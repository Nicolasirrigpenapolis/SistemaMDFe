import { MDFeData, RespostaACBr } from '../types/mdfe';
import { ErrorMessageHelper } from '../utils/errorMessages';

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
        const errorMessage = data.mensagem ||
                           ErrorMessageHelper.getApiErrorMessage({
                             ...data,
                             status: response.status
                           });

        return {
          sucesso: false,
          mensagem: errorMessage,
          codigoErro: data.codigoErro || response.status.toString(),
          detalhesValidacao: data.errors || undefined
        };
      }

      return {
        sucesso: true,
        mensagem: data.mensagem || 'Operação realizada com sucesso',
        dados: data.dados || data
      };
    } catch (error) {
      const errorMessage = error instanceof Error ?
        error.message :
        ErrorMessageHelper.getGenericErrorMessage('NETWORK_ERROR');

      return {
        sucesso: false,
        mensagem: errorMessage,
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

  // ===== NOVOS MÉTODOS PARA COMPATIBILIDADE COM O WIZARD =====

  /**
   * Criar MDFe usando o wizard inteligente
   * Suporte a auto-preenchimento e cálculos automáticos
   */
  async criarMDFeWizard(mdfeData: MDFeData): Promise<RespostaACBr> {
    return this.request('/mdfe/wizard', {
      method: 'POST',
      body: JSON.stringify(mdfeData)
    });
  }

  /**
   * Atualizar MDFe usando o wizard
   */
  async atualizarMDFeWizard(id: number, mdfeData: MDFeData): Promise<RespostaACBr> {
    return this.request(`/mdfe/wizard/${id}`, {
      method: 'PUT',
      body: JSON.stringify(mdfeData)
    });
  }

  /**
   * Obter MDFe no formato do wizard
   */
  async obterMDFeWizard(id: number): Promise<RespostaACBr> {
    return this.request(`/mdfe/wizard/${id}`, {
      method: 'GET'
    });
  }

  /**
   * Salvar rascunho do MDFe (compatível com wizard)
   */
  async salvarRascunhoWizard(mdfeData: Partial<MDFeData>): Promise<RespostaACBr> {
    return this.request('/mdfe/salvar-rascunho', {
      method: 'POST',
      body: JSON.stringify(mdfeData)
    });
  }

  /**
   * Listar MDFes com paginação
   */
  async listarMDFes(params?: {
    emitenteId?: number;
    pagina?: number;
    tamanhoPagina?: number;
  }): Promise<RespostaACBr> {
    const searchParams = new URLSearchParams();

    if (params?.emitenteId) {
      searchParams.append('emitenteId', params.emitenteId.toString());
    }
    if (params?.pagina) {
      searchParams.append('pagina', params.pagina.toString());
    }
    if (params?.tamanhoPagina) {
      searchParams.append('tamanhoPagina', params.tamanhoPagina.toString());
    }

    const queryString = searchParams.toString();
    const url = queryString ? `/mdfe?${queryString}` : '/mdfe';

    return this.request(url, {
      method: 'GET'
    });
  }

  /**
   * Obter próximo número do MDFe
   */
  async obterProximoNumero(emitenteCnpj?: string): Promise<RespostaACBr> {
    const searchParams = new URLSearchParams();

    if (emitenteCnpj) {
      searchParams.append('emitenteCnpj', emitenteCnpj);
    }

    const queryString = searchParams.toString();
    const url = queryString ? `/mdfe/proximo-numero?${queryString}` : '/mdfe/proximo-numero';

    return this.request(url, {
      method: 'GET'
    });
  }
}

export const mdfeService = new MDFeService();