# ============================================
# 🌐 INICIAR CHROME COM REMOTE DEBUGGING
# ============================================

Write-Host "🌐 Iniciando Chrome com Remote Debugging..." -ForegroundColor Cyan

# Fechar todas as instâncias do Chrome
Write-Host "Fechando instâncias existentes do Chrome..." -ForegroundColor Yellow
Get-Process chrome -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 2

# Iniciar Chrome com debugging
$chromePath = "C:\Program Files\Google\Chrome\Application\chrome.exe"
$debugPort = 9222
$userDataDir = "$env:TEMP\chrome-debug-profile"

# Criar diretório de perfil se não existir
if (-not (Test-Path $userDataDir)) {
    New-Item -ItemType Directory -Path $userDataDir -Force | Out-Null
}

Write-Host "Iniciando Chrome na porta $debugPort..." -ForegroundColor Green
Write-Host "URL: http://localhost:3000" -ForegroundColor Cyan

Start-Process -FilePath $chromePath -ArgumentList @(
    "--remote-debugging-port=$debugPort",
    "--user-data-dir=$userDataDir",
    "http://localhost:3000"
)

Write-Host ""
Write-Host "✅ Chrome iniciado com sucesso!" -ForegroundColor Green
Write-Host "📌 Remote Debugging Port: $debugPort" -ForegroundColor White
Write-Host "📌 Debug URL: http://localhost:$debugPort" -ForegroundColor White
Write-Host ""
Write-Host "💡 Agora você precisa:" -ForegroundColor Yellow
Write-Host "   1. Reiniciar o Claude Desktop" -ForegroundColor White
Write-Host "   2. As ferramentas DevTools estarão disponíveis" -ForegroundColor White
Write-Host ""
