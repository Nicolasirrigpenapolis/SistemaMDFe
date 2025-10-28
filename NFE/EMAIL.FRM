VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{248DD890-BB45-11CF-9ABC-0080C7E7B78D}#1.0#0"; "MSWINSCK.OCX"
Object = "{20C62CAE-15DA-101B-B9A8-444553540000}#1.1#0"; "MSMAPI32.OCX"
Begin VB.Form frmEnviaEMail 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Envia Email"
   ClientHeight    =   6555
   ClientLeft      =   4215
   ClientTop       =   2745
   ClientWidth     =   6555
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5640
   ScaleWidth      =   6435
   StartUpPosition =   2  'CenterScreen
   Begin MSWinsockLib.Winsock wskRef 
      Left            =   6000
      Top             =   0
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
   End
   Begin MSMAPI.MAPIMessages MAPIMessages 
      Left            =   4800
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      _Version        =   393216
      AddressEditFieldCount=   1
      AddressModifiable=   0   'False
      AddressResolveUI=   0   'False
      FetchSorted     =   0   'False
      FetchUnreadOnly =   0   'False
   End
   Begin MSMAPI.MAPISession MAPISession 
      Left            =   5400
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      _Version        =   393216
      DownloadMail    =   0   'False
      LogonUI         =   -1  'True
      NewSession      =   0   'False
   End
   Begin VB.Frame fraProgresso 
      Caption         =   "Progresso..."
      Height          =   3945
      Left            =   1200
      TabIndex        =   28
      Top             =   2040
      Width           =   4785
      Begin NFE.GBotao botAborta 
         Height          =   360
         Left            =   2460
         TabIndex        =   34
         Top             =   3450
         Width           =   1470
         _ExtentX        =   2593
         _ExtentY        =   635
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         CaptionAlign    =   4
         CaptionOffset   =   120
      End
      Begin NFE.GBotao botConcluido 
         Height          =   360
         Left            =   870
         TabIndex        =   33
         Top             =   3450
         Width           =   1470
         _ExtentX        =   2593
         _ExtentY        =   635
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         CaptionAlign    =   4
         CaptionOffset   =   120
      End
      Begin VB.ListBox lstProgresso 
         Height          =   2400
         Left            =   240
         TabIndex        =   32
         Top             =   600
         Width           =   4395
      End
      Begin MSComctlLib.ProgressBar pbgEnvia 
         Height          =   255
         Left            =   240
         TabIndex        =   30
         Top             =   3105
         Width           =   3795
         _ExtentX        =   6694
         _ExtentY        =   450
         _Version        =   327682
         Appearance      =   1
      End
      Begin VB.Label labEnviaProg 
         Caption         =   "0 %"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   165
         Left            =   4140
         TabIndex        =   31
         Top             =   3150
         Width           =   465
      End
      Begin VB.Label labEnvia 
         AutoSize        =   -1  'True
         Caption         =   "Enviando Email"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   240
         TabIndex        =   29
         Top             =   330
         Width           =   1365
      End
   End
   Begin VB.Frame fraEMail 
      Height          =   1545
      Left            =   30
      TabIndex        =   23
      Top             =   4890
      Width           =   6375
      Begin NFE.GBotao botEnviaEMail 
         Height          =   360
         Left            =   5940
         TabIndex        =   18
         TabStop         =   0   'False
         Top             =   1080
         Width           =   360
         _ExtentX        =   635
         _ExtentY        =   635
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         CaptionOffset   =   50
      End
      Begin VB.TextBox txtMensagem 
         Height          =   825
         Left            =   1830
         MaxLength       =   100
         MultiLine       =   -1  'True
         TabIndex        =   17
         Top             =   600
         Width           =   4065
      End
      Begin VB.TextBox txtAssunto 
         Height          =   285
         Left            =   1830
         MaxLength       =   60
         TabIndex        =   16
         Top             =   240
         Width           =   4065
      End
      Begin VB.Label labMensagem 
         AutoSize        =   -1  'True
         Caption         =   "Mensagem adicional"
         Height          =   195
         Left            =   180
         TabIndex        =   25
         Top             =   630
         Width           =   1455
      End
      Begin VB.Label labAssunto 
         AutoSize        =   -1  'True
         Caption         =   "Assunto"
         Height          =   195
         Left            =   180
         TabIndex        =   23
         Top             =   240
         Width           =   570
      End
   End
   Begin VB.Frame fraFormato 
      Caption         =   "Formato para o Email"
      Height          =   915
      Left            =   30
      TabIndex        =   42
      Top             =   30
      Width           =   6375
      Begin VB.OptionButton optFormato 
         Caption         =   "Envio via MAPI"
         Height          =   195
         Index           =   0
         Left            =   300
         TabIndex        =   1
         Top             =   270
         Width           =   1395
      End
      Begin VB.OptionButton optFormato 
         Caption         =   "Envio direto"
         Height          =   195
         Index           =   1
         Left            =   300
         TabIndex        =   2
         Top             =   570
         Width           =   1500
      End
      Begin VB.TextBox txtSmtp 
         Height          =   285
         Left            =   3540
         MaxLength       =   50
         TabIndex        =   3
         Top             =   510
         Width           =   2775
      End
      Begin VB.Label labSmtp 
         AutoSize        =   -1  'True
         Caption         =   "Servidor SMTP"
         Height          =   195
         Left            =   2130
         TabIndex        =   19
         Top             =   540
         Width           =   1080
      End
   End
   Begin VB.Frame fraDest 
      Caption         =   "Dados do(s) destinatário(s)"
      Height          =   2295
      Left            =   30
      TabIndex        =   22
      Top = 2520
      Width           =   6375
      Begin NFE.GBotao botExclui 
         Height          =   360
         Left            =   5940
         TabIndex        =   15
         Top             =   1440
         Width           =   360
         _ExtentX        =   635
         _ExtentY        =   635
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         CaptionOffset   =   50
      End
      Begin NFE.GBotao botInclui 
         Height          =   360
         Left            =   5940
         TabIndex        =   14
         Top             =   1080
         Width           =   360
         _ExtentX        =   635
         _ExtentY        =   635
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         CaptionOffset   =   50
      End
      Begin NFE.GBotao botSalva 
         Height          =   360
         Left            =   5190
         TabIndex        =   12
         Top             =   660
         Width           =   360
         _ExtentX        =   0
         _ExtentY        =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         CaptionOffset   =   50
      End
      Begin NFE.GBotao botCancela 
         Height          =   360
         Left            =   5550
         TabIndex        =   13
         Top             =   660
         Width           =   360
         _ExtentX        =   0
         _ExtentY        =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         CaptionOffset   =   50
      End
      Begin VB.ComboBox cboTipoDest 
         Height          =   315
         Left            =   4020
         Style           =   2  'Dropdown List
         TabIndex        =   11
         Top             =   270
         Width           =   1905
      End
      Begin VB.TextBox txtTo 
         Height          =   285
         Index           =   0
         Left            =   810
         MaxLength       =   50
         TabIndex        =   9
         Top             =   270
         Width           =   2265
      End
      Begin VB.TextBox txtTo 
         Height          =   285
         Index           =   1
         Left            =   810
         MaxLength       =   50
         TabIndex        =   10
         Top             =   630
         Width           =   2265
      End
      Begin MSComctlLib.ListView lstDest 
         Height          =   1155
         Left            =   180
         TabIndex        =   19
         Top             =   1050
         Width           =   5745
         _ExtentX        =   10134
         _ExtentY        =   2037
         View            =   3
         LabelEdit       =   1
         LabelWrap       =   -1  'True
         HideSelection   =   0   'False
         _Version        =   327682
         ForeColor       =   -2147483640
         BackColor       =   -2147483643
         BorderStyle     =   1
         Appearance      =   1
         NumItems        =   3
         BeginProperty ColumnHeader(1) {0713E8C7-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.Tag             =   ""
            Text            =   "Nome"
            Object.Width           =   3704
         EndProperty
         BeginProperty ColumnHeader(2) {0713E8C7-850A-101B-AFC0-4210102A8DA7} 
            SubItemIndex    =   1
            Key             =   ""
            Object.Tag             =   ""
            Text            =   "Email"
            Object.Width           =   2999
         EndProperty
         BeginProperty ColumnHeader(3) {0713E8C7-850A-101B-AFC0-4210102A8DA7} 
            SubItemIndex    =   2
            Key             =   ""
            Object.Tag             =   ""
            Text            =   "Tipo"
            Object.Width           =   1411
         EndProperty
      End
      Begin VB.Label labTo 
         AutoSize        =   -1  'True
         Caption         =   "Tipo"
         Height          =   195
         Index           =   2
         Left            =   3240
         TabIndex        =   20
         Top             =   270
         Width           =   315
      End
      Begin VB.Label labTo 
         AutoSize        =   -1  'True
         Caption         =   "Nome"
         Height          =   195
         Index           =   0
         Left            =   180
         TabIndex        =   25
         Top             =   270
         Width           =   420
      End
      Begin VB.Label labTo 
         AutoSize        =   -1  'True
         Caption         =   "Email"
         Height          =   195
         Index           =   1
         Left            =   180
         TabIndex        =   26
         Top             =   630
         Width           =   435
      End
   End
   Begin VB.Frame fraRem 
      Caption         =   "Dados remetente"
      Height          =   1515
      Left            =   30
      TabIndex        =   21
      Top             =   960
      Width = 6375
      Begin VB.TextBox txtFrom 
         Height          =   285
         IMEMode         =   3  'DISABLE
         Index           =   3
         Left            =   3990
         MaxLength       =   50
         PasswordChar    =   "*"
         TabIndex        =   8
         Top             =   915
         Width           =   2265
      End
      Begin VB.CheckBox chkAut 
         Caption         =   "Requer Autenticação"
         Height          =   240
         Left            =   120
         TabIndex        =   6
         Top             =   600
         Width           =   2025
      End
      Begin VB.TextBox txtFrom 
         Height          =   285
         Index           =   2
         Left            =   810
         MaxLength       =   50
         TabIndex        =   7
         Top             =   915
         Width           =   2265
      End
      Begin VB.Label labFrom 
         Caption         =   "Senha"
         Height          =   255
         Index           =   3
         Left            =   3480
         TabIndex        =   39
         Top             =   960
         Width           =   495
      End
      Begin VB.Label labFrom 
         Caption         =   "Usuário"
         Height          =   240
         Index           =   2
         Left            =   120
         TabIndex        =   38
         Top             =   915
         Width           =   615
      End
      Begin VB.TextBox txtFrom 
         Height          =   285
         Index           =   1
         Left            =   3990
         MaxLength       =   50
         TabIndex        =   5
         Top             =   240
         Width           =   2295
      End
      Begin VB.TextBox txtFrom 
         Height          =   285
         Index           =   0
         Left            =   810
         MaxLength       =   50
         TabIndex        =   4
         Top             =   240
         Width           =   2265
      End
      Begin VB.Label labFrom 
         AutoSize        =   -1  'True
         Caption         =   "Email"
         Height          =   195
         Index           =   1
         Left            =   3480
         TabIndex        =   31
         Top             =   240
         Width           =   435
      End
      Begin VB.Label labFrom 
         AutoSize        =   -1  'True
         Caption         =   "Nome"
         Height          =   195
         Index           =   0
         Left            =   240
         TabIndex        =   41
         Top             =   240
         Width           =   420
      End
   End
End
Attribute VB_Name = "frmEnviaEMail"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'* Sistema...: Emissor de MDF-e (Layout 3.00)
'* Empresa...: Ygor Eduardo Dellalio
'* Módulo....: EMAIL
'* Função....: Envia relatório via Email
'* CopyRight.: (C)2024 Ygor Eduardo Dellalio
'* Criação...: GAS-2007 - Gerador Automático de Sistemas
'* Data......: 05/09/2024 18:10:19
'* * * * * * *

Option Explicit
DefInt A-Z

Public vgTooltips As New cTooltips

Public vgSituacao As Integer, vgPriVez As Boolean

Public WithEvents poSendMail As clsEnviaEMail, frmRel As Form
Attribute poSendMail.VB_VarHelpID = -1

Private Sub botCancela_Click()
   vgSituacao = ACAO_NAVEGANDO
   PreparaBotoes
   If lstDest.ListItems.Count > 0 Then
      lstDest_ItemClick lstDest.SelectedItem
   Else
      vgPriVez = True
      txtTo(0).Text = ""
      txtTo(1).Text = ""
      cboTipoDest.ListIndex = -1
      vgPriVez = False
   End If
   txtTo(0).SetFocus
End Sub

Private Sub botConcluido_Click()
   Unload Me
End Sub

Private Sub botEnviaEMail_Click()
   Dim vgOk As Boolean, vgMsg As String, vgCtl As Object
   vgOk = True
   If optFormato(1).Value = True Then
      vgOk = (Len(txtSmtp.Text) > 0)              'endereço SMTP em branco
      vgMsg$ = LoadGasString(9210) 
      Set vgCtl = txtSmtp
      If vgOk Then
         vgOk = (Len(txtFrom(1).Text) > 0)        'remetente em branco
         vgMsg$ = LoadGasString(9212)
         Set vgCtl = txtFrom(1)
      End If
      If vgOk Then
         vgOk = (lstDest.ListItems.Count > 0)
         vgMsg$ = LoadGasString(9214)             'destinatário em branco
         Set vgCtl = txtTo(0)
      End If
   End If
   If vgOk = False Then
      MsgBox vgMsg$, vbExclamation, vgAtencao$
      vgCtl.SetFocus
      Set vgCtl = Nothing
   Else
      EnviaEMail
   End If
End Sub

Private Sub botExclui_Click()
   If MsgBox(LoadGasString(9216), vbQuestion + vbYesNo, vgAtencao$) = vbYes Then
      lstDest.ListItems.Remove lstDest.SelectedItem.Index
      If lstDest.ListItems.Count > 0 Then
         lstDest.ListItems(1).Selected = True
      End If
      botCancela_Click
   End If
End Sub

Private Sub botInclui_Click()
   vgSituacao = ACAO_INCLUINDO
   vgPriVez = True
   txtTo(0).Text = ""
   txtTo(1).Text = ""
   cboTipoDest.ListIndex = -1
   vgPriVez = False
   txtTo(0).SetFocus
   PreparaBotoes
End Sub

Private Sub botSalva_Click()
   Dim Item As ListItem
   If vgSituacao = ACAO_INCLUINDO Then
      Set Item = lstDest.ListItems.Add
   Else
      Set Item = lstDest.SelectedItem
   End If
   Item.Text = txtTo(0).Text
   Item.SubItems(1) = txtTo(1).Text
   Item.SubItems(2) = cboTipoDest.Text
   Item.Tag = cboTipoDest.ListIndex
   vgSituacao = ACAO_NAVEGANDO
   txtTo(0).SetFocus
   Set Item = Nothing
   PreparaBotoes
End Sub

Private Sub cboTipoDest_Click()
   If vgPriVez = True Then Exit Sub
   If vgSituacao = ACAO_NAVEGANDO Then
      If lstDest.ListItems.Count > 0 Then
         vgSituacao = ACAO_EDITANDO
      Else
         vgSituacao = ACAO_INCLUINDO
      End If
      PreparaBotoes
   End If
End Sub

Private Sub chkAut_Click()
   txtFrom(2).Enabled = (chkAut.Value)
   txtFrom(3).Enabled = (chkAut.Value)
   txtFrom(2).Text = txtFrom(1).Text
   labFrom(2).Enabled = (chkAut.Value)
   labFrom(3).Enabled = (chkAut.Value)
End Sub

Private Sub Form_Load()
   Dim i As Integer, j As Integer, x As String, Item As ListItem
   cboTipoDest.AddItem LoadGasString(9218) 
   cboTipoDest.AddItem LoadGasString(9220) 
   cboTipoDest.AddItem LoadGasString(9222) 
   Set botSalva.Picture = LoadPicture(LoadGasPicture(659))
   Set botSalva.PictureDisabled = LoadPicture(LoadGasPicture(660))
   Set botCancela.Picture = LoadPicture(LoadGasPicture(661))
   Set botCancela.PictureDisabled = LoadPicture(LoadGasPicture(662))
   Set botInclui.Picture = LoadPicture(LoadGasPicture(655))
   Set botInclui.PictureDisabled = LoadPicture(LoadGasPicture(656))
   Set botExclui.Picture = LoadPicture(LoadGasPicture(657))
   Set botExclui.PictureDisabled = LoadPicture(LoadGasPicture(658))
   Set botConcluido.Picture = LoadPicture(LoadGasPicture(664))
   Set botConcluido.PictureDisabled = LoadPicture(LoadGasPicture(665))
   Set botAborta.Picture = LoadPicture(LoadGasPicture(666))
   Set botAborta.PictureDisabled = LoadPicture(LoadGasPicture(667))
   Set botEnviaEMail.Picture = LoadPicture(LoadGasPicture(663))

   botConcluido.Caption = LoadGasString(9224)
   botAborta.Caption = LoadGasString(9226)   
   fraProgresso.Visible = False

   'coloca títulos nos controles 
   Caption = LoadGasString(9240)
   fraProgresso.Caption = LoadGasString(9241)
   labEnvia.Caption = LoadGasString(9242)
   labMensagem.Caption = LoadGasString(9243)
   labAssunto.Caption = LoadGasString(9244)
   fraFormato.Caption = LoadGasString(9245)
   optFormato(0).Caption = LoadGasString(9246)
   optFormato(1).Caption = LoadGasString(9247)
   labSmtp.Caption = LoadGasString(9248)
   fraDest.Caption = LoadGasString(9249)
   lstDest.ColumnHeaders(1).Text = LoadGasString(9250)
   lstDest.ColumnHeaders(2).Text = LoadGasString(9251)
   lstDest.ColumnHeaders(3).Text = LoadGasString(9252)
   labTo(0).Caption = LoadGasString(9250)
   labTo(1).Caption = LoadGasString(9251)
   labTo(2).Caption = LoadGasString(9252)
   fraRem.Caption = LoadGasString(9253)
   labFrom(0).Caption = LoadGasString(9250)
   labFrom(1).Caption = LoadGasString(9251)
   labFrom(2).Caption = LoadGasString(9280)
   labFrom(3).Caption = LoadGasString(9281)
   chkAut.Caption = LoadGasString(9282)
   

   'hint para os controles 
   vgTooltips.Create
   vgTooltips.AddTool botSalva, 0, LoadGasString(9260)
   vgTooltips.AddTool botCancela, 0, LoadGasString(9261)
   vgTooltips.AddTool botInclui, 0, LoadGasString(9262)
   vgTooltips.AddTool botExclui, 0, LoadGasString(9263)
   vgTooltips.AddTool botConcluido, 0, LoadGasString(9264)
   vgTooltips.AddTool botAborta, 0, LoadGasString(9265)
   vgTooltips.AddTool botEnviaEMail, 0, LoadGasString(9266)
   vgTooltips.AddTool optFormato(0), 0, LoadGasString(9267)
   vgTooltips.AddTool optFormato(1), 0, LoadGasString(9268)
   vgTooltips.AddTool txtSmtp, 0, LoadGasString(9269)
   vgTooltips.AddTool txtFrom(0), 0, LoadGasString(9270)
   vgTooltips.AddTool txtFrom(1), 0, LoadGasString(9271)
   vgTooltips.AddTool txtTo(0), 0, LoadGasString(9272)
   vgTooltips.AddTool txtTo(1), 0, LoadGasString(9273)
   vgTooltips.AddTool cboTipoDest, 0, LoadGasString(9274)
   vgTooltips.AddTool lstDest, 0, LoadGasString(9275)
   vgTooltips.AddTool txtAssunto, 0, LoadGasString(9276)
   vgTooltips.AddTool txtMensagem, 0, LoadGasString(9277)
   vgTooltips.AddTool txtFrom(2), 0, LoadGasString(9278)
   vgTooltips.AddTool txtFrom(3), 0, LoadGasString(9279)

   'carrega configurações anteriores
   On Error Resume Next
   optFormato(PegaIntDoIni("E-Mail", "Formato", 0, vgNomeINI$)).Value = True
   txtSmtp.Text = PegaStrDoIni("E-Mail", "Servidor SMTP", vgNomeINI$)
   txtFrom(0).Text = PegaStrDoIni("E-Mail", "Nome remetente", vgNomeINI$)
   txtFrom(1).Text = PegaStrDoIni("E-Mail", "E-Mail remetente", vgNomeINI$)
   i = PegaIntDoIni("E-Mail", "Número destinatários", 0, vgNomeINI$)
   For j = 1 To i
      x$ = PegaStrDoIni("E-Mail", "Destinatário " + CStr(j), vgNomeINI$)
      Set Item = lstDest.ListItems.Add
      Item.Text = Parse(x$, Chr(216))
      Item.SubItems(1) = Parse(x$, Chr(216))
      Item.Tag = Parse(x$, Chr(216))
      Item.SubItems(2) = cboTipoDest.List(Item.Tag)
   Next
   txtAssunto.Text = PegaStrDoIni("E-Mail", "Assunto", vgNomeINI$)
   txtMensagem.Text = PegaStrDoIni("E-Mail", "Mensagem", vgNomeINI$)
   If Err Then
      lstDest.ListItems.Remove Item.Index
   ElseIf Not Item Is Nothing Then
      lstDest.ListItems(1).Selected = True
      lstDest_ItemClick lstDest.SelectedItem
   End If
   Set Item = Nothing
   txtFrom(2).Enabled = chkAut.Value
   txtFrom(3).Enabled = chkAut.Value
   labFrom(2).Enabled = (chkAut.Value)
   labFrom(3).Enabled = (chkAut.Value)
   vgSituacao = ACAO_NAVEGANDO
   PreparaBotoes
End Sub

Private Sub Form_Unload(Cancel As Integer)
   Dim i As Integer, j As Integer

   On Error Resume Next
   
   'grava configurações atuais
   GravaNoIni "E-Mail", "Formato", CStr(Abs(optFormato(0).Value = False)), vgNomeINI$
   GravaNoIni "E-Mail", "Servidor SMTP", txtSmtp.Text, vgNomeINI$
   GravaNoIni "E-Mail", "Nome remetente", txtFrom(0).Text, vgNomeINI$
   GravaNoIni "E-Mail", "E-Mail remetente", txtFrom(1).Text, vgNomeINI$
   i = PegaIntDoIni("E-Mail", "Número destinatários", 0, vgNomeINI$)
   For j = lstDest.ListItems.Count + 1 To i
      GravaNoIni "E-Mail", "Destinatário " + CStr(j), vbNullString, vgNomeINI$
   Next
   GravaNoIni "E-Mail", "Número destinatários", CStr(lstDest.ListItems.Count), vgNomeINI$
   For i = 1 To lstDest.ListItems.Count
      GravaNoIni "E-Mail", "Destinatário " + CStr(i), lstDest.ListItems(i).Text + Chr(216) + lstDest.ListItems(i).SubItems(1) + Chr(216) + CStr(lstDest.ListItems(i).Tag), vgNomeINI$
   Next
   GravaNoIni "E-Mail", "Assunto", txtAssunto.Text, vgNomeINI$
   GravaNoIni "E-Mail", "Mensagem", txtMensagem.Text, vgNomeINI$
   
   frmRel.Show
   Set vgTooltips = Nothing
   Set poSendMail = Nothing
   Set frmEnviaEMail = Nothing                          'libera o segmento de código do form
End Sub

Private Sub lstDest_ItemClick(ByVal Item As MSComctlLib.ListItem)
   vgPriVez = True
   txtTo(0).Text = Item.Text
   txtTo(1).Text = Item.SubItems(1)
   cboTipoDest.ListIndex = Val(Item.Tag)
   vgPriVez = False
End Sub

Private Sub PreparaBotoes()
   botCancela.Enabled = (vgSituacao <> ACAO_NAVEGANDO)
   botSalva.Enabled = (vgSituacao <> ACAO_NAVEGANDO)
   botExclui.Enabled = (vgSituacao = ACAO_NAVEGANDO And lstDest.ListItems.Count > 0 And Not lstDest.SelectedItem Is Nothing)
   botInclui.Enabled = (vgSituacao = ACAO_NAVEGANDO)
   lstDest.Enabled = (vgSituacao = ACAO_NAVEGANDO)
   labSmtp.Enabled = (optFormato(1).Value = True)
   txtSmtp.Enabled = (optFormato(1).Value = True)
   labEnvia.Enabled = (optFormato(1).Value = True)
   lstProgresso.Enabled = (optFormato(1).Value = True)
   labEnviaProg.Enabled = (optFormato(1).Value = True)
   fraRem.Enabled = (optFormato(1).Value = True)
   labFrom(0).Enabled = (optFormato(1).Value = True)
   labFrom(1).Enabled = (optFormato(1).Value = True)
   txtFrom(0).Enabled = (optFormato(1).Value = True)
   txtFrom(1).Enabled = (optFormato(1).Value = True)
End Sub

Private Sub optFormato_Click(Index As Integer)
   PreparaBotoes
End Sub

Private Sub txtTo_Change(Index As Integer)
   If vgPriVez Then Exit Sub
   If vgSituacao = ACAO_NAVEGANDO Then
      If lstDest.ListItems.Count > 0 Then
         vgSituacao = ACAO_EDITANDO
      Else
         vgSituacao = ACAO_INCLUINDO
      End If
      PreparaBotoes
   End If
End Sub

Private Sub EnviaEMail()
   Dim Email As MAPIClass, i As Integer, x(3) As String, z(3) As String, j As Integer, w As String
   
   fraDest.Visible = False
   fraFormato.Visible = False
   fraEMail.Visible = False
   fraRem.Visible = False
   fraProgresso.Left = fraFormato.Left
   fraProgresso.Top = fraFormato.Top
   fraProgresso.Visible = True
   Me.Width = fraProgresso.Width + 10 * Screen.TwipsPerPixelX
   Me.Height = fraProgresso.Height + 30 * Screen.TwipsPerPixelX
   botConcluido.Enabled = False
   botAborta.SetFocus
   DoEvents
   w$ = frmRel.EnviaEMailRel
   If Len(w$) > 0 Then
      MsgBox LoadGasString(9228) + vbCrLf + vbCrLf + LoadGasString(9230) + w$, vbCritical, vgAtencao$
      Unload Me
      Exit Sub
   ElseIf frmRel.vgCancelou Then
      MsgBox LoadGasString(9232), vbExclamation, vgAtencao$
      Unload Me
      Exit Sub
   Else
      w$ = frmRel.vgArqExportados$
      If Len(w$) > 0 Then
         w$ = Left(w$, Len(w$) - 1)
      End If
   End If
   
   If optFormato(0).Value = True Then
      Set Email = New MAPIClass
      For i = 1 To lstDest.ListItems.Count
         Email.IncluiDestinatario lstDest.ListItems(i).SubItems(1), lstDest.ListItems(i).Text, Val(lstDest.ListItems(i).Tag) + 1
      Next
      Do While Len(w$) > 0
         Email.IncluiAttach Parse(w$, "|")
      Loop
      Email.Assunto = txtAssunto.Text
      Email.Mensagem = txtMensagem.Text
      Email.EnviaEMail
      If Len(Email.Erro$) = 0 Then
         MsgBox LoadGasString(9234), vbInformation, vgAtencao$
      Else
         MsgBox LoadGasString(9236) + vbCrLf + vbCrLf + Email.Erro$, vbCritical, vgAtencao$
      End If
      Set Email = Nothing
   Else
      Set poSendMail = New clsEnviaEMail
      poSendMail.Inicia wskRef
      With poSendMail
         .SMTPHostValidation = VALIDATE_NONE
         .EmailAddressValidation = VALIDATE_SYNTAX
         .SMTPHost = txtSmtp.Text
         .from = txtFrom(1).Text
         .FromDisplayName = txtFrom(0).Text
         x$(1) = ""
         z$(1) = ""
         x$(2) = ""
         z$(2) = ""
         x$(3) = ""
         z$(3) = ""
         For i = 1 To lstDest.ListItems.Count
            j = Val(lstDest.ListItems(i).Tag) + 1
            If Len(x$(j)) > 0 Or Len(z$(j)) > 0 Then
               x$(j) = x$(j) + .Delimiter
               z$(j) = z$(j) + .Delimiter
            End If
            x$(j) = x$(j) + lstDest.ListItems(i).SubItems(1)
            z$(j) = z$(j) + lstDest.ListItems(i).Text
         Next
         .Recipient = x$(1)
         .RecipientDisplayName = z$(1)
         .CcRecipient = x$(2)
         .CcDisplayName = z$(2)
         .BccRecipient = x$(3)
         .Subject = txtAssunto.Text
         .Message = txtMensagem.Text
         If chkAut.Value = vbChecked Then
            .Username = txtFrom(2).Text
            .Password = txtFrom(3).Text
            .UseAuthentication = True
         End If
         If Len(w$) > 0 Then
            .Attachment = Substitui(w$, "|", ";", UM_A_UM)
         End If
         .AsHTML = True
         .SEND
      End With
   End If
   botAborta.Enabled = False
   botConcluido.Enabled = True
   botConcluido.SetFocus
End Sub

Private Sub poSendMail_Progress(lPercentCompete As Long)
   labEnviaProg.Caption = CStr(lPercentCompete) + " %"
   pbgEnvia.Value = lPercentCompete
End Sub

Private Sub poSendMail_SendFailed(Explanation As String)
   MsgBox LoadGasString(9236) + vbCrLf + vbCrLf + LoadGasString(9238) + Explanation$, vbCritical, vgAtencao$
   Screen.MousePointer = vbDefault
End Sub

Private Sub poSendMail_SendSuccesful()
   MsgBox LoadGasString(9234), vbInformation, vgAtencao$
End Sub

Private Sub poSendMail_Status(Status As String)
   lstProgresso.AddItem Status
   lstProgresso.ListIndex = lstProgresso.ListCount - 1
   lstProgresso.ListIndex = -1
End Sub

Public Sub SetProp(vgForm As Form)
   Set frmRel = vgForm
End Sub
