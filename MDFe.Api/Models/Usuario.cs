using System.ComponentModel.DataAnnotations;
using Microsoft.AspNetCore.Identity;

namespace MDFeApi.Models
{
    public class Usuario : IdentityUser<int>
    {
        [MaxLength(100)]
        public string Nome { get; set; } = string.Empty;

        [MaxLength(20)]
        public string? Telefone { get; set; }

        public int? CargoId { get; set; }
        public Cargo? Cargo { get; set; }

        public bool Ativo { get; set; } = true;

        public DateTime DataCriacao { get; set; } = DateTime.Now;
        public DateTime? DataUltimaAlteracao { get; set; }
        public DateTime? DataUltimoLogin { get; set; }
    }
}