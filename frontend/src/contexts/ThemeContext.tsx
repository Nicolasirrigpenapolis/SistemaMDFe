import React, { createContext, useContext, useEffect, useState, ReactNode } from 'react';
import { Theme as MuiTheme } from '@mui/material/styles';
import { getTheme } from '../theme/muiTheme';

type ThemeMode = 'light' | 'dark';

interface ThemeContextType {
  themeMode: ThemeMode;
  theme: MuiTheme;
  toggleTheme: () => void;
  isDark: boolean;
}

const ThemeContext = createContext<ThemeContextType | undefined>(undefined);

export function useTheme() {
  const context = useContext(ThemeContext);
  if (context === undefined) {
    throw new Error('useTheme must be used within a ThemeProvider');
  }
  return context;
}

export function useThemeMode() {
  const { themeMode } = useTheme();
  return themeMode;
}

export function useIsDark() {
  const { isDark } = useTheme();
  return isDark;
}

interface ThemeProviderProps {
  children: ReactNode;
}

export function ThemeProvider({ children }: ThemeProviderProps) {
  const [themeMode, setThemeMode] = useState<ThemeMode>('light');
  const [theme, setTheme] = useState(getTheme('light'));

  const isDark = themeMode === 'dark';

  const applyTheme = (mode: ThemeMode) => {
    // Atualizar documento para Tailwind
    if (mode === 'dark') {
      document.documentElement.classList.add('dark');
      document.body.classList.add('dark');
    } else {
      document.documentElement.classList.remove('dark');
      document.body.classList.remove('dark');
    }

    // Atualizar atributo data-theme para CSS custom
    document.documentElement.setAttribute('data-theme', mode);

    // Atualizar variáveis CSS customizadas para compatibility
    document.documentElement.style.setProperty('--theme-mode', mode);
  };

  useEffect(() => {
    // Verificar tema salvo ou preferência do sistema
    const savedTheme = localStorage.getItem('mdfe-theme') as ThemeMode;
    const systemPrefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;

    const initialTheme = savedTheme || (systemPrefersDark ? 'dark' : 'light');
    setThemeMode(initialTheme);
    setTheme(getTheme(initialTheme));
    applyTheme(initialTheme);
  }, []);

  const toggleTheme = () => {
    const newTheme = themeMode === 'light' ? 'dark' : 'light';
    setThemeMode(newTheme);
    setTheme(getTheme(newTheme));
    applyTheme(newTheme);

    // Salvar preferência
    localStorage.setItem('mdfe-theme', newTheme);
  };

  return (
    <ThemeContext.Provider value={{ themeMode, theme, toggleTheme, isDark }}>
      {children}
    </ThemeContext.Provider>
  );
}