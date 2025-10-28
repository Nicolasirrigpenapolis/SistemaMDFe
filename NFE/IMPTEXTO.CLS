VERSION 1.0 CLASS
BEGIN
      MultiUse = -1                               'True
END
Attribute VB_Name = "ImprimeTexto"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
' ImprimeTexto
' Classe para impressão de em modo texto usando o Spooler do windows
' Copyright©2003 GAS Informática Ltda
' ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Option Explicit
DefInt A-Z

'declara variáveis
Dim vgHImpre As Long                              'handle da impressora
Dim vgNomeImp As String                           'nome da impressora
Dim vgHTarefa As Long                             'handle da tarefa
Dim vgTitTarefa As String                         'titulo da tarefa
Dim vgNomeArq As String                           'arq saida
Dim vgParaArquivo As Boolean                      'flag - imprime em arquivo
Dim vgImprimindo As Boolean                       'flag
Dim vgReset As String                             'Codigos para inicializacao de impressoras matriciais
Dim vgPrivez As Boolean
Dim vgNovoReset As String

'usadas somente para impressão semelhante ao Clipper (say xx, yyy, zzzzzzz)
'(veja funções ao final desta classe)
Dim vgMaxLinhas  As Integer                       'qde máximo de linhas por página
Dim vgLargLinha  As Integer                       'largura da linha em caracteres
Dim vgBufLinha() As String                        'linha utilizada para impressão igual ao clipper

'para manipular erros
Public Enum ErrosDeImpressao
   ErroAbrindoPrn = vbObjectError + 1             'erro de abertura
   ErroAoImprimir                                 'erro de impressao
End Enum

Public Enum ModoImpressao
   Normal = 1
   CONDENSADO = 2
End Enum

'estrutura do documento
Private Type DOC_INFO_1
   pDocName    As String                          'nome do documento
   pOutputFile As String                          'arquivo de saida
   pDatatype   As String                          'tipo de dado
End Type

'declara Api's na winspool
Private Declare Function ClosePrinter Lib "winspool.drv" (ByVal hPrinter As Long) As Long
Private Declare Function EndPagePrinter Lib "winspool.drv" (ByVal hPrinter As Long) As Long
Private Declare Function EndDocPrinter Lib "winspool.drv" (ByVal hPrinter As Long) As Long
Private Declare Function OpenPrinter Lib "winspool.drv" Alias "OpenPrinterA" (ByVal pPrinterName As String, phPrinter As Long, ByVal pDefault As Long) As Long
Private Declare Function SetJob Lib "winspool.drv" Alias "SetJobA" (ByVal hPrinter As Long, ByVal JobId As Long, ByVal Level As Long, pJob As Any, ByVal Command As Long) As Long
Private Declare Function StartDocPrinter Lib "winspool.drv" Alias "StartDocPrinterA" (ByVal hPrinter As Long, ByVal Level As Long, pDOC_INFO_1 As DOC_INFO_1) As Long
Private Declare Function StartPagePrinter Lib "winspool.drv" (ByVal hPrinter As Long) As Long
Private Declare Function WritePrinter Lib "winspool.drv" (ByVal hPrinter As Long, pBuf As Any, ByVal cdBuf As Long, pcWritten As Long) As Long

'Locais
'~~~~~~

'inicializa a classe
Private Sub Class_Initialize()
   vgNomeImp = Printer.DeviceName
   vgTitTarefa = "Imprimindo de " & App.Title
   AbreImpressora
   vgPrivez = True
   
   'inicializa variaveis para opção igual Clipper
   MaxLinhas = 66                                 '66 linhas por página
   LargLinha = 80                                 '80 chars por linha (normal)
   PreparaBuffer                                  'prepara o buffer da página

End Sub

'substitui caracteres para caracteres acentuados não disponíveis na fonte DOS
Private Function Acentua(ByVal Lin As String) As String
   Dim T1 As String, T2 As String, Ac As String, i As Integer, p As Integer, C As String
   T1$ = "ÀÈàèÁÉÍÓÚáéíóúÇçÂÊÔâêôÃÑÕãñõÜü"                      'tela
   T2$ = "AEaeAEIOUaeiouCcAEOaeoANOanoUu"                      'impressora
   Ac$ = "`````''''''''',,^^^^^^~~~~~~" + Chr$(34) + Chr$(34)  'nosso acento
   p = 1
   For i = 1 To Len(Lin$)                                      'cada letra
      C$ = Mid$(Lin$, i, 1)                                    'pega o char
      p = InStr(T1$, C$)                                       'tem acento correspondente?
      If p Then                                                'tem...
         'troca usando backspace: letra + bs + acento
         Lin$ = Left$(Lin$, i - 1) + _
                Mid$(T2$, p, 1) + _
                Chr$(vbKeyBack) + _
                Mid$(Ac$, p, 1) + _
                Mid$(Lin$, i + 1)                              'troca
         i = i + 2                                             'incrementa ponteiro na string
      End If
   Next
   Lin$ = Substitui(Lin$, Chr(170) + Chr(186) + Chr(176), Chr(166) + Chr(167) + Chr(167), UM_A_UM)
   Acentua$ = Lin$                                             'retorna a linha acentuada na marra...

End Function

'termina
Private Sub Class_Terminate()
   Dim vgErrNum As Long, vgErrDesc As String, vgErrSrc As String

   'salva erro
   vgErrNum = Err.Number
   vgErrDesc = Err.Description
   vgErrSrc = Err.Source
   
   If vgHTarefa <> 0 Then EndDoc                  'termina o documento, se ainda existir aberto
   FechaImpressora                                'fecha a impressora

   'restaura erro
   Err.Number = vgErrNum
   Err.Description = vgErrDesc
   Err.Source = vgErrSrc

End Sub

'inicializa a impressora
Private Sub AbreImpressora()
   If OpenPrinter(vgNomeImp, vgHImpre, 0) = 0 Then
      'dispara erro para a aplicação
      Err.Raise ErroAbrindoPrn, , "Erro ao abrir impressora: " + vgNomeImp
   End If
End Sub

'fecha a impressora
Private Sub FechaImpressora()
   If vgHTarefa <> 0 Then
      EndDoc
   End If
   ClosePrinter vgHImpre
End Sub

'métodos e funções exportados
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~

'liga/desliga impressao para arquivo
Public Property Let ParaArquivo(ByVal mParaArquivo As Boolean)
   vgParaArquivo = mParaArquivo
End Property

'recupera flag de direcionamento
Public Property Get ParaArquivo() As Boolean
   ParaArquivo = vgParaArquivo
End Property

'designa titulo da tarefa
Public Property Let TituloTarefa(ByVal mTituloTarefa As String)
   vgTitTarefa = mTituloTarefa
End Property

'recupera titulo da tarefa
Public Property Get TituloTarefa() As String
   TituloTarefa = vgTitTarefa
End Property

'designa arquivo de saida
Public Property Let ArquivoSaida(ByVal mArquivoSaida As String)
   vgNomeArq = mArquivoSaida
End Property

'recupera nome do arquivo de saída
Public Property Get ArquivoSaida() As String
   ArquivoSaida = vgNomeArq
End Property

'designa nome do dispositivo
Public Property Let NomeDevice(ByVal mNomeDevice As String)
   FechaImpressora
   vgNomeImp = mNomeDevice
   AbreImpressora
End Property

'recupera nome do dispositivo
Public Property Get NomeDevice() As String
   NomeDevice = vgNomeImp
End Property

Public Property Get ResetCode() As String
   ResetCode = vgNovoReset
End Property

Public Property Let ResetCode(ByVal NewResetCode As String)
   vgNovoReset = NewResetCode
End Property

'termina a página corrente
Public Sub EndPage()
   Imprime vbFormFeed                             'pula página
   EndPagePrinter vgHImpre                        'finaliza pg
   vgImprimindo = False                           'reseta flag
End Sub

'finaliza o documento corrente
Public Sub EndDoc()
   EndPagePrinter vgHImpre                        'finaliza pg
   EndDocPrinter vgHImpre                         'finaliza doc
   vgHTarefa = 0                                  'reseta tarefa
   vgPrivez = True
End Sub

'mata o documento corrente
Public Sub KillDoc()
   SetJob vgHImpre, vgHTarefa, 0, ByVal 0&, 3&
   EndDoc
End Sub

'envia informação para a impressora
Public Sub Imprime(ParamArray Args() As Variant)
   Dim vgInfo As String, i As Integer, vgPronto As Long, Pv As Boolean, j As Integer
   PV = False
   If vgHTarefa = 0 Then                          'handle vazio
      Dim DI As DOC_INFO_1
      With DI                                     'cria novo documento e enche estrutura
         If ParaArquivo Then                      'se imprimir para arquivo,
            .pOutputFile = vgNomeArq              'direciona para arquivo
         Else
            .pOutputFile = vbNullString           'nao precisamos dessa
         End If
         .pDatatype = vbNullString                'nulo
         .pDocName = vgTitTarefa                  'titulo da tarefa
      End With
      vgHTarefa = StartDocPrinter(vgHImpre, 1, DI) 'inicia documento
      StartPagePrinter vgHImpre                    'inicia página
      vgImprimindo = True                          'liga flag
      PV = True
      j = vgMaxLinhas
      If j > 255 Then j = 255
      If vgPrivez Then
         If Len(vgNovoReset) > 0 Then
            vgInfo = vgNovoReset
         Else
            vgInfo = vgReset
         End If
         vgPrivez = False
      End If
   End If
   For i = 0 To UBound(Args)                       'pega bytes
      vgInfo = vgInfo + CStr(Args(i))              'monta informação a imprimir
   Next
   vgInfo = Acentua(vgInfo)
   WritePrinter vgHImpre, ByVal vgInfo, Len(vgInfo), vgPronto 'envia informação
   If vgPronto <> Len(vgInfo) Then                            'deu erro...
      'dispara erro para a aplicação
      Err.Raise ErroAoImprimir, , "Erro ao imprimir dados..."
   End If
   PreparaBuffer                                              'prepara novo buffer vazio para impressão = Clipper
End Sub


' As seguintes propriedades e métodos foram criadas para serem usadas
' apenas quando se deseja utilizar sintaxe semelhante ao CA-Clipper
' para a formatação de relatórios TEXTO, com controle de linhas e páginas
' ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

'prepara um buffer vazio para a página inteira
Private Sub PreparaBuffer()
   Dim i As Integer
   Erase vgBufLinha()
   ReDim vgBufLinha(vgMaxLinhas - 1) As String    'vetor de linhas da página
   For i = 0 To vgMaxLinhas - 1
      vgBufLinha(i) = Space$(vgLargLinha)
   Next
End Sub

'ajusta linhas/página
Public Property Let MaxLinhas(ByVal mMaxLinhas As Integer)
   vgMaxLinhas = mMaxLinhas
   vgReset = Chr$(27) + "@" + Chr(27) + "2" + Chr(27) + "C" + Chr(vgMaxLinhas) + Chr(18) + Chr(27) + "k" + Chr(1) + Chr$(27) + "x" + Chr(0) + Chr(27) + "P"
   PreparaBuffer
End Property

'recupera linhas/pg
Public Property Get MaxLinhas() As Integer
   MaxLinhas = vgMaxLinhas
End Property

'ajusta largura da linha em caracteres
Public Property Let LargLinha(ByVal mLargLinha As Integer)
   vgLargLinha = mLargLinha
End Property

'recupera largura/linha
Public Property Get LargLinha() As Integer
   LargLinha = vgLargLinha
End Property

'junta o vetor vgBufLinha em uma só informação a imprimir
Public Function MontaInfo() As String
   Dim RetVal As String, i As Integer
   RetVal$ = ""
   For i = 0 To vgMaxLinhas - 1
      RetVal$ = RetVal$ + Acentua$(RTrim$(vgBufLinha(i))) + vbCrLf  'acentua trimando a direita para acelerar
   Next
   Do While Right(RetVal$, 2) = vbCrLf
      RetVal$ = Left(RetVal$, Len(RetVal$) - 2)
   Loop
   RetVal$ = RetVal$ + Chr$(12) 
   MontaInfo$ = RetVal$
End Function

'prepara informação para ser impressa em linha, coluna
Public Sub Say(vgLin As Integer, vgCol As Integer, vgInfo As Variant)
   Dim St As String
   'previne cair por parâmetro errado... (mandou linha ou col errada, coloca na primeira...)
   If vgLin < 0 Or vgLin > (vgMaxLinhas - 1) Then vgLin = 0
   If vgCol < 0 Or vgCol > (vgLargLinha - 1) Then vgCol = 0
   St$ = CStr(vgInfo)                             'converte para string
   
   vgBufLinha(vgLin) = Left(vgBufLinha(vgLin) + Space(vgLargLinha), vgLargLinha)
   
   'estampa no buffer
   Mid$(vgBufLinha(vgLin), vgCol + 1, Len(St$)) = St$
End Sub

Public Sub Eject()
   Imprime vbFormFeed
End Sub
'\\ Final de ImprimeTexto
