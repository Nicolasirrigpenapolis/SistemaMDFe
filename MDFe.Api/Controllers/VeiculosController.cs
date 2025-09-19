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
    public class VeiculosController : ControllerBase
    {
        private readonly MDFeContext _context;

        public VeiculosController(MDFeContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<ResultadoPaginado<Veiculo>>> GetVeiculos([FromQuery] int pagina = 1, [FromQuery] int tamanhoPagina = 10)
        {
            var query = _context.Veiculos
                .Where(v => v.Ativo)
                .AsQueryable();

            var totalItens = await query.CountAsync();

            var itens = await query
                .OrderBy(v => v.Placa)
                .Skip((pagina - 1) * tamanhoPagina)
                .Take(tamanhoPagina)
                .ToListAsync();

            var resultadoPaginado = new ResultadoPaginado<Veiculo>
            {
                Itens = itens,
                TotalItens = totalItens,
                Pagina = pagina,
                TamanhoPagina = tamanhoPagina
            };

            return Ok(resultadoPaginado);
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Veiculo>> GetVeiculo(int id)
        {
            var veiculo = await _context.Veiculos.FindAsync(id);

            if (veiculo == null || !veiculo.Ativo)
            {
                return NotFound();
            }

            return veiculo;
        }

        [HttpPost]
        public async Task<ActionResult<Veiculo>> CreateVeiculo(VeiculoCreateDto veiculoDto)
        {
            try
            {
                // Validar se placa já existe
                var existingPlaca = await _context.Veiculos
                    .AnyAsync(v => v.Placa == veiculoDto.Placa && v.Ativo);
                if (existingPlaca)
                {
                    return BadRequest(new { message = "Placa já cadastrada" });
                }

                var veiculo = new Veiculo
                {
                    Placa = veiculoDto.Placa,
                    Renavam = veiculoDto.Renavam,
                    Marca = veiculoDto.Marca,
                    Modelo = veiculoDto.Modelo,
                    Ano = veiculoDto.Ano,
                    Cor = veiculoDto.Cor,
                    Combustivel = veiculoDto.Combustivel,
                    Tara = veiculoDto.Tara ?? 0,
                    CapacidadeKg = veiculoDto.CapacidadeKg,
                    TipoRodado = veiculoDto.TipoRodado,
                    TipoCarroceria = veiculoDto.TipoCarroceria,
                    Uf = veiculoDto.Uf,
                    Ativo = true
                };

                _context.Veiculos.Add(veiculo);
                await _context.SaveChangesAsync();

                return CreatedAtAction(nameof(GetVeiculo), new { id = veiculo.Id }, veiculo);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Erro interno do servidor", error = ex.Message });
            }
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateVeiculo(int id, VeiculoUpdateDto veiculoDto)
        {
            var veiculo = await _context.Veiculos.FindAsync(id);
            if (veiculo == null || !veiculo.Ativo)
            {
                return NotFound();
            }

            try
            {
                // Validar se placa já existe (exceto para o próprio veículo)
                if (veiculoDto.Placa != veiculo.Placa)
                {
                    var existingPlaca = await _context.Veiculos
                        .AnyAsync(v => v.Placa == veiculoDto.Placa && v.Id != id && v.Ativo);
                    if (existingPlaca)
                    {
                        return BadRequest(new { message = "Placa já cadastrada" });
                    }
                }

                veiculo.Placa = veiculoDto.Placa;
                veiculo.Renavam = veiculoDto.Renavam;
                veiculo.Marca = veiculoDto.Marca;
                veiculo.Modelo = veiculoDto.Modelo;
                veiculo.Ano = veiculoDto.Ano;
                veiculo.Cor = veiculoDto.Cor;
                veiculo.Combustivel = veiculoDto.Combustivel;
                veiculo.Tara = veiculoDto.Tara ?? 0;
                veiculo.CapacidadeKg = veiculoDto.CapacidadeKg;
                veiculo.TipoRodado = veiculoDto.TipoRodado;
                veiculo.TipoCarroceria = veiculoDto.TipoCarroceria;
                veiculo.Uf = veiculoDto.Uf;

                await _context.SaveChangesAsync();

                return NoContent();
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Erro interno do servidor", error = ex.Message });
            }
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteVeiculo(int id)
        {
            var veiculo = await _context.Veiculos.FindAsync(id);
            if (veiculo == null)
            {
                return NotFound();
            }

            try
            {
                // Verificar se tem MDF-e vinculados
                var temMdfe = await _context.MDFes.AnyAsync(m => m.VeiculoId == id);
                if (temMdfe)
                {
                    return BadRequest(new { message = "Não é possível excluir veículo com MDF-e vinculados" });
                }

                // Soft delete
                veiculo.Ativo = false;
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