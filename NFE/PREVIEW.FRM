VERSION 5.00
Begin VB.Form frmPreview
   AutoRedraw      =   -1  'True
   ClientHeight    =   5370
   ClientLeft      =   2505
   ClientTop       =   1935
   ClientWidth     =   8055
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   ScaleHeight     =   5370
   ScaleWidth      =   8055
   Begin VB.TextBox txtFixa
      Appearance      =   0  'Flat
      Height          =   615
      Index           =   0
      Left            =   1050
      MultiLine       =   -1  'True
      TabIndex        =   24
      Top             =   3450
      Visible         =   0   'False
      Width           =   1635
   End
   Begin VB.PictureBox picExterna
      Height          =   2865
      Left            =   60
      ScaleHeight     =   2805
      ScaleWidth      =   3075
      TabIndex        =   9
      Top             =   420
      Width           =   3135
      Begin VB.PictureBox picInterna
         AutoSize        =   -1  'True
         BackColor       =   &H00800000&
         BorderStyle     =   0  'None
         Height          =   2385
         Left            =   90
         ScaleHeight     =   2385
         ScaleWidth      =   2745
         TabIndex        =   10
         Top             =   120
         Width           =   2745
         Begin VB.PictureBox picPreview
            Appearance      =   0  'Flat
            AutoRedraw      =   -1  'True
            BackColor       =   &H00FFFFFF&
            BorderStyle     =   0  'None
            ForeColor       =   &H80000008&
            Height          =   825
            Left            =   180
            MousePointer    =   99  'Custom
            ScaleHeight     =   825
            ScaleWidth      =   915
            TabIndex        =   11
            Top             =   150
            Width           =   915
         End
      End
   End
   Begin VB.VScrollBar scrV
      Height          =   915
      LargeChange     =   10
      Left            =   3270
      Max             =   -100
      TabIndex        =   8
      TabStop         =   0   'False
      Top             =   1080
      Width           =   255
   End
   Begin VB.HScrollBar scrH
      Height          =   255
      LargeChange     =   10
      Left            =   3360
      Max             =   -100
      TabIndex        =   7
      TabStop         =   0   'False
      Top             =   600
      Width           =   945
   End
   Begin VB.PictureBox picTools
      Align           =   1  'Align Top
      Appearance      =   0  'Flat
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   405
      Left            =   0
      ScaleHeight     =   405
      ScaleWidth      =   8055
      TabIndex        =   2
      Top             =   0
      Width           =   8055
      Begin NFE.GBotao botTamaPg
         Height          =   390
         Index           =   0
         Left            =   3780
         TabIndex        =   22
         Top             =   0
         Width           =   390
         _ExtentX        =   688
         _ExtentY        =   688
         Enabled         =   0   'False
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851}
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ButtonStyle     =   1
         CaptionOffset   =   50
         ShowFocus       =   0   'False
      End
      Begin NFE.GBotao botTamaPg
         Height          =   390
         Index           =   1
         Left            =   4170
         TabIndex        =   19
         Top             =   0
         Width           =   390
         _ExtentX        =   688
         _ExtentY        =   688
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851}
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ButtonStyle     =   1
         CaptionOffset   =   50
         ShowFocus       =   0   'False
      End
      Begin NFE.GBotao botTamaPg
         Height          =   390
         Index           =   2
         Left            =   4560
         TabIndex        =   20
         Top             =   0
         Width           =   390
         _ExtentX        =   688
         _ExtentY        =   688
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851}
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ButtonStyle     =   1
         CaptionOffset   =   50
         ShowFocus       =   0   'False
      End
      Begin NFE.GBotao botPag
         Height          =   285
         Left            =   7350
         TabIndex        =   16
         Top             =   90
         Width           =   285
         _ExtentX        =   503
         _ExtentY        =   503
         ForeColor       =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851}
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ButtonStyle     =   1
         ShowFocus       =   0   'False
      End
      Begin NFE.GBotao botFecha
         Height          =   390
         Left            =   5010
         TabIndex        =   3
         Top             =   0
         Width           =   390
         _ExtentX        =   688
         _ExtentY        =   688
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851}
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ButtonStyle     =   1
         CaptionOffset   =   50
         ShowFocus       =   0   'False
      End
      Begin NFE.GBotao botImprime
         Height          =   390
         Left            =   2430
         TabIndex        =   18
         Top             =   0
         Width           =   390
         _ExtentX        =   688
         _ExtentY        =   688
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851}
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ButtonStyle     =   1
         CaptionOffset   =   50
         ShowFocus       =   0   'False
      End
      Begin NFE.GBotao botImpFolha
         Height          =   390
         Left            =   2040
         TabIndex        =   4
         Top             =   0
         Width           =   390
         _ExtentX        =   688
         _ExtentY        =   688
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851}
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ButtonStyle     =   1
         CaptionOffset   =   50
         ShowFocus       =   0   'False
      End
      Begin NFE.GBotao botPrimeiro
         Height          =   390
         Left            =   30
         TabIndex        =   12
         Top             =   0
         Width           =   390
         _ExtentX        =   688
         _ExtentY        =   688
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851}
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ButtonStyle     =   1
         CaptionOffset   =   50
         ShowFocus       =   0   'False
      End
      Begin NFE.GBotao botVolta
         Height          =   390
         Left            =   420
         TabIndex        =   6
         Top             =   0
         Width           =   390
         _ExtentX        =   688
         _ExtentY        =   688
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851}
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ButtonStyle     =   1
         CaptionOffset   =   50
         ShowFocus       =   0   'False
      End
      Begin NFE.GBotao botPara
         Height          =   390
         Left            =   810
         TabIndex        =   17
         Top             =   0
         Width           =   390
         _ExtentX        =   688
         _ExtentY        =   688
         Enabled         =   0   'False
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851}
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MousePointer    =   1
         ButtonStyle     =   1
         CaptionOffset   =   50
         ShowFocus       =   0   'False
      End
      Begin NFE.GBotao botMais
         Height          =   390
         Left            =   1200
         TabIndex        =   5
         Top             =   0
         Width           =   390
         _ExtentX        =   688
         _ExtentY        =   688
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851}
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ButtonStyle     =   1
         CaptionOffset   =   50
         ShowFocus       =   0   'False
      End
      Begin NFE.GBotao botUltimo
         Height          =   390
         Left            =   1590
         TabIndex        =   13
         Top             =   0
         Width           =   390
         _ExtentX        =   688
         _ExtentY        =   688
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851}
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ButtonStyle     =   1
         CaptionOffset   =   50
         ShowFocus       =   0   'False
      End
      Begin VB.ComboBox cboEscala
         Height          =   315
         Left            =   2880
         TabIndex        =   21
         Top             =   60
         Width           =   825
      End
      Begin VB.TextBox txtPag
         Height          =   285
         Left            =   6660
         TabIndex        =   14
         Top             =   90
         Width           =   675
      End
      Begin VB.Label labPag
         Alignment       =   1  'Right Justify
         Caption         =   "Ir para a página"
         Height          =   255
         Left            =   5370
         TabIndex        =   15
         Top             =   150
         Width           =   1245
      End
   End
   Begin VB.PictureBox picAux
      AutoRedraw      =   -1  'True
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   0  'None
      Height          =   615
      Left            =   1050
      ScaleHeight     =   615
      ScaleWidth      =   975
      TabIndex        =   1
      Top             =   4380
      Visible         =   0   'False
      Width           =   975
   End
   Begin VB.PictureBox picFixa
      AutoRedraw      =   -1  'True
      Height          =   345
      Index           =   0
      Left            =   210
      ScaleHeight     =   285
      ScaleWidth      =   555
      TabIndex        =   0
      Top             =   4710
      Visible         =   0   'False
      Width           =   615
   End
End
Attribute VB_Name = "frmPreview"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'* Sistema...: Emissor de MDF-e (Layout 3.00)
'* Empresa...: Ygor Eduardo Dellalio
'* Módulo....: frmPreview
'* Função....: Previsão de impressão do relatório
'* CopyRight.: (C)2024 Ygor Eduardo Dellalio
'* Criação...: GAS-2007 - Gerador Automático de Sistemas
'* Data......: 05/09/2024 18:10:19
'* * * * * * *

Implements GSubClassInterface

Option Explicit
DefInt A-Z

Const MOSTRA_PG_LARGURA = 1
Const MOSTRA_PG_COMPLETA = 2

Const WHEEL_DELTA = 120

Public vgSituacao As Integer, vgCaracteristica As Integer, _
                     vgTipo As Integer, vgFormID As Long         'propriedades dos forms
Public vgPriVez As Boolean  , vgEmBrowse As Integer
Public vgContaPg As Long, vgUltPagVista As Long, vgProcuraPg As Boolean, vgFimDoArq As Boolean, _
                     vgNovaPag As Long, vgFormRel As Form, vgPagRef As Integer
Public vgTooltips As New cTooltips

Dim vgSubClass As GSubClass

'para manipular linhas memo com sendmessage
Const M_PEGA_QDE_LINHAS = &HBA                    '//memo
Const M_PEGA_UMA_LINHA = &HC4

'extrai uma linha do campo memo     '//memo
Public Function ExtraiLinhaMemo(ByVal Index As Integer, ByVal vgLinha As Long) As String
   Dim i As Long, vgBufLin As String
   vgBufLin$ = Space$(1056)
   i = SendMessage(txtFixa(Index).hWnd, M_PEGA_UMA_LINHA, vgLinha, ByVal vgBufLin$)
   vgBufLin$ = Left$(vgBufLin$, i)                    'acerta o tamanho
   'se tiver só um espaço na frente, tira (resultado de quebra de linha no meio de frase)
   If Len(vgBufLin$) > 1 Then                         'se tem info,
      If Asc(vgBufLin$) = 32 And Asc(Mid$(vgBufLin$, 2)) <> 32 Then
         vgBufLin$ = LTrim$(vgBufLin$)                'tira o espaço da frente
      End If
   End If
   ExtraiLinhaMemo$ = vgBufLin$
End Function

'conta quantas linhas tem o memo   '//memo
Public Function ContaLinhasMemo(ByVal Index As Integer) As Long
   ContaLinhasMemo = SendMessage(txtFixa(Index).hWnd, M_PEGA_QDE_LINHAS, 0, 0) - 1
End Function

Private Sub txtFixa_Change(Index As Integer)
   Dim x As String
   If vgPriVez Then Exit Sub
   vgPriVez = True
   x$ = Rtrim$(txtFixa(Index).Text)               'tira linhas em branco
   If Len(x$) > 0 Then                            'do final do campo
      Do While Right$(x$, 2) = vbCrLf             'memo
         x$ = Rtrim$(Left$(x$, Len(x$) - 2))
      Loop
      txtFixa(Index).Text = x$
   End If
   vgPriVez = False
End Sub

'retorna high word de um long
Private Function HiWord(DWord As Long) As Integer
   Dim vgInts(1 To 2) As Integer
   CopyMemory vgInts(1), DWord, Len(DWord)
   HiWord = vgInts(2)
End Function

Public Sub ShowPreview(Optional ByVal vgOqFazer As Integer)
   Dim vgWid As Single, vgHgt As Single, vgFator As Long
   Screen.MousePointer = vbHourglass
   If vgUltPagVista < vgContaPg Then vgUltPagVista = vgContaPg  'acerta o último acessado...
   'força picpreview ter o tamanho correto
   If IsMissing(vgOqFazer) Or vgOqFazer = 0 Then                'nao mexe com escala,
      vgFator = Val(cboEscala.Text)                             'usa a que está na combo

      'limites da escala
      If vgFator > 500 Then vgFator = 500
      If vgFator < 1 Then vgFator = 5
      vgWid = (picPreview.Width - picPreview.ScaleWidth) + picAux.Width * (vgFator / 100)
      vgHgt = (picPreview.Height - picPreview.ScaleHeight) + picAux.Height * (vgFator / 100)
   Else                                           'está alterando escalas
      If vgOqFazer = MOSTRA_PG_LARGURA Then       'ajusta página na largura da window
         vgWid = IIf(scrV.Visible, scrV.left, ScaleWidth) - 60 'pega larg da janela
         vgHgt = vgWid * picAux.Height / picAux.Width          'faz a altura proporcional...
      ElseIf vgOqFazer = MOSTRA_PG_COMPLETA Then               'temos de mostrar a página completa,
         picInterna.Move 0, 0                                  'acerta o container e
         scrV.Value = 0                                        'sincroniza as barras vertical e
         scrH.Value = 0                                        'horizontal
         If picAux.Width >= picAux.Height Then                 'se form em "landscape"
            vgHgt = ScaleHeight - picTools.Height - 60
            vgWid = vgHgt * picAux.Width / picAux.Height       'e faz a largura proporcional
         End If
         If picAux.Width < picAux.Height Or vgWid > ScaleWidth Then
            vgWid = ScaleWidth - 60
            vgHgt = vgWid * picAux.Height / picAux.Width       'faz a altura proporcional...
            If vgHgt > ScaleHeight Then
               vgHgt = ScaleHeight - picTools.Height - 60
               vgWid = vgHgt * picAux.Width / picAux.Height    'e faz a largura proporcional
            End If
         End If
      Else
         Screen.MousePointer = vbDefault
         Exit Sub                                              'valor inválido, sai
      End If

      'mostra quanto deu de escala...
      cboEscala.Text = Trim$(Str$(vgWid * 100 \ picAux.Width)) + "%"
   End If
   picInterna.Move 0, 0, vgWid, vgHgt                          'acerta posição
   picPreview.Move 0, 0, vgWid, vgHgt
   DoEvents

   'copia para o preview - essas margens não usadas na impressora
   picPreview.PaintPicture picAux.Image, 260, 360, picPreview.ScaleWidth, picPreview.ScaleHeight
   txtPag.Text = Trim$(Str$(vgContaPg))                        'mostra página na textbox
   botPag.Enabled = False                                      'desabilita o botão porque estamos na página da txtbox
   botPara.Enabled = False
   botTamaPg(0).Enabled = (Val(cboEscala.Text) <> 100)         'hab/desabilita ver normal (100%)
   vgProcuraPg = False                                         'reseta flag
   Form_Resize                                                 'acerta barras
   Screen.MousePointer = vbDefault
End Sub

Private Function MontaRet(ByVal L As Long, ByVal T As Long, ByVal w As Long, ByVal h As Long) As RECT
   With MontaRet                                  'acerta o ratangulo da pg
      .Left = L
      .Top = T
      .Right = L + w
      .Bottom = T + h
   End With
End Function

Private Sub botImpFolha_Click()
   vgFormRel.ProssegueExecucao Printer, G_IMP_ATUA_PG    'imprime a página atualmente selecionada...
End Sub

Private Sub botImprime_Click()
   vgFormRel.ProssegueExecucao Printer                   'joga direto na impressora
End Sub

Private Sub botPag_Click()
   vgFormRel.ProssegueExecucao picAux, Val(txtPag.Text)
End Sub

Private Sub botMais_Click()
   vgFormRel.ProssegueExecucao picAux, G_IMP_PROX_PG
End Sub

Private Sub botPara_Click()
   vgProcuraPg = False                            'reseta a flag procurando pg
   botPara.Enabled = False                        'e desabilita este botão
End Sub

Private Sub botPrimeiro_Click()
   vgFormRel.ProssegueExecucao picAux, G_IMP_PRI_PG
End Sub

Private Sub botTamaPg_Click(Index As Integer)
   If Index = 0 Then                              'clicou botão de 100%
      cboEscala.ListIndex = 3                     'então, acerta para 100%
      ShowPreview                                 'e mostra
   Else                                           'senão,
      ShowPreview Index                           'mostra na larg da janela ou completa...
   End If
End Sub

Private Sub botUltimo_Click()
   vgFormRel.ProssegueExecucao picAux, G_IMP_ULT_PG
End Sub

Private Sub botVolta_Click()
   vgFormRel.ProssegueExecucao picAux, G_IMP_ANT_PG
End Sub

Private Sub cboEscala_Click()
   Dim i As Long
   Screen.MousePointer = vbHourglass
   i = Val(cboEscala.Text)                        'pega valor,
   If i < 1 Then i = 5                            'limites da escala
   If i > 500 Then i = 500
   cboEscala.Text = Trim$(i) + "%"                'formata para mostrar
   picPreview.Cls                                 'limpa a imagem antiga
   ShowPreview                                    'mostra o preview
   Screen.MousePointer = vbDefault
End Sub

Private Sub cboEscala_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then                 'se teclou enter no campo escala
      KeyAscii = 0                                'tira o beep e
      cboEscala_Click                             'dispara um clique da combo
   End If
End Sub

Private Sub Form_Activate()
   AtivaForm Me
End Sub

Private Sub Form_Load()
   vgCaracteristica = F_COMUM                            'designa sua característica,
   vgSituacao = ACAO_NAVEGANDO                           'situação e
   vgTipo = TP_FPW                                       'tipo
   vgFormID = 24                                         'identificacao do form
   labPag.Caption = LoadGasString(7500)

   'hint para os controles 
   vgTooltips.Create
   vgTooltips.AddTool botTamaPg(0), 0, LoadGasString(7510)
   vgTooltips.AddTool botTamaPg(1), 0, LoadGasString(7520)
   vgTooltips.AddTool botTamaPg(2), 0, LoadGasString(7530)
   vgTooltips.AddTool botPag, 0, LoadGasString(7540)
   vgTooltips.AddTool botFecha, 0, LoadGasString(7550)
   vgTooltips.AddTool botImprime, 0, LoadGasString(7560)
   vgTooltips.AddTool botImpFolha, 0, LoadGasString(7570)
   vgTooltips.AddTool botPrimeiro, 0, LoadGasString(7580)
   vgTooltips.AddTool botVolta, 0, LoadGasString(7590)
   vgTooltips.AddTool botPara, 0, LoadGasString(7600)
   vgTooltips.AddTool botMais, 0, LoadGasString(7610)
   vgTooltips.AddTool botUltimo, 0, LoadGasString(7620)

   'carrega icones dos botoes

   Set botImprime.Picture = LoadPicture(LoadGasPicture(618))
   Set botImprime.PictureMouseOver = LoadPicture(LoadGasPicture(617))
   Set botImpFolha.Picture = LoadPicture(LoadGasPicture(616))
   Set botImpFolha.PictureMouseOver = LoadPicture(LoadGasPicture(615))
   Set botFecha.Picture = LoadPicture(LoadGasPicture(629))
   Set botFecha.PictureMouseOver = LoadPicture(LoadGasPicture(628))
   Set botTamaPg(0).Picture = LoadPicture(LoadGasPicture(620))
   Set botTamaPg(0).PictureMouseOver = LoadPicture(LoadGasPicture(619))
   Set botTamaPg(0).PictureDisabled = LoadPicture(LoadGasPicture(621))
   Set botTamaPg(1).Picture = LoadPicture(LoadGasPicture(623))
   Set botTamaPg(1).PictureMouseOver = LoadPicture(LoadGasPicture(622))
   Set botTamaPg(1).PictureDisabled = LoadPicture(LoadGasPicture(624))
   Set botTamaPg(2).Picture = LoadPicture(LoadGasPicture(626))
   Set botTamaPg(2).PictureMouseOver = LoadPicture(LoadGasPicture(625))
   Set botTamaPg(2).PictureDisabled = LoadPicture(LoadGasPicture(627))
   Set botPag.Picture = LoadPicture(LoadGasPicture(631))
   Set botPag.PictureMouseOver = LoadPicture(LoadGasPicture(630))
   Set botPag.PictureDisabled = LoadPicture(LoadGasPicture(632))
   Set botPrimeiro.Picture = LoadPicture(LoadGasPicture(601))
   Set botPrimeiro.PictureMouseOver = LoadPicture(LoadGasPicture(600))
   Set botPrimeiro.PictureDisabled = LoadPicture(LoadGasPicture(602))
   Set botVolta.Picture = LoadPicture(LoadGasPicture(604))
   Set botVolta.PictureMouseOver = LoadPicture(LoadGasPicture(603))
   Set botVolta.PictureDisabled = LoadPicture(LoadGasPicture(605))
   Set botPara.Picture = LoadPicture(LoadGasPicture(607))
   Set botPara.PictureMouseOver = LoadPicture(LoadGasPicture(606))
   Set botPara.PictureDisabled = LoadPicture(LoadGasPicture(608))
   Set botMais.Picture = LoadPicture(LoadGasPicture(610))
   Set botMais.PictureMouseOver = LoadPicture(LoadGasPicture(609))
   Set botMais.PictureDisabled = LoadPicture(LoadGasPicture(611))
   Set botUltimo.Picture = LoadPicture(LoadGasPicture(613))
   Set botUltimo.PictureMouseOver = LoadPicture(LoadGasPicture(612))
   Set botUltimo.PictureDisabled = LoadPicture(LoadGasPicture(614))

   Set picPreview.MouseIcon = LoadPicture(LoadGasPicture(2))
   'o usuário vai poder digitar uma escala diretamente aqui...
   'escalas acima de 200 podem demorar muito em máquinas mais lentas...
   With cboEscala                                        'enche com as escalas de 25 em 25
      .Clear
      .AddItem "25%"
      .AddItem "50%"
      .AddItem "75%"
      .AddItem "100%"
      .AddItem "125%"
      .AddItem "150%"
      .AddItem "175%"
      .AddItem "200%"
      .ListIndex = 3                                     'força 100%
   End With
   'abre o form com uma boa área, sem maximizar...
   Move 0, 0, mdiNFE.ScaleWidth - 120, mdiNFE.ScaleHeight - 120

   'vamos instanciar a subclasse para interceptar o mouse wheel
   Set vgSubClass = New GSubClass
   vgSubClass.SubClass Me.hwnd, Me
   vgSubClass.AddMessage Me.hwnd, WM_MOUSEWHEEL, MSG_AFTER

End Sub

'Vamos fazer atalhos para os botões da barra
Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
   Select Case KeyCode
      Case vbKeySpace                             'espaço... cancela a procura de página
         If botPara.Enabled Then botPara_Click
      Case vbKeyF5
         If botPrimeiro.Enabled Then botPrimeiro_Click
      Case vbKeyF6
         If botVolta.Enabled Then botVolta_Click
      Case vbKeyF7
         If botMais.Enabled Then botMais_Click
      Case vbKeyF8
         If botUltimo.Enabled Then botUltimo_Click
      Case vbKeyDown                              'move para baixo
         If scrV.Value > scrV.Max Then scrV.Value = scrV.Value - (10 + (scrV.Value Mod 10))
      Case vbKeyUp                                'move para cima
         If scrV.Value <= -10 Then scrV.Value = scrV.Value + (10 - (scrV.Value Mod 10))
      Case vbKeyRight                             'move para direita
         If scrH.Value > scrV.Max Then scrH.Value = scrH.Value - (10 + (scrH.Value Mod 10))
      Case vbKeyLeft                              'move para esquerda
         If scrH.Value <= -10 Then scrH.Value = scrH.Value + (10 - (scrH.Value Mod 10))
      Case vbKeyPageDown                          'move para o último ponto da página
         scrV.Value = scrV.Max
      Case vbKeyPageUp                            'move para o primeiro ponto da página
         scrV.Value = scrV.min
      Case vbKeyHome                              'move para o início (horizontal)
         scrH.Value = scrH.min
      Case vbKeyEnd                               'move para o fim (horizontal)
         scrH.Value = scrH.Max
      Case vbKeyAdd                               'aumenta o zoom
         If cboEscala.ListIndex < cboEscala.ListCount - 1 Then cboEscala.ListIndex = cboEscala.ListIndex + 1
      Case vbKeySubtract                          'diminui o zoom
         If cboEscala.ListIndex > 0 Then cboEscala.ListIndex = cboEscala.ListIndex - 1
      Case vbKeyP                                 'quer imprimir?
         If Shift = 4 Then                        'ALT, página atual
            If MsgBox(LoadGasString(7506), vbQuestion + vbYesNo, vgAtencao$) = vbYes Then botImpFolha_Click
         ElseIf Shift = 2 Then                    'CTRL, relatório inteiro
            If MsgBox(LoadGasString(7507), vbQuestion + vbYesNo, vgAtencao$) = vbYes Then botImprime_Click
         End If
      Case vbKeyEscape                            'quer abandonar o preview
         KeyCode = 0
         DoEvents                                 'deixa o Windows trabalhar...
         botFecha_Click                           'finaliza o preview
   End Select
End Sub

Private Sub GSubClassInterface_WndProc(ByVal lHwnd As Long, ByVal message As GSCMessage, wParam As Long, lParam As Long, ByVal bBefore As Boolean, bCancel As Boolean, lReturn As Long)
   Dim vgValue As Long
   If message = WM_MOUSEWHEEL Then
      vgValue = HiWord(wParam)
      scrV.Value = scrV.Value + 5 * (vgValue / WHEEL_DELTA)
   End If
End Sub

Private Sub Form_Resize()
   Dim Q_wid As Single                            'dimensiona locais
   Dim Q_hgt As Single
   Dim Mais_wid As Single
   Dim Mais_hgt As Single
   Dim Poe_scrH As Boolean
   Dim Poe_scrV As Boolean
   If WindowState = vbMinimized Then Exit Sub     'se minimizado nada fazemos
   'calcula qde necessária na largura e altura
   Mais_wid = picPreview.Width + (picInterna.Width - picInterna.ScaleWidth) + 30
   Mais_hgt = picPreview.Height + (picInterna.Height - picInterna.ScaleHeight) + 30
   Q_wid = ScaleWidth
   Q_hgt = ScaleHeight - picTools.Height

   'verifica qual scroll bar precisamos
   Poe_scrH = (Mais_wid > Q_wid)                  'designa flag para scr horizontal
   If Poe_scrH Then                               'vamos ter scr horizontal
      Q_hgt = Q_hgt - scrH.Height                 'calcula altura
   End If
   Poe_scrV = (Mais_hgt > Q_hgt)                  'designa flag para scr vertical
   If Poe_scrV Then                               'vamos ter scr vertical,
      Q_wid = Q_wid - scrV.Width                  'recalcula qde largura, descontando o controle
      If Not Poe_scrH Then                        'se não tem scr horizontal
         Poe_scrH = (Mais_wid > Q_wid)            'reavalia a flag scr horizontal
         If Poe_scrH Then                         'se tem scr horizontal,
            Q_hgt = Q_hgt - scrH.Height           'recalcula descontando o controle
         End If
      End If
   End If
   If Q_hgt < Screen.TwipsPerPixelX Then          'altura mínima
      Q_hgt = Screen.TwipsPerPixelX
   End If
   If Q_wid < Screen.TwipsPerPixelY Then          'largura mínima
      Q_wid = Screen.TwipsPerPixelY
   End If
   picExterna.Move 0, picTools.Height, Q_wid, Q_hgt
   If Poe_scrH Then
      scrH.Move 0, Q_hgt + picTools.Height, Q_wid
      scrH.Visible = True
   Else
      scrH.Visible = False
      scrH.Value = 0
   End If
   If Poe_scrV Then
      scrV.Move Q_wid, picTools.Height, scrV.Width, Q_hgt
      scrV.Visible = True
   Else
      scrV.Visible = False
      scrV.Value = 0
   End If
   scrH_Change                                    'ajusta scroll
   scrV_Change
   If scrH.Visible And scrV.Visible Then          'tendo os dois controles de scroll
      Cls                                         'limpa o form e desenha o size grip
      DrawFrameControl hdc, MontaRet(ScaleWidth / Screen.TwipsPerPixelX - 15, ScaleHeight / Screen.TwipsPerPixelY - 15, 15, 15), &H3, &H8 'desenha grip size
   End If
End Sub

Private Sub picPreview_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
   Dim i As Long
   i = Val(cboEscala.Text)                        'que valor temos na combo
   If i < 1 Then i = 5                            'limites da escala
   If i > 500 Then i = 500
   If i = 200 And Button = vbLeftButton Or _
      i = 25 And Button = vbRightButton Then      'está num dos limites,
      Exit Sub                                    'cai fora se pedir mais zoom...
   End If
   If cboEscala.ListIndex = -1 Then               'nenhum selecionado, é número digitado...
      If (i Mod 25) <> 0 Then                     'se número diferente da nossa lista
         i = i - (i Mod 25)                       'ajusta para o primeiro menor múltiplo de 25
      End If
   End If
   If Button = vbRightButton Then                 'está voltando a escala...
      i = i + 25 * (i > 25)                       'desconta 25 limitando em 25
   Else                                           'está aumentando a escala
      i = i - 25 * (i < 200)                      'aumenta 25 limitando em 200
   End If
   cboEscala.Text = Trim$(Str$(i))                'ajusta o texto
   cboEscala_Click
End Sub

Private Sub scrH_Change()
   picInterna.left = (((picInterna.Width - (picExterna.Width * 0.8)) * scrH.Value) / 100)  'atualiza valor
End Sub

Private Sub scrH_Scroll()
   picInterna.left = (((picInterna.Width - (picExterna.Width * 0.8)) * scrH.Value) / 100)  'atualiza valor
End Sub

Private Sub scrV_Change()
   picInterna.Top = (((picInterna.Height - (picExterna.Height * 0.8)) * scrV.Value) / 100)  'atualiza valor
End Sub

Private Sub scrV_Scroll()
   picInterna.Top = (((picInterna.Height - (picExterna.Height * 0.8)) * scrV.Value) / 100)  'atualiza valor
End Sub

Private Sub botFecha_Click()
   Me.Hide                                        'esconde of form
   vgFormRel.vgVisivel = True                     'reseta flag
   vgFormRel.Visible = True                       'e mostra form original
End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)
   If UnloadMode = vbFormControlMenu Then             'está fechando pelo X
      Cancel = True                                   'cancela para não descarregar
      vgFormRel.vgVisivel = True                      'reseta flag
      vgFormRel.Visible = True                        'e mostra form original
      Me.Hide                                         'e só esconde
   End If
End Sub

Private Sub Form_Unload(Cancel As Integer)
   vgSubClass.UnSubClass
   Set vgSubClass = Nothing
   Set vgTooltips = Nothing
   Set frmPreview = Nothing                       'libera o segmento de código do form
End Sub

Private Sub txtPag_Change()
   Dim i As Long, Stat As Boolean
   If vgProcuraPg Then Exit Sub                   'em movimento... sai
   i = Val(txtPag.Text)                           'pega valor do txtbox
   Stat = (i > 0 And i <> vgContaPg)              'compara...
   If botPag.Enabled <> Stat Then                 'se ajustou outra página,
      botPag.Enabled = Stat                       'acerta acesso ao botão de pg avulsa
   End If
End Sub

Private Sub txtPag_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn And botPag.Enabled Then
      KeyAscii = 0
      botPag_Click
   End If
End Sub

Private Sub txtPag_LostFocus()
   If Val(txtPag.Text) < 1 Then
      txtPag.Text = Trim$(Str$(vgContaPg))        'página inválida - força a atual
   End If
End Sub
