import React, { useState, useEffect } from 'react';
import { useAuth } from '../../../contexts/AuthContext';
import { authService } from '../../../services/authService';
import Icon from '../../../components/UI/Icon';

interface User {
  id: number;
  nome: string;
  email: string;
  telefone?: string;
  ativo: boolean;
  dataCriacao: string;
}

export function Usuarios() {
  const { user: currentUser } = useAuth();
  const [users, setUsers] = useState<User[]>([]);
  const [loading, setLoading] = useState(true);
  const [showModal, setShowModal] = useState(false);
  const [editingUser, setEditingUser] = useState<User | null>(null);
  const [userForm, setUserForm] = useState({
    nome: '',
    email: '',
    telefone: '',
    password: ''
  });

  useEffect(() => {
    loadUsers();
  }, []);

  const loadUsers = async () => {
    try {
      setLoading(true);
      // Aqui você faria a chamada para API de usuários
      // Por enquanto, vamos simular dados
      const mockUsers: User[] = [
        {
          id: 1,
          nome: currentUser?.nome || 'Usuário Atual',
          email: currentUser?.email || 'usuario@exemplo.com',
          telefone: currentUser?.telefone,
          ativo: true,
          dataCriacao: new Date().toISOString()
        }
      ];
      setUsers(mockUsers);
    } catch (error) {
      console.error('Erro ao carregar usuários:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleEditUser = (user: User) => {
    setEditingUser(user);
    setUserForm({
      nome: user.nome,
      email: user.email,
      telefone: user.telefone || '',
      password: ''
    });
    setShowModal(true);
  };

  const handleAddUser = () => {
    setEditingUser(null);
    setUserForm({
      nome: '',
      email: '',
      telefone: '',
      password: ''
    });
    setShowModal(true);
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    try {
      if (editingUser) {
        // Editar usuário existente
        console.log('Editando usuário:', editingUser.id, userForm);
        // Aqui faria a chamada para API de edição
      } else {
        // Criar novo usuário
        const result = await authService.register({
          nome: userForm.nome,
          email: userForm.email,
          password: userForm.password,
          telefone: userForm.telefone || undefined
        });

        if (result.sucesso) {
          await loadUsers();
          setShowModal(false);
        } else {
          alert(result.mensagem || 'Erro ao criar usuário');
        }
      }
    } catch (error) {
      console.error('Erro ao salvar usuário:', error);
      alert('Erro ao salvar usuário');
    }
  };

  const toggleUserStatus = async (userId: number) => {
    try {
      // Aqui faria a chamada para API de ativação/desativação
      console.log('Alterando status do usuário:', userId);
      await loadUsers();
    } catch (error) {
      console.error('Erro ao alterar status do usuário:', error);
    }
  };

  if (loading) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div>
      </div>
    );
  }

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex justify-between items-center">
        <div>
          <h1 className="text-2xl font-bold text-gray-900 dark:text-white">
            Usuários do Sistema
          </h1>
          <p className="text-gray-600 dark:text-gray-400">
            Gerencie os usuários com acesso ao sistema MDFe
          </p>
        </div>
        <button
          onClick={handleAddUser}
          className="flex items-center gap-2 px-4 py-2 bg-blue-600 hover:bg-blue-700 text-white rounded-lg transition-colors"
        >
          <Icon name="plus" size="sm" />
          Novo Usuário
        </button>
      </div>

      {/* Lista de usuários */}
      <div className="bg-white dark:bg-gray-800 rounded-lg shadow">
        <div className="overflow-x-auto">
          <table className="w-full">
            <thead className="bg-gray-50 dark:bg-gray-700">
              <tr>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider">
                  Usuário
                </th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider">
                  Email
                </th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider">
                  Telefone
                </th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider">
                  Status
                </th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider">
                  Data Criação
                </th>
                <th className="px-6 py-3 text-right text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider">
                  Ações
                </th>
              </tr>
            </thead>
            <tbody className="bg-white dark:bg-gray-800 divide-y divide-gray-200 dark:divide-gray-700">
              {users.map((user) => (
                <tr key={user.id}>
                  <td className="px-6 py-4 whitespace-nowrap">
                    <div className="flex items-center">
                      <div className="w-10 h-10 bg-blue-100 dark:bg-blue-900/30 rounded-full flex items-center justify-center">
                        <Icon name="user" size="sm" />
                      </div>
                      <div className="ml-4">
                        <div className="text-sm font-medium text-gray-900 dark:text-white">
                          {user.nome}
                        </div>
                      </div>
                    </div>
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900 dark:text-gray-300">
                    {user.email}
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900 dark:text-gray-300">
                    {user.telefone || '-'}
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap">
                    <span className={`inline-flex px-2 py-1 text-xs font-semibold rounded-full ${
                      user.ativo
                        ? 'bg-green-100 text-green-800 dark:bg-green-900/30 dark:text-green-400'
                        : 'bg-red-100 text-red-800 dark:bg-red-900/30 dark:text-red-400'
                    }`}>
                      {user.ativo ? 'Ativo' : 'Inativo'}
                    </span>
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-900 dark:text-gray-300">
                    {new Date(user.dataCriacao).toLocaleDateString('pt-BR')}
                  </td>
                  <td className="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                    <div className="flex items-center justify-end gap-2">
                      <button
                        onClick={() => handleEditUser(user)}
                        className="text-blue-600 hover:text-blue-900 dark:text-blue-400 dark:hover:text-blue-300"
                        title="Editar usuário"
                      >
                        <Icon name="edit" size="sm" />
                      </button>
                      <button
                        onClick={() => toggleUserStatus(user.id)}
                        className={`${
                          user.ativo
                            ? 'text-red-600 hover:text-red-900 dark:text-red-400 dark:hover:text-red-300'
                            : 'text-green-600 hover:text-green-900 dark:text-green-400 dark:hover:text-green-300'
                        }`}
                        title={user.ativo ? 'Desativar usuário' : 'Ativar usuário'}
                      >
                        <Icon name={user.ativo ? 'ban' : 'check'} size="sm" />
                      </button>
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>

      {/* Modal de usuário */}
      {showModal && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50">
          <div className="bg-white dark:bg-gray-800 rounded-lg shadow-xl max-w-md w-full mx-4 p-6">
            <div className="flex justify-between items-center mb-4">
              <h3 className="text-lg font-semibold text-gray-900 dark:text-white">
                {editingUser ? 'Editar Usuário' : 'Novo Usuário'}
              </h3>
              <button
                onClick={() => setShowModal(false)}
                className="text-gray-400 hover:text-gray-600 dark:hover:text-gray-200"
              >
                <Icon name="times" size="sm" />
              </button>
            </div>

            <form onSubmit={handleSubmit} className="space-y-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
                  Nome
                </label>
                <input
                  type="text"
                  className="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-lg bg-white dark:bg-gray-700 text-gray-900 dark:text-white"
                  value={userForm.nome}
                  onChange={(e) => setUserForm({ ...userForm, nome: e.target.value })}
                  required
                />
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
                  Email
                </label>
                <input
                  type="email"
                  className="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-lg bg-white dark:bg-gray-700 text-gray-900 dark:text-white"
                  value={userForm.email}
                  onChange={(e) => setUserForm({ ...userForm, email: e.target.value })}
                  required
                />
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
                  Telefone (opcional)
                </label>
                <input
                  type="tel"
                  className="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-lg bg-white dark:bg-gray-700 text-gray-900 dark:text-white"
                  value={userForm.telefone}
                  onChange={(e) => setUserForm({ ...userForm, telefone: authService.formatPhone(e.target.value) })}
                  placeholder="(11) 99999-9999"
                />
              </div>

              {!editingUser && (
                <div>
                  <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
                    Senha
                  </label>
                  <input
                    type="password"
                    className="w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-lg bg-white dark:bg-gray-700 text-gray-900 dark:text-white"
                    value={userForm.password}
                    onChange={(e) => setUserForm({ ...userForm, password: e.target.value })}
                    required
                    minLength={6}
                  />
                </div>
              )}

              <div className="flex gap-3 justify-end pt-4">
                <button
                  type="button"
                  onClick={() => setShowModal(false)}
                  className="px-4 py-2 text-sm font-medium text-gray-700 dark:text-gray-300 bg-gray-100 dark:bg-gray-700 hover:bg-gray-200 dark:hover:bg-gray-600 rounded-lg transition-colors"
                >
                  Cancelar
                </button>
                <button
                  type="submit"
                  className="px-4 py-2 text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 rounded-lg transition-colors"
                >
                  {editingUser ? 'Salvar' : 'Criar'}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
}