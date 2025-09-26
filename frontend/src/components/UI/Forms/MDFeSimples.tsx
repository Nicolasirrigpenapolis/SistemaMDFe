import React, { useState, useEffect } from 'react';
import { MDFeData } from '../../../types/mdfe';
import { entitiesService, EntityOption } from '../../../services/entitiesService';
import { mdfeService } from '../../../services/mdfeService';
import { formatCNPJ, formatPlaca } from '../../../utils/formatters';
import Icon from '../Icon';

interface MDFeSimplesProps {
  dados: Partial<MDFeData>;
  onDadosChange: (dados: Partial<MDFeData>) => void;
  onSalvar: () => void;
  onCancelar: () => void;
  onTransmitir?: () => void;
  salvando: boolean;
  transmitindo?: boolean;
  isEdicao: boolean;
}

export function MDFeSimples({
  dados,
  onDadosChange,
  onSalvar,
  onCancelar,
  onTransmitir,
  salvando,
  transmitindo = false,
  isEdicao
}: MDFeSimplesProps) {
  const [emitentes, setEmitentes] = useState<EntityOption[]>([]);
  const [condutores, setCondutores] = useState<EntityOption[]>([]);
  const [veiculos, setVeiculos] = useState<EntityOption[]>([]);
  const [loading, setLoading] = useState(false);

  // Estados para UF
  const ufs = [
    'AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA',
    'MT', 'MS', 'MG', 'PA', 'PB', 'PR', 'PE', 'PI', 'RJ', 'RN',
    'RS', 'RO', 'RR', 'SC', 'SP', 'SE', 'TO'
  ];

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

  // Validações
  const emitenteCompleto = !!(dados.emit?.CNPJ && dados.emit?.xNome);
  const veiculoCompleto = !!(dados.infModal?.rodo?.veicTracao?.placa);
  const trajetoCompleto = !!(dados.ide?.UFIni && dados.ide?.UFFim);
  const cargaCompleta = !!(dados.tot?.vCarga && parseFloat(dados.tot.vCarga) > 0);

  const podeEmitir = emitenteCompleto && veiculoCompleto && trajetoCompleto && cargaCompleta;

  return (
    <div className="mdfe-simples">
      {/* Header Compacto */}
      <div className="mdfe-header">
        <div className="mdfe-title">
          <Icon name={isEdicao ? "edit" : "plus"} />
          <div>
            <h1>{isEdicao ? 'Editar' : 'Novo'} MDF-e</h1>
            {dados.ide?.serie && dados.ide?.nMDF && (
              <span className="mdfe-numero">Série {dados.ide.serie} - Nº {dados.ide.nMDF}</span>
            )}
          </div>
        </div>

        <div className="mdfe-status">
          <div className={`status-badge ${podeEmitir ? 'success' : 'warning'}`}>
            <Icon name={podeEmitir ? 'check-circle' : 'alert-circle'} />
            {podeEmitir ? 'Pronto' : 'Incompleto'}
          </div>
        </div>
      </div>

      {/* Formulário em Grid Compacto */}
      <div className="mdfe-form">
        {/* Linha 1: Emitente e Veículo */}
        <div className="form-row">
          <div className="form-group">
            <label>Emitente *</label>
            <select
              value={emitentes.find(e => e.data?.CNPJ === dados.emit?.CNPJ)?.id || ''}
              onChange={(e) => {
                const emitente = emitentes.find(em => em.id === e.target.value);
                if (emitente?.data) {
                  onDadosChange({
                    ...dados,
                    emit: {
                      ...dados.emit,
                      CNPJ: emitente.data.CNPJ || '',
                      xNome: emitente.data.xNome || '',
                      IE: emitente.data.IE || ''
                    }
                  });
                }
              }}
            >
              <option value="">Selecione o emitente</option>
              {emitentes.map(emitente => (
                <option key={emitente.id} value={emitente.id}>
                  {emitente.label}
                </option>
              ))}
            </select>
            {dados.emit?.xNome && (
              <div className="selected-info">
                {dados.emit.xNome} - {formatCNPJ(dados.emit.CNPJ || '')}
              </div>
            )}
          </div>

          <div className="form-group">
            <label>Veículo *</label>
            <select
              value={veiculos.find(v => v.data?.placa === dados.infModal?.rodo?.veicTracao?.placa)?.id || ''}
              onChange={(e) => {
                const veiculo = veiculos.find(v => v.id === e.target.value);
                if (veiculo?.data) {
                  onDadosChange({
                    ...dados,
                    infModal: {
                      ...dados.infModal,
                      versaoModal: '3.00',
                      rodo: {
                        ...dados.infModal?.rodo,
                        veicTracao: {
                          ...dados.infModal?.rodo?.veicTracao,
                          placa: veiculo.data.placa || '',
                          tara: veiculo.data.tara?.toString() || '',
                          tpRod: '06',
                          tpCar: '00'
                        }
                      }
                    }
                  });
                }
              }}
            >
              <option value="">Selecione o veículo</option>
              {veiculos.map(veiculo => (
                <option key={veiculo.id} value={veiculo.id}>
                  {veiculo.label}
                </option>
              ))}
            </select>
            {dados.infModal?.rodo?.veicTracao?.placa && (
              <div className="selected-info">
                Placa: {formatPlaca(dados.infModal.rodo.veicTracao.placa)}
              </div>
            )}
          </div>
        </div>

        {/* Linha 2: Trajeto */}
        <div className="form-row">
          <div className="form-group">
            <label>UF Origem *</label>
            <select
              value={dados.ide?.UFIni || ''}
              onChange={(e) => onDadosChange({
                ...dados,
                ide: { ...dados.ide, UFIni: e.target.value }
              })}
            >
              <option value="">Selecione UF origem</option>
              {ufs.map(uf => (
                <option key={uf} value={uf}>{uf}</option>
              ))}
            </select>
          </div>

          <div className="form-group">
            <label>UF Destino *</label>
            <select
              value={dados.ide?.UFFim || ''}
              onChange={(e) => onDadosChange({
                ...dados,
                ide: { ...dados.ide, UFFim: e.target.value }
              })}
            >
              <option value="">Selecione UF destino</option>
              {ufs.map(uf => (
                <option key={uf} value={uf}>{uf}</option>
              ))}
            </select>
          </div>

          <div className="form-group">
            <label>Valor da Carga (R$) *</label>
            <input
              type="number"
              step="0.01"
              value={dados.tot?.vCarga || ''}
              onChange={(e) => onDadosChange({
                ...dados,
                tot: { ...dados.tot, vCarga: e.target.value }
              })}
              placeholder="0,00"
            />
          </div>
        </div>

        {/* Linha 3: Condutor (Opcional) */}
        <div className="form-row">
          <div className="form-group optional">
            <label>Condutor <span className="optional-text">(opcional)</span></label>
            <select
              value={condutores.find(c => c.data?.CPF === dados.infModal?.rodo?.veicTracao?.condutor?.[0]?.CPF)?.id || ''}
              onChange={(e) => {
                const condutor = condutores.find(c => c.id === e.target.value);
                if (condutor?.data) {
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
                            xNome: condutor.data.xNome || '',
                            CPF: condutor.data.CPF || ''
                          }]
                        }
                      }
                    }
                  });
                } else {
                  // Remover condutor se selecionou vazio
                  onDadosChange({
                    ...dados,
                    infModal: {
                      ...dados.infModal,
                      rodo: {
                        ...dados.infModal?.rodo,
                        veicTracao: {
                          ...dados.infModal?.rodo?.veicTracao,
                          condutor: undefined
                        }
                      }
                    }
                  });
                }
              }}
            >
              <option value="">Nenhum condutor</option>
              {condutores.map(condutor => (
                <option key={condutor.id} value={condutor.id}>
                  {condutor.label}
                </option>
              ))}
            </select>
          </div>

          <div className="form-group">
            <label>Peso da Carga (kg) <span className="optional-text">(opcional)</span></label>
            <input
              type="number"
              step="0.001"
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

      {/* Ações */}
      <div className="mdfe-actions">
        <button
          type="button"
          className="btn btn-secondary"
          onClick={onCancelar}
        >
          <Icon name="x" />
          Cancelar
        </button>

        <div className="actions-main">
          <button
            type="button"
            className="btn btn-primary"
            onClick={onSalvar}
            disabled={salvando || !podeEmitir}
          >
            {salvando ? (
              <>
                <div className="spinner" />
                Salvando...
              </>
            ) : (
              <>
                <Icon name="save" />
                Salvar MDF-e
              </>
            )}
          </button>

          {onTransmitir && podeEmitir && (
            <button
              type="button"
              className="btn btn-success"
              onClick={onTransmitir}
              disabled={transmitindo || !podeEmitir}
            >
              {transmitindo ? (
                <>
                  <div className="spinner" />
                  Transmitindo...
                </>
              ) : (
                <>
                  <Icon name="send" />
                  Transmitir SEFAZ
                </>
              )}
            </button>
          )}
        </div>
      </div>

      <style>{`
        .mdfe-simples {
          height: 100vh;
          display: flex;
          flex-direction: column;
          background: var(--color-background);
          padding: 1.5rem;
          box-sizing: border-box;
        }

        .mdfe-header {
          display: flex;
          align-items: center;
          justify-content: space-between;
          padding: 1.5rem 2rem;
          background: var(--gradient-surface);
          border-radius: var(--border-radius-lg);
          box-shadow: var(--shadow-md);
          margin-bottom: 1.5rem;
        }

        .mdfe-title {
          display: flex;
          align-items: center;
          gap: 1rem;
        }

        .mdfe-title svg {
          width: 2.5rem;
          height: 2.5rem;
          color: var(--color-primary);
        }

        .mdfe-title h1 {
          margin: 0;
          font-size: 1.75rem;
          font-weight: 700;
          color: var(--color-text-primary);
        }

        .mdfe-numero {
          font-size: 0.875rem;
          color: var(--color-text-secondary);
          background: var(--color-primary-light);
          padding: 0.25rem 0.75rem;
          border-radius: var(--border-radius);
          font-weight: 500;
        }

        .status-badge {
          display: flex;
          align-items: center;
          gap: 0.5rem;
          padding: 0.75rem 1.25rem;
          border-radius: var(--border-radius);
          font-weight: 600;
          font-size: 0.875rem;
        }

        .status-badge.success {
          background: var(--color-success-light);
          color: var(--color-success-dark);
          border: 2px solid var(--color-success);
        }

        .status-badge.warning {
          background: var(--color-warning-light);
          color: var(--color-warning-dark);
          border: 2px solid var(--color-warning);
        }

        .mdfe-form {
          flex: 1;
          background: var(--color-surface);
          border-radius: var(--border-radius-lg);
          padding: 2rem;
          box-shadow: var(--shadow-md);
          display: flex;
          flex-direction: column;
          gap: 1.5rem;
          margin-bottom: 1.5rem;
        }

        .form-row {
          display: grid;
          grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
          gap: 1.5rem;
          align-items: start;
        }

        .form-group {
          display: flex;
          flex-direction: column;
          gap: 0.5rem;
        }

        .form-group.optional {
          opacity: 0.8;
        }

        .form-group label {
          font-weight: 600;
          color: var(--color-text-primary);
          font-size: 0.875rem;
        }

        .optional-text {
          color: var(--color-text-tertiary);
          font-weight: 400;
          font-size: 0.75rem;
        }

        .form-group select,
        .form-group input {
          padding: 0.75rem;
          border: 2px solid var(--color-border);
          border-radius: var(--border-radius);
          font-size: 0.875rem;
          background: var(--color-surface);
          color: var(--color-text-primary);
          transition: all var(--transition-fast);
        }

        .form-group select:focus,
        .form-group input:focus {
          outline: none;
          border-color: var(--color-primary);
          box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }

        .selected-info {
          font-size: 0.75rem;
          color: var(--color-text-secondary);
          background: var(--color-background-secondary);
          padding: 0.5rem;
          border-radius: var(--border-radius-sm);
        }

        .mdfe-actions {
          display: flex;
          align-items: center;
          justify-content: space-between;
          padding: 1.5rem 2rem;
          background: var(--color-surface);
          border-radius: var(--border-radius-lg);
          box-shadow: var(--shadow-md);
        }

        .actions-main {
          display: flex;
          gap: 1rem;
        }

        .btn {
          display: flex;
          align-items: center;
          gap: 0.5rem;
          padding: 0.75rem 1.5rem;
          border: none;
          border-radius: var(--border-radius);
          font-size: 0.875rem;
          font-weight: 600;
          cursor: pointer;
          transition: all var(--transition-fast);
          text-decoration: none;
        }

        .btn:disabled {
          opacity: 0.5;
          cursor: not-allowed;
        }

        .btn-secondary {
          background: var(--color-surface);
          color: var(--color-text-primary);
          border: 2px solid var(--color-border);
        }

        .btn-secondary:hover:not(:disabled) {
          background: var(--color-surface-hover);
          border-color: var(--color-text-tertiary);
        }

        .btn-primary {
          background: var(--gradient-primary);
          color: white;
          box-shadow: var(--shadow-md);
        }

        .btn-primary:hover:not(:disabled) {
          transform: translateY(-1px);
          box-shadow: var(--shadow-lg);
        }

        .btn-success {
          background: var(--gradient-success);
          color: white;
          box-shadow: var(--shadow-md);
        }

        .btn-success:hover:not(:disabled) {
          transform: translateY(-1px);
          box-shadow: var(--shadow-lg);
        }

        .spinner {
          width: 14px;
          height: 14px;
          border: 2px solid transparent;
          border-top: 2px solid currentColor;
          border-radius: 50%;
          animation: spin 1s linear infinite;
        }

        @keyframes spin {
          to { transform: rotate(360deg); }
        }

        /* Responsividade para telas menores */
        @media (max-width: 1024px) {
          .form-row {
            grid-template-columns: 1fr 1fr;
          }
        }

        @media (max-width: 768px) {
          .mdfe-simples {
            padding: 1rem;
          }

          .form-row {
            grid-template-columns: 1fr;
          }

          .mdfe-actions {
            flex-direction: column;
            gap: 1rem;
          }

          .actions-main {
            width: 100%;
            justify-content: center;
          }
        }
      `}</style>
    </div>
  );
}