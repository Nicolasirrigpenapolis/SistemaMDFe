using MDFeApi.Models;
using MDFeApi.Controllers;

namespace MDFeApi.Services
{
    public interface IMDFeService
    {
        Task<MDFe> CreateMDFeAsync(MDFe mdfe);
        Task<MDFe?> GetMDFeByIdAsync(int id);
        Task<IEnumerable<MDFe>> GetMDFesByEmitenteAsync(int emitenteId);
        Task<MDFe> UpdateMDFeAsync(MDFe mdfe);
        Task<bool> DeleteMDFeAsync(int id);
        Task<int> GetNextNumberAsync(int emitenteId, int serie);
        Task<bool> ValidateMDFeAsync(MDFe mdfe);

        // Novos métodos para rascunhos
        Task<string> SalvarRascunhoAsync(MDFeData mdfeData);
        Task<MDFeData?> CarregarRascunhoAsync(string id);
    }
}