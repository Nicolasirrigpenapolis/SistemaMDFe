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
        public EmitentesController(
            MDFeContext context,
            ILogger<EmitentesController> logger,
            ICacheService cacheService)
            : base(context, logger, cacheService)
        {
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
                TemCertificado = false, // Certificado gerenciado pelo MonitorACBr
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
                // Certificado removido - MonitorACBr gerencia
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
                // Certificado removido - MonitorACBr gerencia
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
            // Certificado removido - MonitorACBr gerencia
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

        /// <summary>
        /// Atualizar código IBGE de todos os emitentes com município cadastrado
        /// </summary>
        [HttpPost("atualizar-codigos-ibge")]
        public async Task<ActionResult> AtualizarCodigosIBGE()
        {
            try
            {
                var emitentes = await _context.Emitentes
                    .Where(e => e.CodMunicipio == 0 && !string.IsNullOrEmpty(e.Municipio) && !string.IsNullOrEmpty(e.Uf))
                    .ToListAsync();

                int atualizados = 0;
                int naoEncontrados = 0;

                foreach (var emitente in emitentes)
                {
                    var municipio = await _context.Municipios
                        .FirstOrDefaultAsync(m => m.Nome.ToUpper() == emitente.Municipio.ToUpper() && m.Uf.ToUpper() == emitente.Uf.ToUpper());

                    if (municipio != null)
                    {
                        emitente.CodMunicipio = municipio.Codigo;
                        _logger.LogInformation("Emitente {Id} - {Municipio}/{Uf}: Código IBGE {Codigo} atualizado",
                            emitente.Id, emitente.Municipio, emitente.Uf, municipio.Codigo);
                        atualizados++;
                    }
                    else
                    {
                        _logger.LogWarning("Emitente {Id} - {Municipio}/{Uf}: Município não encontrado na tabela IBGE",
                            emitente.Id, emitente.Municipio, emitente.Uf);
                        naoEncontrados++;
                    }
                }

                await _context.SaveChangesAsync();

                return Ok(new
                {
                    sucesso = true,
                    mensagem = $"Atualização concluída: {atualizados} emitentes atualizados, {naoEncontrados} não encontrados",
                    atualizados,
                    naoEncontrados,
                    total = emitentes.Count
                });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao atualizar códigos IBGE dos emitentes");
                return StatusCode(500, new { sucesso = false, mensagem = "Erro ao atualizar códigos IBGE", erro = ex.Message });
            }
        }

        /// <summary>
        /// Diagnosticar problemas com códigos IBGE dos emitentes
        /// </summary>
        [HttpGet("diagnostico-ibge")]
        public async Task<ActionResult> DiagnosticoIBGE()
        {
            try
            {
                var emitentes = await _context.Emitentes.ToListAsync();
                var municipios = await _context.Municipios.CountAsync();

                var diagnostico = emitentes.Select(e => new
                {
                    id = e.Id,
                    razaoSocial = e.RazaoSocial,
                    municipio = e.Municipio,
                    uf = e.Uf,
                    codMunicipioAtual = e.CodMunicipio,
                    status = e.CodMunicipio == 0 ? "❌ ZERADO" : "✅ OK",
                    municipioExisteNaTabela = _context.Municipios.Any(m =>
                        m.Nome.ToUpper() == e.Municipio.ToUpper() &&
                        m.Uf.ToUpper() == e.Uf.ToUpper())
                }).ToList();

                return Ok(new
                {
                    sucesso = true,
                    totalEmitentes = emitentes.Count,
                    totalMunicipiosCadastrados = municipios,
                    emitentesComProblema = diagnostico.Count(d => d.codMunicipioAtual == 0),
                    detalhes = diagnostico
                });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao gerar diagnóstico");
                return StatusCode(500, new { sucesso = false, mensagem = "Erro ao gerar diagnóstico", erro = ex.Message });
            }
        }
    }
}