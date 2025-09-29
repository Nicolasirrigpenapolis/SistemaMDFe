import { BrowserRouter } from 'react-router-dom';
import { ThemeProvider as MuiThemeProvider } from '@mui/material/styles';
import CssBaseline from '@mui/material/CssBaseline';
import { ThemeProvider, useTheme } from './contexts/ThemeContext';
import { AuthProvider } from './contexts/AuthContext';
import { MainLayout } from './components/Layout/MainLayout/MainLayout';
import { AppRoutes } from './routes/AppRoutes';
import './styles/globals.css';

function AppContent() {
  const { theme } = useTheme();

  return (
    <MuiThemeProvider theme={theme}>
      <CssBaseline />
      <BrowserRouter>
        <MainLayout>
          <AppRoutes />
        </MainLayout>
      </BrowserRouter>
    </MuiThemeProvider>
  );
}

function App() {
  return (
    <ThemeProvider>
      <AuthProvider>
        <AppContent />
      </AuthProvider>
    </ThemeProvider>
  );
}

export default App;