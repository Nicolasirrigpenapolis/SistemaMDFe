Version 5.00
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "TABCTL32.OCX"
Begin VB.Form frmGeral
   ForeColor                =   &H80000008
   BorderStyle              =   2
   Height                   =   7695
   Left                     =   1815
   LinkTopic                =   "Geral"
   LockControls             =   -1
   KeyPreview               =   -1
   MDIChild                 =   -1
   ScaleHeight              =   7275
   ScaleWidth               =   11580
   Top                      =   1780
   Width                    =   11670
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
      Height                   =   7095
      Left                     =   15
      Width                    =   11400
      Top                      =   15
      TabStop                  =  0
      _extentx                 =   20098
      _extenty                 =   12508
      Index                    =   0 
      Begin NFE.GCpMM mmCampo
         Appearance               =   0
         BackColor                =   &H8000000F
         BorderStyle              =   0
         Stretch                  =   0
         Height                   =   1425
         Left                     =   240
         Width                    =   1395
         Top                      =   120
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
         Left                     =   1860
         Width                    =   960
         Top                      =   180
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
         Caption                  =   "Geral"
         Index                    =   0 
      End
      Begin VB.Line Linha
         BorderColor              =   -2147483640
         BorderStyle              =   1
         BorderWidth              =   1
         X1                       =   1920
         Y1                       =   630
         X2                       =   2775
         Y2                       =   630
         Index                    =   0 
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   0
         Height                   =   240
         Left                     =   300
         Width                    =   1095
         Top                      =   1740
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
         ForeColor                =   &H80000008
         BorderStyle              =   1
         Alignment                =   1
         Locked                   =   -1
         TabIndex                 =   18
         TabStop                  =   0
         Height                   =   300
         Left                     =   1440
         Width                    =   840
         Top                      =   1740
         DataField                =   "Sequencia do geral"
         TabStop                  =  0
         Index                    =   0 
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
         ForeColor                =   &H80
         Alignment                =   0
         TabIndex                 =   19
         TabStop                  =   0
         Height                   =   255
         Left                     =   1920
         Width                    =   1140
         Top                      =   1200
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851}
            Name                     =   "Microsoft Sans Serif"
            CharSet                  =   0
            Weight                   =   700
            Size                     =   9.75
            Underline                =   0
            Italic                   =   0
            StrikeThrough            =   0
         EndProperty
         ForeColor                =   &H80
         Alignment                =   0
         Caption                  =   "Cliente"
         Index                    =   0 
         DataField                =   "Cliente"
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
         ForeColor                =   &H80
         Alignment                =   0
         TabIndex                 =   20
         TabStop                  =   0
         Height                   =   255
         Left                     =   3120
         Width                    =   2040
         Top                      =   1200
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851}
            Name                     =   "Microsoft Sans Serif"
            CharSet                  =   0
            Weight                   =   700
            Size                     =   9.75
            Underline                =   0
            Italic                   =   0
            StrikeThrough            =   0
         EndProperty
         ForeColor                =   &H80
         Alignment                =   0
         Caption                  =   "Transportadora"
         Index                    =   1 
         DataField                =   "Transportadora"
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
         ForeColor                =   &H80
         Alignment                =   0
         TabIndex                 =   21
         TabStop                  =   0
         Height                   =   255
         Left                     =   6900
         Width                    =   2115
         Top                      =   1200
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851}
            Name                     =   "Microsoft Sans Serif"
            CharSet                  =   0
            Weight                   =   700
            Size                     =   9.75
            Underline                =   0
            Italic                   =   0
            StrikeThrough            =   0
         EndProperty
         ForeColor                =   &H80
         Alignment                =   0
         Caption                  =   "Consumidor Final"
         Index                    =   2 
         DataField                =   "Consumidor final"
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
         ForeColor                =   &H80
         Alignment                =   0
         TabIndex                 =   22
         TabStop                  =   0
         Height                   =   255
         Left                     =   9180
         Width                    =   1035
         Top                      =   1200
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851}
            Name                     =   "Microsoft Sans Serif"
            CharSet                  =   0
            Weight                   =   700
            Size                     =   9.75
            Underline                =   0
            Italic                   =   0
            StrikeThrough            =   0
         EndProperty
         ForeColor                =   &H80
         Alignment                =   0
         Caption                  =   "Isento"
         Index                    =   3 
         DataField                =   "Isento"
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
         ForeColor                =   &H80
         Alignment                =   0
         TabIndex                 =   23
         TabStop                  =   0
         Height                   =   255
         Left                     =   10080
         Width                    =   1155
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
         ForeColor                =   &H80
         Alignment                =   0
         Caption                  =   "Inativo"
         Index                    =   4 
         DataField                =   "Inativo"
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   0
         Height                   =   240
         Left                     =   2460
         Width                    =   1380
         Top                      =   1740
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
         Caption                  =   "*Razão Social:"
         Index                    =   2 
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
         ForeColor                =   &H80000008
         MaxLength                =   60
         BorderStyle              =   1
         Alignment                =   0
         TabIndex                 =   0
         TabStop                  =   -1
         Height                   =   300
         Left                     =   3960
         Width                    =   7140
         Top                      =   1740
         DataField                =   "Razão social"
         Index                    =   1 
      End
      Begin TabDlg.SSTab Tabs
         TabsPerRow               =   3
         TabHeight                =   519
         BackColor                =   &H8000000F
         Style                    =   1
         TabOrientation           =   0
         Tabs                     =   1
         TabIndex                 =   17
         TabStop                  =   0
         Height                   =   4500
         Left                     =   300
         Width                    =   10800
         Top                      =   2370
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
         Caption                  =   "Dados Principais"
         Index                    =   0 
         _version                 =   65536
         _extentx                 =   19040
         _extenty                 =   7933
         _stockprops              =   15
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   0
            Height                   =   240
            Left                     =   180
            Width                    =   1035
            Top                      =   600
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
            Caption                  =   "Fantasia...:"
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
            ForeColor                =   &H80000008
            MaxLength                =   60
            BorderStyle              =   1
            Alignment                =   0
            TabIndex                 =   1
            TabStop                  =   -1
            Height                   =   300
            Left                     =   1245
            Width                    =   6015
            Top                      =   600
            DataField                =   "Nome fantasia"
            Index                    =   2 
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   -1
            Height                   =   240
            Left                     =   7380
            Width                    =   630
            Top                      =   565
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
            ForeColor                =   &H80000008
            Caption                  =   "*Tipo:"
            Index                    =   4 
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   0
            Height                   =   240
            Left                     =   150
            Width                    =   1065
            Top                      =   1140
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
            Caption                  =   "*Endereço:"
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
            ForeColor                =   &H80000008
            MaxLength                =   100
            BorderStyle              =   1
            Alignment                =   0
            TabIndex                 =   2
            TabStop                  =   -1
            Height                   =   300
            Left                     =   1245
            Width                    =   5985
            Top                      =   1140
            DataField                =   "Endereço"
            Index                    =   3 
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   0
            Height                   =   240
            Left                     =   7440
            Width                    =   690
            Top                      =   1140
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
            Caption                  =   "Compl:"
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
            ForeColor                =   &H80000008
            MaxLength                =   30
            BorderStyle              =   1
            Alignment                =   0
            TabIndex                 =   3
            TabStop                  =   -1
            Height                   =   300
            Left                     =   8220
            Width                    =   2370
            Top                      =   1140
            DataField                =   "Complemento"
            Index                    =   4 
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   0
            Height                   =   240
            Left                     =   855
            Width                    =   360
            Top                      =   1680
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
            Caption                  =   "Nº.:"
            Index                    =   7 
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
            ForeColor                =   &H80000008
            MaxLength                =   8
            BorderStyle              =   1
            Alignment                =   0
            TabIndex                 =   4
            TabStop                  =   -1
            Height                   =   300
            Left                     =   1245
            Width                    =   555
            Top                      =   1680
            DataField                =   "Nro"
            Index                    =   5 
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   0
            Height                   =   240
            Left                     =   1920
            Width                    =   750
            Top                      =   1680
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
            Caption                  =   "*Bairro:"
            Index                    =   8 
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
            ForeColor                =   &H80000008
            MaxLength                =   60
            BorderStyle              =   1
            Alignment                =   0
            TabIndex                 =   5
            TabStop                  =   -1
            Height                   =   300
            Left                     =   2700
            Width                    =   2850
            Top                      =   1680
            DataField                =   "Bairro"
            Index                    =   6 
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   0
            Height                   =   240
            Left                     =   5640
            Width                    =   990
            Top                      =   1680
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
            Caption                  =   "*Município:"
            Index                    =   9 
         End
         Begin VB.Label labFdo7
            Appearance               =  1
            BorderStyle              =  1
            BackColor                =  &H80000005
            Left                     =   6720
            Top                      =   1680
            Width                    =   3570
            Height                   =   300
         End
         Begin VB.CommandButton bottxtCampo7
            Style                    =   1
            TabStop                  =   0
            Index                    =   1
            Left                     =   10005
            Top                      =   1710
            Width                    =   255
            Height                   =   240
         End
         Begin VB.CommandButton bottxtCampo7
            Style                    =   1
            TabStop                  =   0
            Index                    =   2
            Left                     =   9750
            Top                      =   1710
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
            ForeColor                =   &H80000008
            BorderStyle              =   0
            Alignment                =   0
            TabIndex                 =   6
            TabStop                  =   -1
            Height                   =   240
            Left                     =   6750
            Width                    =   2985
            Top                      =   1710
            DataField                =   "Sequencia do municipio"
            Index                    =   7 
         End
         Begin NFE.GBotao Botao
            ButtonStyle              =   0
            JoinSeparators           =   0
            LeftSeparator            =   0
            TopSeparator             =   0
            TabIndex                 =   25
            TabStop                  =   0
            ButtonType               =   0
            Height                   =   270
            Left                     =   10320
            Width                    =   270
            Top                      =   1680
            CaptionAlign             =   0
            CaptionOffset            =   50
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851}
               Name                     =   "MS Sans Serif"
               CharSet                  =   0
               Weight                   =   400
               Size                     =   8.25
               Underline                =   0
               Italic                   =   0
               StrikeThrough            =   0
            EndProperty
            ForeColor                =   &H80000012
            Caption                  =   ""
            Index                    =   0 
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   -1
            Height                   =   240
            Left                     =   825
            Width                    =   315
            Top                      =   2220
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
            Caption                  =   "UF:"
            Index                    =   10 
         End
         Begin VB.TextBox txtCp
            Appearance               =   1
            BackColor                =   &HE0E0E0
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851}
               Name                     =   "Microsoft Sans Serif"
               CharSet                  =   0
               Weight                   =   700
               Size                     =   9.75
               Underline                =   0
               Italic                   =   0
               StrikeThrough            =   0
            EndProperty
            ForeColor                =   &H80000008
            MaxLength                =   254
            BorderStyle              =   1
            Alignment                =   0
            Locked                   =   -1
            TabIndex                 =   26
            TabStop                  =   0
            Height                   =   300
            Left                     =   1245
            Width                    =   570
            Top                      =   2220
            TabStop                  =  0
            Index                    =   8 
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   0
            Height                   =   240
            Left                     =   1980
            Width                    =   675
            Top                      =   2220
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
            Caption                  =   "Cep....:"
            Index                    =   11 
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
            ForeColor                =   &H80000008
            BorderStyle              =   1
            Alignment                =   0
            TabIndex                 =   7
            TabStop                  =   -1
            Height                   =   300
            Left                     =   2700
            Width                    =   1035
            Top                      =   2220
            DataField                =   "Cep"
            Index                    =   9 
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   0
            Height                   =   240
            Left                     =   3840
            Width                    =   615
            Top                      =   2220
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
            Caption                  =   "Fone:"
            Index                    =   12 
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
            ForeColor                =   &H80000008
            MaxLength                =   13
            BorderStyle              =   1
            Alignment                =   0
            TabIndex                 =   8
            TabStop                  =   -1
            Height                   =   300
            Left                     =   4500
            Width                    =   1335
            Top                      =   2220
            DataField                =   "Fone"
            Index                    =   10 
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   0
            Height                   =   240
            Left                     =   6240
            Width                    =   420
            Top                      =   2220
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
            Caption                  =   "Cel:"
            Index                    =   13 
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
            ForeColor                =   &H80000008
            MaxLength                =   14
            BorderStyle              =   1
            Alignment                =   0
            TabIndex                 =   9
            TabStop                  =   -1
            Height                   =   300
            Left                     =   6720
            Width                    =   1395
            Top                      =   2220
            DataField                =   "Celular"
            Index                    =   11 
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   0
            Height                   =   240
            Left                     =   8280
            Width                    =   1095
            Top                      =   2220
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
            Caption                  =   "Suframa:"
            Index                    =   14 
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
            ForeColor                =   &H80000008
            MaxLength                =   9
            BorderStyle              =   1
            Alignment                =   0
            TabIndex                 =   10
            TabStop                  =   -1
            Height                   =   300
            Left                     =   9255
            Width                    =   1365
            Top                      =   2220
            DataField                =   "Codigo do suframa"
            Index                    =   12 
         End
         Begin VB.Frame Frame
            Height                   =   1065
            Left                     =   7080
            Width                    =   3540
            Top                      =   3240
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851}
               Name                     =   "MS Sans Serif"
               CharSet                  =   0
               Weight                   =   400
               Size                     =   8.25
               Underline                =   0
               Italic                   =   0
               StrikeThrough            =   0
            EndProperty
            ForeColor                =   &H80000012
            Caption                  =   ""
            Index                    =   0 
            Begin VB.Label Label
               Appearance               =   1
               BackColor                =   &H8000000F
               BackStyle                =   1
               BorderStyle              =   0
               AutoSize                 =   0
               Height                   =   240
               Left                     =   120
               Width                    =   705
               Top                      =   240
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
               ForeColor                =   &H80000008
               Caption                  =   "RG...:"
               Index                    =   15 
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
               ForeColor                =   &H80000008
               MaxLength                =   20
               BorderStyle              =   1
               Alignment                =   0
               TabIndex                 =   14
               TabStop                  =   -1
               Height                   =   300
               Left                     =   900
               Width                    =   2400
               Top                      =   240
               DataField                =   "Rg e ie"
               Index                    =   13 
            End
            Begin VB.Label Label
               Appearance               =   1
               BackColor                =   &H8000000F
               BackStyle                =   1
               BorderStyle              =   0
               AutoSize                 =   0
               Height                   =   240
               Left                     =   120
               Width                    =   705
               Top                      =   660
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
               ForeColor                =   &H80000008
               Caption                  =   "CPF.:"
               Index                    =   16 
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
               ForeColor                =   &H80000008
               MaxLength                =   20
               BorderStyle              =   1
               Alignment                =   0
               TabIndex                 =   15
               TabStop                  =   -1
               Height                   =   300
               Left                     =   900
               Width                    =   2400
               Top                      =   660
               DataField                =   "Cpf e cnpj"
               Index                    =   14 
            End
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   0
            Height                   =   240
            Left                     =   720
            Width                    =   480
            Top                      =   3300
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
            Caption                  =   "Obs:"
            Index                    =   17 
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
            ForeColor                =   &H80000008
            BorderStyle              =   1
            Alignment                =   0
            TabIndex                 =   16
            TabStop                  =   0
            Height                   =   1005
            Left                     =   1245
            Width                    =   5775
            Top                      =   3300
            DataField                =   "Observação"
            Index                    =   15 
            MultiLine                =   -1
            ScrollBars               =   2
         End
         Begin NFE.GPainel Painel
            BackColor                =   &H8000000F
            BevelOuter               =   0
            BevelInner               =   0
            BorderWidth              =   1
            BevelWidth               =   1
            BorderStyle              =   0
            Stretch                  =   -1
            Stripes                  =   0
            SaveGridBars             =   0
            Height                   =   630
            Left                     =   8085
            Width                    =   2550
            Top                      =   330
            TabStop                  =  0
            _extentx                 =   4495
            _extenty                 =   1110
            Index                    =   1 
            Begin                VB.Label labopcPainel1
               BorderStyle              =   1
               DataField                =   "Tipo"
               Height                   =   120
               Left                     =   915
               Top                      =   180
               Visible                  =   0
               Width                    =   240
               End
            Begin VB.OptionButton opcPainel1Cp
               Appearance               =   1
               BackColor                =   &H8000000F
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851}
                  Name                     =   "Microsoft Sans Serif"
                  CharSet                  =   0
                  Weight                   =   700
                  Size                     =   9
                  Underline                =   0
                  Italic                   =   0
                  StrikeThrough            =   0
               EndProperty
               ForeColor                =   &H80000008
               Alignment                =   2
               TabIndex                 =   28
               TabStop                  =   0
               Height                   =   255
               Left                     =   135
               Width                    =   1020
               Top                      =   255
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851}
                  Name                     =   "Microsoft Sans Serif"
                  CharSet                  =   0
                  Weight                   =   700
                  Size                     =   9
                  Underline                =   0
                  Italic                   =   0
                  StrikeThrough            =   0
               EndProperty
               ForeColor                =   &H80000008
               Alignment                =   0
               Caption                  =   "FISICA"
               Index                    =   0 
            End
            Begin VB.OptionButton opcPainel1Cp
               Appearance               =   1
               BackColor                =   &H8000000F
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851}
                  Name                     =   "Microsoft Sans Serif"
                  CharSet                  =   0
                  Weight                   =   700
                  Size                     =   9
                  Underline                =   0
                  Italic                   =   0
                  StrikeThrough            =   0
               EndProperty
               ForeColor                =   &H80000008
               Alignment                =   2
               TabIndex                 =   29
               TabStop                  =   0
               Height                   =   255
               Left                     =   1215
               Width                    =   1335
               Top                      =   255
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851}
                  Name                     =   "Microsoft Sans Serif"
                  CharSet                  =   0
                  Weight                   =   700
                  Size                     =   9
                  Underline                =   0
                  Italic                   =   0
                  StrikeThrough            =   0
               EndProperty
               ForeColor                =   &H80000008
               Alignment                =   0
               Caption                  =   "JURIDICA"
               Index                    =   1 
            End
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   0
            Height                   =   240
            Left                     =   600
            Width                    =   540
            Top                      =   2760
            Alignment                =   1
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
            Caption                  =   "Email:"
            Index                    =   18 
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
            ForeColor                =   &H80000008
            MaxLength                =   255
            BorderStyle              =   1
            Alignment                =   0
            TabIndex                 =   11
            TabStop                  =   -1
            Height                   =   300
            Left                     =   1245
            Width                    =   4590
            Top                      =   2760
            DataField                =   "Email"
            Index                    =   16 
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   -1
            Height                   =   240
            Left                     =   6000
            Width                    =   600
            Top                      =   2760
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
            Caption                  =   "ANTT:"
            Index                    =   19 
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
            ForeColor                =   &H80000008
            MaxLength                =   20
            BorderStyle              =   1
            Alignment                =   0
            TabIndex                 =   12
            TabStop                  =   -1
            Height                   =   300
            Left                     =   6720
            Width                    =   1395
            Top                      =   2760
            DataField                =   "Codigo da antt"
            Index                    =   17 
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   -1
            Height                   =   240
            Left                     =   8280
            Width                    =   810
            Top                      =   2760
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
            Caption                  =   "Dt. Nasc:"
            Index                    =   20 
         End
         Begin VB.Label labFdo18
            Appearance               =  1
            BorderStyle              =  1
            BackColor                =  &H80000005
            Left                     =   9255
            Top                      =   2760
            Width                    =   1365
            Height                   =   300
         End
         Begin VB.CommandButton bottxtCampo18
            Style                    =   1
            TabStop                  =   0
            Index                    =   0
            Left                     =   10335
            Top                      =   2790
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
            ForeColor                =   &H80000008
            BorderStyle              =   0
            Alignment                =   0
            TabIndex                 =   13
            TabStop                  =   -1
            Height                   =   240
            Left                     =   9285
            Width                    =   1035
            Top                      =   2790
            DataField                =   "Data de Nascimento"
            Index                    =   18 
         End
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
         ForeColor                =   &H80
         Alignment                =   0
         TabIndex                 =   24
         TabStop                  =   0
         Height                   =   255
         Left                     =   5220
         Width                    =   1635
         Top                      =   1200
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851}
            Name                     =   "Microsoft Sans Serif"
            CharSet                  =   0
            Weight                   =   700
            Size                     =   9.75
            Underline                =   0
            Italic                   =   0
            StrikeThrough            =   0
         EndProperty
         ForeColor                =   &H80
         Alignment                =   0
         Caption                  =   "Fornecedor"
         Index                    =   5 
         DataField                =   "Fornecedor"
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   -1
         Height                   =   240
         Left                     =   1920
         Width                    =   1350
         Top                      =   720
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
         ForeColor                =   &H80000008
         Caption                  =   "Dt. Cadastro:"
         Index                    =   21 
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
         ForeColor                =   &H80000008
         BorderStyle              =   1
         Alignment                =   0
         TabIndex                 =   27
         TabStop                  =   0
         Height                   =   300
         Left                     =   9060
         Width                    =   1140
         Top                      =   7380
         DataField                =   "Data do cadastro"
         Index                    =   19 
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   -1
         Height                   =   240
         Left                     =   10980
         Width                    =   45
         Top                      =   7305
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
         Index                    =   22 
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
Attribute VB_name = "frmGeral"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
'* Sistema...: Emissor de Nota Fiscal Eletronica
'* Empresa...: Ygor Eduardo Dellalio
'* Módulo....: Geral
'* Função....: Geral
'* CopyRight.: (C)2016 Ygor Eduardo Dellalio
'* Criação...: GAS-2007 - Gerador Automático de Sistemas
'* Data......: 13/07/2016 13:38:08
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
Dim txtCampo(19) As New FormataCampos             'classe dos campos tipo texto do módulo  
Dim chkCampo(5) As New FormataCampos              'classe dos campos tipo lógico do módulo
Dim opcPainel1(1) As New FormataCampos
Dim Cliente As Boolean, Transportadora As Boolean, Consumidor_final As Boolean
Dim Isento As Boolean, Inativo As Boolean, Sequencia_do_geral As Long
Dim Razao_social As String, Nome_fantasia As String, Tipo As Integer
Dim Endereco As String, Complemento As String, Nro As String
Dim Bairro As String, Sequencia_do_municipio As Long, Cep As String
Dim Fone As String, Celular As String, Codigo_do_suframa As String
Dim Cpf_e_cnpj As String, Rg_e_ie As String, Observacao As String
Dim Data_do_cadastro As Variant, Fornecedor As Boolean, Email As String
Dim Codigo_da_antt As String, Data_de_Nascimento As Variant, Ajuste As String
Public lblRGIE As Object, txtRGIE As Object, lblCPFCNPJ As Object
Public txtCPFCNPJ As Object, lblAjuste As Object

Private MunAux As GRecordset
Public Tipo2 As Byte

Private Sub Tabs_Click(Index As Integer, PreviousTab As Integer)
   MudaTamCampos Me
End Sub

Private Sub RepositionGeral()   
   TbAuxiliar "Municipios", "[Sequencia do municipio] = " & Sequencia_do_Municipio, MunAux
   Tipo2 = Tipo
   MudaMascara      
End Sub


'ROTINA PARA MUDAR A MASCARA DOS CAMPOS CPF/CNPJ E RG/IE
'COMO É UM UNICO CAMPO PARA DOIS TIPOS DIFERENTE PRECISAMOS MUDAR A MASCARA DELES
'DE ACORDO COM O Tipo DA PESSOA FISICA OU JURIDICA
Private Sub MudaMascara()
   On Error Resume Next
   
   If Tipo = 0 Then  'CPF e RG
      txtCPFCNPJ.Mask = "999.999.999-99"      'mascara
      lblCPFCNPJ.Caption = "CPF.:"            'titulos
      txtRGIE.Mask = "@x"
      lblRGIE.Caption = "RG..:"
   Else                    'CNPJ e IE
      txtCPFCNPJ.Mask = "99.999.999/9999-99"  'mascara
      lblCPFCNPJ.Caption = "CNPJ:"            'titulos
      Select Case MunAux!UF
         Case "MG" '999.999.999/9999
            txtRGIE.Mask = "999.999.999/9999"
         Case "ES", "GO", "MA", "PA" '999.999.99-9
            txtRGIE.Mask = "999.999.99-9"
         Case "RJ" '99.999.99-9
            txtRGIE.Mask = "99.999.99-9" 
         Case "SC" '999.999.999
            txtRGIE.Mask = "999.999.999"
         Case "DF" '99.999999.999-99
            txtRGIE.Mask = "99.999999.999-99"
         Case "PR" '99.999.999-99
            txtRGIE.Mask = "99.999.999-99"
         Case "PE" '9.999.999-99
            txtRGIE.Mask = "9.999.999-99"
         Case "RN", "AM", "PB" '99.999.999-9
            txtRGIE.Mask = "99.999.999-9"
         Case "RS" '999/999999-9
            txtRGIE.Mask = "999/999999-9"
         Case "RO" '9999999999999-9
            txtRGIE.Mask = "9999999999999-9"
         Case "SP" '999.999.999.999
            'If Not e_Produtor_Paulista Then
               txtRGIE.Mask = "999.999.999.999"
            'Else '(Produtor) 99999999.9/999
            '   txtRGIE.Mask = "99999999.9/999"
            'End If
         Case "BA" '#99.999.999
            txtRGIE.Mask = "#99.999.999"
         Case "CE", "AL", "AP", "PI", "SE", "RR" '99999999-9
            txtRGIE.Mask = "99999999-9"
         Case "AC" '99.999.999/999-99
            txtRGIE.Mask = "99.999.999/999-99"
         Case "MT" '9999999999-9
            txtRGIE.Mask = "9999999999-9"
         Case "MS" '99.999.999-9
            txtRGIE.Mask = "99.999.999-9"   
         Case "TO" '99.99.999999-9
            txtRGIE.Mask = "99.99.999999-9"
      End Select      
      lblRGIE.Caption = "IE..:"       
      If Isento Then
         lblRGIE.Enabled = False
      Else
         lblRGIE.Enabled = True
      End If
   End If   
   If vgSituacao <> ACAO_INCLUINDO And vgSituacao <> ACAO_EDITANDO Then Executar PEGA_DO_ARQUIVO   'Se nw estiver editando ou incluindo vamos pegar recuperar as informações do banco
                                                                                                   'Senão tiver essa linha quando o usuario navegar pelos registro ele nw aplica a mascara
                                                                                                   'como deveria      
End Sub

'ROTINA MANUAL
'Proposito: arrumar o erro que tinha quando alterava um registro carregado por outro formulario
'evento - quando uma opção for selecionada
 Private Sub opcPainel1Cp_Click(Index As Integer)
    If vgPriVez Then Exit Sub
    If opcPainel1(Index).Locked Then
       opcPainel1(Val(labopcPainel1.Caption)).Value = True
    Else
       If Val(labopcPainel1.Caption) <> opcPainel1(Index).BookMark Then 'Manual
          labopcPainel1.Caption = Str$(opcPainel1(Index).BookMark)
          LigaFocos Me
          InicializaApelidos COM_TEXTBOX
          ExecutaVisivel
          ExecutaPreValidacao
          MostraFormulas
          MudaMascara
          opcPainel1(Index).Change
          Select Case Index
            Case 0
               Tipo2 = 0
            Case 1
               Tipo2 = 1
          End Select
      End If 'Manual
   End If
End Sub

'Usado quando abre o Formulario pela consulta
Public Sub SuperTipo()
   On Error Resume Next
   Tipo2 = Tipo
   RepositionGeral
End Sub

'Deixar Inativo o Botão de Excluir Caso exista Nota Fiscal com o Geral
'Tem integridade no db mas a msg do sql é feia então fiz assim
Private Function TemNota() As Boolean
   Dim Nota As New GRecordset, Transp As New GRecordset
   
   On Error Resume Next
   
   Set Nota  = vgdb.OpenRecordset("SELECT * FROM [Nota Fiscal] WHERE [Sequencia do Geral] = " & Sequencia_do_Geral)
   Set Transp = vgdb.OpenRecordset("SELECT * FROM [Nota Fiscal] WHERE [Sequencia da Transportadora] = " & Sequencia_do_Geral)
   
   If Nota.RecordCount > 0 Or Transp.RecordCount > 0  Then
      TemNota = True
   Else
      TemNota = False
   End If

End Function


Private Function PegaSequencial() As Long
Dim Tb As New GRecordSet
 
 If VgSituacao = ACAO_INCLUINDO Then
    Set Tb = VgDb.OpenRecordSet("SELECT MAX([Sequencia do geral]) Seq From [Geral]")
    PegaSequencial = Tb!Seq + 1
 End If
 
End Function 
 
Private Sub VerificaCNPJ()
 Dim Tb As New GRecordSet
 
 Set Tb = VgDb.OpenRecordSet("Select * From Geral Where [CPF e CNPJ] = '" & Cpf_e_cnpj & "'")
  
  If Tb.RecordCount > 0 And Cpf_e_cnpj <> "" And VgSituacao <> ACAO_NAVEGANDO Then
   If MsgBox("Ja Existe um Cadastro com este (CNPJ / CPF) Cadastro de " & " " & Tb![Razão Social] & " Sequencia do Geral" & " --> " & " 00" & Tb![Sequencia Do Geral] & "   Deseja Alterar os Dados?", vbQuestion + vbYesNo, vaTitulo) = vbNo Then 
      MDINFE.CancelaAlteracoes
   Else
      MDINFE.CancelaAlteracoes
      PosicionaRegistro frmGeral, "Sequencia do geral", Tb![Sequencia Do Geral]
   End If
  End If 
   
End Sub

Public Sub LigaDesligaBotoes
   Botao( 0 ).Enabled =    Botao( 0 ).Enabled And Permitido("Municipios", ACAO_NAVEGANDO)
End Sub

Public Property Get txtCampoTab(Index As Integer) As FormataCampos   
   Set txtCampoTab = txtCampo(Index)
End Sub

'inicializa variaveis (apelidos) coms os campos correspondentes
Private Sub InicializaApelidos(vgComOQue As Integer)
   On Error Resume Next                           'prepara para possíveis erros
   If (vgTb.RecordCount > 0 And vgTb.Eof = False And vgTb.Bof = False) Or vgComOQue = COM_TEXTBOX Then
      If vgComOQue = COM_TEXTBOX Then
         Cliente = chkCampo(0).Value
         Transportadora = chkCampo(1).Value
         Consumidor_final = chkCampo(2).Value
         Isento = chkCampo(3).Value
         Inativo = chkCampo(4).Value
         Sequencia_do_geral = txtCampo(0).Value
         Razao_social = txtCampo(1).Value
         Nome_fantasia = txtCampo(2).Value
         Tipo = Val(labopcPainel1.Caption)
         Endereco = txtCampo(3).Value
         Complemento = txtCampo(4).Value
         Nro = txtCampo(5).Value
         Bairro = txtCampo(6).Value
         Sequencia_do_municipio = txtCampo(7).Value
         Cep = txtCampo(9).Value
         Fone = txtCampo(10).Value
         Celular = txtCampo(11).Value
         Codigo_do_suframa = txtCampo(12).Value
         Cpf_e_cnpj = txtCampo(14).Value
         Rg_e_ie = txtCampo(13).Value
         Observacao = txtCampo(15).Value
         Data_do_cadastro = txtCampo(19).Value
         Fornecedor = chkCampo(5).Value
         Email = txtCampo(16).Value
         Codigo_da_antt = txtCampo(17).Value
         Data_de_Nascimento = txtCampo(18).Value
      Else
         Cliente = IIf(IsNull(vgTb!Cliente), 0, vgTb!Cliente)
         Transportadora = IIf(IsNull(vgTb!Transportadora), 0, vgTb!Transportadora)
         Consumidor_final = IIf(IsNull(vgTb![Consumidor final]), 0, vgTb![Consumidor final])
         Isento = IIf(IsNull(vgTb!Isento), 0, vgTb!Isento)
         Inativo = IIf(IsNull(vgTb!Inativo), 0, vgTb!Inativo)
         Sequencia_do_geral = IIf(IsNull(vgTb![Sequencia do geral]), 0, vgTb![Sequencia do geral])
         Razao_social = IIf(IsNull(vgTb![Razão social]), "", vgTb![Razão social])
         Nome_fantasia = IIf(IsNull(vgTb![Nome fantasia]), "", vgTb![Nome fantasia])
         Tipo = IIf(IsNull(vgTb!Tipo), 0, vgTb!Tipo)
         Endereco = IIf(IsNull(vgTb!Endereço), "", vgTb!Endereço)
         Complemento = IIf(IsNull(vgTb!Complemento), "", vgTb!Complemento)
         Nro = IIf(IsNull(vgTb!Nro), "", vgTb!Nro)
         Bairro = IIf(IsNull(vgTb!Bairro), "", vgTb!Bairro)
         Sequencia_do_municipio = IIf(IsNull(vgTb![Sequencia do municipio]), 0, vgTb![Sequencia do municipio])
         Cep = IIf(IsNull(vgTb!Cep), "", vgTb!Cep)
         Fone = IIf(IsNull(vgTb!Fone), "", vgTb!Fone)
         Celular = IIf(IsNull(vgTb!Celular), "", vgTb!Celular)
         Codigo_do_suframa = IIf(IsNull(vgTb![Codigo do suframa]), "", vgTb![Codigo do suframa])
         Cpf_e_cnpj = IIf(IsNull(vgTb![Cpf e cnpj]), "", vgTb![Cpf e cnpj])
         Rg_e_ie = IIf(IsNull(vgTb![Rg e ie]), "", vgTb![Rg e ie])
         Observacao = IIf(IsNull(vgTb!Observação), "", vgTb!Observação)
         Data_do_cadastro = vgTb![Data do cadastro]
         Fornecedor = IIf(IsNull(vgTb!Fornecedor), 0, vgTb!Fornecedor)
         Email = IIf(IsNull(vgTb!Email), "", vgTb!Email)
         Codigo_da_antt = IIf(IsNull(vgTb![Codigo da antt]), "", vgTb![Codigo da antt])
         Data_de_Nascimento = vgTb![Data de Nascimento]
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
      i = (Not TemNota()) and Permitido(vgIdentTab, ACAO_EXCLUINDO)
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
   Dim i As Integer, vgRsError As GRecordSet, vgMsg As String, vgOk As Integer, vgPV As Boolean, vgNVez As Integer, vgInd As Integer
   On Error GoTo DeuErro                          'fica na espera de um erro...
   vgMsg$ = ""                                    'retorna uma msg dizendo o motivo
   vgOk = True                                    'se a validação esta OK
   vgPV = vgPriVez
   vgColumn = -1
   vgNVez = 0                                     'porque não fez o processo/validacoes
   If vgOq = VALIDACOES Then
      InicializaApelidos COM_TEXTBOX
      vgOk = (Not Vazio(Razao_social))
      vgMsg$ = "Razão social não pode ser vazio!"
      If Not vgOk Then vgColumn = 2
      If vgOk Then
         vgOk = (Not Vazio(Endereco))
         vgMsg$ = "Endereço não pode ser vazio!"
         If Not vgOk Then vgColumn = 4
      End If
      If vgOk Then
         vgOk = (Not Vazio(Bairro))
         vgMsg$ = "Bairro não pode ser vazio!"
         If Not vgOk Then vgColumn = 7
      End If
      If vgOk Then
         vgOk = (Sequencia_do_municipio > 0)
         vgMsg$ = "Municipio inválido!"
         If Not vgOk Then vgColumn = 8
      End If
      If vgOk Then
         If Tipo = 0 Then
            vgOk = (IsDate(Data_de_Nascimento) Or Vazio(Data_de_Nascimento))
            vgMsg$ = "Data de Nascimento não pode ser vazio!"
            If Not vgOk Then vgColumn = 19
         End If
      End If
      If vgOk Then
         If Isento = 0 Then
            If (Tipo2 = 1) And Isento = 0 Then
               vgOk = (ValidaIE(MunAux!UF, Rg_e_ie, False))
               vgMsg$ = "" & MsgValIE & ""
               If Not vgOk Then vgColumn = 14
            End If
         End If
      End If
      If vgOk Then
         If Isento = 0 Then
            If Tipo2 = 0 Then
               vgOk = (Not Vazio(Rg_e_ie))
               vgMsg$ = "RG não pode ser vazio!"
               If Not vgOk Then vgColumn = 14
            End If
         End If
      End If
      If vgOk Then
         If Tipo = 0 Then
            vgOk = ((VDV2(Cpf_e_cnpj)) And Not Vazio(Cpf_e_cnpj))
            vgMsg$ = "CPF Invalido!"
            If Not vgOk Then vgColumn = 15
         End If
      End If
      If vgOk Then
         If Tipo = 1 Then
            vgOk = ((VCGC(Cpf_e_cnpj)) And Not Vazio(Cpf_e_cnpj))
            vgMsg$ = "CNPJ Invalido!"
            If Not vgOk Then vgColumn = 15
         End If
      End If
      If vgOk Then
         vgOk = (IIf(Cliente = 0 AND Transportadora = 0 AND Fornecedor = 0 , False, 1 = 1))
         vgMsg$ = "Você deve escolher um tipo de Geral (Cliente, Fornecedor ou Trasnportadora)"
         If Not vgOk Then vgColumn = 1
      End If
      If vgOk Then
         vgOk = (IsDate(Data_do_cadastro) Or Vazio(Data_do_cadastro))
         vgMsg$ = "Data do cadastro não pode ser vazio!"
         If Not vgOk Then vgColumn = 20
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
         chkCampo(1).Value = False
         chkCampo(2).Value = 1
         chkCampo(3).Value = False
         chkCampo(4).Value = False
         opcPainel1(0).Value = True
         opcPainel1(0).CtPri.TabStop = False
         chkCampo(5).Value = False
         txtCampo(19).Value = Date
         On Error Goto DeuErro
         InicializaApelidos COM_TEXTBOX
         PoeRelEFiltroCbo 7
      End If
   ElseIf vgOq = PEGA_DO_ARQUIVO Then
      If vgTb.RecordCount > 0 And vgTb.EOF = False And vgTb.BOF = False Then
         vgPriVez = True
         vgTb.Resync 1             'adAffectCurrent
         InicializaApelidos COM_REGISTRO
         PoeRelEFiltroCbo 7
         For i = 0 To UBound(txtCampo)
            If Len(txtCampo(i).DataField) > 0 Then
               txtCampo(i).SetOriginalValue = True
               txtCampo(i).Value = vgTb.Fields(txtCampo(i).DataField).Value
            End If
         Next
         chkCampo(0).Value = Cliente
         chkCampo(1).Value = Transportadora
         chkCampo(2).Value = Consumidor_final
         chkCampo(3).Value = Isento
         chkCampo(4).Value = Inativo
         opcPainel1(Tipo).Value = True
         opcPainel1(Tipo).CtPri.TabStop = False
         chkCampo(5).Value = Fornecedor
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
      vgTb!Cliente = Cliente
      vgTb!Transportadora = Transportadora
      vgTb![Consumidor final] = Consumidor_final
      vgTb!Isento = Isento
      vgTb!Inativo = Inativo
      vgTb!Tipo = Tipo
      vgTb!Fornecedor = Fornecedor
   ElseIf vgOq = INI_APELIDOS Then
      InicializaApelidos COM_REGISTRO
      ExecutaVisivel
      ExecutaPreValidacao
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

   
'executa a pré-validação da coluna do grid do modo grade do formulário
Private Sub grdBrowse_GetColumnLocked(ByVal vgRow As Long, ByVal vgCol As Long, vgColumns() As Variant, ByRef FormField As FormataCampos, ByRef vgLocked As Boolean)
   ExecutaPreValidacao                            'checa as pré-validações
   vgLocked = Not FormField.Enabled               'aplica as definições de pré-validação que são aplicadas ao campo da tela
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
   If vgSituacao = ACAO_NAVEGANDO Then
      AnalisaCondicoes 
   End If
   RepositionGeral  
   ExecutaVisivel
   ExecutaPreValidacao
   MostraFormulas
   vgTemAlteracaoGrids = Not LockGrids
   If vgEmBrowse And vgSituacao = ACAO_NAVEGANDO And vgFrmImpCons Is Nothing Then grdBrowse.Refresh
DeuErro:
   
End Sub

'mostra fórmulas na janela
Private Sub MostraFormulas()
   On Error Resume Next                           'previne erros...
   txtCampo(8).Value = MunAux!UF
   If Err Then Err = 0: txtCampo(8).Text = ""
   Label(21).Caption = "Dt. Cadastro: " & Data_do_Cadastro
   If Err Then Err = 0: Label(21).Caption = ""
   If Err Then Err.Clear                          'se houve erro, limpa...
End Sub

'executa a pré-validação dos campos
Private Sub ExecutaPreValidacao()
   Dim Ok As Boolean, vgPV As Integer
   On Error Resume Next                           'prepara para possiveis erros
   vgPV = vgPriVez
   vgPriVez = True
   Ok = (Tipo = 1)
   chkCampo(3).Enabled = (Ok And chkCampo(3).Editable)
   Ok = (MunAux!UF = "AM")
   txtCampo(12).Enabled = (Ok And txtCampo(12).Editable)
   Ok = (Isento = 0)
   txtCampo(13).Enabled = (Ok And txtCampo(13).Editable)
   Ok = (Transportadora = True)
   txtCampo(17).Enabled = (Ok And txtCampo(17).Editable)
   Ok = (Tipo = 0)
   txtCampo(18).Enabled = (Ok And txtCampo(18).Editable)
   If Err Then Err.Clear                          'se houve erro, limpa...
   vgPriVez = vgPV
End Sub

'coloca os campos visíveis segundo a condição
Private Sub ExecutaVisivel()
   On Error Resume Next                           'prepara para possiveis erros
   Label(21).Visible = (Not Vazio(Data_do_Cadastro))
   txtCampo(19).Visible = (vgPWUsuario = "ADMIN")
   Label(22).Visible = (False)
   If Err Then Err.Clear                          'se houve erro, limpa...
End Sub

'evento - quando o conteúdo do campo for alterado
Private Sub txtCp_Change(Index As Integer)
   If vgPriVez Or txtCampo(Index).PriVez Then Exit Sub
   If Len(txtCampo(Index).DataField) > 0 Then LigaFocos Me
   InicializaApelidos COM_TEXTBOX                         'inicializa apelidos com o que esta sendo digitado
   txtCampo(Index).Change
   If Index = 7 Then
      ExecutaVisivel
      ExecutaPreValidacao
      MostraFormulas
   End If
   Select Case Index
      Case 7
         TbAuxiliar "Municipios", "[Sequencia do municipio] = " & Sequencia_do_Municipio, MunAux: MudaMascara
   End Select
End Sub

'evento - quando o campo receber o foco
Private Sub txtCp_GotFocus(Index As Integer)
   If vgSituacao <> ACAO_NAVEGANDO Or (Len(txtCampo(Index).PesqSQLExpression) > 0) Then
      On Error Resume Next
      Select Case Index
         Case 7
            PoeRelEFiltroCbo 7
         Case 9
            If Len(txtCp(9).Text) = 0 Then
               txtCampo(9).Value = MunAux!Cep
               txtCp_Change Index
               InicializaApelidos COM_TEXTBOX
               ExecutaVisivel
               ExecutaPreValidacao
               MostraFormulas
            End If
         Case 19
            If Len(txtCp(19).Text) = 0 Then
               txtCampo(19).Value = Date
               txtCp_Change Index
               InicializaApelidos COM_TEXTBOX
               ExecutaVisivel
               ExecutaPreValidacao
               MostraFormulas
            End If
      End Select
   End If
   txtCampo(Index).GotFocus
End Sub

'evento - quando qq tecla for digitada no campo
Private Sub txtCp_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn And vgSituacao <> ACAO_NAVEGANDO Then  'se tela esta em edição e digitou ENTER
      ExecutaVisivel                                               'torna camos visiveis
      ExecutaPreValidacao                                          'habilita/desabilita campos
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
      MostraFormulas                              'mostra formulas na janela
      ExecutaVisivel                              'torna camos visiveis
      ExecutaPreValidacao                         'habilita/desabilita campos
   End If
   Select Case Index
      Case 14
         VerificaCNPJ  
   End Select
End Sub


'evento - quando o check for marcado/desmarcado
Private Sub chkCp_Click(Index As Integer)
   If vgPriVez Then Exit Sub
   If chkCampo(Index).Locked Then
      If Index = 0 Then
         chkCampo(0).Value = Cliente
      ElseIf Index = 1 Then
         chkCampo(1).Value = Transportadora

      ElseIf Index = 2 Then
         chkCampo(2).Value = Consumidor_final

      ElseIf Index = 3 Then
         chkCampo(3).Value = Isento

      ElseIf Index = 4 Then
         chkCampo(4).Value = Inativo

      ElseIf Index = 5 Then
         chkCampo(5).Value = Fornecedor
      End If
   Else
   If Len(chkCampo(Index).DataField) > 0 Then LigaFocos Me
      InicializaApelidos COM_TEXTBOX
      MostraFormulas                              'mostra formulas na janela
      ExecutaVisivel                              'torna camos visiveis
      ExecutaPreValidacao                         'habilita/desabilita campos
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

'evento - quando qq tecla for digitada no campo
Private Sub opcPainel1Cp_KeyPress(Index As Integer, KeyAscii As Integer)
   opcPainel1(Index).KeyPress KeyAscii
End Sub

'evento - quando qq tecla for digitada no campo
Private Sub opcPainel1Cp_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
   opcPainel1(Index).KeyDown KeyCode, Shift
End Sub

'evento - quando o campo receber o foco
Private Sub opcPainel1Cp_GotFocus(Index As Integer)
   opcPainel1(Index).GotFocus
   If vgSituacao <> ACAO_NAVEGANDO Or (Len(txtCampo(Index).PesqSQLExpression) > 0) Then
      On Error Resume Next
      Select Case Index
         Case 7
            PoeRelEFiltroCbo 7
      End Select
   End If
End Sub

'evento - quando o campo perder o foco
Private Sub opcPainel1Cp_LostFocus(Index As Integer)
   opcPainel1(Index).LostFocus
End Sub

'evento - quando o formulário receber o foco
Private Sub Form_Activate()
   If vgPriVez = False Then
      Screen.MousePointer = vbHourglass           'mouse = ampulheta
   Else
      vgPriVez = False
   End If
   PosicionaRegistro frmGeral, "Sequencia do geral", seqRegistro
   AtivaForm Me
   
   'se tiver imprimindo registros em grade, fecha form de selecao/preview
   If FormEstaAberto("frmEnviaEmail") Then
      If Not frmEnviaEmail.Visible Then
         UnLoad vgFrmImpCons
         Set vgFrmImpCons = Nothing
         UnLoad frmEnviaEmail
      End If
   End If
   Screen.MousePointer = vbDefault
End Sub

'evento - inicialização do formulário
Private Sub Form_Load()
   On Error GoTo DeuErro
   Screen.MousePointer = vbHourglass
   Caption = LoadGasString(14550)
   vgFormID = 620
   vgIdentTab = "Geral"
   vgFiltroEmUso = -1
   vgIndDefault = "Sequencia do geral"
   vgPriVez = True
   vgTipo = TP_TABELA
   vgTemInclusao = True
   vgTemExclusao = True
   vgTemAlteracao = True
   vgTemProcura = True
   vgTemFiltro = True
   vgTemBrowse = True
   grdBrowse.Tag = 1
   vgTemCondicoesEsp = True
   vgCaracteristica = F_DADOS
   vgUltimoTabIndex = 15
   vgSituacao = ACAO_NAVEGANDO
   Set mmCampo(0).Picture = LoadPicture(LoadGasPicture(6055))
   Set Botao(0).Picture = LoadPicture(LoadGasPicture(6056))
   Set lblRGIE = Label(15)
   Set txtRGIE = txtCampo(13)
   Set lblCPFCNPJ = Label(16)
   Set txtCPFCNPJ = txtCampo(14)
   Set lblAjuste = Label(22)
   Set vgTb = New GRecordSet
   If Len(vgFiltroInicial$) > 0 Then
      vgFiltroInicial$ = vgFiltroInicial$ + " And "
   End If
   vgFiltroInicial$ = vgFiltroInicial$ + "([Sequencia do geral] > " & 0 & ") AND [Razão social] <> 'O MESMO'"
   vgFiltroOriginal$ = vgFiltroInicial$
   DefineControles
   vgTooltips.Create
   Label(0).Caption = LoadGasString(14555)
   Label(1).Caption = LoadGasString(14556)
   vgTooltips.AddTool txtCampo(0).CtPri, 0, LoadGasString(14557)
   vgTooltips.AddTool chkCampo(0).CtPri, 0, LoadGasString(14558)
   chkCampo(0).Caption = LoadGasString(14559)
   vgTooltips.AddTool chkCampo(1).CtPri, 0, LoadGasString(14560)
   chkCampo(1).Caption = LoadGasString(14561)
   vgTooltips.AddTool chkCampo(2).CtPri, 0, LoadGasString(14562)
   chkCampo(2).Caption = LoadGasString(14563)
   vgTooltips.AddTool chkCampo(3).CtPri, 0, LoadGasString(14564)
   chkCampo(3).Caption = LoadGasString(14565)
   vgTooltips.AddTool chkCampo(4).CtPri, 0, LoadGasString(14566)
   chkCampo(4).Caption = LoadGasString(14567)
   Label(2).Caption = LoadGasString(14568)
   vgTooltips.AddTool txtCampo(1).CtPri, 0, LoadGasString(14569)
   Tabs(0).TabCaption(0) = LoadGasString(14570)
   Label(3).Caption = LoadGasString(14571)
   vgTooltips.AddTool txtCampo(2).CtPri, 0, LoadGasString(14572)
   Label(4).Caption = LoadGasString(14573)
   Label(5).Caption = LoadGasString(14574)
   vgTooltips.AddTool txtCampo(3).CtPri, 0, LoadGasString(14575)
   Label(6).Caption = LoadGasString(14576)
   vgTooltips.AddTool txtCampo(4).CtPri, 0, LoadGasString(14577)
   Label(7).Caption = LoadGasString(14578)
   vgTooltips.AddTool txtCampo(5).CtPri, 0, LoadGasString(14579)
   Label(8).Caption = LoadGasString(14580)
   vgTooltips.AddTool txtCampo(6).CtPri, 0, LoadGasString(14581)
   Label(9).Caption = LoadGasString(14582)
   vgTooltips.AddTool txtCampo(7).CtPri, 0, LoadGasString(14583)
   Label(10).Caption = LoadGasString(14584)
   Label(11).Caption = LoadGasString(14585)
   vgTooltips.AddTool txtCampo(9).CtPri, 0, LoadGasString(14586)
   Label(12).Caption = LoadGasString(14587)
   vgTooltips.AddTool txtCampo(10).CtPri, 0, LoadGasString(14588)
   Label(13).Caption = LoadGasString(14589)
   vgTooltips.AddTool txtCampo(11).CtPri, 0, LoadGasString(14590)
   Label(14).Caption = LoadGasString(14591)
   vgTooltips.AddTool txtCampo(12).CtPri, 0, LoadGasString(14592)
   Label(15).Caption = LoadGasString(14593)
   vgTooltips.AddTool txtCampo(13).CtPri, 0, LoadGasString(14594)
   Label(16).Caption = LoadGasString(14595)
   vgTooltips.AddTool txtCampo(14).CtPri, 0, LoadGasString(14596)
   Label(17).Caption = LoadGasString(14597)
   vgTooltips.AddTool txtCampo(15).CtPri, 0, LoadGasString(14598)
   vgTooltips.AddTool opcPainel1(0).CtPri, 0, LoadGasString(14599)
   opcPainel1(0).Caption = LoadGasString(14600)
   vgTooltips.AddTool opcPainel1(1).CtPri, 0, LoadGasString(14601)
   opcPainel1(1).Caption = LoadGasString(14602)
   Label(18).Caption = LoadGasString(14603)
   vgTooltips.AddTool txtCampo(16).CtPri, 0, LoadGasString(14604)
   Label(19).Caption = LoadGasString(14605)
   vgTooltips.AddTool txtCampo(17).CtPri, 0, LoadGasString(14606)
   Label(20).Caption = LoadGasString(14607)
   vgTooltips.AddTool txtCampo(18).CtPri, 0, LoadGasString(14608)
   vgTooltips.AddTool chkCampo(5).CtPri, 0, LoadGasString(14609)
   chkCampo(5).Caption = LoadGasString(14610)
   vgTooltips.AddTool txtCampo(19).CtPri, 0, LoadGasString(14611)
   Label(22).Caption = LoadGasString(14612)
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

   Set txtCampo(1).CtPri = txtCp(1)
   txtCampo(1).DataType = 0
   txtCampo(1).Mask = "@x"
   txtCampo(1).BoundColumn = ""
   txtCampo(1).ListFields = ""
   txtCampo(1).OrderFields = ""
   txtCampo(1).Relation = ""
   txtCampo(1).Source = ""
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
   txtCampo(3).DataType = 0
   txtCampo(3).Mask = "@x"
   txtCampo(3).BoundColumn = ""
   txtCampo(3).ListFields = ""
   txtCampo(3).OrderFields = ""
   txtCampo(3).Relation = ""
   txtCampo(3).Source = ""
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(3).DataField), txtCampo(3)

   Set txtCampo(4).CtPri = txtCp(4)
   txtCampo(4).DataType = 0
   txtCampo(4).Mask = "@x"
   txtCampo(4).BoundColumn = ""
   txtCampo(4).ListFields = ""
   txtCampo(4).OrderFields = ""
   txtCampo(4).Relation = ""
   txtCampo(4).Source = ""
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(4).DataField), txtCampo(4)

   Set txtCampo(5).CtPri = txtCp(5)
   txtCampo(5).DataType = 0
   txtCampo(5).Mask = "@x"
   txtCampo(5).BoundColumn = ""
   txtCampo(5).ListFields = ""
   txtCampo(5).OrderFields = ""
   txtCampo(5).Relation = ""
   txtCampo(5).Source = ""
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(5).DataField), txtCampo(5)

   Set txtCampo(6).CtPri = txtCp(6)
   txtCampo(6).DataType = 0
   txtCampo(6).Mask = "@x"
   txtCampo(6).BoundColumn = ""
   txtCampo(6).ListFields = ""
   txtCampo(6).OrderFields = ""
   txtCampo(6).Relation = ""
   txtCampo(6).Source = ""
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(6).DataField), txtCampo(6)

   Set txtCampo(7).CtPri = txtCp(7)
   Set txtCampo(7).CtFdo = labFdo7
   Set txtCampo(7).CtBot(BOT_LISTA) = bottxtCampo7(BOT_LISTA)
   Set txtCampo(7).CtBot(BOT_COMBO) = bottxtCampo7(BOT_COMBO)
   bottxtCampo7(BOT_LISTA).Caption = "P"
   Set bottxtCampo7(BOT_COMBO).Picture = LoadPicture(LoadGasPicture(3))
   txtCampo(7).DataType = 1
   txtCampo(7).Mask = "99999"
   txtCampo(7).PesqModoAbertura =  2 
   txtCampo(7).PesqFieldCapture = "Municipios.[Sequencia do municipio]"
   txtCampo(7).BoundColumn = "Sequencia do municipio"
   txtCampo(7).ListFields = "Descrição do municipio"
   txtCampo(7).OrderFields = "Descrição do municipio"
   txtCampo(7).Relation = ""
   txtCampo(7).Source = "Municipios"
   txtCampo(7).vgfrmGMCale.grdListaG.AutoRebind = True
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(7).DataField), txtCampo(7)

   Set txtCampo(9).CtPri = txtCp(9)
   txtCampo(9).DataType = 0
   txtCampo(9).Mask = "99999-999"
   txtCampo(9).BoundColumn = ""
   txtCampo(9).ListFields = ""
   txtCampo(9).OrderFields = ""
   txtCampo(9).Relation = ""
   txtCampo(9).Source = ""
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(9).DataField), txtCampo(9)

   Set txtCampo(10).CtPri = txtCp(10)
   txtCampo(10).DataType = 0
   txtCampo(10).Mask = "(99)9999-9999"
   txtCampo(10).BoundColumn = ""
   txtCampo(10).ListFields = ""
   txtCampo(10).OrderFields = ""
   txtCampo(10).Relation = ""
   txtCampo(10).Source = ""
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(10).DataField), txtCampo(10)

   Set txtCampo(11).CtPri = txtCp(11)
   txtCampo(11).DataType = 0
   txtCampo(11).Mask = "(99)99999-9999"
   txtCampo(11).BoundColumn = ""
   txtCampo(11).ListFields = ""
   txtCampo(11).OrderFields = ""
   txtCampo(11).Relation = ""
   txtCampo(11).Source = ""
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(11).DataField), txtCampo(11)

   Set txtCampo(12).CtPri = txtCp(12)
   txtCampo(12).DataType = 0
   txtCampo(12).Mask = "@x"
   txtCampo(12).BoundColumn = ""
   txtCampo(12).ListFields = ""
   txtCampo(12).OrderFields = ""
   txtCampo(12).Relation = ""
   txtCampo(12).Source = ""
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(12).DataField), txtCampo(12)

   Set txtCampo(16).CtPri = txtCp(16)
   txtCampo(16).DataType = 0
   txtCampo(16).Mask = "@a"
   txtCampo(16).BoundColumn = ""
   txtCampo(16).ListFields = ""
   txtCampo(16).OrderFields = ""
   txtCampo(16).Relation = ""
   txtCampo(16).Source = ""
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(16).DataField), txtCampo(16)

   Set txtCampo(17).CtPri = txtCp(17)
   txtCampo(17).DataType = 0
   txtCampo(17).Mask = "@x"
   txtCampo(17).BoundColumn = ""
   txtCampo(17).ListFields = ""
   txtCampo(17).OrderFields = ""
   txtCampo(17).Relation = ""
   txtCampo(17).Source = ""
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(17).DataField), txtCampo(17)

   Set txtCampo(18).CtPri = txtCp(18)
   Set txtCampo(18).CtFdo = labFdo18
   Set txtCampo(18).CtBot(BOT_ACAO) = bottxtCampo18(BOT_ACAO)
   Set bottxtCampo18(BOT_ACAO).Picture = LoadPicture(LoadGasPicture(4))
   txtCampo(18).DataType = 2
   txtCampo(18).Mask = "99/99/9999"
   txtCampo(18).BoundColumn = ""
   txtCampo(18).ListFields = ""
   txtCampo(18).OrderFields = ""
   txtCampo(18).Relation = ""
   txtCampo(18).Source = ""
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(18).DataField), txtCampo(18)

   Set txtCampo(13).CtPri = txtCp(13)
   txtCampo(13).DataType = 0
   txtCampo(13).Mask = "@x"
   txtCampo(13).BoundColumn = ""
   txtCampo(13).ListFields = ""
   txtCampo(13).OrderFields = ""
   txtCampo(13).Relation = ""
   txtCampo(13).Source = ""
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(13).DataField), txtCampo(13)

   Set txtCampo(14).CtPri = txtCp(14)
   txtCampo(14).DataType = 0
   txtCampo(14).Mask = "@x"
   txtCampo(14).BoundColumn = ""
   txtCampo(14).ListFields = ""
   txtCampo(14).OrderFields = ""
   txtCampo(14).Relation = ""
   txtCampo(14).Source = ""
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(14).DataField), txtCampo(14)

   Set txtCampo(15).CtPri = txtCp(15)
   txtCampo(15).DataType = 4
   txtCampo(15).Mask = ""
   txtCampo(15).BoundColumn = ""
   txtCampo(15).ListFields = ""
   txtCampo(15).OrderFields = ""
   txtCampo(15).Relation = ""
   txtCampo(15).Source = ""
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(15).DataField), txtCampo(15)

   Set txtCampo(0).CtPri = txtCp(0)
   txtCampo(0).DataType = 1
   txtCampo(0).Mask = "999999"
   txtCampo(0).Editable = False
   txtCampo(0).BoundColumn = ""
   txtCampo(0).ListFields = ""
   txtCampo(0).OrderFields = ""
   txtCampo(0).Relation = ""
   txtCampo(0).Source = ""
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(0).DataField), txtCampo(0)

   Set chkCampo(0).CtPri = chkCp(0)
   chkCampo(0).DataType = 5
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(chkCampo(0).DataField), chkCampo(0)

   Set chkCampo(1).CtPri = chkCp(1)
   chkCampo(1).DataType = 5
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(chkCampo(1).DataField), chkCampo(1)

   Set chkCampo(2).CtPri = chkCp(2)
   chkCampo(2).DataType = 5
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(chkCampo(2).DataField), chkCampo(2)

   Set chkCampo(3).CtPri = chkCp(3)
   chkCampo(3).DataType = 5
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(chkCampo(3).DataField), chkCampo(3)

   Set chkCampo(4).CtPri = chkCp(4)
   chkCampo(4).DataType = 5
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(chkCampo(4).DataField), chkCampo(4)

   Set chkCampo(5).CtPri = chkCp(5)
   chkCampo(5).DataType = 5
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(chkCampo(5).DataField), chkCampo(5)

   Set txtCampo(8).CtPri = txtCp(8)
   txtCampo(8).DataType = 0
   txtCampo(8).Mask = ""
   txtCampo(8).Editable = False
   txtCampo(8).BoundColumn = ""
   txtCampo(8).ListFields = ""
   txtCampo(8).OrderFields = ""
   txtCampo(8).Relation = ""
   txtCampo(8).Source = ""

   Set txtCampo(19).CtPri = txtCp(19)
   txtCampo(19).DataType = 2
   txtCampo(19).Mask = "99/99/9999"
   txtCampo(19).BoundColumn = ""
   txtCampo(19).ListFields = ""
   txtCampo(19).OrderFields = ""
   txtCampo(19).Relation = ""
   txtCampo(19).Source = ""
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(19).DataField), txtCampo(19)

   Set opcPainel1(0).CtPri = opcPainel1Cp(0)
   Set opcPainel1(0).CtFdo = labopcPainel1
   opcPainel1(0).DataType = 6
   opcPainel1(0).BookMark = 0
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(opcPainel1(0).DataField), opcPainel1(0)

   Set opcPainel1(1).CtPri = opcPainel1Cp(1)
   Set opcPainel1(1).CtFdo = labopcPainel1
   opcPainel1(1).DataType = 6
   opcPainel1(1).BookMark = 1

 Exit Sub

 DeuErro:
  CErr.NumErro = Err
  CErr.FunctionName = "DefineControles0"
  CErr.Origem = CStr(vgFormID) +" - "+ Me.Caption
 CErr.Show
End Sub


'poe relacionamento e filtro na lista externa (combobox)
Private Sub PoeRelEFiltroCbo(Index As Integer)
   On Error Resume Next
   Select Case Index
      Case 7
         txtCampo(7).Filter = "([Sequencia do municipio] > " & 0 & ") AND Inativo = " & 0 & ""
                           txtCampo(7).PesqSQLExpression = "SELECT Municipios.[Sequencia do municipio], Municipios.[Descrição do municipio], Municipios.Uf, Municipios.[Codigo do ibge], " + _
                                                              "Municipios.Cep FROM Municipios WHERE (Municipios.[Sequencia do municipio] > " + CStr(0) + ") AND (Municipios.Inativo = " + CStr(0) + ")"
   End Select
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
   MudaTamCampos Me
End Sub

'evento - descarregando o formulário da memória
Private Sub Form_Unload(Cancel As Integer)
   Dim i As Integer
   On Error Resume Next
   FinalizaForm Me
   Set lblRGIE = Nothing
   Set txtRGIE = Nothing
   Set lblCPFCNPJ = Nothing
   Set txtCPFCNPJ = Nothing
   Set lblAjuste = Nothing
   For i = 0 To UBound(txtCampo)
      txtCampo(i).Finalize
      Set txtCampo(i) = Nothing
   Next
   Set chkCampo(0) = Nothing
   Set chkCampo(1) = Nothing
   Set chkCampo(2) = Nothing
   Set chkCampo(3) = Nothing
   Set chkCampo(4) = Nothing
   Set chkCampo(5) = Nothing

   'se tiver imprimindo registros em grade, fecha form de selecao/preview
   UnLoad vgFrmImpCons
   Set vgFrmImpCons = Nothing

   grdBrowse.Finalize                             'descarrega o grid
   Set frmGeral = Nothing                         'libera o segmento de código do form
End Sub

'evento - quando o botão for pressionado
Private Sub Botao_Click(Index As Integer)
   Dim Cancel As Boolean, hMenu As Long, pt As POINTAPI
   If vgPriVez Then Exit Sub
   Select Case Index
      Case 0
         seqRegistro = Sequencia_do_Municipio 
         mdiNFE.MMunicipi
   End Select
End Sub


'evento - quando o botão for apertado
Private Sub bottxtCampo7_Click(Index As Integer)
   txtCampo(7).SetFocus
   DoEvents
   txtCampo(7).botClick Index
End Sub

'evento - quando o botão for apertado
Private Sub bottxtCampo18_Click(Index As Integer)
   txtCampo(18).SetFocus
   DoEvents
   txtCampo(18).botClick Index
End Sub

'evento - quando o mouse for pressionado sobre o campo
Private Sub txtCp_MouseDown(Index As Integer, Button As Integer, Shift As Integer, x as Single, y as Single)
   txtCampo(Index).MouseDown
End Sub


