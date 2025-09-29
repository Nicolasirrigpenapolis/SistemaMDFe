import React, { useState, useEffect } from 'react';
import { OptionalFieldsToggle, OptionalSection } from '../../../components/UI/Common/OptionalFieldsToggle';
import Icon from '../../../components/UI/Icon';

interface Municipio {
  id?: number;
  codigo: string;
  nome: string;
  uf: string;
  ativo?: boolean;
  ibge?: string;
  observacoes?: string;
}

interface PaginationData {
  current: number;
  pageSize: number;
  total: number;
  totalPages: number;
}

interface FiltrosMunicipios {
  status: string;
  uf: string;
}

export function ListarMunicipios() {
  const [municipios, setMunicipios] = useState<Municipio[]>([]);
  const [carregando, setCarregando] = useState(false);
  const [termoBusca, setTermoBusca] = useState('');

  // Estados dos filtros
  const [filtros, setFiltros] = useState<FiltrosMunicipios>({
    status: '',
    uf: ''
  });

  // Estados da paginação
  const [paginacao, setPaginacao] = useState<PaginationData>({
    current: 1,
    pageSize: 10,
    total: 0,
    totalPages: 0
  });

  // Estados do modal
  const [modalAberto, setModalAberto] = useState(false);
  const [modalVisualizacao, setModalVisualizacao] = useState(false);
  const [municipioSelecionado, setMunicipioSelecionado] = useState<Municipio | null>(null);
  const [isEdicao, setIsEdicao] = useState(false);
  const [salvando, setSalvando] = useState(false);
  const [mostrarOpcionais, setMostrarOpcionais] = useState(false);
  const [importandoIBGE, setImportandoIBGE] = useState(false);

  // Estados do modal de importação
  const [modalImportacao, setModalImportacao] = useState(false);

  // Estados do formulário
  const [dadosForm, setDadosForm] = useState<Municipio>({
    codigo: '',
    nome: '',
    uf: '',
    ativo: true
  });

  useEffect(() => {
    carregarMunicipios();
  }, [paginacao.current, paginacao.pageSize]);

  const carregarMunicipios = async () => {
    try {
      setCarregando(true);

      // Conectar à API real de municípios
      const response = await fetch(`https://localhost:5001/api/municipios?tamanhoPagina=${paginacao.pageSize}&pagina=${paginacao.current}`);

      if (!response.ok) {
        // Se não houver municípios cadastrados, mostrar lista vazia
        setMunicipios([]);
        setPaginacao(prev => ({
          ...prev,
          total: 0,
          totalPages: 0
        }));
        return;
      }

      const data = await response.json();

      // API retorna ResultadoPaginado<Municipio> com propriedades em minúsculas
      const municipiosArray = Array.isArray(data.itens) ? data.itens : [];

      // Mapear dados da API para o formato esperado
      const municipiosFormatados = municipiosArray.map((municipio: any) => ({
        id: municipio.id,
        codigo: municipio.codigo,
        nome: municipio.nome,
        uf: municipio.uf,
        ibge: municipio.codigo, // Codigo IBGE é o mesmo que codigo
        ativo: municipio.ativo,
        observacoes: '' // Campo não está no modelo da API
      }));

      setMunicipios(municipiosFormatados);
      setPaginacao(prev => ({
        ...prev,
        total: data.totalItens || 0,
        totalPages: data.totalPaginas || Math.ceil((data.totalItens || 0) / prev.pageSize)
      }));
    } catch (error) {
      console.error('Erro ao carregar municípios:', error);
    } finally {
      setCarregando(false);
    }
  };



  const limparFiltros = () => {
    setFiltros({
      status: '',
      uf: ''
    });
    setTermoBusca('');
    setPaginacao(prev => ({ ...prev, current: 1 }));
  };

  const abrirModalNovo = () => {
    setIsEdicao(false);
    setDadosForm({
      codigo: '',
      nome: '',
      uf: '',
      ativo: true
    });
    setMostrarOpcionais(false);
    setModalAberto(true);
  };

  const abrirModalEdicao = (municipio: Municipio) => {
    setIsEdicao(true);
    setDadosForm(municipio);
    setMostrarOpcionais(!!municipio.observacoes);
    setModalAberto(true);
  };

  const abrirModalVisualizacao = (municipio: Municipio) => {
    setMunicipioSelecionado(municipio);
    setModalVisualizacao(true);
  };

  const fecharModais = () => {
    setModalAberto(false);
    setModalVisualizacao(false);
    setMunicipioSelecionado(null);
    setIsEdicao(false);
    setSalvando(false);
  };

  const salvarMunicipio = async (e: React.FormEvent) => {
    e.preventDefault();

    try {
      setSalvando(true);

      if (isEdicao) {
        setMunicipios(prev => prev.map(mun =>
          mun.id === dadosForm.id ? dadosForm : mun
        ));
      } else {
        const novoMunicipio = { ...dadosForm, id: Date.now() };
        setMunicipios(prev => [...prev, novoMunicipio]);
      }

      fecharModais();
      carregarMunicipios();
    } catch (error) {
      console.error('Erro ao salvar município:', error);
    } finally {
      setSalvando(false);
    }
  };

  const excluirMunicipio = async (id: number) => {
    if (window.confirm('Deseja realmente excluir este município?')) {
      setMunicipios(prev => prev.filter(mun => mun.id !== id));
      carregarMunicipios();
    }
  };

  const alterarPagina = (novaPagina: number) => {
    setPaginacao(prev => ({ ...prev, current: novaPagina }));
  };

  const alterarTamanhoPagina = (novoTamanho: number) => {
    setPaginacao(prev => ({
      ...prev,
      pageSize: novoTamanho,
      current: 1
    }));
  };

  const editarDoModal = () => {
    if (municipioSelecionado) {
      setModalVisualizacao(false);
      abrirModalEdicao(municipioSelecionado);
    }
  };

  const abrirModalImportacao = () => {
    setModalImportacao(true);
  };

  const fecharModalImportacao = () => {
    if (!importandoIBGE) {
      setModalImportacao(false);
    }
  };

  const confirmarImportacao = async () => {
    try {
      setImportandoIBGE(true);

      // Chamar a API do backend para importar municípios do IBGE
      const response = await fetch('https://localhost:5001/api/municipios/importar-todos-ibge', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        }
      });

      if (!response.ok) {
        throw new Error('Erro ao importar municípios do IBGE');
      }

      const result = await response.json();

      alert(`${result.municipiosImportados || 'Todos os'} municípios importados com sucesso!`);
      carregarMunicipios();

      // Fechar modal
      setModalImportacao(false);
    } catch (error) {
      console.error('Erro ao importar municípios do IBGE:', error);
      alert('Erro ao importar municípios do IBGE. Tente novamente.');
    } finally {
      setImportandoIBGE(false);
    }
  };

  if (carregando) {
    return (
      <div className="max-w-7xl mx-auto px-6 py-8">
        <div className="flex items-center justify-center py-16">
          <div className="flex items-center gap-4">
            <div className="w-8 h-8 border-4 border-primary border-t-transparent rounded-full animate-spin"></div>
            <span className="text-text-secondary">Carregando municípios...</span>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="max-w-7xl mx-auto px-6 py-8">
      <div className="flex items-center justify-between mb-8">
        <h1>
          <i className="fas fa-map-marker-alt"></i>
          Municípios
        </h1>
        <div className="flex items-center gap-4">
          <button
            className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 font-medium transition-colors duration-200 flex items-center gap-2"
            onClick={abrirModalImportacao}
            disabled={importandoIBGE}
          >
            <i className={importandoIBGE ? "fas fa-spinner fa-spin" : "fas fa-download"}></i>
            {importandoIBGE ? 'Importando...' : 'Importar IBGE'}
          </button>
          <button className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary-hover font-medium transition-colors duration-200 flex items-center gap-2" onClick={abrirModalNovo}>
            <i className="fas fa-plus"></i>
            Novo Município
          </button>
        </div>
      </div>

      <div className="bg-bg-surface rounded-xl border border-border-primary p-6 mb-6">
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div className="space-y-2">
            <label className="text-sm font-medium text-text-primary">Status</label>
            <select
              value={filtros.status}
              onChange={(e) => setFiltros({ ...filtros, status: e.target.value })}
              className="w-full px-3 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary focus:outline-none focus:ring-2 focus:ring-primary"
            >
              <option value="">Todos</option>
              <option value="ativo">Ativo</option>
              <option value="inativo">Inativo</option>
            </select>
          </div>

          <div className="space-y-2">
            <label className="text-sm font-medium text-text-primary">UF</label>
            <select
              value={filtros.uf}
              onChange={(e) => setFiltros({ ...filtros, uf: e.target.value })}
              className="w-full px-3 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary focus:outline-none focus:ring-2 focus:ring-primary"
            >
              <option value="">Todas</option>
              <option value="SP">São Paulo</option>
              <option value="RJ">Rio de Janeiro</option>
              <option value="MG">Minas Gerais</option>
              <option value="PR">Paraná</option>
              <option value="RS">Rio Grande do Sul</option>
              <option value="SC">Santa Catarina</option>
              <option value="BA">Bahia</option>
              <option value="GO">Goiás</option>
              <option value="PE">Pernambuco</option>
              <option value="CE">Ceará</option>
            </select>
          </div>

          <div className="space-y-2">
            <label className="text-sm font-medium text-text-primary">Buscar</label>
            <input
              type="text"
              placeholder="Buscar por nome, código ou UF..."
              value={termoBusca}
              onChange={(e) => setTermoBusca(e.target.value)}
              className="w-full px-3 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary focus:outline-none focus:ring-2 focus:ring-primary"
            />
          </div>

          <button
            className="px-4 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary hover:bg-bg-surface-hover transition-colors duration-200 col-span-full md:col-span-1"
            onClick={limparFiltros}
          >
            Limpar Filtros
          </button>
        </div>
      </div>

      <div className="bg-bg-surface rounded-xl border border-border-primary shadow-sm">
        {municipios.length === 0 ? (
          <div className="flex flex-col items-center justify-center py-16 px-6">
            <div className="w-16 h-16 bg-bg-tertiary rounded-full flex items-center justify-center mb-4">
              <i className="fas fa-map-marker-alt text-2xl text-text-tertiary"></i>
            </div>
            <h3 className="text-lg font-semibold text-text-primary mb-2">Nenhum município encontrado</h3>
            <p className="text-text-secondary text-center">Adicione um novo município ou ajuste os filtros de busca.</p>
          </div>
        ) : (
          <div className="overflow-x-auto">
            <div className="grid grid-cols-5 gap-4 p-4 bg-bg-tertiary border-b border-border-primary font-semibold text-text-primary">
              <div>Código IBGE</div>
              <div>Nome</div>
              <div>UF</div>
              <div>Status</div>
              <div>Ações</div>
            </div>

            {municipios.map((municipio) => (
              <div key={municipio.id} className="grid grid-cols-5 gap-4 p-4 border-b border-border-primary hover:bg-bg-surface-hover transition-colors duration-200">
                <div>
                  <span className="text-text-primary">{municipio.codigo}</span>
                  <div className="text-sm text-text-secondary">Código IBGE</div>
                </div>
                <div>
                  <strong className="text-text-primary">{municipio.nome}</strong>
                  {municipio.observacoes && (
                    <div className="text-sm text-text-secondary">{municipio.observacoes}</div>
                  )}
                </div>
                <div>
                  <span className="px-2 py-1 bg-gray-100 text-gray-800 dark:bg-gray-800 dark:text-gray-300 rounded text-xs font-medium">{municipio.uf}</span>
                </div>
                <div>
                  <span className={`px-2 py-1 rounded-full text-xs font-medium ${
                    municipio.ativo
                      ? 'bg-green-100 text-green-800 dark:bg-green-900 dark:text-green-300'
                      : 'bg-red-100 text-red-800 dark:bg-red-900 dark:text-red-300'
                  }`}>
                    {municipio.ativo ? 'Ativo' : 'Inativo'}
                  </span>
                </div>
                <div className="flex items-center gap-2">
                  <button
                    className="px-3 py-1 text-blue-600 hover:bg-blue-50 dark:hover:bg-blue-900/20 rounded transition-colors duration-200"
                    onClick={() => abrirModalVisualizacao(municipio)}
                    title="Visualizar"
                  >
                    Ver
                  </button>
                  <button
                    className="px-3 py-1 text-amber-600 hover:bg-amber-50 dark:hover:bg-amber-900/20 rounded transition-colors duration-200"
                    onClick={() => abrirModalEdicao(municipio)}
                    title="Editar"
                  >
                    Editar
                  </button>
                  <button
                    className="px-3 py-1 text-red-600 hover:bg-red-50 dark:hover:bg-red-900/20 rounded transition-colors duration-200"
                    onClick={() => municipio.id && excluirMunicipio(municipio.id)}
                    title="Excluir"
                  >
                    Excluir
                  </button>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>

      {/* Paginação - só mostra se houver registros */}
      {paginacao.total > 0 && (
        <div className="mt-6 bg-bg-surface border-t border-border-primary p-4">
          <div className="flex flex-col sm:flex-row justify-between items-center gap-4">
            <div className="flex items-center gap-2">
              <label className="text-sm text-text-primary">Itens por página:</label>
              <select
                className="px-3 py-1 border border-border-primary rounded bg-bg-surface text-text-primary focus:outline-none focus:ring-2 focus:ring-primary"
                value={paginacao.pageSize}
                onChange={(e) => alterarTamanhoPagina(Number(e.target.value))}
              >
                <option value={5}>5</option>
                <option value={10}>10</option>
                <option value={20}>20</option>
                <option value={50}>50</option>
              </select>
            </div>

            <div className="flex items-center gap-2">
              <button
                className="px-4 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary hover:bg-bg-surface-hover disabled:opacity-50 disabled:cursor-not-allowed transition-colors duration-200"
                onClick={() => alterarPagina(paginacao.current - 1)}
                disabled={paginacao.current === 1}
              >
                Anterior
              </button>

              <span className="px-4 py-2 text-text-primary">
                Página {paginacao.current} de {paginacao.totalPages}
              </span>

              <button
                className="px-4 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary hover:bg-bg-surface-hover disabled:opacity-50 disabled:cursor-not-allowed transition-colors duration-200"
                onClick={() => alterarPagina(paginacao.current + 1)}
                disabled={paginacao.current === paginacao.totalPages}
              >
                Próxima
              </button>
            </div>

            <div className="text-sm text-text-secondary">
              Mostrando {((paginacao.current - 1) * paginacao.pageSize) + 1} a {Math.min(paginacao.current * paginacao.pageSize, paginacao.total)} de {paginacao.total} municípios
            </div>
          </div>
        </div>
      )}

      {/* Modal de Cadastro/Edição */}
      {modalAberto && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50 backdrop-blur-sm" onClick={fecharModais}>
          <div className="bg-bg-surface rounded-xl border border-border-primary shadow-xl max-w-2xl w-full mx-4 max-h-[90vh] overflow-y-auto" onClick={(e) => e.stopPropagation()}>
            <div className="flex items-center justify-between p-6 border-b border-border-primary">
              <h2 className="text-xl font-semibold text-text-primary">{isEdicao ? 'Editar Município' : 'Novo Município'}</h2>
              <button className="text-text-tertiary hover:text-text-primary transition-colors duration-200 text-2xl" onClick={fecharModais}>×</button>
            </div>

            <form onSubmit={salvarMunicipio} className="p-6">
              <div className="space-y-6">
                <div>
                  <h3 className="text-lg font-medium text-text-primary mb-4">Dados Básicos</h3>

                  <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                    <div className="md:col-span-2 space-y-2">
                      <label className="text-sm font-medium text-text-primary">Nome *</label>
                      <input
                        type="text"
                        value={dadosForm.nome}
                        onChange={(e) => setDadosForm({ ...dadosForm, nome: e.target.value })}
                        required
                        placeholder="Nome do município"
                        className="w-full px-3 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary focus:outline-none focus:ring-2 focus:ring-primary"
                      />
                    </div>

                    <div className="space-y-2">
                      <label className="text-sm font-medium text-text-primary">UF *</label>
                      <select
                        value={dadosForm.uf}
                        onChange={(e) => setDadosForm({ ...dadosForm, uf: e.target.value })}
                        required
                        className="w-full px-3 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary focus:outline-none focus:ring-2 focus:ring-primary"
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

                  <div className="grid grid-cols-1 gap-4 mt-4">
                    <div className="space-y-2">
                      <label className="text-sm font-medium text-text-primary">Código IBGE *</label>
                      <input
                        type="text"
                        value={dadosForm.codigo}
                        onChange={(e) => setDadosForm({ ...dadosForm, codigo: e.target.value, ibge: e.target.value })}
                        required
                        placeholder="Ex: 3550308"
                        className="w-full px-3 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary focus:outline-none focus:ring-2 focus:ring-primary"
                      />
                    </div>
                  </div>
                </div>

              <OptionalFieldsToggle
                isExpanded={mostrarOpcionais}
                onToggle={() => setMostrarOpcionais(!mostrarOpcionais)}
                label="Campos Opcionais"
                description="Informações adicionais do município"
              />

              <OptionalSection isVisible={mostrarOpcionais}>
                <div className="space-y-4">
                  <h3 className="text-lg font-medium text-text-primary">Informações Adicionais</h3>

                  <div className="space-y-2">
                    <label className="text-sm font-medium text-text-primary">Observações</label>
                    <input
                      type="text"
                      value={dadosForm.observacoes || ''}
                      onChange={(e) => setDadosForm({ ...dadosForm, observacoes: e.target.value })}
                      placeholder="Observações sobre o município"
                      className="w-full px-3 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary focus:outline-none focus:ring-2 focus:ring-primary"
                    />
                  </div>
                </div>
              </OptionalSection>
              </div>

              <div className="flex items-center justify-end gap-4 mt-6 pt-6 border-t border-border-primary">
                <button type="button" onClick={fecharModais} className="px-4 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary hover:bg-bg-surface-hover transition-colors duration-200">
                  Cancelar
                </button>
                <button type="submit" className="px-4 py-2 bg-primary hover:bg-primary-hover text-white rounded-lg font-medium transition-colors duration-200" disabled={salvando}>
                  {salvando ? 'Salvando...' : (isEdicao ? 'Atualizar' : 'Salvar')}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}

      {/* Modal de Visualização */}
      {modalVisualizacao && municipioSelecionado && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50 backdrop-blur-sm" onClick={fecharModais}>
          <div className="bg-bg-surface rounded-xl border border-border-primary shadow-xl max-w-md w-full mx-4" onClick={(e) => e.stopPropagation()}>
            <div className="flex items-center justify-between p-6 border-b border-border-primary">
              <h2 className="text-xl font-semibold text-text-primary">Visualizar Município</h2>
              <button className="text-text-tertiary hover:text-text-primary transition-colors duration-200 text-2xl" onClick={fecharModais}>×</button>
            </div>

            <div className="p-6">
              <div className="space-y-6">
                <div>
                  <h3 className="text-lg font-medium text-text-primary mb-4">Dados do Município</h3>
                  <div className="grid grid-cols-1 gap-4">
                    <div className="space-y-1">
                      <label className="text-sm font-medium text-text-secondary">Nome:</label>
                      <span className="block text-text-primary">{municipioSelecionado.nome}</span>
                    </div>
                    <div className="space-y-1">
                      <label className="text-sm font-medium text-text-secondary">UF:</label>
                      <span className="block text-text-primary">{municipioSelecionado.uf}</span>
                    </div>
                    <div className="space-y-1">
                      <label className="text-sm font-medium text-text-secondary">Código IBGE:</label>
                      <span className="block text-text-primary">{municipioSelecionado.codigo}</span>
                    </div>
                    <div className="space-y-1">
                      <label className="text-sm font-medium text-text-secondary">Status:</label>
                      <span className={`inline-block px-2 py-1 rounded-full text-xs font-medium ${
                        municipioSelecionado.ativo
                          ? 'bg-green-100 text-green-800 dark:bg-green-900 dark:text-green-300'
                          : 'bg-red-100 text-red-800 dark:bg-red-900 dark:text-red-300'
                      }`}>
                        {municipioSelecionado.ativo ? 'Ativo' : 'Inativo'}
                      </span>
                    </div>
                    {municipioSelecionado.observacoes && (
                      <div className="space-y-1">
                        <label className="text-sm font-medium text-text-secondary">Observações:</label>
                        <span className="block text-text-primary">{municipioSelecionado.observacoes}</span>
                      </div>
                    )}
                  </div>
                </div>
              </div>
            </div>

            <div className="flex items-center justify-end gap-4 p-6 border-t border-border-primary">
              <button type="button" onClick={fecharModais} className="px-4 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary hover:bg-bg-surface-hover transition-colors duration-200">
                Fechar
              </button>
              <button type="button" onClick={editarDoModal} className="px-4 py-2 bg-amber-500 hover:bg-amber-600 text-white rounded-lg font-medium transition-colors duration-200">
                Editar
              </button>
            </div>
          </div>
        </div>
      )}

      {/* Modal de importação - componente temporariamente removido */}
      {modalImportacao && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50">
          <div className="bg-white dark:bg-gray-800 rounded-lg shadow-xl max-w-md w-full mx-4 p-6">
            <h3 className="text-lg font-semibold text-gray-900 dark:text-white mb-4">
              Importar Municípios IBGE
            </h3>
            <p className="text-gray-700 dark:text-gray-300 mb-4">
              Deseja importar todos os municípios do IBGE? Esta base contém mais de 5.500 municípios brasileiros.
            </p>
            <p className="text-yellow-600 dark:text-yellow-400 text-sm mb-6">
              Todos os municípios existentes serão atualizados com os dados mais recentes do IBGE.
            </p>
            <div className="flex gap-3 justify-end">
              <button
                onClick={fecharModalImportacao}
                className="px-4 py-2 text-sm font-medium text-gray-700 dark:text-gray-300 bg-gray-100 dark:bg-gray-700 hover:bg-gray-200 dark:hover:bg-gray-600 rounded-lg transition-colors"
                disabled={importandoIBGE}
              >
                Cancelar
              </button>
              <button
                onClick={confirmarImportacao}
                className="px-4 py-2 text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 rounded-lg transition-colors disabled:opacity-50"
                disabled={importandoIBGE}
              >
                {importandoIBGE ? 'Importando...' : 'Importar'}
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}