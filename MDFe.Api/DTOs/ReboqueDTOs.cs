using System.ComponentModel.DataAnnotations;

namespace MDFeApi.DTOs
{
    public class ReboqueCreateDto
    {
        [Required]
        [StringLength(8)]
        public string Placa { get; set; } = string.Empty;

        [StringLength(11)]
        public string? Renavam { get; set; }

        [Required]
        public int Tara { get; set; }

        public int CapacidadeKg { get; set; }

        [Required]
        [StringLength(50)]
        public string TipoRodado { get; set; } = string.Empty;

        [Required]
        [StringLength(50)]
        public string TipoCarroceria { get; set; } = string.Empty;

        [Required]
        [StringLength(2)]
        public string Uf { get; set; } = string.Empty;

        [StringLength(20)]
        public string? Rntrc { get; set; }
    }

    public class ReboqueUpdateDto : ReboqueCreateDto
    {
        // Herda todas as propriedades de ReboqueCreateDto
    }

    public class ReboqueResponseDto
    {
        public int Id { get; set; }
        public string Placa { get; set; } = string.Empty;
        public string? Renavam { get; set; }
        public int Tara { get; set; }
        public int CapacidadeKg { get; set; }
        public string TipoRodado { get; set; } = string.Empty;
        public string TipoCarroceria { get; set; } = string.Empty;
        public string Uf { get; set; } = string.Empty;
        public string? Rntrc { get; set; }
        public bool Ativo { get; set; }
        public DateTime DataCriacao { get; set; }
    }
}