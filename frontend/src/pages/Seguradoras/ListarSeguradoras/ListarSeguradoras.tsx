import React, { useState, useEffect } from 'react';
import styles from './ListarSeguradoras.module.css';

interface Seguradora {
  id?: number;
  cnpj: string;
  razaoSocial: string;
  endereco: string;
  numero?: string;
  complemento?: string;
  bairro: string;
  codMunicipio: number;
  municipio: string;
  cep: string;
  uf: string;
  telefone?: string;
  apolice?: string;
  ativo?: boolean;
}

export function ListarSeguradoras() {
  const [seguradoras, setSeguradoras] = useState<Seguradora[]>([]);
  const [carregando, setCarregando] = useState(false);
  const [filtro, setFiltro] = useState('');

  // Estados do modal
  const [modalAberto, setModalAberto] = useState(false);
  const [seguradoraEdicao, setSeguradoraEdicao] = useState<Seguradora | null>(null);
  const [dadosModal, setDadosModal] = useState<Seguradora>({
    cnpj: '',
    razaoSocial: '',
    endereco: '',
    bairro: '',
    codMunicipio: 0,
    municipio: '',
    cep: '',
    uf: '',
    ativo: true
  });

  useEffect(() => {
    carregarSeguradoras();
  }, []);

  const carregarSeguradoras = async () => {
    try {
      setCarregando(true);
      // Simular dados por enquanto
      const dadosSimulados: Seguradora[] = [
        {
          id: 1,
          cnpj: '12345678000190',
          razaoSocial: 'Seguradora Brasil S.A.',
          endereco: 'Av. Faria Lima',
          numero: '2000',
          bairro: 'Itaim Bibi',
          codMunicipio: 3550308,
          municipio: 'São Paulo',
          cep: '01451000',
          uf: 'SP',
          telefone: '1133334444',
          apolice: 'POL-123456',
          ativo: true
        },
        {
          id: 2,
          cnpj: '98765432000110',
          razaoSocial: 'Porto Seguro Seguros',
          endereco: 'Alameda Barão de Piracicaba',
          numero: '618',
          bairro: 'Campos Elíseos',
          codMunicipio: 3550308,
          municipio: 'São Paulo',
          cep: '01216001',
          uf: 'SP',
          telefone: '1122223333',
          apolice: 'POL-789012',
          ativo: true
        }
      ];
      setSeguradoras(dadosSimulados);
    } catch (error) {
      console.error('Erro ao carregar seguradoras:', error);
    } finally {
      setCarregando(false);
    }
  };

  const abrirModalNovo = () => {
    setSeguradoraEdicao(null);
    setDadosModal({
      cnpj: '',
      razaoSocial: '',
      endereco: '',
      bairro: '',
      codMunicipio: 0,
      municipio: '',
      cep: '',
      uf: '',
      ativo: true
    });
    setModalAberto(true);
  };

  const abrirModalEdicao = (seguradora: Seguradora) => {
    setSeguradoraEdicao(seguradora);
    setDadosModal(seguradora);
    setModalAberto(true);
  };

  const fecharModal = () => {
    setModalAberto(false);
    setSeguradoraEdicao(null);
  };

  const salvarSeguradora = async (e: React.FormEvent) => {
    e.preventDefault();

    try {
      if (seguradoraEdicao) {
        // Atualizar existente
        setSeguradoras(prev => prev.map(seg =>
          seg.id === seguradoraEdicao.id ? { ...dadosModal, id: seguradoraEdicao.id } : seg
        ));
      } else {
        // Criar novo
        const novaSeguradora = { ...dadosModal, id: Date.now(), ativo: true };
        setSeguradoras(prev => [...prev, novaSeguradora]);
      }

      fecharModal();
    } catch (error) {
      console.error('Erro ao salvar seguradora:', error);
    }
  };

  const excluirSeguradora = async (id: number) => {
    if (window.confirm('Deseja realmente excluir esta seguradora?')) {
      setSeguradoras(prev => prev.filter(seg => seg.id !== id));
    }
  };

  const seguradorasFiltradas = seguradoras.filter(seguradora =>
    seguradora.razaoSocial.toLowerCase().includes(filtro.toLowerCase()) ||
    seguradora.cnpj.includes(filtro)
  );

  // Renderizar modal inline
  const renderModal = () => {
    if (!modalAberto) return null;

    return (
      <div className={styles.modalOverlay}>
        <div className={styles.modal}>
          <div className={styles.modalHeader}>
            <h2>{seguradoraEdicao ? 'Editar Seguradora' : 'Nova Seguradora'}</h2>
            <button className={styles.closeBtn} onClick={fecharModal}>×</button>
          </div>

          <form onSubmit={salvarSeguradora} className={styles.modalForm}>
            <div className={styles.modalSection}>
              <h3>Dados da Seguradora</h3>

              <div className={styles.modalRow}>
                <div className={styles.modalField}>
                  <label>CNPJ *</label>
                  <input
                    type="text"
                    value={dadosModal.cnpj}
                    onChange={(e) => setDadosModal({ ...dadosModal, cnpj: e.target.value })}
                    placeholder="00000000000000"
                    maxLength={14}
                    required
                  />
                </div>

                <div className={styles.modalField}>
                  <label>Razão Social *</label>
                  <input
                    type="text"
                    value={dadosModal.razaoSocial}
                    onChange={(e) => setDadosModal({ ...dadosModal, razaoSocial: e.target.value })}
                    placeholder="Razão social da seguradora"
                    maxLength={200}
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
                    placeholder="Telefone da seguradora"
                    maxLength={15}
                  />
                </div>

                <div className={styles.modalField}>
                  <label>Apólice</label>
                  <input
                    type="text"
                    value={dadosModal.apolice || ''}
                    onChange={(e) => setDadosModal({ ...dadosModal, apolice: e.target.value })}
                    placeholder="Número da apólice"
                    maxLength={50}
                  />
                </div>
              </div>
            </div>


            <div className={styles.modalSection}>
              <h3>Endereço</h3>

              <div className={styles.modalRow}>
                <div className={styles.modalField}>
                  <label>Endereço *</label>
                  <input
                    type="text"
                    value={dadosModal.endereco}
                    onChange={(e) => setDadosModal({ ...dadosModal, endereco: e.target.value })}
                    placeholder="Logradouro"
                    maxLength={200}
                    required
                  />
                </div>

                <div className={styles.modalFieldSmall}>
                  <label>Número</label>
                  <input
                    type="text"
                    value={dadosModal.numero || ''}
                    onChange={(e) => setDadosModal({ ...dadosModal, numero: e.target.value })}
                    placeholder="123"
                    maxLength={20}
                  />
                </div>

                <div className={styles.modalField}>
                  <label>Complemento</label>
                  <input
                    type="text"
                    value={dadosModal.complemento || ''}
                    onChange={(e) => setDadosModal({ ...dadosModal, complemento: e.target.value })}
                    placeholder="Apto, sala, etc."
                    maxLength={100}
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
                    placeholder="Nome do bairro"
                    maxLength={100}
                    required
                  />
                </div>

                <div className={styles.modalFieldSmall}>
                  <label>CEP *</label>
                  <input
                    type="text"
                    value={dadosModal.cep}
                    onChange={(e) => setDadosModal({ ...dadosModal, cep: e.target.value })}
                    placeholder="00000000"
                    maxLength={8}
                    required
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
                    placeholder="Nome do município"
                    maxLength={100}
                    required
                  />
                </div>

                <div className={styles.modalField}>
                  <label>Código IBGE *</label>
                  <input
                    type="number"
                    value={dadosModal.codMunicipio || ''}
                    onChange={(e) => setDadosModal({ ...dadosModal, codMunicipio: parseInt(e.target.value) || 0 })}
                    placeholder="Código IBGE do município"
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

            <div className={styles.modalActions}>
              <button type="button" onClick={fecharModal} className={styles.btnCancel}>
                Cancelar
              </button>
              <button type="submit" className={styles.btnSave}>
                {seguradoraEdicao ? 'Atualizar' : 'Salvar'}
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
        <div className={styles.loading}>Carregando seguradoras...</div>
      </div>
    );
  }

  return (
    <div className={styles.container}>
      <div className={styles.header}>
        <h1>Seguradoras</h1>
        <button className={styles.btnNovo} onClick={abrirModalNovo}>
          Nova Seguradora
        </button>
      </div>

      <div className={styles.filters}>
        <input
          type="text"
          placeholder="Buscar por nome ou CNPJ..."
          value={filtro}
          onChange={(e) => setFiltro(e.target.value)}
          className={styles.searchInput}
        />
      </div>

      <div className={styles.list}>
        {seguradorasFiltradas.length === 0 ? (
          <div className={styles.emptyState}>
            <h3>Nenhuma seguradora encontrada</h3>
            <p>Adicione uma nova seguradora para começar.</p>
          </div>
        ) : (
          <div className={styles.table}>
            <div className={styles.tableHeader}>
              <div>Razão Social</div>
              <div>CNPJ</div>
              <div>Telefone</div>
              <div>Cidade/UF</div>
              <div>Apólice</div>
              <div>Status</div>
              <div>Ações</div>
            </div>

            {seguradorasFiltradas.map((seguradora) => (
              <div key={seguradora.id} className={styles.tableRow}>
                <div>
                  <strong>{seguradora.razaoSocial}</strong>
                </div>
                <div>{seguradora.cnpj}</div>
                <div>
                  {seguradora.telefone || '-'}
                </div>
                <div>
                  {seguradora.municipio}/{seguradora.uf}
                </div>
                <div>
                  {seguradora.apolice || '-'}
                </div>
                <div>
                  <span className={`${styles.status} ${seguradora.ativo ? styles.ativo : styles.inativo}`}>
                    {seguradora.ativo ? 'Ativa' : 'Inativa'}
                  </span>
                </div>
                <div className={styles.actions}>
                  <button
                    className={styles.btnEdit}
                    onClick={() => abrirModalEdicao(seguradora)}
                  >
                    Editar
                  </button>
                  <button
                    className={styles.btnDelete}
                    onClick={() => seguradora.id && excluirSeguradora(seguradora.id)}
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