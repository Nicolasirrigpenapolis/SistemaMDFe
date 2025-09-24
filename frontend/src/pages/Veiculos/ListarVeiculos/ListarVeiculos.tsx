import React, { useState, useEffect } from 'react';
import { OptionalFieldsToggle, OptionalSection } from '../../../components/UI/Common/OptionalFieldsToggle';
import { ConfirmDeleteModal } from '../../../components/UI/Modal/ConfirmDeleteModal';
import { formatCNPJ, cleanNumericString, formatPlaca, cleanPlaca } from '../../../utils/formatters';
import { entitiesService } from '../../../services/entitiesService';
import PaginatedList from '../../../components/PaginatedList/PaginatedList';
import styles from './ListarVeiculos.module.css';

interface Veiculo {
  id?: number;
  placa: string;
  tara: number;
  capacidadeKg?: number;
  tipoRodado: string;
  tipoCarroceria: string;
  uf: string;
  rntrc?: string;
  ativo?: boolean;
  marca: string;
  modelo: string;
  ano: number;
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

export function ListarVeiculos() {
  const [veiculos, setVeiculos] = useState<Veiculo[]>([]);
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
  const [veiculoEdicao, setVeiculoEdicao] = useState<Veiculo | null>(null);
  const [veiculoVisualizacao, setVeiculoVisualizacao] = useState<Veiculo | null>(null);

  // Estados do modal de exclusão
  const [modalExclusao, setModalExclusao] = useState(false);
  const [veiculoExclusao, setVeiculoExclusao] = useState<Veiculo | null>(null);
  const [excludindo, setExcluindo] = useState(false);
  const [salvando, setSalvando] = useState(false);
  const [mostrarCamposOpcionais, setMostrarCamposOpcionais] = useState({
    dadosComplementares: false,
    detalhes: false,
    configuracoes: false
  });

  const [dadosModal, setDadosModal] = useState<Veiculo>({
    placa: '',
    tara: 0,
    tipoRodado: '',
    tipoCarroceria: '',
    uf: '',
    marca: '',
    modelo: '',
    ano: new Date().getFullYear(),
    ativo: true
  });

  useEffect(() => {
    carregarVeiculos();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [paginaAtual, tamanhoPagina]);

  useEffect(() => {
    setPaginaAtual(1);
    carregarVeiculos(1, filtro);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [filtro]);

  const carregarVeiculos = async (pagina: number = paginaAtual, busca: string = filtro) => {
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

      const response = await fetch(`${API_BASE_URL}/veiculos?${params}`);

      if (!response.ok) {
        throw new Error('Erro ao carregar veículos');
      }

      const data: PaginationData & { items: Veiculo[] } = await response.json();

      setVeiculos(data.items || []);
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
      console.error('Erro ao carregar veículos:', error);
      setVeiculos([]);
      setPaginacao(null);
    } finally {
      setCarregando(false);
    }
  };

  const abrirModalNovo = () => {
    setVeiculoEdicao(null);
    setDadosModal({
      placa: '',
      tara: 0,
      tipoRodado: '',
      tipoCarroceria: '',
      uf: '',
      marca: '',
      modelo: '',
      ano: new Date().getFullYear(),
      ativo: true
    });
    setModalAberto(true);
  };

  const abrirModalEdicao = (veiculo: Veiculo) => {
    setVeiculoEdicao(veiculo);
    setDadosModal(veiculo);
    setModalAberto(true);
  };

  const abrirModalVisualizacao = (veiculo: Veiculo) => {
    setVeiculoVisualizacao(veiculo);
    setModalVisualizacao(true);
  };

  const fecharModal = () => {
    setModalAberto(false);
    setVeiculoEdicao(null);
    setMostrarCamposOpcionais({
      dadosComplementares: false,
      detalhes: false,
      configuracoes: false
    });
  };

  const fecharModalVisualizacao = () => {
    setModalVisualizacao(false);
    setVeiculoVisualizacao(null);
  };

  const toggleCampoOpcional = (campo: keyof typeof mostrarCamposOpcionais) => {
    setMostrarCamposOpcionais(prev => ({
      ...prev,
      [campo]: !prev[campo]
    }));
  };

  const salvarVeiculo = async (e: React.FormEvent) => {
    e.preventDefault();
    setSalvando(true);

    try {
      // Limpar dados antes do envio
      const dadosLimpos = {
        ...dadosModal,
        placa: dadosModal.placa.trim().toUpperCase(),
        marca: dadosModal.marca.trim(),
        modelo: dadosModal.modelo.trim(),
        uf: dadosModal.uf.toUpperCase()
      };

      let resposta;
      if (veiculoEdicao?.id) {
        // Atualizar existente
        resposta = await entitiesService.atualizarVeiculo(veiculoEdicao.id, dadosLimpos);
      } else {
        // Criar novo
        resposta = await entitiesService.criarVeiculo(dadosLimpos);
      }

      if (resposta.sucesso) {
        fecharModal();
        carregarVeiculos(); // Recarregar lista do backend
      } else {
        alert(`Erro ao salvar veículo: ${resposta.mensagem}`);
      }
    } catch (error) {
      console.error('Erro ao salvar veículo:', error);
      alert('Erro inesperado ao salvar veículo. Verifique os dados e tente novamente.');
    } finally {
      setSalvando(false);
    }
  };

  const abrirModalExclusao = (veiculo: Veiculo) => {
    setVeiculoExclusao(veiculo);
    setModalExclusao(true);
  };

  const fecharModalExclusao = () => {
    setModalExclusao(false);
    setVeiculoExclusao(null);
    setExcluindo(false);
  };

  const confirmarExclusao = async () => {
    if (!veiculoExclusao?.id) return;

    try {
      setExcluindo(true);
      const resposta = await entitiesService.excluirVeiculo(veiculoExclusao.id);

      if (resposta.sucesso) {
        fecharModalExclusao();
        carregarVeiculos(); // Recarregar lista do backend
      } else {
        alert(`Erro ao excluir veículo: ${resposta.mensagem}`);
        setExcluindo(false);
      }
    } catch (error) {
      console.error('Erro ao excluir veículo:', error);
      alert('Erro inesperado ao excluir veículo. Tente novamente.');
      setExcluindo(false);
    }
  };

  const veiculosFiltrados = veiculos.filter(veiculo => {
    // Filtro de tipo
    const tipoMatch = !filtroTipo || veiculo.tipoRodado === filtroTipo;

    // Filtro de status
    const statusMatch = !filtroStatus ||
      (filtroStatus === 'ativo' && veiculo.ativo) ||
      (filtroStatus === 'inativo' && !veiculo.ativo);

    // Filtro de UF
    const ufMatch = !filtroUf || veiculo.uf === filtroUf;

    return tipoMatch && statusMatch && ufMatch;
  });

  const limparFiltros = () => {
    setFiltro('');
    setFiltroTipo('');
    setFiltroStatus('');
    setFiltroUf('');
  };

  // Renderizar modal inline
  const renderModal = () => {
    if (!modalAberto) return null;

    return (
      <div className={styles.modalOverlay}>
        <div className={styles.modal}>
          <div className={styles.modalHeader}>
            <h2>{veiculoEdicao ? 'Editar Veículo' : 'Novo Veículo'}</h2>
            <button className={styles.closeBtn} onClick={fecharModal}>×</button>
          </div>

          <form id="veiculo-form" onSubmit={salvarVeiculo} className={styles.modalForm}>
            <div className={styles.modalSection}>
              <h3>Dados Principais</h3>

              <div className={styles.modalRow}>
                <div className={styles.modalField}>
                  <label>Placa *</label>
                  <input
                    type="text"
                    value={formatPlaca(dadosModal.placa)}
                    onChange={(e) => setDadosModal({ ...dadosModal, placa: cleanPlaca(e.target.value) })}
                    placeholder="ABC-1234"
                    maxLength={8}
                    required
                  />
                </div>
              </div>

              <div className={styles.modalRow}>
                <div className={styles.modalField}>
                  <label>Marca *</label>
                  <input
                    type="text"
                    value={dadosModal.marca}
                    onChange={(e) => setDadosModal({ ...dadosModal, marca: e.target.value })}
                    required
                  />
                </div>

                <div className={styles.modalField}>
                  <label>Modelo *</label>
                  <input
                    type="text"
                    value={dadosModal.modelo}
                    onChange={(e) => setDadosModal({ ...dadosModal, modelo: e.target.value })}
                    required
                  />
                </div>
              </div>

              <div className={styles.modalRow}>
                <div className={styles.modalField}>
                  <label>Ano *</label>
                  <input
                    type="number"
                    value={dadosModal.ano}
                    onChange={(e) => setDadosModal({ ...dadosModal, ano: parseInt(e.target.value) })}
                    required
                    min="1900"
                    max={new Date().getFullYear() + 1}
                  />
                </div>
              </div>

              <div className={styles.modalRow}>
                <div className={styles.modalField}>
                  <label>Tipo de Rodado *</label>
                  <select
                    value={dadosModal.tipoRodado}
                    onChange={(e) => setDadosModal({ ...dadosModal, tipoRodado: e.target.value })}
                    required
                  >
                    <option value="">Selecione</option>
                    <option value="01">01 - Truck</option>
                    <option value="02">02 - Toco</option>
                    <option value="03">03 - Cavalo Mecânico</option>
                    <option value="04">04 - VAN</option>
                    <option value="05">05 - Utilitário</option>
                    <option value="06">06 - Outros</option>
                  </select>
                </div>

                <div className={styles.modalField}>
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

            <OptionalFieldsToggle
              label="Dados Complementares"
              description="Capacidade, tara e outras informações"
              isExpanded={mostrarCamposOpcionais.dadosComplementares}
              onToggle={() => toggleCampoOpcional('dadosComplementares')}
              icon="fas fa-address-book"
            />

            <OptionalSection isVisible={mostrarCamposOpcionais.dadosComplementares}>
              <div className={styles.modalRow}>
                <div className={styles.modalField}>
                  <label>Tara (kg) *</label>
                  <input
                    type="number"
                    value={dadosModal.tara}
                    onChange={(e) => setDadosModal({ ...dadosModal, tara: Number(e.target.value) })}
                    min="0"
                    required
                  />
                </div>

                <div className={styles.modalField}>
                  <label>Capacidade (kg)</label>
                  <input
                    type="number"
                    value={dadosModal.capacidadeKg || ''}
                    onChange={(e) => setDadosModal({ ...dadosModal, capacidadeKg: Number(e.target.value) || undefined })}
                    min="0"
                  />
                </div>

              </div>

              <div className={styles.modalRow}>
                <div className={styles.modalField}>
                  <label>Tipo de Carroceria *</label>
                  <select
                    value={dadosModal.tipoCarroceria}
                    onChange={(e) => setDadosModal({ ...dadosModal, tipoCarroceria: e.target.value })}
                    required
                  >
                    <option value="">Selecione</option>
                    <option value="00">00 - Não aplicável</option>
                    <option value="01">01 - Aberta</option>
                    <option value="02">02 - Fechada/baú</option>
                    <option value="03">03 - Graneleira</option>
                    <option value="04">04 - Porta Container</option>
                    <option value="05">05 - Sider</option>
                  </select>
                </div>


                <div className={styles.modalField}>
                  <label>RNTRC</label>
                  <input
                    type="text"
                    value={dadosModal.rntrc || ''}
                    onChange={(e) => setDadosModal({ ...dadosModal, rntrc: e.target.value })}
                    placeholder="Registro Nacional dos Transportadores"
                  />
                </div>
              </div>

            </OptionalSection>

            {veiculoEdicao && (
              <>
                <OptionalFieldsToggle
                  label="Configurações"
                  description="Status e configurações do veículo"
                  isExpanded={mostrarCamposOpcionais.configuracoes}
                  onToggle={() => toggleCampoOpcional('configuracoes')}
                  icon="fas fa-cog"
                />

                <OptionalSection isVisible={mostrarCamposOpcionais.configuracoes}>
                  <div className={styles.modalRow}>
                    <div className={styles.modalField}>
                      <label>Status</label>
                      <select
                        value={dadosModal.ativo ? 'true' : 'false'}
                        onChange={(e) => setDadosModal({ ...dadosModal, ativo: e.target.value === 'true' })}
                      >
                        <option value="true">Ativo</option>
                        <option value="false">Inativo</option>
                      </select>
                    </div>
                  </div>
                </OptionalSection>
              </>
            )}
          </form>

          <div className={styles.modalActions}>
            <button type="button" onClick={fecharModal} className={styles.btnCancel}>
              Cancelar
            </button>
            <button type="submit" form="veiculo-form" className={styles.btnSave} disabled={salvando}>
              {salvando ? 'Salvando...' : (veiculoEdicao ? 'Atualizar' : 'Salvar')}
            </button>
          </div>
        </div>
      </div>
    );
  };

  // Renderizar modal de visualização
  const renderModalVisualizacao = () => {
    if (!modalVisualizacao || !veiculoVisualizacao) return null;

    return (
      <div className={styles.modalOverlay}>
        <div className={styles.modal}>
          <div className={styles.modalHeader}>
            <h2>Visualizar Veículo</h2>
            <button className={styles.closeBtn} onClick={fecharModalVisualizacao}>×</button>
          </div>

          <div className={styles.modalContent}>
            <div className={styles.modalSection}>
              <h3>Dados Principais</h3>
              <div className={styles.viewGrid}>
                <div className={styles.viewField}>
                  <label>Placa:</label>
                  <span>{veiculoVisualizacao.placa}</span>
                </div>
                <div className={styles.viewField}>
                  <label>Marca:</label>
                  <span>{veiculoVisualizacao.marca}</span>
                </div>
                <div className={styles.viewField}>
                  <label>Modelo:</label>
                  <span>{veiculoVisualizacao.modelo}</span>
                </div>
                <div className={styles.viewField}>
                  <label>Ano:</label>
                  <span>{veiculoVisualizacao.ano}</span>
                </div>
                <div className={styles.viewField}>
                  <label>Tipo de Rodado:</label>
                  <span>{veiculoVisualizacao.tipoRodado}</span>
                </div>
                <div className={styles.viewField}>
                  <label>UF:</label>
                  <span>{veiculoVisualizacao.uf}</span>
                </div>
              </div>
            </div>

            {(veiculoVisualizacao.tara || veiculoVisualizacao.capacidadeKg || veiculoVisualizacao.tipoCarroceria || veiculoVisualizacao.rntrc) && (
              <div className={styles.modalSection}>
                <h3>Dados Complementares</h3>
                <div className={styles.viewGrid}>
                  <div className={styles.viewField}>
                    <label>Tara:</label>
                    <span>{veiculoVisualizacao.tara.toLocaleString()} kg</span>
                  </div>
                  {veiculoVisualizacao.capacidadeKg && (
                    <div className={styles.viewField}>
                      <label>Capacidade (kg):</label>
                      <span>{veiculoVisualizacao.capacidadeKg.toLocaleString()} kg</span>
                    </div>
                  )}
                  <div className={styles.viewField}>
                    <label>Tipo de Carroceria:</label>
                    <span>{veiculoVisualizacao.tipoCarroceria}</span>
                  </div>
                  {veiculoVisualizacao.rntrc && (
                    <div className={styles.viewField}>
                      <label>RNTRC:</label>
                      <span>{veiculoVisualizacao.rntrc}</span>
                    </div>
                  )}
                </div>
              </div>
            )}

            <div className={styles.modalSection}>
              <h3>Configurações</h3>
              <div className={styles.viewGrid}>
                <div className={styles.viewField}>
                  <label>Status:</label>
                  <span className={`${styles.statusBadge} ${veiculoVisualizacao.ativo ? styles.ativo : styles.inativo}`}>
                    {veiculoVisualizacao.ativo ? 'Ativo' : 'Inativo'}
                  </span>
                </div>
              </div>
            </div>
          </div>

          <div className={styles.modalActions}>
            <button onClick={fecharModalVisualizacao} className={styles.btnCancel}>
              Fechar
            </button>
            <button
              onClick={() => {
                fecharModalVisualizacao();
                abrirModalEdicao(veiculoVisualizacao);
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
        <div className={styles.loading}>Carregando veículos...</div>
      </div>
    );
  }

  return (
    <div className={styles.container}>
      <div className={styles.header}>
        <h1>
          <i className="fas fa-truck"></i>
          Veículos
        </h1>
        <button className={styles.btnNovo} onClick={abrirModalNovo}>
          Novo Veículo
        </button>
      </div>

      <div className={styles.filters}>
        <div className={styles.filtersRow}>
          <div className={styles.filterField}>
            <label>Buscar</label>
            <input
              type="text"
              placeholder="Placa ou marca..."
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
              <option value="01">01 - Truck</option>
              <option value="02">02 - Toco</option>
              <option value="03">03 - Cavalo Mecânico</option>
              <option value="04">04 - VAN</option>
              <option value="05">05 - Utilitário</option>
              <option value="06">06 - Outros</option>
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
        {veiculosFiltrados.length === 0 ? (
          <div className={styles.emptyState}>
            <h3>Nenhum veículo encontrado</h3>
            <p>Adicione um novo veículo para começar.</p>
          </div>
        ) : (
          <div className={styles.table}>
            <div className={styles.tableHeader}>
              <div>Placa</div>
              <div>Veículo</div>
              <div>Tipo</div>
              <div>Localização</div>
              <div>Status</div>
              <div>Ações</div>
            </div>

            {veiculosFiltrados.map((veiculo) => (
              <div key={veiculo.id} className={styles.tableRow}>
                <div>
                  <strong>{veiculo.placa}</strong>
                  {veiculo.renavam && (
                    <div className={styles.subtext}>RENAVAM: {veiculo.renavam}</div>
                  )}
                </div>
                <div>
                  <strong>{veiculo.marca} {veiculo.modelo}</strong>
                  <div className={styles.subtext}>{veiculo.ano} - {veiculo.cor}</div>
                </div>
                <div>
                  <span className={styles.tipoVeiculo}>
                    Tipo {veiculo.tipoRodado}
                  </span>
                </div>
                <div>
                  <strong>{veiculo.uf}</strong>
                </div>
                <div>
                  <span className={`${styles.status} ${veiculo.ativo ? styles.ativo : styles.inativo}`}>
                    {veiculo.ativo ? 'Ativo' : 'Inativo'}
                  </span>
                </div>
                <div className={styles.actions}>
                  <button
                    className={styles.btnView}
                    onClick={() => abrirModalVisualizacao(veiculo)}
                  >
                    Visualizar
                  </button>
                  <button
                    className={styles.btnEdit}
                    onClick={() => abrirModalEdicao(veiculo)}
                  >
                    Editar
                  </button>
                  <button
                    className={styles.btnDelete}
                    onClick={() => abrirModalExclusao(veiculo)}
                  >
                    Excluir
                  </button>
                </div>
              </div>
            ))}
          </div>
        )}

        {/* Informações e Paginação - só mostra se houver registros */}
        {paginacao && paginacao.totalItems > 0 && (
          <div className={styles.paginationContainer}>
            <div className={styles.paginationControls}>
              <div className={styles.paginationInfo}>
                Mostrando {paginacao.startItem} até {paginacao.endItem} de {paginacao.totalItems} veículos
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
        title="Excluir Veículo"
        message="Tem certeza de que deseja excluir este veículo?"
        itemName={veiculoExclusao ? `${formatPlaca(veiculoExclusao.placa)} - ${veiculoExclusao.marca} ${veiculoExclusao.modelo}` : ''}
        onConfirm={confirmarExclusao}
        onCancel={fecharModalExclusao}
        loading={excludindo}
      />
    </div>
  );
}