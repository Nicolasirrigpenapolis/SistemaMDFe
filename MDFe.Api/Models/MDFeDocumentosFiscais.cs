using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MDFeApi.Models
{
    // CT-e vinculado ao MDFe
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
        public string? IndReentrega { get; set; }

        [MaxLength(3)]
        public string? IndicadorPrestacaoParcial { get; set; }

        // Propriedades para compatibilidade
        public string? SegundoCodigoBarras { get => SegCodigoBarras; set => SegCodigoBarras = value; }
        public string? IndicadorReentrega { get => IndReentrega; set => IndReentrega = value; }

        public int? MunicipioDescargaId { get; set; }
        public virtual Municipio? MunicipioDescarga { get; set; }

        [MaxLength(100)]
        public string? DescricaoMunicipioDescarga { get; set; }

        [MaxLength(14)]
        public string? CnpjColeta { get; set; }

        [MaxLength(14)]
        public string? CnpjEntrega { get; set; }

        [Column(TypeName = "decimal(10,2)")]
        public decimal? ValorCarga { get; set; }

        [Column(TypeName = "decimal(10,3)")]
        public decimal? PesoBruto { get; set; }

        public DateTime DataCriacao { get; set; } = DateTime.Now;

        public int Ordem { get; set; }

        // Relacionamentos
        public virtual ICollection<MDFeUnidadeTransporte> UnidadesTransporte { get; set; } = new List<MDFeUnidadeTransporte>();
        public virtual ICollection<MDFeProdutoPerigoso> ProdutosPerigosos { get; set; } = new List<MDFeProdutoPerigoso>();
        public virtual ICollection<MDFeNfePrestacaoParcial> NfesPrestacaoParcial { get; set; } = new List<MDFeNfePrestacaoParcial>();
        public virtual MDFeEntregaParcial? EntregaParcial { get; set; }
    }

    // NF-e vinculada ao MDFe
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
        public string? IndReentrega { get; set; }

        [MaxLength(20)]
        public string? PinSuframa { get; set; }

        public DateTime? DataPrevistaEntrega { get; set; }

        // Propriedades para compatibilidade
        public string? SegundoCodigoBarras { get => SegCodigoBarras; set => SegCodigoBarras = value; }
        public string? IndicadorReentrega { get => IndReentrega; set => IndReentrega = value; }

        public int? MunicipioDescargaId { get; set; }
        public virtual Municipio? MunicipioDescarga { get; set; }

        [MaxLength(100)]
        public string? DescricaoMunicipioDescarga { get; set; }

        [MaxLength(14)]
        public string? CnpjColeta { get; set; }

        [MaxLength(14)]
        public string? CnpjEntrega { get; set; }

        [Column(TypeName = "decimal(10,2)")]
        public decimal? ValorCarga { get; set; }

        [Column(TypeName = "decimal(10,3)")]
        public decimal? PesoBruto { get; set; }

        public DateTime DataCriacao { get; set; } = DateTime.Now;

        public int Ordem { get; set; }

        // Relacionamentos
        public virtual ICollection<MDFeUnidadeTransporte> UnidadesTransporte { get; set; } = new List<MDFeUnidadeTransporte>();
        public virtual ICollection<MDFeProdutoPerigoso> ProdutosPerigosos { get; set; } = new List<MDFeProdutoPerigoso>();
        public virtual MDFeEntregaParcial? EntregaParcial { get; set; }
    }

    // MDFe de transporte vinculado ao MDFe
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
        public string? SegCodigoBarras { get; set; }

        [MaxLength(3)]
        public string? IndReentrega { get; set; }

        // Propriedades para compatibilidade
        public string? SegundoCodigoBarras { get => SegCodigoBarras; set => SegCodigoBarras = value; }
        public string? IndicadorReentrega { get => IndReentrega; set => IndReentrega = value; }

        public int? MunicipioDescargaId { get; set; }
        public virtual Municipio? MunicipioDescarga { get; set; }

        [MaxLength(100)]
        public string? DescricaoMunicipioDescarga { get; set; }

        [MaxLength(14)]
        public string? CnpjColeta { get; set; }

        [MaxLength(14)]
        public string? CnpjEntrega { get; set; }

        [Column(TypeName = "decimal(10,2)")]
        public decimal? ValorCarga { get; set; }

        [Column(TypeName = "decimal(10,3)")]
        public decimal? PesoBruto { get; set; }

        [Column(TypeName = "decimal(18,3)")]
        public decimal? QuantidadeRateada { get; set; }

        public DateTime DataCriacao { get; set; } = DateTime.Now;

        public int Ordem { get; set; }

        // Relacionamentos
        public virtual ICollection<MDFeUnidadeTransporte> UnidadesTransporte { get; set; } = new List<MDFeUnidadeTransporte>();
        public virtual ICollection<MDFeProdutoPerigoso> ProdutosPerigosos { get; set; } = new List<MDFeProdutoPerigoso>();
    }

    // Lacres rodoviários do MDFe
    public class MDFeLacreRodoviario
    {
        public int Id { get; set; }

        [Required]
        public int MDFeId { get; set; }
        public virtual MDFe MDFe { get; set; } = null!;

        [Required]
        [MaxLength(60)]
        public string NumeroLacre { get; set; } = string.Empty;

        public DateTime DataCriacao { get; set; } = DateTime.Now;

        public int Ordem { get; set; }
    }

    // Contratante específico para MDFe (classe complementar)
    public class MDFeContratante
    {
        public int Id { get; set; }

        [Required]
        public int MDFeId { get; set; }
        public virtual MDFe MDFe { get; set; } = null!;

        [MaxLength(14)]
        public string? Cnpj { get; set; }

        [MaxLength(11)]
        public string? Cpf { get; set; }

        [MaxLength(200)]
        public string? RazaoSocial { get; set; }

        [MaxLength(200)]
        public string? NomeFantasia { get; set; }

        [MaxLength(20)]
        public string? Ie { get; set; }

        [MaxLength(200)]
        public string? Endereco { get; set; }

        [MaxLength(20)]
        public string? Numero { get; set; }

        [MaxLength(200)]
        public string? Complemento { get; set; }

        [MaxLength(100)]
        public string? Bairro { get; set; }

        public int? CodMunicipio { get; set; }

        [MaxLength(100)]
        public string? Municipio { get; set; }

        [MaxLength(8)]
        public string? Cep { get; set; }

        [MaxLength(2)]
        public string? Uf { get; set; }

        [MaxLength(20)]
        public string? Telefone { get; set; }

        [MaxLength(200)]
        public string? Email { get; set; }

        public DateTime DataCriacao { get; set; } = DateTime.Now;
    }

    // Unidades de Transporte
    public class MDFeUnidadeTransporte
    {
        public int Id { get; set; }

        [Required]
        public int MDFeId { get; set; }
        public virtual MDFe MDFe { get; set; } = null!;

        // Relacionamentos com documentos fiscais
        public int? MDFeCteId { get; set; }
        public virtual MDFeCte? MDFeCte { get; set; }

        public int? MDFeNfeId { get; set; }
        public virtual MDFeNfe? MDFeNfe { get; set; }

        public int? MDFeMdfeTranspId { get; set; }
        public virtual MDFeMdfeTransp? MDFeMdfeTransp { get; set; }

        [Required]
        [MaxLength(1)]
        public string TipoUnidadeTransporte { get; set; } = string.Empty; // 1=Rodotrem, 2=Caminhão, etc.

        [Required]
        [MaxLength(20)]
        public string IdentificacaoUnidadeTransporte { get; set; } = string.Empty;

        [Column(TypeName = "decimal(18,3)")]
        public decimal? QuantidadeRateada { get; set; }

        public DateTime DataCriacao { get; set; } = DateTime.Now;

        // Relacionamentos
        public virtual ICollection<MDFeUnidadeCarga> UnidadesCarga { get; set; } = new List<MDFeUnidadeCarga>();
        public virtual ICollection<MDFeLacreUnidadeTransporte> Lacres { get; set; } = new List<MDFeLacreUnidadeTransporte>();
    }

    // Unidades de Carga
    public class MDFeUnidadeCarga
    {
        public int Id { get; set; }

        [Required]
        public int MDFeUnidadeTransporteId { get; set; }
        public virtual MDFeUnidadeTransporte UnidadeTransporte { get; set; } = null!;

        [Required]
        [MaxLength(1)]
        public string TipoUnidadeCarga { get; set; } = string.Empty; // 1=Container, 2=ULD, etc.

        [Required]
        [MaxLength(20)]
        public string IdentificacaoUnidadeCarga { get; set; } = string.Empty;

        [Column(TypeName = "decimal(18,3)")]
        public decimal? QuantidadeRateada { get; set; }

        public DateTime DataCriacao { get; set; } = DateTime.Now;

        // Relacionamentos
        public virtual ICollection<MDFeLacreUnidadeCarga> Lacres { get; set; } = new List<MDFeLacreUnidadeCarga>();
    }

    // Lacres de Unidades de Transporte
    public class MDFeLacreUnidadeTransporte
    {
        public int Id { get; set; }

        [Required]
        public int MDFeUnidadeTransporteId { get; set; }
        public virtual MDFeUnidadeTransporte UnidadeTransporte { get; set; } = null!;

        [Required]
        [MaxLength(60)]
        public string NumeroLacre { get; set; } = string.Empty;

        public DateTime DataCriacao { get; set; } = DateTime.Now;
    }

    // Lacres de Unidades de Carga
    public class MDFeLacreUnidadeCarga
    {
        public int Id { get; set; }

        [Required]
        public int MDFeUnidadeCargaId { get; set; }
        public virtual MDFeUnidadeCarga UnidadeCarga { get; set; } = null!;

        [Required]
        [MaxLength(60)]
        public string NumeroLacre { get; set; } = string.Empty;

        public DateTime DataCriacao { get; set; } = DateTime.Now;
    }

    // Produtos Perigosos
    public class MDFeProdutoPerigoso
    {
        public int Id { get; set; }

        [Required]
        public int MDFeId { get; set; }
        public virtual MDFe MDFe { get; set; } = null!;

        // Relacionamentos com documentos fiscais
        public int? MDFeCteId { get; set; }
        public virtual MDFeCte? MDFeCte { get; set; }

        public int? MDFeNfeId { get; set; }
        public virtual MDFeNfe? MDFeNfe { get; set; }

        public int? MDFeMdfeTranspId { get; set; }
        public virtual MDFeMdfeTransp? MDFeMdfeTransp { get; set; }

        [Required]
        [MaxLength(4)]
        public string NumeroONU { get; set; } = string.Empty;

        [MaxLength(150)]
        public string? NomeApropriado { get; set; }

        [MaxLength(40)]
        public string? ClasseRisco { get; set; }

        [MaxLength(6)]
        public string? GrupoEmbalagem { get; set; }

        [Required]
        [MaxLength(20)]
        public string QuantidadeTotalProduto { get; set; } = string.Empty;

        [MaxLength(60)]
        public string? QuantidadeVolumoTipo { get; set; }

        public DateTime DataCriacao { get; set; } = DateTime.Now;
    }

    // Entregas Parciais
    public class MDFeEntregaParcial
    {
        public int Id { get; set; }

        [Required]
        public int MDFeId { get; set; }
        public virtual MDFe MDFe { get; set; } = null!;

        // Relacionamentos com documentos fiscais (CT-e ou NF-e)
        public int? MDFeCteId { get; set; }
        public virtual MDFeCte? MDFeCte { get; set; }

        public int? MDFeNfeId { get; set; }
        public virtual MDFeNfe? MDFeNfe { get; set; }

        [Required]
        [Column(TypeName = "decimal(11,4)")]
        public decimal QuantidadeTotal { get; set; }

        [Required]
        [Column(TypeName = "decimal(11,4)")]
        public decimal QuantidadeParcial { get; set; }

        public DateTime DataCriacao { get; set; } = DateTime.Now;
    }

    // NFes de Prestação Parcial (relacionadas a CTes)
    public class MDFeNfePrestacaoParcial
    {
        public int Id { get; set; }

        [Required]
        public int MDFeCteId { get; set; }
        public virtual MDFeCte MDFeCte { get; set; } = null!;

        [Required]
        [MaxLength(44)]
        public string ChaveNfe { get; set; } = string.Empty;

        public DateTime DataCriacao { get; set; } = DateTime.Now;
    }
}