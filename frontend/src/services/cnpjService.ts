export interface CNPJData {
  cnpj: string;
  razao_social: string;
  nome_fantasia?: string;
  logradouro: string;
  numero: string;
  complemento?: string;
  bairro: string;
  municipio: string;
  uf: string;
  cep: string;
  codigo_municipio?: number;
  telefone?: string;
  email?: string;
  situacao?: string;
  data_situacao?: string;
}

export interface CNPJResponse {
  success: boolean;
  data?: CNPJData;
  error?: string;
}

class CNPJService {
  private readonly baseUrl = 'https://brasilapi.com.br/api/cnpj/v1';

  async consultarCNPJ(cnpj: string): Promise<CNPJResponse> {
    try {
      // Remove formatação do CNPJ
      const cnpjLimpo = cnpj.replace(/\D/g, '');

      if (cnpjLimpo.length !== 14) {
        return {
          success: false,
          error: 'CNPJ deve conter 14 dígitos'
        };
      }

      const response = await fetch(`${this.baseUrl}/${cnpjLimpo}`);

      if (!response.ok) {
        if (response.status === 404) {
          return {
            success: false,
            error: 'CNPJ não encontrado'
          };
        }
        throw new Error(`Erro na consulta: ${response.status}`);
      }

      const data = await response.json();

      return {
        success: true,
        data: {
          cnpj: data.cnpj,
          razao_social: data.razao_social || '',
          nome_fantasia: data.nome_fantasia || '',
          logradouro: data.logradouro || '',
          numero: data.numero || '',
          complemento: data.complemento || '',
          bairro: data.bairro || '',
          municipio: data.municipio || '',
          uf: data.uf || '',
          cep: data.cep?.replace(/\D/g, '') || '',
          codigo_municipio: parseInt(data.codigo_municipio) || 0,
          telefone: data.ddd_telefone_1 ? `(${data.ddd_telefone_1.substring(0, 2)}) ${data.ddd_telefone_1.substring(2)}` : '',
          email: data.email || '',
          situacao: data.situacao || '',
          data_situacao: data.data_situacao || ''
        }
      };

    } catch (error) {
      console.error('Erro ao consultar CNPJ:', error);
      return {
        success: false,
        error: error instanceof Error ? error.message : 'Erro desconhecido ao consultar CNPJ'
      };
    }
  }

  formatarCNPJ(cnpj: string): string {
    const cnpjLimpo = cnpj.replace(/\D/g, '');
    return cnpjLimpo.replace(/^(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})$/, '$1.$2.$3/$4-$5');
  }

  validarCNPJ(cnpj: string): boolean {
    const cnpjLimpo = cnpj.replace(/\D/g, '');

    if (cnpjLimpo.length !== 14) return false;

    // Verifica se todos os dígitos são iguais
    if (/^(\d)\1+$/.test(cnpjLimpo)) return false;

    // Validação do primeiro dígito verificador
    let soma = 0;
    let peso = 5;

    for (let i = 0; i < 12; i++) {
      soma += parseInt(cnpjLimpo[i]) * peso;
      peso = peso === 2 ? 9 : peso - 1;
    }

    const resto1 = soma % 11;
    const dv1 = resto1 < 2 ? 0 : 11 - resto1;

    if (parseInt(cnpjLimpo[12]) !== dv1) return false;

    // Validação do segundo dígito verificador
    soma = 0;
    peso = 6;

    for (let i = 0; i < 13; i++) {
      soma += parseInt(cnpjLimpo[i]) * peso;
      peso = peso === 2 ? 9 : peso - 1;
    }

    const resto2 = soma % 11;
    const dv2 = resto2 < 2 ? 0 : 11 - resto2;

    return parseInt(cnpjLimpo[13]) === dv2;
  }
}

export const cnpjService = new CNPJService();