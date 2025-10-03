import React, { useState, useEffect } from 'react';
import { MDFeData, EntidadesCarregadas } from '../../../types/mdfe';
import { useMDFeForm } from '../../../hooks/useMDFeForm';
import Icon from '../Icon';
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
  entidadesCarregadas?: EntidadesCarregadas;
}

// Helper para mapear entidades para opções do Combobox de forma segura
const mapEntityToOption = (entity: any, defaultLabel: string, icon: string) => ({
  id: entity?.id || '',
  label: entity?.label || defaultLabel,
  sublabel: entity?.description || '',
  icon
});

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
  const [currentSection, setCurrentSection] = useState('dados-basicos');
  const [showCancelModal, setShowCancelModal] = useState(false);


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
    selectEntity,
    setFormData
  } = useMDFeForm();

  // Sincronizar dados do hook com o componente pai - SEM criar loop
  useEffect(() => {
    if (dadosHook && Object.keys(dadosHook).length > 0) {
      // Apenas atualizar se houver diferença real nos IDs
      const idsChanged =
        dadosHook.emitenteId !== dados.emitenteId ||
        dadosHook.veiculoId !== dados.veiculoId ||
        dadosHook.condutorId !== dados.condutorId ||
        dadosHook.contratanteId !== dados.contratanteId ||
        dadosHook.seguradoraId !== dados.seguradoraId;

      if (idsChanged) {
        onDadosChange({ ...dados, ...dadosHook });
      }
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [dadosHook]);

  // ✅ Carregar localidades quando em modo de edição - APENAS UMA VEZ
  const [dadosInicializados, setDadosInicializados] = useState(false);

  // ✅ useEffect único para inicialização e atualização de dados
  useEffect(() => {
    // Prevenir múltiplas inicializações
    if (dadosInicializados || carregandoDados || !dados) {
      return;
    }

    if (isEdicao) {
      console.log('🔄 Inicializando dados do formulário:', {
        isEdicao,
        carregandoDados,
        dadosInicializados,
        temDados: !!dados,
        dados
      });

      // Atualizar selectedIds
      if (dados.emitenteId || dados.veiculoId || dados.condutorId) {
        console.log('� Atualizando selectedIds com:', dados);
        setFormData(dados);
      }
      console.log('🔄 Inicializando dados do MDFe para edição:', dados);

      // Carregar localidades de carregamento
      if (dados.localidadesCarregamento && dados.localidadesCarregamento.length > 0) {
        const locais = dados.localidadesCarregamento.map((mun, index) => ({
          id: `carregamento-${index}`,
          uf: mun.uf || '',
          municipio: mun.municipio || '',
          codigoIBGE: mun.codigoIBGE || 0
        }));
        setLocaisCarregamento(locais);
        console.log('✅ Carregados', locais.length, 'locais de carregamento');
      }

      // Carregar localidades de descarregamento
      if (dados.localidadesDescarregamento && dados.localidadesDescarregamento.length > 0) {
        const locais = dados.localidadesDescarregamento.map((mun, index) => ({
          id: `descarregamento-${index}`,
          uf: mun.uf || '',
          municipio: mun.municipio || '',
          codigoIBGE: mun.codigoIBGE || 0
        }));
        setLocaisDescarregamento(locais);
        console.log('✅ Carregados', locais.length, 'locais de descarregamento');
      }

      // Carregar rota se disponível
      if (dados.rotaPercurso && dados.rotaPercurso.length > 0) {
        setRotaSelecionada(dados.rotaPercurso);
        console.log('✅ Carregada rota com', dados.rotaPercurso.length, 'UFs');
      }

      // Carregar reboques se disponíveis
      if (dados.reboquesIds && dados.reboquesIds.length > 0) {
        setReboquesSelecionados(dados.reboquesIds);
        console.log('✅ Carregados', dados.reboquesIds.length, 'reboques');
      }

      // Atualizar hook com os IDs
      setFormData(dados);

      // Marcar como inicializado (não executar novamente)
      setDadosInicializados(true);
      console.log('✅ Dados inicializados com sucesso');
    }
  }, [isEdicao, carregandoDados, dados, dadosInicializados, setFormData]);

  // Resetar flag quando o ID do MDFe mudar
  useEffect(() => {
    if (isEdicao && dados?.id !== undefined) {
      // Se está em modo edição e tem um novo ID, reseta para permitir nova inicialização
      setDadosInicializados(false);
      console.log('🔄 Reset do formulário para novo MDFe:', dados.id);
    }
  }, [isEdicao, dados?.id]);

  // Funções para gerenciar localidades
  const handleLocaisCarregamentoChange = (locais: LocalCarregamento[]) => {
    setLocaisCarregamento(locais);
    // Backend calcula automaticamente UfIni/MunicipioIni do primeiro local
  };

  const handleLocaisDescarregamentoChange = (locais: LocalCarregamento[]) => {
    setLocaisDescarregamento(locais);
    // Backend calcula automaticamente UfFim/MunicipioFim do primeiro local
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

  // Carregar reboques disponíveis
  useEffect(() => {
    const carregarReboques = async () => {
      console.log('🚛 Carregando reboques...');
      setCarregandoReboques(true);
      try {
        const response = await reboquesService.listarReboquesAtivos();
        console.log('📦 Resposta do serviço:', response);

        if (response.sucesso && response.data) {
          console.log(`✅ ${response.data.length} reboques ativos encontrados`);
          setReboquesDisponiveis(response.data);
        } else {
          console.warn('⚠️ Nenhum reboque retornado:', response.mensagem);
        }
      } catch (error) {
        console.error('❌ Erro ao carregar reboques:', error);
      } finally {
        setCarregandoReboques(false);
      }
    };

    carregarReboques();
  }, []);

  // Validações mais rigorosas das seções
  const validarDadosBasicos = () => {
    // Valida Emitente + Transporte (obrigatórios)
    // Contratação é opcional, não bloqueia
    const emitenteValido = !!(selectedIds.emitenteId && selectedIds.emitenteId !== '');
    const transporteValido = !!(
      selectedIds.veiculoId && selectedIds.veiculoId !== '' &&
      selectedIds.condutorId && selectedIds.condutorId !== ''
    );
    return emitenteValido && transporteValido;
  };

  const validarLocalidades = () => {
    return locaisCarregamento.length > 0 && locaisDescarregamento.length > 0;
  };

  const validarCargaDocumentos = () => {
    // Valida Carga + Documentos juntos
    const cargaValida = !!(
      dados.valorTotal && dados.valorTotal > 0 &&
      dados.pesoBrutoTotal && dados.pesoBrutoTotal > 0
    );
    const temCTe = dados.documentosCTe && dados.documentosCTe.length > 0 && dados.documentosCTe.every(doc => doc.length === 44);
    const temNFe = dados.documentosNFe && dados.documentosNFe.length > 0 && dados.documentosNFe.every(doc => doc.length === 44);
    const documentosValidos = !!(temCTe || temNFe);

    return cargaValida && documentosValidos;
  };

  const validarTudo = () => {
    return validarDadosBasicos() && validarLocalidades() && validarCargaDocumentos();
  };

  // Verificar se há dados preenchidos
  const temDadosPreenchidos = () => {
    return !!(
      selectedIds.emitenteId ||
      selectedIds.veiculoId ||
      selectedIds.condutorId ||
      selectedIds.contratanteId ||
      selectedIds.seguradoraId ||
      locaisCarregamento.length > 0 ||
      locaisDescarregamento.length > 0 ||
      dados.valorTotal ||
      dados.pesoBrutoTotal ||
      dados.documentosCTe?.length ||
      dados.documentosNFe?.length
    );
  };

  // Handle cancelar com confirmação
  const handleCancelar = () => {
    if (temDadosPreenchidos()) {
      setShowCancelModal(true);
    } else {
      onCancelar();
    }
  };

  const confirmarCancelamento = () => {
    setShowCancelModal(false);
    onCancelar();
  };

  const sections: WizardSection[] = [
    {
      id: 'dados-basicos',
      title: 'Dados Básicos',
      description: 'Emitente, Transporte e Contratação',
      required: true,
      completed: validarDadosBasicos()
    },
    {
      id: 'localidades',
      title: 'Rota e Localidades',
      description: 'Carregamento, descarregamento e percurso',
      required: true,
      completed: validarLocalidades()
    },
    {
      id: 'carga-documentos',
      title: 'Carga e Documentos',
      description: 'Informações da carga e documentos fiscais',
      required: true,
      completed: validarCargaDocumentos()
    },
    {
      id: 'resumo',
      title: 'Revisão Final',
      description: 'Validação e transmissão',
      required: true,
      completed: validarTudo()
    }
  ];

  const currentSectionIndex = sections.findIndex(s => s.id === currentSection);
  const canGoNext = currentSectionIndex < sections.length - 1;
  const canGoPrev = currentSectionIndex > 0;



  // Sincronizar localidades com dados do MDFe quando há mudanças - OTIMIZADO
  React.useEffect(() => {
    // Não sincronizar durante carregamento inicial
    if (carregandoDados) return;

    // Sempre sincronizar as localidades com o estado pai
    const dadosAtualizados = {
      ...dados,
      localidadesCarregamento: locaisCarregamento.map(local => ({
        uf: local.uf,
        municipio: local.municipio,
        codigoIBGE: local.codigoIBGE
      })),
      localidadesDescarregamento: locaisDescarregamento.map(local => ({
        uf: local.uf,
        municipio: local.municipio,
        codigoIBGE: local.codigoIBGE
      })),
      rotaPercurso: rotaSelecionada
    };

    onDadosChange(dadosAtualizados);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [locaisCarregamento, locaisDescarregamento, rotaSelecionada]);


  if (carregandoDados) {
    return (
      <div className="flex items-center justify-center min-h-64 bg-card rounded-lg border border-gray-300 dark:border-0">
        <div className="flex flex-col items-center space-y-4">
          <Icon name="spinner" className="w-8 h-8 text-primary animate-spin" />
          <p className="text-muted-foreground text-lg">Carregando dados do formulário...</p>
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
    <div className="min-h-screen bg-background">
      {/* Header modernizado */}
      <div className="bg-gradient-to-r from-blue-50 to-indigo-50 dark:from-gray-800 dark:to-gray-900 border-b border-gray-200 dark:border-0 shadow-lg">
        <div className="w-full px-6 py-8">
          <div className="flex items-center justify-between flex-wrap gap-4">
            <div className="flex items-center space-x-6">
              <div className="w-16 h-16 bg-gradient-to-br from-blue-500 to-indigo-600 dark:from-blue-600 dark:to-indigo-700 rounded-xl flex items-center justify-center shadow-lg">
                <i className="fas fa-file-invoice text-white text-2xl"></i>
              </div>
              <div>
                <h1 className="text-3xl font-bold text-foreground mb-2">
                  {isEdicao ? 'Editar MDFe' : 'Novo MDFe'}
                </h1>
                <p className="text-muted-foreground dark:text-gray-300 text-lg">
                  {isEdicao ? 'Edite os dados do manifesto eletrônico' : 'Preencha os dados para criar um novo manifesto eletrônico'}
                </p>
              </div>
            </div>

            <div className="flex items-center gap-4">
              <div className="bg-blue-50 dark:bg-gray-700 border-2 border-blue-400 dark:border-blue-500 rounded-xl px-6 py-4 shadow-lg">
                <label className="block text-xs font-semibold text-gray-700 dark:text-gray-200 mb-1 uppercase tracking-wide">Número do MDFe</label>
                <div className="text-3xl font-bold text-center text-blue-700 dark:text-blue-300 min-w-[8rem] py-1">
                  {dados.numero || '---'}
                </div>
              </div>
              <div className="bg-indigo-50 dark:bg-gray-700 border-2 border-indigo-400 dark:border-indigo-500 rounded-xl px-6 py-4 shadow-lg">
                <label className="block text-xs font-semibold text-gray-700 dark:text-gray-200 mb-1 uppercase tracking-wide text-center">Série</label>
                <input
                  type="text"
                  value={dados.serie || '1'}
                  onChange={(e) => onDadosChange({ ...dados, serie: e.target.value })}
                  placeholder="1"
                  maxLength={3}
                  className="w-20 text-3xl font-bold text-center text-indigo-700 dark:text-indigo-300 bg-transparent border-0 focus:outline-none focus:ring-2 focus:ring-indigo-500 dark:focus:ring-indigo-400 rounded py-1"
                />
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* Navegação modernizada */}
      <div className="bg-card border-b border-gray-200 dark:border-0 shadow-sm">
        <div className="w-full px-6">
          <nav className="grid grid-cols-4 gap-3 py-4">
            {sections.map((section, index) => {
              const isCurrent = section.id === currentSection;
              const isCompleted = section.completed;

              return (
                <button
                  key={section.id}
                  onClick={() => setCurrentSection(section.id)}
                  className={`w-full px-4 py-3 rounded-lg font-medium text-sm transition-all duration-300 hover:shadow-md ${
                    isCurrent
                      ? 'bg-gradient-to-r from-blue-500 to-indigo-600 text-white shadow-lg'
                      : isCompleted
                      ? 'bg-gradient-to-r from-green-500 to-emerald-600 text-white shadow-md'
                      : 'bg-gray-100 dark:bg-gray-700 text-muted-foreground dark:text-gray-300'
                  }`}
                >
                  <div className="flex items-center space-x-2">
                    <span className="w-6 h-6 rounded-full flex items-center justify-center text-xs font-bold bg-card/20">
                      {isCompleted ? <i className="fas fa-check"></i> : index + 1}
                    </span>
                    <div className="text-left flex-1">
                      <div className="font-semibold text-xs">{section.title}</div>
                      <div className="text-xs mt-0.5 opacity-75 hidden md:block">{section.description}</div>
                    </div>
                  </div>
                </button>
              );
            })}
          </nav>
        </div>
      </div>

      {/* Conteúdo */}
      <div className="w-full px-6 py-8">
        <div className="bg-card rounded-2xl shadow-xl border border-gray-200 dark:border-0 p-6 lg:p-8">

          {/* Etapa 1: Dados Básicos (Emitente + Transporte + Contratação) */}
          {currentSection === 'dados-basicos' && (
            <div>
              <div className="flex items-center mb-8">
                <div className="w-12 h-12 bg-gradient-to-br from-blue-500 to-indigo-600 rounded-xl flex items-center justify-center mr-4 shadow-lg">
                  <i className="fas fa-id-card text-white text-lg"></i>
                </div>
                <div>
                  <h2 className="text-2xl font-bold text-foreground">Dados Básicos do Transporte</h2>
                  <p className="text-muted-foreground mt-1">Preencha as informações essenciais do MDFe</p>
                </div>
              </div>

              <div className="space-y-8">
                {/* Seção: Emitente */}
                <div>
                  <div className="flex items-center gap-2 mb-4">
                    <div className="w-8 h-8 bg-blue-500 rounded-lg flex items-center justify-center">
                      <i className="fas fa-building text-white text-sm"></i>
                    </div>
                    <h3 className="text-lg font-semibold text-foreground">
                      Emitente
                      <span className="text-red-500 ml-1">*</span>
                    </h3>
                  </div>
                  <div className="pl-10">
                    <Combobox
                      label="Empresa Emissora"
                      options={((entidadesCarregadas?.emitentes || [])
                        .filter(emitente => emitente && typeof emitente === 'object')
                        .map((emitente: any) => ({
                          id: emitente?.id || '',
                          label: String(emitente?.label || 'Sem nome'),
                          sublabel: String(emitente?.description || ''),
                          icon: "fas fa-building"
                        }))
                      )}
                      selectedValue={selectedIds.emitenteId}
                      onSelect={(value) => selectEntity('emitenteId', value)}
                      placeholder="Selecione o emitente do MDFe..."
                      searchPlaceholder="Buscar emitente..."
                      required={true}
                    />
                    {!selectedIds.emitenteId && (
                      <p className="text-red-500 text-sm mt-2 flex items-center gap-2">
                        <i className="fas fa-exclamation-circle"></i>
                        Campo obrigatório
                      </p>
                    )}

                    {/* Indicador de Código IBGE do Município */}
                    {selectedIds.emitenteId && entidadesCarregadas?.emitentes && (() => {
                      const emitenteSelected: any = entidadesCarregadas.emitentes.find((e: any) => e?.id === selectedIds.emitenteId);
                      const codMunicipio = (emitenteSelected?.codMunicipio ?? 0) as number;
                      const municipio = (emitenteSelected?.municipio ?? '') as string;
                      const uf = (emitenteSelected?.uf ?? '') as string;

                      return (
                        <div className={`mt-3 p-3 rounded-lg border-2 ${
                          codMunicipio === 0
                            ? 'bg-red-50 dark:bg-red-900/20 border-red-300 dark:border-red-800'
                            : 'bg-green-50 dark:bg-green-900/20 border-green-300 dark:border-green-800'
                        }`}>
                          <div className="flex items-center gap-2">
                            <i className={`fas ${codMunicipio === 0 ? 'fa-exclamation-triangle text-red-600' : 'fa-check-circle text-green-600'}`}></i>
                            <div className="flex-1">
                              <p className={`text-sm font-semibold ${
                                codMunicipio === 0 ? 'text-red-700 dark:text-red-400' : 'text-green-700 dark:text-green-400'
                              }`}>
                                Código IBGE do Município: {codMunicipio === 0 ? 'NÃO DEFINIDO' : codMunicipio}
                              </p>
                              <p className="text-xs text-muted-foreground mt-1">
                                {municipio}/{uf}
                                {codMunicipio === 0 && ' - Edite o emitente para corrigir!'}
                              </p>
                            </div>
                          </div>
                        </div>
                      );
                    })()}
                  </div>
                </div>

                {/* Divisor */}
                <div className="border-t border-gray-200 dark:border-gray-700"></div>

                {/* Seção: Veículo e Condutor */}
                <div>
                  <div className="flex items-center gap-2 mb-4">
                    <div className="w-8 h-8 bg-orange-500 rounded-lg flex items-center justify-center">
                      <i className="fas fa-truck text-white text-sm"></i>
                    </div>
                    <h3 className="text-lg font-semibold text-foreground">
                      Veículo e Condutor
                      <span className="text-red-500 ml-1">*</span>
                    </h3>
                  </div>
                  <div className="pl-10 grid grid-cols-1 md:grid-cols-2 gap-6">
                    {/* Veículo */}
                    <div>
                      <Combobox
                        label="Veículo"
                        options={entidadesCarregadas?.veiculos?.map((veiculo: any) => ({
                          id: veiculo.id,
                          label: veiculo.label,
                          sublabel: veiculo.description,
                          icon: "fas fa-truck"
                        })) || []}
                        selectedValue={selectedIds.veiculoId}
                        onSelect={(value) => selectEntity('veiculoId', value)}
                        placeholder="Selecione o veículo..."
                        searchPlaceholder="Buscar veículo..."
                        required={true}
                      />
                      {!selectedIds.veiculoId && (
                        <p className="text-red-500 text-sm mt-2 flex items-center gap-2">
                          <i className="fas fa-exclamation-circle"></i>
                          Campo obrigatório
                        </p>
                      )}
                    </div>

                    {/* Condutor */}
                    <div>
                      <Combobox
                        label="Condutor"
                        options={entidadesCarregadas?.condutores?.map((condutor: any) => ({
                          id: condutor.id,
                          label: condutor.label,
                          sublabel: condutor.description,
                          icon: "fas fa-id-card"
                        })) || []}
                        selectedValue={selectedIds.condutorId}
                        onSelect={(value) => selectEntity('condutorId', value)}
                        placeholder="Selecione o condutor..."
                        searchPlaceholder="Buscar condutor..."
                        required={true}
                      />
                      {!selectedIds.condutorId && (
                        <p className="text-red-500 text-sm mt-2 flex items-center gap-2">
                          <i className="fas fa-exclamation-circle"></i>
                          Campo obrigatório
                        </p>
                      )}
                    </div>
                  </div>

                  {/* Reboques */}
                  <div className="pl-10 mt-6">
                    <div className="flex items-center justify-between mb-3">
                      <label className="block text-sm font-medium text-foreground">
                        Reboques
                        <span className="text-xs text-muted-foreground ml-2">(Opcional)</span>
                      </label>
                      {reboquesDisponiveis.length > 0 && reboquesSelecionados.length > 0 && (
                        <span className="text-xs text-muted-foreground">
                          {reboquesSelecionados.length} de {reboquesDisponiveis.length} selecionado{reboquesSelecionados.length !== 1 ? 's' : ''}
                        </span>
                      )}
                    </div>

                    {carregandoReboques ? (
                      <div className="flex items-center gap-2 text-sm text-gray-500 py-4">
                        <i className="fas fa-spinner fa-spin"></i>
                        Carregando reboques...
                      </div>
                    ) : reboquesDisponiveis.length === 0 ? (
                      <div className="text-sm text-gray-500 text-center py-4 border-2 border-dashed border-gray-300 dark:border-gray-600 rounded-lg">
                        <i className="fas fa-exclamation-triangle text-yellow-500 mr-2"></i>
                        Nenhum reboque ativo encontrado
                      </div>
                    ) : (
                      <div className="grid grid-cols-1 md:grid-cols-2 gap-3 max-h-64 overflow-y-auto pr-1">
                        {reboquesDisponiveis.map((reboque) => {
                          const isSelected = reboquesSelecionados.includes(reboque.id);
                          return (
                            <div
                              key={reboque.id}
                              onClick={() => handleReboqueToggle(reboque.id)}
                              className={`flex items-start gap-3 p-3 border-2 rounded-lg cursor-pointer transition-all ${
                                isSelected
                                  ? 'border-orange-500 bg-orange-50 dark:bg-orange-900/20'
                                  : 'border-gray-300 dark:border-gray-600 hover:border-orange-400 bg-card'
                              }`}
                            >
                              <div className={`flex-shrink-0 w-5 h-5 rounded border-2 flex items-center justify-center transition-all ${
                                isSelected
                                  ? 'bg-orange-500 border-orange-500'
                                  : 'border-gray-400 dark:border-gray-400 bg-white dark:bg-gray-700'
                              }`}>
                                {isSelected && (
                                  <svg className="w-3 h-3 text-white" fill="none" strokeLinecap="round" strokeLinejoin="round" strokeWidth="3" viewBox="0 0 24 24" stroke="currentColor">
                                    <path d="M5 13l4 4L19 7"></path>
                                  </svg>
                                )}
                              </div>
                              <div className="flex-1 min-w-0">
                                <div className="font-semibold text-foreground mb-1">
                                  {reboquesService.formatarPlaca(reboque.placa)}
                                </div>
                                <div className="flex flex-wrap gap-x-3 gap-y-1 text-xs text-muted-foreground">
                                  <span className="flex items-center gap-1">
                                    <i className="fas fa-map-marker-alt text-[10px]"></i>
                                    {reboque.uf}
                                  </span>
                                  <span className="flex items-center gap-1">
                                    <i className="fas fa-weight-hanging text-[10px]"></i>
                                    {reboquesService.formatarTara(reboque.tara)}
                                  </span>
                                  {reboque.tipoCarroceria && (
                                    <span className="flex items-center gap-1 truncate">
                                      <i className="fas fa-truck-loading text-[10px]"></i>
                                      {reboque.tipoCarroceria}
                                    </span>
                                  )}
                                </div>
                              </div>
                            </div>
                          );
                        })}
                      </div>
                    )}
                  </div>
                </div>

                {/* Divisor */}
                <div className="border-t border-gray-200 dark:border-gray-700"></div>

                {/* Seção: Contratação (Opcional) */}
                <div>
                  <div className="flex items-center gap-2 mb-4">
                    <div className="w-8 h-8 bg-purple-500 rounded-lg flex items-center justify-center">
                      <i className="fas fa-handshake text-white text-sm"></i>
                    </div>
                    <h3 className="text-lg font-semibold text-foreground">
                      Contratação
                      <span className="text-xs text-muted-foreground ml-2">(Opcional)</span>
                    </h3>
                  </div>
                  <div className="pl-10 grid grid-cols-1 md:grid-cols-2 gap-6">
                    {/* Contratante */}
                    <div>
                      <Combobox
                        label="Contratante"
                        options={entidadesCarregadas?.contratantes?.map((contratante: any) => ({
                          id: contratante.id,
                          label: contratante.label,
                          sublabel: contratante.description,
                          icon: "fas fa-building"
                        })) || []}
                        selectedValue={selectedIds.contratanteId}
                        onSelect={(value) => selectEntity('contratanteId', value)}
                        placeholder="Selecione o contratante (opcional)..."
                        searchPlaceholder="Buscar contratante..."
                      />
                    </div>

                    {/* Seguradora */}
                    <div>
                      <Combobox
                        label="Seguradora"
                        options={entidadesCarregadas?.seguradoras?.map((seguradora: any) => ({
                          id: seguradora.id,
                          label: seguradora.label,
                          sublabel: seguradora.description,
                          icon: "fas fa-shield-alt"
                        })) || []}
                        selectedValue={selectedIds.seguradoraId}
                        onSelect={(value) => selectEntity('seguradoraId', value)}
                        placeholder="Selecione a seguradora (opcional)..."
                        searchPlaceholder="Buscar seguradora..."
                      />
                    </div>
                  </div>
                </div>

              </div>
            </div>
          )}

          {/* Etapa 2: Rota e Localidades (Carregamento + Descarregamento) */}
          {currentSection === 'localidades' && (
            <div>
              <div className="flex items-center mb-8">
                <div className="w-12 h-12 bg-gradient-to-br from-blue-500 to-indigo-600 rounded-xl flex items-center justify-center mr-4 shadow-lg">
                  <i className="fas fa-map-marker-alt text-white text-lg"></i>
                </div>
                <div>
                  <h2 className="text-2xl font-bold text-foreground">Localidades de Carregamento e Descarregamento</h2>
                  <p className="text-muted-foreground mt-1">Informe os locais de carregamento e descarregamento da carga</p>
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
                  <div className="bg-gradient-to-r from-emerald-50 to-green-50 dark:from-emerald-900/20 dark:to-green-900/20 p-6 rounded-xl border border-emerald-200 dark:border-0">
                    <h3 className="text-lg font-semibold text-foreground mb-4 flex items-center">
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


          {/* Etapa 3: Carga e Documentos (Unificada) */}
          {currentSection === 'carga-documentos' && (
            <div>
              <div className="flex items-center mb-8">
                <div className="w-12 h-12 bg-gradient-to-br from-green-500 to-teal-600 rounded-xl flex items-center justify-center mr-4 shadow-lg">
                  <i className="fas fa-boxes text-white text-lg"></i>
                </div>
                <div>
                  <h2 className="text-2xl font-bold text-foreground">Carga e Documentos Fiscais</h2>
                  <p className="text-muted-foreground mt-1">Informações da carga e documentos fiscais vinculados (CTe/NFe)</p>
                </div>
              </div>

              <div className="space-y-6">
                <div className="bg-gradient-to-r from-green-50 to-teal-50 dark:from-green-900/20 dark:to-teal-900/20 p-6 rounded-xl border border-green-200 dark:border-0">
                  <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                      <label className="block text-sm font-semibold text-foreground mb-2">
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
                        className="w-full px-4 py-3 border-2 border-gray-300 dark:border-0 rounded-xl bg-card text-foreground focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500"
                      />
                    </div>

                    <div>
                      <label className="block text-sm font-semibold text-foreground mb-2">
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
                        className="w-full px-4 py-3 border-2 border-gray-300 dark:border-0 rounded-xl bg-card text-foreground focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500"
                      />
                    </div>

                    <div>
                      <label className="block text-sm font-semibold text-foreground mb-2">
                        Unidade de Medida
                      </label>
                      <div className="w-full px-4 py-3 border-2 border-gray-300 dark:border-0 rounded-xl bg-background dark:bg-gray-700 text-foreground flex items-center">
                        <i className="fas fa-weight-hanging text-green-500 mr-2"></i>
                        <span className="font-medium">Quilograma (kg)</span>
                        <span className="ml-auto text-xs text-gray-500 dark:text-gray-400">Padrão do sistema</span>
                      </div>
                    </div>

                    <div>
                      <label className="block text-sm font-semibold text-foreground mb-2">
                        Tipo de Carga
                      </label>
                      <select
                        className="w-full px-4 py-3 border-2 border-gray-300 dark:border-0 rounded-xl bg-card text-foreground focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500"
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
                    <label className="block text-sm font-semibold text-foreground mb-2">
                      Descrição da Carga
                    </label>
                    <textarea
                      rows={3}
                      placeholder="Descreva brevemente a carga a ser transportada..."
                      className="w-full px-4 py-3 border-2 border-gray-300 dark:border-0 rounded-xl bg-card text-foreground focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-green-500 resize-none"
                    />
                  </div>
                </div>

                {/* Seção Documentos Fiscais - Integrada */}
                <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                  {/* Card CTe */}
                  <div className="bg-card p-6 rounded-xl border-2 border-blue-200 dark:border-blue-800">
                    <div className="flex items-center justify-between mb-4">
                      <div className="flex items-center gap-3">
                        <div className="w-8 h-8 bg-gradient-to-br from-blue-500 to-blue-600 rounded-lg flex items-center justify-center">
                          <i className="fas fa-truck text-white text-sm"></i>
                        </div>
                        <h3 className="text-lg font-semibold text-foreground">
                          CTe
                        </h3>
                      </div>
                      <button
                        type="button"
                        onClick={() => {
                          const novosCTe = [...(dados.documentosCTe || []), ''];
                          onDadosChange({ ...dados, documentosCTe: novosCTe });
                        }}
                        className="flex items-center gap-2 px-3 py-1 bg-gradient-to-r from-blue-500 to-blue-600 text-white rounded-lg text-sm font-semibold hover:shadow-lg transition-all"
                      >
                        <i className="fas fa-plus text-xs"></i>
                        Adicionar
                      </button>
                    </div>

                    {dados.documentosCTe && dados.documentosCTe.length > 0 ? (
                      <div className="space-y-2 max-h-64 overflow-y-auto">
                        {dados.documentosCTe.map((chaveAcesso: string, index: number) => (
                          <div key={index} className="bg-blue-50 dark:bg-blue-900/20 p-3 rounded-lg border border-blue-200 dark:border-0">
                            <div className="flex items-center gap-2">
                              <div className="flex-1">
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
                                  placeholder="44 dígitos"
                                  className="w-full px-3 py-2 border border-blue-300 dark:border-blue-600 rounded-lg bg-card text-foreground text-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
                                  maxLength={44}
                                />
                                {chaveAcesso && chaveAcesso.length !== 44 && (
                                  <p className="text-red-500 text-xs mt-1">
                                    Deve ter 44 dígitos
                                  </p>
                                )}
                              </div>
                              <button
                                type="button"
                                onClick={() => {
                                  const novosCTe = dados.documentosCTe!.filter((_: string, i: number) => i !== index);
                                  onDadosChange({ ...dados, documentosCTe: novosCTe });
                                }}
                                className="text-red-500 hover:text-red-700 p-2"
                              >
                                <i className="fas fa-trash text-xs"></i>
                              </button>
                            </div>
                          </div>
                        ))}
                      </div>
                    ) : (
                      <div className="text-center py-6 border-2 border-dashed border-blue-300 dark:border-0 rounded-xl bg-blue-50 dark:bg-blue-900/10">
                        <i className="fas fa-truck text-blue-400 text-2xl mb-2"></i>
                        <p className="text-sm text-muted-foreground">Nenhum CTe</p>
                      </div>
                    )}
                  </div>

                  {/* Card NFe */}
                  <div className="bg-card p-6 rounded-xl border-2 border-green-200 dark:border-green-800">
                    <div className="flex items-center justify-between mb-4">
                      <div className="flex items-center gap-3">
                        <div className="w-8 h-8 bg-gradient-to-br from-green-500 to-green-600 rounded-lg flex items-center justify-center">
                          <i className="fas fa-file-invoice text-white text-sm"></i>
                        </div>
                        <h3 className="text-lg font-semibold text-foreground">
                          NFe
                        </h3>
                      </div>
                      <button
                        type="button"
                        onClick={() => {
                          const novosNFe = [...(dados.documentosNFe || []), ''];
                          onDadosChange({ ...dados, documentosNFe: novosNFe });
                        }}
                        className="flex items-center gap-2 px-3 py-1 bg-gradient-to-r from-green-500 to-green-600 text-white rounded-lg text-sm font-semibold hover:shadow-lg transition-all"
                      >
                        <i className="fas fa-plus text-xs"></i>
                        Adicionar
                      </button>
                    </div>

                    {dados.documentosNFe && dados.documentosNFe.length > 0 ? (
                      <div className="space-y-2 max-h-64 overflow-y-auto">
                        {dados.documentosNFe.map((chaveAcesso: string, index: number) => (
                          <div key={index} className="bg-green-50 dark:bg-green-900/20 p-3 rounded-lg border border-green-200 dark:border-0">
                            <div className="flex items-center gap-2">
                              <div className="flex-1">
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
                                  placeholder="44 dígitos"
                                  className="w-full px-3 py-2 border border-green-300 dark:border-green-600 rounded-lg bg-card text-foreground text-sm focus:outline-none focus:ring-2 focus:ring-green-500"
                                  maxLength={44}
                                />
                                {chaveAcesso && chaveAcesso.length !== 44 && (
                                  <p className="text-red-500 text-xs mt-1">
                                    Deve ter 44 dígitos
                                  </p>
                                )}
                              </div>
                              <button
                                type="button"
                                onClick={() => {
                                  const novosNFe = dados.documentosNFe!.filter((_: string, i: number) => i !== index);
                                  onDadosChange({ ...dados, documentosNFe: novosNFe });
                                }}
                                className="text-red-500 hover:text-red-700 p-2"
                              >
                                <i className="fas fa-trash text-xs"></i>
                              </button>
                            </div>
                          </div>
                        ))}
                      </div>
                    ) : (
                      <div className="text-center py-6 border-2 border-dashed border-green-300 dark:border-0 rounded-xl bg-green-50 dark:bg-green-900/10">
                        <i className="fas fa-file-invoice text-green-400 text-2xl mb-2"></i>
                        <p className="text-sm text-muted-foreground">Nenhuma NFe</p>
                      </div>
                    )}
                  </div>
                </div>
              </div>
            </div>
          )}

          {/* Etapa 4: Resumo Final */}
          {currentSection === 'resumo' && (
            <div>
              <div className="flex items-center mb-8">
                <div className="w-12 h-12 bg-gradient-to-br from-indigo-500 to-purple-600 rounded-xl flex items-center justify-center mr-4 shadow-lg">
                  <i className="fas fa-clipboard-check text-white text-lg"></i>
                </div>
                <div>
                  <h2 className="text-2xl font-bold text-foreground">Resumo do MDFe</h2>
                  <p className="text-muted-foreground mt-1">Revise todas as informações antes de salvar e transmitir</p>
                </div>
              </div>

              <div className="space-y-6">
                {/* Status Geral */}
                <div className="bg-gradient-to-r from-indigo-50 to-purple-50 dark:from-indigo-900/20 dark:to-purple-900/20 p-6 rounded-xl border border-indigo-200 dark:border-0">
                  <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
                    <div className="text-center">
                      <div className="w-16 h-16 bg-gradient-to-br from-blue-500 to-blue-600 rounded-full flex items-center justify-center mx-auto mb-3">
                        <i className="fas fa-file-alt text-white text-xl"></i>
                      </div>
                      <h3 className="font-bold text-foreground mb-1">Documento</h3>
                      <p className="text-sm text-muted-foreground">
                        {isEdicao ? 'Editando MDFe' : 'Novo MDFe'}
                      </p>
                    </div>
                    <div className="text-center">
                      <div className="w-16 h-16 bg-gradient-to-br from-green-500 to-green-600 rounded-full flex items-center justify-center mx-auto mb-3">
                        <i className="fas fa-check-circle text-white text-xl"></i>
                      </div>
                      <h3 className="font-bold text-foreground mb-1">Status</h3>
                      <p className="text-sm text-muted-foreground">
                        Pronto para transmissão
                      </p>
                    </div>
                  </div>
                </div>

                {/* Informações Principais */}
                <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
                  {/* Emitente */}
                  <div className="bg-card p-6 rounded-xl border border-gray-200 dark:border-0 shadow-sm">
                    <div className="flex items-center mb-4">
                      <div className="w-8 h-8 bg-blue-100 dark:bg-blue-900/50 rounded-lg flex items-center justify-center mr-3">
                        <i className="fas fa-building text-blue-600 dark:text-blue-400"></i>
                      </div>
                      <h3 className="text-lg font-semibold text-foreground">Emitente</h3>
                    </div>
                    <div className="space-y-2">
                      <div>
                        <span className="text-sm font-medium text-gray-500 dark:text-gray-400">Razão Social:</span>
                        <p className="text-foreground font-medium">
                          {(() => {
                            if (!selectedIds.emitenteId) return 'Não selecionado';
                            const emitente = entidadesCarregadas?.emitentes?.find((e: any) => e.id === selectedIds.emitenteId);
                            return emitente?.data?.razaoSocial || emitente?.data?.RazaoSocial || emitente?.label || 'Não informado';
                          })()}
                        </p>
                      </div>
                      <div>
                        <span className="text-sm font-medium text-gray-500 dark:text-gray-400">CNPJ:</span>
                        <p className="text-foreground">
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
                  <div className="bg-card p-6 rounded-xl border border-gray-200 dark:border-0 shadow-sm">
                    <div className="flex items-center mb-4">
                      <div className="w-8 h-8 bg-green-100 dark:bg-green-900/50 rounded-lg flex items-center justify-center mr-3">
                        <i className="fas fa-truck text-green-600 dark:text-green-400"></i>
                      </div>
                      <h3 className="text-lg font-semibold text-foreground">Transporte</h3>
                    </div>
                    <div className="space-y-2">
                      <div>
                        <span className="text-sm font-medium text-gray-500 dark:text-gray-400">Veículo:</span>
                        <p className="text-foreground font-medium">
                          {(() => {
                            if (!selectedIds.veiculoId) return 'Não selecionado';
                            const veiculo = entidadesCarregadas?.veiculos?.find((v: any) => v.id === selectedIds.veiculoId);
                            return veiculo?.data?.placa || veiculo?.data?.Placa || veiculo?.label?.split(' - ')[0] || 'Não informado';
                          })()}
                        </p>
                      </div>
                      <div>
                        <span className="text-sm font-medium text-gray-500 dark:text-gray-400">Condutor:</span>
                        <p className="text-foreground">
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
                          <p className="text-foreground">
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
                <div className="bg-card p-6 rounded-xl border border-gray-200 dark:border-0 shadow-sm">
                  <div className="flex items-center mb-4">
                    <div className="w-8 h-8 bg-purple-100 dark:bg-purple-900/50 rounded-lg flex items-center justify-center mr-3">
                      <i className="fas fa-map-marker-alt text-purple-600 dark:text-purple-400"></i>
                    </div>
                    <h3 className="text-lg font-semibold text-foreground">Localidades</h3>
                  </div>
                  <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                      <h4 className="font-medium text-foreground mb-2">Carregamento</h4>
                      {locaisCarregamento.length > 0 ? (
                        <div className="space-y-1">
                          {locaisCarregamento.map((local, index) => (
                            <p key={index} className="text-sm text-muted-foreground">
                              {local.municipio} - {local.uf}
                            </p>
                          ))}
                        </div>
                      ) : (
                        <p className="text-sm text-red-500">Nenhum local definido</p>
                      )}
                    </div>
                    <div>
                      <h4 className="font-medium text-foreground mb-2">Descarregamento</h4>
                      {locaisDescarregamento.length > 0 ? (
                        <div className="space-y-1">
                          {locaisDescarregamento.map((local, index) => (
                            <p key={index} className="text-sm text-muted-foreground">
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
                    <div className="mt-4 pt-4 border-t border-gray-200 dark:border-0">
                      <h4 className="font-medium text-foreground mb-2">Percurso Fiscal</h4>
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
                  <div className="bg-card p-6 rounded-xl border border-gray-200 dark:border-0 shadow-sm">
                    <div className="flex items-center mb-4">
                      <div className="w-8 h-8 bg-orange-100 dark:bg-orange-900/50 rounded-lg flex items-center justify-center mr-3">
                        <i className="fas fa-handshake text-orange-600 dark:text-orange-400"></i>
                      </div>
                      <h3 className="text-lg font-semibold text-foreground">Contratante</h3>
                    </div>
                    <div className="space-y-2">
                      <div>
                        <span className="text-sm font-medium text-gray-500 dark:text-gray-400">Empresa:</span>
                        <p className="text-foreground">
                          {(() => {
                            if (!selectedIds.contratanteId) return 'Não selecionado';
                            const contratante = entidadesCarregadas?.contratantes?.find((c: any) => c.id === selectedIds.contratanteId);
                            return contratante?.data?.razaoSocial || contratante?.data?.nome || contratante?.label || 'Não informado';
                          })()}
                        </p>
                      </div>
                    </div>
                  </div>

                  <div className="bg-card p-6 rounded-xl border border-gray-200 dark:border-0 shadow-sm">
                    <div className="flex items-center mb-4">
                      <div className="w-8 h-8 bg-teal-100 dark:bg-teal-900/50 rounded-lg flex items-center justify-center mr-3">
                        <i className="fas fa-shield-alt text-teal-600 dark:text-teal-400"></i>
                      </div>
                      <h3 className="text-lg font-semibold text-foreground">Seguradora</h3>
                    </div>
                    <div className="space-y-2">
                      <div>
                        <span className="text-sm font-medium text-gray-500 dark:text-gray-400">Empresa:</span>
                        <p className="text-foreground">
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
                  <div className="bg-card p-6 rounded-xl border border-gray-200 dark:border-0 shadow-sm">
                    <div className="flex items-center mb-4">
                      <div className="w-8 h-8 bg-emerald-100 dark:bg-emerald-900/50 rounded-lg flex items-center justify-center mr-3">
                        <i className="fas fa-boxes text-emerald-600 dark:text-emerald-400"></i>
                      </div>
                      <h3 className="text-lg font-semibold text-foreground">Informações da Carga</h3>
                    </div>
                    <div className="space-y-2">
                      <div>
                        <span className="text-sm font-medium text-gray-500 dark:text-gray-400">Valor:</span>
                        <p className="text-foreground font-medium">
                          {dados.valorTotal ? `R$ ${dados.valorTotal.toLocaleString('pt-BR', { minimumFractionDigits: 2 })}` : 'Não informado'}
                        </p>
                      </div>
                      <div>
                        <span className="text-sm font-medium text-gray-500 dark:text-gray-400">Peso:</span>
                        <p className="text-foreground">
                          {dados.pesoBrutoTotal ? `${dados.pesoBrutoTotal} kg` : 'Não informado'}
                        </p>
                      </div>
                    </div>
                  </div>

                  <div className="bg-card p-6 rounded-xl border border-gray-200 dark:border-0 shadow-sm">
                    <div className="flex items-center mb-4">
                      <div className="w-8 h-8 bg-red-100 dark:bg-red-900/50 rounded-lg flex items-center justify-center mr-3">
                        <i className="fas fa-file-invoice text-red-600 dark:text-red-400"></i>
                      </div>
                      <h3 className="text-lg font-semibold text-foreground">Documentos Fiscais</h3>
                    </div>
                    <div className="space-y-2">
                      <div>
                        <span className="text-sm font-medium text-gray-500 dark:text-gray-400">CTe:</span>
                        <p className="text-foreground">
                          {dados.documentosCTe?.length || 0} documento(s)
                        </p>
                      </div>
                      <div>
                        <span className="text-sm font-medium text-gray-500 dark:text-gray-400">NFe:</span>
                        <p className="text-foreground">
                          {dados.documentosNFe?.length || 0} documento(s)
                        </p>
                      </div>
                    </div>
                  </div>
                </div>

                {/* Validação */}
                <div className="bg-blue-50 dark:bg-blue-900/20 border border-blue-200 dark:border-0 rounded-xl p-6">
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
        <div className="bg-gray-50 dark:bg-gray-900 border-t-2 border-gray-200 dark:border-gray-700 mt-8 -mx-6 lg:-mx-8 px-6 lg:px-8 py-6 shadow-lg">
          <div className="flex justify-between items-center">
            {/* Botão Cancelar - Esquerda */}
            <button
              onClick={handleCancelar}
              disabled={salvando || transmitindo}
              className="px-6 py-3 rounded-lg font-semibold bg-gray-100 dark:bg-gray-700 text-gray-700 dark:text-gray-200 hover:bg-gray-200 dark:hover:bg-gray-600 border-2 border-gray-300 dark:border-gray-600 transition-all duration-200 disabled:opacity-50 disabled:cursor-not-allowed flex items-center gap-2"
            >
              <i className="fas fa-times"></i>
              Cancelar
            </button>

            {/* Botões Salvar/Transmitir - Direita */}
            <div className="flex items-center gap-3">
              <button
                onClick={onSalvar}
                disabled={salvando || transmitindo}
                className="px-8 py-3 bg-gradient-to-r from-green-500 to-emerald-600 text-white rounded-lg font-bold text-base hover:from-green-600 hover:to-emerald-700 shadow-lg hover:shadow-xl transition-all duration-200 disabled:opacity-50 disabled:cursor-not-allowed flex items-center gap-2"
              >
                {salvando ? (
                  <>
                    <i className="fas fa-spinner fa-spin"></i>
                    Salvando...
                  </>
                ) : (
                  <>
                    <i className="fas fa-save"></i>
                    Salvar MDFe
                  </>
                )}
              </button>
              {onTransmitir && currentSection === 'resumo' && (
                <button
                  onClick={onTransmitir}
                  disabled={salvando || transmitindo || !validarTudo()}
                  className="px-8 py-3 bg-gradient-to-r from-blue-500 to-indigo-600 text-white rounded-lg font-bold text-base hover:from-blue-600 hover:to-indigo-700 shadow-lg hover:shadow-xl transition-all duration-200 disabled:opacity-50 disabled:cursor-not-allowed flex items-center gap-2"
                  title={!validarTudo() ? 'Preencha todos os campos obrigatórios antes de transmitir' : ''}
                >
                  {transmitindo ? (
                    <>
                      <i className="fas fa-spinner fa-spin"></i>
                      Transmitindo...
                    </>
                  ) : (
                    <>
                      <i className="fas fa-paper-plane"></i>
                      Transmitir para SEFAZ
                    </>
                  )}
                </button>
              )}
            </div>
          </div>
        </div>

        {/* Modal de Confirmação de Cancelamento */}
        {showCancelModal && (
          <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
            <div className="bg-card rounded-xl shadow-2xl p-8 max-w-md w-full mx-4 border-2 border-gray-200 dark:border-gray-600">
              <div className="flex items-center gap-4 mb-6">
                <div className="w-12 h-12 bg-yellow-100 dark:bg-yellow-900/40 rounded-full flex items-center justify-center">
                  <i className="fas fa-exclamation-triangle text-yellow-600 dark:text-yellow-400 text-xl"></i>
                </div>
                <h3 className="text-xl font-bold text-foreground">Confirmar Cancelamento</h3>
              </div>

              <p className="text-muted-foreground mb-6 leading-relaxed">
                Você preencheu dados no formulário. Tem certeza que deseja cancelar? Todos os dados não salvos serão perdidos.
              </p>

              <div className="flex justify-end gap-3">
                <button
                  onClick={() => setShowCancelModal(false)}
                  className="px-4 py-2 rounded-lg font-medium bg-gray-100 dark:bg-gray-600 text-gray-700 dark:text-gray-200 hover:bg-gray-200 dark:hover:bg-gray-500 border border-gray-300 dark:border-gray-500 transition-all duration-200"
                >
                  Continuar editando
                </button>
                <button
                  onClick={confirmarCancelamento}
                  className="px-4 py-2 rounded-lg font-medium bg-red-500 text-white hover:bg-red-600 transition-all duration-200"
                >
                  Sim, cancelar
                </button>
              </div>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}