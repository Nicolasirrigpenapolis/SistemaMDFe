using Microsoft.EntityFrameworkCore;
using MDFeApi.Data;
using MDFeApi.Models;
using MDFeApi.DTOs;
using MDFeApi.Interfaces;

namespace MDFeApi.Services
{
    /// <summary>
    /// Serviço de negócio MDFe - lógica de negócio e persistência
    /// Responsabilidades:
    /// - CRUD de MDFe
    /// - Validações de negócio
    /// - Numeração sequencial
    /// - Workflow de status
    /// </summary>
    public class MDFeService : IMDFeService
    {
        private readonly MDFeContext _context;
        private readonly ILogger<MDFeService> _logger;

        public MDFeService(MDFeContext context, ILogger<MDFeService> logger)
        {
            _context = context;
            _logger = logger;
        }

        #region Operações CRUD

        public async Task<MDFe> CreateAsync(MDFe mdfe)
        {
            try
            {
                // Gerar número sequencial se não informado
                if (mdfe.NumeroMdfe == 0)
                {
                    mdfe.NumeroMdfe = await ObterProximoNumeroAsync(mdfe.EmitenteId, mdfe.Serie);
                }

                // Status inicial
                if (string.IsNullOrEmpty(mdfe.StatusSefaz))
                {
                    mdfe.StatusSefaz = "Rascunho";
                }

                mdfe.DataEmissao = DateTime.Now;

                _context.MDFes.Add(mdfe);
                await _context.SaveChangesAsync();

                _logger.LogInformation("MDFe {Id} criado - Número: {Numero}", mdfe.Id, mdfe.NumeroMdfe);
                return mdfe;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao criar MDFe");
                throw;
            }
        }

        public async Task<MDFe?> GetByIdAsync(int id)
        {
            return await _context.MDFes
                .Include(m => m.Emitente)
                .Include(m => m.Veiculo)
                .Include(m => m.Condutor)
                .Include(m => m.Contratante)
                .Include(m => m.Reboques)
                .Include(m => m.Seguradora)
                .FirstOrDefaultAsync(m => m.Id == id && m.Ativo);
        }

        public async Task<IEnumerable<MDFe>> GetByEmitenteAsync(int emitenteId)
        {
            return await _context.MDFes
                .Include(m => m.Emitente)
                .Where(m => m.EmitenteId == emitenteId && m.Ativo)
                .OrderByDescending(m => m.DataEmissao)
                .ToListAsync();
        }

        public async Task<MDFe> UpdateAsync(MDFe mdfe)
        {
            var existing = await _context.MDFes.FindAsync(mdfe.Id);
            if (existing == null)
                throw new InvalidOperationException($"MDFe {mdfe.Id} não encontrado");

            if (existing.StatusSefaz != "Rascunho")
                throw new InvalidOperationException("Apenas MDFe em rascunho podem ser editados");

            _context.Entry(existing).CurrentValues.SetValues(mdfe);
            await _context.SaveChangesAsync();
            return existing;
        }

        public async Task<bool> DeleteAsync(int id)
        {
            var mdfe = await _context.MDFes.FindAsync(id);
            if (mdfe == null) return false;

            if (mdfe.StatusSefaz != "Rascunho")
                throw new InvalidOperationException("Apenas MDFe em rascunho podem ser excluídos");

            mdfe.Ativo = false;
            await _context.SaveChangesAsync();
            return true;
        }

        #endregion

        #region Operações de Negócio

        public async Task<int> ObterProximoNumeroAsync(int emitenteId, int serie)
        {
            var ultimoNumero = await _context.MDFes
                .Where(m => m.EmitenteId == emitenteId && m.Serie == serie)
                .MaxAsync(m => (int?)m.NumeroMdfe) ?? 0;

            return ultimoNumero + 1;
        }

        public async Task<(bool valido, List<string> erros)> ValidarAsync(MDFe mdfe)
        {
            var erros = new List<string>();

            // Validações básicas - MANTENDO todos os campos xSeg, etc como estão
            if (mdfe.PesoBrutoTotal <= 0)
                erros.Add("Peso bruto total deve ser maior que zero");

            if (string.IsNullOrEmpty(mdfe.UfIni))
                erros.Add("UF de início é obrigatória");

            return (!erros.Any(), erros);
        }

        #endregion

        #region Métodos SEFAZ

        public async Task<string> GerarXmlAsync(int mdfeId)
        {
            // Placeholder - implementar geração de XML
            return "<xml>Placeholder</xml>";
        }

        public async Task<object> TransmitirAsync(int mdfeId)
        {
            // Placeholder - implementar transmissão
            return new { message = "Transmitido com sucesso", protocolo = "123456" };
        }

        public async Task<object> ConsultarProtocoloAsync(int mdfeId, string protocolo)
        {
            // Placeholder - implementar consulta de protocolo
            return new { message = "Protocolo consultado", status = "Autorizado" };
        }

        public async Task<object> ConsultarMDFeAsync(int mdfeId)
        {
            // Placeholder - implementar consulta MDFe
            return new { message = "MDFe consultado", status = "Autorizado" };
        }

        public async Task<object> CancelarAsync(int mdfeId, string justificativa)
        {
            // Placeholder - implementar cancelamento
            return new { message = "MDFe cancelado", protocolo = "CANC123" };
        }

        public async Task<object> EncerrarAsync(int mdfeId, string protocolo)
        {
            // Placeholder - implementar encerramento
            return new { message = "MDFe encerrado", protocolo = "ENC123" };
        }

        public async Task<object> ConsultarStatusServicoAsync(string uf)
        {
            // Placeholder - implementar consulta status serviço
            return new { message = "Serviço operacional", status = "1" };
        }

        public async Task<object> ConsultarPorChaveAsync(string chave)
        {
            // Placeholder - implementar consulta por chave
            return new { message = "MDFe encontrado", status = "Autorizado" };
        }

        public async Task<object> ConsultarReciboAsync(string recibo)
        {
            // Placeholder - implementar consulta recibo
            return new { message = "Recibo processado", status = "Processado" };
        }

        #endregion
    }
}