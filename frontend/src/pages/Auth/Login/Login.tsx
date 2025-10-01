import React, { useState, useEffect } from 'react';
import { useNavigate, Link } from 'react-router-dom';
import { useAuth } from '../../../contexts/AuthContext';
import { authService } from '../../../services/authService';
import Icon from '../../../components/UI/Icon';

interface LoginForm {
  username: string;
  password: string;
  rememberMe: boolean;
}

interface FormErrors {
  username?: string;
  password?: string;
  general?: string;
}

export function Login() {
  const navigate = useNavigate();
  const { login, isAuthenticated, loading } = useAuth();

  const [form, setForm] = useState<LoginForm>({
    username: '',
    password: '',
    rememberMe: false
  });

  const [errors, setErrors] = useState<FormErrors>({});
  const [showPassword, setShowPassword] = useState(false);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [alert, setAlert] = useState<{ type: 'success' | 'error'; message: string } | null>(null);

  // Redirecionar se já autenticado
  useEffect(() => {
    if (!loading && isAuthenticated) {
      navigate('/dashboard', { replace: true });
    }
  }, [isAuthenticated, loading, navigate]);

  // Limpar alertas após 5 segundos
  useEffect(() => {
    if (alert) {
      const timer = setTimeout(() => setAlert(null), 5000);
      return () => clearTimeout(timer);
    }
  }, [alert]);

  const validateForm = (): boolean => {
    const newErrors: FormErrors = {};

    // Validar username
    if (!form.username) {
      newErrors.username = 'Nome de usuário é obrigatório';
    } else if (form.username.length < 3) {
      newErrors.username = 'Nome de usuário deve ter pelo menos 3 caracteres';
    }

    // Validar senha
    if (!form.password) {
      newErrors.password = 'Senha é obrigatória';
    } else if (form.password.length < 6) {
      newErrors.password = 'Senha deve ter pelo menos 6 caracteres';
    }

    setErrors(newErrors);
    return Object.keys(newErrors).length === 0;
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    if (!validateForm()) {
      return;
    }

    setIsSubmitting(true);
    setErrors({});
    setAlert(null);

    try {
      const result = await login({
        username: form.username,
        password: form.password
      });

      if (result.success) {
        setAlert({ type: 'success', message: result.message });
        // A navegação será feita pelo useEffect quando isAuthenticated mudar
      } else {
        setAlert({ type: 'error', message: result.message });
      }
    } catch (error) {
      setAlert({ type: 'error', message: 'Erro inesperado. Tente novamente.' });
    } finally {
      setIsSubmitting(false);
    }
  };

  const handleInputChange = (field: keyof LoginForm, value: string | boolean) => {
    setForm(prev => ({ ...prev, [field]: value }));

    // Limpar erro do campo específico
    if (errors[field as keyof FormErrors]) {
      setErrors(prev => ({ ...prev, [field]: undefined }));
    }
  };

  const togglePassword = () => {
    setShowPassword(!showPassword);
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100 dark:from-gray-900 dark:to-gray-800 flex items-center justify-center p-4">
      <div className="w-full max-w-md">
        <div className="bg-bg-surface rounded-2xl shadow-xl border border-border-primary overflow-hidden">
          <div className="p-8 text-center border-b border-border-primary bg-gradient-to-r from-primary/5 to-primary-light/5">
            <div className="w-16 h-16 bg-gradient-to-br from-primary to-primary-hover rounded-xl flex items-center justify-center mx-auto mb-4 shadow-lg">
              <Icon name="truck" color="white" size="lg" />
            </div>
            <h1 className="text-2xl font-bold text-text-primary mb-2">MDFe System</h1>
            <p className="text-text-secondary">Acesse sua conta para continuar</p>
          </div>

          <div className="p-8">
            {alert && (
              <div className={`flex items-center gap-3 p-4 rounded-lg mb-6 ${
                alert.type === 'success'
                  ? 'bg-success-light border border-success/20 text-success-dark'
                  : 'bg-danger-light border border-danger/20 text-danger-dark'
              }`}>
                <Icon name={alert.type === 'success' ? 'check-circle' : 'exclamation-circle'} size="sm" />
                <span className="font-medium">{alert.message}</span>
              </div>
            )}

            <form className="space-y-6" onSubmit={handleSubmit} noValidate>
              <div className="space-y-2">
                <label htmlFor="username" className="block text-sm font-medium text-text-primary">
                  Usuário
                </label>
                <div className="relative">
                  <input
                    id="username"
                    type="text"
                    className={`w-full pl-11 pr-4 py-3 border rounded-lg bg-bg-surface text-text-primary placeholder-text-tertiary focus:outline-none focus:ring-2 focus:ring-primary/20 focus:border-primary transition-colors duration-200 ${
                      errors.username
                        ? 'border-danger focus:ring-danger/20 focus:border-danger'
                        : 'border-border-primary hover:border-border-hover'
                    }`}
                    placeholder="Nome de usuário"
                    value={form.username}
                    onChange={(e) => handleInputChange('username', e.target.value)}
                    disabled={isSubmitting}
                    autoComplete="username"
                  />
                  <div className="absolute left-3 top-1/2 transform -translate-y-1/2">
                    <Icon name="user" className="text-text-tertiary" size="sm" />
                  </div>
                </div>
                {errors.username && (
                  <div className="flex items-center gap-2 text-danger text-sm">
                    <Icon name="exclamation-triangle" size="sm" />
                    <span>{errors.username}</span>
                  </div>
                )}
              </div>

              <div className="space-y-2">
                <label htmlFor="password" className="block text-sm font-medium text-text-primary">
                  Senha
                </label>
                <div className="relative">
                  <input
                    id="password"
                    type={showPassword ? 'text' : 'password'}
                    className={`w-full pl-11 pr-12 py-3 border rounded-lg bg-bg-surface text-text-primary placeholder-text-tertiary focus:outline-none focus:ring-2 focus:ring-primary/20 focus:border-primary transition-colors duration-200 ${
                      errors.password
                        ? 'border-danger focus:ring-danger/20 focus:border-danger'
                        : 'border-border-primary hover:border-border-hover'
                    }`}
                    placeholder="Digite sua senha"
                    value={form.password}
                    onChange={(e) => handleInputChange('password', e.target.value)}
                    disabled={isSubmitting}
                    autoComplete="current-password"
                  />
                  <div className="absolute left-3 top-1/2 transform -translate-y-1/2">
                    <Icon name="lock" className="text-text-tertiary" size="sm" />
                  </div>
                  <button
                    type="button"
                    className="absolute right-3 top-1/2 transform -translate-y-1/2 p-1 text-text-tertiary hover:text-text-primary transition-colors duration-200"
                    onClick={togglePassword}
                    disabled={isSubmitting}
                    title={showPassword ? 'Ocultar senha' : 'Mostrar senha'}
                  >
                    <Icon name={showPassword ? 'eye-slash' : 'eye'} size="sm" />
                  </button>
                </div>
                {errors.password && (
                  <div className="flex items-center gap-2 text-danger text-sm">
                    <Icon name="exclamation-triangle" size="sm" />
                    <span>{errors.password}</span>
                  </div>
                )}
              </div>

              <div className="flex items-center justify-between">
                <div className="flex items-center gap-2">
                  <input
                    id="rememberMe"
                    type="checkbox"
                    className="w-4 h-4 text-primary bg-bg-surface border-border-primary rounded focus:ring-primary/20 focus:ring-2"
                    checked={form.rememberMe}
                    onChange={(e) => handleInputChange('rememberMe', e.target.checked)}
                    disabled={isSubmitting}
                  />
                  <label htmlFor="rememberMe" className="text-sm text-text-secondary">
                    Lembrar de mim
                  </label>
                </div>

                <Link
                  to="/auth/forgot-password"
                  className="text-sm text-primary hover:text-primary-hover transition-colors duration-200 font-medium"
                >
                  Esqueceu sua senha?
                </Link>
              </div>

              <button
                type="submit"
                className="w-full py-3 px-4 bg-gradient-to-r from-primary to-primary-hover text-white rounded-lg font-medium hover:shadow-lg disabled:opacity-50 disabled:cursor-not-allowed transition-all duration-200"
                disabled={isSubmitting || loading}
              >
                {isSubmitting ? (
                  <div className="flex items-center justify-center gap-2">
                    <div className="animate-spin rounded-full h-4 w-4 border-b-2 border-white"></div>
                    <span>Entrando...</span>
                  </div>
                ) : (
                  'Entrar'
                )}
              </button>
            </form>

            <div className="mt-6 text-center">
              <p className="text-sm text-text-tertiary">
                Acesso restrito. Entre em contato com o administrador do sistema para obter uma conta.
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}