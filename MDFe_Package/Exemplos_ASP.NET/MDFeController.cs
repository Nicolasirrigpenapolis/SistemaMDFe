using Microsoft.AspNetCore.Mvc;
using SeuProjeto.Services;

namespace SeuProjeto.Controllers
{
    /// <summary>
    /// Controller para operações de MDFe - Modal Rodoviário
    /// </summary>
    [ApiController]
    [Route("api/[controller]")]
    public class MDFeController : ControllerBase
    {
        private readonly IMDFeService _mdfeService;
        private readonly ILogger<MDFeController> _logger;

        public MDFeController(IMDFeService mdfeService, ILogger<MDFeController> logger)
        {
            _mdfeService = mdfeService;
            _logger = logger;
        }

        /// <summary>
        /// Gera um novo MDFe rodoviário
        /// </summary>
        /// <param name="request">Dados do MDFe</param>
        /// <returns>XML do MDFe gerado</returns>
        [HttpPost("gerar")]
        public async Task<ActionResult<MDFeResponse>> GerarMDFe([FromBody] GerarMDFeRequest request)
        {
            try
            {
                _logger.LogInformation("Gerando MDFe para placa: {placa}", request.PlacaVeiculo);

                // Criar template temporário com os dados
                var templatePath = await CriarTemplateTemporario(request);

                // Gerar MDFe
                var xmlGerado = _mdfeService.GerarMDFe(templatePath);

                // Limpar arquivo temporário
                if (System.IO.File.Exists(templatePath))
                    System.IO.File.Delete(templatePath);

                return Ok(new MDFeResponse
                {
                    Sucesso = true,
                    XmlMDFe = xmlGerado,
                    Mensagem = "MDFe gerado com sucesso"
                });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao gerar MDFe");
                return BadRequest(new MDFeResponse
                {
                    Sucesso = false,
                    Mensagem = ex.Message
                });
            }
        }

        /// <summary>
        /// Transmite um MDFe para a SEFAZ
        /// </summary>
        /// <param name="request">Dados da transmissão</param>
        /// <returns>Resultado da transmissão</returns>
        [HttpPost("transmitir")]
        public ActionResult<MDFeResponse> TransmitirMDFe([FromBody] TransmitirMDFeRequest request)
        {
            try
            {
                _logger.LogInformation("Transmitindo MDFe - Lote: {lote}", request.NumeroLote);

                var resultado = _mdfeService.TransmitirMDFe(request.NumeroLote);

                return Ok(new MDFeResponse
                {
                    Sucesso = true,
                    XmlRetorno = resultado,
                    Mensagem = "MDFe transmitido com sucesso"
                });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao transmitir MDFe");
                return BadRequest(new MDFeResponse
                {
                    Sucesso = false,
                    Mensagem = ex.Message
                });
            }
        }

        /// <summary>
        /// Consulta um MDFe pela chave
        /// </summary>
        /// <param name="chave">Chave de acesso do MDFe</param>
        /// <returns>Dados do MDFe</returns>
        [HttpGet("consultar/{chave}")]
        public ActionResult<MDFeResponse> ConsultarMDFe(string chave)
        {
            try
            {
                _logger.LogInformation("Consultando MDFe: {chave}", chave);

                if (string.IsNullOrWhiteSpace(chave) || chave.Length != 44)
                    return BadRequest(new MDFeResponse { Sucesso = false, Mensagem = "Chave de acesso inválida" });

                var resultado = _mdfeService.ConsultarMDFe(chave);

                return Ok(new MDFeResponse
                {
                    Sucesso = true,
                    XmlRetorno = resultado,
                    Mensagem = "MDFe consultado com sucesso"
                });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao consultar MDFe");
                return BadRequest(new MDFeResponse
                {
                    Sucesso = false,
                    Mensagem = ex.Message
                });
            }
        }

        /// <summary>
        /// Cancela um MDFe
        /// </summary>
        /// <param name="request">Dados do cancelamento</param>
        /// <returns>Resultado do cancelamento</returns>
        [HttpPost("cancelar")]
        public ActionResult<MDFeResponse> CancelarMDFe([FromBody] CancelarMDFeRequest request)
        {
            try
            {
                _logger.LogInformation("Cancelando MDFe: {chave}", request.ChaveMDFe);

                if (string.IsNullOrWhiteSpace(request.ChaveMDFe) || request.ChaveMDFe.Length != 44)
                    return BadRequest(new MDFeResponse { Sucesso = false, Mensagem = "Chave de acesso inválida" });

                if (string.IsNullOrWhiteSpace(request.Justificativa) || request.Justificativa.Length < 15)
                    return BadRequest(new MDFeResponse { Sucesso = false, Mensagem = "Justificativa deve ter no mínimo 15 caracteres" });

                var resultado = _mdfeService.CancelarMDFe(request.ChaveMDFe, request.Justificativa);

                return Ok(new MDFeResponse
                {
                    Sucesso = true,
                    XmlRetorno = resultado,
                    Mensagem = "MDFe cancelado com sucesso"
                });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao cancelar MDFe");
                return BadRequest(new MDFeResponse
                {
                    Sucesso = false,
                    Mensagem = ex.Message
                });
            }
        }

        /// <summary>
        /// Encerra um MDFe
        /// </summary>
        /// <param name="request">Dados do encerramento</param>
        /// <returns>Resultado do encerramento</returns>
        [HttpPost("encerrar")]
        public ActionResult<MDFeResponse> EncerrarMDFe([FromBody] EncerrarMDFeRequest request)
        {
            try
            {
                _logger.LogInformation("Encerrando MDFe: {chave}", request.ChaveMDFe);

                if (string.IsNullOrWhiteSpace(request.ChaveMDFe) || request.ChaveMDFe.Length != 44)
                    return BadRequest(new MDFeResponse { Sucesso = false, Mensagem = "Chave de acesso inválida" });

                var resultado = _mdfeService.EncerrarMDFe(request.ChaveMDFe, request.CodigoMunicipioDestino);

                return Ok(new MDFeResponse
                {
                    Sucesso = true,
                    XmlRetorno = resultado,
                    Mensagem = "MDFe encerrado com sucesso"
                });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao encerrar MDFe");
                return BadRequest(new MDFeResponse
                {
                    Sucesso = false,
                    Mensagem = ex.Message
                });
            }
        }

        /// <summary>
        /// Consulta status do serviço SEFAZ
        /// </summary>
        /// <returns>Status do serviço</returns>
        [HttpGet("status-servico")]
        public ActionResult<MDFeResponse> StatusServico()
        {
            try
            {
                var resultado = _mdfeService.StatusServico();

                return Ok(new MDFeResponse
                {
                    Sucesso = true,
                    XmlRetorno = resultado,
                    Mensagem = "Status consultado com sucesso"
                });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao consultar status do serviço");
                return BadRequest(new MDFeResponse
                {
                    Sucesso = false,
                    Mensagem = ex.Message
                });
            }
        }

        /// <summary>
        /// Consulta MDFes não encerrados
        /// </summary>
        /// <param name="cnpj">CNPJ da transportadora</param>
        /// <returns>Lista de MDFes não encerrados</returns>
        [HttpGet("nao-encerrados/{cnpj}")]
        public ActionResult<MDFeResponse> ConsultarNaoEncerrados(string cnpj)
        {
            try
            {
                _logger.LogInformation("Consultando não encerrados: {cnpj}", cnpj);

                if (string.IsNullOrWhiteSpace(cnpj))
                    return BadRequest(new MDFeResponse { Sucesso = false, Mensagem = "CNPJ é obrigatório" });

                var resultado = _mdfeService.ConsultarNaoEncerrados(cnpj);

                return Ok(new MDFeResponse
                {
                    Sucesso = true,
                    XmlRetorno = resultado,
                    Mensagem = "Consulta realizada com sucesso"
                });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao consultar não encerrados");
                return BadRequest(new MDFeResponse
                {
                    Sucesso = false,
                    Mensagem = ex.Message
                });
            }
        }

        /// <summary>
        /// Configura certificado digital
        /// </summary>
        /// <param name="request">Dados do certificado</param>
        /// <returns>Resultado da configuração</returns>
        [HttpPost("configurar-certificado")]
        public ActionResult<MDFeResponse> ConfigurarCertificado([FromBody] ConfigurarCertificadoRequest request)
        {
            try
            {
                _logger.LogInformation("Configurando certificado");

                _mdfeService.ConfigurarCertificado(request.NumeroCertificado, request.Senha);

                return Ok(new MDFeResponse
                {
                    Sucesso = true,
                    Mensagem = "Certificado configurado com sucesso"
                });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao configurar certificado");
                return BadRequest(new MDFeResponse
                {
                    Sucesso = false,
                    Mensagem = ex.Message
                });
            }
        }

        /// <summary>
        /// Configura ambiente (produção/homologação)
        /// </summary>
        /// <param name="ambiente">1 = Produção, 2 = Homologação</param>
        /// <returns>Resultado da configuração</returns>
        [HttpPost("configurar-ambiente/{ambiente}")]
        public ActionResult<MDFeResponse> ConfigurarAmbiente(int ambiente)
        {
            try
            {
                _logger.LogInformation("Configurando ambiente: {ambiente}", ambiente);

                _mdfeService.ConfigurarAmbiente(ambiente);

                return Ok(new MDFeResponse
                {
                    Sucesso = true,
                    Mensagem = $"Ambiente configurado: {(ambiente == 1 ? "Produção" : "Homologação")}"
                });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao configurar ambiente");
                return BadRequest(new MDFeResponse
                {
                    Sucesso = false,
                    Mensagem = ex.Message
                });
            }
        }

        #region Métodos Privados

        /// <summary>
        /// Cria um arquivo INI temporário com os dados do request
        /// </summary>
        private async Task<string> CriarTemplateTemporario(GerarMDFeRequest request)
        {
            var templatePath = Path.Combine(Path.GetTempPath(), $"mdfe_temp_{Guid.NewGuid()}.ini");

            var conteudoIni = $@"[infMDFe]
Id=MDFe{request.ChaveMDFe ?? Guid.NewGuid().ToString().Replace("-", "")}

[ide]
cUF=35
tpAmb=2
tpEmit=1
tpTransp=1
mod=58
serie={request.Serie ?? 1}
nMDF={request.NumeroMDFe}
cMDF={request.CodigoMDFe}
cDV={request.DigitoVerificador}
modal=01
dhEmi={DateTime.Now:yyyy-MM-ddTHH:mm:sszzz}
tpEmis=1
procEmi=0
verProc=Sistema MDFe v1.2.2.337
UFIni={request.UFInicio ?? "SP"}
UFFim={request.UFDestino}

[emit]
CNPJCPF={request.CNPJEmitente}
IE={request.IEEmitente}
xNome={request.NomeEmitente}
xFant={request.NomeFantasiaEmitente}
xLgr={request.EnderecoEmitente}
nro={request.NumeroEnderecoEmitente}
xBairro={request.BairroEmitente}
cMun={request.CodigoMunicipioEmitente}
xMun={request.MunicipioEmitente}
CEP={request.CEPEmitente}
UF={request.UFEmitente}
fone={request.TelefoneEmitente}

[infModal]
versaoModal=3.00

[infANTT]
RNTRC={request.RNTRC}

[veicTracao]
cInt=1
placa={request.PlacaVeiculo}
RENAVAM={request.RENAVAMVeiculo}
tara={request.TaraVeiculo}
capKG={request.CapacidadeKGVeiculo}
capM3={request.CapacidadeM3Veiculo}
tpRod=01
tpCar=01
UF={request.UFVeiculo}

[prop]
CPF={request.CPFProprietario}
xNome={request.NomeProprietario}
UF={request.UFProprietario}
tpProp=1

[moto001]
xNome={request.NomeCondutor}
CPF={request.CPFCondutor}

[infDoc]

[infMunDescarga001]
cMunDescarga={request.CodigoMunicipioDestino}
xMunDescarga={request.MunicipioDestino}

[infCTe001]
chCTe={request.ChaveCTe}

[prodPred]
tpCarga={request.TipoCarga ?? 5}
xProd={request.DescricaoProduto}

[tot]
qCTe=1
qNFe=0
qMDFe=0
vCarga={request.ValorCarga:F2}
cUnid=01
qCarga={request.PesoCarga:F4}

[infAdic]
infCpl={request.InformacoesComplementares ?? "MDFe gerado automaticamente - Modal Rodoviário"}";

            await System.IO.File.WriteAllTextAsync(templatePath, conteudoIni);
            return templatePath;
        }

        #endregion
    }

    #region DTOs

    /// <summary>
    /// Request para geração de MDFe
    /// </summary>
    public class GerarMDFeRequest
    {
        public string? ChaveMDFe { get; set; }
        public int? Serie { get; set; } = 1;
        public int NumeroMDFe { get; set; }
        public int CodigoMDFe { get; set; }
        public int DigitoVerificador { get; set; }
        public string UFInicio { get; set; } = "SP";
        public string UFDestino { get; set; } = "";

        // Dados do Emitente
        public string CNPJEmitente { get; set; } = "";
        public string IEEmitente { get; set; } = "";
        public string NomeEmitente { get; set; } = "";
        public string NomeFantasiaEmitente { get; set; } = "";
        public string EnderecoEmitente { get; set; } = "";
        public string NumeroEnderecoEmitente { get; set; } = "";
        public string BairroEmitente { get; set; } = "";
        public string CodigoMunicipioEmitente { get; set; } = "";
        public string MunicipioEmitente { get; set; } = "";
        public string CEPEmitente { get; set; } = "";
        public string UFEmitente { get; set; } = "";
        public string TelefoneEmitente { get; set; } = "";

        // ANTT
        public string RNTRC { get; set; } = "";

        // Veículo
        public string PlacaVeiculo { get; set; } = "";
        public string RENAVAMVeiculo { get; set; } = "";
        public int TaraVeiculo { get; set; }
        public int CapacidadeKGVeiculo { get; set; }
        public int CapacidadeM3Veiculo { get; set; }
        public string UFVeiculo { get; set; } = "";

        // Proprietário
        public string CPFProprietario { get; set; } = "";
        public string NomeProprietario { get; set; } = "";
        public string UFProprietario { get; set; } = "";

        // Condutor
        public string NomeCondutor { get; set; } = "";
        public string CPFCondutor { get; set; } = "";

        // Destino
        public string CodigoMunicipioDestino { get; set; } = "";
        public string MunicipioDestino { get; set; } = "";

        // Documentos
        public string ChaveCTe { get; set; } = "";

        // Carga
        public int TipoCarga { get; set; } = 5; // Carga Geral
        public string DescricaoProduto { get; set; } = "";
        public decimal ValorCarga { get; set; }
        public decimal PesoCarga { get; set; }

        // Complementares
        public string InformacoesComplementares { get; set; } = "";
    }

    /// <summary>
    /// Request para transmissão de MDFe
    /// </summary>
    public class TransmitirMDFeRequest
    {
        public int NumeroLote { get; set; } = 1;
    }

    /// <summary>
    /// Request para cancelamento de MDFe
    /// </summary>
    public class CancelarMDFeRequest
    {
        public string ChaveMDFe { get; set; } = "";
        public string Justificativa { get; set; } = "";
    }

    /// <summary>
    /// Request para encerramento de MDFe
    /// </summary>
    public class EncerrarMDFeRequest
    {
        public string ChaveMDFe { get; set; } = "";
        public string CodigoMunicipioDestino { get; set; } = "";
    }

    /// <summary>
    /// Request para configuração de certificado
    /// </summary>
    public class ConfigurarCertificadoRequest
    {
        public string NumeroCertificado { get; set; } = "";
        public string Senha { get; set; } = "";
    }

    /// <summary>
    /// Response padrão para operações MDFe
    /// </summary>
    public class MDFeResponse
    {
        public bool Sucesso { get; set; }
        public string Mensagem { get; set; } = "";
        public string XmlMDFe { get; set; } = "";
        public string XmlRetorno { get; set; } = "";
        public DateTime DataHora { get; set; } = DateTime.Now;
    }

    #endregion
}