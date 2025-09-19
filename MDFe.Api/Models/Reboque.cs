using System.ComponentModel.DataAnnotations;

namespace MDFeApi.Models
{
    public class Reboque
    {
        public int Id { get; set; }

        [Required]
        [MaxLength(8)]
        public string Placa { get; set; } = string.Empty;

        [MaxLength(11)]
        public string? Renavam { get; set; }

        public int Tara { get; set; }

        public int CapacidadeKg { get; set; }

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

        // Propriedades computadas
        [System.ComponentModel.DataAnnotations.Schema.NotMapped]
        public string UfPlaca => Uf;

        // Relacionamentos
        public virtual ICollection<MDFeReboque> MDFeReboques { get; set; } = new List<MDFeReboque>();
    }
}