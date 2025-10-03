using MDFeApi.DTOs;

namespace MDFeApi.Interfaces
{
    /// <summary>
    /// Interface para parser de respostas do ACBr Monitor
    /// </summary>
    public interface IACBrResponseParser
    {
        /// <summary>
        /// Processa a resposta bruta do ACBr Monitor
        /// </summary>
        /// <param name="respostaBruta">Resposta completa do ACBr</param>
        /// <returns>DTO com dados estruturados</returns>
        ACBrResponseDto ParseResposta(string respostaBruta);
    }
}
