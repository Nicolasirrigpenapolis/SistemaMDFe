using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace MDFeApi.Migrations
{
    /// <inheritdoc />
    public partial class AdicionarTabelaEstados : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "EstadoId",
                table: "Municipios",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "CodigoUf",
                table: "MDFes",
                type: "nvarchar(2)",
                maxLength: 2,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "VersaoModal",
                table: "MDFes",
                type: "nvarchar(10)",
                maxLength: 10,
                nullable: false,
                defaultValue: "");

            migrationBuilder.CreateTable(
                name: "Estados",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Uf = table.Column<string>(type: "nvarchar(2)", maxLength: 2, nullable: false),
                    Nome = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    CodigoIbge = table.Column<string>(type: "nvarchar(2)", maxLength: 2, nullable: false),
                    Ativo = table.Column<bool>(type: "bit", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Estados", x => x.Id);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Municipios_EstadoId",
                table: "Municipios",
                column: "EstadoId");

            migrationBuilder.AddForeignKey(
                name: "FK_Municipios_Estados_EstadoId",
                table: "Municipios",
                column: "EstadoId",
                principalTable: "Estados",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Municipios_Estados_EstadoId",
                table: "Municipios");

            migrationBuilder.DropTable(
                name: "Estados");

            migrationBuilder.DropIndex(
                name: "IX_Municipios_EstadoId",
                table: "Municipios");

            migrationBuilder.DropColumn(
                name: "EstadoId",
                table: "Municipios");

            migrationBuilder.DropColumn(
                name: "CodigoUf",
                table: "MDFes");

            migrationBuilder.DropColumn(
                name: "VersaoModal",
                table: "MDFes");
        }
    }
}
