import React from 'react';
import { ErrorMessageHelper } from '../../../utils/errorMessages';
import Icon from '../Icon';
import './ErrorDisplay.css';

interface ErrorDisplayProps {
  error?: string | any;
  errors?: Record<string, string[]>;
  className?: string;
  type?: 'inline' | 'block' | 'toast';
  onClose?: () => void;
}

export const ErrorDisplay: React.FC<ErrorDisplayProps> = ({
  error,
  errors,
  className = '',
  type = 'block',
  onClose
}) => {
  if (!error && (!errors || Object.keys(errors).length === 0)) {
    return null;
  }

  const getErrorMessage = (): string => {
    if (error) {
      if (typeof error === 'string') {
        return error;
      }
      return ErrorMessageHelper.processApiResponse(error);
    }

    if (errors) {
      const validationErrors = ErrorMessageHelper.processValidationErrors(errors);
      return ErrorMessageHelper.formatValidationErrors(validationErrors);
    }

    return 'Ocorreu um erro inesperado.';
  };

  const getValidationErrors = () => {
    if (errors) {
      return ErrorMessageHelper.processValidationErrors(errors);
    }
    return [];
  };

  const errorMessage = getErrorMessage();
  const validationErrors = getValidationErrors();
  const hasMultipleErrors = validationErrors.length > 1;

  const baseClassName = `error-display error-display--${type} ${className}`;

  return (
    <div className={baseClassName} role="alert">
      {onClose && (
        <button
          className="error-display__close"
          onClick={onClose}
          aria-label="Fechar erro"
        >
          ×
        </button>
      )}

      <div className="error-display__icon">
        <Icon name="exclamation-triangle" color="#dc3545" />
      </div>

      <div className="error-display__content">
        {hasMultipleErrors ? (
          <div>
            <div className="error-display__title">
              Foram encontrados erros de validação:
            </div>
            <ul className="error-display__list">
              {validationErrors.map((err, index) => (
                <li key={index} className="error-display__item">
                  <strong>{err.field}:</strong> {err.message}
                </li>
              ))}
            </ul>
          </div>
        ) : (
          <div className="error-display__message">
            {errorMessage}
          </div>
        )}
      </div>
    </div>
  );
};

interface FieldErrorProps {
  error?: string;
  field?: string;
}

export const FieldError: React.FC<FieldErrorProps> = ({ error, field }) => {
  if (!error) return null;

  const friendlyField = field ? ErrorMessageHelper.translateFieldName(field) : '';
  const message = field ? `${friendlyField}: ${error}` : error;

  return (
    <div className="field-error" role="alert">
      <span className="field-error__message">{message}</span>
    </div>
  );
};

interface ToastErrorProps {
  error?: string | any;
  isVisible: boolean;
  onClose: () => void;
  duration?: number;
}

export const ToastError: React.FC<ToastErrorProps> = ({
  error,
  isVisible,
  onClose,
  duration = 5000
}) => {
  React.useEffect(() => {
    if (isVisible && duration > 0) {
      const timer = setTimeout(() => {
        onClose();
      }, duration);

      return () => clearTimeout(timer);
    }
  }, [isVisible, duration, onClose]);

  if (!isVisible || !error) {
    return null;
  }

  const message = typeof error === 'string' ? error : ErrorMessageHelper.processApiResponse(error);

  return (
    <div className="toast-error">
      <div className="toast-error__content">
        <span className="toast-error__icon">
          <Icon name="exclamation-triangle" color="#dc3545" />
        </span>
        <span className="toast-error__message">{message}</span>
        <button
          className="toast-error__close"
          onClick={onClose}
          aria-label="Fechar"
        >
          ×
        </button>
      </div>
    </div>
  );
};