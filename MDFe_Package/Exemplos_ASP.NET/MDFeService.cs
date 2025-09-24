using System.Runtime.InteropServices;
using System.Text;

namespace SeuProjeto.Services
{
    /// <summary>
    /// Interface para o serviço MDFe
    /// </summary>
    public interface IMDFeService
    {
        string GerarMDFe(string templatePath);
        string TransmitirMDFe(int numeroLote = 1);
        string ConsultarMDFe(string chave);
        string CancelarMDFe(string chave, string justificativa);
        string EncerrarMDFe(string chave, string codigoMunicipioDestino);
        string StatusServico();
        string ConsultarNaoEncerrados(string cnpj);
        void ConfigurarCertificado(string numeroCertificado, string senha = "");
        void ConfigurarAmbiente(int ambiente);
    }

    /// <summary>
    /// Serviço para integração com ACBrLibMDFe - Modal Rodoviário
    /// Versão 1.2.2.337 com suporte à Nota Técnica 2025.001
    /// </summary>
    public class MDFeService : IMDFeService, IDisposable
    {
        private bool _inicializado = false;
        private readonly ILogger<MDFeService>? _logger;

        public MDFeService(ILogger<MDFeService>? logger = null)
        {
            _logger = logger;
        }

        #region DLL Imports - Convenção Cdecl para ASP.NET

        [DllImport("ACBrMDFe64.dll", CallingConvention = CallingConvention.Cdecl, CharSet = CharSet.Ansi)]
        private static extern int MDFE_Inicializar([MarshalAs(UnmanagedType.LPStr)] string eIniPath, [MarshalAs(UnmanagedType.LPStr)] string eChaveCrypt);

        [DllImport("ACBrMDFe64.dll", CallingConvention = CallingConvention.Cdecl)]
        private static extern int MDFE_Finalizar();

        [DllImport("ACBrMDFe64.dll", CallingConvention = CallingConvention.Cdecl, CharSet = CharSet.Ansi)]
        private static extern int MDFE_Nome([MarshalAs(UnmanagedType.LPStr)] StringBuilder sResposta, ref int esTamanho);

        [DllImport("ACBrMDFe64.dll", CallingConvention = CallingConvention.Cdecl, CharSet = CharSet.Ansi)]
        private static extern int MDFE_Versao([MarshalAs(UnmanagedType.LPStr)] StringBuilder sResposta, ref int esTamanho);

        [DllImport("ACBrMDFe64.dll", CallingConvention = CallingConvention.Cdecl, CharSet = CharSet.Ansi)]
        private static extern int MDFE_ConfigLer([MarshalAs(UnmanagedType.LPStr)] string eSecao, [MarshalAs(UnmanagedType.LPStr)] string eChave, [MarshalAs(UnmanagedType.LPStr)] StringBuilder sResposta, ref int esTamanho);

        [DllImport("ACBrMDFe64.dll", CallingConvention = CallingConvention.Cdecl, CharSet = CharSet.Ansi)]
        private static extern int MDFE_ConfigGravar([MarshalAs(UnmanagedType.LPStr)] string eSecao, [MarshalAs(UnmanagedType.LPStr)] string eChave, [MarshalAs(UnmanagedType.LPStr)] string eValor);

        [DllImport("ACBrMDFe64.dll", CallingConvention = CallingConvention.Cdecl, CharSet = CharSet.Ansi)]
        private static extern int MDFE_ConfigLerArquivo([MarshalAs(UnmanagedType.LPStr)] string eArquivoIni);

        [DllImport("ACBrMDFe64.dll", CallingConvention = CallingConvention.Cdecl, CharSet = CharSet.Ansi)]
        private static extern int MDFE_CarregarINI([MarshalAs(UnmanagedType.LPStr)] string eArquivoOuINI);

        [DllImport("ACBrMDFe64.dll", CallingConvention = CallingConvention.Cdecl, CharSet = CharSet.Ansi)]
        private static extern int MDFE_CarregarXML([MarshalAs(UnmanagedType.LPStr)] string eArquivoOuXML);

        [DllImport("ACBrMDFe64.dll", CallingConvention = CallingConvention.Cdecl)]
        private static extern int MDFE_Limpar();

        [DllImport("ACBrMDFe64.dll", CallingConvention = CallingConvention.Cdecl, CharSet = CharSet.Ansi)]
        private static extern int MDFE_Assinar([MarshalAs(UnmanagedType.LPStr)] StringBuilder sResposta, ref int esTamanho);

        [DllImport("ACBrMDFe64.dll", CallingConvention = CallingConvention.Cdecl, CharSet = CharSet.Ansi)]
        private static extern int MDFE_Validar([MarshalAs(UnmanagedType.LPStr)] StringBuilder sResposta, ref int esTamanho);

        [DllImport("ACBrMDFe64.dll", CallingConvention = CallingConvention.Cdecl, CharSet = CharSet.Ansi)]
        private static extern int MDFE_Enviar([MarshalAs(UnmanagedType.I4)] int aLote, [MarshalAs(UnmanagedType.I1)] bool aImprimir, [MarshalAs(UnmanagedType.I1)] bool aSincrono, [MarshalAs(UnmanagedType.LPStr)] StringBuilder sResposta, ref int esTamanho);

        [DllImport("ACBrMDFe64.dll", CallingConvention = CallingConvention.Cdecl, CharSet = CharSet.Ansi)]
        private static extern int MDFE_Consultar([MarshalAs(UnmanagedType.LPStr)] string eChaveOuArquivo, [MarshalAs(UnmanagedType.I1)] bool aExtrairEventos, [MarshalAs(UnmanagedType.LPStr)] StringBuilder sResposta, ref int esTamanho);

        [DllImport("ACBrMDFe64.dll", CallingConvention = CallingConvention.Cdecl, CharSet = CharSet.Ansi)]
        private static extern int MDFE_StatusServico([MarshalAs(UnmanagedType.LPStr)] StringBuilder sResposta, ref int esTamanho);

        [DllImport("ACBrMDFe64.dll", CallingConvention = CallingConvention.Cdecl, CharSet = CharSet.Ansi)]
        private static extern int MDFE_ConsultarRecibo([MarshalAs(UnmanagedType.LPStr)] string aRecibo, [MarshalAs(UnmanagedType.LPStr)] StringBuilder sResposta, ref int esTamanho);

        [DllImport("ACBrMDFe64.dll", CallingConvention = CallingConvention.Cdecl, CharSet = CharSet.Ansi)]
        private static extern int MDFE_CancelarMDFe([MarshalAs(UnmanagedType.LPStr)] string eChave, [MarshalAs(UnmanagedType.LPStr)] string eJustificativa, [MarshalAs(UnmanagedType.LPStr)] string eCNPJCPF, [MarshalAs(UnmanagedType.I4)] int nLote, [MarshalAs(UnmanagedType.LPStr)] StringBuilder sResposta, ref int esTamanho);

        [DllImport("ACBrMDFe64.dll", CallingConvention = CallingConvention.Cdecl, CharSet = CharSet.Ansi)]
        private static extern int MDFE_EncerrarMDFe([MarshalAs(UnmanagedType.LPStr)] string eArquivoOuINI, [MarshalAs(UnmanagedType.LPStr)] StringBuilder sResposta, ref int esTamanho);

        [DllImport("ACBrMDFe64.dll", CallingConvention = CallingConvention.Cdecl, CharSet = CharSet.Ansi)]
        private static extern int MDFE_ConsultarNaoEncerrados([MarshalAs(UnmanagedType.LPStr)] string eCNPJ, [MarshalAs(UnmanagedType.LPStr)] StringBuilder sResposta, ref int esTamanho);

        [DllImport("ACBrMDFe64.dll", CallingConvention = CallingConvention.Cdecl, CharSet = CharSet.Ansi)]
        private static extern int MDFE_IncluirCondutor([MarshalAs(UnmanagedType.LPStr)] string eArquivoOuINI, [MarshalAs(UnmanagedType.LPStr)] StringBuilder sResposta, ref int esTamanho);

        [DllImport("ACBrMDFe64.dll", CallingConvention = CallingConvention.Cdecl, CharSet = CharSet.Ansi)]
        private static extern int MDFE_IncluirDFe([MarshalAs(UnmanagedType.LPStr)] string eArquivoOuINI, [MarshalAs(UnmanagedType.LPStr)] StringBuilder sResposta, ref int esTamanho);

        #endregion

        #region Métodos Públicos

        /// <summary>
        /// Gera um MDFe a partir de um template INI
        /// </summary>
        /// <param name="templatePath">Caminho para o arquivo INI template</param>
        /// <returns>XML do MDFe gerado e assinado</returns>
        public string GerarMDFe(string templatePath)
        {
            try
            {
                InicializarSeNecessario();

                _logger?.LogInformation("Gerando MDFe a partir do template: {templatePath}", templatePath);

                // Carregar template INI
                var resultado = MDFE_CarregarINI(templatePath);
                VerificarResultado(resultado, "Erro ao carregar template INI");

                // Validar MDFe
                var bufferValidacao = new StringBuilder(65536);
                var tamanhoValidacao = bufferValidacao.Capacity;
                resultado = MDFE_Validar(bufferValidacao, ref tamanhoValidacao);
                VerificarResultado(resultado, "Erro na validação do MDFe");

                // Assinar MDFe
                var bufferAssinatura = new StringBuilder(65536);
                var tamanhoAssinatura = bufferAssinatura.Capacity;
                resultado = MDFE_Assinar(bufferAssinatura, ref tamanhoAssinatura);
                VerificarResultado(resultado, "Erro ao assinar MDFe");

                var xmlGerado = bufferAssinatura.ToString();
                _logger?.LogInformation("MDFe gerado e assinado com sucesso");

                return xmlGerado;
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "Erro ao gerar MDFe");
                throw;
            }
        }

        /// <summary>
        /// Transmite o MDFe para a SEFAZ
        /// </summary>
        /// <param name="numeroLote">Número do lote (padrão: 1)</param>
        /// <returns>Resposta da SEFAZ</returns>
        public string TransmitirMDFe(int numeroLote = 1)
        {
            try
            {
                _logger?.LogInformation("Transmitindo MDFe - Lote: {numeroLote}", numeroLote);

                var buffer = new StringBuilder(65536);
                var tamanho = buffer.Capacity;
                var resultado = MDFE_Enviar(numeroLote, false, true, buffer, ref tamanho);
                VerificarResultado(resultado, "Erro ao transmitir MDFe");

                var resposta = buffer.ToString();
                _logger?.LogInformation("MDFe transmitido com sucesso");

                return resposta;
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "Erro ao transmitir MDFe");
                throw;
            }
        }

        /// <summary>
        /// Consulta um MDFe pela chave de acesso
        /// </summary>
        /// <param name="chave">Chave de acesso do MDFe</param>
        /// <returns>XML do MDFe consultado</returns>
        public string ConsultarMDFe(string chave)
        {
            try
            {
                InicializarSeNecessario();

                _logger?.LogInformation("Consultando MDFe: {chave}", chave);

                var buffer = new StringBuilder(65536);
                var tamanho = buffer.Capacity;
                var resultado = MDFE_Consultar(chave, true, buffer, ref tamanho);
                VerificarResultado(resultado, "Erro ao consultar MDFe");

                var resposta = buffer.ToString();
                _logger?.LogInformation("MDFe consultado com sucesso");

                return resposta;
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "Erro ao consultar MDFe");
                throw;
            }
        }

        /// <summary>
        /// Cancela um MDFe
        /// </summary>
        /// <param name="chave">Chave de acesso do MDFe</param>
        /// <param name="justificativa">Justificativa do cancelamento (mín 15 caracteres)</param>
        /// <returns>Resultado do cancelamento</returns>
        public string CancelarMDFe(string chave, string justificativa)
        {
            try
            {
                InicializarSeNecessario();

                if (string.IsNullOrWhiteSpace(justificativa) || justificativa.Length < 15)
                    throw new ArgumentException("Justificativa deve ter no mínimo 15 caracteres");

                _logger?.LogInformation("Cancelando MDFe: {chave}", chave);

                // Obter CNPJ do emitente das configurações
                var bufferCNPJ = new StringBuilder(18);
                var tamanhoCNPJ = bufferCNPJ.Capacity;
                MDFE_ConfigLer("emit", "CNPJCPF", bufferCNPJ, ref tamanhoCNPJ);
                var cnpjEmitente = bufferCNPJ.ToString();

                var buffer = new StringBuilder(65536);
                var tamanho = buffer.Capacity;
                var resultado = MDFE_CancelarMDFe(chave, justificativa, cnpjEmitente, 1, buffer, ref tamanho);
                VerificarResultado(resultado, "Erro ao cancelar MDFe");

                var resposta = buffer.ToString();
                _logger?.LogInformation("MDFe cancelado com sucesso");

                return resposta;
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "Erro ao cancelar MDFe");
                throw;
            }
        }

        /// <summary>
        /// Encerra um MDFe (quando chega ao destino)
        /// </summary>
        /// <param name="chave">Chave de acesso do MDFe</param>
        /// <param name="codigoMunicipioDestino">Código do município de destino</param>
        /// <returns>Resultado do encerramento</returns>
        public string EncerrarMDFe(string chave, string codigoMunicipioDestino)
        {
            try
            {
                InicializarSeNecessario();

                _logger?.LogInformation("Encerrando MDFe: {chave}", chave);

                // Criar INI de encerramento temporário
                var iniEncerramento = $@"
[evento]
chMDFe={chave}
tpEvento=110112
detEvento_versaoEvento=3.00
detEvento_evEncMDFe_descEvento=Encerramento
detEvento_evEncMDFe_cMunDescarga={codigoMunicipioDestino}
detEvento_evEncMDFe_dtEnc={DateTime.Now:yyyy-MM-dd}
";

                var buffer = new StringBuilder(65536);
                var tamanho = buffer.Capacity;
                var resultado = MDFE_EncerrarMDFe(iniEncerramento, buffer, ref tamanho);
                VerificarResultado(resultado, "Erro ao encerrar MDFe");

                var resposta = buffer.ToString();
                _logger?.LogInformation("MDFe encerrado com sucesso");

                return resposta;
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "Erro ao encerrar MDFe");
                throw;
            }
        }

        /// <summary>
        /// Verifica o status do serviço SEFAZ
        /// </summary>
        /// <returns>Status do serviço</returns>
        public string StatusServico()
        {
            try
            {
                InicializarSeNecessario();

                _logger?.LogInformation("Verificando status do serviço SEFAZ");

                var buffer = new StringBuilder(65536);
                var tamanho = buffer.Capacity;
                var resultado = MDFE_StatusServico(buffer, ref tamanho);
                VerificarResultado(resultado, "Erro ao consultar status do serviço");

                var resposta = buffer.ToString();
                _logger?.LogInformation("Status do serviço consultado com sucesso");

                return resposta;
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "Erro ao consultar status do serviço");
                throw;
            }
        }

        /// <summary>
        /// Consulta MDFes não encerrados de uma transportadora
        /// </summary>
        /// <param name="cnpj">CNPJ da transportadora</param>
        /// <returns>Lista de MDFes não encerrados</returns>
        public string ConsultarNaoEncerrados(string cnpj)
        {
            try
            {
                InicializarSeNecessario();

                _logger?.LogInformation("Consultando MDFes não encerrados: {cnpj}", cnpj);

                var buffer = new StringBuilder(65536);
                var tamanho = buffer.Capacity;
                var resultado = MDFE_ConsultarNaoEncerrados(cnpj, buffer, ref tamanho);
                VerificarResultado(resultado, "Erro ao consultar MDFes não encerrados");

                var resposta = buffer.ToString();
                _logger?.LogInformation("Consulta de não encerrados realizada com sucesso");

                return resposta;
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "Erro ao consultar MDFes não encerrados");
                throw;
            }
        }

        /// <summary>
        /// Configura o certificado digital
        /// </summary>
        /// <param name="numeroCertificado">Número de série do certificado</param>
        /// <param name="senha">Senha do certificado (se necessário)</param>
        public void ConfigurarCertificado(string numeroCertificado, string senha = "")
        {
            try
            {
                InicializarSeNecessario();

                _logger?.LogInformation("Configurando certificado: {numeroCertificado}", numeroCertificado);

                var resultado = MDFE_ConfigGravar("Certificados", "NumeroSerie", numeroCertificado);
                VerificarResultado(resultado, "Erro ao configurar número do certificado");

                if (!string.IsNullOrWhiteSpace(senha))
                {
                    resultado = MDFE_ConfigGravar("Certificados", "Senha", senha);
                    VerificarResultado(resultado, "Erro ao configurar senha do certificado");
                }

                _logger?.LogInformation("Certificado configurado com sucesso");
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "Erro ao configurar certificado");
                throw;
            }
        }

        /// <summary>
        /// Configura o ambiente (produção/homologação)
        /// </summary>
        /// <param name="ambiente">1 = Produção, 2 = Homologação</param>
        public void ConfigurarAmbiente(int ambiente)
        {
            try
            {
                InicializarSeNecessario();

                if (ambiente != 1 && ambiente != 2)
                    throw new ArgumentException("Ambiente deve ser 1 (Produção) ou 2 (Homologação)");

                _logger?.LogInformation("Configurando ambiente: {ambiente}", ambiente == 1 ? "Produção" : "Homologação");

                var resultado = MDFE_ConfigGravar("DFe", "AmbienteCodigo", ambiente.ToString());
                VerificarResultado(resultado, "Erro ao configurar ambiente");

                resultado = MDFE_ConfigGravar("WebServices", "Ambiente", ambiente.ToString());
                VerificarResultado(resultado, "Erro ao configurar ambiente dos webservices");

                _logger?.LogInformation("Ambiente configurado com sucesso");
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "Erro ao configurar ambiente");
                throw;
            }
        }

        #endregion

        #region Métodos Privados

        /// <summary>
        /// Inicializa a biblioteca se ainda não foi inicializada
        /// </summary>
        private void InicializarSeNecessario()
        {
            if (!_inicializado)
            {
                var caminhoIni = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "ACBrLib.ini");
                var resultado = MDFE_Inicializar(caminhoIni, "");
                VerificarResultado(resultado, "Erro ao inicializar ACBrLibMDFe");

                _inicializado = true;
                _logger?.LogInformation("ACBrLibMDFe inicializada com sucesso");
            }
        }

        /// <summary>
        /// Verifica o resultado de uma operação da DLL
        /// </summary>
        /// <param name="resultado">Código de retorno</param>
        /// <param name="mensagemErro">Mensagem de erro personalizada</param>
        private void VerificarResultado(int resultado, string mensagemErro)
        {
            if (resultado != 0)
            {
                var erro = $"{mensagemErro}. Código: {resultado}";
                _logger?.LogError(erro);
                throw new Exception(erro);
            }
        }

        #endregion

        #region IDisposable

        public void Dispose()
        {
            if (_inicializado)
            {
                try
                {
                    MDFE_Finalizar();
                    _inicializado = false;
                    _logger?.LogInformation("ACBrLibMDFe finalizada");
                }
                catch (Exception ex)
                {
                    _logger?.LogError(ex, "Erro ao finalizar ACBrLibMDFe");
                }
            }
            GC.SuppressFinalize(this);
        }

        ~MDFeService()
        {
            Dispose();
        }

        #endregion
    }
}