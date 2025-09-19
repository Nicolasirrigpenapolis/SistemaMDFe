using MDFeApi.Models;
using System.Text.Json;

namespace MDFeApi.Services
{
    public static class MDFeDataCopyService
    {
        /// <summary>
        /// Copia todos os dados do emitente para o MDFe
        /// Garante que o MDFe tenha uma "foto" dos dados no momento da emissão
        /// </summary>
        public static void CopyEmitenteData(this MDFe mdfe, Emitente emitente)
        {
            mdfe.EmitenteCnpj = emitente.Cnpj ?? string.Empty;
            mdfe.EmitenteCpf = emitente.Cpf;
            mdfe.EmitenteIe = emitente.Ie;
            mdfe.EmitenteRazaoSocial = emitente.RazaoSocial;
            mdfe.EmitenteNomeFantasia = emitente.NomeFantasia;
            mdfe.EmitenteEndereco = emitente.Endereco;
            mdfe.EmitenteNumero = emitente.Numero;
            mdfe.EmitenteComplemento = emitente.Complemento;
            mdfe.EmitenteBairro = emitente.Bairro;
            mdfe.EmitenteCodMunicipio = emitente.CodMunicipio;
            mdfe.EmitenteMunicipio = emitente.Municipio;
            mdfe.EmitenteCep = emitente.Cep;
            mdfe.EmitenteUf = emitente.Uf;
            mdfe.EmitenteTelefone = emitente.Telefone;
            mdfe.EmitenteEmail = emitente.Email;
            mdfe.EmitenteTipoEmitente = emitente.TipoEmitente;
            mdfe.EmitenteRntrc = emitente.Rntrc;
        }

        /// <summary>
        /// Copia todos os dados do condutor para o MDFe
        /// </summary>
        public static void CopyCondutorData(this MDFe mdfe, Condutor condutor)
        {
            mdfe.CondutorNome = condutor.Nome;
            mdfe.CondutorCpf = condutor.Cpf;
            mdfe.CondutorTelefone = condutor.Telefone;
        }

        /// <summary>
        /// Copia todos os dados do veículo para o MDFe
        /// </summary>
        public static void CopyVeiculoData(this MDFe mdfe, Veiculo veiculo)
        {
            mdfe.VeiculoPlaca = veiculo.Placa;
            mdfe.VeiculoRenavam = veiculo.Renavam;
            mdfe.VeiculoTara = veiculo.Tara;
            mdfe.VeiculoCapacidadeKg = veiculo.CapacidadeKg;
            mdfe.VeiculoTipoRodado = veiculo.TipoRodado;
            mdfe.VeiculoTipoCarroceria = veiculo.TipoCarroceria;
            mdfe.VeiculoUf = veiculo.Uf;
            mdfe.VeiculoMarca = veiculo.Marca;
            mdfe.VeiculoModelo = veiculo.Modelo;
            mdfe.VeiculoAno = veiculo.Ano;
            mdfe.VeiculoCor = veiculo.Cor;
            mdfe.VeiculoCombustivel = veiculo.Combustivel;

            // Copiar RNTRC do veículo se disponível
            mdfe.Rntrc = veiculo.Rntrc ?? mdfe.EmitenteRntrc;
        }

        /// <summary>
        /// Copia todos os dados do contratante para o MDFe
        /// </summary>
        public static void CopyContratanteData(this MDFe mdfe, Contratante? contratante)
        {
            if (contratante == null) return;

            mdfe.ContratanteId = contratante.Id;
            mdfe.ContratanteCnpj = contratante.Cnpj;
            mdfe.ContratanteCpf = contratante.Cpf;
            mdfe.ContratanteRazaoSocial = contratante.RazaoSocial;
            mdfe.ContratanteNomeFantasia = contratante.NomeFantasia;
            mdfe.ContratanteEndereco = contratante.Endereco;
            mdfe.ContratanteNumero = contratante.Numero;
            mdfe.ContratanteComplemento = contratante.Complemento;
            mdfe.ContratanteBairro = contratante.Bairro;
            mdfe.ContratanteCodMunicipio = contratante.CodMunicipio;
            mdfe.ContratanteMunicipio = contratante.Municipio;
            mdfe.ContratanteCep = contratante.Cep;
            mdfe.ContratanteUf = contratante.Uf;
            mdfe.ContratanteTelefone = contratante.Telefone;
            mdfe.ContratanteEmail = contratante.Email;
        }

        /// <summary>
        /// Copia todos os dados da seguradora para o MDFe
        /// </summary>
        public static void CopySeguradoraData(this MDFe mdfe, Seguradora? seguradora)
        {
            if (seguradora == null) return;

            mdfe.SeguradoraId = seguradora.Id;
            mdfe.SeguradoraCnpj = seguradora.Cnpj;
            mdfe.SeguradoraRazaoSocial = seguradora.RazaoSocial;
            mdfe.SeguradoraEndereco = seguradora.Endereco;
            mdfe.SeguradoraNumero = seguradora.Numero;
            mdfe.SeguradoraComplemento = seguradora.Complemento;
            mdfe.SeguradoraBairro = seguradora.Bairro;
            mdfe.SeguradoraCodMunicipio = seguradora.CodMunicipio;
            mdfe.SeguradoraMunicipio = seguradora.Municipio;
            mdfe.SeguradoraCep = seguradora.Cep;
            mdfe.SeguradoraUf = seguradora.Uf;
            mdfe.SeguradoraTelefone = seguradora.Telefone;
        }

        /// <summary>
        /// Copia todos os dados dos cadastros relacionados para o MDFe em uma única operação
        /// </summary>
        public static void CopyAllRelatedData(this MDFe mdfe, Emitente emitente, Condutor condutor, Veiculo veiculo)
        {
            mdfe.CopyEmitenteData(emitente);
            mdfe.CopyCondutorData(condutor);
            mdfe.CopyVeiculoData(veiculo);
        }

        /// <summary>
        /// Copia dados de auditoria e controle
        /// </summary>
        public static void CopyAuditoriaData(this MDFe mdfe, string? usuario = null, string? versaoSistema = null)
        {
            mdfe.UsuarioUltimaAlteracao = usuario;
            mdfe.VersaoSistema = versaoSistema ?? "1.0.0";
            mdfe.DataUltimaAlteracao = DateTime.Now;

            // Se é um novo MDFe, definir usuário de criação
            if (mdfe.Id == 0)
            {
                mdfe.UsuarioCriacao = usuario;
                mdfe.DataCriacao = DateTime.Now;
            }
        }

        /// <summary>
        /// Cria backup dos dados originais em JSON para auditoria
        /// </summary>
        public static void CreateOriginalDataBackup(this MDFe mdfe, Emitente emitente, Condutor condutor, Veiculo veiculo, Contratante? contratante = null, Seguradora? seguradora = null)
        {
            var dadosOriginais = new
            {
                Emitente = new
                {
                    emitente.Id,
                    emitente.Cnpj,
                    emitente.Cpf,
                    emitente.RazaoSocial,
                    emitente.NomeFantasia,
                    emitente.Endereco,
                    emitente.Municipio,
                    emitente.Uf,
                    emitente.TipoEmitente,
                    emitente.Rntrc,
                    DataSnapshot = DateTime.Now
                },
                Veiculo = new
                {
                    veiculo.Id,
                    veiculo.Placa,
                    veiculo.Renavam,
                    veiculo.Marca,
                    veiculo.Modelo,
                    veiculo.Ano,
                    veiculo.Tara,
                    veiculo.CapacidadeKg,
                    veiculo.TipoRodado,
                    veiculo.TipoCarroceria,
                    veiculo.Uf,
                    DataSnapshot = DateTime.Now
                },
                Condutor = new
                {
                    condutor.Id,
                    condutor.Nome,
                    condutor.Cpf,
                    condutor.Telefone,
                    DataSnapshot = DateTime.Now
                },
                Contratante = contratante != null ? new
                {
                    contratante.Id,
                    contratante.Cnpj,
                    contratante.Cpf,
                    contratante.RazaoSocial,
                    contratante.Municipio,
                    contratante.Uf,
                    DataSnapshot = DateTime.Now
                } : null,
                Seguradora = seguradora != null ? new
                {
                    seguradora.Id,
                    seguradora.Cnpj,
                    seguradora.RazaoSocial,
                    seguradora.Apolice,
                    DataSnapshot = DateTime.Now
                } : null,
                SnapshotDateTime = DateTime.Now
            };

            mdfe.DadosOriginaisJson = JsonSerializer.Serialize(dadosOriginais, new JsonSerializerOptions
            {
                WriteIndented = true,
                PropertyNamingPolicy = JsonNamingPolicy.CamelCase
            });
        }

        /// <summary>
        /// Copia todos os dados dos cadastros relacionados incluindo contratante e seguradora
        /// </summary>
        public static void CopyAllRelatedDataComplete(this MDFe mdfe, Emitente emitente, Condutor condutor, Veiculo veiculo, Contratante? contratante = null, Seguradora? seguradora = null, string? usuario = null, string? versaoSistema = null)
        {
            // Copiar dados principais
            mdfe.CopyEmitenteData(emitente);
            mdfe.CopyCondutorData(condutor);
            mdfe.CopyVeiculoData(veiculo);
            mdfe.CopyContratanteData(contratante);
            mdfe.CopySeguradoraData(seguradora);

            // Criar backup dos dados originais
            mdfe.CreateOriginalDataBackup(emitente, condutor, veiculo, contratante, seguradora);

            // Copiar dados de auditoria
            mdfe.CopyAuditoriaData(usuario, versaoSistema);
        }
    }
}