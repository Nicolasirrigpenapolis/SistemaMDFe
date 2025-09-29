using System.ComponentModel.DataAnnotations;

namespace MDFeApi.DTOs
{
    public class SeguradoraListDto
    {
        public int Id { get; set; }
        public string Cnpj { get; set; } = string.Empty;
        public string RazaoSocial { get; set; } = string.Empty;
        public string Uf { get; set; } = string.Empty;
        public string? NomeFantasia { get; set; }
        public string? Apolice { get; set; }
        public bool Ativo { get; set; }
        public DateTime DataCriacao { get; set; }
    }

    public class SeguradoraDetailDto : SeguradoraListDto
    {
        public DateTime? DataUltimaAlteracao { get; set; }
    }

    public class SeguradoraCreateDto
    {
        [Required(ErrorMessage = "CNPJ é obrigatório")]
        [MaxLength(14)]
        public string Cnpj { get; set; } = string.Empty;

        [Required(ErrorMessage = "Razão Social é obrigatória")]
        [MaxLength(200)]
        public string RazaoSocial { get; set; } = string.Empty;

        [MaxLength(200)]
        public string? NomeFantasia { get; set; }

        [Required(ErrorMessage = "Endereço é obrigatório")]
        [MaxLength(200)]
        public string Endereco { get; set; } = string.Empty;

        [MaxLength(20)]
        public string? Numero { get; set; }

        [MaxLength(100)]
        public string? Complemento { get; set; }

        [Required(ErrorMessage = "Bairro é obrigatório")]
        [MaxLength(100)]
        public string Bairro { get; set; } = string.Empty;

        [Required]
        public int CodMunicipio { get; set; }

        [Required(ErrorMessage = "Município é obrigatório")]
        [MaxLength(100)]
        public string Municipio { get; set; } = string.Empty;

        [Required(ErrorMessage = "CEP é obrigatório")]
        [MaxLength(8)]
        public string Cep { get; set; } = string.Empty;

        [Required(ErrorMessage = "UF é obrigatória")]
        [MaxLength(2)]
        public string Uf { get; set; } = string.Empty;

        [MaxLength(15)]
        public string? Telefone { get; set; }

        [MaxLength(200)]
        public string? Email { get; set; }

        [MaxLength(50)]
        public string? Apolice { get; set; }

        public bool Ativo { get; set; } = true;
    }

    public class SeguradoraUpdateDto : SeguradoraCreateDto
    {
    }

    public class SeguradoraSimpleDto
    {
        public int Id { get; set; }
        public string Cnpj { get; set; } = string.Empty;
        public string RazaoSocial { get; set; } = string.Empty;
        public string? Apolice { get; set; }
    }

    public class SeguradoraCreateWrapper
    {
        public SeguradoraCreateDto Dto { get; set; } = new();
    }
}