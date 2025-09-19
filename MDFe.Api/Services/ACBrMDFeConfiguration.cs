namespace MDFeApi.Services
{
    public class ACBrMDFeConfiguration
    {
        public string DllPath { get; set; } = string.Empty;
        public int TipoAmbiente { get; set; } = 2; // 1=Produção, 2=Homologação
        public string UF { get; set; } = "SP";
        public int TimeOut { get; set; } = 60000;
        public int FormaEmissao { get; set; } = 1; // 1=Normal
        public string VersaoDF { get; set; } = "3.00";
        public string IdCSC { get; set; } = string.Empty;
        public string CSC { get; set; } = string.Empty;
        public string ProxyHost { get; set; } = string.Empty;
        public int ProxyPort { get; set; } = 0;
        public string ProxyUser { get; set; } = string.Empty;
        public string ProxyPass { get; set; } = string.Empty;

        // Certificado
        public string CertificadoPath { get; set; } = string.Empty;
        public string CertificadoSenha { get; set; } = string.Empty;
        public string CertificadoNumeroSerie { get; set; } = string.Empty;

        // Arquivos
        public string PathLogs { get; set; } = string.Empty;
        public string PathSchemas { get; set; } = string.Empty;
        public string PathSalvar { get; set; } = string.Empty;
        public string IniServicos { get; set; } = string.Empty;

        public static ACBrMDFeConfiguration FromConfiguration(IConfiguration configuration)
        {
            var config = new ACBrMDFeConfiguration();
            configuration.GetSection("ACBrMDFe").Bind(config);
            return config;
        }

        public bool IsValid()
        {
            if (string.IsNullOrEmpty(DllPath)) return false;
            if (string.IsNullOrEmpty(UF)) return false;
            if (TipoAmbiente != 1 && TipoAmbiente != 2) return false;
            
            return true;
        }

        public bool ValidarConfiguracaoCompleta()
        {
            if (!IsValid()) return false;

            // Verificar se DLL existe
            if (!File.Exists(DllPath)) return false;

            // Verificar se é a DLL correta (MT/Cdecl)
            if (!DllPath.Contains("MT") || !DllPath.Contains("Cdecl"))
            {
                throw new InvalidOperationException("DLL deve ser da versão MT/Cdecl para C#. Caminho atual: " + DllPath);
            }

            // Validações adicionais opcionais (certificado pode ser configurado por empresa)
            if (!string.IsNullOrEmpty(CertificadoPath) && !File.Exists(CertificadoPath))
            {
                throw new FileNotFoundException($"Certificado não encontrado: {CertificadoPath}");
            }

            return true;
        }
    }
}