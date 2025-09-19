using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MDFeApi.Data;
using MDFeApi.Models;
using MDFeApi.DTOs;

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

        [HttpGet]
        public async Task<ActionResult<ResultadoPaginado<Condutor>>> GetCondutores([FromQuery] int pagina = 1, [FromQuery] int tamanhoPagina = 10)
        {
            var query = _context.Condutores
                .Where(c => c.Ativo)
                .AsQueryable();

            var totalItens = await query.CountAsync();

            var itens = await query
                .OrderBy(c => c.Nome)
                .Skip((pagina - 1) * tamanhoPagina)
                .Take(tamanhoPagina)
                .ToListAsync();

            var resultadoPaginado = new ResultadoPaginado<Condutor>
            {
                Itens = itens,
                TotalItens = totalItens,
                Pagina = pagina,
                TamanhoPagina = tamanhoPagina
            };

            return Ok(resultadoPaginado);
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
                    Telefone = string.IsNullOrWhiteSpace(condutorDto.Telefone) ? null : condutorDto.Telefone,
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
                condutor.Telefone = string.IsNullOrWhiteSpace(condutorDto.Telefone) ? null : condutorDto.Telefone;

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