import React from 'react';
import { useNavigate, useLocation } from 'react-router-dom';
import { usePermissionContext } from '../../../contexts/PermissionContext';
import Icon from '../../UI/Icon';

interface SidebarProps {
  aberta: boolean;
  isMobile?: boolean;
  onClose?: () => void;
}

interface MenuItem {
  id: string;
  path: string;
  label: string;
  icon: string;
  permission?: string;
}

export function Sidebar({ aberta, isMobile, onClose }: SidebarProps) {
  const navigate = useNavigate();
  const location = useLocation();
  const { hasPermission, loading } = usePermissionContext();

  const handleNavigate = (path: string) => {
    navigate(path);
    // Fechar sidebar em mobile após navegação
    if (isMobile && onClose) {
      onClose();
    }
  };

  const menuItems: MenuItem[] = [
    {
      id: 'dashboard',
      path: '/dashboard',
      label: 'Dashboard',
      icon: 'chart-bar',
      permission: 'dashboard.view'
    },
    {
      id: 'mdfes',
      path: '/mdfes',
      label: 'MDFes',
      icon: 'file-alt',
      permission: 'mdfe.read'
    },
    {
      id: 'emitentes',
      path: '/emitentes',
      label: 'Emitentes',
      icon: 'building',
      permission: 'emitentes.read'
    },
    {
      id: 'veiculos',
      path: '/veiculos',
      label: 'Veículos',
      icon: 'truck',
      permission: 'veiculos.read'
    },
    {
      id: 'reboques',
      path: '/reboques',
      label: 'Reboques',
      icon: 'trailer',
      permission: 'reboques.read'
    },
    {
      id: 'condutores',
      path: '/condutores',
      label: 'Condutores',
      icon: 'user',
      permission: 'condutores.read'
    },
    {
      id: 'contratantes',
      path: '/contratantes',
      label: 'Contratantes',
      icon: 'handshake',
      permission: 'contratantes.read'
    },
    {
      id: 'seguradoras',
      path: '/seguradoras',
      label: 'Seguradoras',
      icon: 'shield-alt',
      permission: 'seguradoras.read'
    },
    {
      id: 'municipios',
      path: '/municipios',
      label: 'Municípios',
      icon: 'map-marker-alt',
      permission: 'municipios.read'
    },
    {
      id: 'usuarios',
      path: '/admin/usuarios',
      label: 'Usuários',
      icon: 'users',
      permission: 'admin.users.read'
    },
    {
      id: 'cargos',
      path: '/admin/cargos',
      label: 'Cargos',
      icon: 'user-cog',
      permission: 'admin.roles.read'
    }
  ];

  const isActive = (path: string) => {
    return location.pathname === path || location.pathname.startsWith(path + '/');
  };

  // Filtrar itens do menu baseado nas permissões do usuário
  const availableMenuItems = menuItems.filter(item => {
    // Se não tem permissão definida, mostrar sempre (para itens públicos)
    if (!item.permission) return true;

    // Se ainda está carregando permissões, mostrar todos os itens (para evitar flicker)
    if (loading) {
      console.log(`Sidebar: Permissions loading, showing '${item.label}' temporarily`);
      return true;
    }

    // Verificar se o usuário tem a permissão necessária
    const hasAccess = hasPermission(item.permission);
    console.log(`Sidebar: Checking permission '${item.permission}' for '${item.label}': ${hasAccess}`);
    return hasAccess;
  });

  console.log(`Sidebar: Loading: ${loading}, Total menu items: ${menuItems.length}, Available items: ${availableMenuItems.length}`);

  return (
    <aside className={`
      ${isMobile
        ? `fixed top-0 left-0 h-full z-40 transform transition-transform duration-300 ease-in-out
           ${aberta ? 'translate-x-0' : '-translate-x-full'}
           w-64 pt-16 sm:pt-20`
        : `${aberta ? 'w-64' : 'w-16'} transition-all duration-300 ease-in-out
           min-h-full fixed top-16 sm:top-20 left-0 z-40`
      }
      bg-card dark:bg-gray-900
      border-r border-gray-200 dark:border-0
      shadow-lg dark:shadow-gray-900/50
      flex flex-col
    `}>
      <div className="flex-1 flex flex-col p-2 pt-4">
        <nav className="flex-1">
          <ul className="space-y-1">
            {availableMenuItems.map((item) => {
              const active = isActive(item.path);
              return (
                <li key={item.id}>
                  <button
                    className={`
                      w-full flex items-center gap-3 px-3 py-2.5 rounded-lg
                      transition-all duration-200 ease-in-out group relative
                      ${active
                        ? 'bg-blue-50 dark:bg-blue-900/30 text-blue-700 dark:text-blue-300'
                        : 'text-gray-700 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-800'
                      }
                      ${!aberta ? 'justify-center' : ''}
                    `}
                    onClick={() => handleNavigate(item.path)}
                    title={!aberta && !isMobile ? item.label : undefined}
                  >
                    <span className={`flex-shrink-0`}>
                      <Icon name={item.icon} size="md" />
                    </span>

                    {(aberta || isMobile) && (
                      <span className="font-medium truncate">
                        {item.label}
                      </span>
                    )}

                    {active && (
                      <div className="absolute left-0 top-0 bottom-0 w-1 bg-blue-600 dark:bg-blue-400 rounded-r"></div>
                    )}
                  </button>
                </li>
              );
            })}
          </ul>
        </nav>

        {(aberta || isMobile) && (
          <div className="mt-6 pt-4 border-t border-gray-200 dark:border-0">
            <div className="px-3 py-2 text-center">
              <span className="block text-xs font-medium text-gray-500 dark:text-gray-400">
                Versão
              </span>
              <span className="block text-sm font-semibold text-foreground">
                1.0.0
              </span>
            </div>
          </div>
        )}
      </div>
    </aside>
  );
}