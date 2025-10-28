VERSION 5.00
Begin VB.Form frmConNFe
   ForeColor                =   &H80000008
   BorderStyle              =   2
   Height                   =   4950
   Left                     =   2190
   LinkTopic                =   "ConNFe"
   LockControls             =   -1
   KeyPreview               =   -1
   MDIChild                 =   -1
   ScaleHeight              =   4530
   ScaleWidth               =   8250
   Top                      =   1750
   Width                    =   8340
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
      Height                   =   4350
      Left                     =   15
      Width                    =   8070
      Top                      =   15
      TabStop                  =  0
      _extentx                 =   14227
      _extenty                 =   7669
      Index                    =   0 
      Begin NFE.GCpMM mmCampo
         Appearance               =   0
         BackColor                =   &H8000000F
         BorderStyle              =   0
         Stretch                  =   0
         Height                   =   1410
         Left                     =   75
         Width                    =   1440
         Top                      =   75
         Index                    =   0 
         TabStop                  =   0
         ScrollBars               =   0
         Locked                   =   -1
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   -1
         Height                   =   435
         Left                     =   1695
         Width                    =   1980
         Top                      =   375
         Alignment                =   0
         BeginProperty Font
            Name                     =   "Microsoft Sans Serif"
            CharSet                  =   0
            Weight                   =   700
            Size                     =   18
            Underline                =   0
            Italic                   =   0
            StrikeThrough            =   0
         EndProperty
         ForeColor                =   &H80000008
         Caption                  =   "Nota Fiscal"
         Index                    =   0 
      End
      Begin VB.Line Linha
         BorderColor              =   -2147483640
         BorderStyle              =   1
         BorderWidth              =   1
         X1                       =   1755
         Y1                       =   765
         X2                       =   3675
         Y2                       =   765
         Index                    =   0 
      End
      Begin VB.Label labFdo0
         Appearance               =  0
         BorderStyle              =  1
         BackColor                =  &H80000005
         Left                     =   1425
         Top                      =   1575
         Width                    =   1170
         Height                   =   270
      End
      Begin VB.CommandButton bottxtCampo0
         Style                    =   1
         TabStop                  =   0
         Index                    =   1
         Left                     =   2325
         Top                      =   1590
         Width                    =   255
         Height                   =   240
      End
      Begin VB.CommandButton bottxtCampo0
         Style                    =   1
         TabStop                  =   0
         Index                    =   2
         Left                     =   2070
         Top                      =   1590
         Width                    =   255
         Height                   =   240
      End
      Begin VB.TextBox txtCp
         Appearance               =   0
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
         ForeColor                =   &H80000008
         BorderStyle              =   0
         Alignment                =   0
         TabIndex                 =   0
         TabStop                  =   -1
         Height                   =   240
         Left                     =   1440
         Width                    =   615
         Top                      =   1590
         Index                    =   0 
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   -1
         Height                   =   240
         Left                     =   2790
         Width                    =   840
         Top                      =   1575
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
         Caption                  =   "Dt. Inicial:"
         Index                    =   1 
      End
      Begin VB.Label labFdo1
         Appearance               =  0
         BorderStyle              =  1
         BackColor                =  &H80000005
         Left                     =   3765
         Top                      =   1575
         Width                    =   1440
         Height                   =   270
      End
      Begin VB.CommandButton bottxtCampo1
         Style                    =   1
         TabStop                  =   0
         Index                    =   0
         Left                     =   4935
         Top                      =   1590
         Width                    =   255
         Height                   =   240
      End
      Begin VB.TextBox txtCp
         Appearance               =   0
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
         ForeColor                =   &H80000008
         MaxLength                =   254
         BorderStyle              =   0
         Alignment                =   0
         TabIndex                 =   1
         TabStop                  =   -1
         Height                   =   240
         Left                     =   3780
         Width                    =   1140
         Top                      =   1590
         Index                    =   1 
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   -1
         Height                   =   240
         Left                     =   5400
         Width                    =   765
         Top                      =   1575
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
         Caption                  =   "Dt. Final:"
         Index                    =   2 
      End
      Begin VB.Label labFdo2
         Appearance               =  0
         BorderStyle              =  1
         BackColor                =  &H80000005
         Left                     =   6360
         Top                      =   1575
         Width                    =   1425
         Height                   =   270
      End
      Begin VB.CommandButton bottxtCampo2
         Style                    =   1
         TabStop                  =   0
         Index                    =   0
         Left                     =   7515
         Top                      =   1590
         Width                    =   255
         Height                   =   240
      End
      Begin VB.TextBox txtCp
         Appearance               =   0
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
         ForeColor                =   &H80000008
         MaxLength                =   254
         BorderStyle              =   0
         Alignment                =   0
         TabIndex                 =   2
         TabStop                  =   -1
         Height                   =   240
         Left                     =   6375
         Width                    =   1125
         Top                      =   1590
         Index                    =   2 
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   -1
         Height                   =   240
         Left                     =   735
         Width                    =   585
         Top                      =   1995
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
         Caption                  =   "Geral.:"
         Index                    =   3 
      End
      Begin VB.Label labFdo3
         Appearance               =  0
         BorderStyle              =  1
         BackColor                =  &H80000005
         Left                     =   1395
         Top                      =   1995
         Width                    =   6398
         Height                   =   270
      End
      Begin VB.CommandButton bottxtCampo3
         Style                    =   1
         TabStop                  =   0
         Index                    =   1
         Left                     =   7523
         Top                      =   2010
         Width                    =   255
         Height                   =   240
      End
      Begin VB.CommandButton bottxtCampo3
         Style                    =   1
         TabStop                  =   0
         Index                    =   2
         Left                     =   7268
         Top                      =   2010
         Width                    =   255
         Height                   =   240
      End
      Begin VB.TextBox txtCp
         Appearance               =   0
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
         ForeColor                =   &H80000008
         BorderStyle              =   0
         Alignment                =   0
         TabIndex                 =   3
         TabStop                  =   -1
         Height                   =   240
         Left                     =   1410
         Width                    =   5843
         Top                      =   2010
         Index                    =   3 
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   -1
         Height                   =   240
         Left                     =   420
         Width                    =   900
         Top                      =   2415
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
         Caption                  =   "Município:"
         Index                    =   4 
      End
      Begin VB.Label labFdo4
         Appearance               =  0
         BorderStyle              =  1
         BackColor                =  &H80000005
         Left                     =   1395
         Top                      =   2415
         Width                    =   6398
         Height                   =   270
      End
      Begin VB.CommandButton bottxtCampo4
         Style                    =   1
         TabStop                  =   0
         Index                    =   1
         Left                     =   7523
         Top                      =   2430
         Width                    =   255
         Height                   =   240
      End
      Begin VB.CommandButton bottxtCampo4
         Style                    =   1
         TabStop                  =   0
         Index                    =   2
         Left                     =   7268
         Top                      =   2430
         Width                    =   255
         Height                   =   240
      End
      Begin VB.TextBox txtCp
         Appearance               =   0
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
         ForeColor                =   &H80000008
         BorderStyle              =   0
         Alignment                =   0
         TabIndex                 =   4
         TabStop                  =   -1
         Height                   =   240
         Left                     =   1410
         Width                    =   5843
         Top                      =   2430
         Index                    =   4 
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   -1
         Height                   =   240
         Left                     =   855
         Width                    =   480
         Top                      =   1575
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
         Caption                  =   "NFe.:"
         Index                    =   5 
      End
      Begin VB.CheckBox ChkCp
         Appearance               =   1
         BackColor                =   &H8000000F
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851}
            Name                     =   "MS Sans Serif"
            CharSet                  =   0
            Weight                   =   700
            Size                     =   9.75
            Underline                =   0
            Italic                   =   0
            StrikeThrough            =   0
         EndProperty
         ForeColor                =   &H80
         Alignment                =   0
         TabIndex                 =   5
         TabStop                  =   -1
         Height                   =   255
         Left                     =   1755
         Width                    =   1695
         Top                      =   915
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851}
            Name                     =   "MS Sans Serif"
            CharSet                  =   0
            Weight                   =   700
            Size                     =   9.75
            Underline                =   0
            Italic                   =   0
            StrikeThrough            =   0
         EndProperty
         ForeColor                =   &H80
         Alignment                =   0
         Caption                  =   "Canceladas"
         Index                    =   0 
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   -1
         Height                   =   240
         Left                     =   7695
         Width                    =   45
         Top                      =   4575
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
         Index                    =   6 
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   -1
         Height                   =   240
         Left                     =   570
         Width                    =   750
         Top                      =   2835
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
         Caption                  =   "Produto:"
         Index                    =   7 
      End
      Begin VB.Label labFdo5
         Appearance               =  0
         BorderStyle              =  1
         BackColor                =  &H80000005
         Left                     =   1395
         Top                      =   2835
         Width                    =   6398
         Height                   =   270
      End
      Begin VB.CommandButton bottxtCampo5
         Style                    =   1
         TabStop                  =   0
         Index                    =   1
         Left                     =   7523
         Top                      =   2850
         Width                    =   255
         Height                   =   240
      End
      Begin VB.CommandButton bottxtCampo5
         Style                    =   1
         TabStop                  =   0
         Index                    =   2
         Left                     =   7268
         Top                      =   2850
         Width                    =   255
         Height                   =   240
      End
      Begin VB.TextBox txtCp
         Appearance               =   0
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
         ForeColor                =   &H80000008
         BorderStyle              =   0
         Alignment                =   0
         TabIndex                 =   6
         TabStop                  =   -1
         Height                   =   240
         Left                     =   1410
         Width                    =   5843
         Top                      =   2850
         Index                    =   5 
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   -1
         Height                   =   240
         Left                     =   735
         Width                    =   585
         Top                      =   3255
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
         Caption                  =   "CFOP:"
         Index                    =   8 
      End
      Begin VB.Label labFdo6
         Appearance               =  0
         BorderStyle              =  1
         BackColor                =  &H80000005
         Left                     =   1395
         Top                      =   3255
         Width                    =   6398
         Height                   =   270
      End
      Begin VB.CommandButton bottxtCampo6
         Style                    =   1
         TabStop                  =   0
         Index                    =   1
         Left                     =   7523
         Top                      =   3270
         Width                    =   255
         Height                   =   240
      End
      Begin VB.CommandButton bottxtCampo6
         Style                    =   1
         TabStop                  =   0
         Index                    =   2
         Left                     =   7268
         Top                      =   3270
         Width                    =   255
         Height                   =   240
      End
      Begin VB.TextBox txtCp
         Appearance               =   0
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
         ForeColor                =   &H80000008
         BorderStyle              =   0
         Alignment                =   0
         TabIndex                 =   7
         TabStop                  =   -1
         Height                   =   240
         Left                     =   1410
         Width                    =   5843
         Top                      =   3270
         Index                    =   6 
      End
      Begin NFE.GBotao botOk
         ButtonStyle              =   0
         JoinSeparators           =   0
         LeftSeparator            =   0
         TopSeparator             =   0
         TabIndex                 =   8
         TabStop                  =   -1
         ButtonType               =   0
         Height                   =   360
         Left                     =   4830
         Width                    =   1470
         Top                      =   3810
         CaptionAlign             =   4
         CaptionOffset            =   50
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851}
            Name                     =   "Microsoft Sans Serif"
            CharSet                  =   0
            Weight                   =   400
            Size                     =   9.75
            Underline                =   0
            Italic                   =   0
            StrikeThrough            =   0
         EndProperty
         ForeColor                =   &H80000012
         Caption                  =   "Prosseguir"
      End
      Begin NFE.GBotao botCancela
         ButtonStyle              =   0
         JoinSeparators           =   0
         LeftSeparator            =   0
         TopSeparator             =   0
         TabIndex                 =   9
         TabStop                  =   -1
         ButtonType               =   0
         Height                   =   360
         Left                     =   6315
         Width                    =   1470
         Top                      =   3810
         CaptionAlign             =   4
         CaptionOffset            =   50
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851}
            Name                     =   "Microsoft Sans Serif"
            CharSet                  =   0
            Weight                   =   400
            Size                     =   9.75
            Underline                =   0
            Italic                   =   0
            StrikeThrough            =   0
         EndProperty
         ForeColor                =   &H80000012
         Caption                  =   "Cancelar"
      End
   End
         Begin VB.Timer timUnLoad
                  Enabled         =   0
                  Interval        =   5
                  left            =   30
                  top             =   950
         End
End
Attribute VB_name = "frmConNFe"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
'* Sistema...: Emissor de Nota Fiscal Eletronica
'* Empresa...: Ygor Eduardo Dellalio
'* Módulo....: ConNFe
'* Função....: Nota Fiscal
'* CopyRight.: (C)2016 Ygor Eduardo Dellalio
'* Criação...: GAS-2007 - Gerador Automático de Sistemas
'* Data......: 13/07/2016 13:38:15
'* * * * * * *

Option Explicit
DefInt A-Z

Public vgSituacao As Integer                      'situação de edição que do módulo
Public vgCaracteristica As Integer                'caracteristica do módulo
Public vgTipo As Integer                          'tipo do módulo
Public vgPriVez As Integer                        'flag de carregamento do módulo  
Public vgFormID As Long                           'identificador único para o módulo 
Public vgIdentTab As String                       'nome da tabela principal do módulo 
Public vgEmBrowse As Integer                      'flag se o módulo esta em grade 
Public vgTemFiltro As Integer                     'flag se tem ou não filtro no módulo
Public vgCancelou As Integer                      'flag cancela ou nao o processo do módulo  
Public vgQueryAtual As String                     'expressão SQL definada para o módulo 

Public vgFP As New frmPreview                     'formuário de preview do relatório 
Public vgTooltips As New cTooltips                'classe de ajuda para os controes do módulo
Public vgFG As frmGauge                           'formulário do gauge 
Public vgQReg As Long                             'quantidade de já feira para o gauge  

Dim txtCampo(6) As New FormataCampos              'classe dos compos tipo texto do módulo  
Dim chkCampo(0) As New FormataCampos              'classe dos compos tipo lógico do módulo 
Dim vgPodeFazerUnLoad As Boolean                  'flag se o módulo pode ou nao ser removido da memória
Dim Sequencia As Double, Dt_Inicial As Variant, Dt_Final As Variant
Dim Geral As Double, Municipio As Double, Canceladas As Boolean
Dim Produto As Double, Cfop As Double
Public LblAjuste As Object

Private Sub ProssegueExecucao()
   Dim Tb As New GRecordSet, i As Long
   Dim vgFGrid As New frmBrowse, SQL As String
   
   On Error Resume Next
   
   SQL = "SELECT [Sequencia da Nota Fiscal], Nota, " & _
         "[Data de Emissão], [Razão Social], Município, [Valor Total], [Nota Cancelada] " & _
         "FROM( " & _
         "SELECT [Nota Fiscal].[Sequencia da Nota Fiscal], [Data de Emissão], Geral.[Sequencia Do Geral], " & _
         "Geral.[Razão Social], Municipios.[Sequencia Do Municipio], " & _
         "Municipios.[Descrição do Municipio] Município, Autorizada, [Nota Cancelada], " & _
         "[Numero da NFe] Nota, [Valor Total da NFe] As [Valor Total] " & _
         "FROM [Nota Fiscal] LEFT JOIN Geral ON [Nota Fiscal].[Sequencia Do Geral] = Geral.[Sequencia Do Geral] " & _
         "LEFT JOIN Municipios ON Geral.[Sequencia Do Municipio] = Municipios.[Sequencia Do Municipio] " & _
         "LEFT JOIN [Produtos da Nota Fiscal] ON [Nota Fiscal].[Sequencia da Nota Fiscal] = [Produtos da Nota Fiscal].[Sequencia da Nota Fiscal] " & _
         "WHERE [Nota Fiscal].[Sequencia Do Geral] > 0 " & Filtro2()
   SQL = SQL & " ) A " & _
               "WHERE " & Filtro() & _
               " GROUP BY [Sequencia da Nota Fiscal], Nota, [Data de Emissão], [Razão Social], " & _
               "Município, [Valor Total], [Nota Cancelada] " & _
               "ORDER BY [Sequencia da Nota Fiscal]"
      
   With vgFGrid
      Tag = "Nota Fiscal  (Clicle na NFe que deseja Consultar e Aperte F3 para Abrir a Consulta)"
            
      vgNovaQuery = SQL
         
      Set Tb = vgDb.OpenRecordSet(vgNovaQuery)
                       
      'NAO PODE TER ORDER BY
      .vgTitConsulta = Tag
      .vgFiltroInicial = FiltroJanela
      If Tb.RecordCount = 1 Then
         'Unload Me
         seqRegistro = Tb![Sequencia da Nota Fiscal]
         frmNotaFisc.Show
         frmNotaFisc.vgFiltroInicial = "[Sequencia da Nota Fiscal] = " & seqRegistro
         InicializaFiltro frmNotaFisc
         frmNotaFisc.SetFocus
      Else
         With .grdBrowse
            '.DefineOrderColumn .Columns("Seqüência").Index
            .ColumnCaption("Sequencia da Nota Fiscal") = "Seqüência"
            .ColumnWidth("Sequencia da Nota Fiscal") = 1100
            .ColumnWidth("Nota") = 750
            .ColumnWidth("Data de Emissão") = 1500
            .ColumnWidth("Razão Social") = 4000
            .ColumnWidth("Município") = 1700
            .ShowFilterBar = True
            '.Stripes = Zebrar
         End With
         Hide
         .Width = Screen.Width - 200
         .Top = (Screen.Height - .Height) / 2
         .Left = (Screen.Width - .Width) / 2
         .Show
      End If
      DoEvents
   End With
End Sub


Private Function Filtro2() As String
   Filtro2 = ""
   
   If Produto > 0 Then 'Produto
      Filtro2 = Filtro2 & " AND [Produtos da Nota Fiscal].[Sequencia do Produto] = " & Produto
   End If
   
   If CFOP > 0 Then 'CFOP
      Filtro2 = Filtro2 & " AND [Produtos da Nota Fiscal].CFOP = " & CFOP 'Produtos
   End If

End Function

Private Function Filtro() As String
      
   On Error Resume Next
      
   Filtro = "[Sequencia da Nota Fiscal] > 0"
   If Sequencia = 0 Then
      If Not Vazio(Dt_Inicial) Then 'Data Inicial
         Filtro = Filtro & " AND [Data de Emissão] >= " & D(Dt_Inicial)     
      End If
      If Not Vazio(Dt_Final) Then 'Data Final
         Filtro = Filtro & " AND [Data de Emissão] <= " & D(Dt_Final)         
      End If
      If Canceladas Then 
         Filtro = Filtro & " AND [Nota Cancelada] = 1"
      End If
      If Geral > 0 Then 'Geral
         Filtro = Filtro & " AND [Sequencia do Geral] = " & Geral
      End If
      If Municipio > 0 Then 'Municipio
         Filtro = Filtro & " AND [Sequencia do Municipio] = " & Municipio
      End If
   Else
      If Sequencia > 0 Then
         Filtro = Filtro & " AND [Sequencia da Nota Fiscal] = " & Sequencia
      End If
   End If
End Function


Private Function FiltroJanela() As String
   On Error Resume Next
      
   FiltroJanela = "[Sequencia da Nota Fiscal] > 0"
   If Sequencia = 0 Then
      If Not Vazio(Dt_Inicial) Then 'Data Inicial
         FiltroJanela = FiltroJanela & " AND [Data de Emissão] >= " & D(Dt_Inicial)     
      End If
      If Not Vazio(Dt_Final) Then 'Data Final
         FiltroJanela = FiltroJanela & " AND [Data de Emissão] <= " & D(Dt_Final)          
      End If
      If Canceladas Then 
         FiltroJanela = FiltroJanela & " AND [Nota Cancelada] = 1"
      End If
      If Geral > 0 Then 'Geral
         FiltroJanela = FiltroJanela & " AND [Sequencia do Geral] = " & Geral
      End If
      If Municipio > 0 Then 'Municipio
         FiltroJanela = FiltroJanela & " AND [Sequencia da Nota Fiscal] IN (SELECT [Sequencia da Nota Fiscal] FROM [Nota Fiscal] N INNER JOIN Geral G ON N.[Sequencia do Geral] = G.[Sequencia do Geral] INNER JOIN Municipios M ON G.[Sequencia do Municipio] = M.[Sequencia do Municipio] WHERE M.[Sequencia do Municipio] = " & Municipio & ")"
      End If
      If Produto > 0 Then 'Produto
         FiltroJanela = FiltroJanela & " AND [Sequencia da Nota Fiscal] IN(SELECT [Sequencia da Nota Fiscal] FROM [Produtos da Nota Fiscal] WHERE [Sequencia do Produto] = " & Produto & ")"
      End If
      If CFOP > 0 Then 'CFOP
         FiltroJanela = FiltroJanela & " AND [Sequencia da Nota Fiscal] IN (SELECT [Sequencia da Nota Fiscal] FROM [Produtos da Nota Fiscal] WHERE CFOP = " & CFOP & ")" 
      End If
   Else
      If Sequencia > 0 Then
         FiltroJanela = FiltroJanela & " AND [Sequencia da Nota Fiscal] = " & Sequencia
      End If
   End If
End Function

'inicializa variaveis (apelidos) coms os campos correspondentes
Private Sub InicializaApelidos(vgComOQue As Integer)
   On Error Resume Next                           'prepara para possíveis erros
   Sequencia = txtCampo(0).Value
   Dt_Inicial = txtCampo(1).Value
   Dt_Final = txtCampo(2).Value
   Geral = txtCampo(3).Value
   Municipio = txtCampo(4).Value
   Canceladas = chkCampo(0).Value
   Produto = txtCampo(5).Value
   Cfop = txtCampo(6).Value
   If Err Then Err.Clear                          'se deu algum erro, vamos resetá-lo
End Sub

'poe relacionamento e filtro na lista externa (combobox)
Private Sub PoeRelEFiltroCbo(Index As Integer)
   On Error Resume Next
   Select Case Index
      Case 0
         txtCampo(0).Filter = "[Sequencia da nota fiscal] > " & 0 & ""
                           txtCampo(0).PesqSQLExpression = "SELECT [Nota fiscal].[Sequencia da nota fiscal], [Nota fiscal].[Numero da nfe], [Nota fiscal].[Data de emissão] FROM [Nota fiscal] WHERE ([Nota fiscal].[Sequencia da nota fiscal] > " + CStr(0) + ")"
      Case 3
         txtCampo(3).Filter = "[Sequencia do geral] > " & 0 & ""
                           txtCampo(3).PesqSQLExpression = "SELECT Geral.[Sequencia do geral], Geral.[Razão social], Geral.[Nome fantasia], Geral.Endereço, Geral.Complemento, " + _
                                                              "Geral.Nro, Geral.Bairro, Municipios.[Sequencia do municipio], Municipios.[Descrição do municipio], Municipios.Uf, " + _
                                                              "Geral.Cep FROM Geral, Municipios WHERE (Geral.[Sequencia do geral] > " + CStr(0) + ") AND (Geral.[Sequencia do municipio] = " + _
                                                              "Municipios.[Sequencia do municipio])"
      Case 4
         txtCampo(4).Filter = "[Sequencia do municipio] > " & 0 & ""
                           txtCampo(4).PesqSQLExpression = "SELECT Municipios.[Sequencia do municipio], Municipios.[Descrição do municipio], Municipios.Uf, Municipios.Cep FROM Municipios WHERE (Municipios.[Sequencia do municipio] > " + CStr(0) + ")"
      Case 5
         txtCampo(5).Filter = "[Sequencia do produto] > " & 0 & ""
                           txtCampo(5).PesqSQLExpression = "SELECT Produtos.[Sequencia do produto], Produtos.Descrição, [Classificação fiscal].Ncm FROM Produtos, " + _
                                                              "[Classificação fiscal] WHERE (Produtos.[Sequencia do produto] > " + CStr(0) + ") AND (Produtos.[Sequencia da classificação] = " + _
                                                              "[Classificação fiscal].[Sequencia da classificação])"
      Case 6
         txtCampo(6).Filter = "[Sequencia da natureza] > " & 0 & ""
                           txtCampo(6).PesqSQLExpression = "SELECT [Natureza de operação].[Sequencia da natureza], [Natureza de operação].Cfop, [Natureza de operação].[Descrição do cfop] FROM [Natureza de operação] WHERE ([Natureza de operação].[Sequencia da natureza] > " + CStr(0) + ")"
   End Select
End Sub

'executa processos/validacoes nos campos do formuário
Public Function Executar(vgOq As String) As String
   Dim vgMsg As String, vgOk As Integer, vgNVez As Integer
   On Error Goto DeuErro                          'fica na espera de um erro...
   vgMsg$ = ""                                    'retorna uma msg dizendo o motivo
   vgOk = True                                    'se a validação esta OK
   vgNVez = 0                                     'porque não fez o processo/validacoes
   If vgOq = INICIALIZACOES Then
      InicializaApelidos COM_TEXTBOX
      On Error Resume Next
            chkCampo(0).Value = False
   ElseIf vgOq = INI_APELIDOS Then
      InicializaApelidos COM_REGISTRO
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

'executa a pré-validação dos campos
Private Sub ExecutaPreValidacao()
   Dim Ok As Boolean
   On Error Resume Next                           'prepara para possiveis erros
   Ok = (Sequencia = 0)
   txtCampo(1).Enabled = (Ok And txtCampo(1).Editable)
   Ok = (Sequencia = 0)
   txtCampo(2).Enabled = (Ok And txtCampo(2).Editable)
   Ok = (Sequencia = 0)
   txtCampo(3).Enabled = (Ok And txtCampo(3).Editable)
   Ok = (Sequencia = 0)
   txtCampo(4).Enabled = (Ok And txtCampo(4).Editable)
   Ok = (Sequencia = 0)
   txtCampo(5).Enabled = (Ok And txtCampo(5).Editable)
   Ok = (Sequencia = 0)
   txtCampo(6).Enabled = (Ok And txtCampo(6).Editable)
   If Err Then Err.Clear                          'se houve erro, limpa...
End Sub

'evento - quando o conteúdo do campo for alterado
Private Sub txtCp_Change(Index As Integer)
   If vgPriVez Or txtCampo(Index).PriVez Then Exit Sub
   InicializaApelidos COM_TEXTBOX                         'inicializa apelidos com o que esta sendo digitado
   txtCampo(Index).Change
   If Index = 0 Or Index = 3 Or Index = 4 Or Index = 5 Or Index = 6 Then
      ExecutaPreValidacao
   End If
End Sub

'evento - quando o campo receber o foco
Private Sub txtCp_GotFocus(Index As Integer)
         On Error Resume Next
         Select Case Index
         Case 0
            PoeRelEFiltroCbo 0
         Case 1
            If Len(txtCp(1).Text) = 0 Then
               txtCampo(1).Value = Date
               txtCp_Change Index
               InicializaApelidos COM_TEXTBOX
               ExecutaPreValidacao
            End If
         Case 2
            If Len(txtCp(2).Text) = 0 Then
               txtCampo(2).Value = UltD(Dt_Inicial)
               txtCp_Change Index
               InicializaApelidos COM_TEXTBOX
               ExecutaPreValidacao
            End If
         Case 3
            PoeRelEFiltroCbo 3
         Case 4
            PoeRelEFiltroCbo 4
         Case 5
            PoeRelEFiltroCbo 5
         Case 6
            PoeRelEFiltroCbo 6
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
   txtCampo(Index).LostFocus                      'executa LostFocus na classe
   InicializaApelidos COM_TEXTBOX                 'inicializa apelidos dos campos
   ExecutaPreValidacao                            'habilita/desabilita campos
End Sub


'evento - quando o check for marcado/desmarcado
Private Sub chkCp_Click(Index As Integer)
   If vgPriVez Then Exit Sub
   InicializaApelidos COM_TEXTBOX
   ExecutaPreValidacao                            'habilita/desabilita campos
   chkCampo(Index).Change
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

'evento - inicialização do formulário
Private Sub Form_Load()
   On Error GoTo DeuErro
   Screen.MousePointer = vbHourglass
   Caption = LoadGasString(17850)
   vgFormID = 632
   vgIdentTab = ""
   vgPriVez = True
   vgPodeFazerUnLoad = False
   vgTipo = TP_COMUM
   vgCaracteristica = F_COMUM
   vgTemFiltro = False
   vgSituacao = ACAO_NAVEGANDO
   Set mmCampo(0).Picture = LoadPicture(LoadGasPicture(9355))
   Set botOk.Picture = LoadPicture(LoadGasPicture(9356))
   Set botCancela.Picture = LoadPicture(LoadGasPicture(9357))
   Set LblAjuste = Label(6)
   DefineControles
   vgTooltips.Create
   Label(0).Caption = LoadGasString(17855)
   Label(1).Caption = LoadGasString(17856)
   Label(2).Caption = LoadGasString(17857)
   Label(3).Caption = LoadGasString(17858)
   Label(4).Caption = LoadGasString(17859)
   Label(5).Caption = LoadGasString(17860)
   chkCampo(0).Caption = LoadGasString(17861)
   Label(6).Caption = LoadGasString(17862)
   Label(7).Caption = LoadGasString(17863)
   Label(8).Caption = LoadGasString(17864)
   vgTooltips.AddTool botOk, 0, LoadGasString(17865)
   botOk.Caption = LoadGasString(17866)
   vgTooltips.AddTool botCancela, 0, LoadGasString(17867)
   botCancela.Caption = LoadGasString(17868)
   AjustaTamanho Me
   Executar INICIALIZACOES
   InicializaApelidos COM_TEXTBOX
   ExecutaPreValidacao
   Screen.MousePointer = vbDefault
   vgPriVez = False
   Exit Sub

DeuErro:
   CErr.NumErro = Err
   CErr.FunctionName = "Form_Load"
   CErr.Origem = CStr(vgFormID) + " - " + Me.Caption
   CErr.Show
End Sub


'evento - quando o formulário receber o foco
Private Sub Form_Activate()
   Dim i As Integer
   AtivaForm Me
End Sub

'evento - redefinido o tamanho do formulário
Private Sub Form_Resize()
   AjustaPanFundo Me
End Sub

'define as propriedades das classe dos campos do formuário
Public Sub DefineControles()
 On Error GoTo DeuErro

   Set txtCampo(0).CtPri = txtCp(0)
   Set txtCampo(0).CtFdo = labFdo0
   Set txtCampo(0).CtBot(BOT_LISTA) = bottxtCampo0(BOT_LISTA)
   Set txtCampo(0).CtBot(BOT_COMBO) = bottxtCampo0(BOT_COMBO)
   bottxtCampo0(BOT_LISTA).Caption = "P"
   Set bottxtCampo0(BOT_COMBO).Picture = LoadPicture(LoadGasPicture(3))
   txtCampo(0).DataType = 1
   txtCampo(0).Mask = ""
   txtCampo(0).PesqModoAbertura =  2 
   txtCampo(0).PesqFieldCapture = "[Nota fiscal].[Sequencia da nota fiscal]"
   txtCampo(0).BoundColumn = "Sequencia da nota fiscal"
   txtCampo(0).ListFields = "Numero da nfe"
   txtCampo(0).OrderFields = "Numero da nfe"
   txtCampo(0).Relation = ""
   txtCampo(0).Source = "Nota fiscal"
   txtCampo(0).vgfrmGMCale.grdListaG.AutoRebind = True

   Set txtCampo(1).CtPri = txtCp(1)
   Set txtCampo(1).CtFdo = labFdo1
   Set txtCampo(1).CtBot(BOT_ACAO) = bottxtCampo1(BOT_ACAO)
   Set bottxtCampo1(BOT_ACAO).Picture = LoadPicture(LoadGasPicture(4))
   txtCampo(1).DataType = 2
   txtCampo(1).Mask = "99/99/9999"
   txtCampo(1).BoundColumn = ""
   txtCampo(1).ListFields = ""
   txtCampo(1).OrderFields = ""
   txtCampo(1).Relation = ""
   txtCampo(1).Source = ""

   Set txtCampo(2).CtPri = txtCp(2)
   Set txtCampo(2).CtFdo = labFdo2
   Set txtCampo(2).CtBot(BOT_ACAO) = bottxtCampo2(BOT_ACAO)
   Set bottxtCampo2(BOT_ACAO).Picture = LoadPicture(LoadGasPicture(4))
   txtCampo(2).DataType = 2
   txtCampo(2).Mask = "99/99/9999"
   txtCampo(2).BoundColumn = ""
   txtCampo(2).ListFields = ""
   txtCampo(2).OrderFields = ""
   txtCampo(2).Relation = ""
   txtCampo(2).Source = ""

   Set txtCampo(3).CtPri = txtCp(3)
   Set txtCampo(3).CtFdo = labFdo3
   Set txtCampo(3).CtBot(BOT_LISTA) = bottxtCampo3(BOT_LISTA)
   Set txtCampo(3).CtBot(BOT_COMBO) = bottxtCampo3(BOT_COMBO)
   bottxtCampo3(BOT_LISTA).Caption = "P"
   Set bottxtCampo3(BOT_COMBO).Picture = LoadPicture(LoadGasPicture(3))
   txtCampo(3).DataType = 1
   txtCampo(3).Mask = ""
   txtCampo(3).PesqModoAbertura =  2 
   txtCampo(3).PesqFieldCapture = "Geral.[Sequencia do geral]"
   txtCampo(3).BoundColumn = "Sequencia do geral"
   txtCampo(3).ListFields = "Razão social"
   txtCampo(3).OrderFields = "Razão social"
   txtCampo(3).Relation = ""
   txtCampo(3).Source = "Geral"
   txtCampo(3).vgfrmGMCale.grdListaG.AutoRebind = True

   Set txtCampo(4).CtPri = txtCp(4)
   Set txtCampo(4).CtFdo = labFdo4
   Set txtCampo(4).CtBot(BOT_LISTA) = bottxtCampo4(BOT_LISTA)
   Set txtCampo(4).CtBot(BOT_COMBO) = bottxtCampo4(BOT_COMBO)
   bottxtCampo4(BOT_LISTA).Caption = "P"
   Set bottxtCampo4(BOT_COMBO).Picture = LoadPicture(LoadGasPicture(3))
   txtCampo(4).DataType = 1
   txtCampo(4).Mask = ""
   txtCampo(4).PesqModoAbertura =  2 
   txtCampo(4).PesqFieldCapture = "Municipios.[Sequencia do municipio]"
   txtCampo(4).BoundColumn = "Sequencia do municipio"
   txtCampo(4).ListFields = "Descrição do municipio; Uf"
   txtCampo(4).OrderFields = "Descrição do municipio"
   txtCampo(4).Relation = ""
   txtCampo(4).Source = "Municipios"
   txtCampo(4).vgfrmGMCale.grdListaG.AutoRebind = True

   Set chkCampo(0).CtPri = chkCp(0)
   chkCampo(0).DataType = 5

   Set txtCampo(5).CtPri = txtCp(5)
   Set txtCampo(5).CtFdo = labFdo5
   Set txtCampo(5).CtBot(BOT_LISTA) = bottxtCampo5(BOT_LISTA)
   Set txtCampo(5).CtBot(BOT_COMBO) = bottxtCampo5(BOT_COMBO)
   bottxtCampo5(BOT_LISTA).Caption = "P"
   Set bottxtCampo5(BOT_COMBO).Picture = LoadPicture(LoadGasPicture(3))
   txtCampo(5).DataType = 1
   txtCampo(5).Mask = ""
   txtCampo(5).PesqModoAbertura =  2 
   txtCampo(5).PesqFieldCapture = "Produtos.[Sequencia do produto]"
   txtCampo(5).BoundColumn = "Sequencia do produto"
   txtCampo(5).ListFields = "Descrição"
   txtCampo(5).OrderFields = "Descrição"
   txtCampo(5).Relation = ""
   txtCampo(5).Source = "Produtos"
   txtCampo(5).vgfrmGMCale.grdListaG.AutoRebind = True

   Set txtCampo(6).CtPri = txtCp(6)
   Set txtCampo(6).CtFdo = labFdo6
   Set txtCampo(6).CtBot(BOT_LISTA) = bottxtCampo6(BOT_LISTA)
   Set txtCampo(6).CtBot(BOT_COMBO) = bottxtCampo6(BOT_COMBO)
   bottxtCampo6(BOT_LISTA).Caption = "P"
   Set bottxtCampo6(BOT_COMBO).Picture = LoadPicture(LoadGasPicture(3))
   txtCampo(6).DataType = 1
   txtCampo(6).Mask = ""
   txtCampo(6).PesqModoAbertura =  2 
   txtCampo(6).PesqFieldCapture = "[Natureza de operação].[Sequencia da natureza]"
   txtCampo(6).BoundColumn = "Cfop"
   txtCampo(6).ListFields = "Cfop; Descrição do cfop"
   txtCampo(6).OrderFields = "Cfop"
   txtCampo(6).Relation = ""
   txtCampo(6).Source = "Natureza de operação"
   txtCampo(6).vgfrmGMCale.grdListaG.AutoRebind = True

 Exit Sub

 DeuErro:
  CErr.NumErro = Err
  CErr.FunctionName = "DefineControles0"
  CErr.Origem = CStr(vgFormID) +" - "+ Me.Caption
 CErr.Show
End Sub

'evento - valida digitações e prossegue a execução
Private Sub botOk_Click()
   Dim k As String
   If vgPriVez Then Exit Sub
   vgPriVez = True
   k$ = Executar(VALIDACOES)                      'faz validaçao dos campos
   If Len(k$) > 0 Then                            'EPA!... tem campo errado
      If Instr(k$, "|") > 0 Then
         Err.Source = Parse$(k$, "|")
         Err.Number = Val(Parse$(k$, "|"))        'deu erro
         Err.Description = Parse$(k$, "|")
         CErr.NumErro = Err.Number
         CErr.Show
      Else
         Beep                                     'manda aviso sonoro
         MsgBox k$, vbCritical, vgAtencao$        'mostra mensagem do erro
      End If
      Screen.MousePointer = vbDefault             'reseta o pointer do mouse
      vgPriVez = False
      Exit Sub                                    'e sai para continuar a ediçao ou inclusao
   End If                                         'OK. os campos estao certos
   ProssegueExecucao  
   vgPriVez = False
End Sub

'evento - cancela formulário
Private Sub botCancela_Click()
   Unload Me
End Sub

'evento - antes de descarregar o formulário
Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)
   If vgPodeFazerUnLoad = False Then
      timUnLoad.Enabled = True
      Cancel = True
   End If
   Cancel = Cancel Or(Not vgFG Is Nothing)
End Sub

'evento - descarregando o formulário da memória
Private Sub Form_Unload(Cancel As Integer)
   Dim i As Integer
   On Error Resume Next
   FinalizaForm Me
   Set LblAjuste = Nothing
   For i = 0 To UBound(txtCampo)
      txtCampo(i).Finalize
      Set txtCampo(i) = Nothing
   Next
   Set chkCampo(0) = Nothing
   Set vgFG = Nothing
   Set vgTooltips = Nothing
   Set frmConNFe = Nothing                        'libera o segmento de código do form
End Sub

'evento - quando qq tecla for digitada no formulário
Private Sub Form_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyEscape Then                 'se teclou ESC
      Unload Me                                   'tira este form da memória
   End If
End Sub

'evento - quando o tempo esgotar  
Private Sub timUnLoad_Timer()
   timUnLoad.Enabled = False
   vgPodeFazerUnLoad = True
   Unload Me
End Sub


'evento - quando o botão for apertado
Private Sub bottxtCampo0_Click(Index As Integer)
   txtCampo(0).SetFocus
   DoEvents
   txtCampo(0).botClick Index
End Sub

'evento - quando o botão for apertado
Private Sub bottxtCampo1_Click(Index As Integer)
   txtCampo(1).SetFocus
   DoEvents
   txtCampo(1).botClick Index
End Sub

'evento - quando o botão for apertado
Private Sub bottxtCampo2_Click(Index As Integer)
   txtCampo(2).SetFocus
   DoEvents
   txtCampo(2).botClick Index
End Sub

'evento - quando o botão for apertado
Private Sub bottxtCampo3_Click(Index As Integer)
   txtCampo(3).SetFocus
   DoEvents
   txtCampo(3).botClick Index
End Sub

'evento - quando o botão for apertado
Private Sub bottxtCampo4_Click(Index As Integer)
   txtCampo(4).SetFocus
   DoEvents
   txtCampo(4).botClick Index
End Sub

'evento - quando o botão for apertado
Private Sub bottxtCampo5_Click(Index As Integer)
   txtCampo(5).SetFocus
   DoEvents
   txtCampo(5).botClick Index
End Sub

'evento - quando o botão for apertado
Private Sub bottxtCampo6_Click(Index As Integer)
   txtCampo(6).SetFocus
   DoEvents
   txtCampo(6).botClick Index
End Sub

'evento - quando o mouse for pressionado sobre o campo
Private Sub txtCp_MouseDown(Index As Integer, Button As Integer, Shift As Integer, x as Single, y as Single)
   txtCampo(Index).MouseDown
End Sub

