import React from 'react';
import { ThemeToggle } from '../../UI/Common/ThemeToggle';
import Icon from '../../UI/Icon';
import styles from './Header.module.css';

interface HeaderProps {
  onToggleSidebar: () => void;
  sidebarAberta: boolean;
}

export function Header({ onToggleSidebar, sidebarAberta }: HeaderProps) {
  return (
    <header className={styles.header}>
      <div className={styles.headerLeft}>
        <button
          className={styles.menuToggle}
          onClick={onToggleSidebar}
          aria-label="Toggle menu"
        >
          <Icon name="bars" />
        </button>

        <div className={styles.logoSection}>
          <div className={styles.logoText}>
            <h1 className={styles.title}>MDFe System</h1>
            <span className={styles.subtitle}>Gestão Profissional</span>
          </div>
        </div>
      </div>

      <div className={styles.headerRight}>
        <div className={styles.userSection}>
          <ThemeToggle />
          <div className={styles.divider}></div>
          <div className={styles.userAvatar}>
            <i className="fas fa-user"></i>
          </div>
          <div className={styles.userInfo}>
            <span className={styles.userName}>Sistema MDFe</span>
            <span className={styles.userRole}>Administrador</span>
          </div>
          <button className={styles.userDropdown}>
            <i className="fas fa-chevron-down"></i>
          </button>
        </div>

        <button className={styles.logoutBtn}>
          <i className="fas fa-sign-out-alt"></i>
          <span>Sair</span>
        </button>
      </div>
    </header>
  );
}