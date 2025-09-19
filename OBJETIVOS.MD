
# ✅ CHECKLIST COMPLETO — SISTEMA MDF-e

**Projeto:** SistemaMDFe  
**Repositório:** https://github.com/Nicolasirrigpenapolis/SistemaMDFe.git  
**Frontend:** React + TypeScript + CSS  
**Backend:** ASP.NET  
**Biblioteca de emissão:** ACBrLibMDFe-Windows-1.2.2.337  

> Objetivo: Garantir que o sistema de emissão de MDF-e funcione corretamente, siga boas práticas, esteja alinhado entre frontend e backend e use a biblioteca ACBr de forma correta. Todas as alterações devem ser commitadas e enviadas para a branch `main` a cada etapa concluída.

## ⚙️ 0 — Inicialização do Git e projeto
- [ ] Criar o repositório local:
  ```bash
  cd <pasta-do-projeto>
  git init
  ```
- [ ] Adicionar todos os arquivos:
  ```bash
  git add .
  ```
- [ ] Criar commit inicial:
  ```bash
  git commit -m "Commit inicial: estrutura do projeto MDF-e"
  ```
- [ ] Criar branch `main` (se não existir):
  ```bash
  git branch -M main
  ```
- [ ] Conectar ao repositório remoto no GitHub:
  ```bash
  git remote add origin https://github.com/Nicolasirrigpenapolis/SistemaMDFe.git
  ```
- [ ] Enviar commit inicial para o GitHub:
  ```bash
  git push -u origin main
  ```
- [ ] Configurar `.gitignore`
- [ ] Fazer backup do banco de dados atual
- [ ] Registrar a versão atual do sistema

## 🧹 1 — Limpeza do projeto
- [ ] Remover arquivos, componentes e estilos não utilizados
- [ ] Atualizar dependências no `package.json` e `.csproj`
- [ ] Garantir que o build funcione sem warnings
- [ ] Commit e push:
  ```bash
  git add .
  git commit -m "Limpeza do projeto: remoção de arquivos e dependências obsoletas"
  git push origin main
  ```

## 🎨 2 — Padronização visual de listagens e modais
- [ ] Criar ou seguir guia de estilos: cores, fontes, espaçamentos, botões, estados
- [ ] Aplicar o mesmo padrão em todas as listagens e modais
- [ ] Implementar suporte a tema escuro
- [ ] Commit e push:
  ```bash
  git add .
  git commit -m "Padronização visual: listas e modais com tema escuro"
  git push origin main
  ```

## 🧠 3 — Formulário de MDF-e (UX e auto-preenchimento)
- [ ] Organizar o formulário em seções: Emitente, Informante, Veículo, Trajeto, Carga, Documentos vinculados
- [ ] Tornar o formulário moderno e profissional
- [ ] Implementar auto-preenchimento com cadastros existentes (veículo, emitente, motorista etc.)
- [ ] Evitar digitação manual redundante
- [ ] Commit e push:
  ```bash
  git add .
  git commit -m "Formulário MDF-e moderno e auto-preenchimento implementado"
  git push origin main
  ```

## 🔁 4 — Alinhamento frontend ↔ backend
- [ ] Garantir que DTOs e Controllers usam os mesmos nomes e tipos dos Models
- [ ] Atualizar/gerar documentação de endpoints (Swagger/OpenAPI)
- [ ] Testar comunicação completa frontend ↔ backend
- [ ] Commit e push:
  ```bash
  git add .
  git commit -m "Alinhamento frontend/backend: DTOs, Controllers e Models"
  git push origin main
  ```

## 🧩 5 — Validação de mapeamento
- [ ] Conferir compatibilidade entre Models, DTOs e Controllers
- [ ] Implementar validações no backend (`[Required]`, formatos, tamanhos)
- [ ] Garantir mensagens de erro amigáveis no frontend
- [ ] Commit e push:
  ```bash
  git add .
  git commit -m "Validação de mapeamento e regras no backend"
  git push origin main
  ```

## 🧱 6 — Persistência de dados e vinculações
- [ ] Salvar IDs vinculados no MDF-e (ex.: VehicleId, EmitenteId)
- [ ] Salvar dados essenciais no MDF-e (placa, RNTRC) para manter histórico
- [ ] Criar/atualizar migrations e scripts SQL
- [ ] Testar alteração de cadastros vinculados para garantir integridade
- [ ] Commit e push:
  ```bash
  git add .
  git commit -m "Persistência e vinculação de dados no MDF-e"
  git push origin main
  ```

## 📚 7 — Comunicação com bibliotecas externas
- [ ] Testar geração de XML, assinatura digital, envio para SEFAZ e geração de PDF
- [ ] Garantir que cadastros alimentam corretamente esses processos
- [ ] Commit e push:
  ```bash
  git add .
  git commit -m "Integração com bibliotecas externas testada"
  git push origin main
  ```

## 🧪 8 — Testes CRUD e em massa
- [ ] Testar insert, update, delete e view de todos os cadastros e MDF-e
- [ ] Executar testes em massa (vários registros)
- [ ] Corrigir eventuais problemas encontrados
- [ ] Commit e push:
  ```bash
  git add .
  git commit -m "Testes CRUD concluídos"
  git push origin main
  ```

## 🔗 9 — Testes ponta a ponta (integração)
- [ ] Executar fluxo completo: selecionar cadastros → gerar MDF-e → salvar rascunho → finalizar → assinar → transmitir
- [ ] Testar casos de erro (certificado inválido, rejeição SEFAZ, etc.)
- [ ] Commit e push:
  ```bash
  git add .
  git commit -m "Testes ponta a ponta realizados"
  git push origin main
  ```

## 💾 10 — Persistência incremental (salvar progresso)
- [ ] Implementar salvamento de rascunho durante o preenchimento do MDF-e
- [ ] Permitir retomar MDF-e em andamento
- [ ] Commit e push:
  ```bash
  git add .
  git commit -m "Persistência incremental implementada"
  git push origin main
  ```

## ⚙️ 11 — Comunicação com bibliotecas nos cadastros
- [ ] Garantir que todos os cadastros estão se comunicando corretamente com as bibliotecas externas
- [ ] Validar se todos os campos obrigatórios estão sendo passados corretamente
- [ ] Commit e push:
  ```bash
  git add .
  git commit -m "Validação da comunicação de cadastros com bibliotecas"
  git push origin main
  ```

## 🧩 12 — Integração completa com ACBrLibMDFe
- [ ] Configurar a biblioteca `ACBrLibMDFe-Windows-1.2.2.337` no projeto
- [ ] Seguir documentação oficial do ACBr e validar cada etapa e verificar se a logica esta totalmente correta e se esta pegando os arquviso certos (dll. schemas , etc)
- [ ] Testar manualmente cada botão/etapa:
  - [ ] GerarINI
  - [ ] GerarXML
  - [ ] Validar
  - [ ] Assinar
  - [ ] Transmitir
  - [ ] Consultar
  - [ ] Cancelar
  - [ ] Finalizar
  - e outras caso tiver.
- [ ] Corrigir qualquer erro encontrado
- [ ] Commit e push:
  ```bash
  git add .
  git commit -m "Integração ACBrLibMDFe concluída e testada"
  git push origin main
  ```

## ✅ 13 — Verificação final completa
- [ ] Revisar todo o sistema
- [ ] Garantir que todos os cadastros, formulários e fluxos de emissão estão funcionando
- [ ] Testes finais completos de emissão MDF-e e resposta SEFAZ
- [ ] Confirmar ausência de erros de console ou exceções no backend
- [ ] Commit final e push:
  ```bash
  git add .
  git commit -m "Sistema MDF-e finalizado e validado"
  git push origin main
  ```
