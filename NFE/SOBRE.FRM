VERSION 5.00
Begin VB.Form frmSobre
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Sobre esta aplicação..."
   ClientHeight    =   2235
   ClientLeft      =   3780
   ClientTop       =   2340
   ClientWidth     =   3495
   ControlBox      =   0   'False
   BeginProperty Font
      name            =   "MS Sans Serif"
      charset         =   0
      weight          =   700
      size            =   8.25
      underline       =   0   'False
      italic          =   0   'False
      strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H80000008&
   Height          =   2640
   Left            =   3720
   LinkTopic       =   "frmSobre"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2235
   ScaleWidth      =   3495
   ShowInTaskbar   =   0   'False
   Top             =   1995
   Width           =   3615
   Begin VB.Label labSobre
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      ForeColor       =   &H80000008&
      Height          =   1215
      Left            =   180
      TabIndex        =   1
      Top             =   60
      Width           =   3135
   End
   Begin NFE.GBotao botOk
      Height          =   450
      Left            =   1560
      TabIndex        =   0
      Top             =   1620
      Width           =   450
   End
   Begin VB.Line Line1
      BorderWidth     =   2
      X1              =   120
      X2              =   3360
      Y1              =   1380
      Y2              =   1380
   End
End
Attribute VB_Name = "frmSobre"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
'* Sistema...: Emissor de MDF-e (Layout 3.00)
'* Empresa...: Ygor Eduardo Dellalio
'* Módulo....: frmSobre
'* Função....: Créditos da aplicação
'* CopyRight.: (C)2024 Ygor Eduardo Dellalio
'* Criação...: GAS-2007 - Gerador Automático de Sistemas
'* Data......: 05/09/2024 18:10:18
'* * * * * * *

Option Explicit                                       'requer variáveis explicitamente declaradas
DefInt A-Z                                            'todas inteiras, por default

Public vgSituacao As Integer, vgCaracteristica As Integer, vgTipo As Integer, vgFormID As Long  'dimensiona públicas deste form
Public vgTooltips As New cTooltips

Private Sub botOk_Click()
   Unload frmSobre                                'clicou botão de fechar o form - então descarrega
End Sub

'carga do form na memória
Private Sub Form_Load()
   Screen.MousePointer = vbHourglass                                 'mouse = ampulheta
   vgFormID = 12                                  'identificacao do form
   labSobre.Caption = vgNomeSistema$ + Chr$(13) + "*" + Chr$(13) + _
                    LoadGasString(8000) + Chr$(13) + vgProjetista$ + Chr$(13) + _
                    LoadGasString(8015) + CStr(App.Major) + "." + _
                    CStr(App.Minor) + "." + CStr(App.Revision) 'monta mensagem
   SET botOk.Picture = LoadPicture(LoadGasPicture(160))        'carrega icone no botão

   'hint para os controles 
   vgTooltips.Create
   vgTooltips.AddTool botOk, 0 , LoadGasString(8020)           'mensagem de ajuda do botão
   vgCaracteristica = F_COMUM                                  'essas variáveis são
   vgSituacao = ACAO_NAVEGANDO                                 'necessárias em todos os forms
   CentraNaTela Me                                             'centraliza na tela
   LeParametrosForm Me                                         'le parâmetros deste form
   Screen.MousePointer = vbDefault                             'restaura ponteiro do mouse
End Sub

Private Sub Form_Unload(Cancel As Integer)
   GravaParametrosForm Me                         'grava parâmetros do form
   Set vgTooltips = Nothing
   Set frmSobre = Nothing                         'libera o segmento de código do form
End Sub
