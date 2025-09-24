using System.Text.RegularExpressions;

namespace MDFeApi.Utils
{
    public static class DocumentUtils
    {
        /// <summary>
        /// Remove formatação do CNPJ, mantendo apenas números
        /// </summary>
        /// <param name="cnpj">CNPJ formatado (ex: 12.345.678/0001-90)</param>
        /// <returns>CNPJ limpo (ex: 12345678000190)</returns>
        public static string? LimparCnpj(string? cnpj)
        {
            if (string.IsNullOrWhiteSpace(cnpj))
                return null;

            // Remove tudo que não for dígito
            return Regex.Replace(cnpj, @"[^\d]", "");
        }

        /// <summary>
        /// Remove formatação do CPF, mantendo apenas números
        /// </summary>
        /// <param name="cpf">CPF formatado (ex: 123.456.789-10)</param>
        /// <returns>CPF limpo (ex: 12345678910)</returns>
        public static string? LimparCpf(string? cpf)
        {
            if (string.IsNullOrWhiteSpace(cpf))
                return null;

            // Remove tudo que não for dígito
            return Regex.Replace(cpf, @"[^\d]", "");
        }

        /// <summary>
        /// Remove formatação do CEP, mantendo apenas números
        /// </summary>
        /// <param name="cep">CEP formatado (ex: 12345-678)</param>
        /// <returns>CEP limpo (ex: 12345678)</returns>
        public static string? LimparCep(string? cep)
        {
            if (string.IsNullOrWhiteSpace(cep))
                return null;

            // Remove tudo que não for dígito
            return Regex.Replace(cep, @"[^\d]", "");
        }

        /// <summary>
        /// Remove formatação do telefone, mantendo apenas números
        /// </summary>
        /// <param name="telefone">Telefone formatado (ex: (11) 99999-9999)</param>
        /// <returns>Telefone limpo (ex: 11999999999)</returns>
        public static string? LimparTelefone(string? telefone)
        {
            if (string.IsNullOrWhiteSpace(telefone))
                return null;

            // Remove tudo que não for dígito
            return Regex.Replace(telefone, @"[^\d]", "");
        }

        /// <summary>
        /// Valida se CNPJ tem 14 dígitos
        /// </summary>
        /// <param name="cnpj">CNPJ limpo</param>
        /// <returns>True se válido</returns>
        public static bool ValidarTamanhoCnpj(string? cnpj)
        {
            return !string.IsNullOrWhiteSpace(cnpj) && cnpj.Length == 14;
        }

        /// <summary>
        /// Valida se CPF tem 11 dígitos
        /// </summary>
        /// <param name="cpf">CPF limpo</param>
        /// <returns>True se válido</returns>
        public static bool ValidarTamanhoCpf(string? cpf)
        {
            return !string.IsNullOrWhiteSpace(cpf) && cpf.Length == 11;
        }

        /// <summary>
        /// Aplica limpeza em uma entidade Emitente
        /// </summary>
        /// <param name="emitente">Entidade Emitente</param>
        public static void LimparDocumentosEmitente(Models.Emitente emitente)
        {
            if (emitente == null) return;

            emitente.Cnpj = LimparCnpj(emitente.Cnpj);
            emitente.Cpf = LimparCpf(emitente.Cpf);
            emitente.Cep = LimparCep(emitente.Cep) ?? string.Empty;
        }
    }
}