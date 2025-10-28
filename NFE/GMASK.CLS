VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "FormataCampos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
DefInt A-Z

'tipo de dado do controle
Enum TipoDeCampo
   Character
   Numeric
   [Date ]
   Spinner
   Memo
   [Boolean]
   [Option ]
End Enum

'ATENCAO!!! O ".," DEVE ESTAR SEMPRE NAS PRIMEIRAS POSICOES....
'lista de caracteres que podem ser inseridos na máscara
Const C_INSERTAVEIS = ".,-+$/\()[]{}: "
Const C_NUMERICOS = "0123456789"                     'set de caracteres numéricos
Const TECLA_DEL = -7                                 'valor para a tecla DEL

Const SM_CXVSCROLL = 2
Const SM_CYHSCROLL = 3

Private Declare Function GetParent Lib "user32" (ByVal hWnd As Long) As Long
Private Declare Function GetSystemMetrics Lib "user32" (ByVal nIndex As Long) As Long

Public vgTableLista As GTable                          'TableDef da lst externa
Public vgValueAtual As Variant                         'valor atual da lst (do campo a ser capturado)
Public vgText As String                                'text atual do controle (quando não houver CtPri)
Public vgTemRS As Integer                              'flag - tem DataControl da lst externa
Public vgNaoEClick As Integer                          'flag temporária
Public vgListaAberta As Boolean                        'lista (combo) está aberta

'propriedades da classe
Dim vgMask As String                                   'máscara para o campo
Dim vgDataType As TipoDeCampo                          'tipo do campo
Dim vgStuffChar As String                              'caractere para justificar à esquerda
Dim vgSelectOnFocus As Boolean                         'seleciona o campo quando pegar o foco
Dim vgColorOnFocus As OLE_COLOR                        'cor quando o cursor estiver no campo
Dim vgColorNoFocus As OLE_COLOR                        'cor quando o cursor não estiver no campo
Dim vgFillStyleOnFocus As Integer                      'estilo do enchimento quando com foco
Dim vgFillStyleNoFocus As Integer                      'estilo do enchimento quando sem foco
Dim vgRowSource As String                              'nome do data control da lst externa
Dim vgShowFields As String                             'nome dos campos para lst ou opções da lst interna
Dim vgListFields As String                             'nome dos campos para lst ou opções da lst interna
Dim vgAllowAnyText As Boolean                          'permite digitação livre em lst interna
Dim vgOrderFields As String                            'nome dos campos para ordenação da lista
Dim vgBoundColumn As String                            'nome do campo para retornar da lista (value)
Dim vgPesqFieldCapture As String                       'campo a capturar na pesquisa
Dim vgPesqSQLExpression As String                      'expressão SQL para pesquisa
Dim vgPesqBD As String                                 'nome do banco para pesquisa
Dim vgPesqModoAbertura As Integer                      'forma de abertura da pesquisa
Dim vgDatBase As GDataBase                             'BD associado a lista externa
Dim vgSource As String
Dim vgQtCh As Integer
Dim vgFormatLostFocus As Boolean                       'flag - campo todo selecionado quando pegar o foco
Dim vgBookMark As Variant
Dim vgTag As String                                    'tag do controle
Dim vgLocked As Boolean                                'se o controle esta bloqueado para edição
Dim vgEditable As Boolean                              'flag - campo é editável ou não
Dim vgCtPri As Control                                 'controle principal
Dim vgCtScr As Control                                 'scroll dos campos rotativos
Dim vgCtTit As Label                                   'label do título dos campos
Dim vgCtShp As Shape                                   'shape do formato que envolve o título
Dim vgCtFdo As Label                                   'título do campo
Dim vgCtBot(2) As CommandButton                        'botões extensores do campo
Dim vgFilter As String                                 'filtro para lista externa
Dim vgRelation As String                               'relação para lista externa
Dim vgRelationValue As String                          'relação para lista externa já com valores
Dim vgAlignment As Long                                'alinhamento para o campo
Dim vgVisible As Boolean                               'visibilidade do campo
Dim vgValorOriginal As Variant                         'valor original do campo no RS
Dim vgSetValorOriginal As Boolean                      'se pode setar valor original do campo no RS
Dim vgInFilter As Boolean                              'indica que está sendo usado na barra de filtro do grid (txtFilter)

'dimensiona variaveis para a mascara
Dim vgMascara As String                                'máscaras
Dim vgMaiusculo As Integer                             'flag - maiúsculas?
Dim vgMinusculo As Integer                             'flag - minúsculas?
Dim vgSoAlfa As Integer                                'flag - só alfabético?
Dim vgQcDec As Integer                                 'qde de casas decimais
Dim vgQcInt As Integer                                 'qde de inteiros
Dim vgTemSpInt As Integer                              'se tem separadores de inteiros

Public vgfrmGMCale As frmGMCale                        'classe ativa do momento
Public vgfrmPesquisa As frmBrowse                      'formulário de pesquisa
Dim vgListBoxSearch As String                          'string de procura na lista
Dim vgPriVez As Boolean                                'flag para evitar recursividade
Dim vgfrmCalcNaMem As Boolean                          'se o form de calculadora está na memória
Dim vgFezGotFocus As Boolean                           'flag ja fez o GotFocus

Dim FlagFocus As Boolean                               'flag para identificar o LostFocus quando abrindo a combo

Public Sub CarregaGMCale(Optional vgForca As Boolean)
   If vgfrmGMCale Is Nothing Then
      Set vgfrmGMCale = New frmGMCale
      Load vgfrmGMCale
   End If
   Set vgfrmGMCale.CtTransfer = Me                      'ctl que chamou o calendário
   If vgForca Then
      vgfrmGMCale.grdListaG.Visible = True
      'vgfrmGMCale.Move -3000, -3000, 300, 300
      vgfrmGMCale.Show
      DoEvents
      vgfrmGMCale.grdListaG.Visible = False
      vgfrmGMCale.Hide
   End If
End Sub

'pega o nome do campo que relacionado com o banco
Public Property Get DataField() As String
   On Error Resume Next
   If Not vgCtPri Is Nothing Then
      DataField = vgCtPri.DataField
      If Err Then
         Err.Clear
         If Not vgCtFdo Is Nothing Then
            DataField = vgCtFdo.DataField
         End If
      End If
   End If
End Property

'filtro para lst externa - pega
Public Property Get Filter() As String
   Filter = vgFilter
End Property

'filtro para lst externa - coloca
Public Property Let Filter(ByVal New_Filter As String)
   If vgFilter <> New_Filter Then
      vgFilter = New_Filter
   End If
End Property

'relação para lst externa - pega
Public Property Get Relation() As String
   Relation = vgRelation
End Property

'relação para lst externa - coloca
Public Property Let Relation(ByVal New_Relation As String)
   If vgRelation <> New_Relation Then
      vgRelation = New_Relation
   End If
End Property

'relação para lst externa (já com valores) - pega
Public Property Get RelationValue() As String
   RelationValue = vgRelationValue
End Property

'relação para lst externa (já com valores) - coloca
Public Property Let RelationValue(ByVal New_RelationValue As String)
   If vgRelationValue <> New_RelationValue Then
      vgRelationValue = New_RelationValue
   End If
End Property

'pega um item específico da lista
Public Property Get List(Index As Long) As String
   List = vgfrmGMCale.grdListaG.List(Index)
End Property

'seta um item específico para a lista
Public Property Let List(Index As Long, NewList As String)
   vgfrmGMCale.grdListaG.List(Index) = NewList
End Property

'retorna se o campo é editável ou não
Public Property Get Editable() As Boolean
   Editable = vgEditable
End Property

'define se o campo é editável ou não
Public Property Let Editable(NewEditable As Boolean)
   vgEditable = NewEditable
End Property

'retorna alinhamento para o controle
Public Property Get Alignment() As Long
   Alignment = vgAlignment
End Property

'seta alinhamento para o controle
Public Property Let Alignment(ByVal New_Alignment As Long)
   On Error Resume Next
   If vgAlignment <> New_Alignment Then
      vgAlignment = New_Alignment
      vgCtPri.Alignment = vgAlignment
   End If
End Property

'abre recordset no no mesmo banco de dados da lista externa
Public Property Get OpenRecordSet(vgSQL As String) As Object
   Set OpenRecordSet = vgDatBase.OpenRecordSet(vgSQL$)
End Property

'muda plano do controle
Public Sub ZOrder(ByVal Index As Integer)
   On Error Resume Next                                  'previne eventuais erros
   vgCtPri.ZOrder Index                                  'tenta colocar ctl no plano indicado
End Sub

Public Sub Finalize()
   On Error Resume Next                                 'previne erros
   If Not vgfrmGMCale Is Nothing Then
      Set vgfrmGMCale.CtTransfer = Nothing
      vgfrmGMCale.Finalize
      Unload vgfrmGMCale                                'descarrega o form da lst
      Set vgfrmGMCale = Nothing
   End If
   If Not vgfrmPesquisa Is Nothing Then
      Set vgfrmPesquisa.CtTransfer = Nothing
      Unload vgfrmPesquisa                              'descarrega o form da lst
      Set vgfrmPesquisa = Nothing
   End If
   Unload frmGMCalc                                     'vamos descarregá-la
   Set frmGMCalc = Nothing
   Set vgCtPri = Nothing
   Set vgCtTit = Nothing
   Set vgCtShp = Nothing
   Set vgCtFdo = Nothing
   Set vgCtScr = Nothing
   Set vgCtBot(0) = Nothing
   Set vgCtBot(1) = Nothing
   Set vgCtBot(2) = Nothing
End Sub

'foco no controle principal - coloca
Public Sub SetFocus()
   On Error Resume Next                                  'previne eventuais erros
   vgCtPri.SetFocus                                      'tenta colocar o foco no ctl principal
End Sub

'controle principal - coloca
Public Property Set CtPri(ByVal New_Ct As Control)
   Dim i As Boolean
   Set vgCtPri = New_Ct                                  'controle principal
   vgVisible = True                                      'visiblidade true
   On Error Resume Next                                  'pode ser que o controle nao tenha esta propriedade
   i = New_Ct.Locked                                     'esta bloqueado?
   If Err Then                                           'não tem a propriedade
      Err.Clear
   Else
      vgLocked = i                                       'paga como esta
   End If
End Property

'controle principal - pega
Public Property Get CtPri() As Control
   Set CtPri = vgCtPri
End Property

'controle que será o título - coloca
Public Property Set CtTit(ByVal New_Ct As Label)
   Set vgCtTit = New_Ct
End Property

'controle resposável pelo formato do título - coloca
Public Property Set CtShp(ByVal New_Ct As Shape)
   Set vgCtShp = New_Ct
End Property

'cotrole que dará efeito 3d e será vinculado ao BD - coloca
Public Property Set CtFdo(ByVal New_Ct As Label)
   Set vgCtFdo = New_Ct
   vgCtFdo.ZOrder 0
End Property

'controle scroll de campos rotativos - coloca
Public Property Set CtScr(ByVal New_Ct As Control)
   Set vgCtScr = New_Ct
End Property

'controle botão extensor - coloca
Public Property Set CtBot(ByVal Index As Integer, ByVal New_Ct As CommandButton)
   Set vgCtBot(Index) = New_Ct
End Property

'controle botão extensor - pega
Public Property Get CtBot(ByVal Index As Integer) As CommandButton
   Set CtBot = vgCtBot(Index)
End Property

Public Property Let Source(ByVal NewSource As String)
   vgSource = NewSource
   UpdateAlias
End Property

Public Property Get Source() As String
   Source = vgSource
End Property

Public Property Let DataBase(ByVal NewDataBase As GDataBase)
   Set vgDatBase = NewDataBase
   UpdateAlias
End Property

Public Property Get DataBase() As GDataBase
   If vgDatBase Is Nothing Then Set vgDatBase = vgDb(1)
   Set DataBase = vgDatBase
End Property

'flag se o campo será reformatado após perder o foco - coloca
Public Property Let FormatLostFocus(ByVal New_FormatLostFocus As Boolean)
   vgFormatLostFocus = New_FormatLostFocus
End Property

'cor de fundo do controle - pega
Public Property Get BackColor() As OLE_COLOR
   BackColor = vgCtPri.BackColor
End Property

'cor de fundo do controle - coloca
Public Property Let BackColor(ByVal New_BackColor As OLE_COLOR)
   vgCtPri.BackColor() = New_BackColor
End Property

'handle do controle - pega
Public Property Get hWnd() As Long
   On Error Resume Next                                  'pode ser que o ctl principal não tenha handle
   hWnd = vgCtPri.hWnd                                   'handle do ctl principal
   If Err Then                                           'ctl sem handle
      Err.Clear                                          'tira erro da memória
      hWnd = vgCtPri.Container.hWnd                      'pega o handle do seu container
   End If
End Property

'marca para o controle normalmente usada em ctl do tipo optativo - pega
Public Property Get BookMark() As Variant
   BookMark = vgBookMark
End Property

'marca para o controle normalmente usada em ctl do tipo optativo - coloca
Public Property Let BookMark(ByVal New_BookMark As Variant)
   vgBookMark = New_BookMark
End Property

'largura do ctl - pega
Public Property Get Width() As Single
   If Not vgCtFdo Is Nothing Then                 'se o controle tem fundo
      Width = vgCtFdo.Width                       'retorna a largura do fundo
   ElseIf Not vgCtPri Is Nothing Then             'se o controle não tem fundo
      Width = vgCtPri.Width                       'retorna a largura do controle
   End If
End Property

'largura do ctl - coloca
Public Property Let Width(ByVal New_Width As Single)
   Dim vgDif As Single, vgWi As Single, i As Integer
   If Not vgCtFdo Is Nothing Then                 'se o controle tem fundo
      vgCtFdo.Width = New_Width                   'definimos a nova largura para o fundo
      If vgCtFdo.Appearance = 0 Then              'se o fundo tem aparência Flat
         vgDif = Screen.TwipsPerPixelX            'pega quantidade de twips da largura do pixel
      Else
         vgDif = Screen.TwipsPerPixelX * 2        'pega 2 vezes a quantidade de twips da largura do pixel
      End If
      vgCtPri.Width = New_Width - 2 * vgDif       'define a largura interna do controle, sem a borda
      For i = 0 To 2
         If Not vgCtBot(i) Is Nothing Then
            vgWi = vgCtFdo.Width - vgCtBot(i).Width - 2 * vgDif 'calcula a largura interna do controle, sem a borda
            If vgWi < vgCtBot(i).Width Then
               Width = vgCtBot(i).Width * 2 + 2 * vgDif
               Exit Property
            Else
               vgCtPri.Width = vgWi                             'define a largura interna do controle, tirando a diferença do tamanho de botões
            End If
            Left = Left                                         'ajusta a nova posição para os botões
         End If
      Next
   ElseIf Not vgCtPri Is Nothing Then
      vgWi = New_Width
      For i = 0 To 2
         If Not vgCtBot(i) Is Nothing Then
            vgWi = vgWi - 255
         End If
      Next
      If vgWi < 255 Then
         vgWi = 255 * 2
      End If
      vgCtPri.Width = vgWi                                      'define a nova largura do controle
      Left = Left                                               'ajusta a posição dos botões
   End If
End Property

'Topo do ctl - pega
Public Property Get Top() As Single
   If Not vgCtFdo Is Nothing Then
      Top = vgCtFdo.Top
   ElseIf Not vgCtPri Is Nothing Then
      Top = vgCtPri.Top
   End If
End Property

'Topo do ctl - coloca
Public Property Let Top(ByVal New_Top As Single)
   Dim vgDif As Single, i As Integer
   
   If Not vgCtFdo Is Nothing Then
      vgCtFdo.Top = New_Top
      If vgCtFdo.Appearance = 0 Then
         vgDif = Screen.TwipsPerPixelY
      Else
         vgDif = Screen.TwipsPerPixelY * 2
      End If
      vgCtPri.Top = New_Top + vgDif
      For i = 0 To 2
         If Not vgCtBot(i) Is Nothing Then
            vgCtBot(i).Top = vgCtFdo.Top + vgDif
         End If
      Next
   ElseIf Not vgCtPri Is Nothing Then
      vgCtPri.Top = New_Top
      For i = 0 To 2
         If Not vgCtBot(i) Is Nothing Then
            vgCtBot(i).Top = vgCtPri.Top
         End If
      Next
   End If
End Property

'Esquerdo do ctl - pega
Public Property Get Left() As Single
   If Not vgCtFdo Is Nothing Then
      Left = vgCtFdo.Left
   ElseIf Not vgCtPri Is Nothing Then
      Left = vgCtPri.Left
   End If
End Property

'Esquerdo do ctl - coloca
Public Property Let Left(ByVal New_Left As Single)
   Dim vgDif As Single, i As Integer
   If Not vgCtFdo Is Nothing Then
      vgCtFdo.Left = New_Left
      If vgCtFdo.Appearance = 0 Then
         vgDif = Screen.TwipsPerPixelX
      Else
         vgDif = Screen.TwipsPerPixelX * 2
      End If
      vgCtPri.Left = New_Left + vgDif
      For i = 0 To 2
         If Not vgCtBot(i) Is Nothing Then
            vgCtBot(i).Left = vgCtFdo.Left + vgCtFdo.Width - vgCtBot(i).Width - vgDif
            vgDif = vgDif + vgCtBot(i).Width
         End If
      Next
   ElseIf Not vgCtPri Is Nothing Then
      vgCtPri.Left = New_Left
      For i = 2 To 0 Step -1
         If Not vgCtBot(i) Is Nothing Then
            vgCtBot(i).Left = vgCtPri.Left + vgCtPri.Width + vgDif
            vgDif = vgDif + vgCtBot(i).Width
         End If
      Next
   End If
End Property

Public Sub Move(ByVal New_Left As Single, ByVal New_Top As Single, ByVal New_Width As Single, ByVal New_Height As Single)
   Left = New_Left
   Top = New_Top
   Width = New_Width
   Height = New_Height
End Sub

'altura do ctl - pega
Public Property Get Height() As Single
   Height = vgCtPri.Height
End Property

'altura do ctl - coloca
Public Property Let Height(ByVal New_Height As Single)
   Dim vgDif As Single, i As Integer
   If Not vgCtFdo Is Nothing Then
      vgCtFdo.Height = New_Height
      If vgCtFdo.Appearance = 0 Then
         vgDif = Screen.TwipsPerPixelY
      Else
         vgDif = Screen.TwipsPerPixelY * 2
      End If
      vgCtPri.Height = New_Height - vgDif * 2
      For i = 0 To 2
         If Not vgCtBot(i) Is Nothing Then
            vgCtBot(i).Height = vgCtPri.Height
            Left = Left
         End If
      Next
   Else
      vgCtPri.Height = New_Height
      For i = 0 To 2
         If Not vgCtBot(i) Is Nothing Then
            vgCtBot(i).Height = vgCtPri.Height
         End If
      Next
      Left = Left
   End If
End Property

'caractere para ser mostrado no ctl quando digitando senha - pega
Public Property Get PasswordChar() As String
   PasswordChar = vgCtPri.PasswordChar
End Property

'caractere para ser mostrado no ctl quando digitando senha - coloca
Public Property Let PasswordChar(ByVal New_PasswordChar As String)
   vgCtPri.PasswordChar() = New_PasswordChar
End Property

'cor do shape quando sem foco - pega
Public Property Get ColorNoFocus() As OLE_COLOR
   ColorNoFocus = vgColorNoFocus
End Property

'cor do shape quando sem foco - pega
Public Property Let ColorNoFocus(ByVal New_ColorNoFocus As OLE_COLOR)
   vgColorNoFocus = New_ColorNoFocus
   If Not (vgCtShp Is Nothing) Then                      'ctl do formato já definido
      vgCtShp.FillColor() = vgColorNoFocus               'coloca cor nele
   End If
End Property

'cor do shape quando com foco - pega
Public Property Get ColorOnFocus() As OLE_COLOR
   ColorOnFocus = vgColorOnFocus
End Property

'cor do shape quando com foco - coloca
Public Property Let ColorOnFocus(ByVal New_ColorOnFocus As OLE_COLOR)
   vgColorOnFocus = New_ColorOnFocus
End Property

'controle travado (não editável) - pega
Public Property Get Locked() As Boolean
   If vgCtPri Is Nothing Then
      Locked = True
   Else
      Locked = (vgLocked Or vgCtPri.WhatsThisHelpID = -1)
   End If
End Property

'controle travado (não editável) - coloca
Public Property Let Locked(ByVal New_Locked As Boolean)
   vgLocked = New_Locked
   On Error Resume Next                                  'pode ser que o ctl não tenha esta propriedade
   If Not vgCtPri Is Nothing Then
      vgCtPri.Locked = vgLocked                          'coloca ctl editável/não editável
   End If
End Property

'valor do click do botão do scroll - pega
Public Property Get SmallChange() As Integer
   If Not (vgCtScr Is Nothing) Then                      'scroll já definido
      SmallChange = vgCtScr.SmallChange                  'pega o valor de sua propriedade
   Else
      SmallChange = 0                                    'senão, pega o default
   End If
End Property

'valor do click do botão do scroll - coloca
Public Property Let SmallChange(ByVal New_SmallChange As Integer)
   If Not (vgCtScr Is Nothing) Then                      'scroll já definido
      vgCtScr.SmallChange() = New_SmallChange            'poe novo valor na sua propriedade
   End If
End Property

'valor quando click na barra de scroll - pega
Public Property Get LargeChange() As Integer
   If Not (vgCtScr Is Nothing) Then                      'o ctl scroll já definido
      LargeChange = vgCtScr.LargeChange                  'pega o valor de sua propriedade
   Else                                                  'scroll não definido
      LargeChange = 0                                    'valor = 0
   End If
End Property

'valor do click do scroll - coloca
Public Property Let LargeChange(ByVal New_LargeChange As Integer)
   If Not (vgCtScr Is Nothing) Then                      'scroll já definido
      vgCtScr.LargeChange = New_LargeChange              'troca sua propriedade
   End If
End Property

'evento click no botao extensor
Public Sub BotClick(ByVal Index As Integer, Optional ByVal vgBaseCt As Object)
   Dim p As POINTAPI, L As Long, T As Long, i As Long, h As Long, w As Long, _
       Ct As Control, vgNVez As Integer

   On Error GoTo DeuErro
   
   vgCtPri.SetFocus                                      'coloca foco no ctl principal

   vgNVez = 0
   Do While vgFezGotFocus = False And vgNVez < 100       'se ainda nao fez o gotfocus
      DoEvents                                           'vamos esperar um pouco
      vgNVez = vgNVez + 1
   Loop
   If vgFezGotFocus = False Then                         'esperamos e ainda não fez
      vgFezGotFocus = True                               'o gotfocus
      Exit Sub                                           'cai fora
   End If

   If vgLocked Or vgCtPri.WhatsThisHelpID = -1 Then
      Exit Sub                                           'se esta travado nao faz nada
   End If

   'base do controle
   If Not vgBaseCt Is Nothing Then
      Set Ct = vgBaseCt                                  'pega o controle solicitado como base
   ElseIf vgCtFdo Is Nothing Then                        'se não tem label de fundo (efeito 3d)
      Set Ct = vgCtPri                                   'pega o próprio ctl primário
   Else                                                  'senão,
      Set Ct = vgCtFdo                                   'o label será a base
   End If
   p.x = Ct.Left / Screen.TwipsPerPixelX                 'coordenadas da base
   p.y = Ct.Top / Screen.TwipsPerPixelY                  'em relação a seu container
   If Not vgBaseCt Is Nothing Then
      ClientToScreen GetParent(Ct.hWnd), p               'coord em relação a tela
   Else
      ClientToScreen Ct.Container.hWnd, p                'coord em relação a tela
   End If

   'se for lst interna o botão irá abrir uma lst abaixo do ctl base
   If Len(vgListFields) > 0 And Index = BOT_COMBO Then
      CarregaGMCale
      If vgfrmGMCale.OqMostrar <> MOSTRA_LST_EXTERNA And vgfrmGMCale.OqMostrar <> MOSTRA_LST_INTERNA Then
         EncheRowSource
      End If
      If ComLstExt Then
         vgfrmGMCale.IniciaCale MOSTRA_LST_EXTERNA
         vgfrmGMCale.Remonta
         If vgfrmGMCale.grdListaG.AutoRebind Then vgfrmGMCale.grdListaG.ReBind
         vgfrmGMCale.grdListaG.ClearSearch               'limpa qualquer pesquisa feita através da digitação para pesquisar pelo clique
         If Len(vgfrmGMCale.CtTransfer.Text) > 0 Then vgfrmGMCale.SearchListBox Parse$(vgfrmGMCale.CtTransfer.Text, vgSubsTab$), False
         i = (vgfrmGMCale.grdListaG.RecordSet.RecordCount > 0) 'tem registro?
      Else
         vgfrmGMCale.IniciaCale MOSTRA_LST_INTERNA
         i = (vgfrmGMCale.grdListaG.ListCount > 0)             'lst interna tem itens?
      End If
      If i Then
         w = Ct.Width                                          'tamanho do ctl base será tamanho da lst
         If Ct = vgCtPri Then
            w = w + vgCtBot(Index).Width + 2 * Screen.TwipsPerPixelX
         End If
         If ComLstExt Then
            vgfrmGMCale.grdListaG.RecordSet.Populate
            h = vgfrmGMCale.grdListaG.RecordSet.RecordCount
            For i = 1 To vgfrmGMCale.grdListaG.Columns.Count
               vgfrmGMCale.grdListaG.ColumnWidth(i) = -1
            Next
            If (w < vgfrmGMCale.grdListaG.ColumnRight(vgfrmGMCale.grdListaG.GetVisibleCol(COL_LAST)) + 4 * Screen.TwipsPerPixelX) Then
               w = vgfrmGMCale.grdListaG.ColumnRight(vgfrmGMCale.grdListaG.GetVisibleCol(COL_LAST)) + 4 * Screen.TwipsPerPixelX
            Else
               w = w + 6 * Screen.TwipsPerPixelX
            End If
            If Not vgCtFdo Is Nothing Then
               On Error Resume Next
               i = vgCtFdo.Parent.Width
               If Err Then
                  i = 0
                  Err.Clear
               End If
               On Error GoTo DeuErro
               If i > 0 And vgfrmGMCale.grdListaG.ColumnRight(vgfrmGMCale.grdListaG.GetVisibleCol(COL_LAST)) > i - vgCtFdo.Left Then
                  w = i - vgCtFdo.Left
               ElseIf w < vgCtFdo.Width Then
                  w = vgCtFdo.Width
               End If
            ElseIf Not vgCtPri Is Nothing Then
               On Error Resume Next
               i = vgCtPri.Parent.Width
               If Err Then
                  i = 0
                  Err.Clear
               End If
               On Error GoTo DeuErro
               If i > 0 And vgfrmGMCale.grdListaG.ColumnRight(vgfrmGMCale.grdListaG.GetVisibleCol(COL_LAST)) > i - vgCtPri.Left Then
                  w = i - vgCtPri.Left
               ElseIf w < vgCtPri.Width Then
                  w = vgCtPri.Width
               End If
            End If
            If h > 10 Then
               w = w + GetSystemMetrics(SM_CXVSCROLL) + 17 * Screen.TwipsPerPixelX
            End If
         Else
            h = vgfrmGMCale.grdListaG.ListCount
            vgfrmGMCale.grdListaG.ColumnWidth(1) = w - 4 * Screen.TwipsPerPixelX
            If h > 10 Then
               vgfrmGMCale.grdListaG.ColumnWidth(1) = vgfrmGMCale.grdListaG.ColumnWidth(1) - (2 + GetSystemMetrics(SM_CXVSCROLL)) * Screen.TwipsPerPixelX
            End If
         End If
         h = IIf(h > 10, 10, h)
         h = (h * vgfrmGMCale.grdListaG.RowHeight) + vgfrmGMCale.grdListaG.HeaderHeightFull + Screen.TwipsPerPixelY * 4 'altura máxima da lst
         
         L = ((p.x - 3) * Screen.TwipsPerPixelX)   'coordenadas onde a lst será aberta
         T = (p.y * Screen.TwipsPerPixelY) + Ct.Height + (3 * Screen.TwipsPerPixelY)
         If T + h > Screen.Height Then             'se lst nao cabe na tela abre para cima
            T = (p.y * Screen.TwipsPerPixelY) - h - Screen.TwipsPerPixelY
         End If

         'largura máxima, teórica
         If (w > Screen.Width) Then w = Screen.Width
         
         If L + w > Screen.Width Then              'se não cabe na tela, vamos decidir se alinharemos à esquerda ou à direita
            If (L + vgCtPri.Width) > Screen.Width - 120 - L Then
               w = L + vgCtPri.Width
               L = 120
               w = w + vgCtBot(Index).Width + 2 * Screen.TwipsPerPixelX
            Else
               w = Screen.Width - L - 120
            End If
            'L = Screen.Width - w                          'será alinhado no lado direito da tela
         End If
         If L < 120 Then                           'se iniciando antes da borda esquerda da tela
            w = w - (120 - L)                      'reajusta largura
            L = 120                                'ajusta para começar na borda esquerda
         End If

         'se tem barra de scroll horizontal...
         If w < vgfrmGMCale.grdListaG.ColumnRight(vgfrmGMCale.grdListaG.GetVisibleCol(COL_LAST)) Then
            h = h + GetSystemMetrics(SM_CYHSCROLL) * Screen.TwipsPerPixelX 'vamos aumentar um pouco a altura da lista (exatamente a altura da barra)
         End If
         vgfrmGMCale.Move L, T, w, h                                       'coloca lst na posição
         DoEvents                                 'deixa o windows trabalhar
         vgfrmGMCale.grdListaG.ShowFilterBar = False 'não mostrar a barra de filtro
         ChamaForm vgfrmGMCale                       'mostra a lst
         GotFocus                                    'dispara evento GotFocus
      End If
   ElseIf Len(vgPesqSQLExpression) > 0 And Index = BOT_LISTA Then
      If vgPesqModoAbertura = PESQ_MODO_COMBO Then
         CarregaGMCale
         With vgfrmGMCale
            .IniciaCale MOSTRA_LST_PESQUISA
            .Remonta
            w = vgfrmGMCale.grdListaG.ColumnRight(vgfrmGMCale.grdListaG.GetVisibleCol(COL_LAST)) + 4 * Screen.TwipsPerPixelX
            If Not vgCtFdo Is Nothing Then
               On Error Resume Next
               i = vgCtFdo.Parent.Width
               If Err Then
                  i = 0
                  Err.Clear
               End If
               On Error GoTo DeuErro
               If i > 0 And vgfrmGMCale.grdListaG.ColumnRight(vgfrmGMCale.grdListaG.GetVisibleCol(COL_LAST)) > i - vgCtFdo.Left Then
                  w = i - vgCtFdo.Left
               ElseIf w < vgCtFdo.Width Then
                  w = vgCtFdo.Width
               End If
            ElseIf Not vgCtPri Is Nothing Then
               On Error Resume Next
               i = vgCtPri.Parent.Width
               If Err Then
                  i = 0
                  Err.Clear
               End If
               On Error GoTo DeuErro
               If i > 0 And vgfrmGMCale.grdListaG.ColumnRight(vgfrmGMCale.grdListaG.GetVisibleCol(COL_LAST)) > i - vgCtPri.Left Then
                  w = i - vgCtPri.Left
               ElseIf w < vgCtPri.Width Then
                  w = vgCtPri.Width
               End If
            End If
            w = w + 3 * Screen.TwipsPerPixelX
            vgfrmGMCale.grdListaG.RecordSet.Populate
            h = vgfrmGMCale.grdListaG.RecordSet.RecordCount + 1 'coloca + 1 para calcular altura da linha de filtragem
            h = IIf(h > 8, 8, h)
            h = (h * vgfrmGMCale.grdListaG.RowHeight) + (30 * Screen.TwipsPerPixelY) + vgfrmGMCale.grdListaG.HeaderHeight 'altura maxima da lst
            L = (p.x * Screen.TwipsPerPixelX)     'coordenadas a onde a lst sera aberta
            T = (p.y * Screen.TwipsPerPixelY) + Ct.Height + Screen.TwipsPerPixelY
            If T + h > Screen.Height Then         'se lst nao cabe na tela abre para cima
               T = (p.y * Screen.TwipsPerPixelY) - h - Screen.TwipsPerPixelY
            End If
            If L + w > Screen.Width Then          'se não cabe na tela
               L = Screen.Width - w               'será alinhado no lado direito da tela
            ElseIf L < 0 Then                     'se iniciando antes da borda esquerda da tela
               L = 0                              'ajusta para começar na borda esquerda
            End If
            vgfrmGMCale.Move L, T, w, h           'coloca lst na posição
            DoEvents
            vgfrmGMCale.grdListaG.ShowFilterBar = True 'exibir a barra de filtro
            ChamaForm vgfrmGMCale
            GotFocus
            DoEvents                                   'permite terminar de construir o grid para foco na barra de filtro
            vgfrmGMCale.grdListaG.SetFocusFilter       'coloca o foco na barra de filtro do grid
         End With
      ElseIf vgPesqModoAbertura = PESQ_MODO_JANELA Then 'abre pesquisa em modo Janela
         vgNovaQuery$ = vgPesqSQLExpression$            'armazena a consulta SQL que vai ser executada
         If vgfrmPesquisa Is Nothing Then
            Set vgfrmPesquisa = New frmBrowse
            Set vgfrmPesquisa.CtTransfer = Me           'ctl que chamou a pesquisa
            vgfrmPesquisa.grdBrowse.TrackSelect = False 'desabilita a rolagem automática do mouse
            vgfrmPesquisa.grdBrowse.ShowFilterBar = True 'abre exibindo a barra de filtro
            vgfrmPesquisa.grdBrowse.FullRowSelect = (Len(vgPesqFieldCapture) > 0) 'se tem campo a capturar definido, seleção pega toda a linha
            vgfrmPesquisa.grdBrowse.AllowDelete = False
            vgfrmPesquisa.grdBrowse.AllowEdit = False
            vgfrmPesquisa.grdBrowse.AllowInsert = False
            Load vgfrmPesquisa
         Else
            If vgfrmPesquisa.grdBrowse.RecordSet.Source <> vgNovaQuery$ Then vgfrmPesquisa.grdBrowse.ClearFilterBar 'limpa os campos da barra de filtro
            vgfrmPesquisa.grdBrowse.ClearColumns
            vgfrmPesquisa.grdBrowse.OpenRecordSet vgNovaQuery$, CURSOR_DYNAMIC, True, , , , , , True
            DoEvents
         End If
         vgfrmPesquisa.grdBrowse.Caption = LoadGasString(1640) & vgPesqFieldCapture                                 'coloca o título "PESQUISA" no grid com o campo a capturar
         vgfrmPesquisa.grdBrowse.ShowFilterBar = True   'exibir a barra de filtro
         vgfrmPesquisa.Show                             'exibe a pesquisa
         DoEvents                                       'vamos aguardar um pouco para o formulário se estabilizar e
         vgfrmPesquisa.grdBrowse.SetFocusFilter         'força o foco na barra de filtro
      End If
      
   'campo data abre calendário
   ElseIf vgDataType = [Date ] And Index = BOT_ACAO Then
      CarregaGMCale
      With vgfrmGMCale
         .Width = 1720                                  'largura e altura do calendário
         .Height = 1545
         L = ((p.x * Screen.TwipsPerPixelX) + Ct.Width) - vgfrmGMCale.Width - 15
         If L < 0 Then L = 0                            'coordenadas do calendário
         T = (p.y * Screen.TwipsPerPixelY) + Ct.Height + 15
         If T + vgfrmGMCale.Height > Screen.Height Then
            T = (p.y * Screen.TwipsPerPixelY) - vgfrmGMCale.Width - 15
         End If
         .Left = L                                      'posiciona o calendário
         .Top = T
         .IniciaCale MOSTRA_CALE                        'monta calendário
         ChamaForm vgfrmGMCale                          'e mostra
         DoEvents                                       'deixa o windows trabalhar
         GotFocus                                       'dispara evento GotFocus
      End With

   'campo numéro abre calculadora
   ElseIf (vgDataType = Numeric Or vgDataType = Spinner) And Index = BOT_ACAO Then
      Load frmGMCalc                                    'carrega calculadora na memória
      vgfrmCalcNaMem = True                             'flag, calculadora na memória
      With frmGMCalc                                    'coloca no tag do form da calc algumas
         .Tag = Text + "|"                              'informações como: Valor inicial
         If vgQcDec = 0 Then                            'e máscara do campo
            .Tag = .Tag + String$(vgQcInt, "#")
         Else
            .Tag = .Tag + String$(vgQcInt - 1, "#") + "0." + String$(vgQcDec, "0")
         End If
         .IniciaCalc                                    'prepara a calculadora
         L = ((p.x * Screen.TwipsPerPixelX) + Ct.Width) - frmGMCalc.Width - 15
         If L < 0 Then L = 0
         T = (p.y * Screen.TwipsPerPixelY) + Ct.Height + 15
         If T + frmGMCalc.Height > Screen.Height Then   'se não cabe embaixo coloca em cima
            T = (p.y * Screen.TwipsPerPixelY) - frmGMCalc.Width - 15
         End If
         .Left = L                                      'posiciona calculadora
         .Top = T
      End With
      ChamaForm frmGMCalc                               'mostra calculadora
      DoEvents                                          'deixa o windows trabalhar
      GotFocus                                          'dispara evento GotFocus
   End If
   Exit Sub
   
DeuErro:

End Sub

'evento click no scroll
Public Sub ScrChange()
   If vgLocked Or vgCtPri.WhatsThisHelpID = -1 Then
      Exit Sub                                             'se esta travado nao faz nada
   End If
   On Error Resume Next                                    'previne erros
   Text = Trim(Str(vgCtScr.Value))                         'coloca no campo valor do scroll
   If Not vgPriVez Then vgCtPri.SetFocus                   'coloca foco no clt primário
End Sub

'cor do texto - pega
Public Property Get ForeColor() As OLE_COLOR
   ForeColor = vgCtPri.ForeColor
End Property

'cor do texto - coloca
Public Property Let ForeColor(ByVal New_ForeColor As OLE_COLOR)
   vgCtPri.ForeColor() = New_ForeColor
End Property

'cor do título do campo - pega
Public Property Get CaptionColor() As OLE_COLOR
   If vgCtTit Is Nothing Then                            'se label do título não existe
      CaptionColor = 0                                   'retorna preto como default
   Else
      CaptionColor = vgCtTit.ForeColor                   'coloca cor do título
   End If
End Property

'cor do título do campo - coloca
Public Property Let CaptionColor(ByVal New_CaptionColor As OLE_COLOR)
   If Not (vgCtTit Is Nothing) Then                      'se título já existe
      vgCtTit.ForeColor() = New_CaptionColor             'coloca a cor no label do título
   End If
End Property

'Fonte do ctl principal - pega
Public Property Get Font() As Font
   Set Font = vgCtPri.Font
End Property

'Fonte do ctl principal - coloca
Public Property Set Font(ByVal New_Font As Font)
   Set vgCtPri.Font = New_Font
End Property

'Fonte do título - pega
Public Property Get CaptionFont() As Font
   If Not (vgCtTit Is Nothing) Then                      'ctl do título já foi definido
      Set CaptionFont = vgCtTit.Font                     'pega a sua fonte
   Else                                                  'senão,
      Set CaptionFont = vgCtPri.Font                     'pega fonte do ctl principal como default
   End If
End Property

'Fonte do título - Coloca
Public Property Set CaptionFont(ByVal New_CaptionFont As Font)
   If Not (vgCtTit Is Nothing) Then                      'ctl do título já foi definido
      Set vgCtTit.Font = New_CaptionFont                 'coloca a fonte nele
   End If
End Property

'verifica se o evento já foi disparado
Public Property Get PriVez() As Boolean
   PriVez = vgPriVez
End Property

'evento disparado quando o ctl principal muda o seu valor
Public Function Change() As Boolean
   Dim RetVal As Boolean, vgVl As Variant
   RetVal = False                                        'evento chegou ate o fim?
   If Not vgPriVez Then                                  'se não foi disparado de outro evento
      If vgDataType <> [Option ] And vgDataType <> [Boolean] Then
         If vgDataType = Spinner Then                    'cp rotativo coloca o valor no scroll
            On Error Resume Next                         'previne estouro no controle scroll
            vgCtScr.Value = ValBrasil(Text)
            If Err Then                                  'epa! Valor acima do permitido pelo scroll
               If Val(Text) > vgCtScr.Max Then           'vamos colocar o valor máximo
                  Text = LTrim(Str(vgCtScr.Value))       'do scroll no ctl principal
               End If
            End If
         ElseIf Len(vgListFields) > 0 And vgAllowAnyText And Not ComLstExt And Len(Value) > 0 Then 'se for lst tenta achar na lst a tecla digitada
            vgPriVez = True
            vgListBoxSearch$ = vgfrmGMCale.SearchListBox(Value, False)
            vgPriVez = False
         End If
         vgVl = Value                             'valor atual
      End If
      RetVal = True                               'evento chegou até o final...
      'INICIO MANUAL
      If cmdCapitaliza.Value And ((vgDataType = Character And vgMask = "@x") Or (vgDataType = Memo And vgMask = "")) Then
         If Vazio(cmdCapitaliza.Tag) Then cmdCapitaliza.Tag = vgCtPri.SelStart: vgCtPri.Text = Capitaliza(vgCtPri.Text)
         If Not Vazio(cmdCapitaliza.Tag) Then vgCtPri.SelStart = cmdCapitaliza.Tag: cmdCapitaliza.Tag = ""
      End If
      'FIM MANUAL
   End If
   Change = RetVal                                'retorna situação do evento
End Function

'evento disparado quando o foco sai do ctl principal
Public Sub LostFocus()
   Dim x As String, Ok As Boolean                 'define variáveis locais
   On Error Resume Next                           'previne erros...
   If FlagFocus = False Then
      vgListaAberta = False
   End If
   FlagFocus = False

   If TypeOf vgCtPri.Parent Is GListV Then
      Ok = True
   Else
      Ok = (vgCtPri.Parent.vgSituacao <> ACAO_NAVEGANDO Or vgCtPri.Parent.vgTipo <> TP_TABELA)
   End If


   'se o campo não for lógico/Optativo e flag de formatar campo após perder
   'o foco estiver ligada então vamos fazer...
   If vgDataType <> [Boolean] And vgDataType <> [Option ] And _
      vgDataType <> 99 And vgFormatLostFocus And Ok Then

      vgPriVez = True                             'evita recursividade de eventos
      x$ = FormatText(Text)                       'formata cp segundo a sua máscara
      vgPriVez = False
      If Err Then                                 'Epa! um erro aconteceu...
         Err.Clear                                'limpa o erro da memória
         Class_Terminate                          'e termina esta classe
         Exit Sub                                 'sai deste evento
      End If
      If x$ <> Text Then                          'cp formatado diferente do atual
         Text = x$                                'coloca cp formatado no ctl principal
      End If
      vgPriVez = True                             'evita recursividade
      Text = Text                                 'reformata o texto no ctl principal
      vgPriVez = False
   End If
   If Not (vgCtShp Is Nothing) Then               'tem formato ao redor do título
      vgCtShp.FillColor = vgColorNoFocus          'troca a sua cor e
      vgCtShp.FillStyle = vgFillStyleNoFocus      'estilo quando não tem foco
   End If
   vgFezGotFocus = False                          'reseta flag
End Sub

'evento KeyDown
Public Sub KeyDown(KeyCode As Integer, Shift As Integer)
   Dim i As Integer, vgFezF4 As Boolean
   If KeyCode <> 0 And Not vgCtPri Is Nothing Then                                  'alguma tecla foi digitada
      If vgLocked Or vgCtPri.WhatsThisHelpID = -1 Then
         If KeyCode <> vbKeyLeft And KeyCode <> vbKeyRight And _
            KeyCode <> vbKeyUp And KeyCode <> vbKeyDown And _
            KeyCode <> vbKeyPageDown And KeyCode <> vbKeyPageUp And _
            KeyCode <> vbKeyEnd And KeyCode <> vbKeyHome Then
            KeyCode = 0
         End If
         Exit Sub
      End If

      'campo é uma lista (interna ou extena)
      i = (vgDataType <> [Boolean] And vgDataType <> [Option ])
      If i Then
         i = (Len(vgListFields) > 0 And vgCtPri.Enabled = True)
      End If
      If i Then                                   'Se o campo for lst
         If KeyCode <> vbKeyEscape And KeyCode <> vbKeyReturn And KeyCode <> vbKeyF4 Then
            CarregaGMCale
            If vgfrmGMCale.OqMostrar <> MOSTRA_LST_INTERNA And vgfrmGMCale.OqMostrar <> MOSTRA_LST_EXTERNA Then EncheRowSource
            If ComLstExt Then                     'se lista externa
               If vgValueAtual = Empty Then       'se combo ainda não preenchida
                  vgfrmGMCale.SelecionaItem ""    'posiciona no item -1
               Else                               'se combo já preenchida
                  vgfrmGMCale.SelecionaItem vgValueAtual 'seleciona o item correspondente ao valor atual da combo
               End If
            Else                                         'se lista interna
               vgfrmGMCale.SelecionaItem Text            'seleciona o item correspondente ao texto da campo
            End If
         End If
         If KeyCode = vbKeyDown Then                     'seta para baixo
            vgFezF4 = False                              'reseta flag F4
            vgListBoxSearch$ = ""                        'limpa pesquisa por palavra
            vgfrmGMCale.grdListaG.HideSelect = False
            If vgfrmGMCale.grdListaG.SelectedItem < vgfrmGMCale.grdListaG.ListCount - 1 Then
               vgfrmGMCale.grdListaG.SelecionaItem vgfrmGMCale.grdListaG.SelectedItem + 1
               vgfrmGMCale.PegaSelecao True
               Change
            End If
         ElseIf KeyCode = vbKeyUp Then                   'seta para cima
            vgListBoxSearch$ = ""                        'limpa pesquisa por palavra
            vgfrmGMCale.grdListaG.HideSelect = False
            If vgfrmGMCale.grdListaG.SelectedItem > 0 Then
               vgfrmGMCale.grdListaG.SelecionaItem vgfrmGMCale.grdListaG.SelectedItem - 1
               vgfrmGMCale.PegaSelecao True
               Change
            End If
         ElseIf KeyCode <= vbKeyHelp And KeyCode <> vbKeySpace And KeyCode <> vbKeyShift And KeyCode <> vbKeyEscape Then
            vgListBoxSearch$ = ""                        'limpa pesquisa por palavra
            vgfrmGMCale.grdListaG.HideSelect = False
            If Not vgAllowAnyText And (KeyCode = vbKeyDelete Or KeyCode = vbKeyBack) Then 'limpa lista
               vgfrmGMCale.grdListaG.SelecionaItem -1                                     'desmarca lista
               If KeyCode = vbKeyDelete Then                                              'vamos limpar o cache da última procura...
                  vgfrmGMCale.grdListaG.ClearSearch
               End If
               Text = ""                          'limpa ctl principal
            End If
         ElseIf KeyCode = vbKeyF4 Then            'trata atalho F4
            vgFezF4 = True                        'para abrir combo
         ElseIf KeyCode = vbKeyF5 Then
            vgfrmGMCale.grdListaG.ReBind
         ElseIf KeyCode = vbKeyC And Shift = vbCtrlMask Then 'CTRL+C
            KeyCode = TrataTecla(3, KeyCode)
         ElseIf KeyCode = vbKeyV And Shift = vbCtrlMask Then 'CTRL+V
            KeyCode = TrataTecla(22, KeyCode)
         End If

         'so aceita estas teclas de controle
         If KeyCode <> vbKeyReturn And KeyCode <> vbKeyLeft And KeyCode <> vbKeyRight And _
            KeyCode <> vbKeyEnd And KeyCode <> vbKeyHome And Shift <> 4 And Not vgAllowAnyText Then
            KeyCode = 0
         End If
      Else
         If KeyCode = vbKeyF4 Then                           'trata f4 com outros cps com extensor
            If Not vgCtBot(BOT_COMBO) Is Nothing Then        'se tem extensor
               vgFezF4 = True                                'vamos abrir
            End If
         ElseIf KeyCode = vbKeyDelete Then                   'se pressionou DEL
            KeyCode = TrataTecla(TECLA_DEL, KeyCode)         'trata esta tecla...
         ElseIf KeyCode = vbKeyUp Then                       'seta cima,
            KeyCode = TrataTecla(-2, KeyCode)                'vamos tratar adiante
         ElseIf KeyCode = vbKeyDown Then                     'seta para baixo
            KeyCode = TrataTecla(-1, KeyCode)                'vamos tratar..
         ElseIf KeyCode = vbKeyTab And Shift = vbCtrlMask Then 'seta para baixo
            KeyCode = 0                                        'CTRL-TAB nao pode
         End If
      End If
      If vgFezF4 And Not vgCtBot(BOT_COMBO) Is Nothing Then    'se f4,
         vgCtBot(BOT_COMBO).Value = True                       'força clique no extensor
      End If
   End If
End Sub

'evento GotFocus
Public Sub GotFocus()
   vgListBoxSearch$ = ""                                 'começa pesquisa de palavra
   If Len(vgListFields) > 0 Then
      CarregaGMCale
      vgfrmGMCale.grdListaG.HideSelect = False
   End If
   If Not (vgCtShp Is Nothing) Then                      'tem formato em volta do título
      vgCtShp.FillColor = vgColorOnFocus                 'coloca o cor e o tipo do shape
      vgCtShp.FillStyle = vgFillStyleOnFocus             'quando com foco
   End If

   'se não for campo memo, optativo e lógico e quer selecionar o campo
   If vgDataType <> Memo And vgDataType <> [Boolean] And vgDataType <> [Option ] And _
      vgDataType <> 99 And vgSelectOnFocus Then
      SelStart = 0                                       'cursor na posição 0
      SelLength = Len(Text)                              'seleciona todo o texto do ctl
   End If
   On Error Resume Next                                  'prepara para possivel erro...
   If mdiNFE.ActiveForm.vgCaracteristica = F_DADOS Then  'não é form de dados
      If Err Then
         Err.Clear
      Else                                               'se não esta incluindo e não pode alterar
         If vgCtPri.Parent.vgCaracteristica = F_DADOS Then
            If Err Then
               Err.Clear
            Else
               If mdiNFE.ActiveForm.vgSituacao = ACAO_NAVEGANDO And mdiNFE.ActiveForm.vgTemAlteracao = False Then
                  If vgCtPri.Tag <> "BRW" Then
                     vgCtPri.Locked = True               'bloqueia o campo
                  End If
               Else                                      'se não
                  vgCtPri.Locked = Locked                'deixa como esta
               End If
            End If
         End If
      End If
   End If
   mdiNFE.ActiveControl.TiraFoco                         'mas vamos tentar colocar
   vgFezGotFocus = True                                  'flag o evento chegou ao fim
End Sub

'evento KeyPress
Public Sub KeyPress(KeyAscii As Integer)
   Dim vgNewSearch As String, Ind As Integer
   On Error GoTo DeuErro
   If KeyAscii <> 0 Then                                 'digitou algo...
      If vgLocked Or vgCtPri.WhatsThisHelpID = -1 Then
         KeyAscii = 0
         Exit Sub
      End If
      If Len(vgListFields) > 0 Then                      'se for lst tenta achar na lst a tecla digitada
         If KeyAscii <> vbKeyBack And KeyAscii <> vbKeyReturn And _
            KeyAscii <> vbKeyTab Then
            CarregaGMCale
            If vgfrmGMCale.OqMostrar <> MOSTRA_LST_INTERNA And vgfrmGMCale.OqMostrar <> MOSTRA_LST_EXTERNA Then
               EncheRowSource
            End If
            If vgAllowAnyText Then
               If SelStart <> 0 Or SelLength <> Len(vgListBoxSearch$) Or UCase$(Left(Text, Len(vgListBoxSearch$))) <> UCase$(vgListBoxSearch$) Then
                  Exit Sub
               End If
            End If
            vgNewSearch$ = vgListBoxSearch$ + Chr$(KeyAscii)
            If ComLstExt Then
               If vgfrmGMCale.grdListaG.AutoRebind And Len(vgNewSearch$) = 1 Then vgfrmGMCale.grdListaG.ReBind
            End If
            vgListBoxSearch$ = vgfrmGMCale.SearchListBox(vgNewSearch$, False) 'procura na lst
            If vgAllowAnyText Then
               If vgNewSearch$ <> vgListBoxSearch$ Then
                  Ind = SelStart + SelLength + 1
                  Value = Empty
                  Text = vgNewSearch
                  vgListBoxSearch$ = ""
                  SelStart = Ind
               End If
            End If
         End If
         If KeyAscii = vbKeyReturn Then                                       'teclou Enter
            SendK vbKeyTab                        'substitui por TAB
         End If
         If KeyAscii <> vbKeyBack Or Not vgAllowAnyText Then
            KeyAscii = 0                          'estas teclas não fazem nada
         End If
      Else
         KeyAscii = TrataTecla(KeyAscii, KeyAscii) 'formata tecla digitada conforme a máscara
      End If
   End If
   Exit Sub
   
DeuErro:
   KeyAscii = 0
End Sub

'evento MoudeDown
Public Sub MouseDown()
   vgListBoxSearch$ = ""                                'recomeça pesquisa de palavras
   If Len(vgListFields) Then
      CarregaGMCale
      vgfrmGMCale.grdListaG.HideSelect = False
   End If
End Sub

'mostra form de lst/calendário ou calculadora
Private Sub ChamaForm(F As Form)
   On Error Resume Next                                  'previne erros...
   FlagFocus = True                                      'flag para identificar o LostFocus quando estiver abrindo a lista
   vgListaAberta = True                                  'flag para identificar que a combo está aberta
   Set F.CtTransfer = Me                                 'classe atual
   F.Enabled = True                                      'habilita o form que iremos mostrar
   F.Show                                                'mostra o form
   If Err Then                                           'erro - o form deve ser modal
      F.Show vbModal                                     'vamos abrir também este de forma modal
   End If
End Sub

'flag se o texto será selecionado quando pegar foco - pega
Public Property Get SelectOnFocus() As Boolean
   SelectOnFocus = vgSelectOnFocus
End Property

'flag se o texto será selecionado quando pegar foco - coloca
Public Property Let SelectOnFocus(ByVal New_SelectOnFocus As Boolean)
   vgSelectOnFocus = New_SelectOnFocus
End Property

'valor mínimo do scroll - pega
Public Property Get Min() As Integer
   If Not (vgCtScr Is Nothing) Then                      'scroll já definido
      Min = vgCtScr.Min                                  'pega o seu valor
   Else                                                  'caso contrário
      Min = 0                                            'pega o default
   End If
End Property

'valor mínimo do scroll - coloca
Public Property Let Min(ByVal New_Min As Integer)
   If Not (vgCtScr Is Nothing) Then                      'scroll já definido
      On Error Resume Next
      vgCtScr.Min() = New_Min                            'atribui para a sua propriedade
   End If
End Property

'tamanho máximo de caracters no texto - pega
Public Property Get MaxLength() As Long
   On Error Resume Next
   If Not vgCtPri Is Nothing Then
      MaxLength = vgCtPri.MaxLength
   End If
End Property

'tamanho máximo de caracters no texto - coloca
Public Property Let MaxLength(ByVal New_MaxLength As Long)
   If vgDataType <> Memo And vgDataType <> [Boolean] And Not vgCtPri Is Nothing Then                             'campo memo não...
      vgCtPri.MaxLength() = New_MaxLength
   ElseIf vgDataType = Memo Then
      vgCtPri.MaxLength() = 0
   End If
End Property

'valor máximo para o scroll - pega
Public Property Get Max() As Integer
   If Not (vgCtScr Is Nothing) Then                      'scroll já definido
      Max = vgCtScr.Max                                  'pega o valor de sua propriedade
   Else
      Max = 32767                                        'senão, pega o default (32767)
   End If
End Property

'valor máximo para o scroll - coloca
Public Property Let Max(ByVal New_Max As Integer)
   If Not (vgCtScr Is Nothing) Then                      'scroll já definido
      On Error Resume Next
      vgCtScr.Max() = New_Max                            'coloca o valor na sua propriedade
   End If
End Property

'Método Refresh
Public Sub Refresh()
   If Len(vgListFields) Then
      CarregaGMCale
      vgfrmGMCale.Remonta                                 'tenta echer pegar o RS da lista
   End If
End Sub

'Método adiciona item na lst interna
Public Sub AddItem(ByVal New_Item As String)
   If Len(vgRowSource) = 0 Then                          'se não for lst externa
      If Len(vgListFields) > 0 Then                      'se já tem algum item na lst
         vgListFields = vgListFields + "|"               'coloca o separador de itens
      End If
      vgListFields = vgListFields + New_Item             'coloca o novo item
      CarregaGMCale
      vgfrmGMCale.grdListaG.AddItem New_Item
   End If
End Sub

'Método para limpar todos os itens da lst
Public Sub Clear()
   If Len(vgRowSource) = 0 Then                         'se não for lst externa
      If Len(vgListFields) > 0 Then                     'se tem itens
         vgListFields = ""                              'tira
         CarregaGMCale
         vgfrmGMCale.grdListaG.ClearItems
      End If
      Text = ""                                         'limpa o ctl principal
   End If
End Sub

'Método para remover um item da lista
Public Sub RemoveItem(ByVal New_Index As Integer)
   Dim i As Integer                                     'dimensiona variáveis
   If Len(vgRowSource) = 0 Then                         'se não for lst externa
      CarregaGMCale
      vgfrmGMCale.grdListaG.RemoveItem New_Index        'remove o itens da lst
      If vgfrmGMCale.grdListaG.SelectedItem = -1 Then   'se lst não selecionada
         Text = ""                                      'limpa contole principal
      End If
      vgListFields = ""                                 'remonta variável da lst de itens
      For i = 0 To vgfrmGMCale.grdListaG.ListCount - 1
         If Len(vgListFields) > 0 Then                  'já tem um iten na lst
            vgListFields = vgListFields + "|"           'coloca um separador entre eles
         End If
         vgListFields = vgListFields + vgfrmGMCale.grdListaG.List(i)
      Next
   End If
End Sub

'Item selecionado - pega
Public Property Get ListIndex() As Integer
   If Len(vgListFields) > 0 Then
      CarregaGMCale
      ListIndex = vgfrmGMCale.grdListaG.SelectedItem
   End If
End Property

'Item selecionado - coloca
Public Property Let ListIndex(ByVal New_ListIndex As Integer)
   If Len(vgListFields) > 0 Then
      CarregaGMCale
      If vgfrmGMCale.OqMostrar = MOSTRA_NAO Then           'se ainda não encheu a lst
         EncheRowSource                                    'vamos fazer agora...
      End If
      vgfrmGMCale.grdListaG.SelecionaItem New_ListIndex
   End If
End Property

'quantidade de itens da lst - pega
Public Property Get ListCount() As Integer
   If Len(vgListFields) > 0 Then
      CarregaGMCale
      ListCount = vgfrmGMCale.grdListaG.ListCount
   End If
End Property

'variável de usuário - pega
Public Property Get Tag() As String
   Tag = vgTag
End Property

'variável de usuário - coloca
Public Property Let Tag(ByVal New_Tag As String)
   vgTag = New_Tag
End Property

'texto selecionado no ctl principal - pega
Public Property Get SelText() As String
   If Not vgCtPri Is Nothing Then
      SelText = vgCtPri.SelText
   End If
End Property

'texto selecionado no ctl principal - coloca
Public Property Let SelText(ByVal New_SelText As String)
   If Not vgCtPri Is Nothing Then
      vgCtPri.SelText() = New_SelText
   End If
End Property

'Posição do cursor no ctl principal - pega
Public Property Get SelStart() As Long
   If Not vgCtPri Is Nothing Then
      If TypeOf vgCtPri Is TextBox Then
         SelStart = vgCtPri.SelStart
      End If
   End If
End Property

'Posiçao do cursor no ctl principal - coloca
Public Property Let SelStart(ByVal New_SelStart As Long)
   If Not vgCtPri Is Nothing Then
      If TypeOf vgCtPri Is TextBox Then
         vgCtPri.SelStart() = New_SelStart
      End If
   End If
End Property

'quantidade de caractere para seleção - pega
Public Property Get SelLength() As Long
   If Not vgCtPri Is Nothing Then
      If TypeOf vgCtPri Is TextBox Then
         SelLength = vgCtPri.SelLength
      End If
   End If
End Property

'quantidade de caractere para seleção - coloca
Public Property Let SelLength(ByVal New_SelLength As Long)
   If Not vgCtPri Is Nothing Then
      If TypeOf vgCtPri Is TextBox Then
         vgCtPri.SelLength() = New_SelLength
      End If
   End If
End Property

'texto do ctl principal - pega
Public Property Get Text() As String
   If Not vgCtPri Is Nothing Then
      'campo lógico ou optativo não tem textbox
      If vgDataType = [Option ] Then
         Text = vgCtPri.Caption                                'pega o caption do ctl principal
      Else
         Text = vgCtPri.Text                                   'outros tipos de campos pega da textbox (ctl principal)
      End If
   Else
      Text = vgText
   End If
End Property

'texto do ctl principal - coloca
Public Property Let Text(ByVal New_Text As String)
   Dim x As String
   If New_Text = "" Then                                  'texto é tudo branco
      x$ = ""
   Else                                           'senão,
      x$ = FormatText(New_Text)                   'formata segundo sua máscara
   End If

   'nos campos lógicos ou optativos...
   If Not vgCtPri Is Nothing Then
      If vgDataType = [Option ] Then
         vgCtPri.Caption = x$                     'usa a propriedade caption
      Else
         If Len(x$) = 0 Then                      'se for lst externa
            vgValueAtual = Empty                  'tira valor
         End If
         vgCtPri.Text = x$                        'senão, usa a propriedade texto
      End If
   Else
      If vgDataType <> [Option ] Then
         If Len(x$) = 0 Then                      'se for lst externa
            vgValueAtual = Empty                  'tira valor
         End If
      End If
      vgText = x$
   End If
End Property

'valor do controle - pega
Public Property Get Value() As Variant

   'lst externa
   If ComLstExt Then
      If IsEmpty(vgValueAtual) Then                        'se não tem item selecionado
         Select Case vgDataType                            'de acordo com o seu tipo vamos
            Case Character, Memo                           'retornar o seu valor
               Value = ""                                  'caractere ou memo: em branco
            Case Numeric, Spinner, [Option ]
               Value = 0                                   'numérico, rotativo ou optativo: 0
            Case [Boolean]
               Value = False                               'lógico: falso
            Case [Date ]
               Value = Null                                'data: nulo
         End Select
      Else                                                 'tem item selecionado
         Value = vgValueAtual                              'pega o valor do campo de retorno (BoundColumn)
      End If
   Else                                           'não é lst externa
      Select Case vgDataType
         Case Character, Memo                     'caractere ou memo
            Value = Text                          'retorna o que esta no ctl principal
         Case Numeric, Spinner                    'numérico ou rotativo
            If Len(vgListFields) > 0 And vgDataType = Numeric Then 'lst interna
               CarregaGMCale
               Value = vgfrmGMCale.grdListaG.SelectedItem          'retorna número do item selecionado
            Else                                  'caso contrário
               Value = CtoN(Text)                 'transforma o texto do ctl principal em número
            End If
         Case [Boolean]                           'lógico
            Value = vgCtPri.Value                 'o valor que está checado
         Case [Option ]                           'optativo
            Value = vgCtPri.Value                 'o valor que está marcado
         Case [Date ]                             'data
            If Len(Text) = 0 Or IsDate(Text) = False Then
               Value = Null                       'data inválido ou em branco
            Else

               'se a data digitada no texto pode ser transformada para data
               'vamos retorná-la, senão, retorna nula (data em branco)
               If IsDate(Format$(Text, TrataMaskData$(vgMask))) Then
                  Value = CDate(Format$(Text, TrataMaskData$(vgMask)))
               Else
                  Value = Null
               End If
            End If
      End Select
   End If
End Property

'valor original do campo - pega
Public Property Get OriginalValue() As Variant
   OriginalValue = vgValorOriginal
End Property

'se pode setar valor original do campo - pega
Public Property Get SetOriginalValue() As Boolean
   SetOriginalValue = vgSetValorOriginal
End Property

'se pode setar valor original do campo - coloca
Public Property Let SetOriginalValue(ByVal NewValue As Boolean)
   vgSetValorOriginal = NewValue
End Property

'valor do controle - coloca
Public Property Let Value(ByVal New_Value As Variant)
   Dim x As String, i As Integer, vgPV As Boolean, NewText As String          'cria variávies na memória
   vgPV = vgPriVez                                'situação atual que evita recursividade
   If vgSetValorOriginal Then                     'só se estiver setando valor original (pois em caso de selecionar item em uma lista, o change deverá ser disparado e mudar a situacao do form para edição)
      vgPriVez = True                             'força flag para não ter recursividade
   End If
   On Error GoTo DeuErro
   If ComLstExt Then                              'é lst externa
      vgValueAtual = New_Value                    'valor do campo de retorno (BoundColumn)
      If vgSetValorOriginal And Len(vgRelation) > 0 Then
         NewText = ""
         For i = 1 To Tally(Substitui$(vgListFields, "; ", "|", SO_UM) + "|", "|")
            x$ = Parse$(Substitui$(vgListFields, "; ", "|", SO_UM) + "|", "|", i)
            If Len(NewText) > 0 Then NewText = NewText + "   "
            NewText = NewText + CStr(vgCtPri.Parent.vgTb.Field(vgDb(1).GetFieldNameShort(vgSource + "_" + x$)).Value & "")
         Next
      Else
         CarregaGMCale
         If vgfrmGMCale.OqMostrar <> MOSTRA_LST_EXTERNA And vgfrmGMCale.OqMostrar <> MOSTRA_LST_INTERNA Then
            EncheRowSource
         End If
         vgfrmGMCale.IniciaCale MOSTRA_LST_EXTERNA
         NewText = vgfrmGMCale.SelecionaItem(vgValueAtual, vgSetValorOriginal) 'seleciona na lst
      End If
      Text = NewText
   ElseIf vgDataType = Spinner Then                                            'campo rotativo
      If Not (vgCtScr Is Nothing) Then                                         'tem scroll associado
         vgCtScr.Value() = Val(CStr(New_Value))                                'coloca o valor no scroll
         Text = vgCtScr.Value                                                  'coloca o valor no controle
      End If
   ElseIf vgDataType = [Date ] Then                                            'campo data coloca formatando
      Text = Format$(Trim(New_Value), TrataMaskData$(vgMask))
   ElseIf vgDataType = [Boolean] Then                                          'campo lógico
      If vgCtPri.Value <> Abs(New_Value <> 0) Then                             'se teve alteração
         vgCtPri.Value = Abs(New_Value <> 0)                                   'troca seu valor
      End If
   ElseIf vgDataType = [Option ] Then                                          'campo optativo
      vgCtPri.Value = True                        'marca esta opção
      If vgLocked = False And vgCtPri.WhatsThisHelpID <> -1 Then 'se esta travado acerta o
         vgCtFdo.Caption = Str$(BookMark)                        'label de controle do optativo
      End If
   Else                                           'campos caracteres, numéricos e memos

      'campo numérico com lista interna
      If Len(vgListFields) > 0 And (vgDataType = Numeric Or (VarType(New_Value) >= vbInteger And VarType(New_Value) <= vbCurrency)) Then
         CarregaGMCale
         If New_Value < vgfrmGMCale.grdListaG.ListCount Then 'se valor passado é menor que número de itens
            vgfrmGMCale.grdListaG.SelecionaItem New_Value    'marca item na lst e coloca o texto no ctl principal
            Text = Substitui(vgfrmGMCale.grdListaG.ColumnValue(-1, 1), vbTab, vgSubsTab$, SO_UM)
         End If
      Else
         On Error Resume Next                                'previne erro
         x$ = CStr(New_Value)                                'transforma qualquer tipo em caractere
         If Err Then                                         'não conseguiu converter
            Err.Clear                                        'limpa o erro
            x$ = ""                                          'e coloca texto em branco
         End If
         Text = x$                                           'coloca o texto conforme sua máscara
      End If
   End If

   If vgSetValorOriginal Then
      vgValorOriginal = New_Value
      vgSetValorOriginal = False
   End If

DeuErro:
   If Err Then Err.Clear
   vgPriVez = vgPV
End Property

Public Function FieldValue(ByVal St As String, ByVal Tp As TipoDeCampo, ByVal MA As String, ByVal LstCp As String) As Variant
   Dim i As Integer, k As String
   Select Case Tp
      Case Character, Memo
         FieldValue = St$
      Case Numeric, Spinner, [Option ]
         If Len(LstCp$) > 0 Then
            i = InStr("|" + LstCp$ + "|", "|" + St$ + "|")
            If i = 0 Then
               FieldValue = -1
            Else
               k$ = Left$(LstCp$, i - 1)
               FieldValue = Len(k$) - Len(Retira$(k$, "|", SO_UM))
            End If
         Else
            FieldValue = CtoN(St$)
         End If
      Case [Date ]
         If Len(St$) = 0 Then
            FieldValue = Null
         Else
            k$ = Format$(St$, TrataMaskData$(MA$))
            If IsDate(k$) Then
               FieldValue = CDate(k$)
            Else
               FieldValue = Null
            End If
         End If
      Case [Boolean]
         FieldValue = (Len(Trim$(St$)) > 0)
   End Select
End Function

Public Function FormatField(ByVal New_Value As Variant, ByVal MA As String, ByVal Tp As TipoDeCampo, ByVal LstCp As String) As Variant
   Dim RetVal As Variant, xDataType As TipoDeCampo, xMask As String, xMascara As String, xMaiusculo As Integer, xMinusculo As Integer, i As Integer, _
       xSoAlfa  As Integer, xQcDec As Integer, xQcInt As Integer, xTemSpInt As Integer, xMaxLength As Integer, j As Integer, xgListFields As String, xStuffChar As String
   vgPriVez = True

   'salva situacao atual
   xDataType = vgDataType
   xMascara$ = vgMascara$
   xMask$ = vgMask
   xMaiusculo = vgMaiusculo
   xMinusculo = vgMinusculo
   xSoAlfa = vgSoAlfa
   xQcDec = vgQcDec
   xQcInt = vgQcInt
   xTemSpInt = vgTemSpInt
   xMaxLength = MaxLength
   xgListFields = vgListFields
   xStuffChar = vgStuffChar

   'define situacao para a formatacao do texto
   vgDataType = Tp
   vgMask = MA
   vgListFields = LstCp$
   TrataMascara
   If vgDataType = [Date ] Then
      RetVal = Format$(Trim(New_Value), TrataMaskData$(vgMask))
   Else
      If (vgDataType = Numeric And Len(LstCp$) > 0) Or vgDataType = [Option ] Then
         If Len(CStr(New_Value)) = 0 Then
            RetVal = ""
         Else
            j = 1
            For i = 0 To New_Value - 1
               j = InStr(j, LstCp$, "|") + 1
            Next
            If j > 0 Then
               i = InStr(j, LstCp$ + "|", "|")
               RetVal = Mid$(LstCp$, j, i - j)
            Else
               RetVal = ""
            End If
         End If
      Else
         If Len(vgMask$) > 0 Then
            If vgDataType = Character And vgMask$ = String(Len(vgMask$), "9") Then vgStuffChar = "0"      'vamos completar com zeros à esquerda...
            'nao pode colocar o trim(New_Value) pois perde o espacos de mascaras
            'que comecao com # (#999-9999)
            RetVal = FormatText((New_Value))
         Else
            RetVal = New_Value
         End If
      End If
   End If

   'restaura a situacao
   vgDataType = xDataType
   MaxLength = xMaxLength
   vgMascara$ = xMascara$
   vgMask$ = xMask
   vgMaiusculo = xMaiusculo
   vgMinusculo = xMinusculo
   vgSoAlfa = xSoAlfa
   vgQcDec = xQcDec
   vgQcInt = xQcInt
   vgTemSpInt = xTemSpInt
   vgListFields = xgListFields
   vgStuffChar = xStuffChar
   vgPriVez = False
   FormatField = RetVal
End Function

'formata uma string confome sua máscara
Public Function FormatText(St As String) As String
   Dim x As String, vgTexto As String, i As Integer, z As String, p As Integer, b10 As Double, vgNegativo As Boolean
   If IsEmpty(St) Then Exit Function                      'não tem nada a fazer
   If vgDataType = Memo Or Len(St$) = 0 Then              'campo memo
      FormatText = St$                                    'nao tem formatacao
      Exit Function
   End If
   vgTexto$ = TiraTracos(St$, 1)                          'retira caracteres insertáveis do texto
   If Len(vgMascara) > 0 And vgDataType = Character And _
      Len(vgStuffChar) > 0 And Len(vgTexto$) > 0 Then     'ajusta texto com caracter (StuffChar) à esquerda
      vgTexto$ = Right$(String(Len(vgMascara$), vgStuffChar) + Trim$(vgTexto$), Len(TiraTracos(vgMascara$, 1))) 'com brancos
   End If
   vgTexto$ = PoeTracos(vgTexto$, 0)              'põe caracteres insertáveis no texto
   If (vgDataType = Numeric Or vgDataType = Spinner) And _
      Len(vgListFields) = 0 Then                  'lst interna com campo numérico

NovaPosDec:
      i = InStr(vgTexto$, vgSpDec$)               'testa se o separador (,) está no texto
      If i = 0 Then
         i = Len(vgTexto$) + 1                    'senão, pega o tamanho todo
      Else
         p = InStr(vgTexto$, "E-")                'verifica se número esta na base 10
         If p > 0 Then
            b10 = Val(Mid$(vgTexto$, p + 1))      'separa base 10
            If (i + vgQcDec + b10) < 1 Then
               vgTexto$ = CDec(vgTexto$)          'Caso seja base decimal
            Else
               If (p - 1) - i > vgQcDec Then      'trunca número de decimais
                  vgTexto$ = Left$(vgTexto$, i + vgQcDec + b10)
               End If
               b10 = ValBrasil(vgTexto$) * (10 ^ b10) 'calcula novo número
            End If
            vgTexto$ = CStr(b10)                      'coloca no texto
            GoTo NovaPosDec                           'e começa tudo de novo
         End If
      End If
      x$ = Left$(vgTexto$, i - 1)                     'separa a parte inteira do número
      If vgQcInt > 0 Then                             'trunca na qde de inteiros da máscara
         x$ = Left$(Retira$(Left$(vgTexto$, i - 1), vgSpInt$, UM_A_UM), vgQcInt)
      End If
      If vgTemSpInt Then                              'se tem separador de inteiros
         x$ = Retira$(x$, vgSpInt$, UM_A_UM)          'vamos tirar os que já tem
         vgNegativo = (Left$(Trim$(x$), 1) = "-")     'valor negativo?
         x$ = Format$(x$, "#,##0")                    'coloca sep de inteiro nos lugares certos
         If vgNegativo And Left$(x$, 1) <> "-" Then
            x$ = "-" + x$                             'o numero era negativo recoloca sinal
         End If
      End If

      'se no texto foram digitado decimais vamos colocar no texto junto com
      'o separador de decimais
      If vgQcDec > 0 Then
         z$ = Left$(Retira$(Mid$(vgTexto$, i + 1), vgSpDec$, UM_A_UM), vgQcDec)
         x$ = x$ + vgSpDec$ + Left$(z$ + String$(vgQcDec, "0"), vgQcDec)
      End If
      vgTexto$ = x$                                   'texto numérico formatado
   ElseIf vgDataType = [Date ] Then                   'cp data formata de acordo com a sua máscara
      vgTexto$ = Format$(vgTexto$, TrataMaskData$(vgMask))
   End If                                             'retorna o texto formatado
   FormatText = vgTexto$
End Function

Private Sub UpdateAlias()
   If ComLstExt Then
      CarregaGMCale
      vgfrmGMCale.UpdateFieldsAlias
   End If
End Sub

'acha o datacontrol associado a lst externa e enche o item desta lst ou
'enche a lst interna com os itens da ListFields
Private Sub EncheRowSource()
   Dim i As Integer, z As String, k As String, QI As Integer, x As String
   On Error Resume Next                                    'previne erros...
   If ComLstExt Then
      CarregaGMCale
      vgfrmGMCale.IniciaCale MOSTRA_LST_EXTERNA
      vgfrmGMCale.ClearFields
      For i = 1 To Tally(Substitui$(ListFields, "; ", "|", SO_UM), "|") + 1
         vgfrmGMCale.AddField Parse(Substitui$(ListFields, "; ", "|", SO_UM), "|", i), False
      Next
      For i = 1 To Tally(Substitui$(ShowFields, "; ", "|", SO_UM), "|") + 1
         x$ = Parse(Substitui$(ShowFields, "; ", "|", SO_UM), "|", i)
         If InStr("|" + Substitui$(ListFields, "; ", "|", SO_UM) + "|" + ShowFields + "|", "|" + x$ + "|") = 0 Then
            vgfrmGMCale.AddField x$, True
         End If
      Next
      If InStr("|" + Substitui$(ListFields, "; ", "|", SO_UM) + "|" + Substitui$(ShowFields, "; ", "|", SO_UM) + "|", "|" + BoundColumn + "|") = 0 Then
         vgfrmGMCale.AddField BoundColumn, True
      End If
   ElseIf Len(vgListFields) > 0 And Len(vgBoundColumn) = 0 Then 'lst interna
      CarregaGMCale
      vgfrmGMCale.IniciaCale MOSTRA_LST_INTERNA                 'prepara lst para ser mostrada
      vgfrmGMCale.ClearFields
      z$ = vgListFields                                         'itens da lst
      vgfrmGMCale.grdListaG.ClearItems                          'limpa lista
      x$ = Substitui(Text, vgSubsTab$, vbTab, SO_UM)            'item atual
      QI = -1
      Do While Len(z$) > 0                                      'vamos colocar todos os itens na lst
         i = InStr(z$, "|")                                     'próximo da lista
         If i = 0 Then i = Len(z$) + 1                          'é o último
         k$ = Trim$(Left$(z$, i - 1))                           'separa um único item
         z$ = Mid$(z$, i + 1)
         If k$ = "{*}" Then
            vgAllowAnyText = True
         Else
            vgfrmGMCale.grdListaG.AddItem k$                    'adiciona na lst
            If x$ = k$ Then                                     'é o item atual
               QI = vgfrmGMCale.grdListaG.ListCount - 1         'guarda sua posição
            End If
         End If
      Loop
      vgfrmGMCale.grdListaG.SelecionaItem QI                    'escolhe ele na lst
   End If
End Sub

'campo de retorno da lst externa - pega
Public Property Get BoundColumn() As String
   BoundColumn = vgBoundColumn
End Property

'campo de retorno da lst externa - coloca
Public Property Let BoundColumn(ByVal New_BoundColumn As String)
   vgBoundColumn = New_BoundColumn
   If Len(vgShowFields) = 0 Then ShowFields = vgListFields
End Property

'lst de itens da lst interna - pega
Public Property Get ListFields() As String
   ListFields = vgListFields
End Property

'lst de itens da lst interna - coloca
Public Property Let ListFields(ByVal New_ListFields As String)
   If vgListFields <> New_ListFields Then
      vgListFields = New_ListFields
      EncheRowSource                                            'enche lst conforme novos itens
      If Len(vgShowFields) = 0 And Len(vgBoundColumn) > 0 Then ShowFields = vgListFields
      UpdateAlias
   End If
End Property

'lst de itens da lst interna - pega
Public Property Get ShowFields() As String
   ShowFields = vgShowFields
End Property

'lst de itens da lst interna - coloca
Public Property Let ShowFields(ByVal New_ShowFields As String)
   If vgShowFields <> New_ShowFields Then
      vgShowFields = New_ShowFields
      If Len(vgShowFields) > 0 And Len(vgMask) > 0 Then        'cp tipo lst
         TrataMascara                                          'tem máscaras especiais
      End If
      EncheRowSource                                           'enche lst conforme novos itens
      If Len(vgListFields) = 0 Then ListFields = vgShowFields
   End If
End Property

'lst de campos para ordenar - pega
Public Property Get OrderFields() As String
   OrderFields = vgOrderFields
End Property

'lst de campos para ordenar - coloca
Public Property Let OrderFields(ByVal New_OrderFields As String)
   If vgOrderFields <> New_OrderFields Then
      vgOrderFields = New_OrderFields
      CarregaGMCale
      vgfrmGMCale.Order = vgOrderFields
   End If
End Property

'lst de campos para ordenar - pega
Public Property Get PesqFieldCapture() As String
   PesqFieldCapture = vgPesqFieldCapture
End Property

'lst de campos para ordenar - coloca
Public Property Let PesqFieldCapture(ByVal New_PesqFieldCapture As String)
   If vgPesqFieldCapture <> New_PesqFieldCapture Then
      vgPesqFieldCapture = Parse$(Retira$(New_PesqFieldCapture, "[]", UM_A_UM), ".", 2)
   End If
End Property

'lst de campos para ordenar - pega
Public Property Get PesqSQLExpression() As String
   PesqSQLExpression = vgPesqSQLExpression
End Property

'lst de campos para ordenar - coloca
Public Property Let PesqSQLExpression(ByVal New_PesqSQLExpression As String)
   If vgPesqSQLExpression <> New_PesqSQLExpression Then
      vgPesqSQLExpression = New_PesqSQLExpression
   End If
End Property

'lst de campos para ordenar - pega
Public Property Get PesqBD() As String
   PesqBD = vgPesqBD
End Property

'lst de campos para ordenar - coloca
Public Property Let PesqBD(ByVal New_PesqBD As String)
   If vgPesqBD <> New_PesqBD Then
      vgPesqBD = New_PesqBD
   End If
End Property

'máscara para o campo - pega
Public Property Get Mask() As String
   Mask = vgMask
End Property

'máscara para o campo - coloca
Public Property Let Mask(ByVal New_Mask As String)
   vgMask = New_Mask
   TrataMascara                                          'trata/inicializa máscara
End Property

'trata máscara/inicializa variáveis de auxilia a formatação do campo
Private Sub TrataMascara()
   Dim i As Integer, x As String                         'inicializa variáveis
   
   If Len(vgListFields) > 0 Then                         'se tem lst interna/externa
      vgMask = ""                                        'não tem máscara
      If vgDataType <> Memo Then                         'e se não for memo
         vgCtPri.MaxLength = 0                           'não tem tamanho definido
      End If
   End If
   vgMascara$ = vgMask                                   'máscara tratada
   vgMaiusculo = False                                   'flag - tudo maiúsculo
   vgMinusculo = False                                   'flag - tudo minúsculo
   vgSoAlfa = False                                      'flag - só alfabético
   vgQcDec = 0                                           'número de decimais
   vgQcInt = 0                                           'e inteiros
   vgTemSpInt = False                                    'flag - tem separador de inteiro
   If Left$(vgMascara$, 1) = "I" Then                    'é campo Invisível?
      vgMascara$ = Mid$(vgMascara$, 2)                   'tira um caracteres da frente
   End If
   While Left$(LTrim$(vgMascara$), 1) = "@"              'enquanto começar com @ (pode combinar "@!@A...")
      vgMascara$ = LTrim$(vgMascara$)                    'tira brancos da frente (pode " @! @A...")
      If Left$(vgMascara$, 2) = "@!" Then                'deseja tudo maiúsculas?
         vgMascara$ = LTrim$(Mid$(vgMascara$, 3))        'tira dois caracteres da frente
         vgMaiusculo = True                              'liga flag do controle
      End If
      If Left$(vgMascara$, 2) = "@a" Then                'deseja tudo miúsculas?
         vgMascara$ = LTrim$(Mid$(vgMascara$, 3))        'tira dois caracteres da frente
         vgMinusculo = True                              'liga flag do controle
      End If
      If Left$(vgMascara$, 2) = "@A" Then                'se for @A - tudo alfabético
         vgMascara$ = LTrim$(Mid$(vgMascara$, 3))        'tira os 2 primeiros caracteres
         vgSoAlfa = True                                 'liga a flag tudo alfabético
      End If
      If Left$(vgMascara$, 1) = "@" And _
         Left$(vgMascara$, 2) <> "@!" And _
         Left$(vgMascara$, 2) <> "@a" And _
         Left$(vgMascara$, 2) <> "@A" Then               'tira caracteres estranhos!!!
         vgMascara$ = LTrim$(Mid$(vgMascara$, 3))
      End If
   Wend

   'campo numérico trata máscara
   If vgDataType = Numeric Or vgDataType = Spinner Then
      x$ = Retira$(vgMascara$, ".", UM_A_UM)             'retira separação de inteiros
      i = InStr(x$, ",")                                 'posição do ponto decimal
      If i > 0 Then
         vgQcInt = i - 1                                 'qde inteiros a considerar
         vgQcDec = Len(x$) - i                           'qde de casas decimais a considerar
      Else                                               'não tem decimais
         vgQcInt = Len(x$)                               'só inteiros
      End If
      If InStr(vgMascara$, ".") > 0 Then                 'se na máscara tem separadores de inteiros
         vgTemSpInt = True                               'seta flag
      End If
      vgMascara$ = String$(Len(vgMascara$), "9")         'coloca tudo 9 para números
   ElseIf vgDataType = [Date ] Then                      'campo data
      vgMascara$ = TrataMaskData$(vgMascara$)            'troca 99/99/99 por dd/mm/yy
      i = InStr(LCase$(vgMascara$), "mmm")               'se nome do mês é por extenso
      If i > 0 Then
         Mid$(vgMascara$, i, 1) = "!"                    'troca os "m" por
         i = i + 1                                       'caracteres que aceitem a digitação de alfabéticos

OutroMes:
         If LCase$(Mid$(vgMascara$, i, 1)) = "m" Then    'mais um "m"
            Mid$(vgMascara$, i, 1) = "a"                 'troca este também
            i = i + 1                                    'e vê o próximo caracter
            GoTo OutroMes
         End If
      End If
      For i = 1 To Len(vgMascara$)
         If InStr("dmyhsDMYHS", Mid$(vgMascara$, i, 1)) > 0 Then
            Mid$(vgMascara$, i, 1) = "9"                 'os demais troca para aceitar digitação de números
         End If
      Next
   End If

   'se não tem @ na máscara arranja qde de caracteres possíveis de
   'serem digitados
   If InStr(vgMask, "@") = 0 And Len(vgMask) > 0 Then
      If Not vgCtPri Is Nothing Then
         If vgDataType <> Memo And vgDataType <> [Boolean] And Not vgCtPri Is Nothing Then
            On Error Resume Next
            vgCtPri.MaxLength = Len(vgMascara$)
         ElseIf vgDataType = Memo Then
            On Error Resume Next
            vgCtPri.MaxLength = 0
         End If
      End If
   End If
End Sub

'pega o modo de abertura da pesquisa
Public Property Get PesqModoAbertura() As Integer
   PesqModoAbertura = vgPesqModoAbertura
End Property

'define o modo de abertura da pesquisa
Public Property Let PesqModoAbertura(NewPesqModoAbertura As Integer)
   vgPesqModoAbertura = NewPesqModoAbertura
End Property

'tido do campo - pega
Public Property Get DataType() As TipoDeCampo
   DataType = vgDataType
End Property

'tido do campo - coloca
Public Property Let DataType(ByVal New_DataType As TipoDeCampo)
   vgDataType = New_DataType
End Property

'caractere a justificar a esquerda - pega
Public Property Get StuffChar() As String
   StuffChar = vgStuffChar
End Property

'caractere a justificar a esquerda - coloca
Public Property Let StuffChar(ByVal New_StuffChar As String)
   vgStuffChar = New_StuffChar
End Property

'tira os caracteres insertáveis, na posição correspondente da máscara
Private Function TiraTracos(vgSt As String, vgPo As Integer) As String
   Dim k As String, i As Integer, x As String, z As String, w As String               'dimensiona locais
   z$ = C_INSERTAVEIS                             'caracteres que podem ser inseridos nas máscaras
   If vgDataType = Numeric Or vgDataType = Spinner Then
      z$ = Mid$(z$, 5)                            'tira sinais e separadores para campos numéricos
   End If
   If InStr(vgMascara$, "#") Then                 'se na máscara pode ter brancos
      z$ = Left$(z$, Len(z$) - 1)                 'tira o espaco dos caracteres insertáveis
   End If
   k$ = Left$(vgSt$, vgPo - 1)                    'salva o que tem antes do cursor
   For i = vgPo To Len(vgSt$)                     'com o restante,
      x$ = Mid$(vgSt$, i, 1)                      'caractere do campo
      w$ = Mid$(vgMascara$, i, 1)                 'caractere da máscara
      If (InStr(z$, x$) = 0 Or w$ = "" Or (InStr("Aa!X#", w$) > 0 And x$ = " ")) And _
         Asc(Mid$(vgSt$, i)) <> 255 Then          'se não for caractere insertável...
         k$ = k$ + x$                             'concatena com o que tinha antes
      End If
   Next
   TiraTracos$ = k$                               'depois de tudo retorna a nova string
End Function

'coloca caracteres insertáveis, na posição correspondente da máscara
Private Function PoeTracos(vgSt As String, vgPo As Integer) As String
   Dim k As String, x As String, i As Integer, _
       j As Integer                                        'dimensiona locais
   k$ = Left$(vgSt$, vgPo)                                 'salva o que tem antes do cursor
   j = vgPo + 1                                            'inicializa j no próximo char
   For i = vgPo + 1 To Len(vgSt$)                          'com o restante,
      x$ = Mid$(vgMascara$, j, 1)                          'pega o caracter que tem na máscara, nesta posição
      If InStr(C_INSERTAVEIS, x$) > 0 Or x$ = "" Then      'se for um char insertável,
         k$ = k$ + Mid$(vgMascara$, j, 1)                  'tira da máscara e coloca no campo
         j = j + 1                                         'incrementa contador
      End If
      k$ = k$ + Mid$(vgSt$, i, 1)                          'concatena com o restante
      j = j + 1                                            'incrementa contador
   Next                                           'pega próximo
   PoeTracos$ = k$                                'retorna string com traços
End Function

'faz o tratamento da tecla pressionada durante a edição do controle...
'como o controle de edição é todo feito aqui, vamos retornar sempre 0 para
'que o VB fique na dele e não faça nada...
Private Function TrataTecla(KeyAscii As Integer, ByVal KeyOri As Integer) As Integer
   Dim p As Integer, vgTexto As String, vgCM As String, z As String, _
       x As String, i As Integer, vgTamaCp As Integer, j As Integer, vgClipB As String, _
       vgNegativo As Integer, ii As Long                 'dimensiona locais

   If vgDataType <> [Boolean] And vgDataType <> [Option ] Then 'todos os tipos, menos estes...
      vgTamaCp = IIf(vgCtPri.MaxLength = 0, 32000, vgCtPri.MaxLength) 'ajusta qde de máxima de chars a digitar
   End If
   If vgSoAlfa Then                               'se máscara alfabética,
      vgMascara$ = String$(vgTamaCp, 65)          'enchemos a máscara de AAAA...
   End If

   Select Case KeyAscii                           'tecla digitada
      Case vbKeyReturn, -1                        'se ENTER ou seta para baixo
         If vgDataType = Memo Then                'e o campo for memo
            TrataTecla = KeyOri                   'vamos deixar com o VB
         Else                                     'senão,
            TrataTecla = 0
            SendK vbKeyTab                        'funcionará com TAB
         End If
         Exit Function                            'cai fora daqui...

      Case -2                                     'seta para cima...
         If vgDataType = Memo Then                'nos campo memos
            TrataTecla = KeyOri                   'vamos deixar com o VB
         Else                                     'nos demais
            TrataTecla = 0                        'anula tecla digitada e
            keybd_event VK_SHIFT, &H45, KEYEVENTF_EXTENDEDKEY Or 0, 0 'Simula KeyPress
            SendK vbKeyTab                                            'trata como SHIFT+TAB
            keybd_event VK_SHIFT, &H45, KEYEVENTF_EXTENDEDKEY Or KEYEVENTF_KEYUP, 0 'Simula KeyRelease
         End If
         Exit Function                            'e sai...
   End Select

   If vgLocked Or vgCtPri.WhatsThisHelpID = -1 Then 'controle não editável
      KeyAscii = 0                                  'tecla não faz nada
      Exit Function                                 'cai fora...
   End If


   Select Case KeyAscii                             'tecla digitada
      Case 3, 24                                    'CTRL+C, CTRL+X
         Clipboard.Clear                            'limpa o clipboard
         Clipboard.SetText vgCtPri.SelText          'joga texto selecionado nele
         If KeyAscii = 24 Then                      'se CTRL+X
            KeyAscii = TECLA_DEL                    'mata texto marcado
         Else
            TrataTecla = 0                          'anula tecla
            Exit Function                           'e cair fora daqui...
         End If

      Case 22                                       'CTRL+V
         vgClipB$ = Clipboard.GetText()             'pega o que esta no clipboard
         On Error Resume Next
         If ComLstExt And Len(vgClipB$) > 0 Then
            vgfrmGMCale.SearchListBox Parse$(vgClipB$, vgSubsTab$), False
         End If
         On Error GoTo 0
         If Len(vgMascara) = 0 Then                 'se não tem máscara
            p = vgCtPri.SelStart + 1                'poe o clipboard todo de uma vez
            vgCtPri.Text = Left$(vgCtPri.Text, p - 1) + IIf(vgMaiusculo, UCase$(vgClipB$), IIf(vgMinusculo, LCase$(vgClipB$), vgClipB$)) + _
                           Mid$(vgCtPri.Text, p + vgCtPri.SelLength)
            vgCtPri.SelStart = p + Len(vgClipB$) - 1 'reposiciona posiçao do cursor
         Else                                        'tem máscara
            If vgDataType = Numeric Or vgDataType = Spinner Then 'se campo numérico
               vgClipB$ = Retira$(vgClipB$, vgSpInt$, SO_UM)     'tira separador de inteiros
            End If
            For ii = 1 To Len(vgClipB$)                          'joga letra por letra
               KeyAscii = Asc(Mid$(vgClipB$, ii, 1))             'para tratar a máscara
               GoSub PoeLetra
            Next
         End If
         TrataTecla = 0                                          'retorna 0 - VB não faz nada... Tudo foi tratado aqui...
         Exit Function                                           'cai fora daqui...
   End Select

   'se tipo de campo for memo, lógico ou optativo não tem máscara
   If vgDataType = Memo Or vgDataType = [Boolean] Or vgDataType = [Option ] Then
      TrataTecla = KeyOri                                        'deixa o VB trabalhar normalmente
   Else
      GoSub PoeLetra                                             'trata tecla de acordo com sua máscara
      TrataTecla = 0                                             'retorna 0 - VB não faz nada... Tudo foi tratado aqui...
   End If
   Exit Function

PoeLetra:
   If vgCtPri.Locked Or vgCtPri.WhatsThisHelpID = -1 Then        'travado cai fora...
      Exit Function
   End If

   p = vgCtPri.SelStart + 1                                      'pega posição após o cursor
   vgTexto$ = Text                                               'salva o texto que está no campo
   If vgCtPri.SelLength > 0 Then                                 'se tem texto selecionado,
      vgTexto$ = Left$(vgTexto$, p - 1) + _
      String$(vgCtPri.SelLength, 255) + _
      Mid$(vgTexto$, p + vgCtPri.SelLength)                      'joga asc 255 na parte selecionada
   End If
   vgCM$ = Mid$(vgMascara$, p, 1)                                'pega caractere da máscara, nesta posição
   If vgCM$ = "" Then vgCM$ = "X"                                'se x ou nada, qq caracter serve
   If HaNaString(1, vgMascara$, C_INSERTAVEIS, UM_A_UM) > 0 Or _
    InStr(vgTexto$, Chr$(255)) > 0 Then                          'se tem caractere insertável na máscara ou tinha seleção
      vgTexto$ = TiraTracos(vgTexto$, p)                         'retira insertáveis a partir do cursor
   End If
   z$ = vgTexto$
   If KeyAscii = vbKeyBack Then                                  'se teclou retrocesso,
      If p > 1 Then                                              'se não estamos na primeira posição,
         vgTexto$ = Left$(vgTexto$, p - 2) + Mid$(vgTexto$, p)   'retira o caractere e
         p = p - 1                                               'reajusta posição
      End If
   ElseIf KeyAscii = TECLA_DEL Then                              'se teclou DEL
      If vgCtPri.SelLength = 0 Then
         vgTexto$ = Left$(vgTexto$, p - 1) + Mid$(vgTexto$, p + 1) 'retira o caractere sob o cursor
      End If
   ElseIf (vgDataType = Numeric Or vgDataType = Spinner) And (((KeyAscii = 44 Or KeyAscii = 46) And (InStr(vgTexto$, vgSpDec$) > 0 Or vgQcDec = 0)) Or _
     ((KeyAscii = 45 And (InStr(vgTexto$, "-") > 0 Or p > 1)))) Then 'se dado numérico, teclou vírgula e já tinha vírgula,
         Beep                                     'beep!
   Else                                           'senão,
      If KeyAscii < 32 Or KeyAscii = 127 Then     'se for char estranho
         TrataTecla = 0                           'não considera
         Exit Function                            'e cai fora daqui...
      End If
      If p <= vgTamaCp Then                       'se posição cursor dentro do campo,
         If InStr(C_INSERTAVEIS, vgCM$) > 0 And _
            vgDataType <> Numeric And vgDataType <> Spinner Then 'e se está sobre um caractere insertável
            vgTexto$ = Left$(vgTexto$, p - 1) + vgCM$ + _
                       Mid$(vgTexto$, p)                         'tira este caractere
            p = p + 1                                            'incrementa a posição
            vgCM$ = Mid$(vgMascara$, p, 1)                       'pega o novo caractere da máscara, na posição
            If vgCM$ = "" Then vgCM$ = "X"                       'se vazio, considera x - qq caractere serve
         End If
         Select Case vgCM$                                       'compara o caractere que está na máscara, na posição

            Case "9", "#"                                        'números 0-9 e sinais (se # pode espaço também)
               x$ = C_NUMERICOS                                  'inicializa x com dígitos numéricos
               If vgCM$ = "#" Then                               'se na máscara tem # e tipo de dado não numérico
                  If vgDataType <> Numeric And vgDataType <> Spinner Then
                     x$ = x$ + " "                               'espaço também vai poder ser digitado...
                  End If
               ElseIf vgDataType = Numeric Or vgDataType = Spinner Then 'senão, se tipo de dado é numérico,
                  x$ = x$ + "-,."                                       'vamos poder digitar vírgula e sinais
                  If vgInFilter Then x$ = x$ + "*"                      'se estiver na barra de filtro do grid, vamos permitir usar o * num campo numérico
                  If KeyAscii = 44 Or KeyAscii = 46 Then
                     KeyAscii = Asc(vgSpDec$)
                  End If
               End If
               If InStr(x$, Chr$(KeyAscii)) Then                        'se o que teclamos for válido, então
                  vgTexto$ = Left$(vgTexto$, p - 1) + Chr$(KeyAscii) + _
                           Mid$(vgTexto$, p)                            'concatena na string a ser retornada
                  p = p + 1                                             'incrementa a posição
               End If
            Case "A", "N"                                               'só letras (A-z acentuadas ou não) - se "N", pode números também
               If (KeyAscii > 64 And KeyAscii < 91) Or (KeyAscii > 223 And KeyAscii < 253) Or _
                  (KeyAscii > 192 And KeyAscii < 221) Or (KeyAscii > 96 And KeyAscii < 123) Or _
                  (KeyAscii = 32) Or (vgCM$ = "N" And _
                  InStr(C_NUMERICOS, Chr$(KeyAscii)) > 0) Then          'se for caracter aceitável
                  vgTexto$ = Left$(vgTexto$, p - 1) + _
                           IIf(vgMaiusculo, UCase$(Chr$(KeyAscii)), Chr$(KeyAscii)) + _
                           Mid$(vgTexto$, p)                            'concatena controlando maiúsculas...
                  p = p + 1                                             'incrementa ponteiro do cursor
               End If
            Case "!", "X", "a"                                          'qualquer caracter serve...
               vgTexto$ = Left$(vgTexto$, p - 1) + _
                        IIf(vgMaiusculo Or vgCM$ = "!", UCase$(Chr$(KeyAscii)), IIf(vgMinusculo Or vgCM$ = "a", LCase$(Chr$(KeyAscii)), Chr$(KeyAscii))) + _
                        Mid$(vgTexto$, p)                               'concatena jogando para maiúsculas, se requerido
               p = p + 1                                                'incrementa ponteiro do cursor
         End Select
      End If
   End If
   If HaNaString(1, vgMascara$, C_INSERTAVEIS, UM_A_UM) > 0 Then        'se tem caracter insertável na máscara,
      vgTexto$ = Left$(PoeTracos(vgTexto$, p - 1), vgTamaCp)            'põe os caracteres nas posições
   End If
   If vgDataType = Numeric Or vgDataType = Spinner Then                 'campos numéricos
      i = InStr(vgTexto$, vgSpDec$) - 1                                 'testa se o separador (,) está no texto
      If i = -1 Then i = Len(vgTexto$)                                  'se não está só tem inteiros
      x$ = Left$(vgTexto$, i)                                           'pega a parte inteira
      If vgTemSpInt Then                                                'se existe separador de inteiros
         j = Len(z$) - Len(Retira$(z$, vgSpInt$, UM_A_UM))              'qde de sep inteiros que tem no texto
         x$ = Left$(Retira$(x$, vgSpInt$, UM_A_UM), vgQcInt)            'deixa só os números
         vgNegativo = (Left$(Trim$(x$), 1) = "-")                       'valor negativo?
         x$ = Format$(x$, "#,##0")                                      'coloca sep de inteiro nos lugares certos
         If vgNegativo And Left$(x$, 1) <> "-" Then
            x$ = "-" + x$                                               'o numero era negativo recoloca sinal
         End If
         x$ = Substitui$(x$, ".", vgSpInt$, UM_A_UM)                    'coloca o separador de acordo com o idioma
         p = p + (Len(x$) - Len(Retira$(x$, vgSpInt$, UM_A_UM)) - j)    'posição atual do cursor
         If KeyAscii = 45 Then p = p + 1                                'se digitou (.) anda mais um
      Else
         x$ = Left$(x$, vgQcInt)                                        'deixa só os números da parte inteira...
      End If

      'coloca decimais e o peprador de decimais se necessário
      vgTexto$ = x$ + Left$(Retira$(Mid$(vgTexto$, i + 1), vgSpInt$, UM_A_UM), vgQcDec + 1)
   End If
   vgCtPri.Text = vgTexto$                                              'joga o resultado no controle principal
   If p <= 0 Then p = 1
   vgCtPri.SelStart = p - 1                                             'restaura a posição do cursor
   Return

End Function

'título do controle - pega
Public Property Get Caption() As String
   If Not (vgCtTit Is Nothing) Then                      'se o ctl do título já foi definido
      Caption = vgCtTit.Caption                          'pega sua propriedade
   End If
End Property

'título do controle - coloca
Public Property Let Caption(ByVal New_Caption As String)
   If Not (vgCtTit Is Nothing) Then                      'se o ctl existe
      vgCtTit.Caption() = New_Caption                    'coloca o novo título
   End If
End Property

'tipo do shape quando sem o foco - pega
Public Property Get FillStyleOnFocus() As Integer
   FillStyleOnFocus = vgFillStyleOnFocus
End Property

'tipo do shape quando sem o foco - coloca
Public Property Let FillStyleOnFocus(ByVal New_FillStyleOnFocus As Integer)
   vgFillStyleOnFocus = New_FillStyleOnFocus
   If Not (vgCtShp Is Nothing) Then                      'se o controle já está definido
      vgCtShp.FillStyle = vgFillStyleOnFocus             'troca propriedade do shape
   End If
End Property

'tipo do shape quando com o foco - pega
Public Property Get FillStyleNoFocus() As Integer
   FillStyleNoFocus = vgFillStyleNoFocus
End Property

'tipo do shape quando com o foco - coloca
Public Property Let FillStyleNoFocus(ByVal New_FillStyleNoFocus As Integer)
   vgFillStyleNoFocus = New_FillStyleNoFocus
End Property

'nome do data control da lst externa - pega
Public Property Get RowSource() As String
   RowSource = vgRowSource
End Property

'nome do data control da lst externa - coloca
Public Property Let RowSource(ByVal New_RowSource As String)
   vgRowSource = New_RowSource
End Property

'verifica se o campo tem uma lista externa
Public Function ComLstExt() As Integer
' If Not (vgRsLista Is Nothing) And Len(vgBoundColumn) > 0 And Len(vgListFields) > 0 Then
   If Len(vgBoundColumn) > 0 And Len(vgListFields) > 0 Then
      ComLstExt = True
   Else
      ComLstExt = False
   End If
End Function

'habilita controle - pega
Public Property Get Enabled() As Boolean
   On Error Resume Next
   Enabled = vgCtPri.Enabled
End Property

'habilita controle - coloca
Public Property Let Enabled(ByVal New_Enabled As Boolean)
   Dim i As Integer
   On Error Resume Next
   If Not (vgCtPri Is Nothing) Then vgCtPri.Enabled() = New_Enabled

   'verifica os controles associados e muda seu estado também
   For i = 0 To 2
      If Not (vgCtBot(i) Is Nothing) Then vgCtBot(i).Enabled() = New_Enabled
   Next
   If Not (vgCtScr Is Nothing) Then vgCtScr.Enabled() = New_Enabled
   If Not (vgCtFdo Is Nothing) Then vgCtFdo.Enabled() = New_Enabled
   If Not (vgCtTit Is Nothing) Then vgCtTit.Enabled() = New_Enabled
End Property

'habilita ou desabilita a edição de texto nas listas (combos)
Public Property Let AllowAnyText(ByVal New_AllowAnyText As Boolean)
   vgAllowAnyText = New_AllowAnyText
End Property

'retorna o estado da permissão de edição em listas (combos)
Public Property Get AllowAnyText() As Boolean
   AllowAnyText = vgAllowAnyText
End Property

'visibilidade do controle - pega
Public Property Get Visible() As Boolean
   Visible = vgVisible
End Property

'visibilidade do controle - coloca
Public Property Let Visible(ByVal New_Visible As Boolean)
   Dim i As Integer
   
   On Error Resume Next
   vgVisible = New_Visible
   If Not (vgCtPri Is Nothing) Then vgCtPri.Visible() = vgVisible

   'troca visibilidade dos controles associados
   For i = 0 To 2
      If Not (vgCtBot(i) Is Nothing) Then vgCtBot(i).Visible() = vgVisible
   Next
   If Not (vgCtScr Is Nothing) Then vgCtScr.Visible() = vgVisible
   If Not (vgCtFdo Is Nothing) And vgDataType <> [Option ] Then vgCtFdo.Visible() = vgVisible
   If Not (vgCtTit Is Nothing) Then vgCtTit.Visible() = vgVisible
   If Not (vgCtShp Is Nothing) Then vgCtShp.Visible() = vgVisible
End Property

'nome do controle - pega
Public Property Get Name() As String
   Name = vgCtPri.Name
End Property

'indice do controle - pega
Public Property Get Index() As Integer
   Index = vgCtPri.Index
End Property

'quando setado para True, o campo numérico poderá receber também o * para permitir filtragens com like
Public Property Let InFilter(New_InFilter As Boolean)
   vgInFilter = New_InFilter
End Property

'retorna a indicação de que o campo é usado para fitragem com like, mesmo sendo numérico
Public Property Get InFilter() As Boolean
   InFilter = vgInFilter
End Property

'inicializa classe com os defaults de algumas propriedades
Private Sub Class_Initialize()
   vgColorNoFocus = &HFF&
   vgColorOnFocus = &HFF00&
   vgFillStyleOnFocus = 0
   vgFillStyleNoFocus = 0
   vgFormatLostFocus = True
   vgBookMark = Null
   vgMask = ""
   vgListFields = ""
   vgShowFields = ""
   vgBoundColumn = ""
   vgDataType = Character
   vgStuffChar = ""
   vgSelectOnFocus = True
   vgLocked = False
   vgEditable = True
   vgfrmCalcNaMem = False
   vgSetValorOriginal = False
   vgValueAtual = Empty
   vgQtCh = -1
End Sub

'termina a classe
Private Sub Class_Terminate()
   Dim vgErrNum As Long, vgErrDesc As String, vgErrSrc As String

   'salva erro
   vgErrNum = Err.Number
   vgErrDesc = Err.Description
   vgErrSrc = Err.Source
   
   Finalize

   'restaura erro
   Err.Number = vgErrNum
   Err.Description = vgErrDesc
   Err.Source = vgErrSrc

End Sub
