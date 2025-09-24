using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MDFeApi.Data;
using MDFeApi.Models;
using MDFeApi.DTOs;
using MDFeApi.Extensions;

namespace MDFeApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class CondutoresController : ControllerBase
    {
        private readonly MDFeContext _context;

        public CondutoresController(MDFeContext context)
        {
            _context = context;
        }

        [HttpGet("test")]
        public async Task<ActionResult> TestConnection()
        {
            try
            {
                var count = await _context.Condutores.CountAsync();
                return Ok(new { success = true, message = $"Conexão OK. {count} condutores encontrados." });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { success = false, message = "Erro de conexão", error = ex.Message });
            }
        }

        [HttpGet]
        public async Task<ActionResult> GetCondutores([FromQuery] PaginationRequest request)
        {
            try
            {
                var query = _context.Condutores
                    .Where(c => c.Ativo)
                    .AsQueryable();

                // Filtrar por busca se fornecido
                if (!string.IsNullOrWhiteSpace(request.Search))
                {
                    var searchTerm = request.Search.ToLower();
                    query = query.Where(c =>
                        c.Nome.ToLower().Contains(searchTerm) ||
                        (c.Cpf != null && c.Cpf.Contains(searchTerm))
                    );
                }

                // Aplicar ordenação
                switch (request.SortBy?.ToLower())
                {
                    case "cpf":
                        query = request.SortDirection?.ToLower() == "desc" ?
                            query.OrderByDescending(c => c.Cpf) :
                            query.OrderBy(c => c.Cpf);
                        break;
                    case "datacriacao":
                        query = request.SortDirection?.ToLower() == "desc" ?
                            query.OrderByDescending(c => c.DataCriacao) :
                            query.OrderBy(c => c.DataCriacao);
                        break;
                    default:
                        query = request.SortDirection?.ToLower() == "desc" ?
                            query.OrderByDescending(c => c.Nome) :
                            query.OrderBy(c => c.Nome);
                        break;
                }

                // Implementação simples da paginação
                var totalItems = await query.CountAsync();
                var items = await query
                    .Skip((request.Page - 1) * request.PageSize)
                    .Take(request.PageSize)
                    .ToListAsync();

                var result = new
                {
                    items = items,
                    totalItems = totalItems,
                    totalPages = (int)Math.Ceiling((double)totalItems / request.PageSize),
                    currentPage = request.Page,
                    pageSize = request.PageSize,
                    hasNextPage = request.Page * request.PageSize < totalItems,
                    hasPreviousPage = request.Page > 1
                };

                return Ok(result);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Erro ao obter condutores", error = ex.Message });
            }
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Condutor>> GetCondutor(int id)
        {
            var condutor = await _context.Condutores.FindAsync(id);

            if (condutor == null || !condutor.Ativo)
            {
                return NotFound();
            }

            return condutor;
        }

        [HttpPost]
        public async Task<ActionResult<Condutor>> CreateCondutor(CondutorSimpleDto condutorDto)
        {
            if (condutorDto == null)
            {
                return BadRequest(new { message = "Dados do condutor são obrigatórios" });
            }

            try
            {
                // Validar se CPF já existe
                if (!string.IsNullOrWhiteSpace(condutorDto.Cpf))
                {
                    var existingCpf = await _context.Condutores
                        .AnyAsync(c => c.Cpf == condutorDto.Cpf && c.Ativo);
                    if (existingCpf)
                    {
                        return BadRequest(new { message = "CPF já cadastrado" });
                    }
                }

                var condutor = new Condutor
                {
                    Nome = condutorDto.Nome,
                    Cpf = condutorDto.Cpf,
                    Ativo = true
                };

                _context.Condutores.Add(condutor);
                await _context.SaveChangesAsync();

                return CreatedAtAction(nameof(GetCondutor), new { id = condutor.Id }, condutor);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Erro interno do servidor", error = ex.Message });
            }
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateCondutor(int id, CondutorUpdateDto condutorDto)
        {
            var condutor = await _context.Condutores.FindAsync(id);
            if (condutor == null || !condutor.Ativo)
            {
                return NotFound();
            }

            try
            {
                // Validar se CPF já existe (exceto para o próprio condutor)
                if (!string.IsNullOrWhiteSpace(condutorDto.Cpf) && condutorDto.Cpf != condutor.Cpf)
                {
                    var existingCpf = await _context.Condutores
                        .AnyAsync(c => c.Cpf == condutorDto.Cpf && c.Id != id && c.Ativo);
                    if (existingCpf)
                    {
                        return BadRequest(new { message = "CPF já cadastrado" });
                    }
                }

                condutor.Nome = condutorDto.Nome;
                condutor.Cpf = condutorDto.Cpf;

                await _context.SaveChangesAsync();

                return NoContent();
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Erro interno do servidor", error = ex.Message });
            }
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCondutor(int id)
        {
            var condutor = await _context.Condutores.FindAsync(id);
            if (condutor == null)
            {
                return NotFound();
            }

            try
            {
                // Verificar se tem MDF-e vinculados
                var temMdfe = await _context.MDFes.AnyAsync(m => m.CondutorId == id);
                if (temMdfe)
                {
                    return BadRequest(new { message = "Não é possível excluir condutor com MDF-e vinculados" });
                }

                // Soft delete
                condutor.Ativo = false;
                await _context.SaveChangesAsync();

                return NoContent();
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Erro interno do servidor", error = ex.Message });
            }
        }
    }
}