
const API_BASE_URL = process.env.REACT_APP_API_URL || 'https://localhost:5001/api';

export interface Estado {
  id: number;
  sigla: string;
  nome: string;
}

export interface Municipio {
  id: number;
  nome: string;
  uf: string;
}

class LocalidadeService {
  private async request(
    endpoint: string, 
    options: RequestInit = {}
  ): Promise<any> {
    try {
      const response = await fetch(`${API_BASE_URL}${endpoint}`, {
        headers: {
          'Content-Type': 'application/json',
          ...options.headers,
        },
        ...options,
      });

      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }

      return await response.json();
    } catch (error) {
      throw error;
    }
  }

  async obterEstados(): Promise<Estado[]> {
    try {
      const estados = await this.request('/localidade/estados');
      return estados || [];
    } catch (error) {
      return [];
    }
  }

  async obterMunicipiosPorEstado(uf: string): Promise<Municipio[]> {
    try {
      if (!uf || uf.length !== 2) {
        return [];
      }

      const municipios = await this.request(`/localidade/municipios/${uf.toUpperCase()}`);
      return municipios || [];
    } catch (error) {
      return [];
    }
  }

  async obterCodigoMunicipio(municipio: string, uf: string): Promise<number> {
    try {
      const result = await this.request(`/localidade/codigo-municipio?municipio=${encodeURIComponent(municipio)}&uf=${encodeURIComponent(uf)}`);
      return result?.codigo || 0;
    } catch (error) {
      return 0;
    }
  }
}

export const localidadeService = new LocalidadeService();