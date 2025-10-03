# Script para remover todos os estados de loading do frontend

$files = @(
    "frontend\src\pages\Veiculos\ListarVeiculos\ListarVeiculos.tsx",
    "frontend\src\pages\Condutores\ListarCondutores\ListarCondutores.tsx",
    "frontend\src\pages\Reboques\ListarReboques\ListarReboques.tsx",
    "frontend\src\pages\Municipios\ListarMunicipios\ListarMunicipios.tsx",
    "frontend\src\pages\Contratantes\ListarContratantes\ListarContratantes.tsx",
    "frontend\src\pages\Seguradoras\ListarSeguradoras\ListarSeguradoras.tsx",
    "frontend\src\pages\MDFe\DetalhesMDFe\DetalhesMDFe.tsx",
    "frontend\src\pages\MDFe\FormularioMDFe\FormularioMDFe.tsx"
)

foreach ($file in $files) {
    if (Test-Path $file) {
        Write-Host "Processando: $file"

        $content = Get-Content $file -Raw

        # Remover estado de loading
        $content = $content -replace "const \[carregando, setCarregando\] = useState\(false\);", "// Loading removido - interface instantânea"
        $content = $content -replace "const \[loading, setLoading\] = useState\(false\);", "// Loading removido - interface instantânea"

        # Remover setCarregando/setLoading
        $content = $content -replace "setCarregando\(true\);", "// Loading removido"
        $content = $content -replace "setCarregando\(false\);", "// Loading removido"
        $content = $content -replace "setLoading\(true\);", "// Loading removido"
        $content = $content -replace "setLoading\(false\);", "// Loading removido"

        # Salvar arquivo
        $content | Set-Content $file -NoNewline

        Write-Host "✓ $file atualizado" -ForegroundColor Green
    }
}

Write-Host "`nLoadings removidos com sucesso!" -ForegroundColor Cyan
