using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace MDFeApi.Migrations
{
    /// <inheritdoc />
    public partial class AddDocumentFieldsToMDFe : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "DocumentosCTeJson",
                table: "MDFes",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "DocumentosNFeJson",
                table: "MDFes",
                type: "nvarchar(max)",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "DocumentosCTeJson",
                table: "MDFes");

            migrationBuilder.DropColumn(
                name: "DocumentosNFeJson",
                table: "MDFes");
        }
    }
}
