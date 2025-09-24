using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace MDFeApi.Migrations
{
    /// <inheritdoc />
    public partial class AdicionarCamposFaltantesCadastros : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<decimal>(
                name: "CapacidadeM3",
                table: "Veiculos",
                type: "decimal(10,3)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "CodigoSusep",
                table: "Seguradoras",
                type: "nvarchar(50)",
                maxLength: 50,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Email",
                table: "Seguradoras",
                type: "nvarchar(200)",
                maxLength: 200,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "NomeFantasia",
                table: "Seguradoras",
                type: "nvarchar(200)",
                maxLength: 200,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Ie",
                table: "Contratantes",
                type: "nvarchar(20)",
                maxLength: 20,
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "CapacidadeM3",
                table: "Veiculos");

            migrationBuilder.DropColumn(
                name: "CodigoSusep",
                table: "Seguradoras");

            migrationBuilder.DropColumn(
                name: "Email",
                table: "Seguradoras");

            migrationBuilder.DropColumn(
                name: "NomeFantasia",
                table: "Seguradoras");

            migrationBuilder.DropColumn(
                name: "Ie",
                table: "Contratantes");
        }
    }
}
