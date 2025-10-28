Version 5.00
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "TABCTL32.OCX"
Begin VB.Form frmMontaSQL
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "MONTAGEM de consulta SQL"
   ClientHeight    =   5175
   ClientLeft      =   720
   ClientTop       =   1710
   ClientWidth     =   8070
   ControlBox      =   0   'False
   KeyPreview      =   -1  'True
   LinkTopic       =   "frmMontaSQL"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5175
   ScaleWidth      =   8070
   ShowInTaskbar   =   0   'False
   Begin NFE.GBotao botLimpa 
      Height          =   420
      Left            =   6630
      TabIndex        =   24
      Top             =   60
      Width           =   450
      ForeColor       =   -2147483640
   End
   Begin NFE.GBotao botGrava 
      Height          =   420
      Left            =   7080
      TabIndex        =   25
      Top             =   60
      Width           =   450
      ForeColor       =   -2147483640
      Enabled         =   0   'False
   End
   Begin NFE.GBotao botRetorna 
      Height          =   420
      Left            =   7530
      TabIndex        =   26
      Top             =   60
      Width           =   450
      ForeColor       =   -2147483640
   End
   Begin VB.CheckBox chkPermitirATodos 
      Caption         =   "Permitir..."
      Height          =   195
      Left            =   90
      TabIndex        =   29
      Top             =   4920
      Width           =   4035
   End
   Begin TabDlg.SSTab tabMonta 
      Height          =   2925
      Left            =   60
      TabIndex        =   7
      Top             =   510
      Width           =   7935
      _ExtentX        =   13996
      _ExtentY        =   5159
      _Version        =   393216
      Style           =   1
      TabsPerRow      =   5
      TabHeight       =   520
      TabCaption(0)   =   "Conteúdos"
      Tab(0).ControlEnabled=   -1  'True
      Tab(0).Control(0)=   "labTabelas"
      Tab(0).Control(0).Enabled=   0   'False
      Tab(0).Control(1)=   "labCamposMostrar"
      Tab(0).Control(1).Enabled=   0   'False
      Tab(0).Control(2)=   "lstTabelas"
      Tab(0).Control(2).Enabled=   0   'False
      Tab(0).Control(3)=   "lstCamposMostrar"
      Tab(0).Control(3).Enabled=   0   'False
      Tab(0).Control(4)=   "fraFunc"
      Tab(0).Control(4).Enabled=   0   'False
      Tab(0).ControlCount=   5
      TabCaption(1)   =   "Grupos e ordenação"
      Tab(1).ControlEnabled=   0   'False
      Tab(1).Control(0)=   "labCampoGrupo"
      Tab(1).Control(1)=   "labCampoOrdem"
      Tab(1).Control(2)=   "lstCampoGrupo"
      Tab(1).Control(3)=   "lstCampoOrdem"
      Tab(1).Control(4)=   "fraOrdenacao"
      Tab(1).ControlCount=   5
      TabCaption(2)   =   "Seleção"
      Tab(2).ControlEnabled=   0   'False
      Tab(2).Control(0)=   "fraTop"
      Tab(2).Control(1)=   "fraFiltragem"
      Tab(2).ControlCount=   2
      Begin VB.frame fraFunc 
         Caption         =   "Coluna avulsa"
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            StrikeThrough   =   0   'False
         EndProperty
         Height          =   855
         Left            =   120
         TabIndex        =   42
         Top             =   2010
         Width           =   7665
         Begin VB.CommandButton botConcaFunc 
            Enabled         =   0   'False
            Height          =   450
            Left            =   7110
            Style           =   1  'Graphical
            TabIndex        =   6
            Top             =   330
            Width           =   450
         End
         Begin VB.ComboBox cboFunc 
            BackColor       =   &H00FFFFFF&
            Enabled         =   0   'False
            Height          =   315
            Left            =   150
            Style           =   2  'Dropdown List
            TabIndex        =   3
            Top             =   450
            Width           =   1785
         End
         Begin VB.TextBox txtTitCol 
            Height          =   315
            Left            =   5280
            TabIndex        =   5
            Top             =   450
            Width           =   1755
         End
         Begin VB.ComboBox cboCampoFunc 
            Height          =   315
            Left            =   2010
            TabIndex        =   4
            Top             =   450
            Width           =   3195
         End
         Begin VB.Label labFunc 
            AutoSize        =   -1  'True
            Caption         =   "Função"
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               StrikeThrough   =   0   'False
            EndProperty
            Height          =   195
            Left            =   150
            TabIndex        =   45
            Top             =   240
            Width           =   1815
         End
         Begin VB.Label LabCampoFunc 
            AutoSize        =   -1  'True
            Caption         =   "Nome do campo"
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               StrikeThrough   =   0   'False
            EndProperty
            Height          =   195
            Left            =   2040
            TabIndex        =   44
            Top             =   240
            Width           =   2775
         End
         Begin VB.Label labTitCol 
            AutoSize        =   -1  'True
            Caption         =   "Título"
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               StrikeThrough   =   0   'False
            EndProperty
            Height          =   195
            Left            =   5280
            TabIndex        =   43
            Top             =   240
            Width           =   435
         End
      End
      Begin VB.frame fraOrdenacao 
         Caption         =   "Ordenação"
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            StrikeThrough   =   0   'False
         EndProperty
         Height          =   675
         Left            =   -70980
         TabIndex        =   34
         Top             =   2040
         Width           =   3765
         Begin VB.OptionButton opcOrdem 
            Caption         =   "&Ascendente"
            Enabled         =   0   'False
            Height          =   255
            Index           =   1
            Left            =   1980
            TabIndex        =   10
            Top             =   300
            Width           =   1455
         End
         Begin VB.OptionButton opcOrdem 
            Caption         =   "&Descendente"
            Enabled         =   0   'False
            Height          =   255
            Index           =   0
            Left            =   270
            TabIndex        =   9
            Top             =   300
            Value           =   -1  'True
            Width           =   1485
         End
      End
      Begin VB.ListBox lstCampoOrdem 
         BackColor       =   &H00FFFFFF&
         Height          =   1230
         Left            =   -70980
         MultiSelect     =   1  'Simple
         TabIndex        =   11
         Top             =   690
         Width           =   3765
      End
      Begin VB.ListBox lstCampoGrupo 
         BackColor       =   &H00FFFFFF&
         Height          =   2010
         Left            =   -74880
         MultiSelect     =   1  'Simple
         TabIndex        =   8
         Top             =   690
         Width           =   3765
      End
      Begin VB.frame fraTop 
         Caption         =   "Os primeiros..."
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            StrikeThrough   =   0   'False
         EndProperty
         Height          =   795
         Left            =   -74910
         TabIndex        =   41
         Top             =   390
         Width           =   7755
         Begin VB.OptionButton OpcTop 
            Caption         =   "&Porcento"
            Enabled         =   0   'False
            Height          =   375
            Index           =   1
            Left            =   5130
            TabIndex        =   14
            Top             =   330
            Width           =   1155
         End
         Begin VB.OptionButton OpcTop 
            Caption         =   "&Registros"
            Enabled         =   0   'False
            Height          =   375
            Index           =   0
            Left            =   3060
            TabIndex        =   13
            Top             =   330
            Value           =   -1  'True
            Width           =   1155
         End
         Begin VB.TextBox txtTop 
            Height          =   285
            Left            =   1440
            TabIndex        =   12
            Top             =   330
            Width           =   735
         End
      End
      Begin VB.frame fraFiltragem 
         Caption         =   "Seleção de registros/união de tabelas"
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            StrikeThrough   =   0   'False
         EndProperty
         Height          =   1515
         Left            =   -74910
         TabIndex        =   36
         Top             =   1290
         Width           =   7755
         Begin NFE.GBotao botTiraFiltro 
            Enabled         =   0   'False
            Height          =   450
            Left            =   3840
            TabIndex        =   23
            Top             =   270
            Width           =   450
            ForeColor       =   -2147483640
         End
         Begin NFE.GBotao botConcatena 
            Height          =   435
            Left            =   6510
            TabIndex        =   22
            Top             =   270
            Width           =   1185
            Enabled         =   0   'False
            Caption         =   "&Concatena"
         End
         Begin VB.OptionButton opcFiltro 
            Caption         =   "Filtrar"
            Enabled         =   0   'False
            Height          =   255
            Index           =   0
            Left            =   120
            TabIndex        =   15
            Top             =   330
            Value           =   -1  'True
            Width           =   1755
         End
         Begin VB.OptionButton opcFiltro 
            Caption         =   "&Unir tabelas"
            Enabled         =   0   'False
            Height          =   255
            Index           =   1
            Left            =   1860
            TabIndex        =   16
            Top             =   330
            Width           =   1515
         End
         Begin VB.frame fraAndOr 
            Enabled         =   0   'False
            Height          =   495
            Left            =   4380
            TabIndex        =   37
            Top             =   210
            Width           =   2115
            Begin VB.OptionButton opcAndOr 
               Caption         =   "&Ou..."
               Enabled         =   0   'False
               Height          =   315
               Index           =   1
               Left            =   1140
               TabIndex        =   21
               Top             =   120
               Width           =   735
            End
            Begin VB.OptionButton opcAndOr 
               Caption         =   "&E..."
               Enabled         =   0   'False
               Height          =   315
               Index           =   0
               Left            =   180
               TabIndex        =   20
               Top             =   120
               Value           =   -1  'True
               Width           =   675
            End
         End
         Begin VB.ComboBox cboValor 
            BackColor       =   &H00FFFFFF&
            Enabled         =   0   'False
            Height          =   315
            Left            =   4500
            TabIndex        =   19
            Top             =   1080
            Width           =   3195
         End
         Begin VB.ComboBox cboOperador 
            BackColor       =   &H00FFFFFF&
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               StrikeThrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   3480
            Style           =   2  'Dropdown List
            TabIndex        =   18
            Top             =   1080
            Width           =   855
         End
         Begin VB.ComboBox cboCampos 
            BackColor       =   &H00FFFFFF&
            Enabled         =   0   'False
            Height          =   315
            Left            =   60
            Style           =   2  'Dropdown List
            TabIndex        =   17
            Top             =   1080
            Width           =   3255
         End
         Begin VB.Label labOperador 
            AutoSize        =   -1  'True
            Caption         =   "Operadores"
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               StrikeThrough   =   0   'False
            EndProperty
            Height          =   195
            Left            =   3480
            TabIndex        =   40
            Top             =   840
            Width           =   915
         End
         Begin VB.Label labValor 
            AutoSize        =   -1  'True
            Caption         =   "Valor"
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               StrikeThrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   4500
            TabIndex        =   39
            Top             =   840
            Width           =   3030
         End
         Begin VB.Label labNomeCampo 
            AutoSize        =   -1  'True
            Caption         =   "Nome do campo"
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               StrikeThrough   =   0   'False
            EndProperty
            Height          =   195
            Left            =   60
            TabIndex        =   38
            Top             =   840
            Width           =   2835
         End
      End
      Begin VB.ListBox lstCamposMostrar 
         BackColor       =   &H00FFFFFF&
         Height          =   1230
         Left            =   4020
         MultiSelect     =   1  'Simple
         TabIndex        =   2
         Top             =   690
         Width           =   3765
      End
      Begin VB.ListBox lstTabelas 
         BackColor       =   &H00FFFFFF&
         Height          =    1230
         Left            =   120
         TabIndex        =   1
         Top             =   690
         Width           =   3765
      End
      Begin VB.Label labCampoOrdem 
         AutoSize        =   -1  'True
         Caption         =   "Ordenado por..."
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            StrikeThrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   -70980
         TabIndex        =   46
         Tag             =   ""
         Top             =   450
         Width           =   3420
      End
      Begin VB.Label labCampoGrupo 
         AutoSize        =   -1  'True
         Caption         =   "Agrupar por..."
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            StrikeThrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   -74880
         TabIndex        =   35
         Tag             =   ""
         Top             =   450
         Width           =   2835
      End
      Begin VB.Label labCamposMostrar 
         AutoSize        =   -1  'True
         Caption         =   "Campos a mostrar"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            StrikeThrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   4020
         TabIndex        =   33
         Top             =   480
         Width           =   2115
      End
      Begin VB.Label labTabelas 
         AutoSize        =   -1  'True
         Caption         =   "Tabelas"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            StrikeThrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   120
         TabIndex        =   32
         Top             =   450
         Width           =   1650
      End
   End
   Begin VB.TextBox txtCriterio 
      Enabled         =   0   'False
      Height          =   1095
      Left            =   60
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   28
      Top             =   3750
      Width           =   7935
   End
   Begin VB.ComboBox cboNomeQuery 
      Height          =   315
      Left            =   2040
      Sorted          =   -1  'True
      TabIndex        =   0
      Top             =   60
      Width           =   4335
   End
   Begin VB.CheckBox chkExpSQL 
      Caption         =   "Visualizar..."
      Height          =   195
      Left            =   5100
      TabIndex        =   27
      Top             =   3510
      Width           =   2865
   End
   Begin VB.Label labCriterio 
      AutoSize        =   -1  'True
      Caption         =   "Expressão SQL que define o módulo"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         StrikeThrough   =   0   'False
      EndProperty
      Height          =   165
      Left            =   60
      TabIndex        =   31
      Top             =   3540
      Width           =   3210
   End
   Begin VB.Label labNomeQuery 
      Alignment       =   1  'Right Justify
      AutoSize        =   -1  'True
      Caption         =   "Nome da consulta"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         StrikeThrough   =   0   'False
      EndProperty
      Height          =   225
      Left            =   60
      TabIndex        =   30
      Top             =   120
      Width           =   1905
   End
End
Attribute VB_Name = "frmMontaSQL"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
'* Sistema...: Emissor de MDF-e (Layout 3.00)
'* Empresa...: Ygor Eduardo Dellalio
'* Módulo....: frmMontaSQL
'* Função....: Construtor de consultas SQL
'* CopyRight.: (C)2024 Ygor Eduardo Dellalio
'* Criação...: GAS-2007 - Gerador Automático de Sistemas
'* Data......: 05/09/2024 18:10:18
'* * * * * * *

Option Explicit                                   'variáveis explicictamente declaradas
DefInt A-Z                                        'por default, todas inteiras

Const CONFIRMA_GRAVACAO = 0                       'constantes para testar confirmação do usuário
Const NAO_CONFIRMA_GRAVACAO = 1

Public vgSituacao As Integer, vgCaracteristica As Integer, _
                     vgTipo As Integer, vgFormID As Long  'propriedades que todos os forms têm...
Public vgTooltips As New cTooltips

Dim vgExpSQL As String, vgFromAnterior As String      'dimensiona
Dim vgNaoEClick As Integer, vgModifQuery As Integer   'o que precisamos
Dim vgNomeSQL As String
Dim vgNovaCol As String, vgManual As Integer

' muda status do botão de gravação
Sub AtualizaBotGravacao(vgStatus As Integer)
   vgModifQuery = vgStatus                            'liga flag
   botGrava.Enabled = vgStatus                        'muda status do botão, de acordo
End Sub

' salva a expressão SQL
Private Function SalvaQuery(Confirmacao As Integer) As Integer
   Dim i As Integer, vgMsgErro As String, vgWh As String, vgOrd As String, vgQueryOrig As String, _
       vgRsTeste As GRecordSet, x As String, z As String, _
       vgUsuarioPermitido As String, vgSecaoIni As String, j As Integer
   vgUsuarioPermitido = IIf(chkPermitirATodos.Value = 1, "*TODOS*", vgPWUsuario$)
   vgSecaoIni$ = "CONSULTAS"
   SalvaQuery = True                                      'liga flag
   If vgModifQuery Then                                   'se modificou,
      i = vbYes                                           'prepara resposta default
      If Confirmacao = CONFIRMA_GRAVACAO Then             'se é para confirmar...
         i = MsgBox(LoadGasString(4400), vbQuestion + _
             vbYesNoCancel, vgAtencao$)
      End If                                              'solicita confirmação
      If i = vbYes Then                                   'se quer gravar
         If Len(vgNovaQuery$) = 0 Then                    'mas falta o título,
            SalvaQuery = False                            'retorna falso
            Beep                                          'apita
            MsgBox LoadGasString(4410), vbCritical, vgAtencao$ 'e avisa...
            cboNomeQuery.SetFocus                              'voltando o foco para o nome
         Else                                                  'se tem o nome
            On Error Resume Next                               'prepara para pegar erros
            Set vgRsTeste = vgDb(1).OpenRecordSet(vgExpSQL$, , , , , , , , , chkExpSQL.Value) 'cria dynaset da expressão,
            If Err = 0 Then                       'se não deu erro
               vgRsTeste.CloseRecordset           'fecha o dynaset
               i = 0
               Do
                  i = i + 1
                  x$ = PegaStrDoIni(vgSecaoIni$, "Nome da consulta " & i, vgConsultaINI$) 'pega nome da consulta do INI
               Loop Until x$ = vgNovaQuery$ Or x$=""
               If x$ = vgNovaQuery$ Then
                  GeraLogAcao LoadGasString(4520) + " " + vgNovaQuery$
               Else
                  GeraLogAcao LoadGasString(4525) + " " + vgNovaQuery$
               End If     
               GravaNoIni vgSecaoIni$, "Nome da consulta " & i, vgNovaQuery$, vgConsultaINI$
               GravaNoIni vgSecaoIni$, "Edicao " & i, CStr(vgManual), vgConsultaINI$
               vgWh$ = ExtraiSQL$(vgExpSQL$, EXP_WHERE, True)                             'cláusula "WHERE" existente
               vgOrd$ = ExtraiSQL$(vgExpSQL$, EXP_ORDERBY, True)                          'cláusula "ORDER BY" existente

               'grava filtro inicial da consulta
               z$ = vgWh$
               x$ = z$
               j = 0
               Do
                  j = j + 1
                  If Len(z$) > 120 Then
                     x$ = z$
                     z$ = Mid$(z$, 1, Rat(Mid(z$, 1, 120), " ") - 1)
                  End If
                  GravaNoIni vgSecaoIni$, "SQL Filtro Inicial " & i & "." & j, Trim(z$), vgConsultaINI$
                  x$ = Mid$(x$, Len(z$) + 1)
                  z$ = x$
               Loop Until x$ = ""

               'mata o restante do filtro inicial caso existam no INI para esta consulta
               Do
                  j = j + 1
                  x$ = PegaStrDoIni(vgSecaoIni$, "SQL Filtro Inicial " & i & "." & j, vgConsultaINI$) 'pega nome da consulta do INI
                  If x$ <> "" Then
                     GravaNoIni vgSecaoIni$, "SQL Filtro Inicial " & i & "." & j, vbNullString, vgConsultaINI$
                  End If
               Loop Until x$ = ""

               'grava ordem inicial da consulta
               z$ = vgOrd$
               x$ = z$
               j = 0
               Do
                  j = j + 1
                  If Len(z$) > 120 Then
                     x$ = z$
                     z$ = Mid$(z$, 1, Rat(Mid(z$, 1, 120), " ") - 1)
                  End If
                  GravaNoIni vgSecaoIni$, "SQL Ordem Inicial " & i & "." & j, Trim(z$), vgConsultaINI$
                  x$ = Mid$(x$, Len(z$) + 1)
                  z$ = x$
               Loop Until x$ = ""

               'mata o restante da ordem inicial caso existam no INI para esta consulta
               Do
                  j = j + 1
                  x$ = PegaStrDoIni(vgSecaoIni$, "SQL Ordem Inicial " & i & "." & j, vgConsultaINI$)
                  If x$ <> "" Then
                     GravaNoIni vgSecaoIni$, "SQL Ordem Inicial " & i & "." & j, vbNullString, vgConsultaINI$
                  End If
               Loop Until x$ = ""

               vgQueryOrig$ = vgExpSQL$           'salva expresão da consulta
               InsereClausula EXP_ORDERBY, ""     'tira clausulas da expressao
               InsereClausula EXP_WHERE, ""       'para gravar o restante
               j = 0
               x$ = Substitui(vgExpSQL$, vbCrLf, " ", SO_UM) 
               z$ = x$
               Do
                  j = j + 1
                  If Len(z$) > 120 Then
                     x$ = z$
                     z$ = Mid$(z$, 1, Rat(Mid(z$, 1, 120), " ") - 1)
                  End If
                  GravaNoIni vgSecaoIni$, "SQL " & i & "." & j, Trim(z$), vgConsultaINI$
                  x$ = Mid$(x$, Len(z$) + 1)
                  z$ = x$
               Loop Until x$ = ""

               'mata o restante de instruções SQL caso existam no INI para esta consulta
               Do
                  j = j + 1
                  x$ = PegaStrDoIni(vgSecaoIni$, "SQL " & i & "." & j, vgConsultaINI$) 'pega nome da consulta do INI
                  If x$ <> "" Then
                     GravaNoIni vgSecaoIni$, "SQL " & i & "." & j, vbNullString, vgConsultaINI$
                  End If
               Loop Until x$ = ""
               GravaNoIni vgSecaoIni$, "Usuário " & i, vgUsuarioPermitido$, vgConsultaINI$ 
               txtCriterio.Text = vgQueryOrig$                                         'mostra ao usuário
            End If
            If Err Then                           'deu erro de criação,
               If Err = 3012 Then                 'nome de query repetido
                  vgMsgErro$ = LoadGasString(4420) 'prepara a mensagem
               ElseIf Err = 3122 Then              'se nome inválido, prepara msg
                  vgMsgErro$ = LoadGasString(4430) + Left$(Error$, InStr(Error$, " ")) + _
                             LoadGasString(4440) + _
                             LoadGasString(4450) + _
                             LoadGasString(4460)
               Else                                'outros erros,
                  vgMsgErro$ = LoadGasString(4470) 'prepara mensagem
               End If
               Beep                                'apita
               MsgBox vgMsgErro$, vbExclamation, vgAtencao$ 'mostra mensagem
               SalvaQuery = False                           'prepara retorno falso
               cboNomeQuery.SetFocus                        'foco no nome da query
            Else                                            'senão, não deu erro...
               AtualizaBotGravacao False                    'ajusta o botão de gravar
            End If
         End If
      ElseIf i = vbCancel Then                              'se não confirmou,
         SalvaQuery = False                                 'retorna falso
      End If
   End If
End Function

'insere cláusula especificada dentro da exrpessão SQL
Private Sub InsereClausula(vgQual As Integer, ByVal vgOQueInserir As String)
   Dim vgEx As String, j As Integer, i As Integer, _
       k As String, x As String, vgCp As GColumn, C As String, _
       vgEncheuGrupo As Boolean, vgGrupo As String, vgOrdem As String, vgTitC As String

   vgEncheuGrupo = False
   vgEx$ = ""                                         'conterá toda a exp SQL
   vgOQueInserir$ = Trim$(vgOQueInserir$)             'cláusula a inserir
   For i = 0 To EXP_TODAS - 1                         'corre todas as cláusulas
      If i = vgQual Then                              'se for a que quer inserir
         x$ = vgOQueInserir$                          'substitui pela informada
      Else                                            'caso contrário
         x$ = ExtraiSQL$(vgExpSQL$, i, True)          'tira cláusula da própia exp SQL
      End If
      If Len(x$) Then                                 'se a cláusula existe
         If i = EXP_SELECT And Val(txtTop.Text) > 0 Then 'se for a "SELECT" e tem "TOP"
            x$ = "TOP " + LTrim$(txtTop.Text) + _
                 Left$(" PERCENT", 8 * -(OpcTop(1) = True)) + _
                 " " + x$                                'coloca na cláusula (incluido o "PERCENT")
         End If
         vgEx$ = vgEx$ + LTrim$(vgClausula$(i)) + x$ + vbCrLf 'e segue montando a nova exp SQL
      End If
   Next
   vgExpSQL$ = Trim$(vgEx$)                                   'esta é a nova exp SQL
   If chkExpSQL.Value = vbChecked Or vgManual = True Then
      txtCriterio.Text = vgExpSQL$                            'mostra ao usuário
   Else
      txtCriterio.Text = PoeTitulos$(vgExpSQL$)               'mostra ao usuário
   End If

   'se a cláusula modificada/inclusa foi a "FROM" ou remontou toda
   'a expressão SQL vamos aproveitar e reatualizar todos os controles
   'que depende destes arquivos selecionados
   If (vgQual = EXP_FROM Or vgQual = EXP_SELECT Or vgQual = EXP_TODAS) And _
      (vgOQueInserir$ <> vgFromAnterior$ Or Len(vgOQueInserir$) = 0) Then
      If InStr(UCase$(vgExpSQL$), LTrim$(vgClausula$(EXP_FROM))) > 0 Then
         vgOQueInserir$ = ExtraiSQL$(vgExpSQL$, EXP_FROM, True) 'extrai a cláusula "FROM"
      Else
         vgOQueInserir$ = ""
      End If
      vgOrdem$ = ExtraiSQL$(vgExpSQL$, EXP_ORDERBY, True)       'extrai ordem
      vgGrupo$ = ExtraiSQL$(vgExpSQL$, EXP_GROUPBY, True)       'e agrupadamentos
      cboCampos.Clear                                           'limpa combos de campos
      cboValor.Clear                                            'valores (filtragem)
      lstCampoOrdem.Clear                                       'e ordem
      lstCampoOrdem.Tag = ""
      cboCampos.Tag = ""
      cboValor.Tag = ""

      'funcoes agregadas
      cboCampoFunc.Clear									                               'limpa combo de campos de função agregada
      cboCampoFunc.Tag = ""
      txtTitCol.Text = ""									                              'limpa campo "Título da coluna", em funç
      
      'agrupamentos
      lstCampoGrupo.Clear                                       'agrupar registros...
      lstCampoGrupo.Tag = ""
      vgEncheuGrupo = True

      vgFromAnterior$ = vgOQueInserir$                          'salva cláusula "FROM"
      While Len(vgOQueInserir$) > 0                             'vamos pegar todos os arquivo da "FROM"
         x$ = Trim$(Parse$(vgOQueInserir$, ","))                'nome do arquivo
         For Each vgCp In vgDb.Tables(Retira$(x$, "[]", UM_A_UM)).Columns 'pega todos os campos do arqivo
            C$ = x$ + "." + PoeColchetes$(vgCp.Name)                      'prepara para inserir nas conbos...
            vgTitC$ = vgCp.Title  									                               'titulo do campo
            If vgCp.Hidden = False And vgCp.ColumnType <> TP_BINARIO Then 'campo invisível não pode...

               'se já tem um campo no primeiro operando (filtragem) vamos encher
               'o segundo operador com todos os outros campos menos com os campos
               'da tabela do primeiro operando (união entre tabelas)
               If Len(cboValor.Text) = 0 Or x$ <> Left$(cboValor.Text, InStr(cboValor.Text + ".", ".") - 1) Then
                  cboCampos.AddItem vgTitC$
                  cboCampos.Tag = cboCampos.Tag + "|" + C$
               End If

               'idem para encher a combo do primeiro operando...
               If Len(cboCampos.Text) = 0 Or x$ <> Left$(cboCampos.Text, InStr(cboCampos.Text + ".", ".") - 1) Then
                  cboValor.AddItem vgTitC$
                  cboValor.Tag = cboValor.Tag + "|" + C$
               End If 
               If vgCp.ColumnType <> TP_MEMO Then
                  lstCampoOrdem.AddItem vgTitC$                           'todos os campos valem na ordenação
                  lstCampoOrdem.Tag = lstCampoOrdem.Tag + "|" + C$
                  If PosiDoNome(vgOrdem$ + ",", C$ + ",", False) > 0 Or PosiDoNome(vgOrdem$ + ",", C$ + " DESC,", False) > 0 Then
                     vgNaoEClick = True
                     lstCampoOrdem.Selected(lstCampoOrdem.NewIndex) = True
                     vgNaoEClick = False
                  End If

                  'funcoes agregadas
                  cboCampoFunc.AddItem x$ + "->" + vgTitC$   			          'adicionando na combo de campos de função agregada a exibição como "Tabela->Campo"
                  cboCampoFunc.Tag = cboCampoFunc.Tag + "|" + C$		        'armazenamos na tag o nome real completo do campo como "[Nome da tabela].[Nome do campo]"
                  
                  cboCampoFunc.itemData(cboCampoFunc.ListCount - 1) = vgCp.Index
               
                  'lista de campos (grupos)
                  lstCampoGrupo.AddItem vgTitC$                           'todos os campos valem na ordenação
                  lstCampoGrupo.Tag = lstCampoGrupo.Tag + "|" + C$
                  If PosiDoNome(vgGrupo$ + ",", C$ + ",", False) > 0 Then
                     vgNaoEClick = True
                     lstCampoGrupo.Selected(lstCampoGrupo.NewIndex) = True
                     vgNaoEClick = False
                  End If
               End If
            End If
         Next
         Set vgCp = Nothing
      Wend
      cboCampoFunc.Tag = Mid$(cboCampoFunc.Tag, 2)
      cboCampos.Tag = Mid$(cboCampos.Tag, 2)
      cboValor.Tag = Mid$(cboValor.Tag, 2)
      i = (InStr(vgFromAnterior$, ",") > 0)                               'tem mais de uma tabela na cláusual "FROM"
      opcFiltro(1).Enabled = i                                            'só pode unir tabela se mais de 1
      If opcFiltro(1).Enabled = False And _
       opcFiltro(1).Value = True Then                                     'se não pode unir tabelas mas este
         opcFiltro(0).Value = True                                        'está marcado, desmarca
      End If
   End If

   'se a cláusula modificada/inclusa foi a "WHERE" ou remontou toda
   'a expressão SQL verificar se agora ja podemos deixa o usuário
   'concatenar com AND  e OR
   If vgQual = EXP_WHERE Or vgQual = EXP_TODAS Then
      If vgQual = EXP_TODAS Then                                          'retira exp "WHERE" se
         vgOQueInserir$ = ExtraiSQL$(vgExpSQL$, EXP_WHERE, True)          'remontou toda s SQL
      End If
      i = Len(vgOQueInserir$) > 0                                         'pode concatenar?
      If opcAndOr(0).Enabled <> i And opcFiltro(0).Value Then             'se pode e não esta
         fraAndOr.Enabled = i                                             'unindo tabela...
         opcAndOr(0).Enabled = i
         opcAndOr(1).Enabled = i
      End If
      If botTiraFiltro.Enabled <> i Then                                  'habilita/desabilita
         botTiraFiltro.Enabled = i                                        'botão para limpar
      End If                                      'exp "WHERE"
   End If

   'se a cláusula modificada/inclusa foi a "SELECT" ou remontou toda
   'a expressão SQL vamos aproveitar e habilitar/desabilitar todos os
   'controles que depende do numero de campos seleciondos
   If vgQual = EXP_SELECT Or vgQual = EXP_TODAS Then
      vgOQueInserir$ = ExtraiSQL$(vgExpSQL$, EXP_SELECT, True) 'extrai "SELECT"
      If Len(vgOrdem$) = 0 Then vgOrdem$ = ExtraiSQL$(vgExpSQL$, EXP_ORDERBY, True) 'extrai ordem
      If Len(vgGrupo$) = 0 Then vgGrupo$ = ExtraiSQL$(vgExpSQL$, EXP_ORDERBY, True) 'e agrupadamentos
      i = (Len(vgOQueInserir$) > 0 And vgManual = False)                            'habilitado ou não?
      If fraFiltragem.Enabled <> i Then                                             'se esta diferente do anterior
         lstCampoGrupo.Enabled = i                                                  'vamos habiliar ou
         lstCampoOrdem.Enabled = i                                                  'desabilitar todos
         cboCampos.Enabled = i                    'os controles que
         cboOperador.Enabled = i                  'não pode ser
         cboValor.Enabled = i                     'utilizados enquanto
         fraFiltragem.Enabled = i                 'não existir pelo
         fraOrdenacao.Enabled = i                 'menos um campo
         fraTop.Enabled = i                       'selecionado
         labCampoGrupo.Enabled = i
         labCampoOrdem.Enabled = i
         labNomeCampo.Enabled = i
         labOperador.Enabled = i
         labValor.Enabled = i
         txtTop.Enabled = i
         For j = 0 To 1
            opcFiltro(j).Enabled = i
            opcOrdem(j).Enabled = i
         Next

         'funcoes abregadas
         fraFunc.Enabled = i
         cboCampoFunc.Enabled = i
         cboFunc.Enabled = i
         labFunc.Enabled = i
         txtTitCol.Enabled = i
         labTitCol.Enabled = i
         LabCampoFunc.Enabled = i
         If i = False Then
            botConcaFunc.Enabled = i
         Else
            HabConcaFunc
         End If
      End If
      tabMonta.Enabled = (i Or vgManual = False)
      chkExpSQL.Enabled = (i Or vgManual = False)
      labCriterio.Enabled = (i Or vgManual = True)
      txtCriterio.Enabled = (i Or vgManual = True)
      lstTabelas.Enabled = (vgManual = False)
      lstCamposMostrar.Enabled = (vgManual = False)
      labTabelas.Enabled = (vgManual = False)
      labCamposMostrar.Enabled = (vgManual = False)
   End If

   'se esta enchendo os grupos coloca as colunas com funcoes agregadas
   If vgEncheuGrupo = True Then
      vgOQueInserir$ = ExtraiSQL$(vgExpSQL$, EXP_SELECT, True) 'extrai "SELECT"
      While Len(vgOQueInserir$) > 0                            'somente os campos da exp SQL
         i = InStr(vgOQueInserir$, ",")
         If i > 0 Then                                         'se encontrou um provável separador de campos
            
            'vamos ver se "," está entre parenteses ( ...  ,  ... )
            Do While i > 0
               k$ = Left(vgOQueInserir$, i)
               If Tally(k$, "(") <> Tally(k$, ")") Then
                  i = InStr(i + 1, vgOQueInserir$, ",")
               Else
                  Exit Do
               End If
            Loop
         End If
         If i = 0 Then i = Len(vgOQueInserir$) + 1
         C$ = Trim$(Left(vgOQueInserir$, i - 1))
         vgOQueInserir$ = Mid(vgOQueInserir$, i + 1)
         i = Rat(UCase$(C$), " AS ")                           'procura pelo alias
         If i > 0 Then                                         'verifica se é realmente o alias ou pode
            k$ = Trim$(Mid$(C$, i + 4))                        'ser um pedaço de um camo com []
            Do While (Tally(C$, "[") <> Tally(C$, "]") Or Tally(k$, "(") <> Tally(k$, ")")) And i <> 0
               i = Rat(UCase$(Left$(C$, i)), " AS ")           'alias invalido pega outro se existir
               If i > 0 Then k$ = Trim$(Mid$(C$, i + 4))       'tem outro alias..
            Loop                                               'testa novamente
            If i > 0 Then C$ = Trim$(Left$(C$, i - 1))         'tem alias pega so o campo
         End If

         'verefica se o campo ja esta na lista...
         i = InStr(UCase$(lstCampoOrdem.Tag) + "|", "|" + UCase$(C$) + "|") 'se o campo tem o prefixo "SUM"
         If i = 0 Then
            lstCampoGrupo.AddItem TrocaPeloTitulo(C$, EXP_GROUPBY)          'lista de campos (grupos)
            lstCampoGrupo.Tag = lstCampoGrupo.Tag + "|" + C$
            If PosiDoNome(vgGrupo$ + ",", C$ + ",", False) > 0 Then
               vgNaoEClick = True
               lstCampoGrupo.Selected(lstCampoGrupo.NewIndex) = True
               vgNaoEClick = False
            End If

            lstCampoOrdem.AddItem TrocaPeloTitulo(C$, EXP_ORDERBY)          'lista de campos (grupos)
            lstCampoOrdem.Tag = lstCampoOrdem.Tag + "|" + C$
            If PosiDoNome(vgOrdem$ + ",", C$ + ",", False) > 0 Or _
               PosiDoNome(vgOrdem$ + ",", C$ + " DESC,", False) > 0 Then
               vgNaoEClick = True
               lstCampoOrdem.Selected(lstCampoOrdem.NewIndex) = True
               vgNaoEClick = False
            End If
         End If
      Wend
      lstCampoGrupo.Tag = Mid$(lstCampoGrupo.Tag, 2)
      lstCampoOrdem.Tag = Mid$(lstCampoOrdem.Tag, 2)
   End If
   botConcatena.Enabled = (Len(cboValor.Text) > 0 And Len(cboCampos.Text) > 0)
End Sub

'evento disparado no clique do botão de concatenação de função agregada/coluna avulsa
Private Sub botConcaFunc_Click()
   Dim T As String, vgCp As String, vgNomeCp As String, i As Long, _
       vgSe As String, vgFr As String, x As String, vgWhere As String, _
       vgAliasCp As String, vgNFCp As String, j As Long
   If vgNaoEClick = True Or cboFunc.ListIndex = -1 Or Len(cboCampoFunc.Text) = 0 Then Exit Sub
   vgCp$ = PoeColchetes$(TrocaPeloCampo(cboCampoFunc.Text))

   'vamos armazenar o nome da tabela
   If InStr(vgCp$, "(") = 0 And InStr(vgCp$, ".") > 0 Then
      T$ = Parse$((vgCp$), ".")
   End If
   
   vgNomeCp$ = vgCp$
   If cboFunc.ListIndex > 0 Then
      If cboFunc.Text = LoadGasString(4544) Then
         vgCp$ = vgFuncAgregadas$(cboFunc.ListIndex - 1) + "(" + vgCp$ + ", 'yyyy/mm')"   'Mes/ano
      ElseIf cboFunc.Text = LoadGasString(4543) Then
         vgCp$ = vgFuncAgregadas$(cboFunc.ListIndex - 1) + "(" + vgCp$ + ", 'dd/mm/yyyy')" 'Data
      Else
         vgCp$ = vgFuncAgregadas$(cboFunc.ListIndex - 1) + "(" + vgCp$ + ")"
      End If
   End If
   If Len(Trim$(txtTitCol.Text)) > 0 Then
      vgAliasCp$ = " As " + PoeColchetes(Trim$(txtTitCol.Text))
   Else
      If InStr(vgNomeCp$, "(") = 0 And InStr(vgNomeCp$, ".") > 0 Then
         x$ = Parse$(vgNomeCp$, ".")
         vgAliasCp$ = " As " + PoeColchetes$(PegaAtributo(Retira$(vgNomeCp$, "[]", UM_A_UM), 3), True)
      End If
   End If
   vgSe$ = ExtraiSQL$(vgExpSQL$, EXP_SELECT, True)
   vgFr$ = ExtraiSQL$(vgExpSQL$, EXP_FROM, True)
   vgNFCp$ = vgCp$

   'procura pelo campo.... com ou sem apelido
   i = PosiDoNome(", " + vgSe$ + " AS ", ", " + vgNFCp$ + " AS", False)
   If i = 0 Then
      i = PosiDoNome(", " + vgSe$ + ",", ", " + vgNFCp$ + ",", False)
   End If
   If i = 0 Then                                  'nao tem na expressao vamos colocar
   
      'alias ja existemte nao coloca nada
      If Len(vgAliasCp$) > 0 Then
         If PosiDoNome(vgSe$ + ",", Trim$(vgAliasCp$) + ",", False) > 0 Then 'atualiza SQL se o campo não constar nela
            vgAliasCp$ = ""
         End If
      End If
      vgCp$ = vgCp$ + vgAliasCp$
      If Len(vgSe$) > 0 Then vgSe$ = vgSe$ + ", "
      InsereClausula EXP_SELECT, vgSe$ + vgCp$
   Else                                           'estava SELECIONADO

      'procura o inicio do proximo campo para remover a coluna por completa (campo e aplelido)
      j = InStr(i + Len(vgCp$), ", " + vgSe$ + ",", ",")
      x$ = Mid$(", " + vgSe$ + ",", i + 1, j - i - 1)
      Do While (Tally(x$, "[") <> Tally(x$, "]") Or Tally(x$, "(") <> Tally(x$, ")")) And _
         Tally(x$, "'") <> Tally(x$, "'") And j > 0
         j = InStr(j + 1, ", " + vgSe$ + ",", ",")
         x$ = Mid$(", " + vgSe$ + ",", i, j - i)
      Loop                                        'testa novamente
      vgSe$ = Trim$(Left$(", " + vgSe$, i - 1) + Mid$(", " + vgSe$, j))
      If Left$(vgSe$, 2) = ", " Then vgSe$ = Trim$(Mid$(vgSe$, 3))
      If Right$(vgSe$, 1) = "," Then vgSe$ = Left$(vgSe$, Len(vgSe$) - 1)
      InsereClausula EXP_SELECT, vgSe$
      If PosiDoNome(vgSe$, T$, False) = 0 Then TiraNomeDaClausula EXP_FROM, T$
      TiraNomeDaClausula EXP_ORDERBY, vgCp$
      TiraNomeDaClausula EXP_GROUPBY, vgCp$
      vgWhere$ = ExtraiSQL$(vgExpSQL$, EXP_WHERE, True)
      If PosiDoNome(vgWhere$, vgCp$, False) > 0 Then 'se o campo faz parte do filtro
         InsereClausula EXP_WHERE, ""                'remove todo o filtro
      End If
   End If
   If chkExpSQL.Value = vbChecked Or vgManual = True Then
      txtCriterio.Text = vgExpSQL$                   'mostra ao usuário
   Else
      txtCriterio.Text = PoeTitulos$(vgExpSQL$)      'mostra ao usuário
   End If
   lstTabelas_Click
   HabConcaFunc
End Sub

Private Sub botLimpa_Click()
   If SalvaQuery(CONFIRMA_GRAVACAO) Then             'salvar (se quiser) consulta existente
      ResetaQuery
      cboNomeQuery.SetFocus                          'coloca cursor no nome da query
   End If
End Sub

'concatena filtro/união de tabelas com "WHERE" existente
Private Sub botConcatena_Click()
   Dim vgWh As String, x As String, vgSegOperando As String, vgTp As GCOLUMN_TYPE, vgSegOp As String, _
       C As String, T As String, i As Integer, EmB As Integer, vgCpReal As String, vgConector As String
   vgCpReal$ = CampoReal(cboCampos)
   vgConector$ = cboOperador.Text
   If opcFiltro(1).Value Then                         'se for união de tabelas
      vgSegOperando$ = CampoReal$(cboValor)           'pega campo da 2a. tabela
   Else                                               'se quer filtrar
      T$ = Retira$(Parse$(vgCpReal$, ".", 1), "[]", UM_A_UM) 'tira os colchetes da
      C$ = Retira$(Parse$(vgCpReal$, ".", 2), "[]", UM_A_UM) 'tabela e campo
      EmB = (UCase$(cboValor.Text) = UCase$(LoadGasString(145)))

      'vamos ver se foi capturado da combo - se sim, é campo
      vgSegOp$ = cboValor.Text
      For i = 0 To cboValor.ListCount - 1
         If cboValor.List(i) = vgSegOp$ Then                 'foi capturado da combo, é campo
            i = -2
            Exit For
         End If
      Next
      vgTp = vgDb.Tables(T$).Columns(C$).ColumnType
      If vgTp = TP_CARACTER Then                             'se for tipo texto
         If vgSegOp$ = "" Or EmB Then                        'campo em branco
            vgSegOperando$ = "''"
         Else
            If i < 0 Then                                    'é campo da lista
               vgSegOperando$ = CampoReal$(cboValor)
            Else
               vgSegOperando$ = Chr$(39) + vgSegOp$ + Chr$(39) 'expressão, poe plics
            End If
         End If
      ElseIf vgTp = TP_LOGICO Then                             'tipo lógico
         vgSegOperando$ = Str$(Val(vgSegOp$) <> 0)             'campo para montar
      ElseIf vgTp = TP_DATA_HORA Then                          'se for data
         If vgSegOp$ = "" Or EmB Then
            vgSegOperando$ = "Null"
            If vgConector$ = "=" Then
               vgConector$ = "Is"
            Else
               vgConector$ = "Is Not"
            End If
         ElseIf UCase$(vgSegOp$) = "DATE" Or UCase$(vgSegOp$) = "DATE()" Or UCase$(vgSegOp$) = UCase$(LoadGasString(146)) Then
            vgSegOperando$ = "Date()"
         Else
            If i < 0 Then                                      'foi pego na combo, vamos ver o tipo
               vgSegOp$ = CampoReal$(cboValor)
               T$ = Retira$(Parse$(vgSegOp$, ".", 1), "[]", UM_A_UM) 'tira os colchetes da
               C$ = Retira$(Parse$(vgSegOp$, ".", 2), "[]", UM_A_UM) 'tabela e campo
               vgTp = vgDb.Tables(T$).Columns(C$).ColumnType
               If vgTp = TP_DATA_HORA Then                           'se for data
                  vgSegOperando$ = vgSegOp$
               Else
                  vgSegOperando$ = "CDate(" + vgSegOp$ + ")"
               End If
            Else
               vgSegOperando$ = "CDate('" + vgSegOp$ + "')"
            End If
         End If
      Else                                        'expressão numerica
         If i < 0 Then                            'é campo da lista
            vgSegOperando$ = CampoReal$(cboValor)
         Else
            vgSegOperando$ = vgSegOp$
         End If
      End If
   End If
   vgWh$ = ExtraiSQL$(vgExpSQL$, EXP_WHERE, True) 'cláusula "WHERE" existente
   If Len(vgWh$) > 0 Then                         'existe alguma?
      If opcFiltro(1).Value Or opcAndOr(0).Value Then 'quer AND ou é união de tabelas
         x$ = " AND ("
      Else                                            'vai concatenar com OR
         x$ = " OR "
         If Right$(vgWh$, 1) = ")" Then               'se tem "(" tira para
            vgWh$ = Left$(vgWh$, Len(vgWh$) - 1)      'concatenar expressão
         Else                                         'se não tem "("
            x$ = x$ + "("                             'vamos colocar um
         End If
      End If
   Else                                               'não de "WHERE" anterior
      x$ = "("                                        'vamos começar com "("
   End If
   If Trim(UCase$(cboOperador.Text)) = "LIKE" Then
      vgSegOperando$ = Substitui(vgSegOperando$, "%", "*", SO_UM)
   End If
   vgWh$ = vgWh$ + x$ + vgCpReal$ + " " + vgConector$ + " " + vgSegOperando$ + ")" 'agora sim, concatena...
   cboCampos.ListIndex = -1                       'limpa filtro/união para
   cboValor.Text = ""                             'um proximo...
   InsereClausula EXP_WHERE, vgWh$                'coloca dentro da exp SQL
   AtualizaListaFiltro cboCampos, cboValor        'enche novamente as listas
   AtualizaListaFiltro cboValor, cboCampos        'com a nova situação
End Sub

'limpa e reseta a consulta em montagem
Private Sub ResetaQuery()
   vgExpSQL$ = ""                                    'limpa exp SQL existente
   cboNomeQuery.Text = ""                            'nome da consulta
   vgNaoEClick = True                                'evitaremos recursividade
   vgManual = False
   chkExpSQL.Value = vbUnchecked
   InsereClausula EXP_TODAS, ""                      'prepara todos os controles
   vgNaoEClick = False
   lstTabelas.ListIndex = -1                         'deseleciona tabela
   AtualizaBotGravacao False                         'troca figuras/hab/desabilita botÔes
End Sub

Private Sub botGrava_Click()
   If SalvaQuery(NAO_CONFIRMA_GRAVACAO) Then      'se gravou query
      frmSeleQueries.EncheLista cboNomeQuery      'vamos coloca-la na lst
      vgNaoEClick = True                          'de consulta existentes
      cboNomeQuery.Text = vgNovaQuery$            'e reseleciona-la
      vgNaoEClick = False
   End If
End Sub

Private Sub botRetorna_Click()
   Unload Me
End Sub

Private Sub botTiraFiltro_Click()
   Beep                                           'quer retirar filtro (WHERE)
   If MsgBox(LoadGasString(4155), vbYesNo + vbQuestion, vgAtencao$) = vbYes Then
      InsereClausula EXP_WHERE, ""                'sim, substitui por nada
   End If
End Sub

'escolheu um campo para coluna avulsa
Private Sub cboCampoFunc_Change()
   If vgNaoEClick = False Then HabConcaFunc
End Sub

'escolheu um campo para coluna avulsa
Private Sub cboCampoFunc_Click()
   If InStr("+-*<>=^%()/", Right$(Trim$(vgNovaCol$), 1)) > 0 Then
      cboCampoFunc.Text = vgNovaCol$ + cboCampoFunc.Text
   End If
   HabConcaFunc
End Sub

'fechou a combo de campos para a nova coluna
Private Sub cboCampoFunc_DropDown()
   vgNovaCol$ = cboCampoFunc.Text
End Sub

'escolheu um campo para sumarizar
Private Sub lstCampoGrupo_Click()
   Dim vgGrupo As String, vgItemAtual As Integer, vgNCp As String
   If vgNaoEClick = False Then                                 'o usuário que clicou?
      vgItemAtual = lstCampoGrupo.ListIndex                    'cp escolhido
      vgGrupo$ = ExtraiSQL$(vgExpSQL$, EXP_GROUPBY, True)      'GROUP BY atual
      vgNCp$ = CampoReal$(lstCampoGrupo)
      If lstCampoGrupo.Selected(lstCampoGrupo.ListIndex) = False Then 'estava SELECIONADO
         TiraNomeDaClausula EXP_GROUPBY, vgNCp$                       'vamos retirá-lo
      Else                                        'aninda não,
         If Len(vgGrupo$) > 0 Then vgGrupo$ = vgGrupo$ + ", " 'vamos concatena-lo
         vgGrupo$ = vgGrupo$ + vgNCp$                         'a exp já existente
         InsereClausula EXP_GROUPBY, vgGrupo$                 'troca cláusula na exp SQL
      End If
      If lstCampoGrupo.ListCount > 0 Then
         vgNaoEClick = True                                   'evita recursividade
         lstCampoGrupo.ListIndex = vgItemAtual                'releciona cp escolhido
         vgNaoEClick = False
      End If
   End If
End Sub

'ordem do consulta
Private Sub lstCampoOrdem_Click()
   Dim vgOrdem As String, vgNCp As String
   If vgNaoEClick = False Then                                                'evita recursividade
      vgOrdem$ = ExtraiSQL$(vgExpSQL$, EXP_ORDERBY, True)                     'expressão de ordenacao (ORDER)
      vgNCp$ = CampoReal$(lstCampoOrdem)
      If lstCampoOrdem.Selected(lstCampoOrdem.ListIndex) = False Then         'estava SELECIONADO
         TiraNomeDaClausula EXP_ORDERBY, vgNCp$                               'então retira
      Else                                        'não,
         If Len(vgOrdem$) > 0 Then vgOrdem$ = vgOrdem$ + ", " 'então vamos
         vgOrdem$ = vgOrdem$ + vgNCp$                         'coloca-lo
         If opcOrdem(1).Value Then                            'é descendente
            vgOrdem$ = vgOrdem$ + " DESC"                     'concatena sufixo
         End If
         InsereClausula EXP_ORDERBY, vgOrdem$                 'troca ordenação na exp SQL
      End If
   End If
End Sub

Private Sub cboCampos_Click()
   Dim C As String, vgTp As GCOLUMN_TYPE                                      'dimensiona
   If vgNaoEClick = False Then                                                'evita recursividade
      AtualizaListaFiltro cboValor, cboCampos                                 'atualiza lista de filtros
      If Len(cboCampos.Text) > 0 Then
         C$ = Retira$(CampoReal$(cboCampos), "[]", UM_A_UM)                   'tira os colchetes
         vgTp = vgDb.Tables(Parse$(C$, ".", 1)).Columns(Parse$(C$, ".", 2)).ColumnType
         EncheOperadores cboOperador, (vgTp = TP_CARACTER Or vgTp = TP_MEMO)  'enche lista de operadores
      End If
   End If
End Sub

Private Sub cboFunc_Change()
   If vgNaoEClick = False Then HabConcaFunc
End Sub

Private Sub HabConcaFunc()
   Dim i As Integer
   i = (cboFunc.ListIndex >= 0 And Len(cboCampoFunc.Text) > 0)
   If botConcaFunc.Enabled <> i Then
      botConcaFunc.Enabled = i
   End If
End Sub

Private Sub cboFunc_Click()
   Dim vgGrupo As String
   If cboFunc.ListIndex > 5 Then
      vgGrupo$ = ExtraiSQL$(vgExpSQL$, EXP_GROUPBY, True)
      If Len(vgGrupo$) = 0 Then
         MsgBox LoadGasString(4534), vbInformation, vgAtencao$
         cboFunc.ListIndex = 0
      End If
   End If
End Sub

Private Sub cboNomeQuery_Change()
   If vgNaoEClick = False And vgNomeSQL$ <> cboNomeQuery.Text Then  'se o usuário que esta modificado o nome
      AtualizaBotGravacao True                                      'da consultam então hab/desabilita
   End If                                         'botões se necessário
   vgNomeSQL$ = cboNomeQuery.Text                 'nome atual da query
End Sub

'troca query de consulta
Private Sub cboNomeQuery_Click()
   Dim i As Integer, j As Integer, x As String, vgSecaoIni As String, k As String

   'verifica se quer salvar a anterior
   If SalvaQuery(CONFIRMA_GRAVACAO) And Len(cboNomeQuery.Text) > 0 Then
      vgNovaQuery$ = cboNomeQuery.Text                'nome da consulta escolhida
      vgSecaoIni$ = "CONSULTAS"
      i = 0
      Do
         i = i + 1
         x$ = PegaStrDoIni(vgSecaoIni$, "Nome da consulta " & i, vgConsultaINI$) 'pega nome da consulta do INI
         If x$ = "" Then
            Exit Sub
         End If
      Loop Until x$ = vgNovaQuery$

      'a consulta esta manual?
      vgManual = Val(PegaStrDoIni(vgSecaoIni$, "Edicao " & i, vgConsultaINI$))
      If vgManual = True Then
         chkExpSQL.Value = vbChecked
      End If

      'vamos montar a expressão SQL, SELECT
      j = 0
      vgExpSQL$ = ""
      Do
         j = j + 1
         x$ = PegaStrDoIni(vgSecaoIni$, "SQL " & i & "." & j, vgConsultaINI$)
         vgExpSQL = vgExpSQL + x$ + " "
      Loop Until x$ = ""

      'pega o filtro, WHERE
      j = 0
      k$ = ""
      Do
         j = j + 1
         x = PegaStrDoIni(vgSecaoIni$, "SQL Filtro inicial " & i & "." & j, vgConsultaINI$)
         k$ = k$ + x$ + " "
      Loop Until x$ = ""
      k$ = Trim$(k$)
      If Len(k$) > 0 Then
         vgExpSQL$ = vgExpSQL + " WHERE " + k$
      End If

      'pega a ordem, ORDER BY
      j = 0
      k$ = ""
      Do
         j = j + 1
         x = PegaStrDoIni(vgSecaoIni$, "SQL Ordem inicial " & i & "." & j, vgConsultaINI$)
         k$ = k$ + x$ + " "
      Loop Until x$ = ""
      k$ = Trim$(k$)
      If Len(k$) > 0 Then
         vgExpSQL$ = vgExpSQL + " ORDER BY " + k$
      End If

      x$ = PegaStrDoIni(vgSecaoIni$, "Usuário " & i, vgConsultaINI$)
      chkPermitirATodos.Value = Abs((x$ = "*TODOS*"))
      vgExpSQL$ = RTrim$(vgExpSQL$)
      If Right$(vgExpSQL$, 2) = vbCrLf Then                                      'vamos pegar o ultimo
         i = Len(vgExpSQL$) - 2                                                  'carcater válid da expressão
      Else
         i = Len(vgExpSQL$)
      End If
      If Mid$(vgExpSQL$, i, 1) = ";" Then                                        'inclusive tirando o ";"
         vgExpSQL$ = Left$(vgExpSQL$, i - 1)
      End If
      vgNaoEClick = True                          'evita recursividade
      txtTop.Text = ""                            'limpa TOP
      If Len(vgExpSQL$) > 0 Then                  'se a expressão de consulta existe
         x$ = LTrim$(vgClausula$(EXP_SELECT)) + "TOP " 'vamos verificar qual o TOP
         i = InStr(vgExpSQL$, x$)
         If i > 0 Then                                 'achamos...
            x$ = LTrim$(Mid$(vgExpSQL$, i + Len(x$)))  'pega o valor
            If Val(x$) > 0 Then
               txtTop.Text = LTrim$(Str$(Val(x$)))     'coloca no controle correnpondente
               x$ = LTrim$(Mid$(x$, InStr(x$, " ")))
            End If
            If UCase$(Left$(x$, 8)) = "PERCENT " Then  'existe a palavar...
               OpcTop(1).Value = True                  'marca "percentual"
            Else                                       'se não tem
               OpcTop(0).Value = True                  'marca "registros"
            End If
         End If
      End If
      InsereClausula EXP_TODAS, ""                     'hab/desabilita/enche tudo que
      vgNaoEClick = False                              'necessário
      AtualizaBotGravacao False                        'ajusta botões
   Else                                                'abandonou gravação...
      cboNomeQuery.Text = vgNovaQuery$                 'seleciona a mesma consulta
   End If
End Sub

Private Sub cboNomeQuery_LostFocus()
   vgNovaQuery$ = cboNomeQuery.Text                  'consulta atual em edição
End Sub

Private Sub cboValor_Change()
   botConcatena.Enabled = (Len(cboValor.Text) > 0 And Len(cboCampos.Text) > 0)
End Sub

Private Sub cboValor_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode <> 40 And KeyCode <> 38 Then           'seta baixo cima seleciona na combo
      If KeyCode = vbKeyReturn Then                  'enter
         KeyCode = 0                                 'vamos substituir
         SendK vbKeyTab                              'por TAB
      End If
      If opcFiltro(1).Value Then
         KeyCode = 0
      End If
   End If
End Sub

Private Sub cboValor_KeyPress(KeyAscii As Integer)
   If opcFiltro(1).Value Then KeyAscii = 0
End Sub

'escolheu um campo do filtro/união de tabelas
Private Sub cboValor_Click()
   If vgNaoEClick = False And opcFiltro(1).Value Then                        'se o usuário relamente clicou
      AtualizaListaFiltro cboCampos, cboValor                                'enche as combos apropriadamente
   End If
   botConcatena.Enabled = (Len(cboValor.Text) > 0 And Len(cboCampos.Text) > 0)
End Sub

'enche lst com os campos apropriados
Private Sub AtualizaListaFiltro(vgCt1 As Control, vgCt2 As Control)
   Dim i As Integer, T As String, vgTextoAnt As String, vgIndexAnt As Integer, _
       vgCp As String, vgTp As String, x As String, j As Long

   vgCp$ = CampoReal(vgCt2)
   T$ = Left$(vgCp$, InStr(vgCp$ + ".", ".") - 1)      'tabela escolhida
   vgTp = -1                                           'tipo do campo
   If vgCt2.ListIndex >= 0 And Len(T$) > 0 Then        'se tem campo selecionado
      vgCp$ = Retira$(vgCp$, "[]", UM_A_UM)            'vamos retirar todos []
      If InStr(vgCp$, ".") Then                        'se tem nome tab antes do cp
         vgCp$ = Mid$(vgCp$, InStr(vgCp$, ".") + 1)    'separa do campo
      End If
      vgTp$ = PegaAtributo$(vgCp$, 2)
   End If
   vgTextoAnt = vgCt1.Text                             'texto digitado anteriormente
   vgIndexAnt = -1
   vgCt1.Clear                                         'limpa lst
   vgCt1.Tag = ""
   If opcFiltro(0).Value Then
      If vgTp$ = "D" Then                              'se for data
         vgCt1.AddItem LoadGasString(145)              'em branca
         vgCt1.AddItem LoadGasString(146)              'data do sistema
         vgCt1.Tag = "||" 
      ElseIf vgTp$ = "C" Or vgTp$ = "M" Then           'se for tipo texto
         vgCt1.AddItem LoadGasString(145)              'em branca
         vgCt1.Tag = "|" 
      End If
   End If
   With lstCampoOrdem                                  'vamos encher
      vgCp$ = .Tag
      For i = 0 To .ListCount - 1                      'com todos os cps
         x$ = Parse$(vgCp$, "|")
         If Len(x$) > 0 Then
         j = InStr(x$, ".")
         If j > 1 Then
            j = (T$ <> Left$(x$, InStr(x$, ".") - 1))
         Else
            j = True
         End If
         If j Or opcFiltro(0).Value Then               'possíveis menos os cps
            vgCt1.AddItem .List(i)                     'da tab já selecionada
               vgCt1.Tag = vgCt1.Tag + "|" + x$
         End If
         End If
      Next
      vgCt1.Tag = Mid$(vgCt1.Tag, 2)
   End With
   For i = 0 To vgCt1.ListCount - 1                    'vamos ver qual o campo
      If vgCt1.List(i) = vgTextoAnt Then               'estava selecionado
         vgIndexAnt = i
         Exit For                                      'achou... cai fora
      End If
   Next
   vgNaoEClick = True                                  'evita recursividade
   vgCt1.ListIndex = vgIndexAnt                        'reseleciona cps esclohido
   vgNaoEClick = False
End Sub

Private Sub chkPermitirATodos_Click()
   AtualizaBotGravacao True
End Sub

Private Sub Form_Unload(Cancel As Integer)
   Set vgTooltips = Nothing
   Set frmMontaSQL = Nothing                      'libera o segmento de código do form
End Sub

'enche lista com nomes das tabelas
Private Sub EncheNomesTabs()
   Dim vgTab As GTable

   'enche lista com os nomes das tabelas
   lstTabelas.Clear
   'enche lista de tabelas
   For Each vgTab In vgDb.Tables
      If vgTab.System = False And vgTab.Hidden = False Then
         If Permitido(vgTab.Name, ACAO_NAVEGANDO) Then    'tira tabelas de segurança e invisíveis
            lstTabelas.AddItem vgTab.Title                'coloca na lista
            lstTabelas.ItemData(lstTabelas.NewIndex) = vgTab.Index
         End If
      End If
   Next
   Set vgTab = Nothing
End Sub

Private Sub Form_Load()
   Dim i As Integer
   Screen.MousePointer = vbHourglass
   vgCaracteristica = F_COMUM
   vgFormID = 7                                   'identificacao do form
   vgExpSQL$ = ""
   vgNomeSQL$ = ""
   vgNaoEClick = False
   vgManual = False
   EncheNomesTabs
   AtualizaBotGravacao False
   labNomeQuery.Caption = LoadGasString(4000)
   labCampoGrupo.Caption = LoadGasString(4010)
   labCampoOrdem.Caption = LoadGasString(4015)
   labTabelas.Caption = LoadGasString(4020)
   labCamposMostrar.Caption = LoadGasString(4030)
   fraOrdenacao.Caption = LoadGasString(4040)
   opcOrdem(0).Caption = LoadGasString(4050)
   opcOrdem(1).Caption = LoadGasString(4060)
   fraTop.Caption = LoadGasString(4070)
   OpcTop(0).Caption = LoadGasString(4080)
   OpcTop(1).Caption = LoadGasString(4090)
   fraFiltragem.Caption = LoadGasString(4100)
   opcFiltro(0).Caption = LoadGasString(4110)
   opcFiltro(1).Caption = LoadGasString(4120)
   opcAndOr(0).Caption = LoadGasString(4130) + "..."
   opcAndOr(1).Caption = LoadGasString(4140) + "..."
   botConcatena.Caption = LoadGasString(4150)
   chkPermitirATodos.Caption = LoadGasString(4275)
   chkExpSQL.Caption = LoadGasString(4277)
   labNomeCampo.Caption = LoadGasString(4160)
   labOperador.Caption = LoadGasString(4170)
   labValor.Caption = LoadGasString(4180)
   labCriterio.Caption = LoadGasString(4190)
   Set botGrava.Picture = LoadPicture(LoadGasPicture(245))
   Set botGrava.PictureDisabled = LoadPicture(LoadGasPicture(250))
   Set botRetorna.Picture = LoadPicture(LoadGasPicture(255))
   Set botLimpa.Picture = LoadPicture(LoadGasPicture(260))
   Set botTiraFiltro.Picture = LoadPicture(LoadGasPicture(263))
   Set botTiraFiltro.PictureDisabled = LoadPicture(LoadGasPicture(264))

   'funcoes agregadas
   LabCampoFunc.Caption = LoadGasString(4532)
   labFunc.Caption = LoadGasString(4531)
   fraFunc.Caption = LoadGasString(4530)
   labTitCol.Caption = LoadGasString(4533)
   Set botConcaFunc.Picture = LoadPicture(LoadGasPicture(186))
   Set botConcaFunc.DisabledPicture = LoadPicture(LoadGasPicture(187))
   cboFunc.AddItem ""
   For i = 0 To 13
      cboFunc.AddItem LoadGasString(4540 + i)
   Next
   cboFunc.ListIndex = 0

   'hint para os controles 
   vgTooltips.Create
   vgTooltips.AddTool botTiraFiltro, 0, LoadGasString(4490)
   vgTooltips.AddTool botConcatena, 0, LoadGasString(4200)
   vgTooltips.AddTool botRetorna, 0, LoadGasString(4210)
   vgTooltips.AddTool botGrava, 0, LoadGasString(4220)
   vgTooltips.AddTool botLimpa, 0, LoadGasString(4230)
   vgTooltips.AddTool fraAndOr, 0, LoadGasString(4240)
   vgTooltips.AddTool fraFiltragem, 0, LoadGasString(4250)
   vgTooltips.AddTool lstCampoOrdem, 0, LoadGasString(4260)
   vgTooltips.AddTool txtTop, 0, LoadGasString(4270)
   vgTooltips.AddTool lstCamposMostrar, 0, LoadGasString(4330)
   vgTooltips.AddTool lstTabelas, 0, LoadGasString(4340)
   vgTooltips.AddTool opcFiltro(0), 0, LoadGasString(4350)
   vgTooltips.AddTool opcFiltro(1), 0, LoadGasString(4355)
   vgTooltips.AddTool opcOrdem(0), 0, LoadGasString(4360)
   vgTooltips.AddTool opcOrdem(1), 0, LoadGasString(4365)
   vgTooltips.AddTool OpcTop(0), 0, LoadGasString(4370)
   vgTooltips.AddTool OpcTop(1), 0, LoadGasString(4375)
   vgTooltips.AddTool txtCriterio, 0, LoadGasString(4380)
   vgTooltips.AddTool txtTop, 0, LoadGasString(4390)
   vgTooltips.AddTool cboFunc, 0, LoadGasString(4241)
   vgTooltips.AddTool cboCampoFunc, 0, LoadGasString(4242)
   vgTooltips.AddTool txtTitCol, 0, LoadGasString(4243)
   vgTooltips.AddTool botConcaFunc, 0, LoadGasString(4244)
   vgTooltips.AddTool chkExpSQL, 0, LoadGasString(4245)
   vgTooltips.AddTool chkPermitirATodos, 0, LoadGasString(4246)
   vgTooltips.AddTool lstCampoGrupo, 0, LoadGasString(4247)
   vgTooltips.AddTool lstCampoOrdem, 0, LoadGasString(4248)
   vgTooltips.AddTool cboCampos, 0, LoadGasString(4249)
   vgTooltips.AddTool cboOperador, 0, LoadGasString(4251)
   vgTooltips.AddTool cboValor, 0, LoadGasString(4252)
   EncheOperadores cboOperador, True
   frmSeleQueries.EncheLista cboNomeQuery
   cboOperador.Text = "="
   CentraNaTela Me
   Screen.MousePointer = vbDefault
End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)
   Cancel = Not SalvaQuery(CONFIRMA_GRAVACAO)
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyEscape Then                    'se teclou ESC
      Unload Me                                      'tira este form da memória
   End If
End Sub

Private Sub lstCamposMostrar_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode <> vbKeySpace Then
      vgNaoEClick = True
   End If
End Sub

Private Sub lstCamposMostrar_KeyUp(KeyCode As Integer, Shift As Integer)
   vgNaoEClick = False
End Sub

Private Sub lstCamposMostrar_Click()
   Dim T As String, vgCp As String, vgNomeCp As String, i As Long, j As Long, _
       vgSe As String, vgFr As String, vgGrupo As String, x As String, vgWhere As String, _
       vgIndCp As Integer, vgAliasCp As String
   If vgNaoEClick Then Exit Sub
   vgSe$ = ExtraiSQL$(vgExpSQL$, EXP_SELECT, True)
   vgFr$ = ExtraiSQL$(vgExpSQL$, EXP_FROM, True)
   vgGrupo$ = ExtraiSQL$(vgExpSQL$, EXP_GROUPBY, True)
   T$ = vgDb.Tables(lstTabelas.itemData(lstTabelas.ListIndex)).Name
   vgAliasCp$ = ""
   vgIndCp = lstCamposMostrar.itemData(lstCamposMostrar.ListIndex)
   vgNomeCp$ = PoeColchetes$(vgDb.Tables(T$).Columns(vgIndCp).Name)
   T$ = PoeColchetes$(T$)
   vgCp$ = T$ + "." + vgNomeCp$
   If UCase$(lstCamposMostrar.Text) <> UCase$(Retira$(vgNomeCp$, "[]", UM_A_UM)) Then
      vgAliasCp$ = " As " + PoeColchetes$(lstCamposMostrar.Text, True)
   End If
   vgNomeCp$ = T$ + "." + vgNomeCp$
   
   'procura pelo campo.... com ou sem apelido
   i = PosiDoNome(", " + vgSe$ + " AS ", ", " + vgNomeCp$ + " AS", False)
   If i = 0 Then
      i = PosiDoNome(", " + vgSe$ + ",", ", " + vgNomeCp$ + ",", False)
   End If
   If i = 0 Then                                     'nao tem na expressao vamos colocar
      If Len(vgAliasCp$) > 0 Then
         If PosiDoNome(vgSe$ + ",", Trim$(vgAliasCp$) + ",", False) > 0 Then 'atualiza SQL se o campo não constar nela
            vgAliasCp$ = ""
         End If
      End If
      If Len(vgSe$) > 0 Then vgSe$ = vgSe$ + ", "
      InsereClausula EXP_SELECT, vgSe$ + vgCp$
      If PosiDoNome(vgFr$ + ",", T$ + ",", False) = 0 Then
         If Len(vgFr$) > 0 Then vgFr$ = vgFr$ + ", "
         InsereClausula EXP_FROM, vgFr$ + T$
      End If
   Else                                           'estava SELECIONADO
      'procura o inicio do proximo campo para remover a coluna por completa (campo e aplelido)
      j = InStr(i + Len(vgNomeCp$), ", " + vgSe$ + ",", ",")
      x$ = Mid$(", " + vgSe$ + ",", i + 1, j - i - 1)
      Do While (Tally(x$, "[") <> Tally(x$, "]") Or Tally(x$, "(") <> Tally(x$, ")")) And _
         Tally(x$, "'") <> Tally(x$, "'") And j > 0
         j = InStr(j + 1, ", " + vgSe$ + ",", ",")
         x$ = Mid$(", " + vgSe$ + ",", i, j - i)
      Loop                                        'testa novamente
      vgSe$ = Trim$(Left$(", " + vgSe$, i - 1) + Mid$(", " + vgSe$, j))
      If Left$(vgSe$, 2) = ", " Then vgSe$ = Trim$(Mid$(vgSe$, 3))
      If Right$(vgSe$, 1) = "," Then vgSe$ = Left$(vgSe$, Len(vgSe$) - 1)
      InsereClausula EXP_SELECT, vgSe$
      If PosiDoNome(vgSe$, T$, False) = 0 Then TiraNomeDaClausula EXP_FROM, T$
      TiraNomeDaClausula EXP_ORDERBY, vgNomeCp$
      TiraNomeDaClausula EXP_GROUPBY, vgNomeCp$
      vgWhere$ = ExtraiSQL$(vgExpSQL$, EXP_WHERE, True)
      If PosiDoNome(vgWhere$, vgNomeCp$, False) > 0 Then 'se o campo faz parte do filtro
         InsereClausula EXP_WHERE, ""                    'remove todo o filtro
      End If
   End If
   If chkExpSQL.Value = vbChecked Or vgManual = True Then
      txtCriterio.Text = vgExpSQL$                       'mostra ao usuário
   Else
      txtCriterio.Text = PoeTitulos$(vgExpSQL$)          'mostra ao usuário
   End If

End Sub

Private Sub chkExpSQL_Click()
   vgNaoEClick = True
   If chkExpSQL.Value = vbChecked Or vgManual = True Then
      txtCriterio.Text = vgExpSQL$                        'mostra ao usuário
   Else
      txtCriterio.Text = PoeTitulos$(vgExpSQL$)           'mostra ao usuário
   End If
   vgNaoEClick = False
End Sub

Private Sub TiraNomeDaClausula(ByVal vgQual As Integer, vgNome As String)
   Dim i As Integer, j As Integer, vgEx As String, k As String
   vgEx$ = ExtraiSQL$(vgExpSQL$, vgQual, True)

TiraOutro:
   i = PosiDoNome(", " + vgEx$ + ",", ", " + vgNome$ + ",", False)
   If i = 0 Then                                     'tenta decrescente
      i = PosiDoNome(", " + vgEx$ + ",", ", " + vgNome$ + " DESC" + ",", False)
   End If
   
   If i > 0 And Len(vgEx$) > 0 And Len(vgNome$) > 0 Then
      If i > 2 Then i = i - 1                        'ajusta carcter colocado para pesquisa
      j = InStr(i, vgEx$ + ",", ",")
      If j > 0 Then                                  'se encontrou um provável separador de campos

         'vamos ver se "," está entre parenteses ( ...  ,  ... )
         Do While j > 0
            k$ = Mid$(vgEx$, i, j - i)
            If Tally(k$, "(") <> Tally(k$, ")") Then
               j = InStr(j + 1, vgEx$, ",")
            Else
               Exit Do
            End If
         Loop
      End If
      If j = 0 Then
         j = Len(vgEx$) + 1
      End If
      
      vgEx$ = Trim$(Left$(vgEx$, i - 1) + Mid$(vgEx$, j + 1))
      If Right$(vgEx$, 1) = "," Then vgEx$ = Left$(vgEx$, Len(vgEx$) - 1)
      InsereClausula vgQual, vgEx$
      GoTo TiraOutro
   End If
End Sub

Private Sub lstTabelas_Click()
   Dim vgCp As GColumn, vgSe As String, vgNt As String, _
       vgNTbP As String, j As Long, p As Long
   lstCamposMostrar.Clear
   If lstTabelas.ListIndex >= 0 Then
      vgNt$ = vgDb.Tables(lstTabelas.itemData(lstTabelas.ListIndex)).Name
      vgNTbP$ = PoeColchetes$(vgNt$) + "."
      vgSe$ = ExtraiSQL$(vgExpSQL$, EXP_SELECT, True)
      vgNaoEClick = True
      For Each vgCp In vgDb.Tables(vgNt$).Columns
         If vgCp.Hidden = False Then
            lstCamposMostrar.AddItem vgCp.Title
            lstCamposMostrar.itemData(lstCamposMostrar.NewIndex) = vgCp.Index
            p = PosiDoNome(", " + vgSe$ + ",", ", " + vgNTbP$ + PoeColchetes$(vgCp.Name) + ",", False)
            j = PosiDoNome(", " + vgSe$ + ",", ", " + vgNTbP$ + PoeColchetes$(vgCp.Name) + " AS", False)
            If p > 0 Or j > 0 Then
               lstCamposMostrar.Selected(lstCamposMostrar.NewIndex) = True  'selecione este...
            End If
         End If
      Next
      Set vgCp = Nothing
      vgNaoEClick = False
   End If
End Sub

Private Sub opcFiltro_Click(Index As Integer)
   cboOperador.Enabled = (Index = 0)
   labOperador.Enabled = (Index = 0)
   If Index = 1 Then cboOperador.Text = "="
   If Len(ExtraiSQL$(vgExpSQL$, EXP_WHERE, True)) > 0 Then
      fraAndOr.Enabled = (Index = 0)
      opcAndOr(0).Enabled = (Index = 0)
      opcAndOr(1).Enabled = (Index = 0)
   End If
   AtualizaListaFiltro cboCampos, cboValor
   AtualizaListaFiltro cboValor, cboCampos
End Sub

Private Sub OpcTop_Click(Index As Integer)
   InsereClausula EXP_TODAS, ""
End Sub

Private Sub txtCriterio_Change()
   If vgNaoEClick = False Then
      AtualizaBotGravacao True
      If vgManual Then
         vgExpSQL$ = txtCriterio.Text
      End If
   End If
End Sub

Private Sub txtCriterio_KeyDown(KeyCode As Integer, Shift As Integer)
   If chkExpSQL.Value = vbChecked Then
      If vgManual = False Then
         If KeyCode <> vbKeyLeft And KeyCode <> vbKeyRight And KeyCode <> vbKeyUp And _
             KeyCode <> vbKeyDown And KeyCode <> vbKeyPageDown And KeyCode <> vbKeyPageUp And _
             KeyCode <> vbKeyHome And KeyCode <> vbKeyEnd And KeyCode <> vbKeyEscape And _
             KeyCode <> vbKeyInsert And KeyCode <> vbKeyShift And KeyCode <> vbKeyControl And _
             KeyCode <> vbKeyNumlock And KeyCode <> vbKeyCapital And (KeyCode = vbKeyC And Shift = 2) = False Then
            vgManual = True
            InsereClausula EXP_TODAS, ""
         End If
      End If
   ElseIf KeyCode = vbKeyDelete Then
      KeyCode = 0
   End If
End Sub

Private Sub txtCriterio_KeyPress(KeyAscii As Integer)
   If chkExpSQL.Value = vbUnchecked Then
      KeyAscii = 0                                      'proibe digitação
   End If
End Sub

Private Sub txtTop_Change()
   If vgNaoEClick = False Then
      InsereClausula EXP_TODAS, ""
      OpcTop(0).Enabled = (Val(txtTop.Text) > 0)
      OpcTop(1).Enabled = OpcTop(0).Enabled
   End If
End Sub

'pega o nome do campo real 
Private Function CampoReal(cbo As Object) As String
   Dim i As Integer, vgRetVal As String, x As String
   
   x$ = cbo.Tag
   vgRetVal$ = cbo.Text
   For i = 0 To cbo.ListIndex
      vgRetVal = Parse$(x$, "|")
   Next
   CampoReal = vgRetVal$
End Function

'insere cláusula especificada dentro da exrpessão SQL
Private Function PoeTitulos(vgConSQL As String) As String
   Dim vgEx As String, x As String, vgNumExp As Integer
   vgEx$ = ""                                          'conterá toda a exp SQL
   For vgNumExp = 0 To EXP_TODAS - 1                   'corre todas as cláusulas
      x$ = ExtraiSQL$(vgConSQL$, vgNumExp, False)      'tira cláusula da própia exp SQL
      If Len(x$) > 0 Then                              'se a cláusula existe
         x$ = TrocaPeloTitulo(x$, vgNumExp)            'poe os títulos dos campos
         vgEx$ = vgEx$ + LoadGasString(4500 + vgNumExp) + " " + x$ + vbCrLf 'e segue montando a nova exp SQL
      End If
   Next
   PoeTitulos$ = Trim$(vgEx$)                                               'esta é a nova exp SQL
End Function

'troca nomes de campos pelos títulos
Private Function TrocaPeloCampo(vgExp As String) As String
   Dim vgCp As GColumn, vgTitTb As String, vgNCp As String, vgRetVal As String, _
       vgNTb As String, vgTab As GTable
   vgRetVal$ = vgExp$
   
   'enche lista de tabelas
   For Each vgTab In vgDb.Tables
      If vgTab.Hidden = False And vgTab.System = False Then  'tira tabelas invisíveis
         vgTitTb$ = vgTab.Title
         vgNTb$ = vgTab.Name
         For Each vgCp In vgTab.Columns
            If vgCp.Hidden = False Then
               vgNCp$ = vgCp.Title
               vgRetVal$ = Substitui$(vgRetVal$, vgTitTb$ + "->" + vgNCp$, PoeColchetes(vgNTb$) + "." + PoeColchetes$(vgCp.Name), SO_UM)
            End If
         Next
      End If
   Next
   
   Set vgTab = Nothing
   Set vgCp = Nothing
   TrocaPeloCampo = vgRetVal$
End Function

'troca nomes de campos pelos títulos
Private Function TrocaPeloTitulo(vgExp As String, vgNumExp As Integer) As String
   Dim i As Long, j As Long, x As String, vgRetVal As String, vgCharX As String, _
       vgNTb As String, vgNCp As String, p As Long, ii As Integer, k As String, _
       vgTeveTop As Boolean
   If vgNumExp = EXP_FROM Then
      k$ = vgExp$
      vgRetVal$ = ""
      Do While Len(k$)
         vgNTb$ = Parse$(k$, ",")
         vgRetVal$ = vgRetVal$ + ", " + vgDb.Tables(Trim$(Retira$(vgNTb$, "[]", UM_A_UM))).Title
      Loop
      If Len(vgRetVal$) Then vgRetVal$ = Mid$(vgRetVal$, 3)
      GoTo FimDaSub
   End If
   i = 1
   vgTeveTop = False
   vgRetVal$ = vgExp$
   vgCharX$ = Chr$(13) + Chr$(34) + "() +-*/\;=,<>^ '{}"

ComPar:
   Do While InStr(vgCharX$, Mid$(vgRetVal$, i, 1)) > 0 And i < Len(vgRetVal$) 
      i = i + 1
   Loop
   If i > Len(vgRetVal$) Then GoTo FimDaSub
   j = i
   
   'acha a primeira ocorrencia de caracteres especiais
CampoParcial:
   If j < Len(vgRetVal$) Then
      Do While InStr(vgCharX$, Mid$(vgRetVal$, j, 1)) = 0 And j <= Len(vgRetVal$)
         j = j + 1
      Loop
      j = j - 1                                   'antes do separador
   End If 
   x$ = Mid$(vgRetVal$, i, j - i + 1)             'nome do campo

   'usando format acha o primeiro parentese
   If UCase$(x$) = "FORMAT" Then
      Do While Mid$(vgRetVal$, j, 1) <> "(" And j < Len(vgRetVal$)
         j = j + 1
      Loop
      x$ = Mid$(vgRetVal$, i, j - i + 1)          'nome do campo
   End If
   If Len(x$) > 0 Then
   
      'veririca se não é um pedaço de campo
      If Tally(x$, "[") <> Tally(x$, "]") Or Tally(x$, "(") > Tally(x$, ")") Or _
         ((Tally(x$, "'") Mod 2) <> 0) Then
         j = j + 2
         If j > Len(vgRetVal$) Then
            GoTo FimDaSub
         Else
            GoTo CampoParcial
         End If
      End If
   End If
   vgNCp$ = ""

   'format trata diferente
   If Left$(UCase$(x$), 6) = "FORMAT" Then
      If InStr(x$, "'dd/mm/yyyy'") Then
         vgNCp$ = LoadGasString(4543)             'data
      ElseIf InStr(x$, "'yyyy/mm'") Then
         vgNCp$ = LoadGasString(4544)             'Ano/Mes
      Else
         k$ = Left$(x$, 6)                        'salva a palavra format
         vgNCp$ = "TZYXQW"                        'so para não passar aqui de novo
      End If
      x$ = vgNCp$ + Mid$(x$, 7)
      vgNCp$ = TrocaPeloTitulo(x$, vgNumExp)
      If Left$(vgNCp$, 6) = "TZYXQW" Then
         vgNCp$ = k$ + Mid$(vgNCp$, 7)
      End If
      
   'esta entre pliques coloca como esta
   ElseIf i > 1 And j < Len(vgRetVal$) Then
      If Mid$(vgRetVal$, i - 1, 1) = "'" And Mid$(vgRetVal$, j + 1, 1) = "'" Then
         vgNCp$ = x$
      End If
   End If
   
   'se for select nas primeiras posicoes pode ter top xx percent
   If vgNumExp = EXP_SELECT And i < 25 Then
      If UCase$(x$) = "TOP" And i = 1 Then
         vgNCp$ = UCase$(LoadGasString(4070))
         vgTeveTop = True
      ElseIf UCase$(x$) = "PERCENT" And vgTeveTop Then
         vgNCp$ = "%"
      End If
   End If

   'verifica se é uma funcao agregada
   If Len(vgNCp$) = 0 Then
      For ii = 0 To UBound(vgFuncAgregadas)
         If UCase$(x$) = vgFuncAgregadas$(ii) Then
            vgNCp$ = LoadGasString(4540 + ii)
            ii = 99
         End If
      Next
   End If
   If Len(vgNCp$) = 0 Then
      
      'separa a tabela do nome do campo
      p = InStr(x$, ".")
      If p > 0 And p < Len(x$) Then
         If Asc(Mid$(x$, p + 1, 1)) < Asc("0") Or Asc(Mid$(x$, p + 1, 1)) > Asc("9") Then
            vgNTb$ = Left$(x$, p - 1)             'nome da tabela e o
            vgNCp$ = Mid$(x$, Len(vgNTb$) + 2)    'nome do campo
            vgNTb$ = Retira$(vgNTb$, "[]", UM_A_UM) 'tira os colchetes
            vgNCp$ = vgDb.Tables(vgNTb$).Title + "->" + PegaAtributo$(Retira$(vgNCp$, "[]", UM_A_UM), 3) 'tabela->campo
         End If
      Else
         If UCase$(x$) = "OR" Then                'operador OR
            vgNCp$ = LoadGasString(4140)
         ElseIf UCase$(x$) = "AND" Then           'operador AND
            vgNCp$ = LoadGasString(4130)
         End If
      End If
   End If
   If Len(vgNCp$) > 0 Then
      vgRetVal$ = Left$(vgRetVal$, i - 1) + vgNCp$ + Mid$(vgRetVal$, j + 1) 'troca na expressão
      j = i + Len(vgNCp$)                         'ajusta para a proxima posição
   End If
   i = j + 1
   If i < Len(vgRetVal$) Then GoTo ComPar

FimDaSub:
   TrocaPeloTitulo = Trim$(vgRetVal$)
End Function
