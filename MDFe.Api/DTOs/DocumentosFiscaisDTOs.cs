namespace MDFeApi.DTOs
{
    public class MDFeCteDto
    {
        public int Id { get; set; }
        public int MunicipioDescargaId { get; set; }
        public string ChaveCte { get; set; } = string.Empty;
        public string? SegundoCodigoBarras { get; set; }
        public string? IndicadorReentrega { get; set; }
        public string? IndicadorPrestacaoParcial { get; set; }
        public List<MDFeUnidadeTransporteDto> UnidadesTransporte { get; set; } = new();
        public List<MDFeProdutoPerigososDto> ProdutosPerigosos { get; set; } = new();
        public MDFeEntregaParcialDto? EntregaParcial { get; set; }
        public List<string> NfesPrestacaoParcial { get; set; } = new(); // Lista de chaves NFe
    }

    public class MDFeNfeDto
    {
        public int Id { get; set; }
        public int MunicipioDescargaId { get; set; }
        public string ChaveNfe { get; set; } = string.Empty;
        public string? SegundoCodigoBarras { get; set; }
        public string? IndicadorReentrega { get; set; }
        public string? PinSuframa { get; set; }
        public DateTime? DataPrevistaEntrega { get; set; }
        public List<MDFeUnidadeTransporteDto> UnidadesTransporte { get; set; } = new();
        public List<MDFeProdutoPerigososDto> ProdutosPerigosos { get; set; } = new();
        public MDFeEntregaParcialDto? EntregaParcial { get; set; }
    }

    public class MDFeMdfeTranspDto
    {
        public int Id { get; set; }
        public int MunicipioDescargaId { get; set; }
        public string ChaveMdfeTransp { get; set; } = string.Empty;
        public string? IndicadorReentrega { get; set; }
        public decimal? QuantidadeRateada { get; set; }
        public List<MDFeUnidadeTransporteDto> UnidadesTransporte { get; set; } = new();
        public List<MDFeProdutoPerigososDto> ProdutosPerigosos { get; set; } = new();
    }

    public class MDFeUnidadeTransporteDto
    {
        public int Id { get; set; }
        public string TipoUnidadeTransporte { get; set; } = string.Empty;
        public string IdentificacaoUnidadeTransporte { get; set; } = string.Empty;
        public decimal? QuantidadeRateada { get; set; }
        public List<string> Lacres { get; set; } = new(); // Lista de números de lacre
        public List<MDFeUnidadeCargaDto> UnidadesCarga { get; set; } = new();
    }

    public class MDFeUnidadeCargaDto
    {
        public int Id { get; set; }
        public string TipoUnidadeCarga { get; set; } = string.Empty;
        public string IdentificacaoUnidadeCarga { get; set; } = string.Empty;
        public decimal? QuantidadeRateada { get; set; }
        public List<string> Lacres { get; set; } = new(); // Lista de números de lacre
    }

    public class MDFeProdutoPerigososDto
    {
        public int Id { get; set; }
        public string NumeroONU { get; set; } = string.Empty;
        public string? NomeApropriado { get; set; }
        public string? ClasseRisco { get; set; }
        public string? GrupoEmbalagem { get; set; }
        public string QuantidadeTotalProduto { get; set; } = string.Empty;
        public string? QuantidadeVolumoTipo { get; set; }
    }

    public class MDFeEntregaParcialDto
    {
        public int Id { get; set; }
        public decimal QuantidadeTotal { get; set; }
        public decimal QuantidadeParcial { get; set; }
    }

    public class MDFeLacreRodoviarioDto
    {
        public int Id { get; set; }
        public string NumeroLacre { get; set; } = string.Empty;
    }

    // DTO para criação/atualização de municípios de descarga com documentos
    public class MDFeMunicipioDescargaDto
    {
        public int MunicipioId { get; set; }
        public string NomeMunicipio { get; set; } = string.Empty;
        public List<MDFeCteDto> DocumentosCte { get; set; } = new();
        public List<MDFeNfeDto> DocumentosNfe { get; set; } = new();
        public List<MDFeMdfeTranspDto> DocumentosMdfeTransp { get; set; } = new();
    }

    // DTO para envio de dados completos de documentos fiscais
    public class MDFeDocumentosFiscaisCreateDto
    {
        public int MDFeId { get; set; }
        public List<MDFeMunicipioDescargaDto> MunicipiosDescarga { get; set; } = new();
        public List<MDFeLacreRodoviarioDto> LacresRodoviarios { get; set; } = new();
    }

    // DTO para resposta com dados completos
    public class MDFeDocumentosFiscaisResponseDto
    {
        public int MDFeId { get; set; }
        public List<MDFeMunicipioDescargaDto> MunicipiosDescarga { get; set; } = new();
        public List<MDFeLacreRodoviarioDto> LacresRodoviarios { get; set; } = new();
        public int TotalDocumentosCte { get; set; }
        public int TotalDocumentosNfe { get; set; }
        public int TotalDocumentosMdfeTransp { get; set; }
        public int TotalLacres { get; set; }
    }
}