# 📁 Documentação de Arquivos e Componentes

Este documento detalha a função de cada arquivo e componente do sistema MDFe.

## 🔧 Backend (.NET API) - `MDFe.Api/`

### 📡 Controllers - `Controllers/`

| Arquivo | Função | Principais Endpoints |
|---------|--------|---------------------|
| **AuthController.cs** | Autenticação e registro de usuários | `POST /auth/login`, `POST /auth/register` |
| **EmitentesController.cs** | CRUD de empresas emissoras | `GET /emitentes`, `POST /emitentes`, `PUT /emitentes/{id}` |
| **VeiculosController.cs** | Gestão de veículos da frota | `GET /veiculos`, `POST /veiculos`, `DELETE /veiculos/{id}` |
| **CondutoresController.cs** | Cadastro de motoristas | `GET /condutores`, `POST /condutores`, `PUT /condutores/{id}` |
| **ContratantesController.cs** | Empresas contratantes | `GET /contratantes`, `POST /contratantes` |
| **SeguradorasController.cs** | Cadastro de seguradoras | `GET /seguradoras`, `POST /seguradoras` |
| **MunicipiosController.cs** | Base de municípios IBGE | `GET /municipios`, `POST /municipios/importar-ibge` |
| **MDFeController.cs** | Emissão e gestão de MDFe | `POST /mdfe/emitir`, `GET /mdfe/{id}`, `PUT /mdfe/{id}/cancelar` |

### 🗄️ Models - `Models/`

| Arquivo | Função | Relacionamentos |
|---------|--------|----------------|
| **ApplicationUser.cs** | Modelo de usuário do sistema | Identity User extendido |
| **Emitente.cs** | Dados da empresa emissora | → MDFe (1:N) |
| **Veiculo.cs** | Informações do veículo | → MDFe (N:N), → Reboque (1:N) |
| **Condutor.cs** | Dados do motorista | → MDFe (N:N) |
| **Contratante.cs** | Empresa contratante | → MDFe (1:N) |
| **Seguradora.cs** | Dados da seguradora | → MDFe (1:N) |
| **Municipio.cs** | Município IBGE | → LocalCarregamento/Descarregamento |
| **MDFe.cs** | Manifesto eletrônico principal | Relaciona todas as entidades |
| **InfMunCarrega.cs** | Local de carregamento | MDFe → Municipio |
| **InfMunDescarrega.cs** | Local de descarregamento | MDFe → Municipio |
| **InfCTe.cs** | CTe anexado ao MDFe | MDFe (N:N) |
| **InfNFe.cs** | NFe anexada ao MDFe | MDFe (N:N) |

### 🔧 Services - `Services/`

| Arquivo | Função | Responsabilidade |
|---------|--------|-----------------|
| **AcbrService.cs** | Integração com ACBr MDFe | Comunicação com SEFAZ, validação XML |
| **MDFeService.cs** | Lógica de negócio MDFe | Montagem, validação, processamento |
| **EmitentesService.cs** | Regras de negócio emitentes | Validação CNPJ, dados empresariais |
| **AuthService.cs** | Autenticação e JWT | Geração tokens, validação usuários |

### 📊 DTOs - `DTOs/`

| Arquivo | Função | Uso |
|---------|--------|-----|
| **AuthDTOs.cs** | Login, registro, tokens | Request/Response autenticação |
| **MDFeDTOs.cs** | Criação e consulta MDFe | Transfer entre frontend/backend |
| **EntidadesDTOs.cs** | DTOs das entidades | Padronização API responses |

### 🗃️ Data - `Data/`

| Arquivo | Função | Responsabilidade |
|---------|--------|-----------------|
| **ApplicationDbContext.cs** | Contexto Entity Framework | Configuração banco, DbSets |
| **ModelConfigurations/** | Configurações dos modelos | Mapeamento tabelas, relacionamentos |

## ⚛️ Frontend (React) - `frontend/src/`

### 🎯 Pages - `pages/`

#### 🔐 Auth - `pages/Auth/`
| Arquivo | Função | Descrição |
|---------|--------|-----------|
| **Login/Login.tsx** | Página de login | Interface autenticação, validação formulário |
| **Login/Login.module.css** | Estilos da página login | Design responsivo, animações |

#### 📊 Dashboard - `pages/Dashboard/`
| Arquivo | Função | Descrição |
|---------|--------|-----------|
| **Dashboard.tsx** | Painel principal | Métricas, estatísticas, navegação rápida |

#### 📄 MDFe - `pages/MDFe/`
| Arquivo | Função | Descrição |
|---------|--------|-----------|
| **ListarMDFe/ListarMDFe.tsx** | Lista de manifestos | Grid, filtros, paginação |
| **FormularioMDFe/FormularioMDFe.tsx** | Emissão de MDFe | Wizard multi-etapas, validação |
| **DetalhesMDFe/DetalhesMDFe.tsx** | Visualização detalhada | Dados completos, ações disponíveis |

#### 🏢 Entidades - `pages/[Entidade]/`
| Diretório | Função | Padrão |
|-----------|--------|--------|
| **Emitentes/** | Gestão de emitentes | CRUD via modal, validação CNPJ |
| **Veiculos/** | Gestão de veículos | CRUD, dados ANTT, validação placa |
| **Condutores/** | Gestão de condutores | CRUD, dados CNH, validação CPF |
| **Contratantes/** | Gestão de contratantes | CRUD via modal |
| **Seguradoras/** | Gestão de seguradoras | CRUD via modal |
| **Municipios/** | Base de municípios | Listagem, importação IBGE |

#### 👥 Admin - `pages/Admin/`
| Arquivo | Função | Descrição |
|---------|--------|-----------|
| **Usuarios/Usuarios.tsx** | Gestão de usuários | CRUD usuários, controle acesso |

### 🧩 Components - `components/`

#### 🎨 Layout - `components/Layout/`
| Arquivo | Função | Responsabilidade |
|---------|--------|-----------------|
| **MainLayout/MainLayout.tsx** | Layout principal | Wrapper geral, integração auth |
| **Header/Header.tsx** | Cabeçalho do sistema | Navegação, perfil usuário, logout |
| **Sidebar/Sidebar.tsx** | Menu lateral | Navegação entre páginas, ícones |

#### 🔐 Auth - `components/Auth/`
| Arquivo | Função | Responsabilidade |
|---------|--------|-----------------|
| **PrivateRoute.tsx** | Proteção de rotas | Verificação autenticação, redirecionamento |
| **TokenWarning.tsx** | Aviso expiração token | Modal alerta sessão, renovação |

#### 🎛️ UI - `components/UI/`
| Diretório | Função | Componentes |
|-----------|--------|-------------|
| **Forms/** | Formulários complexos | MDFeForm, validações, wizard |
| **Common/** | Componentes reutilizáveis | Buttons, Inputs, Modals |
| **Modal/** | Modais do sistema | Confirmação, CRUD, alertas |
| **Icon.tsx** | Ícones Font Awesome | Padronização ícones, tamanhos |

### 🔗 Context - `contexts/`

| Arquivo | Função | Estado Gerenciado |
|---------|--------|------------------|
| **AuthContext.tsx** | Contexto de autenticação | usuário, token, sessão |
| **ThemeContext.tsx** | Tema dark/light | preferências visuais |

### 🔧 Services - `services/`

| Arquivo | Função | Responsabilidade |
|---------|--------|-----------------|
| **authService.ts** | Serviço de autenticação | Login, logout, JWT, validações |
| **api.ts** | Cliente HTTP | Requisições padronizadas, interceptors |

### 🪝 Hooks - `hooks/`

| Arquivo | Função | Retorno |
|---------|--------|---------|
| **useTokenMonitor.ts** | Monitoramento token | status expiração, alertas |
| **useMDFeForm.ts** | Estado formulário MDFe | dados, validações, seleções |

### 🔀 Routes - `routes/`

| Arquivo | Função | Configuração |
|---------|--------|-------------|
| **AppRoutes.tsx** | Roteamento principal | Rotas públicas/privadas, proteção |

### 📝 Types - `types/`

| Arquivo | Função | Definições |
|---------|--------|-----------|
| **mdfe.ts** | Tipos MDFe | Interfaces dados formulário |
| **auth.ts** | Tipos autenticação | User, tokens, requests |

## 📄 Arquivos de Configuração

### Root - `NewMDF-e/`

| Arquivo | Função | Conteúdo |
|---------|--------|-----------|
| **README.md** | Documentação principal | Visão geral, arquitetura, setup |
| **CLAUDE.md** | Instruções Claude | Regras desenvolvimento, comandos |

### Backend - `MDFe.Api/`

| Arquivo | Função | Configuração |
|---------|--------|-------------|
| **appsettings.json** | Configurações API | Connection strings, JWT settings |
| **Program.cs** | Startup da aplicação | Services, middleware, pipeline |
| **MDFe.Api.csproj** | Projeto .NET | Dependências, target framework |

### Frontend - `frontend/`

| Arquivo | Função | Configuração |
|---------|--------|-------------|
| **package.json** | Dependências Node | Scripts, libraries React |
| **tsconfig.json** | Configuração TypeScript | Compiler options, paths |
| **tailwind.config.js** | Configuração Tailwind | Theme, plugins, customizações |

## 🗂️ Pasta docs/ - Documentação

| Arquivo | Função | Conteúdo |
|---------|--------|-----------|
| **ARQUIVOS.md** | Este documento | Mapeamento completo sistema |
| **scripts-db.ps1** | Scripts banco dados | Migrações, reset, status |
| **setup-environment.ps1** | Setup ambiente | Configuração inicial desenvolvimento |

## 🔄 Fluxo de Dados

### 1. **Autenticação**
```
Login.tsx → authService.ts → AuthController.cs → JWT → AuthContext.tsx → PrivateRoute.tsx
```

### 2. **Emissão MDFe**
```
FormularioMDFe.tsx → useMDFeForm.ts → MDFeController.cs → AcbrService.cs → SEFAZ
```

### 3. **CRUD Entidades**
```
[Entidade]Lista.tsx → api.ts → [Entidade]Controller.cs → [Entidade]Service.cs → DbContext
```

### 4. **Layout e Navegação**
```
App.tsx → MainLayout.tsx → Header.tsx + Sidebar.tsx → AppRoutes.tsx → Pages
```

## 📋 Padrões Utilizados

- **Repository Pattern**: Controllers → Services → DbContext
- **DTO Pattern**: Separação dados API e modelos internos
- **Context Pattern**: Estado global React (Auth, Theme)
- **Component Pattern**: Componentes reutilizáveis e modulares
- **Hook Pattern**: Lógica compartilhada React
- **Module CSS**: Estilos encapsulados por componente