import React from 'react';
import Icon from '../Icon';

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
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50 backdrop-blur-sm" onClick={onCancel}>
      <div className="bg-bg-surface rounded-xl border border-border-primary shadow-xl max-w-md w-full mx-4 overflow-hidden" onClick={(e) => e.stopPropagation()}>
        <div className="flex items-center gap-4 p-6 border-b border-border-primary">
          <div className="w-12 h-12 rounded-full bg-danger-light flex items-center justify-center">
            <Icon name="exclamation-triangle" className="text-danger" size="lg" />
          </div>
          <h2 className="text-xl font-semibold text-text-primary">{title}</h2>
        </div>

        <div className="p-6 space-y-4">
          <p className="text-text-secondary">{message}</p>
          {itemName && (
            <div className="p-3 rounded-lg bg-bg-surface-hover border border-border-primary">
              <strong className="text-text-primary">{itemName}</strong>
            </div>
          )}
          <div className="flex items-center gap-2 p-3 rounded-lg bg-danger-light border border-danger/20">
            <Icon name="info-circle" className="text-danger" size="sm" />
            <span className="text-sm text-danger font-medium">Esta ação não pode ser desfeita.</span>
          </div>
        </div>

        <div className="flex items-center justify-end gap-3 p-6 border-t border-border-primary bg-bg-surface-hover">
          <button
            type="button"
            onClick={onCancel}
            className="px-4 py-2 text-text-secondary border border-border-primary rounded-lg hover:bg-bg-surface hover:text-text-primary transition-colors duration-200 font-medium"
            disabled={loading}
          >
            Cancelar
          </button>
          <button
            type="button"
            onClick={onConfirm}
            className="flex items-center gap-2 px-4 py-2 bg-danger hover:bg-danger-dark text-white rounded-lg disabled:opacity-50 disabled:cursor-not-allowed transition-colors duration-200 font-medium"
            disabled={loading}
          >
            {loading ? (
              <>
                <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-white"></div>
                Excluindo...
              </>
            ) : (
              <>
                <Icon name="trash" size="sm" />
                Excluir
              </>
            )}
          </button>
        </div>
      </div>
    </div>
  );
}