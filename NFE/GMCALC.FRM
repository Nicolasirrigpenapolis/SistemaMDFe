VERSION 5.00
Begin VB.Form frmGMCalc
   AutoRedraw      =   -1  'True
   BorderStyle     =   0  'None
   ClientHeight    =   1605
   ClientLeft      =   6360
   ClientTop       =   2640
   ClientWidth     =   1740
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1605
   ScaleWidth      =   1740
   ShowInTaskbar   =   0   'False
   Begin VB.CommandButton bot
      BeginProperty Font
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Index           =   24
      Left            =   1260
      MouseIcon       =   "GMCALC.FRX":0000
      MousePointer    =   99  'Custom
      Picture         =   "GMCALC.FRX":030A
      Style           =   1  'Graphical
      TabIndex        =   26
      Top             =   330
      Width           =   300
   End
   Begin VB.CommandButton bot
      BeginProperty Font
         Name            =   "Times New Roman"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Index           =   16
      Left            =   45
      MouseIcon       =   "GMCALC.FRX":0614
      MousePointer    =   99  'Custom
      Picture         =   "GMCALC.FRX":091E
      Style           =   1  'Graphical
      TabIndex        =   0
      Top             =   585
      Width           =   300
   End
   Begin VB.CommandButton bot
      BeginProperty Font
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Index           =   23
      Left            =   1260
      MouseIcon       =   "GMCALC.FRX":0C28
      MousePointer    =   99  'Custom
      Picture         =   "GMCALC.FRX":0F32
      Style           =   1  'Graphical
      TabIndex        =   23
      Top             =   1305
      Width           =   300
   End
   Begin VB.CommandButton bot
      BeginProperty Font
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Index           =   22
      Left            =   1260
      MouseIcon       =   "GMCALC.FRX":123C
      MousePointer    =   99  'Custom
      Picture         =   "GMCALC.FRX":1546
      Style           =   1  'Graphical
      TabIndex        =   22
      Top             =   1080
      Width           =   300
   End
   Begin VB.CommandButton bot
      BeginProperty Font
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Index           =   21
      Left            =   1260
      MouseIcon       =   "GMCALC.FRX":1850
      MousePointer    =   99  'Custom
      Picture         =   "GMCALC.FRX":1B5A
      Style           =   1  'Graphical
      TabIndex        =   21
      Top             =   825
      Width           =   300
   End
   Begin VB.CommandButton bot
      BeginProperty Font
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Index           =   20
      Left            =   1260
      MouseIcon       =   "GMCALC.FRX":1E64
      MousePointer    =   99  'Custom
      Picture         =   "GMCALC.FRX":216E
      Style           =   1  'Graphical
      TabIndex        =   20
      Top             =   585
      Width           =   300
   End
   Begin VB.CommandButton bot
      BeginProperty Font
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Index           =   19
      Left            =   45
      MouseIcon       =   "GMCALC.FRX":2478
      MousePointer    =   99  'Custom
      Picture         =   "GMCALC.FRX":2782
      Style           =   1  'Graphical
      TabIndex        =   19
      Top             =   1305
      Width           =   300
   End
   Begin VB.CommandButton bot
      BeginProperty Font
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Index           =   18
      Left            =   45
      MouseIcon       =   "GMCALC.FRX":2A8C
      MousePointer    =   99  'Custom
      Picture         =   "GMCALC.FRX":2D96
      Style           =   1  'Graphical
      TabIndex        =   18
      Top             =   1065
      Width           =   300
   End
   Begin VB.CommandButton bot
      BeginProperty Font
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Index           =   17
      Left            =   45
      MouseIcon       =   "GMCALC.FRX":30A0
      MousePointer    =   99  'Custom
      Picture         =   "GMCALC.FRX":33AA
      Style           =   1  'Graphical
      TabIndex        =   17
      Top             =   825
      Width           =   300
   End
   Begin VB.CommandButton bot
      BeginProperty Font
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Index           =   15
      Left            =   960
      MouseIcon       =   "GMCALC.FRX":36B4
      MousePointer    =   99  'Custom
      Picture         =   "GMCALC.FRX":39BE
      Style           =   1  'Graphical
      TabIndex        =   16
      Top             =   330
      Width           =   300
   End
   Begin VB.CommandButton bot
      BeginProperty Font
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Index           =   14
      Left            =   660
      MouseIcon       =   "GMCALC.FRX":3CC8
      MousePointer    =   99  'Custom
      Picture         =   "GMCALC.FRX":3FD2
      Style           =   1  'Graphical
      TabIndex        =   15
      Top             =   330
      Width           =   300
   End
   Begin VB.CommandButton bot
      BeginProperty Font
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Index           =   13
      Left            =   360
      MouseIcon       =   "GMCALC.FRX":42DC
      MousePointer    =   99  'Custom
      Picture         =   "GMCALC.FRX":45E6
      Style           =   1  'Graphical
      TabIndex        =   14
      Top             =   330
      Width           =   300
   End
   Begin VB.CommandButton bot
      BeginProperty Font
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Index           =   12
      Left            =   45
      MouseIcon       =   "GMCALC.FRX":48F0
      MousePointer    =   99  'Custom
      Picture         =   "GMCALC.FRX":4BFA
      Style           =   1  'Graphical
      TabIndex        =   13
      Top             =   330
      Width           =   300
   End
   Begin VB.CommandButton bot
      BeginProperty Font
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Index           =   11
      Left            =   960
      MouseIcon       =   "GMCALC.FRX":4F04
      MousePointer    =   99  'Custom
      Style           =   1  'Graphical
      TabIndex        =   12
      Top             =   585
      Width           =   300
   End
   Begin VB.CommandButton bot
      BeginProperty Font
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Index           =   10
      Left            =   660
      MouseIcon       =   "GMCALC.FRX":520E
      MousePointer    =   99  'Custom
      Style           =   1  'Graphical
      TabIndex        =   11
      Top             =   585
      Width           =   300
   End
   Begin VB.CommandButton bot
      BeginProperty Font
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Index           =   9
      Left            =   360
      MouseIcon       =   "GMCALC.FRX":5518
      MousePointer    =   99  'Custom
      Style           =   1  'Graphical
      TabIndex        =   10
      Top             =   585
      Width           =   300
   End
   Begin VB.CommandButton bot
      BeginProperty Font
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Index           =   8
      Left            =   960
      MouseIcon       =   "GMCALC.FRX":5822
      MousePointer    =   99  'Custom
      Style           =   1  'Graphical
      TabIndex        =   9
      Top             =   825
      Width           =   300
   End
   Begin VB.CommandButton bot
      BeginProperty Font
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Index           =   7
      Left            =   660
      MouseIcon       =   "GMCALC.FRX":5B2C
      MousePointer    =   99  'Custom
      Style           =   1  'Graphical
      TabIndex        =   8
      Top             =   825
      Width           =   300
   End
   Begin VB.CommandButton bot
      BeginProperty Font
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Index           =   6
      Left            =   360
      MouseIcon       =   "GMCALC.FRX":5E36
      MousePointer    =   99  'Custom
      Style           =   1  'Graphical
      TabIndex        =   7
      Top             =   825
      Width           =   300
   End
   Begin VB.CommandButton bot
      BeginProperty Font
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Index           =   5
      Left            =   960
      MouseIcon       =   "GMCALC.FRX":6140
      MousePointer    =   99  'Custom
      Style           =   1  'Graphical
      TabIndex        =   6
      Top             =   1065
      Width           =   300
   End
   Begin VB.CommandButton bot
      BeginProperty Font
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Index           =   4
      Left            =   660
      MouseIcon       =   "GMCALC.FRX":644A
      MousePointer    =   99  'Custom
      Style           =   1  'Graphical
      TabIndex        =   5
      Top             =   1065
      Width           =   300
   End
   Begin VB.CommandButton bot
      BeginProperty Font
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Index           =   3
      Left            =   360
      MouseIcon       =   "GMCALC.FRX":6754
      MousePointer    =   99  'Custom
      Style           =   1  'Graphical
      TabIndex        =   4
      Top             =   1065
      Width           =   300
   End
   Begin VB.CommandButton bot
      BeginProperty Font
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Index           =   2
      Left            =   360
      MouseIcon       =   "GMCALC.FRX":6A5E
      MousePointer    =   99  'Custom
      Style           =   1  'Graphical
      TabIndex        =   3
      Top             =   1305
      Width           =   300
   End
   Begin VB.CommandButton bot
      BeginProperty Font
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Index           =   1
      Left            =   660
      MouseIcon       =   "GMCALC.FRX":6D68
      MousePointer    =   99  'Custom
      Style           =   1  'Graphical
      TabIndex        =   2
      Top             =   1305
      Width           =   300
   End
   Begin VB.CommandButton bot
      BeginProperty Font
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Index           =   0
      Left            =   960
      MouseIcon       =   "GMCALC.FRX":7072
      MousePointer    =   99  'Custom
      Style           =   1  'Graphical
      TabIndex        =   1
      Top             =   1305
      Width           =   300
   End
   Begin VB.Label labMemo
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BeginProperty Font
         Name            =   "Arial"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   135
      Left            =   110
      TabIndex        =   25
      Top             =   110
      Width           =   105
   End
   Begin VB.Label lab
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   1  'Fixed Single
      Height          =   255
      Left            =   60
      TabIndex        =   24
      Top             =   60
      Width           =   1515
   End
End
Attribute VB_Name = "frmGMCalc"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
DefInt A-Z

Public CtTransfer As FormataCampos
Public vgCaracteristica As Integer, vgSituacao As Integer, vgFormID As Long, vgTipo As Integer

Private Memoria As Double, Resultado As Double, Display As Double, _
                        EmDecimal As Integer, PosDec As Integer, LimparTudo As Integer, _
                        Operador As Integer, Operando As Integer, Apagar As Integer, _
                        Mascara As String

'constantes dos botões - NÃO MUDAR DE ORDEM...
Const BOT_Igual = 0
Const BOT_Ponto = 1
Const BOT_0 = 2
Const BOT_9 = 11
Const BOT_MemoRec = 12
Const BOT_MemoMenos = 13
Const BOT_MemoMais = 14
Const BOT_MemoClear = 15
Const BOT_TrocaSinal = 16
Const BOT_Perc = 17
Const BOT_Raiz = 18
Const BOT_Limpa = 19
Const BOT_Divide = 20
Const BOT_Vezes = 21
Const BOT_Menos = 22
Const BOT_Mais = 23
Const BOT_Captura = 24

'poe número no display da calculadora
Private Sub PoeNoDisplay(Disp As Double)
   Dim x As String
   x$ = Format$(Disp, Mascara$)                   'formata número conforme sua máscara
   If Len(x$) > Len(Mascara$) Then                'número maior que a máscara
      lab.Caption = "Mask Error"                  'apresenta erro no display
      Display = 0
   Else                                           'formatação ok
      lab.Caption = Left$(x$, Len(Mascara$))      'coloca número mascarado no display
   End If
End Sub

'inicializa o display da calculadora
Sub InicializaDisplay()
   PoeNoDisplay Display                           'coloca número no display
   EmDecimal = False                              'onde estamos digitando
   Apagar = False                                 'apaga memória da calculadora
   PosDec = 0                                     'posição das casas decimais
   Operando = 0                                   'operação do momento
   If LimparTudo > 1 Then                         '2a vez que apertar o CE, mata tudo
      Resultado = 0                               'zera o resultado
      LimparTudo = 0                              'retorna a flag ao estado original
   End If
End Sub

'trata números digitados
Sub TrataNumeros(QBotao As Integer)
   Dim i As Integer, QCasas As Integer, x As String, Valor As String, Dec As String
   x$ = lab.Caption                               'display do momento
   i = InStr(x$, vgSpDec$)                        'posição de inicio das casas decimais
   If i > 0 Then                                  'se tem decimais
      Valor$ = Trim$(Left$(x$, i - 1))            'pega a parte inteira
      Dec$ = Trim$(Mid$(x$, i + 1))               'e as decimais
      QCasas = Len(Dec$)                          'qtde de casas decimais
   Else                                           'não tem decimais
      Valor$ = Trim$(x$)                          'tudo é inteiro
      Dec$ = ""
      QCasas = 0
   End If
   While Left$(Valor$, 1) = "0"                   'tira zeros à esq
      Valor$ = Mid$(Valor$, 2)
   Wend
   If Not EmDecimal Then                          'estamos digitando na parte inteira
      If Len(x$) < Len(Mascara$) Then             'só 14 dígitos valem
         Valor$ = Valor$ + Trim$(Str$(bot(QBotao).Caption)) 'concatena número digitado no display
      End If
   Else                                           'digitando na parte decimal
      PosDec = PosDec - (PosDec < QCasas)         'posição a onde está digitando
      Mid$(Dec$, PosDec, 1) = bot(QBotao).Caption 'troca no display
   End If
   PoeNoDisplay ValBrasil(Valor$ + vgSpDec$ + Dec$) 'recoloca o display
   Display = ValBrasil(lab.Caption)                 'pega seu novo valor
End Sub

'manipula os botões da calculadora
Private Sub bot_Click(Index As Integer)
   Select Case Index                              'botão apertado
      Case BOT_Captura                            'captura resultado para o clt principal
         Hide                                     'esconde a calculadora
         Enabled = False
         CtTransfer.SetFocus                      'coloca o foco no ctl principal
         CtTransfer.Text = lab.Caption            'e transporta o resultado para ele
         Exit Sub                                 'cai fora da calculadora

      Case BOT_MemoClear                          'limpa a memória
         Memoria = 0
         Apagar = True
      Case BOT_MemoMais                           'acumula na memória
         Memoria = Memoria + ValBrasil(lab.Caption)
         Apagar = True
      Case BOT_MemoMenos                          'subtrai na memória
         Memoria = Memoria - ValBrasil(lab.Caption)
         Apagar = True
      Case BOT_MemoRec                            'capta memória
         Display = Memoria
         PoeNoDisplay Memoria
         Apagar = False
      Case BOT_Limpa                              'botão CE
         LimparTudo = LimparTudo + 1
         Display = 0
         InicializaDisplay                        'reinicializa display
      Case BOT_Ponto                              'ponto decimal
         If (Operando Or Apagar) And Not EmDecimal Then
            Display = 0
            InicializaDisplay                     'vamos operar
         End If
         Apagar = False
         EmDecimal = True
         PosDec = 0
      Case BOT_TrocaSinal                         'botao +/-
         Display = Display * -1
         PoeNoDisplay Display
         Display = ValBrasil(lab.Caption)         'reatualiza para truncar dec
      Case BOT_Raiz
         Display = Sqr(Display)
         PoeNoDisplay Display
         Display = ValBrasil(lab.Caption)         'reatualiza para truncar dec
         EmDecimal = False
         Apagar = True

      Case BOT_Divide, BOT_Vezes, BOT_Mais, BOT_Menos
         If Not Operando Then                     'se não estava operando
            GoSub TrataIgual                      'força igual antes da próxima operação
         End If
         Operador = Index                         'operação atual
         Resultado = ValBrasil(lab.Caption)
         PoeNoDisplay Display
         Display = ValBrasil(lab.Caption)         'reatualiza para truncar dec
         EmDecimal = False
         Operando = True

      Case BOT_Igual, BOT_Perc                    'botão = ou %
         GoSub TrataIgual

      Case BOT_0 To BOT_9
         LimparTudo = 0                           'a qq número, zera
         If (Operando Or Apagar) And Not EmDecimal Then 'havia apertado um operador
            Display = 0
            InicializaDisplay                           'vamos operar
         End If
         TrataNumeros Index

   End Select

   'habilita botões
   bot(BOT_Raiz).Enabled = (Display >= 0)               'raiz quadrada só de número positivo
   bot(BOT_MemoRec).Enabled = (Memoria > 0)
   bot(BOT_MemoClear).Enabled = (Memoria > 0)
   bot(BOT_MemoMais).Enabled = (Display > 0)
   bot(BOT_MemoMenos).Enabled = (Display > 0)
   labMemo.Caption = Left$("M", Abs(Memoria > 0))
   bot(BOT_Captura).SetFocus                            'foco sempre no captura
   Exit Sub

TrataIgual:
   If Operador <> 0 Then
      Select Case Operador
         Case BOT_Divide
            If Index = BOT_Perc Then
               Display = Resultado / (Display / 100)
            Else
               Display = Resultado / ValBrasil(lab.Caption)
            End If
         Case BOT_Menos
            If Index = BOT_Perc Then
               Display = Resultado - (Resultado * Display / 100)
            Else
               Display = Resultado - ValBrasil(lab.Caption)
            End If
         Case BOT_Vezes
            If Index = BOT_Perc Then
               Display = Resultado * Display / 100
            Else
               Display = Resultado * ValBrasil(lab.Caption)
            End If
         Case BOT_Mais
            If Index = BOT_Perc Then
               Display = Resultado + (Resultado * Display / 100)
            Else
               Display = Resultado + ValBrasil(lab.Caption)
            End If
      End Select
      PoeNoDisplay Display
      Display = ValBrasil(lab.Caption)                  'reatualiza para truncar dec
      EmDecimal = False
      Operando = False
      Operador = 0
      Resultado = 0
      Apagar = True                                     'qdo redigitar, vamos reinicializar display
   End If
   Return

End Sub

'se foco em outro form some com a calculadora
Private Sub Form_Deactivate()
   On Error Resume Next                           'ignora erros
   Hide                                           'esconde a calculadora
   Enabled = False
   CtTransfer.LostFocus                           'coloca foco no controle principal
   Set CtTransfer = Nothing                       'libera memória
End Sub

'esta digitando no teclado numérico
Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
   Dim IndBot As Integer
   Select Case KeyCode
      Case vbKeyEscape                            'ESC descarrega calculadora
         Hide                                     'esconde a calculadora
         Enabled = False
         CtTransfer.SetFocus
         Exit Sub
      Case 96 To 105
         IndBot = KeyCode - 94                    'números de 0 a 9
      Case 187
         IndBot = BOT_Igual
      Case 110
         IndBot = BOT_Ponto
      Case 67
         IndBot = BOT_Limpa
      Case 111
         IndBot = BOT_Divide
      Case 106
         IndBot = BOT_Vezes
      Case 107
         IndBot = BOT_Mais
      Case 109
         IndBot = BOT_Menos
      Case Else
         IndBot = -1
   End Select
   If IndBot >= 0 Then                            'ativa o clique do botão apropriado
      bot_Click (IndBot)
   End If
End Sub

Private Sub Form_Load()
   Dim i As Integer
   vgCaracteristica = F_COMUM                     'caracteristica deste form
   vgSituacao = ACAO_NAVEGANDO                    'situação do form
   vgFormID = 17                                  'identificação do form
   vgTipo = TP_CALC                               'tipo do formulário

   Width = 1635                                   'posição e tamanho do form
   Height = 1620
   Top = 0
   Left = Screen.Width / 2

   'números
   For i = 0 To 11
      bot(i).Caption = Mid$("=" + vgSpDec$ + "0123456789", i + 1, 1)
   Next
End Sub

'inicializa calculadora
Public Sub IniciaCalc()
   Dim i As Integer
   i = InStr(Tag, "|")                            'no tag do form vem
   Display = ValBrasil(Left$(Tag, i - 1))         'o valor inicial e
   Mascara$ = Mid$(Tag, i + 1)                    'a máscara para display
   Memoria = 0

   'acerta alguns botões
   bot(BOT_Ponto).Enabled = (InStr(Mascara$, ".") > 0)
   bot(BOT_MemoRec).Enabled = False               'desabilita botões
   bot(BOT_MemoClear).Enabled = False
   bot(BOT_MemoMais).Enabled = False
   bot(BOT_MemoMenos).Enabled = False
   InicializaDisplay
   Operando = False
   Operador = 0

   'efeitos 3d no form
   DrawWidth = 4
   ForeColor = vbWhite
   Line (0, 0)-(0, ScaleHeight)
   Line (0, 0)-(ScaleWidth, 0)
   ForeColor = vbBlack
   Line (0, ScaleHeight - 1)-(ScaleWidth - 1, ScaleHeight - 1)
   Line (ScaleWidth - 1, 0)-(ScaleWidth - 1, ScaleHeight - 1)
End Sub

Private Sub Form_Unload(Cancel As Integer)
   Set CtTransfer = Nothing                       'destroi objetos
   Set frmGMCalc = Nothing
End Sub
