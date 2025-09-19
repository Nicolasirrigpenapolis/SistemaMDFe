using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MDFeApi.Models
{
    public class Veiculo
    {
        public int Id { get; set; }

        [Required]
        [MaxLength(8)]
        public string Placa { get; set; } = string.Empty;

        [MaxLength(11)]
        public string? Renavam { get; set; }

        public int Tara { get; set; }

        public int? CapacidadeKg { get; set; }

        [Required]
        [MaxLength(50)]
        public string TipoRodado { get; set; } = string.Empty;

        [Required]
        [MaxLength(50)]
        public string TipoCarroceria { get; set; } = string.Empty;

        [Required]
        [MaxLength(2)]
        public string Uf { get; set; } = string.Empty;

        [MaxLength(20)]
        public string? Rntrc { get; set; }

        public bool Ativo { get; set; } = true;

        public DateTime DataCriacao { get; set; } = DateTime.Now;

        // Propriedades auxiliares
        [Required]
        [MaxLength(100)]
        public string Marca { get; set; } = string.Empty;

        [Required]
        [MaxLength(100)]
        public string Modelo { get; set; } = string.Empty;

        [Required]
        public int Ano { get; set; }

        [Required]
        [MaxLength(50)]
        public string Cor { get; set; } = string.Empty;

        [Required]
        [MaxLength(50)]
        public string Combustivel { get; set; } = string.Empty;
        
        [NotMapped]
        public int? TaraKg => Tara;
        [NotMapped]
        public string UfLicenciamento => Uf;
        [NotMapped]
        public string UfPlaca => Uf;

        // Relacionamentos
        public virtual ICollection<MDFe> MDFes { get; set; } = new List<MDFe>();
    }
}