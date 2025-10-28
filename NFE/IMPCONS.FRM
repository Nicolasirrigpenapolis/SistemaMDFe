Version 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form frmImpCons 
   ClientHeight    =   4620
   ClientLeft      =   5790
   ClientTop       =   2700
   ClientWidth     =   7050
   ForeColor       =   &H80000008&
   KeyPreview      =   -1  'True
   LinkTopic       =   "frmImpCons"
   MDIChild        =   -1  'True
   ScaleHeight     =   4620
   ScaleWidth      =   7050
   Begin VB.frame fraQuebra 
      Caption         =   "Expressão para quebra"
      Height          =   3930
      Left            =   960
      TabIndex        =   31
      Top             =   240
      Width           =   4860
      Begin VB.ListBox lstCps 
         Height          =   1980
         IntegralHeight  =   0   'False
         Left            =   180
         TabIndex        =   40
         TabStop         =   0   'False
         Top             =   270
         Width           =   2205
      End
      Begin NFE.GBotao BotInclui 
         Height = 345
         Left            =   3615
         TabIndex        =   37
         Top             =   2235
         Width           =   285
         _ExtentX        =   0
         _ExtentY        =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            StrikeThrough   =   0   'False
         EndProperty
         CaptionOffset   =   50
      End
      
      Begin NFE.GBotao BotExclui 
         Height          =   345
         Left            =   3885
         TabIndex        =   36
         Top             =   2235
         Width           =   285
         _ExtentX        =   0
         _ExtentY        =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            StrikeThrough   =   0   'False
         EndProperty
         CaptionOffset   =   50
      End
      
      Begin NFE.GBotao botCancelaQb 
         Height          =   360
         Left            =   4155
         TabIndex        =   35
         Top             =   2610
         Width           =   360
         _ExtentX        =   0
         _ExtentY        =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            StrikeThrough   =   0   'False
         EndProperty
         CaptionOffset   =   50
      End
      
      Begin NFE.GBotao botOkQb 
         Height          =   360
         Left            =   3735
         TabIndex        =   34
         Top             =   2610
         Width           =   360
         _ExtentX        =   0
         _ExtentY        =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            StrikeThrough   =   0   'False
         EndProperty
         CaptionOffset   =   50
      End
      
      Begin NFE.GBotao BotTotQb 
         Height          =   345
         Left            =   4230
         TabIndex        =   32
         Top             =   2235
         Width           =   285
         _ExtentX        =   0
         _ExtentY        =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            StrikeThrough   =   0   'False
         EndProperty
         CaptionOffset   =   50
      End
      
      Begin MSComctlLib.TreeView trvQB 
         Height          =   1965
         Left            =   2745
         TabIndex        =   33
         Top             =   270
         Width           =   1920
         _ExtentX        =   3387
         _ExtentY        =   3466
         _Version        =   327682
         Style           =   7
         Appearance      =   1
      End
   End
   Begin NFE.GPainel Painel 
      Height          =   3615
      Index           =   0
      Left            =   30
      Top             =   30
      Width           =   5970
      _ExtentX        =   10530
      _ExtentY        =   6376
      BevelOuter      =   0
      Stretch         =   -1  'True
      Begin NFE.GBotao botConfImp 
         Height          =   360
         Left            =   4440
         TabIndex        =   2
         Top             =   3120
         Width           =   360
         _ExtentX        =   0
         _ExtentY        =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            StrikeThrough   =   0   'False
         EndProperty
         CaptionOffset   =   50
      End
      Begin NFE.GBotao botQuebra 
         Height          =   360
         Left            =   4800
         TabIndex        =   3
         Top             =   3120
         Width           =   360
         _ExtentX        =   0
         _ExtentY        =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            StrikeThrough   =   0   'False
         EndProperty
         CaptionOffset   =   50
      End
      Begin NFE.GBotao botOk 
         Height          =   360
         Left            =   5160
         TabIndex        =   0
         Top             =   3120
         Width           =   360
         _ExtentX        =   0
         _ExtentY        =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            StrikeThrough   =   0   'False
         EndProperty
         CaptionOffset   =   50
      End
      Begin NFE.GBotao botCancela 
         Height          =   360
         Left            =   5520
         TabIndex        =   1
         Top = 3120
         Width = 360
         _ExtentX        =   0
         _ExtentY        =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            StrikeThrough   =   0   'False
         EndProperty
         CaptionOffset   =   50
      End
      Begin VB.frame fraTotal 
         Caption         =   "Totaliza colunas"
         Height          =   1215
         Left            =   3510
         TabIndex        =   29
         Top             =   1650
         Width           =   2415
         Begin VB.ListBox lstTotal 
            Height          =   840
            Left            =   120
            MultiSelect     =   1  'Simple
            TabIndex        =   30
            Top             =   270
            Width           =   2175
         End
      End
      Begin VB.frame frame 
         Caption         =   "Formato TXT"
         Height          =   1215
         Index           =   2
         Left            =   90
         TabIndex        =   20
         Top             =   1650
         Width           =   3345
         Begin VB.TextBox txtCp 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               StrikeThrough   =   0   'False
            EndProperty
            Height          =   285
            Index           =   2
            Left            =   2835
            MaxLength       =   254
            TabIndex        =   26
            Top             =   420
            Width           =   390
         End
         Begin VB.TextBox txtCp 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               StrikeThrough   =   0   'False
            EndProperty
            Height          =   285
            Index           =   3
            Left            =   2835
            MaxLength       =   254
            TabIndex        =   25
            Top             =   810
            Width           =   390
         End
         Begin VB.OptionButton opcFrame2Cp 
            Caption         =   "Texto delimitado"
            Height          =   195
            Index           =   2
            Left            =   60
            TabIndex        =   23
            Top             =   900
            Width           =   1695
         End
         Begin VB.OptionButton opcFrame2Cp 
            Caption         =   "Formato SDF"
            Height          =   195
            Index           =   1
            Left            =   60
            TabIndex        =   22
            Top             =   585
            Width           =   1695
         End
         Begin VB.OptionButton opcFrame2Cp 
            Caption         =   "Sem formatação"
            Height          =   195
            Index           =   0
            Left            =   60
            TabIndex        =   21
            Top             =   270
            Width           =   1695
         End
         Begin VB.Label Label 
            Alignment       =   1  'Right Justify
            Caption         =   "Separador:"
            ForeColor       =   &H80000008&
            Height          =   195
            Index           =   4
            Left            =   1950
            TabIndex        =   28
            Top             =   450
            Width           =   810
         End
         Begin VB.Label Label 
            Alignment       =   1  'Right Justify
            Caption         =   "Delimitador:"
            ForeColor       =   &H80000008&
            Height          =   195
            Index           =   5
            Left            =   1800
            TabIndex        =   27
            Top             =   840
            Width           =   975
         End
         Begin VB.Label labopcFrame2 
            BorderStyle     =   1  'Fixed Single
            Height          =   120
            Left            =   1860
            TabIndex        =   24
            Top             =   120
            Visible         =   0   'False
            Width           =   240
         End
      End
      Begin VB.frame frame 
         Caption         =   "Arquivo de saída"
         Height          =   1545
         Index           =   1
         Left            =   2280
         TabIndex        =   11
         Top             =   90
         Width           =   3645
         Begin VB.TextBox txtCp 
            BorderStyle     =   0  'None
            Height          =   255
            Index           =   1
            Left            =   945
            MaxLength       =   254
            TabIndex        =   15
            Top             =   990
            Width           =   2250
         End
         Begin VB.CommandButton bottxtCampo1 
            Height          =   255
            Left            =   3210
            Style           =   1  'Graphical
            TabIndex        =   14
            TabStop         =   0   'False
            Top             =   990
            Width           =   255
         End
         Begin VB.TextBox txtCp 
            BorderStyle     =   0  'None
            Height          =   255
            Index           =   0
            Left            =   945
            TabIndex        =   13
            Top             =   435
            Width           =   2250
         End
         Begin VB.CommandButton bottxtCampo0 
            Height          =   255
            Left            =   3210
            Style           =   1  'Graphical
            TabIndex        =   12
            TabStop         =   0   'False
            Top             =   435
            Width           =   255
         End
         Begin VB.Label labFdo1 
            BackColor       =   &H80000005&
            BorderStyle     =   1  'Fixed Single
            Height          =   315
            Left            =   915
            TabIndex        =   19
            Top             =   960
            Width           =   2580
         End
         Begin VB.Label Label 
            Alignment       =   1  'Right Justify
            Caption         =   "Nome:"
            ForeColor       =   &H80000008&
            Height          =   195
            Index           =   3
            Left            =   120
            TabIndex        =   18
            Top             =   1020
            Width           =   750
         End
         Begin VB.Label labFdo0 
            BackColor       =   &H80000005&
            BorderStyle     =   1  'Fixed Single
            Height          =   315
            Left            =   915
            TabIndex        =   17
            Top             =   405
            Width           =   2580
         End
         Begin VB.Label Label 
            Alignment       =   1  'Right Justify
            Caption         =   "Formato:"
            ForeColor       =   &H80000008&
            Height          =   195
            Index           =   2
            Left            =   120
            TabIndex        =   16
            Top             =   465
            Width           =   750
         End
      End
      Begin VB.frame frame 
         Caption         =   "Destino do relatório"
         Height          =   1545
         Index           =   0
         Left            =   90
         TabIndex        =   5
         Top             =   90
         Width           =   2130
         Begin VB.OptionButton opcFrame0Cp 
            Caption         =   "Destinatário de Correio"
            ForeColor       =   &H80000008&
            Height          =   255
            Index           =   3
            Left            =   60
            TabIndex        =   9
            Top             =   1140
            Width           =   2025
         End
         Begin VB.OptionButton opcFrame0Cp 
            Caption         =   "Arquivo"
            ForeColor       =   &H80000008&
            Height          =   255
            Index           =   2
            Left            =   60
            TabIndex        =   8
            Top             =   855
            Width           =   2025
         End
         Begin VB.OptionButton opcFrame0Cp 
            Caption         =   "Impressora"
            ForeColor       =   &H80000008&
            Height          =   255
            Index           =   1
            Left            =   60
            TabIndex        =   7
            Top             =   555
            Width           =   2025
         End
         Begin VB.OptionButton opcFrame0Cp 
            Caption         =   "Janela"
            ForeColor       =   &H80000008&
            Height          =   255
            Index           =   0
            Left            =   60
            TabIndex        =   6
            Top             =   270
            Width           =   2025
         End
         Begin VB.Label labopcFrame0 
            BorderStyle     =   1  'Fixed Single
            Height          =   120
            Left            =   1845
            TabIndex        =   10
            Top             =   180
            Visible         =   0   'False
            Width           =   240
         End
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Impressora padrão"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   0
         Left            =   60
         TabIndex        =   3
         Top             =   2940
         Width           =   1305
      End
      Begin VB.Label Label 
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H00FF0000&
         Height          =   300
         Index           =   1
         Left            =   60
         TabIndex        =   4
         Top             =   3180
         Width           =   4275
      End
   End
End
Attribute VB_name = "frmImpCons"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
'* Sistema...: Emissor de MDF-e (Layout 3.00)
'* Empresa...: Ygor Eduardo Dellalio
'* Módulo....: IMPCONS.FRM
'* Função....: Imprime/exporta as consultas
'* CopyRight.: (C)2024 Ygor Eduardo Dellalio
'* Criação...: GAS-2007 - Gerador Automático de Sistemas
'* Data......: 05/09/2024 18:10:19
'* * * * * * *

Option Explicit
DefInt A-Z

Public vgSituacao As Integer                       'situação de edição que do módulo
Public vgCaracteristica As Integer                 'caracteristica do módulo
Public vgTipo As Integer                           'tipo do módulo
Public vgPriVez As Integer                         'flag de carregamento do módulo
Public vgFormID As Long                            'identificador único para o módulo
Public vgIdentTab As String                        'nome da tabela principal do módulo
Public vgEmBrowse As Integer                       'flag se o módulo esta em grade
Public vgTemFiltro As Integer                      'flag se tem ou não filtro no módulo
Public vgCancelou As Integer                       'flag cancela ou nao o processo do módulo
Public vgQueryAtual As String                      'expressão SQL definada para o módulo
Public vgTooltips As New cTooltips                'classe de ajuda para os controes do módulo
Public vgFG As frmGauge                            'formulário do gauge
Public vgQReg As Long                              'quantidade de já feita para o gauge
Public vgFP As New frmPreview                      'formuário de preview do relatório
Public vgFrmOrigem As Form
Public vgPosLin As Single                          'posição atual de impressão
Public vgArqExportados As String                   'nome do arquivo para exporatação

Dim txtCampo(3) As New FormataCampos               'classe dos compos tipo texto do módulo
Dim opcFrame0(3) As New FormataCampos
Dim opcFrame2(2) As New FormataCampos
Dim vgFormatarTexto As New FormataCampos
Dim vgDestRel As Integer, vgArquivo As String, vgFormatoSaida As FORMA_EXPORTACAO, vgFormatoTXT As Integer, vgSeparador As String, vgDelimitador As String
Dim vgDataInicial As Variant                       'data que iniciou o relatório
Dim vgPrimeiroCab As Integer                       'flag se ja foi impresso o primeiro cabeçlho do relatório
Dim vgTabReferencia As Object
Dim trvItem As MSComctlLib.Node
Public vgVisivel As Boolean                         'se a tela de parâmetros do relatório esta visível

Dim vgBookPg() As Variant                           'marcador do registro do inicio da página
Dim vgPagRef() As Integer                           'Ordem da página dentro do intervalo
Dim vgPodeVoltar() As Boolean                       'se pode ou não retroceder para esta página
Dim vgWidthRel As Single                            'lagura do relatório
Dim vgHeightRel As Single                           'altura do relatório
Dim vgLarg As Single
Dim vgAlt As Single

Dim vgPgTotCps() As Double
Dim vgPgTotCpsQb() As Double
Dim vgQuebras() As String, vgQtQuebras As Integer
Dim vgTp As GCOLUMN_TYPE


Private Sub botCancelaQb_Click()
   trvQB.Nodes.Clear
   FraQuebra.Visible = False
   botOk.SetFocus
End Sub

Private Sub lstCps_Click()
   Dim i As Integer, vgTp As Integer
   For i = 0 To vgFrmOrigem.grdBrowse.ColumnCount - 1  '     'enche a lista com campos númericos...
      If vgFrmOrigem.grdBrowse.ColumnWidth(i + 1) > 0 Then 'se a coluna no grid está visivel
         vgTp = vgFrmOrigem.grdBrowse.ColumnType(i + 1)
         If vgTp = TP_NUMERICO Then
            If PegaAtributo$(vgFrmOrigem.vgTb.Fields(i).Name, 3) = lstCps.Text Then
               Set BotTotQb.Picture = LoadPicture(LoadGasPicture(780))
               BotTotQb.Enabled = True
               Exit For
            Else
               Set BotTotQb.Picture = LoadPicture(LoadGasPicture(790))
               BotTotQb.Enabled = False
            End If
         End If
      End If
   Next
End Sub

Private Sub lstCps_DblClick()
   If lstCps.ListIndex <> -1 Then
      botInclui_Click
   End If
End Sub

Private Function PegaIndQb() As Integer
   Dim i As Integer, RetVal As Integer
   RetVal = 1
   For i = 2 To trvQB.Nodes.count
      If trvQB.Nodes(i).Parent = trvQB.Nodes("ROOT") Then
         If Left(trvQB.Nodes(i).Key, 2) = "QB" Then
            RetVal = RetVal + 1
         End If
      End If
   Next
   PegaIndQb = RetVal
End Function

Private Sub botExclui_Click()
   Dim x As String, trvItem As MSComctlLib.Node
      If trvQB.SelectedItem <> trvQB.Nodes("ROOT") Then        'se não for o root
      Set trvItem = trvQB.SelectedItem
      If trvItem.Parent = trvQB.Nodes("ROOT") Then             'se estiver sobre uma quebra
         x = "a quebra"
      Else
         If trvQB.SelectedItem.Parent.Children = 1 Then        'se for o último campo da quebra
            x = "a quebra"
            Set trvItem = trvQB.SelectedItem.Parent            'vamos excluir a própria quebra
         Else
            x = "o campo"
         End If
      End If
      If MsgBox(LoadGasString(7630) + vbCrLf + x + "?", vbQuestion + vbYesNo) = vbYes Then
         trvQB.Nodes.Remove trvItem.Index                      'exclui o item
         trvQB.Nodes("ROOT").EnsureVisible                     'vamos mostrar o root
         trvQB.Nodes("ROOT").Selected = True                   'e seleciona-lo
      End If
      Set trvItem = Nothing
   End If
End Sub

Private Sub botInclui_Click()
   Dim NovaQb As Boolean, trvItem As MSComctlLib.Node, IndQb As Integer, cp As String
   On Error Resume Next
   NovaQb = (trvQB.SelectedItem.key = "ROOT")       'verifica se tem que criar uma nova quebra
   cp = lstCps.Text                                 'campo para inserir na quebra
   
   If NovaQb Then                                   'se for nova quebra
      IndQb = PegaIndQb                             'vamos pegar um novo índice para a quebra
      Set trvItem = trvQB.Nodes.Add("ROOT", tvwChild, "QB" + CStr(IndQb), LoadGasString(5330) & " " & CStr(IndQb)) 'adiciona a quebra
   Else                                           'se não
      If trvQB.SelectedItem.Parent = trvQB.Nodes("ROOT") Then 'se o parent do node selecionado for o root
         Set trvItem = trvQB.SelectedItem                     'usa o próprio node (Está em um node de quebra)
      Else                                        'se não
         Set trvItem = trvQB.SelectedItem.Parent  'usa o parent do node selecionado (está em um campo)
      End If
   End If
   
   On Error Resume Next                           'ignora erros

   trvItem.Expanded = True

   Set trvItem = trvQB.Nodes.Add(trvItem, tvwChild, cp, cp) 'acrescenta o campo na quebra
   
   If Err.Number = 35602 Then                               'já tem esse campo para essa quebra...
      If NovaQb Then trvQB.Nodes.Remove trvItem.Index       'mata a quebra se acabou de inserir
      MsgBox LoadGasString(7640), vbExclamation             'avisa
   Else
      If lstCps.ListIndex < lstCps.ListCount - 1 Then
         lstCps.ListIndex = lstCps.ListIndex + 1
      End If
   End If
   
   Set trvItem = Nothing
   
   trvQB.Nodes("ROOT").EnsureVisible                        'vamos mostrar o root
   trvQB.Nodes("ROOT").Selected = True                      'e seleciona-lo
   
End Sub
Private Sub IncluiTotQuebra()
Dim NovaQb As Boolean, trvItem As MSComctlLib.Node, cp As String
      NovaQb = (trvQB.SelectedItem.Key = "ROOT")        'verifica se tem que criar uma nova quebra
      
   cp = lstCps.Text + "(+)"                             'campo para inserir na quebra

   
   If NovaQb Then                                       'se for nova quebra
      MsgBox LoadGasString(7650)
      Exit Sub
   Else                                                 'se não
      If trvQB.SelectedItem.Parent = trvQB.Nodes("ROOT") Then 'se o parent do node selecionado for o root
         Set trvItem = trvQB.SelectedItem                     'usa o próprio node (Está em um node de quebra)
      Else                                        'se não
         Set trvItem = trvQB.SelectedItem.Parent  'usa o parent do node selecionado (está em um campo)
      End If
   End If
   
   On Error Resume Next                           'ignora erros
   trvItem.Expanded = True
   Set trvItem = trvQB.Nodes.Add(trvItem, tvwChild, cp, cp) 'acrescenta o campo na quebra
   trvItem.ForeColor = &HFF0000
   If Err.Number = 35602 Then                               'já tem esse campo para essa quebra...
      If NovaQb Then trvQB.Nodes.Remove trvItem.Index       'mata a quebra se acabou de inserir
      MsgBox LoadGasString(7660), vbExclamation             'avisa
   Else
      If lstCps.ListIndex < lstCps.ListCount - 1 Then
         lstCps.ListIndex = lstCps.ListIndex + 1
      End If
   End If
   
   Set trvItem = Nothing
   
   trvQB.Nodes("ROOT").EnsureVisible                        'vamos mostrar o root
   trvQB.Nodes("ROOT").Selected = True                      'e seleciona-lo
   
End Sub

Private Sub botOkQb_Click()
   Dim trvItem As MSComctlLib.Node, i As Integer
   vgQtQuebras = 0
   ReDim vgQuebras(0) As String
   For i = 2 To trvQB.Nodes.count
      If trvQB.Nodes(i).Parent = trvQB.Nodes("ROOT") Then
         If Left(trvQB.Nodes(i).Key, 2) = "QB" And trvQB.Nodes(i).Children > 0 Then
            Set trvItem = trvQB.Nodes(i).Child
            If InStr(trvItem.Text, "(+)") = 0 Then
               vgQtQuebras = vgQtQuebras + 1
               ReDim Preserve vgQuebras(vgQtQuebras) As String
         
               Do
                  If trvItem.Parent <> trvQB.Nodes(i) Then Exit Do
                  vgQuebras(vgQtQuebras) = vgQuebras(vgQtQuebras) + "|" + IIf(InStr(trvItem.Text, "(+)") = 0, trvItem.Text, "")
                  Set trvItem = trvItem.Next
               Loop Until trvItem Is Nothing
            End If
            If Len(vgQuebras(vgQtQuebras)) Then vgQuebras(vgQtQuebras) = vgQuebras(vgQtQuebras) + "|"
            Set trvItem = Nothing
         End If
      End If
   Next
   FraQuebra.Visible = False
   botOk.SetFocus
End Sub


Private Sub botQuebra_Click()
   FraQuebra.Visible = True
   FraQuebra.ZOrder
   lstCps.SetFocus
End Sub

Private Sub BotTotQb_Click()
   IncluiTotQuebra
End Sub


Private Sub botCancela_Click()
   Unload Me
End Sub

Private Sub botConfImp_Click()
   Dim x As String
   ConfigImpressora                                   'chama diáglogo de configuração impressora
   x$ = Printer.DeviceName
   Label(1).Caption = x$
   With vgFP
      Set .vgFormRel = Me
      .vgContaPg = 0
      vgLarg = Printer.ScaleX(Printer.ScaleWidth, Printer.ScaleMode, vbMillimeters)
      vgAlt = Printer.ScaleY(Printer.ScaleHeight, Printer.ScaleMode, vbMillimeters)
      vgWidthRel = 520 + Printer.ScaleX(Printer.ScaleWidth, Printer.ScaleMode, .ScaleMode)
      vgHeightRel = 720 + Printer.ScaleY(Printer.ScaleHeight, Printer.ScaleMode, .ScaleMode)
      .picAux.Width = vgWidthRel
      .picAux.Height = vgHeightRel
      .Caption = LoadGasString(7505) + Me.Caption
      .picInterna.Move 0, 0, vgWidthRel, vgHeightRel
      .picAux.ScaleMode = vbMillimeters
      .picAux.Scale (0, 0)-(197.0018, 286.8078)
   End With
   vgWidthRel = vgWidthRel - 520
   vgHeightRel = vgHeightRel - 720
End Sub

Private Sub botOk_Click()
   Dim k As String, i As Integer, j As Integer
   If vgPriVez Then Exit Sub
   vgPriVez = True
   k$ = Executar(VALIDACOES)                          'faz validaçao dos campos
   If Len(k$) > 0 Then                                'EPA!... tem campo errado
      If InStr(k$, "|") > 0 Then
         Err.Source = Parse$(k$, "|")
         Err.Number = Parse$(k$, "|")                 'deu erro
         Err.Description = Parse$(k$, "|")
         CErr.NumErro = Err.Number
         CErr.Show
      Else
         Beep                                         'manda aviso sonoro
         MsgBox k$, vbCritical, vgAtencao$            'mostra mensagem do erro
      End If
      Screen.MousePointer = vbDefault                 'reseta o pointer do mouse
      vgPriVez = False
      Exit Sub                                        'e sai para continuar a ediçao ou inclusao
   End If                                             'OK. os campos estao certos
   Set vgTabReferencia = vgFrmOrigem.vgTb.Clone
   j = 0
   For i = 0 To lstTotal.ListCount - 1
      If lstTotal.Selected(i) Then
         j = j + 1
      End If
   Next
   ReDim vgPgTotCps(j, 0) As Double
   j = 0
   For i = 2 To trvQB.Nodes.count
      If trvQB.Nodes(i).Parent = trvQB.Nodes("ROOT") Then
         If Left(trvQB.Nodes(i).Key, 2) = "QB" And trvQB.Nodes(i).Children > 0 Then
            Set trvItem = trvQB.Nodes(i).Child
            Do
               If trvItem.Parent <> trvQB.Nodes(i) Then Exit Do
               If InStr(trvItem.Text, "(+)") > 0 Then
                  j = j + 1
               End If
               Set trvItem = trvItem.Next
            Loop Until trvItem Is Nothing
         End If
         Set trvItem = Nothing
      End If
   Next
   ReDim vgPgTotCpsQb(j, 0) As Double
   vgFP.vgFimDoArq = False                            'é fim do arquivo
   vgFP.vgContaPg = 0                                 'contador de paginas
   vgFP.vgNovaPag = 0                                 'número da página real dentro do intervalo (Ex: 3;5;1;2 - se estiver na página real 5, a página atual será 2)
   vgFP.vgPagRef = 0                                  'número da página de referência
   vgFP.vgUltPagVista = 0                             'ate onde ja fomos...
   If vgDestRel = 0 Then                              'onde vai ser gerado (janela ou papel)
      vgFP.cboEscala.ListIndex = 3                    'escal 100%
      ProssegueExecucao vgFP.picAux                   'faz preview
      If vgPrimeiroCab <> 2 Then                      'se não deu erro
         If vgPrimeiroCab Then                        'nenhuma página foi impressa
            MsgBox LoadGasString(92), vbExclamation, vgAtencao$ 'apresenta a mensagem
         Else
            vgFP.ShowPreview                                    'arruma form preview
            vgFP.Visible = True                                 'mostra form de preview
            Visible = False                                     'esconde o este form
            vgVisivel = False                                   'e seta variavel
         End If
      End If
   ElseIf vgDestRel = 1 Then
      ProssegueExecucao Printer                                 'joga direto na impressora
   ElseIf vgDestRel = 2 Then
      vgFP.vgContaPg = 0
      ProssegueExecucao vgFP.picAux, , vgFormatoSaida, vgArquivo$
   ElseIf vgDestRel = 3 Then
      vgFP.vgContaPg = 0
      Load frmEnviaEMail
      Hide
      Set frmEnviaEMail.frmRel = Me
      frmEnviaEMail.Show
   End If
   vgPriVez = False
End Sub

'evento - quando o botão for apertado
Private Sub bottxtCampo0_Click()
   txtCampo(0).botClick BOT_COMBO
End Sub

'evento - quando o botão for apertado
Private Sub bottxtCampo1_Click()
   Dim Cancel As Boolean
   txtCampo_ButtonClick 1, Cancel
   DoEvents
   If Not Cancel Then
      txtCampo(1).botClick BOT_ACAO
   End If
End Sub

'Clique dos botões para combo
Private Sub txtCampo_ButtonClick(Index As Integer, Cancel As Boolean)
   If vgPriVez Then Exit Sub
   Select Case Index
      Case 1
         PegaArqDefa Index
   End Select
End Sub

Private Sub Form_Activate()
   DoEvents
   AtivaForm Me
   Err.Clear
End Sub

'Inicialização do form
Private Sub Form_Load()
   Screen.MousePointer = vbHourglass
   If Len(vgFrmOrigem.Caption) = 0 Then
      vgFrmOrigem.Caption = vgFrmOrigem.grdBrowse.Caption
   End If
   Caption = LoadGasString(5328) + vgFrmOrigem.Caption   'Impressão de
   vgFormID = 9999
   vgIdentTab = ""
   vgPriVez = True
   vgTipo = TP_FPW
   vgCaracteristica = F_COMUM
   vgTemFiltro = False
   DesligaRepara
   ReDim vgBookPg(0) As Variant, vgPodeVoltar(0) As Boolean, vgPagRef(0) As Integer
   Load vgFP
   With vgFP
      Set .vgFormRel = Me
      .vgContaPg = 0
      vgLarg = Printer.ScaleX(Printer.ScaleWidth, Printer.ScaleMode, vbMillimeters)
      vgAlt = Printer.ScaleY(Printer.ScaleHeight, Printer.ScaleMode, vbMillimeters)
      vgWidthRel = 520 + Printer.ScaleX(Printer.ScaleWidth, Printer.ScaleMode, .ScaleMode)
      vgHeightRel = 720 + Printer.ScaleY(Printer.ScaleHeight, Printer.ScaleMode, .ScaleMode)
      .picAux.Width = vgWidthRel
      .picAux.Height = vgHeightRel
      .Caption = LoadGasString(7505) + Me.Caption
      .picInterna.Move 0, 0, vgWidthRel, vgHeightRel
      .picAux.ScaleMode = vbMillimeters
      .picAux.Scale (0, 0)-(197.0018, 286.8078)
   End With
   vgWidthRel = vgWidthRel - 520
   vgHeightRel = vgHeightRel - 720
   vgVisivel = True
   vgSituacao = ACAO_NAVEGANDO
   Set botConfImp.Picture = LoadPicture(LoadGasPicture(670))
   Set botOk.Picture = LoadPicture(LoadGasPicture(230))
   Set botCancela.Picture = LoadPicture(LoadGasPicture(661))
   Set botQuebra.Picture = LoadPicture(LoadGasPicture(750))
   DefineControles
   vgTooltips.Create
   frame(0).Caption = LoadGasString(5301)                'Destino do relatório
   opcFrame0Cp(0).Caption = LoadGasString(5302)          'Janela
   opcFrame0Cp(1).Caption = LoadGasString(5303)          'Impressora
   opcFrame0Cp(2).Caption = LoadGasString(5304)          'Arquivo
   opcFrame0Cp(3).Caption = LoadGasString(5305)          'Destinatário de correio
   frame(2).Caption = LoadGasString(5324)                'Formato TXT
   opcFrame2Cp(0).Caption = LoadGasString(5325)          'Sem formatação
   opcFrame2Cp(1).Caption = LoadGasString(5326)          'Formato SDF
   opcFrame2Cp(2).Caption = LoadGasString(5327)          'Texto delimitado
   frame(1).Caption = LoadGasString(5323)                'Arquivo de saída
   Label(0).Caption = LoadGasString(5313)                'Impressora padrão
   Label(1).Caption = Printer.DeviceName
   Label(2).Caption = LoadGasString(5318)                'Formato:
   Label(3).Caption = LoadGasString(5319)                'Nome:
   Label(4).Caption = LoadGasString(5320)                'Separador:
   Label(5).Caption = LoadGasString(5321)                'Delimitador:
   fraTotal.Caption = LoadGasString(5322)                'Totaliza colunas
   fraQuebra.Caption = LoadGasString(5329)               'Expressão para quebra
   vgTooltips.AddTool botConfImp, 0, LoadGasString(5314) 'Troca/configura impressora conectada
   vgTooltips.AddTool botOk, 0, LoadGasString(5315)      'Prossegue a operação
   vgTooltips.AddTool botCancela, 0, LoadGasString(5316) 'Cancela a operação
   Executar INICIALIZACOES
   InicializaApelidos
   ExecutaPreValidacao
   AjustaTamanho Me
   Dim i As Integer, j As Long, vgNCp As String, vgTitCp As String
   
   Set botOkQb.Picture = LoadPicture(LoadGasPicture(200))
   Set botCancelaQb.Picture = LoadPicture(LoadGasPicture(263))
   Set botInclui.Picture = LoadPicture(LoadGasPicture(760))
   Set botExclui.Picture = LoadPicture(LoadGasPicture(770))
   Set BotTotQb.Picture = LoadPicture(LoadGasPicture(790))
   
   FraQuebra.Left = Frame(0).Left - 30
   FraQuebra.Top = Frame(0).Top - 30
   FraQuebra.Width = Frame(1).Left + Frame(1).Width - Frame(0).Left + 60
   FraQuebra.Height = Label(1).Top + Label(1).Height - Frame(0).Top + 60
   FraQuebra.ZOrder
   
   botOkQb.Left = FraQuebra.Width - botOkQb.Width * 2 - 120
   botOkQb.Top = FraQuebra.Height - botOkQb.Height - 120
   botCancelaQb.Left = botOkQb.Left + botOkQb.Width
   botCancelaQb.Top = botOkQb.Top
   
   lstCps.Left = 90
   lstCps.Top = 240
   lstCps.Height = botOkQb.Top - 360
   lstCps.Width = (FraQuebra.Width - botInclui.Width - 240) / 2 '- 120 - 60

   botInclui.Left = lstCps.Left + lstCps.Width + 30
   botInclui.Top = lstCps.Top
      
   BotTotQb.Top = botInclui.Top + botInclui.Height
   BotTotQb.Left = botInclui.Left
   BotTotQb.Enabled = False
      
   botExclui.Top = BotTotQb.Top + BotTotQb.Height
   botExclui.Left = BotTotQb.Left
      
   trvQB.Left = botInclui.Left + botInclui.Width + 30
   trvQB.Top = lstCps.Top
   trvQB.Height = lstCps.Height
   trvQB.Width = lstCps.Width
   
   
   'inclui módulo principal da treeview
   trvQB.Nodes.Add , , "ROOT", LoadGasString(5330) & "s"
   trvQB.Nodes("ROOT").Selected = True
   trvQB.Nodes("ROOT").Expanded = True
   
   'usa essa tabela como referência
   Set vgTabReferencia = vgFrmOrigem.vgTb
   
   'enche a lista de campos da quebra
   lstCps.Clear                                                 'limpa lista de campos
   For i = 1 To vgFrmOrigem.grdBrowse.Columns.Count
      vgNCp$ = vgFrmOrigem.grdBrowse.ColumnOrdered(i).Name      'nome do campo
      vgTp = vgFrmOrigem.grdBrowse.ColumnOrdered(i).ColumnType
      If vgTp <> TP_BINARIO And vgFrmOrigem.grdBrowse.ColumnOrdered(i).Hidden = False Then 'imagem ou campo invisivel não pode
         vgTitCp$ = vgFrmOrigem.grdBrowse.ColumnOrdered(i).Title                           'titulo do campo
         lstCps.AddItem vgTitCp$
         lstCps.itemData(lstCps.NewIndex) = i - 1                                          'numero do campo dentro da tabela
      End If
   Next  
   'seleciona o primeiro campo
   lstCps.ListIndex = 0
   
   ReDim vgQuebras(0) As String
   vgQtQuebras = 0
   
   FraQuebra.Visible = False

   Screen.MousePointer = vbDefault
   vgPriVez = False
End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)
   Cancel = (Not vgFG Is Nothing)
End Sub

Private Sub Form_Unload(Cancel As Integer)
   Dim i As Integer
   FinalizaForm Me                                    'ativa rotinas de finalização deste form
   For i = 0 To UBound(txtCampo)
      txtCampo(i).Finalize
      Set txtCampo(i) = Nothing
   Next
   For i = 0 To UBound(opcFrame0)
      opcFrame0(i).Finalize
      Set opcFrame0(i) = Nothing
   Next
   For i = 0 To UBound(opcFrame2)
      opcFrame2(i).Finalize
      Set opcFrame2(i) = Nothing
   Next
   If vgRelAtivo = vgFormID Then vgRelAtivo = 0
   On Error Resume Next
   Unload vgFP
   Set vgFP = Nothing                                 'tira o form de preview da memória
   Set vgFG = Nothing
   Set vgFormatarTexto = Nothing                      'Descarrega formatador de campos numéricos em texto SDF
End Sub
'Monta a expressao da Quebra na impressao da consulta
Private Function MontaExpQuebra(ByVal vgTab As Object, vgQQb As Integer) As String
   Dim RetVal As String, x As String, z As String
   x = Mid(vgQuebras(vgQQb), 2)
   If Len(x) = 0 Then RetVal = vgQuebras(vgQQb)
   Do While Len(x)
      z = Parse(x, "|")
      If Len(z) Then
         RetVal = RetVal + (vgTab.Fields(z).Value & "") + "|"
      End If
   Loop
   
   MontaExpQuebra = RetVal
End Function



'define as propriedades das classe dos campos do formuário
Private Sub DefineControles()

   Set opcFrame0(0).CtPri = opcFrame0Cp(0)
   Set opcFrame0(0).CtFdo = labopcFrame0
   opcFrame0(0).DataType = 6
   opcFrame0(0).BookMark = 0

   Set opcFrame0(1).CtPri = opcFrame0Cp(1)
   Set opcFrame0(1).CtFdo = labopcFrame0
   opcFrame0(1).DataType = 6
   opcFrame0(1).BookMark = 1

   Set opcFrame0(2).CtPri = opcFrame0Cp(2)
   Set opcFrame0(2).CtFdo = labopcFrame0
   opcFrame0(2).DataType = 6
   opcFrame0(2).BookMark = 2

   Set opcFrame0(3).CtPri = opcFrame0Cp(3)
   Set opcFrame0(3).CtFdo = labopcFrame0
   opcFrame0(3).DataType = 6
   opcFrame0(3).BookMark = 3

   Set opcFrame2(0).CtPri = opcFrame2Cp(0)
   Set opcFrame2(0).CtFdo = labopcFrame2
   opcFrame2(0).DataType = 6
   opcFrame2(0).BookMark = 0

   Set opcFrame2(1).CtPri = opcFrame2Cp(1)
   Set opcFrame2(1).CtFdo = labopcFrame2
   opcFrame2(1).DataType = 6
   opcFrame2(1).BookMark = 1

   Set opcFrame2(2).CtPri = opcFrame2Cp(2)
   Set opcFrame2(2).CtFdo = labopcFrame2
   opcFrame2(2).DataType = 6
   opcFrame2(2).BookMark = 2

   Set txtCampo(0).CtPri = txtCp(0)
   Set txtCampo(0).CtFdo = labFdo0
   Set txtCampo(0).CtBot(0) = bottxtCampo0
   Set bottxtCampo0.Picture = LoadPicture(LoadGasPicture(3))
   txtCampo(0).DataType = 0
   txtCampo(0).ListFields = "Html|Texto (ASCII)|Microsoft Word (Doc)|Jpg|Gif|Bitmap (Bmp)"

   Set txtCampo(1).CtPri = txtCp(1)
   Set txtCampo(1).CtFdo = labFdo1
   Set txtCampo(1).CtBot(0) = bottxtCampo1
   Set bottxtCampo1.Picture = LoadPicture(LoadGasPicture(4))
   txtCampo(1).DataType = 0
   txtCampo(1).Mask = ""

   Set txtCampo(2).CtPri = txtCp(2)
   txtCampo(2).DataType = 0
   txtCampo(2).Mask = "@!"
   txtCampo(2).MaxLength = 1

   Set txtCampo(3).CtPri = txtCp(3)
   txtCampo(3).DataType = 0
   txtCampo(3).Mask = "@!"
   txtCampo(3).MaxLength = 1

End Sub

'evento - quando o conteúdo do campo for alterado
Private Sub txtCp_Change(Index As Integer)
   If vgPriVez Or txtCampo(Index).PriVez Then Exit Sub
   InicializaApelidos
   txtCampo(Index).Change
   If Index = 0 Then
      ExecutaPreValidacao
      txtCp_GotFocus Index
   End If
End Sub

'evento - quando o campo receber o foco
Private Sub txtCp_GotFocus(Index As Integer)
      Dim x As String, i As Long
      On Error Resume Next
      Select Case Index
         Case 0
            If Len(txtCampo(0).Value) = 0 Then
               txtCampo(0).Value = 0
            Else
               x$ = Choose(vgFormatoSaida + 1, "html", "txt", "doc", "jpg", "gif", "bmp")
               If Right(vgArquivo$, Len(x$)) <> x$ And Len(vgArquivo$) > 0 Then
                  i = Rat(vgArquivo$, ".")
                  If i > 0 Then
                     txtCampo(1).Value = Left(vgArquivo$, i) + x$
                  Else
                     txtCampo(1).Value = vgArquivo$ + "." + x$
                  End If
               End If
            End If
            InicializaApelidos
            ExecutaPreValidacao
         Case 1
            If Len(txtCp(1).Text) = 0 Then
               txtCampo(1).Value = vgDirEXE$ + "Temp." + Choose(vgFormatoSaida + 1, "html", "txt", "doc", "jpg", "gif", "bmp")
               InicializaApelidos
               ExecutaPreValidacao
            End If
         Case 2
            If Len(txtCp(2).Text) = 0 Then
               txtCampo(2).Value = ","
               InicializaApelidos
               ExecutaPreValidacao
            End If
         Case 3
            If Len(txtCp(3).Text) = 0 Then
               txtCampo(3).Value = Chr(34)
               InicializaApelidos
               ExecutaPreValidacao
            End If
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
   txtCampo(Index).LostFocus                          'executa LostFocus na classe
   ExecutaPreValidacao                                'habilita/desabilita campos
End Sub

'evento - quando uma opção for selecionada
Private Sub opcFrame0Cp_Click(Index As Integer)
   If vgPriVez Then Exit Sub
   If opcFrame0(Index).Locked Then
      opcFrame0(Val(labopcFrame0.Caption)).Value = True
   Else
      If Val(labopcFrame0.Caption) <> opcFrame0(Index).BookMark Then
         labopcFrame0.Caption = Str$(opcFrame0(Index).BookMark)
         InicializaApelidos
         ExecutaPreValidacao
         opcFrame0(Index).Change
      End If
   End If
End Sub

'evento - quando qq tecla for digitada no campo
Private Sub opcFrame0Cp_KeyPress(Index As Integer, KeyAscii As Integer)
   opcFrame0(Index).KeyPress KeyAscii
End Sub

'evento - quando qq tecla for digitada no campo
Private Sub opcFrame0Cp_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
   opcFrame0(Index).KeyDown KeyCode, Shift
End Sub

'evento - quando o campo receber o foco
Private Sub opcFrame0Cp_GotFocus(Index As Integer)
   opcFrame0(Index).GotFocus
End Sub

'evento - quando o campo perder o foco
Private Sub opcFrame0Cp_LostFocus(Index As Integer)
   opcFrame0(Index).LostFocus
End Sub

'evento - quando uma opção for selecionada
Private Sub opcFrame2Cp_Click(Index As Integer)
   If vgPriVez Then Exit Sub
   If opcFrame2(Index).Locked Then
      opcFrame2(Val(labopcFrame2.Caption)).Value = True
   Else
      If Val(labopcFrame2.Caption) <> opcFrame2(Index).BookMark Then
         labopcFrame2.Caption = Str$(opcFrame2(Index).BookMark)
         InicializaApelidos
         ExecutaPreValidacao
         opcFrame2(Index).Change
      End If
   End If
End Sub

'evento - quando qq tecla for digitada no campo
Private Sub opcFrame2Cp_KeyPress(Index As Integer, KeyAscii As Integer)
   opcFrame2(Index).KeyPress KeyAscii
End Sub

'evento - quando qq tecla for digitada no campo
Private Sub opcFrame2Cp_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
   opcFrame2(Index).KeyDown KeyCode, Shift
End Sub

'evento - quando o campo receber o foco
Private Sub opcFrame2Cp_GotFocus(Index As Integer)
   opcFrame2(Index).GotFocus
End Sub

'evento - quando o campo perder o foco
Private Sub opcFrame2Cp_LostFocus(Index As Integer)
   opcFrame2(Index).LostFocus
End Sub

'inicializa variaveis (apelidos) com os campos correspondentes
Private Sub InicializaApelidos()
   On Error Resume Next                               'prepara para possíveis erros
   vgDestRel = Val(labopcFrame0.Caption)
   vgFormatoTXT = Val(labopcFrame2.Caption)
   vgFormatoSaida = txtCampo(0).ListIndex
   vgSeparador = txtCampo(2).Text
   vgDelimitador = txtCampo(3).Text
   vgArquivo$ = txtCampo(1).Value
   If Err Then Err.Clear                              'se deu algum erro, vamos resetá-lo
End Sub

'executa a pré-validação dos campos
Private Sub ExecutaPreValidacao()
   Dim Ok As Boolean
   On Error Resume Next                               'prepara para possiveis erros
   Ok = (vgDestRel >= 2)
   Frame(1).Enabled = Ok
   txtCampo(0).Enabled = Ok
   txtCampo(1).Enabled = Ok
   Label(2).Enabled = Ok
   Label(3).Enabled = Ok
   Ok = Ok And (vgFormatoSaida = 1)
   Frame(2).Enabled = Ok
   opcFrame2Cp(0).Enabled = Ok
   opcFrame2Cp(1).Enabled = Ok
   opcFrame2Cp(2).Enabled = Ok
   Ok = Ok And (vgFormatoTXT = 2)
   txtCampo(2).Enabled = Ok
   txtCampo(3).Enabled = Ok
   Label(4).Enabled = Ok
   Label(5).Enabled = Ok
   If Err Then Err.Clear                              'se houve erro, limpa...
End Sub

'pega nome do arquivo para exportação
Private Sub PegaArqDefa(Index As Integer)
   Dim dlgArquivo As New cCommonDialog
   On Error GoTo SaiArq                              'prepara para possível erro
   With dlgArquivo                                   'vamos escolher um arquivo para
      .CancelError = True                            'gravar o relatório
      .InitDir = vgDirEXE$                           'diretório default
      .FileName = txtCampo(Index).Text               'nome do arq default
      .DialogTitle = LoadGasString(8650)             'titulo da caixa de diálago
      .Filter = "Todos (*.*)|*.*"                    'típos de arquivos
      .FilterIndex = 0                               'o "todos" será o default
      .flags = OFN_CREATEPROMPT                      'perguntará se irá criar o diretório
      .ShowSave
      txtCampo(Index).Text = .FileName               'mostra arquivo informado
   End With

SaiArq:                                              'se cancelou caxa de diálago...
   Set dlgArquivo = Nothing

End Sub

Public Function ProssegueExecucao(vgObSaida As Object, Optional ByVal vgNumPg As IMPRIME_PAGINA = 0, Optional ByVal vgExporta As FORMA_EXPORTACAO = G_NAO_EXPORTA, Optional ByVal vgArqDestino As String, Optional ByVal vgEnviaEMail As Boolean) As String
   Dim vgPsm As Integer, vgPsz As Integer, vgPfn As String, vgPor As Integer, x As String, z As String
   Dim i As Integer, vgLimiteInf As Single, vgValImp As Variant
   Dim vgNVez As Integer, vgPosX As Single, vgPosY As Single, ii As Single  
   Dim vgEmPapel As Boolean, vgPagOk As Boolean, vgPV As Boolean, vgNumPag As Long
   Dim j As Integer, vgPagOrig As Integer, vgNovaPg As Integer, k As Integer, _
       Ok As Boolean, vgIniProc As Boolean, vgPosCps() As Single, vgLargCps() As Single, vgQtCps As Integer, _
       vgNumLinCab As Integer, vgQtCpsLinha As Integer, vgArqExp As Long, vgTotCps() As Double, vgTotCpsQb() As Double, _
       vgLstTotCps As String, vgLstTotQuebras As String, vgQtTotCps As Integer, vgQtTotCpsQb As Integer, CpCol As String
   Dim PvMemo As Integer, vgQdeLMemo As Long, vgCl As Long, _
       vgIndMemo As Long, vgPosIniMemo As Single, vgPosFimMemo As Single
   Dim vgValQuebras() As String, vgQQb As Integer, EstaQuebrando As Boolean, PoeCp As Boolean, VerificaQb As Boolean
   Dim vgFimTab As Boolean
         
   Screen.MousePointer = vbHourglass                 'mostra ampulheta
   vgCancelou = False
   If TypeOf vgObSaida Is Printer Then               'estamos em preview ou impressora?
      GeraLogAcao LoadGasString(296) + " " + vgFrmOrigem.Caption
      vgEmPapel = True                               'imprimindo na impressora, confirma
   Else
      vgEmPapel = False
      vgObSaida.Cls
      If vgExporta = G_NAO_EXPORTA Or vgExporta = G_EXPORTA_BMP Or vgExporta = G_EXPORTA_JPG Or vgExporta = G_EXPORTA_GIF Then
         vgObSaida.Picture = LoadPicture("")
      End If
      vgFP.scrH.Value = 0                            'acerta scroll do preview
      vgFP.scrV.Value = 0
   End If
   vgDataInicial = Now                               'data e hora do inicio do relatório
   vgNovaPg = -1
   vgIniProc = False                                 'flag para informar que iniciou procura em navegação (próxima, anterior, última...)
   
   vgIndMemo = 0
   PvMemo = 0                                        '0=campo nao memo 1=pv memo 2=imprimindo memo
   vgPosIniMemo = 0
   vgPosFimMemo = 0
   
   vgQtTotCps = 0
   vgQtTotCpsQb = 0
   vgLstTotCps$ = ""
   vgLstTotQuebras = ""
   For i = 0 To lstTotal.ListCount - 1
      If lstTotal.Selected(i) Then
         vgQtTotCps = vgQtTotCps + 1
         vgLstTotCps$ = vgLstTotCps$ + "|" + CStr(lstTotal.itemData(i)) + "-" + CStr(vgQtTotCps)
      End If
   Next
   
   For i = 2 To trvQB.Nodes.count
      If trvQB.Nodes(i).Parent = trvQB.Nodes("ROOT") Then
         If Left(trvQB.Nodes(i).Key, 2) = "QB" And trvQB.Nodes(i).Children > 0 Then
            Set trvItem = trvQB.Nodes(i).Child
            Do
               If trvItem.Parent <> trvQB.Nodes(i) Then Exit Do
               If InStr(trvItem.Text, "(+)") > 0 Then
                  vgQtTotCpsQb = vgQtTotCpsQb + 1
               End If
               If InStr(trvItem.Text, "(+)") > 0 Then
                  For ii = 0 To lstCps.ListCount - 1
                     If lstCps.List(ii) = Retira(trvItem.Text, "(+)", SO_UM) Then
                        vgLstTotQuebras = vgLstTotQuebras + "|" + CStr(lstCps.itemData(ii)) + "-" + CStr(vgQtTotCpsQb)
                     End If
                  Next
               End If
               Set trvItem = trvItem.Next
            Loop Until trvItem Is Nothing
         End If
         Set trvItem = Nothing
      End If
   Next
   If Len(vgLstTotCps$) > 0 Then vgLstTotCps$ = vgLstTotCps$ + "|"
   If Len(vgLstTotQuebras) Then vgLstTotQuebras = vgLstTotQuebras + "|"
   ReDim vgPosCps(vgFrmOrigem.grdBrowse.Columns.count - 1) As Single
   ReDim vgLargCps(vgFrmOrigem.grdBrowse.Columns.Count - 1) As Single
   ReDim vgTotCps(vgQtTotCps) As Double
   ReDim vgTotCpsQb(vgQtTotCpsQb) As Double
   If vgNumPg = G_IMP_ATUA_PG Then                   'solicitou impressão da página atual
      vgNumPg = vgFP.vgContaPg
   End If

OutraCopia:
   On Error GoTo DeuErro                             'vamos cercar erros...
   If vgQtQuebras = 0 Then
      vgQtQuebras = 1
      ReDim vgValQuebras(vgQtQuebras) As String
      ReDim vgQuebras(vgQtQuebras) As String
      vgValQuebras(vgQtQuebras) = "*"
      vgQuebras(vgQtQuebras) = "*"
   Else
      ReDim vgValQuebras(vgQtQuebras) As String
   End If

   'abre os recordsets
   vgPV = (vgNumPg = 0 Or (vgEmPapel And vgFP.vgContaPg > 0)) 'veio do botao de prosseguir?
   If vgPV And Not (vgEmPapel And vgFP.vgContaPg > 0) Then
      ReDim vgBookPg(0) As Variant                            'cria variável para salvar bookmark
      ReDim vgPodeVoltar(0) As Boolean                        'controle de quebra em filhos
      GoSub IniciaImpressao
   Else
      If vgNumPg >= 0 And (vgEmPapel And vgFP.vgContaPg > 0) Then
         GoSub IniciaImpressao
      End If
      vgPagOrig = vgFP.vgPagRef
      If vgNumPg > 0 Then                                     'se estiver indo para alguma página específica
         vgFP.vgNovaPag = vgNumPg
         If vgNumPg > UBound(vgBookPg()) Then
            vgNumPg = UBound(vgBookPg())
         End If
         vgNovaPg = vgNumPg - 1
         vgFP.vgProcuraPg = (vgNumPg <> vgFP.vgNovaPag)
      ElseIf vgNumPg = G_IMP_PROX_PG Or vgNumPg = G_IMP_ANT_PG Then
         i = (vgNumPg = G_IMP_ANT_PG) ^ (vgNumPg = G_IMP_ANT_PG) 'i=+1 para G_IMP_PROX_PG e i=-1 para G_IMP_ANT_PG
         vgFP.vgProcuraPg = False
         vgNovaPg = vgFP.vgContaPg + (i * 1) - 1
      ElseIf vgNumPg = G_IMP_PRI_PG Or vgNumPg = 0 Then
         If vgEmPapel And vgFP.vgContaPg > 0 Then                'se for em papel... e tiver vindo do botão IMPRIME do preview...
            vgPagOrig = vgFP.vgPagRef
         End If
         vgFP.vgProcuraPg = False
         vgNovaPg = 0
      ElseIf vgNumPg = G_IMP_ULT_PG Then
         If UBound(vgBookPg()) > 0 Then
            vgNovaPg = UBound(vgBookPg()) - 1
         End If
         vgFP.vgProcuraPg = True
         vgIniProc = True                                        'flag para informar que iniciamos procura
         vgFP.vgNovaPag = 0
      End If
   End If
   If vgNovaPg >= 0 Then
      If vgPodeVoltar(vgNovaPg + 1) = False And vgNovaPg > 0 Then
         If Not vgFP.vgProcuraPg Then                            'se nao esta indo para pg ou ultima pg
            vgFP.vgProcuraPg = True
            vgIniProc = True                                     'flag para informar que iniciamos procura
            vgFP.vgPagRef = vgFP.vgNovaPag
         End If
         Do While vgPodeVoltar(vgNovaPg + 1) = False             'acerto para não deixar voltar página com quebra em filho
            vgNovaPg = vgNovaPg - 1
         Loop
         vgFP.vgPagRef = vgFP.vgNovaPag
      End If
      vgFP.vgContaPg = vgNovaPg
      vgTabReferencia.BookMark = vgBookPg(vgNovaPg + 1)
      vgNumPag = vgNovaPg + 1
   Else
      vgFP.vgPagRef = 1
   End If
   vgFP.botPara.Enabled = (vgFP.vgProcuraPg Or vgNumPg = G_IMP_ULT_PG) 'habilita/desabilita stop
   vgPrimeiroCab = True

   'Lista a consulta
   If vgTabReferencia.RecordCount > 0 Then
      If vgNumPg = 0 And Not (vgEmPapel And vgFP.vgContaPg > 0) Then
         vgTabReferencia.MoveFirst
      End If
      If ((vgEmPapel And vgNumPg = 0) Or vgExporta <> G_NAO_EXPORTA) And vgPrimeiroCab Then
         vgQReg = 0
         Set vgFG = New frmGauge
         Load vgFG
         Set vgFG.vgFrmOrigem = Me
         vgFG.MostraGauge
         If vgEnviaEMail Then
            vgFG.Caption = LoadGasString(1150)
         End If
      End If
      vgLimiteInf = vgAlt
      On Error Resume Next
      For j = 1 To vgQtTotCps
         vgTotCps(j) = vgPgTotCps(j, vgNumPag)
      Next
      
      For j = 1 To vgQtTotCpsQb
         vgTotCpsQb(j) = vgPgTotCpsQb(j, vgNumPag)
      Next
      
      VerificaQb = True
      EstaQuebrando = False
      
      Do While Not vgTabReferencia.EOF
         For vgQQb = 1 To vgQtQuebras                                  'vamos verificar cada uma das quebras
            
            'faz o controle de quebras
            If VerificaQb Then
               x = MontaExpQuebra(vgTabReferencia, vgQQb)
               If x = "*" Then VerificaQb = False
               EstaQuebrando = (x <> "*" And x <> vgValQuebras(vgQQb))
               If EstaQuebrando Then                                   'se tem quebra e está quebrando nessa quebra...
                  vgValQuebras(vgQQb) = x
                  For j = vgQQb + 1 To vgQtQuebras                     'vamos resetar todas as quebras filhas
                     vgValQuebras(j) = ""
                  Next
               End If
            End If
         
            vgFP.vgFimDoArq = False
            If vgExporta <> G_EXPORTA_TXT Or (vgExporta = G_EXPORTA_TXT And vgFormatoTXT = 0) Then
               If vgPrimeiroCab Or vgPosLin + 5 > vgLimiteInf Then
                  vgPagOk = True
                  If Not vgEmPapel And vgPrimeiroCab = False And vgExporta = G_NAO_EXPORTA Then
                     GoSub SalvaPagina
                     If Not vgFP.vgProcuraPg Then                      'se não está procurando por uma página
                        If vgFP.vgContaPg <> vgFP.vgNovaPag And vgNumPg > 0 Then
                           GoSub RestauraPag
                           GoSub SalvaPagina
                        End If
                        GoTo SaiDaSub                                  'cai fora
                     End If
                  ElseIf vgEmPapel And vgNumPg > 0 And Not vgPrimeiroCab Then
                     If vgFP.vgContaPg = vgFP.vgNovaPag Then GoTo CancelouRel
                  ElseIf vgNumPg = 0 And Not vgPrimeiroCab Then
                     GoSub SalvaInicioPg
                  End If
                  GoSub OutraFolha
                  On Error Resume Next
                  If vgExporta = G_EXPORTA_WORD Or vgExporta = G_EXPORTA_GIF Then
                     vgQReg = 0
                  End If
               End If
            End If
            If EstaQuebrando Then
               vgPosLin = vgPosLin + 5
               GoSub ImprimeCabRel
            End If
            ii = 0
            z$ = ""
            If PvMemo = 0 Then
               vgQtCps = 0
            End If
            If EstaQuebrando Or Not VerificaQb Then
               For i = vgIndMemo To vgFrmOrigem.grdBrowse.Columns.Count - 1     
                  CpCol = vgFrmOrigem.grdBrowse.ColumnOrdered(i + 1).Name
                  vgTp = vgTabReferencia.Table.Columns(CpCol).ColumnType
                  If EstaQuebrando Then
                     PoeCp = InStr(UCase(vgQuebras(vgQQb)), "|" + UCase(CpCol) + "|") > 0
                  Else
                     PoeCp = (vgTp <> TP_BINARIO And vgFrmOrigem.grdBrowse.ColumnWidth(CpCol) > 0)

                     If PoeCp And vgQuebras(vgQQb) <> "*" Then
                        For j = 1 To vgQtQuebras
                           PoeCp = InStr(UCase(vgQuebras(j)), "|" + UCase(CpCol) + "|") = 0
                           If Not PoeCp Then Exit For
                        Next
                     End If
                  End If
                  If PoeCp Then
                     If vgTp <> TP_BINARIO And vgFrmOrigem.grdBrowse.ColumnWidth(CpCol) > 0 Then
                        If vgExporta <> G_EXPORTA_TXT Or (vgExporta = G_EXPORTA_TXT And vgFormatoTXT = 0) Then
                           If PvMemo = 0 Then
                              vgQtCps = vgQtCps + 1
                           End If
                           
                           'arruma atributos
                           z$ = "L=" + CStr(vgLargCps(i))
                           vgValImp = vgTabReferencia.Fields(CpCol).Value
                           If vgTp = TP_NUMERICO Then
                              z$ = z$ + "|JD"
                              j = InStr(vgLstTotCps$, "|" + CStr(i) + "-")
                              If j > 0 Then
                                 j = Val(Mid(vgLstTotCps$, j + Len("|" + CStr(i) + "-")))
                                 vgTotCps(j) = vgTotCps(j) + vgValImp
                              End If
                              j = InStr(vgLstTotQuebras, "|" + CStr(i) + "-")
                              If j > 0 Then
                                 j = Val(Mid(vgLstTotQuebras, j + Len("|" + CStr(i) + "-")))
                                 vgTotCpsQb(j) = vgTotCpsQb(j) + vgValImp
                              End If
                           ElseIf vgTp = TP_MEMO Then
                              If PvMemo = 0 Then
                                 vgIndMemo = i
                                 PvMemo = 1
                                 vgCl = 0
                                 vgFP.txtFixa(0).Text = vgValImp
                                 vgFP.txtFixa(0).Width = vgFrmOrigem.grdBrowse.ColumnWidth(vgIndMemo)
                                 vgQdeLMemo = vgFP.ContaLinhasMemo(0)
                                 vgPosIniMemo = vgPosLin
                              End If
                              vgValImp = vgFP.ExtraiLinhaMemo(0, vgCl)
                              vgCl = vgCl + 1          
                           End If
                           If vgPosCps(i) < ii Or PvMemo = 2 Then         
                              vgPosLin = vgPosLin + vgObSaida.TextHeight("X")
                           End If
                           
                           Imprime vgValImp, vgPosCps(i), vgPosLin, z$, vgObSaida, PegaAtributo(vgTabReferencia.Table.Columns(CpCol), 1), vgExporta, , vgFP.vgProcuraPg
                           ii = vgPosCps(i)
                           If vgTp = TP_MEMO And vgCl <= vgQdeLMemo Then
                              PvMemo = 2
                              Exit For
                           Else
                              If PvMemo <> 0 Then
                                 vgPosFimMemo = vgPosLin
                                 If vgPosIniMemo > 0 Then
                                    vgPosLin = vgPosIniMemo
                                 End If
                              End If
                              PvMemo = 0
                              vgIndMemo = 0
                           End If
                        Else
                           x$ = (vgTabReferencia.Fields(CpCol).Value & "")
                           If vgFormatoTXT = 1 Then                    'SDF
                              If vgTp = TP_NUMERICO Then
                                 vgFormatarTexto.DataType = TipoDeCampo.Numeric
                                 vgFormatarTexto.Mask = vgTabReferencia.Table.Columns(CpCol).Mask
                                 x$ = vgFormatarTexto.FormatText(vgTabReferencia.Fields(CpCol).Value)
                                 x$ = LPad(Trim(CStr(x$)), j, Chr(32))
                                 j = InStr(vgLstTotCps$, "|" + CStr(i) + "-")
                                 If j > 0 Then
                                    j = Val(Mid(vgLstTotCps$, j + 1))
                                    vgTotCps(j) = vgTotCps(j) + vgTabReferencia.Fields(CpCol).Value
                                    vgTotCpsQb(j) = vgTotCpsQb(j) + vgTabReferencia.Fields(CpCol).Value
                                 End If
                              ElseIf vgTp = TP_LOGICO Then
                                 x$ = CStr(Abs(Val(vgTabReferencia.Fields(CpCol).Value)))
                              ElseIf vgTp = TP_DATA_HORA Then
                                 x$ = Format(x$, TrataMaskData(vgTabReferencia.Table.Columns(CpCol).Mask))
                              Else
                                 x$ = RPad(x$, vgTabReferencia.Table.Columns(CpCol).Size, Chr(32))
                              End If
                              z$ = z$ + x$
                           Else                                        'Delimitado
                              If Len(z$) > 0 Then
                                 z$ = z$ + vgSeparador
                              End If
                              If InStr(x$, vgSeparador$) > 0 Or Left(x$, 1) = Chr(32) Or Right(x$, 1) = Chr(32) Then
                                 x$ = vgDelimitador$ + x$ + vgDelimitador$
                              End If
                              z$ = z$ + x$
                           End If
                        End If
                     End If
                  End If
               Next
            End If
            If vgExporta = G_EXPORTA_TXT And vgFormatoTXT > 0 Then
               Print #vgArqExp, z$
            End If
            If PvMemo = 0 Then
               If vgPosFimMemo > 0 Then
                  vgPosLin = vgPosFimMemo
                  vgPosFimMemo = 0
                  vgPosIniMemo = 0
               End If
               If Not EstaQuebrando And Not VerificaQb Then
                  VerificaQb = True
                  vgPosLin = vgPosLin + vgObSaida.TextHeight("X")
                  vgTabReferencia.MoveNext
                  If vgTabReferencia.EOF Then
                     vgFimTab = True
                     GoSub ImprimeCabRel
                  Else
                     vgQQb = 99                                        'só precisa da primeira passagem pela quebra, esse registro acabou de ser impresso e não é preciso verificar mais quebra para ele
                  End If
                  If ((vgEmPapel And vgNumPg = 0) Or vgExporta <> G_NAO_EXPORTA) Then
                     vgQReg = vgQReg + 1
                     If vgExporta = G_EXPORTA_WORD Or vgExporta = G_EXPORTA_GIF Then
                        vgFG.pgb1.Tag = CStr(vgQReg) + "|" + CStr(vgTabReferencia.RecordCount)
                     Else
                        vgFG.pgb1.Value = vgQReg * 100 / vgTabReferencia.RecordCount
                     End If
                     If vgFG.vgQuerCancelar Then Exit Do
                  End If
               ElseIf vgQuebras(vgQQb) <> "*" And vgQQb = vgQtQuebras Then 'se tem quebra e já conferiu a última...
                  If EstaQuebrando And VerificaQb Then
                     EstaQuebrando = False
                     vgPosLin = vgPosLin + 5
                     GoSub ImprimeCabRel
                  Else
                     EstaQuebrando = False
                  End If
                  VerificaQb = False
               ElseIf vgQQb = vgQtQuebras Then
                  vgPosLin = vgPosLin + vgObSaida.TextHeight("X")
                  vgTabReferencia.MoveNext
               End If
            End If
         Next 
      Loop
   
      'agora vamos colocar os totalizadores...
      vgPosLin = vgPosLin + 2
      Imprime "", 0, vgPosLin, "LIN=B0/0/" + Trim(str$(vgPosLin)) + "/" + Trim(str$(vgLarg)) + "/" + Trim(str$(vgPosLin)), vgObSaida, , vgExporta, , vgFP.vgProcuraPg
      vgPosLin = vgPosLin + 1
      ii = 0
      For j = 1 To vgQtTotCps
         i = InStr(vgLstTotCps$, "-" + CStr(j) + "|")
         k = Rat(Left(vgLstTotCps$, i - 1), "|")
         k = Val(Mid(vgLstTotCps$, k + 1, i - k - 1))
         z$ = "L=" + CStr(vgLargCps(k)) + "|JD"
         If vgPosCps(k) < ii Then
            vgPosLin = vgPosLin + vgObSaida.TextHeight("X")
         End If
         Imprime vgTotCps(j), vgPosCps(k), vgPosLin, z$, vgObSaida, vgFrmOrigem.grdBrowse.ColumnOrdered(k + 1).Mask, vgExporta, , vgFP.vgProcuraPg
         ii = vgPosCps(k)
      Next

      If vgFP.vgProcuraPg Then                                             'ops... estava buscando por uma página, e ela não existe (chegou no final do arquivo)!
         If vgNumPg = G_IMP_ULT_PG Then
            vgPrimeiroCab = True
            vgFP.vgProcuraPg = True
            vgNumPg = UBound(vgBookPg())
            GoTo OutraCopia
         Else
            vgPrimeiroCab = True
            vgFP.vgProcuraPg = False
            If vgFP.vgNovaPag > vgFP.vgContaPg Then
               GoSub RestauraPag
               GoTo NaoAchouPg
            End If
         End If
      End If
   End If

CancelouRel:
   If vgEmPapel Or vgExporta <> G_NAO_EXPORTA Then
      If vgEmPapel = True And vgNumPg > 0 And Not vgPrimeiroCab Then
         If vgEmPapel Then
            Set vgFG = Nothing
            vgObSaida.EndDoc
         Else
            GoSub GravaPagina
         End If
      Else
         If vgFG.vgQuerCancelar Then
            vgCancelou = True
            vgObSaida.KillDoc
         ElseIf vgExporta = G_NAO_EXPORTA Then
            vgObSaida.EndDoc
         ElseIf vgExporta <> G_EXPORTA_TXT Or (vgExporta = G_EXPORTA_TXT And vgFormatoTXT = 0) Then
            GoSub GravaPagina
         End If
         If vgNumPg = 0 And vgPagOrig > 0 Then                             'solicitou impressão de todo relatório pelo preview
            vgFP.vgPagRef = vgPagOrig
            vgFP.vgContaPg = vgPagOrig                                     'e arruma o número da página
         End If
         If ((vgEmPapel And vgNumPg = 0) Or vgExporta <> G_NAO_EXPORTA) Then
            UnLoad vgFG
            Set vgFG = Nothing
            Err.Clear
         End If
      End If
      If vgExporta <> G_EXPORTA_TXT Or (vgExporta = G_EXPORTA_TXT And vgFormatoTXT = 0) Then
         With Printer
            .ScaleMode = vgPsm
            .Orientation = vgPor
            .PaperSize = vgPsz
            .FontName = vgPfn
         End With
      End If
      Err.Clear
   Else
      GoSub SalvaPagina
   End If
   GoTo SaiDaSub

OutraFolha:
   If vgEmPapel = False Then
      GoSub SalvaInicioPg
      If vgFP.vgProcuraPg And vgNumPg = G_IMP_ULT_PG Then
         vgFP.txtPag.Text = Trim$(str$(vgFP.vgContaPg + 1))
         vgFP.txtPag.Refresh
      End If
   Else
      If Not vgPrimeiroCab And Not vgFP.vgProcuraPg Then vgObSaida.NewPage
   End If
   vgFP.vgContaPg = vgFP.vgContaPg + 1
   If vgFP.vgProcuraPg = False Then
      vgFP.vgNovaPag = vgFP.vgContaPg
   ElseIf vgFP.vgNovaPag = vgFP.vgContaPg Then                             'se a página atual é a página procurada
      vgFP.vgProcuraPg = False                                             'vamos cancelar a procura!
   End If
   vgNumPag = vgFP.vgContaPg - 1 + 1                                       'vamos utilizar a página atual
   vgFP.vgPagRef = vgNumPag                                                'com o mesmo número para página de referência
   If vgExporta <> G_EXPORTA_TXT Or (vgExporta = G_EXPORTA_TXT And vgFormatoTXT = 0) Then
      If Not vgEmPapel And vgNumPag > 1 And vgPV = True Then
         If Not vgFP.vgProcuraPg Then
            GoSub GravaPagina
         End If
         If vgExporta = G_EXPORTA_BMP Or vgExporta = G_EXPORTA_JPG Or vgExporta = G_EXPORTA_GIF Then
            vgFP.picAux.Cls
            vgFP.picAux.Picture = LoadPicture("")
         End If
      End If
      Imprime "", 0, 0, "EXPORTA=PAGINA/NRPG=" + CStr(vgFP.vgPagRef) + "/NRMOSTRAR=" + CStr(vgNumPag), vgObSaida, , vgExporta, , vgFP.vgProcuraPg
      If vgFrmOrigem.Tipo = TP_TABELA Then
         Imprime Trim(vgFrmOrigem.Caption), 3, 6, "S=15|B=True", vgObSaida, , vgExporta, , vgFP.vgProcuraPg
      Else
         Imprime Trim(Mid(vgFrmOrigem.grdBrowse.Caption, InStr(vgFrmOrigem.grdBrowse.Caption, "-") + 1)), 3, 6, "S=15|B=True", vgObSaida, , vgExporta, , vgFP.vgProcuraPg
      End If
      vgPosX = vgLarg - vgObSaida.TextWidth(LoadGasString(5331)) - 14
      vgPosY = 4
      Imprime LoadGasString(5331), vgPosX, vgPosY, , vgObSaida, , vgExporta, , vgFP.vgProcuraPg
      Imprime vgFP.vgContaPg, vgPosX + vgObSaida.TextWidth(LoadGasString(5331)) + 2, vgPosY, , vgObSaida, "9999", vgExporta, , vgFP.vgProcuraPg
      vgPosY = vgPosY + vgObSaida.TextHeight(LoadGasString(5331)) + 1
      Imprime LoadGasString(5332), vgPosX, vgPosY, , vgObSaida, , vgExporta, , vgFP.vgProcuraPg
      Imprime CDate(vgDataInicial), vgPosX + vgObSaida.TextWidth(LoadGasString(5332)) + 2, vgPosY, , vgObSaida, "99/99/9999", vgExporta, , vgFP.vgProcuraPg
      vgPosY = vgPosY + vgObSaida.TextHeight(LoadGasString(5332)) + 1
      Imprime LoadGasString(5333), vgPosX, vgPosY, , vgObSaida, , vgExporta, , vgFP.vgProcuraPg
      Imprime CDate(vgDataInicial), vgPosX + vgObSaida.TextWidth(LoadGasString(5333)) + 2, vgPosY, , vgObSaida, "99:99", vgExporta, , vgFP.vgProcuraPg
   End If
   vgPosLin = 28
   vgPrimeiroCab = False
   
   If Not EstaQuebrando Then
      GoSub ImprimeCabRel
   End If
   Return

ImprimeCabRel:
   If vgQuebras(vgQQb) <> "*" And Not EstaQuebrando And Not vgFimTab Then
      vgPosX = 10 * vgQQb
   Else
      If vgFimTab And vgQuebras(vgQQb) <> "*" Then vgPosLin = vgPosLin + 5  
      vgPosX = 2 + (vgQQb - 1) * 10
      If UBound(vgTotCpsQb) > 0 Then
            For ii = 1 To UBound(vgTotCpsQb)
               j = InStr(vgLstTotQuebras, "-" + CStr(ii) + "|")
               k = Rat(Left(vgLstTotQuebras, j - 1), "|")
               k = Val(Mid(vgLstTotQuebras, k + 1, j - k - 1))
               z$ = "L=" + CStr(vgLargCps(k)) + "|JD"
               x$ = vgFrmOrigem.grdBrowse.ColumnOrdered(k + 1).Mask
               
         
               If vgPosCps(k) > 0 Then
                  Imprime "", vgPosCps(k) - vgLargCps(k) + 4, vgPosLin - 5, "LIN=B0/" + Trim(str(vgPosCps(k) - vgLargCps(k) + 4)) + "/" + Trim(str$(vgPosLin - 5)) + "/" + Trim(str$(vgPosCps(k))) + "/" + Trim(str$(vgPosLin - 5)), vgObSaida, , vgExporta, , vgFP.vgProcuraPg
                  Imprime vgTotCpsQb(ii), vgPosCps(k), vgPosLin - 4, z$, vgObSaida, x, vgExporta, , vgFP.vgProcuraPg
                  vgTotCpsQb(ii) = 0
               End If
            Next
      End If
   End If
   If vgFimTab Then
      vgFimTab = Not vgFimTab
      Return
   End If
   vgPosY = vgPosLin
   
   'prepara o cabeçalho (títulos dos campos)
   If vgExporta <> G_EXPORTA_TXT Or (vgExporta = G_EXPORTA_TXT And vgFormatoTXT = 0) Then
      x$ = ""
      vgQtCps = 0
      vgQtCpsLinha = 0
      vgNumLinCab = 1                             'número de linhas com título para campos
      ReDim vgIndCps(0) As Integer
      For i = 0 To vgFrmOrigem.grdBrowse.ColumnCount - 1
         CpCol = vgFrmOrigem.grdBrowse.ColumnOrdered(i + 1).Name
         vgTp = vgTabReferencia.Table.Columns(CpCol).ColumnType
         If EstaQuebrando Then
            PoeCp = InStr(UCase(vgQuebras(vgQQb)), "|" + UCase(CpCol) + "|") > 0
         Else
            PoeCp = (vgTp <> TP_BINARIO And vgFrmOrigem.grdBrowse.ColumnWidth(CpCol))
            If PoeCp And vgQuebras(vgQQb) <> "*" Then
               For j = 1 To vgQtQuebras
                  PoeCp = InStr(UCase(vgQuebras(j)), "|" + UCase(CpCol) + "|") = 0
                  If Not PoeCp Then Exit For
               Next
            End If
         End If
         If PoeCp Then
            If vgTp <> TP_BINARIO And vgFrmOrigem.grdBrowse.ColumnWidth(CpCol) > 0 Then
               vgQtCps = vgQtCps + 1
               vgQtCpsLinha = vgQtCpsLinha + 1
               ReDim Preserve vgIndCps(vgQtCps) As Integer
               x$ = vgTabReferencia.Table.Columns(CpCol).Name
               vgLargCps(i) = vgFrmOrigem.ScaleX(vgFrmOrigem.grdBrowse.ColumnWidth(CpCol), vbTwips, vbMillimeters) + 2 'aumenta um pouco a largura, só para ficar uma "sobra"
            
            'arruma atributos
               z$ = "L=" + CStr(vgLargCps(i))
               k = 0
               If vgTp = TP_NUMERICO Then
                  z$ = z$ + "|JD"
                  k = 1
               End If
            
ImprimeAgora:
               
               If vgQtCpsLinha > 1 And k < 2 Then   'se tem outros campos nessa mesma linha e está na primeira passagem
                  vgPosX = vgPosX + 2               'coloca separação entre os campos
               End If
               If k > 0 Then                        'se tem impressão para se fazer agora
                  vgPosCps(i) = vgPosX              'grava posição para imprimir o campo

                  If k > 1 Then
                     Imprime x$, vgPosX, vgPosY, z$, vgObSaida, , vgExporta, , vgFP.vgProcuraPg 'imprime informação (cabeçalho)
                  End If
                  
               End If
               If k < 3 Then                      'se não acabou a impressão dessa informação
                  If k < 2 And vgPosX + vgLargCps(i) > vgLarg And vgQtCpsLinha > 1 Then 've se vai caber..... caso não caiba...
                     vgNumLinCab = vgNumLinCab + 1                                      'incrementa o número de linhas do cabeçalho
                     vgQtCpsLinha = 1             'número de campos nessa linha de cabeçalho
                     If Not (vgNumLinCab And 1) Then 'se for par...
                        vgPosX = 10                  'vamos iniciar em uma posição um pouco deslocada
                     Else                            'ímpar...
                        vgPosX = 2                   'posiciona no início
                     End If
                     vgPosY = vgPosY + vgObSaida.TextHeight("X") + 2 'desloca verticalmente a posição para a próxima linha
                     If k = 1 Then                                   'se tem alinhamento para direita
                        GoTo ImprimeAgora                            'vamos voltar para controlar impressão (posicionamento)
                     End If
                     k = 1                                           'passou o primeiro passo...
                  ElseIf k > 0 Then                                  'se não é o primeiro passo ou tem impressão alinhada direita
                     vgPosX = vgPosX + vgLargCps(i)                  'incrementa a posição X
                     If k = 2 Then                                   'se já é segundo passo,
                        k = 0                                        'cai fora
                     Else                                            'senão
                        k = 2                                        'seta flag para imprimir na próxima passagem
                     End If
                  Else                                               'ok.. impressão normal, pode imprimir
                     k = 1                                           'flag para imprimir na próxima passagem
                  End If
                  If k > 0 Then                                      'se tem que fazer novamente (para imprimir ou verificar posição)
                     k = k + 1                                       'incrementa o controle de passo
                     GoTo ImprimeAgora                               'invoca impressão/teste
                  End If
               End If
            End If
         End If
      Next
      vgPosY = vgPosY + 6                                            'imprime a linha 0.6 cm após o título
      If Not EstaQuebrando Then
         vgPosX = vgLarg
      End If
      
      Imprime "", 0, vgPosY, "LIN=B0/0/" + Trim(str$(vgPosY)) + "/" + Trim(str$(vgLarg)) + "/" + Trim(str$(vgPosY)), vgObSaida, , vgExporta, , vgFP.vgProcuraPg
      vgPosLin = vgPosY + 2                                          'vamos começar a impressão dos dados 0.2 cm após a linha
   End If
   vgPrimeiroCab = False
   Return

SalvaInicioPg:
   If (vgPV Or vgFP.vgContaPg + 1 > UBound(vgBookPg)) And Not vgTabReferencia.EOF Then 'testa se precisa mais variáveis
      If vgFP.vgContaPg + 1 > UBound(vgBookPg) Then
         ReDim Preserve vgBookPg(vgFP.vgContaPg + 1) As Variant                        'cria variável para salvar bookmark
         ReDim Preserve vgPodeVoltar(vgFP.vgContaPg + 1) As Boolean                    'controle de quebra em filhos
         ReDim Preserve vgPgTotCps(vgQtTotCps, vgFP.vgContaPg + 1) As Double
         ReDim Preserve vgPgTotCpsQb(vgQtTotCpsQb, vgFP.vgContaPg + 1) As Double
         For j = 1 To vgQtTotCps
            vgPgTotCps(j, vgFP.vgContaPg + 1) = vgTotCps(j)
         Next
         For j = 1 To vgQtTotCpsQb
            vgPgTotCpsQb(j, vgFP.vgContaPg + 1) = vgTotCpsQb(j)
         Next
      
      End If
      If Not vgTabReferencia.EOF Then
         vgBookPg(vgFP.vgContaPg + 1) = vgTabReferencia.BookMark                       'salva inicio desta página
      End If
      vgPodeVoltar(vgFP.vgContaPg + 1) = vgPagOk Or vgPrimeiroCab                      'pode voltar preview para esta página?
   End If
   If Not vgPriVez Then
      vgPagOk = False
   End If
   Return

SalvaPagina:
   If Not vgEmPapel Or (vgEmPapel And vgNumPg = 0) Then
      With vgFP
         If .vgFimDoArq = False And vgTabReferencia.EOF Then
            .vgFimDoArq = True
         End If
         Ok = (.vgFimDoArq = False Or .vgContaPg < .vgUltPagVista) And Not .vgProcuraPg
         If Ok <> .botMais.Enabled Then
            .botMais.Enabled = Ok                 'habilita/desabilita botões do preview
         End If
         Ok = .botMais.Enabled And Not .vgProcuraPg
         If Ok <> .botUltimo.Enabled Then
            .botUltimo.Enabled = Ok
         End If
         Ok = (.vgPagRef > 1 And Not .vgProcuraPg)
         If Ok <> .botVolta.Enabled Then
            .botVolta.Enabled = Ok
         End If
         Ok = (.vgPagRef > 1 And Not .vgProcuraPg)
         If Ok <> .botPrimeiro.Enabled Then
            .botPrimeiro.Enabled = Ok
         End If
         GoSub SalvaInicioPg
         If .vgProcuraPg Or (.vgContaPg <> .vgNovaPag And .vgNovaPag <> 0) Then 'procurando pg adiante...
            If .vgProcuraPg And (vgTabReferencia.EOF Or .vgContaPg = .vgNovaPag) Then
               .ShowPreview                       'mostra preview
            Else
               .picAux.Cls                        'limpa a área para a próxima pg
               vgPosLin = vgLimiteInf + 99        'força um cabec na próxima vez
            End If
         Else
            .ShowPreview
         End If
      End With
   End If
   Return

GravaPagina:
   Imprime "", 0, 0, "EXPORTA=GRAVAPAGINA", vgObSaida, , vgExporta
   Return

RestauraPag:
   vgFP.txtPag.Text = CStr(vgPagOrig)
   vgFP.botPara.Enabled = False
   vgFP.vgProcuraPg = False
   If vgPagOrig < vgFP.vgContaPg Then             'se não for a última página, vamos restaurar o bookmark para atualizar os botões do preview
      vgTabReferencia.BookMark = vgBookPg(vgPagOrig)
   End If
   vgFP.vgContaPg = vgPagOrig
   vgFP.vgPagRef = vgPagOrig
   Return

IniciaImpressao:
   If vgExporta <> G_EXPORTA_TXT Or (vgExporta = G_EXPORTA_TXT And vgFormatoTXT = 0) Then
      On Error Resume Next                        'algumas impressoras não tem certas propriedades
      If vgEmPapel Then
         With Printer                             'salva configs da impressora
            vgPsm = .ScaleMode
            vgPor = .Orientation
            vgPsz = .PaperSize
            vgPfn = .FontName
            If Err Then Err.Clear
         End With
      End If
      With vgObSaida.Font
         If vgDestRel <> 2 Or vgFormatoSaida <> G_EXPORTA_TXT Then
         'ajusta para nós...
            .Name = "Arial"
            .Charset = 0
            .Weight = 400
            .Size = 8.25
            .Underline = 0
            .Italic = 0
            .StrikeThrough = 0
            vgObSaida.ForeColor = &H0&
         Else
            'ajusta para nós...
            .Name = "Courier New"
            .Charset = 0
            .Weight = 400
            .Size = 8
            .Underline = 0
            .Italic = 0
            .StrikeThrough = 0
            vgObSaida.ForeColor = &H0&
         End If
         vgObSaida.ScaleMode = vbMillimeters      'vamos trabalhar em mm
      End With
      On Error GoTo DeuErro                       'vamos cercar erros...
      Imprime "", 0, 0, "EXPORTA=INICIOREL/TITULO=" + Me.Caption + "/CABECALHO=0/DESTINO=" + vgArqDestino$ + "/FUNDO=16750950/ALTURA=" + CStr(vgHeightRel) + "/LARGURA=" + CStr(vgWidthRel) + "/PAPEL=" + CStr(vgAlt) + "*" + CStr(vgAlt) + "*" + CStr(vbPRORPortrait) + "/ENVIAEMAIL=" + CStr(Int(vgEnviaEMail)), vgObSaida, , vgExporta
   Else
      vgArqExp = FreeFile
      Open vgArqDestino$ For Output As vgArqExp
   End If
   Return

NaoAchouPg:
   GoSub SalvaPagina
   vgFP.txtPag.Text = CStr(vgPagOrig)
   MsgBox "A página especificada não foi encontrada no relatório!", vbExclamation
   GoTo FimDaSub

DeuErro:                                          'deu um erro
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
   If Err <> 65524 Then                           'se não for um erro de crítica
      CErr.NumErro = Err
      CErr.Show
   End If
   vgPrimeiroCab = 2                              'flag para não dar a msg novamente

SaiDaSub:                                         'saída comum da sub...
   If vgExporta <> G_EXPORTA_TXT Or (vgExporta = G_EXPORTA_TXT And vgFormatoTXT = 0) Then
      Imprime "", 0, 0, "EXPORTA=FIMREL", vgObSaida, , vgExporta
   Else
      Close vgArqExp
   End If
   If Err Then
      ProssegueExecucao = CStr(Err.Number) + " - " + Err.Description
   Else
      ProssegueExecucao = ""
   End If

FimDaSub:
   Close vgArqExp
   Err.Clear
   Screen.MousePointer = vbDefault                'ponteiro do mouse = default

End Function

'executa processos/validacoes nos campos do formuário
Public Function Executar(vgOq As String) As String

   Dim vgMsg As String, vgOk As Integer, vgNVez As Integer, i As Integer
   On Error GoTo DeuErro                               'fica na espera de um erro...
   vgMsg$ = ""                                         'retorna uma msg dizendo o motivo
   vgOk = True                                         'se a validação esta OK
   vgNVez = 0                                          'porque não fez o processo/validacoes
   If vgOq = VALIDACOES Then
      InicializaApelidos
      If vgOk Then
         If vgDestRel >= 2 Then
            vgOk = (Not Vazio(vgArquivo$))    
            vgMsg$ = "Nome do arquivo não pode ser vazio!"
            If Not vgOk Then txtCampo(3).SetFocus
         End If
      End If
      If vgOk Then vgMsg$ = ""
      DoEvents
   ElseIf vgOq = INICIALIZACOES Then
      For i = 0 To vgFrmOrigem.grdBrowse.ColumnCount - 1 'enche a lista com campos númericos...
         If vgFrmOrigem.grdBrowse.ColumnWidth(vgFrmOrigem.grdBrowse.ColumnOrdered(i + 1).Name) > 0 Then 'se a coluna no grid está visivel
            If vgFrmOrigem.grdBrowse.ColumnType(vgFrmOrigem.grdBrowse.ColumnOrdered(i + 1).Name) = TP_NUMERICO Then 'se for numérico,
               lstTotal.AddItem vgFrmOrigem.grdBrowse.Columns(vgFrmOrigem.grdBrowse.ColumnOrdered(i + 1).Name).Name 'joga na lista
               lstTotal.itemData(lstTotal.ListCount - 1) = i 
            End If
         End If
      Next
      opcFrame0(0).Value = True
      opcFrame2(0).Value = True
      txtCp(2).Text = ","
      txtCp(3).Text = Chr(34)
   ElseIf vgOq = INI_APELIDOS Then
      InicializaApelidos
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

Public Function EnviaEMailRel() As String
   Dim k As String, vgTempDir As String
   k$ = "\" + vgArquivo$
   k$ = Mid(k$, Rat(k$, "\") + 1)
   vgTempDir$ = String(256, Chr$(0))
   GetTempPath 256, vgTempDir$
   vgTempDir$ = Left$(vgTempDir$, InStr(vgTempDir$, Chr$(0)) - 1)
   If Right(vgTempDir$, 1) <> "\" Then vgTempDir$ = vgTempDir$ + "\"
   EnviaEMailRel = ProssegueExecucao(vgFP.picAux, 0, vgFormatoSaida, vgTempDir$ + k$, True)
End Function
