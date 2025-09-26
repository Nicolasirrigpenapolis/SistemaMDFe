import React, { useState, useEffect } from 'react';
import { localidadeService, Estado, Municipio, LocalCarregamento, RotaCalculada, OpcaoRota } from '../../../services/localidadeService';
import { useTheme } from '../../../contexts/ThemeContext';
import Icon from '../Icon';

interface LocalidadeSelectorProps {
  locais: LocalCarregamento[];
  onChange: (locais: LocalCarregamento[]) => void;
  title: string;
  tipo: 'carregamento' | 'descarregamento';
  onRotaChange?: (rotaSelecionada: string[]) => void;
  locaisOrigem?: LocalCarregamento[]; // Para calcular rotas no componente de descarregamento
}

export function LocalidadeSelector({ locais, onChange, title, tipo, onRotaChange, locaisOrigem }: LocalidadeSelectorProps) {
  const { theme } = useTheme();
  const [estados, setEstados] = useState<Estado[]>([]);
  const [municipiosPorUF, setMunicipiosPorUF] = useState<{ [key: string]: Municipio[] }>({});
  const [rotaCalculada, setRotaCalculada] = useState<RotaCalculada[]>([]);
  const [estadosPercurso, setEstadosPercurso] = useState<string[]>([]);
  const [opcoesRotas, setOpcoesRotas] = useState<OpcaoRota[]>([]);
  const [rotaSelecionada, setRotaSelecionada] = useState<string>('');
  const [rotaCustomizada, setRotaCustomizada] = useState<string[]>([]);
  const [modoCustomizado, setModoCustomizado] = useState<boolean>(false);
  const [novoEstadoCustomizado, setNovoEstadoCustomizado] = useState<string>('');

  useEffect(() => {
    carregarEstados();
  }, []);

  // ✅ CORREÇÃO: Carregar municípios automaticamente quando dados forem restaurados
  useEffect(() => {
    const carregarMunicipiosRestaurados = async () => {
      const ufsPendentes: string[] = [];

      // Identificar UFs que precisam ter municípios carregados
      for (const local of locais) {
        if (local.uf && local.municipio && !municipiosPorUF[local.uf] && !ufsPendentes.includes(local.uf)) {
          ufsPendentes.push(local.uf);
        }
      }

      // Carregar municípios para cada UF pendente
      for (const uf of ufsPendentes) {
        await carregarMunicipios(uf);
      }
    };

    if (locais.length > 0) {
      carregarMunicipiosRestaurados();
    }
  }, [locais]);

  // Recalcular rotas quando dados são carregados inicialmente ou restaurados
  useEffect(() => {
    // Para componente de descarregamento, verificar se temos dados válidos para rotas
    if (tipo === 'descarregamento' && locaisOrigem && locais.length > 0) {
      const carregamentoValido = locaisOrigem.find(local =>
        local.uf && local.municipio && local.uf.trim() !== '' && local.municipio.trim() !== ''
      );
      const descarregamentoValido = locais.find(local =>
        local.uf && local.municipio && local.uf.trim() !== '' && local.municipio.trim() !== ''
      );

      if (carregamentoValido && descarregamentoValido) {
        setTimeout(() => {
          calcularRota();
        }, 100); // Small delay para garantir que o estado está atualizado
      }
    }
  }, [locais, locaisOrigem, tipo]);

  useEffect(() => {
    if (locais.length >= 2) {
      calcularRota();
    } else {
      setRotaCalculada([]);
      setEstadosPercurso([]);
    }
  }, [locais]);

  // Recalcular rotas quando locais de origem mudarem (para componente de descarregamento)
  useEffect(() => {
    if (tipo === 'descarregamento' && locaisOrigem && locais.length > 0) {
      calcularRota();
    }
  }, [locaisOrigem, locais]);

  const carregarEstados = async () => {
    const estadosData = await localidadeService.obterEstados();
    setEstados(estadosData);
  };

  const carregarMunicipios = async (uf: string) => {
    if (!municipiosPorUF[uf]) {
      try {
        const municipios = await localidadeService.obterMunicipiosPorEstado(uf);
        setMunicipiosPorUF(prev => ({
          ...prev,
          [uf]: municipios || []
        }));
      } catch (error) {
        setMunicipiosPorUF(prev => ({
          ...prev,
          [uf]: []
        }));
      }
    }
  };

  const calcularRota = () => {
    // Para gerar rotas, precisamos ter pelo menos 1 local no componente atual
    // E para componente de descarregamento, precisamos ter locaisOrigem também
    if (locais.length > 0) {
      const rotas = localidadeService.calcularRotaCompleta(locais);
      const todosEstados = localidadeService.obterEstadosPercursoTotal(rotas);

      // Gerar opções de rotas quando temos locais de origem e destino válidos
      if (tipo === 'descarregamento' && locaisOrigem && locaisOrigem.length > 0 && locais.length > 0) {
        // Buscar primeiro local válido de cada tipo (com UF E município preenchidos)
        const primeiroCarregamento = locaisOrigem.find(local => local.uf && local.municipio && local.uf.trim() !== '' && local.municipio.trim() !== '');
        const primeiroDescarregamento = locais.find(local => local.uf && local.municipio && local.uf.trim() !== '' && local.municipio.trim() !== '');

        if (primeiroCarregamento && primeiroDescarregamento) {
          // Gerar rotas mesmo se for no mesmo estado (rota direta)
          const opcoesGeradas = localidadeService.gerarOpcoesRotas(primeiroCarregamento.uf, primeiroDescarregamento.uf);

          setOpcoesRotas(opcoesGeradas);

          // Selecionar automaticamente a primeira rota (recomendada) se ainda não foi selecionada
          if (!rotaSelecionada && opcoesGeradas.length > 0) {
            setRotaSelecionada(opcoesGeradas[0].id);
            if (onRotaChange) {
              onRotaChange(opcoesGeradas[0].percurso);
            }
          }
        } else {
          setOpcoesRotas([]);
          setRotaSelecionada('');
        }
      } else {
        setOpcoesRotas([]);
        setRotaSelecionada('');
      }

      setRotaCalculada(rotas);
      setEstadosPercurso(todosEstados);
    } else {
      setOpcoesRotas([]);
      setRotaSelecionada('');
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

  const selecionarRota = (rotaId: string) => {
    setRotaSelecionada(rotaId);
    setModoCustomizado(false); // Sair do modo customizado
    const rotaEscolhida = opcoesRotas.find(rota => rota.id === rotaId);
    if (rotaEscolhida && onRotaChange) {
      onRotaChange(rotaEscolhida.percurso);
    }
  };

  const ativarModoCustomizado = () => {
    setModoCustomizado(true);
    setRotaSelecionada(''); // Limpar seleção de rota automática

    // Inicializar com origem e destino se disponíveis
    if (locaisOrigem && locaisOrigem.length > 0 && locais.length > 0) {
      const origem = locaisOrigem[0]?.uf;
      const destino = locais[0]?.uf;
      if (origem && destino && origem !== destino) {
        setRotaCustomizada([origem, destino]);
      } else if (origem) {
        setRotaCustomizada([origem]);
      }
    } else {
      setRotaCustomizada([]);
    }
  };

  const adicionarEstadoCustomizado = () => {
    if (novoEstadoCustomizado && !rotaCustomizada.includes(novoEstadoCustomizado)) {
      const novaRota = [...rotaCustomizada];

      // Inserir antes do último estado (destino) se houver mais de 1
      if (novaRota.length > 1) {
        novaRota.splice(-1, 0, novoEstadoCustomizado);
      } else {
        novaRota.push(novoEstadoCustomizado);
      }

      setRotaCustomizada(novaRota);
      setNovoEstadoCustomizado('');

      // Notificar mudança
      if (onRotaChange) {
        onRotaChange(novaRota);
      }
    }
  };

  const removerEstadoCustomizado = (index: number) => {
    const novaRota = rotaCustomizada.filter((_, i) => i !== index);
    setRotaCustomizada(novaRota);

    // Notificar mudança
    if (onRotaChange) {
      onRotaChange(novaRota);
    }
  };

  const finalizarRotaCustomizada = () => {
    if (rotaCustomizada.length >= 2) {
      // Validar se a rota faz sentido geográfico
      const rotaValida = validarRotaCustomizada(rotaCustomizada);
      if (rotaValida && onRotaChange) {
        onRotaChange(rotaCustomizada);
      }
    }
  };

  const validarRotaCustomizada = (rota: string[]): boolean => {
    if (rota.length < 2) return false;

    // Verificar se todos os estados existem
    const estadosValidos = estados.map(e => e.sigla);
    return rota.every(uf => estadosValidos.includes(uf));
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

      {/* Opções de Rotas Disponíveis */}
      {opcoesRotas.length > 0 && (
        <div style={{
          marginTop: '2rem',
          padding: '2rem',
          background: theme === 'dark'
            ? 'linear-gradient(135deg, #1f2937 0%, #111827 100%)'
            : 'linear-gradient(135deg, #ffffff 0%, #f8fafc 100%)',
          borderRadius: '16px',
          border: theme === 'dark'
            ? '2px solid rgba(55, 65, 81, 0.8)'
            : '2px solid rgba(229, 231, 235, 0.8)',
          boxShadow: theme === 'dark'
            ? '0 8px 32px rgba(0, 0, 0, 0.3)'
            : '0 8px 32px rgba(0, 0, 0, 0.1)',
          position: 'relative',
          overflow: 'hidden'
        }}>
          {/* Header com ícone e título */}
          <div style={{
            display: 'flex',
            alignItems: 'center',
            gap: '1rem',
            marginBottom: '1.5rem',
            paddingBottom: '1rem',
            borderBottom: `2px solid ${theme === 'dark' ? '#374151' : '#e5e7eb'}`
          }}>
            <div style={{
              width: '48px',
              height: '48px',
              background: 'linear-gradient(135deg, #059669, #047857)',
              borderRadius: '12px',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              color: 'white',
              fontSize: '1.25rem',
              boxShadow: '0 4px 12px rgba(5, 150, 105, 0.3)'
            }}>
              <Icon name="route" />
            </div>
            <div>
              <h6 style={{
                margin: 0,
                fontSize: '1.125rem',
                fontWeight: '700',
                color: 'var(--color-text-primary)',
                letterSpacing: '-0.025em'
              }}>
                Seleção de Percurso Fiscal
              </h6>
              <p style={{
                margin: '0.25rem 0 0 0',
                fontSize: '0.875rem',
                color: 'var(--color-text-secondary)',
                fontWeight: '500'
              }}>
                Configure o trajeto para emissão do Manifesto Eletrônico de Documentos Fiscais
              </p>
            </div>
          </div>

          <div style={{
            background: theme === 'dark'
              ? 'rgba(16, 185, 129, 0.1)'
              : 'rgba(16, 185, 129, 0.05)',
            border: `1px solid ${theme === 'dark' ? 'rgba(16, 185, 129, 0.3)' : 'rgba(16, 185, 129, 0.2)'}`,
            borderRadius: '8px',
            padding: '0.75rem 1rem',
            marginBottom: '1.5rem',
            display: 'flex',
            alignItems: 'center',
            gap: '0.75rem'
          }}>
            <div style={{
              width: '24px',
              height: '24px',
              background: '#10b981',
              borderRadius: '50%',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              flexShrink: 0
            }}>
              <Icon name="info" style={{ fontSize: '0.75rem', color: 'white' }} />
            </div>
            <p style={{
              margin: 0,
              fontSize: '0.875rem',
              color: 'var(--color-text-primary)',
              fontWeight: '500',
              lineHeight: '1.4'
            }}>
              <strong>Importante:</strong> Selecione o percurso que será utilizado para o transporte. Esta informação será registrada no MDF-e conforme legislação fiscal vigente.
            </p>
          </div>

          <div style={{ display: 'flex', flexDirection: 'column', gap: '1rem' }}>
            {opcoesRotas.map((opcao) => (
              <div
                key={opcao.id}
                onClick={() => selecionarRota(opcao.id)}
                style={{
                  padding: '1.25rem',
                  border: rotaSelecionada === opcao.id
                    ? '2px solid #059669'
                    : `2px solid ${theme === 'dark' ? '#374151' : '#e5e7eb'}`,
                  borderRadius: '12px',
                  background: rotaSelecionada === opcao.id
                    ? theme === 'dark'
                      ? 'rgba(5, 150, 105, 0.15)'
                      : 'rgba(5, 150, 105, 0.08)'
                    : theme === 'dark'
                      ? 'rgba(55, 65, 81, 0.3)'
                      : 'rgba(255, 255, 255, 0.8)',
                  cursor: 'pointer',
                  transition: 'all 0.3s ease',
                  position: 'relative',
                  boxShadow: rotaSelecionada === opcao.id
                    ? '0 4px 20px rgba(5, 150, 105, 0.2)'
                    : theme === 'dark'
                      ? '0 2px 8px rgba(0, 0, 0, 0.3)'
                      : '0 2px 8px rgba(0, 0, 0, 0.08)'
                }}
                onMouseEnter={(e) => {
                  if (rotaSelecionada !== opcao.id) {
                    e.currentTarget.style.background = theme === 'dark'
                      ? 'rgba(55, 65, 81, 0.5)'
                      : 'rgba(249, 250, 251, 1)';
                    e.currentTarget.style.borderColor = '#059669';
                    e.currentTarget.style.boxShadow = '0 4px 16px rgba(5, 150, 105, 0.15)';
                    e.currentTarget.style.transform = 'translateY(-2px)';
                  }
                }}
                onMouseLeave={(e) => {
                  if (rotaSelecionada !== opcao.id) {
                    e.currentTarget.style.background = theme === 'dark'
                      ? 'rgba(55, 65, 81, 0.3)'
                      : 'rgba(255, 255, 255, 0.8)';
                    e.currentTarget.style.borderColor = theme === 'dark' ? '#374151' : '#e5e7eb';
                    e.currentTarget.style.boxShadow = theme === 'dark'
                      ? '0 2px 8px rgba(0, 0, 0, 0.3)'
                      : '0 2px 8px rgba(0, 0, 0, 0.08)';
                    e.currentTarget.style.transform = 'translateY(0)';
                  }
                }}
              >
                {opcao.recomendada && (
                  <div style={{
                    position: 'absolute',
                    top: '-8px',
                    right: '16px',
                    background: '#10b981',
                    color: 'white',
                    fontSize: '0.7rem',
                    fontWeight: '600',
                    padding: '0.25rem 0.75rem',
                    borderRadius: '12px',
                    textTransform: 'uppercase',
                    letterSpacing: '0.05em'
                  }}>
                    Recomendada
                  </div>
                )}

                <div style={{
                  display: 'flex',
                  justifyContent: 'space-between',
                  alignItems: 'flex-start',
                  marginBottom: '0.75rem'
                }}>
                  <div>
                    <div style={{
                      margin: 0,
                      fontSize: '0.9rem',
                      fontWeight: '700',
                      color: 'var(--color-text-primary)',
                      display: 'flex',
                      alignItems: 'center',
                      gap: '0.5rem'
                    }}>
                      {rotaSelecionada === opcao.id && <Icon name="check-circle" style={{ color: '#10b981' }} />}
                      {opcao.nome}
                    </div>
                  </div>
                  <div style={{
                    display: 'flex',
                    gap: '1rem',
                    fontSize: '0.75rem',
                    color: 'var(--color-text-secondary)'
                  }}>
                    <span>~{opcao.distancia.toLocaleString()} km</span>
                    <span>{opcao.estados} estados</span>
                  </div>
                </div>

                <div style={{
                  display: 'flex',
                  flexWrap: 'wrap',
                  gap: '0.5rem'
                }}>
                  {opcao.percurso.map((uf, index) => (
                    <span
                      key={`${opcao.id}_${uf}_${index}`}
                      style={{
                        padding: '0.375rem 1rem',
                        background: index === 0 ? 'rgba(16, 185, 129, 0.2)' :
                                   index === opcao.percurso.length - 1 ? 'rgba(239, 68, 68, 0.2)' :
                                   'rgba(59, 130, 246, 0.2)',
                        color: 'var(--color-text-primary)',
                        borderRadius: '20px',
                        fontSize: '0.875rem',
                        fontWeight: '700',
                        display: 'flex',
                        alignItems: 'center',
                        gap: '0.375rem',
                        minWidth: '3rem',
                        justifyContent: 'center'
                      }}
                    >
                      {index === 0 && <Icon name="play" style={{ fontSize: '0.75rem' }} />}
                      {index === opcao.percurso.length - 1 && <Icon name="flag" style={{ fontSize: '0.75rem' }} />}
                      {uf}
                      {index < opcao.percurso.length - 1 && (
                        <Icon name="arrow-right" style={{ fontSize: '0.75rem' }} />
                      )}
                    </span>
                  ))}
                </div>
              </div>
            ))}
          </div>

          {/* Botão para ativar modo customizado */}
          {!modoCustomizado && (
            <div style={{ marginTop: '1rem', textAlign: 'center' }}>
              <button
                type="button"
                onClick={ativarModoCustomizado}
                style={{
                  display: 'flex',
                  alignItems: 'center',
                  gap: '0.5rem',
                  padding: '0.75rem 1.5rem',
                  background: theme === 'dark'
                    ? 'linear-gradient(135deg, #7c3aed, #5b21b6)'
                    : 'linear-gradient(135deg, #8b5cf6, #7c3aed)',
                  color: 'white',
                  border: 'none',
                  borderRadius: '8px',
                  cursor: 'pointer',
                  fontWeight: '600',
                  fontSize: '0.875rem',
                  margin: '0 auto',
                  transition: 'all 0.3s ease',
                  boxShadow: '0 4px 12px rgba(139, 92, 246, 0.3)'
                }}
                onMouseEnter={(e) => {
                  e.currentTarget.style.transform = 'translateY(-2px)';
                  e.currentTarget.style.boxShadow = '0 6px 20px rgba(139, 92, 246, 0.4)';
                }}
                onMouseLeave={(e) => {
                  e.currentTarget.style.transform = 'translateY(0)';
                  e.currentTarget.style.boxShadow = '0 4px 12px rgba(139, 92, 246, 0.3)';
                }}
              >
                <Icon name="edit" />
                Criar Rota Personalizada
              </button>
            </div>
          )}

          {/* Interface para rota customizada */}
          {modoCustomizado && (
            <div style={{
              marginTop: '1.5rem',
              padding: '1.5rem',
              background: theme === 'dark'
                ? 'rgba(124, 58, 237, 0.1)'
                : 'rgba(139, 92, 246, 0.05)',
              border: `2px solid ${theme === 'dark' ? 'rgba(124, 58, 237, 0.3)' : 'rgba(139, 92, 246, 0.2)'}`,
              borderRadius: '12px'
            }}>
              <div style={{
                display: 'flex',
                alignItems: 'center',
                gap: '1rem',
                marginBottom: '1rem',
                paddingBottom: '1rem',
                borderBottom: `1px solid ${theme === 'dark' ? 'rgba(124, 58, 237, 0.3)' : 'rgba(139, 92, 246, 0.2)'}`
              }}>
                <div style={{
                  width: '32px',
                  height: '32px',
                  background: 'linear-gradient(135deg, #8b5cf6, #7c3aed)',
                  borderRadius: '8px',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  color: 'white'
                }}>
                  <Icon name="edit" />
                </div>
                <h6 style={{
                  margin: 0,
                  fontSize: '1rem',
                  fontWeight: '700',
                  color: 'var(--color-text-primary)'
                }}>
                  Rota Personalizada
                </h6>
              </div>

              {/* Estados da rota customizada */}
              <div style={{ marginBottom: '1rem' }}>
                <label style={{
                  display: 'block',
                  fontSize: '0.875rem',
                  fontWeight: '600',
                  color: 'var(--color-text-primary)',
                  marginBottom: '0.5rem'
                }}>
                  Percurso Atual:
                </label>
                <div style={{
                  display: 'flex',
                  flexWrap: 'wrap',
                  gap: '0.5rem',
                  minHeight: '2.5rem',
                  padding: '0.75rem',
                  border: `2px solid ${theme === 'dark' ? '#4b5563' : '#e5e7eb'}`,
                  borderRadius: '8px',
                  background: theme === 'dark' ? '#374151' : '#f9fafb'
                }}>
                  {rotaCustomizada.length > 0 ? (
                    rotaCustomizada.map((uf, index) => (
                      <span
                        key={`custom_${uf}_${index}`}
                        style={{
                          display: 'flex',
                          alignItems: 'center',
                          gap: '0.5rem',
                          padding: '0.375rem 0.75rem',
                          background: index === 0
                            ? 'linear-gradient(135deg, #10b981, #059669)'
                            : index === rotaCustomizada.length - 1
                              ? 'linear-gradient(135deg, #ef4444, #dc2626)'
                              : 'linear-gradient(135deg, #3b82f6, #1d4ed8)',
                          color: 'white',
                          borderRadius: '6px',
                          fontSize: '0.8rem',
                          fontWeight: '600'
                        }}
                      >
                        {index === 0 && <Icon name="play" style={{ fontSize: '0.7rem' }} />}
                        {index === rotaCustomizada.length - 1 && <Icon name="flag" style={{ fontSize: '0.7rem' }} />}
                        {uf}
                        {index > 0 && index < rotaCustomizada.length - 1 && (
                          <button
                            onClick={() => removerEstadoCustomizado(index)}
                            style={{
                              width: '16px',
                              height: '16px',
                              background: 'rgba(255, 255, 255, 0.2)',
                              border: 'none',
                              borderRadius: '50%',
                              color: 'white',
                              cursor: 'pointer',
                              fontSize: '0.7rem',
                              display: 'flex',
                              alignItems: 'center',
                              justifyContent: 'center'
                            }}
                          >
                            ×
                          </button>
                        )}
                      </span>
                    ))
                  ) : (
                    <span style={{
                      color: 'var(--color-text-secondary)',
                      fontSize: '0.875rem',
                      fontStyle: 'italic'
                    }}>
                      Nenhum estado adicionado ainda
                    </span>
                  )}
                </div>
              </div>

              {/* Adicionar novo estado */}
              <div style={{
                display: 'flex',
                gap: '1rem',
                marginBottom: '1rem'
              }}>
                <select
                  value={novoEstadoCustomizado}
                  onChange={(e) => setNovoEstadoCustomizado(e.target.value)}
                  style={{
                    flex: 1,
                    padding: '0.75rem',
                    border: `2px solid ${theme === 'dark' ? '#4b5563' : '#e5e7eb'}`,
                    borderRadius: '8px',
                    fontSize: '0.875rem',
                    background: theme === 'dark' ? '#374151' : 'white',
                    color: theme === 'dark' ? '#f9fafb' : '#1f2937'
                  }}
                >
                  <option value="">Selecione um estado para adicionar</option>
                  {estados
                    .filter(estado => !rotaCustomizada.includes(estado.sigla))
                    .map(estado => (
                      <option key={estado.sigla} value={estado.sigla}>
                        {estado.sigla} - {estado.nome}
                      </option>
                    ))}
                </select>
                <button
                  onClick={adicionarEstadoCustomizado}
                  disabled={!novoEstadoCustomizado}
                  style={{
                    padding: '0.75rem 1.5rem',
                    background: novoEstadoCustomizado
                      ? 'linear-gradient(135deg, #10b981, #059669)'
                      : 'var(--color-border)',
                    color: novoEstadoCustomizado ? 'white' : 'var(--color-text-secondary)',
                    border: 'none',
                    borderRadius: '8px',
                    cursor: novoEstadoCustomizado ? 'pointer' : 'not-allowed',
                    fontWeight: '600',
                    fontSize: '0.875rem',
                    display: 'flex',
                    alignItems: 'center',
                    gap: '0.5rem'
                  }}
                >
                  <Icon name="plus" />
                  Adicionar
                </button>
              </div>

              {/* Ações */}
              <div style={{
                display: 'flex',
                gap: '1rem',
                justifyContent: 'flex-end'
              }}>
                <button
                  onClick={() => setModoCustomizado(false)}
                  style={{
                    padding: '0.75rem 1.5rem',
                    background: 'transparent',
                    color: 'var(--color-text-secondary)',
                    border: `2px solid ${theme === 'dark' ? '#4b5563' : '#e5e7eb'}`,
                    borderRadius: '8px',
                    cursor: 'pointer',
                    fontWeight: '600',
                    fontSize: '0.875rem'
                  }}
                >
                  Cancelar
                </button>
                <button
                  onClick={finalizarRotaCustomizada}
                  disabled={rotaCustomizada.length < 2}
                  style={{
                    padding: '0.75rem 1.5rem',
                    background: rotaCustomizada.length >= 2
                      ? 'linear-gradient(135deg, #8b5cf6, #7c3aed)'
                      : 'var(--color-border)',
                    color: rotaCustomizada.length >= 2 ? 'white' : 'var(--color-text-secondary)',
                    border: 'none',
                    borderRadius: '8px',
                    cursor: rotaCustomizada.length >= 2 ? 'pointer' : 'not-allowed',
                    fontWeight: '600',
                    fontSize: '0.875rem',
                    display: 'flex',
                    alignItems: 'center',
                    gap: '0.5rem'
                  }}
                >
                  <Icon name="check" />
                  Confirmar Rota
                </button>
              </div>
            </div>
          )}

          <div style={{
            marginTop: '1.5rem',
            padding: '1rem',
            background: theme === 'dark'
              ? 'rgba(55, 65, 81, 0.3)'
              : 'rgba(249, 250, 251, 0.8)',
            border: `1px solid ${theme === 'dark' ? '#4b5563' : '#d1d5db'}`,
            borderRadius: '8px',
            display: 'flex',
            alignItems: 'flex-start',
            gap: '0.75rem'
          }}>
            <div style={{
              width: '20px',
              height: '20px',
              background: '#3b82f6',
              borderRadius: '50%',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              flexShrink: 0,
              marginTop: '0.125rem'
            }}>
              <Icon name="lightbulb" style={{ fontSize: '0.675rem', color: 'white' }} />
            </div>
            <div>
              <p style={{
                margin: '0 0 0.25rem 0',
                fontSize: '0.8rem',
                color: 'var(--color-text-primary)',
                fontWeight: '600'
              }}>
                Informações Técnicas
              </p>
              <p style={{
                margin: 0,
                fontSize: '0.75rem',
                color: 'var(--color-text-secondary)',
                lineHeight: '1.4'
              }}>
                As rotas são calculadas considerando as divisas estaduais e legislação de trânsito interestadual.
                A seleção do percurso adequado otimiza o cumprimento das obrigações fiscais do MDF-e.
              </p>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}