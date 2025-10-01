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

  // Estado simples para controlar se estamos em modo de edição
  const [modoEdicao, setModoEdicao] = useState(false);

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
    ambienteSefaz: 2,
    ativo: true
  });

  useEffect(() => {
    carregarEmitentes(paginaAtual, filtro, filtroTipo, filtroStatus, filtroUf);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [paginaAtual, tamanhoPagina]);

  // Carregamento inicial sem filtros
  useEffect(() => {
    carregarEmitentes(1, '', '', '', '');
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  // Filtragem em tempo real
  useEffect(() => {
    const timeoutId = setTimeout(() => {
      setPaginaAtual(1);
      carregarEmitentes(1, filtro, filtroTipo, filtroStatus, filtroUf);
    }, 300); // Debounce de 300ms para evitar muitas requisições

    return () => clearTimeout(timeoutId);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [filtro, filtroTipo, filtroStatus, filtroUf]);

  const carregarEmitentes = async (
    pagina: number = paginaAtual,
    busca: string = filtro,
    tipo: string = filtroTipo,
    status: string = filtroStatus,
    uf: string = filtroUf
  ) => {
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

      if (tipo) {
        params.append('TipoEmitente', tipo);
      }

      if (status) {
        params.append('Status', status === 'ativo' ? 'true' : 'false');
      }

      if (uf) {
        params.append('Uf', uf);
      }

      // Log para debug das filtragens
      console.log('Parâmetros de filtro:', {
        pagina,
        busca: busca.trim(),
        tipo,
        status,
        uf,
        url: `${API_BASE_URL}/emitentes?${params}`
      });

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
      ambienteSefaz: 2,
      ativo: true
    });
    setModalAberto(true);
  };

  const abrirModalEdicao = (emitente: Emitente) => {
    setEmitenteEdicao(emitente);

    // Mapear tanto camelCase quanto PascalCase do backend
    const cnpjRaw = emitente.cnpj || (emitente as any).Cnpj || '';

    // Ativar modo de edição
    setModoEdicao(true);
    const dadosParaModal = {
      ...emitente,
      cnpj: cnpjRaw ? formatCNPJ(cnpjRaw) : '',
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
    // Resetar modo de edição
    setModoEdicao(false);
  };

  const fecharModalVisualizacao = () => {
    setModalVisualizacao(false);
    setEmitenteVisualizacao(null);
  };

  // Função simplificada para mudanças no CNPJ
  const handleCnpjChange = (cnpj: string, isValid: boolean) => {
    setDadosModal({ ...dadosModal, cnpj });
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
    setPaginaAtual(1);
    // Recarregar sem filtros
    setTimeout(() => carregarEmitentes(1, '', '', '', ''), 0);
  };

  const renderModal = () => {
    if (!modalAberto) return null;

    return (
      <div className="fixed inset-0 bg-black/60 backdrop-blur-sm flex items-center justify-center z-50 p-2 sm:p-4">
        <div className="bg-white dark:bg-gray-900 rounded-xl sm:rounded-2xl shadow-2xl w-full max-w-6xl h-[98vh] sm:h-[95vh] flex flex-col">

          {/* Header com gradiente moderno */}
          <div className="bg-gradient-to-r from-blue-600 via-blue-700 to-indigo-700 dark:from-blue-700 dark:via-blue-800 dark:to-indigo-800 px-4 sm:px-6 lg:px-8 py-4 sm:py-6">
            <div className="flex items-center justify-between">
              <div className="flex items-center gap-2 sm:gap-4 min-w-0 flex-1">
                <div className="w-10 h-10 sm:w-12 sm:h-12 lg:w-14 lg:h-14 bg-white/15 backdrop-blur-sm rounded-xl flex items-center justify-center shadow-lg flex-shrink-0">
                  <i className="fas fa-building text-white text-lg sm:text-xl lg:text-2xl"></i>
                </div>
                <div className="min-w-0 flex-1">
                  <h2 className="text-lg sm:text-xl lg:text-2xl font-bold text-white mb-1 truncate">
                    {emitenteEdicao ? 'Editar Emitente' : 'Novo Emitente'}
                  </h2>
                  <p className="text-blue-100 text-xs sm:text-sm hidden sm:block">
                    {emitenteEdicao ? 'Atualize as informações do emitente' : 'Cadastre uma nova empresa emissora de MDF-e'}
                  </p>
                </div>
              </div>
              <button
                className="w-8 h-8 sm:w-10 sm:h-10 bg-white/10 hover:bg-white/20 rounded-xl flex items-center justify-center transition-all duration-200 group backdrop-blur-sm flex-shrink-0 ml-2"
                onClick={fecharModal}
              >
                <i className="fas fa-times text-white text-sm sm:text-lg group-hover:scale-110 transition-transform"></i>
              </button>
            </div>
          </div>

          {/* Conteúdo do formulário */}
          <div className="flex-1 overflow-y-auto">
            <form id="emitente-form" onSubmit={salvarEmitente} className="p-4 sm:p-6 lg:p-8">

              {/* SEÇÃO 1: IDENTIFICAÇÃO */}
              <div className="mb-8">
                <div className="flex items-center gap-3 mb-6">
                  <div className="w-10 h-10 bg-gradient-to-br from-blue-500 to-blue-600 rounded-xl flex items-center justify-center shadow-lg">
                    <i className="fas fa-id-card text-white"></i>
                  </div>
                  <div>
                    <h3 className="text-xl font-bold text-gray-900 dark:text-white">Identificação</h3>
                    <p className="text-gray-600 dark:text-gray-400 text-sm">Dados principais da empresa</p>
                  </div>
                </div>

                <div className="bg-gradient-to-br from-gray-50 to-gray-100 dark:from-gray-800 dark:to-gray-850 rounded-xl p-4 sm:p-6 border border-gray-200 dark:border-0">
                  <div className="grid grid-cols-1 sm:grid-cols-2 gap-4 sm:gap-6">

                    {/* CNPJ */}
                    <div className="space-y-2">
                      <label className="flex items-center gap-2 text-sm font-semibold text-gray-700 dark:text-gray-300">
                        <i className="fas fa-building text-blue-500 text-xs"></i>
                        CNPJ <span className="text-red-500">*</span>
                      </label>
                      <SmartCNPJInput
                        value={dadosModal.cnpj || ''}
                        onChange={handleCnpjChange}
                        onDataFetch={!modoEdicao ? (data) => {
                          setDadosModal(prev => ({
                            ...prev,
                            // Atualizar apenas campos que vêm da consulta de CNPJ
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
                            uf: data.uf,
                            // PRESERVAR campos que NÃO vêm da consulta de CNPJ
                            id: prev.id,
                            cpf: prev.cpf,
                            ie: prev.ie,
                            rntrc: prev.rntrc,
                            tipoEmitente: prev.tipoEmitente,
                            ambienteSefaz: prev.ambienteSefaz,
                            ativo: prev.ativo,
                            caminhoArquivoCertificado: prev.caminhoArquivoCertificado,
                            senhaCertificado: prev.senhaCertificado
                          }));
                        } : undefined}
                        autoValidate={true}
                        autoFetch={!modoEdicao}
                        className="w-full px-4 py-3 border border-gray-300 dark:border-0 rounded-xl bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200 shadow-sm hover:shadow-md"
                        placeholder="00.000.000/0000-00"
                      />
                    </div>

                    {/* CPF */}
                    <div className="space-y-2">
                      <label className="flex items-center gap-2 text-sm font-semibold text-gray-700 dark:text-gray-300">
                        <i className="fas fa-user text-green-500 text-xs"></i>
                        CPF (Pessoa Física)
                      </label>
                      <input
                        type="text"
                        value={dadosModal.cpf ? applyMask(dadosModal.cpf, 'cpf') : ''}
                        onChange={(e) => setDadosModal({ ...dadosModal, cpf: cleanNumericString(e.target.value) })}
                        placeholder="000.000.000-00"
                        maxLength={14}
                        className="w-full px-4 py-3 border border-gray-300 dark:border-0 rounded-xl bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent transition-all duration-200 shadow-sm hover:shadow-md"
                      />
                    </div>

                    {/* Razão Social */}
                    <div className="space-y-2">
                      <label className="flex items-center gap-2 text-sm font-semibold text-gray-700 dark:text-gray-300">
                        <i className="fas fa-file-signature text-purple-500 text-xs"></i>
                        Razão Social <span className="text-red-500">*</span>
                      </label>
                      <input
                        type="text"
                        value={dadosModal.razaoSocial}
                        onChange={(e) => setDadosModal({ ...dadosModal, razaoSocial: e.target.value })}
                        maxLength={200}
                        required
                        className="w-full px-4 py-3 border border-gray-300 dark:border-0 rounded-xl bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all duration-200 shadow-sm hover:shadow-md"
                        placeholder="Nome completo da empresa"
                      />
                    </div>

                    {/* Nome Fantasia */}
                    <div className="space-y-2">
                      <label className="flex items-center gap-2 text-sm font-semibold text-gray-700 dark:text-gray-300">
                        <i className="fas fa-store text-amber-500 text-xs"></i>
                        Nome Fantasia
                      </label>
                      <input
                        type="text"
                        value={dadosModal.nomeFantasia || ''}
                        onChange={(e) => setDadosModal({ ...dadosModal, nomeFantasia: e.target.value })}
                        maxLength={200}
                        className="w-full px-4 py-3 border border-gray-300 dark:border-0 rounded-xl bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-amber-500 focus:border-transparent transition-all duration-200 shadow-sm hover:shadow-md"
                        placeholder="Nome comercial (opcional)"
                      />
                    </div>

                    {/* IE */}
                    <div className="space-y-2">
                      <label className="flex items-center gap-2 text-sm font-semibold text-gray-700 dark:text-gray-300">
                        <i className="fas fa-certificate text-indigo-500 text-xs"></i>
                        Inscrição Estadual
                      </label>
                      <input
                        type="text"
                        value={dadosModal.ie || ''}
                        onChange={(e) => setDadosModal({ ...dadosModal, ie: e.target.value })}
                        maxLength={20}
                        className="w-full px-4 py-3 border border-gray-300 dark:border-0 rounded-xl bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-transparent transition-all duration-200 shadow-sm hover:shadow-md"
                        placeholder="Número da Inscrição Estadual"
                      />
                    </div>

                    {/* Tipo de Emitente */}
                    <div className="space-y-2">
                      <label className="flex items-center gap-2 text-sm font-semibold text-gray-700 dark:text-gray-300">
                        <i className="fas fa-tags text-emerald-500 text-xs"></i>
                        Tipo de Emitente <span className="text-red-500">*</span>
                      </label>
                      <select
                        value={dadosModal.tipoEmitente}
                        onChange={(e) => setDadosModal({ ...dadosModal, tipoEmitente: e.target.value })}
                        required
                        className="w-full px-4 py-3 border border-gray-300 dark:border-0 rounded-xl bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:border-transparent transition-all duration-200 shadow-sm hover:shadow-md"
                      >
                        <option value="PrestadorServico">Prestador de Serviço</option>
                        <option value="EntregaPropria">Entrega Própria</option>
                      </select>
                    </div>
                  </div>
                </div>
              </div>

              {/* SEÇÃO 2: ENDEREÇO */}
              <div className="mb-8">
                <div className="flex items-center gap-3 mb-6">
                  <div className="w-10 h-10 bg-gradient-to-br from-emerald-500 to-emerald-600 rounded-xl flex items-center justify-center shadow-lg">
                    <i className="fas fa-map-marker-alt text-white"></i>
                  </div>
                  <div>
                    <h3 className="text-xl font-bold text-gray-900 dark:text-white">Endereço</h3>
                    <p className="text-gray-600 dark:text-gray-400 text-sm">Localização da empresa</p>
                  </div>
                </div>

                <div className="bg-gradient-to-br from-emerald-50 to-emerald-100 dark:from-emerald-900/20 dark:to-emerald-800/20 rounded-xl p-4 sm:p-6 border border-emerald-200 dark:border-emerald-700/50">
                  <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4 sm:gap-6">

                    {/* Logradouro */}
                    <div className="sm:col-span-2 lg:col-span-2 space-y-2">
                      <label className="flex items-center gap-2 text-sm font-semibold text-gray-700 dark:text-gray-300">
                        <i className="fas fa-road text-emerald-600 text-xs"></i>
                        Logradouro <span className="text-red-500">*</span>
                      </label>
                      <input
                        type="text"
                        value={dadosModal.endereco}
                        onChange={(e) => setDadosModal({ ...dadosModal, endereco: e.target.value })}
                        maxLength={200}
                        required
                        className="w-full px-4 py-3 border border-gray-300 dark:border-0 rounded-xl bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:border-transparent transition-all duration-200 shadow-sm hover:shadow-md"
                        placeholder="Rua, Avenida, etc."
                      />
                    </div>

                    {/* Número */}
                    <div className="space-y-2">
                      <label className="flex items-center gap-2 text-sm font-semibold text-gray-700 dark:text-gray-300">
                        <i className="fas fa-hashtag text-emerald-600 text-xs"></i>
                        Número
                      </label>
                      <input
                        type="text"
                        value={dadosModal.numero || ''}
                        onChange={(e) => setDadosModal({ ...dadosModal, numero: e.target.value })}
                        maxLength={20}
                        className="w-full px-4 py-3 border border-gray-300 dark:border-0 rounded-xl bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:border-transparent transition-all duration-200 shadow-sm hover:shadow-md"
                        placeholder="123"
                      />
                    </div>

                    {/* Bairro */}
                    <div className="space-y-2">
                      <label className="flex items-center gap-2 text-sm font-semibold text-gray-700 dark:text-gray-300">
                        <i className="fas fa-home text-emerald-600 text-xs"></i>
                        Bairro <span className="text-red-500">*</span>
                      </label>
                      <input
                        type="text"
                        value={dadosModal.bairro}
                        onChange={(e) => setDadosModal({ ...dadosModal, bairro: e.target.value })}
                        maxLength={100}
                        required
                        className="w-full px-4 py-3 border border-gray-300 dark:border-0 rounded-xl bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:border-transparent transition-all duration-200 shadow-sm hover:shadow-md"
                        placeholder="Nome do bairro"
                      />
                    </div>

                    {/* Complemento */}
                    <div className="space-y-2">
                      <label className="flex items-center gap-2 text-sm font-semibold text-gray-700 dark:text-gray-300">
                        <i className="fas fa-plus text-emerald-600 text-xs"></i>
                        Complemento
                      </label>
                      <input
                        type="text"
                        value={dadosModal.complemento || ''}
                        onChange={(e) => setDadosModal({ ...dadosModal, complemento: e.target.value })}
                        maxLength={100}
                        className="w-full px-4 py-3 border border-gray-300 dark:border-0 rounded-xl bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:border-transparent transition-all duration-200 shadow-sm hover:shadow-md"
                        placeholder="Apt, Sala, Bloco, etc."
                      />
                    </div>

                    {/* Município */}
                    <div className="space-y-2">
                      <label className="flex items-center gap-2 text-sm font-semibold text-gray-700 dark:text-gray-300">
                        <i className="fas fa-city text-emerald-600 text-xs"></i>
                        Município <span className="text-red-500">*</span>
                      </label>
                      <input
                        type="text"
                        value={dadosModal.municipio}
                        onChange={(e) => setDadosModal({ ...dadosModal, municipio: e.target.value })}
                        maxLength={100}
                        required
                        className="w-full px-4 py-3 border border-gray-300 dark:border-0 rounded-xl bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:border-transparent transition-all duration-200 shadow-sm hover:shadow-md"
                        placeholder="Nome da cidade"
                      />
                    </div>

                    {/* CEP */}
                    <div className="space-y-2">
                      <label className="flex items-center gap-2 text-sm font-semibold text-gray-700 dark:text-gray-300">
                        <i className="fas fa-mail-bulk text-emerald-600 text-xs"></i>
                        CEP <span className="text-red-500">*</span>
                      </label>
                      <input
                        type="text"
                        value={dadosModal.cep ? applyMask(dadosModal.cep, 'cep') : ''}
                        onChange={(e) => setDadosModal({ ...dadosModal, cep: cleanNumericString(e.target.value) })}
                        required
                        placeholder="00000-000"
                        maxLength={9}
                        className="w-full px-4 py-3 border border-gray-300 dark:border-0 rounded-xl bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:border-transparent transition-all duration-200 shadow-sm hover:shadow-md"
                      />
                    </div>

                    {/* UF */}
                    <div className="space-y-2">
                      <label className="flex items-center gap-2 text-sm font-semibold text-gray-700 dark:text-gray-300">
                        <i className="fas fa-map text-emerald-600 text-xs"></i>
                        UF <span className="text-red-500">*</span>
                      </label>
                      <select
                        value={dadosModal.uf}
                        onChange={(e) => setDadosModal({ ...dadosModal, uf: e.target.value })}
                        required
                        className="w-full px-4 py-3 border border-gray-300 dark:border-0 rounded-xl bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-emerald-500 focus:border-transparent transition-all duration-200 shadow-sm hover:shadow-md"
                      >
                        <option value="">Selecione</option>
                        <option value="AC">Acre</option>
                        <option value="AL">Alagoas</option>
                        <option value="AP">Amapá</option>
                        <option value="AM">Amazonas</option>
                        <option value="BA">Bahia</option>
                        <option value="CE">Ceará</option>
                        <option value="DF">Distrito Federal</option>
                        <option value="ES">Espírito Santo</option>
                        <option value="GO">Goiás</option>
                        <option value="MA">Maranhão</option>
                        <option value="MT">Mato Grosso</option>
                        <option value="MS">Mato Grosso do Sul</option>
                        <option value="MG">Minas Gerais</option>
                        <option value="PA">Pará</option>
                        <option value="PB">Paraíba</option>
                        <option value="PR">Paraná</option>
                        <option value="PE">Pernambuco</option>
                        <option value="PI">Piauí</option>
                        <option value="RJ">Rio de Janeiro</option>
                        <option value="RN">Rio Grande do Norte</option>
                        <option value="RS">Rio Grande do Sul</option>
                        <option value="RO">Rondônia</option>
                        <option value="RR">Roraima</option>
                        <option value="SC">Santa Catarina</option>
                        <option value="SP">São Paulo</option>
                        <option value="SE">Sergipe</option>
                        <option value="TO">Tocantins</option>
                      </select>
                    </div>
                  </div>
                </div>
              </div>

              {/* SEÇÃO 3: CONFIGURAÇÕES */}
              <div className="mb-8">
                <div className="flex items-center gap-3 mb-6">
                  <div className="w-10 h-10 bg-gradient-to-br from-violet-500 to-violet-600 rounded-xl flex items-center justify-center shadow-lg">
                    <i className="fas fa-cog text-white"></i>
                  </div>
                  <div>
                    <h3 className="text-xl font-bold text-gray-900 dark:text-white">Configurações</h3>
                    <p className="text-gray-600 dark:text-gray-400 text-sm">Certificados e configurações técnicas</p>
                  </div>
                </div>

                <div className="bg-gradient-to-br from-violet-50 to-violet-100 dark:from-violet-900/20 dark:to-violet-800/20 rounded-xl p-4 sm:p-6 border border-violet-200 dark:border-violet-700/50">
                  <div className="grid grid-cols-1 sm:grid-cols-2 gap-4 sm:gap-6">

                    {/* RNTRC */}
                    <div className="space-y-2">
                      <label className="flex items-center gap-2 text-sm font-semibold text-gray-700 dark:text-gray-300">
                        <i className="fas fa-truck text-violet-600 text-xs"></i>
                        RNTRC
                      </label>
                      <input
                        type="text"
                        value={dadosModal.rntrc || ''}
                        onChange={(e) => setDadosModal({ ...dadosModal, rntrc: e.target.value })}
                        placeholder="Registro Nacional dos Transportadores"
                        maxLength={20}
                        className="w-full px-4 py-3 border border-gray-300 dark:border-0 rounded-xl bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-violet-500 focus:border-transparent transition-all duration-200 shadow-sm hover:shadow-md"
                      />
                    </div>

                    {/* Ambiente SEFAZ */}
                    <div className="space-y-2">
                      <label className="flex items-center gap-2 text-sm font-semibold text-gray-700 dark:text-gray-300">
                        <i className="fas fa-server text-violet-600 text-xs"></i>
                        Ambiente SEFAZ
                      </label>
                      <select
                        value={dadosModal.ambienteSefaz || 2}
                        onChange={(e) => setDadosModal({ ...dadosModal, ambienteSefaz: parseInt(e.target.value) })}
                        className="w-full px-4 py-3 border border-gray-300 dark:border-0 rounded-xl bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-violet-500 focus:border-transparent transition-all duration-200 shadow-sm hover:shadow-md"
                      >
                        <option value={1}>Produção</option>
                        <option value={2}>Homologação (Teste)</option>
                      </select>
                    </div>

                    {/* Status - Apenas no modo de edição */}
                    {modoEdicao && (
                      <div className="space-y-2">
                        <label className="flex items-center gap-2 text-sm font-semibold text-gray-700 dark:text-gray-300">
                          <i className="fas fa-toggle-on text-violet-600 text-xs"></i>
                          Status
                        </label>
                        <select
                          value={dadosModal.ativo === true ? 'ativo' : 'inativo'}
                          onChange={(e) => setDadosModal({ ...dadosModal, ativo: e.target.value === 'ativo' })}
                          className="w-full px-4 py-3 border border-gray-300 dark:border-0 rounded-xl bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-violet-500 focus:border-transparent transition-all duration-200 shadow-sm hover:shadow-md"
                        >
                          <option value="ativo">Ativo</option>
                          <option value="inativo">Inativo</option>
                        </select>
                      </div>
                    )}

                    {/* Certificado */}
                    <div className="space-y-2">
                      <label className="flex items-center gap-2 text-sm font-semibold text-gray-700 dark:text-gray-300">
                        <i className="fas fa-certificate text-violet-600 text-xs"></i>
                        Certificado Digital
                      </label>
                      <div className="flex gap-3">
                        <input
                          type="text"
                          value={dadosModal.caminhoArquivoCertificado || ''}
                          onChange={(e) => setDadosModal({ ...dadosModal, caminhoArquivoCertificado: e.target.value })}
                          placeholder="Selecione o arquivo .pfx ou .p12"
                          className="flex-1 px-4 py-3 border border-gray-300 dark:border-0 rounded-xl bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-violet-500 focus:border-transparent transition-all duration-200 shadow-sm hover:shadow-md"
                        />
                        <button
                          type="button"
                          className="px-4 py-3 bg-violet-600 hover:bg-violet-700 text-white rounded-xl font-medium transition-all duration-200 shadow-sm hover:shadow-md flex items-center gap-2"
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
                          <i className="fas fa-folder-open"></i>
                          Buscar
                        </button>
                      </div>
                    </div>

                    {/* Senha do Certificado */}
                    <div className="space-y-2">
                      <label className="flex items-center gap-2 text-sm font-semibold text-gray-700 dark:text-gray-300">
                        <i className="fas fa-key text-violet-600 text-xs"></i>
                        Senha do Certificado
                      </label>
                      <input
                        type="password"
                        value={dadosModal.senhaCertificado || ''}
                        onChange={(e) => setDadosModal({ ...dadosModal, senhaCertificado: e.target.value })}
                        placeholder={emitenteEdicao?.caminhoArquivoCertificado ? "••••••••" : "Senha do certificado"}
                        className="w-full px-4 py-3 border border-gray-300 dark:border-0 rounded-xl bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-violet-500 focus:border-transparent transition-all duration-200 shadow-sm hover:shadow-md"
                      />
                    </div>

                    {/* Pasta XMLs */}
                    <div className="sm:col-span-2 space-y-2">
                      <label className="flex items-center gap-2 text-sm font-semibold text-gray-700 dark:text-gray-300">
                        <i className="fas fa-folder text-violet-600 text-xs"></i>
                        Pasta para Salvar XMLs
                      </label>
                      <div className="flex gap-3">
                        <input
                          type="text"
                          value={dadosModal.caminhoSalvarXml || ''}
                          onChange={(e) => setDadosModal({ ...dadosModal, caminhoSalvarXml: e.target.value })}
                          placeholder="Selecione onde salvar os XMLs gerados"
                          className="flex-1 px-4 py-3 border border-gray-300 dark:border-0 rounded-xl bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-violet-500 focus:border-transparent transition-all duration-200 shadow-sm hover:shadow-md"
                        />
                        <button
                          type="button"
                          className="px-4 py-3 bg-violet-600 hover:bg-violet-700 text-white rounded-xl font-medium transition-all duration-200 shadow-sm hover:shadow-md flex items-center gap-2"
                          onClick={async () => {
                            try {
                              if ('showDirectoryPicker' in window) {
                                const dirHandle = await (window as any).showDirectoryPicker();
                                setDadosModal({ ...dadosModal, caminhoSalvarXml: dirHandle.name });
                              } else {
                                const path = prompt('Digite o caminho da pasta:', dadosModal.caminhoSalvarXml || 'C:\\MDFe_XMLs\\');
                                if (path) {
                                  setDadosModal({ ...dadosModal, caminhoSalvarXml: path });
                                }
                              }
                            } catch (error) {
                              // Usuário cancelou
                            }
                          }}
                        >
                          <i className="fas fa-folder-open"></i>
                          Buscar
                        </button>
                      </div>
                    </div>
                  </div>
                </div>
              </div>

            </form>
          </div>

          {/* Footer com botões */}
          <div className="flex-shrink-0 bg-gray-50 dark:bg-gray-800 border-t border-gray-200 dark:border-0 px-4 sm:px-6 lg:px-8 py-4 sm:py-6">
            <div className="flex flex-col-reverse sm:flex-row items-center justify-between gap-4">
              <p className="text-xs sm:text-sm text-gray-500 dark:text-gray-400 text-center sm:text-left">
                * Campos obrigatórios
              </p>
              <div className="flex flex-col sm:flex-row items-center gap-3 w-full sm:w-auto">
                <button
                  type="submit"
                  form="emitente-form"
                  className="w-full sm:w-auto order-2 sm:order-2 px-6 sm:px-8 py-3 bg-gradient-to-r from-blue-600 to-indigo-600 hover:from-blue-700 hover:to-indigo-700 text-white rounded-xl font-semibold transition-all duration-200 shadow-lg hover:shadow-xl flex items-center justify-center gap-2"
                >
                  <i className={`fas ${emitenteEdicao ? 'fa-save' : 'fa-plus'}`}></i>
                  <span className="hidden sm:inline">
                    {emitenteEdicao ? 'Atualizar Emitente' : 'Cadastrar Emitente'}
                  </span>
                  <span className="sm:hidden">
                    {emitenteEdicao ? 'Atualizar' : 'Cadastrar'}
                  </span>
                </button>
                <button
                  type="button"
                  onClick={fecharModal}
                  className="w-full sm:w-auto order-1 sm:order-1 px-4 sm:px-6 py-3 border border-gray-300 dark:border-0 rounded-xl bg-white dark:bg-gray-700 text-gray-700 dark:text-gray-300 font-medium hover:bg-gray-50 dark:hover:bg-gray-600 transition-all duration-200 shadow-sm hover:shadow-md"
                >
                  Cancelar
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    );
  };

  const renderModalVisualizacao = () => {
    if (!modalVisualizacao || !emitenteVisualizacao) {
      return null;
    }

    return (
      <div className="fixed inset-0 bg-black/60 backdrop-blur-sm flex items-center justify-center z-50 p-2 sm:p-4">
        <div className="bg-white dark:bg-gray-900 rounded-xl sm:rounded-2xl shadow-2xl w-full max-w-5xl h-[98vh] sm:h-[90vh] flex flex-col">

          {/* Header com gradiente moderno */}
          <div className="bg-gradient-to-r from-emerald-600 via-emerald-700 to-teal-700 dark:from-emerald-700 dark:via-emerald-800 dark:to-teal-800 px-4 sm:px-6 lg:px-8 py-4 sm:py-6">
            <div className="flex items-center justify-between">
              <div className="flex items-center gap-2 sm:gap-4 min-w-0 flex-1">
                <div className="w-10 h-10 sm:w-12 sm:h-12 lg:w-14 lg:h-14 bg-white/15 backdrop-blur-sm rounded-xl flex items-center justify-center shadow-lg flex-shrink-0">
                  <i className="fas fa-eye text-white text-lg sm:text-xl lg:text-2xl"></i>
                </div>
                <div className="min-w-0 flex-1">
                  <h2 className="text-lg sm:text-xl lg:text-2xl font-bold text-white mb-1 truncate">
                    Visualizar Emitente
                  </h2>
                  <p className="text-emerald-100 text-xs sm:text-sm hidden sm:block">
                    Detalhes completos do emitente
                  </p>
                </div>
              </div>
              <button
                className="w-8 h-8 sm:w-10 sm:h-10 bg-white/10 hover:bg-white/20 rounded-xl flex items-center justify-center transition-all duration-200 group backdrop-blur-sm flex-shrink-0 ml-2"
                onClick={fecharModalVisualizacao}
              >
                <i className="fas fa-times text-white text-sm sm:text-lg group-hover:scale-110 transition-transform"></i>
              </button>
            </div>
          </div>

          {/* Conteúdo scrollável */}
          <div className="flex-1 overflow-y-auto">
            <div className="p-4 sm:p-6 lg:p-8">

              {/* SEÇÃO 1: IDENTIFICAÇÃO */}
              <div className="mb-8">
                <div className="flex items-center gap-3 mb-6">
                  <div className="w-10 h-10 bg-gradient-to-br from-blue-500 to-blue-600 rounded-xl flex items-center justify-center shadow-lg">
                    <i className="fas fa-id-card text-white"></i>
                  </div>
                  <div>
                    <h3 className="text-xl font-bold text-gray-900 dark:text-white">Identificação</h3>
                    <p className="text-gray-600 dark:text-gray-400 text-sm">Dados principais da empresa</p>
                  </div>
                </div>

                <div className="bg-gradient-to-br from-gray-50 to-gray-100 dark:from-gray-800 dark:to-gray-850 rounded-xl p-4 sm:p-6 border border-gray-200 dark:border-0">
                  <div className="grid grid-cols-1 sm:grid-cols-2 gap-4 sm:gap-6">

                    {emitenteVisualizacao.cnpj && (
                      <div className="space-y-2">
                        <label className="flex items-center gap-2 text-sm font-semibold text-gray-700 dark:text-gray-300">
                          <i className="fas fa-building text-blue-500 text-xs"></i>
                          CNPJ
                        </label>
                        <div className="px-4 py-3 bg-white dark:bg-gray-800 rounded-xl border border-gray-200 dark:border-0">
                          <span className="font-medium text-gray-900 dark:text-white">{formatCNPJ(emitenteVisualizacao.cnpj)}</span>
                        </div>
                      </div>
                    )}

                    {emitenteVisualizacao.cpf && (
                      <div className="space-y-2">
                        <label className="flex items-center gap-2 text-sm font-semibold text-gray-700 dark:text-gray-300">
                          <i className="fas fa-user text-green-500 text-xs"></i>
                          CPF
                        </label>
                        <div className="px-4 py-3 bg-white dark:bg-gray-800 rounded-xl border border-gray-200 dark:border-0">
                          <span className="font-medium text-gray-900 dark:text-white">{formatCPF(emitenteVisualizacao.cpf)}</span>
                        </div>
                      </div>
                    )}

                    <div className="space-y-2">
                      <label className="flex items-center gap-2 text-sm font-semibold text-gray-700 dark:text-gray-300">
                        <i className="fas fa-file-signature text-purple-500 text-xs"></i>
                        Razão Social
                      </label>
                      <div className="px-4 py-3 bg-white dark:bg-gray-800 rounded-xl border border-gray-200 dark:border-0">
                        <span className="font-medium text-gray-900 dark:text-white">{emitenteVisualizacao.razaoSocial}</span>
                      </div>
                    </div>

                    {emitenteVisualizacao.nomeFantasia && (
                      <div className="space-y-2">
                        <label className="flex items-center gap-2 text-sm font-semibold text-gray-700 dark:text-gray-300">
                          <i className="fas fa-store text-amber-500 text-xs"></i>
                          Nome Fantasia
                        </label>
                        <div className="px-4 py-3 bg-white dark:bg-gray-800 rounded-xl border border-gray-200 dark:border-0">
                          <span className="font-medium text-gray-900 dark:text-white">{emitenteVisualizacao.nomeFantasia}</span>
                        </div>
                      </div>
                    )}

                    {emitenteVisualizacao.ie && (
                      <div className="space-y-2">
                        <label className="flex items-center gap-2 text-sm font-semibold text-gray-700 dark:text-gray-300">
                          <i className="fas fa-certificate text-indigo-500 text-xs"></i>
                          Inscrição Estadual
                        </label>
                        <div className="px-4 py-3 bg-white dark:bg-gray-800 rounded-xl border border-gray-200 dark:border-0">
                          <span className="font-medium text-gray-900 dark:text-white">{emitenteVisualizacao.ie}</span>
                        </div>
                      </div>
                    )}

                    <div className="space-y-2">
                      <label className="flex items-center gap-2 text-sm font-semibold text-gray-700 dark:text-gray-300">
                        <i className="fas fa-tags text-emerald-500 text-xs"></i>
                        Tipo de Emitente
                      </label>
                      <div className="px-4 py-3 bg-white dark:bg-gray-800 rounded-xl border border-gray-200 dark:border-0">
                        <span className={`font-semibold ${
                          emitenteVisualizacao.tipoEmitente === 'PrestadorServico'
                            ? 'text-blue-600 dark:text-blue-400'
                            : 'text-green-600 dark:text-green-400'
                        }`}>
                          {emitenteVisualizacao.tipoEmitente === 'PrestadorServico' ? 'Prestador de Serviço' : 'Entrega Própria'}
                        </span>
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              {/* SEÇÃO 2: ENDEREÇO */}
              <div className="mb-8">
                <div className="flex items-center gap-3 mb-6">
                  <div className="w-10 h-10 bg-gradient-to-br from-emerald-500 to-emerald-600 rounded-xl flex items-center justify-center shadow-lg">
                    <i className="fas fa-map-marker-alt text-white"></i>
                  </div>
                  <div>
                    <h3 className="text-xl font-bold text-gray-900 dark:text-white">Endereço</h3>
                    <p className="text-gray-600 dark:text-gray-400 text-sm">Localização da empresa</p>
                  </div>
                </div>

                <div className="bg-gradient-to-br from-emerald-50 to-emerald-100 dark:from-emerald-900/20 dark:to-emerald-800/20 rounded-xl p-4 sm:p-6 border border-emerald-200 dark:border-emerald-700/50">
                  <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4 sm:gap-6">

                    <div className="sm:col-span-2 lg:col-span-2 space-y-2">
                      <label className="flex items-center gap-2 text-sm font-semibold text-gray-700 dark:text-gray-300">
                        <i className="fas fa-road text-emerald-600 text-xs"></i>
                        Logradouro
                      </label>
                      <div className="px-4 py-3 bg-white dark:bg-gray-800 rounded-xl border border-gray-200 dark:border-0">
                        <span className="font-medium text-gray-900 dark:text-white">{emitenteVisualizacao.endereco}</span>
                      </div>
                    </div>

                    {emitenteVisualizacao.numero && (
                      <div className="space-y-2">
                        <label className="flex items-center gap-2 text-sm font-semibold text-gray-700 dark:text-gray-300">
                          <i className="fas fa-hashtag text-emerald-600 text-xs"></i>
                          Número
                        </label>
                        <div className="px-4 py-3 bg-white dark:bg-gray-800 rounded-xl border border-gray-200 dark:border-0">
                          <span className="font-medium text-gray-900 dark:text-white">{emitenteVisualizacao.numero}</span>
                        </div>
                      </div>
                    )}

                    <div className="space-y-2">
                      <label className="flex items-center gap-2 text-sm font-semibold text-gray-700 dark:text-gray-300">
                        <i className="fas fa-home text-emerald-600 text-xs"></i>
                        Bairro
                      </label>
                      <div className="px-4 py-3 bg-white dark:bg-gray-800 rounded-xl border border-gray-200 dark:border-0">
                        <span className="font-medium text-gray-900 dark:text-white">{emitenteVisualizacao.bairro}</span>
                      </div>
                    </div>

                    {emitenteVisualizacao.complemento && (
                      <div className="space-y-2">
                        <label className="flex items-center gap-2 text-sm font-semibold text-gray-700 dark:text-gray-300">
                          <i className="fas fa-plus text-emerald-600 text-xs"></i>
                          Complemento
                        </label>
                        <div className="px-4 py-3 bg-white dark:bg-gray-800 rounded-xl border border-gray-200 dark:border-0">
                          <span className="font-medium text-gray-900 dark:text-white">{emitenteVisualizacao.complemento}</span>
                        </div>
                      </div>
                    )}

                    <div className="space-y-2">
                      <label className="flex items-center gap-2 text-sm font-semibold text-gray-700 dark:text-gray-300">
                        <i className="fas fa-city text-emerald-600 text-xs"></i>
                        Município
                      </label>
                      <div className="px-4 py-3 bg-white dark:bg-gray-800 rounded-xl border border-gray-200 dark:border-0">
                        <span className="font-medium text-gray-900 dark:text-white">{emitenteVisualizacao.municipio}</span>
                      </div>
                    </div>

                    <div className="space-y-2">
                      <label className="flex items-center gap-2 text-sm font-semibold text-gray-700 dark:text-gray-300">
                        <i className="fas fa-mail-bulk text-emerald-600 text-xs"></i>
                        CEP
                      </label>
                      <div className="px-4 py-3 bg-white dark:bg-gray-800 rounded-xl border border-gray-200 dark:border-0">
                        <span className="font-medium text-gray-900 dark:text-white">
                          {emitenteVisualizacao.cep ? applyMask(emitenteVisualizacao.cep, 'cep') : 'Não informado'}
                        </span>
                      </div>
                    </div>

                    <div className="space-y-2">
                      <label className="flex items-center gap-2 text-sm font-semibold text-gray-700 dark:text-gray-300">
                        <i className="fas fa-map text-emerald-600 text-xs"></i>
                        UF
                      </label>
                      <div className="px-4 py-3 bg-white dark:bg-gray-800 rounded-xl border border-gray-200 dark:border-0">
                        <span className="font-medium text-gray-900 dark:text-white">{emitenteVisualizacao.uf}</span>
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              {/* SEÇÃO 3: CONFIGURAÇÕES */}
              {(emitenteVisualizacao.rntrc || emitenteVisualizacao.caminhoArquivoCertificado || emitenteVisualizacao.ambienteSefaz) && (
                <div className="mb-8">
                  <div className="flex items-center gap-3 mb-6">
                    <div className="w-10 h-10 bg-gradient-to-br from-violet-500 to-violet-600 rounded-xl flex items-center justify-center shadow-lg">
                      <i className="fas fa-cog text-white"></i>
                    </div>
                    <div>
                      <h3 className="text-xl font-bold text-gray-900 dark:text-white">Configurações</h3>
                      <p className="text-gray-600 dark:text-gray-400 text-sm">Certificados e configurações técnicas</p>
                    </div>
                  </div>

                  <div className="bg-gradient-to-br from-violet-50 to-violet-100 dark:from-violet-900/20 dark:to-violet-800/20 rounded-xl p-4 sm:p-6 border border-violet-200 dark:border-violet-700/50">
                    <div className="grid grid-cols-1 sm:grid-cols-2 gap-4 sm:gap-6">

                      {emitenteVisualizacao.rntrc && (
                        <div className="space-y-2">
                          <label className="flex items-center gap-2 text-sm font-semibold text-gray-700 dark:text-gray-300">
                            <i className="fas fa-truck text-violet-600 text-xs"></i>
                            RNTRC
                          </label>
                          <div className="px-4 py-3 bg-white dark:bg-gray-800 rounded-xl border border-gray-200 dark:border-0">
                            <span className="font-medium text-gray-900 dark:text-white">{emitenteVisualizacao.rntrc}</span>
                          </div>
                        </div>
                      )}

                      <div className="space-y-2">
                        <label className="flex items-center gap-2 text-sm font-semibold text-gray-700 dark:text-gray-300">
                          <i className="fas fa-server text-violet-600 text-xs"></i>
                          Ambiente SEFAZ
                        </label>
                        <div className="px-4 py-3 bg-white dark:bg-gray-800 rounded-xl border border-gray-200 dark:border-0">
                          <span className="font-medium text-gray-900 dark:text-white">
                            {emitenteVisualizacao.ambienteSefaz === 1 ? 'Produção' : 'Homologação'}
                          </span>
                        </div>
                      </div>

                      {emitenteVisualizacao.caminhoArquivoCertificado && (
                        <div className="space-y-2">
                          <label className="flex items-center gap-2 text-sm font-semibold text-gray-700 dark:text-gray-300">
                            <i className="fas fa-certificate text-violet-600 text-xs"></i>
                            Certificado Digital
                          </label>
                          <div className="px-4 py-3 bg-white dark:bg-gray-800 rounded-xl border border-gray-200 dark:border-0">
                            <span className="font-medium text-gray-900 dark:text-white text-sm">{emitenteVisualizacao.caminhoArquivoCertificado}</span>
                          </div>
                        </div>
                      )}

                      <div className="space-y-2">
                        <label className="flex items-center gap-2 text-sm font-semibold text-gray-700 dark:text-gray-300">
                          <i className="fas fa-circle text-violet-600 text-xs"></i>
                          Status
                        </label>
                        <div className="px-4 py-3 bg-white dark:bg-gray-800 rounded-xl border border-gray-200 dark:border-0">
                          <span className={`font-semibold ${emitenteVisualizacao.ativo ? 'text-green-600 dark:text-green-400' : 'text-red-600 dark:text-red-400'}`}>
                            {emitenteVisualizacao.ativo ? 'Ativo' : 'Inativo'}
                          </span>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              )}

            </div>
          </div>

          {/* Footer com botões */}
          <div className="flex-shrink-0 bg-gray-50 dark:bg-gray-800 border-t border-gray-200 dark:border-0 px-4 sm:px-6 lg:px-8 py-4 sm:py-6">
            <div className="flex flex-col-reverse sm:flex-row items-center justify-between gap-4">
              <p className="text-xs sm:text-sm text-gray-500 dark:text-gray-400 text-center sm:text-left">
                Informações do emitente
              </p>
              <div className="flex flex-col sm:flex-row items-center gap-3 w-full sm:w-auto">
                <button
                  onClick={() => {
                    fecharModalVisualizacao();
                    abrirModalEdicao(emitenteVisualizacao);
                  }}
                  className="w-full sm:w-auto order-2 sm:order-2 px-6 sm:px-8 py-3 bg-gradient-to-r from-amber-600 to-orange-600 hover:from-amber-700 hover:to-orange-700 text-white rounded-xl font-semibold transition-all duration-200 shadow-lg hover:shadow-xl flex items-center justify-center gap-2"
                >
                  <i className="fas fa-edit"></i>
                  <span className="hidden sm:inline">Editar Emitente</span>
                  <span className="sm:hidden">Editar</span>
                </button>
                <button
                  onClick={fecharModalVisualizacao}
                  className="w-full sm:w-auto order-1 sm:order-1 px-4 sm:px-6 py-3 border border-gray-300 dark:border-0 rounded-xl bg-white dark:bg-gray-700 text-gray-700 dark:text-gray-300 font-medium hover:bg-gray-50 dark:hover:bg-gray-600 transition-all duration-200 shadow-sm hover:shadow-md"
                >
                  Fechar
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    );
  };

  if (carregando) {
    return (
      <div className="min-h-screen bg-gray-50 dark:bg-gray-900">
        <div className="w-full px-6 py-8">
          <div className="flex items-center justify-center py-16">
            <div className="flex items-center gap-4">
              <div className="w-8 h-8 border-4 border-blue-600 border-t-transparent rounded-full animate-spin"></div>
              <span className="text-gray-600 dark:text-gray-400">Carregando emitentes...</span>
            </div>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gray-50 dark:bg-gray-900">
      <div className="w-full px-1 sm:px-2 py-2 sm:py-4">
        <div className="flex items-center justify-between mb-3 sm:mb-4">
          <div className="flex items-center gap-4">
            <div className="w-14 h-14 bg-gradient-to-br from-blue-600 to-indigo-600 rounded-xl flex items-center justify-center shadow-lg">
              <i className="fas fa-building text-white text-xl"></i>
            </div>
            <div>
              <h1 className="text-3xl font-bold text-gray-900 dark:text-white mb-1">Emitentes</h1>
              <p className="text-gray-600 dark:text-gray-400 text-lg">Gerencie as empresas emissoras de MDF-e</p>
            </div>
          </div>
          <button
            className="px-6 py-3 bg-gradient-to-r from-blue-600 to-indigo-600 hover:from-blue-700 hover:to-indigo-700 text-white rounded-xl font-semibold transition-all duration-200 flex items-center gap-3 shadow-lg hover:shadow-xl transform hover:scale-105"
            onClick={abrirModalNovo}
          >
            <i className="fas fa-plus text-lg"></i>
            <span>Novo Emitente</span>
          </button>
        </div>

        <div className="bg-white dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-0 p-4 sm:p-6 mb-4 sm:mb-6">
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-5 gap-4 items-end">
            <div>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Buscar</label>
              <input
                type="text"
                placeholder="Razão social ou CNPJ..."
                value={filtro}
                onChange={(e) => {
                  setFiltro(e.target.value);
                }}
                className="w-full px-3 py-2 border border-gray-300 dark:border-0 rounded-lg bg-white dark:bg-gray-800 text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-blue-500/20 focus:border-blue-500"
              />
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Tipo</label>
              <select
                value={filtroTipo}
                onChange={(e) => setFiltroTipo(e.target.value)}
                className="w-full px-3 py-2 border border-gray-300 dark:border-0 rounded-lg bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-blue-500/20 focus:border-blue-500"
              >
                <option value="">Todos os tipos</option>
                <option value="PrestadorServico">Prestador de Serviço</option>
                <option value="EntregaPropria">Entrega Própria</option>
              </select>
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">Status</label>
              <select
                value={filtroStatus}
                onChange={(e) => setFiltroStatus(e.target.value)}
                className="w-full px-3 py-2 border border-gray-300 dark:border-0 rounded-lg bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-blue-500/20 focus:border-blue-500"
              >
                <option value="">Todos os status</option>
                <option value="ativo">Ativo</option>
                <option value="inativo">Inativo</option>
              </select>
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">UF</label>
              <select
                value={filtroUf}
                onChange={(e) => setFiltroUf(e.target.value)}
                className="w-full px-3 py-2 border border-gray-300 dark:border-0 rounded-lg bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-blue-500/20 focus:border-blue-500"
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

            <div className="flex justify-center">
              <button
                onClick={limparFiltros}
                className="px-6 py-3 bg-red-50 hover:bg-red-100 dark:bg-red-900/20 dark:hover:bg-red-900/30 text-red-600 dark:text-red-400 hover:text-red-700 dark:hover:text-red-300 border border-red-200 dark:border-red-800 rounded-lg font-semibold transition-all duration-200 flex items-center gap-2 shadow-sm hover:shadow-md"
                disabled={!filtro && !filtroTipo && !filtroStatus && !filtroUf}
              >
                <i className="fas fa-times"></i>
                Limpar Filtros
              </button>
            </div>
          </div>
        </div>

        {/* Indicador de filtros ativos */}
        {(filtro || filtroTipo || filtroStatus || filtroUf) && (
          <div className="bg-blue-50 dark:bg-blue-900/20 border border-blue-200 dark:border-blue-800 rounded-lg p-3 mb-4">
            <div className="flex items-center gap-2">
              <i className="fas fa-filter text-blue-600 dark:text-blue-400"></i>
              <span className="text-sm font-medium text-blue-700 dark:text-blue-300">
                Filtros ativos:
                {filtro && <span className="ml-1 px-2 py-1 bg-blue-100 dark:bg-blue-800 rounded text-xs">{filtro}</span>}
                {filtroTipo && <span className="ml-1 px-2 py-1 bg-blue-100 dark:bg-blue-800 rounded text-xs">{filtroTipo === 'PrestadorServico' ? 'Prestador' : 'Entrega Própria'}</span>}
                {filtroStatus && <span className="ml-1 px-2 py-1 bg-blue-100 dark:bg-blue-800 rounded text-xs">{filtroStatus === 'ativo' ? 'Ativo' : 'Inativo'}</span>}
                {filtroUf && <span className="ml-1 px-2 py-1 bg-blue-100 dark:bg-blue-800 rounded text-xs">{filtroUf}</span>}
              </span>
            </div>
          </div>
        )}

        <div className="bg-white dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-0 shadow-sm">
          {emitentes.length === 0 ? (
            <div className="flex flex-col items-center justify-center py-16 px-6">
              <div className="w-16 h-16 bg-gray-100 dark:bg-gray-700 rounded-full flex items-center justify-center mb-4">
                <i className="fas fa-building text-2xl text-gray-400"></i>
              </div>
              <h3 className="text-lg font-semibold text-gray-900 dark:text-white mb-2">
                {(filtro || filtroTipo || filtroStatus || filtroUf) ? 'Nenhum emitente encontrado com os filtros aplicados' : 'Nenhum emitente encontrado'}
              </h3>
              <p className="text-gray-600 dark:text-gray-400 text-center">
                {(filtro || filtroTipo || filtroStatus || filtroUf) ? 'Tente ajustar os filtros ou limpar para ver todos os emitentes.' : 'Adicione um novo emitente para começar.'}
              </p>
            </div>
          ) : (
            <>
              {/* Tabela para desktop */}
              <div className="hidden lg:block overflow-x-auto">
                <div className="grid grid-cols-6 gap-4 p-4 bg-gray-50 dark:bg-gray-800 border-b border-gray-200 dark:border-0 font-semibold text-gray-900 dark:text-white">
                  <div className="text-center">Documento</div>
                  <div className="text-center">Empresa</div>
                  <div className="text-center">Tipo</div>
                  <div className="text-center">Localização</div>
                  <div className="text-center">Status</div>
                  <div className="text-center">Ações</div>
                </div>

                {emitentes.map((emitente) => (
                  <div key={emitente.id} className="grid grid-cols-6 gap-4 p-4 border-b border-gray-200 dark:border-0 hover:bg-gray-50 dark:hover:bg-gray-700 transition-colors duration-200">
                    <div className="text-center">
                      <div className="font-medium text-gray-900 dark:text-white">
                        {emitente.cnpj ? formatCNPJ(emitente.cnpj) :
                         emitente.cpf ? formatCPF(emitente.cpf) :
                         'Não informado'}
                      </div>
                      {emitente.ie && (
                        <div className="text-sm text-gray-500 dark:text-gray-400">IE: {emitente.ie}</div>
                      )}
                    </div>
                    <div className="text-center">
                      <div className="font-medium text-gray-900 dark:text-white">{emitente.razaoSocial}</div>
                      {emitente.nomeFantasia && (
                        <div className="text-sm text-gray-600 dark:text-gray-400">{emitente.nomeFantasia}</div>
                      )}
                    </div>
                    <div className="text-center flex justify-center">
                      <span className={`text-sm font-semibold ${
                        emitente.tipoEmitente === 'PrestadorServico'
                          ? 'text-blue-600 dark:text-blue-400'
                          : 'text-green-600 dark:text-green-400'
                      }`}>
                        {emitente.tipoEmitente === 'PrestadorServico' ? 'Prestador' : 'Entrega Própria'}
                      </span>
                    </div>
                    <div className="text-center">
                      <div className="font-medium text-gray-900 dark:text-white">
                        {emitente.municipio || 'Não informado'}/{emitente.uf}
                      </div>
                    </div>
                    <div className="text-center flex justify-center">
                      <span className={`text-sm font-semibold ${
                        emitente.ativo
                          ? 'text-green-600 dark:text-green-400'
                          : 'text-red-600 dark:text-red-400'
                      }`}>
                        {emitente.ativo ? 'Ativo' : 'Inativo'}
                      </span>
                    </div>
                    <div className="flex items-center justify-center gap-2">
                      <button
                        className="p-2 text-blue-600 dark:text-blue-400 hover:bg-blue-50 dark:hover:bg-blue-900/20 rounded-lg transition-colors duration-200"
                        onClick={() => abrirModalVisualizacao(emitente)}
                        title="Visualizar"
                      >
                        <i className="fas fa-eye"></i>
                      </button>
                      <button
                        className="p-2 text-amber-600 dark:text-amber-400 hover:bg-amber-50 dark:hover:bg-amber-900/20 rounded-lg transition-colors duration-200"
                        onClick={() => abrirModalEdicao(emitente)}
                        title="Editar"
                      >
                        <i className="fas fa-edit"></i>
                      </button>
                      <button
                        className="p-2 text-red-600 dark:text-red-400 hover:bg-red-50 dark:hover:bg-red-900/20 rounded-lg transition-colors duration-200"
                        onClick={() => abrirModalExclusao(emitente)}
                        title="Excluir"
                      >
                        <i className="fas fa-trash"></i>
                      </button>
                    </div>
                  </div>
                ))}
              </div>

              {/* Cards para mobile/tablet */}
              <div className="lg:hidden space-y-4 p-4">
                {emitentes.map((emitente) => (
                  <div key={emitente.id} className="bg-white dark:bg-gray-800 border border-gray-200 dark:border-0 rounded-xl p-4 shadow-sm hover:shadow-md transition-shadow duration-200">
                    <div className="flex items-start justify-between mb-3">
                      <div className="flex-1 min-w-0">
                        <div className="font-medium text-gray-900 dark:text-white text-lg mb-1 truncate">
                          {emitente.razaoSocial}
                        </div>
                        {emitente.nomeFantasia && (
                          <div className="text-sm text-gray-600 dark:text-gray-400 mb-2 truncate">
                            {emitente.nomeFantasia}
                          </div>
                        )}
                        <div className="text-sm font-medium text-gray-700 dark:text-gray-300">
                          {emitente.cnpj ? formatCNPJ(emitente.cnpj) :
                           emitente.cpf ? formatCPF(emitente.cpf) :
                           'Não informado'}
                        </div>
                      </div>

                      <div className="flex items-center gap-2 ml-4">
                        <span className={`text-sm font-semibold ${
                          emitente.ativo
                            ? 'text-green-600 dark:text-green-400'
                            : 'text-red-600 dark:text-red-400'
                        }`}>
                          {emitente.ativo ? 'Ativo' : 'Inativo'}
                        </span>
                      </div>
                    </div>

                    <div className="grid grid-cols-2 gap-4 text-sm mb-4">
                      <div>
                        <span className="text-gray-500 dark:text-gray-400 block">Tipo:</span>
                        <span className={`inline-block text-sm font-semibold mt-1 ${
                          emitente.tipoEmitente === 'PrestadorServico'
                            ? 'text-blue-600 dark:text-blue-400'
                            : 'text-green-600 dark:text-green-400'
                        }`}>
                          {emitente.tipoEmitente === 'PrestadorServico' ? 'Prestador' : 'Entrega Própria'}
                        </span>
                      </div>

                      <div>
                        <span className="text-gray-500 dark:text-gray-400 block">Localização:</span>
                        <span className="text-gray-900 dark:text-white font-medium">
                          {emitente.municipio || 'Não informado'}/{emitente.uf}
                        </span>
                      </div>
                    </div>

                    {emitente.ie && (
                      <div className="text-sm text-gray-500 dark:text-gray-400 mb-4">
                        IE: {emitente.ie}
                      </div>
                    )}

                    <div className="flex items-center justify-end gap-2 pt-3 border-t border-gray-100 dark:border-0">
                      <button
                        className="flex items-center gap-2 px-3 py-2 text-blue-600 dark:text-blue-400 hover:bg-blue-50 dark:hover:bg-blue-900/20 rounded-lg transition-colors duration-200 text-sm font-medium"
                        onClick={() => abrirModalVisualizacao(emitente)}
                      >
                        <i className="fas fa-eye"></i>
                        Ver
                      </button>
                      <button
                        className="flex items-center gap-2 px-3 py-2 text-amber-600 dark:text-amber-400 hover:bg-amber-50 dark:hover:bg-amber-900/20 rounded-lg transition-colors duration-200 text-sm font-medium"
                        onClick={() => abrirModalEdicao(emitente)}
                      >
                        <i className="fas fa-edit"></i>
                        Editar
                      </button>
                      <button
                        className="flex items-center gap-2 px-3 py-2 text-red-600 dark:text-red-400 hover:bg-red-50 dark:hover:bg-red-900/20 rounded-lg transition-colors duration-200 text-sm font-medium"
                        onClick={() => abrirModalExclusao(emitente)}
                      >
                        <i className="fas fa-trash"></i>
                        Excluir
                      </button>
                    </div>
                  </div>
                ))}
              </div>
            </>
          )}
        </div>

        {paginacao && paginacao.totalItems > 0 && (
          <div className="mt-6 bg-white dark:bg-gray-800 border-t border-gray-200 dark:border-0 p-4 rounded-b-lg lg:rounded-none">
            <div className="flex flex-col sm:flex-row justify-between items-center gap-4">
              <div className="text-xs sm:text-sm text-gray-600 dark:text-gray-400 text-center sm:text-left">
                {paginacao && paginacao.totalItems > 0 ? (
                  <>Mostrando {paginacao.startItem || ((paginacao.currentPage - 1) * paginacao.pageSize) + 1} até {paginacao.endItem || Math.min(paginacao.currentPage * paginacao.pageSize, paginacao.totalItems)} de {paginacao.totalItems} emitentes</>
                ) : (
                  <>Nenhum emitente encontrado</>
                )}
              </div>

              {paginacao.totalPages > 1 && (
                <div className="flex items-center gap-1 sm:gap-2">
                  <button
                    onClick={() => setPaginaAtual(paginacao.currentPage - 1)}
                    disabled={!paginacao.hasPreviousPage}
                    className="px-3 sm:px-4 py-2 border border-gray-300 dark:border-0 rounded-lg bg-white dark:bg-gray-800 text-gray-900 dark:text-white hover:bg-gray-50 dark:hover:bg-gray-700 disabled:opacity-50 disabled:cursor-not-allowed transition-colors duration-200 text-sm"
                  >
                    <span className="hidden sm:inline">Anterior</span>
                    <span className="sm:hidden">‹</span>
                  </button>

                  <span className="px-2 sm:px-4 py-2 text-gray-900 dark:text-white font-medium text-sm whitespace-nowrap">
                    {paginacao.currentPage} / {paginacao.totalPages}
                  </span>

                  <button
                    onClick={() => setPaginaAtual(paginacao.currentPage + 1)}
                    disabled={!paginacao.hasNextPage}
                    className="px-3 sm:px-4 py-2 border border-gray-300 dark:border-0 rounded-lg bg-white dark:bg-gray-800 text-gray-900 dark:text-white hover:bg-gray-50 dark:hover:bg-gray-700 disabled:opacity-50 disabled:cursor-not-allowed transition-colors duration-200 text-sm"
                  >
                    <span className="hidden sm:inline">Próxima</span>
                    <span className="sm:hidden">›</span>
                  </button>
                </div>
              )}

              <div className="flex items-center gap-2">
                <label className="text-sm text-gray-700 dark:text-gray-300">Itens por página:</label>
                <select
                  value={tamanhoPagina}
                  onChange={(e) => {
                    setTamanhoPagina(Number(e.target.value));
                    setPaginaAtual(1);
                  }}
                  className="px-3 py-1 border border-gray-300 dark:border-0 rounded bg-white dark:bg-gray-800 text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-blue-500/20 focus:border-blue-500"
                >
                  <option value={5}>5</option>
                  <option value={10}>10</option>
                  <option value={20}>20</option>
                  <option value={50}>50</option>
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
    </div>
  );
}