using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace MDFeApi.Migrations
{
    /// <inheritdoc />
    public partial class AdicionarTelefoneEmailEmitente : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "Email",
                table: "Empresas",
                type: "nvarchar(200)",
                maxLength: 200,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Telefone",
                table: "Empresas",
                type: "nvarchar(20)",
                maxLength: 20,
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Email",
                table: "Empresas");

            migrationBuilder.DropColumn(
                name: "Telefone",
                table: "Empresas");
        }
    }
}
