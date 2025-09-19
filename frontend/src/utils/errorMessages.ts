interface ValidationError {
  field: string;
  message: string;
}

interface ApiError {
  title?: string;
  detail?: string;
  errors?: Record<string, string[]>;
  status?: number;
}

export class ErrorMessageHelper {
  private static fieldTranslations: Record<string, string> = {
    // Campos do Emitente
    'cnpj': 'CNPJ',
    'cpf': 'CPF',
    'ie': 'Inscrição Estadual',
    'razaoSocial': 'Razão Social',
    'nomeFantasia': 'Nome Fantasia',
    'endereco': 'Endereço',
    'numero': 'Número',
    'complemento': 'Complemento',
    'bairro': 'Bairro',
    'municipio': 'Município',
    'cep': 'CEP',
    'uf': 'UF',
    'telefone': 'Telefone',
    'email': 'Email',

    // Campos do Veículo
    'placa': 'Placa',
    'renavam': 'RENAVAM',
    'marca': 'Marca',
    'modelo': 'Modelo',
    'ano': 'Ano',
    'cor': 'Cor',
    'combustivel': 'Combustível',
    'tara': 'Tara',
    'capacidadeKg': 'Capacidade (Kg)',
    'capacidadeM3': 'Capacidade (M³)',
    'tipoRodado': 'Tipo de Rodado',
    'tipoCarroceria': 'Tipo de Carroceria',
    'rntrc': 'RNTRC',

    // Campos do Condutor
    'nome': 'Nome',

    // Campos do MDFe
    'ufIni': 'UF de Início',
    'ufFim': 'UF de Fim',
    'dataEmissao': 'Data de Emissão',
    'dataInicioViagem': 'Data de Início da Viagem',
    'valorCarga': 'Valor da Carga',
    'quantidadeCarga': 'Quantidade da Carga',
    'serie': 'Série',
    'modal': 'Modal',
    'tpTransp': 'Tipo de Transportador',

    // Campos específicos wizard
    'UFIni': 'UF de Início',
    'UFFim': 'UF de Fim',
    'VCarga': 'Valor da Carga',
    'QCarga': 'Quantidade da Carga',
    'CUnid': 'Unidade de Medida',
    'QCTe': 'Quantidade de CTe',
    'QNFe': 'Quantidade de NFe',
    'QMDFe': 'Quantidade de MDFe',

    // Campos de validação específicos
    'EmitenteId': 'Emitente',
    'VeiculoId': 'Veículo',
    'CondutorId': 'Condutor',
    'MunicipioIni': 'Município de Início',
    'MunicipioFim': 'Município de Fim',
    'PesoBrutoTotal': 'Peso Bruto Total',
    'ValorTotal': 'Valor Total',
    'Observacoes': 'Observações',
    'TipoEmitente': 'Tipo de Emitente',
    'DescricaoEmitente': 'Descrição do Emitente',
    'CaminhoArquivoCertificado': 'Caminho do Certificado',
    'SenhaCertificado': 'Senha do Certificado',
    'CodMunicipio': 'Código do Município',
  };

  private static errorMessages: Record<string, string> = {
    // Erros de rede
    'NETWORK_ERROR': 'Erro de conexão com o servidor. Verifique sua internet e tente novamente.',
    'TIMEOUT_ERROR': 'A operação demorou muito para responder. Tente novamente.',
    'SERVER_ERROR': 'Erro interno do servidor. Tente novamente em alguns instantes.',

    // Erros de validação comuns
    'REQUIRED_FIELD': 'Este campo é obrigatório.',
    'INVALID_FORMAT': 'Formato inválido.',
    'INVALID_EMAIL': 'Email deve ter um formato válido.',
    'INVALID_PHONE': 'Telefone deve ter um formato válido.',
    'INVALID_CPF': 'CPF deve ser válido (verifique os dígitos verificadores).',
    'INVALID_CNPJ': 'CNPJ deve ser válido (verifique os dígitos verificadores).',
    'INVALID_CEP': 'CEP deve conter exatamente 8 dígitos.',
    'INVALID_UF': 'UF deve conter exatamente 2 letras maiúsculas.',
    'INVALID_PLACA': 'Placa deve estar no formato ABC1234 ou ABC1A23 (Mercosul).',
    'INVALID_RENAVAM': 'RENAVAM deve conter apenas números (9 a 11 dígitos).',
    'INVALID_DOCUMENTO_FISCAL': 'Chave do documento fiscal deve conter exatamente 44 dígitos.',
    'INVALID_MUNICIPIO_CODE': 'Código do município deve ser válido (código IBGE).',
    'INVALID_YEAR': 'Ano deve estar entre 1900 e 2030.',
    'VALUE_TOO_SMALL': 'Valor deve ser maior que zero.',
    'VALUE_TOO_LARGE': 'Valor excede o limite máximo permitido.',
    'STRING_TOO_SHORT': 'Texto muito curto.',
    'STRING_TOO_LONG': 'Texto muito longo.',
    'DUPLICATE_ENTRY': 'Este registro já existe no sistema.',
    'DATA_TRUNCATED': 'Um ou mais campos excedem o tamanho máximo permitido.',

    // Erros específicos do MDFe
    'EMITENTE_NOT_FOUND': 'Emitente não encontrado ou inativo.',
    'VEICULO_NOT_FOUND': 'Veículo não encontrado ou inativo.',
    'CONDUTOR_NOT_FOUND': 'Condutor não encontrado ou inativo.',
    'INVALID_SEQUENCE': 'Sequência de numeração inválida.',
    'MDFE_ALREADY_EXISTS': 'Já existe um MDFe com essa numeração.',
    'CERTIFICATE_ERROR': 'Erro no certificado digital.',
    'SEFAZ_ERROR': 'Erro na comunicação com a SEFAZ.',

    // Erros de autorização
    'UNAUTHORIZED': 'Você não tem permissão para realizar esta operação.',
    'FORBIDDEN': 'Acesso negado.',
    'NOT_FOUND': 'Recurso não encontrado.',
  };

  /**
   * Converte um nome de campo técnico para um nome amigável
   */
  static translateFieldName(fieldName: string): string {
    const cleanField = fieldName.toLowerCase();
    return this.fieldTranslations[cleanField] || fieldName;
  }

  /**
   * Formata uma mensagem de erro de validação
   */
  static formatValidationError(field: string, message: string): string {
    const friendlyField = this.translateFieldName(field);
    return `${friendlyField}: ${message}`;
  }

  /**
   * Processa erros de validação do backend (.NET)
   */
  static processValidationErrors(errors: Record<string, string[]>): ValidationError[] {
    const validationErrors: ValidationError[] = [];

    Object.entries(errors).forEach(([field, messages]) => {
      const friendlyField = this.translateFieldName(field);
      messages.forEach(message => {
        validationErrors.push({
          field: friendlyField,
          message: message
        });
      });
    });

    return validationErrors;
  }

  /**
   * Converte erro da API para mensagem amigável
   */
  static getApiErrorMessage(error: ApiError): string {
    // Se tem erros de validação específicos
    if (error.errors && Object.keys(error.errors).length > 0) {
      const validationErrors = this.processValidationErrors(error.errors);
      if (validationErrors.length === 1) {
        return validationErrors[0].message;
      }
      return `Foram encontrados ${validationErrors.length} erro(s) de validação.`;
    }

    // Se tem uma mensagem de detalhe
    if (error.detail) {
      return error.detail;
    }

    // Se tem um título
    if (error.title) {
      return error.title;
    }

    // Mensagens baseadas no status HTTP
    switch (error.status) {
      case 400:
        return 'Dados inválidos. Verifique as informações e tente novamente.';
      case 401:
        return 'Você precisa estar autenticado para realizar esta operação.';
      case 403:
        return 'Você não tem permissão para realizar esta operação.';
      case 404:
        return 'Recurso não encontrado.';
      case 409:
        return 'Conflito: o recurso já existe ou está sendo usado.';
      case 422:
        return 'Dados inválidos. Verifique as informações fornecidas.';
      case 500:
        return 'Erro interno do servidor. Tente novamente em alguns instantes.';
      case 503:
        return 'Serviço temporariamente indisponível. Tente novamente mais tarde.';
      default:
        return 'Ocorreu um erro inesperado. Tente novamente.';
    }
  }

  /**
   * Formata múltiplos erros de validação para exibição
   */
  static formatValidationErrors(errors: ValidationError[]): string {
    if (errors.length === 0) return '';

    if (errors.length === 1) {
      return errors[0].message;
    }

    return `Foram encontrados os seguintes erros:\n${errors.map(err => `• ${err.message}`).join('\n')}`;
  }

  /**
   * Obtém uma mensagem de erro genérica baseada no código
   */
  static getGenericErrorMessage(errorCode: string): string {
    return this.errorMessages[errorCode] || 'Ocorreu um erro inesperado.';
  }

  /**
   * Processa resposta de erro da API e retorna mensagem amigável
   */
  static processApiResponse(response: any): string {
    // Se é uma resposta ACBr
    if (response.sucesso === false) {
      if (response.mensagem) {
        return response.mensagem;
      }
      if (response.codigoErro) {
        return this.getGenericErrorMessage(response.codigoErro);
      }
    }

    // Se é uma resposta de erro da API .NET
    if (response.errors) {
      return this.getApiErrorMessage(response);
    }

    // Se tem uma mensagem direta
    if (response.message) {
      return response.message;
    }

    return 'Ocorreu um erro inesperado.';
  }
}

/**
 * Hook para usar mensagens de erro amigáveis em componentes React
 */
export const useErrorMessages = () => {
  const formatError = (error: any): string => {
    return ErrorMessageHelper.processApiResponse(error);
  };

  const formatValidationErrors = (errors: Record<string, string[]>): ValidationError[] => {
    return ErrorMessageHelper.processValidationErrors(errors);
  };

  return {
    formatError,
    formatValidationErrors,
    translateField: ErrorMessageHelper.translateFieldName,
    getGenericMessage: ErrorMessageHelper.getGenericErrorMessage
  };
};