using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MDFeApi.Data;
using MDFeApi.Models;
using MDFeApi.DTOs;
using MDFeApi.Interfaces;
using MDFeApi.Utils;
using MDFeApi.Helpers;
using MDFeApi.Services;

namespace MDFeApi.Controllers
{
    [Route("api/[controller]")]
    public class EmitentesController : BaseController<Emitente, EmitenteListDto, EmitenteResponseDto, EmitenteCreateDto, EmitenteUpdateDto>
    {
        private readonly ICertificadoService _certificadoService;

        public EmitentesController(
            MDFeContext context,
            ICertificadoService certificadoService,
            ILogger<EmitentesController> logger,
            ICacheService cacheService)
            : base(context, logger, cacheService)
        {
            _certificadoService = certificadoService;
        }

        protected override DbSet<Emitente> GetDbSet() => _context.Emitentes;

        protected override EmitenteListDto EntityToListDto(Emitente entity)
        {
            return new EmitenteListDto
            {
                Id = entity.Id,
                RazaoSocial = entity.RazaoSocial,
                NomeFantasia = entity.NomeFantasia,
                Cnpj = entity.Cnpj,
                Cpf = entity.Cpf,
                Ie = entity.Ie,
                Endereco = entity.Endereco,
                Numero = entity.Numero,
                Complemento = entity.Complemento,
                Bairro = entity.Bairro,
                CodMunicipio = entity.CodMunicipio,
                Municipio = entity.Municipio,
                Cep = entity.Cep,
                TipoEmitente = entity.TipoEmitente,
                TemCertificado = !string.IsNullOrEmpty(entity.CaminhoArquivoCertificado),
                AmbienteSefaz = entity.AmbienteSefaz,
                Uf = entity.Uf,
                Ativo = entity.Ativo
            };
        }

        protected override EmitenteResponseDto EntityToDetailDto(Emitente entity)
        {
            return new EmitenteResponseDto
            {
                Id = entity.Id,
                Cnpj = entity.Cnpj,
                Cpf = entity.Cpf,
                Ie = entity.Ie,
                RazaoSocial = entity.RazaoSocial,
                NomeFantasia = entity.NomeFantasia,
                Endereco = entity.Endereco,
                Numero = entity.Numero,
                Complemento = entity.Complemento,
                Bairro = entity.Bairro,
                CodMunicipio = entity.CodMunicipio,
                Municipio = entity.Municipio,
                Cep = entity.Cep,
                Uf = entity.Uf,
                Telefone = entity.Telefone,
                Email = entity.Email,
                Ativo = entity.Ativo,
                TipoEmitente = entity.TipoEmitente,
                CaminhoArquivoCertificado = entity.CaminhoArquivoCertificado,
                SenhaCertificado = entity.SenhaCertificado,
                CaminhoSalvarXml = entity.CaminhoSalvarXml,
                Rntrc = entity.Rntrc,
                SerieInicial = entity.SerieInicial,
                TipoTransportador = entity.TipoTransportador,
                ModalTransporte = entity.ModalTransporte,
                AmbienteSefaz = entity.AmbienteSefaz,
                DataCriacao = entity.DataCriacao,
                DataAtualizacao = entity.DataUltimaAlteracao
            };
        }

        protected override Emitente CreateDtoToEntity(EmitenteCreateDto dto)
        {
            var emitente = new Emitente
            {
                Cnpj = dto.Cnpj?.Trim(),
                Cpf = dto.Cpf?.Trim(),
                Ie = dto.Ie?.Trim(),
                RazaoSocial = dto.RazaoSocial?.Trim(),
                NomeFantasia = dto.NomeFantasia?.Trim(),
                Endereco = dto.Endereco?.Trim(),
                Numero = dto.Numero?.Trim(),
                Complemento = dto.Complemento?.Trim(),
                Bairro = dto.Bairro?.Trim(),
                CodMunicipio = dto.CodMunicipio,
                Municipio = dto.Municipio?.Trim(),
                Cep = dto.Cep?.Trim(),
                Uf = dto.Uf?.Trim(),
                Telefone = dto.Telefone?.Trim(),
                Email = dto.Email?.Trim(),
                TipoEmitente = dto.TipoEmitente?.Trim(),
                CaminhoArquivoCertificado = dto.CaminhoArquivoCertificado?.Trim(),
                SenhaCertificado = dto.SenhaCertificado?.Trim(),
                CaminhoSalvarXml = dto.CaminhoSalvarXml?.Trim(),
                Rntrc = dto.Rntrc?.Trim(),
                SerieInicial = dto.SerieInicial,
                TipoTransportador = dto.TipoTransportador,
                ModalTransporte = dto.ModalTransporte,
                AmbienteSefaz = dto.AmbienteSefaz,
                Ativo = dto.Ativo // Usar valor do DTO (padrão true)
            };

            // Aplicar limpeza automática de documentos
            DocumentUtils.LimparDocumentosEmitente(emitente);
            return emitente;
        }

        protected override void UpdateEntityFromDto(Emitente entity, EmitenteUpdateDto dto)
        {
            entity.Cnpj = dto.Cnpj?.Trim();
            entity.Cpf = dto.Cpf?.Trim();
            entity.Ie = dto.Ie?.Trim();
            entity.RazaoSocial = dto.RazaoSocial?.Trim();
            entity.NomeFantasia = dto.NomeFantasia?.Trim();
            entity.Endereco = dto.Endereco?.Trim();
            entity.Numero = dto.Numero?.Trim();
            entity.Complemento = dto.Complemento?.Trim();
            entity.Bairro = dto.Bairro?.Trim();
            entity.CodMunicipio = dto.CodMunicipio;
            entity.Municipio = dto.Municipio?.Trim();
            entity.Cep = dto.Cep?.Trim();
            entity.Uf = dto.Uf?.Trim();
            entity.Telefone = dto.Telefone?.Trim();
            entity.Email = dto.Email?.Trim();
            entity.TipoEmitente = dto.TipoEmitente?.Trim();
            entity.CaminhoArquivoCertificado = dto.CaminhoArquivoCertificado?.Trim();
            entity.SenhaCertificado = dto.SenhaCertificado?.Trim();
            entity.CaminhoSalvarXml = dto.CaminhoSalvarXml?.Trim();
            entity.Rntrc = dto.Rntrc?.Trim();
            entity.SerieInicial = dto.SerieInicial;
            entity.TipoTransportador = dto.TipoTransportador;
            entity.ModalTransporte = dto.ModalTransporte;
            entity.AmbienteSefaz = dto.AmbienteSefaz;
            entity.Ativo = dto.Ativo; // Atualizar status ativo também

            // Aplicar limpeza automática de documentos
            DocumentUtils.LimparDocumentosEmitente(entity);
        }

        protected override IQueryable<Emitente> ApplySearchFilter(IQueryable<Emitente> query, string search)
        {
            var searchTerm = search.ToLower();
            return query.Where(e =>
                e.RazaoSocial.ToLower().Contains(searchTerm) ||
                (e.Cnpj != null && e.Cnpj.Contains(searchTerm)) ||
                (e.NomeFantasia != null && e.NomeFantasia.ToLower().Contains(searchTerm)) ||
                (e.Cpf != null && e.Cpf.Contains(searchTerm))
            );
        }

        protected override IQueryable<Emitente> ApplyOrdering(IQueryable<Emitente> query, string? sortBy, string? sortDirection)
        {
            var isDesc = sortDirection?.ToLower() == "desc";

            return sortBy?.ToLower() switch
            {
                "cnpj" => isDesc ? query.OrderByDescending(e => e.Cnpj) : query.OrderBy(e => e.Cnpj),
                "cpf" => isDesc ? query.OrderByDescending(e => e.Cpf) : query.OrderBy(e => e.Cpf),
                "uf" => isDesc ? query.OrderByDescending(e => e.Uf) : query.OrderBy(e => e.Uf),
                "tipoemitente" => isDesc ? query.OrderByDescending(e => e.TipoEmitente) : query.OrderBy(e => e.TipoEmitente),
                "datacriacao" => isDesc ? query.OrderByDescending(e => e.DataCriacao) : query.OrderBy(e => e.DataCriacao),
                _ => isDesc ? query.OrderByDescending(e => e.RazaoSocial) : query.OrderBy(e => e.RazaoSocial)
            };
        }

        protected override async Task<(bool canDelete, string errorMessage)> CanDeleteAsync(Emitente entity)
        {
            var temMdfe = await _context.MDFes.AnyAsync(m => m.EmitenteId == entity.Id);
            if (temMdfe)
            {
                return (false, "Não é possível excluir emitente com MDF-e vinculados");
            }
            return (true, string.Empty);
        }


        protected override async Task<(bool isValid, string errorMessage)> ValidateCreateAsync(EmitenteCreateDto dto)
        {
            // Validar se CNPJ ou CPF é obrigatório
            if (string.IsNullOrEmpty(dto.Cnpj) && string.IsNullOrEmpty(dto.Cpf))
            {
                return (false, "CNPJ ou CPF é obrigatório");
            }

            var emitenteTemp = new Emitente { Cnpj = dto.Cnpj?.Trim(), Cpf = dto.Cpf?.Trim() };
            DocumentUtils.LimparDocumentosEmitente(emitenteTemp);

            // Verificar se já existe emitente com mesmo CNPJ ou CPF
            var existente = await _context.Emitentes
                .AnyAsync(e => (!string.IsNullOrEmpty(emitenteTemp.Cnpj) && e.Cnpj == emitenteTemp.Cnpj) ||
                              (!string.IsNullOrEmpty(emitenteTemp.Cpf) && e.Cpf == emitenteTemp.Cpf));

            if (existente)
            {
                return (false, "Já existe um emitente cadastrado com este CNPJ/CPF");
            }

            return (true, string.Empty);
        }

        protected override async Task<(bool isValid, string errorMessage)> ValidateUpdateAsync(Emitente entity, EmitenteUpdateDto dto)
        {
            // Validar se CNPJ ou CPF é obrigatório
            if (string.IsNullOrEmpty(dto.Cnpj) && string.IsNullOrEmpty(dto.Cpf))
            {
                return (false, "CNPJ ou CPF é obrigatório");
            }

            var emitenteTemp = new Emitente { Cnpj = dto.Cnpj?.Trim(), Cpf = dto.Cpf?.Trim() };
            DocumentUtils.LimparDocumentosEmitente(emitenteTemp);

            // Verificar se já existe outro emitente com mesmo CNPJ ou CPF
            var existente = await _context.Emitentes
                .AnyAsync(e => e.Id != entity.Id &&
                              ((!string.IsNullOrEmpty(emitenteTemp.Cnpj) && e.Cnpj == emitenteTemp.Cnpj) ||
                               (!string.IsNullOrEmpty(emitenteTemp.Cpf) && e.Cpf == emitenteTemp.Cpf)));

            if (existente)
            {
                return (false, "Já existe outro emitente cadastrado com este CNPJ/CPF");
            }

            return (true, string.Empty);
        }

        #region Métodos específicos de Certificado

        /// <summary>
        /// Configurar certificado do emitente
        /// </summary>
        [HttpPost("{id}/certificado")]
        public async Task<IActionResult> ConfigurarCertificado(int id, [FromBody] ConfigurarCertificadoRequest request)
        {
            try
            {
                var emitente = await _context.Emitentes.FindAsync(id);
                if (emitente == null || !emitente.Ativo)
                {
                    return NotFound(new { message = "Emitente não encontrado" });
                }

                // Validar certificado
                var isValid = await _certificadoService.ValidarCertificadoAsync(
                    request.CaminhoArquivoCertificado,
                    request.SenhaCertificado);

                if (!isValid)
                {
                    return BadRequest(new { message = "Certificado inválido ou senha incorreta" });
                }

                // Atualizar dados do certificado
                emitente.CaminhoArquivoCertificado = request.CaminhoArquivoCertificado;
                emitente.SenhaCertificado = request.SenhaCertificado;
                emitente.DataUltimaAlteracao = DateTime.Now;

                await _context.SaveChangesAsync();

                return Ok(new { message = "Certificado configurado com sucesso" });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao configurar certificado do emitente {EmitenteId}", id);
                return StatusCode(500, new { message = "Erro interno do servidor", error = ex.Message });
            }
        }

        /// <summary>
        /// Obter emitentes com certificado válido
        /// </summary>
        [HttpGet("com-certificado")]
        public async Task<ActionResult<IEnumerable<EmitenteComCertificadoDto>>> GetEmitentesComCertificado()
        {
            try
            {
                var emitentes = await _context.Emitentes
                    .Where(e => e.Ativo && !string.IsNullOrEmpty(e.CaminhoArquivoCertificado))
                    .Select(e => new EmitenteComCertificadoDto
                    {
                        Id = e.Id,
                        RazaoSocial = e.RazaoSocial,
                        TipoEmitente = e.TipoEmitente,
                        CaminhoArquivoCertificado = e.CaminhoArquivoCertificado,
                        CertificadoValido = false, // Será validado pelo service
                        ValidadeCertificado = null // Será preenchido pelo service
                    })
                    .ToListAsync();

                // Validar certificados
                foreach (var emitente in emitentes)
                {
                    if (!string.IsNullOrEmpty(emitente.CaminhoArquivoCertificado))
                    {
                        emitente.CertificadoValido = await _certificadoService.CertificadoValidoAsync(
                            emitente.CaminhoArquivoCertificado);
                    }
                }

                return Ok(emitentes);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao obter emitentes com certificado");
                return StatusCode(500, new { message = "Erro interno do servidor", error = ex.Message });
            }
        }

        /// <summary>
        /// Selecionar emitente ativo
        /// </summary>
        [HttpPost("selecionar")]
        public async Task<IActionResult> SelecionarEmitente([FromBody] SelecionarEmitenteRequest request)
        {
            try
            {
                var emitente = await _context.Emitentes.FindAsync(request.EmitenteId);
                if (emitente == null || !emitente.Ativo)
                {
                    return NotFound(new { message = "Emitente não encontrado" });
                }

                // Aqui poderia implementar lógica de sessão/contexto do emitente selecionado
                // Por ora, apenas retorna sucesso
                return Ok(new {
                    message = "Emitente selecionado com sucesso",
                    emitente = new { emitente.Id, emitente.RazaoSocial, emitente.TipoEmitente }
                });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao selecionar emitente {EmitenteId}", request.EmitenteId);
                return StatusCode(500, new { message = "Erro interno do servidor", error = ex.Message });
            }
        }

        #endregion
    }
}