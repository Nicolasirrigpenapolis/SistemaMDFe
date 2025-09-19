import { MDFeData, RespostaACBr } from '../types/mdfe';

const API_BASE_URL = process.env.REACT_APP_API_URL || 'https://localhost:5001/api';

class MDFeService {
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

      const data = await response.json();

      if (!response.ok) {
        return {
          sucesso: false,
          mensagem: data.mensagem || 'Erro na requisição',
          codigoErro: data.codigoErro || response.status.toString()
        };
      }

      return {
        sucesso: true,
        mensagem: data.mensagem || 'Operação realizada com sucesso',
        dados: data.dados || data
      };
    } catch (error) {
      return {
        sucesso: false,
        mensagem: error instanceof Error ? error.message : 'Erro de comunicação com a API',
        codigoErro: 'NETWORK_ERROR'
      };
    }
  }

  async carregarINI(mdfeData: MDFeData): Promise<RespostaACBr> {
    return this.request('/mdfe/carregar-ini', {
      method: 'POST',
      body: JSON.stringify(mdfeData)
    });
  }

  async carregarINISimples(dados: {
    emitenteId: number;
    condutorId: number;
    veiculoId: number;
    ufInicio: string;
    ufFim: string;
    municipioCarregamento?: string;
    municipioDescarregamento?: string;
    serie?: number;
    numero?: number;
    reboquesIds?: number[];
  }): Promise<RespostaACBr> {
    return this.request('/mdfe/carregar-ini-simples', {
      method: 'POST',
      body: JSON.stringify(dados)
    });
  }

  async assinar(): Promise<RespostaACBr> {
    return this.request('/mdfe/assinar', {
      method: 'POST'
    });
  }

  async validar(): Promise<RespostaACBr> {
    return this.request('/mdfe/validar', {
      method: 'POST'
    });
  }

  async enviarSincrono(): Promise<RespostaACBr> {
    return this.request('/mdfe/enviar', {
      method: 'POST',
      body: JSON.stringify({ sincrono: true })
    });
  }

  async enviarAssincrono(): Promise<RespostaACBr> {
    return this.request('/mdfe/enviar', {
      method: 'POST',
      body: JSON.stringify({ sincrono: false })
    });
  }

  async consultarRecibo(numeroRecibo: string): Promise<RespostaACBr> {
    return this.request(`/mdfe/consultar-recibo/${encodeURIComponent(numeroRecibo)}`, {
      method: 'GET'
    });
  }

  async consultarMDFe(chaveAcesso: string): Promise<RespostaACBr> {
    return this.request(`/mdfe/consultar/${encodeURIComponent(chaveAcesso)}`, {
      method: 'GET'
    });
  }

  async imprimir(): Promise<RespostaACBr> {
    return this.request('/mdfe/imprimir', {
      method: 'POST'
    });
  }

  async cancelar(): Promise<RespostaACBr> {
    return this.request('/mdfe/cancelar', {
      method: 'POST'
    });
  }

  async encerrar(): Promise<RespostaACBr> {
    return this.request('/mdfe/encerrar', {
      method: 'POST'
    });
  }

  async salvarRascunho(mdfeData: MDFeData): Promise<RespostaACBr> {
    return this.request('/mdfe/salvar-rascunho', {
      method: 'POST',
      body: JSON.stringify(mdfeData)
    });
  }

  async carregarRascunho(id: string): Promise<RespostaACBr> {
    return this.request(`/mdfe/carregar-rascunho/${encodeURIComponent(id)}`, {
      method: 'GET'
    });
  }

  async obterStatus(): Promise<RespostaACBr> {
    return this.request('/mdfe/status', {
      method: 'GET'
    });
  }
}

export const mdfeService = new MDFeService();