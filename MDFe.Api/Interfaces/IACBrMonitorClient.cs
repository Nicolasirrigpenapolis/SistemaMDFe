namespace MDFeApi.Interfaces
{
    /// <summary>
    /// Interface para comunicação com o ACBrMonitorPLUS via TCP/IP
    /// </summary>
    public interface IACBrMonitorClient
    {
        /// <summary>
        /// Executa um comando no ACBrMonitor e retorna a resposta
        /// </summary>
        /// <param name="comando">Comando a ser executado (ex: "MDFE.StatusServico")</param>
        /// <returns>Resposta do ACBrMonitor</returns>
        Task<string> ExecutarComandoAsync(string comando);

        /// <summary>
        /// Testa a conectividade com o ACBrMonitor
        /// </summary>
        /// <returns>True se conectado, False caso contrário</returns>
        Task<bool> TestarConexaoAsync();
    }
}
