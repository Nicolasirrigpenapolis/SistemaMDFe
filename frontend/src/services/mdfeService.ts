import { MDFeData, RespostaACBr } from '../types/mdfe';
import { ErrorMessageHelper } from '../utils/errorMessages';

const API_BASE_URL = process.env.REACT_APP_API_URL || 'https://localhost:5001/api';

class MDFeService {
  // ⚠️ MAPEAMENTO REMOVIDO: Backend agora aceita dados diretos do frontend

  private async request(
    endpoint: string,
    options: RequestInit = {}
  ): Promise<RespostaACBr> {
    const fullUrl = `${API_BASE_URL}${endpoint}`;

    try {
      const response = await fetch(fullUrl, {
        headers: {
          'Content-Type': 'application/json',
          ...options.headers,
        },
        ...options,
      });

      let data;
      try {
        data = await response.json();
      } catch (jsonError) {
        console.error('❌ JSON Parse Error:', jsonError);
        // Se não conseguir fazer parse do JSON, é um erro de servidor
        return {
          sucesso: false,
          mensagem: `Erro no servidor (${response.status}): ${response.statusText}`,
          codigoErro: response.status.toString()
        };
      }

      if (!response.ok) {
        const errorMessage = ErrorMessageHelper.getApiErrorMessage({
          detail: data?.message || data?.error || `${response.status} ${response.statusText}`,
          status: response.status
        });

        return {
          sucesso: false,
          mensagem: errorMessage,
          codigoErro: response.status.toString(),
          detalhesValidacao: data?.errors || data?.details || {}
        };
      }

      return {
        sucesso: true,
        mensagem: data?.message || 'Operação realizada com sucesso',
        dados: data
      };
    } catch (error: any) {
      console.error('❌ Network Error:', error);
      return {
        sucesso: false,
        mensagem: 'Erro de conexão com o servidor. Verifique sua internet.',
        codigoErro: 'NETWORK_ERROR'
      };
    }
  }

  // ===== MÉTODOS PRINCIPAIS =====

  /**
   * ✅ Criar MDFe - dados diretos
   */
  async criarMDFe(mdfeData: MDFeData): Promise<RespostaACBr> {
    return this.request('/mdfe', {
      method: 'POST',
      body: JSON.stringify(mdfeData)
    });
  }

  /**
   * ✅ Atualizar MDFe - dados diretos
   */
  async atualizarMDFe(id: number, mdfeData: MDFeData): Promise<RespostaACBr> {
    return this.request(`/mdfe/${id}`, {
      method: 'PUT',
      body: JSON.stringify(mdfeData)
    });
  }

  /**
   * Obter dados completos do MDFe para edição
   */
  async obterMDFeCompleto(id: number): Promise<RespostaACBr> {
    return this.request(`/mdfe/data/wizard-complete/${id}`, {
      method: 'GET'
    });
  }

  /**
   * Carregar arquivo INI do MDFe
   */
  async carregarINI(mdfeData: MDFeData): Promise<RespostaACBr> {
    try {
      const response = await this.request('/mdfe/carregar-ini', {
        method: 'POST',
        body: JSON.stringify(mdfeData)
      });

      // Log detalhado para depuração do INI gerado
      try {
        const raw = response.dados;
        console.log('🔧 MDFeService.carregarINI - resposta bruta:', raw);

        // Heurística para localizar o INI no payload retornado
        const ini =
          typeof raw === 'string' ? raw :
          raw?.ini || raw?.conteudoIni || raw?.conteudo || raw?.dados || raw?.dados?.ini;

        if (ini) {
          console.log('🧾 INI gerado:\n', ini);
        } else {
          console.log('🧾 INI não encontrado no payload; veja a resposta bruta acima.');
        }
      } catch (logError) {
        console.error('❌ Erro ao tentar logar o INI retornado:', logError);
      }

      return response;
    } catch (error) {
      console.error('❌ MDFeService.carregarINI - ERRO:', error);
      throw error;
    }
  }

  /**
   * Carregar INI simplificado
   */
  async carregarINISimples(dados: {
    emitenteId: number;
    condutorId: number;
    veiculoId: number;
    ufIni: string;
    ufFim: string;
    municipioCarregamento?: string;
    municipioDescarregamento?: string;
    valorTotal?: number;
    pesoBrutoTotal?: number;
    infoAdicional?: string;
  }): Promise<RespostaACBr> {
    return this.request('/mdfe/gerar-ini', {
      method: 'POST',
      body: JSON.stringify(dados)
    });
  }

  /**
   * Consultar status do MDFe na SEFAZ
   */
  async consultarMDFe(chaveAcesso: string): Promise<RespostaACBr> {
    return this.request('/mdfe/consultar-status', {
      method: 'POST',
      body: JSON.stringify({ chaveAcesso })
    });
  }

  /**
   * Gerar MDFe
   */
  async gerarMDFe(id: number): Promise<RespostaACBr> {
    return this.request(`/mdfe/${id}/gerar`, {
      method: 'POST'
    });
  }

  /**
   * Transmitir MDFe
   */
  async transmitirMDFe(id: number): Promise<RespostaACBr> {
    return this.request(`/mdfe/${id}/transmitir`, {
      method: 'POST'
    });
  }

  /**
   * Salvar rascunho
   */
  async salvarRascunho(mdfeData: MDFeData): Promise<RespostaACBr> {
    return this.request('/mdfe/salvar-rascunho', {
      method: 'POST',
      body: JSON.stringify(mdfeData)
    });
  }

  /**
   * Carregar rascunho
   */
  async carregarRascunho(id: string): Promise<RespostaACBr> {
    return this.request(`/mdfe/carregar-rascunho/${encodeURIComponent(id)}`, {
      method: 'GET'
    });
  }

  /**
   * Obter status do serviço
   */
  async obterStatus(): Promise<RespostaACBr> {
    return this.request('/mdfe/status', {
      method: 'GET'
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
    const endpoint = queryString ? `/mdfe?${queryString}` : '/mdfe';

    return this.request(endpoint, {
      method: 'GET'
    });
  }

  /**
   * Obter MDFe por ID
   */
  async obterMDFe(id: number): Promise<RespostaACBr> {
    return this.request(`/mdfe/${id}`, {
      method: 'GET'
    });
  }

  /**
   * Excluir MDFe
   */
  async excluirMDFe(id: number): Promise<RespostaACBr> {
    return this.request(`/mdfe/${id}`, {
      method: 'DELETE'
    });
  }
}

// Exportar instância única
export const mdfeService = new MDFeService();
export default mdfeService;