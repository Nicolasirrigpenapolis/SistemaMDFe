using System.ComponentModel.DataAnnotations;

namespace MDFeApi.DTOs
{
    /// <summary>
    /// DTO compatível com o wizard inteligente do frontend
    /// Estrutura alinhada com o tipo MDFeData do TypeScript
    /// </summary>
    public class MDFeWizardCreateDto
    {
        // IDs das entidades para auto-preenchimento
        public int? EmitenteId { get; set; }
        public int? VeiculoId { get; set; }
        public int? MotoristaId { get; set; } // Mapear para CondutorId

        // Dados de identificação do MDFe
        public MDFeIdeDto? Ide { get; set; }

        // Dados do emitente (preenchidos automaticamente ou manualmente)
        public MDFeEmitDto? Emit { get; set; }

        // Dados modais (rodoviário)
        public MDFeInfModalDto? InfModal { get; set; }

        // Totalizadores da carga
        public MDFeTotDto? Tot { get; set; }

        // Informações de documentos fiscais
        public MDFeInfDocDto? InfDoc { get; set; }

        // Informações adicionais
        public List<int>? ReboquesIds { get; set; }
    }

    public class MDFeIdeDto
    {
        [MaxLength(2, ErrorMessage = "Código da UF deve ter no máximo 2 caracteres")]
        public string? CUF { get; set; }

        [Required(ErrorMessage = "Tipo de ambiente é obrigatório")]
        [RegularExpression("^[12]$", ErrorMessage = "Tipo de ambiente deve ser 1 (Produção) ou 2 (Homologação)")]
        public string TpAmb { get; set; } = "2"; // 1=Produção, 2=Homologação

        [Required(ErrorMessage = "Tipo de emitente é obrigatório")]
        [RegularExpression("^[12]$", ErrorMessage = "Tipo de emitente deve ser 1 (Normal) ou 2 (Contingência)")]
        public string TpEmit { get; set; } = "1"; // 1=Normal, 2=Contingência

        [Required(ErrorMessage = "Tipo de transportador é obrigatório")]
        [RegularExpression("^[123]$", ErrorMessage = "Tipo de transportador deve ser 1 (ETC), 2 (TAC) ou 3 (CTC)")]
        public string TpTransp { get; set; } = "1"; // 1=ETC, 2=TAC, 3=CTC

        [Required(ErrorMessage = "Modelo do documento é obrigatório")]
        public string Mod { get; set; } = "58"; // Modelo sempre 58

        [MaxLength(3, ErrorMessage = "Série deve ter no máximo 3 caracteres")]
        public string? Serie { get; set; }

        [MaxLength(9, ErrorMessage = "Número do MDFe deve ter no máximo 9 caracteres")]
        public string? NMDF { get; set; }

        [MaxLength(8, ErrorMessage = "Código numérico deve ter no máximo 8 caracteres")]
        public string? CMDF { get; set; } // Código numérico aleatório

        [MaxLength(1, ErrorMessage = "Dígito verificador deve ter 1 caractere")]
        public string? CDV { get; set; } // Dígito verificador

        [Required(ErrorMessage = "Modal é obrigatório")]
        [RegularExpression("^[1234]$", ErrorMessage = "Modal deve ser 1 (Rodoviário), 2 (Aéreo), 3 (Aquaviário) ou 4 (Ferroviário)")]
        public string Modal { get; set; } = "1"; // 1=Rodoviário

        public DateTime? DhEmi { get; set; } // Data e hora de emissão

        [Required(ErrorMessage = "Tipo de emissão é obrigatório")]
        [RegularExpression("^[123]$", ErrorMessage = "Tipo de emissão deve ser 1, 2 ou 3")]
        public string TpEmis { get; set; } = "1"; // Forma de emissão

        [Required(ErrorMessage = "Processo de emissão é obrigatório")]
        [RegularExpression("^[0123]$", ErrorMessage = "Processo de emissão deve ser 0, 1, 2 ou 3")]
        public string ProcEmi { get; set; } = "0"; // Processo de emissão

        [Required(ErrorMessage = "Versão do processo é obrigatório")]
        [MaxLength(20, ErrorMessage = "Versão do processo deve ter no máximo 20 caracteres")]
        public string VerProc { get; set; } = "1.0.0"; // Versão do processo

        [Required(ErrorMessage = "UF de início é obrigatória")]
        [StringLength(2, MinimumLength = 2, ErrorMessage = "UF de início deve ter exatamente 2 caracteres")]
        [RegularExpression(@"^[A-Z]{2}$", ErrorMessage = "UF de início deve conter apenas letras maiúsculas")]
        public string UFIni { get; set; } = string.Empty; // UF de início

        [Required(ErrorMessage = "UF de fim é obrigatória")]
        [StringLength(2, MinimumLength = 2, ErrorMessage = "UF de fim deve ter exatamente 2 caracteres")]
        [RegularExpression(@"^[A-Z]{2}$", ErrorMessage = "UF de fim deve conter apenas letras maiúsculas")]
        public string UFFim { get; set; } = string.Empty; // UF de fim

        public DateTime? DhIniViagem { get; set; } // Data/hora início da viagem

        public List<MDFeInfMunCarregaDto>? InfMunCarrega { get; set; }
        public List<MDFeInfPercursoDto>? InfPercurso { get; set; }
    }

    public class MDFeInfMunCarregaDto
    {
        public string? CMunCarrega { get; set; } // Código do município
        public string? XMunCarrega { get; set; } // Nome do município
    }

    public class MDFeInfPercursoDto
    {
        public string? UFPer { get; set; } // UF de percurso
    }

    public class MDFeEmitDto
    {
        [MaxLength(14, ErrorMessage = "CNPJ deve ter no máximo 14 caracteres")]
        [RegularExpression(@"^\d{14}$", ErrorMessage = "CNPJ deve conter exatamente 14 dígitos")]
        public string? CNPJ { get; set; }

        [MaxLength(11, ErrorMessage = "CPF deve ter no máximo 11 caracteres")]
        [RegularExpression(@"^\d{11}$", ErrorMessage = "CPF deve conter exatamente 11 dígitos")]
        public string? CPF { get; set; }

        [MaxLength(20, ErrorMessage = "IE deve ter no máximo 20 caracteres")]
        public string? IE { get; set; }

        [MaxLength(200, ErrorMessage = "Razão social deve ter no máximo 200 caracteres")]
        public string? XNome { get; set; } // Razão social

        [MaxLength(200, ErrorMessage = "Nome fantasia deve ter no máximo 200 caracteres")]
        public string? XFant { get; set; } // Nome fantasia

        public MDFeEnderEmitDto? EnderEmit { get; set; }
    }

    public class MDFeEnderEmitDto
    {
        [MaxLength(200, ErrorMessage = "Logradouro deve ter no máximo 200 caracteres")]
        public string? XLgr { get; set; } // Logradouro

        [MaxLength(20, ErrorMessage = "Número deve ter no máximo 20 caracteres")]
        public string? Nro { get; set; } // Número

        [MaxLength(200, ErrorMessage = "Complemento deve ter no máximo 200 caracteres")]
        public string? XCpl { get; set; } // Complemento

        [MaxLength(100, ErrorMessage = "Bairro deve ter no máximo 100 caracteres")]
        public string? XBairro { get; set; } // Bairro

        [MaxLength(7, ErrorMessage = "Código do município deve ter no máximo 7 caracteres")]
        [RegularExpression(@"^\d{7}$", ErrorMessage = "Código do município deve conter exatamente 7 dígitos")]
        public string? CMun { get; set; } // Código do município IBGE

        [MaxLength(100, ErrorMessage = "Nome do município deve ter no máximo 100 caracteres")]
        public string? XMun { get; set; } // Nome do município

        [MaxLength(8, ErrorMessage = "CEP deve ter no máximo 8 caracteres")]
        [RegularExpression(@"^\d{8}$", ErrorMessage = "CEP deve conter exatamente 8 dígitos")]
        public string? CEP { get; set; }

        [MaxLength(2, ErrorMessage = "UF deve ter no máximo 2 caracteres")]
        [RegularExpression(@"^[A-Z]{2}$", ErrorMessage = "UF deve conter apenas letras maiúsculas")]
        public string? UF { get; set; }

        [MaxLength(20, ErrorMessage = "Telefone deve ter no máximo 20 caracteres")]
        public string? Fone { get; set; } // Telefone

        [MaxLength(200, ErrorMessage = "Email deve ter no máximo 200 caracteres")]
        [EmailAddress(ErrorMessage = "Email deve ter formato válido")]
        public string? Email { get; set; } // Email
    }

    public class MDFeInfModalDto
    {
        public string VersaoModal { get; set; } = "3.00";
        public MDFeRodoDto? Rodo { get; set; }
    }

    public class MDFeRodoDto
    {
        public MDFeInfANTTDto? InfANTT { get; set; }
        public MDFeVeicTracaoDto? VeicTracao { get; set; }
        public List<MDFeVeicReboqueDto>? VeicReboque { get; set; }
        public List<MDFeLacRodoDto>? LacRodo { get; set; }
    }

    public class MDFeInfANTTDto
    {
        public string? RNTRC { get; set; } // Registro Nacional dos Transportadores
        public List<MDFeInfCIOTDto>? InfCIOT { get; set; }
        public MDFeValePedDto? ValePed { get; set; }
        public List<MDFeInfContratanteDto>? InfContratante { get; set; }
        public List<MDFeInfPagDto>? InfPag { get; set; }
    }

    public class MDFeInfCIOTDto
    {
        public string? CIOT { get; set; } // Código Identificador da Operação
        public string? CPF { get; set; }
        public string? CNPJ { get; set; }
    }

    public class MDFeVeicTracaoDto
    {
        public string? CInt { get; set; } // Código interno do veículo
        public string? Placa { get; set; } // Placa do veículo
        public string? RENAVAM { get; set; } // RENAVAM
        public int? Tara { get; set; } // Tara em KG
        public int? CapKG { get; set; } // Capacidade em KG
        public int? CapM3 { get; set; } // Capacidade em M3
        public string? TpProp { get; set; } // Tipo de proprietário
        public string? TpVeic { get; set; } // Tipo de veículo
        public string? TpRod { get; set; } // Tipo de rodado
        public string? TpCar { get; set; } // Tipo de carroceria
        public string? UF { get; set; } // UF de licenciamento
    }

    public class MDFeVeicReboqueDto
    {
        public string? CInt { get; set; }
        public string? Placa { get; set; }
        public string? RENAVAM { get; set; }
        public int? Tara { get; set; }
        public int? CapKG { get; set; }
        public int? CapM3 { get; set; }
        public string? TpProp { get; set; }
        public string? TpVeic { get; set; }
        public string? TpRod { get; set; }
        public string? TpCar { get; set; }
        public string? UF { get; set; }
    }

    public class MDFeLacRodoDto
    {
        public string? NLacre { get; set; }
    }

    public class MDFeValePedDto
    {
        public List<MDFeDispDto>? Disp { get; set; }
    }

    public class MDFeDispDto
    {
        public string? CNPJForn { get; set; } // CNPJ do fornecedor
        public string? CNPJPg { get; set; } // CNPJ responsável pelo pagamento
        public string? NCompra { get; set; } // Número do comprovante
        public decimal? VValePed { get; set; } // Valor do vale-pedágio
    }

    public class MDFeInfContratanteDto
    {
        public string? XNome { get; set; }
        public string? CPF { get; set; }
        public string? CNPJ { get; set; }
        public string? IdEstrangeiro { get; set; }
    }

    public class MDFeInfPagDto
    {
        public string? XNome { get; set; }
        public string? CPF { get; set; }
        public string? CNPJ { get; set; }
        public string? IdEstrangeiro { get; set; }
        public List<MDFeCompDto>? Comp { get; set; }
        public decimal? VContrato { get; set; }
        public string? IndAltoDesemp { get; set; }
        public string? IndPag { get; set; }
        public decimal? VAdiant { get; set; }
    }

    public class MDFeCompDto
    {
        public string? TpComp { get; set; } // 1=Frete, 2=Seguro, 3=Outros
        public decimal? VComp { get; set; } // Valor do componente
        public string? XComp { get; set; } // Descrição do componente
    }

    public class MDFeTotDto
    {
        [Range(0, int.MaxValue, ErrorMessage = "Quantidade de CTe deve ser maior ou igual a zero")]
        public int QCTe { get; set; } = 0; // Quantidade de CTe

        [Range(0, int.MaxValue, ErrorMessage = "Quantidade de NFe deve ser maior ou igual a zero")]
        public int QNFe { get; set; } = 0; // Quantidade de NFe

        [Range(1, int.MaxValue, ErrorMessage = "Quantidade de MDFe deve ser no mínimo 1")]
        public int QMDFe { get; set; } = 1; // Quantidade de MDFe

        [Range(0, double.MaxValue, ErrorMessage = "Valor da carga deve ser maior ou igual a zero")]
        public decimal? VCarga { get; set; } // Valor total da carga

        [Required(ErrorMessage = "Código da unidade de medida é obrigatório")]
        [MaxLength(2, ErrorMessage = "Código da unidade deve ter no máximo 2 caracteres")]
        [RegularExpression(@"^(01|02|03|04|05)$", ErrorMessage = "Código da unidade deve ser 01 (KG), 02 (TON), 03 (M³), 04 (Litros) ou 05 (MMBTU)")]
        public string CUnid { get; set; } = "01"; // Código da unidade de medida

        [Range(0, double.MaxValue, ErrorMessage = "Quantidade da carga deve ser maior ou igual a zero")]
        public decimal? QCarga { get; set; } // Quantidade total da carga
    }

    public class MDFeInfDocDto
    {
        public List<MDFeInfMunDescargaDto>? InfMunDescarga { get; set; }
    }

    public class MDFeInfMunDescargaDto
    {
        public string? CMunDescarga { get; set; }
        public string? XMunDescarga { get; set; }
        public List<MDFeInfCTeDto>? InfCTe { get; set; }
        public List<MDFeInfNFeDto>? InfNFe { get; set; }
        public List<MDFeInfMDFeTranspDto>? InfMDFeTransp { get; set; }
    }

    public class MDFeInfCTeDto
    {
        public string? ChCTe { get; set; } // Chave de acesso do CTe
        public string? SegCodBarra { get; set; } // Segundo código de barras
        public string? IndReentrega { get; set; } // Indicador de reentrega
        public List<MDFeInfUnidTranspDto>? InfUnidTransp { get; set; }
        public List<MDFePeriDto>? Peri { get; set; }
        public List<MDFeInfEntregaParcialDto>? InfEntregaParcial { get; set; }
    }

    public class MDFeInfNFeDto
    {
        public string? ChNFe { get; set; } // Chave de acesso da NFe
        public string? SegCodBarra { get; set; }
        public string? IndReentrega { get; set; }
        public List<MDFeInfUnidTranspDto>? InfUnidTransp { get; set; }
        public List<MDFePeriDto>? Peri { get; set; }
        public List<MDFeInfEntregaParcialDto>? InfEntregaParcial { get; set; }
    }

    public class MDFeInfMDFeTranspDto
    {
        public string? ChMDFe { get; set; }
        public string? IndReentrega { get; set; }
        public List<MDFeInfUnidTranspDto>? InfUnidTransp { get; set; }
        public List<MDFePeriDto>? Peri { get; set; }
        public List<MDFeInfEntregaParcialDto>? InfEntregaParcial { get; set; }
    }

    public class MDFeInfUnidTranspDto
    {
        public string? TpUnidTransp { get; set; } // Tipo da unidade de transporte
        public string? IdUnidTransp { get; set; } // Identificação da unidade
        public List<MDFeLacUnidTranspDto>? LacUnidTransp { get; set; }
        public List<MDFeInfUnidCargaDto>? InfUnidCarga { get; set; }
        public decimal? QtdRat { get; set; } // Quantidade rateada
    }

    public class MDFeLacUnidTranspDto
    {
        public string? NLacre { get; set; }
    }

    public class MDFeInfUnidCargaDto
    {
        public string? TpUnidCarga { get; set; }
        public string? IdUnidCarga { get; set; }
        public List<MDFeLacUnidCargaDto>? LacUnidCarga { get; set; }
        public decimal? QtdRat { get; set; }
    }

    public class MDFeLacUnidCargaDto
    {
        public string? NLacre { get; set; }
    }

    public class MDFePeriDto
    {
        public string? NNU { get; set; } // Número ONU
        public string? XNomeAE { get; set; } // Nome apropriado para embarque
        public string? XClaRisco { get; set; } // Classe ou subclasse de risco
        public string? GrEmb { get; set; } // Grupo de embalagem
        public string? QTotProd { get; set; } // Quantidade total do produto
        public string? QVolTipo { get; set; } // Quantidade e tipo de volume
    }

    public class MDFeInfEntregaParcialDto
    {
        public decimal? QtdParcial { get; set; }
    }

    // DTO de resposta do wizard
    public class MDFeWizardResponseDto
    {
        public int Id { get; set; }
        public string? ChaveAcesso { get; set; }
        public int Numero { get; set; }
        public int Serie { get; set; }
        public DateTime DataEmissao { get; set; }
        public DateTime? DataInicioViagem { get; set; }
        public string UFIni { get; set; } = string.Empty;
        public string UFFim { get; set; } = string.Empty;
        public string Status { get; set; } = string.Empty;
        public decimal? ValorTotal { get; set; }
        public decimal? PesoBrutoTotal { get; set; }
        public string EmitenteRazaoSocial { get; set; } = string.Empty;
        public string EmitenteFantasia { get; set; } = string.Empty;
        public string VeiculoPlaca { get; set; } = string.Empty;
        public string CondutorNome { get; set; } = string.Empty;
        public bool Transmitido { get; set; }
        public bool Autorizado { get; set; }
        public bool Cancelado { get; set; }
        public DateTime DataCriacao { get; set; }
        public DateTime? DataUltimaAlteracao { get; set; }
    }

    // DTO para atualização
    public class MDFeWizardUpdateDto : MDFeWizardCreateDto
    {
        // Herda todas as propriedades do CreateDto
    }
}