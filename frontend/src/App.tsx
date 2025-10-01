import { BrowserRouter, useLocation } from 'react-router-dom';
import { ThemeProvider } from './contexts/ThemeContext';
import { AuthProvider } from './contexts/AuthContext';
import { PermissionProvider } from './contexts/PermissionContext';
import { MainLayout } from './components/Layout/MainLayout/MainLayout';
import { AppRoutes } from './routes/AppRoutes';
import './styles/globals.css';

function AppContent() {
  const location = useLocation();

  // Páginas que não devem ter o MainLayout
  const pagesWithoutLayout = ['/login'];
  const shouldShowLayout = !pagesWithoutLayout.includes(location.pathname);

  return shouldShowLayout ? (
    <MainLayout>
      <AppRoutes />
    </MainLayout>
  ) : (
    <AppRoutes />
  );
}

function App() {
  return (
    <ThemeProvider>
      <AuthProvider>
        <PermissionProvider>
          <BrowserRouter>
            <AppContent />
          </BrowserRouter>
        </PermissionProvider>
      </AuthProvider>
    </ThemeProvider>
  );
}

export default App;
