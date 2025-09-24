export type MDFeStep =
  | 'emitente-transporte'  // Emitente, Veículo, Motorista
  | 'origem-destino'       // Rota: origem, destino, percurso
  | 'documentos'           // Documentos fiscais transportados
  | 'carga-seguro'         // Informações da carga e seguro
  | 'emissao';             // Revisão final e emissão

export interface MDFeData {
  // IDs das entidades cadastradas (backend vai puxar dados completos)
  emitenteId?: number;
  veiculoId?: number; 
  motoristaId?: number;
  
  ide?: {
    cUF?: string;
    tpAmb?: '1' | '2'; // 1=Producao, 2=Homologacao
    tpEmit?: '1' | '2' | '3'; // 1=Normal, 2=Contingencia, 3=Regime Especial NFF
    tpTransp?: '1' | '2' | '3'; // 1=ETC, 2=TAC, 3=CTC
    mod?: string; // Modelo sempre 58
    serie?: string;
    nMDF?: string;
    cMDF?: string; // Codigo numerico aleatorio
    cDV?: string; // Digito verificador
    modal?: '1' | '2' | '3' | '4'; // 1=Rodoviario, 2=Aereo, 3=Aquaviario, 4=Ferroviario
    dhEmi?: string; // Data e hora de emissao
    tpEmis?: '1' | '2' | '3'; // Forma de emissao
    procEmi?: '0' | '3'; // Processo de emissao
    verProc?: string; // Versao do processo de emissao
    UFIni?: string; // UF de inicio do transporte
    UFFim?: string; // UF de fim do transporte
    infMunCarrega?: Array<{
      cMunCarrega?: string; // Codigo do municipio de carregamento
      xMunCarrega?: string; // Nome do municipio de carregamento  
    }>;
    infPercurso?: Array<{
      UFPer?: string; // UF de percurso
    }>;
    dhIniViagem?: string; // Data e hora prevista de inicio da viagem
  };
  emit?: {
    CNPJ?: string;
    CPF?: string; // Para pessoa fisica
    IE?: string;
    xNome?: string; // Razao social ou nome
    xFant?: string; // Nome fantasia
    enderEmit?: {
      xLgr?: string; // Logradouro
      nro?: string; // Numero
      xCpl?: string; // Complemento
      xBairro?: string; // Bairro
      cMun?: string; // Codigo do municipio IBGE
      xMun?: string; // Nome do municipio
      CEP?: string;
      UF?: string;
      fone?: string; // Telefone
      email?: string; // Email
    };
  };
  infModal?: {
    versaoModal?: string;
    rodo?: {
      infANTT?: {
        RNTRC?: string; // Registro Nacional dos Transportadores Rodoviarios de Carga
        infCIOT?: Array<{
          CIOT?: string; // Codigo Identificador da Operacao de Transporte
          CPF?: string; // CPF responsavel pela geracao do CIOT
          CNPJ?: string; // CNPJ responsavel pela geracao do CIOT
        }>;
        valePed?: {
          disp?: Array<{
            CNPJForn?: string; // CNPJ da empresa fornecedora do vale-pedagio
            CNPJPg?: string; // CNPJ do responsavel pelo pagamento do vale-pedagio
            nCompra?: string; // Numero do comprovante de compra
            vValePed?: string; // Valor do vale-pedagio
          }>;
        };
        infContratante?: Array<{
          xNome?: string; // Razao social ou nome do contratante
          CPF?: string;
          CNPJ?: string;
          idEstrangeiro?: string; // Identificacao do contratante estrangeiro
        }>;
        infPag?: Array<{
          xNome?: string; // Razao social ou nome do responsavel pelo pagamento
          CPF?: string;
          CNPJ?: string;
          idEstrangeiro?: string;
          Comp?: Array<{
            tpComp?: '1' | '2' | '3'; // Tipo do componente (Frete, Seguro, Outros)
            vComp?: string; // Valor do componente
            xComp?: string; // Descricao do componente
          }>;
          vContrato?: string; // Valor total do contrato
          indAltoDesemp?: '1'; // Indicador de operacao de alto desempenho
          indPag?: '0' | '1' | '2'; // Indicador da forma de pagamento
          vAdiant?: string; // Valor do adiantamento
        }>;
      };
      veicTracao?: {
        cInt?: string; // Codigo interno do veiculo
        placa?: string; // Placa do veiculo
        RENAVAM?: string; // RENAVAM do veiculo
        tara?: string; // Tara em KG
        capKG?: string; // Capacidade em KG
        capM3?: string; // Capacidade em M3
        tpRod?: '01' | '02' | '03' | '04' | '05' | '06'; // Tipo de rodado
        tpCar?: '00' | '01' | '02' | '03' | '04' | '05' | '06'; // Tipo de carroceria
        UF?: string; // UF de licenciamento do veiculo
        condutor?: Array<{
          xNome?: string; // Nome do motorista
          CPF?: string; // CPF do motorista
        }>;
        tpNav?: '0' | '1' | '2'; // Tipo de navegacao (so para aquaviario)
        irin?: string; // Irin da embarcacao (so para aquaviario)
      };
      veicReboque?: Array<{
        cInt?: string; // Codigo interno do veiculo
        placa?: string; // Placa do veiculo  
        RENAVAM?: string; // RENAVAM do veiculo
        tara?: string; // Tara em KG
        capKG?: string; // Capacidade em KG
        capM3?: string; // Capacidade em M3
        tpCar?: '00' | '01' | '02' | '03' | '04' | '05' | '06'; // Tipo de carroceria
        UF?: string; // UF de licenciamento do veiculo
        tpNav?: '0' | '1' | '2'; // Tipo de navegacao (so para aquaviario)
        irin?: string; // Irin da embarcacao (so para aquaviario)
      }>;
      codAgPorto?: string; // Codigo do agente portuario (so para aquaviario)
      lacRodo?: Array<{
        nLacre?: string; // Numero do lacre
      }>;
    };
    aereo?: {
      nac?: string; // Marca, modelo e numero de serie da aeronave
      matr?: string; // Matricula da aeronave
      nVoo?: string; // Numero do voo
      cAerEmb?: string; // Aerodromo de embarque
      cAerDes?: string; // Aerodromo de destino
      dVoo?: string; // Data do voo
    };
    aquav?: {
      irin?: string; // Irin da embarcacao
      tpEmb?: string; // Codigo do tipo de embarcacao
      cEmb?: string; // Codigo da embarcacao
      xEmb?: string; // Nome da embarcacao
      nViag?: string; // Numero da viagem
      cPrtEmb?: string; // Codigo do porto de embarque
      cPrtDest?: string; // Codigo do porto de destino
      prtTrans?: string; // Porto de transbordo
      tpNav?: '0' | '1' | '2'; // Tipo de navegacao
    };
    ferrov?: {
      trem?: {
        xPref?: string; // Prefixo do trem
        dhTrem?: string; // Data e hora de liberacao ou de chegada do trem
        xOri?: string; // Origem do trem
        xDest?: string; // Destino do trem
        qVag?: string; // Quantidade de vagoes
      };
      vag?: Array<{
        pesoBC?: string; // Peso base de calculo de frete em toneladas
        pesoR?: string; // Peso real em toneladas
        tpVag?: string; // Tipo de vagao
        serie?: string; // Serie de identificacao do vagao
        nVag?: string; // Numero de identificacao do vagao
        nSeq?: string; // Sequencia do vagao na composicao
        TU?: string; // Tonelada util
      }>;
    };
  };
  infDoc?: {
    infMunDescarga?: Array<{
      cMunDescarga?: string; // Codigo do municipio de descarregamento
      xMunDescarga?: string; // Nome do municipio de descarregamento
      infCTe?: Array<CTeMDFeInfo>;
      infNFe?: Array<NFeMDFeInfo>;
      infMDFeTransp?: Array<{
        chMDFe?: string; // Chave de acesso do MDFe de transporte
        indReentrega?: '1'; // Indicador de reentrega
        qtdRat?: string; // Quantidade rateada
        infUnidTransp?: Array<{
          tpUnidTransp?: '1' | '2' | '3' | '4' | '5' | '6'; // Tipo da unidade de transporte
          idUnidTransp?: string; // Identificacao da unidade de transporte
          qtdRat?: string; // Quantidade rateada
          lacUnidTransp?: Array<{
            nLacre?: string; // Numero do lacre
          }>;
          infUnidCarga?: Array<{
            tpUnidCarga?: '1' | '2' | '3' | '4'; // Tipo da unidade de carga
            idUnidCarga?: string; // Identificacao da unidade de carga
            qtdRat?: string; // Quantidade rateada
            lacUnidCarga?: Array<{
              nLacre?: string; // Numero do lacre
            }>;
          }>;
        }>;
        peri?: Array<{
          nONU?: string; // Numero ONU/UN
          xNomeAE?: string; // Nome apropriado para embarque do produto perigoso
          xClaRisco?: string; // Classe de risco do produto perigoso
          grEmb?: string; // Grupo de embalagem
          qTotProd?: string; // Quantidade total por produto
          qVolTipo?: string; // Quantidade e tipo de volumes
        }>;
      }>;
    }>;
  };
  seg?: Array<{
    infResp?: {
      respSeg?: '1' | '2' | '3' | '4' | '5'; // Responsavel pelo seguro
      CNPJ?: string;
      CPF?: string;
    };
    infSeg?: {
      xSeg?: string; // Nome da seguradora
      CNPJ?: string; // CNPJ da seguradora
    };
    nApol?: string; // Numero da apolice
    nAver?: Array<string>; // Numero da averbacao
  }>;
  tot?: {
    qCTe?: string; // Quantidade total de CT-e
    qNFe?: string; // Quantidade total de NF-e
    qMDFe?: string; // Quantidade total de MDF-e
    vCarga?: string; // Valor total da carga / mercadorias transportadas
    cUnid?: '01' | '02' | '03' | '04' | '05'; // Codigo da unidade de medida do peso bruto da carga
    qCarga?: string; // Peso bruto total da carga
  };
  lacres?: Array<{
    nLacre?: string; // Numero do lacre
  }>;
  infAdic?: {
    infCpl?: string; // Informacoes complementares de interesse do Fisco
    infAdFisco?: string; // Informacoes adicionais de interesse do Fisco
  };
  autXML?: Array<{
    CNPJ?: string; // CNPJ do autorizado
    CPF?: string; // CPF do autorizado
  }>;
}

export interface MensagemFeedback {
  id?: string;
  tipo: 'sucesso' | 'erro' | 'info' | 'aviso';
  titulo: string;
  mensagem: string;
  horario?: Date;
  detalhes?: string;
}

export interface ValidacaoEtapa {
  ehValida: boolean;
  erros: string[];
  avisos: string[];
}

export interface RespostaACBr {
  sucesso: boolean;
  mensagem: string;
  dados?: any;
  codigoErro?: string;
  detalhesValidacao?: Record<string, string[]>;
}

export interface ReciboConciliacaoData {
  numeroRecibo: string;
}

// Interfaces para entidades cadastradas
export interface EmitenteCadastrado {
  id: number;
  cnpj?: string;
  cpf?: string;
  ie?: string;
  razaoSocial: string; // Mapeado do backend RazaoSocial
  nomeFantasia?: string; // Mapeado do backend NomeFantasia
  endereco?: string; // Mapeado do backend Endereco
  numero?: string; // Mapeado do backend Numero
  complemento?: string; // Mapeado do backend Complemento
  bairro?: string; // Mapeado do backend Bairro
  codigoMunicipio?: number; // Mapeado do backend CodMunicipio
  municipio?: string; // Mapeado do backend Municipio
  cep?: string; // Mapeado do backend Cep
  uf: string; // Mapeado do backend Uf
  telefone?: string; // Mapeado do backend Telefone
  email?: string; // Mapeado do backend Email
  ativo: boolean; // Mapeado do backend Ativo
  tipoEmitente: string; // Mapeado do backend TipoEmitente
  descricaoEmitente?: string; // Mapeado do backend DescricaoEmitente
  caminhoArquivoCertificado?: string; // Mapeado do backend CaminhoArquivoCertificado
  rntrc?: string; // Mapeado do backend Rntrc
}

export interface VeiculoCadastrado {
  id: number;
  placa: string; // Mapeado do backend Placa
  renavam?: string; // Mapeado do backend Renavam
  marca?: string; // Mapeado do backend Marca
  modelo?: string; // Mapeado do backend Modelo
  ano?: number; // Mapeado do backend Ano
  cor?: string; // Mapeado do backend Cor
  combustivel?: string; // Mapeado do backend Combustivel
  tara: number; // Mapeado do backend Tara
  capacidadeKg: number; // Mapeado do backend CapacidadeKg
  capacidadeM3?: number; // Mapeado do backend CapacidadeM3
  tipoRodado?: string; // Mapeado do backend TipoRodado
  tipoCarroceria?: string; // Mapeado do backend TipoCarroceria
  uf: string; // Mapeado do backend Uf
  rntrc?: string; // Mapeado do backend Rntrc
  ativo: boolean; // Mapeado do backend Ativo
}

// Propriedades específicas para os documentos
export interface CTeMDFeInfo {
  chCTe?: string;
  SegCodBarra?: string;
  indReentrega?: '1';
  indPrestacaoParcial?: '1';
  vCarga?: string; // Valor da carga
  qCarga?: string; // Quantidade/peso da carga
  infUnidTransp?: Array<{
    tpUnidTransp?: '1' | '2' | '3' | '4' | '5' | '6';
    idUnidTransp?: string;
    qtdRat?: string;
    lacUnidTransp?: Array<{
      nLacre?: string;
    }>;
    infUnidCarga?: Array<{
      tpUnidCarga?: '1' | '2' | '3' | '4';
      idUnidCarga?: string;
      qtdRat?: string;
      lacUnidCarga?: Array<{
        nLacre?: string;
      }>;
    }>;
  }>;
  peri?: Array<{
    nONU?: string;
    xNomeAE?: string;
    xClaRisco?: string;
    grEmb?: string;
    qTotProd?: string;
    qVolTipo?: string;
  }>;
  infEntregaParcial?: {
    qtdTotal?: string;
    qtdParcial?: string;
  };
  infNFePrestParcial?: Array<{
    chNFe?: string;
  }>;
}

export interface NFeMDFeInfo {
  chNFe?: string;
  SegCodBarra?: string;
  indReentrega?: '1';
  PIN?: string;
  dPrev?: string;
  vNF?: string; // Valor da nota fiscal
  infUnidTransp?: Array<{
    tpUnidTransp?: '1' | '2' | '3' | '4' | '5' | '6';
    idUnidTransp?: string;
    qtdRat?: string;
    lacUnidTransp?: Array<{
      nLacre?: string;
    }>;
    infUnidCarga?: Array<{
      tpUnidCarga?: '1' | '2' | '3' | '4';
      idUnidCarga?: string;
      qtdRat?: string;
      lacUnidCarga?: Array<{
        nLacre?: string;
      }>;
    }>;
  }>;
  peri?: Array<{
    nONU?: string;
    xNomeAE?: string;
    xClaRisco?: string;
    grEmb?: string;
    qTotProd?: string;
    qVolTipo?: string;
  }>;
  infEntregaParcial?: {
    qtdTotal?: string;
    qtdParcial?: string;
  };
}