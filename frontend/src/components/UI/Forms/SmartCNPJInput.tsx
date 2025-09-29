import React, { useState, useEffect } from 'react';
import { validationService } from '../../../services/cnpjService';

interface SmartCNPJInputProps {
  value: string;
  onChange: (value: string, isValid: boolean) => void;
  onDataFetch?: (data: any) => void;
  placeholder?: string;
  disabled?: boolean;
  autoValidate?: boolean;
  autoFetch?: boolean;
  className?: string;
}

export function SmartCNPJInput({
  value,
  onChange,
  onDataFetch,
  placeholder = "00.000.000/0000-00",
  disabled = false,
  autoValidate = true,
  autoFetch = true,
  className = ""
}: SmartCNPJInputProps) {
  const [isValidating, setIsValidating] = useState(false);
  const [isFetching, setIsFetching] = useState(false);
  const [isValid, setIsValid] = useState<boolean | null>(null);
  const [error, setError] = useState<string>('');

  // Formatar CNPJ conforme digitação
  const formatCNPJ = (input: string): string => {
    const numbers = input.replace(/\D/g, '');
    const formatted = numbers.replace(/(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})/, '$1.$2.$3/$4-$5');
    return formatted;
  };

  // Validar CNPJ conforme usuário digita
  useEffect(() => {
    const validateCNPJ = async () => {
      const numbers = value.replace(/\D/g, '');

      if (numbers.length === 0) {
        setIsValid(null);
        setError('');
        return;
      }

      if (numbers.length < 14) {
        setIsValid(false);
        setError('CNPJ incompleto');
        return;
      }

      if (numbers.length === 14 && autoValidate) {
        setIsValidating(true);
        setError('');

        try {
          const response = await validationService.validarCNPJ(numbers);
          setIsValid(response.data || false);

          if (!response.data) {
            setError('CNPJ inválido');
          } else if (autoFetch && onDataFetch) {
            // Se validação passou, buscar dados automaticamente
            setIsFetching(true);
            const fetchResponse = await validationService.consultarCNPJ(numbers);

            if (fetchResponse.sucesso && fetchResponse.data) {
              onDataFetch(fetchResponse.data);
              setError('');
            } else {
              setError(fetchResponse.mensagem || 'Erro ao consultar dados');
            }
            setIsFetching(false);
          }
        } catch (err) {
          setIsValid(false);
          setError('Erro ao validar CNPJ');
        } finally {
          setIsValidating(false);
        }
      }
    };

    const timer = setTimeout(validateCNPJ, 500); // Debounce
    return () => clearTimeout(timer);
  }, [value, autoValidate, autoFetch, onDataFetch]);

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const formatted = formatCNPJ(e.target.value);
    const isCurrentValid = isValid === true;
    onChange(formatted, isCurrentValid);
  };

  // Classes dinâmicas baseadas no estado
  const getInputClasses = () => {
    const baseClasses = "w-full px-3 py-2 border rounded-md transition-all duration-200 focus:outline-none focus:ring-2";

    if (disabled) {
      return `${baseClasses} bg-gray-100 border-gray-300 text-gray-500 cursor-not-allowed`;
    }

    if (isValidating || isFetching) {
      return `${baseClasses} border-blue-300 bg-blue-50 focus:ring-blue-500 focus:border-blue-500`;
    }

    if (isValid === true) {
      return `${baseClasses} border-green-300 bg-green-50 focus:ring-green-500 focus:border-green-500`;
    }

    if (isValid === false) {
      return `${baseClasses} border-red-300 bg-red-50 focus:ring-red-500 focus:border-red-500`;
    }

    return `${baseClasses} border-gray-300 focus:ring-blue-500 focus:border-blue-500 ${className}`;
  };

  const getStatusIcon = () => {
    if (isValidating) {
      return (
        <div className="absolute right-3 top-1/2 transform -translate-y-1/2">
          <div className="animate-spin h-4 w-4 border-2 border-blue-500 border-t-transparent rounded-full"></div>
        </div>
      );
    }

    if (isFetching) {
      return (
        <div className="absolute right-3 top-1/2 transform -translate-y-1/2">
          <div className="animate-pulse h-4 w-4 bg-blue-500 rounded-full"></div>
        </div>
      );
    }

    if (isValid === true) {
      return (
        <div className="absolute right-3 top-1/2 transform -translate-y-1/2">
          <svg className="h-4 w-4 text-green-500" fill="currentColor" viewBox="0 0 20 20">
            <path fillRule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clipRule="evenodd" />
          </svg>
        </div>
      );
    }

    if (isValid === false) {
      return (
        <div className="absolute right-3 top-1/2 transform -translate-y-1/2">
          <svg className="h-4 w-4 text-red-500" fill="currentColor" viewBox="0 0 20 20">
            <path fillRule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clipRule="evenodd" />
          </svg>
        </div>
      );
    }

    return null;
  };

  const getStatusMessage = () => {
    if (isValidating) return "Validando CNPJ...";
    if (isFetching) return "Buscando dados da empresa...";
    if (error) return error;
    if (isValid === true && autoFetch) return "✓ Dados preenchidos automaticamente";
    if (isValid === true) return "✓ CNPJ válido";
    return "";
  };

  return (
    <div className="space-y-1">
      <div className="relative">
        <input
          type="text"
          value={value}
          onChange={handleChange}
          placeholder={placeholder}
          disabled={disabled}
          maxLength={18}
          className={getInputClasses()}
        />
        {getStatusIcon()}
      </div>

      {/* Mensagem de status */}
      {getStatusMessage() && (
        <p className={`text-xs transition-all duration-200 ${
          isValidating || isFetching ? 'text-blue-600' :
          isValid === true ? 'text-green-600' :
          isValid === false ? 'text-red-600' : 'text-gray-600'
        }`}>
          {getStatusMessage()}
        </p>
      )}
    </div>
  );
}