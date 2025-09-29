// ⚠️ FRONTEND: APENAS MÁSCARAS VISUAIS PARA UI
// Validações de negócio foram movidas para o backend

// Limpar strings para enviar ao backend
export const cleanNumericString = (value: string): string => {
  return value.replace(/\D/g, '');
};

export const cleanDecimalString = (value: string): string => {
  return value.replace(/[^\d.,]/g, '').replace(',', '.');
};

export const cleanPlaca = (value: string): string => {
  return value.toUpperCase().replace(/[^A-Z0-9]/g, '');
};

// ✅ MÁSCARAS VISUAIS APENAS (para UX)
export const formatCNPJ = (value: string): string => {
  const cleanValue = cleanNumericString(value);

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
  const cleanValue = cleanNumericString(value);

  return cleanValue
    .replace(/(\d{3})(\d)/, '$1.$2')
    .replace(/(\d{3})(\d)/, '$1.$2')
    .replace(/(\d{3})(\d{1,2})$/, '$1-$2');
};

export const formatCEP = (value: string): string => {
  const cleanValue = cleanNumericString(value);

  return cleanValue.replace(/(\d{5})(\d{3})/, '$1-$2');
};

export const formatPlaca = (value: string): string => {
  const cleanValue = cleanPlaca(value);

  if (cleanValue.length <= 3) {
    return cleanValue;
  }

  return cleanValue.replace(/([A-Z]{3})(\d{4})/, '$1-$2');
};

export const formatTelefone = (value: string): string => {
  const cleanValue = cleanNumericString(value);

  // Formato telefone: (XX) XXXXX-XXXX
  return cleanValue
    .replace(/(\d{2})(\d)/, '($1) $2')
    .replace(/(\d{5})(\d{4})$/, '$1-$2');
};

export const formatChaveAcesso = (value: string): string => {
  const cleanValue = cleanNumericString(value);

  // Formato: XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX XXXX
  return cleanValue.replace(/(\d{4})(?=\d)/g, '$1 ').trim();
};

export const formatCurrency = (value: number): string => {
  return value.toLocaleString('pt-BR', {
    style: 'currency',
    currency: 'BRL'
  });
};

export const formatWeight = (value: number, decimals: number = 3): string => {
  return value.toLocaleString('pt-BR', {
    minimumFractionDigits: decimals,
    maximumFractionDigits: decimals
  });
};

// Função para aplicar máscara enquanto o usuário digita
export const applyMask = (value: string, type: 'cpf' | 'cnpj' | 'cep' | 'telefone' | 'placa'): string => {
  switch (type) {
    case 'cpf':
      return formatCPF(value);
    case 'cnpj':
      return formatCNPJ(value);
    case 'cep':
      return formatCEP(value);
    case 'telefone':
      return formatTelefone(value);
    case 'placa':
      return formatPlaca(value);
    default:
      return value;
  }
};