import React, { useState, useEffect } from 'react';
import { ConfirmDeleteModal } from '../../../components/UI/Modal/ConfirmDeleteModal';
import { formatCNPJ, cleanNumericString } from '../../../utils/formatters';
import { entitiesService } from '../../../services/entitiesService';
import { useCNPJLookup } from '../../../hooks/useCNPJLookup';
import Icon from '../../../components/UI/Icon';

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

  // Hook para consulta automática de CNPJ
  const { consultarCNPJ, loading: loadingCNPJ, error: errorCNPJ, clearError } = useCNPJLookup();

  useEffect(() => {
    carregarSeguradoras();
  }, [paginaAtual, tamanhoPagina, filtro, filtroStatus]);

  const carregarSeguradoras = async () => {
    setCarregando(true);
    try {
      const API_BASE_URL = process.env.REACT_APP_API_URL || 'https://localhost:5001/api';
      const params = new URLSearchParams({
        pagina: paginaAtual.toString(),
        tamanhoPagina: tamanhoPagina.toString()
      });

      if (filtro.trim()) {
        params.append('busca', filtro.trim());
      }

      const response = await fetch(`${API_BASE_URL}/seguradoras?${params}`);

      if (!response.ok) {
        throw new Error(`Erro ${response.status}: ${response.statusText}`);
      }

      const data = await response.json();

      const seguradorasMapeadas: Seguradora[] = (data.itens || data.items || data.Itens || []).map((seguradora: any) => ({
        id: seguradora.id || seguradora.Id,
        cnpj: seguradora.cnpj || seguradora.Cnpj,
        razaoSocial: seguradora.razaoSocial || seguradora.RazaoSocial || seguradora.nome || seguradora.Nome,
        nomeFantasia: seguradora.nomeFantasia || seguradora.NomeFantasia,
        apolice: seguradora.apolice || seguradora.Apolice,
        ativo: seguradora.ativo !== undefined ? seguradora.ativo : (seguradora.Ativo !== undefined ? seguradora.Ativo : true)
      }));

      setSeguradoras(seguradorasMapeadas);
      setPaginacao({
        totalItems: data.totalItens || data.totalItems || data.TotalItens || seguradorasMapeadas.length,
        totalPages: data.totalPaginas || data.totalPages || data.TotalPaginas || 1,
        currentPage: data.pagina || data.currentPage || data.Pagina || 1,
        pageSize: data.tamanhoPagina || data.pageSize || data.TamanhoPagina || 10,
        hasNextPage: data.temProximaPagina || data.hasNextPage || data.TemProxima || false,
        hasPreviousPage: data.temPaginaAnterior || data.hasPreviousPage || data.TemAnterior || false,
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
    clearError();
  };

  const handleCNPJChange = async (cnpj: string) => {
    const cnpjFormatado = formatCNPJ(cnpj);
    setDadosFormulario(prev => ({ ...prev, cnpj: cnpjFormatado }));

    const cnpjLimpo = cleanNumericString(cnpj);
    if (cnpjLimpo.length === 14) {
      const dadosCNPJ = await consultarCNPJ(cnpjLimpo);

      if (dadosCNPJ) {
        setDadosFormulario(prev => ({
          ...prev,
          cnpj: formatCNPJ(dadosCNPJ.cnpj),
          razaoSocial: dadosCNPJ.razaoSocial,
          nomeFantasia: dadosCNPJ.nomeFantasia || ''
        }));
      }
    }
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
    <div className="max-w-7xl mx-auto px-6 py-8">
      <div className="flex items-center justify-between mb-8">
        <h1>
          <i className="fas fa-shield-alt"></i>
          Seguradoras
        </h1>
        <button className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary-hover font-medium transition-colors duration-200" onClick={() => abrirModalEdicao()}>
          Nova Seguradora
        </button>
      </div>

      <div className="bg-bg-surface rounded-xl border border-border-primary p-6 mb-6">
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div className="space-y-2">
            <label className="text-sm font-medium text-text-primary">Buscar</label>
            <input
              type="text"
              className="w-full px-3 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary focus:outline-none focus:ring-2 focus:ring-primary"
              placeholder="Buscar por razão social ou CNPJ..."
              value={filtro}
              onChange={(e) => setFiltro(e.target.value)}
            />
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
            Limpar Filtros
          </button>
        </div>
      </div>

      <div className="bg-bg-surface rounded-xl border border-border-primary shadow-sm">
        {carregando ? (
          <div className="flex items-center justify-center py-16">
            <div className="flex items-center gap-4">
              <div className="w-8 h-8 border-4 border-primary border-t-transparent rounded-full animate-spin"></div>
              <span className="text-text-secondary">Carregando seguradoras...</span>
            </div>
          </div>
        ) : seguradoras.length === 0 ? (
          <div className="flex flex-col items-center justify-center py-16 px-6">
            <div className="w-16 h-16 bg-bg-tertiary rounded-full flex items-center justify-center mb-4">
              <i className="fas fa-shield-alt text-2xl text-text-tertiary"></i>
            </div>
            <h3 className="text-lg font-semibold text-text-primary mb-2">Nenhuma seguradora encontrada</h3>
            <p className="text-text-secondary text-center">Adicione uma nova seguradora para começar.</p>
          </div>
        ) : (
          <div className="overflow-x-auto">
            <div className="grid grid-cols-5 gap-4 p-4 bg-bg-tertiary border-b border-border-primary font-semibold text-text-primary">
              <div>CNPJ</div>
              <div>Razão Social</div>
              <div>Apólice</div>
              <div>Status</div>
              <div>Ações</div>
            </div>
            {seguradoras.map((seguradora) => (
              <div key={seguradora.id} className="grid grid-cols-5 gap-4 p-4 border-b border-border-primary hover:bg-bg-surface-hover transition-colors duration-200">
                <div>
                  <strong className="text-text-primary">{formatCNPJ(seguradora.cnpj)}</strong>
                </div>
                <div>
                  <strong className="text-text-primary">{seguradora.razaoSocial}</strong>
                  {seguradora.nomeFantasia && <div className="text-sm text-text-secondary">{seguradora.nomeFantasia}</div>}
                </div>
                <div>
                  <span className="text-text-primary">{seguradora.apolice || 'N/A'}</span>
                </div>
                <div>
                  <span className={`px-2 py-1 rounded-full text-xs font-medium ${
                    seguradora.ativo
                      ? 'bg-green-100 text-green-800 dark:bg-green-900 dark:text-green-300'
                      : 'bg-red-100 text-red-800 dark:bg-red-900 dark:text-red-300'
                  }`}>
                    {seguradora.ativo ? 'Ativo' : 'Inativo'}
                  </span>
                </div>
                <div className="flex items-center gap-2">
                  <button
                    className="px-3 py-1 text-blue-600 hover:bg-blue-50 dark:hover:bg-blue-900/20 rounded transition-colors duration-200"
                    onClick={() => abrirModalVisualizacao(seguradora)}
                  >
                    Visualizar
                  </button>
                  <button
                    className="px-3 py-1 text-amber-600 hover:bg-amber-50 dark:hover:bg-amber-900/20 rounded transition-colors duration-200"
                    onClick={() => abrirModalEdicao(seguradora)}
                  >
                    Editar
                  </button>
                  <button
                    className="px-3 py-1 text-red-600 hover:bg-red-50 dark:hover:bg-red-900/20 rounded transition-colors duration-200"
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
        <div className="mt-6 bg-bg-surface border-t border-border-primary p-4">
          <div className="flex flex-col sm:flex-row justify-between items-center gap-4">
            <div className="text-sm text-text-secondary">
              Mostrando {((paginacao.currentPage - 1) * paginacao.pageSize) + 1} até {Math.min(paginacao.currentPage * paginacao.pageSize, paginacao.totalItems)} de {paginacao.totalItems} seguradoras
            </div>

            {paginacao.totalPages > 1 && (
              <div className="flex items-center gap-2">
                <button
                  onClick={() => setPaginaAtual(paginacao.currentPage - 1)}
                  disabled={!paginacao.hasPreviousPage}
                  className="px-4 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary hover:bg-bg-surface-hover disabled:opacity-50 disabled:cursor-not-allowed transition-colors duration-200"
                >
                  ← Anterior
                </button>

                <span className="px-4 py-2 text-text-primary">
                  Página {paginacao.currentPage} de {paginacao.totalPages}
                </span>

                <button
                  onClick={() => setPaginaAtual(paginacao.currentPage + 1)}
                  disabled={!paginacao.hasNextPage}
                  className="px-4 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary hover:bg-bg-surface-hover disabled:opacity-50 disabled:cursor-not-allowed transition-colors duration-200"
                >
                  Próxima →
                </button>
              </div>
            )}

            <div className="flex items-center gap-2">
              <label className="text-sm text-text-primary">Itens por página:</label>
              <select
                value={tamanhoPagina}
                onChange={(e) => {
                  setTamanhoPagina(Number(e.target.value));
                  setPaginaAtual(1);
                }}
                className="px-3 py-1 border border-border-primary rounded bg-bg-surface text-text-primary focus:outline-none focus:ring-2 focus:ring-primary"
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
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50 backdrop-blur-sm" onClick={fecharModais}>
          <div className="bg-bg-surface rounded-xl border border-border-primary shadow-xl max-w-md w-full mx-4" onClick={(e) => e.stopPropagation()}>
            <div className="flex items-center justify-between p-6 border-b border-border-primary">
              <h2 className="text-xl font-semibold text-text-primary">Visualizar Seguradora</h2>
              <button className="text-text-tertiary hover:text-text-primary transition-colors duration-200 text-2xl" onClick={fecharModais}>×</button>
            </div>
            <div className="p-6">
              <div className="space-y-6">
                <div>
                  <h3 className="text-lg font-medium text-text-primary mb-4">Dados Principais</h3>
                  <div className="grid grid-cols-1 gap-4">
                    <div className="space-y-1">
                      <label className="text-sm font-medium text-text-secondary">CNPJ:</label>
                      <span className="block text-text-primary">{formatCNPJ(seguradoraSelecionada.cnpj)}</span>
                    </div>
                    <div className="space-y-1">
                      <label className="text-sm font-medium text-text-secondary">Razão Social:</label>
                      <span className="block text-text-primary">{seguradoraSelecionada.razaoSocial}</span>
                    </div>
                    {seguradoraSelecionada.nomeFantasia && (
                      <div className="space-y-1">
                        <label className="text-sm font-medium text-text-secondary">Nome Fantasia:</label>
                        <span className="block text-text-primary">{seguradoraSelecionada.nomeFantasia}</span>
                      </div>
                    )}
                    {seguradoraSelecionada.apolice && (
                      <div className="space-y-1">
                        <label className="text-sm font-medium text-text-secondary">Apólice:</label>
                        <span className="block text-text-primary">{seguradoraSelecionada.apolice}</span>
                      </div>
                    )}
                    <div className="space-y-1">
                      <label className="text-sm font-medium text-text-secondary">Status:</label>
                      <span className={`inline-block px-2 py-1 rounded-full text-xs font-medium ${
                        seguradoraSelecionada.ativo
                          ? 'bg-green-100 text-green-800 dark:bg-green-900 dark:text-green-300'
                          : 'bg-red-100 text-red-800 dark:bg-red-900 dark:text-red-300'
                      }`}>
                        {seguradoraSelecionada.ativo ? 'Ativo' : 'Inativo'}
                      </span>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div className="flex items-center justify-end gap-4 p-6 border-t border-border-primary">
              <button className="px-4 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary hover:bg-bg-surface-hover transition-colors duration-200" onClick={fecharModais}>
                Fechar
              </button>
              <button className="px-4 py-2 bg-amber-500 hover:bg-amber-600 text-white rounded-lg font-medium transition-colors duration-200" onClick={() => {
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
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50 backdrop-blur-sm" onClick={fecharModais}>
          <div className="bg-bg-surface rounded-xl border border-border-primary shadow-xl max-w-2xl w-full mx-4 max-h-[90vh] overflow-y-auto" onClick={(e) => e.stopPropagation()}>
            <div className="flex items-center justify-between p-6 border-b border-border-primary">
              <h2 className="text-xl font-semibold text-text-primary">{seguradoraSelecionada ? 'Editar Seguradora' : 'Nova Seguradora'}</h2>
              <button className="text-text-tertiary hover:text-text-primary transition-colors duration-200 text-2xl" onClick={fecharModais}>×</button>
            </div>
            <form className="p-6" onSubmit={(e) => { e.preventDefault(); salvarSeguradora(); }}>
              <div className="space-y-6">
                <div>
                  <h3 className="text-lg font-medium text-text-primary mb-4">Dados Principais</h3>
                  <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div className="space-y-2">
                      <label className="text-sm font-medium text-text-primary">CNPJ *</label>
                      <input
                        type="text"
                        value={dadosFormulario.cnpj ? formatCNPJ(dadosFormulario.cnpj) : ''}
                        onChange={(e) => handleCNPJChange(e.target.value)}
                        maxLength={18}
                        placeholder="00.000.000/0000-00"
                        required
                        className="w-full px-3 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary focus:outline-none focus:ring-2 focus:ring-primary"
                      />
                      {loadingCNPJ && (
                        <small className="text-blue-600">Consultando CNPJ...</small>
                      )}
                      {errorCNPJ && (
                        <small className="text-red-600">{errorCNPJ}</small>
                      )}
                    </div>
                    <div className="space-y-2">
                      <label className="text-sm font-medium text-text-primary">Razão Social *</label>
                      <input
                        type="text"
                        value={dadosFormulario.razaoSocial || ''}
                        onChange={(e) => atualizarCampo('razaoSocial', e.target.value)}
                        maxLength={200}
                        required
                        className="w-full px-3 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary focus:outline-none focus:ring-2 focus:ring-primary"
                      />
                    </div>
                  </div>
                  <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mt-4">
                    <div className="space-y-2">
                      <label className="text-sm font-medium text-text-primary">Nome Fantasia</label>
                      <input
                        type="text"
                        value={dadosFormulario.nomeFantasia || ''}
                        onChange={(e) => atualizarCampo('nomeFantasia', e.target.value)}
                        maxLength={200}
                        className="w-full px-3 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary focus:outline-none focus:ring-2 focus:ring-primary"
                      />
                    </div>
                    <div className="space-y-2">
                      <label className="text-sm font-medium text-text-primary">Apólice</label>
                      <input
                        type="text"
                        value={dadosFormulario.apolice || ''}
                        onChange={(e) => atualizarCampo('apolice', e.target.value)}
                        placeholder="Número da apólice"
                        maxLength={100}
                        className="w-full px-3 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary focus:outline-none focus:ring-2 focus:ring-primary"
                      />
                    </div>
                  </div>
                </div>
              </div>

              <div className="flex items-center justify-end gap-4 mt-6 pt-6 border-t border-border-primary">
                <button type="button" className="px-4 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary hover:bg-bg-surface-hover transition-colors duration-200" onClick={fecharModais}>
                  Cancelar
                </button>
                <button type="submit" className="px-4 py-2 bg-primary hover:bg-primary-hover text-white rounded-lg font-medium transition-colors duration-200" disabled={salvando}>
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