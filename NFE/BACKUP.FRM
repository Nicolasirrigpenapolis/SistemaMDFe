VERSION 5.00
Begin VB.Form frmBackup
   ForeColor                =   &H80000008
   BorderStyle              =   2
   Height                   =   3375
   Left                     =   2430
   LinkTopic                =   "Backup"
   LockControls             =   -1
   KeyPreview               =   -1
   MDIChild                 =   -1
   ScaleHeight              =   2940
   ScaleWidth               =   7170
   Top                      =   1915
   Width                    =   7260
   Begin NFE.GPainel Painel
      BackColor                =   &H8000000F
      BevelOuter               =   0
      BevelInner               =   0
      BorderWidth              =   1
      BevelWidth               =   1
      BorderStyle              =   2
      Stretch                  =   -1
      Stripes                  =   0
      SaveGridBars             =   0
      Height                   =   2775
      Left                     =   15
      Width                    =   6990
      Top                      =   15
      TabStop                  =  0
      _extentx                 =   12323
      _extenty                 =   4892
      Index                    =   0 
      Begin NFE.GCpMM mmCampo
         Appearance               =   0
         BackColor                =   &H8000000F
         BorderStyle              =   0
         Stretch                  =   0
         Height                   =   1545
         Left                     =   120
         Width                    =   1455
         Top                      =   120
         Index                    =   0 
         TabStop                  =   0
         ScrollBars               =   0
         Locked                   =   -1
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   -1
         Height                   =   435
         Left                     =   1800
         Width                    =   3570
         Top                      =   540
         Alignment                =   0
         BeginProperty Font
            Name                     =   "Microsoft Sans Serif"
            CharSet                  =   0
            Weight                   =   700
            Size                     =   18
            Underline                =   0
            Italic                   =   0
            StrikeThrough            =   0
         EndProperty
         ForeColor                =   &H80000008
         Caption                  =   "Copia de Segurança"
         Index                    =   0 
      End
      Begin VB.Line Linha
         BorderColor              =   -2147483640
         BorderStyle              =   1
         BorderWidth              =   1
         X1                       =   1845
         Y1                       =   990
         X2                       =   5355
         Y2                       =   990
         Index                    =   0 
      End
      Begin VB.Label labFdo0
         Appearance               =  0
         BorderStyle              =  1
         BackColor                =  &H80000005
         Left                     =   1200
         Top                      =   1680
         Width                    =   5535
         Height                   =   320
      End
      Begin VB.CommandButton bottxtCampo0
         Style                    =   1
         TabStop                  =   0
         Index                    =   0
         Left                     =   6465
         Top                      =   1695
         Width                    =   255
         Height                   =   290
      End
      Begin VB.TextBox txtCp
         Appearance               =   0
         BackColor                =   &H80000005
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851}
            Name                     =   "MS Sans Serif"
            CharSet                  =   0
            Weight                   =   400
            Size                     =   9.75
            Underline                =   0
            Italic                   =   0
            StrikeThrough            =   0
         EndProperty
         ForeColor                =   &H80000008
         MaxLength                =   254
         BorderStyle              =   0
         Alignment                =   0
         TabIndex                 =   0
         TabStop                  =   -1
         Height                   =   290
         Left                     =   1215
         Width                    =   5235
         Top                      =   1695
         Index                    =   0 
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   -1
         Height                   =   240
         Left                     =   180
         Width                    =   855
         Top                      =   1680
         Alignment                =   0
         BeginProperty Font
            Name                     =   "Microsoft Sans Serif"
            CharSet                  =   0
            Weight                   =   700
            Size                     =   9.75
            Underline                =   0
            Italic                   =   0
            StrikeThrough            =   0
         EndProperty
         ForeColor                =   &H80000008
         Caption                  =   "Destino:"
         Index                    =   1 
      End
      Begin NFE.GBotao Botao
         ButtonStyle              =   0
         JoinSeparators           =   0
         LeftSeparator            =   0
         TopSeparator             =   0
         TabIndex                 =   1
         TabStop                  =   -1
         ButtonType               =   0
         Height                   =   345
         Left                     =   5115
         Width                    =   1620
         Top                      =   2220
         CaptionAlign             =   4
         CaptionOffset            =   50
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851}
            Name                     =   "Courier New"
            CharSet                  =   0
            Weight                   =   700
            Size                     =   9.75
            Underline                =   0
            Italic                   =   0
            StrikeThrough            =   0
         EndProperty
         ForeColor                =   &H80000012
         Caption                  =   "Prossegue"
         Index                    =   0 
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   -1
         Height                   =   240
         Left                     =   6540
         Width                    =   45
         Top                      =   2820
         Alignment                =   0
         BeginProperty Font
            Name                     =   "Microsoft Sans Serif"
            CharSet                  =   0
            Weight                   =   400
            Size                     =   9.75
            Underline                =   0
            Italic                   =   0
            StrikeThrough            =   0
         EndProperty
         ForeColor                =   &H80000008
         Caption                  =   "."
         Index                    =   2 
      End
   End
         Begin VB.Timer timUnLoad
                  Enabled         =   0
                  Interval        =   5
                  left            =   30
                  top             =   950
         End
End
Attribute VB_name = "frmBackup"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
'* Sistema...: Emissor de MDF-e (Layout 3.00)
'* Empresa...: Ygor Eduardo Dellalio
'* Módulo....: Backup
'* Função....: Copia de Segurança
'* CopyRight.: (C)2024 Ygor Eduardo Dellalio
'* Criação...: GAS-2007 - Gerador Automático de Sistemas
'* Data......: 05/09/2024 18:10:15
'* * * * * * *

Option Explicit
DefInt A-Z

Public vgSituacao As Integer                      'situação de edição que do módulo
Public vgCaracteristica As Integer                'caracteristica do módulo
Public vgTipo As Integer                          'tipo do módulo
Public vgPriVez As Integer                        'flag de carregamento do módulo  
Public vgFormID As Long                           'identificador único para o módulo 
Public vgIdentTab As String                       'nome da tabela principal do módulo 
Public vgEmBrowse As Integer                      'flag se o módulo esta em grade 
Public vgTemFiltro As Integer                     'flag se tem ou não filtro no módulo
Public vgCancelou As Integer                      'flag cancela ou nao o processo do módulo  
Public vgQueryAtual As String                     'expressão SQL definada para o módulo 

Public vgFP As New frmPreview                     'formuário de preview do relatório 
Public vgTooltips As New cTooltips                'classe de ajuda para os controes do módulo
Public vgFG As frmGauge                           'formulário do gauge 
Public vgQReg As Long                             'quantidade de já feira para o gauge  

Dim txtCampo(0) As New FormataCampos              'classe dos compos tipo texto do módulo  
Dim vgPodeFazerUnLoad As Boolean                  'flag se o módulo pode ou nao ser removido da memória
Dim Destino As String
Public TxtDestino As Object, lblAjuste As Object

Private Sub Backup()
   Dim NomeBackup As String
   
   On Error GoTo DeuErro
   
   If Vazio(Destino) Then
      MsgBox("Por Favor Informe o Destino do Arquivo")
      Exit Sub
   End If
   
   NomeBackup = Destino & "\DADOSNFE_" & Format(Date, "YYYYMMDD") & "T" & Format(Time, "HHMM") & ".BAK"
   
   vgDb(1).Execute "BACKUP DATABASE DADOSNFE TO DISK ='" & NomeBackup & "' WITH FORMAT", True   
   Call Shell("sqlcmd.exe -Lc", vbHide)
   Call Shell("7zG.exe a " & Replace(NomeBackup, ".BAK", ".7z") & " " & NomeBackup, vbHide)
            
   MsgBox "Backup Concluído com Sucesso!!!", vbOKOnly + vbInformation, vaTitulo

DeuErro:
   If Err <> 0 Then
      MsgBox Err.Description, vbOKOnly + vbCritical, vaTitulo
   End If
Unload Me

End Sub

'inicializa variaveis (apelidos) coms os campos correspondentes
Private Sub InicializaApelidos(vgComOQue As Integer)
   On Error Resume Next                           'prepara para possíveis erros
   Destino = txtCampo(0).Value
   If Err Then Err.Clear                          'se deu algum erro, vamos resetá-lo
End Sub

'executa processos/validacoes nos campos do formuário
Public Function Executar(vgOq As String) As String
   Dim vgMsg As String, vgOk As Integer, vgNVez As Integer
   On Error Goto DeuErro                          'fica na espera de um erro...
   vgMsg$ = ""                                    'retorna uma msg dizendo o motivo
   vgOk = True                                    'se a validação esta OK
   vgNVez = 0                                     'porque não fez o processo/validacoes
   If vgOq = INICIALIZACOES Then
      InicializaApelidos COM_TEXTBOX
      On Error Resume Next
         ElseIf vgOq = INI_APELIDOS Then
      InicializaApelidos COM_REGISTRO
   End If
   Executar = vgMsg$                              'prepara saida da função
   Exit Function                                  'e cai fora...

DeuErro:
   Select Case Err                                'vamos verificar se deu algum erro
      Case 3197                                   'registro acabou de ser alterado por outro usuário
         Resume
      Case 3046, 3158, 3186, 3187, 3188, 3189, 3218, 3260
         vgNVez = vgNVez + 1                      'outro usuário acessando
         If vgNVez <= 10 Then                     'vamos tentar 10 vezes
            Delay 0.5                             'mais antes espera 1/2 segundo
            Resume                                'antes de tentar
         End If
   End Select
   Executar = Err.Source + "|" + Trim$(str$(Err)) + "|" + Error$ 'não teve jeito o erro não pode ser evitado...
End Function

'evento - quando o conteúdo do campo for alterado
Private Sub txtCp_Change(Index As Integer)
   If vgPriVez Or txtCampo(Index).PriVez Then Exit Sub
   InicializaApelidos COM_TEXTBOX                         'inicializa apelidos com o que esta sendo digitado
   txtCampo(Index).Change
End Sub

'evento - quando o campo receber o foco
Private Sub txtCp_GotFocus(Index As Integer)
   txtCampo(Index).GotFocus
End Sub


'evento - quando qq tecla for digitada no campo
Private Sub txtCp_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
   txtCampo(Index).KeyDown KeyCode, Shift
End Sub

'evento - quando qq tecla for digitada no campo
Private Sub txtCp_KeyPress(Index As Integer, KeyAscii As Integer)
   txtCampo(Index).KeyPress KeyAscii
End Sub

'evento - quando o campo perder o foco
Private Sub txtCp_LostFocus(Index As Integer)
   txtCampo(Index).LostFocus                      'executa LostFocus na classe
End Sub


'evento - inicialização do formulário
Private Sub Form_Load()
   On Error GoTo DeuErro
   Screen.MousePointer = vbHourglass
   Caption = LoadGasString(15550)
   vgFormID = 637
   vgIdentTab = ""
   vgPriVez = True
   vgPodeFazerUnLoad = False
   vgTipo = TP_COMUM
   vgCaracteristica = F_COMUM
   vgTemFiltro = False
   vgSituacao = ACAO_NAVEGANDO
   Set mmCampo(0).Picture = LoadPicture(LoadGasPicture(7055))
   Set Botao(0).Picture = LoadPicture(LoadGasPicture(7056))
   Set TxtDestino = txtCampo(0)
   Set lblAjuste = Label(2)
   DefineControles
   vgTooltips.Create
   Label(0).Caption = LoadGasString(15555)
   Label(1).Caption = LoadGasString(15556)
   Botao(0).Caption = LoadGasString(15557)
   Label(2).Caption = LoadGasString(15558)
   AjustaTamanho Me
   Executar INICIALIZACOES
   InicializaApelidos COM_TEXTBOX
   Screen.MousePointer = vbDefault
   vgPriVez = False
   Exit Sub

DeuErro:
   CErr.NumErro = Err
   CErr.FunctionName = "Form_Load"
   CErr.Origem = CStr(vgFormID) + " - " + Me.Caption
   CErr.Show
End Sub


'evento - quando o formulário receber o foco
Private Sub Form_Activate()
   AtivaForm Me
End Sub

'evento - redefinido o tamanho do formulário
Private Sub Form_Resize()
   AjustaPanFundo Me
End Sub

'define as propriedades das classe dos campos do formuário
Public Sub DefineControles()
 On Error GoTo DeuErro

   Set txtCampo(0).CtPri = txtCp(0)
   Set txtCampo(0).CtFdo = labFdo0
   Set txtCampo(0).CtBot(BOT_ACAO) = bottxtCampo0(BOT_ACAO)
   Set bottxtCampo0(BOT_ACAO).Picture = LoadPicture(LoadGasPicture(4))
   txtCampo(0).DataType = 0
   txtCampo(0).Mask = ""
   txtCampo(0).BoundColumn = ""
   txtCampo(0).ListFields = ""
   txtCampo(0).OrderFields = ""
   txtCampo(0).Relation = ""
   txtCampo(0).Source = ""

 Exit Sub

 DeuErro:
  CErr.NumErro = Err
  CErr.FunctionName = "DefineControles0"
  CErr.Origem = CStr(vgFormID) +" - "+ Me.Caption
 CErr.Show
End Sub

'evento - antes de descarregar o formulário
Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)
   If vgPodeFazerUnLoad = False Then
      timUnLoad.Enabled = True
      Cancel = True
   End If
   Cancel = Cancel Or(Not vgFG Is Nothing)
End Sub

'evento - descarregando o formulário da memória
Private Sub Form_Unload(Cancel As Integer)
   Dim i As Integer
   On Error Resume Next
   FinalizaForm Me
   Set TxtDestino = Nothing
   Set lblAjuste = Nothing
   For i = 0 To UBound(txtCampo)
      txtCampo(i).Finalize
      Set txtCampo(i) = Nothing
   Next
   Set vgFG = Nothing
   Set vgTooltips = Nothing
   Set frmBackup = Nothing                        'libera o segmento de código do form
End Sub

'evento - quando qq tecla for digitada no formulário
Private Sub Form_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyEscape Then                 'se teclou ESC
      Unload Me                                   'tira este form da memória
   End If
End Sub

'evento - quando o tempo esgotar  
Private Sub timUnLoad_Timer()
   timUnLoad.Enabled = False
   vgPodeFazerUnLoad = True
   Unload Me
End Sub

'evento - quando o botão for pressionado
Private Sub Botao_Click(Index As Integer)
   Dim Cancel As Boolean, hMenu As Long, pt As POINTAPI
   If vgPriVez Then Exit Sub
   Select Case Index
      Case 0
         Backup  
   End Select
End Sub

'evento - quando o botão for pressionado
Private Sub txtCampo_ButtonClick(Index As Integer, Cancel As Boolean)
   If vgPriVez Then Exit Sub
   Select Case Index
      Case 0
         PegaDir2 Me: txtDestino.Text = vaDir
   End Select
End Sub


'evento - quando o botão for apertado
Private Sub bottxtCampo0_Click(Index As Integer)
   Dim Cancel As Boolean
   If Index = BOT_ACAO Then
      txtCampo_ButtonClick 0, Cancel
      Exit Sub
   End If
   DoEvents
   If Not Cancel Then
      txtCampo(0).botClick Index
   End If
End Sub

'evento - quando o mouse for pressionado sobre o campo
Private Sub txtCp_MouseDown(Index As Integer, Button As Integer, Shift As Integer, x as Single, y as Single)
   txtCampo(Index).MouseDown
End Sub

