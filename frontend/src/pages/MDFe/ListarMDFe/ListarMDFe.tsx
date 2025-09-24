import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import styles from './ListarMDFe.module.css';
import Pagination from '../../../components/UI/Pagination/Pagination';
import { MDFeNumberBadge } from '../../../components/UI/MDFe/MDFeNumberBadge';
import { MDFeViewModal } from '../../../components/UI/Modal/MDFeViewModal';
import { mdfeService } from '../../../services/mdfeService';

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
  const [selectedMDFe, setSelectedMDFe] = useState<MDFe | null>(null);
  const [showViewModal, setShowViewModal] = useState(false);

  useEffect(() => {
    carregarMDFes();
  }, []);

  const carregarMDFes = async () => {
    try {
      setCarregando(true);
      const response = await mdfeService.listarMDFes({
        tamanhoPagina: 1000 // Buscar todos os MDFes
      });

      if (response.sucesso && response.dados) {
        // O backend retorna dados paginados: { Itens: [], TotalItens: 0, Pagina: 1, TamanhoPagina: 10 }
        const mdfesArray = response.dados.Itens || response.dados.Items || response.dados.itens || response.dados.items || response.dados;
        setMDFes(Array.isArray(mdfesArray) ? mdfesArray : []);
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

  const handleViewMDFe = (mdfe: MDFe) => {
    setSelectedMDFe(mdfe);
    setShowViewModal(true);
  };

  const handleCloseViewModal = () => {
    setShowViewModal(false);
    setSelectedMDFe(null);
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
    <div className={styles.mdfeListContainer}>
      {/* Header */}
      <div className={styles.mdfeListHeader}>
        <div className={styles.headerContent}>
          <div className={styles.titleSection}>
            <div>
              <h1>Manifestos Eletrônicos</h1>
              <p>Gerencie seus MDFe de forma profissional</p>
            </div>
          </div>

          <button
            className={styles.btnNovoMdfe}
            onClick={() => navigate('/mdfes/novo')}
          >
            <span style={{ fontSize: '1.2rem', fontWeight: 'bold' }}>+</span>
            <span>Novo MDFe</span>
          </button>
        </div>

        {/* Dashboard Stats */}
        <div className={styles.dashboardStats}>
          <div className={styles.statCard}>
            <div className={styles.statHeader}>
              <div className={styles.statIcon}>
                <i className="fas fa-file-alt"></i>
              </div>
              <div className={styles.statTrend}>
                <i className="fas fa-arrow-up"></i>
              </div>
            </div>
            <div className={styles.statContent}>
              <div className={styles.statNumber}>{mdfes.length}</div>
              <div className={styles.statLabel}>Total MDF-es</div>
            </div>
          </div>

          <div className={styles.statCard}>
            <div className={styles.statHeader}>
              <div className={`${styles.statIcon} ${styles.success}`}>
                <i className="fas fa-check-circle"></i>
              </div>
              <div className={styles.statTrend}>
                <i className="fas fa-arrow-up"></i>
              </div>
            </div>
            <div className={styles.statContent}>
              <div className={styles.statNumber}>{mdfes.filter(m => m.status === 'Autorizado').length}</div>
              <div className={styles.statLabel}>Autorizados</div>
            </div>
          </div>

          <div className={styles.statCard}>
            <div className={styles.statHeader}>
              <div className={`${styles.statIcon} ${styles.warning}`}>
                <i className="fas fa-clock"></i>
              </div>
              <div className={styles.statTrend}>
                <i className="fas fa-arrow-up"></i>
              </div>
            </div>
            <div className={styles.statContent}>
              <div className={styles.statNumber}>{mdfes.filter(m => m.status === 'Pendente').length}</div>
              <div className={styles.statLabel}>Pendentes</div>
            </div>
          </div>

          <div className={styles.statCard}>
            <div className={styles.statHeader}>
              <div className={`${styles.statIcon} ${styles.danger}`}>
                <i className="fas fa-times-circle"></i>
              </div>
              <div className={styles.statTrend}>
                <i className="fas fa-arrow-down"></i>
              </div>
            </div>
            <div className={styles.statContent}>
              <div className={styles.statNumber}>{mdfes.filter(m => m.status === 'Rejeitado' || m.status === 'Cancelado').length}</div>
              <div className={styles.statLabel}>Rejeitados/Cancelados</div>
            </div>
          </div>

        </div>

        {/* Filtros */}
        <div className={styles.filtersSection}>
          <div className={styles.searchContainer}>
            <input
              type="text"
              placeholder="Buscar por número, emitente ou veículo..."
              value={filtro}
              onChange={(e) => setFiltro(e.target.value)}
              className={styles.searchInput}
            />
          </div>

          <select
            value={statusFiltro}
            onChange={(e) => setStatusFiltro(e.target.value)}
            className={styles.statusFilter}
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
            className={styles.itemsPerPageFilter}
          >
            <option value={5}>5 por página</option>
            <option value={10}>10 por página</option>
            <option value={25}>25 por página</option>
            <option value={50}>50 por página</option>
          </select>
        </div>
      </div>

      {/* Lista de MDFes */}
      <div className={styles.mdfeListContent}>
        {totalItems > 0 && (
          <div className={styles.paginationInfo}>
            <span>
              Mostrando {startIndex + 1} a {Math.min(endIndex, totalItems)} de {totalItems} MDFes
            </span>
          </div>
        )}

        {mdfesFiltrados.length === 0 ? (
          <div className={styles.emptyState}>
            <div className={styles.emptyIcon}>
              <i className="fas fa-file-alt"></i>
            </div>
            <h3>Nenhum MDFe encontrado</h3>
            <p>
              {mdfes.length === 0
                ? "Você ainda não possui nenhum manifesto eletrônico."
                : "Nenhum MDFe corresponde aos filtros selecionados."
              }
            </p>
            {mdfes.length === 0 && (
              <button
                className={styles.btnPrimaryLarge}
                onClick={() => navigate('/mdfes/novo')}
              >
                <i className="fas fa-plus"></i>
                Criar primeiro MDF-e
              </button>
            )}
          </div>
        ) : (
          <div className={styles.mdfeGridContainer}>
            <div className={styles.gridTable}>
              <div className={styles.gridHeader}>
                <div className={styles.gridCol}>MDFe / Série</div>
                <div className={styles.gridCol}>Emitente</div>
                <div className={styles.gridCol}>Veículo</div>
                <div className={styles.gridCol}>Percurso</div>
                <div className={styles.gridCol}>Valor</div>
                <div className={styles.gridCol}>Data/Hora</div>
                <div className={styles.gridCol}>Status</div>
                <div className={styles.gridCol}>Ações</div>
              </div>
              
              <div className={styles.gridBody}>
                {mdfesPaginados.map((mdfe) => {
                  const statusConfig = getStatusConfig(mdfe.status);

                  return (
                    <div key={mdfe.id} className={styles.gridRow}>
                      <div className={styles.gridCol}>
                        <MDFeNumberBadge
                          numero={mdfe.numero}
                          serie={mdfe.serie}
                          size="medium"
                          variant="primary"
                        />
                      </div>

                      <div className={styles.gridCol}>
                        <div className={styles.emitenteInfo}>
                          <span>{mdfe.emitenteNome || 'N/A'}</span>
                        </div>
                      </div>

                      <div className={styles.gridCol}>
                        <div className={styles.veiculoInfo}>
                          <span>{mdfe.veiculoPlaca || 'N/A'}</span>
                        </div>
                      </div>

                      <div className={styles.gridCol}>
                        <div className={styles.percursoInfo}>
                          <span>{mdfe.ufInicio} → {mdfe.ufFim}</span>
                        </div>
                      </div>

                      <div className={styles.gridCol}>
                        <div className={styles.valorInfo}>
                          <span>{formatCurrency(mdfe.valorCarga)}</span>
                        </div>
                      </div>

                      <div className={styles.gridCol}>
                        <div className={styles.dataInfo}>
                          <span>{formatDate(mdfe.dataEmissao)}</span>
                        </div>
                      </div>

                      <div className={styles.gridCol}>
                        <div
                          className={styles.statusBadgeGrid}
                          style={{
                            backgroundColor: statusConfig.bgColor,
                            color: statusConfig.textColor
                          }}
                        >
                          <span>{mdfe.status}</span>
                        </div>
                      </div>

                      <div className={styles.gridCol}>
                        <div className={styles.gridActions}>
                          <button
                            className={`${styles.gridActionBtn} ${styles.view}`}
                            title="Visualizar"
                            onClick={() => handleViewMDFe(mdfe)}
                          >
                            <i className="fas fa-eye"></i>
                          </button>

                          {mdfe.status === 'Rascunho' ? (
                            <button
                              className={`${styles.gridActionBtn} ${styles.edit}`}
                              title="Continuar Editando"
                              onClick={() => navigate(`/mdfes/editar/${mdfe.id}`)}
                            >
                              <i className="fas fa-edit"></i>
                            </button>
                          ) : (
                            <button className={`${styles.gridActionBtn} ${styles.edit}`} title="Editar">
                              <i className="fas fa-edit"></i>
                            </button>
                          )}

                          <button
                            className={`${styles.gridActionBtn} ${styles.download}`}
                            title="Download"
                            onClick={() => {
                              // Implementar download do XML/PDF
                              alert('Funcionalidade de download será implementada em breve');
                            }}
                          >
                            <i className="fas fa-download"></i>
                          </button>
                          {mdfe.status !== 'Cancelado' && (
                            <button
                              className={`${styles.gridActionBtn} ${styles.cancel}`}
                              title="Cancelar"
                              onClick={() => {
                                if (confirm(`Deseja realmente cancelar o MDFe ${mdfe.numero}?`)) {
                                  alert('Funcionalidade de cancelamento será implementada em breve');
                                }
                              }}
                            >
                              <i className="fas fa-times"></i>
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

      {/* Modal de Visualização */}
      {selectedMDFe && (
        <MDFeViewModal
          mdfe={selectedMDFe}
          isOpen={showViewModal}
          onClose={handleCloseViewModal}
        />
      )}
    </div>
  );
};