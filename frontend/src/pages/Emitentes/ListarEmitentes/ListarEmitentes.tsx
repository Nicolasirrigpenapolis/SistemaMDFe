import React, { useState, useEffect } from 'react';
import { ConfirmDeleteModal } from '../../../components/UI/Modal/ConfirmDeleteModal';
import { useCNPJLookup } from '../../../hooks/useCNPJLookup';
import { formatCNPJ, formatCPF, cleanNumericString, applyMask } from '../../../utils/formatters';
import { entitiesService } from '../../../services/entitiesService';
import { SmartCNPJInput } from '../../../components/UI/Forms/SmartCNPJInput';
import Icon from '../../../components/UI/Icon';

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
  caminhoSalvarXml?: string;
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

    // Mapear tanto camelCase quanto PascalCase do backend
    const dadosParaModal = {
      ...emitente,
      cnpj: emitente.cnpj || (emitente as any).Cnpj || '',
      ie: emitente.ie || (emitente as any).Ie || '',
      uf: emitente.uf || (emitente as any).Uf || '',
      razaoSocial: emitente.razaoSocial || (emitente as any).RazaoSocial || '',
      nomeFantasia: emitente.nomeFantasia || (emitente as any).NomeFantasia || '',
      endereco: emitente.endereco || (emitente as any).Endereco || '',
      numero: emitente.numero || (emitente as any).Numero || '',
      complemento: emitente.complemento || (emitente as any).Complemento || '',
      bairro: emitente.bairro || (emitente as any).Bairro || '',
      codMunicipio: emitente.codMunicipio || (emitente as any).CodMunicipio || 0,
      municipio: emitente.municipio || (emitente as any).Municipio || '',
      cep: emitente.cep || (emitente as any).Cep || '',
      tipoEmitente: emitente.tipoEmitente || (emitente as any).TipoEmitente || 'PrestadorServico',
      caminhoArquivoCertificado: emitente.caminhoArquivoCertificado || (emitente as any).CaminhoArquivoCertificado || '',
      rntrc: emitente.rntrc || (emitente as any).Rntrc || '',
      ambienteSefaz: emitente.ambienteSefaz || (emitente as any).AmbienteSefaz || 2,
      senhaCertificado: ''
    };

    setDadosModal(dadosParaModal);
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
          razaoSocial: dadosCNPJ.razaoSocial,
          nomeFantasia: dadosCNPJ.nomeFantasia || '',
          endereco: dadosCNPJ.logradouro,
          numero: dadosCNPJ.numero,
          complemento: dadosCNPJ.complemento || '',
          bairro: dadosCNPJ.bairro,
          codMunicipio: dadosCNPJ.codigoMunicipio || 0,
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


  const limparFiltros = () => {
    setFiltro('');
    setFiltroTipo('');
    setFiltroStatus('');
    setFiltroUf('');
  };

  const renderModal = () => {
    if (!modalAberto) return null;

    return (
      <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
        <div className="bg-bg-surface rounded-xl border border-border-primary shadow-xl max-w-4xl w-full max-h-[90vh] overflow-y-auto">
          <div className="flex items-center justify-between p-6 border-b border-border-primary">
            <h2>{emitenteEdicao ? 'Editar Emitente' : 'Novo Emitente'}</h2>
            <button className="text-text-tertiary hover:text-text-primary transition-colors duration-200 text-2xl" onClick={fecharModal}>×</button>
          </div>

          <form id="emitente-form" onSubmit={salvarEmitente} className="p-6 space-y-6">
            <div className="space-y-4">
              <h3>Dados Principais</h3>

              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <label>CNPJ</label>
                  <SmartCNPJInput
                    value={dadosModal.cnpj || ''}
                    onChange={(cnpj, isValid) => setDadosModal({ ...dadosModal, cnpj })}
                    onDataFetch={(data) => {
                      setDadosModal(prev => ({
                        ...prev,
                        cnpj: formatCNPJ(data.cnpj),
                        razaoSocial: data.razaoSocial,
                        nomeFantasia: data.nomeFantasia || '',
                        endereco: data.logradouro,
                        numero: data.numero,
                        complemento: data.complemento || '',
                        bairro: data.bairro,
                        codMunicipio: data.codigoMunicipio || 0,
                        municipio: data.municipio,
                        cep: data.cep,
                        uf: data.uf
                      }));
                    }}
                    autoValidate={true}
                    autoFetch={true}
                    className="w-full px-3 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary focus:outline-none focus:ring-2 focus:ring-primary"
                  />
                </div>

                <div>
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

              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <label>Razão Social *</label>
                  <input
                    type="text"
                    value={dadosModal.razaoSocial}
                    onChange={(e) => setDadosModal({ ...dadosModal, razaoSocial: e.target.value })}
                    maxLength={200}
                    required
                  />
                </div>

                <div>
                  <label>Nome Fantasia</label>
                  <input
                    type="text"
                    value={dadosModal.nomeFantasia || ''}
                    onChange={(e) => setDadosModal({ ...dadosModal, nomeFantasia: e.target.value })}
                    maxLength={200}
                  />
                </div>
              </div>

              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <label>Inscrição Estadual</label>
                  <input
                    type="text"
                    value={dadosModal.ie || ''}
                    onChange={(e) => setDadosModal({ ...dadosModal, ie: e.target.value })}
                    maxLength={20}
                  />
                </div>

                <div>
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

            <div className="space-y-4">
              <h3>Endereço</h3>

              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <label>Logradouro *</label>
                  <input
                    type="text"
                    value={dadosModal.endereco}
                    onChange={(e) => setDadosModal({ ...dadosModal, endereco: e.target.value })}
                    maxLength={200}
                    required
                  />
                </div>

                <div>
                  <label>Número</label>
                  <input
                    type="text"
                    value={dadosModal.numero || ''}
                    onChange={(e) => setDadosModal({ ...dadosModal, numero: e.target.value })}
                    maxLength={20}
                  />
                </div>
              </div>

              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <label>Bairro *</label>
                  <input
                    type="text"
                    value={dadosModal.bairro}
                    onChange={(e) => setDadosModal({ ...dadosModal, bairro: e.target.value })}
                    maxLength={100}
                    required
                  />
                </div>

                <div>
                  <label>Complemento</label>
                  <input
                    type="text"
                    value={dadosModal.complemento || ''}
                    onChange={(e) => setDadosModal({ ...dadosModal, complemento: e.target.value })}
                    maxLength={100}
                  />
                </div>
              </div>

              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <label>Município *</label>
                  <input
                    type="text"
                    value={dadosModal.municipio}
                    onChange={(e) => setDadosModal({ ...dadosModal, municipio: e.target.value })}
                    maxLength={100}
                    required
                  />
                </div>

                <div>
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

                <div>
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

            <div className="space-y-4">
              <h3>Configurações</h3>

              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <label>RNTRC</label>
                  <input
                    type="text"
                    value={dadosModal.rntrc || ''}
                    onChange={(e) => setDadosModal({ ...dadosModal, rntrc: e.target.value })}
                    placeholder="Registro Nacional dos Transportadores"
                    maxLength={20}
                  />
                </div>

                <div>
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

              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <label>Caminho do Certificado</label>
                  <div className="flex gap-2">
                    <input
                      type="text"
                      value={dadosModal.caminhoArquivoCertificado || ''}
                      onChange={(e) => setDadosModal({ ...dadosModal, caminhoArquivoCertificado: e.target.value })}
                      placeholder="C:\certificados\certificado.pfx"
                      maxLength={500}
                    />
                    <button
                      type="button"
                      className="px-3 py-2 bg-primary hover:bg-primary-hover text-white rounded-lg text-sm"
                      onClick={() => {
                        const input = document.createElement('input');
                        input.type = 'file';
                        input.accept = '.pfx,.p12';
                        input.onchange = (e) => {
                          const file = (e.target as HTMLInputElement).files?.[0];
                          if (file) {
                            const path = file.webkitRelativePath || file.name;
                            setDadosModal({ ...dadosModal, caminhoArquivoCertificado: path });
                          }
                        };
                        input.click();
                      }}
                    >
                      Buscar
                    </button>
                  </div>
                </div>

                <div>
                  <label>Senha do Certificado</label>
                  <input
                    type="password"
                    value={dadosModal.senhaCertificado || ''}
                    onChange={(e) => setDadosModal({ ...dadosModal, senhaCertificado: e.target.value })}
                    placeholder={emitenteEdicao?.caminhoArquivoCertificado ? "Deixe vazio para manter" : "Senha do certificado"}
                  />
                </div>
              </div>

              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <label>Pasta para Salvar XMLs</label>
                  <div className="flex gap-2">
                    <input
                      type="text"
                      value={dadosModal.caminhoSalvarXml || ''}
                      onChange={(e) => setDadosModal({ ...dadosModal, caminhoSalvarXml: e.target.value })}
                      placeholder="C:\MDFes\XMLs"
                      maxLength={500}
                    />
                    <button
                      type="button"
                      className="px-3 py-2 bg-primary hover:bg-primary-hover text-white rounded-lg text-sm"
                      onClick={async () => {
                        try {
                          // API moderna do navegador para seleção de diretório
                          if ('showDirectoryPicker' in window) {
                            const dirHandle = await (window as any).showDirectoryPicker();
                            setDadosModal({ ...dadosModal, caminhoSalvarXml: dirHandle.name });
                          } else {
                            // Fallback para navegadores que não suportam
                            const path = prompt('Digite o caminho da pasta:', dadosModal.caminhoSalvarXml || 'C:\\MDFe_XMLs\\');
                            if (path) {
                              setDadosModal({ ...dadosModal, caminhoSalvarXml: path });
                            }
                          }
                        } catch (error) {
                          // Usuário cancelou ou erro
                        }
                      }}
                    >
                      Buscar Pasta
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </form>

          <div className="flex items-center justify-end gap-4 p-6 border-t border-border-primary">
            <button type="button" onClick={fecharModal} className="px-4 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary hover:bg-bg-tertiary transition-colors duration-200">
              Cancelar
            </button>
            <button type="submit" form="emitente-form" className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary-hover transition-colors duration-200 disabled:opacity-50 disabled:cursor-not-allowed">
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
      <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
        <div className="bg-bg-surface rounded-xl border border-border-primary shadow-xl max-w-4xl w-full max-h-[90vh] overflow-y-auto">
          <div className="flex items-center justify-between p-6 border-b border-border-primary">
            <h2>Visualizar Emitente</h2>
            <button className="text-text-tertiary hover:text-text-primary transition-colors duration-200 text-2xl" onClick={fecharModalVisualizacao}>×</button>
          </div>

          <div className="p-6">
            <div className="space-y-4">
              <h3>Dados Principais</h3>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                {emitenteVisualizacao.cnpj && (
                  <div className="space-y-1">
                    <label className="text-sm font-medium text-text-secondary">CNPJ:</label>
                    <span className="text-text-primary">{formatCNPJ(emitenteVisualizacao.cnpj)}</span>
                  </div>
                )}
                {emitenteVisualizacao.cpf && (
                  <div className="space-y-1">
                    <label className="text-sm font-medium text-text-secondary">CPF:</label>
                    <span className="text-text-primary">{formatCPF(emitenteVisualizacao.cpf)}</span>
                  </div>
                )}
                <div className="space-y-1">
                  <label className="text-sm font-medium text-text-secondary">Razão Social:</label>
                  <span className="text-text-primary">{emitenteVisualizacao.razaoSocial}</span>
                </div>
                {emitenteVisualizacao.nomeFantasia && (
                  <div className="space-y-1">
                    <label>Nome Fantasia:</label>
                    <span>{emitenteVisualizacao.nomeFantasia}</span>
                  </div>
                )}
                {emitenteVisualizacao.ie && (
                  <div className="space-y-1">
                    <label>Inscrição Estadual:</label>
                    <span>{emitenteVisualizacao.ie}</span>
                  </div>
                )}
                <div className="space-y-1">
                  <label>Tipo de Emitente:</label>
                  <span>{emitenteVisualizacao.tipoEmitente === 'PrestadorServico' ? 'Prestador de Serviço' : 'Entrega Própria'}</span>
                </div>
              </div>
            </div>

            <div className="space-y-4">
              <h3>Endereço</h3>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div className="space-y-1">
                  <label>Logradouro:</label>
                  <span>{emitenteVisualizacao.endereco}</span>
                </div>
                {emitenteVisualizacao.numero && (
                  <div className="space-y-1">
                    <label>Número:</label>
                    <span>{emitenteVisualizacao.numero}</span>
                  </div>
                )}
                <div className="space-y-1">
                  <label>Bairro:</label>
                  <span>{emitenteVisualizacao.bairro}</span>
                </div>
                {emitenteVisualizacao.complemento && (
                  <div className="space-y-1">
                    <label>Complemento:</label>
                    <span>{emitenteVisualizacao.complemento}</span>
                  </div>
                )}
                <div className="space-y-1">
                  <label>Município:</label>
                  <span>{emitenteVisualizacao.municipio}</span>
                </div>
                <div className="space-y-1">
                  <label>CEP:</label>
                  <span>{applyMask(emitenteVisualizacao.cep, 'cep')}</span>
                </div>
                <div className="space-y-1">
                  <label>UF:</label>
                  <span>{emitenteVisualizacao.uf}</span>
                </div>
              </div>
            </div>

            {(emitenteVisualizacao.rntrc || emitenteVisualizacao.caminhoArquivoCertificado) && (
              <div className="space-y-4">
                <h3>Configurações</h3>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  {emitenteVisualizacao.rntrc && (
                    <div className="space-y-1">
                      <label>RNTRC:</label>
                      <span>{emitenteVisualizacao.rntrc}</span>
                    </div>
                  )}
                  <div className="space-y-1">
                    <label>Ambiente SEFAZ:</label>
                    <span>{emitenteVisualizacao.ambienteSefaz === 1 ? 'Produção' : 'Homologação'}</span>
                  </div>
                  {emitenteVisualizacao.caminhoArquivoCertificado && (
                    <div className="space-y-1">
                      <label>Certificado:</label>
                      <span>{emitenteVisualizacao.caminhoArquivoCertificado}</span>
                    </div>
                  )}
                  <div className="space-y-1">
                    <label>Status:</label>
                    <span className={`inline-block px-2 py-1 rounded-full text-xs font-medium ${emitenteVisualizacao.ativo ? 'bg-green-100 text-green-800 dark:bg-green-900 dark:text-green-300' : 'bg-red-100 text-red-800 dark:bg-red-900 dark:text-red-300'}`}>
                      {emitenteVisualizacao.ativo ? 'Ativo' : 'Inativo'}
                    </span>
                  </div>
                </div>
              </div>
            )}
          </div>

          <div className="flex items-center justify-end gap-4 p-6 border-t border-border-primary">
            <button onClick={fecharModalVisualizacao} className="px-4 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary hover:bg-bg-tertiary transition-colors duration-200">
              Fechar
            </button>
            <button
              onClick={() => {
                fecharModalVisualizacao();
                abrirModalEdicao(emitenteVisualizacao);
              }}
              className="p-2 text-amber-600 hover:bg-amber-50 rounded-lg transition-colors duration-200"
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
      <div className="max-w-7xl mx-auto px-6 py-8">
        <div className="flex items-center justify-center py-16">
          <div className="flex items-center gap-4">
            <div className="w-8 h-8 border-4 border-primary border-t-transparent rounded-full animate-spin"></div>
            <span className="text-text-secondary">Carregando emitentes...</span>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="max-w-7xl mx-auto px-6 py-8">
      <div className="flex items-center justify-between mb-8">
        <h1>
          <i className="fas fa-building"></i>
          Emitentes
        </h1>
        <button className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary-hover transition-colors duration-200 flex items-center gap-2" onClick={abrirModalNovo}>
          Novo Emitente
        </button>
      </div>

      <div className="bg-bg-surface rounded-xl border border-border-primary p-6 mb-6">
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
          <div className="space-y-2">
            <label>Buscar</label>
            <input
              type="text"
              placeholder="Razão social ou CNPJ..."
              value={filtro}
              onChange={(e) => {
                setFiltro(e.target.value);
              }}
              className="w-full px-3 py-2 border border-border-primary rounded-lg bg-bg-surface focus:outline-none focus:ring-2 focus:ring-primary/20"
            />
          </div>

          <div className="space-y-2">
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

          <div className="space-y-2">
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

          <div className="space-y-2">
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
            className="px-4 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary hover:bg-bg-surface-hover transition-colors duration-200"
          >
            Limpar Filtros
          </button>
        </div>
      </div>

      <div className="bg-bg-surface rounded-xl border border-border-primary shadow-sm">
        {emitentes.length === 0 ? (
          <div className="flex flex-col items-center justify-center py-16 px-6">
            <div className="w-16 h-16 bg-bg-tertiary rounded-full flex items-center justify-center mb-4">
              <i className="fas fa-building text-2xl text-text-tertiary"></i>
            </div>
            <h3 className="text-lg font-semibold text-text-primary mb-2">Nenhum emitente encontrado</h3>
            <p className="text-text-secondary text-center">Adicione um novo emitente para começar.</p>
          </div>
        ) : (
          <div className="overflow-x-auto">
            <div className="grid grid-cols-6 gap-4 p-4 bg-bg-tertiary border-b border-border-primary font-semibold text-text-primary">
              <div>Documento</div>
              <div>Empresa</div>
              <div>Tipo</div>
              <div>Localização</div>
              <div>Status</div>
              <div>Ações</div>
            </div>

            {emitentes.map((emitente) => (
              <div key={emitente.id} className="grid grid-cols-6 gap-4 p-4 border-b border-border-primary hover:bg-bg-tertiary transition-colors duration-200">
                <div>
                  <strong>
                    {emitente.cnpj ? formatCNPJ(emitente.cnpj) :
                     emitente.cpf ? formatCPF(emitente.cpf) :
                     'Não informado'}
                  </strong>
                </div>
                <div>
                  <strong className="text-text-primary">{emitente.razaoSocial}</strong>
                  {emitente.nomeFantasia && (
                    <div className="text-sm text-text-secondary">{emitente.nomeFantasia}</div>
                  )}
                </div>
                <div>
                  <span className="px-2 py-1 bg-blue-100 text-blue-800 dark:bg-blue-900 dark:text-blue-300 rounded text-xs font-medium">
                    {emitente.tipoEmitente === 'PrestadorServico' ? 'Prestador' : 'Entrega Própria'}
                  </span>
                </div>
                <div>
                  <strong className="text-text-primary">{emitente.municipio}/{emitente.uf}</strong>
                </div>
                <div>
                  <span className={`px-2 py-1 rounded-full text-xs font-medium ${
                    emitente.ativo
                      ? 'bg-green-100 text-green-800 dark:bg-green-900 dark:text-green-300'
                      : 'bg-red-100 text-red-800 dark:bg-red-900 dark:text-red-300'
                  }`}>
                    {emitente.ativo ? 'Ativo' : 'Inativo'}
                  </span>
                </div>
                <div className="flex items-center gap-2">
                  <button
                    className="p-2 text-blue-600 hover:bg-blue-50 rounded-lg transition-colors duration-200"
                    onClick={() => abrirModalVisualizacao(emitente)}
                  >
                    Visualizar
                  </button>
                  <button
                    className="p-2 text-amber-600 hover:bg-amber-50 rounded-lg transition-colors duration-200"
                    onClick={() => abrirModalEdicao(emitente)}
                  >
                    Editar
                  </button>
                  <button
                    className="p-2 text-red-600 hover:bg-red-50 rounded-lg transition-colors duration-200"
                    onClick={() => abrirModalExclusao(emitente)}
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
        <div className="mt-6 bg-bg-surface border-t border-border-primary p-4">
          <div className="flex flex-col sm:flex-row justify-between items-center gap-4">
            <div className="text-sm text-text-secondary">
              Mostrando {((paginacao.currentPage - 1) * paginacao.pageSize) + 1} até {Math.min(paginacao.currentPage * paginacao.pageSize, paginacao.totalItems)} de {paginacao.totalItems} emitentes
            </div>

            {paginacao.totalPages > 1 && (
              <div className="flex items-center gap-2">
                <button
                  onClick={() => setPaginaAtual(paginacao.currentPage - 1)}
                  disabled={!paginacao.hasPreviousPage}
                  className="px-4 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary hover:bg-bg-surface-hover disabled:opacity-50 disabled:cursor-not-allowed transition-colors duration-200"
                >
                  ← Anterior
                </button>

                <span className="px-4 py-2 text-text-primary">
                  Página {paginacao.currentPage} de {paginacao.totalPages}
                </span>

                <button
                  onClick={() => setPaginaAtual(paginacao.currentPage + 1)}
                  disabled={!paginacao.hasNextPage}
                  className="px-4 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary hover:bg-bg-surface-hover disabled:opacity-50 disabled:cursor-not-allowed transition-colors duration-200"
                >
                  Próxima →
                </button>
              </div>
            )}

            <div className="flex items-center gap-2">
              <label className="text-sm text-text-primary">Itens por página:</label>
              <select
                value={tamanhoPagina}
                onChange={(e) => {
                  setTamanhoPagina(Number(e.target.value));
                  setPaginaAtual(1);
                }}
                className="px-3 py-1 border border-border-primary rounded bg-bg-surface text-text-primary focus:outline-none focus:ring-2 focus:ring-primary"
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