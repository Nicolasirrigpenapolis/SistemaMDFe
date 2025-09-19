import React, { useState, useEffect } from 'react';
import { FormCard } from './common/FormCard';
import { FormField } from './common/FormField';

interface Municipio {
  id: number;
  codigo: number;
  nome: string;
  uf: string;
  ativo: boolean;
}

interface MunicipioFormProps {
  municipio?: Municipio;
  onSave: () => void;
  onCancel: () => void;
}

interface FormData {
  codigo: string;
  nome: string;
  uf: string;
  ativo: boolean;
}

export const MunicipioForm: React.FC<MunicipioFormProps> = ({
  municipio,
  onSave,
  onCancel
}) => {
  const [formData, setFormData] = useState<FormData>({
    codigo: '',
    nome: '',
    uf: '',
    ativo: true
  });
  const [carregando, setCarregando] = useState(false);
  const [erros, setErros] = useState<Record<string, string>>({});
  const [pesquisandoCodigo, setPesquisandoCodigo] = useState(false);

  const estados = [
    { sigla: 'AC', nome: 'Acre' },
    { sigla: 'AL', nome: 'Alagoas' },
    { sigla: 'AP', nome: 'Amapá' },
    { sigla: 'AM', nome: 'Amazonas' },
    { sigla: 'BA', nome: 'Bahia' },
    { sigla: 'CE', nome: 'Ceará' },
    { sigla: 'DF', nome: 'Distrito Federal' },
    { sigla: 'ES', nome: 'Espírito Santo' },
    { sigla: 'GO', nome: 'Goiás' },
    { sigla: 'MA', nome: 'Maranhão' },
    { sigla: 'MT', nome: 'Mato Grosso' },
    { sigla: 'MS', nome: 'Mato Grosso do Sul' },
    { sigla: 'MG', nome: 'Minas Gerais' },
    { sigla: 'PA', nome: 'Pará' },
    { sigla: 'PB', nome: 'Paraíba' },
    { sigla: 'PR', nome: 'Paraná' },
    { sigla: 'PE', nome: 'Pernambuco' },
    { sigla: 'PI', nome: 'Piauí' },
    { sigla: 'RJ', nome: 'Rio de Janeiro' },
    { sigla: 'RN', nome: 'Rio Grande do Norte' },
    { sigla: 'RS', nome: 'Rio Grande do Sul' },
    { sigla: 'RO', nome: 'Rondônia' },
    { sigla: 'RR', nome: 'Roraima' },
    { sigla: 'SC', nome: 'Santa Catarina' },
    { sigla: 'SP', nome: 'São Paulo' },
    { sigla: 'SE', nome: 'Sergipe' },
    { sigla: 'TO', nome: 'Tocantins' }
  ];

  useEffect(() => {
    if (municipio) {
      setFormData({
        codigo: municipio.codigo.toString(),
        nome: municipio.nome,
        uf: municipio.uf,
        ativo: municipio.ativo
      });
    }
  }, [municipio]);

  const buscarCodigoIBGE = async () => {
    if (!formData.nome || !formData.uf) {
      alert('Preencha o nome do município e selecione o estado primeiro');
      return;
    }

    try {
      setPesquisandoCodigo(true);
      const response = await fetch(
        `https://localhost:5001/api/localidade/codigo-municipio?municipio=${encodeURIComponent(formData.nome)}&uf=${formData.uf}`
      );

      if (response.ok) {
        const data = await response.json();
        setFormData(prev => ({ ...prev, codigo: data.codigo.toString() }));
        alert(`Código IBGE encontrado: ${data.codigo}`);
      } else {
        alert('Município não encontrado na base do IBGE');
      }
    } catch (error) {
      alert('Erro ao buscar código IBGE');
    } finally {
      setPesquisandoCodigo(false);
    }
  };

  const validateForm = (): boolean => {
    const newErrors: Record<string, string> = {};

    if (!formData.codigo) {
      newErrors.codigo = 'Código é obrigatório';
    } else if (!/^\d{7}$/.test(formData.codigo)) {
      newErrors.codigo = 'Código deve ter exatamente 7 dígitos';
    }

    if (!formData.nome.trim()) {
      newErrors.nome = 'Nome é obrigatório';
    }

    if (!formData.uf) {
      newErrors.uf = 'Estado é obrigatório';
    }

    setErros(newErrors);
    return Object.keys(newErrors).length === 0;
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    if (!validateForm()) {
      return;
    }

    setCarregando(true);

    try {
      const url = municipio 
        ? `https://localhost:5001/api/municipios/${municipio.id}`
        : 'https://localhost:5001/api/municipios';
      
      const method = municipio ? 'PUT' : 'POST';
      
      const payload = municipio ? {
        nome: formData.nome,
        uf: formData.uf,
        ativo: formData.ativo
      } : {
        codigo: parseInt(formData.codigo),
        nome: formData.nome,
        uf: formData.uf
      };

      const response = await fetch(url, {
        method,
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(payload)
      });

      if (response.ok) {
        alert(municipio ? 'Município atualizado com sucesso!' : 'Município criado com sucesso!');
        onSave();
      } else {
        const errorData = await response.text();
        alert(`Erro: ${errorData}`);
      }
    } catch (error) {
      alert('Erro ao salvar município');
    } finally {
      setCarregando(false);
    }
  };

  return (
    <div className="modal-overlay">
      <div className="modal-content">
        <FormCard title={municipio ? 'Editar Município' : 'Novo Município'}>
          <form onSubmit={handleSubmit}>
            <div style={{ display: 'flex', flexDirection: 'column', gap: '20px' }}>
              
              <FormField
                label="Nome do Município"
                type="text"
                value={formData.nome}
                onChange={(value) => setFormData(prev => ({ ...prev, nome: value }))}
                placeholder="Ex: São Paulo"
                required
                error={erros.nome}
              />

              <FormField
                label="Estado"
                type="select"
                value={formData.uf}
                onChange={(value) => setFormData(prev => ({ ...prev, uf: value }))}
                options={estados.map(estado => ({
                  value: estado.sigla,
                  label: `${estado.sigla} - ${estado.nome}`
                }))}
                required
                error={erros.uf}
              />

              <div className="form-field">
                <label className="form-label">
                  Código IBGE *
                </label>
                <div style={{ display: 'flex', gap: '10px' }}>
                  <input
                    type="text"
                    value={formData.codigo}
                    onChange={(e) => setFormData(prev => ({ ...prev, codigo: e.target.value }))}
                    className={`form-input ${erros.codigo ? 'error' : ''}`}
                    placeholder="Ex: 3550308"
                    disabled={!!municipio}
                    maxLength={7}
                  />
                  {!municipio && (
                    <button
                      type="button"
                      onClick={buscarCodigoIBGE}
                      disabled={pesquisandoCodigo || !formData.nome || !formData.uf}
                      className="btn btn-secondary"
                      style={{ whiteSpace: 'nowrap' }}
                    >
                      {pesquisandoCodigo ? 'Buscando...' : 'Buscar IBGE'}
                    </button>
                  )}
                </div>
                {erros.codigo && (
                  <div className="form-error">
                    {erros.codigo}
                  </div>
                )}
                <div className="form-help">
                  Digite o código ou use o botão para buscar automaticamente
                </div>
              </div>

              {municipio && (
                <div className="form-field">
                  <label className="form-label">Status</label>
                  <div style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
                    <input
                      type="checkbox"
                      id="ativo"
                      checked={formData.ativo}
                      onChange={(e) => setFormData(prev => ({ ...prev, ativo: e.target.checked }))}
                    />
                    <label htmlFor="ativo">Município ativo</label>
                  </div>
                </div>
              )}

              <div className="form-actions" style={{ display: 'flex', gap: '10px', justifyContent: 'flex-end', marginTop: '20px' }}>
                <button
                  type="button"
                  onClick={onCancel}
                  className="btn btn-secondary"
                  disabled={carregando}
                >
                  Cancelar
                </button>
                <button
                  type="submit"
                  className="btn btn-primary"
                  disabled={carregando}
                >
                  {carregando ? 'Salvando...' : municipio ? 'Atualizar' : 'Criar'}
                </button>
              </div>
            </div>
          </form>
        </FormCard>
      </div>
    </div>
  );
};