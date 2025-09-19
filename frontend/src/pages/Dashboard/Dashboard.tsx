import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import styles from './Dashboard.module.css';

interface DashboardStats {
  totalMDFes: number;
  mdfesPendentes: number;
  mdfesAutorizados: number;
  totalVeiculos: number;
  veiculosAtivos: number;
  totalCondutores: number;
  condutoresAtivos: number;
  totalEmitentes: number;
  emitentesAtivos: number;
  totalContratantes: number;
  totalSeguradoras: number;
  totalMunicipios: number;
}

interface RecentMDFe {
  id: number;
  numero: string;
  serie: string;
  dataEmissao: string;
  status: string;
  emitenteNome?: string;
  valorCarga?: number;
}

export function Dashboard() {
  const navigate = useNavigate();
  const [stats, setStats] = useState<DashboardStats>({
    totalMDFes: 0,
    mdfesPendentes: 0,
    mdfesAutorizados: 0,
    totalVeiculos: 0,
    veiculosAtivos: 0,
    totalCondutores: 0,
    condutoresAtivos: 0,
    totalEmitentes: 0,
    emitentesAtivos: 0,
    totalContratantes: 0,
    totalSeguradoras: 0,
    totalMunicipios: 0,
  });
  const [recentMDFes, setRecentMDFes] = useState<RecentMDFe[]>([]);
  const [carregando, setCarregando] = useState(true);

  useEffect(() => {
    carregarDadosDashboard();
  }, []);

  const carregarDadosDashboard = async () => {
    try {
      setCarregando(true);
      const API_BASE_URL = process.env.REACT_APP_API_URL || 'https://localhost:5001/api';

      // Carregar dados em paralelo
      const [
        emitentesRes,
        veiculosRes,
        condutoresRes,
        contratantesRes,
        seguradorasRes,
        municipiosRes,
        mdfesRes
      ] = await Promise.allSettled([
        fetch(`${API_BASE_URL}/emitentes`),
        fetch(`${API_BASE_URL}/veiculos`),
        fetch(`${API_BASE_URL}/condutores`),
        fetch(`${API_BASE_URL}/contratantes`),
        fetch(`${API_BASE_URL}/seguradoras`),
        fetch(`${API_BASE_URL}/municipios`),
        fetch(`${API_BASE_URL}/mdfe`)
      ]);

      // Processar emitentes
      let emitentes = [];
      if (emitentesRes.status === 'fulfilled' && emitentesRes.value.ok) {
        const data = await emitentesRes.value.json();
        emitentes = Array.isArray(data) ? data : (data?.items || data?.data || []);
      }

      // Processar veículos
      let veiculos = [];
      if (veiculosRes.status === 'fulfilled' && veiculosRes.value.ok) {
        const data = await veiculosRes.value.json();
        veiculos = Array.isArray(data) ? data : (data?.items || data?.data || []);
      }

      // Processar condutores
      let condutores = [];
      if (condutoresRes.status === 'fulfilled' && condutoresRes.value.ok) {
        const data = await condutoresRes.value.json();
        condutores = Array.isArray(data) ? data : (data?.items || data?.data || []);
      }

      // Processar contratantes
      let contratantes = [];
      if (contratantesRes.status === 'fulfilled' && contratantesRes.value.ok) {
        const data = await contratantesRes.value.json();
        contratantes = Array.isArray(data) ? data : (data?.items || data?.data || []);
      }

      // Processar seguradoras
      let seguradoras = [];
      if (seguradorasRes.status === 'fulfilled' && seguradorasRes.value.ok) {
        const data = await seguradorasRes.value.json();
        seguradoras = Array.isArray(data) ? data : (data?.items || data?.data || []);
      }

      // Processar municípios
      let municipios = [];
      if (municipiosRes.status === 'fulfilled' && municipiosRes.value.ok) {
        const data = await municipiosRes.value.json();
        municipios = Array.isArray(data) ? data : (data?.items || data?.data || []);
      }

      // Processar MDFes
      let mdfes = [];
      if (mdfesRes.status === 'fulfilled' && mdfesRes.value.ok) {
        const data = await mdfesRes.value.json();
        mdfes = Array.isArray(data) ? data : (data?.items || data?.data || []);
      }

      // Calcular estatísticas
      setStats({
        totalMDFes: mdfes.length,
        mdfesPendentes: mdfes.filter((m: any) => m.status === 'Pendente').length,
        mdfesAutorizados: mdfes.filter((m: any) => m.status === 'Autorizado').length,
        totalVeiculos: veiculos.length,
        veiculosAtivos: veiculos.filter((v: any) => v.ativo).length,
        totalCondutores: condutores.length,
        condutoresAtivos: condutores.filter((c: any) => c.ativo).length,
        totalEmitentes: emitentes.length,
        emitentesAtivos: emitentes.filter((e: any) => e.ativo).length,
        totalContratantes: contratantes.length,
        totalSeguradoras: seguradoras.length,
        totalMunicipios: municipios.length,
      });

      // Definir MDFes recentes (últimos 5)
      const mdfesRecentes = mdfes
        .sort((a: any, b: any) => new Date(b.dataEmissao).getTime() - new Date(a.dataEmissao).getTime())
        .slice(0, 5);
      setRecentMDFes(mdfesRecentes);

    } catch (error) {
      console.error('Erro ao carregar dados do dashboard:', error);
    } finally {
      setCarregando(false);
    }
  };

  const handleNavigate = (page: string) => {
    navigate(`/${page}`);
  };

  const getStatusConfig = (status: string) => {
    switch (status) {
      case 'Autorizado':
        return { color: 'success', icon: 'fas fa-check-circle', bgColor: '#dcfce7', textColor: '#166534' };
      case 'Pendente':
        return { color: 'warning', icon: 'fas fa-clock', bgColor: '#fef3c7', textColor: '#92400e' };
      case 'Cancelado':
        return { color: 'danger', icon: 'fas fa-times-circle', bgColor: '#fee2e2', textColor: '#dc2626' };
      case 'Rejeitado':
        return { color: 'danger', icon: 'fas fa-exclamation-circle', bgColor: '#fee2e2', textColor: '#dc2626' };
      default:
        return { color: 'secondary', icon: 'fas fa-file-alt', bgColor: '#f3f4f6', textColor: '#6b7280' };
    }
  };

  const formatCurrency = (value: number) => {
    return new Intl.NumberFormat('pt-BR', {
      style: 'currency',
      currency: 'BRL'
    }).format(value);
  };

  const formatDate = (dateString: string) => {
    return new Date(dateString).toLocaleDateString('pt-BR', {
      day: '2-digit',
      month: '2-digit',
      year: 'numeric',
      hour: '2-digit',
      minute: '2-digit'
    });
  };

  if (carregando) {
    return (
      <div className="mdfe-list-container">
        <div className="loading-container">
          <div className="loading-spinner"></div>
          <p>Carregando dashboard...</p>
        </div>
      </div>
    );
  }

  return (
    <div className="mdfe-list-container">
      {/* Header */}
      <div className="mdfe-list-header">
        <div className="header-content">
          <div className="title-section">
            <i className="fas fa-tachometer-alt title-icon" style={{fontSize: '32px'}}></i>
            <div>
              <h1>Dashboard</h1>
              <p>Visão geral do sistema MDF-e</p>
            </div>
          </div>

          <button
            className={styles.btnNovo}
            onClick={() => navigate('/mdfes/novo')}
          >
            <i className="fas fa-plus" style={{fontSize: '20px'}}></i>
            <span>Novo MDF-e</span>
            <i className="fas fa-chevron-right" style={{fontSize: '16px'}}></i>
          </button>
        </div>

        {/* Dashboard Stats */}
        <div className="dashboard-stats">
          {/* MDFes */}
          <div className="stat-card" onClick={() => handleNavigate('mdfes')}>
            <div className="stat-icon">
              <i className="fas fa-file-alt" style={{fontSize: '18px'}}></i>
            </div>
            <div className="stat-content">
              <div className="stat-number">{stats.totalMDFes}</div>
              <div className="stat-label">Total MDF-es</div>
            </div>
          </div>

          <div className="stat-card">
            <div className="stat-icon stat-success">
              <i className="fas fa-check-circle" style={{fontSize: '18px'}}></i>
            </div>
            <div className="stat-content">
              <div className="stat-number">{stats.mdfesAutorizados}</div>
              <div className="stat-label">Autorizados</div>
            </div>
          </div>

          <div className="stat-card">
            <div className="stat-icon stat-warning">
              <i className="fas fa-clock" style={{fontSize: '18px'}}></i>
            </div>
            <div className="stat-content">
              <div className="stat-number">{stats.mdfesPendentes}</div>
              <div className="stat-label">Pendentes</div>
            </div>
          </div>

          {/* Emitentes */}
          <div className="stat-card" onClick={() => handleNavigate('emitentes')}>
            <div className="stat-icon">
              <i className="fas fa-building" style={{fontSize: '18px'}}></i>
            </div>
            <div className="stat-content">
              <div className="stat-number">{stats.totalEmitentes}</div>
              <div className="stat-label">Emitentes</div>
            </div>
          </div>

          {/* Veículos */}
          <div className="stat-card" onClick={() => handleNavigate('veiculos')}>
            <div className="stat-icon">
              <i className="fas fa-truck" style={{fontSize: '18px'}}></i>
            </div>
            <div className="stat-content">
              <div className="stat-number">{stats.totalVeiculos}</div>
              <div className="stat-label">Veículos</div>
            </div>
          </div>

          {/* Condutores */}
          <div className="stat-card" onClick={() => handleNavigate('condutores')}>
            <div className="stat-icon">
              <i className="fas fa-id-card" style={{fontSize: '18px'}}></i>
            </div>
            <div className="stat-content">
              <div className="stat-number">{stats.totalCondutores}</div>
              <div className="stat-label">Condutores</div>
            </div>
          </div>
        </div>
      </div>

      {/* Conteúdo */}
      <div className="mdfe-list-content">
        <div style={{ display: 'grid', gridTemplateColumns: '2fr 1fr', gap: '2rem' }}>
          {/* Últimos MDFes */}
          <div style={{
            background: 'rgba(255, 255, 255, 0.7)',
            backdropFilter: 'blur(10px)',
            borderRadius: '20px',
            padding: '1.5rem',
            border: '1px solid rgba(229, 231, 235, 0.8)',
            boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.1)'
          }}>
            <h3 style={{ marginBottom: '1.5rem', color: '#1f2937', display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
              <i className="fas fa-history" style={{fontSize: '20px'}}></i>
              Últimos MDF-es
            </h3>

            {recentMDFes.length === 0 ? (
              <div style={{ textAlign: 'center', padding: '2rem', color: '#6b7280' }}>
                <i className="fas fa-file-alt" style={{fontSize: '48px', marginBottom: '1rem', opacity: 0.5}}></i>
                <p>Nenhum MDF-e emitido ainda</p>
                <button
                  onClick={() => handleNavigate('mdfe-editor')}
                  style={{
                    background: '#3b82f6',
                    color: 'white',
                    border: 'none',
                    borderRadius: '8px',
                    padding: '0.5rem 1rem',
                    cursor: 'pointer',
                    marginTop: '1rem'
                  }}
                >
                  Criar primeiro MDF-e
                </button>
              </div>
            ) : (
              <div style={{ display: 'flex', flexDirection: 'column', gap: '1rem' }}>
                {recentMDFes.map((mdfe) => {
                  const statusConfig = getStatusConfig(mdfe.status);
                  return (
                    <div key={mdfe.id} style={{
                      display: 'flex',
                      alignItems: 'center',
                      padding: '1rem',
                      background: 'rgba(255, 255, 255, 0.5)',
                      borderRadius: '12px',
                      border: '1px solid rgba(229, 231, 235, 0.6)'
                    }}>
                      <div style={{ flex: 1 }}>
                        <div style={{ fontWeight: '600', marginBottom: '0.25rem' }}>
                          MDF-e Nº {mdfe.numero} - Série {mdfe.serie}
                        </div>
                        <div style={{ fontSize: '0.875rem', color: '#6b7280' }}>
                          {mdfe.emitenteNome} • {formatDate(mdfe.dataEmissao)}
                          {mdfe.valorCarga && ` • ${formatCurrency(mdfe.valorCarga)}`}
                        </div>
                      </div>
                      <div style={{
                        padding: '0.25rem 0.75rem',
                        borderRadius: '6px',
                        fontSize: '0.75rem',
                        fontWeight: '500',
                        backgroundColor: statusConfig.bgColor,
                        color: statusConfig.textColor,
                        display: 'flex',
                        alignItems: 'center',
                        gap: '0.25rem'
                      }}>
                        <i className={statusConfig.icon}></i>
                        {mdfe.status}
                      </div>
                    </div>
                  );
                })}
              </div>
            )}
          </div>

          {/* Ações Rápidas */}
          <div style={{
            background: 'rgba(255, 255, 255, 0.7)',
            backdropFilter: 'blur(10px)',
            borderRadius: '20px',
            padding: '1.5rem',
            border: '1px solid rgba(229, 231, 235, 0.8)',
            boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.1)'
          }}>
            <h3 style={{ marginBottom: '1.5rem', color: '#1f2937', display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
              <i className="fas fa-bolt" style={{fontSize: '20px'}}></i>
              Ações Rápidas
            </h3>

            <div style={{ display: 'flex', flexDirection: 'column', gap: '0.75rem' }}>
              <button
                onClick={() => handleNavigate('mdfe-editor')}
                style={{
                  display: 'flex',
                  alignItems: 'center',
                  gap: '0.75rem',
                  padding: '0.875rem 1rem',
                  background: '#3b82f6',
                  color: 'white',
                  border: 'none',
                  borderRadius: '10px',
                  cursor: 'pointer',
                  transition: 'all 0.2s',
                  fontWeight: '500'
                }}
                onMouseOver={(e) => e.currentTarget.style.background = '#2563eb'}
                onMouseOut={(e) => e.currentTarget.style.background = '#3b82f6'}
              >
                <i className="fas fa-plus"></i>
                Novo MDF-e
              </button>

              <button
                onClick={() => handleNavigate('veiculos')}
                style={{
                  display: 'flex',
                  alignItems: 'center',
                  gap: '0.75rem',
                  padding: '0.875rem 1rem',
                  background: 'rgba(255, 255, 255, 0.8)',
                  color: '#374151',
                  border: '1px solid rgba(229, 231, 235, 0.8)',
                  borderRadius: '10px',
                  cursor: 'pointer',
                  transition: 'all 0.2s',
                  fontWeight: '500'
                }}
              >
                <i className="fas fa-truck"></i>
                Gerenciar Veículos
              </button>

              <button
                onClick={() => handleNavigate('condutores')}
                style={{
                  display: 'flex',
                  alignItems: 'center',
                  gap: '0.75rem',
                  padding: '0.875rem 1rem',
                  background: 'rgba(255, 255, 255, 0.8)',
                  color: '#374151',
                  border: '1px solid rgba(229, 231, 235, 0.8)',
                  borderRadius: '10px',
                  cursor: 'pointer',
                  transition: 'all 0.2s',
                  fontWeight: '500'
                }}
              >
                <i className="fas fa-id-card"></i>
                Gerenciar Condutores
              </button>

              <button
                onClick={() => handleNavigate('emitentes')}
                style={{
                  display: 'flex',
                  alignItems: 'center',
                  gap: '0.75rem',
                  padding: '0.875rem 1rem',
                  background: 'rgba(255, 255, 255, 0.8)',
                  color: '#374151',
                  border: '1px solid rgba(229, 231, 235, 0.8)',
                  borderRadius: '10px',
                  cursor: 'pointer',
                  transition: 'all 0.2s',
                  fontWeight: '500'
                }}
              >
                <i className="fas fa-building"></i>
                Gerenciar Emitentes
              </button>
            </div>

            {/* Estatísticas complementares */}
            <div style={{ marginTop: '2rem', paddingTop: '1rem', borderTop: '1px solid rgba(229, 231, 235, 0.6)' }}>
              <h4 style={{ marginBottom: '1rem', color: '#6b7280', fontSize: '0.875rem', fontWeight: '600', textTransform: 'uppercase' }}>
                Resumo do Sistema
              </h4>
              <div style={{ display: 'flex', flexDirection: 'column', gap: '0.5rem', fontSize: '0.875rem', color: '#6b7280' }}>
                <div style={{ display: 'flex', justifyContent: 'space-between' }}>
                  <span>Contratantes:</span>
                  <span style={{ fontWeight: '600' }}>{stats.totalContratantes}</span>
                </div>
                <div style={{ display: 'flex', justifyContent: 'space-between' }}>
                  <span>Seguradoras:</span>
                  <span style={{ fontWeight: '600' }}>{stats.totalSeguradoras}</span>
                </div>
                <div style={{ display: 'flex', justifyContent: 'space-between' }}>
                  <span>Municípios:</span>
                  <span style={{ fontWeight: '600' }}>{stats.totalMunicipios}</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};