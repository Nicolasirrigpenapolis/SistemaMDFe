export type MDFeStep =
  | 'emitente-transporte'  // Emitente, Veículo, Motorista
  | 'origem-destino'       // Rota: origem, destino, percurso
  | 'documentos'           // Documentos fiscais transportados
  | 'carga-seguro'         // Informações da carga e seguro
  | 'emissao';             // Revisão final e emissão

// Documentos são tratados como arrays de strings (chaves) - interfaces removidas para simplicidade

// 🎯 INTERFACE SIMPLIFICADA - SÓ O ESSENCIAL
export interface MDFeData {
  // === IDENTIFICAÇÃO ===
  id?: string;
  numero?: string;
  serie?: string;

  // === ENTIDADES OBRIGATÓRIAS ===
  emitenteId?: number;
  veiculoId?: number;
  condutorId?: number;

  // === VIAGEM ===
  dataEmissao?: Date;
  dataInicioViagem?: Date;
  ufIni?: string;
  ufFim?: string;
  municipioIni?: string;
  municipioFim?: string;

  // === CARGA (VALORES TOTAIS CALCULADOS) ===
  pesoBrutoTotal?: number;
  valorTotal?: number;
  observacoes?: string;

  // === CONTRATAÇÃO (OPCIONAL) ===
  contratanteId?: number;
  seguradoraId?: number;

  // === DOCUMENTOS (ARRAYS SIMPLES DE CHAVES) ===
  documentosCTe?: string[];
  documentosNFe?: string[];
  reboquesIds?: number[];

  // === ROTA ===
  localidadesCarregamento?: Array<{
    uf: string;
    municipio: string;
    codigoIBGE: number;
  }>;
  localidadesDescarregamento?: Array<{
    uf: string;
    municipio: string;
    codigoIBGE: number;
  }>;
  rotaPercurso?: string[];

  // === STATUS (APENAS PARA EXIBIÇÃO) ===
  chaveAcesso?: string;
  protocolo?: string;
  statusSefaz?: string;
}

export interface MensagemFeedback {
  id?: string;
  tipo: 'sucesso' | 'erro' | 'info' | 'aviso';
  titulo: string;
  mensagem: string;
  horario?: Date;
  detalhes?: string;
}

export interface ValidacaoEtapa {
  ehValida: boolean;
  erros: string[];
  avisos: string[];
}

export interface RespostaACBr {
  sucesso: boolean;
  mensagem: string;
  dados?: any;
  codigoErro?: string;
  detalhesValidacao?: Record<string, string[]>;
}

export interface MDFeResponseDto {
  id: number;
  numero: number;
  chave: string;
  serie: string;
  dataEmissao: Date;
  dataInicioViagem: Date;
  ufIni: string;
  ufFim: string;
  municipioIni: string;
  municipioFim: string;
  pesoBrutoTotal?: number;
  valorTotal?: number;
  status: string;
  observacoes?: string;
  emitenteRazaoSocial: string;
  veiculoPlaca: string;
  condutorNome: string;
}

export interface PagedResult<T> {
  items: T[];
  totalItems: number;
  page: number;
  pageSize: number;
  totalPages: number;
  hasNextPage: boolean;
  hasPreviousPage: boolean;
}

export interface ReciboConciliacaoData {
  numeroRecibo: string;
}

// Interfaces para entidades cadastradas
export interface EmitenteCadastrado {
  id: number;
  cnpj?: string;
  cpf?: string;
  ie?: string;
  razaoSocial: string; // Mapeado do backend RazaoSocial
  nomeFantasia?: string; // Mapeado do backend NomeFantasia
  endereco?: string; // Mapeado do backend Endereco
  numero?: string; // Mapeado do backend Numero
  complemento?: string; // Mapeado do backend Complemento
  bairro?: string; // Mapeado do backend Bairro
  codigoMunicipio?: number; // Mapeado do backend CodMunicipio
  municipio?: string; // Mapeado do backend Municipio
  cep?: string; // Mapeado do backend Cep
  uf: string; // Mapeado do backend Uf
  telefone?: string; // Mapeado do backend Telefone
  email?: string; // Mapeado do backend Email
  ativo: boolean; // Mapeado do backend Ativo
  tipoEmitente: string; // Mapeado do backend TipoEmitente
  descricaoEmitente?: string; // Mapeado do backend DescricaoEmitente
  // caminhoArquivoCertificado removido - MonitorACBr gerencia
  rntrc?: string; // Mapeado do backend Rntrc
}

export interface VeiculoCadastrado {
  id: number;
  placa: string; // Mapeado do backend Placa
  tara: number; // Mapeado do backend Tara
  tipoRodado?: string; // Mapeado do backend TipoRodado
  tipoCarroceria?: string; // Mapeado do backend TipoCarroceria
  uf: string; // Mapeado do backend Uf
  ativo: boolean; // Mapeado do backend Ativo
}

// 🚀 NOVA ARQUITETURA SIMPLIFICADA
// Frontend envia APENAS dados essenciais
// Backend monta XML/INI completo internamente

// ❌ INTERFACES XML REMOVIDAS - COMPLEXIDADE DESNECESSÁRIA NO FRONTEND
// ✅ Backend será responsável por TODA lógica SEFAZ

// Interface para entidades disponíveis no combobox
export interface EntidadeOpcao {
  id: number;
  label: string;
  description?: string;
  data?: any; // Dados completos da entidade se disponível
}

export interface EntidadesCarregadas {
  emitentes?: EntidadeOpcao[];
  veiculos?: EntidadeOpcao[];
  condutores?: EntidadeOpcao[];
  contratantes?: EntidadeOpcao[];
  seguradoras?: EntidadeOpcao[];
}