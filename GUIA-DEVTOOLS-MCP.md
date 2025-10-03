# 🔧 Guia Completo - Chrome DevTools MCP

## ✅ Status da Instalação

- [x] Pacote `chrome-devtools-mcp` instalado globalmente
- [x] Arquivo de configuração criado em `%APPDATA%\Claude\claude_desktop_config.json`
- [x] Script de inicialização do Chrome criado

---

## 📋 Passos para Ativar

### 1️⃣ **Iniciar Chrome com Remote Debugging**

Execute o script PowerShell:

```powershell
cd C:\Projetos\NewMDF-e
.\iniciar-chrome-debug.ps1
```

Isso vai:
- ✅ Fechar instâncias existentes do Chrome
- ✅ Iniciar Chrome na porta 9222 com debugging habilitado
- ✅ Abrir automaticamente http://localhost:3000

### 2️⃣ **Reiniciar o Claude Desktop**

**IMPORTANTE:** Você DEVE fechar completamente e reabrir o Claude Desktop para que as ferramentas MCP sejam carregadas.

1. Feche o Claude Desktop (Arquivo → Sair ou Alt+F4)
2. Abra novamente o Claude Desktop
3. As ferramentas DevTools estarão disponíveis

### 3️⃣ **Verificar Conexão**

Após reiniciar o Claude, você verá no console que as ferramentas MCP estão conectadas.

As seguintes ferramentas estarão disponíveis:
- `mcp__chrome-devtools__navigate_page` - Navegar para uma URL
- `mcp__chrome-devtools__click` - Clicar em elementos
- `mcp__chrome-devtools__wait_for` - Aguardar elementos
- `mcp__chrome-devtools__evaluate_script` - Executar JavaScript
- `mcp__chrome-devtools__take_snapshot` - Capturar screenshots

---

## 🎯 Como Usar para Diagnosticar o Problema

Após configurar, o Claude poderá:

1. **Navegar** para a página do MDF-e
2. **Inspecionar** os dados carregados
3. **Executar scripts** para verificar o código IBGE
4. **Capturar** evidências visuais do problema

---

## 🔍 Arquivo de Configuração Criado

Localização: `C:\Users\Irrigação\AppData\Roaming\Claude\claude_desktop_config.json`

Conteúdo:
```json
{
  "mcpServers": {
    "chrome-devtools": {
      "command": "npx",
      "args": ["-y", "chrome-devtools-mcp"]
    }
  }
}
```

---

## ⚠️ Troubleshooting

### Problema: Ferramentas MCP não aparecem após reiniciar

**Solução:**
1. Verifique se o Chrome foi iniciado com o script
2. Verifique se está rodando na porta 9222:
   ```powershell
   netstat -ano | findstr :9222
   ```
3. Acesse http://localhost:9222 no navegador - deve mostrar a interface de debug

### Problema: Chrome não abre

**Solução:**
1. Verifique se o caminho do Chrome está correto no script
2. Tente executar manualmente:
   ```powershell
   & "C:\Program Files\Google\Chrome\Application\chrome.exe" --remote-debugging-port=9222 http://localhost:3000
   ```

---

## 📝 Próximos Passos

Após configurar:

1. ✅ Execute: `.\iniciar-chrome-debug.ps1`
2. ✅ Reinicie o Claude Desktop
3. ✅ Volte para esta conversa
4. ✅ Claude poderá usar DevTools para diagnosticar o problema

---

## 🚀 Comando Rápido (Copie e Cole)

```powershell
# Passo 1: Iniciar Chrome
cd C:\Projetos\NewMDF-e
.\iniciar-chrome-debug.ps1

# Passo 2: Reiniciar Claude Desktop (faça manualmente)

# Passo 3: Voltar para a conversa e testar
```

---

**Configuração completa! Agora siga os passos acima.** ✅
