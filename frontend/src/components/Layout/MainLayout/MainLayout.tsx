import { useState } from 'react';
import { Header } from '../Header/Header';
import { Sidebar } from '../Sidebar/Sidebar';
import styles from './MainLayout.module.css';

interface MainLayoutProps {
  children: React.ReactNode;
}

export function MainLayout({ children }: MainLayoutProps) {
  const [sidebarAberta, setSidebarAberta] = useState(true);

  return (
    <div className={styles.mainLayout}>
      <Header
        onToggleSidebar={() => setSidebarAberta(!sidebarAberta)}
        sidebarAberta={sidebarAberta}
      />

      <div className={styles.content}>
        <Sidebar aberta={sidebarAberta} />

        <main className={`${styles.main} ${!sidebarAberta ? styles.sidebarFechada : ''}`}>
          {children}
        </main>
      </div>
    </div>
  );
}