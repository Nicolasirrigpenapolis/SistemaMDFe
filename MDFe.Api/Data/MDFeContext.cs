using Microsoft.EntityFrameworkCore;
using MDFeApi.Models;

namespace MDFeApi.Data
{
    public class MDFeContext : DbContext
    {
        public MDFeContext(DbContextOptions<MDFeContext> options) : base(options)
        {
        }

        // DbSets das entidades
        public DbSet<Usuario> Usuarios { get; set; }
        public DbSet<Emitente> Emitentes { get; set; }
        public DbSet<Estado> Estados { get; set; }
        public DbSet<Municipio> Municipios { get; set; }
        public DbSet<Condutor> Condutores { get; set; }
        public DbSet<Veiculo> Veiculos { get; set; }
        public DbSet<Reboque> Reboques { get; set; }
        public DbSet<MDFe> MDFes { get; set; }
        public DbSet<MDFeReboque> MDFeReboques { get; set; }
        public DbSet<MDFeCte> MDFeCtes { get; set; }
        public DbSet<MDFeNfe> MDFeNfes { get; set; }
        public DbSet<MDFeMdfeTransp> MDFeMdfeTransps { get; set; }
        public DbSet<MDFeEvento> MDFeEventos { get; set; }
        public DbSet<MDFeUfPercurso> MDFeUfsPercurso { get; set; }
        public DbSet<MDFeLocalCarregamento> MDFeLocaisCarregamento { get; set; }
        public DbSet<MDFeLocalDescarregamento> MDFeLocaisDescarregamento { get; set; }
        public DbSet<MDFeCondutor> MDFeCondutores { get; set; }
        public DbSet<MDFeValePedagio> MDFeValesPedagio { get; set; }
        public DbSet<Contratante> Contratantes { get; set; }
        public DbSet<Seguradora> Seguradoras { get; set; }
        public DbSet<Cargo> Cargos { get; set; }
        public DbSet<Permissao> Permissoes { get; set; }
        public DbSet<CargoPermissao> CargoPermissoes { get; set; }

        public DbSet<MDFeUnidadeTransporte> MDFeUnidadesTransporte { get; set; }
        public DbSet<MDFeUnidadeCarga> MDFeUnidadesCarga { get; set; }
        public DbSet<MDFeLacreUnidadeTransporte> MDFeLacresUnidadeTransporte { get; set; }
        public DbSet<MDFeLacreUnidadeCarga> MDFeLacresUnidadeCarga { get; set; }
        public DbSet<MDFeLacreRodoviario> MDFeLacresRodoviarios { get; set; }
        public DbSet<MDFeProdutoPerigoso> MDFeProdutosPerigosos { get; set; }
        public DbSet<MDFeEntregaParcial> MDFeEntregasParciais { get; set; }
        public DbSet<MDFeNfePrestacaoParcial> MDFeNfesPrestacaoParcial { get; set; }

        protected override void OnModelCreating(ModelBuilder builder)
        {
            // Configuração do Usuario
            builder.Entity<Usuario>(entity =>
            {
                entity.ToTable("Usuarios");
                entity.HasKey(u => u.Id);
                entity.HasIndex(u => u.UserName).IsUnique();

                // Relacionamento com Cargo
                entity.HasOne(u => u.Cargo)
                    .WithMany(c => c.Usuarios)
                    .HasForeignKey(u => u.CargoId)
                    .OnDelete(DeleteBehavior.SetNull);
            });

            // Configuração do Cargo
            builder.Entity<Cargo>(entity =>
            {
                entity.HasIndex(c => c.Nome).IsUnique();
            });

            // Configuração da Permissao
            builder.Entity<Permissao>(entity =>
            {
                entity.HasIndex(p => p.Codigo).IsUnique();
            });

            // Configuração do CargoPermissao
            builder.Entity<CargoPermissao>(entity =>
            {
                entity.HasKey(cp => cp.Id);

                // Índice único composto para evitar duplicação
                entity.HasIndex(cp => new { cp.CargoId, cp.PermissaoId }).IsUnique();

                // Relacionamentos
                entity.HasOne(cp => cp.Cargo)
                    .WithMany(c => c.CargoPermissoes)
                    .HasForeignKey(cp => cp.CargoId)
                    .OnDelete(DeleteBehavior.Cascade);

                entity.HasOne(cp => cp.Permissao)
                    .WithMany(p => p.CargoPermissoes)
                    .HasForeignKey(cp => cp.PermissaoId)
                    .OnDelete(DeleteBehavior.Cascade);
            });

            // Configurações específicas
            
            // Emitente - CNPJ ou CPF é obrigatório
            builder.Entity<Emitente>(entity =>
            {
                entity.HasIndex(e => e.Cnpj).IsUnique().HasFilter("[Cnpj] IS NOT NULL");
                entity.HasIndex(e => e.Cpf).IsUnique().HasFilter("[Cpf] IS NOT NULL");
            });

            // Municipio - Código único
            builder.Entity<Municipio>(entity =>
            {
                entity.HasIndex(e => e.Codigo).IsUnique();
            });

            // Condutor - CPF único
            builder.Entity<Condutor>(entity =>
            {
                entity.HasIndex(e => e.Cpf).IsUnique();
            });

            // Veiculo - Placa única
            builder.Entity<Veiculo>(entity =>
            {
                entity.HasIndex(e => e.Placa).IsUnique();
            });

            // Reboque - Placa única
            builder.Entity<Reboque>(entity =>
            {
                entity.HasIndex(e => e.Placa).IsUnique();
            });

            // MDFe - Chave de acesso única se preenchida
            builder.Entity<MDFe>(entity =>
            {
                entity.HasIndex(e => e.ChaveAcesso).IsUnique().HasFilter("[ChaveAcesso] IS NOT NULL");
                
                // Série e número únicos por emitente
                entity.HasIndex(e => new { e.EmitenteId, e.Serie, e.NumeroMdfe }).IsUnique();
                
                // Configuração de precisão para campos decimais
                entity.Property(e => e.PesoBrutoTotal)
                    .HasColumnType("decimal(18,3)");
                    
                entity.Property(e => e.ValorTotal)
                    .HasColumnType("decimal(18,2)");
                    

                // Relacionamentos
                entity.HasOne(m => m.Emitente)
                    .WithMany(e => e.MDFes)
                    .HasForeignKey(m => m.EmitenteId)
                    .OnDelete(DeleteBehavior.Restrict);

                entity.HasOne(m => m.Condutor)
                    .WithMany(c => c.MDFes)
                    .HasForeignKey(m => m.CondutorId)
                    .OnDelete(DeleteBehavior.Restrict);

                entity.HasOne(m => m.Veiculo)
                    .WithMany(v => v.MDFes)
                    .HasForeignKey(m => m.VeiculoId)
                    .OnDelete(DeleteBehavior.Restrict);

                entity.HasOne(m => m.MunicipioCarregamento)
                    .WithMany(mu => mu.MDFesCarregamento)
                    .HasForeignKey(m => m.MunicipioCarregamentoId)
                    .OnDelete(DeleteBehavior.Restrict);

                entity.HasOne(m => m.Contratante)
                    .WithMany(c => c.MDFes)
                    .HasForeignKey(m => m.ContratanteId)
                    .OnDelete(DeleteBehavior.Restrict);

                entity.HasOne(m => m.Seguradora)
                    .WithMany(s => s.MDFes)
                    .HasForeignKey(m => m.SeguradoraId)
                    .OnDelete(DeleteBehavior.Restrict);
            });

            // MDFeReboque - Chave composta
            builder.Entity<MDFeReboque>(entity =>
            {
                entity.HasKey(mr => new { mr.MDFeId, mr.ReboqueId });

                entity.HasOne(mr => mr.MDFe)
                    .WithMany(m => m.Reboques)
                    .HasForeignKey(mr => mr.MDFeId);

                entity.HasOne(mr => mr.Reboque)
                    .WithMany(r => r.MDFeReboques)
                    .HasForeignKey(mr => mr.ReboqueId);
            });

            // MDFeCte
            builder.Entity<MDFeCte>(entity =>
            {
                entity.HasIndex(mc => mc.ChaveCte).IsUnique();

                entity.HasOne(mc => mc.MDFe)
                    .WithMany(m => m.DocumentosCte)
                    .HasForeignKey(mc => mc.MDFeId)
                    .OnDelete(DeleteBehavior.Cascade);

                entity.HasOne(mc => mc.MunicipioDescarga)
                    .WithMany(mu => mu.MDFesCte)
                    .HasForeignKey(mc => mc.MunicipioDescargaId)
                    .OnDelete(DeleteBehavior.Restrict);
            });

            // MDFeNfe
            builder.Entity<MDFeNfe>(entity =>
            {
                entity.HasIndex(mn => mn.ChaveNfe).IsUnique();

                entity.HasOne(mn => mn.MDFe)
                    .WithMany(m => m.DocumentosNfe)
                    .HasForeignKey(mn => mn.MDFeId)
                    .OnDelete(DeleteBehavior.Cascade);

                entity.HasOne(mn => mn.MunicipioDescarga)
                    .WithMany(mu => mu.MDFesNfe)
                    .HasForeignKey(mn => mn.MunicipioDescargaId)
                    .OnDelete(DeleteBehavior.Restrict);
            });

            // MDFeEvento
            builder.Entity<MDFeEvento>(entity =>
            {
                entity.HasOne(me => me.MDFe)
                    .WithMany(m => m.Eventos)
                    .HasForeignKey(me => me.MDFeId)
                    .OnDelete(DeleteBehavior.Cascade);
            });

            // MDFeUfPercurso
            builder.Entity<MDFeUfPercurso>(entity =>
            {
                entity.HasOne(mup => mup.MDFe)
                    .WithMany(m => m.UfsPercurso)
                    .HasForeignKey(mup => mup.MDFeId)
                    .OnDelete(DeleteBehavior.Cascade);
            });

            // MDFeLocalCarregamento
            builder.Entity<MDFeLocalCarregamento>(entity =>
            {
                entity.HasOne(mlc => mlc.MDFe)
                    .WithMany(m => m.LocaisCarregamento)
                    .HasForeignKey(mlc => mlc.MDFeId)
                    .OnDelete(DeleteBehavior.Cascade);

                entity.HasOne(mlc => mlc.Municipio)
                    .WithMany(mu => mu.LocaisCarregamento)
                    .HasForeignKey(mlc => mlc.MunicipioId)
                    .OnDelete(DeleteBehavior.Restrict);
            });

            // MDFeLocalDescarregamento
            builder.Entity<MDFeLocalDescarregamento>(entity =>
            {
                entity.HasOne(mld => mld.MDFe)
                    .WithMany(m => m.LocaisDescarregamento)
                    .HasForeignKey(mld => mld.MDFeId)
                    .OnDelete(DeleteBehavior.Cascade);

                entity.HasOne(mld => mld.Municipio)
                    .WithMany(mu => mu.LocaisDescarregamento)
                    .HasForeignKey(mld => mld.MunicipioId)
                    .OnDelete(DeleteBehavior.Restrict);
            });

            // MDFeCondutor
            builder.Entity<MDFeCondutor>(entity =>
            {
                entity.HasOne(mc => mc.MDFe)
                    .WithMany(m => m.CondutoresAdicionais)
                    .HasForeignKey(mc => mc.MDFeId)
                    .OnDelete(DeleteBehavior.Cascade);

                entity.HasIndex(mc => mc.CpfCondutor);
            });

            // Contratante - CNPJ ou CPF único
            builder.Entity<Contratante>(entity =>
            {
                entity.HasIndex(c => c.Cnpj).IsUnique().HasFilter("[Cnpj] IS NOT NULL");
                entity.HasIndex(c => c.Cpf).IsUnique().HasFilter("[Cpf] IS NOT NULL");
            });

            // Seguradora - CNPJ único
            builder.Entity<Seguradora>(entity =>
            {
                entity.HasIndex(s => s.Cnpj).IsUnique();
            });

            // MDFeValePedagio
            builder.Entity<MDFeValePedagio>(entity =>
            {
                entity.HasOne(mv => mv.MDFe)
                    .WithMany(m => m.ValesPedagio)
                    .HasForeignKey(mv => mv.MDFeId)
                    .OnDelete(DeleteBehavior.Cascade);
            });

            // MDFeMdfeTransp
            builder.Entity<MDFeMdfeTransp>(entity =>
            {
                entity.HasIndex(mmt => mmt.ChaveMdfeTransp).IsUnique();

                entity.HasOne(mmt => mmt.MDFe)
                    .WithMany(m => m.DocumentosMdfeTransp)
                    .HasForeignKey(mmt => mmt.MDFeId)
                    .OnDelete(DeleteBehavior.Cascade);

                entity.HasOne(mmt => mmt.MunicipioDescarga)
                    .WithMany(mu => mu.MDFesMdfeTransp)
                    .HasForeignKey(mmt => mmt.MunicipioDescargaId)
                    .OnDelete(DeleteBehavior.Restrict);

                entity.Property(mmt => mmt.QuantidadeRateada)
                    .HasColumnType("decimal(18,3)");
            });

        }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                // Fallback se não configurado via DI
                optionsBuilder.UseSqlServer("Server=localhost;Database=MDFeSystem;Trusted_Connection=true;TrustServerCertificate=true;");
            }
        }
    }
}