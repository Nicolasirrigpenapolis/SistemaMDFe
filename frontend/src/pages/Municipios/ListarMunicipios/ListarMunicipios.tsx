import React, { useState, useEffect } from 'react';
import { OptionalFieldsToggle, OptionalSection } from '../../../components/UI/Common/OptionalFieldsToggle';
import { ConfirmImportModal } from '../../../components/UI/Modal/ConfirmImportModal';
import styles from './ListarMunicipios.module.css';

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

  const aplicarFiltros = (dados: Municipio[]) => {
    return dados.filter(municipio => {
      const matchBusca = termoBusca === '' ||
        municipio.nome.toLowerCase().includes(termoBusca.toLowerCase()) ||
        municipio.codigo.includes(termoBusca) ||
        municipio.uf.toLowerCase().includes(termoBusca.toLowerCase());

      const matchStatus = filtros.status === '' ||
        (filtros.status === 'ativo' && municipio.ativo) ||
        (filtros.status === 'inativo' && !municipio.ativo);

      const matchUf = filtros.uf === '' || municipio.uf === filtros.uf;

      return matchBusca && matchStatus && matchUf;
    });
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
      <div className={styles.container}>
        <div className={styles.loading}>Carregando municípios...</div>
      </div>
    );
  }

  return (
    <div className={styles.container}>
      <div className={styles.header}>
        <h1>
          <i className="fas fa-map-marker-alt"></i>
          Municípios
        </h1>
        <div className={styles.headerActions}>
          <button
            className={styles.btnImportIBGE}
            onClick={abrirModalImportacao}
            disabled={importandoIBGE}
          >
            <i className={importandoIBGE ? "fas fa-spinner fa-spin" : "fas fa-download"}></i>
            {importandoIBGE ? 'Importando...' : 'Importar IBGE'}
          </button>
          <button className={styles.btnNovo} onClick={abrirModalNovo}>
            <i className="fas fa-plus"></i>
            Novo Município
          </button>
        </div>
      </div>

      <div className={styles.filters}>
        <div className={styles.filtersRow}>
          <div className={styles.filterField}>
            <label>Status</label>
            <select
              value={filtros.status}
              onChange={(e) => setFiltros({ ...filtros, status: e.target.value })}
            >
              <option value="">Todos</option>
              <option value="ativo">Ativo</option>
              <option value="inativo">Inativo</option>
            </select>
          </div>

          <div className={styles.filterField}>
            <label>UF</label>
            <select
              value={filtros.uf}
              onChange={(e) => setFiltros({ ...filtros, uf: e.target.value })}
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

          <input
            type="text"
            placeholder="Buscar por nome, código ou UF..."
            value={termoBusca}
            onChange={(e) => setTermoBusca(e.target.value)}
            className={styles.searchInput}
          />

          <button
            className={styles.btnClearFilters}
            onClick={limparFiltros}
          >
            Limpar Filtros
          </button>
        </div>
      </div>

      <div className={styles.list}>
        {municipios.length === 0 ? (
          <div className={styles.emptyState}>
            <h3>Nenhum município encontrado</h3>
            <p>Adicione um novo município ou ajuste os filtros de busca.</p>
          </div>
        ) : (
          <div className={styles.table}>
            <div className={styles.tableHeader}>
              <div>Código IBGE</div>
              <div>Nome</div>
              <div>UF</div>
              <div>Status</div>
              <div>Ações</div>
            </div>

            {municipios.map((municipio) => (
              <div key={municipio.id} className={styles.tableRow}>
                <div>
                  {municipio.codigo}
                  <div className={styles.subtext}>Código IBGE</div>
                </div>
                <div>
                  <strong>{municipio.nome}</strong>
                  {municipio.observacoes && (
                    <div className={styles.subtext}>{municipio.observacoes}</div>
                  )}
                </div>
                <div>
                  <span className={styles.codigoUf}>{municipio.uf}</span>
                </div>
                <div>
                  <span className={`${styles.status} ${municipio.ativo ? styles.ativo : styles.inativo}`}>
                    {municipio.ativo ? 'Ativo' : 'Inativo'}
                  </span>
                </div>
                <div className={styles.actions}>
                  <button
                    className={styles.btnView}
                    onClick={() => abrirModalVisualizacao(municipio)}
                    title="Visualizar"
                  >
                    Ver
                  </button>
                  <button
                    className={styles.btnEdit}
                    onClick={() => abrirModalEdicao(municipio)}
                    title="Editar"
                  >
                    Editar
                  </button>
                  <button
                    className={styles.btnDelete}
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
                onClick={() => alterarPagina(paginacao.current - 1)}
                disabled={paginacao.current === 1}
              >
                Anterior
              </button>

              <span className={styles.pageInfo}>
                Página {paginacao.current} de {paginacao.totalPages}
              </span>

              <button
                className={styles.paginationBtn}
                onClick={() => alterarPagina(paginacao.current + 1)}
                disabled={paginacao.current === paginacao.totalPages}
              >
                Próxima
              </button>
            </div>

            <div className={styles.paginationInfo}>
              Mostrando {((paginacao.current - 1) * paginacao.pageSize) + 1} a {Math.min(paginacao.current * paginacao.pageSize, paginacao.total)} de {paginacao.total} municípios
            </div>
          </div>
        </div>
      )}

      {/* Modal de Cadastro/Edição */}
      {modalAberto && (
        <div className={styles.modalOverlay} onClick={fecharModais}>
          <div className={styles.modal} onClick={(e) => e.stopPropagation()}>
            <div className={styles.modalHeader}>
              <h2>{isEdicao ? 'Editar Município' : 'Novo Município'}</h2>
              <button className={styles.closeBtn} onClick={fecharModais}>×</button>
            </div>

            <form onSubmit={salvarMunicipio} className={styles.modalForm}>
              <div className={styles.modalSection}>
                <h3>Dados Básicos</h3>

                <div className={styles.modalRow}>
                  <div className={styles.modalField}>
                    <label>Nome *</label>
                    <input
                      type="text"
                      value={dadosForm.nome}
                      onChange={(e) => setDadosForm({ ...dadosForm, nome: e.target.value })}
                      required
                      placeholder="Nome do município"
                    />
                  </div>

                  <div className={styles.modalFieldSmall}>
                    <label>UF *</label>
                    <select
                      value={dadosForm.uf}
                      onChange={(e) => setDadosForm({ ...dadosForm, uf: e.target.value })}
                      required
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

                <div className={styles.modalRow}>
                  <div className={styles.modalField}>
                    <label>Código IBGE *</label>
                    <input
                      type="text"
                      value={dadosForm.codigo}
                      onChange={(e) => setDadosForm({ ...dadosForm, codigo: e.target.value, ibge: e.target.value })}
                      required
                      placeholder="Ex: 3550308"
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
                <div className={styles.modalSection}>
                  <h3>Informações Adicionais</h3>

                  <div className={styles.modalRow}>
                    <div className={styles.modalField}>
                      <label>Observações</label>
                      <input
                        type="text"
                        value={dadosForm.observacoes || ''}
                        onChange={(e) => setDadosForm({ ...dadosForm, observacoes: e.target.value })}
                        placeholder="Observações sobre o município"
                      />
                    </div>
                  </div>
                </div>
              </OptionalSection>

              <div className={styles.modalActions}>
                <button type="button" onClick={fecharModais} className={styles.btnCancel}>
                  Cancelar
                </button>
                <button type="submit" className={styles.btnSave} disabled={salvando}>
                  {salvando ? 'Salvando...' : (isEdicao ? 'Atualizar' : 'Salvar')}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}

      {/* Modal de Visualização */}
      {modalVisualizacao && municipioSelecionado && (
        <div className={styles.modalOverlay} onClick={fecharModais}>
          <div className={styles.modal} onClick={(e) => e.stopPropagation()}>
            <div className={styles.modalHeader}>
              <h2>Visualizar Município</h2>
              <button className={styles.closeBtn} onClick={fecharModais}>×</button>
            </div>

            <div className={styles.modalContent}>
              <div className={styles.modalSection}>
                <h3>Dados do Município</h3>
                <div className={styles.viewGrid}>
                  <div className={styles.viewField}>
                    <label>Nome:</label>
                    <span>{municipioSelecionado.nome}</span>
                  </div>
                  <div className={styles.viewField}>
                    <label>UF:</label>
                    <span>{municipioSelecionado.uf}</span>
                  </div>
                  <div className={styles.viewField}>
                    <label>Código IBGE:</label>
                    <span>{municipioSelecionado.codigo}</span>
                  </div>
                  <div className={styles.viewField}>
                    <label>Status:</label>
                    <span className={`${styles.statusBadge} ${municipioSelecionado.ativo ? styles.ativo : styles.inativo}`}>
                      {municipioSelecionado.ativo ? 'Ativo' : 'Inativo'}
                    </span>
                  </div>
                  {municipioSelecionado.observacoes && (
                    <div className={styles.viewField}>
                      <label>Observações:</label>
                      <span>{municipioSelecionado.observacoes}</span>
                    </div>
                  )}
                </div>
              </div>
            </div>

            <div className={styles.modalActions}>
              <button type="button" onClick={fecharModais} className={styles.btnCancel}>
                Fechar
              </button>
              <button type="button" onClick={editarDoModal} className={styles.btnEdit}>
                Editar
              </button>
            </div>
          </div>
        </div>
      )}

      <ConfirmImportModal
        isOpen={modalImportacao}
        title="Importar Municípios IBGE"
        message="Deseja importar todos os municípios do IBGE? Esta base contém mais de 5.500 municípios brasileiros."
        warningMessage="Todos os municípios existentes serão atualizados com os dados mais recentes do IBGE."
        onConfirm={confirmarImportacao}
        onCancel={fecharModalImportacao}
        loading={importandoIBGE}
        loadingMessage="Importando municípios do IBGE... Esta operação pode demorar alguns minutos."
      />
    </div>
  );
}