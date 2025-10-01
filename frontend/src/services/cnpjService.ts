/**
 * 🎯 SERVIÇO DE VALIDAÇÃO AUTOMÁTICA
 * Integração completa com ValidationController para validação e preenchimento automático
 */

// ✅ IMPORTANDO TIPOS CENTRALIZADOS
import { CNPJData, ValidacaoResponse } from '../types/apiResponse';

const API_BASE_URL = process.env.REACT_APP_API_URL || 'https://localhost:5001/api';

// Re-exportando para compatibilidade
export type { CNPJData, ValidacaoResponse };

class ValidationService {
  /**
   * 🔍 Consultar e validar CNPJ com preenchimento automático
   */
  async consultarCNPJ(cnpj: string): Promise<ValidacaoResponse<CNPJData>> {
    try {
      // Limpar CNPJ
      const cnpjLimpo = cnpj.replace(/\D/g, '');

      if (cnpjLimpo.length !== 14) {
        return {
          sucesso: false,
          mensagem: 'CNPJ deve conter 14 dígitos'
        };
      }

      const response = await fetch(`${API_BASE_URL}/validation/cnpj/${cnpjLimpo}`);
      const result = await response.json();

      if (!response.ok) {
        return {
          sucesso: false,
          mensagem: result.message || 'Erro ao consultar CNPJ'
        };
      }

      return {
        sucesso: result.success,
        data: result.data,
        mensagem: result.message
      };
    } catch (error) {
      console.error('Erro ao consultar CNPJ:', error);
      return {
        sucesso: false,
        mensagem: 'Erro de conexão com o servidor'
      };
    }
  }

  /**
   * ✅ Validar CNPJ simples (sem consulta)
   */
  async validarCNPJ(cnpj: string): Promise<ValidacaoResponse<boolean>> {
    try {
      const response = await fetch(`${API_BASE_URL}/validation/cnpj`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ documento: cnpj })
      });

      const result = await response.json();

      return {
        sucesso: result.success,
        data: result.data,
        mensagem: result.message
      };
    } catch (error) {
      console.error('Erro ao validar CNPJ:', error);
      return {
        sucesso: false,
        mensagem: 'Erro de conexão com o servidor'
      };
    }
  }

  /**
   * ✅ Validar CPF
   */
  async validarCPF(cpf: string): Promise<ValidacaoResponse<boolean>> {
    try {
      const response = await fetch(`${API_BASE_URL}/validation/cpf`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ documento: cpf })
      });

      const result = await response.json();

      return {
        sucesso: result.success,
        data: result.data,
        mensagem: result.message
      };
    } catch (error) {
      console.error('Erro ao validar CPF:', error);
      return {
        sucesso: false,
        mensagem: 'Erro de conexão com o servidor'
      };
    }
  }

  /**
   * 🎯 Formatação automática de documentos
   */
  formatarCNPJ(cnpj: string): string {
    const limpo = cnpj.replace(/\D/g, '');
    return limpo.replace(/(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})/, '$1.$2.$3/$4-$5');
  }

  formatarCPF(cpf: string): string {
    const limpo = cpf.replace(/\D/g, '');
    return limpo.replace(/(\d{3})(\d{3})(\d{3})(\d{2})/, '$1.$2.$3-$4');
  }

  formatarCEP(cep: string): string {
    const limpo = cep.replace(/\D/g, '');
    return limpo.replace(/(\d{5})(\d{3})/, '$1-$2');
  }

  formatarTelefone(telefone: string): string {
    const limpo = telefone.replace(/\D/g, '');
    if (limpo.length === 11) {
      return limpo.replace(/(\d{2})(\d{5})(\d{4})/, '($1) $2-$3');
    } else if (limpo.length === 10) {
      return limpo.replace(/(\d{2})(\d{4})(\d{4})/, '($1) $2-$3');
    }
    return telefone;
  }
}

export const validationService = new ValidationService();

// Manter compatibilidade
export const cnpjService = validationService;