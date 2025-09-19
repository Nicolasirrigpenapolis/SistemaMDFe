import React, { useState, useEffect } from 'react';
import styles from './ListarMunicipios.module.css';

interface Municipio {
  id?: number;
  codigo: string;
  nome: string;
  uf: string;
  ativo?: boolean;
  ibge?: string;
}

export function ListarMunicipios() {
  const [municipios, setMunicipios] = useState<Municipio[]>([]);
  const [carregando, setCarregando] = useState(false);
  const [filtro, setFiltro] = useState('');

  // Estados do modal
  const [modalAberto, setModalAberto] = useState(false);
  const [municipioEdicao, setMunicipioEdicao] = useState<Municipio | null>(null);
  const [dadosModal, setDadosModal] = useState<Municipio>({
    codigo: '',
    nome: '',
    uf: ''
  });

  useEffect(() => {
    carregarMunicipios();
  }, []);

  const carregarMunicipios = async () => {
    try {
      setCarregando(true);
      // Simular dados por enquanto
      const dadosSimulados: Municipio[] = [
        {
          id: 1,
          codigo: '3550308',
          nome: 'São Paulo',
          uf: 'SP',
          ibge: '3550308',
          ativo: true
        },
        {
          id: 2,
          codigo: '3304557',
          nome: 'Rio de Janeiro',
          uf: 'RJ',
          ibge: '3304557',
          ativo: true
        },
        {
          id: 3,
          codigo: '3106200',
          nome: 'Belo Horizonte',
          uf: 'MG',
          ibge: '3106200',
          ativo: true
        },
        {
          id: 4,
          codigo: '4106902',
          nome: 'Curitiba',
          uf: 'PR',
          ibge: '4106902',
          ativo: true
        },
        {
          id: 5,
          codigo: '4314902',
          nome: 'Porto Alegre',
          uf: 'RS',
          ibge: '4314902',
          ativo: true
        }
      ];
      setMunicipios(dadosSimulados);
    } catch (error) {
      console.error('Erro ao carregar municípios:', error);
    } finally {
      setCarregando(false);
    }
  };

  const abrirModalNovo = () => {
    setMunicipioEdicao(null);
    setDadosModal({
      codigo: '',
      nome: '',
      uf: ''
    });
    setModalAberto(true);
  };

  const abrirModalEdicao = (municipio: Municipio) => {
    setMunicipioEdicao(municipio);
    setDadosModal(municipio);
    setModalAberto(true);
  };

  const fecharModal = () => {
    setModalAberto(false);
    setMunicipioEdicao(null);
  };

  const salvarMunicipio = async (e: React.FormEvent) => {
    e.preventDefault();

    try {
      if (municipioEdicao) {
        // Atualizar existente
        setMunicipios(prev => prev.map(mun =>
          mun.id === municipioEdicao.id ? { ...dadosModal, id: municipioEdicao.id } : mun
        ));
      } else {
        // Criar novo
        const novoMunicipio = { ...dadosModal, id: Date.now(), ativo: true };
        setMunicipios(prev => [...prev, novoMunicipio]);
      }

      fecharModal();
    } catch (error) {
      console.error('Erro ao salvar município:', error);
    }
  };

  const excluirMunicipio = async (id: number) => {
    if (window.confirm('Deseja realmente excluir este município?')) {
      setMunicipios(prev => prev.filter(mun => mun.id !== id));
    }
  };

  const municipiosFiltrados = municipios.filter(municipio =>
    municipio.nome.toLowerCase().includes(filtro.toLowerCase()) ||
    municipio.codigo.includes(filtro) ||
    municipio.uf.toLowerCase().includes(filtro.toLowerCase())
  );

  // Renderizar modal inline
  const renderModal = () => {
    if (!modalAberto) return null;

    return (
      <div className={styles.modalOverlay}>
        <div className={styles.modal}>
          <div className={styles.modalHeader}>
            <h2>{municipioEdicao ? 'Editar Município' : 'Novo Município'}</h2>
            <button className={styles.closeBtn} onClick={fecharModal}>×</button>
          </div>

          <form onSubmit={salvarMunicipio} className={styles.modalForm}>
            <div className={styles.modalSection}>
              <h3>Dados do Município</h3>

              <div className={styles.modalRow}>
                <div className={styles.modalField}>
                  <label>Nome *</label>
                  <input
                    type="text"
                    value={dadosModal.nome}
                    onChange={(e) => setDadosModal({ ...dadosModal, nome: e.target.value })}
                    required
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
                    <option value="SP">SP</option>
                    <option value="RJ">RJ</option>
                    <option value="MG">MG</option>
                    <option value="RS">RS</option>
                    <option value="PR">PR</option>
                    <option value="SC">SC</option>
                    <option value="BA">BA</option>
                    <option value="GO">GO</option>
                    <option value="PE">PE</option>
                    <option value="CE">CE</option>
                  </select>
                </div>
              </div>

              <div className={styles.modalRow}>
                <div className={styles.modalField}>
                  <label>Código IBGE *</label>
                  <input
                    type="text"
                    value={dadosModal.codigo}
                    onChange={(e) => setDadosModal({ ...dadosModal, codigo: e.target.value })}
                    placeholder="Ex: 3550308"
                    required
                  />
                </div>

                <div className={styles.modalField}>
                  <label>Código IBGE (Verificação)</label>
                  <input
                    type="text"
                    value={dadosModal.ibge || ''}
                    onChange={(e) => setDadosModal({ ...dadosModal, ibge: e.target.value })}
                    placeholder="Código para verificação"
                  />
                </div>
              </div>
            </div>

            <div className={styles.modalActions}>
              <button type="button" onClick={fecharModal} className={styles.btnCancel}>
                Cancelar
              </button>
              <button type="submit" className={styles.btnSave}>
                {municipioEdicao ? 'Atualizar' : 'Salvar'}
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
        <div className={styles.loading}>Carregando municípios...</div>
      </div>
    );
  }

  return (
    <div className={styles.container}>
      <div className={styles.header}>
        <h1>Municípios</h1>
        <button className={styles.btnNovo} onClick={abrirModalNovo}>
          Novo Município
        </button>
      </div>

      <div className={styles.filters}>
        <input
          type="text"
          placeholder="Buscar por nome, código ou UF..."
          value={filtro}
          onChange={(e) => setFiltro(e.target.value)}
          className={styles.searchInput}
        />
      </div>

      <div className={styles.list}>
        {municipiosFiltrados.length === 0 ? (
          <div className={styles.emptyState}>
            <h3>Nenhum município encontrado</h3>
            <p>Adicione um novo município para começar.</p>
          </div>
        ) : (
          <div className={styles.table}>
            <div className={styles.tableHeader}>
              <div>Nome</div>
              <div>Código IBGE</div>
              <div>UF</div>
              <div>Status</div>
              <div>Ações</div>
            </div>

            {municipiosFiltrados.map((municipio) => (
              <div key={municipio.id} className={styles.tableRow}>
                <div>
                  <strong>{municipio.nome}</strong>
                  {municipio.ibge && (
                    <div className={styles.subtext}>IBGE: {municipio.ibge}</div>
                  )}
                </div>
                <div>{municipio.codigo}</div>
                <div>{municipio.uf}</div>
                <div>
                  <span className={`${styles.status} ${municipio.ativo ? styles.ativo : styles.inativo}`}>
                    {municipio.ativo ? 'Ativo' : 'Inativo'}
                  </span>
                </div>
                <div className={styles.actions}>
                  <button
                    className={styles.btnEdit}
                    onClick={() => abrirModalEdicao(municipio)}
                  >
                    Editar
                  </button>
                  <button
                    className={styles.btnDelete}
                    onClick={() => municipio.id && excluirMunicipio(municipio.id)}
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