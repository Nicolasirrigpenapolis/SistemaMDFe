
const API_BASE_URL = process.env.REACT_APP_API_URL || 'https://localhost:5001/api';

export interface Estado {
  id: number;
  sigla: string;
  nome: string;
}

export interface Municipio {
  id: number;
  codigo: number;
  nome: string;
  uf: string;
}

export interface LocalCarregamento {
  id?: string;
  municipio: string;
  uf: string;
  codigoIBGE: number;
}

export interface RotaCalculada {
  origem: LocalCarregamento;
  destino: LocalCarregamento;
  estadosPercurso: string[];
  distanciaKm?: number;
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
      console.error('Erro ao obter código do município:', error);
      return 0;
    }
  }

  // Calcula automaticamente os estados de percurso entre origem e destino
  calcularRotaInterestadual(ufOrigem: string, ufDestino: string): string[] {
    // Mapa de conexões interestaduais baseado em fronteiras geográficas
    const conexoes: { [key: string]: string[] } = {
      'AC': ['AM', 'RO'],
      'AL': ['PE', 'SE', 'BA'],
      'AP': ['PA'],
      'AM': ['RR', 'PA', 'MT', 'RO', 'AC'],
      'BA': ['PE', 'AL', 'SE', 'MG', 'ES', 'GO', 'TO', 'PI'],
      'CE': ['PI', 'PE', 'PB', 'RN'],
      'DF': ['GO'],
      'ES': ['MG', 'RJ', 'BA'],
      'GO': ['MT', 'MS', 'MG', 'BA', 'TO', 'DF'],
      'MA': ['PI', 'TO', 'PA'],
      'MT': ['RO', 'AM', 'PA', 'TO', 'GO', 'MS'],
      'MS': ['MT', 'GO', 'MG', 'SP', 'PR'],
      'MG': ['SP', 'RJ', 'ES', 'BA', 'GO', 'MS'],
      'PA': ['AM', 'RR', 'AP', 'MA', 'TO', 'MT'],
      'PB': ['PE', 'CE', 'RN'],
      'PR': ['SP', 'SC', 'MS'],
      'PE': ['AL', 'BA', 'PI', 'CE', 'PB'],
      'PI': ['MA', 'TO', 'BA', 'PE', 'CE'],
      'RJ': ['SP', 'MG', 'ES'],
      'RN': ['CE', 'PB'],
      'RS': ['SC'],
      'RO': ['AC', 'AM', 'MT'],
      'RR': ['AM', 'PA'],
      'SC': ['PR', 'RS'],
      'SP': ['MG', 'RJ', 'PR', 'MS'],
      'SE': ['AL', 'BA'],
      'TO': ['MT', 'PA', 'MA', 'PI', 'BA', 'GO']
    };

    if (ufOrigem === ufDestino) {
      return [ufOrigem];
    }

    // Algoritmo BFS para encontrar o menor caminho
    const queue: { uf: string; caminho: string[] }[] = [{ uf: ufOrigem, caminho: [ufOrigem] }];
    const visitados = new Set<string>();

    while (queue.length > 0) {
      const { uf, caminho } = queue.shift()!;

      if (uf === ufDestino) {
        return caminho;
      }

      if (visitados.has(uf)) {
        continue;
      }

      visitados.add(uf);

      const vizinhos = conexoes[uf] || [];
      for (const vizinho of vizinhos) {
        if (!visitados.has(vizinho)) {
          queue.push({
            uf: vizinho,
            caminho: [...caminho, vizinho]
          });
        }
      }
    }

    // Se não encontrar caminho, retorna direto
    return [ufOrigem, ufDestino];
  }

  // Calcula rota completa entre múltiplos pontos
  calcularRotaCompleta(locais: LocalCarregamento[]): RotaCalculada[] {
    const rotas: RotaCalculada[] = [];

    for (let i = 0; i < locais.length - 1; i++) {
      const origem = locais[i];
      const destino = locais[i + 1];

      const estadosPercurso = this.calcularRotaInterestadual(origem.uf, destino.uf);

      rotas.push({
        origem,
        destino,
        estadosPercurso
      });
    }

    return rotas;
  }

  // Obter todos os estados únicos do percurso total
  obterEstadosPercursoTotal(rotas: RotaCalculada[]): string[] {
    const todosEstados = new Set<string>();

    rotas.forEach(rota => {
      rota.estadosPercurso.forEach(uf => todosEstados.add(uf));
    });

    return Array.from(todosEstados).sort();
  }
}

export const localidadeService = new LocalidadeService();