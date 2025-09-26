using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MDFeApi.Data;
using MDFeApi.Models;
using MDFeApi.DTOs;
using MDFeApi.Services;
using MDFeApi.Utils;
using MDFeApi.Helpers;
using MDFeApi.Extensions;

namespace MDFeApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    // [Authorize] // Temporariamente removido para testes
    public class EmitentesController : ControllerBase
    {
        private readonly MDFeContext _context;
        private readonly ICertificadoService _certificadoService;
        private readonly ILogger<EmitentesController> _logger;

        public EmitentesController(
            MDFeContext context,
            ICertificadoService certificadoService,
            ILogger<EmitentesController> logger)
        {
            _context = context;
            _certificadoService = certificadoService;
            _logger = logger;
        }


        [HttpGet]
        public async Task<ActionResult<PaginationResult<EmitenteResponseDto>>> GetEmitentes([FromQuery] PaginationRequest request)
        {
            try
            {
                var query = _context.Emitentes
                    .Where(e => e.Ativo)
                    .AsQueryable();

                // Filtrar por busca se fornecido
                if (!string.IsNullOrWhiteSpace(request.Search))
                {
                    var searchTerm = request.Search.ToLower();
                    query = query.Where(e =>
                        e.RazaoSocial.ToLower().Contains(searchTerm) ||
                        (e.Cnpj != null && e.Cnpj.Contains(searchTerm)) ||
                        (e.NomeFantasia != null && e.NomeFantasia.ToLower().Contains(searchTerm)) ||
                        (e.Cpf != null && e.Cpf.Contains(searchTerm))
                    );
                }

                // Aplicar ordenação
                switch (request.SortBy?.ToLower())
                {
                    case "cnpj":
                        query = request.SortDirection?.ToLower() == "desc" ?
                            query.OrderByDescending(e => e.Cnpj) :
                            query.OrderBy(e => e.Cnpj);
                        break;
                    case "datacriacao":
                        query = request.SortDirection?.ToLower() == "desc" ?
                            query.OrderByDescending(e => e.DataCriacao) :
                            query.OrderBy(e => e.DataCriacao);
                        break;
                    default:
                        query = request.SortDirection?.ToLower() == "desc" ?
                            query.OrderByDescending(e => e.RazaoSocial) :
                            query.OrderBy(e => e.RazaoSocial);
                        break;
                }

                var queryProjected = query.Select(e => new EmitenteResponseDto
                {
                    Id = e.Id,
                    Cnpj = e.Cnpj,
                    Cpf = e.Cpf,
                    Ie = e.Ie,
                    RazaoSocial = e.RazaoSocial,
                    NomeFantasia = e.NomeFantasia,
                    Endereco = e.Endereco,
                    Numero = e.Numero,
                    Complemento = e.Complemento,
                    Bairro = e.Bairro,
                    CodMunicipio = e.CodMunicipio,
                    Municipio = e.Municipio,
                    Cep = e.Cep,
                    Uf = e.Uf,
                    Ativo = e.Ativo,
                    TipoEmitente = e.TipoEmitente,
                    CaminhoArquivoCertificado = e.CaminhoArquivoCertificado,
                    Rntrc = e.Rntrc,
                    DataCriacao = e.DataCriacao
                });

                var result = await queryProjected.ToPaginatedListAsync(request);
                return Ok(result);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao obter emitentes paginados");
                return StatusCode(500, new { message = "Erro interno do servidor", error = ex.Message });
            }
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<ApiResponse<EmitenteResponseDto>>> GetEmitente(int id)
        {
            var emitente = await _context.Emitentes.FindAsync(id);

            if (emitente == null || !emitente.Ativo)
            {
                return NotFound(ApiResponseHelper.NotFound("Emitente não encontrado"));
            }

            var responseDto = new EmitenteResponseDto
            {
                Id = emitente.Id,
                Cnpj = emitente.Cnpj,
                Cpf = emitente.Cpf,
                Ie = emitente.Ie,
                RazaoSocial = emitente.RazaoSocial,
                NomeFantasia = emitente.NomeFantasia,
                Endereco = emitente.Endereco,
                Numero = emitente.Numero,
                Complemento = emitente.Complemento,
                Bairro = emitente.Bairro,
                CodMunicipio = emitente.CodMunicipio,
                Municipio = emitente.Municipio,
                Cep = emitente.Cep,
                Uf = emitente.Uf,
                Ativo = emitente.Ativo,
                TipoEmitente = emitente.TipoEmitente,
                CaminhoArquivoCertificado = emitente.CaminhoArquivoCertificado,
                Rntrc = emitente.Rntrc,
                DataCriacao = emitente.DataCriacao
            };

            var response = ApiResponseHelper.Success(responseDto, "Emitente obtido com sucesso");
            return Ok(response);
        }

        [HttpPost]
        public async Task<ActionResult<EmitenteResponseDto>> CreateEmitente(EmitenteCreateDto emitenteDto)
        {
            try
            {
                // Validar se CNPJ ou CPF já existe (usando documentos limpos)
                if (!string.IsNullOrWhiteSpace(emitenteDto.Cnpj))
                {
                    var cnpjLimpo = DocumentUtils.LimparCnpj(emitenteDto.Cnpj);
                    var existingCnpj = await _context.Emitentes
                        .AnyAsync(e => e.Cnpj == cnpjLimpo && e.Ativo);
                    if (existingCnpj)
                    {
                        return BadRequest(new { message = "CNPJ já cadastrado" });
                    }
                }

                if (!string.IsNullOrWhiteSpace(emitenteDto.Cpf))
                {
                    var cpfLimpo = DocumentUtils.LimparCpf(emitenteDto.Cpf);
                    var existingCpf = await _context.Emitentes
                        .AnyAsync(e => e.Cpf == cpfLimpo && e.Ativo);
                    if (existingCpf)
                    {
                        return BadRequest(new { message = "CPF já cadastrado" });
                    }
                }

                var emitente = new Emitente
                {
                    Cnpj = string.IsNullOrWhiteSpace(emitenteDto.Cnpj) ? null : emitenteDto.Cnpj,
                    Cpf = string.IsNullOrWhiteSpace(emitenteDto.Cpf) ? null : emitenteDto.Cpf,
                    Ie = string.IsNullOrWhiteSpace(emitenteDto.Ie) ? null : emitenteDto.Ie,
                    RazaoSocial = emitenteDto.RazaoSocial,
                    NomeFantasia = string.IsNullOrWhiteSpace(emitenteDto.NomeFantasia) ? null : emitenteDto.NomeFantasia,
                    Endereco = emitenteDto.Endereco,
                    Numero = string.IsNullOrWhiteSpace(emitenteDto.Numero) ? null : emitenteDto.Numero,
                    Complemento = string.IsNullOrWhiteSpace(emitenteDto.Complemento) ? null : emitenteDto.Complemento,
                    Bairro = emitenteDto.Bairro,
                    CodMunicipio = emitenteDto.CodMunicipio,
                    Municipio = emitenteDto.Municipio,
                    Cep = emitenteDto.Cep,
                    Uf = emitenteDto.Uf,
                    Ativo = true,
                    TipoEmitente = emitenteDto.TipoEmitente,
                    CaminhoArquivoCertificado = string.IsNullOrWhiteSpace(emitenteDto.CaminhoArquivoCertificado) ? null : emitenteDto.CaminhoArquivoCertificado,
                    SenhaCertificado = string.IsNullOrWhiteSpace(emitenteDto.SenhaCertificado) ? null : emitenteDto.SenhaCertificado,
                    Rntrc = string.IsNullOrWhiteSpace(emitenteDto.Rntrc) ? null : emitenteDto.Rntrc,
                };

                // Limpar documentos antes de salvar
                DocumentUtils.LimparDocumentosEmitente(emitente);

                _context.Emitentes.Add(emitente);
                await _context.SaveChangesAsync();

                var responseDto = new EmitenteResponseDto
                {
                    Id = emitente.Id,
                    Cnpj = emitente.Cnpj,
                    Cpf = emitente.Cpf,
                    Ie = emitente.Ie,
                    RazaoSocial = emitente.RazaoSocial,
                    NomeFantasia = emitente.NomeFantasia,
                    Endereco = emitente.Endereco,
                    Numero = emitente.Numero,
                    Complemento = emitente.Complemento,
                    Bairro = emitente.Bairro,
                    CodMunicipio = emitente.CodMunicipio,
                    Municipio = emitente.Municipio,
                    Cep = emitente.Cep,
                    Uf = emitente.Uf,
                    Ativo = emitente.Ativo,
                    TipoEmitente = emitente.TipoEmitente,
                    CaminhoArquivoCertificado = emitente.CaminhoArquivoCertificado,
                    Rntrc = emitente.Rntrc,
                    DataCriacao = emitente.DataCriacao
                };

                return CreatedAtAction(nameof(GetEmitente), new { id = emitente.Id }, responseDto);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao criar emitente");
                return StatusCode(500, new { message = "Erro interno do servidor", error = ex.Message });
            }
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateEmitente(int id, EmitenteUpdateDto emitenteDto)
        {
            var emitente = await _context.Emitentes.FindAsync(id);
            if (emitente == null || !emitente.Ativo)
            {
                return NotFound();
            }

            try
            {
                // Validar se CNPJ ou CPF já existe (exceto para o próprio emitente, usando documentos limpos)
                if (!string.IsNullOrWhiteSpace(emitenteDto.Cnpj))
                {
                    var cnpjLimpo = DocumentUtils.LimparCnpj(emitenteDto.Cnpj);
                    if (cnpjLimpo != emitente.Cnpj)
                    {
                        var existingCnpj = await _context.Emitentes
                            .AnyAsync(e => e.Cnpj == cnpjLimpo && e.Id != id && e.Ativo);
                        if (existingCnpj)
                        {
                            return BadRequest(new { message = "CNPJ já cadastrado" });
                        }
                    }
                }

                if (!string.IsNullOrWhiteSpace(emitenteDto.Cpf))
                {
                    var cpfLimpo = DocumentUtils.LimparCpf(emitenteDto.Cpf);
                    if (cpfLimpo != emitente.Cpf)
                    {
                        var existingCpf = await _context.Emitentes
                            .AnyAsync(e => e.Cpf == cpfLimpo && e.Id != id && e.Ativo);
                        if (existingCpf)
                        {
                            return BadRequest(new { message = "CPF já cadastrado" });
                        }
                    }
                }

                emitente.Cnpj = string.IsNullOrWhiteSpace(emitenteDto.Cnpj) ? null : emitenteDto.Cnpj;
                emitente.Cpf = string.IsNullOrWhiteSpace(emitenteDto.Cpf) ? null : emitenteDto.Cpf;
                emitente.Ie = string.IsNullOrWhiteSpace(emitenteDto.Ie) ? null : emitenteDto.Ie;
                emitente.RazaoSocial = emitenteDto.RazaoSocial;
                emitente.NomeFantasia = string.IsNullOrWhiteSpace(emitenteDto.NomeFantasia) ? null : emitenteDto.NomeFantasia;
                emitente.Endereco = emitenteDto.Endereco;
                emitente.Numero = string.IsNullOrWhiteSpace(emitenteDto.Numero) ? null : emitenteDto.Numero;
                emitente.Complemento = string.IsNullOrWhiteSpace(emitenteDto.Complemento) ? null : emitenteDto.Complemento;
                emitente.Bairro = emitenteDto.Bairro;
                emitente.CodMunicipio = emitenteDto.CodMunicipio;
                emitente.Municipio = emitenteDto.Municipio;
                emitente.Cep = emitenteDto.Cep;
                emitente.Uf = emitenteDto.Uf;
                emitente.TipoEmitente = emitenteDto.TipoEmitente;
                
                if (!string.IsNullOrWhiteSpace(emitenteDto.CaminhoArquivoCertificado))
                    emitente.CaminhoArquivoCertificado = emitenteDto.CaminhoArquivoCertificado;
                
                if (!string.IsNullOrWhiteSpace(emitenteDto.SenhaCertificado))
                    emitente.SenhaCertificado = emitenteDto.SenhaCertificado;

                emitente.Rntrc = string.IsNullOrWhiteSpace(emitenteDto.Rntrc) ? null : emitenteDto.Rntrc;
                emitente.DataAtualizacao = DateTime.Now;

                // Limpar documentos antes de salvar
                DocumentUtils.LimparDocumentosEmitente(emitente);

                await _context.SaveChangesAsync();

                return NoContent();
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao atualizar emitente {EmitenteId}", id);
                return StatusCode(500, new { message = "Erro interno do servidor", error = ex.Message });
            }
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteEmitente(int id)
        {
            var emitente = await _context.Emitentes.FindAsync(id);
            if (emitente == null)
            {
                return NotFound(new { message = "Emitente não encontrado" });
            }

            if (!emitente.Ativo)
            {
                return BadRequest(new { message = "Emitente já está inativo" });
            }

            try
            {
                // Verificar se tem MDF-e vinculados
                var temMdfe = await _context.MDFes.AnyAsync(m => m.EmitenteId == id);
                if (temMdfe)
                {
                    return BadRequest(new { message = "Não é possível excluir emitente com MDF-e vinculados. Exclua ou transfira os MDF-e primeiro." });
                }

                // Soft delete
                emitente.Ativo = false;
                emitente.DataAtualizacao = DateTime.Now;
                await _context.SaveChangesAsync();

                _logger.LogInformation("Emitente {EmitenteId} ({RazaoSocial}) foi inativado com sucesso", id, emitente.RazaoSocial);
                return Ok(new { message = "Emitente excluído com sucesso" });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao deletar emitente {EmitenteId}", id);
                return StatusCode(500, new { message = "Erro interno do servidor ao excluir emitente", error = ex.Message });
            }
        }

        // ##### METHODS MOVED FROM EMITENTESCONTROLLER #####

        [HttpGet("listar")]
        public async Task<ActionResult<IEnumerable<EmitenteListDto>>> ListarEmitentes()
        {
            try
            {
                var emitentes = await _context.Emitentes
                    .Select(e => new EmitenteListDto
                    {
                        Id = e.Id,
                        RazaoSocial = e.RazaoSocial,
                        NomeFantasia = e.NomeFantasia,
                        Cnpj = e.Cnpj,
                        Cpf = e.Cpf,
                        TipoEmitente = e.TipoEmitente,
                        TemCertificado = !string.IsNullOrEmpty(e.CaminhoArquivoCertificado),
                        AmbienteSefaz = e.AmbienteSefaz,
                        Uf = e.Uf
                    })
                    .OrderBy(e => e.TipoEmitente)
                    .ThenBy(e => e.RazaoSocial)
                    .ToListAsync();

                return Ok(emitentes);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao listar emitentes");
                return StatusCode(500, new { message = "Erro ao listar emitentes", error = ex.Message });
            }
        }

        [HttpGet("por-tipo/{tipoEmitente}")]
        public async Task<ActionResult<IEnumerable<EmitenteListDto>>> ListarEmitentesPorTipo(string tipoEmitente)
        {
            try
            {
                var emitentes = await _context.Emitentes
                    .Where(e => e.Ativo && e.TipoEmitente == tipoEmitente)
                    .Select(e => new EmitenteListDto
                    {
                        Id = e.Id,
                        RazaoSocial = e.RazaoSocial,
                        NomeFantasia = e.NomeFantasia,
                        Cnpj = e.Cnpj,
                        Cpf = e.Cpf,
                        TipoEmitente = e.TipoEmitente,
                        TemCertificado = !string.IsNullOrEmpty(e.CaminhoArquivoCertificado),
                        AmbienteSefaz = e.AmbienteSefaz,
                        Uf = e.Uf
                    })
                    .OrderBy(e => e.RazaoSocial)
                    .ToListAsync();

                return Ok(emitentes);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao listar emitentes por tipo");
                return StatusCode(500, new { message = "Erro ao listar emitentes", error = ex.Message });
            }
        }

        [HttpPost("{emitenteId}/certificado")]
        public async Task<IActionResult> ConfigurarCertificado(int emitenteId, [FromBody] ConfigurarCertificadoRequest request)
        {
            try
            {
                if (!System.IO.File.Exists(request.CaminhoArquivoCertificado))
                {
                    return BadRequest(new { message = "Arquivo de certificado não encontrado" });
                }

                var certificadoValido = await _certificadoService.ValidarCertificadoAsync(
                    request.CaminhoArquivoCertificado, 
                    request.SenhaCertificado);

                if (!certificadoValido)
                {
                    return BadRequest(new { message = "Certificado inválido ou senha incorreta" });
                }

                var emitente = await _context.Emitentes.FindAsync(emitenteId);
                if (emitente == null)
                {
                    return NotFound(new { message = "Emitente não encontrado" });
                }

                emitente.CaminhoArquivoCertificado = request.CaminhoArquivoCertificado;
                emitente.SenhaCertificado = request.SenhaCertificado;

                _context.Entry(emitente).State = EntityState.Modified;
                await _context.SaveChangesAsync();

                return Ok(new 
                { 
                    message = "Certificado configurado com sucesso",
                    emitente = emitente.RazaoSocial
                });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao configurar certificado para o emitente {EmitenteId}", emitenteId);
                return StatusCode(500, new { message = "Erro ao configurar certificado", error = ex.Message });
            }
        }

        [HttpGet("com-certificados")]
        public async Task<ActionResult<IEnumerable<EmitenteComCertificadoDto>>> ListarEmitentesComCertificados()
        {
            try
            {
                var emitentes = await _context.Emitentes
                    .Where(e => !string.IsNullOrEmpty(e.CaminhoArquivoCertificado))
                    .ToListAsync();

                var resultado = new List<EmitenteComCertificadoDto>();

                foreach (var emitente in emitentes)
                {
                    var senha = emitente.SenhaCertificado ?? string.Empty;
                    var certificadoValido = false;
                    DateTime? validadeCertificado = null;

                    if (!string.IsNullOrEmpty(emitente.SenhaCertificado))
                    {
                        try
                        {
                            certificadoValido = await _certificadoService.ValidarCertificadoAsync(
                                emitente.CaminhoArquivoCertificado!, senha);

                            if (certificadoValido && System.IO.File.Exists(emitente.CaminhoArquivoCertificado))
                            {
                                var certificadoBytes = await System.IO.File.ReadAllBytesAsync(emitente.CaminhoArquivoCertificado);
                                var certificado = new System.Security.Cryptography.X509Certificates.X509Certificate2(
                                    certificadoBytes, senha);
                                validadeCertificado = certificado.NotAfter;
                            }
                        }
                        catch (Exception ex)
                        {
                            _logger.LogWarning(ex, $"Erro ao validar certificado do emitente {emitente.RazaoSocial}");
                        }
                    }

                    resultado.Add(new EmitenteComCertificadoDto
                    {
                        Id = emitente.Id,
                        RazaoSocial = emitente.RazaoSocial,
                        TipoEmitente = emitente.TipoEmitente,
                        CaminhoArquivoCertificado = emitente.CaminhoArquivoCertificado,
                        CertificadoValido = certificadoValido,
                        ValidadeCertificado = validadeCertificado
                    });
                }

                return Ok(resultado);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao listar emitentes com certificados");
                return StatusCode(500, new { message = "Erro ao listar emitentes", error = ex.Message });
            }
        }

        [HttpGet("tipos-emitente")]
        public IActionResult ListarTiposEmitente()
        {
            return Ok(new[]
            {
                new { valor = "PrestadorServico", descricao = "Prestador de Serviço de Transporte" },
                new { valor = "EntregaPropria", descricao = "Transporte de Entrega Própria" }
            });
        }

    }
}
