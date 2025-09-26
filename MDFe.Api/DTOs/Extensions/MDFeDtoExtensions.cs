using MDFeApi.Utils;

namespace MDFeApi.DTOs.Extensions
{
    public static class MDFeDtoExtensions
    {
        /// <summary>
        /// Limpa e valida os dados do DTO antes do processamento
        /// </summary>
        public static void LimparDados(this MDFeCreateDto dto)
        {
            // Limpar e padronizar strings
            dto.UfIni = dto.UfIni?.Trim().ToUpper() ?? string.Empty;
            dto.UfFim = dto.UfFim?.Trim().ToUpper() ?? string.Empty;
            dto.MunicipioIni = dto.MunicipioIni?.Trim() ?? string.Empty;
            dto.MunicipioFim = dto.MunicipioFim?.Trim() ?? string.Empty;
            dto.Observacoes = string.IsNullOrWhiteSpace(dto.Observacoes) ? null : dto.Observacoes.Trim();
        }

        /// <summary>
        /// Limpa e valida os dados do DTO de atualização
        /// </summary>
        public static void LimparDados(this MDFeUpdateDto dto)
        {
            // MDFeUpdateDto herda de MDFeCreateDto, então podemos usar o mesmo método
            ((MDFeCreateDto)dto).LimparDados();
        }

        /// <summary>
        /// Limpa dados do DTO de geração de INI
        /// </summary>
        public static void LimparDados(this MDFeGerarINIDto dto)
        {
            dto.UfInicio = dto.UfInicio?.Trim().ToUpper() ?? string.Empty;
            dto.UfFim = dto.UfFim?.Trim().ToUpper() ?? string.Empty;
            dto.MunicipioCarregamento = dto.MunicipioCarregamento?.Trim() ?? string.Empty;
            dto.MunicipioDescarregamento = dto.MunicipioDescarregamento?.Trim() ?? string.Empty;
            dto.InfoAdicional = string.IsNullOrWhiteSpace(dto.InfoAdicional) ? string.Empty : dto.InfoAdicional.Trim();
            dto.UnidadeMedida = dto.UnidadeMedida?.Trim() ?? "01";
        }

        /// <summary>
        /// Validações específicas que complementam as validações de atributos
        /// </summary>
        public static List<string> ValidarConsistencia(this MDFeCreateDto dto)
        {
            var erros = new List<string>();

            // Validar se UF início é diferente de UF fim (se necessário)
            if (!string.IsNullOrEmpty(dto.UfIni) && !string.IsNullOrEmpty(dto.UfFim))
            {
                if (dto.UfIni == dto.UfFim && dto.MunicipioIni == dto.MunicipioFim)
                {
                    erros.Add("Origem e destino não podem ser iguais");
                }
            }

            // Validar datas
            if (dto.DataInicioViagem < dto.DataEmissao)
            {
                erros.Add("Data de início da viagem não pode ser anterior à data de emissão");
            }

            if (dto.DataEmissao > DateTime.Now.AddDays(1))
            {
                erros.Add("Data de emissão não pode ser superior a um dia no futuro");
            }

            return erros;
        }
    }
}