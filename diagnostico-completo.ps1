# ============================================
# 🔍 DIAGNÓSTICO COMPLETO - CÓDIGO IBGE
# ============================================

Write-Host "🔍 === DIAGNÓSTICO AUTOMÁTICO ===" -ForegroundColor Cyan
Write-Host ""

$API_URL = "https://localhost:5001/api"

# 1. Testar API de Diagnóstico
Write-Host "📊 1. Executando diagnóstico no backend..." -ForegroundColor Yellow
try {
    $response = Invoke-RestMethod -Uri "$API_URL/emitentes/diagnostico-ibge" -Method Get -SkipCertificateCheck

    Write-Host "✅ Diagnóstico concluído!" -ForegroundColor Green
    Write-Host "   Total de emitentes: $($response.totalEmitentes)" -ForegroundColor White
    Write-Host "   Total de municípios cadastrados: $($response.totalMunicipiosCadastrados)" -ForegroundColor White
    Write-Host "   Emitentes com problema: $($response.emitentesComProblema)" -ForegroundColor Red
    Write-Host ""

    Write-Host "📋 Detalhes dos emitentes:" -ForegroundColor Cyan
    foreach ($emitente in $response.detalhes) {
        $cor = if ($emitente.status -eq "✅ OK") { "Green" } else { "Red" }
        Write-Host "   [$($emitente.status)] ID: $($emitente.id) - $($emitente.razaoSocial)" -ForegroundColor $cor
        Write-Host "      Município: $($emitente.municipio)/$($emitente.uf)" -ForegroundColor Gray
        Write-Host "      Código IBGE atual: $($emitente.codMunicipioAtual)" -ForegroundColor Gray
        Write-Host "      Município existe na tabela IBGE: $($emitente.municipioExisteNaTabela)" -ForegroundColor Gray
        Write-Host ""
    }
} catch {
    Write-Host "❌ Erro ao chamar API de diagnóstico: $_" -ForegroundColor Red
}

# 2. Testar API de Entidades (wizard)
Write-Host ""
Write-Host "📊 2. Testando API /entities/wizard..." -ForegroundColor Yellow
try {
    $response = Invoke-RestMethod -Uri "$API_URL/entities/wizard" -Method Get -SkipCertificateCheck

    if ($response.data.emitentes) {
        Write-Host "✅ API retornou $($response.data.emitentes.Count) emitentes" -ForegroundColor Green
        Write-Host ""

        foreach ($emitente in $response.data.emitentes) {
            $problemas = @()

            if ([string]::IsNullOrEmpty($emitente.label)) {
                $problemas += "Label vazio"
            }
            if ($emitente.codMunicipio -eq 0 -or $null -eq $emitente.codMunicipio) {
                $problemas += "Código IBGE zerado"
            }

            if ($problemas.Count -gt 0) {
                Write-Host "   ❌ Emitente ID $($emitente.id):" -ForegroundColor Red
                Write-Host "      Label: '$($emitente.label)'" -ForegroundColor Gray
                Write-Host "      Código IBGE: $($emitente.codMunicipio)" -ForegroundColor Gray
                Write-Host "      Município/UF: $($emitente.municipio)/$($emitente.uf)" -ForegroundColor Gray
                Write-Host "      Problemas: $($problemas -join ', ')" -ForegroundColor Red
            } else {
                Write-Host "   ✅ Emitente ID $($emitente.id): $($emitente.label) - Código IBGE: $($emitente.codMunicipio)" -ForegroundColor Green
            }
        }
    }
} catch {
    Write-Host "❌ Erro ao chamar API wizard: $_" -ForegroundColor Red
}

# 3. Atualizar códigos IBGE automaticamente
Write-Host ""
Write-Host "📊 3. Deseja atualizar os códigos IBGE automaticamente? (S/N)" -ForegroundColor Yellow
$resposta = Read-Host

if ($resposta -eq "S" -or $resposta -eq "s") {
    Write-Host "🔄 Atualizando códigos IBGE..." -ForegroundColor Yellow
    try {
        $response = Invoke-RestMethod -Uri "$API_URL/emitentes/atualizar-codigos-ibge" -Method Post -SkipCertificateCheck

        Write-Host "✅ $($response.mensagem)" -ForegroundColor Green
        Write-Host "   Atualizados: $($response.atualizados)" -ForegroundColor White
        Write-Host "   Não encontrados: $($response.naoEncontrados)" -ForegroundColor White
        Write-Host "   Total processado: $($response.total)" -ForegroundColor White
    } catch {
        Write-Host "❌ Erro ao atualizar códigos: $_" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "✅ === DIAGNÓSTICO CONCLUÍDO ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "💡 PRÓXIMOS PASSOS:" -ForegroundColor Yellow
Write-Host "1. Se houver emitentes com problema, execute a atualização automática" -ForegroundColor White
Write-Host "2. Recarregue a página do MDF-e no navegador" -ForegroundColor White
Write-Host "3. Verifique se o badge verde aparece com o código IBGE correto" -ForegroundColor White
Write-Host ""
