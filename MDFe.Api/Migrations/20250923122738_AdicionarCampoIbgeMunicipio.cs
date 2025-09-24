using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace MDFeApi.Migrations
{
    /// <inheritdoc />
    public partial class AdicionarCampoIbgeMunicipio : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "DataCriacao",
                table: "MDFeUnidadesTransporte");

            migrationBuilder.DropColumn(
                name: "DataCriacao",
                table: "MDFeProdutosPerigosos");

            migrationBuilder.RenameColumn(
                name: "DataCriacao",
                table: "MDFeEntregasParciais",
                newName: "DataEntrega");

            migrationBuilder.AlterColumn<string>(
                name: "IdentificacaoUnidadeTransporte",
                table: "MDFeUnidadesTransporte",
                type: "nvarchar(50)",
                maxLength: 50,
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(20)",
                oldMaxLength: 20);

            migrationBuilder.AddColumn<decimal>(
                name: "CapacidadeKg",
                table: "MDFeUnidadesTransporte",
                type: "decimal(10,3)",
                nullable: true);

            migrationBuilder.AddColumn<decimal>(
                name: "CapacidadeM3",
                table: "MDFeUnidadesTransporte",
                type: "decimal(10,3)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "CodigoInterno",
                table: "MDFeUnidadesTransporte",
                type: "nvarchar(20)",
                maxLength: 20,
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "Ordem",
                table: "MDFeUnidadesTransporte",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<string>(
                name: "Placa",
                table: "MDFeUnidadesTransporte",
                type: "nvarchar(8)",
                maxLength: 8,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Renavam",
                table: "MDFeUnidadesTransporte",
                type: "nvarchar(11)",
                maxLength: 11,
                nullable: true);

            migrationBuilder.AddColumn<decimal>(
                name: "Tara",
                table: "MDFeUnidadesTransporte",
                type: "decimal(10,3)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "TipoCarroceria",
                table: "MDFeUnidadesTransporte",
                type: "nvarchar(2)",
                maxLength: 2,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "TipoRodado",
                table: "MDFeUnidadesTransporte",
                type: "nvarchar(2)",
                maxLength: 2,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Uf",
                table: "MDFeUnidadesTransporte",
                type: "nvarchar(2)",
                maxLength: 2,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "CodigoCIOT",
                table: "MDFes",
                type: "nvarchar(20)",
                maxLength: 20,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "CodigoNumericoAleatorio",
                table: "MDFes",
                type: "nvarchar(8)",
                maxLength: 8,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "CodigoVerificador",
                table: "MDFes",
                type: "nvarchar(1)",
                maxLength: 1,
                nullable: true);

            migrationBuilder.AddColumn<DateTime>(
                name: "DataGeracao",
                table: "MDFes",
                type: "datetime2",
                nullable: true);

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

            migrationBuilder.AlterColumn<string>(
                name: "QuantidadeVolumoTipo",
                table: "MDFeProdutosPerigosos",
                type: "nvarchar(10)",
                maxLength: 10,
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(60)",
                oldMaxLength: 60,
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "QuantidadeTotalProduto",
                table: "MDFeProdutosPerigosos",
                type: "nvarchar(20)",
                maxLength: 20,
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(20)",
                oldMaxLength: 20);

            migrationBuilder.AlterColumn<string>(
                name: "GrupoEmbalagem",
                table: "MDFeProdutosPerigosos",
                type: "nvarchar(3)",
                maxLength: 3,
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(6)",
                oldMaxLength: 6,
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "ClasseRisco",
                table: "MDFeProdutosPerigosos",
                type: "nvarchar(1)",
                maxLength: 1,
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "nvarchar(40)",
                oldMaxLength: 40,
                oldNullable: true);

            migrationBuilder.AddColumn<string>(
                name: "NomeEmbarque",
                table: "MDFeProdutosPerigosos",
                type: "nvarchar(150)",
                maxLength: 150,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "Observacoes",
                table: "MDFeProdutosPerigosos",
                type: "nvarchar(200)",
                maxLength: 200,
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "Ordem",
                table: "MDFeProdutosPerigosos",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<decimal>(
                name: "QuantidadeTotal",
                table: "MDFeProdutosPerigosos",
                type: "decimal(12,4)",
                nullable: false,
                defaultValue: 0m);

            migrationBuilder.AddColumn<string>(
                name: "UnidadeMedida",
                table: "MDFeProdutosPerigosos",
                type: "nvarchar(2)",
                maxLength: 2,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AlterColumn<string>(
                name: "NumeroLacre",
                table: "MDFeLacresRodoviarios",
                type: "nvarchar(20)",
                maxLength: 20,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(60)",
                oldMaxLength: 60);

            migrationBuilder.AlterColumn<decimal>(
                name: "QuantidadeTotal",
                table: "MDFeEntregasParciais",
                type: "decimal(18,3)",
                nullable: true,
                oldClrType: typeof(decimal),
                oldType: "decimal(18,3)");

            migrationBuilder.AddColumn<string>(
                name: "DescricaoEntrega",
                table: "MDFeEntregasParciais",
                type: "nvarchar(200)",
                maxLength: 200,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "LocalEntrega",
                table: "MDFeEntregasParciais",
                type: "nvarchar(100)",
                maxLength: 100,
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "MDFeMdfeTranspId",
                table: "MDFeEntregasParciais",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "Ordem",
                table: "MDFeEntregasParciais",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateIndex(
                name: "IX_MDFeEntregasParciais_MDFeMdfeTranspId",
                table: "MDFeEntregasParciais",
                column: "MDFeMdfeTranspId");

            migrationBuilder.AddForeignKey(
                name: "FK_MDFeEntregasParciais_MDFeMdfeTransps_MDFeMdfeTranspId",
                table: "MDFeEntregasParciais",
                column: "MDFeMdfeTranspId",
                principalTable: "MDFeMdfeTransps",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_MDFeEntregasParciais_MDFeMdfeTransps_MDFeMdfeTranspId",
                table: "MDFeEntregasParciais");

            migrationBuilder.DropIndex(
                name: "IX_MDFeEntregasParciais_MDFeMdfeTranspId",
                table: "MDFeEntregasParciais");

            migrationBuilder.DropColumn(
                name: "CapacidadeKg",
                table: "MDFeUnidadesTransporte");

            migrationBuilder.DropColumn(
                name: "CapacidadeM3",
                table: "MDFeUnidadesTransporte");

            migrationBuilder.DropColumn(
                name: "CodigoInterno",
                table: "MDFeUnidadesTransporte");

            migrationBuilder.DropColumn(
                name: "Ordem",
                table: "MDFeUnidadesTransporte");

            migrationBuilder.DropColumn(
                name: "Placa",
                table: "MDFeUnidadesTransporte");

            migrationBuilder.DropColumn(
                name: "Renavam",
                table: "MDFeUnidadesTransporte");

            migrationBuilder.DropColumn(
                name: "Tara",
                table: "MDFeUnidadesTransporte");

            migrationBuilder.DropColumn(
                name: "TipoCarroceria",
                table: "MDFeUnidadesTransporte");

            migrationBuilder.DropColumn(
                name: "TipoRodado",
                table: "MDFeUnidadesTransporte");

            migrationBuilder.DropColumn(
                name: "Uf",
                table: "MDFeUnidadesTransporte");

            migrationBuilder.DropColumn(
                name: "CodigoCIOT",
                table: "MDFes");

            migrationBuilder.DropColumn(
                name: "CodigoNumericoAleatorio",
                table: "MDFes");

            migrationBuilder.DropColumn(
                name: "CodigoVerificador",
                table: "MDFes");

            migrationBuilder.DropColumn(
                name: "DataGeracao",
                table: "MDFes");

            migrationBuilder.DropColumn(
                name: "NumeroApolice",
                table: "MDFes");

            migrationBuilder.DropColumn(
                name: "NumeroAverbacao",
                table: "MDFes");

            migrationBuilder.DropColumn(
                name: "NomeEmbarque",
                table: "MDFeProdutosPerigosos");

            migrationBuilder.DropColumn(
                name: "Observacoes",
                table: "MDFeProdutosPerigosos");

            migrationBuilder.DropColumn(
                name: "Ordem",
                table: "MDFeProdutosPerigosos");

            migrationBuilder.DropColumn(
                name: "QuantidadeTotal",
                table: "MDFeProdutosPerigosos");

            migrationBuilder.DropColumn(
                name: "UnidadeMedida",
                table: "MDFeProdutosPerigosos");

            migrationBuilder.DropColumn(
                name: "DescricaoEntrega",
                table: "MDFeEntregasParciais");

            migrationBuilder.DropColumn(
                name: "LocalEntrega",
                table: "MDFeEntregasParciais");

            migrationBuilder.DropColumn(
                name: "MDFeMdfeTranspId",
                table: "MDFeEntregasParciais");

            migrationBuilder.DropColumn(
                name: "Ordem",
                table: "MDFeEntregasParciais");

            migrationBuilder.RenameColumn(
                name: "DataEntrega",
                table: "MDFeEntregasParciais",
                newName: "DataCriacao");

            migrationBuilder.AlterColumn<string>(
                name: "IdentificacaoUnidadeTransporte",
                table: "MDFeUnidadesTransporte",
                type: "nvarchar(20)",
                maxLength: 20,
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "nvarchar(50)",
                oldMaxLength: 50,
                oldNullable: true);

            migrationBuilder.AddColumn<DateTime>(
                name: "DataCriacao",
                table: "MDFeUnidadesTransporte",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.AlterColumn<string>(
                name: "QuantidadeVolumoTipo",
                table: "MDFeProdutosPerigosos",
                type: "nvarchar(60)",
                maxLength: 60,
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(10)",
                oldMaxLength: 10,
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "QuantidadeTotalProduto",
                table: "MDFeProdutosPerigosos",
                type: "nvarchar(20)",
                maxLength: 20,
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "nvarchar(20)",
                oldMaxLength: 20,
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "GrupoEmbalagem",
                table: "MDFeProdutosPerigosos",
                type: "nvarchar(6)",
                maxLength: 6,
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(3)",
                oldMaxLength: 3,
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "ClasseRisco",
                table: "MDFeProdutosPerigosos",
                type: "nvarchar(40)",
                maxLength: 40,
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(1)",
                oldMaxLength: 1);

            migrationBuilder.AddColumn<DateTime>(
                name: "DataCriacao",
                table: "MDFeProdutosPerigosos",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.AlterColumn<string>(
                name: "NumeroLacre",
                table: "MDFeLacresRodoviarios",
                type: "nvarchar(60)",
                maxLength: 60,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(20)",
                oldMaxLength: 20);

            migrationBuilder.AlterColumn<decimal>(
                name: "QuantidadeTotal",
                table: "MDFeEntregasParciais",
                type: "decimal(18,3)",
                nullable: false,
                defaultValue: 0m,
                oldClrType: typeof(decimal),
                oldType: "decimal(18,3)",
                oldNullable: true);
        }
    }
}
