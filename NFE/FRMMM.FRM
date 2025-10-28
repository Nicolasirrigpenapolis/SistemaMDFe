VERSION 5.00
Begin VB.Form frmMM
   BorderStyle     =   5  'Sizable ToolWindow
   Caption         =   "Campo..."
   ClientHeight    =   4665
   ClientLeft      =   3105
   ClientTop       =   1875
   ClientWidth     =   5175
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4665
   ScaleWidth      =   5175
   ShowInTaskbar   =   0   'False
   Begin NFE.GCpMM gmm
      Height          =   1425
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   2145
      _ExtentX        =   1773
      _ExtentY        =   1561
      HasToolBar      =   -1  'True
      ToolBarVisible  =   -1  'True
      SmallChange     =   20
      BeginProperty CaptionFont {0BE35203-8F91-11CE-9DE3-00AA004BB851}
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
End
Attribute VB_Name = "frmMM"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'* Sistema...: Emissor de MDF-e (Layout 3.00)
'* Empresa...: Ygor Eduardo Dellalio
'* Módulo....: frmMM
'* Função....: Mostrar/editar imagens
'* CopyRight.: (C)2024 Ygor Eduardo Dellalio
'* Criação...: GAS-2007 - Gerador Automático de Sistemas
'* Data......: 05/09/2024 18:10:19
'* * * * * * *

Option Explicit
DefInt A-Z
Public vgCaracteristica As Integer, vgTipo As Integer, vgFormID As Long, vgSituacao As Integer

Private Sub Form_Load()
   Dim vgSecaoIni As String
   vgCaracteristica = F_COMUM                             'ajusta característica,
   vgTipo = TP_COMUM                                      'seu tipo
   vgFormID = 23                                          'identificacao do form
   vgSituacao = ACAO_NAVEGANDO                            'e a situação atual neste form
   vgSecaoIni$ = "CONSULTAS"
   gmm.AllowMaximize = False                              'não vai ter botão de maximizar...
   gmm.ToolBarVisible = PegaIntDoIni(vgSecaoIni$, "gMM-botoeira visivel", -1, vgNomeINI$)
End Sub

Private Sub Form_Resize()
   gmm.Move 0, 0, ScaleWidth, ScaleHeight         'acerta controle no form
End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)
   Dim vgOk As Integer
   If gmm.DataChanged Then                        'se alterou midia, confirma gravação
      vgOk = MsgBox(LoadGasString(93), vbExclamation + vbYesNoCancel, vgAtencao)
      If vgOk = vbCancel Then                     'cancelou
         Cancel = True                            'vamos ficar por aqui...
      ElseIf vgOk = vbYes Then                    'quer gravar,
         gmm.SaveWithUpdate                       'salva no bd direto
      ElseIf vgOk <> vbYes Then                   'não quer gravar,
         gmm.DataChanged = False                  'reseta propriedade
      End If
   End If
End Sub

Private Sub gmm_OptionSelected(ByVal Opt As Integer, ByVal TypeImg As Integer, Cancel As Boolean)
   Dim vgSecao As String
   vgSecao$ = "CONSULTA"
   If Opt = 11 Then                               'esconde botões acionados?
      GravaNoIni vgSecao$, "gMM-botoeira visivel", Str$((Not gmm.ToolBarVisible) * 1), vgNomeINI$
   End If
End Sub
