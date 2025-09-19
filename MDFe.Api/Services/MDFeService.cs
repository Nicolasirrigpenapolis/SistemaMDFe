using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Caching.Memory;
using MDFeApi.Data;
using MDFeApi.Models;

namespace MDFeApi.Services
{
    public class MDFeService : IMDFeService
    {
        private readonly MDFeContext _context;
        private readonly ILogger<MDFeService> _logger;
        private readonly IMemoryCache _cache;

        public MDFeService(MDFeContext context, ILogger<MDFeService> logger, IMemoryCache cache)
        {
            _context = context;
            _logger = logger;
            _cache = cache;
        }

        public async Task<MDFe> CreateMDFeAsync(MDFe mdfe)
        {
            // Gerar número sequencial automático para o emitente
            if (mdfe.NumeroMdfe == 0)
            {
                mdfe.NumeroMdfe = await GetNextNumberAsync(mdfe.EmitenteId, 1);
            }
            
            // Fixar série em 1
            mdfe.Serie = 1;
            
            // Definir data/hora de emissão automaticamente se não informada
            if (mdfe.DataEmissao == DateTime.MinValue)
            {
                mdfe.DataEmissao = DateTime.Now;
            }
            
            mdfe.DataCriacao = DateTime.Now;
            mdfe.StatusSefaz = "RASCUNHO";
            mdfe.Ativo = true;

            _context.MDFes.Add(mdfe);
            await _context.SaveChangesAsync();

            return mdfe;
        }

        public async Task<MDFe?> GetMDFeByIdAsync(int id)
        {
            return await _context.MDFes
                .Include(m => m.Emitente)
                .Include(m => m.Veiculo)
                .Include(m => m.Condutor)
                .Include(m => m.Reboques)
                .FirstOrDefaultAsync(m => m.Id == id && m.Ativo);
        }

        public async Task<IEnumerable<MDFe>> GetMDFesByEmitenteAsync(int emitenteId)
        {
            return await _context.MDFes
                .Include(m => m.Emitente)
                .Include(m => m.Veiculo)
                .Include(m => m.Condutor)
                .Where(m => m.EmitenteId == emitenteId && m.Ativo)
                .OrderByDescending(m => m.DataEmissao)
                .ToListAsync();
        }

        public async Task<MDFe> UpdateMDFeAsync(MDFe mdfe)
        {
            mdfe.DataUltimaAlteracao = DateTime.Now;
            _context.Entry(mdfe).State = EntityState.Modified;
            await _context.SaveChangesAsync();
            return mdfe;
        }

        public async Task<bool> DeleteMDFeAsync(int id)
        {
            var mdfe = await _context.MDFes.FindAsync(id);
            if (mdfe == null || !mdfe.Ativo)
                return false;

            mdfe.Ativo = false;
            mdfe.DataUltimaAlteracao = DateTime.Now;
            await _context.SaveChangesAsync();
            return true;
        }

        public async Task<int> GetNextNumberAsync(int emitenteId, int serie)
        {
            var ultimoNumero = await _context.MDFes
                .Where(m => m.EmitenteId == emitenteId && m.Serie == serie)
                .MaxAsync(m => (int?)m.NumeroMdfe) ?? 0;

            return ultimoNumero + 1;
        }

        public async Task<bool> ValidateMDFeAsync(MDFe mdfe)
        {
            // Validações básicas
            if (mdfe.EmitenteId <= 0) return false;
            if (mdfe.VeiculoId <= 0) return false;
            if (mdfe.CondutorId <= 0) return false;
            if (string.IsNullOrEmpty(mdfe.UfInicio)) return false;
            if (string.IsNullOrEmpty(mdfe.UfFim)) return false;

            // Validar se emitente existe
            var emitenteExists = await _context.Emitentes
                .AnyAsync(e => e.Id == mdfe.EmitenteId && e.Ativo);
            if (!emitenteExists) return false;

            // Validar se veículo existe
            var veiculoExists = await _context.Veiculos
                .AnyAsync(v => v.Id == mdfe.VeiculoId && v.Ativo);
            if (!veiculoExists) return false;

            // Validar se condutor existe
            var condutorExists = await _context.Condutores
                .AnyAsync(c => c.Id == mdfe.CondutorId && c.Ativo);
            if (!condutorExists) return false;

            return true;
        }

        public Task<string> SalvarRascunhoAsync(Controllers.MDFeData mdfeData)
        {
            var rascunhoId = Guid.NewGuid().ToString();
            var cacheKey = $"rascunho_{rascunhoId}";
            
            // Armazenar rascunho no cache com expiração de 24 horas
            var cacheOptions = new MemoryCacheEntryOptions
            {
                AbsoluteExpirationRelativeToNow = TimeSpan.FromHours(24),
                Priority = CacheItemPriority.Normal
            };
            
            _cache.Set(cacheKey, mdfeData, cacheOptions);
            
            _logger.LogInformation($"Rascunho salvo no cache: {rascunhoId}");
            return Task.FromResult(rascunhoId);
        }

        public Task<Controllers.MDFeData?> CarregarRascunhoAsync(string id)
        {
            try
            {
                var cacheKey = $"rascunho_{id}";
                
                if (_cache.TryGetValue(cacheKey, out Controllers.MDFeData? mdfeData))
                {
                    _logger.LogInformation($"Rascunho carregado do cache: {id}");
                    return Task.FromResult<Controllers.MDFeData?>(mdfeData);
                }

                _logger.LogWarning($"Rascunho não encontrado no cache: {id}");
                return Task.FromResult<Controllers.MDFeData?>(null);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"Erro ao carregar rascunho: {id}");
                return Task.FromResult<Controllers.MDFeData?>(null);
            }
        }
    }
}