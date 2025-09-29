using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace MDFeApi.Migrations
{
    /// <inheritdoc />
    public partial class PadronizarNomenclaturaCampos : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "NumeroApolice",
                table: "MDFes");

            migrationBuilder.DropColumn(
                name: "NumeroAverbacao",
                table: "MDFes");

            migrationBuilder.DropColumn(
                name: "QuantidadeCarga",
                table: "MDFes");

            migrationBuilder.RenameColumn(
                name: "ValorCarga",
                table: "MDFes",
                newName: "ValorTotal");

            migrationBuilder.RenameColumn(
                name: "UfInicio",
                table: "MDFes",
                newName: "UfIni");

            migrationBuilder.RenameColumn(
                name: "ValorCarga",
                table: "MDFeNfes",
                newName: "ValorTotal");

            migrationBuilder.RenameColumn(
                name: "ValorCarga",
                table: "MDFeCtes",
                newName: "ValorTotal");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "ValorTotal",
                table: "MDFes",
                newName: "ValorCarga");

            migrationBuilder.RenameColumn(
                name: "UfIni",
                table: "MDFes",
                newName: "UfInicio");

            migrationBuilder.RenameColumn(
                name: "ValorTotal",
                table: "MDFeNfes",
                newName: "ValorCarga");

            migrationBuilder.RenameColumn(
                name: "ValorTotal",
                table: "MDFeCtes",
                newName: "ValorCarga");

            migrationBuilder.AddColumn<string>(
                name: "NumeroApolice",
                table: "MDFes",
                type: "nvarchar(50)",
                maxLength: 50,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "NumeroAverbacao",
                table: "MDFes",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<decimal>(
                name: "QuantidadeCarga",
                table: "MDFes",
                type: "decimal(18,3)",
                nullable: true);
        }
    }
}
