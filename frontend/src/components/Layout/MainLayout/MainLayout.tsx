import React, { useState } from 'react';
import { useLocation } from 'react-router-dom';
import { Header } from '../Header/Header';
import { Sidebar } from '../Sidebar/Sidebar';
import { TokenWarning } from '../../Auth/TokenWarning';
import { useTokenMonitor } from '../../../hooks/useTokenMonitor';

interface MainLayoutProps {
  children: React.ReactNode;
}

export function MainLayout({ children }: MainLayoutProps) {
  // Estado baseado no tamanho da tela
  const [sidebarAberta, setSidebarAberta] = useState(false); // Fechada por padrão em mobile
  const [isMobile, setIsMobile] = useState(window.innerWidth < 1024);
  const location = useLocation();

  // Todos os hooks devem estar no topo, antes de qualquer early return
  const { showWarning, tokenTimeRemaining, onContinue, onLogout } = useTokenMonitor();

  // Monitorar mudanças no tamanho da tela
  React.useEffect(() => {
    const handleResize = () => {
      const mobile = window.innerWidth < 1024;
      setIsMobile(mobile);

      // Em desktop, abrir sidebar por padrão; em mobile, fechar
      if (!mobile && !sidebarAberta) {
        setSidebarAberta(true);
      } else if (mobile && sidebarAberta) {
        setSidebarAberta(false);
      }
    };

    window.addEventListener('resize', handleResize);
    handleResize(); // Executar imediatamente

    return () => window.removeEventListener('resize', handleResize);
  }, []);

  // Não mostrar layout para páginas de autenticação
  const isAuthPage = location.pathname.startsWith('/login') || location.pathname.startsWith('/auth');

  if (isAuthPage) {
    return <>{children}</>;
  }

  const toggleSidebar = () => {
    setSidebarAberta(!sidebarAberta);
  };

  return (
    <div className="min-h-screen bg-gray-50 dark:bg-gray-900 transition-colors duration-200">
      {/* Header fixo no topo */}
      <Header
        onToggleSidebar={toggleSidebar}
        sidebarAberta={sidebarAberta}
        isMobile={isMobile}
      />

      {/* Container principal com altura calculada (100vh - altura do header) */}
      <div className="flex h-screen pt-16 sm:pt-20">
        {/* Sidebar */}
        <Sidebar
          aberta={sidebarAberta}
          isMobile={isMobile}
          onClose={() => setSidebarAberta(false)}
        />

        {/* Overlay para mobile quando sidebar está aberta */}
        {isMobile && sidebarAberta && (
          <div
            className="fixed inset-0 bg-black bg-opacity-50 z-30 lg:hidden"
            onClick={() => setSidebarAberta(false)}
          />
        )}

        {/* Área de conteúdo principal - usa o espaço restante */}
        <main className={`
          flex-1 overflow-auto transition-all duration-300 ease-in-out
          ${!isMobile ? (sidebarAberta ? 'lg:ml-64' : 'lg:ml-16') : 'ml-0'}
          bg-gray-50 dark:bg-gray-900
        `}>
          <div className="p-2 sm:p-4 h-full">
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