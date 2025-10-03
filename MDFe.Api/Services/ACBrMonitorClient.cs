using System.Net.Sockets;
using System.Text;
using MDFeApi.Interfaces;

namespace MDFeApi.Services
{
    public class ACBrMonitorClient : IACBrMonitorClient
    {
        private readonly string _host;
        private readonly int _port;
        private readonly int _timeout;
        private readonly ILogger<ACBrMonitorClient> _logger;

        // IMPORTANTE: Encoding ISO-8859-1 (Latin1) conforme documentação ACBr
        private static readonly Encoding _encoding = Encoding.GetEncoding("ISO-8859-1");

        public ACBrMonitorClient(string host, int port, int timeout, ILogger<ACBrMonitorClient> logger)
        {
            _host = host;
            _port = port;
            _timeout = timeout;
            _logger = logger;
        }

        public async Task<string> ExecutarComandoAsync(string comando)
        {
            try
            {
                using var client = new TcpClient();

                // Conectar com timeout
                var connectTask = client.ConnectAsync(_host, _port);
                if (await Task.WhenAny(connectTask, Task.Delay(_timeout)) != connectTask)
                {
                    throw new TimeoutException($"Timeout ao conectar no ACBrMonitor ({_host}:{_port})");
                }

                await connectTask; // Lançar exceção se falhou

                using var stream = client.GetStream();

                // Formato do comando: "COMANDO\r\n.\r\n"
                var comandoFormatado = $"{comando}\r\n.\r\n";
                var bytes = _encoding.GetBytes(comandoFormatado);

                // Enviar comando
                await stream.WriteAsync(bytes, 0, bytes.Length);
                _logger.LogInformation("Comando enviado ao ACBr: {Comando}", comando);

                // Ler resposta
                var buffer = new byte[65536]; // 64KB
                var bytesRead = await stream.ReadAsync(buffer, 0, buffer.Length);
                var resposta = _encoding.GetString(buffer, 0, bytesRead);

                _logger.LogInformation("Resposta ACBr recebida ({Bytes} bytes)", bytesRead);
                _logger.LogDebug("Resposta completa: {Resposta}", resposta);

                return resposta;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao executar comando ACBr: {Comando}", comando);
                throw new InvalidOperationException($"Falha na comunicação com ACBrMonitor: {ex.Message}", ex);
            }
        }

        public async Task<bool> TestarConexaoAsync()
        {
            try
            {
                var resposta = await ExecutarComandoAsync("MDFE.Ativo");
                return resposta.Contains("OK", StringComparison.OrdinalIgnoreCase);
            }
            catch (Exception ex)
            {
                _logger.LogWarning(ex, "Falha ao testar conexão com ACBrMonitor");
                return false;
            }
        }
    }
}
