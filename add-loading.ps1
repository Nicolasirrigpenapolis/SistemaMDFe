# Script para adicionar loading simples em todas as páginas de listagem

$files = @(
    "frontend\src\pages\Emitentes\ListarEmitentes\ListarEmitentes.tsx",
    "frontend\src\pages\Veiculos\ListarVeiculos\ListarVeiculos.tsx",
    "frontend\src\pages\Condutores\ListarCondutores\ListarCondutores.tsx",
    "frontend\src\pages\Reboques\ListarReboques\ListarReboques.tsx",
    "frontend\src\pages\Municipios\ListarMunicipios\ListarMunicipios.tsx"
)

foreach ($file in $files) {
    $filePath = Join-Path $PSScriptRoot $file

    if (Test-Path $filePath) {
        Write-Host "Processando: $file"

        $content = Get-Content $filePath -Raw

        # Adiciona loading state se não existir
        if ($content -match 'const \[loading, setLoading\]') {
            Write-Host "  - Já possui loading state" -ForegroundColor Yellow
        } else {
            Write-Host "  - Adicionando loading state" -ForegroundColor Green
            $content = $content -replace '(const \[\w+, set\w+\] = useState<[^>]+>\(\[\]\);)\s*//\s*Loading removido[^\n]*', '$1' + "`n  const [loading, setLoading] = useState(false);"
            $content = $content -replace '(const \[\w+, set\w+\] = useState<[^>]+>\(\[\]\);)\s*const \[primeiraVez[^\n]*', '$1' + "`n  const [loading, setLoading] = useState(false);"
        }

        # Adiciona setLoading(true) no início das funções de carregamento
        $content = $content -replace '(const carregar\w+ = async[^{]*\{)\s*(try \{)?', '$1' + "`n    setLoading(true);`n    try {"

        # Adiciona setLoading(false) no finally
        $content = $content -replace '(setPrimeiraVez\(false\);)\s*\}(\s*catch)', '} finally {' + "`n      setLoading(false);`n    }$2"
        $content = $content -replace '//\s*Loading removido\s*\}\s*catch', '} finally {' + "`n      setLoading(false);`n    } catch"

        # Adiciona o componente de loading antes do return principal
        $loadingComponent = @"
  if (loading) {
    return (
      <div className="min-h-screen bg-background flex items-center justify-center">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary mx-auto mb-4"></div>
          <p className="text-muted-foreground">Carregando...</p>
        </div>
      </div>
    );
  }

"@

        if ($content -notmatch 'if \(loading\)') {
            # Remove skeleton antigo se existir
            $content = $content -replace 'if \(primeiraVez && \w+\.length === 0\) \{[\s\S]*?\}\s*\}\s*(return \()', $loadingComponent + '$1'

            # Se não tinha skeleton, adiciona antes do return principal
            if ($content -notmatch 'if \(loading\)') {
                $content = $content -replace '(\s+)(return \(\s*<div className="min-h-screen)', '$1' + $loadingComponent + '$2'
            }
        }

        Set-Content $filePath $content -NoNewline
        Write-Host "  - Concluído!" -ForegroundColor Green
    } else {
        Write-Host "Arquivo não encontrado: $file" -ForegroundColor Red
    }
}

Write-Host "`nProcessamento concluído!" -ForegroundColor Cyan
