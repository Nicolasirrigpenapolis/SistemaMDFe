import React, { useState, useEffect } from 'react';
import { OptionalFieldsToggle, OptionalSection } from '../../../components/UI/Common/OptionalFieldsToggle';
import { cleanNumericString } from '../../../utils/formatters';
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
  telefone?: string;
  email?: string;
  ativo?: boolean;
  tipoEmitente: string;
  descricaoEmitente?: string;
  caminhoArquivoCertificado?: string;
  senhaCertificado?: string;
  rntrc?: string;
  ambienteSefaz?: number;
}

export function ListarEmitentes() {
  const [emitentes, setEmitentes] = useState<Emitente[]>([]);
  const [carregando, setCarregando] = useState(false);
  const [filtro, setFiltro] = useState('');

  // Estados do modal
  const [modalAberto, setModalAberto] = useState(false);
  const [emitenteEdicao, setEmitenteEdicao] = useState<Emitente | null>(null);
  const [mostrarCamposOpcionais, setMostrarCamposOpcionais] = useState({
    dadosComplementares: false,
    certificado: false,
    configuracoes: false
  });
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
  }, []);

  const carregarEmitentes = async () => {
    try {
      setCarregando(true);
      // Simular dados por enquanto
      const dadosSimulados: Emitente[] = [
        {
          id: 1,
          cnpj: '12.345.678/0001-90',
          razaoSocial: 'Empresa ABC Ltda',
          nomeFantasia: 'ABC Transportes',
          ie: '123456789',
          endereco: 'Rua das Flores',
          numero: '123',
          bairro: 'Centro',
          codMunicipio: 3550308,
          municipio: 'São Paulo',
          cep: '01234567',
          uf: 'SP',
          telefone: '(11) 1234-5678',
          email: 'contato@abc.com.br',
          ativo: true,
          tipoEmitente: 'PrestadorServico',
          rntrc: '12345678',
          ambienteSefaz: 2
        }
      ];
      setEmitentes(dadosSimulados);
    } catch (error) {
      console.error('Erro ao carregar emitentes:', error);
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
    setDadosModal(emitente);
    setModalAberto(true);
  };

  const fecharModal = () => {
    setModalAberto(false);
    setEmitenteEdicao(null);
    setMostrarCamposOpcionais({
      dadosComplementares: false,
      certificado: false,
      configuracoes: false
    });
  };

  const toggleCampoOpcional = (campo: keyof typeof mostrarCamposOpcionais) => {
    setMostrarCamposOpcionais(prev => ({
      ...prev,
      [campo]: !prev[campo]
    }));
  };

  const salvarEmitente = async (e: React.FormEvent) => {
    e.preventDefault();

    try {
      // Limpar dados antes do envio
      const dadosLimpos = {
        ...dadosModal,
        cnpj: dadosModal.cnpj ? cleanNumericString(dadosModal.cnpj) : undefined,
        cpf: dadosModal.cpf ? cleanNumericString(dadosModal.cpf) : undefined,
        cep: cleanNumericString(dadosModal.cep),
        telefone: dadosModal.telefone ? cleanNumericString(dadosModal.telefone) : undefined,
        email: dadosModal.email ? dadosModal.email.trim().toLowerCase() : undefined,
        razaoSocial: dadosModal.razaoSocial.trim(),
        nomeFantasia: dadosModal.nomeFantasia ? dadosModal.nomeFantasia.trim() : undefined,
        endereco: dadosModal.endereco.trim(),
        bairro: dadosModal.bairro.trim(),
        municipio: dadosModal.municipio.trim(),
        uf: dadosModal.uf.toUpperCase()
      };

      if (emitenteEdicao) {
        // Atualizar existente
        setEmitentes(prev => prev.map(emp =>
          emp.id === emitenteEdicao.id ? { ...dadosLimpos, id: emitenteEdicao.id } : emp
        ));
      } else {
        // Criar novo
        const novoEmitente = { ...dadosLimpos, id: Date.now(), ativo: true };
        setEmitentes(prev => [...prev, novoEmitente]);
      }

      fecharModal();
    } catch (error) {
      console.error('Erro ao salvar emitente:', error);
    }
  };

  const excluirEmitente = async (id: number) => {
    if (window.confirm('Deseja realmente excluir este emitente?')) {
      setEmitentes(prev => prev.filter(emp => emp.id !== id));
    }
  };

  const emitentesFiltrados = emitentes.filter(emitente =>
    emitente.razaoSocial.toLowerCase().includes(filtro.toLowerCase()) ||
    (emitente.cnpj && emitente.cnpj.includes(filtro))
  );

  // Renderizar modal inline
  const renderModal = () => {
    if (!modalAberto) return null;

    return (
      <div className={styles.modalOverlay}>
        <div className={styles.modal}>
          <div className={styles.modalHeader}>
            <h2>{emitenteEdicao ? 'Editar Emitente' : 'Novo Emitente'}</h2>
            <button className={styles.closeBtn} onClick={fecharModal}>×</button>
          </div>

          <form onSubmit={salvarEmitente} className={styles.modalForm}>
            <div className={styles.modalSection}>
              <h3>Dados Principais</h3>

              <div className={styles.modalRow}>
                <div className={styles.modalField}>
                  <label>CNPJ</label>
                  <input
                    type="text"
                    value={dadosModal.cnpj || ''}
                    onChange={(e) => setDadosModal({ ...dadosModal, cnpj: e.target.value })}
                    placeholder="00.000.000/0000-00"
                  />
                </div>

                <div className={styles.modalField}>
                  <label>CPF</label>
                  <input
                    type="text"
                    value={dadosModal.cpf || ''}
                    onChange={(e) => setDadosModal({ ...dadosModal, cpf: e.target.value })}
                    placeholder="000.000.000-00"
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
                    value={dadosModal.cep}
                    onChange={(e) => setDadosModal({ ...dadosModal, cep: e.target.value })}
                    required
                    placeholder="00000000"
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

            <OptionalFieldsToggle
              label="Dados Complementares"
              description="Telefone, email e outras informações"
              isExpanded={mostrarCamposOpcionais.dadosComplementares}
              onToggle={() => toggleCampoOpcional('dadosComplementares')}
              icon="fas fa-address-book"
            />

            <OptionalSection isVisible={mostrarCamposOpcionais.dadosComplementares}>
              <div className={styles.modalRow}>
                <div className={styles.modalField}>
                  <label>Telefone</label>
                  <input
                    type="text"
                    value={dadosModal.telefone || ''}
                    onChange={(e) => setDadosModal({ ...dadosModal, telefone: e.target.value })}
                    placeholder="(00) 0000-0000"
                  />
                </div>

                <div className={styles.modalField}>
                  <label>Email</label>
                  <input
                    type="email"
                    value={dadosModal.email || ''}
                    onChange={(e) => setDadosModal({ ...dadosModal, email: e.target.value })}
                    placeholder="contato@empresa.com.br"
                  />
                </div>
              </div>

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
                  <label>Descrição do Emitente</label>
                  <input
                    type="text"
                    value={dadosModal.descricaoEmitente || ''}
                    onChange={(e) => setDadosModal({ ...dadosModal, descricaoEmitente: e.target.value })}
                    placeholder="Ex: Transportadora ABC - Prestador"
                  />
                </div>
              </div>
            </OptionalSection>

            <OptionalFieldsToggle
              label="Certificado Digital"
              description="Configurações do certificado para assinatura"
              isExpanded={mostrarCamposOpcionais.certificado}
              onToggle={() => toggleCampoOpcional('certificado')}
              icon="fas fa-certificate"
            />

            <OptionalSection isVisible={mostrarCamposOpcionais.certificado}>
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
                    placeholder="Senha do certificado"
                  />
                </div>
              </div>
            </OptionalSection>

            <OptionalFieldsToggle
              label="Configurações SEFAZ"
              description="Ambiente e configurações do sistema"
              isExpanded={mostrarCamposOpcionais.configuracoes}
              onToggle={() => toggleCampoOpcional('configuracoes')}
              icon="fas fa-cog"
            />

            <OptionalSection isVisible={mostrarCamposOpcionais.configuracoes}>
              <div className={styles.modalRow}>
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
                {emitenteEdicao ? 'Atualizar' : 'Salvar'}
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
        <div className={styles.loading}>Carregando emitentes...</div>
      </div>
    );
  }

  return (
    <div className={styles.container}>
      <div className={styles.header}>
        <h1>Emitentes</h1>
        <button className={styles.btnNovo} onClick={abrirModalNovo}>
          Novo Emitente
        </button>
      </div>

      <div className={styles.filters}>
        <input
          type="text"
          placeholder="Buscar por razão social ou CNPJ..."
          value={filtro}
          onChange={(e) => setFiltro(e.target.value)}
          className={styles.searchInput}
        />
      </div>

      <div className={styles.list}>
        {emitentesFiltrados.length === 0 ? (
          <div className={styles.emptyState}>
            <h3>Nenhum emitente encontrado</h3>
            <p>Adicione um novo emitente para começar.</p>
          </div>
        ) : (
          <div className={styles.table}>
            <div className={styles.tableHeader}>
              <div>CNPJ</div>
              <div>Razão Social</div>
              <div>Cidade/UF</div>
              <div>Status</div>
              <div>Ações</div>
            </div>

            {emitentesFiltrados.map((emitente) => (
              <div key={emitente.id} className={styles.tableRow}>
                <div>{emitente.cnpj || emitente.cpf || 'Não informado'}</div>
                <div>
                  <strong>{emitente.razaoSocial}</strong>
                  {emitente.nomeFantasia && (
                    <div className={styles.subtext}>{emitente.nomeFantasia}</div>
                  )}
                </div>
                <div>{emitente.municipio}/{emitente.uf}</div>
                <div>
                  <span className={`${styles.status} ${emitente.ativo ? styles.ativo : styles.inativo}`}>
                    {emitente.ativo ? 'Ativo' : 'Inativo'}
                  </span>
                </div>
                <div className={styles.actions}>
                  <button
                    className={styles.btnEdit}
                    onClick={() => abrirModalEdicao(emitente)}
                  >
                    Editar
                  </button>
                  <button
                    className={styles.btnDelete}
                    onClick={() => emitente.id && excluirEmitente(emitente.id)}
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