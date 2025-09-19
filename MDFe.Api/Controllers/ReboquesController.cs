using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MDFeApi.Data;
using MDFeApi.Models;
using MDFeApi.DTOs;

namespace MDFeApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ReboquesController : ControllerBase
    {
        private readonly MDFeContext _context;

        public ReboquesController(MDFeContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Reboque>>> GetReboques()
        {
            return await _context.Reboques
                .Where(r => r.Ativo)
                .OrderBy(r => r.Placa)
                .ToListAsync();
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Reboque>> GetReboque(int id)
        {
            var reboque = await _context.Reboques
                .Where(r => r.Ativo)
                .FirstOrDefaultAsync(r => r.Id == id);

            if (reboque == null)
            {
                return NotFound();
            }

            return reboque;
        }

        [HttpPost]
        public async Task<ActionResult<Reboque>> PostReboque(ReboqueCreateDto reboqueDto)
        {
            var reboque = new Reboque
            {
                Placa = reboqueDto.Placa,
                Renavam = reboqueDto.Renavam,
                Tara = reboqueDto.Tara,
                CapacidadeKg = reboqueDto.CapacidadeKg,
                TipoRodado = reboqueDto.TipoRodado,
                TipoCarroceria = reboqueDto.TipoCarroceria,
                Uf = reboqueDto.Uf,
                Rntrc = reboqueDto.Rntrc,
                Ativo = true,
                DataCriacao = DateTime.UtcNow
            };

            _context.Reboques.Add(reboque);
            await _context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetReboque), new { id = reboque.Id }, reboque);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> PutReboque(int id, ReboqueCreateDto reboqueDto)
        {
            var reboque = await _context.Reboques
                .Where(r => r.Ativo)
                .FirstOrDefaultAsync(r => r.Id == id);

            if (reboque == null)
            {
                return NotFound();
            }

            reboque.Placa = reboqueDto.Placa;
            reboque.Renavam = reboqueDto.Renavam;
            reboque.Tara = reboqueDto.Tara;
            reboque.CapacidadeKg = reboqueDto.CapacidadeKg;
            reboque.TipoRodado = reboqueDto.TipoRodado;
            reboque.TipoCarroceria = reboqueDto.TipoCarroceria;
            reboque.Uf = reboqueDto.Uf;
            reboque.Rntrc = reboqueDto.Rntrc;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ReboqueExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteReboque(int id)
        {
            var reboque = await _context.Reboques
                .Where(r => r.Ativo)
                .FirstOrDefaultAsync(r => r.Id == id);

            if (reboque == null)
            {
                return NotFound();
            }

            reboque.Ativo = false;
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool ReboqueExists(int id)
        {
            return _context.Reboques.Any(e => e.Id == id && e.Ativo);
        }
    }
}