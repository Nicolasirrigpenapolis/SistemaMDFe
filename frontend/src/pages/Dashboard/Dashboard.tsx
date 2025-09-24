import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import styles from './Dashboard.module.css';
import { entitiesService } from '../../services/entitiesService';
import { mdfeService } from '../../services/mdfeService';
import { localidadeService } from '../../services/localidadeService';

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
  const [carregando, setCarregando] = useState(false);

  useEffect(() => {
    carregarDadosDashboard();
  }, []);

  const carregarDadosDashboard = async () => {
    try {
      setCarregando(true);

      // Carregar dados em paralelo usando services
      const [
        emitentesRes,
        veiculosRes,
        condutoresRes,
        contratantesRes,
        seguradorasRes,
        municipiosRes,
        mdfesRes
      ] = await Promise.allSettled([
        entitiesService.obterEmitentes(),
        entitiesService.obterVeiculos(),
        entitiesService.obterCondutores(),
        entitiesService.obterDestinatarios(), // Contratantes
        entitiesService.obterSeguradoras(),
        fetch('https://localhost:5001/api/municipios?tamanhoPagina=1&pagina=1').then(res => res.json()),
        mdfeService.listarMDFes({ tamanhoPagina: 1000 })
      ]);

      // Processar emitentes
      let emitentes: any[] = [];
      if (emitentesRes.status === 'fulfilled') {
        emitentes = emitentesRes.value || [];
      }

      // Processar veículos
      let veiculos: any[] = [];
      if (veiculosRes.status === 'fulfilled') {
        veiculos = veiculosRes.value || [];
      }

      // Processar condutores
      let condutores: any[] = [];
      if (condutoresRes.status === 'fulfilled') {
        condutores = condutoresRes.value || [];
      }

      // Processar contratantes
      let contratantes: any[] = [];
      if (contratantesRes.status === 'fulfilled') {
        contratantes = contratantesRes.value || [];
      }

      // Processar seguradoras
      let seguradoras: any[] = [];
      if (seguradorasRes.status === 'fulfilled') {
        seguradoras = seguradorasRes.value || [];
      }

      // Processar municípios
      let totalMunicipios = 0;
      if (municipiosRes.status === 'fulfilled') {
        const municipiosData = municipiosRes.value;
        totalMunicipios = municipiosData?.totalItens || 0;
      }

      // Processar MDFes
      let mdfes: any[] = [];
      if (mdfesRes.status === 'fulfilled' && mdfesRes.value.sucesso && mdfesRes.value.dados) {
        const dados = mdfesRes.value.dados;
        mdfes = dados.Itens || dados.Items || dados.itens || dados.items || dados || [];
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
        totalMunicipios: totalMunicipios, // Total real de municípios da API
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
      <div className={styles.dashboardContainer}>
        <div className={styles.loading}>
          <div className={styles.loadingSpinner}></div>
          <p>Carregando dados do dashboard...</p>
        </div>
      </div>
    );
  }

  return (
    <div className={styles.dashboardContainer}>
      {/* Header */}
      <div className={styles.header}>
        <div className={styles.headerContent}>
          <div className={styles.titleSection}>
            <div className={styles.iconWrapper}>
              <i className="fas fa-chart-pie"></i>
            </div>
            <div className={styles.titleContent}>
              <h1 className={styles.title}>Dashboard</h1>
              <p className={styles.subtitle}>Visão geral completa do sistema MDF-e</p>
            </div>
          </div>

          <button
            className={styles.btnNovo}
            onClick={() => navigate('/mdfes/novo')}
          >
            <i className="fas fa-plus"></i>
            <span>Emitir MDF-e</span>
          </button>
        </div>
      </div>

      {/* Main Stats */}
      <div className={styles.statsGrid}>
        <div className={styles.statCard} onClick={() => handleNavigate('mdfes')}>
          <div className={styles.statHeader}>
            <div className={styles.statIcon}>
              <i className="fas fa-file-alt"></i>
            </div>
            <div className={styles.statTrend}>
              <i className="fas fa-arrow-up"></i>
            </div>
          </div>
          <div className={styles.statContent}>
            <div className={styles.statNumber}>{stats.totalMDFes}</div>
            <div className={styles.statLabel}>Total MDF-es</div>
          </div>
        </div>

        <div className={styles.statCard}>
          <div className={styles.statHeader}>
            <div className={`${styles.statIcon} ${styles.success}`}>
              <i className="fas fa-check-circle"></i>
            </div>
            <div className={styles.statTrend}>
              <i className="fas fa-arrow-up"></i>
            </div>
          </div>
          <div className={styles.statContent}>
            <div className={styles.statNumber}>{stats.mdfesAutorizados}</div>
            <div className={styles.statLabel}>Autorizados</div>
          </div>
        </div>

        <div className={styles.statCard}>
          <div className={styles.statHeader}>
            <div className={`${styles.statIcon} ${styles.warning}`}>
              <i className="fas fa-clock"></i>
            </div>
            <div className={styles.statTrend}>
              <i className="fas fa-minus"></i>
            </div>
          </div>
          <div className={styles.statContent}>
            <div className={styles.statNumber}>{stats.mdfesPendentes}</div>
            <div className={styles.statLabel}>Pendentes</div>
          </div>
        </div>

        <div className={styles.statCard} onClick={() => handleNavigate('emitentes')}>
          <div className={styles.statHeader}>
            <div className={styles.statIcon}>
              <i className="fas fa-building"></i>
            </div>
          </div>
          <div className={styles.statContent}>
            <div className={styles.statNumber}>{stats.totalEmitentes}</div>
            <div className={styles.statLabel}>Emitentes</div>
          </div>
        </div>

        <div className={styles.statCard} onClick={() => handleNavigate('veiculos')}>
          <div className={styles.statHeader}>
            <div className={styles.statIcon}>
              <i className="fas fa-truck"></i>
            </div>
          </div>
          <div className={styles.statContent}>
            <div className={styles.statNumber}>{stats.totalVeiculos}</div>
            <div className={styles.statLabel}>Veículos</div>
          </div>
        </div>

        <div className={styles.statCard} onClick={() => handleNavigate('condutores')}>
          <div className={styles.statHeader}>
            <div className={styles.statIcon}>
              <i className="fas fa-users"></i>
            </div>
          </div>
          <div className={styles.statContent}>
            <div className={styles.statNumber}>{stats.totalCondutores}</div>
            <div className={styles.statLabel}>Condutores</div>
          </div>
        </div>
      </div>

      {/* Main Content */}
      <div className={styles.mainContent}>
        <div className={styles.contentGrid}>
          {/* Recent MDFes */}
          <div className={styles.recentMDFes}>
            <div className={styles.cardHeader}>
              <div className={styles.cardTitle}>
                <i className="fas fa-history"></i>
                <span>Atividade Recente</span>
              </div>
              <button
                className={styles.viewAllBtn}
                onClick={() => handleNavigate('mdfes')}
              >
                Ver todos
                <i className="fas fa-arrow-right"></i>
              </button>
            </div>

            {recentMDFes.length === 0 ? (
              <div className={styles.emptyState}>
                <div className={styles.emptyIcon}>
                  <i className="fas fa-file-alt"></i>
                </div>
                <h3>Nenhum MDF-e emitido</h3>
                <p>Comece emitindo seu primeiro manifesto eletrônico</p>
                <button
                  className={styles.primaryBtn}
                  onClick={() => handleNavigate('mdfe-editor')}
                >
                  <i className="fas fa-plus"></i>
                  Emitir primeiro MDF-e
                </button>
              </div>
            ) : (
              <div className={styles.mdfList}>
                {recentMDFes.map((mdfe) => {
                  const statusConfig = getStatusConfig(mdfe.status);
                  return (
                    <div key={mdfe.id} className={styles.mdfItem}>
                      <div className={styles.mdfInfo}>
                        <div className={styles.mdfNumber}>
                          MDF-e Nº {mdfe.numero}/{mdfe.serie}
                        </div>
                        <div className={styles.mdfDetails}>
                          <span>{mdfe.emitenteNome}</span>
                          <span>{formatDate(mdfe.dataEmissao)}</span>
                          {mdfe.valorCarga && <span>{formatCurrency(mdfe.valorCarga)}</span>}
                        </div>
                      </div>
                      <div className={`${styles.statusBadge} ${styles[statusConfig.color]}`}>
                        <i className={statusConfig.icon}></i>
                        {mdfe.status}
                      </div>
                    </div>
                  );
                })}
              </div>
            )}
          </div>

          {/* Quick Actions & System Info */}
          <div className={styles.sidebar}>
            {/* Quick Actions */}
            <div className={styles.quickActions}>
              <div className={styles.cardHeader}>
                <div className={styles.cardTitle}>
                  <i className="fas fa-bolt"></i>
                  <span>Ações Rápidas</span>
                </div>
              </div>

              <div className={styles.actionsList}>
                <button
                  className={styles.actionBtn}
                  onClick={() => handleNavigate('mdfe-editor')}
                >
                  <div className={styles.actionIcon}>
                    <i className="fas fa-plus"></i>
                  </div>
                  <div className={styles.actionContent}>
                    <span className={styles.actionTitle}>Novo MDF-e</span>
                    <span className={styles.actionDesc}>Emitir manifesto</span>
                  </div>
                  <i className="fas fa-chevron-right"></i>
                </button>

                <button
                  className={styles.actionBtn}
                  onClick={() => handleNavigate('veiculos')}
                >
                  <div className={styles.actionIcon}>
                    <i className="fas fa-truck"></i>
                  </div>
                  <div className={styles.actionContent}>
                    <span className={styles.actionTitle}>Veículos</span>
                    <span className={styles.actionDesc}>Gerenciar frota</span>
                  </div>
                  <i className="fas fa-chevron-right"></i>
                </button>

                <button
                  className={styles.actionBtn}
                  onClick={() => handleNavigate('condutores')}
                >
                  <div className={styles.actionIcon}>
                    <i className="fas fa-users"></i>
                  </div>
                  <div className={styles.actionContent}>
                    <span className={styles.actionTitle}>Condutores</span>
                    <span className={styles.actionDesc}>Motoristas</span>
                  </div>
                  <i className="fas fa-chevron-right"></i>
                </button>

                <button
                  className={styles.actionBtn}
                  onClick={() => handleNavigate('emitentes')}
                >
                  <div className={styles.actionIcon}>
                    <i className="fas fa-building"></i>
                  </div>
                  <div className={styles.actionContent}>
                    <span className={styles.actionTitle}>Emitentes</span>
                    <span className={styles.actionDesc}>Empresas</span>
                  </div>
                  <i className="fas fa-chevron-right"></i>
                </button>
              </div>
            </div>

            {/* System Summary */}
            <div className={styles.systemSummary}>
              <div className={styles.cardHeader}>
                <div className={styles.cardTitle}>
                  <i className="fas fa-chart-bar"></i>
                  <span>Resumo</span>
                </div>
              </div>

              <div className={styles.summaryList}>
                <div className={styles.summaryItem}>
                  <span>Contratantes</span>
                  <span className={styles.summaryValue}>{stats.totalContratantes}</span>
                </div>
                <div className={styles.summaryItem}>
                  <span>Seguradoras</span>
                  <span className={styles.summaryValue}>{stats.totalSeguradoras}</span>
                </div>
                <div className={styles.summaryItem}>
                  <span>Municípios</span>
                  <span className={styles.summaryValue}>{stats.totalMunicipios}</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};