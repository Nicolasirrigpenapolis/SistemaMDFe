import React, { useState, useEffect } from 'react';
import { ConfirmDeleteModal } from '../../../components/UI/Modal/ConfirmDeleteModal';
import { formatCNPJ, cleanNumericString, applyMask } from '../../../utils/formatters';
import { entitiesService } from '../../../services/entitiesService';
import styles from './ListarSeguradoras.module.css';

interface Seguradora {
  id?: number;
  cnpj: string;
  razaoSocial: string;
  nomeFantasia?: string;
  apolice?: string;
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

export function ListarSeguradoras() {
  const [seguradoras, setSeguradoras] = useState<Seguradora[]>([]);
  const [carregando, setCarregando] = useState(false);
  const [filtro, setFiltro] = useState('');
  const [filtroStatus, setFiltroStatus] = useState('');

  // Estados para paginação
  const [paginaAtual, setPaginaAtual] = useState(1);
  const [tamanhoPagina, setTamanhoPagina] = useState(10);
  const [paginacao, setPaginacao] = useState<PaginationData | null>(null);

  // Estados para modais
  const [modalVisualizacao, setModalVisualizacao] = useState(false);
  const [modalEdicao, setModalEdicao] = useState(false);
  const [seguradoraSelecionada, setSeguradoraSelecionada] = useState<Seguradora | null>(null);
  const [dadosFormulario, setDadosFormulario] = useState<Partial<Seguradora>>({});
  const [salvando, setSalvando] = useState(false);

  // Estados do modal de exclusão
  const [modalExclusao, setModalExclusao] = useState(false);
  const [seguradoraExclusao, setSeguradoraExclusao] = useState<Seguradora | null>(null);
  const [excludindo, setExcluindo] = useState(false);

  useEffect(() => {
    carregarSeguradoras();
  }, [paginaAtual, tamanhoPagina, filtro, filtroStatus]);

  const carregarSeguradoras = async () => {
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

      const response = await fetch(`${API_BASE_URL}/seguradoras?${params}`);

      if (!response.ok) {
        throw new Error(`Erro ${response.status}: ${response.statusText}`);
      }

      const data = await response.json();

      const seguradorasMapeadas: Seguradora[] = (data.items || data.Itens || []).map((seguradora: any) => ({
        id: seguradora.id || seguradora.Id,
        cnpj: seguradora.cnpj || seguradora.Cnpj,
        razaoSocial: seguradora.razaoSocial || seguradora.RazaoSocial || seguradora.nome || seguradora.Nome,
        nomeFantasia: seguradora.nomeFantasia || seguradora.NomeFantasia,
        apolice: seguradora.apolice || seguradora.Apolice,
        ativo: seguradora.ativo !== undefined ? seguradora.ativo : (seguradora.Ativo !== undefined ? seguradora.Ativo : true)
      }));

      setSeguradoras(seguradorasMapeadas);
      setPaginacao({
        totalItems: data.totalItems || data.TotalItens || seguradorasMapeadas.length,
        totalPages: data.totalPages || data.TotalPaginas || 1,
        currentPage: data.currentPage || data.Pagina || 1,
        pageSize: data.pageSize || data.TamanhoPagina || 10,
        hasNextPage: data.hasNextPage || data.TemProxima || false,
        hasPreviousPage: data.hasPreviousPage || data.TemAnterior || false,
        startItem: data.startItem || 1,
        endItem: data.endItem || seguradorasMapeadas.length
      });
    } catch (error) {
      console.error('Erro ao carregar seguradoras:', error);
      setSeguradoras([]);
      setPaginacao({
        totalItems: 0,
        totalPages: 1,
        currentPage: 1,
        pageSize: 10,
        hasNextPage: false,
        hasPreviousPage: false,
        startItem: 0,
        endItem: 0
      });
    } finally {
      setCarregando(false);
    }
  };

  const abrirModalVisualizacao = (seguradora: Seguradora) => {
    setSeguradoraSelecionada(seguradora);
    setModalVisualizacao(true);
  };

  const abrirModalEdicao = (seguradora?: Seguradora) => {
    if (seguradora) {
      setSeguradoraSelecionada(seguradora);
      setDadosFormulario(seguradora);
    } else {
      setSeguradoraSelecionada(null);
      setDadosFormulario({});
    }
    setModalEdicao(true);
  };

  const fecharModais = () => {
    setModalVisualizacao(false);
    setModalEdicao(false);
    setSeguradoraSelecionada(null);
    setDadosFormulario({});
  };

  const salvarSeguradora = async () => {
    setSalvando(true);
    try {
      const dadosParaSalvar = {
        cnpj: dadosFormulario.cnpj ? cleanNumericString(dadosFormulario.cnpj) : undefined,
        razaoSocial: dadosFormulario.razaoSocial?.trim(),
        nomeFantasia: dadosFormulario.nomeFantasia?.trim(),
        apolice: dadosFormulario.apolice?.trim(),
        ativo: dadosFormulario.ativo !== false
      };

      let resposta;
      if (seguradoraSelecionada?.id) {
        resposta = await entitiesService.atualizarSeguradora(seguradoraSelecionada.id, dadosParaSalvar);
      } else {
        resposta = await entitiesService.criarSeguradora(dadosParaSalvar);
      }

      if (resposta.sucesso) {
        fecharModais();
        carregarSeguradoras();
      } else {
        alert(`Erro ao salvar seguradora: ${resposta.mensagem}`);
      }
    } catch (error) {
      console.error('Erro ao salvar seguradora:', error);
      alert('Erro inesperado ao salvar seguradora. Verifique os dados e tente novamente.');
    } finally {
      setSalvando(false);
    }
  };

  const abrirModalExclusao = (seguradora: Seguradora) => {
    setSeguradoraExclusao(seguradora);
    setModalExclusao(true);
  };

  const fecharModalExclusao = () => {
    setModalExclusao(false);
    setSeguradoraExclusao(null);
    setExcluindo(false);
  };

  const confirmarExclusao = async () => {
    if (!seguradoraExclusao?.id) return;

    try {
      setExcluindo(true);
      const resposta = await entitiesService.excluirSeguradora(seguradoraExclusao.id);

      if (resposta.sucesso) {
        fecharModalExclusao();
        carregarSeguradoras();
      } else {
        alert(`Erro ao excluir seguradora: ${resposta.mensagem}`);
        setExcluindo(false);
      }
    } catch (error) {
      console.error('Erro ao excluir seguradora:', error);
      alert('Erro inesperado ao excluir seguradora. Tente novamente.');
      setExcluindo(false);
    }
  };

  const limparFiltros = () => {
    setFiltro('');
    setFiltroStatus('');
    setPaginaAtual(1);
  };

  const atualizarCampo = (campo: string, valor: any) => {
    setDadosFormulario(prev => ({
      ...prev,
      [campo]: valor
    }));
  };

  return (
    <div className={styles.container}>
      <div className={styles.header}>
        <h1>
          <i className="fas fa-shield-alt"></i>
          Seguradoras
        </h1>
        <button className={styles.btnNovo} onClick={() => abrirModalEdicao()}>
          Nova Seguradora
        </button>
      </div>

      <div className={styles.filters}>
        <div className={styles.filtersRow}>
          <div className={styles.filterField}>
            <label>Buscar</label>
            <input
              type="text"
              className={styles.searchInput}
              placeholder="Buscar por razão social ou CNPJ..."
              value={filtro}
              onChange={(e) => setFiltro(e.target.value)}
            />
          </div>

          <div className={styles.filterField}>
            <label>Status</label>
            <select
              value={filtroStatus}
              onChange={(e) => setFiltroStatus(e.target.value)}
            >
              <option value="">Todos</option>
              <option value="ativo">Ativo</option>
              <option value="inativo">Inativo</option>
            </select>
          </div>

          <button className={styles.btnClearFilters} onClick={limparFiltros}>
            Limpar Filtros
          </button>
        </div>
      </div>

      <div className={styles.list}>
        {carregando ? (
          <div className={styles.loading}>Carregando seguradoras...</div>
        ) : seguradoras.length === 0 ? (
          <div className={styles.emptyState}>
            <h3>Nenhuma seguradora encontrada</h3>
            <p>Adicione uma nova seguradora para começar.</p>
          </div>
        ) : (
          <div className={styles.table}>
            <div className={styles.tableHeader}>
              <div>CNPJ</div>
              <div>Razão Social</div>
              <div>Apólice</div>
              <div>Status</div>
              <div>Ações</div>
            </div>
            {seguradoras.map((seguradora) => (
              <div key={seguradora.id} className={styles.tableRow}>
                <div>
                  <strong>{formatCNPJ(seguradora.cnpj)}</strong>
                </div>
                <div>
                  <strong>{seguradora.razaoSocial}</strong>
                  {seguradora.nomeFantasia && <div className={styles.subtext}>{seguradora.nomeFantasia}</div>}
                </div>
                <div>
                  <span className={styles.apolice}>{seguradora.apolice || 'N/A'}</span>
                </div>
                <div>
                  <span className={`${styles.status} ${seguradora.ativo ? styles.ativo : styles.inativo}`}>
                    {seguradora.ativo ? 'Ativo' : 'Inativo'}
                  </span>
                </div>
                <div className={styles.actions}>
                  <button
                    className={styles.btnView}
                    onClick={() => abrirModalVisualizacao(seguradora)}
                  >
                    Visualizar
                  </button>
                  <button
                    className={styles.btnEdit}
                    onClick={() => abrirModalEdicao(seguradora)}
                  >
                    Editar
                  </button>
                  <button
                    className={styles.btnDelete}
                    onClick={() => abrirModalExclusao(seguradora)}
                  >
                    Excluir
                  </button>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>

      {paginacao && paginacao.totalItems > 0 && (
        <div className={styles.paginationContainer}>
          <div className={styles.paginationControls}>
            <div className={styles.paginationInfo}>
              Mostrando {paginacao.startItem} até {paginacao.endItem} de {paginacao.totalItems} seguradoras
            </div>

            {paginacao.totalPages > 1 && (
              <div className={styles.pagination}>
                <button
                  onClick={() => setPaginaAtual(paginacao.currentPage - 1)}
                  disabled={!paginacao.hasPreviousPage}
                  className={styles.paginationBtn}
                >
                  ← Anterior
                </button>

                <span className={styles.pageInfo}>
                  Página {paginacao.currentPage} de {paginacao.totalPages}
                </span>

                <button
                  onClick={() => setPaginaAtual(paginacao.currentPage + 1)}
                  disabled={!paginacao.hasNextPage}
                  className={styles.paginationBtn}
                >
                  Próxima →
                </button>
              </div>
            )}

            <div className={styles.pageSizeSelector}>
              <label>Itens por página:</label>
              <select
                value={tamanhoPagina}
                onChange={(e) => {
                  setTamanhoPagina(Number(e.target.value));
                  setPaginaAtual(1);
                }}
                className={styles.pageSizeSelect}
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

      {modalVisualizacao && seguradoraSelecionada && (
        <div className={styles.modalOverlay} onClick={fecharModais}>
          <div className={styles.modal} onClick={(e) => e.stopPropagation()}>
            <div className={styles.modalHeader}>
              <h2>Visualizar Seguradora</h2>
              <button className={styles.closeBtn} onClick={fecharModais}>×</button>
            </div>
            <div className={styles.modalContent}>
              <div className={styles.modalSection}>
                <h3>Dados Principais</h3>
                <div className={styles.viewGrid}>
                  <div className={styles.viewField}>
                    <label>CNPJ:</label>
                    <span>{formatCNPJ(seguradoraSelecionada.cnpj)}</span>
                  </div>
                  <div className={styles.viewField}>
                    <label>Razão Social:</label>
                    <span>{seguradoraSelecionada.razaoSocial}</span>
                  </div>
                  {seguradoraSelecionada.nomeFantasia && (
                    <div className={styles.viewField}>
                      <label>Nome Fantasia:</label>
                      <span>{seguradoraSelecionada.nomeFantasia}</span>
                    </div>
                  )}
                  {seguradoraSelecionada.apolice && (
                    <div className={styles.viewField}>
                      <label>Apólice:</label>
                      <span>{seguradoraSelecionada.apolice}</span>
                    </div>
                  )}
                  <div className={styles.viewField}>
                    <label>Status:</label>
                    <span className={`${styles.statusBadge} ${seguradoraSelecionada.ativo ? styles.ativo : styles.inativo}`}>
                      {seguradoraSelecionada.ativo ? 'Ativo' : 'Inativo'}
                    </span>
                  </div>
                </div>
              </div>
            </div>
            <div className={styles.modalActions}>
              <button className={styles.btnCancel} onClick={fecharModais}>
                Fechar
              </button>
              <button className={styles.btnEdit} onClick={() => {
                setModalVisualizacao(false);
                abrirModalEdicao(seguradoraSelecionada);
              }}>
                Editar
              </button>
            </div>
          </div>
        </div>
      )}

      {modalEdicao && (
        <div className={styles.modalOverlay} onClick={fecharModais}>
          <div className={styles.modal} onClick={(e) => e.stopPropagation()}>
            <div className={styles.modalHeader}>
              <h2>{seguradoraSelecionada ? 'Editar Seguradora' : 'Nova Seguradora'}</h2>
              <button className={styles.closeBtn} onClick={fecharModais}>×</button>
            </div>
            <form className={styles.modalForm} onSubmit={(e) => { e.preventDefault(); salvarSeguradora(); }}>
              <div className={styles.modalSection}>
                <h3>Dados Principais</h3>
                <div className={styles.modalRow}>
                  <div className={styles.modalField}>
                    <label>CNPJ *</label>
                    <input
                      type="text"
                      value={dadosFormulario.cnpj ? formatCNPJ(dadosFormulario.cnpj) : ''}
                      onChange={(e) => atualizarCampo('cnpj', cleanNumericString(e.target.value))}
                      maxLength={18}
                      placeholder="00.000.000/0000-00"
                      required
                    />
                  </div>
                  <div className={styles.modalField}>
                    <label>Razão Social *</label>
                    <input
                      type="text"
                      value={dadosFormulario.razaoSocial || ''}
                      onChange={(e) => atualizarCampo('razaoSocial', e.target.value)}
                      required
                    />
                  </div>
                </div>
                <div className={styles.modalRow}>
                  <div className={styles.modalField}>
                    <label>Nome Fantasia</label>
                    <input
                      type="text"
                      value={dadosFormulario.nomeFantasia || ''}
                      onChange={(e) => atualizarCampo('nomeFantasia', e.target.value)}
                    />
                  </div>
                  <div className={styles.modalField}>
                    <label>Apólice</label>
                    <input
                      type="text"
                      value={dadosFormulario.apolice || ''}
                      onChange={(e) => atualizarCampo('apolice', e.target.value)}
                      placeholder="Número da apólice"
                    />
                  </div>
                </div>
              </div>

              <div className={styles.modalActions}>
                <button type="button" className={styles.btnCancel} onClick={fecharModais}>
                  Cancelar
                </button>
                <button type="submit" className={styles.btnSave} disabled={salvando}>
                  {salvando ? 'Salvando...' : 'Salvar'}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}

      <ConfirmDeleteModal
        isOpen={modalExclusao}
        title="Excluir Seguradora"
        message="Tem certeza de que deseja excluir esta seguradora?"
        itemName={seguradoraExclusao ? `${seguradoraExclusao.razaoSocial} (${formatCNPJ(seguradoraExclusao.cnpj)})` : ''}
        onConfirm={confirmarExclusao}
        onCancel={fecharModalExclusao}
        loading={excludindo}
      />
    </div>
  );
}