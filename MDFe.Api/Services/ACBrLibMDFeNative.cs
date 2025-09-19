using System.Runtime.InteropServices;
using System.Text;

namespace MDFeApi.Services
{
    /// <summary>
    /// Classe para importação das funções nativas da ACBrLibMDFe.dll
    /// Versão: ACBrLibMDFe-Windows-1.2.2.337
    /// </summary>
    public static class ACBrLibMDFeNative
    {
        private const string DLL_NAME = "ACBrLibMDFe64.dll";

        #region Funções de Inicialização

        /// <summary>
        /// Inicializar a biblioteca ACBrLibMDFe
        /// </summary>
        /// <param name="eArqConfig">Arquivo de configuração</param>
        /// <param name="eChaveCrypt">Chave de criptografia</param>
        /// <returns>0 = Sucesso, outros = erro</returns>
        [DllImport(DLL_NAME, CallingConvention = CallingConvention.Cdecl, CharSet = CharSet.Ansi)]
        public static extern int MDFe_Inicializar(StringBuilder eArqConfig, StringBuilder eChaveCrypt);

        /// <summary>
        /// Finalizar a biblioteca ACBrLibMDFe
        /// </summary>
        /// <returns>0 = Sucesso, outros = erro</returns>
        [DllImport(DLL_NAME, CallingConvention = CallingConvention.Cdecl)]
        public static extern int MDFe_Finalizar();

        /// <summary>
        /// Obter nome da biblioteca
        /// </summary>
        [DllImport(DLL_NAME, CallingConvention = CallingConvention.Cdecl, CharSet = CharSet.Ansi)]
        public static extern int MDFe_Nome(StringBuilder buffer, ref int bufferSize);

        /// <summary>
        /// Obter versão da biblioteca
        /// </summary>
        [DllImport(DLL_NAME, CallingConvention = CallingConvention.Cdecl, CharSet = CharSet.Ansi)]
        public static extern int MDFe_Versao(StringBuilder buffer, ref int bufferSize);

        #endregion

        #region Funções de Configuração

        /// <summary>
        /// Configurar propriedade da biblioteca
        /// </summary>
        [DllImport(DLL_NAME, CallingConvention = CallingConvention.Cdecl, CharSet = CharSet.Ansi)]
        public static extern int MDFe_ConfigGravar(StringBuilder eNomeSecao, StringBuilder eNomeChave, StringBuilder eValor);

        /// <summary>
        /// Ler propriedade da biblioteca
        /// </summary>
        [DllImport(DLL_NAME, CallingConvention = CallingConvention.Cdecl, CharSet = CharSet.Ansi)]
        public static extern int MDFe_ConfigLer(StringBuilder eNomeSecao, StringBuilder eNomeChave, StringBuilder buffer, ref int bufferSize);

        /// <summary>
        /// Ler arquivo de configuração
        /// </summary>
        [DllImport(DLL_NAME, CallingConvention = CallingConvention.Cdecl, CharSet = CharSet.Ansi)]
        public static extern int MDFe_ConfigLerArquivo(StringBuilder eArqConfig);

        /// <summary>
        /// Gravar arquivo de configuração
        /// </summary>
        [DllImport(DLL_NAME, CallingConvention = CallingConvention.Cdecl, CharSet = CharSet.Ansi)]
        public static extern int MDFe_ConfigGravarArquivo(StringBuilder eArqConfig);

        #endregion

        #region Funções de Carregamento

        /// <summary>
        /// Limpar lista de MDFe
        /// </summary>
        [DllImport(DLL_NAME, CallingConvention = CallingConvention.Cdecl)]
        public static extern int MDFe_LimparLista();

        /// <summary>
        /// Carregar MDFe a partir de arquivo INI
        /// </summary>
        [DllImport(DLL_NAME, CallingConvention = CallingConvention.Cdecl, CharSet = CharSet.Ansi)]
        public static extern int MDFe_CarregarINI(StringBuilder eArquivoOuINI);

        /// <summary>
        /// Carregar MDFe a partir de arquivo XML
        /// </summary>
        [DllImport(DLL_NAME, CallingConvention = CallingConvention.Cdecl, CharSet = CharSet.Ansi)]
        public static extern int MDFe_CarregarXML(StringBuilder eArquivoOuXML);

        /// <summary>
        /// Obter XML do MDFe
        /// </summary>
        [DllImport(DLL_NAME, CallingConvention = CallingConvention.Cdecl, CharSet = CharSet.Ansi)]
        public static extern int MDFe_ObterXml(int AIndex, StringBuilder buffer, ref int bufferSize);

        #endregion

        #region Funções de Assinatura e Validação

        /// <summary>
        /// Assinar MDFe carregado
        /// </summary>
        [DllImport(DLL_NAME, CallingConvention = CallingConvention.Cdecl)]
        public static extern int MDFe_Assinar();

        /// <summary>
        /// Validar MDFe carregado
        /// </summary>
        [DllImport(DLL_NAME, CallingConvention = CallingConvention.Cdecl, CharSet = CharSet.Ansi)]
        public static extern int MDFe_Validar(StringBuilder buffer, ref int bufferSize);

        /// <summary>
        /// Validar regras de negócio do MDFe
        /// </summary>
        [DllImport(DLL_NAME, CallingConvention = CallingConvention.Cdecl, CharSet = CharSet.Ansi)]
        public static extern int MDFe_ValidarRegrasdeNegocios(StringBuilder buffer, ref int bufferSize);

        #endregion

        #region Funções de Transmissão

        /// <summary>
        /// Enviar MDFe para SEFAZ
        /// </summary>
        [DllImport(DLL_NAME, CallingConvention = CallingConvention.Cdecl, CharSet = CharSet.Ansi)]
        public static extern int MDFe_Enviar(int ALote, bool AImprimir, bool ASincrono, bool AZipado, StringBuilder buffer, ref int bufferSize);

        /// <summary>
        /// Consultar recibo de lote
        /// </summary>
        [DllImport(DLL_NAME, CallingConvention = CallingConvention.Cdecl, CharSet = CharSet.Ansi)]
        public static extern int MDFe_ConsultarRecibo(StringBuilder ARecibo, StringBuilder buffer, ref int bufferSize);

        /// <summary>
        /// Consultar MDFe pela chave de acesso
        /// </summary>
        [DllImport(DLL_NAME, CallingConvention = CallingConvention.Cdecl, CharSet = CharSet.Ansi)]
        public static extern int MDFe_Consultar(StringBuilder eChaveOuArquivo, bool AExtrairEventos, StringBuilder buffer, ref int bufferSize);

        /// <summary>
        /// Consultar status do serviço SEFAZ
        /// </summary>
        [DllImport(DLL_NAME, CallingConvention = CallingConvention.Cdecl, CharSet = CharSet.Ansi)]
        public static extern int MDFe_StatusServico(StringBuilder buffer, ref int bufferSize);

        #endregion

        #region Funções de Eventos

        /// <summary>
        /// Cancelar MDFe
        /// </summary>
        [DllImport(DLL_NAME, CallingConvention = CallingConvention.Cdecl, CharSet = CharSet.Ansi)]
        public static extern int MDFe_CancelarMDFe(StringBuilder eChave, StringBuilder eJustificativa, StringBuilder eCNPJ, int ALote, StringBuilder buffer, ref int bufferSize);

        /// <summary>
        /// Encerrar MDFe
        /// </summary>
        [DllImport(DLL_NAME, CallingConvention = CallingConvention.Cdecl, CharSet = CharSet.Ansi)]
        public static extern int MDFe_EncerrarMDFe(StringBuilder eChave, StringBuilder eDtEnc, StringBuilder eCUF, StringBuilder eCMun, StringBuilder buffer, ref int bufferSize);

        /// <summary>
        /// Incluir condutor no MDFe
        /// </summary>
        [DllImport(DLL_NAME, CallingConvention = CallingConvention.Cdecl, CharSet = CharSet.Ansi)]
        public static extern int MDFe_IncluirCondutor(StringBuilder eChave, StringBuilder eNomeCondutor, StringBuilder eCPFCondutor, int ALote, StringBuilder buffer, ref int bufferSize);

        #endregion

        #region Funções de Impressão

        /// <summary>
        /// Imprimir DAMDFE
        /// </summary>
        [DllImport(DLL_NAME, CallingConvention = CallingConvention.Cdecl, CharSet = CharSet.Ansi)]
        public static extern int MDFe_ImprimirPDF();

        /// <summary>
        /// Imprimir DAMDFE em arquivo
        /// </summary>
        [DllImport(DLL_NAME, CallingConvention = CallingConvention.Cdecl, CharSet = CharSet.Ansi)]
        public static extern int MDFe_ImprimirPDFArquivo(StringBuilder eArquivo);

        #endregion

        #region Funções de Distribuição DFe

        /// <summary>
        /// Distribuição DFe por último NSU
        /// </summary>
        [DllImport(DLL_NAME, CallingConvention = CallingConvention.Cdecl, CharSet = CharSet.Ansi)]
        public static extern int MDFe_DistribuicaoDFePorUltimoNSU(int cUFAutor, StringBuilder eCNPJCPF, StringBuilder eultNSU, StringBuilder buffer, ref int bufferSize);

        /// <summary>
        /// Distribuição DFe por NSU
        /// </summary>
        [DllImport(DLL_NAME, CallingConvention = CallingConvention.Cdecl, CharSet = CharSet.Ansi)]
        public static extern int MDFe_DistribuicaoDFePorNSU(int cUFAutor, StringBuilder eCNPJCPF, StringBuilder eNSU, StringBuilder buffer, ref int bufferSize);

        /// <summary>
        /// Distribuição DFe por chave
        /// </summary>
        [DllImport(DLL_NAME, CallingConvention = CallingConvention.Cdecl, CharSet = CharSet.Ansi)]
        public static extern int MDFe_DistribuicaoDFePorChave(int cUFAutor, StringBuilder eCNPJCPF, StringBuilder eChaveAcesso, StringBuilder buffer, ref int bufferSize);

        #endregion

        #region Funções Helper

        /// <summary>
        /// Obter último erro ocorrido
        /// </summary>
        [DllImport(DLL_NAME, CallingConvention = CallingConvention.Cdecl, CharSet = CharSet.Ansi)]
        public static extern int MDFe_UltimoRetorno(StringBuilder buffer, ref int bufferSize);

        /// <summary>
        /// Gerar chave do MDFe
        /// </summary>
        [DllImport(DLL_NAME, CallingConvention = CallingConvention.Cdecl, CharSet = CharSet.Ansi)]
        public static extern int MDFe_GerarChave(int ACodigoUF, int ACodigoNumerico, int AModelo, int ASerie, int ANumero, int ATpEmi, StringBuilder ADataEmi, StringBuilder ACnpjCpf, StringBuilder buffer, ref int bufferSize);

        #endregion
    }
}