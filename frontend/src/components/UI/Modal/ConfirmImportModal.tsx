import React from 'react';
import styles from './ConfirmImportModal.module.css';

interface ConfirmImportModalProps {
  isOpen: boolean;
  title: string;
  message: string;
  warningMessage?: string;
  onConfirm: () => void;
  onCancel: () => void;
  loading?: boolean;
  loadingMessage?: string;
}

export function ConfirmImportModal({
  isOpen,
  title,
  message,
  warningMessage,
  onConfirm,
  onCancel,
  loading = false,
  loadingMessage = 'Processando...'
}: ConfirmImportModalProps) {
  if (!isOpen) return null;

  return (
    <div className={styles.modalOverlay} onClick={!loading ? onCancel : undefined}>
      <div className={styles.modal} onClick={(e) => e.stopPropagation()}>
        <div className={styles.modalHeader}>
          <div className={styles.iconContainer}>
            <i className={loading ? "fas fa-sync-alt fa-spin" : "fas fa-download"}></i>
          </div>
          <h2>{loading ? 'Importando Dados' : title}</h2>
        </div>

        <div className={styles.modalBody}>
          <p>{loading ? loadingMessage : message}</p>

          {!loading && warningMessage && (
            <div className={styles.warningBox}>
              <i className="fas fa-exclamation-triangle"></i>
              <span>{warningMessage}</span>
            </div>
          )}

          {loading && (
            <div className={styles.progressContainer}>
              <div className={styles.progressBar}>
                <div className={styles.progressFill}></div>
              </div>
              <p className={styles.progressText}>
                Esta operação pode levar alguns minutos. Por favor, não feche esta janela.
              </p>
            </div>
          )}

          {!loading && (
            <div className={styles.infoText}>
              <i className="fas fa-info-circle"></i>
              Esta operação pode demorar alguns minutos para ser concluída.
            </div>
          )}
        </div>

        <div className={styles.modalActions}>
          <button
            type="button"
            onClick={onCancel}
            className={styles.btnCancel}
            disabled={loading}
          >
            {loading ? 'Aguarde...' : 'Cancelar'}
          </button>
          {!loading && (
            <button
              type="button"
              onClick={onConfirm}
              className={styles.btnConfirm}
            >
              <i className="fas fa-download"></i>
              Importar
            </button>
          )}
        </div>
      </div>
    </div>
  );
}