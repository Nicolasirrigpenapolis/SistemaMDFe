import React, { useState, useEffect } from 'react';
import { MDFeData } from '../../../types/mdfe';
import { entitiesService, EntityOption } from '../../../services/entitiesService';
import { LocalCarregamento, localidadeService } from '../../../services/localidadeService';
import { mdfeService } from '../../../services/mdfeService';
import { useTheme } from '../../../contexts/ThemeContext';
import { LocalidadeSelector } from './LocalidadeSelector';
import { formatCNPJ, formatCPF, formatPlaca, cleanNumericString, cleanPlaca, applyMask } from '../../../utils/formatters';
import Icon from '../Icon';

interface MDFeWizardProps {
  dados: Partial<MDFeData>;
  onDadosChange: (dados: Partial<MDFeData>) => void;
  onSalvar: () => void;
  onCancelar: () => void;
  onTransmitir?: () => void;
  salvando: boolean;
  transmitindo?: boolean;
  isEdicao: boolean;
}

interface WizardSection {
  id: string;
  title: string;
  description: string;
  required: boolean;
  completed: boolean;
}

export function MDFeWizard({ dados, onDadosChange, onSalvar, onCancelar, onTransmitir, salvando, transmitindo = false, isEdicao }: MDFeWizardProps) {
  const { theme } = useTheme();
  const [currentSection, setCurrentSection] = useState('emitente');
  const [emitentes, setEmitentes] = useState<EntityOption[]>([]);
  const [condutores, setCondutores] = useState<EntityOption[]>([]);
  const [veiculos, setVeiculos] = useState<EntityOption[]>([]);
  const [loading, setLoading] = useState(false);
  const [showCTeModal, setShowCTeModal] = useState(false);
  const [showNFeModal, setShowNFeModal] = useState(false);
  const [documentChave, setDocumentChave] = useState('');
  const [locaisCarregamento, setLocaisCarregamento] = useState<LocalCarregamento[]>([]);
  const [locaisDescarregamento, setLocaisDescarregamento] = useState<LocalCarregamento[]>([]);
  const [selectedEmitenteId, setSelectedEmitenteId] = useState<string>('');
  const [selectedCondutorId, setSelectedCondutorId] = useState<string>('');
  const [selectedVeiculoId, setSelectedVeiculoId] = useState<string>('');

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

  // ✨ SALVAMENTO AUTOMÁTICO - evita perda de dados ao fechar navegador
  useEffect(() => {
    let timeoutId: NodeJS.Timeout;

    const autoSave = async () => {
      try {
        // Só salvar se tiver algum dado preenchido
        if (dados.emit?.xNome || dados.tot?.vCarga || locaisCarregamento.length > 0 || locaisDescarregamento.length > 0) {
          console.log('💾 Executando salvamento automático...');

          // Salvar no localStorage como backup adicional
          const dadosParaSalvar = {
            ...dados,
            timestamp: new Date().toISOString(),
            locaisCarregamento,
            locaisDescarregamento
          };

          localStorage.setItem('mdfe_autosave_backup', JSON.stringify(dadosParaSalvar));

          // Salvar no servidor via API
          await mdfeService.salvarRascunho(dados);

          console.log('✅ Salvamento automático concluído');
        }
      } catch (error) {
        console.warn('⚠️ Erro no salvamento automático:', error);
        // Em caso de erro da API, pelo menos o localStorage funcionou
      }
    };

    // Executar salvamento após 2 segundos de inatividade
    timeoutId = setTimeout(autoSave, 2000);

    // Cleanup do timeout
    return () => clearTimeout(timeoutId);
  }, [dados, locaisCarregamento, locaisDescarregamento]);

  // ✨ RESTAURAR DADOS DO BACKUP AUTOMÁTICO na inicialização
  useEffect(() => {
    const restaurarBackup = () => {
      try {
        const backup = localStorage.getItem('mdfe_autosave_backup');
        if (backup && !isEdicao) {
          const dadosBackup = JSON.parse(backup);
          const agora = new Date();
          const timestampBackup = new Date(dadosBackup.timestamp);
          const diferencaHoras = (agora.getTime() - timestampBackup.getTime()) / (1000 * 60 * 60);

          // Só restaurar se backup for recente (últimas 24 horas) e não estamos editando
          if (diferencaHoras < 24 && Object.keys(dados).length <= 1) {
            console.log('🔄 Restaurando backup automático...');
            onDadosChange(dadosBackup);

            if (dadosBackup.locaisCarregamento) {
              setLocaisCarregamento(dadosBackup.locaisCarregamento);
            }
            if (dadosBackup.locaisDescarregamento) {
              setLocaisDescarregamento(dadosBackup.locaisDescarregamento);
            }

            // Mostrar notificação ao usuário
            const notification = document.createElement('div');
            notification.style.cssText = `
              position: fixed;
              top: 20px;
              right: 20px;
              background: linear-gradient(135deg, #10b981, #059669);
              color: white;
              padding: 1rem 1.5rem;
              border-radius: 12px;
              box-shadow: 0 4px 20px rgba(16, 185, 129, 0.3);
              z-index: 10000;
              font-weight: 600;
              font-size: 0.875rem;
              animation: slideInRight 0.3s ease-out;
            `;
            notification.innerHTML = '💾 Dados restaurados automaticamente do último backup!';
            document.body.appendChild(notification);

            setTimeout(() => {
              notification.remove();
            }, 4000);

            console.log('✅ Backup restaurado com sucesso');
          }
        }
      } catch (error) {
        console.warn('⚠️ Erro ao restaurar backup:', error);
      }
    };

    restaurarBackup();
  }, []); // Executar apenas uma vez na inicialização

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
      cMunCarrega: local.codigoIBGE.toString(),
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
    // ✅ CORREÇÃO: Preservar CTes/NFes existentes ao atualizar locais
    const ctesExistentes = dados.infDoc?.infMunDescarga?.reduce((acc, descarga) => {
      if (descarga.infCTe) acc.push(...descarga.infCTe);
      return acc;
    }, [] as any[]) || [];

    const nfesExistentes = dados.infDoc?.infMunDescarga?.reduce((acc, descarga) => {
      if (descarga.infNFe) acc.push(...descarga.infNFe);
      return acc;
    }, [] as any[]) || [];

    // ✨ Distribuir CTes automaticamente entre os locais
    const ctesDistribuidos = distribuirCtesAutomaticamente(ctesExistentes, novosLocais);
    const nfesDistribuidos = distribuirCtesAutomaticamente(nfesExistentes, novosLocais);

    const infMunDescarga = novosLocais.map((local, index) => ({
      cMunDescarga: local.codigoIBGE.toString(),
      xMunDescarga: local.municipio,
      uf: local.uf,
      // ✨ Distribuir documentos automaticamente
      infCTe: ctesDistribuidos[index] || [],
      infNFe: nfesDistribuidos[index] || []
    }));

    console.log('🚛 [DEBUG] CTes distribuídos:', ctesDistribuidos);
    console.log('🚛 [DEBUG] Estrutura final:', infMunDescarga);

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
      console.log('Carregando entidades...');

      const [emitentesData, condutoresData, veiculosData] = await Promise.all([
        entitiesService.obterEmitentes(),
        entitiesService.obterCondutores(),
        entitiesService.obterVeiculos()
      ]);

      console.log('Emitentes carregados:', emitentesData.length, emitentesData);
      console.log('Condutores carregados:', condutoresData.length, condutoresData);
      console.log('Veículos carregados:', veiculosData.length, veiculosData);

      setEmitentes(emitentesData);
      setCondutores(condutoresData);
      setVeiculos(veiculosData);
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

  const handleEmitenteSelect = (emitenteId: string) => {
    setSelectedEmitenteId(emitenteId);
    const emitente = emitentes.find(e => e.id === emitenteId);
    if (emitente && emitente.data) {
      atualizarSecao('emit', {
        CNPJ: emitente.data.CNPJ,
        IE: emitente.data.IE,
        xNome: emitente.data.xNome,
        xFant: emitente.data.xFant,
        enderEmit: emitente.data.enderEmit
      });
    } else if (emitenteId === '') {
      // Limpar campos se deselecionar
      atualizarSecao('emit', {
        CNPJ: '',
        IE: '',
        xNome: '',
        xFant: '',
        enderEmit: undefined
      });
    }
  };

  const handleCondutorSelect = (condutorId: string) => {
    setSelectedCondutorId(condutorId);
    const condutor = condutores.find(c => c.id === condutorId);
    if (condutor && condutor.data) {
      // Atualizar dados do condutor no veículo de tração
      atualizarSecao('infModal', {
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
      });
    } else if (condutorId === '') {
      // Limpar campos se deselecionar
      atualizarSecao('infModal', {
        ...dados.infModal,
        rodo: {
          ...dados.infModal?.rodo,
          veicTracao: {
            ...dados.infModal?.rodo?.veicTracao,
            condutor: undefined
          },
        }
      });
    }
  };

  const handleVeiculoSelect = (veiculoId: string) => {
    setSelectedVeiculoId(veiculoId);
    const veiculo = veiculos.find(v => v.id === veiculoId);
    if (veiculo && veiculo.data) {
      atualizarSecao('infModal', {
        rodo: {
          veicTracao: {
            cInt: veiculo.data.cInt,
            placa: veiculo.data.placa,
            tara: veiculo.data.tara,
            tpProp: veiculo.data.tpProp,
            tpVeic: veiculo.data.tpVeic,
            tpRod: veiculo.data.tpRod,
            tpCar: veiculo.data.tpCar,
            UF: veiculo.data.UF
          }
        }
      });
    } else if (veiculoId === '') {
      // Limpar campos se deselecionar
      atualizarSecao('infModal', {
        rodo: {
          veicTracao: {
            cInt: '',
            placa: '',
            tara: '',
            tpProp: '1',
            tpVeic: '07',
            tpRod: '',
            tpCar: '',
            UF: ''
          }
        }
      });
    }
  };

  const addCTe = () => {
    console.log('🟡 [DEBUG] addCTe chamado - chave:', documentChave, 'length:', documentChave.length);

    if (documentChave && documentChave.length === 44) {
      const currentDescarga = dados.infDoc?.infMunDescarga || [];
      const newDescarga = [...currentDescarga];

      console.log('🟡 [DEBUG] currentDescarga:', currentDescarga);

      if (newDescarga.length === 0) {
        // Sem locais de descarga ainda, criar estrutura básica
        newDescarga.push({
          cMunDescarga: '',
          xMunDescarga: '',
          infCTe: [{ chCTe: documentChave }],
          infNFe: []
        });
        console.log('🟡 [DEBUG] Criado novo local de descarga com CTe');
      } else {
        // Já existem locais, adicionar CTe ao primeiro
        if (!newDescarga[0].infCTe) {
          newDescarga[0].infCTe = [];
        }
        newDescarga[0].infCTe.push({ chCTe: documentChave });
        console.log('🟡 [DEBUG] CTe adicionado ao local existente, total CTes:', newDescarga[0].infCTe.length);
      }

      console.log('🟡 [DEBUG] newDescarga final:', newDescarga);

      atualizarSecao('infDoc', {
        infMunDescarga: newDescarga
      });

      // Atualizar contadores
      const qCTe = newDescarga[0]?.infCTe?.length || 0;
      atualizarCampo('tot', 'qCTe', qCTe.toString());

      console.log('🟡 [DEBUG] Contador qCTe atualizado para:', qCTe);

      setDocumentChave('');
      setShowCTeModal(false);
    } else {
      console.log('🟡 [DEBUG] Chave inválida - não processado');
    }
  };

  const addNFe = () => {
    if (documentChave && documentChave.length === 44) {
      const currentDescarga = dados.infDoc?.infMunDescarga || [];
      const newDescarga = [...currentDescarga];

      if (newDescarga.length === 0) {
        newDescarga.push({
          cMunDescarga: '',
          xMunDescarga: '',
          infCTe: [],
          infNFe: [{ chNFe: documentChave }]
        });
      } else {
        if (!newDescarga[0].infNFe) {
          newDescarga[0].infNFe = [];
        }
        newDescarga[0].infNFe.push({ chNFe: documentChave });
      }

      atualizarSecao('infDoc', {
        infMunDescarga: newDescarga
      });

      // Atualizar contadores
      const qNFe = newDescarga[0]?.infNFe?.length || 0;
      atualizarCampo('tot', 'qNFe', qNFe.toString());

      setDocumentChave('');
      setShowNFeModal(false);
    }
  };

  const removeCTe = (index: number) => {
    const currentDescarga = dados.infDoc?.infMunDescarga || [];
    if (currentDescarga[0]?.infCTe) {
      const newCTe = currentDescarga[0].infCTe.filter((_, i) => i !== index);
      const newDescarga = [{
        ...currentDescarga[0],
        infCTe: newCTe
      }];

      atualizarSecao('infDoc', {
        infMunDescarga: newDescarga
      });

      atualizarCampo('tot', 'qCTe', newCTe.length.toString());
    }
  };

  const removeNFe = (index: number) => {
    const currentDescarga = dados.infDoc?.infMunDescarga || [];
    if (currentDescarga[0]?.infNFe) {
      const newNFe = currentDescarga[0].infNFe.filter((_, i) => i !== index);
      const newDescarga = [{
        ...currentDescarga[0],
        infNFe: newNFe
      }];

      atualizarSecao('infDoc', {
        infMunDescarga: newDescarga
      });

      atualizarCampo('tot', 'qNFe', newNFe.length.toString());
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
        cMunCarrega: local.codigoIBGE.toString(),
        xMunCarrega: local.municipio,
        uf: local.uf
      }));
      atualizarCampo('ide', 'infMunCarrega', infMunCarrega);
    }

    // ✅ CORREÇÃO: Não sobrescrever dados de descarregamento se já existem
    // Esta função deve apenas calcular percurso, não gerenciar locais de descarga
    // Os locais já são gerenciados pela função salvarLocaisDescarregamento
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

      case 'trajeto':
        return (
          <div className="card-body">
            <div style={{
              background: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)',
              borderRadius: '16px',
              padding: '2rem',
              marginBottom: '2rem',
              color: 'white',
              textAlign: 'center'
            }}>
              <div style={{
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center',
                gap: '1rem',
                marginBottom: '1rem'
              }}>
                <Icon name="route" style={{ fontSize: '2.5rem' }} />
                <h4 style={{
                  margin: 0,
                  fontSize: '2rem',
                  fontWeight: '700',
                  textShadow: '0 2px 4px rgba(0,0,0,0.3)'
                }}>Configurar Trajeto da Viagem</h4>
              </div>
              <p style={{
                margin: 0,
                fontSize: '1.125rem',
                opacity: 0.9,
                fontWeight: '500'
              }}>
                Defina os locais de carregamento e descarregamento. O sistema calculará automaticamente a melhor rota.
              </p>
            </div>

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
                      value={documentChave}
                      onChange={(e) => setDocumentChave(e.target.value.replace(/\D/g, '').slice(0, 44))}
                      placeholder="Digite os 44 dígitos da chave de acesso"
                      style={{
                        width: '100%',
                        padding: '0.75rem 1rem',
                        border: `2px solid ${documentChave.length === 44
                          ? '#10b981'
                          : documentChave.length > 0
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
                        color: documentChave.length === 44
                          ? '#10b981'
                          : documentChave.length > 0
                            ? '#f59e0b'
                            : 'var(--color-text-secondary)'
                      }}>
                        {documentChave.length}/44
                      </span>
                    </div>
                  </div>
                  <button
                    onClick={addCTe}
                    disabled={documentChave.length !== 44}
                    style={{
                      padding: '0.75rem 1.5rem',
                      background: documentChave.length === 44
                        ? 'linear-gradient(135deg, #3b82f6, #1d4ed8)'
                        : 'var(--color-border)',
                      color: documentChave.length === 44 ? 'white' : 'var(--color-text-secondary)',
                      border: 'none',
                      borderRadius: '8px',
                      cursor: documentChave.length === 44 ? 'pointer' : 'not-allowed',
                      fontWeight: '600',
                      fontSize: '0.875rem',
                      transition: 'all 0.2s ease',
                      display: 'flex',
                      alignItems: 'center',
                      gap: '0.5rem',
                      opacity: documentChave.length === 44 ? 1 : 0.6,
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
                      value={documentChave}
                      onChange={(e) => setDocumentChave(e.target.value.replace(/\D/g, '').slice(0, 44))}
                      placeholder="Digite os 44 dígitos da chave de acesso"
                      style={{
                        width: '100%',
                        padding: '0.75rem 1rem',
                        border: `2px solid ${documentChave.length === 44
                          ? '#10b981'
                          : documentChave.length > 0
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
                        color: documentChave.length === 44
                          ? '#10b981'
                          : documentChave.length > 0
                            ? '#f59e0b'
                            : 'var(--color-text-secondary)'
                      }}>
                        {documentChave.length}/44
                      </span>
                    </div>
                  </div>
                  <button
                    onClick={addNFe}
                    disabled={documentChave.length !== 44}
                    style={{
                      padding: '0.75rem 1.5rem',
                      background: documentChave.length === 44
                        ? 'linear-gradient(135deg, #10b981, #059669)'
                        : 'var(--color-border)',
                      color: documentChave.length === 44 ? 'white' : 'var(--color-text-secondary)',
                      border: 'none',
                      borderRadius: '8px',
                      cursor: documentChave.length === 44 ? 'pointer' : 'not-allowed',
                      fontWeight: '600',
                      fontSize: '0.875rem',
                      transition: 'all 0.2s ease',
                      display: 'flex',
                      alignItems: 'center',
                      gap: '0.5rem',
                      opacity: documentChave.length === 44 ? 1 : 0.6,
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
          <div className="card-body">
            {/* Header com status geral */}
            <div style={{
              background: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)',
              borderRadius: '20px',
              padding: '2.5rem',
              marginBottom: '2.5rem',
              color: 'white',
              textAlign: 'center',
              position: 'relative',
              overflow: 'hidden'
            }}>
              {/* Background pattern */}
              <div style={{
                position: 'absolute',
                top: '-50%',
                left: '-50%',
                width: '200%',
                height: '200%',
                background: 'radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%)',
                animation: 'pulse 4s ease-in-out infinite'
              }} />

              <div style={{
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center',
                gap: '1.5rem',
                marginBottom: '1.5rem',
                position: 'relative',
                zIndex: 1
              }}>
                <div style={{
                  width: '80px',
                  height: '80px',
                  background: 'rgba(255,255,255,0.2)',
                  borderRadius: '50%',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  backdropFilter: 'blur(10px)',
                  border: '2px solid rgba(255,255,255,0.3)'
                }}>
                  <Icon name="clipboard-check" style={{ fontSize: '2.5rem' }} />
                </div>
                <div style={{ textAlign: 'left' }}>
                  <h3 style={{
                    margin: 0,
                    fontSize: '2.5rem',
                    fontWeight: '800',
                    textShadow: '0 2px 10px rgba(0,0,0,0.3)',
                    letterSpacing: '-0.02em'
                  }}>Revisão Final</h3>
                  <p style={{
                    margin: 0,
                    fontSize: '1.125rem',
                    opacity: 0.9,
                    fontWeight: '500'
                  }}>Manifesto de Documentos Fiscais Eletrônicos</p>
                </div>
              </div>

              <div style={{
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center',
                gap: '2rem',
                position: 'relative',
                zIndex: 1
              }}>
                <div style={{
                  background: todasSecoesCompletas ? 'rgba(16, 185, 129, 0.3)' : 'rgba(239, 68, 68, 0.3)',
                  borderRadius: '50px',
                  padding: '0.75rem 2rem',
                  display: 'flex',
                  alignItems: 'center',
                  gap: '0.5rem',
                  backdropFilter: 'blur(10px)',
                  border: todasSecoesCompletas ? '2px solid rgba(16, 185, 129, 0.5)' : '2px solid rgba(239, 68, 68, 0.5)'
                }}>
                  <Icon name={todasSecoesCompletas ? "check-circle" : "alert-circle"} />
                  <span style={{ fontSize: '1rem', fontWeight: '600' }}>
                    {todasSecoesCompletas ? 'Pronto para Emissão' : 'Pendências Encontradas'}
                  </span>
                </div>

                <div style={{
                  background: 'rgba(255,255,255,0.2)',
                  borderRadius: '50px',
                  padding: '0.75rem 2rem',
                  display: 'flex',
                  alignItems: 'center',
                  gap: '0.5rem',
                  backdropFilter: 'blur(10px)',
                  border: '2px solid rgba(255,255,255,0.3)'
                }}>
                  <Icon name="tasks" />
                  <span style={{ fontSize: '1rem', fontWeight: '600' }}>
                    {sections.filter(s => s.completed && s.id !== 'resumo').length}/{sections.filter(s => s.id !== 'resumo').length} Seções
                  </span>
                </div>
              </div>
            </div>

            {/* Status das Seções Aprimorado */}
            <div style={{
              marginBottom: '2.5rem'
            }}>
              <h5 style={{
                margin: '0 0 1.5rem 0',
                fontSize: '1.5rem',
                fontWeight: '700',
                color: 'var(--color-text-primary)',
                display: 'flex',
                alignItems: 'center',
                gap: '0.75rem'
              }}>
                <div style={{
                  width: '40px',
                  height: '40px',
                  background: 'linear-gradient(135deg, #6366f1, #8b5cf6)',
                  borderRadius: '12px',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  color: 'white'
                }}>
                  <Icon name="list-check" style={{ fontSize: '1.25rem' }} />
                </div>
                Verificação das Seções
              </h5>

              <div style={{
                display: 'grid',
                gridTemplateColumns: 'repeat(auto-fit, minmax(320px, 1fr))',
                gap: '1.25rem'
              }}>
                {sections.filter(section => section.id !== 'resumo').map((section) => (
                  <div
                    key={section.id}
                    style={{
                      padding: '1.5rem',
                      border: section.completed
                        ? '3px solid #10b981'
                        : section.required
                          ? '3px solid #ef4444'
                          : '3px solid #f59e0b',
                      borderRadius: '16px',
                      background: section.completed
                        ? 'linear-gradient(145deg, rgba(16, 185, 129, 0.1), rgba(16, 185, 129, 0.05))'
                        : section.required
                          ? 'linear-gradient(145deg, rgba(239, 68, 68, 0.1), rgba(239, 68, 68, 0.05))'
                          : 'linear-gradient(145deg, rgba(245, 158, 11, 0.1), rgba(245, 158, 11, 0.05))',
                      display: 'flex',
                      alignItems: 'center',
                      justifyContent: 'space-between',
                      boxShadow: section.completed
                        ? '0 4px 20px rgba(16, 185, 129, 0.15)'
                        : section.required
                          ? '0 4px 20px rgba(239, 68, 68, 0.15)'
                          : '0 4px 20px rgba(245, 158, 11, 0.15)',
                      transition: 'all 0.3s ease',
                      position: 'relative',
                      overflow: 'hidden'
                    }}
                  >
                    {/* Background decoration */}
                    <div style={{
                      position: 'absolute',
                      top: 0,
                      right: 0,
                      width: '100px',
                      height: '100px',
                      background: section.completed
                        ? 'radial-gradient(circle, rgba(16, 185, 129, 0.1) 0%, transparent 70%)'
                        : section.required
                          ? 'radial-gradient(circle, rgba(239, 68, 68, 0.1) 0%, transparent 70%)'
                          : 'radial-gradient(circle, rgba(245, 158, 11, 0.1) 0%, transparent 70%)',
                      borderRadius: '50%',
                      transform: 'translate(30%, -30%)'
                    }} />

                    <div style={{ display: 'flex', alignItems: 'center', gap: '1rem', position: 'relative', zIndex: 1 }}>
                      <div style={{
                        width: '50px',
                        height: '50px',
                        background: section.completed
                          ? 'linear-gradient(135deg, #10b981, #059669)'
                          : section.required
                            ? 'linear-gradient(135deg, #ef4444, #dc2626)'
                            : 'linear-gradient(135deg, #f59e0b, #d97706)',
                        borderRadius: '15px',
                        display: 'flex',
                        alignItems: 'center',
                        justifyContent: 'center',
                        color: 'white',
                        flexShrink: 0
                      }}>
                        {section.completed ? (
                          <Icon name="check-circle" style={{ fontSize: '1.5rem' }} />
                        ) : section.required ? (
                          <Icon name="alert-circle" style={{ fontSize: '1.5rem' }} />
                        ) : (
                          <Icon name="clock" style={{ fontSize: '1.5rem' }} />
                        )}
                      </div>
                      <div>
                        <h6 style={{
                          margin: 0,
                          fontSize: '1.125rem',
                          fontWeight: '700',
                          color: 'var(--color-text-primary)',
                          marginBottom: '0.25rem'
                        }}>
                          {section.title}
                        </h6>
                        <p style={{
                          margin: 0,
                          fontSize: '0.875rem',
                          color: 'var(--color-text-secondary)',
                          lineHeight: 1.4
                        }}>
                          {section.description}
                        </p>
                        <div style={{
                          marginTop: '0.5rem',
                          display: 'flex',
                          alignItems: 'center',
                          gap: '0.5rem'
                        }}>
                          <div style={{
                            padding: '0.25rem 0.75rem',
                            borderRadius: '20px',
                            fontSize: '0.75rem',
                            fontWeight: '600',
                            background: section.completed
                              ? 'rgba(16, 185, 129, 0.2)'
                              : section.required
                                ? 'rgba(239, 68, 68, 0.2)'
                                : 'rgba(245, 158, 11, 0.2)',
                            color: section.completed
                              ? '#059669'
                              : section.required
                                ? '#dc2626'
                                : '#d97706'
                          }}>
                            {section.completed ? 'CONCLUÍDO' : section.required ? 'OBRIGATÓRIO' : 'OPCIONAL'}
                          </div>
                        </div>
                      </div>
                    </div>

                    <button
                      onClick={() => setCurrentSection(section.id)}
                      style={{
                        padding: '0.75rem 1.5rem',
                        background: section.completed
                          ? 'linear-gradient(135deg, #10b981, #059669)'
                          : 'linear-gradient(135deg, #6366f1, #4f46e5)',
                        color: 'white',
                        border: 'none',
                        borderRadius: '12px',
                        cursor: 'pointer',
                        fontSize: '0.875rem',
                        fontWeight: '600',
                        transition: 'all 0.2s ease',
                        display: 'flex',
                        alignItems: 'center',
                        gap: '0.5rem',
                        position: 'relative',
                        zIndex: 1,
                        boxShadow: '0 2px 8px rgba(0,0,0,0.15)'
                      }}
                      onMouseEnter={(e) => {
                        e.currentTarget.style.transform = 'translateY(-2px)';
                        e.currentTarget.style.boxShadow = '0 4px 16px rgba(0,0,0,0.25)';
                      }}
                      onMouseLeave={(e) => {
                        e.currentTarget.style.transform = 'translateY(0)';
                        e.currentTarget.style.boxShadow = '0 2px 8px rgba(0,0,0,0.15)';
                      }}
                    >
                      <Icon name={section.completed ? "edit" : "arrow-right"} />
                      {section.completed ? 'Revisar' : 'Completar'}
                    </button>
                  </div>
                ))}
              </div>
            </div>

            {/* Resumo dos Dados */}
            <div style={{
              display: 'grid',
              gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))',
              gap: '1rem',
              marginBottom: '2rem'
            }}>
              {/* Card Emitente */}
              {dados.emit?.xNome && (
                <div style={{
                  padding: '1rem',
                  border: '1px solid var(--color-border)',
                  borderRadius: '8px',
                  background: 'var(--color-background-secondary)'
                }}>
                  <h6 style={{ margin: '0 0 0.5rem 0', color: 'var(--color-text-primary)' }}>
                    🏢 Emitente
                  </h6>
                  <p style={{ margin: 0, fontSize: '0.875rem', color: 'var(--color-text-secondary)' }}>
                    <strong>{dados.emit.xNome}</strong><br />
                    {dados.emit.CNPJ || dados.emit.CPF}
                  </p>
                </div>
              )}

              {/* Card Veículo */}
              {dados.infModal?.rodo?.veicTracao?.placa && (
                <div style={{
                  padding: '1rem',
                  border: '1px solid var(--color-border)',
                  borderRadius: '8px',
                  background: 'var(--color-background-secondary)'
                }}>
                  <h6 style={{ margin: '0 0 0.5rem 0', color: 'var(--color-text-primary)' }}>
                    🚛 Veículo
                  </h6>
                  <p style={{ margin: 0, fontSize: '0.875rem', color: 'var(--color-text-secondary)' }}>
                    <strong>Placa:</strong> {dados.infModal.rodo.veicTracao.placa}<br />
                    <strong>Tara:</strong> {dados.infModal.rodo.veicTracao.tara} kg
                  </p>
                </div>
              )}

              {/* Card Trajeto */}
              {(locaisCarregamento.length > 0 || locaisDescarregamento.length > 0) && (
                <div style={{
                  padding: '1rem',
                  border: '1px solid var(--color-border)',
                  borderRadius: '8px',
                  background: 'var(--color-background-secondary)'
                }}>
                  <h6 style={{ margin: '0 0 0.5rem 0', color: 'var(--color-text-primary)' }}>
                    🗺️ Trajeto
                  </h6>
                  <p style={{ margin: 0, fontSize: '0.875rem', color: 'var(--color-text-secondary)' }}>
                    <strong>Carregamento:</strong> {locaisCarregamento.length} local(is)<br />
                    <strong>Descarregamento:</strong> {locaisDescarregamento.length} local(is)
                  </p>
                </div>
              )}

              {/* Card Carga */}
              {dados.tot?.vCarga && (
                <div style={{
                  padding: '1rem',
                  border: '1px solid var(--color-border)',
                  borderRadius: '8px',
                  background: 'var(--color-background-secondary)'
                }}>
                  <h6 style={{ margin: '0 0 0.5rem 0', color: 'var(--color-text-primary)' }}>
                    📦 Carga
                  </h6>
                  <p style={{ margin: 0, fontSize: '0.875rem', color: 'var(--color-text-secondary)' }}>
                    <strong>Valor:</strong> R$ {parseFloat(dados.tot.vCarga).toLocaleString('pt-BR', { minimumFractionDigits: 2 })}<br />
                    {dados.tot.qCarga && <><strong>Peso:</strong> {dados.tot.qCarga} {dados.tot.cUnid === '01' ? 'kg' : 'ton'}</>}
                  </p>
                </div>
              )}

              {/* Card Documentos */}
              <div style={{
                padding: '1rem',
                border: '1px solid var(--color-border)',
                borderRadius: '8px',
                background: 'var(--color-background-secondary)'
              }}>
                <h6 style={{ margin: '0 0 0.5rem 0', color: 'var(--color-text-primary)' }}>
                  📄 Documentos
                </h6>
                <p style={{ margin: 0, fontSize: '0.875rem', color: 'var(--color-text-secondary)' }}>
                  {dados.tot?.qCTe ? `${dados.tot.qCTe} CTe(s)` : '0 CTe(s)'}<br />
                  {dados.tot?.qNFe ? `${dados.tot.qNFe} NFe(s)` : '0 NFe(s)'}
                </p>
              </div>
            </div>

            {/* Validações Finais */}
            <div style={{
              padding: '1rem',
              border: todasSecoesCompletas ? '2px solid #10b981' : '2px solid #ef4444',
              borderRadius: '12px',
              background: todasSecoesCompletas ? 'rgba(16, 185, 129, 0.1)' : 'rgba(239, 68, 68, 0.1)',
              marginBottom: '2rem'
            }}>
              <h6 style={{
                margin: '0 0 1rem 0',
                color: 'var(--color-text-primary)',
                display: 'flex',
                alignItems: 'center',
                gap: '0.5rem'
              }}>
                {todasSecoesCompletas ? (
                  <Icon name="check-circle" style={{ color: '#10b981' }} />
                ) : (
                  <Icon name="alert-circle" style={{ color: '#ef4444' }} />
                )}
                Status de Validação
              </h6>

              {todasSecoesCompletas ? (
                <div style={{ color: '#10b981', fontSize: '0.875rem' }}>
                  ✅ <strong>MDFe pronto para emissão!</strong><br />
                  Todas as informações obrigatórias foram preenchidas corretamente.
                </div>
              ) : (
                <div style={{ color: '#ef4444', fontSize: '0.875rem' }}>
                  ❌ <strong>MDFe não pode ser emitido ainda.</strong><br />
                  Complete todas as seções obrigatórias antes de prosseguir.
                </div>
              )}
            </div>

            {/* Botões de Ação */}
            <div style={{
              display: 'flex',
              gap: '1rem',
              justifyContent: 'flex-end',
              borderTop: '1px solid var(--color-border)',
              paddingTop: '1rem'
            }}>
              <button
                onClick={onCancelar}
                style={{
                  padding: '0.75rem 1.5rem',
                  border: '1px solid var(--color-border)',
                  borderRadius: '8px',
                  background: 'transparent',
                  color: 'var(--color-text-primary)',
                  cursor: 'pointer',
                  fontSize: '0.875rem'
                }}
              >
                Cancelar
              </button>

              <button
                onClick={onSalvar}
                disabled={salvando || !todasSecoesCompletas}
                style={{
                  padding: '0.75rem 1.5rem',
                  border: 'none',
                  borderRadius: '8px',
                  background: todasSecoesCompletas
                    ? 'linear-gradient(135deg, #10b981, #059669)'
                    : 'var(--color-border)',
                  color: 'white',
                  cursor: todasSecoesCompletas ? 'pointer' : 'not-allowed',
                  fontSize: '0.875rem',
                  fontWeight: '600',
                  display: 'flex',
                  alignItems: 'center',
                  gap: '0.5rem',
                  opacity: todasSecoesCompletas ? 1 : 0.5
                }}
              >
                {salvando ? (
                  <>
                    <div className="spinner-border spinner-border-sm" role="status" />
                    Salvando...
                  </>
                ) : (
                  <>
                    <Icon name="save" />
                    Salvar MDFe
                  </>
                )}
              </button>

              {onTransmitir && todasSecoesCompletas && (
                <button
                  onClick={onTransmitir}
                  disabled={transmitindo || !todasSecoesCompletas}
                  style={{
                    padding: '0.75rem 1.5rem',
                    border: 'none',
                    borderRadius: '8px',
                    background: 'linear-gradient(135deg, #3b82f6, #1d4ed8)',
                    color: 'white',
                    cursor: todasSecoesCompletas ? 'pointer' : 'not-allowed',
                    fontSize: '0.875rem',
                    fontWeight: '600',
                    display: 'flex',
                    alignItems: 'center',
                    gap: '0.5rem',
                    opacity: todasSecoesCompletas ? 1 : 0.5
                  }}
                >
                  {transmitindo ? (
                    <>
                      <div className="spinner-border spinner-border-sm" role="status" />
                      Transmitindo...
                    </>
                  ) : (
                    <>
                      <Icon name="send" />
                      Transmitir para SEFAZ
                    </>
                  )}
                </button>
              )}
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

  const canProceed = () => {
    const currentSectionData = sections.find(s => s.id === currentSection);
    return currentSectionData?.completed || false;
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
        <div style={{
          position: 'absolute',
          top: 0,
          left: 0,
          right: 0,
          height: '4px',
          background: 'linear-gradient(90deg, #3b82f6, #1d4ed8)',
          borderRadius: '20px 20px 0 0'
        }}></div>

        <div style={{ display: 'flex', alignItems: 'center', gap: '1.5rem' }}>
          <div style={{
            width: '64px',
            height: '64px',
            background: 'linear-gradient(135deg, #3b82f6, #1d4ed8)',
            borderRadius: '16px',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            color: 'white',
            fontSize: '24px',
            fontWeight: 'bold',
            boxShadow: '0 8px 24px rgba(59, 130, 246, 0.3)'
          }}>
<i className={isEdicao ? 'fas fa-edit' : 'fas fa-plus'}></i>
          </div>
          <div>
            <h1 style={{
              margin: 0,
              fontSize: '2rem',
              fontWeight: '700',
              color: theme === 'dark' ? '#f9fafb' : '#1f2937',
              lineHeight: '1.2'
            }}>
              {isEdicao ? 'Editar MDF-e' : 'Novo MDF-e'}
            </h1>
            <p style={{
              margin: '0.5rem 0 0 0',
              color: theme === 'dark' ? '#d1d5db' : '#6b7280',
              fontSize: '1rem',
              fontWeight: '400'
            }}>
              {isEdicao ? 'Modifique as informações do manifesto' : 'Complete os dados para gerar o manifesto eletrônico'}
            </p>

            {/* Informações do MDF-e (Número e Série) - DESTAQUE */}
            {(dados.ide?.serie || dados.ide?.nMDF) && (
              <div style={{
                marginTop: '1.5rem',
                padding: '1.25rem 2rem',
                background: theme === 'dark'
                  ? 'linear-gradient(135deg, rgba(16, 185, 129, 0.15) 0%, rgba(59, 130, 246, 0.15) 100%)'
                  : 'linear-gradient(135deg, rgba(16, 185, 129, 0.08) 0%, rgba(59, 130, 246, 0.08) 100%)',
                border: theme === 'dark'
                  ? '2px solid rgba(16, 185, 129, 0.4)'
                  : '2px solid rgba(16, 185, 129, 0.3)',
                borderRadius: '16px',
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center',
                position: 'relative',
                overflow: 'hidden',
                boxShadow: theme === 'dark'
                  ? '0 8px 32px rgba(16, 185, 129, 0.2)'
                  : '0 8px 32px rgba(16, 185, 129, 0.15)'
              }}>
                {/* Barra superior destacada */}
                <div style={{
                  position: 'absolute',
                  top: 0,
                  left: 0,
                  right: 0,
                  height: '4px',
                  background: 'linear-gradient(90deg, #10b981, #3b82f6)',
                }}></div>


                {/* Informações de número e série */}
                <div style={{
                  display: 'flex',
                  alignItems: 'center',
                  gap: '2rem'
                }}>
                  {dados.ide?.nMDF && (
                    <div style={{
                      textAlign: 'center',
                      padding: '0.75rem 1.25rem',
                      background: theme === 'dark'
                        ? 'rgba(255, 255, 255, 0.1)'
                        : 'rgba(255, 255, 255, 0.8)',
                      borderRadius: '12px',
                      border: theme === 'dark'
                        ? '1px solid rgba(255, 255, 255, 0.2)'
                        : '1px solid rgba(59, 130, 246, 0.2)',
                      minWidth: '120px'
                    }}>
                      <div style={{
                        fontSize: '0.75rem',
                        fontWeight: '600',
                        color: theme === 'dark' ? '#94a3b8' : '#6b7280',
                        textTransform: 'uppercase',
                        letterSpacing: '0.05em',
                        marginBottom: '0.25rem'
                      }}>
                        NÚMERO
                      </div>
                      <div style={{
                        fontSize: '1.25rem',
                        fontWeight: '800',
                        color: '#3b82f6',
                        lineHeight: '1'
                      }}>
                        {dados.ide.nMDF}
                      </div>
                    </div>
                  )}
                  {dados.ide?.serie && (
                    <div style={{
                      textAlign: 'center',
                      padding: '0.75rem 1.25rem',
                      background: theme === 'dark'
                        ? 'rgba(255, 255, 255, 0.1)'
                        : 'rgba(255, 255, 255, 0.8)',
                      borderRadius: '12px',
                      border: theme === 'dark'
                        ? '1px solid rgba(255, 255, 255, 0.2)'
                        : '1px solid rgba(16, 185, 129, 0.2)',
                      minWidth: '100px'
                    }}>
                      <div style={{
                        fontSize: '0.75rem',
                        fontWeight: '600',
                        color: theme === 'dark' ? '#94a3b8' : '#6b7280',
                        textTransform: 'uppercase',
                        letterSpacing: '0.05em',
                        marginBottom: '0.25rem'
                      }}>
                        SÉRIE
                      </div>
                      <div style={{
                        fontSize: '1.25rem',
                        fontWeight: '800',
                        color: '#10b981',
                        lineHeight: '1'
                      }}>
                        {dados.ide.serie}
                      </div>
                    </div>
                  )}
                </div>

              </div>
            )}
          </div>
        </div>

        <div style={{ display: 'flex', gap: '1rem' }}>
          <button
            type="button"
            onClick={onCancelar}
            style={{
              display: 'flex',
              alignItems: 'center',
              gap: '0.5rem',
              padding: '0.875rem 1.5rem',
              background: 'transparent',
              color: '#dc2626',
              border: '2px solid #dc2626',
              borderRadius: '12px',
              cursor: 'pointer',
              fontWeight: '600',
              fontSize: '0.875rem',
              transition: 'all 0.3s ease'
            }}
            onMouseEnter={(e) => {
              e.currentTarget.style.background = '#dc2626';
              e.currentTarget.style.borderColor = '#dc2626';
              e.currentTarget.style.color = '#ffffff';
            }}
            onMouseLeave={(e) => {
              e.currentTarget.style.background = 'transparent';
              e.currentTarget.style.borderColor = '#dc2626';
              e.currentTarget.style.color = '#dc2626';
            }}
          >
            <Icon name="times" />
            Cancelar
          </button>
          <button
            type="button"
            onClick={onSalvar}
            disabled={salvando || transmitindo}
            style={{
              display: 'flex',
              alignItems: 'center',
              gap: '0.5rem',
              padding: '0.875rem 1.5rem',
              background: 'linear-gradient(135deg, #3b82f6, #1d4ed8)',
              color: 'white',
              border: 'none',
              borderRadius: '12px',
              cursor: (salvando || transmitindo) ? 'not-allowed' : 'pointer',
              fontWeight: '600',
              fontSize: '0.875rem',
              transition: 'all 0.3s ease',
              boxShadow: '0 4px 16px rgba(59, 130, 246, 0.3)',
              opacity: (salvando || transmitindo) ? 0.7 : 1
            }}
            onMouseEnter={(e) => {
              if (!salvando && !transmitindo) {
                e.currentTarget.style.transform = 'translateY(-2px)';
                e.currentTarget.style.boxShadow = '0 8px 24px rgba(59, 130, 246, 0.4)';
              }
            }}
            onMouseLeave={(e) => {
              if (!salvando && !transmitindo) {
                e.currentTarget.style.transform = 'translateY(0)';
                e.currentTarget.style.boxShadow = '0 4px 16px rgba(59, 130, 246, 0.3)';
              }
            }}
          >
            <Icon name={salvando ? 'spinner' : 'save'} />
            {salvando ? 'Salvando...' : 'Salvar MDF-e'}
          </button>

          {onTransmitir && sections.every(section => section.completed) && (
            <button
              type="button"
              onClick={onTransmitir}
              disabled={salvando || transmitindo}
              style={{
                display: 'flex',
                alignItems: 'center',
                gap: '0.5rem',
                padding: '0.875rem 1.5rem',
                background: 'linear-gradient(135deg, #10b981, #059669)',
                color: 'white',
                border: 'none',
                borderRadius: '12px',
                cursor: (salvando || transmitindo) ? 'not-allowed' : 'pointer',
                fontWeight: '600',
                fontSize: '0.875rem',
                transition: 'all 0.3s ease',
                boxShadow: '0 4px 16px rgba(16, 185, 129, 0.3)',
                opacity: (salvando || transmitindo) ? 0.7 : 1
              }}
              onMouseEnter={(e) => {
                if (!salvando && !transmitindo) {
                  e.currentTarget.style.transform = 'translateY(-2px)';
                  e.currentTarget.style.boxShadow = '0 8px 24px rgba(16, 185, 129, 0.4)';
                }
              }}
              onMouseLeave={(e) => {
                if (!salvando && !transmitindo) {
                  e.currentTarget.style.transform = 'translateY(0)';
                  e.currentTarget.style.boxShadow = '0 4px 16px rgba(16, 185, 129, 0.3)';
                }
              }}
            >
              <i className={transmitindo ? "fas fa-spinner fa-spin" : "fas fa-paper-plane"}></i>
              {transmitindo ? 'Transmitindo...' : 'Transmitir para SEFAZ'}
            </button>
          )}
        </div>
      </header>

      <div style={{ display: 'flex', gap: 'var(--space-6)', minHeight: '600px' }}>
        {/* Sidebar Moderna com seções */}
        <div style={{ flexShrink: 0, width: '320px' }}>
          <div style={{
            background: theme === 'dark' ? '#1f2937' : 'white',
            borderRadius: '20px',
            border: theme === 'dark'
              ? '1px solid rgba(55, 65, 81, 0.5)'
              : '1px solid rgba(229, 231, 235, 0.5)',
            boxShadow: theme === 'dark'
              ? '0 4px 20px rgba(0, 0, 0, 0.3)'
              : '0 4px 20px rgba(0, 0, 0, 0.08)',
            overflow: 'hidden'
          }}>
            <div style={{
              padding: '1.5rem 2rem',
              background: theme === 'dark'
                ? 'linear-gradient(135deg, #374151 0%, #1f2937 100%)'
                : 'linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%)',
              borderBottom: theme === 'dark'
                ? '1px solid rgba(55, 65, 81, 0.3)'
                : '1px solid rgba(229, 231, 235, 0.3)'
            }}>
              <h3 style={{
                margin: 0,
                fontSize: '1.25rem',
                fontWeight: '700',
                color: theme === 'dark' ? '#f9fafb' : '#1f2937',
                display: 'flex',
                alignItems: 'center',
                gap: '0.75rem'
              }}>
                <div style={{
                  width: '32px',
                  height: '32px',
                  background: 'linear-gradient(135deg, #3b82f6, #1d4ed8)',
                  borderRadius: '8px',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  color: 'white',
                  fontSize: '14px'
                }}>
                  <Icon name="list" />
                </div>
                Etapas do MDF-e
              </h3>
            </div>
            <div style={{ padding: 0 }}>
              {sections.map((section, index) => (
                <button
                  key={section.id}
                  onClick={() => setCurrentSection(section.id)}
                  style={{
                    width: '100%',
                    textAlign: 'left',
                    padding: '1.25rem 2rem',
                    border: 'none',
                    borderBottom: '1px solid rgba(229, 231, 235, 0.2)',
                    background: currentSection === section.id
                      ? 'linear-gradient(90deg, rgba(59, 130, 246, 0.1) 0%, rgba(59, 130, 246, 0.05) 100%)'
                      : 'transparent',
                    cursor: 'pointer',
                    transition: 'all 0.3s ease',
                    borderLeft: currentSection === section.id ? '4px solid #3b82f6' : '4px solid transparent',
                    position: 'relative'
                  }}
                >
                  <div style={{ display: 'flex', alignItems: 'center', gap: '1rem' }}>
                    <div style={{
                      width: '40px',
                      height: '40px',
                      borderRadius: '12px',
                      display: 'flex',
                      alignItems: 'center',
                      justifyContent: 'center',
                      fontSize: '0.875rem',
                      fontWeight: '600',
                      background: section.completed
                        ? 'linear-gradient(135deg, #10b981, #059669)'
                        : currentSection === section.id
                        ? 'linear-gradient(135deg, #3b82f6, #1d4ed8)'
                        : 'linear-gradient(135deg, #f3f4f6, #e5e7eb)',
                      color: section.completed || currentSection === section.id ? 'white' : '#6b7280',
                      transition: 'all 0.3s ease',
                      boxShadow: section.completed || currentSection === section.id
                        ? '0 4px 12px rgba(59, 130, 246, 0.3)'
                        : 'none'
                    }}>
                      {section.completed ? <Icon name="check" /> : index + 1}
                    </div>
                    <div style={{ flex: 1 }}>
                      <div style={{
                        fontWeight: '600',
                        color: theme === 'dark'
                          ? (currentSection === section.id ? '#f9fafb' : '#e2e8f0')
                          : (currentSection === section.id ? '#1f2937' : '#374151'),
                        fontSize: '0.9rem',
                        marginBottom: '0.25rem'
                      }}>
                        {section.title}
                      </div>
                      <div style={{
                        fontSize: '0.75rem',
                        color: theme === 'dark' ? '#94a3b8' : '#6b7280',
                        lineHeight: '1.3'
                      }}>
                        {section.description}
                      </div>
                    </div>
                    {section.completed && (
                      <div style={{
                        width: '8px',
                        height: '8px',
                        borderRadius: '50%',
                        background: '#10b981'
                      }}></div>
                    )}
                  </div>
                </button>
              ))}
            </div>
          </div>
        </div>

        {/* Conteúdo principal */}
        <div style={{ flex: 1 }}>
          <div style={{
            background: theme === 'dark' ? '#1f2937' : 'white',
            borderRadius: '20px',
            border: theme === 'dark'
              ? '1px solid rgba(55, 65, 81, 0.5)'
              : '1px solid rgba(229, 231, 235, 0.5)',
            boxShadow: theme === 'dark'
              ? '0 4px 20px rgba(0, 0, 0, 0.3)'
              : '0 4px 20px rgba(0, 0, 0, 0.08)',
            overflow: 'hidden',
            minHeight: '600px'
          }}>
            {/* Header da seção ativa */}
            <div style={{
              padding: '2rem 2.5rem 1.5rem',
              background: theme === 'dark'
                ? 'linear-gradient(135deg, #374151 0%, #1f2937 100%)'
                : 'linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%)',
              borderBottom: theme === 'dark'
                ? '1px solid rgba(55, 65, 81, 0.3)'
                : '1px solid rgba(229, 231, 235, 0.3)',
              position: 'relative'
            }}>
              {/* Barra de progresso */}
              <div style={{
                position: 'absolute',
                top: 0,
                left: 0,
                right: 0,
                height: '4px',
                background: 'rgba(229, 231, 235, 0.3)'
              }}>
                <div style={{
                  height: '100%',
                  background: 'linear-gradient(90deg, #3b82f6, #1d4ed8)',
                  width: `${((sections.findIndex(s => s.id === currentSection) + 1) / sections.length) * 100}%`,
                  transition: 'width 0.3s ease'
                }}></div>
              </div>

              <div style={{ display: 'flex', alignItems: 'center', gap: '1.5rem' }}>
                <div style={{
                  width: '56px',
                  height: '56px',
                  borderRadius: '16px',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  fontSize: '24px',
                  background: sections.find(s => s.id === currentSection)?.completed
                    ? 'linear-gradient(135deg, #10b981, #059669)'
                    : 'linear-gradient(135deg, #3b82f6, #1d4ed8)',
                  color: 'white',
                  boxShadow: '0 8px 24px rgba(59, 130, 246, 0.3)'
                }}>
                  {sections.find(s => s.id === currentSection)?.completed ?
                    <Icon name="check" /> :
                    <Icon name="edit" />
                  }
                </div>
                <div style={{ flex: 1 }}>
                  <h3 style={{
                    margin: 0,
                    fontSize: '1.5rem',
                    fontWeight: '700',
                    color: theme === 'dark' ? '#f9fafb' : '#1f2937',
                    marginBottom: '0.5rem'
                  }}>
                    {sections.find(s => s.id === currentSection)?.title}
                  </h3>
                  <p style={{
                    margin: 0,
                    fontSize: '1rem',
                    color: theme === 'dark' ? '#d1d5db' : '#6b7280',
                    fontWeight: '400'
                  }}>
                    {sections.find(s => s.id === currentSection)?.description}
                  </p>
                </div>
                <div style={{
                  display: 'flex',
                  alignItems: 'center',
                  gap: '0.5rem',
                  padding: '0.5rem 1rem',
                  background: 'rgba(59, 130, 246, 0.1)',
                  borderRadius: '8px',
                  fontSize: '0.875rem',
                  fontWeight: '600',
                  color: '#3b82f6'
                }}>
                  <Icon name="layers" />
                  {sections.findIndex(s => s.id === currentSection) + 1} de {sections.length}
                </div>
              </div>
            </div>

            {/* Conteúdo da seção */}
            <div style={{ padding: '2.5rem' }}>
              {renderSectionContent()}
            </div>

            {/* Footer com navegação */}
            <div style={{
              padding: '1.5rem 2.5rem',
              borderTop: theme === 'dark'
                ? '1px solid rgba(55, 65, 81, 0.3)'
                : '1px solid rgba(229, 231, 235, 0.3)',
              background: theme === 'dark'
                ? 'rgba(55, 65, 81, 0.3)'
                : 'rgba(248, 250, 252, 0.5)',
              display: 'flex',
              justifyContent: 'space-between',
              alignItems: 'center'
            }}>
              <button
                onClick={prevSection}
                disabled={sections.findIndex(s => s.id === currentSection) === 0}
                style={{
                  display: 'flex',
                  alignItems: 'center',
                  gap: '0.5rem',
                  padding: '0.75rem 1.5rem',
                  background: 'transparent',
                  color: sections.findIndex(s => s.id === currentSection) === 0 ? '#9ca3af' : '#6b7280',
                  border: '2px solid',
                  borderColor: sections.findIndex(s => s.id === currentSection) === 0 ? '#e5e7eb' : '#d1d5db',
                  borderRadius: '12px',
                  cursor: sections.findIndex(s => s.id === currentSection) === 0 ? 'not-allowed' : 'pointer',
                  fontWeight: '600',
                  fontSize: '0.875rem',
                  transition: 'all 0.3s ease',
                  opacity: sections.findIndex(s => s.id === currentSection) === 0 ? 0.5 : 1
                }}
                onMouseEnter={(e) => {
                  if (sections.findIndex(s => s.id === currentSection) !== 0) {
                    e.currentTarget.style.background = 'rgba(59, 130, 246, 0.05)';
                    e.currentTarget.style.borderColor = '#3b82f6';
                    e.currentTarget.style.color = '#3b82f6';
                  }
                }}
                onMouseLeave={(e) => {
                  if (sections.findIndex(s => s.id === currentSection) !== 0) {
                    e.currentTarget.style.background = 'transparent';
                    e.currentTarget.style.borderColor = '#d1d5db';
                    e.currentTarget.style.color = '#6b7280';
                  }
                }}
              >
                <Icon name="arrow-left" />
                Anterior
              </button>

              <div style={{
                display: 'flex',
                alignItems: 'center',
                gap: '0.5rem',
                color: theme === 'dark' ? '#d1d5db' : '#6b7280',
                fontSize: '0.875rem',
                fontWeight: '500'
              }}>
                <Icon name="info-circle" />
                {sections.filter(s => s.completed).length} de {sections.length} seções concluídas
              </div>

              <button
                onClick={nextSection}
                disabled={sections.findIndex(s => s.id === currentSection) === sections.length - 1}
                style={{
                  display: 'flex',
                  alignItems: 'center',
                  gap: '0.5rem',
                  padding: '0.75rem 1.5rem',
                  background: sections.findIndex(s => s.id === currentSection) === sections.length - 1
                    ? 'transparent'
                    : 'linear-gradient(135deg, #3b82f6, #1d4ed8)',
                  color: sections.findIndex(s => s.id === currentSection) === sections.length - 1 ? '#9ca3af' : 'white',
                  border: '2px solid',
                  borderColor: sections.findIndex(s => s.id === currentSection) === sections.length - 1 ? '#e5e7eb' : 'transparent',
                  borderRadius: '12px',
                  cursor: sections.findIndex(s => s.id === currentSection) === sections.length - 1 ? 'not-allowed' : 'pointer',
                  fontWeight: '600',
                  fontSize: '0.875rem',
                  transition: 'all 0.3s ease',
                  boxShadow: sections.findIndex(s => s.id === currentSection) === sections.length - 1
                    ? 'none'
                    : '0 4px 16px rgba(59, 130, 246, 0.3)',
                  opacity: sections.findIndex(s => s.id === currentSection) === sections.length - 1 ? 0.5 : 1
                }}
                onMouseEnter={(e) => {
                  if (sections.findIndex(s => s.id === currentSection) !== sections.length - 1) {
                    e.currentTarget.style.transform = 'translateY(-2px)';
                    e.currentTarget.style.boxShadow = '0 8px 24px rgba(59, 130, 246, 0.4)';
                  }
                }}
                onMouseLeave={(e) => {
                  if (sections.findIndex(s => s.id === currentSection) !== sections.length - 1) {
                    e.currentTarget.style.transform = 'translateY(0)';
                    e.currentTarget.style.boxShadow = '0 4px 16px rgba(59, 130, 246, 0.3)';
                  }
                }}
              >
                Próximo
                <Icon name="arrow-right" />
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
