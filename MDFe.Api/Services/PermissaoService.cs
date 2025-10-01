using Microsoft.EntityFrameworkCore;
using MDFeApi.Data;
using MDFeApi.Models;
using MDFeApi.Repositories;

namespace MDFeApi.Services
{
    public class PermissaoService : IPermissaoService
    {
        private readonly IPermissaoRepository _permissaoRepository;
        private readonly MDFeContext _context;

        public PermissaoService(IPermissaoRepository permissaoRepository, MDFeContext context)
        {
            _permissaoRepository = permissaoRepository;
            _context = context;
        }

        public async Task<IEnumerable<Permissao>> GetAllPermissoesAsync()
        {
            return await _permissaoRepository.GetAllAsync();
        }

        public async Task<IEnumerable<Permissao>> GetPermissoesByCargoIdAsync(int cargoId)
        {
            return await _permissaoRepository.GetPermissoesByCargoIdAsync(cargoId);
        }

        public async Task<IEnumerable<Permissao>> GetPermissoesByModuloAsync(string modulo)
        {
            return await _permissaoRepository.GetPermissoesByModuloAsync(modulo);
        }

        public async Task<bool> UserHasPermissionAsync(int? cargoId, string codigoPermissao)
        {
            if (!cargoId.HasValue)
                return false;

            return await _permissaoRepository.CargoHasPermissaoAsync(cargoId.Value, codigoPermissao);
        }

        public async Task<IEnumerable<string>> GetUserPermissionsAsync(int? cargoId)
        {
            if (!cargoId.HasValue)
                return new List<string>();

            return await _permissaoRepository.GetCodigosPermissoesByCargoIdAsync(cargoId.Value);
        }

        public async Task AtribuirPermissaoToCargoAsync(int cargoId, int permissaoId)
        {
            var existeRelacao = await _context.CargoPermissoes
                .AnyAsync(cp => cp.CargoId == cargoId && cp.PermissaoId == permissaoId);

            if (!existeRelacao)
            {
                var cargoPermissao = new CargoPermissao
                {
                    CargoId = cargoId,
                    PermissaoId = permissaoId,
                    DataCriacao = DateTime.Now
                };

                _context.CargoPermissoes.Add(cargoPermissao);
                await _context.SaveChangesAsync();
            }
        }

        public async Task RemoverPermissaoFromCargoAsync(int cargoId, int permissaoId)
        {
            var cargoPermissao = await _context.CargoPermissoes
                .FirstOrDefaultAsync(cp => cp.CargoId == cargoId && cp.PermissaoId == permissaoId);

            if (cargoPermissao != null)
            {
                _context.CargoPermissoes.Remove(cargoPermissao);
                await _context.SaveChangesAsync();
            }
        }

        public async Task<IEnumerable<string>> GetModulosAsync()
        {
            return await _context.Permissoes
                .Where(p => p.Ativo)
                .Select(p => p.Modulo)
                .Distinct()
                .OrderBy(m => m)
                .ToListAsync();
        }
    }
}