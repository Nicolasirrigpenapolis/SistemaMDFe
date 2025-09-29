using System.ComponentModel.DataAnnotations;

namespace MDFeApi.Models
{
    public class Cargo
    {
        public int Id { get; set; }

        [MaxLength(100)]
        public string Nome { get; set; } = string.Empty;

        [MaxLength(500)]
        public string? Descricao { get; set; }

        public bool Ativo { get; set; } = true;

        public DateTime DataCriacao { get; set; } = DateTime.Now;
        public DateTime? DataUltimaAlteracao { get; set; }

        // Navegação
        public ICollection<Usuario> Usuarios { get; set; } = new List<Usuario>();
    }
}