import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import styles from './ListarMDFe.module.css';
import Pagination from '../../../components/UI/Pagination/Pagination';

interface MDFe {
  id: number;
  numero: string;
  serie: string;
  dataEmissao: string;
  ufInicio: string;
  ufFim: string;
  valorCarga: number;
  status: 'Autorizado' | 'Pendente' | 'Cancelado' | 'Rejeitado' | 'Rascunho';
  chave: string;
  emitenteNome?: string;
  veiculoPlaca?: string;
}

export function ListarMDFe() {
  const navigate = useNavigate();
  const [mdfes, setMDFes] = useState<MDFe[]>([]);
  const [carregando, setCarregando] = useState(false);
  const [filtro, setFiltro] = useState('');
  const [statusFiltro, setStatusFiltro] = useState('todos');
  const [paginaAtual, setPaginaAtual] = useState(1);
  const [itensPorPagina, setItensPorPagina] = useState(10);

  useEffect(() => {
    carregarMDFes();
  }, []);

  const carregarMDFes = async () => {
    try {
      setCarregando(false);
      const response = await fetch('/api/mdfe');

      if (response.ok) {
        const data = await response.json();
        // Garantir que sempre seja um array
        const mdfesArray = Array.isArray(data) ? data : (data?.items || data?.data || []);
        setMDFes(mdfesArray);
      } else {
        setMDFes([]);
      }
    } catch (error) {
      console.error('Erro ao carregar MDFes:', error);
      setMDFes([]);
    } finally {
      setCarregando(false);
    }
  };

  const getStatusConfig = (status: string) => {
    switch (status) {
      case 'Autorizado':
        return { color: 'success', bgColor: '#dcfce7', textColor: '#166534' };
      case 'Pendente':
        return { color: 'warning', bgColor: '#fef3c7', textColor: '#92400e' };
      case 'Rascunho':
        return { color: 'draft', bgColor: '#f3f4f6', textColor: '#374151' };
      case 'Cancelado':
        return { color: 'secondary', bgColor: '#f1f5f9', textColor: '#64748b' };
      case 'Rejeitado':
        return { color: 'danger', bgColor: '#fee2e2', textColor: '#dc2626' };
      default:
        return { color: 'secondary', bgColor: '#f3f4f6', textColor: '#6b7280' };
    }
  };

  const formatCurrency = (value: number) => {
    return new Intl.NumberFormat('pt-BR', {
      style: 'currency',
      currency: 'BRL'
    }).format(value);
  };

  const formatDate = (dateString: string) => {
    return new Date(dateString).toLocaleDateString('pt-BR', {
      day: '2-digit',
      month: '2-digit',
      year: 'numeric',
      hour: '2-digit',
      minute: '2-digit'
    });
  };

  const mdfesFiltrados = Array.isArray(mdfes) ? mdfes.filter(mdfe => {
    const matchFiltro = mdfe.numero.toLowerCase().includes(filtro.toLowerCase()) ||
                       mdfe.emitenteNome?.toLowerCase().includes(filtro.toLowerCase()) ||
                       mdfe.veiculoPlaca?.toLowerCase().includes(filtro.toLowerCase());

    const matchStatus = statusFiltro === 'todos' || mdfe.status === statusFiltro;

    return matchFiltro && matchStatus;
  }) : [];

  // Cálculos de paginação
  const totalItems = mdfesFiltrados.length;
  const totalPages = Math.ceil(totalItems / itensPorPagina);
  const startIndex = (paginaAtual - 1) * itensPorPagina;
  const endIndex = startIndex + itensPorPagina;
  const mdfesPaginados = mdfesFiltrados.slice(startIndex, endIndex);

  // Reset da página quando filtros mudam
  useEffect(() => {
    setPaginaAtual(1);
  }, [filtro, statusFiltro]);

  const handlePageChange = (page: number) => {
    setPaginaAtual(page);
  };

  const handleItemsPerPageChange = (items: number) => {
    setItensPorPagina(items);
    setPaginaAtual(1);
  };

  if (carregando) {
    return (
      <div className="mdfe-list-container">
        <div className="loading-container">
          <div className="loading-spinner"></div>
          <p>Carregando manifestos...</p>
        </div>
      </div>
    );
  }

  return (
    <div className={styles.container}>
      {/* Header */}
      <div className="mdfe-list-header">
        <div className="header-content">
          <div className="title-section">
            <div>
              <h1>Manifestos Eletrônicos</h1>
              <p>Gerencie seus MDFe de forma profissional</p>
            </div>
          </div>

          <button
            className={styles.btnNovo}
            onClick={() => navigate('/mdfes/novo')}
          >
            Novo MDFe
          </button>
        </div>

        {/* Dashboard Stats */}
        <div className="dashboard-stats">
          <div className="stat-card">
            <div className="stat-content">
              <div className="stat-number">{mdfes.length}</div>
              <div className="stat-label">Total</div>
            </div>
          </div>

          <div className="stat-card">
            <div className="stat-content">
              <div className="stat-number">{mdfes.filter(m => m.status === 'Autorizado').length}</div>
              <div className="stat-label">Autorizados</div>
            </div>
          </div>

          <div className="stat-card">
            <div className="stat-content">
              <div className="stat-number">{mdfes.filter(m => m.status === 'Pendente').length}</div>
              <div className="stat-label">Pendentes</div>
            </div>
          </div>

        </div>

        {/* Filtros */}
        <div className="filters-section">
          <div className="search-container">
            <input
              type="text"
              placeholder="Buscar por número, emitente ou veículo..."
              value={filtro}
              onChange={(e) => setFiltro(e.target.value)}
              className="search-input"
            />
          </div>
          
          <select
            value={statusFiltro}
            onChange={(e) => setStatusFiltro(e.target.value)}
            className="status-filter"
          >
            <option value="todos">Todos os Status</option>
            <option value="Autorizado">Autorizado</option>
            <option value="Pendente">Pendente</option>
            <option value="Rascunho">Rascunho</option>
            <option value="Cancelado">Cancelado</option>
            <option value="Rejeitado">Rejeitado</option>
          </select>

          <select
            value={itensPorPagina}
            onChange={(e) => handleItemsPerPageChange(Number(e.target.value))}
            className="items-per-page-filter"
          >
            <option value={5}>5 por página</option>
            <option value={10}>10 por página</option>
            <option value={25}>25 por página</option>
            <option value={50}>50 por página</option>
          </select>
        </div>
      </div>

      {/* Lista de MDFes */}
      <div className="mdfe-list-content">
        {totalItems > 0 && (
          <div className="pagination-info">
            <span>
              Mostrando {startIndex + 1} a {Math.min(endIndex, totalItems)} de {totalItems} MDFes
            </span>
          </div>
        )}

        {mdfesFiltrados.length === 0 ? (
          <div className="empty-state">
            <h3>Nenhum MDFe encontrado</h3>
            <p>
              {mdfes.length === 0
                ? "Você ainda não possui nenhum manifesto eletrônico."
                : "Nenhum MDFe corresponde aos filtros selecionados."
              }
            </p>
          </div>
        ) : (
          <div className="mdfe-grid-container">
            <div className="grid-table">
              <div className="grid-header">
                <div className="grid-col col-numero">Número</div>
                <div className="grid-col col-emitente">Emitente</div>
                <div className="grid-col col-veiculo">Veículo</div>
                <div className="grid-col col-percurso">Percurso</div>
                <div className="grid-col col-valor">Valor</div>
                <div className="grid-col col-data">Data/Hora</div>
                <div className="grid-col col-status">Status</div>
                <div className="grid-col col-acoes">Ações</div>
              </div>
              
              <div className="grid-body">
                {mdfesPaginados.map((mdfe) => {
                  const statusConfig = getStatusConfig(mdfe.status);

                  return (
                    <div key={mdfe.id} className="grid-row">
                      <div className="grid-col col-numero">
                        <div className="numero-info">
                          <div>
                            <span className="numero">Nº {mdfe.numero}</span>
                            <span className="serie">Série {mdfe.serie}</span>
                          </div>
                        </div>
                      </div>

                      <div className="grid-col col-emitente">
                        <div className="emitente-info">
                          <span>{mdfe.emitenteNome || 'N/A'}</span>
                        </div>
                      </div>

                      <div className="grid-col col-veiculo">
                        <div className="veiculo-info">
                          <span>{mdfe.veiculoPlaca || 'N/A'}</span>
                        </div>
                      </div>

                      <div className="grid-col col-percurso">
                        <div className="percurso-info">
                          <span>{mdfe.ufInicio} → {mdfe.ufFim}</span>
                        </div>
                      </div>

                      <div className="grid-col col-valor">
                        <div className="valor-info">
                          <span>{formatCurrency(mdfe.valorCarga)}</span>
                        </div>
                      </div>

                      <div className="grid-col col-data">
                        <div className="data-info">
                          <span>{formatDate(mdfe.dataEmissao)}</span>
                        </div>
                      </div>

                      <div className="grid-col col-status">
                        <div
                          className="status-badge-grid"
                          style={{
                            backgroundColor: statusConfig.bgColor,
                            color: statusConfig.textColor
                          }}
                        >
                          <span>{mdfe.status}</span>
                        </div>
                      </div>
                      
                      <div className="grid-col col-acoes">
                        <div className="grid-actions">
                          <button className="grid-action-btn view" title="Visualizar">
                            Ver
                          </button>

                          {mdfe.status === 'Rascunho' ? (
                            <button
                              className="grid-action-btn edit primary"
                              title="Continuar Editando"
                              onClick={() => navigate(`/mdfes/editar/${mdfe.id}`)}
                            >
                              Editar
                            </button>
                          ) : (
                            <button className="grid-action-btn edit" title="Editar">
                              Editar
                            </button>
                          )}

                          <button className="grid-action-btn download" title="Download">
                            Download
                          </button>
                          {mdfe.status !== 'Cancelado' && (
                            <button className="grid-action-btn cancel" title="Cancelar">
                              Cancelar
                            </button>
                          )}
                        </div>
                      </div>
                    </div>
                  );
                })}
              </div>
            </div>

            {totalPages > 1 && (
              <Pagination
                currentPage={paginaAtual}
                totalPages={totalPages}
                onPageChange={handlePageChange}
              />
            )}
          </div>
        )}
      </div>
    </div>
  );
};