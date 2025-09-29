import React from 'react';
import { MDFeNumberBadge } from '../MDFe/MDFeNumberBadge';
import Icon from '../Icon';

interface MDFe {
  id: number;
  numero: string;
  serie: string;
  dataEmissao: string;
  ufIni: string;
  ufFim: string;
  valorTotal: number;
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
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50 backdrop-blur-sm" onClick={onClose}>
      <div className="bg-bg-surface rounded-xl border border-border-primary shadow-xl max-w-4xl w-full mx-4 max-h-[90vh] overflow-hidden" onClick={(e) => e.stopPropagation()}>
        <div className="p-6 border-b border-border-primary">
          <div className="flex items-center justify-between mb-4">
            <MDFeNumberBadge
              numero={mdfe.numero}
              serie={mdfe.serie}
              size="large"
              variant="primary"
            />
            <button
              className="p-2 rounded-lg text-text-tertiary hover:text-text-primary hover:bg-bg-surface-hover transition-colors duration-200"
              onClick={onClose}
            >
              <Icon name="times" size="lg" />
            </button>
          </div>

          <div className="flex items-center gap-4">
            <div
              className="flex items-center gap-2 px-3 py-1 rounded-full text-sm font-medium"
              style={{
                backgroundColor: statusConfig.bgColor,
                color: statusConfig.textColor
              }}
            >
              <div className="w-2 h-2 rounded-full bg-current"></div>
              <span>{mdfe.status}</span>
            </div>
            <div className="flex items-center gap-2 text-text-secondary">
              <Icon name="calendar-alt" size="sm" />
              <span>{formatDate(mdfe.dataEmissao)}</span>
            </div>
          </div>
        </div>

        <div className="p-6 max-h-[60vh] overflow-y-auto">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
            <div className="bg-bg-surface-hover rounded-lg border border-border-primary p-4">
              <div className="flex items-center gap-3 mb-3">
                <Icon name="building" className="text-primary" size="sm" />
                <h3 className="font-semibold text-text-primary">Emitente</h3>
              </div>
              <p className="text-text-secondary">{mdfe.emitenteNome || 'N/A'}</p>
            </div>

            <div className="bg-bg-surface-hover rounded-lg border border-border-primary p-4">
              <div className="flex items-center gap-3 mb-3">
                <Icon name="truck" className="text-primary" size="sm" />
                <h3 className="font-semibold text-text-primary">Veículo</h3>
              </div>
              <p className="text-text-secondary">{mdfe.veiculoPlaca || 'N/A'}</p>
            </div>

            <div className="bg-bg-surface-hover rounded-lg border border-border-primary p-4">
              <div className="flex items-center gap-3 mb-3">
                <Icon name="route" className="text-primary" size="sm" />
                <h3 className="font-semibold text-text-primary">Percurso</h3>
              </div>
              <p className="text-text-secondary">{mdfe.ufIni} → {mdfe.ufFim}</p>
            </div>

            <div className="bg-bg-surface-hover rounded-lg border border-border-primary p-4">
              <div className="flex items-center gap-3 mb-3">
                <Icon name="dollar-sign" className="text-primary" size="sm" />
                <h3 className="font-semibold text-text-primary">Valor da Carga</h3>
              </div>
              <p className="text-xl font-bold text-success">{formatCurrency(mdfe.valorTotal)}</p>
            </div>
          </div>

          {mdfe.chave && (
            <div className="bg-bg-surface-hover rounded-lg border border-border-primary p-4">
              <h4 className="flex items-center gap-3 font-semibold text-text-primary mb-3">
                <Icon name="key" className="text-primary" size="sm" />
                Chave de Acesso
              </h4>
              <div className="flex items-center gap-2 p-3 bg-bg-surface rounded-lg border border-border-primary">
                <code className="flex-1 text-sm font-mono text-text-secondary break-all">{mdfe.chave}</code>
                <button
                  className="p-2 text-text-tertiary hover:text-primary hover:bg-bg-surface-hover rounded-lg transition-colors duration-200"
                  onClick={() => navigator.clipboard.writeText(mdfe.chave)}
                  title="Copiar chave"
                >
                  <Icon name="copy" size="sm" />
                </button>
              </div>
            </div>
          )}
        </div>

        <div className="flex items-center justify-end gap-3 p-6 border-t border-border-primary bg-bg-surface-hover">
          <button className="flex items-center gap-2 px-4 py-2 text-text-secondary border border-border-primary rounded-lg hover:bg-bg-surface hover:text-text-primary transition-colors duration-200 font-medium">
            <Icon name="download" size="sm" />
            <span>Download XML</span>
          </button>
          <button className="flex items-center gap-2 px-4 py-2 text-text-secondary border border-border-primary rounded-lg hover:bg-bg-surface hover:text-text-primary transition-colors duration-200 font-medium">
            <Icon name="print" size="sm" />
            <span>Imprimir</span>
          </button>
          {mdfe.status !== 'Cancelado' && (
            <button className="flex items-center gap-2 px-4 py-2 bg-danger hover:bg-danger-dark text-white rounded-lg transition-colors duration-200 font-medium">
              <Icon name="times" size="sm" />
              <span>Cancelar</span>
            </button>
          )}
        </div>
      </div>
    </div>
  );
}