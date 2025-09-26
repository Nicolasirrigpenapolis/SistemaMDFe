import React from 'react';
import Icon from '../Icon';

interface ConfirmTransmissaoModalProps {
  isOpen: boolean;
  onConfirm: () => void;
  onCancel: () => void;
  isTransmitting?: boolean;
  numeroMDFe?: string;
  ambiente?: 'producao' | 'homologacao';
}

const ConfirmTransmissaoModal: React.FC<ConfirmTransmissaoModalProps> = ({
  isOpen,
  onConfirm,
  onCancel,
  isTransmitting = false,
  numeroMDFe,
  ambiente = 'homologacao'
}) => {
  if (!isOpen) return null;

  return (
    <div style={{
      position: 'fixed',
      top: 0,
      left: 0,
      right: 0,
      bottom: 0,
      backgroundColor: 'rgba(0, 0, 0, 0.6)',
      display: 'flex',
      alignItems: 'center',
      justifyContent: 'center',
      zIndex: 1000,
      backdropFilter: 'blur(4px)'
    }}>
      <div style={{
        background: 'var(--color-background)',
        borderRadius: '16px',
        boxShadow: '0 20px 60px rgba(0, 0, 0, 0.3)',
        width: '100%',
        maxWidth: '500px',
        margin: '2rem',
        border: '2px solid var(--color-border)',
        overflow: 'hidden'
      }}>
        {/* Header */}
        <div style={{
          background: ambiente === 'producao'
            ? 'linear-gradient(135deg, #dc2626, #b91c1c)'
            : 'linear-gradient(135deg, #f59e0b, #d97706)',
          padding: '2rem',
          color: 'white',
          textAlign: 'center'
        }}>
          <div style={{
            width: '60px',
            height: '60px',
            background: 'rgba(255, 255, 255, 0.2)',
            borderRadius: '50%',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            margin: '0 auto 1rem',
            border: '3px solid rgba(255, 255, 255, 0.3)'
          }}>
            <Icon name="zap" style={{ fontSize: '1.75rem' }} />
          </div>
          <h2 style={{
            margin: '0 0 0.5rem 0',
            fontSize: '1.5rem',
            fontWeight: '700'
          }}>
            Transmitir para SEFAZ
          </h2>
          <p style={{
            margin: '0',
            fontSize: '0.95rem',
            opacity: 0.9
          }}>
            Confirme a transmissão do documento fiscal
          </p>
        </div>

        {/* Content */}
        <div style={{ padding: '2rem' }}>
          {/* Informações do Documento */}
          <div style={{
            background: 'var(--color-background-secondary)',
            borderRadius: '12px',
            padding: '1.5rem',
            marginBottom: '1.5rem',
            border: '1px solid var(--color-border)'
          }}>
            <div style={{
              display: 'flex',
              alignItems: 'center',
              gap: '0.75rem',
              marginBottom: '1rem'
            }}>
              <Icon name="file-text" style={{ fontSize: '1.25rem', color: '#3b82f6' }} />
              <h3 style={{
                margin: '0',
                fontSize: '1rem',
                fontWeight: '600',
                color: 'var(--color-text-primary)'
              }}>
                Documento MDF-e
              </h3>
            </div>

            <div style={{
              display: 'grid',
              gridTemplateColumns: '1fr 1fr',
              gap: '1rem',
              fontSize: '0.875rem'
            }}>
              <div>
                <span style={{ color: 'var(--color-text-secondary)' }}>Número:</span>
                <div style={{ fontWeight: '600', color: 'var(--color-text-primary)' }}>
                  {numeroMDFe || 'Automático'}
                </div>
              </div>
              <div>
                <span style={{ color: 'var(--color-text-secondary)' }}>Ambiente:</span>
                <div style={{
                  fontWeight: '600',
                  color: ambiente === 'producao' ? '#dc2626' : '#f59e0b'
                }}>
                  {ambiente === 'producao' ? 'PRODUÇÃO' : 'HOMOLOGAÇÃO'}
                </div>
              </div>
            </div>
          </div>

          {/* Aviso */}
          <div style={{
            background: ambiente === 'producao'
              ? 'rgba(220, 38, 38, 0.1)'
              : 'rgba(245, 158, 11, 0.1)',
            border: `1px solid ${ambiente === 'producao' ? 'rgba(220, 38, 38, 0.2)' : 'rgba(245, 158, 11, 0.2)'}`,
            borderRadius: '8px',
            padding: '1rem',
            marginBottom: '1.5rem',
            display: 'flex',
            alignItems: 'flex-start',
            gap: '0.75rem'
          }}>
            <Icon
              name="alert-triangle"
              style={{
                fontSize: '1.25rem',
                color: ambiente === 'producao' ? '#dc2626' : '#f59e0b',
                marginTop: '0.125rem'
              }}
            />
            <div>
              <div style={{
                fontWeight: '600',
                fontSize: '0.875rem',
                color: 'var(--color-text-primary)',
                marginBottom: '0.25rem'
              }}>
                Atenção: Operação irreversível
              </div>
              <div style={{
                fontSize: '0.8rem',
                color: 'var(--color-text-secondary)',
                lineHeight: '1.4'
              }}>
                Uma vez transmitido para a SEFAZ, o documento não poderá ser alterado.
                Certifique-se de que todas as informações estão corretas.
              </div>
            </div>
          </div>

          {/* Pergunta Principal */}
          <div style={{
            textAlign: 'center',
            fontSize: '1.1rem',
            fontWeight: '600',
            color: 'var(--color-text-primary)',
            marginBottom: '2rem'
          }}>
            Deseja transmitir este MDFe para a SEFAZ?
          </div>

          {/* Buttons */}
          <div style={{
            display: 'flex',
            gap: '1rem',
            justifyContent: 'center'
          }}>
            <button
              onClick={onCancel}
              disabled={isTransmitting}
              style={{
                padding: '0.875rem 1.75rem',
                border: '2px solid #6b7280',
                borderRadius: '10px',
                background: 'var(--color-background)',
                color: '#6b7280',
                cursor: isTransmitting ? 'not-allowed' : 'pointer',
                fontWeight: '600',
                fontSize: '0.95rem',
                transition: 'all 0.2s ease',
                display: 'flex',
                alignItems: 'center',
                gap: '0.5rem',
                minWidth: '120px',
                justifyContent: 'center',
                opacity: isTransmitting ? 0.6 : 1
              }}
            >
              <Icon name="x" style={{ fontSize: '1rem' }} />
              Cancelar
            </button>

            <button
              onClick={onConfirm}
              disabled={isTransmitting}
              style={{
                padding: '0.875rem 1.75rem',
                border: 'none',
                borderRadius: '10px',
                background: isTransmitting
                  ? '#6b7280'
                  : ambiente === 'producao'
                    ? 'linear-gradient(135deg, #dc2626, #b91c1c)'
                    : 'linear-gradient(135deg, #f59e0b, #d97706)',
                color: 'white',
                cursor: isTransmitting ? 'not-allowed' : 'pointer',
                fontWeight: '700',
                fontSize: '1rem',
                transition: 'all 0.2s ease',
                display: 'flex',
                alignItems: 'center',
                gap: '0.75rem',
                minWidth: '180px',
                justifyContent: 'center',
                boxShadow: isTransmitting
                  ? 'none'
                  : ambiente === 'producao'
                    ? '0 4px 12px rgba(220, 38, 38, 0.4)'
                    : '0 4px 12px rgba(245, 158, 11, 0.4)',
                transform: isTransmitting ? 'none' : 'translateY(-1px)'
              }}
            >
              <Icon
                name={isTransmitting ? 'loader' : 'zap'}
                style={{
                  fontSize: '1.25rem',
                  animation: isTransmitting ? 'spin 1s linear infinite' : 'none'
                }}
              />
              {isTransmitting ? 'TRANSMITINDO...' : 'TRANSMITIR AGORA'}
            </button>
          </div>
        </div>
      </div>

      {/* Animação de spin para o loader */}
      <style>{`
        @keyframes spin {
          from {
            transform: rotate(0deg);
          }
          to {
            transform: rotate(360deg);
          }
        }
      `}</style>
    </div>
  );
};

export default ConfirmTransmissaoModal;