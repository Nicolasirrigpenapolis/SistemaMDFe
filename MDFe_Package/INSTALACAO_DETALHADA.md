# Instalação Detalhada - ACBr MDFe em ASP.NET

## Pré-requisitos

1. **Visual Studio 2019 ou superior**
2. **.NET 6.0 ou superior**
3. **Visual C++ Redistributable 2019 x64**
4. **Certificado Digital A1** (para produção)

## Passo a Passo da Instalação

### 1. Preparação do Projeto

Crie ou abra seu projeto ASP.NET existente.

### 2. Adição das DLLs

1. Copie todas as DLLs da pasta `DLLs/` para o diretório raiz do seu projeto
2. No Visual Studio, clique com botão direito no projeto → "Add" → "Existing Item"
3. Selecione todas as DLLs copiadas
4. Para cada DLL, nas propriedades:
   - **Build Action**: Content
   - **Copy to Output Directory**: Copy always

### 3. Adição dos Arquivos de Configuração

1. Copie os arquivos `.ini` da pasta `Config/` para o diretório raiz
2. Adicione-os ao projeto com as mesmas configurações das DLLs

### 4. Configuração do .csproj

Adicione o seguinte código ao seu arquivo `.csproj`:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">

  <PropertyGroup>
    <TargetFramework>net6.0</TargetFramework>
    <Platforms>x64</Platforms>
    <RuntimeIdentifier>win-x64</RuntimeIdentifier>
  </PropertyGroup>

  <ItemGroup>
    <!-- DLLs ACBr -->
    <Content Include="ACBrMDFe64.dll">
      <CopyToOutputDirectory>Always</CopyToOutputDirectory>
    </Content>
    <Content Include="libcrypto-1_1-x64.dll">
      <CopyToOutputDirectory>Always</CopyToOutputDirectory>
    </Content>
    <Content Include="libexslt.dll">
      <CopyToOutputDirectory>Always</CopyToOutputDirectory>
    </Content>
    <Content Include="libiconv.dll">
      <CopyToOutputDirectory>Always</CopyToOutputDirectory>
    </Content>
    <Content Include="libssl-1_1-x64.dll">
      <CopyToOutputDirectory>Always</CopyToOutputDirectory>
    </Content>
    <Content Include="libxml2.dll">
      <CopyToOutputDirectory>Always</CopyToOutputDirectory>
    </Content>
    <Content Include="libxslt.dll">
      <CopyToOutputDirectory>Always</CopyToOutputDirectory>
    </Content>

    <!-- Configurações INI -->
    <Content Include="ACBrLib.ini">
      <CopyToOutputDirectory>Always</CopyToOutputDirectory>
    </Content>
    <Content Include="MDFeTemplate.ini">
      <CopyToOutputDirectory>Always</CopyToOutputDirectory>
    </Content>
    <Content Include="ACBrMDFeServicos.ini">
      <CopyToOutputDirectory>Always</CopyToOutputDirectory>
    </Content>
  </ItemGroup>

</Project>
```

### 5. Criação do Service

Crie uma classe de serviço para encapsular as funções MDFe:

```csharp
using System.Runtime.InteropServices;
using System.Text;

namespace SeuProjeto.Services
{
    public class MDFeService
    {
        // Importações da DLL
        [DllImport("ACBrMDFe64.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int MDFe_Inicializar([MarshalAs(UnmanagedType.LPStr)] string eIniPath, [MarshalAs(UnmanagedType.LPStr)] string eChaveCrypt);

        [DllImport("ACBrMDFe64.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int MDFe_Finalizar();

        [DllImport("ACBrMDFe64.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int MDFe_CarregarINI([MarshalAs(UnmanagedType.LPStr)] string eArquivoOuINI);

        [DllImport("ACBrMDFe64.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int MDFe_Assinar(StringBuilder sResposta, ref int esTamanho);

        [DllImport("ACBrMDFe64.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int MDFe_Transmitir(StringBuilder sResposta, ref int esTamanho);

        [DllImport("ACBrMDFe64.dll", CallingConvention = CallingConvention.Cdecl)]
        public static extern int MDFe_StatusServico(StringBuilder sResposta, ref int esTamanho);

        private bool _inicializado = false;

        public void Inicializar()
        {
            if (!_inicializado)
            {
                var resultado = MDFe_Inicializar("", "");
                if (resultado != 0)
                    throw new Exception($"Erro ao inicializar MDFe: {resultado}");
                _inicializado = true;
            }
        }

        public string GerarMDFe(string template)
        {
            Inicializar();

            // Carregar template
            var resultado = MDFe_CarregarINI(template);
            if (resultado != 0)
                throw new Exception($"Erro ao carregar template: {resultado}");

            // Assinar
            var buffer = new StringBuilder(65536);
            var tamanho = buffer.Capacity;
            resultado = MDFe_Assinar(buffer, ref tamanho);

            if (resultado != 0)
                throw new Exception($"Erro ao assinar MDFe: {resultado}");

            return buffer.ToString();
        }

        public string TransmitirMDFe()
        {
            var buffer = new StringBuilder(65536);
            var tamanho = buffer.Capacity;
            var resultado = MDFe_Transmitir(buffer, ref tamanho);

            if (resultado != 0)
                throw new Exception($"Erro ao transmitir MDFe: {resultado}");

            return buffer.ToString();
        }

        public void Finalizar()
        {
            if (_inicializado)
            {
                MDFe_Finalizar();
                _inicializado = false;
            }
        }
    }
}
```

### 6. Registro no DI Container

No arquivo `Program.cs` (ou `Startup.cs`):

```csharp
// Program.cs
builder.Services.AddScoped<MDFeService>();
```

### 7. Uso no Controller

```csharp
[ApiController]
[Route("api/[controller]")]
public class MDFeController : ControllerBase
{
    private readonly MDFeService _mdfeService;

    public MDFeController(MDFeService mdfeService)
    {
        _mdfeService = mdfeService;
    }

    [HttpPost("gerar")]
    public IActionResult GerarMDFe()
    {
        try
        {
            var xml = _mdfeService.GerarMDFe("MDFeTemplate.ini");
            var resultado = _mdfeService.TransmitirMDFe();

            return Ok(new { xml, resultado });
        }
        catch (Exception ex)
        {
            return BadRequest(new { erro = ex.Message });
        }
        finally
        {
            _mdfeService.Finalizar();
        }
    }
}
```

## Configurações de Produção vs Homologação

### Homologação (Teste)
No `ACBrLib.ini`:
```ini
[DFe]
UF=SP
AmbienteCodigo=2  # 2 = Homologação
Salvar=1
```

### Produção
No `ACBrLib.ini`:
```ini
[DFe]
UF=SP
AmbienteCodigo=1  # 1 = Produção
Salvar=1

[Certificados]
NumeroCertificado=1234567890  # Número do certificado
Senha=senha_do_certificado    # Se necessário
```

## Deploy para IIS

1. **Certificar que todas as DLLs estão no bin/**
2. **Configurar Application Pool para 64-bit**
3. **Instalar Visual C++ Redistributable no servidor**
4. **Configurar permissões de pasta para escrita** (se necessário salvar XMLs)

## Troubleshooting

### "BadImageFormatException"
- Projeto deve ser compilado para x64
- Application Pool deve ser 64-bit

### "DllNotFoundException"
- Verificar se todas as DLLs estão presentes
- Verificar Visual C++ Redistributable

### "Access Violation"
- Sempre inicializar antes de usar
- Sempre finalizar após uso
- Não usar em múltiplas threads simultaneamente

## Estrutura Final do Projeto

```
SeuProjetoMDFe/
├── Controllers/
│   └── MDFeController.cs
├── Services/
│   └── MDFeService.cs
├── bin/Debug/net6.0/
│   ├── ACBrMDFe64.dll
│   ├── libcrypto-1_1-x64.dll
│   ├── ...outras DLLs
│   ├── ACBrLib.ini
│   ├── MDFeTemplate.ini
│   └── ACBrMDFeServicos.ini
├── ACBrMDFe64.dll (source)
├── ACBrLib.ini (source)
├── MDFeTemplate.ini (source)
├── ACBrMDFeServicos.ini (source)
└── SeuProjeto.csproj
```