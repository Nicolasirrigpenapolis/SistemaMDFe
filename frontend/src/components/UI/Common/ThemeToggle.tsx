import React from 'react';
import Icon from '../Icon';
import { useTheme } from '../../../contexts/ThemeContext';

export function ThemeToggle() {
  const { theme, toggleTheme } = useTheme();

  return (
    <button
      onClick={toggleTheme}
      className="btn btn-secondary btn-sm"
      title={`Alternar para tema ${theme === 'light' ? 'escuro' : 'claro'}`}
      style={{
        padding: 'var(--space-2)',
        minWidth: 'auto',
        aspectRatio: '1',
        fontSize: '1rem'
      }}
    >
      <Icon name={theme === 'light' ? 'moon' : 'sun'} />
    </button>
  );
}