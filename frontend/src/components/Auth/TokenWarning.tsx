import React from 'react';

interface TokenWarningProps {
  isVisible: boolean;
  timeRemaining: number;
  onContinue: () => void;
  onLogout: () => void;
}

/**
 * 🔔 Modal de aviso sobre expiração do token
 */
export function TokenWarning({ isVisible, timeRemaining, onContinue, onLogout }: TokenWarningProps) {
  if (!isVisible) return null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50">
      <div className="bg-white dark:bg-gray-800 rounded-lg shadow-xl max-w-md w-full mx-4 p-6">
        <div className="flex items-center mb-4">
          <div className="w-12 h-12 bg-yellow-100 dark:bg-yellow-900/30 rounded-full flex items-center justify-center mr-4">
            <i className="fas fa-exclamation-triangle text-yellow-600 dark:text-yellow-400 text-xl"></i>
          </div>
          <div>
            <h3 className="text-lg font-semibold text-gray-900 dark:text-white">
              Sessão Expirando
            </h3>
            <p className="text-sm text-gray-600 dark:text-gray-400">
              Sua sessão expirará em {timeRemaining} minuto{timeRemaining !== 1 ? 's' : ''}
            </p>
          </div>
        </div>

        <p className="text-gray-700 dark:text-gray-300 mb-6">
          Por motivos de segurança, sua sessão será encerrada automaticamente.
          Deseja continuar trabalhando ou fazer logout?
        </p>

        <div className="flex gap-3 justify-end">
          <button
            onClick={onLogout}
            className="px-4 py-2 text-sm font-medium text-gray-700 dark:text-gray-300 bg-gray-100 dark:bg-gray-700 hover:bg-gray-200 dark:hover:bg-gray-600 rounded-lg transition-colors"
          >
            Fazer Logout
          </button>
          <button
            onClick={onContinue}
            className="px-4 py-2 text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 rounded-lg transition-colors"
          >
            Continuar Sessão
          </button>
        </div>
      </div>
    </div>
  );
}