using MDFeApi.Models;

namespace MDFeApi.Interfaces
{
    public interface IMDFeService
    {
        // Operações CRUD
        Task<MDFe> CreateAsync(MDFe mdfe);
        Task<MDFe?> GetByIdAsync(int id);
        Task<IEnumerable<MDFe>> GetByEmitenteAsync(int emitenteId);
        Task<MDFe> UpdateAsync(MDFe mdfe);
        Task<bool> DeleteAsync(int id);

        // Operações de Negócio
        Task<int> ObterProximoNumeroAsync(int emitenteId, int serie);
        Task<(bool valido, List<string> erros)> ValidarAsync(MDFe mdfe);

        // Métodos SEFAZ
        Task<string> GerarXmlAsync(int mdfeId);
        Task<object> TransmitirAsync(int mdfeId);
        Task<object> ConsultarProtocoloAsync(int mdfeId, string protocolo);
        Task<object> ConsultarMDFeAsync(int mdfeId);
        Task<object> CancelarAsync(int mdfeId, string justificativa);
        Task<object> EncerrarAsync(int mdfeId, string? codigoMunicipioEncerramento = null, DateTime? dataEncerramento = null);
        Task<object> ConsultarStatusServicoAsync(string uf);
        Task<object> ConsultarPorChaveAsync(string chave);
        Task<object> ConsultarReciboAsync(string recibo);
        Task<byte[]> GerarPDFAsync(int mdfeId);
    }
}