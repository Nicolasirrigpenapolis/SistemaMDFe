import React from 'react';
import { MDFeNumberBadge } from '../MDFe/MDFeNumberBadge';
import styles from './MDFeViewModal.module.css';

interface MDFe {
  id: number;
  numero: string;
  serie: string;
  dataEmissao: string;
  ufInicio: string;
  ufFim: string;
  valorCarga: number;
  status: 'Autorizado' | 'Pendente' | 'Cancelado' | 'Rejeitado' | 'Rascunho';
  chave: string;
  emitenteNome?: string;
  veiculoPlaca?: string;
}

interface MDFeViewModalProps {
  mdfe: MDFe;
  isOpen: boolean;
  onClose: () => void;
}

export function MDFeViewModal({ mdfe, isOpen, onClose }: MDFeViewModalProps) {
  if (!isOpen) return null;

  const formatCurrency = (value: number) => {
    return new Intl.NumberFormat('pt-BR', {
      style: 'currency',
      currency: 'BRL'
    }).format(value);
  };

  const formatDate = (dateString: string) => {
    return new Date(dateString).toLocaleDateString('pt-BR', {
      day: '2-digit',
      month: '2-digit',
      year: 'numeric',
      hour: '2-digit',
      minute: '2-digit'
    });
  };

  const getStatusConfig = (status: string) => {
    switch (status) {
      case 'Autorizado':
        return { color: 'success', bgColor: '#dcfce7', textColor: '#166534' };
      case 'Pendente':
        return { color: 'warning', bgColor: '#fef3c7', textColor: '#92400e' };
      case 'Rascunho':
        return { color: 'draft', bgColor: '#f3f4f6', textColor: '#374151' };
      case 'Cancelado':
        return { color: 'secondary', bgColor: '#f1f5f9', textColor: '#64748b' };
      case 'Rejeitado':
        return { color: 'danger', bgColor: '#fee2e2', textColor: '#dc2626' };
      default:
        return { color: 'secondary', bgColor: '#f3f4f6', textColor: '#6b7280' };
    }
  };

  const statusConfig = getStatusConfig(mdfe.status);

  return (
    <div className={styles.modalOverlay} onClick={onClose}>
      <div className={styles.modalContent} onClick={(e) => e.stopPropagation()}>
        <div className={styles.modalHeader}>
          <div className={styles.headerTop}>
            <MDFeNumberBadge
              numero={mdfe.numero}
              serie={mdfe.serie}
              size="large"
              variant="primary"
            />
            <button className={styles.closeButton} onClick={onClose}>
              <i className="fas fa-times"></i>
            </button>
          </div>

          <div className={styles.headerInfo}>
            <div
              className={styles.statusBadge}
              style={{
                backgroundColor: statusConfig.bgColor,
                color: statusConfig.textColor
              }}
            >
              <i className="fas fa-circle"></i>
              <span>{mdfe.status}</span>
            </div>
            <div className={styles.dateInfo}>
              <i className="fas fa-calendar-alt"></i>
              <span>{formatDate(mdfe.dataEmissao)}</span>
            </div>
          </div>
        </div>

        <div className={styles.modalBody}>
          <div className={styles.infoGrid}>
            <div className={styles.infoCard}>
              <div className={styles.cardHeader}>
                <i className="fas fa-building"></i>
                <h3>Emitente</h3>
              </div>
              <div className={styles.cardContent}>
                <p>{mdfe.emitenteNome || 'N/A'}</p>
              </div>
            </div>

            <div className={styles.infoCard}>
              <div className={styles.cardHeader}>
                <i className="fas fa-truck"></i>
                <h3>Veículo</h3>
              </div>
              <div className={styles.cardContent}>
                <p>{mdfe.veiculoPlaca || 'N/A'}</p>
              </div>
            </div>

            <div className={styles.infoCard}>
              <div className={styles.cardHeader}>
                <i className="fas fa-route"></i>
                <h3>Percurso</h3>
              </div>
              <div className={styles.cardContent}>
                <p>{mdfe.ufInicio} → {mdfe.ufFim}</p>
              </div>
            </div>

            <div className={styles.infoCard}>
              <div className={styles.cardHeader}>
                <i className="fas fa-dollar-sign"></i>
                <h3>Valor da Carga</h3>
              </div>
              <div className={styles.cardContent}>
                <p className={styles.valorDestaque}>{formatCurrency(mdfe.valorCarga)}</p>
              </div>
            </div>
          </div>

          {mdfe.chave && (
            <div className={styles.chaveSection}>
              <h4>
                <i className="fas fa-key"></i>
                Chave de Acesso
              </h4>
              <div className={styles.chaveContainer}>
                <code className={styles.chaveText}>{mdfe.chave}</code>
                <button
                  className={styles.copyButton}
                  onClick={() => navigator.clipboard.writeText(mdfe.chave)}
                  title="Copiar chave"
                >
                  <i className="fas fa-copy"></i>
                </button>
              </div>
            </div>
          )}
        </div>

        <div className={styles.modalFooter}>
          <div className={styles.actionButtons}>
            <button className={`${styles.actionBtn} ${styles.download}`}>
              <i className="fas fa-download"></i>
              <span>Download XML</span>
            </button>
            <button className={`${styles.actionBtn} ${styles.print}`}>
              <i className="fas fa-print"></i>
              <span>Imprimir</span>
            </button>
            {mdfe.status !== 'Cancelado' && (
              <button className={`${styles.actionBtn} ${styles.cancel}`}>
                <i className="fas fa-times"></i>
                <span>Cancelar</span>
              </button>
            )}
          </div>
        </div>
      </div>
    </div>
  );
}