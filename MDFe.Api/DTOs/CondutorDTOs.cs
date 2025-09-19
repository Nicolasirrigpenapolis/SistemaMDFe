using System.ComponentModel.DataAnnotations;

namespace MDFeApi.DTOs
{
    public class CondutorCreateDto
    {
        [Required]
        [MaxLength(200)]
        public string Nome { get; set; } = string.Empty;
        
        [Required]
        [MaxLength(11)]
        public string Cpf { get; set; } = string.Empty;
        
        [MaxLength(20)]
        public string? Telefone { get; set; }
    }

    public class CondutorUpdateDto : CondutorCreateDto
    {
        // Mesmas propriedades que CondutorCreateDto
    }

    public class CondutorSimpleDto
    {
        [Required(ErrorMessage = "Nome do condutor é obrigatório")]
        [MinLength(2, ErrorMessage = "Nome deve ter pelo menos 2 caracteres")]
        public string Nome { get; set; } = "";

        [Required(ErrorMessage = "CPF do condutor é obrigatório")]
        [RegularExpression(@"^\d{11}$", ErrorMessage = "CPF deve conter exatamente 11 dígitos")]
        public string Cpf { get; set; } = "";

        [Phone(ErrorMessage = "Formato de telefone inválido")]
        public string? Telefone { get; set; }
    }
}