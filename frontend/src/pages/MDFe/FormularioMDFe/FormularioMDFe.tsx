import { useState, useEffect } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import { mdfeService } from '../../../services/mdfeService';
import { entitiesService } from '../../../services/entitiesService';
import { MDFeData } from '../../../types/mdfe';
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

  const [entidadesCarregadas, setEntidadesCarregadas] = useState<any>(null);
  const [dados, setDados] = useState<Partial<MDFeData>>({
    // Nova interface simplificada - apenas campos básicos
    documentosCTe: [],
    documentosNFe: []
  });


  useEffect(() => {
    carregarDadosIniciais();
    if (id) {
      carregarMDFe(id);
    }
  }, [id]);

  // Cleanup ao desmontar componente
  useEffect(() => {
    return () => {
      setMensagemSucesso('');
      setErro('');
    };
  }, []);

  const carregarDadosIniciais = async () => {
    try {
      await entitiesService.obterEmitentes();
      if (!id) {
        await gerarProximoNumero();
      }
    } catch (error) {
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

  const carregarMDFe = async (mdfeId: string) => {
    setCarregandoDados(true);
    setErro('');

    try {
      const resultado = await mdfeService.obterMDFeCompleto(parseInt(mdfeId));

      if (resultado.sucesso && resultado.dados) {
        // Estrutura: { mdfe: {...}, entities: {...} }
        const { mdfe, entities } = resultado.dados as any;

        if (mdfe) {
          // Usar os dados do MDFe diretamente (snapshots já incluídos pelo backend)
          setDados(mdfe);

          // Definir as entidades carregadas
          setEntidadesCarregadas(entities);

          // Log para debug das entidades carregadas
          if (process.env.NODE_ENV === 'development') {

            // Debug específico para localidades
          }
        }
      } else {
        setErro(`Erro ao carregar MDFe: ${resultado.mensagem}`);
      }
    } catch (error) {
      setErro('Erro inesperado ao carregar MDFe. Tente novamente.');
    } finally {
      setCarregandoDados(false);
    }
  };



  const salvar = async () => {
    setSalvando(true);
    try {
      const agora = new Date().toISOString().slice(0, 16);

      // Nova interface simplificada - datas serão gerenciadas pelo backend
      const dadosAtualizados = {
        ...dados,
        dataEmissao: new Date(),
        dataInicioViagem: new Date()
      };

      const resultado = id
        ? await mdfeService.atualizarMDFe(parseInt(id), dadosAtualizados as MDFeData)
        : await mdfeService.criarMDFe(dadosAtualizados as MDFeData);

      if (resultado.sucesso) {
        setMensagemSucesso('MDFe salvo com sucesso! Agora você pode transmitir para a SEFAZ.');
        // Remover mensagem após 3 segundos
        setTimeout(() => setMensagemSucesso(''), 3000);
      } else {
        setErro(`Erro ao salvar MDFe: ${resultado.mensagem}`);
        console.error('Erro detalhado:', resultado);
      }
    } catch (error) {
      setErro('Erro inesperado ao salvar MDFe. Tente novamente.');
    } finally {
      setSalvando(false);
    }
  };

  const cancelar = () => {
    navigate('/mdfes');
  };

  const transmitir = async () => {

    if (!window.confirm('Deseja transmitir este MDFe para a SEFAZ?')) {
      return;
    }

    setTransmitindo(true);
    setErro('');
    setMensagemSucesso('');

    try {
      await salvar();


      const resultadoCarregamento = await mdfeService.carregarINI(dados);

      if (!resultadoCarregamento.sucesso) {
        console.error('❌ TRANSMITIR - ERRO NO CARREGAMENTO:', resultadoCarregamento);
        setErro(`Erro ao carregar dados: ${resultadoCarregamento.mensagem}`);
        return;
      }


      // Se não tem ID, precisa salvar primeiro
      if (!id) {
        setErro('É necessário salvar o MDFe antes de transmitir');
        return;
      }

      const resultadoTransmissao = await mdfeService.transmitirMDFe(parseInt(id));

      if (resultadoTransmissao.sucesso) {
        setMensagemSucesso('MDFe transmitido com sucesso para a SEFAZ!');
        setTimeout(() => navigate('/mdfes'), 2000);
      } else {
        console.error('❌ TRANSMITIR - ERRO NA TRANSMISSÃO:', resultadoTransmissao);
        setErro(`Erro na transmissão: ${resultadoTransmissao.mensagem}`);
      }
    } catch (error) {
      console.error('💥 TRANSMITIR - ERRO CRÍTICO:', error);
      console.error('Stack trace:', error instanceof Error ? error.stack : 'No stack available');
      setErro('Erro inesperado ao transmitir MDFe. Tente novamente.');
    } finally {
      setTransmitindo(false);
    }
  };



  return (
    <div className="min-h-screen bg-gray-50 dark:bg-gray-900">
      {/* Indicador de carregamento */}
      {carregandoDados && (
        <div className="fixed top-5 left-1/2 transform -translate-x-1/2 z-50 px-6 py-4 bg-gradient-to-r from-blue-500 to-blue-700 text-white rounded-xl flex items-center space-x-3 shadow-lg animate-pulse">
          <i className="fas fa-spinner fa-spin text-xl"></i>
          <span className="font-medium">Carregando dados do MDFe...</span>
        </div>
      )}

      {erro && (
        <div className="fixed top-5 left-1/2 transform -translate-x-1/2 z-50 max-w-md">
          <ErrorDisplay
            error={erro}
            type="block"
            onClose={() => setErro('')}
          />
        </div>
      )}

      {/* Mensagem de sucesso */}
      {mensagemSucesso && (
        <div className="fixed top-5 left-1/2 transform -translate-x-1/2 z-50 px-8 py-5 bg-gradient-to-r from-green-500 to-green-600 text-white rounded-xl flex items-center space-x-3 shadow-lg border-2 border-green-400 min-w-96">
          <i className="fas fa-check-circle text-2xl"></i>
          <span className="font-semibold text-lg">{mensagemSucesso}</span>
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