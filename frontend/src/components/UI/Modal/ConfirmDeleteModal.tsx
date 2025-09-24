import React from 'react';
import styles from './ConfirmDeleteModal.module.css';

interface ConfirmDeleteModalProps {
  isOpen: boolean;
  title: string;
  message: string;
  itemName?: string;
  onConfirm: () => void;
  onCancel: () => void;
  loading?: boolean;
}

export function ConfirmDeleteModal({
  isOpen,
  title,
  message,
  itemName,
  onConfirm,
  onCancel,
  loading = false
}: ConfirmDeleteModalProps) {
  if (!isOpen) return null;

  return (
    <div className={styles.modalOverlay} onClick={onCancel}>
      <div className={styles.modal} onClick={(e) => e.stopPropagation()}>
        <div className={styles.modalHeader}>
          <div className={styles.iconContainer}>
            <i className="fas fa-exclamation-triangle"></i>
          </div>
          <h2>{title}</h2>
        </div>

        <div className={styles.modalBody}>
          <p>{message}</p>
          {itemName && (
            <div className={styles.itemHighlight}>
              <strong>{itemName}</strong>
            </div>
          )}
          <div className={styles.warningText}>
            <i className="fas fa-info-circle"></i>
            Esta ação não pode ser desfeita.
          </div>
        </div>

        <div className={styles.modalActions}>
          <button
            type="button"
            onClick={onCancel}
            className={styles.btnCancel}
            disabled={loading}
          >
            Cancelar
          </button>
          <button
            type="button"
            onClick={onConfirm}
            className={styles.btnConfirm}
            disabled={loading}
          >
            {loading ? (
              <>
                <i className="fas fa-spinner fa-spin"></i>
                Excluindo...
              </>
            ) : (
              <>
                <i className="fas fa-trash"></i>
                Excluir
              </>
            )}
          </button>
        </div>
      </div>
    </div>
  );
}