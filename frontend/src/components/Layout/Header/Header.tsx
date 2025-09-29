import React from 'react';
import { useAuth } from '../../../contexts/AuthContext';
import { ThemeToggle } from '../../UI/Common/ThemeToggle';
import Icon from '../../UI/Icon';

interface HeaderProps {
  onToggleSidebar: () => void;
  sidebarAberta: boolean;
}

export function Header({ onToggleSidebar, sidebarAberta }: HeaderProps) {
  const { user, logout } = useAuth();

  const handleLogout = () => {
    if (window.confirm('Tem certeza que deseja sair?')) {
      logout();
    }
  };
  return (
    <header className="
      fixed top-0 left-0 right-0 z-50
      flex items-center justify-between px-6 py-4
      bg-white dark:bg-gray-800
      border-b border-gray-200 dark:border-gray-700
      shadow-sm dark:shadow-gray-900/20
      transition-colors duration-200
    ">
      <div className="flex items-center gap-4">
        <button
          className="
            p-2 rounded-lg transition-all duration-200
            text-gray-600 dark:text-gray-300
            hover:bg-gray-100 dark:hover:bg-gray-700
            hover:text-gray-900 dark:hover:text-white
            focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-opacity-50
          "
          onClick={onToggleSidebar}
          aria-label="Toggle menu"
        >
          <Icon name="bars" size="md" />
        </button>

        <div className="flex items-center gap-3">
          <div className="
            w-10 h-10 rounded-xl bg-gradient-to-br from-blue-600 to-blue-700 dark:from-blue-500 dark:to-blue-600
            flex items-center justify-center shadow-lg
          ">
            <Icon name="truck" color="white" size="md" />
          </div>
          <div>
            <h1 className="text-xl font-bold text-gray-900 dark:text-white">
              MDFe System
            </h1>
            <span className="text-xs text-gray-500 dark:text-gray-400 font-medium">
              Gestão Profissional
            </span>
          </div>
        </div>
      </div>

      <div className="flex items-center gap-4">
        <div className="flex items-center gap-4">
          <ThemeToggle />

          <div className="w-px h-6 bg-gray-300 dark:bg-gray-600"></div>

          <div className="flex items-center gap-3">
            <div className="
              w-8 h-8 rounded-full bg-gradient-to-br from-gray-600 to-gray-700 dark:from-gray-500 dark:to-gray-600
              flex items-center justify-center text-white text-sm font-medium
            ">
              <Icon name="user" size="sm" />
            </div>
            <div className="hidden sm:block">
              <span className="block text-sm font-medium text-gray-900 dark:text-white">
                {user?.nome || 'Usuário'}
              </span>
              <span className="block text-xs text-gray-500 dark:text-gray-400">
                {user?.email || 'Não autenticado'}
              </span>
            </div>
            <button className="
              p-1 rounded-md transition-colors duration-200
              text-gray-400 dark:text-gray-500
              hover:text-gray-600 dark:hover:text-gray-300
            ">
              <Icon name="chevron-down" size="sm" />
            </button>
          </div>
        </div>

        <button
          className="
            flex items-center gap-2 px-4 py-2 rounded-lg transition-all duration-200
            text-red-600 dark:text-red-400
            hover:bg-red-50 dark:hover:bg-red-900/20
            hover:text-red-700 dark:hover:text-red-300
            border border-transparent hover:border-red-200 dark:hover:border-red-800
            focus:outline-none focus:ring-2 focus:ring-red-500 focus:ring-opacity-50
          "
          onClick={handleLogout}
          title="Sair do sistema"
        >
          <Icon name="sign-out-alt" size="sm" />
          <span className="hidden sm:inline text-sm font-medium">Sair</span>
        </button>
      </div>
    </header>
  );
}