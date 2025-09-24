import { useState, useCallback } from 'react';
import { cnpjService, CNPJData } from '../services/cnpjService';

interface UseCNPJLookupReturn {
  consultarCNPJ: (cnpj: string) => Promise<CNPJData | null>;
  loading: boolean;
  error: string | null;
  clearError: () => void;
}

export const useCNPJLookup = (): UseCNPJLookupReturn => {
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const consultarCNPJ = useCallback(async (cnpj: string): Promise<CNPJData | null> => {
    if (!cnpj || cnpj.replace(/\D/g, '').length !== 14) {
      setError('CNPJ deve conter 14 dígitos');
      return null;
    }

    setLoading(true);
    setError(null);

    try {
      const response = await cnpjService.consultarCNPJ(cnpj);

      if (response.success && response.data) {
        return response.data;
      } else {
        setError(response.error || 'Erro ao consultar CNPJ');
        return null;
      }
    } catch (err) {
      setError('Erro de rede ao consultar CNPJ');
      return null;
    } finally {
      setLoading(false);
    }
  }, []);

  const clearError = useCallback(() => {
    setError(null);
  }, []);

  return {
    consultarCNPJ,
    loading,
    error,
    clearError
  };
};