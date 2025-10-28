VERSION 5.00
Begin VB.Form frmCCe
   ForeColor                =   &H80000008
   BorderStyle              =   2
   Height                   =   5010
   Left                     =   2505
   LinkTopic                =   "CCe"
   LockControls             =   -1
   KeyPreview               =   -1
   MDIChild                 =   -1
   ScaleHeight              =   4590
   ScaleWidth               =   9450
   Top                      =   1540
   Width                    =   9540
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
      Height                   =   4410
      Left                     =   15
      Width                    =   9270
      Top                      =   15
      TabStop                  =  0
      _extentx                 =   16343
      _extenty                 =   7774
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
         Height                   =   1305
         Left                     =   75
         Width                    =   1350
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
         Left                     =   1590
         Width                    =   3615
         Top                      =   555
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
         Caption                  =   "Carta de Correção"
         Index                    =   0 
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   -1
         Height                   =   240
         Left                     =   2820
         Width                    =   4845
         Top                      =   1575
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
         ForeColor                =   &H80
         Caption                  =   "Lembrete: Última Correção Substitui a Anterior."
         Index                    =   1 
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   -1
         Height                   =   195
         Left                     =   8940
         Width                    =   45
         Top                      =   4560
         Alignment                =   0
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
         Caption                  =   "-"
         Index                    =   2 
      End
      Begin NFE.GBotao botOk
         ButtonStyle              =   0
         JoinSeparators           =   0
         LeftSeparator            =   0
         TopSeparator             =   0
         TabIndex                 =   0
         TabStop                  =   -1
         ButtonType               =   0
         Height                   =   360
         Left                     =   6075
         Width                    =   1470
         Top                      =   3900
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
         Caption                  =   "Prosseguir"
      End
      Begin NFE.GBotao botCancela
         ButtonStyle              =   0
         JoinSeparators           =   0
         LeftSeparator            =   0
         TopSeparator             =   0
         TabIndex                 =   1
         TabStop                  =   -1
         ButtonType               =   0
         Height                   =   360
         Left                     =   7560
         Width                    =   1470
         Top                      =   3900
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
         Caption                  =   "Cancelar"
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
         TabIndex                 =   2
         TabStop                  =   -1
         Height                   =   1725
         Left                     =   1230
         Width                    =   7800
         Top                      =   2010
         Index                    =   0 
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
         Top                      =   2010
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
         Index                    =   3 
      End
      Begin VB.Label labFdo1
         Appearance               =  0
         BorderStyle              =  1
         BackColor                =  &H80000005
         Left                     =   1230
         Top                      =   1545
         Width                    =   1425
         Height                   =   300
      End
      Begin VB.CommandButton bottxtCampo1
         Style                    =   1
         TabStop                  =   0
         Index                    =   1
         Left                     =   2385
         Top                      =   1560
         Width                    =   255
         Height                   =   270
      End
      Begin VB.CommandButton bottxtCampo1
         Style                    =   1
         TabStop                  =   0
         Index                    =   2
         Left                     =   2130
         Top                      =   1560
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
         Alignment                =   1
         TabIndex                 =   3
         TabStop                  =   -1
         Height                   =   270
         Left                     =   1245
         Width                    =   870
         Top                      =   1560
         Index                    =   1 
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   -1
         Height                   =   240
         Left                     =   720
         Width                    =   435
         Top                      =   1575
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
         Caption                  =   "NFe:"
         Index                    =   4 
      End
   End
         Begin VB.Timer timUnLoad
                  Enabled         =   0
                  Interval        =   5
                  left            =   30
                  top             =   950
         End
End
Attribute VB_name = "frmCCe"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
'* Sistema...: Emissor de Nota Fiscal Eletronica
'* Empresa...: Ygor Eduardo Dellalio
'* Módulo....: CCe
'* Função....: Carta de Correção
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
Dim Ajuste As String, CorrecaoTela As String, SeqNotaTela As Double
Public lblAjuste As Object, txtSeqNotaTela As Object

'Carta de Correção Eletronica
Private Sub CCe(SeqNota As Long)
   Dim msgDados As String, msgRetWS As String, msgResultado As String, siglaUF As String, siglaWS As String, certificado As String
   Dim proxy As String, usuario As String, senha As String, licenca As String, ambiente As Integer, versao As String, cStat As Long
   Dim chaveNFe As String, Correcao As String, dhCorrecao As String, nCCe As Long, descEventoAcentuado As Long, objNFeUtil As Object
   Dim procCCe As String, nProtocoloCCe As String, dProtocoloCCe As String, Nota As New GRecordSet, Arq As Long, SeqdaCCe As Long
   Dim TbCCe As New GRecordSet

   On Error GoTo DeuErro
   
   Screen.MousePointer = vbHourglass    ' ampulheta
   Set objNFeUtil = CreateObject("NFe_util_2G.util")
   Set Nota = vgDb.OpenRecordSet("SELECT [Chave de acesso da nfe], [Numero da nfe], [Sequencia da nota fiscal], Observação FROM [Nota fiscal] WHERE [Sequencia da nota fiscal] = " & SeqNota)
   If Nota.RecordCount = 0 Then Exit Sub
   lblProgresso.Caption = "Enviando CCe..."
   
   vgDb.BeginTrans 'Inicia a Transação
     
   certificado = Parametros_da_nfe![Certificado digital] 
   licenca = Empresa![Chave flexdocs]
   siglaWS = "SP3"
   chaveNFe = Nota![Chave de acesso da nfe]
   Correcao = Substitui(SuperTiraAcentos(Substitui(CorrecaoTela, vbCrLf, ";", 1)), "&", "E", UM_A_UM)
   versao = "1.00" ' versão do leiaute da carta de correção
   dhCorrecao = Str(DateTime.Now)      ' data e hora da correção
   nCCe = SuperPegaSequencial("Carta de correção nfe", "Numero da correção", "[Sequencia da nota fiscal] = " & Nota![Sequencia da nota fiscal]) ' número da carta de correção, deve ser um número sequencial iniciado em 1, o valor máximo é 20
   Set TbCCe = VgDb.OpenRecordSet("SELECT MAX([Sequencia da correção]) Seq From [Carta de correção nfe]")
   SeqdaCCe = TbCCe!Seq + 1
   descEventoAcentuado = 0             ' indicador de acentuação da descrição do evento e das condições de uso, deve ser informado com 0-não/1-sim
  
   If chaveNFe = "" Then
      MsgBox "Necessário informar a chave de acesso da NFe objeto de carta de Correção", vbCritical + vbOKOnly, vaTitulo
      Screen.MousePointer = vbDefault 'Ampulheta
      Exit Sub
   End If
    
   If Len(Correcao) < 15 Or Len(Correcao) > 1000 Then '
      MsgBox "Necessário informar o texto da correção com no mín. 15 caracteres e Max. 1000 caracteres.", vbCritical + vbOKOnly, vaTitulo
      Screen.MousePointer = vbDefault 'Ampulheta
      Exit Sub
   End If
       
   If Parametros_da_nfe!Ambiente = 0 Then 'Produção
      ambiente = 1
   Else 'Homologação
      ambiente = 2
   End If

   'Bora lah...
   procCCe = objNFeUtil.EnviaCCe2G(siglaWS, ambiente, certificado, versao, msgDados, msgRetWS, cStat, msgResultado, chaveNFe, Correcao, descEventoAcentuado, nCCe, dhCorrecao, nProtocoloCCe, dProtocoloCCe, proxy, usuario, senha, licenca)
   
   'Historico
   With Nota
      .Edit
      If Vazio(!Observação) Then
         !Observação = "Gerando XML de Correção (CCe)..."
      Else
         !Observação = !Observação & vbCrLf & "Gerando XML de Correção (CCe)..."
      End If
      .Update
      .BookMark = .LastModified
   End With

   If cStat = 135 Then 'Sucesso
           
      'Salvando o xml...
      Arq = FreeFile
      If Parametros_da_nfe!Ambiente = 0 Then 'Produção
         Open Parametros_da_nfe![Diretorio 1 nfe produção] & Format(Nota![Numero da nfe], "000000") & "-" & Format(nCCe, "00") & "_CORRECAO.xml" For Append As #Arq
            Print #Arq, procCCe
         Close #Arq
      Else 'Homologação
         Open Parametros_da_nfe![Diretorio 1 nfe homologação] & Format(Nota![Numero da nfe], "000000") & "-" & Format(nCCe, "00") & "_CORRECAO.xml" For Append As #Arq
            Print #Arq, procCCe
         Close #Arq
      End If
            
      'Historico
      With Nota
         .Edit
         If Vazio(!Observação) Then
            !Observação = "Carta de Correção Autorizada com Sucesso!"
         Else
            !Observação = !Observação & vbCrLf & "Carta de Correção Autorizada com Sucesso!"
         End If
         .Update
         .BookMark = .LastModified
      End With
   Else
      MsgBox msgResultado & Chr(13) & Chr(13), vbCritical + vbOKOnly, vaTitulo
      
      'Historico
      With Nota
         .Edit
         If Vazio(!Observação) Then
            !Observação = "Erro ao Enviar Carta de Correção: " & msgResultado
         Else
            !Observação = !Observação & vbCrLf & "Erro ao Enviar Carta de Correção: " & msgResultado
         End If
         .Update
         .BookMark = .LastModified
      End With
      GoTo SaiDaSub
   End If
   
   'Lança na Tabela
   vgDb.Execute "Insert Into [Carta de correção nfe] Values(" & SeqdaCCe & ", " & SeqNota & ", " & nCCe & ", '" & CorrecaoTela & "', " & D(Date) & ")"
   vgDb.CommitTrans 'Comitando
            
   MsgBox "Carta de Correção Autorizada com Sucesso!!!", vbInformation + vbOKOnly, vaTitulo
    
   AbreDACCe 'Abrindo o UniDanfe
   
DeuErro:
   If Err.Number <> 0 Then
      vgDb.RollBackTrans 'Voltando
      MsgBox Err.Description, vbCritical + vbOKOnly, vaTitulo
   End If
   
SaiDaSub:
   Screen.MousePointer = vbDefault 'Ampulheta
   Set objNFeUtil = Nothing
   lblProgresso.Caption = ""
   Unload Me
   
End Sub


Private Sub AbreDACCe() 
  Dim CCe As New GRecordSet, evento As Byte, Arquivo As String, Principal As Byte
  On Error Resume Next
   
   NFe_Consulta = frmNotaFisc.vgTb![Numero da NFe] 'Caso abrir a partir da Nota Fiscal entao vamos pegar o numero de lah
         
   If NFe_Consulta > 0 Then
      Set CCe = vgDb.OpenRecordSet("SELECT NF.[Sequencia da Nota Fiscal], CCe.[Numero da Correção], NF.[Numero da NFe] " & _
                                   "FROM [Carta de Correção NFe] CCe INNER JOIN [Nota Fiscal] NF ON CCe.[Sequencia da Nota Fiscal] = NF.[Sequencia da Nota Fiscal] " & _
                                   "WHERE NF.[Numero da NFe] = " & NFe_Consulta & " ORDER BY [Numero da Correção]")
      
      If CCe.RecordCount > 1 Then 'Opa possui mais de um evento bora lah
                          
         CCe.MoveLast 'Pegando o Ultimo Evento
         Principal = CCe![Numero da Correção]
         
         If Parametros_da_NFe!ambiente = 0 Then 'Produção
            Arquivo = "C:\unimake\uninfe\UniDANFe.exe arquivo=" & Parametros_da_NFe![Diretorio 1 NFe Produção] & Format(CCe![Numero da NFe], "000000") & "-" & Format(Principal, "00") & "_CORRECAO.xml r=" & Empresa!Email & " NFe=" & Parametros_da_NFe![Diretorio 1 NFe Produção] & Format(NFe_Consulta, "000000") & "_AUTORIZADO.xml"
         Else 'Homologação
            Arquivo = "C:\unimake\uninfe\UniDANFe.exe arquivo=" & Parametros_da_NFe![Diretorio 1 NFe Homologação] & Format(CCe![Numero da NFe], "000000") & "-" & Format(Principal, "00") & "_CORRECAO.xml r=" & Empresa!Email & " NFe=" & Parametros_da_NFe![Diretorio 1 NFe Homologação] & Format(NFe_Consulta, "000000") & "_AUTORIZADO.xml"
         End If
           
         CCe.MoveFirst: evento = 2
                     
         'Vamos Capturar todos os Eventos
         Do While Not CCe.EOF
            If CCe![Numero da Correção] = Principal Then Exit Do 'Se Caiu no Principal é pq é Ultimo Evento e não devemos adicionar ele aqui, já adicionamos em cima
            If Parametros_da_NFe!ambiente = 0 Then 'Produção
               Arquivo = Arquivo & " a" & evento & "=" & Parametros_da_NFe![Diretorio 1 NFe Produção] & Format(CCe![Numero da NFe], "000000") & "-" & Format(CCe![Numero da Correção], "00") & "_CORRECAO.xml"
            Else 'Homologação
               Arquivo = Arquivo & " a" & evento & "=" & Parametros_da_NFe![Diretorio 1 NFe Homologação] & Format(CCe![Numero da NFe], "000000") & "-" & Format(CCe![Numero da Correção], "00") & "_CORRECAO.xml"
            End If
            evento = evento + 1
            CCe.MoveNext
         Loop
         
         Shell (Arquivo) 'Abrindo "DACCE"
         
      ElseIf CCe.RecordCount = 1 Then 'Se tem apenas um Evento aí fica mais facil
         If Parametros_da_NFe!ambiente = 0 Then 'Produção
            If Dir(Parametros_da_NFe![Diretorio 1 NFe Produção] & Format(NFe_Consulta, "000000") & "_AUTORIZADO.xml", vbArchive) <> "" Then
               Shell ("C:\unimake\uninfe\UniDANFe.exe arquivo=" & Parametros_da_NFe![Diretorio 1 NFe Produção] & Format(NFe_Consulta, "000000") & "-" & Format(CCe![Numero da Correção], "00") & "_CORRECAO.xml ee=0" & " NFe=" & Parametros_da_NFe![Diretorio 1 NFe Produção] & Format(NFe_Consulta, "000000") & "_AUTORIZADO.xml")
            End If
         Else 'Homologação
            If Dir(Parametros_da_NFe![Diretorio 1 NFe Homologação] & Format(NFe_Consulta, "000000") & "_AUTORIZADO.xml", vbArchive) <> "" Then
               Shell ("C:\unimake\uninfe\UniDANFe.exe arquivo=" & Parametros_da_NFe![Diretorio 1 NFe Homologação] & Format(NFe_Consulta, "000000") & "-" & Format(CCe![Numero da Correção], "00") & "_CORRECAO.xml ee=0" & " NFe=" & Parametros_da_NFe![Diretorio 1 NFe Homologação] & Format(NFe_Consulta, "000000") & "_AUTORIZADO.xml")
            End If
         End If
      Else 'Nw tem Evento Vamos Notificar
         MsgBox "Essa NFe NÃO Possui Correções.", vbExclamation + vbOKOnly, vaTitulo
      End If
   Else 'Nw Enviou
      MsgBox "Essa Nota Fiscal NÃO foi Autorizada.", vbExclamation + vbOKOnly, vaTitulo
   End If
   
   
End Sub

'inicializa variaveis (apelidos) coms os campos correspondentes
Private Sub InicializaApelidos(vgComOQue As Integer)
   On Error Resume Next                           'prepara para possíveis erros
   CorrecaoTela = txtCampo(0).Value
   SeqNotaTela = txtCampo(1).Value
   If Err Then Err.Clear                          'se deu algum erro, vamos resetá-lo
End Sub

'poe relacionamento e filtro na lista externa (combobox)
Private Sub PoeRelEFiltroCbo(Index As Integer)
   On Error Resume Next
   Select Case Index
      Case 1
         txtCampo(1).Filter = "([Numero da nfe] > " & 0 & ") AND [Sequencia da nota fiscal] > " & 0 & ""
                           txtCampo(1).PesqSQLExpression = "SELECT [Nota fiscal].[Sequencia da nota fiscal], [Nota fiscal].[Numero da nfe], [Nota fiscal].[Data de emissão] FROM [Nota fiscal] WHERE ([Nota fiscal].[Sequencia da nota fiscal] > " + CStr(0) + ") AND " + _
                                                              "([Nota fiscal].[Numero da nfe] > " + CStr(0) + ")"
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
   ElseIf vgOq = INI_APELIDOS Then
      InicializaApelidos COM_REGISTRO
      ExecutaVisivel
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
   txtCampo(1).Enabled = (Ok And txtCampo(1).Editable)
   If Err Then Err.Clear                          'se houve erro, limpa...
End Sub

'coloca os campos visíveis segundo a condição
Private Sub ExecutaVisivel()
   On Error Resume Next                           'prepara para possiveis erros
   Label(2).Visible = (False)
   If Err Then Err.Clear                          'se houve erro, limpa...
End Sub

'evento - quando o conteúdo do campo for alterado
Private Sub txtCp_Change(Index As Integer)
   If vgPriVez Or txtCampo(Index).PriVez Then Exit Sub
   InicializaApelidos COM_TEXTBOX                         'inicializa apelidos com o que esta sendo digitado
   txtCampo(Index).Change
   If Index = 1 Then
      ExecutaVisivel
      ExecutaPreValidacao
   End If
End Sub

'evento - quando o campo receber o foco
Private Sub txtCp_GotFocus(Index As Integer)
         On Error Resume Next
         Select Case Index
         Case 1
            PoeRelEFiltroCbo 1
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
   ExecutaPreValidacao                            'habilita/desabilita campos
End Sub


'evento - inicialização do formulário
Private Sub Form_Load()
   On Error GoTo DeuErro
   Screen.MousePointer = vbHourglass
   Caption = LoadGasString(16860)
   vgFormID = 630
   vgIdentTab = ""
   vgPriVez = True
   vgPodeFazerUnLoad = False
   vgTipo = TP_COMUM
   vgCaracteristica = F_COMUM
   vgTemFiltro = False
   vgSituacao = ACAO_NAVEGANDO
   Set picBox(0).Picture = LoadPicture(LoadGasPicture(8365))
   Set botOk.Picture = LoadPicture(LoadGasPicture(8366))
   Set botCancela.Picture = LoadPicture(LoadGasPicture(8367))
   Set lblAjuste = Label(2)
   Set txtSeqNotaTela = txtCampo(1)
   DefineControles
   vgTooltips.Create
   Label(0).Caption = LoadGasString(16865)
   Label(1).Caption = LoadGasString(16866)
   Label(2).Caption = LoadGasString(16867)
   vgTooltips.AddTool botOk, 0, LoadGasString(16868)
   botOk.Caption = LoadGasString(16869)
   vgTooltips.AddTool botCancela, 0, LoadGasString(16870)
   botCancela.Caption = LoadGasString(16871)
   Label(3).Caption = LoadGasString(16872)
   vgTooltips.AddTool txtCampo(1).CtPri, 0, LoadGasString(16873)
   Label(4).Caption = LoadGasString(16874)
   AjustaTamanho Me
   Executar INICIALIZACOES
   InicializaApelidos COM_TEXTBOX
   ExecutaVisivel
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
   txtCampo(0).DataType = 4
   txtCampo(0).Mask = ""
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
   txtCampo(1).DataType = 1
   txtCampo(1).Mask = ""
   txtCampo(1).PesqModoAbertura =  2 
   txtCampo(1).PesqFieldCapture = "[Nota fiscal].[Sequencia da nota fiscal]"
   txtCampo(1).BoundColumn = "Sequencia da nota fiscal"
   txtCampo(1).ListFields = "Numero da nfe"
   txtCampo(1).OrderFields = "Numero da nfe"
   txtCampo(1).Relation = ""
   txtCampo(1).Source = "Nota fiscal"
   txtCampo(1).vgfrmGMCale.grdListaG.AutoRebind = True

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
   CCe CLng(SeqNotaTela)
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
   Set txtSeqNotaTela = Nothing
   For i = 0 To UBound(txtCampo)
      txtCampo(i).Finalize
      Set txtCampo(i) = Nothing
   Next
   Set vgFG = Nothing
   Set vgTooltips = Nothing
   Set frmCCe = Nothing                           'libera o segmento de código do form
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

'evento - quando o mouse for pressionado sobre o campo
Private Sub txtCp_MouseDown(Index As Integer, Button As Integer, Shift As Integer, x as Single, y as Single)
   txtCampo(Index).MouseDown
End Sub

