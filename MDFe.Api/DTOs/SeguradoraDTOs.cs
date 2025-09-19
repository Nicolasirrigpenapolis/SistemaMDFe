using System.ComponentModel.DataAnnotations;

namespace MDFeApi.DTOs
{
    public class SeguradoraListDTO
    {
        public int Id { get; set; }
        public string Cnpj { get; set; } = string.Empty;
        public string RazaoSocial { get; set; } = string.Empty;
        public string Endereco { get; set; } = string.Empty;
        public string? Numero { get; set; }
        public string? Complemento { get; set; }
        public string Bairro { get; set; } = string.Empty;
        public int CodMunicipio { get; set; }
        public string Municipio { get; set; } = string.Empty;
        public string Cep { get; set; } = string.Empty;
        public string Uf { get; set; } = string.Empty;
        public string? Telefone { get; set; }
        public string? Apolice { get; set; }
        public bool Ativo { get; set; }
        public DateTime DataCriacao { get; set; }
    }

    public class SeguradoraDetailDTO : SeguradoraListDTO
    {
        public DateTime? DataUltimaAlteracao { get; set; }
    }

    public class SeguradoraCreateDTO
    {
        [Required(ErrorMessage = "CNPJ é obrigatório")]
        [MaxLength(14)]
        public string Cnpj { get; set; } = string.Empty;

        [Required(ErrorMessage = "Razão Social é obrigatória")]
        [MaxLength(200)]
        public string RazaoSocial { get; set; } = string.Empty;

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

        [Required(ErrorMessage = "Código do município é obrigatório")]
        public int CodMunicipio { get; set; }

        [Required(ErrorMessage = "Município é obrigatório")]
        [MaxLength(100)]
        public string Municipio { get; set; } = string.Empty;

        [Required(ErrorMessage = "CEP é obrigatório")]
        [MaxLength(8)]
        public string Cep { get; set; } = string.Empty;

        [Required(ErrorMessage = "UF é obrigatório")]
        [MaxLength(2)]
        public string Uf { get; set; } = string.Empty;

        [MaxLength(15)]
        public string? Telefone { get; set; }

        [MaxLength(50)]
        public string? Apolice { get; set; }

        public bool Ativo { get; set; } = true;
    }

    public class SeguradoraUpdateDTO : SeguradoraCreateDTO
    {
    }

    public class SeguradoraSimpleDTO
    {
        public int Id { get; set; }
        public string Cnpj { get; set; } = string.Empty;
        public string RazaoSocial { get; set; } = string.Empty;
        public string? Apolice { get; set; }
    }
}