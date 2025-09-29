using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MDFeApi.Data;
using MDFeApi.DTOs;
using MDFeApi.Models;
using MDFeApi.Utils;
using MDFeApi.Helpers;

namespace MDFeApi.Controllers
{
    [Route("api/[controller]")]
    public class SeguradorasController : BaseController<Seguradora, SeguradoraListDto, SeguradoraDetailDto, SeguradoraCreateDto, SeguradoraUpdateDto>
    {
        public SeguradorasController(MDFeContext context, ILogger<SeguradorasController> logger)
            : base(context, logger)
        {
        }

        protected override DbSet<Seguradora> GetDbSet() => _context.Seguradoras;

        protected override SeguradoraListDto EntityToListDto(Seguradora entity)
        {
            return new SeguradoraListDto
            {
                Id = entity.Id,
                Cnpj = entity.Cnpj,
                RazaoSocial = entity.RazaoSocial,
                Uf = entity.Uf,
                NomeFantasia = entity.NomeFantasia,
                Apolice = entity.Apolice,
                Ativo = entity.Ativo,
                DataCriacao = entity.DataCriacao
            };
        }

        protected override SeguradoraDetailDto EntityToDetailDto(Seguradora entity)
        {
            return new SeguradoraDetailDto
            {
                Id = entity.Id,
                Cnpj = entity.Cnpj,
                RazaoSocial = entity.RazaoSocial,
                Uf = entity.Uf,
                NomeFantasia = entity.NomeFantasia,
                Apolice = entity.Apolice,
                Ativo = entity.Ativo,
                DataCriacao = entity.DataCriacao,
                DataUltimaAlteracao = entity.DataUltimaAlteracao
            };
        }

        protected override Seguradora CreateDtoToEntity(SeguradoraCreateDto dto)
        {
            var seguradora = new Seguradora
            {
                Cnpj = dto.Cnpj,
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
                Apolice = dto.Apolice?.Trim(),
                Ativo = dto.Ativo
            };

            DocumentUtils.LimparDocumentosSeguradora(seguradora);
            return seguradora;
        }

        protected override void UpdateEntityFromDto(Seguradora entity, SeguradoraUpdateDto dto)
        {
            entity.Cnpj = dto.Cnpj;
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
            entity.Apolice = dto.Apolice?.Trim();
            entity.Ativo = dto.Ativo;

            DocumentUtils.LimparDocumentosSeguradora(entity);
        }

        protected override IQueryable<Seguradora> ApplySearchFilter(IQueryable<Seguradora> query, string search)
        {
            return query.Where(s =>
                s.RazaoSocial.Contains(search) ||
                s.Cnpj.Contains(search) ||
                (s.Apolice != null && s.Apolice.Contains(search))
            );
        }

        protected override IQueryable<Seguradora> ApplyOrdering(IQueryable<Seguradora> query, string? sortBy, string? sortDirection)
        {
            var isDesc = sortDirection?.ToLower() == "desc";

            return sortBy?.ToLower() switch
            {
                "cnpj" => isDesc ? query.OrderByDescending(s => s.Cnpj) : query.OrderBy(s => s.Cnpj),
                "uf" => isDesc ? query.OrderByDescending(s => s.Uf) : query.OrderBy(s => s.Uf),
                "datacriacao" => isDesc ? query.OrderByDescending(s => s.DataCriacao) : query.OrderBy(s => s.DataCriacao),
                _ => isDesc ? query.OrderByDescending(s => s.RazaoSocial) : query.OrderBy(s => s.RazaoSocial)
            };
        }

        protected override async Task<(bool canDelete, string errorMessage)> CanDeleteAsync(Seguradora entity)
        {
            var temMdfeVinculado = await _context.MDFes.AnyAsync(m => m.SeguradoraId == entity.Id);
            if (temMdfeVinculado)
            {
                return (false, "Não é possível excluir seguradora com MDF-e vinculados");
            }
            return (true, string.Empty);
        }

        protected override async Task<(bool isValid, string errorMessage)> ValidateCreateAsync(SeguradoraCreateDto dto)
        {
            if (string.IsNullOrEmpty(dto.Cnpj))
            {
                return (false, "CNPJ é obrigatório");
            }

            // ✅ OTIMIZADO: Usar DocumentUtils para limpeza consistente
            var cnpjLimpo = DocumentUtils.LimparCnpj(dto.Cnpj);

            // Verificar apenas duplicação (validação de CNPJ é responsabilidade do ValidationController)
            var existenteCnpj = await _context.Seguradoras
                .AnyAsync(s => s.Cnpj == cnpjLimpo);
            if (existenteCnpj)
            {
                return (false, "Já existe uma seguradora cadastrada com este CNPJ");
            }
            return (true, string.Empty);
        }

        protected override async Task<(bool isValid, string errorMessage)> ValidateUpdateAsync(Seguradora entity, SeguradoraUpdateDto dto)
        {
            if (string.IsNullOrEmpty(dto.Cnpj))
            {
                return (false, "CNPJ é obrigatório");
            }

            // ✅ OTIMIZADO: Usar DocumentUtils para limpeza consistente
            var cnpjLimpo = DocumentUtils.LimparCnpj(dto.Cnpj);

            // Verificar apenas duplicação (validação de CNPJ é responsabilidade do ValidationController)
            var existenteCnpj = await _context.Seguradoras
                .AnyAsync(s => s.Id != entity.Id && s.Cnpj == cnpjLimpo);
            if (existenteCnpj)
            {
                return (false, "Já existe outra seguradora cadastrada com este CNPJ");
            }
            return (true, string.Empty);
        }


        // Método personalizado para aceitar wrapper do frontend
        [HttpPost("wrapper")]
        public async Task<ActionResult<SeguradoraDetailDto>> CreateFromWrapper([FromBody] SeguradoraCreateWrapper wrapper)
        {
            return await Create(wrapper.Dto);
        }
    }
}