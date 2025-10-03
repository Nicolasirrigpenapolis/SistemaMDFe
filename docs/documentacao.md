# **Documentação de Comandos do Objeto MDFe**

Esta documentação consolida os comandos para a emissão e gerenciamento de Manifesto Eletrônico de Documentos Fiscais (MDF-e) com base nos arquivos fornecidos.

## **1\. Configurações**

### **MDFe.SetCertificado**

Define o certificado digital que será utilizado para assinar os documentos.

**Sintaxe (Caminho do Arquivo):**

MDFE.SetCertificado(cCertificado, cSenha)

**Parâmetros:**

* cCertificado: Caminho do arquivo do Certificado Digital (.pfx).  
* cSenha: Senha do Certificado.

**Sintaxe (Número de Série):**

MDFE.SetCertificado(cCertificado)

**Parâmetros:**

* cCertificado: Número de Série do Certificado instalado no Windows.

### **MDFe.ObterCertificados**

Retorna uma lista com as informações de todos os certificados digitais instalados na máquina.

**Sintaxe:**

MDFe.ObterCertificados

Retorno:  
As informações dos certificados são listadas e separadas por | (pipe) na seguinte ordem: Numero Serie | RazaoSocial | CNPJ | DataVenc | Certificadora.

### **MDFe.CertificadoDataVencimento**

Retorna a data de vencimento do certificado digital atualmente configurado no ACBrMonitor.

**Sintaxe:**

MDFe.CertificadoDataVencimento

### **MDFe.SetAmbiente**

Configura o ambiente de destino para o envio dos documentos.

**Sintaxe:**

MDFe.SetAmbiente(nNumAmbiente)

**Parâmetros:**

* nNumAmbiente: 1 para Ambiente de Produção ou 2 para Ambiente de Homologação.

### **MDFe.SetVersaoDF**

Define a versão do layout do MDF-e a ser utilizado.

**Sintaxe:**

MDFe.SetVersaoDF(nVersao)

**Parâmetros:**

* nVersao: Versão do documento, por exemplo: "1.00" ou "3.00".

### **MDFe.SetFormaEmissao**

Define a forma de emissão do MDF-e (Normal, Contingência, etc.).

**Sintaxe:**

MDFe.SetFormaEmissao(nFormaEmissao)

**Parâmetros:**

* nFormaEmissao: 1 \- Normal, 2 \- Contingência, 3 \- SCAN, 4 \- DPEC, 5 \- FSDA, 6 \- SVCAN, 7 \- SVCRS, 8 \- SVCSP ou 9 \- OffLine.

### **MDFe.SetTipoImpressao**

Define a orientação da impressão do DAMDFe.

**Sintaxe:**

MDFe.SetTipoImpressao(nTipoImpressao)

**Parâmetros:**

* nTipoImpressao: 1 para Retrato ou 2 para Paisagem.

### **MDFe.SetLogoMarca**

Define um arquivo de imagem para ser usado como logomarca no DAMDFe.

**Sintaxe:**

MDFe.SetLogomarca(nLogo)

**Parâmetros:**

* nLogo: Caminho completo do arquivo de imagem (ex: "C:\\ACBrMonitorPlus\\Logo.png").

## **2\. Criação e Envio de MDFe**

### **Envio Individual**

#### **MDFe.CriarMDFe**

Cria, valida e assina o arquivo XML do MDF-e a partir de um arquivo .ini, mas não o envia.

**Sintaxe:**

MDFe.CriarMDFe(cIniMDFe, \[bRetornaXML\])

**Parâmetros:**

* cIniMDFe: Caminho do arquivo .ini com as informações do MDF-e.  
* bRetornaXML (Opcional): Informe 1 para retornar o conteúdo do XML gerado.

#### **MDFe.CriarEnviarMDFe**

Cria e envia um MDF-e em um único comando, a partir de um arquivo .ini.

**Sintaxe:**

MDFE.CRIARENVIARMDFE(cIniMDFe, \[nLote\], \[nImprimir\], \[nImpressora\], \[bAssincrono\], \[bPreview\], \[nCopias\], \[bGerarPDF\], \[bEncerrado\])

**Parâmetros:**

* cIniMDFe: Caminho do arquivo .ini com as informações do MDF-e.  
* Outros parâmetros são opcionais para impressão e configuração do envio.

#### **MDFe.EnviarMDFe**

Envia um arquivo XML de MDF-e previamente gerado.

**Sintaxe:**

MDFE.ENVIARMDFe(nXMLMDFe, \[nLote\], \[nAssinar\], \[nImprimi\], \[nImpressora\], \[bAssincrono\], \[bEncerrado\])

**Parâmetros:**

* nXMLMDFe: Caminho completo do arquivo XML do MDF-e.

### **Envio em Lote**

#### **MDFe.AdicionarMDFe**

Adiciona um MDF-e (baseado em um arquivo .ini) a um lote para envio posterior.

**Sintaxe:**

MDFe.AdicionarMDFe(cIniMDFe, nLote)

**Parâmetros:**

* cIniMDFe: Caminho do arquivo .ini com as informações do MDF-e.  
* nLote: Número para identificar o lote.

#### **MDFe.EnviarLoteMDFe**

Envia um lote de MDF-e previamente montado com o comando AdicionarMDFe.

**Sintaxe:**

MDFe.EnviarLoteMDFe(nLote, nLoteEnvio, \[bImprimir\], \[nImpressora\], \[bPreview\], \[nCopia\], \[bGerarPDF\], \[bEncerrado\])

**Parâmetros:**

* nLote: Número do lote que contém os XMLs.  
* nLoteEnvio: Número do lote para o envio.

## **3\. Enviar Evento**

### **MDFe.EnviarEvento**

Envia um evento (cancelamento, encerramento, etc.) associado a um MDF-e.

**Sintaxe:**

MDFe.EnviarEvento(cIniEvento)

**Parâmetros:**

* cIniEvento: Caminho do arquivo .ini com os dados do evento.

### **Modelos de Evento .INI**

#### **Cancelamento**

\[EVENTO\]  
idLote=1

\[EVENTO001\]  
cOrgao=\<informar o código da UF do emitente\>  
CNPJCPF=\<CNPJ/CPF do emitente\>  
chMDFe=\<chave do MDFe\>  
dhEvento=\<data e hora do evento\>  
tpEvento=110111  
nSeqEvento=1  
versaoEvento=3.00  
nProt=\<numero do protocolo de autorização do MDFe a ser cancelado\>  
xJust=\<informar o motivo do cancelamento (mínimo 15 e máximo 255 caracteres)\>

#### **Encerramento**

\[EVENTO\]  
idLote=1

\[EVENTO001\]  
cOrgao=\<informar o código da UF do emitente\>  
CNPJCPF=\<CNPJ/CPF do emitente\>  
chMDFe=\<chave do MDFe\>  
dhEvento=\<data e hora do evento\>  
tpEvento=110112  
nSeqEvento=1  
versaoEvento=3.00  
nProt=\<numero do protocolo de autorização do MDFe a ser Encerrado\>  
dtEnc=\<Data do Encerramento\>  
cUF=\<Código da UF do Encerramento\>  
cMun=\<Código IBGE do Município do Encerramento\>

#### **Inclusão de Condutor**

\[EVENTO\]  
idLote=1

\[EVENTO001\]  
cOrgao=\<informar o código da UF do emitente\>  
CNPJCPF=\<CNPJ/CPF do emitente\>  
chMDFe=\<chave do MDFe\>  
dhEvento=\<data e hora do evento\>  
tpEvento=110114  
nSeqEvento=1  
versaoEvento=3.00  
xNome=\<Nome do Condutor\>  
CPF=\<CPF do Condutor\>

#### **Inclusão de DF-e**

\[EVENTO\]  
idLote=1

\[EVENTO001\]  
cOrgao=\<informar o código da UF do emitente\>  
CNPJCPF=\<CNPJ/CPF do emitente\>  
chMDFe=\<chave do MDFe\>  
dhEvento=\<data e hora do evento\>  
tpEvento=110115  
nSeqEvento=1  
versaoEvento=3.00  
nProt=\<numero do protocolo de autorização do MDF-e\>  
cMunCarrega=\<código IBGE do município onde ocorreu o carregamento\>  
xMunCarrega=\<descrição do município\>

\[infDoc0001\]  
cMunDescarga=\<código IBGE do município de descarregamento\>  
xMunDescarga=\<descrição do município\>  
chNFe=\<chave da NF-e a ser incluída\>

#### **Pagamento da Operação de Transporte**

\[EVENTO\]  
idLote=1

\[EVENTO001\]  
cOrgao=\<informar o código da UF do emitente\>  
CNPJCPF=\<CNPJ/CPF do emitente\>  
chMDFe=\<chave do MDFe\>  
dhEvento=\<data e hora do evento\>  
tpEvento=110116  
nSeqEvento=1  
versaoEvento=3.00  
nProt=\<numero do protocolo de autorização do MDFe\>

\[infViagens\]  
qtdViagens=\<Quantidade total de viagens\>  
nroViagem=\<Número de referência da viagem\>

\[infPag001\]  
CNPJCPF=\<CNPJ/CPF do contratante\>  
xNome=\<Nome do contratante\>  
vContrato=\<Valor total do contrato\>  
indPag=\<0=À Vista; 1=À Prazo\>  
vAdiant=\<Valor do Adiantamento\>

\[Comp001001\]  
tpComp=\<01=Vale Pedágio; 02=Impostos; 03=Despesas; 99=Outros\>  
vComp=\<Valor do Componente\>  
xComp=\<Descrição do componente\>

\[infPrazo001001\]  
nParcela=\<Número da parcela\>  
dVenc=\<Data de vencimento\>  
vParcela=\<Valor da parcela\>

\[infBanc001\]  
codBanco=\<Número do banco\>  
codAgencia=\<Número da Agência\>  
CNPJIPEF=\<CNPJ da Instituição de Pagamento\>

## **4\. Impressão**

### **MDFe.ImprimirDAMDFe**

Imprime o DAMDFe de um arquivo XML.

**Sintaxe:**

MDFE.IMPRIMIRDAMDFE(cArqXML, \[cImpressora\], \[nNumCopias\], \[cProtocolo\], \[bPreview\], \[bEncerrado\])

### **MDFe.ImprimirDAMDFePDF**

Gera e salva o DAMDFe em um arquivo PDF.

**Sintaxe:**

MDFE.IMPRIMIRDAMDFEPDF(cArqXML, \[cProtocolo\], \[bEncerrado\])

### **MDFe.ImprimirEvento**

Imprime o documento de um evento.

**Sintaxe:**

MDFE.IMPRIMIREVENTO(nXMLEvento, nXMLMDFe, \[nImpressora\], \[nCopias\], \[bPreview\])

### **MDFe.ImprimirEventoPDF**

Gera e salva o documento de um evento em um arquivo PDF.

**Sintaxe:**

MDFE.IMPRIMIREVENTOPDF(nXMLEvento, nXMLMDFe)

## **5\. Envio por Email**

### **MDFe.EnviarEmail**

Envia por e-mail o XML e o PDF (opcional) de um MDF-e autorizado.

**Sintaxe:**

MDFE.EnviarEmail(cEmailDestino, cArqXML, \[cEnviaPDF\], \[cAssunto\], \[cEmailsCopias\], \[cAnexos\], \[cReplayTo\])

### **MDFe.EnviarEmailEvento**

Envia por e-mail o XML e o PDF (opcional) de um evento.

**Sintaxe:**

MDFe.EnviarEmailEvento(cEmailDestino, cArqXMLEvento, \[cArqXMLMDFe\], cEnviaPDF, \[cAssunto\], \[cEmailsCopias\], \[cAnexos\], \[cReplayTo\])

## **6\. Consultas**

### **MDFe.ReciboMDFe**

Consulta o status de um lote de MDF-e enviado de forma assíncrona.

**Sintaxe:**

MDFE.ReciboMDFe(nRecibo)

**Parâmetros:**

* nRecibo: Número do Recibo retornado no envio do lote.

### **MDFe.DistribuicaoDFe**

Busca por documentos (MDF-e e eventos) destinados a um CNPJ.

**Sintaxe:**

MDFe.DistribuicaoDFePorNSU(cCNPJ, nNSU)  
MDFe.DistribuicaoDFePorUltNSU(cCNPJ, nUltNSU)

**Parâmetros:**

* cCNPJ: CNPJ do interessado.  
* nNSU: Número Sequencial Único a ser consultado.  
* nUltNSU: Último NSU que a empresa possui para obter os próximos.

## **7\. Utilitários**

### **MDFe.GerarChave**

Gera a chave de acesso de um MDF-e com base nos parâmetros fornecidos.

**Sintaxe:**

MDFe.GerarChave(codigoUF, codigoNumerico, modelo, serie, numero, tpemi, emissao, CNPJ)

**Parâmetros:**

* codigoUF: Código da UF.  
* codigoNumerico: Código Numérico.  
* modelo: Modelo do documento.  
* serie: Série do documento.  
* numero: Número do MDFe.  
* tpemi: Tipo de Emissão.  
* emissao: Data de Emissão.  
* CNPJ: CNPJ do emissor.

### **MDFe.GetPathMDFe**

Retorna o caminho do diretório padrão onde os XMLs de MDF-e são salvos.

**Sintaxe:**

MDFe.GetPathMDFe(\[dData\], \[cCNPJ\], \[cIE\])

### **MDFe.GetPathEvento**

Retorna o caminho do diretório padrão para um tipo de evento específico.

**Sintaxe:**

MDFe.GetPathEvento(cEvento, \[cCNPJ\], \[cIE\], \[dData\])

**Parâmetros:**

* cEvento: Código do Evento (ex: "110111" para Cancelamento).

### **MDFe.GetPathCan**

Retorna o caminho do diretório padrão para eventos de cancelamento.

**Sintaxe:**

MDFe.GetPathCan(\[cCNPJ\], \[cIE\], \[dData\])

### **MDFe.MDFeToTxt**

Converte um arquivo XML de MDF-e para o formato .txt.

**Sintaxe:**

MDFe.MDFeToTXT(cArqXML, \[cNomeArqTXT\])

### **MDFe.LerMDFe**

Lê um arquivo XML de MDF-e e retorna seus dados no formato .ini.

**Sintaxe:**

MDFe.LerMDFe(cArqXML)

### **MDFe.FileExists**

Verifica se um determinado arquivo existe no diretório do ACBrMonitor.

**Sintaxe:**

MDFe.FileExists(cNomeArq)

### **MDFe.SaveToFile**

Salva um conteúdo de texto em um arquivo.

**Sintaxe:**

MDFe.SaveToFile(cNomeArq, cConteudoArquivo)

### **MDFe.LoadFromFile**

Lê o conteúdo de um arquivo.

**Sintaxe:**

MDFe.LoadfromFile(cNomeArq, \[nSegundos\])

### **MDFe.LerIni**

Lê o arquivo de configuração ACBrMonitor.ini e carrega todos os parâmetros.

**Sintaxe:**

MDFe.LerIni

## **8\. Comandos do Monitor**

### **MDFe.Ativo**

Verifica se o ACBrMonitorPlus está em execução.

**Sintaxe:**

MDFe.Ativo

### **MDFe.Versao**

Retorna a versão atual do ACBrMonitorPlus.

**Sintaxe:**

MDFe.Versao

### **MDFe.Data**

Retorna a data atual no formato dd/mm/yyyy.

**Sintaxe:**

MDFe.Data

### **MDFe.Hora**

Retorna a hora atual no formato hh:nn:ss.

**Sintaxe:**

MDFe.Hora

### **MDFe.DataHora**

Retorna a data e hora atuais no formato dd/mm/yyyy hh:nn:ss.

**Sintaxe:**

MDFe.DataHora

### **MDFe.Ocultar**

Oculta a janela do ACBrMonitorPlus.

**Sintaxe:**

MDFe.Ocultar

### **MDFe.Restaurar**

Restaura a janela do ACBrMonitorPlus.

**Sintaxe:**

MDFe.Restaurar

### **MDFe.EncerrarMonitor**

Encerra a execução do ACBrMonitorPlus.

**Sintaxe:**

MDFe.EncerrarMonitor

### **MDFe.exit \- bye \- fim**

Desconecta o cliente do ACBrMonitorPlus quando a comunicação é via TCP/IP.

**Sintaxe:**

MDFe.exit

## **9\. Guia de Emissão (Passo a Passo)**

A emissão de um MDF-e pode ser feita de diferentes maneiras, seja com um único comando que executa todas as etapas ou com comandos separados para cada passo.

**Observação:** Antes de emitir, as configurações de Certificado, SSL e ambiente do WebService devem ser configuradas previamente no ACBrMonitor, na aba "DFe".

### **Modo 1: Emissão com Comando Único**

Esta é a forma mais simples, onde você passa os dados para gerar o XML, enviar ao fisco e imprimir (opcionalmente) com um só comando.

1. **Utilize o método CriarEnviarMDFe**  
   MDFe.CriarEnviarMDFe("C:\\ACBrMonitorPLUS\\Entrada\\MDFe.INI", 1, 1\)

   * **Primeiro parâmetro:** O caminho para o arquivo MDFe.INI com todos os dados do manifesto. Alternativamente, todo o conteúdo do arquivo .ini pode ser passado como uma string entre aspas.  
   * **Segundo Parâmetro (Opcional):** O número do Lote. O padrão é 1\. Este método envia um MDF-e por vez.  
   * **Terceiro Parâmetro (Opcional):** Informa se o DAMDFe deve ser impresso caso seja autorizado. Use 1 para imprimir.

### **Modo 2: Emissão com Comandos Separados**

Este modo oferece mais controle sobre cada etapa do processo de emissão.

1. **Crie o XML com CriarMDFe**  
   MDFe.CriarMDFe("C:\\ACBrMonitorPLUS\\Entrada\\MDFe.INI")

2. **Envie o XML com EnviarMDFe**  
   MDFe.EnviarMDFe("C:\\ACBrMonitorPlus\\Logs\\35XXXXXXXXXXXXXXXX550010000000050000000058-mdfe.xml")

   * **Primeiro parâmetro:** O caminho do XML gerado no passo anterior. O conteúdo do XML também pode ser passado diretamente como string.  
3. **Imprima o DAMDFe com ImprimirDAMDFe**  
   MDFe.ImprimirDAMDFe("C:\\ACBrMonitorPlus\\Arqs\\35XXXXXXXXXXXXXXXX550010000000050000000058-mdfe.xml")

   * **Primeiro parâmetro:** O caminho do XML autorizado após o envio.

### **Como Encerrar um MDFe (Importante)**

Todo manifesto deve ser **Encerrado** ao final do transporte ou **Cancelado** (caso o transporte não seja executado). Esta ação é obrigatória para que seja possível emitir um novo MDF-e para o mesmo veículo.

O encerramento é realizado através do envio de um evento de encerramento.

**Exemplo:**

MDFe.EnviarEvento("C:\\caminho\\para\\seu\\evento\_encerramento.ini")

O conteúdo do arquivo evento\_encerramento.ini deve seguir o modelo especificado na **seção 3** desta documentação.

## **10\. Preenchimento do Arquivo .INI**

Aqui estão as informações e regras para o correto preenchimento do arquivo .INI utilizado para gerar o MDF-e.

* A descrição dos campos no arquivo .INI utiliza a nomenclatura oficial do Manual de Orientações do Contribuinte do MDF-e, disponibilizado pela SEFAZ. Apenas os nomes dos grupos (que estão entre colchetes \[ \]) seguem uma nomenclatura interna do ACBr.  
* Para o preenchimento correto, é imprescindível consultar o Manual e as Notas Técnicas (NTs) da SEFAZ para entender cada campo e seus códigos.  
* Alguns grupos \[ \] e campos não são obrigatórios (conforme o manual da SEFAZ) e podem ser removidos do arquivo .INI caso não sejam preenchidos.

### **Especificação dos Grupos**

A numeração nos nomes dos grupos indica a sua hierarquia e a possibilidade de múltiplas ocorrências.

**Exemplo:** \[infCTe001001\]

* A parte literal "infCTe" identifica o grupo de informações.  
* O primeiro "001" indica que este é o primeiro grupo de um tipo que pode se repetir (por exemplo, você pode adicionar vários CT-es). Para um segundo CT-e, você usaria \[infCTe002\].  
* O segundo "001" indica que este é um subgrupo (filho) do grupo \[infCTe001\].

Alguns grupos podem ser repetidos. Por exemplo, para incluir dois CT-es, você teria as seções \[infCTE001\] e \[infCTE002\]. As chaves filhas devem sempre seguir a mesma sequência numérica da chave pai.