using Microsoft.Extensions.Diagnostics.HealthChecks;
using MDFeApi.Interfaces;

namespace MDFeApi.HealthChecks
{
    public class ACBrMonitorHealthCheck : IHealthCheck
    {
        private readonly IACBrMonitorClient _acbrClient;
        private readonly ILogger<ACBrMonitorHealthCheck> _logger;

        public ACBrMonitorHealthCheck(IACBrMonitorClient acbrClient, ILogger<ACBrMonitorHealthCheck> logger)
        {
            _acbrClient = acbrClient;
            _logger = logger;
        }

        public async Task<HealthCheckResult> CheckHealthAsync(
            HealthCheckContext context,
            CancellationToken cancellationToken = default)
        {
            try
            {
                _logger.LogDebug("Verificando saúde do ACBrMonitor...");

                var conectado = await _acbrClient.TestarConexaoAsync();

                if (conectado)
                {
                    _logger.LogDebug("ACBrMonitor está ativo e respondendo");
                    return HealthCheckResult.Healthy("ACBrMonitor está ativo e respondendo");
                }
                else
                {
                    _logger.LogWarning("ACBrMonitor não está respondendo");
                    return HealthCheckResult.Unhealthy("ACBrMonitor não está respondendo");
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao conectar no ACBrMonitor");
                return HealthCheckResult.Unhealthy("Erro ao conectar no ACBrMonitor", ex);
            }
        }
    }
}
