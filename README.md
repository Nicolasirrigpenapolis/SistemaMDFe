# 🚛 Sistema MDF-e

Sistema completo para emissão e gerenciamento de Manifesto Eletrônico de Documentos Fiscais (MDF-e) utilizando ACBr, com interface web moderna e sistema de autenticação.

## 🏗️ Arquitetura

- **Backend**: .NET 8 API com Entity Framework Core + ACBr Integration
- **Frontend**: React 18 com TypeScript, Material-UI e Context API
- **Autenticação**: JWT com refresh tokens e proteção de rotas
- **Integração**: ACBr MDFe para comunicação com SEFAZ
- **Banco de Dados**: SQL Server Express com Entity Framework migrations
- **UI/UX**: Design responsivo com dark mode e animações modernas

## 📁 Estrutura do Projeto

```
NewMDF-e/
├── MDFe.Api/                    # 🔧 Backend .NET API
│   ├── Controllers/             # API Controllers (Emitentes, MDFe, Auth, etc.)
│   ├── Models/                  # Modelos de dados Entity Framework
│   ├── Services/                # Serviços de negócio e integração ACBr
│   ├── Data/                    # DbContext e configurações do banco
│   ├── DTOs/                    # Data Transfer Objects para API
│   ├── Migrations/              # Migrações do Entity Framework
│   └── Infrastructure/          # Configurações e injeção de dependência
├── frontend/                    # ⚛️ Frontend React TypeScript
│   ├── src/
│   │   ├── components/          # Componentes reutilizáveis
│   │   │   ├── Layout/          # Header, Sidebar, MainLayout
│   │   │   ├── UI/              # Componentes de interface
│   │   │   └── Auth/            # Componentes de autenticação
│   │   ├── pages/               # Páginas da aplicação
│   │   │   ├── Auth/            # Login e autenticação
│   │   │   ├── Dashboard/       # Painel principal
│   │   │   ├── MDFe/            # Gestão de MDFe
│   │   │   ├── Emitentes/       # Gestão de emitentes
│   │   │   └── Admin/           # Administração do sistema
│   │   ├── contexts/            # React Contexts (Auth, Theme)
│   │   ├── services/            # Serviços de API e autenticação
│   │   ├── hooks/               # Custom React hooks
│   │   ├── types/               # Definições TypeScript
│   │   └── routes/              # Configuração de rotas
├── ACBrLibMDFe-Windows-*/       # 📚 Biblioteca ACBr MDFe
├── certificados/                # 🔐 Certificados digitais A1/A3
├── docs/                        # 📖 Documentação e scripts
├── CLAUDE.md                    # 🤖 Instruções para Claude
└── README.md                    # 📋 Este arquivo
```

## 🚀 Execução

### Desenvolvimento

1. **Inicie o backend e frontend:**
   ```cmd
   start-dev.cmd
   ```

2. **Ou manualmente:**
   ```cmd
   # Backend
   cd MDFe.Api
   dotnet run

   # Frontend (em outro terminal)
   cd frontend
   npm start
   ```

### URLs

- **Backend API**: http://localhost:5000
- **Frontend**: http://localhost:3000

## ⚙️ Configuração

1. Configure a string de conexão no `appsettings.json`
2. Coloque o certificado digital em `certificados/`
3. Configure as credenciais no arquivo `.env`

## 📋 Funcionalidades Implementadas

### 🔐 **FASE 5: Sistema de Autenticação** ✅
- Sistema completo de login/logout com JWT
- Proteção de rotas autenticadas
- Gestão de usuários e permissões
- Monitoramento de expiração de sessão
- Interface moderna de login com validação

### 🏢 **Gestão de Entidades** ✅
- **Emitentes**: Cadastro de empresas emissoras
- **Veículos**: Gestão de frota e dados ANTT
- **Condutores**: Cadastro de motoristas e CNH
- **Contratantes**: Empresas contratantes do transporte
- **Seguradoras**: Dados de seguros de carga
- **Municípios**: Base completa de municípios IBGE

### 📄 **Sistema MDFe** ✅
- Formulário inteligente com wizard multi-etapas
- Emissão de MDFe com validação automática
- Gestão de carregamento e descarregamento
- Anexação de CTe e NFe automatizada
- Cálculos automáticos de peso e valor
- Consulta e listagem de manifestos

### 🎨 **Interface e UX** ✅
- Design responsivo com dark mode
- Sidebar colapsível e navegação intuitiva
- Componentes reutilizáveis e modularizados
- Feedback visual e loading states
- Validação em tempo real nos formulários
- Sistema de notificações e alertas

### 🔧 **Infraestrutura** ✅
- API REST com ASP.NET Core 8
- Entity Framework com migrações automáticas
- Integração completa com ACBr MDFe
- Sistema de configuração flexível
- Scripts de automação para desenvolvimento

## 🚀 **Próximas Fases** (Roadmap)

### 📡 **FASE 6: Integração SEFAZ**
- Transmissão real para SEFAZ
- Consulta de status e retornos
- Processamento de eventos
- Cancelamento e encerramento

### 📊 **FASE 7: Relatórios e Analytics**
- Dashboard com métricas
- Relatórios de produtividade
- Exportação de dados
- Gráficos e indicadores

### 🔄 **FASE 8: Automação**
- Importação em lote
- Processamento automático
- Integração com ERPs
- API para terceiros

## 🔧 Tecnologias

### Backend
- **.NET 8** - Framework principal
- **Entity Framework Core** - ORM e migrations
- **ASP.NET Core Identity** - Autenticação e autorização
- **JWT Bearer** - Tokens de autenticação
- **ACBr MDFe** - Integração com SEFAZ
- **SQL Server Express** - Banco de dados

### Frontend
- **React 18** - Library principal
- **TypeScript** - Tipagem estática
- **Material-UI (MUI)** - Componentes de interface
- **React Router** - Roteamento e navegação
- **Context API** - Gerenciamento de estado
- **CSS Modules** - Estilização modularizada

### DevOps e Ferramentas
- **Entity Framework Migrations** - Versionamento do banco
- **PowerShell Scripts** - Automação de tarefas
- **Git** - Controle de versão
- **Claude Code** - Assistência de desenvolvimento

## 📄 Documentação Adicional

- **CLAUDE.md** - Instruções específicas para Claude
- **docs/ARQUIVOS.md** - Documentação detalhada de cada arquivo
- Pasta `docs/` - Scripts e documentação técnica