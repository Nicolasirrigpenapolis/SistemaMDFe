namespace MDFeApi.Services
{
    public interface ICertificadoService
    {
        Task<bool> ValidarCertificadoAsync(string certificadoPath, string senha);
        Task<bool> ValidarCertificadoAsync(string certificadoPath);
        Task<string> ObterCnpjCertificadoAsync(string certificadoPath, string senha);
        Task<DateTime> ObterValidadeCertificadoAsync(string certificadoPath, string senha);
        Task<IEnumerable<string>> ListarCertificadosDisponiveisAsync();
        Task<bool> CertificadoValidoAsync(string certificadoPath);
        Task<IEnumerable<object>> ObterEmitentesPorTipoAsync(string tipo);
        Task<bool> DefinirSenhaCertificadoAsync(string senha);
    }
}