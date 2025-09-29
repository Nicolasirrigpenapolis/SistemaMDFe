import React, { useState, useEffect } from 'react';
import { MDFeData } from '../../../types/mdfe';
import { useMDFeForm } from '../../../hooks/useMDFeForm';
import Icon from '../Icon';
import { OptionalFieldsToggle, OptionalSection } from '../Common/OptionalFieldsToggle';
import { Combobox } from '../Common/Combobox';
import { LocalCarregamento } from '../../../services/localidadeService';
import { LocalidadeSelector } from './LocalidadeSelector';
import { reboquesService, ReboqueList } from '../../../services/reboquesService';

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
  entidadesCarregadas?: any;
}

interface WizardSection {
  id: string;
  title: string;
  description: string;
  required: boolean;
  completed: boolean;
}

export function MDFeForm({
  dados,
  onDadosChange,
  onSalvar,
  onCancelar,
  onTransmitir,
  salvando,
  transmitindo = false,
  isEdicao,
  carregandoDados = false,
  entidadesCarregadas
}: MDFeFormProps) {
  const [currentSection, setCurrentSection] = useState('emitente');
  const [showOptionalContratacao, setShowOptionalContratacao] = useState(false);
  const [showOptionalSeguro, setShowOptionalSeguro] = useState(false);


  // Estados para localidades com LocalidadeSelector
  const [locaisCarregamento, setLocaisCarregamento] = useState<LocalCarregamento[]>([]);
  const [locaisDescarregamento, setLocaisDescarregamento] = useState<LocalCarregamento[]>([]);

  // Estados para reboques
  const [reboquesDisponiveis, setReboquesDisponiveis] = useState<ReboqueList[]>([]);
  const [reboquesSelecionados, setReboquesSelecionados] = useState<number[]>([]);
  const [carregandoReboques, setCarregandoReboques] = useState(false);
  const [rotaSelecionada, setRotaSelecionada] = useState<string[]>([]);

  const {
    dados: dadosHook,
    selectedIds,
    updateField,
    selectEntity,
    setFormData,
    resetForm
  } = useMDFeForm();

  useEffect(() => {
    if (dadosHook && Object.keys(dadosHook).length > 0) {
      onDadosChange({ ...dados, ...dadosHook });

      // Também tentar carregar localidades do dadosHook quando disponível
      if (isEdicao && dadosHook) {

        // Verificar carregamento no dadosHook (usando novo formato)
        if (dadosHook.localidadesCarregamento && dadosHook.localidadesCarregamento.length > 0) {
          const locaisCarregamentoHook = dadosHook.localidadesCarregamento.map((mun, index) => ({
            id: `carregamento-hook-${index}`,
            uf: mun.uf || '',
            municipio: mun.municipio || '',
            codigoIBGE: mun.codigoIBGE || 0
          }));
          setLocaisCarregamento(locaisCarregamentoHook);
        }

        // Verificar descarregamento no dadosHook (usando novo formato)
        if (dadosHook.localidadesDescarregamento && dadosHook.localidadesDescarregamento.length > 0) {
          const locaisDescarregamentoHook = dadosHook.localidadesDescarregamento.map((mun, index) => ({
            id: `descarregamento-hook-${index}`,
            uf: mun.uf || '',
            municipio: mun.municipio || '',
            codigoIBGE: mun.codigoIBGE || 0
          }));
          setLocaisDescarregamento(locaisDescarregamentoHook);
        }
      }
    }
  }, [dadosHook, isEdicao]);

  // Funções para gerenciar localidades
  const handleLocaisCarregamentoChange = (locais: LocalCarregamento[]) => {
    setLocaisCarregamento(locais);
    // Atualizar dados gerais do MDFe
    if (locais.length > 0) {
      const primeiroLocal = locais[0];
      onDadosChange({
        ...dados,
        ufIni: primeiroLocal.uf,
        municipioIni: primeiroLocal.municipio
      });
    }
  };

  const handleLocaisDescarregamentoChange = (locais: LocalCarregamento[]) => {
    setLocaisDescarregamento(locais);
    // Atualizar dados gerais do MDFe
    if (locais.length > 0) {
      const primeiroLocal = locais[0];
      onDadosChange({
        ...dados,
        ufFim: primeiroLocal.uf,
        municipioFim: primeiroLocal.municipio
      });
    }
  };

  const handleRotaChange = (rota: string[]) => {
    setRotaSelecionada(rota);
    // Atualizar dados do MDFe com a rota selecionada
    onDadosChange({
      ...dados,
      rotaPercurso: rota
    });
  };

  // Gerenciar reboques selecionados
  const handleReboqueToggle = (reboqueId: number) => {
    const novosReboques = reboquesSelecionados.includes(reboqueId)
      ? reboquesSelecionados.filter(id => id !== reboqueId)
      : [...reboquesSelecionados, reboqueId];

    setReboquesSelecionados(novosReboques);
    onDadosChange({
      ...dados,
      reboquesIds: novosReboques
    });
  };

  const adicionarTodosReboques = () => {
    const todosIds = reboquesDisponiveis.map(reboque => reboque.id);
    setReboquesSelecionados(todosIds);
    onDadosChange({
      ...dados,
      reboquesIds: todosIds
    });
  };

  const removerTodosReboques = () => {
    setReboquesSelecionados([]);
    onDadosChange({
      ...dados,
      reboquesIds: []
    });
  };

  // Carregar reboques disponíveis
  useEffect(() => {
    const carregarReboques = async () => {
      setCarregandoReboques(true);
      try {
        const response = await reboquesService.listarReboquesAtivos();
        if (response.sucesso && response.data) {
          setReboquesDisponiveis(response.data);
        }
      } catch (error) {
        console.error('Erro ao carregar reboques:', error);
      } finally {
        setCarregandoReboques(false);
      }
    };

    carregarReboques();
  }, []);

  const sections: WizardSection[] = [
    {
      id: 'emitente',
      title: 'Emitente',
      description: 'Empresa emissora',
      required: true,
      completed: !!selectedIds.emitenteId && !!dados.emitenteId
    },
    {
      id: 'transporte',
      title: 'Transporte',
      description: 'Veículo e condutor',
      required: true,
      completed: !!selectedIds.veiculoId && !!selectedIds.condutorId
    },
    {
      id: 'localidades',
      title: 'Localidades',
      description: 'Carregamento e descarregamento',
      required: true,
      completed: locaisCarregamento.length > 0 && locaisDescarregamento.length > 0
    },
    {
      id: 'contratacao',
      title: 'Contratação',
      description: 'Contratante e seguradora',
      required: true,
      completed: (selectedIds.contratanteId !== undefined && selectedIds.contratanteId !== '') || (selectedIds.seguradoraId !== undefined && selectedIds.seguradoraId !== '')
    },
    {
      id: 'carga',
      title: 'Carga',
      description: 'Informações da carga',
      required: true,
      completed: !!(dados.valorTotal && dados.pesoBrutoTotal)
    },
    {
      id: 'documentos',
      title: 'Documentos Fiscais',
      description: 'CTe/NFe vinculados',
      required: true,
      completed: !!((dados.documentosCTe && dados.documentosCTe.length > 0) || (dados.documentosNFe && dados.documentosNFe.length > 0))
    },
    {
      id: 'resumo',
      title: 'Resumo',
      description: 'Revisão final',
      required: true,
      completed: false
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



  // Sincronizar localidades com dados do MDFe quando há mudanças nas localidades
  React.useEffect(() => {
    // Não atualizar se estamos carregando dados (para evitar loop)
    // Remover loading check

    // Sincronizar dados apenas se há localidades definidas
    if (locaisCarregamento.length > 0 || locaisDescarregamento.length > 0) {
      // Atualizar infMunCarrega
      const infMunCarrega = locaisCarregamento.map(local => ({
        cMunCarrega: local.codigoIBGE.toString(),
        xMunCarrega: local.municipio,
        uf: local.uf
      }));

      // Atualizar infMunDescarga
      const infMunDescarga = locaisDescarregamento.map(local => ({
        cMunDescarga: local.codigoIBGE.toString(),
        xMunDescarga: local.municipio,
        uf: local.uf
      }));

      // Atualizar os dados com as localidades e rota (usando novo formato)
      const dadosAtualizados = {
        ...dados,
        localidadesCarregamento: infMunCarrega.map(local => ({
          uf: local.uf || '',
          municipio: local.xMunCarrega || '',
          codigoIBGE: parseInt(local.cMunCarrega || '0')
        })),
        localidadesDescarregamento: infMunDescarga.map(local => ({
          uf: local.uf || '',
          municipio: local.xMunDescarga || '',
          codigoIBGE: parseInt(local.cMunDescarga || '0')
        })),
        rotaPercurso: rotaSelecionada
      };

      onDadosChange(dadosAtualizados);
    }
  }, [locaisCarregamento, locaisDescarregamento, rotaSelecionada]);


  if (carregandoDados) {
    return (
      <div className="flex items-center justify-center min-h-64 bg-white dark:bg-gray-800 rounded-lg border border-gray-300 dark:border-gray-600">
        <div className="flex flex-col items-center space-y-4">
          <Icon name="spinner" className="w-8 h-8 text-primary animate-spin" />
          <p className="text-text-secondary text-lg">Carregando dados do formulário...</p>
        </div>
      </div>
    );
  }

  if (false) { // TODO: implementar estado de erro
    return (
      <div className="flex items-center justify-center min-h-64 bg-danger-light border border-danger rounded-lg">
        <div className="flex items-center space-x-4">
          <Icon name="exclamation-triangle" className="w-8 h-8 text-danger" />
          <div className="text-left">
            <h3 className="text-lg font-semibold text-danger">Erro</h3>
            <div className="text-danger">Erro desconhecido</div>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gray-50 dark:bg-gray-900">
      {/* Header modernizado */}
      <div className="bg-gradient-to-r from-blue-50 to-indigo-50 dark:from-gray-800 dark:to-gray-900 border-b border-gray-200 dark:border-gray-700 shadow-lg">
        <div className="max-w-full mx-auto px-4 py-8">
          <div className="flex items-center justify-between">
            <div className="flex items-center space-x-6">
              <div className="w-16 h-16 bg-gradient-to-br from-blue-500 to-indigo-600 dark:from-blue-600 dark:to-indigo-700 rounded-xl flex items-center justify-center shadow-lg">
                <i className="fas fa-file-invoice text-white text-2xl"></i>
              </div>
              <div>
                <h1 className="text-3xl font-bold text-gray-900 dark:text-white mb-2">
                  {isEdicao ? 'Editar MDFe' : 'Novo MDFe'}
                </h1>
                <p className="text-gray-600 dark:text-gray-300 text-lg">
                  {isEdicao ? 'Edite os dados do manifesto eletrônico' : 'Preencha os dados para criar um novo manifesto eletrônico'}
                </p>
              </div>
            </div>

            <div className="flex flex-wrap gap-3">

            </div>
          </div>
        </div>
      </div>

      {/* Navegação modernizada */}
      <div className="bg-white dark:bg-gray-800 border-b border-gray-200 dark:border-gray-700 shadow-sm">
        <div className="max-w-full mx-auto px-4">
          <nav className="flex space-x-2 overflow-x-auto py-2">
            {sections.map((section, index) => {
              const isCurrent = section.id === currentSection;
              const isCompleted = section.completed;

              return (
                <button
                  key={section.id}
                  onClick={() => setCurrentSection(section.id)}
                  className={`flex-shrink-0 px-6 py-4 rounded-lg font-medium text-sm transition-all duration-300 transform hover:scale-105 ${
                    isCurrent
                      ? 'bg-gradient-to-r from-blue-500 to-indigo-600 text-white shadow-lg'
                      : isCompleted
                      ? 'bg-gradient-to-r from-green-500 to-emerald-600 text-white shadow-md'
                      : 'bg-gray-100 dark:bg-gray-700 text-gray-600 dark:text-gray-300'
                  }`}
                >
                  <div className="flex items-center space-x-3">
                    <span className="w-8 h-8 rounded-full flex items-center justify-center text-xs font-bold bg-white/20">
                      {isCompleted ? <i className="fas fa-check"></i> : index + 1}
                    </span>
                    <div className="text-left">
                      <div className="font-semibold">{section.title}</div>
                      <div className="text-xs mt-1 opacity-80">{section.description}</div>
                    </div>
                  </div>
                </button>
              );
            })}
          </nav>
        </div>
      </div>

      {/* Conteúdo */}
      <div className="max-w-full mx-auto px-4 py-8">
        <div className="bg-white dark:bg-gray-800 rounded-2xl shadow-xl border border-gray-200 dark:border-gray-700 p-8">

          {/* Seção Emitente */}
          {currentSection === 'emitente' && (
            <div>
              <div className="flex items-center mb-8">
                <div className="w-12 h-12 bg-gradient-to-br from-blue-500 to-indigo-600 rounded-xl flex items-center justify-center mr-4 shadow-lg">
                  <i className="fas fa-building text-white text-lg"></i>
                </div>
                <div>
                  <h2 className="text-2xl font-bold text-gray-900 dark:text-white">Dados do Emitente</h2>
                  <p className="text-gray-600 dark:text-gray-400 mt-1">Selecione a empresa que emitirá o MDFe</p>
                </div>
              </div>

              <div className="space-y-6">
                <div>
                  <Combobox
                    label="Selecionar Emitente"
                    options={entidadesCarregadas?.emitentes?.map((emitente: any) => ({
                      id: emitente.id,
                      label: emitente.label,
                      sublabel: emitente.description,
                      icon: "fas fa-building"
                    }))}
                    selectedValue={selectedIds.emitenteId}
                    onSelect={(value) => selectEntity('emitenteId', value.toString())}
                    placeholder="Selecione um emitente..."
                    searchPlaceholder="Buscar emitente..."
                    required={true}
                  />
                </div>

              </div>
            </div>
          )}

          {/* Seção Transporte */}
          {currentSection === 'transporte' && (
            <div>
              <div className="flex items-center mb-8">
                <div className="w-12 h-12 bg-gradient-to-br from-orange-500 to-red-600 rounded-xl flex items-center justify-center mr-4 shadow-lg">
                  <i className="fas fa-truck text-white text-lg"></i>
                </div>
                <div>
                  <h2 className="text-2xl font-bold text-gray-900 dark:text-white">Dados do Transporte</h2>
                  <p className="text-gray-600 dark:text-gray-400 mt-1">Selecione o veículo e condutor para o transporte</p>
                </div>
              </div>

              <div className="space-y-6">
                {/* Seleção de Veículo */}
                <div className="bg-gradient-to-r from-orange-50 to-red-50 dark:from-orange-900/20 dark:to-red-900/20 p-6 rounded-xl border border-orange-200 dark:border-orange-700">
                  <h3 className="text-lg font-semibold text-gray-900 dark:text-white mb-4 flex items-center">
                    <i className="fas fa-truck text-orange-500 mr-2"></i>
                    Veículo
                  </h3>
                  <div className="space-y-4">
                    <div>
                      <Combobox
                        label="Selecionar Veículo"
                        options={entidadesCarregadas?.veiculos?.map((veiculo: any) => ({
                          id: veiculo.id,
                          label: veiculo.label,
                          sublabel: veiculo.description,
                          icon: "fas fa-truck"
                        }))}
                        selectedValue={selectedIds.veiculoId}
                        onSelect={(value) => selectEntity('veiculoId', value.toString())}
                        placeholder="Selecione um veículo..."
                        searchPlaceholder="Buscar veículo..."
                        required={true}
                      />
                    </div>

                  </div>
                </div>

                {/* Seleção de Condutor */}
                <div className="bg-gradient-to-r from-blue-50 to-indigo-50 dark:from-blue-900/20 dark:to-indigo-900/20 p-6 rounded-xl border border-blue-200 dark:border-blue-700">
                  <h3 className="text-lg font-semibold text-gray-900 dark:text-white mb-4 flex items-center">
                    <i className="fas fa-user text-blue-500 mr-2"></i>
                    Condutor
                  </h3>
                  <div className="space-y-4">
                    <div>
                      <Combobox
                        label="Selecionar Condutor"
                        options={entidadesCarregadas?.condutores?.map((condutor: any) => ({
                          id: condutor.id,
                          label: condutor.label,
                          sublabel: condutor.description,
                          icon: "fas fa-id-card"
                        }))}
                        selectedValue={selectedIds.condutorId}
                        onSelect={(value) => selectEntity('condutorId', value.toString())}
                        placeholder="Selecione um condutor..."
                        searchPlaceholder="Buscar condutor..."
                        required={true}
                      />
                    </div>

                    {/* Seção Reboques - Opcional */}
                    <OptionalFieldsToggle
                      label="Reboques (Opcional)"
                      isExpanded={false}
                      onToggle={() => {
                        // Estado será controlado pelo próprio toggle
                      }}
                    />
                    <OptionalSection isVisible={true}>
                        <div className="space-y-4">
                          <div className="flex items-center justify-between">
                            <h4 className="text-sm font-medium text-gray-700 dark:text-gray-300 flex items-center gap-2">
                              <i className="fas fa-trailer text-blue-600"></i>
                              Seleção de Reboques
                            </h4>
                            <div className="flex gap-2">
                              <button
                                type="button"
                                onClick={adicionarTodosReboques}
                                className="text-xs px-3 py-1 bg-blue-100 text-blue-700 rounded hover:bg-blue-200 transition-colors"
                                disabled={carregandoReboques || reboquesDisponiveis.length === 0}
                              >
                                Selecionar Todos
                              </button>
                              <button
                                type="button"
                                onClick={removerTodosReboques}
                                className="text-xs px-3 py-1 bg-gray-100 text-gray-700 rounded hover:bg-gray-200 transition-colors"
                                disabled={reboquesSelecionados.length === 0}
                              >
                                Limpar
                              </button>
                            </div>
                          </div>

                          {carregandoReboques ? (
                            <div className="flex items-center gap-2 text-sm text-gray-500">
                              <i className="fas fa-spinner fa-spin"></i>
                              Carregando reboques...
                            </div>
                          ) : reboquesDisponiveis.length === 0 ? (
                            <div className="text-sm text-gray-500 text-center py-4">
                              <i className="fas fa-exclamation-triangle text-yellow-500 mr-2"></i>
                              Nenhum reboque ativo encontrado.
                              <a href="/reboques" className="text-blue-600 hover:underline ml-1">
                                Cadastre reboques aqui
                              </a>
                            </div>
                          ) : (
                            <div className="grid grid-cols-1 md:grid-cols-2 gap-3 max-h-64 overflow-y-auto">
                              {reboquesDisponiveis.map((reboque) => (
                                <div
                                  key={reboque.id}
                                  className={`p-3 border rounded-lg cursor-pointer transition-all hover:shadow-md ${
                                    reboquesSelecionados.includes(reboque.id)
                                      ? 'border-blue-500 bg-blue-50 dark:bg-blue-900/20'
                                      : 'border-gray-300 hover:border-gray-400'
                                  }`}
                                  onClick={() => handleReboqueToggle(reboque.id)}
                                >
                                  <div className="flex items-center justify-between">
                                    <div className="flex items-center gap-2">
                                      <input
                                        type="checkbox"
                                        checked={reboquesSelecionados.includes(reboque.id)}
                                        onChange={() => handleReboqueToggle(reboque.id)}
                                        className="w-4 h-4 text-blue-600 rounded"
                                      />
                                      <div>
                                        <div className="font-medium text-sm">
                                          {reboquesService.formatarPlaca(reboque.placa)}
                                        </div>
                                        <div className="text-xs text-gray-500">
                                          {reboque.tipoCarroceria} • {reboque.uf}
                                        </div>
                                      </div>
                                    </div>
                                    <div className="text-right">
                                      <div className="text-xs text-gray-600">
                                        {reboquesService.formatarTara(reboque.tara)}
                                      </div>
                                      <div className="text-xs text-gray-500">
                                        {reboque.tipoRodado}
                                      </div>
                                    </div>
                                  </div>
                                </div>
                              ))}
                            </div>
                          )}

                          {reboquesSelecionados.length > 0 && (
                            <div className="bg-green-50 dark:bg-green-900/20 p-3 rounded-lg">
                              <div className="text-sm text-green-800 dark:text-green-300">
                                <i className="fas fa-check text-green-600 mr-2"></i>
                                {reboquesSelecionados.length} reboque(s) selecionado(s)
                              </div>
                              <div className="text-xs text-green-700 dark:text-green-400 mt-1">
                                {reboquesDisponiveis
                                  .filter(r => reboquesSelecionados.includes(r.id))
                                  .map(r => reboquesService.formatarPlaca(r.placa))
                                  .join(', ')}
                              </div>
                            </div>
                          )}
                        </div>
                    </OptionalSection>

                  </div>
                </div>
              </div>
            </div>
          )}

          {/* Seção Localidades (Carregamento + Descarregamento) */}
          {currentSection === 'localidades' && (
            <div>
              <div className="flex items-center mb-8">
                <div className="w-12 h-12 bg-gradient-to-br from-blue-500 to-indigo-600 rounded-xl flex items-center justify-center mr-4 shadow-lg">
                  <i className="fas fa-map-marker-alt text-white text-lg"></i>
                </div>
                <div>
                  <h2 className="text-2xl font-bold text-gray-900 dark:text-white">Localidades de Carregamento e Descarregamento</h2>
                  <p className="text-gray-600 dark:text-gray-400 mt-1">Informe os locais de carregamento e descarregamento da carga</p>
                </div>
              </div>

              <div className="space-y-8">
                {/* Locais de Carregamento */}
                <LocalidadeSelector
                  locais={locaisCarregamento}
                  onChange={handleLocaisCarregamentoChange}
                  title="Locais de Carregamento"
                  tipo="carregamento"
                />

                {/* Locais de Descarregamento */}
                <LocalidadeSelector
                  locais={locaisDescarregamento}
                  onChange={handleLocaisDescarregamentoChange}
                  title="Locais de Descarregamento"
                  tipo="descarregamento"
                  onRotaChange={handleRotaChange}
                  locaisOrigem={locaisCarregamento}
                />

                {/* Exibir rota selecionada se houver */}
                {rotaSelecionada.length > 0 && (
                  <div className="bg-gradient-to-r from-emerald-50 to-green-50 dark:from-emerald-900/20 dark:to-green-900/20 p-6 rounded-xl border border-emerald-200 dark:border-emerald-700">
                    <h3 className="text-lg font-semibold text-gray-900 dark:text-white mb-4 flex items-center">
                      <i className="fas fa-route text-emerald-500 mr-2"></i>
                      Rota de Percurso Selecionada
                    </h3>
                    <div className="flex flex-wrap items-center gap-2">
                      {rotaSelecionada.map((uf, index) => (
                        <React.Fragment key={index}>
                          <span className="px-3 py-2 bg-emerald-100 dark:bg-emerald-800 text-emerald-700 dark:text-emerald-300 rounded-lg text-sm font-bold">
                            {uf}
                          </span>
                          {index < rotaSelecionada.length - 1 && (
                            <i className="fas fa-arrow-right text-gray-400 text-sm"></i>
                          )}
                        </React.Fragment>
                      ))}
                    </div>
                  </div>
                )}
              </div>
            </div>
          )}


          {/* Seção Contratação */}
          {currentSection === 'contratacao' && (
            <div>
              <div className="flex items-center mb-8">
                <div className="w-12 h-12 bg-gradient-to-br from-purple-500 to-pink-600 rounded-xl flex items-center justify-center mr-4 shadow-lg">
                  <i className="fas fa-handshake text-white text-lg"></i>
                </div>
                <div>
                  <h2 className="text-2xl font-bold text-gray-900 dark:text-white">Dados de Contratação</h2>
                  <p className="text-gray-600 dark:text-gray-400 mt-1">Informações do contratante e seguradora</p>
                </div>
              </div>

              <div className="space-y-6">
                {/* Toggle Contratante */}
                <OptionalFieldsToggle
                  label="Informações do Contratante"
                  description="Dados da empresa contratante do transporte"
                  isExpanded={showOptionalContratacao}
                  onToggle={() => setShowOptionalContratacao(!showOptionalContratacao)}
                  icon="fas fa-building"
                />

                <OptionalSection isVisible={showOptionalContratacao}>
                  <div className="bg-gradient-to-r from-purple-50 to-pink-50 dark:from-purple-900/20 dark:to-pink-900/20 p-6 rounded-xl border border-purple-200 dark:border-purple-700">
                    <h3 className="text-lg font-semibold text-gray-900 dark:text-white mb-4 flex items-center">
                      <i className="fas fa-building text-purple-500 mr-2"></i>
                      Contratante
                    </h3>
                    <div className="space-y-4">
                      <div>
                        <label className="block text-sm font-semibold text-gray-900 dark:text-white mb-2">
                          Selecionar Contratante
                        </label>
                        <select
                          value={selectedIds.contratanteId || ''}
                          onChange={(e) => selectEntity('contratanteId', e.target.value)}
                          className="w-full px-4 py-3 border-2 border-gray-300 dark:border-gray-600 rounded-xl bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-purple-500"
                        >
                          <option value="">Selecione um contratante...</option>
                          {entidadesCarregadas?.contratantes?.map((contratante: any) => (
                            <option key={contratante.id} value={contratante.id}>
                              {contratante.label} - {contratante.description}
                            </option>
                          ))}
                        </select>
                      </div>

                      {/* Dados do contratante preenchidos automaticamente */}
                      {false && (
                        <div className="bg-white dark:bg-gray-800 border border-purple-200 dark:border-purple-700 rounded-lg p-4">
                          <h4 className="text-sm font-semibold text-gray-900 dark:text-white mb-3 flex items-center">
                            <i className="fas fa-info-circle text-purple-500 mr-2"></i>
                            Dados do Contratante
                          </h4>
                          <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
                            <div>
                              <label className="block text-xs font-medium text-gray-600 dark:text-gray-400 mb-1">CNPJ/CPF</label>
                              <input
                                type="text"
                                value={'Dados removidos - agora via ID'}
                                readOnly
                                className="w-full px-2 py-1 border border-gray-300 dark:border-gray-600 rounded bg-gray-50 dark:bg-gray-700 text-gray-900 dark:text-white text-sm"
                              />
                            </div>
                            <div>
                              <label className="block text-xs font-medium text-gray-600 dark:text-gray-400 mb-1">Razão Social</label>
                              <input
                                type="text"
                                value={"Dados via ID"}
                                readOnly
                                className="w-full px-2 py-1 border border-gray-300 dark:border-gray-600 rounded bg-gray-50 dark:bg-gray-700 text-gray-900 dark:text-white text-sm"
                              />
                            </div>
                          </div>
                        </div>
                      )}
                    </div>
                  </div>
                </OptionalSection>

                {/* Toggle Seguradora */}
                <OptionalFieldsToggle
                  label="Informações da Seguradora"
                  description="Dados da seguradora responsável pela carga"
                  isExpanded={showOptionalSeguro}
                  onToggle={() => setShowOptionalSeguro(!showOptionalSeguro)}
                  icon="fas fa-shield-alt"
                />

                <OptionalSection isVisible={showOptionalSeguro}>
                  <div className="bg-gradient-to-r from-blue-50 to-cyan-50 dark:from-blue-900/20 dark:to-cyan-900/20 p-6 rounded-xl border border-blue-200 dark:border-blue-700">
                    <h3 className="text-lg font-semibold text-gray-900 dark:text-white mb-4 flex items-center">
                      <i className="fas fa-shield-alt text-blue-500 mr-2"></i>
                      Seguradora
                    </h3>
                    <div className="space-y-4">
                      <div>
                        <label className="block text-sm font-semibold text-gray-900 dark:text-white mb-2">
                          Selecionar Seguradora
                        </label>
                        <select
                          value={selectedIds.seguradoraId || ''}
                          onChange={(e) => selectEntity('seguradoraId', e.target.value)}
                          className="w-full px-4 py-3 border-2 border-gray-300 dark:border-gray-600 rounded-xl bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                        >
                          <option value="">Selecione uma seguradora...</option>
                          {entidadesCarregadas?.seguradoras?.map((seguradora: any) => (
                            <option key={seguradora.id} value={seguradora.id}>
                              {seguradora.label} - {seguradora.description}
                            </option>
                          ))}
                        </select>
                      </div>

                      {/* Dados da seguradora preenchidos automaticamente */}
                      {false && (
                        <div className="bg-white dark:bg-gray-800 border border-blue-200 dark:border-blue-700 rounded-lg p-4">
                          <h4 className="text-sm font-semibold text-gray-900 dark:text-white mb-3 flex items-center">
                            <i className="fas fa-info-circle text-blue-500 mr-2"></i>
                            Dados da Seguradora
                          </h4>
                          <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
                            <div>
                              <label className="block text-xs font-medium text-gray-600 dark:text-gray-400 mb-1">CNPJ</label>
                              <input
                                type="text"
                                value={"Dados via ID"}
                                readOnly
                                className="w-full px-2 py-1 border border-gray-300 dark:border-gray-600 rounded bg-gray-50 dark:bg-gray-700 text-gray-900 dark:text-white text-sm"
                              />
                            </div>
                            <div>
                              <label className="block text-xs font-medium text-gray-600 dark:text-gray-400 mb-1">Razão Social</label>
                              <input
                                type="text"
                                value={"Dados via ID"}
                                readOnly
                                className="w-full px-2 py-1 border border-gray-300 dark:border-gray-600 rounded bg-gray-50 dark:bg-gray-700 text-gray-900 dark:text-white text-sm"
                              />
                            </div>
                            <div>
                              <label className="block text-xs font-medium text-gray-600 dark:text-gray-400 mb-1">Número da Apólice</label>
                              <input
                                type="text"
                                value={"Dados via ID"}
                                readOnly
                                className="w-full px-2 py-1 border border-gray-300 dark:border-gray-600 rounded bg-gray-50 dark:bg-gray-700 text-gray-900 dark:text-white text-sm"
                              />
                            </div>
                          </div>
                        </div>
                      )}
                    </div>
                  </div>
                </OptionalSection>

                {!showOptionalContratacao && !showOptionalSeguro && (
                  <div className="text-center py-8 text-gray-500 dark:text-gray-400">
                    <i className="fas fa-handshake text-4xl mb-4 opacity-50"></i>
                    <p>Seção opcional</p>
                    <p className="text-sm">Ative os campos acima se necessário</p>
                  </div>
                )}
              </div>
            </div>
          )}

          {/* Seção Carga */}
          {currentSection === 'carga' && (
            <div>
              <div className="flex items-center mb-8">
                <div className="w-12 h-12 bg-gradient-to-br from-green-500 to-teal-600 rounded-xl flex items-center justify-center mr-4 shadow-lg">
                  <i className="fas fa-boxes text-white text-lg"></i>
                </div>
                <div>
                  <h2 className="text-2xl font-bold text-gray-900 dark:text-white">Informações da Carga</h2>
                  <p className="text-gray-600 dark:text-gray-400 mt-1">Dados sobre a carga a ser transportada</p>
                </div>
              </div>

              <div className="space-y-6">
                <div className="bg-gradient-to-r from-green-50 to-teal-50 dark:from-green-900/20 dark:to-teal-900/20 p-6 rounded-xl border border-green-200 dark:border-green-700">
                  <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                      <label className="block text-sm font-semibold text-gray-900 dark:text-white mb-2">
                        Valor Total da Carga (R$)
                      </label>
                      <input
                        type="text"
                        value={dados.valorTotal || ''}
                        onChange={(e) => {
                          const value = e.target.value;
                          // Permite digitação mantendo como string temporariamente
                          onDadosChange({ ...dados, valorTotal: value as any });
                        }}
                        onBlur={(e) => {
                          const numericValue = parseFloat(e.target.value.replace(',', '.')) || 0;
                          onDadosChange({ ...dados, valorTotal: numericValue });
                        }}
                        placeholder="0,00"
                        className="w-full px-4 py-3 border-2 border-gray-300 dark:border-gray-600 rounded-xl bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500"
                      />
                    </div>

                    <div>
                      <label className="block text-sm font-semibold text-gray-900 dark:text-white mb-2">
                        Peso Total (kg)
                      </label>
                      <input
                        type="text"
                        value={dados.pesoBrutoTotal || ''}
                        onChange={(e) => {
                          const value = e.target.value;
                          // Permite digitação mantendo como string temporariamente
                          onDadosChange({ ...dados, pesoBrutoTotal: value as any });
                        }}
                        onBlur={(e) => {
                          const numericValue = parseFloat(e.target.value.replace(',', '.')) || 0;
                          onDadosChange({ ...dados, pesoBrutoTotal: numericValue });
                        }}
                        placeholder="0,000"
                        className="w-full px-4 py-3 border-2 border-gray-300 dark:border-gray-600 rounded-xl bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500"
                      />
                    </div>

                    <div>
                      <label className="block text-sm font-semibold text-gray-900 dark:text-white mb-2">
                        Unidade de Medida
                      </label>
                      <div className="w-full px-4 py-3 border-2 border-gray-300 dark:border-gray-600 rounded-xl bg-gray-50 dark:bg-gray-700 text-gray-900 dark:text-white flex items-center">
                        <i className="fas fa-weight-hanging text-green-500 mr-2"></i>
                        <span className="font-medium">Quilograma (kg)</span>
                        <span className="ml-auto text-xs text-gray-500 dark:text-gray-400">Padrão do sistema</span>
                      </div>
                    </div>

                    <div>
                      <label className="block text-sm font-semibold text-gray-900 dark:text-white mb-2">
                        Tipo de Carga
                      </label>
                      <select
                        className="w-full px-4 py-3 border-2 border-gray-300 dark:border-gray-600 rounded-xl bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500"
                      >
                        <option value="">Selecione...</option>
                        <option value="01">Carga Geral</option>
                        <option value="02">Neogranel</option>
                        <option value="03">Granel Sólido</option>
                        <option value="04">Granel Líquido</option>
                        <option value="05">Contêiner</option>
                        <option value="06">Carga Frigorificada</option>
                        <option value="07">Carga Perigosa</option>
                      </select>
                    </div>
                  </div>

                  <div className="mt-6">
                    <label className="block text-sm font-semibold text-gray-900 dark:text-white mb-2">
                      Descrição da Carga
                    </label>
                    <textarea
                      rows={3}
                      placeholder="Descreva brevemente a carga a ser transportada..."
                      className="w-full px-4 py-3 border-2 border-gray-300 dark:border-gray-600 rounded-xl bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500 resize-none"
                    />
                  </div>
                </div>
              </div>
            </div>
          )}

          {/* Seção Documentos Fiscais */}
          {currentSection === 'documentos' && (
            <div>
              <div className="flex items-center mb-8">
                <div className="w-12 h-12 bg-gradient-to-br from-orange-500 to-red-600 rounded-xl flex items-center justify-center mr-4 shadow-lg">
                  <i className="fas fa-file-invoice text-white text-lg"></i>
                </div>
                <div>
                  <h2 className="text-2xl font-bold text-gray-900 dark:text-white">Documentos Fiscais</h2>
                  <p className="text-gray-600 dark:text-gray-400 mt-1">Vincule os CTe/NFe que serão transportados</p>
                </div>
              </div>

              <div className="space-y-6">
                {/* Seção CTe */}
                <div className="bg-white dark:bg-gray-800 p-6 rounded-xl border-2 border-gray-200 dark:border-gray-700">
                  <div className="flex items-center justify-between mb-6">
                    <div className="flex items-center gap-3">
                      <div className="w-8 h-8 bg-gradient-to-br from-blue-500 to-blue-600 rounded-lg flex items-center justify-center">
                        <i className="fas fa-truck text-white text-sm"></i>
                      </div>
                      <h3 className="text-lg font-semibold text-gray-900 dark:text-white">
                        CTe - Conhecimento de Transporte Eletrônico
                      </h3>
                    </div>
                    <button
                      type="button"
                      onClick={() => {
                        const novosCTe = [...(dados.documentosCTe || []), ''];
                        onDadosChange({ ...dados, documentosCTe: novosCTe });
                      }}
                      className="flex items-center gap-2 px-4 py-2 bg-gradient-to-r from-blue-500 to-blue-600 text-white rounded-lg font-semibold hover:shadow-lg transition-all"
                    >
                      <i className="fas fa-plus"></i>
                      Adicionar CTe
                    </button>
                  </div>

                  {dados.documentosCTe && dados.documentosCTe.length > 0 ? (
                    <div className="space-y-3">
                      {dados.documentosCTe.map((chaveAcesso: string, index: number) => (
                        <div key={index} className="bg-blue-50 dark:bg-blue-900/20 p-4 rounded-lg border border-blue-200 dark:border-blue-700">
                          <div className="flex items-center gap-4">
                            <div className="flex-1">
                              <label className="block text-sm font-semibold text-gray-700 dark:text-gray-300 mb-2">
                                Chave de Acesso CTe {index + 1} *
                              </label>
                              <input
                                type="text"
                                value={chaveAcesso || ''}
                                onChange={(e) => {
                                  const valor = e.target.value.replace(/\D/g, '');
                                  if (valor.length <= 44) {
                                    const novosCTe = [...dados.documentosCTe!];
                                    novosCTe[index] = valor;
                                    onDadosChange({ ...dados, documentosCTe: novosCTe });
                                  }
                                }}
                                placeholder="Digite a chave de acesso do CTe (44 dígitos)"
                                className="w-full px-4 py-3 border-2 border-blue-300 dark:border-blue-600 rounded-xl bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                                maxLength={44}
                              />
                              {chaveAcesso && chaveAcesso.length !== 44 && (
                                <p className="text-red-500 text-sm mt-1">
                                  A chave de acesso deve ter exatamente 44 dígitos
                                </p>
                              )}
                            </div>
                            <button
                              type="button"
                              onClick={() => {
                                const novosCTe = dados.documentosCTe!.filter((_: string, i: number) => i !== index);
                                onDadosChange({ ...dados, documentosCTe: novosCTe });
                              }}
                              className="text-red-500 hover:text-red-700 p-2 rounded-lg hover:bg-red-50 dark:hover:bg-red-900/20"
                            >
                              <i className="fas fa-trash"></i>
                            </button>
                          </div>
                        </div>
                      ))}
                    </div>
                  ) : (
                    <div className="text-center py-8 border-2 border-dashed border-blue-300 dark:border-blue-600 rounded-xl bg-blue-50 dark:bg-blue-900/10">
                      <div className="w-12 h-12 bg-gradient-to-br from-blue-500 to-blue-600 rounded-full flex items-center justify-center mx-auto mb-3">
                        <i className="fas fa-truck text-white"></i>
                      </div>
                      <h4 className="text-md font-semibold text-gray-900 dark:text-white mb-2">
                        Nenhum CTe vinculado
                      </h4>
                      <p className="text-gray-600 dark:text-gray-400 text-sm">
                        Adicione as chaves de acesso dos CTe transportados
                      </p>
                    </div>
                  )}
                </div>

                {/* Seção NFe */}
                <div className="bg-white dark:bg-gray-800 p-6 rounded-xl border-2 border-gray-200 dark:border-gray-700">
                  <div className="flex items-center justify-between mb-6">
                    <div className="flex items-center gap-3">
                      <div className="w-8 h-8 bg-gradient-to-br from-green-500 to-green-600 rounded-lg flex items-center justify-center">
                        <i className="fas fa-file-invoice text-white text-sm"></i>
                      </div>
                      <h3 className="text-lg font-semibold text-gray-900 dark:text-white">
                        NFe - Nota Fiscal Eletrônica
                      </h3>
                    </div>
                    <button
                      type="button"
                      onClick={() => {
                        const novosNFe = [...(dados.documentosNFe || []), ''];
                        onDadosChange({ ...dados, documentosNFe: novosNFe });
                      }}
                      className="flex items-center gap-2 px-4 py-2 bg-gradient-to-r from-green-500 to-green-600 text-white rounded-lg font-semibold hover:shadow-lg transition-all"
                    >
                      <i className="fas fa-plus"></i>
                      Adicionar NFe
                    </button>
                  </div>

                  {dados.documentosNFe && dados.documentosNFe.length > 0 ? (
                    <div className="space-y-3">
                      {dados.documentosNFe.map((chaveAcesso: string, index: number) => (
                        <div key={index} className="bg-green-50 dark:bg-green-900/20 p-4 rounded-lg border border-green-200 dark:border-green-700">
                          <div className="flex items-center gap-4">
                            <div className="flex-1">
                              <label className="block text-sm font-semibold text-gray-700 dark:text-gray-300 mb-2">
                                Chave de Acesso NFe {index + 1} *
                              </label>
                              <input
                                type="text"
                                value={chaveAcesso || ''}
                                onChange={(e) => {
                                  const valor = e.target.value.replace(/\D/g, '');
                                  if (valor.length <= 44) {
                                    const novosNFe = [...dados.documentosNFe!];
                                    novosNFe[index] = valor;
                                    onDadosChange({ ...dados, documentosNFe: novosNFe });
                                  }
                                }}
                                placeholder="Digite a chave de acesso da NFe (44 dígitos)"
                                className="w-full px-4 py-3 border-2 border-green-300 dark:border-green-600 rounded-xl bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500"
                                maxLength={44}
                              />
                              {chaveAcesso && chaveAcesso.length !== 44 && (
                                <p className="text-red-500 text-sm mt-1">
                                  A chave de acesso deve ter exatamente 44 dígitos
                                </p>
                              )}
                            </div>
                            <button
                              type="button"
                              onClick={() => {
                                const novosNFe = dados.documentosNFe!.filter((_: string, i: number) => i !== index);
                                onDadosChange({ ...dados, documentosNFe: novosNFe });
                              }}
                              className="text-red-500 hover:text-red-700 p-2 rounded-lg hover:bg-red-50 dark:hover:bg-red-900/20"
                            >
                              <i className="fas fa-trash"></i>
                            </button>
                          </div>
                        </div>
                      ))}
                    </div>
                  ) : (
                    <div className="text-center py-8 border-2 border-dashed border-green-300 dark:border-green-600 rounded-xl bg-green-50 dark:bg-green-900/10">
                      <div className="w-12 h-12 bg-gradient-to-br from-green-500 to-green-600 rounded-full flex items-center justify-center mx-auto mb-3">
                        <i className="fas fa-file-invoice text-white"></i>
                      </div>
                      <h4 className="text-md font-semibold text-gray-900 dark:text-white mb-2">
                        Nenhuma NFe vinculada
                      </h4>
                      <p className="text-gray-600 dark:text-gray-400 text-sm">
                        Adicione as chaves de acesso das NFe transportadas
                      </p>
                    </div>
                  )}
                </div>

                {/* Informações importantes */}
                <div className="bg-blue-50 dark:bg-blue-900/20 border border-blue-200 dark:border-blue-700 rounded-xl p-4">
                  <div className="flex items-start gap-3">
                    <div className="w-6 h-6 bg-blue-500 rounded-full flex items-center justify-center flex-shrink-0 mt-0.5">
                      <i className="fas fa-info text-white text-xs"></i>
                    </div>
                    <div>
                      <h4 className="font-semibold text-blue-900 dark:text-blue-200 mb-1">
                        Informações Importantes
                      </h4>
                      <ul className="text-sm text-blue-800 dark:text-blue-300 space-y-1">
                        <li>• Informe apenas a chave de acesso (44 dígitos numéricos)</li>
                        <li>• Vincule apenas documentos autorizados e em vigor</li>
                        <li>• Você pode adicionar CTe e NFe separadamente conforme necessário</li>
                        <li>• Todos os documentos devem estar relacionados ao transporte</li>
                      </ul>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          )}

          {/* Seção Resumo */}
          {currentSection === 'resumo' && (
            <div>
              <div className="flex items-center mb-8">
                <div className="w-12 h-12 bg-gradient-to-br from-indigo-500 to-purple-600 rounded-xl flex items-center justify-center mr-4 shadow-lg">
                  <i className="fas fa-clipboard-check text-white text-lg"></i>
                </div>
                <div>
                  <h2 className="text-2xl font-bold text-gray-900 dark:text-white">Resumo do MDFe</h2>
                  <p className="text-gray-600 dark:text-gray-400 mt-1">Revise todas as informações antes de salvar e transmitir</p>
                </div>
              </div>

              <div className="space-y-6">
                {/* Status Geral */}
                <div className="bg-gradient-to-r from-indigo-50 to-purple-50 dark:from-indigo-900/20 dark:to-purple-900/20 p-6 rounded-xl border border-indigo-200 dark:border-indigo-700">
                  <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
                    <div className="text-center">
                      <div className="w-16 h-16 bg-gradient-to-br from-blue-500 to-blue-600 rounded-full flex items-center justify-center mx-auto mb-3">
                        <i className="fas fa-file-alt text-white text-xl"></i>
                      </div>
                      <h3 className="font-bold text-gray-900 dark:text-white mb-1">Documento</h3>
                      <p className="text-sm text-gray-600 dark:text-gray-400">
                        {isEdicao ? 'Editando MDFe' : 'Novo MDFe'}
                      </p>
                    </div>
                    <div className="text-center">
                      <div className="w-16 h-16 bg-gradient-to-br from-green-500 to-green-600 rounded-full flex items-center justify-center mx-auto mb-3">
                        <i className="fas fa-check-circle text-white text-xl"></i>
                      </div>
                      <h3 className="font-bold text-gray-900 dark:text-white mb-1">Status</h3>
                      <p className="text-sm text-gray-600 dark:text-gray-400">
                        Pronto para transmissão
                      </p>
                    </div>
                  </div>
                </div>

                {/* Informações Principais */}
                <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
                  {/* Emitente */}
                  <div className="bg-white dark:bg-gray-800 p-6 rounded-xl border border-gray-200 dark:border-gray-700 shadow-sm">
                    <div className="flex items-center mb-4">
                      <div className="w-8 h-8 bg-blue-100 dark:bg-blue-900/50 rounded-lg flex items-center justify-center mr-3">
                        <i className="fas fa-building text-blue-600 dark:text-blue-400"></i>
                      </div>
                      <h3 className="text-lg font-semibold text-gray-900 dark:text-white">Emitente</h3>
                    </div>
                    <div className="space-y-2">
                      <div>
                        <span className="text-sm font-medium text-gray-500 dark:text-gray-400">Razão Social:</span>
                        <p className="text-gray-900 dark:text-white font-medium">
                          {(() => {
                            if (!selectedIds.emitenteId) return 'Não selecionado';
                            const emitente = entidadesCarregadas?.emitentes?.find((e: any) => e.id === selectedIds.emitenteId);
                            return emitente?.data?.razaoSocial || emitente?.data?.RazaoSocial || emitente?.label || 'Não informado';
                          })()}
                        </p>
                      </div>
                      <div>
                        <span className="text-sm font-medium text-gray-500 dark:text-gray-400">CNPJ:</span>
                        <p className="text-gray-900 dark:text-white">
                          {(() => {
                            if (!selectedIds.emitenteId) return 'Não selecionado';
                            const emitente = entidadesCarregadas?.emitentes?.find((e: any) => e.id === selectedIds.emitenteId);
                            return emitente?.data?.cnpj || emitente?.data?.CNPJ || emitente?.description?.split(' - ')[0] || 'Não informado';
                          })()}
                        </p>
                      </div>
                    </div>
                  </div>

                  {/* Transporte */}
                  <div className="bg-white dark:bg-gray-800 p-6 rounded-xl border border-gray-200 dark:border-gray-700 shadow-sm">
                    <div className="flex items-center mb-4">
                      <div className="w-8 h-8 bg-green-100 dark:bg-green-900/50 rounded-lg flex items-center justify-center mr-3">
                        <i className="fas fa-truck text-green-600 dark:text-green-400"></i>
                      </div>
                      <h3 className="text-lg font-semibold text-gray-900 dark:text-white">Transporte</h3>
                    </div>
                    <div className="space-y-2">
                      <div>
                        <span className="text-sm font-medium text-gray-500 dark:text-gray-400">Veículo:</span>
                        <p className="text-gray-900 dark:text-white font-medium">
                          {(() => {
                            if (!selectedIds.veiculoId) return 'Não selecionado';
                            const veiculo = entidadesCarregadas?.veiculos?.find((v: any) => v.id === selectedIds.veiculoId);
                            return veiculo?.data?.placa || veiculo?.data?.Placa || veiculo?.label?.split(' - ')[0] || 'Não informado';
                          })()}
                        </p>
                      </div>
                      <div>
                        <span className="text-sm font-medium text-gray-500 dark:text-gray-400">Condutor:</span>
                        <p className="text-gray-900 dark:text-white">
                          {(() => {
                            if (!selectedIds.condutorId) return 'Não selecionado';
                            const condutor = entidadesCarregadas?.condutores?.find((c: any) => c.id === selectedIds.condutorId);
                            return condutor?.data?.nome || condutor?.label || 'Não informado';
                          })()}
                        </p>
                      </div>
                      {reboquesSelecionados.length > 0 && (
                        <div>
                          <span className="text-sm font-medium text-gray-500 dark:text-gray-400">Reboques:</span>
                          <p className="text-gray-900 dark:text-white">
                            {reboquesDisponiveis
                              .filter(r => reboquesSelecionados.includes(r.id))
                              .map(r => reboquesService.formatarPlaca(r.placa))
                              .join(', ') || 'Nenhum reboque selecionado'}
                          </p>
                        </div>
                      )}
                    </div>
                  </div>
                </div>

                {/* Localidades */}
                <div className="bg-white dark:bg-gray-800 p-6 rounded-xl border border-gray-200 dark:border-gray-700 shadow-sm">
                  <div className="flex items-center mb-4">
                    <div className="w-8 h-8 bg-purple-100 dark:bg-purple-900/50 rounded-lg flex items-center justify-center mr-3">
                      <i className="fas fa-map-marker-alt text-purple-600 dark:text-purple-400"></i>
                    </div>
                    <h3 className="text-lg font-semibold text-gray-900 dark:text-white">Localidades</h3>
                  </div>
                  <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                      <h4 className="font-medium text-gray-900 dark:text-white mb-2">Carregamento</h4>
                      {locaisCarregamento.length > 0 ? (
                        <div className="space-y-1">
                          {locaisCarregamento.map((local, index) => (
                            <p key={index} className="text-sm text-gray-600 dark:text-gray-400">
                              {local.municipio} - {local.uf}
                            </p>
                          ))}
                        </div>
                      ) : (
                        <p className="text-sm text-red-500">Nenhum local definido</p>
                      )}
                    </div>
                    <div>
                      <h4 className="font-medium text-gray-900 dark:text-white mb-2">Descarregamento</h4>
                      {locaisDescarregamento.length > 0 ? (
                        <div className="space-y-1">
                          {locaisDescarregamento.map((local, index) => (
                            <p key={index} className="text-sm text-gray-600 dark:text-gray-400">
                              {local.municipio} - {local.uf}
                            </p>
                          ))}
                        </div>
                      ) : (
                        <p className="text-sm text-red-500">Nenhum local definido</p>
                      )}
                    </div>
                  </div>
                  {rotaSelecionada.length > 0 && (
                    <div className="mt-4 pt-4 border-t border-gray-200 dark:border-gray-700">
                      <h4 className="font-medium text-gray-900 dark:text-white mb-2">Percurso Fiscal</h4>
                      <div className="flex flex-wrap gap-2">
                        {rotaSelecionada.map((uf: string, index: number) => (
                          <span
                            key={index}
                            className="px-3 py-1 bg-blue-100 dark:bg-blue-900/50 text-blue-800 dark:text-blue-200 rounded-full text-sm font-medium"
                          >
                            {uf}
                          </span>
                        ))}
                      </div>
                    </div>
                  )}
                </div>

                {/* Contratação */}
                <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
                  <div className="bg-white dark:bg-gray-800 p-6 rounded-xl border border-gray-200 dark:border-gray-700 shadow-sm">
                    <div className="flex items-center mb-4">
                      <div className="w-8 h-8 bg-orange-100 dark:bg-orange-900/50 rounded-lg flex items-center justify-center mr-3">
                        <i className="fas fa-handshake text-orange-600 dark:text-orange-400"></i>
                      </div>
                      <h3 className="text-lg font-semibold text-gray-900 dark:text-white">Contratante</h3>
                    </div>
                    <div className="space-y-2">
                      <div>
                        <span className="text-sm font-medium text-gray-500 dark:text-gray-400">Empresa:</span>
                        <p className="text-gray-900 dark:text-white">
                          {(() => {
                            if (!selectedIds.contratanteId) return 'Não selecionado';
                            const contratante = entidadesCarregadas?.contratantes?.find((c: any) => c.id === selectedIds.contratanteId);
                            return contratante?.data?.razaoSocial || contratante?.data?.nome || contratante?.label || 'Não informado';
                          })()}
                        </p>
                      </div>
                    </div>
                  </div>

                  <div className="bg-white dark:bg-gray-800 p-6 rounded-xl border border-gray-200 dark:border-gray-700 shadow-sm">
                    <div className="flex items-center mb-4">
                      <div className="w-8 h-8 bg-teal-100 dark:bg-teal-900/50 rounded-lg flex items-center justify-center mr-3">
                        <i className="fas fa-shield-alt text-teal-600 dark:text-teal-400"></i>
                      </div>
                      <h3 className="text-lg font-semibold text-gray-900 dark:text-white">Seguradora</h3>
                    </div>
                    <div className="space-y-2">
                      <div>
                        <span className="text-sm font-medium text-gray-500 dark:text-gray-400">Empresa:</span>
                        <p className="text-gray-900 dark:text-white">
                          {(() => {
                            if (!selectedIds.seguradoraId) return 'Não selecionado';
                            const seguradora = entidadesCarregadas?.seguradoras?.find((s: any) => s.id === selectedIds.seguradoraId);
                            return seguradora?.data?.razaoSocial || seguradora?.label || 'Não informado';
                          })()}
                        </p>
                      </div>
                    </div>
                  </div>
                </div>

                {/* Carga e Documentos */}
                <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
                  <div className="bg-white dark:bg-gray-800 p-6 rounded-xl border border-gray-200 dark:border-gray-700 shadow-sm">
                    <div className="flex items-center mb-4">
                      <div className="w-8 h-8 bg-emerald-100 dark:bg-emerald-900/50 rounded-lg flex items-center justify-center mr-3">
                        <i className="fas fa-boxes text-emerald-600 dark:text-emerald-400"></i>
                      </div>
                      <h3 className="text-lg font-semibold text-gray-900 dark:text-white">Informações da Carga</h3>
                    </div>
                    <div className="space-y-2">
                      <div>
                        <span className="text-sm font-medium text-gray-500 dark:text-gray-400">Valor:</span>
                        <p className="text-gray-900 dark:text-white font-medium">
                          {dados.valorTotal ? `R$ ${dados.valorTotal.toLocaleString('pt-BR', { minimumFractionDigits: 2 })}` : 'Não informado'}
                        </p>
                      </div>
                      <div>
                        <span className="text-sm font-medium text-gray-500 dark:text-gray-400">Peso:</span>
                        <p className="text-gray-900 dark:text-white">
                          {dados.pesoBrutoTotal ? `${dados.pesoBrutoTotal} kg` : 'Não informado'}
                        </p>
                      </div>
                    </div>
                  </div>

                  <div className="bg-white dark:bg-gray-800 p-6 rounded-xl border border-gray-200 dark:border-gray-700 shadow-sm">
                    <div className="flex items-center mb-4">
                      <div className="w-8 h-8 bg-red-100 dark:bg-red-900/50 rounded-lg flex items-center justify-center mr-3">
                        <i className="fas fa-file-invoice text-red-600 dark:text-red-400"></i>
                      </div>
                      <h3 className="text-lg font-semibold text-gray-900 dark:text-white">Documentos Fiscais</h3>
                    </div>
                    <div className="space-y-2">
                      <div>
                        <span className="text-sm font-medium text-gray-500 dark:text-gray-400">CTe:</span>
                        <p className="text-gray-900 dark:text-white">
                          {dados.documentosCTe?.length || 0} documento(s)
                        </p>
                      </div>
                      <div>
                        <span className="text-sm font-medium text-gray-500 dark:text-gray-400">NFe:</span>
                        <p className="text-gray-900 dark:text-white">
                          {dados.documentosNFe?.length || 0} documento(s)
                        </p>
                      </div>
                    </div>
                  </div>
                </div>

                {/* Validação */}
                <div className="bg-blue-50 dark:bg-blue-900/20 border border-blue-200 dark:border-blue-700 rounded-xl p-6">
                  <div className="flex items-start gap-4">
                    <div className="w-8 h-8 bg-blue-500 rounded-full flex items-center justify-center flex-shrink-0 mt-0.5">
                      <i className="fas fa-info text-white text-sm"></i>
                    </div>
                    <div>
                      <h4 className="font-semibold text-blue-900 dark:text-blue-200 mb-2">
                        Validação Final
                      </h4>
                      <div className="space-y-1 text-sm text-blue-800 dark:text-blue-300">
                        <div className="flex items-center gap-2">
                          <i className={`fas ${selectedIds.emitenteId ? 'fa-check text-green-600' : 'fa-times text-red-600'}`}></i>
                          <span>Emitente selecionado</span>
                        </div>
                        <div className="flex items-center gap-2">
                          <i className={`fas ${selectedIds.veiculoId && selectedIds.condutorId ? 'fa-check text-green-600' : 'fa-times text-red-600'}`}></i>
                          <span>Transporte configurado</span>
                        </div>
                        <div className="flex items-center gap-2">
                          <i className={`fas ${locaisCarregamento.length > 0 && locaisDescarregamento.length > 0 ? 'fa-check text-green-600' : 'fa-times text-red-600'}`}></i>
                          <span>Localidades definidas</span>
                        </div>
                        <div className="flex items-center gap-2">
                          <i className={`fas ${dados.valorTotal && dados.pesoBrutoTotal ? 'fa-check text-green-600' : 'fa-times text-red-600'}`}></i>
                          <span>Informações da carga</span>
                        </div>
                        <div className="flex items-center gap-2">
                          <i className={`fas ${(dados.documentosCTe?.length || 0) > 0 || (dados.documentosNFe?.length || 0) > 0 ? 'fa-check text-green-600' : 'fa-times text-red-600'}`}></i>
                          <span>Documentos fiscais vinculados</span>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          )}
        </div>

        {/* Botões */}
        <div className="flex justify-between items-center pt-8 border-t-2 border-gray-200 dark:border-gray-700 mt-10">
          <div className="flex space-x-4">
            <button
              onClick={prevSection}
              disabled={!canGoPrev}
              className="px-6 py-3 border-2 rounded-xl font-semibold bg-white dark:bg-gray-800 text-gray-900 dark:text-white"
            >
              ← Anterior
            </button>
            <button
              onClick={nextSection}
              disabled={!canGoNext}
              className="px-6 py-3 rounded-xl font-semibold bg-gradient-to-r from-blue-500 to-indigo-600 text-white"
            >
              Próximo →
            </button>
          </div>

          <div className="flex space-x-4">
            <button
              onClick={onCancelar}
              className="px-6 py-3 border-2 border-gray-300 dark:border-gray-600 rounded-xl font-semibold bg-white dark:bg-gray-800 text-gray-900 dark:text-white"
            >
              Cancelar
            </button>
            <button
              onClick={onSalvar}
              className="px-6 py-3 bg-gradient-to-r from-green-500 to-emerald-600 text-white rounded-xl font-semibold"
            >
              {salvando ? 'Salvando...' : 'Salvar'}
            </button>
            {onTransmitir && currentSection === 'resumo' && (
              <button
                onClick={onTransmitir}
                className="px-6 py-3 bg-gradient-to-r from-blue-500 to-indigo-600 text-white rounded-xl font-semibold"
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