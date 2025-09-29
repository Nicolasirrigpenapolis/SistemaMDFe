import React from 'react';
import { useNavigate, useLocation } from 'react-router-dom';
import Icon from '../../UI/Icon';

interface SidebarProps {
  aberta: boolean;
}

interface MenuItem {
  id: string;
  path: string;
  label: string;
  icon: string;
}

export function Sidebar({ aberta }: SidebarProps) {
  const navigate = useNavigate();
  const location = useLocation();

  const menuItems: MenuItem[] = [
    {
      id: 'dashboard',
      path: '/dashboard',
      label: 'Dashboard',
      icon: 'chart-bar'
    },
    {
      id: 'mdfes',
      path: '/mdfes',
      label: 'MDFes',
      icon: 'file-alt'
    },
    {
      id: 'emitentes',
      path: '/emitentes',
      label: 'Emitentes',
      icon: 'building'
    },
    {
      id: 'veiculos',
      path: '/veiculos',
      label: 'Veículos',
      icon: 'truck'
    },
    {
      id: 'reboques',
      path: '/reboques',
      label: 'Reboques',
      icon: 'trailer'
    },
    {
      id: 'condutores',
      path: '/condutores',
      label: 'Condutores',
      icon: 'user'
    },
    {
      id: 'contratantes',
      path: '/contratantes',
      label: 'Contratantes',
      icon: 'handshake'
    },
    {
      id: 'seguradoras',
      path: '/seguradoras',
      label: 'Seguradoras',
      icon: 'shield-alt'
    },
    {
      id: 'municipios',
      path: '/municipios',
      label: 'Municípios',
      icon: 'map-marker-alt'
    },
    {
      id: 'usuarios',
      path: '/admin/usuarios',
      label: 'Usuários',
      icon: 'users'
    }
  ];

  const isActive = (path: string) => {
    return location.pathname === path || location.pathname.startsWith(path + '/');
  };

  return (
    <aside className={`
      ${aberta ? 'w-64' : 'w-16'}
      transition-all duration-300 ease-in-out
      bg-white dark:bg-gray-900
      border-r border-gray-200 dark:border-gray-700
      shadow-lg dark:shadow-gray-900/50
      flex flex-col
      min-h-screen fixed top-20 left-0 z-40
      transform ${aberta ? 'translate-x-0' : 'translate-x-0'}
    `}>
      <div className="flex-1 flex flex-col p-2 pt-4">
        <nav className="flex-1">
          <ul className="space-y-1">
            {menuItems.map((item) => {
              const active = isActive(item.path);
              return (
                <li key={item.id}>
                  <button
                    className={`
                      w-full flex items-center gap-3 px-3 py-3 rounded-xl
                      transition-all duration-200 ease-in-out group
                      ${active
                        ? 'bg-blue-50 dark:bg-blue-900/30 text-blue-700 dark:text-blue-300 shadow-sm'
                        : 'text-gray-700 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-800 hover:text-gray-900 dark:hover:text-white'
                      }
                      focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-opacity-50
                      ${!aberta ? 'justify-center' : ''}
                    `}
                    onClick={() => navigate(item.path)}
                    title={!aberta ? item.label : undefined}
                  >
                    <span className={`
                      flex-shrink-0 transition-colors duration-200
                      ${active
                        ? 'text-blue-600 dark:text-blue-400'
                        : 'text-gray-500 dark:text-gray-400 group-hover:text-gray-700 dark:group-hover:text-gray-200'
                      }
                    `}>
                      <Icon name={item.icon} size="md" />
                    </span>

                    {aberta && (
                      <span className={`
                        font-medium transition-colors duration-200 truncate
                        ${active
                          ? 'text-blue-700 dark:text-blue-300'
                          : 'text-gray-700 dark:text-gray-300 group-hover:text-gray-900 dark:group-hover:text-white'
                        }
                      `}>
                        {item.label}
                      </span>
                    )}

                    {active && (
                      <div className="absolute left-0 top-0 bottom-0 w-1 bg-blue-600 dark:bg-blue-400 rounded-r-full"></div>
                    )}
                  </button>
                </li>
              );
            })}
          </ul>
        </nav>

        {aberta && (
          <div className="mt-6 pt-4 border-t border-gray-200 dark:border-gray-700">
            <div className="px-3 py-2 text-center">
              <span className="block text-xs font-medium text-gray-500 dark:text-gray-400">
                Versão
              </span>
              <span className="block text-sm font-semibold text-gray-700 dark:text-gray-300">
                1.0.0
              </span>
            </div>
          </div>
        )}
      </div>
    </aside>
  );
}