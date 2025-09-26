import React, { useState, useEffect } from 'react';
import { MDFeData } from '../../../types/mdfe';
import { entitiesService, EntityOption } from '../../../services/entitiesService';
import { LocalCarregamento, localidadeService } from '../../../services/localidadeService';
import { mdfeService } from '../../../services/mdfeService';
import { useTheme } from '../../../contexts/ThemeContext';
import { LocalidadeSelector } from './LocalidadeSelector';
import { formatCNPJ, formatCPF, formatPlaca, cleanNumericString, cleanPlaca } from '../../../utils/formatters';
import Icon from '../Icon';
import ConfirmTransmissaoModal from '../Modal/ConfirmTransmissaoModal';

interface MDFeWizardProps {
  dados: Partial<MDFeData>;
  onDadosChange: (dados: Partial<MDFeData>) => void;
  onSalvar: () => void;
  onCancelar: () => void;
  onTransmitir?: () => void;
  salvando: boolean;
  transmitindo?: boolean;
  isEdicao: boolean;
  carregandoDados?: boolean;
}

interface WizardSection {
  id: string;
  title: string;
  description: string;
  required: boolean;
  completed: boolean;
}

export function MDFeWizardNovo({ dados, onDadosChange, onSalvar, onCancelar, onTransmitir, salvando, transmitindo = false, isEdicao }: MDFeWizardProps) {
  const { theme } = useTheme();
  const [currentSection, setCurrentSection] = useState('emitente');
  const [emitentes, setEmitentes] = useState<EntityOption[]>([]);
  const [condutores, setCondutores] = useState<EntityOption[]>([]);
  const [veiculos, setVeiculos] = useState<EntityOption[]>([]);
  const [contratantes, setContratantes] = useState<EntityOption[]>([]);
  const [seguradoras, setSeguradoras] = useState<EntityOption[]>([]);
  const [loading, setLoading] = useState(false);
  const [cteChave, setCteChave] = useState('');
  const [nfeChave, setNfeChave] = useState('');
  const [locaisCarregamento, setLocaisCarregamento] = useState<LocalCarregamento[]>([]);
  const [locaisDescarregamento, setLocaisDescarregamento] = useState<LocalCarregamento[]>([]);
  const [selectedEmitenteId, setSelectedEmitenteId] = useState<string>('');
  const [selectedCondutorId, setSelectedCondutorId] = useState<string>('');
  const [selectedVeiculoId, setSelectedVeiculoId] = useState<string>('');
  const [selectedContratanteId, setSelectedContratanteId] = useState<string>('');
  const [selectedSeguradoraId, setSelectedSeguradoraId] = useState<string>('');
  const [showTransmissaoModal, setShowTransmissaoModal] = useState(false);

  // Validações das seções principais
  const emitenteCompleto = !!(dados.emit?.CNPJ && dados.emit?.xNome);
  const veiculoCompleto = !!(dados.infModal?.rodo?.veicTracao?.placa && dados.infModal?.rodo?.veicTracao?.tara);
  const condutorCompleto = !!(dados.infModal?.rodo?.veicTracao?.condutor?.[0]?.xNome);
  const trajetoCompleto = !!(locaisCarregamento.length > 0 && locaisDescarregamento.length > 0 &&
    locaisCarregamento.every(l => l.municipio && l.uf) &&
    locaisDescarregamento.every(l => l.municipio && l.uf));
  const cargaCompleta = !!(dados.tot?.vCarga && parseFloat(dados.tot.vCarga) > 0);
  const documentosCompletos = !!dados.infDoc?.infMunDescarga?.some(descarga =>
    descarga.infNFe?.length || descarga.infCTe?.length
  );

  // Todas as seções obrigatórias estão completas
  const todasSecoesCompletas = emitenteCompleto && veiculoCompleto && trajetoCompleto && cargaCompleta && documentosCompletos;

  const sections: WizardSection[] = [
    {
      id: 'emitente',
      title: 'Emitente',
      description: 'Dados do emitente do manifesto',
      required: true,
      completed: emitenteCompleto
    },
    {
      id: 'veiculo',
      title: 'Veículo',
      description: 'Dados do veículo de transporte',
      required: true,
      completed: veiculoCompleto
    },
    {
      id: 'condutor',
      title: 'Condutor',
      description: 'Dados do condutor responsável',
      required: false,
      completed: condutorCompleto
    },
    {
      id: 'contratante',
      title: 'Contratante',
      description: 'Dados do contratante do serviço',
      required: false,
      completed: true // Por enquanto sempre completo pois é opcional
    },
    {
      id: 'seguradora',
      title: 'Seguradora',
      description: 'Dados da seguradora da carga',
      required: false,
      completed: true // Por enquanto sempre completo pois é opcional
    },
    {
      id: 'trajeto',
      title: 'Trajeto',
      description: 'Rota e percurso da viagem',
      required: true,
      completed: trajetoCompleto
    },
    {
      id: 'carga',
      title: 'Carga',
      description: 'Informações sobre a carga transportada',
      required: true,
      completed: cargaCompleta
    },
    {
      id: 'documentos',
      title: 'Documentos Vinculados',
      description: 'CTe/NFe vinculados ao manifesto',
      required: true,
      completed: documentosCompletos
    },
    {
      id: 'resumo',
      title: 'Resumo Final',
      description: 'Revisão dos dados antes da emissão',
      required: true,
      completed: todasSecoesCompletas
    }
  ];

  useEffect(() => {
    loadEntities();
    loadExistingData();
  }, []);

  // Sincronizar estados locais quando dados mudarem (ao voltar de outras seções)
  useEffect(() => {

    // ✅ CORREÇÃO: Restaurar locais de carregamento com fallbacks robustos
    if (dados.ide?.infMunCarrega && dados.ide.infMunCarrega.length > 0) {
      const carregamentoSalvos = dados.ide.infMunCarrega
        .map((local, index) => {
          // Validar se temos dados mínimos necessários
          if (!local.xMunCarrega || (!local.cMunCarrega && !local.uf)) {
            return null;
          }

          return {
            id: `carregamento_${index}`,
            municipio: local.xMunCarrega || '',
            uf: (local as any).uf || '',
            codigoIBGE: parseInt(local.cMunCarrega || '0')
          };
        })
        .filter(local => local !== null) as LocalCarregamento[];

      // Só atualizar se temos dados válidos e realmente mudou
      if (carregamentoSalvos.length > 0 && JSON.stringify(carregamentoSalvos) !== JSON.stringify(locaisCarregamento)) {
        setLocaisCarregamento(carregamentoSalvos);
      }
    }

    // ✅ CORREÇÃO: Restaurar locais de descarregamento com fallbacks robustos
    if (dados.infDoc?.infMunDescarga && dados.infDoc.infMunDescarga.length > 0) {
      const descarregamentoSalvos = dados.infDoc.infMunDescarga
        .map((local, index) => {
          // Validar se temos dados mínimos necessários
          if (!local.xMunDescarga || (!local.cMunDescarga && !local.uf)) {
            return null;
          }

          return {
            id: `descarregamento_${index}`,
            municipio: local.xMunDescarga || '',
            uf: (local as any).uf || '',
            codigoIBGE: parseInt(local.cMunDescarga || '0')
          };
        })
        .filter(local => local !== null) as LocalCarregamento[];

      // Só atualizar se temos dados válidos e realmente mudou
      if (descarregamentoSalvos.length > 0 && JSON.stringify(descarregamentoSalvos) !== JSON.stringify(locaisDescarregamento)) {
        setLocaisDescarregamento(descarregamentoSalvos);
      }
    }
  }, [dados.ide?.infMunCarrega, dados.infDoc?.infMunDescarga]);

  // CORREÇÃO: Auto-selecionar entidades usando IDs diretos primeiro, depois busca por dados
  useEffect(() => {
    if (!isEdicao) return; // Só executar em modo de edição

    // ✅ PRIMEIRO: Tentar usar IDs diretos do MDFeData (mais confiável)
    if (dados.emitenteId && emitentes.length > 0 && !selectedEmitenteId) {
      const emitenteEncontrado = emitentes.find(e => e.id === dados.emitenteId?.toString());
      if (emitenteEncontrado) {
        setSelectedEmitenteId(emitenteEncontrado.id);
        console.log('✅ Emitente selecionado via ID:', emitenteEncontrado.id);
      }
    }

    if (dados.veiculoId && veiculos.length > 0 && !selectedVeiculoId) {
      const veiculoEncontrado = veiculos.find(v => v.id === dados.veiculoId?.toString());
      if (veiculoEncontrado) {
        setSelectedVeiculoId(veiculoEncontrado.id);
        console.log('✅ Veículo selecionado via ID:', veiculoEncontrado.id);
      }
    }

    if (dados.motoristaId && condutores.length > 0 && !selectedCondutorId) {
      const condutorEncontrado = condutores.find(c => c.id === dados.motoristaId?.toString());
      if (condutorEncontrado) {
        setSelectedCondutorId(condutorEncontrado.id);
        console.log('✅ Condutor selecionado via ID:', condutorEncontrado.id);
      }
    }

    // ⚠️ FALLBACK: Se não tiver IDs, tentar buscar por CNPJ/placa/CPF (para compatibilidade)
    if (!dados.emitenteId && dados.emit?.CNPJ && emitentes.length > 0 && !selectedEmitenteId) {
      const cnpj = dados.emit.CNPJ.replace(/\D/g, '');
      const emitente = emitentes.find(e => e.data?.CNPJ?.replace(/\D/g, '') === cnpj);
      if (emitente) {
        setSelectedEmitenteId(emitente.id);
        console.log('⚠️ Emitente selecionado via CNPJ (fallback):', emitente.id);
      }
    }

    if (!dados.veiculoId && dados.infModal?.rodo?.veicTracao?.placa && veiculos.length > 0 && !selectedVeiculoId) {
      const placa = dados.infModal.rodo.veicTracao.placa.replace(/\W/g, '').toUpperCase();
      const veiculo = veiculos.find(v => v.data?.placa?.replace(/\W/g, '').toUpperCase() === placa);
      if (veiculo) {
        setSelectedVeiculoId(veiculo.id);
        console.log('⚠️ Veículo selecionado via placa (fallback):', veiculo.id);
      }
    }

    if (!dados.motoristaId && dados.infModal?.rodo?.veicTracao?.condutor?.[0]?.CPF && condutores.length > 0 && !selectedCondutorId) {
      const cpf = dados.infModal.rodo.veicTracao.condutor[0].CPF.replace(/\D/g, '');
      const condutor = condutores.find(c => c.data?.CPF?.replace(/\D/g, '') === cpf);
      if (condutor) {
        setSelectedCondutorId(condutor.id);
        console.log('⚠️ Condutor selecionado via CPF (fallback):', condutor.id);
      }
    }

    // ✅ CONTRATANTE: Selecionar contratante se tiver ID
    if (dados.contratanteId && contratantes.length > 0 && !selectedContratanteId) {
      const contratanteEncontrado = contratantes.find(c => c.id === dados.contratanteId?.toString());
      if (contratanteEncontrado) {
        setSelectedContratanteId(contratanteEncontrado.id);
        console.log('✅ Contratante selecionado via ID:', contratanteEncontrado.id);
      }
    }

    // ✅ SEGURADORA: Selecionar seguradora se tiver ID
    if (dados.seguradoraId && seguradoras.length > 0 && !selectedSeguradoraId) {
      const seguradoraEncontrada = seguradoras.find(s => s.id === dados.seguradoraId?.toString());
      if (seguradoraEncontrada) {
        setSelectedSeguradoraId(seguradoraEncontrada.id);
        console.log('✅ Seguradora selecionada via ID:', seguradoraEncontrada.id);
      }
    }

    // ⚠️ FALLBACK CONTRATANTE: Se não tiver ID, tentar buscar por CNPJ
    if (!dados.contratanteId && dados.contrat?.CNPJ && contratantes.length > 0 && !selectedContratanteId) {
      const cnpj = dados.contrat.CNPJ.replace(/\D/g, '');
      const contratante = contratantes.find(c => c.data?.CNPJ?.replace(/\D/g, '') === cnpj);
      if (contratante) {
        setSelectedContratanteId(contratante.id);
        console.log('⚠️ Contratante selecionado via CNPJ (fallback):', contratante.id);
      }
    }

    // ⚠️ FALLBACK SEGURADORA: Se não tiver ID, tentar buscar por CNPJ
    if (!dados.seguradoraId && dados.seg?.[0]?.infSeg?.CNPJ && seguradoras.length > 0 && !selectedSeguradoraId) {
      const cnpj = dados.seg[0].infSeg.CNPJ.replace(/\D/g, '');
      const seguradora = seguradoras.find(s => s.data?.CNPJ?.replace(/\D/g, '') === cnpj);
      if (seguradora) {
        setSelectedSeguradoraId(seguradora.id);
        console.log('⚠️ Seguradora selecionada via CNPJ (fallback):', seguradora.id);
      }
    }
  }, [dados, emitentes, veiculos, condutores, contratantes, seguradoras, isEdicao, selectedEmitenteId, selectedVeiculoId, selectedCondutorId, selectedContratanteId, selectedSeguradoraId]);

  // Salvamento automático removido - apenas salvamento manual

  // Backup automático removido completamente

  // Carregar dados existentes (modo edição ou rascunho salvo)
  const loadExistingData = () => {
    if (dados) {
      // Carregar locais de carregamento se existirem
      if (dados.ide?.infMunCarrega && dados.ide.infMunCarrega.length > 0 && locaisCarregamento.length === 0) {
        const locaisCarregamento = dados.ide.infMunCarrega.map((local, index) => ({
          id: `carregamento_${index}`,
          municipio: local.xMunCarrega || '',
          uf: (local as any).uf || '', // Restaurar UF salva
          codigoIBGE: parseInt(local.cMunCarrega || '0')
        }));
        setLocaisCarregamento(locaisCarregamento);
      }

      // Carregar locais de descarregamento se existirem
      if (dados.infDoc?.infMunDescarga && dados.infDoc.infMunDescarga.length > 0 && locaisDescarregamento.length === 0) {
        const locaisDescarregamento = dados.infDoc.infMunDescarga.map((local, index) => ({
          id: `descarregamento_${index}`,
          municipio: local.xMunDescarga || '',
          uf: (local as any).uf || '', // Restaurar UF salva
          codigoIBGE: parseInt(local.cMunDescarga || '0')
        }));
        setLocaisDescarregamento(locaisDescarregamento);
      }
    }
  };

  // Salvar locais de carregamento diretamente no estado
  const salvarLocaisCarregamento = (novosLocais: LocalCarregamento[]) => {

    const infMunCarrega = novosLocais.map(local => ({
      cMunCarrega: local.codigoIBGE.toString().padStart(7, '0'),
      xMunCarrega: local.municipio,
      uf: local.uf // Salvar UF para restaurar depois
    }));

    atualizarCampo('ide', 'infMunCarrega', infMunCarrega);
  };

  // ✨ Função para distribuir CTes automaticamente entre locais de descarregamento
  const distribuirCtesAutomaticamente = (ctes: any[], locais: LocalCarregamento[]): any[][] => {
    if (ctes.length === 0 || locais.length === 0) return [];

    // Se só há 1 local, todos os CTes vão para ele
    if (locais.length === 1) {
      return [ctes];
    }

    // Distribuir CTes de forma equilibrada entre os locais
    const ctesDistribuidos: any[][] = Array(locais.length).fill(null).map(() => [] as any[]);
    ctes.forEach((cte, index) => {
      const localIndex = index % locais.length; // Distribuição round-robin
      ctesDistribuidos[localIndex].push(cte);
    });

    return ctesDistribuidos;
  };

  // Salvar locais de descarregamento diretamente no estado
  const salvarLocaisDescarregamento = (novosLocais: LocalCarregamento[]) => {
    console.log('🚛 [DEBUG] salvarLocaisDescarregamento chamada com:', novosLocais);
    console.log('🚛 [DEBUG] Primeiro local recebido:', {
      municipio: novosLocais[0]?.municipio,
      uf: novosLocais[0]?.uf,
      codigoIBGE: novosLocais[0]?.codigoIBGE
    });

    // ✅ CORREÇÃO: Preservar CTes/NFes existentes ao atualizar locais
    const ctesExistentes = dados.infDoc?.infMunDescarga?.reduce((acc, descarga) => {
      if (descarga.infCTe) acc.push(...descarga.infCTe);
      return acc;
    }, [] as any[]) || [];

    const nfesExistentes = dados.infDoc?.infMunDescarga?.reduce((acc, descarga) => {
      if (descarga.infNFe) acc.push(...descarga.infNFe);
      return acc;
    }, [] as any[]) || [];

    console.log('🚛 [DEBUG] CTes existentes:', ctesExistentes);

    // ✨ Distribuir CTes automaticamente entre os locais
    const ctesDistribuidos = distribuirCtesAutomaticamente(ctesExistentes, novosLocais);
    const nfesDistribuidos = distribuirCtesAutomaticamente(nfesExistentes, novosLocais);

    const infMunDescarga = novosLocais.map((local, index) => {
      // ✅ PRESERVAR dados existentes se disponíveis
      const dadosExistentes = dados.infDoc?.infMunDescarga?.[index];

      return {
        // Usar dados do local atual ou preservar existentes
        cMunDescarga: local.codigoIBGE?.toString().padStart(7, '0') || dadosExistentes?.cMunDescarga || '',
        xMunDescarga: local.municipio || dadosExistentes?.xMunDescarga || '',
        uf: local.uf || dadosExistentes?.uf || '',
        // ✨ Distribuir documentos automaticamente
        infCTe: ctesDistribuidos[index] || [],
        infNFe: nfesDistribuidos[index] || []
      };
    });

    console.log('🚛 [DEBUG] CTes distribuídos:', ctesDistribuidos);
    console.log('🚛 [DEBUG] Estrutura final que será salva:', infMunDescarga);
    console.log('🚛 [DEBUG] Primeiro município da estrutura final:', {
      cMunDescarga: infMunDescarga[0]?.cMunDescarga,
      xMunDescarga: infMunDescarga[0]?.xMunDescarga,
      uf: infMunDescarga[0]?.uf
    });

    atualizarSecao('infDoc', {
      infMunDescarga: infMunDescarga
    });
  };

  // Função para salvar automaticamente os dados no banco
  const salvarAutomaticamente = async () => {
    try {
      await mdfeService.salvarRascunhoWizard(dados);
      console.log('📁 Dados salvos automaticamente');
      // Forçar atualização do estado pai para manter sincronização
      onDadosChange({ ...dados });
    } catch (error) {
      console.warn('⚠️ Erro ao salvar automaticamente:', error);
    }
  };

  const loadEntities = async () => {
    setLoading(true);
    try {
      const [emitentesData, condutoresData, veiculosData, contratantesData, seguradorasData] = await Promise.all([
        entitiesService.obterEmitentes(),
        entitiesService.obterCondutores(),
        entitiesService.obterVeiculos(),
        entitiesService.obterContratantes(),
        entitiesService.obterSeguradoras()
      ]);

      setEmitentes(emitentesData);
      setCondutores(condutoresData);
      setVeiculos(veiculosData);
      setContratantes(contratantesData);
      setSeguradoras(seguradorasData);
    } catch (error) {
      console.error('Erro ao carregar entidades:', error);
    } finally {
      setLoading(false);
    }
  };

  const atualizarCampo = (secao: string, campo: string, valor: any) => {
    const novosDados = { ...dados } as any;
    if (!novosDados[secao]) {
      novosDados[secao] = {};
    }
    novosDados[secao][campo] = valor;
    onDadosChange(novosDados);
  };

  const atualizarSecao = (secao: string, dadosSecao: any) => {
    const novosDados = { ...dados } as any;
    novosDados[secao] = { ...(novosDados[secao] || {}), ...dadosSecao };
    onDadosChange(novosDados);
  };

  const atualizarVeiculo = (campo: string, valor: any) => {
    atualizarSecao('infModal', {
      ...dados.infModal,
      rodo: {
        ...dados.infModal?.rodo,
        veicTracao: {
          ...dados.infModal?.rodo?.veicTracao,
          [campo]: valor
        }
      }
    });
  };

  const atualizarSeguradora = (campo: string, valor: any) => {
    const currentSeg = dados.seg || [{}];
    const updatedSeg = [...currentSeg];

    if (!updatedSeg[0]) {
      updatedSeg[0] = {};
    }

    // Campos que ficam em infSeg
    if (['CNPJ', 'xSeg'].includes(campo)) {
      if (!updatedSeg[0].infSeg) {
        updatedSeg[0].infSeg = {};
      }
      (updatedSeg[0].infSeg as any)[campo] = valor;
    }
    // Campos que ficam em infResp
    else if (['respSeg', 'CPF'].includes(campo)) {
      if (!updatedSeg[0].infResp) {
        updatedSeg[0].infResp = {};
      }
      (updatedSeg[0].infResp as any)[campo] = valor;
    }
    // Campos que ficam diretamente no objeto seg
    else if (['nApol', 'nAver'].includes(campo)) {
      (updatedSeg[0] as any)[campo] = valor;
    }
    // Para novos campos como nomeFantasia, adicionar em infSeg
    else {
      if (!updatedSeg[0].infSeg) {
        updatedSeg[0].infSeg = {};
      }
      (updatedSeg[0].infSeg as any)[campo] = valor;
    }

    onDadosChange({
      ...dados,
      seg: updatedSeg
    });
  };

  const handleEmitenteSelect = (emitenteId: string) => {
    setSelectedEmitenteId(emitenteId);
    const emitente = emitentes.find(e => e.id === emitenteId);

    if (emitente && emitente.data) {
      // ✅ CORREÇÃO: Salvar ID do emitente + dados expandidos
      onDadosChange({
        ...dados,
        emitenteId: parseInt(emitenteId), // Salvar ID direto
        emit: {
          CNPJ: emitente.data.CNPJ,
          IE: emitente.data.IE,
          xNome: emitente.data.xNome,
          xFant: emitente.data.xFant,
          enderEmit: emitente.data.enderEmit
        }
      });
    } else if (emitenteId === '') {
      // Limpar campos se deselecionar
      onDadosChange({
        ...dados,
        emitenteId: undefined, // Limpar ID também
        emit: {
          CNPJ: '',
          IE: '',
          xNome: '',
          xFant: '',
          enderEmit: undefined
        }
      });
    }
  };

  const handleCondutorSelect = (condutorId: string) => {
    setSelectedCondutorId(condutorId);
    const condutor = condutores.find(c => c.id === condutorId);

    if (condutor && condutor.data) {
      // ✅ CORREÇÃO: Salvar ID do condutor + dados expandidos
      onDadosChange({
        ...dados,
        motoristaId: parseInt(condutorId), // Salvar ID direto
        infModal: {
          ...dados.infModal,
          rodo: {
            ...dados.infModal?.rodo,
            veicTracao: {
              ...dados.infModal?.rodo?.veicTracao,
              condutor: [{
                xNome: condutor.data.xNome,
                CPF: condutor.data.CPF
              }]
            },
          }
        }
      });
    } else if (condutorId === '') {
      // Limpar campos se deselecionar
      onDadosChange({
        ...dados,
        motoristaId: undefined, // Limpar ID também
        infModal: {
          ...dados.infModal,
          rodo: {
            ...dados.infModal?.rodo,
            veicTracao: {
              ...dados.infModal?.rodo?.veicTracao,
              condutor: undefined
            },
          }
        }
      });
    }
  };

  const handleVeiculoSelect = (veiculoId: string) => {
    setSelectedVeiculoId(veiculoId);
    const veiculo = veiculos.find(v => v.id === veiculoId);

    if (veiculo && veiculo.data) {
      // ✅ CORREÇÃO: Salvar ID do veículo + dados expandidos
      onDadosChange({
        ...dados,
        veiculoId: parseInt(veiculoId), // Salvar ID direto
        infModal: {
          ...dados.infModal,
          rodo: {
            ...dados.infModal?.rodo,
            veicTracao: {
              ...dados.infModal?.rodo?.veicTracao,
              cInt: veiculo.data.cInt,
              placa: veiculo.data.placa,
              tara: veiculo.data.tara,
              // tpProp removido - não existe na interface veicTracao
              // tpVeic removido - não existe na interface veicTracao
              tpRod: veiculo.data.tpRod,
              tpCar: veiculo.data.tpCar,
              UF: veiculo.data.UF
            }
          }
        }
      });
    } else if (veiculoId === '') {
      // Limpar campos se deselecionar
      onDadosChange({
        ...dados,
        veiculoId: undefined, // Limpar ID também
        infModal: {
          ...dados.infModal,
          rodo: {
            ...dados.infModal?.rodo,
            veicTracao: {
              ...dados.infModal?.rodo?.veicTracao,
              cInt: '',
              placa: '',
              tara: '',
              // tpProp removido - não existe na interface veicTracao
              // tpVeic removido - não existe na interface veicTracao
              tpRod: '01',
              tpCar: '00',
              UF: ''
            }
          }
        }
      });
    }
  };

  const handleContratanteSelect = (contratanteId: string) => {
    setSelectedContratanteId(contratanteId);
    const contratante = contratantes.find(c => c.id === contratanteId);

    if (contratante && contratante.data) {
      onDadosChange({
        ...dados,
        contratanteId: parseInt(contratanteId),
        contrat: {
          CNPJ: contratante.data.CNPJ,
          IE: contratante.data.IE,
          xNome: contratante.data.xNome,
          xFant: contratante.data.xFant,
          enderContrat: contratante.data.enderContrat
        }
      });
    } else if (contratanteId === '') {
      onDadosChange({
        ...dados,
        contratanteId: undefined,
        contrat: {
          CNPJ: '',
          IE: '',
          xNome: '',
          xFant: ''
        }
      });
    }
  };

  const handleSeguradoraSelect = async (seguradoraId: string) => {
    setSelectedSeguradoraId(seguradoraId);

    if (seguradoraId === '') {
      // Limpar campos se deselecionar
      onDadosChange({
        ...dados,
        seguradoraId: undefined,
        seg: []
      });
      return;
    }

    try {
      // Buscar dados completos da seguradora via API
      const response = await fetch(`${process.env.REACT_APP_API_URL || 'https://localhost:5001/api'}/seguradoras/${seguradoraId}`);

      if (response.ok) {
        const seguradoraCompleta = await response.json();

        console.log('✅ Dados da seguradora carregados:', seguradoraCompleta);

        // Preencher automaticamente todos os campos
        onDadosChange({
          ...dados,
          seguradoraId: parseInt(seguradoraId),
          seg: [{
            infSeg: {
              xSeg: seguradoraCompleta.razaoSocial || seguradoraCompleta.RazaoSocial || '',
              CNPJ: seguradoraCompleta.cnpj || seguradoraCompleta.Cnpj || ''
            },
            infResp: {
              respSeg: "1", // 1 = Emitente é responsável pelo seguro
              CNPJ: seguradoraCompleta.cnpj || seguradoraCompleta.Cnpj || '',
              CPF: undefined
            },
            nApol: seguradoraCompleta.apolice || seguradoraCompleta.Apolice || '', // Campo correto
            nAver: [] // Array de averbações (opcional)
          }]
        });
      } else {
        console.warn('⚠️ Erro ao buscar dados da seguradora');
        // Fallback: usar dados básicos do combobox
        const seguradora = seguradoras.find(s => s.id === seguradoraId);
        if (seguradora && seguradora.data) {
          onDadosChange({
            ...dados,
            seguradoraId: parseInt(seguradoraId),
            seg: [{
              infSeg: {
                xSeg: seguradora.data.xSeg || seguradora.label,
                CNPJ: seguradora.data.CNPJ || ''
              }
            }]
          });
        }
      }
    } catch (error) {
      console.error('❌ Erro ao carregar dados da seguradora:', error);
      // Fallback: usar dados básicos do combobox
      const seguradora = seguradoras.find(s => s.id === seguradoraId);
      if (seguradora && seguradora.data) {
        onDadosChange({
          ...dados,
          seguradoraId: parseInt(seguradoraId),
          seg: [{
            infSeg: {
              xSeg: seguradora.data.xSeg || seguradora.label,
              CNPJ: seguradora.data.CNPJ || ''
            }
          }]
        });
      }
    }
  };

  const addCTe = () => {

    if (cteChave && cteChave.length === 44) {
      const currentDescarga = dados.infDoc?.infMunDescarga || [];
      const newDescarga = [...currentDescarga];


      if (newDescarga.length === 0) {
        // Sem locais de descarga ainda, usar dados do estado locaisDescarregamento
        const primeiroLocal = locaisDescarregamento[0];
        newDescarga.push({
          cMunDescarga: primeiroLocal?.codigoIBGE?.toString().padStart(7, '0') || '',
          xMunDescarga: primeiroLocal?.municipio || '',
          uf: primeiroLocal?.uf || '',
          infCTe: [{ chCTe: cteChave }],
          infNFe: []
        });
        console.log('🟡 [DEBUG] Criado novo local de descarga com CTe usando dados do estado:', primeiroLocal);
        console.log('🟡 [DEBUG] Estrutura criada:', {
          cMunDescarga: primeiroLocal?.codigoIBGE?.toString().padStart(7, '0') || '',
          xMunDescarga: primeiroLocal?.municipio || '',
          uf: primeiroLocal?.uf || ''
        });
      } else {
        // Já existem locais, adicionar CTe ao primeiro E atualizar dados do município se vazios
        if (!newDescarga[0].infCTe) {
          newDescarga[0].infCTe = [];
        }
        newDescarga[0].infCTe.push({ chCTe: cteChave });

        // ✅ ATUALIZAR dados do município se estão vazios
        const primeiroLocal = locaisDescarregamento[0];
        if (primeiroLocal && (!newDescarga[0].xMunDescarga || !newDescarga[0].uf)) {
          newDescarga[0].cMunDescarga = primeiroLocal.codigoIBGE?.toString().padStart(7, '0') || newDescarga[0].cMunDescarga;
          newDescarga[0].xMunDescarga = primeiroLocal.municipio || newDescarga[0].xMunDescarga;
          newDescarga[0].uf = primeiroLocal.uf || newDescarga[0].uf;
          console.log('🟡 [DEBUG] Dados do município atualizados:', {
            cMunDescarga: newDescarga[0].cMunDescarga,
            xMunDescarga: newDescarga[0].xMunDescarga,
            uf: newDescarga[0].uf
          });
        }

        console.log('🟡 [DEBUG] CTe adicionado ao local existente, total CTes:', newDescarga[0].infCTe.length);
      }

      console.log('🟡 [DEBUG] newDescarga final:', newDescarga);

      // 🔥 FORÇAR ATUALIZAÇÃO IMEDIATA E COMPLETA
      const novosDadosCompletos = {
        ...dados,
        infDoc: {
          ...dados.infDoc,
          infMunDescarga: newDescarga
        },
        tot: {
          ...dados.tot,
          qCTe: (newDescarga[0]?.infCTe?.length || 0).toString()
        }
      };

      console.log('🔥 [DEBUG] Forçando atualização completa:', novosDadosCompletos);
      onDadosChange(novosDadosCompletos);

      console.log('🟡 [DEBUG] Contador qCTe atualizado para:', newDescarga[0]?.infCTe?.length || 0);

      setCteChave('');
    } else {
      console.log('🟡 [DEBUG] Chave inválida - não processado');
    }
  };

  const addNFe = () => {
    if (nfeChave && nfeChave.length === 44) {
      const currentDescarga = dados.infDoc?.infMunDescarga || [];
      const newDescarga = [...currentDescarga];

      if (newDescarga.length === 0) {
        // Sem locais de descarga ainda, usar dados do estado locaisDescarregamento
        const primeiroLocal = locaisDescarregamento[0];
        newDescarga.push({
          cMunDescarga: primeiroLocal?.codigoIBGE?.toString().padStart(7, '0') || '',
          xMunDescarga: primeiroLocal?.municipio || '',
          uf: primeiroLocal?.uf || '',
          infCTe: [],
          infNFe: [{ chNFe: nfeChave }]
        });
      } else {
        if (!newDescarga[0].infNFe) {
          newDescarga[0].infNFe = [];
        }
        newDescarga[0].infNFe.push({ chNFe: nfeChave });

        // ✅ ATUALIZAR dados do município se estão vazios
        const primeiroLocal = locaisDescarregamento[0];
        if (primeiroLocal && (!newDescarga[0].xMunDescarga || !newDescarga[0].uf)) {
          newDescarga[0].cMunDescarga = primeiroLocal.codigoIBGE?.toString().padStart(7, '0') || newDescarga[0].cMunDescarga;
          newDescarga[0].xMunDescarga = primeiroLocal.municipio || newDescarga[0].xMunDescarga;
          newDescarga[0].uf = primeiroLocal.uf || newDescarga[0].uf;
          console.log('🟢 [DEBUG] Dados do município atualizados no NFe:', {
            cMunDescarga: newDescarga[0].cMunDescarga,
            xMunDescarga: newDescarga[0].xMunDescarga,
            uf: newDescarga[0].uf
          });
        }
      }

      atualizarSecao('infDoc', {
        infMunDescarga: newDescarga
      });

      // Atualizar contadores
      const qNFe = newDescarga[0]?.infNFe?.length || 0;
      atualizarCampo('tot', 'qNFe', qNFe.toString());

      setNfeChave('');
    }
  };

  const removeCTe = (index: number) => {
    console.log('🗑️ [DEBUG] removeCTe chamado - index:', index);

    const currentDescarga = dados.infDoc?.infMunDescarga || [];
    if (currentDescarga[0]?.infCTe && currentDescarga[0].infCTe.length > 0) {
      const newCTe = currentDescarga[0].infCTe.filter((_, i) => i !== index);
      console.log('🗑️ [DEBUG] CTes antes da remoção:', currentDescarga[0].infCTe.length);
      console.log('🗑️ [DEBUG] CTes depois da remoção:', newCTe.length);

      const newDescarga = [{
        ...currentDescarga[0],
        infCTe: newCTe
      }];

      // 🔥 FORÇAR ATUALIZAÇÃO IMEDIATA E COMPLETA
      const novosDadosCompletos = {
        ...dados,
        infDoc: {
          ...dados.infDoc,
          infMunDescarga: newDescarga
        },
        tot: {
          ...dados.tot,
          qCTe: newCTe.length.toString()
        }
      };

      console.log('🔥 [DEBUG] Forçando atualização completa na remoção:', novosDadosCompletos);
      onDadosChange(novosDadosCompletos);
    }
  };

  const removeNFe = (index: number) => {
    console.log('🗑️ [DEBUG] removeNFe chamado - index:', index);

    const currentDescarga = dados.infDoc?.infMunDescarga || [];
    if (currentDescarga[0]?.infNFe && currentDescarga[0].infNFe.length > 0) {
      const newNFe = currentDescarga[0].infNFe.filter((_, i) => i !== index);
      console.log('🗑️ [DEBUG] NFes antes da remoção:', currentDescarga[0].infNFe.length);
      console.log('🗑️ [DEBUG] NFes depois da remoção:', newNFe.length);

      const newDescarga = [{
        ...currentDescarga[0],
        infNFe: newNFe
      }];

      // 🔥 FORÇAR ATUALIZAÇÃO IMEDIATA E COMPLETA
      const novosDadosCompletos = {
        ...dados,
        infDoc: {
          ...dados.infDoc,
          infMunDescarga: newDescarga
        },
        tot: {
          ...dados.tot,
          qNFe: newNFe.length.toString()
        }
      };

      console.log('🔥 [DEBUG] Forçando atualização completa na remoção NFe:', novosDadosCompletos);
      onDadosChange(novosDadosCompletos);
    }
  };

  const atualizarLocaisCarregamento = (novosLocais: LocalCarregamento[]) => {
    setLocaisCarregamento(novosLocais);
    // Salvar locais de carregamento independentemente do descarregamento
    salvarLocaisCarregamento(novosLocais);
    // Só calcular rota se tiver ambos
    if (novosLocais.length > 0 && locaisDescarregamento.length > 0) {
      atualizarPercursoMDFe(novosLocais, locaisDescarregamento);
    }
    salvarAutomaticamente(); // Auto-salvar quando dados mudarem
  };

  const atualizarLocaisDescarregamento = (novosLocais: LocalCarregamento[]) => {
    setLocaisDescarregamento(novosLocais);
    // Salvar locais de descarregamento independentemente do carregamento
    salvarLocaisDescarregamento(novosLocais);
    // Só calcular rota se tiver ambos
    if (locaisCarregamento.length > 0 && novosLocais.length > 0) {
      atualizarPercursoMDFe(locaisCarregamento, novosLocais);
    }
    salvarAutomaticamente(); // Auto-salvar quando dados mudarem
  };

  const atualizarPercursoMDFe = (carregamento: LocalCarregamento[], descarregamento: LocalCarregamento[]) => {
    if (carregamento.length === 0 || descarregamento.length === 0) return;

    // Calcular UF inicial e final
    const ufInicial = carregamento[0]?.uf;
    const ufFinal = descarregamento[descarregamento.length - 1]?.uf;

    // Calcular todos os locais em sequência
    const todosLocais = [...carregamento, ...descarregamento];
    const rotas = localidadeService.calcularRotaCompleta(todosLocais);
    const estadosPercurso = localidadeService.obterEstadosPercursoTotal(rotas);

    // Atualizar dados do MDF-e
    atualizarCampo('ide', 'UFIni', ufInicial);
    atualizarCampo('ide', 'UFFim', ufFinal);


    // Atualizar percurso
    const infPercurso = estadosPercurso
      .filter(uf => uf !== ufInicial && uf !== ufFinal)
      .map(uf => ({ UFPer: uf }));

    atualizarCampo('ide', 'infPercurso', infPercurso);

    // ✅ CORREÇÃO: Não sobrescrever os dados já salvos pelas funções individuais
    // Os locais já foram salvos corretamente pelas funções salvarLocaisCarregamento e salvarLocaisDescarregamento
    // Aqui apenas atualizamos campos adicionais se necessário, mas mantemos os dados existentes

    // Verificar se os dados já existem antes de sobrescrever
    if (!dados.ide?.infMunCarrega || dados.ide.infMunCarrega.length === 0) {
      const infMunCarrega = carregamento.map(local => ({
        cMunCarrega: local.codigoIBGE.toString().padStart(7, '0'),
        xMunCarrega: local.municipio,
        uf: local.uf
      }));
      atualizarCampo('ide', 'infMunCarrega', infMunCarrega);
    }

    // ✅ CORREÇÃO: Não sobrescrever dados de descarregamento se já existem
    // Esta função deve apenas calcular percurso, não gerenciar locais de descarga
    // Os locais já são gerenciados pela função salvarLocaisDescarregamento
  };

  const nextSection = () => {
    const currentIndex = sections.findIndex(s => s.id === currentSection);
    if (currentIndex < sections.length - 1) {
      setCurrentSection(sections[currentIndex + 1].id);
    }
  };

  const prevSection = () => {
    const currentIndex = sections.findIndex(s => s.id === currentSection);
    if (currentIndex > 0) {
      setCurrentSection(sections[currentIndex - 1].id);
    }
  };

  const renderSectionContent = () => {
    switch (currentSection) {
      case 'emitente':
        return (
          <div className="card-body">
            <h4>Selecionar Emitente</h4>
            <p className="mb-4" style={{ color: 'var(--color-text-secondary)' }}>
              Selecione o emitente dos seus cadastros ou preencha manualmente
            </p>

            <div className="mb-4">
              <label className="label">Emitente Cadastrado</label>
              <select
                className="input"
                value={selectedEmitenteId}
                onChange={(e) => handleEmitenteSelect(e.target.value)}
                disabled={loading}
              >
                <option value="">
                  {loading ? 'Carregando emitentes...' :
                   emitentes.length === 0 ? 'Nenhum emitente cadastrado' :
                   'Selecione um emitente cadastrado...'}
                </option>
                {emitentes.map(emitente => (
                  <option key={emitente.id} value={emitente.id}>
                    {emitente.label} - {emitente.description}
                  </option>
                ))}
              </select>
              {!loading && emitentes.length === 0 && (
                <small style={{ color: 'var(--color-text-secondary)', fontSize: '0.75rem', display: 'block', marginTop: '0.25rem' }}>
                  Cadastre emitentes antes de criar um MDF-e ou preencha os dados manualmente abaixo
                </small>
              )}
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 'var(--space-4)' }}>
              <div>
                <label className="label label-required">CNPJ</label>
                <input
                  type="text"
                  className="input"
                  value={dados.emit?.CNPJ ? formatCNPJ(dados.emit.CNPJ) : ''}
                  onChange={(e) => atualizarCampo('emit', 'CNPJ', cleanNumericString(e.target.value))}
                  placeholder="00.000.000/0000-00"
                  maxLength={18}
                  required
                />
              </div>

              <div>
                <label className="label">Inscrição Estadual</label>
                <input
                  type="text"
                  className="input"
                  value={dados.emit?.IE || ''}
                  onChange={(e) => atualizarCampo('emit', 'IE', e.target.value)}
                  placeholder="Inscrição Estadual"
                />
              </div>

              <div>
                <label className="label label-required">Razão Social</label>
                <input
                  type="text"
                  className="input"
                  value={dados.emit?.xNome || ''}
                  onChange={(e) => atualizarCampo('emit', 'xNome', e.target.value)}
                  placeholder="Nome da empresa"
                  required
                />
              </div>

              <div>
                <label className="label">Nome Fantasia</label>
                <input
                  type="text"
                  className="input"
                  value={dados.emit?.xFant || ''}
                  onChange={(e) => atualizarCampo('emit', 'xFant', e.target.value)}
                  placeholder="Nome fantasia"
                />
              </div>
            </div>
          </div>
        );

      case 'veiculo':
        return (
          <div className="card-body">
            <h4>Selecionar Veículo</h4>
            <p className="mb-4" style={{ color: 'var(--color-text-secondary)' }}>
              Selecione o veículo de tração dos seus cadastros
            </p>

            <div className="mb-4">
              <label className="label">Veículo Cadastrado</label>
              <select
                className="input"
                value={selectedVeiculoId}
                onChange={(e) => handleVeiculoSelect(e.target.value)}
                disabled={loading}
              >
                <option value="">
                  {loading ? 'Carregando veículos...' :
                   veiculos.length === 0 ? 'Nenhum veículo cadastrado' :
                   'Selecione um veículo cadastrado...'}
                </option>
                {veiculos.map(veiculo => (
                  <option key={veiculo.id} value={veiculo.id}>
                    {veiculo.label} - {veiculo.description}
                  </option>
                ))}
              </select>
              {!loading && veiculos.length === 0 && (
                <small style={{ color: 'var(--color-text-secondary)', fontSize: '0.75rem', display: 'block', marginTop: '0.25rem' }}>
                  Cadastre veículos antes de criar um MDF-e ou preencha os dados manualmente abaixo
                </small>
              )}
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr 1fr', gap: 'var(--space-4)' }}>
              <div>
                <label className="label label-required">Placa</label>
                <input
                  type="text"
                  className="input"
                  value={dados.infModal?.rodo?.veicTracao?.placa ? formatPlaca(dados.infModal.rodo.veicTracao.placa) : ''}
                  onChange={(e) => atualizarVeiculo('placa', cleanPlaca(e.target.value))}
                  placeholder="ABC-1234"
                  maxLength={8}
                  required
                />
              </div>


              <div>
                <label className="label">UF</label>
                <input
                  type="text"
                  className="input"
                  value={dados.infModal?.rodo?.veicTracao?.UF || ''}
                  onChange={(e) => atualizarVeiculo('UF', e.target.value)}
                  placeholder="SP"
                  maxLength={2}
                />
              </div>

              <div>
                <label className="label label-required">Tara (kg)</label>
                <input
                  type="number"
                  className="input"
                  value={dados.infModal?.rodo?.veicTracao?.tara || ''}
                  onChange={(e) => atualizarVeiculo('tara', e.target.value)}
                  placeholder="Peso vazio"
                  required
                />
              </div>

            </div>
          </div>
        );

      case 'condutor':
        return (
          <div className="card-body">
            <h4>Selecionar Condutor</h4>
            <p className="mb-4" style={{ color: 'var(--color-text-secondary)' }}>
              Selecione o condutor responsável pelo transporte (opcional)
            </p>

            <div className="mb-4">
              <label className="label">Condutor Cadastrado</label>
              <select
                className="input"
                value={selectedCondutorId}
                onChange={(e) => handleCondutorSelect(e.target.value)}
                disabled={loading}
              >
                <option value="">
                  {loading ? 'Carregando condutores...' :
                   condutores.length === 0 ? 'Nenhum condutor cadastrado' :
                   'Selecione um condutor cadastrado...'}
                </option>
                {condutores.map(condutor => (
                  <option key={condutor.id} value={condutor.id}>
                    {condutor.label} - {condutor.description}
                  </option>
                ))}
              </select>
              {!loading && condutores.length === 0 && (
                <small style={{ color: 'var(--color-text-secondary)', fontSize: '0.75rem', display: 'block', marginTop: '0.25rem' }}>
                  Cadastre condutores para facilitar a seleção ou preencha os dados manualmente abaixo
                </small>
              )}
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 'var(--space-4)' }}>
              <div>
                <label className="label">Nome do Condutor</label>
                <input
                  type="text"
                  className="input"
                  value={dados.infModal?.rodo?.veicTracao?.condutor?.[0]?.xNome || ''}
                  onChange={(e) => atualizarSecao('infModal', {
                    ...dados.infModal,
                    rodo: {
                      ...dados.infModal?.rodo,
                      veicTracao: {
                        ...dados.infModal?.rodo?.veicTracao,
                        condutor: [{
                          ...dados.infModal?.rodo?.veicTracao?.condutor?.[0],
                          xNome: e.target.value
                        }]
                      }
                    }
                  })}
                  placeholder="Nome completo do condutor"
                />
              </div>

              <div>
                <label className="label">CPF do Condutor</label>
                <input
                  type="text"
                  className="input"
                  value={dados.infModal?.rodo?.veicTracao?.condutor?.[0]?.CPF ? formatCPF(dados.infModal.rodo.veicTracao.condutor[0].CPF) : ''}
                  onChange={(e) => {
                    const cpf = cleanNumericString(e.target.value);
                    atualizarSecao('infModal', {
                      ...dados.infModal,
                      rodo: {
                        ...dados.infModal?.rodo,
                        veicTracao: {
                          ...dados.infModal?.rodo?.veicTracao,
                          condutor: [{
                            ...dados.infModal?.rodo?.veicTracao?.condutor?.[0],
                            CPF: cpf
                          }]
                        },
                      }
                    });
                  }}
                  placeholder="000.000.000-00"
                  maxLength={14}
                />
              </div>

            </div>

            <div style={{
              marginTop: 'var(--space-4)',
              padding: 'var(--space-4)',
              background: 'var(--color-background-secondary)',
              borderRadius: 'var(--border-radius-lg)',
              border: '1px solid var(--color-border)'
            }}>
              <h6 style={{
                margin: '0 0 0.75rem 0',
                fontSize: '0.9rem',
                fontWeight: '600',
                color: 'var(--color-text-primary)',
                display: 'flex',
                alignItems: 'center',
                gap: '0.5rem'
              }}>
                <Icon name="info-circle" />
                Informações sobre Condutores
              </h6>
              <ul style={{
                margin: 0,
                paddingLeft: '1.5rem',
                color: 'var(--color-text-secondary)',
                fontSize: '0.875rem',
                lineHeight: '1.5'
              }}>
                <li>A informação do condutor é opcional no MDF-e</li>
                <li>Quando informado, deve conter o nome completo e CPF</li>
                <li>Deixe em branco se não se aplica ao seu caso</li>
              </ul>
            </div>
          </div>
        );

      case 'contratante':
        return (
          <div className="card-body">
            <h4>Selecionar Contratante</h4>
            <p className="mb-4" style={{ color: 'var(--color-text-secondary)' }}>
              Selecione o contratante do serviço (opcional)
            </p>

            <div className="mb-4">
              <label className="label">Contratante Cadastrado</label>
              <select
                className="input"
                value={selectedContratanteId}
                onChange={(e) => handleContratanteSelect(e.target.value)}
                disabled={loading}
              >
                <option value="">
                  {loading ? 'Carregando contratantes...' :
                   contratantes.length === 0 ? 'Nenhum contratante cadastrado' :
                   'Selecione um contratante cadastrado...'}
                </option>
                {contratantes.map(contratante => (
                  <option key={contratante.id} value={contratante.id}>
                    {contratante.label} - {contratante.description}
                  </option>
                ))}
              </select>
              {!loading && contratantes.length === 0 && (
                <small style={{ color: 'var(--color-text-secondary)', fontSize: '0.75rem', display: 'block', marginTop: '0.25rem' }}>
                  Cadastre contratantes ou deixe em branco se não se aplica
                </small>
              )}
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 'var(--space-4)' }}>
              <div>
                <label className="label">CNPJ</label>
                <input
                  type="text"
                  className="input"
                  value={dados.contrat?.CNPJ ? formatCNPJ(dados.contrat.CNPJ) : ''}
                  onChange={(e) => atualizarCampo('contrat', 'CNPJ', cleanNumericString(e.target.value))}
                  placeholder="00.000.000/0000-00"
                  maxLength={18}
                />
              </div>

              <div>
                <label className="label">Razão Social</label>
                <input
                  type="text"
                  className="input"
                  value={dados.contrat?.xNome || ''}
                  onChange={(e) => atualizarCampo('contrat', 'xNome', e.target.value)}
                  placeholder="Nome da empresa contratante"
                />
              </div>
            </div>

            <div className="mt-4 p-3" style={{
              backgroundColor: 'var(--color-bg-secondary)',
              borderRadius: 'var(--border-radius-md)',
              border: '1px solid var(--color-border-light)'
            }}>
              <h6 style={{ color: 'var(--color-text-primary)', marginBottom: '0.5rem' }}>ℹ️ Informações sobre Contratante</h6>
              <ul style={{
                margin: 0,
                paddingLeft: '1.2rem',
                color: 'var(--color-text-secondary)',
                fontSize: '0.875rem',
                lineHeight: '1.5'
              }}>
                <li>O contratante é opcional no MDF-e</li>
                <li>Identifica quem contratou o serviço de transporte</li>
                <li>Deixe em branco se não se aplica ao seu caso</li>
              </ul>
            </div>
          </div>
        );

      case 'seguradora':
        return (
          <div className="card-body">
            <h4>Selecionar Seguradora</h4>
            <p className="mb-4" style={{ color: 'var(--color-text-secondary)' }}>
              Selecione a seguradora da carga (opcional)
            </p>

            <div className="mb-4">
              <label className="label">Seguradora Cadastrada</label>
              <select
                className="input"
                value={selectedSeguradoraId}
                onChange={(e) => handleSeguradoraSelect(e.target.value)}
                disabled={loading}
              >
                <option value="">
                  {loading ? 'Carregando seguradoras...' :
                   seguradoras.length === 0 ? 'Nenhuma seguradora cadastrada' :
                   'Selecione uma seguradora cadastrada...'}
                </option>
                {seguradoras.map(seguradora => (
                  <option key={seguradora.id} value={seguradora.id}>
                    {seguradora.label} - {seguradora.description}
                  </option>
                ))}
              </select>
              {!loading && seguradoras.length === 0 && (
                <small style={{ color: 'var(--color-text-secondary)', fontSize: '0.75rem', display: 'block', marginTop: '0.25rem' }}>
                  Cadastre seguradoras ou deixe em branco se não se aplica
                </small>
              )}
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 'var(--space-4)' }}>
              <div>
                <label className="label">CNPJ</label>
                <input
                  type="text"
                  className="input"
                  value={dados.seg?.[0]?.infSeg?.CNPJ ? formatCNPJ(dados.seg[0].infSeg.CNPJ) : ''}
                  onChange={(e) => atualizarSeguradora('CNPJ', cleanNumericString(e.target.value))}
                  placeholder="00.000.000/0000-00"
                  maxLength={18}
                />
              </div>

              <div>
                <label className="label">Razão Social</label>
                <input
                  type="text"
                  className="input"
                  value={dados.seg?.[0]?.infSeg?.xSeg || ''}
                  onChange={(e) => atualizarSeguradora('xSeg', e.target.value)}
                  placeholder="Nome da seguradora"
                />
              </div>
            </div>

            <div className="mt-4 p-3" style={{
              backgroundColor: 'var(--color-bg-secondary)',
              borderRadius: 'var(--border-radius-md)',
              border: '1px solid var(--color-border-light)'
            }}>
              <h6 style={{ color: 'var(--color-text-primary)', marginBottom: '0.5rem' }}>ℹ️ Informações sobre Seguradora</h6>
              <ul style={{
                margin: 0,
                paddingLeft: '1.2rem',
                color: 'var(--color-text-secondary)',
                fontSize: '0.875rem',
                lineHeight: '1.5'
              }}>
                <li>A seguradora é opcional no MDF-e</li>
                <li>Identifica a empresa responsável pelo seguro da carga</li>
                <li>Deixe em branco se não há seguro específico para a carga</li>
              </ul>
            </div>
          </div>
        );

      case 'trajeto':
        return (
          <div className="card-body">
            <LocalidadeSelector
              locais={locaisCarregamento}
              onChange={atualizarLocaisCarregamento}
              title="Locais de Carregamento"
              tipo="carregamento"
            />

            <LocalidadeSelector
              locais={locaisDescarregamento}
              onChange={atualizarLocaisDescarregamento}
              title="Locais de Descarregamento"
              tipo="descarregamento"
              locaisOrigem={locaisCarregamento}
              onRotaChange={(rotaSelecionada) => {
                console.log('🗺️ Rota selecionada no wizard:', rotaSelecionada);
                // Salvar a rota selecionada no estado do MDFe se necessário
              }}
            />
          </div>
        );

      case 'carga':
        return (
          <div className="card-body">
            <h4>Informações da Carga</h4>
            <p className="mb-4" style={{ color: 'var(--color-text-secondary)' }}>
              Configure os totais e características da carga transportada
            </p>

            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr 1fr', gap: 'var(--space-4)' }}>
              <div>
                <label className="label label-required">Valor da Carga (R$)</label>
                <input
                  type="number"
                  step="0.01"
                  className="input"
                  value={dados.tot?.vCarga || ''}
                  onChange={(e) => atualizarCampo('tot', 'vCarga', e.target.value)}
                  placeholder="0,00"
                  required
                />
                <small style={{ color: 'var(--color-text-secondary)', fontSize: '0.75rem' }}>
                  Valor total da mercadoria transportada
                </small>
              </div>

              <div>
                <label className="label label-required">Peso da Carga (kg)</label>
                <input
                  type="number"
                  step="0.001"
                  className="input"
                  value={dados.tot?.qCarga || ''}
                  onChange={(e) => atualizarCampo('tot', 'qCarga', e.target.value)}
                  placeholder="0,000"
                  required
                />
                <small style={{ color: 'var(--color-text-secondary)', fontSize: '0.75rem' }}>
                  Peso bruto total em quilogramas
                </small>
              </div>

              <div>
                <label className="label">Unidade de Medida</label>
                <select
                  className="input"
                  value={dados.tot?.cUnid || '01'}
                  onChange={(e) => atualizarCampo('tot', 'cUnid', e.target.value)}
                >
                  <option value="01">01 - KG (Quilograma)</option>
                  <option value="02">02 - TON (Tonelada)</option>
                  <option value="03">03 - UNID (Unidade)</option>
                  <option value="04">04 - LT (Litro)</option>
                  <option value="05">05 - M3 (Metro Cúbico)</option>
                </select>
              </div>
            </div>


            <div style={{
              marginTop: 'var(--space-6)',
              padding: 'var(--space-4)',
              background: 'var(--color-background-secondary)',
              borderRadius: 'var(--border-radius-lg)',
              border: '1px solid var(--color-border)'
            }}>
              <h6 style={{
                margin: '0 0 0.5rem 0',
                fontSize: '0.9rem',
                fontWeight: '600',
                color: 'var(--color-text-primary)',
                display: 'flex',
                alignItems: 'center',
                gap: '0.5rem'
              }}>
                <Icon name="info-circle" />
                Informações Importantes
              </h6>
              <ul style={{
                margin: 0,
                paddingLeft: '1.5rem',
                color: 'var(--color-text-secondary)',
                fontSize: '0.875rem',
                lineHeight: '1.5'
              }}>
                <li>O valor da carga deve representar o valor total das mercadorias transportadas</li>
                <li>O peso deve ser informado em quilogramas (kg) ou na unidade selecionada</li>
                <li>As quantidades de documentos (CT-e/NF-e) são calculadas automaticamente ao vincular os documentos</li>
                <li>Use a unidade de medida apropriada para o tipo de carga transportada</li>
              </ul>
            </div>
          </div>
        );

      case 'documentos':
        return (
          <div className="card-body">
            <h4>Documentos Vinculados ao MDF-e</h4>
            <p className="mb-4" style={{ color: 'var(--color-text-secondary)' }}>
              Vincule os CT-e e NF-e que serão transportados neste manifesto
            </p>

            {/* Seção CT-e */}
            <div style={{ marginBottom: 'var(--space-6)' }}>
              <h5 style={{
                margin: '0 0 1rem 0',
                fontSize: '1.25rem',
                fontWeight: '700',
                color: 'var(--color-text-primary)',
                display: 'flex',
                alignItems: 'center',
                gap: '0.75rem'
              }}>
                <div style={{
                  width: '40px',
                  height: '40px',
                  background: 'linear-gradient(135deg, #3b82f6, #1d4ed8)',
                  borderRadius: '12px',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  color: 'white'
                }}>
                  <Icon name="file-text" style={{ fontSize: '1.25rem' }} />
                </div>
                Conhecimentos de Transporte (CT-e)
              </h5>

              {/* Campo de entrada direta para CT-e */}
              <div style={{
                background: 'var(--color-background-secondary)',
                border: '2px solid var(--color-border)',
                borderRadius: '12px',
                padding: '1.5rem',
                marginBottom: '1rem'
              }}>
                <div style={{
                  display: 'flex',
                  gap: '1rem',
                  alignItems: 'flex-end'
                }}>
                  <div style={{ flex: 1 }}>
                    <label style={{
                      display: 'block',
                      fontSize: '0.875rem',
                      fontWeight: '600',
                      color: 'var(--color-text-primary)',
                      marginBottom: '0.5rem'
                    }}>
                      Chave de Acesso do CT-e
                    </label>
                    <input
                      type="text"
                      value={cteChave}
                      onChange={(e) => setCteChave(e.target.value.replace(/\D/g, '').slice(0, 44))}
                      placeholder="Digite os 44 dígitos da chave de acesso do CT-e"
                      style={{
                        width: '100%',
                        padding: '0.75rem 1rem',
                        border: `2px solid ${cteChave.length === 44
                          ? '#10b981'
                          : cteChave.length > 0
                            ? '#f59e0b'
                            : 'var(--color-border)'}`,
                        borderRadius: '8px',
                        fontSize: '0.875rem',
                        fontFamily: 'monospace',
                        background: 'var(--color-background)',
                        color: 'var(--color-text-primary)',
                        outline: 'none',
                        transition: 'all 0.2s ease'
                      }}
                      maxLength={44}
                    />
                    <div style={{
                      display: 'flex',
                      justifyContent: 'space-between',
                      alignItems: 'center',
                      marginTop: '0.5rem',
                      fontSize: '0.75rem'
                    }}>
                      <span style={{ color: 'var(--color-text-secondary)' }}>Formato: somente números, 44 dígitos</span>
                      <span style={{
                        fontWeight: '600',
                        color: cteChave.length === 44
                          ? '#10b981'
                          : cteChave.length > 0
                            ? '#f59e0b'
                            : 'var(--color-text-secondary)'
                      }}>
                        {cteChave.length}/44
                      </span>
                    </div>
                  </div>
                  <button
                    onClick={addCTe}
                    disabled={cteChave.length !== 44}
                    style={{
                      padding: '0.75rem 1.5rem',
                      background: cteChave.length === 44
                        ? 'linear-gradient(135deg, #3b82f6, #1d4ed8)'
                        : 'var(--color-border)',
                      color: cteChave.length === 44 ? 'white' : 'var(--color-text-secondary)',
                      border: 'none',
                      borderRadius: '8px',
                      cursor: cteChave.length === 44 ? 'pointer' : 'not-allowed',
                      fontWeight: '600',
                      fontSize: '0.875rem',
                      transition: 'all 0.2s ease',
                      display: 'flex',
                      alignItems: 'center',
                      gap: '0.5rem',
                      opacity: cteChave.length === 44 ? 1 : 0.6,
                      minWidth: '140px'
                    }}
                  >
                    <Icon name="plus" />
                    Adicionar
                  </button>
                </div>
              </div>

              {(() => {
                const cteList = dados.infDoc?.infMunDescarga?.[0]?.infCTe;
                console.log('🔍 [DEBUG] Verificando listagem CTe:', {
                  dados: dados.infDoc,
                  infMunDescarga: dados.infDoc?.infMunDescarga,
                  primeiro: dados.infDoc?.infMunDescarga?.[0],
                  cteList: cteList,
                  temCTe: cteList && cteList.length > 0
                });
                return cteList && cteList.length > 0 ? (
                  <div style={{
                    border: '1px solid var(--color-border)',
                    borderRadius: 'var(--border-radius-lg)',
                    background: 'var(--color-background-secondary)'
                  }}>
                    {cteList.map((cte, index) => (
                      <div key={index} style={{
                        display: 'flex',
                        alignItems: 'center',
                        justifyContent: 'space-between',
                        padding: 'var(--space-4)',
                        borderBottom: index < cteList.length - 1 ? '1px solid var(--color-border)' : 'none'
                      }}>
                      <div style={{ display: 'flex', alignItems: 'center', gap: '1rem' }}>
                        <div style={{
                          width: '32px',
                          height: '32px',
                          background: 'linear-gradient(135deg, #3b82f6, #1d4ed8)',
                          borderRadius: '8px',
                          display: 'flex',
                          alignItems: 'center',
                          justifyContent: 'center',
                          color: 'white'
                        }}>
                          <Icon name="file-text" />
                        </div>
                        <div>
                          <div style={{
                            fontWeight: '600',
                            color: 'var(--color-text-primary)',
                            fontSize: '0.875rem'
                          }}>
                            CT-e {index + 1}
                          </div>
                          <div style={{
                            color: 'var(--color-text-secondary)',
                            fontSize: '0.75rem',
                            fontFamily: 'monospace'
                          }}>
                            {cte.chCTe}
                          </div>
                        </div>
                      </div>
                      <button
                        onClick={() => removeCTe(index)}
                        style={{
                          width: '28px',
                          height: '28px',
                          background: '#ef4444',
                          border: 'none',
                          borderRadius: '6px',
                          color: 'white',
                          cursor: 'pointer',
                          display: 'flex',
                          alignItems: 'center',
                          justifyContent: 'center'
                        }}
                      >
                        🗑️
                      </button>
                      </div>
                    ))}
                  </div>
                ) : (
                  <div style={{
                    border: '2px dashed var(--color-border)',
                    borderRadius: 'var(--border-radius-lg)',
                    padding: 'var(--space-6)',
                    textAlign: 'center',
                    background: 'var(--color-background-secondary)'
                  }}>
                    <div style={{
                      width: '48px',
                      height: '48px',
                      background: 'linear-gradient(135deg, #3b82f6, #1d4ed8)',
                      borderRadius: '50%',
                      display: 'flex',
                      alignItems: 'center',
                      justifyContent: 'center',
                      margin: '0 auto 1rem',
                      color: 'white'
                    }}>
                      <Icon name="file-text" />
                    </div>
                    <h6 style={{
                      margin: '0 0 0.5rem 0',
                      fontSize: '1rem',
                      fontWeight: '600',
                      color: 'var(--color-text-primary)'
                    }}>
                      Nenhum CT-e vinculado
                    </h6>
                    <p style={{
                      margin: '0',
                      color: 'var(--color-text-secondary)',
                      fontSize: '0.875rem'
                    }}>
                      Clique no botão "Adicionar CT-e" para vincular os Conhecimentos de Transporte eletrônicos
                    </p>
                  </div>
                );
              })()}
            </div>

            {/* Seção NF-e */}
            <div style={{ marginBottom: 'var(--space-6)' }}>
              <h5 style={{
                margin: '0 0 1rem 0',
                fontSize: '1.25rem',
                fontWeight: '700',
                color: 'var(--color-text-primary)',
                display: 'flex',
                alignItems: 'center',
                gap: '0.75rem'
              }}>
                <div style={{
                  width: '40px',
                  height: '40px',
                  background: 'linear-gradient(135deg, #10b981, #059669)',
                  borderRadius: '12px',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  color: 'white'
                }}>
                  <Icon name="file-invoice" style={{ fontSize: '1.25rem' }} />
                </div>
                Notas Fiscais eletrônicas (NF-e)
              </h5>

              {/* Campo de entrada direta para NF-e */}
              <div style={{
                background: 'var(--color-background-secondary)',
                border: '2px solid var(--color-border)',
                borderRadius: '12px',
                padding: '1.5rem',
                marginBottom: '1rem'
              }}>
                <div style={{
                  display: 'flex',
                  gap: '1rem',
                  alignItems: 'flex-end'
                }}>
                  <div style={{ flex: 1 }}>
                    <label style={{
                      display: 'block',
                      fontSize: '0.875rem',
                      fontWeight: '600',
                      color: 'var(--color-text-primary)',
                      marginBottom: '0.5rem'
                    }}>
                      Chave de Acesso da NF-e
                    </label>
                    <input
                      type="text"
                      value={nfeChave}
                      onChange={(e) => setNfeChave(e.target.value.replace(/\D/g, '').slice(0, 44))}
                      placeholder="Digite os 44 dígitos da chave de acesso"
                      style={{
                        width: '100%',
                        padding: '0.75rem 1rem',
                        border: `2px solid ${nfeChave.length === 44
                          ? '#10b981'
                          : nfeChave.length > 0
                            ? '#f59e0b'
                            : 'var(--color-border)'}`,
                        borderRadius: '8px',
                        fontSize: '0.875rem',
                        fontFamily: 'monospace',
                        background: 'var(--color-background)',
                        color: 'var(--color-text-primary)',
                        outline: 'none',
                        transition: 'all 0.2s ease'
                      }}
                      maxLength={44}
                    />
                    <div style={{
                      display: 'flex',
                      justifyContent: 'space-between',
                      alignItems: 'center',
                      marginTop: '0.5rem',
                      fontSize: '0.75rem'
                    }}>
                      <span style={{ color: 'var(--color-text-secondary)' }}>Formato: somente números, 44 dígitos</span>
                      <span style={{
                        fontWeight: '600',
                        color: nfeChave.length === 44
                          ? '#10b981'
                          : nfeChave.length > 0
                            ? '#f59e0b'
                            : 'var(--color-text-secondary)'
                      }}>
                        {nfeChave.length}/44
                      </span>
                    </div>
                  </div>
                  <button
                    onClick={addNFe}
                    disabled={nfeChave.length !== 44}
                    style={{
                      padding: '0.75rem 1.5rem',
                      background: nfeChave.length === 44
                        ? 'linear-gradient(135deg, #10b981, #059669)'
                        : 'var(--color-border)',
                      color: nfeChave.length === 44 ? 'white' : 'var(--color-text-secondary)',
                      border: 'none',
                      borderRadius: '8px',
                      cursor: nfeChave.length === 44 ? 'pointer' : 'not-allowed',
                      fontWeight: '600',
                      fontSize: '0.875rem',
                      transition: 'all 0.2s ease',
                      display: 'flex',
                      alignItems: 'center',
                      gap: '0.5rem',
                      opacity: nfeChave.length === 44 ? 1 : 0.6,
                      minWidth: '140px'
                    }}
                  >
                    <Icon name="plus" />
                    Adicionar
                  </button>
                </div>
              </div>

              {(() => {
                const nfeList = dados.infDoc?.infMunDescarga?.[0]?.infNFe;
                return nfeList && nfeList.length > 0 ? (
                  <div style={{
                    border: '1px solid var(--color-border)',
                    borderRadius: 'var(--border-radius-lg)',
                    background: 'var(--color-background-secondary)'
                  }}>
                    {nfeList.map((nfe, index) => (
                      <div key={index} style={{
                        display: 'flex',
                        alignItems: 'center',
                        justifyContent: 'space-between',
                        padding: 'var(--space-4)',
                        borderBottom: index < nfeList.length - 1 ? '1px solid var(--color-border)' : 'none'
                      }}>
                      <div style={{ display: 'flex', alignItems: 'center', gap: '1rem' }}>
                        <div style={{
                          width: '32px',
                          height: '32px',
                          background: 'linear-gradient(135deg, #10b981, #059669)',
                          borderRadius: '8px',
                          display: 'flex',
                          alignItems: 'center',
                          justifyContent: 'center',
                          color: 'white'
                        }}>
                          <Icon name="file-invoice" />
                        </div>
                        <div>
                          <div style={{
                            fontWeight: '600',
                            color: 'var(--color-text-primary)',
                            fontSize: '0.875rem'
                          }}>
                            NF-e {index + 1}
                          </div>
                          <div style={{
                            color: 'var(--color-text-secondary)',
                            fontSize: '0.75rem',
                            fontFamily: 'monospace'
                          }}>
                            {nfe.chNFe}
                          </div>
                        </div>
                      </div>
                      <button
                        onClick={() => removeNFe(index)}
                        style={{
                          width: '28px',
                          height: '28px',
                          background: '#ef4444',
                          border: 'none',
                          borderRadius: '6px',
                          color: 'white',
                          cursor: 'pointer',
                          display: 'flex',
                          alignItems: 'center',
                          justifyContent: 'center'
                        }}
                      >
                        🗑️
                        </button>
                      </div>
                    ))}
                  </div>
                ) : (
                  <div style={{
                    border: '2px dashed var(--color-border)',
                    borderRadius: 'var(--border-radius-lg)',
                    padding: 'var(--space-6)',
                    textAlign: 'center',
                    background: 'var(--color-background-secondary)'
                  }}>
                    <div style={{
                      width: '48px',
                      height: '48px',
                      background: 'linear-gradient(135deg, #10b981, #059669)',
                      borderRadius: '50%',
                      display: 'flex',
                      alignItems: 'center',
                      justifyContent: 'center',
                      margin: '0 auto 1rem',
                      color: 'white'
                    }}>
                      <Icon name="file-invoice" />
                    </div>
                    <h6 style={{
                      margin: '0 0 0.5rem 0',
                      fontSize: '1rem',
                      fontWeight: '600',
                      color: 'var(--color-text-primary)'
                    }}>
                      Nenhuma NF-e vinculada
                    </h6>
                    <p style={{
                      margin: '0',
                      color: 'var(--color-text-secondary)',
                      fontSize: '0.875rem'
                    }}>
                      Clique no botão "Adicionar NF-e" para vincular as Notas Fiscais eletrônicas
                    </p>
                  </div>
                );
              })()}
            </div>

            {/* Informações importantes */}
            <div style={{
              background: 'linear-gradient(135deg, rgba(59, 130, 246, 0.1), rgba(16, 185, 129, 0.1))',
              border: '2px solid rgba(59, 130, 246, 0.2)',
              borderRadius: '16px',
              padding: '2rem',
              position: 'relative',
              overflow: 'hidden'
            }}>
              {/* Background pattern */}
              <div style={{
                position: 'absolute',
                top: 0,
                right: 0,
                width: '100px',
                height: '100px',
                background: 'radial-gradient(circle, rgba(59, 130, 246, 0.1) 0%, transparent 70%)',
                borderRadius: '50%',
                transform: 'translate(25%, -25%)'
              }} />

              <div style={{
                display: 'flex',
                alignItems: 'center',
                gap: '1rem',
                marginBottom: '1.5rem'
              }}>
                <div style={{
                  width: '48px',
                  height: '48px',
                  background: 'linear-gradient(135deg, #3b82f6, #10b981)',
                  borderRadius: '12px',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  color: 'white'
                }}>
                  <Icon name="lightbulb" style={{ fontSize: '1.5rem' }} />
                </div>
                <div>
                  <h6 style={{
                    margin: 0,
                    fontSize: '1.25rem',
                    fontWeight: '700',
                    color: 'var(--color-text-primary)'
                  }}>
                    Como funciona a adição de documentos?
                  </h6>
                  <p style={{
                    margin: 0,
                    fontSize: '0.875rem',
                    color: 'var(--color-text-secondary)'
                  }}>
                    Sistema inteligente com distribuição automática
                  </p>
                </div>
              </div>

              <div style={{
                display: 'grid',
                gridTemplateColumns: 'repeat(auto-fit, minmax(280px, 1fr))',
                gap: '1.5rem',
                position: 'relative'
              }}>
                <div>
                  <h6 style={{
                    margin: '0 0 1rem 0',
                    fontSize: '1rem',
                    fontWeight: '600',
                    color: '#3b82f6',
                    display: 'flex',
                    alignItems: 'center',
                    gap: '0.5rem'
                  }}>
                    <Icon name="file-text" />
                    CT-e (Conhecimento de Transporte)
                  </h6>
                  <ul style={{
                    margin: 0,
                    paddingLeft: '1.5rem',
                    color: 'var(--color-text-secondary)',
                    fontSize: '0.875rem',
                    lineHeight: '1.6'
                  }}>
                    <li>Para transporte de cargas de terceiros</li>
                    <li>Distribuição automática entre locais de descarga</li>
                    <li>Validação automática da chave (44 dígitos)</li>
                  </ul>
                </div>

                <div>
                  <h6 style={{
                    margin: '0 0 1rem 0',
                    fontSize: '1rem',
                    fontWeight: '600',
                    color: '#10b981',
                    display: 'flex',
                    alignItems: 'center',
                    gap: '0.5rem'
                  }}>
                    <Icon name="file-invoice" />
                    NF-e (Nota Fiscal eletrônica)
                  </h6>
                  <ul style={{
                    margin: 0,
                    paddingLeft: '1.5rem',
                    color: 'var(--color-text-secondary)',
                    fontSize: '0.875rem',
                    lineHeight: '1.6'
                  }}>
                    <li>Para mercadorias próprias ou remetidas</li>
                    <li>Cálculo automático de valores e totais</li>
                    <li>Apenas um tipo de documento é obrigatório</li>
                  </ul>
                </div>
              </div>

              <div style={{
                marginTop: '1.5rem',
                padding: '1rem',
                background: 'rgba(16, 185, 129, 0.1)',
                borderRadius: '8px',
                border: '1px solid rgba(16, 185, 129, 0.2)'
              }}>
                <p style={{
                  margin: 0,
                  fontSize: '0.875rem',
                  color: 'var(--color-text-primary)',
                  fontWeight: '600',
                  display: 'flex',
                  alignItems: 'center',
                  gap: '0.5rem'
                }}>
                  <Icon name="check-circle" style={{ color: '#10b981' }} />
                  Você só precisa informar CT-e OU NF-e, não os dois!
                </p>
              </div>
            </div>
          </div>
        );

      case 'resumo':
        return (
          <div style={{
            padding: '2rem 3rem',
            background: 'var(--color-background)',
            width: '100%',
            minHeight: '100vh'
          }}>

            {/* Status Geral */}
            <div style={{
              background: todasSecoesCompletas
                ? 'linear-gradient(135deg, rgba(16, 185, 129, 0.1), rgba(5, 150, 105, 0.05))'
                : 'linear-gradient(135deg, rgba(239, 68, 68, 0.1), rgba(220, 38, 38, 0.05))',
              border: `3px solid ${todasSecoesCompletas ? '#10b981' : '#ef4444'}`,
              borderRadius: '16px',
              padding: '2.5rem',
              marginBottom: '3rem',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'space-between'
            }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: '1rem' }}>
                <Icon name={todasSecoesCompletas ? 'check-circle' : 'alert-triangle'}
                      style={{
                        fontSize: '2rem',
                        color: todasSecoesCompletas ? '#10b981' : '#ef4444'
                      }} />
                <div>
                  <h3 style={{
                    margin: '0 0 0.25rem 0',
                    fontSize: '1.25rem',
                    fontWeight: '700',
                    color: 'var(--color-text-primary)'
                  }}>
                    {todasSecoesCompletas ? 'Documento Pronto para Emissão' : 'Documento com Pendências'}
                  </h3>
                  <p style={{
                    margin: '0',
                    fontSize: '0.875rem',
                    color: 'var(--color-text-secondary)'
                  }}>
                    {todasSecoesCompletas
                      ? 'Todas as seções foram preenchidas corretamente'
                      : 'Complete as seções pendentes para prosseguir com a emissão'
                    }
                  </p>
                </div>
              </div>
              <div style={{
                background: todasSecoesCompletas ? '#10b981' : '#ef4444',
                color: 'white',
                padding: '0.5rem 1rem',
                borderRadius: '8px',
                fontSize: '0.875rem',
                fontWeight: '600'
              }}>
                {todasSecoesCompletas ? 'PRONTO' : 'PENDENTE'}
              </div>
            </div>

            {/* Tabela de Resumo */}
            <div style={{
              background: 'var(--color-background)',
              border: '3px solid var(--color-border)',
              borderRadius: '16px',
              overflow: 'hidden',
              marginBottom: '3rem',
              boxShadow: '0 4px 20px rgba(0, 0, 0, 0.05)'
            }}>
              <div style={{
                background: 'linear-gradient(135deg, var(--color-background-secondary), rgba(59, 130, 246, 0.05))',
                padding: '1.5rem 2rem',
                borderBottom: '2px solid var(--color-border)',
                display: 'flex',
                alignItems: 'center',
                gap: '1rem'
              }}>
                <Icon name="clipboard-list" style={{ fontSize: '1.5rem', color: 'var(--color-text-primary)' }} />
                <h3 style={{
                  margin: '0',
                  fontSize: '1.375rem',
                  fontWeight: '700',
                  color: 'var(--color-text-primary)'
                }}>
                  Resumo Detalhado das Informações
                </h3>
              </div>

              <div style={{ padding: '2.5rem' }}>
                <div style={{
                  display: 'grid',
                  gridTemplateColumns: '1fr 1fr',
                  gap: '3rem'
                }}>
                  {/* Coluna 1 - Documento e Emitente */}
                  <div>
                    <div style={{ marginBottom: '1.5rem' }}>
                      <h4 style={{
                        margin: '0 0 0.75rem 0',
                        fontSize: '1rem',
                        fontWeight: '600',
                        color: 'var(--color-text-primary)',
                        display: 'flex',
                        alignItems: 'center',
                        gap: '0.5rem'
                      }}>
                        <Icon name="file-text" style={{ fontSize: '1rem' }} />
                        Documento
                      </h4>
                      <div style={{ paddingLeft: '1.5rem', fontSize: '0.875rem' }}>
                        <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '0.25rem' }}>
                          <span style={{ color: 'var(--color-text-secondary)' }}>Série:</span>
                          <span style={{ fontWeight: '600', color: 'var(--color-text-primary)' }}>{dados.ide?.serie || '1'}</span>
                        </div>
                        <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '0.25rem' }}>
                          <span style={{ color: 'var(--color-text-secondary)' }}>Número:</span>
                          <span style={{ fontWeight: '600', color: 'var(--color-text-primary)' }}>{dados.ide?.nMDF || 'Auto'}</span>
                        </div>
                        <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '0.25rem' }}>
                          <span style={{ color: 'var(--color-text-secondary)' }}>Ambiente:</span>
                          <span style={{
                            fontWeight: '600',
                            color: dados.ide?.tpAmb === '1' ? '#dc2626' : '#f59e0b'
                          }}>
                            {dados.ide?.tpAmb === '1' ? 'Produção' : 'Homologação'}
                          </span>
                        </div>
                      </div>
                    </div>

                    <div>
                      <h4 style={{
                        margin: '0 0 0.75rem 0',
                        fontSize: '1rem',
                        fontWeight: '600',
                        color: 'var(--color-text-primary)',
                        display: 'flex',
                        alignItems: 'center',
                        gap: '0.5rem'
                      }}>
                        <Icon name="building" style={{ fontSize: '1rem' }} />
                        Emitente
                      </h4>
                      <div style={{ paddingLeft: '1.5rem', fontSize: '0.875rem' }}>
                        <div style={{ fontWeight: '600', marginBottom: '0.5rem', color: 'var(--color-text-primary)' }}>
                          {dados.emit?.xNome || 'Não informado'}
                        </div>
                        <div style={{ color: 'var(--color-text-secondary)', marginBottom: '0.25rem' }}>
                          CNPJ: {dados.emit?.CNPJ ?
                            dados.emit.CNPJ.replace(/(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})/, '$1.$2.$3/$4-$5')
                            : 'Não informado'}
                        </div>
                        <div style={{ color: 'var(--color-text-secondary)' }}>
                          IE: {dados.emit?.IE || 'Não informado'}
                        </div>
                      </div>
                    </div>
                  </div>

                  {/* Coluna 2 - Transporte e Percurso */}
                  <div>
                    <div style={{ marginBottom: '1.5rem' }}>
                      <h4 style={{
                        margin: '0 0 0.75rem 0',
                        fontSize: '1rem',
                        fontWeight: '600',
                        color: 'var(--color-text-primary)',
                        display: 'flex',
                        alignItems: 'center',
                        gap: '0.5rem'
                      }}>
                        <Icon name="truck" style={{ fontSize: '1rem' }} />
                        Transporte
                      </h4>
                      <div style={{ paddingLeft: '1.5rem', fontSize: '0.875rem' }}>
                        <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '0.25rem' }}>
                          <span style={{ color: 'var(--color-text-secondary)' }}>Veículo:</span>
                          <span style={{ fontWeight: '600', color: 'var(--color-text-primary)' }}>
                            {dados.infModal?.rodo?.veicTracao?.placa || 'Não informado'}
                          </span>
                        </div>
                        <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '0.25rem' }}>
                          <span style={{ color: 'var(--color-text-secondary)' }}>Condutor:</span>
                          <span style={{ fontWeight: '600', color: 'var(--color-text-primary)' }}>
                            {dados.infModal?.rodo?.veicTracao?.condutor?.[0]?.xNome || 'Não informado'}
                          </span>
                        </div>
                      </div>
                    </div>

                    <div>
                      <h4 style={{
                        margin: '0 0 0.75rem 0',
                        fontSize: '1rem',
                        fontWeight: '600',
                        color: 'var(--color-text-primary)',
                        display: 'flex',
                        alignItems: 'center',
                        gap: '0.5rem'
                      }}>
                        <Icon name="map-pin" style={{ fontSize: '1rem' }} />
                        Percurso
                      </h4>
                      <div style={{ paddingLeft: '1.5rem', fontSize: '0.875rem' }}>
                        <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '0.25rem' }}>
                          <span style={{ color: 'var(--color-text-secondary)' }}>UF Início:</span>
                          <span style={{ fontWeight: '600', color: 'var(--color-text-primary)' }}>
                            {dados.ide?.UFIni || 'Não informado'}
                          </span>
                        </div>
                        <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '0.25rem' }}>
                          <span style={{ color: 'var(--color-text-secondary)' }}>UF Fim:</span>
                          <span style={{ fontWeight: '600', color: 'var(--color-text-primary)' }}>
                            {dados.ide?.UFFim || 'Não informado'}
                          </span>
                        </div>
                        <div style={{ display: 'flex', justifyContent: 'space-between' }}>
                          <span style={{ color: 'var(--color-text-secondary)' }}>Estados no percurso:</span>
                          <span style={{ fontWeight: '600', color: 'var(--color-text-primary)' }}>
                            {dados.ide?.infPercurso?.length || 0}
                          </span>
                        </div>
                      </div>
                    </div>
                  </div>

                  {/* Coluna 3 - Informações Adicionais */}
                  <div>
                    <div style={{ marginBottom: '1.5rem' }}>
                      <h4 style={{
                        margin: '0 0 0.75rem 0',
                        fontSize: '1rem',
                        fontWeight: '600',
                        color: 'var(--color-text-primary)',
                        display: 'flex',
                        alignItems: 'center',
                        gap: '0.5rem'
                      }}>
                        <Icon name="calendar" style={{ fontSize: '1rem' }} />
                        Data e Hora
                      </h4>
                      <div style={{ paddingLeft: '1.5rem', fontSize: '0.875rem' }}>
                        <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '0.25rem' }}>
                          <span style={{ color: 'var(--color-text-secondary)' }}>Emissão:</span>
                          <span style={{ fontWeight: '600', color: 'var(--color-text-primary)' }}>
                            {dados.ide?.dhEmi ? new Date(dados.ide.dhEmi).toLocaleString('pt-BR') : 'Automático'}
                          </span>
                        </div>
                        <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '0.25rem' }}>
                          <span style={{ color: 'var(--color-text-secondary)' }}>Início Viagem:</span>
                          <span style={{ fontWeight: '600', color: 'var(--color-text-primary)' }}>
                            {dados.ide?.dhIniViagem ? new Date(dados.ide.dhIniViagem).toLocaleString('pt-BR') : 'Data da emissão'}
                          </span>
                        </div>
                      </div>
                    </div>

                    <div style={{ marginBottom: '1.5rem' }}>
                      <h4 style={{
                        margin: '0 0 0.75rem 0',
                        fontSize: '1rem',
                        fontWeight: '600',
                        color: 'var(--color-text-primary)',
                        display: 'flex',
                        alignItems: 'center',
                        gap: '0.5rem'
                      }}>
                        <Icon name="map-pin" style={{ fontSize: '1rem' }} />
                        Locais de Carga
                      </h4>
                      <div style={{ paddingLeft: '1.5rem', fontSize: '0.875rem' }}>
                        {dados.ide?.infMunCarrega && dados.ide.infMunCarrega.length > 0 ? (
                          dados.ide.infMunCarrega.map((local, index) => (
                            <div key={index} style={{ marginBottom: '0.5rem' }}>
                              <div style={{ fontWeight: '600', color: 'var(--color-text-primary)' }}>
                                {local.xMunCarrega || 'Município não informado'}
                              </div>
                              <div style={{ color: 'var(--color-text-secondary)', fontSize: '0.8rem' }}>
                                {local.uf ? `${local.uf}` : ''} {local.cMunCarrega ? `(${local.cMunCarrega})` : ''}
                              </div>
                            </div>
                          ))
                        ) : (
                          <div style={{ color: 'var(--color-text-secondary)' }}>
                            Nenhum local de carregamento definido
                          </div>
                        )}
                      </div>
                    </div>

                    <div>
                      <h4 style={{
                        margin: '0 0 0.75rem 0',
                        fontSize: '1rem',
                        fontWeight: '600',
                        color: 'var(--color-text-primary)',
                        display: 'flex',
                        alignItems: 'center',
                        gap: '0.5rem'
                      }}>
                        <Icon name="target" style={{ fontSize: '1rem' }} />
                        Locais de Descarga
                      </h4>
                      <div style={{ paddingLeft: '1.5rem', fontSize: '0.875rem' }}>
                        {dados.infDoc?.infMunDescarga && dados.infDoc.infMunDescarga.length > 0 ? (
                          dados.infDoc.infMunDescarga.map((local, index) => (
                            <div key={index} style={{ marginBottom: '0.5rem' }}>
                              <div style={{ fontWeight: '600', color: 'var(--color-text-primary)' }}>
                                {local.xMunDescarga || 'Município não informado'}
                              </div>
                              <div style={{ color: 'var(--color-text-secondary)', fontSize: '0.8rem' }}>
                                {local.uf ? `${local.uf}` : ''} {local.cMunDescarga ? `(${local.cMunDescarga})` : ''}
                              </div>
                            </div>
                          ))
                        ) : (
                          <div style={{ color: 'var(--color-text-secondary)' }}>
                            Nenhum local de descarregamento definido
                          </div>
                        )}
                      </div>
                    </div>
                  </div>
                </div>

              </div>
            </div>

            {/* Documentos Fiscais */}
            <div style={{
              background: 'var(--color-background)',
              border: '2px solid var(--color-border)',
              borderRadius: '12px',
              overflow: 'hidden',
              marginBottom: '2rem'
            }}>
              <div style={{
                background: 'linear-gradient(135deg, #3b82f6, #1d4ed8)',
                padding: '1rem 1.5rem',
                color: 'white',
                display: 'flex',
                alignItems: 'center',
                gap: '0.75rem'
              }}>
                <Icon name="folder-open" style={{ fontSize: '1.25rem' }} />
                <h3 style={{
                  margin: '0',
                  fontSize: '1.125rem',
                  fontWeight: '700'
                }}>
                  Documentos Fiscais Vinculados
                </h3>
              </div>

              <div style={{ padding: '1.5rem' }}>
                <div style={{
                  display: 'grid',
                  gridTemplateColumns: 'repeat(3, 1fr)',
                  gap: '2rem'
                }}>
                  {/* CT-e */}
                  <div style={{
                    background: 'linear-gradient(135deg, rgba(59, 130, 246, 0.1), rgba(29, 78, 216, 0.05))',
                    border: '2px solid rgba(59, 130, 246, 0.2)',
                    borderRadius: '12px',
                    padding: '1.5rem',
                    textAlign: 'center',
                    position: 'relative',
                    overflow: 'hidden'
                  }}>
                    <div style={{
                      position: 'absolute',
                      top: '-10px',
                      right: '-10px',
                      width: '60px',
                      height: '60px',
                      background: 'radial-gradient(circle, rgba(59, 130, 246, 0.1) 0%, transparent 70%)',
                      borderRadius: '50%'
                    }} />
                    <div style={{
                      width: '56px',
                      height: '56px',
                      background: 'linear-gradient(135deg, #3b82f6, #1d4ed8)',
                      borderRadius: '14px',
                      display: 'flex',
                      alignItems: 'center',
                      justifyContent: 'center',
                      margin: '0 auto 1rem',
                      color: 'white',
                      boxShadow: '0 4px 12px rgba(59, 130, 246, 0.3)',
                      position: 'relative'
                    }}>
                      <Icon name="file-text" style={{ fontSize: '1.75rem' }} />
                    </div>
                    <div style={{
                      fontSize: '2rem',
                      fontWeight: '800',
                      color: '#3b82f6',
                      marginBottom: '0.25rem',
                      position: 'relative'
                    }}>
                      {dados.tot?.qCTe || '0'}
                    </div>
                    <div style={{
                      fontSize: '0.875rem',
                      color: 'var(--color-text-primary)',
                      fontWeight: '600'
                    }}>
                      Conhecimentos de Transporte
                    </div>
                    <div style={{
                      fontSize: '0.75rem',
                      color: 'var(--color-text-secondary)',
                      marginTop: '0.25rem'
                    }}>
                      CT-e
                    </div>
                  </div>

                  {/* NF-e */}
                  <div style={{
                    background: 'linear-gradient(135deg, rgba(16, 185, 129, 0.1), rgba(5, 150, 105, 0.05))',
                    border: '2px solid rgba(16, 185, 129, 0.2)',
                    borderRadius: '12px',
                    padding: '1.5rem',
                    textAlign: 'center',
                    position: 'relative',
                    overflow: 'hidden'
                  }}>
                    <div style={{
                      position: 'absolute',
                      top: '-10px',
                      right: '-10px',
                      width: '60px',
                      height: '60px',
                      background: 'radial-gradient(circle, rgba(16, 185, 129, 0.1) 0%, transparent 70%)',
                      borderRadius: '50%'
                    }} />
                    <div style={{
                      width: '56px',
                      height: '56px',
                      background: 'linear-gradient(135deg, #10b981, #059669)',
                      borderRadius: '14px',
                      display: 'flex',
                      alignItems: 'center',
                      justifyContent: 'center',
                      margin: '0 auto 1rem',
                      color: 'white',
                      boxShadow: '0 4px 12px rgba(16, 185, 129, 0.3)',
                      position: 'relative'
                    }}>
                      <Icon name="file-invoice" style={{ fontSize: '1.75rem' }} />
                    </div>
                    <div style={{
                      fontSize: '2rem',
                      fontWeight: '800',
                      color: '#10b981',
                      marginBottom: '0.25rem',
                      position: 'relative'
                    }}>
                      {dados.tot?.qNFe || '0'}
                    </div>
                    <div style={{
                      fontSize: '0.875rem',
                      color: 'var(--color-text-primary)',
                      fontWeight: '600'
                    }}>
                      Notas Fiscais Eletrônicas
                    </div>
                    <div style={{
                      fontSize: '0.75rem',
                      color: 'var(--color-text-secondary)',
                      marginTop: '0.25rem'
                    }}>
                      NF-e
                    </div>
                  </div>

                  {/* Valor Total */}
                  <div style={{
                    background: 'linear-gradient(135deg, rgba(139, 92, 246, 0.1), rgba(124, 58, 237, 0.05))',
                    border: '2px solid rgba(139, 92, 246, 0.2)',
                    borderRadius: '12px',
                    padding: '1.5rem',
                    textAlign: 'center',
                    position: 'relative',
                    overflow: 'hidden'
                  }}>
                    <div style={{
                      position: 'absolute',
                      top: '-10px',
                      right: '-10px',
                      width: '60px',
                      height: '60px',
                      background: 'radial-gradient(circle, rgba(139, 92, 246, 0.1) 0%, transparent 70%)',
                      borderRadius: '50%'
                    }} />
                    <div style={{
                      width: '56px',
                      height: '56px',
                      background: 'linear-gradient(135deg, #8b5cf6, #7c3aed)',
                      borderRadius: '14px',
                      display: 'flex',
                      alignItems: 'center',
                      justifyContent: 'center',
                      margin: '0 auto 1rem',
                      color: 'white',
                      boxShadow: '0 4px 12px rgba(139, 92, 246, 0.3)',
                      position: 'relative'
                    }}>
                      <Icon name="dollar-sign" style={{ fontSize: '1.75rem' }} />
                    </div>
                    <div style={{
                      fontSize: '1.5rem',
                      fontWeight: '800',
                      color: '#8b5cf6',
                      marginBottom: '0.25rem',
                      position: 'relative'
                    }}>
                      R$ {parseFloat(dados.tot?.vCarga || '0').toLocaleString('pt-BR', {
                        minimumFractionDigits: 2,
                        maximumFractionDigits: 2
                      })}
                    </div>
                    <div style={{
                      fontSize: '0.875rem',
                      color: 'var(--color-text-primary)',
                      fontWeight: '600'
                    }}>
                      Valor Total da Carga
                    </div>
                    <div style={{
                      fontSize: '0.75rem',
                      color: 'var(--color-text-secondary)',
                      marginTop: '0.25rem'
                    }}>
                      Mercadorias transportadas
                    </div>
                  </div>
                </div>
              </div>
            </div>

            {/* Chaves dos Documentos Fiscais */}
            {(dados.infDoc?.infMunDescarga && dados.infDoc.infMunDescarga.length > 0 &&
              dados.infDoc.infMunDescarga.some(mun =>
                (mun.infCTe && mun.infCTe.length > 0) || (mun.infNFe && mun.infNFe.length > 0)
              )) && (
              <div style={{
                background: 'var(--color-background)',
                border: '3px solid var(--color-border)',
                borderRadius: '16px',
                overflow: 'hidden',
                marginBottom: '3rem',
                boxShadow: '0 4px 20px rgba(0, 0, 0, 0.05)'
              }}>
                <div style={{
                  background: 'linear-gradient(135deg, #10b981, #059669)',
                  padding: '1.5rem 2rem',
                  color: 'white',
                  display: 'flex',
                  alignItems: 'center',
                  gap: '1rem'
                }}>
                  <Icon name="key" style={{ fontSize: '1.5rem' }} />
                  <h3 style={{
                    margin: '0',
                    fontSize: '1.375rem',
                    fontWeight: '700'
                  }}>
                    Chaves de Acesso dos Documentos
                  </h3>
                </div>

                <div style={{ padding: '2.5rem' }}>

                  <div style={{ display: 'flex', flexDirection: 'column', gap: '2rem' }}>
                    {/* Documentos organizados por município de descarga */}
                    {dados.infDoc?.infMunDescarga && dados.infDoc.infMunDescarga.length > 0 ? dados.infDoc.infMunDescarga.map((municipio, munIndex) => (
                      <div key={munIndex}>
                        {/* Header do Município de Descarga */}
                        <div style={{
                          background: 'linear-gradient(135deg, rgba(59, 130, 246, 0.1), rgba(29, 78, 216, 0.05))',
                          border: '2px solid rgba(59, 130, 246, 0.2)',
                          borderRadius: '12px',
                          padding: '1.5rem',
                          marginBottom: '1.5rem',
                          display: 'flex',
                          alignItems: 'center',
                          gap: '1rem'
                        }}>
                          <Icon name="map-pin" style={{ fontSize: '1.5rem', color: '#3b82f6' }} />
                          <div>
                            <h4 style={{
                              margin: '0 0 0.25rem 0',
                              fontSize: '1.25rem',
                              fontWeight: '700',
                              color: 'var(--color-text-primary)'
                            }}>
                              {municipio.xMunDescarga?.trim() && municipio.uf?.trim()
                                ? `${municipio.xMunDescarga} - ${municipio.uf}`
                                : municipio.xMunDescarga?.trim() || municipio.uf?.trim()
                                  ? `${municipio.xMunDescarga?.trim() || 'Município não informado'} - ${municipio.uf?.trim() || 'UF não informada'}`
                                  : 'Município de Descarga não informado'
                              }
                            </h4>
                            <div style={{
                              fontSize: '0.875rem',
                              color: 'var(--color-text-secondary)'
                            }}>
                              {municipio.cMunDescarga?.trim()
                                ? `Código: ${municipio.cMunDescarga}`
                                : 'Código do município não informado'
                              }
                            </div>
                          </div>
                        </div>

                        <div style={{
                          display: 'grid',
                          gridTemplateColumns: 'repeat(auto-fit, minmax(400px, 1fr))',
                          gap: '2rem'
                        }}>
                          {/* CT-es deste município */}
                          {municipio.infCTe && municipio.infCTe.length > 0 && (
                            <div>
                              <h4 style={{
                                margin: '0 0 1rem 0',
                                fontSize: '1.125rem',
                                fontWeight: '600',
                                color: 'var(--color-text-primary)',
                                display: 'flex',
                                alignItems: 'center',
                                gap: '0.5rem'
                              }}>
                                <Icon name="file-text" style={{ fontSize: '1.125rem', color: '#3b82f6' }} />
                                CT-es para {municipio.uf?.trim() || 'UF não informada'} ({municipio.infCTe.length})
                              </h4>
                              <div style={{
                                background: 'rgba(59, 130, 246, 0.05)',
                                borderRadius: '12px',
                                padding: '1rem',
                                border: '1px solid rgba(59, 130, 246, 0.1)'
                              }}>
                                {municipio.infCTe.map((cte, index) => (
                                  <div key={index} style={{
                                    padding: '0.75rem 0',
                                    borderBottom: index < (municipio.infCTe?.length || 0) - 1 ? '1px solid rgba(59, 130, 246, 0.1)' : 'none'
                                  }}>
                                    <div style={{
                                      display: 'flex',
                                      justifyContent: 'space-between',
                                      alignItems: 'center',
                                      marginBottom: '0.5rem'
                                    }}>
                                      <div style={{
                                        fontSize: '0.875rem',
                                        fontWeight: '600',
                                        color: '#3b82f6'
                                      }}>
                                        CT-e {index + 1}
                                      </div>
                                      <div style={{
                                        fontSize: '0.75rem',
                                        fontWeight: '600',
                                        color: 'white',
                                        background: '#3b82f6',
                                        padding: '0.25rem 0.5rem',
                                        borderRadius: '4px'
                                      }}>
                                        Destino: {municipio.uf?.trim() || 'UF não informada'}
                                      </div>
                                    </div>
                                    <div style={{
                                      fontSize: '0.8rem',
                                      fontFamily: 'monospace',
                                      color: 'var(--color-text-primary)',
                                      background: 'var(--color-background)',
                                      padding: '0.5rem',
                                      borderRadius: '6px',
                                      border: '1px solid rgba(59, 130, 246, 0.2)',
                                      wordBreak: 'break-all'
                                    }}>
                                      {cte.chCTe}
                                    </div>
                                    {cte.vCarga && (
                                      <div style={{
                                        fontSize: '0.75rem',
                                        color: 'var(--color-text-secondary)',
                                        marginTop: '0.25rem'
                                      }}>
                                        Valor: R$ {parseFloat(cte.vCarga).toLocaleString('pt-BR', {
                                          minimumFractionDigits: 2,
                                          maximumFractionDigits: 2
                                        })}
                                      </div>
                                    )}
                                  </div>
                                ))}
                              </div>
                            </div>
                          )}

                          {/* NF-es deste município */}
                          {municipio.infNFe && municipio.infNFe.length > 0 && (
                            <div>
                              <h4 style={{
                                margin: '0 0 1rem 0',
                                fontSize: '1.125rem',
                                fontWeight: '600',
                                color: 'var(--color-text-primary)',
                                display: 'flex',
                                alignItems: 'center',
                                gap: '0.5rem'
                              }}>
                                <Icon name="file-invoice" style={{ fontSize: '1.125rem', color: '#10b981' }} />
                                NF-es para {municipio.uf?.trim() || 'UF não informada'} ({municipio.infNFe.length})
                              </h4>
                              <div style={{
                                background: 'rgba(16, 185, 129, 0.05)',
                                borderRadius: '12px',
                                padding: '1rem',
                                border: '1px solid rgba(16, 185, 129, 0.1)'
                              }}>
                                {municipio.infNFe.map((nfe, index) => (
                                  <div key={index} style={{
                                    padding: '0.75rem 0',
                                    borderBottom: index < (municipio.infNFe?.length || 0) - 1 ? '1px solid rgba(16, 185, 129, 0.1)' : 'none'
                                  }}>
                                    <div style={{
                                      display: 'flex',
                                      justifyContent: 'space-between',
                                      alignItems: 'center',
                                      marginBottom: '0.5rem'
                                    }}>
                                      <div style={{
                                        fontSize: '0.875rem',
                                        fontWeight: '600',
                                        color: '#10b981'
                                      }}>
                                        NF-e {index + 1}
                                      </div>
                                      <div style={{
                                        fontSize: '0.75rem',
                                        fontWeight: '600',
                                        color: 'white',
                                        background: '#10b981',
                                        padding: '0.25rem 0.5rem',
                                        borderRadius: '4px'
                                      }}>
                                        Destino: {municipio.uf?.trim() || 'UF não informada'}
                                      </div>
                                    </div>
                                    <div style={{
                                      fontSize: '0.8rem',
                                      fontFamily: 'monospace',
                                      color: 'var(--color-text-primary)',
                                      background: 'var(--color-background)',
                                      padding: '0.5rem',
                                      borderRadius: '6px',
                                      border: '1px solid rgba(16, 185, 129, 0.2)',
                                      wordBreak: 'break-all'
                                    }}>
                                      {nfe.chNFe}
                                    </div>
                                    {nfe.vNF && (
                                      <div style={{
                                        fontSize: '0.75rem',
                                        color: 'var(--color-text-secondary)',
                                        marginTop: '0.25rem'
                                      }}>
                                        Valor: R$ {parseFloat(nfe.vNF).toLocaleString('pt-BR', {
                                          minimumFractionDigits: 2,
                                          maximumFractionDigits: 2
                                        })}
                                      </div>
                                    )}
                                  </div>
                                ))}
                              </div>
                            </div>
                          )}
                        </div>
                      </div>
                    )) : (
                      <div style={{
                        textAlign: 'center',
                        color: 'var(--color-text-secondary)',
                        fontSize: '1rem',
                        padding: '2rem'
                      }}>
                        Nenhum documento fiscal vinculado
                      </div>
                    )}
                  </div>
                </div>
              </div>
            )}

            {/* Botões de Ação Profissionais */}
            <div style={{
              background: 'var(--color-background)',
              border: '2px solid var(--color-border)',
              borderRadius: '12px',
              padding: '2rem',
              textAlign: 'center',
              marginBottom: '2rem'
            }}>
              <h3 style={{
                margin: '0 0 1.5rem 0',
                fontSize: '1.125rem',
                fontWeight: '700',
                color: 'var(--color-text-primary)'
              }}>
                Ações do Documento
              </h3>

              <div style={{
                display: 'flex',
                gap: '1rem',
                justifyContent: 'center',
                flexWrap: 'wrap',
                alignItems: 'center'
              }}>
                <button onClick={onCancelar} style={{
                  padding: '0.875rem 1.75rem',
                  border: '2px solid #6b7280',
                  borderRadius: '10px',
                  background: 'var(--color-background)',
                  color: '#6b7280',
                  cursor: 'pointer',
                  fontWeight: '600',
                  fontSize: '0.95rem',
                  transition: 'all 0.2s ease',
                  display: 'flex',
                  alignItems: 'center',
                  gap: '0.5rem',
                  minWidth: '140px',
                  justifyContent: 'center'
                }}>
                  <Icon name="x-circle" style={{ fontSize: '1.125rem' }} />
                  Cancelar
                </button>

                <button onClick={onSalvar} disabled={salvando} style={{
                  padding: '0.875rem 1.75rem',
                  border: 'none',
                  borderRadius: '10px',
                  background: salvando
                    ? '#6b7280'
                    : 'linear-gradient(135deg, #10b981, #059669)',
                  color: 'white',
                  cursor: salvando ? 'not-allowed' : 'pointer',
                  fontWeight: '600',
                  fontSize: '0.95rem',
                  transition: 'all 0.2s ease',
                  opacity: salvando ? 0.7 : 1,
                  display: 'flex',
                  alignItems: 'center',
                  gap: '0.5rem',
                  minWidth: '140px',
                  justifyContent: 'center',
                  boxShadow: salvando ? 'none' : '0 2px 8px rgba(16, 185, 129, 0.3)'
                }}>
                  <Icon name={salvando ? 'loader' : 'save'} style={{
                    fontSize: '1.125rem',
                    animation: salvando ? 'spin 1s linear infinite' : 'none'
                  }} />
                  {salvando ? 'Salvando...' : 'Salvar Rascunho'}
                </button>

                {onTransmitir && todasSecoesCompletas && (
                  <button onClick={() => setShowTransmissaoModal(true)} disabled={transmitindo} style={{
                    padding: '1rem 2rem',
                    border: 'none',
                    borderRadius: '10px',
                    background: transmitindo
                      ? '#6b7280'
                      : 'linear-gradient(135deg, #dc2626, #b91c1c)',
                    color: 'white',
                    cursor: transmitindo ? 'not-allowed' : 'pointer',
                    fontWeight: '700',
                    fontSize: '1rem',
                    transition: 'all 0.2s ease',
                    opacity: transmitindo ? 0.8 : 1,
                    display: 'flex',
                    alignItems: 'center',
                    gap: '0.75rem',
                    minWidth: '180px',
                    justifyContent: 'center',
                    boxShadow: transmitindo ? 'none' : '0 4px 12px rgba(220, 38, 38, 0.4)',
                    transform: transmitindo ? 'none' : 'translateY(-1px)'
                  }}>
                    <Icon name={transmitindo ? 'loader' : 'zap'} style={{
                      fontSize: '1.25rem',
                      animation: transmitindo ? 'spin 1s linear infinite' : 'none'
                    }} />
                    {transmitindo ? 'TRANSMITINDO...' : 'TRANSMITIR SEFAZ'}
                  </button>
                )}
              </div>

              {/* Informação sobre salvamento */}
              <div style={{
                marginTop: '1.5rem',
                padding: '1rem',
                background: todasSecoesCompletas
                  ? 'rgba(220, 38, 38, 0.05)'
                  : 'rgba(59, 130, 246, 0.05)',
                borderRadius: '8px',
                border: todasSecoesCompletas
                  ? '1px solid rgba(220, 38, 38, 0.1)'
                  : '1px solid rgba(59, 130, 246, 0.1)'
              }}>
                {todasSecoesCompletas ? (
                  <>
                    <div style={{
                      display: 'flex',
                      alignItems: 'center',
                      gap: '0.5rem',
                      marginBottom: '0.5rem'
                    }}>
                      <Icon name="alert-triangle" style={{
                        color: '#dc2626',
                        fontSize: '1.1rem'
                      }} />
                      <strong style={{ color: '#dc2626', fontSize: '0.9rem' }}>
                        Importante - Transmissão SEFAZ
                      </strong>
                    </div>
                    <p style={{
                      margin: '0',
                      fontSize: '0.8rem',
                      color: 'var(--color-text-secondary)',
                      lineHeight: '1.5',
                      display: 'flex',
                      alignItems: 'center',
                      justifyContent: 'center',
                      gap: '0.5rem'
                    }}>
                      <Icon name="alert-triangle" style={{ fontSize: '0.875rem', color: '#dc2626' }} />
                      <strong>Atenção:</strong> Uma vez transmitido, o documento não poderá ser alterado.
                    </p>
                  </>
                ) : (
                  <>
                    <div style={{
                      display: 'flex',
                      alignItems: 'center',
                      gap: '0.5rem',
                      marginBottom: '0.5rem'
                    }}>
                      <Icon name="info" style={{
                        color: '#3b82f6',
                        fontSize: '1.1rem'
                      }} />
                      <strong style={{ color: '#3b82f6', fontSize: '0.9rem' }}>
                        Salvamento como Rascunho
                      </strong>
                    </div>
                    <p style={{
                      margin: '0',
                      fontSize: '0.85rem',
                      color: 'var(--color-text-secondary)',
                      lineHeight: '1.5'
                    }}>
                      <strong>Você pode salvar mesmo com dados incompletos.</strong>
                      <br />
                      O documento será salvo como <strong>rascunho</strong> e poderá ser editado posteriormente. Para transmitir à SEFAZ, todos os campos obrigatórios precisam estar preenchidos.
                    </p>
                  </>
                )}
              </div>
            </div>
          </div>
        );

      default:
        return (
          <div className="card-body">
            <h4>{sections.find(s => s.id === currentSection)?.title}</h4>
            <p>Seção em desenvolvimento...</p>
          </div>
        );
    }
  };

  return (
    <div>
      {/* Header Moderno */}
      <header style={{
        display: 'flex',
        justifyContent: 'space-between',
        alignItems: 'center',
        marginBottom: '2rem',
        padding: '2rem 2.5rem',
        background: theme === 'dark'
          ? 'linear-gradient(135deg, #1f2937 0%, #111827 100%)'
          : 'linear-gradient(135deg, #ffffff 0%, #f8fafc 100%)',
        borderRadius: '20px',
        border: theme === 'dark'
          ? '1px solid rgba(55, 65, 81, 0.5)'
          : '1px solid rgba(229, 231, 235, 0.5)',
        boxShadow: theme === 'dark'
          ? '0 4px 20px rgba(0, 0, 0, 0.3)'
          : '0 4px 20px rgba(0, 0, 0, 0.08)',
        position: 'relative',
        overflow: 'hidden'
      }}>
        <div style={{ display: 'flex', alignItems: 'flex-start', gap: '1rem' }}>
          <div style={{
            width: '48px',
            height: '48px',
            background: 'linear-gradient(135deg, #3b82f6, #1d4ed8)',
            borderRadius: '12px',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            color: 'white',
            fontSize: '1.5rem',
            flexShrink: 0,
            marginTop: '0.125rem' // Pequeno ajuste para alinhar com a primeira linha do texto
          }}>
            <Icon name={isEdicao ? "edit" : "plus"} />
          </div>
          <div>
            <h2 style={{ margin: 0, fontSize: '1.75rem', fontWeight: '700' }}>
              {isEdicao ? 'Editar MDF-e' : 'Novo MDF-e'}
            </h2>
            <div style={{
              margin: '1rem 0 0 0',
              display: 'flex',
              alignItems: 'center',
              gap: '1.5rem'
            }}>
              <div style={{
                background: theme === 'dark'
                  ? 'linear-gradient(135deg, #059669, #047857)'
                  : 'linear-gradient(135deg, #10b981, #059669)',
                color: 'white',
                padding: '0.75rem 1.5rem',
                borderRadius: '12px',
                fontSize: '1rem',
                fontWeight: '700',
                display: 'flex',
                alignItems: 'center',
                gap: '0.75rem',
                boxShadow: '0 4px 12px rgba(16, 185, 129, 0.3)'
              }}>
                <Icon name="tag" size="md" />
                <span>Série: {dados.ide?.serie || '001'}</span>
              </div>
              <div style={{
                background: theme === 'dark'
                  ? 'linear-gradient(135deg, #1d4ed8, #1e40af)'
                  : 'linear-gradient(135deg, #3b82f6, #1d4ed8)',
                color: 'white',
                padding: '0.75rem 1.5rem',
                borderRadius: '12px',
                fontSize: '1rem',
                fontWeight: '700',
                display: 'flex',
                alignItems: 'center',
                gap: '0.75rem',
                boxShadow: '0 4px 12px rgba(59, 130, 246, 0.3)'
              }}>
                <Icon name="hash" size="md" />
                <span>Número: {dados.ide?.nMDF || '---'}</span>
              </div>
            </div>
          </div>
        </div>

        <div style={{
          display: 'flex',
          alignItems: 'center',
          gap: '1rem',
          color: theme === 'dark' ? '#9ca3af' : '#6b7280',
          fontSize: '0.875rem'
        }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
            <Icon name="layers" />
            {sections.find(s => s.id === currentSection)?.title}
          </div>
        </div>
      </header>

      {/* Progress Steps */}
      <div style={{
        marginBottom: '2rem',
        padding: '2rem',
        background: theme === 'dark'
          ? 'linear-gradient(135deg, #1f2937 0%, #111827 100%)'
          : 'linear-gradient(135deg, #ffffff 0%, #f8fafc 100%)',
        borderRadius: '16px',
        border: theme === 'dark'
          ? '1px solid rgba(55, 65, 81, 0.5)'
          : '1px solid rgba(229, 231, 235, 0.5)',
        boxShadow: theme === 'dark'
          ? '0 4px 20px rgba(0, 0, 0, 0.3)'
          : '0 4px 20px rgba(0, 0, 0, 0.08)'
      }}>
        <div style={{
          display: 'flex',
          justifyContent: 'space-between',
          alignItems: 'center',
          position: 'relative'
        }}>
          {/* Progress Line Background */}
          <div style={{
            position: 'absolute',
            top: '24px', // Centro da bolinha (48px / 2)
            left: '24px', // Começa do centro da primeira bolinha
            right: '24px', // Termina no centro da última bolinha
            height: '4px',
            background: theme === 'dark' ? '#374151' : '#e5e7eb',
            borderRadius: '2px',
            zIndex: 1,
            transform: 'translateY(-2px)' // Centraliza a linha verticalmente
          }} />

          {/* Progress Line Active */}
          <div style={{
            position: 'absolute',
            top: '24px', // Centro da bolinha (48px / 2)
            left: '24px', // Começa do centro da primeira bolinha
            height: '4px',
            background: 'linear-gradient(90deg, #3b82f6, #10b981)',
            borderRadius: '2px',
            zIndex: 2,
            width: `calc((100% - 48px) * ${(sections.findIndex(s => s.id === currentSection) / (sections.length - 1))})`,
            transition: 'width 0.3s ease',
            transform: 'translateY(-2px)' // Centraliza a linha verticalmente
          }} />

          {sections.map((section, index) => {
            const isActive = section.id === currentSection;
            const isPassed = sections.findIndex(s => s.id === currentSection) > index;
            const isCompleted = section.completed;

            return (
              <div
                key={section.id}
                style={{
                  display: 'flex',
                  flexDirection: 'column',
                  alignItems: 'center',
                  cursor: 'pointer',
                  zIndex: 3,
                  position: 'relative'
                }}
                onClick={() => setCurrentSection(section.id)}
              >
                {/* Step Circle */}
                <div style={{
                  width: '48px',
                  height: '48px',
                  borderRadius: '50%',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  background: isActive
                    ? 'linear-gradient(135deg, #3b82f6, #1d4ed8)'
                    : isPassed || isCompleted
                      ? 'linear-gradient(135deg, #10b981, #059669)'
                      : theme === 'dark' ? '#374151' : '#e5e7eb',
                  color: isActive || isPassed || isCompleted ? 'white' : theme === 'dark' ? '#9ca3af' : '#6b7280',
                  fontWeight: '600',
                  fontSize: '0.875rem',
                  border: isActive ? '3px solid #bfdbfe' : 'none',
                  boxShadow: isActive ? '0 0 0 6px rgba(59, 130, 246, 0.1)' : 'none',
                  transition: 'all 0.3s ease',
                  marginBottom: '0.75rem'
                }}>
                  {isCompleted || isPassed ? (
                    <Icon name="check" />
                  ) : (
                    <span>{index + 1}</span>
                  )}
                </div>

                {/* Step Label */}
                <div style={{
                  textAlign: 'center',
                  minWidth: '80px'
                }}>
                  <div style={{
                    fontSize: '0.875rem',
                    fontWeight: '600',
                    color: isActive
                      ? '#3b82f6'
                      : isPassed || isCompleted
                        ? '#10b981'
                        : theme === 'dark' ? '#9ca3af' : '#6b7280',
                    marginBottom: '0.25rem'
                  }}>
                    {section.title}
                  </div>
                  <div style={{
                    fontSize: '0.75rem',
                    color: theme === 'dark' ? '#6b7280' : '#9ca3af',
                    maxWidth: '120px'
                  }}>
                    {section.description}
                  </div>
                </div>
              </div>
            );
          })}
        </div>
      </div>

      {/* Conteúdo da Seção */}
      <div style={{ marginBottom: '2rem' }}>
        {renderSectionContent()}
      </div>

      {/* Navegação */}
      <div style={{
        display: 'flex',
        justifyContent: 'space-between',
        alignItems: 'center',
        padding: '2rem',
        background: theme === 'dark'
          ? 'linear-gradient(135deg, #1f2937 0%, #111827 100%)'
          : 'linear-gradient(135deg, #ffffff 0%, #f8fafc 100%)',
        borderRadius: '16px',
        border: theme === 'dark'
          ? '1px solid rgba(55, 65, 81, 0.5)'
          : '1px solid rgba(229, 231, 235, 0.5)',
        boxShadow: theme === 'dark'
          ? '0 4px 20px rgba(0, 0, 0, 0.3)'
          : '0 4px 20px rgba(0, 0, 0, 0.08)'
      }}>
        <button
          onClick={() => {
            const currentIndex = sections.findIndex(s => s.id === currentSection);
            if (currentIndex > 0) {
              setCurrentSection(sections[currentIndex - 1].id);
            }
          }}
          disabled={sections.findIndex(s => s.id === currentSection) === 0}
          style={{
            display: 'flex',
            alignItems: 'center',
            gap: '0.5rem',
            padding: '0.75rem 1.5rem',
            background: sections.findIndex(s => s.id === currentSection) === 0
              ? theme === 'dark' ? '#374151' : '#e5e7eb'
              : theme === 'dark'
                ? 'linear-gradient(135deg, #374151, #4b5563)'
                : 'linear-gradient(135deg, #f8fafc, #e2e8f0)',
            color: sections.findIndex(s => s.id === currentSection) === 0
              ? theme === 'dark' ? '#6b7280' : '#9ca3af'
              : theme === 'dark' ? '#e5e7eb' : '#475569',
            border: `2px solid ${sections.findIndex(s => s.id === currentSection) === 0
              ? theme === 'dark' ? '#4b5563' : '#d1d5db'
              : theme === 'dark' ? '#6b7280' : '#cbd5e1'}`,
            borderRadius: '12px',
            fontSize: '0.875rem',
            fontWeight: '600',
            cursor: sections.findIndex(s => s.id === currentSection) === 0 ? 'not-allowed' : 'pointer',
            transition: 'all 0.3s ease',
            opacity: sections.findIndex(s => s.id === currentSection) === 0 ? 0.5 : 1
          }}
        >
          <Icon name="arrow-left" />
          Anterior
        </button>

        {/* Progress Info */}
        <div style={{
          display: 'flex',
          alignItems: 'center',
          gap: '0.75rem',
          color: theme === 'dark' ? '#9ca3af' : '#6b7280',
          fontSize: '0.875rem',
          fontWeight: '500'
        }}>
          <Icon name="info-circle" />
          Etapa {sections.findIndex(s => s.id === currentSection) + 1} de {sections.length}
        </div>

        <button
          onClick={() => {
            const currentIndex = sections.findIndex(s => s.id === currentSection);
            if (currentIndex < sections.length - 1) {
              setCurrentSection(sections[currentIndex + 1].id);
            }
          }}
          disabled={sections.findIndex(s => s.id === currentSection) === sections.length - 1}
          style={{
            display: 'flex',
            alignItems: 'center',
            gap: '0.5rem',
            padding: '0.75rem 1.5rem',
            background: sections.findIndex(s => s.id === currentSection) === sections.length - 1
              ? theme === 'dark' ? '#374151' : '#e5e7eb'
              : 'linear-gradient(135deg, #3b82f6, #1d4ed8)',
            color: sections.findIndex(s => s.id === currentSection) === sections.length - 1
              ? theme === 'dark' ? '#6b7280' : '#9ca3af'
              : 'white',
            border: `2px solid ${sections.findIndex(s => s.id === currentSection) === sections.length - 1
              ? theme === 'dark' ? '#4b5563' : '#d1d5db'
              : 'transparent'}`,
            borderRadius: '12px',
            fontSize: '0.875rem',
            fontWeight: '600',
            cursor: sections.findIndex(s => s.id === currentSection) === sections.length - 1 ? 'not-allowed' : 'pointer',
            transition: 'all 0.3s ease',
            opacity: sections.findIndex(s => s.id === currentSection) === sections.length - 1 ? 0.5 : 1,
            boxShadow: sections.findIndex(s => s.id === currentSection) === sections.length - 1
              ? 'none'
              : '0 4px 14px rgba(59, 130, 246, 0.4)'
          }}
          onMouseEnter={(e) => {
            if (sections.findIndex(s => s.id === currentSection) !== sections.length - 1) {
              e.currentTarget.style.transform = 'translateY(-2px)';
              e.currentTarget.style.boxShadow = '0 6px 20px rgba(59, 130, 246, 0.5)';
            }
          }}
          onMouseLeave={(e) => {
            if (sections.findIndex(s => s.id === currentSection) !== sections.length - 1) {
              e.currentTarget.style.transform = 'translateY(0)';
              e.currentTarget.style.boxShadow = '0 4px 14px rgba(59, 130, 246, 0.4)';
            }
          }}
        >
          Próximo
          <Icon name="arrow-right" />
        </button>
      </div>

      {/* Modal de Confirmação de Transmissão */}
      <ConfirmTransmissaoModal
        isOpen={showTransmissaoModal}
        onConfirm={() => {
          setShowTransmissaoModal(false);
          if (onTransmitir) onTransmitir();
        }}
        onCancel={() => setShowTransmissaoModal(false)}
        isTransmitting={transmitindo}
        numeroMDFe={dados.ide?.nMDF?.toString()}
        ambiente={dados.ide?.tpAmb === '1' ? 'producao' : 'homologacao'}
      />
    </div>
  );
}