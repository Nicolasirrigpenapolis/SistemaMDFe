using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using MDFeApi.Models;

namespace MDFeApi.Data
{
    public class MDFeContext : IdentityDbContext<Usuario, IdentityRole<int>, int>
    {
        public MDFeContext(DbContextOptions<MDFeContext> options) : base(options)
        {
        }

        // DbSets das entidades
        public DbSet<Emitente> Emitentes { get; set; }
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

        // Novas entidades de documentos fiscais
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
            base.OnModelCreating(builder);

            // Configurações das tabelas Identity
            builder.Entity<Usuario>(entity =>
            {
                entity.ToTable("Usuarios");
            });

            builder.Entity<IdentityRole<int>>(entity =>
            {
                entity.ToTable("Roles");
            });

            builder.Entity<IdentityUserRole<int>>(entity =>
            {
                entity.ToTable("UsuarioRoles");
            });

            builder.Entity<IdentityUserClaim<int>>(entity =>
            {
                entity.ToTable("UsuarioClaims");
            });

            builder.Entity<IdentityUserLogin<int>>(entity =>
            {
                entity.ToTable("UsuarioLogins");
            });

            builder.Entity<IdentityUserToken<int>>(entity =>
            {
                entity.ToTable("UsuarioTokens");
            });

            builder.Entity<IdentityRoleClaim<int>>(entity =>
            {
                entity.ToTable("RoleClaims");
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
                    
                entity.Property(e => e.ValorCarga)
                    .HasColumnType("decimal(18,2)");
                    
                entity.Property(e => e.QuantidadeCarga)
                    .HasColumnType("decimal(18,3)");

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

            // MDFeUnidadeTransporte
            builder.Entity<MDFeUnidadeTransporte>(entity =>
            {
                entity.Property(ut => ut.QuantidadeRateada)
                    .HasColumnType("decimal(18,3)");

                entity.HasOne(ut => ut.MDFe)
                    .WithMany(m => m.UnidadesTransporte)
                    .HasForeignKey(ut => ut.MDFeId)
                    .OnDelete(DeleteBehavior.Cascade);

                entity.HasOne(ut => ut.MDFeCte)
                    .WithMany(c => c.UnidadesTransporte)
                    .HasForeignKey(ut => ut.MDFeCteId)
                    .OnDelete(DeleteBehavior.NoAction);

                entity.HasOne(ut => ut.MDFeNfe)
                    .WithMany(n => n.UnidadesTransporte)
                    .HasForeignKey(ut => ut.MDFeNfeId)
                    .OnDelete(DeleteBehavior.NoAction);

                entity.HasOne(ut => ut.MDFeMdfeTransp)
                    .WithMany(mt => mt.UnidadesTransporte)
                    .HasForeignKey(ut => ut.MDFeMdfeTranspId)
                    .OnDelete(DeleteBehavior.NoAction);
            });

            // MDFeUnidadeCarga
            builder.Entity<MDFeUnidadeCarga>(entity =>
            {
                entity.HasOne(uc => uc.UnidadeTransporte)
                    .WithMany(ut => ut.UnidadesCarga)
                    .HasForeignKey(uc => uc.MDFeUnidadeTransporteId)
                    .OnDelete(DeleteBehavior.Cascade);

                entity.Property(uc => uc.QuantidadeRateada)
                    .HasColumnType("decimal(18,3)");
            });

            // MDFeLacreUnidadeTransporte
            builder.Entity<MDFeLacreUnidadeTransporte>(entity =>
            {
                entity.HasOne(lut => lut.UnidadeTransporte)
                    .WithMany(ut => ut.Lacres)
                    .HasForeignKey(lut => lut.MDFeUnidadeTransporteId)
                    .OnDelete(DeleteBehavior.Cascade);
            });

            // MDFeLacreUnidadeCarga
            builder.Entity<MDFeLacreUnidadeCarga>(entity =>
            {
                entity.HasOne(luc => luc.UnidadeCarga)
                    .WithMany(uc => uc.Lacres)
                    .HasForeignKey(luc => luc.MDFeUnidadeCargaId)
                    .OnDelete(DeleteBehavior.Cascade);
            });

            // MDFeLacreRodoviario
            builder.Entity<MDFeLacreRodoviario>(entity =>
            {
                entity.HasOne(lr => lr.MDFe)
                    .WithMany(m => m.LacresRodoviarios)
                    .HasForeignKey(lr => lr.MDFeId)
                    .OnDelete(DeleteBehavior.Cascade);
            });

            // MDFeEntregaParcial
            builder.Entity<MDFeEntregaParcial>(entity =>
            {
                entity.Property(ep => ep.QuantidadeTotal)
                    .HasColumnType("decimal(18,3)");

                entity.Property(ep => ep.QuantidadeParcial)
                    .HasColumnType("decimal(18,3)");

                entity.HasOne(ep => ep.MDFe)
                    .WithMany(m => m.EntregasParciais)
                    .HasForeignKey(ep => ep.MDFeId)
                    .OnDelete(DeleteBehavior.Cascade);

                entity.HasOne(ep => ep.MDFeCte)
                    .WithOne(c => c.EntregaParcial)
                    .HasForeignKey<MDFeEntregaParcial>(ep => ep.MDFeCteId)
                    .OnDelete(DeleteBehavior.NoAction);

                entity.HasOne(ep => ep.MDFeNfe)
                    .WithOne(n => n.EntregaParcial)
                    .HasForeignKey<MDFeEntregaParcial>(ep => ep.MDFeNfeId)
                    .OnDelete(DeleteBehavior.NoAction);
            });

            // MDFeProdutoPerigoso - Configurar para evitar ciclos de cascata
            builder.Entity<MDFeProdutoPerigoso>(entity =>
            {
                entity.HasOne(pp => pp.MDFe)
                    .WithMany(m => m.ProdutosPerigosos)
                    .HasForeignKey(pp => pp.MDFeId)
                    .OnDelete(DeleteBehavior.Cascade);

                entity.HasOne(pp => pp.MDFeCte)
                    .WithMany(c => c.ProdutosPerigosos)
                    .HasForeignKey(pp => pp.MDFeCteId)
                    .OnDelete(DeleteBehavior.NoAction);

                entity.HasOne(pp => pp.MDFeNfe)
                    .WithMany(n => n.ProdutosPerigosos)
                    .HasForeignKey(pp => pp.MDFeNfeId)
                    .OnDelete(DeleteBehavior.NoAction);

                entity.HasOne(pp => pp.MDFeMdfeTransp)
                    .WithMany(mt => mt.ProdutosPerigosos)
                    .HasForeignKey(pp => pp.MDFeMdfeTranspId)
                    .OnDelete(DeleteBehavior.NoAction);
            });

            // MDFeNfePrestacaoParcial
            builder.Entity<MDFeNfePrestacaoParcial>(entity =>
            {
                entity.HasOne(npp => npp.MDFeCte)
                    .WithMany(c => c.NfesPrestacaoParcial)
                    .HasForeignKey(npp => npp.MDFeCteId)
                    .OnDelete(DeleteBehavior.Cascade);
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