import { useState, useEffect } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import { mdfeService } from '../../../services/mdfeService';
import { entitiesService } from '../../../services/entitiesService';
import { MDFeData } from '../../../types/mdfe';
import { MDFeWizard } from '../../../components/UI/Forms/MDFeWizard';
import { ErrorDisplay } from '../../../components/UI/ErrorDisplay/ErrorDisplay';
import styles from './FormularioMDFe.module.css';

export function FormularioMDFe() {
  const navigate = useNavigate();
  const { id } = useParams();
  const [salvando, setSalvando] = useState(false);
  const [carregando, setCarregando] = useState(false);
  const [erro, setErro] = useState<string>('');

  const [dados, setDados] = useState<Partial<MDFeData>>({
    ide: {
      cUF: '',
      tpAmb: '2',
      tpEmit: '1',
      tpTransp: '1',
      mod: '58',
      serie: '',
      nMDF: '',
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

  const carregarDadosIniciais = async () => {
    setCarregando(true);
    try {
      // Carregar entidades necessárias para o formulário
      const resultadoEmitentes = await entitiesService.obterEmitentes();
      if (resultadoEmitentes && resultadoEmitentes.length > 0) {
        // Dados carregados com sucesso
        console.log(`${resultadoEmitentes.length} emitentes carregados`);
      }
    } catch (error) {
      console.error('Erro ao carregar dados iniciais:', error);
      setErro('Erro ao carregar dados necessários para o formulário');
    } finally {
      setCarregando(false);
    }
  };

  const carregarMDFe = async (mdfeId: string) => {
    setCarregando(true);
    try {
      const resultado = await mdfeService.obterMDFeWizard(parseInt(mdfeId));
      if (resultado.sucesso) {
        setDados(resultado.dados);
      } else {
        console.error('Erro ao carregar MDFe:', resultado.mensagem);
        setErro(`Erro ao carregar MDFe: ${resultado.mensagem}`);
      }
    } catch (error) {
      console.error('Erro inesperado ao carregar MDFe:', error);
      setErro('Erro inesperado ao carregar MDFe. Tente novamente.');
    } finally {
      setCarregando(false);
    }
  };

  const atualizarCampo = (secao: string, campo: string, valor: any) => {
    setDados(prev => {
      const novosDados = { ...prev } as any;
      if (!novosDados[secao]) {
        novosDados[secao] = {};
      }
      novosDados[secao][campo] = valor;
      return novosDados;
    });
  };

  const atualizarSecao = (secao: string, dadosSecao: any) => {
    setDados(prev => {
      const novosDados = { ...prev } as any;
      novosDados[secao] = { ...(novosDados[secao] || {}), ...dadosSecao };
      return novosDados;
    });
  };


  const salvar = async () => {
    setSalvando(true);
    try {
      let resultado;

      if (id) {
        // Atualizar MDFe existente
        resultado = await mdfeService.atualizarMDFeWizard(parseInt(id), dados as MDFeData);
      } else {
        // Criar novo MDFe
        resultado = await mdfeService.criarMDFeWizard(dados as MDFeData);
      }

      if (resultado.sucesso) {
        navigate('/mdfes');
      } else {
        console.error('Erro ao salvar MDFe:', resultado.mensagem);
        setErro(`Erro ao salvar MDFe: ${resultado.mensagem}`);
      }
    } catch (error) {
      console.error('Erro inesperado ao salvar MDFe:', error);
      setErro('Erro inesperado ao salvar MDFe. Tente novamente.');
    } finally {
      setSalvando(false);
    }
  };

  const cancelar = () => {
    navigate('/mdfes');
  };


  if (carregando) {
    return (
      <div className={styles.loading}>
        <div className={styles.spinner}></div>
        <p>Carregando formulário...</p>
      </div>
    );
  }

  return (
    <div className={styles.formularioMdfe}>
      {erro && (
        <ErrorDisplay
          error={erro}
          type="block"
          onClose={() => setErro('')}
        />
      )}

      <MDFeWizard
        dados={dados}
        onDadosChange={setDados}
        onSalvar={salvar}
        onCancelar={cancelar}
        salvando={salvando}
        isEdicao={!!id}
      />
    </div>
  );
}