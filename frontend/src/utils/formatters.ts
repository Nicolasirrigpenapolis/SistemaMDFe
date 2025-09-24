export const formatCNPJ = (value: string): string => {
  const cleanValue = value.replace(/\D/g, '');
  
  if (cleanValue.length <= 11) {
    return cleanValue;
  }
  
  return cleanValue
    .replace(/(\d{2})(\d)/, '$1.$2')
    .replace(/(\d{3})(\d)/, '$1.$2')
    .replace(/(\d{3})(\d)/, '$1/$2')
    .replace(/(\d{4})(\d{1,2})$/, '$1-$2');
};

export const formatCPF = (value: string): string => {
  const cleanValue = value.replace(/\D/g, '');
  
  return cleanValue
    .replace(/(\d{3})(\d)/, '$1.$2')
    .replace(/(\d{3})(\d)/, '$1.$2')
    .replace(/(\d{3})(\d{1,2})$/, '$1-$2');
};

export const formatIE = (value: string): string => {
  const cleanValue = value.replace(/\D/g, '');
  
  // Formato genérico: XXX.XXX.XXX.XXX
  return cleanValue
    .replace(/(\d{3})(\d)/, '$1.$2')
    .replace(/(\d{3})(\d)/, '$1.$2')
    .replace(/(\d{3})(\d)/, '$1.$2');
};

export const formatCEP = (value: string): string => {
  const cleanValue = value.replace(/\D/g, '');
  
  return cleanValue.replace(/(\d{5})(\d{3})/, '$1-$2');
};

export const formatPlaca = (value: string): string => {
  const cleanValue = value.toUpperCase().replace(/[^A-Z0-9]/g, '');

  if (cleanValue.length <= 3) {
    return cleanValue;
  }

  return cleanValue.replace(/([A-Z]{3})(\d{4})/, '$1-$2');
};

export const formatChaveAcesso = (value: string): string => {
  const cleanValue = value.replace(/\D/g, '');
  
  // Formato: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
  return cleanValue.replace(/(\d{4})(?=\d)/g, '$1 ').trim();
};

export const formatCurrency = (value: string): string => {
  const cleanValue = value.replace(/\D/g, '');
  const numberValue = parseFloat(cleanValue) / 100;
  
  return numberValue.toLocaleString('pt-BR', {
    style: 'currency',
    currency: 'BRL'
  });
};

export const formatWeight = (value: string, decimals: number = 3): string => {
  const cleanValue = value.replace(/[^\d.,]/g, '').replace(',', '.');
  const numberValue = parseFloat(cleanValue);
  
  if (isNaN(numberValue)) return '';
  
  return numberValue.toLocaleString('pt-BR', {
    minimumFractionDigits: decimals,
    maximumFractionDigits: decimals
  });
};

export const cleanNumericString = (value: string): string => {
  return value.replace(/\D/g, '');
};

export const cleanDecimalString = (value: string): string => {
  return value.replace(/[^\d.,]/g, '').replace(',', '.');
};

export const cleanPlaca = (value: string): string => {
  return value.toUpperCase().replace(/[^A-Z0-9]/g, '');
};

export const validateCNPJ = (cnpj: string): boolean => {
  const cleanCNPJ = cnpj.replace(/\D/g, '');
  
  if (cleanCNPJ.length !== 14) return false;
  
  // Verificar se todos os dígitos são iguais
  if (/^(\d)\1+$/.test(cleanCNPJ)) return false;
  
  // Algoritmo de validação do CNPJ
  let tamanho = cleanCNPJ.length - 2;
  let numeros = cleanCNPJ.substring(0, tamanho);
  const digitos = cleanCNPJ.substring(tamanho);
  let soma = 0;
  let pos = tamanho - 7;
  
  for (let i = tamanho; i >= 1; i--) {
    soma += parseInt(numeros.charAt(tamanho - i)) * pos--;
    if (pos < 2) pos = 9;
  }
  
  let resultado = soma % 11 < 2 ? 0 : 11 - (soma % 11);
  if (resultado !== parseInt(digitos.charAt(0))) return false;
  
  tamanho = tamanho + 1;
  numeros = cleanCNPJ.substring(0, tamanho);
  soma = 0;
  pos = tamanho - 7;
  
  for (let i = tamanho; i >= 1; i--) {
    soma += parseInt(numeros.charAt(tamanho - i)) * pos--;
    if (pos < 2) pos = 9;
  }
  
  resultado = soma % 11 < 2 ? 0 : 11 - (soma % 11);
  return resultado === parseInt(digitos.charAt(1));
};

export const validateCPF = (cpf: string): boolean => {
  const cleanCPF = cpf.replace(/\D/g, '');
  
  if (cleanCPF.length !== 11) return false;
  
  // Verificar se todos os dígitos são iguais
  if (/^(\d)\1+$/.test(cleanCPF)) return false;
  
  // Algoritmo de validação do CPF
  let soma = 0;
  
  for (let i = 1; i <= 9; i++) {
    soma += parseInt(cleanCPF.substring(i - 1, i)) * (11 - i);
  }
  
  let resto = soma % 11;
  let dv1 = resto < 2 ? 0 : 11 - resto;
  
  if (dv1 !== parseInt(cleanCPF.substring(9, 10))) return false;
  
  soma = 0;
  for (let i = 1; i <= 10; i++) {
    soma += parseInt(cleanCPF.substring(i - 1, i)) * (12 - i);
  }
  
  resto = soma % 11;
  const dv2 = resto < 2 ? 0 : 11 - resto;
  
  return dv2 === parseInt(cleanCPF.substring(10, 11));
};

export const validateChaveAcesso = (chave: string): boolean => {
  const cleanChave = chave.replace(/\D/g, '');
  return cleanChave.length === 44;
};

// Função helper para aplicar máscara enquanto o usuário digita
export const applyMask = (value: string, type: 'cpf' | 'cnpj' | 'cep' | 'telefone' | 'ie'): string => {
  const cleanValue = cleanNumericString(value);

  switch (type) {
    case 'cpf':
      return formatCPF(cleanValue);
    case 'cnpj':
      return formatCNPJ(cleanValue);
    case 'cep':
      return formatCEP(cleanValue);
    case 'ie':
      return formatIE(cleanValue);
    case 'telefone':
      // Formato telefone: (XX) XXXXX-XXXX
      return cleanValue
        .replace(/(\d{2})(\d)/, '($1) $2')
        .replace(/(\d{5})(\d{4})$/, '$1-$2');
    default:
      return value;
  }
};

// Função para detectar automaticamente o tipo de campo e aplicar máscara
export const autoMask = (value: string, fieldName: string): string => {
  const lowerFieldName = fieldName.toLowerCase();

  if (lowerFieldName.includes('cpf')) {
    return applyMask(value, 'cpf');
  } else if (lowerFieldName.includes('cnpj')) {
    return applyMask(value, 'cnpj');
  } else if (lowerFieldName.includes('cep')) {
    return applyMask(value, 'cep');
  } else if (lowerFieldName.includes('telefone') || lowerFieldName.includes('phone')) {
    return applyMask(value, 'telefone');
  } else if (lowerFieldName.includes('ie') || lowerFieldName.includes('inscricao')) {
    return applyMask(value, 'ie');
  }

  return value;
};