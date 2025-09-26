import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import styles from './ListarMDFe.module.css';
import Pagination from '../../../components/UI/Pagination/Pagination';
import { MDFeViewModal } from '../../../components/UI/Modal/MDFeViewModal';

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
  const [filtro, setFiltro] = useState('');
  const [statusFiltro, setStatusFiltro] = useState('todos');
  const [paginaAtual, setPaginaAtual] = useState(1);
  const [itensPorPagina, setItensPorPagina] = useState(10);
  const [selectedMDFe, setSelectedMDFe] = useState<MDFe | null>(null);
  const [showViewModal, setShowViewModal] = useState(false);
  const [processando, setProcessando] = useState<number | null>(null);
  const [mensagem, setMensagem] = useState<{ tipo: 'sucesso' | 'erro'; texto: string } | null>(null);

  useEffect(() => {
    carregarMDFes();
  }, []);

  const carregarMDFes = async () => {
    try {
      const response = await fetch(`${process.env.REACT_APP_API_URL || 'https://localhost:5001/api'}/mdfe?pagina=1&tamanhoPagina=50`);

      if (!response.ok) {
        throw new Error('Erro ao carregar MDF-es');
      }

      const data = await response.json();

      // Mapear os dados da API para o formato esperado pelo componente
      const mdfesMapeados: MDFe[] = data.itens?.map((item: any) => ({
        id: item.id,
        numero: item.numero?.toString().padStart(9, '0') || '',
        serie: item.serie || '001',
        dataEmissao: item.dataEmissao,
        ufInicio: item.ufIni || '',
        ufFim: item.ufFim || '',
        valorCarga: item.valorTotal || 0,
        status: mapearStatus(item.status),
        chave: item.chave || '',
        emitenteNome: item.emitenteRazaoSocial || '',
        veiculoPlaca: item.veiculoPlaca || ''
      })) || [];

      setMDFes(mdfesMapeados);
    } catch (error) {
      console.error('Erro ao carregar MDFes:', error);
      setMDFes([]); // Define array vazio em caso de erro
    }
  };

  // Função auxiliar para mapear status da API para o formato do componente
  const mapearStatus = (status: string): 'Autorizado' | 'Pendente' | 'Cancelado' | 'Rejeitado' | 'Rascunho' => {
    switch (status?.toUpperCase()) {
      case 'AUTORIZADO':
        return 'Autorizado';
      case 'CANCELADO':
        return 'Cancelado';
      case 'REJEITADO':
        return 'Rejeitado';
      case 'PENDENTE':
        return 'Pendente';
      case 'RASCUNHO':
      default:
        return 'Rascunho';
    }
  };

  // Função para exibir mensagem temporária
  const exibirMensagem = (tipo: 'sucesso' | 'erro', texto: string) => {
    setMensagem({ tipo, texto });
    setTimeout(() => setMensagem(null), 5000);
  };

  // Download do PDF/DAMDFE
  const handleDownloadPDF = async (mdfeId: number, numero: string) => {
    try {
      setProcessando(mdfeId);

      const response = await fetch(`${process.env.REACT_APP_API_URL || 'https://localhost:5001/api'}/mdfe/${mdfeId}/imprimir`, {
        method: 'GET',
        headers: {
          'Accept': 'application/pdf'
        }
      });

      if (!response.ok) {
        throw new Error('Erro ao gerar PDF');
      }

      const blob = await response.blob();
      const url = window.URL.createObjectURL(blob);
      const link = document.createElement('a');
      link.href = url;
      link.download = `DAMDFE_${numero}_${new Date().toISOString().split('T')[0]}.pdf`;
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
      window.URL.revokeObjectURL(url);

      exibirMensagem('sucesso', `PDF do MDFe ${numero} baixado com sucesso!`);
    } catch (error) {
      console.error('Erro ao baixar PDF:', error);
      exibirMensagem('erro', `Erro ao baixar PDF do MDFe ${numero}`);
    } finally {
      setProcessando(null);
    }
  };

  // Duplicar MDFe
  const handleDuplicar = async (mdfeId: number, numero: string) => {
    if (!window.confirm(`Deseja criar um novo MDFe baseado no MDFe ${numero}?`)) {
      return;
    }

    try {
      setProcessando(mdfeId);

      const response = await fetch(`${process.env.REACT_APP_API_URL || 'https://localhost:5001/api'}/mdfe/${mdfeId}/duplicar`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        }
      });

      const resultado = await response.json();

      if (response.ok) {
        exibirMensagem('sucesso', `MDFe duplicado com sucesso!`);
        setTimeout(() => {
          navigate(`/mdfes/editar/${resultado.id}`);
        }, 1500);
      } else {
        exibirMensagem('erro', resultado.message || `Erro ao duplicar MDFe ${numero}`);
      }
    } catch (error) {
      console.error('Erro ao duplicar MDFe:', error);
      exibirMensagem('erro', `Erro ao duplicar MDFe ${numero}`);
    } finally {
      setProcessando(null);
    }
  };

  // Filtrar MDFes
  const mdfesFiltrados = mdfes.filter(mdfe => {
    const passaFiltroTexto = filtro === '' ||
      mdfe.numero.toLowerCase().includes(filtro.toLowerCase()) ||
      mdfe.emitenteNome?.toLowerCase().includes(filtro.toLowerCase()) ||
      mdfe.veiculoPlaca?.toLowerCase().includes(filtro.toLowerCase());

    const passaFiltroStatus = statusFiltro === 'todos' || mdfe.status === statusFiltro;

    return passaFiltroTexto && passaFiltroStatus;
  });

  // Paginação
  const totalItems = mdfesFiltrados.length;
  const totalPages = Math.ceil(totalItems / itensPorPagina);
  const startIndex = (paginaAtual - 1) * itensPorPagina;
  const endIndex = startIndex + itensPorPagina;
  const itensAtuais = mdfesFiltrados.slice(startIndex, endIndex);

  const handlePageChange = (novaPagina: number) => {
    setPaginaAtual(novaPagina);
  };

  const handleItemsPerPageChange = (novoTamanho: number) => {
    setItensPorPagina(novoTamanho);
    setPaginaAtual(1);
  };


  return (
    <div className={styles.container}>
      {/* Mensagem de Feedback */}
      {mensagem && (
        <div className={`${styles.mensagem} ${styles[mensagem.tipo]}`}>
          <i className={`fas ${
            mensagem.tipo === 'sucesso' ? 'fa-check-circle' : 'fa-exclamation-circle'
          }`}></i>
          {mensagem.texto}
          <button
            className={styles.fecharMensagem}
            onClick={() => setMensagem(null)}
          >
            <i className="fas fa-times"></i>
          </button>
        </div>
      )}

      {/* Header */}
      <div className={styles.header}>
        <h1>
          <i className="fas fa-file-alt"></i>
          Manifestos Eletrônicos (MDFe)
        </h1>
        <button
          onClick={() => navigate('/mdfes/novo')}
          className={styles.btnNovo}
        >
          <i className="fas fa-plus"></i>
          Novo MDFe
        </button>
      </div>

      {/* Estatísticas */}
      <div className={styles.dashboardStats}>
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
            <div className={styles.statNumber}>{mdfes.filter(m => m.status === 'Pendente' || m.status === 'Rascunho').length}</div>
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
      <div className={styles.filters}>
        <div className={styles.filtersRow}>
          <div className={styles.filterField}>
            <input
              type="text"
              placeholder="Buscar por número, emitente ou veículo..."
              value={filtro}
              onChange={(e) => setFiltro(e.target.value)}
              className={styles.searchInput}
            />
          </div>

          <div className={styles.filterField}>
            <select
              value={statusFiltro}
              onChange={(e) => setStatusFiltro(e.target.value)}
            >
              <option value="todos">Todos os Status</option>
              <option value="Autorizado">Autorizado</option>
              <option value="Pendente">Pendente</option>
              <option value="Rascunho">Rascunho</option>
              <option value="Cancelado">Cancelado</option>
              <option value="Rejeitado">Rejeitado</option>
            </select>
          </div>

          <div className={styles.filterField}>
            <select
              value={itensPorPagina}
              onChange={(e) => handleItemsPerPageChange(Number(e.target.value))}
            >
              <option value={5}>5 por página</option>
              <option value={10}>10 por página</option>
              <option value={25}>25 por página</option>
              <option value={50}>50 por página</option>
            </select>
          </div>
        </div>
      </div>

      {/* Lista de MDFes */}
      <div className={styles.list}>
        {totalItems > 0 && (
          <div className={styles.paginationInfo}>
            <span>
              Mostrando {startIndex + 1} a {Math.min(endIndex, totalItems)} de {totalItems} MDFes
            </span>
          </div>
        )}

        {itensAtuais.length === 0 ? (
          <div className={styles.emptyState}>
            <div className={styles.emptyIcon}>
              <i className="fas fa-file-alt"></i>
            </div>
            <h3>Nenhum MDFe encontrado</h3>
            <p>
              {filtro || statusFiltro !== 'todos'
                ? 'Tente ajustar os filtros para encontrar o que procura.'
                : 'Comece criando seu primeiro manifesto eletrônico.'
              }
            </p>
            {(!filtro && statusFiltro === 'todos') && (
              <button
                onClick={() => navigate('/mdfes/novo')}
                className={styles.btnPrimaryLarge}
              >
                <i className="fas fa-plus"></i>
                Criar Primeiro MDFe
              </button>
            )}
          </div>
        ) : (
          <div className={styles.table}>
            {/* Header da Tabela */}
            <div className={styles.tableHeader}>
              <div>Número/Série</div>
              <div>Emitente</div>
              <div>Data</div>
              <div>Trajeto</div>
              <div>Veículo</div>
              <div>Valor Carga</div>
              <div>Status</div>
              <div>Ações</div>
            </div>

            {/* Linhas da Tabela */}
            {itensAtuais.map((mdfe) => (
              <div key={mdfe.id} className={styles.tableRow}>
                <div>
                  <strong>#{mdfe.numero}</strong>
                  <div className={styles.subtext}>Série {mdfe.serie}</div>
                </div>

                <div>
                  <span>{mdfe.emitenteNome || 'N/A'}</span>
                </div>

                <div>
                  <span>{new Date(mdfe.dataEmissao).toLocaleDateString('pt-BR')}</span>
                </div>

                <div>
                  <span>{mdfe.ufInicio} → {mdfe.ufFim}</span>
                </div>

                <div>
                  <span>{mdfe.veiculoPlaca || 'N/A'}</span>
                </div>

                <div>
                  <span>R$ {mdfe.valorCarga.toLocaleString('pt-BR', { minimumFractionDigits: 2 })}</span>
                </div>

                <div>
                  <span
                    className={`${styles.status} ${
                      mdfe.status === 'Autorizado' ? styles.ativo :
                      mdfe.status === 'Rascunho' || mdfe.status === 'Pendente' ? styles.pendente :
                      styles.inativo
                    }`}
                  >
                    {mdfe.status}
                  </span>
                </div>

                <div className={styles.actions}>
                  {/* Ação principal por status */}
                  {(mdfe.status === 'Rascunho' || mdfe.status === 'Rejeitado') ? (
                    <button
                      className={styles.btnEdit}
                      title={mdfe.status === 'Rejeitado' ? 'Corrigir & Editar' : 'Continuar Editando'}
                      onClick={() => navigate(`/mdfes/editar/${mdfe.id}`)}
                    >
                      <i className="fas fa-edit"></i>
                    </button>
                  ) : (
                    <button
                      className={styles.btnView}
                      title="Ver Detalhes"
                      onClick={() => navigate(`/mdfes/visualizar/${mdfe.id}`)}
                    >
                      <i className="fas fa-eye"></i>
                    </button>
                  )}

                  {/* Download rápido apenas para autorizados/pendentes */}
                  {(mdfe.status === 'Autorizado' || mdfe.status === 'Pendente') && (
                    <button
                      className={styles.btnView}
                      title="Download PDF"
                      onClick={() => handleDownloadPDF(mdfe.id, mdfe.numero)}
                      disabled={processando === mdfe.id}
                    >
                      {processando === mdfe.id ? (
                        <i className="fas fa-spinner fa-spin"></i>
                      ) : (
                        <i className="fas fa-download"></i>
                      )}
                    </button>
                  )}

                  {/* Duplicar sempre disponível (exceto cancelados) */}
                  {mdfe.status !== 'Cancelado' && (
                    <button
                      className={styles.btnEdit}
                      title="Duplicar MDFe"
                      onClick={() => handleDuplicar(mdfe.id, mdfe.numero)}
                      disabled={processando === mdfe.id}
                    >
                      {processando === mdfe.id ? (
                        <i className="fas fa-spinner fa-spin"></i>
                      ) : (
                        <i className="fas fa-copy"></i>
                      )}
                    </button>
                  )}
                </div>
              </div>
            ))}
          </div>
        )}

        {totalPages > 1 && (
          <Pagination
            currentPage={paginaAtual}
            totalPages={totalPages}
            onPageChange={handlePageChange}
          />
        )}
      </div>

      {/* Modal de Visualização */}
      {selectedMDFe && (
        <MDFeViewModal
          mdfe={selectedMDFe}
          isOpen={showViewModal}
          onClose={() => {
            setShowViewModal(false);
            setSelectedMDFe(null);
          }}
        />
      )}
    </div>
  );
};