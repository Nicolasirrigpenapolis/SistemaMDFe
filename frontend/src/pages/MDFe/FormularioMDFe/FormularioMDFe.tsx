import { useState, useEffect } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import { mdfeService } from '../../../services/mdfeService';
import { entitiesService } from '../../../services/entitiesService';
import { MDFeData, EntidadesCarregadas } from '../../../types/mdfe';
import { MDFeForm } from '../../../components/UI/Forms/MDFeForm';
import { ErrorDisplay } from '../../../components/UI/ErrorDisplay/ErrorDisplay';

export function FormularioMDFe() {
  const navigate = useNavigate();
  const { id } = useParams();
  const [salvando, setSalvando] = useState(false);
  const [erro, setErro] = useState<string>('');
  const [transmitindo, setTransmitindo] = useState(false);
  const [mensagemSucesso, setMensagemSucesso] = useState<string>('');
  const [carregandoDados, setCarregandoDados] = useState(false);
  const [mostrarModalCancelamento, setMostrarModalCancelamento] = useState(false);
  const [temAlteracoesNaoSalvas, setTemAlteracoesNaoSalvas] = useState(false);
  const [modalTransmissao, setModalTransmissao] = useState<{
    aberto: boolean;
    sucesso: boolean;
    mensagem: string;
    detalhes?: any;
  }>({ aberto: false, sucesso: false, mensagem: '' });

  const [entidadesCarregadas, setEntidadesCarregadas] = useState<EntidadesCarregadas | null>(null);
  const [dados, setDados] = useState<Partial<MDFeData>>({
    // Nova interface simplificada - apenas campos básicos
    documentosCTe: [],
    documentosNFe: []
  });


  useEffect(() => {
    const inicializar = async () => {
      // 1️⃣ PRIMEIRO: Carregar entidades frescas do banco
      await carregarDadosIniciais();

      // 2️⃣ DEPOIS: Carregar MDFe (se estiver editando)
      if (id) {
        await carregarMDFe(id);
      }
    };

    inicializar();
  }, [id]);

  // Detectar alterações nos dados para ativar o aviso
  useEffect(() => {
    // Se há dados preenchidos, marca como tendo alterações não salvas
    const temDados =
      dados.emitenteId ||
      dados.veiculoId ||
      dados.condutorId ||
      dados.ufIni ||
      dados.ufFim ||
      (dados.localidadesCarregamento && dados.localidadesCarregamento.length > 0) ||
      (dados.localidadesDescarregamento && dados.localidadesDescarregamento.length > 0);

    setTemAlteracoesNaoSalvas(!!temDados);
  }, [dados]);

  // Cleanup ao desmontar componente
  useEffect(() => {
    return () => {
      setMensagemSucesso('');
      setErro('');
    };
  }, []);

  // 🚨 Bloquear navegação se houver alterações não salvas
  useEffect(() => {
    const handleBeforeUnload = (e: BeforeUnloadEvent) => {
      if (temAlteracoesNaoSalvas) {
        e.preventDefault();
        e.returnValue = '';
      }
    };

    window.addEventListener('beforeunload', handleBeforeUnload);

    return () => {
      window.removeEventListener('beforeunload', handleBeforeUnload);
    };
  }, [temAlteracoesNaoSalvas]);

  const carregarDadosIniciais = async () => {
    try {
      console.log('📥 Carregando entidades FRESCAS do banco...');
      const entidades = await entitiesService.obterTodasEntidades();

      console.log('🔍 ESTRUTURA COMPLETA DAS ENTIDADES:', JSON.stringify(entidades, null, 2));

      // 🔍 DEBUG: Verificar código IBGE dos emitentes carregados
      if (entidades?.emitentes && entidades.emitentes.length > 0) {
        entidades.emitentes.forEach((emitente: any) => {
          console.log(`🏢 Emitente carregado:`, {
            id: emitente.id,
            label: emitente.label,
            description: emitente.description,
            codMunicipio: emitente.codMunicipio,
            municipio: emitente.municipio,
            razaoSocial: emitente.razaoSocial
          });

          // ⚠️ ALERTA se label estiver vazio
          if (!emitente.label || emitente.label === '') {
            console.error('❌ EMITENTE COM LABEL VAZIO:', emitente);
          }
        });
      }

      setEntidadesCarregadas(entidades);
      console.log('✅ Entidades carregadas com sucesso');

      if (!id) {
        await gerarProximoNumero();
      }
    } catch (error) {
      console.error('❌ ERRO ao carregar dados iniciais:', error);
      setErro('Erro ao carregar dados necessários para o formulário');
    }
  };

  const gerarProximoNumero = async () => {
    try {
      const response = await fetch(`${process.env.REACT_APP_API_URL || 'https://localhost:5001/api'}/mdfe/proximo-numero`);

      const proximoNumero = response.ok
        ? ((await response.json()).proximoNumero || 700)
        : 700;

      // Nova interface simplificada - não precisa mais de objeto ide
      setDados(dadosAtuais => ({
        ...dadosAtuais
        // Próximo número será gerenciado pelo backend
      }));
    } catch (error) {
      // Nova interface simplificada - fallback será gerenciado pelo backend
      setDados(dadosAtuais => ({
        ...dadosAtuais
      }));
    }
  };

  // ✅ Função helper para parse seguro de JSON
  const parseJsonSafe = <T,>(json: string | null | undefined, fallback: T): T => {
    if (!json || json.trim() === '') return fallback;
    try {
      return JSON.parse(json) as T;
    } catch (error) {
      console.error('❌ Erro ao fazer parse do JSON:', json, error);
      return fallback;
    }
  };

  const carregarMDFe = async (mdfeId: string) => {
    setCarregandoDados(true);
    setErro('');

    try {
      console.log('🔄 Carregando MDFe ID:', mdfeId);
      const resultado = await mdfeService.obterMDFeCompleto(parseInt(mdfeId));
      console.log('📡 Resultado da API:', JSON.stringify(resultado, null, 2));

      if (resultado.sucesso && resultado.dados) {
        // Log detalhado da estrutura
        console.log('📦 Estrutura completa dos dados:', {
          sucesso: resultado.sucesso,
          mensagem: resultado.mensagem,
          dados: resultado.dados
        });

        // ✅ A API retorna uma estrutura aninhada: resultado.dados.dados.mdfe
        const dadosApi = resultado.dados.dados || resultado.dados;
        const { mdfe, entities } = dadosApi;
        
        if (!mdfe) {
          console.error('❌ MDFe não encontrado na resposta');
          setErro('Dados do MDFe não encontrados na resposta da API');
          return;
        }

        console.log('📦 MDFe extraído:', JSON.stringify(mdfe, null, 2));
        console.log('📦 Entities extraídas:', JSON.stringify(entities, null, 2));

        // 🔍 DEBUG: Verificar código IBGE do emitente
        if (entities?.emitentes && entities.emitentes.length > 0) {
          const emitente = entities.emitentes[0];
          console.log('🏢 CÓDIGO IBGE DO EMITENTE:', {
            id: emitente.id,
            razaoSocial: emitente.razaoSocial,
            municipio: emitente.municipio,
            uf: emitente.uf,
            codMunicipio: emitente.codMunicipio,
            status: emitente.codMunicipio === 0 ? '❌ ZERADO - PRECISA EDITAR!' : '✅ OK'
          });
        }

        if (mdfe) {
          console.log('📦 Dados do MDFe recebidos:', mdfe);

          // 🎯 Mapear APENAS os campos essenciais que o usuário preencheu
          const dadosMapeados: Partial<MDFeData> = {
            id: id, // Usar o ID diretamente do parâmetro da URL
            numero: mdfe.numeroMdfe?.toString(),
            serie: mdfe.serie?.toString(),

            // IDs das entidades selecionadas
            emitenteId: mdfe.emitenteId,
            veiculoId: mdfe.veiculoId,
            condutorId: mdfe.condutorId,
            contratanteId: mdfe.contratanteId || undefined,
            seguradoraId: mdfe.seguradoraId || undefined,

            // Dados da viagem
            dataEmissao: mdfe.dataEmissao ? new Date(mdfe.dataEmissao) : new Date(),
            dataInicioViagem: mdfe.dataInicioViagem ? new Date(mdfe.dataInicioViagem) : new Date(),
            ufIni: mdfe.ufIni,
            ufFim: mdfe.ufFim,
            municipioIni: mdfe.municipioIni || '',
            municipioFim: mdfe.municipioFim || '',

            // Valores
            pesoBrutoTotal: mdfe.pesoBrutoTotal || 0,
            valorTotal: mdfe.valorTotal || 0,
            observacoes: mdfe.observacoes || '',

            // ✅ Localidades (parseadas do JSON com segurança)
            localidadesCarregamento: parseJsonSafe(mdfe.localidadesCarregamentoJson, []),
            localidadesDescarregamento: parseJsonSafe(mdfe.localidadesDescarregamentoJson, []),
            rotaPercurso: parseJsonSafe(mdfe.rotaPercursoJson, []),

            // ✅ Documentos (parseados do JSON com segurança)
            documentosCTe: parseJsonSafe(mdfe.documentosCTeJson, []),
            documentosNFe: parseJsonSafe(mdfe.documentosNFeJson, []),

            // ✅ Reboques (IDs do backend)
            reboquesIds: mdfe.reboquesIds || [],

            // Status (apenas para exibição)
            chaveAcesso: mdfe.chaveAcesso,
            protocolo: mdfe.protocolo,
            statusSefaz: mdfe.statusSefaz
          };

          console.log('✅ Dados mapeados para o formulário:', dadosMapeados);
          console.log('🔍 ID mapeado:', dadosMapeados.id, 'tipo:', typeof dadosMapeados.id);
          setDados(dadosMapeados);

          // ⚠️ NÃO usar entities da API (snapshots antigos)
          // As entidades já foram carregadas frescas do banco em carregarDadosIniciais()
          // Apenas use entities se ainda não tivermos entidades carregadas
          if (!entidadesCarregadas) {
            console.warn('⚠️ Usando entities da API (pode conter dados desatualizados)');
            setEntidadesCarregadas(entities);
          } else {
            console.log('✅ Mantendo entidades frescas já carregadas do banco');
          }
        }
      } else {
        setErro(`Erro ao carregar MDFe: ${resultado.mensagem}`);
      }
    } catch (error) {
      console.error('❌ Erro ao carregar MDFe:', error);
      setErro('Erro inesperado ao carregar MDFe. Tente novamente.');
    } finally {
      setCarregandoDados(false);
    }
  };



  const salvar = async () => {
    console.log('💾 Salvando MDFe...', { id, dados });
    setSalvando(true);
    try {
      const dadosAtualizados = {
        ...dados,
        dataEmissao: new Date(),
        dataInicioViagem: new Date()
      };

      console.log('📦 Dados enviados para a API:', dadosAtualizados);
      console.log('🔍 LOCALIDADES - Carregamento:', JSON.stringify(dadosAtualizados.localidadesCarregamento));
      console.log('🔍 LOCALIDADES - Descarregamento:', JSON.stringify(dadosAtualizados.localidadesDescarregamento));

      // Backend decide se é rascunho ou completo
      const resultado = id
        ? await mdfeService.atualizarMDFe(parseInt(id), dadosAtualizados as MDFeData)
        : await mdfeService.criarMDFe(dadosAtualizados as MDFeData);

      if (resultado.sucesso) {
        console.log('✅ MDFe salvo com sucesso:', resultado);
        setTemAlteracoesNaoSalvas(false);
        setMensagemSucesso('MDFe salvo com sucesso');

        // Redirecionar para listagem
        setTimeout(() => {
          navigate('/mdfes');
        }, 1500);
      } else {
        console.error('❌ Erro ao salvar MDFe:', resultado);
        setErro(`Erro ao salvar MDFe: ${resultado.mensagem}`);
        console.error('Erro detalhado:', resultado);
      }
    } catch (error) {
      console.error('💥 Erro crítico ao salvar MDFe:', error);
      setErro('Erro inesperado ao salvar MDFe. Tente novamente.');
    } finally {
      setSalvando(false);
    }
  };

  const cancelar = () => {
    if (temAlteracoesNaoSalvas) {
      setMostrarModalCancelamento(true);
    } else {
      navigate('/mdfes');
    }
  };

  const confirmarCancelamento = () => {
    setTemAlteracoesNaoSalvas(false);
    setMostrarModalCancelamento(false);
    navigate('/mdfes');
  };

  const continuarEditando = () => {
    setMostrarModalCancelamento(false);
  };

  const transmitir = async () => {
    setTransmitindo(true);
    setErro('');
    setMensagemSucesso('');

    try {
      const resultadoCarregamento = await mdfeService.carregarINI(dados);
      console.log('🔍 resultadoCarregamento:', resultadoCarregamento);

      if (!resultadoCarregamento.sucesso) {
        console.error('❌ TRANSMITIR - ERRO NO CARREGAMENTO:', resultadoCarregamento);
        setModalTransmissao({
          aberto: true,
          sucesso: false,
          mensagem: `Erro ao carregar dados: ${resultadoCarregamento.mensagem}`,
          detalhes: resultadoCarregamento
        });
        return;
      }

      // Se não tem ID, precisa salvar primeiro
      if (!id) {
        setModalTransmissao({
          aberto: true,
          sucesso: false,
          mensagem: 'É necessário salvar o MDFe antes de transmitir'
        });
        return;
      }

      const resultadoTransmissao = await mdfeService.transmitirMDFe(parseInt(id));

      if (resultadoTransmissao.sucesso) {
        setModalTransmissao({
          aberto: true,
          sucesso: true,
          mensagem: 'MDFe transmitido com sucesso para a SEFAZ!',
          detalhes: resultadoTransmissao.dados
        });
  // Recarregar dados do MDFe para atualizar status
  await carregarMDFe(id);
      } else {
        console.error('❌ TRANSMITIR - ERRO NA TRANSMISSÃO:', resultadoTransmissao);
        setModalTransmissao({
          aberto: true,
          sucesso: false,
          mensagem: `Erro na transmissão: ${resultadoTransmissao.mensagem}`,
          detalhes: resultadoTransmissao
        });
      }
    } catch (error) {
      console.error('💥 TRANSMITIR - ERRO CRÍTICO:', error);
      console.error('Stack trace:', error instanceof Error ? error.stack : 'No stack available');
      setModalTransmissao({
        aberto: true,
        sucesso: false,
        mensagem: 'Erro inesperado ao transmitir MDFe. Tente novamente.',
        detalhes: error
      });
    } finally {
      setTransmitindo(false);
    }
  };



  return (
    <div className="min-h-screen bg-background">
      {/* Modal de Confirmação de Cancelamento */}
      {mostrarModalCancelamento && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50 backdrop-blur-sm">
          <div className="bg-card border border-border rounded-xl shadow-2xl max-w-md w-full mx-4 overflow-hidden">
            {/* Header */}
            <div className="bg-gradient-to-r from-amber-500 to-orange-600 px-6 py-4 flex items-center gap-3">
              <div className="w-10 h-10 bg-white rounded-full flex items-center justify-center">
                <i className="fas fa-exclamation-triangle text-amber-600 text-lg"></i>
              </div>
              <h3 className="text-white font-bold text-lg">Cancelar Edição?</h3>
            </div>

            {/* Content */}
            <div className="p-6">
              <p className="text-foreground mb-4 text-base leading-relaxed">
                Você tem <strong>alterações não salvas</strong>. Se sair agora, todas as modificações serão perdidas.
              </p>
              <p className="text-muted-foreground text-sm">
                Deseja realmente cancelar e descartar as alterações?
              </p>
            </div>

            {/* Actions */}
            <div className="bg-muted px-6 py-4 flex gap-3 justify-end border-t border-border">
              <button
                onClick={continuarEditando}
                className="px-6 py-2.5 bg-card hover:bg-background border-2 border-border text-foreground rounded-lg font-semibold transition-all duration-200 hover:scale-105"
              >
                <i className="fas fa-arrow-left mr-2"></i>
                Continuar Editando
              </button>
              <button
                onClick={confirmarCancelamento}
                className="px-6 py-2.5 bg-gradient-to-r from-red-500 to-red-600 hover:from-red-600 hover:to-red-700 text-white rounded-lg font-semibold transition-all duration-200 hover:scale-105 shadow-lg"
              >
                <i className="fas fa-times mr-2"></i>
                Descartar e Sair
              </button>
            </div>
          </div>
        </div>
      )}

      {/* Modal de Resultado da Transmissão */}
      {modalTransmissao.aberto && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50 backdrop-blur-sm">
          <div className="bg-card border border-border rounded-xl shadow-2xl max-w-2xl w-full mx-4 overflow-hidden">
            {/* Header */}
            <div className={`px-6 py-4 flex items-center gap-3 ${
              modalTransmissao.sucesso
                ? 'bg-gradient-to-r from-green-500 to-emerald-600'
                : 'bg-gradient-to-r from-red-500 to-red-600'
            }`}>
              <div className="w-10 h-10 bg-white rounded-full flex items-center justify-center">
                <i className={`fas ${
                  modalTransmissao.sucesso ? 'fa-check-circle text-green-600' : 'fa-times-circle text-red-600'
                } text-lg`}></i>
              </div>
              <h3 className="text-white font-bold text-lg">
                {modalTransmissao.sucesso ? 'Transmissão Realizada' : 'Erro na Transmissão'}
              </h3>
            </div>

            {/* Content */}
            <div className="p-6">
              <p className="text-foreground mb-4 text-base leading-relaxed">
                {modalTransmissao.mensagem}
              </p>

              {modalTransmissao.detalhes && (
                <div className="mt-4 p-4 bg-muted rounded-lg border border-border">
                  <p className="text-sm font-semibold text-foreground mb-2">Detalhes:</p>
                  <pre className="text-xs text-muted-foreground overflow-auto max-h-60">
                    {JSON.stringify(modalTransmissao.detalhes, null, 2)}
                  </pre>
                </div>
              )}
            </div>

            {/* Actions */}
            <div className="bg-muted px-6 py-4 flex gap-3 justify-end border-t border-border">
              {modalTransmissao.sucesso ? (
                <button
                  onClick={() => setModalTransmissao({ aberto: false, sucesso: false, mensagem: '' })}
                  className="px-6 py-2.5 bg-card hover:bg-background border-2 border-border text-foreground rounded-lg font-semibold transition-all duration-200 hover:scale-105"
                >
                  Continuar Editando
                </button>
              ) : (
                <button
                  onClick={() => setModalTransmissao({ aberto: false, sucesso: false, mensagem: '' })}
                  className="px-6 py-2.5 bg-gradient-to-r from-blue-500 to-blue-600 hover:from-blue-600 hover:to-blue-700 text-white rounded-lg font-semibold transition-all duration-200 hover:scale-105 shadow-lg"
                >
                  Fechar
                </button>
              )}
            </div>
          </div>
        </div>
      )}

      {erro && (
        <div className="fixed top-5 right-5 z-50 px-4 py-3 bg-red-500 text-white rounded-lg flex items-center gap-2 shadow-lg max-w-sm">
          <i className="fas fa-exclamation-circle"></i>
          <span className="text-sm font-medium">{erro}</span>
          <button onClick={() => setErro('')} className="ml-2 hover:opacity-75">
            <i className="fas fa-times"></i>
          </button>
        </div>
      )}

      {/* Mensagem de sucesso */}
      {mensagemSucesso && (
        <div className="fixed top-5 right-5 z-50 px-4 py-3 bg-green-500 text-white rounded-lg flex items-center gap-2 shadow-lg">
          <i className="fas fa-check-circle"></i>
          <span className="text-sm font-medium">{mensagemSucesso}</span>
        </div>
      )}

      <MDFeForm
        dados={dados}
        onDadosChange={setDados}
        onSalvar={salvar}
        onCancelar={cancelar}
        onTransmitir={transmitir}
        salvando={salvando}
        transmitindo={transmitindo}
        isEdicao={!!id}
        carregandoDados={carregandoDados}
        entidadesCarregadas={entidadesCarregadas}
      />
    </div>
  );
}
