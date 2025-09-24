import React, { useState, useEffect } from 'react';
import { ConfirmDeleteModal } from '../../../components/UI/Modal/ConfirmDeleteModal';
import { formatCNPJ, formatCPF, cleanNumericString, applyMask } from '../../../utils/formatters';
import { entitiesService } from '../../../services/entitiesService';
import styles from './ListarContratantes.module.css';

interface Contratante {
  id?: number;
  cnpj?: string;
  cpf?: string;
  razaoSocial: string;
  nomeFantasia?: string;
  endereco: string;
  numero?: string;
  complemento?: string;
  bairro: string;
  codMunicipio: number;
  municipio: string;
  cep: string;
  uf: string;
  ie?: string;
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

export function ListarContratantes() {
  const [contratantes, setContratantes] = useState<Contratante[]>([]);
  const [carregando, setCarregando] = useState(false);
  const [filtro, setFiltro] = useState('');
  const [filtroTipo, setFiltroTipo] = useState('');
  const [filtroStatus, setFiltroStatus] = useState('');
  const [filtroUf, setFiltroUf] = useState('');

  // Estados para paginação
  const [paginaAtual, setPaginaAtual] = useState(1);
  const [tamanhoPagina, setTamanhoPagina] = useState(10);
  const [paginacao, setPaginacao] = useState<PaginationData | null>(null);

  // Estados para modais
  const [modalVisualizacao, setModalVisualizacao] = useState(false);
  const [modalEdicao, setModalEdicao] = useState(false);
  const [contratanteSelecionado, setContratanteSelecionado] = useState<Contratante | null>(null);
  const [dadosFormulario, setDadosFormulario] = useState<Partial<Contratante>>({});
  const [salvando, setSalvando] = useState(false);

  // Estados do modal de exclusão
  const [modalExclusao, setModalExclusao] = useState(false);
  const [contratanteExclusao, setContratanteExclusao] = useState<Contratante | null>(null);
  const [excludindo, setExcluindo] = useState(false);

  useEffect(() => {
    carregarContratantes();
  }, [paginaAtual, tamanhoPagina, filtro, filtroTipo, filtroStatus, filtroUf]);

  const carregarContratantes = async () => {
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

      const response = await fetch(`${API_BASE_URL}/contratantes?${params}`);

      if (!response.ok) {
        throw new Error(`Erro ${response.status}: ${response.statusText}`);
      }

      const data = await response.json();

      const contratantesMapeados: Contratante[] = (data.items || data.Itens || []).map((contratante: any) => ({
        id: contratante.id || contratante.Id,
        cnpj: contratante.cnpj || contratante.Cnpj,
        cpf: contratante.cpf || contratante.Cpf,
        razaoSocial: contratante.razaoSocial || contratante.RazaoSocial,
        nomeFantasia: contratante.nomeFantasia || contratante.NomeFantasia,
        ie: contratante.ie || contratante.Ie,
        endereco: contratante.endereco || contratante.Endereco,
        numero: contratante.numero || contratante.Numero,
        complemento: contratante.complemento || contratante.Complemento,
        bairro: contratante.bairro || contratante.Bairro,
        codMunicipio: contratante.codMunicipio || contratante.CodMunicipio,
        municipio: contratante.municipio || contratante.Municipio,
        cep: contratante.cep || contratante.Cep,
        uf: contratante.uf || contratante.Uf,
        ativo: contratante.ativo !== undefined ? contratante.ativo : (contratante.Ativo !== undefined ? contratante.Ativo : true)
      }));

      setContratantes(contratantesMapeados);
      setPaginacao({
        totalItems: data.totalItems || data.TotalItens || contratantesMapeados.length,
        totalPages: data.totalPages || data.TotalPaginas || 1,
        currentPage: data.currentPage || data.Pagina || 1,
        pageSize: data.pageSize || data.TamanhoPagina || 10,
        hasNextPage: data.hasNextPage || data.TemProxima || false,
        hasPreviousPage: data.hasPreviousPage || data.TemAnterior || false,
        startItem: data.startItem || 1,
        endItem: data.endItem || contratantesMapeados.length
      });
    } catch (error) {
      console.error('Erro ao carregar contratantes:', error);
      setContratantes([]);
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

  const abrirModalVisualizacao = (contratante: Contratante) => {
    setContratanteSelecionado(contratante);
    setModalVisualizacao(true);
  };

  const abrirModalEdicao = (contratante?: Contratante) => {
    if (contratante) {
      setContratanteSelecionado(contratante);
      setDadosFormulario(contratante);
    } else {
      setContratanteSelecionado(null);
      setDadosFormulario({});
    }
    setModalEdicao(true);
  };

  const fecharModais = () => {
    setModalVisualizacao(false);
    setModalEdicao(false);
    setContratanteSelecionado(null);
    setDadosFormulario({});
  };

  const salvarContratante = async () => {
    setSalvando(true);
    try {
      const dadosParaSalvar = {
        cnpj: dadosFormulario.cnpj ? cleanNumericString(dadosFormulario.cnpj) : undefined,
        cpf: dadosFormulario.cpf ? cleanNumericString(dadosFormulario.cpf) : undefined,
        razaoSocial: dadosFormulario.razaoSocial?.trim(),
        nomeFantasia: dadosFormulario.nomeFantasia?.trim(),
        endereco: dadosFormulario.endereco?.trim(),
        numero: dadosFormulario.numero?.trim(),
        complemento: dadosFormulario.complemento?.trim(),
        bairro: dadosFormulario.bairro?.trim(),
        codMunicipio: dadosFormulario.codMunicipio,
        municipio: dadosFormulario.municipio?.trim(),
        cep: dadosFormulario.cep ? cleanNumericString(dadosFormulario.cep) : undefined,
        uf: dadosFormulario.uf?.toUpperCase(),
        ie: dadosFormulario.ie?.trim(),
        ativo: dadosFormulario.ativo !== false
      };

      let resposta;
      if (contratanteSelecionado?.id) {
        resposta = await entitiesService.atualizarContratante(contratanteSelecionado.id, dadosParaSalvar);
      } else {
        resposta = await entitiesService.criarContratante(dadosParaSalvar);
      }

      if (resposta.sucesso) {
        fecharModais();
        carregarContratantes();
      } else {
        alert(`Erro ao salvar contratante: ${resposta.mensagem}`);
      }
    } catch (error) {
      console.error('Erro ao salvar contratante:', error);
    } finally {
      setSalvando(false);
    }
  };

  const abrirModalExclusao = (contratante: Contratante) => {
    setContratanteExclusao(contratante);
    setModalExclusao(true);
  };

  const fecharModalExclusao = () => {
    setModalExclusao(false);
    setContratanteExclusao(null);
    setExcluindo(false);
  };

  const confirmarExclusao = async () => {
    if (!contratanteExclusao?.id) return;

    try {
      setExcluindo(true);
      const resposta = await entitiesService.excluirContratante(contratanteExclusao.id);

      if (resposta.sucesso) {
        fecharModalExclusao();
        carregarContratantes();
      } else {
        alert(`Erro ao excluir contratante: ${resposta.mensagem}`);
        setExcluindo(false);
      }
    } catch (error) {
      console.error('Erro ao excluir contratante:', error);
      alert('Erro inesperado ao excluir contratante. Tente novamente.');
      setExcluindo(false);
    }
  };

  const limparFiltros = () => {
    setFiltro('');
    setFiltroTipo('');
    setFiltroStatus('');
    setFiltroUf('');
    setPaginaAtual(1);
  };

  const atualizarCampo = (campo: string, valor: any) => {
    setDadosFormulario(prev => ({
      ...prev,
      [campo]: valor
    }));
  };

  const tipoContratante = (contratante: Contratante) => {
    return contratante.cnpj ? 'PJ' : 'PF';
  };

  return (
    <div className={styles.container}>
      <div className={styles.header}>
        <h1>
          <i className="fas fa-handshake"></i>
          Contratantes
        </h1>
        <button className={styles.btnNovo} onClick={() => abrirModalEdicao()}>
          Novo Contratante
        </button>
      </div>

      <div className={styles.filters}>
        <div className={styles.filtersRow}>
          <div className={styles.filterField}>
            <label>Buscar</label>
            <input
              type="text"
              className={styles.searchInput}
              placeholder="Buscar por razão social, CNPJ, CPF..."
              value={filtro}
              onChange={(e) => setFiltro(e.target.value)}
            />
          </div>

          <div className={styles.filterField}>
            <label>Tipo</label>
            <select
              value={filtroTipo}
              onChange={(e) => setFiltroTipo(e.target.value)}
            >
              <option value="">Todos</option>
              <option value="PJ">Pessoa Jurídica</option>
              <option value="PF">Pessoa Física</option>
            </select>
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

          <div className={styles.filterField}>
            <label>UF</label>
            <select
              value={filtroUf}
              onChange={(e) => setFiltroUf(e.target.value)}
            >
              <option value="">Todas</option>
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

          <button className={styles.btnClearFilters} onClick={limparFiltros}>
            Limpar Filtros
          </button>
        </div>
      </div>

      <div className={styles.list}>
        {carregando ? (
          <div className={styles.loading}>Carregando contratantes...</div>
        ) : contratantes.length === 0 ? (
          <div className={styles.emptyState}>
            <h3>Nenhum contratante encontrado</h3>
            <p>Adicione um novo contratante para começar.</p>
          </div>
        ) : (
          <div className={styles.table}>
            <div className={styles.tableHeader}>
              <div>CNPJ/CPF</div>
              <div>Razão Social</div>
              <div>Tipo</div>
              <div>Localização</div>
              <div>Status</div>
              <div>Ações</div>
            </div>
            {contratantes.map((contratante) => (
              <div key={contratante.id} className={styles.tableRow}>
                <div>
                  <strong>
                    {contratante.cnpj ? formatCNPJ(contratante.cnpj) : formatCPF(contratante.cpf || '')}
                  </strong>
                  {contratante.ie && <div className={styles.subtext}>IE: {contratante.ie}</div>}
                </div>
                <div>
                  <strong>{contratante.razaoSocial}</strong>
                  {contratante.nomeFantasia && <div className={styles.subtext}>{contratante.nomeFantasia}</div>}
                </div>
                <div>
                  <span className={styles.tipoContratante}>{tipoContratante(contratante)}</span>
                </div>
                <div>
                  <strong>{contratante.municipio}/{contratante.uf}</strong>
                </div>
                <div>
                  <span className={`${styles.status} ${contratante.ativo ? styles.ativo : styles.inativo}`}>
                    {contratante.ativo ? 'Ativo' : 'Inativo'}
                  </span>
                </div>
                <div className={styles.actions}>
                  <button
                    className={styles.btnView}
                    onClick={() => abrirModalVisualizacao(contratante)}
                  >
                    Visualizar
                  </button>
                  <button
                    className={styles.btnEdit}
                    onClick={() => abrirModalEdicao(contratante)}
                  >
                    Editar
                  </button>
                  <button
                    className={styles.btnDelete}
                    onClick={() => abrirModalExclusao(contratante)}
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
              Mostrando {paginacao.startItem} até {paginacao.endItem} de {paginacao.totalItems} contratantes
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

      {modalVisualizacao && contratanteSelecionado && (
        <div className={styles.modalOverlay} onClick={fecharModais}>
          <div className={styles.modal} onClick={(e) => e.stopPropagation()}>
            <div className={styles.modalHeader}>
              <h2>Visualizar Contratante</h2>
              <button className={styles.closeBtn} onClick={fecharModais}>×</button>
            </div>
            <div className={styles.modalContent}>
              <div className={styles.modalSection}>
                <h3>Dados Principais</h3>
                <div className={styles.viewGrid}>
                  <div className={styles.viewField}>
                    <label>Razão Social:</label>
                    <span>{contratanteSelecionado.razaoSocial}</span>
                  </div>
                  {contratanteSelecionado.nomeFantasia && (
                    <div className={styles.viewField}>
                      <label>Nome Fantasia:</label>
                      <span>{contratanteSelecionado.nomeFantasia}</span>
                    </div>
                  )}
                  <div className={styles.viewField}>
                    <label>{contratanteSelecionado.cnpj ? 'CNPJ:' : 'CPF:'}</label>
                    <span>
                      {contratanteSelecionado.cnpj
                        ? formatCNPJ(contratanteSelecionado.cnpj)
                        : formatCPF(contratanteSelecionado.cpf || '')}
                    </span>
                  </div>
                  {contratanteSelecionado.ie && (
                    <div className={styles.viewField}>
                      <label>IE:</label>
                      <span>{contratanteSelecionado.ie}</span>
                    </div>
                  )}
                  <div className={styles.viewField}>
                    <label>Tipo:</label>
                    <span>{tipoContratante(contratanteSelecionado)}</span>
                  </div>
                  <div className={styles.viewField}>
                    <label>Status:</label>
                    <span className={`${styles.statusBadge} ${contratanteSelecionado.ativo ? styles.ativo : styles.inativo}`}>
                      {contratanteSelecionado.ativo ? 'Ativo' : 'Inativo'}
                    </span>
                  </div>
                </div>
              </div>

              <div className={styles.modalSection}>
                <h3>Endereço</h3>
                <div className={styles.viewGrid}>
                  <div className={styles.viewField}>
                    <label>Logradouro:</label>
                    <span>{contratanteSelecionado.endereco}</span>
                  </div>
                  {contratanteSelecionado.numero && (
                    <div className={styles.viewField}>
                      <label>Número:</label>
                      <span>{contratanteSelecionado.numero}</span>
                    </div>
                  )}
                  <div className={styles.viewField}>
                    <label>Bairro:</label>
                    <span>{contratanteSelecionado.bairro}</span>
                  </div>
                  {contratanteSelecionado.complemento && (
                    <div className={styles.viewField}>
                      <label>Complemento:</label>
                      <span>{contratanteSelecionado.complemento}</span>
                    </div>
                  )}
                  <div className={styles.viewField}>
                    <label>Município:</label>
                    <span>{contratanteSelecionado.municipio}</span>
                  </div>
                  <div className={styles.viewField}>
                    <label>UF:</label>
                    <span>{contratanteSelecionado.uf}</span>
                  </div>
                  <div className={styles.viewField}>
                    <label>CEP:</label>
                    <span>{applyMask(contratanteSelecionado.cep, 'cep')}</span>
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
                abrirModalEdicao(contratanteSelecionado);
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
              <h2>{contratanteSelecionado ? 'Editar Contratante' : 'Novo Contratante'}</h2>
              <button className={styles.closeBtn} onClick={fecharModais}>×</button>
            </div>
            <form className={styles.modalForm} onSubmit={(e) => { e.preventDefault(); salvarContratante(); }}>
              <div className={styles.modalSection}>
                <h3>Dados Principais</h3>
                <div className={styles.modalRow}>
                  <div className={styles.modalField}>
                    <label>Razão Social *</label>
                    <input
                      type="text"
                      value={dadosFormulario.razaoSocial || ''}
                      onChange={(e) => atualizarCampo('razaoSocial', e.target.value)}
                      required
                    />
                  </div>
                  <div className={styles.modalField}>
                    <label>Nome Fantasia</label>
                    <input
                      type="text"
                      value={dadosFormulario.nomeFantasia || ''}
                      onChange={(e) => atualizarCampo('nomeFantasia', e.target.value)}
                    />
                  </div>
                </div>
                <div className={styles.modalRow}>
                  <div className={styles.modalField}>
                    <label>CNPJ</label>
                    <input
                      type="text"
                      value={dadosFormulario.cnpj ? formatCNPJ(dadosFormulario.cnpj) : ''}
                      onChange={(e) => atualizarCampo('cnpj', cleanNumericString(e.target.value))}
                      maxLength={18}
                      placeholder="00.000.000/0000-00"
                    />
                  </div>
                  <div className={styles.modalField}>
                    <label>CPF</label>
                    <input
                      type="text"
                      value={dadosFormulario.cpf ? formatCPF(dadosFormulario.cpf) : ''}
                      onChange={(e) => atualizarCampo('cpf', cleanNumericString(e.target.value))}
                      maxLength={14}
                      placeholder="000.000.000-00"
                    />
                  </div>
                  <div className={styles.modalField}>
                    <label>Inscrição Estadual</label>
                    <input
                      type="text"
                      value={dadosFormulario.ie || ''}
                      onChange={(e) => atualizarCampo('ie', e.target.value)}
                    />
                  </div>
                </div>
              </div>

              <div className={styles.modalSection}>
                <h3>Endereço</h3>
                <div className={styles.modalRow}>
                  <div className={styles.modalField}>
                    <label>Logradouro *</label>
                    <input
                      type="text"
                      value={dadosFormulario.endereco || ''}
                      onChange={(e) => atualizarCampo('endereco', e.target.value)}
                      required
                    />
                  </div>
                  <div className={styles.modalFieldSmall}>
                    <label>Número</label>
                    <input
                      type="text"
                      value={dadosFormulario.numero || ''}
                      onChange={(e) => atualizarCampo('numero', e.target.value)}
                    />
                  </div>
                </div>
                <div className={styles.modalRow}>
                  <div className={styles.modalField}>
                    <label>Bairro *</label>
                    <input
                      type="text"
                      value={dadosFormulario.bairro || ''}
                      onChange={(e) => atualizarCampo('bairro', e.target.value)}
                      required
                    />
                  </div>
                  <div className={styles.modalField}>
                    <label>Complemento</label>
                    <input
                      type="text"
                      value={dadosFormulario.complemento || ''}
                      onChange={(e) => atualizarCampo('complemento', e.target.value)}
                    />
                  </div>
                </div>
                <div className={styles.modalRow}>
                  <div className={styles.modalField}>
                    <label>Município *</label>
                    <input
                      type="text"
                      value={dadosFormulario.municipio || ''}
                      onChange={(e) => atualizarCampo('municipio', e.target.value)}
                      required
                    />
                  </div>
                  <div className={styles.modalFieldSmall}>
                    <label>UF *</label>
                    <select
                      value={dadosFormulario.uf || ''}
                      onChange={(e) => atualizarCampo('uf', e.target.value)}
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
                  <div className={styles.modalFieldSmall}>
                    <label>CEP *</label>
                    <input
                      type="text"
                      value={dadosFormulario.cep ? applyMask(dadosFormulario.cep, 'cep') : ''}
                      onChange={(e) => atualizarCampo('cep', cleanNumericString(e.target.value))}
                      maxLength={9}
                      placeholder="00000-000"
                      required
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
        title="Excluir Contratante"
        message="Tem certeza de que deseja excluir este contratante?"
        itemName={contratanteExclusao ? `${contratanteExclusao.razaoSocial}${contratanteExclusao.cnpj ? ` (${formatCNPJ(contratanteExclusao.cnpj)})` : contratanteExclusao.cpf ? ` (${formatCPF(contratanteExclusao.cpf)})` : ''}` : ''}
        onConfirm={confirmarExclusao}
        onCancel={fecharModalExclusao}
        loading={excludindo}
      />
    </div>
  );
}