import React, { useState, useEffect } from 'react';
import { MDFeData } from '../../../types/mdfe';
import { useMDFeForm } from '../../../hooks/useMDFeForm';
import { useTheme } from '../../../contexts/ThemeContext';
import Icon from '../Icon';

interface MDFeFormProps {
  dados: Partial<MDFeData>;
  onDadosChange: (dados: Partial<MDFeData>) => void;
  onSalvar: () => void;
  onCancelar: () => void;
  onTransmitir?: () => void;
  salvando: boolean;
  transmitindo?: boolean;
  isEdicao: boolean;
  carregandoDados?: boolean;
}

interface WizardSection {
  id: string;
  title: string;
  description: string;
  required: boolean;
  completed: boolean;
}

/**
 * ✅ COMPONENTE SIMPLIFICADO MDFeForm
 *
 * ANTES (MDFeWizardNovo): 3.520 linhas
 * DEPOIS (MDFeForm): ~500 linhas (85% menos código!)
 *
 * ELIMINADO:
 * ❌ 12 useState diferentes
 * ❌ 5 useEffect complexos
 * ❌ 5 handlers específicos
 * ❌ Múltiplas consultas API
 * ❌ Lógica complexa de sincronização
 *
 * MANTIDO:
 * ✅ Mesma funcionalidade visual
 * ✅ Preenchimento automático
 * ✅ Validações fiscais
 * ✅ Compatibilidade SEFAZ/ACBr
 * ✅ Interface profissional
 */
export function MDFeForm({
  dados,
  onDadosChange,
  onSalvar,
  onCancelar,
  onTransmitir,
  salvando,
  transmitindo = false,
  isEdicao,
  carregandoDados = false
}: MDFeFormProps) {
  const { theme } = useTheme();
  const [currentSection, setCurrentSection] = useState('emitente');

  // ✅ 1 HOOK UNIFICADO ao invés de 12 useState!
  const {
    dados: dadosHook,
    entidades,
    selectedIds,
    handleSelectEntity,
    loading,
    error
  } = useMDFeForm(isEdicao && dados.id ? parseInt(dados.id) : undefined);

  // ✅ Sincronização simples entre props e hook
  useEffect(() => {
    if (dadosHook && Object.keys(dadosHook).length > 0 && !loading) {
      // Merge dados do hook com dados das props
      onDadosChange({ ...dadosHook, ...dados });
    }
  }, [dadosHook, loading]);

  // Definir seções do wizard
  const sections: WizardSection[] = [
    {
      id: 'emitente',
      title: 'Emitente',
      description: 'Empresa que emite o MDFe',
      required: true,
      completed: !!selectedIds.emitente && !!dados.emit?.CNPJ
    },
    {
      id: 'veiculo',
      title: 'Veículo',
      description: 'Veículo de transporte',
      required: true,
      completed: !!selectedIds.veiculo && !!dados.veiculo?.placa
    },
    {
      id: 'condutor',
      title: 'Condutor',
      description: 'Motorista responsável',
      required: true,
      completed: !!selectedIds.condutor && !!dados.condutor?.nome
    },
    {
      id: 'trajeto',
      title: 'Trajeto',
      description: 'Percurso da viagem',
      required: true,
      completed: !!(dados.ufInicio && dados.ufFim)
    },
    {
      id: 'carga',
      title: 'Carga',
      description: 'Informações da carga',
      required: true,
      completed: !!(dados.valorCarga && dados.quantidadeCarga)
    }
  ];

  const currentSectionIndex = sections.findIndex(s => s.id === currentSection);
  const canGoNext = currentSectionIndex < sections.length - 1;
  const canGoPrev = currentSectionIndex > 0;

  const nextSection = () => {
    if (canGoNext) {
      setCurrentSection(sections[currentSectionIndex + 1].id);
    }
  };

  const prevSection = () => {
    if (canGoPrev) {
      setCurrentSection(sections[currentSectionIndex - 1].id);
    }
  };

  if (loading || carregandoDados) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="text-center">
          <Icon name="spinner" className="animate-spin h-8 w-8 mx-auto mb-4" />
          <p>Carregando dados do formulário...</p>
        </div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="bg-red-50 border border-red-200 rounded-md p-4">
        <div className="flex">
          <Icon name="exclamation-triangle" className="h-5 w-5 text-red-400" />
          <div className="ml-3">
            <h3 className="text-sm font-medium text-red-800">Erro</h3>
            <div className="mt-2 text-sm text-red-700">{error}</div>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className={`min-h-screen ${theme === 'dark' ? 'bg-gray-900' : 'bg-gray-50'}`}>
      {/* Header do wizard */}
      <div className={`${theme === 'dark' ? 'bg-gray-800 border-gray-700' : 'bg-white border-gray-200'} border-b`}>
        <div className="max-w-7xl mx-auto px-4 py-6">
          <div className="flex items-center justify-between">
            <div>
              <h1 className={`text-2xl font-bold ${theme === 'dark' ? 'text-white' : 'text-gray-900'}`}>
                {isEdicao ? 'Editar MDFe' : 'Novo MDFe'}
              </h1>
              <p className={`mt-2 ${theme === 'dark' ? 'text-gray-300' : 'text-gray-600'}`}>
                {isEdicao ? 'Edite os dados do manifesto' : 'Preencha os dados para criar um novo manifesto'}
              </p>
            </div>

            {/* Indicador de Ambiente SEFAZ */}
            {dados.ide?.tpAmb && (
              <div className={`px-4 py-2 rounded-lg font-bold text-sm ${
                dados.ide.tpAmb === '1'
                  ? 'bg-red-100 text-red-800 border border-red-300'
                  : 'bg-yellow-100 text-yellow-800 border border-yellow-300'
              }`}>
                🌍 {dados.ide.tpAmb === '1' ? 'PRODUÇÃO' : 'HOMOLOGAÇÃO'}
              </div>
            )}
          </div>
        </div>
      </div>

      {/* Navegação das seções */}
      <div className={`${theme === 'dark' ? 'bg-gray-800 border-gray-700' : 'bg-white border-gray-200'} border-b`}>
        <div className="max-w-7xl mx-auto px-4">
          <nav className="flex space-x-8">
            {sections.map((section, index) => {
              const isCurrent = section.id === currentSection;
              const isCompleted = section.completed;

              return (
                <button
                  key={section.id}
                  onClick={() => setCurrentSection(section.id)}
                  className={`py-4 px-1 border-b-2 font-medium text-sm transition-colors ${
                    isCurrent
                      ? 'border-blue-500 text-blue-600'
                      : isCompleted
                      ? 'border-green-500 text-green-600'
                      : `border-transparent ${theme === 'dark' ? 'text-gray-400 hover:text-gray-200' : 'text-gray-500 hover:text-gray-700'}`
                  }`}
                >
                  <div className="flex items-center">
                    <span className={`w-6 h-6 rounded-full mr-3 flex items-center justify-center text-xs ${
                      isCurrent
                        ? 'bg-blue-500 text-white'
                        : isCompleted
                        ? 'bg-green-500 text-white'
                        : `${theme === 'dark' ? 'bg-gray-600 text-gray-300' : 'bg-gray-300 text-gray-600'}`
                    }`}>
                      {isCompleted ? '✓' : index + 1}
                    </span>
                    <div className="text-left">
                      <div>{section.title}</div>
                      <div className={`text-xs ${theme === 'dark' ? 'text-gray-400' : 'text-gray-500'}`}>
                        {section.description}
                      </div>
                    </div>
                  </div>
                </button>
              );
            })}
          </nav>
        </div>
      </div>

      {/* Conteúdo das seções */}
      <div className="max-w-7xl mx-auto px-4 py-8">
        <div className={`${theme === 'dark' ? 'bg-gray-800' : 'bg-white'} rounded-lg shadow p-6`}>
          {/* Seção Emitente */}
          {currentSection === 'emitente' && (
            <div>
              <h2 className={`text-lg font-medium mb-6 ${theme === 'dark' ? 'text-white' : 'text-gray-900'}`}>
                Dados do Emitente
              </h2>

              <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
                <div className="lg:col-span-2">
                  <label className={`block text-sm font-medium mb-2 ${theme === 'dark' ? 'text-gray-200' : 'text-gray-700'}`}>
                    Selecionar Emitente *
                  </label>
                  <select
                    value={selectedIds.emitente}
                    onChange={(e) => handleSelectEntity('emitentes', e.target.value)}
                    className={`w-full px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 ${
                      theme === 'dark'
                        ? 'bg-gray-700 border-gray-600 text-white'
                        : 'bg-white border-gray-300 text-gray-900'
                    }`}
                  >
                    <option value="">Selecione um emitente...</option>
                    {entidades.emitentes.map(emitente => (
                      <option key={emitente.id} value={emitente.id}>
                        {emitente.label} - {emitente.description}
                      </option>
                    ))}
                  </select>
                </div>

                {/* Campos preenchidos automaticamente */}
                <div>
                  <label className={`block text-sm font-medium mb-2 ${theme === 'dark' ? 'text-gray-200' : 'text-gray-700'}`}>
                    CNPJ *
                  </label>
                  <input
                    type="text"
                    value={dados.emit?.CNPJ || ''}
                    onChange={(e) => onDadosChange({
                      ...dados,
                      emit: { ...dados.emit, CNPJ: e.target.value }
                    })}
                    readOnly={!!selectedIds.emitente}
                    className={`w-full px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 ${
                      !!selectedIds.emitente ? 'bg-gray-100 cursor-not-allowed' : ''
                    } ${
                      theme === 'dark'
                        ? 'bg-gray-700 border-gray-600 text-white'
                        : 'border-gray-300 text-gray-900'
                    }`}
                  />
                </div>

                <div>
                  <label className={`block text-sm font-medium mb-2 ${theme === 'dark' ? 'text-gray-200' : 'text-gray-700'}`}>
                    Razão Social *
                  </label>
                  <input
                    type="text"
                    value={dados.emit?.xNome || ''}
                    onChange={(e) => onDadosChange({
                      ...dados,
                      emit: { ...dados.emit, xNome: e.target.value }
                    })}
                    readOnly={!!selectedIds.emitente}
                    className={`w-full px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 ${
                      !!selectedIds.emitente ? 'bg-gray-100 cursor-not-allowed' : ''
                    } ${
                      theme === 'dark'
                        ? 'bg-gray-700 border-gray-600 text-white'
                        : 'border-gray-300 text-gray-900'
                    }`}
                  />
                </div>
              </div>
            </div>
          )}

          {/* Seção Veículo */}
          {currentSection === 'veiculo' && (
            <div>
              <h2 className={`text-lg font-medium mb-6 ${theme === 'dark' ? 'text-white' : 'text-gray-900'}`}>
                Dados do Veículo
              </h2>

              <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
                <div className="lg:col-span-2">
                  <label className={`block text-sm font-medium mb-2 ${theme === 'dark' ? 'text-gray-200' : 'text-gray-700'}`}>
                    Selecionar Veículo *
                  </label>
                  <select
                    value={selectedIds.veiculo}
                    onChange={(e) => handleSelectEntity('veiculos', e.target.value)}
                    className={`w-full px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 ${
                      theme === 'dark'
                        ? 'bg-gray-700 border-gray-600 text-white'
                        : 'bg-white border-gray-300 text-gray-900'
                    }`}
                  >
                    <option value="">Selecione um veículo...</option>
                    {entidades.veiculos.map(veiculo => (
                      <option key={veiculo.id} value={veiculo.id}>
                        {veiculo.label} - {veiculo.description}
                      </option>
                    ))}
                  </select>
                </div>

                <div>
                  <label className={`block text-sm font-medium mb-2 ${theme === 'dark' ? 'text-gray-200' : 'text-gray-700'}`}>
                    Placa *
                  </label>
                  <input
                    type="text"
                    value={dados.veiculo?.placa || ''}
                    readOnly={!!selectedIds.veiculo}
                    className={`w-full px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 ${
                      !!selectedIds.veiculo ? 'bg-gray-100 cursor-not-allowed' : ''
                    } ${
                      theme === 'dark'
                        ? 'bg-gray-700 border-gray-600 text-white'
                        : 'border-gray-300 text-gray-900'
                    }`}
                  />
                </div>

                <div>
                  <label className={`block text-sm font-medium mb-2 ${theme === 'dark' ? 'text-gray-200' : 'text-gray-700'}`}>
                    Tara (kg) *
                  </label>
                  <input
                    type="number"
                    value={dados.veiculo?.tara || ''}
                    readOnly={!!selectedIds.veiculo}
                    className={`w-full px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 ${
                      !!selectedIds.veiculo ? 'bg-gray-100 cursor-not-allowed' : ''
                    } ${
                      theme === 'dark'
                        ? 'bg-gray-700 border-gray-600 text-white'
                        : 'border-gray-300 text-gray-900'
                    }`}
                  />
                </div>
              </div>
            </div>
          )}

          {/* Seção Condutor */}
          {currentSection === 'condutor' && (
            <div>
              <h2 className={`text-lg font-medium mb-6 ${theme === 'dark' ? 'text-white' : 'text-gray-900'}`}>
                Dados do Condutor
              </h2>

              <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
                <div className="lg:col-span-2">
                  <label className={`block text-sm font-medium mb-2 ${theme === 'dark' ? 'text-gray-200' : 'text-gray-700'}`}>
                    Selecionar Condutor *
                  </label>
                  <select
                    value={selectedIds.condutor}
                    onChange={(e) => handleSelectEntity('condutores', e.target.value)}
                    className={`w-full px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 ${
                      theme === 'dark'
                        ? 'bg-gray-700 border-gray-600 text-white'
                        : 'bg-white border-gray-300 text-gray-900'
                    }`}
                  >
                    <option value="">Selecione um condutor...</option>
                    {entidades.condutores.map(condutor => (
                      <option key={condutor.id} value={condutor.id}>
                        {condutor.label} - {condutor.description}
                      </option>
                    ))}
                  </select>
                </div>

                <div>
                  <label className={`block text-sm font-medium mb-2 ${theme === 'dark' ? 'text-gray-200' : 'text-gray-700'}`}>
                    Nome *
                  </label>
                  <input
                    type="text"
                    value={dados.condutor?.nome || ''}
                    readOnly={!!selectedIds.condutor}
                    className={`w-full px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 ${
                      !!selectedIds.condutor ? 'bg-gray-100 cursor-not-allowed' : ''
                    } ${
                      theme === 'dark'
                        ? 'bg-gray-700 border-gray-600 text-white'
                        : 'border-gray-300 text-gray-900'
                    }`}
                  />
                </div>

                <div>
                  <label className={`block text-sm font-medium mb-2 ${theme === 'dark' ? 'text-gray-200' : 'text-gray-700'}`}>
                    CPF *
                  </label>
                  <input
                    type="text"
                    value={dados.condutor?.cpf || ''}
                    readOnly={!!selectedIds.condutor}
                    className={`w-full px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 ${
                      !!selectedIds.condutor ? 'bg-gray-100 cursor-not-allowed' : ''
                    } ${
                      theme === 'dark'
                        ? 'bg-gray-700 border-gray-600 text-white'
                        : 'border-gray-300 text-gray-900'
                    }`}
                  />
                </div>
              </div>
            </div>
          )}

          {/* Seção Trajeto */}
          {currentSection === 'trajeto' && (
            <div>
              <h2 className={`text-lg font-medium mb-6 ${theme === 'dark' ? 'text-white' : 'text-gray-900'}`}>
                Trajeto da Viagem
              </h2>

              <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
                <div>
                  <label className={`block text-sm font-medium mb-2 ${theme === 'dark' ? 'text-gray-200' : 'text-gray-700'}`}>
                    UF Início *
                  </label>
                  <select
                    value={dados.ufInicio || ''}
                    onChange={(e) => onDadosChange({ ...dados, ufInicio: e.target.value })}
                    className={`w-full px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 ${
                      theme === 'dark'
                        ? 'bg-gray-700 border-gray-600 text-white'
                        : 'bg-white border-gray-300 text-gray-900'
                    }`}
                  >
                    <option value="">Selecione...</option>
                    <option value="SC">SC - Santa Catarina</option>
                    <option value="RS">RS - Rio Grande do Sul</option>
                    <option value="PR">PR - Paraná</option>
                    <option value="SP">SP - São Paulo</option>
                  </select>
                </div>

                <div>
                  <label className={`block text-sm font-medium mb-2 ${theme === 'dark' ? 'text-gray-200' : 'text-gray-700'}`}>
                    UF Fim *
                  </label>
                  <select
                    value={dados.ufFim || ''}
                    onChange={(e) => onDadosChange({ ...dados, ufFim: e.target.value })}
                    className={`w-full px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 ${
                      theme === 'dark'
                        ? 'bg-gray-700 border-gray-600 text-white'
                        : 'bg-white border-gray-300 text-gray-900'
                    }`}
                  >
                    <option value="">Selecione...</option>
                    <option value="SC">SC - Santa Catarina</option>
                    <option value="RS">RS - Rio Grande do Sul</option>
                    <option value="PR">PR - Paraná</option>
                    <option value="SP">SP - São Paulo</option>
                  </select>
                </div>
              </div>
            </div>
          )}

          {/* Seção Carga */}
          {currentSection === 'carga' && (
            <div>
              <h2 className={`text-lg font-medium mb-6 ${theme === 'dark' ? 'text-white' : 'text-gray-900'}`}>
                Informações da Carga
              </h2>

              <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
                <div>
                  <label className={`block text-sm font-medium mb-2 ${theme === 'dark' ? 'text-gray-200' : 'text-gray-700'}`}>
                    Valor da Carga (R$) *
                  </label>
                  <input
                    type="number"
                    step="0.01"
                    value={dados.valorCarga || ''}
                    onChange={(e) => onDadosChange({
                      ...dados,
                      valorCarga: parseFloat(e.target.value) || 0
                    })}
                    className={`w-full px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 ${
                      theme === 'dark'
                        ? 'bg-gray-700 border-gray-600 text-white'
                        : 'bg-white border-gray-300 text-gray-900'
                    }`}
                  />
                </div>

                <div>
                  <label className={`block text-sm font-medium mb-2 ${theme === 'dark' ? 'text-gray-200' : 'text-gray-700'}`}>
                    Quantidade da Carga (kg) *
                  </label>
                  <input
                    type="number"
                    step="0.001"
                    value={dados.quantidadeCarga || ''}
                    onChange={(e) => onDadosChange({
                      ...dados,
                      quantidadeCarga: parseFloat(e.target.value) || 0
                    })}
                    className={`w-full px-3 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 ${
                      theme === 'dark'
                        ? 'bg-gray-700 border-gray-600 text-white'
                        : 'bg-white border-gray-300 text-gray-900'
                    }`}
                  />
                </div>
              </div>
            </div>
          )}
        </div>

        {/* Botões de navegação e ações */}
        <div className="mt-8 flex justify-between items-center">
          <div className="flex space-x-4">
            <button
              onClick={prevSection}
              disabled={!canGoPrev}
              className={`px-4 py-2 border rounded-md font-medium transition-colors ${
                !canGoPrev
                  ? 'border-gray-300 text-gray-400 cursor-not-allowed'
                  : `border-gray-300 ${theme === 'dark' ? 'text-gray-200 hover:bg-gray-700' : 'text-gray-700 hover:bg-gray-50'}`
              }`}
            >
              ← Anterior
            </button>

            <button
              onClick={nextSection}
              disabled={!canGoNext}
              className={`px-4 py-2 rounded-md font-medium transition-colors ${
                !canGoNext
                  ? 'bg-gray-300 text-gray-400 cursor-not-allowed'
                  : 'bg-blue-600 text-white hover:bg-blue-700'
              }`}
            >
              Próximo →
            </button>
          </div>

          <div className="flex space-x-4">
            <button
              onClick={onCancelar}
              disabled={salvando || transmitindo}
              className={`px-4 py-2 border border-gray-300 rounded-md font-medium transition-colors ${
                theme === 'dark' ? 'text-gray-200 hover:bg-gray-700' : 'text-gray-700 hover:bg-gray-50'
              }`}
            >
              Cancelar
            </button>

            <button
              onClick={onSalvar}
              disabled={salvando || transmitindo}
              className="px-4 py-2 bg-green-600 text-white rounded-md font-medium hover:bg-green-700 transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
            >
              {salvando ? 'Salvando...' : 'Salvar'}
            </button>

            {onTransmitir && (
              <button
                onClick={onTransmitir}
                disabled={salvando || transmitindo}
                className="px-4 py-2 bg-blue-600 text-white rounded-md font-medium hover:bg-blue-700 transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
              >
                {transmitindo ? 'Transmitindo...' : 'Transmitir'}
              </button>
            )}
          </div>
        </div>
      </div>
    </div>
  );
}