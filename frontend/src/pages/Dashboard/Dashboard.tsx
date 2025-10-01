import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { entitiesService } from '../../services/entitiesService';
import { mdfeService } from '../../services/mdfeService';
import Icon from '../../components/UI/Icon';

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
  valorTotal?: number;
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
        entitiesService.obterContratantes(), // Contratantes
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
      <div className="min-h-screen bg-bg-primary">
        <div className="flex items-center justify-center min-h-screen">
          <div className="text-center">
            <div className="animate-spin rounded-full h-16 w-16 border-b-2 border-primary mx-auto mb-4"></div>
            <p className="text-text-secondary font-medium">Carregando dados do dashboard...</p>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-bg-primary">
      {/* Header */}
      <div className="bg-bg-surface border-b border-border-primary mb-8">
        <div className="px-6 py-8">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-4">
              <div className="w-14 h-14 rounded-xl bg-gradient-to-br from-primary to-primary-hover flex items-center justify-center shadow-lg">
                <Icon name="chart-pie" color="white" size="lg" />
              </div>
              <div>
                <h1 className="text-3xl font-bold text-text-primary">Dashboard</h1>
                <p className="text-text-secondary font-medium">Visão geral completa do sistema MDF-e</p>
              </div>
            </div>

            <button
              className="flex items-center gap-2 px-6 py-3 bg-gradient-to-r from-primary to-primary-hover text-white rounded-lg hover:shadow-lg transition-all duration-200 font-medium"
              onClick={() => navigate('/mdfes/novo')}
            >
              <Icon name="plus" size="sm" />
              <span>Emitir MDF-e</span>
            </button>
          </div>
        </div>
      </div>

      {/* Main Stats */}
      <div className="px-6 mb-8">
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-6 gap-6">
          <div
            className="bg-bg-surface rounded-xl p-6 border border-border-primary hover:shadow-lg transition-all duration-200 cursor-pointer group"
            onClick={() => handleNavigate('mdfes')}
          >
            <div className="flex items-center justify-between mb-4">
              <div className="w-10 h-10 rounded-lg bg-blue-100 dark:bg-blue-900/30 flex items-center justify-center">
                <Icon name="file-alt" className="text-blue-600 dark:text-blue-400" size="sm" />
              </div>
              <Icon name="arrow-up" className="text-success w-4 h-4" />
            </div>
            <div className="text-2xl font-bold text-text-primary mb-1">{stats.totalMDFes}</div>
            <div className="text-sm text-text-secondary">Total MDF-es</div>
          </div>

          <div className="bg-bg-surface rounded-xl p-6 border border-border-primary hover:shadow-lg transition-all duration-200">
            <div className="flex items-center justify-between mb-4">
              <div className="w-10 h-10 rounded-lg bg-green-100 dark:bg-green-900/30 flex items-center justify-center">
                <Icon name="check-circle" className="text-success" size="sm" />
              </div>
              <Icon name="arrow-up" className="text-success w-4 h-4" />
            </div>
            <div className="text-2xl font-bold text-text-primary mb-1">{stats.mdfesAutorizados}</div>
            <div className="text-sm text-text-secondary">Autorizados</div>
          </div>

          <div className="bg-bg-surface rounded-xl p-6 border border-border-primary hover:shadow-lg transition-all duration-200">
            <div className="flex items-center justify-between mb-4">
              <div className="w-10 h-10 rounded-lg bg-warning-light dark:bg-warning/20 flex items-center justify-center">
                <Icon name="clock" className="text-warning" size="sm" />
              </div>
              <Icon name="minus" className="text-text-tertiary w-4 h-4" />
            </div>
            <div className="text-2xl font-bold text-text-primary mb-1">{stats.mdfesPendentes}</div>
            <div className="text-sm text-text-secondary">Pendentes</div>
          </div>

          <div
            className="bg-bg-surface rounded-xl p-6 border border-border-primary hover:shadow-lg transition-all duration-200 cursor-pointer"
            onClick={() => handleNavigate('emitentes')}
          >
            <div className="flex items-center justify-between mb-4">
              <div className="w-10 h-10 rounded-lg bg-purple-100 dark:bg-purple-900/30 flex items-center justify-center">
                <Icon name="building" className="text-purple-600 dark:text-purple-400" size="sm" />
              </div>
            </div>
            <div className="text-2xl font-bold text-text-primary mb-1">{stats.totalEmitentes}</div>
            <div className="text-sm text-text-secondary">Emitentes</div>
          </div>

          <div
            className="bg-bg-surface rounded-xl p-6 border border-border-primary hover:shadow-lg transition-all duration-200 cursor-pointer"
            onClick={() => handleNavigate('veiculos')}
          >
            <div className="flex items-center justify-between mb-4">
              <div className="w-10 h-10 rounded-lg bg-orange-100 dark:bg-orange-900/30 flex items-center justify-center">
                <Icon name="truck" className="text-orange-600 dark:text-orange-400" size="sm" />
              </div>
            </div>
            <div className="text-2xl font-bold text-text-primary mb-1">{stats.totalVeiculos}</div>
            <div className="text-sm text-text-secondary">Veículos</div>
          </div>

          <div
            className="bg-bg-surface rounded-xl p-6 border border-border-primary hover:shadow-lg transition-all duration-200 cursor-pointer"
            onClick={() => handleNavigate('condutores')}
          >
            <div className="flex items-center justify-between mb-4">
              <div className="w-10 h-10 rounded-lg bg-teal-100 dark:bg-teal-900/30 flex items-center justify-center">
                <Icon name="users" className="text-teal-600 dark:text-teal-400" size="sm" />
              </div>
            </div>
            <div className="text-2xl font-bold text-text-primary mb-1">{stats.totalCondutores}</div>
            <div className="text-sm text-text-secondary">Condutores</div>
          </div>
        </div>
      </div>

      {/* Main Content */}
      <div className="px-6">
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
          {/* Recent MDFes */}
          <div className="lg:col-span-2">
            <div className="bg-bg-surface rounded-xl border border-border-primary">
              <div className="flex items-center justify-between p-6 border-b border-border-primary">
                <div className="flex items-center gap-3">
                  <Icon name="history" className="text-text-secondary" size="sm" />
                  <span className="font-semibold text-text-primary">Atividade Recente</span>
                </div>
                <button
                  className="flex items-center gap-2 text-primary hover:text-primary-hover transition-colors duration-200 text-sm font-medium"
                  onClick={() => handleNavigate('mdfes')}
                >
                  Ver todos
                  <Icon name="arrow-right" size="sm" />
                </button>
              </div>

              {recentMDFes.length === 0 ? (
                <div className="flex flex-col items-center justify-center p-12 text-center">
                  <div className="w-16 h-16 rounded-full bg-bg-surface-hover flex items-center justify-center mb-4">
                    <Icon name="file-alt" className="text-text-tertiary" size="lg" />
                  </div>
                  <h3 className="text-lg font-semibold text-text-primary mb-2">Nenhum MDF-e emitido</h3>
                  <p className="text-text-secondary mb-6">Comece emitindo seu primeiro manifesto eletrônico</p>
                  <button
                    className="flex items-center gap-2 px-4 py-2 bg-gradient-to-r from-primary to-primary-hover text-white rounded-lg hover:shadow-lg transition-all duration-200 font-medium"
                    onClick={() => handleNavigate('mdfe-editor')}
                  >
                    <Icon name="plus" size="sm" />
                    Emitir primeiro MDF-e
                  </button>
                </div>
              ) : (
                <div className="p-6">
                  <div className="space-y-4">
                    {recentMDFes.map((mdfe) => {
                      const statusConfig = getStatusConfig(mdfe.status);
                      return (
                        <div key={mdfe.id} className="flex items-center justify-between p-4 rounded-lg border border-border-primary hover:bg-bg-surface-hover transition-colors duration-200">
                          <div className="flex-1">
                            <div className="font-medium text-text-primary mb-1">
                              MDF-e Nº {mdfe.numero}/{mdfe.serie}
                            </div>
                            <div className="flex flex-wrap gap-3 text-sm text-text-secondary">
                              <span>{mdfe.emitenteNome}</span>
                              <span>{formatDate(mdfe.dataEmissao)}</span>
                              {mdfe.valorTotal && <span>{formatCurrency(mdfe.valorTotal)}</span>}
                            </div>
                          </div>
                          <div className="flex items-center gap-2 px-3 py-1 rounded-full text-xs font-medium" style={{ backgroundColor: statusConfig.bgColor, color: statusConfig.textColor }}>
                            <i className={statusConfig.icon}></i>
                            {mdfe.status}
                          </div>
                        </div>
                      );
                    })}
                  </div>
                </div>
              )}
            </div>
          </div>

          {/* Quick Actions & System Info */}
          <div className="space-y-6">
            {/* Quick Actions */}
            <div className="bg-bg-surface rounded-xl border border-border-primary">
              <div className="p-6 border-b border-border-primary">
                <div className="flex items-center gap-3">
                  <Icon name="bolt" className="text-text-secondary" size="sm" />
                  <span className="font-semibold text-text-primary">Ações Rápidas</span>
                </div>
              </div>

              <div className="p-6 space-y-3">
                <button
                  className="w-full flex items-center justify-between p-4 rounded-lg border border-border-primary hover:bg-bg-surface-hover transition-colors duration-200 group"
                  onClick={() => handleNavigate('mdfe-editor')}
                >
                  <div className="flex items-center gap-4">
                    <div className="w-10 h-10 rounded-lg bg-primary-light flex items-center justify-center">
                      <Icon name="plus" className="text-primary" size="sm" />
                    </div>
                    <div className="text-left">
                      <div className="font-medium text-text-primary">Novo MDF-e</div>
                      <div className="text-sm text-text-secondary">Emitir manifesto</div>
                    </div>
                  </div>
                  <Icon name="chevron-right" className="text-text-tertiary group-hover:text-primary transition-colors duration-200" size="sm" />
                </button>

                <button
                  className="w-full flex items-center justify-between p-4 rounded-lg border border-border-primary hover:bg-bg-surface-hover transition-colors duration-200 group"
                  onClick={() => handleNavigate('veiculos')}
                >
                  <div className="flex items-center gap-4">
                    <div className="w-10 h-10 rounded-lg bg-orange-100 dark:bg-orange-900/30 flex items-center justify-center">
                      <Icon name="truck" className="text-orange-600 dark:text-orange-400" size="sm" />
                    </div>
                    <div className="text-left">
                      <div className="font-medium text-text-primary">Veículos</div>
                      <div className="text-sm text-text-secondary">Gerenciar frota</div>
                    </div>
                  </div>
                  <Icon name="chevron-right" className="text-text-tertiary group-hover:text-primary transition-colors duration-200" size="sm" />
                </button>

                <button
                  className="w-full flex items-center justify-between p-4 rounded-lg border border-border-primary hover:bg-bg-surface-hover transition-colors duration-200 group"
                  onClick={() => handleNavigate('condutores')}
                >
                  <div className="flex items-center gap-4">
                    <div className="w-10 h-10 rounded-lg bg-teal-100 dark:bg-teal-900/30 flex items-center justify-center">
                      <Icon name="users" className="text-teal-600 dark:text-teal-400" size="sm" />
                    </div>
                    <div className="text-left">
                      <div className="font-medium text-text-primary">Condutores</div>
                      <div className="text-sm text-text-secondary">Motoristas</div>
                    </div>
                  </div>
                  <Icon name="chevron-right" className="text-text-tertiary group-hover:text-primary transition-colors duration-200" size="sm" />
                </button>

                <button
                  className="w-full flex items-center justify-between p-4 rounded-lg border border-border-primary hover:bg-bg-surface-hover transition-colors duration-200 group"
                  onClick={() => handleNavigate('emitentes')}
                >
                  <div className="flex items-center gap-4">
                    <div className="w-10 h-10 rounded-lg bg-purple-100 dark:bg-purple-900/30 flex items-center justify-center">
                      <Icon name="building" className="text-purple-600 dark:text-purple-400" size="sm" />
                    </div>
                    <div className="text-left">
                      <div className="font-medium text-text-primary">Emitentes</div>
                      <div className="text-sm text-text-secondary">Empresas</div>
                    </div>
                  </div>
                  <Icon name="chevron-right" className="text-text-tertiary group-hover:text-primary transition-colors duration-200" size="sm" />
                </button>
              </div>
            </div>

            {/* System Summary */}
            <div className="bg-bg-surface rounded-xl border border-border-primary">
              <div className="p-6 border-b border-border-primary">
                <div className="flex items-center gap-3">
                  <Icon name="chart-bar" className="text-text-secondary" size="sm" />
                  <span className="font-semibold text-text-primary">Resumo</span>
                </div>
              </div>

              <div className="p-6 space-y-4">
                <div className="flex items-center justify-between">
                  <span className="text-text-secondary">Contratantes</span>
                  <span className="font-semibold text-text-primary">{stats.totalContratantes}</span>
                </div>
                <div className="flex items-center justify-between">
                  <span className="text-text-secondary">Seguradoras</span>
                  <span className="font-semibold text-text-primary">{stats.totalSeguradoras}</span>
                </div>
                <div className="flex items-center justify-between">
                  <span className="text-text-secondary">Municípios</span>
                  <span className="font-semibold text-text-primary">{stats.totalMunicipios}</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};