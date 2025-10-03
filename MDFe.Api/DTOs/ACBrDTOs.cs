namespace MDFeApi.DTOs
{
    /// <summary>
    /// Resposta padrão dos comandos ACBr Monitor
    /// </summary>
    public class ACBrResponseDto
    {
        public bool Sucesso { get; set; }
        public string Mensagem { get; set; } = string.Empty;
        public string? ChaveMDFe { get; set; }
        public string? Protocolo { get; set; }
        public string? XmlGerado { get; set; }
        public List<string> Erros { get; set; } = new();
        public string RespostaBruta { get; set; } = string.Empty;
    }

    /// <summary>
    /// Configurações do ACBr Monitor
    /// </summary>
    public class ACBrConfigDto
    {
        public string Host { get; set; } = "127.0.0.1";
        public int Port { get; set; } = 3434;
        public int Timeout { get; set; } = 30000;
        public string PathTemporario { get; set; } = "C:\\Temp\\MDFe";
    }
}
