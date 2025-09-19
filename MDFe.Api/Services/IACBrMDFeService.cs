using MDFeApi.Controllers;

namespace MDFeApi.Services
{
    public interface IACBrMDFeService
    {
        #region Métodos de Inicialização e Configuração
        
        /// <summary>
        /// Inicializar a biblioteca ACBrLibMDFe
        /// </summary>
        Task<bool> InicializarAsync(string arquivoConfig = "", string chaveCrypt = "");
        
        /// <summary>
        /// Finalizar a biblioteca ACBrLibMDFe
        /// </summary>
        Task<bool> FinalizarAsync();
        
        /// <summary>
        /// Obter versão da biblioteca
        /// </summary>
        Task<string> ObterVersaoAsync();
        
        /// <summary>
        /// Obter nome da biblioteca
        /// </summary>
        Task<string> ObterNomeAsync();
        
        /// <summary>
        /// Configurar propriedade da biblioteca
        /// </summary>
        Task<bool> ConfigurarPropriedadeAsync(string sessao, string chave, string valor);
        
        /// <summary>
        /// Ler propriedade da biblioteca
        /// </summary>
        Task<string> LerPropriedadeAsync(string sessao, string chave);

        #endregion

        #region Métodos de Geração e Carregamento

        /// <summary>
        /// Limpar lista de MDFe
        /// </summary>
        Task<bool> LimparListaAsync();
        
        /// <summary>
        /// Gerar arquivo INI a partir dos dados do MDFe
        /// </summary>
        Task<string> GerarArquivoINIAsync(MDFeData mdfeData);
        
        /// <summary>
        /// Gerar arquivo INI buscando dados automaticamente por IDs
        /// </summary>
        Task<string> GerarArquivoINIAsync(DTOs.MDFeGerarINIDto dados);
        
        /// <summary>
        /// Carregar MDFe a partir de arquivo INI
        /// </summary>
        Task<bool> CarregarINIAsync(string iniPath);
        
        /// <summary>
        /// Carregar MDFe a partir de arquivo XML
        /// </summary>
        Task<bool> CarregarXMLAsync(string xmlPath);
        
        /// <summary>
        /// Obter XML do MDFe
        /// </summary>
        Task<string> ObterXMLAsync(int indice = 0);
        
        /// <summary>
        /// Gerar chave do MDFe
        /// </summary>
        Task<string> GerarChaveAsync(int cUF, int codigoNumerico, int modelo, int serie, int numero, int tpEmi, string dataEmissao, string cnpj);

        #endregion

        #region Métodos de Assinatura e Validação

        /// <summary>
        /// Assinar MDFe carregado
        /// </summary>
        Task<bool> AssinarAsync();
        
        /// <summary>
        /// Validar MDFe carregado
        /// </summary>
        Task<object> ValidarAsync();
        
        /// <summary>
        /// Validar regras de negócio do MDFe
        /// </summary>
        Task<object> ValidarRegrasNegocioAsync();
        
        /// <summary>
        /// Validar certificado atual
        /// </summary>
        Task<bool> ValidarCertificadoAtualAsync();

        #endregion

        #region Métodos de Transmissão

        /// <summary>
        /// Enviar MDFe para SEFAZ
        /// </summary>
        Task<object> EnviarAsync(bool sincrono = false, int lote = 1, bool imprimir = false, bool zipado = true);
        
        /// <summary>
        /// Consultar recibo de lote
        /// </summary>
        Task<object> ConsultarReciboAsync(string numeroRecibo);
        
        /// <summary>
        /// Consultar MDFe pela chave de acesso
        /// </summary>
        Task<object> ConsultarMDFeByChaveAsync(string chaveAcesso, bool extrairEventos = true);
        
        /// <summary>
        /// Consultar status do serviço SEFAZ
        /// </summary>
        Task<object> ConsultarStatusServicoAsync();

        #endregion

        #region Métodos de Eventos

        /// <summary>
        /// Cancelar MDFe
        /// </summary>
        Task<object> CancelarMDFeAsync(string chave, string justificativa, string cnpj, int lote = 1);
        
        /// <summary>
        /// Encerrar MDFe
        /// </summary>
        Task<object> EncerrarMDFeAsync(string chave, string dataEncerramento, string cUF, string cMun);
        
        /// <summary>
        /// Incluir condutor no MDFe
        /// </summary>
        Task<object> IncluirCondutorAsync(string chave, string nomeCondutor, string cpfCondutor);
        
        /// <summary>
        /// Incluir DFe no MDFe
        /// </summary>
        Task<object> IncluirDFeAsync(string chave, string cnpjEmitente, string cMunCarrega, string xMunCarrega);
        
        /// <summary>
        /// Registrar passagem
        /// </summary>
        Task<object> RegistrarPassagemAsync(string chave, string cUFTransito);
        
        /// <summary>
        /// Registrar passagem BRId
        /// </summary>
        Task<object> RegistrarPassagemBRIdAsync(string chave, string cUFTransito);

        #endregion

        #region Métodos de Impressão

        /// <summary>
        /// Imprimir DAMDFE
        /// </summary>
        Task<object> ImprimirDAMDFEAsync();
        
        /// <summary>
        /// Salvar DAMDFE em PDF
        /// </summary>
        Task<object> SalvarPDFAsync();

        #endregion

        #region Métodos de Distribuição DFe

        /// <summary>
        /// Distribuição DFe por último NSU
        /// </summary>
        Task<object> DistribuicaoDFePorUltimoNSUAsync(int cUFAutor, string cnpjCpf, string ultimoNSU);
        
        /// <summary>
        /// Distribuição DFe por NSU
        /// </summary>
        Task<object> DistribuicaoDFePorNSUAsync(int cUFAutor, string cnpjCpf, string nsu);
        
        /// <summary>
        /// Distribuição DFe por chave
        /// </summary>
        Task<object> DistribuicaoDFePorChaveAsync(int cUFAutor, string cnpjCpf, string chave);

        #endregion

        #region Métodos Legados (compatibilidade)

        /// <summary>
        /// Gerar MDFe (método legado)
        /// </summary>
        Task<string> GerarMDFeAsync(int mdfeId);
        
        /// <summary>
        /// Transmitir MDFe (método legado)
        /// </summary>
        Task<string> TransmitirMDFeAsync(int mdfeId);
        
        /// <summary>
        /// Consultar protocolo (método legado)
        /// </summary>
        Task<string> ConsultarProtocoloAsync(string numeroRecibo);
        
        /// <summary>
        /// Consultar MDFe (método legado)
        /// </summary>
        Task<string> ConsultarMDFeAsync(string chaveAcesso);
        
        /// <summary>
        /// Cancelar MDFe (método legado)
        /// </summary>
        Task<string> CancelarMDFeAsync(int mdfeId, string justificativa);
        
        /// <summary>
        /// Encerrar MDFe (método legado)
        /// </summary>
        Task<string> EncerrarMDFeAsync(int mdfeId, string municipioDescarga, string dataEncerramento);
        
        /// <summary>
        /// Gerar DAMDFE (método legado)
        /// </summary>
        Task<byte[]> GerarDAMDFeAsync(int mdfeId);
        
        /// <summary>
        /// Consultar status serviço (método legado)
        /// </summary>
        Task<string> ConsultarStatusServicoAsync(int codigoUf);
        
        /// <summary>
        /// Validar certificado (método legado)
        /// </summary>
        Task<bool> ValidarCertificadoAsync();
        
        /// <summary>
        /// Obter status da biblioteca
        /// </summary>
        Task<object> ObterStatusAsync();
        
        /// <summary>
        /// Cancelar MDFe simples (para interface web)
        /// </summary>
        Task<object> CancelarMDFeSimplesAsync();
        
        /// <summary>
        /// Encerrar MDFe simples (para interface web)
        /// </summary>
        Task<object> EncerrarMDFeSimplesAsync();

        #endregion
    }
}