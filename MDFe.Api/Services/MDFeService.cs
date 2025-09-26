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

            // 🔒 SNAPSHOT FISCAL: Capturar dados dos cadastros no momento da criação
            await PreencherSnapshotFiscalAsync(mdfe);

            mdfe.DataCriacao = DateTime.Now;
            mdfe.StatusSefaz = "RASCUNHO";
            mdfe.Ativo = true;

            _context.MDFes.Add(mdfe);
            await _context.SaveChangesAsync();

            return mdfe;
        }

        /// <summary>
        /// Preenche automaticamente os campos de snapshot fiscal com dados atuais dos cadastros
        /// </summary>
        private async Task PreencherSnapshotFiscalAsync(MDFe mdfe)
        {
            // Snapshot do Emitente
            var emitente = await _context.Emitentes.FindAsync(mdfe.EmitenteId);
            if (emitente != null)
            {
                mdfe.EmitenteCnpj = emitente.Cnpj ?? string.Empty;
                mdfe.EmitenteCpf = emitente.Cpf;
                mdfe.EmitenteIe = emitente.Ie;
                mdfe.EmitenteRazaoSocial = emitente.RazaoSocial;
                mdfe.EmitenteNomeFantasia = emitente.NomeFantasia;
                mdfe.EmitenteEndereco = emitente.Endereco;
                mdfe.EmitenteNumero = emitente.Numero;
                mdfe.EmitenteComplemento = emitente.Complemento;
                mdfe.EmitenteBairro = emitente.Bairro;
                mdfe.EmitenteCodMunicipio = emitente.CodMunicipio;
                mdfe.EmitenteMunicipio = emitente.Municipio;
                mdfe.EmitenteCep = emitente.Cep;
                mdfe.EmitenteUf = emitente.Uf;
                mdfe.EmitenteTipoEmitente = emitente.TipoEmitente;
                mdfe.EmitenteRntrc = emitente.Rntrc;

                // ✅ CAMPOS ADICIONAIS PARA XML/INI
                mdfe.Rntrc = emitente.Rntrc; // RNTRC principal do MDFe
            }

            // Snapshot do Condutor
            var condutor = await _context.Condutores.FindAsync(mdfe.CondutorId);
            if (condutor != null)
            {
                mdfe.CondutorNome = condutor.Nome;
                mdfe.CondutorCpf = condutor.Cpf;
            }

            // Snapshot do Veículo
            var veiculo = await _context.Veiculos.FindAsync(mdfe.VeiculoId);
            if (veiculo != null)
            {
                mdfe.VeiculoPlaca = veiculo.Placa;
                mdfe.VeiculoTara = veiculo.Tara;
                mdfe.VeiculoTipoRodado = veiculo.TipoRodado;
                mdfe.VeiculoTipoCarroceria = veiculo.TipoCarroceria;
                mdfe.VeiculoUf = veiculo.Uf;
                mdfe.VeiculoMarca = veiculo.Marca;
            }

            // Snapshot do Contratante (se informado)
            if (mdfe.ContratanteId.HasValue)
            {
                var contratante = await _context.Contratantes.FindAsync(mdfe.ContratanteId.Value);
                if (contratante != null)
                {
                    mdfe.ContratanteCnpj = contratante.Cnpj;
                    mdfe.ContratanteCpf = contratante.Cpf;
                    mdfe.ContratanteRazaoSocial = contratante.RazaoSocial;
                    mdfe.ContratanteNomeFantasia = contratante.NomeFantasia;
                    mdfe.ContratanteEndereco = contratante.Endereco;
                    mdfe.ContratanteNumero = contratante.Numero;
                    mdfe.ContratanteComplemento = contratante.Complemento;
                    mdfe.ContratanteBairro = contratante.Bairro;
                    mdfe.ContratanteCodMunicipio = contratante.CodMunicipio;
                    mdfe.ContratanteMunicipio = contratante.Municipio;
                    mdfe.ContratanteCep = contratante.Cep;
                    mdfe.ContratanteUf = contratante.Uf;
                }
            }

            // Snapshot da Seguradora (se informado)
            if (mdfe.SeguradoraId.HasValue)
            {
                var seguradora = await _context.Seguradoras.FindAsync(mdfe.SeguradoraId.Value);
                if (seguradora != null)
                {
                    mdfe.SeguradoraCnpj = seguradora.Cnpj;
                    mdfe.SeguradoraRazaoSocial = seguradora.RazaoSocial;
                    mdfe.SeguradoraNomeFantasia = seguradora.NomeFantasia; // ✅ CAMPO ADICIONADO

                    // ✅ CAMPOS ADICIONAIS:
                    mdfe.NumeroApoliceSeguro = seguradora.Apolice;
                }
            }

            _logger.LogInformation($"Snapshot fiscal criado para MDFe {mdfe.NumeroMdfe}");
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
            // ❌ PROTEÇÃO FISCAL: MDFe transmitido é IMUTÁVEL
            var mdfeExistente = await _context.MDFes.FindAsync(mdfe.Id);
            if (mdfeExistente == null)
            {
                throw new InvalidOperationException("MDFe não encontrado.");
            }

            if (mdfeExistente.Transmitido ||
                mdfeExistente.StatusSefaz != "RASCUNHO")
            {
                throw new InvalidOperationException(
                    "MDFe transmitido não pode ser alterado. Documento fiscal é imutável por exigência da SEFAZ."
                );
            }

            // ✅ Permitir alteração apenas se RASCUNHO
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

            // ❌ PROTEÇÃO FISCAL: MDFe transmitido NÃO pode ser excluído
            if (mdfe.Transmitido || mdfe.StatusSefaz != "RASCUNHO")
            {
                throw new InvalidOperationException(
                    "MDFe transmitido não pode ser excluído. Use cancelamento via SEFAZ."
                );
            }

            // ✅ Permitir exclusão apenas se RASCUNHO
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

        public async Task<string> SalvarRascunhoAsync(Controllers.MDFeData mdfeData)
        {
            // ✅ CORREÇÃO: Salvar no banco de dados ao invés de apenas cache
            try
            {
                var mdfe = new MDFe
                {
                    StatusSefaz = "RASCUNHO",
                    DataCriacao = DateTime.Now,
                    DataUltimaAlteracao = DateTime.Now,
                    UsuarioCriacao = "wizard",
                    UsuarioUltimaAlteracao = "wizard",
                    DadosOriginaisJson = System.Text.Json.JsonSerializer.Serialize(mdfeData, new System.Text.Json.JsonSerializerOptions
                    {
                        WriteIndented = true,
                        PropertyNamingPolicy = System.Text.Json.JsonNamingPolicy.CamelCase
                    })
                };

                // Salvar dados básicos do MDFe se disponíveis
                if (mdfeData.ide != null)
                {
                    if (!string.IsNullOrEmpty(mdfeData.ide.serie) && int.TryParse(mdfeData.ide.serie, out var serie))
                        mdfe.Serie = serie;

                    if (!string.IsNullOrEmpty(mdfeData.ide.UFIni))
                        mdfe.UfInicio = mdfeData.ide.UFIni;

                    if (!string.IsNullOrEmpty(mdfeData.ide.UFFim))
                        mdfe.UfFim = mdfeData.ide.UFFim;
                }

                if (mdfeData.emit != null)
                {
                    if (!string.IsNullOrEmpty(mdfeData.emit.CNPJ))
                        mdfe.EmitenteCnpj = mdfeData.emit.CNPJ;

                    if (!string.IsNullOrEmpty(mdfeData.emit.xNome))
                        mdfe.EmitenteRazaoSocial = mdfeData.emit.xNome;

                    if (!string.IsNullOrEmpty(mdfeData.emit.xFant))
                        mdfe.EmitenteNomeFantasia = mdfeData.emit.xFant;
                }

                if (mdfeData.tot != null)
                {
                    if (decimal.TryParse(mdfeData.tot.vCarga, out var vCarga))
                        mdfe.ValorCarga = vCarga;

                    if (decimal.TryParse(mdfeData.tot.qCarga, out var qCarga))
                        mdfe.QuantidadeCarga = qCarga;
                }

                // Definir EmitenteId padrão se não existir
                if (mdfe.EmitenteId == 0)
                {
                    var primeiroEmitente = await _context.Emitentes.FirstOrDefaultAsync();
                    if (primeiroEmitente != null)
                        mdfe.EmitenteId = primeiroEmitente.Id;
                }

                // Salvar no banco de dados
                _context.MDFes.Add(mdfe);
                await _context.SaveChangesAsync();

                _logger.LogInformation($"Rascunho salvo no banco de dados: ID {mdfe.Id}");

                // Manter também no cache para acesso rápido
                var cacheKey = $"rascunho_{mdfe.Id}";
                var cacheOptions = new MemoryCacheEntryOptions
                {
                    AbsoluteExpirationRelativeToNow = TimeSpan.FromHours(24),
                    Priority = CacheItemPriority.Normal
                };
                _cache.Set(cacheKey, mdfeData, cacheOptions);

                return mdfe.Id.ToString();
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao salvar rascunho no banco de dados");

                // Fallback para cache se banco falhar
                var rascunhoId = Guid.NewGuid().ToString();
                var cacheKey = $"rascunho_fallback_{rascunhoId}";
                var cacheOptions = new MemoryCacheEntryOptions
                {
                    AbsoluteExpirationRelativeToNow = TimeSpan.FromHours(24),
                    Priority = CacheItemPriority.Normal
                };
                _cache.Set(cacheKey, mdfeData, cacheOptions);

                _logger.LogWarning($"Rascunho salvo apenas no cache (fallback): {rascunhoId}");
                return rascunhoId;
            }
        }

        public async Task<Controllers.MDFeData?> CarregarRascunhoAsync(string id)
        {
            try
            {
                // ✅ CORREÇÃO: Carregar do banco de dados primeiro
                if (int.TryParse(id, out var rascunhoId))
                {
                    var mdfe = await _context.MDFes
                        .FirstOrDefaultAsync(m => m.Id == rascunhoId && m.StatusSefaz == "RASCUNHO");

                    if (mdfe != null && !string.IsNullOrEmpty(mdfe.DadosOriginaisJson))
                    {
                        var mdfeData = System.Text.Json.JsonSerializer.Deserialize<Controllers.MDFeData>(
                            mdfe.DadosOriginaisJson,
                            new System.Text.Json.JsonSerializerOptions
                            {
                                PropertyNameCaseInsensitive = true,
                                PropertyNamingPolicy = System.Text.Json.JsonNamingPolicy.CamelCase
                            });

                        _logger.LogInformation($"Rascunho carregado do banco de dados: {id}");
                        return mdfeData;
                    }
                }

                // Fallback para cache se não encontrar no banco ou ID inválido
                var cacheKey = $"rascunho_{id}";
                if (_cache.TryGetValue(cacheKey, out Controllers.MDFeData? cachedData))
                {
                    _logger.LogInformation($"Rascunho carregado do cache (fallback): {id}");
                    return cachedData;
                }

                // Tentar buscar cache com fallback prefix
                var fallbackCacheKey = $"rascunho_fallback_{id}";
                if (_cache.TryGetValue(fallbackCacheKey, out Controllers.MDFeData? fallbackData))
                {
                    _logger.LogInformation($"Rascunho carregado do cache fallback: {id}");
                    return fallbackData;
                }

                _logger.LogWarning($"Rascunho não encontrado: {id}");
                return null;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"Erro ao carregar rascunho: {id}");
                return null;
            }
        }
    }
}