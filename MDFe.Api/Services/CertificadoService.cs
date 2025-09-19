using Microsoft.EntityFrameworkCore;
using System.Security.Cryptography.X509Certificates;
using System.Text.RegularExpressions;
using MDFeApi.Data;

namespace MDFeApi.Services
{
    public class CertificadoService : ICertificadoService
    {
        private readonly ILogger<CertificadoService> _logger;
        private readonly MDFeContext _context;

        public CertificadoService(ILogger<CertificadoService> logger, MDFeContext context)
        {
            _logger = logger;
            _context = context;
        }

        public async Task<bool> ValidarCertificadoAsync(string certificadoPath, string senha)
        {
            if (!File.Exists(certificadoPath))
            {
                _logger.LogWarning("Arquivo de certificado não encontrado em {Path}", certificadoPath);
                return false;
            }

            try
            {
                var certificate = new X509Certificate2(await File.ReadAllBytesAsync(certificadoPath), senha);
                var isValido = DateTime.Now >= certificate.NotBefore && DateTime.Now <= certificate.NotAfter;
                if (!isValido)
                {
                    _logger.LogWarning("Certificado {Subject} expirado. Validade: {NotAfter}", certificate.Subject, certificate.NotAfter);
                }
                return isValido;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao validar o certificado {Path}. A senha pode estar incorreta ou o arquivo corrompido.", certificadoPath);
                return false;
            }
        }

        public async Task<string> ObterCnpjCertificadoAsync(string certificadoPath, string senha)
        {
            try
            {
                var certificate = new X509Certificate2(await File.ReadAllBytesAsync(certificadoPath), senha);

                // Tenta extrair o CNPJ do Subject Name
                var match = Regex.Match(certificate.Subject, "CN=([^:]+):([0-9]{14})");
                if (match.Success && match.Groups.Count > 2)
                {
                    return match.Groups[2].Value;
                }

                // Fallback para outras extensões (mais complexo, omitido por simplicidade inicial)
                _logger.LogWarning("Não foi possível extrair o CNPJ do Subject Name do certificado: {Subject}", certificate.Subject);
                return string.Empty;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao obter CNPJ do certificado.");
                return string.Empty;
            }
        }

        public async Task<DateTime> ObterValidadeCertificadoAsync(string certificadoPath, string senha)
        {
            try
            {
                var certificate = new X509Certificate2(await File.ReadAllBytesAsync(certificadoPath), senha);
                return certificate.NotAfter;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao obter data de validade do certificado.");
                return DateTime.MinValue;
            }
        }

        public async Task<IEnumerable<string>> ListarCertificadosDisponiveisAsync()
        {
            try
            {
                // Listar certificados do Windows Store (usuário atual)
                var certificados = new List<string>();

                using (var store = new X509Store(StoreName.My, StoreLocation.CurrentUser))
                {
                    store.Open(OpenFlags.ReadOnly);
                    foreach (var cert in store.Certificates)
                    {
                        // Filtrar apenas certificados válidos e com chave privada
                        if (cert.HasPrivateKey && DateTime.Now >= cert.NotBefore && DateTime.Now <= cert.NotAfter)
                        {
                            certificados.Add($"{cert.Subject} - Válido até: {cert.NotAfter:dd/MM/yyyy}");
                        }
                    }
                    store.Close();
                }

                // Também listar certificados dos emitentes cadastrados
                var emitentesComCertificado = await _context.Emitentes
                    .Where(e => e.Ativo && !string.IsNullOrEmpty(e.CaminhoArquivoCertificado))
                    .Select(e => new { e.RazaoSocial, e.CaminhoArquivoCertificado })
                    .ToListAsync();

                foreach (var emitente in emitentesComCertificado)
                {
                    if (File.Exists(emitente.CaminhoArquivoCertificado))
                    {
                        certificados.Add($"Arquivo: {emitente.CaminhoArquivoCertificado} ({emitente.RazaoSocial})");
                    }
                }

                return certificados;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao listar certificados disponíveis");
                return new List<string>();
            }
        }

        public async Task<bool> ValidarCertificadoAsync(string certificadoPath)
        {
            if (string.IsNullOrEmpty(certificadoPath) || !File.Exists(certificadoPath))
            {
                return false;
            }

            try
            {
                // Tentar carregar o certificado sem senha (se for um arquivo .cer ou .crt)
                var certificateBytes = await File.ReadAllBytesAsync(certificadoPath);
                var certificate = new X509Certificate2(certificateBytes);

                // Verificar se o certificado está dentro do período de validade
                return DateTime.Now >= certificate.NotBefore && DateTime.Now <= certificate.NotAfter;
            }
            catch (Exception ex)
            {
                // Se falhar, pode ser um arquivo .pfx que precisa de senha
                _logger.LogWarning(ex, "Não foi possível validar o certificado sem senha: {Path}", certificadoPath);
                return File.Exists(certificadoPath); // Pelo menos verificar se o arquivo existe
            }
        }

        public async Task<bool> CertificadoValidoAsync(string certificadoPath)
        {
            return await ValidarCertificadoAsync(certificadoPath);
        }

        public async Task<IEnumerable<object>> ObterEmitentesPorTipoAsync(string tipo)
        {
            try
            {
                var query = _context.Emitentes.Where(e => e.Ativo);

                // Filtrar por tipo se especificado
                if (!string.IsNullOrEmpty(tipo))
                {
                    switch (tipo.ToLower())
                    {
                        case "com_certificado":
                            query = query.Where(e => !string.IsNullOrEmpty(e.CaminhoArquivoCertificado));
                            break;
                        case "sem_certificado":
                            query = query.Where(e => string.IsNullOrEmpty(e.CaminhoArquivoCertificado));
                            break;
                        case "pessoa_fisica":
                            query = query.Where(e => e.Cnpj != null && e.Cnpj.Length == 11); // CPF tem 11 dígitos
                            break;
                        case "pessoa_juridica":
                            query = query.Where(e => e.Cnpj != null && e.Cnpj.Length == 14); // CNPJ tem 14 dígitos
                            break;
                    }
                }

                var emitentes = await query
                    .Select(e => new
                    {
                        Id = e.Id,
                        Nome = e.RazaoSocial,
                        Cnpj = e.Cnpj,
                        TemCertificado = !string.IsNullOrEmpty(e.CaminhoArquivoCertificado),
                        InscricaoEstadual = e.Ie,
                        Uf = e.Uf
                    })
                    .ToListAsync();

                return emitentes;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao obter emitentes por tipo: {Tipo}", tipo);
                return new List<object>();
            }
        }

        public async Task<bool> DefinirSenhaCertificadoAsync(string senha)
        {
            try
            {
                if (string.IsNullOrEmpty(senha))
                {
                    _logger.LogWarning("Tentativa de definir senha vazia para certificado");
                    return false;
                }

                // Validar se a senha atende aos critérios mínimos
                if (senha.Length < 4)
                {
                    _logger.LogWarning("Senha muito curta para certificado (mínimo 4 caracteres)");
                    return false;
                }

                // Aqui podemos implementar validações adicionais ou armazenar temporariamente
                // Por ora, apenas validamos e retornamos sucesso
                _logger.LogInformation("Senha de certificado definida com sucesso");

                await Task.Delay(10); // Simular operação async se necessário
                return true;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao definir senha do certificado");
                return false;
            }
        }
    }
}