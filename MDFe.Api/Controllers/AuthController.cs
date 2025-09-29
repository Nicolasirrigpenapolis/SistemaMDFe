using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using MDFeApi.Models;
using MDFeApi.DTOs;
using Microsoft.AspNetCore.Authorization;
using Microsoft.EntityFrameworkCore;
using MDFeApi.Data;

namespace MDFeApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AuthController : ControllerBase
    {
        private readonly UserManager<Usuario> _userManager;
        private readonly SignInManager<Usuario> _signInManager;
        private readonly IConfiguration _configuration;
        private readonly MDFeContext _context;

        public AuthController(
            UserManager<Usuario> userManager,
            SignInManager<Usuario> signInManager,
            IConfiguration configuration,
            MDFeContext context)
        {
            _userManager = userManager;
            _signInManager = signInManager;
            _configuration = configuration;
            _context = context;
        }

        [HttpPost("login")]
        public async Task<IActionResult> Login([FromBody] LoginRequest request)
        {
            try
            {
                var user = await _context.Users
                    .Include(u => u.Cargo)
                    .FirstOrDefaultAsync(u => u.UserName == request.Username);

                if (user == null || !user.Ativo)
                {
                    return BadRequest(new { message = "Credenciais inválidas" });
                }

                var result = await _signInManager.CheckPasswordSignInAsync(user, request.Password, false);
                if (!result.Succeeded)
                {
                    return BadRequest(new { message = "Credenciais inválidas" });
                }

                var token = await GenerateJwtToken(user);
                
                // Atualizar último login
                user.DataUltimoLogin = DateTime.Now;
                await _userManager.UpdateAsync(user);

                return Ok(new LoginResponse
                {
                    Token = token,
                    User = new UserInfo
                    {
                        Id = user.Id,
                        Nome = user.Nome,
                        Username = user.UserName ?? "",
                        Email = user.Email ?? "",
                        Telefone = user.Telefone,
                        CargoId = user.CargoId,
                        CargoNome = user.Cargo?.Nome
                    }
                });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Erro interno do servidor", error = ex.Message });
            }
        }

        [HttpPost("register")]
        [Authorize]
        public async Task<IActionResult> Register([FromBody] RegisterRequest request)
        {
            try
            {
                // Verificar se o usuário atual é Master ou Admin
                var currentUserId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
                if (currentUserId == null)
                {
                    return Unauthorized(new { message = "Usuário não autenticado" });
                }

                var currentUser = await _context.Users
                    .Include(u => u.Cargo)
                    .FirstOrDefaultAsync(u => u.Id.ToString() == currentUserId);

                if (currentUser == null || currentUser.Cargo?.Nome != "Programador")
                {
                    return Forbid("Apenas usuários com cargo 'Programador' podem criar novos usuários");
                }

                var existingUser = await _userManager.FindByNameAsync(request.Username);
                if (existingUser != null)
                {
                    return BadRequest(new { message = "Nome de usuário já está em uso" });
                }

                var existingEmail = await _userManager.FindByEmailAsync(request.Email);
                if (existingEmail != null)
                {
                    return BadRequest(new { message = "Email já está em uso" });
                }

                var user = new Usuario
                {
                    UserName = request.Username,
                    Email = request.Email,
                    Nome = request.Nome,
                    Telefone = request.Telefone,
                    CargoId = request.CargoId,
                    EmailConfirmed = true,
                    Ativo = true
                };

                var result = await _userManager.CreateAsync(user, request.Password);
                if (!result.Succeeded)
                {
                    return BadRequest(new { message = "Erro ao criar usuário", errors = result.Errors });
                }

                return Ok(new { message = "Usuário criado com sucesso" });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Erro interno do servidor", error = ex.Message });
            }
        }

        private async Task<string> GenerateJwtToken(Usuario user)
        {
            var jwtSettings = _configuration.GetSection("JwtSettings");
            var secretKey = Encoding.ASCII.GetBytes(jwtSettings["SecretKey"]!);

            var claims = new List<Claim>
            {
                new(ClaimTypes.NameIdentifier, user.Id.ToString()),
                new(ClaimTypes.Name, user.Nome),
                new(ClaimTypes.Email, user.Email ?? "")
            };

            // Adicionar cargo se tiver
            if (user.Cargo != null)
            {
                claims.Add(new Claim(ClaimTypes.Role, user.Cargo.Nome));
                claims.Add(new Claim("cargo", user.Cargo.Nome));
                claims.Add(new Claim("cargoId", user.CargoId.ToString() ?? ""));
            }

            var roles = await _userManager.GetRolesAsync(user);
            claims.AddRange(roles.Select(role => new Claim(ClaimTypes.Role, role)));

            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(claims),
                Expires = DateTime.UtcNow.AddMinutes(double.Parse(jwtSettings["ExpirationInMinutes"]!)),
                Issuer = jwtSettings["Issuer"],
                Audience = jwtSettings["Audience"],
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(secretKey), SecurityAlgorithms.HmacSha256Signature)
            };

            var tokenHandler = new JwtSecurityTokenHandler();
            var token = tokenHandler.CreateToken(tokenDescriptor);
            return tokenHandler.WriteToken(token);
        }
    }
}