// ✅ MENSAGENS DE ERRO SIMPLIFICADAS
// Versão estática sem chamadas API desnecessárias

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

// 🎯 Mapeamento de campos para nomes amigáveis (estático)
const FIELD_TRANSLATIONS: Record<string, string> = {
  // Campos comuns
  'cnpj': 'CNPJ',
  'cpf': 'CPF',
  'razaoSocial': 'Razão Social',
  'nomeFantasia': 'Nome Fantasia',
  'inscricaoEstadual': 'Inscrição Estadual',
  'telefone': 'Telefone',
  'email': 'E-mail',
  'cep': 'CEP',
  'logradouro': 'Logradouro',
  'numero': 'Número',
  'bairro': 'Bairro',
  'municipio': 'Município',
  'uf': 'UF',

  // MDFe específicos
  'emitenteId': 'Emitente',
  'condutorId': 'Condutor',
  'veiculoId': 'Veículo',
  'contratanteId': 'Contratante',
  'seguradoraId': 'Seguradora',
  'ufIni': 'UF de Origem',
  'ufFim': 'UF de Destino',
  'municipioCarregamento': 'Município de Carregamento',
  'municipioDescarregamento': 'Município de Descarregamento',
  'valorTotal': 'Valor Total',
  'pesoBrutoTotal': 'Peso Bruto Total',

  // Campos de veículo
  'placa': 'Placa',
  'renavam': 'RENAVAM',
  'tara': 'Tara',
  'tipoRodado': 'Tipo de Rodado',
  'tipoCarroceria': 'Tipo de Carroceria',

  // Campos de condutor
  'nome': 'Nome',
  'rg': 'RG',
  'cnh': 'CNH'
};

// 🎯 Mensagens de erro padrão (estáticas)
const ERROR_MESSAGES: Record<string, string> = {
  // Erros de rede
  'NETWORK_ERROR': 'Erro de conexão com o servidor. Verifique sua internet.',
  'TIMEOUT_ERROR': 'Tempo limite excedido. Tente novamente.',

  // Erros HTTP
  '400': 'Dados inválidos. Verifique as informações e tente novamente.',
  '401': 'Você precisa estar autenticado para realizar esta operação.',
  '403': 'Você não tem permissão para realizar esta operação.',
  '404': 'Recurso não encontrado.',
  '409': 'Conflito: o recurso já existe ou está sendo usado.',
  '422': 'Dados inválidos. Verifique as informações fornecidas.',
  '500': 'Erro interno do servidor. Tente novamente em alguns instantes.',
  '503': 'Serviço temporariamente indisponível. Tente novamente mais tarde.',

  // Erros de validação
  'REQUIRED': 'Este campo é obrigatório.',
  'INVALID_FORMAT': 'Formato inválido.',
  'ALREADY_EXISTS': 'Este registro já existe.',
  'NOT_FOUND': 'Registro não encontrado.',
  'INVALID_CNPJ': 'CNPJ inválido.',
  'INVALID_CPF': 'CPF inválido.',
  'INVALID_EMAIL': 'E-mail inválido.',
  'INVALID_PHONE': 'Telefone inválido.',

  // Erros específicos MDFe
  'INVALID_UF': 'UF inválida.',
  'INVALID_MUNICIPIO': 'Município inválido.',
  'INVALID_VALOR': 'Valor deve ser maior que zero.',
  'INVALID_PESO': 'Peso deve ser maior que zero.',
  'SAME_UF_ORIGIN_DESTINATION': 'UF de origem e destino não podem ser iguais.'
};

export class ErrorMessageHelper {
  /**
   * ✅ Traduz nome de campo (estático, sem API)
   */
  static translateFieldName(fieldName: string): string {
    return FIELD_TRANSLATIONS[fieldName] || fieldName;
  }

  /**
   * ✅ Formata erro de validação (estático)
   */
  static formatValidationError(field: string, message: string): string {
    const friendlyField = this.translateFieldName(field);
    return `${friendlyField}: ${message}`;
  }

  /**
   * ✅ Processa erros de validação (estático)
   */
  static processValidationErrors(errors: Record<string, string[]>): ValidationError[] {
    const validationErrors: ValidationError[] = [];

    for (const [field, messages] of Object.entries(errors)) {
      const friendlyField = this.translateFieldName(field);

      for (const message of messages) {
        validationErrors.push({
          field: friendlyField,
          message: `${friendlyField}: ${message}`
        });
      }
    }

    return validationErrors;
  }

  /**
   * ✅ Obtém mensagem de erro genérica (estático)
   */
  static getGenericErrorMessage(errorCode: string): string {
    return ERROR_MESSAGES[errorCode] || 'Ocorreu um erro inesperado.';
  }

  /**
   * ✅ Converte erro da API para mensagem amigável (simplificado)
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
    if (error.status) {
      return this.getGenericErrorMessage(error.status.toString());
    }

    return 'Ocorreu um erro inesperado.';
  }

  /**
   * ✅ Formata múltiplos erros de validação para exibição
   */
  static formatValidationErrors(errors: ValidationError[]): string {
    if (errors.length === 0) return '';

    if (errors.length === 1) {
      return errors[0].message;
    }

    return `Foram encontrados os seguintes erros:\n${errors.map(err => `• ${err.message}`).join('\n')}`;
  }

  /**
   * ✅ Processa resposta de erro da API (simplificado)
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
 * ✅ Hook simplificado para usar mensagens de erro em componentes React
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

// ✅ Exportar constantes para uso direto
export { FIELD_TRANSLATIONS, ERROR_MESSAGES };
export type { ValidationError, ApiError };