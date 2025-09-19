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
        <h1 className={styles.title}>MDFe System</h1>
      </div>

      <div className={styles.headerRight}>
        <ThemeToggle />
        <div className={styles.userInfo}>
          <span className={styles.userName}>Sistema MDFe</span>
          <span className={styles.userRole}>Administrador</span>
        </div>
        <button className={styles.logoutBtn}>
          Sair
        </button>
      </div>
    </header>
  );
}