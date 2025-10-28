Version 5.00
Begin VB.Form frmAdaptbd
   Appearance = 0         'Flat
   BorderStyle     =   3  'Fixed Dialog
   ClientHeight    =   6030
   ClientLeft      =   210
   ClientTop       =   540
   ClientWidth     =   9330
   ControlBox      =   0   'False
   KeyPreview      =   -1  'True
   LinkTopic       =   "frmAdaptbd"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   6030
   ScaleWidth      =   9330
   ShowInTaskbar   =   0   'False
   Begin VB.Image imgInf 
      Height          =   480
      Left            =   120
      Top             =   150
      Width           =   480
   End
   Begin VB.Label labInfo 
      BackStyle       =   0  'Transparent
      Caption         =   "Dados do banco"
      Height          =   390
      Left            =   930
      TabIndex        =   0
      Top             =   60
      Width           =   4425
   End
   Begin VB.Label labTipoDb
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Tipo do banco"
      Height          =   195
      Left            =   120
      TabIndex        =   1
      Top             =   750
      Width           =   1035
   End
   Begin VB.ComboBox cboTipoDb
      Height          =   315
      Left            =   120
      Style           =   2  'Dropdown List
      TabIndex        =   2
      Top             =   975
      Width           =   2565
   End
   Begin VB.Label labNomeDb
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Nome do banco"
      Height          =   195
      Left            =   2790
      TabIndex        =   3
      Top             =   750
      Width           =   1140
   End
   Begin VB.TextBox txtNomeDb 
      Height          =   315
      Left            =   2790
      MaxLength       =   25
      TabIndex        =   4
      ToolTipText     =   "Pode ser utilizando em String Connection como [DATABASE]"
      Top             =   975
      Width           =   2565
   End
   Begin VB.Label labServidor 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Servidor"
      Height          =   195
      Left            =   120
      TabIndex        =   5
      Top             =   1380
      Width           =   585
   End
   Begin VB.TextBox txtServidor 
      Height          =   315
      Left            =   150
      MaxLength       =   25
      TabIndex        =   6
      ToolTipText     =   "Pode ser utilizando em String Connection como [SERVER]"
      Top             =   1620
      Width           =   2565
   End
   Begin VB.Label labDialeto 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Dialeto"
      Height          =   195
      Left            =   2790
      TabIndex        =   7
      Top             =   1380
      Width           =   495
      Visible         =   0
   End
   Begin VB.TextBox txtDialeto 
      Height          =   315
      Left            =   2790
      MaxLength       =   1
      TabIndex        =   8
      ToolTipText     =   "Pode ser utilizando em String Connection como [DIALECT]"
      Top             =   1620
      Width           =   795
      Visible         =   0      
   End
   Begin VB.Label labDirDb
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Diretório do banco"
      Height          =   195
      Left            =   120
      TabIndex        =   9
      Top             =   2010
      Width           =   1305
   End
   Begin VB.TextBox txtDirDb 
      Height          =   315
      Left            =   120
      TabIndex        =   10
      ToolTipText     =   "Pode ser utilizando em String Connection como [PATH]"
      Top             =   2250
      Width           =   5235
   End
   Begin VB.CommandButton botDir 
      Caption         =   "..."
      Height          =   255
      Left            =   5040
      TabIndex        =   11
      TabStop         =   0   'False
      Top             =   2280
      Width           =   285
   End
   Begin VB.Label labProvider 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Provider"
      Height          =   195
      Left            =   120
      TabIndex        =   12
      Top             =   2640
      Width           =   585
   End
   Begin VB.ComboBox cboProvider 
      Height          =   315
      Left            =   120
      TabIndex        =   13
      ToolTipText     =   "Pode ser utilizando em String Connection como [PROVIDER]"
      Top             =   2880
      Width           =   2565
   End
   Begin VB.Label labDriver 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Driver"
      Height          =   195
      Left            =   2790
      TabIndex        =   14
      Top             =   2640
      Width           =   420
   End
   Begin VB.ComboBox cboDriver 
      Height          =   315
      Left            =   2790
      TabIndex        =   15
      ToolTipText     =   "Pode ser utilizando em String Connection como [DRIVER]"
      Top             =   2880
      Width           =   2565
   End
   Begin VB.CheckBox chkTrusted 
      Caption         =   "Trusted Connection"
      Height          =   225
      Left            =   120
      TabIndex        =   16
      ToolTipText     =   "Pode ser utilizando em String Connection como [TRUSTED]"
      Top             =   3330
      Width           =   1965
   End
   Begin VB.Label labUsuarioDb 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Usuário"
      Height          =   195
      Left            =   120
      TabIndex        =   17
      Top             =   3630
      Width           =   540
   End
   Begin VB.TextBox txtUsuarioDb 
      Height          =   315
      Left            =   120
      MaxLength       =   40
      TabIndex        =   18
      ToolTipText     =   "Pode ser utilizando em String Connection como [USER]"
      Top             =   3870
      Width           =   2565
   End
   Begin VB.Label labSenhaDb 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Senha"
      Height          =   195
      Left            =   2790
      TabIndex        =   19
      Top             =   3630
      Width           =   465
   End
   Begin VB.TextBox txtSenhaDb 
      Height          =   315
      IMEMode         =   3  'DISABLE
      Left            =   2790
      MaxLength       =   40
      PasswordChar    =   "*"
      TabIndex        =   20
      ToolTipText     =   "Pode ser utilizando em String Connection como [PASSWORD]"
      Top             =   3870
      Width           =   2565
   End
   Begin VB.Label labStrConn 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "String Connection"
      Height          =   195
      Left            =   120
      TabIndex        =   21
      Top             =   4260
      Width           =   1260
   End
   Begin VB.TextBox txtStrConn 
      Height          =   795
      Left            =   120
      MultiLine       =   -1  'True
      TabIndex        =   22
      TabStop         =   False
      Top             =   4500
      Width           =   5235
   End
   Begin VB.Label labEstacao 
      BackStyle       =   0  'Transparent
      Caption         =   "Estação"
      Height          =   195
      Left            =   5460
      TabIndex        =   23
      Top             =   750
      Width           =   1815
   End
   Begin VB.TextBox txtEstacao 
      Height          =   315
      Left            =   5460
      MaxLength       =   25
      TabIndex        =   24
      Top             =   975
      Width           =   3765
   End
   Begin VB.Label labDirConsultas 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Diretório para consultas"
      Height          =   195
      Left            =   5460
      TabIndex        =   25
      Top             =   1380
      Width           =   1665
   End
   Begin VB.TextBox txtDirConsultas 
      Height          =   315
      Left            =   5460
      TabIndex        =   26
      Top             =   1620
      Width           =   3765
   End
   Begin VB.Label labUsuario 
      BackStyle       =   0  'Transparent
      Caption         =   "Usuário"
      Height          =   195
      Left            =   5460
      TabIndex        =   27
      Top             =   2010
      Width           =   1815
   End
   Begin VB.TextBox txtUsuario 
      Height          =   315
      Left            =   5460
      MaxLength       =   25
      TabIndex        =   28
      Top             =   2250
      Width           =   2595
   End
   Begin VB.Label labSenha 
      BackStyle       =   0  'Transparent
      Caption         =   "Senha"
      Height          =   195
      Left            =   5460
      TabIndex        =   29
      Top             =   2640
      Width           =   1815
   End
   Begin VB.TextBox txtSenha 
      Height          =   315
      IMEMode         =   3  'DISABLE
      Left            =   5460
      MaxLength       =   20
      PasswordChar    =   "*"
      TabIndex        =   30
      Top             =   2880
      Width           =   2595
   End
   Begin Adapta.GBotao botOk 
      Height          =   450
      Left            =   4470
      TabIndex        =   31
      Top             =   5430
      Width           =   450
      _ExtentX        =   0
      _ExtentY        =   0
      ForeColor       =   -2147483640
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         StrikeThrough   =   0   'False
      EndProperty
   End
   Begin Adapta.GBotao botCancela 
      Height          =   450
      Left            =   4920
      TabIndex        =   32
      Top             =   5430
      Width           =   450
      _ExtentX        =   0
      _ExtentY        =   0
      ForeColor       =   -2147483640
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         StrikeThrough   =   0   'False
      EndProperty
   End
End
Attribute VB_Name = "frmAdaptbd"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
'* Sistema...: Emissor de MDF-e (Layout 3.00)
'* Empresa...: Ygor Eduardo Dellalio
'* Módulo....: ADAPTBD
'* Função....: Bancos a Adaptar
'* CopyRight.: (C)2023 Ygor Eduardo Dellalio
'* Criação...: GAS-2007 - Gerador Automático de Sistemas
'* Data......: 01/09/2023 10:21:36
'* * * * * * *

Option Explicit                                   'requer que todas as variáveis sejam declaradas
DefInt A-Z                                        'variáveis inteiras, por default

Public vgFormID As Long                            'identificação do form

Dim vgQualControle As Integer                      'dimensiona variáveis do escopo do form
Dim vgNumTent As Integer, vgCancelou As Boolean

'usuário clicou no botão de cancelar
Private Sub botCancela_Click()
   vgCancelou = True
   Unload Me                                      'descarrega este form
End Sub

'Clicou no botão para pegar diretório
Private Sub botDir_Click()
   Dim bi As BROWSEINFO, vgRet As Variant, vgDirCapt As String
   bi.hOwner = Me.hWnd
   bi.lpszTitle = LoadGasString(5027) + " (NFE VIEW.INI)."
   bi.ulFlags = BI_RETORNADIR Or BIF_EDITBOX Or BIF_USENEWUI
   vgRet = SHBrowseForFolder(bi)                                     'vamos chamar o diálog
   vgDirCapt$ = Space$(512)                                          'prepara o buffer
   If SHGetPathFromIDList(ByVal vgRet, ByVal vgDirCapt$) Then        'pega a pasta capturada e se foi cancelado ou não
      vgDirCapt$ = Left(vgDirCapt$, InStr(vgDirCapt$, Chr$(0)) - 1)  'pega o caminho da pasta capturada
      If vgQualControle = PEGA_DIR Then
         txtDirDb.Text = vgDirCapt$
      End If
   End If
   If vgQualControle = PEGA_DIR Then
      txtDirDb.SetFocus
   End If
End Sub

'clicou no botão OK
Private Sub botOk_Click()
   Dim vgPareceOk As Integer, x As String, i As Integer, _
       vgDDb As String, DirAtual As String                      'dimensiona locais
   DIM vgJaTem As Integer, vgAr As Integer
   Beep                                           'apita e pede confirmação das informações
   vgPareceOk = (MsgBox(LoadGasString(5000), vbYesNo + vbExclamation, vgAtencao$) = vbYes)
   If Not vgPareceOk Then                         'se não parece ok,
      Beep                                        'apita e mostra mensagem de erro...
      MsgBox LoadGasString(5070), vbExclamation, vgAtencao$
   Else                                           'parece que está tudo OK - vamos ver...
      If vgQualControle = PEGA_DIR Then           'se estamos pedindo diretório,
         If cboTipoDb.ListIndex >= 0 Then
            vgTipoDb(1) = cboTipoDb.itemData(cboTipoDb.ListIndex)
         Else
            vgTipoDb(1) = -1
         End If
         vgNomeDb$(1) = txtNomeDb.Text            'move valor para a variável
         vgDirDb$(1) = txtDirDb.Text              'move valor para a variável
         If Right(vgDirDb(1), 1) <> "\" And len(vgDirDb(1)) > 0 Then vgDirDb(1) = vgDirDb(1) + "\"
         vgServerDb(1) = txtServidor.Text         ' PegaStrDoIni("Geral", "Server de " + vgAliasDb(QualDb), vgNomeINI$)
         vgTrustConnDb(1) = (chkTrusted.Value = vbChecked) '  PegaIntDoIni("Geral", "Trusted Connection de " + vgAliasDb(QualDb), 0, vgNomeINI$)
         vgUsuarioID(1) = txtUsuarioDb.Text                ' PegaStrDoIni("Geral", "Usuário de " + vgAliasDb(QualDb), vgNomeINI$)
         vgSenhaDb(1) = txtSenhaDb.Text                    ' PegaStrDoIni("Geral", "Senha de " + vgAliasDb(QualDb), vgNomeINI$)
         vgProviderDb(1) = cboProvider.Text                ' PegaStrDoIni("Geral", "String Connection de " + vgAliasDb(QualDb), vgNomeINI$)
         vgDriverDb(1) = cboDriver.Text                    ' PegaStrDoIni("Geral", "String Connection de " + vgAliasDb(QualDb), vgNomeINI$)
         vgStrConnectionDb(1) = txtStrConn.Text            ' PegaStrDoIni("Geral", "String Connection de " + vgAliasDb(QualDb), vgNomeINI$)
      End If
      Unload Me                                            'descarrega este form
   End If
End Sub

Private Sub cboTipoDb_Click()
   Dim Ok As Boolean
   PreparaControles
   cboProvider.Clear
   cboDriver.Clear
   cboProvider.AddItem "SQLOLEDB.1"
   cboDriver.AddItem "{SQL Server}"
   
   'vamos carregar definições default para o banco
   LeInfDb cboTipoDb.itemData(cboTipoDb.ListIndex)
   
   txtNomeDb.Text = vgNomeDb(1)
   txtDirDb.Text = vgDirDb(1)
   txtServidor.Text = vgServerDb(1)
   chkTrusted.Value = Abs(vgTrustConnDb(1))
   txtUsuarioDb.Text = vgUsuarioID(1)
   txtSenhaDb.Text = vgSenhaDb(1)
   txtStrConn.Text = vgStrConnectionDb(1)
   If cboTipoDb.Visible Then
      cboTipoDb.SetFocus
   End If
   
   'se só tem 1 provider, seleciona-o
   If cboProvider.ListCount = 1 Then
      cboProvider.ListIndex = 0
   End If
   
   'se só tem 1 driver, seleciona-o
   If cboDriver.ListCount = 1 Then
      cboDriver.ListIndex = 0
   End If
   
End Sub

Private Sub chkTrusted_Click()
   PreparaControles
End Sub

'carga deste form
Private Sub Form_Load()
   vgFormID = 14                                         'identificacao do form
   SET botOk.Picture = LoadPicture(LoadGasPicture(235))  'carrega figura do botão ok
   SET botCancela.Picture = LoadPicture(LoadGasPicture(240)) 'e do botão de cancelamento
   Caption = vgNomeSistema$ + Chr$(160)                      'seu título é o nome do sistema
   labUsuario.Caption = LoadGasString(5050)                  'coloca os títulos
   labSenha.Caption = LoadGasString(5060)                    'nos labels dos
   CentraNaTela Me                                           'centraliza form na tela
End Sub

'habilita/desabilita controles de acordo com o banco selecionado
Private Sub PreparaControles()
   Dim QualDb As EnumDataBaseType, L1 As Long, L2 As Long, W1 As Long, W2 As Long, UltCt As Object, PosiBot As Integer
   labTipoDb.Visible = False: cboTipoDb.Visible = False
   labNomeDb.Visible = False: txtNomeDb.Visible = False
   labServidor.Visible = False: txtServidor.Visible = False
   labProvider.Visible = False: cboProvider.Visible = False
   labDriver.Visible = False: cboDriver.Visible = False
   labDirDb.Visible = False: txtDirDb.Visible = False: botDir.Visible = False
   chkTrusted.Visible = False
   labUsuarioDb.Visible = False: txtUsuarioDb.Visible = False
   labSenhaDb.Visible = False: txtSenhaDb.Visible = False
   labStrConn.Visible = False: txtStrConn.Visible = False
   labEstacao.Visible = False: txtEstacao.Visible = False
   labDirConsultas.Visible = False: txtDirConsultas.Visible = False
   labUsuario.Visible = False: txtUsuario.Visible = False
   labSenha.Visible = False: txtSenha.Visible = False
   Select Case vgQualControle
      Case PEGA_DIR
         If cboTipoDb.ListIndex >= 0 Then
            QualDb = cboTipoDb.itemData(cboTipoDb.ListIndex)
         Else
            QualDb = -1
         End If
         labTipoDb.Visible = True: cboTipoDb.Visible = True
         labNomeDb.Visible = True: txtNomeDb.Visible = True
         labUsuarioDb.Enabled = (chkTrusted.Value = vbUnchecked)
         txtUsuarioDb.Enabled = (chkTrusted.Value = vbUnchecked)
         labSenhaDb.Enabled = (chkTrusted.Value = vbUnchecked   )
         txtSenhaDb.Enabled = (chkTrusted.Value = vbUnchecked   )
         labInfo.Height = 210: labInfo.Width = 4425
         labInfo.Left = imgInf.Left + imgInf.Width + 210: labInfo.Top = imgInf.Top + imgInf.Height / 2 - labInfo.Height / 2
         L1 = labTipoDb.Left
         W1 = cboTipoDb.Width
         L2 = L1 + W1 + 90
         W2 = W1 * 2 + 90
         cboTipoDb.Left = L1: cboTipoDb.Top = labTipoDb.Top + labTipoDb.Height + 30
         labNomeDb.Left = L2: labNomeDb.Top = labTipoDb.Top
         txtNomeDb.Left = L2: txtNomeDb.Top = cboTipoDb.Top
         PosiBot = -1
         
         Select Case QualDb
            Case DB_SQL
               PosicionaControles labServidor, txtServidor, cboTipoDb, L1
               PosicionaControles labProvider, cboProvider, txtServidor, L1
               PosicionaControles labDriver, cboDriver, txtServidor, L2
               PosicionaControles chkTrusted, Nothing, cboProvider, L1
               PosicionaControles labUsuarioDb, txtUsuarioDb, chkTrusted, L1
               PosicionaControles labSenhaDb, txtSenhaDb, chkTrusted, L2
               PosicionaControles labStrConn, txtStrConn, txtSenhaDb, L1
               Set UltCt = txtStrConn
               PosiBot = 0
            Case Else
               Set UltCt = txtNomeDb
               PosiBot = 0
         End Select
   End Select
   If PosiBot = 0 Then
      botCancela.Left = L1 + W2 - botCancela.Width: botCancela.Top = UltCt.Top + UltCt.Height + 150
   ElseIf PosiBot = 1 Or PosiBot = 2 Then
      botCancela.Left = L1 + W2 - botCancela.Width: botCancela.Top = UltCt.Top + UltCt.Height - botCancela.Height
   End If
   If PosiBot < 2 Then
      botOk.Left = botCancela.Left - botCancela.Width: botOk.Top = botCancela.Top
      Height = botOk.Top + botOk.Height + 120 + (Height - ScaleHeight)
   Else
      botOk.Left = botCancela.Left: botOk.Top = botCancela.Top - botOk.Height
      Height = botCancela.Top + botCancela.Height + 270 + (Height - ScaleHeight)
   End If
   Width = L1 + W2 + L1 + (Width - ScaleWidth)
   CentraNaTela Me
End Sub

Private Sub PosicionaControles(Ct1 As Object, Ct2 As Object, CtAnt As Object, L As Long)
   Ct1.Left = L: Ct1.Top = CtAnt.Top + CtAnt.Height + 90
   If Not Ct2 Is Nothing Then Ct2.Left = L: Ct2.Top = Ct1.Top + Ct1.Height + 30
   Ct1.Visible = True: If Not Ct2 Is Nothing Then Ct2.Visible = True
End Sub

'inicializa o form
Public Function Iniciaform(vgParaQue As Integer) As Boolean
   On Error GoTo DeuErro                          'prepara para possivel erro
   vgQualControle = vgParaQue                     'flag - para que vamos carregar este form...
   If vgQualControle = PEGA_DIR Then              'queremos pegar diretório da aplicação
      Icon = LoadPicture(LoadGasPicture(232))     'carrea o ícone do form
      labInfo.Caption = LoadGasString(5020) & " " & vgAliasDb(1)
      labInfo.FontBold = False
      cboTipoDb.AddItem LoadGasString(5032)
      cboTipoDb.ItemData(cboTipoDb.NewIndex) = DB_SQL
   Else                                           'se estamos pegando o nome da estação
      Icon = LoadPicture(LoadGasPicture(232))     'coloca o ícone do form
      labInfo.Caption = LoadGasString(5040)       'mostra mensagem,
   End If
   
   PreparaControles
   
   vgCancelou = False
   
   If vgQualControle = PEGA_DIR Then
      cboTipoDb.ListIndex = 0
   End If
   Show vbModal
   
   IniciaForm = Not vgCancelou
   
   Exit Function

DeuErro:
   Err.Clear
End Function

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyF1 Then
      KeyCode = 0
   ElseIf KeyCode = vbKeyEscape Then
      vgCancelou = True
      UnLoad Me
   End If
End Sub

Private Sub cboTipoDb_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      KeyAscii = 0
      SendK vbKeyTab
   End If
End Sub

Private Sub chkTrusted_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      KeyAscii = 0
      SendK vbKeyTab
   End If
End Sub

Private Sub txtDirDb_GotFocus()
   If Len(txtDirDb.Text) = 0 Then
      txtDirDb.Text = vgDirEXE
   End If
End Sub

Private Sub txtDirDb_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyF4 Then
      botDir.Value = True
   End If
End Sub

Private Sub txtDirDb_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      KeyAscii = 0
      SendK vbKeyTab
   End If
End Sub

Private Sub txtDirConsultas_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyF4 Then
      botDir.Value = True
   End If
End Sub

Private Sub cboDriver_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      KeyAscii = 0
      SendK vbKeyTab
   End If
End Sub

Private Sub cboProvider_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      KeyAscii = 0
      SendK vbKeyTab
   End If
End Sub

Private Sub txtDirConsultas_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      KeyAscii = 0
      SendK vbKeyTab
   End If
End Sub

Private Sub txtNomeDb_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      KeyAscii = 0
      SendK vbKeyTab
   End If
End Sub

Private Sub txtSenhaDb_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      KeyAscii = 0
      SendK vbKeyTab
   End If
End Sub

Private Sub txtServidor_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      KeyAscii = 0
      SendK vbKeyTab
   End If
End Sub

Private Sub txtSenha_KeyPress(KeyAscii As Integer)
   KeyAscii = Asc(UCase(Chr(KeyAscii)))
   If KeyAscii = vbKeyReturn Then
      KeyAscii = 0
      SendK vbKeyTab
   End If
End Sub

Private Sub txtUsuario_KeyPress(KeyAscii As Integer)
   KeyAscii = Asc(UCase(Chr(KeyAscii)))
   If KeyAscii = vbKeyReturn Then
      KeyAscii = 0
      SendK vbKeyTab
   End If
End Sub

Private Sub txtSenha_GotFocus()
   txtSenha.SelStart = 0
   txtSenha.SelLength = Len(txtSenha.Text)
End Sub

Private Sub txtUsuario_GotFocus()
   txtUsuario.SelStart = 0
   txtUsuario.SelLength = Len(txtUsuario.Text)
End Sub

Private Sub txtUsuarioDb_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      KeyAscii = 0
      SendK vbKeyTab
   End If
End Sub

Private Sub txtEstacao_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      KeyAscii = 0
      SendK vbKeyTab
   End If
End Sub
