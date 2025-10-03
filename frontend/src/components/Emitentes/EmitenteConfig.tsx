import { CRUDConfig } from '../../types/modal';
import { formatCNPJ, formatCPF, applyMask } from '../../utils/formatters';

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

export const emitenteConfig: CRUDConfig<Emitente> = {
  entity: {
    name: 'emitente',
    pluralName: 'emitentes',
    idField: 'id'
  },

  view: {
    title: 'Visualizar Emitente',
    subtitle: 'Detalhes completos do emitente',
    headerIcon: 'eye',
    headerColor: 'linear-gradient(to right, #2563eb, #4f46e5)',

    getSections: (emitente) => [
      {
        title: 'Identificação',
        subtitle: 'Dados principais da empresa',
        icon: 'id-card',
        color: '#2563eb',
        bgColor: '#dbeafe',
        fields: [
          {
            label: 'CNPJ',
            value: emitente.cnpj,
            icon: 'building',
            formatter: (value) => value ? formatCNPJ(value) : 'N/A',
            show: !!emitente.cnpj
          },
          {
            label: 'CPF',
            value: emitente.cpf,
            icon: 'user',
            formatter: (value) => value ? formatCPF(value) : 'N/A',
            show: !!emitente.cpf
          },
          {
            label: 'Razão Social',
            value: emitente.razaoSocial,
            icon: 'file-signature'
          },
          {
            label: 'Nome Fantasia',
            value: emitente.nomeFantasia,
            icon: 'store',
            show: !!emitente.nomeFantasia
          },
          {
            label: 'Inscrição Estadual',
            value: emitente.ie,
            icon: 'certificate',
            show: !!emitente.ie
          },
          {
            label: 'Tipo de Emitente',
            value: emitente.tipoEmitente === 'PrestadorServico' ? 'Prestador de Serviço' : 'Entrega Própria',
            icon: 'tags',
            type: 'badge'
          }
        ]
      },
      {
        title: 'Endereço',
        subtitle: 'Localização da empresa',
        icon: 'map-marker-alt',
        color: '#2563eb',
        bgColor: '#dcfce7',
        fields: [
          {
            label: 'Logradouro',
            value: emitente.endereco,
            icon: 'road',
            colSpan: 2
          },
          {
            label: 'Número',
            value: emitente.numero,
            icon: 'hashtag',
            show: !!emitente.numero
          },
          {
            label: 'Bairro',
            value: emitente.bairro,
            icon: 'home'
          },
          {
            label: 'Complemento',
            value: emitente.complemento,
            icon: 'plus',
            show: !!emitente.complemento
          },
          {
            label: 'Município',
            value: emitente.municipio,
            icon: 'city'
          },
          {
            label: 'CEP',
            value: emitente.cep,
            icon: 'mail-bulk',
            formatter: (value) => value ? applyMask(value, 'cep') : 'N/A'
          },
          {
            label: 'UF',
            value: emitente.uf,
            icon: 'map'
          }
        ]
      },
      {
        title: 'Configurações',
        subtitle: 'Certificados e configurações técnicas',
        icon: 'cog',
        color: '#2563eb',
        bgColor: '#ede9fe',
        fields: [
          {
            label: 'RNTRC',
            value: emitente.rntrc,
            icon: 'truck',
            show: !!emitente.rntrc
          },
          {
            label: 'Ambiente SEFAZ',
            value: emitente.ambienteSefaz === 1 ? 'Produção' : 'Homologação',
            icon: 'server'
          },
          {
            label: 'Certificado Digital',
            value: emitente.caminhoArquivoCertificado,
            icon: 'certificate',
            show: !!emitente.caminhoArquivoCertificado,
            colSpan: 2
          },
          {
            label: 'Senha do Certificado',
            value: emitente.senhaCertificado ? '••••••••' : 'Não configurada',
            icon: 'key',
            show: !!emitente.caminhoArquivoCertificado
          },
          {
            label: 'Pasta para Salvar XMLs',
            value: emitente.caminhoSalvarXml,
            icon: 'folder',
            show: !!emitente.caminhoSalvarXml,
            colSpan: 2
          },
          {
            label: 'Status',
            value: emitente.ativo ? 'Ativo' : 'Inativo',
            icon: 'circle',
            type: 'status'
          }
        ]
      }
    ],

    getStatusConfig: (emitente) => ({
      value: emitente.ativo ? 'Ativo' : 'Inativo',
      color: emitente.ativo ? '#059669' : '#dc2626',
      bgColor: emitente.ativo ? '#dcfce7' : '#fee2e2',
      textColor: emitente.ativo ? '#166534' : '#991b1b'
    }),

    idField: 'id'
  },

  form: {
    title: 'Novo Emitente',
    editTitle: 'Editar Emitente',
    subtitle: 'Cadastre uma nova empresa emissora de MDF-e',
    editSubtitle: 'Atualize as informações do emitente',
    headerIcon: 'building',
    headerColor: 'linear-gradient(to right, #2563eb, #4f46e5)',

    defaultValues: {
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
    },

    getSections: (item) => [
      {
        title: 'Identificação',
        subtitle: 'Dados principais da empresa',
        icon: 'id-card',
        color: '#2563eb',
        bgColor: '#dbeafe',
        fields: [
          {
            key: 'cnpj',
            label: 'CNPJ',
            type: 'cnpj',
            icon: 'building',
            placeholder: '00.000.000/0000-00',
            autoFetch: !item, // Só buscar dados automaticamente quando for novo cadastro
            onDataFetch: (data) => {
              // Esta função será implementada no componente pai
              console.log('Dados do CNPJ:', data);
            }
          },
          {
            key: 'cpf',
            label: 'CPF (Pessoa Física)',
            type: 'cpf',
            icon: 'user',
            placeholder: '000.000.000-00'
          },
          {
            key: 'razaoSocial',
            label: 'Razão Social',
            type: 'text',
            icon: 'file-signature',
            placeholder: 'Nome completo da empresa',
            required: true,
            maxLength: 100
          },
          {
            key: 'nomeFantasia',
            label: 'Nome Fantasia',
            type: 'text',
            icon: 'store',
            placeholder: 'Nome comercial (opcional)',
            maxLength: 100
          },
          {
            key: 'ie',
            label: 'Inscrição Estadual',
            type: 'text',
            icon: 'certificate',
            placeholder: 'Número da Inscrição Estadual',
            maxLength: 20
          },
          {
            key: 'tipoEmitente',
            label: 'Tipo de Emitente',
            type: 'select',
            icon: 'tags',
            required: true,
            options: [
              { value: 'PrestadorServico', label: 'Prestador de Serviço' },
              { value: 'EntregaPropria', label: 'Entrega Própria' }
            ]
          }
        ]
      },
      {
        title: 'Endereço',
        subtitle: 'Localização da empresa',
        icon: 'map-marker-alt',
        color: '#2563eb',
        bgColor: '#dcfce7',
        columns: 3,
        fields: [
          {
            key: 'endereco',
            label: 'Logradouro',
            type: 'text',
            icon: 'road',
            placeholder: 'Rua, Avenida, etc.',
            required: true,
            colSpan: 2,
            maxLength: 100
          },
          {
            key: 'numero',
            label: 'Número',
            type: 'text',
            icon: 'hashtag',
            placeholder: '123',
            maxLength: 10
          },
          {
            key: 'bairro',
            label: 'Bairro',
            type: 'text',
            icon: 'home',
            placeholder: 'Nome do bairro',
            required: true,
            maxLength: 60
          },
          {
            key: 'complemento',
            label: 'Complemento',
            type: 'text',
            icon: 'plus',
            placeholder: 'Apt, Sala, Bloco, etc.',
            maxLength: 50
          },
          {
            key: 'municipio',
            label: 'Município',
            type: 'text',
            icon: 'city',
            placeholder: 'Nome da cidade',
            required: true,
            maxLength: 60
          },
          {
            key: 'cep',
            label: 'CEP',
            type: 'cep',
            icon: 'mail-bulk',
            placeholder: '00000-000',
            required: true
          },
          {
            key: 'uf',
            label: 'UF',
            type: 'select',
            icon: 'map',
            required: true,
            options: [
              { value: 'AC', label: 'Acre' },
              { value: 'AL', label: 'Alagoas' },
              { value: 'AP', label: 'Amapá' },
              { value: 'AM', label: 'Amazonas' },
              { value: 'BA', label: 'Bahia' },
              { value: 'CE', label: 'Ceará' },
              { value: 'DF', label: 'Distrito Federal' },
              { value: 'ES', label: 'Espírito Santo' },
              { value: 'GO', label: 'Goiás' },
              { value: 'MA', label: 'Maranhão' },
              { value: 'MT', label: 'Mato Grosso' },
              { value: 'MS', label: 'Mato Grosso do Sul' },
              { value: 'MG', label: 'Minas Gerais' },
              { value: 'PA', label: 'Pará' },
              { value: 'PB', label: 'Paraíba' },
              { value: 'PR', label: 'Paraná' },
              { value: 'PE', label: 'Pernambuco' },
              { value: 'PI', label: 'Piauí' },
              { value: 'RJ', label: 'Rio de Janeiro' },
              { value: 'RN', label: 'Rio Grande do Norte' },
              { value: 'RS', label: 'Rio Grande do Sul' },
              { value: 'RO', label: 'Rondônia' },
              { value: 'RR', label: 'Roraima' },
              { value: 'SC', label: 'Santa Catarina' },
              { value: 'SP', label: 'São Paulo' },
              { value: 'SE', label: 'Sergipe' },
              { value: 'TO', label: 'Tocantins' }
            ]
          }
        ]
      },
      {
        title: 'Configurações',
        subtitle: 'Certificados e configurações técnicas',
        icon: 'cog',
        color: '#2563eb',
        bgColor: '#ede9fe',
        collapsible: true,
        defaultCollapsed: false,
        fields: [
          {
            key: 'rntrc',
            label: 'RNTRC',
            type: 'text',
            icon: 'truck',
            placeholder: 'Registro Nacional dos Transportadores',
            maxLength: 20
          },
          {
            key: 'ambienteSefaz',
            label: 'Ambiente SEFAZ',
            type: 'select',
            icon: 'server',
            options: [
              { value: 1, label: 'Produção' },
              { value: 2, label: 'Homologação (Teste)' }
            ]
          },
          {
            key: 'caminhoArquivoCertificado',
            label: 'Certificado Digital',
            type: 'file' as const,
            icon: 'certificate',
            placeholder: 'Selecione o arquivo .pfx ou .p12',
            colSpan: 2,
            buttonLabel: 'Buscar Certificado',
            accept: '.pfx,.p12'
          },
          {
            key: 'senhaCertificado',
            label: 'Senha do Certificado',
            type: 'password',
            icon: 'key',
            placeholder: 'Senha do certificado'
          },
          {
            key: 'caminhoSalvarXml',
            label: 'Pasta para Salvar XMLs',
            type: 'folder' as const,
            icon: 'folder',
            placeholder: 'Selecione onde salvar os XMLs gerados',
            colSpan: 2,
            buttonLabel: 'Buscar Pasta'
          },
          {
            key: 'ativo',
            label: 'Status Ativo',
            type: 'checkbox',
            icon: 'toggle-on',
            placeholder: 'Emitente ativo no sistema',
            show: !!item // Só mostrar no modo de edição
          }
        ]
      }
    ],

    validate: (data) => {
      const errors: Record<string, string> = {};

      if (!data.razaoSocial?.trim()) {
        errors.razaoSocial = 'Razão Social é obrigatória';
      }

      if (!data.endereco?.trim()) {
        errors.endereco = 'Endereço é obrigatório';
      }

      if (!data.bairro?.trim()) {
        errors.bairro = 'Bairro é obrigatório';
      }

      if (!data.municipio?.trim()) {
        errors.municipio = 'Município é obrigatório';
      }

      if (!data.cep?.trim()) {
        errors.cep = 'CEP é obrigatório';
      }

      if (!data.uf?.trim()) {
        errors.uf = 'UF é obrigatória';
      }

      if (!data.tipoEmitente?.trim()) {
        errors.tipoEmitente = 'Tipo de Emitente é obrigatório';
      }

      return errors;
    }
  }
};