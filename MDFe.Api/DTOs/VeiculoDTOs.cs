using System.ComponentModel.DataAnnotations;

namespace MDFeApi.DTOs
{
    public class VeiculoCreateDto
    {
        [Required]
        [StringLength(8)]
        public string Placa { get; set; } = string.Empty;
        
        [StringLength(11)]
        public string? Renavam { get; set; }

        [Required]
        public string Marca { get; set; } = string.Empty;

        [Required]
        public string Modelo { get; set; } = string.Empty;

        public int Ano { get; set; }

        [Required]
        public string Cor { get; set; } = string.Empty;

        [Required]
        public string Combustivel { get; set; } = string.Empty;
        
        public int? Tara { get; set; }
        public int? CapacidadeKg { get; set; }
        
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

    public class VeiculoUpdateDto : VeiculoCreateDto
    {
        // Mesmas propriedades que VeiculoCreateDto
    }
}