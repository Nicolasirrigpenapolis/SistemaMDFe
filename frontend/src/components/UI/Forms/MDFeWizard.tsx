import React, { useState, useEffect } from 'react';
import { MDFeData } from '../../../types/mdfe';
import { entitiesService, EntityOption } from '../../../services/entitiesService';
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
  const [currentSection, setCurrentSection] = useState('emitente');
  const [emitentes, setEmitentes] = useState<EntityOption[]>([]);
  const [condutores, setCondutores] = useState<EntityOption[]>([]);
  const [veiculos, setVeiculos] = useState<EntityOption[]>([]);
  const [loading, setLoading] = useState(false);

  const sections: WizardSection[] = [
    {
      id: 'emitente',
      title: 'Emitente',
      description: 'Dados do emitente do manifesto',
      required: true,
      completed: !!(dados.emit?.CNPJ && dados.emit?.xNome)
    },
    {
      id: 'informante',
      title: 'Informante',
      description: 'Responsável pelas informações do MDFe',
      required: false,
      completed: !!dados.infDoc?.infMunDescarga?.some(descarga =>
        descarga.infNFe?.length || descarga.infCTe?.length
      )
    },
    {
      id: 'veiculo',
      title: 'Veículo',
      description: 'Dados do veículo de transporte',
      required: true,
      completed: !!(dados.infModal?.rodo?.veicTracao?.placa && dados.infModal?.rodo?.veicTracao?.tara)
    },
    {
      id: 'trajeto',
      title: 'Trajeto',
      description: 'Rota e percurso da viagem',
      required: true,
      completed: !!(dados.ide?.UFIni && dados.ide?.UFFim)
    },
    {
      id: 'carga',
      title: 'Carga',
      description: 'Informações sobre a carga transportada',
      required: true,
      completed: !!dados.tot?.qCTe || !!dados.tot?.qNFe
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
      const [emitentesData, condutoresData, veiculosData] = await Promise.all([
        entitiesService.obterEmitentes(),
        entitiesService.obterCondutores(),
        entitiesService.obterVeiculos()
      ]);

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
    const emitente = emitentes.find(e => e.id === emitenteId);
    if (emitente && emitente.data) {
      atualizarSecao('emit', {
        CNPJ: emitente.data.CNPJ,
        IE: emitente.data.IE,
        xNome: emitente.data.xNome,
        xFant: emitente.data.xFant,
        enderEmit: emitente.data.enderEmit
      });
    }
  };

  const handleCondutorSelect = (condutorId: string) => {
    const condutor = condutores.find(c => c.id === condutorId);
    if (condutor && condutor.data) {
      atualizarSecao('rodo_infANTT', {
        infCIOT: [{
          CIOT: '',
          CPF: condutor.data.CPF,
          xNome: condutor.data.xNome
        }]
      });
    }
  };

  const handleVeiculoSelect = (veiculoId: string) => {
    const veiculo = veiculos.find(v => v.id === veiculoId);
    if (veiculo && veiculo.data) {
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
                onChange={(e) => handleEmitenteSelect(e.target.value)}
                disabled={loading}
              >
                <option value="">Selecione um emitente cadastrado...</option>
                {emitentes.map(emitente => (
                  <option key={emitente.id} value={emitente.id}>
                    {emitente.label} - {emitente.description}
                  </option>
                ))}
              </select>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 'var(--space-4)' }}>
              <div>
                <label className="label label-required">CNPJ</label>
                <input
                  type="text"
                  className="input"
                  value={dados.emit?.CNPJ || ''}
                  onChange={(e) => atualizarCampo('emit', 'CNPJ', e.target.value)}
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
                onChange={(e) => handleVeiculoSelect(e.target.value)}
                disabled={loading}
              >
                <option value="">Selecione um veículo cadastrado...</option>
                {veiculos.map(veiculo => (
                  <option key={veiculo.id} value={veiculo.id}>
                    {veiculo.label} - {veiculo.description}
                  </option>
                ))}
              </select>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr 1fr', gap: 'var(--space-4)' }}>
              <div>
                <label className="label label-required">Placa</label>
                <input
                  type="text"
                  className="input"
                  value={dados.infModal?.rodo?.veicTracao?.placa || ''}
                  onChange={(e) => atualizarVeiculo('placa', e.target.value)}
                  placeholder="ABC-1234"
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

      case 'trajeto':
        return (
          <div className="card-body">
            <h4>Definir Trajeto</h4>
            <p className="mb-4" style={{ color: 'var(--color-text-secondary)' }}>
              Configure a rota da viagem - UF de início e fim
            </p>

            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 'var(--space-4)' }}>
              <div>
                <label className="label label-required">UF de Início</label>
                <select
                  className="input"
                  value={dados.ide?.UFIni || ''}
                  onChange={(e) => atualizarCampo('ide', 'UFIni', e.target.value)}
                  required
                >
                  <option value="">Selecione UF de origem</option>
                  <option value="SP">São Paulo</option>
                  <option value="RJ">Rio de Janeiro</option>
                  <option value="MG">Minas Gerais</option>
                  <option value="RS">Rio Grande do Sul</option>
                  <option value="PR">Paraná</option>
                  <option value="SC">Santa Catarina</option>
                </select>
              </div>

              <div>
                <label className="label label-required">UF de Destino</label>
                <select
                  className="input"
                  value={dados.ide?.UFFim || ''}
                  onChange={(e) => atualizarCampo('ide', 'UFFim', e.target.value)}
                  required
                >
                  <option value="">Selecione UF de destino</option>
                  <option value="SP">São Paulo</option>
                  <option value="RJ">Rio de Janeiro</option>
                  <option value="MG">Minas Gerais</option>
                  <option value="RS">Rio Grande do Sul</option>
                  <option value="PR">Paraná</option>
                  <option value="SC">Santa Catarina</option>
                </select>
              </div>
            </div>

            <div className="mt-4">
              <label className="label">Data/Hora de Início da Viagem</label>
              <input
                type="datetime-local"
                className="input"
                value={dados.ide?.dhIniViagem || ''}
                onChange={(e) => atualizarCampo('ide', 'dhIniViagem', e.target.value)}
              />
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
      {/* Cabeçalho */}
      <header style={{
        display: 'flex',
        justifyContent: 'space-between',
        alignItems: 'center',
        marginBottom: 'var(--space-6)',
        padding: 'var(--space-4)',
        backgroundColor: 'var(--color-surface)',
        borderRadius: 'var(--radius-md)',
        border: '1px solid var(--color-border)'
      }}>
        <div>
          <h1 style={{ margin: 0, fontSize: '1.5rem', fontWeight: '600' }}>
            {isEdicao ? 'Editar MDFe' : 'Novo MDFe'}
          </h1>
          <p style={{ margin: '4px 0 0 0', color: 'var(--color-text-secondary)' }}>
            Preencha as seções para criar o manifesto eletrônico
          </p>
        </div>
        <div style={{ display: 'flex', gap: 'var(--space-3)' }}>
          <button
            type="button"
            onClick={onCancelar}
            className="btn btn-secondary"
          >
            Cancelar
          </button>
          <button
            type="button"
            onClick={onSalvar}
            className="btn btn-primary"
            disabled={salvando}
          >
            {salvando ? 'Salvando...' : 'Salvar MDFe'}
          </button>
        </div>
      </header>

      <div style={{ display: 'flex', gap: 'var(--space-6)', minHeight: '600px' }}>
        {/* Sidebar com seções */}
        <div style={{ flexShrink: 0, width: '280px' }}>
          <div className="card">
            <div className="card-header">
              <h3 style={{ margin: 0, fontSize: '1.125rem' }}>Seções do MDFe</h3>
            </div>
            <div style={{ padding: 0 }}>
              {sections.map((section, index) => (
                <button
                key={section.id}
                onClick={() => setCurrentSection(section.id)}
                className={`w-full text-left p-4 border-b border-gray-200 transition-colors ${
                  currentSection === section.id
                    ? 'bg-primary-50 border-l-4 border-l-primary-500'
                    : 'hover:bg-gray-50'
                }`}
                style={{
                  width: '100%',
                  textAlign: 'left',
                  padding: 'var(--space-4)',
                  border: 'none',
                  borderBottom: '1px solid var(--color-border)',
                  backgroundColor: currentSection === section.id ? 'var(--color-primary-light)' : 'transparent',
                  cursor: 'pointer',
                  transition: 'background-color var(--transition-fast)',
                  borderLeft: currentSection === section.id ? '4px solid var(--color-primary)' : '4px solid transparent'
                }}
              >
                <div style={{ display: 'flex', alignItems: 'center', gap: 'var(--space-2)' }}>
                  <span style={{
                    fontSize: '1.25rem',
                    color: section.completed ? 'var(--color-success)' : 'var(--color-text-secondary)'
                  }}>
                    {section.completed ? <Icon name="check" color="var(--color-success)" /> : index + 1}
                  </span>
                  <div>
                    <div style={{ fontWeight: '500', color: 'var(--color-text-primary)' }}>
                      {section.title}
                    </div>
                    <div style={{ fontSize: '0.75rem', color: 'var(--color-text-secondary)', marginTop: '2px' }}>
                      {section.description}
                    </div>
                  </div>
                </div>
                </button>
              ))}
            </div>
          </div>
        </div>

        {/* Conteúdo principal */}
        <div style={{ flex: 1 }}>
        <div className="card" style={{ height: 'fit-content' }}>
          <div className="card-header">
            <div style={{ display: 'flex', alignItems: 'center', gap: 'var(--space-2)' }}>
              <span style={{ fontSize: '1.5rem' }}>
                {sections.find(s => s.id === currentSection)?.completed ?
                  <Icon name="check" color="var(--color-success)" /> :
                  <Icon name="edit" color="var(--color-primary)" />
                }
              </span>
              <div>
                <h3 style={{ margin: 0, fontSize: '1.25rem' }}>
                  {sections.find(s => s.id === currentSection)?.title}
                </h3>
                <p style={{ margin: '4px 0 0 0', fontSize: '0.875rem', color: 'var(--color-text-secondary)' }}>
                  {sections.find(s => s.id === currentSection)?.description}
                </p>
              </div>
            </div>
          </div>

          {renderSectionContent()}

          <div className="card-footer">
            <div style={{ display: 'flex', justifyContent: 'space-between' }}>
              <button
                className="btn btn-secondary"
                onClick={prevSection}
                disabled={sections.findIndex(s => s.id === currentSection) === 0}
              >
                ← Anterior
              </button>

              <button
                className="btn btn-primary"
                onClick={nextSection}
                disabled={sections.findIndex(s => s.id === currentSection) === sections.length - 1}
              >
                Próximo →
              </button>
            </div>
          </div>
        </div>
        </div>
      </div>
    </div>
  );
}