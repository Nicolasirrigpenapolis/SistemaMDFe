namespace MDFeApi.Utils
{
    /// <summary>
    /// Validador para chaves de acesso de documentos fiscais (NFe, CTe, MDFe)
    /// </summary>
    public static class ValidadorChaveNFe
    {
        /// <summary>
        /// Valida chave de acesso de documento fiscal (NFe, CTe, MDFe)
        /// Estrutura: 44 dígitos com dígito verificador no final
        /// </summary>
        public static bool ValidarChave(string? chave)
        {
            if (string.IsNullOrWhiteSpace(chave))
                return false;

            // Remove espaços e caracteres não numéricos
            chave = new string(chave.Where(char.IsDigit).ToArray());

            // Chave deve ter 44 dígitos
            if (chave.Length != 44)
                return false;

            // Extrai os 43 primeiros dígitos (sem o DV)
            var chaveSemDv = chave.Substring(0, 43);
            var dvInformado = int.Parse(chave[43].ToString());

            // Calcula o dígito verificador
            var dvCalculado = CalcularDigitoVerificador(chaveSemDv);

            return dvInformado == dvCalculado;
        }

        /// <summary>
        /// Calcula o dígito verificador da chave de acesso usando Módulo 11
        /// </summary>
        private static int CalcularDigitoVerificador(string chave)
        {
            if (string.IsNullOrWhiteSpace(chave) || chave.Length != 43)
                throw new ArgumentException("Chave deve ter 43 dígitos para cálculo do DV");

            // Multiplicadores do Módulo 11 (2 a 9, repetindo)
            int[] multiplicadores = { 2, 3, 4, 5, 6, 7, 8, 9 };
            int soma = 0;
            int posMultiplicador = 0;

            // Percorre a chave de trás para frente
            for (int i = chave.Length - 1; i >= 0; i--)
            {
                int digito = int.Parse(chave[i].ToString());
                soma += digito * multiplicadores[posMultiplicador];

                posMultiplicador++;
                if (posMultiplicador >= multiplicadores.Length)
                    posMultiplicador = 0;
            }

            int resto = soma % 11;

            // Se resto for 0 ou 1, DV = 0, caso contrário DV = 11 - resto
            return resto < 2 ? 0 : 11 - resto;
        }

        /// <summary>
        /// Valida estrutura da chave de CTe (modelo 57)
        /// </summary>
        public static bool ValidarChaveCTe(string? chave)
        {
            if (!ValidarChave(chave))
                return false;

            // Verifica se é modelo 57 (CTe)
            var modelo = chave!.Substring(20, 2);
            return modelo == "57";
        }

        /// <summary>
        /// Valida estrutura da chave de NFe (modelo 55)
        /// </summary>
        public static bool ValidarChaveNFe(string? chave)
        {
            if (!ValidarChave(chave))
                return false;

            // Verifica se é modelo 55 (NFe)
            var modelo = chave!.Substring(20, 2);
            return modelo == "55";
        }

        /// <summary>
        /// Valida estrutura da chave de MDFe (modelo 58)
        /// </summary>
        public static bool ValidarChaveMDFe(string? chave)
        {
            if (!ValidarChave(chave))
                return false;

            // Verifica se é modelo 58 (MDFe)
            var modelo = chave!.Substring(20, 2);
            return modelo == "58";
        }

        /// <summary>
        /// Extrai informações da chave de acesso
        /// </summary>
        public static ChaveInfo? ExtrairInformacoes(string? chave)
        {
            if (!ValidarChave(chave))
                return null;

            chave = new string(chave!.Where(char.IsDigit).ToArray());

            return new ChaveInfo
            {
                CodigoUF = chave.Substring(0, 2),
                AnoMes = chave.Substring(2, 4),
                CNPJ = chave.Substring(6, 14),
                Modelo = chave.Substring(20, 2),
                Serie = chave.Substring(22, 3),
                Numero = chave.Substring(25, 9),
                TipoEmissao = chave.Substring(34, 1),
                CodigoNumerico = chave.Substring(35, 8),
                DigitoVerificador = chave.Substring(43, 1)
            };
        }

        /// <summary>
        /// Formata chave de acesso para exibição (grupos de 4 dígitos)
        /// </summary>
        public static string FormatarChave(string? chave)
        {
            if (string.IsNullOrWhiteSpace(chave))
                return string.Empty;

            chave = new string(chave.Where(char.IsDigit).ToArray());

            if (chave.Length != 44)
                return chave;

            // Formata: 9999 9999 9999 9999 9999 9999 9999 9999 9999 9999 9999
            var grupos = new List<string>();
            for (int i = 0; i < chave.Length; i += 4)
            {
                grupos.Add(chave.Substring(i, Math.Min(4, chave.Length - i)));
            }

            return string.Join(" ", grupos);
        }

        /// <summary>
        /// Remove formatação da chave (retorna apenas números)
        /// </summary>
        public static string RemoverFormatacao(string? chave)
        {
            if (string.IsNullOrWhiteSpace(chave))
                return string.Empty;

            return new string(chave.Where(char.IsDigit).ToArray());
        }
    }

    /// <summary>
    /// Informações extraídas de uma chave de acesso
    /// </summary>
    public class ChaveInfo
    {
        public string CodigoUF { get; set; } = string.Empty;
        public string AnoMes { get; set; } = string.Empty;
        public string CNPJ { get; set; } = string.Empty;
        public string Modelo { get; set; } = string.Empty;
        public string Serie { get; set; } = string.Empty;
        public string Numero { get; set; } = string.Empty;
        public string TipoEmissao { get; set; } = string.Empty;
        public string CodigoNumerico { get; set; } = string.Empty;
        public string DigitoVerificador { get; set; } = string.Empty;

        public string ModeloDescricao => Modelo switch
        {
            "55" => "NF-e",
            "57" => "CT-e",
            "58" => "MDF-e",
            _ => "Desconhecido"
        };
    }
}
