import React, { useState, useEffect } from 'react';
import { localidadeService, Estado, Municipio, LocalCarregamento, RotaCalculada } from '../../../services/localidadeService';
import { useTheme } from '../../../contexts/ThemeContext';
import Icon from '../Icon';

interface LocalidadeSelectorProps {
  locais: LocalCarregamento[];
  onChange: (locais: LocalCarregamento[]) => void;
  title: string;
  tipo: 'carregamento' | 'descarregamento';
}

export function LocalidadeSelector({ locais, onChange, title, tipo }: LocalidadeSelectorProps) {
  const { theme } = useTheme();
  const [estados, setEstados] = useState<Estado[]>([]);
  const [municipiosPorUF, setMunicipiosPorUF] = useState<{ [key: string]: Municipio[] }>({});
  const [rotaCalculada, setRotaCalculada] = useState<RotaCalculada[]>([]);
  const [estadosPercurso, setEstadosPercurso] = useState<string[]>([]);

  useEffect(() => {
    carregarEstados();
  }, []);

  useEffect(() => {
    if (locais.length >= 2) {
      calcularRota();
    } else {
      setRotaCalculada([]);
      setEstadosPercurso([]);
    }
  }, [locais]);

  const carregarEstados = async () => {
    const estadosData = await localidadeService.obterEstados();
    setEstados(estadosData);
  };

  const carregarMunicipios = async (uf: string) => {
    if (!municipiosPorUF[uf]) {
      const municipios = await localidadeService.obterMunicipiosPorEstado(uf);
      setMunicipiosPorUF(prev => ({
        ...prev,
        [uf]: municipios
      }));
    }
  };

  const calcularRota = () => {
    if (locais.length >= 2) {
      const rotas = localidadeService.calcularRotaCompleta(locais);
      const todosEstados = localidadeService.obterEstadosPercursoTotal(rotas);

      setRotaCalculada(rotas);
      setEstadosPercurso(todosEstados);
    }
  };

  const adicionarLocal = () => {
    const novoLocal: LocalCarregamento = {
      id: `${tipo}_${Date.now()}`,
      municipio: '',
      uf: '',
      codigoIBGE: 0
    };

    onChange([...locais, novoLocal]);
  };

  const removerLocal = (index: number) => {
    const novosLocais = locais.filter((_, i) => i !== index);
    onChange(novosLocais);
  };

  const atualizarLocal = async (index: number, campo: 'uf' | 'municipio', valor: string) => {
    const novosLocais = [...locais];
    novosLocais[index] = { ...novosLocais[index], [campo]: valor };

    if (campo === 'uf') {
      // Reset município quando UF mudar
      novosLocais[index].municipio = '';
      novosLocais[index].codigoIBGE = 0;
      // Carregar municípios da nova UF
      await carregarMunicipios(valor);
    } else if (campo === 'municipio' && novosLocais[index].uf) {
      // Buscar código IBGE real do backend quando município for selecionado
      const codigoIBGE = await localidadeService.obterCodigoMunicipio(valor, novosLocais[index].uf);
      novosLocais[index].codigoIBGE = codigoIBGE;
    }

    onChange(novosLocais);
  };

  return (
    <div style={{ marginBottom: 'var(--space-6)' }}>
      <div style={{
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'space-between',
        marginBottom: 'var(--space-4)'
      }}>
        <h5 style={{
          margin: 0,
          fontSize: '1.1rem',
          fontWeight: '600',
          color: 'var(--color-text-primary)',
          display: 'flex',
          alignItems: 'center',
          gap: '0.5rem'
        }}>
          <Icon name={tipo === 'carregamento' ? 'upload' : 'download'} />
          {title}
        </h5>
        <button
          type="button"
          onClick={adicionarLocal}
          style={{
            display: 'flex',
            alignItems: 'center',
            gap: '0.5rem',
            padding: '0.5rem 1rem',
            background: 'linear-gradient(135deg, #3b82f6, #1d4ed8)',
            color: 'white',
            border: 'none',
            borderRadius: '8px',
            cursor: 'pointer',
            fontWeight: '600',
            fontSize: '0.875rem',
            transition: 'all 0.3s ease'
          }}
          onMouseEnter={(e) => {
            e.currentTarget.style.transform = 'translateY(-1px)';
            e.currentTarget.style.boxShadow = '0 4px 12px rgba(59, 130, 246, 0.3)';
          }}
          onMouseLeave={(e) => {
            e.currentTarget.style.transform = 'translateY(0)';
            e.currentTarget.style.boxShadow = 'none';
          }}
        >
          <Icon name="plus" />
          Adicionar Local
        </button>
      </div>

      {/* Lista de Locais */}
      {locais.length > 0 ? (
        <div style={{
          border: '1px solid var(--color-border)',
          borderRadius: 'var(--border-radius-lg)',
          background: 'var(--color-background-secondary)',
          overflow: 'hidden'
        }}>
          {locais.map((local, index) => (
            <div key={local.id || index} style={{
              padding: 'var(--space-4)',
              borderBottom: index < locais.length - 1 ? '1px solid var(--color-border)' : 'none'
            }}>
              <div style={{
                display: 'flex',
                alignItems: 'center',
                gap: '1rem',
                marginBottom: '1rem'
              }}>
                <div style={{
                  width: '32px',
                  height: '32px',
                  background: tipo === 'carregamento'
                    ? 'linear-gradient(135deg, #3b82f6, #1d4ed8)'
                    : 'linear-gradient(135deg, #10b981, #059669)',
                  borderRadius: '8px',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  color: 'white',
                  fontWeight: '600',
                  fontSize: '0.875rem'
                }}>
                  {index + 1}
                </div>
                <div style={{ flex: 1 }}>
                  <h6 style={{
                    margin: 0,
                    fontSize: '0.9rem',
                    fontWeight: '600',
                    color: 'var(--color-text-primary)'
                  }}>
                    Local {index + 1} de {tipo}
                  </h6>
                </div>
                <button
                  onClick={() => removerLocal(index)}
                  style={{
                    width: '28px',
                    height: '28px',
                    background: '#ef4444',
                    border: 'none',
                    borderRadius: '6px',
                    color: 'white',
                    cursor: 'pointer',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center'
                  }}
                >
                  <Icon name="trash" />
                </button>
              </div>

              <div style={{
                display: 'grid',
                gridTemplateColumns: '1fr 2fr',
                gap: 'var(--space-4)'
              }}>
                <div>
                  <label style={{
                    display: 'block',
                    fontSize: '0.875rem',
                    fontWeight: '600',
                    color: 'var(--color-text-primary)',
                    marginBottom: '0.5rem'
                  }}>
                    Estado (UF) *
                  </label>
                  <select
                    value={local.uf}
                    onChange={(e) => atualizarLocal(index, 'uf', e.target.value)}
                    style={{
                      width: '100%',
                      padding: '0.75rem',
                      border: `2px solid ${theme === 'dark' ? '#374151' : '#d1d5db'}`,
                      borderRadius: '8px',
                      fontSize: '0.875rem',
                      background: theme === 'dark' ? '#374151' : 'white',
                      color: theme === 'dark' ? '#f9fafb' : '#1f2937'
                    }}
                    required
                  >
                    <option value="">Selecione o Estado</option>
                    {estados.map(estado => (
                      <option key={estado.sigla} value={estado.sigla}>
                        {estado.sigla} - {estado.nome}
                      </option>
                    ))}
                  </select>
                </div>

                <div>
                  <label style={{
                    display: 'block',
                    fontSize: '0.875rem',
                    fontWeight: '600',
                    color: 'var(--color-text-primary)',
                    marginBottom: '0.5rem'
                  }}>
                    Município *
                  </label>
                  <select
                    value={local.municipio}
                    onChange={(e) => atualizarLocal(index, 'municipio', e.target.value)}
                    disabled={!local.uf}
                    style={{
                      width: '100%',
                      padding: '0.75rem',
                      border: `2px solid ${theme === 'dark' ? '#374151' : '#d1d5db'}`,
                      borderRadius: '8px',
                      fontSize: '0.875rem',
                      background: theme === 'dark' ? '#374151' : 'white',
                      color: theme === 'dark' ? '#f9fafb' : '#1f2937',
                      cursor: !local.uf ? 'not-allowed' : 'pointer',
                      opacity: !local.uf ? 0.6 : 1
                    }}
                    required
                  >
                    <option value="">
                      {!local.uf ? 'Primeiro selecione o Estado' : 'Selecione o Município'}
                    </option>
                    {local.uf && municipiosPorUF[local.uf]?.map(municipio => (
                      <option key={municipio.id} value={municipio.nome}>
                        {municipio.nome}
                      </option>
                    ))}
                  </select>
                </div>
              </div>

              {local.codigoIBGE > 0 && (
                <div style={{
                  marginTop: '0.75rem',
                  padding: '0.5rem',
                  background: 'rgba(16, 185, 129, 0.1)',
                  borderRadius: '6px',
                  fontSize: '0.75rem',
                  color: 'var(--color-text-secondary)'
                }}>
                  <Icon name="check-circle" style={{ marginRight: '0.25rem' }} />
                  Código IBGE: {local.codigoIBGE}
                </div>
              )}
            </div>
          ))}
        </div>
      ) : (
        <div style={{
          border: '2px dashed var(--color-border)',
          borderRadius: 'var(--border-radius-lg)',
          padding: 'var(--space-6)',
          textAlign: 'center',
          background: 'var(--color-background-secondary)'
        }}>
          <div style={{
            width: '48px',
            height: '48px',
            background: tipo === 'carregamento'
              ? 'linear-gradient(135deg, #3b82f6, #1d4ed8)'
              : 'linear-gradient(135deg, #10b981, #059669)',
            borderRadius: '50%',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            margin: '0 auto 1rem',
            color: 'white'
          }}>
            <Icon name={tipo === 'carregamento' ? 'upload' : 'download'} />
          </div>
          <h6 style={{
            margin: '0 0 0.5rem 0',
            fontSize: '1rem',
            fontWeight: '600',
            color: 'var(--color-text-primary)'
          }}>
            Nenhum local de {tipo} definido
          </h6>
          <p style={{
            margin: '0',
            color: 'var(--color-text-secondary)',
            fontSize: '0.875rem'
          }}>
            Clique em "Adicionar Local" para definir os locais de {tipo}
          </p>
        </div>
      )}

      {/* Informações de Rota Calculada */}
      {estadosPercurso.length > 0 && (
        <div style={{
          marginTop: 'var(--space-4)',
          padding: 'var(--space-4)',
          background: 'linear-gradient(135deg, rgba(59, 130, 246, 0.1), rgba(29, 78, 216, 0.05))',
          borderRadius: 'var(--border-radius-lg)',
          border: '1px solid rgba(59, 130, 246, 0.2)'
        }}>
          <h6 style={{
            margin: '0 0 1rem 0',
            fontSize: '0.9rem',
            fontWeight: '600',
            color: 'var(--color-text-primary)',
            display: 'flex',
            alignItems: 'center',
            gap: '0.5rem'
          }}>
            <Icon name="route" />
            Rota Calculada Automaticamente
          </h6>

          <div style={{
            display: 'flex',
            flexWrap: 'wrap',
            gap: '0.5rem',
            marginBottom: '1rem'
          }}>
            {estadosPercurso.map((uf, index) => (
              <span
                key={uf}
                style={{
                  padding: '0.25rem 0.75rem',
                  background: 'rgba(59, 130, 246, 0.2)',
                  color: 'var(--color-text-primary)',
                  borderRadius: '20px',
                  fontSize: '0.75rem',
                  fontWeight: '600',
                  display: 'flex',
                  alignItems: 'center',
                  gap: '0.25rem'
                }}
              >
                {uf}
                {index < estadosPercurso.length - 1 && (
                  <Icon name="arrow-right" style={{ fontSize: '0.6rem' }} />
                )}
              </span>
            ))}
          </div>

          <p style={{
            margin: 0,
            fontSize: '0.75rem',
            color: 'var(--color-text-secondary)',
            fontStyle: 'italic'
          }}>
            ✨ Esta rota foi calculada automaticamente baseada nas fronteiras geográficas entre os estados.
            Os estados de percurso serão incluídos automaticamente no MDF-e.
          </p>
        </div>
      )}
    </div>
  );
}