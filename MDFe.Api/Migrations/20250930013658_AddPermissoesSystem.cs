using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace MDFeApi.Migrations
{
    /// <inheritdoc />
    public partial class AddPermissoesSystem : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Permissoes",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Codigo = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    Nome = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    Descricao = table.Column<string>(type: "nvarchar(500)", maxLength: 500, nullable: true),
                    Modulo = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    Ativo = table.Column<bool>(type: "bit", nullable: false),
                    DataCriacao = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Permissoes", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "CargoPermissoes",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    CargoId = table.Column<int>(type: "int", nullable: false),
                    PermissaoId = table.Column<int>(type: "int", nullable: false),
                    DataCriacao = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CargoPermissoes", x => x.Id);
                    table.ForeignKey(
                        name: "FK_CargoPermissoes_Cargos_CargoId",
                        column: x => x.CargoId,
                        principalTable: "Cargos",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_CargoPermissoes_Permissoes_PermissaoId",
                        column: x => x.PermissaoId,
                        principalTable: "Permissoes",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_CargoPermissoes_CargoId_PermissaoId",
                table: "CargoPermissoes",
                columns: new[] { "CargoId", "PermissaoId" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_CargoPermissoes_PermissaoId",
                table: "CargoPermissoes",
                column: "PermissaoId");

            migrationBuilder.CreateIndex(
                name: "IX_Permissoes_Codigo",
                table: "Permissoes",
                column: "Codigo",
                unique: true);

            // Inserir permissões padrão do sistema
            var permissoes = new[]
            {
                // DASHBOARD
                new { Codigo = "dashboard.view", Nome = "Visualizar Dashboard", Descricao = "Acesso ao painel principal do sistema", Modulo = "Dashboard" },
                new { Codigo = "dashboard.stats", Nome = "Visualizar Estatísticas", Descricao = "Visualizar estatísticas e métricas do dashboard", Modulo = "Dashboard" },

                // MDFE
                new { Codigo = "mdfe.create", Nome = "Criar MDFe", Descricao = "Criar novos manifestos eletrônicos", Modulo = "MDFe" },
                new { Codigo = "mdfe.read", Nome = "Visualizar MDFe", Descricao = "Visualizar manifestos eletrônicos", Modulo = "MDFe" },
                new { Codigo = "mdfe.update", Nome = "Editar MDFe", Descricao = "Editar manifestos eletrônicos existentes", Modulo = "MDFe" },
                new { Codigo = "mdfe.delete", Nome = "Excluir MDFe", Descricao = "Excluir manifestos eletrônicos", Modulo = "MDFe" },
                new { Codigo = "mdfe.transmit", Nome = "Transmitir MDFe", Descricao = "Transmitir manifestos para SEFAZ", Modulo = "MDFe" },
                new { Codigo = "mdfe.cancel", Nome = "Cancelar MDFe", Descricao = "Cancelar manifestos na SEFAZ", Modulo = "MDFe" },

                // EMITENTES
                new { Codigo = "emitentes.create", Nome = "Criar Emitente", Descricao = "Criar novos emitentes", Modulo = "Emitentes" },
                new { Codigo = "emitentes.read", Nome = "Visualizar Emitentes", Descricao = "Visualizar dados dos emitentes", Modulo = "Emitentes" },
                new { Codigo = "emitentes.update", Nome = "Editar Emitentes", Descricao = "Editar dados dos emitentes", Modulo = "Emitentes" },
                new { Codigo = "emitentes.delete", Nome = "Excluir Emitentes", Descricao = "Excluir emitentes do sistema", Modulo = "Emitentes" },

                // VEICULOS
                new { Codigo = "veiculos.create", Nome = "Criar Veículo", Descricao = "Criar novos veículos", Modulo = "Veículos" },
                new { Codigo = "veiculos.read", Nome = "Visualizar Veículos", Descricao = "Visualizar dados dos veículos", Modulo = "Veículos" },
                new { Codigo = "veiculos.update", Nome = "Editar Veículos", Descricao = "Editar dados dos veículos", Modulo = "Veículos" },
                new { Codigo = "veiculos.delete", Nome = "Excluir Veículos", Descricao = "Excluir veículos do sistema", Modulo = "Veículos" },

                // REBOQUES
                new { Codigo = "reboques.create", Nome = "Criar Reboque", Descricao = "Criar novos reboques", Modulo = "Reboques" },
                new { Codigo = "reboques.read", Nome = "Visualizar Reboques", Descricao = "Visualizar dados dos reboques", Modulo = "Reboques" },
                new { Codigo = "reboques.update", Nome = "Editar Reboques", Descricao = "Editar dados dos reboques", Modulo = "Reboques" },
                new { Codigo = "reboques.delete", Nome = "Excluir Reboques", Descricao = "Excluir reboques do sistema", Modulo = "Reboques" },

                // CONDUTORES
                new { Codigo = "condutores.create", Nome = "Criar Condutor", Descricao = "Criar novos condutores", Modulo = "Condutores" },
                new { Codigo = "condutores.read", Nome = "Visualizar Condutores", Descricao = "Visualizar dados dos condutores", Modulo = "Condutores" },
                new { Codigo = "condutores.update", Nome = "Editar Condutores", Descricao = "Editar dados dos condutores", Modulo = "Condutores" },
                new { Codigo = "condutores.delete", Nome = "Excluir Condutores", Descricao = "Excluir condutores do sistema", Modulo = "Condutores" },

                // CONTRATANTES
                new { Codigo = "contratantes.create", Nome = "Criar Contratante", Descricao = "Criar novos contratantes", Modulo = "Contratantes" },
                new { Codigo = "contratantes.read", Nome = "Visualizar Contratantes", Descricao = "Visualizar dados dos contratantes", Modulo = "Contratantes" },
                new { Codigo = "contratantes.update", Nome = "Editar Contratantes", Descricao = "Editar dados dos contratantes", Modulo = "Contratantes" },
                new { Codigo = "contratantes.delete", Nome = "Excluir Contratantes", Descricao = "Excluir contratantes do sistema", Modulo = "Contratantes" },

                // SEGURADORAS
                new { Codigo = "seguradoras.create", Nome = "Criar Seguradora", Descricao = "Criar novas seguradoras", Modulo = "Seguradoras" },
                new { Codigo = "seguradoras.read", Nome = "Visualizar Seguradoras", Descricao = "Visualizar dados das seguradoras", Modulo = "Seguradoras" },
                new { Codigo = "seguradoras.update", Nome = "Editar Seguradoras", Descricao = "Editar dados das seguradoras", Modulo = "Seguradoras" },
                new { Codigo = "seguradoras.delete", Nome = "Excluir Seguradoras", Descricao = "Excluir seguradoras do sistema", Modulo = "Seguradoras" },

                // MUNICIPIOS
                new { Codigo = "municipios.read", Nome = "Visualizar Municípios", Descricao = "Visualizar dados dos municípios", Modulo = "Municípios" },
                new { Codigo = "municipios.import", Nome = "Importar Municípios", Descricao = "Importar dados do IBGE", Modulo = "Municípios" },

                // ADMIN - USUARIOS
                new { Codigo = "admin.users.create", Nome = "Criar Usuário", Descricao = "Criar novos usuários do sistema", Modulo = "Administração" },
                new { Codigo = "admin.users.read", Nome = "Visualizar Usuários", Descricao = "Visualizar dados dos usuários", Modulo = "Administração" },
                new { Codigo = "admin.users.update", Nome = "Editar Usuários", Descricao = "Editar dados dos usuários", Modulo = "Administração" },
                new { Codigo = "admin.users.delete", Nome = "Excluir Usuários", Descricao = "Excluir usuários do sistema", Modulo = "Administração" },

                // ADMIN - CARGOS (apenas Programador)
                new { Codigo = "admin.roles.create", Nome = "Criar Cargo", Descricao = "Criar novos cargos do sistema", Modulo = "Administração" },
                new { Codigo = "admin.roles.read", Nome = "Visualizar Cargos", Descricao = "Visualizar dados dos cargos", Modulo = "Administração" },
                new { Codigo = "admin.roles.update", Nome = "Editar Cargos", Descricao = "Editar dados dos cargos", Modulo = "Administração" },
                new { Codigo = "admin.roles.delete", Nome = "Excluir Cargos", Descricao = "Excluir cargos do sistema", Modulo = "Administração" },

                // ADMIN - PERMISSOES (apenas Programador)
                new { Codigo = "admin.permissions.read", Nome = "Visualizar Permissões", Descricao = "Visualizar permissões do sistema", Modulo = "Administração" },
                new { Codigo = "admin.permissions.assign", Nome = "Atribuir Permissões", Descricao = "Atribuir permissões aos cargos", Modulo = "Administração" }
            };

            foreach (var permissao in permissoes)
            {
                migrationBuilder.InsertData(
                    table: "Permissoes",
                    columns: new[] { "Codigo", "Nome", "Descricao", "Modulo", "Ativo", "DataCriacao" },
                    values: new object[] { permissao.Codigo, permissao.Nome, permissao.Descricao, permissao.Modulo, true, DateTime.Now });
            }

            // Atribuir TODAS as permissões ao cargo "Programador"
            migrationBuilder.Sql(@"
                INSERT INTO CargoPermissoes (CargoId, PermissaoId, DataCriacao)
                SELECT c.Id, p.Id, GETDATE()
                FROM Cargos c
                CROSS JOIN Permissoes p
                WHERE c.Nome = 'Programador'
            ");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "CargoPermissoes");

            migrationBuilder.DropTable(
                name: "Permissoes");
        }
    }
}
