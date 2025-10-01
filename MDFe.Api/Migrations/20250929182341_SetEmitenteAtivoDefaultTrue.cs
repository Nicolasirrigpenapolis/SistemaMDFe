using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace MDFeApi.Migrations
{
    /// <inheritdoc />
    public partial class SetEmitenteAtivoDefaultTrue : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            // Definir valor padrão TRUE para a coluna Ativo da tabela Empresas
            migrationBuilder.AlterColumn<bool>(
                name: "Ativo",
                table: "Empresas",
                type: "bit",
                nullable: false,
                defaultValue: true,
                oldClrType: typeof(bool),
                oldType: "bit");

            // Atualizar todos os registros existentes para Ativo = true
            migrationBuilder.Sql("UPDATE Empresas SET Ativo = 1 WHERE Ativo = 0");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            // Remover valor padrão da coluna Ativo
            migrationBuilder.AlterColumn<bool>(
                name: "Ativo",
                table: "Empresas",
                type: "bit",
                nullable: false,
                oldClrType: typeof(bool),
                oldType: "bit",
                oldDefaultValue: true);
        }
    }
}
