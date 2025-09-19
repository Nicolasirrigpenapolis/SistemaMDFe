import { RespostaACBr } from '../types/mdfe';

const API_BASE_URL = process.env.REACT_APP_API_URL || 'https://localhost:5001/api';

interface EntityOption {
  id: string;
  label: string;
  description?: string;
  data: any;
}

class EntitiesService {
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
          mensagem: data.message || 'Erro na requisição',
          codigoErro: data.errorCode || response.status.toString()
        };
      }

      return {
        sucesso: true,
        mensagem: data.message || 'Operação realizada com sucesso',
        dados: data.data || data
      };
    } catch (error) {
      return {
        sucesso: false,
        mensagem: error instanceof Error ? error.message : 'Erro de comunicação com a API',
        codigoErro: 'NETWORK_ERROR'
      };
    }
  }

  // Emitentes
  async obterEmitentes(): Promise<EntityOption[]> {
    const response = await this.request('/empresas/emitentes');
    if (!response.sucesso || !response.dados) {
      return [];
    }

    return response.dados.map((emitente: any) => ({
      id: emitente.id,
      label: emitente.razaoSocial || emitente.nomeFantasia,
      description: `${emitente.cnpj} - ${emitente.endereco?.cidade || ''}`,
      data: {
        CNPJ: emitente.cnpj,
        IE: emitente.inscricaoEstadual,
        xNome: emitente.razaoSocial,
        xFant: emitente.nomeFantasia,
        enderEmit: {
          xLgr: emitente.endereco?.logradouro,
          nro: emitente.endereco?.numero,
          xCpl: emitente.endereco?.complemento,
          xBairro: emitente.endereco?.bairro,
          cMun: emitente.endereco?.codigoMunicipio,
          xMun: emitente.endereco?.cidade,
          CEP: emitente.endereco?.cep,
          UF: emitente.endereco?.uf
        }
      }
    }));
  }

  // Condutores
  async obterCondutores(): Promise<EntityOption[]> {
    const response = await this.request('/condutores');
    if (!response.sucesso || !response.dados) {
      return [];
    }

    return response.dados.map((condutor: any) => ({
      id: condutor.id,
      label: condutor.nome,
      description: `CPF: ${condutor.cpf}`,
      data: {
        xNome: condutor.nome,
        CPF: condutor.cpf
      }
    }));
  }

  // Veículos
  async obterVeiculos(): Promise<EntityOption[]> {
    const response = await this.request('/veiculos');
    if (!response.sucesso || !response.dados) {
      return [];
    }

    return response.dados.map((veiculo: any) => ({
      id: veiculo.id,
      label: `${veiculo.placa} - ${veiculo.marca} ${veiculo.modelo}`,
      description: `RENAVAM: ${veiculo.renavam} - Ano: ${veiculo.ano}`,
      data: {
        cInt: veiculo.codigoInterno,
        placa: veiculo.placa,
        RENAVAM: veiculo.renavam,
        tara: veiculo.tara.toString(),
        capKG: veiculo.capacidadeKg.toString(),
        capM3: veiculo.capacidadeM3.toString(),
        tpProp: veiculo.tipoPropriedade,
        tpVeic: veiculo.tipoVeiculo,
        tpRod: veiculo.tipoRodado,
        tpCar: veiculo.tipoCarroceria,
        UF: veiculo.uf
      }
    }));
  }

  // Destinatários/Remetentes (pessoas jurídicas que não são emitentes)
  async obterDestinatarios(): Promise<EntityOption[]> {
    const response = await this.request('/empresas?tipo=destinatario');
    if (!response.sucesso || !response.dados) {
      return [];
    }

    return response.dados.map((destinatario: any) => ({
      id: destinatario.id,
      label: destinatario.razaoSocial || destinatario.nomeFantasia,
      description: `${destinatario.cnpj} - ${destinatario.endereco?.cidade || ''}`,
      data: {
        CNPJ: destinatario.cnpj,
        IE: destinatario.inscricaoEstadual,
        xNome: destinatario.razaoSocial,
        xFant: destinatario.nomeFantasia,
        enderDest: {
          xLgr: destinatario.endereco?.logradouro,
          nro: destinatario.endereco?.numero,
          xCpl: destinatario.endereco?.complemento,
          xBairro: destinatario.endereco?.bairro,
          cMun: destinatario.endereco?.codigoMunicipio,
          xMun: destinatario.endereco?.cidade,
          CEP: destinatario.endereco?.cep,
          UF: destinatario.endereco?.uf
        }
      }
    }));
  }

  // Seguradoras
  async obterSeguradoras(): Promise<EntityOption[]> {
    const response = await this.request('/seguradoras');
    if (!response.sucesso || !response.dados) {
      // Fallback para sugestões se não houver dados
      const sugestoes = await this.request('/seguradoras/sugestoes');
      if (sugestoes.sucesso && sugestoes.dados) {
        return sugestoes.dados.map((seguradora: any) => ({
          id: seguradora.id,
          label: seguradora.nome,
          description: `CNPJ: ${seguradora.cnpj}`,
          data: {
            xSeg: seguradora.nome,
            CNPJ: seguradora.cnpj
          }
        }));
      }
      return [];
    }

    return response.dados.map((seguradora: any) => ({
      id: seguradora.id,
      label: seguradora.nome,
      description: `CNPJ: ${seguradora.cnpj}`,
      data: {
        xSeg: seguradora.nome,
        CNPJ: seguradora.cnpj
      }
    }));
  }

}

export const entitiesService = new EntitiesService();
export type { EntityOption };