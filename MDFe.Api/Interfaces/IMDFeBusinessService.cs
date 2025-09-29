using MDFeApi.DTOs;
using MDFeApi.Models;
using MDFeApi.Utils;

namespace MDFeApi.Interfaces
{
    public interface IMDFeBusinessService
    {
        Task<PagedResult<MDFeResponseDto>> GetMDFesAsync(int? emitenteId, int pagina, int tamanhoPagina);
        Task<MDFe?> GetMDFeByIdAsync(int id);
        Task<MDFe?> UpdateMDFeAsync(int id, MDFeCreateDto mdfeDto);
        Task<bool> DeleteMDFeAsync(int id);
        Task<int> GetProximoNumeroAsync(string? emitenteCnpj = null);
        Task<MDFe> CreateMDFeAsync(MDFeCreateDto mdfeDto);
    }
}