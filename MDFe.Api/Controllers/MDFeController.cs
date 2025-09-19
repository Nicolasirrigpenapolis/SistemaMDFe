using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MDFeApi.Data;
using MDFeApi.Models;
using MDFeApi.DTOs;
using MDFeApi.Services;
using Microsoft.Extensions.Logging;

namespace MDFeApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class MDFeController : ControllerBase
    {
        private readonly MDFeContext _context;
        private readonly IMDFeService _mdfeService;
        private readonly IACBrMDFeService _acbrService;
        private readonly IConfiguration _configuration;
        private readonly ILogger<MDFeController> _logger;

        public MDFeController(MDFeContext context, IMDFeService mdfeService, IACBrMDFeService acbrService, IConfiguration configuration, ILogger<MDFeController> logger)
        {
            _context = context;
            _mdfeService = mdfeService;
            _acbrService = acbrService;
            _configuration = configuration;
            _logger = logger;
        }

        [HttpGet]
        public async Task<ActionResult<ResultadoPaginado<MDFeResponseDto>>> GetMDFes([FromQuery] int? emitenteId, [FromQuery] int pagina = 1, [FromQuery] int tamanhoPagina = 10)
        {
            var query = _context.MDFes
                .Include(m => m.Emitente)
                .Include(m => m.Veiculo)
                .Include(m => m.Condutor)
                .AsQueryable();

            if (emitenteId.HasValue)
            {
                query = query.Where(m => m.EmitenteId == emitenteId.Value);
            }

            var totalItens = await query.CountAsync();

            var itens = await query
                .OrderByDescending(m => m.DataEmissao)
                .Skip((pagina - 1) * tamanhoPagina)
                .Take(tamanhoPagina)
                .Select(m => new MDFeResponseDto
                {
                    Id = m.Id,
                    Numero = m.NumeroMdfe,
                    Chave = m.ChaveAcesso ?? "",
                    Serie = m.Serie.ToString(),
                    DataEmissao = m.DataEmissao,
                    DataInicioViagem = m.DataInicioViagem ?? m.DataEmissao,
                    UfIni = m.UfInicio,
                    UfFim = m.UfFim,
                    MunicipioIni = m.MunicipioIni,
                    MunicipioFim = m.MunicipioFim,
                    PesoBrutoTotal = m.PesoBrutoTotal,
                    ValorTotal = m.ValorCarga,
                    Status = m.StatusSefaz,
                    Observacoes = m.InfoAdicional,
                    EmitenteRazaoSocial = m.Emitente.RazaoSocial,
                    VeiculoPlaca = m.Veiculo.Placa,
                    CondutorNome = m.Condutor.Nome
                })
                .ToListAsync();

            var resultadoPaginado = new ResultadoPaginado<MDFeResponseDto>
            {
                Itens = itens,
                TotalItens = totalItens,
                Pagina = pagina,
                TamanhoPagina = tamanhoPagina
            };

            return Ok(resultadoPaginado);
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<MDFe>> GetMDFe(int id)
        {
            var mdfe = await _context.MDFes
                .Include(m => m.Emitente)
                .Include(m => m.Veiculo)
                .Include(m => m.Condutor)
                .Include(m => m.Reboques)
                .FirstOrDefaultAsync(m => m.Id == id);

            if (mdfe == null || !mdfe.Ativo)
            {
                return NotFound();
            }

            return mdfe;
        }

        [HttpPost]
        public async Task<ActionResult<MDFe>> CreateMDFe(MDFeCreateDto mdfeDto)
        {
            try
            {
                // Validar se emitente, veículo e condutor existem
                var emitente = await _context.Emitentes.FindAsync(mdfeDto.EmitenteId);
                if (emitente == null || !emitente.Ativo)
                {
                    return BadRequest(new { message = "Emitente não encontrado ou inativo" });
                }

                var veiculo = await _context.Veiculos.FindAsync(mdfeDto.VeiculoId);
                if (veiculo == null || !veiculo.Ativo)
                {
                    return BadRequest(new { message = "Veículo não encontrado ou inativo" });
                }

                var condutor = await _context.Condutores.FindAsync(mdfeDto.CondutorId);
                if (condutor == null || !condutor.Ativo)
                {
                    return BadRequest(new { message = "Condutor não encontrado ou inativo" });
                }

                // Gerar próximo número
                var ultimoNumero = await _context.MDFes
                    .Where(m => m.EmitenteId == mdfeDto.EmitenteId)
                    .MaxAsync(m => (int?)m.NumeroMdfe) ?? 0;

                var mdfe = new MDFe
                {
                    EmitenteId = mdfeDto.EmitenteId,
                    VeiculoId = mdfeDto.VeiculoId,
                    CondutorId = mdfeDto.CondutorId,
                    NumeroMdfe = ultimoNumero + 1,
                    Serie = 1,
                    DataEmissao = mdfeDto.DataEmissao,
                    DataInicioViagem = mdfeDto.DataInicioViagem,
                    UfInicio = mdfeDto.UfIni,
                    UfFim = mdfeDto.UfFim,
                    MunicipioIni = mdfeDto.MunicipioIni,
                    MunicipioFim = mdfeDto.MunicipioFim,
                    PesoBrutoTotal = mdfeDto.PesoBrutoTotal,
                    ValorCarga = mdfeDto.ValorTotal,
                    InfoAdicional = mdfeDto.Observacoes,
                    StatusSefaz = "RASCUNHO",
                    ChaveAcesso = "" // Será gerada posteriormente
                };

                // **COPIAR DADOS DOS CADASTROS PARA O MDFE**
                // Isso garante que o MDFe tenha uma "foto" dos dados no momento da emissão
                // Futuras alterações nos cadastros não afetarão este MDFe
                mdfe.CopyAllRelatedData(emitente, condutor, veiculo);

                _context.MDFes.Add(mdfe);
                await _context.SaveChangesAsync();

                // Associar reboques se informados
                if (mdfeDto.ReboquesIds != null && mdfeDto.ReboquesIds.Any())
                {
                    var reboques = await _context.Reboques
                        .Where(r => mdfeDto.ReboquesIds.Contains(r.Id) && r.Ativo)
                        .ToListAsync();

                    int ordem = 1;
                    foreach (var reboque in reboques)
                    {
                        _context.Add(new MDFeReboque
                        {
                            MDFeId = mdfe.Id,
                            ReboqueId = reboque.Id,
                            Ordem = ordem++
                        });
                    }

                    await _context.SaveChangesAsync();
                }

                return CreatedAtAction(nameof(GetMDFe), new { id = mdfe.Id }, mdfe);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Erro interno do servidor", error = ex.Message });
            }
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateMDFe(int id, MDFeUpdateDto mdfeDto)
        {
            var mdfe = await _context.MDFes.FindAsync(id);
            if (mdfe == null || !mdfe.Ativo)
            {
                return NotFound();
            }

            // Não permitir edição se já foi transmitido
            if (mdfe.StatusSefaz == "AUTORIZADO" || mdfe.StatusSefaz == "REJEITADO")
            {
                return BadRequest(new { message = "MDF-e não pode ser editado após transmissão" });
            }

            try
            {
                mdfe.VeiculoId = mdfeDto.VeiculoId;
                mdfe.CondutorId = mdfeDto.CondutorId;
                mdfe.DataEmissao = mdfeDto.DataEmissao;
                mdfe.DataInicioViagem = mdfeDto.DataInicioViagem;
                mdfe.UfInicio = mdfeDto.UfIni;
                mdfe.UfFim = mdfeDto.UfFim;
                mdfe.MunicipioIni = mdfeDto.MunicipioIni;
                mdfe.MunicipioFim = mdfeDto.MunicipioFim;
                mdfe.PesoBrutoTotal = mdfeDto.PesoBrutoTotal;
                mdfe.ValorCarga = mdfeDto.ValorTotal;
                mdfe.InfoAdicional = mdfeDto.Observacoes;

                await _context.SaveChangesAsync();

                return NoContent();
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Erro interno do servidor", error = ex.Message });
            }
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteMDFe(int id)
        {
            var mdfe = await _context.MDFes.FindAsync(id);
            if (mdfe == null)
            {
                return NotFound();
            }

            // Não permitir exclusão se já foi transmitido
            if (mdfe.StatusSefaz == "AUTORIZADO")
            {
                return BadRequest(new { message = "MDF-e autorizado não pode ser excluído" });
            }

            try
            {
                // Soft delete
                mdfe.StatusSefaz = "EXCLUIDO";
                await _context.SaveChangesAsync();

                return NoContent();
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Erro interno do servidor", error = ex.Message });
            }
        }

        [HttpPost("{id}/gerar")]
        public async Task<ActionResult<string>> GerarMDFe(int id)
        {
            try
            {
                var mdfe = await _context.MDFes.FindAsync(id);
                if (mdfe == null || !mdfe.Ativo)
                {
                    return NotFound();
                }

                if (mdfe.StatusSefaz != "RASCUNHO")
                {
                    return BadRequest(new { message = "MDFe só pode ser gerado quando estiver em rascunho" });
                }

                string xml = await _acbrService.GerarMDFeAsync(id);

                return Ok(new { xml = xml, message = "MDFe gerado e assinado com sucesso" });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Erro ao gerar MDFe", error = ex.Message });
            }
        }

        [HttpPost("{id}/transmitir")]
        public async Task<ActionResult<string>> TransmitirMDFe(int id)
        {
            try
            {
                var mdfe = await _context.MDFes.FindAsync(id);
                if (mdfe == null || !mdfe.Ativo)
                {
                    return NotFound();
                }

                if (string.IsNullOrEmpty(mdfe.XmlAssinado))
                {
                    return BadRequest(new { message = "MDFe deve ser gerado antes de transmitir" });
                }

                if (mdfe.Transmitido)
                {
                    return BadRequest(new { message = "MDFe já foi transmitido" });
                }

                string retorno = await _acbrService.TransmitirMDFeAsync(id);

                return Ok(new { retorno = retorno, message = "MDFe transmitido com sucesso" });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Erro ao transmitir MDFe", error = ex.Message });
            }
        }

        [HttpPost("{id}/consultar-protocolo")]
        public async Task<ActionResult<string>> ConsultarProtocolo(int id)
        {
            try
            {
                var mdfe = await _context.MDFes.FindAsync(id);
                if (mdfe == null || !mdfe.Ativo)
                {
                    return NotFound();
                }

                if (string.IsNullOrEmpty(mdfe.NumeroRecibo))
                {
                    return BadRequest(new { message = "Número do recibo não encontrado" });
                }

                string retorno = await _acbrService.ConsultarProtocoloAsync(mdfe.NumeroRecibo);

                return Ok(new { retorno = retorno, message = "Consulta de protocolo realizada com sucesso" });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Erro ao consultar protocolo", error = ex.Message });
            }
        }

        [HttpPost("{id}/consultar-mdfe")]
        public async Task<ActionResult<string>> ConsultarMDFe(int id)
        {
            try
            {
                var mdfe = await _context.MDFes.FindAsync(id);
                if (mdfe == null || !mdfe.Ativo)
                {
                    return NotFound();
                }

                if (string.IsNullOrEmpty(mdfe.ChaveAcesso))
                {
                    return BadRequest(new { message = "Chave do MDFe não encontrada" });
                }

                string retorno = await _acbrService.ConsultarMDFeAsync(mdfe.ChaveAcesso);

                return Ok(new { retorno = retorno, message = "Consulta realizada com sucesso" });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Erro ao consultar MDFe", error = ex.Message });
            }
        }

        [HttpPost("{id}/cancelar")]
        public async Task<ActionResult<string>> CancelarMDFe(int id, [FromBody] CancelarMDFeRequest request)
        {
            try
            {
                if (string.IsNullOrEmpty(request.Justificativa) || request.Justificativa.Length < 15)
                {
                    return BadRequest(new { message = "Justificativa deve ter no mínimo 15 caracteres" });
                }

                string retorno = await _acbrService.CancelarMDFeAsync(id, request.Justificativa);

                return Ok(new { retorno = retorno, message = "MDFe cancelado com sucesso" });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Erro ao cancelar MDFe", error = ex.Message });
            }
        }

        [HttpPost("{id}/encerrar")]
        public async Task<ActionResult<string>> EncerrarMDFe(int id, [FromBody] EncerrarMDFeRequest request)
        {
            try
            {
                if (string.IsNullOrEmpty(request.MunicipioDescarga))
                {
                    return BadRequest(new { message = "Município de descarga é obrigatório" });
                }

                string dataEncerramentoStr = request.DataEncerramento.ToString("yyyy-MM-ddTHH:mm:ss-03:00");
                
                string retorno = await _acbrService.EncerrarMDFeAsync(id, request.MunicipioDescarga, dataEncerramentoStr);

                return Ok(new { retorno = retorno, message = "MDFe encerrado com sucesso" });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Erro ao encerrar MDFe", error = ex.Message });
            }
        }

        [HttpGet("{id}/imprimir")]
        public async Task<ActionResult> ImprimirDAMDFe(int id)
        {
            try
            {
                var pdfBytes = await _acbrService.GerarDAMDFeAsync(id);
                
                return File(pdfBytes, "application/pdf", $"DAMDFe_{id}.pdf");
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Erro ao gerar PDF", error = ex.Message });
            }
        }

        [HttpGet("status-servico/{codigoUf}")]
        public async Task<ActionResult<string>> ConsultarStatusServico(int codigoUf)
        {
            try
            {
                string retorno = await _acbrService.ConsultarStatusServicoAsync(codigoUf);

                return Ok(new { retorno = retorno, message = "Status do serviço consultado com sucesso" });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Erro ao consultar status do serviço", error = ex.Message });
            }
        }

        // Novos métodos para a interface MDFe Editor

        [HttpPost("carregar-ini")]
        public async Task<ActionResult> CarregarINI([FromBody] MDFeData mdfeData)
        {
            try
            {
                // Converter dados do frontend para INI e carregar na ACBrLib
                string iniPath = await _acbrService.GerarArquivoINIAsync(mdfeData);
                bool sucesso = await _acbrService.CarregarINIAsync(iniPath);

                if (sucesso)
                {
                    return Ok(new { 
                        success = true, 
                        message = "INI carregado com sucesso na ACBrLib",
                        data = new { iniPath }
                    });
                }
                else
                {
                    return BadRequest(new { 
                        success = false, 
                        message = "Erro ao carregar INI na ACBrLib" 
                    });
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { 
                    success = false, 
                    message = "Erro interno do servidor", 
                    error = ex.Message 
                });
            }
        }

        [HttpPost("carregar-ini-simples")]
        public async Task<ActionResult> CarregarINISimples([FromBody] DTOs.MDFeGerarINIDto dados)
        {
            try
            {
                // Buscar dados automaticamente e gerar INI
                string iniPath = await _acbrService.GerarArquivoINIAsync(dados);
                bool sucesso = await _acbrService.CarregarINIAsync(iniPath);

                if (sucesso)
                {
                    return Ok(new { 
                        success = true, 
                        message = "INI gerado e carregado com sucesso na ACBrLib",
                        data = new { iniPath }
                    });
                }
                else
                {
                    return BadRequest(new { 
                        success = false, 
                        message = "Erro ao carregar INI na ACBrLib" 
                    });
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { 
                    success = false, 
                    message = "Erro interno ao carregar INI", 
                    errorCode = "INTERNAL_ERROR",
                    details = ex.Message 
                });
            }
        }

        [HttpPost("assinar")]
        public async Task<ActionResult> Assinar()
        {
            try
            {
                bool sucesso = await _acbrService.AssinarAsync();

                if (sucesso)
                {
                    return Ok(new { 
                        success = true, 
                        message = "MDF-e assinado com sucesso" 
                    });
                }
                else
                {
                    return BadRequest(new { 
                        success = false, 
                        message = "Erro ao assinar MDF-e" 
                    });
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { 
                    success = false, 
                    message = "Erro interno ao assinar", 
                    errorCode = "INTERNAL_ERROR",
                    details = ex.Message 
                });
            }
        }

        [HttpPost("validar")]
        public async Task<ActionResult> Validar()
        {
            try
            {
                var resultado = await _acbrService.ValidarAsync();

                return Ok(new { 
                    success = true, 
                    message = "Validação concluída",
                    data = resultado
                });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { 
                    success = false, 
                    message = "Erro ao validar MDF-e", 
                    errorCode = "VALIDATION_ERROR",
                    details = ex.Message 
                });
            }
        }

        [HttpPost("enviar")]
        public async Task<ActionResult> Enviar([FromBody] EnviarRequest request)
        {
            try
            {
                var resultado = await _acbrService.EnviarAsync(request.Sincrono);

                return Ok(new { 
                    success = true, 
                    message = request.Sincrono ? "Envio síncrono concluído" : "Envio assíncrono iniciado",
                    data = resultado
                });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { 
                    success = false, 
                    message = "Erro ao enviar MDF-e", 
                    errorCode = "SEND_ERROR",
                    details = ex.Message 
                });
            }
        }

        [HttpGet("consultar-recibo/{numeroRecibo}")]
        public async Task<ActionResult> ConsultarRecibo(string numeroRecibo)
        {
            try
            {
                var resultado = await _acbrService.ConsultarReciboAsync(numeroRecibo);

                return Ok(new { 
                    success = true, 
                    message = "Consulta de recibo realizada",
                    data = resultado
                });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { 
                    success = false, 
                    message = "Erro ao consultar recibo", 
                    errorCode = "RECEIPT_ERROR",
                    details = ex.Message 
                });
            }
        }

        [HttpGet("consultar/{chaveAcesso}")]
        public async Task<ActionResult> ConsultarMDFeByChave(string chaveAcesso)
        {
            try
            {
                var resultado = await _acbrService.ConsultarMDFeByChaveAsync(chaveAcesso);

                return Ok(new { 
                    success = true, 
                    message = "Consulta de MDF-e realizada",
                    data = resultado
                });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { 
                    success = false, 
                    message = "Erro ao consultar MDF-e", 
                    errorCode = "QUERY_ERROR",
                    details = ex.Message 
                });
            }
        }

        [HttpPost("imprimir")]
        public async Task<ActionResult> Imprimir()
        {
            try
            {
                var resultado = await _acbrService.ImprimirDAMDFEAsync();

                return Ok(new { 
                    success = true, 
                    message = "DAMDFE gerado com sucesso",
                    data = resultado
                });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { 
                    success = false, 
                    message = "Erro ao imprimir DAMDFE", 
                    errorCode = "PRINT_ERROR",
                    details = ex.Message 
                });
            }
        }

        [HttpPost("cancelar")]
        public async Task<ActionResult> CancelarMDFeSimples()
        {
            try
            {
                var resultado = await _acbrService.CancelarMDFeSimplesAsync();

                return Ok(new { 
                    success = true, 
                    message = "MDF-e cancelado com sucesso",
                    data = resultado
                });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { 
                    success = false, 
                    message = "Erro ao cancelar MDF-e", 
                    errorCode = "CANCEL_ERROR",
                    details = ex.Message 
                });
            }
        }

        [HttpPost("encerrar")]
        public async Task<ActionResult> EncerrarMDFeSimples()
        {
            try
            {
                var resultado = await _acbrService.EncerrarMDFeSimplesAsync();

                return Ok(new { 
                    success = true, 
                    message = "MDF-e encerrado com sucesso",
                    data = resultado
                });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { 
                    success = false, 
                    message = "Erro ao encerrar MDF-e", 
                    errorCode = "CLOSE_ERROR",
                    details = ex.Message 
                });
            }
        }

        [HttpPost("salvar-rascunho")]
        public async Task<ActionResult> SalvarRascunho([FromBody] MDFeData mdfeData)
        {
            try
            {
                // Salvar dados como rascunho no banco ou cache
                var rascunhoId = await _mdfeService.SalvarRascunhoAsync(mdfeData);

                return Ok(new { 
                    success = true, 
                    message = "Rascunho salvo com sucesso",
                    data = new { id = rascunhoId }
                });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { 
                    success = false, 
                    message = "Erro ao salvar rascunho", 
                    errorCode = "SAVE_ERROR",
                    details = ex.Message 
                });
            }
        }

        [HttpGet("carregar-rascunho/{id}")]
        public async Task<ActionResult> CarregarRascunho(string id)
        {
            try
            {
                var rascunho = await _mdfeService.CarregarRascunhoAsync(id);

                if (rascunho == null)
                {
                    return NotFound(new { 
                        success = false, 
                        message = "Rascunho não encontrado" 
                    });
                }

                return Ok(new { 
                    success = true, 
                    message = "Rascunho carregado com sucesso",
                    data = rascunho
                });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { 
                    success = false, 
                    message = "Erro ao carregar rascunho", 
                    errorCode = "LOAD_ERROR",
                    details = ex.Message 
                });
            }
        }

        [HttpGet("status")]
        public async Task<ActionResult> ObterStatus()
        {
            try
            {
                var status = await _acbrService.ObterStatusAsync();

                return Ok(new { 
                    success = true, 
                    message = "Status obtido com sucesso",
                    data = status
                });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { 
                    success = false, 
                    message = "Erro ao obter status", 
                    errorCode = "STATUS_ERROR",
                    details = ex.Message 
                });
            }
        }

        [HttpGet("proximo-numero")]
        public async Task<ActionResult> ObterProximoNumero([FromQuery] string? emitenteCnpj)
        {
            try
            {
                // Buscar o último número emitido na base
                var ultimoNumero = await _context.MDFes
                    .Where(m => m.Ativo)
                    .MaxAsync(m => (int?)m.NumeroMdfe) ?? 0;

                // Se não há nenhum MDF-e na base, começar do 612
                var proximoNumero = ultimoNumero == 0 ? 612 : ultimoNumero + 1;

                return Ok(new { 
                    proximoNumero = proximoNumero,
                    ultimoNumero = ultimoNumero,
                    success = true
                });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao buscar próximo número MDFe");
                // Fallback para 612 em caso de erro
                return Ok(new { 
                    proximoNumero = 612,
                    ultimoNumero = 0,
                    success = true
                });
            }
        }
        // Endpoint para criar/atualizar documentos fiscais de um MDF-e
        [HttpPost("{id}/documentos-fiscais")]
        public async Task<ActionResult<MDFeDocumentosFiscaisResponseDTO>> CreateOrUpdateDocumentosFiscais(int id, [FromBody] MDFeDocumentosFiscaisCreateDTO dto)
        {
            try
            {
                var mdfe = await _context.MDFes.FindAsync(id);
                if (mdfe == null || !mdfe.Ativo)
                {
                    return NotFound(new { message = "MDF-e não encontrado" });
                }

                if (mdfe.StatusSefaz == "AUTORIZADO" || mdfe.StatusSefaz == "REJEITADO")
                {
                    return BadRequest(new { message = "MDF-e não pode ser editado após transmissão" });
                }

                using var transaction = await _context.Database.BeginTransactionAsync();

                // Remover documentos existentes
                var documentosExistentes = await _context.MDFeCtes
                    .Where(d => d.MDFeId == id)
                    .ToListAsync();
                _context.MDFeCtes.RemoveRange(documentosExistentes);

                var nfesExistentes = await _context.MDFeNfes
                    .Where(d => d.MDFeId == id)
                    .ToListAsync();
                _context.MDFeNfes.RemoveRange(nfesExistentes);

                var mdfeTranspExistentes = await _context.MDFeMdfeTransps
                    .Where(d => d.MDFeId == id)
                    .ToListAsync();
                _context.MDFeMdfeTransps.RemoveRange(mdfeTranspExistentes);

                var lacresExistentes = await _context.MDFeLacresRodoviarios
                    .Where(l => l.MDFeId == id)
                    .ToListAsync();
                _context.MDFeLacresRodoviarios.RemoveRange(lacresExistentes);

                // Adicionar novos documentos e lacres
                foreach (var municipio in dto.MunicipiosDescarga)
                {
                    // Validar município
                    var municipioBanco = await _context.Municipios.FindAsync(municipio.MunicipioId);
                    if (municipioBanco == null || !municipioBanco.Ativo)
                    {
                        return BadRequest(new { message = $"Município {municipio.MunicipioId} não encontrado" });
                    }

                    // Processar CT-es
                    foreach (var cteDto in municipio.DocumentosCte)
                    {
                        var cte = new MDFeCte
                        {
                            MDFeId = id,
                            MunicipioDescargaId = municipio.MunicipioId,
                            ChaveCte = cteDto.ChaveCte,
                            SegundoCodigoBarras = cteDto.SegundoCodigoBarras,
                            IndicadorReentrega = cteDto.IndicadorReentrega,
                            IndicadorPrestacaoParcial = cteDto.IndicadorPrestacaoParcial
                        };

                        _context.MDFeCtes.Add(cte);
                        await _context.SaveChangesAsync(); // Para obter o ID

                        // Processar unidades de transporte
                        await ProcessarUnidadesTransporte(cte.Id, cteDto.UnidadesTransporte, "CTE");

                        // Processar produtos perigosos
                        await ProcessarProdutosPerigosos(cte.Id, cteDto.ProdutosPerigosos, "CTE");

                        // Processar entrega parcial
                        if (cteDto.EntregaParcial != null)
                        {
                            var entregaParcial = new MDFeEntregaParcial
                            {
                                MDFeCteId = cte.Id,
                                QuantidadeTotal = cteDto.EntregaParcial.QuantidadeTotal,
                                QuantidadeParcial = cteDto.EntregaParcial.QuantidadeParcial
                            };
                            _context.MDFeEntregasParciais.Add(entregaParcial);
                        }
                    }

                    // Processar NF-es
                    foreach (var nfeDto in municipio.DocumentosNfe)
                    {
                        var nfe = new MDFeNfe
                        {
                            MDFeId = id,
                            MunicipioDescargaId = municipio.MunicipioId,
                            ChaveNfe = nfeDto.ChaveNfe,
                            SegundoCodigoBarras = nfeDto.SegundoCodigoBarras,
                            IndicadorReentrega = nfeDto.IndicadorReentrega,
                            PinSuframa = nfeDto.PinSuframa,
                            DataPrevistaEntrega = nfeDto.DataPrevistaEntrega
                        };

                        _context.MDFeNfes.Add(nfe);
                        await _context.SaveChangesAsync();

                        await ProcessarUnidadesTransporte(nfe.Id, nfeDto.UnidadesTransporte, "NFE");
                        await ProcessarProdutosPerigosos(nfe.Id, nfeDto.ProdutosPerigosos, "NFE");

                        if (nfeDto.EntregaParcial != null)
                        {
                            var entregaParcial = new MDFeEntregaParcial
                            {
                                MDFeNfeId = nfe.Id,
                                QuantidadeTotal = nfeDto.EntregaParcial.QuantidadeTotal,
                                QuantidadeParcial = nfeDto.EntregaParcial.QuantidadeParcial
                            };
                            _context.MDFeEntregasParciais.Add(entregaParcial);
                        }
                    }

                    // Processar MDF-e Transporte
                    foreach (var mdfeTranspDto in municipio.DocumentosMdfeTransp)
                    {
                        var mdfeTransp = new MDFeMdfeTransp
                        {
                            MDFeId = id,
                            MunicipioDescargaId = municipio.MunicipioId,
                            ChaveMdfeTransp = mdfeTranspDto.ChaveMdfeTransp,
                            IndicadorReentrega = mdfeTranspDto.IndicadorReentrega,
                            QuantidadeRateada = mdfeTranspDto.QuantidadeRateada
                        };

                        _context.MDFeMdfeTransps.Add(mdfeTransp);
                        await _context.SaveChangesAsync();

                        await ProcessarUnidadesTransporte(mdfeTransp.Id, mdfeTranspDto.UnidadesTransporte, "MDFE_TRANSP");
                        await ProcessarProdutosPerigosos(mdfeTransp.Id, mdfeTranspDto.ProdutosPerigosos, "MDFE_TRANSP");
                    }
                }

                // Processar lacres rodoviários
                foreach (var lacreDto in dto.LacresRodoviarios)
                {
                    var lacre = new MDFeLacreRodoviario
                    {
                        MDFeId = id,
                        NumeroLacre = lacreDto.NumeroLacre
                    };
                    _context.MDFeLacresRodoviarios.Add(lacre);
                }

                await _context.SaveChangesAsync();
                await transaction.CommitAsync();

                // Retornar dados atualizados
                var response = await ObterDocumentosFiscais(id);
                return Ok(response.Value);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Erro ao salvar documentos fiscais", error = ex.Message });
            }
        }

        // Endpoint para obter documentos fiscais de um MDF-e
        [HttpGet("{id}/documentos-fiscais")]
        public async Task<ActionResult<MDFeDocumentosFiscaisResponseDTO>> ObterDocumentosFiscais(int id)
        {
            try
            {
                var mdfe = await _context.MDFes.FindAsync(id);
                if (mdfe == null || !mdfe.Ativo)
                {
                    return NotFound(new { message = "MDF-e não encontrado" });
                }

                var ctes = await _context.MDFeCtes
                    .Include(c => c.MunicipioDescarga)
                    .Where(c => c.MDFeId == id)
                    .ToListAsync();

                var nfes = await _context.MDFeNfes
                    .Include(n => n.MunicipioDescarga)
                    .Where(n => n.MDFeId == id)
                    .ToListAsync();

                var mdfeTransps = await _context.MDFeMdfeTransps
                    .Include(m => m.MunicipioDescarga)
                    .Where(m => m.MDFeId == id)
                    .ToListAsync();

                var lacres = await _context.MDFeLacresRodoviarios
                    .Where(l => l.MDFeId == id)
                    .ToListAsync();

                // Agrupar por município
                var municipiosGroup = ctes.Select(c => c.MunicipioDescarga)
                    .Union(nfes.Select(n => n.MunicipioDescarga))
                    .Union(mdfeTransps.Select(m => m.MunicipioDescarga))
                    .Distinct()
                    .ToList();

                var municipiosDescarga = new List<MDFeMunicipioDescargaDTO>();

                foreach (var municipio in municipiosGroup)
                {
                    var municipioDto = new MDFeMunicipioDescargaDTO
                    {
                        MunicipioId = municipio?.Id ?? 0,
                        NomeMunicipio = municipio?.Nome ?? string.Empty,
                        DocumentosCte = ctes.Where(c => c.MunicipioDescargaId == municipio?.Id)
                            .Select(c => new MDFeCteDTO
                            {
                                Id = c.Id,
                                ChaveCte = c.ChaveCte,
                                SegundoCodigoBarras = c.SegundoCodigoBarras,
                                IndicadorReentrega = c.IndicadorReentrega,
                                IndicadorPrestacaoParcial = c.IndicadorPrestacaoParcial
                            }).ToList(),
                        DocumentosNfe = nfes.Where(n => n.MunicipioDescargaId == municipio?.Id)
                            .Select(n => new MDFeNfeDTO
                            {
                                Id = n.Id,
                                ChaveNfe = n.ChaveNfe,
                                SegundoCodigoBarras = n.SegundoCodigoBarras,
                                IndicadorReentrega = n.IndicadorReentrega,
                                PinSuframa = n.PinSuframa,
                                DataPrevistaEntrega = n.DataPrevistaEntrega
                            }).ToList(),
                        DocumentosMdfeTransp = mdfeTransps.Where(m => m.MunicipioDescargaId == municipio?.Id)
                            .Select(m => new MDFeMdfeTranspDTO
                            {
                                Id = m.Id,
                                ChaveMdfeTransp = m.ChaveMdfeTransp,
                                IndicadorReentrega = m.IndicadorReentrega,
                                QuantidadeRateada = m.QuantidadeRateada
                            }).ToList()
                    };

                    municipiosDescarga.Add(municipioDto);
                }

                var response = new MDFeDocumentosFiscaisResponseDTO
                {
                    MDFeId = id,
                    MunicipiosDescarga = municipiosDescarga,
                    LacresRodoviarios = lacres.Select(l => new MDFeLacreRodoviarioDTO
                    {
                        Id = l.Id,
                        NumeroLacre = l.NumeroLacre
                    }).ToList(),
                    TotalDocumentosCte = ctes.Count,
                    TotalDocumentosNfe = nfes.Count,
                    TotalDocumentosMdfeTransp = mdfeTransps.Count,
                    TotalLacres = lacres.Count
                };

                return Ok(response);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Erro ao obter documentos fiscais", error = ex.Message });
            }
        }

        private async Task ProcessarUnidadesTransporte(int documentoId, List<MDFeUnidadeTransporteDTO> unidadesDto, string tipoDocumento)
        {
            if (unidadesDto == null || !unidadesDto.Any()) return;

            foreach (var unidadeDto in unidadesDto)
            {
                var unidade = new MDFeUnidadeTransporte
                {
                    TipoUnidadeTransporte = unidadeDto.TipoUnidadeTransporte,
                    IdentificacaoUnidadeTransporte = unidadeDto.IdentificacaoUnidadeTransporte,
                    QuantidadeRateada = unidadeDto.QuantidadeRateada
                };

                // Definir relacionamento baseado no tipo de documento
                switch (tipoDocumento)
                {
                    case "CTE":
                        unidade.MDFeCteId = documentoId;
                        break;
                    case "NFE":
                        unidade.MDFeNfeId = documentoId;
                        break;
                    case "MDFE_TRANSP":
                        unidade.MDFeMdfeTranspId = documentoId;
                        break;
                }

                _context.MDFeUnidadesTransporte.Add(unidade);
                await _context.SaveChangesAsync();

                // Processar lacres da unidade
                foreach (var lacre in unidadeDto.Lacres)
                {
                    var lacreUnidade = new MDFeLacreUnidadeTransporte
                    {
                        MDFeUnidadeTransporteId = unidade.Id,
                        NumeroLacre = lacre
                    };
                    _context.MDFeLacresUnidadeTransporte.Add(lacreUnidade);
                }

                // Processar unidades de carga
                foreach (var unidadeCargaDto in unidadeDto.UnidadesCarga)
                {
                    var unidadeCarga = new MDFeUnidadeCarga
                    {
                        MDFeUnidadeTransporteId = unidade.Id,
                        TipoUnidadeCarga = unidadeCargaDto.TipoUnidadeCarga,
                        IdentificacaoUnidadeCarga = unidadeCargaDto.IdentificacaoUnidadeCarga,
                        QuantidadeRateada = unidadeCargaDto.QuantidadeRateada
                    };

                    _context.MDFeUnidadesCarga.Add(unidadeCarga);
                    await _context.SaveChangesAsync();

                    // Processar lacres da unidade de carga
                    foreach (var lacre in unidadeCargaDto.Lacres)
                    {
                        var lacreUnidadeCarga = new MDFeLacreUnidadeCarga
                        {
                            MDFeUnidadeCargaId = unidadeCarga.Id,
                            NumeroLacre = lacre
                        };
                        _context.MDFeLacresUnidadeCarga.Add(lacreUnidadeCarga);
                    }
                }
            }
        }

        private Task ProcessarProdutosPerigosos(int documentoId, List<MDFeProdutoPerigososDTO> produtosDto, string tipoDocumento)
        {
            if (produtosDto == null || !produtosDto.Any()) return Task.CompletedTask;

            foreach (var produtoDto in produtosDto)
            {
                var produto = new MDFeProdutoPerigoso
                {
                    NumeroONU = produtoDto.NumeroONU,
                    NomeApropriado = produtoDto.NomeApropriado,
                    ClasseRisco = produtoDto.ClasseRisco,
                    GrupoEmbalagem = produtoDto.GrupoEmbalagem,
                    QuantidadeTotalProduto = produtoDto.QuantidadeTotalProduto,
                    QuantidadeVolumoTipo = produtoDto.QuantidadeVolumoTipo
                };

                // Definir relacionamento baseado no tipo de documento
                switch (tipoDocumento)
                {
                    case "CTE":
                        produto.MDFeCteId = documentoId;
                        break;
                    case "NFE":
                        produto.MDFeNfeId = documentoId;
                        break;
                    case "MDFE_TRANSP":
                        produto.MDFeMdfeTranspId = documentoId;
                        break;
                }

                _context.MDFeProdutosPerigosos.Add(produto);
            }

            return Task.CompletedTask;
        }

        // Endpoints específicos para Pagamentos e Seguros
        [HttpPut("{id}/pagamentos")]
        public async Task<ActionResult> AtualizarPagamentos(int id, [FromBody] MDFePagamentosDto pagamentosDto)
        {
            try
            {
                var mdfe = await _context.MDFes.FindAsync(id);
                if (mdfe == null || !mdfe.Ativo)
                {
                    return NotFound(new { message = "MDFe não encontrado" });
                }

                // Serializar componentes de pagamento para JSON
                if (pagamentosDto.ComponentesPagamento != null)
                {
                    mdfe.ComponentesPagamentoJson = System.Text.Json.JsonSerializer.Serialize(pagamentosDto.ComponentesPagamento);
                    mdfe.ValorTotalContrato = pagamentosDto.ComponentesPagamento.Sum(c => c.Valor);
                    mdfe.TipoPagamento = "0"; // À vista por padrão
                }

                // Serializar vales-pedágio para JSON
                if (pagamentosDto.ValesPedagio != null)
                {
                    mdfe.ValesPedagioJson = System.Text.Json.JsonSerializer.Serialize(pagamentosDto.ValesPedagio);
                    mdfe.SemValePedagio = pagamentosDto.ValesPedagio.Count == 0;
                }
                else
                {
                    mdfe.SemValePedagio = true;
                    mdfe.ValesPedagioJson = null;
                }

                await _context.SaveChangesAsync();

                return Ok(new {
                    success = true,
                    message = "Informações de pagamento atualizadas com sucesso"
                });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new {
                    message = "Erro ao atualizar informações de pagamento",
                    error = ex.Message
                });
            }
        }

        [HttpPut("{id}/seguro")]
        public async Task<ActionResult> AtualizarSeguro(int id, [FromBody] MDFeSeguroDto seguroDto)
        {
            try
            {
                var mdfe = await _context.MDFes.FindAsync(id);
                if (mdfe == null || !mdfe.Ativo)
                {
                    return NotFound(new { message = "MDFe não encontrado" });
                }

                // Atualizar informações de seguro
                mdfe.TipoResponsavelSeguro = seguroDto.ResponsavelSeguro.TipoResponsavel;

                if (seguroDto.SeguradoraInfo != null)
                {
                    mdfe.SeguradoraId = seguroDto.SeguradoraInfo.SeguradoraId;
                    mdfe.SeguradoraCnpj = seguroDto.SeguradoraInfo.Cnpj;
                    mdfe.SeguradoraRazaoSocial = seguroDto.SeguradoraInfo.RazaoSocial;
                    mdfe.SeguradoraCodigoSusep = seguroDto.SeguradoraInfo.CodigoSusep;
                }

                mdfe.NumeroApoliceSeguro = seguroDto.NumeroApolice;
                mdfe.NumeroAverbacaoSeguro = seguroDto.NumerosAverbacao?.FirstOrDefault();

                await _context.SaveChangesAsync();

                return Ok(new {
                    success = true,
                    message = "Informações de seguro atualizadas com sucesso"
                });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new {
                    message = "Erro ao atualizar informações de seguro",
                    error = ex.Message
                });
            }
        }

        [HttpGet("{id}/pagamentos")]
        public async Task<ActionResult<MDFePagamentosDto>> ObterPagamentos(int id)
        {
            try
            {
                var mdfe = await _context.MDFes.FindAsync(id);
                if (mdfe == null || !mdfe.Ativo)
                {
                    return NotFound(new { message = "MDFe não encontrado" });
                }

                var pagamentosDto = new MDFePagamentosDto();

                // Deserializar componentes de pagamento
                if (!string.IsNullOrEmpty(mdfe.ComponentesPagamentoJson))
                {
                    pagamentosDto.ComponentesPagamento = System.Text.Json.JsonSerializer.Deserialize<List<ComponentePagamentoDto>>(mdfe.ComponentesPagamentoJson);
                }
                else
                {
                    pagamentosDto.ComponentesPagamento = new List<ComponentePagamentoDto>();
                }

                // Deserializar vales-pedágio
                if (!string.IsNullOrEmpty(mdfe.ValesPedagioJson))
                {
                    pagamentosDto.ValesPedagio = System.Text.Json.JsonSerializer.Deserialize<List<ValePedagioDto>>(mdfe.ValesPedagioJson);
                }
                else
                {
                    pagamentosDto.ValesPedagio = new List<ValePedagioDto>();
                }

                return Ok(pagamentosDto);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new {
                    message = "Erro ao obter informações de pagamento",
                    error = ex.Message
                });
            }
        }

        [HttpGet("{id}/seguro")]
        public async Task<ActionResult<MDFeSeguroDto>> ObterSeguro(int id)
        {
            try
            {
                var mdfe = await _context.MDFes.FindAsync(id);
                if (mdfe == null || !mdfe.Ativo)
                {
                    return NotFound(new { message = "MDFe não encontrado" });
                }

                var seguroDto = new MDFeSeguroDto
                {
                    ResponsavelSeguro = new ResponsavelSeguroDto
                    {
                        TipoResponsavel = mdfe.TipoResponsavelSeguro ?? "1"
                    },
                    SeguradoraInfo = mdfe.SeguradoraId.HasValue ? new SeguradoraInfoDto
                    {
                        SeguradoraId = mdfe.SeguradoraId,
                        Cnpj = mdfe.SeguradoraCnpj ?? string.Empty,
                        RazaoSocial = mdfe.SeguradoraRazaoSocial ?? string.Empty,
                        CodigoSusep = mdfe.SeguradoraCodigoSusep
                    } : null,
                    NumeroApolice = mdfe.NumeroApoliceSeguro,
                    NumerosAverbacao = !string.IsNullOrEmpty(mdfe.NumeroAverbacaoSeguro)
                        ? new List<string> { mdfe.NumeroAverbacaoSeguro }
                        : new List<string>()
                };

                return Ok(seguroDto);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new {
                    message = "Erro ao obter informações de seguro",
                    error = ex.Message
                });
            }
        }
    }

    public class CancelarMDFeRequest
    {
        public string Justificativa { get; set; } = string.Empty;
    }

    public class EncerrarMDFeRequest
    {
        public DateTime DataEncerramento { get; set; }
        public string MunicipioDescarga { get; set; } = string.Empty;
    }

    public class EnviarRequest
    {
        public bool Sincrono { get; set; } = true;
    }

    // Classe para receber dados do frontend (compatível com o TypeScript)
    public class MDFeData
    {
        public IdeData? ide { get; set; }
        public EmitData? emit { get; set; }
        public InfModalData? infModal { get; set; }
        public InfDocData? infDoc { get; set; }
        public List<SegData>? seg { get; set; }
        public TotData? tot { get; set; }
        public InfAdicData? infAdic { get; set; }
    }

    public class IdeData
    {
        public string? cUF { get; set; }
        public string? tpAmb { get; set; }
        public string? tpEmit { get; set; }
        public string? mod { get; set; } = "58";
        public string? serie { get; set; }
        public string? nMDF { get; set; }
        public string? cMDF { get; set; }
        public string? cDV { get; set; }
        public string? modal { get; set; }
        public string? dhEmi { get; set; }
        public string? tpEmis { get; set; }
        public string? procEmi { get; set; }
        public string? verProc { get; set; }
        public string? UFIni { get; set; }
        public string? UFFim { get; set; }
    }

    public class EmitData
    {
        public string? CNPJ { get; set; }
        public string? IE { get; set; }
        public string? xNome { get; set; }
        public string? xFant { get; set; }
        public EnderEmitData? enderEmit { get; set; }
    }

    public class EnderEmitData
    {
        public string? xLgr { get; set; }
        public string? nro { get; set; }
        public string? xCpl { get; set; }
        public string? xBairro { get; set; }
        public string? cMun { get; set; }
        public string? xMun { get; set; }
        public string? CEP { get; set; }
        public string? UF { get; set; }
    }

    public class InfModalData
    {
        public string? versaoModal { get; set; }
        public RodoData? rodo { get; set; }
    }

    public class RodoData
    {
        public InfANTTData? infANTT { get; set; }
        public VeicTracaoData? veicTracao { get; set; }
        public List<VeicReboqueData>? veicReboque { get; set; }
    }

    public class InfANTTData
    {
        public string? RNTRC { get; set; }
    }

    public class VeicTracaoData
    {
        public string? cInt { get; set; }
        public string? placa { get; set; }
        public string? RENAVAM { get; set; }
        public string? tara { get; set; }
        public string? capKG { get; set; }
        public string? capM3 { get; set; }
        public string? tpRod { get; set; }
        public string? tpCar { get; set; }
        public string? UF { get; set; }
        public List<CondutorData>? condutor { get; set; }
    }

    public class VeicReboqueData
    {
        public string? cInt { get; set; }
        public string? placa { get; set; }
        public string? RENAVAM { get; set; }
        public string? tara { get; set; }
        public string? capKG { get; set; }
        public string? capM3 { get; set; }
        public string? tpCar { get; set; }
        public string? UF { get; set; }
    }

    public class CondutorData
    {
        public string? xNome { get; set; }
        public string? CPF { get; set; }
    }

    public class InfDocData
    {
        public List<InfMunCarregaData>? infMunCarrega { get; set; }
        public List<InfMunDescargaData>? infMunDescarga { get; set; }
    }

    public class InfMunCarregaData
    {
        public string? cMunCarrega { get; set; }
        public string? xMunCarrega { get; set; }
    }

    public class InfMunDescargaData
    {
        public string? cMunDescarga { get; set; }
        public string? xMunDescarga { get; set; }
        public List<InfCTeData>? infCTe { get; set; }
        public List<InfNFeData>? infNFe { get; set; }
    }

    public class InfCTeData
    {
        public string? chCTe { get; set; }
        public string? SegCodBarra { get; set; }
    }

    public class InfNFeData
    {
        public string? chNFe { get; set; }
        public string? SegCodBarra { get; set; }
        public string? PIN { get; set; }
    }

    public class SegData
    {
        public InfRespData? infResp { get; set; }
        public InfSegData? infSeg { get; set; }
        public string? nApol { get; set; }
        public List<string>? nAver { get; set; }
    }

    public class InfRespData
    {
        public string? respSeg { get; set; }
        public string? CNPJ { get; set; }
        public string? CPF { get; set; }
    }

    public class InfSegData
    {
        public string? xSeg { get; set; }
        public string? CNPJ { get; set; }
    }

    public class TotData
    {
        public string? qCTe { get; set; }
        public string? qNFe { get; set; }
        public string? qMDFe { get; set; }
        public string? vCarga { get; set; }
        public string? cUnid { get; set; }
        public string? qCarga { get; set; }
    }

    public class InfAdicData
    {
        public string? infCpl { get; set; }
    }
}