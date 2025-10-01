import { useState, useEffect } from 'react';
import { useAuth } from '../contexts/AuthContext';
import { authService } from '../services/authService';

interface UsePermissionsReturn {
  permissions: string[];
  hasPermission: (permission: string) => boolean;
  hasAnyPermission: (permissions: string[]) => boolean;
  hasAllPermissions: (permissions: string[]) => boolean;
  loading: boolean;
}

export function usePermissions(): UsePermissionsReturn {
  const { user, token } = useAuth();
  const [permissions, setPermissions] = useState<string[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const loadPermissions = async () => {
      console.log('usePermissions: Loading permissions...', { token: !!token, user: !!user });

      if (!token || !user) {
        console.log('usePermissions: No token or user, skipping permission load');
        setPermissions([]);
        setLoading(false);
        return;
      }

      try {
        const API_BASE_URL = process.env.REACT_APP_API_URL || 'https://localhost:5001/api';
        const url = `${API_BASE_URL}/permissoes/user`;
        console.log('usePermissions: Fetching permissions from:', url);

        const response = await authService.fetchWithAuth(url);

        if (response.ok) {
          const userPermissions = await response.json();
          console.log('usePermissions: Permissions loaded:', userPermissions);
          setPermissions(userPermissions || []);
        } else {
          console.error('usePermissions: Error response status:', response.status);
          const errorText = await response.text();
          console.error('usePermissions: Error response body:', errorText);
          setPermissions([]);
        }
      } catch (error) {
        console.error('usePermissions: Exception loading permissions:', error);
        setPermissions([]);
      } finally {
        setLoading(false);
      }
    };

    loadPermissions();
  }, [token, user]);

  const hasPermission = (permission: string): boolean => {
    return permissions.includes(permission);
  };

  const hasAnyPermission = (permissionList: string[]): boolean => {
    return permissionList.some(permission => permissions.includes(permission));
  };

  const hasAllPermissions = (permissionList: string[]): boolean => {
    return permissionList.every(permission => permissions.includes(permission));
  };

  return {
    permissions,
    hasPermission,
    hasAnyPermission,
    hasAllPermissions,
    loading
  };
}