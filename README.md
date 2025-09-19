# Sistema MDF-e

Sistema para emissão e gerenciamento de Manifesto Eletrônico de Documentos Fiscais (MDF-e) utilizando ACBr.

## 🏗️ Arquitetura

- **Backend**: .NET 8 API com Entity Framework Core
- **Frontend**: React com TypeScript
- **Integração**: ACBr MDFe para comunicação com SEFAZ
- **Banco**: SQL Server/SQLite

## 📁 Estrutura do Projeto

```
MDF-e/
├── MDFe.Api/                    # Backend .NET API
│   ├── Controllers/             # Controllers da API
│   ├── Models/                  # Modelos de dados
│   ├── Services/                # Serviços de negócio
│   ├── Data/                    # Contexto do banco
│   └── DTOs/                    # Data Transfer Objects
├── frontend/                    # Frontend React
├── ACBrLibMDFe-Windows-*/       # Biblioteca ACBr MDFe
├── certificados/                # Certificados digitais
├── docs/                        # Documentação e scripts
└── start-dev.cmd               # Script de inicialização
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

## 📋 Funcionalidades

- ✅ Cadastro de empresas, veículos e condutores
- ✅ Emissão de MDF-e
- ✅ Consulta de status
- ✅ Cancelamento e encerramento
- ✅ Interface web completa

## 🔧 Tecnologias

- .NET 8, Entity Framework Core
- React, TypeScript, Material-UI
- ACBr MDFe Library
- SQL Server

## 📄 Documentação

Veja a pasta `docs/` para documentação adicional e scripts de banco de dados.