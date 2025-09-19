using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MDFeApi.Data;

namespace MDFeApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class LocalidadeController : ControllerBase
    {
        private readonly MDFeContext _context;
        private readonly ILogger<LocalidadeController> _logger;

        public LocalidadeController(MDFeContext context, ILogger<LocalidadeController> logger)
        {
            _context = context;
            _logger = logger;
        }

        /// <summary>
        /// Obter lista de estados distintos da tabela de municípios
        /// </summary>
        [HttpGet("estados")]
        public async Task<IActionResult> ObterEstados()
        {
            try
            {
                // Puxar estados diretamente da tabela de municípios, agrupando por UF
                var estados = await _context.Municipios
                    .Where(m => m.Ativo)
                    .Select(m => m.Uf)
                    .Distinct()
                    .Select(uf => new
                    {
                        Id = (int)(uf.GetHashCode() % 100 + 1), // ID simples baseado na UF
                        Sigla = uf,
                        Nome = uf // Usar a própria sigla como nome, ou mapear se necessário
                    })
                    .OrderBy(e => e.Sigla)
                    .ToListAsync();

                return Ok(estados);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao buscar estados da tabela de municípios");
                return StatusCode(500, new { message = "Erro interno do servidor" });
            }
        }

        /// <summary>
        /// Obter lista de municípios por estado (UF) do banco local
        /// </summary>
        [HttpGet("municipios/{uf}")]
        public async Task<IActionResult> ObterMunicipiosPorEstado(string uf)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(uf) || uf.Length != 2)
                {
                    return BadRequest(new { message = "UF deve conter exatamente 2 caracteres" });
                }

                var municipios = await _context.Municipios
                    .Where(m => m.Uf.ToUpper() == uf.ToUpper() && m.Ativo)
                    .OrderBy(m => m.Nome)
                    .Select(m => new
                    {
                        Id = m.Codigo,  // Usar código IBGE como ID
                        Codigo = m.Codigo,
                        Nome = m.Nome,
                        UF = m.Uf
                    })
                    .ToListAsync();

                return Ok(municipios);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao buscar municípios para UF: {uf} no banco local", uf);
                return StatusCode(500, new { message = "Erro interno do servidor" });
            }
        }

        /// <summary>
        /// Buscar código IBGE de um município específico do banco local
        /// </summary>
        [HttpGet("codigo-municipio")]
        public async Task<IActionResult> ObterCodigoMunicipio([FromQuery] string municipio, [FromQuery] string uf)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(municipio) || string.IsNullOrWhiteSpace(uf))
                {
                    return BadRequest(new { message = "Município e UF são obrigatórios" });
                }

                var municipioEncontrado = await _context.Municipios
                    .FirstOrDefaultAsync(m => m.Nome.ToUpper() == municipio.ToUpper() &&
                                            m.Uf.ToUpper() == uf.ToUpper() &&
                                            m.Ativo);

                if (municipioEncontrado == null)
                {
                    return NotFound(new { message = "Município não encontrado no banco local" });
                }

                return Ok(new
                {
                    codigo = municipioEncontrado.Codigo,
                    municipio = municipioEncontrado.Nome,
                    uf = municipioEncontrado.Uf
                });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao buscar código do município: {municipio}/{uf} no banco local", municipio, uf);
                return StatusCode(500, new { message = "Erro interno do servidor" });
            }
        }
    }
}