namespace MDFeApi.DTOs
{
    // DTO para criação de MDFe
    public class MDFeCreateDto
    {
        public int EmitenteId { get; set; }
        public int VeiculoId { get; set; }
        public int CondutorId { get; set; }
        public DateTime DataEmissao { get; set; }
        public DateTime DataInicioViagem { get; set; }
        public string UfIni { get; set; } = string.Empty;
        public string UfFim { get; set; } = string.Empty;
        public string MunicipioIni { get; set; } = string.Empty;
        public string MunicipioFim { get; set; } = string.Empty;
        public decimal? PesoBrutoTotal { get; set; }
        public decimal? ValorTotal { get; set; }
        public string? Observacoes { get; set; }
        public List<int>? ReboquesIds { get; set; }
    }

    // DTO específico para informações de pagamento (vale-pedágio)
    public class MDFePagamentosDto
    {
        public List<ValePedagioDto>? ValesPedagio { get; set; }
        public List<ComponentePagamentoDto>? ComponentesPagamento { get; set; }
    }

    // DTO para vale-pedágio
    public class ValePedagioDto
    {
        public string CnpjFornecedor { get; set; } = string.Empty;
        public string NumeroCompra { get; set; } = string.Empty;
        public decimal Valor { get; set; }
        public string TipoVale { get; set; } = "01"; // 01-Fornecedor, 02-Posto, 03-Rede
        public string? NomeFornecedor { get; set; }
    }

    // DTO para componentes de pagamento
    public class ComponentePagamentoDto
    {
        public string TipoComponente { get; set; } = string.Empty; // 1-Frete, 2-Seguro, 3-Outros
        public decimal Valor { get; set; }
        public string? Descricao { get; set; }
    }

    // DTO específico para informações de seguro
    public class MDFeSeguroDto
    {
        public ResponsavelSeguroDto ResponsavelSeguro { get; set; } = new();
        public SeguradoraInfoDto? SeguradoraInfo { get; set; }
        public string? NumeroApolice { get; set; }
        public List<string>? NumerosAverbacao { get; set; }
    }

    // DTO para responsável pelo seguro
    public class ResponsavelSeguroDto
    {
        public string TipoResponsavel { get; set; } = "1"; // 1-Emitente, 2-Contratante, 3-Outros
        public string? Cnpj { get; set; }
        public string? Cpf { get; set; }
        public string? Nome { get; set; }
    }

    // DTO para informações da seguradora
    public class SeguradoraInfoDto
    {
        public int? SeguradoraId { get; set; }
        public string Cnpj { get; set; } = string.Empty;
        public string RazaoSocial { get; set; } = string.Empty;
        public string? CodigoSusep { get; set; }
    }

    public class MDFeUpdateDto : MDFeCreateDto
    {
        // Mesmas propriedades que MDFeCreateDto
    }

    public class MDFeResponseDto
    {
        public int Id { get; set; }
        public int Numero { get; set; }
        public string Chave { get; set; } = string.Empty;
        public string Serie { get; set; } = string.Empty;
        public DateTime DataEmissao { get; set; }
        public DateTime DataInicioViagem { get; set; }
        public string UfIni { get; set; } = string.Empty;
        public string UfFim { get; set; } = string.Empty;
        public string MunicipioIni { get; set; } = string.Empty;
        public string MunicipioFim { get; set; } = string.Empty;
        public decimal? PesoBrutoTotal { get; set; }
        public decimal? ValorTotal { get; set; }
        public string Status { get; set; } = string.Empty;
        public string? Observacoes { get; set; }
        public string EmitenteRazaoSocial { get; set; } = string.Empty;
        public string VeiculoPlaca { get; set; } = string.Empty;
        public string CondutorNome { get; set; } = string.Empty;
    }

    public class MDFeGerarINIDto
    {
        public int EmitenteId { get; set; }
        public int CondutorId { get; set; }
        public int VeiculoId { get; set; }
        public string UfInicio { get; set; } = string.Empty;
        public string UfFim { get; set; } = string.Empty;
        public string MunicipioCarregamento { get; set; } = string.Empty;
        public string MunicipioDescarregamento { get; set; } = string.Empty;
        public int Serie { get; set; } = 1;
        public int NumeroMdfe { get; set; } = 1;
        public int Modal { get; set; } = 1;
        public int TipoTransportador { get; set; } = 1;
        public decimal ValorCarga { get; set; } = 0;
        public decimal QuantidadeCarga { get; set; } = 0;
        public string UnidadeMedida { get; set; } = "01";
        public string InfoAdicional { get; set; } = string.Empty;
        public List<int>? ReboquesIds { get; set; }
    }
}