VERSION 5.00
Begin VB.Form frmSeleQueries
   Caption         =   "CONSULTAS - Apresentação e criação"
   ClientHeight    =   3300
   ClientLeft      =   2790
   ClientTop       =   2685
   ClientWidth     =   5715
   KeyPreview      =   -1  'True
   LinkTopic       =   "frmSeleQueries"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   ScaleHeight     =   3300
   ScaleWidth      =   5715
   Begin NFE.GPainel Painel
      Height          =   3075
      Index           =   0
      Left            =   120
      Top             =   60
      Width           =   5475
      _ExtentX        =   423
      _ExtentY        =   423
      borderwidth     =   0
      bevelinner      =   2
      Begin VB.Label labTitMenu
         AutoSize        =   -1  'True
         Caption         =   "Consultas existentes"
         BeginProperty Font
            name            =   "MS Sans Serif"
            charset         =   1
            weight          =   700
            size            =   8.25
            underline       =   0   'False
            italic          =   0   'False
            strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   240
         TabIndex        =   0
         Top             =   660
         Width           =   1755
      End
      Begin VB.ListBox lstConsultas
         Height          =   2010
         Left            =   240
         Sorted          =   -1  'True
         TabIndex        =   1
         Top             =   900
         Width           =   5055
      End
      Begin NFE.GBotao botOk
         Height          =   450
         Left            =   3510
         TabIndex        =   2
         Top             =   180
         Width           =   450
         ForeColor       =   -2147483640
      End
      Begin NFE.GBotao botConstroi
         Height          =   450
         Left            =   3960
         TabIndex        =   3
         Top             =   180
         Width           =   450
         ForeColor       =   -2147483640
      End
      Begin NFE.GBotao botRetorna
         Height          =   450
         Left            =   4860
         TabIndex        =   4
         Top             =   180
         Width           =   450
         ForeColor       =   -2147483640
      End
      Begin NFE.GBotao botDel
         Height          =   450
         Left            =   4410
         TabIndex        =   5
         Top             =   180
         Width           =   450
         ForeColor       =   -2147483640
      End
   End
End
Attribute VB_Name = "frmSeleQueries"
Attribute VB_Creatable = False
Attribute VB_Exposed = False

'* Sistema...: Emissor de MDF-e (Layout 3.00)
'* Empresa...: Ygor Eduardo Dellalio
'* Módulo....: frmSeleQueries
'* Função....: Menu de consultas gravadas
'* CopyRight.: (C)2024 Ygor Eduardo Dellalio
'* Criação...: GAS-2007 - Gerador Automático de Sistemas
'* Data......: 05/09/2024 18:10:18
'* * * * * * *

Option Explicit                                   'requer declaração explícita
DefInt A-Z                                        'todas inteiras, por default

Public vgCaracteristica As Integer, vgTipo As Integer, vgPriVez As Integer, _
                     vgSituacao As Integer, vgFormID As Long    'propriedades dos forms
Public vgEmBrowse As Integer
Public vgTemFiltro As Integer                     'dimensiona públicas
Public vgTooltips As New cTooltips

Private Sub botRetorna_Click()
   Unload Me                                      'descarrega o form
End Sub

Private Sub AcertaMeusBotoes()
   botOk.Enabled = (lstConsultas.ListCount > 0)
   botDel.Enabled = botOk.Enabled
End Sub

Private Sub botConstroi_Click()
   Dim i As Integer
   vgNovaQuery = lstConsultas.Text                'carrega o nome da query selecionada
   frmMontaSQL.Show vbModal                       'carrega e mostra
   EncheLista lstConsultas                        'enche a lista com as consultas
   If Len(vgNovaQuery$) > 0 Then                  'se tem uma query,
      For i = 0 To lstConsultas.ListCount - 1     'vamos procurá-la na lista
         If vgNovaQuery$ = lstConsultas.List(i) Then 'e deixá-la
            lstConsultas.ListIndex = i               'selecionada
            Exit For                                 'sai do for...
         End If
      Next                                           'prox consulta
   ElseIf lstConsultas.ListCount > 0 Then            'se não tiver,
      lstConsultas.ListIndex = 0                     'seleciona a primeira delas
   End If
   AcertaMeusBotoes                                  'acerta os botões
End Sub

Private Sub botDel_Click()
   Dim i As Integer, j As Integer, x As String, z As String, vgSecaoIni As String
   Beep                                           'fomm, fomm!
   i = MsgBox(LoadGasString(7060), vbYesNo + _
       vbQuestion, vgAtencao$)                    've se que apagar a consulta
   If i = vbYes Then                              'e quer!
      On Error Resume Next                        'prepara para pegar erros
      GeraLogAcao LoadGasString(7070) + " " + lstConsultas.Text
      vgSecaoIni = vgNomeEstacao$ + "frmBrowse - CONSULTA - " + lstConsultas.Text
      GravaNoIni vgSecaoIni$, vbNullString, "", vgConsultaINI$ 'apaga todos os itens da seao
      vgSecaoIni$ = "CONSULTAS"                                'nome da seao do INI onde estao gravadas as consultas

      'pega número da consulta gravada no INI
      i = 0
      Do
         i = i + 1
         x$ = PegaStrDoIni(vgSecaoIni$, "Nome da consulta " & i, vgConsultaINI$) 'pega nome da consulta do INI
      Loop Until x$ = lstConsultas.Text OR x$ = ""

      'apaga as instruções SQL referentes àquela consulta
      j = 0
      Do
         j = j + 1
         x$ = PegaStrDoIni(vgSecaoIni$, "SQL " & i & "." & j, vgConsultaINI$)    'pega SQL da consulta do INI
         If x$ <> "" Then
            GravaNoIni vgSecaoIni$, "SQL " & i & "." & j, vbNullString, vgConsultaINI$ 'apaga esta SQL do INI
         End If
      Loop Until x$ = ""

      'apaga as instruções WHERE referentes àquela consulta
      j = 0
      Do
         j = j + 1
         x$ = PegaStrDoIni(vgSecaoIni$, "SQL Filtro Inicial " & i & "." & j, vgConsultaINI$) 'pega WHERE da consulta do INI
         If x$ <> "" Then
            GravaNoIni vgSecaoIni$, "SQL Filtro Inicial " & i & "." & j, vbNullString, vgConsultaINI$ 'apaga esta WHERE do INI
         End If
      Loop Until x$ = ""

      'apaga as instruções ORDER BY referentes àquela consulta
      j = 0
      Do
         j = j + 1
         x$ = PegaStrDoIni(vgSecaoIni$, "SQL Ordem Inicial " & i & "." & j, vgConsultaINI$)           'pega WHERE da consulta do INI
         If x$ <> "" Then
            GravaNoIni vgSecaoIni$, "SQL Ordem Inicial " & i & "." & j, vbNullString, vgConsultaINI$  'apaga esta WHERE do INI
         End If
      Loop Until x$ = ""

      'ordena números das consultas no INI
      Do
         i = i + 1                                'começa a procura a partir da próxima consulta e vai incrementando
         x$ = PegaStrDoIni(vgSecaoIni$, "Nome da consulta " & i, vgConsultaINI$) 'pega nome da consulta do INI
         If x$ <> "" Then                         'se achou a consulta
            GravaNoIni vgSecaoIni$, "Nome da consulta " & i - 1, x$, vgConsultaINI$
            GravaNoIni vgSecaoIni$, "Usuário " & i - 1, PegaStrDoIni(vgSecaoIni$, "Usuário " & i, vgConsultaINI$), vgConsultaINI$
            GravaNoIni vgSecaoIni$, "Banco de dados " & i - 1, PegaStrDoIni(vgSecaoIni$, "Banco de dados " & i, vgConsultaINI$), vgConsultaINI$

            'pega cláusulas SQL desta consulta e transfere para um número de consulta anterior
            j = 0
            Do
               j = j + 1
               z$ = PegaStrDoIni(vgSecaoIni$, "SQL " & i & "." & j, vgConsultaINI$) 'pega SQL da consulta do INI
               If z$ <> "" Then
                  GravaNoIni vgSecaoIni$, "SQL " & i - 1 & "." & j, z$, vgConsultaINI$
                  GravaNoIni vgSecaoIni$, "SQL " & i & "." & j, vbNullString, vgConsultaINI$
               End If
            Loop Until z$ = ""

            'pega cláusulas WHERE desta consulta e transfere para um número de consulta anterior
            j = 0
            Do
               j = j + 1
               z$ = PegaStrDoIni(vgSecaoIni$, "SQL Filtro Inicial " & i & "." & j, vgConsultaINI$) 'pega WHERE da consulta do INI
               If z$ <> "" Then
                  GravaNoIni vgSecaoIni$, "SQL Filtro Inicial " & i - 1 & "." & j, z$, vgConsultaINI$
                  GravaNoIni vgSecaoIni$, "SQL Filtro Inicial " & i & "." & j, vbNullString, vgConsultaINI$
               End If
            Loop Until z$ = ""

            'pega cláusulas ORDER BY desta consulta e transfere para um número de consulta anterior
            j = 0
            Do
               j = j + 1
               z$ = PegaStrDoIni(vgSecaoIni$, "SQL Ordem Inicial " & i & "." & j, vgConsultaINI$)  'pega WHERE da consulta do INI
               If z$ <> "" Then
                  GravaNoIni vgSecaoIni$, "SQL Ordem Inicial " & i - 1 & "." & j, z$, vgConsultaINI$
                  GravaNoIni vgSecaoIni$, "SQL Ordem Inicial " & i & "." & j, vbNullString, vgConsultaINI$
               End If
            Loop Until z$ = ""
         Else                                     'se não
            i = i - 1                             'restaura o número da consulta
         End If
      Loop Until x$ = ""
      GravaNoIni vgSecaoIni$, "Nome da consulta " & i, vbNullString, vgConsultaINI$
      GravaNoIni vgSecaoIni$, "Usuário " & i, vbNullString, vgConsultaINI$
      GravaNoIni vgSecaoIni$, "Banco de dados " & i, vbNullString, vgConsultaINI$
      i = lstConsultas.ItemData(lstConsultas.ListIndex)
      EncheLista lstConsultas                     'reenche a lista
      If lstConsultas.ListCount = 0 Then          'se não tem consultas na lista
         AcertaMeusBotoes                         'acerta os botões
      Else                                        'senão
         lstConsultas.ListIndex = 0               'força elemento 0 selecionado
      End If
   End If
End Sub

Private Sub botOk_Click()
   Dim vgFGrid As New frmBrowse, vgSecaoIni As String, i As Integer, j As Integer, x As String
   Screen.MousePointer = vbHourglass              'mouse = ampulheta
   vgSecaoIni = "CONSULTAS"
   'pega número da consulta gravada no INI
   i = 0
   Do
      i = i + 1
      x$ = PegaStrDoIni(vgSecaoIni$, "Nome da consulta " & i, vgConsultaINI$) 'pega nome da consulta do INI
   Loop Until x$ = lstConsultas.Text
   j = 0                                          'zera contador SQL
   x$ = ""                                        'zera variável que irá conter a expressão SQL
   vgNovaQuery$ = ""
   Do
      j = j + 1                                   'incrementa contador de SQL
      x$ = PegaStrDoIni(vgSecaoIni$, "SQL " & i & "." & j, vgConsultaINI$) 'pega expressão SQL
      vgNovaQuery$ = vgNovaQuery$ + x$ + " "
   Loop Until x$ = ""

   j = 0
   vgFGrid.vgFiltroInicial = ""
   x$ = ""
   Do
      j = j + 1                                   'incrementa contador de WHERE
      x$ = PegaStrDoIni(vgSecaoIni$, "SQL Filtro Inicial " & i & "." & j, vgConsultaINI$) 'pega expressão WHERE
      vgFGrid.vgFiltroInicial = vgFGrid.vgFiltroInicial + x$ + " "
   Loop Until x$ = ""

   j = 0
   vgFGrid.vgOrdemInicial = ""
   x$ = ""
   Do
      j = j + 1                                   'incrementa contador de ORDER BY
      x$ = PegaStrDoIni(vgSecaoIni$, "SQL Ordem Inicial " & i & "." & j, vgConsultaINI$) 'pega expressão ORDER BY
      vgFGrid.vgOrdemInicial = vgFGrid.vgOrdemInicial + x$ + " "
   Loop Until x$ = ""

   vgNovaQuery$ = Rtrim$(vgNovaQuery$)
   vgFGrid.vgFiltroInicial = RTrim$(vgFGrid.vgFiltroInicial)                             'filtro inicial
   vgFGrid.vgTitConsulta = lstConsultas.Text                                             'nomeia a consulta
   vgFGrid.vgFromFormID = Me.vgFormID             'passa o FormID para o browse poder identificar a consulta
   vgFGrid.Show                                   'mostra na grade
   Unload Me                                      'descarrega o form de menu de consultas
   Screen.MousePointer = vbDefault                'cursor do mouse = default
End Sub

Private Sub Form_Activate()
   AtivaForm Me                                   'executa rotinas de inicialização do form
End Sub

' carga do form
Private Sub Form_Load()
   Screen.MousePointer = vbHourglass                      'mouse = ampulheta
   vgCaracteristica = F_COMUM                             'designa propriedades
   vgTipo = TP_SELEQUERY                                  'que todos os forms
   vgSituacao = ACAO_NAVEGANDO                            'tem...
   vgFormID = 10                                          'identificacao do form
   vgTemFiltro = False                                    'desliga flag
   LeParametrosForm Me                                    'le informações gravadas deste form
   Set Icon = LoadPicture(LoadGasPicture(23))             'coloca o ícone no form

   'coloca ícones nos botões
   Set botRetorna.Picture = LoadPicture(LoadGasPicture(205))
   Set botConstroi.Picture = LoadPicture(LoadGasPicture(210))
   Set botOk.Picture = LoadPicture(LoadGasPicture(200))
   Set botOk.PictureDisabled = LoadPicture(LoadGasPicture(203))
   Set botDel.Picture = LoadPicture(LoadGasPicture(215))
   Set botDel.PictureDisabled = LoadPicture(LoadGasPicture(217))

   labTitMenu.Caption = LoadGasString(7000)               'texto título do menu

   'hint para os controles 
   vgTooltips.Create
   vgTooltips.AddTool botOk, 0, LoadGasString(7010)       'designa
   vgTooltips.AddTool botRetorna, 0, LoadGasString(7020)  'texto de
   vgTooltips.AddTool botConstroi, 0, LoadGasString(7030) 'ajuda para
   vgTooltips.AddTool botDel, 0, LoadGasString(7040)      'os objetos
   vgTooltips.AddTool lstConsultas, 0, LoadGasString(7050) 'do form

   EncheLista lstConsultas                                 'enche lista com as consultas existentes
   If lstConsultas.ListCount > 0 Then                      'se tiver consultas gravadas
      lstConsultas.ListIndex = 0                           'força primeiro selecionado
   End If
   AcertaMeusBotoes                                        'acerta os botões
   AjustaTamanho Me                                        'acerta o tamanho deste form
   Screen.MousePointer = vbDefault                         'mostra cursor default do mouse
End Sub

Private Sub Form_Resize()
   AjustaPanFundo Me                              'centraliza o form na tela
End Sub

Private Sub Form_Unload(Cancel As Integer)
   FinalizaForm Me                                'executa finalização do form
   Set vgTooltips = Nothing
   Set frmSeleQueries = Nothing                   'libera o segmento de código do form
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyEscape Then                 'se teclou ESC
      Unload Me                                   'tira este form da memória
   End If
End Sub

'eche uma ListBox ou ComboBox com os nomes das queries válidas
Public Sub EncheLista(vgCt As Control)
   Dim vgContConsultas As Integer, vgContSQL As Integer, x As String, z As String, _
       vgUsuario As String, i As Integer, vgSecaoIni As String, vgExpSQL As String

   vgCt.Clear                                         'limpa o controle
   vgContConsultas = 0
   vgContSQL = 0
   vgSecaoIni$ = "CONSULTAS"
   Do
      vgContConsultas = vgContConsultas + 1           'Incrementa o contador
      vgExpSQL$ = ""
      x$ = PegaStrDoIni(vgSecaoIni$, "Nome da consulta " & vgContConsultas, vgConsultaINI$) 'pega nome da consulta do INI
      vgUsuario = PegaStrDoIni(vgSecaoIni$, "Usuário " & vgContConsultas, vgConsultaINI$)   'pega usuário que pode acessar a consulta
      If x$ <> "" Then                            'se conseguiu pegar uma consulta
         vgContSQL = 0                            'zera contador SQL
         z$ = ""                                  'zera variável que irá conter a expressão SQL
         Do
            vgContSQL = vgContSQL + 1             'incrementa contador de SQL
            z$ = PegaStrDoIni(vgSecaoIni$, "SQL " & vgContConsultas & "." & vgContSQL, vgConsultaINI$) 'pega expressão SQL
            vgExpSQL$ = vgExpSQL$ + z$ + " "      'incrementa expressão SQL
         Loop Until z$ = ""
         vgExpSQL$ = RTrim$(vgExpSQL$)            'retira caracteres em branco a direita
         z$ = vgExpSQL$
         If z$ <> "" Then
            If InStr(x$, "~") = 0 Then            'se tem "~" no nome é do sistema
               i = InStr(z$, "FROM ")             'pega clásula FROM
               z$ = LTrim$(Mid$(z$, i + 5))
               i = InStr(z$, "WHERE ")
               If i = 0 Then
                  i = InStr(z$, "GROUP BY ")
                  If i = 0 Then
                     i = InStr(z$, "ORDER BY ")
                  End If
               End If
               z$ = RTrim$(Left(z$, IIf(i = 0, Len(z$), i - 1)))
               i = HaNaString(1, z$ + ",", ",;" + vbCrLf, UM_A_UM) 'pega nome da 1a. tabela
               z$ = Retira$(Left$(z$, i - 1), "[]", UM_A_UM)       'tira colchetes e,
               If Permitido(z$, ACAO_NAVEGANDO) And (vgUsuario = "*TODOS*" Or vgUsuario = vgPWUsuario$) Then 'se tem permissão,
                  vgCt.AddItem "   "              'coloca no topo da lista
                  vgCt.List(0) = x$               'troca para o nome certo da consulta
               End If
            End If
         End If
      End If
   Loop Until x$ = ""
End Sub

Private Sub lstConsultas_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn And lstConsultas.ListIndex <> -1 Then
      botOk_Click
   End If
End Sub
