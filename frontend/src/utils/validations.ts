// Constantes de validação baseadas na estrutura do banco de dados
export const MAX_LENGTHS = {
  // Emitentes
  emitente: {
    cnpj: 18,
    cpf: 11,
    ie: 20,
    razaoSocial: 200,
    nomeFantasia: 200,
    endereco: 200,
    numero: 20,
    complemento: 200,
    bairro: 100,
    municipio: 100,
    cep: 8,
    uf: 2,
    telefone: 20,
    email: 200,
    tipoEmitente: 50,
    descricaoEmitente: 100,
    caminhoArquivoCertificado: 500,
    senhaCertificado: 500,
    rntrc: 20
  },

  // Condutores
  condutor: {
    nome: 200,
    cpf: 11,
    telefone: 20
  },

  // Veículos
  veiculo: {
    placa: 8,
    marca: 100,
    modelo: 100,
    cor: 50,
    combustivel: 50,
    tipoRodado: 50,
    tipoCarroceria: 50,
    uf: 2,
    rntrc: 20
  },

  // Contratantes
  contratante: {
    cnpj: 18,
    cpf: 11,
    razaoSocial: 200,
    nomeFantasia: 200,
    endereco: 200,
    numero: 20,
    complemento: 100,
    bairro: 100,
    municipio: 100,
    cep: 8,
    uf: 2,
    telefone: 15,
    email: 200
  },

  // Reboques
  reboque: {
    placa: 8,
    tipoRodado: 50,
    tipoCarroceria: 50,
    uf: 2,
    rntrc: 20
  },

  // Seguradoras
  seguradora: {
    cnpj: 18,
    razaoSocial: 200,
    endereco: 200,
    numero: 20,
    complemento: 100,
    bairro: 100,
    municipio: 100,
    cep: 8,
    uf: 2,
    telefone: 15,
    apolice: 50
  },

  // MDFe
  mdfe: {
    chaveAcesso: 44,
    ufInicio: 2,
    ufFim: 2,
    unidadeMedida: 2,
    infoAdicional: 500,
    statusSefaz: 20,
    protocolo: 20,
    tipoCarga: 2,
    descricaoProduto: 100,
    cepCarregamento: 8,
    cepDescarregamento: 8,
    produtoPredominante: 200,
    numeroRecibo: 20
  }
};

// Função para validar comprimento de campo
export const validateFieldLength = (value: string, maxLength: number): boolean => {
  return value.length <= maxLength;
};

// Função para truncar valor se exceder o limite
export const truncateValue = (value: string, maxLength: number): string => {
  if (value.length > maxLength) {
    return value.substring(0, maxLength);
  }
  return value;
};

// Função para aplicar validações a um objeto de dados
export const applyValidations = (data: any, entityType: keyof typeof MAX_LENGTHS): any => {
  const validatedData = { ...data };
  const limits = MAX_LENGTHS[entityType];

  Object.keys(validatedData).forEach(key => {
    if (limits[key as keyof typeof limits] && typeof validatedData[key] === 'string') {
      validatedData[key] = truncateValue(validatedData[key], limits[key as keyof typeof limits]);
    }
  });

  return validatedData;
};

// Hook para validação em tempo real
export const useFieldValidation = (entityType: keyof typeof MAX_LENGTHS) => {
  const validateField = (fieldName: string, value: string): string => {
    const limits = MAX_LENGTHS[entityType];
    const maxLength = limits[fieldName as keyof typeof limits];

    if (maxLength && typeof value === 'string') {
      return truncateValue(value, maxLength);
    }

    return value;
  };

  return { validateField };
};

// Mensagens de erro padronizadas
export const VALIDATION_MESSAGES = {
  required: (field: string) => `${field} é obrigatório`,
  maxLength: (field: string, max: number) => `${field} deve ter no máximo ${max} caracteres`,
  email: 'Email deve ter formato válido',
  cnpj: 'CNPJ deve ter formato válido',
  cpf: 'CPF deve ter formato válido',
  cep: 'CEP deve ter formato válido',
  telefone: 'Telefone deve ter formato válido'
};

// Validações específicas de formato
export const FORMAT_VALIDATORS = {
  email: (value: string): boolean => {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(value);
  },

  cnpj: (value: string): boolean => {
    const cnpjNumbers = value.replace(/\D/g, '');
    return cnpjNumbers.length === 14;
  },

  cpf: (value: string): boolean => {
    const cpfNumbers = value.replace(/\D/g, '');
    return cpfNumbers.length === 11;
  },

  cep: (value: string): boolean => {
    const cepNumbers = value.replace(/\D/g, '');
    return cepNumbers.length === 8;
  },

  telefone: (value: string): boolean => {
    const phoneNumbers = value.replace(/\D/g, '');
    return phoneNumbers.length >= 10 && phoneNumbers.length <= 11;
  }
};