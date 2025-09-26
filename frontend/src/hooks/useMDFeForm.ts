import { useState, useEffect, useCallback } from 'react';
import { MDFeData as AppMDFeData } from '../types/mdfe';

// Tipos para as entidades
interface Entity {
  id: string;
  label: string;
  description: string;
  data: any;
}

interface Entities {
  emitentes: Entity[];
  veiculos: Entity[];
  condutores: Entity[];
  contratantes: Entity[];
  seguradoras: Entity[];
}

// Usar o tipo da aplicação diretamente

// Response do endpoint wizard-complete
interface MDFeWizardResponse {
  mdfe: AppMDFeData | null;
  entities: Entities;
}

/**
 * Hook simplificado para gerenciar formulário MDFe
 *
 * ✅ BENEFÍCIOS:
 * - 1 consulta API ao invés de 5+
 * - 1 hook ao invés de 12 useState
 * - 1 handler genérico ao invés de 5 específicos
 * - Preenchimento automático inteligente
 * - Compatível com sistema fiscal (ACBr/SEFAZ)
 *
 * ELIMINA:
 * ❌ 12 useState diferentes
 * ❌ 5 useEffect complexos
 * ❌ 5 handlers específicos
 * ❌ Múltiplas consultas API
 * ❌ Lógica complexa de sincronização
 */
export const useMDFeForm = (mdfeId?: number) => {
  // Estados consolidados (era 12, agora são 4!)
  const [dados, setDados] = useState<AppMDFeData>({});
  const [entidades, setEntidades] = useState<Entities>({
    emitentes: [],
    veiculos: [],
    condutores: [],
    contratantes: [],
    seguradoras: []
  });
  const [selectedIds, setSelectedIds] = useState({
    emitente: '',
    veiculo: '',
    condutor: '',
    contratante: '',
    seguradora: ''
  });
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  // ✅ 1 useEffect só (era 5!)
  useEffect(() => {
    loadAllData();
  }, [mdfeId]);

  /**
   * ✅ 1 consulta API UNIFICADA
   * Carrega TUDO que precisa: entidades + dados do MDFe (se editando)
   * Antes: 5+ consultas separadas + fetch individual em cada handler
   * Depois: 1 consulta só com todos os dados
   */
  const loadAllData = async () => {
    try {
      setLoading(true);
      setError(null);

      // ✅ ENDPOINT UNIFICADO - carrega tudo de uma vez
      const response = await fetch(`/api/mdfe/wizard-complete/${mdfeId || ''}`);

      if (!response.ok) {
        throw new Error('Erro ao carregar dados');
      }

      const data: MDFeWizardResponse = await response.json();

      // Carregar todas as entidades de uma vez
      setEntidades(data.entities);

      // Se tem MDFe para edição, carregar dados e IDs selecionados
      if (data.mdfe) {
        setDados(data.mdfe);

        // Definir IDs selecionados baseado nos dados do MDFe
        setSelectedIds({
          emitente: data.mdfe.emitenteId?.toString() || '',
          veiculo: data.mdfe.veiculoId?.toString() || '',
          condutor: data.mdfe.motoristaId?.toString() || '',
          contratante: '', // TODO: adicionar se necessário
          seguradora: '' // TODO: adicionar se necessário
        });
      }
    } catch (err) {
      const errorMessage = err instanceof Error ? err.message : 'Erro desconhecido';
      setError(`Erro ao carregar dados: ${errorMessage}`);
      console.error('Erro no useMDFeForm:', err);
    } finally {
      setLoading(false);
    }
  };

  /**
   * ✅ 1 HANDLER GENÉRICO para TODAS as entidades
   * Antes: 5 handlers específicos com código duplicado
   * Depois: 1 handler que funciona para qualquer entidade
   *
   * Funcionalidades:
   * - Selecionar/deselecionar entidade
   * - Preenchimento automático inteligente
   * - Limpeza de dados quando desmarca
   * - Atualização de IDs para backend
   */
  const handleSelectEntity = useCallback((entityType: keyof Entities, id: string) => {
    const entity = entidades[entityType].find(e => e.id === id);

    if (!entity) {
      // Limpar seleção
      setSelectedIds(prev => ({ ...prev, [entityType]: '' }));
      clearEntityData(entityType);
      return;
    }

    // Atualizar ID selecionado
    setSelectedIds(prev => ({ ...prev, [entityType]: id }));

    // ✅ Preenchimento automático baseado na entidade selecionada
    updateEntityData(entityType, entity.data);
  }, [entidades]);

  /**
   * Atualizar dados da entidade no MDFe
   * Preenche automaticamente os campos baseado na seleção do combobox
   */
  const updateEntityData = (entityType: string, entityData: any) => {
    switch (entityType) {
      case 'emitente':
        setDados(prev => ({
          ...prev,
          emitenteId: parseInt(entityData.id),
          emit: {
            CNPJ: entityData.cnpj,
            xNome: entityData.razaoSocial,
            IE: entityData.ie,
            enderEmit: {
              xLgr: entityData.endereco,
              nro: entityData.numero,
              xCpl: entityData.complemento,
              xBairro: entityData.bairro,
              cMun: entityData.codMunicipio?.toString(),
              xMun: entityData.municipio,
              CEP: entityData.cep,
              UF: entityData.uf
            }
          },
          ide: {
            ...prev.ide,
            tpAmb: entityData.ambienteSefaz?.toString() || '2' // ✅ Usar ambiente do emitente!
          }
        }));

        // Log para debug
        console.log(`🔧 Emitente selecionado: ${entityData.razaoSocial}`);
        console.log(`🌍 Ambiente SEFAZ: ${entityData.ambienteSefaz === 1 ? 'PRODUÇÃO' : 'HOMOLOGAÇÃO'}`);
        break;

      case 'veiculo':
        setDados(prev => ({
          ...prev,
          veiculoId: parseInt(entityData.id),
          veiculo: {
            placa: entityData.placa,
            tara: entityData.tara,
            uf: entityData.uf
          }
        }));
        break;

      case 'condutor':
        setDados(prev => ({
          ...prev,
          motoristaId: parseInt(entityData.id),
          condutor: {
            nome: entityData.nome,
            cpf: entityData.cpf
          }
        }));
        break;

      case 'contratante':
        // TODO: Implementar se necessário
        console.log('Contratante selecionado:', entityData);
        break;

      case 'seguradora':
        // TODO: Implementar se necessário
        console.log('Seguradora selecionada:', entityData);
        break;
    }
  };

  /**
   * Limpar dados da entidade quando desmarcada
   */
  const clearEntityData = (entityType: string) => {
    switch (entityType) {
      case 'emitente':
        setDados(prev => ({ ...prev, emitenteId: undefined, emit: undefined }));
        break;
      case 'veiculo':
        setDados(prev => ({ ...prev, veiculoId: undefined, veiculo: undefined }));
        break;
      case 'condutor':
        setDados(prev => ({ ...prev, motoristaId: undefined, condutor: undefined }));
        break;
      case 'contratante':
        // TODO: Implementar se necessário
        break;
      case 'seguradora':
        // TODO: Implementar se necessário
        break;
    }
  };

  /**
   * Atualizar dados diretamente (para campos manuais)
   */
  const updateDados = useCallback((novosDados: Partial<AppMDFeData>) => {
    setDados(prev => ({ ...prev, ...novosDados }));
  }, []);

  /**
   * Resetar formulário
   */
  const resetForm = useCallback(() => {
    setDados({});
    setSelectedIds({
      emitente: '',
      veiculo: '',
      condutor: '',
      contratante: '',
      seguradora: ''
    });
  }, []);

  // ✅ API SIMPLIFICADA - expõe apenas o essencial
  return {
    // Estados
    dados,
    entidades,
    selectedIds,
    loading,
    error,

    // Actions
    handleSelectEntity,  // ← 1 handler genérico para TUDO
    updateDados,         // ← Atualização manual de campos
    resetForm,           // ← Reset completo
    reloadData: loadAllData  // ← Recarregar se necessário
  };
};