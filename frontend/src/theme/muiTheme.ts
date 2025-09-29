import { createTheme, ThemeOptions } from '@mui/material/styles';

// Função para criar tema baseado no modo
const createMDFeTheme = (mode: 'light' | 'dark'): ThemeOptions => ({
  palette: {
    mode,
    primary: {
      main: '#2196f3', // Azul principal
      light: '#64b5f6',
      dark: '#1976d2',
      contrastText: '#ffffff',
    },
    secondary: {
      main: '#f50057', // Rosa/magenta
      light: '#ff5983',
      dark: '#c51162',
      contrastText: '#ffffff',
    },
    success: {
      main: '#4caf50',
      light: '#81c784',
      dark: '#388e3c',
    },
    warning: {
      main: '#ff9800',
      light: '#ffb74d',
      dark: '#f57c00',
    },
    error: {
      main: '#f44336',
      light: '#e57373',
      dark: '#d32f2f',
    },
    info: {
      main: '#2196f3',
      light: '#64b5f6',
      dark: '#1976d2',
    },
    background: {
      default: mode === 'light' ? '#f5f5f5' : '#121212',
      paper: mode === 'light' ? '#ffffff' : '#1e1e1e',
    },
    text: {
      primary: mode === 'light' ? '#212121' : '#ffffff',
      secondary: mode === 'light' ? '#757575' : '#b0b0b0',
    },
    divider: mode === 'light' ? '#e0e0e0' : '#424242',
    action: {
      active: mode === 'light' ? '#1976d2' : '#90caf9',
      hover: mode === 'light' ? 'rgba(0, 0, 0, 0.04)' : 'rgba(255, 255, 255, 0.08)',
      selected: mode === 'light' ? 'rgba(0, 0, 0, 0.08)' : 'rgba(255, 255, 255, 0.12)',
      disabled: mode === 'light' ? 'rgba(0, 0, 0, 0.26)' : 'rgba(255, 255, 255, 0.3)',
      disabledBackground: mode === 'light' ? 'rgba(0, 0, 0, 0.12)' : 'rgba(255, 255, 255, 0.12)',
    },
  },
  typography: {
    fontFamily: '"Roboto", "Helvetica", "Arial", sans-serif',
    h1: {
      fontSize: '2.5rem',
      fontWeight: 500,
      lineHeight: 1.2,
    },
    h2: {
      fontSize: '2rem',
      fontWeight: 500,
      lineHeight: 1.3,
    },
    h3: {
      fontSize: '1.75rem',
      fontWeight: 500,
      lineHeight: 1.3,
    },
    h4: {
      fontSize: '1.5rem',
      fontWeight: 500,
      lineHeight: 1.4,
    },
    h5: {
      fontSize: '1.25rem',
      fontWeight: 500,
      lineHeight: 1.4,
    },
    h6: {
      fontSize: '1rem',
      fontWeight: 500,
      lineHeight: 1.5,
    },
    body1: {
      fontSize: '1rem',
      lineHeight: 1.5,
    },
    body2: {
      fontSize: '0.875rem',
      lineHeight: 1.43,
    },
    button: {
      fontSize: '0.875rem',
      fontWeight: 500,
      textTransform: 'none', // Remove uppercase automático
    },
  },
  shape: {
    borderRadius: 8, // Bordas mais arredondadas
  },
  spacing: 8, // 1 unit = 8px
  components: {
    // Customizações globais dos componentes
    MuiButton: {
      styleOverrides: {
        root: {
          borderRadius: 12,
          textTransform: 'none',
          fontWeight: 600,
          boxShadow: 'none',
          transition: 'all 0.3s ease',
          '&:hover': {
            boxShadow: mode === 'light'
              ? '0px 4px 12px rgba(0, 0, 0, 0.15)'
              : '0px 4px 12px rgba(0, 0, 0, 0.3)',
            transform: 'translateY(-2px)',
          },
        },
        contained: {
          '&:hover': {
            boxShadow: mode === 'light'
              ? '0px 6px 20px rgba(0, 0, 0, 0.2)'
              : '0px 6px 20px rgba(0, 0, 0, 0.4)',
          },
        },
      },
    },
    MuiCard: {
      styleOverrides: {
        root: {
          borderRadius: 16,
          boxShadow: mode === 'light'
            ? '0px 2px 8px rgba(0, 0, 0, 0.08)'
            : '0px 2px 8px rgba(0, 0, 0, 0.3)',
          transition: 'all 0.3s ease',
          '&:hover': {
            boxShadow: mode === 'light'
              ? '0px 8px 24px rgba(0, 0, 0, 0.15)'
              : '0px 8px 24px rgba(0, 0, 0, 0.4)',
            transform: 'translateY(-4px)',
          },
        },
      },
    },
    MuiPaper: {
      styleOverrides: {
        root: {
          borderRadius: 8,
        },
      },
    },
    MuiTextField: {
      styleOverrides: {
        root: {
          '& .MuiOutlinedInput-root': {
            borderRadius: 8,
          },
        },
      },
    },
    MuiDialog: {
      styleOverrides: {
        paper: {
          borderRadius: 12,
        },
      },
    },
    MuiChip: {
      styleOverrides: {
        root: {
          borderRadius: 16,
          fontWeight: 500,
        },
      },
    },
    MuiTableContainer: {
      styleOverrides: {
        root: {
          borderRadius: 16,
          boxShadow: mode === 'light'
            ? '0px 2px 8px rgba(0, 0, 0, 0.08)'
            : '0px 2px 8px rgba(0, 0, 0, 0.3)',
          overflow: 'hidden',
        },
      },
    },
    MuiTableHead: {
      styleOverrides: {
        root: {
          '& .MuiTableCell-head': {
            backgroundColor: mode === 'light' ? '#f8f9fa' : '#2d2d2d',
            fontWeight: 700,
            fontSize: '0.875rem',
            color: mode === 'light' ? '#495057' : '#ffffff',
            borderBottom: `2px solid ${mode === 'light' ? '#dee2e6' : '#424242'}`,
            textTransform: 'uppercase',
            letterSpacing: '0.5px',
          },
        },
      },
    },
    MuiTableRow: {
      styleOverrides: {
        root: {
          '&:nth-of-type(even)': {
            backgroundColor: mode === 'light' ? '#fafafa' : '#1a1a1a',
          },
          '&:hover': {
            backgroundColor: mode === 'light'
              ? '#e3f2fd !important'
              : '#333333 !important',
            transform: 'scale(1.01)',
            transition: 'all 0.2s ease',
          },
        },
      },
    },
    MuiIconButton: {
      styleOverrides: {
        root: {
          borderRadius: 12,
          transition: 'all 0.3s ease',
          '&:hover': {
            backgroundColor: mode === 'light'
              ? 'rgba(0, 0, 0, 0.08)'
              : 'rgba(255, 255, 255, 0.12)',
            transform: 'scale(1.1)',
          },
        },
      },
    },
    MuiAlert: {
      styleOverrides: {
        root: {
          borderRadius: 12,
          fontWeight: 500,
          '& .MuiAlert-icon': {
            fontSize: '1.25rem',
          },
        },
      },
    },
  },
});

// Temas pré-definidos
export const lightTheme = createTheme(createMDFeTheme('light'));
export const darkTheme = createTheme(createMDFeTheme('dark'));

// Tema padrão (light)
export const theme = lightTheme;

// Função para obter tema baseado no modo
export const getTheme = (mode: 'light' | 'dark') => {
  return mode === 'dark' ? darkTheme : lightTheme;
};

export default theme;