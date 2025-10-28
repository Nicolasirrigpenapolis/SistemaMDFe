Attribute VB_Name = "modNFE"
'* Sistema...: Emissor de MDF-e (Layout 3.00)
'* Empresa...: Ygor Eduardo Dellalio
'* Módulo....: modNFE
'* Função....: Módulo de funções globais
'* CopyRight.: (C)2024 Ygor Eduardo Dellalio
'* Criação...: GAS-2007 - Gerador Automático de Sistemas
'* Data......: 05/09/2024 18:10:16
'* * * * * * *

Option Explicit                                   'requer variáveis explicitamente declaradas
DefInt A-Z                                        'inteiras, por default

'engana o SETUP WIZARD...
#If False Then
   Public Declare Sub NadaFaz Lib "OC30.DLL" ()
   Public Declare Sub NadaFaz Lib "MSGHOO32.OCX" ()
   Public Declare Sub NadaFaz Lib "NFE.RES" ()
   Public Declare Sub NadaFaz Lib "IJL10.DLL" ()
   Public Declare Sub NadaFaz Lib "EZTW32.DLL" ()
   Public Declare Sub NadaFaz Lib "DADOSNFE-SQL.SQL" ()
   Public Declare Sub NadaFaz Lib "NFE.XML" ()
#End If

'constantes dos botoes de movimentacao de registros
Public Const REG_PRIMEIRO = 0                     'move para o primeiro registro da tabela
Public Const REG_ANTERIOR = 1                     'move para o registro anterior da tabela
Public Const REG_SEGUINTE = 2                     'move para o registro seguinte
Public Const REG_ULTIMO = 3                       'move para o último registro da tabela
Public Const REG_FORCAVOLTA = 4                   'so testa se o registro esta correto

'constantes para a sub IncializaApelidos
Public Const COM_REGISTRO = 0                      'inicializa apelidos com a tabela
Public Const COM_TEXTBOX = 1                       'inicializa apelidos com os textbox

'constantes para definição dos tipos de botões para mask
Public Const BOT_ACAO = 0
Public Const BOT_LISTA = 1
Public Const BOT_COMBO = 2

'constantes para a variavel "vgCaracteristica" de cada form
Public Const F_COMUM = 0                          'sem controle de dados 
Public Const F_DADOS = 1                          'com controle de dados
Public Const F_GRAFICO = 5                        'que apresenta um gráfico
Public Const F_BROWSE = 6                         'que apresenta consultas
Public Const F_VARIAVEL = 8                       'que recebe variáveis complementares

'constantes para a variavel "vgSituacao" de cada form
Public Const ACAO_NAVEGANDO = 1                    'está visualizando
Public Const ACAO_INCLUINDO = 2                    'está em módulo de inclusão
Public Const ACAO_EDITANDO = 3                     'está alterando o registro
Public Const ACAO_EXCLUINDO = 4                    'está excluindo um registro
Public Const ACAO_EM_PROGRESSO = 5                 'está processando dados no form

'usadas na montagem de "queries" para extrair ou colocar as cláusulas
'da expressão SQL
Public Const EXP_SELECT = 0                         'extrai a expressão SELECT/UPDATE/DELETE do SQL
Public Const EXP_SET = 1                            'extrai a expressão SET do SQL
Public Const EXP_FROM = 2                           'extrai a expressão FROM do SQL
Public Const EXP_LEFT_JOIN = 3                      'extrai a expressão LEFT JOIN do SQL
Public Const EXP_RIGHT_JOIN = 4                     'extrai a expressão RIGHT JOIN do SQL
Public Const EXP_INNER_JOIN = 5                     'extrai a expressão INNER JOIN do SQL
Public Const EXP_INNER_ON = 6                       'extrai a expressão ON do SQL
Public Const EXP_WHERE = 7                          'extrai a expressão WHERE do SQL
Public Const EXP_GROUPBY = 8                        'extrai a expressão GROUPBY do SQL
Public Const EXP_HAVING = 9                         'extrai a expressão HAVING do SQL
Public Const EXP_ORDERBY = 10                       'extrai a expressão ORDERBY do SQL
Public Const EXP_LIMIT = 11                         'extrai a expressão LIMIT do SQL (MySQL)
Public Const EXP_TODAS = 12                         'extrai a expressão SQL inteira

'constantes para tipo do form (armazenado em vgTipo)
Public Const TP_COMUM = 0                         'form comum
Public Const TP_TABELA = 1                        'tabela comum
Public Const TP_PARAMETROS = 2                    'parâmetros do sistema
Public Const TP_GRAFICO = 3                       'form de gráficos comerciais
Public Const TP_CONFGRAF = 4                      'form de configurações de gráfico
Public Const TP_BROWSE = 5                        'form do browse (consultas)
Public Const TP_INFODB = 6                        'form informações do BD
Public Const TP_SELEQUERY = 7                     'form para selecionar consultas
Public Const TP_SENHAS = 9                        'form de manutenção de senhas
Public Const TP_CALC = 11                         'form da calculadora
Public Const TP_CALE = 12                         'form do calendario/lista
Public Const TP_VARIAVEL = 13                     'form para receber varável complementar
Public Const TP_RELAT = 14                        'form de fonte de relatorio
Public Const TP_FPW = 15                          'form para preview de relatórios

'para o form controle
Public Const PEGA_DIR = 0                         'pega diretório do BD
Public Const PEGA_ESTACAO = 1                     'pega nome da estação
Public Const PEGA_SENHA_INICIAL = 2               'pega senha ao iniciar o sistema
Public Const PEGA_SENHA = 3                       'pega senha ao abandonar o sistema
Public Const PEGA_INI_CONSULTA = 4                'pega diretório das consultas

'para o form gauge
Public Const OP_PROGRESSO = 0                     'para mostrar painel progresso
Public Const OP_DIALOGOTOT = 1                    'painel com diálogo de totalização de colunas

'usado para definir o método a usar no grdBrowse
Public Const BRW_NADA = 0                         'não excuta nada
Public Const BRW_REFRESH = 1                      'força refresh
Public Const BRW_REBIND = 2                       'força rebind

'usada para mostra o que foi solicitado no form de cale
Public Const MOSTRA_NAO = -1                      'inicializando formulário dos extensores (combobox)
Public Const MOSTRA_CALE = 0                      'extensor vai mostrar calendário 
Public Const MOSTRA_LST_INTERNA = 1               'extensor vai mostrar lista interna 
Public Const MOSTRA_LST_EXTERNA = 2               'extensor vai mostrar lista externa 
Public Const MOSTRA_LST_PESQUISA = 3              'extensor vai mostrar lista de pesquisa

'usadas para definir o modo de abertura da pesquisa
Public Const PESQ_MODO_COMBO = 1
Public Const PESQ_MODO_JANELA = 2

Public Const BI_RETORNADIR = &H1                  'abrir o browser para capturar uma pasta
Public Const BIF_EDITBOX = &H10
Public Const BIF_USENEWUI = &H40


Public Const LB_SETHORIZONTALEXTENT = &H194       'lista com scroll horizontal

Public Const RGN_COPY = 5

'constantes para a funcao "Executar" dos forms de dados
Public Const VALIDACOES = 0                       'critica os campos digitados
Public Const EXCLUSOES = 1                        'exclusão de registros
Public Const PROCESSOS_DIRETOS = 2                'executa processos diretos
Public Const PROCESSOS_INVERSOS = 3               'executa processos inversos
Public Const INICIALIZACOES = 4                   'inicializa campos antes da inclusão
Public Const INI_APELIDOS = 5                     'pega apelido dos campos
Public Const CONTEUDODACOLUNA = 6                 'inicializa colunas do grid
Public Const CONDICOES_ESPECIAIS = 7              'verifica se pode incluir, alterar ou excluir no grid
Public Const PREVALIDACOES = 9                    'prevalidações do grid
Public Const DEFAULTDASCOLUNAS = 10               'default das colunas
Public Const PEGA_DO_ARQUIVO = 12                 'pega dados do registro e coloca nos controles
Public Const POE_NO_ARQUIVO = 13                  'pega dados dos controles e poe no registro
Public Const ABRETABELADACOLUNA = 20              'abre recordset com filtro para coluna do grid
Public Const PEGAFILTRODASCOLUNAS = 21            'pega filtro da coluna do grid
Public Const APOS_EDICAO = 22                     'executa uma ação apos a inclusão, alteração ou exclusão
Public Const PROCESSOS_ANTES = 23                 'processos diretos executados antes do update
Public Const TESTA_VAL_RS = 24                     'testa se os valores do recorset foram alterados
Public Const ABRE_TABELA_GRID = 28                  'Inicializa tabela do grid
Public Const PEGAEXPRESSAOPESQUISA = 30           'Pega expressão SQL para definição da pesquisa em grid

'parâmetros da função HaNaString
Public Const UM_A_UM = -1                         'só um caracter testado
Public Const SO_UM = 0                            'todos os caracteres testados um a um

'estilo da window 
Public Const GWL_STYLE = (-16)                    'pega estilo da janela
Public Const WS_HSCROLL = &H100000                'coloca barra de rolagem na janela 

'Constantes para controle do form
Public Const SW_SHOW = 5
Public Const SW_RESTORE = 9

'para evento que simula tecla pressionada
Public Const KEYEVENTF_EXTENDEDKEY = &H1          'envia simulação de tecla extendida 
Public Const KEYEVENTF_KEYUP = &H2                'envia simulação de tecla liberada
Public Const VK_SHIFT = &H10                      'envia simulação de shift pressionado  
Public Const VK_CTRL = &HA2                       'envia simulação de ctrl pressionado

Public Const LF_FACESIZE = 32                     'tamanho do nome da fonte


'constantes para API's de PopupMenu
Public Const MF_STRING = &H0&
Public Const TPM_LEFTALIGN = &H0&
Public Const TPM_RETURNCMD = &H100&
Public Const TPM_RIGHTBUTTON = &H2&

'cria variáveis vistas em todo sistema
Public vgPWUsuario As String                      'nome do usuário
Public vgPWGrupo As String                        'grupo de trabalho do usuário
Public vgPWSenha As String                        'senha atual do usuário
Public vgPWObs As String                          'observação sobre o usuário
Public vgAliasDb(1) As String                     'alias para registro do banco de dados
Public vgNomeDb(1) As String                      'path e nome do banco de dados
Public vgTiposPermDb(1) As Integer                'tipos que o banco pode assumir
Public vgServerDb(1) As String                    'servidor do banco de dados
Public vgTipoDb(1) As EnumDataBaseType            'tipo do banco de dados
Public vgDirDb(1) As String                       'diretório do banco de dados
Public vgProviderDb(1) As String                   'providers para conexão com o bancos de dados
Public vgDriverDb(1) As String                     'drivers para conexão com o bancos de dados
Public vgUsuarioID(1) As String                    'usuário para conexão com o banco de dados
Public vgSenhaDb(1) As String                      'senha para conexão com o banco de dados
Public vgStrConnectionDb(1) As String              'string connection para os bancos de dados
Public vgTrustConnDb(1) As Boolean                 'vai utilizar trusted connection para o banco
Public vgNomeINI As String                        'nome do arquivo .INI
Public vgConsultaINI As String                    'nome do arquivo .INI para as consulta feitas pelo usuário
Public vgDirEXE As String                         'diretório do sistema (.EXE)
Public vgNomeRes As String                        'nome do arquivo resource
Public vgTemLogDb(1) As Boolean                   'controle de logs por banco
Public vgSenhaLog(1) As String
Public vgDb As New GConnection                    'Coleção de bancos de dados utilizados pelo aplicativo
Public vgQdeRecursos As Long                      'Quantidade de recursos no resource (.RC)
Public vgNomeApp As String                        'nome original do aplicativo (.EXE)
Public vgArqEstXML As String                      'arquivo de estrutura do banco
Public vgNomeSistema As String                    'nome do sistema
Public vgIDSistema As String                      'ID do sistema
Public vgCriptChv As String                       'Chave para encriptações
Public vgProjetista As String                     'nome do analista/projetista
Public vgEMailProjetista As String                'e-mail do analista/projetista
Public vgBotoesOK As Integer                      'status dos botões da barra de ferramentas
Public vgNovaQuery As String                      'query de relatório/consultas
Public vgFiltroAtual As String                    'armazenará a última pesquisa feita
Public vgFiltroAtualComTit As String              'armazenará a última pesquisa feita com os titulos dos campos
Public vgOrdemAtual As String                     'armazenará a última ordem feita
Public vgOrdemAtualComTit As String               'armazenará a última ordem feita com os titulos dos campos
Public vgAtencao As String                        'palavra "Atenção!"
Public vgSpInt As String                          'separador de inteiros
Public vgSpDec As String                          'separador de decimais
Public vgImpConv As Integer                       'flag - impressora é uma impressora convêncional?
Public vgSubsTab As String                        'separador das colunas da lista externa (combobox)
Public CErr As New Dbox                           'classe para mostrar erros
Public vgClausula(EXP_TODAS - 1) As String        'vetor com os nomes das cláusulas SQL
Public vgFuncAgregadas(13) As String              'funções SQL 
Public vgBarraFerr As Integer                     'status da barra de ferramentas
Public vgAjudaAtiva As Integer                    'status da ajuda ativa
Public vgNaoAtRolagem As Integer                  'flag utilizada no scroll do filtro
Public vgNomeEstacao As String                    'nome da estação de trabalho
Public vgRsPwGrupos As New GRecordSet             'tabela de gupos de usuário
Public vgRsPwUsuarios As New GRecordSet           'tabela dos nomes dos usuários
Public vgRsPwTabelas As New GRecordSet            'tabela de permissões de cada tabela
Public Empresa As New GRecordSet, Parametros_da_nfe As New GRecordSet

Public vgRelAtivo As Long                         'número do relatório que está rodando
Public vgCriandoSenha As Boolean                  'flag para saber a hora que esta cirando as senhas
Public vgNomeCupom As String                          'Nome arquivo que armazenará o cupom fiscal
Public BancoDeCampos As New GColumns                  'Coleção com todos os campos de todos os bancos do projeto (pode substituir a PegaAtributo)

'coordenadas da janela
Public Type RECT
   Left As Long
   Top As Long
   Right As Long
   Bottom As Long
End Type

'obtem informacoes sobre o tamanho da fonte
Public Type TEXTMETRIC
   tmHeight As Long
   tmAscent As Long
   tmDescent As Long
   tmInternalLeading As Long
   tmExternalLeading As Long
   tmAveCharWidth As Long
   tmMaxCharWidth As Long
   tmWeight As Long
   tmOverhang As Long
   tmDigitizedAspectX As Long
   tmDigitizedAspectY As Long
   tmFirstChar As Byte
   tmLastChar As Byte
   tmDefaultChar As Byte
   tmBreakChar As Byte
   tmItalic As Byte
   tmUnderlined As Byte
   tmStruckOut As Byte
   tmPitchAndFamily As Byte
   tmCharSet As Byte
End Type

'cria estrutura para captar coordenadas do mouse
Public Type POINTAPI
   x As Long                                      'posição x
   y As Long                                      'posicão y
End Type

'cria estrutura para o browser para capturar uma pasta
Public Type BROWSEINFO
   hOwner As Long
   pidlRoot As Long
   pszDisplayName As String
   lpszTitle As String
   ulFlags As Long
   lpfn As Long
   lParam As Long
   iImage As Long
End Type

'estrutura de fonte
Public Type LogFont
   lfHeight As Long
   lfWidth As Long
   lfEscapement As Long
   lfOrientation As Long
   lfWeight As Long
   lfItalic As Byte
   lfUnderline As Byte
   lfStrikeOut As Byte
   lfCharSet As Byte
   lfOutPrecision As Byte
   lfClipPrecision As Byte
   lfQuality As Byte
   lfPitchAndFamily As Byte
   lfFaceName As String * LF_FACESIZE
End Type

'Windows API para imprimir
Public Declare Function TextOut Lib "gdi32" Alias "TextOutA" (ByVal hdc As Long, ByVal x As Long, ByVal y As Long, ByVal lpString As String, ByVal nCount As Long) As Long  ' or Boolean
Public Declare Function DeleteObject Lib "gdi32" (ByVal hObject As Long) As Long
Public Declare Function CreateFontIndirect Lib "gdi32" Alias "CreateFontIndirectA" (lpLogFont As LogFont) As Long
Public Declare Function SelectObject Lib "gdi32" (ByVal hdc As Long, ByVal hObject As Long) As Long
Public Declare Function SetBkMode Lib "gdi32" (ByVal hdc As Long, ByVal nBkMode As Long) As Long

'Windows API para ler e gravar no arquivo INI
Declare Function GetPrivateProfileInt Lib "Kernel32" Alias "GetPrivateProfileIntA" (ByVal NAp As String, ByVal Chave As String, ByVal nDefa As Long, ByVal NArq As String) As Long
Declare Function GetPrivateProfileString Lib "Kernel32" Alias "GetPrivateProfileStringA" (ByVal NAp As String, ByVal Chave As Any, ByVal nDefa As String, ByVal StRet As String, ByVal nTama As Long, ByVal NArq As String) As Long
Declare Function WritePrivateProfileString Lib "Kernel32" Alias "WritePrivateProfileStringA" (ByVal NAp As String, ByVal Chave As Any, ByVal St As Any, ByVal NArq As String) As Long

'evia um mensagem para o windows
Declare Sub keybd_event Lib "user32" (ByVal bVk As Byte, ByVal bScan As Byte, ByVal dwFlags As Long, ByVal dwExtraInfo As Long)

'Windows API para criar forms irregulares
Declare Function CreatePolygonRgn Lib "gdi32" (lpPoint As POINTAPI, ByVal nCount As Long, ByVal nPolyFillMode As Long) As Long
Declare Function CreateRectRgn Lib "gdi32" (ByVal x1 As Long, ByVal y1 As Long, ByVal X2 As Long, ByVal Y2 As Long) As Long
Declare Function CreateRoundRectRgn Lib "gdi32" (ByVal x1 As Long, ByVal y1 As Long, ByVal X2 As Long, ByVal Y2 As Long, ByVal X3 As Long, ByVal Y3 As Long) As Long
Declare Function CreateEllipticRgn Lib "gdi32" (ByVal x1 As Long, ByVal y1 As Long, ByVal X2 As Long, ByVal Y2 As Long) As Long
Declare Function CombineRgn Lib "gdi32" (ByVal hDestRgn As Long, ByVal hSrcRgn1 As Long, ByVal hSrcRgn2 As Long, ByVal nCombineMode As Long) As Long
Declare Function SetWindowRgn Lib "user32" (ByVal hWnd As Long, ByVal hRgn As Long, ByVal bRedraw As Boolean) As Long
Declare Function ReleaseCapture Lib "user32" () As Long
Declare Function GetPixel Lib "gdi32" (ByVal hdc As Long, ByVal x As Long, ByVal y As Long) As Long

'Declara API's para pegar outra instância desta aplicação rodando
Declare Function ShowWindow Lib "User32" (ByVal hWnd As Long, ByVal wCmd As Long) As Long
Declare Function FindWindow Lib "User32" Alias "FindWindowA" (ByVal Class As Long, ByVal Caption As Long) As Long
Declare Function GetWindow Lib "User32" (ByVal hWnd As Long, ByVal wCmd As Long) As Long
Declare Function GetWindowText Lib "User32" Alias "GetWindowTextA" (ByVal hWnd As Long, ByVal Buf As String, ByVal LBuf As Long) As Long

'Funções para controle do foco
Declare Function GetWindowThreadProcessId Lib "user32" (ByVal hWnd As Long, lpdwProcessId As Long) As Long
Declare Function AttachThreadInput Lib "user32" (ByVal idAttach As Long, ByVal idAttachTo As Long, ByVal fAttach As Long) As Long
Declare Function GetForegroundWindow Lib "user32" () As Long
Declare Function SetForegroundWindow Lib "user32" (ByVal hWnd As Long) As Long
Declare Function IsIconic Lib "user32" (ByVal hWnd As Long) As Long
Declare Function GetParent Lib "user32" (ByVal hwnd As Long) As Long
Declare Function GetClassName Lib "user32" Alias "GetClassNameA" (ByVal hwnd As Long, ByVal lpClassName As String, ByVal nMaxCount As Long) As Long

Public Declare Function GetCursorPos Lib "user32" Alias "GetCursorPos" (lpPoint As POINTAPI) As Long
'Windows API's - apresenta help da aplicacao
Declare Function WinHelp Lib "User32" Alias "WinHelpA" (ByVal hWnd As Long, ByVal HelpFile As String, ByVal wCmd As Long, ByVal dwData As Long) As Long

'Windows API's - para ler WIN.INI
Declare Function GetProfileString Lib "Kernel32" Alias "GetProfileStringA" (ByVal lpAppName As String, ByVal lpkeyName As String, ByVal lpDefa As String, ByVal lpRet As String, ByVal NSize As Long) As Long

'Windows API's - trabalha com os forms
Declare Function SetWindowWord Lib "User32" (ByVal hWnd As Long, ByVal nCmd As Long, ByVal nVal As Long) As Long
Declare Function SetWindowLong Lib "user32" Alias "SetWindowLongA" (ByVal hwnd As Long, ByVal nIndex As Long, ByVal dwNewLong As Long) As Long
Declare Function GetWindowLong Lib "user32" Alias "GetWindowLongA" (ByVal hwnd As Long, ByVal nIndex As Long) As Long

Declare Function GetTextMetrics Lib "gdi32" Alias "GetTextMetricsA" (ByVal hdc As Long, lpMetrics As TEXTMETRIC) As Long

'Windows API's - pega coordenada do form em relação a tela
Declare Function ClientToScreen Lib "user32" (ByVal hwnd As Long, lpPoint As POINTAPI) As Long

'Windows API's - abre browser para capturar uma pasta
Declare Function SHGetPathFromIDList Lib "shell32.dll" Alias "SHGetPathFromIDListA" (ByVal pidl As Long, ByVal pszPath As String) As Long
Declare Function SHBrowseForFolder Lib "shell32.dll" Alias "SHBrowseForFolderA" (lpBrowseInfo As BROWSEINFO) As Long  'ITEMIDLIST

'Windows API's - executa um commando com o arquivo associado
Public Declare Function ShellExecute Lib "shell32" Alias "ShellExecuteA" ( _
                        ByVal hwnd As Long, ByVal lpOperation As String, _
                        ByVal lpfile As String, ByVal lpparameters As String, _
                        ByVal lpDirectory As String, ByVal nShowCmd As Long) As Long

'Windows API's - boot no computador
Declare Function ExitWindows Lib "User32" (ByVal wReserved As Long, ByVal wRetCode As Long) As Long

'Windows API's - pega o nome da estacao
Declare Function GetComputerName Lib "kernel32" Alias "GetComputerNameA" (ByVal lpBuffer As String, nSize As Long) As Long

'Windows API's - envia uma mensagem para o windows
Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, lParam As Any) As Long

'Windows API's - utilizada para tratamento do resource
Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (hpvDest As Any, hpvSource As Any, ByVal cbCopy As Long)

'Windows API's - pega diretório temporário para o usuário atual
Declare Function GetTempPath Lib "kernel32" Alias "GetTempPathA" (ByVal nBufferLength As Long, ByVal lpBuffer As String) As Long

'Windows API's - pega area de trabalho sem a barra do systray
Declare Function SystemParametersInfo Lib "user32" Alias "SystemParametersInfoA" (ByVal uAction As Long, ByVal uParam As Long, ByRef lpvParam As RECT, ByVal fuWinIni As Long) As Long
Public Const SPI_GETWORKAREA = 48

'Pega long referente para cor OLE
Public Declare Function TranslateColor Lib "olepro32.dll" Alias "OleTranslateColor" (ByVal clr As OLE_COLOR, ByVal palet As Long, Col As Long) As Long

'Windows API's - desenha size grip
Declare Function DrawFrameControl Lib "user32" (ByVal hdc&, lpRect As RECT, ByVal un1 As Long, ByVal un2 As Long) As Boolean


'Windows API's - cria PopupMenu
Public Declare Function CreatePopupMenu Lib "user32" () As Long
Public Declare Function TrackPopupMenuEx Lib "user32" (ByVal hMenu As Long, ByVal wFlags As Long, ByVal x As Long, ByVal y As Long, ByVal hWnd As Long, ByVal lptpm As Any) As Long
Public Declare Function AppendMenu Lib "user32" Alias "AppendMenuA" (ByVal hMenu As Long, ByVal wFlags As Long, ByVal wIDNewItem As Long, ByVal lpNewItem As Any) As Long
Public Declare Function DestroyMenu Lib "user32" (ByVal hMenu As Long) As Long

Dim vgDadosAntTabela() As String, vgDadosPostTabela() As String
Public paneControles As Object, cmdCapitaliza As Object, lblTitulo As Object
Public lblGrupo As Object, lblUsuario As Object, lblDataHora As Object
Public lblUsuario2 As Object, lblAlteracao As Object, lblProgresso As Object
Public MnuCadastro As Object, MnuParametros As Object, mnuCapitaliza As Object
Public MnuConsultas As Object, MnuFerramentas As Object

Public Declare Function SetParent Lib "user32" (ByVal hWndChild As Long, ByVal hWndNewParent As Long) As Long
Public Declare Function FindWindowArm Lib "user32" Alias "FindWindowA" (ByVal Class As String, ByVal Caption As String) As Long
Public MsgValIE As String
Public vaTitulo As String
Public vaDir As String
Public seqRegistro As Long
Public NFe_Consulta As Long 
'========Capturar Pasta==========
'Existem outras flags para parametrizar a pesquisa
Public Const BIF_RETURNONLYFSDIRSYGOR = 1
Public Const BIF_DONTGOBELOWDOMAINYGOR = 2
Public Const MAX_PATHYGOR = 260
Public Const SuperSenha As String = "013666"
Public InputYgor As String

Public Declare Function SHBrowseForFolderYGOR Lib "shell32" Alias "SHBrowseForFolder" (lpbi As BrowseInfoYGOR) As Long
Public Declare Function SHGetPathFromIDListYGOR Lib "shell32" Alias "SHGetPathFromIDList" (ByVal pidList As Long, ByVal lpBuffer As String) As Long
Public Declare Function lstrcatYGOR Lib "kernel32" Alias "lstrcatA" (ByVal lpString1 As String, ByVal lpString2 As String) As Long
Public Declare Function GetUserName Lib "advapi32.dll" Alias "GetUserNameA" (ByVal lpBuffer As String, nSize As Long) As Long

'Tipo para default
Public Type BrowseInfoYGOR
   hWndOwner As Long
   pIDLRoot As Long
   pszDisplayName As Long
   lpszTitle As Long
   ulFlags As Long
   lpfnCallback As Long
   lParam As Long
   iImage As Long
End Type

'ROTINA QUE TIRA OS ACENTOS DE UM TEXTO
Public Function SuperTiraAcentos(Texto As String) As String
   Dim Vector As String, x As Long, y As Long, Igual As Boolean, Retorno As String
      
   Vector = "AEIOUaeiouAEIOUaeiouAOaoAEIOUaeiouAEIOUaeiouYycCÁÉÍÓÚáéíóúÀÈÌÒÙàèìòùÃÕãõÂÊÎÔÛâêîôûÄËÏÖÜäëïöüÝýçÇ"
   y = 1
   
   For x = 1 To Len(Texto)
      Do While (y <= 96)
         If Mid(Texto, x, 1) = Mid(Vector, y, 1) And y > 48 Then
            Igual = True
            Retorno$ = Retorno$ & Mid(Vector, Abs(y - 48), 1)
            Exit Do
         End If
         y = y + 1
      Loop
      If Igual <> True Then
         Retorno$ = Retorno$ & Mid(Texto, x, 1)
      End If
      Igual = False
      y = 1
   Next
   
   SuperTiraAcentos = Retorno$

End Function

'ROTINA para tirar os caracteres especiais
Public Function RemoveCaracteres(texto As String, Optional excessao As Boolean) As String
   Dim Vector As String, x As Long, y As Integer, Retorno As String, Igual As Boolean
   
   If Not excessao Then
      Vector = "!@#$%¨&*()-_=+'¹²³£¢¬§´`~^;:.,<>/?°][{}ºª\|"
   Else 'Usado em Nota Fiscais e Etc...
      Vector = "!@#$%¨&*_=+¹²³£¢¬§´`~^;:<>/?°][{}ºª\|"
   End If
   
   y = 1
      
   For x = 1 To Len(texto)
      y = 1
      Do While y <= Len(Vector)
         If Mid(texto, x, 1) = Mid(Vector, y, 1) Then
            Igual = True
            Exit Do
         End If
         y = y + 1
      Loop
      If Not Igual Then
         Retorno$ = Retorno$ & Mid(texto, x, 1)
      End If
      Igual = False
   Next
   
   RemoveCaracteres = Retorno$
   
End Function


Public Function D(Data As Variant) As String   
   D = "CONVERT(VARCHAR, '" & Format(Data, "yyyy-mm-dd") & "', 120)"
End Function

Public Function UltD(Optional Data As Variant) As Date
   If IsMissing(Data) Or Vazio(Data) Then
      UltD = Date
   Else
      UltD = CDate(Data)
   End If
   UltD = DateAdd("M", 1, UltD) - Day(DateAdd("M", 1, UltD))
End Function

'Super Rotina Validation
Public Function ValidaIE(UF As String, IE As String, ProdutorSP As Boolean) As Boolean
   Dim SPeso As Integer, Resto As Integer, DV As Integer, Produto As Integer, p As Integer, D As Integer, i As Integer, Count As Integer
   Dim Inscricao As String, NInscricao As String, Auxiliar(10) As String
   Dim Vetor As String
   
   On Error GoTo DeuErro
   
   If Vazio(IE) Then
      ValidaIE = False:
      MsgValIE = "Inscrição Estadual não pode ser Vazia!"          
      Exit Function
   End If
   
   'É Número?
   Inscricao = RemoveCaracteres(IE)
   If Not IsNumeric(Inscricao) Then MsgValIE = "Favor Digitar Apenas Números." & vbCrLf & _
                                               "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
   'Validações Bora lah...
   Select Case UF
      Case "AC" 'Exemplo: 01.004.823/001-12. Dois Primeiros Dígitos sempre é '01'
         If Mid(Inscricao, 1, 2) <> 1 Then MsgValIE = "Insc. Estadual do Acre sempre deve Começar com '01'." & vbCrLf & _
                                                      "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
         If Len(Inscricao) <> 13 Then MsgValIE = "Dígitos a mais ou a menos para essa Inscrição." & vbCrLf & _
                                                 "Eram Esperam 13 Dígitos." & vbCrLf & _
                                                 "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
         '1º Digito Verificador
         'Pesos (4 3 2 9 8 7 6 5 4 3 2)
         SPeso = ((4 * Mid(Inscricao, 1, 1)) + (3 * Mid(Inscricao, 2, 1)) + (2 * Mid(Inscricao, 3, 1)) + (9 * Mid(Inscricao, 4, 1)) + (8 * Mid(Inscricao, 5, 1)) + (7 * Mid(Inscricao, 6, 1)) + (6 * Mid(Inscricao, 7, 1)) + (5 * Mid(Inscricao, 8, 1)) + (4 * Mid(Inscricao, 9, 1)) + (3 * Mid(Inscricao, 10, 1)) + (2 * Mid(Inscricao, 11, 1)))
         Resto = SPeso Mod 11 'Modulo 11
         If Resto < 2 Then
            DV = 0
         Else
            DV = 11 - Resto   'Dígito Verificador
         End If
               
         'Nova Inscrição
         NInscricao = CStr(Mid(Inscricao, 1, 11)) & DV
        
         '2º Digito Verificador
         'Pesos (5 4 3 2 9 8 7 6 5 4 3 2)
         SPeso = ((5 * Mid(Inscricao, 1, 1)) + (4 * Mid(Inscricao, 2, 1)) + (3 * Mid(Inscricao, 3, 1)) + (2 * Mid(Inscricao, 4, 1)) + (9 * Mid(Inscricao, 5, 1)) + (8 * Mid(Inscricao, 6, 1)) + (7 * Mid(Inscricao, 7, 1)) + (6 * Mid(Inscricao, 8, 1)) + (5 * Mid(Inscricao, 9, 1)) + (4 * Mid(Inscricao, 10, 1)) + (3 * Mid(Inscricao, 11, 1)) + (2 * Mid(Inscricao, 12, 1)))
         Resto = SPeso Mod 11 'Modulo 11
         If Resto < 2 Then
            DV = 0
         Else
            DV = 11 - Resto
         End If
         
         'Nova Inscricao
         NInscricao = NInscricao & DV
        
         If NInscricao = RemoveCaracteres(IE) Then
            ValidaIE = True: MsgValIE = "": Exit Function
         Else
            ValidaIE = False: MsgValIE = "Dígito Verificador Incorreto." & vbCrLf & _
                                         "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
         End If
      Case "AL" 'Exemplo: 240000048. Formação: 24XNNNNND. Dois Primeiros Dígitos sempre é '24'(Código do Estado)
         Vetor = "0 3 5 7 8" 'X-Tipo Empresa (0-Normal, 3-Produtor Rural, 5-Substituta, 7-Micro-Empresa Ambulante, 8-Micro-Empresa)
         If Mid(Inscricao, 1, 2) <> 24 Then MsgValIE = "Insc. Estadual de Alagoas sempre deve Começar com '24'." & vbCrLf & _
                                                       "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
         If Len(Inscricao) <> 9 Then MsgValIE = "Dígitos a mais ou a menos para essa Inscrição." & vbCrLf & _
                                                "Eram Esperam 9 Dígitos." & vbCrLf & _
                                                "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
         If Not InStr(Vetor, 0) > 0 Or Not InStr(Vetor, 0) > 0 Or Not InStr(Vetor, 0) > 0 Or Not InStr(Vetor, 0) > 0 Or Not InStr(Vetor, 0) > 0 Then _
            MsgValIE = "3º Dígito Inválido para essa Inscrição." & vbCrLf & _
                       "Era Esperado 0,3,5,7 ou 8." & vbCrLf & _
                       "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
         
         'Pesos (9 8 7 6 5 4 3 2) da Direita pra Esquerda
         SPeso = ((9 * Mid(Inscricao, 1, 1)) + (8 * Mid(Inscricao, 2, 1)) + (7 * Mid(Inscricao, 3, 1)) + (6 * Mid(Inscricao, 4, 1)) + (5 * Mid(Inscricao, 5, 1)) + (4 * Mid(Inscricao, 6, 1)) + (3 * Mid(Inscricao, 7, 1)) + (2 * Mid(Inscricao, 8, 1)))
         Produto = SPeso * 10 '10 = Constante
         Resto = (Produto - (Int(Produto / 11) * 11))
         If Resto = 10 Then
            DV = 0
         Else
            DV = Resto
         End If
         
         'Nova Inscrição
         NInscricao = Mid(Inscricao, 1, 8) & DV
        
         If NInscricao = RemoveCaracteres(IE) Then
            ValidaIE = True: MsgValIE = "": Exit Function
         Else
            ValidaIE = False: MsgValIE = "Dígito Verificador Incorreto." & vbCrLf & _
                                         "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
         End If
      Case "AP" 'Exemplo: 030123459. Formato: 03NNNNNND. Dois Primeiros Dígitos sempre é '03'
         If Mid(Inscricao, 1, 2) <> 3 Then MsgValIE = "Insc. Estadual do Amapá sempre deve Começar com '03'." & vbCrLf & _
                                                      "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
         If Len(Inscricao) <> 9 Then MsgValIE = "Dígitos a mais ou a menos para essa Inscrição." & vbCrLf & _
                                                "Eram Esperam 9 Dígitos." & vbCrLf & _
                                                "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
         'Nova Inscrição
         NInscricao = Mid(Inscricao, 1, 8)
         
         'Definindo o Valor de P e D de Acordo com as Faixas
         If NInscricao >= 3000001 And NInscricao <= 3017000 Then p = 5: D = 0   'De 03000001 a 03017000 => P = 5 e D = 0
         If NInscricao >= 3017001 And NInscricao <= 3019022 Then p = 9: D = 1   'De 03017001 a 03019022 => P = 9 e D = 1
         If NInscricao >= 3019023 Then p = 0: D = 0                             'De 03019023 em Diante  => P = 0 e D = 0
         
         'Pesos (9 8 7 6 5 4 3 2)
         SPeso = p + ((9 * Mid(NInscricao, 1, 1)) + (8 * Mid(NInscricao, 2, 1)) + (7 * Mid(NInscricao, 3, 1)) + (6 * Mid(NInscricao, 4, 1)) + (5 * Mid(NInscricao, 5, 1)) + (4 * Mid(NInscricao, 6, 1)) + (3 * Mid(NInscricao, 7, 1)) + (2 * Mid(NInscricao, 8, 1)))
         Resto = SPeso Mod 11
         DV = 11 - Resto
         If DV = 10 Then
            DV = 0
         ElseIf DV = 11 Then
            DV = D
         End If
         
         'Nova Inscrição
         NInscricao = Mid(Inscricao, 1, 8) & DV
        
         If NInscricao = RemoveCaracteres(IE) Then
            ValidaIE = True: MsgValIE = "": Exit Function
         Else
            ValidaIE = False: MsgValIE = "Dígito Verificador Incorreto." & vbCrLf & _
                                         "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
         End If
      Case "AM", "CE", "ES", "PB", "PI", "SC", "SE"
         If Len(Inscricao) <> 9 Then MsgValIE = "Dígitos a mais ou a menos para essa Inscrição." & vbCrLf & _
                                                "Eram Esperam 9 Dígitos." & vbCrLf & _
                                                "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
         'Nova Inscrição
         NInscricao = Mid(Inscricao, 1, 8)
         
         'Pesos (9 8 7 6 5 4 3 2)
         SPeso = ((9 * Mid(NInscricao, 1, 1)) + (8 * Mid(NInscricao, 2, 1)) + (7 * Mid(NInscricao, 3, 1)) + (6 * Mid(NInscricao, 4, 1)) + (5 * Mid(NInscricao, 5, 1)) + (4 * Mid(NInscricao, 6, 1)) + (3 * Mid(NInscricao, 7, 1)) + (2 * Mid(NInscricao, 8, 1)))
         Resto = SPeso Mod 11
         If Resto < 2 Then
            DV = 0
         Else
            DV = 11 - Resto
         End If
         
         'Nova Inscrição
         NInscricao = NInscricao & DV
        
         If NInscricao = RemoveCaracteres(IE) Then
            ValidaIE = True: MsgValIE = "": Exit Function
         Else
            ValidaIE = False: MsgValIE = "Dígito Verificador Incorreto." & vbCrLf & _
                                         "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
         End If
      Case "BA" '8 ou 9 Dígitos
         If Len(Inscricao) <> 9 And Len(Inscricao) <> 8 Then MsgValIE = "Dígitos a mais ou a menos para essa Inscrição." & vbCrLf & _
                                                                        "Eram Esperam 9 ou 8 Dígitos." & vbCrLf & _
                                                                        "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
         Vetor = "0 1 2 3 4 5 8"
         'Cálculo do Dígito Verificador para IE com 8 Dígitos
         If Len(Inscricao) = 8 Then
            'Nova Inscrição
            NInscricao = Mid(Inscricao, 1, 6)
            If InStr(Vetor, Mid(NInscricao, 1, 1)) > 0 Then 'Inscrições Cujo Primeiro Dígito é 0, 1, 2, 3, 4, 5, 8 'Calculo pelo Modulo 10
               'Exemplo: 123456-63
               '2º Dígito Verificador
               'Pesos (7 6 5 4 3 2)
               SPeso = ((7 * Mid(NInscricao, 1, 1)) + (6 * Mid(NInscricao, 2, 1)) + (5 * Mid(NInscricao, 3, 1)) + (4 * Mid(NInscricao, 4, 1)) + (3 * Mid(NInscricao, 5, 1)) + (2 * Mid(NInscricao, 6, 1)))
               Resto = SPeso Mod 10 'Modulo 10
               If Resto = 0 Then
                  DV = 0
               Else
                  DV = 10 - Resto
               End If
               
               'Nova Inscrição
               NInscricao = NInscricao & DV
               
               '1º Dígito Verificador
               'Pesos (8 7 6 5 4 3 2) 'Acrescentamos o 2º Dígito Verificador nele
               SPeso = ((8 * Mid(NInscricao, 1, 1)) + (7 * Mid(NInscricao, 2, 1)) + (6 * Mid(NInscricao, 3, 1)) + (5 * Mid(NInscricao, 4, 1)) + (4 * Mid(NInscricao, 5, 1)) + (3 * Mid(NInscricao, 6, 1)) + (2 * Mid(NInscricao, 7, 1)))
               Resto = SPeso Mod 10 'Modulo 10
               If Resto = 0 Then
                  DV = 0
               Else
                  DV = 10 - Resto
               End If
               
               'Nova Inscrição
               NInscricao = Mid(NInscricao, 1, 6) & DV & Mid(NInscricao, 7, 1)
            Else 'Inscrições Cujo Primeiro Dígito é 6, 7 Ou 9 'Calculo pelo Modulo 11
               'Exemplo 612345-57
               '2º Dígito Verificador
               'Pesos (7 6 5 4 3 2)
               SPeso = ((7 * Mid(NInscricao, 1, 1)) + (6 * Mid(NInscricao, 2, 1)) + (5 * Mid(NInscricao, 3, 1)) + (4 * Mid(NInscricao, 4, 1)) + (3 * Mid(NInscricao, 5, 1)) + (2 * Mid(NInscricao, 6, 1)))
               Resto = SPeso Mod 11
               If Resto < 2 Then
                  DV = 0
               Else
                  DV = 11 - Resto
               End If
               
               'Nova Inscrição
               NInscricao = NInscricao & CStr(DV)
               
               '1º Dígito Verificador
               'Pesos (8 7 6 5 4 3 2) 'Acrescentamos o 2º Dígito Verificador nele
               SPeso = ((8 * Mid(NInscricao, 1, 1)) + (7 * Mid(NInscricao, 2, 1)) + (6 * Mid(NInscricao, 3, 1)) + (5 * Mid(NInscricao, 4, 1)) + (4 * Mid(NInscricao, 5, 1)) + (3 * Mid(NInscricao, 6, 1)) + (2 * Mid(NInscricao, 7, 1)))
               Resto = SPeso Mod 11 'Modulo 11
               If Resto < 2 Then
                  DV = 0
               Else
                  DV = 11 - Resto
               End If
            
               'Nova Inscrição
               NInscricao = Mid(NInscricao, 1, 6) & DV & Mid(NInscricao, 7, 1)
            End If
            
            If NInscricao = RemoveCaracteres(IE) Then
               ValidaIE = True: MsgValIE = "": Exit Function
            Else
               ValidaIE = False: MsgValIE = "Dígito Verificador Incorreto." & vbCrLf & _
                                            "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
            End If
         Else 'Cálculo do Dígito Verificador para IE com 9 Dígitos
            'Nova Inscrição
            NInscricao = Mid(Inscricao, 1, 7)
            If InStr(Vetor, Mid(NInscricao, 2, 1)) > 0 Then 'Inscrições Cujo Segundo Dígito é 0, 1, 2, 3, 4, 5, 8 'Calculo pelo Modulo 10
               'Exemplo: 1000003-06
               
               '2º Dígito Verificador
               'Pesos (8 7 6 5 4 3 2)
               SPeso = ((8 * Mid(NInscricao, 1, 1)) + (7 * Mid(NInscricao, 2, 1)) + (6 * Mid(NInscricao, 3, 1)) + (5 * Mid(NInscricao, 4, 1)) + (4 * Mid(NInscricao, 5, 1)) + (3 * Mid(NInscricao, 6, 1)) + (2 * Mid(NInscricao, 7, 1)))
               Resto = SPeso Mod 10
               If Resto = 0 Then
                  DV = 0
               Else
                  DV = 10 - Resto
               End If
               
               'Nova Inscrição
               NInscricao = NInscricao & DV
               
               '1º Dígito Verificador
               'Pesos (9 8 7 6 5 4 3 2)
               SPeso = ((9 * Mid(NInscricao, 1, 1)) + (8 * Mid(NInscricao, 2, 1)) + (7 * Mid(NInscricao, 3, 1)) + (6 * Mid(NInscricao, 4, 1)) + (5 * Mid(NInscricao, 5, 1)) + (4 * Mid(NInscricao, 6, 1)) + (3 * Mid(NInscricao, 7, 1)) + (2 * Mid(NInscricao, 8, 1)))
               Resto = SPeso Mod 10
               If Resto = 0 Then
                  DV = 0
               Else
                  DV = 10 - Resto
               End If
               
               'Nova Inscrição
               NInscricao = Mid(NInscricao, 1, 7) & DV & Mid(NInscricao, 8, 1)
            Else 'Inscrições Cujo Segundo Dígito é 6, 7 Ou 9 'Calculo pelo Modulo 11
               '2º Dígito Verificador
               'Pesos (8 7 6 5 4 3 2)
               SPeso = ((8 * Mid(NInscricao, 1, 1)) + (7 * Mid(NInscricao, 2, 1)) + (6 * Mid(NInscricao, 3, 1)) + (5 * Mid(NInscricao, 4, 1)) + (4 * Mid(NInscricao, 5, 1)) + (3 * Mid(NInscricao, 6, 1)) + (2 * Mid(NInscricao, 7, 1)))
               Resto = SPeso Mod 11
               If Resto < 2 Then
                  DV = 0
               Else
                  DV = 11 - Resto
               End If
               
               'Nova Inscrição
               NInscricao = NInscricao & DV
               
               '1º Dígito Verificador
               'Pesos (9 8 7 6 5 4 3 2) 'Acrescentamos o 2º Dígito Verificador nele
               SPeso = ((9 * Mid(NInscricao, 1, 1)) + (8 * Mid(NInscricao, 2, 1)) + (7 * Mid(NInscricao, 3, 1)) + (6 * Mid(NInscricao, 4, 1)) + (5 * Mid(NInscricao, 5, 1)) + (4 * Mid(NInscricao, 6, 1)) + (3 * Mid(NInscricao, 7, 1)) + (2 * Mid(NInscricao, 8, 1)))
               Resto = SPeso Mod 11 'Modulo 11
               If Resto < 2 Then
                  DV = 0
               Else
                  DV = 11 - Resto
               End If
            
               'Nova Inscrição
               NInscricao = Mid(NInscricao, 1, 7) & DV & Mid(NInscricao, 8, 1)
            End If
         
            If NInscricao = RemoveCaracteres(IE) Then
               ValidaIE = True: MsgValIE = "": Exit Function
            Else
               ValidaIE = False: MsgValIE = "Dígito Verificador Incorreto." & vbCrLf & _
                                            "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
            End If
         End If
      Case "DF" 'Exemplo: 07.300001.001-09. Os Dois Primeiros Dígitos sempre é '07'
         If Len(Inscricao) <> 13 Then MsgValIE = "Dígitos a mais ou a menos para essa Inscrição." & vbCrLf & _
                                                 "Eram Esperam 13 Dígitos." & vbCrLf & _
                                                 "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
         'Nova Inscrição
         NInscricao = Mid(Inscricao, 1, 11)
         
         '1º Dígito Verificador
         'Pesos (4 3 2 9 8 7 6 5 4 3 2)
         SPeso = ((4 * Mid(NInscricao, 1, 1)) + (3 * Mid(NInscricao, 2, 1)) + (2 * Mid(NInscricao, 3, 1)) + (9 * Mid(NInscricao, 4, 1)) + (8 * Mid(NInscricao, 5, 1)) + (7 * Mid(NInscricao, 6, 1)) + (6 * Mid(NInscricao, 7, 1)) + (5 * Mid(NInscricao, 8, 1)) + (4 * Mid(NInscricao, 9, 1)) + (3 * Mid(NInscricao, 10, 1)) + (2 * Mid(NInscricao, 11, 1)))
         Resto = SPeso Mod 11
         If Resto < 2 Then
            DV = 0
         Else
            DV = 11 - Resto
         End If
                  
         'Nova Inscrição
         NInscricao = NInscricao & DV
         
         '2º Dígito Verificador
         'Pesos (5 4 3 2 9 8 7 6 5 4 3 2)
         SPeso = ((5 * Mid(NInscricao, 1, 1)) + (4 * Mid(NInscricao, 2, 1)) + (3 * Mid(NInscricao, 3, 1)) + (2 * Mid(NInscricao, 4, 1)) + (9 * Mid(NInscricao, 5, 1)) + (8 * Mid(NInscricao, 6, 1)) + (7 * Mid(NInscricao, 7, 1)) + (6 * Mid(NInscricao, 8, 1)) + (5 * Mid(NInscricao, 9, 1)) + (4 * Mid(NInscricao, 10, 1)) + (3 * Mid(NInscricao, 11, 1)) + (2 * Mid(NInscricao, 12, 1)))
         Resto = SPeso Mod 11
         If Resto < 2 Then
            DV = 0
         Else
            DV = 11 - Resto
         End If
         
         'Nova Inscrição
         NInscricao = NInscricao & DV
         
         If NInscricao = RemoveCaracteres(IE) Then
               ValidaIE = True: MsgValIE = "": Exit Function
         Else
               ValidaIE = False: MsgValIE = "Dígito Verificador Incorreto." & vbCrLf & _
                                            "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
         End If
      Case "GO" 'Formato: AB.CDE.FGH-I. 8 Dígitos + 1 Dígito Verificador. Onde AB pode ser igual a 10, 11 ou 15. Exemplo: 10.987.654-7
         If Len(Inscricao) <> 9 Then MsgValIE = "Dígitos a mais ou a menos para essa Inscrição." & vbCrLf & _
                                                "Eram Esperam 9 Dígitos." & vbCrLf & _
                                                "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
         'Nova Inscrição
         NInscricao = Mid(Inscricao, 1, 8)
         
         'Pesos (9 8 7 6 5 4 3 2)
         SPeso = ((9 * Mid(NInscricao, 1, 1)) + (8 * Mid(NInscricao, 2, 1)) + (7 * Mid(NInscricao, 3, 1)) + (6 * Mid(NInscricao, 4, 1)) + (5 * Mid(NInscricao, 5, 1)) + (4 * Mid(NInscricao, 6, 1)) + (3 * Mid(NInscricao, 7, 1)) + (2 * Mid(NInscricao, 8, 1)))
         Resto = SPeso Mod 11
         If NInscricao = 11094402 Then
            DV = 0
         ElseIf Resto = 0 Then
            DV = 0
         ElseIf Resto = 1 And (NInscricao >= 10103105 And NInscricao <= 10119997) Then
            DV = 1
         ElseIf Resto = 1 And (NInscricao < 10103105 And NInscricao > 10119997) And NInscricao <> 11094402 Then
            DV = 0
         ElseIf Resto > 1 Then
            DV = 11 - Resto
         End If
         
         'Nova Inscrição
         NInscricao = NInscricao & DV
         
         If NInscricao = RemoveCaracteres(IE) Then
            ValidaIE = True: MsgValIE = "": Exit Function
         Else
            ValidaIE = False: MsgValIE = "Dígito Verificador Incorreto." & vbCrLf & _
                                         "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
         End If
      Case "MA" 'Os Dois Primeiros Correspondentes ao Código do Estado (12). Exemplo: 12000038-5
         If Len(Inscricao) <> 9 Then MsgValIE = "Dígitos a mais ou a menos para essa Inscrição." & vbCrLf & _
                                                "Eram Esperam 9 Dígitos." & vbCrLf & _
                                                "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
         If Mid(Inscricao, 1, 2) <> 12 Then MsgValIE = "Insc. Estadual do Maranhão sempre deve Começar com '12'." & vbCrLf & _
                                                       "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
         'Nova Inscrição
         NInscricao = Mid(Inscricao, 1, 8)
         
         'Pesos (9 8 7 6 5 4 3 2)
         SPeso = ((9 * Mid(NInscricao, 1, 1)) + (8 * Mid(NInscricao, 2, 1)) + (7 * Mid(NInscricao, 3, 1)) + (6 * Mid(NInscricao, 4, 1)) + (5 * Mid(NInscricao, 5, 1)) + (4 * Mid(NInscricao, 6, 1)) + (3 * Mid(NInscricao, 7, 1)) + (2 * Mid(NInscricao, 8, 1)))
         Resto = SPeso Mod 11
         If Resto < 2 Then
            DV = 0
         Else
            DV = 11 - Resto
         End If
         
         'Nova Inscrição
         NInscricao = NInscricao & DV
         
         If NInscricao = RemoveCaracteres(IE) Then
            ValidaIE = True: MsgValIE = "": Exit Function
         Else
            ValidaIE = False: MsgValIE = "Dígito Verificador Incorreto." & vbCrLf & _
                                         "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
         End If
      Case "MT" 'Formato: NNNNNNNNNN-D. Exemplo: 0013000001-9
         If Len(Inscricao) <> 11 Then MsgValIE = "Dígitos a mais ou a menos para essa Inscrição." & vbCrLf & _
                                                 "Eram Esperam 11 Dígitos." & vbCrLf & _
                                                 "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
         'Nova Inscrição
         NInscricao = Mid(Inscricao, 1, 10)
         
         'Pesos (3 2 9 8 7 6 5 4 3 2)
         SPeso = ((3 * Mid(Inscricao, 1, 1)) + (2 * Mid(Inscricao, 2, 1)) + (9 * Mid(Inscricao, 3, 1)) + (8 * Mid(Inscricao, 4, 1)) + (7 * Mid(Inscricao, 5, 1)) + (6 * Mid(Inscricao, 6, 1)) + (5 * Mid(Inscricao, 7, 1)) + (4 * Mid(Inscricao, 8, 1)) + (3 * Mid(Inscricao, 9, 1)) + (2 * Mid(Inscricao, 10, 1)))
         Resto = SPeso Mod 11
         If Resto < 2 Then
            DV = 0
         Else
            DV = 11 - Resto
         End If
         
         'Nova Inscrição
         NInscricao = NInscricao & DV
         
         If NInscricao = RemoveCaracteres(IE) Then
            ValidaIE = True: MsgValIE = "": Exit Function
         Else
            ValidaIE = False: MsgValIE = "Dígito Verificador Incorreto." & vbCrLf & _
                                         "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
         End If
      Case "MS" 'Formato: NNNNNNNN-D. Os Dois Primeiros Dígitos Sempre tem que ser '28'
         If Len(Inscricao) <> 9 Then MsgValIE = "Dígitos a mais ou a menos para essa Inscrição." & vbCrLf & _
                                                "Eram Esperam 9 Dígitos." & vbCrLf & _
                                                "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
         If Mid(Inscricao, 1, 2) <> 28 Then MsgValIE = "Insc. Estadual do Mato Grosso do Sul sempre deve Começar com '28'." & vbCrLf & _
                                                       "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
         'Nova Inscrição
         NInscricao = Mid(Inscricao, 1, 8)
         
         'Pesos (9 8 7 6 5 4 3 2)
         SPeso = ((9 * Mid(NInscricao, 1, 1)) + (8 * Mid(NInscricao, 2, 1)) + (7 * Mid(NInscricao, 3, 1)) + (6 * Mid(NInscricao, 4, 1)) + (5 * Mid(NInscricao, 5, 1)) + (4 * Mid(NInscricao, 6, 1)) + (3 * Mid(NInscricao, 7, 1)) + (2 * Mid(NInscricao, 8, 1)))
         Resto = SPeso Mod 11
         If Resto < 2 Then
            DV = 0
         Else
            DV = 11 - Resto
         End If
         
         'Nova Inscrição
         NInscricao = NInscricao & DV
         
         If NInscricao = RemoveCaracteres(IE) Then
            ValidaIE = True: MsgValIE = "": Exit Function
         Else
            ValidaIE = False: MsgValIE = "Dígito Verificador Incorreto." & vbCrLf & _
                                         "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
         End If
      Case "MG" 'Exemplo: 062.307.904/0081
         If Len(Inscricao) <> 13 Then MsgValIE = "Dígitos a mais ou a menos para essa Inscrição." & vbCrLf & _
                                                 "Eram Esperam 13 Dígitos." & vbCrLf & _
                                                 "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
         'Igualando as Casas (Frescura na Bund...)
         NInscricao = Mid(Inscricao, 1, 3) & 0 & Mid(Inscricao, 4, 8)
         
         '1º Dígito Verificador
         'Pesos (1 2 1 2 1 2 1 2 1 2 1 2)
         Vetor = ((1 * Mid(NInscricao, 1, 1)) & (2 * Mid(NInscricao, 2, 1)) & (1 * Mid(NInscricao, 3, 1)) & (2 * Mid(NInscricao, 4, 1)) & (1 * Mid(NInscricao, 5, 1)) & (2 * Mid(NInscricao, 6, 1)) & (1 * Mid(NInscricao, 7, 1)) & (2 * Mid(NInscricao, 8, 1)) & (1 * Mid(NInscricao, 9, 1)) & (2 * Mid(NInscricao, 10, 1)) & (1 * Mid(NInscricao, 11, 1)) & (2 * Mid(NInscricao, 12, 1)))
         
         'Somando os Algarismos
         Count = 1
         Do While Count <= Len(Vetor)
            SPeso = SPeso + CInt(Mid(Vetor, Count, 1))
            Count = Count + 1
         Loop
         
         'Descobrindo a primeira dezena exata
         Auxiliar(0) = 10: Auxiliar(1) = 20: Auxiliar(2) = 30: Auxiliar(3) = 40: Auxiliar(4) = 50: Auxiliar(5) = 60: Auxiliar(6) = 70: Auxiliar(7) = 80: Auxiliar(8) = 90: Auxiliar(9) = 100: Auxiliar(10) = 110
         For i = 0 To 10
            If (SPeso <= Auxiliar(i)) Then
               Resto = Auxiliar(i) 'Dezena Exata Superior
               Exit For
            End If
         Next
                  
         '1º Digito
         DV = Resto - SPeso
         
         'Nova Inscrição
         NInscricao = Mid(NInscricao, 1, 3) & Mid(NInscricao, 5, 8) & DV
         
         '2º Dígito Verificador
         'Pesos (3 2 11 10 9 8 7 6 5 4 3 2)
         SPeso = ((3 * Mid(NInscricao, 1, 1)) + (2 * Mid(NInscricao, 2, 1)) + (11 * Mid(NInscricao, 3, 1)) + (10 * Mid(NInscricao, 4, 1)) + (9 * Mid(NInscricao, 5, 1)) + (8 * Mid(NInscricao, 6, 1)) + (7 * Mid(NInscricao, 7, 1)) + (6 * Mid(NInscricao, 8, 1)) + (5 * Mid(NInscricao, 9, 1)) + (4 * Mid(NInscricao, 10, 1)) + (3 * Mid(NInscricao, 11, 1)) + (2 * Mid(NInscricao, 12, 1)))
         Resto = SPeso Mod 11
         If Resto < 2 Then
            DV = 0
         Else
            DV = 11 - Resto
         End If
         
         'Nova Inscrição
         NInscricao = NInscricao & DV
         
         If NInscricao = RemoveCaracteres(IE) Then
            ValidaIE = True: MsgValIE = "": Exit Function
         Else
            ValidaIE = False: MsgValIE = "Dígito Verificador Incorreto." & vbCrLf & _
                                         "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
         End If
      Case "PA" 'Formato: 15.999999-5. Os Dois Primeiros Dígitos sempre vai ser '15' (Código do Estado)
         If Len(Inscricao) <> 9 Then MsgValIE = "Dígitos a mais ou a menos para essa Inscrição." & vbCrLf & _
                                                "Eram Esperam 9 Dígitos." & vbCrLf & _
                                                "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
         If Mid(Inscricao, 1, 2) <> 15 Then MsgValIE = "Insc. Estadual do Pará sempre deve Começar com '15'." & vbCrLf & _
                                                       "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
         'Nova Inscrição
         NInscricao = Mid(Inscricao, 1, 8)
         
         'Pesos (9 8 7 6 5 4 3 2)
         SPeso = ((9 * Mid(NInscricao, 1, 1)) + (8 * Mid(NInscricao, 2, 1)) + (7 * Mid(NInscricao, 3, 1)) + (6 * Mid(NInscricao, 4, 1)) + (5 * Mid(NInscricao, 5, 1)) + (4 * Mid(NInscricao, 6, 1)) + (3 * Mid(NInscricao, 7, 1)) + (2 * Mid(NInscricao, 8, 1)))
         Resto = SPeso Mod 11
         If Resto < 2 Then
            DV = 0
         Else
            DV = 11 - Resto
         End If
         
         'Nova Inscrição
         NInscricao = NInscricao & DV
         
         If NInscricao = RemoveCaracteres(IE) Then
            ValidaIE = True: MsgValIE = "": Exit Function
         Else
            ValidaIE = False: MsgValIE = "Dígito Verificador Incorreto." & vbCrLf & _
                                         "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
         End If
      Case "PR" 'Formato: NNNNNNNN-DD
         If Len(Inscricao) <> 10 Then MsgValIE = "Dígitos a mais ou a menos para essa Inscrição." & vbCrLf & _
                                                 "Eram Esperam 10 Dígitos." & vbCrLf & _
                                                 "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
         'Nova Inscrição
         NInscricao = Mid(Inscricao, 1, 8)
         
         '1º Dígito Verificador
         'Pesos (3 2 7 6 5 4 3 2)
         SPeso = ((3 * Mid(NInscricao, 1, 1)) + (2 * Mid(NInscricao, 2, 1)) + (7 * Mid(NInscricao, 3, 1)) + (6 * Mid(NInscricao, 4, 1)) + (5 * Mid(NInscricao, 5, 1)) + (4 * Mid(NInscricao, 6, 1)) + (3 * Mid(NInscricao, 7, 1)) + (2 * Mid(NInscricao, 8, 1)))
         Resto = SPeso Mod 11
         If Resto < 2 Then
            DV = 0
         Else
            DV = 11 - Resto
         End If
         
         'Nova Inscrição
         NInscricao = NInscricao & DV
         
         '2º Dígito Verificador
         'Pesos (4 3 2 7 6 5 4 3 2)
         SPeso = ((4 * Mid(NInscricao, 1, 1)) + (3 * Mid(NInscricao, 2, 1)) + (2 * Mid(NInscricao, 3, 1)) + (7 * Mid(NInscricao, 4, 1)) + (6 * Mid(NInscricao, 5, 1)) + (5 * Mid(NInscricao, 6, 1)) + (4 * Mid(NInscricao, 7, 1)) + (3 * Mid(NInscricao, 8, 1)) + (2 * Mid(NInscricao, 9, 1)))
         Resto = SPeso Mod 11
         If Resto < 2 Then
            DV = 0
         Else
            DV = 11 - Resto
         End If
         
         'Nova Inscrição
         NInscricao = NInscricao & DV
         
         If NInscricao = RemoveCaracteres(IE) Then
            ValidaIE = True: MsgValIE = "": Exit Function
         Else
            ValidaIE = False: MsgValIE = "Dígito Verificador Incorreto." & vbCrLf & _
                                         "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
         End If
      Case "PE" 'Exemplo 1: 0321418-40. Exemplo 2: 18.1.001.0000004-9
         If Len(Inscricao) <> 9 And Len(Inscricao) <> 14 Then MsgValIE = "Dígitos a mais ou a menos para essa Inscrição." & vbCrLf & _
                                                                         "Eram Esperam 9 ou 14 Dígitos." & vbCrLf & _
                                                                         "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
         If Len(Inscricao) = 9 Then 'Cadastros Novos Exemplo 1
            'Nova Inscrição
            NInscricao = Mid(Inscricao, 1, 7)
            
            '1º Dígito Verificador
            'Pesos (8 7 6 5 4 3 2)
            SPeso = ((8 * Mid(NInscricao, 1, 1)) + (7 * Mid(NInscricao, 2, 1)) + (6 * Mid(NInscricao, 3, 1)) + (5 * Mid(NInscricao, 4, 1)) + (4 * Mid(NInscricao, 5, 1)) + (3 * Mid(NInscricao, 6, 1)) + (2 * Mid(NInscricao, 7, 1)))
            Resto = SPeso Mod 11
            If Resto < 2 Then
               DV = 0
            Else
               DV = 11 - Resto
            End If
            
            'Nova Inscrição
            NInscricao = NInscricao & DV
            
            '2º Dígito Verificador
            'Pesos (9 8 7 6 5 4 3 2)
            SPeso = ((9 * Mid(NInscricao, 1, 1)) + (8 * Mid(NInscricao, 2, 1)) + (7 * Mid(NInscricao, 3, 1)) + (6 * Mid(NInscricao, 4, 1)) + (5 * Mid(NInscricao, 5, 1)) + (4 * Mid(NInscricao, 6, 1)) + (3 * Mid(NInscricao, 7, 1)) + (2 * Mid(NInscricao, 8, 1)))
            Resto = SPeso Mod 11
            If Resto < 2 Then
               DV = 0
            Else
               DV = 11 - Resto
            End If
            
            'Nova Inscrição
            NInscricao = NInscricao & DV
         
            If NInscricao = RemoveCaracteres(IE) Then
               ValidaIE = True: MsgValIE = "": Exit Function
            Else
               ValidaIE = False: MsgValIE = "Dígito Verificador Incorreto." & vbCrLf & _
                                            "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
            End If
         Else 'Cadastros Antigos Exemplo 2
            'Nova Inscrição
            NInscricao = Mid(Inscricao, 1, 13)
                        
            'Pesos (5 4 3 2 1 9 8 7 6 5 4 3 2)
            SPeso = ((5 * Mid(NInscricao, 1, 1)) + (4 * Mid(NInscricao, 2, 1)) + (3 * Mid(NInscricao, 3, 1)) + (2 * Mid(NInscricao, 4, 1)) + (1 * Mid(NInscricao, 5, 1)) + (9 * Mid(NInscricao, 6, 1)) + (8 * Mid(NInscricao, 7, 1)) + (7 * Mid(NInscricao, 8, 1)) + (6 * Mid(NInscricao, 9, 1)) + (5 * Mid(NInscricao, 10, 1)) + (4 * Mid(NInscricao, 11, 1)) + (3 * Mid(NInscricao, 12, 1)) + (2 * Mid(NInscricao, 13, 1)))
            Resto = SPeso Mod 11
            If Resto < 2 Then
               DV = 0
            Else
               DV = 11 - Resto
            End If
            
            'Nova Inscrição
            NInscricao = NInscricao & DV
            
            If NInscricao = RemoveCaracteres(IE) Then
               ValidaIE = True: MsgValIE = "": Exit Function
            Else
               ValidaIE = False: MsgValIE = "Dígito Verificador Incorreto." & vbCrLf & _
                                            "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
            End If
         End If
      Case "RJ" 'Formato: 99.999.99-D
         If Len(Inscricao) <> 8 Then MsgValIE = "Dígitos a mais ou a menos para essa Inscrição." & vbCrLf & _
                                                "Eram Esperam 8 Dígitos." & vbCrLf & _
                                                "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
         'Nova Inscricao
         NInscricao = Mid(Inscricao, 1, 7)
         
         'Pesos (2 7 6 5 4 3 2)
         SPeso = ((2 * Mid(NInscricao, 1, 1)) + (7 * Mid(NInscricao, 2, 1)) + (6 * Mid(NInscricao, 3, 1)) + (5 * Mid(NInscricao, 4, 1)) + (4 * Mid(NInscricao, 5, 1)) + (3 * Mid(NInscricao, 6, 1)) + (2 * Mid(NInscricao, 7, 1)))
         Resto = SPeso Mod 11
         If Resto < 2 Then
            DV = 0
         Else
            DV = 11 - Resto
         End If
         
         'Nova Inscrição
         NInscricao = NInscricao & DV
      
         If NInscricao = RemoveCaracteres(IE) Then
            ValidaIE = True: MsgValIE = "": Exit Function
         Else
            ValidaIE = False: MsgValIE = "Dígito Verificador Incorreto." & vbCrLf & _
                                         "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
         End If
      Case "RN" 'Formato: 9 Dígitos Ou 10 Dígitos. Os Dois Primeiros Dígitos é sempre '20'
         If Mid(Inscricao, 1, 2) <> 20 Then MsgValIE = "Insc. Estadual do Rio Grande do Norte sempre deve Começar com '20'." & vbCrLf & _
                                                       "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
         If Len(Inscricao) <> 10 And Len(Inscricao) <> 9 Then MsgValIE = "Dígitos a mais ou a menos para essa Inscrição." & vbCrLf & _
                                                                         "Eram Esperam 10 ou 9 Dígitos." & vbCrLf & _
                                                                         "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
         If Len(Inscricao) = 9 Then   '9 Dígitos
            'Nova Inscricao
            NInscricao = Mid(Inscricao, 1, 8)
            
            'Pesos (9 8 7 6 5 4 3 2)
            SPeso = ((9 * Mid(NInscricao, 1, 1)) + (8 * Mid(NInscricao, 2, 1)) + (7 * Mid(NInscricao, 3, 1)) + (6 * Mid(NInscricao, 4, 1)) + (5 * Mid(NInscricao, 5, 1)) + (4 * Mid(NInscricao, 6, 1)) + (3 * Mid(NInscricao, 7, 1)) + (2 * Mid(NInscricao, 8, 1)))
            SPeso = SPeso * 10 'Frescura na Bund...
            Resto = SPeso Mod 11
            If Resto = 10 Then
               DV = 0
            Else
               DV = Resto
            End If
            
            'Nova Inscrição
            NInscricao = NInscricao & DV
            
            If NInscricao = RemoveCaracteres(IE) Then
               ValidaIE = True: MsgValIE = "": Exit Function
            Else
               ValidaIE = False: MsgValIE = "Dígito Verificador Incorreto." & vbCrLf & _
                                            "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
            End If
         Else '10 Dígitos
            'Nova Inscricao
            NInscricao = Mid(Inscricao, 1, 9)
            
            'Pesos (10 9 8 7 6 5 4 3 2)
            SPeso = ((10 * Mid(NInscricao, 1, 1)) + (9 * Mid(NInscricao, 2, 1)) + (8 * Mid(NInscricao, 3, 1)) + (7 * Mid(NInscricao, 4, 1)) + (6 * Mid(NInscricao, 5, 1)) + (5 * Mid(NInscricao, 6, 1)) + (4 * Mid(NInscricao, 7, 1)) + (3 * Mid(NInscricao, 8, 1)) + (2 * Mid(NInscricao, 9, 1)))
            SPeso = SPeso * 10 'Frescura na Bund...
            Resto = SPeso Mod 11
            If Resto < 2 Then
               DV = 0
            Else
               DV = 11 - Resto
            End If
            
            'Nova Inscrição
            NInscricao = NInscricao & DV
            
            If NInscricao = RemoveCaracteres(IE) Then
               ValidaIE = True: MsgValIE = "": Exit Function
            Else
               ValidaIE = False: MsgValIE = "Dígito Verificador Incorreto." & vbCrLf & _
                                            "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
            End If
         End If
      Case "RS" 'Formato: NNN/NNNNNN-D. Exemplo: 224/365879-2
         If Len(Inscricao) <> 10 Then MsgValIE = "Dígitos a mais ou a menos para essa Inscrição." & vbCrLf & _
                                                 "Eram Esperam 10 Dígitos." & vbCrLf & _
                                                 "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
         'Nova Inscricao
         NInscricao = Mid(Inscricao, 1, 9)
         
         'Pesos (2 9 8 7 6 5 4 3 2)
         SPeso = ((2 * Mid(NInscricao, 1, 1)) + (9 * Mid(NInscricao, 2, 1)) + (8 * Mid(NInscricao, 3, 1)) + (7 * Mid(NInscricao, 4, 1)) + (6 * Mid(NInscricao, 5, 1)) + (5 * Mid(NInscricao, 6, 1)) + (4 * Mid(NInscricao, 7, 1)) + (3 * Mid(NInscricao, 8, 1)) + (2 * Mid(NInscricao, 9, 1)))
         Resto = SPeso Mod 11
         If Resto < 2 Then
            DV = 0
         Else
            DV = 11 - Resto
         End If
         
         'Nova Inscrição
         NInscricao = NInscricao & DV
         
         If NInscricao = RemoveCaracteres(IE) Then
            ValidaIE = True: MsgValIE = "": Exit Function
         Else
            ValidaIE = False: MsgValIE = "Dígito Verificador Incorreto." & vbCrLf & _
                                         "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
         End If
      Case "RO" 'Cuidado Regra Mudou. Formato Antigo: 3 Digitos(Municipio) + 5 Dígitos (Empresa) + 1 Dígito Verificador. Formato: 13 Dígitos + 1 Dígito Verificador
         If Len(Inscricao) <> 14 Then MsgValIE = "Dígitos a mais ou a menos para essa Inscrição." & vbCrLf & _
                                                 "Eram Esperados 14 Dígitos." & vbCrLf & _
                                                 "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
         'Nova Inscrição
         NInscricao = Mid(Inscricao, 1, 13)
         
         'Pesos (6 5 4 3 2 9 8 7 6 5 4 3 2)
         SPeso = ((6 * Mid(NInscricao, 1, 1)) + (5 * Mid(NInscricao, 2, 1)) + (4 * Mid(NInscricao, 3, 1)) + (3 * Mid(NInscricao, 4, 1)) + (2 * Mid(NInscricao, 5, 1)) + (9 * Mid(NInscricao, 6, 1)) + (8 * Mid(NInscricao, 7, 1)) + (7 * Mid(NInscricao, 8, 1)) + (6 * Mid(NInscricao, 9, 1)) + (5 * Mid(NInscricao, 10, 1)) + (4 * Mid(NInscricao, 11, 1)) + (3 * Mid(NInscricao, 12, 1)) + (2 * Mid(NInscricao, 13, 1)))
         Resto = SPeso Mod 11
         If Resto < 2 Then
            DV = 0
         Else
            DV = 11 - Resto
         End If
         
         'Nova Inscrição
         NInscricao = NInscricao & DV
         
         If NInscricao = RemoveCaracteres(IE) Then
            ValidaIE = True: MsgValIE = "": Exit Function
         Else
            ValidaIE = False: MsgValIE = "Dígito Verificador Incorreto." & vbCrLf & _
                                         "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
         End If
      Case "RR" 'Formato: 2 Dígitos Constantes (24) + 6 Dígitos (Empresa) + 1 Dígito Verificador. Os Dois Primeiros Dígitos sempre é '24'. Exemplo: 24006628-1
         If Mid(Inscricao, 1, 2) <> 24 Then MsgValIE = "Insc. Estadual de Roraima sempre deve Começar com '24'." & vbCrLf & _
                                                       "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
         If Len(Inscricao) <> 9 Then MsgValIE = "Dígitos a mais ou a menos para essa Inscrição." & vbCrLf & _
                                                "Eram Esperados 9 Dígitos." & vbCrLf & _
                                                "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
         'Nova Inscrição
         NInscricao = Mid(Inscricao, 1, 8)
         
         'Pesos (1 2 3 4 5 6 7 8)
         SPeso = ((1 * Mid(NInscricao, 1, 1)) + (2 * Mid(NInscricao, 2, 1)) + (3 * Mid(NInscricao, 3, 1)) + (4 * Mid(NInscricao, 4, 1)) + (5 * Mid(NInscricao, 5, 1)) + (6 * Mid(NInscricao, 6, 1)) + (7 * Mid(NInscricao, 7, 1)) + (8 * Mid(NInscricao, 8, 1)))
         Resto = SPeso Mod 9
         DV = Resto
      
         'Nova Inscrição
         NInscricao = NInscricao & DV
         
         If NInscricao = RemoveCaracteres(IE) Then
            ValidaIE = True: MsgValIE = "": Exit Function
         Else
            ValidaIE = False: MsgValIE = "Dígito Verificador Incorreto." & vbCrLf & _
                                         "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
         End If
      Case "SP" 'Obs.: Tem Produtor e Não Produtor (Formatos Diferentes) 'Removido a Validação do Produtor Paulista, Pois o Formato agora é o mesmo
         If Len(Inscricao) <> 12 And Len(Inscricao) <> 13 Then MsgValIE = "Dígitos a mais ou a menos para essa Inscrição." & vbCrLf & _
                                                                          "Eram Esperados 12 Dígitos." & vbCrLf & _
                                                                          "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
         If Len(Inscricao) = 12 And Not ProdutorSP Then 'Formato: 12 Dígitos sendo o 9º e 12º Dígito Verificador
            'Exemplo: 110.042.490.114
                        
            'Nova Inscrição
            NInscricao = Mid(Inscricao, 1, 8)
            
            '1º Dígito Verificador
            'Pesos (1 3 4 5 6 7 8 10)
            SPeso = ((1 * Mid(Inscricao, 1, 1)) + (3 * Mid(Inscricao, 2, 1)) + (4 * Mid(Inscricao, 3, 1)) + (5 * Mid(Inscricao, 4, 1)) + (6 * Mid(Inscricao, 5, 1)) + (7 * Mid(Inscricao, 6, 1)) + (8 * Mid(Inscricao, 7, 1)) + (10 * Mid(Inscricao, 8, 1)))
            Resto = SPeso Mod 11
            DV = Right$(Resto, 1)
            
            'Nova Inscrição
            NInscricao = NInscricao & DV & Mid(Inscricao, 10, 2)
            
            '2º Dígito Verificador
            'Pesos (3 2 10 9 8 7 6 5 4 3 2)
            SPeso = ((3 * Mid(NInscricao, 1, 1)) + (2 * Mid(NInscricao, 2, 1)) + (10 * Mid(NInscricao, 3, 1)) + (9 * Mid(NInscricao, 4, 1)) + (8 * Mid(NInscricao, 5, 1)) + (7 * Mid(NInscricao, 6, 1)) + (6 * Mid(NInscricao, 7, 1)) + (5 * Mid(NInscricao, 8, 1)) + (4 * Mid(NInscricao, 9, 1)) + (3 * Mid(NInscricao, 10, 1)) + (2 * Mid(NInscricao, 11, 1)))
            Resto = SPeso Mod 11
            DV = Right$(Resto, 1)
            
            'Nova Inscrição
            NInscricao = NInscricao & DV
            
            If NInscricao = RemoveCaracteres(IE) Then
               ValidaIE = True: MsgValIE = "": Exit Function
            Else
               ValidaIE = False: MsgValIE = "Dígito Verificador Incorreto." & vbCrLf & _
                                            "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
            End If
         Else 'Formato: P0MMMSSSSD000 '13 Dígitos. Não se usa mais a Letra 'P', Apenas usar para o Calculo. Exemplo: P-01100424.3/002
            If Len(Inscricao) = 13 Then MsgValIE = "Essa Inscr. Estadual NÃO é de um Produtor Paulista." & vbCrLf & _
                                                   "Se Tiver a Letra 'P', Favor Removê-la." & vbCrLf & _
                                                   "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
            'Nova Inscrição
            NInscricao = Mid(Inscricao, 1, 8)
            
            'Pesos (1 3 4 5 6 7 8 10)
            SPeso = ((1 * Mid(NInscricao, 1, 1)) + (3 * Mid(NInscricao, 2, 1)) + (4 * Mid(NInscricao, 3, 1)) + (5 * Mid(NInscricao, 4, 1)) + (6 * Mid(NInscricao, 5, 1)) + (7 * Mid(NInscricao, 6, 1)) + (8 * Mid(NInscricao, 7, 1)) + (10 * Mid(NInscricao, 8, 1)))
            Resto = SPeso Mod 11
            DV = Right$(Resto, 1)
            
            'Nova Inscrição
            NInscricao = NInscricao & DV & Mid(Inscricao, 10, 3)
            
            If NInscricao = RemoveCaracteres(IE) Then
               ValidaIE = True: MsgValIE = "": Exit Function
            Else
               ValidaIE = False: MsgValIE = "Dígito Verificador Incorreto." & vbCrLf & _
                                            "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
            End If
         End If
      Case "TO" 'Formato: 11 Dígitos. Os Dois Primeiro sempre '29'.
         'Exemplo: 29.02.2783-6
         If Len(Inscricao) <> 9 Then MsgValIE = "Dígitos a mais ou a menos para essa Inscrição." & vbCrLf & _
                                                 "Eram Esperados 11 Dígitos." & vbCrLf & _
                                                 "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
         If Mid(Inscricao, 1, 2) <> 29 Then MsgValIE = "Insc. Estadual de Tocantins deve Começar com '29'." & vbCrLf & _
                                                       "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
         'Nova Inscricao
         NInscricao = Mid(Inscricao, 1, 8)
         
         SPeso = ((9 * Mid(NInscricao, 1, 1)) + (8 * Mid(NInscricao, 2, 1)) + (7 * Mid(NInscricao, 3, 1)) + (6 * Mid(NInscricao, 4, 1)) + (5 * Mid(NInscricao, 5, 1)) + (4 * Mid(NInscricao, 6, 1)) + (3 * Mid(NInscricao, 7, 1)) + (2 * Mid(NInscricao, 8, 1)))
         Resto = SPeso Mod 11
         If Resto < 2 Then
            DV = 0
         Else
            DV = 11 - Resto
         End If
         
         'Nova Inscrição
         NInscricao = NInscricao & DV
         
         If NInscricao = RemoveCaracteres(IE) Then
            ValidaIE = True: MsgValIE = "": Exit Function
         Else
            ValidaIE = False: MsgValIE = "Dígito Verificador Incorreto." & vbCrLf & _
                                         "Inscrição Estadual Inválida.": ValidaIE = False: Exit Function
         End If
   End Select
   
   'Fim...Ufa Achei que nw tinha fim rsrs
   
DeuErro:
   If Err.Number <> 0 Then
      MsgBox Err.Description, vbCritical + vbOKOnly, vaTitulo
   End If
   
End Function


'Captura Pasta
Public Sub PegaDir2(Formulario As Form)
   Dim lpIDList As Long, sBuffer As String, szTitle As String
   Dim tBrowseInfo As BrowseInfoYGOR

   'Personaliza a procura
   szTitle = "Pasta XML NFe"
   With tBrowseInfo
      .hWndOwner = Formulario.hWnd
      .lpszTitle = lstrcatYGOR(szTitle, "")
      .ulFlags = BIF_RETURNONLYFSDIRSYGOR + BIF_DONTGOBELOWDOMAINYGOR
   End With

   'Abre a janela de procura
   'E retorna o caminho da pasta selecionada
   lpIDList = SHBrowseForFolderYGOR(tBrowseInfo)

   'Se existir alguma pasta selecionada extrair
   If (lpIDList) Then
      sBuffer = Space(MAX_PATHYGOR)
      SHGetPathFromIDListYGOR lpIDList, sBuffer
      sBuffer = Left(sBuffer, InStr(sBuffer, vbNullChar) - 1)
      vaDir = sBuffer & "\"      
   End If

End Sub

Public Function EstaEmIDE()
   On Error Resume Next
   Debug.Print 1 / 0
   If Err Then EstaEmIDE = True
   Err.Clear
End Function


Public Function Capitaliza(ByVal Texto As String) As String
   Dim Exceções As Variant, Ind As Long, Pos As Long
   Texto = " " & LCase(Texto) & " "
   Exceções = Array(" Com ", " Da ", " Das ", " De ", " Des ", " Do ", " Dos ", " E ")
   For Pos = 1 To Len(Texto) - 1
      Select Case Asc(Mid(Texto, Pos, 1))
         Case 10, 32 To 47, 58 To 64, 91 To 96, 123 To 127
            Mid(Texto, Pos + 1, 1) = UCase(Mid(Texto, Pos + 1, 1))
      End Select
      For Ind = LBound(Exceções) To UBound(Exceções)
         If Mid(Texto, Pos, Len(Exceções(Ind))) = Exceções(Ind) Then Mid(Texto, Pos, Len(Exceções(Ind))) = LCase(Mid(Texto, Pos, Len(Exceções(Ind))))
      Next Ind
   Next Pos
   Capitaliza = Mid(Texto, 2, Len(Texto) - 2)
End Function


Public Sub mdiLoad()
  With mdiNFe
     .WindowState = vbMaximized
  End With 
  mnuCapitaliza.Enabled = False 
  mnuCapitaliza.Checked = True
  cmdCapitaliza.Value = True  
  paneControles.Visible = False
  lblTitulo.Visible = True
  Status
End Sub

'Propósito: Consertar o tamanho dos campos quando muda de aba (eles aumentavam sozinho pau do vb6)
Public Sub MudaTamCampos(formulario As Form)
   Dim C As Variant
   
   On Error Resume Next
   
   For Each C In formulario.Controls
      If TypeOf C Is TextBox Then
         If C.Font = "Microsoft Sans Serif" And C.Font.Size = 9.75 And C.Height = 360 _
         And C.Name <> "txtMemo" Then
            C.Font.Size = 8
            C.Height = 300
            C.Font.Size = 10
         End If
      End If
   Next
   
End Sub

'ROTINA PARA POSICIONAR O REGISTRO NUM DETERMINADO LOCAL DO INDICE
Public Sub PosicionaRegistro(frmFormulario As Form, Indice As String, ParamArray Chaves() As Variant)
   Dim IndAtual As String, x As Variant, Operador As String
      
   Operador = "="
   
   If Chaves(0) = 0 Then Exit Sub
     
   With frmFormulario.vgTb 'para facilitar
      IndAtual = .Index 'salva indice atual
      .ChangeIndex Indice
      Select Case UBound(Chaves) 'não se espante! O Bill Gates falou que é assim mesmo!...
         Case 0 'se tiver uma chave...
            .SeekRecord "", Operador$, Chaves(0) '... pesquisa só ela...
         Case 1
            .SeekRecord "", Operador$, Chaves(0), Chaves(1)
         Case 2
            .SeekRecord "", Operador$, Chaves(0), Chaves(1), Chaves(2)
         Case 3
            .SeekRecord "", Operador$, Chaves(0), Chaves(1), Chaves(2), Chaves(3)
         Case 4
            .SeekRecord "", Operador$, Chaves(0), Chaves(1), Chaves(2), Chaves(3), Chaves(4)
         Case 5
            .SeekRecord "", Operador$, Chaves(0), Chaves(1), Chaves(2), Chaves(3), Chaves(4), Chaves(5)
         Case 6
            .SeekRecord "", Operador$, Chaves(0), Chaves(1), Chaves(2), Chaves(3), Chaves(4), Chaves(5), Chaves(6)
         Case 7
            .SeekRecord "", Operador$, Chaves(0), Chaves(1), Chaves(2), Chaves(3), Chaves(4), Chaves(5), Chaves(6), Chaves(7)
         Case 8
            .SeekRecord "", Operador$, Chaves(0), Chaves(1), Chaves(2), Chaves(3), Chaves(4), Chaves(5), Chaves(6), Chaves(7), Chaves(8)
         Case 9
            .SeekRecord "", Operador$, Chaves(0), Chaves(1), Chaves(2), Chaves(3), Chaves(4), Chaves(5), Chaves(6), Chaves(7), Chaves(8), Chaves(9)
      End Select
      If Not frmFormulario.vgTb.NoMatch Then 'se encontrou...
         x = frmFormulario.vgTb.BookMark
         frmFormulario.Reposition 'mostra o registro
      End If
      'Comentei essa linha de baixo, senao toda vez que o usuario voltar o registro, voltaria no primeiro registro
      '.ChangeIndex IndAtual 'retorna ao indice original
      seqRegistro = 0
   End With
End Sub

'ROTINA PARA PEGAR UMA TABELA AUXILIAR
Public Sub TbAuxiliar(Tabela As String, Optional Filtro As String, Optional ByRef TabAuxiliar As GRecordSet)
   Dim sql As String
   
   On Error Resume Next
     
   sql = "SELECT * FROM [" & Tabela & "] " & _
         "WHERE " & IIf(Not Vazio(Filtro), Filtro, "1 = 1")
   
   Set TabAuxiliar = vgDb.OpenRecordSet(sql)
   
End Sub

'ROTINA MANUAL
'PROPÓSITO: AO ATIVAR UMA JANELA HABILITAR OS BOTOES DE FERRAMENTAS
'prepara o formulário quando o mesmo pega o foco
Public Sub AtivaForm(F As Form)
   On Error Resume Next
   If F.Name = mdiNFe.ActiveForm.Name Then      'evita foco em form minimizado (AH! VB!!!...)
      If Err > 0 Then
         Err.Clear
      Else
         'INICIO MANUAL
         If F.vgTipo = TP_TABELA Then
            mnuCapitaliza.Enabled = True
         Else
            mnuCapitaliza.Enabled = False
         End If
         F.vgAlterar = True
         F.Icon = mdiNFe.Icon
         'If Not EstaEmIDE Then 'PC do programador
            AjustaBorda F, F.lblAjuste
         'End If
         'FIM MANUAL
         PrepBotoes F, F.vgSituacao               'ajusta barra de farramenta
      End If
   End If
   'INICIO MANUAL
   If QtForms >= 1 And F.vgTipo = TP_TABELA Then
      paneControles.Visible = True
      lblTitulo.Visible = False
   Else
      paneControles.Visible = False
      lblTitulo.Visible = True
   End If
   'FIM MANUAL
End Sub


'ROTINAS DO GAS QUE POSSUEM INTERVENÇÕES
'BORA LÁ...
'ROTINA MANUAL
'PROPÓSITO: HABILITAR/DESABILITAR CONTROLES DA BARRA DE FERRAMENTA
'finaliza formulário aberto
Public Sub FinalizaForm(F As Form)
   'INICIO MANUAL
   Dim QtdeForm As Integer
   QtdeForm = QtForms
   'FIM MANUAL
   GravaParametrosForm F                          'grava situação do form no .INI
   With mdiNFe                                    'referencia o MDI
      'INICIO MANUAL
      If QtForms > 1 Then
         If F.Name = "frmBrowse" Then
            QtdeForm = QtForms - 1
         End If
      End If
      'FIM MANUAL
      If QtdeForm = 1 Then                         'este é o ultimo form na tela
         PrepBotoes mdiNFe, ACAO_NAVEGANDO      'ajusta barra de ferramenta
         .vgPriVez = True                         'evita remontagem dos indices
         .vgPriVez = False
         'INICIO MANUAL
          paneControles.Visible = False   'Painel dos controles incluir, salvar...
          lblTitulo.Visible = True        'Título DELLALIO NFe
          mnuCapitaliza.Enabled = False
         'FIM MANUAL
      End If
   End With
   F.vgSituacao = ACAO_NAVEGANDO                  'situação do form = normal
   If F.vgCaracteristica <> F_COMUM Then          'form com arquivo aberto..
      If F.vgTemFiltro Then                       'se tem filtro
         F.vgSQL$ = ""                            'limpa filtro existente
      End If
      On Error Resume Next                     'previne eventuais erros
      F.vgTb.CloseRecordset                    'fecha tabela
      Set F.vgTb = Nothing                     'libera objeto relacionado      
   End If
End Sub

'ROTINA PARA AJUSTAR A BORDA DA JANELA AUTOMATICAMENTE
Public Sub AjustaBorda(janela As Form, ajuste As Label)
   On Error Resume Next
      
   With janela
      .Height = ajuste.Top + 430
      .Width = ajuste.Left + 680
      .grdBrowse.ShowFilterBar = True
   End With

End Sub

Public Sub Status()
   Dim Dia As Date, Hora As String
            
   'Data e Hora
   Dia = Format(Date, "dd") & "/" & Format(Date, "mm") & "/" & Format(Date, "yyyy") 'Dia
   Hora = Format(Hour(Time), "00") & ":" & Format(Minute(Time), "00") 'Horas
      
   lblDataHora.Caption = Dia & " " & Hora  
   
End Sub

'Pegando o nome do Usuario da Maquina
Public Function UsuarioPC() As String
   Dim strUserName As String
   
   On Error Resume Next
   
   'Create a buffer
   strUserName = String(100, Chr$(0))
   'Get the username
   GetUserName strUserName, 100
   'strip the rest of the buffer
   strUserName = Left$(strUserName, InStr(strUserName, Chr$(0)) - 1) 
   
   UsuarioPC = strUserName 

End Function

' 1 CFOP - 2 % iCMS - 3 % ipi - 4 Vr Ipi - 5 Cst - 6 Bc - 7 Vr Icms - 8 Pis - 9 Cofins - 10 Iva - 11 Bc St - 12 Vr icms st - 13 % icms st
Public Function CalculaImposto(SeqItem As Long, SeqGeral As Long, Oq As Integer, VrTotal As Double, vrFrete As Double, VrDesc As Double, Optional NCM As Long) As Variant
   Dim TbProdutos As New GRecordSet, TbNcm As New GRecordSet, TbGeral As New GRecordSet, TbMunicipios As New GRecordSet, TbIcms As New GRecordSet
   Dim ConsumidorFinal As Boolean, Substituicao As Boolean, MatAdqTerc As Boolean, ForadoEstado As Boolean, ForadoPais As Boolean, Reducao As Boolean
   Dim Contribuinte As Boolean, BC As Double, AliqICMS As Double, IVA As Double, VrICMS As Double, UF As String, Isento As Boolean, Importado As Boolean, TemIPI As Boolean

   On Error Resume Next
   
   'Produtos
   Set TbProdutos = vgDb.OpenRecordSet("SELECT * FROM Produtos WHERE [Sequencia do produto] = " & SeqItem & " AND [Sequencia do Produto] > 0") 'Produtos
   Importado = TbProdutos!Importado
     
   If TbProdutos.RecordCount = 0 Then CalculaImposto = 0: Exit Function
      Set TbNcm = vgDb.OpenRecordSet("SELECT * FROM [Classificação fiscal] WHERE [Sequencia da classificação] = " & TbProdutos![Sequencia da classificação] & " AND [Sequencia da classificação] > 0") 'Classificação Fiscal (NCM)
   If TbNcm.RecordCount = 0 Then CalculaImposto = 0: Exit Function
   
   'DESTINATÁRIO
   Set TbGeral = vgDb.OpenRecordSet("SELECT * FROM Geral WHERE [Sequencia do Geral] = " & SeqGeral & " AND [Sequencia do Geral] > 0") 'Geral
   Set TbMunicipios = vgDb.OpenRecordSet("SELECT * FROM Municipios WHERE [Sequencia do Municipio] = " & TbGeral![Sequencia Do Municipio] & " AND [Sequencia do Municipio] > 0") 'Município (Geral)
   Set TbIcms = vgDb.OpenRecordSet("SELECT * FROM ICMS WHERE UF = '" & TbMunicipios!UF & "'")
   UF = TbMunicipios!UF
  
   'Opções
   MatAdqTerc = TbProdutos![Material Adquirido de Terceiro]
   ConsumidorFinal = TbGeral![Consumidor final]
   Substituicao = TbNcm!Iva > 0 'Item Faz Parte da Substituição?
   Isento = TbGeral!Isento 'Inscrição Isenta: Não Calcula ICMS
   ForadoEstado = UF <> "SP" 'É Fora do Estado
   ForadoPais = UF = "EX" 'É Fora do Pais (Exterior)
   TemIPI = TbNcm![Percentual de ipi] > 0
   
   If TbGeral!Tipo = 1 Then 'Pessoa Jurídica
      Contribuinte = (CBool(Not Vazio(TbGeral![RG e IE])))
   End If
      
   AliqICMS = TbIcms![Aliquota Do icms] 
  
   'Vamos Calcular Oque?
   Select Case Oq
      Case "1" 'CFOP (Apenas as Vendas. Devoluções, Remessas e etc... Será Avulsa(Usuário Digitará))
         If Not ForadoPais Then
            If ForadoEstado And Substituicao And Not ConsumidorFinal Then CalculaImposto = "6403": Exit Function 
            If Not ForadoEstado And Substituicao And Not ConsumidorFinal Then CalculaImposto = "5403": Exit Function
            If Not ForadoEstado And Substituicao And MatAdqTerc Then CalculaImposto = "5403": Exit Function 
            If ForadoEstado And Substituicao And MatAdqTerc Then CalculaImposto = "6403": Exit Function  
            If Not ForadoEstado And Not MatAdqTerc Then CalculaImposto = "5101": Exit Function 'Fabricação Propria Dentro do Estado
            If ForadoEstado And Not MatAdqTerc Then CalculaImposto = "6101": Exit Function 'Fabricação Propria Fora do Estado
            If Not ForadoEstado And MatAdqTerc Then CalculaImposto = "5102": Exit Function 'venda de Material adq. de terceiros
            If ForadoEstado And MatAdqTerc Then CalculaImposto = "6102": Exit Function
         Else
            If Not MatAdqTerc  Then CalculaImposto = "7101": Exit Function
            If MatAdqTerc Then CalculaImposto = "7102": Exit Function
         End If
      Case "2" '% ICMS
         If ConsumidorFinal And Substituicao And MatAdqTerc Then CalculaImposto = 0: Exit Function 'Tem Substituição entao vamos cair fora
         If Importado And ForadoEstado Then CalculaImposto = 4: Exit Function 'Produto Importados são cobrados 4% de ICMS qdo Fora do Estado
         If Importado And Not ForadoEstado Then CalculaImposto = AliqICMS: Exit Function
            CalculaImposto =  AliqICMS: Exit Function    
      Case "3", "4" '% IPI, Vr IPI
         If MatAdqTerc Then CalculaImposto = 0: Exit Function 'Se Mercadoria de Terceiro CFOP(5102, 6102, 7102)
         If TbNcm![Percentual de ipi] = 0 Then CalculaImposto = 0: Exit Function 'Se nw Tiver Percentual
         If TbProdutos!Usado Then CalculaImposto = 0: Exit Function 'Se Item for Usado 
         If Oq = 3 Then '%IPI
            CalculaImposto = TbNcm![Percentual de ipi] 
         Else 'Valor IPI
            CalculaImposto = Round((VrTotal * (TbNcm![Percentual de ipi] / 100)), 2)
         End If
         Exit Function 
      Case "5" 'CST
         If ForadoPais Then CalculaImposto = "041": Exit Function 'Exterior
         If Not ConsumidorFinal And Substituicao And Not Importado Then CalculaImposto = "010": Exit Function 'Substituição e Revenda
         If Substituicao And ConsumidorFinal And MatAdqTerc Then CalculaImposto = "060": Exit Function 'Substituição e MATERIAL ADQUERIDO DE TERCEIROS
         If Importado And Substituicao And ConsumidorFinal And Not MatAdqTerc Then CalculaImposto = "100": Exit Function
         If Substituicao And ConsumidorFinal And Not MatAdqTerc And Not Importado Then CalculaImposto = "000": Exit Function
         If Importado And Not Substituicao Then CalculaImposto = "100": Exit Function 'Substituicao e Produto Importado
         If Importado And Substituicao And Not ConsumidorFinal Then CalculaImposto = "110": Exit Function
            CalculaImposto = "000"
     Case "6" 'BC ICMS
         If ConsumidorFinal And Substituicao And MatAdqTerc Then CalculaImposto = 0: Exit Function 'Tem Substituição entao vamos cair fora
         If TemIPI And Not TbProdutos!Usado And ConsumidorFinal And Not MatAdqTerc Then 'Se for Produto tem IPI, for Novo e nw for Revenda e nw For Material Adquerido de terceiros
            BC = Round(VrTotal * (TbNcm![Percentual de ipi] / 100), 2) 'Vamos Adicionar o IPI na Base de ICMS
         End If 
         BC = Round(BC + VrTotal + VrFrete - VrDesc, 2)
            CalculaImposto = BC
            Exit Function 
      Case "7" 'Valor do ICMS
         If ConsumidorFinal And Substituicao And MatAdqTerc Then CalculaImposto = 0: Exit Function 'Tem Substituição entao vamos cair fora
         If TemIPI And Not TbProdutos!Usado And ConsumidorFinal And Not MatAdqTerc Then 'Se for Produto tem IPI, for Novo e nw for Revenda e nw For Material Adquerido de terceiros
            BC = Round(VrTotal * (TbNcm![Percentual de ipi] / 100), 2) 'Vamos Adicionar o IPI na Base de ICMS
            BC = Round(BC + VrTotal + VrFrete - VrDesc, 2)
         End If
            
         If Not TemIPI Then 
            BC = Round(VrTotal + VrFrete - VrDesc, 2)  
         End If
         
         If TemIPI And MatAdqTerc Then 
            BC = Round(VrTotal + VrFrete - VrDesc, 2)  
         End If
          
         If TemIPI And Not ConsumidorFinal Then 
            BC = Round(VrTotal + VrFrete - VrDesc, 2)  
         End If
         
         If TbProdutos!Usado Then
             BC = Round(VrTotal + VrFrete - VrDesc, 2)  
         End If
         
         If Not Importado Then
            CalculaImposto = Round(BC * (AliqICMS / 100), 2)
         Else 'Importado
             If Not ForadoEstado Then
                CalculaImposto = Round(BC * (AliqICMS / 100), 2)
             Else 'Importados Fora do Estado
                  CalculaImposto = Round(BC * (4 / 100), 2)
             End If
         End If 
         Exit Function    
     Case "8" 'Valor do PIS
       CalculaImposto = Round((VrTotal + VrFrete - VrDesc) * (Empresa![Aliquota Do pis] / 100), 2)
     Case "9" 'Valor do COFINS
       CalculaImposto = Round((VrTotal + VrFrete - VrDesc) * (Empresa![Aliquota Do cofins] / 100), 2)    
     Case "10" 'IVA Ajustado
         If Not ConsumidorFinal And Substituicao Then
            'Formula: (((1 + (IVA Original / 100)) * (1 - (Porcentagem de ICMS / 100)) / (1 - (Alíquota InterEstadual / 100))) - 1) * 100 Esta linha ja estava comentada
            If Not Importado Then
               IVA = Round((((1 + (TbNcm!IVA / 100)) * (1 - (AliqICMS / 100)) / (1 - (TbIcms![Aliquota interna] / 100))) - 1) * 100, 2)
            Else 'Importado
            If ForadoEstado Then
               IVA = Round((((1 + (TbNcm!IVA / 100)) * (1 - (4 / 100)) / (1 - (TbIcms![Aliquota interna] / 100))) - 1) * 100, 2)
            Else ' Dentro do Estado
               IVA = Round((((1 + (TbNcm!IVA / 100)) * (1 - (AliqICMS / 100)) / (1 - (TbIcms![Aliquota interna] / 100))) - 1) * 100, 2)
            End If   
            End If
            CalculaImposto = IVA
            Exit Function
         Else
            CalculaImposto = 0: Exit Function
         End If
     Case "11" 'BC ICMS ST
         If Not ConsumidorFinal And Substituicao Then 'Se for Revenda e Substituicao
            BC = 0
            BC = Round(BC + VrTotal - VrDesc, 2)
            BC = Round(BC + VrFrete, 2)
            
            If Not Importado Then
               IVA = Round((((1 + (TbNcm!IVA / 100)) * (1 - (AliqICMS / 100)) / (1 - (TbIcms![Aliquota interna] / 100))) - 1) * 100, 2)
            Else ' Importado
            If ForadoEstado Then
               IVA = (((1 + (TbNcm!IVA / 100)) * (1 - (4 / 100)) / (1 - (TbIcms![Aliquota interna] / 100))) - 1) * 100
            Else
               IVA = (((1 + (TbNcm!IVA / 100)) * (1 - (AliqICMS / 100)) / (1 - (TbIcms![Aliquota interna] / 100))) - 1) * 100 
            End If   
            End If
            CalculaImposto = Round((BC) * ((IVA / 100) + 1), 2)
            Exit Function
         End If
         CalculaImposto = 0: Exit Function
      Case "12" 'Valor do ICMS ST
         If Not ConsumidorFinal And Substituicao Then 'Se for Revenda e Substituicao
            BC = 0
            BC = Round(BC + VrTotal - VrDesc, 2)
            BC = Round(BC + VrFrete, 2)
            
            If Not Importado Then
               VrICMS = Round(BC * (AliqICMS / 100), 2) 
               IVA = Round((((1 + (TbNcm!IVA / 100)) * (1 - (AliqICMS / 100)) / (1 - (TbIcms![Aliquota interna] / 100))) - 1) * 100, 2) 
            Else 'Importado
            If ForadoEstado Then
               VrICMS = BC * (4 / 100)
               IVA = (((1 + (TbNcm!IVA / 100)) * (1 - (4 / 100)) / (1 - (TbIcms![Aliquota interna] / 100))) - 1) * 100
            Else ' Importado Dentro do Estado
               VrICMS = BC * (AliqICMS / 100)
               IVA = (((1 + (TbNcm!IVA / 100)) * (1 - (AliqICMS / 100)) / (1 - (TbIcms![Aliquota interna] / 100))) - 1) * 100
            End If   
            End If
            CalculaImposto = (BC) * ((IVA / 100) + 1)
            CalculaImposto = CalculaImposto * (TbIcms![Aliquota interna] / 100)
            CalculaImposto = Round(CalculaImposto - VrICMS, 2)
            Exit Function
         End If
         CalculaImposto = 0: Exit Function
      Case "13" '% ICMS ST
         If Not ConsumidorFinal And Substituicao Then 'Se for Revenda e Substituicao
            CalculaImposto = TbIcms![Aliquota interna]
            Exit Function
         End If
         CalculaImposto = 0: Exit Function
   End Select

End Function

'ROTINA PARA PEGAR A SEQUENCIA DA TABELA
'PQ O PEGASEQUENCIA DO GAS NW PRESTA
Public Function SuperPegaSequencial(Tabela As String, Campo As String, Optional Filtro As String) As Long
   Dim Sql As String, Tb As GRecordSet
   
   On Error Resume Next
   
   Sql = "SELECT MAX([" & Campo & "]) Seq " & _
         "FROM [" & Tabela & "] " & _
         "WHERE " & IIf(Not Vazio(Filtro), Filtro, "1 = 1")
         
   Set Tb = vgDb.OpenRecordSet(Sql)
         
   If Tb.RecordCount > 0 Then
      SuperPegaSequencial = Tb!Seq + 1
   Else
      SuperPegaSequencial = 1
   End If
   
End Function


'Função para Abreviar o textos
Public Function Abreviacao(ByVal Texto As String) As String
   Dim map(15, 2) As String, i As Long, x$
   
   On Error Resume Next
         
   x$ = Texto
   
   map(0, 0) = "Rua": map(0, 1) = "R"
   map(1, 0) = "Avenida": map(1, 1) = "Av"
   map(2, 0) = "Fazenda": map(2, 1) = "Faz"
   map(3, 0) = "Rodovia": map(3, 1) = "Rod"
   map(4, 0) = "Santa": map(4, 1) = "Sta"
   map(5, 0) = "Santo": map(5, 1) = "Sto"
   map(6, 0) = "Chacara": map(6, 1) = "Chac"
   map(7, 0) = "Alameda": map(7, 1) = "Al"
   map(8, 0) = "Colonia": map(8, 1) = "Colon"
   map(9, 0) = "Condominio": map(9, 1) = "Condo"
   map(10, 0) = "Estancia": map(10, 1) = "Estan"
   map(11, 0) = "Estrada": map(11, 1) = "Estr"
   map(12, 0) = "Prolongamento": map(12, 1) = "Prl"
   map(13, 0) = "Travessa": map(13, 1) = "Trav"
   map(14, 0) = "Vicinal": map(14, 1) = "Vic"
      
   For i = 0 To 14
      x$ = Replace(x$, map(i, 0), map(i, 1))
   Next
      
   'Fim
   Abreviacao = x$

End Function

' 1 CFOP - 2 % iCMS - 3 % ipi - 4 Vr Ipi - 5 Cst - 6 Bc - 7 Vr Icms - 8 Pis - 9 Cofins - 10 Iva - 11 Bc St - 12 Vr icms st - 13 % icms st
Public Function CalculaSimplesNacional(SeqItem As Long, SeqGeral As Long, Oq As Integer, VrTotal As Double, vrFrete As Double, VrDesc As Double, Optional NCM As Long) As Variant
   Dim TbProdutos As New GRecordSet, TbNcm As New GRecordSet, TbGeral As New GRecordSet, TbMunicipios As New GRecordSet, TbIcms As New GRecordSet
   Dim ConsumidorFinal As Boolean, Substituicao As Boolean, MatAdqTerc As Boolean, ForadoEstado As Boolean, ForadoPais As Boolean, Reducao As Boolean
   Dim Contribuinte As Boolean, BC As Double, AliqICMS As Double, IVA As Double, VrICMS As Double, UF As String, Isento As Boolean, Importado As Boolean, TemIPI As Boolean

   On Error Resume Next
   
   'Produtos
   Set TbProdutos = vgDb.OpenRecordSet("SELECT * FROM Produtos WHERE [Sequencia do produto] = " & SeqItem & " AND [Sequencia do Produto] > 0") 'Produtos
   Importado = TbProdutos!Importado
     
   If TbProdutos.RecordCount = 0 Then CalculaSimplesNacional = 0: Exit Function
      Set TbNcm = vgDb.OpenRecordSet("SELECT * FROM [Classificação fiscal] WHERE [Sequencia da classificação] = " & TbProdutos![Sequencia da classificação] & " AND [Sequencia da classificação] > 0") 'Classificação Fiscal (NCM)
   If TbNcm.RecordCount = 0 Then CalculaSimplesNacional = 0: Exit Function
   
   'DESTINATÁRIO
   Set TbGeral = vgDb.OpenRecordSet("SELECT * FROM Geral WHERE [Sequencia do Geral] = " & SeqGeral & " AND [Sequencia do Geral] > 0") 'Geral
   Set TbMunicipios = vgDb.OpenRecordSet("SELECT * FROM Municipios WHERE [Sequencia do Municipio] = " & TbGeral![Sequencia Do Municipio] & " AND [Sequencia do Municipio] > 0") 'Município (Geral)
   Set TbIcms = vgDb.OpenRecordSet("SELECT * FROM ICMS WHERE UF = '" & TbMunicipios!UF & "'")
   UF = TbMunicipios!UF
  
   'Opções
   MatAdqTerc = TbProdutos![Material Adquirido de Terceiro]
   ConsumidorFinal = TbGeral![Consumidor final]
   Substituicao = TbNcm!Iva > 0 'Item Faz Parte da Substituição?
   Isento = TbGeral!Isento 'Inscrição Isenta: Não Calcula ICMS
   ForadoEstado = UF <> "SP" 'É Fora do Estado
   ForadoPais = UF = "EX" 'É Fora do Pais (Exterior)
   TemIPI = TbNcm![Percentual de ipi] > 0
   
   If TbGeral!Tipo = 1 Then 'Pessoa Jurídica
      Contribuinte = (CBool(Not Vazio(TbGeral![RG e IE])))
   End If
      
   AliqICMS = TbIcms![Aliquota Do icms] 
  
   'Vamos Calcular Oque?
   Select Case Oq
      Case "1" 'CFOP (Apenas as Vendas. Devoluções, Remessas e etc... Será Avulsa(Usuário Digitará))
            If ForadoEstado And Substituicao And MatAdqTerc Then CalculaSimplesNacional = "6403": Exit Function 
            If Not ForadoEstado And Substituicao And MatAdqTerc Then CalculaSimplesNacional = "5403": Exit Function 
            If ForadoEstado And Substituicao And Not MatAdqTerc And Not ConsumidorFinal Then CalculaSimplesNacional = "6401": Exit Function 
            If Not ForadoEstado And Substituicao And Not MatAdqTerc And Not ConsumidorFinal Then CalculaSimplesNacional = "5401": Exit Function 
            If Not ForadoEstado And Not MatAdqTerc Then CalculaSimplesNacional = "5101": Exit Function 'Fabricação Propria Dentro do Estado
            If ForadoEstado And Not MatAdqTerc Then CalculaSimplesNacional = "6101": Exit Function 'Fabricação Propria Fora do Estado
            If Not ForadoEstado And MatAdqTerc Then CalculaSimplesNacional = "5102": Exit Function 'venda de Material adq. de terceiros
            If ForadoEstado And MatAdqTerc Then CalculaSimplesNacional = "6102": Exit Function 'venda de Material adq. de terceiros
      Case "2" '% ICMS
            CalculaSimplesNacional = 0: Exit Function    
      Case "3", "4" '% IPI, Vr IPI
         If Oq = 3 Then '%IPI
            CalculaSimplesNacional = 0
         Else 'Valor IPI
            CalculaSimplesNacional = 0
         End If
         Exit Function 
      Case "5" 'CST
         If TbGeral!Tipo = 0 Then CalculaSimplesNacional = "102": Exit Function ' Não Contribuinte pessoa fisica
         If Contribuinte And Not Substituicao Then CalculaSimplesNacional = "101": Exit Function
         If TbGeral!Isento Then CalculaSimplesNacional = "102": Exit Function
         If Not ConsumidorFinal And Substituicao And Contribuinte Then CalculaSimplesNacional = "203": Exit Function 'Substituição e Revenda
      Case "6" 'BC ICMS
         CalculaSimplesNacional = 0: Exit Function       
      Case "7" 'Valor do ICMS
         CalculaSimplesNacional = 0: Exit Function        
      Case "8" 'Valor do PIS
         CalculaSimplesNacional = 0
      Case "9" 'Valor do COFINS
         CalculaSimplesNacional = 0
      Case "10" 'IVA Ajustado
         If Not ConsumidorFinal And Substituicao Then
            'Formula: (((1 + (IVA Original / 100)) * (1 - (Porcentagem de ICMS / 100)) / (1 - (Alíquota InterEstadual / 100))) - 1) * 100 Esta linha ja estava comentada
            If Not Importado Then
               IVA = Round((((1 + (TbNcm!IVA / 100)) * (1 - (AliqICMS / 100)) / (1 - (TbIcms![Aliquota interna] / 100))) - 1) * 100, 2)
            Else 'Importado
            If ForadoEstado Then
               IVA = Round((((1 + (TbNcm!IVA / 100)) * (1 - (4 / 100)) / (1 - (TbIcms![Aliquota interna] / 100))) - 1) * 100, 2)
            Else ' Dentro do Estado
               IVA = Round((((1 + (TbNcm!IVA / 100)) * (1 - (AliqICMS / 100)) / (1 - (TbIcms![Aliquota interna] / 100))) - 1) * 100, 2)
            End If   
            End If
            CalculaSimplesNacional = IVA
            Exit Function
         Else
            CalculaSimplesNacional = 0: Exit Function
         End If
     Case "11" 'BC ICMS ST
         If Not ConsumidorFinal And Substituicao Then 'Se for Revenda e Substituicao
            BC = 0
            BC = Round(BC + VrTotal - VrDesc, 2)
            BC = Round(BC + VrFrete, 2)
            
            If Not Importado Then
               IVA = Round((((1 + (TbNcm!IVA / 100)) * (1 - (AliqICMS / 100)) / (1 - (TbIcms![Aliquota interna] / 100))) - 1) * 100, 2)
            Else ' Importado
            If ForadoEstado Then
               IVA = (((1 + (TbNcm!IVA / 100)) * (1 - (4 / 100)) / (1 - (TbIcms![Aliquota interna] / 100))) - 1) * 100
            Else
               IVA = (((1 + (TbNcm!IVA / 100)) * (1 - (AliqICMS / 100)) / (1 - (TbIcms![Aliquota interna] / 100))) - 1) * 100 
            End If   
            End If
            CalculaSimplesNacional = Round((BC) * ((IVA / 100) + 1), 2)
            Exit Function
         End If
         CalculaSimplesNacional = 0: Exit Function
      Case "12" 'Valor do ICMS ST
         If Not ConsumidorFinal And Substituicao Then 'Se for Revenda e Substituicao
            BC = 0
            BC = Round(BC + VrTotal - VrDesc, 2)
            BC = Round(BC + VrFrete, 2)
            
            If Not Importado Then
               VrICMS = Round(BC * (AliqICMS / 100), 2) 
               IVA = Round((((1 + (TbNcm!IVA / 100)) * (1 - (AliqICMS / 100)) / (1 - (TbIcms![Aliquota interna] / 100))) - 1) * 100, 2) 
            Else 'Importado
            If ForadoEstado Then
               VrICMS = BC * (4 / 100)
               IVA = (((1 + (TbNcm!IVA / 100)) * (1 - (4 / 100)) / (1 - (TbIcms![Aliquota interna] / 100))) - 1) * 100
            Else ' Importado Dentro do Estado
               VrICMS = BC * (AliqICMS / 100)
               IVA = (((1 + (TbNcm!IVA / 100)) * (1 - (AliqICMS / 100)) / (1 - (TbIcms![Aliquota interna] / 100))) - 1) * 100
            End If   
            End If
            CalculaSimplesNacional = (BC) * ((IVA / 100) + 1)
            CalculaSimplesNacional = CalculaSimplesNacional * (TbIcms![Aliquota interna] / 100)
            CalculaSimplesNacional = Round(CalculaSimplesNacional - VrICMS, 2)
            Exit Function
         End If
         CalculaSimplesNacional = 0: Exit Function
      Case "13" '% ICMS ST
         If Not ConsumidorFinal And Substituicao Then 'Se for Revenda e Substituicao
            CalculaSimplesNacional = TbIcms![Aliquota interna]
            Exit Function
         End If
         CalculaSimplesNacional = 0: Exit Function
   End Select

End Function

'abre banco de dados
Public Function AbreBancoDeDados(Optional ByVal vgIgnoraErros As Long = 0) As Integer
   Dim vgPV As Boolean, vgCriaDb As Boolean,i As Integer, vgCp As Object
   On Error GoTo DeuErro
   AbreBancoDeDados = False
   vgDB.Clear
   vgCriaDb = False
   vgPV = True
   vgDB.RegisterDatabase vgAliasDb(1)             'registra o banco de dados para o aplicativo
   vgDB(1).DataBaseType = vgTipoDb(1)
   vgDb(1).TrustedConnection = vgTrustConnDb(1)
   vgDB(1).Username = vgUsuarioID$(1)
   vgDB(1).Password = vgSenhaDb$(1)
   vgDB(1).Provider = vgProviderDb$(1)
   vgDB(1).Driver = vgDriverDb$(1)
   vgDB(1).Server = vgServerDb$(1)
   vgDB(1).DatabaseName = vgNomeDb$(1)
   vgDB(1).DataBaseDir = vgDirDb$(1)
   vgDB(1).StringConnection = vgStrConnectionDb$(1)
   vgDB(1).OpenConnection vgCriaDb

   'Empresa
   Set Empresa = vgDb.OpenRecordSet("Empresa")
   With Empresa
      If .RecordCount = 0 Then
         .AddNew
         For i = 0 to .Fields.Count - 1
            If .Fields(i).Type <> adLongVarBinary Then
             .Fields(i) = .Fields(i)
            End If
         Next
         .Update
         .MoveFirst
      End If
   End With
   'Parametros da nfe
   Set Parametros_da_nfe = vgDb.OpenRecordSet("Parametros da nfe")
   With Parametros_da_nfe
      If .RecordCount = 0 Then
         .AddNew
         For i = 0 to .Fields.Count - 1
            If .Fields(i).Type <> adLongVarBinary Then
             .Fields(i) = .Fields(i)
            End If
         Next
         .Fields("Codigo da uf") = 35
         .Update
         .MoveFirst
      End If
   End With

   'abre tabelas de segurança do sistema (grupo, usuários e permissões)
   vgRsPwGrupos.Source = "PW~Grupos"
   vgRsPwUsuarios.Source = "PW~Usuarios"
   vgRsPwTabelas.Source = "PW~Tabelas"

   AbreBancoDeDados = True                        'tudo certo!
   Exit Function

DeuErro:
   If Err.Number = 65500 And vgPV Then
      If MsgBox(LoadGasStringParam(1083, vgAliasDb(1)), vbQuestion + vbYesNo, vgAtencao) = vbYes Then
         vgCriaDb = True
         vgPV = False
      Else
         vgPV = False
         vgCriaDb = False
      End If
      Resume
   End If
   If vgIgnoraErros = 0 Then
      CErr.NumErro = Err                          'opa! um erro aconteceu...
      CErr.Show
   End If
End Function

'fecha o banco de dados
Public Sub FechaBancoDeDados()
   On Error Resume Next

   'fecha arquivos de perametros
   Empresa.CloseRecordSet
   Set Empresa = Nothing
   Parametros_da_nfe.CloseRecordSet
   Set Parametros_da_nfe = Nothing

   'fecha arquivos de controle de senhas
   vgRsPwGrupos.CloseRecordset                    'fecha tabela de grupos,
   vgRsPwUsuarios.CloseRecordset                  'usuários e
   vgRsPwTabelas.CloseRecordset                   'permissões
   Set vgRsPwGrupos = Nothing                     'libera os objetos
   Set vgRsPwUsuarios = Nothing                   'da memória
   Set vgRsPwTabelas = Nothing
   vgDb.Clear                                     'finaliza todas as conexões abertas
End Sub

'mostra form principal
Private Sub MostraMainForm()
   With mdiNFE                                    'com o form principal MDI
      .timRefresh.Enabled = True                  'habilita o timer de refresh de tabelas
      .Menu_Barra.Checked = vgBarraFerr           'com o que leu no INI, marca a opção da barra de ferramentas,
      .panTools.Visible = vgBarraFerr             'ajusta a sua visi,
      .Menu_Ajuda.Checked = vgAjudaAtiva          'marca/desmarca a opção de ajuda,
      .Show                                       'e mostra o form principal
   End With
   Screen.MousePointer = vbDefault                'restaura e ponteiro do mouse
End Sub

'pega senha para acesso ao sistema
Public Sub PegaLogin(vgOque As Integer)
   If vgOQue <> PEGA_SENHA_INICIAL Then
      vgPWUsuario$ = ""                           'zera variáveis públicas...
      vgPWGrupo$ = ""
      vgPWSenha$ = ""
      vgPWObs$ = ""
   End If
   mdiNFE.timRefresh.Enabled = False              'desliga remontagem do BD
   mdiNFE.Visible = False                         'esconde form principal
   Load frmControle                               'carrega form de controle na memória
   With frmControle                               'vamos trabalhar no form de controle...
      .Iniciaform vgOque                          'diz ao form o que queremos
   End With
   UnLoad frmControle                             'vamos forçar a descarregar sempre
   Set frmControle = Nothing           

   'se usuário ok, habilita temporizador para apresentar o form principal
   If vgPWUsuario$ <> "" Then                     'digitou a senha
      MostraMainForm                              'mostra form principal
   End If
End Sub

'Faz verificação de permissões para menus
Public Sub VerificaMenus()
   Dim vgOk As Integer, x As String, i As Long, p As Long, vgPerms As String, vgRsTemp As GRecordset
   vgOk = True                                       'variável de retorno
   On Error Resume Next
   vgPerms = "|"
   If vgPWGrupo <> UCase$(LoadGasString(11166)) Then
      Set vgRsTemp = vgDb.OpenRecordSet("SELECT * FROM [PW~Tabelas] WHERE [PW~Tabelas].[PW~Grupo] = '" + Encripta$(vgPWGrupo$) + "'")
      Do While Not vgRsTemp.EOF
         vgPerms = vgPerms + Mid(Decripta(vgRsTemp![PW~Nome]), 3) + Chr(1) + Mid(Decripta(vgRsTemp![PW~Permissoes]), 1, 1) + "|"
         vgRsTemp.MoveNext
      Loop
   End If
   For i = 0 To mdiNFE.Controls.Count - 1            'corre todos os controles
      If TypeOf mdiNFE.Controls(i) Is Menu Then      'menus para ver
         If Val(mdiNFE.Controls(i).Tag) > 0 Then     'se tem permissão
            x = "|" + Parse(CStr(mdiNFE.Controls(i).Tag), "|") + Chr(1)
            p = InStr(vgPerms, x)
            If p = 0 Or vgPWGrupo = UCase$(LoadGasString(11166)) Then 'nao tem registro para controle de permissão para esse menu, vamos criar...
               vgOk = True
            Else
               vgOk = (Val(Mid(vgPerms, p + Len(x), 1)) <> 0)     
            End If
            mdiNFE.Controls(i).Visible = vgOk
         End If
      End If
   Next

   'se não tem permissão para visualizar a tabela nega opções de menu e botões...
   On Error Resume Next
   With mdiNFE
               .Menu_642(0).Visible = (Permitido("Emitentes mdfe", ACAO_NAVEGANDO) And PermitidoMenu(.Menu_642(0).Tag))
               .Menu_614(0).Visible = (Permitido("Empresa", ACAO_NAVEGANDO) And PermitidoMenu(.Menu_614(0).Tag))
               .Menu_639(0).Visible = (Permitido("Manifesto", ACAO_NAVEGANDO) And PermitidoMenu(.Menu_639(0).Tag))
               .Menu_642(2).Visible = (Permitido("Motoristas", ACAO_NAVEGANDO) And PermitidoMenu(.Menu_642(2).Tag))
               .Menu_642(1).Visible = (Permitido("Municipios", ACAO_NAVEGANDO) And PermitidoMenu(.Menu_642(1).Tag))
               .Menu_614(1).Visible = (Permitido("Parametros da nfe", ACAO_NAVEGANDO) And PermitidoMenu(.Menu_614(1).Tag))
   End With

   'Vamos fechar e destruir o objeto
   vgRsTemp.CloseRecordset
   Set vgRsTemp = Nothing
End Sub

'Retorna True ou False se o usuário pode executar uma determinada ação em uma tabela da aplicação
Public Function Permitido(ByVal vgNomeTab As String, ByVal vgAcao As Integer) As Integer
   Dim vgOk As Integer, x As String
   If InStr(vgNomeTab$, "~") > 0 Then             'tira tabelas de segurana e invisveis
      Permitido = False                           'não permitido
      Exit Function
   ElseIf vgPWGrupo = UCase$(LoadGasString(11166)) Then
      Permitido = True                            'permitido Para administradores
      Exit Function
   End If
   vgOk = True                                    'variável de retorno

   x$ = Encripta$(UCase$(vgNomeTab$))             'nome da tabela encriptada
   If vgRsPwTabelas.PTab("Chave tabelas", " ", Encripta$(vgPWGrupo$), x$) Then 'se achou...
      x$ = Decripta$(vgRsPwTabelas![PW~Permissoes])                            'permissões: 01001
      If vgAcao > 0 Then
         vgOk = Val(Mid$(x$, vgAcao, 1)) <> 0                                  'se posição da ação é 0 não tem permissão
      Else
         vgOk = 0
         vgOk = vgOk + Val(Mid$(x$, 1, 1)) * 2^ 1 + Val(Mid$(x$, 2, 1)) * 2^ 2
         vgOk = vgOk + Val(Mid$(x$, 3, 1)) * 2^ 3 + Val(Mid$(x$, 4, 1)) * 2^ 4
      End If
   End If
   Permitido = vgOk                               'retorna o que achou
End Function

'Retorna True ou False se o usuário tem pode visualizar a opção do menu
Public Function PermitidoMenu(ByVal vgTagMenu As String) As Integer
   Dim vgOk As Integer, x As String
   vgOk = True                                    'variável de retorno

   'vamos permitir para administradores
   If vgPWGrupo = UCase$(LoadGasString(11166)) Then
      PermitidoMenu = True
      Exit Function
   End If

   x$ = Encripta$("M." + Parse((vgTagMenu$), "|" )) 'identificacao do menu
   If vgRsPwTabelas.PTab("Chave tabelas", vgIDSistema$, Encripta$(vgPWGrupo$), x$) Then 'se achou...
      x$ = Decripta$(vgRsPwTabelas![PW~Permissoes])                                     'permissões: 01001
      vgOk = Val(Mid$(x$, 1, 1)) <> 0             'se posição é 0 não tem permissão
   End If
   PermitidoMenu = vgOk                           'retorna o que achou
End Function

'mostra o menu popup nos grids dos forms de dados/consultas
Public Sub MostraPopGrid(F As Form, vgBotao As Integer)
   Dim vgQColSel As Integer, i As Integer, _
       vgQColVis As Integer                       'dimensiona
   If vgBotao = vbRightButton Then                'botão direito?
      If F.Name = mdiNFE.ActiveForm.Name Then     'Se esta em cima do form ativo?
         With F.grdBrowse                         'vamos agir no grid...
            If .SelStartCol > -1 Then             'se tem seleção
               vgQColSel = .SelEndCol + 1 - .SelStartCol 'pega quantas...
            Else
               vgQColSel = 0                             'nenhuma selecionada
            End If
            vgQColVis = 0                                'quantas colunas invisíveis?
            For i = 0 To .Cols - 1                       'verifica cada coluna e
               vgQColVis = vgQColVis - (.Columns(i).Visible) 'acumula quantas estão invisíveis
            Next
         End With
         With mdiNFE                                         'agora no form principal
            .Menu_Grd_ApgCol.Enabled = (vgQColSel > 0)       'habilita apagar, se alguma selecionada
            .Menu_Grd_Procura.Enabled = (F.vgTipo = TP_TABELA And F.vgTb.RecordCount > 0)
            .Menu_Grd_Constroi.Enabled = (F.grdBrowse.Columns.Count <> vgQColVis) 'habilita se nenhuma coluna oculta
            mdiNFE.PopupMenu .Menu_PropGrade, vbPopupMenuLeftAlign                'apresenta o popup na posição do mouse
         End With
      End If
   End If
End Sub

'ajusta valor do scroll do filtro com a posição dentro da tabela (PercentPosition)
Public Sub AjustaRolagem(F As Form)
   Dim i As Integer
   vgNaoAtRolagem = True                          'para não disparar o scrRolaDados_change
   On Error Resume Next                           'previne erro divisão por zero
   With F.vgTb
      If .EOF Then
         i = 101
      ElseIf .BOF Then
         i = -1
      Else
         i = Int(100 * (.AbsolutePosition - 1) / (.RecordCount - 1))
      End If
      If i > 100 Then                             'se posicao calculada maior que 100
         i = 100                                  'vira 100
      ElseIf i < 0 Then                           'se menor que zero
         i = 0                                    'vira zero
      End If
      mdiNFE.schNavega.Value = i                  'ajusta scroll do filtro com valor calculado
   End With
   vgNaoAtRolagem = False                         'agora pode executar o "change"
End Sub

'espera alguns segundos
Public Sub Delay(vgTempo As Single)
   Dim vgAgora As Double
   vgAgora# = Timer                               'numero de segundo a contar de 0 hora
   Do While (Timer - vgAgora#) < vgTempo!         'fica aqui o tempo necessário
      DoEvents                                    'as outras aplicações trabalharem
      If Timer < vgTempo! Then Exit Do            'previne mudança zero hora
   Loop
End Sub

'poe o foco no primeiro campo habilitado
Public Sub FocoNoPriControle(F As Form)
   Dim vgCt1 As Control, vgCt2 As Control, i As Integer  'dimensiona objetos
   i = 999
   On Error Resume Next                                  'prepara para um erro
   For Each vgCt1 In F.Controls                          'para cada campo no form
      If Not TypeOf vgCt1 Is GListV Then                 'se não for um grid
         If vgCt1.Enabled And vgCt1.TabStop And vgCt1.Visible And _
            (vgCt1.TabIndex < i) Then                    'esta habilitado? pode ter foco? pode ser o 1o.?
            If Err = 0 Then                              'se deu tudo certo
               Set vgCt2 = vgCt1                         'esse controle pode ser o 1o.
               i = vgCt2.TabIndex                        'marca o que achamos
            Else
               Err = 0                                   'reseta possível erro
            End If
         End If
      End If
   Next                                                  'próximo controle
   If i <> 999 Then                                      'se encontrou o 10. controle
      mdiNFE.picAux.Move - 6000, - 6000
      mdiNFE.picAux.Visible = True
      mdiNFE.picAux.SetFocus
      mdiNFE.picAux.Visible = False
      vgCt2.SetFocus                                     'coloca foco nele
      Set vgCt2 = Nothing                                'libera memória da variável
   End If
   Set vgCt1 = Nothing                                   'libera memória da variável
End Sub

'verifica se a mascara da data tem "99" e substitui pelo correto (dd/mm/yy)
Public Function TrataMaskData(St As String) As String
   Dim k As String, RetVal As String, Dt As Date, i As Integer
   RetVal$ = St$
   If InStr(RetVal$, "9") > 0 Then                'se a data for 99/99/999 vamos substituir por dd/mm/yy
      If InStr(RetVal$, ":") > 0 Then
         k$ = "hms"
      Else
         Dt = Format$("25/12/98", "Short date")
         k$ = CStr(Dt)
         If Left$(k$, 2) = "25" Then k$ = "dmy" Else k$ = "mdy"
      End If
      For i = 1 To Len(RetVal$)
         If Mid$(RetVal$, i, 1) = "9" Then
            Mid$(RetVal$, i, 1) = Left$(k$, 1)
         Else
            k$ = Mid$(k$, 2)
         End If
      Next
   ElseIf Len(RetVal$) = 0 Then
      RetVal$ = "dd/mm/yy"                        ' mascara default
   End If
   TrataMaskData = RetVal$
End Function

'retorna a qtde de forms de dados na tela
Public Function QtForms() As Integer
   Dim i As Integer, RetVal As Integer, Ok As Boolean
   On Error Resume Next                           'previne qualqer erro
   RetVal = 0                                     'qtde a retornar
   For i = 1 To Forms.Count - 1                   'corre todos os forms execto o MDI

      'soma se não for um form auxiliar (help, calculadora ou calendario)
      Ok = (Forms(i).vgTipo <> TP_RELAT And Forms(i).vgTipo <> TP_CALC And Forms(i).vgTipo <> TP_CALE)
      If Forms(i).vgTipo = TP_BROWSE Then         'se é browse e é pesquisa, não conta formulário
         If Not Forms(i).CtTransfer Is Nothing Then Ok = False
      End If
      If Not Err Then                             'se tudo ok
         If Ok Then RetVal = RetVal + 1           'soma mais um...
      Else
         Err.Clear                                'limpa o erro atual
      End If
   Next
   QtForms = RetVal                               'retorna a qtde de forms abertos
End Function

'trata a movimentação de registros nas tabelas
Public Sub MoveRegistro(F As Form, vgParaOnde As Integer)
   Screen.MousePointer = vbHourglass              'mouse = ampulheta
   vgBotoesOK = False                             'reseta flag
   On Error Resume Next
   If vgParaOnde = REG_FORCAVOLTA Then
      If F.vgEmBrowse Then
         F.grdBrowse.SelectPreviousItem
      Else
         F.vgTb.MovePrevious
      End If
   End If
   If Err Then vgParaOnde = REG_PRIMEIRO          'se deu erro vai p/ 1o. reg
   Select Case vgParaOnde                         'verifica para onde movimentar
      Case REG_PRIMEIRO                           'primeiro
         If F.vgEmBrowse Then
            F.grdBrowse.SelectFirstItem
         Else
            F.vgTb.MoveFirst                      'então vamos...
         End If
      Case REG_ANTERIOR                           'anterior
         If F.vgEmBrowse Then
            F.grdBrowse.SelectPreviousItem
         Else
            F.vgTb.MovePrevious                   'move
         End If
      Case REG_SEGUINTE                           'seguinte
         If F.vgEmBrowse Then
            F.grdBrowse.SelectNextItem
         Else
            F.vgTb.MoveNext                       'move
         End If
      Case REG_ULTIMO                             'último registro
         If F.vgEmBrowse Then
            F.grdBrowse.SelectLastItem
         Else
            F.vgTb.MoveLast                       'move
         End If
   End Select
   If F.vgTb.EOF Then                             'se final do arquivo,
      If F.vgEmBrowse Then
         F.grdBrowse.SelectLastItem
      Else
         F.vgTb.MoveLast                          'volta um
      End If
   ElseIf F.vgTb.BOF Then                         'senão, se início do arquivo,
      If F.vgEmBrowse Then
         F.grdBrowse.SelectFirstItem
      Else
         F.vgTb.MoveFirst
      End If
   End If
   F.Reposition True
   AjustaRolagem F
   vgBotoesOK = True                              'reajusta a flag e
   Screen.MousePointer = vbDefault                'o ponteiro do mouse...
End Sub

'mostra o tópico de ajuda requerido
Public Sub AtivaHelp()
   Dim vgNomeHTML As String
   vgNomeHTML$ = "NFE.chm"
   If Existe(vgDirEXE + "Help\" + vgNomeHTML$) Then
      AbreComando vgDirEXE + "Help\" + vgNomeHTML$
   Else
      AbreComando vgDirEXE + vgNomeHTML$
   End If
End Sub

'ajusta tamanho do formulário de acordo com o painel do fundo
Public Sub AjustaTamanho(F As Form)
   Dim Ok As Boolean
   Ok = (F.hWnd = mdiNFE.hWnd)
   If Not Ok Then
         Ok = (F.BorderStyle <> 0)
   End If
   If Ok And F.WindowState <> vbMinimized And F.vgTipo <> TP_BROWSE Then  'se não está minimizado e não é consulta
      F.Move F.Left, F.Top, F.Painel(0).Width + 200, F.Painel(0).Height + 470
   End If
   LeParametrosForm F                             'le os parametros gravados no .INI
End Sub

'grava dentro do arquivo .INI parametros relativo ao formulário
Public Sub GravaParametrosForm(F As Form)
   Dim i As Integer, j As Integer, x As String, k As String
   Dim vgBrowseID As String
   x$ = vgNomeEstacao$ + F.Name + " - "           'nome do form (grupo)
   i = InStr(F.Caption, Chr(160))
   If i > 0 Then
      x$ = x$ + Left(F.Caption, i - 1)            'nome do form (grupo)
   Else
      x$ = x$ + F.Caption
   End If
   vgBrowseID$ = x$
   If F.vgTipo = TP_BROWSE Then
      vgBrowseID$ = vgBrowseID$ + F.vgTitConsulta + str$(F.vgFromFormID)
   End If
   If F.WindowState = vbNormal Then               'gravar só em estado normal
      GravaNoIni x$, "Left", CStr(F.Left), vgNomeINI$ 'coordenada do form, esquerda
      GravaNoIni x$, "Top", CStr(F.Top), vgNomeINI$   'direita,
      GravaNoIni x$, "Width", CStr(F.Width), vgNomeINI$ 'largura e
      GravaNoIni x$, "Height", CStr(F.Height), vgNomeINI$ 'altura
   End If
   If F.vgCaracteristica = F_GRAFICO Then                 'se for form de GRÁFICO
      With F.gra1
         GravaNoIni x$, "GraphType", CStr(.GraphType), vgNomeINI$ 'tipo do gráfico
         GravaNoIni x$, "NumSets", CStr(.NumSets), vgNomeINI$     'qde de conjunto de dados
         GravaNoIni x$, "NumPoints", CStr(.NumPoints), vgNomeINI$ 'qde de itens por conjunto
         GravaNoIni x$, "GraphStyle", CStr(.GraphStyle), vgNomeINI$ 'estilo
         GravaNoIni x$, "GridStyle", CStr(.GridStyle), vgNomeINI$   'estilo da grade
         GravaNoIni x$, "ThickLines", CStr(.ThickLines), vgNomeINI$ 'marca valores
         GravaNoIni x$, "GraphTitle", .GraphTitle, vgNomeINI$       'título superior
         GravaNoIni x$, "LeftTitle", .LeftTitle, vgNomeINI$         'título da esquerda
         GravaNoIni x$, "BottomTitle", .BottomTitle, vgNomeINI$     'título do fundo
         GravaNoIni x$, "Labels", CStr(.Labels), vgNomeINI$         'com legendas?
         For j = 1 To .NumPoints                                    'e outros dados
            GravaNoIni x$, "ExtraData", CStr(.ExtraData), vgNomeINI$ 'importantes
         Next
      End With
   ElseIf F.vgCaracteristica <> F_COMUM Then
      GravaNoIni x$, "Ultimo filtro", F.vgUltimoFiltro, vgNomeINI$   'salva ultimo filtro
      If Len(F.vgUltimoFiltro) > 0 Then k$=F.vgUltimoFiltroComTit Else k$=""
      GravaNoIni x$, "Ultimo filtro Com Titulo", k$, vgNomeINI$
      GravaNoIni x$, "Ultima ordem", F.vgUltimaOrdem, vgNomeINI$     'salva ultima ordem
      If Len(F.vgUltimaOrdem) > 0 Then k$ = F.vgUltimaOrdemComTit Else k$=""
      GravaNoIni x$, "Ultima ordem Com Titulo", k$, vgNomeINI$
      GravaNoIni x$, "Em browse", CStr(F.vgEmBrowse), vgNomeINI$     'está no grid?
      GravaNoIni x$, "Coord ant", F.Tag, vgNomeINI$                  'coordenadas ateriores

      'grava altura da linha
      On Error Resume Next                                           'previne erros
      If F.vgTipo = TP_BROWSE Or (F.vgTipo = TP_TABELA) Then
         If F.vgTemBrowse Then
            k$ = Str$(F.grdBrowse.RowHeight)                         'altura da linha do grid da tabela
            If Err Then                                              'se deu erro nao existe grid
               Err.Clear                                             'reseta o erro
            Else
               GravaNoIni vgBrowseID$, "Alt grdBrowse", k$, vgNomeINI$ 'grava no ini a altura do grid
               
               'grava no ini flags de popup para gravações de layout do grid
               GravaNoIni vgBrowseID$, "Save Bars", CStr(F.grdBrowse.SaveGridBars), vgNomeINI$
               GravaNoIni vgBrowseID$, "Save Cols", CStr(F.grdBrowse.SaveGridCols), vgNomeINI$
               GravaNoIni vgBrowseID$, "Save Stripes", CStr(F.grdBrowse.SaveGridStripes), vgNomeINI$

               'salva situação atual das barras do grid
               If F.grdBrowse.SaveGridBars Then
                  GravaNoIni vgBrowseID$, "Show filter bar grdBrowse", CStr(F.grdBrowse.ShowFilterBar), vgNomeINI$
                  GravaNoIni vgBrowseID$, "Show status bar grdBrowse", CStr(Not F.grdBrowse.HideStatus), vgNomeINI$
                  GravaNoIni vgBrowseID$, "Show left bar grdBrowse", CStr(Not F.grdBrowse.HideLeftBar), vgNomeINI$
                  GravaNoIni vgBrowseID$, "Show sum bar grdBrowse", CStr(F.grdBrowse.ShowSumBar), vgNomeINI$
                  GravaNoIni vgBrowseID$, "Show min bar grdBrowse", CStr(F.grdBrowse.ShowMinBar), vgNomeINI$
                  GravaNoIni vgBrowseID$, "Show max bar grdBrowse", CStr(F.grdBrowse.ShowMaxBar), vgNomeINI$
                  GravaNoIni vgBrowseID$, "Show avg bar grdBrowse", CStr(F.grdBrowse.ShowAvgBar), vgNomeINI$
               End If
               
               'grava no ini a largura das colunas do grid
               If F.grdBrowse.SaveGridCols Then
                  For j = 1 To F.grdBrowse.Columns.Count
                     GravaNoIni vgBrowseID$, "Larg grdBrowse" + str$(j), CStr(F.grdBrowse.ColumnWidth(j)), vgNomeINI$
                     GravaNoIni vgBrowseID$, "SumCol grdBrowse" + str$(j), CStr(F.grdBrowse.ShowSumCol(j)), vgNomeINI$
                     GravaNoIni vgBrowseID$, "AvgCol grdBrowse" + str$(j), CStr(F.grdBrowse.ShowAvgCol(j)), vgNomeINI$
                     GravaNoIni vgBrowseID$, "MaxCol grdBrowse" + str$(j), CStr(F.grdBrowse.ShowMaxCol(j)), vgNomeINI$
                     GravaNoIni vgBrowseID$, "MinCol grdBrowse" + str$(j), CStr(F.grdBrowse.ShowMinCol(j)), vgNomeINI$ 
                  Next
               End If

               'grava no ini a situação do zebrado
               If F.grdBrowse.SaveGridStripes Then
                  GravaNoIni vgBrowseID$, "Stripes grdBrowse", CStr(F.grdBrowse.Stripes), vgNomeINI$
               End If
            End If
         End If
      End If
      If F.vgTipo = TP_TABELA Or F.vgTipo = TP_PARAMETROS Then
         Err.Clear
         j = F.Grid(0).Index                                           'tem grid (filho) na janela
         If Err Then
            Err.Clear                                                  'não tem cancela o erro
         Else
            For j = 0 To F.Grid.Count - 1                              'grava altura de todos os grids filhos
               GravaNoIni x$, "Alt grd" + str$(j), CStr(F.Grid(j).RowHeight), vgNomeINI$
               
               'grava no ini flags de popup para gravações de layout do grid
               GravaNoIni x$, "Save Bars" + str$(j), CStr(F.Grid(j).SaveGridBars), vgNomeINI$
               GravaNoIni x$, "Save Cols" + str$(j), CStr(F.Grid(j).SaveGridCols), vgNomeINI$
               GravaNoIni x$, "Save Stripes" + str$(j), CStr(F.Grid(j).SaveGridStripes), vgNomeINI$

               'salva situação atual das barras do grid
               If F.Grid(j).SaveGridBars Then
                  GravaNoIni x$, "Show filter bar grd" + Str$(j), CStr(F.Grid(j).ShowFilterBar), vgNomeINI$
                  GravaNoIni x$, "Show status bar grd" + Str$(j), CStr(Not F.Grid(j).HideStatus), vgNomeINI$
                  GravaNoIni x$, "Show left bar grd" + Str$(j), CStr(Not F.Grid(j).HideLeftBar), vgNomeINI$
                  GravaNoIni x$, "Show sum bar grd" + Str$(j), CStr(F.Grid(j).ShowSumBar), vgNomeINI$
                  GravaNoIni x$, "Show min bar grd" + Str$(j), CStr(F.Grid(j).ShowMinBar), vgNomeINI$
                  GravaNoIni x$, "Show max bar grd" + Str$(j), CStr(F.Grid(j).ShowMaxBar), vgNomeINI$
                  GravaNoIni x$, "Show avg bar grd" + Str$(j), CStr(F.Grid(j).ShowAvgBar), vgNomeINI$
               End If

               'grava no ini a largura das colunas do grid
               If F.Grid(j).SaveGridCols Then                          'tag do grid = 1, significa que quer gravar
                  For i = 1 To F.Grid(j).Columns.Count
                     GravaNoIni x$, "Larg grd" + str$(j) + str$(i), CStr(F.Grid(j).ColumnWidth(i)), vgNomeINI$
                     GravaNoIni x$, "SumCol grd" + str$(j) + str$(i), CStr(F.Grid(j).ShowSumCol(i)), vgNomeINI$
                     GravaNoIni x$, "AvgCol grd" + str$(j) + str$(i), CStr(F.Grid(j).ShowAvgCol(i)), vgNomeINI$
                     GravaNoIni x$, "MaxCol grd" + str$(j) + str$(i), CStr(F.Grid(j).ShowMaxCol(i)), vgNomeINI$
                     GravaNoIni x$, "MinCol grd" + str$(j) + str$(i), CStr(F.Grid(j).ShowMinCol(i)), vgNomeINI$
                  Next
               End If
   
               'grava o zebrado do grid
               If F.Grid(j).SaveGridStripes Then
                  GravaNoIni x$, "Stripes grd" + Str$(j), CStr(F.Grid(j).Stripes), vgNomeINI$
               End If
            Next
         End If
      End If
   ElseIf F.vgTipo = TP_RELAT Then                                     'form de relatorio
      GravaNoIni x$, "Ultimo filtro", F.vgUltimoFiltro, vgNomeINI$     'salva ultimo filtro
      If Len(F.vgUltimoFiltro) > 0 Then k$=F.vgUltimoFiltroComTit Else k$=""
      GravaNoIni x$, "Ultimo filtro Com Titulo", k$, vgNomeINI$
      GravaNoIni x$, "Ultima ordem", F.vgUltimaOrdem, vgNomeINI$       'salva ultima ordem
      If Len(F.vgUltimaOrdem) > 0 Then k$ = F.vgUltimaOrdemComTit Else k$=""
      GravaNoIni x$, "Ultima ordem Com Titulo", k$, vgNomeINI$
   End If
End Sub

'le parâmetro do .INI para o formulário
Public Sub LeParametrosForm(F As Form)
   Dim x As String, k As String, i As Integer, j As Integer, Ok As Boolean
   Dim vgBrowseID As String
   Ok = (F.hWnd = mdiNFE.hWnd)
   If Not Ok Then
         Ok = (F.BorderStyle <> 0)
   End If
   x$ = vgNomeEstacao$ + F.Name + " - "           'nome do form (grupo)
   i = InStr(F.Caption, Chr(160))
   If i > 0 Then
      x$ = x$ + Left(F.Caption, i - 1)            'nome do form (grupo)
   Else
      x$ = x$ + F.Caption
   End If
   vgBrowseID$ = x$
   If F.vgTipo = TP_BROWSE Then
      vgBrowseID$ = vgBrowseID$ + F.vgTitConsulta + str$(F.vgFromFormID)
   End If
   F.Left = PegaIntDoIni(x$, "Left", F.Left, vgNomeINI$) 'posição do form
   F.Top = PegaIntDoIni(x$, "Top", F.Top, vgNomeINI$)
   If Ok Then
      F.Width = PegaIntDoIni(x$, "Width", F.Width, vgNomeINI$)
      F.Height = PegaIntDoIni(x$, "Height", F.Height, vgNomeINI$)
   End If
   If F.vgCaracteristica = F_GRAFICO Then                'GRÁFICO
      With F.gra1
         .GraphType = PegaIntDoIni(x$, "GraphType", .GraphType, vgNomeINI$) 'tipo
         .NumSets = PegaIntDoIni(x$, "NumSets", .NumSets, vgNomeINI$)       'qde de conjunto de dados
         .NumPoints = PegaIntDoIni(x$, "NumPoints", .NumPoints, vgNomeINI$) 'qde itens por conjunto
         .GraphStyle = PegaIntDoIni(x$, "GraphStyle", .GraphStyle, vgNomeINI$) 'estilo
         .GridStyle = PegaIntDoIni(x$, "GridStyle", .GridStyle, vgNomeINI$)    'estilo da grade
         .ThickLines = PegaIntDoIni(x$, "ThickLines", .ThickLines, vgNomeINI$) 'marca valores
         .Labels = PegaIntDoIni(x$, "Labels", .Labels, vgNomeINI$)             'com legendas?

         .GraphTitle = PegaStrDoIni(x$, "GraphTitle", vgNomeINI$)              'título superior
         .LeftTitle = PegaStrDoIni(x$, "LeftTitle", vgNomeINI$)                'título esquedo
         .BottomTitle = PegaStrDoIni(x$, "BottomTitle", vgNomeINI$)            'título do fundo
         .DataReset = 3                           'reseta datos extras
         If .GraphType < 3 Then                   'se for pizza 3d/3d
            For i = 1 To .NumPoints               'grava os dados adicionais
               .ExtraData = PegaIntDoIni(x$, "ExtraData", .ExtraData, vgNomeINI$)
            Next
         End If
      End With
   ElseIf F.vgCaracteristica <> F_COMUM Then      'form de DADOS
      F.vgUltimoFiltro = PegaStrDoIni(x$, "Ultimo filtro", vgNomeINI$) 'ultimo filtro
      F.vgUltimoFiltroComTit = PegaStrDoIni(x$, "Ultimo filtro com titulo", vgNomeINI$) 'ultimo filtro
      F.vgUltimaOrdem = PegaStrDoIni(x$, "Ultima ordem", vgNomeINI$)                    'ultima Ordem
      F.vgUltimaOrdemComTit = PegaStrDoIni(x$, "Ultima ordem com titulo", vgNomeINI$)   'ultia ordem
      If F.vgCaracteristica <> F_BROWSE Then
         F.vgEmBrowse = PegaIntDoIni(x$, "Em browse", 0, vgNomeINI$)                    'estava no browse?
         F.Tag = PegaStrDoIni(x$, "Coord ant", vgNomeINI$)                              'coordenadas anteriores
      End If

      'le linha dos grids
      On Error Resume Next                        'previne um erro
      If F.vgTipo = TP_BROWSE Or (F.vgTipo = TP_TABELA) Then
         If F.vgTemBrowse Then
            k$ = PegaStrDoIni(vgBrowseID$, "Alt grdBrowse", vgNomeINI$) 'altura da linha do grid da tabela
            If Len(k$) > 0 Then
               F.grdBrowse.RowHeight = Val(k$)                          'se leu coloca no grid
            End If
            k$ = PegaStrDoIni(vgBrowseID$, "Show filter bar grdBrowse", vgNomeINI$) 'barra de filtro
            If Len(k$) Then F.grdBrowse.ShowFilterBar = CBool(k$)
            k$ = PegaStrDoIni(vgBrowseID$, "Show status bar grdBrowse", vgNomeINI$) 'barra de status
            If Len(k$) Then F.grdBrowse.HideStatus = Not CBool(k$)
            k$ = PegaStrDoIni(vgBrowseID$, "Show left bar grdBrowse", vgNomeINI$)   'barra lateral esquerda
            If Len(k$) Then F.grdBrowse.HideLeftBar = Not CBool(k$)
            k$ = PegaStrDoIni(vgBrowseID$, "Show sum bar grdBrowse", vgNomeINI$)    'barra de somatório
            If Len(k$) Then F.grdBrowse.ShowSumBar = CBool(k$)
            k$ = PegaStrDoIni(vgBrowseID$, "Show min bar grdBrowse", vgNomeINI$)    'barra de mínimo
            If Len(k$) Then F.grdBrowse.ShowMinBar = CBool(k$)
            k$ = PegaStrDoIni(vgBrowseID$, "Show max bar grdBrowse", vgNomeINI$)    'barra de máximo
            If Len(k$) Then F.grdBrowse.ShowMaxBar = CBool(k$)
            k$ = PegaStrDoIni(vgBrowseID$, "Show avg bar grdBrowse", vgNomeINI$)    'barra de média
            If Len(k$) Then F.grdBrowse.ShowAvgBar = CBool(k$)
            k$ = PegaStrDoIni(vgBrowseID$, "Stripes grdBrowse", vgNomeINI$)         'zebrado
            If Len(k$) Then F.grdBrowse.Stripes = CBool(k$)
            k$ = PegaStrDoIni(vgBrowseID$, "Save Bars", vgNomeINI$)                 'salvar barras
            If Len(k$) Then F.grdBrowse.SaveGridBars = CBool(k$)
            k$ = PegaStrDoIni(vgBrowseID$, "Save Cols", vgNomeINI$)                 'salvar colunas
            If Len(k$) Then F.grdBrowse.SaveGridCols = CBool(k$)
            k$ = PegaStrDoIni(vgBrowseID$, "Save Stripes", vgNomeINI$)              'salvar zebrado
            If Len(k$) Then F.grdBrowse.SaveGridStripes = CBool(k$)

            'le largura das colunas do grid
            If F.grdBrowse.SaveGridCols Then                                        'tag do grid = 1, significa que quer le
               For j = 1 To F.grdBrowse.Columns.Count
                  k$ = PegaStrDoIni(vgBrowseID$, "Larg grdBrowse" + str$(j), vgNomeINI$)
                  If Len(k$) > 0 Then
                     F.grdBrowse.ColumnWidth(j) = Val(k$)                           'acerta tamanho da coluna
                  End If
                  k$ = PegaStrDoIni(vgBrowseID$, "SumCol grdBrowse" + str$(j), vgNomeINI$)
                  If Len(k$) > 0 Then F.grdBrowse.ShowSumCol(j) = CBool(k$)
                  k$ = PegaStrDoIni(vgBrowseID$, "AvgCol grdBrowse" + str$(j), vgNomeINI$)
                  If Len(k$) > 0 Then F.grdBrowse.ShowAvgCol(j) = CBool(k$)
                  k$ = PegaStrDoIni(vgBrowseID$, "MaxCol grdBrowse" + str$(j), vgNomeINI$)
                  If Len(k$) > 0 Then F.grdBrowse.ShowMaxCol(j) = CBool(k$)
                  k$ = PegaStrDoIni(vgBrowseID$, "MinCol grdBrowse" + str$(j), vgNomeINI$)
                  If Len(k$) > 0 Then F.grdBrowse.ShowMinCol(j) = CBool(k$)
               Next
            End If
         Else
            F.vgEmBrowse = False
         End If
      End If
      If F.vgTipo = TP_TABELA Or F.vgTipo = TP_PARAMETROS Then
         j = 0
         Do
            j = j + 1
            k$ = PegaStrDoIni(x$, "Filtro " & j, vgNomeINI)                         'pega nome da consulta do INI
         Loop Until k$ = F.vgUltimoFiltro Or k$ = ""
         If Len(k$) > 0 Then
            F.vgFiltroEmUso = j
         Else
            F.vgFiltroEmUso = 0
         End If
         j = F.Grid(0).Index                      'tem grid (filho) na janela
         If Err Then                              'se não
            Err.Clear                             'cancela o erro
         Else                                     'se tiver
            For j = 0 To F.Grid.Count - 1         'corre todos os grids da janela
               k$ = PegaStrDoIni(x$, "Alt grd" + Str$(j), vgNomeINI$)
               If Len(k$) > 0 Then
                  F.Grid(j).RowHeight = Val(k$)   'restaura altura da linha do grid
               End If 
               
               'lê flags para salvar layout do grid
               k$ = PegaStrDoIni(x$, "Save Bars" + str$(j), vgNomeINI$) 'salvar barras
               If Len(k$) Then F.Grid(j).SaveGridBars = CBool(k$)
               k$ = PegaStrDoIni(x$, "Save Cols" + str$(j), vgNomeINI$) 'salvar colunas
               If Len(k$) Then F.Grid(j).SaveGridCols = CBool(k$)
               k$ = PegaStrDoIni(x$, "Save Stripes" + str$(j), vgNomeINI$) 'salvar zebrado
               If Len(k$) Then F.Grid(j).SaveGridStripes = CBool(k$)

               'se está salvando as barras do grid, lê o que está gravado
               If F.Grid(j).SaveGridBars Then
                  k$ = PegaStrDoIni(x$, "Show filter bar grd"+ str$(j), vgNomeINI$) 'barra de filtro
                  If Len(k$) Then F.Grid(j).ShowFilterBar = CBool(k$)
                  k$ = PegaStrDoIni(x$, "Show status bar grd"+ str$(j), vgNomeINI$) 'barra de status
                  If Len(k$) Then F.Grid(j).HideStatus = Not CBool(k$)
                  k$ = PegaStrDoIni(x$, "Show left bar grd"+ str$(j), vgNomeINI$)   'barra lateral esquerda
                  If Len(k$) Then F.Grid(j).HideLeftBar = Not CBool(k$)
                  k$ = PegaStrDoIni(x$, "Show sum bar grd"+ str$(j), vgNomeINI$)    'barra de somatório
                  If Len(k$) Then F.Grid(j).ShowSumBar = CBool(k$)
                  k$ = PegaStrDoIni(x$, "Show min bar grd"+ str$(j), vgNomeINI$)    'barra de mínimo
                  If Len(k$) Then F.Grid(j).ShowMinBar = CBool(k$)
                  k$ = PegaStrDoIni(x$, "Show max bar grd"+ str$(j), vgNomeINI$)    'barra de máximo
                  If Len(k$) Then F.Grid(j).ShowMaxBar = CBool(k$)
                  k$ = PegaStrDoIni(x$, "Show avg bar grd"+ str$(j), vgNomeINI$)    'barra de média
                  If Len(k$) Then F.Grid(j).ShowAvgBar = CBool(k$)
               End If
               
               'se está salvando o zebrado, lê o que está gravado
               If F.Grid(j).SaveGridStripes Then
                  k$ = PegaStrDoIni(x$, "Stripes grd" + str$(j), vgNomeINI$)        'zebrado
                  If Len(k$) Then F.Grid(j).Stripes = CBool(k$)
               End If

               'le largura das colunas do grid se elas estão sendo gravadas
               If F.Grid(j).SaveGridCols Then
                  For i = 1 To F.Grid(j).Columns.Count
                     k$ = PegaStrDoIni(x$, "Larg grd" + str$(j) + str$(i), vgNomeINI$)
                     If Len(k$) > 0 Then F.Grid(j).ColumnWidth(i) = Val(k$)
                     k$ = PegaStrDoIni(x$, "SumCol grd" + str$(j) + str$(i), vgNomeINI$)
                     If Len(k$) > 0 Then F.Grid(j).ShowSumCol(i) = CBool(k$)
                     k$ = PegaStrDoIni(x$, "AvgCol grd" + str$(j) + str$(i), vgNomeINI$)
                     If Len(k$) > 0 Then F.Grid(j).ShowAvgCol(i) = CBool(k$)
                     k$ = PegaStrDoIni(x$, "MaxCol grd" + str$(j) + str$(i), vgNomeINI$)
                     If Len(k$) > 0 Then F.Grid(j).ShowMaxCol(i) = CBool(k$)
                     k$ = PegaStrDoIni(x$, "MinCol grd" + str$(j) + str$(i), vgNomeINI$)
                     If Len(k$) > 0 Then F.Grid(j).ShowMinCol(i) = CBool(k$)
                  Next
               End If
            Next
         End If
      End If
   ElseIf F.vgTipo = TP_RELAT Then                                                  'form de relatorio
      F.vgUltimoFiltro = PegaStrDoIni(x$, "Ultimo filtro", vgNomeINI$)              'ultimo filtro
      F.vgUltimoFiltroComTit = PegaStrDoIni(x$, "Ultimo filtro Com Titulo", vgNomeINI$)
      F.vgUltimaOrdem = PegaStrDoIni(x$, "Ultima ordem", vgNomeINI$)                'ultima ordem
      F.vgUltimaOrdemComTit = PegaStrDoIni(x$, "Ultima ordem com titulo", vgNomeINI$)
   End If
End Sub

'abre recordset do filtro com o ultimo filtro definido
Public Sub InicializaFiltro(F As Form, Optional ForcaAjusteRolagem As Boolean = True)
   Dim vgNovaSQL As String, x As String, i As Integer, vgBOK As Integer, _
       vgPosicReg As Boolean, vgNInd As String, _
       vgWhere As String, vgOrder As String
   
   vgBOK = vgBotoesOK                                'saval situacao anterior
   vgBotoesOK = False                                'flags que evitam

   vgNovaSQL$ = F.vgIdentTab
   
   If Len(F.vgUltimoFiltro) > 0 And Len(F.vgFiltroInicial) > 0 Then 'tem filtro extra?
      vgWhere$ = "(" + F.vgFiltroInicial + ") And (" + F.vgUltimoFiltro$ + ")" 'coloca na expressão SQL
   ElseIf Len(F.vgUltimoFiltro + F.vgFiltroInicial) > 0 Then                   'tem filtro extra?
      vgWhere$ = F.vgFiltroInicial + F.vgUltimoFiltro$                         'coloca na expressão SQL
   End If
   
   If Len(F.vgUltimaOrdem) > 0 And Len(F.vgOrdemInicial) > 0 Then              'tem Ordem extra?
      vgOrder$ = F.vgOrdemInicial + "," + F.vgUltimaOrdem$                     'coloca na expressão SQL
   ElseIf Len(F.vgUltimaOrdem + F.vgOrdemInicial) > 0 Then                     'tem Ordem extra?
      vgOrder$ = F.vgOrdemInicial + F.vgUltimaOrdem                            'coloca na expressão SQL
   End If

   

   If Len(vgOrder$) = 0 Then
      F.vgUltimaOrdem = ""
      F.vgUltimaOrdemComTit = ""
   End If
   vgPosicReg = False                             'se o recordset ja esta aberto e se for um
   If F.vgTipo = TP_TABELA Then
      If Not F.vgTb Is Nothing Then               'reg valido vamos tentar reposicionar depois
         If F.vgTb.RsSource <> "" Then
            vgPosicReg = (F.vgTb.RecordCount > 0 And F.vgTb.EOF = False And F.vgTb.BOF = False)
         End If
      End If
   ElseIf F.vgTipo = TP_BROWSE Then
      With F.grdBrowse.Recordset
         If .RsSource <> "" Then
            vgPosicReg = (.RecordCount > 0 And .EOF = False And .BOF = False)
         End If
      End With
   End If
   
   If F.vgTipo = TP_TABELA Or F.vgTipo = TP_PARAMETROS Then
      Set F.vgTb = New GRecordSet                 'instancia o recordset
      
      'vamos inserir relacionamentos para combo-box
      On Error Resume Next
      i = F.txtCp.Count
      If Err = 0 Then
         For i = 0 To F.txtCp.Count - 1
            If Len(F.txtCampoTab(i).Source) > 0 And Len(F.txtCampoTab(i).Relation) > 0 Then
               F.vgTb.AddRelation F.txtCampoTab(i).Source, F.txtCampoTab(i).BoundColumn, F.txtCampoTab(i).ListFields, F.txtCampoTab(i).OrderFields, F.txtCampoTab(i).Filter, F.txtCampoTab(i).Relation
            End If
         Next
      End If
      On Error Goto 0
      
      F.vgTb.ExternalOrderBy = vgOrder$
      F.vgTb.Where = vgWhere$
      F.vgTb.Source = vgNovaSQL$
      F.vgTb.OpenRecordSet                        'abre o dynaset
      If Len(vgWhere$ + vgOrder$) > 0 Then        'tem filtro/ordem extra?
         If F.vgTb.RecordCount > 0 Then           'tem registro...
            F.vgTb.MoveLast                       'vamos popular
            F.vgTb.MoveFirst                      'o dynaset de filtro
         End If                                   'filtro
      Else
         F.vgTb.Index = vgNInd$
      End If

   End If
   If vgPosicReg Then                             'reposiciona o reg
      On Error Resume Next                        'vamos ignorar algum erro ocorrido pois nem
      F.Reposition                                'toda janela de dados tem essa Sub
      On Error GoTo 0
   End If
   If vgPosicReg > 0 Or F.vgTipo <> TP_BROWSE Then
      If ForcaAjusteRolagem Then AjustaRolagem F  'ajusta scroll de rolagem do
   End If

   'coloca filtro da tabela no caption
   If F.vgTipo = TP_BROWSE Then
      x$ = F.grdBrowse.Caption
   Else
      x$ = F.Caption
   End If
   i = InStr(x$ + Chr$(160), Chr$(160))           'tinha filtro antes
   x$ = Left$(x$, i - 1)                          'vamos retirar
   If Len(F.vgUltimoFiltroComTit) > 0 Then        'se tem filtro agora vamos mostrar
      x$ = x$ + Chr(160) + " - " + F.vgUltimoFiltroComTit
   End If
   If F.vgTipo = TP_BROWSE Then
      F.grdBrowse.Caption = x$
   Else
      F.Caption = x$
   End If
   
   For i = 0 To F.Controls.Count - 1              'corre controles
      If TypeOf F.Controls(i) Is GCpMM Then       'se cp imagem,
         If Len(F.Controls(i).DataField) > 0 And _
            F.Controls(i).Locked = False Then     'e vinculado, sem ser fórmula,
            Set F.Controls(i).DataSource = F.vgTb 'troca recordset
         End If
      End If
   Next
   
   If F.vgTipo = TP_BROWSE Then
      F.vgFiltroAtual = vgWhere
      F.vgOrdemAtual = vgOrder
   End If
   F.vgSQL = vgNovaSQL$
   vgBotoesOk = vgBOK                             'retorna situacao
End Sub

'Inicializa os controles de dados, filtros, variáveis públicas e permissões para o formulário
Public Sub IniciaFormDados(F As Form)
   Dim x As String, vgP As Integer

TentaDeNovo:
   
   On Error GoTo DeuErro

   F.vgSituacao = ACAO_NAVEGANDO                   'situacao atual do form
   InicializaFiltro F
   DesligaRepara                                   'desativa botao de repara BD
   If F.vgTipo <> TP_BROWSE Then                   'ajusta permissões
      vgP = Permitido(F.vgIdentTab, 0)
      If F.vgTemInclusao Then F.vgTemInclusao = ((vgP And 2 ^ ACAO_INCLUINDO) = 2 ^ ACAO_INCLUINDO)
      If F.vgTemExclusao Then F.vgTemExclusao = ((vgP And 2 ^ ACAO_EXCLUINDO) = 2 ^ ACAO_EXCLUINDO)
      If F.vgTemAlteracao Then F.vgTemAlteracao = ((vgP And 2 ^ ACAO_EDITANDO) = 2 ^ ACAO_EDITANDO)
      If (F.vgCaracteristica = F_DADOS) And _
         F.vgTipo <> TP_PARAMETROS Then            'se o form tem browse
         If F.vgTemBrowse And F.vgEmBrowse Then
            F.grdBrowse.AllowInsert = F.grdBrowse.AllowInsert And F.vgTemInclusao
            F.grdBrowse.AllowDelete = F.grdBrowse.AllowDelete And F.vgTemExclusao
            F.grdBrowse.AllowEdit = F.grdBrowse.AllowEdit And F.vgTemAlteracao
            x$ = F.Tag                             'salva coordenadas anteriores
            F.Tag = ""
            TrocaBrowse F                          'mostra/esconde o grid
            F.Tag = x$                             'restabelece coordenadas
         End If
      End If
   End If

   Exit Sub

ForcaErro:
   Error 3251
   
DeuErro:
   If Err.Number = -2147467259 Or Err.Number = 3251 Then 'se erro de conexão...
      If MsgBox(LoadGasString(1138), vbQuestion + vbYesNo, vgAtencao) = vbYes Then
         FechaBancoDeDados                               'fecha o banco
         Err.Clear
         If AbreBancoDeDados(True) Then                  'tenta abrir novamente ignorando erros
            Resume TentaDeNovo                           'ok, banco aberto, vamos tentar iniciar dados novamente
         Else
            Resume ForcaErro                             'vamos perguntar novamente
         End If
      Else
         vgPWUsuario$ = ""                               'vamos impedir crítica para deixar na senha
         Unload mdiNFE
      End If
   End If

End Sub

Public Sub ForcaFocoAplicativo(Optional ByVal hWnd As Long)
   Dim ThreadID1 As Long
   Dim ThreadID2 As Long
   Dim nRet As Long
   
   If hWnd = 0 Then hWnd = mdiNFE.hWnd
   
   If hWnd = GetForegroundWindow() Then           'se é a própria Window solicitada...
      'pode cair fora
   Else
      ThreadID1 = GetWindowThreadProcessId(GetForegroundWindow, ByVal 0&)
      ThreadID2 = GetWindowThreadProcessId(hWnd, ByVal 0&)
      If ThreadID1 <> ThreadID2 Then
         Call AttachThreadInput(ThreadID1, ThreadID2, True)
         nRet = SetForegroundWindow(hWnd)
         Call AttachThreadInput(ThreadID1, ThreadID2, False)
      Else
         nRet = SetForegroundWindow(hWnd)
      End If
      If IsIconic(hWnd) Then
         Call ShowWindow(hWnd, SW_RESTORE)
      Else
         Call ShowWindow(hWnd, SW_SHOW)
      End If
   End If
End Sub

'Inicializa o sistema mostrando logotipo, pega nome da estação, diretório de trabalho, senhas, etc..
Public Sub Main()
   Dim j As Long, i As Long, vgDCon As String, p As String * 50
   vgDirEXE$ = App.Path                           'diretório onde a aplicação está sendo executada
   If Right(vgDirEXE$, 1) <> "\" Then             'se diretório da aplicação não for o
      vgDirEXE$ = vgDirEXE$ + "\"                 'raiz, coloca "\" no fim do path
   End If
   AbreHandleRes

   'vamos conferir o arquivo RES
   If Not Existe(vgDirEXE$ + vgNomeRes$) Then
      MsgBox "Arquivo de recursos " + vgNomeRes$ + " não encontrado no diretório do aplicativo! Reinstale o programa para correção do problema.", vbExclamation
      Exit Sub
   ElseIf vgQdeRecursos = 0 Then
      MsgBox "Arquivo de recursos " + vgNomeRes$ + " está corrompido! Reinstale o programa para correção do problema.", vbExclamation
      Exit Sub
   End If

   vgNomeApp$ = "NFE"                             'nome original do aplicativo (.EXE)
   vgArqEstXML$ = vgDirEXE$ + vgNomeApp$ + ".XML" 'nome do arquivo de estrutura
   vgNomeSistema$ = LoadGasString(1020)           'nome da aplicação
   vgIDSistema$ = LoadGasString(1025)             'ID da aplicação
   vgCriptChv$ = LoadGasString(1026)              'Chave para encriptações
   vgProjetista$ = LoadGasString(1030)            'nome do analista/projetista
   vgEMailProjetista = LoadGasString(1031)        'e-mail do analista/projetista
   
   'Vamos armazenar nome do executável para utilização pelo Gerente
   SaveSetting "SOLUÇAO", vgNomeApp$, "Dir", vgDirEXE$
   
   i = App.PrevInstance                           'verifica se tem outra instância
   j = ProcuraWindow(vgNomeSistema$ + Chr$(160), 0, "") 'verifica se a aplicação já está rodando pelo título...
   If Not i Then i = (j <> 0)                           'achou rodando
   If i Then                                            'tem outra instância
      If j Then ForcaFocoAplicativo j
      Exit Sub                                          'cai fora desta aplicação
   End If
   i = GetProfileString("Intl", "sDecimal", ",", p$, Len(p$)) 'tenta pegar separador decimais
   If i > 0 Then                                              'se i>0, pegamos
      vgSpDec$ = Left$(p$, i)                                 'vamos salvar...
   Else                                           'senão,
      vgSpDec$ = ","                              'vamos usar vírgula
   End If
   vgCriandoSenha = False
   vgSpInt$ = IIf(vgSpDec$ = ",", ".", ",")       'separador de inteiros
   vgSubsTab$ = Chr$(160) + Chr$(160) + Chr$(160)
   vgAtencao$ = LoadGasString(1040)               'palavra "Atenção!" (usada muitas vezes)
   vgNomeINI$ = vgDirEXE$ + "NFE.INI"             'nome do aquivo .INI (configurações)
   vgAliasDb$(1) = "DADOSNFE"
   vgSenhaLog(1) = "5139249"
   vgTiposPermDb(1) = 8
   vgNomeCupom$ = vgDirEXE$ + "CUPOM.ECF"         'espelho do último cupom fiscal...
   i = GetComputerName(p$, Len(p$))               'tenta pega o nome da estacao
   If i > 0 Then                                  'ok! pega o mome da estação
      vgNomeEstacao$ = Left$(p$, Instr(p$ + Chr$(0), Chr$(0)) - 1)
   Else                                           'o windows não sabe quem é!!!
      vgNomeEstacao$ = ""
   End If
   If Len(vgNomeEstacao$) = 0 Then                'aida não tem o nome da estação
      vgNomeEstacao$ = Environ(LoadGasString(1137)) 'tenta pegar nome da estação pela variável em "SET ESTACAO"
      If Len(vgNomeEstacao$) = 0 Then               'se não conseguiu
         Load frmControle                           'carrega form para memória e diz ao
         If Not frmControle.IniciaForm(PEGA_ESTACAO) Then 'form que vamos receber o nome da estação
            End                                           'então não pode entrar no sistema.
         End If
      End If
   End If
   vgNomeEstacao$ = vgNomeEstacao$ + " - "                'prepara variável para grupo no .INI

   'pega diretório de trabalho
   If LeInfDb() = False Then                              'informação não encontrada no .INI
      Load frmControle                                    'mostra form e diz a ele que
      If Not frmControle.IniciaForm(PEGA_DIR) Then        'queremos pedir o diretório do BD
         End
      End If
      'grava diretório no arquivo .INI para esta estação
      GravaNoIni vgNomeEstacao$ + "Geral", "Nome de " + vgAliasDb(1), vgNomeDb$(1), vgNomeINI$
      GravaNoIni vgNomeEstacao$ + "Geral", "Tipo de " + vgAliasDb(1), CStr(vgTipoDb(1)), vgNomeINI$
      GravaNoIni vgNomeEstacao$ + "Geral", "Diretório de " + vgAliasDb(1), vgDirDb(1), vgNomeINI$
      GravaNoIni vgNomeEstacao$ + "Geral", "Server de " + vgAliasDb(1), vgServerDb(1), vgNomeINI$
      GravaNoIni vgNomeEstacao$ + "Geral", "Trusted Connection de " + vgAliasDb(1), CStr(Abs(vgTrustConnDb(1))), vgNomeINI$
      GravaNoIni vgNomeEstacao$ + "Geral", "Usuário de " + vgAliasDb(1), Encripta$(vgUsuarioID(1)), vgNomeINI$
      GravaNoIni vgNomeEstacao$ + "Geral", "Senha de " + vgAliasDb(1), Encripta$(vgSenhaDb(1)), vgNomeINI$
      GravaNoIni vgNomeEstacao$ + "Geral", "Provider de " + vgAliasDb(1), vgProviderDb(1), vgNomeINI$
      GravaNoIni vgNomeEstacao$ + "Geral", "Driver de " + vgAliasDb(1), vgDriverDb(1), vgNomeINI$
      GravaNoIni vgNomeEstacao$ + "Geral", "String Connection de " + vgAliasDb(1), vgStrConnectionDb(1), vgNomeINI$
   End If

   'pega diretório do ini da consulta
   vgDCon$ = PegaStrDoIni(vgNomeEstacao$ + "Geral", "Diretório das consultas", vgNomeINI$)
   If Len(vgDCon$) = 0 Then                               'informação não encontrada no .INI
      Load frmControle                                    'mostra form e diz a ele que
      If Not frmControle.IniciaForm(PEGA_INI_CONSULTA) Then 'queremos pedir o diretório das consultas
         End                                                'consultas cai fora
      End If
      'grava diretrio no arquivo .INI para esta estaao
      GravaNoIni vgNomeEstacao$ + "Geral", "Diretório das consultas", vgConsultaINI$, vgNomeINI$
   Else                                           'diretório já havia sido informado
      vgConsultaINI$ = LTrim$(vgDCon$)            'anteriormente
   End If
   vgConsultaINI$ = vgConsultaINI$ + "NFE VIEW.INI" 'nome do aquivo .INI das consultas
   Screen.MousePointer = vbHourglass                'ampulheta...

   'le do .INI o status da barra de ferramenta e da ajuda ativa
   vgBarraFerr = PegaIntDoIni(vgNomeEstacao$ + "Geral", "Barra ferramentas", -1, vgNomeINI$)
   vgAjudaAtiva = PegaIntDoIni(vgNomeEstacao$ + "Geral", "Ajuda ativa", -1, vgNomeINI$)

   For i = 0 To EXP_TODAS - 1                       'vetor com os nomes das cláusulas SQL
      vgClausula$(i) = " " + Choose(i + 1, "SELECT", "SET", "FROM", "LEFT JOIN", "RIGHT JOIN", "INNER JOIN", "ON", "WHERE", "GROUP BY", "HAVING", "ORDER BY", "LIMIT") + " "
   Next

   If Not AbreBancoDeDados() Then                   'se não conseguiu abrir o BD
      Beep                                          'avisa
      End                                           'e cai fora!
   End If
   
   Screen.MousePointer = vbDefault                  'tira ampulheta...
   Load mdiNFE                                      'carrega form principal para a memória
   mdiNFE.PoeTiraBarra
   On Error Resume Next                             'pode não ser um impressora convensional
   Printer.FontName = "Courier New"                 'ajusta tipo da fontes impressora
   vgImpConv = (Err=0)                              'impressora convêncional?
   If Not vgImpConv Then                            'não pode configurar...
      Beep
      PrepBotoes mdiNFE, mdiNFE.vgSituacao
      MsgBox LoadGasString(1085), vbExclamation, vgAtencao$
   Else
      Printer.FontSize = 9.5                        'ajusta o tamanho da fonte
   End If
   For i = 0 To UBound(vgFuncAgregadas)             'funções agregadas do SQL para construção de consultas
      vgFuncAgregadas$(i) = Choose(i + 1, "DAY", "MONTH", "YEAR", "FORMAT", "FORMAT", "COUNT", "SUM", "AVG", "MIN", "MAX", "STDEVP", "STDEV", "VARP", "VAR")
   Next

   'cria registros para senha
   If Not CriaUsuarioAdm() Then                     'cria registros da senha se necessário
      FechaBancoDeDados                             'deu erro... Fecha o banco dado
      Beep                                          'avisa
      MsgBox LoadGasString(1130), vbCritical, vgAtencao$
      End                                           'e cai fora!
   End If

   PegaLogin PEGA_SENHA_INICIAL                     'pega senha, 1a. vez...
   If vgPWUsuario$ = "" Then                        'não disse quem é...
      UnLoad mdiNFE                                 'descarrega form principal
      FinalizaAplicacao                             'finaliza a aplicação
      End
   End If
      PrepBotoes mdiNFE, mdiNFE.vgSituacao 
   GeraLogAcao LoadGasString(293)
End Sub

'Carrega todas as informações para o banco requerido
Public Function LeInfDb(Optional vgTipo As EnumDataBaseType = -1) As Boolean
   Dim RetVal As Boolean
   If vgTipo <> -1 Then                           'vamos pegar informações definidas em projeto
      vgNomeDb(1) = "DADOSNFE"
      vgTrustConnDb(1) = False
      vgUsuarioID(1) = ""
      vgSenhaDb(1) = ""
      vgStrConnectionDb(1) = "Provider=[PROVIDER];Persist Security Info=False;DRIVER=[DRIVER];Server=[SERVER];UID=[USER];Pwd=[PASSWORD];Database=[DATABASE];Trusted_Connection=[TRUSTED]"
   Else                                           'lê informações do INI
      vgNomeDb(1) = PegaStrDoIni(vgNomeEstacao$ + "Geral", "Nome de " + vgAliasDb(1), vgNomeINI$)
      vgTipoDb(1) = PegaIntDoIni(vgNomeEstacao$ + "Geral", "Tipo de " + vgAliasDb(1), -1, vgNomeINI$)
      vgDirDb(1) = PegaStrDoIni(vgNomeEstacao$ + "Geral", "Diretório de " + vgAliasDb(1), vgNomeINI$)
      vgServerDb(1) = PegaStrDoIni(vgNomeEstacao$ + "Geral", "Server de " + vgAliasDb(1), vgNomeINI$)
      vgTrustConnDb(1) = PegaIntDoIni(vgNomeEstacao$ + "Geral", "Trusted Connection de " + vgAliasDb(1), 0, vgNomeINI$)
      vgUsuarioID(1) = Decripta$(PegaStrDoIni(vgNomeEstacao$ + "Geral", "Usuário de " + vgAliasDb(1), vgNomeINI$))
      vgSenhaDb(1) = DeCripta$(PegaStrDoIni(vgNomeEstacao$ + "Geral", "Senha de " + vgAliasDb(1), vgNomeINI$))
      vgProviderDb(1) = PegaStrDoIni(vgNomeEstacao$ + "Geral", "Provider de " + vgAliasDb(1), vgNomeINI$)
      vgDriverDb(1) = PegaStrDoIni(vgNomeEstacao$ + "Geral", "Driver de " + vgAliasDb(1), vgNomeINI$)
      vgStrConnectionDb(1) = PegaStrDoIni(vgNomeEstacao$ + "Geral", "String Connection de " + vgAliasDb(1), vgNomeINI$)
      
      RetVal = ((vgTiposPermDb(1) And vgTipoDb(1)) <> 0 And vgTipoDb(1) <> -1)
      
      If RetVal Then                              'se tipo ok, vamos validar se tem o restante dos dados para o tipo de banco selecionado
            RetVal = (Len(vgStrConnectionDb(1)) > 0) Or ((Len(vgServerDb$(1)) > 0) And (vgTrustConnDb(1) Or ((Len(vgUsuarioID(1)) > 0) And (Len(vgSenhaDb(1)) > 0))))
      End If
   End If
   
   LeInfDb = RetVal
End Function

Public Sub FinalizaAplicacao()
   On Error Resume Next
   FechaBancoDeDados
End Sub

'cria os registros de senhas para as tabelas
Public Function CriaUsuarioAdm() As Boolean
   Dim vgTb As New GRecordSet, vgTbG As New GRecordset
               
   On Error GoTo DeuErro                              'vamos esperar os erros...
   Set vgTbG = vgDb.OpenRecordSet("SELECT * FROM PW~Grupos WHERE [PW~Nome]='" & Encripta$(UCase$(LoadGasString(11166))) & "'") 'abre a tabela de grupos
   If vgTbG.RecordCount = 0 Then
   
      'vamos verificar se existe o grupo "ADMINISTRAÇÃO" sem base64
      Set vgTbG = vgDb.OpenRecordSet("SELECT * FROM PW~Grupos WHERE [PW~Nome]='" & EncriptaPW$(UCase$(LoadGasString(11166))) & "'") 'abre a tabela de grupos

      If vgTbG.RecordCount = 0 Then
         With vgTbG                               'para criar o supervisor
            .AddNew                               'cria registro
            ![PW~Nome] = Encripta$(UCase$(LoadGasString(11166))) 'nome do grupo encriptado
            .Update                                              'atualiza a tabela
         End With
         Set vgTb = vgDb.OpenRecordSet("SELECT TOP 1 * FROM PW~Usuarios") 'cria o supervisor no grupo administração
         With vgTb
            .AddNew                               'cria o registro
            ![PW~Grupo] = Encripta$(UCase$(LoadGasString(11166))) 'nome do grupo (administrador)
            ![PW~Nome] = Encripta$("ADMIN")                       'nome do usuário
            ![PW~Senha] = Encripta$("5139249")                    'senha master
            ![PW~Obs] = Encripta$(Space$(25))                     'obs - nada
            .Update                                               'atualiza arquivo
         End With
         vgTb.CloseRecordset                                      'fecha tabela de usuários
      Else
         ConverteEncriptacao
      End If
   End If
   vgTbG.CloseRecordset                                           'fecha tabela de grupo
   Set vgTbG = Nothing
   Set vgTb = Nothing
   CriaUsuarioAdm = True
   Exit Function

DeuErro:
   CriaUsuarioAdm = False
End Function

'converte a encriptação dos registros das tabelas de senhas
Public Sub ConverteEncriptacao()
   Dim Base64 As New Base64
   Dim i As Long
   Dim j As Integer
   
   Set vgRsPwGrupos = vgDb.OpenRecordSet("PW~Grupos")
   
   'percorrer todos os campos da tabela "PW~Grupos"
   Do While Not vgRsPwGrupos.EOF
      For j = 1 To vgRsPwGrupos.Fields.Count
         If Not Base64.IsBase64(vgRsPwGrupos(j)) Then
            vgRsPwGrupos(j) = Encripta(EncriptaPW(vgRsPwGrupos(j)))
         End If
      Next
      vgRsPwGrupos.MoveNext
   Loop
   
   Set vgRsPwUsuarios = vgDb.OpenRecordSet("PW~Usuarios")
   
   'percorrer todos os campos da tabela "PW~Usuarios"
   Do While Not vgRsPwUsuarios.EOF
      For j = 1 To vgRsPwUsuarios.Fields.Count
         If Not Base64.IsBase64(vgRsPwUsuarios(j)) Then
            vgRsPwUsuarios(j) = Encripta(EncriptaPW(vgRsPwUsuarios(j)))
         End If
      Next
      vgRsPwUsuarios.MoveNext
   Loop

   Set vgRsPwTabelas = vgDb.OpenRecordSet("PW~Tabelas")

   'percorrer todos os campos da tabela "PW~Tabelas"
   Do While Not vgRsPwTabelas.EOF
      For j = 1 To vgRsPwTabelas.Fields.Count
         If Not Base64.IsBase64(vgRsPwTabelas(j)) Then
            vgRsPwTabelas(j) = Encripta(EncriptaPW(vgRsPwTabelas(j)))
         End If
      Next
      vgRsPwTabelas.MoveNext
   Loop
   
   Set Base64 = Nothing
End Sub

Public Function PegaErro() As String
   Dim x As String
   Select Case CErr.NumErro                       'qual será o erro?
      Case -2147217864                            'registro acabou de ser alterado por outro usuário
         x$ = LoadGasString(58) + vbCrLf + LoadGasString(59)
         CErr.Fatal = True                        'erro nao pode continuar...
      Case -2147217885                            'registro foi apagado por outro usuário
         x$ = LoadGasString(57)
         CErr.Fatal = True                        'erro nao pode continuar...
      Case 3024                                   'banco não encontrado
         x$ = LoadGasString(72)
      Case -2147352571                            'tipo de dado inválido
         x$ = LoadGasString(71)
      Case  -2147217900, -2147217973              'ja existe/erro de integridade
         x$ = LoadGasString(65)
      Case 3600
         x$ = LoadGasString(121)
      Case 3601
         x$ = LoadGasString(121)
         CErr.Fatal = True
      Case 3800      
         If Len(CErr.Mensagem) = 0 Then
            x$ = LoadGasPicture(124)              'erro ao gravar
         End If 
      Case 3801
         x$ = LoadGasPicture(123)                 'erro ao excluir
   End Select
   PegaErro = x$ 
End Function

'habilita/desabilita e troca icones dos botões da barra de ferramenta
'de acordo com a situação que se encontra o form no momento
Public Sub PrepBotoes(F As Form, vgAcao As Integer)
   Dim vgHaRegNaoInc As Integer, i As Integer, vgHaFiltro As Integer

   vgHaFiltro = False

   'todos os form que tem controle da dados
   If F.vgTipo = TP_TABELA Or F.vgTipo = TP_PARAMETROS Then
      If F.vgSemVincDados = 0 Then
         vgHaRegNaoInc = ((F.vgTb.RecordCount > 0 And F.vgTb.EOF = False) And _
                          vgAcao = ACAO_NAVEGANDO)  'tem registro na tabela e não está editando
         vgHaFiltro = (Len(F.vgUltimoFiltro) > 0)
         i = (Not ((F.vgTemAlteracao And _
             F.vgTb.RecordCount > 0 And F.vgTb.EOF = False) Or _
             vgAcao = ACAO_INCLUINDO))              'controles nao pode ser editados?
         LigaDesligaControles F, i                  'bloquea edicao ou nao dos controles da tela
      Else
         vgHaRegNaoInc = False                      'não pode esta incluindo...
      End If
   ElseIf F.vgTipo = TP_BROWSE Then
      vgHaRegNaoInc = ((F.grdBrowse.Recordset.RecordCount > 0 And F.grdBrowse.Recordset.EOF = False) And vgAcao = ACAO_NAVEGANDO) 'tem registro na tabela e não está editando
   Else                                           'se não é form de dados
      vgHaRegNaoInc = False                       'não pode esta incluindo...
   End If
   With mdiNFE
      .vgPriVez = True

      'botão grava habilita somente se esta em um form de dados e não esta
      'no browse (consulta) e esta fazendo uma atualização no arquivo ou
      'esta em um form de gráfico
      i = (F.vgTipo = TP_GRAFICO Or ((F.vgTipo = TP_TABELA Or F.vgTipo = TP_PARAMETROS Or F.vgTipo = TP_BROWSE) And vgAcao <> ACAO_NAVEGANDO And vgAcao <> ACAO_EM_PROGRESSO And vgAcao <> ACAO_EXCLUINDO))
      .botSalva.Enabled = i
      .Menu_Salva.Enabled = i

      'botão cancela idem do grava, a não ser que não seja habilitado em relatórios
      i = (i And F.vgTipo <> TP_GRAFICO)
      .botCancela.Enabled = i
      .Menu_Cancela.Enabled = i
      If F.vgTipo = TP_TABELA Then                'só na tabela pode ter inclusão e exclusão
         i = (F.vgTemExclusao And vgHaRegNaoInc)
         .botExclui.Enabled = i
         .Menu_Exclui.Enabled = i
         i = (F.vgEmBrowse = False And F.vgTemInclusao And vgAcao = ACAO_NAVEGANDO)
         .botInclui.Enabled = i
         .Menu_Inclui.Enabled = i
      Else                                        'o form não é tabela
         .botInclui.Enabled = False               'desativa botões de inclui
         .Menu_Inclui.Enabled = False             'desativa opção de menu inclui
         .botExclui.Enabled = False               'e exclui
         .Menu_Exclui.Enabled = False
         .Menu_Repeticao.Enabled = False
      End If
      .Menu_Procura.Enabled = False
      i = (F.vgEmBrowse = False And (F.vgTipo = TP_TABELA Or F.vgTipo = TP_PARAMETROS))
      .Menu_Ortog.Enabled = i
      .botPrimeiro.Enabled = False                'verificar se tem necessidade
      .Menu_Primeiro.Enabled = False
      .botAnterior.Enabled = False                'de liga-los
      .Menu_Anterior.Enabled = False
      .botSeguinte.Enabled = False
      .Menu_Seguinte.Enabled = False
      .botUltimo.Enabled = False
      .Menu_Ultimo.Enabled = False
      .schNavega.Enabled = False
      i = (F.vgTipo = TP_BROWSE)
      .Menu_Filtra.Enabled = i

      'se for uma tabelas e não estiver em modo de inclusão
      If F.vgTipo = TP_TABELA And (vgHaRegNaoInc Or vgHaFiltro) Then
         .Menu_Filtra.Enabled = F.vgTemFiltro
         If F.vgTb.RecordCount > 1 And vgHaRegNaoInc Then 'se tem mais de um registro
            .Menu_Procura.Enabled = F.vgTemProcura
            .botPrimeiro.Enabled = True                   'no arquivo
            .Menu_Primeiro.Enabled = True                 'no arquivo
            .botAnterior.Enabled = True
            .Menu_Anterior.Enabled = True
            .botSeguinte.Enabled = True
            .Menu_Seguinte.Enabled = True
            .botUltimo.Enabled = True
            .Menu_Ultimo.Enabled = True
                  .schNavega.Enabled = True               'habilita sua navegação
         End If
      End If
      If F.vgTipo = TP_TABELA And vgHaRegNaoInc = False Then
         If Len(F.vgUltimoFiltro) > 0 Then
            .Menu_Filtra.Enabled = True
         End If
      End If
      'se for tabela não estiver incluindo e não for "filho" habilita botão de browse
      If F.vgTipo <> TP_TABELA Then
         i = False
      Else
         i = (F.vgTemBrowse And vgAcao = ACAO_NAVEGANDO And _
             (F.vgCaracteristica = F_DADOS))
      End If
      .botBrowse.Enabled = i
      .Menu_Browse.Enabled = i
      If i Then                                           'se botao de browse esta habilitado
         .botBrowse.Value = F.vgEmBrowse                  'seta seu valor (baixo ou cima)
      Else                                                'senão,
         .botBrowse.Value = False                         'sempre coloca para cima
      End If

      'se for consulta na tabela no módulo browse e não está incluindo, pode
      'totalizar, grafar e apagar colunas
      i = ((F.vgTipo = TP_BROWSE Or F.vgEmBrowse) And vgHaRegNaoInc)
      .Menu_Grafa.Enabled = i
      .Menu_ApagaCol.Enabled = i
      'forms de consulta, gráfico, info BD, tabela, parâmetro e relatórios tem impressão
      i = ((((F.vgTipo = TP_BROWSE And vgHaRegNaoInc) Or F.vgTipo = TP_GRAFICO Or F.vgTipo = TP_INFODB Or (F.vgTipo = TP_TABELA Or F.vgTipo = TP_PARAMETROS) And _
          vgHaRegNaoInc)) And vgImpConv)
      .botImprime.Enabled = i
      .Menu_Imprime.Enabled = i

      'configurações só no gráfico
      i = (F.vgTipo = TP_GRAFICO)
      .Menu_ConfGraf.Enabled = i

      'botão de seleção de consulta, só não pode nele mesmo
      i = (F.vgTipo <> TP_SELEQUERY)
      .Menu_Consulta.Enabled = i

      On Error Resume Next
      .Menu_Consulta.Visible = (False And (PermitidoMenu(.Menu_Consulta.Tag)))
      .Menu_Repara.Visible = (False And (PermitidoMenu(.Menu_Repara.Tag)))
      .Menu_Info.Visible = (False And (PermitidoMenu(.Menu_Info.Tag)))
      .Menu_570(9).Visible = (False And (PermitidoMenu(.Menu_570(9).Tag)))
      .Menu_614(0).Visible = (False And (Permitido("Empresa", ACAO_NAVEGANDO) And PermitidoMenu(.Menu_614(0).Tag)))
      .Menu_614(0).Enabled = vgPWUsuario = "ADMIN"
      .Menu_614(1).Visible = (False And (Permitido("Parametros da nfe", ACAO_NAVEGANDO) And PermitidoMenu(.Menu_614(1).Tag)))
      .Menu_570(5).Visible = (False And (PermitidoMenu(.Menu_570(5).Tag)))
      .Menu_639(1).Visible = (False And (PermitidoMenu(.Menu_639(1).Tag)))
      .vgPriVez = False
   End With
   vgBotoesOK = (vgAcao = ACAO_NAVEGANDO)                 'flag - se os botões não estão em edição
   F.vgSituacao = vgAcao                                  'coloca situação atual que se encontra o form
   On Error Resume Next
   mdiNFE.Botao(0).Visible = (False)
   If Err > 0 Then
      Err.Clear
      mdiNFE.Botao(0).Visible = False
   End If
   On Error Resume Next
   F.LigaDesligaBotoes                                    'habilita/desabilita botoes = barra de ferramentas
End Sub


Public Function MontaExpressaoFiltro(ByVal vgExpOrig As String, ByVal vgTipoCampo As GCOLUMN_TYPE, ByVal vgOp As String, ByVal vgCampo As String, ByVal vgConteudo1 As Variant, ByVal vgConteudo2 As Variant) As String
   Dim x As String, Vl As String, vgOk As Boolean, vgJaFez As Boolean, vgOpOrig As String
   vgJaFez = False
   vgOpOrig = vgOp
   If vgOp = "L" Then
      vgOp = "Like"
   End If
   If vgOp = "B" Then
      If vgTipoCampo = TP_DATA_HORA Then
         vgOk = (IsDate(vgConteudo1) And IsDate(vgConteudo2))
      Else
         vgOk = (Len(vgConteudo1) > 0 And Len(vgConteudo2) > 0)
      End If
      vgOp = ">="
   Else
      If vgTipoCampo = TP_DATA_HORA Then
         vgOk = IsDate(vgConteudo1)
      Else
         vgOk = (Len(vgConteudo1) > 0)
      End If
   End If
   If vgOp = "V" Then
      vgOp = "="
      vgConteudo1 = ""
      vgOk = True
   End If
   
OutraVez:
   If vgOk Then                                   'se tem informação digitada para esse campo
      If Len(vgExpOrig$) > 0 Then vgExpOrig$ = vgExpOrig$ + " And " 'vamos concatenar se for preciso
      vgExpOrig$ = vgExpOrig$ + PoeColchetes(vgCampo)               'soma com o nome do campo
      If vgTipoCampo = TP_CARACTER Or vgTipoCampo = TP_MEMO Then    'se caracter
         x$ = Substitui(CStr(vgConteudo1), "'", "''", SO_UM)
         vgExpOrig$ = vgExpOrig$ + " " + vgOp$ + " " + Chr(39) + x$ + IIf(vgOpOrig = "L", "*", "") + Chr(39)
      ElseIf vgTipoCampo = TP_DATA_HORA Then                        'se data
         vgExpOrig$ = vgExpOrig$ + " " + vgOp$ + " CDate('" + Format(vgConteudo1, "dd/mm/yyyy hh:mm:ss") + "')"
      Else                                        'se não...
         Vl$ = CStr(vgConteudo1)                  'corrige valor
         x$ = " = "                               'default vamos procurar =
         If vgTipoCampo = TP_NUMERICO Or vgTipoCampo = TP_LOGICO Then 'se numérico ou lógico
            If vgTipoCampo = TP_LOGICO Then                           'se lógico
               If Vl$ <> "0" Then                                     'se não for "0" vamos procurar por True
                  Vl$ = "0"                                           'volta para 0
                  x = " <> "                                          'para pegar tudo diferente de false
               Else                               'senão...
                  Vl$ = "0"                       'vamos procurar por False
               End If
            End If
            vgExpOrig$ = vgExpOrig$ + x$ + Vl$    'prepara expressão do filtro
         Else
            vgExpOrig$ = vgExpOrig$ + " " + vgOp$ + " " + Chr(39) + Vl$ + IIf(vgOpOrig = "L", "*", "") + Chr(39) 'vamos procurar com Like
         End If
      End If
   End If
   If Not vgJaFez And vgOpOrig = "B" Then
      vgOp = "<="
      vgConteudo1 = vgConteudo2
      vgJaFez = True
      GoTo OutraVez
   End If
   MontaExpressaoFiltro$ = vgExpOrig
End Function

'grava log des atualizações nas tabelas feitas pelo usuário
Public Sub GeraLog(F As Form, vgSit As Integer, Optional IndGrid As Integer = -1, Optional GravaDadosAnt As Boolean)
   Dim i As Integer, vgArqLog As String, vgRet As Long, vgHandleArqLog As Integer, x As String
   Dim vgLin As String, vgPosAlteracao As Double, vgNInd As String
   Dim vgCamposChave As String, j As Integer, vgSep As String, vgGrvLog As Boolean, vgTab As Object, vgIdentTb As String
   On Error Resume Next
   If IndGrid >= 0 Then
      Set vgTab = F.Grid(IndGrid).RecordSet
      vgIdentTb$ = vgTab.Name
   Else
      Set vgTab = F.vgTb
      vgIdentTb$ = F.vgIdentTab
   End If
   If Err Then
      Err.Clear
      vgIdentTb$ = ExtraiSQL(vgTab.Source, EXP_FROM)
   End If
   vgSit = Abs(vgSit)
   On Error GoTo DeuErro
   vgSep$ = Chr(160)
   vgArqLog$ = Left$(vgConsultaINI$, Rat(vgConsultaINI$, "\" ))
   vgArqLog$ = vgArqLog$ + vgAliasDb$(1) + ".Lag"
   vgRet = PreparaArqLog
   If vgRet > 0 Then Error vgRet
   vgIdentTb$ = Retira(vgIdentTb$, "[]", UM_A_UM)
   If GravaDadosAnt Or vgSit = ACAO_INCLUINDO Then
      ReDim vgDadosAntTabela(vgDb.Tables(vgIdentTb$).Columns.Count) As String  'vamos redimencionar o vetor que receberá os dados antes da gravação
      ReDim vgDadosPostTabela(vgDb.Tables(vgIdentTb$).Columns.Count) As String 'vamos redimencionar o vetor que receberá os dados depois da gravação
   End If
   If GravaDadosAnt Then
      If vgSit <> ACAO_INCLUINDO Then                                          'se não for preparação para inclusão
         If vgSit <> ACAO_EXCLUINDO Then                                       'se não for preparação para exclusão
            GoSub EncheVetorAntes
         Else
            GoSub EncheVetorDepois
         End If
      End If
   Else
      If vgSit <> ACAO_EXCLUINDO Then                                          'está excluindo...
         GoSub EncheVetorDepois
      End If
      vgLin$ = Format(Now, "yyyy/mm/dd hh:mm") + vgSep$                        'data e hora
      vgLin$ = vgLin$ + vgIdentTb$ + vgSep$ + vgPWUsuario$ + vgSep$            'nome da tabela e usuário
      vgLin$ = vgLin$ + "[" + Mid("IME", vgSit - 1, 1) + "]" + vgSep$          'tipo da operação
      vgCamposChave$ = ""

      'se estiver editando... pega o nome dos campos que compõem o índice primário
      If vgSit = ACAO_EDITANDO Then
   
         'Vamos achar o indice primario
         For j = 1 To vgDb.Tables(vgIdentTb$).Indexes.Count
            If vgDb.Tables(vgIdentTb$).Indexes(1).IndexType = TYPE_Primary Then
               vgNInd$ = vgDb.Tables(vgIdentTb$).Indexes(j).Name
               Exit For
            End If
         Next

         If Len(vgNInd$) > 0 Then
            vgCamposChave$ = ";"
            For j = 1 To vgDb.Tables(vgIdentTb$).Indexes(vgNInd$).Columns.Count
               vgCamposChave$ = UCase(vgCamposChave$ + vgDb.Tables(vgIdentTb$).Indexes(vgNInd$).Columns(j).Name + ";")
            Next
         End If
      End If

      vgGrvLog = (vgSit <> ACAO_EDITANDO)
      x$ = ""
      For i = 1 To vgDb.Tables(vgIdentTb$).Columns.Count
         If vgDb.Tables(vgIdentTb$).Columns(i).ColumnType <> TP_BINARIO And Not vgDb.Tables(vgIdentTb$).Columns(i).Hidden Then 'imagem ou campo invisivel não pode
               If vgDadosAntTabela$(i) <> vgDadosPostTabela$(i) Or vgSit <> ACAO_EDITANDO Or InStr(vgCamposChave$, UCase(";" + vgDb.Tables(vgIdentTb$).Columns(i).Name + ";" )) > 0 Then
                  If vgDb.Tables(vgIdentTb$).Columns(i).ColumnType = TP_MEMO Then
                     GoSub PegaPos
                  End If
                  If vgSit = ACAO_EDITANDO And vgDadosAntTabela$(i) <> vgDadosPostTabela$(i) Then
                     vgGrvLog = True
                     If vgDb.Tables(vgIdentTb$).Columns(i).ColumnType = TP_MEMO Then
                        If vgPosAlteracao > 1 Then x$ = x$ + "..."
                        x$ = x$ + Mid$(vgDadosAntTabela$(i), vgPosAlteracao, 50) + " " + Chr(187) + " "
                        If Len(Mid$(vgDadosPostTabela$(i), vgPosAlteracao)) > 50 Then x$ = x$ + "..."
                     Else
                        x$ = x$ + vgDadosAntTabela$(i) + " " + Chr$(187) + " "
                     End If
                  End If
                  If vgDb.Tables(vgIdentTb$).Columns(i).ColumnType = TP_MEMO Then
                     x$ = x$ + Mid$(vgDadosPostTabela$(i), vgPosAlteracao, 50)
                     If Len(Mid(vgDadosPostTabela$(i), vgPosAlteracao)) > 50 Then x$ = x$ + "..."
                  Else
                     x$ = x$ + vgDadosPostTabela$(i)
                  End If
               End If
               vgLin$ = vgLin$ + x$
         End If 
         x$ = vgSep$
      Next
      If vgGrvLog Then
         vgHandleArqLog = FreeFile
         Open vgArqLog For Append As vgHandleArqLog
         Print #vgHandleArqLog, Cript$(vgLin$, vgSenhaLog$(1))
         Close vgHandleArqLog
      End If 
   End If
   Exit Sub
   
PegaPos:
   For vgPosAlteracao = 1 To Len(vgDadosAntTabela$(i))
      If Mid(vgDadosAntTabela$(i), vgPosAlteracao, 1) <> Mid(vgDadosPostTabela$(i), vgPosAlteracao, 1) Then                    'achou uma posição diferente
         Exit For
      End If
   Next
   If vgPosAlteracao > 5 Then
      vgPosAlteracao = vgPosAlteracao - 5
   Else
      vgPosAlteracao = 1
   End If
   Return
   
EncheVetorAntes:
   For i = 1 To vgDb.Tables(vgIdentTb$).Columns.Count
      If vgDb.Tables(vgIdentTb$).Columns(i).ColumnType <> TP_BINARIO And Not vgDb.Tables(vgIdentTb$).Columns(i).Hidden Then    'imagem ou campo invisivel não pode
         If Not IsNull(vgTab.Fields(vgDb.Tables(vgIdentTb$).Columns(i).Name)) Then
            vgDadosAntTabela$(i) = CStr(vgTab.Fields(vgDb.Tables(vgIdentTb$).Columns(i).Name).Value & "")
         End If
      End If
   Next
   Return
   
EncheVetorDepois:
   For i = 1 To vgDb.Tables(vgIdentTb$).Columns.Count
      If vgDb.Tables(vgIdentTb$).Columns(i).ColumnType <> TP_BINARIO And Not vgDb.Tables(vgIdentTb$).Columns(i).Hidden Then    'imagem ou campo invisivel não pode
         If Not IsNull(vgTab.Fields(vgDb.Tables(vgIdentTb$).Columns(i).Name)) Then
            vgDadosPostTabela$(i) = CStr(vgTab.Fields(vgDb.Tables(vgIdentTb$).Columns(i).Name).Value & "")
         End If
      End If
   Next
   Return
   
DeuErro:
   If vgHandleArqLog >= 0 Then
      Close vgHandleArqLog
   End If
   CErr.NumErro = Err
   CErr.Show
   Err.Clear
End Sub

'grava arquivo de log de ações dos usuários
Public Sub GeraLogAcao(vgAcao As String)
   Dim vgArqLog As String, vgRet As Long, vgHandleArqLog As Integer, _
       vgLin As String, vgSep As String
   On Error GoTo DeuErro
   vgSep$ = Chr(160)
   vgArqLog$ = Left$(vgConsultaINI$, Rat(vgConsultaINI$, "\" ))
   vgArqLog$ = vgArqLog$ + vgAliasDb$(1) + ".Lag"
   vgRet = PreparaArqLog
   If vgRet > 0 Then Error vgRet
   vgLin$ = Format(Now, "yyyy/mm/dd hh:mm") + vgSep$                    'data e hora
   vgLin$ = vgLin$ + LoadGasString(1140) + vgSep$ + vgPWUsuario$ + vgSep$ 'nome da tabela e usuário
   vgLin$ = vgLin$ + "[A]" + vgSep$ + vgAcao$                             'tipo da operação + ação 
   vgHandleArqLog = FreeFile
   Open vgArqLog For Append As vgHandleArqLog
   Print #vgHandleArqLog, Cript$(vgLin$, vgSenhaLog$(1))
   Close vgHandleArqLog
   Exit Sub

DeuErro:
   If vgHandleArqLog >= 0 Then
      Close vgHandleArqLog
   End If
   CErr.NumErro = Err
   CErr.Show
   Err.Clear
End Sub

'incializa arquivo de log da aplicação
Private Function PreparaArqLog() As Long
   Dim vgArqLog As String, vgHandleArqLog As Integer, i As Integer, j As Integer, _
       vgLin As String, vgSep As String
   On Error GoTo DeuErro
   vgSep$ = Chr(160)
   vgArqLog$ = Left$(vgConsultaINI$, Rat(vgConsultaINI$, "\"))
   vgArqLog$ = vgArqLog$ + vgAliasDb$(1) + ".Lag"
   vgHandleArqLog = FreeFile
   If Not Existe(vgArqLog$) Then
      Open vgArqLog$ For Output As vgHandleArqLog                    'vamos criar o arquivo em branco
      
      'vamos criar o header para o arquivo de log
      Print #vgHandleArqLog, Cript("Aplicação = " + vgNomeSistema$, vgSenhaLog$(1)) 'grava o nome de cada campo
      For i = 1 To vgDb.Tables.Count                                                'para cada tabela do banco
         With vgDb.Tables(i)
            If Not .System And Not .Hidden Then                                     'não é tabela de sistema e se não for tabela invisível
               vgLin$ = "*" + .Name + vgSep$                                        'nome da tabela 
               For j = 1 To .Columns.Count                                          'para cada campo da tabela
                  If .Columns(j).ColumnType <> TP_BINARIO And Not .Columns(j).Hidden Then 'imagem ou campo invisivel não pode
                     If j > 1 Then vgLin$ = vgLin$ + ";"
                     vgLin$ = vgLin$ + .Columns(j).Name                                   'grava o nome de cada campo
                  End If
               Next
               Print #vgHandleArqLog, Cript$(vgLin$, vgSenhaLog$(1))                      'grava o nome da tabela
            End If
         End With
      Next

      'coloca ação executada
      vgLin$ = "*" + LoadGasString(1140) + vgSep$ + LoadGasString(1141)
      Print #vgHandleArqLog, Cript$(vgLin$, vgSenhaLog$(1))

      Close vgHandleArqLog
   End If
   PreparaArqLog = 0
   Exit Function
   
DeuErro:
   If vgHandleArqLog >= 0 Then
      Close vgHandleArqLog
   End If
   PreparaArqLog = Err.Number
End Function

'função que converte valor inteiro em GHex
'iValue - Valor inteiro a ser convertido
'iDigits - Quantidade de dígitos que deve ter o valor retornado
Public Function GHex(lValue As Long, Optional ByVal iDigits As Integer = 3) As String
      Dim sHex As String
      Dim sSignificant As String
      sHex = Hex$(lValue)                                    'valor convertido em hexadecimal
      If Len(sHex$) > iDigits Then Err.Raise 6, "GHex", "Overflow"
      sHex = LPad$(sHex$, iDigits, "0")                      'acrescentados zeros à esquerda
      sSignificant = Chr(Val("&H" & Left(sHex, 1)) + 65)     'valor significativo, padrão GAS Hex
      GHex = sSignificant & Right(sHex, iDigits - 1)         'retorno do valor no padrão GAS Hex
End Function

'função que converte de GHex para decimal
'sGHexValue - valor no padrão GHex a ser convertido
Public Function GHexToDecimal(sGHexValue As String) As Integer
   Dim sSignificant As String
   sSignificant = Asc(Left$(sGHexValue, 1)) - 65            'valor do dígito significativo
   GHexToDecimal = Val("&H" & Hex$(sSignificant) & Right(sGHexValue, Len(sGHexValue) - 1)) 'retorno do valor no sistema decimal
End Function
