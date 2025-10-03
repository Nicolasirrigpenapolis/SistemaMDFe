using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using MDFeApi.Extensions;

namespace MDFeApi.Models
{
    public class MDFe
    {
        public int Id { get; set; }

        public int EmitenteId { get; set; }
        public virtual Emitente Emitente { get; set; } = null!;

        // === DADOS DO EMITENTE (COPIADOS DA EMPRESA NO MOMENTO DA EMISSÃO) ===
        [MaxLength(14)]
        public string? EmitenteCnpj { get; set; }

        [MaxLength(11)]
        public string? EmitenteCpf { get; set; }

        [MaxLength(20)]
        public string? EmitenteIe { get; set; }

        [MaxLength(200)]
        public string? EmitenteRazaoSocial { get; set; }

        [MaxLength(200)]
        public string? EmitenteNomeFantasia { get; set; }

        [MaxLength(200)]
        public string? EmitenteEndereco { get; set; }

        [MaxLength(20)]
        public string? EmitenteNumero { get; set; }

        [MaxLength(200)]
        public string? EmitenteComplemento { get; set; }

        [MaxLength(100)]
        public string? EmitenteBairro { get; set; }

        public int? EmitenteCodMunicipio { get; set; }

        [MaxLength(100)]
        public string? EmitenteMunicipio { get; set; }

        [MaxLength(8)]
        public string? EmitenteCep { get; set; }

        [MaxLength(2)]
        public string? EmitenteUf { get; set; }


        [MaxLength(50)]
        public string? EmitenteTipoEmitente { get; set; }

        [MaxLength(20)]
        public string? EmitenteRntrc { get; set; }

        public int? CondutorId { get; set; }
        public virtual Condutor? Condutor { get; set; }

        // === DADOS DO CONDUTOR (COPIADOS NO MOMENTO DA EMISSÃO) ===
        [MaxLength(200)]
        public string? CondutorNome { get; set; }

        [MaxLength(11)]
        public string? CondutorCpf { get; set; }

        [MaxLength(20)]
        public string? CondutorTelefone { get; set; }

        public int? VeiculoId { get; set; }
        public virtual Veiculo? Veiculo { get; set; }

        // === DADOS DO VEÍCULO (COPIADOS NO MOMENTO DA EMISSÃO) ===
        [MaxLength(8)]
        public string? VeiculoPlaca { get; set; }


        public int? VeiculoTara { get; set; }


        [MaxLength(50)]
        public string? VeiculoTipoRodado { get; set; }

        [MaxLength(50)]
        public string? VeiculoTipoCarroceria { get; set; }

        [MaxLength(2)]
        public string? VeiculoUf { get; set; }




        public int? MunicipioCarregamentoId { get; set; }
        public virtual Municipio? MunicipioCarregamento { get; set; }

        public int Serie { get; set; }

        public int NumeroMdfe { get; set; }

        [MaxLength(44)]
        public string? ChaveAcesso { get; set; }

        // Código UF do emitente (obrigatório SEFAZ)
        [MaxLength(2)]
        public string? CodigoUf { get; set; }

        // Dígito verificador da chave de acesso (extraído da chave)
        [MaxLength(1)]
        public string? CodigoVerificador { get; set; }

        // Código numérico aleatório (usado na geração da chave)
        [MaxLength(8)]
        public string? CodigoNumericoAleatorio { get; set; }

        // Versão do modal (configurável via appsettings)
        [MaxLength(10)]
        public string VersaoModal { get; set; } = "3.00";

        [MaxLength(2)]
        public string? UfIni { get; set; }

        [MaxLength(2)]
        public string? UfFim { get; set; }

        public int Modal { get; set; } = 1; // 1 = Rodoviário

        public int TipoTransportador { get; set; } = 1; // 1 = ETC, 2 = TAC, 3 = CTC

        public DateTime DataEmissao { get; set; } = DateTime.Now;

        public DateTime? DataInicioViagem { get; set; }

        [Column(TypeName = "decimal(10,2)")]
        public decimal? ValorTotal { get; set; }

        public int? QuantidadeCTe { get; set; } // Calculado automaticamente

        public int? QuantidadeNFe { get; set; } // Calculado automaticamente

        public int? Lote { get; set; } = 1; // Número do lote de envio

        [MaxLength(2)]
        public string UnidadeMedida { get; set; } = "01"; // Fixo em '01' = Quilograma (padrão do sistema)

        [MaxLength(500)]
        public string? InfoAdicional { get; set; }

        [MaxLength(20)]
        public string StatusSefaz { get; set; } = "RASCUNHO";

        [MaxLength(20)]
        public string? Protocolo { get; set; }

        public DateTime? DataAutorizacao { get; set; }

        public string? XmlGerado { get; set; }

        public string? XmlRetorno { get; set; }

        public DateTime DataCriacao { get; set; } = DateTime.Now;

        public DateTime? DataUltimaAlteracao { get; set; }


        // Produto Predominante
        [MaxLength(2)]
        public string? TipoCarga { get; set; } // 01=Granel sólido, 02=Granel líquido, etc.

        [MaxLength(100)]
        public string? DescricaoProduto { get; set; }

        // CEP de Carregamento e Descarregamento
        [MaxLength(8)]
        public string? CepCarregamento { get; set; }

        [MaxLength(8)]
        public string? CepDescarregamento { get; set; }

        // Dados ANTT - Removidos campos duplicados (usar EmitenteRntrc e ContratanteCnpj)

        // Dados do Proprietário do Veículo (se diferente do emitente)
        public bool ProprietarioDiferente { get; set; } = false;

        [MaxLength(14)]
        public string? CnpjProprietario { get; set; }

        [MaxLength(11)]
        public string? CpfProprietario { get; set; }

        [MaxLength(200)]
        public string? NomeProprietario { get; set; }

        [MaxLength(20)]
        public string? IeProprietario { get; set; }

        [MaxLength(2)]
        public string? UfProprietario { get; set; }

        [MaxLength(20)]
        public string? RntrcProprietario { get; set; }

        // === DADOS DO CONTRATANTE (COPIADOS NO MOMENTO DA EMISSÃO) ===
        public int? ContratanteId { get; set; }
        public virtual Contratante? Contratante { get; set; }

        [MaxLength(14)]
        public string? ContratanteCnpj { get; set; }

        [MaxLength(11)]
        public string? ContratanteCpf { get; set; }

        [MaxLength(200)]
        public string? ContratanteRazaoSocial { get; set; }

        [MaxLength(200)]
        public string? ContratanteNomeFantasia { get; set; }

        [MaxLength(20)]
        public string? ContratanteIe { get; set; }

        [MaxLength(200)]
        public string? ContratanteEndereco { get; set; }

        [MaxLength(20)]
        public string? ContratanteNumero { get; set; }

        [MaxLength(200)]
        public string? ContratanteComplemento { get; set; }

        [MaxLength(100)]
        public string? ContratanteBairro { get; set; }

        public int? ContratanteCodMunicipio { get; set; }

        [MaxLength(100)]
        public string? ContratanteMunicipio { get; set; }

        [MaxLength(8)]
        public string? ContratanteCep { get; set; }

        [MaxLength(2)]
        public string? ContratanteUf { get; set; }


        // === DADOS DA SEGURADORA (COPIADOS NO MOMENTO DA EMISSÃO) ===
        public int? SeguradoraId { get; set; }
        public virtual Seguradora? Seguradora { get; set; }

        [MaxLength(1)]
        public string? TipoResponsavelSeguro { get; set; } // 1=Emitente, 2=Contratante, 3=Outros, 4=Destinatário, 5=Remetente

        [MaxLength(14)]
        public string? SeguradoraCnpj { get; set; }

        [MaxLength(200)]
        public string? SeguradoraRazaoSocial { get; set; }

        [MaxLength(200)]
        public string? SeguradoraNomeFantasia { get; set; }

        [MaxLength(200)]
        public string? SeguradoraEndereco { get; set; }

        [MaxLength(20)]
        public string? SeguradoraNumero { get; set; }

        [MaxLength(100)]
        public string? SeguradoraComplemento { get; set; }

        [MaxLength(100)]
        public string? SeguradoraBairro { get; set; }

        public int? SeguradoraCodMunicipio { get; set; }

        [MaxLength(100)]
        public string? SeguradoraMunicipio { get; set; }

        [MaxLength(8)]
        public string? SeguradoraCep { get; set; }

        [MaxLength(2)]
        public string? SeguradoraUf { get; set; }

        [MaxLength(15)]
        public string? SeguradoraTelefone { get; set; }

        [MaxLength(200)]
        public string? SeguradoraEmail { get; set; }


        [MaxLength(50)]
        public string? NumeroApoliceSeguro { get; set; }

        [MaxLength(50)]
        public string? NumeroAverbacaoSeguro { get; set; }

        // === COMPONENTES DE PAGAMENTO (JSON) ===
        [Column(TypeName = "nvarchar(max)")]
        public string? ComponentesPagamentoJson { get; set; }

        [Column(TypeName = "decimal(18,2)")]
        public decimal? ValorTotalContrato { get; set; }

        [MaxLength(1)]
        public string? TipoPagamento { get; set; } // 0=À vista, 1=Prazo, 2=Outros

        // === VALE PEDÁGIO ===
        [Column(TypeName = "nvarchar(max)")]
        public string? ValesPedagioJson { get; set; }

        public bool SemValePedagio { get; set; } = false;

        // Produto Predominante
        [MaxLength(200)]
        public string? ProdutoPredominante { get; set; }

        // Coordenadas GPS
        [Column(TypeName = "decimal(10,6)")]
        public decimal? LatitudeCarregamento { get; set; }

        [Column(TypeName = "decimal(10,6)")]
        public decimal? LongitudeCarregamento { get; set; }

        [Column(TypeName = "decimal(10,6)")]
        public decimal? LatitudeDescarregamento { get; set; }

        [Column(TypeName = "decimal(10,6)")]
        public decimal? LongitudeDescarregamento { get; set; }

        // Controle do Sistema
        public bool Transmitido { get; set; } = false;
        public bool Autorizado { get; set; } = false;
        public bool Encerrado { get; set; } = false;
        public bool Cancelado { get; set; } = false;

        [MaxLength(20)]
        public string? NumeroRecibo { get; set; }

        public DateTime? DataTransmissao { get; set; }
        public DateTime? DataEncerramento { get; set; }
        public DateTime? DataCancelamento { get; set; }
        
        public string? XmlAssinado { get; set; }
        public string? XmlAutorizado { get; set; }
        
        // Propriedades adicionais para compatibilidade
        public string? MunicipioIni { get; set; }
        public string? MunicipioFim { get; set; }
        public decimal? PesoBrutoTotal { get; set; }

        // === AUDITORIA E CONTROLE ===
        [MaxLength(200)]
        public string? UsuarioCriacao { get; set; }

        [MaxLength(200)]
        public string? UsuarioUltimaAlteracao { get; set; }

        [MaxLength(100)]
        public string? VersaoSistema { get; set; } = "1.0.0";

        [MaxLength(500)]
        public string? ObservacoesInternas { get; set; }

        // === LOCALIDADES E ROTA DE PERCURSO ===
        // JSON das localidades de carregamento
        [Column(TypeName = "nvarchar(max)")]
        public string? LocalidadesCarregamentoJson { get; set; }

        // JSON das localidades de descarregamento
        [Column(TypeName = "nvarchar(max)")]
        public string? LocalidadesDescarregamentoJson { get; set; }

        // JSON da rota de percurso
        [Column(TypeName = "nvarchar(max)")]
        public string? RotaPercursoJson { get; set; }

        // JSON dos documentos fiscais
        [Column(TypeName = "nvarchar(max)")]
        public string? DocumentosCTeJson { get; set; }

        [Column(TypeName = "nvarchar(max)")]
        public string? DocumentosNFeJson { get; set; }

        // === BACKUP DOS DADOS ORIGINAIS ===
        [Column(TypeName = "nvarchar(max)")]
        public string? DadosOriginaisJson { get; set; } // Backup dos dados originais dos cadastros

        // Propriedades adicionais (sem aliases confusos)
        [NotMapped]
        public bool Ativo { get; set; } = true;

        // Propriedades adicionais para compatibilidade
        public DateTime? DataGeracao { get; set; }

        [MaxLength(20)]
        public string? CodigoCIOT { get; set; }

        // Relacionamentos
        public virtual ICollection<MDFeReboque> Reboques { get; set; } = new List<MDFeReboque>();
        public virtual ICollection<MDFeCte> DocumentosCte { get; set; } = new List<MDFeCte>();
        public virtual ICollection<MDFeNfe> DocumentosNfe { get; set; } = new List<MDFeNfe>();
        public virtual ICollection<MDFeMdfeTransp> DocumentosMdfeTransp { get; set; } = new List<MDFeMdfeTransp>();
        public virtual ICollection<MDFeEvento> Eventos { get; set; } = new List<MDFeEvento>();
        public virtual ICollection<MDFeUfPercurso> UfsPercurso { get; set; } = new List<MDFeUfPercurso>();
        public virtual ICollection<MDFeLocalCarregamento> LocaisCarregamento { get; set; } = new List<MDFeLocalCarregamento>();
        public virtual ICollection<MDFeLocalDescarregamento> LocaisDescarregamento { get; set; } = new List<MDFeLocalDescarregamento>();
        public virtual ICollection<MDFeCondutor> CondutoresAdicionais { get; set; } = new List<MDFeCondutor>();
        public virtual ICollection<MDFeValePedagio> ValesPedagio { get; set; } = new List<MDFeValePedagio>();
        public virtual ICollection<MDFeLacreRodoviario> LacresRodoviarios { get; set; } = new List<MDFeLacreRodoviario>();

        // === ESTRUTURA COMPLETA DOS DOCUMENTOS FISCAIS ===

        // Unidades de Transporte (relacionadas aos documentos)
        public virtual ICollection<MDFeUnidadeTransporte> UnidadesTransporte { get; set; } = new List<MDFeUnidadeTransporte>();

        // Produtos Perigosos (relacionados aos documentos)
        public virtual ICollection<MDFeProdutoPerigoso> ProdutosPerigosos { get; set; } = new List<MDFeProdutoPerigoso>();

        // =====================================
        // PROPRIEDADES CALCULADAS (DDD)
        // =====================================

        /// <summary>
        /// Total de documentos (CTe + NFe) - cálculo simplificado
        /// </summary>
        [NotMapped]
        public int TotalDocumentos => LocaisCarregamento?.Count ?? 0;

        /// <summary>
        /// Indica se o MDFe pode ser editado
        /// </summary>
        [NotMapped]
        public bool PodeEditar => StatusSefaz == "RASCUNHO";

        /// <summary>
        /// Indica se o MDFe pode ser transmitido
        /// </summary>
        [NotMapped]
        public bool PodeTransmitir => StatusSefaz == "RASCUNHO" && TotalDocumentos > 0 && !string.IsNullOrEmpty(ChaveAcesso);

        /// <summary>
        /// Indica se o MDFe está autorizado
        /// </summary>
        [NotMapped]
        public bool EstaAutorizado => StatusSefaz == "AUTORIZADO";

        // =====================================
        // MÉTODOS DE NEGÓCIO (DDD)
        // =====================================

        /// <summary>
        /// Cria snapshots dos dados atuais das entidades relacionadas
        /// Implementa o conceito de Value Objects mantendo dados imutáveis
        /// </summary>
        public void CriarSnapshotsEntidades()
        {
            if (Emitente != null)
            {
                EmitenteCnpj = Emitente.Cnpj ?? "";
                EmitenteRazaoSocial = Emitente.RazaoSocial;
                EmitenteIe = Emitente.Ie;
                EmitenteNomeFantasia = Emitente.NomeFantasia;
                EmitenteEndereco = Emitente.Endereco;
                EmitenteNumero = Emitente.Numero;
                EmitenteBairro = Emitente.Bairro;
                EmitenteCodMunicipio = Emitente.CodMunicipio;
                EmitenteMunicipio = Emitente.Municipio;
                EmitenteUf = Emitente.Uf;
                EmitenteCep = Emitente.Cep;
            }

            if (Condutor != null)
            {
                CondutorNome = Condutor.Nome;
                CondutorCpf = Condutor.Cpf;
                CondutorTelefone = Condutor.Telefone;
            }

            if (Veiculo != null)
            {
                VeiculoPlaca = Veiculo.Placa;
                VeiculoTara = Veiculo.Tara;
                VeiculoUf = Veiculo.UfLicenciamento;
                // Valores padrão para campos não disponíveis no modelo atual
                VeiculoTipoRodado = "01"; // Truck
                VeiculoTipoCarroceria = "00"; // Não aplicável
            }
        }

        /// <summary>
        /// Gera próximo número do MDFe para um emitente específico
        /// Numeração inicia em 650
        /// </summary>
        public static int GerarProximoNumero(IEnumerable<MDFe> mdfesExistentes, int emitenteId, int serie = 1)
        {
            const int NUMERO_INICIAL = 650;

            var ultimoNumero = mdfesExistentes
                .Where(m => m.EmitenteId == emitenteId && m.Serie == serie)
                .MaxOrDefault(m => m.NumeroMdfe, 0);

            // Se não houver MDFes ainda, começar do número inicial (650)
            if (ultimoNumero == 0)
            {
                return NUMERO_INICIAL;
            }

            return ultimoNumero + 1;
        }

        /// <summary>
        /// Valida se o MDFe está pronto para transmissão
        /// </summary>
        public (bool IsValid, List<string> Errors) ValidarParaTransmissao()
        {
            var erros = new List<string>();

            // Validações de dados obrigatórios
            if (string.IsNullOrEmpty(EmitenteCnpj))
                erros.Add("CNPJ do emitente é obrigatório");

            if (string.IsNullOrEmpty(CondutorNome))
                erros.Add("Nome do condutor é obrigatório");

            if (string.IsNullOrEmpty(VeiculoPlaca))
                erros.Add("Placa do veículo é obrigatória");

            if (TotalDocumentos == 0)
                erros.Add("É necessário pelo menos um documento (CTe ou NFe)");

            if (PesoBrutoTotal <= 0)
                erros.Add("Peso bruto total deve ser maior que zero");

            if (string.IsNullOrEmpty(UfIni) || string.IsNullOrEmpty(UfFim))
                erros.Add("UF de início e fim são obrigatórias");

            if (string.IsNullOrEmpty(ChaveAcesso))
                erros.Add("Chave de acesso não foi gerada");

            return (!erros.Any(), erros);
        }

        /// <summary>
        /// Recalcula totais baseado nos documentos vinculados
        /// </summary>
        public void RecalcularTotais()
        {
            // Cálculo simplificado baseado nos locais de carregamento
            var totalLocais = LocaisCarregamento?.Count ?? 0;

            // Em produção, buscar valores reais dos documentos
            // Por enquanto, usar estimativa baseada na quantidade
            PesoBrutoTotal = totalLocais * 1000; // 1 tonelada por local
            ValorTotal = totalLocais * 10000; // R$ 10.000 por local

            DataUltimaAlteracao = DateTime.Now;
        }

        /// <summary>
        /// Gera chave de acesso do MDFe (implementação simplificada)
        /// </summary>
        public string GerarChaveAcesso()
        {
            // Usar dados do snapshot se disponíveis, senão usar da entidade relacionada
            var emitenteUf = !string.IsNullOrEmpty(EmitenteUf) ? EmitenteUf : (Emitente?.Uf ?? "");
            var emitenteCnpj = !string.IsNullOrEmpty(EmitenteCnpj) ? EmitenteCnpj : (Emitente?.Cnpj ?? "");

            if (string.IsNullOrEmpty(emitenteUf) || string.IsNullOrEmpty(emitenteCnpj))
                throw new InvalidOperationException("Dados do emitente são obrigatórios para gerar chave");

            var agora = DataEmissao;
            var codigoUf = ObterCodigoUfIBGE(emitenteUf);
            var ano = agora.ToString("yy");
            var mes = agora.ToString("MM");
            var cnpj = emitenteCnpj.PadLeft(14, '0');
            var modelo = "58"; // MDFe
            var serie = Serie.ToString().PadLeft(3, '0');
            var numero = NumeroMdfe.ToString().PadLeft(9, '0');
            var tipoEmissao = "1"; // Normal

            // Gerar código aleatório se não existir
            if (string.IsNullOrEmpty(CodigoNumericoAleatorio))
            {
                CodigoNumericoAleatorio = new Random().Next(10000000, 99999999).ToString();
            }

            var chaveSemDv = $"{codigoUf}{ano}{mes}{cnpj}{modelo}{serie}{numero}{tipoEmissao}{CodigoNumericoAleatorio}";

            // Calcular dígito verificador (implementação simplificada)
            var dv = CalcularDigitoVerificador(chaveSemDv);

            ChaveAcesso = chaveSemDv + dv;
            return ChaveAcesso;
        }

        /// <summary>
        /// Calcula dígito verificador da chave (implementação simplificada)
        /// </summary>
        private int CalcularDigitoVerificador(string chave)
        {
            // Implementação simplificada - em produção usar algoritmo módulo 11 oficial
            return chave.Sum(c => int.Parse(c.ToString())) % 10;
        }

        /// <summary>
        /// Obtém código IBGE da UF para usar na chave de acesso
        /// </summary>
        private string ObterCodigoUfIBGE(string uf)
        {
            var codigosUf = new Dictionary<string, string>
            {
                {"AC", "12"}, {"AL", "17"}, {"AP", "16"}, {"AM", "13"}, {"BA", "29"},
                {"CE", "23"}, {"DF", "53"}, {"ES", "32"}, {"GO", "52"}, {"MA", "21"},
                {"MT", "51"}, {"MS", "50"}, {"MG", "31"}, {"PA", "15"}, {"PB", "25"},
                {"PR", "41"}, {"PE", "26"}, {"PI", "22"}, {"RJ", "33"}, {"RN", "24"},
                {"RS", "43"}, {"RO", "11"}, {"RR", "14"}, {"SC", "42"}, {"SP", "35"},
                {"SE", "28"}, {"TO", "27"}
            };

            if (!codigosUf.TryGetValue(uf?.ToUpper() ?? "", out var codigo))
            {
                throw new InvalidOperationException($"UF '{uf}' não é válida para geração da chave de acesso");
            }

            return codigo;
        }

        // Entregas Parciais
        public virtual ICollection<MDFeEntregaParcial> EntregasParciais { get; set; } = new List<MDFeEntregaParcial>();
    }

    // Tabela de relacionamento MDFe <-> Reboque
    public class MDFeReboque
    {
        public int MDFeId { get; set; }
        public virtual MDFe MDFe { get; set; } = null!;

        public int ReboqueId { get; set; }
        public virtual Reboque Reboque { get; set; } = null!;

        public int Ordem { get; set; }
    }

    // Eventos do MDFe (cancelamento, encerramento, etc.)
    public class MDFeEvento
    {
        public int Id { get; set; }

        [Required]
        public int MDFeId { get; set; }
        public virtual MDFe MDFe { get; set; } = null!;

        [Required]
        [MaxLength(20)]
        public string TipoEvento { get; set; } = string.Empty; // CANCELAMENTO, ENCERRAMENTO

        [Required]
        [MaxLength(500)]
        public string Justificativa { get; set; } = string.Empty;

        [MaxLength(20)]
        public string? ProtocoloEvento { get; set; }

        [MaxLength(20)]
        public string Status { get; set; } = "PENDENTE";

        public DateTime DataEvento { get; set; } = DateTime.Now;

        public string? XmlEvento { get; set; }

        public string? XmlRetornoEvento { get; set; }
    }

    // UFs de percurso do MDFe
    public class MDFeUfPercurso
    {
        public int Id { get; set; }

        [Required]
        public int MDFeId { get; set; }
        public virtual MDFe MDFe { get; set; } = null!;

        [Required]
        [MaxLength(2)]
        public string Uf { get; set; } = string.Empty;

        public int Ordem { get; set; }
    }

    // Locais de carregamento do MDFe
    public class MDFeLocalCarregamento
    {
        public int Id { get; set; }

        [Required]
        public int MDFeId { get; set; }
        public virtual MDFe MDFe { get; set; } = null!;

        [Required]
        public int MunicipioId { get; set; }
        public virtual Municipio Municipio { get; set; } = null!;

        [MaxLength(100)]
        public string? DescricaoMunicipio { get; set; }

        public int Ordem { get; set; }
    }

    // Locais de descarregamento do MDFe
    public class MDFeLocalDescarregamento
    {
        public int Id { get; set; }

        [Required]
        public int MDFeId { get; set; }
        public virtual MDFe MDFe { get; set; } = null!;

        [Required]
        public int MunicipioId { get; set; }
        public virtual Municipio Municipio { get; set; } = null!;

        [MaxLength(100)]
        public string? DescricaoMunicipio { get; set; }

        public int Ordem { get; set; }
    }

    // Condutores adicionais do MDFe (além do principal)
    public class MDFeCondutor
    {
        public int Id { get; set; }

        [Required]
        public int MDFeId { get; set; }
        public virtual MDFe MDFe { get; set; } = null!;

        [Required]
        [MaxLength(200)]
        public string NomeCondutor { get; set; } = string.Empty;

        [Required]
        [MaxLength(11)]
        public string CpfCondutor { get; set; } = string.Empty;

        public int Ordem { get; set; }
    }

    // Vale-pedágio vinculado ao MDFe
    public class MDFeValePedagio
    {
        public int Id { get; set; }

        [Required]
        public int MDFeId { get; set; }
        public virtual MDFe MDFe { get; set; } = null!;

        [Required]
        [MaxLength(14)]
        public string CnpjFornecedor { get; set; } = string.Empty;

        [Required]
        [MaxLength(20)]
        public string NumeroCompra { get; set; } = string.Empty;

        [Required]
        [Column(TypeName = "decimal(10,2)")]
        public decimal ValorVale { get; set; }

        [Required]
        [MaxLength(2)]
        public string TipoVale { get; set; } = "01"; // 01-Fornecedor, 02-Posto, 03-Rede

        [MaxLength(200)]
        public string? NomeFornecedor { get; set; }

        public DateTime DataCriacao { get; set; } = DateTime.Now;

        public int Ordem { get; set; }
    }

    // Lacres rodoviários do MDFe
    public class MDFeLacreRodoviario
    {
        public int Id { get; set; }

        [Required]
        public int MDFeId { get; set; }
        public virtual MDFe MDFe { get; set; } = null!;

        [Required]
        [MaxLength(20)]
        public string NumeroLacre { get; set; } = string.Empty;

        public int Ordem { get; set; }

        public DateTime DataCriacao { get; set; } = DateTime.Now;
    }

    // Unidades de transporte para documentos fiscais
    public class MDFeUnidadeTransporte
    {
        public int Id { get; set; }

        [Required]
        public int MDFeId { get; set; }
        public virtual MDFe MDFe { get; set; } = null!;

        [Required]
        [MaxLength(1)]
        public string TipoUnidadeTransporte { get; set; } = string.Empty; // 1-Rodoviário Tração, 2-Rodoviário Reboque, etc.

        [MaxLength(20)]
        public string? CodigoInterno { get; set; }

        [MaxLength(8)]
        public string? Placa { get; set; }

        [Column(TypeName = "decimal(10,3)")]
        public decimal? Tara { get; set; }

        [Column(TypeName = "decimal(10,3)")]
        public decimal? CapacidadeKg { get; set; }

        [Column(TypeName = "decimal(10,3)")]
        public decimal? CapacidadeM3 { get; set; }

        [MaxLength(2)]
        public string? TipoRodado { get; set; }

        [MaxLength(2)]
        public string? TipoCarroceria { get; set; }

        [MaxLength(2)]
        public string? Uf { get; set; }

        public int Ordem { get; set; }

        // Propriedades adicionais para compatibilidade
        [MaxLength(50)]
        public string? IdentificacaoUnidadeTransporte { get; set; }

        [Column(TypeName = "decimal(10,3)")]
        public decimal? QuantidadeRateada { get; set; }

        // Relacionamentos com documentos
        public int? MDFeCteId { get; set; }
        public virtual MDFeCte? MDFeCte { get; set; }

        public int? MDFeNfeId { get; set; }
        public virtual MDFeNfe? MDFeNfe { get; set; }

        public int? MDFeMdfeTranspId { get; set; }
        public virtual MDFeMdfeTransp? MDFeMdfeTransp { get; set; }

        // Relacionamentos com unidades de carga e lacres
        public virtual ICollection<MDFeUnidadeCarga>? UnidadesCarga { get; set; } = new List<MDFeUnidadeCarga>();
        public virtual ICollection<MDFeLacreUnidadeTransporte>? Lacres { get; set; } = new List<MDFeLacreUnidadeTransporte>();
    }

    // Produtos perigosos transportados
    public class MDFeProdutoPerigoso
    {
        public int Id { get; set; }

        [Required]
        public int MDFeId { get; set; }
        public virtual MDFe MDFe { get; set; } = null!;

        [Required]
        [MaxLength(4)]
        public string NumeroONU { get; set; } = string.Empty;

        [Required]
        [MaxLength(150)]
        public string NomeEmbarque { get; set; } = string.Empty;

        [Required]
        [MaxLength(1)]
        public string ClasseRisco { get; set; } = string.Empty;

        [MaxLength(3)]
        public string? GrupoEmbalagem { get; set; }

        [Column(TypeName = "decimal(12,4)")]
        public decimal QuantidadeTotal { get; set; }

        [Required]
        [MaxLength(2)]
        public string UnidadeMedida { get; set; } = "01"; // Fixo em '01' = Quilograma (padrão do sistema)

        [MaxLength(200)]
        public string? Observacoes { get; set; }

        public int Ordem { get; set; }

        // Propriedades adicionais para compatibilidade

        [MaxLength(150)]
        public string? NomeApropriado { get; set; }

        [MaxLength(20)]
        public string? QuantidadeTotalProduto { get; set; }

        [MaxLength(10)]
        public string? QuantidadeVolumoTipo { get; set; }

        // Relacionamentos com documentos
        public int? MDFeCteId { get; set; }
        public virtual MDFeCte? MDFeCte { get; set; }

        public int? MDFeNfeId { get; set; }
        public virtual MDFeNfe? MDFeNfe { get; set; }

        public int? MDFeMdfeTranspId { get; set; }
        public virtual MDFeMdfeTransp? MDFeMdfeTransp { get; set; }
    }

    // Entregas parciais
    public class MDFeEntregaParcial
    {
        public int Id { get; set; }

        [Required]
        public int MDFeId { get; set; }
        public virtual MDFe MDFe { get; set; } = null!;

        [Column(TypeName = "decimal(12,4)")]
        public decimal QuantidadeParcial { get; set; }

        [Required]
        [MaxLength(200)]
        public string DescricaoEntrega { get; set; } = string.Empty;

        public DateTime DataEntrega { get; set; }

        [MaxLength(100)]
        public string? LocalEntrega { get; set; }

        public int Ordem { get; set; }

        // Propriedades adicionais para compatibilidade
        [Column(TypeName = "decimal(12,4)")]
        public decimal? QuantidadeTotal { get; set; }

        // Relacionamentos com documentos
        public int? MDFeCteId { get; set; }
        public virtual MDFeCte? MDFeCte { get; set; }

        public int? MDFeNfeId { get; set; }
        public virtual MDFeNfe? MDFeNfe { get; set; }

        public int? MDFeMdfeTranspId { get; set; }
        public virtual MDFeMdfeTransp? MDFeMdfeTransp { get; set; }
    }

    // === MODELS DE DOCUMENTOS FISCAIS ===

    // Classe básica para CT-e vinculado ao MDFe (simplificada)
    public class MDFeCte
    {
        public int Id { get; set; }

        [Required]
        public int MDFeId { get; set; }
        public virtual MDFe MDFe { get; set; } = null!;

        [Required]
        [MaxLength(44)]
        public string ChaveCte { get; set; } = string.Empty;

        [MaxLength(3)]
        public string? SegCodigoBarras { get; set; }

        [MaxLength(3)]
        public string? SegundoCodigoBarras { get; set; }

        [MaxLength(3)]
        public string? IndReentrega { get; set; }

        public int? MunicipioDescargaId { get; set; }
        public virtual Municipio? MunicipioDescarga { get; set; }

        [Column(TypeName = "decimal(10,2)")]
        public decimal? ValorTotal { get; set; }

        [Column(TypeName = "decimal(10,3)")]
        public decimal? PesoBruto { get; set; }

        public DateTime DataCriacao { get; set; } = DateTime.Now;
        public int Ordem { get; set; }
    }

    // Classe básica para NF-e vinculada ao MDFe (simplificada)
    public class MDFeNfe
    {
        public int Id { get; set; }

        [Required]
        public int MDFeId { get; set; }
        public virtual MDFe MDFe { get; set; } = null!;

        [Required]
        [MaxLength(44)]
        public string ChaveNfe { get; set; } = string.Empty;

        [MaxLength(3)]
        public string? SegCodigoBarras { get; set; }

        [MaxLength(3)]
        public string? SegundoCodigoBarras { get; set; }

        [MaxLength(20)]
        public string? PinSuframa { get; set; }

        [MaxLength(3)]
        public string? IndReentrega { get; set; }

        public int? MunicipioDescargaId { get; set; }
        public virtual Municipio? MunicipioDescarga { get; set; }

        [Column(TypeName = "decimal(10,2)")]
        public decimal? ValorTotal { get; set; }

        [Column(TypeName = "decimal(10,3)")]
        public decimal? PesoBruto { get; set; }

        public DateTime DataCriacao { get; set; } = DateTime.Now;
        public int Ordem { get; set; }
    }

    // Classe básica para MDFe de transporte (simplificada)
    public class MDFeMdfeTransp
    {
        public int Id { get; set; }

        [Required]
        public int MDFeId { get; set; }
        public virtual MDFe MDFe { get; set; } = null!;

        [Required]
        [MaxLength(44)]
        public string ChaveMdfeTransp { get; set; } = string.Empty;

        [MaxLength(3)]
        public string? IndReentrega { get; set; }

        public int? MunicipioDescargaId { get; set; }
        public virtual Municipio? MunicipioDescarga { get; set; }

        [Column(TypeName = "decimal(18,3)")]
        public decimal? QuantidadeRateada { get; set; }

        public DateTime DataCriacao { get; set; } = DateTime.Now;
        public int Ordem { get; set; }
    }

    // Classe para unidade de carga do MDFe
    public class MDFeUnidadeCarga
    {
        public int Id { get; set; }

        [Required]
        public int MDFeId { get; set; }
        public virtual MDFe MDFe { get; set; } = null!;

        [Required]
        [MaxLength(1)]
        public string TipoUnidadeCarga { get; set; } = string.Empty;

        [MaxLength(50)]
        public string? IdUnidadeCarga { get; set; }

        [Column(TypeName = "decimal(18,3)")]
        public decimal? QtdRat { get; set; }

        public DateTime DataCriacao { get; set; } = DateTime.Now;
        public int Ordem { get; set; }

        public virtual ICollection<MDFeLacreUnidadeCarga> LacresUnidadeCarga { get; set; } = new List<MDFeLacreUnidadeCarga>();
    }

    // Classe para lacre de unidade de transporte
    public class MDFeLacreUnidadeTransporte
    {
        public int Id { get; set; }

        [Required]
        public int MDFeId { get; set; }
        public virtual MDFe MDFe { get; set; } = null!;

        [Required]
        [MaxLength(20)]
        public string NumeroLacre { get; set; } = string.Empty;

        public DateTime DataCriacao { get; set; } = DateTime.Now;
        public int Ordem { get; set; }
    }

    // Classe para lacre de unidade de carga
    public class MDFeLacreUnidadeCarga
    {
        public int Id { get; set; }

        [Required]
        public int UnidadeCargaId { get; set; }
        public virtual MDFeUnidadeCarga UnidadeCarga { get; set; } = null!;

        [Required]
        [MaxLength(20)]
        public string NumeroLacre { get; set; } = string.Empty;

        public DateTime DataCriacao { get; set; } = DateTime.Now;
        public int Ordem { get; set; }
    }

    // Classe para prestação parcial de NFe
    public class MDFeNfePrestacaoParcial
    {
        public int Id { get; set; }

        [Required]
        public int NFeId { get; set; }
        public virtual MDFeNfe NFe { get; set; } = null!;

        [Column(TypeName = "decimal(15,2)")]
        public decimal? QtdeParcial { get; set; }

        [MaxLength(15)]
        public string? DenominacaoMercadoria { get; set; }

        public DateTime DataCriacao { get; set; } = DateTime.Now;
        public int Ordem { get; set; }
    }

}