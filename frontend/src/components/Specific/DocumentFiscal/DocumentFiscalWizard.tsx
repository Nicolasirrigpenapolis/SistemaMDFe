import React, { useState, useCallback } from 'react';
import { MDFeData, MensagemFeedback } from '../../types/mdfe';
import { OptionalFieldsToggle, OptionalSection } from '../common/OptionalFieldsToggle';

interface DocumentFiscalWizardProps {
  data: MDFeData;
  onChange: (data: Partial<MDFeData>) => void;
  onFeedback: (message: MensagemFeedback) => void;
}

interface WizardStep {
  id: string;
  title: string;
  description: string;
  icon: string;
  isCompleted: boolean;
  isRequired: boolean;
}

export const DocumentFiscalWizard: React.FC<DocumentFiscalWizardProps> = ({
  data,
  onChange,
  onFeedback
}) => {
  const [currentStep, setCurrentStep] = useState<string>('basic-info');
  const [mostrarCamposOpcionais, setMostrarCamposOpcionais] = useState<Record<string, boolean>>({});

  const toggleOptionalField = useCallback((fieldKey: string) => {
    setMostrarCamposOpcionais(prev => ({
      ...prev,
      [fieldKey]: !prev[fieldKey]
    }));
  }, []);

  const steps: WizardStep[] = [
    {
      id: 'basic-info',
      title: 'Informações Básicas',
      description: 'Emitente, rota e modal',
      icon: 'fas fa-info-circle',
      isCompleted: !!(data.emit?.CNPJ && data.ide?.UFIni && data.ide?.UFFim),
      isRequired: true
    },
    {
      id: 'documents',
      title: 'Documentos Fiscais',
      description: 'CTe, NFe e MDFe',
      icon: 'fas fa-file-invoice',
      isCompleted: !!(data.infDoc?.infMunDescarga?.length),
      isRequired: true
    },
    {
      id: 'vehicle-driver',
      title: 'Veículo e Condutor',
      description: 'Dados do transporte',
      icon: 'fas fa-truck',
      isCompleted: !!(data.infModal?.rodo?.veicTracao?.placa),
      isRequired: true
    },
    {
      id: 'cargo-insurance',
      title: 'Carga e Seguro',
      description: 'Totais e seguros',
      icon: 'fas fa-shield-alt',
      isCompleted: !!(data.tot?.qCarga),
      isRequired: true
    },
    {
      id: 'additional-info',
      title: 'Informações Adicionais',
      description: 'Dados complementares',
      icon: 'fas fa-plus-circle',
      isCompleted: false,
      isRequired: false
    }
  ];

  const currentStepData = steps.find(step => step.id === currentStep);
  const currentStepIndex = steps.findIndex(step => step.id === currentStep);
  const isFirstStep = currentStepIndex === 0;
  const isLastStep = currentStepIndex === steps.length - 1;

  const handleNext = () => {
    if (!isLastStep) {
      setCurrentStep(steps[currentStepIndex + 1].id);
    }
  };

  const handlePrevious = () => {
    if (!isFirstStep) {
      setCurrentStep(steps[currentStepIndex - 1].id);
    }
  };

  const renderStepContent = () => {
    switch (currentStep) {
      case 'basic-info':
        return renderBasicInfoStep();
      case 'documents':
        return renderDocumentsStep();
      case 'vehicle-driver':
        return renderVehicleDriverStep();
      case 'cargo-insurance':
        return renderCargoInsuranceStep();
      case 'additional-info':
        return renderAdditionalInfoStep();
      default:
        return <div>Etapa não encontrada</div>;
    }
  };

  const renderBasicInfoStep = () => (
    <div className="wizard-step-content">
      <div className="form-section">
        <h3>Identificação do Manifesto</h3>
        <div className="form-grid">
          <div className="form-field">
            <label>Série *</label>
            <input
              type="number"
              value={data.ide?.serie || ''}
              onChange={(e) => onChange({
                ide: { ...data.ide, serie: e.target.value }
              })}
              min="1"
              max="999"
              required
            />
          </div>
          <div className="form-field">
            <label>Número *</label>
            <input
              type="number"
              value={data.ide?.nMDF || ''}
              onChange={(e) => onChange({
                ide: { ...data.ide, nMDF: e.target.value }
              })}
              min="1"
              required
            />
          </div>
        </div>
      </div>

      <div className="form-section">
        <h3>Rota de Transporte</h3>
        <div className="form-grid">
          <div className="form-field">
            <label>UF Inicial *</label>
            <select
              value={data.ide?.UFIni || ''}
              onChange={(e) => onChange({
                ide: { ...data.ide, UFIni: e.target.value }
              })}
              required
            >
              <option value="">Selecione...</option>
              <option value="SP">São Paulo</option>
              <option value="RJ">Rio de Janeiro</option>
              <option value="MG">Minas Gerais</option>
              {/* Adicionar mais UFs */}
            </select>
          </div>
          <div className="form-field">
            <label>UF Final *</label>
            <select
              value={data.ide?.UFFim || ''}
              onChange={(e) => onChange({
                ide: { ...data.ide, UFFim: e.target.value }
              })}
              required
            >
              <option value="">Selecione...</option>
              <option value="SP">São Paulo</option>
              <option value="RJ">Rio de Janeiro</option>
              <option value="MG">Minas Gerais</option>
              {/* Adicionar mais UFs */}
            </select>
          </div>
        </div>
      </div>

      <OptionalFieldsToggle
        label="Informações Complementares"
        description="Dados adicionais sobre o manifesto"
        isExpanded={mostrarCamposOpcionais.basicOptional}
        onToggle={() => toggleOptionalField('basicOptional')}
      />

      <OptionalSection isVisible={mostrarCamposOpcionais.basicOptional}>
        <div className="form-grid">
          <div className="form-field">
            <label>Tipo de Emissão</label>
            <select
              value={data.ide?.tpEmis || '1'}
              onChange={(e) => onChange({
                ide: { ...data.ide, tpEmis: e.target.value as "1" | "2" | "3" }
              })}
            >
              <option value="1">Normal</option>
              <option value="2">Contingência</option>
            </select>
          </div>
          <div className="form-field">
            <label>Processo de Emissão</label>
            <select
              value={data.ide?.procEmi || '0'}
              onChange={(e) => onChange({
                ide: { ...data.ide, procEmi: e.target.value as "0" | "3" }
              })}
            >
              <option value="0">Aplicativo do contribuinte</option>
              <option value="1">Avulsa pela Fazenda</option>
            </select>
          </div>
        </div>
      </OptionalSection>
    </div>
  );

  const renderDocumentsStep = () => (
    <div className="wizard-step-content">
      <div className="form-section">
        <h3>Documentos Fiscais</h3>
        <p>Adicione os documentos fiscais que serão transportados</p>

        <div className="document-types">
          <div className="document-type-card">
            <div className="card-header">
              <i className="fas fa-file-alt"></i>
              <h4>Conhecimentos de Transporte (CTe)</h4>
            </div>
            <button className="btn btn-outline">
              <i className="fas fa-plus"></i>
              Adicionar CTe
            </button>
          </div>

          <div className="document-type-card">
            <div className="card-header">
              <i className="fas fa-receipt"></i>
              <h4>Notas Fiscais (NFe)</h4>
            </div>
            <button className="btn btn-outline">
              <i className="fas fa-plus"></i>
              Adicionar NFe
            </button>
          </div>
        </div>
      </div>
    </div>
  );

  const renderVehicleDriverStep = () => (
    <div className="wizard-step-content">
      <div className="form-section">
        <h3>Veículo de Tração</h3>
        <div className="form-grid">
          <div className="form-field">
            <label>Placa *</label>
            <input
              type="text"
              value={data.infModal?.rodo?.veicTracao?.placa || ''}
              onChange={(e) => onChange({
                infModal: {
                  ...data.infModal,
                  rodo: {
                    ...data.infModal?.rodo,
                    veicTracao: {
                      ...data.infModal?.rodo?.veicTracao,
                      placa: e.target.value
                    }
                  }
                }
              })}
              placeholder="ABC1234"
              required
            />
          </div>
          <div className="form-field">
            <label>RENAVAM *</label>
            <input
              type="text"
              value={data.infModal?.rodo?.veicTracao?.RENAVAM || ''}
              onChange={(e) => onChange({
                infModal: {
                  ...data.infModal,
                  rodo: {
                    ...data.infModal?.rodo,
                    veicTracao: {
                      ...data.infModal?.rodo?.veicTracao,
                      RENAVAM: e.target.value
                    }
                  }
                }
              })}
              required
            />
          </div>
        </div>
      </div>

      <div className="form-section">
        <h3>Condutor</h3>
        <div className="form-grid">
          <div className="form-field">
            <label>Nome *</label>
            <input
              type="text"
              value={data.infModal?.rodo?.veicTracao?.condutor?.[0]?.xNome || ''}
              onChange={(e) => onChange({
                infModal: {
                  ...data.infModal,
                  rodo: {
                    ...data.infModal?.rodo,
                    veicTracao: {
                      ...data.infModal?.rodo?.veicTracao,
                      condutor: [{
                        xNome: e.target.value,
                        CPF: data.infModal?.rodo?.veicTracao?.condutor?.[0]?.CPF || ''
                      }]
                    }
                  }
                }
              })}
              required
            />
          </div>
          <div className="form-field">
            <label>CPF *</label>
            <input
              type="text"
              value={data.infModal?.rodo?.veicTracao?.condutor?.[0]?.CPF || ''}
              onChange={(e) => onChange({
                infModal: {
                  ...data.infModal,
                  rodo: {
                    ...data.infModal?.rodo,
                    veicTracao: {
                      ...data.infModal?.rodo?.veicTracao,
                      condutor: [{
                        xNome: data.infModal?.rodo?.veicTracao?.condutor?.[0]?.xNome || '',
                        CPF: e.target.value
                      }]
                    }
                  }
                }
              })}
              required
            />
          </div>
        </div>
      </div>
    </div>
  );

  const renderCargoInsuranceStep = () => (
    <div className="wizard-step-content">
      <div className="form-section">
        <h3>Totais da Carga</h3>
        <div className="form-grid">
          <div className="form-field">
            <label>Quantidade de Carga (Kg) *</label>
            <input
              type="number"
              value={data.tot?.qCarga || ''}
              onChange={(e) => onChange({
                tot: { ...data.tot, qCarga: e.target.value }
              })}
              step="0.01"
              min="0"
              required
            />
          </div>
          <div className="form-field">
            <label>Valor Total da Carga *</label>
            <input
              type="number"
              value={data.tot?.vCarga || ''}
              onChange={(e) => onChange({
                tot: { ...data.tot, vCarga: e.target.value }
              })}
              step="0.01"
              min="0"
              required
            />
          </div>
        </div>
      </div>

      <OptionalFieldsToggle
        label="Informações de Seguro"
        description="Dados do seguro da carga (opcional)"
        isExpanded={mostrarCamposOpcionais.insurance}
        onToggle={() => toggleOptionalField('insurance')}
        icon="fas fa-shield-alt"
      />

      <OptionalSection isVisible={mostrarCamposOpcionais.insurance}>
        <div className="form-grid">
          <div className="form-field">
            <label>Responsável pelo Seguro</label>
            <select>
              <option value="">Selecione...</option>
              <option value="1">Emitente do MDF-e</option>
              <option value="2">Contratante do serviço</option>
            </select>
          </div>
          <div className="form-field">
            <label>Nome da Seguradora</label>
            <input type="text" placeholder="Nome da empresa seguradora" />
          </div>
        </div>
      </OptionalSection>
    </div>
  );

  const renderAdditionalInfoStep = () => (
    <div className="wizard-step-content">
      <div className="form-section">
        <h3>Informações Adicionais</h3>
        <p>Todos os campos desta seção são opcionais</p>

        <OptionalFieldsToggle
          label="Informações do Frete"
          description="Detalhes sobre o frete e pagamento"
          isExpanded={mostrarCamposOpcionais.freight}
          onToggle={() => toggleOptionalField('freight')}
          icon="fas fa-money-bill"
        />

        <OptionalSection isVisible={mostrarCamposOpcionais.freight}>
          <div className="form-grid">
            <div className="form-field">
              <label>Valor do Frete</label>
              <input type="number" step="0.01" min="0" />
            </div>
            <div className="form-field">
              <label>Forma de Pagamento</label>
              <select>
                <option value="">Selecione...</option>
                <option value="0">Pago</option>
                <option value="1">A pagar</option>
                <option value="2">Outros</option>
              </select>
            </div>
          </div>
        </OptionalSection>

        <OptionalFieldsToggle
          label="Observações"
          description="Informações complementares do manifesto"
          isExpanded={mostrarCamposOpcionais.observations}
          onToggle={() => toggleOptionalField('observations')}
          icon="fas fa-comment"
        />

        <OptionalSection isVisible={mostrarCamposOpcionais.observations}>
          <div className="form-field">
            <label>Observações Gerais</label>
            <textarea
              rows={4}
              placeholder="Digite aqui informações complementares sobre o transporte..."
              style={{ resize: 'vertical' }}
            />
          </div>
        </OptionalSection>
      </div>
    </div>
  );

  return (
    <div className="document-fiscal-wizard">
      {/* Progress Header */}
      <div className="wizard-header">
        <div className="wizard-progress">
          {steps.map((step, index) => (
            <div
              key={step.id}
              className={`progress-step ${currentStep === step.id ? 'active' : ''} ${step.isCompleted ? 'completed' : ''}`}
              onClick={() => setCurrentStep(step.id)}
            >
              <div className="step-circle">
                {step.isCompleted ? (
                  <i className="fas fa-check"></i>
                ) : (
                  <span>{index + 1}</span>
                )}
              </div>
              <div className="step-label">
                <div className="step-title">{step.title}</div>
                <div className="step-description">{step.description}</div>
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* Step Content */}
      <div className="wizard-content">
        <div className="step-header">
          <i className={currentStepData?.icon}></i>
          <div>
            <h2>{currentStepData?.title}</h2>
            <p>{currentStepData?.description}</p>
          </div>
        </div>

        {renderStepContent()}
      </div>

      {/* Navigation Footer */}
      <div className="wizard-footer">
        <div className="wizard-navigation">
          {!isFirstStep && (
            <button className="btn btn-secondary" onClick={handlePrevious}>
              <i className="fas fa-chevron-left"></i>
              Anterior
            </button>
          )}

          <div className="nav-spacer"></div>

          {!isLastStep ? (
            <button className="btn btn-primary" onClick={handleNext}>
              Próximo
              <i className="fas fa-chevron-right"></i>
            </button>
          ) : (
            <button className="btn btn-success">
              Finalizar
              <i className="fas fa-check"></i>
            </button>
          )}
        </div>
      </div>

      <style>{`
        .document-fiscal-wizard {
          max-width: 1200px;
          margin: 0 auto;
          background: white;
          border-radius: 12px;
          box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
          overflow: hidden;
        }

        .wizard-header {
          background: linear-gradient(135deg, #0284c7 0%, #0369a1 100%);
          color: white;
          padding: 24px;
        }

        .wizard-progress {
          display: flex;
          justify-content: space-between;
          align-items: center;
          max-width: 800px;
          margin: 0 auto;
        }

        .progress-step {
          display: flex;
          align-items: center;
          cursor: pointer;
          transition: all 0.2s ease;
          padding: 8px;
          border-radius: 8px;
          flex: 1;
          margin: 0 4px;
        }

        .progress-step:hover {
          background: rgba(255, 255, 255, 0.1);
        }

        .progress-step.active {
          background: rgba(255, 255, 255, 0.2);
        }

        .step-circle {
          width: 32px;
          height: 32px;
          border-radius: 50%;
          background: rgba(255, 255, 255, 0.2);
          display: flex;
          align-items: center;
          justify-content: center;
          margin-right: 12px;
          font-weight: 600;
          font-size: 14px;
        }

        .progress-step.completed .step-circle {
          background: #10b981;
        }

        .progress-step.active .step-circle {
          background: white;
          color: #0284c7;
        }

        .step-label {
          flex: 1;
        }

        .step-title {
          font-weight: 600;
          font-size: 14px;
          margin-bottom: 2px;
        }

        .step-description {
          font-size: 12px;
          opacity: 0.8;
        }

        .wizard-content {
          padding: 32px;
        }

        .step-header {
          display: flex;
          align-items: center;
          margin-bottom: 32px;
          padding-bottom: 16px;
          border-bottom: 1px solid #e5e7eb;
        }

        .step-header i {
          font-size: 24px;
          color: #0284c7;
          margin-right: 16px;
        }

        .step-header h2 {
          margin: 0 0 4px 0;
          color: #111827;
          font-size: 24px;
          font-weight: 700;
        }

        .step-header p {
          margin: 0;
          color: #6b7280;
          font-size: 16px;
        }

        .wizard-step-content {
          min-height: 400px;
        }

        .form-section {
          margin-bottom: 32px;
        }

        .form-section h3 {
          margin: 0 0 16px 0;
          color: #374151;
          font-size: 18px;
          font-weight: 600;
        }

        .form-section p {
          margin: 0 0 16px 0;
          color: #6b7280;
          font-size: 14px;
        }

        .form-grid {
          display: grid;
          grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
          gap: 16px;
        }

        .form-field {
          display: flex;
          flex-direction: column;
        }

        .form-field label {
          font-weight: 500;
          color: #374151;
          margin-bottom: 6px;
          font-size: 14px;
        }

        .form-field input,
        .form-field select,
        .form-field textarea {
          padding: 12px;
          border: 1px solid #d1d5db;
          border-radius: 8px;
          font-size: 14px;
          transition: border-color 0.2s ease;
        }

        .form-field input:focus,
        .form-field select:focus,
        .form-field textarea:focus {
          outline: none;
          border-color: #0284c7;
          box-shadow: 0 0 0 3px rgba(2, 132, 199, 0.1);
        }

        .document-types {
          display: grid;
          grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
          gap: 16px;
        }

        .document-type-card {
          border: 1px solid #e5e7eb;
          border-radius: 8px;
          padding: 20px;
          text-align: center;
        }

        .document-type-card .card-header {
          display: flex;
          align-items: center;
          justify-content: center;
          margin-bottom: 16px;
        }

        .document-type-card .card-header i {
          font-size: 24px;
          color: #0284c7;
          margin-right: 12px;
        }

        .document-type-card h4 {
          margin: 0;
          color: #374151;
          font-size: 16px;
          font-weight: 600;
        }

        .btn {
          display: inline-flex;
          align-items: center;
          justify-content: center;
          padding: 12px 24px;
          border: none;
          border-radius: 8px;
          font-weight: 500;
          font-size: 14px;
          cursor: pointer;
          transition: all 0.2s ease;
          text-decoration: none;
        }

        .btn i {
          margin: 0 6px;
        }

        .btn-outline {
          background: white;
          color: #0284c7;
          border: 1px solid #0284c7;
        }

        .btn-outline:hover {
          background: #0284c7;
          color: white;
        }

        .btn-primary {
          background: #0284c7;
          color: white;
        }

        .btn-primary:hover {
          background: #0369a1;
        }

        .btn-secondary {
          background: #6b7280;
          color: white;
        }

        .btn-secondary:hover {
          background: #4b5563;
        }

        .btn-success {
          background: #10b981;
          color: white;
        }

        .btn-success:hover {
          background: #059669;
        }

        .wizard-footer {
          background: #f9fafb;
          padding: 24px 32px;
          border-top: 1px solid #e5e7eb;
        }

        .wizard-navigation {
          display: flex;
          align-items: center;
          justify-content: space-between;
        }

        .nav-spacer {
          flex: 1;
        }

        @media (max-width: 768px) {
          .wizard-progress {
            flex-direction: column;
            gap: 8px;
          }

          .progress-step {
            justify-content: flex-start;
            margin: 0;
          }

          .wizard-content {
            padding: 24px 16px;
          }

          .form-grid {
            grid-template-columns: 1fr;
          }
        }
      `}</style>
    </div>
  );
};