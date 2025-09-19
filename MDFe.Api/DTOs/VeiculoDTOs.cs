using System.ComponentModel.DataAnnotations;
using MDFeApi.Attributes;

namespace MDFeApi.DTOs
{
    public class VeiculoCreateDto
    {
        [Required(ErrorMessage = "Placa é obrigatória")]
        [StringLength(8, ErrorMessage = "Placa deve ter no máximo 8 caracteres")]
        [PlacaVeiculo(ErrorMessage = "Placa deve estar no formato ABC1234 ou ABC1A23 (Mercosul)")]
        public string Placa { get; set; } = string.Empty;

        [StringLength(11, ErrorMessage = "RENAVAM deve ter no máximo 11 caracteres")]
        public string? Renavam { get; set; }

        [Required(ErrorMessage = "Marca é obrigatória")]
        [MaxLength(100, ErrorMessage = "Marca deve ter no máximo 100 caracteres")]
        public string Marca { get; set; } = string.Empty;

        [Required(ErrorMessage = "Modelo é obrigatório")]
        [MaxLength(100, ErrorMessage = "Modelo deve ter no máximo 100 caracteres")]
        public string Modelo { get; set; } = string.Empty;

        [Required(ErrorMessage = "Ano é obrigatório")]
        [Range(1900, 2100, ErrorMessage = "Ano deve estar entre 1900 e 2100")]
        public int Ano { get; set; }

        [Required(ErrorMessage = "Cor é obrigatória")]
        [MaxLength(50, ErrorMessage = "Cor deve ter no máximo 50 caracteres")]
        public string Cor { get; set; } = string.Empty;

        [Required(ErrorMessage = "Combustível é obrigatório")]
        [MaxLength(50, ErrorMessage = "Combustível deve ter no máximo 50 caracteres")]
        public string Combustivel { get; set; } = string.Empty;

        [Required(ErrorMessage = "Tara é obrigatória")]
        [Range(1, int.MaxValue, ErrorMessage = "Tara deve ser maior que zero")]
        public int Tara { get; set; }

        [Range(0, int.MaxValue, ErrorMessage = "Capacidade deve ser maior ou igual a zero")]
        public int? CapacidadeKg { get; set; }

        [Range(0, int.MaxValue, ErrorMessage = "Capacidade em M³ deve ser maior ou igual a zero")]
        public int? CapacidadeM3 { get; set; }
        
        [Required(ErrorMessage = "Tipo de rodado é obrigatório")]
        [MaxLength(50, ErrorMessage = "Tipo de rodado deve ter no máximo 50 caracteres")]
        public string TipoRodado { get; set; } = string.Empty;

        [Required(ErrorMessage = "Tipo de carroceria é obrigatório")]
        [MaxLength(50, ErrorMessage = "Tipo de carroceria deve ter no máximo 50 caracteres")]
        public string TipoCarroceria { get; set; } = string.Empty;

        [Required(ErrorMessage = "UF é obrigatória")]
        [StringLength(2, MinimumLength = 2, ErrorMessage = "UF deve ter exatamente 2 caracteres")]
        [RegularExpression(@"^[A-Z]{2}$", ErrorMessage = "UF deve conter apenas letras maiúsculas")]
        public string Uf { get; set; } = string.Empty;

        [MaxLength(20, ErrorMessage = "RNTRC deve ter no máximo 20 caracteres")]
        public string? Rntrc { get; set; }
    }

    public class VeiculoUpdateDto : VeiculoCreateDto
    {
        // Mesmas propriedades que VeiculoCreateDto
    }

    public class VeiculoResponseDto
    {
        public int Id { get; set; }
        public string Placa { get; set; } = string.Empty;
        public string? Renavam { get; set; }
        public string Marca { get; set; } = string.Empty;
        public string Modelo { get; set; } = string.Empty;
        public int Ano { get; set; }
        public string Cor { get; set; } = string.Empty;
        public string Combustivel { get; set; } = string.Empty;
        public int Tara { get; set; }
        public int? CapacidadeKg { get; set; }
        public int? CapacidadeM3 { get; set; }
        public string TipoRodado { get; set; } = string.Empty;
        public string TipoCarroceria { get; set; } = string.Empty;
        public string Uf { get; set; } = string.Empty;
        public string? Rntrc { get; set; }
        public bool Ativo { get; set; }
        public DateTime DataCriacao { get; set; }
    }

    public class VeiculoListDto
    {
        public int Id { get; set; }
        public string Placa { get; set; } = string.Empty;
        public string Marca { get; set; } = string.Empty;
        public string Modelo { get; set; } = string.Empty;
        public int Ano { get; set; }
        public string TipoRodado { get; set; } = string.Empty;
        public string TipoCarroceria { get; set; } = string.Empty;
        public string Uf { get; set; } = string.Empty;
        public bool Ativo { get; set; }
    }
}