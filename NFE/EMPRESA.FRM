Version 5.00
Begin VB.Form frmEmpresa
   ForeColor                =   &H80000008
   BorderStyle              =   2
   Height                   =   5925
   Left                     =   4050
   LinkTopic                =   "Empresa"
   LockControls             =   -1
   KeyPreview               =   -1
   MDIChild                 =   -1
   ScaleHeight              =   5490
   ScaleWidth               =   8670
   Top                      =   2290
   Width                    =   8760
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
      Height                   =   5325
      Left                     =   15
      Width                    =   8490
      Top                      =   15
      TabStop                  =  0
      _extentx                 =   14967
      _extenty                 =   9387
      Index                    =   0 
      Begin NFE.GCpMM mmCampo
         Appearance               =   0
         BackColor                =   &H8000000F
         BorderStyle              =   0
         Stretch                  =   0
         Height                   =   1500
         Left                     =   120
         Width                    =   1470
         Top                      =   60
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
         Height                   =   375
         Left                     =   1680
         Width                    =   2985
         Top                      =   540
         Alignment                =   0
         BeginProperty Font
            Name                     =   "Microsoft Sans Serif"
            CharSet                  =   0
            Weight                   =   700
            Size                     =   15.75
            Underline                =   0
            Italic                   =   0
            StrikeThrough            =   0
         EndProperty
         ForeColor                =   &H0
         Caption                  =   "Dados do Emitente"
         Index                    =   0 
      End
      Begin VB.Line Linha
         BorderColor              =   -2147483640
         BorderStyle              =   1
         BorderWidth              =   1
         X1                       =   1740
         Y1                       =   930
         X2                       =   4680
         Y2                       =   930
         Index                    =   0 
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   0
         Height                   =   240
         Left                     =   180
         Width                    =   1335
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
         ForeColor                =   &H0
         Caption                  =   "*Razão Social:"
         Index                    =   1 
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   0
         Height                   =   240
         Left                     =   660
         Width                    =   870
         Top                      =   2160
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
         ForeColor                =   &H0
         Caption                  =   "Fantasia:"
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
         ForeColor                =   &H0
         MaxLength                =   60
         BorderStyle              =   1
         Alignment                =   0
         TabIndex                 =   1
         TabStop                  =   -1
         Height                   =   300
         Left                     =   1680
         Width                    =   6570
         Top                      =   2160
         DataField                =   "Nome fantasia"
         Index                    =   0 
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   0
         Height                   =   240
         Left                     =   960
         Width                    =   570
         Top                      =   2640
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
         ForeColor                =   &H0
         Caption                  =   "*CPF:"
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
         BorderStyle              =   1
         Alignment                =   0
         TabIndex                 =   2
         TabStop                  =   -1
         Height                   =   300
         Left                     =   1680
         Width                    =   1530
         Top                      =   2640
         DataField                =   "Cpf do emitente"
         Index                    =   1 
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   0
         Height                   =   240
         Left                     =   3360
         Width                    =   630
         Top                      =   2640
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
         ForeColor                =   &H0
         Caption                  =   "*CNPJ:"
         Index                    =   4 
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
         Alignment                =   0
         TabIndex                 =   3
         TabStop                  =   -1
         Height                   =   300
         Left                     =   4140
         Width                    =   1800
         Top                      =   2640
         DataField                =   "Cnpj"
         Index                    =   2 
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   0
         Height                   =   240
         Left                     =   6060
         Width                    =   390
         Top                      =   2640
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
         ForeColor                =   &H0
         Caption                  =   "*IE:"
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
         MaxLength                =   20
         BorderStyle              =   1
         Alignment                =   0
         TabIndex                 =   4
         TabStop                  =   -1
         Height                   =   300
         Left                     =   6510
         Width                    =   1740
         Top                      =   2640
         DataField                =   "Inscrição estadual"
         Index                    =   3 
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   0
         Height                   =   240
         Left                     =   1080
         Width                    =   510
         Top                      =   3120
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
         ForeColor                =   &H0
         Caption                  =   "Rua:"
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
         MaxLength                =   60
         BorderStyle              =   1
         Alignment                =   0
         TabIndex                 =   5
         TabStop                  =   -1
         Height                   =   300
         Left                     =   1680
         Width                    =   5190
         Top                      =   3120
         DataField                =   "Rua"
         Index                    =   4 
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   0
         Height                   =   240
         Left                     =   6960
         Width                    =   270
         Top                      =   3120
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
         ForeColor                =   &H0
         Caption                  =   "Nº"
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
         ForeColor                =   &H0
         MaxLength                =   8
         BorderStyle              =   1
         Alignment                =   0
         TabIndex                 =   6
         TabStop                  =   -1
         Height                   =   300
         Left                     =   7260
         Width                    =   990
         Top                      =   3120
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
         Left                     =   960
         Width                    =   630
         Top                      =   3660
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
         ForeColor                =   &H0
         Caption                  =   "Bairro:"
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
         ForeColor                =   &H0
         MaxLength                =   60
         BorderStyle              =   1
         Alignment                =   0
         TabIndex                 =   7
         TabStop                  =   -1
         Height                   =   300
         Left                     =   1680
         Width                    =   2190
         Top                      =   3660
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
         Left                     =   3960
         Width                    =   960
         Top                      =   3660
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
         ForeColor                =   &H0
         Caption                  =   "Município:"
         Index                    =   9 
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
         MaxLength                =   60
         BorderStyle              =   1
         Alignment                =   0
         TabIndex                 =   8
         TabStop                  =   -1
         Height                   =   300
         Left                     =   4980
         Width                    =   2100
         Top                      =   3660
         DataField                =   "Município"
         Index                    =   7 
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   0
         Height                   =   240
         Left                     =   7200
         Width                    =   330
         Top                      =   3660
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
         ForeColor                =   &H0
         Caption                  =   "UF:"
         Index                    =   10 
      End
      Begin VB.Label labFdo8
         Appearance               =  1
         BorderStyle              =  1
         BackColor                =  &H80000005
         Left                     =   7650
         Top                      =   3660
         Width                    =   600
         Height                   =   300
      End
      Begin VB.CommandButton bottxtCampo8
         Style                    =   1
         TabStop                  =   0
         Index                    =   2
         Left                     =   7965
         Top                      =   3690
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
         TabIndex                 =   9
         TabStop                  =   -1
         Height                   =   240
         Left                     =   7680
         Width                    =   270
         Top                      =   3690
         DataField                =   "Uf"
         Index                    =   8 
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   0
         Height                   =   240
         Left                     =   1080
         Width                    =   495
         Top                      =   4140
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
         ForeColor                =   &H0
         Caption                  =   "CEP:"
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
         ForeColor                =   &H0
         BorderStyle              =   1
         Alignment                =   0
         TabIndex                 =   10
         TabStop                  =   -1
         Height                   =   300
         Left                     =   1680
         Width                    =   1140
         Top                      =   4140
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
         Left                     =   3000
         Width                    =   1920
         Top                      =   4140
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
         ForeColor                =   &H0
         Caption                  =   "Codigo do Município:"
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
         ForeColor                =   &H0
         BorderStyle              =   1
         Alignment                =   0
         TabIndex                 =   11
         TabStop                  =   -1
         Height                   =   300
         Left                     =   4980
         Width                    =   885
         Top                      =   4140
         DataField                =   "Codigo do municipio"
         Index                    =   10 
         MultiLine                =   -1
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   0
         Height                   =   240
         Left                     =   6240
         Width                    =   600
         Top                      =   4140
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
         ForeColor                =   &H0
         Caption                  =   "Fone:"
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
         ForeColor                =   &H0
         MaxLength                =   13
         BorderStyle              =   1
         Alignment                =   0
         TabIndex                 =   12
         TabStop                  =   -1
         Height                   =   300
         Left                     =   6855
         Width                    =   1380
         Top                      =   4140
         DataField                =   "Fone"
         Index                    =   11 
      End
      Begin NFE.GBotao Botao
         ButtonStyle              =   1
         JoinSeparators           =   0
         LeftSeparator            =   0
         TopSeparator             =   0
         TabIndex                 =   13
         TabStop                  =   0
         ButtonType               =   0
         Height                   =   300
         Left                     =   5880
         Width                    =   225
         Top                      =   4140
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
         Left                     =   1680
         Width                    =   6570
         Top                      =   1680
         DataField                =   "Razão social"
         Index                    =   12 
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   0
         Height                   =   240
         Left                     =   4620
         Width                    =   405
         Top                      =   180
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
         Caption                  =   "Pis:"
         Index                    =   14 
      End
      Begin VB.Label labFdo13
         Appearance               =  1
         BorderStyle              =  1
         BackColor                =  &H80000005
         Left                     =   5100
         Top                      =   180
         Width                    =   1125
         Height                   =   300
      End
      Begin VB.CommandButton bottxtCampo13
         Style                    =   1
         TabStop                  =   0
         Index                    =   0
         Left                     =   5940
         Top                      =   210
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
         Alignment                =   1
         TabIndex                 =   14
         TabStop                  =   0
         Height                   =   240
         Left                     =   5130
         Width                    =   795
         Top                      =   210
         DataField                =   "Aliquota do pis"
         Index                    =   13 
         MultiLine                =   -1
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   0
         Height                   =   240
         Left                     =   6360
         Width                    =   705
         Top                      =   180
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
         Caption                  =   "Cofins:"
         Index                    =   15 
      End
      Begin VB.Label labFdo14
         Appearance               =  1
         BorderStyle              =  1
         BackColor                =  &H80000005
         Left                     =   7080
         Top                      =   180
         Width                    =   1125
         Height                   =   300
      End
      Begin VB.CommandButton bottxtCampo14
         Style                    =   1
         TabStop                  =   0
         Index                    =   0
         Left                     =   7920
         Top                      =   210
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
         Alignment                =   1
         TabIndex                 =   15
         TabStop                  =   0
         Height                   =   240
         Left                     =   7110
         Width                    =   795
         Top                      =   210
         DataField                =   "Aliquota do cofins"
         Index                    =   14 
         MultiLine                =   -1
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   0
         Height                   =   240
         Left                     =   1680
         Width                    =   780
         Top                      =   1200
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
         Caption                  =   "Licença:"
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
         MaxLength                =   130
         BorderStyle              =   1
         Alignment                =   0
         TabIndex                 =   16
         TabStop                  =   -1
         Height                   =   300
         Left                     =   2520
         Width                    =   5699
         Top                      =   1200
         DataField                =   "Chave flexdocs"
         Index                    =   15 
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   -1
         Height                   =   240
         Left                     =   8160
         Width                    =   45
         Top                      =   5280
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
         Index                    =   17 
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   0
         Height                   =   240
         Left                     =   480
         Width                    =   1035
         Top                      =   4620
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
         Caption                  =   "Email NFe:"
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
         TabIndex                 =   17
         TabStop                  =   -1
         Height                   =   300
         Left                     =   1680
         Width                    =   3735
         Top                      =   4620
         DataField                =   "Email"
         Index                    =   16 
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   0
         Height                   =   240
         Left                     =   5580
         Width                    =   1215
         Top                      =   4620
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
         Caption                  =   "Ult Ativação:"
         Index                    =   19 
      End
      Begin VB.Label labFdo17
         Appearance               =  1
         BorderStyle              =  1
         BackColor                =  &H80000005
         Left                     =   6885
         Top                      =   4620
         Width                    =   1371
         Height                   =   300
      End
      Begin VB.CommandButton bottxtCampo17
         Style                    =   1
         TabStop                  =   0
         Index                    =   1
         Left                     =   7971
         Top                      =   4650
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
         TabIndex                 =   18
         TabStop                  =   -1
         Height                   =   240
         Left                     =   6915
         Width                    =   1041
         Top                      =   4650
         DataField                =   "Data Inicial da Ativação"
         Index                    =   17 
      End
   End
End
Attribute VB_name = "frmEmpresa"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
'* Sistema...: Emissor de MDF-e (Layout 3.00)
'* Empresa...: Ygor Eduardo Dellalio
'* Módulo....: Empresa
'* Função....: Parametros do Emitente
'* CopyRight.: (C)2024 Ygor Eduardo Dellalio
'* Criação...: GAS-2007 - Gerador Automático de Sistemas
'* Data......: 05/09/2024 18:10:10
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
Dim txtCampo(17) As New FormataCampos             'classe dos campos tipo texto do módulo  
Dim Razao_social As String, Nome_fantasia As String, Cpf As String
Dim Inscricao_estadual As String, Cnpj As String, Rua As String
Dim Nro As String, Bairro As String, Municipio As String
Dim Codigo_do_municipio As Long, Uf As String, Cep As String
Dim Fone As String, Aliquota_do_cofins As Double, Chave_flexdocs As String
Dim Email As String, Data_Inicial_da_Ativacao As Variant, Aliquota_do_pis As Double
Public txtIE As Object, lblAjuste As Object

Public MsgCMun As String

'ROTINA PARA ABRIR O SITE DO IBGE E JA TRAZER O CODIGO DO MUNICIPIO INFORMADO
Private Sub ConsultaCodMun(municipio As String)
   On Error Resume Next
  
   If Not Vazio(municipio) Then
      ShellExecute 0&, vbNullString, "http://www.ibge.gov.br/home/geociencias/areaterritorial/area.php?nome=" & _
                                     SuperTiraAcentos(municipio) & "&codigo=&submit.x=0&submit.y=0", vbNullString, vbNullString, SW_SHOWNORMAL     
   Else
      ShellExecute 0&, vbNullString, "http://www.ibge.gov.br/home/geociencias/areaterritorial/area.shtm", vbNullString, vbNullString, SW_SHOWNORMAL
   End If

End Sub

'Valida Código Mun de Acordo com o DV e UF
Public Function ValidaCMun(Codigo As Long, UF As String) As Boolean
   Dim A(6), B(6), C(6), D(6) As Integer   'Vetores
   Dim DV, i, Soma, DVTabela, CodEstado As Integer
   Dim RestoDiv As Double
   Dim UFVect(27, 27) As Variant           'Matriz
   
   ValidaCMun = True: MsgCMun = ""
   If Codigo = 0 Then Exit Function        'Caso o Usuário não souber o Código vamos deixar salvar  
   If Codigo = 9999999 Then Exit Function  'Exterior
   
   'Estados com Sigla e Codigo
   UFVect(0, 0) = 11: UFVect(0, 1) = "RO"    'RONDÔNIA
   UFVect(1, 0) = 12: UFVect(1, 1) = "AC"    'ACRE
   UFVect(2, 0) = 13: UFVect(2, 1) = "AM"    'AMAZONAS
   UFVect(3, 0) = 14: UFVect(3, 1) = "RR"    'RORAIMA
   UFVect(4, 0) = 15: UFVect(4, 1) = "PA"    'PARÁ
   UFVect(5, 0) = 16: UFVect(5, 1) = "AP"    'AMAPÁ
   UFVect(6, 0) = 17: UFVect(6, 1) = "TO"    'TOCANTINS
   UFVect(7, 0) = 21: UFVect(7, 1) = "MA"    'MARANHÃO
   UFVect(8, 0) = 22: UFVect(8, 1) = "PI"    'PIAUÍ
   UFVect(9, 0) = 23: UFVect(9, 1) = "CE"    'CEARÁ
   UFVect(10, 0) = 24: UFVect(10, 1) = "RN"  'RIO GRANDE DO NORTE
   UFVect(11, 0) = 25: UFVect(11, 1) = "PB"  'PARAÍBA
   UFVect(12, 0) = 26: UFVect(12, 1) = "PE"  'PERNAMBUCO
   UFVect(13, 0) = 27: UFVect(13, 1) = "AL"  'ALAGOAS
   UFVect(14, 0) = 28: UFVect(14, 1) = "SE"  'SERGIPE
   UFVect(15, 0) = 29: UFVect(15, 1) = "BA"  'BAHIA
   UFVect(16, 0) = 31: UFVect(16, 1) = "MG"  'MINAS GERAIS
   UFVect(17, 0) = 32: UFVect(17, 1) = "ES"  'ESPÍRITO SANTO
   UFVect(18, 0) = 33: UFVect(18, 1) = "RJ"  'RIO DE JANEIRO
   UFVect(19, 0) = 35: UFVect(19, 1) = "SP"  'SÃO PAULO
   UFVect(20, 0) = 41: UFVect(20, 1) = "PR"  'PARANÁ
   UFVect(21, 0) = 42: UFVect(21, 1) = "SC"  'SANTA CATARINA
   UFVect(22, 0) = 43: UFVect(22, 1) = "RS"  'RIO GRANDE DO SUL
   UFVect(23, 0) = 50: UFVect(23, 1) = "MS"  'MATO GROSSO DO SUL
   UFVect(24, 0) = 51: UFVect(24, 1) = "MT"  'MATO GROSS
   UFVect(25, 0) = 52: UFVect(25, 1) = "GO"  'GOIÁS
   UFVect(26, 0) = 53: UFVect(26, 1) = "DF"  'DISTRITO FEDERAL
   
   'Possíveis erros: Digitos faltando ou os dois primeiros digitos nw corresponde a UF informada
   
   'Dígitos
   If Len(CStr(Codigo)) < 7 Then
      MsgCMun = "Código do Município Informado Possuí Valores a Menos!" + vbCrLf + _
                "Eram Esperados 7 Dígitos."
      ValidaCMun = False
      Exit Function
   Else
      If Vazio(UF) Then 'Só por Precausão o GAS ja esta verificando na Validação do campo UF, mas em todo caso neh
         MsgCMun = "Cidade sem UF Cadastrada!" + vbCrLf + _
                   "Favor Informá-la."
         ValidaCMun = False
         Exit Function
      Else              'UF Conrresponde?
         For i = 0 To 26
            If UFVect(i, 1) = UF Then
               If CInt(UFVect(i, 0)) = Mid(Codigo, 1, 2) Then
                  GoTo Continua                 'Parabéns Corresponde
               Else
                  Exit For
               End If
           End If
         Next
         MsgCMun = "Código do Município não Corresponde ao Estado Informado!" + vbCrLf + _
                   "Favor Verificar a UF e o Código do Município."
         ValidaCMun = False       'Vixi deu Merd... Vamos Digitar certo
         Exit Function
      End If
   End If
             
'Vamos Verificar o Digito Verificador agora
Continua:
   DVTabela = Mid(Codigo, 7, 1) 'DV digitado
   
   'Alimentando o Vetor B(Pesos 1 e 2)
   B(0) = 1
   B(1) = 2
   B(2) = 1
   B(3) = 2
   B(4) = 1
   B(5) = 2
     
   For i = 0 To 5
      A(i) = Mid(Codigo, i + 1, 1)  'Vetor Codigo do Municipio
      C(i) = A(i) * B(i)            'Vetor Ponderação(A * B)
      If C(i) <= 9 Then             'Se a Ponderação for maior que 9 vamos somar os algarismos
         D(i) = C(i)
      Else
         D(i) = CInt(Abs((Mid(C(i), 1, 1)) + Abs(Mid(C(i), 2, 1)))) 'Vetor Soma dos Algarismos
      End If
      Soma = Soma + D(i)            'Soma Total do Algarismos
   Next
   
   RestoDiv = Soma Mod 10           'Pegando o Resto da Divição
   DV = 10 - RestoDiv               'Pegando o Dígito Verificador
   DV = IIf(DV = 10, 0, DV)         'Opa se For Resto 0 entao o DV tb é 0
   
   'Ufa acabou vamos somente verificar agora
   If DV <> DVTabela Then            'Verificando se o digito verificador confere
      MsgCMun = "Código do Município Informado está Incorreto!" + vbCrLf + _
                "Dígito Verificador Inválido."
      ValidaCMun = False
   End If
End Function

Private Sub MudaMascara()
   On Error Resume Next
   
      Select Case Uf
         Case "MG" '999.999.999/9999
            txtIE.Mask = "999.999.999/9999"
         Case "ES", "GO", "MA", "PA" '999.999.99-9
            txtIE.Mask = "999.999.99-9"
         Case "RJ" '99.999.99-9
            txtIE.Mask = "99.999.99-9" 
         Case "SC" '999.999.999
            txtIE.Mask = "999.999.999"
         Case "DF" '99.999999.999-99
            txtIE.Mask = "99.999999.999-99"
         Case "PR" '99.999.999-99
            txtIE.Mask = "99.999.999-99"
         Case "PE" '9.999.999-99
            txtIE.Mask = "9.999.999-99"
         Case "RN", "AM", "PB" '99.999.999-9
            txtIE.Mask = "99.999.999-9"
         Case "RS" '999/999999-9
            txtIE.Mask = "999/999999-9"
         Case "RO" '9999999999999-9
            txtIE.Mask = "9999999999999-9"
         Case "SP" '999.999.999.999
            'If Not e_Produtor_Paulista Then
               txtIE.Mask = "999.999.999.999"
            'Else '(Produtor) 99999999.9/999
            '   txtRGIE.Mask = "99999999.9/999"
            'End If
         Case "BA" '#99.999.999
            txtIE.Mask = "#99.999.999"
         Case "CE", "AL", "AP", "PI", "SE", "RR" '99999999-9
            txtIE.Mask = "99999999-9"
         Case "AC" '99.999.999/999-99
            txtIE.Mask = "99.999.999/999-99"
         Case "MT" '9999999999-9
            txtIE.Mask = "9999999999-9"
         Case "MS" '99.999.999-9
            txtIE.Mask = "99.999.999-9"   
         Case "TO" '99.99.999999-9
            txtIE.Mask = "99.99.999999-9"
      End Select      
      
   If vgSituacao <> ACAO_INCLUINDO And vgSituacao <> ACAO_EDITANDO Then Executar PEGA_DO_ARQUIVO   'Se nw estiver editando ou incluindo vamos pegar recuperar as informações do banco
                                                                                                   'Senão tiver essa linha quando o usuario navegar pelos registro ele nw aplica a mascara
                                                                                                   'como deveria      
End Sub

Public Property Get txtCampoTab(Index As Integer) As FormataCampos   
   Set txtCampoTab = txtCampo(Index)
End Sub

'inicializa variaveis (apelidos) coms os campos correspondentes
Private Sub InicializaApelidos(vgComOQue As Integer)
   On Error Resume Next                           'prepara para possíveis erros
   If (vgTb.RecordCount > 0 And vgTb.Eof = False And vgTb.Bof = False) Or vgComOQue = COM_TEXTBOX Then
      If vgComOQue = COM_TEXTBOX Then
         Razao_social = txtCampo(12).Value
         Nome_fantasia = txtCampo(0).Value
         Cpf = txtCampo(1).Value
         Inscricao_estadual = txtCampo(3).Value
         Cnpj = txtCampo(2).Value
         Rua = txtCampo(4).Value
         Nro = txtCampo(5).Value
         Bairro = txtCampo(6).Value
         Municipio = txtCampo(7).Value
         Codigo_do_municipio = txtCampo(10).Value
         Uf = txtCampo(8).Value
         Cep = txtCampo(9).Value
         Fone = txtCampo(11).Value
         Aliquota_do_cofins = txtCampo(14).Value
         Chave_flexdocs = txtCampo(15).Value
         Email = txtCampo(16).Value
         Data_Inicial_da_Ativacao = txtCampo(17).Value
         Aliquota_do_pis = txtCampo(13).Value
      Else
         Razao_social = IIf(IsNull(vgTb![Razão social]), "", vgTb![Razão social])
         Nome_fantasia = IIf(IsNull(vgTb![Nome fantasia]), "", vgTb![Nome fantasia])
         Cpf = IIf(IsNull(vgTb![Cpf do emitente]), "", vgTb![Cpf do emitente])
         Inscricao_estadual = IIf(IsNull(vgTb![Inscrição estadual]), "", vgTb![Inscrição estadual])
         Cnpj = IIf(IsNull(vgTb!Cnpj), "", vgTb!Cnpj)
         Rua = IIf(IsNull(vgTb!Rua), "", vgTb!Rua)
         Nro = IIf(IsNull(vgTb!Nro), "", vgTb!Nro)
         Bairro = IIf(IsNull(vgTb!Bairro), "", vgTb!Bairro)
         Municipio = IIf(IsNull(vgTb!Município), "", vgTb!Município)
         Codigo_do_municipio = IIf(IsNull(vgTb![Codigo do municipio]), 0, vgTb![Codigo do municipio])
         Uf = IIf(IsNull(vgTb!Uf), "", vgTb!Uf)
         Cep = IIf(IsNull(vgTb!Cep), "", vgTb!Cep)
         Fone = IIf(IsNull(vgTb!Fone), "", vgTb!Fone)
         Aliquota_do_cofins = IIf(IsNull(vgTb![Aliquota do cofins]), 0, vgTb![Aliquota do cofins])
         Chave_flexdocs = IIf(IsNull(vgTb![Chave flexdocs]), "", vgTb![Chave flexdocs])
         Email = IIf(IsNull(vgTb!Email), "", vgTb!Email)
         Data_Inicial_da_Ativacao = vgTb![Data Inicial da Ativação]
         Aliquota_do_pis = IIf(IsNull(vgTb![Aliquota do pis]), 0, vgTb![Aliquota do pis])
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
      .botInclui.Enabled = i
      .Menu_Inclui.Enabled = i
      i = Permitido(vgIdentTab, ACAO_EXCLUINDO)
      If Err Then Err.Clear: i = False
      vgTemExclusao = i
      .botExclui.Enabled = i
      .Menu_Exclui.Enabled = i
      i = Permitido(vgIdentTab, ACAO_EDITANDO)
      If Err Then Err.Clear: i = False
      vgTemAlteracao = i
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
      vgOk = (Not Vazio(Razao_social))
      vgMsg$ = "Razão social não pode ser vazio!"
      If Not vgOk Then txtCampo(12).SetFocus
      If vgOk Then
         vgOk = (Not Vazio(Nome_fantasia))
         vgMsg$ = "Nome fantasia não pode ser vazio!"
         If Not vgOk Then txtCampo(0).SetFocus
      End If
      If vgOk Then
         vgOk = (VDV2(Cpf))
         vgMsg$ = "Cpf inválido!"
         If Not vgOk Then txtCampo(1).SetFocus
      End If
      If vgOk Then
         vgOk = (VCGC(Cnpj))
         vgMsg$ = "Cnpj inválido!"
         If Not vgOk Then txtCampo(2).SetFocus
      End If
      If vgOk Then
         If Uf <> "" Then
            vgOk = (ValidaIE(Uf, Inscricao_estadual, False))
            vgMsg$ = "" & MsgValIE & ""
            If Not vgOk Then txtCampo(3).SetFocus
         End If
      End If
      If vgOk Then
         If Vazio(Inscricao_estadual) Then
            vgOk = (Not Vazio(Inscricao_estadual))
            vgMsg$ = "Inscrição Estadual não pode ser vazio"
            If Not vgOk Then txtCampo(3).SetFocus
         End If
      End If
      If vgOk Then
         vgOk = (Not Vazio(Rua))
         vgMsg$ = "Rua não pode ser vazio!"
         If Not vgOk Then txtCampo(4).SetFocus
      End If
      If vgOk Then
         vgOk = (Not Vazio(Nro))
         vgMsg$ = "Nro não pode ser vazio!"
         If Not vgOk Then txtCampo(5).SetFocus
      End If
      If vgOk Then
         vgOk = (Not Vazio(Bairro))
         vgMsg$ = "Bairro não pode ser vazio!"
         If Not vgOk Then txtCampo(6).SetFocus
      End If
      If vgOk Then
         vgOk = (Not Vazio(Municipio))
         vgMsg$ = "Município não pode ser vazio!"
         If Not vgOk Then txtCampo(7).SetFocus
      End If
      If vgOk Then
         vgOk = (VUF(Uf))
         vgMsg$ = "Uf inválido!"
         If Not vgOk Then txtCampo(8).SetFocus
      End If
      If vgOk Then
         vgOk = (Not Vazio(Cep))
         vgMsg$ = "Cep não pode ser vazio!"
         If Not vgOk Then txtCampo(9).SetFocus
      End If
      If vgOk Then
         vgOk = (ValidaCMun(Codigo_do_municipio, UF))
         vgMsg$ = "" & MsgCMun & ""
         If Not vgOk Then txtCampo(10).SetFocus
      End If
      If vgOk Then
         vgOk = ((Not Vazio(Data_Inicial_da_Ativacao)) And (IsDate(Data_Inicial_da_Ativacao) Or Vazio(Data_Inicial_da_Ativacao)))
         vgMsg$ = "Data Inicial da Ativação não pode ser vazio!"
         If Not vgOk Then txtCampo(17).SetFocus
      End If
      If vgOk Then vgMsg$ = ""
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
                  On Error Goto DeuErro
         InicializaApelidos COM_TEXTBOX
      End If
   ElseIf vgOq = PEGA_DO_ARQUIVO Then
      If vgTb.RecordCount > 0 And vgTb.EOF = False And vgTb.BOF = False Then
         vgPriVez = True
         InicializaApelidos COM_REGISTRO
         For i = 0 To UBound(txtCampo)
            If Len(txtCampo(i).DataField) > 0 Then
               txtCampo(i).SetOriginalValue = True
               txtCampo(i).Value = vgTb.Fields(txtCampo(i).DataField).Value
            End If
         Next
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
      For i = 0 To UBound(txtCampo)
         If Len(txtCampo(i).DataField) > 0 Then
            If vgTb.Fields(txtCampo(i).DataField).Value <> txtCampo(i).OriginalValue Then
               If Len(vgMsg$) = 0 Then
                  vgMsg$ = Caption + "|3600|" + LoadGasString(122)
               End If
               vgPriVez = True
               txtCampo(i).SetOriginalValue = True
               txtCampo(i).Value = vgTb.Fields(txtCampo(i).DataField).Value
               vgPriVez = False
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
   ElseIf vgOq = INI_APELIDOS Then
      InicializaApelidos COM_REGISTRO
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

'evento - quando qq tecla for digitada no formulário
Private Sub Form_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyEscape Then                 'se teclou ESC
      Unload Me                                   'tira este form da memória
   End If
End Sub

'prepara botões e o formulário para o novo registro
Public Sub Reposition(Optional ForceRebind As Boolean, Optional LockGrids As Boolean = True)
   On Error GoTo DeuErro
   If vgPriVez Then Exit Sub
   If vgSituacao <> ACAO_INCLUINDO And vgSituacao <> ACAO_EDITANDO Then Executar PEGA_DO_ARQUIVO
   vgTemAlteracaoGrids = Not LockGrids
DeuErro:
   
End Sub

'evento - quando o conteúdo do campo for alterado
Private Sub txtCp_Change(Index As Integer)
   If vgPriVez Or txtCampo(Index).PriVez Then Exit Sub
   If Len(txtCampo(Index).DataField) > 0 Then LigaFocos Me
   InicializaApelidos COM_TEXTBOX                         'inicializa apelidos com o que esta sendo digitado
   txtCampo(Index).Change
   Select Case Index
      Case 8
         MudaMascara
   End Select
End Sub

'evento - quando o campo receber o foco
Private Sub txtCp_GotFocus(Index As Integer)
   If vgSituacao <> ACAO_NAVEGANDO Or (Len(txtCampo(Index).PesqSQLExpression) > 0) Then
      On Error Resume Next
      Select Case Index
         Case 17
            If Len(txtCp(17).Text) = 0 Then
               txtCampo(17).Value = Date
               txtCp_Change Index
               InicializaApelidos COM_TEXTBOX
            End If
      End Select
   End If
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
   txtCampo(Index).LostFocus
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
   Caption = LoadGasString(12000)
   vgFormID = 614
   vgIdentTab = "Empresa"
   vgFiltroEmUso = -1
   vgIndDefault = ""
   vgPriVez = True
   vgTipo = TP_PARAMETROS
   vgTemInclusao = True
   vgTemExclusao = True
   vgTemAlteracao = True
   vgTemProcura = False
   vgTemFiltro = False
   vgTemBrowse = False
   vgTemCondicoesEsp = False
   vgCaracteristica = F_DADOS
   vgUltimoTabIndex = 18
   vgSituacao = ACAO_NAVEGANDO
   Set mmCampo(0).Picture = LoadPicture(LoadGasPicture(3505))
   Set Botao(0).Picture = LoadPicture(LoadGasPicture(3506))
   Set txtIE = txtCampo(3)
   Set lblAjuste = Label(17)
   Set vgTb = New GRecordSet
   DefineControles
   vgTooltips.Create
   Label(0).Caption = LoadGasString(12005)
   Label(1).Caption = LoadGasString(12006)
   Label(2).Caption = LoadGasString(12007)
   vgTooltips.AddTool txtCampo(0).CtPri, 0, LoadGasString(12008)
   Label(3).Caption = LoadGasString(12009)
   vgTooltips.AddTool txtCampo(1).CtPri, 0, LoadGasString(12010)
   Label(4).Caption = LoadGasString(12011)
   vgTooltips.AddTool txtCampo(2).CtPri, 0, LoadGasString(12012)
   Label(5).Caption = LoadGasString(12013)
   vgTooltips.AddTool txtCampo(3).CtPri, 0, LoadGasString(12014)
   Label(6).Caption = LoadGasString(12015)
   vgTooltips.AddTool txtCampo(4).CtPri, 0, LoadGasString(12016)
   Label(7).Caption = LoadGasString(12017)
   vgTooltips.AddTool txtCampo(5).CtPri, 0, LoadGasString(12018)
   Label(8).Caption = LoadGasString(12019)
   vgTooltips.AddTool txtCampo(6).CtPri, 0, LoadGasString(12020)
   Label(9).Caption = LoadGasString(12021)
   vgTooltips.AddTool txtCampo(7).CtPri, 0, LoadGasString(12022)
   Label(10).Caption = LoadGasString(12023)
   vgTooltips.AddTool txtCampo(8).CtPri, 0, LoadGasString(12024)
   Label(11).Caption = LoadGasString(12025)
   vgTooltips.AddTool txtCampo(9).CtPri, 0, LoadGasString(12026)
   Label(12).Caption = LoadGasString(12027)
   vgTooltips.AddTool txtCampo(10).CtPri, 0, LoadGasString(12028)
   Label(13).Caption = LoadGasString(12029)
   vgTooltips.AddTool txtCampo(11).CtPri, 0, LoadGasString(12030)
   vgTooltips.AddTool txtCampo(12).CtPri, 0, LoadGasString(12031)
   Label(14).Caption = LoadGasString(12032)
   vgTooltips.AddTool txtCampo(13).CtPri, 0, LoadGasString(12033)
   Label(15).Caption = LoadGasString(12034)
   vgTooltips.AddTool txtCampo(14).CtPri, 0, LoadGasString(12035)
   Label(16).Caption = LoadGasString(12036)
   vgTooltips.AddTool txtCampo(15).CtPri, 0, LoadGasString(12037)
   Label(17).Caption = LoadGasString(12038)
   Label(18).Caption = LoadGasString(12039)
   vgTooltips.AddTool txtCampo(16).CtPri, 0, LoadGasString(12040)
   Label(19).Caption = LoadGasString(12041)
   vgTooltips.AddTool txtCampo(17).CtPri, 0, LoadGasString(12042)
   AjustaTamanho Me
   IniciaFormDados Me
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

   Set txtCampo(12).CtPri = txtCp(12)
   txtCampo(12).DataType = 0
   txtCampo(12).Mask = "@x"
   txtCampo(12).BoundColumn = ""
   txtCampo(12).ListFields = ""
   txtCampo(12).OrderFields = ""
   txtCampo(12).Relation = ""
   txtCampo(12).Source = ""

   Set txtCampo(0).CtPri = txtCp(0)
   txtCampo(0).DataType = 0
   txtCampo(0).Mask = "@x"
   txtCampo(0).BoundColumn = ""
   txtCampo(0).ListFields = ""
   txtCampo(0).OrderFields = ""
   txtCampo(0).Relation = ""
   txtCampo(0).Source = ""

   Set txtCampo(1).CtPri = txtCp(1)
   txtCampo(1).DataType = 0
   txtCampo(1).Mask = "999.999.999-99"
   txtCampo(1).BoundColumn = ""
   txtCampo(1).ListFields = ""
   txtCampo(1).OrderFields = ""
   txtCampo(1).Relation = ""
   txtCampo(1).Source = ""

   Set txtCampo(2).CtPri = txtCp(2)
   txtCampo(2).DataType = 0
   txtCampo(2).Mask = "99.999.999/9999-99"
   txtCampo(2).BoundColumn = ""
   txtCampo(2).ListFields = ""
   txtCampo(2).OrderFields = ""
   txtCampo(2).Relation = ""
   txtCampo(2).Source = ""

   Set txtCampo(3).CtPri = txtCp(3)
   txtCampo(3).DataType = 0
   txtCampo(3).Mask = "@!"
   txtCampo(3).BoundColumn = ""
   txtCampo(3).ListFields = ""
   txtCampo(3).OrderFields = ""
   txtCampo(3).Relation = ""
   txtCampo(3).Source = ""

   Set txtCampo(4).CtPri = txtCp(4)
   txtCampo(4).DataType = 0
   txtCampo(4).Mask = "@x"
   txtCampo(4).BoundColumn = ""
   txtCampo(4).ListFields = ""
   txtCampo(4).OrderFields = ""
   txtCampo(4).Relation = ""
   txtCampo(4).Source = ""

   Set txtCampo(5).CtPri = txtCp(5)
   txtCampo(5).DataType = 0
   txtCampo(5).Mask = "@x"
   txtCampo(5).BoundColumn = ""
   txtCampo(5).ListFields = ""
   txtCampo(5).OrderFields = ""
   txtCampo(5).Relation = ""
   txtCampo(5).Source = ""

   Set txtCampo(6).CtPri = txtCp(6)
   txtCampo(6).DataType = 0
   txtCampo(6).Mask = "@x"
   txtCampo(6).BoundColumn = ""
   txtCampo(6).ListFields = ""
   txtCampo(6).OrderFields = ""
   txtCampo(6).Relation = ""
   txtCampo(6).Source = ""

   Set txtCampo(7).CtPri = txtCp(7)
   txtCampo(7).DataType = 0
   txtCampo(7).Mask = "@x"
   txtCampo(7).BoundColumn = ""
   txtCampo(7).ListFields = ""
   txtCampo(7).OrderFields = ""
   txtCampo(7).Relation = ""
   txtCampo(7).Source = ""

   Set txtCampo(8).CtPri = txtCp(8)
   Set txtCampo(8).CtFdo = labFdo8
   Set txtCampo(8).CtBot(BOT_COMBO) = bottxtCampo8(BOT_COMBO)
   Set bottxtCampo8(BOT_COMBO).Picture = LoadPicture(LoadGasPicture(3))
   txtCampo(8).DataType = 0
   txtCampo(8).ListFields = "AC|AL|AP|AM|BA|CE|DF|ES|TO|GO|MA|MT|MS|MG|PA|PB|PR|PE|PI|RN|RS|RJ|RO|RR|SC|SP|SE"

   Set txtCampo(9).CtPri = txtCp(9)
   txtCampo(9).DataType = 0
   txtCampo(9).Mask = "99999-999"
   txtCampo(9).BoundColumn = ""
   txtCampo(9).ListFields = ""
   txtCampo(9).OrderFields = ""
   txtCampo(9).Relation = ""
   txtCampo(9).Source = ""

   Set txtCampo(10).CtPri = txtCp(10)
   txtCampo(10).DataType = 1
   txtCampo(10).Mask = "9999999"
   txtCampo(10).BoundColumn = ""
   txtCampo(10).ListFields = ""
   txtCampo(10).OrderFields = ""
   txtCampo(10).Relation = ""
   txtCampo(10).Source = ""

   Set txtCampo(11).CtPri = txtCp(11)
   txtCampo(11).DataType = 0
   txtCampo(11).Mask = "(99)9999-9999"
   txtCampo(11).BoundColumn = ""
   txtCampo(11).ListFields = ""
   txtCampo(11).OrderFields = ""
   txtCampo(11).Relation = ""
   txtCampo(11).Source = ""

   Set txtCampo(13).CtPri = txtCp(13)
   Set txtCampo(13).CtFdo = labFdo13
   Set txtCampo(13).CtBot(BOT_ACAO) = bottxtCampo13(BOT_ACAO)
   Set bottxtCampo13(BOT_ACAO).Picture = LoadPicture(LoadGasPicture(4))
   txtCampo(13).DataType = 1
   txtCampo(13).Mask = "999,9999"
   txtCampo(13).BoundColumn = ""
   txtCampo(13).ListFields = ""
   txtCampo(13).OrderFields = ""
   txtCampo(13).Relation = ""
   txtCampo(13).Source = ""

   Set txtCampo(14).CtPri = txtCp(14)
   Set txtCampo(14).CtFdo = labFdo14
   Set txtCampo(14).CtBot(BOT_ACAO) = bottxtCampo14(BOT_ACAO)
   Set bottxtCampo14(BOT_ACAO).Picture = LoadPicture(LoadGasPicture(4))
   txtCampo(14).DataType = 1
   txtCampo(14).Mask = "999,9999"
   txtCampo(14).BoundColumn = ""
   txtCampo(14).ListFields = ""
   txtCampo(14).OrderFields = ""
   txtCampo(14).Relation = ""
   txtCampo(14).Source = ""

   Set txtCampo(15).CtPri = txtCp(15)
   txtCampo(15).DataType = 0
   txtCampo(15).Mask = "@a"
   txtCampo(15).BoundColumn = ""
   txtCampo(15).ListFields = ""
   txtCampo(15).OrderFields = ""
   txtCampo(15).Relation = ""
   txtCampo(15).Source = ""

   Set txtCampo(16).CtPri = txtCp(16)
   txtCampo(16).DataType = 0
   txtCampo(16).Mask = "@a"
   txtCampo(16).BoundColumn = ""
   txtCampo(16).ListFields = ""
   txtCampo(16).OrderFields = ""
   txtCampo(16).Relation = ""
   txtCampo(16).Source = ""

   Set txtCampo(17).CtPri = txtCp(17)
   Set txtCampo(17).CtFdo = labFdo17
   Set txtCampo(17).CtBot(BOT_LISTA) = bottxtCampo17(BOT_LISTA)
   Set bottxtCampo17(BOT_LISTA).Picture = LoadPicture(LoadGasPicture(4))
   txtCampo(17).DataType = 2
   txtCampo(17).Mask = "99/99/9999"
   txtCampo(17).PesqModoAbertura =  2 
   txtCampo(17).BoundColumn = ""
   txtCampo(17).ListFields = ""
   txtCampo(17).OrderFields = ""
   txtCampo(17).Relation = ""
   txtCampo(17).Source = ""

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
   Set txtIE = Nothing
   Set lblAjuste = Nothing
   For i = 0 To UBound(txtCampo)
      txtCampo(i).Finalize
      Set txtCampo(i) = Nothing
   Next

   'se tiver imprimindo registros em grade, fecha form de selecao/preview
   UnLoad vgFrmImpCons
   Set vgFrmImpCons = Nothing

   Set frmEmpresa = Nothing                       'libera o segmento de código do form
End Sub

'evento - quando o botão for pressionado
Private Sub Botao_Click(Index As Integer)
   Dim Cancel As Boolean, hMenu As Long, pt As POINTAPI
   If vgPriVez Then Exit Sub
   Select Case Index
      Case 0
         ConsultaCodMun Municipio 
   End Select
End Sub


'evento - quando o botão for apertado
Private Sub bottxtCampo8_Click(Index As Integer)
   txtCampo(8).SetFocus
   DoEvents
   txtCampo(8).botClick Index
End Sub

'evento - quando o botão for apertado
Private Sub bottxtCampo13_Click(Index As Integer)
   txtCampo(13).SetFocus
   DoEvents
   txtCampo(13).botClick Index
End Sub

'evento - quando o botão for apertado
Private Sub bottxtCampo14_Click(Index As Integer)
   txtCampo(14).SetFocus
   DoEvents
   txtCampo(14).botClick Index
End Sub

'evento - quando o botão for apertado
Private Sub bottxtCampo17_Click(Index As Integer)
   txtCampo(17).SetFocus
   DoEvents
   txtCampo(17).botClick Index
End Sub

'evento - quando o mouse for pressionado sobre o campo
Private Sub txtCp_MouseDown(Index As Integer, Button As Integer, Shift As Integer, x as Single, y as Single)
   txtCampo(Index).MouseDown
End Sub


