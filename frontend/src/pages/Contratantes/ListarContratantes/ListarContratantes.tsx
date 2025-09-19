import React, { useState, useEffect } from 'react';
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
  telefone?: string;
  email?: string;
  ativo?: boolean;
}

export function ListarContratantes() {
  const [contratantes, setContratantes] = useState<Contratante[]>([]);
  const [carregando, setCarregando] = useState(false);
  const [filtro, setFiltro] = useState('');

  // Estados do modal
  const [modalAberto, setModalAberto] = useState(false);
  const [contratanteEdicao, setContratanteEdicao] = useState<Contratante | null>(null);
  const [dadosModal, setDadosModal] = useState<Contratante>({
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
    carregarContratantes();
  }, []);

  const carregarContratantes = async () => {
    try {
      setCarregando(true);
      // Simular dados por enquanto
      const dadosSimulados: Contratante[] = [
        {
          id: 1,
          cnpj: '12345678000190',
          razaoSocial: 'Empresa ABC Ltda',
          nomeFantasia: 'ABC Transportes',
          endereco: 'Av. Paulista',
          numero: '123',
          bairro: 'Bela Vista',
          codMunicipio: 3550308,
          municipio: 'São Paulo',
          cep: '01310100',
          uf: 'SP',
          telefone: '11999991234',
          email: 'contrato@empresaabc.com.br',
          ativo: true
        },
        {
          id: 2,
          cpf: '12345678900',
          razaoSocial: 'João Silva',
          endereco: 'Rua das Flores',
          numero: '456',
          bairro: 'Centro',
          codMunicipio: 3550308,
          municipio: 'São Paulo',
          cep: '01234567',
          uf: 'SP',
          telefone: '11888885678',
          email: 'joao@email.com',
          ativo: true
        }
      ];
      setContratantes(dadosSimulados);
    } catch (error) {
      console.error('Erro ao carregar contratantes:', error);
    } finally {
      setCarregando(false);
    }
  };

  const abrirModalNovo = () => {
    setContratanteEdicao(null);
    setDadosModal({
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

  const abrirModalEdicao = (contratante: Contratante) => {
    setContratanteEdicao(contratante);
    setDadosModal(contratante);
    setModalAberto(true);
  };

  const fecharModal = () => {
    setModalAberto(false);
    setContratanteEdicao(null);
  };

  const salvarContratante = async (e: React.FormEvent) => {
    e.preventDefault();

    try {
      if (contratanteEdicao) {
        // Atualizar existente
        setContratantes(prev => prev.map(cont =>
          cont.id === contratanteEdicao.id ? { ...dadosModal, id: contratanteEdicao.id } : cont
        ));
      } else {
        // Criar novo
        const novoContratante = { ...dadosModal, id: Date.now(), ativo: true };
        setContratantes(prev => [...prev, novoContratante]);
      }

      fecharModal();
    } catch (error) {
      console.error('Erro ao salvar contratante:', error);
    }
  };

  const excluirContratante = async (id: number) => {
    if (window.confirm('Deseja realmente excluir este contratante?')) {
      setContratantes(prev => prev.filter(cont => cont.id !== id));
    }
  };

  const contratantesFiltrados = contratantes.filter(contratante =>
    contratante.razaoSocial.toLowerCase().includes(filtro.toLowerCase()) ||
    (contratante.cnpj && contratante.cnpj.includes(filtro)) ||
    (contratante.cpf && contratante.cpf.includes(filtro))
  );

  // Renderizar modal inline
  const renderModal = () => {
    if (!modalAberto) return null;

    return (
      <div className={styles.modalOverlay}>
        <div className={styles.modal}>
          <div className={styles.modalHeader}>
            <h2>{contratanteEdicao ? 'Editar Contratante' : 'Novo Contratante'}</h2>
            <button className={styles.closeBtn} onClick={fecharModal}>×</button>
          </div>

          <form onSubmit={salvarContratante} className={styles.modalForm}>
            <div className={styles.modalSection}>
              <h3>Dados Principais</h3>

              <div className={styles.modalRow}>
                <div className={styles.modalField}>
                  <label>CNPJ</label>
                  <input
                    type="text"
                    value={dadosModal.cnpj || ''}
                    onChange={(e) => setDadosModal({ ...dadosModal, cnpj: e.target.value })}
                    placeholder="00000000000000"
                    maxLength={14}
                  />
                </div>

                <div className={styles.modalField}>
                  <label>CPF</label>
                  <input
                    type="text"
                    value={dadosModal.cpf || ''}
                    onChange={(e) => setDadosModal({ ...dadosModal, cpf: e.target.value })}
                    placeholder="00000000000"
                    maxLength={11}
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
                    placeholder="Razão social do contratante"
                    maxLength={200}
                    required
                  />
                </div>

                <div className={styles.modalField}>
                  <label>Nome Fantasia</label>
                  <input
                    type="text"
                    value={dadosModal.nomeFantasia || ''}
                    onChange={(e) => setDadosModal({ ...dadosModal, nomeFantasia: e.target.value })}
                    placeholder="Nome fantasia"
                    maxLength={200}
                  />
                </div>
              </div>
            </div>

            <div className={styles.modalSection}>
              <h3>Contato</h3>

              <div className={styles.modalRow}>
                <div className={styles.modalField}>
                  <label>Telefone</label>
                  <input
                    type="text"
                    value={dadosModal.telefone || ''}
                    onChange={(e) => setDadosModal({ ...dadosModal, telefone: e.target.value })}
                    placeholder="(11) 99999-1234"
                  />
                </div>

                <div className={styles.modalField}>
                  <label>Email</label>
                  <input
                    type="email"
                    value={dadosModal.email || ''}
                    onChange={(e) => setDadosModal({ ...dadosModal, email: e.target.value })}
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
                {contratanteEdicao ? 'Atualizar' : 'Salvar'}
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
        <div className={styles.loading}>Carregando contratantes...</div>
      </div>
    );
  }

  return (
    <div className={styles.container}>
      <div className={styles.header}>
        <h1>Contratantes</h1>
        <button className={styles.btnNovo} onClick={abrirModalNovo}>
          Novo Contratante
        </button>
      </div>

      <div className={styles.filters}>
        <input
          type="text"
          placeholder="Buscar por nome ou documento..."
          value={filtro}
          onChange={(e) => setFiltro(e.target.value)}
          className={styles.searchInput}
        />
      </div>

      <div className={styles.list}>
        {contratantesFiltrados.length === 0 ? (
          <div className={styles.emptyState}>
            <h3>Nenhum contratante encontrado</h3>
            <p>Adicione um novo contratante para começar.</p>
          </div>
        ) : (
          <div className={styles.table}>
            <div className={styles.tableHeader}>
              <div>Nome</div>
              <div>Documento</div>
              <div>Contato</div>
              <div>Cidade/UF</div>
              <div>Status</div>
              <div>Ações</div>
            </div>

            {contratantesFiltrados.map((contratante) => (
              <div key={contratante.id} className={styles.tableRow}>
                <div>
                  <strong>{contratante.razaoSocial}</strong>
                  {contratante.nomeFantasia && (
                    <div className={styles.subtext}>{contratante.nomeFantasia}</div>
                  )}
                </div>
                <div>
                  {contratante.cnpj && <div>CNPJ: {contratante.cnpj}</div>}
                  {contratante.cpf && <div>CPF: {contratante.cpf}</div>}
                </div>
                <div>
                  {contratante.telefone && <div>{contratante.telefone}</div>}
                  {contratante.email && (
                    <div className={styles.subtext}>{contratante.email}</div>
                  )}
                </div>
                <div>
                  {contratante.municipio}/{contratante.uf}
                </div>
                <div>
                  <span className={`${styles.status} ${contratante.ativo ? styles.ativo : styles.inativo}`}>
                    {contratante.ativo ? 'Ativo' : 'Inativo'}
                  </span>
                </div>
                <div className={styles.actions}>
                  <button
                    className={styles.btnEdit}
                    onClick={() => abrirModalEdicao(contratante)}
                  >
                    Editar
                  </button>
                  <button
                    className={styles.btnDelete}
                    onClick={() => contratante.id && excluirContratante(contratante.id)}
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