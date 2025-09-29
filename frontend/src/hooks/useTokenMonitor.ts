import { useEffect, useState } from 'react';
import { useAuth } from '../contexts/AuthContext';

/**
 * 🔔 Hook para monitorar status do token e avisar sobre expiração
 */
export function useTokenMonitor() {
  const { tokenTimeRemaining, shouldRefreshToken, logout } = useAuth();
  const [showWarning, setShowWarning] = useState(false);
  const [warningShown, setWarningShown] = useState(false);

  useEffect(() => {
    // Reset warning quando o token é renovado
    if (tokenTimeRemaining > 5) {
      setWarningShown(false);
      setShowWarning(false);
    }

    // Mostrar aviso quando token está próximo do vencimento
    if (shouldRefreshToken && tokenTimeRemaining <= 5 && tokenTimeRemaining > 0 && !warningShown) {
      setShowWarning(true);
      setWarningShown(true);
    }

    // Auto-logout quando token expira
    if (tokenTimeRemaining <= 0) {
      logout();
    }
  }, [tokenTimeRemaining, shouldRefreshToken, logout, warningShown]);

  const handleContinueSession = () => {
    setShowWarning(false);
    // Aqui poderia implementar refresh automático do token se necessário
  };

  const handleLogout = () => {
    setShowWarning(false);
    logout();
  };

  return {
    showWarning,
    tokenTimeRemaining,
    onContinue: handleContinueSession,
    onLogout: handleLogout
  };
}