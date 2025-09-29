/**
 * 🔐 SERVIÇO DE AUTENTICAÇÃO
 * Sistema completo de autenticação JWT com gestão de tokens e usuários
 */

// ✅ IMPORTANDO TIPOS CENTRALIZADOS
import {
  LoginRequest,
  RegisterRequest,
  UserInfo,
  LoginResponse,
  ApiResponseAlternativo as ApiResponse
} from '../types/apiResponse';

const API_BASE_URL = process.env.REACT_APP_API_URL || 'https://localhost:5001/api';

// Constantes para localStorage
const TOKEN_KEY = 'mdfe_token';
const USER_KEY = 'mdfe_user';
const REFRESH_KEY = 'mdfe_refresh';

class AuthService {
  /**
   * 🔑 Fazer login no sistema
   */
  async login(credentials: LoginRequest): Promise<ApiResponse<LoginResponse>> {
    try {
      const response = await fetch(`${API_BASE_URL}/auth/login`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(credentials)
      });

      const result = await response.json();

      if (response.ok) {
        // Salvar dados no localStorage
        this.setToken(result.token);
        this.setUser(result.user);

        return {
          sucesso: true,
          data: result,
          mensagem: 'Login realizado com sucesso'
        };
      } else {
        return {
          sucesso: false,
          mensagem: result.message || 'Erro ao fazer login'
        };
      }
    } catch (error) {
      console.error('Erro no login:', error);
      return {
        sucesso: false,
        mensagem: 'Erro de conexão com o servidor'
      };
    }
  }

  /**
   * 📝 Registrar novo usuário
   */
  async register(userData: RegisterRequest): Promise<ApiResponse<void>> {
    try {
      const response = await fetch(`${API_BASE_URL}/auth/register`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(userData)
      });

      const result = await response.json();

      return {
        sucesso: response.ok,
        mensagem: result.message || (response.ok ? 'Usuário criado com sucesso' : 'Erro ao criar usuário')
      };
    } catch (error) {
      console.error('Erro no registro:', error);
      return {
        sucesso: false,
        mensagem: 'Erro de conexão com o servidor'
      };
    }
  }

  /**
   * 🚪 Fazer logout
   */
  logout(): void {
    // Limpar dados do localStorage
    localStorage.removeItem(TOKEN_KEY);
    localStorage.removeItem(USER_KEY);
    localStorage.removeItem(REFRESH_KEY);

    // Redirecionar para login
    window.location.href = '/login';
  }

  /**
   * 🔍 Verificar se usuário está autenticado
   */
  isAuthenticated(): boolean {
    const token = this.getToken();
    if (!token) return false;

    // Verificar se token não expirou
    try {
      const payload = this.parseJWT(token);
      const now = Date.now() / 1000;

      if (payload.exp && payload.exp < now) {
        // Token expirado, fazer logout
        this.logout();
        return false;
      }

      return true;
    } catch (error) {
      // Token inválido
      this.logout();
      return false;
    }
  }

  /**
   * 👤 Obter dados do usuário atual
   */
  getCurrentUser(): UserInfo | null {
    const userStr = localStorage.getItem(USER_KEY);
    if (!userStr) return null;

    try {
      return JSON.parse(userStr);
    } catch (error) {
      console.error('Erro ao parsear dados do usuário:', error);
      return null;
    }
  }

  /**
   * 🎫 Obter token de acesso
   */
  getToken(): string | null {
    return localStorage.getItem(TOKEN_KEY);
  }

  /**
   * 💾 Salvar token
   */
  setToken(token: string): void {
    localStorage.setItem(TOKEN_KEY, token);
  }

  /**
   * 💾 Salvar dados do usuário
   */
  setUser(user: UserInfo): void {
    localStorage.setItem(USER_KEY, JSON.stringify(user));
  }

  /**
   * 📊 Obter header de autorização para requests
   */
  getAuthHeader(): Record<string, string> {
    const token = this.getToken();
    if (!token) return {};

    return {
      'Authorization': `Bearer ${token}`
    };
  }

  /**
   * 🔄 Interceptor para requests automáticos
   */
  async fetchWithAuth(url: string, options: RequestInit = {}): Promise<Response> {
    const authHeaders = this.getAuthHeader();

    const response = await fetch(url, {
      ...options,
      headers: {
        'Content-Type': 'application/json',
        ...authHeaders,
        ...options.headers,
      },
    });

    // Se retornar 401, token expirou
    if (response.status === 401) {
      this.logout();
      throw new Error('Sessão expirada');
    }

    return response;
  }

  /**
   * 🔧 Utilitários privados
   */
  private parseJWT(token: string): any {
    try {
      const base64Url = token.split('.')[1];
      const base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
      const jsonPayload = decodeURIComponent(
        atob(base64)
          .split('')
          .map(c => '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2))
          .join('')
      );

      return JSON.parse(jsonPayload);
    } catch (error) {
      throw new Error('Token inválido');
    }
  }

  /**
   * ⏰ Obter tempo restante do token (em minutos)
   */
  getTokenTimeRemaining(): number {
    const token = this.getToken();
    if (!token) return 0;

    try {
      const payload = this.parseJWT(token);
      const now = Date.now() / 1000;
      const timeRemaining = payload.exp - now;

      return Math.max(0, Math.floor(timeRemaining / 60));
    } catch (error) {
      return 0;
    }
  }

  /**
   * 🔔 Verificar se token expira em breve (15 minutos)
   */
  shouldRefreshToken(): boolean {
    const timeRemaining = this.getTokenTimeRemaining();
    return timeRemaining <= 15 && timeRemaining > 0;
  }

  /**
   * ✅ Validar formato de email
   */
  validateEmail(email: string): boolean {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
  }

  /**
   * ✅ Validar força da senha
   */
  validatePassword(password: string): {
    isValid: boolean;
    errors: string[];
  } {
    const errors: string[] = [];

    if (password.length < 6) {
      errors.push('Senha deve ter pelo menos 6 caracteres');
    }

    if (!/[A-Z]/.test(password)) {
      errors.push('Senha deve conter pelo menos uma letra maiúscula');
    }

    if (!/[a-z]/.test(password)) {
      errors.push('Senha deve conter pelo menos uma letra minúscula');
    }

    if (!/\d/.test(password)) {
      errors.push('Senha deve conter pelo menos um número');
    }

    return {
      isValid: errors.length === 0,
      errors
    };
  }

  /**
   * 📱 Validar formato de telefone
   */
  validatePhone(phone: string): boolean {
    if (!phone) return true; // Telefone é opcional

    const phoneRegex = /^\(\d{2}\)\s\d{4,5}-\d{4}$/;
    return phoneRegex.test(phone);
  }

  /**
   * 🎯 Formatação automática de telefone
   */
  formatPhone(phone: string): string {
    const numbers = phone.replace(/\D/g, '');

    if (numbers.length === 11) {
      return numbers.replace(/(\d{2})(\d{5})(\d{4})/, '($1) $2-$3');
    } else if (numbers.length === 10) {
      return numbers.replace(/(\d{2})(\d{4})(\d{4})/, '($1) $2-$3');
    }

    return phone;
  }

  /**
   * 📊 Obter estatísticas da sessão
   */
  getSessionInfo(): {
    isAuthenticated: boolean;
    user: UserInfo | null;
    tokenTimeRemaining: number;
    shouldRefresh: boolean;
  } {
    return {
      isAuthenticated: this.isAuthenticated(),
      user: this.getCurrentUser(),
      tokenTimeRemaining: this.getTokenTimeRemaining(),
      shouldRefresh: this.shouldRefreshToken()
    };
  }
}

export const authService = new AuthService();