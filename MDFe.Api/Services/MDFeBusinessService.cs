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

            _context.MDFes.Remove(mdfe);
            await _context.SaveChangesAsync();
            return true;
        }

        public async Task<int> GetProximoNumeroAsync(string? emitenteCnpj = null)
        {
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

            var mdfe = new MDFe
            {
                NumeroMdfe = proximoNumero,
                Serie = emitente.SerieInicial,
                UfIni = mdfeDto.UfIni ?? emitente.Uf,
                UfFim = mdfeDto.UfFim ?? emitente.Uf,
                DataEmissao = mdfeDto.DataEmissao ?? DateTime.Now,
                DataInicioViagem = mdfeDto.DataInicioViagem ?? DateTime.Now,
                Modal = emitente.ModalTransporte,
                TipoTransportador = emitente.TipoTransportador,
                UnidadeMedida = "01", // Quilograma (padrão do sistema)
                EmitenteId = mdfeDto.EmitenteId,
                CondutorId = mdfeDto.CondutorId,
                VeiculoId = mdfeDto.VeiculoId,
                ValorTotal = mdfeDto.ValorTotal ?? 0,
                PesoBrutoTotal = mdfeDto.PesoBrutoTotal ?? 0,
                StatusSefaz = "RASCUNHO",
                DataCriacao = DateTime.Now,
                // Relacionamentos para permitir snapshots
                Emitente = emitente,
                Condutor = condutor,
                Veiculo = veiculo
            };

            // ✅ Criar snapshots usando método do modelo
            mdfe.CriarSnapshotsEntidades();

            // ✅ Gerar chave de acesso usando método do modelo
            mdfe.GerarChaveAcesso();

            _context.MDFes.Add(mdfe);
            await _context.SaveChangesAsync();

            _logger.LogInformation("MDFe {NumeroMdfe} criado com sucesso para emitente {EmitenteId}. Chave: {ChaveAcesso}",
                mdfe.NumeroMdfe, mdfe.EmitenteId, mdfe.ChaveAcesso);

            return mdfe;
        }

        public async Task<MDFe?> UpdateMDFeAsync(int id, MDFeCreateDto mdfeDto)
        {
            var mdfe = await _context.MDFes.FindAsync(id);
            if (mdfe == null) return null;

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
            mdfe.UfIni = mdfeDto.UfIni;
            mdfe.UfFim = mdfeDto.UfFim;
            mdfe.DataEmissao = mdfeDto.DataEmissao ?? mdfe.DataEmissao;
            mdfe.DataInicioViagem = mdfeDto.DataInicioViagem;
            mdfe.ValorTotal = mdfeDto.ValorTotal ?? mdfe.ValorTotal;
            mdfe.PesoBrutoTotal = mdfeDto.PesoBrutoTotal ?? mdfe.PesoBrutoTotal;
            mdfe.InfoAdicional = mdfeDto.Observacoes;

            // Atribuir entidades relacionadas
            mdfe.Emitente = emitente;
            mdfe.Condutor = condutor;
            mdfe.Veiculo = veiculo;

            // Criar snapshots das entidades relacionadas
            mdfe.CriarSnapshotsEntidades();

            await _context.SaveChangesAsync();

            _logger.LogInformation("MDFe {NumeroMdfe} atualizado com sucesso", mdfe.NumeroMdfe);

            return mdfe;
        }
    }
}