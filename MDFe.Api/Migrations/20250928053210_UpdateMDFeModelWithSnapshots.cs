using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace MDFeApi.Migrations
{
    /// <inheritdoc />
    public partial class UpdateMDFeModelWithSnapshots : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_MDFeLacresUnidadeCarga_MDFeUnidadesCarga_MDFeUnidadeCargaId",
                table: "MDFeLacresUnidadeCarga");

            migrationBuilder.DropForeignKey(
                name: "FK_MDFeLacresUnidadeTransporte_MDFeUnidadesTransporte_MDFeUnidadeTransporteId",
                table: "MDFeLacresUnidadeTransporte");

            migrationBuilder.DropForeignKey(
                name: "FK_MDFeNfesPrestacaoParcial_MDFeCtes_MDFeCteId",
                table: "MDFeNfesPrestacaoParcial");

            migrationBuilder.DropForeignKey(
                name: "FK_MDFeUnidadesCarga_MDFeUnidadesTransporte_MDFeUnidadeTransporteId",
                table: "MDFeUnidadesCarga");

            migrationBuilder.DropIndex(
                name: "IX_MDFeNfesPrestacaoParcial_MDFeCteId",
                table: "MDFeNfesPrestacaoParcial");

            migrationBuilder.DropIndex(
                name: "IX_MDFeEntregasParciais_MDFeCteId",
                table: "MDFeEntregasParciais");

            migrationBuilder.DropIndex(
                name: "IX_MDFeEntregasParciais_MDFeNfeId",
                table: "MDFeEntregasParciais");

            migrationBuilder.DropColumn(
                name: "Marca",
                table: "Veiculos");

            migrationBuilder.DropColumn(
                name: "CapacidadeKg",
                table: "Reboques");

            migrationBuilder.DropColumn(
                name: "Renavam",
                table: "Reboques");

            migrationBuilder.DropColumn(
                name: "Renavam",
                table: "MDFeUnidadesTransporte");

            migrationBuilder.DropColumn(
                name: "IdentificacaoUnidadeCarga",
                table: "MDFeUnidadesCarga");

            migrationBuilder.DropColumn(
                name: "CnpjContratante",
                table: "MDFes");

            migrationBuilder.DropColumn(
                name: "ContratanteEmail",
                table: "MDFes");

            migrationBuilder.DropColumn(
                name: "ContratanteTelefone",
                table: "MDFes");

            migrationBuilder.DropColumn(
                name: "EmitenteEmail",
                table: "MDFes");

            migrationBuilder.DropColumn(
                name: "EmitenteTelefone",
                table: "MDFes");

            migrationBuilder.DropColumn(
                name: "Rntrc",
                table: "MDFes");

            migrationBuilder.DropColumn(
                name: "SeguradoraCodigoSusep",
                table: "MDFes");

            migrationBuilder.DropColumn(
                name: "VeiculoAno",
                table: "MDFes");

            migrationBuilder.DropColumn(
                name: "VeiculoCapacidadeKg",
                table: "MDFes");

            migrationBuilder.DropColumn(
                name: "VeiculoCombustivel",
                table: "MDFes");

            migrationBuilder.DropColumn(
                name: "VeiculoCor",
                table: "MDFes");

            migrationBuilder.DropColumn(
                name: "VeiculoMarca",
                table: "MDFes");

            migrationBuilder.DropColumn(
                name: "VeiculoModelo",
                table: "MDFes");

            migrationBuilder.DropColumn(
                name: "VeiculoRenavam",
                table: "MDFes");

            migrationBuilder.DropColumn(
                name: "ChaveNfe",
                table: "MDFeNfesPrestacaoParcial");

            migrationBuilder.DropColumn(
                name: "CnpjColeta",
                table: "MDFeNfes");

            migrationBuilder.DropColumn(
                name: "CnpjEntrega",
                table: "MDFeNfes");

            migrationBuilder.DropColumn(
                name: "DataPrevistaEntrega",
                table: "MDFeNfes");

            migrationBuilder.DropColumn(
                name: "DescricaoMunicipioDescarga",
                table: "MDFeNfes");

            migrationBuilder.DropColumn(
                name: "IndicadorReentrega",
                table: "MDFeNfes");

            migrationBuilder.DropColumn(
                name: "CnpjColeta",
                table: "MDFeMdfeTransps");

            migrationBuilder.DropColumn(
                name: "CnpjEntrega",
                table: "MDFeMdfeTransps");

            migrationBuilder.DropColumn(
                name: "DescricaoMunicipioDescarga",
                table: "MDFeMdfeTransps");

            migrationBuilder.DropColumn(
                name: "IndicadorReentrega",
                table: "MDFeMdfeTransps");

            migrationBuilder.DropColumn(
                name: "PesoBruto",
                table: "MDFeMdfeTransps");

            migrationBuilder.DropColumn(
                name: "SegCodigoBarras",
                table: "MDFeMdfeTransps");

            migrationBuilder.DropColumn(
                name: "SegundoCodigoBarras",
                table: "MDFeMdfeTransps");

            migrationBuilder.DropColumn(
                name: "ValorCarga",
                table: "MDFeMdfeTransps");

            migrationBuilder.DropColumn(
                name: "CnpjColeta",
                table: "MDFeCtes");

            migrationBuilder.DropColumn(
                name: "CnpjEntrega",
                table: "MDFeCtes");

            migrationBuilder.DropColumn(
                name: "DescricaoMunicipioDescarga",
                table: "MDFeCtes");

            migrationBuilder.DropColumn(
                name: "IndicadorPrestacaoParcial",
                table: "MDFeCtes");

            migrationBuilder.DropColumn(
                name: "IndicadorReentrega",
                table: "MDFeCtes");

            migrationBuilder.RenameColumn(
                name: "QuantidadeRateada",
                table: "MDFeUnidadesCarga",
                newName: "QtdRat");

            migrationBuilder.RenameColumn(
                name: "MDFeCteId",
                table: "MDFeNfesPrestacaoParcial",
                newName: "Ordem");

            migrationBuilder.RenameColumn(
                name: "MDFeUnidadeCargaId",
                table: "MDFeLacresUnidadeCarga",
                newName: "UnidadeCargaId");

            migrationBuilder.RenameIndex(
                name: "IX_MDFeLacresUnidadeCarga_MDFeUnidadeCargaId",
                table: "MDFeLacresUnidadeCarga",
                newName: "IX_MDFeLacresUnidadeCarga_UnidadeCargaId");

            migrationBuilder.RenameColumn(
                name: "DataAtualizacao",
                table: "Empresas",
                newName: "DataUltimaAlteracao");

            migrationBuilder.AddColumn<DateTime>(
                name: "DataUltimaAlteracao",
                table: "Veiculos",
                type: "datetime2",
                nullable: true);

            migrationBuilder.AddColumn<DateTime>(
                name: "DataUltimaAlteracao",
                table: "Usuarios",
                type: "datetime2",
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

            migrationBuilder.AddColumn<DateTime>(
                name: "DataUltimaAlteracao",
                table: "Reboques",
                type: "datetime2",
                nullable: true);

            migrationBuilder.AlterColumn<decimal>(
                name: "QuantidadeRateada",
                table: "MDFeUnidadesTransporte",
                type: "decimal(10,3)",
                nullable: true,
                oldClrType: typeof(decimal),
                oldType: "decimal(18,3)",
                oldNullable: true);

            migrationBuilder.AlterColumn<int>(
                name: "MDFeUnidadeTransporteId",
                table: "MDFeUnidadesCarga",
                type: "int",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.AddColumn<string>(
                name: "IdUnidadeCarga",
                table: "MDFeUnidadesCarga",
                type: "nvarchar(50)",
                maxLength: 50,
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "MDFeId",
                table: "MDFeUnidadesCarga",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "Ordem",
                table: "MDFeUnidadesCarga",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<string>(
                name: "DenominacaoMercadoria",
                table: "MDFeNfesPrestacaoParcial",
                type: "nvarchar(15)",
                maxLength: 15,
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "NFeId",
                table: "MDFeNfesPrestacaoParcial",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<decimal>(
                name: "QtdeParcial",
                table: "MDFeNfesPrestacaoParcial",
                type: "decimal(15,2)",
                nullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "SegundoCodigoBarras",
                table: "MDFeNfes",
                type: "nvarchar(3)",
                maxLength: 3,
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)",
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "NumeroLacre",
                table: "MDFeLacresUnidadeTransporte",
                type: "nvarchar(20)",
                maxLength: 20,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(60)",
                oldMaxLength: 60);

            migrationBuilder.AlterColumn<int>(
                name: "MDFeUnidadeTransporteId",
                table: "MDFeLacresUnidadeTransporte",
                type: "int",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.AddColumn<int>(
                name: "MDFeId",
                table: "MDFeLacresUnidadeTransporte",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "Ordem",
                table: "MDFeLacresUnidadeTransporte",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AlterColumn<string>(
                name: "NumeroLacre",
                table: "MDFeLacresUnidadeCarga",
                type: "nvarchar(20)",
                maxLength: 20,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(60)",
                oldMaxLength: 60);

            migrationBuilder.AddColumn<int>(
                name: "Ordem",
                table: "MDFeLacresUnidadeCarga",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AlterColumn<decimal>(
                name: "QuantidadeTotal",
                table: "MDFeEntregasParciais",
                type: "decimal(12,4)",
                nullable: true,
                oldClrType: typeof(decimal),
                oldType: "decimal(18,3)",
                oldNullable: true);

            migrationBuilder.AlterColumn<decimal>(
                name: "QuantidadeParcial",
                table: "MDFeEntregasParciais",
                type: "decimal(12,4)",
                nullable: false,
                oldClrType: typeof(decimal),
                oldType: "decimal(18,3)");

            migrationBuilder.AlterColumn<string>(
                name: "SegundoCodigoBarras",
                table: "MDFeCtes",
                type: "nvarchar(3)",
                maxLength: 3,
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)",
                oldNullable: true);

            migrationBuilder.AddColumn<int>(
                name: "ModalTransporte",
                table: "Empresas",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "SerieInicial",
                table: "Empresas",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "TipoTransportador",
                table: "Empresas",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<string>(
                name: "Email",
                table: "Contratantes",
                type: "nvarchar(200)",
                maxLength: 200,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Telefone",
                table: "Contratantes",
                type: "nvarchar(20)",
                maxLength: 20,
                nullable: true);

            migrationBuilder.AddColumn<DateTime>(
                name: "DataUltimaAlteracao",
                table: "Condutores",
                type: "datetime2",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Telefone",
                table: "Condutores",
                type: "nvarchar(20)",
                maxLength: 20,
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_MDFeUnidadesCarga_MDFeId",
                table: "MDFeUnidadesCarga",
                column: "MDFeId");

            migrationBuilder.CreateIndex(
                name: "IX_MDFeNfesPrestacaoParcial_NFeId",
                table: "MDFeNfesPrestacaoParcial",
                column: "NFeId");

            migrationBuilder.CreateIndex(
                name: "IX_MDFeLacresUnidadeTransporte_MDFeId",
                table: "MDFeLacresUnidadeTransporte",
                column: "MDFeId");

            migrationBuilder.CreateIndex(
                name: "IX_MDFeEntregasParciais_MDFeCteId",
                table: "MDFeEntregasParciais",
                column: "MDFeCteId");

            migrationBuilder.CreateIndex(
                name: "IX_MDFeEntregasParciais_MDFeNfeId",
                table: "MDFeEntregasParciais",
                column: "MDFeNfeId");

            migrationBuilder.AddForeignKey(
                name: "FK_MDFeLacresUnidadeCarga_MDFeUnidadesCarga_UnidadeCargaId",
                table: "MDFeLacresUnidadeCarga",
                column: "UnidadeCargaId",
                principalTable: "MDFeUnidadesCarga",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_MDFeLacresUnidadeTransporte_MDFeUnidadesTransporte_MDFeUnidadeTransporteId",
                table: "MDFeLacresUnidadeTransporte",
                column: "MDFeUnidadeTransporteId",
                principalTable: "MDFeUnidadesTransporte",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_MDFeLacresUnidadeTransporte_MDFes_MDFeId",
                table: "MDFeLacresUnidadeTransporte",
                column: "MDFeId",
                principalTable: "MDFes",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_MDFeNfesPrestacaoParcial_MDFeNfes_NFeId",
                table: "MDFeNfesPrestacaoParcial",
                column: "NFeId",
                principalTable: "MDFeNfes",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_MDFeUnidadesCarga_MDFeUnidadesTransporte_MDFeUnidadeTransporteId",
                table: "MDFeUnidadesCarga",
                column: "MDFeUnidadeTransporteId",
                principalTable: "MDFeUnidadesTransporte",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_MDFeUnidadesCarga_MDFes_MDFeId",
                table: "MDFeUnidadesCarga",
                column: "MDFeId",
                principalTable: "MDFes",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_MDFeLacresUnidadeCarga_MDFeUnidadesCarga_UnidadeCargaId",
                table: "MDFeLacresUnidadeCarga");

            migrationBuilder.DropForeignKey(
                name: "FK_MDFeLacresUnidadeTransporte_MDFeUnidadesTransporte_MDFeUnidadeTransporteId",
                table: "MDFeLacresUnidadeTransporte");

            migrationBuilder.DropForeignKey(
                name: "FK_MDFeLacresUnidadeTransporte_MDFes_MDFeId",
                table: "MDFeLacresUnidadeTransporte");

            migrationBuilder.DropForeignKey(
                name: "FK_MDFeNfesPrestacaoParcial_MDFeNfes_NFeId",
                table: "MDFeNfesPrestacaoParcial");

            migrationBuilder.DropForeignKey(
                name: "FK_MDFeUnidadesCarga_MDFeUnidadesTransporte_MDFeUnidadeTransporteId",
                table: "MDFeUnidadesCarga");

            migrationBuilder.DropForeignKey(
                name: "FK_MDFeUnidadesCarga_MDFes_MDFeId",
                table: "MDFeUnidadesCarga");

            migrationBuilder.DropIndex(
                name: "IX_MDFeUnidadesCarga_MDFeId",
                table: "MDFeUnidadesCarga");

            migrationBuilder.DropIndex(
                name: "IX_MDFeNfesPrestacaoParcial_NFeId",
                table: "MDFeNfesPrestacaoParcial");

            migrationBuilder.DropIndex(
                name: "IX_MDFeLacresUnidadeTransporte_MDFeId",
                table: "MDFeLacresUnidadeTransporte");

            migrationBuilder.DropIndex(
                name: "IX_MDFeEntregasParciais_MDFeCteId",
                table: "MDFeEntregasParciais");

            migrationBuilder.DropIndex(
                name: "IX_MDFeEntregasParciais_MDFeNfeId",
                table: "MDFeEntregasParciais");

            migrationBuilder.DropColumn(
                name: "DataUltimaAlteracao",
                table: "Veiculos");

            migrationBuilder.DropColumn(
                name: "DataUltimaAlteracao",
                table: "Usuarios");

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
                name: "DataUltimaAlteracao",
                table: "Reboques");

            migrationBuilder.DropColumn(
                name: "IdUnidadeCarga",
                table: "MDFeUnidadesCarga");

            migrationBuilder.DropColumn(
                name: "MDFeId",
                table: "MDFeUnidadesCarga");

            migrationBuilder.DropColumn(
                name: "Ordem",
                table: "MDFeUnidadesCarga");

            migrationBuilder.DropColumn(
                name: "DenominacaoMercadoria",
                table: "MDFeNfesPrestacaoParcial");

            migrationBuilder.DropColumn(
                name: "NFeId",
                table: "MDFeNfesPrestacaoParcial");

            migrationBuilder.DropColumn(
                name: "QtdeParcial",
                table: "MDFeNfesPrestacaoParcial");

            migrationBuilder.DropColumn(
                name: "MDFeId",
                table: "MDFeLacresUnidadeTransporte");

            migrationBuilder.DropColumn(
                name: "Ordem",
                table: "MDFeLacresUnidadeTransporte");

            migrationBuilder.DropColumn(
                name: "Ordem",
                table: "MDFeLacresUnidadeCarga");

            migrationBuilder.DropColumn(
                name: "ModalTransporte",
                table: "Empresas");

            migrationBuilder.DropColumn(
                name: "SerieInicial",
                table: "Empresas");

            migrationBuilder.DropColumn(
                name: "TipoTransportador",
                table: "Empresas");

            migrationBuilder.DropColumn(
                name: "Email",
                table: "Contratantes");

            migrationBuilder.DropColumn(
                name: "Telefone",
                table: "Contratantes");

            migrationBuilder.DropColumn(
                name: "DataUltimaAlteracao",
                table: "Condutores");

            migrationBuilder.DropColumn(
                name: "Telefone",
                table: "Condutores");

            migrationBuilder.RenameColumn(
                name: "QtdRat",
                table: "MDFeUnidadesCarga",
                newName: "QuantidadeRateada");

            migrationBuilder.RenameColumn(
                name: "Ordem",
                table: "MDFeNfesPrestacaoParcial",
                newName: "MDFeCteId");

            migrationBuilder.RenameColumn(
                name: "UnidadeCargaId",
                table: "MDFeLacresUnidadeCarga",
                newName: "MDFeUnidadeCargaId");

            migrationBuilder.RenameIndex(
                name: "IX_MDFeLacresUnidadeCarga_UnidadeCargaId",
                table: "MDFeLacresUnidadeCarga",
                newName: "IX_MDFeLacresUnidadeCarga_MDFeUnidadeCargaId");

            migrationBuilder.RenameColumn(
                name: "DataUltimaAlteracao",
                table: "Empresas",
                newName: "DataAtualizacao");

            migrationBuilder.AddColumn<string>(
                name: "Marca",
                table: "Veiculos",
                type: "nvarchar(100)",
                maxLength: 100,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<int>(
                name: "CapacidadeKg",
                table: "Reboques",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<string>(
                name: "Renavam",
                table: "Reboques",
                type: "nvarchar(11)",
                maxLength: 11,
                nullable: true);

            migrationBuilder.AlterColumn<decimal>(
                name: "QuantidadeRateada",
                table: "MDFeUnidadesTransporte",
                type: "decimal(18,3)",
                nullable: true,
                oldClrType: typeof(decimal),
                oldType: "decimal(10,3)",
                oldNullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Renavam",
                table: "MDFeUnidadesTransporte",
                type: "nvarchar(11)",
                maxLength: 11,
                nullable: true);

            migrationBuilder.AlterColumn<int>(
                name: "MDFeUnidadeTransporteId",
                table: "MDFeUnidadesCarga",
                type: "int",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "int",
                oldNullable: true);

            migrationBuilder.AddColumn<string>(
                name: "IdentificacaoUnidadeCarga",
                table: "MDFeUnidadesCarga",
                type: "nvarchar(20)",
                maxLength: 20,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "CnpjContratante",
                table: "MDFes",
                type: "nvarchar(14)",
                maxLength: 14,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "ContratanteEmail",
                table: "MDFes",
                type: "nvarchar(200)",
                maxLength: 200,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "ContratanteTelefone",
                table: "MDFes",
                type: "nvarchar(20)",
                maxLength: 20,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "EmitenteEmail",
                table: "MDFes",
                type: "nvarchar(200)",
                maxLength: 200,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "EmitenteTelefone",
                table: "MDFes",
                type: "nvarchar(20)",
                maxLength: 20,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Rntrc",
                table: "MDFes",
                type: "nvarchar(20)",
                maxLength: 20,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "SeguradoraCodigoSusep",
                table: "MDFes",
                type: "nvarchar(50)",
                maxLength: 50,
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "VeiculoAno",
                table: "MDFes",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "VeiculoCapacidadeKg",
                table: "MDFes",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "VeiculoCombustivel",
                table: "MDFes",
                type: "nvarchar(50)",
                maxLength: 50,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "VeiculoCor",
                table: "MDFes",
                type: "nvarchar(50)",
                maxLength: 50,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "VeiculoMarca",
                table: "MDFes",
                type: "nvarchar(100)",
                maxLength: 100,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "VeiculoModelo",
                table: "MDFes",
                type: "nvarchar(100)",
                maxLength: 100,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "VeiculoRenavam",
                table: "MDFes",
                type: "nvarchar(11)",
                maxLength: 11,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "ChaveNfe",
                table: "MDFeNfesPrestacaoParcial",
                type: "nvarchar(44)",
                maxLength: 44,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AlterColumn<string>(
                name: "SegundoCodigoBarras",
                table: "MDFeNfes",
                type: "nvarchar(max)",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(3)",
                oldMaxLength: 3,
                oldNullable: true);

            migrationBuilder.AddColumn<string>(
                name: "CnpjColeta",
                table: "MDFeNfes",
                type: "nvarchar(14)",
                maxLength: 14,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "CnpjEntrega",
                table: "MDFeNfes",
                type: "nvarchar(14)",
                maxLength: 14,
                nullable: true);

            migrationBuilder.AddColumn<DateTime>(
                name: "DataPrevistaEntrega",
                table: "MDFeNfes",
                type: "datetime2",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "DescricaoMunicipioDescarga",
                table: "MDFeNfes",
                type: "nvarchar(100)",
                maxLength: 100,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "IndicadorReentrega",
                table: "MDFeNfes",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "CnpjColeta",
                table: "MDFeMdfeTransps",
                type: "nvarchar(14)",
                maxLength: 14,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "CnpjEntrega",
                table: "MDFeMdfeTransps",
                type: "nvarchar(14)",
                maxLength: 14,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "DescricaoMunicipioDescarga",
                table: "MDFeMdfeTransps",
                type: "nvarchar(100)",
                maxLength: 100,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "IndicadorReentrega",
                table: "MDFeMdfeTransps",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<decimal>(
                name: "PesoBruto",
                table: "MDFeMdfeTransps",
                type: "decimal(10,3)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "SegCodigoBarras",
                table: "MDFeMdfeTransps",
                type: "nvarchar(3)",
                maxLength: 3,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "SegundoCodigoBarras",
                table: "MDFeMdfeTransps",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<decimal>(
                name: "ValorCarga",
                table: "MDFeMdfeTransps",
                type: "decimal(10,2)",
                nullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "NumeroLacre",
                table: "MDFeLacresUnidadeTransporte",
                type: "nvarchar(60)",
                maxLength: 60,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(20)",
                oldMaxLength: 20);

            migrationBuilder.AlterColumn<int>(
                name: "MDFeUnidadeTransporteId",
                table: "MDFeLacresUnidadeTransporte",
                type: "int",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "int",
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "NumeroLacre",
                table: "MDFeLacresUnidadeCarga",
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
                nullable: true,
                oldClrType: typeof(decimal),
                oldType: "decimal(12,4)",
                oldNullable: true);

            migrationBuilder.AlterColumn<decimal>(
                name: "QuantidadeParcial",
                table: "MDFeEntregasParciais",
                type: "decimal(18,3)",
                nullable: false,
                oldClrType: typeof(decimal),
                oldType: "decimal(12,4)");

            migrationBuilder.AlterColumn<string>(
                name: "SegundoCodigoBarras",
                table: "MDFeCtes",
                type: "nvarchar(max)",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(3)",
                oldMaxLength: 3,
                oldNullable: true);

            migrationBuilder.AddColumn<string>(
                name: "CnpjColeta",
                table: "MDFeCtes",
                type: "nvarchar(14)",
                maxLength: 14,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "CnpjEntrega",
                table: "MDFeCtes",
                type: "nvarchar(14)",
                maxLength: 14,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "DescricaoMunicipioDescarga",
                table: "MDFeCtes",
                type: "nvarchar(100)",
                maxLength: 100,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "IndicadorPrestacaoParcial",
                table: "MDFeCtes",
                type: "nvarchar(3)",
                maxLength: 3,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "IndicadorReentrega",
                table: "MDFeCtes",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_MDFeNfesPrestacaoParcial_MDFeCteId",
                table: "MDFeNfesPrestacaoParcial",
                column: "MDFeCteId");

            migrationBuilder.CreateIndex(
                name: "IX_MDFeEntregasParciais_MDFeCteId",
                table: "MDFeEntregasParciais",
                column: "MDFeCteId",
                unique: true,
                filter: "[MDFeCteId] IS NOT NULL");

            migrationBuilder.CreateIndex(
                name: "IX_MDFeEntregasParciais_MDFeNfeId",
                table: "MDFeEntregasParciais",
                column: "MDFeNfeId",
                unique: true,
                filter: "[MDFeNfeId] IS NOT NULL");

            migrationBuilder.AddForeignKey(
                name: "FK_MDFeLacresUnidadeCarga_MDFeUnidadesCarga_MDFeUnidadeCargaId",
                table: "MDFeLacresUnidadeCarga",
                column: "MDFeUnidadeCargaId",
                principalTable: "MDFeUnidadesCarga",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_MDFeLacresUnidadeTransporte_MDFeUnidadesTransporte_MDFeUnidadeTransporteId",
                table: "MDFeLacresUnidadeTransporte",
                column: "MDFeUnidadeTransporteId",
                principalTable: "MDFeUnidadesTransporte",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_MDFeNfesPrestacaoParcial_MDFeCtes_MDFeCteId",
                table: "MDFeNfesPrestacaoParcial",
                column: "MDFeCteId",
                principalTable: "MDFeCtes",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_MDFeUnidadesCarga_MDFeUnidadesTransporte_MDFeUnidadeTransporteId",
                table: "MDFeUnidadesCarga",
                column: "MDFeUnidadeTransporteId",
                principalTable: "MDFeUnidadesTransporte",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
