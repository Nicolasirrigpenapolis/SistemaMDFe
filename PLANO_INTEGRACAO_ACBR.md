# 🚀 PLANO DE INTEGRAÇÃO ACBr MONITOR - SISTEMA MDFE

**Data:** 02/10/2025
**Versão ACBrMonitor:** 1.4.0.366
**Versão ACBrLibMDFe:** 1.2.2.337

---

## 📊 RESUMO EXECUTIVO

Este plano detalha a integração completa do sistema MDFe ASP.NET com o **ACBrMonitorPLUS** via comunicação TCP/IP.

### Arquitetura Escolhida
```
[Frontend React] ─(HTTPS)→ [Backend ASP.NET] ─(TCP/IP:3434)→ [ACBrMonitor] ─(HTTPS)→ [SEFAZ]
```

### Fluxo de Emissão
1. Frontend envia dados do MDFe via API REST
2. Backend gera arquivo `.INI` com os dados
3. Backend envia comando `MDFE.CriarEnviarMDFe()` via TCP/IP
4. ACBrMonitor processa, assina e transmite para SEFAZ
5. Backend recebe resposta (chave, protocolo, status)
6. Backend atualiza banco de dados
7. Frontend exibe resultado ao usuário

---

## 📋 ANÁLISE DO MODELO DE DADOS

### Campos Presentes no MDFe.cs

#### ✅ Emitente (Snapshot)
- EmitenteCnpj, EmitenteIe, EmitenteRazaoSocial
- EmitenteNomeFantasia, EmitenteEndereco, EmitenteNumero
- EmitenteBairro, EmitenteMunicipio, EmitenteCep, EmitenteUf
- EmitenteTipoEmitente (1=ETC, 2=TAC, 3=CTC)
- EmitenteRntrc

#### ✅ Condutor (Snapshot)
- CondutorNome, CondutorCpf, CondutorTelefone

#### ✅ Veículo (Snapshot)
- VeiculoPlaca, VeiculoTara
- VeiculoTipoRodado, VeiculoTipoCarroceria, VeiculoUf

#### ✅ Contratante (Snapshot - Opcional)
- ContratanteCnpj/Cpf, ContratanteRazaoSocial
- Endereço completo

#### ✅ Seguradora (Snapshot - Opcional)
- SeguradoraCnpj, SeguradoraRazaoSocial
- TipoResponsavelSeguro (1-5)
- Endereço completo

#### ✅ Dados do MDFe
- Serie, NumeroMdfe, ChaveAcesso
- UfIni, UfFim, Modal (1=Rodoviário)
- DataEmissao, DataInicioViagem
- ValorTotal, UnidadeMedida (fixo '01'=kg)
- TipoCarga, DescricaoProduto
- CepCarregamento, CepDescarregamento

#### ✅ Propriet ário do Veículo (Opcional)
- ProprietarioDiferente (bool)
- CnpjProprietario/CpfProprietario, NomeProprietario
- RntrcProprietario

#### ✅ Controle SEFAZ
- StatusSefaz (RASCUNHO, AUTORIZADO, CANCELADO, ENCERRADO)
- Protocolo, DataAutorizacao
- XmlGerado, XmlRetorno

#### ✅ Relacionamentos
- Reboques (ICollection<Reboque>)
- DocumentosCTeJson, DocumentosNFeJson (JSON)
- PercursosJson (JSON com UFs do percurso)
- MunicipioCarregamento

#### ❌ Campos FALTANDO (importantes para MDFe)
- **PesoBrutoTotal** (qCarga) - ⚠️ CRÍTICO
- **QuantidadeCTe** (calculado automaticamente)
- **QuantidadeNFe** (calculado automaticamente)
- **Lote** (número do lote de envio)

---

## 🔧 IMPLEMENTAÇÃO

### FASE 1: ESTRUTURA BASE

#### 1.1 - Criar DTOs de Comunicação ACBr

**Arquivo:** `MDFe.Api/DTOs/ACBrDTOs.cs`

```csharp
namespace MDFeApi.DTOs
{
    /// <summary>
    /// Resposta padrão dos comandos ACBr Monitor
    /// </summary>
    public class ACBrResponseDto
    {
        public bool Sucesso { get; set; }
        public string Mensagem { get; set; } = string.Empty;
        public string? ChaveMDFe { get; set; }
        public string? Protocolo { get; set; }
        public string? XmlGerado { get; set; }
        public List<string> Erros { get; set; } = new();
        public string RespostaBruta { get; set; } = string.Empty;
    }

    /// <summary>
    /// Configurações do ACBr Monitor
    /// </summary>
    public class ACBrConfigDto
    {
        public string Host { get; set; } = "127.0.0.1";
        public int Port { get; set; } = 3434;
        public int Timeout { get; set; } = 30000;
        public string PathTemporario { get; set; } = "C:\\Temp\\MDFe";
    }
}
```

---

#### 1.2 - Criar Cliente TCP/IP do ACBr Monitor

**Arquivo:** `MDFe.Api/Services/ACBrMonitorClient.cs`

```csharp
using System.Net.Sockets;
using System.Text;

namespace MDFeApi.Services
{
    public interface IACBrMonitorClient
    {
        Task<string> ExecutarComandoAsync(string comando);
        Task<bool> TestarConexaoAsync();
    }

    public class ACBrMonitorClient : IACBrMonitorClient
    {
        private readonly string _host;
        private readonly int _port;
        private readonly int _timeout;
        private readonly ILogger<ACBrMonitorClient> _logger;

        // IMPORTANTE: Encoding ISO-8859-1 (Latin1) conforme documentação
        private static readonly Encoding _encoding = Encoding.GetEncoding("ISO-8859-1");

        public ACBrMonitorClient(string host, int port, int timeout, ILogger<ACBrMonitorClient> logger)
        {
            _host = host;
            _port = port;
            _timeout = timeout;
            _logger = logger;
        }

        public async Task<string> ExecutarComandoAsync(string comando)
        {
            try
            {
                using var client = new TcpClient();
                var connectTask = client.ConnectAsync(_host, _port);

                if (await Task.WhenAny(connectTask, Task.Delay(_timeout)) != connectTask)
                {
                    throw new TimeoutException($"Timeout ao conectar no ACBrMonitor ({_host}:{_port})");
                }

                await connectTask; // Throw exception se falhou

                using var stream = client.GetStream();

                // Formato do comando: "COMANDO\r\n.\r\n"
                var comandoFormatado = $"{comando}\r\n.\r\n";
                var bytes = _encoding.GetBytes(comandoFormatado);

                await stream.WriteAsync(bytes, 0, bytes.Length);
                _logger.LogInformation("Comando enviado ao ACBr: {Comando}", comando);

                // Ler resposta
                var buffer = new byte[65536]; // 64KB
                var bytesRead = await stream.ReadAsync(buffer, 0, buffer.Length);
                var resposta = _encoding.GetString(buffer, 0, bytesRead);

                _logger.LogInformation("Resposta ACBr recebida: {Resposta}", resposta);
                return resposta;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao executar comando ACBr: {Comando}", comando);
                throw;
            }
        }

        public async Task<bool> TestarConexaoAsync()
        {
            try
            {
                var resposta = await ExecutarComandoAsync("MDFE.Ativo");
                return resposta.Contains("OK", StringComparison.OrdinalIgnoreCase);
            }
            catch
            {
                return false;
            }
        }
    }
}
```

---

#### 1.3 - Criar Parser de Respostas ACBr

**Arquivo:** `MDFe.Api/Services/ACBrResponseParser.cs`

```csharp
using MDFeApi.DTOs;
using System.Text.RegularExpressions;

namespace MDFeApi.Services
{
    public interface IACBrResponseParser
    {
        ACBrResponseDto ParseResposta(string respostaBruta);
    }

    public class ACBrResponseParser : IACBrResponseParser
    {
        private readonly ILogger<ACBrResponseParser> _logger;

        public ACBrResponseParser(ILogger<ACBrResponseParser> logger)
        {
            _logger = logger;
        }

        public ACBrResponseDto ParseResposta(string respostaBruta)
        {
            var dto = new ACBrResponseDto
            {
                RespostaBruta = respostaBruta
            };

            try
            {
                // Verificar se é sucesso ou erro
                if (respostaBruta.StartsWith("OK:", StringComparison.OrdinalIgnoreCase))
                {
                    dto.Sucesso = true;
                    dto.Mensagem = "Operação executada com sucesso";

                    // Extrair chave do MDFe (44 dígitos)
                    var chaveMatch = Regex.Match(respostaBruta, @"Chave[:\s]+(\d{44})");
                    if (chaveMatch.Success)
                    {
                        dto.ChaveMDFe = chaveMatch.Groups[1].Value;
                    }

                    // Extrair protocolo
                    var protocoloMatch = Regex.Match(respostaBruta, @"Protocolo[:\s]+(\d+)");
                    if (protocoloMatch.Success)
                    {
                        dto.Protocolo = protocoloMatch.Groups[1].Value;
                    }
                }
                else if (respostaBruta.StartsWith("ERRO:", StringComparison.OrdinalIgnoreCase))
                {
                    dto.Sucesso = false;
                    dto.Mensagem = respostaBruta.Replace("ERRO:", "").Trim();
                    dto.Erros.Add(dto.Mensagem);
                }
                else
                {
                    // Resposta não reconhecida
                    dto.Sucesso = false;
                    dto.Mensagem = "Resposta não reconhecida do ACBr";
                    dto.Erros.Add(respostaBruta);
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao parsear resposta ACBr");
                dto.Sucesso = false;
                dto.Mensagem = $"Erro ao processar resposta: {ex.Message}";
                dto.Erros.Add(ex.Message);
            }

            return dto;
        }
    }
}
```

---

### FASE 2: GERAÇÃO DE ARQUIVO INI

#### 2.1 - Adicionar Campo Faltante no Modelo

**Arquivo:** `MDFe.Api/Models/MDFe.cs`

```csharp
// Adicionar após linha 156 (ValorTotal):

[Column(TypeName = "decimal(18,3)")]
public decimal? PesoBrutoTotal { get; set; } // qCarga em Kg

public int? QuantidadeCTe { get; set; } // Calculado automaticamente
public int? QuantidadeNFe { get; set; } // Calculado automaticamente

public int? Lote { get; set; } = 1; // Número do lote de envio
```

**Criar migração:**
```bash
dotnet ef migrations add AddPesoBrutoTotalEQuantidades
dotnet ef database update
```

---

#### 2.2 - Criar Gerador de INI

**Arquivo:** `MDFe.Api/Services/MDFeIniGenerator.cs`

```csharp
using MDFeApi.Models;
using System.Text;

namespace MDFeApi.Services
{
    public interface IMDFeIniGenerator
    {
        Task<string> GerarIniAsync(MDFe mdfe);
        string GerarIniEvento(string tipoEvento, MDFe mdfe, Dictionary<string, string> parametrosEvento);
    }

    public class MDFeIniGenerator : IMDFeIniGenerator
    {
        private readonly ILogger<MDFeIniGenerator> _logger;

        public MDFeIniGenerator(ILogger<MDFeIniGenerator> logger)
        {
            _logger = logger;
        }

        public async Task<string> GerarIniAsync(MDFe mdfe)
        {
            var ini = new StringBuilder();

            // === SEÇÃO [infMDFe] ===
            ini.AppendLine("[infMDFe]");
            ini.AppendLine($"versao=3.00");
            ini.AppendLine();

            // === SEÇÃO [ide] - Identificação do MDFe ===
            ini.AppendLine("[ide]");
            ini.AppendLine($"cUF={ObterCodigoUF(mdfe.EmitenteUf)}");
            ini.AppendLine($"tpAmb=2"); // 1=Produção, 2=Homologação (ler de config)
            ini.AppendLine($"tpEmit={mdfe.TipoTransportador}"); // 1=ETC, 2=TAC, 3=CTC
            ini.AppendLine($"mod=58"); // Fixo: 58 = MDFe
            ini.AppendLine($"serie={mdfe.Serie}");
            ini.AppendLine($"nMDF={mdfe.NumeroMdfe}");
            ini.AppendLine($"cMDF={mdfe.CodigoNumericoAleatorio ?? GerarCodigoAleatorio()}");
            ini.AppendLine($"cDV={mdfe.CodigoVerificador ?? "0"}");
            ini.AppendLine($"modal={mdfe.Modal}"); // 1=Rodoviário
            ini.AppendLine($"dhEmi={mdfe.DataEmissao:yyyy-MM-ddTHH:mm:sszzz}");
            ini.AppendLine($"tpEmis=1"); // 1=Normal
            ini.AppendLine($"procEmi=0"); // 0=Aplicativo contribuinte
            ini.AppendLine($"verProc=1.0.0"); // Versão do sistema
            ini.AppendLine($"UFIni={mdfe.UfIni}");
            ini.AppendLine($"UFFim={mdfe.UfFim}");

            // Percurso (se houver)
            if (!string.IsNullOrEmpty(mdfe.PercursosJson))
            {
                var percursos = System.Text.Json.JsonSerializer.Deserialize<List<string>>(mdfe.PercursosJson);
                for (int i = 0; i < percursos?.Count; i++)
                {
                    ini.AppendLine($"UFPer{(i + 1):D3}={percursos[i]}");
                }
            }

            // Informações adicionais
            if (!string.IsNullOrEmpty(mdfe.InfoAdicional))
            {
                ini.AppendLine($"infAdFisco={mdfe.InfoAdicional}");
            }

            ini.AppendLine();

            // === SEÇÃO [emit] - Emitente ===
            ini.AppendLine("[emit]");

            if (!string.IsNullOrEmpty(mdfe.EmitenteCnpj))
                ini.AppendLine($"CNPJ={mdfe.EmitenteCnpj}");
            else if (!string.IsNullOrEmpty(mdfe.EmitenteCpf))
                ini.AppendLine($"CPF={mdfe.EmitenteCpf}");

            ini.AppendLine($"IE={mdfe.EmitenteIe}");
            ini.AppendLine($"xNome={mdfe.EmitenteRazaoSocial}");

            if (!string.IsNullOrEmpty(mdfe.EmitenteNomeFantasia))
                ini.AppendLine($"xFant={mdfe.EmitenteNomeFantasia}");

            // Endereço do emitente
            ini.AppendLine($"xLgr={mdfe.EmitenteEndereco}");
            ini.AppendLine($"nro={mdfe.EmitenteNumero ?? "SN"}");

            if (!string.IsNullOrEmpty(mdfe.EmitenteComplemento))
                ini.AppendLine($"xCpl={mdfe.EmitenteComplemento}");

            ini.AppendLine($"xBairro={mdfe.EmitenteBairro}");
            ini.AppendLine($"cMun={mdfe.EmitenteCodMunicipio}");
            ini.AppendLine($"xMun={mdfe.EmitenteMunicipio}");
            ini.AppendLine($"CEP={mdfe.EmitenteCep}");
            ini.AppendLine($"UF={mdfe.EmitenteUf}");
            ini.AppendLine();

            // === SEÇÃO [infModal] - Modal Rodoviário ===
            ini.AppendLine("[infModal]");
            ini.AppendLine($"versaoModal=3.00");
            ini.AppendLine();

            // === SEÇÃO [rodo] - Rodoviário ===
            ini.AppendLine("[rodo]");

            // Dados ANTT
            if (!string.IsNullOrEmpty(mdfe.EmitenteRntrc))
                ini.AppendLine($"RNTRC={mdfe.EmitenteRntrc}");

            // CEPs de Carregamento/Descarregamento (opcionais)
            if (!string.IsNullOrEmpty(mdfe.CepCarregamento))
                ini.AppendLine($"CEPCarga={mdfe.CepCarregamento}");

            if (!string.IsNullOrEmpty(mdfe.CepDescarregamento))
                ini.AppendLine($"CEPDescarga={mdfe.CepDescarregamento}");

            ini.AppendLine();

            // === SEÇÃO [veicTracao] - Veículo de Tração ===
            ini.AppendLine("[veicTracao]");
            ini.AppendLine($"placa={mdfe.VeiculoPlaca}");
            ini.AppendLine($"tara={mdfe.VeiculoTara ?? 0}");
            ini.AppendLine($"UF={mdfe.VeiculoUf}");

            // Tipo de Rodado e Carroceria conforme tabela SEFAZ
            ini.AppendLine($"tpRod={mdfe.VeiculoTipoRodado}");
            ini.AppendLine($"tpCar={mdfe.VeiculoTipoCarroceria}");
            ini.AppendLine();

            // === SEÇÃO [condutor001] - Condutor ===
            if (!string.IsNullOrEmpty(mdfe.CondutorNome))
            {
                ini.AppendLine("[condutor001]");
                ini.AppendLine($"xNome={mdfe.CondutorNome}");
                ini.AppendLine($"CPF={mdfe.CondutorCpf}");
                ini.AppendLine();
            }

            // === SEÇÃO [infMunCarrega001] - Município de Carregamento ===
            if (mdfe.MunicipioCarregamento != null)
            {
                ini.AppendLine("[infMunCarrega001]");
                ini.AppendLine($"cMunCarrega={mdfe.MunicipioCarregamento.CodigoIbge}");
                ini.AppendLine($"xMunCarrega={mdfe.MunicipioCarregamento.Nome}");
                ini.AppendLine();
            }

            // === SEÇÃO [infDoc001] - Documentos Fiscais (CTe/NFe) ===
            await AdicionarDocumentosFiscaisIni(ini, mdfe);

            // === SEÇÃO [seg001] - Seguradora (Opcional) ===
            if (!string.IsNullOrEmpty(mdfe.TipoResponsavelSeguro))
            {
                ini.AppendLine("[seg001]");
                ini.AppendLine($"respSeg={mdfe.TipoResponsavelSeguro}");
                ini.AppendLine($"CNPJ={mdfe.SeguradoraCnpj}");
                ini.AppendLine($"xSeg={mdfe.SeguradoraRazaoSocial}");
                // Apólice e averbação (se houver)
                ini.AppendLine();
            }

            // === SEÇÃO [tot] - Totalizadores ===
            ini.AppendLine("[tot]");
            ini.AppendLine($"qCTe={mdfe.QuantidadeCTe ?? 0}");
            ini.AppendLine($"qNFe={mdfe.QuantidadeNFe ?? 0}");
            ini.AppendLine($"qMDFe=1"); // FIXO: sempre 1 (um MDFe por arquivo)
            ini.AppendLine($"vCarga={mdfe.ValorTotal?.ToString("F2") ?? "0.00"}");
            ini.AppendLine($"cUnid=01"); // FIXO: 01=Quilograma
            ini.AppendLine($"qCarga={mdfe.PesoBrutoTotal?.ToString("F3") ?? "0.000"}");
            ini.AppendLine();

            // === SEÇÃO [prodPred] - Produto Predominante (Opcional) ===
            if (!string.IsNullOrEmpty(mdfe.TipoCarga))
            {
                ini.AppendLine("[prodPred]");
                ini.AppendLine($"tpCarga={mdfe.TipoCarga}");
                ini.AppendLine($"xProd={mdfe.DescricaoProduto ?? "Diversos"}");
                ini.AppendLine();
            }

            // === SEÇÃO [autXML001] - Autorizados para Download do XML (Opcional) ===
            // TODO: Implementar se necessário (campo novo no modelo)

            var conteudoIni = ini.ToString();
            _logger.LogInformation("INI gerado com sucesso para MDFe {Id}", mdfe.Id);

            return conteudoIni;
        }

        private async Task AdicionarDocumentosFiscaisIni(StringBuilder ini, MDFe mdfe)
        {
            int docIndex = 1;

            // CTe
            if (!string.IsNullOrEmpty(mdfe.DocumentosCTeJson))
            {
                var chavesCTe = System.Text.Json.JsonSerializer.Deserialize<List<string>>(mdfe.DocumentosCTeJson);

                foreach (var chave in chavesCTe ?? new List<string>())
                {
                    ini.AppendLine($"[infDoc{docIndex:D3}]");
                    ini.AppendLine($"cMunDescarga=3550308"); // TODO: Extrair do CTe ou ter campo no modelo
                    ini.AppendLine($"xMunDescarga=São Paulo"); // TODO: idem
                    ini.AppendLine();

                    ini.AppendLine($"[infCTe{docIndex:D3}001]");
                    ini.AppendLine($"chCTe={chave}");
                    ini.AppendLine();

                    docIndex++;
                }
            }

            // NFe
            if (!string.IsNullOrEmpty(mdfe.DocumentosNFeJson))
            {
                var chavesNFe = System.Text.Json.JsonSerializer.Deserialize<List<string>>(mdfe.DocumentosNFeJson);

                foreach (var chave in chavesNFe ?? new List<string>())
                {
                    ini.AppendLine($"[infDoc{docIndex:D3}]");
                    ini.AppendLine($"cMunDescarga=3550308"); // TODO: idem
                    ini.AppendLine($"xMunDescarga=São Paulo");
                    ini.AppendLine();

                    ini.AppendLine($"[infNFe{docIndex:D3}001]");
                    ini.AppendLine($"chNFe={chave}");
                    ini.AppendLine();

                    docIndex++;
                }
            }
        }

        public string GerarIniEvento(string tipoEvento, MDFe mdfe, Dictionary<string, string> parametrosEvento)
        {
            var ini = new StringBuilder();

            ini.AppendLine("[EVENTO]");
            ini.AppendLine($"idLote={parametrosEvento.GetValueOrDefault("idLote", "1")}");
            ini.AppendLine();

            ini.AppendLine("[EVENTO001]");
            ini.AppendLine($"cOrgao={ObterCodigoUF(mdfe.EmitenteUf)}");
            ini.AppendLine($"CNPJCPF={mdfe.EmitenteCnpj ?? mdfe.EmitenteCpf}");
            ini.AppendLine($"chMDFe={mdfe.ChaveAcesso}");
            ini.AppendLine($"dhEvento={DateTime.Now:yyyy-MM-ddTHH:mm:sszzz}");
            ini.AppendLine($"tpEvento={tipoEvento}");
            ini.AppendLine($"nSeqEvento={parametrosEvento.GetValueOrDefault("nSeqEvento", "1")}");
            ini.AppendLine($"versaoEvento=3.00");

            // Campos específicos por tipo de evento
            switch (tipoEvento)
            {
                case "110111": // Cancelamento
                    ini.AppendLine($"nProt={mdfe.Protocolo}");
                    ini.AppendLine($"xJust={parametrosEvento["xJust"]}");
                    break;

                case "110112": // Encerramento
                    ini.AppendLine($"nProt={mdfe.Protocolo}");
                    ini.AppendLine($"dtEnc={parametrosEvento["dtEnc"]}");
                    ini.AppendLine($"cUF={ObterCodigoUF(parametrosEvento["UFEnc"])}");
                    ini.AppendLine($"cMun={parametrosEvento["cMun"]}");
                    break;

                case "110114": // Inclusão de Condutor
                    ini.AppendLine($"xNome={parametrosEvento["xNome"]}");
                    ini.AppendLine($"CPF={parametrosEvento["CPF"]}");
                    break;
            }

            ini.AppendLine();

            return ini.ToString();
        }

        // Métodos auxiliares
        private string ObterCodigoUF(string uf)
        {
            var codigosUF = new Dictionary<string, string>
            {
                {"AC", "12"}, {"AL", "27"}, {"AP", "16"}, {"AM", "13"},
                {"BA", "29"}, {"CE", "23"}, {"DF", "53"}, {"ES", "32"},
                {"GO", "52"}, {"MA", "21"}, {"MT", "51"}, {"MS", "50"},
                {"MG", "31"}, {"PA", "15"}, {"PB", "25"}, {"PR", "41"},
                {"PE", "26"}, {"PI", "22"}, {"RJ", "33"}, {"RN", "24"},
                {"RS", "43"}, {"RO", "11"}, {"RR", "14"}, {"SC", "42"},
                {"SP", "35"}, {"SE", "28"}, {"TO", "17"}
            };

            return codigosUF.GetValueOrDefault(uf, "35"); // Default SP
        }

        private string GerarCodigoAleatorio()
        {
            return new Random().Next(10000000, 99999999).ToString();
        }
    }
}
```

---

### FASE 3: ATUALIZAR MDFeService

#### 3.1 - Implementar Métodos SEFAZ Reais

**Arquivo:** `MDFe.Api/Services/MDFeService.cs`

Substituir os métodos placeholder (linhas 138-193) por implementações reais:

```csharp
private readonly IACBrMonitorClient _acbrClient;
private readonly IACBrResponseParser _acbrParser;
private readonly IMDFeIniGenerator _iniGenerator;
private readonly IConfiguration _configuration;

// Atualizar construtor
public MDFeService(
    MDFeContext context,
    ILogger<MDFeService> logger,
    IACBrMonitorClient acbrClient,
    IACBrResponseParser acbrParser,
    IMDFeIniGenerator iniGenerator,
    IConfiguration configuration)
{
    _context = context;
    _logger = logger;
    _acbrClient = acbrClient;
    _acbrParser = acbrParser;
    _iniGenerator = iniGenerator;
    _configuration = configuration;
}

public async Task<string> GerarXmlAsync(int mdfeId)
{
    var mdfe = await GetByIdAsync(mdfeId);
    if (mdfe == null)
        throw new InvalidOperationException($"MDFe {mdfeId} não encontrado");

    try
    {
        // 1. Gerar INI
        var conteudoIni = await _iniGenerator.GerarIniAsync(mdfe);

        // 2. Salvar INI temporariamente
        var pathTemp = Path.Combine(Path.GetTempPath(), $"mdfe_{mdfeId}.ini");
        await File.WriteAllTextAsync(pathTemp, conteudoIni, Encoding.GetEncoding("ISO-8859-1"));

        // 3. Enviar comando CriarMDFe
        var comando = $"MDFE.CriarMDFe({pathTemp})";
        var resposta = await _acbrClient.ExecutarComandoAsync(comando);

        // 4. Parsear resposta
        var resultado = _acbrParser.ParseResposta(resposta);

        if (!resultado.Sucesso)
            throw new InvalidOperationException($"Erro ao gerar XML: {resultado.Mensagem}");

        // 5. Ler XML gerado (ACBr salva no PathSalvar configurado)
        // TODO: Obter caminho correto do XML gerado pelo ACBr
        var xmlPath = resultado.XmlGerado ?? "";

        // 6. Atualizar MDFe
        mdfe.XmlGerado = await File.ReadAllTextAsync(xmlPath);
        mdfe.StatusSefaz = "XML_GERADO";
        await _context.SaveChangesAsync();

        _logger.LogInformation("XML gerado com sucesso para MDFe {Id}", mdfeId);
        return mdfe.XmlGerado;
    }
    catch (Exception ex)
    {
        _logger.LogError(ex, "Erro ao gerar XML do MDFe {Id}", mdfeId);
        throw;
    }
}

public async Task<object> TransmitirAsync(int mdfeId)
{
    var mdfe = await GetByIdAsync(mdfeId);
    if (mdfe == null)
        throw new InvalidOperationException($"MDFe {mdfeId} não encontrado");

    try
    {
        // 1. Gerar INI
        var conteudoIni = await _iniGenerator.GerarIniAsync(mdfe);
        var pathTemp = Path.Combine(Path.GetTempPath(), $"mdfe_{mdfeId}.ini");
        await File.WriteAllTextAsync(pathTemp, conteudoIni, Encoding.GetEncoding("ISO-8859-1"));

        // 2. Enviar comando CriarEnviarMDFe (tudo em um só comando)
        var lote = mdfe.Lote ?? 1;
        var comando = $"MDFE.CriarEnviarMDFe({pathTemp}, {lote})";
        var resposta = await _acbrClient.ExecutarComandoAsync(comando);

        // 3. Parsear resposta
        var resultado = _acbrParser.ParseResposta(resposta);

        if (!resultado.Sucesso)
        {
            mdfe.StatusSefaz = "REJEITADO";
            mdfe.XmlRetorno = resultado.RespostaBruta;
            await _context.SaveChangesAsync();

            return new {
                sucesso = false,
                mensagem = resultado.Mensagem,
                erros = resultado.Erros
            };
        }

        // 4. Atualizar MDFe com dados da SEFAZ
        mdfe.ChaveAcesso = resultado.ChaveMDFe;
        mdfe.Protocolo = resultado.Protocolo;
        mdfe.StatusSefaz = "AUTORIZADO";
        mdfe.DataAutorizacao = DateTime.Now;
        mdfe.XmlRetorno = resultado.RespostaBruta;
        await _context.SaveChangesAsync();

        _logger.LogInformation("MDFe {Id} transmitido com sucesso. Chave: {Chave}", mdfeId, resultado.ChaveMDFe);

        return new
        {
            sucesso = true,
            mensagem = "MDFe autorizado com sucesso",
            chave = resultado.ChaveMDFe,
            protocolo = resultado.Protocolo,
            dataAutorizacao = mdfe.DataAutorizacao
        };
    }
    catch (Exception ex)
    {
        _logger.LogError(ex, "Erro ao transmitir MDFe {Id}", mdfeId);
        mdfe.StatusSefaz = "ERRO_TRANSMISSAO";
        await _context.SaveChangesAsync();
        throw;
    }
}

public async Task<object> CancelarAsync(int mdfeId, string justificativa)
{
    if (justificativa.Length < 15)
        throw new ArgumentException("Justificativa deve ter no mínimo 15 caracteres");

    var mdfe = await GetByIdAsync(mdfeId);
    if (mdfe == null)
        throw new InvalidOperationException($"MDFe {mdfeId} não encontrado");

    if (mdfe.StatusSefaz != "AUTORIZADO")
        throw new InvalidOperationException("Apenas MDFe autorizados podem ser cancelados");

    try
    {
        // 1. Gerar INI do evento de cancelamento
        var parametros = new Dictionary<string, string>
        {
            { "xJust", justificativa }
        };

        var iniEvento = _iniGenerator.GerarIniEvento("110111", mdfe, parametros);
        var pathTemp = Path.Combine(Path.GetTempPath(), $"evento_cancel_{mdfeId}.ini");
        await File.WriteAllTextAsync(pathTemp, iniEvento, Encoding.GetEncoding("ISO-8859-1"));

        // 2. Enviar evento
        var comando = $"MDFE.EnviarEvento({pathTemp})";
        var resposta = await _acbrClient.ExecutarComandoAsync(comando);

        // 3. Processar resposta
        var resultado = _acbrParser.ParseResposta(resposta);

        if (resultado.Sucesso)
        {
            mdfe.StatusSefaz = "CANCELADO";
            await _context.SaveChangesAsync();

            return new { sucesso = true, mensagem = "MDFe cancelado com sucesso" };
        }
        else
        {
            return new { sucesso = false, mensagem = resultado.Mensagem, erros = resultado.Erros };
        }
    }
    catch (Exception ex)
    {
        _logger.LogError(ex, "Erro ao cancelar MDFe {Id}", mdfeId);
        throw;
    }
}

public async Task<object> EncerrarAsync(int mdfeId, string protocoloEnc)
{
    var mdfe = await GetByIdAsync(mdfeId);
    if (mdfe == null)
        throw new InvalidOperationException($"MDFe {mdfeId} não encontrado");

    // TODO: Receber parâmetros completos (dtEnc, cUF, cMun)
    var parametros = new Dictionary<string, string>
    {
        { "dtEnc", DateTime.Now.ToString("yyyy-MM-dd") },
        { "UFEnc", "SP" },
        { "cMun", "3550308" }
    };

    var iniEvento = _iniGenerator.GerarIniEvento("110112", mdfe, parametros);
    var pathTemp = Path.Combine(Path.GetTempPath(), $"evento_enc_{mdfeId}.ini");
    await File.WriteAllTextAsync(pathTemp, iniEvento, Encoding.GetEncoding("ISO-8859-1"));

    var comando = $"MDFE.EnviarEvento({pathTemp})";
    var resposta = await _acbrClient.ExecutarComandoAsync(comando);
    var resultado = _acbrParser.ParseResposta(resposta);

    if (resultado.Sucesso)
    {
        mdfe.StatusSefaz = "ENCERRADO";
        await _context.SaveChangesAsync();
    }

    return new { sucesso = resultado.Sucesso, mensagem = resultado.Mensagem };
}

public async Task<object> ConsultarStatusServicoAsync(string uf)
{
    var comando = "MDFE.StatusServico";
    var resposta = await _acbrClient.ExecutarComandoAsync(comando);
    var resultado = _acbrParser.ParseResposta(resposta);

    return new { sucesso = resultado.Sucesso, mensagem = resultado.Mensagem };
}

public async Task<object> ConsultarPorChaveAsync(string chave)
{
    var comando = $"MDFE.ConsultarMDFe({chave})";
    var resposta = await _acbrClient.ExecutarComandoAsync(comando);
    var resultado = _acbrParser.ParseResposta(resposta);

    return new { sucesso = resultado.Sucesso, dados = resultado.RespostaBruta };
}
```

---

### FASE 4: CONFIGURAÇÃO

#### 4.1 - Atualizar appsettings.json

**Arquivo:** `MDFe.Api/appsettings.json`

```json
{
  "ACBrMonitor": {
    "Host": "127.0.0.1",
    "Port": 3434,
    "Timeout": 30000
  },
  "ACBrMDFe": {
    "TipoAmbiente": 2,
    "PathTemporario": "C:\\Temp\\MDFe",
    "PathLogs": "C:\\ACBrMonitor\\Logs",
    "PathSalvar": "C:\\ACBrMonitor\\MDFe"
  }
}
```

#### 4.2 - Registrar Dependências

**Arquivo:** `MDFe.Api/Program.cs` (após linha 88)

```csharp
// Registrar serviços ACBr
builder.Services.AddSingleton<IACBrMonitorClient>(provider =>
{
    var logger = provider.GetRequiredService<ILogger<ACBrMonitorClient>>();
    var host = builder.Configuration["ACBrMonitor:Host"] ?? "127.0.0.1";
    var port = builder.Configuration.GetValue<int>("ACBrMonitor:Port", 3434);
    var timeout = builder.Configuration.GetValue<int>("ACBrMonitor:Timeout", 30000);

    return new ACBrMonitorClient(host, port, timeout, logger);
});

builder.Services.AddScoped<IACBrResponseParser, ACBrResponseParser>();
builder.Services.AddScoped<IMDFeIniGenerator, MDFeIniGenerator>();
```

---

### FASE 5: TESTES

#### 5.1 - Health Check do ACBr Monitor

**Arquivo:** `MDFe.Api/HealthChecks/ACBrMonitorHealthCheck.cs`

```csharp
using Microsoft.Extensions.Diagnostics.HealthChecks;
using MDFeApi.Services;

namespace MDFeApi.HealthChecks
{
    public class ACBrMonitorHealthCheck : IHealthCheck
    {
        private readonly IACBrMonitorClient _acbrClient;

        public ACBrMonitorHealthCheck(IACBrMonitorClient acbrClient)
        {
            _acbrClient = acbrClient;
        }

        public async Task<HealthCheckResult> CheckHealthAsync(
            HealthCheckContext context,
            CancellationToken cancellationToken = default)
        {
            try
            {
                var conectado = await _acbrClient.TestarConexaoAsync();

                if (conectado)
                {
                    return HealthCheckResult.Healthy("ACBrMonitor está ativo e respondendo");
                }
                else
                {
                    return HealthCheckResult.Unhealthy("ACBrMonitor não está respondendo");
                }
            }
            catch (Exception ex)
            {
                return HealthCheckResult.Unhealthy("Erro ao conectar no ACBrMonitor", ex);
            }
        }
    }
}
```

Registrar no Program.cs:

```csharp
builder.Services.AddHealthChecks()
    .AddCheck<ACBrMonitorHealthCheck>("acbr_monitor", tags: new[] { "acbr", "ready" });
```

---

## 📝 CHECKLIST DE IMPLEMENTAÇÃO

### Arquivos a Criar
- [ ] `MDFe.Api/DTOs/ACBrDTOs.cs`
- [ ] `MDFe.Api/Services/ACBrMonitorClient.cs`
- [ ] `MDFe.Api/Services/ACBrResponseParser.cs`
- [ ] `MDFe.Api/Services/MDFeIniGenerator.cs`
- [ ] `MDFe.Api/HealthChecks/ACBrMonitorHealthCheck.cs`

### Arquivos a Modificar
- [ ] `MDFe.Api/Models/MDFe.cs` (adicionar PesoBrutoTotal, QuantidadeCTe, QuantidadeNFe, Lote)
- [ ] `MDFe.Api/Services/MDFeService.cs` (substituir placeholders)
- [ ] `MDFe.Api/Program.cs` (registrar dependências)
- [ ] `MDFe.Api/appsettings.json` (adicionar configurações ACBrMonitor)

### Migrations
- [ ] Criar migration para novos campos
- [ ] Aplicar migration no banco

### Configuração ACBrMonitor
- [ ] Abrir ACBrMonitorPLUS
- [ ] Configurar certificado digital (Aba DFe)
- [ ] Ativar servidor TCP/IP porta 3434
- [ ] Configurar ambiente (Homologação/Produção)
- [ ] Testar conectividade

### Testes
- [ ] Testar conexão TCP/IP com ACBrMonitor
- [ ] Testar geração de INI
- [ ] Testar criação de XML
- [ ] Testar transmissão (Homologação)
- [ ] Testar consulta de status
- [ ] Testar cancelamento
- [ ] Testar encerramento

---

## 🚨 PONTOS DE ATENÇÃO

### 1. Encoding
**SEMPRE usar ISO-8859-1** na comunicação com ACBr e escrita de arquivos INI.

### 2. Município de Descarga
Atualmente hardcoded como "São Paulo" (3550308). **Necessário**:
- Adicionar campo `MunicipioDescarregamentoId` no modelo MDFe
- Ou extrair automaticamente dos documentos (CTe/NFe)

### 3. Reboques
Modelo já tem `ICollection<Reboque>`, mas precisa adicionar no gerador INI:
```ini
[reboque001]
placa=ABC1234
tara=5000
UF=SP
```

### 4. Percurso de UFs
Já armazenado em `PercursosJson`, incluir no INI como `UFPer001`, `UFPer002`, etc.

### 5. Validações
Antes de transmitir, validar:
- [ ] PesoBrutoTotal > 0
- [ ] QuantidadeCTe ou QuantidadeNFe > 0
- [ ] Certificado digital válido
- [ ] ACBrMonitor rodando

### 6. Ambiente SEFAZ
Configurar via `appsettings.json`:
- `tpAmb=1` → Produção
- `tpAmb=2` → Homologação

**SEMPRE testar em HOMOLOGAÇÃO primeiro!**

---

## 📚 REFERÊNCIAS

- Documentação ACBr Monitor: `docs/documentacao.md`
- Manual SEFAZ MDFe: https://www.sefaz.rs.gov.br/MDFE/MDFE-MOC.aspx
- Schema MDFe 3.00: Fornecido pelo ACBr
- Guia de emissão: Seção 9 da documentação

---

## 🎯 PRÓXIMOS PASSOS

Após implementação básica funcionar:

1. **Melhorias no Frontend**
   - Adicionar campo "Peso Bruto Total" no formulário
   - Calcular automaticamente quantidades de CTe/NFe
   - Validar dados antes de enviar

2. **Impressão de DAMDFe**
   - Implementar `MDFE.ImprimirDAMDFePDF()`
   - Download automático do PDF

3. **Consultas Avançadas**
   - Distribuição DFe
   - Consulta por placa

4. **Eventos Adicionais**
   - Inclusão de Condutor (110114)
   - Inclusão de DFe (110115)
   - Pagamento Operação (110116)

5. **Auditoria e Logs**
   - Salvar todos os XMLs enviados/recebidos
   - Log completo de comunicação SEFAZ

6. **Contingência**
   - Implementar emissão em contingência (tpEmis=2)

---

**Versão:** 1.0
**Última Atualização:** 02/10/2025
