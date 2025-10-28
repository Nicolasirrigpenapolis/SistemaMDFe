VERSION 5.00
Begin VB.Form frmEncMDFe
   ForeColor                =   &H80000008
   BorderStyle              =   2
   Height                   =   3585
   Left                     =   4140
   LinkTopic                =   "EncMDFe"
   LockControls             =   -1
   KeyPreview               =   -1
   MDIChild                 =   -1
   ScaleHeight              =   3150
   ScaleWidth               =   9180
   Top                      =   2695
   Width                    =   9270
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
      Height                   =   2970
      Left                     =   15
      Width                    =   9000
      Top                      =   15
      TabStop                  =  0
      _extentx                 =   15866
      _extenty                 =   5236
      Index                    =   0 
      Begin NFE.GCpMM mmCampo
         Appearance               =   0
         BackColor                =   &H8000000F
         BorderStyle              =   0
         Stretch                  =   0
         Height                   =   1275
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
         Left                     =   1860
         Width                    =   3165
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
         Caption                  =   "Encerra Manifesto"
         Index                    =   0 
      End
      Begin VB.Line Linha
         BorderColor              =   -2147483640
         BorderStyle              =   1
         BorderWidth              =   1
         X1                       =   1920
         Y1                       =   870
         X2                       =   5055
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
         Left                     =   8760
         Width                    =   45
         Top                      =   2880
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
         Index                    =   1 
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
         Alignment                =   0
         Locked                   =   -1
         TabIndex                 =   0
         TabStop                  =   0
         Height                   =   270
         Left                     =   1920
         Width                    =   510
         Top                      =   1200
         TabStop                  =  0
         Index                    =   0 
         MultiLine                =   -1
      End
      Begin VB.Label labFdo1
         Appearance               =  0
         BorderStyle              =  1
         BackColor                =  &H80000005
         Left                     =   1920
         Top                      =   1560
         Width                    =   5115
         Height                   =   270
      End
      Begin VB.CommandButton bottxtCampo1
         Style                    =   1
         TabStop                  =   0
         Index                    =   1
         Left                     =   6765
         Top                      =   1575
         Width                    =   255
         Height                   =   240
      End
      Begin VB.CommandButton bottxtCampo1
         Style                    =   1
         TabStop                  =   0
         Index                    =   2
         Left                     =   6510
         Top                      =   1575
         Width                    =   255
         Height                   =   240
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
         BorderStyle              =   0
         Alignment                =   0
         TabIndex                 =   1
         TabStop                  =   -1
         Height                   =   240
         Left                     =   1935
         Width                    =   4560
         Top                      =   1575
         Index                    =   1 
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   -1
         Height                   =   240
         Left                     =   240
         Width                    =   1425
         Top                      =   1560
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
         Caption                  =   "* Município.........:"
         Index                    =   2 
      End
      Begin VB.Label labFdo2
         Appearance               =  0
         BorderStyle              =  1
         BackColor                =  &H80000005
         Left                     =   7800
         Top                      =   1560
         Width                    =   840
         Height                   =   270
      End
      Begin VB.CommandButton bottxtCampo2
         Style                    =   1
         TabStop                  =   0
         Index                    =   2
         Left                     =   8370
         Top                      =   1575
         Width                    =   255
         Height                   =   240
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
         BorderStyle              =   0
         Alignment                =   0
         TabIndex                 =   2
         TabStop                  =   -1
         Height                   =   240
         Left                     =   7815
         Width                    =   540
         Top                      =   1575
         Index                    =   2 
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   -1
         Height                   =   240
         Left                     =   7200
         Width                    =   435
         Top                      =   1560
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
         Caption                  =   "* UF:"
         Index                    =   3 
      End
      Begin NFE.GBotao botOk
         ButtonStyle              =   0
         JoinSeparators           =   0
         LeftSeparator            =   0
         TopSeparator             =   0
         TabIndex                 =   3
         TabStop                  =   -1
         ButtonType               =   0
         Height                   =   360
         Left                     =   5655
         Width                    =   1500
         Top                      =   2235
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
         TabIndex                 =   4
         TabStop                  =   -1
         ButtonType               =   0
         Height                   =   360
         Left                     =   7155
         Width                    =   1500
         Top                      =   2235
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
   End
         Begin VB.Timer timUnLoad
                  Enabled         =   0
                  Interval        =   5
                  left            =   30
                  top             =   950
         End
End
Attribute VB_name = "frmEncMDFe"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
'* Sistema...: Emissor de MDF-e (Layout 3.00)
'* Empresa...: Ygor Eduardo Dellalio
'* Módulo....: EncMDFe
'* Função....: Encerra Manifesto
'* CopyRight.: (C)2024 Ygor Eduardo Dellalio
'* Criação...: GAS-2007 - Gerador Automático de Sistemas
'* Data......: 05/09/2024 18:10:14
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

Dim txtCampo(2) As New FormataCampos              'classe dos compos tipo texto do módulo  
Dim vgPodeFazerUnLoad As Boolean                  'flag se o módulo pode ou nao ser removido da memória
Dim Nota As Double, CodigoIbge As String, UfTermina As String
Public lblAjuste As Object, txtNota As Object

Private Sub EncerraMDFe()
 Dim siglaWS As String, Ambiente As Integer, Certificado As String, Versao As String, EventoMDFe As String
 Dim msgDados As String, msgRetWS As String, Resultado As Long, msgResultado As String, objMDFeUtil As Object
 Dim ChaveMDFe As String, nProtocolo As String, dtEnc As String, cUFEnc As String, cMunEnc As String, Arq As Long
 Dim dataEvento As String, nProtocoloEnc As String, dProtocoloEnc As String, proxy As String, usuario As String
 Dim Senha As String, Licenca As String, Emitente As New GRecordSet, Manifesto As New GRecordSet, NomeEmitente As String
 
   On Error GoTo DeuErro
   
   If CodigoIbge = "" Then
      MsgBox("Informe o Município de Encerramento")
      Exit Sub
   End If
 
   Set Manifesto = vgDb.OpenRecordSet("SELECT * FROM Manifesto WHERE [Sequencia do Manifesto] = " & Nota)
   Set Emitente = VgDb.OpenRecordSet("SELECT * From [Emitentes MDFe] WHERE [Sequencia do Emitente] = " & Manifesto![Codigo Do Emitente])
   NomeEmitente = UCASE(Mid(Emitente![Razão Social],1,5))
 
   siglaWS = "RS"
 
   If Parametros_da_NFe!ambiente = 0 Then 'Produção
      Ambiente = 1
   Else 'Homologação
      Ambiente = 2
   End If
   
   Certificado = Emitente![Certificado Digital]
   Versao = "3.00"
   ChaveMDFe = Manifesto![Chave de Acesso]
   nProtocolo = Manifesto![Protocolo de Autorização]
   dtEnc = Format$(Now,"yyyy-mm-dd")
   cUFEnc = Mid(CodigoIbge,1,2)
   cMunEnc = CodigoIbge
   dataEvento = ""'Format$(Now, "yyyy-mm-dd HH:mm:ss")
   Licenca = Emitente![Chave Flexdocs]
   Proxy = ""
   Usuario = ""
   Senha = ""
   
   Set objMDFEUtil = CreateObject("MDFe_Util.Util")
   
   EventoMDFe = objMDFEUtil.EncerraMDFe(siglaWS, Ambiente, Certificado, versao, msgDados, msgRetWS, Resultado, msgResultado, ChaveMDFe, nProtocolo, dtEnc, cUFEnc, cMunEnc, dataEvento, nProtocoloEnc, dProtocoloEnc, Proxy, Usuario, Senha, Licenca)
   
   With Manifesto
      .Edit
      If Vazio(!Observação) Then
         !Observação = "Encerrando MDFe..."
      Else
         !Observação = !Observação & vbCrLf & "Encerrando MDFe..."
      End If
      .Update
      .BookMark = .LastModified
   End With
   
   If Resultado = 135 Then    
      With Manifesto
         .Edit
         !Observação = !Observação & vbCrLf & "MDFe Encerrado com Sucesso!!!"
         !Encerrado = True
         .Update
         .BookMark = .LastModified
      End With
    'Salvando o xml...
      Arq = FreeFile
      If Parametros_da_NFe!ambiente = 0 Then 'Produção
         Open Parametros_da_NFe![Diretorio 1 NFe Produção] & NomeEmitente & Format(Manifesto![Numero Do Manifesto], "000000") & "_ENCERRADO.xml" For Append As #Arq
            Print #Arq, EventoMDFe
         Close #Arq
      Else 'Homologação
         Open Parametros_da_NFe![Diretorio 1 NFe Homologação] & NomeEmitente & Format(Manifesto![Numero Do Manifesto], "000000") & "_ENCERRADO.xml" For Append As #Arq
            Print #Arq, EventoMDFe
         Close #Arq
      End If
      MsgBox "Manifesto Encerrado com Sucesso!!!", vbInformation + vbOKOnly, vaTitulo 'Suuuuuceeeeesssssoooo
      GoTo SaiDaSub
   Else
      MsgBox msgResultado, vbCritical + vbOKOnly, "Atenção: Encerramento do MDFe Falhou"
      'Historico
      With Manifesto
         .Edit
         !Observação = !Observação & vbCrLf & "Erro ao Encerrar MDFe: " & msgResultado
         .Update
         .BookMark = .LastModified
      End With
      GoTo SaiDaSub   
   End If 
   
 
 DeuErro:
   If Err.Number <> 0 Then
      vgDb.RollBackTrans
      MsgBox Err.Description, vbCritical + vbOKOnly, vaTitulo
   End If
   
   SaiDaSub:
   Set objMDFeUtil = Nothing
   Screen.MousePointer = vbDefault ' normal
   lblProgresso.Caption = ""
   frmMDFe.Show
   frmMDFe.SetFocus
   PosicionaRegistro frmMDFe, "Sequencia do Manifesto", Nota
   frmMDFe.Reposition
   frmMDFe.DAMDFE
   Unload Me
   
End Sub

'inicializa variaveis (apelidos) coms os campos correspondentes
Private Sub InicializaApelidos(vgComOQue As Integer)
   On Error Resume Next                           'prepara para possíveis erros
   Nota = txtCampo(0).Value
   CodigoIbge = txtCampo(1).Value
   UfTermina = txtCampo(2).Value
   If Err Then Err.Clear                          'se deu algum erro, vamos resetá-lo
End Sub

'poe relacionamento e filtro na lista externa (combobox)
Private Sub PoeRelEFiltroCbo(Index As Integer)
   On Error Resume Next
   Select Case Index
      Case 1
         txtCampo(1).Filter = "([Sequencia do municipio] > " & 0 & ") AND Inativo = " & 0 & ""
                           txtCampo(1).PesqSQLExpression = "SELECT Municipios.[Sequencia do municipio], Municipios.[Descrição do municipio], Municipios.Uf, Municipios.[Codigo do ibge] FROM Municipios WHERE (Municipios.[Sequencia do municipio] > " + CStr(0) + ") AND " + _
                                                              "(Municipios.Inativo = " + CStr(0) + ")"
      Case 2
         txtCampo(2).Filter = "[Codigo do ibge] = " & CodigoIbge & ""
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
   txtCampo(0).Visible = (False)
   If Err Then Err.Clear                          'se houve erro, limpa...
End Sub

'evento - quando o conteúdo do campo for alterado
Private Sub txtCp_Change(Index As Integer)
   If vgPriVez Or txtCampo(Index).PriVez Then Exit Sub
   InicializaApelidos COM_TEXTBOX                         'inicializa apelidos com o que esta sendo digitado
   txtCampo(Index).Change
   If Index = 1 Or Index = 2 Then
      ExecutaVisivel
   End If
End Sub

'evento - quando o campo receber o foco
Private Sub txtCp_GotFocus(Index As Integer)
         On Error Resume Next
         Select Case Index
         Case 1
            PoeRelEFiltroCbo 1
         Case 2
            PoeRelEFiltroCbo 2
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
   Caption = LoadGasString(15360)
   vgFormID = 648
   vgIdentTab = ""
   vgPriVez = True
   vgPodeFazerUnLoad = False
   vgTipo = TP_COMUM
   vgCaracteristica = F_COMUM
   vgTemFiltro = False
   vgSituacao = ACAO_NAVEGANDO
   Set mmCampo(0).Picture = LoadPicture(LoadGasPicture(6865))
   Set botOk.Picture = LoadPicture(LoadGasPicture(6866))
   Set botCancela.Picture = LoadPicture(LoadGasPicture(6867))
   Set lblAjuste = Label(1)
   Set txtNota = txtCampo(0)
   DefineControles
   vgTooltips.Create
   Label(0).Caption = LoadGasString(15365)
   Label(1).Caption = LoadGasString(15366)
   Label(2).Caption = LoadGasString(15367)
   Label(3).Caption = LoadGasString(15368)
   vgTooltips.AddTool botOk, 0, LoadGasString(15369)
   botOk.Caption = LoadGasString(15370)
   vgTooltips.AddTool botCancela, 0, LoadGasString(15371)
   botCancela.Caption = LoadGasString(15372)
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
   txtCampo(0).DataType = 1
   txtCampo(0).Mask = ""
   txtCampo(0).Editable = False
   txtCampo(0).BoundColumn = ""
   txtCampo(0).ListFields = ""
   txtCampo(0).OrderFields = ""
   txtCampo(0).Relation = ""
   txtCampo(0).Source = ""

   Set txtCampo(1).CtPri = txtCp(1)
   Set txtCampo(1).CtFdo = labFdo1
   Set txtCampo(1).CtBot(BOT_LISTA) = bottxtCampo1(BOT_LISTA)
   Set txtCampo(1).CtBot(BOT_COMBO) = bottxtCampo1(BOT_COMBO)
   bottxtCampo1(BOT_LISTA).Caption = "P"
   Set bottxtCampo1(BOT_COMBO).Picture = LoadPicture(LoadGasPicture(3))
   txtCampo(1).DataType = 0
   txtCampo(1).Mask = ""
   txtCampo(1).PesqModoAbertura =  2 
   txtCampo(1).PesqFieldCapture = "Municipios.[Codigo do ibge]"
   txtCampo(1).BoundColumn = "Codigo do ibge"
   txtCampo(1).ListFields = "Descrição do municipio; Codigo do ibge"
   txtCampo(1).OrderFields = "Descrição do municipio"
   txtCampo(1).Relation = ""
   txtCampo(1).Source = "Municipios"
   txtCampo(1).vgfrmGMCale.grdListaG.AutoRebind = True

   Set txtCampo(2).CtPri = txtCp(2)
   Set txtCampo(2).CtFdo = labFdo2
   Set txtCampo(2).CtBot(BOT_COMBO) = bottxtCampo2(BOT_COMBO)
   Set bottxtCampo2(BOT_COMBO).Picture = LoadPicture(LoadGasPicture(3))
   txtCampo(2).DataType = 0
   txtCampo(2).Mask = ""
   txtCampo(2).BoundColumn = "Uf"
   txtCampo(2).ListFields = "Uf"
   txtCampo(2).OrderFields = "Uf"
   txtCampo(2).Relation = ""
   txtCampo(2).Source = "Municipios"
   txtCampo(2).vgfrmGMCale.grdListaG.AutoRebind = True

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
   EncerraMDFe  
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
   Set frmEncMDFe = Nothing                       'libera o segmento de código do form
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
Private Sub bottxtCampo1_Click(Index As Integer)
   txtCampo(1).SetFocus
   DoEvents
   txtCampo(1).botClick Index
End Sub

'evento - quando o botão for apertado
Private Sub bottxtCampo2_Click(Index As Integer)
   txtCampo(2).SetFocus
   DoEvents
   txtCampo(2).botClick Index
End Sub

'evento - quando o mouse for pressionado sobre o campo
Private Sub txtCp_MouseDown(Index As Integer, Button As Integer, Shift As Integer, x as Single, y as Single)
   txtCampo(Index).MouseDown
End Sub

