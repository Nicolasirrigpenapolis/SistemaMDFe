Version 5.00
Begin VB.Form frmIcms
   ForeColor                =   &H80000008
   BorderStyle              =   2
   Height                   =   3210
   Left                     =   1605
   LinkTopic                =   "Icms"
   LockControls             =   -1
   KeyPreview               =   -1
   MDIChild                 =   -1
   ScaleHeight              =   2790
   ScaleWidth               =   7425
   Top                      =   1570
   Width                    =   7515
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
      Height                   =   2610
      Left                     =   15
      Width                    =   7245
      Top                      =   15
      TabStop                  =  0
      _extentx                 =   12772
      _extenty                 =   4601
      Index                    =   0 
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   -1
         Height                   =   375
         Left                     =   1800
         Width                    =   780
         Top                      =   420
         Alignment                =   0
         BeginProperty Font
            Name                     =   "Microsoft Sans Serif"
            CharSet                  =   0
            Weight                   =   400
            Size                     =   15.75
            Underline                =   0
            Italic                   =   0
            StrikeThrough            =   0
         EndProperty
         ForeColor                =   &H0
         Caption                  =   "ICMS"
         Index                    =   0 
      End
      Begin NFE.GCpMM mmCampo
         Appearance               =   0
         BackColor                =   &H8000000F
         BorderStyle              =   0
         Stretch                  =   0
         Height                   =   1320
         Left                     =   90
         Width                    =   1530
         Top                      =   0
         Index                    =   0 
         TabStop                  =   0
         ScrollBars               =   0
         Locked                   =   -1
      End
      Begin VB.Line Linha
         BorderColor              =   -2147483640
         BorderStyle              =   1
         BorderWidth              =   1
         X1                       =   1800
         Y1                       =   810
         X2                       =   2580
         Y2                       =   810
         Index                    =   0 
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   0
         Height                   =   240
         Left                     =   240
         Width                    =   1260
         Top                      =   1440
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
         ForeColor                =   &H0
         Caption                  =   "Sequencia:"
         Index                    =   1 
      End
      Begin VB.TextBox txtCp
         Appearance               =   1
         BackColor                =   &HE0E0E0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851}
            Name                     =   "Microsoft Sans Serif"
            CharSet                  =   0
            Weight                   =   400
            Size                     =   9.75
            Underline                =   0
            Italic                   =   0
            StrikeThrough            =   0
         EndProperty
         ForeColor                =   &H0
         BorderStyle              =   1
         Alignment                =   1
         Locked                   =   -1
         TabIndex                 =   0
         TabStop                  =   0
         Height                   =   300
         Left                     =   1560
         Width                    =   540
         Top                      =   1440
         DataField                =   "Sequencia do icms"
         TabStop                  =  0
         Index                    =   0 
         MultiLine                =   -1
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   0
         Height                   =   240
         Left                     =   2220
         Width                    =   420
         Top                      =   1440
         Alignment                =   0
         BeginProperty Font
            Name                     =   "MS Sans Serif"
            CharSet                  =   0
            Weight                   =   700
            Size                     =   8.25
            Underline                =   0
            Italic                   =   0
            StrikeThrough            =   0
         EndProperty
         ForeColor                =   &H0
         Caption                  =   "*UF:"
         Index                    =   2 
      End
      Begin VB.Label labFdo1
         Appearance               =  1
         BorderStyle              =  1
         BackColor                =  &H80000005
         Left                     =   2700
         Top                      =   1440
         Width                    =   720
         Height                   =   300
      End
      Begin VB.CommandButton bottxtCampo1
         Style                    =   1
         TabStop                  =   0
         Index                    =   2
         Left                     =   3135
         Top                      =   1470
         Width                    =   255
         Height                   =   240
      End
      Begin VB.TextBox txtCp
         Appearance               =   1
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
         ForeColor                =   &H0
         BorderStyle              =   0
         Alignment                =   0
         TabIndex                 =   1
         TabStop                  =   -1
         Height                   =   240
         Left                     =   2730
         Width                    =   390
         Top                      =   1470
         DataField                =   "Uf"
         Index                    =   1 
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   0
         Height                   =   240
         Left                     =   3600
         Width                    =   840
         Top                      =   1440
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
         ForeColor                =   &H0
         Caption                  =   "Região:"
         Index                    =   3 
      End
      Begin VB.TextBox txtCp
         Appearance               =   1
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
         ForeColor                =   &H0
         MaxLength                =   20
         BorderStyle              =   1
         Alignment                =   0
         TabIndex                 =   2
         TabStop                  =   -1
         Height                   =   300
         Left                     =   4590
         Width                    =   2490
         Top                      =   1440
         DataField                =   "Região"
         Index                    =   2 
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   0
         Height                   =   240
         Left                     =   180
         Width                    =   1320
         Top                      =   2040
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
         ForeColor                =   &H0
         Caption                  =   "*Aliquota....:"
         Index                    =   4 
      End
      Begin VB.TextBox txtCp
         Appearance               =   1
         BackColor                =   &HE0E0E0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851}
            Name                     =   "Microsoft Sans Serif"
            CharSet                  =   0
            Weight                   =   400
            Size                     =   9.75
            Underline                =   0
            Italic                   =   0
            StrikeThrough            =   0
         EndProperty
         ForeColor                =   &H0
         BorderStyle              =   1
         Alignment                =   1
         TabIndex                 =   3
         TabStop                  =   -1
         Height                   =   300
         Left                     =   1560
         Width                    =   540
         Top                      =   2040
         DataField                =   "Aliquota do icms"
         Index                    =   3 
         MultiLine                =   -1
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   0
         Height                   =   240
         Left                     =   2280
         Width                    =   2040
         Top                      =   2040
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
         ForeColor                =   &H0
         Caption                  =   "*Aliquota Interna...:"
         Index                    =   5 
      End
      Begin VB.TextBox txtCp
         Appearance               =   1
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
         ForeColor                =   &H0
         BorderStyle              =   1
         Alignment                =   1
         TabIndex                 =   4
         TabStop                  =   -1
         Height                   =   300
         Left                     =   4380
         Width                    =   720
         Top                      =   2040
         DataField                =   "Aliquota interna"
         Index                    =   4 
         MultiLine                =   -1
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   0
         Height                   =   240
         Left                     =   5280
         Width                    =   1320
         Top                      =   2040
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
         ForeColor                =   &H0
         Caption                  =   "*Cod da UF:"
         Index                    =   6 
      End
      Begin VB.TextBox txtCp
         Appearance               =   1
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
         ForeColor                =   &H0
         BorderStyle              =   1
         Alignment                =   1
         TabIndex                 =   5
         TabStop                  =   -1
         Height                   =   300
         Left                     =   6690
         Width                    =   390
         Top                      =   2040
         DataField                =   "Codigo da uf"
         Index                    =   5 
         MultiLine                =   -1
      End
      Begin VB.CheckBox ChkCp
         Appearance               =   1
         BackColor                =   &H8000000F
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851}
            Name                     =   "Microsoft Sans Serif"
            CharSet                  =   0
            Weight                   =   700
            Size                     =   9.75
            Underline                =   0
            Italic                   =   0
            StrikeThrough            =   0
         EndProperty
         ForeColor                =   &H0
         Alignment                =   0
         TabIndex                 =   6
         TabStop                  =   0
         Height                   =   255
         Left                     =   6060
         Width                    =   1080
         Top                      =   300
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851}
            Name                     =   "Microsoft Sans Serif"
            CharSet                  =   0
            Weight                   =   700
            Size                     =   9.75
            Underline                =   0
            Italic                   =   0
            StrikeThrough            =   0
         EndProperty
         ForeColor                =   &H0
         Alignment                =   0
         Caption                  =   "Inativo"
         Index                    =   0 
         DataField                =   "Inativo"
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   -1
         Height                   =   240
         Left                     =   6900
         Width                    =   45
         Top                      =   2700
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
         Caption                  =   "."
         Index                    =   7 
      End
   End
         Begin NFE.GListV grdBrowse 
                  Height          =   795
                  Left            =   60
                  TabIndex        =   0
                  Top             =   330
                  Width           =   1575
                  _ExtentX        =   2778
                  _ExtentY        =   1402
                  FullRowSelect   =   0           'False
                  RowHeight       =   225
                  AllowEdit       =   -1          'True
                  AllowInsert     =   -1          'True
                  AllowDelete     =   -1          'True
                  ManualUpdate    =   -1          'True
                  ManualDelete    =   -1          'True
                  NavigationAddMode=   1
                  ShowGridCaption =   0           'False
                  ShowFilterBar   =   -1          'True
                  Caption         =   ""
                  CacheSize       =   100
                  BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                           Name            =   "MS Sans Serif"
                           Size            =   8.25
                           Charset         =   0
                           Weight          =   400
                           Underline       =   0  'False
                           Italic          =   0  'False
                           StrikeThrough   =   0  'False
                  EndProperty
         End
End
Attribute VB_name = "frmIcms"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
'* Sistema...: Emissor de Nota Fiscal Eletronica
'* Empresa...: Ygor Eduardo Dellalio
'* Módulo....: Icms
'* Função....: Icms
'* CopyRight.: (C)2016 Ygor Eduardo Dellalio
'* Criação...: GAS-2007 - Gerador Automático de Sistemas
'* Data......: 13/07/2016 13:38:05
'* * * * * * *

Option Explicit
DefInt A-Z

Public vgSituacao As Integer                      'situação de edição que do módulo
Public vgCaracteristica As Integer                'caracteristica do módulo
Public vgTipo As Integer                          'tipo do módulo
Public vgFiltroInicial As String                  'filtro inicial do módulo   
Public vgOrdemInicial As String                   'ordem inicial do módulo
Public vgUltimaOrdem As String                    'última ordenação feita no módulo    
Public vgUltimoFiltro As String                   'último filtro definido no módulo   
Public vgUltimoFiltroComTit As String             'titulo do último filtro definido no módulo
Public vgUltimaOrdemComTit As String              'titulo da última ordenação feita no módulo 
Public vgUltimoTabIndex As Integer                'último campo com foco do módulo
Public vgPriVez As Integer                        'flag de carregamento do módulo  
Public WithEvents vgTb As GRecordSet              'tabela de dados do módulo
Public vgSQL As String                            'expressão SQL que define o módulo
Public vgTemInclusao As Integer                   'flag se tem ou não inclusão no módulo 
Public vgTemExclusao As Integer                   'flag se tem ou não exclusão no módulo 
Public vgTemProcura As Integer                    'flag se tem ou não procura no módulo 
Public vgTemFiltro As Integer                     'flag se tem ou não filtro no módulo
Public vgTemAlteracao As Integer                  'flag se tem ou não alteração no módulo 
Public vgTemAlteracaoGrids As Integer              'flag se tem ou não alteração nos grids
Public vgTemBrowse As Integer                     'flag se tem ou não janela em grade no módulo
Public vgSemVincDados As Integer                  'Flag para definir formulários sem vinculo com dados
Public vgTemCondicoesEsp As Integer               'flag se tem expresão de validação para inclusão/alteração ou exclusão
Public vgEmBrowse As Integer                      'flag se o módulo esta em grade 
Public vgFiltroEmUso As Integer                   'Indice do Filtro atual em uso 
Public vgIndDefault As String                     'indice default do módulo 
Public vgFormID As Long                           'identificador único para o módulo 
Public vgIdentTab As String                       'nome da tabela principal do módulo 
Public vgFrmImpCons As New frmImpCons             'impressao de consutlas
Public vgTooltips As New cTooltips                'classe de ajuda para os controes do módulo
Public vgFiltroOriginal As String
Dim txtCampo(5) As New FormataCampos              'classe dos campos tipo texto do módulo  
Dim chkCampo(0) As New FormataCampos              'classe dos campos tipo lógico do módulo
Dim Sequencia_do_icms As Integer, Uf As String, Regiao As String
Dim Aliquota_do_icms As Single, Aliquota_interna As Single, Codigo_da_uf As Integer
Dim Inativo As Boolean, Ajuste As String
Public lblAjuste As Object

Private Function PegaSequencial() As Long
 Dim Tb As New GRecordSet
 
 If VgSituacao = ACAO_INCLUINDO Then
  Set Tb = VgDb.OpenRecordSet("SELECT MAX([Sequencia do icms]) Seq From Icms")
  PegaSequencial = Tb!Seq + 1
 End If
    
End Function

Public Property Get txtCampoTab(Index As Integer) As FormataCampos   
   Set txtCampoTab = txtCampo(Index)
End Sub

'inicializa variaveis (apelidos) coms os campos correspondentes
Private Sub InicializaApelidos(vgComOQue As Integer)
   On Error Resume Next                           'prepara para possíveis erros
   If (vgTb.RecordCount > 0 And vgTb.Eof = False And vgTb.Bof = False) Or vgComOQue = COM_TEXTBOX Then
      If vgComOQue = COM_TEXTBOX Then
         Sequencia_do_icms = txtCampo(0).Value
         Uf = txtCampo(1).Value
         Regiao = txtCampo(2).Value
         Aliquota_do_icms = txtCampo(3).Value
         Aliquota_interna = txtCampo(4).Value
         Codigo_da_uf = txtCampo(5).Value
         Inativo = chkCampo(0).Value
      Else
         Sequencia_do_icms = IIf(IsNull(vgTb![Sequencia do icms]), 0, vgTb![Sequencia do icms])
         Uf = IIf(IsNull(vgTb!Uf), "", vgTb!Uf)
         Regiao = IIf(IsNull(vgTb!Região), "", vgTb!Região)
         Aliquota_do_icms = IIf(IsNull(vgTb![Aliquota do icms]), 0, vgTb![Aliquota do icms])
         Aliquota_interna = IIf(IsNull(vgTb![Aliquota interna]), 0, vgTb![Aliquota interna])
         Codigo_da_uf = IIf(IsNull(vgTb![Codigo da uf]), 0, vgTb![Codigo da uf])
         Inativo = IIf(IsNull(vgTb!Inativo), 0, vgTb!Inativo)
      End If
   End If
   If Err Then Err.Clear                          'se deu algum erro, vamos resetá-lo
End Sub

'verifica permissões para as condições especiais
'e muda situação de alguns botões
Private Sub AnalisaCondicoes()
   Dim i As Integer
   On Error Resume Next
   If Not mdiNFE.ActiveForm Is Nothing Then
      If mdiNFE.ActiveForm.Name <> Me.Name And Me.Visible Then Exit Sub
   End If
   With mdiNFE
      i = Permitido(vgIdentTab, ACAO_INCLUINDO)
      If Err Then Err.Clear: i = False
      vgTemInclusao = i
      grdBrowse.AllowInsert = i
      .botInclui.Enabled = i
      .Menu_Inclui.Enabled = i
      i = Permitido(vgIdentTab, ACAO_EXCLUINDO)
      If Err Then Err.Clear: i = False
      vgTemExclusao = i
      grdBrowse.AllowDelete = i
      .botExclui.Enabled = i
      .Menu_Exclui.Enabled = i
      i = Permitido(vgIdentTab, ACAO_EDITANDO)
      If Err Then Err.Clear: i = False
      vgTemAlteracao = i
      grdBrowse.AllowEdit = i
      LigaDesligaControles Me, Not i
   End With
End Sub

'executa processos/validacoes nos campos do arquivo
Public Function Executar(vgOq As String, Optional ByRef vgColumn As Integer) As String
   Dim i As Integer, vgRsError As GRecordSet, vgMsg As String, vgOk As Integer, vgPV As Boolean, vgNVez As Integer
   On Error GoTo DeuErro                          'fica na espera de um erro...
   vgMsg$ = ""                                    'retorna uma msg dizendo o motivo
   vgOk = True                                    'se a validação esta OK
   vgPV = vgPriVez
   vgColumn = -1
   vgNVez = 0                                     'porque não fez o processo/validacoes
   If vgOq = VALIDACOES Then
      InicializaApelidos COM_TEXTBOX
      vgOk = (VUF(Uf))
      vgMsg$ = "Uf inválido!"
      If Not vgOk Then vgColumn = 2
      If vgOk Then
         vgOk = (Aliquota_do_icms > 0)
         vgMsg$ = "Aliquota do icms inválido!"
         If Not vgOk Then vgColumn = 4
      End If
      If vgOk Then
         vgOk = (Aliquota_interna > 0)
         vgMsg$ = "Aliquota interna inválido!"
         If Not vgOk Then vgColumn = 5
      End If
      If vgOk Then
         vgOk = (Codigo_da_uf > 0)
         vgMsg$ = "Codigo da uf inválido!"
         If Not vgOk Then vgColumn = 6
      End If
      If vgOk Then
         vgMsg$ = ""
      ElseIf vgColumn <> -1  And Not vgEmBrowse  Then
         txtCampo(vgColumn - 1).SetFocus
      End If
      DoEvents
   ElseIf vgOq = INICIALIZACOES Then
      If vgPriVez = False Then
         vgPriVez = True
         For i = 0 To UBound(txtCampo)
            If Len(txtCampo(i).DataField) > 0 Then
               txtCampo(i).Text = ""
            End If
         Next
         InicializaApelidos COM_TEXTBOX
         On Error Resume Next
                  txtCampo(0).Value = PegaSequencial()
         chkCampo(0).Value = False
         On Error Goto DeuErro
         InicializaApelidos COM_TEXTBOX
      End If
   ElseIf vgOq = PEGA_DO_ARQUIVO Then
      If vgTb.RecordCount > 0 And vgTb.EOF = False And vgTb.BOF = False Then
         vgPriVez = True
         vgTb.Resync 1             'adAffectCurrent
         InicializaApelidos COM_REGISTRO
         For i = 0 To UBound(txtCampo)
            If Len(txtCampo(i).DataField) > 0 Then
               txtCampo(i).SetOriginalValue = True
               txtCampo(i).Value = vgTb.Fields(txtCampo(i).DataField).Value
            End If
         Next
         chkCampo(0).Value = Inativo
         If vgSituacao = ACAO_NAVEGANDO Then
            If Me.Name = mdiNFE.ActiveForm.Name Then
               If Not ActiveControl Is Nothing Then
                  If TypeOf ActiveControl Is GListV Then
                     If Not ActiveControl.PreEditing Then DoEvents
                  Else
                     DoEvents
                  End If
               End If
            End If
         End If
      Else
         Executar INICIALIZACOES
      End If
      vgPriVez = False
   ElseIf vgOq = TESTA_VAL_RS Then
      vgTb.Resync 1         'adAffectCurrent
      For i = 0 To UBound(txtCampo)
         If Len(txtCampo(i).DataField) > 0 Then
            If vgTb.Fields(txtCampo(i).DataField).Value <> txtCampo(i).OriginalValue Then
               If Len(vgMsg$) = 0 Then
                  vgMsg$ = Caption + "|" + CStr(3600 + Abs(vgEmBrowse)) + "|" + LoadGasString(122)
               End If
               If vgEmBrowse Then
                  Exit For
               Else
                  vgPriVez = True
                  txtCampo(i).SetOriginalValue = True
                  txtCampo(i).Value = vgTb.Fields(txtCampo(i).DataField).Value
                  vgPriVez = False
               End If
            End If
         End If
      Next
   ElseIf vgOq = POE_NO_ARQUIVO Then
      For i = 0 To UBound(txtCampo)
         If Len(txtCampo(i).DataField) > 0 Then
            If Not vgTb.Table.Columns(txtCampo(i).DataField).SeqInterno Then
               If (txtCampo(i).Value & "" <> vgTb.Fields(txtCampo(i).DataField).Value & "") Or _
                        (IsNull(txtCampo(i).Value) Xor IsNull(vgTb.Fields(txtCampo(i).DataField).Value)) Then    'se for diferente do conteúdo atual do RS
                  vgTb.Fields(txtCampo(i).DataField).Value = txtCampo(i).Value
               End If
            End If
         End If
      Next
      InicializaApelidos COM_TEXTBOX
      vgTb!Inativo = Inativo
   ElseIf vgOq = INI_APELIDOS Then
      InicializaApelidos COM_REGISTRO
      ExecutaVisivel
   End If
   Executar = vgMsg$                              'prepara saida da função
   vgPriVez = vgPV
   Exit Function                                  'e cai fora...

DeuErro:
   Select Case Err                                'vamos verificar se deu algum erro

      Case -2147467259
         Resume Next

      Case -2147217885                            'registro foi apagado
         vgPriVez = False
         MoveRegistro Me, REG_FORCAVOLTA          'volta um registro
         PrepBotoes Me, vgSituacao                'acerta icones dos botoes

   End Select
   Executar = Err.Source + "|" + Trim$(str$(Err)) + "|" + Error$ 'não teve jeito o erro não pode ser evitado...
   If Err = 3265 Then Executar = Executar & vbCrLf & vbCrLf & txtCampo(i).DataField
   If Not vgRsError Is Nothing Then
      vgRsError.CancelUpdate
      Set vgRsError = Nothing
   End If
   vgPriVez = vgPV
End Function

Private Sub grdBrowse_DeleteData(ByVal vgItem As Long, vgColumns() As Variant, vgDataDeleted As Boolean, vgErrorMessage As String)
   vgDataDeleted = mdiNFE.ExcluiRegistro()
End Sub
   
Private Sub grdBrowse_InitEdit(CancelEdit As Boolean)
   Reposition
End Sub

Private Sub grdBrowse_ItemSelect(ByVal vgItem As Long, vgColumns() As Variant)
   If vgPriVez Or Not grdBrowse.Visible Then Exit Sub
   AjustaRolagem Me
   If vgSituacao = ACAO_NAVEGANDO Then Executar PEGA_DO_ARQUIVO
End Sub

'evento disparado ao mudar de registro no grid.
Private Sub grdBrowse_SkipRecord(Columns() As Variant, ByVal BookMark As Variant)
   If vgSituacao = ACAO_NAVEGANDO Then Reposition
End Sub

Private Sub grdBrowse_GetColumnFilter(ByVal vgColumn As Integer, vgColumns() As Variant, vgFilter As String)
   If UBound(txtCampo) >= vgColumn - 1 Then
      vgFilter = txtCampo(vgColumn - 1).Filter
   End If
End Sub

   


Private Sub grdBrowse_SaveData(ByVal vgItem As Long, vgColumns() As Variant, vgDataSaved As Boolean, vgColumn As Integer, vgErrorMessage As String)
   mdiNFE.SalvaDados vgColumn
   vgDataSaved = (vgSituacao = ACAO_NAVEGANDO)
End Sub
   
Private Sub grdBrowse_StatusChanged(ByVal vgNewStatus As Integer)
   If (vgNewStatus = ACAO_EXCLUINDO And Val(grdBrowse.Recordset.BookMark) >= 0) Then
      Reposition
   End If
   PrepBotoes Me, vgNewStatus                          'acerta icones dos botoes
   mdiNFE.RemontaForm                                  'remonta dos os form da tela
End Sub

'apresenta popup menu para trabalhar com o grid
Private Sub grdBrowse_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single, ByVal vgCurCol As Integer)
   MostraPopGrid Me, Button
End Sub

'evento - quando qq tecla for digitada no formulário
Private Sub Form_KeyPress(KeyAscii As Integer)
   Dim Ok As Boolean
   If Not Me.ActiveControl Is Nothing Then
      Ok = (Not TypeOf Me.ActiveControl Is GListV)         'se não está em um GRID
   Else
      Ok = True
   End If
   If Not Ok Then
      Ok = (Me.ActiveControl.Status = ACAO_NAVEGANDO And Not Me.ActiveControl.PreEditing) 'e se grid não está em pré-edição, edição nem inclusão
   End If
   If KeyAscii = vbKeyEscape And Ok Then                                                  'se teclou ESC
      Unload Me                                   'tira este form da memória
   End If
End Sub

'evento - quando o formuário for pintado
Private Sub Form_Paint()
   grdBrowse.Visible = vgEmBrowse                 'AH VB!!...
End Sub

'prepara botões e o formulário para o novo registro
Public Sub Reposition(Optional ForceRebind As Boolean, Optional LockGrids As Boolean = True)
   On Error GoTo DeuErro
   If vgPriVez Then Exit Sub
   If vgSituacao <> ACAO_INCLUINDO And vgSituacao <> ACAO_EDITANDO Then Executar PEGA_DO_ARQUIVO
   ExecutaVisivel
   vgTemAlteracaoGrids = Not LockGrids
   If vgEmBrowse And vgSituacao = ACAO_NAVEGANDO And vgFrmImpCons Is Nothing Then grdBrowse.Refresh
DeuErro:
   
End Sub

'coloca os campos visíveis segundo a condição
Private Sub ExecutaVisivel()
   On Error Resume Next                           'prepara para possiveis erros
   Label(7).Visible = (False)
   If Err Then Err.Clear                          'se houve erro, limpa...
End Sub

'evento - quando o conteúdo do campo for alterado
Private Sub txtCp_Change(Index As Integer)
   If vgPriVez Or txtCampo(Index).PriVez Then Exit Sub
   If Len(txtCampo(Index).DataField) > 0 Then LigaFocos Me
   InicializaApelidos COM_TEXTBOX                         'inicializa apelidos com o que esta sendo digitado
   txtCampo(Index).Change
   If Index = 1 Then
      ExecutaVisivel
   End If
End Sub

'evento - quando o campo receber o foco
Private Sub txtCp_GotFocus(Index As Integer)
   txtCampo(Index).GotFocus
End Sub

'evento - quando qq tecla for digitada no campo
Private Sub txtCp_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn And vgSituacao <> ACAO_NAVEGANDO Then  'se tela esta em edição e digitou ENTER
      ExecutaVisivel                                               'torna camos visiveis
   End If
   txtCampo(Index).KeyDown KeyCode, Shift
End Sub

'evento - quando qq tecla for digitada no campo
Private Sub txtCp_KeyPress(Index As Integer, KeyAscii As Integer)
   txtCampo(Index).KeyPress KeyAscii
End Sub

'evento - quando o campo perder o foco
Private Sub txtCp_LostFocus(Index As Integer)
   txtCampo(Index).LostFocus
   If vgSituacao <> ACAO_NAVEGANDO Then           'se tela esta em edição
      InicializaApelidos COM_TEXTBOX              'pega apelidos dos campos
      ExecutaVisivel                              'torna camos visiveis
   End If
End Sub


'evento - quando o check for marcado/desmarcado
Private Sub chkCp_Click(Index As Integer)
   If vgPriVez Then Exit Sub
   If chkCampo(Index).Locked Then
      chkCampo(0).Value = Inativo
   Else
   If Len(chkCampo(Index).DataField) > 0 Then LigaFocos Me
      InicializaApelidos COM_TEXTBOX
      ExecutaVisivel                              'torna camos visiveis
      chkCampo(Index).Change
   End If
End Sub

'evento - quando o check receber o foco
Private Sub chkCp_GotFocus(Index As Integer)
   chkCampo(Index).GotFocus
End Sub

'evento - quando qq tecla for digitada no check
Private Sub chkCp_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
   chkCampo(Index).KeyDown KeyCode, Shift
End Sub

'evento - quando qq tecla for digitada no check
Private Sub chkCp_KeyPress(Index As Integer, KeyAscii As Integer)
   chkCampo(Index).KeyPress KeyAscii
End Sub

'evento - quando o check perder o foco
Private Sub chkCp_LostFocus(Index As Integer)
   chkCampo(Index).LostFocus
End Sub

'evento - quando o formulário receber o foco
Private Sub Form_Activate()
   AtivaForm Me
   
   'se tiver imprimindo registros em grade, fecha form de selecao/preview
   If FormEstaAberto("frmEnviaEmail") Then
      If Not frmEnviaEmail.Visible Then
         UnLoad vgFrmImpCons
         Set vgFrmImpCons = Nothing
         UnLoad frmEnviaEmail
      End If
   End If
End Sub

'evento - inicialização do formulário
Private Sub Form_Load()
   On Error GoTo DeuErro
   Screen.MousePointer = vbHourglass
   Caption = LoadGasString(12740)
   vgFormID = 612
   vgIdentTab = "Icms"
   vgFiltroEmUso = -1
   vgIndDefault = "Sequencia do icms"
   vgPriVez = True
   vgTipo = TP_TABELA
   vgTemInclusao = True
   vgTemExclusao = True
   vgTemAlteracao = True
   vgTemProcura = True
   vgTemFiltro = True
   vgTemBrowse = True
   grdBrowse.Tag = 1
   vgTemCondicoesEsp = False
   vgCaracteristica = F_DADOS
   vgUltimoTabIndex = 5
   vgSituacao = ACAO_NAVEGANDO
   Set mmCampo(0).Picture = LoadPicture(LoadGasPicture(4245))
   Set lblAjuste = Label(7)
   Set vgTb = New GRecordSet
   If Len(vgFiltroInicial$) > 0 Then
      vgFiltroInicial$ = vgFiltroInicial$ + " And "
   End If
   vgFiltroInicial$ = vgFiltroInicial$ + "[Sequencia do icms] > " & 0
   vgFiltroOriginal$ = vgFiltroInicial$
   DefineControles
   vgTooltips.Create
   Label(0).Caption = LoadGasString(12745)
   Label(1).Caption = LoadGasString(12746)
   vgTooltips.AddTool txtCampo(0).CtPri, 0, LoadGasString(12747)
   Label(2).Caption = LoadGasString(12748)
   vgTooltips.AddTool txtCampo(1).CtPri, 0, LoadGasString(12749)
   Label(3).Caption = LoadGasString(12750)
   vgTooltips.AddTool txtCampo(2).CtPri, 0, LoadGasString(12751)
   Label(4).Caption = LoadGasString(12752)
   vgTooltips.AddTool txtCampo(3).CtPri, 0, LoadGasString(12753)
   Label(5).Caption = LoadGasString(12754)
   vgTooltips.AddTool txtCampo(4).CtPri, 0, LoadGasString(12755)
   Label(6).Caption = LoadGasString(12756)
   vgTooltips.AddTool txtCampo(5).CtPri, 0, LoadGasString(12757)
   vgTooltips.AddTool chkCampo(0).CtPri, 0, LoadGasString(12758)
   chkCampo(0).Caption = LoadGasString(12759)
   Label(7).Caption = LoadGasString(12760)
   AjustaTamanho Me
   IniciaFormDados Me
   If vgTb.RecordCount > 0 Then vgTb.MoveLast
   vgPriVez = False
   Reposition
   Screen.MousePointer = vbDefault
   Exit Sub

DeuErro:
   CErr.NumErro = Err
   CErr.FunctionName = "IniciaForm"
   CErr.Origem = CStr(vgFormID) + " - " + Me.Caption
   CErr.Show
End Sub

Public Sub DefineControles()
 On Error GoTo DeuErro
 grdBrowse.AddControlIgnoreFocus mdiNFE.botCancela.hwnd           'não deixa o grid tentar gravar automaticamente
 grdBrowse.AddControlIgnoreFocus mdiNFE.botSalva.hwnd             'se estiver perdendo o foco para esses botões
   grdBrowse.AllowDelete = True
   grdBrowse.AllowEdit = True
   grdBrowse.SpecialPopupDisabled POP_GRID_BARS Or POP_GRID_STRIPES

   Set txtCampo(0).CtPri = txtCp(0)
   txtCampo(0).DataType = 1
   txtCampo(0).Mask = "9999"
   txtCampo(0).Editable = False
   txtCampo(0).BoundColumn = ""
   txtCampo(0).ListFields = ""
   txtCampo(0).OrderFields = ""
   txtCampo(0).Relation = ""
   txtCampo(0).Source = ""
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(0).DataField), txtCampo(0)

   Set txtCampo(1).CtPri = txtCp(1)
   Set txtCampo(1).CtFdo = labFdo1
   Set txtCampo(1).CtBot(BOT_COMBO) = bottxtCampo1(BOT_COMBO)
   Set bottxtCampo1(BOT_COMBO).Picture = LoadPicture(LoadGasPicture(3))
   txtCampo(1).DataType = 0
   txtCampo(1).ListFields = "AC|AL|AP|AM|BA|CE|DF|ES|TO|GO|MA|MT|MS|MG|PA|PB|PR|PE|PI|RN|RS|RJ|RO|RR|SC|SP|SE"
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(1).DataField), txtCampo(1)

   Set txtCampo(2).CtPri = txtCp(2)
   txtCampo(2).DataType = 0
   txtCampo(2).Mask = "@x"
   txtCampo(2).BoundColumn = ""
   txtCampo(2).ListFields = ""
   txtCampo(2).OrderFields = ""
   txtCampo(2).Relation = ""
   txtCampo(2).Source = ""
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(2).DataField), txtCampo(2)

   Set txtCampo(3).CtPri = txtCp(3)
   txtCampo(3).DataType = 1
   txtCampo(3).Mask = "99,99"
   txtCampo(3).BoundColumn = ""
   txtCampo(3).ListFields = ""
   txtCampo(3).OrderFields = ""
   txtCampo(3).Relation = ""
   txtCampo(3).Source = ""
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(3).DataField), txtCampo(3)

   Set txtCampo(4).CtPri = txtCp(4)
   txtCampo(4).DataType = 1
   txtCampo(4).Mask = "99,99"
   txtCampo(4).BoundColumn = ""
   txtCampo(4).ListFields = ""
   txtCampo(4).OrderFields = ""
   txtCampo(4).Relation = ""
   txtCampo(4).Source = ""
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(4).DataField), txtCampo(4)

   Set txtCampo(5).CtPri = txtCp(5)
   txtCampo(5).DataType = 1
   txtCampo(5).Mask = "99"
   txtCampo(5).BoundColumn = ""
   txtCampo(5).ListFields = ""
   txtCampo(5).OrderFields = ""
   txtCampo(5).Relation = ""
   txtCampo(5).Source = ""
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(5).DataField), txtCampo(5)

   Set chkCampo(0).CtPri = chkCp(0)
   chkCampo(0).DataType = 5
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(chkCampo(0).DataField), chkCampo(0)

 Exit Sub

 DeuErro:
  CErr.NumErro = Err
  CErr.FunctionName = "DefineControles0"
  CErr.Origem = CStr(vgFormID) +" - "+ Me.Caption
 CErr.Show
End Sub


'evento - antes de descarregar o formulário
Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)
   If vgSituacao <> ACAO_NAVEGANDO And vgBotoesOK Then  'botoeira esta correta?
      AtivaForm Me                                      'entao coloca
   End If
   Cancel = FormPendente(Me)                            've se tem atualizacao pendente
End Sub

'evento - redefinido o tamanho do formulário
Private Sub Form_Resize()
   AjustaPanFundo Me
End Sub

'evento - descarregando o formulário da memória
Private Sub Form_Unload(Cancel As Integer)
   Dim i As Integer
   On Error Resume Next
   FinalizaForm Me
   Set lblAjuste = Nothing
   For i = 0 To UBound(txtCampo)
      txtCampo(i).Finalize
      Set txtCampo(i) = Nothing
   Next
   Set chkCampo(0) = Nothing

   'se tiver imprimindo registros em grade, fecha form de selecao/preview
   UnLoad vgFrmImpCons
   Set vgFrmImpCons = Nothing

   grdBrowse.Finalize                             'descarrega o grid
   Set frmIcms = Nothing                          'libera o segmento de código do form
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


