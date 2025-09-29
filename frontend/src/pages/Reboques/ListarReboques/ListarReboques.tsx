import React, { useState, useEffect } from 'react';
import { ConfirmDeleteModal } from '../../../components/UI/Modal/ConfirmDeleteModal';
import { reboquesService, ReboqueList, ReboqueDetail, ReboqueCreate, ReboqueUpdate } from '../../../services/reboquesService';
import Icon from '../../../components/UI/Icon';

interface PaginationData {
  totalItems: number;
  totalPages: number;
  currentPage: number;
  pageSize: number;
  hasNextPage: boolean;
  hasPreviousPage: boolean;
}

export function ListarReboques() {
  const [reboques, setReboques] = useState<ReboqueList[]>([]);
  const [carregando, setCarregando] = useState(false);
  const [filtro, setFiltro] = useState('');
  const [filtroUf, setFiltroUf] = useState('');
  const [filtroStatus, setFiltroStatus] = useState('');

  // Estados para paginação
  const [paginaAtual, setPaginaAtual] = useState(1);
  const [tamanhoPagina, setTamanhoPagina] = useState(10);
  const [paginacao, setPaginacao] = useState<PaginationData | null>(null);

  // Estados do modal
  const [modalAberto, setModalAberto] = useState(false);
  const [modalVisualizacao, setModalVisualizacao] = useState(false);
  const [reboqueEdicao, setReboqueEdicao] = useState<ReboqueDetail | null>(null);
  const [reboqueVisualizacao, setReboqueVisualizacao] = useState<ReboqueDetail | null>(null);

  // Estados do modal de exclusão
  const [modalExclusao, setModalExclusao] = useState(false);
  const [reboqueExclusao, setReboqueExclusao] = useState<ReboqueList | null>(null);
  const [excludindo, setExcluindo] = useState(false);

  const [dadosModal, setDadosModal] = useState<ReboqueCreate>({
    placa: '',
    tara: 0,
    tipoRodado: '',
    tipoCarroceria: '',
    uf: '',
    rntrc: ''
  });

  useEffect(() => {
    carregarReboques();
  }, [paginaAtual, tamanhoPagina]);

  useEffect(() => {
    setPaginaAtual(1);
    carregarReboques(1, filtro);
  }, [filtro]);

  const carregarReboques = async (pagina: number = paginaAtual, busca: string = filtro) => {
    try {
      setCarregando(true);

      const response = await reboquesService.listarReboques(
        pagina,
        tamanhoPagina,
        busca || undefined,
        'placa',
        'asc'
      );

      if (response.sucesso && response.data) {
        setReboques(response.data.data);
        setPaginacao({
          totalItems: response.data.totalItems,
          totalPages: response.data.totalPages,
          currentPage: response.data.currentPage,
          pageSize: response.data.pageSize,
          hasNextPage: response.data.hasNextPage,
          hasPreviousPage: response.data.hasPreviousPage
        });
      } else {
        console.error('Erro ao carregar reboques:', response.mensagem);
        setReboques([]);
      }
    } catch (error) {
      console.error('Erro ao carregar reboques:', error);
      setReboques([]);
    } finally {
      setCarregando(false);
    }
  };

  const abrirModalNovo = () => {
    setReboqueEdicao(null);
    setDadosModal({
      placa: '',
      tara: 0,
      tipoRodado: '',
      tipoCarroceria: '',
      uf: '',
      rntrc: ''
    });
    setModalAberto(true);
  };

  const abrirModalEdicao = async (reboque: ReboqueList) => {
    try {
      const response = await reboquesService.buscarReboque(reboque.id);
      if (response.sucesso && response.data) {
        setReboqueEdicao(response.data);
        setDadosModal({
          placa: response.data.placa,
          tara: response.data.tara,
          tipoRodado: response.data.tipoRodado,
          tipoCarroceria: response.data.tipoCarroceria,
          uf: response.data.uf,
          rntrc: response.data.rntrc || ''
        });
        setModalAberto(true);
      }
    } catch (error) {
      console.error('Erro ao buscar reboque:', error);
    }
  };

  const abrirModalVisualizacao = async (reboque: ReboqueList) => {
    try {
      const response = await reboquesService.buscarReboque(reboque.id);
      if (response.sucesso && response.data) {
        setReboqueVisualizacao(response.data);
        setModalVisualizacao(true);
      }
    } catch (error) {
      console.error('Erro ao buscar reboque:', error);
    }
  };

  const fecharModal = () => {
    setModalAberto(false);
    setReboqueEdicao(null);
  };

  const fecharModalVisualizacao = () => {
    setModalVisualizacao(false);
    setReboqueVisualizacao(null);
  };

  const salvarReboque = async (e: React.FormEvent) => {
    e.preventDefault();

    try {
      let resposta;
      if (reboqueEdicao?.id) {
        resposta = await reboquesService.atualizarReboque(reboqueEdicao.id, dadosModal);
      } else {
        resposta = await reboquesService.criarReboque(dadosModal);
      }

      if (resposta.sucesso) {
        fecharModal();
        carregarReboques();
        alert(resposta.mensagem);
      } else {
        alert(`Erro ao salvar reboque: ${resposta.mensagem}`);
      }
    } catch (error) {
      console.error('Erro ao salvar reboque:', error);
      alert('Erro ao salvar reboque');
    }
  };

  const abrirModalExclusao = (reboque: ReboqueList) => {
    setReboqueExclusao(reboque);
    setModalExclusao(true);
  };

  const fecharModalExclusao = () => {
    setModalExclusao(false);
    setReboqueExclusao(null);
    setExcluindo(false);
  };

  const confirmarExclusao = async () => {
    if (!reboqueExclusao) return;

    try {
      setExcluindo(true);
      const resposta = await reboquesService.excluirReboque(reboqueExclusao.id);

      if (resposta.sucesso) {
        fecharModalExclusao();
        carregarReboques();
        alert(resposta.mensagem);
      } else {
        alert(`Erro ao excluir reboque: ${resposta.mensagem}`);
        setExcluindo(false);
      }
    } catch (error) {
      console.error('Erro ao excluir reboque:', error);
      alert('Erro ao excluir reboque');
      setExcluindo(false);
    }
  };

  const limparFiltros = () => {
    setFiltro('');
    setFiltroUf('');
    setFiltroStatus('');
    setPaginaAtual(1);
    carregarReboques(1, '');
  };

  const formatarData = (dataString: string) => {
    const data = new Date(dataString);
    return data.toLocaleDateString('pt-BR', {
      day: '2-digit',
      month: '2-digit',
      year: 'numeric'
    });
  };

  const formatarPlaca = (placa: string) => {
    return reboquesService.formatarPlaca(placa);
  };

  const formatarTara = (tara: number) => {
    return reboquesService.formatarTara(tara);
  };

  const aplicarFiltros = () => {
    let reboquesFiltraods = [...reboques];

    if (filtroUf) {
      reboquesFiltraods = reboquesFiltraods.filter(reboque => reboque.uf === filtroUf);
    }

    if (filtroStatus) {
      const isAtivo = filtroStatus === 'ativo';
      reboquesFiltraods = reboquesFiltraods.filter(reboque => reboque.ativo === isAtivo);
    }

    return reboquesFiltraods;
  };

  const reboquesFiltrados = aplicarFiltros();

  return (
    <div className="max-w-7xl mx-auto px-6 py-8">
      {/* Header */}
      <div className="flex items-center justify-between mb-8">
        <h1>
          <i className="fas fa-truck"></i>
          Gestão de Reboques
        </h1>
        <button className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary-hover font-medium transition-colors duration-200 flex items-center gap-2" onClick={abrirModalNovo}>
          <i className="fas fa-plus"></i>
          Novo Reboque
        </button>
      </div>

      {/* Filtros */}
      <div className="bg-bg-surface rounded-xl border border-border-primary p-6 mb-6">
        <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
          <div className="space-y-2">
            <label className="text-sm font-medium text-text-primary">Buscar</label>
            <input
              type="text"
              value={filtro}
              onChange={(e) => setFiltro(e.target.value)}
              placeholder="Placa ou RNTRC..."
              className="w-full px-3 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary focus:outline-none focus:ring-2 focus:ring-primary"
            />
          </div>

          <div className="space-y-2">
            <label className="text-sm font-medium text-text-primary">UF</label>
            <select
              value={filtroUf}
              onChange={(e) => setFiltroUf(e.target.value)}
              className="w-full px-3 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary focus:outline-none focus:ring-2 focus:ring-primary"
            >
              <option value="">Todos os estados</option>
              {reboquesService.getEstados().map(estado => (
                <option key={estado.value} value={estado.value}>
                  {estado.label}
                </option>
              ))}
            </select>
          </div>

          <div className="space-y-2">
            <label className="text-sm font-medium text-text-primary">Status</label>
            <select
              value={filtroStatus}
              onChange={(e) => setFiltroStatus(e.target.value)}
              className="w-full px-3 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary focus:outline-none focus:ring-2 focus:ring-primary"
            >
              <option value="">Todos</option>
              <option value="ativo">Ativo</option>
              <option value="inativo">Inativo</option>
            </select>
          </div>

          <button className="px-4 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary hover:bg-bg-surface-hover transition-colors duration-200" onClick={limparFiltros}>
            Limpar
          </button>
        </div>
      </div>

      {/* Tabela */}
      <div className="bg-bg-surface rounded-xl border border-border-primary shadow-sm">
        {carregando ? (
          <div className="flex items-center justify-center py-16">
            <div className="flex items-center gap-4">
              <div className="w-8 h-8 border-4 border-primary border-t-transparent rounded-full animate-spin"></div>
              <span className="text-text-secondary">Carregando reboques...</span>
            </div>
          </div>
        ) : reboquesFiltrados.length === 0 ? (
          <div className="flex flex-col items-center justify-center py-16 px-6">
            <div className="w-16 h-16 bg-bg-tertiary rounded-full flex items-center justify-center mb-4">
              <i className="fas fa-truck text-2xl text-text-tertiary"></i>
            </div>
            <h3 className="text-lg font-semibold text-text-primary mb-2">Nenhum reboque encontrado</h3>
            <p className="text-text-secondary text-center">Tente ajustar os filtros ou cadastre um novo reboque.</p>
          </div>
        ) : (
          <>
            <div className="overflow-x-auto">
              <div className="grid grid-cols-9 gap-4 p-4 bg-bg-tertiary border-b border-border-primary font-semibold text-text-primary">
                <div>Placa</div>
                <div>Tara</div>
                <div>Tipo Rodado</div>
                <div>Tipo Carroceria</div>
                <div>UF</div>
                <div>RNTRC</div>
                <div>Status</div>
                <div>Data Cadastro</div>
                <div>Ações</div>
              </div>
              {reboquesFiltrados.map((reboque) => (
                <div key={reboque.id} className="grid grid-cols-9 gap-4 p-4 border-b border-border-primary hover:bg-bg-surface-hover transition-colors duration-200">
                  <div>
                    <strong className="text-text-primary">{formatarPlaca(reboque.placa)}</strong>
                  </div>
                  <div className="text-text-primary">{formatarTara(reboque.tara)}</div>
                  <div className="text-text-primary">{reboque.tipoRodado}</div>
                  <div className="text-text-primary">{reboque.tipoCarroceria}</div>
                  <div>
                    <span className="px-2 py-1 bg-gray-100 text-gray-800 dark:bg-gray-800 dark:text-gray-300 rounded text-xs font-medium">{reboque.uf}</span>
                  </div>
                  <div className="text-text-primary">{reboque.rntrc || '-'}</div>
                  <div>
                    <span className={`px-2 py-1 rounded-full text-xs font-medium ${
                      reboque.ativo
                        ? 'bg-green-100 text-green-800 dark:bg-green-900 dark:text-green-300'
                        : 'bg-red-100 text-red-800 dark:bg-red-900 dark:text-red-300'
                    }`}>
                      {reboque.ativo ? 'Ativo' : 'Inativo'}
                    </span>
                  </div>
                  <div className="text-text-primary">{formatarData(reboque.dataCriacao)}</div>
                  <div>
                    <div className="flex items-center gap-1">
                      <button
                        className="p-2 text-blue-600 hover:bg-blue-50 dark:hover:bg-blue-900/20 rounded transition-colors duration-200"
                        onClick={() => abrirModalVisualizacao(reboque)}
                        title="Visualizar"
                      >
                        <i className="fas fa-eye"></i>
                      </button>
                      <button
                        className="p-2 text-amber-600 hover:bg-amber-50 dark:hover:bg-amber-900/20 rounded transition-colors duration-200"
                        onClick={() => abrirModalEdicao(reboque)}
                        title="Editar"
                      >
                        <i className="fas fa-edit"></i>
                      </button>
                      <button
                        className="p-2 text-red-600 hover:bg-red-50 dark:hover:bg-red-900/20 rounded transition-colors duration-200"
                        onClick={() => abrirModalExclusao(reboque)}
                        title="Excluir"
                      >
                        <i className="fas fa-trash"></i>
                      </button>
                    </div>
                  </div>
                </div>
              ))}
            </div>

            {/* Paginação */}
            {paginacao && (
              <div className="mt-6 bg-bg-surface border-t border-border-primary p-4">
                <div className="flex flex-col sm:flex-row justify-between items-center gap-4">
                  <div className="text-sm text-text-secondary">
                    Mostrando {((paginacao.currentPage - 1) * paginacao.pageSize) + 1} a {Math.min(paginacao.currentPage * paginacao.pageSize, paginacao.totalItems)} de {paginacao.totalItems} registros
                  </div>
                  <div className="flex items-center gap-2">
                    <button
                      className="px-4 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary hover:bg-bg-surface-hover disabled:opacity-50 disabled:cursor-not-allowed transition-colors duration-200"
                      onClick={() => setPaginaAtual(paginaAtual - 1)}
                      disabled={!paginacao.hasPreviousPage}
                    >
                      Anterior
                    </button>
                    <span className="px-4 py-2 text-text-primary">
                      Página {paginacao.currentPage} de {paginacao.totalPages}
                    </span>
                    <button
                      className="px-4 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary hover:bg-bg-surface-hover disabled:opacity-50 disabled:cursor-not-allowed transition-colors duration-200"
                      onClick={() => setPaginaAtual(paginaAtual + 1)}
                      disabled={!paginacao.hasNextPage}
                    >
                      Próxima
                    </button>
                  </div>
                </div>
              </div>
            )}
          </>
        )}
      </div>

      {/* Modal de Formulário */}
      {modalAberto && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50 backdrop-blur-sm" onClick={fecharModal}>
          <div className="bg-bg-surface rounded-xl border border-border-primary shadow-xl max-w-4xl w-full mx-4 max-h-[90vh] overflow-y-auto" onClick={(e) => e.stopPropagation()}>
            <div className="flex items-center justify-between p-6 border-b border-border-primary">
              <h2 className="text-xl font-semibold text-text-primary flex items-center gap-2">
                <i className="fas fa-truck"></i>
                {reboqueEdicao ? 'Editar Reboque' : 'Novo Reboque'}
              </h2>
              <button className="text-text-tertiary hover:text-text-primary transition-colors duration-200 text-2xl" onClick={fecharModal}>
                <i className="fas fa-times"></i>
              </button>
            </div>

            <form onSubmit={salvarReboque} className="p-6">
              <div className="space-y-6">
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <div className="space-y-2">
                    <label className="text-sm font-medium text-text-primary">Placa *</label>
                    <input
                      type="text"
                      value={dadosModal.placa}
                      onChange={(e) => setDadosModal({ ...dadosModal, placa: e.target.value.toUpperCase() })}
                      placeholder="ABC-1234 ou ABC1D23"
                      maxLength={8}
                      required
                      className="w-full px-3 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary focus:outline-none focus:ring-2 focus:ring-primary"
                    />
                  </div>

                  <div className="space-y-2">
                    <label className="text-sm font-medium text-text-primary">Tara (kg) *</label>
                    <input
                      type="number"
                      value={dadosModal.tara}
                      onChange={(e) => setDadosModal({ ...dadosModal, tara: parseInt(e.target.value) || 0 })}
                      placeholder="5000"
                      min="0"
                      required
                      className="w-full px-3 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary focus:outline-none focus:ring-2 focus:ring-primary"
                    />
                  </div>

                  <div className="space-y-2">
                    <label className="text-sm font-medium text-text-primary">Tipo de Rodado *</label>
                    <select
                      value={dadosModal.tipoRodado}
                      onChange={(e) => setDadosModal({ ...dadosModal, tipoRodado: e.target.value })}
                      required
                      className="w-full px-3 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary focus:outline-none focus:ring-2 focus:ring-primary"
                    >
                      <option value="">Selecione...</option>
                      {reboquesService.getTiposRodado().map(tipo => (
                        <option key={tipo.value} value={tipo.value}>
                          {tipo.label}
                        </option>
                      ))}
                    </select>
                  </div>

                  <div className="space-y-2">
                    <label className="text-sm font-medium text-text-primary">Tipo de Carroceria *</label>
                    <select
                      value={dadosModal.tipoCarroceria}
                      onChange={(e) => setDadosModal({ ...dadosModal, tipoCarroceria: e.target.value })}
                      required
                      className="w-full px-3 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary focus:outline-none focus:ring-2 focus:ring-primary"
                    >
                      <option value="">Selecione...</option>
                      {reboquesService.getTiposCarroceria().map(tipo => (
                        <option key={tipo.value} value={tipo.value}>
                          {tipo.label}
                        </option>
                      ))}
                    </select>
                  </div>

                  <div className="space-y-2">
                    <label className="text-sm font-medium text-text-primary">UF *</label>
                    <select
                      value={dadosModal.uf}
                      onChange={(e) => setDadosModal({ ...dadosModal, uf: e.target.value })}
                      required
                      className="w-full px-3 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary focus:outline-none focus:ring-2 focus:ring-primary"
                    >
                      <option value="">Selecione...</option>
                      {reboquesService.getEstados().map(estado => (
                        <option key={estado.value} value={estado.value}>
                          {estado.label}
                        </option>
                      ))}
                    </select>
                  </div>

                  <div className="space-y-2">
                    <label className="text-sm font-medium text-text-primary">RNTRC</label>
                    <input
                      type="text"
                      value={dadosModal.rntrc || ''}
                      onChange={(e) => setDadosModal({ ...dadosModal, rntrc: e.target.value })}
                      placeholder="12345678"
                      maxLength={20}
                      className="w-full px-3 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary focus:outline-none focus:ring-2 focus:ring-primary"
                    />
                  </div>
                </div>
              </div>

              <div className="flex items-center justify-end gap-4 mt-6 pt-6 border-t border-border-primary">
                <button type="button" className="px-4 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary hover:bg-bg-surface-hover transition-colors duration-200" onClick={fecharModal}>
                  Cancelar
                </button>
                <button type="submit" className="px-4 py-2 bg-primary hover:bg-primary-hover text-white rounded-lg font-medium transition-colors duration-200 flex items-center gap-2">
                  <i className="fas fa-save"></i>
                  {reboqueEdicao ? 'Atualizar' : 'Criar'} Reboque
                </button>
              </div>
            </form>
          </div>
        </div>
      )}

      {/* Modal de Visualização */}
      {modalVisualizacao && reboqueVisualizacao && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50 backdrop-blur-sm" onClick={fecharModalVisualizacao}>
          <div className="bg-bg-surface rounded-xl border border-border-primary shadow-xl max-w-2xl w-full mx-4 max-h-[90vh] overflow-y-auto" onClick={(e) => e.stopPropagation()}>
            <div className="flex items-center justify-between p-6 border-b border-border-primary">
              <h2 className="text-xl font-semibold text-text-primary flex items-center gap-2">
                <i className="fas fa-truck"></i>
                Detalhes do Reboque
              </h2>
              <button className="text-text-tertiary hover:text-text-primary transition-colors duration-200 text-2xl" onClick={fecharModalVisualizacao}>
                <i className="fas fa-times"></i>
              </button>
            </div>

            <div className="p-6">
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div className="space-y-1">
                  <strong className="text-sm font-medium text-text-secondary">Placa:</strong>
                  <span className="block text-text-primary">{formatarPlaca(reboqueVisualizacao.placa)}</span>
                </div>
                <div className="space-y-1">
                  <strong className="text-sm font-medium text-text-secondary">Tara:</strong>
                  <span className="block text-text-primary">{formatarTara(reboqueVisualizacao.tara)}</span>
                </div>
                <div className="space-y-1">
                  <strong className="text-sm font-medium text-text-secondary">Tipo de Rodado:</strong>
                  <span className="block text-text-primary">{reboqueVisualizacao.tipoRodado}</span>
                </div>
                <div className="space-y-1">
                  <strong className="text-sm font-medium text-text-secondary">Tipo de Carroceria:</strong>
                  <span className="block text-text-primary">{reboqueVisualizacao.tipoCarroceria}</span>
                </div>
                <div className="space-y-1">
                  <strong className="text-sm font-medium text-text-secondary">UF:</strong>
                  <span className="block text-text-primary">{reboqueVisualizacao.uf}</span>
                </div>
                <div className="space-y-1">
                  <strong className="text-sm font-medium text-text-secondary">RNTRC:</strong>
                  <span className="block text-text-primary">{reboqueVisualizacao.rntrc || 'Não informado'}</span>
                </div>
                <div className="space-y-1">
                  <strong className="text-sm font-medium text-text-secondary">Status:</strong>
                  <span className={`inline-block px-2 py-1 rounded-full text-xs font-medium ${
                    reboqueVisualizacao.ativo
                      ? 'bg-green-100 text-green-800 dark:bg-green-900 dark:text-green-300'
                      : 'bg-red-100 text-red-800 dark:bg-red-900 dark:text-red-300'
                  }`}>
                    {reboqueVisualizacao.ativo ? 'Ativo' : 'Inativo'}
                  </span>
                </div>
                <div className="space-y-1">
                  <strong className="text-sm font-medium text-text-secondary">Data de Cadastro:</strong>
                  <span className="block text-text-primary">{formatarData(reboqueVisualizacao.dataCriacao)}</span>
                </div>
                {reboqueVisualizacao.dataUltimaAlteracao && (
                  <div className="space-y-1">
                    <strong className="text-sm font-medium text-text-secondary">Última Alteração:</strong>
                    <span className="block text-text-primary">{formatarData(reboqueVisualizacao.dataUltimaAlteracao)}</span>
                  </div>
                )}
              </div>
            </div>

            <div className="flex items-center justify-end gap-4 p-6 border-t border-border-primary">
              <button className="px-4 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary hover:bg-bg-surface-hover transition-colors duration-200" onClick={fecharModalVisualizacao}>
                Fechar
              </button>
            </div>
          </div>
        </div>
      )}

      {/* Modal de Confirmação de Exclusão */}
      {modalExclusao && reboqueExclusao && (
        <ConfirmDeleteModal
          isOpen={modalExclusao}
          title="Excluir Reboque"
          message="Tem certeza de que deseja excluir este reboque?"
          itemName={`reboque ${formatarPlaca(reboqueExclusao.placa)}`}
          onConfirm={confirmarExclusao}
          onCancel={fecharModalExclusao}
          loading={excludindo}
        />
      )}
    </div>
  );
}