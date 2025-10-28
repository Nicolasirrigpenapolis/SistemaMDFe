VERSION 5.00
Begin VB.Form frmProcura
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Montagem da PESQUISA"
   ClientHeight    =   4185
   ClientLeft      =   3375
   ClientTop       =   3960
   ClientWidth     =   7365
   ForeColor       =   &H80000008&
   KeyPreview      =   -1  'True
   LinkTopic       =   "frmProcura"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4185
   ScaleWidth      =   7365
   ShowInTaskbar   =   0   'False
   Begin NFE.GBotao botCancela
      Height          =   450
      Left            =   6885
      TabIndex        =   9
      Top             =   3720
      Width           =   450
   End
   Begin NFE.GBotao botOk
      Height          =   450
      Left            =   5985
      TabIndex        =   7
      Top             =   3720
      Width           =   450
      Enabled         =   0   'False
   End
   Begin NFE.GBotao botLimpa
      Height          =   450
      Left            =   6435
      TabIndex        =   8
      Top             =   3720
      Width           =   450
   End
   Begin VB.Frame fraIndice 
      Caption         =   "Índices"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3375
      Left            =   15
      TabIndex        =   13
      Top             =   15
      Width           =   3080
      Begin VB.ListBox lstIndices
         Height          =   2985
         Left            =   120
         TabIndex        =   0
         Top             =   240
         Width           =   2835
      End
   End
   Begin VB.Frame FraProcura 
      Caption         =   "Conteúdo a procurar"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3375
      Left            =   3135
      TabIndex        =   11
      Top             =   15
      Width           =   4215
      Begin VB.TextBox txtCp 
         Height          =   315
         Index           =   1
         Left            =   1860
         TabIndex        =   6
         Top             =   240
         Width           =   2235
      End
      Begin VB.Label labChave 
         Alignment       =   1  'Right Justify
         BackStyle       =   0  'Transparent
         Caption         =   "Label1"
         ForeColor       =   &H00FF0000&
         Height          =   225
         Index           =   1
         Left            =   0
         TabIndex        =   12
         Top             =   285
         Width           =   1755
      End
   End
   Begin VB.Frame fraOperadores 
      Caption         =   "Operadores"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   15
      TabIndex        =   10
      Top             =   3435
      Width           =   3080
      Begin VB.OptionButton opcOper
         Caption         =   ">"
         Height          =   195
         Index           =   0
         Left            =   240
         TabIndex        =   1
         Top             =   300
         Width           =   405
      End
      Begin VB.OptionButton opcOper
         Caption         =   ">="
         Height          =   195
         Index           =   1
         Left            =   720
         TabIndex        =   2
         Top             =   300
         Width           =   525
      End
      Begin VB.OptionButton opcOper
         Caption         =   "="
         Height          =   195
         Index           =   2
         Left            =   1320
         TabIndex        =   3
         Top             =   300
         Value           =   -1  'True
         Width           =   405
      End
      Begin VB.OptionButton opcOper
         Caption         =   "<="
         Height          =   195
         Index           =   3
         Left            =   1800
         TabIndex        =   4
         Top             =   300
         Width           =   525
      End
      Begin VB.OptionButton opcOper
         Caption         =   "<"
         Height          =   195
         Index           =   4
         Left            =   2400
         TabIndex        =   5
         Top             =   300
         Width           =   405
      End
   End
End
Attribute VB_Name = "frmProcura"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
'* Sistema...: Emissor de MDF-e (Layout 3.00)
'* Empresa...: Ygor Eduardo Dellalio
'* Módulo....: frmProcura
'* Função....: Executa pesquisa indexada
'* CopyRight.: (C)2024 Ygor Eduardo Dellalio
'* Criação...: GAS-2007 - Gerador Automático de Sistemas
'* Data......: 05/09/2024 18:10:18
'* * * * * * *

Option Explicit                                   'tudo tem de ser declarado!
DefInt A-Z                                        'variáveis inteiras são gastam menos e operam mais rápido

Public vgCaracteristica As Integer, vgSituacao As Integer, vgFormID As Long, vgTipo As Integer
Public vgTooltips As New cTooltips

Dim txtCampo() As New FormataCampos

Const ALT_NORMAL = 735                            'essa é a altura normal deste form

Dim vgTd As Object, vgIdx As Object               'vamos precisar desses dois objetos
Dim vgICp As Integer                              'armazena de cxs de texto para o indice
Dim vgOper As String                              'operador a ser usado na pesquisa

Private Sub botLimpa_Click()
   ClickLstIndices                                'faz de conta que é a primeira vez...
End Sub

Private Sub botOk_Click()
   Dim vgChaves() As Variant, i As Integer, vgIndAtual As String
   Dim x As Variant
   ReDim vgChaves(vgICp) As Variant                      'vetor para armazenar as chaves
   For i = 1 To vgICp
      vgChaves(i) = txtCampo(i).Value
   Next
   With mdiNFE.ActiveForm.vgTb                           'para facilitar
      vgIndAtual = .Index                                'salva indice atual
      .ChangeIndex vgDb.Tables(mdiNFE.ActiveForm.vgIdentTab).Indexes(lstIndices.ItemData(lstIndices.ListIndex)).Name 'liga o índice selecionado
      Select Case vgICp                           'não se espante! O Bill Gates falou que é assim mesmo!...
         Case 1                                   'se tiver uma chave...
            .SeekRecord "", vgOper$, vgChaves(1)  '... pesquisa só ela...
         Case 2
            .SeekRecord "", vgOper$, vgChaves(1), vgChaves(2)
         Case 3
            .SeekRecord "", vgOper$, vgChaves(1), vgChaves(2), vgChaves(3)
         Case 4
            .SeekRecord "", vgOper$, vgChaves(1), vgChaves(2), vgChaves(3), vgChaves(4)
         Case 5
            .SeekRecord "", vgOper$, vgChaves(1), vgChaves(2), vgChaves(3), vgChaves(4), vgChaves(5)
         Case 6
            .SeekRecord "", vgOper$, vgChaves(1), vgChaves(2), vgChaves(3), vgChaves(4), vgChaves(5), vgChaves(6)
         Case 7
            .SeekRecord "", vgOper$, vgChaves(1), vgChaves(2), vgChaves(3), vgChaves(4), vgChaves(5), vgChaves(6), vgChaves(7)
         Case 8
            .SeekRecord "", vgOper$, vgChaves(1), vgChaves(2), vgChaves(3), vgChaves(4), vgChaves(5), vgChaves(6), vgChaves(7), vgChaves(8)
         Case 9
            .SeekRecord "", vgOper$, vgChaves(1), vgChaves(2), vgChaves(3), vgChaves(4), vgChaves(5), vgChaves(6), vgChaves(7), vgChaves(8), vgChaves(9)
         Case 10
            .SeekRecord "", vgOper$, vgChaves(1), vgChaves(2), vgChaves(3), vgChaves(4), vgChaves(5), vgChaves(6), vgChaves(7), vgChaves(8), vgChaves(9), vgChaves(10)
      End Select
      If Not mdiNFE.ActiveForm.vgTb.NoMatch Then  'se  encontrou...
         x = mdiNFE.ActiveForm.vgTb.BookMark
      End If

      .ChangeIndex vgIndAtual                     'retorna ao indice original
   End With

   If mdiNFE.ActiveForm.vgTb.NoMatch Then         'se não encontrou...
      Beep                                        'beepa e
      MsgBox LoadGasString(9010), vbExclamation, vgAtencao$ 'avisa...
   Else                                           'se encontrou,
      mdiNFE.ActiveForm.vgTb.BookMark = x
      If mdiNFE.ActiveForm.vgTemBrowse Then
         If mdiNFE.ActiveForm.vgEmBrowse Then
            mdiNFE.ActiveForm.grdBrowse.SelecionaItem mdiNFE.ActiveForm.vgTb.AbsolutePosition - 1
         End If
      End If
      UnLoad Me                                   'descarrega o form
      mdiNFE.ActiveForm.Reposition                'mostra o registro
      AjustaRolagem mdiNFE.ActiveForm             'ajusta scroll de rolagem de reg
   End If
   Exit Sub


DeuErro:
   CErr.NumErro = Err
   CErr.Show
End Sub

Private Sub botCancela_Click()
   Unload Me                                      'descarrega o form
End Sub

Private Sub Form_Unload(Cancel As Integer)
   Dim i As Integer
   Set vgIdx = Nothing                            'destroi objetos
   Set vgTd = Nothing
   If vgICp > 1 Then                              'se esta variável está maior do que 0,
      For i = 2 To vgICp                          'é sinal que tem mais de um campo no indice
         vgTooltips.DeleteTool txtCp(i)           'retira o hint do controle 
         Unload labChave(i)                       'retira os controle da memória
         Unload txtCp(i)                                 
         txtCampo(i).Finalize
         Set txtCampo(i) = Nothing
      Next
      vgICp = 0                                   'zera contador de indices
   End If
   vgTooltips.DeleteTool txtCp(1)                 'retira o hint do controle 
   For i = 1 To UBound(txtCampo)
      txtCampo(i).Finalize
      Set txtCampo(i) = Nothing
   Next 
   Set vgTooltips = Nothing
End Sub

Private Sub Form_Load()
   Dim i As Integer, j As Integer, vgIndDef As String
   vgCaracteristica = F_COMUM
   vgSituacao = ACAO_NAVEGANDO
   vgFormID = 8                                         'identificacao do form
   vgTipo = TP_COMUM                                    'seu tipo
   fraIndice.Caption = LoadGasString(9001)              'os titulos dos labels

   'carrega os ícones dos botões
   Set botOk.Picture = LoadPicture(LoadGasPicture(290))
   Set botOk.PictureDisabled = LoadPicture(LoadGasPicture(295))
   Set botLimpa.Picture = LoadPicture(LoadGasPicture(300))
   Set botCancela.Picture = LoadPicture(LoadGasPicture(310))
   ReDim txtCampo(1) As New FormataCampos
   Set txtCampo(1).CtPri = txtCp(1)

   'hint para os controles 
   vgTooltips.Create
   vgTooltips.AddTool lstIndices, 0, LoadGasString(9030)
   vgTooltips.AddTool botOk, 0, LoadGasString(9040)
   vgTooltips.AddTool botLimpa, 0, LoadGasString(9050)
   vgTooltips.AddTool botCancela, 0, LoadGasString(9060)
   vgTooltips.AddTool txtCampo(1).CtPri, 0, LoadGasString(9080) 'e o conteúdo
   For i = 0 To 4
      vgTooltips.AddTool opcOper(i), 0, LoadGasString(i + 9081)
   Next
   vgOper$ = "="                                                'operador default é igualdade...
   opcOper(1).Value = True
   Caption = LoadGasString(9000) + mdiNFE.ActiveForm.Caption    'título deste form de pesquisa
   vgICp = 0                                      'inicializa o contador de campos/índice
   lstIndices.Clear                               'limpa para encher lista com os nomes dos indices
   j = 0
   vgIndDef$ = ""
   For i = 1 To vgDb.Tables(mdiNFE.ActiveForm.vgIdentTab).Indexes.Count
      If Not vgDb.Tables(mdiNFE.ActiveForm.vgIdentTab).Indexes(i).Hidden Then
         lstIndices.AddItem vgDb.Tables(mdiNFE.ActiveForm.vgIdentTab).Indexes(i).Title
         lstIndices.ItemData(lstIndices.ListCount - 1) = vgDb.Tables(mdiNFE.ActiveForm.vgIdentTab).Indexes(i).Index
      End If
   Next
   SelecionaItemLista vgIndDef$
   CentraNaTela Me                                'e centraliza na área de cliente do MDI
End Sub

Private Sub SelecionaItemLista(vgInd As String)
   Dim i As Integer
   For i = 0 To lstIndices.ListCount - 1
      If lstIndices.List(i) = vgInd$ Then
         lstIndices.ListIndex = i
         Exit For
      End If
   Next
   If lstIndices.ListIndex = -1 And lstIndices.ListCount > 0 Then
      lstIndices.ListIndex = 0
   End If
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyEscape Then                 'se teclou ESC
      Unload Me                                   'tira este form da memória
   End If
End Sub

Private Sub lstIndices_Click()
   ClickLstIndices                                    'prepara para receber os cps dos indices
End Sub

'prepara cps do indice selecionado
Private Sub ClickLstIndices()
   Dim i As Integer, vgDistV As Integer, vgCp As GColumn, vgTp As GCOLUMN_TYPE, vgInd As GIndex
   vgDistV = txtCampo(1).Height + 15                  'distancia vertical das cx de texto
   Set vgInd = vgDb.Tables(mdiNFE.ActiveForm.vgIdentTab).Indexes(lstIndices.ItemData(lstIndices.ListIndex))
   If vgICp > 1 Then                                  'se esta variável está maior do que 0,
      For i = 2 To vgICp                              'é sinal que o usuário já trabalhou com
         vgTooltips.DeleteTool txtCp(i)               'retira o hint do controle 
         Unload labChave(i)                           'outros ídices nesta seção e, neste caso,
         Unload txtCp(i)                              'excedentes da última seção
      Next
      vgICp = 0                                       'zera contador de indices
   End If
   i = 0                                              'inicializa contador
   For i = 1 To vgInd.Columns.Count                   'para cada campo do indice selecionado,
      Set vgCp = vgInd.Columns(i)
      If i > 1 Then                                   'se nao for o primeiro,
         Load labChave(i)                             'precisamos carregar o label
         Load txtCp(i)                                'e a cx texto no vetor
         ReDim Preserve txtCampo(i) As New FormataCampos 'redimenciona a clase   
         Set txtCampo(i).CtPri = txtCp(i)
         txtCampo(i).DataType = 0                        'inicialiaza com caracter
         labChave(i).Top = txtCampo(i - 1).Top + vgDistV 'acerta o top to label
         txtCampo(i).Top = txtCampo(i - 1).Top + vgDistV 'e da cx texto
         labChave(i).Visible = True                      'e os coloca
         txtCampo(i).Visible = True                      'visíveis
         labChave(i).TabIndex = (i * 2) + 5              'ajusta o tabindex
         txtCampo(i).CtPri.TabIndex = labChave(i).TabIndex + 1 'ajusta o tabindex
         vgTooltips.AddTool txtCampo(i).CtPri, 0, LoadGasString(9080) 'e o conteúdo
      End If
      botOk.TabIndex = txtCampo(i).CtPri.TabIndex + 1
      botCancela.TabIndex = txtCampo(i).CtPri.TabIndex + 3
      botLimpa.TabIndex = txtCampo(i).CtPri.TabIndex + 2
      txtCampo(i).Text = ""                                           'apaga conteudo do campo
      labChave(i).Caption = vgCp.Title                                'joga o seu nome no label
      vgTp = vgCp.ColumnType                                          'pega tipo do campo
      txtCampo(i).Mask = vgCp.Mask                                    'pega mascara do campo
      If vgTp = TP_CARACTER Then                                      'se for tipo texto
         txtCampo(i).DataType = 0
         txtCampo(i).MaxLength = 0
         txtCampo(i).Mask = txtCampo(i).Mask
         If Len(txtCampo(i).Mask) > 0 Then                            'dependendo da mascara coloca "0" ou " " a esquerda
            If txtCampo(i).Mask = String$(Len(txtCampo(i).Mask), "9") Then
               txtCampo(i).StuffChar = "0"
            ElseIf txtCampo(i).Mask = String$(Len(txtCampo(i).Mask), "#") Then
               txtCampo(i).StuffChar = " "
            End If
         End If
      ElseIf vgTp = TP_MEMO Then                                      'se for memo
         txtCampo(i).DataType = 4
      ElseIf vgTp = TP_DATA_HORA Then                                 'se for data
         txtCampo(i).DataType = 2
         txtCampo(i).Mask = txtCampo(i).Mask
      ElseIf vgTp = TP_LOGICO Then                                    'se for logico
         txtCampo(i).DataType = 5
      Else                                        'se for númerico
         txtCampo(i).DataType = 1
         txtCampo(i).Mask = txtCampo(i).Mask
      End If
   Next
   vgICp = vgInd.Columns.Count
End Sub

Private Sub lstIndices_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      If txtCampo(1).Visible Then txtCampo(1).SetFocus
   End If
End Sub

Private Sub opcOper_Click(Index As Integer)
   vgOper$ = opcOper(Index).Caption                 'pega operador no título da opção
End Sub

Private Sub txtCp_Change(Index As Integer)
   Dim i As Integer, vgOk As Integer
   txtCampo(Index).Change
   vgOk = False                                      'inicializa flag
   For i = 1 To vgICp                                'se tiver algum texto em pelo menos uma cx
      If Len(txtCampo(i).Text) > 0 Then              'então, podemos
         vgOk = True                                 'habilitar botão ok
         Exit For                                    'sai do for...
      End If
   Next
   If vgOk <> botOk.Enabled Then                     'vamos mexer somente se estiver diferente,
      botOk.Enabled = vgOk                           'senão este botão vai ficar indesejavelmente piscando
   End If
End Sub

Private Sub txtCp_GotFocus(Index As Integer)
   txtCampo(Index).GotFocus
End Sub

Private Sub txtCp_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
   txtCampo(Index).KeyDown KeyCode, Shift
End Sub

Private Sub txtCp_KeyPress(Index As Integer, KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then                    'se teclou ENTER,
      If Index >= vgICp Then                         'se não estamos na última caixa de texto,
         KeyAscii = 0                                'vamos anular esta tecla
         If botOk.Enabled = True Then                'senão, se o botão ok está habilitado,
            txtCampo(Index).LostFocus                'força a formatação com a máscara
            botOk_Click                              'força click no botão de OK
            Exit Sub
         End If
      End If
   End If
   txtCampo(Index).KeyPress KeyAscii
End Sub

Private Sub txtCp_LostFocus(Index As Integer)
   txtCampo(Index).LostFocus
End Sub
