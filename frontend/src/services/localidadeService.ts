
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

export interface OpcaoRota {
  id: string;
  nome: string;
  percurso: string[];
  distancia: number;
  estados: number;
  recomendada?: boolean;
}

class LocalidadeService {
  // Mapeamento de fallback para nomes de estados
  private readonly estadosNomes: { [sigla: string]: string } = {
    'AC': 'Acre',
    'AL': 'Alagoas',
    'AP': 'Amapá',
    'AM': 'Amazonas',
    'BA': 'Bahia',
    'CE': 'Ceará',
    'DF': 'Distrito Federal',
    'ES': 'Espírito Santo',
    'GO': 'Goiás',
    'MA': 'Maranhão',
    'MT': 'Mato Grosso',
    'MS': 'Mato Grosso do Sul',
    'MG': 'Minas Gerais',
    'PA': 'Pará',
    'PB': 'Paraíba',
    'PR': 'Paraná',
    'PE': 'Pernambuco',
    'PI': 'Piauí',
    'RJ': 'Rio de Janeiro',
    'RN': 'Rio Grande do Norte',
    'RS': 'Rio Grande do Sul',
    'RO': 'Rondônia',
    'RR': 'Roraima',
    'SC': 'Santa Catarina',
    'SP': 'São Paulo',
    'SE': 'Sergipe',
    'TO': 'Tocantins'
  };
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

      // Corrigir nomes de estados se backend retornou sigla duplicada
      const estadosCorrigidos = (estados || []).map((estado: Estado) => ({
        ...estado,
        nome: estado.nome === estado.sigla || !estado.nome
          ? this.estadosNomes[estado.sigla] || estado.sigla
          : estado.nome
      }));

      return estadosCorrigidos;
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

  // Calcula múltiplas rotas alternativas entre origem e destino
  calcularRotasAlternativas(ufOrigem: string, ufDestino: string): string[][] {
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
      return [[ufOrigem]];
    }

    // 🎯 CORREÇÃO CRÍTICA: Verificar primeiro se há conexão direta
    const vizinhosOrigem = conexoes[ufOrigem] || [];
    if (vizinhosOrigem.includes(ufDestino)) {
      // Há conexão direta - retornar como primeira (e principal) opção
      const rotasEncontradas: string[][] = [[ufOrigem, ufDestino]];

      // Adicionar rotas alternativas apenas se necessário
      const rotasAlternativas = this.buscarRotasIndiretas(ufOrigem, ufDestino, conexoes, 2);
      rotasEncontradas.push(...rotasAlternativas.slice(0, 2)); // Máximo 2 alternativas

      return rotasEncontradas;
    }

    // Se não há conexão direta, usar algoritmo completo
    return this.buscarRotasIndiretas(ufOrigem, ufDestino, conexoes, 3);
  }

  // Método auxiliar para buscar rotas indiretas
  private buscarRotasIndiretas(ufOrigem: string, ufDestino: string, conexoes: { [key: string]: string[] }, maxRotas: number): string[][] {
    const rotasEncontradas: string[][] = [];
    const MAX_ROTAS = maxRotas;
    const MAX_DISTANCIA = 5; // Reduzido para evitar rotas muito longas

    const buscarRotas = (ufAtual: string, ufDestino: string, caminhoAtual: string[], visitados: Set<string>) => {
      // Parar se o caminho for muito longo ou já temos rotas suficientes
      if (caminhoAtual.length > MAX_DISTANCIA || rotasEncontradas.length >= MAX_ROTAS) {
        return;
      }

      if (ufAtual === ufDestino) {
        rotasEncontradas.push([...caminhoAtual]);
        return;
      }

      const vizinhos = conexoes[ufAtual] || [];

      // Priorizar vizinhos que conectam diretamente ao destino
      const vizinhosOrdenados = vizinhos.sort((a, b) => {
        const aTemDestino = conexoes[a]?.includes(ufDestino) ? 0 : 1;
        const bTemDestino = conexoes[b]?.includes(ufDestino) ? 0 : 1;
        return aTemDestino - bTemDestino;
      });

      for (const vizinho of vizinhosOrdenados) {
        if (!visitados.has(vizinho) && rotasEncontradas.length < MAX_ROTAS) {
          const novosVisitados = new Set(visitados);
          novosVisitados.add(vizinho);
          buscarRotas(vizinho, ufDestino, [...caminhoAtual, vizinho], novosVisitados);
        }
      }
    };

    const visitadosIniciais = new Set<string>();
    visitadosIniciais.add(ufOrigem);
    buscarRotas(ufOrigem, ufDestino, [ufOrigem], visitadosIniciais);

    // Ordena por tamanho (rotas mais curtas primeiro)
    return rotasEncontradas.sort((a, b) => a.length - b.length);
  }

  // Compatibilidade: Calcula automaticamente os estados de percurso entre origem e destino (menor rota)
  calcularRotaInterestadual(ufOrigem: string, ufDestino: string): string[] {
    const rotasAlternativas = this.calcularRotasAlternativas(ufOrigem, ufDestino);
    return rotasAlternativas[0] || [ufOrigem, ufDestino];
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

  // Gera opções de rotas formatadas para seleção do usuário
  gerarOpcoesRotas(ufOrigem: string, ufDestino: string): OpcaoRota[] {
    const rotasAlternativas = this.calcularRotasAlternativas(ufOrigem, ufDestino);

    return rotasAlternativas.map((rota, index) => {
      const estadosPercurso = rota.slice(1, -1); // Remove origem e destino
      const distanciaEstimada = rota.length - 1; // Estimativa baseada no número de estados

      let nomeRota = '';

      // Determinar nome base da rota
      if (estadosPercurso.length === 0) {
        nomeRota = 'Rota Direta';
      } else if (index === 0) {
        nomeRota = 'Rota Recomendada';
      } else {
        nomeRota = `Rota Alternativa ${index}`;
      }

      // Adicionar detalhes específicos da rota baseado no percurso
      if (estadosPercurso.length > 0) {
        if (estadosPercurso.includes('SP') || estadosPercurso.includes('MG')) {
          nomeRota += ' (Via Grandes Centros)';
        } else if (estadosPercurso.includes('GO') || estadosPercurso.includes('DF')) {
          nomeRota += ' (Via Centro-Oeste)';
        } else if (estadosPercurso.some(uf => ['AM', 'PA', 'RR', 'RO', 'AC'].includes(uf))) {
          nomeRota += ' (Via Região Norte)';
        } else if (estadosPercurso.some(uf => ['CE', 'PE', 'BA', 'AL', 'SE', 'PB', 'RN', 'PI', 'MA'].includes(uf))) {
          nomeRota += ' (Via Região Nordeste)';
        }
      }

      return {
        id: `rota_${index}`,
        nome: nomeRota,
        percurso: rota,
        distancia: distanciaEstimada * 500, // Estimativa em km
        estados: rota.length,
        recomendada: index === 0 // Primeira rota é a recomendada
      };
    });
  }
}

export const localidadeService = new LocalidadeService();