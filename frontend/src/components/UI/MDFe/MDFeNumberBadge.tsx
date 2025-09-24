import React from 'react';
import styles from './MDFeNumberBadge.module.css';

interface MDFeNumberBadgeProps {
  numero: string | number;
  serie: string | number;
  size?: 'small' | 'medium' | 'large';
  variant?: 'primary' | 'secondary' | 'minimal';
  className?: string;
}

export function MDFeNumberBadge({
  numero,
  serie,
  size = 'medium',
  variant = 'primary',
  className = ''
}: MDFeNumberBadgeProps) {
  return (
    <div className={`${styles.mdfeNumberBadge} ${styles[size]} ${styles[variant]} ${className}`}>
      <div className={styles.badgeContent}>
        <div className={styles.mdfeNumber}>
          MDFe Nº {numero}
        </div>
        <div className={styles.mdfeSerieLabel}>
          Série {serie}
        </div>
      </div>
    </div>
  );
}