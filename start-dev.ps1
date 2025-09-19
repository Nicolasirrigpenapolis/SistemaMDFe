# Script para iniciar API e Frontend simultaneamente

Write-Host "🚀 Iniciando ambiente de desenvolvimento..." -ForegroundColor Green

# Verificar se estamos no diretório correto
if (-not (Test-Path "MDFe.Api")) {
    Write-Error "Execute este script na raiz do projeto MDF-e"
    exit 1
}

# Iniciar a API em segundo plano
Write-Host "📡 Iniciando API..." -ForegroundColor Yellow
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd 'C:\Projetos\MDF-e\MDFe.Api'; dotnet run"

# Aguardar um pouco para a API inicializar
Start-Sleep -Seconds 3

# Iniciar o Frontend
Write-Host "🌐 Iniciando Frontend..." -ForegroundColor Yellow
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd 'C:\Projetos\MDF-e\frontend'; npm start"

Write-Host "✅ Ambiente iniciado!" -ForegroundColor Green
Write-Host "📱 Frontend: http://localhost:3000" -ForegroundColor Cyan
Write-Host "🔧 API: https://localhost:5000" -ForegroundColor Cyan
Write-Host "📚 Swagger: https://localhost:5000/swagger" -ForegroundColor Cyan