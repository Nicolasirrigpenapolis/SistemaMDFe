using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MDFeApi.Data;
using MDFeApi.Models;
using MDFeApi.DTOs;
using MDFeApi.Services;
using System.Diagnostics;

namespace MDFeApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class MunicipiosController : ControllerBase
    {
        private readonly MDFeContext _context;
        private readonly IIBGEService _ibgeService;
        private readonly ILogger<MunicipiosController> _logger;

        public MunicipiosController(MDFeContext context, IIBGEService ibgeService, ILogger<MunicipiosController> logger)
        {
            _context = context;
            _ibgeService = ibgeService;
            _logger = logger;
        }

        [HttpGet]
        public async Task<ActionResult<PagedResult<Municipio>>> GetMunicipios([FromQuery] string? uf = null, [FromQuery] int page = 1, [FromQuery] int pageSize = 10)
        {
            var query = _context.Municipios.Where(m => m.Ativo).AsQueryable();

            if (!string.IsNullOrEmpty(uf))
            {
                query = query.Where(m => m.Uf == uf);
            }

            var totalCount = await query.CountAsync();

            var items = await query
                .OrderBy(m => m.Nome)
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToListAsync();

            var pagedResult = new PagedResult<Municipio>
            {
                Items = items,
                TotalCount = totalCount,
                Page = page,
                PageSize = pageSize
            };

            return Ok(pagedResult);
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Municipio>> GetMunicipio(int id)
        {
            var municipio = await _context.Municipios
                .Where(m => m.Ativo)
                .FirstOrDefaultAsync(m => m.Id == id);

            if (municipio == null)
            {
                return NotFound();
            }

            return municipio;
        }

        [HttpGet("codigo/{codigo}")]
        public async Task<ActionResult<Municipio>> GetMunicipioByCodigo(int codigo)
        {
            var municipio = await _context.Municipios
                .Where(m => m.Ativo)
                .FirstOrDefaultAsync(m => m.Codigo == codigo);

            if (municipio == null)
            {
                return NotFound();
            }

            return municipio;
        }

        [HttpPost]
        public async Task<ActionResult<DTOs.MunicipioDto>> PostMunicipio(MunicipioCreateDto municipioDto)
        {
            var municipioExistente = await _context.Municipios
                .FirstOrDefaultAsync(m => m.Codigo == municipioDto.Codigo);

            if (municipioExistente != null)
            {
                return BadRequest($"Já existe um município com o código {municipioDto.Codigo}");
            }

            var municipio = new Municipio
            {
                Codigo = municipioDto.Codigo,
                Nome = municipioDto.Nome,
                Uf = municipioDto.Uf.ToUpper(),
                Ativo = true
            };

            _context.Municipios.Add(municipio);
            await _context.SaveChangesAsync();

            var resultado = new DTOs.MunicipioDto
            {
                Id = municipio.Id,
                Codigo = municipio.Codigo,
                Nome = municipio.Nome,
                Uf = municipio.Uf,
                Ativo = municipio.Ativo
            };

            return CreatedAtAction(nameof(GetMunicipio), new { id = municipio.Id }, resultado);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> PutMunicipio(int id, MunicipioUpdateDto municipioDto)
        {
            var municipio = await _context.Municipios.FindAsync(id);

            if (municipio == null)
            {
                return NotFound();
            }

            municipio.Nome = municipioDto.Nome;
            municipio.Uf = municipioDto.Uf.ToUpper();
            municipio.Ativo = municipioDto.Ativo;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!MunicipioExists(id))
                {
                    return NotFound();
                }
                throw;
            }

            return NoContent();
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteMunicipio(int id)
        {
            var municipio = await _context.Municipios.FindAsync(id);
            if (municipio == null)
            {
                return NotFound();
            }

            municipio.Ativo = false;
            await _context.SaveChangesAsync();

            return NoContent();
        }

        [HttpPost("importar-todos-ibge")]
        public async Task<ActionResult<ImportResultDto>> ImportarTodosMunicipiosIBGE()
        {
            var stopwatch = Stopwatch.StartNew();
            var resultado = new ImportResultDto { Sucesso = true };

            try
            {
                _logger.LogInformation("Iniciando import completo de municípios do IBGE");

                var municipiosIBGE = await _ibgeService.ImportarTodosMunicipiosAsync();
                
                if (!municipiosIBGE.Any())
                {
                    resultado.Sucesso = false;
                    resultado.Erros.Add("Não foi possível obter dados do IBGE");
                    return BadRequest(resultado);
                }

                resultado.TotalEstados = municipiosIBGE.Select(m => m.UF).Distinct().Count();

                using var transaction = await _context.Database.BeginTransactionAsync();

                try
                {
                    var municipiosExistentes = await _context.Municipios
                        .ToDictionaryAsync(m => m.Codigo, m => m);

                    var municipiosParaInserir = new List<Municipio>();

                    foreach (var municipioIBGE in municipiosIBGE)
                    {
                        if (municipiosExistentes.TryGetValue(municipioIBGE.Id, out var existente))
                        {
                            if (existente.Nome != municipioIBGE.Nome || 
                                existente.Uf != municipioIBGE.UF || 
                                !existente.Ativo)
                            {
                                existente.Nome = municipioIBGE.Nome;
                                existente.Uf = municipioIBGE.UF;
                                existente.Ativo = true;
                                resultado.TotalAtualizados++;
                            }
                            else
                            {
                                resultado.TotalIgnorados++;
                            }
                        }
                        else
                        {
                            municipiosParaInserir.Add(new Municipio
                            {
                                Codigo = municipioIBGE.Id,
                                Nome = municipioIBGE.Nome,
                                Uf = municipioIBGE.UF,
                                Ativo = true
                            });
                        }
                    }

                    if (municipiosParaInserir.Any())
                    {
                        await _context.Municipios.AddRangeAsync(municipiosParaInserir);
                        resultado.TotalInseridos = municipiosParaInserir.Count;
                    }

                    await _context.SaveChangesAsync();
                    await transaction.CommitAsync();

                    _logger.LogInformation($"Import concluído: {resultado.TotalInseridos} inseridos, {resultado.TotalAtualizados} atualizados, {resultado.TotalIgnorados} ignorados");
                }
                catch (Exception ex)
                {
                    await transaction.RollbackAsync();
                    _logger.LogError(ex, "Erro durante importação de municípios");
                    throw;
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro durante import de municípios");
                resultado.Sucesso = false;
                resultado.Erros.Add($"Erro durante o processamento: {ex.Message}");
                return StatusCode(500, resultado);
            }
            finally
            {
                stopwatch.Stop();
                resultado.TempoProcessamento = stopwatch.Elapsed;
            }

            return Ok(resultado);
        }

        private bool MunicipioExists(int id)
        {
            return _context.Municipios.Any(e => e.Id == id);
        }
    }
}