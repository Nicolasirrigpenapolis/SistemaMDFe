using System.Collections.Generic;

namespace MDFeApi.Services
{
    /// <summary>
    /// Serviço para mapeamento de códigos e descrições da SEFAZ
    /// Baseado na documentação oficial do MDF-e
    /// </summary>
    public interface ISefazMappingService
    {
        Dictionary<string, string> GetCodigosUF();
        Dictionary<string, string> GetTiposAmbiente();
        Dictionary<string, string> GetTiposEmissao();
        Dictionary<string, string> GetTiposTransportador();
        Dictionary<string, string> GetStatusMDFe();
        Dictionary<string, string> GetTiposModal();
        Dictionary<string, string> GetTiposVeiculo();
        string GetDescricaoStatusMDFe(string codigo);
        string GetDescricaoUF(string codigo);
    }

    public class SefazMappingService : ISefazMappingService
    {
        private readonly Dictionary<string, string> _codigosUF;
        private readonly Dictionary<string, string> _tiposAmbiente;
        private readonly Dictionary<string, string> _tiposEmissao;
        private readonly Dictionary<string, string> _tiposTransportador;
        private readonly Dictionary<string, string> _statusMDFe;
        private readonly Dictionary<string, string> _tiposModal;
        private readonly Dictionary<string, string> _tiposVeiculo;

        public SefazMappingService()
        {
            _codigosUF = InitializeCodigosUF();
            _tiposAmbiente = InitializeTiposAmbiente();
            _tiposEmissao = InitializeTiposEmissao();
            _tiposTransportador = InitializeTiposTransportador();
            _statusMDFe = InitializeStatusMDFe();
            _tiposModal = InitializeTiposModal();
            _tiposVeiculo = InitializeTiposVeiculo();
        }

        public Dictionary<string, string> GetCodigosUF() => _codigosUF;
        public Dictionary<string, string> GetTiposAmbiente() => _tiposAmbiente;
        public Dictionary<string, string> GetTiposEmissao() => _tiposEmissao;
        public Dictionary<string, string> GetTiposTransportador() => _tiposTransportador;
        public Dictionary<string, string> GetStatusMDFe() => _statusMDFe;
        public Dictionary<string, string> GetTiposModal() => _tiposModal;
        public Dictionary<string, string> GetTiposVeiculo() => _tiposVeiculo;

        public string GetDescricaoStatusMDFe(string codigo)
        {
            return _statusMDFe.TryGetValue(codigo, out var descricao) ? descricao : $"Status {codigo}";
        }

        public string GetDescricaoUF(string codigo)
        {
            return _codigosUF.TryGetValue(codigo, out var uf) ? uf : $"UF {codigo}";
        }

        private Dictionary<string, string> InitializeCodigosUF()
        {
            return new Dictionary<string, string>
            {
                { "12", "AC" }, { "17", "AL" }, { "16", "AP" }, { "13", "AM" },
                { "29", "BA" }, { "23", "CE" }, { "53", "DF" }, { "32", "ES" },
                { "52", "GO" }, { "21", "MA" }, { "51", "MT" }, { "50", "MS" },
                { "31", "MG" }, { "15", "PA" }, { "25", "PB" }, { "41", "PR" },
                { "26", "PE" }, { "22", "PI" }, { "33", "RJ" }, { "24", "RN" },
                { "43", "RS" }, { "11", "RO" }, { "14", "RR" }, { "42", "SC" },
                { "35", "SP" }, { "28", "SE" }, { "27", "TO" }
            };
        }

        private Dictionary<string, string> InitializeTiposAmbiente()
        {
            return new Dictionary<string, string>
            {
                { "1", "Produção" },
                { "2", "Homologação" }
            };
        }

        private Dictionary<string, string> InitializeTiposEmissao()
        {
            return new Dictionary<string, string>
            {
                { "1", "Normal" },
                { "2", "Contingência" }
            };
        }

        private Dictionary<string, string> InitializeTiposTransportador()
        {
            return new Dictionary<string, string>
            {
                { "1", "ETC - Empresa de Transporte de Carga" },
                { "2", "TAC - Transportador Autônomo de Carga" },
                { "3", "CTC - Cooperativa de Transporte de Carga" }
            };
        }

        private Dictionary<string, string> InitializeStatusMDFe()
        {
            return new Dictionary<string, string>
            {
                // Status internos do sistema
                { "RASCUNHO", "Rascunho - Em elaboração" },
                { "ASSINADO", "Assinado digitalmente" },
                { "VALIDADO", "Validado pelo schema" },
                { "TRANSMITIDO", "Transmitido para SEFAZ" },

                // Status de lote SEFAZ
                { "103", "Lote recebido com sucesso" },
                { "104", "Lote processado" },
                { "105", "Lote em processamento" },
                { "LOTE_RECEBIDO", "Lote recebido com sucesso" },
                { "LOTE_PROCESSADO", "Lote processado" },
                { "LOTE_EM_PROCESSAMENTO", "Lote em processamento" },

                // Status de autorização
                { "100", "Autorizado o uso do MDF-e" },
                { "AUTORIZADO", "Autorizado o uso do MDF-e" },

                // Status de rejeição
                { "110", "Uso Denegado" },
                { "301", "Uso Denegado - Irregularidade fiscal do emitente" },
                { "302", "Uso Denegado - Irregularidade fiscal do destinatário" },
                { "303", "Uso Denegado - Destinatário não habilitado a operar na UF" },
                { "REJEITADO", "Rejeitado pela SEFAZ" },
                { "DENEGADO", "Uso denegado" },

                // Status de eventos
                { "135", "Evento registrado e vinculado ao MDF-e" },
                { "136", "Evento registrado, mas não vinculado ao MDF-e" },
                { "CANCELADO", "Cancelado" },
                { "ENCERRADO", "Encerrado" },

                // Status de erro
                { "ERRO_SCHEMA", "Erro de validação do schema" },
                { "ERRO_ASSINATURA", "Erro na assinatura digital" },
                { "ERRO_TRANSMISSAO", "Erro na transmissão" },
                { "ERRO_CERTIFICADO", "Erro no certificado digital" },

                // Códigos de erro comuns
                { "215", "MDF-e não encontrado" },
                { "216", "MDF-e não consta na base de dados da SEFAZ" },
                { "217", "MDF-e cancelado" },
                { "218", "MDF-e encerrado" },
                { "219", "MDF-e com falha de schema XML" },
                { "225", "Falha no schema XML do MDF-e" },

                // Status de processamento
                { "PROCESSANDO", "Processando na SEFAZ" },
                { "AGUARDANDO_PROTOCOLO", "Aguardando protocolo de autorização" },
                { "ERRO_CONSULTA", "Erro na consulta" },
                { "SEM_RETORNO", "Sem retorno da SEFAZ" }
            };
        }

        private Dictionary<string, string> InitializeTiposModal()
        {
            return new Dictionary<string, string>
            {
                { "1", "Rodoviário" },
                { "2", "Aéreo" },
                { "3", "Aquaviário" },
                { "4", "Ferroviário" },
                { "5", "Dutoviário" }
            };
        }

        private Dictionary<string, string> InitializeTiposVeiculo()
        {
            return new Dictionary<string, string>
            {
                // Tipos de rodado
                { "01", "Truck" },
                { "02", "Toco" },
                { "03", "Cavalo Mecânico" },
                { "04", "VAN" },
                { "05", "Utilitário" },
                { "06", "Outros" },

                // Tipos de carroceria
                { "00", "Não aplicável" },
                { "01", "Aberta" },
                { "02", "Fechada/Baú" },
                { "03", "Graneleira" },
                { "04", "Porta Container" },
                { "05", "Sider" },
                { "06", "Outros" }
            };
        }
    }

    /// <summary>
    /// Códigos de resposta específicos do MDF-e conforme Manual de Integração
    /// </summary>
    public static class CodigosMDFe
    {
        // Códigos de status de lote
        public const string LOTE_RECEBIDO = "103";
        public const string LOTE_PROCESSADO = "104";
        public const string LOTE_EM_PROCESSAMENTO = "105";

        // Códigos de autorização
        public const string AUTORIZADO = "100";
        public const string USO_DENEGADO = "110";
        public const string USO_DENEGADO_EMITENTE = "301";
        public const string USO_DENEGADO_DESTINATARIO = "302";
        public const string USO_DENEGADO_UF = "303";

        // Códigos de evento
        public const string EVENTO_VINCULADO = "135";
        public const string EVENTO_NAO_VINCULADO = "136";

        // Códigos de erro
        public const string MDFE_NAO_ENCONTRADO = "215";
        public const string MDFE_NAO_CONSTA_BASE = "216";
        public const string MDFE_CANCELADO = "217";
        public const string MDFE_ENCERRADO = "218";
        public const string FALHA_SCHEMA = "219";
        public const string SCHEMA_INVALIDO = "225";
    }

    /// <summary>
    /// Utilitários para trabalhar com códigos MDF-e
    /// </summary>
    public static class MDFeUtils
    {
        /// <summary>
        /// Verificar se o código indica sucesso na autorização
        /// </summary>
        public static bool IsAutorizado(string codigo)
        {
            return codigo == CodigosMDFe.AUTORIZADO;
        }

        /// <summary>
        /// Verificar se o código indica que o lote foi recebido
        /// </summary>
        public static bool IsLoteRecebido(string codigo)
        {
            return codigo == CodigosMDFe.LOTE_RECEBIDO;
        }

        /// <summary>
        /// Verificar se o código indica que o evento foi registrado
        /// </summary>
        public static bool IsEventoRegistrado(string codigo)
        {
            return codigo == CodigosMDFe.EVENTO_VINCULADO || codigo == CodigosMDFe.EVENTO_NAO_VINCULADO;
        }

        /// <summary>
        /// Verificar se o código indica erro
        /// </summary>
        public static bool IsErro(string codigo)
        {
            if (string.IsNullOrEmpty(codigo)) return true;

            var codigoInt = int.TryParse(codigo, out var result) ? result : 0;

            // Códigos de erro geralmente são >= 400 ou códigos específicos de rejeição
            return codigoInt >= 400 ||
                   codigo == CodigosMDFe.USO_DENEGADO ||
                   codigo == CodigosMDFe.USO_DENEGADO_EMITENTE ||
                   codigo == CodigosMDFe.USO_DENEGADO_DESTINATARIO ||
                   codigo == CodigosMDFe.USO_DENEGADO_UF ||
                   codigo == CodigosMDFe.FALHA_SCHEMA ||
                   codigo == CodigosMDFe.SCHEMA_INVALIDO;
        }
    }
}