import React, { useState, useEffect } from 'react';
import { OptionalFieldsToggle, OptionalSection } from '../../../components/UI/Common/OptionalFieldsToggle';
import styles from './ListarVeiculos.module.css';

interface Veiculo {
  id?: number;
  placa: string;
  renavam?: string;
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
  cor: string;
  combustivel: string;
}

export function ListarVeiculos() {
  const [veiculos, setVeiculos] = useState<Veiculo[]>([]);
  const [carregando, setCarregando] = useState(false);
  const [filtro, setFiltro] = useState('');

  // Estados do modal
  const [modalAberto, setModalAberto] = useState(false);
  const [veiculoEdicao, setVeiculoEdicao] = useState<Veiculo | null>(null);
  const [mostrarCamposOpcionais, setMostrarCamposOpcionais] = useState({
    detalhes: false,
    configuracoes: false
  });
  const [dadosModal, setDadosModal] = useState<Veiculo>({
    placa: '',
    tara: 0,
    tipoRodado: '',
    tipoCarroceria: '',
    uf: '',
    ativo: true,
    marca: '',
    modelo: '',
    ano: new Date().getFullYear(),
    cor: '',
    combustivel: ''
  });

  useEffect(() => {
    carregarVeiculos();
  }, []);

  const carregarVeiculos = async () => {
    try {
      setCarregando(true);
      // Simular dados por enquanto
      const dadosSimulados: Veiculo[] = [
        {
          id: 1,
          placa: 'ABC-1234',
          renavam: '123456789',
          tara: 7500,
          capacidadeKg: 25000,
          tipoRodado: '06',
          tipoCarroceria: '00',
          uf: 'SP',
          rntrc: '12345678',
          ativo: true,
          marca: 'Scania',
          modelo: 'R450',
          ano: 2020,
          cor: 'Branco',
          combustivel: 'Diesel'
        },
        {
          id: 2,
          placa: 'DEF-5678',
          renavam: '987654321',
          tara: 3500,
          capacidadeKg: 15000,
          tipoRodado: '04',
          tipoCarroceria: '02',
          uf: 'SP',
          ativo: true,
          marca: 'Volvo',
          modelo: 'Carreta',
          ano: 2018,
          cor: 'Azul',
          combustivel: 'Diesel'
        }
      ];
      setVeiculos(dadosSimulados);
    } catch (error) {
      console.error('Erro ao carregar veículos:', error);
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
      ativo: true,
      marca: '',
      modelo: '',
      ano: new Date().getFullYear(),
      cor: '',
      combustivel: ''
    });
    setModalAberto(true);
  };

  const abrirModalEdicao = (veiculo: Veiculo) => {
    setVeiculoEdicao(veiculo);
    setDadosModal(veiculo);
    setModalAberto(true);
  };

  const fecharModal = () => {
    setModalAberto(false);
    setVeiculoEdicao(null);
    setMostrarCamposOpcionais({
      detalhes: false,
      configuracoes: false
    });
  };

  const toggleCampoOpcional = (campo: keyof typeof mostrarCamposOpcionais) => {
    setMostrarCamposOpcionais(prev => ({
      ...prev,
      [campo]: !prev[campo]
    }));
  };

  const salvarVeiculo = async (e: React.FormEvent) => {
    e.preventDefault();

    try {
      if (veiculoEdicao) {
        // Atualizar existente
        setVeiculos(prev => prev.map(vei =>
          vei.id === veiculoEdicao.id ? { ...dadosModal, id: veiculoEdicao.id } : vei
        ));
      } else {
        // Criar novo
        const novoVeiculo = { ...dadosModal, id: Date.now(), ativo: true };
        setVeiculos(prev => [...prev, novoVeiculo]);
      }

      fecharModal();
    } catch (error) {
      console.error('Erro ao salvar veículo:', error);
    }
  };

  const excluirVeiculo = async (id: number) => {
    if (window.confirm('Deseja realmente excluir este veículo?')) {
      setVeiculos(prev => prev.filter(vei => vei.id !== id));
    }
  };

  const veiculosFiltrados = veiculos.filter(veiculo =>
    veiculo.placa.toLowerCase().includes(filtro.toLowerCase()) ||
    veiculo.marca.toLowerCase().includes(filtro.toLowerCase()) ||
    veiculo.modelo.toLowerCase().includes(filtro.toLowerCase())
  );

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

          <form onSubmit={salvarVeiculo} className={styles.modalForm}>
            <div className={styles.modalSection}>
              <h3>Dados do Veículo</h3>

              <div className={styles.modalRow}>
                <div className={styles.modalField}>
                  <label>Placa *</label>
                  <input
                    type="text"
                    value={dadosModal.placa}
                    onChange={(e) => setDadosModal({ ...dadosModal, placa: e.target.value })}
                    placeholder="ABC-1234"
                    maxLength={8}
                    required
                  />
                </div>

                <div className={styles.modalField}>
                  <label>RENAVAM</label>
                  <input
                    type="text"
                    value={dadosModal.renavam || ''}
                    onChange={(e) => setDadosModal({ ...dadosModal, renavam: e.target.value })}
                    placeholder="Número do RENAVAM"
                    maxLength={11}
                  />
                </div>

                <div className={styles.modalField}>
                  <label>UF *</label>
                  <select
                    value={dadosModal.uf}
                    onChange={(e) => setDadosModal({ ...dadosModal, uf: e.target.value })}
                    required
                  >
                    <option value="">Selecione a UF</option>
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
                  <label>Marca *</label>
                  <input
                    type="text"
                    value={dadosModal.marca}
                    onChange={(e) => setDadosModal({ ...dadosModal, marca: e.target.value })}
                    placeholder="Ex: Scania, Volvo, Mercedes"
                    maxLength={100}
                    required
                  />
                </div>

                <div className={styles.modalField}>
                  <label>Modelo *</label>
                  <input
                    type="text"
                    value={dadosModal.modelo}
                    onChange={(e) => setDadosModal({ ...dadosModal, modelo: e.target.value })}
                    placeholder="Ex: R450, FH460"
                    maxLength={100}
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
                    onChange={(e) => setDadosModal({ ...dadosModal, ano: parseInt(e.target.value) || new Date().getFullYear() })}
                    required
                    min="1900"
                    max={new Date().getFullYear() + 1}
                  />
                </div>

                <div className={styles.modalField}>
                  <label>Cor *</label>
                  <input
                    type="text"
                    value={dadosModal.cor}
                    onChange={(e) => setDadosModal({ ...dadosModal, cor: e.target.value })}
                    placeholder="Ex: Branco, Azul"
                    maxLength={50}
                    required
                  />
                </div>

                <div className={styles.modalField}>
                  <label>Combustível *</label>
                  <select
                    value={dadosModal.combustivel}
                    onChange={(e) => setDadosModal({ ...dadosModal, combustivel: e.target.value })}
                    required
                  >
                    <option value="">Selecione</option>
                    <option value="Diesel">Diesel</option>
                    <option value="Gasolina">Gasolina</option>
                    <option value="Etanol">Etanol</option>
                    <option value="GNV">GNV</option>
                    <option value="Elétrico">Elétrico</option>
                    <option value="Híbrido">Híbrido</option>
                  </select>
                </div>
              </div>
            </div>

            <OptionalFieldsToggle
              label="Informações Complementares"
              description="RNTRC e configurações adicionais"
              isExpanded={mostrarCamposOpcionais.configuracoes}
              onToggle={() => toggleCampoOpcional('configuracoes')}
              icon="fas fa-cog"
            />

            <OptionalSection isVisible={mostrarCamposOpcionais.configuracoes}>
              <div className={styles.modalRow}>
                <div className={styles.modalField}>
                  <label>RNTRC</label>
                  <input
                    type="text"
                    value={dadosModal.rntrc || ''}
                    onChange={(e) => setDadosModal({ ...dadosModal, rntrc: e.target.value })}
                    placeholder="Registro Nacional dos Transportadores"
                    maxLength={20}
                  />
                </div>

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

            <div className={styles.modalActions}>
              <button type="button" onClick={fecharModal} className={styles.btnCancel}>
                Cancelar
              </button>
              <button type="submit" className={styles.btnSave}>
                {veiculoEdicao ? 'Atualizar' : 'Salvar'}
              </button>
            </div>
          </form>
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
        <h1>Veículos</h1>
        <button className="btn btn-primary" onClick={abrirModalNovo}>
          Novo Veículo
        </button>
      </div>

      <div className={styles.filters}>
        <input
          type="text"
          placeholder="Buscar por placa, marca ou modelo..."
          value={filtro}
          onChange={(e) => setFiltro(e.target.value)}
          className={styles.searchInput}
        />
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
              <div>Marca/Modelo</div>
              <div>Ano</div>
              <div>Capacidade</div>
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
                  <div className={styles.subtext}>Tara: {veiculo.tara.toLocaleString()} kg</div>
                </div>
                <div>
                  <span>{veiculo.ano}</span>
                  <div className={styles.subtext}>{veiculo.cor}</div>
                </div>
                <div>
                  <div>{veiculo.capacidadeKg ? veiculo.capacidadeKg.toLocaleString() + ' kg' : 'N/I'}</div>
                  <div className={styles.subtext}>{veiculo.tipoCarroceria}</div>
                </div>
                <div>
                  <span className={`${styles.status} ${veiculo.ativo ? styles.ativo : styles.inativo}`}>
                    {veiculo.ativo ? 'Ativo' : 'Inativo'}
                  </span>
                </div>
                <div className={styles.actions}>
                  <button
                    className={styles.btnEdit}
                    onClick={() => abrirModalEdicao(veiculo)}
                  >
                    Editar
                  </button>
                  <button
                    className={styles.btnDelete}
                    onClick={() => veiculo.id && excluirVeiculo(veiculo.id)}
                  >
                    Excluir
                  </button>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>

      {renderModal()}
    </div>
  );
}