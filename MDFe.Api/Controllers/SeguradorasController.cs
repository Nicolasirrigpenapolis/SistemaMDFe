using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MDFeApi.Data;
using MDFeApi.DTOs;
using MDFeApi.Models;
using MDFeApi.Utils;

namespace MDFeApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class SeguradorasController : ControllerBase
    {
        private readonly MDFeContext _context;

        public SeguradorasController(MDFeContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<ResultadoPaginado<SeguradoraListDto>>> Get(
            [FromQuery] int pagina = 1,
            [FromQuery] int tamanhoPagina = 10,
            [FromQuery] string? busca = null)
        {
            var query = _context.Seguradoras.AsQueryable();

            if (!string.IsNullOrEmpty(busca))
            {
                query = query.Where(s =>
                    s.RazaoSocial.Contains(busca) ||
                    s.Cnpj.Contains(busca) ||
                    (s.Apolice != null && s.Apolice.Contains(busca)));
            }

            var totalItens = await query.CountAsync();

            var seguradoras = await query
                .OrderBy(s => s.RazaoSocial)
                .Skip((pagina - 1) * tamanhoPagina)
                .Take(tamanhoPagina)
                .Select(s => new SeguradoraListDto
                {
                    Id = s.Id,
                    Cnpj = s.Cnpj,
                    RazaoSocial = s.RazaoSocial,
                    NomeFantasia = s.NomeFantasia,
                    Apolice = s.Apolice,
                    Ativo = s.Ativo,
                    DataCriacao = s.DataCriacao
                })
                .ToListAsync();

            return Ok(new ResultadoPaginado<SeguradoraListDto>
            {
                Itens = seguradoras,
                TotalItens = totalItens,
                Pagina = pagina,
                TamanhoPagina = tamanhoPagina
            });
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<SeguradoraDetailDto>> Get(int id)
        {
            var seguradora = await _context.Seguradoras
                .Where(s => s.Id == id)
                .Select(s => new SeguradoraDetailDto
                {
                    Id = s.Id,
                    Cnpj = s.Cnpj,
                    RazaoSocial = s.RazaoSocial,
                    NomeFantasia = s.NomeFantasia,
                    Apolice = s.Apolice,
                    Ativo = s.Ativo,
                    DataCriacao = s.DataCriacao,
                    DataUltimaAlteracao = s.DataUltimaAlteracao
                })
                .FirstOrDefaultAsync();

            if (seguradora == null)
            {
                return NotFound(new { message = "Seguradora não encontrada" });
            }

            return Ok(seguradora);
        }

        [HttpPost]
        public async Task<ActionResult<SeguradoraDetailDto>> Post([FromBody] SeguradoraCreateWrapper wrapper)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var dto = wrapper.Dto;

            // Validações de negócio
            if (string.IsNullOrEmpty(dto.Cnpj))
            {
                return BadRequest(new { message = "CNPJ é obrigatório" });
            }

            var seguradora = new Seguradora
            {
                Cnpj = dto.Cnpj,
                RazaoSocial = dto.RazaoSocial?.Trim(),
                NomeFantasia = dto.NomeFantasia?.Trim(),
                Apolice = dto.Apolice?.Trim(),
                Ativo = dto.Ativo,
                DataCriacao = DateTime.Now
            };

            // Aplicar limpeza automática de documentos
            DocumentUtils.LimparDocumentosSeguradora(seguradora);

            // Verificar se já existe seguradora com mesmo CNPJ (usando dados limpos)
            var existenteCnpj = await _context.Seguradoras
                .Where(s => s.Cnpj == seguradora.Cnpj)
                .FirstOrDefaultAsync();

            if (existenteCnpj != null)
            {
                return BadRequest(new { message = "Já existe uma seguradora cadastrada com este CNPJ" });
            }

            _context.Seguradoras.Add(seguradora);
            await _context.SaveChangesAsync();

            var result = new SeguradoraDetailDto
            {
                Id = seguradora.Id,
                Cnpj = seguradora.Cnpj,
                RazaoSocial = seguradora.RazaoSocial,
                NomeFantasia = seguradora.NomeFantasia,
                Apolice = seguradora.Apolice,
                Ativo = seguradora.Ativo,
                DataCriacao = seguradora.DataCriacao,
                DataUltimaAlteracao = seguradora.DataUltimaAlteracao
            };

            return CreatedAtAction(nameof(Get), new { id = seguradora.Id }, result);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> Put(int id, SeguradoraUpdateDto dto)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var seguradora = await _context.Seguradoras.FindAsync(id);
            if (seguradora == null)
            {
                return NotFound(new { message = "Seguradora não encontrada" });
            }

            // Validações de negócio
            if (string.IsNullOrEmpty(dto.Cnpj))
            {
                return BadRequest(new { message = "CNPJ é obrigatório" });
            }

            // Atualizar dados com trim
            seguradora.Cnpj = dto.Cnpj;
            seguradora.RazaoSocial = dto.RazaoSocial?.Trim();
            seguradora.NomeFantasia = dto.NomeFantasia?.Trim();
            seguradora.Apolice = dto.Apolice?.Trim();
            seguradora.Ativo = dto.Ativo;
            seguradora.DataUltimaAlteracao = DateTime.Now;

            // Aplicar limpeza automática de documentos
            DocumentUtils.LimparDocumentosSeguradora(seguradora);

            // Verificar se já existe outra seguradora com mesmo CNPJ (usando dados limpos)
            var existenteCnpj = await _context.Seguradoras
                .Where(s => s.Id != id && s.Cnpj == seguradora.Cnpj)
                .FirstOrDefaultAsync();

            if (existenteCnpj != null)
            {
                return BadRequest(new { message = "Já existe outra seguradora cadastrada com este CNPJ" });
            }

            try
            {
                await _context.SaveChangesAsync();
                return Ok(new { message = "Seguradora atualizada com sucesso" });
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!SeguradoraExists(id))
                {
                    return NotFound(new { message = "Seguradora não encontrada" });
                }
                throw;
            }
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            var seguradora = await _context.Seguradoras.FindAsync(id);
            if (seguradora == null)
            {
                return NotFound(new { message = "Seguradora não encontrada" });
            }

            // Verificar se a seguradora está sendo usada em algum MDFe
            var temMdfeVinculado = await _context.MDFes
                .AnyAsync(m => m.SeguradoraId == id);

            if (temMdfeVinculado)
            {
                // Desativar ao invés de excluir
                seguradora.Ativo = false;
                seguradora.DataUltimaAlteracao = DateTime.Now;
                await _context.SaveChangesAsync();
                return Ok(new { message = "Seguradora desativada com sucesso (estava sendo usada em MDFes)" });
            }
            else
            {
                // Pode excluir fisicamente
                _context.Seguradoras.Remove(seguradora);
                await _context.SaveChangesAsync();
                return Ok(new { message = "Seguradora excluída com sucesso" });
            }
        }

        [HttpGet("sugestoes")]
        public ActionResult<IEnumerable<object>> GetSugestoesSeguradoras()
        {
            // Lista de seguradoras comuns para sugestão
            var sugestoes = new[]
            {
                new { id = "02038527000143", cnpj = "02.038.527/0001-43", nome = "Itaú Seguros S.A." },
                new { id = "61194053000133", cnpj = "61.194.053/0001-33", nome = "Bradesco Seguros S.A." },
                new { id = "92693118000191", cnpj = "92.693.118/0001-91", nome = "Tokio Marine Seguradora S.A." },
                new { id = "05523314000148", cnpj = "05.523.314/0001-48", nome = "Porto Seguro Companhia de Seguros Gerais" },
                new { id = "34484541000184", cnpj = "34.484.541/0001-84", nome = "SulAmérica Companhia Nacional de Seguros" },
                new { id = "88610040000119", cnpj = "88.610.040/0001-19", nome = "Allianz Seguros S.A." },
                new { id = "17192577000170", cnpj = "17.192.577/0001-70", nome = "Mapfre Seguros Gerais S.A." },
                new { id = "33041260000162", cnpj = "33.041.260/0001-62", nome = "Liberty Seguros S.A." }
            };

            return Ok(sugestoes);
        }

        private bool SeguradoraExists(int id)
        {
            return _context.Seguradoras.Any(e => e.Id == id);
        }
    }
}