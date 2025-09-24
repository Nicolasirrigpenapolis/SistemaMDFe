import React, { useState, useEffect } from 'react';
import { MDFeData } from '../../../types/mdfe';
import { entitiesService, EntityOption } from '../../../services/entitiesService';
import { LocalCarregamento, localidadeService } from '../../../services/localidadeService';
import { useTheme } from '../../../contexts/ThemeContext';
import { LocalidadeSelector } from './LocalidadeSelector';
import { formatCNPJ, formatCPF, formatPlaca, cleanNumericString, cleanPlaca, applyMask } from '../../../utils/formatters';
import Icon from '../Icon';

interface MDFeWizardProps {
  dados: Partial<MDFeData>;
  onDadosChange: (dados: Partial<MDFeData>) => void;
  onSalvar: () => void;
  onCancelar: () => void;
  salvando: boolean;
  isEdicao: boolean;
}

interface WizardSection {
  id: string;
  title: string;
  description: string;
  required: boolean;
  completed: boolean;
}

export function MDFeWizard({ dados, onDadosChange, onSalvar, onCancelar, salvando, isEdicao }: MDFeWizardProps) {
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

  const sections: WizardSection[] = [
    {
      id: 'emitente',
      title: 'Emitente',
      description: 'Dados do emitente do manifesto',
      required: true,
      completed: !!(dados.emit?.CNPJ && dados.emit?.xNome)
    },
    {
      id: 'veiculo',
      title: 'Veículo',
      description: 'Dados do veículo de transporte',
      required: true,
      completed: !!(dados.infModal?.rodo?.veicTracao?.placa && dados.infModal?.rodo?.veicTracao?.tara)
    },
    {
      id: 'condutor',
      title: 'Condutor',
      description: 'Dados do condutor responsável',
      required: false,
      completed: !!(dados.infModal?.rodo?.infANTT?.infCIOT?.[0]?.CPF && dados.infModal?.rodo?.veicTracao?.condutor?.[0]?.xNome)
    },
    {
      id: 'trajeto',
      title: 'Trajeto',
      description: 'Rota e percurso da viagem',
      required: true,
      completed: !!(locaisCarregamento.length > 0 && locaisDescarregamento.length > 0 &&
        locaisCarregamento.every(l => l.municipio && l.uf) &&
        locaisDescarregamento.every(l => l.municipio && l.uf))
    },
    {
      id: 'carga',
      title: 'Carga',
      description: 'Informações sobre a carga transportada',
      required: true,
      completed: !!(dados.tot?.vCarga && parseFloat(dados.tot.vCarga) > 0)
    },
    {
      id: 'documentos',
      title: 'Documentos Vinculados',
      description: 'CTe/NFe vinculados ao manifesto',
      required: true,
      completed: !!dados.infDoc?.infMunDescarga?.some(descarga =>
        descarga.infNFe?.length || descarga.infCTe?.length
      )
    }
  ];

  useEffect(() => {
    loadEntities();
  }, []);

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
      console.log('🏢 [MDFeWizard] Emitente selecionado:', emitente);
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
      console.log('👨‍💼 [MDFeWizard] Condutor selecionado:', condutor);
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
          infANTT: {
            ...dados.infModal?.rodo?.infANTT,
            infCIOT: [{
              CIOT: '',
              CPF: condutor.data.CPF
            }]
          }
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
          infANTT: {
            ...dados.infModal?.rodo?.infANTT,
            infCIOT: undefined
          }
        }
      });
    }
  };

  const handleVeiculoSelect = (veiculoId: string) => {
    setSelectedVeiculoId(veiculoId);
    const veiculo = veiculos.find(v => v.id === veiculoId);
    if (veiculo && veiculo.data) {
      console.log('🚛 [MDFeWizard] Veículo selecionado:', veiculo);
      atualizarSecao('infModal', {
        rodo: {
          veicTracao: {
            cInt: veiculo.data.cInt,
            placa: veiculo.data.placa,
            RENAVAM: veiculo.data.RENAVAM,
            tara: veiculo.data.tara,
            capKG: veiculo.data.capKG,
            capM3: veiculo.data.capM3,
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
            RENAVAM: '',
            tara: '',
            capKG: '',
            capM3: '',
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
    if (documentChave && documentChave.length === 44) {
      const currentDescarga = dados.infDoc?.infMunDescarga || [];
      const newDescarga = [...currentDescarga];

      if (newDescarga.length === 0) {
        newDescarga.push({
          cMunDescarga: '',
          xMunDescarga: '',
          infCTe: [{ chCTe: documentChave }],
          infNFe: []
        });
      } else {
        if (!newDescarga[0].infCTe) {
          newDescarga[0].infCTe = [];
        }
        newDescarga[0].infCTe.push({ chCTe: documentChave });
      }

      atualizarSecao('infDoc', {
        infMunDescarga: newDescarga
      });

      // Atualizar contadores
      const qCTe = newDescarga[0]?.infCTe?.length || 0;
      atualizarCampo('tot', 'qCTe', qCTe.toString());

      setDocumentChave('');
      setShowCTeModal(false);
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
    atualizarPercursoMDFe(novosLocais, locaisDescarregamento);
  };

  const atualizarLocaisDescarregamento = (novosLocais: LocalCarregamento[]) => {
    setLocaisDescarregamento(novosLocais);
    atualizarPercursoMDFe(locaisCarregamento, novosLocais);
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

    // Atualizar municípios de carregamento
    const infMunCarrega = carregamento.map(local => ({
      cMunCarrega: local.codigoIBGE.toString(),
      xMunCarrega: local.municipio
    }));

    atualizarCampo('ide', 'infMunCarrega', infMunCarrega);

    // Atualizar informações de descarga nos documentos
    const infMunDescarga = descarregamento.map(local => ({
      cMunDescarga: local.codigoIBGE.toString(),
      xMunDescarga: local.municipio,
      infCTe: dados.infDoc?.infMunDescarga?.[0]?.infCTe || [],
      infNFe: dados.infDoc?.infMunDescarga?.[0]?.infNFe || []
    }));

    atualizarSecao('infDoc', {
      infMunDescarga: infMunDescarga
    });
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
                <label className="label">RENAVAM</label>
                <input
                  type="text"
                  className="input"
                  value={dados.infModal?.rodo?.veicTracao?.RENAVAM || ''}
                  onChange={(e) => atualizarVeiculo('RENAVAM', e.target.value)}
                  placeholder="RENAVAM"
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

              <div>
                <label className="label">Capacidade (kg)</label>
                <input
                  type="number"
                  className="input"
                  value={dados.infModal?.rodo?.veicTracao?.capKG || ''}
                  onChange={(e) => atualizarVeiculo('capKG', e.target.value)}
                  placeholder="Capacidade máxima"
                />
              </div>

              <div>
                <label className="label">Capacidade (m³)</label>
                <input
                  type="number"
                  className="input"
                  value={dados.infModal?.rodo?.veicTracao?.capM3 || ''}
                  onChange={(e) => atualizarVeiculo('capM3', e.target.value)}
                  placeholder="Volume máximo"
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
                        infANTT: {
                          ...dados.infModal?.rodo?.infANTT,
                          infCIOT: [{
                            ...dados.infModal?.rodo?.infANTT?.infCIOT?.[0],
                            CPF: cpf
                          }]
                        }
                      }
                    });
                  }}
                  placeholder="000.000.000-00"
                  maxLength={14}
                />
              </div>

              <div>
                <label className="label">CIOT</label>
                <input
                  type="text"
                  className="input"
                  value={dados.infModal?.rodo?.infANTT?.infCIOT?.[0]?.CIOT || ''}
                  onChange={(e) => atualizarSecao('infModal', {
                    ...dados.infModal,
                    rodo: {
                      ...dados.infModal?.rodo,
                      infANTT: {
                        ...dados.infModal?.rodo?.infANTT,
                        infCIOT: [{
                          ...dados.infModal?.rodo?.infANTT?.infCIOT?.[0],
                          CIOT: e.target.value
                        }]
                      }
                    }
                  })}
                  placeholder="Código CIOT (opcional)"
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
                <li>O CIOT é obrigatório apenas para alguns tipos de transporte</li>
                <li>Deixe em branco se não se aplica ao seu caso</li>
              </ul>
            </div>
          </div>
        );

      case 'trajeto':
        return (
          <div className="card-body">
            <h4>Configurar Trajeto da Viagem</h4>
            <p className="mb-4" style={{ color: 'var(--color-text-secondary)' }}>
              Defina os locais de carregamento e descarregamento. A rota será calculada automaticamente.
            </p>

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
            />


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
                Como Funciona o Trajeto Inteligente
              </h6>
              <ul style={{
                margin: 0,
                paddingLeft: '1.5rem',
                color: 'var(--color-text-secondary)',
                fontSize: '0.875rem',
                lineHeight: '1.5'
              }}>
                <li>Adicione múltiplos locais de carregamento (onde pega a carga)</li>
                <li>Adicione múltiplos locais de descarregamento (onde entrega a carga)</li>
                <li>O sistema calcula automaticamente a rota mais eficiente</li>
                <li>Os estados de percurso são incluídos automaticamente no MDF-e</li>
                <li>Os códigos IBGE dos municípios são obtidos automaticamente</li>
              </ul>
            </div>
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
              <div style={{
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'space-between',
                marginBottom: 'var(--space-4)'
              }}>
                <h5 style={{
                  margin: 0,
                  fontSize: '1.1rem',
                  fontWeight: '600',
                  color: 'var(--color-text-primary)',
                  display: 'flex',
                  alignItems: 'center',
                  gap: '0.5rem'
                }}>
                  <Icon name="file-text" />
                  Conhecimentos de Transporte (CT-e)
                </h5>
                <button
                  type="button"
                  onClick={() => setShowCTeModal(true)}
                  style={{
                    display: 'flex',
                    alignItems: 'center',
                    gap: '0.5rem',
                    padding: '0.5rem 1rem',
                    background: 'linear-gradient(135deg, #3b82f6, #1d4ed8)',
                    color: 'white',
                    border: 'none',
                    borderRadius: '8px',
                    cursor: 'pointer',
                    fontWeight: '600',
                    fontSize: '0.875rem',
                    transition: 'all 0.3s ease'
                  }}
                  onMouseEnter={(e) => {
                    e.currentTarget.style.transform = 'translateY(-1px)';
                    e.currentTarget.style.boxShadow = '0 4px 12px rgba(59, 130, 246, 0.3)';
                  }}
                  onMouseLeave={(e) => {
                    e.currentTarget.style.transform = 'translateY(0)';
                    e.currentTarget.style.boxShadow = 'none';
                  }}
                >
                  <Icon name="plus" />
                  Adicionar CT-e
                </button>
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
                        <Icon name="trash" />
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
              <div style={{
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'space-between',
                marginBottom: 'var(--space-4)'
              }}>
                <h5 style={{
                  margin: 0,
                  fontSize: '1.1rem',
                  fontWeight: '600',
                  color: 'var(--color-text-primary)',
                  display: 'flex',
                  alignItems: 'center',
                  gap: '0.5rem'
                }}>
                  <Icon name="file-invoice" />
                  Notas Fiscais eletrônicas (NF-e)
                </h5>
                <button
                  type="button"
                  onClick={() => setShowNFeModal(true)}
                  style={{
                    display: 'flex',
                    alignItems: 'center',
                    gap: '0.5rem',
                    padding: '0.5rem 1rem',
                    background: 'linear-gradient(135deg, #10b981, #059669)',
                    color: 'white',
                    border: 'none',
                    borderRadius: '8px',
                    cursor: 'pointer',
                    fontWeight: '600',
                    fontSize: '0.875rem',
                    transition: 'all 0.3s ease'
                  }}
                  onMouseEnter={(e) => {
                    e.currentTarget.style.transform = 'translateY(-1px)';
                    e.currentTarget.style.boxShadow = '0 4px 12px rgba(16, 185, 129, 0.3)';
                  }}
                  onMouseLeave={(e) => {
                    e.currentTarget.style.transform = 'translateY(0)';
                    e.currentTarget.style.boxShadow = 'none';
                  }}
                >
                  <Icon name="plus" />
                  Adicionar NF-e
                </button>
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
                        <Icon name="trash" />
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
                Informações sobre Documentos Vinculados
              </h6>
              <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 'var(--space-4)' }}>
                <ul style={{
                  margin: 0,
                  paddingLeft: '1.5rem',
                  color: 'var(--color-text-secondary)',
                  fontSize: '0.875rem',
                  lineHeight: '1.5'
                }}>
                  <li>CT-e: Para transporte de cargas de terceiros</li>
                  <li>NF-e: Para mercadorias próprias ou remetidas</li>
                  <li>Chaves devem ter 44 dígitos</li>
                </ul>
                <ul style={{
                  margin: 0,
                  paddingLeft: '1.5rem',
                  color: 'var(--color-text-secondary)',
                  fontSize: '0.875rem',
                  lineHeight: '1.5'
                }}>
                  <li>Documentos devem estar autorizados</li>
                  <li>Valores são calculados automaticamente</li>
                  <li>Pelo menos um documento é obrigatório</li>
                </ul>
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
            disabled={salvando}
            style={{
              display: 'flex',
              alignItems: 'center',
              gap: '0.5rem',
              padding: '0.875rem 1.5rem',
              background: 'linear-gradient(135deg, #3b82f6, #1d4ed8)',
              color: 'white',
              border: 'none',
              borderRadius: '12px',
              cursor: salvando ? 'not-allowed' : 'pointer',
              fontWeight: '600',
              fontSize: '0.875rem',
              transition: 'all 0.3s ease',
              boxShadow: '0 4px 16px rgba(59, 130, 246, 0.3)',
              opacity: salvando ? 0.7 : 1
            }}
            onMouseEnter={(e) => {
              if (!salvando) {
                e.currentTarget.style.transform = 'translateY(-2px)';
                e.currentTarget.style.boxShadow = '0 8px 24px rgba(59, 130, 246, 0.4)';
              }
            }}
            onMouseLeave={(e) => {
              if (!salvando) {
                e.currentTarget.style.transform = 'translateY(0)';
                e.currentTarget.style.boxShadow = '0 4px 16px rgba(59, 130, 246, 0.3)';
              }
            }}
          >
            <Icon name={salvando ? 'spinner' : 'save'} />
            {salvando ? 'Salvando...' : 'Salvar MDF-e'}
          </button>
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

      {/* Modal CT-e */}
      {showCTeModal && (
        <div style={{
          position: 'fixed',
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          background: 'rgba(0, 0, 0, 0.5)',
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'center',
          zIndex: 1000
        }}>
          <div style={{
            background: theme === 'dark' ? '#1f2937' : 'white',
            borderRadius: '16px',
            padding: '2rem',
            width: '500px',
            maxWidth: '90vw',
            boxShadow: '0 20px 50px rgba(0, 0, 0, 0.3)'
          }}>
            <h3 style={{
              margin: '0 0 1rem 0',
              color: theme === 'dark' ? '#f9fafb' : '#1f2937',
              display: 'flex',
              alignItems: 'center',
              gap: '0.5rem'
            }}>
              <Icon name="file-text" />
              Adicionar CT-e
            </h3>
            <p style={{
              margin: '0 0 1.5rem 0',
              color: theme === 'dark' ? '#d1d5db' : '#6b7280',
              fontSize: '0.875rem'
            }}>
              Digite a chave de acesso do Conhecimento de Transporte eletrônico (44 dígitos)
            </p>
            <input
              type="text"
              value={documentChave}
              onChange={(e) => setDocumentChave(e.target.value.replace(/\D/g, '').slice(0, 44))}
              placeholder="Chave de acesso (44 dígitos)"
              style={{
                width: '100%',
                padding: '0.75rem',
                border: `2px solid ${theme === 'dark' ? '#374151' : '#d1d5db'}`,
                borderRadius: '8px',
                fontSize: '0.875rem',
                fontFamily: 'monospace',
                background: theme === 'dark' ? '#374151' : 'white',
                color: theme === 'dark' ? '#f9fafb' : '#1f2937',
                marginBottom: '1.5rem'
              }}
              maxLength={44}
            />
            <div style={{
              display: 'flex',
              gap: '1rem',
              justifyContent: 'flex-end'
            }}>
              <button
                onClick={() => {
                  setShowCTeModal(false);
                  setDocumentChave('');
                }}
                style={{
                  padding: '0.75rem 1.5rem',
                  background: 'transparent',
                  color: '#dc2626',
                  border: '2px solid #dc2626',
                  borderRadius: '8px',
                  cursor: 'pointer',
                  fontWeight: '600'
                }}
              >
                Cancelar
              </button>
              <button
                onClick={addCTe}
                disabled={documentChave.length !== 44}
                style={{
                  padding: '0.75rem 1.5rem',
                  background: documentChave.length === 44
                    ? 'linear-gradient(135deg, #3b82f6, #1d4ed8)'
                    : '#9ca3af',
                  color: 'white',
                  border: 'none',
                  borderRadius: '8px',
                  cursor: documentChave.length === 44 ? 'pointer' : 'not-allowed',
                  fontWeight: '600'
                }}
              >
                Adicionar
              </button>
            </div>
          </div>
        </div>
      )}

      {/* Modal NF-e */}
      {showNFeModal && (
        <div style={{
          position: 'fixed',
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          background: 'rgba(0, 0, 0, 0.5)',
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'center',
          zIndex: 1000
        }}>
          <div style={{
            background: theme === 'dark' ? '#1f2937' : 'white',
            borderRadius: '16px',
            padding: '2rem',
            width: '500px',
            maxWidth: '90vw',
            boxShadow: '0 20px 50px rgba(0, 0, 0, 0.3)'
          }}>
            <h3 style={{
              margin: '0 0 1rem 0',
              color: theme === 'dark' ? '#f9fafb' : '#1f2937',
              display: 'flex',
              alignItems: 'center',
              gap: '0.5rem'
            }}>
              <Icon name="file-invoice" />
              Adicionar NF-e
            </h3>
            <p style={{
              margin: '0 0 1.5rem 0',
              color: theme === 'dark' ? '#d1d5db' : '#6b7280',
              fontSize: '0.875rem'
            }}>
              Digite a chave de acesso da Nota Fiscal eletrônica (44 dígitos)
            </p>
            <input
              type="text"
              value={documentChave}
              onChange={(e) => setDocumentChave(e.target.value.replace(/\D/g, '').slice(0, 44))}
              placeholder="Chave de acesso (44 dígitos)"
              style={{
                width: '100%',
                padding: '0.75rem',
                border: `2px solid ${theme === 'dark' ? '#374151' : '#d1d5db'}`,
                borderRadius: '8px',
                fontSize: '0.875rem',
                fontFamily: 'monospace',
                background: theme === 'dark' ? '#374151' : 'white',
                color: theme === 'dark' ? '#f9fafb' : '#1f2937',
                marginBottom: '1.5rem'
              }}
              maxLength={44}
            />
            <div style={{
              display: 'flex',
              gap: '1rem',
              justifyContent: 'flex-end'
            }}>
              <button
                onClick={() => {
                  setShowNFeModal(false);
                  setDocumentChave('');
                }}
                style={{
                  padding: '0.75rem 1.5rem',
                  background: 'transparent',
                  color: '#dc2626',
                  border: '2px solid #dc2626',
                  borderRadius: '8px',
                  cursor: 'pointer',
                  fontWeight: '600'
                }}
              >
                Cancelar
              </button>
              <button
                onClick={addNFe}
                disabled={documentChave.length !== 44}
                style={{
                  padding: '0.75rem 1.5rem',
                  background: documentChave.length === 44
                    ? 'linear-gradient(135deg, #10b981, #059669)'
                    : '#9ca3af',
                  color: 'white',
                  border: 'none',
                  borderRadius: '8px',
                  cursor: documentChave.length === 44 ? 'pointer' : 'not-allowed',
                  fontWeight: '600'
                }}
              >
                Adicionar
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}