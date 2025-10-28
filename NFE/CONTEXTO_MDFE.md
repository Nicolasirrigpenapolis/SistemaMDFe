# CONTEXTO MDF-e (Implementação VB6 + MDFe_Util)

Este documento serve como referência rápida para manter, revisar ou reverter a implementação atual do MDF-e (layout 3.00) neste projeto VB6.

---
## 1. Objetivo
Fornecer uma emissão de MDF-e mínima (somente campos obrigatórios) para dois cenários:
- Modo Fracionado (padrão): múltiplos documentos ou múltiplos destinatários.
- Modo Carga Lotação: exatamente 1 documento (NF-e ou CT-e) e entrega para um único destinatário (checkbox marcado pelo usuário).

No modo lotação adicionamos apenas os blocos indispensáveis exigidos pela SEFAZ:
- `<prodPred>` com `<tpCarga>`, `<xProd>`, `<NCM>` e `<infLotacao>`
- `<infPag>` (com `<Comp>`, `<vContrato>`, `<indPag>`, `<infBanc>`)

---
## 2. Diferença entre Fracionado x Lotação
| Aspecto | Fracionado | Lotação |
|---------|------------|---------|
| Quantidade de docs (NF-e + CT-e) | ≥ 1 (sem restrição para mais de 1) | Exatamente 1 | 
| Checkbox "único destinatário" | Ignorado | Obrigatório = Marcado |
| `<prodPred>` | Não gerado | Gerado |
| `<NCM>` | Não aparece | Obrigatório (8 dígitos) |
| `<infLotacao>` | Não aparece | Gerado via `infLotacao` (CEPs) |
| `<infPag>` | Não gerado | Gerado dinamicamente |
| Captura NCM/frete | Não ocorre | Via InputBox em tempo de autorização |

Regra de ativação do modo lotação no código:  
```
ehLotacao = (chkUnicoDest.Value = 1 And docsTotal = 1) 'docsTotal = qNFe + qCTe
```

---
## 3. Blocos XML Condicionais
### 3.1 prodPred (lotação)
Montado somente se `ehLotacao = True`.
Estrutura mínima gerada:
```xml
<prodPred>
  <tpCarga>VARIOS</tpCarga>
  <xProd>AGREGADO</xProd>
  <NCM>XXXXXXXX</NCM>
  <infLotacao>...retorno da DLL...</infLotacao>
</prodPred>
```
`<infLotacao>` vem de `objMDFeUtil.infLotacao(cepCar,0,0,cepDes,0,0)` quando CEPS válidos.

### 3.2 infPag (lotação)
Injetado dentro ou antes do fechamento do bloco `<infANTT>` se não existir.
```xml
<infPag>
  <xNome>...</xNome>
  <CNPJ>...</CNPJ>
  <Comp>
    <tpComp>99</tpComp>
    <vComp>999.99</vComp>
    <xComp>FRETE</xComp>
  </Comp>
  <vContrato>999.99</vContrato>
  <indPag>0</indPag>
  <infBanc>
    <codBanco>001</codBanco>
    <codAgencia>0001</codAgencia>
  </infBanc>
</infPag>
```
Os valores `codBanco` e `codAgencia` estão fixos (pode-se parametrizar depois).

---
## 4. Captura Dinâmica (InputBox)
Removidos os TextBoxes de tela (`txtNCM`, `txtValorFrete`). Agora:
1. Usuário marca o checkbox (lotação) e aciona autorização.
2. Sistema pergunta NCM: até 3 tentativas (8 dígitos numéricos). Cancelar em branco → opção de abortar.
3. Sistema pergunta valor do frete: até 3 tentativas (> 0). Cancelar em branco → opção de abortar.
4. Falha após 3 tentativas → emissão abortada.
5. Sucesso → gera `prodPred` + `infPag` + injeta no XML final.

Formatação do valor: `Format$(valorFreteUsuario, "0.00")` para padrão decimal com ponto (compatível com schema).

---
## 5. Erros SEFAZ tratáveis / histórico
| Código | Causa Original | Solução Implementada |
|--------|----------------|----------------------|
| 5203 | UF de retorno ausente/ambígua | Ajuste/fallback ao capturar UF no retorno (parse manual) |
| 5505 | `<infPag>` incompleto (faltava `<infBanc>`) | Inclusão de `<infBanc>` mínimo |
| 725 | Ausência de `<prodPred>` em lotação | Geração condicional do bloco |
| 686 | MDF-e antigo não encerrado > 30 dias | Encerrar MDF-e(s) pendentes (evento 110112) |

---
## 6. Evento de Encerramento (686)
A rejeição 686 não vem do código local. É exigência SEFAZ: encerrar MDF-e autorizados com mais de 30 dias. Solução: enviar evento 110112 com chave, protocolo, UF e município final. Depois disso novas autorizações liberam.

---
## 7. Pontos Chave no Código (`mdfe.txt`)
- Condição lotação: variável `ehLotacao` baseada em checkbox + contagem de documentos.
- Construção `prodPred` e injeção de `infPag` ficam próximos à chamada `MDFe_NT2020001`.
- Remoção dos TextBoxes: substituídos por InputBox (NCM e frete).
- Log: appende mensagens em campo `Observação` (infPag inserido / prodPred inserido).

---
## 8. Reversão Rápida
Se precisar voltar ao modo antigo (sem lotação dinâmica):
1. Comentar a lógica de captura de NCM/frete e geração de `prodPred` e `infPag` condicionais.
2. Remover referência a `chkUnicoDest` na condição `ehLotacao` (ou forçar `ehLotacao = False`).
3. (Opcional) Restaurar TextBoxes (recuperar do histórico git ou backup prévio se existir).

---
## 9. Troubleshooting Rápido
| Sintoma | Ação |
|---------|------|
| Rejeição 725 | Verificar se checkbox marcado + exatamente 1 doc + NCM válido | 
| Rejeição 5505 | Conferir se `<infBanc>` está presente dentro de `<infPag>` | 
| Rejeição 686 | Encerrar MDF-e anteriores (evento 110112) | 
| NCM inválido | Confirmar 8 dígitos numéricos; usuário cancelou? | 
| Frete <= 0 | Repetir InputBox; validar formatação | 
| `<infLotacao>` ausente | Checar CEPs de carregamento/descarregamento (8 dígitos) | 

---
## 10. Melhorias Futuras (opcionais)
- Função robusta de parse numérico (tratar 3.500,33 / 3,500.33).
- Parametrizar `codBanco` / `codAgencia` em tabela/config.
- Escape XML para campos livres (ex.: `xProd`, `xNome`).
- Pré-checagem automática de MDF-e não encerrados antes de autorizar.
- Log estruturado (ex: JSON em arquivo separado) para auditoria.

---
## 11. Checklist de Emissão (Operacional)
1. Conferir se não há pendente > 30 dias (encerrar se houver).
2. Marcar checkbox se for 1 doc / 1 destinatário (lotação).
3. Autorizar → informar NCM e frete quando solicitado.
4. Validar retorno (cStat=100) e armazenar protocolo.
5. Após término real da viagem → enviar encerramento.

---
## 12. Glossário Resumido
- MDF-e: Manifesto Eletrônico de Documentos Fiscais (modelo 58).
- prodPred: Bloco descrevendo produto predominante (lotação).
- infPag: Informações de pagamento do frete no MDF-e 3.00.
- infLotacao: Bloco que caracteriza carga lotação (CEP origem/destino, etc.).
- Evento 110112: Encerramento de MDF-e.

---
## 13. Manutenção Rápida
Se a SEFAZ alterar schema (nova NT):
1. Verificar versão da DLL `MDFe_Util` e se há novo método (ex.: `MDFe_NT20xxxxxx`).
2. Ajustar chamada principal (atualmente `MDFe_NT2020001`).
3. Validar novos campos obrigatórios comparando com reject codes recentes.

---
## 14. Referências Úteis
- XSDs base (3.00): `mdfe_v3.00.xsd`, `mdfeModalRodoviario_v3.00.xsd`, `mdfeTiposBasico_v3.00.xsd`.
- Rejeições: consultar tabela oficial de códigos MDF-e.
- Evento Encerramento: NTs relacionadas (ver notas técnicas vigentes).

---
## 15. Contato / Histórico
Documento gerado para consolidar ajustes feitos (checkbox de lotação, captura dinâmica de NCM e frete, correção de rejeições 5505/725, orientação rejeição 686). Manter este arquivo versionado.

---
## 16. Como Atualizar Este Documento
- Adicionar novas seções ao final ou atualizar tabelas mantendo data da mudança.
- Registrar mudanças significativas (ex.: mudança de regra de lotação) em um changelog simples.

---
Última atualização: (preencher data manualmente ao alterar)
