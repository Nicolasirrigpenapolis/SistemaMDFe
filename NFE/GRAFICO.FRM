Version 5.00
Object = "{0A8A0428-822E-11D3-BBEF-444553540000}#1.0#0"; "gPainel2.ocx"
Object = "{0842D103-1E19-101B-9AAF-1A1626551E7C}#1.0#0"; "GRAPH32.OCX"
Begin VB.Form frmGrafico
   Caption         =   "Gráfico"
   ClientHeight    =   3750
   ClientLeft      =   2625
   ClientTop       =   3840
   ClientWidth     =   4755
   Height          =   4155
   Left            =   2565
   LinkTopic       =   "frmGrafico"
   MDIChild        =   -1  'True
   ScaleHeight     =   3750
   ScaleWidth      =   4755
   Top             =   3495
   Width           =   4875
   Begin NFE.GPainel Painel
      Height          =   3495
      Index           =   0
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   4575
      _ExtentX        =   423
      _ExtentY        =   423
      borderwidth     =   0
      bevelinner      =   2
      Begin GraphLib.Graph gra1
         Height          =   2835
         Left            =   240
         TabIndex        =   1
         Top             =   240
         Width           =   4215
         _version        =   65536
         _extentx        =   7435
         _extenty        =   5001
         _stockprops     =   96
         borderstyle     =   1
         autoinc         =   0
         graphstyle      =   6
         graphtype       =   4
         gridstyle       =   3
         numpoints       =   7
         randomdata      =   1
         colordata       =   0
         extradata       =   0
         extradata[]     =   7
         fontfamily      =   4
         fontsize        =   4
         fontsize[0]     =   200
         fontsize[1]     =   150
         fontsize[2]     =   100
         fontsize[3]     =   100
         fontstyle       =   4
         graphdata       =   0
         graphdata[]     =   7
         labeltext       =   0
         legendtext      =   0
         patterndata     =   0
         symboldata      =   0
         xposdata        =   0
         xposdata[]      =   0
      End
   End
End
Attribute VB_Name = "frmGrafico"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
'* Sistema...: Emissor de MDF-e (Layout 3.00)
'* Empresa...: Ygor Eduardo Dellalio
'* Módulo....: frmGrafico
'* Função....: Apresentação de gráfico
'* CopyRight.: (C)2024 Ygor Eduardo Dellalio
'* Criação...: GAS-2007 - Gerador Automático de Sistemas
'* Data......: 05/09/2024 18:10:18
'* * * * * * *

Option Explicit                                   'variáveis têm de ser declaradas explicitamente
DefInt A-Z                                        'por default, todas inteiras

Public vgSituacao As Integer, vgCaracteristica As Integer, vgTipo As Integer   'propriedades genéricas dos forms
Public vgEmBrowse As Integer
Public vgTemFiltro As Integer, vgFormID As Long, vgQueryAtual As String, vgPriVez As Integer  'propriedades deste form

Dim vgGrafDados() As Variant                      'arranjo dinâmico para os dados do gráfico deste form

'salva os dados do gráfico para possibilitar restauração dos mesmos
Public Sub SalvaDados()
   Dim vgNs As Integer, vgNp As Integer, i As Integer  'dimensiona locais
   i = 0                                               'inicializa indexador
   For vgNs = 1 To gra1.NumSets                        'para cada set de dados,
      gra1.ThisSet = vgNs                              'pega um set e,
      For vgNp = 1 To gra1.NumPoints                   'para cada ponto no set
         gra1.ThisPoint = vgNp                         'pega um pondo
         i = i + 1                                     'incrementa o indexador,
         ReDim Preserve vgGrafDados(i)                 'redimensiona preservando e
         vgGrafDados(i) = gra1.GraphData               'armazena os dados do gráfico no nosso vetor
      Next                                             'pega próximo ponto
   Next                                                'pega próximo set
End Sub

'restaura os dados após configuração
Public Sub RestauraDados()
   Dim i As Integer                                  'dimensiona
   For i = 1 To gra1.NumSets * gra1.NumPoints        'joga os dados
      gra1.GraphData = vgGrafDados(i)                'do vetor para o gráfico
   Next
End Sub

Private Sub Form_Activate()
   AtivaForm Me                                      'rotina de inicialização de forms
End Sub

'carga deste form
Private Sub Form_Load()
   Dim vgTMaior As Single, vgLMaior As Single, _
       F As Form                                      'dimensiona locais
   Screen.MousePointer = vbHourglass                  'mouse = ampulheta
   vgCaracteristica = F_GRAFICO                       'ajusta propriedades
   vgSituacao = ACAO_NAVEGANDO                        'deste
   vgTipo = TP_GRAFICO                                'form
   vgFormID = 4                                       'identificacao do form
   vgTemFiltro = False                                'flag - não há filtros
   vgPriVez = False
   vgQueryAtual$ = vgNovaQuery$
   If InStr(vgNovaQuery$, "-") > 0 Then               'título deste form: GRAFICO - xxxxx
      Caption = LoadGasString(2900) + Mid$(vgNovaQuery$, InStr(vgNovaQuery$, "-") + 2)
   Else
      Caption = LoadGasString(2900) + vgNovaQuery$
   End If
   Icon = LoadPicture(LoadGasPicture(265))            'põe ícone no form
   Width = 5430                                       'fixa largura e
   Height = 4400                                      'altura
   CentraNaTela Me                                    'centraliza o form na tela
   vgTMaior = 0                                       'inicializa duas variáveis para
   vgLMaior = 0                                       'controlar as posições das instâncias deste form
   Tag = "EU"                                         'marca quem sou eu (esta instância)

   'se tiver outras instâncias de gráficos na tela, vamos abrí-los defasando...
   For Each F In Forms                                'para cada form existente
      If F.Caption = vgQueryAtual$ And _
       F.vgTipo = TP_GRAFICO And F.Tag <> "EU" Then   'se for de gráfico e não for esta instância
         If F.Top > vgTMaior Or F.Left > vgLMaior Then 'vamos ver quem está mais à direita e
            vgTMaior = F.Top                           'mais abaixo e ajustar as duas
            vgLMaior = F.Left                          'variáveis de posição...
         End If
      End If
   Next
   Tag = ""                                            'desmarca quem sou eu... não precisamos mais...
   If vgTMaior > 0 Then                                'se pegou um topo,
      Move vgLMaior + 300, vgTMaior + 300              'faz cascata, movendo 300 pontos para a direita e para baixo
   End If
   LeParametrosForm Me                                 'lê os parâmetros deste form
   Screen.MousePointer = vbDefault                     'restaura o ponteiro do mouse
End Sub

'usuário está mudando o tamanho do form
Private Sub Form_Resize()
   If WindowState <> vbMinimized Then                                 'se não estiver minimizado
      If Height < 2500 Then Height = 2500                             'limita o tamanho vertical
      If Width < 2500 Then Width = 2500                               'e horizontal
      Painel(0).Move 100, 100, ScaleWidth - 200, ScaleHeight - 200    'ajusta o painel de fundo e
      gra1.Move 100, 100, Painel(0).Width - 200, Painel(0).Height - 200 'também o gráfico sobre o mesmo...
   End If
End Sub

Private Sub Form_Unload(Cancel As Integer)
   FinalizaForm Me                                'executa rotinas de finalização do form
   Set frmGrafico = Nothing                       'libera o segmento de código do form
End Sub

Private Sub gra1_GotFocus()
   PrepBotoes Me, vgSituacao                      'prepara os botões na barra de ferramentas do MDI, para a situação
End Sub

'manipula clique com o botão direito do mouse sobre o gráfico - chama configuração
Private Sub gra1_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
   If Button = vbRightButton Then                 'se for o botão diretito
      If mdiNFE.ActiveForm.Name <> Me.Name Then
         Me.SetFocus
      End If
      If mdiNFE.ActiveForm.Name = Me.Name Then
         frmConfGraf.Show vbModal                 'chama o form de configuração
      End If
   End If
End Sub

