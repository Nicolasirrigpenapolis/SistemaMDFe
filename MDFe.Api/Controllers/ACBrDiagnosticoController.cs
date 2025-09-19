using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using MDFeApi.Data;
using MDFeApi.Services;
using Microsoft.EntityFrameworkCore;

namespace MDFeApi.Controllers
{
    /// <summary>
    /// Controller para diagnóstico e validação da integração ACBr
    /// </summary>
    [ApiController]
    [Route("api/[controller]")]
    [Authorize]
    public class ACBrDiagnosticoController : ControllerBase
    {
        private readonly MDFeContext _context;
        private readonly IACBrMDFeService _acbrService;
        private readonly ACBrMDFeConfiguration _acbrConfig;
        private readonly ILogger<ACBrDiagnosticoController> _logger;

        public ACBrDiagnosticoController(
            MDFeContext context, 
            IACBrMDFeService acbrService, 
            ACBrMDFeConfiguration acbrConfig,
            ILogger<ACBrDiagnosticoController> logger)
        {
            _context = context;
            _acbrService = acbrService;
            _acbrConfig = acbrConfig;
            _logger = logger;
        }

        /// <summary>
        /// Testa a conectividade com os serviços SEFAZ
        /// </summary>
        [HttpGet("status-sefaz/{codigoUf}")]
        public async Task<IActionResult> TestarStatusSEFAZ(int codigoUf)
        {
            try
            {
                var resultado = await _acbrService.ConsultarStatusServicoAsync(codigoUf);
                
                var diagnostico = new
                {
                    CodigoUf = codigoUf,
                    DataTeste = DateTime.Now,
                    Resultado = resultado,
                    Status = resultado.Contains("cStat>107") ? "Online" : "Offline",
                    Sucesso = true
                };

                return Ok(diagnostico);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao testar status SEFAZ para UF {CodigoUf}", codigoUf);
                
                return Ok(new
                {
                    CodigoUf = codigoUf,
                    DataTeste = DateTime.Now,
                    Erro = ex.Message,
                    Status = "Erro",
                    Sucesso = false
                });
            }
        }

        /// <summary>
        /// Valida a configuração completa do ACBr para um emitente
        /// </summary>
        [HttpGet("validar-emitente/{emitenteId}")]
        public async Task<IActionResult> ValidarConfiguracao(int emitenteId)
        {
            try
            {
                var emitente = await _context.Emitentes.FindAsync(emitenteId);
                if (emitente == null)
                    return NotFound(new { message = "Emitente não encontrado" });

                var validacao = _acbrConfig.ValidarConfiguracaoCompleta();
                
                var resultado = new
                {
                    EmitenteId = emitenteId,
                    EmitenteNome = emitente.RazaoSocial,
                    DataValidacao = DateTime.Now,
                    Aprovado = validacao,
                    TotalErros = validacao ? 0 : 1,
                    TotalAvisos = 0,
                    Erros = validacao ? new List<string>() : new List<string> { "Configuração ACBr incompleta" },
                    Avisos = new List<string>(),
                    Informacoes = new List<string> { validacao ? "Configuração válida" : "Configuração inválida" },
                    RelatorioCompleto = validacao ? "Configuração OK" : "Configuração com problemas"
                };

                return Ok(resultado);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao validar configuração do emitente {EmitenteId}", emitenteId);
                return StatusCode(500, new { message = "Erro interno", error = ex.Message });
            }
        }

        /// <summary>
        /// Testa o certificado digital de um emitente
        /// </summary>
        [HttpGet("validar-certificado/{emitenteId}")]
        public async Task<IActionResult> ValidarCertificado(int emitenteId)
        {
            try
            {
                var emitente = await _context.Emitentes.FindAsync(emitenteId);
                if (emitente == null)
                    return NotFound(new { message = "Emitente não encontrado" });

                var certificadoValido = await _acbrService.ValidarCertificadoAsync();

                var diagnostico = new
                {
                    EmitenteId = emitenteId,
                    EmitenteNome = emitente.RazaoSocial,
                    CaminhoArquivo = emitente.CaminhoArquivoCertificado,
                    DataValidacao = DateTime.Now,
                    CertificadoValido = certificadoValido,
                    ArquivoExiste = !string.IsNullOrEmpty(emitente.CaminhoArquivoCertificado) &&
                                   System.IO.File.Exists(emitente.CaminhoArquivoCertificado),
                    SenhaConfigurada = !string.IsNullOrEmpty(emitente.SenhaCertificado)
                };

                return Ok(diagnostico);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao validar certificado do emitente {EmitenteId}", emitenteId);
                return StatusCode(500, new { message = "Erro ao validar certificado", error = ex.Message });
            }
        }

        /// <summary>
        /// Gera relatório completo de diagnóstico do sistema
        /// </summary>
        [HttpGet("diagnostico-completo")]
        public async Task<IActionResult> DiagnosticoCompleto()
        {
            try
            {
                var diagnostico = new
                {
                    DataDiagnostico = DateTime.Now,
                    VersaoSistema = "1.0.0",
                    Ambiente = Environment.MachineName,
                    
                    // Verificar emitentes cadastrados
                    TotalEmitentes = await _context.Emitentes.CountAsync(e => e.Ativo),
                    EmitentesComCertificado = await _context.Emitentes.CountAsync(e => e.Ativo && !string.IsNullOrEmpty(e.CaminhoArquivoCertificado)),
                    
                    // Verificar outros cadastros
                    TotalVeiculos = await _context.Veiculos.CountAsync(v => v.Ativo),
                    TotalCondutores = await _context.Condutores.CountAsync(c => c.Ativo),
                    TotalMDFes = await _context.MDFes.CountAsync(),
                    
                    // Status dos MDFes
                    MDFesPorStatus = await _context.MDFes
                        .GroupBy(m => m.StatusSefaz)
                        .Select(g => new { Status = g.Key, Quantidade = g.Count() })
                        .ToListAsync(),
                    
                    // Verificar diretórios ACBr
                    DiretoriosACBr = VerificarDiretoriosACBr(),
                    
                    // Verificar DLL ACBr
                    DllACBr = VerificarDllACBr()
                };

                return Ok(diagnostico);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao gerar diagnóstico completo");
                return StatusCode(500, new { message = "Erro no diagnóstico", error = ex.Message });
            }
        }

        /// <summary>
        /// Testa a geração de um INI de exemplo
        /// </summary>
        [HttpPost("testar-ini")]
        public async Task<IActionResult> TestarGeracaoINI([FromBody] TestarINIRequest request)
        {
            try
            {
                var mdfe = await _context.MDFes
                    .Include(m => m.Emitente)
                    .Include(m => m.Condutor)
                    .Include(m => m.Veiculo)
                    .Include(m => m.MunicipioCarregamento)
                    .FirstOrDefaultAsync(m => m.Id == request.MDFeId);

                if (mdfe == null)
                    return NotFound(new { message = "MDFe não encontrado" });

                // Simular geração do INI sem usar ACBr
                var iniContent = GerarINITeste(mdfe);

                return Ok(new
                {
                    MDFeId = request.MDFeId,
                    DataTeste = DateTime.Now,
                    INIGerado = iniContent,
                    Sucesso = true,
                    TamanhoINI = iniContent.Length
                });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao testar geração de INI para MDFe {MDFeId}", request.MDFeId);
                return StatusCode(500, new { message = "Erro ao gerar INI", error = ex.Message });
            }
        }

        private object VerificarDiretoriosACBr()
        {
            var baseDir = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "ACBr");
            var diretorios = new[] { "Esquemas", "GeralMDFe", "Logs", "Temp", "PDF" };

            return new
            {
                DiretorioBase = baseDir,
                DiretorioBaseExiste = Directory.Exists(baseDir),
                Subdiretorios = diretorios.Select(dir => new
                {
                    Nome = dir,
                    Caminho = Path.Combine(baseDir, dir),
                    Existe = Directory.Exists(Path.Combine(baseDir, dir))
                }).ToList()
            };
        }

        private object VerificarDllACBr()
        {
            var dllPaths = new[]
            {
                "ACBrMDFe32.dll",
                "ACBrMDFe64.dll",
                Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "ACBrMDFe32.dll"),
                Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "ACBrMDFe64.dll")
            };

            return new
            {
                CaminhosPesquisados = dllPaths,
                ArquivosEncontrados = dllPaths.Where(System.IO.File.Exists).ToList(),
                RecomendacaoInstalacao = "Copie a DLL ACBrMDFe32.dll para o diretório da aplicação"
            };
        }

        private string GerarINITeste(Models.MDFe mdfe)
        {
            var ini = new System.Text.StringBuilder();
            
            ini.AppendLine("[MDFe]");
            ini.AppendLine($"cUF=35"); // São Paulo como exemplo
            ini.AppendLine($"tpAmb={mdfe.Emitente.AmbienteSefaz}");
            ini.AppendLine($"tpEmit={mdfe.TipoTransportador}");
            ini.AppendLine($"serie={mdfe.Serie}");
            ini.AppendLine($"nMDF={mdfe.NumeroMdfe}");
            ini.AppendLine($"modal={mdfe.Modal}");
            ini.AppendLine($"dhEmi={mdfe.DataEmissao:yyyy-MM-ddTHH:mm:ss-03:00}");
            ini.AppendLine("tpEmis=1");
            ini.AppendLine("procEmi=0");
            ini.AppendLine("verProc=3.00");
            ini.AppendLine($"UFIni={mdfe.UfInicio}");
            ini.AppendLine($"UFFim={mdfe.UfFim}");
            ini.AppendLine();
            
            ini.AppendLine("[emit]");
            ini.AppendLine($"CNPJCPF={mdfe.Emitente.Cnpj?.Replace(".", "").Replace("/", "").Replace("-", "")}");
            ini.AppendLine($"IE={mdfe.Emitente.Ie}");
            ini.AppendLine($"xNome={mdfe.Emitente.RazaoSocial}");
            ini.AppendLine($"xFant={mdfe.Emitente.NomeFantasia ?? mdfe.Emitente.RazaoSocial}");
            ini.AppendLine($"xLgr={mdfe.Emitente.Endereco}");
            ini.AppendLine($"nro={mdfe.Emitente.Numero ?? "S/N"}");
            ini.AppendLine($"xBairro={mdfe.Emitente.Bairro}");
            ini.AppendLine($"cMun={mdfe.Emitente.CodMunicipio}");
            ini.AppendLine($"xMun={mdfe.Emitente.Municipio}");
            ini.AppendLine($"CEP={mdfe.Emitente.Cep?.Replace("-", "")}");
            ini.AppendLine($"UF={mdfe.Emitente.Uf}");
            ini.AppendLine($"fone={mdfe.Emitente.Telefone ?? ""}");
            ini.AppendLine($"email={mdfe.Emitente.Email ?? ""}");
            ini.AppendLine();

            ini.AppendLine("[veicTracao]");
            ini.AppendLine("cInt=001");
            ini.AppendLine($"placa={mdfe.Veiculo.Placa}");
            ini.AppendLine($"RENAVAM={mdfe.Veiculo.Renavam ?? ""}");
            ini.AppendLine($"tara={mdfe.Veiculo.Tara}");
            ini.AppendLine($"capKG={mdfe.Veiculo.CapacidadeKg ?? 0}");
            
            ini.AppendLine($"tpRod={mdfe.Veiculo.TipoRodado}");
            ini.AppendLine($"tpCar={mdfe.Veiculo.TipoCarroceria}");
            ini.AppendLine($"UF={mdfe.Veiculo.Uf}");
            ini.AppendLine();

            ini.AppendLine("[condutor001]");
            ini.AppendLine($"xNome={mdfe.Condutor.Nome}");
            ini.AppendLine($"CPF={mdfe.Condutor.Cpf?.Replace(".", "").Replace("-", "")}");

            return ini.ToString();
        }
    }

    public class TestarINIRequest
    {
        public int MDFeId { get; set; }
    }
}