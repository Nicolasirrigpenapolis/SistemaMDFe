import React, { useState, useEffect } from 'react';
import { ConfirmDeleteModal } from '../../../components/UI/Modal/ConfirmDeleteModal';
import { formatPlaca, cleanPlaca } from '../../../utils/formatters';
import styles from './ListarReboques.module.css';

interface Reboque {
  id?: number;
  placa: string;
  renavam?: string;
  tara: number;
  capacidadeKg: number;
  tipoRodado: string;
  tipoCarroceria: string;
  uf: string;
  rntrc?: string;
  ativo?: boolean;
}

export function ListarReboques() {
  const [reboques, setReboques] = useState<Reboque[]>([]);
  const [carregando, setCarregando] = useState(false);
  const [filtro, setFiltro] = useState('');

  // Estados do modal
  const [modalAberto, setModalAberto] = useState(false);
  const [reboqueEdicao, setReboqueEdicao] = useState<Reboque | null>(null);

  // Estados do modal de exclusão
  const [modalExclusao, setModalExclusao] = useState(false);
  const [reboqueExclusao, setReboqueExclusao] = useState<Reboque | null>(null);
  const [excludindo, setExcluindo] = useState(false);
  const [dadosModal, setDadosModal] = useState<Reboque>({
    placa: '',
    tara: 0,
    capacidadeKg: 0,
    tipoRodado: '',
    tipoCarroceria: '',
    uf: '',
    ativo: true
  });

  useEffect(() => {
    carregarReboques();
  }, []);

  const carregarReboques = async () => {
    try {
      setCarregando(true);

      // Conectar à API real de reboques
      const response = await fetch('https://localhost:5001/api/reboques?pageSize=100');

      if (!response.ok) {
        // Se não houver reboques cadastrados, mostrar lista vazia
        setReboques([]);
        return;
      }

      const data = await response.json();

      // Mapear dados da API para o formato esperado
      const reboquesFormatados = (data.items || data.Itens || data || []).map((reboque: any) => ({
        id: reboque.id || reboque.Id,
        placa: reboque.placa || reboque.Placa,
        renavam: reboque.renavam || reboque.Renavam,
        tara: reboque.tara || reboque.Tara,
        capacidadeKg: reboque.capacidadeKg || reboque.CapacidadeKg,
        tipoRodado: reboque.tipoRodado || reboque.TipoRodado,
        tipoCarroceria: reboque.tipoCarroceria || reboque.TipoCarroceria,
        uf: reboque.uf || reboque.Uf,
        rntrc: reboque.rntrc || reboque.Rntrc,
        ativo: reboque.ativo !== undefined ? reboque.ativo : reboque.Ativo !== undefined ? reboque.Ativo : true
      }));

      setReboques(reboquesFormatados);
    } catch (error) {
      console.error('Erro ao carregar reboques:', error);
    } finally {
      setCarregando(false);
    }
  };

  const abrirModalNovo = () => {
    setReboqueEdicao(null);
    setDadosModal({
      placa: '',
      tara: 0,
      capacidadeKg: 0,
      tipoRodado: '',
      tipoCarroceria: '',
      uf: '',
      ativo: true
    });
    setModalAberto(true);
  };

  const abrirModalEdicao = (reboque: Reboque) => {
    setReboqueEdicao(reboque);
    setDadosModal(reboque);
    setModalAberto(true);
  };

  const fecharModal = () => {
    setModalAberto(false);
    setReboqueEdicao(null);
  };

  const salvarReboque = async (e: React.FormEvent) => {
    e.preventDefault();

    try {
      if (reboqueEdicao) {
        // Atualizar existente
        setReboques(prev => prev.map(reb =>
          reb.id === reboqueEdicao.id ? { ...dadosModal, id: reboqueEdicao.id } : reb
        ));
      } else {
        // Criar novo
        const novoReboque = { ...dadosModal, id: Date.now(), ativo: true };
        setReboques(prev => [...prev, novoReboque]);
      }

      fecharModal();
    } catch (error) {
      console.error('Erro ao salvar reboque:', error);
    }
  };

  const abrirModalExclusao = (reboque: Reboque) => {
    setReboqueExclusao(reboque);
    setModalExclusao(true);
  };

  const fecharModalExclusao = () => {
    setModalExclusao(false);
    setReboqueExclusao(null);
    setExcluindo(false);
  };

  const confirmarExclusao = async () => {
    if (!reboqueExclusao?.id) return;

    try {
      setExcluindo(true);
      setReboques(prev => prev.filter(r => r.id !== reboqueExclusao.id));
      fecharModalExclusao();
    } catch (error) {
      console.error('Erro ao excluir reboque:', error);
      alert('Erro inesperado ao excluir reboque. Tente novamente.');
      setExcluindo(false);
    }
  };

  const reboquesFiltrados = reboques.filter(reboque =>
    reboque.placa.toLowerCase().includes(filtro.toLowerCase()) ||
    (reboque.rntrc && reboque.rntrc.includes(filtro))
  );

  // Renderizar modal inline
  const renderModal = () => {
    if (!modalAberto) return null;

    return (
      <div className={styles.modalOverlay}>
        <div className={styles.modal}>
          <div className={styles.modalHeader}>
            <h2>{reboqueEdicao ? 'Editar Reboque' : 'Novo Reboque'}</h2>
            <button className={styles.closeBtn} onClick={fecharModal}>×</button>
          </div>

          <form onSubmit={salvarReboque} className={styles.modalForm}>
            <div className={styles.modalSection}>
              <h3>Dados do Reboque</h3>

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

                <div className={styles.modalField}>
                  <label>RENAVAM</label>
                  <input
                    type="text"
                    value={dadosModal.renavam || ''}
                    onChange={(e) => setDadosModal({ ...dadosModal, renavam: e.target.value })}
                    placeholder="RENAVAM do reboque"
                    maxLength={11}
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

              <div className={styles.modalRow}>
                <div className={styles.modalField}>
                  <label>Tipo Rodado *</label>
                  <input
                    type="text"
                    value={dadosModal.tipoRodado}
                    onChange={(e) => setDadosModal({ ...dadosModal, tipoRodado: e.target.value })}
                    placeholder="Truck, Carreta, etc."
                    maxLength={50}
                    required
                  />
                </div>

                <div className={styles.modalField}>
                  <label>Tipo Carroceria *</label>
                  <input
                    type="text"
                    value={dadosModal.tipoCarroceria}
                    onChange={(e) => setDadosModal({ ...dadosModal, tipoCarroceria: e.target.value })}
                    placeholder="Baú, Graneleiro, etc."
                    maxLength={50}
                    required
                  />
                </div>
              </div>

              <div className={styles.modalRow}>
                <div className={styles.modalField}>
                  <label>Tara (kg) *</label>
                  <input
                    type="number"
                    value={dadosModal.tara || ''}
                    onChange={(e) => setDadosModal({ ...dadosModal, tara: parseInt(e.target.value) || 0 })}
                    placeholder="Peso do reboque vazio"
                    required
                  />
                </div>

                <div className={styles.modalField}>
                  <label>Capacidade (kg) *</label>
                  <input
                    type="number"
                    value={dadosModal.capacidadeKg || ''}
                    onChange={(e) => setDadosModal({ ...dadosModal, capacidadeKg: parseInt(e.target.value) || 0 })}
                    placeholder="Capacidade máxima de carga"
                    required
                  />
                </div>

                <div className={styles.modalField}>
                  <label>RNTRC</label>
                  <input
                    type="text"
                    value={dadosModal.rntrc || ''}
                    onChange={(e) => setDadosModal({ ...dadosModal, rntrc: e.target.value })}
                    placeholder="RNTRC do reboque"
                    maxLength={20}
                  />
                </div>
              </div>

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
            </div>

            <div className={styles.modalActions}>
              <button type="button" onClick={fecharModal} className={styles.btnCancel}>
                Cancelar
              </button>
              <button type="submit" className={styles.btnSave}>
                {reboqueEdicao ? 'Atualizar' : 'Salvar'}
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
        <div className={styles.loading}>Carregando reboques...</div>
      </div>
    );
  }

  return (
    <div className={styles.container}>
      <div className={styles.header}>
        <h1>Reboques</h1>
        <button className={styles.btnNovo} onClick={abrirModalNovo}>
          Novo Reboque
        </button>
      </div>

      <div className={styles.filters}>
        <input
          type="text"
          placeholder="Buscar por placa ou RNTRC..."
          value={filtro}
          onChange={(e) => setFiltro(e.target.value)}
          className={styles.searchInput}
        />
      </div>

      <div className={styles.list}>
        {reboquesFiltrados.length === 0 ? (
          <div className={styles.emptyState}>
            <h3>Nenhum reboque encontrado</h3>
            <p>Adicione um novo reboque para começar.</p>
          </div>
        ) : (
          <div className={styles.table}>
            <div className={styles.tableHeader}>
              <div>Placa</div>
              <div>Tipo</div>
              <div>Capacidade</div>
              <div>UF</div>
              <div>RNTRC</div>
              <div>Status</div>
              <div>Ações</div>
            </div>

            {reboquesFiltrados.map((reboque) => (
              <div key={reboque.id} className={styles.tableRow}>
                <div>
                  <strong>{reboque.placa}</strong>
                  {reboque.renavam && (
                    <div className={styles.subtext}>RENAVAM: {reboque.renavam}</div>
                  )}
                </div>
                <div>
                  <div>{reboque.tipoRodado}</div>
                  <div className={styles.subtext}>{reboque.tipoCarroceria}</div>
                </div>
                <div>
                  <div>Tara: {reboque.tara.toLocaleString()} kg</div>
                  <div className={styles.subtext}>Cap: {reboque.capacidadeKg.toLocaleString()} kg</div>
                </div>
                <div>{reboque.uf}</div>
                <div>{reboque.rntrc || '-'}</div>
                <div>
                  <span className={`${styles.status} ${reboque.ativo ? styles.ativo : styles.inativo}`}>
                    {reboque.ativo ? 'Ativo' : 'Inativo'}
                  </span>
                </div>
                <div className={styles.actions}>
                  <button
                    className={styles.btnEdit}
                    onClick={() => abrirModalEdicao(reboque)}
                  >
                    Editar
                  </button>
                  <button
                    className={styles.btnDelete}
                    onClick={() => abrirModalExclusao(reboque)}
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

      <ConfirmDeleteModal
        isOpen={modalExclusao}
        title="Excluir Reboque"
        message="Tem certeza de que deseja excluir este reboque?"
        itemName={reboqueExclusao ? formatPlaca(reboqueExclusao.placa) : ''}
        onConfirm={confirmarExclusao}
        onCancel={fecharModalExclusao}
        loading={excludindo}
      />
    </div>
  );
}