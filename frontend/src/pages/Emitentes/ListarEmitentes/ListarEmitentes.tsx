import React, { useState, useEffect } from 'react';
import { ConfirmDeleteModal } from '../../../components/UI/Modal/ConfirmDeleteModal';
import { useCNPJLookup } from '../../../hooks/useCNPJLookup';
import { formatCNPJ, formatCPF, cleanNumericString, applyMask } from '../../../utils/formatters';
import { entitiesService } from '../../../services/entitiesService';
import styles from './ListarEmitentes.module.css';

interface Emitente {
  id?: number;
  cnpj?: string;
  cpf?: string;
  ie?: string;
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
  ativo?: boolean;
  tipoEmitente: string;
  caminhoArquivoCertificado?: string;
  senhaCertificado?: string;
  rntrc?: string;
  ambienteSefaz?: number;
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

export function ListarEmitentes() {
  const [emitentes, setEmitentes] = useState<Emitente[]>([]);
  const [carregando, setCarregando] = useState(false);
  const [filtro, setFiltro] = useState('');
  const [filtroTipo, setFiltroTipo] = useState('');
  const [filtroStatus, setFiltroStatus] = useState('');
  const [filtroUf, setFiltroUf] = useState('');

  // Estados para paginação
  const [paginaAtual, setPaginaAtual] = useState(1);
  const [tamanhoPagina, setTamanhoPagina] = useState(10);
  const [paginacao, setPaginacao] = useState<PaginationData | null>(null);

  // Estados do modal
  const [modalAberto, setModalAberto] = useState(false);
  const [modalVisualizacao, setModalVisualizacao] = useState(false);
  const [emitenteEdicao, setEmitenteEdicao] = useState<Emitente | null>(null);
  const [emitenteVisualizacao, setEmitenteVisualizacao] = useState<Emitente | null>(null);

  // Estados do modal de exclusão
  const [modalExclusao, setModalExclusao] = useState(false);
  const [emitenteExclusao, setEmitenteExclusao] = useState<Emitente | null>(null);
  const [excludindo, setExcluindo] = useState(false);

  // Hook para consulta automática de CNPJ
  const { consultarCNPJ, loading: loadingCNPJ, error: errorCNPJ, clearError } = useCNPJLookup();

  const [dadosModal, setDadosModal] = useState<Emitente>({
    razaoSocial: '',
    endereco: '',
    bairro: '',
    codMunicipio: 0,
    municipio: '',
    cep: '',
    uf: '',
    tipoEmitente: 'PrestadorServico',
    ambienteSefaz: 2
  });

  useEffect(() => {
    carregarEmitentes();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [paginaAtual, tamanhoPagina]);

  useEffect(() => {
    setPaginaAtual(1);
    carregarEmitentes(1, filtro);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [filtro]);

  const carregarEmitentes = async (pagina: number = paginaAtual, busca: string = filtro) => {
    try {
      setCarregando(true);

      const API_BASE_URL = process.env.REACT_APP_API_URL || 'https://localhost:5001/api';
      const params = new URLSearchParams({
        Page: pagina.toString(),
        PageSize: tamanhoPagina.toString()
      });

      if (busca.trim()) {
        params.append('Search', busca.trim());
      }

      const response = await fetch(`${API_BASE_URL}/emitentes?${params}`);

      if (!response.ok) {
        throw new Error('Erro ao carregar emitentes');
      }

      const data: PaginationData & { items: Emitente[] } = await response.json();

      setEmitentes(data.items || []);
      setPaginacao({
        totalItems: data.totalItems,
        totalPages: data.totalPages,
        currentPage: data.currentPage,
        pageSize: data.pageSize,
        hasNextPage: data.hasNextPage,
        hasPreviousPage: data.hasPreviousPage,
        startItem: data.startItem,
        endItem: data.endItem
      });
    } catch (error) {
      console.error('Erro ao carregar emitentes:', error);
      setEmitentes([]);
      setPaginacao(null);
    } finally {
      setCarregando(false);
    }
  };

  const abrirModalNovo = () => {
    setEmitenteEdicao(null);
    setDadosModal({
      razaoSocial: '',
      endereco: '',
      bairro: '',
      codMunicipio: 0,
      municipio: '',
      cep: '',
      uf: '',
      tipoEmitente: 'PrestadorServico',
      ambienteSefaz: 2
    });
    setModalAberto(true);
  };

  const abrirModalEdicao = (emitente: Emitente) => {
    setEmitenteEdicao(emitente);
    setDadosModal({
      ...emitente,
      senhaCertificado: ''
    });
    setModalAberto(true);
  };

  const abrirModalVisualizacao = (emitente: Emitente) => {
    setEmitenteVisualizacao(emitente);
    setModalVisualizacao(true);
  };

  const fecharModal = () => {
    setModalAberto(false);
    setEmitenteEdicao(null);
    clearError();
  };

  const fecharModalVisualizacao = () => {
    setModalVisualizacao(false);
    setEmitenteVisualizacao(null);
  };

  const handleCNPJChange = async (cnpj: string) => {
    const cnpjFormatado = formatCNPJ(cnpj);
    setDadosModal({ ...dadosModal, cnpj: cnpjFormatado });

    const cnpjLimpo = cleanNumericString(cnpj);
    if (cnpjLimpo.length === 14) {
      const dadosCNPJ = await consultarCNPJ(cnpjLimpo);

      if (dadosCNPJ) {
        setDadosModal(prev => ({
          ...prev,
          cnpj: formatCNPJ(dadosCNPJ.cnpj),
          razaoSocial: dadosCNPJ.razao_social,
          nomeFantasia: dadosCNPJ.nome_fantasia || '',
          endereco: dadosCNPJ.logradouro,
          numero: dadosCNPJ.numero,
          complemento: dadosCNPJ.complemento || '',
          bairro: dadosCNPJ.bairro,
          codMunicipio: dadosCNPJ.codigo_municipio || 0,
          municipio: dadosCNPJ.municipio,
          cep: dadosCNPJ.cep,
          uf: dadosCNPJ.uf
        }));
      }
    }
  };

  const salvarEmitente = async (e: React.FormEvent) => {
    e.preventDefault();

    try {
      const dadosLimpos = {
        ...dadosModal,
        cnpj: dadosModal.cnpj ? cleanNumericString(dadosModal.cnpj) : undefined,
        cpf: dadosModal.cpf ? cleanNumericString(dadosModal.cpf) : undefined,
        cep: cleanNumericString(dadosModal.cep),
        razaoSocial: dadosModal.razaoSocial.trim(),
        nomeFantasia: dadosModal.nomeFantasia ? dadosModal.nomeFantasia.trim() : undefined,
        endereco: dadosModal.endereco.trim(),
        bairro: dadosModal.bairro.trim(),
        municipio: dadosModal.municipio.trim(),
        uf: dadosModal.uf.toUpperCase()
      };

      let resposta;
      if (emitenteEdicao?.id) {
        resposta = await entitiesService.atualizarEmitente(emitenteEdicao.id, dadosLimpos);
      } else {
        resposta = await entitiesService.criarEmitente(dadosLimpos);
      }

      if (resposta.sucesso) {
        fecharModal();
        carregarEmitentes();
      } else {
        alert(`Erro ao salvar emitente: ${resposta.mensagem}`);
      }
    } catch (error) {
      console.error('Erro ao salvar emitente:', error);
    }
  };

  const abrirModalExclusao = (emitente: Emitente) => {
    setEmitenteExclusao(emitente);
    setModalExclusao(true);
  };

  const fecharModalExclusao = () => {
    setModalExclusao(false);
    setEmitenteExclusao(null);
    setExcluindo(false);
  };

  const confirmarExclusao = async () => {
    if (!emitenteExclusao?.id) return;

    try {
      setExcluindo(true);
      const resposta = await entitiesService.excluirEmitente(emitenteExclusao.id);

      if (resposta.sucesso) {
        fecharModalExclusao();
        carregarEmitentes();
      } else {
        alert(`Erro ao excluir emitente: ${resposta.mensagem}`);
        setExcluindo(false);
      }
    } catch (error) {
      console.error('Erro ao excluir emitente:', error);
      alert('Erro inesperado ao excluir emitente. Tente novamente.');
      setExcluindo(false);
    }
  };

  const emitentesFiltrados = emitentes.filter(emitente => {
    const tipoMatch = !filtroTipo || emitente.tipoEmitente === filtroTipo;
    const statusMatch = !filtroStatus ||
      (filtroStatus === 'ativo' && emitente.ativo) ||
      (filtroStatus === 'inativo' && !emitente.ativo);
    const ufMatch = !filtroUf || emitente.uf === filtroUf;

    return tipoMatch && statusMatch && ufMatch;
  });

  const limparFiltros = () => {
    setFiltro('');
    setFiltroTipo('');
    setFiltroStatus('');
    setFiltroUf('');
  };

  const renderModal = () => {
    if (!modalAberto) return null;

    return (
      <div className={styles.modalOverlay}>
        <div className={styles.modal}>
          <div className={styles.modalHeader}>
            <h2>{emitenteEdicao ? 'Editar Emitente' : 'Novo Emitente'}</h2>
            <button className={styles.closeBtn} onClick={fecharModal}>×</button>
          </div>

          <form id="emitente-form" onSubmit={salvarEmitente} className={styles.modalForm}>
            <div className={styles.modalSection}>
              <h3>Dados Principais</h3>

              <div className={styles.modalRow}>
                <div className={styles.modalField}>
                  <label>CNPJ</label>
                  <input
                    type="text"
                    value={dadosModal.cnpj || ''}
                    onChange={(e) => handleCNPJChange(e.target.value)}
                    placeholder="00.000.000/0000-00"
                    maxLength={18}
                  />
                  {loadingCNPJ && (
                    <small className={styles.loadingText}>Consultando CNPJ...</small>
                  )}
                  {errorCNPJ && (
                    <small className={styles.errorText}>{errorCNPJ}</small>
                  )}
                </div>

                <div className={styles.modalField}>
                  <label>CPF</label>
                  <input
                    type="text"
                    value={dadosModal.cpf ? applyMask(dadosModal.cpf, 'cpf') : ''}
                    onChange={(e) => setDadosModal({ ...dadosModal, cpf: cleanNumericString(e.target.value) })}
                    placeholder="000.000.000-00"
                    maxLength={14}
                  />
                </div>
              </div>

              <div className={styles.modalRow}>
                <div className={styles.modalField}>
                  <label>Razão Social *</label>
                  <input
                    type="text"
                    value={dadosModal.razaoSocial}
                    onChange={(e) => setDadosModal({ ...dadosModal, razaoSocial: e.target.value })}
                    required
                  />
                </div>

                <div className={styles.modalField}>
                  <label>Nome Fantasia</label>
                  <input
                    type="text"
                    value={dadosModal.nomeFantasia || ''}
                    onChange={(e) => setDadosModal({ ...dadosModal, nomeFantasia: e.target.value })}
                  />
                </div>
              </div>

              <div className={styles.modalRow}>
                <div className={styles.modalField}>
                  <label>Inscrição Estadual</label>
                  <input
                    type="text"
                    value={dadosModal.ie || ''}
                    onChange={(e) => setDadosModal({ ...dadosModal, ie: e.target.value })}
                  />
                </div>

                <div className={styles.modalField}>
                  <label>Tipo de Emitente *</label>
                  <select
                    value={dadosModal.tipoEmitente}
                    onChange={(e) => setDadosModal({ ...dadosModal, tipoEmitente: e.target.value })}
                    required
                  >
                    <option value="PrestadorServico">Prestador de Serviço</option>
                    <option value="EntregaPropria">Entrega Própria</option>
                  </select>
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
                    value={dadosModal.endereco}
                    onChange={(e) => setDadosModal({ ...dadosModal, endereco: e.target.value })}
                    required
                  />
                </div>

                <div className={styles.modalFieldSmall}>
                  <label>Número</label>
                  <input
                    type="text"
                    value={dadosModal.numero || ''}
                    onChange={(e) => setDadosModal({ ...dadosModal, numero: e.target.value })}
                  />
                </div>
              </div>

              <div className={styles.modalRow}>
                <div className={styles.modalField}>
                  <label>Bairro *</label>
                  <input
                    type="text"
                    value={dadosModal.bairro}
                    onChange={(e) => setDadosModal({ ...dadosModal, bairro: e.target.value })}
                    required
                  />
                </div>

                <div className={styles.modalField}>
                  <label>Complemento</label>
                  <input
                    type="text"
                    value={dadosModal.complemento || ''}
                    onChange={(e) => setDadosModal({ ...dadosModal, complemento: e.target.value })}
                  />
                </div>
              </div>

              <div className={styles.modalRow}>
                <div className={styles.modalField}>
                  <label>Município *</label>
                  <input
                    type="text"
                    value={dadosModal.municipio}
                    onChange={(e) => setDadosModal({ ...dadosModal, municipio: e.target.value })}
                    required
                  />
                </div>

                <div className={styles.modalFieldSmall}>
                  <label>CEP *</label>
                  <input
                    type="text"
                    value={dadosModal.cep ? applyMask(dadosModal.cep, 'cep') : ''}
                    onChange={(e) => setDadosModal({ ...dadosModal, cep: cleanNumericString(e.target.value) })}
                    required
                    placeholder="00000-000"
                    maxLength={9}
                  />
                </div>

                <div className={styles.modalFieldSmall}>
                  <label>UF *</label>
                  <select
                    value={dadosModal.uf}
                    onChange={(e) => setDadosModal({ ...dadosModal, uf: e.target.value })}
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
            </div>

            <div className={styles.modalSection}>
              <h3>Configurações</h3>

              <div className={styles.modalRow}>
                <div className={styles.modalField}>
                  <label>RNTRC</label>
                  <input
                    type="text"
                    value={dadosModal.rntrc || ''}
                    onChange={(e) => setDadosModal({ ...dadosModal, rntrc: e.target.value })}
                    placeholder="Registro Nacional dos Transportadores"
                  />
                </div>

                <div className={styles.modalField}>
                  <label>Ambiente SEFAZ</label>
                  <select
                    value={dadosModal.ambienteSefaz || 2}
                    onChange={(e) => setDadosModal({ ...dadosModal, ambienteSefaz: parseInt(e.target.value) })}
                  >
                    <option value={1}>Produção</option>
                    <option value={2}>Homologação</option>
                  </select>
                </div>
              </div>

              <div className={styles.modalRow}>
                <div className={styles.modalField}>
                  <label>Caminho do Certificado</label>
                  <input
                    type="text"
                    value={dadosModal.caminhoArquivoCertificado || ''}
                    onChange={(e) => setDadosModal({ ...dadosModal, caminhoArquivoCertificado: e.target.value })}
                    placeholder="C:\certificados\certificado.pfx"
                  />
                </div>

                <div className={styles.modalField}>
                  <label>Senha do Certificado</label>
                  <input
                    type="password"
                    value={dadosModal.senhaCertificado || ''}
                    onChange={(e) => setDadosModal({ ...dadosModal, senhaCertificado: e.target.value })}
                    placeholder={emitenteEdicao?.caminhoArquivoCertificado ? "Deixe vazio para manter" : "Senha do certificado"}
                  />
                </div>
              </div>
            </div>
          </form>

          <div className={styles.modalActions}>
            <button type="button" onClick={fecharModal} className={styles.btnCancel}>
              Cancelar
            </button>
            <button type="submit" form="emitente-form" className={styles.btnSave}>
              {emitenteEdicao ? 'Atualizar' : 'Salvar'}
            </button>
          </div>
        </div>
      </div>
    );
  };

  const renderModalVisualizacao = () => {
    if (!modalVisualizacao || !emitenteVisualizacao) return null;

    return (
      <div className={styles.modalOverlay}>
        <div className={styles.modal}>
          <div className={styles.modalHeader}>
            <h2>Visualizar Emitente</h2>
            <button className={styles.closeBtn} onClick={fecharModalVisualizacao}>×</button>
          </div>

          <div className={styles.modalContent}>
            <div className={styles.modalSection}>
              <h3>Dados Principais</h3>
              <div className={styles.viewGrid}>
                {emitenteVisualizacao.cnpj && (
                  <div className={styles.viewField}>
                    <label>CNPJ:</label>
                    <span>{formatCNPJ(emitenteVisualizacao.cnpj)}</span>
                  </div>
                )}
                {emitenteVisualizacao.cpf && (
                  <div className={styles.viewField}>
                    <label>CPF:</label>
                    <span>{formatCPF(emitenteVisualizacao.cpf)}</span>
                  </div>
                )}
                <div className={styles.viewField}>
                  <label>Razão Social:</label>
                  <span>{emitenteVisualizacao.razaoSocial}</span>
                </div>
                {emitenteVisualizacao.nomeFantasia && (
                  <div className={styles.viewField}>
                    <label>Nome Fantasia:</label>
                    <span>{emitenteVisualizacao.nomeFantasia}</span>
                  </div>
                )}
                {emitenteVisualizacao.ie && (
                  <div className={styles.viewField}>
                    <label>Inscrição Estadual:</label>
                    <span>{emitenteVisualizacao.ie}</span>
                  </div>
                )}
                <div className={styles.viewField}>
                  <label>Tipo de Emitente:</label>
                  <span>{emitenteVisualizacao.tipoEmitente === 'PrestadorServico' ? 'Prestador de Serviço' : 'Entrega Própria'}</span>
                </div>
              </div>
            </div>

            <div className={styles.modalSection}>
              <h3>Endereço</h3>
              <div className={styles.viewGrid}>
                <div className={styles.viewField}>
                  <label>Logradouro:</label>
                  <span>{emitenteVisualizacao.endereco}</span>
                </div>
                {emitenteVisualizacao.numero && (
                  <div className={styles.viewField}>
                    <label>Número:</label>
                    <span>{emitenteVisualizacao.numero}</span>
                  </div>
                )}
                <div className={styles.viewField}>
                  <label>Bairro:</label>
                  <span>{emitenteVisualizacao.bairro}</span>
                </div>
                {emitenteVisualizacao.complemento && (
                  <div className={styles.viewField}>
                    <label>Complemento:</label>
                    <span>{emitenteVisualizacao.complemento}</span>
                  </div>
                )}
                <div className={styles.viewField}>
                  <label>Município:</label>
                  <span>{emitenteVisualizacao.municipio}</span>
                </div>
                <div className={styles.viewField}>
                  <label>CEP:</label>
                  <span>{applyMask(emitenteVisualizacao.cep, 'cep')}</span>
                </div>
                <div className={styles.viewField}>
                  <label>UF:</label>
                  <span>{emitenteVisualizacao.uf}</span>
                </div>
              </div>
            </div>

            {(emitenteVisualizacao.rntrc || emitenteVisualizacao.caminhoArquivoCertificado) && (
              <div className={styles.modalSection}>
                <h3>Configurações</h3>
                <div className={styles.viewGrid}>
                  {emitenteVisualizacao.rntrc && (
                    <div className={styles.viewField}>
                      <label>RNTRC:</label>
                      <span>{emitenteVisualizacao.rntrc}</span>
                    </div>
                  )}
                  <div className={styles.viewField}>
                    <label>Ambiente SEFAZ:</label>
                    <span>{emitenteVisualizacao.ambienteSefaz === 1 ? 'Produção' : 'Homologação'}</span>
                  </div>
                  {emitenteVisualizacao.caminhoArquivoCertificado && (
                    <div className={styles.viewField}>
                      <label>Certificado:</label>
                      <span>{emitenteVisualizacao.caminhoArquivoCertificado}</span>
                    </div>
                  )}
                  <div className={styles.viewField}>
                    <label>Status:</label>
                    <span className={`${styles.statusBadge} ${emitenteVisualizacao.ativo ? styles.ativo : styles.inativo}`}>
                      {emitenteVisualizacao.ativo ? 'Ativo' : 'Inativo'}
                    </span>
                  </div>
                </div>
              </div>
            )}
          </div>

          <div className={styles.modalActions}>
            <button onClick={fecharModalVisualizacao} className={styles.btnCancel}>
              Fechar
            </button>
            <button
              onClick={() => {
                fecharModalVisualizacao();
                abrirModalEdicao(emitenteVisualizacao);
              }}
              className={styles.btnEdit}
            >
              Editar
            </button>
          </div>
        </div>
      </div>
    );
  };

  if (carregando) {
    return (
      <div className={styles.container}>
        <div className={styles.loading}>Carregando emitentes...</div>
      </div>
    );
  }

  return (
    <div className={styles.container}>
      <div className={styles.header}>
        <h1>
          <i className="fas fa-building"></i>
          Emitentes
        </h1>
        <button className={styles.btnNovo} onClick={abrirModalNovo}>
          Novo Emitente
        </button>
      </div>

      <div className={styles.filters}>
        <div className={styles.filtersRow}>
          <div className={styles.filterField}>
            <label>Buscar</label>
            <input
              type="text"
              placeholder="Razão social ou CNPJ..."
              value={filtro}
              onChange={(e) => {
                setFiltro(e.target.value);
              }}
              className={styles.searchInput}
            />
          </div>

          <div className={styles.filterField}>
            <label>Tipo</label>
            <select
              value={filtroTipo}
              onChange={(e) => setFiltroTipo(e.target.value)}
            >
              <option value="">Todos os tipos</option>
              <option value="PrestadorServico">Prestador de Serviço</option>
              <option value="EntregaPropria">Entrega Própria</option>
            </select>
          </div>

          <div className={styles.filterField}>
            <label>Status</label>
            <select
              value={filtroStatus}
              onChange={(e) => setFiltroStatus(e.target.value)}
            >
              <option value="">Todos os status</option>
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
              <option value="">Todas as UF</option>
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

          <button
            onClick={limparFiltros}
            className={styles.btnClearFilters}
          >
            Limpar Filtros
          </button>
        </div>
      </div>

      <div className={styles.list}>
        {emitentes.length === 0 ? (
          <div className={styles.emptyState}>
            <h3>Nenhum emitente encontrado</h3>
            <p>Adicione um novo emitente para começar.</p>
          </div>
        ) : (
          <div className={styles.table}>
            <div className={styles.tableHeader}>
              <div>Documento</div>
              <div>Empresa</div>
              <div>Tipo</div>
              <div>Localização</div>
              <div>Status</div>
              <div>Ações</div>
            </div>

            {emitentes.map((emitente) => (
              <div key={emitente.id} className={styles.tableRow}>
                <div>
                  <strong>
                    {emitente.cnpj ? formatCNPJ(emitente.cnpj) :
                     emitente.cpf ? formatCPF(emitente.cpf) :
                     'Não informado'}
                  </strong>
                </div>
                <div>
                  <strong>{emitente.razaoSocial}</strong>
                  {emitente.nomeFantasia && (
                    <div className={styles.subtext}>{emitente.nomeFantasia}</div>
                  )}
                </div>
                <div>
                  <span className={styles.tipoEmitente}>
                    {emitente.tipoEmitente === 'PrestadorServico' ? 'Prestador' : 'Entrega Própria'}
                  </span>
                </div>
                <div>
                  <strong>{emitente.municipio}/{emitente.uf}</strong>
                </div>
                <div>
                  <span className={`${styles.status} ${emitente.ativo ? styles.ativo : styles.inativo}`}>
                    {emitente.ativo ? 'Ativo' : 'Inativo'}
                  </span>
                </div>
                <div className={styles.actions}>
                  <button
                    className={styles.btnView}
                    onClick={() => abrirModalVisualizacao(emitente)}
                  >
                    Visualizar
                  </button>
                  <button
                    className={styles.btnEdit}
                    onClick={() => abrirModalEdicao(emitente)}
                  >
                    Editar
                  </button>
                  <button
                    className={styles.btnDelete}
                    onClick={() => abrirModalExclusao(emitente)}
                  >
                    Excluir
                  </button>
                </div>
              </div>
            ))}
          </div>
        )}

        {paginacao && paginacao.totalItems > 0 && (
          <div className={styles.paginationContainer}>
            <div className={styles.paginationControls}>
              <div className={styles.paginationInfo}>
                Mostrando {paginacao.startItem} até {paginacao.endItem} de {paginacao.totalItems} emitentes
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
      </div>

      {renderModal()}
      {renderModalVisualizacao()}

      <ConfirmDeleteModal
        isOpen={modalExclusao}
        title="Excluir Emitente"
        message="Tem certeza de que deseja excluir este emitente?"
        itemName={emitenteExclusao ? `${emitenteExclusao.razaoSocial}${emitenteExclusao.cnpj ? ` (${formatCNPJ(emitenteExclusao.cnpj)})` : ''}` : ''}
        onConfirm={confirmarExclusao}
        onCancel={fecharModalExclusao}
        loading={excludindo}
      />
    </div>
  );
}