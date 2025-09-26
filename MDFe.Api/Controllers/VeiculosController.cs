using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MDFeApi.Data;
using MDFeApi.Models;
using MDFeApi.DTOs;
using MDFeApi.Extensions;
using MDFeApi.Utils;

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
                        (v.Marca != null && v.Marca.ToLower().Contains(searchTerm))
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
                var veiculo = new Veiculo
                {
                    Placa = veiculoDto.Placa,
                    Marca = veiculoDto.Marca?.Trim(),
                    Tara = veiculoDto.Tara,
                    TipoRodado = veiculoDto.TipoRodado?.Trim(),
                    TipoCarroceria = veiculoDto.TipoCarroceria?.Trim(),
                    Uf = veiculoDto.Uf?.Trim(),
                    Ativo = true
                };

                // Aplicar limpeza automática de documentos
                DocumentUtils.LimparDocumentosVeiculo(veiculo);

                // Validar se placa já existe (usando dados limpos)
                var existingPlaca = await _context.Veiculos
                    .AnyAsync(v => v.Placa == veiculo.Placa && v.Ativo);
                if (existingPlaca)
                {
                    return BadRequest(new { message = "Placa já cadastrada" });
                }

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
                return NotFound(new { message = "Veículo não encontrado" });
            }

            try
            {
                // Salvar placa original
                var placaOriginal = veiculo.Placa;

                // Atualizar dados com trim
                veiculo.Placa = veiculoDto.Placa;
                veiculo.Marca = veiculoDto.Marca?.Trim();
                veiculo.Tara = veiculoDto.Tara;
                veiculo.TipoRodado = veiculoDto.TipoRodado?.Trim();
                veiculo.TipoCarroceria = veiculoDto.TipoCarroceria?.Trim();
                veiculo.Uf = veiculoDto.Uf?.Trim();

                // Aplicar limpeza automática de documentos
                DocumentUtils.LimparDocumentosVeiculo(veiculo);

                // Validar se placa já existe (exceto para o próprio veículo, usando dados limpos)
                if (veiculo.Placa != placaOriginal)
                {
                    var existingPlaca = await _context.Veiculos
                        .AnyAsync(v => v.Placa == veiculo.Placa && v.Id != id && v.Ativo);
                    if (existingPlaca)
                    {
                        return BadRequest(new { message = "Placa já cadastrada" });
                    }
                }

                await _context.SaveChangesAsync();

                return NoContent();
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Erro ao atualizar veículo", error = ex.Message });
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