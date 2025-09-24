# 📋 GUIA - INTEGRAÇÃO COM CADASTROS PRÉ-DEFINIDOS

## 🎯 **PROBLEMA RESOLVIDO**
Este guia resolve como implementar MDFe quando você já tem **cadastros** no sistema (emitentes, veículos, condutores, etc.) e quer **selecionar por ID** ao invés de digitar dados manualmente.

---

## 🏗️ **ARQUITETURA RECOMENDADA**

### **1️⃣ ESTRUTURA DE CADASTROS**

```csharp
// Seus cadastros existentes
public class Emitente
{
    public int Id { get; set; }
    public string CNPJ { get; set; }
    public string IE { get; set; }
    public string RazaoSocial { get; set; }
    public string NomeFantasia { get; set; }
    public string Endereco { get; set; }
    public string Numero { get; set; }
    public string Bairro { get; set; }
    public string Cidade { get; set; }
    public string UF { get; set; }
    public string CEP { get; set; }
    public string Telefone { get; set; }
    public string RNTRC { get; set; }

    // ⭐ CRÍTICO: Dados do certificado
    public string CertificadoSerial { get; set; }
    public string CertificadoSenha { get; set; } // Pode estar criptografada
    public bool CertificadoSenhaCriptografada { get; set; }
}

public class Veiculo
{
    public int Id { get; set; }
    public string Placa { get; set; }
    public string RENAVAM { get; set; }
    public int Tara { get; set; }
    public int CapacidadeKG { get; set; }
    public int CapacidadeM3 { get; set; }
    public string UF { get; set; }

    // ⭐ CRÍTICO: Campos numéricos para MDFe
    public int TipoRodadoCodigo { get; set; } // 1=Truck, 2=Toco, etc
    public int TipoCarroceriaCodigo { get; set; } // 1=Aberta, 2=Baú, etc

    // Relacionamentos
    public int ProprietarioId { get; set; }
    public Proprietario Proprietario { get; set; }
}

public class Condutor
{
    public int Id { get; set; }
    public string Nome { get; set; }
    public string CPF { get; set; }
    public bool Ativo { get; set; }
}

public class Destinatario
{
    public int Id { get; set; }
    public string CNPJ { get; set; }
    public string RazaoSocial { get; set; }
    public string Cidade { get; set; }
    public string UF { get; set; }
    public int CodigoMunicipioIBGE { get; set; } // ⭐ CRÍTICO: Código IBGE
}
```

---

## 💻 **IMPLEMENTAÇÃO - SERVIÇO COM CADASTROS**

### **2️⃣ INTERFACE PARA CADASTROS**

```csharp
public interface IMDFeServiceCadastros
{
    Task<string> GerarMDFeComCadastros(MDFeRequestCadastros request);
    Task<string> TransmitirMDFe(int emitenteId, int numeroLote = 1);
    Task<string> ConsultarMDFe(int emitenteId, string chave);
    Task<string> CancelarMDFe(int emitenteId, string chave, string justificativa);
}

public class MDFeRequestCadastros
{
    public int EmitenteId { get; set; } // ID do cadastro de emitente
    public int VeiculoId { get; set; } // ID do cadastro de veículo
    public int CondutorId { get; set; } // ID do cadastro de condutor
    public int DestinatarioId { get; set; } // ID do cadastro de destinatário

    // Dados específicos do MDFe
    public int NumeroMDFe { get; set; }
    public string ChaveCTe { get; set; }
    public decimal ValorCarga { get; set; }
    public decimal PesoCarga { get; set; }
    public int TipoCarga { get; set; } // ⭐ Código numérico 01-12
    public string DescricaoProduto { get; set; }
    public string InformacoesComplementares { get; set; }
}
```

### **3️⃣ IMPLEMENTAÇÃO DO SERVIÇO**

```csharp
public class MDFeServiceCadastros : IMDFeServiceCadastros
{
    private readonly IMDFeService _mdfeService; // Serviço base do package
    private readonly IEmitenteRepository _emitenteRepo;
    private readonly IVeiculoRepository _veiculoRepo;
    private readonly ICondutorRepository _condutorRepo;
    private readonly IDestinatarioRepository _destinatarioRepo;
    private readonly ICertificadoManager _certificadoManager;
    private readonly ILogger<MDFeServiceCadastros> _logger;

    public async Task<string> GerarMDFeComCadastros(MDFeRequestCadastros request)
    {
        try
        {
            _logger.LogInformation("Iniciando geração MDFe - Emitente: {emitenteId}", request.EmitenteId);

            // 1. Buscar todos os cadastros
            var emitente = await _emitenteRepo.ObterPorIdAsync(request.EmitenteId);
            var veiculo = await _veiculoRepo.ObterComProprietarioAsync(request.VeiculoId);
            var condutor = await _condutorRepo.ObterPorIdAsync(request.CondutorId);
            var destinatario = await _destinatarioRepo.ObterPorIdAsync(request.DestinatarioId);

            // 2. Validar cadastros
            ValidarCadastros(emitente, veiculo, condutor, destinatario);

            // 3. Configurar certificado do emitente
            await _certificadoManager.ConfigurarCertificadoEmitente(emitente);

            // 4. Gerar INI com dados dos cadastros
            var iniPath = await GerarINIComCadastros(request, emitente, veiculo, condutor, destinatario);

            // 5. Gerar MDFe usando o serviço base
            var xml = _mdfeService.GerarMDFe(iniPath);

            _logger.LogInformation("MDFe gerado com sucesso - Emitente: {emitenteId}", request.EmitenteId);

            return xml;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Erro ao gerar MDFe com cadastros - Emitente: {emitenteId}", request.EmitenteId);
            throw;
        }
    }

    private async Task<string> GerarINIComCadastros(
        MDFeRequestCadastros request,
        Emitente emitente,
        Veiculo veiculo,
        Condutor condutor,
        Destinatario destinatario)
    {
        var iniContent = $@"[infMDFe]
Id=MDFe{GerarChaveMDFe(request, emitente)}

[ide]
cUF={ObterCodigoUF(emitente.UF)}
tpAmb=2
tpEmit=1
tpTransp=1
mod=58
serie=1
nMDF={request.NumeroMDFe:000000}
cMDF={GerarCodigoMDFe()}
cDV={CalcularDV(request.NumeroMDFe)}
modal=01
dhEmi={DateTime.Now:yyyy-MM-ddTHH:mm:sszzz}
tpEmis=1
procEmi=0
verProc=Sistema MDFe v1.2.2.337
UFIni={emitente.UF}
UFFim={destinatario.UF}

[emit]
CNPJCPF={emitente.CNPJ}
IE={emitente.IE}
xNome={emitente.RazaoSocial}
xFant={emitente.NomeFantasia}
xLgr={emitente.Endereco}
nro={emitente.Numero}
xBairro={emitente.Bairro}
cMun={ObterCodigoMunicipioIBGE(emitente.Cidade, emitente.UF)}
xMun={emitente.Cidade}
CEP={emitente.CEP}
UF={emitente.UF}
fone={emitente.Telefone}

[infModal]
versaoModal=3.00

[infANTT]
RNTRC={emitente.RNTRC}

[veicTracao]
cInt=1
placa={veiculo.Placa}
RENAVAM={veiculo.RENAVAM}
tara={veiculo.Tara}
capKG={veiculo.CapacidadeKG}
capM3={veiculo.CapacidadeM3}
tpRod={veiculo.TipoRodadoCodigo:D2}
tpCar={veiculo.TipoCarroceriaCodigo:D2}
UF={veiculo.UF}

[prop]
CPF={veiculo.Proprietario.CPF}
xNome={veiculo.Proprietario.Nome}
UF={veiculo.Proprietario.UF}
tpProp=1

[moto001]
xNome={condutor.Nome}
CPF={condutor.CPF}

[infDoc]

[infMunDescarga001]
cMunDescarga={destinatario.CodigoMunicipioIBGE}
xMunDescarga={destinatario.Cidade}

[infCTe001]
chCTe={request.ChaveCTe}

[prodPred]
tpCarga={request.TipoCarga:D2}
xProd={request.DescricaoProduto}

[tot]
qCTe=1
qNFe=0
qMDFe=0
vCarga={request.ValorCarga:F2}
cUnid=01
qCarga={request.PesoCarga:F4}

[infAdic]
infCpl={request.InformacoesComplementares}";

        var iniPath = Path.GetTempFileName();
        await File.WriteAllTextAsync(iniPath, iniContent);

        _logger.LogInformation("INI gerado: {iniPath}", iniPath);

        return iniPath;
    }

    private void ValidarCadastros(Emitente emitente, Veiculo veiculo, Condutor condutor, Destinatario destinatario)
    {
        // Validar emitente
        if (emitente == null) throw new ArgumentException("Emitente não encontrado");
        if (string.IsNullOrEmpty(emitente.CNPJ)) throw new ArgumentException("CNPJ do emitente é obrigatório");
        if (string.IsNullOrEmpty(emitente.RNTRC)) throw new ArgumentException("RNTRC do emitente é obrigatório");

        // Validar veículo
        if (veiculo == null) throw new ArgumentException("Veículo não encontrado");
        if (string.IsNullOrEmpty(veiculo.Placa)) throw new ArgumentException("Placa do veículo é obrigatória");
        if (veiculo.TipoRodadoCodigo < 1 || veiculo.TipoRodadoCodigo > 6)
            throw new ArgumentException($"Tipo rodado inválido: {veiculo.TipoRodadoCodigo}");
        if (veiculo.TipoCarroceriaCodigo < 1 || veiculo.TipoCarroceriaCodigo > 5)
            throw new ArgumentException($"Tipo carroceria inválido: {veiculo.TipoCarroceriaCodigo}");

        // Validar condutor
        if (condutor == null) throw new ArgumentException("Condutor não encontrado");
        if (string.IsNullOrEmpty(condutor.CPF) || condutor.CPF.Length != 11)
            throw new ArgumentException("CPF do condutor inválido");

        // Validar destinatário
        if (destinatario == null) throw new ArgumentException("Destinatário não encontrado");
        if (destinatario.CodigoMunicipioIBGE <= 0)
            throw new ArgumentException("Código município IBGE do destinatário é obrigatório");

        _logger.LogInformation("Todos os cadastros validados com sucesso");
    }
}
```

---

## 🔧 **HELPERS E UTILITÁRIOS**

### **4️⃣ MÉTODOS AUXILIARES**

```csharp
public static class MDFeHelper
{
    private static readonly Dictionary<string, int> CodigosUF = new()
    {
        { "AC", 12 }, { "AL", 17 }, { "AP", 16 }, { "AM", 13 }, { "BA", 29 },
        { "CE", 23 }, { "DF", 53 }, { "ES", 32 }, { "GO", 52 }, { "MA", 21 },
        { "MT", 51 }, { "MS", 50 }, { "MG", 31 }, { "PA", 15 }, { "PB", 25 },
        { "PR", 41 }, { "PE", 26 }, { "PI", 22 }, { "RJ", 33 }, { "RN", 24 },
        { "RS", 43 }, { "RO", 11 }, { "RR", 14 }, { "SC", 42 }, { "SP", 35 },
        { "SE", 28 }, { "TO", 27 }
    };

    public static int ObterCodigoUF(string uf)
    {
        return CodigosUF.TryGetValue(uf?.ToUpper(), out int codigo) ? codigo : throw new ArgumentException($"UF inválida: {uf}");
    }

    public static string GerarChaveMDFe(MDFeRequestCadastros request, Emitente emitente)
    {
        var cuf = ObterCodigoUF(emitente.UF);
        var aamm = DateTime.Now.ToString("yyMM");
        var cnpj = emitente.CNPJ;
        var mod = "58";
        var serie = "001";
        var numero = request.NumeroMDFe.ToString("000000000");
        var tpEmis = "1";
        var codigo = GerarCodigoMDFe().ToString("00000000");

        var chaveSemDV = $"{cuf}{aamm}{cnpj}{mod}{serie}{numero}{tpEmis}0{codigo}";
        var dv = CalcularDV(chaveSemDV);

        return chaveSemDV + dv;
    }

    public static int GerarCodigoMDFe()
    {
        return new Random().Next(10000000, 99999999);
    }

    public static int CalcularDV(object valor)
    {
        var chave = valor.ToString();
        var soma = 0;
        var peso = 2;

        for (int i = chave.Length - 1; i >= 0; i--)
        {
            soma += int.Parse(chave[i].ToString()) * peso;
            peso++;
            if (peso > 9) peso = 2;
        }

        var resto = soma % 11;
        return resto < 2 ? 0 : 11 - resto;
    }

    // ⭐ CRÍTICO: Buscar código IBGE do município
    public static async Task<int> ObterCodigoMunicipioIBGE(string cidade, string uf)
    {
        // Implementar consulta à sua tabela de municípios IBGE
        // ou webservice de consulta

        // Exemplo simplificado - VOCÊ DEVE IMPLEMENTAR ISSO
        var municipios = new Dictionary<string, int>
        {
            { "SAO PAULO-SP", 3550308 },
            { "PENAPOLIS-SP", 3537305 },
            { "ITUIUTABA-MG", 3134202 }
        };

        var chave = $"{cidade?.ToUpper()}-{uf?.ToUpper()}";
        return municipios.TryGetValue(chave, out int codigo) ? codigo :
            throw new ArgumentException($"Código IBGE não encontrado para {cidade}-{uf}");
    }
}
```

---

## 🎯 **EXEMPLO DE USO NO CONTROLLER**

```csharp
[ApiController]
[Route("api/[controller]")]
public class MDFeController : ControllerBase
{
    private readonly IMDFeServiceCadastros _mdfeService;

    [HttpPost("gerar-com-cadastros")]
    public async Task<IActionResult> GerarMDFeComCadastros([FromBody] MDFeRequestCadastros request)
    {
        try
        {
            // Validação básica
            if (request.EmitenteId <= 0) return BadRequest("Emitente é obrigatório");
            if (request.VeiculoId <= 0) return BadRequest("Veículo é obrigatório");
            if (request.CondutorId <= 0) return BadRequest("Condutor é obrigatório");
            if (request.TipoCarga < 1 || request.TipoCarga > 12) return BadRequest("Tipo de carga inválido (1-12)");

            // Gerar MDFe
            var xml = await _mdfeService.GerarMDFeComCadastros(request);

            return Ok(new {
                sucesso = true,
                xml = xml,
                mensagem = "MDFe gerado com sucesso usando cadastros pré-definidos"
            });
        }
        catch (Exception ex)
        {
            return BadRequest(new {
                sucesso = false,
                mensagem = ex.Message
            });
        }
    }
}
```

---

## ✅ **CHECKLIST DE IMPLEMENTAÇÃO**

### **📋 CADASTROS:**
- [ ] Tabela de emitentes com certificado
- [ ] Tabela de veículos com códigos numéricos (tpRod, tpCar)
- [ ] Tabela de condutores com CPF válido
- [ ] Tabela de destinatários com código IBGE
- [ ] Tabela de municípios IBGE atualizada

### **💻 CÓDIGO:**
- [ ] Interface IMDFeServiceCadastros implementada
- [ ] Validação de todos os cadastros
- [ ] Geração automática de INI a partir dos cadastros
- [ ] Tratamento de erros específicos
- [ ] Logs detalhados para debug

### **🔧 CONFIGURAÇÃO:**
- [ ] Repository pattern para acesso aos cadastros
- [ ] Injeção de dependência configurada
- [ ] Manager de certificados implementado
- [ ] Helper methods para códigos e validações

---

**💡 RESULTADO FINAL**: Sistema que trabalha 100% com seus cadastros existentes, garantindo que todos os campos numéricos sejam passados corretamente!