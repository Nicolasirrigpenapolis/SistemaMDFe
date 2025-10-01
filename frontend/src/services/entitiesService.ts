// ⚠️ FRONTEND: APENAS CHAMADAS SIMPLES PARA BACKEND
// Transformações e mapeamentos movidos para o backend

import { RespostaACBr } from '../types/mdfe';
import { EntityOption } from '../types/apiResponse';

const API_BASE_URL = process.env.REACT_APP_API_URL || 'https://localhost:5001/api';

class EntitiesService {
  // ✅ Request simples - sem transformações
  private async request(
    endpoint: string,
    options: RequestInit = {}
  ): Promise<RespostaACBr> {
    try {
      const response = await fetch(`${API_BASE_URL}${endpoint}`, {
        headers: {
          'Content-Type': 'application/json',
          ...options.headers,
        },
        ...options,
      });

      if (!response.ok) {
        let errorData = null;
        try {
          errorData = await response.json();
        } catch {
          // Resposta não tem JSON válido
        }

        return {
          sucesso: false,
          mensagem: errorData?.message || 'Erro na operação',
          codigoErro: response.status.toString()
        };
      }

      // Sucesso - verificar se tem conteúdo
      let data = null;
      if (response.status !== 204) { // 204 = No Content
        try {
          data = await response.json();
        } catch {
          // Resposta de sucesso sem JSON válido (normal para alguns endpoints)
        }
      }

      return {
        sucesso: true,
        mensagem: 'Operação realizada com sucesso',
        dados: data
      };
    } catch (error) {
      return {
        sucesso: false,
        mensagem: 'Erro de conexão com o servidor',
        codigoErro: 'NETWORK_ERROR'
      };
    }
  }

  // ✅ Obter todas as entidades de uma vez (otimizado)
  async obterTodasEntidades(): Promise<{
    emitentes: EntityOption[];
    condutores: EntityOption[];
    veiculos: EntityOption[];
    contratantes: EntityOption[];
    seguradoras: EntityOption[];
  }> {
    const response = await this.request('/entities/wizard');

    if (!response.sucesso || !response.dados) {
      return {
        emitentes: [],
        condutores: [],
        veiculos: [],
        contratantes: [],
        seguradoras: []
      };
    }

    return response.dados;
  }

  // ✅ Métodos individuais simplificados
  async obterEmitentes(): Promise<EntityOption[]> {
    const response = await this.request('/entities/emitentes');
    return response.sucesso ? response.dados : [];
  }

  async obterCondutores(): Promise<EntityOption[]> {
    const response = await this.request('/entities/condutores');
    return response.sucesso ? response.dados : [];
  }

  async obterVeiculos(): Promise<EntityOption[]> {
    const response = await this.request('/entities/veiculos');
    return response.sucesso ? response.dados : [];
  }

  async obterContratantes(): Promise<EntityOption[]> {
    const response = await this.request('/entities/contratantes');
    return response.sucesso ? response.dados : [];
  }

  async obterSeguradoras(): Promise<EntityOption[]> {
    const response = await this.request('/entities/seguradoras');
    return response.sucesso ? response.dados : [];
  }

  // ✅ CRUD SIMPLIFICADO - backend aceita dados diretos

  // Emitentes
  async criarEmitente(dados: any): Promise<RespostaACBr> {
    return await this.request('/emitentes', {
      method: 'POST',
      body: JSON.stringify(dados)
    });
  }

  async atualizarEmitente(id: number, dados: any): Promise<RespostaACBr> {
    return await this.request(`/emitentes/${id}`, {
      method: 'PUT',
      body: JSON.stringify(dados)
    });
  }

  async excluirEmitente(id: number): Promise<RespostaACBr> {
    return await this.request(`/emitentes/${id}`, { method: 'DELETE' });
  }

  // Condutores
  async criarCondutor(dados: any): Promise<RespostaACBr> {
    return await this.request('/condutores', {
      method: 'POST',
      body: JSON.stringify(dados)
    });
  }

  async atualizarCondutor(id: number, dados: any): Promise<RespostaACBr> {
    return await this.request(`/condutores/${id}`, {
      method: 'PUT',
      body: JSON.stringify(dados)
    });
  }

  async excluirCondutor(id: number): Promise<RespostaACBr> {
    return await this.request(`/condutores/${id}`, { method: 'DELETE' });
  }

  // Veículos
  async criarVeiculo(dados: any): Promise<RespostaACBr> {
    return await this.request('/veiculos', {
      method: 'POST',
      body: JSON.stringify(dados)
    });
  }

  async atualizarVeiculo(id: number, dados: any): Promise<RespostaACBr> {
    return await this.request(`/veiculos/${id}`, {
      method: 'PUT',
      body: JSON.stringify(dados)
    });
  }

  async excluirVeiculo(id: number): Promise<RespostaACBr> {
    return await this.request(`/veiculos/${id}`, { method: 'DELETE' });
  }

  // Contratantes
  async criarContratante(dados: any): Promise<RespostaACBr> {
    return await this.request('/contratantes', {
      method: 'POST',
      body: JSON.stringify(dados)
    });
  }

  async atualizarContratante(id: number, dados: any): Promise<RespostaACBr> {
    return await this.request(`/contratantes/${id}`, {
      method: 'PUT',
      body: JSON.stringify(dados)
    });
  }

  async excluirContratante(id: number): Promise<RespostaACBr> {
    return await this.request(`/contratantes/${id}`, { method: 'DELETE' });
  }

  // Seguradoras
  async criarSeguradora(dados: any): Promise<RespostaACBr> {
    return await this.request('/seguradoras', {
      method: 'POST',
      body: JSON.stringify(dados)
    });
  }

  async atualizarSeguradora(id: number, dados: any): Promise<RespostaACBr> {
    return await this.request(`/seguradoras/${id}`, {
      method: 'PUT',
      body: JSON.stringify(dados)
    });
  }

  async excluirSeguradora(id: number): Promise<RespostaACBr> {
    return await this.request(`/seguradoras/${id}`, { method: 'DELETE' });
  }
}

export const entitiesService = new EntitiesService();