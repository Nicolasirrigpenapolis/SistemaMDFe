using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace MDFeApi.Migrations
{
    /// <inheritdoc />
    public partial class AddLocalidadesERota : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "LocalidadesCarregamentoJson",
                table: "MDFes",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "LocalidadesDescarregamentoJson",
                table: "MDFes",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "RotaPercursoJson",
                table: "MDFes",
                type: "nvarchar(max)",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "LocalidadesCarregamentoJson",
                table: "MDFes");

            migrationBuilder.DropColumn(
                name: "LocalidadesDescarregamentoJson",
                table: "MDFes");

            migrationBuilder.DropColumn(
                name: "RotaPercursoJson",
                table: "MDFes");
        }
    }
}
