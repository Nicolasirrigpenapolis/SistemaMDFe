import { RespostaACBr } from '../types/mdfe';
import { ApiResponse, PaginatedApiResponse } from '../types/apiResponse';
import { ErrorMessageHelper } from '../utils/errorMessages';

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

      // Verificar se há conteúdo para fazer parse do JSON
      const text = await response.text();
      let data;

      try {
        data = text ? JSON.parse(text) : {};
      } catch (jsonError) {
        console.warn('Resposta não é JSON válido:', text);
        data = { message: text || 'Resposta vazia' };
      }

      if (!response.ok) {
        // Detectar se é uma resposta ApiResponse (novo formato)
        if (data.success !== undefined) {
          return {
            sucesso: false,
            mensagem: data.message || 'Erro na operação',
            codigoErro: data.errors?.[0]?.code || response.status.toString(),
            detalhesValidacao: data.errors?.reduce((acc: any, err: any) => {
              if (err.field) {
                acc[err.field] = [err.message];
              }
              return acc;
            }, {}) || undefined
          };
        }

        // Formato antigo
        const errorMessage = data.message ||
                           ErrorMessageHelper.getApiErrorMessage({
                             ...data,
                             status: response.status
                           });

        return {
          sucesso: false,
          mensagem: errorMessage,
          codigoErro: data.errorCode || response.status.toString(),
          detalhesValidacao: data.errors || undefined
        };
      }

      // Se não há dados (resposta 204 ou similar), considerar sucesso
      if (!text || Object.keys(data).length === 0) {
        return {
          sucesso: true,
          mensagem: 'Operação realizada com sucesso',
          dados: null
        };
      }

      // Detectar se é uma resposta ApiResponse (novo formato)
      if (data.success !== undefined) {
        return {
          sucesso: data.success,
          mensagem: data.message || 'Operação realizada com sucesso',
          dados: data.data || data
        };
      }

      // Formato antigo
      return {
        sucesso: true,
        mensagem: data.message || 'Operação realizada com sucesso',
        dados: data.data || data
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

  // Emitentes
  async obterEmitentes(): Promise<EntityOption[]> {
    const response = await this.request('/emitentes?pageSize=100'); // Buscar emitentes (máximo permitido pelo backend)

    if (!response.sucesso || !response.dados) {
      console.warn('❌ [entitiesService] Falha ao obter emitentes:', response.mensagem);
      return [];
    }

    // O backend pode retornar dados em diferentes formatos:
    // Novo formato atual: { items: [...], totalItems: 0, ... }
    // Formato antigo: { Itens: [...], TotalItens: 0, ... }
    // Array direto: [...]
    let emitentes;
    if (Array.isArray(response.dados)) {
      emitentes = response.dados;
    } else if (response.dados.items) {
      // Formato atual do backend
      emitentes = response.dados.items;
    } else if (response.dados.Itens) {
      // Formato antigo
      emitentes = response.dados.Itens;
    } else {
      emitentes = response.dados;
    }

    if (!Array.isArray(emitentes)) {
      console.error('❌ [entitiesService] Formato de dados inesperado:', response.dados);
      return [];
    }

    const result = emitentes.map((emitente: any) => ({
      id: (emitente.id || emitente.Id).toString(),
      label: emitente.razaoSocial || emitente.RazaoSocial || emitente.nomeFantasia || emitente.NomeFantasia,
      description: `${emitente.cnpj || emitente.Cnpj} - ${emitente.municipio || emitente.Municipio || ''}`,
      data: {
        CNPJ: emitente.cnpj || emitente.Cnpj,
        IE: emitente.ie || emitente.Ie,
        xNome: emitente.razaoSocial || emitente.RazaoSocial,
        xFant: emitente.nomeFantasia || emitente.NomeFantasia,
        enderEmit: {
          xLgr: emitente.endereco || emitente.Endereco,
          nro: emitente.numero || emitente.Numero,
          xCpl: emitente.complemento || emitente.Complemento,
          xBairro: emitente.bairro || emitente.Bairro,
          cMun: (emitente.codMunicipio || emitente.CodMunicipio)?.toString(),
          xMun: emitente.municipio || emitente.Municipio,
          CEP: emitente.cep || emitente.Cep,
          UF: emitente.uf || emitente.Uf,
          fone: emitente.telefone || emitente.Telefone,
          email: emitente.email || emitente.Email
        }
      }
    }));

    return result;
  }

  // Condutores
  async obterCondutores(): Promise<EntityOption[]> {
    const response = await this.request('/condutores?pageSize=100'); // Buscar condutores (máximo permitido pelo backend)
    if (!response.sucesso || !response.dados) {
      console.warn('Condutores não disponíveis:', response.mensagem);
      return [];
    }

    // O backend pode retornar dados em diferentes formatos
    let condutores;
    if (Array.isArray(response.dados)) {
      condutores = response.dados;
    } else if (response.dados.items) {
      condutores = response.dados.items;
    } else if (response.dados.Itens) {
      condutores = response.dados.Itens;
    } else {
      condutores = response.dados;
    }

    if (!Array.isArray(condutores)) {
      console.error('Formato de dados inesperado para condutores:', response.dados);
      return [];
    }

    return condutores.map((condutor: any) => ({
      id: (condutor.id || condutor.Id).toString(),
      label: condutor.nome || condutor.Nome,
      description: `CPF: ${condutor.cpf || condutor.Cpf}`,
      data: {
        xNome: condutor.nome || condutor.Nome,
        CPF: condutor.cpf || condutor.Cpf
      }
    }));
  }

  // Veículos
  async obterVeiculos(): Promise<EntityOption[]> {
    const response = await this.request('/veiculos?pageSize=100'); // Buscar veículos (máximo permitido pelo backend)
    if (!response.sucesso || !response.dados) {
      console.warn('Veículos não disponíveis:', response.mensagem);
      return [];
    }

    // O backend pode retornar dados em diferentes formatos
    let veiculos;
    if (Array.isArray(response.dados)) {
      veiculos = response.dados;
    } else if (response.dados.items) {
      veiculos = response.dados.items;
    } else if (response.dados.Itens) {
      veiculos = response.dados.Itens;
    } else {
      veiculos = response.dados;
    }

    if (!Array.isArray(veiculos)) {
      console.error('Formato de dados inesperado para veículos:', response.dados);
      return [];
    }

    return veiculos.map((veiculo: any) => ({
      id: (veiculo.id || veiculo.Id).toString(),
      label: `${veiculo.placa || veiculo.Placa} - ${veiculo.marca || veiculo.Marca} ${veiculo.modelo || veiculo.Modelo}`,
      description: `Ano: ${veiculo.ano || veiculo.Ano}`,
      data: {
        cInt: (veiculo.id || veiculo.Id)?.toString(),
        placa: veiculo.placa || veiculo.Placa,
        tara: (veiculo.tara || veiculo.Tara)?.toString(),
        capKG: (veiculo.capacidadeKg || veiculo.CapacidadeKg)?.toString(),
        capM3: (veiculo.capacidadeM3 || veiculo.CapacidadeM3)?.toString(),
        tpProp: '1', // Padrão: próprio
        tpVeic: '07', // Padrão: caminhão trator
        tpRod: veiculo.tipoRodado || veiculo.TipoRodado,
        tpCar: veiculo.tipoCarroceria || veiculo.TipoCarroceria,
        UF: veiculo.uf || veiculo.Uf
      }
    }));
  }

  // Destinatários/Remetentes (pessoas jurídicas que não são emitentes)
  async obterDestinatarios(): Promise<EntityOption[]> {
    const response = await this.request('/emitentes?tipo=destinatario&pageSize=100');
    if (!response.sucesso || !response.dados) {
      return [];
    }

    // O backend retorna dados paginados: { Itens: [], TotalItens: 0, Pagina: 1, TamanhoPagina: 10 }
    const destinatarios = response.dados.Itens || response.dados;
    if (!Array.isArray(destinatarios)) {
      return [];
    }

    return destinatarios.map((destinatario: any) => ({
      id: destinatario.Id || destinatario.id,
      label: destinatario.RazaoSocial || destinatario.NomeFantasia,
      description: `${destinatario.Cnpj} - ${destinatario.Municipio || ''}`,
      data: {
        CNPJ: destinatario.Cnpj,
        IE: destinatario.Ie,
        xNome: destinatario.RazaoSocial,
        xFant: destinatario.NomeFantasia,
        enderDest: {
          xLgr: destinatario.Endereco,
          nro: destinatario.Numero,
          xCpl: destinatario.Complemento,
          xBairro: destinatario.Bairro,
          cMun: destinatario.CodMunicipio?.toString(),
          xMun: destinatario.Municipio,
          CEP: destinatario.Cep,
          UF: destinatario.Uf
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
          id: seguradora.Id || seguradora.id,
          label: seguradora.Nome || seguradora.nome,
          description: `CNPJ: ${seguradora.Cnpj || seguradora.cnpj}`,
          data: {
            xSeg: seguradora.Nome || seguradora.nome,
            CNPJ: seguradora.Cnpj || seguradora.cnpj
          }
        }));
      }
      return [];
    }

    // O backend retorna dados paginados: { Itens: [], TotalItens: 0, Pagina: 1, TamanhoPagina: 10 }
    const seguradoras = response.dados.Itens || response.dados;
    if (!Array.isArray(seguradoras)) {
      return [];
    }

    return seguradoras.map((seguradora: any) => ({
      id: seguradora.Id || seguradora.id,
      label: seguradora.Nome || seguradora.nome,
      description: `CNPJ: ${seguradora.Cnpj || seguradora.cnpj}`,
      data: {
        xSeg: seguradora.Nome || seguradora.nome,
        CNPJ: seguradora.Cnpj || seguradora.cnpj
      }
    }));
  }

  // ========== MÉTODOS CRUD PARA EMITENTES ==========

  async criarEmitente(dados: any): Promise<RespostaACBr> {
    // Limpar dados antes de enviar
    const dadosLimpos = {
      ...dados,
      cnpj: dados.cnpj ? dados.cnpj.replace(/\D/g, '') : undefined,
      cpf: dados.cpf ? dados.cpf.replace(/\D/g, '') : undefined,
      telefone: dados.telefone ? dados.telefone.replace(/\D/g, '') : undefined,
      cep: dados.cep ? dados.cep.replace(/\D/g, '') : undefined
    };

    console.log('Dados enviados para POST /emitentes:', JSON.stringify(dadosLimpos, null, 2));

    return await this.request('/emitentes', {
      method: 'POST',
      body: JSON.stringify(dadosLimpos)
    });
  }

  async atualizarEmitente(id: number, dados: any): Promise<RespostaACBr> {
    // Limpar dados antes de enviar
    const dadosLimpos = {
      ...dados,
      cnpj: dados.cnpj ? dados.cnpj.replace(/\D/g, '') : undefined,
      cpf: dados.cpf ? dados.cpf.replace(/\D/g, '') : undefined,
      telefone: dados.telefone ? dados.telefone.replace(/\D/g, '') : undefined,
      cep: dados.cep ? dados.cep.replace(/\D/g, '') : undefined
    };

    // Converter para PascalCase conforme esperado pelo backend
    const dadosBackend = {
      Cnpj: dadosLimpos.cnpj,
      Cpf: dadosLimpos.cpf,
      Ie: dadosLimpos.ie,
      RazaoSocial: dadosLimpos.razaoSocial,
      NomeFantasia: dadosLimpos.nomeFantasia,
      Endereco: dadosLimpos.endereco,
      Numero: dadosLimpos.numero,
      Complemento: dadosLimpos.complemento,
      Bairro: dadosLimpos.bairro,
      CodMunicipio: dadosLimpos.codMunicipio,
      Municipio: dadosLimpos.municipio,
      Cep: dadosLimpos.cep,
      Uf: dadosLimpos.uf,
      Telefone: dadosLimpos.telefone,
      Email: dadosLimpos.email,
      Ativo: dadosLimpos.ativo,
      TipoEmitente: dadosLimpos.tipoEmitente,
      DescricaoEmitente: dadosLimpos.descricaoEmitente,
      CaminhoArquivoCertificado: dadosLimpos.caminhoArquivoCertificado,
      SenhaCertificado: dadosLimpos.senhaCertificado,
      Rntrc: dadosLimpos.rntrc,
      AmbienteSefaz: dadosLimpos.ambienteSefaz
    };

    console.log('Dados enviados para PUT /emitentes/' + id + ':', JSON.stringify(dadosBackend, null, 2));

    return await this.request(`/emitentes/${id}`, {
      method: 'PUT',
      body: JSON.stringify(dadosBackend)
    });
  }

  async excluirEmitente(id: number): Promise<RespostaACBr> {
    return await this.request(`/emitentes/${id}`, {
      method: 'DELETE'
    });
  }

  // ========== MÉTODOS CRUD PARA CONDUTORES ==========

  async criarCondutor(dados: any): Promise<RespostaACBr> {
    // Limpar dados antes de enviar
    const dadosLimpos = {
      ...dados,
      cpf: dados.cpf ? dados.cpf.replace(/\D/g, '') : undefined,
      telefone: dados.telefone ? dados.telefone.replace(/\D/g, '') : undefined,
      cep: dados.cep ? dados.cep.replace(/\D/g, '') : undefined
    };

    console.log('Dados enviados para POST /condutores:', JSON.stringify(dadosLimpos, null, 2));

    return await this.request('/condutores', {
      method: 'POST',
      body: JSON.stringify(dadosLimpos)
    });
  }

  async atualizarCondutor(id: number, dados: any): Promise<RespostaACBr> {
    // Limpar dados antes de enviar
    const dadosLimpos = {
      ...dados,
      cpf: dados.cpf ? dados.cpf.replace(/\D/g, '') : undefined,
      telefone: dados.telefone ? dados.telefone.replace(/\D/g, '') : undefined,
      cep: dados.cep ? dados.cep.replace(/\D/g, '') : undefined
    };

    console.log('Dados enviados para PUT /condutores/' + id + ':', JSON.stringify(dadosLimpos, null, 2));

    return await this.request(`/condutores/${id}`, {
      method: 'PUT',
      body: JSON.stringify(dadosLimpos)
    });
  }

  async excluirCondutor(id: number): Promise<RespostaACBr> {
    return await this.request(`/condutores/${id}`, {
      method: 'DELETE'
    });
  }

  // ========== MÉTODOS CRUD PARA VEÍCULOS ==========

  async criarVeiculo(dados: any): Promise<RespostaACBr> {
    // Limpar dados antes de enviar
    const dadosLimpos = {
      ...dados,
      telefone: dados.telefone ? dados.telefone.replace(/\D/g, '') : undefined,
      cep: dados.cep ? dados.cep.replace(/\D/g, '') : undefined
    };

    console.log('Dados enviados para POST /veiculos:', JSON.stringify(dadosLimpos, null, 2));

    return await this.request('/veiculos', {
      method: 'POST',
      body: JSON.stringify(dadosLimpos)
    });
  }

  async atualizarVeiculo(id: number, dados: any): Promise<RespostaACBr> {
    // Limpar dados antes de enviar
    const dadosLimpos = {
      ...dados,
      telefone: dados.telefone ? dados.telefone.replace(/\D/g, '') : undefined,
      cep: dados.cep ? dados.cep.replace(/\D/g, '') : undefined
    };

    console.log('Dados enviados para PUT /veiculos/' + id + ':', JSON.stringify(dadosLimpos, null, 2));

    return await this.request(`/veiculos/${id}`, {
      method: 'PUT',
      body: JSON.stringify(dadosLimpos)
    });
  }

  async excluirVeiculo(id: number): Promise<RespostaACBr> {
    return await this.request(`/veiculos/${id}`, {
      method: 'DELETE'
    });
  }

  // ========== MÉTODOS CRUD PARA SEGURADORAS ==========

  async criarSeguradora(dados: any): Promise<RespostaACBr> {
    // Limpar dados antes de enviar
    const dadosLimpos = {
      ...dados,
      cnpj: dados.cnpj ? dados.cnpj.replace(/\D/g, '') : undefined,
      telefone: dados.telefone ? dados.telefone.replace(/\D/g, '') : undefined,
      cep: dados.cep ? dados.cep.replace(/\D/g, '') : undefined
    };

    // Converter para o formato esperado pelo backend (PascalCase com wrapper dto)
    const dadosBackend = {
      dto: {
        Cnpj: dadosLimpos.cnpj,
        RazaoSocial: dadosLimpos.razaoSocial,
        NomeFantasia: dadosLimpos.nomeFantasia,
        Endereco: dadosLimpos.endereco,
        Numero: dadosLimpos.numero,
        Complemento: dadosLimpos.complemento,
        Bairro: dadosLimpos.bairro,
        CodMunicipio: dadosLimpos.codMunicipio,
        Municipio: dadosLimpos.municipio,
        Cep: dadosLimpos.cep,
        Uf: dadosLimpos.uf,
        Telefone: dadosLimpos.telefone,
        Email: dadosLimpos.email,
        CodigoSusep: dadosLimpos.codigoSusep,
        Apolice: dadosLimpos.apolice,
        Ativo: dadosLimpos.ativo
      }
    };

    console.log('Dados enviados para POST /seguradoras:', JSON.stringify(dadosBackend, null, 2));

    return await this.request('/seguradoras', {
      method: 'POST',
      body: JSON.stringify(dadosBackend)
    });
  }

  async atualizarSeguradora(id: number, dados: any): Promise<RespostaACBr> {
    // Limpar dados antes de enviar
    const dadosLimpos = {
      ...dados,
      cnpj: dados.cnpj ? dados.cnpj.replace(/\D/g, '') : undefined,
      telefone: dados.telefone ? dados.telefone.replace(/\D/g, '') : undefined,
      cep: dados.cep ? dados.cep.replace(/\D/g, '') : undefined
    };

    console.log('Dados enviados para PUT /seguradoras/' + id + ':', JSON.stringify(dadosLimpos, null, 2));

    return await this.request(`/seguradoras/${id}`, {
      method: 'PUT',
      body: JSON.stringify(dadosLimpos)
    });
  }

  async excluirSeguradora(id: number): Promise<RespostaACBr> {
    return await this.request(`/seguradoras/${id}`, {
      method: 'DELETE'
    });
  }

  // ========== MÉTODOS CRUD PARA CONTRATANTES ==========

  async criarContratante(dados: any): Promise<RespostaACBr> {
    // Limpar dados antes de enviar
    const dadosLimpos = {
      ...dados,
      cnpj: dados.cnpj ? dados.cnpj.replace(/\D/g, '') : undefined,
      cpf: dados.cpf ? dados.cpf.replace(/\D/g, '') : undefined,
      telefone: dados.telefone ? dados.telefone.replace(/\D/g, '') : undefined,
      cep: dados.cep ? dados.cep.replace(/\D/g, '') : undefined
    };

    console.log('Dados enviados para POST /contratantes:', JSON.stringify(dadosLimpos, null, 2));

    return await this.request('/contratantes', {
      method: 'POST',
      body: JSON.stringify(dadosLimpos)
    });
  }

  async atualizarContratante(id: number, dados: any): Promise<RespostaACBr> {
    // Limpar dados antes de enviar
    const dadosLimpos = {
      ...dados,
      cnpj: dados.cnpj ? dados.cnpj.replace(/\D/g, '') : undefined,
      cpf: dados.cpf ? dados.cpf.replace(/\D/g, '') : undefined,
      telefone: dados.telefone ? dados.telefone.replace(/\D/g, '') : undefined,
      cep: dados.cep ? dados.cep.replace(/\D/g, '') : undefined
    };

    console.log('Dados enviados para PUT /contratantes/' + id + ':', JSON.stringify(dadosLimpos, null, 2));

    return await this.request(`/contratantes/${id}`, {
      method: 'PUT',
      body: JSON.stringify(dadosLimpos)
    });
  }

  async excluirContratante(id: number): Promise<RespostaACBr> {
    return await this.request(`/contratantes/${id}`, {
      method: 'DELETE'
    });
  }

  // ========== MÉTODOS CRUD PARA REBOQUES ==========

  async criarReboque(dados: any): Promise<RespostaACBr> {
    // Limpar dados antes de enviar
    const dadosLimpos = {
      ...dados,
      telefone: dados.telefone ? dados.telefone.replace(/\D/g, '') : undefined,
      cep: dados.cep ? dados.cep.replace(/\D/g, '') : undefined
    };

    console.log('Dados enviados para POST /reboques:', JSON.stringify(dadosLimpos, null, 2));

    return await this.request('/reboques', {
      method: 'POST',
      body: JSON.stringify(dadosLimpos)
    });
  }

  async atualizarReboque(id: number, dados: any): Promise<RespostaACBr> {
    // Limpar dados antes de enviar
    const dadosLimpos = {
      ...dados,
      telefone: dados.telefone ? dados.telefone.replace(/\D/g, '') : undefined,
      cep: dados.cep ? dados.cep.replace(/\D/g, '') : undefined
    };

    console.log('Dados enviados para PUT /reboques/' + id + ':', JSON.stringify(dadosLimpos, null, 2));

    return await this.request(`/reboques/${id}`, {
      method: 'PUT',
      body: JSON.stringify(dadosLimpos)
    });
  }

  async excluirReboque(id: number): Promise<RespostaACBr> {
    return await this.request(`/reboques/${id}`, {
      method: 'DELETE'
    });
  }
}

export const entitiesService = new EntitiesService();
export type { EntityOption };