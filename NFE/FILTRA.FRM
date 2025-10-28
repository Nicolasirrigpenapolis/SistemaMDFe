Version 5.00
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "TABCTL32.OCX"
Begin VB.Form frmFiltra
   BorderStyle     =   3
   Caption         =   "Montagem de FILTRO"
   ClientHeight    =   4905
   ClientLeft      =   6450
   ClientTop       =   2130
   ClientWidth     =   6540
   BeginProperty Font
      Name            =   "MS Sans Serif"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H80000008&
   KeyPreview      =   -1  'True
   LinkTopic       =   "frmFiltra"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4905
   ScaleWidth      =   6540
   ShowInTaskbar   =   0   'False
   Begin NFE.GBotao botLimpa 
      Height          =   450
      Left            =   5550
      TabIndex        =   8
      Top             =   4380
      Width           =   450
      _ExtentX        =   0
      _ExtentY        =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         StrikeThrough   =   0   'False
      EndProperty
   End
   Begin NFE.GBotao botOk 
      Height          =   450
      Left            =   5100
      TabIndex        =   7
      Top             =   4380
      Width           =   450
      _ExtentX        =   0
      _ExtentY        =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         StrikeThrough   =   0   'False
      EndProperty
   End
   Begin NFE.GBotao botCancela 
      Height          =   450
      Left            =   6000
      TabIndex        =   9
      Top             =   4380
      Width           =   450
      _ExtentX        =   0
      _ExtentY        =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         StrikeThrough   =   0   'False
      EndProperty
   End
   Begin VB.TextBox txtCriterio 
      BackColor       =   &H00FFFFFF&
      Height          =   1365
      Left            =   90
      Locked          =   -1  'True
      MultiLine       =   -1  'True
      TabIndex        =   18
      TabStop         =   0   'False
      Top             =   2940
      Width           =   6345
   End
   Begin TabDlg.SSTab tabFiltro 
      Height          =   2595
      Left            =   90
      TabIndex        =   0
      Top             =   90
      Width           =   6375
      _ExtentX        =   11245
      _ExtentY        =   4577
      _Version        =   393216
      Style           =   1
      Tabs            =   2
      TabsPerRow      =   2
      TabHeight       =   520
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         StrikeThrough   =   0   'False
      EndProperty
      TabCaption(0)   =   "Filtragem"
      Tab(0).ControlEnabled=   -1  'True
      Tab(0).Control(0)=   "labOperador"
      Tab(0).Control(0).Enabled=   0   'False
      Tab(0).Control(1)=   "labValor"
      Tab(0).Control(1).Enabled=   0   'False
      Tab(0).Control(2)=   "labNomeCampo"
      Tab(0).Control(2).Enabled=   0   'False
      Tab(0).Control(3)=   "cboOperador"
      Tab(0).Control(3).Enabled=   0   'False
      Tab(0).Control(4)=   "cboCampos"
      Tab(0).Control(4).Enabled=   0   'False
      Tab(0).Control(5)=   "txtCp(0)"
      Tab(0).Control(5).Enabled=   0   'False
      Tab(0).Control(6)=   "fraAndOr"
      Tab(0).Control(6).Enabled=   0   'False
      Tab(0).Control(7)=   "botConcatena"
      Tab(0).Control(7).Enabled=   0    'False
      Tab(0).Control(8) = "CboFiltros"
      Tab(0).Control(8).Enabled=   0    'False
      Tab(0).Control(9) = "LabelNomeFiltro"
      Tab(0).Control(9).Enabled = 0   'False
      Tab(0).ControlCount=   10
      TabCaption(1)   =   "Ordenação"
      Tab(1).ControlEnabled=   0   'False
      Tab(1).Control(0)=   "labOrdem"
      Tab(1).Control(0).Enabled=   0   'False
      Tab(1).Control(1)=   "fraOrdenacao"
      Tab(1).Control(1).Enabled=   0   'False
      Tab(1).Control(2)=   "lstCampoOrdem"
      Tab(1).Control(2).Enabled=   0    'False
      Tab(1).Control(3)=   "LabelNomeOrdem"
      Tab(1).Control(3).Enabled=   0    'False
      Tab(1).Control(4)=   "CboOrdem"
      Tab(1).Control(4).Enabled=   0   'False
      Tab(1).ControlCount=   5
      Begin NFE.GBotao botConcatena 
         Height          =   405
         Left            =   4590
         TabIndex        =   6
         Top             =   2010
         Width           =   1635
         _ExtentX        =   3836
         _ExtentY        =   714
         Enabled         =   0   'False
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            StrikeThrough   =   0   'False
         EndProperty
         Caption         =   "&Concatena"
      End
      Begin VB.ComboBox CboOrdem 
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            StrikeThrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   -74880
         TabIndex        =   23
         Text            =   "CboOrdem"
         Top             =   660
         Width           =   6155
      End
      Begin VB.ComboBox CboFiltros 
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            StrikeThrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   120
         TabIndex        =   21
         Text            =   "CboFiltros"
         Top             =   660
         Width           =   6155
      End
      Begin VB.frame fraAndOr 
         Height          =   495
         Left            =   4590
         TabIndex        =   17
         Enabled         =   0   'False
         Top             =   1170
         Width           =   1665
         Begin VB.OptionButton opcAndOr 
            Caption         =   "OU..."
            Enabled         =   0   'False
            Height          =   255
            Index           =   1
            Left            =   780
            TabIndex        =   5
            Top             =   150
            Width           =   855
         End
         Begin VB.OptionButton opcAndOr 
            Caption         =   "E..."
            Enabled         =   0   'False
            Height          =   255
            Index           =   0
            Left            =   120
            TabIndex        =   4
            Top             =   150
            Value           =   -1  'True
            Width           =   675
         End
      End
      Begin VB.TextBox txtCp 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            StrikeThrough   =   0   'False
         EndProperty
         Height          =   315
         Index           =   0
         Left            =   120
         TabIndex        =   3
         Top             =   2070
         Width           =   4365
      End
      Begin VB.ComboBox cboCampos 
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            StrikeThrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   120
         Style           =   2  'Dropdown List
         TabIndex        =   1
         Top             =   1320
         Width           =   3195
      End
      Begin VB.ComboBox cboOperador 
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            StrikeThrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   3390
         Style           =   2  'Dropdown List
         TabIndex        =   2
         Top             =   1320
         Width           =   1035
      End
      Begin VB.ListBox lstCampoOrdem 
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            StrikeThrough   =   0   'False
         EndProperty
         Height          =   1230
         Left            =   -74880
         MultiSelect     =   1  'Simple
         TabIndex        =   12
         Top             =   1230
         Width           =   3945
      End
      Begin VB.frame fraOrdenacao 
         Caption         =   "Ordenação"
         Height          =   1185
         Left            =   -70740
         TabIndex        =   13
         Top             =   1290
         Width           =   1935
         Begin VB.OptionButton opcOrdem 
            Caption         =   "&Ascendente"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               StrikeThrough   =   0   'False
            EndProperty
            Height          =   255
            Index           =   0
            Left            =   270
            TabIndex        =   10
            Top             =   390
            Value           =   -1  'True
            Width           =   1485
         End
         Begin VB.OptionButton opcOrdem 
            Caption         =   "&Descendente"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               StrikeThrough   =   0   'False
            EndProperty
            Height          =   255
            Index           =   1
            Left            =   270
            TabIndex        =   11
            Top             =   750
            Width           =   1455
         End
      End
      Begin VB.Label LabelNomeOrdem 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Nome da Ordem"
         Height          =   195
         Left            =   -74880
         TabIndex        =   24
         Top             =   420
         Width           =   1365
      End
      Begin VB.Label LabelNomeFiltro 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Nome do Filtro"
         Height          =   195
         Left            =   120
         TabIndex        =   22
         Top             =   420
         Width           =   1245
      End
      Begin VB.Label labOrdem 
         Caption         =   "Seleciona a ordem e o campo"
         Height          =   195
         Left            =   -74880
         TabIndex        =   20
         Top             =   990
         Width           =   3735
      End
      Begin VB.Label labNomeCampo 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Nome do campo"
         Height          =   195
         Left            =   120
         TabIndex        =   16
         Top             =   1080
         Width           =   1380
      End
      Begin VB.Label labValor 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Valor"
         Height          =   195
         Left            =   120
         TabIndex        =   15
         Top             =   1830
         Width           =   450
      End
      Begin VB.Label labOperador 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Operador"
         Height          =   195
         Left            =   3390
         TabIndex        =   14
         Top             =   1080
         Width           =   795
      End
   End
   Begin VB.Label labCriterio 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Expressão que define o filtro/ordenação dos registros"
      Height          =   195
      Left            =   90
      TabIndex        =   19
      Top             =   2700
      Width           =   3645
   End
End
Attribute VB_Name = "frmFiltra"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
'* Sistema...: Emissor de MDF-e (Layout 3.00)
'* Empresa...: Ygor Eduardo Dellalio
'* Módulo....: frmFiltra
'* Função....: Monta expressão de filtro
'* CopyRight.: (C)2024 Ygor Eduardo Dellalio
'* Criação...: GAS-2007 - Gerador Automático de Sistemas
'* Data......: 05/09/2024 18:10:18
'* * * * * * *

Option Explicit                                   'requer declaração de variáveis
DefInt A-Z                                        'todas inteiras, por default

Public vgCaracteristica As Integer, vgSituacao As Integer, vgFormID As Long, vgTipo As Integer
Public vgTooltips As New cTooltips

Dim vgForm As Form, vgTb As GRecordSet            'dimensiona variável objeto recordset
Dim txtCampo(0) As New FormataCampos, vgPriVez As Boolean
Dim vgFiltroSelecionado As String, vgOrdemSelecionada As String
Dim vgPv As Boolean, vgSecaoIni As String

'clicou no botão cancela
Private Sub botCancela_Click()
   vgFiltroAtual$ = vgForm.vgUltimoFiltro         'volta filtro anterior
   vgFiltroAtualComTit$ = vgForm.vgUltimoFiltroComTit
   vgOrdemAtual$ = vgForm.vgUltimaOrdem           'volta ordem anterior
   vgOrdemAtualComTit$ = vgForm.vgUltimoFiltroComTit
   UnLoad Me                                      'descarrega este form da memória e
End Sub

'clicou no botão de concatenar expressões
Private Sub botConcatena_Click()
   Dim vgWh As String, x As String, vgPriOperando As String, vgSegOperando As String, _
       vgConector As String, vgTp As GCOLUMN_TYPE, k As String, _
       vgNCp As String , vgWhTit As String
   On Error GoTo DeuErro
   vgConector$ = cboOperador.Text
   If vgForm.vgTipo = TP_BROWSE Then
      Set vgTb = vgForm.grdBrowse.Recordset            'sim, carrega recordset e armazena nome do campo do combo
   End If
   vgNCp$ = vgTb.Table.Columns(cboCampos.itemData(cboCampos.ListIndex)).Name
   vgPriOperando$ = PoeColchetes$(vgNCp$)              'coloca colchetes em campos que contenham espaços no nome
   'troca apelido pelo valor rela da coluna
   vgPriOperando$ = TrocaAliasPelaExp(vgPriOperando$, vgForm.vgSQL)
   vgTp = vgTb.Table.Columns(vgNCp$).ColumnType        'sim, armazena o tipo do campo
   If (vgTp = TP_CARACTER Or vgTp = TP_MEMO) Then      'texto ou memo
      vgSegOperando$ = Chr$(39) + Substitui(txtCampo(0).Text, "'", "''", SO_UM) + Chr$(39) 'monta segundo operando com aspas
   ElseIf vgTp = TP_DATA_HORA Then                'se tipo data,
      If txtCampo(0).Text = "" Then               'e não tem segundo operando
         vgSegOperando$ = "Null"                  'a data pode estar nula
         If vgConector$ = "=" Then
            vgConector$ = "Is"
         Else
            vgConector$ = "Is Not"
         End If
      Else                                        'se não transforma para data
         vgSegOperando$ = "CDate('" + txtCampo(0).Text + "')" 'utiliza função de conversão
      End If
   ElseIf vgTp = TP_LOGICO Then                               'se tipo boolean
      vgSegOperando$ = CStr(txtCampo(0).Text)                 'utiliza puramente o que estiver no texto
   Else                                           'qq outro tipo,
      vgSegOperando$ = CStr(txtCampo(0).Value)    'utiliza puramente o que estiver no texto
      vgSegOperando$ = Substitui$(vgSegOperando$, ",", ".", SO_UM)
   End If
   vgWh$ = vgFiltroAtual$                         'pega o que estiver no campo,
   vgWhTit$ = vgFiltroAtualComTit$
   If Len(vgWh$) > 0 Then                         'se há algo
      If opcAndOr(0).Value Then                   'se opção AND selecionada,
         x$ = " AND ("                            'monta o que vamos concatenar...
         k$ = " " + LoadGasString(6050) + " ("
      Else                                        'senão,
         x$ = " OR "                              'OR está selecionado - monta o que vamos concatenar
         k$ = " " + LoadGasString(6060) + " "
         If Right$(vgWh$, 1) = ")" Then           'se já terminar com fecha parênteses,
            vgWh$ = Left$(vgWh$, Len(vgWh$) - 1)  'retira este...
            vgWhTit$ = Left$(vgWhTit$, Len(vgWhTit$) - 1)
         Else                                     'senão,
            x$ = x$ + "("                         'concatena um parênteses abrindo
            k$ = k$ + "("
         End If
      End If
   Else
      x$ = "("                                    'senão, se não há texto, põe um parênteses abrindo
      k$ = "("
   End If
   vgFiltroAtual$ = vgWh$ + x$ + Trim$(vgPriOperando$ + " " + vgConector$ + " " + vgSegOperando$) + ")"
   vgFiltroAtualComTit$ = vgWhTit$ + k$ + Trim$(cboCampos.Text + " " + vgConector$ + " " + vgSegOperando$) + ")"
   vgFiltroSelecionado = vgFiltroAtual
   MostraFiltroOrdem                              'mostra filtragem e ordenção ja definidos
   cboCampos.ListIndex = -1                       'reinicializa objetos do
DeuErro:
   txtCampo(0).Text = ""                          'filtro
   If Err Then
      Err.Clear
      txtCampo(0).SetFocus
   Else
      txtCampo(0).Enabled = False                 'desabilita o campo segundo operando
   End If
End Sub

'mostra filtragem e ordenção ja definidos 
Private Sub MostraFiltroOrdem
   Dim x As String
   If Len(vgFiltroAtual$) > 0 Then                   'se tem filtro definido
      x$ = LoadGasString(141) + vbCrLf + vgFiltroAtualComTit$ 'filtro já definido
   End If
   If Len(vgOrdemAtual$) > 0 Then                             'se tem ordem definida          
      If Len(x$) > 0 Then                                     'e tem filtro 
         x$ = x$ + vbCrLf                                     'pula uma linha
      End If
      x$ = x$ + LoadGasString(142) + vbCrLf + vgOrdemAtualComTit$ 'ordem definida   
   End If
   txtCriterio.Text = x$                                          'mostra ao usuário o filtro/ordem atual

End Sub

'clicou sobre o botão de limpar a expressão
Private Sub botLimpa_Click()
   Dim i As Integer, x As String
   vgPriVez = True
   vgFiltroAtual$ = ""
   vgFiltroAtualComTit$ = ""
   vgOrdemAtual$ = ""
   vgOrdemAtualComTit$ = ""
   txtCriterio.Text = ""                             'limpa o que tem no campo da expressão,
   cboCampos.ListIndex = -1                          'retira seleção da combo de campos
   txtCampo(0).Text = ""                             'limpa o campo valor
   cboCampos.SetFocus                                'e põe o foco na combo de campos
   txtCampo(0).Enabled = False                       'desabilita o campo segundo operando
   vgFiltroSelecionado = ""
   vgOrdemSelecionada = ""
   vgSecaoIni$ = vgNomeEstacao$ + vgForm.Name + " - " 'nome do form (grupo)
   i = InStr(vgForm.Caption, Chr(160))
   If i > 0 Then
      vgSecaoIni$ = vgSecaoIni$ + Left(vgForm.Caption, i - 1) 'nome do form (grupo)
   Else
      vgSecaoIni$ = vgSecaoIni$ + vgForm.Caption
   End If
      
   If Not Vazio(CboFiltros.Text) Then
      i = 0
      Do
         i = i + 1
         x$ = PegaStrDoIni(vgSecaoIni$, "Nome Filtro " & i, vgNomeINI) 'pega nome da consulta do INI
      Loop Until x$ = CboFiltros.Text Or x$ = ""

      
         
      'vamos remontar a numeracao das consultas
      i = i + 1
      Do
         x$ = PegaStrDoIni(vgSecaoIni$, "Nome Filtro " & i, vgNomeINI) 'pega nome da consulta do INI
         If x$ <> "" Then                                              'se achou a consulta
            GravaNoIni vgSecaoIni$, "Nome Filtro " & i - 1, x$, vgNomeINI
            GravaNoIni vgSecaoIni$, "Filtro " & i - 1, PegaStrDoIni(vgSecaoIni$, "Filtro " & i, vgNomeINI), vgNomeINI
         End If
         If Not Vazio(x$) Then i = i + 1
      Loop Until x$ = ""
      GravaNoIni vgSecaoIni$, "Nome Filtro " & i - 1, vbNullString, vgNomeINI
      GravaNoIni vgSecaoIni$, "Filtro " & i - 1, vbNullString, vgNomeINI
   End If
   If Not Vazio(CboOrdem.Text) Then
      i = 0
      Do
         i = i + 1
         x$ = PegaStrDoIni(vgSecaoIni$, "Nome Ordem " & i, vgNomeINI)  'pega nome da consulta do INI
      Loop Until x$ = CboOrdem.Text Or x$ = ""
      
      GravaNoIni vgSecaoIni$, "Nome Ordem " & i, vbNullString, vgNomeINI
      GravaNoIni vgSecaoIni$, "Ordem " & i, vbNullString, vgNomeINI
      
      'vamos remontar a numeracao das consultas
      i = i + 1
      Do
         x$ = PegaStrDoIni(vgSecaoIni$, "Nome Ordem " & i, vgNomeINI)  'pega nome da consulta do INI
         If x$ <> "" Then                                              'se achou a consulta
            GravaNoIni vgSecaoIni$, "Nome Ordem " & i - 1, x$, vgNomeINI
            GravaNoIni vgSecaoIni$, "Ordem " & i - 1, PegaStrDoIni(vgSecaoIni$, "Ordem " & i, vgNomeINI), vgNomeINI
         End If
         If Not Vazio(x$) Then i = i + 1
      Loop Until x$ = ""
      
      GravaNoIni vgSecaoIni$, "Nome Ordem " & i - 1, vbNullString, vgNomeINI
      GravaNoIni vgSecaoIni$, "Ordem " & i - 1, vbNullString, vgNomeINI
               
   End If
   For i = 0 To lstCampoOrdem.ListCount - 1                            'desmarca todos os campos da ordenação
      lstCampoOrdem.Selected(i) = False
   Next
   vgPriVez = False
End Sub

'clicou no botão ok
Private Sub botOk_Click()
   AplicaFiltro vgForm, 0                         'Vamos aplicar Filtro
End Sub

Public Sub AplicaFiltro(F As Form, vgOq As Integer)
   'Valores para vgOq
   '0 Aplica Filtro a partir de janela de filtragem
   '1 Aplica filtro a partir da lista de filtros
   Dim i As Integer, x As String
   vgSecaoIni$ = vgNomeEstacao$ + F.Name + " - "  'nome do form (grupo)
   i = InStr(F.Caption, Chr(160))
   If i > 0 Then
      vgSecaoIni$ = vgSecaoIni$ + Left(F.Caption, i - 1) 'nome do form (grupo)
   Else
      vgSecaoIni$ = vgSecaoIni$ + F.Caption
   End If
   Select Case vgOq
      Case 0
         If botConcatena.Enabled Then botConcatena_Click 'força a concatenação
         If Not Vazio(CboFiltros.Text) Then
            i = 0
            Do
               i = i + 1
               x$ = PegaStrDoIni(vgSecaoIni$, "Nome Filtro " & i, vgNomeINI) 'pega nome da consulta do INI
            Loop Until x$ = CboFiltros.Text Or x$ = ""
            If F.vgTipo = TP_TABELA Then
               If Vazio(txtCriterio.Text) And Not Vazio(CboFiltros.Text) Then
                  F.vgFiltroEmUso = 0
               Else
                  F.vgFiltroEmUso = i 
               End If
            End If
            If Not Vazio(vgFiltroSelecionado) Or Not Vazio(vgFiltroAtual) Then
               GravaNoIni vgSecaoIni$, "Nome Filtro " & i, CboFiltros.Text, vgNomeINI
               GravaNoIni vgSecaoIni$, "Filtro " & i, IIf(Not Vazio(vgFiltroSelecionado), vgFiltroSelecionado, F.vgUltimoFiltro), vgNomeINI
               vgFiltroAtual$ = vgFiltroSelecionado
               vgFiltroAtualComTit$ = vgFiltroSelecionado
            End If
         End If
         If Not Vazio(CboOrdem.Text) Then
            i = 0
            Do
               i = i + 1
               x$ = PegaStrDoIni(vgSecaoIni$, "Nome Ordem " & i, vgNomeINI)  'pega nome da consulta do INI
            Loop Until x$ = CboOrdem.Text Or x$ = ""
            If Not Vazio(vgOrdemSelecionada) Or Not Vazio(vgOrdemAtual) Then
               GravaNoIni vgSecaoIni$, "Nome Ordem " & i, CboOrdem.Text, vgNomeINI
               GravaNoIni vgSecaoIni$, "Ordem " & i, IIf(Not Vazio(vgOrdemSelecionada), vgOrdemSelecionada, F.vgUltimaOrdem), vgNomeINI
               vgOrdemAtual$ = vgOrdemSelecionada
               vgOrdemAtualComTit$ = vgOrdemSelecionada
               vgOrdemAtual$ = vgOrdemSelecionada
            End If
         Else                                     'se não foi definido nome para a ordenação
            If Len(vgOrdemSelecionada$) > 0 And F.vgTipo = TP_TABELA Then 'verificamos se tem ordem definida
               vgOrdemAtual$ = vgOrdemSelecionada         
            End If
         End If
         UnLoad Me                                'e descarrega o form
      End Select
End Sub

Private Sub cboCampos_Click()
   txtCampo(0).Text = ""                            'apaga qualquer valor anterior
   txtCampo(0).Enabled = True                       'habilita o campo para digitar 2o. operando
   AjustaMascara True                               'enche combo de operadores
End Sub

Private Sub CboFiltros_Click()
   Dim x As String, i As Integer
   
   
   vgSecaoIni$ = vgNomeEstacao$ + vgForm.Name + " - "              'nome do form (grupo)
   i = InStr(vgForm.Caption, Chr(160))
   If i > 0 Then
      vgSecaoIni$ = vgSecaoIni$ + Left(vgForm.Caption, i - 1)      'nome do form (grupo)
   Else
      vgSecaoIni$ = vgSecaoIni$ + vgForm.Caption
   End If
   i = 0
   Do
      i = i + 1
      x$ = PegaStrDoIni(vgSecaoIni$, "Nome Filtro " & i, vgNomeINI) 'pega nome da consulta do INI
   Loop Until x$ = CboFiltros.Text Or x$ = ""

   vgFiltroSelecionado = PegaStrDoIni(vgSecaoIni$, "Filtro " & i, vgNomeINI) 'pega nome da consulta do INI
   vgFiltroAtual$ = vgFiltroSelecionado
   vgFiltroAtualComTit$ = vgFiltroSelecionado
   If Len(vgFiltroSelecionado) > 0 Then                                      'se tem filtro definido
      x$ = LoadGasString(141) + vbCrLf + vgFiltroSelecionado                 'filtro já definido
   End If
   If Len(vgOrdemSelecionada) > 0 Then                                       'se tem ordem definida
      If Len(x$) > 0 Then                         'e tem filtro
         x$ = x$ + vbCrLf                         'pula uma linha
      End If
      x$ = x$ + LoadGasString(142) + vbCrLf + vgOrdemSelecionada 'ordem definida
   End If
   txtCriterio.Text = x$
   
End Sub

Private Sub CboOrdem_Click()
   Dim x As String, i As Integer
   vgSecaoIni$ = vgNomeEstacao$ + vgForm.Name + " - "              'nome do form (grupo)
   i = InStr(vgForm.Caption, Chr(160))
   If i > 0 Then
      vgSecaoIni$ = vgSecaoIni$ + Left(vgForm.Caption, i - 1)      'nome do form (grupo)
   Else
      vgSecaoIni$ = vgSecaoIni$ + vgForm.Caption
   End If
   i = 0
   Do
      i = i + 1
      x$ = PegaStrDoIni(vgSecaoIni$, "Nome Ordem " & i, vgNomeINI) 'pega nome da consulta do INI
   Loop Until x$ = CboOrdem.Text Or x$ = ""
   vgOrdemSelecionada = PegaStrDoIni(vgSecaoIni$, "Ordem " & i, vgNomeINI) 'pega nome da consulta do INI
   vgOrdemAtual$ = vgFiltroSelecionado
   vgOrdemAtualComTit$ = vgFiltroSelecionado
   If Len(vgFiltroSelecionado) > 0 Then                                    'se tem filtro definido
      x$ = LoadGasString(141) + vbCrLf + vgFiltroSelecionado               'filtro já definido
   End If
   If Len(vgOrdemSelecionada) > 0 Then                                     'se tem ordem definida
      If Len(x$) > 0 Then                                                  'e tem filtro
         x$ = x$ + vbCrLf                                                  'pula uma linha
      End If
      x$ = x$ + LoadGasString(142) + vbCrLf + vgOrdemSelecionada           'ordem definida
   End If
   txtCriterio.Text = x$
   
End Sub

Private Sub cboOperador_Click()
   AjustaMascara False                              'ajusta máscara do 2o. operador
End Sub

'ajusta mascara 2o. operador e enche combo de operadores
Private Sub AjustaMascara(EncheOper As Integer)
   Dim vgTp As GCOLUMN_TYPE, x As String, vgNCp As String   'dimensiona o que precisamos
   If cboCampos.ListIndex >= 0 Then                         'se algo selecionado,
      vgNCp$ = vgTb.Table.Columns(cboCampos.ItemData(cboCampos.ListIndex)).Name
      vgTp = vgTb.Table.Columns(vgNCp$).ColumnType
      x$ = vgTb.Table.Columns(vgNCp$).Mask

      'campo texto com mais de 300 caracteres considera como memo
      If EncheOper Then                                     'encher combo de operadores?
         EncheOperadores cboOperador, (vgTp = TP_CARACTER Or vgTp = TP_MEMO) 'se for campo texto ou memo, vai ter o LIKE
      End If
      If cboOperador.Text = "LIKE" Or vgTp = TP_MEMO Then                    'operador LIKE escolhido ou cp Memo?
         txtCampo(0).MaxLength = 254                                         'libera todo o campo
         x$ = ""                                  'e não tem máscara
         txtCampo(0).DataType = 0                 'tido de dado digitado será caracter
         txtCampo(0).StuffChar = ""               'não ajusta a esquerda
      ElseIf vgTp = TP_CARACTER Then              'é texto?
         txtCampo(0).MaxLength = vgTb.Table.Columns(vgNCp$).Size 'tamanho do campo a digitar
         txtCampo(0).DataType = 0                                'tido de dado digitado será caracter
         If x$ = String$(Len(x$), "9") Then                      'se máscara tudo 9
            txtCampo(0).StuffChar = "0"                          'ajusta com 0 a esquerda
         ElseIf x$ = String$(Len(x$), "#") Then                  'se máscara tudo #
            txtCampo(0).StuffChar = " "                          'ajusta com brancos a esquerda
         Else                                     'caso contrario
            txtCampo(0).StuffChar = ""            'não ajusta a esquerda
         End If
      ElseIf vgTp = TP_LOGICO Then
         txtCampo(0).MaxLength = 2                'tamanho da digitação = tamanho da máscara
         txtCampo(0).StuffChar = ""               'não ajusta a esquerda
         txtCampo(0).DataType = 1
         x$ = "99"
      Else
         txtCampo(0).MaxLength = Len(x$)          'tamanho da digitação = tamanho da máscara
         txtCampo(0).StuffChar = ""               'não ajusta a esquerda
         If vgTp = TP_DATA_HORA Then              'se for data
            txtCampo(0).DataType = 2
         Else                                     'se for número
            txtCampo(0).DataType = vgTp
         End If
      End If
      txtCampo(0).Mask = x$                       'coloca máscara no controle
   End If
   txtCp_Change 0                                 'força ajuste de opções de concatenação
End Sub

Public Sub EncheLista(vgCt As Object, F As Form, QualLista As Integer, Optional vgLimpa = True)
   Dim vgCont As Integer, vgContSQL As Integer, x As String, _
       i As Integer, vgExpSQL As String, k As String, y As String
   If vgLimpa Then vgCt.Clear
   vgCont = 0
   'vgContSQL = 0
   vgSecaoIni$ = vgNomeEstacao$ + F.Name + " - "         'nome do form (grupo)
   i = InStr(F.Caption, Chr(160))
   If i > 0 Then
      vgSecaoIni$ = vgSecaoIni$ + Left(F.Caption, i - 1) 'nome do form (grupo)
   Else
      vgSecaoIni$ = vgSecaoIni$ + F.Caption
   End If
   Select Case QualLista
      Case 0                                             'filtro
         Do
            vgCont = vgCont + 1                          'Incrementa o contador
            vgExpSQL$ = ""
            x$ = PegaStrDoIni(vgSecaoIni$, "Nome Filtro " & vgCont, vgNomeINI) 'pega nome da consulta do INI
            If x$ <> "" Then                      'se conseguiu pegar uma consulta
               vgContSQL = 0                      'zera contador SQL
               vgCt.AddItem x$                    'coloca no topo da lista
            End If
         Loop Until x$ = ""
         vgCont = 0
      Case 1                                      'Ordem
         Do
            vgCont = vgCont + 1                   'Incrementa o contador
            x$ = PegaStrDoIni(vgSecaoIni$, "Nome Ordem " & vgCont, vgNomeINI) 'pega nome da consulta do INI
            k$ = PegaStrDoIni(vgSecaoIni$, "Ordem " & vgCont, vgNomeINI)      'pega nome da consulta do INI
            If x$ <> "" Then                                                  'se conseguiu pegar uma consulta
               y$ = y$ + "|*" + k$
               vgCt.AddItem x$                                                'coloca no topo da lista
            End If
         Loop Until x$ = ""
   End Select
End Sub

'inicializa tabela do filtro
Public Sub IniciaTabDoFiltro(F As Form, vgRs As GRecordSet)
   Dim i As Integer, j As Long, vgNCp As String, vgTitCp As String
   cboCampos.Clear                                    'limpa combobox de campos
   lstCampoOrdem.Clear                                'lista de ordenação
   Set vgForm = F
   Set vgTb = vgRs                                    'inicializa o objeto com que vamos trabalhar
   vgPriVez = True                                    'evita recursividade
   For i = 1 To vgTb.Table.Columns.Count              'sim, corre campos para adicionar ao combo de campos e lista de campos para ordem
      vgNCp$ = vgTb.Table.Columns(i).Name             'nome do campo
      'imagem ou campo invisivel não pode
      If vgTb.Table.Columns(i).ColumnType <> TP_BINARIO And vgTb.Table.Columns(i).Hidden = False And vgTb.Table.Columns(i).System = False Then 
         vgTitCp$ = vgTb.Table.Columns(i).Title       'titulo do campo
         cboCampos.AddItem vgTitCp$                   'coloca na cbo de cps que podem ser filtrados
         cboCampos.ItemData(cboCampos.NewIndex) = i   'numero do campo dentro da tabela
         lstCampoOrdem.AddItem vgTitCp$               'lsta de campos para ordenação
         lstCampoOrdem.ItemData(lstCampoOrdem.NewIndex) = i - 1 'numero do campo dentro da tabela
         If Len(vgOrdemAtual$) > 0 Then
            j = PosiDoNome(", " + vgOrdemAtual$ + ",", ", " + vgNCp$ + ",", False)
            If j = 0 Then                                       'tenta decrescente
               j = PosiDoNome(", " + vgOrdemAtual$ + ",", ", " + vgNCp$ + " DESC" + ",", False)
            End If
            If j > 0 Then lstCampoOrdem.Selected(lstCampoOrdem.NewIndex) = True
         End If
      End If
   Next
   MostraFiltroOrdem                                            'mostra filtragem e ordenção ja definidos
   vgPriVez = False
   EncheLista CboFiltros, vgForm, 0
   EncheLista CboOrdem, vgForm, 1
End Sub

'Ah VB!!! Para VB 5.0, não sabemos porque, o Activate do form está sendo disparado
'quando a combo-box de campos é aberta...
Private Sub Form_Activate()
   If vgPv Then                                       'se é primeira vez
      txtCampo(0).Enabled = False                     'desabilita o controle Valor
      vgPv = False                                    'reseta flag
   Else                                               'senão, habilita 
      txtCampo(0).Enabled = (cboCampos.ListIndex >= 0) 'se houver um campo selecionado na combo
   End If
End Sub

Private Sub Form_Unload(Cancel As Integer)
   Dim i As Integer
   Set vgTooltips = Nothing
   Set vgTb = Nothing
   Set vgForm = Nothing
   For i = 0 to UBound(txtCampo)
      txtCampo(i).Finalize
      Set txtCampo(i) = Nothing
   Next 
   Set frmFiltra = Nothing                        'libera o segmento de código do form
End Sub

Private Sub Form_Load()
   vgCaracteristica = F_COMUM
   vgSituacao = ACAO_NAVEGANDO
   vgTipo = TP_COMUM                              'seu tipo
   vgFormID = 15                                  'identificacao do form
   vgPv = True                                    'Flag para habilitar/desabilitar txtCampo(0) = Campo do Valor
   Screen.MousePointer = vbHourglass              'mouse = ampulheta
   vgCaracteristica = F_COMUM                     'designa característica do form
   Caption = LoadGasString(6000)                  'carrega título do form
   labNomeCampo.Caption = LoadGasString(6020)     'ajusta o texto do label nome do campo,
   labOperador.Caption = LoadGasString(6030)      'operador,
   labValor.Caption = LoadGasString(6040)         'valor,
   opcAndOr(0).Caption = LoadGasString(6050)      'AND,
   opcAndOr(1).Caption = LoadGasString(6060)      'OR,
   botConcatena.Caption = LoadGasString(6070)     'concatena
   labCriterio.Caption = LoadGasString(6080)      'critério de pesquisa
   fraOrdenacao.Caption = LoadGasString(6122)     'ordenação
   opcOrdem(0).Caption = LoadGasString(6123)      'ascendente
   opcOrdem(1).Caption = LoadGasString(6124)      'descendente
   labOrdem.Caption = LoadGasString(6125)         'Ordenado por...

   Set txtCampo(0).CtPri = txtCp(0)
   vgPriVez = True

   'prepara texto de ajuda para os objetos
   vgTooltips.Create 
   vgTooltips.AddTool botCancela, 0, LoadGasString(6090) 'botão de cancela,
   vgTooltips.AddTool botConcatena, 0, LoadGasString(6100) 'botão de concatenar
   vgTooltips.AddTool botLimpa, 0, LoadGasString(6110)     'botão de limpar
   vgTooltips.AddTool botOk, 0, LoadGasString(6120)        'botão ok,
   vgTooltips.AddTool cboCampos, 0, LoadGasString(6130)    'label do nome do campo,
   vgTooltips.AddTool cboOperador, 0, LoadGasString(6140)  'operador,
   vgTooltips.AddTool opcAndOr(0), 0, LoadGasString(6150)  'opções AND
   vgTooltips.AddTool opcAndOr(1), 0, LoadGasString(6150)  'e OR,
   vgTooltips.AddTool txtCampo(0).CtPri, 0, LoadGasString(6160) 'texto valor
   vgTooltips.AddTool lstCampoOrdem, 0, LoadGasString(6162)
   vgTooltips.AddTool opcOrdem(0), 0, LoadGasString(6164)
   vgTooltips.AddTool opcOrdem(1), 0, LoadGasString(6166)

   ' coloca icones nos botoes
   Set botOk.Picture = LoadPicture(LoadGasPicture(175))         'botão ok
   Set botCancela.Picture = LoadPicture(LoadGasPicture(185))    'cancela
   Set botLimpa.Picture = LoadPicture(LoadGasPicture(180))      'limpa
   CentraNaTela Me                                              'centraliza o form na tela
   vgPriVez = False
   Screen.MousePointer = vbDefault                              'restaura o ponteiro do mouse
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyEscape Then                 'se teclou ESC
      Unload Me                                   'tira este form da memória
   End If
End Sub

Private Sub txtCp_Change(Index As Integer)
   txtCampo(Index).Change
   If botConcatena.Enabled <> (cboCampos.ListIndex >= 0) Then 
      botConcatena.Enabled = (cboCampos.ListIndex >= 0)          'se status diferente, muda
   End If 
End Sub

Private Sub txtCp_GotFocus(Index As Integer)
   txtCampo(Index).GotFocus
End Sub

Private Sub txtCp_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
   txtCampo(Index).KeyDown KeyCode, Shift
End Sub

Private Sub txtCp_KeyPress(Index As Integer, KeyAscii As Integer)
   If KeyAscii = 124 Then KeyAscii = 0
   txtCampo(Index).KeyPress KeyAscii
End Sub

Private Sub txtCp_LostFocus(Index As Integer)
   txtCampo(Index).LostFocus
End Sub

Private Sub txtCp_MouseDown(Index As Integer, Button As Integer, Shift As Integer, x As Single, y As Single)
   txtCampo(Index).MouseDown
End Sub

'alteração no critério de pesquisa
Private Sub txtCriterio_Change()
   Dim i As Integer                               'dimensiona local
   i = (Len(vgFiltroAtual$) > 0)                  'verifica se tem texto no critério de seleção,
   If fraAndOr.Enabled <> i Then                  'e, ajusta visibilidade, se necessário,
      fraAndOr.Enabled = i                        'do frame de concatenação e
      opcAndOr(0).Enabled = i                     'das opções AND
      opcAndOr(1).Enabled = i                     'e OR
   End If
End Sub

'manipula tecla pressinada no campo de critério
Private Sub txtCriterio_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyDelete Then                  'se pressionou DEL,
      KeyCode = 0                                 'anula - estamos negando edição
   End If
End Sub

Private Sub txtCriterio_KeyPress(KeyAscii As Integer)
   KeyAscii = 0                                   'anula a tecla pressionada - estamos negando edição deste campo
End Sub

'ordem dos registros do filtro
Private Sub lstCampoOrdem_Click()
   Dim vgNCp As String
   If vgPriVez = False Then                       'evita recursividade
      vgNCp$ = PoeColchetes$(vgTb.Fields(lstCampoOrdem.ItemData(lstCampoOrdem.ListIndex)).Name)
      
      'troca apelido pelo valor rela da coluna
      vgNCp$ = TrocaAliasPelaExp(vgNCp$, vgForm.vgSQL)
      If lstCampoOrdem.Selected(lstCampoOrdem.ListIndex) = False Then 'estava SELECIONADO
         vgOrdemAtual$ = TiraCampoDaOrdem(vgOrdemAtual$, vgNCp$)      'então retira
         vgOrdemAtualComTit$ = TiraCampoDaOrdem(vgOrdemAtualComTit$, lstCampoOrdem.Text) 'então retira
      Else                                        'não,
         If Len(vgOrdemAtual$) > 0 Then           'se já tem algo definido
            vgOrdemAtual$ = vgOrdemAtual$ + ", "  'coloca o separador de campos         
            vgOrdemAtualComTit$ = vgOrdemAtualComTit$ + ", " 
         End If 
         vgOrdemAtual$ = vgOrdemAtual$ + vgNCp$   'coloca-lo
         vgOrdemAtualComTit$ = vgOrdemAtualComTit$ + lstCampoOrdem.Text
         If opcOrdem(1).Value Then                'é descendente
            vgOrdemAtual$ = vgOrdemAtual$ + " DESC" 'concatena sufixo
            vgOrdemAtualComTit$ = vgOrdemAtualComTit$ + " DESC"
         End If
      End If
      MostraFiltroOrdem                             'mostra filtragem e ordenção ja definidos 
      vgOrdemSelecionada = vgOrdemAtual
   End If
End Sub

Private Function TiraCampoDaOrdem(vgOrdem As String, vgNome As String) As String
   Dim i As Integer, j As Integer, k As String, vgExp As String
   vgExp$ = vgOrdem$ 

TiraOutro:
   i = PosiDoNome(", " + vgExp$ + ",", ", " + vgNome$ + ",", False)
   If i = 0 Then                                     'tenta decrescente
      i = PosiDoNome(", " + vgExp$ + ",", ", " + vgNome$ + " DESC" + ",", False)
   End If
   
   If i > 0 And Len(vgExp$) > 0 And Len(vgNome$) > 0 Then
      If i > 2 Then i = i - 1                        'ajusta carcter colocado para pesquisa
      j = InStr(i, vgExp$ + ",", ",")
      If j > 0 Then                                  'se encontrou um provável separador de campos

         'vamos ver se "," está entre parenteses ( ...  ,  ... )
         Do While j > 0
            k$ = Mid$(vgExp$, i, j - i)
            If Tally(k$, "(") <> Tally(k$, ")") Then
               j = InStr(j + 1, vgExp$, ",")
            Else
               Exit Do
            End If
         Loop
      End If
      If j = 0 Then
         j = Len(vgExp$) + 1
      End If
      
      vgExp$ = Trim$(Left$(vgExp$, i - 1) + Mid$(vgExp$, j + 1))
      If Right$(vgExp$, 1) = "," Then vgExp$ = Left$(vgExp$, Len(vgExp$) - 1)
      GoTo TiraOutro
   End If
   TiraCampoDaOrdem = vgExp$
End Function
