import React, { useState, useEffect } from 'react';
import styles from './ListarCondutores.module.css';

interface Condutor {
  id?: number;
  nome: string;
  cpf: string;
  telefone?: string;
  ativo?: boolean;
}

export function ListarCondutores() {
  const [condutores, setCondutores] = useState<Condutor[]>([]);
  const [carregando, setCarregando] = useState(false);
  const [filtro, setFiltro] = useState('');

  // Estados do modal
  const [modalAberto, setModalAberto] = useState(false);
  const [condutorEdicao, setCondutorEdicao] = useState<Condutor | null>(null);
  const [dadosModal, setDadosModal] = useState<Condutor>({
    nome: '',
    cpf: '',
    ativo: true
  });

  useEffect(() => {
    carregarCondutores();
  }, []);

  const carregarCondutores = async () => {
    try {
      setCarregando(true);
      // Simular dados por enquanto
      const dadosSimulados: Condutor[] = [
        {
          id: 1,
          nome: 'João da Silva',
          cpf: '12345678900',
          telefone: '11999991234',
          ativo: true
        },
        {
          id: 2,
          nome: 'Maria Santos',
          cpf: '98765432100',
          telefone: '11888885678',
          ativo: true
        }
      ];
      setCondutores(dadosSimulados);
    } catch (error) {
      console.error('Erro ao carregar condutores:', error);
    } finally {
      setCarregando(false);
    }
  };

  const abrirModalNovo = () => {
    setCondutorEdicao(null);
    setDadosModal({
      nome: '',
      cpf: '',
      ativo: true
    });
    setModalAberto(true);
  };

  const abrirModalEdicao = (condutor: Condutor) => {
    setCondutorEdicao(condutor);
    setDadosModal(condutor);
    setModalAberto(true);
  };

  const fecharModal = () => {
    setModalAberto(false);
    setCondutorEdicao(null);
  };

  const salvarCondutor = async (e: React.FormEvent) => {
    e.preventDefault();

    try {
      if (condutorEdicao) {
        // Atualizar existente
        setCondutores(prev => prev.map(cond =>
          cond.id === condutorEdicao.id ? { ...dadosModal, id: condutorEdicao.id } : cond
        ));
      } else {
        // Criar novo
        const novoCondutor = { ...dadosModal, id: Date.now(), ativo: true };
        setCondutores(prev => [...prev, novoCondutor]);
      }

      fecharModal();
    } catch (error) {
      console.error('Erro ao salvar condutor:', error);
    }
  };

  const excluirCondutor = async (id: number) => {
    if (window.confirm('Deseja realmente excluir este condutor?')) {
      setCondutores(prev => prev.filter(cond => cond.id !== id));
    }
  };

  const condutoresFiltrados = condutores.filter(condutor =>
    condutor.nome.toLowerCase().includes(filtro.toLowerCase()) ||
    condutor.cpf.includes(filtro)
  );

  // Renderizar modal inline
  const renderModal = () => {
    if (!modalAberto) return null;

    return (
      <div className={styles.modalOverlay}>
        <div className={styles.modal}>
          <div className={styles.modalHeader}>
            <h2>{condutorEdicao ? 'Editar Condutor' : 'Novo Condutor'}</h2>
            <button className={styles.closeBtn} onClick={fecharModal}>×</button>
          </div>

          <form onSubmit={salvarCondutor} className={styles.modalForm}>
            <div className={styles.modalSection}>
              <h3>Dados do Condutor</h3>

              <div className={styles.modalRow}>
                <div className={styles.modalField}>
                  <label>Nome Completo *</label>
                  <input
                    type="text"
                    value={dadosModal.nome}
                    onChange={(e) => setDadosModal({ ...dadosModal, nome: e.target.value })}
                    placeholder="Nome completo do condutor"
                    maxLength={200}
                    required
                  />
                </div>

                <div className={styles.modalField}>
                  <label>CPF *</label>
                  <input
                    type="text"
                    value={dadosModal.cpf}
                    onChange={(e) => setDadosModal({ ...dadosModal, cpf: e.target.value })}
                    placeholder="00000000000"
                    maxLength={11}
                    required
                  />
                </div>
              </div>

              <div className={styles.modalRow}>
                <div className={styles.modalField}>
                  <label>Telefone</label>
                  <input
                    type="text"
                    value={dadosModal.telefone || ''}
                    onChange={(e) => setDadosModal({ ...dadosModal, telefone: e.target.value })}
                    placeholder="Telefone do condutor"
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
            </div>

            <div className={styles.modalActions}>
              <button type="button" onClick={fecharModal} className={styles.btnCancel}>
                Cancelar
              </button>
              <button type="submit" className={styles.btnSave}>
                {condutorEdicao ? 'Atualizar' : 'Salvar'}
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
        <div className={styles.loading}>Carregando condutores...</div>
      </div>
    );
  }

  return (
    <div className={styles.container}>
      <div className={styles.header}>
        <h1>Condutores</h1>
        <button className={styles.btnNovo} onClick={abrirModalNovo}>
          Novo Condutor
        </button>
      </div>

      <div className={styles.filters}>
        <input
          type="text"
          placeholder="Buscar por nome ou CPF..."
          value={filtro}
          onChange={(e) => setFiltro(e.target.value)}
          className={styles.searchInput}
        />
      </div>

      <div className={styles.list}>
        {condutoresFiltrados.length === 0 ? (
          <div className={styles.emptyState}>
            <h3>Nenhum condutor encontrado</h3>
            <p>Adicione um novo condutor para começar.</p>
          </div>
        ) : (
          <div className={styles.table}>
            <div className={styles.tableHeader}>
              <div>Nome</div>
              <div>CPF</div>
              <div>Telefone</div>
              <div>Status</div>
              <div>Ações</div>
            </div>

            {condutoresFiltrados.map((condutor) => (
              <div key={condutor.id} className={styles.tableRow}>
                <div>
                  <strong>{condutor.nome}</strong>
                </div>
                <div>{condutor.cpf}</div>
                <div>
                  {condutor.telefone || '-'}
                </div>
                <div>
                  <span className={`${styles.status} ${condutor.ativo ? styles.ativo : styles.inativo}`}>
                    {condutor.ativo ? 'Ativo' : 'Inativo'}
                  </span>
                </div>
                <div className={styles.actions}>
                  <button
                    className={styles.btnEdit}
                    onClick={() => abrirModalEdicao(condutor)}
                  >
                    Editar
                  </button>
                  <button
                    className={styles.btnDelete}
                    onClick={() => condutor.id && excluirCondutor(condutor.id)}
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