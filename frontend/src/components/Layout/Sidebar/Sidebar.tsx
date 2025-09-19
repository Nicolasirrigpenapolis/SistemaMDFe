import React from 'react';
import { useNavigate, useLocation } from 'react-router-dom';
import styles from './Sidebar.module.css';

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
      icon: '📊'
    },
    {
      id: 'mdfes',
      path: '/mdfes',
      label: 'MDFes',
      icon: '📋'
    },
    {
      id: 'emitentes',
      path: '/emitentes',
      label: 'Emitentes',
      icon: '🏢'
    },
    {
      id: 'veiculos',
      path: '/veiculos',
      label: 'Veículos',
      icon: '🚛'
    },
    {
      id: 'condutores',
      path: '/condutores',
      label: 'Condutores',
      icon: '👤'
    },
    {
      id: 'contratantes',
      path: '/contratantes',
      label: 'Contratantes',
      icon: '🤝'
    },
    {
      id: 'seguradoras',
      path: '/seguradoras',
      label: 'Seguradoras',
      icon: '🛡️'
    },
    {
      id: 'municipios',
      path: '/municipios',
      label: 'Municípios',
      icon: '🌍'
    }
  ];

  const isActive = (path: string) => {
    return location.pathname === path || location.pathname.startsWith(path + '/');
  };

  return (
    <aside className={`${styles.sidebar} ${aberta ? styles.aberta : styles.fechada}`}>
      <div className={styles.sidebarContent}>
        <nav className={styles.nav}>
          <ul className={styles.navList}>
            {menuItems.map((item) => (
              <li key={item.id} className={styles.navItem}>
                <button
                  className={`${styles.navButton} ${isActive(item.path) ? styles.active : ''}`}
                  onClick={() => navigate(item.path)}
                  title={!aberta ? item.label : undefined}
                >
                  <span className={styles.navIcon}>
                    {item.icon}
                  </span>
                  <span className={styles.navLabel}>
                    {item.label}
                  </span>
                </button>
              </li>
            ))}
          </ul>
        </nav>

        {aberta && (
          <div className={styles.sidebarFooter}>
            <div className={styles.version}>
              <span className={styles.versionLabel}>Versão</span>
              <span className={styles.versionNumber}>1.0.0</span>
            </div>
          </div>
        )}
      </div>
    </aside>
  );
}