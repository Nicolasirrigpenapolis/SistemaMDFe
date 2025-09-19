using System.Text;

namespace MDFeApi.Services
{
    /// <summary>
    /// Classe helper para facilitar o uso da biblioteca ACBrLibMDFe
    /// Centraliza tratamento de erros e conversões
    /// </summary>
    public static class ACBrLibMDFeHelper
    {
        private const int BUFFER_SIZE = 65536;

        /// <summary>
        /// Verificar se resultado da operação foi bem-sucedido
        /// </summary>
        /// <param name="resultado">Código de retorno da função ACBr</param>
        /// <returns>True se sucesso (0), False caso contrário</returns>
        public static bool Sucesso(int resultado)
        {
            return resultado == 0;
        }

        /// <summary>
        /// Verificar se houve erro na operação
        /// </summary>
        /// <param name="resultado">Código de retorno da função ACBr</param>
        /// <returns>True se erro (!= 0), False caso contrário</returns>
        public static bool Erro(int resultado)
        {
            return resultado != 0;
        }

        /// <summary>
        /// Obter último erro da biblioteca
        /// </summary>
        /// <returns>Mensagem de erro</returns>
        public static string ObterUltimoErro()
        {
            var buffer = new StringBuilder(BUFFER_SIZE);
            var bufferSize = BUFFER_SIZE;

            var resultado = ACBrLibMDFeNative.MDFe_UltimoRetorno(buffer, ref bufferSize);

            if (resultado == 0)
                return buffer.ToString();
            else
                return $"Erro ao obter último erro. Código: {resultado}";
        }

        /// <summary>
        /// Lançar exceção se houve erro na operação
        /// </summary>
        /// <param name="resultado">Código de retorno da função ACBr</param>
        /// <param name="operacao">Nome da operação executada</param>
        public static void VerificarErro(int resultado, string operacao = "")
        {
            if (Erro(resultado))
            {
                var mensagemErro = ObterUltimoErro();
                var mensagem = string.IsNullOrEmpty(operacao)
                    ? $"Erro ACBrMDFe: {mensagemErro}"
                    : $"Erro ACBrMDFe em '{operacao}': {mensagemErro}";

                throw new ACBrLibException(mensagem, resultado);
            }
        }

        /// <summary>
        /// Executar operação com buffer de retorno
        /// </summary>
        /// <param name="operacao">Função que executa a operação</param>
        /// <param name="nomeOperacao">Nome da operação para log de erro</param>
        /// <returns>Conteúdo do buffer</returns>
        public static string ExecutarComBuffer(Func<StringBuilder, int, int> operacao, string nomeOperacao = "")
        {
            var buffer = new StringBuilder(BUFFER_SIZE);
            var bufferSize = BUFFER_SIZE;

            var resultado = operacao(buffer, bufferSize);
            VerificarErro(resultado, nomeOperacao);

            return buffer.ToString();
        }

        /// <summary>
        /// Executar operação simples sem retorno
        /// </summary>
        /// <param name="operacao">Função que executa a operação</param>
        /// <param name="nomeOperacao">Nome da operação para log de erro</param>
        public static void ExecutarOperacao(Func<int> operacao, string nomeOperacao = "")
        {
            var resultado = operacao();
            VerificarErro(resultado, nomeOperacao);
        }

        /// <summary>
        /// Converter string para StringBuilder para uso nas funções ACBr
        /// </summary>
        /// <param name="texto">Texto a ser convertido</param>
        /// <returns>StringBuilder com o texto</returns>
        public static StringBuilder StringParaBuffer(string texto)
        {
            return new StringBuilder(texto ?? string.Empty);
        }

        /// <summary>
        /// Alias para StringParaBuffer - compatibilidade
        /// </summary>
        /// <param name="texto">Texto a ser convertido</param>
        /// <returns>StringBuilder com o texto</returns>
        public static StringBuilder ToStringBuilder(string texto)
        {
            return StringParaBuffer(texto);
        }

        /// <summary>
        /// Executar comando simples sem retorno
        /// </summary>
        /// <param name="operacao">Função que executa a operação</param>
        /// <param name="nomeOperacao">Nome da operação para log de erro</param>
        public static void ExecutarComandoSimples(Func<int> operacao, string nomeOperacao = "")
        {
            ExecutarOperacao(operacao, nomeOperacao);
        }

        /// <summary>
        /// Validar se arquivo existe
        /// </summary>
        /// <param name="caminho">Caminho do arquivo</param>
        /// <param name="nomeArquivo">Nome do arquivo para mensagem de erro</param>
        public static void ValidarArquivo(string caminho, string nomeArquivo = "arquivo")
        {
            if (string.IsNullOrEmpty(caminho))
                throw new ACBrLibException($"Caminho do {nomeArquivo} não pode ser vazio");

            if (!File.Exists(caminho))
                throw new ACBrLibException($"{nomeArquivo} não encontrado: {caminho}");
        }

        /// <summary>
        /// Configurar propriedade da biblioteca
        /// </summary>
        /// <param name="secao">Nome da seção</param>
        /// <param name="chave">Nome da chave</param>
        /// <param name="valor">Valor a ser configurado</param>
        public static void ConfigurarPropriedade(string secao, string chave, string valor)
        {
            var resultado = ACBrLibMDFeNative.MDFe_ConfigGravar(
                StringParaBuffer(secao),
                StringParaBuffer(chave),
                StringParaBuffer(valor)
            );

            VerificarErro(resultado, $"Configurar {secao}.{chave}");
        }

        /// <summary>
        /// Ler propriedade da biblioteca
        /// </summary>
        /// <param name="secao">Nome da seção</param>
        /// <param name="chave">Nome da chave</param>
        /// <returns>Valor da propriedade</returns>
        public static string LerPropriedade(string secao, string chave)
        {
            return ExecutarComBuffer(
                (buffer, bufferSize) => ACBrLibMDFeNative.MDFe_ConfigLer(
                    StringParaBuffer(secao),
                    StringParaBuffer(chave),
                    buffer,
                    ref bufferSize
                ),
                $"Ler {secao}.{chave}"
            );
        }

        /// <summary>
        /// Obter versão da biblioteca
        /// </summary>
        /// <returns>Versão da biblioteca</returns>
        public static string ObterVersao()
        {
            return ExecutarComBuffer(
                (buffer, bufferSize) => ACBrLibMDFeNative.MDFe_Versao(buffer, ref bufferSize),
                "Obter versão"
            );
        }

        /// <summary>
        /// Obter nome da biblioteca
        /// </summary>
        /// <returns>Nome da biblioteca</returns>
        public static string ObterNome()
        {
            return ExecutarComBuffer(
                (buffer, bufferSize) => ACBrLibMDFeNative.MDFe_Nome(buffer, ref bufferSize),
                "Obter nome"
            );
        }
    }

    /// <summary>
    /// Exceção específica para erros da biblioteca ACBrLib
    /// </summary>
    public class ACBrLibException : Exception
    {
        public int CodigoErro { get; }

        public ACBrLibException(string message) : base(message)
        {
            CodigoErro = -1;
        }

        public ACBrLibException(string message, int codigoErro) : base(message)
        {
            CodigoErro = codigoErro;
        }

        public ACBrLibException(string message, Exception innerException) : base(message, innerException)
        {
            CodigoErro = -1;
        }

        public ACBrLibException(string message, int codigoErro, Exception innerException) : base(message, innerException)
        {
            CodigoErro = codigoErro;
        }
    }
}