using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MDFeApi.Data;
using MDFeApi.DTOs;
using MDFeApi.Models;
using System.Security.Claims;

namespace MDFeApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    [Authorize]
    public class CargosController : ControllerBase
    {
        private readonly MDFeContext _context;
        private readonly UserManager<Usuario> _userManager;

        public CargosController(MDFeContext context, UserManager<Usuario> userManager)
        {
            _context = context;
            _userManager = userManager;
        }

        [HttpGet]
        public async Task<IActionResult> GetCargos()
        {
            try
            {
                var cargos = await _context.Cargos
                    .Include(c => c.Usuarios)
                    .OrderBy(c => c.Nome)
                    .Select(c => new CargoResponse
                    {
                        Id = c.Id,
                        Nome = c.Nome,
                        Descricao = c.Descricao,
                        Ativo = c.Ativo,
                        DataCriacao = c.DataCriacao,
                        DataUltimaAlteracao = c.DataUltimaAlteracao,
                        QuantidadeUsuarios = c.Usuarios.Count(u => u.Ativo)
                    })
                    .ToListAsync();

                return Ok(cargos);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Erro interno do servidor", error = ex.Message });
            }
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetCargo(int id)
        {
            try
            {
                var cargo = await _context.Cargos
                    .Include(c => c.Usuarios)
                    .FirstOrDefaultAsync(c => c.Id == id);

                if (cargo == null)
                {
                    return NotFound(new { message = "Cargo não encontrado" });
                }

                var response = new CargoResponse
                {
                    Id = cargo.Id,
                    Nome = cargo.Nome,
                    Descricao = cargo.Descricao,
                    Ativo = cargo.Ativo,
                    DataCriacao = cargo.DataCriacao,
                    DataUltimaAlteracao = cargo.DataUltimaAlteracao,
                    QuantidadeUsuarios = cargo.Usuarios.Count(u => u.Ativo)
                };

                return Ok(response);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Erro interno do servidor", error = ex.Message });
            }
        }

        [HttpPost]
        public async Task<IActionResult> CreateCargo([FromBody] CargoCreateRequest request)
        {
            try
            {
                // Verificar se é Programador
                if (!await IsUserProgramador())
                {
                    return Forbid("Apenas usuários com cargo 'Programador' podem criar cargos");
                }

                // Verificar se já existe um cargo com o mesmo nome
                var existingCargo = await _context.Cargos
                    .FirstOrDefaultAsync(c => c.Nome.ToLower() == request.Nome.ToLower());

                if (existingCargo != null)
                {
                    return BadRequest(new { message = "Já existe um cargo com este nome" });
                }

                var cargo = new Cargo
                {
                    Nome = request.Nome.Trim(),
                    Descricao = request.Descricao?.Trim(),
                    Ativo = true,
                    DataCriacao = DateTime.Now
                };

                _context.Cargos.Add(cargo);
                await _context.SaveChangesAsync();

                var response = new CargoResponse
                {
                    Id = cargo.Id,
                    Nome = cargo.Nome,
                    Descricao = cargo.Descricao,
                    Ativo = cargo.Ativo,
                    DataCriacao = cargo.DataCriacao,
                    DataUltimaAlteracao = cargo.DataUltimaAlteracao,
                    QuantidadeUsuarios = 0
                };

                return CreatedAtAction(nameof(GetCargo), new { id = cargo.Id }, response);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Erro interno do servidor", error = ex.Message });
            }
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateCargo(int id, [FromBody] CargoUpdateRequest request)
        {
            try
            {
                // Verificar se é Programador
                if (!await IsUserProgramador())
                {
                    return Forbid("Apenas usuários com cargo 'Programador' podem atualizar cargos");
                }

                var cargo = await _context.Cargos.FindAsync(id);
                if (cargo == null)
                {
                    return NotFound(new { message = "Cargo não encontrado" });
                }

                // Verificar se já existe outro cargo com o mesmo nome
                var existingCargo = await _context.Cargos
                    .FirstOrDefaultAsync(c => c.Id != id && c.Nome.ToLower() == request.Nome.ToLower());

                if (existingCargo != null)
                {
                    return BadRequest(new { message = "Já existe outro cargo com este nome" });
                }

                cargo.Nome = request.Nome.Trim();
                cargo.Descricao = request.Descricao?.Trim();
                cargo.Ativo = request.Ativo;
                cargo.DataUltimaAlteracao = DateTime.Now;

                await _context.SaveChangesAsync();

                return Ok(new { message = "Cargo atualizado com sucesso" });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Erro interno do servidor", error = ex.Message });
            }
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCargo(int id)
        {
            try
            {
                // Verificar se é Programador
                if (!await IsUserProgramador())
                {
                    return Forbid("Apenas usuários com cargo 'Programador' podem excluir cargos");
                }

                var cargo = await _context.Cargos
                    .Include(c => c.Usuarios)
                    .FirstOrDefaultAsync(c => c.Id == id);

                if (cargo == null)
                {
                    return NotFound(new { message = "Cargo não encontrado" });
                }

                // Verificar se há usuários ativos com este cargo
                if (cargo.Usuarios.Any(u => u.Ativo))
                {
                    return BadRequest(new { message = "Não é possível excluir cargo que possui usuários ativos" });
                }

                _context.Cargos.Remove(cargo);
                await _context.SaveChangesAsync();

                return Ok(new { message = "Cargo excluído com sucesso" });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Erro interno do servidor", error = ex.Message });
            }
        }

        private async Task<bool> IsUserProgramador()
        {
            var currentUserId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            if (currentUserId == null) return false;

            var currentUser = await _userManager.FindByIdAsync(currentUserId);
            return currentUser != null && currentUser.Cargo?.Nome == "Programador";
        }
    }
}