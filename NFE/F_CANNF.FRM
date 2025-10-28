VERSION 5.00
Begin VB.Form frmF_CanNF
   ForeColor                =   &H80000008
   BorderStyle              =   2
   Height                   =   4110
   Left                     =   1905
   LinkTopic                =   "F_CanNF"
   LockControls             =   -1
   KeyPreview               =   -1
   MDIChild                 =   -1
   ScaleHeight              =   3690
   ScaleWidth               =   6885
   Top                      =   1855
   Width                    =   6975
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
      Height                   =   3510
      Left                     =   15
      Width                    =   6705
      Top                      =   15
      TabStop                  =  0
      _extentx                 =   11820
      _extenty                 =   6188
      Index                    =   0 
      Begin VB.PictureBox picBox
         Appearance               =   1
         BackColor                =   &H8000000F
         BeginProperty Font
            Name                     =   "MS Sans Serif"
            CharSet                  =   0
            Weight                   =   400
            Size                     =   8.25
            Underline                =   0
            Italic                   =   0
            StrikeThrough            =   0
         EndProperty
         ForeColor                =   &H80000008
         BorderStyle              =   0
         Height                   =   1395
         Left                     =   75
         Width                    =   1455
         Top                      =   75
         Index                    =   0 
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   -1
         Height                   =   465
         Left                     =   1695
         Width                    =   3975
         Top                      =   540
         Alignment                =   2
         BeginProperty Font
            Name                     =   "Microsoft Sans Serif"
            CharSet                  =   0
            Weight                   =   700
            Size                     =   20.25
            Underline                =   -1
            Italic                   =   0
            StrikeThrough            =   0
         EndProperty
         ForeColor                =   &H0
         Caption                  =   "Cancela Nota Fiscal"
         Index                    =   0 
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   -1
         Height                   =   240
         Left                     =   135
         Width                    =   1020
         Top                      =   1665
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
         Caption                  =   "Seqüência:"
         Index                    =   1 
      End
      Begin VB.Label labFdo0
         Appearance               =  0
         BorderStyle              =  1
         BackColor                =  &H80000005
         Left                     =   1230
         Top                      =   1635
         Width                    =   1905
         Height                   =   300
      End
      Begin VB.CommandButton bottxtCampo0
         Style                    =   1
         TabStop                  =   0
         Index                    =   1
         Left                     =   2865
         Top                      =   1650
         Width                    =   255
         Height                   =   270
      End
      Begin VB.CommandButton bottxtCampo0
         Style                    =   1
         TabStop                  =   0
         Index                    =   2
         Left                     =   2610
         Top                      =   1650
         Width                    =   255
         Height                   =   270
      End
      Begin VB.TextBox txtCp
         Appearance               =   0
         BackColor                =   &H80000005
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851}
            Name                     =   "Microsoft Sans Serif"
            CharSet                  =   0
            Weight                   =   400
            Size                     =   9.75
            Underline                =   0
            Italic                   =   0
            StrikeThrough            =   0
         EndProperty
         ForeColor                =   &H80000008
         BorderStyle              =   0
         Alignment                =   0
         TabIndex                 =   0
         TabStop                  =   -1
         Height                   =   270
         Left                     =   1245
         Width                    =   1350
         Top                      =   1650
         Index                    =   0 
      End
      Begin NFE.GBotao botOk
         ButtonStyle              =   0
         JoinSeparators           =   0
         LeftSeparator            =   0
         TopSeparator             =   0
         TabIndex                 =   1
         TabStop                  =   -1
         ButtonType               =   0
         Height                   =   360
         Left                     =   3450
         Width                    =   1500
         Top                      =   1605
         CaptionAlign             =   4
         CaptionOffset            =   50
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851}
            Name                     =   "Microsoft Sans Serif"
            CharSet                  =   0
            Weight                   =   400
            Size                     =   9.75
            Underline                =   0
            Italic                   =   0
            StrikeThrough            =   0
         EndProperty
         ForeColor                =   &H80000012
         Caption                  =   "Prossegue"
      End
      Begin NFE.GBotao botCancela
         ButtonStyle              =   0
         JoinSeparators           =   0
         LeftSeparator            =   0
         TopSeparator             =   0
         TabIndex                 =   2
         TabStop                  =   -1
         ButtonType               =   0
         Height                   =   360
         Left                     =   4950
         Width                    =   1500
         Top                      =   1605
         CaptionAlign             =   4
         CaptionOffset            =   50
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851}
            Name                     =   "Microsoft Sans Serif"
            CharSet                  =   0
            Weight                   =   400
            Size                     =   9.75
            Underline                =   0
            Italic                   =   0
            StrikeThrough            =   0
         EndProperty
         ForeColor                =   &H80000012
         Caption                  =   "Cancela"
      End
      Begin VB.TextBox txtCp
         Appearance               =   0
         BackColor                =   &H80000005
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851}
            Name                     =   "Microsoft Sans Serif"
            CharSet                  =   0
            Weight                   =   400
            Size                     =   9.75
            Underline                =   0
            Italic                   =   0
            StrikeThrough            =   0
         EndProperty
         ForeColor                =   &H80000008
         MaxLength                =   254
         BorderStyle              =   1
         Alignment                =   0
         TabIndex                 =   3
         TabStop                  =   -1
         Height                   =   1110
         Left                     =   1230
         Width                    =   5205
         Top                      =   2160
         Index                    =   1 
         MultiLine                =   -1
         ScrollBars               =   2
         MaxLength                =   0
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   -1
         Height                   =   240
         Left                     =   75
         Width                    =   1080
         Top                      =   2160
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
         Caption                  =   "Justificativa:"
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
Attribute VB_name = "frmF_CanNF"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
'* Sistema...: Emissor de Nota Fiscal Eletronica
'* Empresa...: Ygor Eduardo Dellalio
'* Módulo....: F_CanNF
'* Função....: Cancela Nota Fiscal
'* CopyRight.: (C)2016 Ygor Eduardo Dellalio
'* Criação...: GAS-2007 - Gerador Automático de Sistemas
'* Data......: 13/07/2016 13:38:12
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

Dim txtCampo(1) As New FormataCampos              'classe dos compos tipo texto do módulo  
Dim vgPodeFazerUnLoad As Boolean                  'flag se o módulo pode ou nao ser removido da memória
Dim Nota As Double, Justificativa As String
Public txtNota As Object

Private Sub Cancelamento()
   Dim Tb As New GRecordSet, Cancelou As Boolean
      
   On Error GoTo DeuErro
      
   If Nota = 0 Then MsgBox "Favor Informar a Seqüência da Nota Fiscal.", vbExclamation + vbOKOnly, vaTitulo: Exit Sub
   If MsgBox("Deseja Realmente Cancelar essa Nota Fiscal?" & vbCrLf & "Essa Operação é Irreversível.", vbExclamation + vbYesNo, vaTitulo) = vbNo Then Exit Sub
   
   vgDb.BeginTrans 'Inicia a transação
   
   Set Tb = vgDb.OpenRecordSet("SELECT [Sequencia da nota fiscal],[Numero da nfe], " & _
                               "Autorizada,[Chave de acesso da nfe],[Protocolo de autorização] " & _
                               "FROM [Nota Fiscal] WHERE [Sequencia da nota fiscal] = " & Nota) 
                               
      
   'Apartir de 01/12/2012 só será aceito cancelamento por evento
   'Começou a usar Apartir de 08/11/2012
   If Tb![Numero da nfe] > 0 And Tb!Autorizada Then
      CancelaNFeEvento Tb![Chave de acesso da nfe], Tb![Protocolo de autorização], Tb![Sequencia da nota fiscal], Cancelou 'Cancelando...
   Else
      Cancelou = True
   End If
         
   If Cancelou = False Then
      vgDb.RollBackTrans
      MsgBox "NÃO foi Possível Realizar o Cancelamento!!!", vbCritical + vbOKOnly, vaTitulo
      Exit Sub
   End If
   
   'Marcando Nota Cancelada na Tabela de Nota Fiscal e se nw Tinha Autorizado antes, vamos recuperar o Numero da Eletronica
   'Marcar cancelado nas tabelas que gerou a nota
   If Tb!Autorizada Then
      vgDb.Execute "Update [Nota fiscal] Set [Nota cancelada] = 1 Where [Sequencia da nota fiscal] = " & Nota 'Nota Fiscal
   Else
      vgDb.Execute "Update [Nota Fiscal] Set [Nota cancelada] = 1, [Numero da nfe] = 0 Where [Sequencia da nota fiscal] = " & Nota
   End If
          
   vgDb.CommitTrans 
   
   MsgBox "Nota Cancelada com Sucesso!!!", vbInformation + vbOKOnly, vaTitulo 'Suuuuuceeeeesssssoooo
   
   frmNotaFisc.Show
   frmNotaFisc.SetFocus
   PosicionaRegistro frmNotaFisc, "Sequencia da nota fiscal", Nota
   frmNotaFisc.Reposition
   frmNotaFisc.DANFE
   
DeuErro:
   If Err.Number <> 0 Then
      vgDb.RollBackTrans
      MsgBox Err.Description, vbCritical + vbOKOnly, vaTitulo
   End If
   Unload Me
End Sub


'Cancelamento da NFe como Evento (A Partir de 01/12/2012)
'É Necessario atualizar a dll para a versao 1.0 ou superior
Private Sub CancelaNFeEvento(chaveNFe As String, Protocolo As String, Nota As Long, ByRef Cancelou As Boolean)
   Dim msgDados As String, msgRetWS As String, msgResultado As String, siglaUF As String, siglaWS As String, certificado As String
   Dim licenca As String, ambiente As Integer, JustificativaEvento As String, procCancNFe As String, nProtocoloCanc As String
   Dim dProtocoloCanc As String, versao As String, cStat As Long, objNFeUtil As Object, Arq As Long, dhEvento As String
   Dim proxy As String, usuario As String, senha As String, NotaFiscal As New GRecordSet
   
   On Error GoTo DeuErro
   
   Screen.MousePointer = vbHourglass    ' ampulheta
   Set objNFeUtil = CreateObject("NFe_util_2G.util")
   Set NotaFiscal = vgDb.OpenRecordSet("SELECT * FROM [Nota fiscal] WHERE [Sequencia da nota fiscal] = " & Nota)
   lblProgresso.Caption = "Cancelando NFe..."
   Cancelou = False
   
   licenca = Empresa![Chave flexdocs] 
   certificado = Parametros_da_nfe![Certificado digital]
   siglaWS = "SP3"
   'versao = "2.00"
   versao = "1.00" 'Cancelamento como Evento a Versao passa a ser 1.00
   
   If chaveNFe = "" Then
      MsgBox "Necessário informar a chave de acesso da NFe para cancelamento da NFe.", vbCritical + vbOKOnly, vaTitulo
      GoTo SaiDaSub
   End If
   
   If Protocolo = "" Then
      MsgBox "Necessário informar o número do protocolo da autorização de uso da NFe para cancelamento da NFe.", vbCritical + vbOKOnly, vaTitulo
      GoTo SaiDaSub
   End If

   'Justificativa = InputBox("Informe a Justificativa do Cancelamento", "Cancelamento de NFe")
   'Hoje Lançamos a Justificativa na tabela de Cancelamento
   JustificativaEvento = Replace(Justificativa, vbCrLf, " ")
   
   If Len(JustificativaEvento) < 15 Then
      MsgBox "Necessário informar a justificativa com no mínimo 15 caracteres", vbCritical + vbOKOnly, vaTitulo
      GoTo SaiDaSub
   End If

   If Parametros_da_nfe!Ambiente = 0 Then 'Produção
      ambiente = 1
   Else 'Homologação
      ambiente = 2
   End If
   
   'Cancelando...
   procCancNFe = objNFeUtil.CancelaNFEvento(siglaWS, ambiente, certificado, versao, msgDados, msgRetWS, cStat, msgResultado, chaveNFe, Protocolo, JustificativaEvento, dhEvento, nProtocoloCanc, dProtocoloCanc, proxy, usuario, senha, licenca)
      
   With NotaFiscal
      .Edit
      If Vazio(!Observação) Then
         !Observação = "Cancelando NFe..."
      Else
         !Observação = !Observação & vbCrLf & "Cancelando NFe..."
      End If
      .Update
      .BookMark = .LastModified
   End With

   'Verificando Status
   '101 - cancelamento de NF-e homologado
   '151 - cancelamento de NF-e homologado fora de prazo (depende da UF, pode haver multa)
   '135 - Evento registrado e vinculado a NF-e (cancelamento de NF-e homologado)
   If cStat = 101 Or cStat = 151 Or cStat = 135 Or cStat = 155 Then
           
      With NotaFiscal
         .Edit
         !Observação = !Observação & vbCrLf & "NFe Cancelada com Sucesso!!!"
         .Update
         .BookMark = .LastModified
      End With
   
      'MsgBox msgResultado, vbInformation + vbOKOnly, vaTitulo
      'Vamos Informar que a nota foi cancelada somente no final
      'pois existes varios processos antes de concluir o cancelamento
      Cancelou = True
      
      'Salvando o xml...
      Arq = FreeFile
      If Parametros_da_nfe!Ambiente = 0 Then 'Produção
         Open Parametros_da_nfe![Diretorio 1 nfe produção] & Format(NotaFiscal![Numero da nfe], "000000") & "_CANCELADO.xml" For Append As #Arq
            Print #Arq, procCancNFe
         Close #Arq
      Else 'Homologação
         Open Parametros_da_nfe![Diretorio 1 nfe homologação] & Format(NotaFiscal![Numero da nfe], "000000") & "_CANCELADO.xml" For Append As #Arq
            Print #Arq, procCancNFe
         Close #Arq
      End If
      GoTo SaiDaSub
   Else
      MsgBox msgResultado, vbCritical + vbOKOnly, "Atenção: Cancelamento da NFe Falhou"
      
      'Historico
      With NotaFiscal
         .Edit
         !Observação = !Observação & vbCrLf & "Erro ao Cancelar NFe: " & msgResultado
         .Update
         .BookMark = .LastModified
      End With
      GoTo SaiDaSub
   End If

DeuErro:
   If Err <> 0 Then
      MsgBox Err.Description, vbCritical + vbOKOnly, vaTitulo
   End If
   
SaiDaSub:
   Set objNFeUtil = Nothing
   Screen.MousePointer = vbDefault ' normal
   lblProgresso.Caption = ""
         
End Sub

'inicializa variaveis (apelidos) coms os campos correspondentes
Private Sub InicializaApelidos(vgComOQue As Integer)
   On Error Resume Next                           'prepara para possíveis erros
   Nota = txtCampo(0).Value
   Justificativa = txtCampo(1).Value
   If Err Then Err.Clear                          'se deu algum erro, vamos resetá-lo
End Sub

'poe relacionamento e filtro na lista externa (combobox)
Private Sub PoeRelEFiltroCbo(Index As Integer)
   On Error Resume Next
   Select Case Index
      Case 0
         txtCampo(0).Filter = "([Sequencia da nota fiscal] > " & 0 & ") AND [Nota cancelada] = " & 0 & ""
                           txtCampo(0).PesqSQLExpression = "SELECT [Nota fiscal].[Sequencia da nota fiscal], [Nota fiscal].[Numero da nfe], [Nota fiscal].[Data de emissão], " + _
                                                              "[Nota fiscal].[Sequencia do geral], Geral.[Razão social] FROM [Nota fiscal], Geral WHERE ([Nota fiscal].[Sequencia da nota fiscal] > " + CStr(0) + ") AND " + _
                                                              "([Nota fiscal].[Nota cancelada] = " + CStr(0) + ") AND ([Nota fiscal].[Sequencia do geral] = Geral.[Sequencia do geral])"
   End Select
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
      txtCampo(1).Value = "Erro de Digitação"
   ElseIf vgOq = INI_APELIDOS Then
      InicializaApelidos COM_REGISTRO
      ExecutaPreValidacao
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

'executa a pré-validação dos campos
Private Sub ExecutaPreValidacao()
   Dim Ok As Boolean
   On Error Resume Next                           'prepara para possiveis erros
   Ok = (False)
   txtCampo(0).Enabled = (Ok And txtCampo(0).Editable)
   If Err Then Err.Clear                          'se houve erro, limpa...
End Sub

'evento - quando o conteúdo do campo for alterado
Private Sub txtCp_Change(Index As Integer)
   If vgPriVez Or txtCampo(Index).PriVez Then Exit Sub
   InicializaApelidos COM_TEXTBOX                         'inicializa apelidos com o que esta sendo digitado
   txtCampo(Index).Change
   If Index = 0 Then
      ExecutaPreValidacao
   End If
End Sub

'evento - quando o campo receber o foco
Private Sub txtCp_GotFocus(Index As Integer)
         On Error Resume Next
         Select Case Index
         Case 0
            PoeRelEFiltroCbo 0
         Case 1
            If Len(txtCp(1).Text) = 0 Then
               txtCampo(1).Value = "Erro de Digitação"
               txtCp_Change Index
               InicializaApelidos COM_TEXTBOX
               ExecutaPreValidacao
            End If
      End Select
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
   ExecutaPreValidacao                            'habilita/desabilita campos
End Sub


'evento - inicialização do formulário
Private Sub Form_Load()
   On Error GoTo DeuErro
   Screen.MousePointer = vbHourglass
   Caption = LoadGasString(16610)
   vgFormID = 628
   vgIdentTab = ""
   vgPriVez = True
   vgPodeFazerUnLoad = False
   vgTipo = TP_COMUM
   vgCaracteristica = F_COMUM
   vgTemFiltro = False
   vgSituacao = ACAO_NAVEGANDO
   Set picBox(0).Picture = LoadPicture(LoadGasPicture(8115))
   Set botOk.Picture = LoadPicture(LoadGasPicture(8116))
   Set botCancela.Picture = LoadPicture(LoadGasPicture(8117))
   Set txtNota = txtCampo(0)
   DefineControles
   vgTooltips.Create
   Label(0).Caption = LoadGasString(16615)
   Label(1).Caption = LoadGasString(16616)
   vgTooltips.AddTool botOk, 0, LoadGasString(16617)
   botOk.Caption = LoadGasString(16618)
   vgTooltips.AddTool botCancela, 0, LoadGasString(16619)
   botCancela.Caption = LoadGasString(16620)
   Label(2).Caption = LoadGasString(16621)
   AjustaTamanho Me
   Executar INICIALIZACOES
   InicializaApelidos COM_TEXTBOX
   ExecutaPreValidacao
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
   Dim i As Integer
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
   Set txtCampo(0).CtBot(BOT_LISTA) = bottxtCampo0(BOT_LISTA)
   Set txtCampo(0).CtBot(BOT_COMBO) = bottxtCampo0(BOT_COMBO)
   bottxtCampo0(BOT_LISTA).Caption = "P"
   Set bottxtCampo0(BOT_COMBO).Picture = LoadPicture(LoadGasPicture(3))
   txtCampo(0).DataType = 1
   txtCampo(0).Mask = ""
   txtCampo(0).PesqModoAbertura =  2 
   txtCampo(0).PesqFieldCapture = "[Nota fiscal].[Sequencia da nota fiscal]"
   txtCampo(0).BoundColumn = "Sequencia da nota fiscal"
   txtCampo(0).ListFields = "Sequencia da nota fiscal"
   txtCampo(0).OrderFields = "Sequencia da nota fiscal-"
   txtCampo(0).Relation = ""
   txtCampo(0).Source = "Nota fiscal"
   txtCampo(0).vgfrmGMCale.grdListaG.AutoRebind = True

   Set txtCampo(1).CtPri = txtCp(1)
   txtCampo(1).DataType = 4
   txtCampo(1).Mask = ""
   txtCampo(1).BoundColumn = ""
   txtCampo(1).ListFields = ""
   txtCampo(1).OrderFields = ""
   txtCampo(1).Relation = ""
   txtCampo(1).Source = ""

 Exit Sub

 DeuErro:
  CErr.NumErro = Err
  CErr.FunctionName = "DefineControles0"
  CErr.Origem = CStr(vgFormID) +" - "+ Me.Caption
 CErr.Show
End Sub

'evento - valida digitações e prossegue a execução
Private Sub botOk_Click()
   Dim k As String
   If vgPriVez Then Exit Sub
   vgPriVez = True
   k$ = Executar(VALIDACOES)                      'faz validaçao dos campos
   If Len(k$) > 0 Then                            'EPA!... tem campo errado
      If Instr(k$, "|") > 0 Then
         Err.Source = Parse$(k$, "|")
         Err.Number = Val(Parse$(k$, "|"))        'deu erro
         Err.Description = Parse$(k$, "|")
         CErr.NumErro = Err.Number
         CErr.Show
      Else
         Beep                                     'manda aviso sonoro
         MsgBox k$, vbCritical, vgAtencao$        'mostra mensagem do erro
      End If
      Screen.MousePointer = vbDefault             'reseta o pointer do mouse
      vgPriVez = False
      Exit Sub                                    'e sai para continuar a ediçao ou inclusao
   End If                                         'OK. os campos estao certos
   Cancelamento  
   vgPriVez = False
End Sub

'evento - cancela formulário
Private Sub botCancela_Click()
   Unload Me
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
   Set txtNota = Nothing
   For i = 0 To UBound(txtCampo)
      txtCampo(i).Finalize
      Set txtCampo(i) = Nothing
   Next
   Set vgFG = Nothing
   Set vgTooltips = Nothing
   Set frmF_CanNF = Nothing                       'libera o segmento de código do form
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


'evento - quando o botão for apertado
Private Sub bottxtCampo0_Click(Index As Integer)
   txtCampo(0).SetFocus
   DoEvents
   txtCampo(0).botClick Index
End Sub

'evento - quando o mouse for pressionado sobre o campo
Private Sub txtCp_MouseDown(Index As Integer, Button As Integer, Shift As Integer, x as Single, y as Single)
   txtCampo(Index).MouseDown
End Sub

