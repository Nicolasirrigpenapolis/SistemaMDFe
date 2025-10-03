namespace MDFeApi.Utils
{
    /// <summary>
    /// Classe utilitária com códigos UF padrão IBGE para documentos fiscais eletrônicos
    /// </summary>
    public static class CodigosUF
    {
        /// <summary>
        /// Mapa de códigos UF conforme tabela IBGE
        /// Fonte: Manual de Orientações do Contribuinte - MDF-e
        /// </summary>
        public static readonly Dictionary<string, string> Codigos = new()
        {
            {"AC", "12"}, // Acre
            {"AL", "27"}, // Alagoas
            {"AP", "16"}, // Amapá
            {"AM", "13"}, // Amazonas
            {"BA", "29"}, // Bahia
            {"CE", "23"}, // Ceará
            {"DF", "53"}, // Distrito Federal
            {"ES", "32"}, // Espírito Santo
            {"GO", "52"}, // Goiás
            {"MA", "21"}, // Maranhão
            {"MT", "51"}, // Mato Grosso
            {"MS", "50"}, // Mato Grosso do Sul
            {"MG", "31"}, // Minas Gerais
            {"PA", "15"}, // Pará
            {"PB", "25"}, // Paraíba
            {"PR", "41"}, // Paraná
            {"PE", "26"}, // Pernambuco
            {"PI", "22"}, // Piauí
            {"RJ", "33"}, // Rio de Janeiro
            {"RN", "24"}, // Rio Grande do Norte
            {"RS", "43"}, // Rio Grande do Sul
            {"RO", "11"}, // Rondônia
            {"RR", "14"}, // Roraima
            {"SC", "42"}, // Santa Catarina
            {"SP", "35"}, // São Paulo
            {"SE", "28"}, // Sergipe
            {"TO", "17"}  // Tocantins
        };

        /// <summary>
        /// Obtém o código IBGE da UF
        /// </summary>
        /// <param name="uf">Sigla da UF (ex: "SP", "RS")</param>
        /// <param name="codigoPadrao">Código padrão caso UF não seja encontrada (padrão: "35" = SP)</param>
        /// <returns>Código IBGE da UF</returns>
        public static string ObterCodigo(string uf, string codigoPadrao = "35")
        {
            if (string.IsNullOrWhiteSpace(uf))
                return codigoPadrao;

            return Codigos.GetValueOrDefault(uf.ToUpper().Trim(), codigoPadrao);
        }

        /// <summary>
        /// Valida se a UF é válida
        /// </summary>
        public static bool IsValid(string uf)
        {
            return !string.IsNullOrWhiteSpace(uf) && Codigos.ContainsKey(uf.ToUpper().Trim());
        }

        /// <summary>
        /// Obtém a UF pelo código IBGE
        /// </summary>
        public static string? ObterUFPorCodigo(string codigo)
        {
            return Codigos.FirstOrDefault(x => x.Value == codigo).Key;
        }
    }
}
