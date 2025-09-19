using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace MDFeApi.Migrations
{
    /// <inheritdoc />
    public partial class AdicionarComponentesPagamentoEValePedagio : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "ComponentesPagamentoJson",
                table: "MDFes",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "SemValePedagio",
                table: "MDFes",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<string>(
                name: "TipoPagamento",
                table: "MDFes",
                type: "nvarchar(1)",
                maxLength: 1,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "ValesPedagioJson",
                table: "MDFes",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<decimal>(
                name: "ValorTotalContrato",
                table: "MDFes",
                type: "decimal(18,2)",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "ComponentesPagamentoJson",
                table: "MDFes");

            migrationBuilder.DropColumn(
                name: "SemValePedagio",
                table: "MDFes");

            migrationBuilder.DropColumn(
                name: "TipoPagamento",
                table: "MDFes");

            migrationBuilder.DropColumn(
                name: "ValesPedagioJson",
                table: "MDFes");

            migrationBuilder.DropColumn(
                name: "ValorTotalContrato",
                table: "MDFes");
        }
    }
}
