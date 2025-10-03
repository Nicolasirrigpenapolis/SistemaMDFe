import React, { useState, useEffect } from 'react';

interface Municipio {
  id: number;
  codigo: number;
  nome: string;
  uf: string;
}

interface MunicipioSelectorProps {
  uf: string;
  value?: string;
  onChange: (municipio: { codigo: number; nome: string } | null) => void;
  placeholder?: string;
  required?: boolean;
  disabled?: boolean;
  className?: string;
}

export function MunicipioSelector({
  uf,
  value,
  onChange,
  placeholder = 'Selecione o município',
  required = false,
  disabled = false,
  className = ''
}: MunicipioSelectorProps) {
  const [municipios, setMunicipios] = useState<Municipio[]>([]);
  const [loading, setLoading] = useState(false);
  const [selectedMunicipio, setSelectedMunicipio] = useState<string>('');

  useEffect(() => {
    // Limpar o valor do município ao trocar de UF
    setSelectedMunicipio('');
    onChange(null);

    if (uf) {
      loadMunicipios(uf);
    } else {
      setMunicipios([]);
    }
  }, [uf]);

  useEffect(() => {
    if (value && municipios.length > 0) {
      setSelectedMunicipio(value);
    }
  }, [value, municipios]);

  const loadMunicipios = async (ufSigla: string) => {
    setLoading(true);
    try {
      const token = localStorage.getItem('token');
      const response = await fetch(
        `https://localhost:5001/api/municipios?uf=${ufSigla}&tamanhoPagina=10000`,
        {
          headers: {
            'Authorization': token || '',
            'Content-Type': 'application/json'
          }
        }
      );

      if (!response.ok) {
        throw new Error('Erro ao carregar municípios');
      }

      const data = await response.json();
      const items = data.items || [];
      setMunicipios(items);

      // Se houver um valor selecionado, mantê-lo
      if (value) {
        const municipio = items.find((m: Municipio) => m.nome === value);
        if (municipio) {
          setSelectedMunicipio(municipio.nome);
        }
      }
    } catch (error) {
      console.error('Erro ao carregar municípios:', error);
      setMunicipios([]);
    } finally {
      setLoading(false);
    }
  };

  const handleChange = (e: React.ChangeEvent<HTMLSelectElement>) => {
    const nomeMunicipio = e.target.value;
    setSelectedMunicipio(nomeMunicipio);

    if (nomeMunicipio) {
      const municipio = municipios.find(m => m.nome === nomeMunicipio);
      if (municipio) {
        onChange({
          codigo: municipio.codigo,
          nome: municipio.nome
        });
      }
    } else {
      onChange(null);
    }
  };

  const baseClass = className || "w-full px-4 py-3 bg-background dark:bg-gray-700 border border-gray-300 dark:border-gray-600 rounded-xl text-foreground placeholder-gray-400 dark:placeholder-gray-500 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200";

  return (
    <select
      value={selectedMunicipio}
      onChange={handleChange}
      className={baseClass}
      disabled={disabled || loading || !uf}
      required={required}
    >
      <option value="">
        {loading ? 'Carregando municípios...' : !uf ? 'Selecione uma UF primeiro' : placeholder}
      </option>
      {municipios.map((municipio) => (
        <option key={municipio.id} value={municipio.nome}>
          {municipio.nome}
        </option>
      ))}
    </select>
  );
}
