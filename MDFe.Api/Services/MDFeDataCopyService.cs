using MDFeApi.Models;

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
    }
}