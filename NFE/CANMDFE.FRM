VERSION 5.00
Begin VB.Form frmCanMDFe
   ForeColor                =   &H80000008
   BorderStyle              =   2
   Height                   =   4155
   Left                     =   4545
   LinkTopic                =   "CanMDFe"
   LockControls             =   -1
   KeyPreview               =   -1
   MDIChild                 =   -1
   ScaleHeight              =   3720
   ScaleWidth               =   6915
   Top                      =   2020
   Width                    =   7005
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
      Height                   =   3540
      Left                     =   15
      Width                    =   6735
      Top                      =   15
      TabStop                  =  0
      _extentx                 =   11873
      _extenty                 =   6241
      Index                    =   0 
      Begin NFE.GCpMM mmCampo
         Appearance               =   0
         BackColor                =   &H8000000F
         BorderStyle              =   0
         Stretch                  =   0
         Height                   =   1530
         Left                     =   0
         Width                    =   1455
         Top                      =   60
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
         Left                     =   1560
         Width                    =   3225
         Top                      =   420
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
         Caption                  =   "Cancela Manifesto"
         Index                    =   0 
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   -1
         Height                   =   240
         Left                     =   300
         Width                    =   1080
         Top                      =   1620
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
         Index                    =   1 
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
         TabIndex                 =   0
         TabStop                  =   -1
         Height                   =   1140
         Left                     =   1575
         Width                    =   5010
         Top                      =   1620
         Index                    =   0 
         MultiLine                =   -1
         ScrollBars               =   2
         MaxLength                =   0
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
         Left                     =   3360
         Width                    =   1500
         Top                      =   2940
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
         Left                     =   4860
         Width                    =   1500
         Top                      =   2940
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
      Begin VB.Line Linha
         BorderColor              =   -2147483640
         BorderStyle              =   1
         BorderWidth              =   1
         X1                       =   1620
         Y1                       =   870
         X2                       =   4785
         Y2                       =   870
         Index                    =   0 
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   -1
         Height                   =   240
         Left                     =   6600
         Width                    =   45
         Top                      =   3600
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
      Begin VB.TextBox txtCp
         Appearance               =   0
         BackColor                =   &HE0E0E0
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
         BorderStyle              =   1
         Alignment                =   1
         Locked                   =   -1
         TabIndex                 =   3
         TabStop                  =   -1
         Height                   =   300
         Left                     =   1560
         Width                    =   495
         Top                      =   1200
         TabStop                  =  0
         Index                    =   1 
         MultiLine                =   -1
      End
   End
         Begin VB.Timer timUnLoad
                  Enabled         =   0
                  Interval        =   5
                  left            =   30
                  top             =   950
         End
End
Attribute VB_name = "frmCanMDFe"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
'* Sistema...: Emissor de MDF-e (Layout 3.00)
'* Empresa...: Ygor Eduardo Dellalio
'* Módulo....: CanMDFe
'* Função....: Cancela Manifesto
'* CopyRight.: (C)2024 Ygor Eduardo Dellalio
'* Criação...: GAS-2007 - Gerador Automático de Sistemas
'* Data......: 05/09/2024 18:10:13
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
Dim Justificativa As String, Nota As Double
Public lblAjuste As Object, txtNota As Object

Private Sub Cancelamento()
   Dim Tb As New GRecordSet, Cancelou As Boolean
      
   On Error GoTo DeuErro
      
   If Nota = 0 Then MsgBox "Favor Informar a Seqüência do Manifesto.", vbExclamation + vbOKOnly, vaTitulo: Exit Sub
   If MsgBox("Deseja Realmente Cancelar esse Manifesto?" & vbCrLf & "Essa Operação é Irreversível.", vbExclamation + vbYesNo, vaTitulo) = vbNo Then Exit Sub
   
   vgDb.BeginTrans 'Inicia a transação
   
   Set Tb = vgDb.OpenRecordSet("SELECT * From Manifesto WHERE [Sequencia do Manifesto] = " & Nota) 
                              
   If Tb![Numero Do Manifesto] > 0 And Tb!Autorizada Then
      CancelaMDFe Tb![Chave de Acesso], Tb![Protocolo de Autorização], Tb![Sequencia Do Manifesto], Cancelou 'Cancelando...
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
      vgDb.Execute "Update Manifesto Set [Nota Cancelada] = 1 Where [Sequencia do Manifesto] = " & Nota 
   Else
      vgDb.Execute "Update Manifesto Set [Nota Cancelada] = 1, [Numero do manifesto] = 0 Where [Sequencia do Manifesto] = " & Nota
   End If
 
   vgDb.CommitTrans 'Vomitando opsss Comitando rsrs
   
   MsgBox "Manifesto Cancelado com Sucesso!!!", vbInformation + vbOKOnly, vaTitulo 'Suuuuuceeeeesssssoooo
   
   frmMDFe.Show
   frmMDFe.SetFocus
   PosicionaRegistro frmMDFe, "Sequencia do Manifesto", Nota
   frmMDFe.Reposition
   frmMDFe.DAMDFE
   
DeuErro:
   If Err.Number <> 0 Then
      vgDb.RollBackTrans
      MsgBox Err.Description, vbCritical + vbOKOnly, vaTitulo
   End If
   Unload Me
End Sub


Private Sub CancelaMDFe(chaveMDFe As String, Protocolo As String, Nota As Long, ByRef Cancelou As Boolean)
   Dim msgDados As String, msgRetWS As String, msgResultado As String, siglaWS As String, certificado As String
   Dim licenca As String, ambiente As Integer, JustificativaEvento As String, nProtocoloCanc As String
   Dim dProtocoloCanc As String, versao As String, Resultado As Long, objMDFeUtil As Object, Arq As Long, dhEvento As String
   Dim proxy As String, usuario As String, senha As String, Emitente As New GRecordSet, ProcCanMDFe As String
   Dim Manifesto As New GRecordSet, NomeEmitente As String
   
   On Error GoTo DeuErro
   
   Screen.MousePointer = vbHourglass    ' ampulheta
   Set objMDFEUtil = CreateObject("MDFe_Util.Util")
   Set Manifesto = vgDb.OpenRecordSet("SELECT * FROM Manifesto WHERE [Sequencia do Manifesto] = " & Nota)
   Set Emitente = VgDb.OpenRecordSet("SELECT * From [Emitentes MDFe] WHERE [Sequencia do Emitente] = " & Manifesto![Codigo Do Emitente])
   NomeEmitente = UCASE(Mid(Emitente![Razão Social],1,5))
   lblProgresso.Caption = "Cancelando MDFe..."
   Cancelou = False
   
   licenca = Emitente![Chave Flexdocs]
   certificado = Emitente![Certificado Digital]
   siglaWS = "RS"
   versao = "3.00" 'Cancelamento como Evento a Versao passa a ser 3.00
   
   If Not Parametros_da_nfe![Horario de verao] Then ' Horario de Brasilia normal
      dhEvento = ""'Format(Now,"yyyy-MM-ddThh:mm:ss-02:00") 'data de emissão em Formato UTC
   Else
      dhEvento = ""'Format(Now,"yyyy-MM-ddThh:mm:ss-03:00") 'data de emissão em Formato UTC no Horario de Verão - Brasilia  
   End If  
 
   If chaveMDFe = "" Then
      MsgBox "Necessário informar a chave de acesso do MDFe para cancelamento do Mesmo.", vbCritical + vbOKOnly, vaTitulo
      GoTo SaiDaSub
   End If
   
   If Protocolo = "" Then
      MsgBox "Necessário informar o número do protocolo da autorização de uso para cancelamento do Mesmo.", vbCritical + vbOKOnly, vaTitulo
      GoTo SaiDaSub
   End If

   JustificativaEvento = Replace(Justificativa, vbCrLf, " ")
   
   If Len(JustificativaEvento) < 15 Then
      MsgBox "Necessário informar a justificativa com no mínimo 15 caracteres", vbCritical + vbOKOnly, vaTitulo
      GoTo SaiDaSub
   End If

   If Parametros_da_NFe!ambiente = 0 Then 'Produção
      ambiente = 1
   Else 'Homologação
      ambiente = 2
   End If
   
   'Cancelando...
   ProcCanMDFe = objMDFeUtil.CancelaMDFe(siglaWS, ambiente, certificado, versao, msgDados, msgRetWS, Resultado, msgResultado, chaveMDFe, Protocolo, JustificativaEvento, dhEvento, nProtocoloCanc, dProtocoloCanc, proxy, usuario, senha, licenca)
      
   With Manifesto
      .Edit
      If Vazio(!Observação) Then
         !Observação = "Cancelando MDFe..."
      Else
         !Observação = !Observação & vbCrLf & "Cancelando MDFe..."
      End If
      .Update
      .BookMark = .LastModified
   End With

   'Verificando Status
   '101 - cancelamento de NF-e homologado
   '151 - cancelamento de NF-e homologado fora de prazo (depende da UF, pode haver multa)
   '135 - Evento registrado e vinculado a NF-e (cancelamento de NF-e homologado)
   If Resultado = 135 Then
           
      With Manifesto
         .Edit
         !Observação = !Observação & vbCrLf & "MDFe Cancelado com Sucesso!!!"
         .Update
         .BookMark = .LastModified
      End With
   
      'MsgBox msgResultado, vbInformation + vbOKOnly, vaTitulo
      'Vamos Informar que a nota foi cancelada somente no final
      'pois existes varios processos antes de concluir o cancelamento
      Cancelou = True
      
      'Salvando o xml...
      Arq = FreeFile
      If Parametros_da_NFe!ambiente = 0 Then 'Produção
         Open Parametros_da_NFe![Diretorio 1 NFe Produção] & NomeEmitente & Format(Manifesto![Numero Do Manifesto], "000000") & "_CANCELADO.xml" For Append As #Arq
            Print #Arq, ProcCanMDFe
         Close #Arq
      Else 'Homologação
         Open Parametros_da_NFe![Diretorio 1 NFe Homologação] & NomeEmitente & Format(Manifesto![Numero Do Manifesto], "000000") & "_CANCELADO.xml" For Append As #Arq
            Print #Arq, ProcCanMDFe
         Close #Arq
      End If
      GoTo SaiDaSub
   Else
      MsgBox msgResultado, vbCritical + vbOKOnly, "Atenção: Cancelamento do MDFe Falhou"
      
      'Historico
      With Manifesto
         .Edit
         !Observação = !Observação & vbCrLf & "Erro ao Cancelar MDFe: " & msgResultado
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
   Set objMDFeUtil = Nothing
   Screen.MousePointer = vbDefault ' normal
   lblProgresso.Caption = ""
         
End Sub

'inicializa variaveis (apelidos) coms os campos correspondentes
Private Sub InicializaApelidos(vgComOQue As Integer)
   On Error Resume Next                           'prepara para possíveis erros
   Justificativa = txtCampo(0).Value
   Nota = txtCampo(1).Value
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
            txtCampo(0).Value = "Erro de Digitacao"
   ElseIf vgOq = INI_APELIDOS Then
      InicializaApelidos COM_REGISTRO
      ExecutaVisivel
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

'coloca os campos visíveis segundo a condição
Private Sub ExecutaVisivel()
   On Error Resume Next                           'prepara para possiveis erros
   txtCampo(1).Visible = (False)
   If Err Then Err.Clear                          'se houve erro, limpa...
End Sub

'evento - quando o conteúdo do campo for alterado
Private Sub txtCp_Change(Index As Integer)
   If vgPriVez Or txtCampo(Index).PriVez Then Exit Sub
   InicializaApelidos COM_TEXTBOX                         'inicializa apelidos com o que esta sendo digitado
   txtCampo(Index).Change
End Sub

'evento - quando o campo receber o foco
Private Sub txtCp_GotFocus(Index As Integer)
         On Error Resume Next
         Select Case Index
         Case 0
            If Len(txtCp(0).Text) = 0 Then
               txtCampo(0).Value = "Erro de Digitacao"
               txtCp_Change Index
               InicializaApelidos COM_TEXTBOX
               ExecutaVisivel
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
   ExecutaVisivel                                 'torna camos visiveis
End Sub


'evento - inicialização do formulário
Private Sub Form_Load()
   On Error GoTo DeuErro
   Screen.MousePointer = vbHourglass
   Caption = LoadGasString(15130)
   vgFormID = 647
   vgIdentTab = ""
   vgPriVez = True
   vgPodeFazerUnLoad = False
   vgTipo = TP_COMUM
   vgCaracteristica = F_COMUM
   vgTemFiltro = False
   vgSituacao = ACAO_NAVEGANDO
   Set mmCampo(0).Picture = LoadPicture(LoadGasPicture(6635))
   Set botOk.Picture = LoadPicture(LoadGasPicture(6636))
   Set botCancela.Picture = LoadPicture(LoadGasPicture(6637))
   Set lblAjuste = Label(2)
   Set txtNota = txtCampo(1)
   DefineControles
   vgTooltips.Create
   Label(0).Caption = LoadGasString(15135)
   Label(1).Caption = LoadGasString(15136)
   vgTooltips.AddTool botOk, 0, LoadGasString(15137)
   botOk.Caption = LoadGasString(15138)
   vgTooltips.AddTool botCancela, 0, LoadGasString(15139)
   botCancela.Caption = LoadGasString(15140)
   Label(2).Caption = LoadGasString(15141)
   AjustaTamanho Me
   Executar INICIALIZACOES
   InicializaApelidos COM_TEXTBOX
   ExecutaVisivel
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
   txtCampo(0).DataType = 4
   txtCampo(0).Mask = ""
   txtCampo(0).BoundColumn = ""
   txtCampo(0).ListFields = ""
   txtCampo(0).OrderFields = ""
   txtCampo(0).Relation = ""
   txtCampo(0).Source = ""

   Set txtCampo(1).CtPri = txtCp(1)
   txtCampo(1).DataType = 1
   txtCampo(1).Mask = ""
   txtCampo(1).Editable = False
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
   Set lblAjuste = Nothing
   Set txtNota = Nothing
   For i = 0 To UBound(txtCampo)
      txtCampo(i).Finalize
      Set txtCampo(i) = Nothing
   Next
   Set vgFG = Nothing
   Set vgTooltips = Nothing
   Set frmCanMDFe = Nothing                       'libera o segmento de código do form
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


'evento - quando o mouse for pressionado sobre o campo
Private Sub txtCp_MouseDown(Index As Integer, Button As Integer, Shift As Integer, x as Single, y as Single)
   txtCampo(Index).MouseDown
End Sub

