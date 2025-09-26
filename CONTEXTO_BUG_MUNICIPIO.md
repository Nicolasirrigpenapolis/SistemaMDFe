# 🐛 BUG: Município de Descarga não aparece no Resumo

## 📋 Resumo do Problema

**SINTOMA:** No resumo do MDFe, aparece:
- "Município de Descarga não informado"
- "Código do município não informado"

**CAUSA IDENTIFICADA:** Os campos `xMunDescarga`, `uf` e `cMunDescarga` estão vazios na estrutura `dados.infDoc.infMunDescarga`.

## 🔍 Debug Atual

**Estado dos dados:**
```
DEBUG: xMun="" uf="" cMun=""
```

**Estado do locaisDescarregamento:**
```json
[{
  "id": "descarregamento_1758817377120",
  "municipio": "Ituiutaba",
  "uf": "MG",
  "codigoIBGE": 3134202
}]
```

## ✅ O que já foi corrigido

1. **Função `salvarLocaisDescarregamento`** - ✅ Funcionando corretamente
2. **Função `addCTe`** - ✅ Corrigida para usar dados do state `locaisDescarregamento`
3. **Função `addNFe`** - ✅ Corrigida para usar dados do state `locaisDescarregamento`
4. **Formato código município** - ✅ Corrigido para 7 dígitos com `.padStart(7, '0')`

## ❌ Problema Restante

Mesmo com as correções, os dados ainda chegam vazios no resumo.

**HIPÓTESE:** Existe uma **outra função** que está sobrescrevendo os dados após `addCTe/addNFe` serem executadas.

## 🎯 Próximos Passos

1. **Identificar** que função está zerando os dados
2. **Corrigir** essa função para preservar os dados do município
3. **Testar** no resumo
4. **Remover** debugs temporários

## 📝 Arquivos Modificados

- `C:\Projetos\NewMDF-e\frontend\src\components\UI\Forms\MDFeWizardNovo.tsx`
  - Funções corrigidas: `addCTe` (linha ~540), `addNFe` (linha ~590)
  - Debug adicionado no resumo (linha ~2380)