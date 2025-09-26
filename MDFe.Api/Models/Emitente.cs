using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MDFeApi.Models
{
    [Table("Empresas")]
    public class Emitente
    {
        public int Id { get; set; }

        [MaxLength(14)]
        public string? Cnpj { get; set; }

        [MaxLength(11)]
        public string? Cpf { get; set; }

        [MaxLength(20)]
        public string? Ie { get; set; }

        [Required]
        [MaxLength(200)]
        public string RazaoSocial { get; set; } = string.Empty;

        [MaxLength(200)]
        public string? NomeFantasia { get; set; }

        [Required]
        [MaxLength(200)]
        public string Endereco { get; set; } = string.Empty;

        [MaxLength(20)]
        public string? Numero { get; set; }

        [MaxLength(200)]
        public string? Complemento { get; set; }

        [Required]
        [MaxLength(100)]
        public string Bairro { get; set; } = string.Empty;

        public int CodMunicipio { get; set; }

        [Required]
        [MaxLength(100)]
        public string Municipio { get; set; } = string.Empty;

        [Required]
        [MaxLength(8)]
        public string Cep { get; set; } = string.Empty;

        [Required]
        [MaxLength(2)]
        public string Uf { get; set; } = string.Empty;


        public bool Ativo { get; set; } = true;

        // Tipo de Emitente
        [Required]
        [MaxLength(50)]
        public string TipoEmitente { get; set; } = "PrestadorServico"; // PrestadorServico ou EntregaPropria
        

        // Certificado Digital
        [MaxLength(500)]
        public string? CaminhoArquivoCertificado { get; set; }

        [MaxLength(500)]
        public string? SenhaCertificado { get; set; }

        // Caminho para salvar XMLs dos MDFe emitidos
        [MaxLength(500)]
        public string? CaminhoSalvarXml { get; set; }

        // Configurações RNTRC
        [MaxLength(20)]
        public string? Rntrc { get; set; }

        // Ambiente SEFAZ (1=Produção, 2=Homologação)
        public int AmbienteSefaz { get; set; } = 2;

        public DateTime DataCriacao { get; set; } = DateTime.Now;
        public DateTime? DataAtualizacao { get; set; }

        // Relacionamentos
        public virtual ICollection<MDFe> MDFes { get; set; } = new List<MDFe>();
    }
}