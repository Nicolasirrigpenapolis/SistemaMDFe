VERSION 5.00
Begin VB.Form frmBrowse 
   ClientHeight    =   2025
   ClientLeft      =   5175
   ClientTop       =   4110
   ClientWidth     =   3075
   ControlBox      =   0   'False
   KeyPreview      =   -1  'True
   LinkTopic       =   "frmBrowse"
   MDIChild        =   -1  'True
   ScaleHeight     =   2025
   ScaleWidth      =   3075
   Begin NFE.GListV grdBrowse 
      Height          =   1785
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   2835
      _ExtentX        =   5001
      _ExtentY        =   3149
      FullRowSelect   =   0   'False
      StripesBackColor=   14737632
      RowHeight       =   285
      AllowEdit       =   -1  'True
      AllowInsert     =   -1  'True
      AllowDelete     =   -1  'True
      NavigationAddMode=   1
      ShowFilterBar   =   -1  'True
      ShowTopField    =   -1  'True
      ShowCloseButton =   -1  'True
      SaveGridStripes =   0   'False
      Caption         =   "BROWSE"
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
End
Attribute VB_Name = "frmBrowse"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'* Sistema...: Emissor de Nota Fiscal Eletronica
'* Empresa...: Ygor Eduardo Dellalio
'* Módulo....: frmBROWSE
'* Função....: Apresentação de consultas
'* CopyRight.: (C)2016 Ygor Eduardo Dellalio
'* Criação...: GAS-2007 - Gerador Automático de Sistemas
'* Data......: 30/06/2016 10:19:28
'* * * * * * *

Option Explicit                                   'requer declaração de variáveis
DefInt A-Z                                        'estabelece todas inteiras, por default

Const LARG_MIN = 4215                             'largura míminima do form - vamos limitar o usuário dimiminuir
Const ALT_MIN = 3000                              'largura míminima do form - vamos limitar o usuário dimiminuir

Public CtTransfer As FormataCampos                      'campo para transferência da pesquisa
Public vgSituacao As Integer, vgCaracteristica As Integer
Public vgTipo As Integer, vgFormID As Long, vgQueryAtual As String, vgIdentTab As String                                            'todos os forms têm essas propriedades
Public vgFromFormID As Long
Public vgEmBrowse As Integer
Public vgPriVez As Integer, vgTitConsulta As String          'cria as propriedades
Public vgUltimoFiltro As String, vgUltimoFiltroComTit As String, vgTemFiltro As Integer, vgFiltroInicial As String  'necessárias a este form
Public vgUltimaOrdem As String, vgUltimaOrdemComTit As String, vgOrdemInicial As String, vgOrdemAtual As String, vgFiltroAtual As String
Public vgSQL As String, vgTemBrowse As Boolean, vgGrvCol As String, vgGrvFiltro As Boolean
Public vgFrmImpCons As New frmImpCons             'impressao de consulta
Public vgCancelou As Boolean
Public vgTb As GRecordSet                         'Recordset para controle de impressao.

Private Sub Form_Activate()
   DoEvents
   AtivaForm Me                                      'executa rotinas de inicialização deste form

   'se tiver imprimindo registros em grade, fecha form de selecao/preview
   If Not frmEnviaEMail.Visible Then
      Unload vgFrmImpCons
      Set vgFrmImpCons = Nothing
      Unload frmEnviaEMail
   Else
      frmEnviaEMail.Show
   End If
End Sub

'executada ao carregar formulário de consultas
Private Sub Form_Load()
   Dim x As String                                   'string de uso geral
   
   vgCaracteristica = F_BROWSE                       'designa sua característica
   vgSituacao = ACAO_NAVEGANDO                       'situação e
   vgTipo = TP_BROWSE                                'tipo
   vgFormID = 2                                      'identificacao do form
   vgTemFiltro = True                                'liga flags
   vgTemBrowse = True
   Icon = LoadPicture(LoadGasPicture(220))           'coloca icone no form
   vgQueryAtual$ = vgNovaQuery$
   grdBrowse.Caption = LoadGasString(1630) + vgTitConsulta$ 'coloca o título no form
   vgIdentTab = vgQueryAtual$
   x$ = vgNomeEstacao$ + Name + " - " + Caption             'nome do form (grupo)
   vgUltimoFiltro = PegaStrDoIni(x$, "Ultimo filtro", vgNomeINI$) 'ultimo filtro
   vgUltimoFiltroComTit = PegaStrDoIni(x$, "Ultimo filtro com titulo", vgNomeINI$) 'ultimo filtro com titulo
   vgUltimaOrdem = PegaStrDoIni(x$, "Ultima ordem", vgNomeINI$)                    'ultimo ordem
   vgUltimaOrdemComTit = PegaStrDoIni(x$, "Ultima ordem com titulo", vgNomeINI$)   'ultima ordem com titulo
   Set Font = grdBrowse.Font
   
   IniciaFormDados Me                             'prepara filtro e ordem

   grdBrowse.AddControlIgnoreFocus mdiNFE.botCancela.hWnd 'não deixa o grid tentar gravar automaticamente
   grdBrowse.AddControlIgnoreFocus mdiNFE.botSalva.hWnd   'se estiver perdendo o foco para esses botões

   'desabilita as permissões de manipulação de dados do browse
   grdBrowse.AllowInsert = False
   grdBrowse.AllowEdit = False
   grdBrowse.AllowDelete = False
   
   On Error GoTo DeuErro
   grdBrowse.OpenRecordSet vgSQL, IIf(Not CtTransfer Is Nothing, CURSOR_TABLE, CURSOR_ASYNC), True, vgFiltroAtual, vgOrdemAtual
   AjustaTamanho Me                                       'ajusta tamanho do form, se form filho
   Exit Sub
   
DeuErro:
   CErr.Show
End Sub

'ocorre quando o usuário muda o tamanho do form, ou na primeira carga do form
Private Sub Form_Resize()
   If vgPriVez Then Exit Sub
   If WindowState <> vbMinimized Then
      vgPriVez = True
      If Width < LARG_MIN And WindowState = vbNormal Then       'se normal e com largura aceitável
         Width = LARG_MIN                                       'segura na largura mínima
      End If
      If Height < ALT_MIN And WindowState = vbNormal Then       'se normal e com largura aceitável
         Height = ALT_MIN                                       'segura na largura mínima
      End If
      vgPriVez = False
      grdBrowse.Move 0, 0, ScaleWidth, ScaleHeight
   End If
End Sub

'ROTINA MANUAL
'Sempre que fechar ou esconte a pesquisa apagar o filtro
'se pesquisa e perder foco, oculta formulário
Private Sub Form_Deactivate()
   If Not CtTransfer Is Nothing Then
      On Error Resume Next
      'Antes
      'Me.Hide
      'Agora
      'Inicio Manual
      Me.Hide: grdBrowse.ClearFilterBar
      'Fim Manual
   End If
End Sub


'ROTINA MANUAL
'PROPOSITO: Quando Fizer uma Consulta retornar a tela anterior e quando abrir a Tela de Cadastro fechá-lá
Private Sub Form_Unload(Cancel As Integer)

   'se tiver imprimindo registros em grade, fecha form de selecao/preview
   Unload vgFrmImpCons
   Set vgFrmImpCons = Nothing

   If Not vgGrvFiltro Then                            'se não for gravar o filtro
      vgUltimoFiltro$ = ""                            'limpa variável
      vgUltimoFiltroComTit = ""
      vgUltimaOrdem$ = ""
      vgUltimaOrdemComTit = ""
   End If
   
   FinalizaForm Me                                    'ativa rotinas de finalização deste form
   
   grdBrowse.Finalize
   Set frmBrowse = Nothing                            'destroi este formulário
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyEscape And grdBrowse.Status = ACAO_NAVEGANDO And Not grdBrowse.PreEditing Then             'se teclou ESC
      If Not CtTransfer Is Nothing Then
         Me.Hide
      Else
         Unload Me
      End If
   End If
End Sub

'se clicado e pesquisa, retorna valor para o campo
Private Sub grdBrowse_ItemClick(ByVal Item As Long, Columns() As Variant)
   If Not CtTransfer Is Nothing Then
      If Len(CtTransfer.PesqFieldCapture) > 0 Then
         CtTransfer.Value = grdBrowse.ColumnValue(Item + 1, CtTransfer.PesqFieldCapture)
      Else
         CtTransfer.Value = grdBrowse.ColumnValue(Item + 1, grdBrowse.Col)
      End If
      Me.Hide
      If Not mdiNFE.ActiveControl Is Nothing Then
         If Not TypeOf mdiNFE.ActiveControl Is GListV Then
            CtTransfer.CtPri.SetFocus
         End If
      End If
   End If
End Sub

'CUIDADO: ROTINA MANUAL
'PROPOSITO: Quando o usuario apertar F3 na consulta abrir o formulario com os dados
Private Sub grdBrowse_KeyDown(ByVal KeyCode As Integer, ByVal Shift As Integer, Columns() As Variant)
   Dim i As Long
   If KeyCode = vbKeyReturn Then
      If Not CtTransfer Is Nothing Then
         If Len(CtTransfer.PesqFieldCapture) > 0 Then
            CtTransfer.Value = grdBrowse.ColumnValue(grdBrowse.SelectedItem + 1, CtTransfer.PesqFieldCapture)
         Else
            CtTransfer.Value = grdBrowse.ColumnValue(grdBrowse.SelectedItem + 1, grdBrowse.Col)
         End If
         Me.Hide
      End If
   End If
   
End Sub


Private Sub grdBrowse_CloseButtonClick()
   If Not CtTransfer Is Nothing Then
      Me.Hide
   Else
      Unload Me
   End If
End Sub

Private Sub grdBrowse_StatusChanged(ByVal NewStatus As Integer)
   PrepBotoes Me, NewStatus                          'acerta icones dos botoes
   mdiNFE.RemontaForm                                'remonta todos os form da tela
End Sub

Private Sub grdBrowse_RecordSetChanged(ByVal NewRecordSet As GRecordSet)
   'Vamos clonar o Recordset da ListView para o objeto recordset da impressao
   Set vgTb = NewRecordSet.Clone
End Sub
