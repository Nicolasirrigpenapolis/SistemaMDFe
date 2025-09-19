namespace MDFeApi.DTOs
{
    public class MDFeCteDTO
    {
        public int Id { get; set; }
        public int MunicipioDescargaId { get; set; }
        public string ChaveCte { get; set; } = string.Empty;
        public string? SegundoCodigoBarras { get; set; }
        public string? IndicadorReentrega { get; set; }
        public string? IndicadorPrestacaoParcial { get; set; }
        public List<MDFeUnidadeTransporteDTO> UnidadesTransporte { get; set; } = new();
        public List<MDFeProdutoPerigososDTO> ProdutosPerigosos { get; set; } = new();
        public MDFeEntregaParcialDTO? EntregaParcial { get; set; }
        public List<string> NfesPrestacaoParcial { get; set; } = new(); // Lista de chaves NFe
    }

    public class MDFeNfeDTO
    {
        public int Id { get; set; }
        public int MunicipioDescargaId { get; set; }
        public string ChaveNfe { get; set; } = string.Empty;
        public string? SegundoCodigoBarras { get; set; }
        public string? IndicadorReentrega { get; set; }
        public string? PinSuframa { get; set; }
        public DateTime? DataPrevistaEntrega { get; set; }
        public List<MDFeUnidadeTransporteDTO> UnidadesTransporte { get; set; } = new();
        public List<MDFeProdutoPerigososDTO> ProdutosPerigosos { get; set; } = new();
        public MDFeEntregaParcialDTO? EntregaParcial { get; set; }
    }

    public class MDFeMdfeTranspDTO
    {
        public int Id { get; set; }
        public int MunicipioDescargaId { get; set; }
        public string ChaveMdfeTransp { get; set; } = string.Empty;
        public string? IndicadorReentrega { get; set; }
        public decimal? QuantidadeRateada { get; set; }
        public List<MDFeUnidadeTransporteDTO> UnidadesTransporte { get; set; } = new();
        public List<MDFeProdutoPerigososDTO> ProdutosPerigosos { get; set; } = new();
    }

    public class MDFeUnidadeTransporteDTO
    {
        public int Id { get; set; }
        public string TipoUnidadeTransporte { get; set; } = string.Empty;
        public string IdentificacaoUnidadeTransporte { get; set; } = string.Empty;
        public decimal? QuantidadeRateada { get; set; }
        public List<string> Lacres { get; set; } = new(); // Lista de números de lacre
        public List<MDFeUnidadeCargaDTO> UnidadesCarga { get; set; } = new();
    }

    public class MDFeUnidadeCargaDTO
    {
        public int Id { get; set; }
        public string TipoUnidadeCarga { get; set; } = string.Empty;
        public string IdentificacaoUnidadeCarga { get; set; } = string.Empty;
        public decimal? QuantidadeRateada { get; set; }
        public List<string> Lacres { get; set; } = new(); // Lista de números de lacre
    }

    public class MDFeProdutoPerigososDTO
    {
        public int Id { get; set; }
        public string NumeroONU { get; set; } = string.Empty;
        public string? NomeApropriado { get; set; }
        public string? ClasseRisco { get; set; }
        public string? GrupoEmbalagem { get; set; }
        public string QuantidadeTotalProduto { get; set; } = string.Empty;
        public string? QuantidadeVolumoTipo { get; set; }
    }

    public class MDFeEntregaParcialDTO
    {
        public int Id { get; set; }
        public decimal QuantidadeTotal { get; set; }
        public decimal QuantidadeParcial { get; set; }
    }

    public class MDFeLacreRodoviarioDTO
    {
        public int Id { get; set; }
        public string NumeroLacre { get; set; } = string.Empty;
    }

    // DTO para criação/atualização de municípios de descarga com documentos
    public class MDFeMunicipioDescargaDTO
    {
        public int MunicipioId { get; set; }
        public string NomeMunicipio { get; set; } = string.Empty;
        public List<MDFeCteDTO> DocumentosCte { get; set; } = new();
        public List<MDFeNfeDTO> DocumentosNfe { get; set; } = new();
        public List<MDFeMdfeTranspDTO> DocumentosMdfeTransp { get; set; } = new();
    }

    // DTO para envio de dados completos de documentos fiscais
    public class MDFeDocumentosFiscaisCreateDTO
    {
        public int MDFeId { get; set; }
        public List<MDFeMunicipioDescargaDTO> MunicipiosDescarga { get; set; } = new();
        public List<MDFeLacreRodoviarioDTO> LacresRodoviarios { get; set; } = new();
    }

    // DTO para resposta com dados completos
    public class MDFeDocumentosFiscaisResponseDTO
    {
        public int MDFeId { get; set; }
        public List<MDFeMunicipioDescargaDTO> MunicipiosDescarga { get; set; } = new();
        public List<MDFeLacreRodoviarioDTO> LacresRodoviarios { get; set; } = new();
        public int TotalDocumentosCte { get; set; }
        public int TotalDocumentosNfe { get; set; }
        public int TotalDocumentosMdfeTransp { get; set; }
        public int TotalLacres { get; set; }
    }
}