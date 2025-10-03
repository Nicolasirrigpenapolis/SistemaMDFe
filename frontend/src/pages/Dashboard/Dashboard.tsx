import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { entitiesService } from '../../services/entitiesService';
import { mdfeService } from '../../services/mdfeService';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '../../components/UI/card';
import { TrendingUp, FileText, CheckCircle2, Clock, Building2, Truck, Users, AlertCircle, ChevronRight, Zap, BarChart3, Activity } from 'lucide-react';

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
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    carregarDadosDashboard();
  }, []);

  const carregarDadosDashboard = async () => {
    setLoading(true);
    try {

      // ✅ OTIMIZADO: Busca apenas estatísticas (PageSize=1) ao invés de todos os dados
      const [
        emitentesStats,
        veiculosStats,
        condutoresStats,
        contratantesStats,
        seguradorasStats,
        municipiosRes,
        mdfesRecentes
      ] = await Promise.allSettled([
        fetch('https://localhost:5001/api/emitentes?Page=1&PageSize=1').then(res => res.json()),
        fetch('https://localhost:5001/api/veiculos?Page=1&PageSize=1').then(res => res.json()),
        fetch('https://localhost:5001/api/condutores?Page=1&PageSize=1').then(res => res.json()),
        fetch('https://localhost:5001/api/contratantes?Page=1&PageSize=1').then(res => res.json()),
        fetch('https://localhost:5001/api/seguradoras?Page=1&PageSize=1').then(res => res.json()),
        fetch('https://localhost:5001/api/municipios?tamanhoPagina=1&pagina=1').then(res => res.json()),
        mdfeService.listarMDFes({ tamanhoPagina: 5, pagina: 1 }) // Apenas 5 para "Atividade Recente"
      ]);

      // Extrai totais das respostas paginadas
      let totalEmitentes = 0, totalVeiculos = 0, totalCondutores = 0;
      let totalContratantes = 0, totalSeguradoras = 0, totalMunicipios = 0;
      let totalMDFes = 0, mdfesPendentes = 0, mdfesAutorizados = 0;
      let mdfesRecentesData: any[] = [];

      if (emitentesStats.status === 'fulfilled' && emitentesStats.value?.data) {
        totalEmitentes = emitentesStats.value.data.totalItems || 0;
      }
      if (veiculosStats.status === 'fulfilled' && veiculosStats.value?.data) {
        totalVeiculos = veiculosStats.value.data.totalItems || 0;
      }
      if (condutoresStats.status === 'fulfilled' && condutoresStats.value?.data) {
        totalCondutores = condutoresStats.value.data.totalItems || 0;
      }
      if (contratantesStats.status === 'fulfilled' && contratantesStats.value?.data) {
        totalContratantes = contratantesStats.value.data.totalItems || 0;
      }
      if (seguradorasStats.status === 'fulfilled' && seguradorasStats.value?.data) {
        totalSeguradoras = seguradorasStats.value.data.totalItems || 0;
      }
      if (municipiosRes.status === 'fulfilled') {
        totalMunicipios = municipiosRes.value?.totalItens || 0;
      }
      if (mdfesRecentes.status === 'fulfilled' && mdfesRecentes.value.sucesso && mdfesRecentes.value.dados) {
        const dados = mdfesRecentes.value.dados;
        mdfesRecentesData = dados.Itens || dados.Items || dados.itens || dados.items || dados || [];
        totalMDFes = dados.TotalItens || dados.totalItems || mdfesRecentesData.length;
        mdfesPendentes = mdfesRecentesData.filter((m: any) => m.status === 'Pendente' || m.statusSefaz === 'RASCUNHO').length;
        mdfesAutorizados = mdfesRecentesData.filter((m: any) => m.status === 'Autorizado' || m.statusSefaz === 'AUTORIZADO').length;
      }

      setStats({
        totalMDFes,
        mdfesPendentes,
        mdfesAutorizados,
        totalVeiculos,
        veiculosAtivos: totalVeiculos, // Backend já filtra apenas ativos
        totalCondutores,
        condutoresAtivos: totalCondutores, // Backend já filtra apenas ativos
        totalEmitentes,
        emitentesAtivos: totalEmitentes, // Backend já filtra apenas ativos
        totalContratantes,
        totalSeguradoras,
        totalMunicipios,
      });

      setRecentMDFes(mdfesRecentesData.slice(0, 5));

    } catch (error) {
      console.error('Erro ao carregar dados do dashboard:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleNavigate = (page: string) => {
    navigate(`/${page}`);
  };

  const getStatusConfig = (status: string) => {
    switch (status) {
      case 'Autorizado':
        return {
          variant: 'default' as const,
          icon: CheckCircle2,
          className: 'bg-emerald-100 text-emerald-700 dark:bg-emerald-950 dark:text-emerald-400'
        };
      case 'Pendente':
        return {
          variant: 'secondary' as const,
          icon: Clock,
          className: 'bg-amber-100 text-amber-700 dark:bg-amber-950 dark:text-amber-400'
        };
      case 'Cancelado':
      case 'Rejeitado':
        return {
          variant: 'destructive' as const,
          icon: AlertCircle,
          className: 'bg-red-100 text-red-700 dark:bg-red-950 dark:text-red-400'
        };
      default:
        return {
          variant: 'outline' as const,
          icon: FileText,
          className: 'bg-slate-100 text-slate-700 dark:bg-slate-800 dark:text-slate-400'
        };
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

  if (loading) {
    return (
      <div className="min-h-screen p-8 flex items-center justify-center">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary mx-auto mb-4"></div>
          <p className="text-muted-foreground">Carregando...</p>
        </div>
      </div>
    );
  }

  // Mantém skeleton antigo para compatibilidade (nunca será executado)
  if (false && stats.totalMDFes === 0) {
    return (
      <div className="min-h-screen p-8 space-y-8 animate-pulse">
        <div className="h-8 bg-gray-200 dark:bg-gray-700 rounded w-1/4"></div>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
          {[1,2,3,4].map(i => (
            <div key={i} className="h-32 bg-gray-200 dark:bg-gray-700 rounded-lg"></div>
          ))}
        </div>
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          <div className="h-96 bg-gray-200 dark:bg-gray-700 rounded-lg"></div>
          <div className="h-96 bg-gray-200 dark:bg-gray-700 rounded-lg"></div>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen p-8 space-y-8">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-4xl font-bold tracking-tight">Dashboard</h1>
          <p className="text-muted-foreground mt-2">Visão geral completa do sistema MDF-e</p>
        </div>
        <button
          className="inline-flex items-center justify-center gap-2 rounded-md text-sm font-medium h-10 px-4 py-2 bg-primary text-primary-foreground hover:bg-primary/90 transition-colors"
          onClick={() => navigate('/mdfes/novo')}
        >
          <Zap className="w-4 h-4" />
          Emitir MDF-e
        </button>
      </div>

      {/* Stats Grid */}
      <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-6">
        <Card className="cursor-pointer hover:shadow-lg transition-shadow" onClick={() => handleNavigate('mdfes')}>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Total MDF-es</CardTitle>
            <FileText className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{stats.totalMDFes}</div>
            <p className="text-xs text-muted-foreground flex items-center gap-1 mt-1">
              <TrendingUp className="w-3 h-3 text-emerald-600" />
              Documentos emitidos
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Autorizados</CardTitle>
            <CheckCircle2 className="h-4 w-4 text-emerald-600" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{stats.mdfesAutorizados}</div>
            <p className="text-xs text-muted-foreground mt-1">
              Aprovados pela SEFAZ
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Pendentes</CardTitle>
            <Clock className="h-4 w-4 text-amber-600" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{stats.mdfesPendentes}</div>
            <p className="text-xs text-muted-foreground mt-1">
              Aguardando processamento
            </p>
          </CardContent>
        </Card>

        <Card className="cursor-pointer hover:shadow-lg transition-shadow" onClick={() => handleNavigate('emitentes')}>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Emitentes</CardTitle>
            <Building2 className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{stats.totalEmitentes}</div>
            <p className="text-xs text-muted-foreground mt-1">
              {stats.emitentesAtivos} ativos
            </p>
          </CardContent>
        </Card>

        <Card className="cursor-pointer hover:shadow-lg transition-shadow" onClick={() => handleNavigate('veiculos')}>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Veículos</CardTitle>
            <Truck className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{stats.totalVeiculos}</div>
            <p className="text-xs text-muted-foreground mt-1">
              {stats.veiculosAtivos} ativos
            </p>
          </CardContent>
        </Card>

        <Card className="cursor-pointer hover:shadow-lg transition-shadow" onClick={() => handleNavigate('condutores')}>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Condutores</CardTitle>
            <Users className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">{stats.totalCondutores}</div>
            <p className="text-xs text-muted-foreground mt-1">
              {stats.condutoresAtivos} ativos
            </p>
          </CardContent>
        </Card>
      </div>

      {/* Main Content */}
      <div className="grid gap-6 lg:grid-cols-3">
        {/* Recent Activity */}
        <Card className="lg:col-span-2">
          <CardHeader>
            <div className="flex items-center justify-between">
              <div className="flex items-center gap-2">
                <Activity className="h-5 w-5" />
                <CardTitle>Atividade Recente</CardTitle>
              </div>
              <button
                className="text-sm font-medium text-primary hover:underline flex items-center gap-1"
                onClick={() => handleNavigate('mdfes')}
              >
                Ver todos
                <ChevronRight className="w-4 h-4" />
              </button>
            </div>
            <CardDescription>Últimos MDF-es emitidos no sistema</CardDescription>
          </CardHeader>
          <CardContent>
            {recentMDFes.length === 0 ? (
              <div className="flex flex-col items-center justify-center py-12 text-center">
                <div className="w-16 h-16 rounded-full bg-muted flex items-center justify-center mb-4">
                  <FileText className="h-8 w-8 text-muted-foreground" />
                </div>
                <h3 className="text-lg font-semibold mb-2">Nenhum MDF-e emitido</h3>
                <p className="text-muted-foreground mb-6">Comece emitindo seu primeiro manifesto eletrônico</p>
                <button
                  className="inline-flex items-center justify-center gap-2 rounded-md text-sm font-medium h-10 px-4 py-2 bg-primary text-primary-foreground hover:bg-primary/90"
                  onClick={() => handleNavigate('mdfe-editor')}
                >
                  <Zap className="w-4 h-4" />
                  Emitir primeiro MDF-e
                </button>
              </div>
            ) : (
              <div className="space-y-3">
                {recentMDFes.map((mdfe) => {
                  const statusConfig = getStatusConfig(mdfe.status);
                  const StatusIcon = statusConfig.icon;
                  return (
                    <div key={mdfe.id} className="flex items-center justify-between p-4 rounded-lg border hover:bg-accent/50 transition-colors">
                      <div className="flex-1">
                        <div className="font-medium mb-1">
                          MDF-e Nº {mdfe.numero}/{mdfe.serie}
                        </div>
                        <div className="flex flex-wrap gap-3 text-sm text-muted-foreground">
                          <span>{mdfe.emitenteNome}</span>
                          <span>{formatDate(mdfe.dataEmissao)}</span>
                          {mdfe.valorTotal && <span>{formatCurrency(mdfe.valorTotal)}</span>}
                        </div>
                      </div>
                      <div className={`flex items-center gap-2 px-3 py-1 rounded-full text-xs font-medium ${statusConfig.className}`}>
                        <StatusIcon className="w-3 h-3" />
                        {mdfe.status}
                      </div>
                    </div>
                  );
                })}
              </div>
            )}
          </CardContent>
        </Card>

        {/* Sidebar */}
        <div className="space-y-6">
          {/* Quick Actions */}
          <Card>
            <CardHeader>
              <div className="flex items-center gap-2">
                <Zap className="h-5 w-5" />
                <CardTitle>Ações Rápidas</CardTitle>
              </div>
            </CardHeader>
            <CardContent className="space-y-2">
              <button
                className="w-full flex items-center justify-between p-3 rounded-lg border hover:bg-accent transition-colors group"
                onClick={() => handleNavigate('mdfe-editor')}
              >
                <div className="flex items-center gap-3">
                  <div className="w-10 h-10 rounded-lg bg-primary/10 flex items-center justify-center">
                    <FileText className="w-5 h-5 text-primary" />
                  </div>
                  <div className="text-left">
                    <div className="font-medium text-sm">Novo MDF-e</div>
                    <div className="text-xs text-muted-foreground">Emitir manifesto</div>
                  </div>
                </div>
                <ChevronRight className="w-4 h-4 text-muted-foreground group-hover:text-primary transition-colors" />
              </button>

              <button
                className="w-full flex items-center justify-between p-3 rounded-lg border hover:bg-accent transition-colors group"
                onClick={() => handleNavigate('veiculos')}
              >
                <div className="flex items-center gap-3">
                  <div className="w-10 h-10 rounded-lg bg-orange-100 dark:bg-orange-950 flex items-center justify-center">
                    <Truck className="w-5 h-5 text-orange-600 dark:text-orange-400" />
                  </div>
                  <div className="text-left">
                    <div className="font-medium text-sm">Veículos</div>
                    <div className="text-xs text-muted-foreground">Gerenciar frota</div>
                  </div>
                </div>
                <ChevronRight className="w-4 h-4 text-muted-foreground group-hover:text-primary transition-colors" />
              </button>

              <button
                className="w-full flex items-center justify-between p-3 rounded-lg border hover:bg-accent transition-colors group"
                onClick={() => handleNavigate('condutores')}
              >
                <div className="flex items-center gap-3">
                  <div className="w-10 h-10 rounded-lg bg-teal-100 dark:bg-teal-950 flex items-center justify-center">
                    <Users className="w-5 h-5 text-teal-600 dark:text-teal-400" />
                  </div>
                  <div className="text-left">
                    <div className="font-medium text-sm">Condutores</div>
                    <div className="text-xs text-muted-foreground">Motoristas</div>
                  </div>
                </div>
                <ChevronRight className="w-4 h-4 text-muted-foreground group-hover:text-primary transition-colors" />
              </button>

              <button
                className="w-full flex items-center justify-between p-3 rounded-lg border hover:bg-accent transition-colors group"
                onClick={() => handleNavigate('emitentes')}
              >
                <div className="flex items-center gap-3">
                  <div className="w-10 h-10 rounded-lg bg-purple-100 dark:bg-purple-950 flex items-center justify-center">
                    <Building2 className="w-5 h-5 text-purple-600 dark:text-purple-400" />
                  </div>
                  <div className="text-left">
                    <div className="font-medium text-sm">Emitentes</div>
                    <div className="text-xs text-muted-foreground">Empresas</div>
                  </div>
                </div>
                <ChevronRight className="w-4 h-4 text-muted-foreground group-hover:text-primary transition-colors" />
              </button>
            </CardContent>
          </Card>

          {/* System Summary */}
          <Card>
            <CardHeader>
              <div className="flex items-center gap-2">
                <BarChart3 className="h-5 w-5" />
                <CardTitle>Resumo do Sistema</CardTitle>
              </div>
            </CardHeader>
            <CardContent className="space-y-3">
              <div className="flex items-center justify-between">
                <span className="text-sm text-muted-foreground">Contratantes</span>
                <span className="font-semibold">{stats.totalContratantes}</span>
              </div>
              <div className="flex items-center justify-between">
                <span className="text-sm text-muted-foreground">Seguradoras</span>
                <span className="font-semibold">{stats.totalSeguradoras}</span>
              </div>
              <div className="flex items-center justify-between">
                <span className="text-sm text-muted-foreground">Municípios</span>
                <span className="font-semibold">{stats.totalMunicipios}</span>
              </div>
            </CardContent>
          </Card>
        </div>
      </div>
    </div>
  );
}
