import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import Icon from '../../../components/UI/Icon';
import Pagination from '../../../components/UI/Pagination/Pagination';
import { MDFeViewModal } from '../../../components/UI/Modal/MDFeViewModal';

interface MDFe {
  id: number;
  numero: string;
  serie: string;
  dataEmissao: string;
  ufIni: string;
  ufFim: string;
  valorTotal: number;
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
        numero: item.numeroMdfe?.toString().padStart(9, '0') || '',
        serie: item.serie?.toString() || '001',
        dataEmissao: item.dataEmissao,
        ufIni: item.ufIni || '',
        ufFim: item.ufFim || '',
        valorTotal: item.valorTotal || 0,
        status: mapearStatus(item.statusSefaz),
        chave: item.chaveAcesso || '',
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

  // Função para gerar MDFe (backend endpoint disponível)
  const handleGerarMDFe = async (mdfeId: number, numero: string) => {
    try {
      setProcessando(mdfeId);

      const response = await fetch(`${process.env.REACT_APP_API_URL || 'https://localhost:5001/api'}/mdfe/${mdfeId}/gerar`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        }
      });

      const resultado = await response.json();

      if (response.ok) {
        exibirMensagem('sucesso', `MDFe ${numero} gerado com sucesso!`);
      } else {
        exibirMensagem('erro', resultado.mensagem || `Erro ao gerar MDFe ${numero}`);
      }
    } catch (error) {
      console.error('Erro ao gerar MDFe:', error);
      exibirMensagem('erro', `Erro ao gerar MDFe ${numero}`);
    } finally {
      setProcessando(null);
    }
  };

  // Função para transmitir MDFe (backend endpoint disponível)
  const handleTransmitir = async (mdfeId: number, numero: string) => {
    if (!window.confirm(`Deseja transmitir o MDFe ${numero} para a SEFAZ?`)) {
      return;
    }

    try {
      setProcessando(mdfeId);

      const response = await fetch(`${process.env.REACT_APP_API_URL || 'https://localhost:5001/api'}/mdfe/${mdfeId}/transmitir`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        }
      });

      const resultado = await response.json();

      if (response.ok) {
        exibirMensagem('sucesso', `MDFe ${numero} transmitido com sucesso!`);
        setTimeout(() => {
          carregarMDFes(); // Recarregar lista para atualizar status
        }, 1500);
      } else {
        exibirMensagem('erro', resultado.mensagem || `Erro ao transmitir MDFe ${numero}`);
      }
    } catch (error) {
      console.error('Erro ao transmitir MDFe:', error);
      exibirMensagem('erro', `Erro ao transmitir MDFe ${numero}`);
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
    <div className="max-w-7xl mx-auto px-6 py-8">
      {/* Mensagem de Feedback */}
      {mensagem && (
        <div className={`mb-6 p-4 rounded-lg border flex items-center justify-between ${
          mensagem.tipo === 'sucesso'
            ? 'bg-green-50 border-green-200 text-green-800 dark:bg-green-900/20 dark:border-green-800 dark:text-green-300'
            : 'bg-red-50 border-red-200 text-red-800 dark:bg-red-900/20 dark:border-red-800 dark:text-red-300'
        }`}>
          <div className="flex items-center gap-3">
            <i className={`fas ${
              mensagem.tipo === 'sucesso' ? 'fa-check-circle' : 'fa-exclamation-circle'
            }`}></i>
            <span>{mensagem.texto}</span>
          </div>
          <button
            className="text-current hover:opacity-70 transition-opacity duration-200"
            onClick={() => setMensagem(null)}
          >
            <i className="fas fa-times"></i>
          </button>
        </div>
      )}

      {/* Header */}
      <div className="flex items-center justify-between mb-8">
        <h1>
          <i className="fas fa-file-alt"></i>
          Manifestos Eletrônicos (MDFe)
        </h1>
        <button
          onClick={() => navigate('/mdfes/novo')}
          className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary-hover font-medium transition-colors duration-200 flex items-center gap-2"
        >
          <i className="fas fa-plus"></i>
          Novo MDFe
        </button>
      </div>

      {/* Estatísticas */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-6">
        <div className="bg-bg-surface rounded-xl border border-border-primary p-6">
          <div className="flex items-center justify-between mb-4">
            <div className="p-3 bg-green-100 dark:bg-green-900/30 rounded-lg">
              <i className="fas fa-check-circle text-green-600 dark:text-green-400 text-xl"></i>
            </div>
            <div className="text-green-600 dark:text-green-400">
              <i className="fas fa-arrow-up"></i>
            </div>
          </div>
          <div>
            <div className="text-2xl font-bold text-text-primary">{mdfes.filter(m => m.status === 'Autorizado').length}</div>
            <div className="text-text-secondary">Autorizados</div>
          </div>
        </div>

        <div className="bg-bg-surface rounded-xl border border-border-primary p-6">
          <div className="flex items-center justify-between mb-4">
            <div className="p-3 bg-yellow-100 dark:bg-yellow-900/30 rounded-lg">
              <i className="fas fa-clock text-yellow-600 dark:text-yellow-400 text-xl"></i>
            </div>
            <div className="text-yellow-600 dark:text-yellow-400">
              <i className="fas fa-arrow-up"></i>
            </div>
          </div>
          <div>
            <div className="text-2xl font-bold text-text-primary">{mdfes.filter(m => m.status === 'Pendente' || m.status === 'Rascunho').length}</div>
            <div className="text-text-secondary">Pendentes</div>
          </div>
        </div>

        <div className="bg-bg-surface rounded-xl border border-border-primary p-6">
          <div className="flex items-center justify-between mb-4">
            <div className="p-3 bg-red-100 dark:bg-red-900/30 rounded-lg">
              <i className="fas fa-times-circle text-red-600 dark:text-red-400 text-xl"></i>
            </div>
            <div className="text-red-600 dark:text-red-400">
              <i className="fas fa-arrow-down"></i>
            </div>
          </div>
          <div>
            <div className="text-2xl font-bold text-text-primary">{mdfes.filter(m => m.status === 'Rejeitado' || m.status === 'Cancelado').length}</div>
            <div className="text-text-secondary">Rejeitados/Cancelados</div>
          </div>
        </div>
      </div>

      {/* Filtros */}
      <div className="bg-bg-surface rounded-xl border border-border-primary p-6 mb-6">
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div className="space-y-2">
            <input
              type="text"
              placeholder="Buscar por número, emitente ou veículo..."
              value={filtro}
              onChange={(e) => setFiltro(e.target.value)}
              className="w-full px-3 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary focus:outline-none focus:ring-2 focus:ring-primary"
            />
          </div>

          <div className="space-y-2">
            <select
              value={statusFiltro}
              onChange={(e) => setStatusFiltro(e.target.value)}
              className="w-full px-3 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary focus:outline-none focus:ring-2 focus:ring-primary"
            >
              <option value="todos">Todos os Status</option>
              <option value="Autorizado">Autorizado</option>
              <option value="Pendente">Pendente</option>
              <option value="Rascunho">Rascunho</option>
              <option value="Cancelado">Cancelado</option>
              <option value="Rejeitado">Rejeitado</option>
            </select>
          </div>

          <div className="space-y-2">
            <select
              value={itensPorPagina}
              onChange={(e) => handleItemsPerPageChange(Number(e.target.value))}
              className="w-full px-3 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary focus:outline-none focus:ring-2 focus:ring-primary"
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
      <div className="bg-bg-surface rounded-xl border border-border-primary shadow-sm">
        {totalItems > 0 && (
          <div className="px-6 py-3 border-b border-border-primary bg-bg-tertiary">
            <span className="text-sm text-text-secondary">
              Mostrando {startIndex + 1} a {Math.min(endIndex, totalItems)} de {totalItems} MDFes
            </span>
          </div>
        )}

        {itensAtuais.length === 0 ? (
          <div className="flex flex-col items-center justify-center py-16 px-6">
            <div className="w-16 h-16 bg-bg-tertiary rounded-full flex items-center justify-center mb-4">
              <i className="fas fa-file-alt text-2xl text-text-tertiary"></i>
            </div>
            <h3 className="text-lg font-semibold text-text-primary mb-2">Nenhum MDFe encontrado</h3>
            <p className="text-text-secondary text-center mb-6">
              {filtro || statusFiltro !== 'todos'
                ? 'Tente ajustar os filtros para encontrar o que procura.'
                : 'Comece criando seu primeiro manifesto eletrônico.'
              }
            </p>
            {(!filtro && statusFiltro === 'todos') && (
              <button
                onClick={() => navigate('/mdfes/novo')}
                className="px-6 py-3 bg-primary text-white rounded-lg hover:bg-primary-hover font-medium transition-colors duration-200 flex items-center gap-2"
              >
                <i className="fas fa-plus"></i>
                Criar Primeiro MDFe
              </button>
            )}
          </div>
        ) : (
          <div className="overflow-x-auto">
            {/* Header da Tabela */}
            <div className="grid grid-cols-8 gap-4 p-4 bg-bg-tertiary border-b border-border-primary font-semibold text-text-primary">
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
              <div key={mdfe.id} className="grid grid-cols-8 gap-4 p-4 border-b border-border-primary hover:bg-bg-surface-hover transition-colors duration-200">
                <div>
                  <strong className="text-text-primary">#{mdfe.numero}</strong>
                  <div className="text-sm text-text-secondary">Série {mdfe.serie}</div>
                </div>

                <div>
                  <span className="text-text-primary">{mdfe.emitenteNome || 'N/A'}</span>
                </div>

                <div>
                  <span className="text-text-primary">{new Date(mdfe.dataEmissao).toLocaleDateString('pt-BR')}</span>
                </div>

                <div>
                  <span className="text-text-primary">{mdfe.ufIni} → {mdfe.ufFim}</span>
                </div>

                <div>
                  <span className="text-text-primary">{mdfe.veiculoPlaca || 'N/A'}</span>
                </div>

                <div>
                  <span className="text-text-primary">R$ {mdfe.valorTotal.toLocaleString('pt-BR', { minimumFractionDigits: 2 })}</span>
                </div>

                <div>
                  <span
                    className={`px-2 py-1 rounded-full text-xs font-medium ${
                      mdfe.status === 'Autorizado' ? 'bg-green-100 text-green-800 dark:bg-green-900 dark:text-green-300' :
                      mdfe.status === 'Rascunho' || mdfe.status === 'Pendente' ? 'bg-yellow-100 text-yellow-800 dark:bg-yellow-900 dark:text-yellow-300' :
                      'bg-red-100 text-red-800 dark:bg-red-900 dark:text-red-300'
                    }`}
                  >
                    {mdfe.status}
                  </span>
                </div>

                <div className="flex items-center gap-1">
                  {/* Ação principal por status */}
                  {(mdfe.status === 'Rascunho' || mdfe.status === 'Rejeitado') ? (
                    <button
                      className="p-2 text-amber-600 hover:bg-amber-50 dark:hover:bg-amber-900/20 rounded transition-colors duration-200"
                      title={mdfe.status === 'Rejeitado' ? 'Corrigir & Editar' : 'Continuar Editando'}
                      onClick={() => navigate(`/mdfes/editar/${mdfe.id}`)}
                    >
                      <i className="fas fa-edit"></i>
                    </button>
                  ) : (
                    <button
                      className="p-2 text-blue-600 hover:bg-blue-50 dark:hover:bg-blue-900/20 rounded transition-colors duration-200"
                      title="Ver Detalhes"
                      onClick={() => navigate(`/mdfes/visualizar/${mdfe.id}`)}
                    >
                      <i className="fas fa-eye"></i>
                    </button>
                  )}

                  {/* Download rápido apenas para autorizados/pendentes */}
                  {(mdfe.status === 'Autorizado' || mdfe.status === 'Pendente') && (
                    <button
                      className="p-2 text-green-600 hover:bg-green-50 dark:hover:bg-green-900/20 rounded transition-colors duration-200"
                      title="Download PDF"
                      onClick={() => handleGerarMDFe(mdfe.id, mdfe.numero)}
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
                      className="p-2 text-purple-600 hover:bg-purple-50 dark:hover:bg-purple-900/20 rounded transition-colors duration-200"
                      title="Duplicar MDFe"
                      onClick={() => handleTransmitir(mdfe.id, mdfe.numero)}
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