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

export function MDFeWizardProfessional({
  dados,
  onDadosChange,
  onSalvar,
  onCancelar,
  onTransmitir,
  salvando,
  transmitindo = false,
  isEdicao
}: MDFeWizardProps) {
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
  const [sidebarOpen, setSidebarOpen] = useState(false);

  // Validações das seções
  const emitenteCompleto = !!(dados.emit?.CNPJ && dados.emit?.xNome);
  const veiculoCompleto = !!(dados.infModal?.rodo?.veicTracao?.placa && dados.infModal?.rodo?.veicTracao?.tara);
  const condutorCompleto = !!(dados.infModal?.rodo?.veicTracao?.condutor?.[0]?.xNome);
  const trajetoCompleto = !!(locaisCarregamento.length > 0 && locaisDescarregamento.length > 0);
  const cargaCompleta = !!(dados.tot?.vCarga && parseFloat(dados.tot.vCarga) > 0);
  const documentosCompletos = !!dados.infDoc?.infMunDescarga?.some(descarga =>
    descarga.infNFe?.length || descarga.infCTe?.length
  );

  const todasSecoesCompletas = emitenteCompleto && veiculoCompleto && trajetoCompleto && cargaCompleta && documentosCompletos;

  const sections: WizardSection[] = [
    { id: 'emitente', title: 'Emitente', description: 'Dados do emitente do manifesto', required: true, completed: emitenteCompleto },
    { id: 'veiculo', title: 'Veículo', description: 'Dados do veículo de transporte', required: true, completed: veiculoCompleto },
    { id: 'condutor', title: 'Condutor', description: 'Dados do condutor responsável', required: false, completed: condutorCompleto },
    { id: 'trajeto', title: 'Trajeto', description: 'Rota e percurso da viagem', required: true, completed: trajetoCompleto },
    { id: 'carga', title: 'Carga', description: 'Informações sobre a carga', required: true, completed: cargaCompleta },
    { id: 'documentos', title: 'Documentos', description: 'CTe/NFe vinculados', required: true, completed: documentosCompletos },
    { id: 'resumo', title: 'Resumo Final', description: 'Revisão antes da emissão', required: true, completed: todasSecoesCompletas }
  ];

  const currentIndex = sections.findIndex(s => s.id === currentSection);
  const completedCount = sections.filter(s => s.completed && s.id !== 'resumo').length;
  const totalSections = sections.filter(s => s.id !== 'resumo').length;
  const progressPercentage = Math.round((completedCount / totalSections) * 100);

  useEffect(() => {
    loadEntities();
  }, []);

  const loadEntities = async () => {
    setLoading(true);
    try {
      const [emitentesResult, condutoresResult, veiculosResult] = await Promise.all([
        entitiesService.obterEmitentes(),
        entitiesService.obterCondutores(),
        entitiesService.obterVeiculos()
      ]);

      setEmitentes(emitentesResult || []);
      setCondutores(condutoresResult || []);
      setVeiculos(veiculosResult || []);
    } catch (error) {
      console.error('Erro ao carregar entidades:', error);
    } finally {
      setLoading(false);
    }
  };

  const renderSectionContent = () => {
    switch (currentSection) {
      case 'emitente':
        return renderEmitenteSection();
      case 'veiculo':
        return renderVeiculoSection();
      case 'condutor':
        return renderCondutorSection();
      case 'trajeto':
        return renderTrajetoSection();
      case 'carga':
        return renderCargaSection();
      case 'documentos':
        return renderDocumentosSection();
      case 'resumo':
        return renderResumoSection();
      default:
        return <div>Seção em desenvolvimento...</div>;
    }
  };

  const renderEmitenteSection = () => (
    <div className="mdfe-section">
      <div className="mdfe-section-header">
        <div className="mdfe-section-icon">
          <Icon name="building" />
        </div>
        <div>
          <h2 className="mdfe-section-title">Dados do Emitente</h2>
          <p className="mdfe-section-subtitle">Selecione ou configure o emitente do manifesto</p>
        </div>
      </div>

      <div className="mdfe-form-grid">
        <div className="mdfe-input-group mdfe-span-2">
          <label className="mdfe-label mdfe-label-required">Emitente</label>
          <select
            className="mdfe-input"
            value={emitentes.find(e => e.data?.CNPJ === dados.emit?.CNPJ)?.id || ''}
            onChange={(e) => {
              const emitenteSelecionado = emitentes.find(em => em.id === e.target.value);
              if (emitenteSelecionado && emitenteSelecionado.data) {
                onDadosChange({
                  ...dados,
                  emit: {
                    ...dados.emit,
                    CNPJ: emitenteSelecionado.data.CNPJ || '',
                    xNome: emitenteSelecionado.data.xNome || '',
                    xFant: emitenteSelecionado.data.xFant || '',
                    IE: emitenteSelecionado.data.IE || '',
                    enderEmit: {
                      ...dados.emit?.enderEmit,
                      xLgr: emitenteSelecionado.data.xLgr || '',
                      xBairro: emitenteSelecionado.data.xBairro || '',
                      xMun: emitenteSelecionado.data.xMun || '',
                      UF: emitenteSelecionado.data.UF || '',
                      CEP: emitenteSelecionado.data.CEP || ''
                    }
                  }
                });
              }
            }}
          >
            <option value="">Selecione um emitente...</option>
            {emitentes.map(emitente => (
              <option key={emitente.id} value={emitente.id}>
                {emitente.label}
              </option>
            ))}
          </select>
        </div>

        {dados.emit?.xNome && (
          <>
            <div className="mdfe-input-group">
              <label className="mdfe-label">CNPJ</label>
              <input
                type="text"
                className="mdfe-input"
                value={formatCNPJ(dados.emit.CNPJ || '')}
                readOnly
              />
            </div>
            <div className="mdfe-input-group">
              <label className="mdfe-label">Inscrição Estadual</label>
              <input
                type="text"
                className="mdfe-input"
                value={dados.emit.IE || ''}
                readOnly
              />
            </div>
            <div className="mdfe-input-group mdfe-span-2">
              <label className="mdfe-label">Razão Social</label>
              <input
                type="text"
                className="mdfe-input"
                value={dados.emit.xNome}
                readOnly
              />
            </div>
            {dados.emit.xFant && (
              <div className="mdfe-input-group mdfe-span-2">
                <label className="mdfe-label">Nome Fantasia</label>
                <input
                  type="text"
                  className="mdfe-input"
                  value={dados.emit.xFant}
                  readOnly
                />
              </div>
            )}
          </>
        )}
      </div>
    </div>
  );

  const renderVeiculoSection = () => (
    <div className="mdfe-section">
      <div className="mdfe-section-header">
        <div className="mdfe-section-icon">
          <Icon name="truck" />
        </div>
        <div>
          <h2 className="mdfe-section-title">Dados do Veículo</h2>
          <p className="mdfe-section-subtitle">Configure o veículo de transporte</p>
        </div>
      </div>

      <div className="mdfe-form-grid">
        <div className="mdfe-input-group mdfe-span-2">
          <label className="mdfe-label mdfe-label-required">Veículo</label>
          <select
            className="mdfe-input"
            value={veiculos.find(v => v.data?.placa === dados.infModal?.rodo?.veicTracao?.placa)?.id || ''}
            onChange={(e) => {
              const veiculoSelecionado = veiculos.find(v => v.id === e.target.value);
              if (veiculoSelecionado && veiculoSelecionado.data) {
                onDadosChange({
                  ...dados,
                  infModal: {
                    ...dados.infModal,
                    versaoModal: '3.00',
                    rodo: {
                      ...dados.infModal?.rodo,
                      veicTracao: {
                        ...dados.infModal?.rodo?.veicTracao,
                        cInt: veiculoSelecionado.data.cInt?.toString() || '',
                        placa: veiculoSelecionado.data.placa || '',
                        tara: veiculoSelecionado.data.tara?.toString() || '',
                        tpRod: '06',
                        tpCar: '00'
                      }
                    }
                  }
                });
              }
            }}
          >
            <option value="">Selecione um veículo...</option>
            {veiculos.map(veiculo => (
              <option key={veiculo.id} value={veiculo.id}>
                {veiculo.label}
              </option>
            ))}
          </select>
        </div>

        {dados.infModal?.rodo?.veicTracao?.placa && (
          <>
            <div className="mdfe-input-group">
              <label className="mdfe-label">Placa</label>
              <input
                type="text"
                className="mdfe-input"
                value={formatPlaca(dados.infModal.rodo.veicTracao.placa)}
                readOnly
              />
            </div>
            <div className="mdfe-input-group">
              <label className="mdfe-label">Código Interno</label>
              <input
                type="text"
                className="mdfe-input"
                value={dados.infModal.rodo.veicTracao.cInt || ''}
                readOnly
              />
            </div>
            <div className="mdfe-input-group">
              <label className="mdfe-label">Tara (kg)</label>
              <input
                type="text"
                className="mdfe-input"
                value={dados.infModal.rodo.veicTracao.tara || ''}
                readOnly
              />
            </div>
          </>
        )}
      </div>
    </div>
  );

  const renderCondutorSection = () => (
    <div className="mdfe-section">
      <div className="mdfe-section-header">
        <div className="mdfe-section-icon">
          <Icon name="user" />
        </div>
        <div>
          <h2 className="mdfe-section-title">Dados do Condutor</h2>
          <p className="mdfe-section-subtitle">Selecione o condutor responsável (opcional)</p>
        </div>
      </div>

      <div className="mdfe-form-grid">
        <div className="mdfe-input-group mdfe-span-2">
          <label className="mdfe-label">Condutor</label>
          <select
            className="mdfe-input"
            value={condutores.find(c => c.data?.CPF === dados.infModal?.rodo?.veicTracao?.condutor?.[0]?.CPF)?.id || ''}
            onChange={(e) => {
              const condutorSelecionado = condutores.find(c => c.id === e.target.value);
              if (condutorSelecionado && condutorSelecionado.data) {
                onDadosChange({
                  ...dados,
                  infModal: {
                    ...dados.infModal,
                    versaoModal: '3.00',
                    rodo: {
                      ...dados.infModal?.rodo,
                      veicTracao: {
                        ...dados.infModal?.rodo?.veicTracao,
                        condutor: [{
                          xNome: condutorSelecionado.data.xNome || '',
                          CPF: condutorSelecionado.data.CPF || ''
                        }]
                      }
                    }
                  }
                });
              }
            }}
          >
            <option value="">Selecione um condutor...</option>
            {condutores.map(condutor => (
              <option key={condutor.id} value={condutor.id}>
                {condutor.label}
              </option>
            ))}
          </select>
        </div>

        {dados.infModal?.rodo?.veicTracao?.condutor?.[0] && (
          <>
            <div className="mdfe-input-group">
              <label className="mdfe-label">Nome</label>
              <input
                type="text"
                className="mdfe-input"
                value={dados.infModal.rodo.veicTracao.condutor[0].xNome}
                readOnly
              />
            </div>
            <div className="mdfe-input-group">
              <label className="mdfe-label">CPF</label>
              <input
                type="text"
                className="mdfe-input"
                value={formatCPF(dados.infModal.rodo.veicTracao.condutor[0].CPF || '')}
                readOnly
              />
            </div>
          </>
        )}
      </div>
    </div>
  );

  const renderTrajetoSection = () => (
    <div className="mdfe-section">
      <div className="mdfe-section-header">
        <div className="mdfe-section-icon">
          <Icon name="map" />
        </div>
        <div>
          <h2 className="mdfe-section-title">Trajeto da Viagem</h2>
          <p className="mdfe-section-subtitle">Defina os locais de carregamento e descarregamento</p>
        </div>
      </div>

      <div className="mdfe-trajeto-container">
        <LocalidadeSelector
          locais={locaisCarregamento}
          onChange={(novosLocais) => setLocaisCarregamento(novosLocais)}
          title="Locais de Carregamento"
          tipo="carregamento"
        />

        <LocalidadeSelector
          locais={locaisDescarregamento}
          onChange={(novosLocais) => setLocaisDescarregamento(novosLocais)}
          title="Locais de Descarregamento"
          tipo="descarregamento"
          locaisOrigem={locaisCarregamento}
        />
      </div>
    </div>
  );

  const renderCargaSection = () => (
    <div className="mdfe-section">
      <div className="mdfe-section-header">
        <div className="mdfe-section-icon">
          <Icon name="package" />
        </div>
        <div>
          <h2 className="mdfe-section-title">Informações da Carga</h2>
          <p className="mdfe-section-subtitle">Configure os dados sobre a carga transportada</p>
        </div>
      </div>

      <div className="mdfe-form-grid">
        <div className="mdfe-input-group">
          <label className="mdfe-label mdfe-label-required">Valor da Carga (R$)</label>
          <input
            type="number"
            step="0.01"
            className="mdfe-input"
            value={dados.tot?.vCarga || ''}
            onChange={(e) => onDadosChange({
              ...dados,
              tot: { ...dados.tot, vCarga: e.target.value }
            })}
            placeholder="0,00"
          />
        </div>

        <div className="mdfe-input-group">
          <label className="mdfe-label">Peso da Carga (kg)</label>
          <input
            type="number"
            step="0.001"
            className="mdfe-input"
            value={dados.tot?.qCarga || ''}
            onChange={(e) => onDadosChange({
              ...dados,
              tot: { ...dados.tot, qCarga: e.target.value, cUnid: '01' }
            })}
            placeholder="0,000"
          />
        </div>
      </div>
    </div>
  );

  const renderDocumentosSection = () => (
    <div className="mdfe-section">
      <div className="mdfe-section-header">
        <div className="mdfe-section-icon">
          <Icon name="file-text" />
        </div>
        <div>
          <h2 className="mdfe-section-title">Documentos Vinculados</h2>
          <p className="mdfe-section-subtitle">Adicione CTe e NFe ao manifesto</p>
        </div>
      </div>

      <div className="mdfe-documents-container">
        <div className="mdfe-document-actions">
          <button
            type="button"
            className="mdfe-btn mdfe-btn-primary"
            onClick={() => setShowCTeModal(true)}
          >
            <Icon name="plus" />
            Adicionar CTe
          </button>

          <button
            type="button"
            className="mdfe-btn mdfe-btn-secondary"
            onClick={() => setShowNFeModal(true)}
          >
            <Icon name="plus" />
            Adicionar NFe
          </button>
        </div>

        <div className="mdfe-documents-summary">
          <div className="mdfe-document-count">
            <Icon name="file-text" />
            <span>
              {dados.tot?.qCTe || 0} CTe(s) e {dados.tot?.qNFe || 0} NFe(s) vinculados
            </span>
          </div>
        </div>
      </div>
    </div>
  );

  const renderResumoSection = () => (
    <div className="mdfe-section">
      <div className="mdfe-section-header">
        <div className="mdfe-section-icon">
          <Icon name="check-circle" />
        </div>
        <div>
          <h2 className="mdfe-section-title">Resumo Final</h2>
          <p className="mdfe-section-subtitle">Revise todos os dados antes da emissão</p>
        </div>
      </div>

      <div className="mdfe-summary-grid">
        {/* Status das Seções */}
        <div className="mdfe-summary-card">
          <h3 className="mdfe-summary-card-title">
            <Icon name="list-check" />
            Status das Seções
          </h3>
          <div className="mdfe-summary-sections">
            {sections.filter(s => s.id !== 'resumo').map(section => (
              <div
                key={section.id}
                className={`mdfe-summary-section ${section.completed ? 'completed' : 'pending'}`}
              >
                <Icon name={section.completed ? 'check-circle' : section.required ? 'alert-circle' : 'clock'} />
                <span>{section.title}</span>
                <div className={`mdfe-status-badge ${
                  section.completed ? 'mdfe-status-success' :
                  section.required ? 'mdfe-status-warning' : 'mdfe-status-info'
                }`}>
                  {section.completed ? 'OK' : section.required ? 'Obrigatório' : 'Opcional'}
                </div>
              </div>
            ))}
          </div>
        </div>

        {/* Resumo dos Dados */}
        <div className="mdfe-summary-card">
          <h3 className="mdfe-summary-card-title">
            <Icon name="info" />
            Dados Principais
          </h3>
          <div className="mdfe-summary-data">
            {dados.emit?.xNome && (
              <div className="mdfe-summary-item">
                <strong>Emitente:</strong> {dados.emit.xNome}
              </div>
            )}
            {dados.infModal?.rodo?.veicTracao?.placa && (
              <div className="mdfe-summary-item">
                <strong>Veículo:</strong> {formatPlaca(dados.infModal.rodo.veicTracao.placa)}
              </div>
            )}
            {dados.tot?.vCarga && (
              <div className="mdfe-summary-item">
                <strong>Valor da Carga:</strong> R$ {parseFloat(dados.tot.vCarga).toLocaleString('pt-BR', { minimumFractionDigits: 2 })}
              </div>
            )}
          </div>
        </div>

        {/* Status de Validação Final */}
        <div className={`mdfe-validation-card ${todasSecoesCompletas ? 'success' : 'error'}`}>
          <div className="mdfe-validation-icon">
            <Icon name={todasSecoesCompletas ? 'check-circle' : 'alert-triangle'} />
          </div>
          <div className="mdfe-validation-content">
            <h3>{todasSecoesCompletas ? 'Pronto para Emissão!' : 'Pendências Encontradas'}</h3>
            <p>
              {todasSecoesCompletas
                ? 'Todas as informações necessárias foram preenchidas.'
                : 'Complete as seções obrigatórias para continuar.'
              }
            </p>
          </div>
        </div>
      </div>
    </div>
  );

  return (
    <div className="mdfe-wizard-container">
      {/* Header Profissional */}
      <header className="mdfe-header">
        <div className="mdfe-header-progress">
          <div
            className="mdfe-header-progress-bar"
            style={{ width: `${progressPercentage}%` }}
          />
        </div>

        <div className="mdfe-header-content">
          <div className="mdfe-header-main">
            <div className="mdfe-header-icon">
              <Icon name={isEdicao ? "edit" : "plus"} />
            </div>
            <div className="mdfe-header-info">
              <h1 className="mdfe-header-title">
                {isEdicao ? 'Editar MDF-e' : 'Novo MDF-e'}
              </h1>
              <p className="mdfe-header-subtitle">
                Manifesto de Documentos Fiscais Eletrônicos
              </p>
            </div>
          </div>

          <div className="mdfe-header-status">
            <div className="mdfe-header-progress-info">
              <span className="mdfe-header-progress-count">
                {completedCount}/{totalSections}
              </span>
              <span className="mdfe-header-progress-label">seções</span>
            </div>
          </div>
        </div>
      </header>

      <div className="mdfe-wizard-body">
        {/* Sidebar de Navegação */}
        <aside className={`mdfe-sidebar ${sidebarOpen ? 'open' : ''}`}>
          <div className="mdfe-sidebar-header">
            <div className="mdfe-sidebar-progress-ring">
              <svg width="48" height="48">
                <circle cx="24" cy="24" r="20" stroke="var(--color-border)" strokeWidth="3" fill="transparent" />
                <circle
                  cx="24"
                  cy="24"
                  r="20"
                  stroke="var(--color-primary)"
                  strokeWidth="3"
                  fill="transparent"
                  strokeDasharray={`${(completedCount / totalSections) * 125.6} 125.6`}
                  transform="rotate(-90 24 24)"
                />
              </svg>
              <span className="progress-text">{progressPercentage}%</span>
            </div>
            <div className="mdfe-sidebar-info">
              <h3>Progresso</h3>
              <p>{completedCount} de {totalSections} seções</p>
            </div>
          </div>

          <nav className="mdfe-sidebar-nav">
            {sections.map((section, index) => (
              <button
                key={section.id}
                className={`mdfe-sidebar-item ${section.id === currentSection ? 'active' : ''} ${
                  section.completed ? 'completed' : ''
                }`}
                onClick={() => setCurrentSection(section.id)}
                type="button"
              >
                <div className="mdfe-sidebar-icon">
                  <Icon name={section.completed ? 'check-circle' : section.id === currentSection ? 'play-circle' : 'circle'} />
                </div>
                <div className="mdfe-sidebar-content">
                  <h4>{section.title}</h4>
                  <p>{section.description}</p>
                  <div className={`mdfe-status-badge ${
                    section.completed ? 'mdfe-status-success' :
                    section.required ? 'mdfe-status-warning' : 'mdfe-status-info'
                  }`}>
                    {section.completed ? 'Concluída' : section.required ? 'Obrigatória' : 'Opcional'}
                  </div>
                </div>
              </button>
            ))}
          </nav>
        </aside>

        {/* Conteúdo Principal */}
        <main className="mdfe-main-content">
          <button
            className="mdfe-sidebar-toggle"
            onClick={() => setSidebarOpen(!sidebarOpen)}
          >
            <Icon name="menu" />
          </button>

          {renderSectionContent()}

          {/* Navegação */}
          <div className="mdfe-navigation">
            <button
              type="button"
              className="mdfe-btn mdfe-btn-secondary"
              onClick={() => {
                if (currentIndex > 0) {
                  setCurrentSection(sections[currentIndex - 1].id);
                } else {
                  onCancelar();
                }
              }}
            >
              <Icon name="arrow-left" />
              {currentIndex > 0 ? 'Anterior' : 'Cancelar'}
            </button>

            <div className="mdfe-navigation-actions">
              {currentSection === 'resumo' ? (
                <>
                  <button
                    type="button"
                    className="mdfe-btn mdfe-btn-primary"
                    onClick={onSalvar}
                    disabled={salvando || !todasSecoesCompletas}
                  >
                    {salvando ? (
                      <>
                        <div className="mdfe-spinner" />
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
                      type="button"
                      className="mdfe-btn mdfe-btn-primary"
                      onClick={onTransmitir}
                      disabled={transmitindo}
                    >
                      {transmitindo ? (
                        <>
                          <div className="mdfe-spinner" />
                          Transmitindo...
                        </>
                      ) : (
                        <>
                          <Icon name="send" />
                          Transmitir
                        </>
                      )}
                    </button>
                  )}
                </>
              ) : (
                <button
                  type="button"
                  className="mdfe-btn mdfe-btn-primary"
                  onClick={() => {
                    if (currentIndex < sections.length - 1) {
                      setCurrentSection(sections[currentIndex + 1].id);
                    }
                  }}
                  disabled={currentIndex >= sections.length - 1}
                >
                  Próximo
                  <Icon name="arrow-right" />
                </button>
              )}
            </div>
          </div>
        </main>
      </div>

      {/* Estilos CSS Integrados */}
      <style>{`
        .mdfe-wizard-container {
          min-height: 100vh;
          background: var(--color-background);
        }

        .mdfe-header {
          background: var(--gradient-surface);
          border-radius: 0 0 var(--border-radius-xl) var(--border-radius-xl);
          box-shadow: var(--shadow-lg);
          margin-bottom: var(--spacing-2xl);
          overflow: hidden;
        }

        .mdfe-header-progress {
          height: 4px;
          background: var(--color-border-light);
        }

        .mdfe-header-progress-bar {
          height: 100%;
          background: var(--gradient-primary);
          transition: width var(--transition-slow);
        }

        .mdfe-header-content {
          display: flex;
          align-items: center;
          justify-content: space-between;
          padding: var(--spacing-2xl) var(--spacing-3xl);
          gap: var(--spacing-2xl);
        }

        .mdfe-header-main {
          display: flex;
          align-items: center;
          gap: var(--spacing-xl);
          flex: 1;
        }

        .mdfe-header-icon {
          width: 64px;
          height: 64px;
          background: var(--gradient-primary);
          border-radius: var(--border-radius-lg);
          display: flex;
          align-items: center;
          justify-content: center;
          color: var(--color-text-inverse);
          font-size: var(--font-size-2xl);
          box-shadow: var(--shadow-md);
        }

        .mdfe-header-title {
          margin: 0 0 var(--spacing-xs) 0;
          font-size: var(--font-size-3xl);
          font-weight: var(--font-weight-bold);
          color: var(--color-text-primary);
        }

        .mdfe-header-subtitle {
          margin: 0;
          font-size: var(--font-size-base);
          color: var(--color-text-secondary);
        }

        .mdfe-header-status {
          text-align: center;
        }

        .mdfe-header-progress-count {
          display: block;
          font-size: var(--font-size-2xl);
          font-weight: var(--font-weight-bold);
          color: var(--color-primary);
        }

        .mdfe-header-progress-label {
          font-size: var(--font-size-sm);
          color: var(--color-text-secondary);
        }

        .mdfe-wizard-body {
          display: flex;
          min-height: calc(100vh - 200px);
        }

        .mdfe-sidebar {
          width: 320px;
          background: var(--color-surface);
          border-right: 1px solid var(--color-border);
          padding: var(--spacing-xl);
          overflow-y: auto;
          position: sticky;
          top: 0;
          height: 100vh;
        }

        .mdfe-sidebar-header {
          display: flex;
          align-items: center;
          gap: var(--spacing-lg);
          padding-bottom: var(--spacing-xl);
          border-bottom: 1px solid var(--color-border);
          margin-bottom: var(--spacing-xl);
        }

        .mdfe-sidebar-progress-ring {
          position: relative;
          display: flex;
          align-items: center;
          justify-content: center;
        }

        .progress-text {
          position: absolute;
          font-size: var(--font-size-sm);
          font-weight: var(--font-weight-bold);
          color: var(--color-primary);
        }

        .mdfe-sidebar-info h3 {
          margin: 0 0 var(--spacing-xs) 0;
          color: var(--color-text-primary);
        }

        .mdfe-sidebar-info p {
          margin: 0;
          font-size: var(--font-size-sm);
          color: var(--color-text-secondary);
        }

        .mdfe-sidebar-nav {
          display: flex;
          flex-direction: column;
          gap: var(--spacing-sm);
        }

        .mdfe-sidebar-item {
          display: flex;
          align-items: flex-start;
          gap: var(--spacing-md);
          padding: var(--spacing-lg);
          border: 1px solid transparent;
          border-radius: var(--border-radius-md);
          background: transparent;
          text-align: left;
          cursor: pointer;
          transition: all var(--transition-fast);
        }

        .mdfe-sidebar-item:hover {
          background: var(--color-surface-hover);
          border-color: var(--color-border);
        }

        .mdfe-sidebar-item.active {
          background: var(--color-primary-light);
          border-color: var(--color-primary);
        }

        .mdfe-sidebar-item.completed {
          background: var(--color-success-light);
          border-color: var(--color-success);
        }

        .mdfe-sidebar-icon {
          color: var(--color-text-tertiary);
          margin-top: 2px;
        }

        .mdfe-sidebar-item.active .mdfe-sidebar-icon {
          color: var(--color-primary);
        }

        .mdfe-sidebar-item.completed .mdfe-sidebar-icon {
          color: var(--color-success);
        }

        .mdfe-sidebar-content h4 {
          margin: 0 0 var(--spacing-xs) 0;
          font-size: var(--font-size-base);
          color: var(--color-text-primary);
        }

        .mdfe-sidebar-content p {
          margin: 0 0 var(--spacing-md) 0;
          font-size: var(--font-size-sm);
          color: var(--color-text-secondary);
        }

        .mdfe-main-content {
          flex: 1;
          padding: var(--spacing-3xl);
          position: relative;
        }

        .mdfe-sidebar-toggle {
          display: none;
          position: fixed;
          top: var(--spacing-xl);
          left: var(--spacing-xl);
          z-index: var(--z-fixed);
          background: var(--color-primary);
          color: white;
          border: none;
          border-radius: var(--border-radius);
          padding: var(--spacing-md);
          cursor: pointer;
        }

        .mdfe-section {
          background: var(--color-surface);
          border-radius: var(--border-radius-lg);
          box-shadow: var(--shadow-md);
          overflow: hidden;
          margin-bottom: var(--spacing-2xl);
        }

        .mdfe-section-header {
          display: flex;
          align-items: center;
          gap: var(--spacing-lg);
          padding: var(--spacing-2xl) var(--spacing-3xl);
          background: var(--gradient-surface);
          border-bottom: 1px solid var(--color-border);
        }

        .mdfe-section-icon {
          width: 48px;
          height: 48px;
          background: var(--gradient-primary);
          border-radius: var(--border-radius-lg);
          display: flex;
          align-items: center;
          justify-content: center;
          color: white;
          font-size: var(--font-size-xl);
        }

        .mdfe-section-title {
          margin: 0 0 var(--spacing-xs) 0;
          font-size: var(--font-size-2xl);
          font-weight: var(--font-weight-bold);
          color: var(--color-text-primary);
        }

        .mdfe-section-subtitle {
          margin: 0;
          color: var(--color-text-secondary);
        }

        .mdfe-form-grid {
          display: grid;
          grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
          gap: var(--spacing-xl);
          padding: var(--spacing-3xl);
        }

        .mdfe-span-2 {
          grid-column: span 2;
        }

        .mdfe-navigation {
          display: flex;
          justify-content: space-between;
          align-items: center;
          padding-top: var(--spacing-2xl);
          border-top: 1px solid var(--color-border);
          margin-top: var(--spacing-2xl);
        }

        .mdfe-navigation-actions {
          display: flex;
          gap: var(--spacing-md);
        }

        .mdfe-spinner {
          width: 16px;
          height: 16px;
          border: 2px solid transparent;
          border-top: 2px solid currentColor;
          border-radius: 50%;
          animation: spin 1s linear infinite;
        }

        @keyframes spin {
          to { transform: rotate(360deg); }
        }

        .mdfe-trajeto-container,
        .mdfe-documents-container {
          padding: var(--spacing-3xl);
        }

        .mdfe-document-actions {
          display: flex;
          gap: var(--spacing-md);
          margin-bottom: var(--spacing-xl);
        }

        .mdfe-documents-summary {
          padding: var(--spacing-lg);
          background: var(--color-background-secondary);
          border-radius: var(--border-radius);
        }

        .mdfe-document-count {
          display: flex;
          align-items: center;
          gap: var(--spacing-sm);
          color: var(--color-text-secondary);
        }

        .mdfe-summary-grid {
          display: grid;
          grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
          gap: var(--spacing-xl);
          padding: var(--spacing-3xl);
        }

        .mdfe-summary-card {
          background: var(--color-surface);
          border: 1px solid var(--color-border);
          border-radius: var(--border-radius-lg);
          padding: var(--spacing-xl);
        }

        .mdfe-summary-card-title {
          display: flex;
          align-items: center;
          gap: var(--spacing-sm);
          margin: 0 0 var(--spacing-lg) 0;
          color: var(--color-text-primary);
        }

        .mdfe-summary-sections {
          display: flex;
          flex-direction: column;
          gap: var(--spacing-sm);
        }

        .mdfe-summary-section {
          display: flex;
          align-items: center;
          gap: var(--spacing-sm);
          padding: var(--spacing-md);
          border-radius: var(--border-radius);
        }

        .mdfe-summary-section.completed {
          background: var(--color-success-light);
        }

        .mdfe-summary-section.pending {
          background: var(--color-warning-light);
        }

        .mdfe-summary-data {
          display: flex;
          flex-direction: column;
          gap: var(--spacing-sm);
        }

        .mdfe-summary-item {
          padding: var(--spacing-sm) 0;
          border-bottom: 1px solid var(--color-border-light);
        }

        .mdfe-validation-card {
          grid-column: span 2;
          display: flex;
          align-items: center;
          gap: var(--spacing-lg);
          padding: var(--spacing-xl);
          border-radius: var(--border-radius-lg);
        }

        .mdfe-validation-card.success {
          background: var(--color-success-light);
          border: 2px solid var(--color-success);
        }

        .mdfe-validation-card.error {
          background: var(--color-danger-light);
          border: 2px solid var(--color-danger);
        }

        .mdfe-validation-icon {
          font-size: var(--font-size-4xl);
        }

        .mdfe-validation-card.success .mdfe-validation-icon {
          color: var(--color-success);
        }

        .mdfe-validation-card.error .mdfe-validation-icon {
          color: var(--color-danger);
        }

        .mdfe-validation-content h3 {
          margin: 0 0 var(--spacing-sm) 0;
        }

        .mdfe-validation-content p {
          margin: 0;
          color: var(--color-text-secondary);
        }

        /* Responsividade */
        @media (max-width: 1024px) {
          .mdfe-sidebar {
            width: 280px;
          }

          .mdfe-span-2 {
            grid-column: span 1;
          }
        }

        @media (max-width: 768px) {
          .mdfe-sidebar {
            position: fixed;
            top: 0;
            left: 0;
            z-index: var(--z-modal);
            width: 100%;
            height: 100vh;
            transform: translateX(-100%);
            transition: transform var(--transition-base);
          }

          .mdfe-sidebar.open {
            transform: translateX(0);
          }

          .mdfe-sidebar-toggle {
            display: block;
          }

          .mdfe-main-content {
            padding: var(--spacing-xl);
          }

          .mdfe-header-content {
            flex-direction: column;
            text-align: center;
          }

          .mdfe-validation-card {
            grid-column: span 1;
          }
        }
      `}</style>
    </div>
  );
}