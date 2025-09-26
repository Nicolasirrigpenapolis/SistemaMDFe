import { useState, useEffect } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import { mdfeService } from '../../../services/mdfeService';
import { entitiesService } from '../../../services/entitiesService';
import { MDFeData } from '../../../types/mdfe';
import { MDFeForm } from '../../../components/UI/Forms/MDFeForm';
import { ErrorDisplay } from '../../../components/UI/ErrorDisplay/ErrorDisplay';
import styles from './FormularioMDFe.module.css';

export function FormularioMDFe() {
  const navigate = useNavigate();
  const { id } = useParams();
  const [salvando, setSalvando] = useState(false);
  const [erro, setErro] = useState<string>('');
  const [transmitindo, setTransmitindo] = useState(false);
  const [mensagemSucesso, setMensagemSucesso] = useState<string>('');
  const [carregandoDados, setCarregandoDados] = useState(false);

  const [dados, setDados] = useState<Partial<MDFeData>>({
    ide: {
      cUF: '',
      tpAmb: '2',
      tpEmit: '1',
      tpTransp: '1',
      mod: '58',
      serie: '001',
      nMDF: '700',
      modal: '1',
      dhEmi: '',
      tpEmis: '1',
      procEmi: '0',
      verProc: '1.0.0',
      UFIni: '',
      UFFim: '',
      infMunCarrega: [],
      infPercurso: [],
      dhIniViagem: ''
    },
    emit: {
      CNPJ: '',
      IE: '',
      xNome: '',
      xFant: '',
      enderEmit: {
        xLgr: '',
        nro: '',
        xCpl: '',
        xBairro: '',
        cMun: '',
        xMun: '',
        CEP: '',
        UF: '',
        fone: '',
        email: ''
      }
    },
    infDoc: {
      infMunDescarga: []
    },
    tot: {
      qCTe: '0',
      qNFe: '0',
      qMDFe: '1',
      vCarga: '0',
      cUnid: '01',
      qCarga: '0'
    }
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
      const response = await fetch(`${process.env.REACT_APP_API_URL || 'https://localhost:5001/api'}/mdfe/ultimo-numero`);

      const proximoNumero = response.ok
        ? ((await response.json()).ultimoNumero || 699) + 1
        : 700;

      setDados(dadosAtuais => ({
        ...dadosAtuais,
        ide: {
          ...dadosAtuais.ide,
          serie: '001',
          nMDF: proximoNumero.toString().padStart(9, '0')
        }
      }));
    } catch (error) {
      setDados(dadosAtuais => ({
        ...dadosAtuais,
        ide: {
          ...dadosAtuais.ide,
          serie: '001',
          nMDF: '000000700'
        }
      }));
    }
  };

  const carregarMDFe = async (mdfeId: string) => {
    setCarregandoDados(true);
    setErro('');

    try {
      const resultado = await mdfeService.obterMDFeWizard(parseInt(mdfeId));

      if (resultado.sucesso) {
        setDados(resultado.dados || {});
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

      // Atualizar apenas campos necessários diretamente
      const dadosAtualizados = {
        ...dados,
        ide: {
          ...dados.ide,
          dhEmi: agora,
          dhIniViagem: agora
        }
      };

      const resultado = id
        ? await mdfeService.atualizarMDFeWizard(parseInt(id), dadosAtualizados as MDFeData)
        : await mdfeService.criarMDFeWizard(dadosAtualizados as MDFeData);

      if (resultado.sucesso) {
        setMensagemSucesso('MDFe salvo com sucesso! Agora você pode transmitir para a SEFAZ.');
      } else {
        setErro(`Erro ao salvar MDFe: ${resultado.mensagem}`);
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
        setErro(`Erro ao carregar dados: ${resultadoCarregamento.mensagem}`);
        return;
      }

      const resultadoTransmissao = await mdfeService.enviarAssincrono();
      if (resultadoTransmissao.sucesso) {
        setMensagemSucesso('MDFe transmitido com sucesso para a SEFAZ!');
        setTimeout(() => navigate('/mdfes'), 2000);
      } else {
        setErro(`Erro na transmissão: ${resultadoTransmissao.mensagem}`);
      }
    } catch (error) {
      setErro('Erro inesperado ao transmitir MDFe. Tente novamente.');
    } finally {
      setTransmitindo(false);
    }
  };



  return (
    <>
      {/* Indicador de carregamento */}
      {carregandoDados && (
        <div style={{
          position: 'fixed',
          top: '20px',
          left: '50%',
          transform: 'translateX(-50%)',
          zIndex: 9999,
          padding: '1rem 1.5rem',
          background: 'linear-gradient(135deg, #3b82f6, #1d4ed8)',
          color: 'white',
          borderRadius: '12px',
          display: 'flex',
          alignItems: 'center',
          gap: '0.75rem',
          boxShadow: '0 10px 25px rgba(59, 130, 246, 0.3)',
          fontSize: '1rem',
          fontWeight: '500'
        }}>
          <i className="fas fa-spinner fa-spin" style={{ fontSize: '1.2rem' }}></i>
          Carregando dados do MDFe...
        </div>
      )}

      {erro && (
        <div className={styles.errorContainer}>
          <ErrorDisplay
            error={erro}
            type="block"
            onClose={() => setErro('')}
          />
        </div>
      )}

      {/* Mensagem de sucesso */}
      {mensagemSucesso && (
        <div style={{
          position: 'fixed',
          top: '20px',
          left: '50%',
          transform: 'translateX(-50%)',
          zIndex: 9999,
          padding: '1.25rem 2rem',
          background: 'linear-gradient(135deg, #10b981, #059669)',
          color: 'white',
          borderRadius: '12px',
          display: 'flex',
          alignItems: 'center',
          gap: '0.75rem',
          boxShadow: '0 10px 25px rgba(16, 185, 129, 0.3), 0 4px 12px rgba(0, 0, 0, 0.1)',
          border: '2px solid #34d399',
          fontSize: '1.1rem',
          fontWeight: '600',
          minWidth: '400px',
          animation: 'slideDown 0.5s ease-out, pulse 2s infinite'
        }}>
          <i className="fas fa-check-circle" style={{ fontSize: '1.5rem' }}></i>
          {mensagemSucesso}
        </div>
      )}

      <style>{`
        @keyframes slideDown {
          from {
            opacity: 0;
            transform: translateX(-50%) translateY(-20px);
          }
          to {
            opacity: 1;
            transform: translateX(-50%) translateY(0);
          }
        }

        @keyframes pulse {
          0%, 100% {
            box-shadow: 0 10px 25px rgba(16, 185, 129, 0.3), 0 4px 12px rgba(0, 0, 0, 0.1);
          }
          50% {
            box-shadow: 0 15px 35px rgba(16, 185, 129, 0.5), 0 6px 18px rgba(0, 0, 0, 0.15);
          }
        }
      `}</style>

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
      />
    </>
  );
}