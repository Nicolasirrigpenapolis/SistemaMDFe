// ⚠️ FRONTEND: APENAS GESTÃO DE ESTADO DA UI
// Lógica de negócio, mapeamentos e transformações movidas para o backend

import { useState, useCallback } from 'react';
import { MDFeData } from '../types/mdfe';

export interface Entity {
  id: string;
  label: string;
  description: string;
}

export interface Entities {
  emitentes: Entity[];
  veiculos: Entity[];
  condutores: Entity[];
  contratantes: Entity[];
  seguradoras: Entity[];
}

/**
 * ✅ Hook SIMPLIFICADO - apenas para UI
 *
 * RESPONSABILIDADES (APENAS UI):
 * - Gerenciar estado do formulário
 * - Controlar seleções nos comboboxes
 * - Atualizar campos da UI
 *
 * NÃO FAZ MAIS:
 * ❌ Consultas API complexas
 * ❌ Transformações de dados
 * ❌ Validações de negócio
 * ❌ Mapeamentos frontend ↔ backend
 * ❌ Correções/lógica de dados
 */
export const useMDFeForm = () => {
  // Estados simples para UI
  const [dados, setDados] = useState<Partial<MDFeData>>({});
  const [selectedIds, setSelectedIds] = useState({
    emitenteId: '',
    veiculoId: '',
    condutorId: '',
    contratanteId: '',
    seguradoraId: ''
  });

  // ✅ Atualizar campo do formulário (UI apenas)
  const updateField = useCallback((field: string, value: any) => {
    setDados(prev => ({ ...prev, [field]: value }));
  }, []);

  // ✅ Atualizar seleção de entidade (UI apenas)
  const selectEntity = useCallback((entityType: string, id: string) => {
    setSelectedIds(prev => ({ ...prev, [`${entityType}Id`]: id }));

    // Atualizar o dado correspondente
    const numericId = id ? parseInt(id) : undefined;
    setDados(prev => ({ ...prev, [`${entityType}Id`]: numericId }));
  }, []);

  // ✅ Definir dados completos (vem do componente pai)
  const setFormData = useCallback((data: Partial<MDFeData>) => {
    setDados(data);

    // Atualizar selectedIds baseado nos dados
    setSelectedIds({
      emitenteId: data.emitenteId?.toString() || '',
      veiculoId: data.veiculoId?.toString() || '',
      condutorId: data.condutorId?.toString() || '',
      contratanteId: data.contratanteId?.toString() || '',
      seguradoraId: data.seguradoraId?.toString() || ''
    });
  }, []);

  // ✅ Reset do formulário
  const resetForm = useCallback(() => {
    setDados({});
    setSelectedIds({
      emitenteId: '',
      veiculoId: '',
      condutorId: '',
      contratanteId: '',
      seguradoraId: ''
    });
  }, []);

  // ✅ API ULTRA-SIMPLIFICADA - apenas UI
  return {
    // Estados da UI
    dados,
    selectedIds,

    // Actions da UI
    updateField,     // ← Atualizar um campo
    selectEntity,    // ← Selecionar entidade no combobox
    setFormData,     // ← Definir dados completos
    resetForm        // ← Reset
  };
};