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
                _logger.LogInformation("📥 Recebendo requisição para criar MDFe: {@MdfeDto}", mdfeDto);
                var mdfe = await _mdfeBusinessService.CreateMDFeAsync(mdfeDto);
                _logger.LogInformation("✅ MDFe criado com sucesso: {Id}", mdfe.Id);
                return CreatedAtAction(nameof(GetMDFe), new { id = mdfe.Id }, mdfe);
            }
            catch (ArgumentException ex)
            {
                _logger.LogWarning(ex, "❌ Argumento inválido ao criar MDFe");
                return BadRequest(new { message = ex.Message });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "💥 ERRO CRÍTICO ao criar MDFe. Mensagem: {Message}. StackTrace: {StackTrace}", ex.Message, ex.StackTrace);
                return StatusCode(500, new {
                    message = "Erro interno do servidor",
                    detalhes = ex.Message,
                    tipo = ex.GetType().Name
                });
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
                _logger.LogInformation("📥 Recebendo requisição para atualizar MDFe {Id}: {@MdfeDto}", id, mdfeDto);
                var mdfe = await _mdfeBusinessService.UpdateMDFeAsync(id, mdfeDto);
                if (mdfe == null)
                    return NotFound(new { message = "MDFe não encontrado" });

                _logger.LogInformation("✅ MDFe {Id} atualizado com sucesso", id);
                return Ok(mdfe);
            }
            catch (ArgumentException ex)
            {
                _logger.LogWarning(ex, "❌ Argumento inválido ao atualizar MDFe {Id}: {Message}", id, ex.Message);
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
                return StatusCode(500, new {
                    sucesso = false,
                    mensagem = $"Erro ao transmitir: {ex.Message}",
                    detalhes = ex.InnerException?.Message ?? ex.StackTrace
                });
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
        public async Task<ActionResult> SalvarRascunho([FromBody] MDFeCreateDto mdfeData)
        {
            try
            {
                MDFe mdfe;

                // Verificar se é atualização ou criação baseado no ID
                if (mdfeData.EmitenteId > 0)
                {
                    // Tentar encontrar MDFe existente por ID ou criar novo
                    var mdfeExistente = await _mdfeBusinessService.GetMDFesAsync(mdfeData.EmitenteId, 1, 100);
                    var rascunhoExistente = mdfeExistente.Items
                        .FirstOrDefault(m => m.Status == "RASCUNHO" && m.Id.ToString() == mdfeData.EmitenteId.ToString());

                    if (rascunhoExistente != null)
                    {
                        // Atualizar rascunho existente
                        mdfe = await _mdfeBusinessService.UpdateMDFeAsync(rascunhoExistente.Id, mdfeData);

                        if (mdfe == null)
                            return NotFound(new { sucesso = false, mensagem = "Rascunho não encontrado para atualização" });

                        _logger.LogInformation("Rascunho {Id} atualizado com sucesso", mdfe.Id);
                    }
                    else
                    {
                        // Criar novo rascunho
                        mdfe = await _mdfeBusinessService.CreateMDFeAsync(mdfeData);
                        _logger.LogInformation("Novo rascunho {Id} criado com sucesso", mdfe.Id);
                    }
                }
                else
                {
                    // Criar novo rascunho
                    mdfe = await _mdfeBusinessService.CreateMDFeAsync(mdfeData);
                    _logger.LogInformation("Novo rascunho {Id} criado com sucesso", mdfe.Id);
                }

                return Ok(new
                {
                    sucesso = true,
                    mensagem = "Rascunho salvo com sucesso",
                    dados = new
                    {
                        id = mdfe.Id,
                        numero = mdfe.NumeroMdfe,
                        serie = mdfe.Serie,
                        chaveAcesso = mdfe.ChaveAcesso,
                        statusSefaz = mdfe.StatusSefaz
                    }
                });
            }
            catch (ArgumentException ex)
            {
                _logger.LogWarning(ex, "Erro de validação ao salvar rascunho");
                return BadRequest(new { sucesso = false, mensagem = ex.Message });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao salvar rascunho");
                return StatusCode(500, new { sucesso = false, mensagem = "Erro ao salvar rascunho. Tente novamente." });
            }
        }

        /// <summary>
        /// Carregar rascunho
        /// </summary>
        [HttpGet("carregar-rascunho/{id}")]
        public async Task<ActionResult> CarregarRascunho(int id)
        {
            try
            {
                var mdfe = await _mdfeBusinessService.GetMDFeByIdAsync(id);

                if (mdfe == null)
                    return NotFound(new { sucesso = false, mensagem = "Rascunho não encontrado" });

                if (mdfe.StatusSefaz != "RASCUNHO")
                    return BadRequest(new { sucesso = false, mensagem = "Este MDFe não é um rascunho" });

                return Ok(new
                {
                    sucesso = true,
                    mensagem = "Rascunho carregado com sucesso",
                    dados = mdfe
                });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao carregar rascunho {Id}", id);
                return StatusCode(500, new { sucesso = false, mensagem = "Erro ao carregar rascunho" });
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
                        contratanteId = mdfe.ContratanteId,
                        seguradoraId = mdfe.SeguradoraId,
                        numeroMdfe = mdfe.NumeroMdfe,
                        serie = mdfe.Serie,
                        dataEmissao = mdfe.DataEmissao,
                        dataInicioViagem = mdfe.DataInicioViagem,
                        ufIni = mdfe.UfIni,
                        ufFim = mdfe.UfFim,
                        municipioIni = mdfe.MunicipioIni,
                        municipioFim = mdfe.MunicipioFim,
                        valorTotal = mdfe.ValorTotal,
                        pesoBrutoTotal = mdfe.PesoBrutoTotal,
                        observacoes = mdfe.InfoAdicional,
                        statusSefaz = mdfe.StatusSefaz,
                        chaveAcesso = mdfe.ChaveAcesso,
                        protocolo = mdfe.Protocolo,

                        // ✅ CAMPOS JSON NECESSÁRIOS PARA EDIÇÃO
                        localidadesCarregamentoJson = mdfe.LocalidadesCarregamentoJson,
                        localidadesDescarregamentoJson = mdfe.LocalidadesDescarregamentoJson,
                        rotaPercursoJson = mdfe.RotaPercursoJson,
                        documentosCTeJson = mdfe.DocumentosCTeJson,
                        documentosNFeJson = mdfe.DocumentosNFeJson,

                        // ✅ IDs dos reboques
                        reboquesIds = mdfe.Reboques?.Select(r => r.ReboqueId).ToList() ?? new List<int>(),

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
                        emitentes = mdfe.Emitente != null ? new[] { mdfe.Emitente } : new object[0],
                        veiculos = mdfe.Veiculo != null ? new[] { mdfe.Veiculo } : new object[0],
                        condutores = mdfe.Condutor != null ? new[] { mdfe.Condutor } : new object[0],
                        contratantes = mdfe.Contratante != null ? new[] { mdfe.Contratante } : new object[0],
                        seguradoras = mdfe.Seguradora != null ? new[] { mdfe.Seguradora } : new object[0]
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