import React, { useState, useEffect } from 'react';
import { ConfirmDeleteModal } from '../../../components/UI/Modal/ConfirmDeleteModal';
import { formatCPF, cleanNumericString } from '../../../utils/formatters';
import { entitiesService } from '../../../services/entitiesService';
import Icon from '../../../components/UI/Icon';

interface Condutor {
  id?: number;
  nome: string;
  cpf: string;
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

export function ListarCondutores() {
  const [condutores, setCondutores] = useState<Condutor[]>([]);
  const [carregando, setCarregando] = useState(false);
  const [filtro, setFiltro] = useState('');
  const [filtroStatus, setFiltroStatus] = useState('todos');

  // Estados de paginação
  const [paginaAtual, setPaginaAtual] = useState(1);
  const [tamanhoPagina, setTamanhoPagina] = useState(10);
  const [paginacao, setPaginacao] = useState<PaginationData | null>(null);

  // Estados do modal
  const [modalAberto, setModalAberto] = useState(false);
  const [modalVisualizacao, setModalVisualizacao] = useState(false);
  const [condutorSelecionado, setCondutorSelecionado] = useState<Condutor | null>(null);
  const [dadosFormulario, setDadosFormulario] = useState<Partial<Condutor>>({});
  const [salvando, setSalvando] = useState(false);

  // Estados do modal de exclusão
  const [modalExclusao, setModalExclusao] = useState(false);
  const [condutorExclusao, setCondutorExclusao] = useState<Condutor | null>(null);
  const [excluindo, setExcluindo] = useState(false);

  useEffect(() => {
    carregarCondutores();
  }, [paginaAtual, tamanhoPagina, filtro, filtroStatus]);

  const carregarCondutores = async () => {
    setCarregando(true);
    try {
      const API_BASE_URL = process.env.REACT_APP_API_URL || 'https://localhost:5001/api';
      const params = new URLSearchParams({
        Page: paginaAtual.toString(),
        PageSize: tamanhoPagina.toString()
      });

      if (filtro.trim()) {
        params.append('Search', filtro.trim());
      }

      const response = await fetch(`${API_BASE_URL}/condutores?${params}`);

      if (!response.ok) {
        throw new Error(`Erro ${response.status}: ${response.statusText}`);
      }

      const data = await response.json();
      const condutoresMapeados: Condutor[] = (data.items || data.Itens || []).map((condutor: any) => ({
        id: condutor.id || condutor.Id,
        nome: condutor.nome || condutor.Nome,
        cpf: condutor.cpf || condutor.Cpf,
        ativo: condutor.ativo !== undefined ? condutor.ativo : (condutor.Ativo !== undefined ? condutor.Ativo : true)
      }));

      setCondutores(condutoresMapeados);
      setPaginacao({
        totalItems: data.totalItems || data.TotalItens || 0,
        totalPages: data.totalPages || data.TotalPaginas || 0,
        currentPage: data.currentPage || data.Pagina || 1,
        pageSize: data.pageSize || data.TamanhoPagina || 10,
        hasNextPage: data.hasNextPage || data.TemProxima || false,
        hasPreviousPage: data.hasPreviousPage || data.TemAnterior || false,
        startItem: data.startItem || data.ItemInicio || 0,
        endItem: data.endItem || data.ItemFim || 0
      });

    } catch (error) {
      console.error('Erro ao carregar condutores:', error);
      setCondutores([]);
      setPaginacao(null);
    } finally {
      setCarregando(false);
    }
  };

  const abrirModalNovo = () => {
    setCondutorSelecionado(null);
    setDadosFormulario({ nome: '', cpf: '', ativo: true });
    setModalAberto(true);
  };

  const abrirModalEdicao = (condutor: Condutor) => {
    setCondutorSelecionado(condutor);
    setDadosFormulario(condutor);
    setModalAberto(true);
  };

  const abrirModalVisualizacao = (condutor: Condutor) => {
    setCondutorSelecionado(condutor);
    setModalVisualizacao(true);
  };

  const fecharModal = () => {
    setModalAberto(false);
    setCondutorSelecionado(null);
    setDadosFormulario({});
  };

  const fecharModalVisualizacao = () => {
    setModalVisualizacao(false);
    setCondutorSelecionado(null);
  };

  const atualizarCampo = (campo: keyof Condutor, valor: any) => {
    setDadosFormulario(prev => ({ ...prev, [campo]: valor }));
  };

  const salvarCondutor = async () => {
    setSalvando(true);
    try {
      const dadosParaSalvar = {
        nome: dadosFormulario.nome?.trim(),
        cpf: dadosFormulario.cpf ? cleanNumericString(dadosFormulario.cpf) : undefined,
        ativo: dadosFormulario.ativo ?? true
      };

      if (condutorSelecionado) {
        await entitiesService.atualizarCondutor(condutorSelecionado.id!, dadosParaSalvar);
      } else {
        await entitiesService.criarCondutor(dadosParaSalvar);
      }

      await carregarCondutores();
      fecharModal();

    } catch (error) {
      console.error('Erro ao salvar condutor:', error);
      alert('Erro ao salvar condutor. Tente novamente.');
    } finally {
      setSalvando(false);
    }
  };

  const abrirModalExclusao = (condutor: Condutor) => {
    setCondutorExclusao(condutor);
    setModalExclusao(true);
  };

  const fecharModalExclusao = () => {
    setModalExclusao(false);
    setCondutorExclusao(null);
    setExcluindo(false);
  };

  const confirmarExclusao = async () => {
    if (!condutorExclusao?.id) return;

    setExcluindo(true);
    try {
      await entitiesService.excluirCondutor(condutorExclusao.id);
      await carregarCondutores();
      fecharModalExclusao();
    } catch (error) {
      console.error('Erro ao excluir condutor:', error);
      alert('Erro ao excluir condutor. Tente novamente.');
      setExcluindo(false);
    }
  };

  const condutoresFiltrados = condutores.filter(condutor => {
    const matchStatus = filtroStatus === 'todos' ||
      (filtroStatus === 'ativo' && condutor.ativo) ||
      (filtroStatus === 'inativo' && !condutor.ativo);
    return matchStatus;
  });

  const alterarPagina = (novaPagina: number) => {
    setPaginaAtual(novaPagina);
  };

  const alterarTamanhoPagina = (novoTamanho: number) => {
    setTamanhoPagina(novoTamanho);
    setPaginaAtual(1);
  };

  if (carregando) {
    return (
      <div className="flex flex-col items-center justify-center min-h-[400px] gap-4">
        <div className="w-8 h-8 border-4 border-primary border-t-transparent rounded-full animate-spin"></div>
        <p className="text-text-secondary">Carregando condutores...</p>
      </div>
    );
  }

  return (
    <div className="max-w-7xl mx-auto px-6 py-8">
      {/* Header */}
      <div className="flex items-center justify-between mb-8">
        <h1 className="text-3xl font-bold text-text-primary flex items-center gap-3">
          <Icon name="user-tie" className="text-primary" />
          Condutores
        </h1>
        <button className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary-hover transition-colors duration-200 flex items-center gap-2" onClick={abrirModalNovo}>
          <Icon name="plus" />
          Novo Condutor
        </button>
      </div>

        {/* Filtros */}
      <div className="bg-bg-surface rounded-xl border border-border-primary p-6 mb-6">
        <div className="flex flex-col md:flex-row gap-4">
          <div className="flex-1">
            <input
              type="text"
              placeholder="Buscar por nome ou CPF..."
              value={filtro}
              onChange={(e) => setFiltro(e.target.value)}
              className="w-full px-3 py-2 border border-border-primary rounded-lg bg-bg-surface focus:outline-none focus:ring-2 focus:ring-primary/20"
            />
          </div>

          <div className="flex-1">
            <select
              value={filtroStatus}
              onChange={(e) => setFiltroStatus(e.target.value)}
              className="w-full px-3 py-2 border border-border-primary rounded-lg bg-bg-surface focus:outline-none focus:ring-2 focus:ring-primary/20"
            >
              <option value="todos">Todos os Status</option>
              <option value="ativo">Ativo</option>
              <option value="inativo">Inativo</option>
            </select>
          </div>
        </div>
      </div>

      {/* Lista de Condutores */}
      <div className="bg-bg-surface rounded-xl border border-border-primary shadow-sm">
        {condutoresFiltrados.length === 0 ? (
          <div className="flex flex-col items-center justify-center py-16 px-6">
            <div className="text-6xl text-text-tertiary mb-4">
              <Icon name="users" />
            </div>
            <h3 className="text-xl font-semibold text-text-primary mb-2">Nenhum condutor encontrado</h3>
            <p className="text-text-secondary text-center mb-6">
              {condutores.length === 0
                ? "Você ainda não possui nenhum condutor cadastrado."
                : "Nenhum condutor corresponde aos filtros selecionados."
              }
            </p>
            {condutores.length === 0 && (
              <button className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary-hover transition-colors duration-200 flex items-center gap-2" onClick={abrirModalNovo}>
                <Icon name="plus" />
                Cadastrar primeiro condutor
              </button>
            )}
          </div>
        ) : (
          <div className="overflow-x-auto">
            {/* Header da Tabela */}
            <div className="grid grid-cols-6 gap-4 p-4 bg-bg-tertiary border-b border-border-primary font-semibold text-text-primary">
              <div>ID</div>
              <div>Nome</div>
              <div>CPF</div>
              <div>Status</div>
              <div>Data Cadastro</div>
              <div>Ações</div>
            </div>

            {/* Linhas da Tabela */}
            {condutoresFiltrados.map((condutor) => (
              <div key={condutor.id} className="grid grid-cols-6 gap-4 p-4 border-b border-border-primary hover:bg-bg-tertiary transition-colors duration-200">
                <div>
                  <strong className="text-primary">#{condutor.id}</strong>
                </div>

                <div>
                  <span className="text-text-primary font-medium">{condutor.nome}</span>
                </div>

                <div>
                  <span className="text-text-secondary font-mono">{formatCPF(condutor.cpf)}</span>
                </div>

                <div>
                  <span className={`px-2 py-1 rounded-full text-xs font-medium ${condutor.ativo ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'}`}>
                    {condutor.ativo ? 'Ativo' : 'Inativo'}
                  </span>
                </div>

                <div>
                  <span className="text-text-tertiary text-sm">
                    {new Date().toLocaleDateString('pt-BR')}
                  </span>
                </div>

                <div className="flex items-center gap-2">
                  <button
                    className="p-2 text-blue-600 hover:bg-blue-50 rounded-lg transition-colors duration-200"
                    onClick={() => abrirModalVisualizacao(condutor)}
                    title="Visualizar"
                  >
                    <Icon name="eye" />
                  </button>

                  <button
                    className="p-2 text-amber-600 hover:bg-amber-50 rounded-lg transition-colors duration-200"
                    onClick={() => abrirModalEdicao(condutor)}
                    title="Editar"
                  >
                    <Icon name="edit" />
                  </button>

                  <button
                    className="p-2 text-red-600 hover:bg-red-50 rounded-lg transition-colors duration-200"
                    onClick={() => abrirModalExclusao(condutor)}
                    title="Excluir"
                  >
                    <Icon name="trash" />
                  </button>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>

      {/* Paginação */}
      {paginacao && paginacao.totalItems > 0 && (
        <div className="mt-6 border-t border-border-primary pt-6">
          <div className="flex flex-col md:flex-row items-center justify-between gap-4">
            <div className="flex items-center gap-2">
              <label className="text-text-secondary text-sm">Itens por página:</label>
              <select
                className="px-3 py-1 border border-border-primary rounded-lg bg-bg-surface focus:outline-none focus:ring-2 focus:ring-primary/20"
                value={paginacao.pageSize}
                onChange={(e) => alterarTamanhoPagina(Number(e.target.value))}
              >
                <option value={5}>5</option>
                <option value={10}>10</option>
                <option value={20}>20</option>
                <option value={50}>50</option>
              </select>
            </div>

            <div className="flex items-center gap-4">
              <button
                className="px-4 py-2 border border-border-primary rounded-lg bg-bg-surface hover:bg-bg-tertiary transition-colors duration-200 disabled:opacity-50 disabled:cursor-not-allowed"
                onClick={() => alterarPagina(paginacao.currentPage - 1)}
                disabled={paginacao.currentPage === 1}
              >
                Anterior
              </button>

              <span className="text-text-secondary text-sm px-4">
                Página {paginacao.currentPage} de {paginacao.totalPages}
              </span>

              <button
                className="px-4 py-2 border border-border-primary rounded-lg bg-bg-surface hover:bg-bg-tertiary transition-colors duration-200 disabled:opacity-50 disabled:cursor-not-allowed"
                onClick={() => alterarPagina(paginacao.currentPage + 1)}
                disabled={paginacao.currentPage === paginacao.totalPages}
              >
                Próxima
              </button>
            </div>

            <div className="text-text-tertiary text-sm">
              Mostrando {((paginacao.currentPage - 1) * paginacao.pageSize) + 1} a {Math.min(paginacao.currentPage * paginacao.pageSize, paginacao.totalItems)} de {paginacao.totalItems} condutores
            </div>
          </div>
        </div>
      )}

      {/* Modal de Cadastro/Edição */}
      {modalAberto && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
          <div className="bg-bg-surface rounded-xl border border-border-primary shadow-xl max-w-2xl w-full max-h-[90vh] overflow-y-auto">
            <div className="flex items-center justify-between p-6 border-b border-border-primary">
              <h2 className="text-xl font-semibold text-text-primary">{condutorSelecionado ? 'Editar Condutor' : 'Novo Condutor'}</h2>
              <button className="text-text-tertiary hover:text-text-primary transition-colors duration-200 text-2xl" onClick={fecharModal}>×</button>
            </div>

            <div className="p-6">
              <div className="space-y-6">
                <h3 className="text-lg font-medium text-text-primary">Dados do Condutor</h3>

                <div className="space-y-4">
                  <div className="space-y-2">
                    <label className="text-sm font-medium text-text-primary">Nome *</label>
                    <input
                      type="text"
                      value={dadosFormulario.nome || ''}
                      onChange={(e) => atualizarCampo('nome', e.target.value)}
                      placeholder="Nome completo do condutor"
                      maxLength={200}
                      required
                      className="w-full px-3 py-2 border border-border-primary rounded-lg bg-bg-surface focus:outline-none focus:ring-2 focus:ring-primary/20"
                    />
                  </div>
                </div>

                <div className="space-y-4">
                  <div className="space-y-2">
                    <label className="text-sm font-medium text-text-primary">CPF *</label>
                    <input
                      type="text"
                      value={formatCPF(dadosFormulario.cpf || '')}
                      onChange={(e) => atualizarCampo('cpf', cleanNumericString(e.target.value))}
                      placeholder="000.000.000-00"
                      maxLength={14}
                      required
                      className="w-full px-3 py-2 border border-border-primary rounded-lg bg-bg-surface focus:outline-none focus:ring-2 focus:ring-primary/20"
                    />
                  </div>
                </div>

                {condutorSelecionado && (
                  <div className="space-y-4">
                    <div className="space-y-2">
                      <label className="text-sm font-medium text-text-primary">Status</label>
                      <select
                        value={dadosFormulario.ativo ? 'true' : 'false'}
                        onChange={(e) => atualizarCampo('ativo', e.target.value === 'true')}
                        className="w-full px-3 py-2 border border-border-primary rounded-lg bg-bg-surface focus:outline-none focus:ring-2 focus:ring-primary/20"
                      >
                        <option value="true">Ativo</option>
                        <option value="false">Inativo</option>
                      </select>
                    </div>
                  </div>
                )}
              </div>
            </div>

            <div className="flex items-center justify-end gap-4 p-6 border-t border-border-primary">
              <button
                type="button"
                onClick={fecharModal}
                className="px-4 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary hover:bg-bg-tertiary transition-colors duration-200"
                disabled={salvando}
              >
                Cancelar
              </button>
              <button
                type="button"
                onClick={salvarCondutor}
                className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary-hover transition-colors duration-200 disabled:opacity-50 disabled:cursor-not-allowed"
                disabled={salvando || !dadosFormulario.nome || !dadosFormulario.cpf}
              >
                {salvando ? 'Salvando...' : condutorSelecionado ? 'Atualizar' : 'Salvar'}
              </button>
            </div>
          </div>
        </div>
      )}

      {/* Modal de Visualização */}
      {modalVisualizacao && condutorSelecionado && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
          <div className="bg-bg-surface rounded-xl border border-border-primary shadow-xl max-w-2xl w-full max-h-[90vh] overflow-y-auto">
            <div className="flex items-center justify-between p-6 border-b border-border-primary">
              <h2 className="text-xl font-semibold text-text-primary">Visualizar Condutor</h2>
              <button className="text-text-tertiary hover:text-text-primary transition-colors duration-200 text-2xl" onClick={fecharModalVisualizacao}>×</button>
            </div>

            <div className="p-6">
              <div className="space-y-6">
                <h3 className="text-lg font-medium text-text-primary">Dados do Condutor</h3>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                  <div className="space-y-2">
                    <label className="text-sm font-medium text-text-secondary">Nome:</label>
                    <span className="text-text-primary font-medium">{condutorSelecionado.nome}</span>
                  </div>
                  <div className="space-y-2">
                    <label className="text-sm font-medium text-text-secondary">CPF:</label>
                    <span className="text-text-primary font-mono">{formatCPF(condutorSelecionado.cpf)}</span>
                  </div>
                  <div className="space-y-2">
                    <label className="text-sm font-medium text-text-secondary">Status:</label>
                    <span className={`px-2 py-1 rounded-full text-xs font-medium ${condutorSelecionado.ativo ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'}`}>
                      {condutorSelecionado.ativo ? 'Ativo' : 'Inativo'}
                    </span>
                  </div>
                </div>
              </div>
            </div>

            <div className="flex items-center justify-end gap-4 p-6 border-t border-border-primary">
              <button onClick={fecharModalVisualizacao} className="px-4 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary hover:bg-bg-tertiary transition-colors duration-200">
                Fechar
              </button>
            </div>
          </div>
        </div>
      )}

      {/* Modal de Exclusão */}
      <ConfirmDeleteModal
        isOpen={modalExclusao}
        onCancel={fecharModalExclusao}
        onConfirm={confirmarExclusao}
        title="Excluir Condutor"
        message={`Tem certeza que deseja excluir o condutor "${condutorExclusao?.nome}"?`}
        loading={excluindo}
      />
    </div>
  );
}