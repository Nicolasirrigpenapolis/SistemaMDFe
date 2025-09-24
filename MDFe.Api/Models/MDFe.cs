using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MDFeApi.Models
{
    public class MDFe
    {
        public int Id { get; set; }

        [Required]
        public int EmitenteId { get; set; }
        public virtual Emitente Emitente { get; set; } = null!;

        // === DADOS DO EMITENTE (COPIADOS DA EMPRESA NO MOMENTO DA EMISSÃO) ===
        [Required]
        [MaxLength(14)]
        public string EmitenteCnpj { get; set; } = string.Empty;

        [MaxLength(11)]
        public string? EmitenteCpf { get; set; }

        [MaxLength(20)]
        public string? EmitenteIe { get; set; }

        [Required]
        [MaxLength(200)]
        public string EmitenteRazaoSocial { get; set; } = string.Empty;

        [MaxLength(200)]
        public string? EmitenteNomeFantasia { get; set; }

        [Required]
        [MaxLength(200)]
        public string EmitenteEndereco { get; set; } = string.Empty;

        [MaxLength(20)]
        public string? EmitenteNumero { get; set; }

        [MaxLength(200)]
        public string? EmitenteComplemento { get; set; }

        [Required]
        [MaxLength(100)]
        public string EmitenteBairro { get; set; } = string.Empty;

        [Required]
        public int EmitenteCodMunicipio { get; set; }

        [Required]
        [MaxLength(100)]
        public string EmitenteMunicipio { get; set; } = string.Empty;

        [Required]
        [MaxLength(8)]
        public string EmitenteCep { get; set; } = string.Empty;

        [Required]
        [MaxLength(2)]
        public string EmitenteUf { get; set; } = string.Empty;

        [MaxLength(20)]
        public string? EmitenteTelefone { get; set; }

        [MaxLength(200)]
        public string? EmitenteEmail { get; set; }

        [Required]
        [MaxLength(50)]
        public string EmitenteTipoEmitente { get; set; } = string.Empty;

        [MaxLength(20)]
        public string? EmitenteRntrc { get; set; }

        [Required]
        public int CondutorId { get; set; }
        public virtual Condutor Condutor { get; set; } = null!;

        // === DADOS DO CONDUTOR (COPIADOS NO MOMENTO DA EMISSÃO) ===
        [Required]
        [MaxLength(200)]
        public string CondutorNome { get; set; } = string.Empty;

        [Required]
        [MaxLength(11)]
        public string CondutorCpf { get; set; } = string.Empty;

        [MaxLength(20)]
        public string? CondutorTelefone { get; set; }

        [Required]
        public int VeiculoId { get; set; }
        public virtual Veiculo Veiculo { get; set; } = null!;

        // === DADOS DO VEÍCULO (COPIADOS NO MOMENTO DA EMISSÃO) ===
        [Required]
        [MaxLength(8)]
        public string VeiculoPlaca { get; set; } = string.Empty;

        [MaxLength(11)]
        public string? VeiculoRenavam { get; set; }

        [Required]
        public int VeiculoTara { get; set; }

        public int? VeiculoCapacidadeKg { get; set; }

        [Required]
        [MaxLength(50)]
        public string VeiculoTipoRodado { get; set; } = string.Empty;

        [Required]
        [MaxLength(50)]
        public string VeiculoTipoCarroceria { get; set; } = string.Empty;

        [Required]
        [MaxLength(2)]
        public string VeiculoUf { get; set; } = string.Empty;


        [MaxLength(100)]
        public string VeiculoMarca { get; set; } = string.Empty;

        [MaxLength(100)]
        public string VeiculoModelo { get; set; } = string.Empty;

        public int VeiculoAno { get; set; }

        [MaxLength(50)]
        public string VeiculoCor { get; set; } = string.Empty;

        [MaxLength(50)]
        public string VeiculoCombustivel { get; set; } = string.Empty;

        public int? MunicipioCarregamentoId { get; set; }
        public virtual Municipio? MunicipioCarregamento { get; set; }

        [Required]
        public int Serie { get; set; }

        [Required]
        public int NumeroMdfe { get; set; }

        [MaxLength(44)]
        public string? ChaveAcesso { get; set; }

        // Dígito verificador da chave de acesso (extraído da chave)
        [MaxLength(1)]
        public string? CodigoVerificador { get; set; }

        // Código numérico aleatório (usado na geração da chave)
        [MaxLength(8)]
        public string? CodigoNumericoAleatorio { get; set; }

        [Required]
        [MaxLength(2)]
        public string UfInicio { get; set; } = string.Empty;

        [Required]
        [MaxLength(2)]
        public string UfFim { get; set; } = string.Empty;

        [Required]
        public int Modal { get; set; } = 1; // 1 = Rodoviário

        [Required]
        public int TipoTransportador { get; set; } = 1; // 1 = ETC, 2 = TAC, 3 = CTC

        public DateTime DataEmissao { get; set; } = DateTime.Now;

        public DateTime? DataInicioViagem { get; set; }

        [Column(TypeName = "decimal(10,2)")]
        public decimal? ValorCarga { get; set; }

        [Column(TypeName = "decimal(10,3)")]
        public decimal? QuantidadeCarga { get; set; }

        [MaxLength(2)]
        public string UnidadeMedida { get; set; } = "01"; // 01 = KG

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

        // Dados ANTT
        [MaxLength(20)]
        public string? Rntrc { get; set; }

        [MaxLength(14)]
        public string? CnpjContratante { get; set; }

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

        [MaxLength(20)]
        public string? ContratanteTelefone { get; set; }

        [MaxLength(200)]
        public string? ContratanteEmail { get; set; }

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
        public string? SeguradoraCodigoSusep { get; set; }

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
        public string MunicipioIni { get; set; } = string.Empty;
        public string MunicipioFim { get; set; } = string.Empty;
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

        // === BACKUP DOS DADOS ORIGINAIS ===
        [Column(TypeName = "nvarchar(max)")]
        public string? DadosOriginaisJson { get; set; } // Backup dos dados originais dos cadastros

        // Propriedades computadas
        [NotMapped]
        public bool Ativo { get; set; } = true;
        [NotMapped]
        public int Numero => NumeroMdfe;
        [NotMapped]
        public string SerieStr => Serie.ToString();
        [NotMapped]
        public string Chave => ChaveAcesso ?? string.Empty;
        [NotMapped]
        public string Status => StatusSefaz;
        [NotMapped]
        public string UfIni => UfInicio;
        [NotMapped]
        public decimal? ValorTotal => ValorCarga;
        [NotMapped]
        public string? Observacoes => InfoAdicional;
        [NotMapped]
        public DateTime DataInicioViagemAtual => DataInicioViagem ?? DataEmissao;
        [NotMapped]
        public string? XmlMDFe => XmlGerado;

        // Propriedades adicionais para compatibilidade
        public DateTime? DataGeracao { get; set; }
        public string? NumeroAverbacao { get; set; }

        [MaxLength(20)]
        public string? CodigoCIOT { get; set; }

        [MaxLength(50)]
        public string? NumeroApolice { get; set; }

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

        [MaxLength(11)]
        public string? Renavam { get; set; }

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
        public string UnidadeMedida { get; set; } = string.Empty;

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


}