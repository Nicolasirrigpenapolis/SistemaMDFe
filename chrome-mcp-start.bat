@echo off
echo ==========================================
echo   INICIANDO CHROME DEVTOOLS MCP SERVER
echo ==========================================
echo.
echo Configurando ambiente para teste automatico do MDFe...
echo.

REM Inicia o MCP server em background
start "Chrome DevTools MCP" npx chrome-devtools-mcp@latest --channel stable --logFile chrome-devtools-mcp.log

echo.
echo ✅ MCP Server iniciado!
echo 📋 Logs sendo salvos em: chrome-devtools-mcp.log
echo 🌐 Pronto para automação do MDFe
echo.
echo Para usar no Claude Code, configure o MCP com:
echo   Arquivo: claude-mcp-config.json
echo.
pause