# 🔒 Configuração de Segurança - Sistema MDF-e

## 📋 Configuração para Desenvolvimento

Para configurar o ambiente de desenvolvimento com dados sensíveis:

### 1. Criar arquivo de configuração local

Copie o arquivo de exemplo e configure com seus dados:

```bash
cp MDFe.Api/appsettings.Local.example.json MDFe.Api/appsettings.Local.json
```

### 2. Configurar dados sensíveis no appsettings.Local.json

```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Server=SEU_SERVIDOR;Database=MDFeSystem;Trusted_Connection=true;TrustServerCertificate=true;MultipleActiveResultSets=true;Connection Timeout=60;Command Timeout=120;"
  },
  "JwtSettings": {
    "SecretKey": "SUA_CHAVE_JWT_SUPER_SECRETA_AQUI"
  }
}
```

### 3. Variáveis de Ambiente para Produção

Em produção, configure as seguintes variáveis de ambiente:

```
ConnectionStrings__DefaultConnection=sua_connection_string_production
JwtSettings__SecretKey=sua_chave_jwt_production
JwtSettings__Issuer=MDFeApi
JwtSettings__Audience=MDFeClient
```

## 🚨 Importante

- **NUNCA** commite arquivos com dados sensíveis
- **SEMPRE** use variáveis de ambiente em produção
- O arquivo `appsettings.Local.json` está no .gitignore
- Use `appsettings.Production.json` como template para produção

## 🔧 Configuração do programa

O Program.cs está configurado para:
1. Carregar appsettings.json (configurações base)
2. Carregar appsettings.Local.json (se existir, apenas desenvolvimento)
3. Carregar variáveis de ambiente (produção)

### Ordem de precedência:
1. Variáveis de ambiente (maior precedência)
2. appsettings.Local.json
3. appsettings.json (menor precedência)