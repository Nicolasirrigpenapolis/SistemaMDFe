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
    public class VeiculosController : ControllerBase
    {
        private readonly MDFeContext _context;

        public VeiculosController(MDFeContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<PaginationResult<Veiculo>>> GetVeiculos([FromQuery] PaginationRequest request)
        {
            try
            {
                var query = _context.Veiculos
                    .Where(v => v.Ativo)
                    .AsQueryable();

                // Filtrar por busca se fornecido
                if (!string.IsNullOrWhiteSpace(request.Search))
                {
                    var searchTerm = request.Search.ToLower();
                    query = query.Where(v =>
                        (v.Placa != null && v.Placa.ToLower().Contains(searchTerm)) ||
                        (v.Marca != null && v.Marca.ToLower().Contains(searchTerm)) ||
                        (v.Modelo != null && v.Modelo.ToLower().Contains(searchTerm))
                    );
                }

                // Aplicar ordenação
                switch (request.SortBy?.ToLower())
                {
                    case "marca":
                        query = request.SortDirection?.ToLower() == "desc" ?
                            query.OrderByDescending(v => v.Marca) :
                            query.OrderBy(v => v.Marca);
                        break;
                    case "modelo":
                        query = request.SortDirection?.ToLower() == "desc" ?
                            query.OrderByDescending(v => v.Modelo) :
                            query.OrderBy(v => v.Modelo);
                        break;
                    case "ano":
                        query = request.SortDirection?.ToLower() == "desc" ?
                            query.OrderByDescending(v => v.Ano) :
                            query.OrderBy(v => v.Ano);
                        break;
                    default:
                        query = request.SortDirection?.ToLower() == "desc" ?
                            query.OrderByDescending(v => v.Placa) :
                            query.OrderBy(v => v.Placa);
                        break;
                }

                var result = await query.ToPaginatedListAsync(request);
                return Ok(result);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Erro ao obter veículos", error = ex.Message });
            }
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
                    Marca = veiculoDto.Marca,
                    Modelo = veiculoDto.Modelo,
                    Ano = veiculoDto.Ano,
                    Tara = veiculoDto.Tara,
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
                veiculo.Marca = veiculoDto.Marca;
                veiculo.Modelo = veiculoDto.Modelo;
                veiculo.Ano = veiculoDto.Ano;
                veiculo.Tara = veiculoDto.Tara;
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