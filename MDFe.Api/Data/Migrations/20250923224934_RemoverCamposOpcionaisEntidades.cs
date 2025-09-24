using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace MDFeApi.Data.Migrations
{
    /// <inheritdoc />
    public partial class RemoverCamposOpcionaisEntidades : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "CapacidadeM3",
                table: "Veiculos");

            migrationBuilder.DropColumn(
                name: "Combustivel",
                table: "Veiculos");

            migrationBuilder.DropColumn(
                name: "Cor",
                table: "Veiculos");

            migrationBuilder.DropColumn(
                name: "Renavam",
                table: "Veiculos");

            migrationBuilder.DropColumn(
                name: "Bairro",
                table: "Seguradoras");

            migrationBuilder.DropColumn(
                name: "Cep",
                table: "Seguradoras");

            migrationBuilder.DropColumn(
                name: "CodMunicipio",
                table: "Seguradoras");

            migrationBuilder.DropColumn(
                name: "CodigoSusep",
                table: "Seguradoras");

            migrationBuilder.DropColumn(
                name: "Complemento",
                table: "Seguradoras");

            migrationBuilder.DropColumn(
                name: "Email",
                table: "Seguradoras");

            migrationBuilder.DropColumn(
                name: "Endereco",
                table: "Seguradoras");

            migrationBuilder.DropColumn(
                name: "Municipio",
                table: "Seguradoras");

            migrationBuilder.DropColumn(
                name: "Numero",
                table: "Seguradoras");

            migrationBuilder.DropColumn(
                name: "Telefone",
                table: "Seguradoras");

            migrationBuilder.DropColumn(
                name: "Uf",
                table: "Seguradoras");

            migrationBuilder.DropColumn(
                name: "Ibge",
                table: "Municipios");

            migrationBuilder.DropColumn(
                name: "DescricaoEmitente",
                table: "Empresas");

            migrationBuilder.DropColumn(
                name: "Email",
                table: "Empresas");

            migrationBuilder.DropColumn(
                name: "Telefone",
                table: "Empresas");

            migrationBuilder.DropColumn(
                name: "Email",
                table: "Contratantes");

            migrationBuilder.DropColumn(
                name: "Telefone",
                table: "Contratantes");

            migrationBuilder.DropColumn(
                name: "Telefone",
                table: "Condutores");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<decimal>(
                name: "CapacidadeM3",
                table: "Veiculos",
                type: "decimal(10,3)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Combustivel",
                table: "Veiculos",
                type: "nvarchar(50)",
                maxLength: 50,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "Cor",
                table: "Veiculos",
                type: "nvarchar(50)",
                maxLength: 50,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "Renavam",
                table: "Veiculos",
                type: "nvarchar(11)",
                maxLength: 11,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Bairro",
                table: "Seguradoras",
                type: "nvarchar(100)",
                maxLength: 100,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "Cep",
                table: "Seguradoras",
                type: "nvarchar(8)",
                maxLength: 8,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<int>(
                name: "CodMunicipio",
                table: "Seguradoras",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<string>(
                name: "CodigoSusep",
                table: "Seguradoras",
                type: "nvarchar(50)",
                maxLength: 50,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Complemento",
                table: "Seguradoras",
                type: "nvarchar(100)",
                maxLength: 100,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Email",
                table: "Seguradoras",
                type: "nvarchar(200)",
                maxLength: 200,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Endereco",
                table: "Seguradoras",
                type: "nvarchar(200)",
                maxLength: 200,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "Municipio",
                table: "Seguradoras",
                type: "nvarchar(100)",
                maxLength: 100,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "Numero",
                table: "Seguradoras",
                type: "nvarchar(20)",
                maxLength: 20,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Telefone",
                table: "Seguradoras",
                type: "nvarchar(15)",
                maxLength: 15,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Uf",
                table: "Seguradoras",
                type: "nvarchar(2)",
                maxLength: 2,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "Ibge",
                table: "Municipios",
                type: "nvarchar(20)",
                maxLength: 20,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "DescricaoEmitente",
                table: "Empresas",
                type: "nvarchar(100)",
                maxLength: 100,
                nullable: true);

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

            migrationBuilder.AddColumn<string>(
                name: "Email",
                table: "Contratantes",
                type: "nvarchar(200)",
                maxLength: 200,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Telefone",
                table: "Contratantes",
                type: "nvarchar(15)",
                maxLength: 15,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Telefone",
                table: "Condutores",
                type: "nvarchar(20)",
                maxLength: 20,
                nullable: true);
        }
    }
}
