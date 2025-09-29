import React, { useState, useEffect } from 'react';
import { OptionalFieldsToggle, OptionalSection } from '../../../components/UI/Common/OptionalFieldsToggle';
import { ConfirmDeleteModal } from '../../../components/UI/Modal/ConfirmDeleteModal';
import { formatPlaca, cleanPlaca } from '../../../utils/formatters';
import { entitiesService } from '../../../services/entitiesService';
import Icon from '../../../components/UI/Icon';

interface Veiculo {
  id?: number;
  placa: string;
  tara: number;
  tipoRodado: string;
  tipoCarroceria: string;
  uf: string;
  ativo?: boolean;
}

interface PaginationData {
  totalItems: number;
  totalPages: number;
  currentPage: number;
  pageSize: number;
  hasNextPage: boolean;
  hasPreviousPage: boolean;
  startItem: number;
  endItem: number;
}

export function ListarVeiculos() {
  const [veiculos, setVeiculos] = useState<Veiculo[]>([]);
  const [carregando, setCarregando] = useState(false);
  const [filtro, setFiltro] = useState('');
  const [filtroTipo, setFiltroTipo] = useState('');
  const [filtroStatus, setFiltroStatus] = useState('');
  const [filtroUf, setFiltroUf] = useState('');

  // Estados para paginação
  const [paginaAtual, setPaginaAtual] = useState(1);
  const [tamanhoPagina, setTamanhoPagina] = useState(10);
  const [paginacao, setPaginacao] = useState<PaginationData | null>(null);

  // Estados do modal
  const [modalAberto, setModalAberto] = useState(false);
  const [modalVisualizacao, setModalVisualizacao] = useState(false);
  const [veiculoEdicao, setVeiculoEdicao] = useState<Veiculo | null>(null);
  const [veiculoVisualizacao, setVeiculoVisualizacao] = useState<Veiculo | null>(null);

  // Estados do modal de exclusão
  const [modalExclusao, setModalExclusao] = useState(false);
  const [veiculoExclusao, setVeiculoExclusao] = useState<Veiculo | null>(null);
  const [excludindo, setExcluindo] = useState(false);
  const [salvando, setSalvando] = useState(false);
  const [mostrarCamposOpcionais, setMostrarCamposOpcionais] = useState({
    dadosComplementares: false,
    detalhes: false,
    configuracoes: false
  });

  const [dadosModal, setDadosModal] = useState<Veiculo>({
    placa: '',
    tara: 0,
    tipoRodado: '',
    tipoCarroceria: '',
    uf: '',
    ativo: true
  });

  useEffect(() => {
    carregarVeiculos();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [paginaAtual, tamanhoPagina]);

  useEffect(() => {
    setPaginaAtual(1);
    carregarVeiculos(1, filtro);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [filtro]);

  const carregarVeiculos = async (pagina: number = paginaAtual, busca: string = filtro) => {
    try {
      setCarregando(true);

      const API_BASE_URL = process.env.REACT_APP_API_URL || 'https://localhost:5001/api';
      const params = new URLSearchParams({
        Page: pagina.toString(),
        PageSize: tamanhoPagina.toString()
      });

      if (busca.trim()) {
        params.append('Search', busca.trim());
      }

      const response = await fetch(`${API_BASE_URL}/veiculos?${params}`);

      if (!response.ok) {
        throw new Error('Erro ao carregar veículos');
      }

      const data: PaginationData & { items: Veiculo[] } = await response.json();

      setVeiculos(data.items || []);
      setPaginacao({
        totalItems: data.totalItems,
        totalPages: data.totalPages,
        currentPage: data.currentPage,
        pageSize: data.pageSize,
        hasNextPage: data.hasNextPage,
        hasPreviousPage: data.hasPreviousPage,
        startItem: data.startItem,
        endItem: data.endItem
      });
    } catch (error) {
      console.error('Erro ao carregar veículos:', error);
      setVeiculos([]);
      setPaginacao(null);
    } finally {
      setCarregando(false);
    }
  };

  const abrirModalNovo = () => {
    setVeiculoEdicao(null);
    setDadosModal({
      placa: '',
      tara: 0,
      tipoRodado: '',
      tipoCarroceria: '',
      uf: '',
        ativo: true
    });
    setModalAberto(true);
  };

  const abrirModalEdicao = (veiculo: Veiculo) => {
    setVeiculoEdicao(veiculo);
    setDadosModal(veiculo);
    setModalAberto(true);
  };

  const abrirModalVisualizacao = (veiculo: Veiculo) => {
    setVeiculoVisualizacao(veiculo);
    setModalVisualizacao(true);
  };

  const fecharModal = () => {
    setModalAberto(false);
    setVeiculoEdicao(null);
    setMostrarCamposOpcionais({
      dadosComplementares: false,
      detalhes: false,
      configuracoes: false
    });
  };

  const fecharModalVisualizacao = () => {
    setModalVisualizacao(false);
    setVeiculoVisualizacao(null);
  };

  const toggleCampoOpcional = (campo: keyof typeof mostrarCamposOpcionais) => {
    setMostrarCamposOpcionais(prev => ({
      ...prev,
      [campo]: !prev[campo]
    }));
  };

  const salvarVeiculo = async (e: React.FormEvent) => {
    e.preventDefault();
    setSalvando(true);

    try {
      // Limpar dados antes do envio
      const dadosLimpos = {
        ...dadosModal,
        placa: dadosModal.placa.trim().toUpperCase(),
        uf: dadosModal.uf.toUpperCase()
      };

      let resposta;
      if (veiculoEdicao?.id) {
        // Atualizar existente
        resposta = await entitiesService.atualizarVeiculo(veiculoEdicao.id, dadosLimpos);
      } else {
        // Criar novo
        resposta = await entitiesService.criarVeiculo(dadosLimpos);
      }

      if (resposta.sucesso) {
        fecharModal();
        carregarVeiculos(); // Recarregar lista do backend
      } else {
        alert(`Erro ao salvar veículo: ${resposta.mensagem}`);
      }
    } catch (error) {
      console.error('Erro ao salvar veículo:', error);
      alert('Erro inesperado ao salvar veículo. Verifique os dados e tente novamente.');
    } finally {
      setSalvando(false);
    }
  };

  const abrirModalExclusao = (veiculo: Veiculo) => {
    setVeiculoExclusao(veiculo);
    setModalExclusao(true);
  };

  const fecharModalExclusao = () => {
    setModalExclusao(false);
    setVeiculoExclusao(null);
    setExcluindo(false);
  };

  const confirmarExclusao = async () => {
    if (!veiculoExclusao?.id) return;

    try {
      setExcluindo(true);
      const resposta = await entitiesService.excluirVeiculo(veiculoExclusao.id);

      if (resposta.sucesso) {
        fecharModalExclusao();
        carregarVeiculos(); // Recarregar lista do backend
      } else {
        alert(`Erro ao excluir veículo: ${resposta.mensagem}`);
        setExcluindo(false);
      }
    } catch (error) {
      console.error('Erro ao excluir veículo:', error);
      alert('Erro inesperado ao excluir veículo. Tente novamente.');
      setExcluindo(false);
    }
  };

  const veiculosFiltrados = veiculos.filter(veiculo => {
    // Filtro de tipo
    const tipoMatch = !filtroTipo || veiculo.tipoRodado === filtroTipo;

    // Filtro de status
    const statusMatch = !filtroStatus ||
      (filtroStatus === 'ativo' && veiculo.ativo) ||
      (filtroStatus === 'inativo' && !veiculo.ativo);

    // Filtro de UF
    const ufMatch = !filtroUf || veiculo.uf === filtroUf;

    return tipoMatch && statusMatch && ufMatch;
  });

  const limparFiltros = () => {
    setFiltro('');
    setFiltroTipo('');
    setFiltroStatus('');
    setFiltroUf('');
  };

  // Renderizar modal inline
  const renderModal = () => {
    if (!modalAberto) return null;

    return (
      <div className="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50 backdrop-blur-sm">
        <div className="bg-bg-surface rounded-xl border border-border-primary shadow-xl max-w-md w-full mx-4 max-h-[90vh] overflow-y-auto">
          <div className="flex items-center justify-between p-6 border-b border-border-primary">
            <h2 className="text-xl font-semibold text-text-primary">{veiculoEdicao ? 'Editar Veículo' : 'Novo Veículo'}</h2>
            <button className="text-text-secondary hover:text-text-primary text-2xl font-bold w-8 h-8 flex items-center justify-center" onClick={fecharModal}>×</button>
          </div>

          <form id="veiculo-form" onSubmit={salvarVeiculo} className="p-6 space-y-6">
            <div className="space-y-4">
              <h3 className="text-lg font-medium text-text-primary">Dados Principais</h3>

              <div className="grid grid-cols-1 gap-4">
                <div>
                  <label className="block text-sm font-medium text-text-primary mb-2">Placa *</label>
                  <input
                    type="text"
                    value={formatPlaca(dadosModal.placa)}
                    onChange={(e) => setDadosModal({ ...dadosModal, placa: cleanPlaca(e.target.value) })}
                    placeholder="ABC-1234"
                    maxLength={8}
                    required
                    className="w-full px-3 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary placeholder-text-secondary focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent"
                  />
                </div>
              </div>

              <div className="grid grid-cols-1 gap-4">
                <div>
                  <label className="block text-sm font-medium text-text-primary mb-2">Marca *</label>
                  <input
                    type="text"
                    value={dadosModal.tipoCarroceria}
                    onChange={(e) => setDadosModal({ ...dadosModal, tipoCarroceria: e.target.value })}
                    maxLength={100}
                    required
                    className="w-full px-3 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary placeholder-text-secondary focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent"
                  />
                </div>
              </div>

              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <label className="block text-sm font-medium text-text-primary mb-2">Tipo de Rodado *</label>
                  <select
                    value={dadosModal.tipoRodado}
                    onChange={(e) => setDadosModal({ ...dadosModal, tipoRodado: e.target.value })}
                    required
                    className="w-full px-3 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent"
                  >
                    <option value="">Selecione</option>
                    <option value="01">01 - Truck</option>
                    <option value="02">02 - Toco</option>
                    <option value="03">03 - Cavalo Mecânico</option>
                    <option value="04">04 - VAN</option>
                    <option value="05">05 - Utilitário</option>
                    <option value="06">06 - Outros</option>
                  </select>
                </div>

                <div>
                  <label className="block text-sm font-medium text-text-primary mb-2">UF *</label>
                  <select
                    value={dadosModal.uf}
                    onChange={(e) => setDadosModal({ ...dadosModal, uf: e.target.value })}
                    required
                    className="w-full px-3 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent"
                  >
                    <option value="">Selecione</option>
                    <option value="AC">AC</option>
                    <option value="AL">AL</option>
                    <option value="AP">AP</option>
                    <option value="AM">AM</option>
                    <option value="BA">BA</option>
                    <option value="CE">CE</option>
                    <option value="DF">DF</option>
                    <option value="ES">ES</option>
                    <option value="GO">GO</option>
                    <option value="MA">MA</option>
                    <option value="MT">MT</option>
                    <option value="MS">MS</option>
                    <option value="MG">MG</option>
                    <option value="PA">PA</option>
                    <option value="PB">PB</option>
                    <option value="PR">PR</option>
                    <option value="PE">PE</option>
                    <option value="PI">PI</option>
                    <option value="RJ">RJ</option>
                    <option value="RN">RN</option>
                    <option value="RS">RS</option>
                    <option value="RO">RO</option>
                    <option value="RR">RR</option>
                    <option value="SC">SC</option>
                    <option value="SP">SP</option>
                    <option value="SE">SE</option>
                    <option value="TO">TO</option>
                  </select>
                </div>
              </div>
            </div>

            <OptionalFieldsToggle
              label="Dados Complementares"
              description="Capacidade, tara e outras informações"
              isExpanded={mostrarCamposOpcionais.dadosComplementares}
              onToggle={() => toggleCampoOpcional('dadosComplementares')}
              icon="fas fa-address-book"
            />

            <OptionalSection isVisible={mostrarCamposOpcionais.dadosComplementares}>
              <div className="grid grid-cols-1 gap-4">
                <div>
                  <label className="block text-sm font-medium text-text-primary mb-2">Tara (kg) *</label>
                  <input
                    type="number"
                    value={dadosModal.tara}
                    onChange={(e) => setDadosModal({ ...dadosModal, tara: Number(e.target.value) })}
                    min="0"
                    required
                    className="w-full px-3 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary placeholder-text-secondary focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent"
                  />
                </div>
              </div>

              <div className="grid grid-cols-1 gap-4">
                <div>
                  <label className="block text-sm font-medium text-text-primary mb-2">Tipo de Carroceria *</label>
                  <select
                    value={dadosModal.tipoCarroceria}
                    onChange={(e) => setDadosModal({ ...dadosModal, tipoCarroceria: e.target.value })}
                    required
                    className="w-full px-3 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent"
                  >
                    <option value="">Selecione</option>
                    <option value="00">00 - Não aplicável</option>
                    <option value="01">01 - Aberta</option>
                    <option value="02">02 - Fechada/baú</option>
                    <option value="03">03 - Graneleira</option>
                    <option value="04">04 - Porta Container</option>
                    <option value="05">05 - Sider</option>
                  </select>
                </div>
              </div>

            </OptionalSection>

            {veiculoEdicao && (
              <>
                <OptionalFieldsToggle
                  label="Configurações"
                  description="Status e configurações do veículo"
                  isExpanded={mostrarCamposOpcionais.configuracoes}
                  onToggle={() => toggleCampoOpcional('configuracoes')}
                  icon="fas fa-cog"
                />

                <OptionalSection isVisible={mostrarCamposOpcionais.configuracoes}>
                  <div className="grid grid-cols-1 gap-4">
                    <div>
                      <label className="block text-sm font-medium text-text-primary mb-2">Status</label>
                      <select
                        value={dadosModal.ativo ? 'true' : 'false'}
                        onChange={(e) => setDadosModal({ ...dadosModal, ativo: e.target.value === 'true' })}
                        className="w-full px-3 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent"
                      >
                        <option value="true">Ativo</option>
                        <option value="false">Inativo</option>
                      </select>
                    </div>
                  </div>
                </OptionalSection>
              </>
            )}
          </form>

          <div className="flex items-center justify-end gap-3 p-6 border-t border-border-primary">
            <button type="button" onClick={fecharModal} className="px-4 py-2 border border-border-primary text-text-secondary hover:text-text-primary hover:border-text-primary rounded-lg font-medium transition-colors">
              Cancelar
            </button>
            <button type="submit" form="veiculo-form" className="px-4 py-2 bg-primary hover:bg-primary-hover text-white rounded-lg font-medium disabled:opacity-50 disabled:cursor-not-allowed transition-colors" disabled={salvando}>
              {salvando ? 'Salvando...' : (veiculoEdicao ? 'Atualizar' : 'Salvar')}
            </button>
          </div>
        </div>
      </div>
    );
  };

  // Renderizar modal de visualização
  const renderModalVisualizacao = () => {
    if (!modalVisualizacao || !veiculoVisualizacao) return null;

    return (
      <div className="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50 backdrop-blur-sm">
        <div className="bg-bg-surface rounded-xl border border-border-primary shadow-xl max-w-md w-full mx-4 max-h-[90vh] overflow-y-auto">
          <div className="flex items-center justify-between p-6 border-b border-border-primary">
            <h2 className="text-xl font-semibold text-text-primary">Visualizar Veículo</h2>
            <button className="text-text-secondary hover:text-text-primary text-2xl font-bold w-8 h-8 flex items-center justify-center" onClick={fecharModalVisualizacao}>×</button>
          </div>

          <div className="p-6 space-y-6">
            <div className="space-y-4">
              <h3 className="text-lg font-medium text-text-primary">Dados Principais</h3>
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <div className="space-y-1">
                  <label className="text-sm font-medium text-text-secondary">Placa:</label>
                  <span className="text-text-primary">{veiculoVisualizacao.placa}</span>
                </div>
                <div className="space-y-1">
                  <label className="text-sm font-medium text-text-secondary">Marca:</label>
                  <span className="text-text-primary">{veiculoVisualizacao.tipoCarroceria}</span>
                </div>
                <div className="space-y-1">
                  <label className="text-sm font-medium text-text-secondary">Tipo de Rodado:</label>
                  <span className="text-text-primary">{veiculoVisualizacao.tipoRodado}</span>
                </div>
                <div className="space-y-1">
                  <label className="text-sm font-medium text-text-secondary">UF:</label>
                  <span className="text-text-primary">{veiculoVisualizacao.uf}</span>
                </div>
              </div>
            </div>

            {(veiculoVisualizacao.tara || veiculoVisualizacao.tipoCarroceria) && (
              <div className="space-y-4">
                <h3 className="text-lg font-medium text-text-primary">Dados Complementares</h3>
                <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                  <div className="space-y-1">
                    <label className="text-sm font-medium text-text-secondary">Tara:</label>
                    <span className="text-text-primary">{veiculoVisualizacao.tara.toLocaleString()} kg</span>
                  </div>
                  <div className="space-y-1">
                    <label className="text-sm font-medium text-text-secondary">Tipo de Carroceria:</label>
                    <span className="text-text-primary">{veiculoVisualizacao.tipoCarroceria}</span>
                  </div>
                </div>
              </div>
            )}

            <div className="space-y-4">
              <h3 className="text-lg font-medium text-text-primary">Configurações</h3>
              <div className="grid grid-cols-1 gap-4">
                <div className="space-y-1">
                  <label className="text-sm font-medium text-text-secondary">Status:</label>
                  <span className={`inline-flex items-center px-2 py-1 rounded-full text-xs font-medium ${veiculoVisualizacao.ativo ? 'bg-success/20 text-success' : 'bg-error/20 text-error'}`}>
                    {veiculoVisualizacao.ativo ? 'Ativo' : 'Inativo'}
                  </span>
                </div>
              </div>
            </div>
          </div>

          <div className="flex items-center justify-end gap-3 p-6 border-t border-border-primary">
            <button onClick={fecharModalVisualizacao} className="px-4 py-2 border border-border-primary text-text-secondary hover:text-text-primary hover:border-text-primary rounded-lg font-medium transition-colors">
              Fechar
            </button>
            <button
              onClick={() => {
                fecharModalVisualizacao();
                abrirModalEdicao(veiculoVisualizacao);
              }}
              className="px-4 py-2 bg-primary hover:bg-primary-hover text-white rounded-lg font-medium transition-colors"
            >
              Editar
            </button>
          </div>
        </div>
      </div>
    );
  };

  if (carregando) {
    return (
      <div className="max-w-7xl mx-auto px-6 py-8">
        <div className="flex items-center justify-center py-12">
          <div className="text-text-secondary">Carregando veículos...</div>
        </div>
      </div>
    );
  }

  return (
    <div className="max-w-7xl mx-auto px-6 py-8">
      <div className="flex items-center justify-between mb-8">
        <h1 className="text-2xl font-bold text-text-primary flex items-center gap-3">
          <i className="fas fa-truck text-primary"></i>
          Veículos
        </h1>
        <button className="px-4 py-2 bg-primary hover:bg-primary-hover text-white rounded-lg font-medium transition-colors flex items-center gap-2" onClick={abrirModalNovo}>
          <Icon name="plus" />
          Novo Veículo
        </button>
      </div>

      <div className="bg-bg-surface rounded-xl border border-border-primary p-6 mb-6">
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 xl:grid-cols-5 gap-4 items-end">
          <div>
            <label className="block text-sm font-medium text-text-primary mb-2">Buscar</label>
            <input
              type="text"
              placeholder="Placa ou carroceria..."
              value={filtro}
              onChange={(e) => {
                setFiltro(e.target.value);
              }}
              className="w-full px-3 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary placeholder-text-secondary focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent"
            />
          </div>

          <div>
            <label className="block text-sm font-medium text-text-primary mb-2">Tipo</label>
            <select
              value={filtroTipo}
              onChange={(e) => setFiltroTipo(e.target.value)}
              className="w-full px-3 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent"
            >
              <option value="">Todos os tipos</option>
              <option value="01">01 - Truck</option>
              <option value="02">02 - Toco</option>
              <option value="03">03 - Cavalo Mecânico</option>
              <option value="04">04 - VAN</option>
              <option value="05">05 - Utilitário</option>
              <option value="06">06 - Outros</option>
            </select>
          </div>

          <div>
            <label className="block text-sm font-medium text-text-primary mb-2">Status</label>
            <select
              value={filtroStatus}
              onChange={(e) => setFiltroStatus(e.target.value)}
              className="w-full px-3 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent"
            >
              <option value="">Todos os status</option>
              <option value="ativo">Ativo</option>
              <option value="inativo">Inativo</option>
            </select>
          </div>

          <div>
            <label className="block text-sm font-medium text-text-primary mb-2">UF</label>
            <select
              value={filtroUf}
              onChange={(e) => setFiltroUf(e.target.value)}
              className="w-full px-3 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent"
            >
              <option value="">Todas as UF</option>
              <option value="AC">AC</option>
              <option value="AL">AL</option>
              <option value="AP">AP</option>
              <option value="AM">AM</option>
              <option value="BA">BA</option>
              <option value="CE">CE</option>
              <option value="DF">DF</option>
              <option value="ES">ES</option>
              <option value="GO">GO</option>
              <option value="MA">MA</option>
              <option value="MT">MT</option>
              <option value="MS">MS</option>
              <option value="MG">MG</option>
              <option value="PA">PA</option>
              <option value="PB">PB</option>
              <option value="PR">PR</option>
              <option value="PE">PE</option>
              <option value="PI">PI</option>
              <option value="RJ">RJ</option>
              <option value="RN">RN</option>
              <option value="RS">RS</option>
              <option value="RO">RO</option>
              <option value="RR">RR</option>
              <option value="SC">SC</option>
              <option value="SP">SP</option>
              <option value="SE">SE</option>
              <option value="TO">TO</option>
            </select>
          </div>

          <button
            onClick={limparFiltros}
            className="px-4 py-2 border border-border-primary text-text-secondary hover:text-text-primary hover:border-text-primary rounded-lg font-medium transition-colors"
          >
            Limpar Filtros
          </button>
        </div>
      </div>

      <div className="bg-bg-surface rounded-xl border border-border-primary shadow-sm">
        {veiculosFiltrados.length === 0 ? (
          <div className="flex flex-col items-center justify-center py-12 px-6 text-center">
            <h3 className="text-lg font-medium text-text-primary mb-2">Nenhum veículo encontrado</h3>
            <p className="text-text-secondary">Adicione um novo veículo para começar.</p>
          </div>
        ) : (
          <div className="overflow-x-auto">
            <div className="grid grid-cols-6 gap-4 p-4 border-b border-border-primary bg-bg-hover text-sm font-medium text-text-secondary">
              <div>Placa</div>
              <div>Veículo</div>
              <div>Tipo</div>
              <div>Localização</div>
              <div>Status</div>
              <div>Ações</div>
            </div>

            {veiculosFiltrados.map((veiculo) => (
              <div key={veiculo.id} className="grid grid-cols-6 gap-4 p-4 border-b border-border-primary hover:bg-bg-hover transition-colors">
                <div className="flex items-center">
                  <span className="font-medium text-text-primary">{veiculo.placa}</span>
                </div>
                <div className="flex flex-col">
                  <span className="font-medium text-text-primary">{veiculo.tipoCarroceria}</span>
                  <span className="text-sm text-text-secondary">Tara: {veiculo.tara.toLocaleString()}kg</span>
                </div>
                <div className="flex items-center">
                  <span className="inline-flex items-center px-2 py-1 rounded-md text-xs font-medium bg-primary/10 text-primary">
                    Tipo {veiculo.tipoRodado}
                  </span>
                </div>
                <div className="flex items-center">
                  <span className="font-medium text-text-primary">{veiculo.uf}</span>
                </div>
                <div className="flex items-center">
                  <span className={`inline-flex items-center px-2 py-1 rounded-full text-xs font-medium ${veiculo.ativo ? 'bg-success/20 text-success' : 'bg-error/20 text-error'}`}>
                    {veiculo.ativo ? 'Ativo' : 'Inativo'}
                  </span>
                </div>
                <div className="flex items-center gap-2">
                  <button
                    className="text-xs px-2 py-1 border border-border-primary text-text-secondary hover:text-text-primary hover:border-text-primary rounded transition-colors"
                    onClick={() => abrirModalVisualizacao(veiculo)}
                  >
                    Visualizar
                  </button>
                  <button
                    className="text-xs px-2 py-1 bg-primary hover:bg-primary-hover text-white rounded transition-colors"
                    onClick={() => abrirModalEdicao(veiculo)}
                  >
                    Editar
                  </button>
                  <button
                    className="text-xs px-2 py-1 bg-error hover:bg-error/80 text-white rounded transition-colors"
                    onClick={() => abrirModalExclusao(veiculo)}
                  >
                    Excluir
                  </button>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>

      {/* Paginação */}
      {paginacao && paginacao.totalItems > 0 && (
        <div className="mt-6 bg-bg-surface rounded-xl border border-border-primary p-6">
          <div className="flex flex-col sm:flex-row items-center justify-between gap-4">
            <div className="text-sm text-text-secondary">
              Mostrando {((paginacao.currentPage - 1) * paginacao.pageSize) + 1} até {Math.min(paginacao.currentPage * paginacao.pageSize, paginacao.totalItems)} de {paginacao.totalItems} veículos
            </div>

            {paginacao.totalPages > 1 && (
              <div className="flex items-center gap-2">
                <button
                  onClick={() => setPaginaAtual(paginacao.currentPage - 1)}
                  disabled={!paginacao.hasPreviousPage}
                  className="px-3 py-2 border border-border-primary text-text-secondary hover:text-text-primary hover:border-text-primary rounded-lg transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
                >
                  ← Anterior
                </button>

                <span className="px-4 py-2 text-sm text-text-primary">
                  Página {paginacao.currentPage} de {paginacao.totalPages}
                </span>

                <button
                  onClick={() => setPaginaAtual(paginacao.currentPage + 1)}
                  disabled={!paginacao.hasNextPage}
                  className="px-3 py-2 border border-border-primary text-text-secondary hover:text-text-primary hover:border-text-primary rounded-lg transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
                >
                  Próxima →
                </button>
              </div>
            )}

            <div className="flex items-center gap-2">
              <label className="text-sm text-text-secondary">Itens por página:</label>
              <select
                value={tamanhoPagina}
                onChange={(e) => {
                  setTamanhoPagina(Number(e.target.value));
                  setPaginaAtual(1);
                }}
                className="px-2 py-1 border border-border-primary rounded bg-bg-surface text-text-primary text-sm focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent"
              >
                <option value={1}>1</option>
                <option value={2}>2</option>
                <option value={5}>5</option>
                <option value={10}>10</option>
                <option value={20}>20</option>
              </select>
            </div>
          </div>
        </div>
      )}

      {renderModal()}
      {renderModalVisualizacao()}

      <ConfirmDeleteModal
        isOpen={modalExclusao}
        title="Excluir Veículo"
        message="Tem certeza de que deseja excluir este veículo?"
        itemName={veiculoExclusao ? `${formatPlaca(veiculoExclusao.placa)} - ${veiculoExclusao.tipoCarroceria}` : ''}
        onConfirm={confirmarExclusao}
        onCancel={fecharModalExclusao}
        loading={excludindo}
      />
    </div>
  );
}