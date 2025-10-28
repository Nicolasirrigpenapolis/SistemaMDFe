Version 5.00
Begin VB.Form frmAdapta
   BorderStyle = 3        'Fixed Dialog
   Caption         =   "Adaptação de arquivo"
   ClientHeight    =   3645
   ClientLeft      =   5250
   ClientTop       =   2580
   ClientWidth     =   4965
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3645
   ScaleWidth      =   4965
   ShowInTaskbar   =   0   'False
   Begin VB.Frame fraDEF
      Caption         =   "Arquivo SQL"
      Height          =   855
      Left            =   60
      TabIndex        =   5
      Top             =   750
      Width           =   3825
      Begin VB.TextBox txtDir
         Height          =   285
         Left            =   90
         TabIndex        =   7
         Top             =   480
         Width           =   3345
      End
      Begin VB.CommandButton botDir
         Caption         =   "..."
         Height          =   285
         Left            =   3450
         TabIndex        =   6
         TabStop         =   0   'False
         Top             =   480
         Width           =   315
      End
      Begin VB.Label labDEF
         Caption         =   "Diretório do script SQL"
         Height          =   195
         Left            =   90
         TabIndex        =   8
         Top             =   240
         Width           =   2715
      End
   End
   Begin VB.CommandButton botCancela
      Caption         =   "&Cancela  "
      Height          =   315
      Left            =   3960
      MousePointer    =   1  'Arrow
      TabIndex        =   1
      Top             =   660
      Width           =   975
   End
   Begin VB.CommandButton botOk
      Caption         =   "&Ok"
      Enabled         =   0   'False
      Height          =   315
      Left            =   3960
      TabIndex        =   0
      Top             =   330
      Width           =   975
   End
   Begin VB.Label labGauge
      Alignment       =   2  'Center
      BorderStyle     =   1  'Fixed Single
      Height          =   255
      Left            =   4110
      TabIndex        =   3
      Top             =   1080
      Visible         =   0   'False
      Width           =   675
   End
   Begin VB.Label labTitulo
      Alignment       =   2  'Center
      Caption         =   "Aplicação"
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
      Left            =   60
      TabIndex        =   2
      Top             =   60
      Width           =   4875
   End
   Begin VB.CheckBox chkSempreVisivel 
      Caption         =   "Sempre visível"
      Height          =   255
      Left            =   120
      TabIndex        =   8
      Top             =   1680
      Value           =   1  'Checked
      Width           =   1935
   End
End
Attribute VB_Name = "frmAdapta"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'* Sistema...: Emissor de MDF-e (Layout 3.00)
'* Empresa...: Ygor Eduardo Dellalio
'* Módulo....: ADAPTA
'* Função....: Form principal
'* CopyRight.: (C)2023 Ygor Eduardo Dellalio
'* Criação...: GAS-2007 - Gerador Automático de Sistemas
'* Data......: 01/09/2023 10:21:36
'* * * * * * *

Option Explicit                                   'variáveis devem ser declaradas
DefInt A-Z                                        'e por default todas seram inteiras

'para pegar dominio e servidores SQL na rede
Private Declare Function GetVersionEx Lib "kernel32" Alias "GetVersionExA" (lpVersionInformation As OSVERSIONINFO) As Long
Private Declare Function NetWkstaGetInfo Lib "Netapi32.dll" (lpServer As Any, ByVal Level As Long, lpBuffer As Any) As Long
Private Declare Function lstrlenW Lib "kernel32" (ByVal lpString As Long) As Long
Private Declare Function NetServerEnum Lib "netapi32" (strServername As Any, ByVal Level As Long, bufptr As Long, ByVal prefmaxlen As Long, _
                        entriesread As Long, totalentries As Long, ByVal servertype As Long, strDomain As Any, resumehandle As Long) As Long
Private Declare Function NetApiBufferFree Lib "Netapi32.dll" (ByVal lpBuffer As Long) As Long
Private Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (Destination As Any, Source As Any, ByVal Length As Long)
Private Const SV_TYPE_SERVER As Long = &H2
Private Const SV_TYPE_SQLSERVER As Long = &H4

Private Type OSVERSIONINFO
   dwOSVersionInfoSize As Long
   dwMajorVersion As Long
   dwMinorVersion As Long
   dwBuildNumber As Long
   dwPlatformId As Long
   szCSDVersion As String * 128
End Type

Private Type WKSTA_INFO_102
   wki102_platform_id As Long
   wki102_computername As Long
   wki102_langroup As Long
   wki102_ver_major As Long
   wki102_ver_minor As Long
   wki102_lanroot As Long
   wki102_logged_on_users As Long
End Type

Private Type SV_100
   platform As Long
   Name As Long
End Type


'inicializa variáveis
Dim vgAtencao As String
Dim vgNDb As String
Dim vgArqOrig As String

Private Sub Form_Unload(Cancel As Integer)
   Set frmAdapta = Nothing                        'destroi este formulário
End Sub

Private Sub botCancela_Click()
   If vgCancelou <> 100 Then                           'está convertendo. Vamos confirmar...
      Beep                                             'avisa setando a flag de cancelamento, se o usuário cancelar
      FormSempreVisivel Me, False                      'deixa a mensagem ficar em primeiro plano
      vgCancelou = (MsgBox("A adaptação não terminou ainda! Deseja realmente cancelar?", vbQuestion + vbYesNo + vbDefaultButton2, vgAtencao$) = vbYes)
      FormSempreVisivel Me, chkSempreVisivel.Value     'volta o formulário para primeiro plano
   Else
      Unload Me                                        'não quer nada...
      End
   End If
End Sub

Private Sub botDir_Click()                          'pega diretório do BD
   Dim bi As BROWSEINFO, vgRet As Variant, vgDirCapt As String
   bi.hOwner = Me.hWnd
   bi.lpszTitle = labDEF.Caption
   bi.ulFlags = BI_RETORNADIR
   vgRet = SHBrowseForFolder(bi)                    'vamos chamar o diálog
   vgDirCapt$ = Space$(512)                         'prepara o buffer
   If SHGetPathFromIDList(ByVal vgRet, ByVal vgDirCapt$) Then 'pega a pasta capturada e se foi cancelado ou não
      vgDirCapt$ = Left(vgDirCapt$, InStr(vgDirCapt$, Chr$(0)) - 1) 'pega o caminho da pasta capturada
   End If
   txtDir.Text = vgDirCapt$                                         'atualiza texto
   vgNDb$ = vgDirCapt$                                              'arquivo informado
   If Right$(vgNDb$, 1) <> "\" Then vgNDb$ = vgNDb$ + "\"
   vgNDb$ = vgNDb$ + vgAliasDb$(1)
   vgNDb$ = vgNDb$ + "-SQL.SQL"
   If Not Existe(vgNDb$) Then                                       'ele existe?
      Beep                                        'não, avisa
      FormSempreVisivel Me, False                 'deixa a mensagem ser exibida em primeiro plano
      MsgBox "Arquivo não existe no diretório informado!" + vbCrLf + "(" + vgNDb$ + ")", vbExclamation, vgAtencao$
      FormSempreVisivel Me, chkSempreVisivel.Value 'volta o formulário para primeiro plano
   End If             
End Sub

Private Sub botOk_Click()
   botOk.Enabled = False                              'desabilita botão de OK
   AdaptaSQL
End Sub


Private Sub AdaptaSQL()
   Dim x As String, AbriuSQL As Boolean, vgNumArea As Integer, vgLinhaAtual As String, i As Long, k As String, _
       z As String, w As String, vgTabAtual As Integer, vgOk As Boolean, vgRs As New GRecordset, vgNomeTabAtual As String, _
       vgQtCps As Integer, vgPVez As Boolean, vgArea As Integer, vgArqSQL As String, j As Long, _ 
               vgExpInd As String, vgTodosInd As String, l As Integer
   Dim vgTb As GTable, vgCp As GColumn, vgInd As GIndex, vgRel As GRelation
   
   vgPVez = True
   vgNDb$ = txtDir.Text
   If Right$(vgNDb$, 1) <> "\" Then vgNDb$ = vgNDb$ + "\"
   vgArqSQL$ = vgNDb$ + "ADAPTA.SQL"
   vgNDb$ = vgNDb$ + vgAliasDb$(1) + "-SQL.SQL"
   If Not Existe(vgNDb$) Then                           'ele existe?
      Beep                                              'não, avisa
      FormSempreVisivel Me, False                       'deixa a mensagem ser exibida em primeiro plano
      MsgBox "Arquivo não existe no diretório informado!" + vbCrLf + "(" + vgNDb$ + ")", vbExclamation, vgAtencao$
      FormSempreVisivel Me, chkSempreVisivel.Value      'volta o formulário para primeiro plano
      Exit Sub
   End If
   Screen.MousePointer = vbHourglass                    'ponteiro sobre o form é ampulheta
   On Error GoTo DeuErro                                'vamos esperar os erros...
   vgDb.Clear
   vgDb.RegisterDatabase vgAliasDb(1)                   'registra o banco de dados para o aplicativo
   vgDb(1).DataBaseType = vgTipoDb(1)
   vgDb(1).TrustedConnection = vgTrustConnDb(1)
   vgDb(1).Username = vgUsuarioID$(1)
   vgDb(1).Password = vgSenhaDb$(1)
   vgDb(1).Provider = vgProviderDb$(1)
   vgDb(1).Driver = vgDriverDb$(1)
   vgDb(1).Server = vgServerDb$(1)
   vgDb(1).DatabaseName = vgNomeDb$(1)
   vgDb(1).DataBaseDir = vgDirDb$(1)
   vgDb(1).StringConnection = vgStrConnectionDb$(1)
   vgDb(1).OpenConnection
   vgCat.ActiveConnection = vgDb(1).Connection

   AbriuSQL = True
   vgCancelou = False                                   'falg, comecou a adaptação
   vgNumArea = FreeFile                                 'pega uma area livre
   Open vgNDb$ For Input As vgNumArea                   'abre o arquivo .SQL
   vgLinhaAtual$ = ""
   vgTodosInd$ = ""
   For Each vgTb In vgDb(1).Tables
      vgAcao = ACAO_PROSSEGUE
      DoEvents                                          'deixa o windows trabalar
      If vgCancelou Then GoTo FimDaSub                  'se cancelou cai fora..
      vgTabAdap$ = ""                                   'tabela origem atual
      vgNomeTabAtual$ = vgTb.Name
      For i = 0 To vgCat.Tables.Count - 1
         If vgCat.Tables(i).Type = "TABLE" And UCase$(vgNomeTabAtual$) = UCase$(vgCat.Tables(i).Name) Then
            vgTabAdap$ = vgNomeTabAtual$                'uma de mesmo nome
            Exit For
         End If
      Next
      If vgTabAdap$ = "" Then                           'não achou nemhuma tabela...
         Load frmAdapDif                                'carrega form e enche
         frmAdapDif.lstTabelas.Clear                    'lst de tabela a escolher
         For i = 0 To vgCat.Tables.Count - 1
            If vgCat.Tables(i).Type = "TABLE" Then
               frmAdapDif.lstTabelas.AddItem vgCat.Tables(i).Name
            End If
         Next

         'msg do form de escolha de tabelas
         frmAdapDif.labMsg.Caption = "A tabela abaixo não foi encontrada! Se desejar, escolha uma tabela para servir de base para a nova tabela. (" + vgNomeTabAtual$ + ")"
         frmAdapDif.IniciaForm PEGA_TABELA              'diz ao form o que vamos fazer
         Screen.MousePointer = vbDefault
         FormSempreVisivel Me, False
         frmAdapDif.Show vbModal                        'deixa escolher uma tabela
         FormSempreVisivel Me, chkSempreVisivel.Value
         Refresh                                        'remonta o form
         Screen.MousePointer = vbHourglass              'ponteiro sobre o form é ampulheta
         If vgCancelou Then GoTo FimDaSub               'se cancelou cai fora..
      End If
      DoEvents                                          'deixa o windows trabalhar
      vgQtCps = vgTb.Columns.Count
      If vgTabAdap$ = "" Then                           'tem tabela para adaptar
         'tabela nao existe cria uma tabela em branco
         GoSub IniciaSQL                                'inicia criacao do script SQL
         Print #vgArea, "/* "; "cria tabela ("; vgNomeTabAtual$; ")"
         Print #vgArea, "   "; String$(60, "="); "*/"
         Print #vgArea, ""
         Print #vgArea, vgTb.ScriptTable
         Print #vgArea, ""
      Else
         vgOk = True                                    'verifica se exite diferencas entre as tabelas
         If vgCat.Tables(vgTabAdap$).Columns.Count <> vgQtCps Then
            vgOk = False                                'numer de campos nao bate
         Else                                           'se bater vamos ver se
            k$ = vgTb.Columns.Item(1).Name
            x$ = Parse$(k$, "@")
            i = 0
            For Each vgCp In vgTb.Columns               'exite diferencao entre os campos
               
               If vgCancelou Then GoTo FimDaSub         'apertou o botão de cancelar?
               x$ = vgCp.Name
               'nome diferente
               If UCase$(x$) <> UCase$(vgCat.Tables(vgTabAdap$).Columns(i).Name) Then
                  vgOk = False                          'tem difereça
               End If
               
               If Not vgCp.Nullable Then                'nao aceita nulos
                  If vgCat.Tables(vgTabAdap$).Columns(i).Attributes >= adColNullable Then
                     vgOk = False                       'tem difereça
                  End If
               Else                                     'aceita nulos
                  If vgCat.Tables(vgTabAdap$).Columns(i).Attributes < adColNullable Then
                     vgOk = False                       'tem difereça
                  End If
               End If

               'tipo diferente
               If vgCp.ColumnType <> vgCp.GetTypeDb(vgCat.Tables(vgTabAdap$).Columns(i).Type) Then
                  vgOk = False                          'tem difereça
               End If

               'tamanho diferente
               If vgCp.Size <> vgCat.Tables(vgTabAdap$).Columns(i).DefinedSize And _
                  vgCat.Tables(vgTabAdap$).Columns(i).Type = adVarChar Then
                  vgOk = False                          'tem difereça
               End If
               i = i + 1
            Next
         End If

         If Not vgOk Then                               'como ha diferenças entre as tabelas
            ReDim vgCpDestino(0) As String, vgCpOrigem(0) As String, vgCpDoArq(0) As Boolean
            vgNumCps = -1                               'quantidade de cps da tab destino (nova)
            For Each vgCp In vgTb.Columns               'exite diferencao entre os campos
               x$ = vgCp.ColumnType
               w$ = Parse$(x$, "|")
               z$ = Parse$(x$, "|")
                  vgNumCps = vgNumCps + 1               'provável conteudo
                  ReDim Preserve vgCpDestino(vgNumCps) As String, vgCpOrigem(vgNumCps) As String, vgCpDoArq(vgNumCps) As Boolean
                  vgCpDestino$(vgNumCps) = vgCp.Name
                  vgCpOrigem$(vgNumCps) = PegaCpDestino$(vgCpDestino$(vgNumCps))
                  vgCpDoArq(vgNumCps) = False
            Next
            Load frmAdapDif                             'vmos deixa trocar os conteúdos dos campos
            frmAdapDif.labMsg.Caption = "Conversão da Tabela " + UCase$(vgNomeTabAtual$) + ". Relacione os campos da tabela anterior"
            frmAdapDif.IniciaForm PEGA_CAMPOS           'vamos relacionar campos
            Screen.MousePointer = vbDefault
            FormSempreVisivel Me, False
            frmAdapDif.Show vbModal                     'apresenta o form
            FormSempreVisivel Me, chkSempreVisivel.Value
            Refresh                                     'repinta o form
            Screen.MousePointer = vbHourglass           'ponteiro do mouse é ampulheta
            If vgCancelou Then GoTo FimDaSub            'se cancelou cai fora..
            If vgAcao = ACAO_IGNORA Then GoSub ProximaTabela
            GoSub IniciaSQL                             'inicia criacao do script SQL
            
            Print #vgArea, "/* "; "adapta tabela ("; vgNomeTabAtual$; ")"
            Print #vgArea, "   "; String$(60, "="); " */"
            Print #vgArea, ""
            
            Print #vgArea, vgTb.ScriptTable("tmp_" + vgNomeTabAtual$)
            
            'verifica se existe campo seqüencial que não tem campo associado
            i = 0
            For Each vgCp In vgTb.Columns
               If Len(vgCpOrigem(i)) = 0 And vgCp.SeqInterno Then
                  i = 0                                 'indica que o campo seqüencial não está associado a outro campo
                  Exit For
               End If
               i = i + 1
            Next
                        
            'se tem campo seqüencial e este está associado
            If InStr(UCase$(vgTb.ScriptTable), "IDENTITY") > 0 And i > 0 Then
               Print #vgArea, "SET IDENTITY_INSERT "; PoeColchetes$("tmp_" + vgNomeTabAtual$); " ON"
               Print #vgArea, "GO"
               Print #vgArea, ""
            End If
            i = 0
            For Each vgCp In vgTb.Columns
                  If Len(vgCpOrigem(i)) > 0 Then
                     If vgCp.Name = vgCpOrigem(i) Or vgCp.Name = "PW~" & vgCpOrigem(i) Then
                        vgCpDoArq(i) = True
                     End If
                  End If
                  i = i + 1
            Next
            z$ = "": w$ = ""
            i = 0
            For Each vgCp In vgTb.Columns
               x$ = vgDb(1).GetFieldDefDb(vgCp, "|")
               If vgCancelou Then GoTo FimDaSub         'apertou o botão de cancelar?
                  vgOk = False
                  'tipo diferente
                  If Len(vgCpOrigem$(i)) > 0 Then       'tira os campos do timpo timestamp
                     If vgCpDoArq(i) Then               'é campo do arquivo
                        If vgCp.ColumnType <> vgCp.GetTypeDb(vgCat.Tables(vgTabAdap$).Columns(vgCpOrigem$(i)).Type) Then
                           vgOk = True
                        End If
                        'tamanho diferente
                        If vgCp.Size <> vgCat.Tables(vgTabAdap$).Columns(vgCpOrigem$(i)).DefinedSize And _
                           (vgCat.Tables(vgTabAdap$).Columns(vgCpOrigem$(i)).Type = adVarChar Or _
                            vgCat.Tables(vgTabAdap$).Columns(vgCpOrigem$(i)).Type = adNumeric) Then
                           vgOk = True
                        End If
                        If vgCp.QDecimal Then
                           vgOk = True
                        End If
                     End If
                     If Len(z$) > 0 Then z$ = z$ + ", "
                     z$ = z$ + PoeColchetes$(vgCpDestino$(i))
                     If Len(w$) > 0 Then w$ = w$ + ", "
                     If vgCpDoArq(i) = False And vgCp.ColumnType <> TP_BINARIO Then
                        w$ = w$ + "CONVERT(" + Trim(Parse$(x$, "|")) + ", '" + vgCpOrigem$(i) + "')"
                     ElseIf vgOk = True And vgCp.ColumnType <> TP_BINARIO Then
                        w$ = w$ + "CONVERT(" + Trim(Parse$(x$, "|")) + ", " + PoeColchetes$(vgCpOrigem$(i)) + ")"
                     Else
                        w$ = w$ + PoeColchetes$(vgCpOrigem$(i))
                     End If
                  End If
                  i = i + 1
            Next
            If vgAcao <> ACAO_CRIA Then
               Print #vgArea, "IF EXISTS(SELECT * FROM "; PoeColchetes$(vgTabAdap$); ")"
               Print #vgArea, " EXEC('INSERT INTO "; PoeColchetes$("tmp_" + vgNomeTabAtual$); " ("; z$; ")"
               Print #vgArea, "      SELECT "; w$
               Print #vgArea, "      FROM "; PoeColchetes$(vgTabAdap$); " TABLOCKX ')"
               Print #vgArea, "GO"
               Print #vgArea, ""
            End If
            If InStr(UCase$(vgTb.ScriptTable), "IDENTITY") > 0 Then
               Print #vgArea, "SET IDENTITY_INSERT "; PoeColchetes$("tmp_" + vgNomeTabAtual$); " OFF"
               Print #vgArea, "GO"
               Print #vgArea, ""
            End If
            If vgAcao = ACAO_CRIA Then
               Print #vgArea, "IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('" & vgNomeTabAtual & "') AND sysstat & 0xf = 3)"
               Print #vgArea, " DROP TABLE "; PoeColchetes$(vgNomeTabAtual$)
            Else
               Print #vgArea, "DROP TABLE "; PoeColchetes$(vgTabAdap$)
            End If
            Print #vgArea, "GO"
            Print #vgArea, ""
            Print #vgArea, "EXEC sp_rename '"; "tmp_" + vgNomeTabAtual$; "', '"; vgNomeTabAtual$; "'"
            Print #vgArea, "GO"
            Print #vgArea, ""
         Else                                           'verifica se mudou os indices...
            For Each vgInd In vgTb.Indexes
               If vgInd.IndexType = TYPE_Primary Then
                  k$ = "P"
               ElseIf vgInd.IndexType = TYPE_Unique Then
                  k$ = "U"
               Else
                  k$ = "N"
               End If
               vgOk = False
               If vgTb.Indexes.Count = (vgCat.Tables(vgNomeTabAtual$).Indexes.Count) Then
                     vgOk = True
                     On Error Resume Next
                     If vgCat.Tables(vgNomeTabAtual$).Indexes(vgInd.Name).PrimaryKey <> (k$ = "P") Or _
                        vgCat.Tables(vgNomeTabAtual$).Indexes(vgInd.Name).Unique <> (k$ = "P" Or k$ = "U") Then
                        vgOk = False
                     Else
                        w$ = "": x$ = ""
                        For i = 0 To vgCat.Tables(vgNomeTabAtual$).Indexes(vgInd.Name).Columns.Count - 1
                           x$ = x$ + "|" + vgInd.Columns(i + 1).Name
                           w$ = w$ + "|" + vgCat.Tables(vgNomeTabAtual$).Indexes(vgInd.Name).Columns(i).Name
                        Next
                        If UCase$(Mid$(w$, 2)) <> UCase$(Mid(x$, 2)) Then
                           vgOk = False
                        End If
                     End If
                     On Error GoTo DeuErro              'vamos esperar os erros...
                     If vgOk = False Then Exit For
                  End If
               Next
         
            If vgOk = False Then                        'mudou os indices
               GoSub TiraEstruTab                       'separa estrutura da tabela
               GoSub PoeInd                             'coloca indice para ser criado depois
               If vgCat.Tables(vgNomeTabAtual$).Indexes.Count > 0 Then
                  GoSub IniciaSQL
                  Print #vgArea, "/* "; "adapta tabela ("; vgNomeTabAtual$; ")"
                  Print #vgArea, "   "; String$(60, "="); " */"
                  Print #vgArea, ""
                  For i = 0 To vgCat.Tables(vgNomeTabAtual$).Indexes.Count - 1
                     If vgCat.Tables(vgNomeTabAtual$).Indexes(i).PrimaryKey Then
                        Print #vgArea, "ALTER TABLE "; PoeColchetes$(vgNomeTabAtual$)
                        Print #vgArea, Space$(12); "DROP CONSTRAINT "; PoeColchetes$(vgCat.Tables(vgNomeTabAtual$).Indexes(i).Name)
                     Else
                        Print #vgArea, "DROP INDEX "; PoeColchetes$(vgNomeTabAtual$); "."; PoeColchetes$(vgCat.Tables(vgNomeTabAtual$).Indexes(i).Name)
                     End If
                     Print #vgArea, "GO"
                     Print #vgArea, ""
                  Next
               End If
            End If
         End If
      End If
ProximaTabela:
   Next

   'mata as tabela que não existem mais
   j = 0
   For vgTabAtual = 0 To vgCat.Tables.Count - 1
      If vgCat.Tables(vgTabAtual).Type = "TABLE" Then
         vgOk = False
         For Each vgTb In vgDb(1).Tables                '  = 0 To vgQtTab
            If UCase$(vgCat.Tables(vgTabAtual).Name) = UCase$(vgTb.Name) Then
               vgOk = True
               Exit For
            End If
         Next
         If Not vgOk Then
            GoSub IniciaSQL
            If j = 0 Then
               Print #vgArea, "/* "; "exclusão de tabelas"
               Print #vgArea, "   "; String$(60, "="); " */"
               Print #vgArea, ""
               j = 1
            End If
            For i = 0 To vgCat.Tables(vgTabAtual).Keys.Count - 1
               If vgCat.Tables(vgTabAtual).Keys(i).Type <> adKeyForeign Then
                  Print #vgArea, "ALTER TABLE "; PoeColchetes$(vgCat.Tables(vgTabAtual).Name)
                  Print #vgArea, Space$(12); "DROP CONSTRAINT "; PoeColchetes$(vgCat.Tables(vgTabAtual).Keys(i).Name)
                  Print #vgArea, "GO"
                  Print #vgArea, ""
               End If
            Next
            Print #vgArea, "DROP TABLE "; PoeColchetes$(vgCat.Tables(vgTabAtual).Name)
            Print #vgArea, "GO"
            Print #vgArea, ""
         End If
      End If
   Next

   If Len(vgTodosInd$) > 0 Then
      GoSub IniciaSQL
      Print #vgArea, "/* "; "cria indices"
      Print #vgArea, "   "; String$(60, "="); " */"
      Print #vgArea, ""
      Print #vgArea, vgTodosInd$
   End If

   'recoloca todas as trigger's
   If vgPVez = False Then
      If Not EOF(vgNumArea) Then
         Print #vgArea, "/* "; "Criação de triggers/foreign key constraints"
         Print #vgArea, "   "; String$(60, "="); " */"
         Print #vgArea, ""
         x$ = ""
         For Each vgTb In vgDb(1).Tables
            For j = 1 To 3
               vgPVez = True
               For Each vgRel In vgDb(1).Relations
                  If vgRel.BaseTable.Name = vgTb.Name And vgRel.Tipo = j And vgRel.Trigger Then
                     If j = 1 And vgPVez Then
                        x$ = "CREATE TRIGGER " + Substitui(vgRel.BaseTable.Name, " ", "_", UM_A_UM) + "_INS " + "ON " + PoeColchetes(vgRel.BaseTable.Name) + " FOR INSERT AS" + vbCrLf
                     ElseIf j = 2 And vgPVez Then
                        x$ = "CREATE TRIGGER " + Substitui(vgRel.BaseTable.Name, " ", "_", UM_A_UM) + "_UPD " + "ON " + PoeColchetes(vgRel.BaseTable) + " FOR UPDATE AS" + vbCrLf
                     ElseIf j = 3 And vgPVez Then
                        x$ = "CREATE TRIGGER " + Substitui(vgRel.BaseTable.Name, " ", "_", UM_A_UM) + "_DEL " + "ON " + PoeColchetes(vgRel.BaseTable) + " FOR DELETE AS" + vbCrLf
                     End If
                     vgPVez = False
                     'vamos fazer as triggers de INSERT ou UPDATE sem Atualizacao
                     If (vgRel.Tipo = TYPE_INSERT Or (vgRel.Tipo = TYPE_UPDATE And Not vgRel.Update)) And vgRel.Trigger Then
                        x$ = x$ + " BEGIN" + vbCrLf
                        x$ = x$ + "  IF (SELECT COUNT(*) FROM inserted) !=" + vbCrLf
                        For i = 1 To vgRel.RelationColumns.Count
                           If i = 1 Then
                              x$ = x$ + "   (SELECT COUNT(*) FROM " + PoeColchetes(vgRel.ForeignTable) + " INNER JOIN inserted ON " + PoeColchetes(vgRel.ForeignTable) + "." + PoeColchetes(vgRel.RelationColumns(i).ForeignColumn.Name) + " = inserted." + PoeColchetes(vgRel.RelationColumns(i).BaseColumn.Name)
                           Else
                              x$ = x$ + "  AND " + PoeColchetes(vgRel.ForeignTable.Name) + "." + PoeColchetes(vgRel.RelationColumns(i).ForeignColumn.Name) + " = inserted." + PoeColchetes(vgRel.RelationColumns(i).BaseColumn.Name)
                           End If
                        Next
                        x$ = x$ + ")" + vbCrLf
                        x$ = x$ + "   BEGIN" + vbCrLf
                        x$ = x$ + "    RAISERROR('" + vgRel.Msg + "', 16, 1)" + vbCrLf
                        x$ = x$ + "    ROLLBACK TRANSACTION" + vbCrLf
                        x$ = x$ + "    Return" + vbCrLf
                        x$ = x$ + "   END" + vbCrLf
                        x$ = x$ + " END" + vbCrLf
                        
                        'vamos fazer as triggers de UPDATE com Atualizacao
                     ElseIf vgRel.Tipo = TYPE_UPDATE And vgRel.Update And vgRel.Trigger Then
                        For i = 1 To vgRel.RelationColumns.Count
                           If i = 1 Then
                              x$ = x$ + " IF (SELECT INSERTED." + PoeColchetes(vgRel.RelationColumns(i).BaseColumn.Name) + " FROM INSERTED) <> (SELECT DELETED." + PoeColchetes(vgRel.RelationColumns(i).BaseColumn.Name) + " FROM DELETED)" + vbCrLf
                           Else
                              x$ = x$ + " OR (SELECT INSERTED." + PoeColchetes(vgRel.RelationColumns(i).BaseColumn.Name) + " FROM INSERTED) <> (SELECT DELETED." + PoeColchetes(vgRel.RelationColumns(i).BaseColumn.Name) + " FROM DELETED)" + vbCrLf
                           End If
                        Next
                        x$ = x$ + "  BEGIN" + vbCrLf
                        For i = 1 To vgRel.RelationColumns.Count
                           If i = 1 Then
                              x$ = x$ + "   IF (SELECT COUNT(*) FROM deleted INNER JOIN " + PoeColchetes(vgRel.ForeignTable) + " ON deleted." + PoeColchetes(vgRel.RelationColumns(i).BaseColumn.Name) + " = " + PoeColchetes(vgRel.ForeignTable.Name) + "." + PoeColchetes(vgRel.RelationColumns(i).ForeignColumn.Name)
                           Else
                              x$ = x$ + " AND deleted." + PoeColchetes(vgRel.RelationColumns(i).BaseColumn.Name) + " = " + PoeColchetes(vgRel.ForeignTable.Name) + "." + PoeColchetes(vgRel.RelationColumns(i).ForeignColumn.Name)
                           End If
                        Next
                        x$ = x$ + ") "
                        x$ = x$ + " > 0" + vbCrLf
                        x$ = x$ + "    BEGIN" + vbCrLf
                        x$ = x$ + "     SET NOCOUNT ON" + vbCrLf
                        x$ = x$ + "     UPDATE " + PoeColchetes(vgRel.ForeignTable.Name) + vbCrLf
                        For i = 1 To vgRel.RelationColumns.Count
                           For l = 1 To vgRel.RelationColumns.Count
                              If i = 1 And l = 1 Then x$ = x$ + "     SET "
                              If l = 1 Then
                                 x$ = x$ + PoeColchetes(vgRel.ForeignTable.Name) + "." + PoeColchetes(vgRel.RelationColumns(i).ForeignColumn.Name) + " = " + "(SELECT inserted." + PoeColchetes(vgRel.RelationColumns(i).BaseColumn.Name) + " FROM INSERTED INNER JOIN " + PoeColchetes(vgRel.BaseTable.Name) + " ON inserted." + PoeColchetes(vgRel.RelationColumns(i).BaseColumn.Name) + " = " + PoeColchetes(vgRel.BaseTable.Name) + "." + PoeColchetes(vgRel.RelationColumns(i).BaseColumn.Name)
                              Else
                                 x$ = x$ + " AND inserted." + PoeColchetes(vgRel.RelationColumns(i).BaseColumn.Name) + " = " + PoeColchetes(vgRel.BaseTable.Name) + "." + PoeColchetes(vgRel.RelationColumns(i).BaseColumn.Name)
                              End If
                           Next
                           If i < vgRel.RelationColumns.Count Then x$ = x$ + ")," + vbCrLf + Space(9)
                           If i = vgRel.RelationColumns.Count Then x$ = x$ + ")" + vbCrLf
                        Next
                        For i = 1 To vgRel.RelationColumns.Count
                           If i = 1 Then
                              x$ = x$ + "     FROM deleted INNER JOIN " + PoeColchetes(vgRel.ForeignTable.Name) + " ON deleted." + PoeColchetes(vgRel.RelationColumns(i).BaseColumn.Name) + " = " + PoeColchetes(vgRel.ForeignTable.Name) + "." + PoeColchetes(vgRel.RelationColumns(i).ForeignColumn.Name)
                           Else
                              x$ = x$ + " AND deleted." + PoeColchetes(vgRel.RelationColumns(i).BaseColumn) + " = " + PoeColchetes(vgRel.ForeignTable.Name) + "." + PoeColchetes(vgRel.RelationColumns(i).ForeignColumn.Name) + vbCrLf
                           End If
                        Next
                        If vgRel.RelationColumns.Count = 1 Then x$ = x$ + vbCrLf
                        x$ = x$ + "    END" + vbCrLf
                        x$ = x$ + "  END" + vbCrLf
                        
                     'Vamos fazer a trigger de Delete para Integridade Referencial 1-1
                     ElseIf vgRel.Tipo = TYPE_DELETE And vgRel.Trigger And Not vgRel.Delete Then
                        For i = 1 To vgRel.RelationColumns.Count
                           If i = 1 Then
                              x$ = x$ + " IF (SELECT COUNT(*) FROM deleted INNER JOIN " + PoeColchetes(vgRel.ForeignTable) + " ON deleted." + PoeColchetes(vgRel.RelationColumns(i).BaseColumn.Name) + " = " + PoeColchetes(vgRel.ForeignTable.Name) + "." + PoeColchetes(vgRel.RelationColumns(i).ForeignColumn.Name)
                           Else
                              x$ = x$ + " AND deleted." + PoeColchetes(vgRel.RelationColumns(i).BaseColumn.Name) + " = " + PoeColchetes(vgRel.ForeignTable.Name) + "." + PoeColchetes(vgRel.RelationColumns(i).ForeignColumn.Name)
                           End If
                        Next
                        x$ = x$ + ") "
                        x$ = x$ + " > 0" + vbCrLf
                        x$ = x$ + "  BEGIN" + vbCrLf
                        x$ = x$ + "   RAISERROR('" + vgRel.Msg + "', 16, 1)" + vbCrLf
                        x$ = x$ + "   ROLLBACK TRANSACTION" + vbCrLf
                        x$ = x$ + "   Return" + vbCrLf
                        x$ = x$ + "  END" + vbCrLf
                        
                     'Vamos fazer a trigger de Deleção em CASCATA
                     ElseIf vgRel.Tipo = TYPE_DELETE And vgRel.Trigger And vgRel.Delete Then
                        For i = 1 To vgRel.RelationColumns.Count
                           If i = 1 Then
                              x$ = x$ + " IF (SELECT COUNT(*) FROM deleted INNER JOIN " + PoeColchetes(vgRel.ForeignTable) + " ON deleted." + PoeColchetes(vgRel.RelationColumns(i).BaseColumn.Name) + " = " + PoeColchetes(vgRel.ForeignTable.Name) + "." + PoeColchetes(vgRel.RelationColumns(i).ForeignColumn.Name)
                           Else
                              x$ = x$ + " AND deleted." + PoeColchetes(vgRel.RelationColumns(i).BaseColumn.Name) + " = " + PoeColchetes(vgRel.ForeignTable.Name) + "." + PoeColchetes(vgRel.RelationColumns(i).ForeignColumn.Name)
                           End If
                        Next
                        x$ = x$ + ") "
                        x$ = x$ + " > 0" + vbCrLf
                        x$ = x$ + "  BEGIN" + vbCrLf
                        x$ = x$ + "   SET NOCOUNT ON" + vbCrLf
                        For i = 1 To vgRel.RelationColumns.Count
                           If i = 1 Then
                              x$ = x$ + "   DELETE " + PoeColchetes(vgRel.ForeignTable.Name) + " FROM " + PoeColchetes(vgRel.ForeignTable.Name) + " INNER JOIN deleted ON " + PoeColchetes(vgRel.ForeignTable.Name) + "." + PoeColchetes(vgRel.RelationColumns(i).ForeignColumn.Name) + " = deleted." + PoeColchetes(vgRel.RelationColumns(i).BaseColumn.Name)
                           Else
                              x$ = x$ + " AND " + PoeColchetes(vgRel.ForeignTable.Name) + "." + PoeColchetes(vgRel.RelationColumns(i).ForeignColumn.Name) + " = deleted." + PoeColchetes(vgRel.RelationColumns(i).BaseColumn.Name) + vbCrLf
                           End If
                        Next
                        If vgRel.RelationColumns.Count = 1 Then x$ = x$ + vbCrLf
                        x$ = x$ + "  END" + vbCrLf
                     End If
                  End If
               Next
               
               'Vamos fechar a trigger
               If Len(x$) > 0 Then
                  x$ = x$ + "GO" + vbCrLf
                  Print #vgArea, x$
                  x$ = ""
               End If
            Next
            
            'se nao for trigger vamos colocar as constraints
            For Each vgRel In vgDb(1).Relations
               If vgRel.BaseTable.Name = vgTb.Name And Not vgRel.Trigger Then ' And Not vgRel.System Then
                  x$ = "ALTER TABLE [dbo]." + PoeColchetes(vgRel.ForeignTable.Name) + " ADD CONSTRAINT " + PoeColchetes("FK_" + Substitui$(vgRel.ForeignTable, " ", "_", UM_A_UM) + "_" + Substitui$(vgRel.BaseTable, " ", "_", UM_A_UM)) + vbCrLf
                  x$ = x$ + " Foreign Key" + vbCrLf
                  For i = 1 To vgRel.RelationColumns.Count
                     If i = 1 Then
                        x$ = x$ + "  ( " + PoeColchetes(vgRel.RelationColumns(i).ForeignColumn.Name)
                     Else
                        x$ = x$ + "," + PoeColchetes(vgRel.RelationColumns(i).ForeignColumn.Name)
                     End If
                  Next
                  x$ = x$ + " )" + vbCrLf
                  x$ = x$ + " References " + PoeColchetes(vgRel.BaseTable.Name) + vbCrLf
                  For i = 1 To vgRel.RelationColumns.Count
                     If i = 1 Then
                        x$ = x$ + "  ( " + PoeColchetes(vgRel.RelationColumns(i).BaseColumn.Name)
                     Else
                        x$ = x$ + "," + PoeColchetes(vgRel.RelationColumns(i).BaseColumn.Name)
                     End If
                  Next
                  x$ = x$ + " )" + vbCrLf
                  If vgRel.Delete Then x$ = x$ + " ON DELETE CASCADE" + vbCrLf
                  If vgRel.Update Then x$ = x$ + " ON UPDATE CASCADE" + vbCrLf
               End If
               If Len(x$) > 0 Then
                  x$ = x$ + "GO" + vbCrLf
                  Print #vgArea, x$
                  x$ = ""
               End If
            Next
         Next
      End If
      Print #vgArea, "/* "; "fecha a transação */"
      Print #vgArea, "COMMIT"
      Print #vgArea, "SET NOCOUNT OFF"
      Print #vgArea, "GO"
      Print #vgArea, "SET XACT_ABORT OFF"
      Print #vgArea, "GO"
      Print #vgArea, ""

      'mata arquivo de inicializacoes
      x$ = Left$(vgNDb$, Rat(vgNDb$, "\")) + "NFE VIEW.INI"                   'arquivo .INI
      If Existe(x$) Then                          'se .ini existe
         Beep                                     'pergunta de quer matar
         FormSempreVisivel Me, False              'deixa a mensagem ser exibida em primeiro plano
         If MsgBox("Apagar o arquivo de configurações .INI?" + vbCrLf + _
                   "Se SIM as consultas definidas pela opção 'Construção de consultas' se perderão. Se o arquivo não for apagado essas consultas poderão apresentar algum tipo de problema.", _
                   vbQuestion + vbYesNo, vgAtencao$) = vbYes Then
            FormSempreVisivel Me, chkSempreVisivel.Value 'volta o formulário para primeiro plano
            Kill x$                                      'vamos apaga-lo
         End If
      End If
      Beep
      FormSempreVisivel Me, False                        'deixa a mensagem ser exibida em primeiro plano
      MsgBox "O arquivo (script) ADAPTA.SQL foi criado!" + vbCrLf + _
             "faça um BACKUP do seu banco de dados e execute este script no 'SQL Server Query Analyser' para efetivar a adaptação.", vbExclamation, vgAtencao$
      FormSempreVisivel Me, chkSempreVisivel.Value       'volta o formulário para primeiro plano
   Else
      Beep
      FormSempreVisivel Me, False                        'deixa a mensagem ser exibida em primeiro plano
      MsgBox "Não é necessário adaptar o arquivo!", vbExclamation, vgAtencao$
      FormSempreVisivel Me, chkSempreVisivel.Value       'volta o formulário para primeiro plano
   End If
   GoTo FimDaSub

IniciaSQL:
   'se for a primera vez exclui todas as trigger's
   If vgPVez Then
      vgArea = FreeFile
      If Existe(vgArqSQL$) Then Kill vgArqSQL$
      Open vgArqSQL$ For Output As #vgArea

      Print #vgArea, "/* "; "Seleciona o banco de dados */"
      Print #vgArea, ""
      Print #vgArea, "USE " + PoeColAspas(UCase$(vgNomeDb$(1)), (vgTipoDb(1)))
      Print #vgArea, "SET LANGUAGE Brazilian"
      Print #vgArea, "SET DATEFORMAT mdy"

      Print #vgArea, ""
      Print #vgArea, "/* "; "Inicia uma transação */"
      Print #vgArea, ""
      Print #vgArea, "SET XACT_ABORT ON"
      Print #vgArea, "GO"
      Print #vgArea, "BEGIN TRANSACTION"
      Print #vgArea, "GO"
      Print #vgArea, "SET NOCOUNT ON"
      Print #vgArea, "GO"
      Print #vgArea, "SET QUOTED_IDENTIFIER ON"
      Print #vgArea, "GO"
      Print #vgArea, "SET TRANSACTION ISOLATION LEVEL SERIALIZABLE"
      Print #vgArea, "GO"
      Print #vgArea, "COMMIT"
      Print #vgArea, "BEGIN TRANSACTION"

      Print #vgArea, ""
      Set vgRs = vgDb(1).OpenRecordSet("SELECT * FROM sysobjects WHERE sysstat & 0xf = 8 or sysstat & 0xf = 11", , , , , , , , , True)
      If vgRs.RecordCount > 0 Then
         Print #vgArea, "/* "; "Exclusão de triggers/foreign key constraints"
         Print #vgArea, "   "; String$(60, "="); " */"
         Print #vgArea, ""
         vgRs.MoveFirst
         Do While Not vgRs.EOF
            Print #vgArea, "If exists (select * from sysobjects where id = object_id('"; vgRs!Name; "') and sysstat & 0xf = " + CStr(vgRs!sysstat) + ")"
            If vgRs!sysstat = 8 Then
               Print #vgArea, " drop trigger "; vgRs!Name
            Else
               Print #vgArea, " ALTER TABLE [dbo].["; vgDb(1).Execute("SELECT Name FROM sysobjects WHERE id = " + CStr(vgRs!parent_obj))!Name; "]"
               Print #vgArea, "       DROP CONSTRAINT ["; vgRs!Name; "]"
            End If
            Print #vgArea, "GO"
            Print #vgArea, ""
            vgRs.MoveNext
         Loop
      End If
      vgRs.CloseRecordSet
      vgPVez = False
   End If
   Return

PoeInd:
   Do While Left$(vgExpInd$, 2) = vbCrLf
      vgExpInd$ = Trim$(Mid$(vgExpInd$, 3))
   Loop

OutroInd:
   j = InStr(vgExpInd$, "CREATE ")
   If j > 0 Then
      i = InStr(j, vgExpInd$, "GO" + vbCrLf)
      If i > 0 Then
         vgTodosInd$ = vgTodosInd$ + Mid$(vgExpInd$, j, i + 4 - j) + vbCrLf
         vgExpInd$ = Left$(vgExpInd$, j - 1) + Mid$(vgExpInd$, i + 6 - (2 * (Mid$(vgExpInd$, i + 6, 2) = vbCrLf)))
         GoTo OutroInd
      End If
   End If
   Return

TiraEstruTab:
   'sepra estrutura da tabela do indice principal
   vgExpInd$ = vgTb.ScriptTable                          'vgScriptTab$(vgTabAtual)
   x$ = Trim$(Parse$(vgExpInd$, "("))
   x$ = Trim$(Parse$(vgExpInd$, ")"))
   Do While Len(Retira$(x$, "(", SO_UM)) <> Len(Retira$(x$, ")", SO_UM))
      x$ = x$ + ")" + Parse$(vgExpInd$, ")")
   Loop
   Do While Left$(x$, 2) = vbCrLf
      x$ = Trim$(Mid$(x$, 3))
   Loop
   i = InStr(UCase$(vgExpInd$), "CONSTRAINT ")
   If i > 0 Then
      j = InStr(i, UCase$(vgExpInd$), "GO" + vbCrLf)
      vgTodosInd$ = vgTodosInd$ + "ALTER TABLE " + PoeColchetes$(vgNomeTabAtual$) + _
                    " ADD " + Mid$(vgExpInd$, i, j - i + 3) + vbCrLf 
      x$ = Trim$(Left$(x$, i - 1))
      Do While Right$(x$, 2) = vbCrLf
         x$ = Trim$(Left$(x$, Len(x$) - 2))
      Loop
      If Right$(x$, 1) = "," Then
         x$ = Trim$(Left$(x$, Len(x$) - 1))
      End If
   End If
   Return

Resume
DeuErro:                                                 'erro indeterminado
   If Err = -2147467259 Then
      Beep                                               'não, avisa
      FormSempreVisivel Me, False                        'deixa a mensagem ser exibida em primeiro plano
      MsgBox "Arquivo não pode ser aberto!", vbExclamation, vgAtencao$
      FormSempreVisivel Me, chkSempreVisivel.Value       'volta o formulário para primeiro plano
   Else
      Beep                                               'não, avisa
      FormSempreVisivel Me, False                        'deixa a mensagem ser exibida em primeiro plano
      MsgBox "Erro indeterminado!" + vbCrLf + Error$, vbExclamation, vgAtencao$
      FormSempreVisivel Me, chkSempreVisivel.Value       'volta o formulário para primeiro plano
   End If

FimDaSub:
   If AbriuSQL Then
      vgDb(1).CloseConnection
      Set vgCat = Nothing
      Set vgDb = Nothing
   End If
   Set vgRs = Nothing
   Close
   vgCancelou = 100                                      'flag, inicio da daptação
   Screen.MousePointer = vbDefault                       'mouse = seta
   UnLoad frmAdapDif                                     'descarrega relacionamento origem-destino
   labGauge.Visible = False
End Sub 




'transforma uma string em data
Public Function CtoD(vgDt As String) As Variant
   On Error Resume Next                           'prepara para possível erro...
   If Len(Trim$(vgDt$)) = 0 Then                  'se a data for em branco
      CtoD = Null                                 'retorna nulo
   Else
      CtoD = CDate(vgDt$)                         'tenta converter para data
      If Err Then CtoD = Null                     'se deu erro retorna o que veio
   End If
End Function

'verifica se na tabela destino ha um campo de mesmo nome da tabela origem
Private Function PegaCpDestino(vgCp As String) As String
   Dim i As Integer
   PegaCpDestino$ = ""                                  'por enquando nada!
   For i = 0 To vgCat.Tables(vgTabAdap$).Columns.Count - 1
      If UCase$(vgCat.Tables(vgTabAdap$).Columns(i).Name) = UCase$(vgCp$) Then 'tabela origem para
         PegaCpDestino$ = vgCp$                                                'verificar se tem cp igual
         Exit For
      End If
   Next
End Function

'evento disparado ao clicar no checkbox "Sempre visível"
Private Sub chkSempreVisivel_Click()
   FormSempreVisivel Me, chkSempreVisivel.Value            'define se o formulário fica em primeiro ou segundo plano e acordo com o valor do checkbox    
End Sub

Private Sub Form_Activate()
   FormSempreVisivel Me, True                            'coloca o formulário em primeiro plano
End Sub

Private Sub Form_Load()
   Dim i As Long, p As String * 50
   Dim vgOS As OSVERSIONINFO
   Dim vgBuffer As Long
   Dim wki As WKSTA_INFO_102
   labTitulo.Caption = UCase$("Emissor de MDF-e (Layout 3.00)")
   vgAliasDb$(1) = "DADOSNFE"
   vgSenhaLog(1) = "5139249"
   vgTiposPermDb(1) = 8
   vgDirEXE$ = App.Path                           'diretório onde a aplicação está sendo executada
   If Right(vgDirEXE$, 1) <> "\" Then             'se diretório da aplicação não for o
      vgDirEXE$ = vgDirEXE$ + "\"                 'raiz, coloca "\" no fim do path
   End If
   vgNomeINI$ = vgDirEXE$ + "NFE.INI"             'nome do aquivo .INI (configurações)
   AbreHandleRes
   vgNomeApp$ = "NFE"                             'nome original do aplicativo (.EXE)
   vgNomeSistema$ = LoadGasString(1020)           'nome da aplicação
   Caption = LoadGasString(1020)                  'título deste programa e aplicação
   vgAtencao$ = LoadGasString(1040)               'palavra "Atenção!" (usada muitas vezes)
   vgArqEstXML$ = vgDirEXE$ + vgNomeApp$ + ".XML" 'nome do arquivo de estrutura
   i = GetProfileString("Intl", "sDecimal", ",", p$, Len(p$)) 'tenta pegar separador decimais
   If i > 0 Then                                              'se i>0, pegamos
      vgSpDec$ = Left$(p$, i)                                 'vamos salvar...
   Else                                           'senão,
      vgSpDec$ = ","                              'vamos usar vírgula
   End If
   i = GetComputerName(p$, Len(p$))               'tenta pega o nome da estacao
   If i > 0 Then                                  'ok! pega o mome da estação
      vgNomeEstacao$ = Left$(p$, Instr(p$ + Chr$(0), Chr$(0)) - 1)
   Else                                           'o windows não sabe quem é!!!
      vgNomeEstacao$ = ""
   End If
   If LEN(vgNomeEstacao$) = 0 Then                'aida não tem o nome da estação
      vgNomeEstacao$ = Environ("ESTACAO")         'tenta pegar nome da estação pela variável em "SET ESTACAO"
      If Len(vgNomeEstacao$) = 0 Then             'se não conseguiu
         Load frmAdaptbd                          'carrega form para memória e diz ao
         If Not frmAdaptbd.Iniciaform(PEGA_ESTACAO) Then 'form que vamos receber o nome da estação
            End                                          'então não pode entrar no sistema.
         End If
      End If
   End If
   vgNomeEstacao$ = vgNomeEstacao$ + " - "               'prepara variável para grupo no .INI
   If LeInfDb() = False Then                             'informação não encontrada no .INI
      Load frmAdaptbd                                    'mostra form e diz a ele que
      If Not frmAdaptbd.Iniciaform(PEGA_DIR) Then        'queremos pedir o diretório do BD
         End
      End If

      'grava diretório no arquivo .INI para esta estação
      GravaNoIni vgNomeEstacao$ + "Geral", "Nome de " + vgAliasDb(1), vgNomeDb$(1), vgNomeINI$
      GravaNoIni vgNomeEstacao$ + "Geral", "Tipo de " + vgAliasDb(1), CStr(vgTipoDb(1)), vgNomeINI$
      GravaNoIni vgNomeEstacao$ + "Geral", "Diretório de " + vgAliasDb(1), vgDirDb(1), vgNomeINI$
      GravaNoIni vgNomeEstacao$ + "Geral", "Server de " + vgAliasDb(1), vgServerDb(1), vgNomeINI$
      GravaNoIni vgNomeEstacao$ + "Geral", "Trusted Connection de " + vgAliasDb(1), CStr(Abs(vgTrustConnDb(1))), vgNomeINI$
      GravaNoIni vgNomeEstacao$ + "Geral", "Usuário de " + vgAliasDb(1), Encripta$(vgUsuarioID(1)), vgNomeINI$
      GravaNoIni vgNomeEstacao$ + "Geral", "Senha de " + vgAliasDb(1), Encripta$(vgSenhaDb(1)), vgNomeINI$
      GravaNoIni vgNomeEstacao$ + "Geral", "Provider de " + vgAliasDb(1), vgProviderDb(1), vgNomeINI$
      GravaNoIni vgNomeEstacao$ + "Geral", "Driver de " + vgAliasDb(1), vgDriverDb(1), vgNomeINI$
      GravaNoIni vgNomeEstacao$ + "Geral", "String Connection de " + vgAliasDb(1), vgStrConnectionDb(1), vgNomeINI$
   End If

   fraDEF.Caption = LoadGasString(11707)
   labDEF.Caption = LoadGasString(11708)
   Me.Height = 2450
   For i = 0 To EXP_TODAS - 1                            'vetor com os nomes das cláusulas SQL
      vgClausula$(i) = " " + Choose(i + 1, "SELECT", "SET", "FROM", "LEFT JOIN", "RIGHT JOIN", "INNER JOIN", "ON", "WHERE", "GROUP BY", "HAVING", "ORDER BY", "LIMIT") + " "
   Next
   If Len(vgDirDb$(1)) > 0 Then                          'se tem diretório para o banco
      txtDir.Text = vgDirDb$(1)                          'diretório default
   Else
      txtDir.Text = vgDirEXE$
   End If
   Top = (Screen.Height - Height) / 2                    'centraliza esta janela vertical e
   Left = (Screen.Width - Width) / 2                     'horizontalmente
   vgCancelou = 100                                      'flag, ainda não começou a adaptação
End Sub


Private Sub txtDir_Change()
   'se os dois campos preenchidos, habilita botão OK
   botOk.Enabled = (Len(txtDir.Text) > 0)
End Sub









