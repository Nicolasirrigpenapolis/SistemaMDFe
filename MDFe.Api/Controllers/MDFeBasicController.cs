using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using MDFeApi.Interfaces;
using MDFeApi.DTOs;
using MDFeApi.Models;

namespace MDFeApi.Controllers
{
    /// <summary>
    /// Controller responsável pelas operações do MDFe (CRUD + SEFAZ)
    /// </summary>
    [ApiController]
    [Route("api/mdfe")]
    // [Authorize] // REMOVIDO para desenvolvimento - Exigir autenticação para todas as operações
    public class MDFeBasicController : ControllerBase
    {
        private readonly IMDFeBusinessService _mdfeBusinessService;
        private readonly IMDFeService _mdfeService;
        private readonly ILogger<MDFeBasicController> _logger;

        public MDFeBasicController(
            IMDFeBusinessService mdfeBusinessService,
            IMDFeService mdfeService,
            ILogger<MDFeBasicController> logger)
        {
            _mdfeBusinessService = mdfeBusinessService;
            _mdfeService = mdfeService;
            _logger = logger;
        }

        /// <summary>
        /// Listar MDFes com paginação
        /// </summary>
        [HttpGet]
        public async Task<ActionResult<PagedResult<MDFeResponseDto>>> GetMDFes(
            [FromQuery] int? emitenteId,
            [FromQuery] int pagina = 1,
            [FromQuery] int tamanhoPagina = 10)
        {
            try
            {
                var result = await _mdfeBusinessService.GetMDFesAsync(emitenteId, pagina, tamanhoPagina);
                return Ok(result);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao buscar MDFes");
                return StatusCode(500, new { message = "Erro interno do servidor" });
            }
        }

        /// <summary>
        /// Obter MDFe por ID
        /// </summary>
        [HttpGet("{id}")]
        public async Task<ActionResult<MDFe>> GetMDFe(int id)
        {
            try
            {
                var mdfe = await _mdfeBusinessService.GetMDFeByIdAsync(id);
                if (mdfe == null)
                    return NotFound(new { message = "MDFe não encontrado" });

                return Ok(mdfe);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao buscar MDFe {Id}", id);
                return StatusCode(500, new { message = "Erro interno do servidor" });
            }
        }

        /// <summary>
        /// Criar novo MDFe
        /// </summary>
        [HttpPost]
        public async Task<ActionResult<MDFe>> CreateMDFe(MDFeCreateDto mdfeDto)
        {
            try
            {
                var mdfe = await _mdfeBusinessService.CreateMDFeAsync(mdfeDto);
                return CreatedAtAction(nameof(GetMDFe), new { id = mdfe.Id }, mdfe);
            }
            catch (ArgumentException ex)
            {
                return BadRequest(new { message = ex.Message });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao criar MDFe");
                return StatusCode(500, new { message = "Erro interno do servidor" });
            }
        }

        /// <summary>
        /// Atualizar MDFe
        /// </summary>
        [HttpPut("{id}")]
        public async Task<ActionResult<MDFe>> UpdateMDFe(int id, MDFeCreateDto mdfeDto)
        {
            try
            {
                var mdfe = await _mdfeBusinessService.UpdateMDFeAsync(id, mdfeDto);
                if (mdfe == null)
                    return NotFound(new { message = "MDFe não encontrado" });

                return Ok(mdfe);
            }
            catch (ArgumentException ex)
            {
                return BadRequest(new { message = ex.Message });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao atualizar MDFe {Id}", id);
                return StatusCode(500, new { message = "Erro interno do servidor" });
            }
        }

        /// <summary>
        /// Excluir MDFe
        /// </summary>
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteMDFe(int id)
        {
            try
            {
                var success = await _mdfeBusinessService.DeleteMDFeAsync(id);
                if (!success)
                    return NotFound(new { message = "MDFe não encontrado" });

                return NoContent();
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao excluir MDFe {Id}", id);
                return StatusCode(500, new { message = "Erro interno do servidor" });
            }
        }

        /// <summary>
        /// Obter próximo número do MDFe
        /// </summary>
        [HttpGet("proximo-numero")]
        public async Task<ActionResult<int>> ObterProximoNumero([FromQuery] string? emitenteCnpj)
        {
            try
            {
                var proximoNumero = await _mdfeBusinessService.GetProximoNumeroAsync(emitenteCnpj);
                return Ok(proximoNumero);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao obter próximo número");
                return StatusCode(500, new { message = "Erro interno do servidor" });
            }
        }

        /// <summary>
        /// Gerar MDFe
        /// </summary>
        [HttpPost("{id}/gerar")]
        public async Task<ActionResult> GerarMDFe(int id)
        {
            try
            {
                var xml = await _mdfeService.GerarXmlAsync(id);
                if (string.IsNullOrEmpty(xml))
                    return BadRequest(new { message = "Erro ao gerar XML do MDFe" });

                return Ok(new { xml, sucesso = true, mensagem = "MDFe gerado com sucesso" });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao gerar MDFe {Id}", id);
                return StatusCode(500, new { sucesso = false, mensagem = "Erro interno do servidor" });
            }
        }

        /// <summary>
        /// Transmitir MDFe para SEFAZ
        /// </summary>
        [HttpPost("{id}/transmitir")]
        public async Task<ActionResult> TransmitirMDFe(int id)
        {
            try
            {
                var resultado = await _mdfeService.TransmitirAsync(id);
                return Ok(new { resultado, sucesso = true, mensagem = "MDFe transmitido com sucesso" });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao transmitir MDFe {Id}", id);
                return StatusCode(500, new { sucesso = false, mensagem = "Erro interno do servidor" });
            }
        }

        /// <summary>
        /// Gerar e baixar PDF do DAMDFE
        /// </summary>
        [HttpGet("{id}/pdf")]
        public async Task<ActionResult> BaixarPDF(int id)
        {
            try
            {
                var pdfBytes = await _mdfeService.GerarPDFAsync(id);

                // Buscar o MDFe para pegar o número
                var mdfe = await _mdfeService.GetByIdAsync(id);
                var numero = mdfe?.NumeroMdfe.ToString().PadLeft(9, '0') ?? id.ToString();
                var nomeArquivo = $"DAMDFE_{numero}_{DateTime.Now:yyyyMMdd}.pdf";

                return File(pdfBytes, "application/pdf", nomeArquivo);
            }
            catch (FileNotFoundException ex)
            {
                _logger.LogWarning(ex, "XML do MDFe {Id} não encontrado", id);
                return NotFound(new { sucesso = false, mensagem = "XML do MDFe não encontrado. O MDFe foi transmitido?" });
            }
            catch (InvalidOperationException ex)
            {
                _logger.LogWarning(ex, "Erro ao gerar PDF do MDFe {Id}", id);
                return BadRequest(new { sucesso = false, mensagem = ex.Message });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao gerar PDF do MDFe {Id}", id);
                return StatusCode(500, new { sucesso = false, mensagem = "Erro ao gerar PDF do DAMDFE" });
            }
        }

        /// <summary>
        /// Consultar status do MDFe na SEFAZ
        /// </summary>
        [HttpPost("consultar-status")]
        public async Task<ActionResult> ConsultarStatus([FromBody] ConsultarStatusRequest request)
        {
            try
            {
                var resultado = await _mdfeService.ConsultarPorChaveAsync(request.ChaveAcesso);
                return Ok(new { resultado, sucesso = true, mensagem = "Consulta realizada com sucesso" });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao consultar status do MDFe");
                return StatusCode(500, new { sucesso = false, mensagem = "Erro interno do servidor" });
            }
        }

        /// <summary>
        /// Carregar INI do MDFe
        /// </summary>
        [HttpPost("carregar-ini")]
        public async Task<ActionResult> CarregarINI([FromBody] object mdfeData)
        {
            try
            {
                // Implementar lógica de carregamento de INI
                return Ok(new { sucesso = true, mensagem = "INI carregado com sucesso" });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao carregar INI");
                return StatusCode(500, new { sucesso = false, mensagem = "Erro interno do servidor" });
            }
        }

        /// <summary>
        /// Gerar INI simplificado
        /// </summary>
        [HttpPost("gerar-ini")]
        public async Task<ActionResult> GerarINI([FromBody] object dados)
        {
            try
            {
                // Implementar lógica de geração de INI
                return Ok(new { sucesso = true, mensagem = "INI gerado com sucesso" });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao gerar INI");
                return StatusCode(500, new { sucesso = false, mensagem = "Erro interno do servidor" });
            }
        }

        /// <summary>
        /// Salvar rascunho
        /// </summary>
        [HttpPost("salvar-rascunho")]
        public async Task<ActionResult> SalvarRascunho([FromBody] object mdfeData)
        {
            try
            {
                // Implementar lógica de salvar rascunho
                return Ok(new { sucesso = true, mensagem = "Rascunho salvo com sucesso" });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao salvar rascunho");
                return StatusCode(500, new { sucesso = false, mensagem = "Erro interno do servidor" });
            }
        }

        /// <summary>
        /// Carregar rascunho
        /// </summary>
        [HttpGet("carregar-rascunho/{id}")]
        public async Task<ActionResult> CarregarRascunho(string id)
        {
            try
            {
                // Implementar lógica de carregar rascunho
                return Ok(new { sucesso = true, mensagem = "Rascunho carregado com sucesso" });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao carregar rascunho");
                return StatusCode(500, new { sucesso = false, mensagem = "Erro interno do servidor" });
            }
        }

        /// <summary>
        /// Obter status do serviço
        /// </summary>
        [HttpGet("status")]
        public async Task<ActionResult> ObterStatus()
        {
            try
            {
                // Implementar lógica de status do serviço
                return Ok(new { sucesso = true, mensagem = "Serviço funcionando" });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao obter status");
                return StatusCode(500, new { sucesso = false, mensagem = "Erro interno do servidor" });
            }
        }

        /// <summary>
        /// Obter dados completos do MDFe para wizard
        /// </summary>
        [HttpGet("data/wizard-complete/{id}")]
        public async Task<ActionResult> ObterMDFeWizardCompleto(int id)
        {
            try
            {
                var mdfe = await _mdfeBusinessService.GetMDFeByIdAsync(id);
                if (mdfe == null)
                    return NotFound(new { sucesso = false, mensagem = "MDFe não encontrado" });

                // Estruturar resposta com MDFe e entidades para o wizard
                var resposta = new
                {
                    mdfe = new
                    {
                        id = mdfe.Id,
                        emitenteId = mdfe.EmitenteId,
                        veiculoId = mdfe.VeiculoId,
                        condutorId = mdfe.CondutorId,
                        numeroMdfe = mdfe.NumeroMdfe,
                        serie = mdfe.Serie,
                        dataEmissao = mdfe.DataEmissao,
                        dataInicioViagem = mdfe.DataInicioViagem,
                        ufIni = mdfe.UfIni,
                        ufFim = mdfe.UfFim,
                        valorTotal = mdfe.ValorTotal,
                        pesoBrutoTotal = mdfe.PesoBrutoTotal,
                        observacoes = mdfe.InfoAdicional,
                        statusSefaz = mdfe.StatusSefaz,
                        chaveAcesso = mdfe.ChaveAcesso,
                        // Snapshots das entidades
                        emitenteRazaoSocial = mdfe.EmitenteRazaoSocial,
                        emitenteCnpj = mdfe.EmitenteCnpj,
                        emitenteEndereco = mdfe.EmitenteEndereco,
                        condutorNome = mdfe.CondutorNome,
                        condutorCpf = mdfe.CondutorCpf,
                        veiculoPlaca = mdfe.VeiculoPlaca,
                        veiculoTara = mdfe.VeiculoTara,
                        // Estrutura para compatibilidade com frontend atual
                        emit = mdfe.Emitente != null ? new
                        {
                            CNPJ = mdfe.EmitenteCnpj ?? mdfe.Emitente.Cnpj,
                            IE = mdfe.Emitente.Ie,
                            xNome = mdfe.EmitenteRazaoSocial ?? mdfe.Emitente.RazaoSocial,
                            xFant = mdfe.Emitente.NomeFantasia,
                            enderEmit = new
                            {
                                xLgr = mdfe.Emitente.Endereco,
                                nro = mdfe.Emitente.Numero,
                                xCpl = mdfe.Emitente.Complemento,
                                xBairro = mdfe.Emitente.Bairro,
                                cMun = mdfe.Emitente.CodMunicipio.ToString(),
                                xMun = mdfe.Emitente.Municipio,
                                CEP = mdfe.Emitente.Cep,
                                UF = mdfe.Emitente.Uf,
                                fone = "",
                                email = ""
                            }
                        } : null
                    },
                    entities = new
                    {
                        // Dados básicos das entidades podem ser adicionados se necessário
                        emitentes = mdfe.Emitente != null ? new[] { new { id = mdfe.EmitenteId, data = mdfe.Emitente } } : new object[0],
                        veiculos = mdfe.Veiculo != null ? new[] { new { id = mdfe.VeiculoId, data = mdfe.Veiculo } } : new object[0],
                        condutores = mdfe.Condutor != null ? new[] { new { id = mdfe.CondutorId, data = mdfe.Condutor } } : new object[0]
                    }
                };

                return Ok(new { sucesso = true, dados = resposta });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao obter dados completos do MDFe {Id}", id);
                return StatusCode(500, new { sucesso = false, mensagem = "Erro interno do servidor" });
            }
        }
    }

    public class ConsultarStatusRequest
    {
        public string ChaveAcesso { get; set; } = string.Empty;
    }
}