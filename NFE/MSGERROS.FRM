VERSION 5.00
Begin VB.Form frmMsgErros
   AutoRedraw      =   -1  'True
   BorderStyle     =   4  'Fixed ToolWindow
   ClientHeight    =   5910
   ClientLeft      =   4050
   ClientTop       =   2355
   ClientWidth     =   4365
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5910
   ScaleWidth      =   4365
   ShowInTaskbar   =   0   'False
   Begin VB.CommandButton botNotificacao 
      Caption         =   "&Notificar Desenvolvedor"
      Default         =   -1  'True
      Height          =   315
      Left            =   1920
      TabIndex        =   5
      Top             =   5520
      Width           =   2415
   End
   Begin VB.CommandButton botDetalhes
      Caption         =   "&Detalhes >>"
      Height          =   315
      Left            =   3060
      Style           =   1  'Graphical
      TabIndex        =   3
      Top             =   1200
      Width           =   975
   End
   Begin VB.CommandButton botOk
      Caption         =   "&Ok"
      Default         =   -1  'True
      Height          =   315
      Left            =   1620
      TabIndex        =   2
      Top             =   1200
      Width           =   975
   End
   Begin VB.PictureBox picIcon
      AutoRedraw      =   -1  'True
      BorderStyle     =   0  'None
      Height          =   615
      Left            =   120
      ScaleHeight     =   615
      ScaleWidth      =   615
      TabIndex        =   0
      Top             =   180
      Width           =   615
   End
   Begin VB.TextBox txtDetalhes
      Height          =   3555
      Left            =   60
      Locked          =   -1  'True
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   4
      Top             =   1890
      Width           =   4245
   End
   Begin VB.Line Line1 
      BorderWidth     =   2
      X1              =   0
      X2              =   4320
      Y1              =   1755
      Y2              =   1755
   End
   Begin VB.Label labMsg
      Height          =   795
      Left            =   840
      TabIndex        =   1
      Top             =   240
      Width           =   3375
   End
End
Attribute VB_Name = "frmMsgErros"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'* Sistema...: Emissor de MDF-e (Layout 3.00)
'* Empresa...: Ygor Eduardo Dellalio
'* Módulo....: frmMsgErros
'* Função....: Mostra mensagens de erros
'* CopyRight.: (C)2024 Ygor Eduardo Dellalio
'* Criação...: GAS-2007 - Gerador Automático de Sistemas
'* Data......: 05/09/2024 18:10:18
'* * * * * * *

Option Explicit                                      'requer variáveis explicitamente declaradas
DefInt A-Z                                           'inteiras, por default

Public vgSituacao As Integer, vgCaracteristica As Integer, vgTipo As Integer, vgFormID As Long  'dimensiona públicas deste form

Dim CurAtual As Integer

'para pegar icone do stock e colocar na picture
Private Declare Function LoadIconBynum Lib "user32" Alias "LoadIconA" (ByVal hInstance As Long, ByVal lpIconName As Long) As Long
Private Declare Function DrawIcon Lib "user32" (ByVal hdc As Long, ByVal x As Long, ByVal y As Long, ByVal hIcon As Long) As Long

Private Sub botDetalhes_Click()
   Dim i As Integer
   On Error Resume Next
   i = Abs((Height = 2000))
   Height = Choose(i + 1, 2000, 6240)
   botDetalhes.Caption = LoadGasString(11300 + i)
   picIcon.SetFocus
   CentraNaTela Me
End Sub

Private Sub botNotificacao_Click()
   On Error GoTo DeuErro
   Dim vgSaveJPG As IntelJpg
   Dim vgEmail As MAPIClass
   
   Set vgEmail = New MAPIClass
   keybd_event vbKeySnapshot, 0, 0&, 1&
   Set vgSaveJPG = New IntelJpg
      
   vgSaveJPG.CreateFromPicture Clipboard.GetData(vbCFBitmap)
   vgSaveJPG.SaveJPG App.path & "\FigErro.JPG"
   vgEmail.IncluiAttach App.path & "\FigErro.JPG"
   vgEmail.Assunto = "Erro no sistema: " & Me.labMsg

   vgEmail.IncluiDestinatario vgEMailProjetista, vgProjetista, MAPI_Dest_TO
   vgEmail.Mensagem = Me.txtDetalhes
   vgEmail.EnviaEMail
   
   If Len(vgEmail.Erro) Then
      MsgBox "Atenção! Ocorreu erro durante esse processo!" & vbCrLf & vbCrLf & vgEmail.Erro, vbExclamation
   Else
      MsgBox "A tela foi capturada e enviada com sucesso!"
   End If
   
DeuErro:
   Set vgSaveJPG = Nothing
   Set vgEmail = Nothing
   If Err Then
      MsgBox "Atenção! Ocorreu erros durante esse processo!", vbExclamation
      Err.Clear
   End If
End Sub

Private Sub botOk_Click()
   Unload Me                                      'descarrega form de mensagem
End Sub

Private Sub Form_Load()
   Dim IconH As Long, QualIcon As Long, vgErrSource As String, vgErrNumber As Long, vgErrDescription As String, vgErrFinal As String
   vgErrSource = Err.Source
   If CErr.NumErro <> 0 Then
      vgErrNumber = CErr.NumErro
      vgErrDescription = CErr.Description
      vgErrSource = CErr.Origem
      If vgErrNumber = 0 And Err.Number <> 0 And Len(vgErrDescription) = 0 And Len(Err.Description) > 0 Then
         vgErrDescription = "Error: " + Err.Number + IIf(Len(vgErrDescription) > 0, vbCrLf, "") + Err.Description
      End If
   Else
      vgErrNumber = Err.Number
      vgErrDescription = Err.Description
   End If
   vgCaracteristica = F_COMUM                            'designa sua característica,
   vgSituacao = ACAO_NAVEGANDO                           'situação e
   vgTipo = TP_COMUM                                     'tipo
   vgFormID = 25                                         'identificacao do form
   CurAtual = Screen.MousePointer
   Height = 6240                                         'ajusta dimensões
   Caption = CErr.Titulo                                 'ajusta o título
   QualIcon = CErr.Tipo                                  'cria identificação do ícone para chamar API
   IconH& = LoadIconBynum(0, QualIcon&)                  'pega o icon do windows stock
   botDetalhes.Caption = LoadGasString(11301)
   DrawIcon picIcon.hdc, 2, 2, IconH&                    'põe na picture box
   CErr.Fatal = False                                    'erro pode ser recuperado
   labMsg.Caption = PegaErro()                           'label de mensagem
   If Len(labMsg.Caption) = 0 Then
      If Len(vgErrDescription) > 0 Then
         labMsg.Caption = vgErrDescription
      Else
         labMsg.Caption = LoadGasString(120)
      End If
   End If
   CErr.OcultarDetalhe = (CErr.Fatal = False)
   botDetalhes.Enabled = True                            'torna label visível e enche com os detalhes
   GoSub MontaDetalheDoErro
   If CErr.OcultarDetalhe Then
      botDetalhes_Click
   End If
   CentraNaTela Me                                       'centraliza
   Screen.MousePointer = vbDefault
   Exit Sub

MontaDetalheDoErro:
   vgErrFinal = LoadGasString(64) + vbCrLf + vgErrDescription + vbCrLf + _
                      vbCrLf + LoadGasString(96) + UCase$(vgErrSource) + vbCrLf
   If Len(CErr.FunctionName) > 0 Then
      vgErrFinal = vgErrFinal + LoadGasString(97) + CErr.FunctionName + vbCrLf
   End If
   If Not mdiNFE.ActiveForm Is Nothing Then
      vgErrFinal = vgErrFinal + vbCrLf + LoadGasString(98) + mdiNFE.ActiveForm.Caption + "(" + mdiNFE.ActiveForm.Name + ")"
   End If
   vgErrFinal = vgErrFinal + vbCrLf + LoadGasString(99) + str$(vgErrNumber)
   vgErrFinal = vgErrFinal + vbCrLf + LoadGasString(101) + vgPWUsuario
   vgErrFinal = vgErrFinal + vbCrLf + LoadGasString(102) + CStr(App.Major) + "." + CStr(App.Minor) + "." + CStr(App.Revision)
   txtDetalhes.Text = vgErrFinal
   Return
End Sub

Private Sub Form_Unload(Cancel As Integer)
   Set frmMsgErros = Nothing                              'destroi o objeto
   Screen.MousePointer = CurAtual
   CErr.FunctionName = ""
   CErr.Mensagem = ""
   CErr.Description = ""
   CErr.Origem = ""
   CErr.Titulo = ""
End Sub
