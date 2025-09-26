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
    public class ContratantesController : ControllerBase
    {
        private readonly MDFeContext _context;

        public ContratantesController(MDFeContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<ResultadoPaginado<ContratanteListDto>>> Get(
            [FromQuery] int pagina = 1,
            [FromQuery] int tamanhoPagina = 10,
            [FromQuery] string? search = null)
        {
            var query = _context.Contratantes.AsQueryable();

            if (!string.IsNullOrEmpty(search))
            {
                query = query.Where(c =>
                    c.RazaoSocial.Contains(search) ||
                    c.NomeFantasia!.Contains(search) ||
                    c.Cnpj!.Contains(search) ||
                    c.Cpf!.Contains(search));
            }

            var totalItens = await query.CountAsync();

            var contratantes = await query
                .OrderBy(c => c.RazaoSocial)
                .Skip((pagina - 1) * tamanhoPagina)
                .Take(tamanhoPagina)
                .Select(c => new ContratanteListDto
                {
                    Id = c.Id,
                    Cnpj = c.Cnpj,
                    Cpf = c.Cpf,
                    RazaoSocial = c.RazaoSocial,
                    NomeFantasia = c.NomeFantasia,
                    Endereco = c.Endereco,
                    Numero = c.Numero,
                    Complemento = c.Complemento,
                    Bairro = c.Bairro,
                    CodMunicipio = c.CodMunicipio,
                    Municipio = c.Municipio,
                    Cep = c.Cep,
                    Uf = c.Uf,
                    Ativo = c.Ativo,
                    DataCriacao = c.DataCriacao
                })
                .ToListAsync();

            return Ok(new ResultadoPaginado<ContratanteListDto>
            {
                Itens = contratantes,
                TotalItens = totalItens,
                Pagina = pagina,
                TamanhoPagina = tamanhoPagina
            });
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<ContratanteDetailDto>> Get(int id)
        {
            var contratante = await _context.Contratantes
                .Where(c => c.Id == id)
                .Select(c => new ContratanteDetailDto
                {
                    Id = c.Id,
                    Cnpj = c.Cnpj,
                    Cpf = c.Cpf,
                    RazaoSocial = c.RazaoSocial,
                    NomeFantasia = c.NomeFantasia,
                    Endereco = c.Endereco,
                    Numero = c.Numero,
                    Complemento = c.Complemento,
                    Bairro = c.Bairro,
                    CodMunicipio = c.CodMunicipio,
                    Municipio = c.Municipio,
                    Cep = c.Cep,
                    Uf = c.Uf,
                    Ativo = c.Ativo,
                    DataCriacao = c.DataCriacao,
                    DataUltimaAlteracao = c.DataUltimaAlteracao
                })
                .FirstOrDefaultAsync();

            if (contratante == null)
            {
                return NotFound(new { message = "Contratante não encontrado" });
            }

            return Ok(contratante);
        }

        [HttpPost]
        public async Task<ActionResult<ContratanteDetailDto>> Post([FromBody] ContratanteCreateDto dto)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            // Validações de negócio
            if (string.IsNullOrEmpty(dto.Cnpj) && string.IsNullOrEmpty(dto.Cpf))
            {
                return BadRequest(new { message = "CNPJ ou CPF é obrigatório" });
            }

            var contratante = new Contratante
            {
                Cnpj = dto.Cnpj,
                Cpf = dto.Cpf,
                RazaoSocial = dto.RazaoSocial?.Trim(),
                NomeFantasia = dto.NomeFantasia?.Trim(),
                Endereco = dto.Endereco?.Trim(),
                Numero = dto.Numero?.Trim(),
                Complemento = dto.Complemento?.Trim(),
                Bairro = dto.Bairro?.Trim(),
                CodMunicipio = dto.CodMunicipio,
                Municipio = dto.Municipio?.Trim(),
                Cep = dto.Cep,
                Uf = dto.Uf?.Trim(),
                Ativo = dto.Ativo,
                DataCriacao = DateTime.Now
            };

            // Aplicar limpeza automática de documentos
            DocumentUtils.LimparDocumentosContratante(contratante);

            // Verificar se já existe contratante com mesmo CNPJ ou CPF (usando dados limpos)
            var existente = await _context.Contratantes
                .Where(c => (!string.IsNullOrEmpty(contratante.Cnpj) && c.Cnpj == contratante.Cnpj) ||
                           (!string.IsNullOrEmpty(contratante.Cpf) && c.Cpf == contratante.Cpf))
                .FirstOrDefaultAsync();

            if (existente != null)
            {
                return BadRequest(new { message = "Já existe um contratante cadastrado com este CNPJ/CPF" });
            }

            _context.Contratantes.Add(contratante);
            await _context.SaveChangesAsync();

            var result = new ContratanteDetailDto
            {
                Id = contratante.Id,
                Cnpj = contratante.Cnpj,
                Cpf = contratante.Cpf,
                RazaoSocial = contratante.RazaoSocial,
                NomeFantasia = contratante.NomeFantasia,
                Endereco = contratante.Endereco,
                Numero = contratante.Numero,
                Complemento = contratante.Complemento,
                Bairro = contratante.Bairro,
                CodMunicipio = contratante.CodMunicipio,
                Municipio = contratante.Municipio,
                Cep = contratante.Cep,
                Uf = contratante.Uf,
                Ativo = contratante.Ativo,
                DataCriacao = contratante.DataCriacao,
                DataUltimaAlteracao = contratante.DataUltimaAlteracao
            };

            return CreatedAtAction(nameof(Get), new { id = contratante.Id }, result);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> Put(int id, [FromBody] ContratanteUpdateDto dto)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var contratante = await _context.Contratantes.FindAsync(id);
            if (contratante == null)
            {
                return NotFound(new { message = "Contratante não encontrado" });
            }

            // Validações de negócio
            if (string.IsNullOrEmpty(dto.Cnpj) && string.IsNullOrEmpty(dto.Cpf))
            {
                return BadRequest(new { message = "CNPJ ou CPF é obrigatório" });
            }

            // Atualizar dados com trim
            contratante.Cnpj = dto.Cnpj;
            contratante.Cpf = dto.Cpf;
            contratante.RazaoSocial = dto.RazaoSocial?.Trim();
            contratante.NomeFantasia = dto.NomeFantasia?.Trim();
            contratante.Endereco = dto.Endereco?.Trim();
            contratante.Numero = dto.Numero?.Trim();
            contratante.Complemento = dto.Complemento?.Trim();
            contratante.Bairro = dto.Bairro?.Trim();
            contratante.CodMunicipio = dto.CodMunicipio;
            contratante.Municipio = dto.Municipio?.Trim();
            contratante.Cep = dto.Cep;
            contratante.Uf = dto.Uf?.Trim();
            contratante.Ativo = dto.Ativo;
            contratante.DataUltimaAlteracao = DateTime.Now;

            // Aplicar limpeza automática de documentos
            DocumentUtils.LimparDocumentosContratante(contratante);

            // Verificar se já existe outro contratante com mesmo CNPJ ou CPF (usando dados limpos)
            var existente = await _context.Contratantes
                .Where(c => c.Id != id &&
                           ((!string.IsNullOrEmpty(contratante.Cnpj) && c.Cnpj == contratante.Cnpj) ||
                            (!string.IsNullOrEmpty(contratante.Cpf) && c.Cpf == contratante.Cpf)))
                .FirstOrDefaultAsync();

            if (existente != null)
            {
                return BadRequest(new { message = "Já existe outro contratante cadastrado com este CNPJ/CPF" });
            }

            try
            {
                await _context.SaveChangesAsync();
                return Ok(new { message = "Contratante atualizado com sucesso" });
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ContratanteExists(id))
                {
                    return NotFound(new { message = "Contratante não encontrado" });
                }
                throw;
            }
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            var contratante = await _context.Contratantes.FindAsync(id);
            if (contratante == null)
            {
                return NotFound(new { message = "Contratante não encontrado" });
            }

            // Verificar se o contratante está sendo usado em algum MDFe
            var temMdfeVinculado = await _context.MDFes
                .AnyAsync(m => m.ContratanteId == id);

            if (temMdfeVinculado)
            {
                // Desativar ao invés de excluir
                contratante.Ativo = false;
                contratante.DataUltimaAlteracao = DateTime.Now;
                await _context.SaveChangesAsync();
                return Ok(new { message = "Contratante desativado com sucesso (estava sendo usado em MDFes)" });
            }
            else
            {
                // Pode excluir fisicamente
                _context.Contratantes.Remove(contratante);
                await _context.SaveChangesAsync();
                return Ok(new { message = "Contratante excluído com sucesso" });
            }
        }

        private bool ContratanteExists(int id)
        {
            return _context.Contratantes.Any(e => e.Id == id);
        }
    }
}