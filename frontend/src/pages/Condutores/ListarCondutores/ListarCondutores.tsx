import React, { useState, useEffect } from 'react';
import { ConfirmDeleteModal } from '../../../components/UI/Modal/ConfirmDeleteModal';
import { formatCPF, cleanNumericString } from '../../../utils/formatters';
import { entitiesService } from '../../../services/entitiesService';
import styles from './ListarCondutores.module.css';

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
      <div className={styles.loadingContainer}>
        <div className={styles.loadingSpinner}></div>
        <p>Carregando condutores...</p>
      </div>
    );
  }

  return (
    <div className={styles.container}>
      {/* Header */}
      <div className={styles.header}>
        <h1>
          <i className="fas fa-user-tie"></i>
          Condutores
        </h1>
        <button className={styles.btnNovo} onClick={abrirModalNovo}>
          <i className="fas fa-plus"></i>
          Novo Condutor
        </button>
      </div>

        {/* Filtros */}
      <div className={styles.filters}>
        <div className={styles.filtersRow}>
          <div className={styles.filterField}>
            <input
              type="text"
              placeholder="Buscar por nome ou CPF..."
              value={filtro}
              onChange={(e) => setFiltro(e.target.value)}
              className={styles.searchInput}
            />
          </div>

          <div className={styles.filterField}>
            <select
              value={filtroStatus}
              onChange={(e) => setFiltroStatus(e.target.value)}
            >
              <option value="todos">Todos os Status</option>
              <option value="ativo">Ativo</option>
              <option value="inativo">Inativo</option>
            </select>
          </div>
        </div>
      </div>

      {/* Lista de Condutores */}
      <div className={styles.list}>
        {condutoresFiltrados.length === 0 ? (
          <div className={styles.emptyState}>
            <div className={styles.emptyIcon}>
              <i className="fas fa-users"></i>
            </div>
            <h3>Nenhum condutor encontrado</h3>
            <p>
              {condutores.length === 0
                ? "Você ainda não possui nenhum condutor cadastrado."
                : "Nenhum condutor corresponde aos filtros selecionados."
              }
            </p>
            {condutores.length === 0 && (
              <button className={styles.btnPrimary} onClick={abrirModalNovo}>
                <i className="fas fa-plus"></i>
                Cadastrar primeiro condutor
              </button>
            )}
          </div>
        ) : (
          <div className={styles.table}>
            {/* Header da Tabela */}
            <div className={styles.tableHeader}>
              <div>ID</div>
              <div>Nome</div>
              <div>CPF</div>
              <div>Status</div>
              <div>Data Cadastro</div>
              <div>Ações</div>
            </div>

            {/* Linhas da Tabela */}
            {condutoresFiltrados.map((condutor) => (
              <div key={condutor.id} className={styles.tableRow}>
                <div>
                  <strong>#{condutor.id}</strong>
                </div>

                <div>
                  <span>{condutor.nome}</span>
                </div>

                <div>
                  <span>{formatCPF(condutor.cpf)}</span>
                </div>

                <div>
                  <span className={`${styles.status} ${condutor.ativo ? styles.ativo : styles.inativo}`}>
                    {condutor.ativo ? 'Ativo' : 'Inativo'}
                  </span>
                </div>

                <div>
                  <span className={styles.subtext}>
                    {new Date().toLocaleDateString('pt-BR')}
                  </span>
                </div>

                <div className={styles.actions}>
                  <button
                    className={styles.btnView}
                    onClick={() => abrirModalVisualizacao(condutor)}
                    title="Visualizar"
                  >
                    <i className="fas fa-eye"></i>
                  </button>

                  <button
                    className={styles.btnEdit}
                    onClick={() => abrirModalEdicao(condutor)}
                    title="Editar"
                  >
                    <i className="fas fa-edit"></i>
                  </button>

                  <button
                    className={styles.btnDelete}
                    onClick={() => abrirModalExclusao(condutor)}
                    title="Excluir"
                  >
                    <i className="fas fa-trash"></i>
                  </button>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>

      {/* Paginação */}
      {paginacao && paginacao.totalItems > 0 && (
        <div className={styles.paginationContainer}>
          <div className={styles.paginationControls}>
            <div className={styles.pageSizeSelector}>
              <label>Itens por página:</label>
              <select
                className={styles.pageSizeSelect}
                value={paginacao.pageSize}
                onChange={(e) => alterarTamanhoPagina(Number(e.target.value))}
              >
                <option value={5}>5</option>
                <option value={10}>10</option>
                <option value={20}>20</option>
                <option value={50}>50</option>
              </select>
            </div>

            <div className={styles.pagination}>
              <button
                className={styles.paginationBtn}
                onClick={() => alterarPagina(paginacao.currentPage - 1)}
                disabled={paginacao.currentPage === 1}
              >
                Anterior
              </button>

              <span className={styles.pageInfo}>
                Página {paginacao.currentPage} de {paginacao.totalPages}
              </span>

              <button
                className={styles.paginationBtn}
                onClick={() => alterarPagina(paginacao.currentPage + 1)}
                disabled={paginacao.currentPage === paginacao.totalPages}
              >
                Próxima
              </button>
            </div>

            <div className={styles.paginationInfo}>
              Mostrando {((paginacao.currentPage - 1) * paginacao.pageSize) + 1} a {Math.min(paginacao.currentPage * paginacao.pageSize, paginacao.totalItems)} de {paginacao.totalItems} condutores
            </div>
          </div>
        </div>
      )}

      {/* Modal de Cadastro/Edição */}
      {modalAberto && (
        <div className={styles.modalOverlay}>
          <div className={styles.modal}>
            <div className={styles.modalHeader}>
              <h2>{condutorSelecionado ? 'Editar Condutor' : 'Novo Condutor'}</h2>
              <button className={styles.closeBtn} onClick={fecharModal}>×</button>
            </div>

            <div className={styles.modalContent}>
              <div className={styles.modalSection}>
                <h3>Dados do Condutor</h3>

                <div className={styles.modalRow}>
                  <div className={styles.modalField}>
                    <label>Nome *</label>
                    <input
                      type="text"
                      value={dadosFormulario.nome || ''}
                      onChange={(e) => atualizarCampo('nome', e.target.value)}
                      placeholder="Nome completo do condutor"
                      maxLength={200}
                      required
                    />
                  </div>
                </div>

                <div className={styles.modalRow}>
                  <div className={styles.modalField}>
                    <label>CPF *</label>
                    <input
                      type="text"
                      value={formatCPF(dadosFormulario.cpf || '')}
                      onChange={(e) => atualizarCampo('cpf', cleanNumericString(e.target.value))}
                      placeholder="000.000.000-00"
                      maxLength={14}
                      required
                    />
                  </div>
                </div>

                {condutorSelecionado && (
                  <div className={styles.modalRow}>
                    <div className={styles.modalField}>
                      <label>Status</label>
                      <select
                        value={dadosFormulario.ativo ? 'true' : 'false'}
                        onChange={(e) => atualizarCampo('ativo', e.target.value === 'true')}
                      >
                        <option value="true">Ativo</option>
                        <option value="false">Inativo</option>
                      </select>
                    </div>
                  </div>
                )}
              </div>
            </div>

            <div className={styles.modalActions}>
              <button
                type="button"
                onClick={fecharModal}
                className={styles.btnCancel}
                disabled={salvando}
              >
                Cancelar
              </button>
              <button
                type="button"
                onClick={salvarCondutor}
                className={styles.btnSave}
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
        <div className={styles.modalOverlay}>
          <div className={styles.modal}>
            <div className={styles.modalHeader}>
              <h2>Visualizar Condutor</h2>
              <button className={styles.closeBtn} onClick={fecharModalVisualizacao}>×</button>
            </div>

            <div className={styles.modalContent}>
              <div className={styles.modalSection}>
                <h3>Dados do Condutor</h3>
                <div className={styles.viewGrid}>
                  <div className={styles.viewField}>
                    <label>Nome:</label>
                    <span>{condutorSelecionado.nome}</span>
                  </div>
                  <div className={styles.viewField}>
                    <label>CPF:</label>
                    <span>{formatCPF(condutorSelecionado.cpf)}</span>
                  </div>
                  <div className={styles.viewField}>
                    <label>Status:</label>
                    <span className={`${styles.statusBadge} ${condutorSelecionado.ativo ? styles.ativo : styles.inativo}`}>
                      {condutorSelecionado.ativo ? 'Ativo' : 'Inativo'}
                    </span>
                  </div>
                </div>
              </div>
            </div>

            <div className={styles.modalActions}>
              <button onClick={fecharModalVisualizacao} className={styles.btnCancel}>
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