import { useState, useEffect } from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import { mdfeService } from '../../../services/mdfeService';
import { entitiesService } from '../../../services/entitiesService';
import { MDFeData, EmitenteCadastrado } from '../../../types/mdfe';
import { OptionalFieldsToggle, OptionalSection } from '../../../components/UI/Common/OptionalFieldsToggle';
import styles from './FormularioMDFe.module.css';

export function FormularioMDFe() {
  const navigate = useNavigate();
  const { id } = useParams();
  const [stepAtivo, setStepAtivo] = useState('dados');
  const [salvando, setSalvando] = useState(false);
  const [carregando, setCarregando] = useState(false);
  const [emitentes, setEmitentes] = useState<EmitenteCadastrado[]>([]);
  const [mostrarCamposOpcionais, setMostrarCamposOpcionais] = useState({
    dadosAvancados: false,
    configuracoes: false,
    observacoes: false,
    contratante: false,
    seguro: false,
    valePedagio: false
  });

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

  const steps = [
    { id: 'dados', titulo: '1. Dados Principais', valido: !!dados.ide?.nMDF && !!dados.ide?.serie },
    { id: 'emitente', titulo: '2. Emitente', valido: !!dados.emit?.CNPJ },
    { id: 'rota', titulo: '3. Rota', valido: !!dados.ide?.UFIni && !!dados.ide?.UFFim },
    { id: 'documentos', titulo: '4. Documentos', valido: true },
    { id: 'resumo', titulo: '5. Resumo', valido: true }
  ];

  useEffect(() => {
    carregarDadosIniciais();
    if (id) {
      carregarMDFe(id);
    }
  }, [id]);

  const carregarDadosIniciais = async () => {
    setCarregando(true);
    try {
      // Carregar emitentes
      const resultadoEmitentes = await emitenteService.listar();
      if (resultadoEmitentes.sucesso) {
        setEmitentes(resultadoEmitentes.dados || []);
      }
    } finally {
      setCarregando(false);
    }
  };

  const carregarMDFe = async (mdfeId: string) => {
    setCarregando(true);
    try {
      const resultado = await mdfeService.carregarRascunho(mdfeId);
      if (resultado.sucesso) {
        setDados(resultado.dados);
      }
    } finally {
      setCarregando(false);
    }
  };

  const atualizarCampo = (secao: string, campo: string, valor: any) => {
    setDados(prev => ({
      ...prev,
      [secao]: {
        ...prev[secao as keyof typeof prev],
        [campo]: valor
      }
    }));
  };

  const toggleCampoOpcional = (campo: keyof typeof mostrarCamposOpcionais) => {
    setMostrarCamposOpcionais(prev => ({
      ...prev,
      [campo]: !prev[campo]
    }));
  };

  const atualizarCampoAninhado = (secao: string, subsecao: string, campo: string, valor: any) => {
    setDados(prev => ({
      ...prev,
      [secao]: {
        ...prev[secao as keyof typeof prev],
        [subsecao]: {
          ...(prev[secao as keyof typeof prev] as any)?.[subsecao],
          [campo]: valor
        }
      }
    }));
  };

  const proximoStep = () => {
    const indiceAtual = steps.findIndex(s => s.id === stepAtivo);
    if (indiceAtual < steps.length - 1) {
      setStepAtivo(steps[indiceAtual + 1].id);
    }
  };

  const stepAnterior = () => {
    const indiceAtual = steps.findIndex(s => s.id === stepAtivo);
    if (indiceAtual > 0) {
      setStepAtivo(steps[indiceAtual - 1].id);
    }
  };

  const salvar = async () => {
    setSalvando(true);
    try {
      const resultado = await mdfeService.salvarRascunho(dados as MDFeData);
      if (resultado.sucesso) {
        navigate('/mdfes');
      }
    } finally {
      setSalvando(false);
    }
  };

  const cancelar = () => {
    navigate('/mdfes');
  };

  const renderizarStep = () => {
    switch (stepAtivo) {
      case 'dados':
        return (
          <div className={styles.stepContent}>
            <h3>Dados Principais do MDFe</h3>
            <div className={styles.grid2Cols}>
              <div className={styles.formGroup}>
                <label>Número do MDFe</label>
                <input
                  type="text"
                  value={dados.ide?.nMDF || ''}
                  onChange={(e) => atualizarCampo('ide', 'nMDF', e.target.value)}
                  placeholder="Digite o número do MDFe"
                  required
                />
              </div>
              <div className={styles.formGroup}>
                <label>Série</label>
                <input
                  type="text"
                  value={dados.ide?.serie || ''}
                  onChange={(e) => atualizarCampo('ide', 'serie', e.target.value)}
                  placeholder="Digite a série"
                  required
                />
              </div>
              <div className={styles.formGroup}>
                <label>Ambiente</label>
                <select
                  value={dados.ide?.tpAmb || '2'}
                  onChange={(e) => atualizarCampo('ide', 'tpAmb', e.target.value)}
                >
                  <option value="1">Produção</option>
                  <option value="2">Homologação</option>
                </select>
              </div>
              <div className={styles.formGroup}>
                <label>Tipo de Emissão</label>
                <select
                  value={dados.ide?.tpEmis || '1'}
                  onChange={(e) => atualizarCampo('ide', 'tpEmis', e.target.value)}
                >
                  <option value="1">Normal</option>
                  <option value="2">Contingência</option>
                </select>
              </div>
            </div>

            <OptionalFieldsToggle
              label="Configurações Avançadas"
              description="Tipo de transportador, modal e outras configurações"
              isExpanded={mostrarCamposOpcionais.dadosAvancados}
              onToggle={() => toggleCampoOpcional('dadosAvancados')}
              icon="fas fa-cogs"
            />

            <OptionalSection isVisible={mostrarCamposOpcionais.dadosAvancados}>
              <div className={styles.grid2Cols}>
                <div className={styles.formGroup}>
                  <label>Tipo de Transportador</label>
                  <select
                    value={dados.ide?.tpTransp || '1'}
                    onChange={(e) => atualizarCampo('ide', 'tpTransp', e.target.value)}
                  >
                    <option value="1">ETC - Empresa de Transporte de Carga</option>
                    <option value="2">TAC - Transportador Autônomo de Carga</option>
                    <option value="3">CTC - Cooperativa de Transporte de Carga</option>
                  </select>
                </div>
                <div className={styles.formGroup}>
                  <label>Modal de Transporte</label>
                  <select
                    value={dados.ide?.modal || '1'}
                    onChange={(e) => atualizarCampo('ide', 'modal', e.target.value)}
                  >
                    <option value="1">Rodoviário</option>
                    <option value="2">Aéreo</option>
                    <option value="3">Aquaviário</option>
                    <option value="4">Ferroviário</option>
                  </select>
                </div>
                <div className={styles.formGroup}>
                  <label>Processo de Emissão</label>
                  <select
                    value={dados.ide?.procEmi || '0'}
                    onChange={(e) => atualizarCampo('ide', 'procEmi', e.target.value)}
                  >
                    <option value="0">Aplicativo do contribuinte</option>
                    <option value="3">Aplicativo fisco</option>
                  </select>
                </div>
                <div className={styles.formGroup}>
                  <label>Versão do Processo</label>
                  <input
                    type="text"
                    value={dados.ide?.verProc || '1.0.0'}
                    onChange={(e) => atualizarCampo('ide', 'verProc', e.target.value)}
                    placeholder="Ex: 1.0.0"
                  />
                </div>
              </div>
            </OptionalSection>

            <OptionalFieldsToggle
              label="Data e Hora"
              description="Configurações de datas da viagem"
              isExpanded={mostrarCamposOpcionais.configuracoes}
              onToggle={() => toggleCampoOpcional('configuracoes')}
              icon="fas fa-calendar"
            />

            <OptionalSection isVisible={mostrarCamposOpcionais.configuracoes}>
              <div className={styles.grid2Cols}>
                <div className={styles.formGroup}>
                  <label>Data/Hora de Emissão</label>
                  <input
                    type="datetime-local"
                    value={dados.ide?.dhEmi || ''}
                    onChange={(e) => atualizarCampo('ide', 'dhEmi', e.target.value)}
                  />
                </div>
                <div className={styles.formGroup}>
                  <label>Data/Hora de Início da Viagem</label>
                  <input
                    type="datetime-local"
                    value={dados.ide?.dhIniViagem || ''}
                    onChange={(e) => atualizarCampo('ide', 'dhIniViagem', e.target.value)}
                  />
                </div>
              </div>
            </OptionalSection>
          </div>
        );

      case 'emitente':
        return (
          <div className={styles.stepContent}>
            <h3>Emitente do MDFe</h3>
            <div className={styles.formGroup}>
              <label>Selecione o Emitente</label>
              <select
                value={dados.emit?.CNPJ || ''}
                onChange={(e) => {
                  const emitenteSelecionado = emitentes.find(em => em.cnpj === e.target.value);
                  if (emitenteSelecionado) {
                    setDados(prev => ({
                      ...prev,
                      emit: {
                        CNPJ: emitenteSelecionado.cnpj || '',
                        IE: emitenteSelecionado.ie || '',
                        xNome: emitenteSelecionado.razaoSocial,
                        xFant: emitenteSelecionado.nomeFantasia || '',
                        enderEmit: {
                          xLgr: emitenteSelecionado.endereco || '',
                          nro: emitenteSelecionado.numero || '',
                          xCpl: emitenteSelecionado.complemento || '',
                          xBairro: emitenteSelecionado.bairro || '',
                          cMun: emitenteSelecionado.codigoMunicipio?.toString() || '',
                          xMun: emitenteSelecionado.municipio || '',
                          CEP: emitenteSelecionado.cep || '',
                          UF: emitenteSelecionado.uf,
                          fone: emitenteSelecionado.telefone || '',
                          email: emitenteSelecionado.email || ''
                        }
                      }
                    }));
                  }
                }}
                required
              >
                <option value="">Selecione um emitente</option>
                {emitentes.map(emitente => (
                  <option key={emitente.id} value={emitente.cnpj}>
                    {emitente.razaoSocial} ({emitente.cnpj})
                  </option>
                ))}
              </select>
            </div>
            {dados.emit?.CNPJ && (
              <div className={styles.emitenteInfo}>
                <h4>Dados do Emitente Selecionado</h4>
                <p><strong>Razão Social:</strong> {dados.emit.xNome}</p>
                <p><strong>CNPJ:</strong> {dados.emit.CNPJ}</p>
                <p><strong>IE:</strong> {dados.emit.IE}</p>
                <p><strong>Endereço:</strong> {dados.emit.enderEmit?.xLgr}, {dados.emit.enderEmit?.nro}</p>
                <p><strong>Cidade:</strong> {dados.emit.enderEmit?.xMun}/{dados.emit.enderEmit?.UF}</p>
              </div>
            )}
          </div>
        );

      case 'rota':
        return (
          <div className={styles.stepContent}>
            <h3>Rota do Transporte</h3>
            <div className={styles.grid2Cols}>
              <div className={styles.formGroup}>
                <label>UF de Início</label>
                <select
                  value={dados.ide?.UFIni || ''}
                  onChange={(e) => atualizarCampo('ide', 'UFIni', e.target.value)}
                  required
                >
                  <option value="">Selecione a UF de início</option>
                  <option value="AC">Acre</option>
                  <option value="AL">Alagoas</option>
                  <option value="AP">Amapá</option>
                  <option value="AM">Amazonas</option>
                  <option value="BA">Bahia</option>
                  <option value="CE">Ceará</option>
                  <option value="DF">Distrito Federal</option>
                  <option value="ES">Espírito Santo</option>
                  <option value="GO">Goiás</option>
                  <option value="MA">Maranhão</option>
                  <option value="MT">Mato Grosso</option>
                  <option value="MS">Mato Grosso do Sul</option>
                  <option value="MG">Minas Gerais</option>
                  <option value="PA">Pará</option>
                  <option value="PB">Paraíba</option>
                  <option value="PR">Paraná</option>
                  <option value="PE">Pernambuco</option>
                  <option value="PI">Piauí</option>
                  <option value="RJ">Rio de Janeiro</option>
                  <option value="RN">Rio Grande do Norte</option>
                  <option value="RS">Rio Grande do Sul</option>
                  <option value="RO">Rondônia</option>
                  <option value="RR">Roraima</option>
                  <option value="SC">Santa Catarina</option>
                  <option value="SP">São Paulo</option>
                  <option value="SE">Sergipe</option>
                  <option value="TO">Tocantins</option>
                </select>
              </div>
              <div className={styles.formGroup}>
                <label>UF de Destino</label>
                <select
                  value={dados.ide?.UFFim || ''}
                  onChange={(e) => atualizarCampo('ide', 'UFFim', e.target.value)}
                  required
                >
                  <option value="">Selecione a UF de destino</option>
                  <option value="AC">Acre</option>
                  <option value="AL">Alagoas</option>
                  <option value="AP">Amapá</option>
                  <option value="AM">Amazonas</option>
                  <option value="BA">Bahia</option>
                  <option value="CE">Ceará</option>
                  <option value="DF">Distrito Federal</option>
                  <option value="ES">Espírito Santo</option>
                  <option value="GO">Goiás</option>
                  <option value="MA">Maranhão</option>
                  <option value="MT">Mato Grosso</option>
                  <option value="MS">Mato Grosso do Sul</option>
                  <option value="MG">Minas Gerais</option>
                  <option value="PA">Pará</option>
                  <option value="PB">Paraíba</option>
                  <option value="PR">Paraná</option>
                  <option value="PE">Pernambuco</option>
                  <option value="PI">Piauí</option>
                  <option value="RJ">Rio de Janeiro</option>
                  <option value="RN">Rio Grande do Norte</option>
                  <option value="RS">Rio Grande do Sul</option>
                  <option value="RO">Rondônia</option>
                  <option value="RR">Roraima</option>
                  <option value="SC">Santa Catarina</option>
                  <option value="SP">São Paulo</option>
                  <option value="SE">Sergipe</option>
                  <option value="TO">Tocantins</option>
                </select>
              </div>
            </div>

            <OptionalFieldsToggle
              label="Municípios de Carregamento"
              description="Especificar municípios onde a carga será carregada"
              isExpanded={mostrarCamposOpcionais.observacoes}
              onToggle={() => toggleCampoOpcional('observacoes')}
              icon="fas fa-map-marker-alt"
            />

            <OptionalSection isVisible={mostrarCamposOpcionais.observacoes}>
              <div className={styles.formGroup}>
                <label>Informações de Percurso</label>
                <textarea
                  rows={3}
                  value=""
                  placeholder="Descreva o percurso, pontos de parada e observações sobre a rota..."
                />
              </div>
            </OptionalSection>
          </div>
        );

      case 'documentos':
        return (
          <div className={styles.stepContent}>
            <h3>Documentos Fiscais</h3>
            <div className={styles.acoesDocumentos}>
              <button type="button" className={styles.btnSecundario}>
                Adicionar CTe
              </button>
              <button type="button" className={styles.btnSecundario}>
                Adicionar NFe
              </button>
            </div>
            <div className={styles.listaDocumentos}>
              <p>Nenhum documento adicionado ainda.</p>
            </div>
          </div>
        );

      case 'resumo':
        return (
          <div className={styles.stepContent}>
            <h3>Resumo do MDFe</h3>
            <div className={styles.resumoGrid}>
              <div className={styles.resumoItem}>
                <strong>Número:</strong> {dados.ide?.nMDF || 'Não informado'}
              </div>
              <div className={styles.resumoItem}>
                <strong>Série:</strong> {dados.ide?.serie || 'Não informado'}
              </div>
              <div className={styles.resumoItem}>
                <strong>Emitente:</strong> {dados.emit?.xNome || 'Não selecionado'}
              </div>
              <div className={styles.resumoItem}>
                <strong>Rota:</strong> {dados.ide?.UFIni || '?'} → {dados.ide?.UFFim || '?'}
              </div>
              <div className={styles.resumoItem}>
                <strong>Ambiente:</strong> {dados.ide?.tpAmb === '1' ? 'Produção' : 'Homologação'}
              </div>
            </div>

            <OptionalFieldsToggle
              label="Dados do Contratante"
              description="Informações sobre quem contratou o serviço"
              isExpanded={mostrarCamposOpcionais.contratante}
              onToggle={() => toggleCampoOpcional('contratante')}
              icon="fas fa-handshake"
            />

            <OptionalSection isVisible={mostrarCamposOpcionais.contratante}>
              <div className={styles.grid2Cols}>
                <div className={styles.formGroup}>
                  <label>CNPJ do Contratante</label>
                  <input
                    type="text"
                    placeholder="00.000.000/0000-00"
                  />
                </div>
                <div className={styles.formGroup}>
                  <label>Razão Social</label>
                  <input
                    type="text"
                    placeholder="Nome da empresa contratante"
                  />
                </div>
              </div>
            </OptionalSection>

            <OptionalFieldsToggle
              label="Seguro da Carga"
              description="Informações sobre o seguro da mercadoria"
              isExpanded={mostrarCamposOpcionais.seguro}
              onToggle={() => toggleCampoOpcional('seguro')}
              icon="fas fa-shield-alt"
            />

            <OptionalSection isVisible={mostrarCamposOpcionais.seguro}>
              <div className={styles.grid2Cols}>
                <div className={styles.formGroup}>
                  <label>Responsável pelo Seguro</label>
                  <select>
                    <option value="">Selecione</option>
                    <option value="1">Emitente do MDF-e</option>
                    <option value="2">Contratante do serviço</option>
                    <option value="3">Destinatário</option>
                    <option value="4">Remetente</option>
                    <option value="5">Outros</option>
                  </select>
                </div>
                <div className={styles.formGroup}>
                  <label>Nome da Seguradora</label>
                  <input
                    type="text"
                    placeholder="Nome da empresa seguradora"
                  />
                </div>
                <div className={styles.formGroup}>
                  <label>Número da Apólice</label>
                  <input
                    type="text"
                    placeholder="Número da apólice de seguro"
                  />
                </div>
                <div className={styles.formGroup}>
                  <label>Número da Averbação</label>
                  <input
                    type="text"
                    placeholder="Número da averbação"
                  />
                </div>
              </div>
            </OptionalSection>

            <OptionalFieldsToggle
              label="Vale-Pedágio"
              description="Informações sobre vale-pedágio utilizado"
              isExpanded={mostrarCamposOpcionais.valePedagio}
              onToggle={() => toggleCampoOpcional('valePedagio')}
              icon="fas fa-road"
            />

            <OptionalSection isVisible={mostrarCamposOpcionais.valePedagio}>
              <div className={styles.grid2Cols}>
                <div className={styles.formGroup}>
                  <label>CNPJ do Fornecedor</label>
                  <input
                    type="text"
                    placeholder="CNPJ da empresa do vale-pedágio"
                  />
                </div>
                <div className={styles.formGroup}>
                  <label>Número do Comprovante</label>
                  <input
                    type="text"
                    placeholder="Número do comprovante de compra"
                  />
                </div>
                <div className={styles.formGroup}>
                  <label>Valor do Vale</label>
                  <input
                    type="number"
                    step="0.01"
                    placeholder="0,00"
                  />
                </div>
              </div>
              <div className={styles.formGroup}>
                <label>
                  <input
                    type="checkbox"
                    style={{ marginRight: '8px' }}
                  />
                  Transporte sem vale-pedágio
                </label>
              </div>
            </OptionalSection>
          </div>
        );

      default:
        return <div>Step não encontrado</div>;
    }
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
      {/* Cabeçalho */}
      <header className={styles.header}>
        <div className={styles.headerLeft}>
          <button type="button" onClick={cancelar} className={styles.btnVoltar}>
            ← Voltar
          </button>
        </div>
        <h1>{id ? 'Editar MDFe' : 'Novo MDFe'}</h1>
        <div className={styles.headerRight}>
          <button type="button" onClick={cancelar} className={styles.btnSecundario}>
            Cancelar
          </button>
          <button
            type="button"
            onClick={salvar}
            className={styles.btnPrimario}
            disabled={salvando}
          >
            {salvando ? 'Salvando...' : 'Salvar'}
          </button>
        </div>
      </header>

      {/* Navegação dos Steps */}
      <nav className={styles.stepsNav}>
        {steps.map(step => (
          <button
            key={step.id}
            type="button"
            className={`${styles.stepBtn} ${stepAtivo === step.id ? styles.ativo : ''} ${step.valido ? styles.valido : ''}`}
            onClick={() => setStepAtivo(step.id)}
          >
            {step.titulo}
            {step.valido && <span className={styles.check}>✓</span>}
          </button>
        ))}
      </nav>

      {/* Conteúdo do Step */}
      <main className={styles.stepContainer}>
        {renderizarStep()}
      </main>

      {/* Rodapé com Botões */}
      <footer className={styles.footer}>
        <div className={styles.botoesEsquerda}>
          {stepAtivo !== steps[0].id && (
            <button type="button" onClick={stepAnterior} className={styles.btnSecundario}>
              ← Anterior
            </button>
          )}
        </div>
        <div className={styles.botoesDireita}>
          {stepAtivo !== steps[steps.length - 1].id && (
            <button type="button" onClick={proximoStep} className={styles.btnPrimario}>
              Próximo →
            </button>
          )}
          {stepAtivo === steps[steps.length - 1].id && (
            <button
              type="button"
              onClick={salvar}
              className={styles.btnPrimario}
              disabled={salvando}
            >
              {salvando ? 'Salvando...' : 'Salvar MDFe'}
            </button>
          )}
        </div>
      </footer>
    </div>
  );
}