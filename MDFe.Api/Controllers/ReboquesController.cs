using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MDFeApi.Data;
using MDFeApi.Models;
using MDFeApi.DTOs;
using MDFeApi.Utils;

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
                TipoRodado = reboqueDto.TipoRodado?.Trim(),
                TipoCarroceria = reboqueDto.TipoCarroceria?.Trim(),
                Uf = reboqueDto.Uf?.Trim(),
                Rntrc = reboqueDto.Rntrc?.Trim(),
                Ativo = true,
                DataCriacao = DateTime.UtcNow
            };

            // Aplicar limpeza automática de documentos
            DocumentUtils.LimparDocumentosReboque(reboque);

            // Validar se placa já existe (usando dados limpos)
            var existingPlaca = await _context.Reboques
                .AnyAsync(r => r.Placa == reboque.Placa && r.Ativo);
            if (existingPlaca)
            {
                return BadRequest(new { message = "Placa já cadastrada" });
            }

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

            // Salvar placa original
            var placaOriginal = reboque.Placa;

            // Atualizar dados com trim
            reboque.Placa = reboqueDto.Placa;
            reboque.Renavam = reboqueDto.Renavam;
            reboque.Tara = reboqueDto.Tara;
            reboque.CapacidadeKg = reboqueDto.CapacidadeKg;
            reboque.TipoRodado = reboqueDto.TipoRodado?.Trim();
            reboque.TipoCarroceria = reboqueDto.TipoCarroceria?.Trim();
            reboque.Uf = reboqueDto.Uf?.Trim();
            reboque.Rntrc = reboqueDto.Rntrc?.Trim();

            // Aplicar limpeza automática de documentos
            DocumentUtils.LimparDocumentosReboque(reboque);

            // Validar se placa já existe (exceto para o próprio reboque, usando dados limpos)
            if (reboque.Placa != placaOriginal)
            {
                var existingPlaca = await _context.Reboques
                    .AnyAsync(r => r.Placa == reboque.Placa && r.Id != id && r.Ativo);
                if (existingPlaca)
                {
                    return BadRequest(new { message = "Placa já cadastrada" });
                }
            }

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