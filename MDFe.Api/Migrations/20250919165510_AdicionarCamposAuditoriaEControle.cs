using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace MDFeApi.Migrations
{
    /// <inheritdoc />
    public partial class AdicionarCamposAuditoriaEControle : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "DadosOriginaisJson",
                table: "MDFes",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "ObservacoesInternas",
                table: "MDFes",
                type: "nvarchar(500)",
                maxLength: 500,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "UsuarioCriacao",
                table: "MDFes",
                type: "nvarchar(200)",
                maxLength: 200,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "UsuarioUltimaAlteracao",
                table: "MDFes",
                type: "nvarchar(200)",
                maxLength: 200,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "VersaoSistema",
                table: "MDFes",
                type: "nvarchar(100)",
                maxLength: 100,
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "DadosOriginaisJson",
                table: "MDFes");

            migrationBuilder.DropColumn(
                name: "ObservacoesInternas",
                table: "MDFes");

            migrationBuilder.DropColumn(
                name: "UsuarioCriacao",
                table: "MDFes");

            migrationBuilder.DropColumn(
                name: "UsuarioUltimaAlteracao",
                table: "MDFes");

            migrationBuilder.DropColumn(
                name: "VersaoSistema",
                table: "MDFes");
        }
    }
}
