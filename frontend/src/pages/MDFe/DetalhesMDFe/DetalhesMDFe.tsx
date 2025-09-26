import React, { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { mdfeService } from '../../../services/mdfeService';
import styles from './DetalhesMDFe.module.css';

interface MDFeDetalhado {
  id: number;
  numero: string;
  serie: string;
  dataEmissao: string;
  ufInicio: string;
  ufFim: string;
  valorCarga: number;
  status: 'Autorizado' | 'Pendente' | 'Cancelado' | 'Rejeitado' | 'Rascunho';
  chaveAcesso?: string;
  emitenteNome: string;
  emitenteCnpj: string;
  veiculoPlaca: string;
  condutorNome?: string;
  observacoes?: string;
  dataTransmissao?: string;
  protocoloSefaz?: string;
  motivoRejeicao?: string;
}

export function DetalhesMDFe() {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const [mdfe, setMdfe] = useState<MDFeDetalhado | null>(null);
  const [carregando, setCarregando] = useState(true);
  const [processando, setProcessando] = useState<string | null>(null);
  const [mensagem, setMensagem] = useState<{ tipo: 'sucesso' | 'erro'; texto: string } | null>(null);

  useEffect(() => {
    if (id) {
      carregarMDFe(parseInt(id));
    }
  }, [id]);

  const carregarMDFe = async (mdfeId: number) => {
    try {
      setCarregando(true);

      const response = await fetch(`${process.env.REACT_APP_API_URL || 'https://localhost:5001/api'}/mdfe/${mdfeId}`);

      if (!response.ok) {
        throw new Error('MDFe não encontrado');
      }

      const data = await response.json();

      // Mapear dados da API para o formato esperado pelo componente
      const mdfeDetalhado: MDFeDetalhado = {
        id: data.id,
        numero: data.numeroMdfe?.toString().padStart(9, '0') || '',
        serie: data.serie?.toString() || '001',
        dataEmissao: data.dataEmissao,
        ufInicio: data.ufInicio || '',
        ufFim: data.ufFim || '',
        valorCarga: data.valorCarga || 0,
        status: mapearStatus(data.statusSefaz),
        chaveAcesso: data.chaveAcesso,
        emitenteNome: data.emitente?.razaoSocial || '',
        emitenteCnpj: data.emitente?.cnpj || '',
        veiculoPlaca: data.veiculo?.placa || '',
        condutorNome: data.condutor?.nome || '',
        observacoes: data.infoAdicional,
        dataTransmissao: data.dataTransmissao,
        protocoloSefaz: data.numeroProtocolo,
        motivoRejeicao: data.motivoRejeicao
      };

      setMdfe(mdfeDetalhado);
    } catch (error) {
      console.error('Erro ao carregar MDFe:', error);
      exibirMensagem('erro', 'Erro ao carregar os detalhes do MDFe');
    } finally {
      setCarregando(false);
    }
  };

  // Função auxiliar para mapear status da API
  const mapearStatus = (status: string): 'Autorizado' | 'Pendente' | 'Cancelado' | 'Rejeitado' | 'Rascunho' => {
    switch (status?.toUpperCase()) {
      case 'AUTORIZADO':
        return 'Autorizado';
      case 'CANCELADO':
        return 'Cancelado';
      case 'REJEITADO':
        return 'Rejeitado';
      case 'PENDENTE':
        return 'Pendente';
      case 'RASCUNHO':
      default:
        return 'Rascunho';
    }
  };

  const exibirMensagem = (tipo: 'sucesso' | 'erro', texto: string) => {
    setMensagem({ tipo, texto });
    setTimeout(() => setMensagem(null), 5000);
  };

  const handleTransmitir = async () => {
    if (!window.confirm('Deseja transmitir este MDFe para a SEFAZ?')) {
      return;
    }

    try {
      setProcessando('transmitir');

      const response = await fetch(`${process.env.REACT_APP_API_URL || 'https://localhost:5001/api'}/mdfe/${id}/transmitir`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        }
      });

      const resultado = await response.json();

      if (response.ok) {
        exibirMensagem('sucesso', 'MDFe transmitido com sucesso para a SEFAZ!');
        await carregarMDFe(parseInt(id!));
      } else {
        exibirMensagem('erro', resultado.message || 'Erro ao transmitir MDFe');
      }
    } catch (error) {
      console.error('Erro ao transmitir:', error);
      exibirMensagem('erro', 'Erro ao transmitir MDFe');
    } finally {
      setProcessando(null);
    }
  };

  const handleCancelar = async () => {
    const justificativa = window.prompt('Digite a justificativa para cancelamento (mínimo 15 caracteres):');

    if (!justificativa) {
      return;
    }

    if (justificativa.length < 15) {
      exibirMensagem('erro', 'Justificativa deve ter no mínimo 15 caracteres');
      return;
    }

    if (!window.confirm(`Deseja realmente cancelar este MDFe?\nEsta ação não pode ser desfeita.`)) {
      return;
    }

    try {
      setProcessando('cancelar');

      const response = await fetch(`${process.env.REACT_APP_API_URL || 'https://localhost:5001/api'}/mdfe/${id}/cancelar`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({ justificativa })
      });

      const resultado = await response.json();

      if (response.ok) {
        exibirMensagem('sucesso', 'MDFe cancelado com sucesso!');
        await carregarMDFe(parseInt(id!));
      } else {
        exibirMensagem('erro', resultado.message || 'Erro ao cancelar MDFe');
      }
    } catch (error) {
      console.error('Erro ao cancelar:', error);
      exibirMensagem('erro', 'Erro ao cancelar MDFe');
    } finally {
      setProcessando(null);
    }
  };

  const handleDownloadPDF = async () => {
    try {
      setProcessando('download');

      const response = await fetch(`${process.env.REACT_APP_API_URL || 'https://localhost:5001/api'}/mdfe/${id}/imprimir`, {
        method: 'GET',
        headers: {
          'Accept': 'application/pdf'
        }
      });

      if (!response.ok) {
        throw new Error('Erro ao gerar PDF');
      }

      const blob = await response.blob();
      const url = window.URL.createObjectURL(blob);
      const link = document.createElement('a');
      link.href = url;
      link.download = `DAMDFE_${mdfe?.numero}_${new Date().toISOString().split('T')[0]}.pdf`;
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
      window.URL.revokeObjectURL(url);

      exibirMensagem('sucesso', 'PDF baixado com sucesso!');
    } catch (error) {
      console.error('Erro ao baixar PDF:', error);
      exibirMensagem('erro', 'Erro ao baixar PDF');
    } finally {
      setProcessando(null);
    }
  };

  const handleDuplicar = async () => {
    if (!window.confirm('Deseja criar um novo MDFe baseado neste?')) {
      return;
    }

    try {
      setProcessando('duplicar');

      const response = await fetch(`${process.env.REACT_APP_API_URL || 'https://localhost:5001/api'}/mdfe/${id}/duplicar`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        }
      });

      const resultado = await response.json();

      if (response.ok) {
        exibirMensagem('sucesso', 'MDFe duplicado com sucesso!');
        setTimeout(() => {
          navigate(`/mdfes/editar/${resultado.id}`);
        }, 1500);
      } else {
        exibirMensagem('erro', resultado.message || 'Erro ao duplicar MDFe');
      }
    } catch (error) {
      console.error('Erro ao duplicar:', error);
      exibirMensagem('erro', 'Erro ao duplicar MDFe');
    } finally {
      setProcessando(null);
    }
  };

  const getStatusColor = (status: string) => {
    switch (status) {
      case 'Autorizado': return '#10b981';
      case 'Rascunho': return '#f59e0b';
      case 'Pendente': return '#3b82f6';
      case 'Rejeitado': return '#ef4444';
      case 'Cancelado': return '#6b7280';
      default: return '#6b7280';
    }
  };

  if (carregando) {
    return (
      <div className={styles.loading}>
        <i className="fas fa-spinner fa-spin"></i>
        <span>Carregando detalhes do MDFe...</span>
      </div>
    );
  }

  if (!mdfe) {
    return (
      <div className={styles.error}>
        <i className="fas fa-exclamation-triangle"></i>
        <span>MDFe não encontrado</span>
        <button onClick={() => navigate('/mdfes')} className={styles.backButton}>
          Voltar à Listagem
        </button>
      </div>
    );
  }

  return (
    <div className={styles.detalhesMdfe}>
      {/* Mensagem de Feedback */}
      {mensagem && (
        <div className={`${styles.mensagem} ${styles[mensagem.tipo]}`}>
          <i className={`fas ${
            mensagem.tipo === 'sucesso' ? 'fa-check-circle' : 'fa-exclamation-circle'
          }`}></i>
          {mensagem.texto}
          <button
            className={styles.fecharMensagem}
            onClick={() => setMensagem(null)}
          >
            <i className="fas fa-times"></i>
          </button>
        </div>
      )}

      {/* Header */}
      <header className={styles.header}>
        <div className={styles.headerLeft}>
          <button
            onClick={() => navigate('/mdfes')}
            className={styles.backButton}
          >
            <i className="fas fa-arrow-left"></i>
            Voltar
          </button>
          <div className={styles.titleSection}>
            <h1>MDFe #{mdfe.numero}</h1>
            <div
              className={styles.statusBadge}
              style={{ backgroundColor: getStatusColor(mdfe.status) }}
            >
              {mdfe.status}
            </div>
          </div>
        </div>

        <div className={styles.headerActions}>
          {/* Ações condicionais por status */}
          {mdfe.status === 'Rascunho' && (
            <>
              <button
                onClick={() => navigate(`/mdfes/editar/${mdfe.id}`)}
                className={`${styles.actionBtn} ${styles.edit}`}
                disabled={!!processando}
              >
                <i className="fas fa-edit"></i>
                Editar
              </button>
              <button
                onClick={handleTransmitir}
                className={`${styles.actionBtn} ${styles.transmit}`}
                disabled={!!processando}
              >
                {processando === 'transmitir' ? (
                  <i className="fas fa-spinner fa-spin"></i>
                ) : (
                  <i className="fas fa-paper-plane"></i>
                )}
                {processando === 'transmitir' ? 'Transmitindo...' : 'Transmitir'}
              </button>
            </>
          )}

          {mdfe.status === 'Rejeitado' && (
            <>
              <button
                onClick={() => navigate(`/mdfes/editar/${mdfe.id}`)}
                className={`${styles.actionBtn} ${styles.edit}`}
                disabled={!!processando}
              >
                <i className="fas fa-edit"></i>
                Corrigir & Editar
              </button>
              <button
                onClick={handleTransmitir}
                className={`${styles.actionBtn} ${styles.transmit}`}
                disabled={!!processando}
              >
                {processando === 'transmitir' ? (
                  <i className="fas fa-spinner fa-spin"></i>
                ) : (
                  <i className="fas fa-paper-plane"></i>
                )}
                {processando === 'transmitir' ? 'Retransmitindo...' : 'Retransmitir'}
              </button>
            </>
          )}

          {(mdfe.status === 'Autorizado' || mdfe.status === 'Pendente') && (
            <>
              <button
                onClick={handleDownloadPDF}
                className={`${styles.actionBtn} ${styles.download}`}
                disabled={!!processando}
              >
                {processando === 'download' ? (
                  <i className="fas fa-spinner fa-spin"></i>
                ) : (
                  <i className="fas fa-download"></i>
                )}
                PDF
              </button>
              <button
                onClick={handleCancelar}
                className={`${styles.actionBtn} ${styles.cancel}`}
                disabled={!!processando}
              >
                {processando === 'cancelar' ? (
                  <i className="fas fa-spinner fa-spin"></i>
                ) : (
                  <i className="fas fa-times"></i>
                )}
                Cancelar
              </button>
            </>
          )}

          {/* Duplicar sempre disponível (exceto cancelados) */}
          {mdfe.status !== 'Cancelado' && (
            <button
              onClick={handleDuplicar}
              className={`${styles.actionBtn} ${styles.duplicate}`}
              disabled={!!processando}
            >
              {processando === 'duplicar' ? (
                <i className="fas fa-spinner fa-spin"></i>
              ) : (
                <i className="fas fa-copy"></i>
              )}
              Duplicar
            </button>
          )}
        </div>
      </header>

      {/* Conteúdo Principal */}
      <div className={styles.content}>
        {/* Informações Básicas */}
        <div className={styles.section}>
          <h2>
            <i className="fas fa-info-circle"></i>
            Informações Básicas
          </h2>
          <div className={styles.infoGrid}>
            <div className={styles.infoItem}>
              <label>Número:</label>
              <span>{mdfe.numero}</span>
            </div>
            <div className={styles.infoItem}>
              <label>Série:</label>
              <span>{mdfe.serie}</span>
            </div>
            <div className={styles.infoItem}>
              <label>Data Emissão:</label>
              <span>{new Date(mdfe.dataEmissao).toLocaleString('pt-BR')}</span>
            </div>
            <div className={styles.infoItem}>
              <label>UF Origem:</label>
              <span>{mdfe.ufInicio}</span>
            </div>
            <div className={styles.infoItem}>
              <label>UF Destino:</label>
              <span>{mdfe.ufFim}</span>
            </div>
            <div className={styles.infoItem}>
              <label>Valor da Carga:</label>
              <span>R$ {mdfe.valorCarga.toLocaleString('pt-BR', { minimumFractionDigits: 2 })}</span>
            </div>
            {mdfe.chaveAcesso && (
              <div className={styles.infoItem} style={{ gridColumn: '1 / -1' }}>
                <label>Chave de Acesso:</label>
                <span className={styles.chaveAcesso}>{mdfe.chaveAcesso}</span>
              </div>
            )}
          </div>
        </div>

        {/* Emitente */}
        <div className={styles.section}>
          <h2>
            <i className="fas fa-building"></i>
            Emitente
          </h2>
          <div className={styles.infoGrid}>
            <div className={styles.infoItem}>
              <label>Razão Social:</label>
              <span>{mdfe.emitenteNome}</span>
            </div>
            <div className={styles.infoItem}>
              <label>CNPJ:</label>
              <span>{mdfe.emitenteCnpj}</span>
            </div>
          </div>
        </div>

        {/* Transporte */}
        <div className={styles.section}>
          <h2>
            <i className="fas fa-truck"></i>
            Transporte
          </h2>
          <div className={styles.infoGrid}>
            <div className={styles.infoItem}>
              <label>Veículo:</label>
              <span>{mdfe.veiculoPlaca}</span>
            </div>
            {mdfe.condutorNome && (
              <div className={styles.infoItem}>
                <label>Condutor:</label>
                <span>{mdfe.condutorNome}</span>
              </div>
            )}
          </div>
        </div>

        {/* Status e Protocolo */}
        {(mdfe.dataTransmissao || mdfe.protocoloSefaz || mdfe.motivoRejeicao) && (
          <div className={styles.section}>
            <h2>
              <i className="fas fa-exchange-alt"></i>
              Status SEFAZ
            </h2>
            <div className={styles.infoGrid}>
              {mdfe.dataTransmissao && (
                <div className={styles.infoItem}>
                  <label>Data Transmissão:</label>
                  <span>{new Date(mdfe.dataTransmissao).toLocaleString('pt-BR')}</span>
                </div>
              )}
              {mdfe.protocoloSefaz && (
                <div className={styles.infoItem}>
                  <label>Protocolo:</label>
                  <span>{mdfe.protocoloSefaz}</span>
                </div>
              )}
              {mdfe.motivoRejeicao && (
                <div className={styles.infoItem} style={{ gridColumn: '1 / -1' }}>
                  <label>Motivo Rejeição:</label>
                  <span className={styles.motivoRejeicao}>{mdfe.motivoRejeicao}</span>
                </div>
              )}
            </div>
          </div>
        )}

        {/* Observações */}
        {mdfe.observacoes && (
          <div className={styles.section}>
            <h2>
              <i className="fas fa-sticky-note"></i>
              Observações
            </h2>
            <div className={styles.observacoes}>
              {mdfe.observacoes}
            </div>
          </div>
        )}
      </div>
    </div>
  );
}