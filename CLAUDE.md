# Instruções para Claude

## Comandos de desenvolvimento

- NUNCA executar `npm start` ou comandos que iniciem servidores de desenvolvimento
- O usuário prefere executar os projetos manualmente
- Ao testar correções, apenas indicar que o código foi corrigido, mas não executar

## Estrutura do projeto

- Frontend React: `frontend/`
- Backend C#/.NET: `MDFe.Api/`
- Para executar: `npm start` (frontend) e executar a API pelo Visual Studio ou dotnet run

## Comandos seguros para usar

- `npm install` - OK
- `dotnet build` - OK
- `dotnet clean` - OK
- Comandos de linting/typecheck - OK
- Comandos de teste - OK

## Comandos a EVITAR

- `npm start`
- `dotnet run` (a menos que seja explicitamente solicitado)
- Qualquer comando que inicie servidores

## Regras de UX/UI para Interface do MDFe

### 1. Design Profissional e Moderno
- Interface deve ser profissional e adequada para emissão de documento fiscal
- Evitar designs "problemáticos" que dificultam manutenção de persistência de dados
- Focar em clareza e funcionalidade

### 2. Campos Opcionais
- **NUNCA** mostrar campos opcionais por padrão no frontend
- Campos opcionais só aparecem SE o usuário marcar/clicar para exibi-los
- Implementar sistema de toggle para campos opcionais
- Evitar poluição visual com campos desnecessários

### 3. Lógica Inteligente do Sistema
- **NÃO** perguntar informações óbvias ao usuário
- Exemplos do que **NÃO** fazer:
  - Se usuário adiciona CTe/NFe, NÃO perguntar "quantos documentos você adicionou"
  - Se está emitindo UM MDFe, NÃO perguntar "quantos MDFe vai emitir"
- Sistema deve calcular automaticamente:
  - Quantidade de documentos (baseado no que foi adicionado)
  - Totais de carga (baseado nos documentos)
  - Valores (soma automática dos documentos)

### 4. Regras de Desenvolvimento
- **MODIFICAR** arquivos existentes ao invés de criar novos
- Evitar criação excessiva de arquivos
- Manter código organizado nos componentes já existentes
- Priorizar manutenibilidade do código

### 5. Auto-cálculos Inteligentes
- Quantidade de CTe: calculado automaticamente
- Quantidade de NFe: calculado automaticamente
- Quantidade de MDFe: sempre 1 (óbvio)
- Peso total: soma dos documentos
- Valor total: soma dos valores dos documentos

### 6. Padronização de Unidades de Medida
- **APENAS QUILOGRAMA (kg)**: Sistema padronizado para usar exclusivamente quilograma
- Código SEFAZ fixo: '01' = Quilograma
- Todas as outras unidades (tonelada, litro, etc.) foram removidas para simplificar o sistema
- Interface mostra "Quilograma (kg)" como padrão fixo do sistema

## Configuração de ambiente

### Variáveis de ambiente para Claude
Para configurar o Claude corretamente, execute:
```powershell
.\setup-environment.ps1
```

### Scripts de banco de dados
Para operações de banco de dados, use:
```powershell
.\scripts-db.ps1 [comando]
```

Comandos disponíveis:
- `check` - Verifica SQL Server e conexão
- `migrate` - Aplica migrações pendentes
- `add-migration <nome>` - Cria nova migração
- `status` - Mostra status das migrações
- `reset-db` - Recria o banco (cuidado!)

### Banco de dados
- SQL Server Express: `localhost\SQLEXPRESS`
- Database: `MDFeSystem`
- Connection string no appsettings.json