import { useState } from 'react';
import { useLocation } from 'react-router-dom';
import { Header } from '../Header/Header';
import { Sidebar } from '../Sidebar/Sidebar';
import { TokenWarning } from '../../Auth/TokenWarning';
import { useTokenMonitor } from '../../../hooks/useTokenMonitor';

interface MainLayoutProps {
  children: React.ReactNode;
}

export function MainLayout({ children }: MainLayoutProps) {
  const [sidebarAberta, setSidebarAberta] = useState(true);
  const location = useLocation();
  const { showWarning, tokenTimeRemaining, onContinue, onLogout } = useTokenMonitor();

  // Não mostrar layout para páginas de autenticação
  const isAuthPage = location.pathname.startsWith('/login') || location.pathname.startsWith('/auth');

  if (isAuthPage) {
    return <>{children}</>;
  }

  return (
    <div className="min-h-screen bg-gray-50 dark:bg-gray-900 transition-colors duration-200">
      <Header
        onToggleSidebar={() => setSidebarAberta(!sidebarAberta)}
        sidebarAberta={sidebarAberta}
      />

      <div className="flex">
        <Sidebar aberta={sidebarAberta} />

        <main className={`
          flex-1 transition-all duration-300 ease-in-out
          ${sidebarAberta ? 'ml-64' : 'ml-16'}
          pt-20 p-6
          min-h-screen
          bg-gray-50 dark:bg-gray-900
        `}>
          <div className="max-w-7xl mx-auto">
            {children}
          </div>
        </main>
      </div>

      {/* Modal de aviso sobre expiração do token */}
      <TokenWarning
        isVisible={showWarning}
        timeRemaining={tokenTimeRemaining}
        onContinue={onContinue}
        onLogout={onLogout}
      />
    </div>
  );
}