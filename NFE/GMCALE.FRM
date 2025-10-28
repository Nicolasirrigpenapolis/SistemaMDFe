Version 5.00
Begin VB.Form frmGMCale
   BorderStyle     =   0  'None
   Caption         =   "Form1"
   ClientHeight    =   1425
   ClientLeft      =   6990
   ClientTop       =   3585
   ClientWidth     =   3975
   BeginProperty Font
      Name            =   "Arial"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   ScaleHeight     =   1425
   ScaleWidth      =   3975
   ShowInTaskbar   =   0       'False
   Begin VB.PictureBox picFoco 
      Height          =   315
      Left            =   2640
      ScaleHeight     =   255
      ScaleWidth      =   435
      TabIndex        =   0
      Top             =   150
      Width           =   495
   End
   Begin NFE.GListV grdListaG 
      Height          =   1260
      Left            =   90
      TabIndex        =   1
      Top             =   60
      Width           =   1890
      _ExtentX        =   3334
      _ExtentY        =   2223
      TrackSelect     =   -1  'True
      HideSelect      =   -1  'True
      GridLines       =   0   'False
      HideLeftBar     =   -1  'True
      HideHScroll     =   -1  'True
      BorderStyle     =   1
      RowHeight       =   240
      ShowGridCaption =   0   'False
      Caption         =   ""
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         StrikeThrough   =   0   'False
      EndProperty
   End
   Begin VB.TextBox txtSele 
      Appearance      =   0  'Flat
      BackColor       =   &H80000002&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000009&
      Height          =   315
      Left            =   2040
      Locked          =   -1  'True
      TabIndex        =   2
      Top             =   150
      Visible         =   0   'False
      Width           =   495
   End
End
Attribute VB_Name = "frmGMCale"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'Apresenta calendário para entrada de datas

Option Explicit
DefInt A-Z

Const NUM_LINS = 8
Const NUM_COLS = 7

'para desenhar os botões
Const BOT_ANT = 0
Const BOT_PROX = 1
Const BOT_CIMA = 0
Const BOT_BAIXO = 1

Public CtTransfer As FormataCampos, OqMostrar As Integer, WLst As Single, TmUltCol As Single
Public vgCaracteristica As Integer, vgSituacao As Integer, vgFormID As Long, vgTipo As Integer, vgGrdCount As Long

Dim LargQuadro As Integer, AltQuadro As Integer, MesAtual As Variant, _
            AnoAtual As Variant, DataAtual As Variant, UltimoDia As Variant, _
            Movendo As Boolean, XAnt As Single, WAnt As Single, WIni As Single, _
            YAnt As Single, HAnt As Single, HIni As Single, _
            vgForcaClick As Boolean, vgPodeSelecionar As Boolean, UltOqMostrar As Integer, _
            vgListBoxSearch As String, vgFields As String, vgOrder As String, vgDatBase As GDataBase                         ', vgRs As Object
Dim NoRefresh As Boolean, RegNext As Variant, RegPrev As Variant, vgSemReg As Boolean

'desenha botão com aspecto 3d
Sub DesenhaBotao(bQual, bEstado)
   Dim BotaoAnt As POINTAPI, BotaoProx As POINTAPI
   If bQual = BOT_ANT Then
      BotaoAnt.X = 1
      BotaoAnt.Y = 0
      ForeColor = IIf(bEstado = BOT_CIMA, vbBlack, vbWhite)
      Line (LargQuadro, 0)-(LargQuadro, AltQuadro)
      ForeColor = IIf(bEstado = BOT_CIMA, vbWhite, vbBlack)
      Line (BotaoAnt.X, BotaoAnt.Y + (AltQuadro \ 2))-(BotaoAnt.X + LargQuadro, BotaoAnt.Y)
      ForeColor = IIf(bEstado = BOT_CIMA, vbBlack, vbWhite)
      Line (BotaoAnt.X, BotaoAnt.Y + (AltQuadro \ 2))-(BotaoAnt.X + LargQuadro, BotaoAnt.Y + (AltQuadro - 1))
   Else
      BotaoProx.X = (LargQuadro * (NUM_COLS - 1))
      BotaoProx.Y = 1
      ForeColor = IIf(bEstado = BOT_CIMA, vbWhite, vbBlack)
      Line (BotaoProx.X, 0)-(BotaoProx.X, AltQuadro)
      Line (BotaoProx.X, BotaoProx.Y)-(BotaoProx.X + LargQuadro, BotaoProx.Y + (AltQuadro \ 2))
      ForeColor = IIf(bEstado = BOT_CIMA, vbBlack, vbWhite)
      Line (BotaoProx.X, BotaoProx.Y + AltQuadro - 2)-(BotaoProx.X + LargQuadro, BotaoProx.Y + (AltQuadro \ 2))
   End If
End Sub

'esta função monta o calendário
Sub PintaCalendario(ByVal qMes As Integer, ByVal qAno As Integer)
   Dim i As Integer, Hoje As Variant, Titulo As String, TempStr As String, _
       PosInic As Integer, Lin As Integer, Col As Integer, DiaAtual As Integer
   MesAtual = qMes
   AnoAtual = qAno

   'ajusta a área do calendário
   ScaleMode = 3                                  'pixel
   AutoRedraw = True
   On Error Resume Next                           'vb4 só pode mostrar modal

   'calcula o tamanho do quadrado do calendário
   AltQuadro = TextHeight("W")
   If (AltQuadro * NUM_LINS) < ScaleHeight Then
      AltQuadro = ScaleHeight \ NUM_LINS
   End If
   LargQuadro = TextWidth("M")
   If (LargQuadro * NUM_COLS) < ScaleWidth Then
      LargQuadro = ScaleWidth \ NUM_COLS
   End If

   'não podemos dar CLS pois isso apaga os botões também - vamos apagar só o que queremos
   'apaga primeiro o miolo do título
   Titulo = "XXXX/0000"
   CurrentY = (AltQuadro - TextHeight(TempStr)) \ 2
   CurrentX = (ScaleWidth - TextWidth(Titulo)) \ 2
   Line (CurrentX, CurrentY)-(CurrentX + TextWidth(Titulo), CurrentY + TextHeight(Titulo)), BackColor, BF
   'agora a área do calendário
   CurrentY = (2 * AltQuadro) + 2
   CurrentX = 0
   Line (CurrentX, CurrentY)-(ScaleWidth, ScaleHeight), BackColor, BF

   ForeColor = vbBlack
   i = 1 * 15
   Width = ((LargQuadro * NUM_COLS) * Screen.TwipsPerPixelX) + i
   Height = ((AltQuadro * NUM_LINS) * Screen.TwipsPerPixelY) + i

   'linhas horizontais
   For i = 1 To NUM_LINS - 1
      Line (0, AltQuadro * i)-(LargQuadro * NUM_COLS, AltQuadro * i)
   Next

   'linhas verticais
   For i = 1 To NUM_LINS - 1
      Line (LargQuadro * i, AltQuadro)-(LargQuadro * i, AltQuadro * NUM_LINS)
   Next

   'efeitos 3d - bordas do form
   ForeColor = vbWhite
   Line (0, 0)-(0, ScaleHeight)
   Line (0, 0)-(ScaleWidth, 0)
   ForeColor = vbBlack
   Line (0, ScaleHeight - 1)-(ScaleWidth - 1, ScaleHeight - 1)
   Line (ScaleWidth - 1, 0)-(ScaleWidth - 1, ScaleHeight - 1)

      'bordas dos botões
   ForeColor = vbWhite
   For Lin = 2 To NUM_LINS
      For Col = 0 To NUM_COLS - 1
         Line (LargQuadro * Col + 1, AltQuadro * (Lin - 1) + 1)-((LargQuadro * (Col + 1)), AltQuadro * (Lin - 1) + 1)
         Line (LargQuadro * Col + 1, AltQuadro * (Lin - 1) + 1)-(LargQuadro * Col + 1, AltQuadro * Lin - 1 + 1)
      Next
   Next

   ForeColor = vbBlue

   'acha o dia da semana para o primeiro dia do mes
   Hoje = Format$("1/" + Format$(qMes) + "/" + Format$(qAno), "dd/mm/yyyy")

   'imprime o título
   ForeColor = vbBlack
   Titulo = Format$(Hoje, "mmm/yyyy")
   FontBold = True
   CurrentY = (AltQuadro - TextHeight(TempStr)) \ 2
   CurrentX = (ScaleWidth - TextWidth(Titulo)) \ 2
   Print Titulo;

   'imprime os dias da semana
   CurrentY = AltQuadro + ((AltQuadro - 1 - TextWidth("W")) \ 2)
   For i = 0 To NUM_COLS - 1
      TempStr = Mid$("DSTQQSS", i + 1, 1)
      CurrentX = (LargQuadro * i) + (((LargQuadro + 1) - TextWidth(TempStr)) \ 2)
      Print Left$(Format$(i + 1, "ddd"), 1);
   Next
   FontBold = False

   'imprime os dias do mes
   ForeColor = vbBlue
   PosInic = Weekday(Hoje) - 1
   DiaAtual = 1
   Lin = 2

   'capta o número de dias que tem este mes
   UltimoDia = DateSerial(qAno, qMes + 1, 1)
   UltimoDia = DateSerial(Year(UltimoDia), Month(UltimoDia), Day(UltimoDia) - 1)
   CurrentY = (AltQuadro * Lin) + ((AltQuadro - TextHeight("W")) \ 2) + 1
   While DiaAtual <= Day(UltimoDia)
      TempStr = DiaAtual
      CurrentX = (LargQuadro * PosInic) + (((LargQuadro + 3) - TextWidth(TempStr)) \ 2)
      Print TempStr;
      DiaAtual = DiaAtual + 1
      PosInic = (PosInic + 1) Mod 7
      If PosInic = 0 Then CurrentY = CurrentY + AltQuadro
   Wend
   DataAtual = DateSerial(AnoAtual, MesAtual, 1)
   Refresh
End Sub

'desenha calendario ou posiciona lst no top do form
Public Sub IniciaCale(Oq As Integer)
   Dim x As Variant
   UltOqMostrar = OqMostrar
   OqMostrar = Oq
   'Set lst.Font = CtTransfer.Font
   If OqMostrar = MOSTRA_CALE Then
      If Len(CtTransfer.Text) > 0 And IsDate(CtTransfer.Text) Then
         X = CtTransfer.Text
      Else
         X = Now
      End If
      PintaCalendario Month(X), Year(X)

      'desenha os botões 3d anterior/próximo
      DesenhaBotao BOT_ANT, BOT_CIMA
      DesenhaBotao BOT_PROX, BOT_CIMA
      grdListaG.Left = -5000
      grdListaG.Width = 1000
   ElseIf OqMostrar = MOSTRA_LST_PESQUISA Then
      If Len(CtTransfer.PesqFieldCapture) > 0 Then
         grdListaG.FullRowSelect = True
      Else
         grdListaG.FullRowSelect = False
      End If
      grdListaG.HeaderHeight = 17 * Screen.TwipsPerPixelY
      grdListaG.HideCaption = False
      grdListaG.GridLines = True
      grdListaG.BorderStyle = GBorder_3D
      grdListaG.Move 0, 0
      picFoco.Move 30, 30, 0, 0
   Else
      If OqMostrar = MOSTRA_LST_EXTERNA Then
         grdListaG.HeaderHeight = 255
         grdListaG.HideCaption = False
      Else
         grdListaG.HeaderHeight = 30
         grdListaG.HideCaption = True
      End If
      grdListaG.GridLines = True
      grdListaG.BorderStyle = GBorder_Flat
      grdListaG.FullRowSelect = True
      grdListaG.Move 0, 0
      picFoco.Move 30, 30, 0, 0
   End If
End Sub

Private Sub Form_Activate()
   If grdListaG.Visible Then grdListaG.SetFocus
End Sub

'se outro form se torna ativo some com a lst ou calendário
Private Sub Form_Deactivate()
   On Error Resume Next                                  'previne erro...
   ClearSelection
   grdListaG.Visible = False
   Hide                                                  'descarrega calendário
   Enabled = False
   CtTransfer.LostFocus                                  'executa evento LostFocus
   If Err Then Err.Clear                                 'se tem erro reseta-o
   If OqMostrar = MOSTRA_CALE Then                       'se está mostrando calendário
      Set CtTransfer = Nothing                           'vamos relamente descarregar
      Unload Me                                          'o form
      Set frmGMCale = Nothing
   End If
End Sub

Private Sub ClearSelection()
   vgListBoxSearch$ = ""                                  'retira pesquisa
   If grdListaG.HideSelect <> False Then
      grdListaG.HideSelect = False
   End If
   grdListaG.ClearSearch
   txtSele.Visible = False                                'incremental
End Sub

'pega item selecionado no grid e joga na caixa de texto
Public Sub PegaSelecao(DescarregaCt As Boolean)
   Dim i As Long, vgX As String
   Dim vgShowFields() As String                   'array com os campos a mostrar da combobox
   Dim vgColumn As Variant                        'campo a mostrar - usado no laço for each do vetor de campos a mostrar
   Dim vgFormatter As New FormataCampos           'instância da formata campos que será passado como parâmetro, por referência, ao método FormattedFieldValue da GRecordset
   
   vgShowFields = Split(CtTransfer.ShowFields, "; ") 'carregando os campos a mostrar no array
   If CtTransfer.vgNaoEClick = 0 Then                'evita recursividade
      CtTransfer.vgNaoEClick = -2
      If Len(CtTransfer.ListFields) > 0 And Len(CtTransfer.BoundColumn) = 0 Then 'lst interna
         CtTransfer.Value = CtTransfer.ListIndex
      ElseIf OqMostrar = MOSTRA_LST_EXTERNA Then
         CtTransfer.vgValueAtual = grdListaG.RecordSet.FieldValue(CtTransfer.BoundColumn) 'CtTransfer.vgRsLista.Fields(CtTransfer.BoundColumn).Value
         vgX$ = ""                                'string de retorno
         For Each vgColumn In vgShowFields        'vamos percorrer todos os campos a mostrar
            If Len(vgX$) > 0 Then vgX$ = vgX$ + vgSubsTab$ 'se nao for a 1a. coluna coloca um seprador
            vgX$ = vgX$ & (grdListaG.Recordset.FormattedFieldValue(vgColumn, vgFormatter) & "") 'vai montando a string
         Next
         CtTransfer.Text = vgX$                   'coloca na caixa de texto
      ElseIf OqMostrar = MOSTRA_LST_PESQUISA Then
         If grdListaG.Recordset.RecordCount > 0 Then
            If Len(CtTransfer.PesqFieldCapture) > 0 Then
               CtTransfer.Value = grdListaG.Recordset.FieldValue(CtTransfer.PesqFieldCapture) 'CtTransfer.vgRsLista.Fields(CtTransfer.BoundColumn).Value
            Else
               CtTransfer.Value = grdListaG.ColumnValue( -1, grdListaG.Col)                   'CtTransfer.vgRsLista.Fields(CtTransfer.BoundColumn).Value
            End If
         End If
      End If
      CtTransfer.vgNaoEClick = 0                  'reseta flag de recursividade
      If DescarregaCt Then                        'se que descarregar o controle
         On Error Resume Next                     'evita parar por erro...
         ClearSelection
         Hide                                     'vamos faze-lo
         Enabled = False
      End If
   End If
   
   Set vgFormatter = Nothing                      'destruindo a instância do formatador
End Sub

Public Sub Finalize()
   grdListaG.Finalize
   Set CtTransfer = Nothing
End Sub

Private Sub Form_Unload(Cancel As Integer)
   Finalize
End Sub

Private Sub grdListaG_ItemClick(ByVal Item As Long, Columns() As Variant)
   If Item <> -1 Then
      PegaSelecao True                                      'coloca na caixa de texto
   End If
End Sub

Private Sub grdListaG_KeyDown(ByVal KeyCode As Integer, ByVal Shift As Integer, Columns() As Variant)
   On Error Resume Next
   If KeyCode = vbKeyReturn Then                           'teclou o enter
      PegaSelecao True                                     'coloca na caixa de texto
   ElseIf KeyCode = vbKeyBack And Len(vgListBoxSearch$) > 1 And OqMostrar <> MOSTRA_LST_PESQUISA Then
      vgListBoxSearch$ = SearchListBox(Left$(vgListBoxSearch$, Len(vgListBoxSearch$) - 1), True)
   ElseIf KeyCode = vbKeyDelete Or KeyCode = vbKeyBack Then
      grdListaG.SelecionaItem -1
      ClearSelection
   ElseIf (KeyCode = vbKeyReturn Or KeyCode = vbKeyLeft Or KeyCode = vbKeyRight Or _
       KeyCode = vbKeyPageDown Or KeyCode = vbKeyPageUp Or KeyCode = vbKeyEnd Or _
       KeyCode = vbKeyHome Or KeyCode = vbKeyUp Or KeyCode = vbKeyDown )And OqMostrar <> MOSTRA_LST_PESQUISA Then
      ClearSelection
   End If
   Form_KeyDown KeyCode, Shift
End Sub

Private Sub grdListaG_KeyPress(ByVal KeyAscii As Integer, ByVal Shift As Integer, Columns() As Variant)
   On Error Resume Next
   If KeyAscii >= 32 And OqMostrar <> MOSTRA_LST_PESQUISA Then
      Select Case KeyAscii
         Case 96 to 105                           'se digitado no teclado numérico
            vgListBoxSearch$ = SearchListBox(vgListBoxSearch$ + Chr$(KeyAscii - 48), True)
         Case 110                                 'se é a vírgula, vamos aceitar na busca
            vgListBoxSearch$ = SearchListBox(vgListBoxSearch$ + Chr$(KeyAscii - 66), True)
         Case Else
            vgListBoxSearch$ = SearchListBox(vgListBoxSearch$ + Chr$(KeyAscii), True)    
      End Select
   End If
End Sub

Private Sub grdListaG_MouseMove()
   MousePointer = vbNormal
End Sub

Public Sub Remonta()
   NoRefresh = True
   RegNext = ""
   RegPrev = ""
   vgSemReg = False
   SelecionaItem CtTransfer.vgValueAtual
   grdListaG.Refresh
   RegNext = ""
   RegPrev = ""
   vgSemReg = False
   NoRefresh = False
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyEscape Then                          'ESC cai fora
      ClearSelection
      Hide
      If CtTransfer.vgValueAtual = "" Then
         grdListaG.SelecionaItem -1
      End If
      Enabled = False
      KeyCode = 0                                         'para evitar que todo o formulário seja fechado quando pressionado ESC num campo combobox na barra de filtro 
   End If
End Sub

Private Sub Form_Load()
   vgCaracteristica = F_COMUM                             'característica deste form
   vgSituacao = ACAO_NAVEGANDO                            'situação atual do form
   vgFormID = 18                                          'identificação do form
   vgTipo = TP_CALE                                       'tipo do formulário
   WAnt = Width                                           'tamanho original do form
   OqMostrar = MOSTRA_NAO                                 'ainda não mostrou nada
   grdListaG.FullRowSelect = True
   grdListaG.HideHeader = False
   grdListaG.HideStatus = True
   grdListaG.HideCaption = True
   grdListaG.HeaderHeight = 30
   grdListaG.HideLeftBar = True
   grdListaG.FlatHeader = True
   grdListaG.GridLines = False
   grdListaG.HideSelect = False
   grdListaG.HideHScroll = False
   grdListaG.HideFocus = True
   grdListaG.Visible = False
   vgForcaClick = False                                   'reseta flag
End Sub

'esta rotina manipula o clique no calendário
Private Sub Form_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
   Dim Lin As Integer, Col As Integer, NewDate As Variant, PosInic As Integer, _
       Hoje As Date, Posicao As Integer, z As String
   If OqMostrar = MOSTRA_CALE Then
      Lin = Y \ AltQuadro
      Col = X \ LargQuadro
      If Lin = 0 And (Col = 0 Or Col = 6) Then
         If Col = 0 Then                                      'usuário clicou em mês anterior
            NewDate = DateSerial(AnoAtual, MesAtual - 1, 1)
            DesenhaBotao BOT_ANT, BOT_BAIXO
         Else                                                 'usuário clicou prox mês
            NewDate = DateSerial(AnoAtual, MesAtual + 1, 1)
            DesenhaBotao BOT_PROX, BOT_BAIXO
         End If
         MesAtual = Month(NewDate)
         AnoAtual = Year(NewDate)
         PintaCalendario MesAtual, AnoAtual
      Else

         'calcula o dia da semana do primeiro dia do mês
         Hoje = Format$("1/" + Format$(MesAtual) + "/" & Format$(AnoAtual), "dd/mm/yyyy")
         PosInic = WeekDay(Hoje)
         Posicao = ((Lin - 2) * NUM_COLS) + ((Col + 1) - (PosInic - 1))

         'se usuário clicou em um dia, então muda a data
         If (Posicao > 0) And (Posicao <= Day(UltimoDia)) Then
            DataAtual = DateSerial(AnoAtual, MesAtual, Posicao)
            z$ = TrataMaskData$(CtTransfer.Mask)
            CtTransfer.Text = CStr(Format(DataAtual, z$))
            Hide
            Enabled = False
            CtTransfer.SetFocus
         Else
            DataAtual = Empty
         End If
      End If
   Else
      Movendo = True
      XAnt = X
      WAnt = Width
      YAnt = y
      HAnt = Height
   End If
End Sub

Private Sub Form_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
   Dim vgMP As Long
   
   vgMP = 0
   If x + 30 >= Width Then
      vgMP = vbSizeWE
   End If
   
   If y + 30 >= Height Then
      If vgMP = 0 Then
         vgMP = vbSizeNS
      Else
         vgMP = vbSizeNWSE
      End If
   End If
   MousePointer = vgMP
   
   If Movendo Then
      If WAnt - (XAnt - X) > WIni Then
         Width = WAnt - (XAnt - X)
      End If
      If HAnt - (YAnt - y) > HIni Then
         Height = HAnt - (YAnt - y)
      End If
   End If
End Sub

Private Sub Form_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
   If OqMostrar = MOSTRA_CALE Then
      DesenhaBotao BOT_ANT, BOT_CIMA
      DesenhaBotao BOT_PROX, BOT_CIMA
   Else
      Movendo = False
   End If
End Sub

Private Sub Form_Resize()
   If OqMostrar <> MOSTRA_CALE Then                         'campos tipo lst
      If Width < (20 * Screen.TwipsPerPixelX) Then          'tamanho mínimo da lista externa
         Width = (20 * Screen.TwipsPerPixelX)
      End If
      If Height < (50 * Screen.TwipsPerPixelY) Then         'tamanho mínimo da lista externa
         Height = (50 * Screen.TwipsPerPixelY)
      End If
      grdListaG.Width = Width - Screen.TwipsPerPixelX
      grdListaG.Height = Height - Screen.TwipsPerPixelY
   End If
End Sub

Public Property Let Order(NewOrder As String)
   Dim x As String, ordem As String, i As Integer
   For i = 1 To Tally(NewOrder, ";") + 1
      If Len(ordem$) > 0 Then ordem$ = ordem$ + ", "
      x$ = Parse(NewOrder, "; ", i)
      If Right(x$, 1) = "-" Then
         x$ = PoeColchetes(Left(x$, Len(x$) - 1)) + " DESC"
      Else
         x$ = PoeColchetes(x$)
      End If
      ordem$ = ordem$ + x$
   Next
   vgOrder = ordem$
End Property

Public Property Get Order() As String
   Order = vgOrder
End Property

Public Property Let DataBase(NewDataBase As GDataBase)
   Set vgDatBase = NewDataBase
End Property

Public Property Get DataBase() As GDataBase
   If vgDatBase Is Nothing Then Set vgDatBase = vgDb(1)
   Set DataBase = vgDatBase
End Property

Public Sub ClearFields()
   grdListaG.ClearColumns
   vgFields = ""
End Sub

Public Sub UpdateFieldsAlias()
   Dim i As Integer, x As String
   On Error GoTo DeuErro
   If Not CtTransfer Is Nothing Then
      If Len(vgFields$) > 0 And Len(CtTransfer.Source) > 0 Then
         x$ = ExtraiSQL(CtTransfer.Source, EXP_FROM)
         For i = 1 To grdListaG.Columns.Count
            grdListaG.Columns(i).Title = CtTransfer.DataBase.Tables(x$).Columns(grdListaG.Columns(i).Name).Title
         Next
      End If
   End If
   Exit Sub
DeuErro:
End Sub

Public Sub AddField(ByVal vgFieldName As String, ByVal vgHideField As Boolean)
   Dim TpCp As GCOLUMN_TYPE
   Select Case PegaAtributo$(vgFieldName$, 2)
      Case "N"
         TpCp = TP_NUMERICO
      Case "C"
         TpCp = TP_CARACTER
      Case "I"
         TpCp = TP_BINARIO
      Case "L"
         TpCp = TP_LOGICO
      Case "M"
         TpCp = TP_MEMO
      Case "D"
         TpCp = TP_DATA_HORA
   End Select
   grdListaG.AddColumn Nothing, Nothing, vgFieldName, vgFieldName, TpCp, PegaAtributo$(vgFieldName$, 1), 255, , Not vgHideField
   If Len(vgFields) > 0 Then vgFields = vgFields + ", "
   vgFields = vgFields + PoeColchetes(vgFieldName)
End Sub

Private Sub AbreRs()
   Dim vgWhere As String, i As Integer
   If UltOqMostrar <> OqMostrar Then
      grdListaG.ClearColumns
      grdListaG.CloseRecordSet
   End If
   If OqMostrar <> MOSTRA_LST_PESQUISA Then
      vgWhere = CtTransfer.Filter
      If Len(vgWhere) > 0 And Len(CtTransfer.RelationValue) > 0 Then vgWhere = vgWhere + " AND "
      vgWhere = vgWhere + CtTransfer.RelationValue
      Set grdListaG.Recordset.Database = CtTransfer.Database
      grdListaG.Recordset.Source = CtTransfer.Source
      grdListaG.Recordset.Where = vgWhere
      grdListaG.Recordset.Top = -1
      grdListaG.Recordset.OrderBy = vgOrder
      grdListaG.Recordset.SelectColumns = vgFields
      grdListaG.RecordSet.ExternalWhere = ""
      grdListaG.RecordSet.ExternalOrderBy = ""
      grdListaG.Recordset.OpenRecordSet
   Else
      grdListaG.ClearFilterBar                    'limpa a barra de filtro do grid
      DoEvents
      grdListaG.RecordSet.ExternalWhere = ""
      grdListaG.RecordSet.ExternalOrderBy = ""
      grdListaG.OpenRecordSet CtTransfer.PesqSQLExpression, CURSOR_TABLE, True
   End If
   
   If Len(grdListaG.Recordset.RsSource) > 0 Then
      'vamos colocar colunas para se auto-ajustarem
      For i = 1 To grdListaG.Columns.Count
         grdListaG.ColumnWidth(i) = -1
      Next
   End If
End Sub

'seleciona item da lista
Public Function SelecionaItem(St As Variant, Optional SoEste As Boolean) As String
   Dim i As Long, RetVal As String, Ok As Boolean
   Dim vgShowFields() As String                   'array com campos a mostrar da combobox
   Dim vgColumn As Variant                        'campo a mostrar - usado no laço for each que percorre os campos a mostrar
   Dim vgFormatter As New FormataCampos           'instância da FormataCampos passada como parâmetro, por referência, ao método FormattedFieldValue da GRecordset.
   
   vgShowFields = Split(CtTransfer.ShowFields, "; ") 'carregando o array com os campos a mostrar
   
   If CtTransfer.ComLstExt And OqMostrar = MOSTRA_LST_EXTERNA Then
      AbreRs
      grdListaG.SelecionaItem -1
      If Len(St) > 0 Then
         RetVal$ = ""
         If SoEste And grdListaG.Recordset.RsSource <> grdListaG.Recordset.NewSource Then 'se quer selecionar só esse registro e o recordset não está de acordo com a necessidade
            Ok = grdListaG.RecordSet.PTab(CtTransfer.BoundColumn, St)                     'faz PTAB selecionando apenas esse registro
         Else                                     'senão
            grdListaG.RecordSet.SeekRecord CtTransfer.BoundColumn, "=", St 'e apenas seleciona o registro dentro do recordset completo
         End If
         
         Ok = False
         If grdListaG.RecordSet.NoMatch = False Then
            Ok = (grdListaG.RecordSet.Fields(CtTransfer.BoundColumn).Value = St)
         End If
         If Ok Then
            grdListaG.SetItemCount grdListaG.RecordSet.RecordCount         'vamos atualizar a quantidade de itens da lista... (em algumas situações o ListCount pode estar incorreto devido ao ptab)
            grdListaG.SelecionaItem grdListaG.RecordSet.AbsolutePosition - 1 'posiciona o item de acordo com sua posição absoluta no recordset
            RetVal$ = ""                          'prepara string de retorno
            For Each vgColumn In vgShowFields     'vamos percorrer todos os campos a mostrar
               If Len(RetVal$) > 0 Then RetVal$ = RetVal$ + vgSubsTab$ 'se nao for a 1a. coluna coloca um seprador
               RetVal$ = RetVal$ & (grdListaG.Recordset.FormattedFieldValue(vgColumn, vgFormatter) & "") 'vai montando a string
            Next
         End If
      ElseIf grdListaG.RecordSet.RsSource <> grdListaG.RecordSet.NewSource Then
         grdListaG.RecordSet.OpenRecordSet
         grdListaG.RecordSet.Populate
      End If
      grdListaG.SetItemCount grdListaG.Recordset.RecordCount                                             'vamos atualizar a quantidade de itens da lista... (pode ser que acabou de abrir o recordset)
   ElseIf OqMostrar = MOSTRA_LST_PESQUISA Then
      AbreRs
      RetVal$ = ""
   Else                                           'se lista interna
      If Len(St) > 0 Then                         'se tem campo já tem conteúdo
         For i = 0 To grdListaG.ListCount - 1     'corre todos os itens da lista interna
            If St = grdListaG.List(i) Then        'se é o item a selecionar
               grdListaG.SelecionaItem i          'seleciona efetivamente o item
               RetVal$ = St                       'retorna o texto do item selecionado
            End If
         Next 
      Else                                        'se campo ainda não foi preenchido                                             
         grdListaG.SelecionaItem -1               'posiciona o item em -1
      End If
   End If
   SelecionaItem = RetVal$                        'retorna string pesquisada
   
   Set vgFormatter = Nothing                      'destruindo a instância do formatador
End Function

Private Function NaoAchou(Rs As Object) As Boolean
   On Error Resume Next
   NaoAchou = Rs.NoMatch
   If Err Then
      Err.Clear
      NaoAchou = (Rs.EOF Or Rs.BOF)
   End If
End Function

'procura palavra dentro dos itens da lista
'St - valor ser pesquisado na combo
'vgVemDoGrid - flag que indica se a pesquisa partiu diretamente da lista da combo (digitando com a combo expandida)
Public Function SearchListBox(St As String, vgVemDoGrid As Boolean) As String
   Dim vgItemAtual As Long, RetVal As Boolean
   
   vgItemAtual = grdListaG.SelectedItem
   
   'vamos esconder o seletor para exibir a seleção pela digitação
   If grdListaG.HideSelect = False And vgVemDoGrid Then
      grdListaG.HideSelect = True
   End If

   'vamos sempre limpar o cache de procura se só tem 1 caracter para pesquisa
   If Len(St) = 1 Then
      grdListaG.ClearSearch
   End If
   
   RetVal = grdListaG.SearchItem(grdListaG.Columns(1).Name, Parse$(St, vbTab, 1))
   
   If Not RetVal And CtTransfer.ComLstExt Then
      SearchListBox = Left$(St$, Len(St$) - 1)
   Else
      If vgVemDoGrid Then
         SeleNoGrid St$
      Else
         PegaSelecao False                                   'coloca reg selecionado na cx de texto
         CtTransfer.SelStart = 0                             'inicio da marcacao
         CtTransfer.SelLength = Len(St$)                     'marca so o que foi digitado
      End If
      SearchListBox = St
   End If
   
   'vamos esconder o seletor para exibir a seleção pela digitação
   If grdListaG.HideSelect <> (Len(SearchListBox) > 0) And vgVemDoGrid Then
      grdListaG.HideSelect = (Len(SearchListBox) > 0)
   End If
End Function

Private Sub SeleNoGrid(St As String)
   Dim ww As Single, x As Long, y As Long, h As Long, w As Long
   On Error GoTo DeuErro
   txtSele.Visible = False
   If grdListaG.SelectedItem >= 0 And Len(St$) > 0 Then
      grdListaG.GetItemInfo x, y, w, h
      w = grdListaG.ColumnWidth(1)
      ww = TextWidth(Mid$(grdListaG.ColumnValue(-1, 1), 1, Len(St$)))
      If ww > w Then ww = w
      txtSele.Move x + Screen.TwipsPerPixelX, y + grdListaG.HeaderHeightFull + 2 * Screen.TwipsPerPixelY, ww, h - 4 * Screen.TwipsPerPixelY
      txtSele.Visible = True
      txtSele.ZOrder
      txtSele.Text = Left$(grdListaG.ColumnValue(-1, 1), Len(St$))
   End If
   Exit Sub

DeuErro:
   txtSele.Visible = False
End Sub

Private Sub picFoco_GotFocus()
   If grdListaG.Visible = False Then                    'está abrindo formulário agora....
      grdListaG.Visible = True                          'vamos mostrar o grid
      DoEvents                                          'e setar
      If grdListaG.Visible Then
         grdListaG.SetFocus                             'o foco para ele
      End If
   Else                                                 'pressionou TAB ou SHIFT+TAB dentro do grid...
      Form_Deactivate                                   'vamos cair fora
   End If
End Sub
