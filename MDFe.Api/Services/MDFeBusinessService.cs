using Microsoft.EntityFrameworkCore;
using MDFeApi.Data;
using MDFeApi.Models;
using MDFeApi.DTOs;
using MDFeApi.Utils;
using MDFeApi.Interfaces;

namespace MDFeApi.Services
{
    public class MDFeBusinessService : IMDFeBusinessService
    {
        private readonly MDFeContext _context;
        private readonly ILogger<MDFeBusinessService> _logger;

        public MDFeBusinessService(MDFeContext context, ILogger<MDFeBusinessService> logger)
        {
            _context = context;
            _logger = logger;
        }

        public async Task<PagedResult<MDFeResponseDto>> GetMDFesAsync(int? emitenteId, int pagina, int tamanhoPagina)
        {
            var query = _context.MDFes
                .Include(m => m.Emitente)
                .Include(m => m.Veiculo)
                .Include(m => m.Condutor)
                .AsQueryable();

            if (emitenteId.HasValue)
            {
                query = query.Where(m => m.EmitenteId == emitenteId.Value);
            }

            var totalItens = await query.CountAsync();

            var itens = await query
                .OrderByDescending(m => m.DataEmissao)
                .Skip((pagina - 1) * tamanhoPagina)
                .Take(tamanhoPagina)
                .Select(m => new MDFeResponseDto
                {
                    Id = m.Id,
                    Numero = m.NumeroMdfe,
                    Serie = m.Serie.ToString(),
                    DataEmissao = m.DataEmissao,
                    DataInicioViagem = m.DataInicioViagem ?? DateTime.Now,
                    UfIni = m.UfIni ?? "",
                    UfFim = m.UfFim ?? "",
                    MunicipioIni = "",
                    MunicipioFim = "",
                    Status = m.StatusSefaz ?? "",
                    Chave = m.ChaveAcesso ?? "",
                    ValorTotal = m.ValorTotal,
                    PesoBrutoTotal = m.PesoBrutoTotal,
                    Observacoes = m.InfoAdicional,
                    // Usar snapshots das entidades relacionadas
                    EmitenteRazaoSocial = m.EmitenteRazaoSocial ?? (m.Emitente != null ? m.Emitente.RazaoSocial : ""),
                    VeiculoPlaca = m.VeiculoPlaca ?? (m.Veiculo != null ? m.Veiculo.Placa : ""),
                    CondutorNome = m.CondutorNome ?? (m.Condutor != null ? m.Condutor.Nome : "")
                })
                .ToListAsync();

            return new PagedResult<MDFeResponseDto>
            {
                Items = itens,
                TotalItems = totalItens,
                Page = pagina,
                PageSize = tamanhoPagina,
                TotalPages = (int)Math.Ceiling((double)totalItens / tamanhoPagina),
                HasNextPage = pagina * tamanhoPagina < totalItens,
                HasPreviousPage = pagina > 1
            };
        }

        public async Task<MDFe?> GetMDFeByIdAsync(int id)
        {
            return await _context.MDFes
                .Include(m => m.Emitente)
                .Include(m => m.Veiculo)
                .Include(m => m.Condutor)
                .Include(m => m.LocaisCarregamento)
                .Include(m => m.LocaisDescarregamento)
                .FirstOrDefaultAsync(m => m.Id == id);
        }

        public async Task<bool> DeleteMDFeAsync(int id)
        {
            var mdfe = await _context.MDFes.FindAsync(id);
            if (mdfe == null)
                return false;

            // ✅ VALIDAÇÃO: Apenas rascunhos podem ser excluídos
            if (mdfe.StatusSefaz != "RASCUNHO")
            {
                _logger.LogWarning("Tentativa de excluir MDFe {Id} com status {Status}", id, mdfe.StatusSefaz);
                throw new InvalidOperationException($"Não é possível excluir MDFe com status '{mdfe.StatusSefaz}'. Apenas rascunhos podem ser excluídos.");
            }

            _context.MDFes.Remove(mdfe);
            await _context.SaveChangesAsync();

            _logger.LogInformation("MDFe {NumeroMdfe} (ID: {Id}) excluído com sucesso", mdfe.NumeroMdfe, id);
            return true;
        }

        public async Task<int> GetProximoNumeroAsync(string? emitenteCnpj = null)
        {
            const int NUMERO_INICIAL = 650;

            var query = _context.MDFes.AsQueryable();

            if (!string.IsNullOrEmpty(emitenteCnpj))
            {
                query = query.Include(m => m.Emitente)
                    .Where(m => m.Emitente != null && m.Emitente.Cnpj == emitenteCnpj);
            }

            var ultimoNumero = await query
                .OrderByDescending(m => m.NumeroMdfe)
                .Select(m => m.NumeroMdfe)
                .FirstOrDefaultAsync();

            // Se não houver MDFes ainda, começar do número inicial (650)
            if (ultimoNumero == 0)
            {
                return NUMERO_INICIAL;
            }

            return ultimoNumero + 1;
        }

        public async Task<MDFe> CreateMDFeAsync(MDFeCreateDto mdfeDto)
        {
            // Buscar entidades relacionadas
            var emitente = await _context.Emitentes.FindAsync(mdfeDto.EmitenteId);
            if (emitente == null) throw new ArgumentException("Emitente não encontrado");

            Condutor? condutor = null;
            if (mdfeDto.CondutorId.HasValue)
            {
                condutor = await _context.Condutores.FindAsync(mdfeDto.CondutorId.Value);
            }

            Veiculo? veiculo = null;
            if (mdfeDto.VeiculoId.HasValue)
            {
                veiculo = await _context.Veiculos.FindAsync(mdfeDto.VeiculoId.Value);
            }

            // ✅ Usar método estático do modelo para gerar próximo número
            var mdfesExistentes = await _context.MDFes
                .Where(m => m.EmitenteId == mdfeDto.EmitenteId)
                .ToListAsync();
            var proximoNumero = MDFe.GerarProximoNumero(mdfesExistentes, mdfeDto.EmitenteId);

            // 🔍 LOG: Verificar dados recebidos
            _logger.LogInformation("🔍 LOCALIDADES RECEBIDAS - Carregamento: {Carregamento}, Descarregamento: {Descarregamento}",
                mdfeDto.LocalidadesCarregamento != null ? System.Text.Json.JsonSerializer.Serialize(mdfeDto.LocalidadesCarregamento) : "NULL",
                mdfeDto.LocalidadesDescarregamento != null ? System.Text.Json.JsonSerializer.Serialize(mdfeDto.LocalidadesDescarregamento) : "NULL");

            // ✅ CALCULAR AUTOMATICAMENTE UF/MUNICÍPIO INICIAL E FINAL DAS LOCALIDADES
            var primeiroCarregamento = mdfeDto.LocalidadesCarregamento?.FirstOrDefault();
            var primeiroDescarregamento = mdfeDto.LocalidadesDescarregamento?.FirstOrDefault();

            var mdfe = new MDFe
            {
                NumeroMdfe = proximoNumero,
                Serie = emitente.SerieInicial > 0 ? emitente.SerieInicial : 1, // Garantir série mínima 1
                UfIni = primeiroCarregamento?.UF ?? emitente.Uf,
                UfFim = primeiroDescarregamento?.UF ?? emitente.Uf,
                MunicipioIni = primeiroCarregamento?.Municipio,
                MunicipioFim = primeiroDescarregamento?.Municipio,
                DataEmissao = mdfeDto.DataEmissao ?? DateTime.Now,
                DataInicioViagem = mdfeDto.DataInicioViagem ?? DateTime.Now,
                Modal = emitente.ModalTransporte,
                TipoTransportador = emitente.TipoTransportador,
                UnidadeMedida = "01", // Quilograma (padrão do sistema)
                EmitenteId = mdfeDto.EmitenteId,
                CondutorId = mdfeDto.CondutorId,
                VeiculoId = mdfeDto.VeiculoId,
                ContratanteId = mdfeDto.ContratanteId,
                SeguradoraId = mdfeDto.SeguradoraId,
                ValorTotal = mdfeDto.ValorTotal ?? 0,
                PesoBrutoTotal = mdfeDto.PesoBrutoTotal ?? 0,
                InfoAdicional = mdfeDto.Observacoes,
                StatusSefaz = "RASCUNHO",
                DataCriacao = DateTime.Now,

                // ✅ SALVAR DADOS JSON
                LocalidadesCarregamentoJson = mdfeDto.LocalidadesCarregamento != null && mdfeDto.LocalidadesCarregamento.Any()
                    ? System.Text.Json.JsonSerializer.Serialize(mdfeDto.LocalidadesCarregamento)
                    : null,
                LocalidadesDescarregamentoJson = mdfeDto.LocalidadesDescarregamento != null && mdfeDto.LocalidadesDescarregamento.Any()
                    ? System.Text.Json.JsonSerializer.Serialize(mdfeDto.LocalidadesDescarregamento)
                    : null,
                RotaPercursoJson = mdfeDto.RotaPercurso != null && mdfeDto.RotaPercurso.Any()
                    ? System.Text.Json.JsonSerializer.Serialize(mdfeDto.RotaPercurso)
                    : null,
                DocumentosCTeJson = mdfeDto.DocumentosCTe != null && mdfeDto.DocumentosCTe.Any()
                    ? System.Text.Json.JsonSerializer.Serialize(mdfeDto.DocumentosCTe)
                    : null,
                DocumentosNFeJson = mdfeDto.DocumentosNFe != null && mdfeDto.DocumentosNFe.Any()
                    ? System.Text.Json.JsonSerializer.Serialize(mdfeDto.DocumentosNFe)
                    : null,

                // Relacionamentos para permitir snapshots
                Emitente = emitente,
                Condutor = condutor,
                Veiculo = veiculo
            };

            // ✅ Criar snapshots usando método do modelo
            mdfe.CriarSnapshotsEntidades();

            // ✅ Gerar chave de acesso usando método do modelo
            mdfe.GerarChaveAcesso();

            // 🔍 LOG: Verificar se JSON está sendo salvo
            _logger.LogInformation("📦 Salvando MDFe com localidades: Carregamento={CarregamentoJson}, Descarregamento={DescarregamentoJson}",
                mdfe.LocalidadesCarregamentoJson ?? "NULL",
                mdfe.LocalidadesDescarregamentoJson ?? "NULL");

            _context.MDFes.Add(mdfe);
            await _context.SaveChangesAsync();

            // ✅ PERSISTIR REBOQUES (relacionamento N:N)
            if (mdfeDto.ReboquesIds != null && mdfeDto.ReboquesIds.Any())
            {
                var ordemReboque = 1;
                foreach (var reboqueId in mdfeDto.ReboquesIds)
                {
                    var mdfeReboque = new MDFeReboque
                    {
                        MDFeId = mdfe.Id,
                        ReboqueId = reboqueId,
                        Ordem = ordemReboque++
                    };
                    _context.Set<MDFeReboque>().Add(mdfeReboque);
                }
                await _context.SaveChangesAsync();
            }

            _logger.LogInformation("MDFe {NumeroMdfe} criado com sucesso para emitente {EmitenteId}. Chave: {ChaveAcesso}",
                mdfe.NumeroMdfe, mdfe.EmitenteId, mdfe.ChaveAcesso);

            return mdfe;
        }

        public async Task<MDFe?> UpdateMDFeAsync(int id, MDFeCreateDto mdfeDto)
        {
            var mdfe = await _context.MDFes.FindAsync(id);
            if (mdfe == null) return null;

            // ✅ VALIDAÇÃO: Apenas rascunhos podem ser editados
            if (mdfe.StatusSefaz != "RASCUNHO")
            {
                _logger.LogWarning("Tentativa de editar MDFe {Id} com status {Status}", id, mdfe.StatusSefaz);
                throw new InvalidOperationException($"Não é possível editar MDFe com status '{mdfe.StatusSefaz}'. Apenas rascunhos podem ser editados.");
            }

            // Buscar entidades relacionadas
            var emitente = await _context.Emitentes.FindAsync(mdfeDto.EmitenteId);
            if (emitente == null) throw new ArgumentException("Emitente não encontrado");

            Condutor? condutor = null;
            if (mdfeDto.CondutorId.HasValue)
            {
                condutor = await _context.Condutores.FindAsync(mdfeDto.CondutorId.Value);
            }

            Veiculo? veiculo = null;
            if (mdfeDto.VeiculoId.HasValue)
            {
                veiculo = await _context.Veiculos.FindAsync(mdfeDto.VeiculoId.Value);
            }

            // Atualizar dados do MDFe
            mdfe.EmitenteId = mdfeDto.EmitenteId;
            mdfe.CondutorId = mdfeDto.CondutorId;
            mdfe.VeiculoId = mdfeDto.VeiculoId;
            mdfe.ContratanteId = mdfeDto.ContratanteId;
            mdfe.SeguradoraId = mdfeDto.SeguradoraId;

            // Garantir valores padrão para campos obrigatórios quando vazios
            mdfe.UfIni = !string.IsNullOrWhiteSpace(mdfeDto.UfIni) ? mdfeDto.UfIni : (emitente?.Uf ?? "RS");
            mdfe.UfFim = !string.IsNullOrWhiteSpace(mdfeDto.UfFim) ? mdfeDto.UfFim : (emitente?.Uf ?? "RS");
            mdfe.MunicipioIni = mdfeDto.MunicipioIni;
            mdfe.MunicipioFim = mdfeDto.MunicipioFim;

            mdfe.DataEmissao = mdfeDto.DataEmissao ?? mdfe.DataEmissao;
            mdfe.DataInicioViagem = mdfeDto.DataInicioViagem;
            mdfe.ValorTotal = mdfeDto.ValorTotal ?? mdfe.ValorTotal;
            mdfe.PesoBrutoTotal = mdfeDto.PesoBrutoTotal ?? mdfe.PesoBrutoTotal;
            mdfe.InfoAdicional = mdfeDto.Observacoes;

            // ✅ ATUALIZAR DADOS JSON
            mdfe.LocalidadesCarregamentoJson = mdfeDto.LocalidadesCarregamento != null && mdfeDto.LocalidadesCarregamento.Any()
                ? System.Text.Json.JsonSerializer.Serialize(mdfeDto.LocalidadesCarregamento)
                : null;
            mdfe.LocalidadesDescarregamentoJson = mdfeDto.LocalidadesDescarregamento != null && mdfeDto.LocalidadesDescarregamento.Any()
                ? System.Text.Json.JsonSerializer.Serialize(mdfeDto.LocalidadesDescarregamento)
                : null;
            mdfe.RotaPercursoJson = mdfeDto.RotaPercurso != null && mdfeDto.RotaPercurso.Any()
                ? System.Text.Json.JsonSerializer.Serialize(mdfeDto.RotaPercurso)
                : null;
            mdfe.DocumentosCTeJson = mdfeDto.DocumentosCTe != null && mdfeDto.DocumentosCTe.Any()
                ? System.Text.Json.JsonSerializer.Serialize(mdfeDto.DocumentosCTe)
                : null;
            mdfe.DocumentosNFeJson = mdfeDto.DocumentosNFe != null && mdfeDto.DocumentosNFe.Any()
                ? System.Text.Json.JsonSerializer.Serialize(mdfeDto.DocumentosNFe)
                : null;

            // Atribuir entidades relacionadas
            mdfe.Emitente = emitente;
            mdfe.Condutor = condutor;
            mdfe.Veiculo = veiculo;

            // Criar snapshots das entidades relacionadas
            mdfe.CriarSnapshotsEntidades();

            // Atualizar timestamp
            mdfe.DataUltimaAlteracao = DateTime.Now;

            // ✅ ATUALIZAR REBOQUES (relacionamento N:N)
            // Remover reboques existentes
            var reboquesExistentes = _context.Set<MDFeReboque>().Where(r => r.MDFeId == id);
            _context.Set<MDFeReboque>().RemoveRange(reboquesExistentes);

            // Adicionar novos reboques
            if (mdfeDto.ReboquesIds != null && mdfeDto.ReboquesIds.Any())
            {
                var ordemReboque = 1;
                foreach (var reboqueId in mdfeDto.ReboquesIds)
                {
                    var mdfeReboque = new MDFeReboque
                    {
                        MDFeId = id,
                        ReboqueId = reboqueId,
                        Ordem = ordemReboque++
                    };
                    _context.Set<MDFeReboque>().Add(mdfeReboque);
                }
            }

            await _context.SaveChangesAsync();

            _logger.LogInformation("MDFe {NumeroMdfe} atualizado com sucesso", mdfe.NumeroMdfe);

            return mdfe;
        }
    }
}