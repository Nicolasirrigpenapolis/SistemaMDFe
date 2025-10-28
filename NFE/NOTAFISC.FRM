Version 5.00
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "TABCTL32.OCX"
Begin VB.Form frmNotafisc
   ForeColor                =   &H80000008
   BorderStyle              =   2
   Height                   =   8355
   Left                     =   2610
   LinkTopic                =   "Notafisc"
   LockControls             =   -1
   KeyPreview               =   -1
   MDIChild                 =   -1
   ScaleHeight              =   7935
   ScaleWidth               =   13575
   Top                      =   1615
   Width                    =   13665
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
      Height                   =   7755
      Left                     =   15
      Width                    =   13395
      Top                      =   15
      TabStop                  =  0
      _extentx                 =   23615
      _extenty                 =   13672
      Index                    =   0 
      Begin NFE.GCpMM mmCampo
         Appearance               =   0
         BackColor                =   &H8000000F
         BorderStyle              =   0
         Stretch                  =   0
         Height                   =   1425
         Left                     =   60
         Width                    =   1455
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
         Height                   =   435
         Left                     =   1560
         Width                    =   3855
         Top                      =   300
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
         Caption                  =   "Nota Fiscal Eletrônica"
         Index                    =   0 
      End
      Begin VB.Line Linha
         BorderColor              =   -2147483640
         BorderStyle              =   1
         BorderWidth              =   1
         X1                       =   1620
         Y1                       =   1110
         X2                       =   13035
         Y2                       =   1110
         Index                    =   0 
      End
      Begin TabDlg.SSTab Tabs
         TabsPerRow               =   5
         TabHeight                =   519
         BackColor                =   &H8000000F
         Style                    =   1
         TabOrientation           =   0
         Tabs                     =   5
         TabIndex                 =   3
         TabStop                  =   0
         Height                   =   3615
         Left                     =   240
         Width                    =   12855
         Top                      =   2040
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
         Caption                  =   "1 - Dados Principais"
         Index                    =   0 
         _version                 =   65536
         _extentx                 =   22663
         _extenty                 =   6373
         _stockprops              =   15
         TabCaption(0)            =   "1 - Dados Principais"
         Tab(0).ControlCount=   50
         Tab(0).ControlEnabled=   -1
         Tab(0).Control(0)=   "Label(1)"
         Tab(0).Control(1)=   "labFdo0"
         Tab(0).Control(2)=   "bottxtCampo0(1)"
         Tab(0).Control(3)=   "bottxtCampo0(2)"
         Tab(0).Control(4)=   "txtCp(0)"
         Tab(0).Control(5)=   "Botao(0)"
         Tab(0).Control(6)=   "Label(2)"
         Tab(0).Control(7)=   "Label(3)"
         Tab(0).Control(8)=   "txtCp(1)"
         Tab(0).Control(9)=   "labFdo2"
         Tab(0).Control(10)=   "bottxtCampo2(0)"
         Tab(0).Control(11)=   "txtCp(2)"
         Tab(0).Control(12)=   "Painel(1)"
         Tab(0).Control(13)=   "Label(4)"
         Tab(0).Control(14)=   "Linha(1)"
         Tab(0).Control(15)=   "Label(5)"
         Tab(0).Control(16)=   "Label(6)"
         Tab(0).Control(17)=   "labFdo3"
         Tab(0).Control(18)=   "bottxtCampo3(2)"
         Tab(0).Control(19)=   "txtCp(3)"
         Tab(0).Control(20)=   "Label(7)"
         Tab(0).Control(21)=   "labFdo4"
         Tab(0).Control(22)=   "bottxtCampo4(1)"
         Tab(0).Control(23)=   "bottxtCampo4(2)"
         Tab(0).Control(24)=   "txtCp(4)"
         Tab(0).Control(25)=   "Botao(1)"
         Tab(0).Control(26)=   "Label(8)"
         Tab(0).Control(27)=   "labFdo5"
         Tab(0).Control(28)=   "bottxtCampo5(2)"
         Tab(0).Control(29)=   "txtCp(5)"
         Tab(0).Control(30)=   "Label(9)"
         Tab(0).Control(31)=   "txtCp(6)"
         Tab(0).Control(32)=   "Label(10)"
         Tab(0).Control(33)=   "labFdo7"
         Tab(0).Control(34)=   "bottxtCampo7(2)"
         Tab(0).Control(35)=   "txtCp(7)"
         Tab(0).Control(36)=   "Label(11)"
         Tab(0).Control(37)=   "txtCp(8)"
         Tab(0).Control(38)=   "Label(12)"
         Tab(0).Control(39)=   "txtCp(9)"
         Tab(0).Control(40)=   "Label(13)"
         Tab(0).Control(41)=   "txtCp(10)"
         Tab(0).Control(42)=   "Label(14)"
         Tab(0).Control(43)=   "txtCp(11)"
         Tab(0).Control(44)=   "Label(15)"
         Tab(0).Control(45)=   "txtCp(12)"
         Tab(0).Control(46)=   "Label(16)"
         Tab(0).Control(47)=   "txtCp(13)"
         Tab(0).Control(48)=   "Label(17)"
         Tab(0).Control(49)=   "txtCp(14)"
         TabCaption(1)            =   "2 - Produtos"
         Tab(1).ControlCount=   1
         Tab(1).ControlEnabled=   0
         Tab(1).Control(0)=   "Grid(0)"
         TabCaption(2)            =   "3 - Financeiro / Tributos"
         Tab(2).ControlCount=   64
         Tab(2).ControlEnabled=   0
         Tab(2).Control(0)=   "Label(18)"
         Tab(2).Control(1)=   "labFdo15"
         Tab(2).Control(2)=   "bottxtCampo15(2)"
         Tab(2).Control(3)=   "txtCp(15)"
         Tab(2).Control(4)=   "Label(19)"
         Tab(2).Control(5)=   "labFdo16"
         Tab(2).Control(6)=   "bottxtCampo16(0)"
         Tab(2).Control(7)=   "txtCp(16)"
         Tab(2).Control(8)=   "Label(20)"
         Tab(2).Control(9)=   "labFdo17"
         Tab(2).Control(10)=   "bottxtCampo17(0)"
         Tab(2).Control(11)=   "txtCp(17)"
         Tab(2).Control(12)=   "Label(21)"
         Tab(2).Control(13)=   "labFdo18"
         Tab(2).Control(14)=   "bottxtCampo18(0)"
         Tab(2).Control(15)=   "txtCp(18)"
         Tab(2).Control(16)=   "Label(22)"
         Tab(2).Control(17)=   "labFdo19"
         Tab(2).Control(18)=   "bottxtCampo19(0)"
         Tab(2).Control(19)=   "txtCp(19)"
         Tab(2).Control(20)=   "Label(23)"
         Tab(2).Control(21)=   "labFdo20"
         Tab(2).Control(22)=   "bottxtCampo20(0)"
         Tab(2).Control(23)=   "txtCp(20)"
         Tab(2).Control(24)=   "Label(24)"
         Tab(2).Control(25)=   "labFdo21"
         Tab(2).Control(26)=   "bottxtCampo21(1)"
         Tab(2).Control(27)=   "txtCp(21)"
         Tab(2).Control(28)=   "Label(25)"
         Tab(2).Control(29)=   "labFdo22"
         Tab(2).Control(30)=   "bottxtCampo22(1)"
         Tab(2).Control(31)=   "txtCp(22)"
         Tab(2).Control(32)=   "Label(26)"
         Tab(2).Control(33)=   "labFdo23"
         Tab(2).Control(34)=   "bottxtCampo23(1)"
         Tab(2).Control(35)=   "txtCp(23)"
         Tab(2).Control(36)=   "Label(27)"
         Tab(2).Control(37)=   "labFdo24"
         Tab(2).Control(38)=   "bottxtCampo24(0)"
         Tab(2).Control(39)=   "txtCp(24)"
         Tab(2).Control(40)=   "Label(28)"
         Tab(2).Control(41)=   "labFdo25"
         Tab(2).Control(42)=   "bottxtCampo25(2)"
         Tab(2).Control(43)=   "txtCp(25)"
         Tab(2).Control(44)=   "Label(29)"
         Tab(2).Control(45)=   "labFdo26"
         Tab(2).Control(46)=   "bottxtCampo26(1)"
         Tab(2).Control(47)=   "txtCp(26)"
         Tab(2).Control(48)=   "Label(30)"
         Tab(2).Control(49)=   "Formato(0)"
         Tab(2).Control(50)=   "Label(31)"
         Tab(2).Control(51)=   "Formato(1)"
         Tab(2).Control(52)=   "Label(32)"
         Tab(2).Control(53)=   "Formato(2)"
         Tab(2).Control(54)=   "Label(33)"
         Tab(2).Control(55)=   "Label(34)"
         Tab(2).Control(56)=   "Label(35)"
         Tab(2).Control(57)=   "Formato(3)"
         Tab(2).Control(58)=   "Label(36)"
         Tab(2).Control(59)=   "Formato(4)"
         Tab(2).Control(60)=   "Label(37)"
         Tab(2).Control(61)=   "Formato(5)"
         Tab(2).Control(62)=   "Label(38)"
         Tab(2).Control(63)=   "Grid(1)"
         TabCaption(3)            =   "4 - Dados / NFe"
         Tab(3).ControlCount=   15
         Tab(3).ControlEnabled=   0
         Tab(3).Control(0)=   "Label(39)"
         Tab(3).Control(1)=   "txtCp(27)"
         Tab(3).Control(2)=   "Label(40)"
         Tab(3).Control(3)=   "txtCp(28)"
         Tab(3).Control(4)=   "Label(41)"
         Tab(3).Control(5)=   "txtCp(29)"
         Tab(3).Control(6)=   "Label(42)"
         Tab(3).Control(7)=   "txtCp(30)"
         Tab(3).Control(8)=   "txtCp(31)"
         Tab(3).Control(9)=   "ChkCp(0)"
         Tab(3).Control(10)=   "Label(43)"
         Tab(3).Control(11)=   "labFdo32"
         Tab(3).Control(12)=   "bottxtCampo32(1)"
         Tab(3).Control(13)=   "bottxtCampo32(2)"
         Tab(3).Control(14)=   "txtCp(32)"
         TabCaption(4)            =   "5 - Devolução"
         Tab(4).ControlCount=   2
         Tab(4).ControlEnabled=   0
         Tab(4).Control(0)=   "Grid(2)"
         Tab(4).Control(1)=   "ChkCp(1)"
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   0
            Height                   =   240
            Left                     =   180
            Width                    =   780
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
            Caption                  =   "* CFOP:"
            Index                    =   1 
         End
         Begin VB.Label labFdo0
            Appearance               =  1
            BorderStyle              =  1
            BackColor                =  &H80000005
            Left                     =   1020
            Top                      =   600
            Width                    =   4350
            Height                   =   300
         End
         Begin VB.CommandButton bottxtCampo0
            Style                    =   1
            TabStop                  =   0
            Index                    =   1
            Left                     =   5085
            Top                      =   630
            Width                    =   255
            Height                   =   240
         End
         Begin VB.CommandButton bottxtCampo0
            Style                    =   1
            TabStop                  =   0
            Index                    =   2
            Left                     =   4830
            Top                      =   630
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
            TabIndex                 =   4
            TabStop                  =   -1
            Height                   =   240
            Left                     =   1050
            Width                    =   3765
            Top                      =   630
            DataField                =   "Sequencia da natureza"
            Index                    =   0 
         End
         Begin NFE.GBotao Botao
            ButtonStyle              =   0
            JoinSeparators           =   0
            LeftSeparator            =   0
            TopSeparator             =   0
            TabIndex                 =   20
            TabStop                  =   0
            ButtonType               =   0
            Height                   =   270
            Left                     =   5340
            Width                    =   300
            Top                      =   600
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
            AutoSize                 =   0
            Height                   =   240
            Left                     =   5760
            Width                    =   990
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
            Caption                  =   "*Dt Saida:"
            Index                    =   2 
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   0
            Height                   =   240
            Left                     =   8280
            Width                    =   585
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
            Caption                  =   "Hora:"
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
            BorderStyle              =   1
            Alignment                =   0
            TabIndex                 =   6
            TabStop                  =   -1
            Height                   =   300
            Left                     =   8880
            Width                    =   900
            Top                      =   600
            DataField                =   "Hora da saida"
            Index                    =   1 
         End
         Begin VB.Label labFdo2
            Appearance               =  1
            BorderStyle              =  1
            BackColor                =  &H80000005
            Left                     =   6780
            Top                      =   600
            Width                    =   1380
            Height                   =   300
         End
         Begin VB.CommandButton bottxtCampo2
            Style                    =   1
            TabStop                  =   0
            Index                    =   0
            Left                     =   7875
            Top                      =   630
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
            TabIndex                 =   5
            TabStop                  =   -1
            Height                   =   240
            Left                     =   6810
            Width                    =   1050
            Top                      =   630
            DataField                =   "Data de saida"
            Index                    =   2 
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
            Height                   =   405
            Left                     =   10740
            Width                    =   2070
            Top                      =   540
            TabStop                  =  0
            _extentx                 =   3649
            _extenty                 =   714
            Index                    =   1 
            Begin                VB.Label labopcPainel1
               BorderStyle              =   1
               DataField                =   "Tipo de nota"
               Height                   =   120
               Left                     =   690
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
                  Weight                   =   400
                  Size                     =   9.75
                  Underline                =   0
                  Italic                   =   0
                  StrikeThrough            =   0
               EndProperty
               ForeColor                =   &H80000008
               Alignment                =   2
               TabIndex                 =   16
               TabStop                  =   0
               Height                   =   255
               Left                     =   15
               Width                    =   915
               Top                      =   75
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
               Alignment                =   0
               Caption                  =   "Saida"
               Index                    =   0 
            End
            Begin VB.OptionButton opcPainel1Cp
               Appearance               =   1
               BackColor                =   &H8000000F
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
               Alignment                =   2
               TabIndex                 =   17
               TabStop                  =   0
               Height                   =   255
               Left                     =   975
               Width                    =   1035
               Top                      =   75
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
               Alignment                =   0
               Caption                  =   "Entrada"
               Index                    =   1 
            End
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   -1
            Height                   =   240
            Left                     =   9900
            Width                    =   690
            Top                      =   600
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
            Caption                  =   "* Tipo:"
            Index                    =   4 
         End
         Begin VB.Line Linha
            BorderColor              =   -2147483640
            BorderStyle              =   1
            BorderWidth              =   1
            X1                       =   240
            Y1                       =   1650
            X2                       =   12795
            Y2                       =   1650
            Index                    =   1 
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   -1
            Height                   =   240
            Left                     =   240
            Width                    =   3615
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
            Caption                  =   "Transportador / Volumes Trasnportados"
            Index                    =   5 
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   0
            Height                   =   240
            Left                     =   4800
            Width                    =   1860
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
            Caption                  =   "* Finalidade da NFe:"
            Index                    =   6 
         End
         Begin VB.Label labFdo3
            Appearance               =  1
            BorderStyle              =  1
            BackColor                =  &H80000005
            Left                     =   6780
            Top                      =   1200
            Width                    =   3000
            Height                   =   300
         End
         Begin VB.CommandButton bottxtCampo3
            Style                    =   1
            TabStop                  =   0
            Index                    =   2
            Left                     =   9495
            Top                      =   1230
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
            TabIndex                 =   7
            TabStop                  =   -1
            Height                   =   240
            Left                     =   6810
            Width                    =   2670
            Top                      =   1230
            DataField                =   "Finalidade nfe"
            Index                    =   3 
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   -1
            Height                   =   240
            Left                     =   240
            Width                    =   1155
            Top                      =   1980
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
            Caption                  =   "* Transporte:"
            Index                    =   7 
         End
         Begin VB.Label labFdo4
            Appearance               =  1
            BorderStyle              =  1
            BackColor                =  &H80000005
            Left                     =   1560
            Top                      =   1980
            Width                    =   4980
            Height                   =   300
         End
         Begin VB.CommandButton bottxtCampo4
            Style                    =   1
            TabStop                  =   0
            Index                    =   1
            Left                     =   6255
            Top                      =   2010
            Width                    =   255
            Height                   =   240
         End
         Begin VB.CommandButton bottxtCampo4
            Style                    =   1
            TabStop                  =   0
            Index                    =   2
            Left                     =   6000
            Top                      =   2010
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
            TabIndex                 =   8
            TabStop                  =   -1
            Height                   =   240
            Left                     =   1590
            Width                    =   4395
            Top                      =   2010
            DataField                =   "Sequencia da transportadora"
            Index                    =   4 
         End
         Begin NFE.GBotao Botao
            ButtonStyle              =   0
            JoinSeparators           =   0
            LeftSeparator            =   0
            TopSeparator             =   0
            TabIndex                 =   21
            TabStop                  =   0
            ButtonType               =   0
            Height                   =   270
            Left                     =   6540
            Width                    =   255
            Top                      =   1980
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
            Index                    =   1 
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   0
            Height                   =   240
            Left                     =   6960
            Width                    =   675
            Top                      =   1980
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
            Caption                  =   "* Frete:"
            Index                    =   8 
         End
         Begin VB.Label labFdo5
            Appearance               =  1
            BorderStyle              =  1
            BackColor                =  &H80000005
            Left                     =   7725
            Top                      =   1980
            Width                    =   1650
            Height                   =   300
         End
         Begin VB.CommandButton bottxtCampo5
            Style                    =   1
            TabStop                  =   0
            Index                    =   2
            Left                     =   9090
            Top                      =   2010
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
            TabIndex                 =   9
            TabStop                  =   -1
            Height                   =   240
            Left                     =   7755
            Width                    =   1320
            Top                      =   2010
            DataField                =   "Frete"
            Index                    =   5 
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   -1
            Height                   =   240
            Left                     =   9600
            Width                    =   570
            Top                      =   1980
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
            Caption                  =   "Placa:"
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
            ForeColor                =   &H80000008
            MaxLength                =   8
            BorderStyle              =   1
            Alignment                =   0
            TabIndex                 =   10
            TabStop                  =   -1
            Height                   =   300
            Left                     =   10320
            Width                    =   1170
            Top                      =   1980
            DataField                =   "Placa do veiculo"
            Index                    =   6 
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   0
            Height                   =   240
            Left                     =   11640
            Width                    =   390
            Top                      =   1980
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
         Begin VB.Label labFdo7
            Appearance               =  1
            BorderStyle              =  1
            BackColor                =  &H80000005
            Left                     =   12030
            Top                      =   1980
            Width                    =   615
            Height                   =   300
         End
         Begin VB.CommandButton bottxtCampo7
            Style                    =   1
            TabStop                  =   0
            Index                    =   2
            Left                     =   12360
            Top                      =   2010
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
            TabIndex                 =   11
            TabStop                  =   -1
            Height                   =   240
            Left                     =   12060
            Width                    =   285
            Top                      =   2010
            DataField                =   "Uf do veiculo"
            Index                    =   7 
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   -1
            Height                   =   240
            Left                     =   450
            Width                    =   930
            Top                      =   2460
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
            Caption                  =   "Endereço:"
            Index                    =   11 
         End
         Begin VB.TextBox txtCp
            Appearance               =   0
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
            MaxLength                =   254
            BorderStyle              =   1
            Alignment                =   0
            Locked                   =   -1
            TabIndex                 =   22
            TabStop                  =   0
            Height                   =   300
            Left                     =   1560
            Width                    =   7815
            Top                      =   2460
            TabStop                  =  0
            Index                    =   8 
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   -1
            Height                   =   240
            Left                     =   9585
            Width                    =   585
            Top                      =   2460
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
            Caption                  =   "RG/IE:"
            Index                    =   12 
         End
         Begin VB.TextBox txtCp
            Appearance               =   0
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
            MaxLength                =   254
            BorderStyle              =   1
            Alignment                =   0
            Locked                   =   -1
            TabIndex                 =   23
            TabStop                  =   0
            Height                   =   300
            Left                     =   10320
            Width                    =   2310
            Top                      =   2460
            TabStop                  =  0
            Index                    =   9 
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   -1
            Height                   =   240
            Left                     =   360
            Width                    =   1020
            Top                      =   3000
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
            Caption                  =   "CPF/CNPJ:"
            Index                    =   13 
         End
         Begin VB.TextBox txtCp
            Appearance               =   0
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
            MaxLength                =   254
            BorderStyle              =   1
            Alignment                =   0
            Locked                   =   -1
            TabIndex                 =   24
            TabStop                  =   0
            Height                   =   300
            Left                     =   1560
            Width                    =   1755
            Top                      =   3000
            TabStop                  =  0
            Index                    =   10 
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   0
            Height                   =   240
            Left                     =   3480
            Width                    =   915
            Top                      =   3000
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
            Caption                  =   "Volumes:"
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
            BorderStyle              =   1
            Alignment                =   0
            TabIndex                 =   12
            TabStop                  =   -1
            Height                   =   300
            Left                     =   4440
            Width                    =   840
            Top                      =   3000
            DataField                =   "Volumes"
            Index                    =   11 
            MultiLine                =   -1
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   0
            Height                   =   240
            Left                     =   5460
            Width                    =   780
            Top                      =   3000
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
            Caption                  =   "Especie:"
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
            MaxLength                =   30
            BorderStyle              =   1
            Alignment                =   0
            TabIndex                 =   13
            TabStop                  =   -1
            Height                   =   300
            Left                     =   6420
            Width                    =   1605
            Top                      =   3000
            DataField                =   "Especie"
            Index                    =   12 
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   0
            Height                   =   240
            Left                     =   8160
            Width                    =   1020
            Top                      =   3000
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
            Caption                  =   "P. Liquido:"
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
            BorderStyle              =   1
            Alignment                =   1
            TabIndex                 =   14
            TabStop                  =   -1
            Height                   =   300
            Left                     =   9240
            Width                    =   1290
            Top                      =   3000
            DataField                =   "Peso liquido"
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
            Left                     =   10680
            Width                    =   825
            Top                      =   3000
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
            Caption                  =   "P. Bruto:"
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
            Alignment                =   1
            TabIndex                 =   15
            TabStop                  =   -1
            Height                   =   300
            Left                     =   11505
            Width                    =   1140
            Top                      =   3000
            DataField                =   "Peso bruto"
            Index                    =   14 
            MultiLine                =   -1
         End
         Begin NFE.GListV Grid
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851}
               Name                     =   "Arial"
               CharSet                  =   0
               Weight                   =   400
               Size                     =   9.75
               Underline                =   0
               Italic                   =   0
               StrikeThrough            =   0
            EndProperty
            CellTextColor            =   &H80000008
            EditTextColor            =   &H80000008
            FilterBackColor          =   8454143
            LeftBackColor            =   -2147483633
            MaxBackColor             =   -2147483633
            AvgBackColor             =   -2147483633
            MinBackColor             =   -2147483633
            SumBackColor             =   -2147483633
            StatusBackColor          =   -2147483633
            ColSelectBackColor       =   -2147483633
            CellBackColor            =   -2147483643
            EditBackColor            =   8454143
            SelectBackColor          =   -2147483635
            StripesBackColor         =   13750737
            BackColor                =   -2147483643
            CaptionBackColor         =   -2147483633
            ColHeaderBackColor       =   -2147483633
            GridLinesColor           =   14737632
            FilterTextColor          =   -2147483640
            AvgTextColor             =   16512
            MinTextColor             =   255
            MaxTextColor             =   49152
            StatusTextColor          =   -2147483630
            SumTextColor             =   16711680
            ColTextBackColor         =   12582912
            CellTextColor            =   -2147483640
            SelectTextColor          =   -2147483634
            EditTextColor            =   -2147483640
            StripesTextColor         =   -2147483630
            CaptionTextColor         =   -2147483630
            ColHeaderTextColor       =   -2147483630
            TabIndex                 =   25
            TabStop                  =   -1
            Stripes                  =   0
            SaveGridBars             =   0
            Height                   =   3030
            Left                     =   -74880
            Width                    =   12585
            Top                      =   420
            Caption                  =   "Produtos"
            ShowGridCaption          =   -1
            Index                    =   0 
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   0
            Height                   =   240
            Left                     =   -74460
            Width                    =   2085
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
            Caption                  =   "Forma de Pagamento:"
            Index                    =   18 
         End
         Begin VB.Label labFdo15
            Appearance               =  1
            BorderStyle              =  1
            BackColor                =  &H80000005
            Left                     =   -72300
            Top                      =   600
            Width                    =   1305
            Height                   =   300
         End
         Begin VB.CommandButton bottxtCampo15
            Style                    =   1
            TabStop                  =   0
            Index                    =   2
            Left                     =   -71280
            Top                      =   630
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
            TabIndex                 =   26
            TabStop                  =   -1
            Height                   =   240
            Left                     =   -72270
            Width                    =   990
            Top                      =   630
            DataField                =   "Forma de pagamento"
            Index                    =   15 
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   -1
            Height                   =   240
            Left                     =   -73380
            Width                    =   915
            Top                      =   1080
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
            Caption                  =   "Desconto:"
            Index                    =   19 
         End
         Begin VB.Label labFdo16
            Appearance               =  1
            BorderStyle              =  1
            BackColor                =  &H80000005
            Left                     =   -72300
            Top                      =   1080
            Width                    =   1305
            Height                   =   300
         End
         Begin VB.CommandButton bottxtCampo16
            Style                    =   1
            TabStop                  =   0
            Index                    =   0
            Left                     =   -71280
            Top                      =   1110
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
            TabIndex                 =   27
            TabStop                  =   -1
            Height                   =   240
            Left                     =   -72270
            Width                    =   990
            Top                      =   1110
            DataField                =   "Valor do desconto"
            Index                    =   16 
            MultiLine                =   -1
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   -1
            Height                   =   240
            Left                     =   -73800
            Width                    =   1320
            Top                      =   1560
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
            Caption                  =   "Valor do Frete:"
            Index                    =   20 
         End
         Begin VB.Label labFdo17
            Appearance               =  1
            BorderStyle              =  1
            BackColor                =  &H80000005
            Left                     =   -72300
            Top                      =   1560
            Width                    =   1305
            Height                   =   300
         End
         Begin VB.CommandButton bottxtCampo17
            Style                    =   1
            TabStop                  =   0
            Index                    =   0
            Left                     =   -71280
            Top                      =   1590
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
            TabIndex                 =   28
            TabStop                  =   -1
            Height                   =   240
            Left                     =   -72270
            Width                    =   990
            Top                      =   1590
            DataField                =   "Valor do frete"
            Index                    =   17 
            MultiLine                =   -1
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   -1
            Height                   =   240
            Left                     =   -73560
            Width                    =   1065
            Top                      =   2520
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
            Caption                  =   "Total de IPI:"
            Index                    =   21 
         End
         Begin VB.Label labFdo18
            Appearance               =  1
            BorderStyle              =  1
            BackColor                =  &HE0E0E0
            Left                     =   -72300
            Top                      =   2520
            Width                    =   1305
            Height                   =   300
         End
         Begin VB.CommandButton bottxtCampo18
            Style                    =   1
            TabStop                  =   0
            Index                    =   0
            Left                     =   -71280
            Top                      =   2550
            Width                    =   255
            Height                   =   240
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
            BorderStyle              =   0
            Alignment                =   1
            Locked                   =   -1
            TabIndex                 =   29
            TabStop                  =   0
            Height                   =   240
            Left                     =   -72270
            Width                    =   990
            Top                      =   2550
            DataField                =   "Valor total do ipi"
            TabStop                  =  0
            Index                    =   18 
            MultiLine                =   -1
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   -1
            Height                   =   240
            Left                     =   -74250
            Width                    =   1755
            Top                      =   2040
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
            Caption                  =   "Total dos Produtos:"
            Index                    =   22 
         End
         Begin VB.Label labFdo19
            Appearance               =  1
            BorderStyle              =  1
            BackColor                =  &HE0E0E0
            Left                     =   -72300
            Top                      =   2040
            Width                    =   1305
            Height                   =   300
         End
         Begin VB.CommandButton bottxtCampo19
            Style                    =   1
            TabStop                  =   0
            Index                    =   0
            Left                     =   -71280
            Top                      =   2070
            Width                    =   255
            Height                   =   240
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
            BorderStyle              =   0
            Alignment                =   1
            Locked                   =   -1
            TabIndex                 =   30
            TabStop                  =   0
            Height                   =   240
            Left                     =   -72270
            Width                    =   990
            Top                      =   2070
            DataField                =   "Valor total dos produtos"
            TabStop                  =  0
            Index                    =   19 
            MultiLine                =   -1
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   -1
            Height                   =   240
            Left                     =   -74475
            Width                    =   1980
            Top                      =   3000
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
            Caption                  =   "Total B. Calculo ICMS:"
            Index                    =   23 
         End
         Begin VB.Label labFdo20
            Appearance               =  1
            BorderStyle              =  1
            BackColor                =  &HE0E0E0
            Left                     =   -72300
            Top                      =   3000
            Width                    =   1305
            Height                   =   300
         End
         Begin VB.CommandButton bottxtCampo20
            Style                    =   1
            TabStop                  =   0
            Index                    =   0
            Left                     =   -71280
            Top                      =   3030
            Width                    =   255
            Height                   =   240
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
            BorderStyle              =   0
            Alignment                =   1
            Locked                   =   -1
            TabIndex                 =   31
            TabStop                  =   0
            Height                   =   240
            Left                     =   -72270
            Width                    =   990
            Top                      =   3030
            DataField                =   "Valor total da bc"
            TabStop                  =  0
            Index                    =   20 
            MultiLine                =   -1
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   -1
            Height                   =   240
            Left                     =   -70140
            Width                    =   1320
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
            Caption                  =   "Total do ICMS:"
            Index                    =   24 
         End
         Begin VB.Label labFdo21
            Appearance               =  1
            BorderStyle              =  1
            BackColor                =  &HE0E0E0
            Left                     =   -68640
            Top                      =   600
            Width                    =   1305
            Height                   =   300
         End
         Begin VB.CommandButton bottxtCampo21
            Style                    =   1
            TabStop                  =   0
            Index                    =   1
            Left                     =   -67620
            Top                      =   630
            Width                    =   255
            Height                   =   240
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
            BorderStyle              =   0
            Alignment                =   1
            Locked                   =   -1
            TabIndex                 =   32
            TabStop                  =   0
            Height                   =   240
            Left                     =   -68610
            Width                    =   990
            Top                      =   630
            DataField                =   "Valor total do icms"
            TabStop                  =  0
            Index                    =   21 
            MultiLine                =   -1
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   -1
            Height                   =   240
            Left                     =   -69975
            Width                    =   1155
            Top                      =   1080
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
            Caption                  =   "Total do PIS:"
            Index                    =   25 
         End
         Begin VB.Label labFdo22
            Appearance               =  1
            BorderStyle              =  1
            BackColor                =  &HE0E0E0
            Left                     =   -68640
            Top                      =   1080
            Width                    =   1305
            Height                   =   300
         End
         Begin VB.CommandButton bottxtCampo22
            Style                    =   1
            TabStop                  =   0
            Index                    =   1
            Left                     =   -67620
            Top                      =   1110
            Width                    =   255
            Height                   =   240
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
            BorderStyle              =   0
            Alignment                =   1
            Locked                   =   -1
            TabIndex                 =   33
            TabStop                  =   0
            Height                   =   240
            Left                     =   -68610
            Width                    =   990
            Top                      =   1110
            DataField                =   "Valor total do pis"
            TabStop                  =  0
            Index                    =   22 
            MultiLine                =   -1
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   -1
            Height                   =   240
            Left                     =   -70215
            Width                    =   1395
            Top                      =   1560
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
            Caption                  =   "Total do Cofins:"
            Index                    =   26 
         End
         Begin VB.Label labFdo23
            Appearance               =  1
            BorderStyle              =  1
            BackColor                =  &HE0E0E0
            Left                     =   -68640
            Top                      =   1560
            Width                    =   1305
            Height                   =   300
         End
         Begin VB.CommandButton bottxtCampo23
            Style                    =   1
            TabStop                  =   0
            Index                    =   1
            Left                     =   -67620
            Top                      =   1590
            Width                    =   255
            Height                   =   240
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
            BorderStyle              =   0
            Alignment                =   1
            Locked                   =   -1
            TabIndex                 =   34
            TabStop                  =   0
            Height                   =   240
            Left                     =   -68610
            Width                    =   990
            Top                      =   1590
            DataField                =   "Valor total do cofins"
            TabStop                  =  0
            Index                    =   23 
            MultiLine                =   -1
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   -1
            Height                   =   240
            Left                     =   -70590
            Width                    =   1770
            Top                      =   2040
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
            Caption                  =   "Total B. Calculo ST:"
            Index                    =   27 
         End
         Begin VB.Label labFdo24
            Appearance               =  1
            BorderStyle              =  1
            BackColor                =  &HE0E0E0
            Left                     =   -68640
            Top                      =   2040
            Width                    =   1305
            Height                   =   300
         End
         Begin VB.CommandButton bottxtCampo24
            Style                    =   1
            TabStop                  =   0
            Index                    =   0
            Left                     =   -67620
            Top                      =   2070
            Width                    =   255
            Height                   =   240
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
            BorderStyle              =   0
            Alignment                =   1
            Locked                   =   -1
            TabIndex                 =   35
            TabStop                  =   0
            Height                   =   240
            Left                     =   -68610
            Width                    =   990
            Top                      =   2070
            DataField                =   "Valor total base st"
            TabStop                  =  0
            Index                    =   24 
            MultiLine                =   -1
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   -1
            Height                   =   240
            Left                     =   -70170
            Width                    =   1350
            Top                      =   2520
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
            Caption                  =   "Total ICMS ST:"
            Index                    =   28 
         End
         Begin VB.Label labFdo25
            Appearance               =  1
            BorderStyle              =  1
            BackColor                =  &HE0E0E0
            Left                     =   -68640
            Top                      =   2520
            Width                    =   1305
            Height                   =   300
         End
         Begin VB.CommandButton bottxtCampo25
            Style                    =   1
            TabStop                  =   0
            Index                    =   2
            Left                     =   -67620
            Top                      =   2550
            Width                    =   255
            Height                   =   240
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
            BorderStyle              =   0
            Alignment                =   1
            Locked                   =   -1
            TabIndex                 =   36
            TabStop                  =   0
            Height                   =   240
            Left                     =   -68610
            Width                    =   990
            Top                      =   2550
            DataField                =   "Valor total icms st"
            TabStop                  =  0
            Index                    =   25 
            MultiLine                =   -1
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   -1
            Height                   =   240
            Left                     =   -70500
            Width                    =   1680
            Top                      =   3000
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
            Caption                  =   "Total dos Tributos:"
            Index                    =   29 
         End
         Begin VB.Label labFdo26
            Appearance               =  1
            BorderStyle              =  1
            BackColor                =  &HE0E0E0
            Left                     =   -68640
            Top                      =   3000
            Width                    =   1305
            Height                   =   300
         End
         Begin VB.CommandButton bottxtCampo26
            Style                    =   1
            TabStop                  =   0
            Index                    =   1
            Left                     =   -67620
            Top                      =   3030
            Width                    =   255
            Height                   =   240
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
            BorderStyle              =   0
            Alignment                =   1
            Locked                   =   -1
            TabIndex                 =   37
            TabStop                  =   0
            Height                   =   240
            Left                     =   -68610
            Width                    =   990
            Top                      =   3030
            DataField                =   "Valor total dos tributos"
            TabStop                  =  0
            Index                    =   26 
            MultiLine                =   -1
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   -1
            Height                   =   240
            Left                     =   -66885
            Width                    =   600
            Top                      =   5400
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
            Caption                  =   "Status:"
            Index                    =   30 
         End
         Begin VB.Shape Formato
            FillColor                =   255
            BackColor                =   &HFF
            FillStyle                =   1
            Shape                    =   1
            BackStyle                =   1
            BorderColor              =   -2147483640
            BorderStyle              =   1
            BorderWidth              =   1
            Height                   =   165
            Left                     =   -66210
            Width                    =   180
            Top                      =   5445
            Index                    =   0 
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   -1
            Height                   =   240
            Left                     =   -65985
            Width                    =   990
            Top                      =   5400
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
            Caption                  =   "Incompleto"
            Index                    =   31 
         End
         Begin VB.Shape Formato
            FillColor                =   255
            BackColor                =   &H80FFFF
            FillStyle                =   1
            Shape                    =   1
            BackStyle                =   1
            BorderColor              =   -2147483640
            BorderStyle              =   1
            BorderWidth              =   1
            Height                   =   165
            Left                     =   -64830
            Width                    =   180
            Top                      =   5445
            Index                    =   1 
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   -1
            Height                   =   240
            Left                     =   -64590
            Width                    =   1050
            Top                      =   5400
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
            Caption                  =   "S/ Parcelas"
            Index                    =   32 
         End
         Begin VB.Shape Formato
            FillColor                =   255
            BackColor                =   &H0
            FillStyle                =   1
            Shape                    =   1
            BackStyle                =   1
            BorderColor              =   -2147483640
            BorderStyle              =   1
            BorderWidth              =   1
            Height                   =   150
            Left                     =   -63375
            Width                    =   165
            Top                      =   5445
            Index                    =   2 
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   -1
            Height                   =   240
            Left                     =   -63150
            Width                    =   300
            Top                      =   5400
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
            Caption                  =   "Ok."
            Index                    =   33 
         End
         Begin VB.Label Label
            Appearance               =   0
            BackColor                =   &H0
            BackStyle                =   1
            BorderStyle              =   1
            AutoSize                 =   0
            Height                   =   255
            Left                     =   -66720
            Width                    =   4485
            Top                      =   600
            Alignment                =   2
            BeginProperty Font
               Name                     =   "Microsoft Sans Serif"
               CharSet                  =   0
               Weight                   =   700
               Size                     =   9.75
               Underline                =   0
               Italic                   =   0
               StrikeThrough            =   0
            EndProperty
            ForeColor                =   &HFFFFFF
            Caption                  =   "Parcelamento"
            Index                    =   34 
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   -1
            Height                   =   240
            Left                     =   -66585
            Width                    =   600
            Top                      =   3240
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
            Caption                  =   "Status:"
            Index                    =   35 
         End
         Begin VB.Shape Formato
            FillColor                =   255
            BackColor                =   &HFF
            FillStyle                =   1
            Shape                    =   1
            BackStyle                =   1
            BorderColor              =   -2147483640
            BorderStyle              =   1
            BorderWidth              =   1
            Height                   =   165
            Left                     =   -65910
            Width                    =   165
            Top                      =   3285
            Index                    =   3 
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   -1
            Height                   =   240
            Left                     =   -65685
            Width                    =   990
            Top                      =   3240
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
            Caption                  =   "Incompleto"
            Index                    =   36 
         End
         Begin VB.Shape Formato
            FillColor                =   255
            BackColor                =   &H80FFFF
            FillStyle                =   1
            Shape                    =   1
            BackStyle                =   1
            BorderColor              =   -2147483640
            BorderStyle              =   1
            BorderWidth              =   1
            Height                   =   165
            Left                     =   -64530
            Width                    =   165
            Top                      =   3285
            Index                    =   4 
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   -1
            Height                   =   240
            Left                     =   -64290
            Width                    =   1050
            Top                      =   3240
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
            Caption                  =   "S/ Parcelas"
            Index                    =   37 
         End
         Begin VB.Shape Formato
            FillColor                =   255
            BackColor                =   &H0
            FillStyle                =   1
            Shape                    =   1
            BackStyle                =   1
            BorderColor              =   -2147483640
            BorderStyle              =   1
            BorderWidth              =   1
            Height                   =   150
            Left                     =   -63075
            Width                    =   150
            Top                      =   3285
            Index                    =   5 
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   -1
            Height                   =   240
            Left                     =   -62850
            Width                    =   300
            Top                      =   3240
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
            Caption                  =   "Ok."
            Index                    =   38 
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   0
            Height                   =   240
            Left                     =   -74865
            Width                    =   1695
            Top                      =   660
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
            Caption                  =   "Chave de Acesso:"
            Index                    =   39 
         End
         Begin VB.TextBox txtCp
            Appearance               =   0
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
            MaxLength                =   50
            BorderStyle              =   1
            Alignment                =   0
            Locked                   =   -1
            TabIndex                 =   43
            TabStop                  =   -1
            Height                   =   300
            Left                     =   -73020
            Width                    =   5190
            Top                      =   660
            DataField                =   "Chave de acesso da nfe"
            TabStop                  =  0
            Index                    =   27 
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   0
            Height                   =   240
            Left                     =   -67680
            Width                    =   975
            Top                      =   660
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
            Caption                  =   "Protocolo:"
            Index                    =   40 
         End
         Begin VB.TextBox txtCp
            Appearance               =   0
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
            MaxLength                =   50
            BorderStyle              =   1
            Alignment                =   0
            Locked                   =   -1
            TabIndex                 =   44
            TabStop                  =   -1
            Height                   =   300
            Left                     =   -66600
            Width                    =   4230
            Top                      =   660
            DataField                =   "Protocolo de autorização"
            TabStop                  =  0
            Index                    =   28 
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   0
            Height                   =   240
            Left                     =   -74340
            Width                    =   1230
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
            Caption                  =   "Data e Hora:"
            Index                    =   41 
         End
         Begin VB.TextBox txtCp
            Appearance               =   0
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
            MaxLength                =   25
            BorderStyle              =   1
            Alignment                =   0
            Locked                   =   -1
            TabIndex                 =   45
            TabStop                  =   -1
            Height                   =   300
            Left                     =   -73020
            Width                    =   2490
            Top                      =   1140
            DataField                =   "Data e hora da nfe"
            TabStop                  =  0
            Index                    =   29 
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   0
            Height                   =   240
            Left                     =   -70380
            Width                    =   750
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
            Caption                  =   "Recibo:"
            Index                    =   42 
         End
         Begin VB.TextBox txtCp
            Appearance               =   0
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
            MaxLength                =   20
            BorderStyle              =   1
            Alignment                =   0
            Locked                   =   -1
            TabIndex                 =   46
            TabStop                  =   -1
            Height                   =   300
            Left                     =   -69540
            Width                    =   1710
            Top                      =   1140
            DataField                =   "Numero do recibo"
            TabStop                  =  0
            Index                    =   30 
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
            Alignment                =   0
            Locked                   =   -1
            TabIndex                 =   47
            TabStop                  =   -1
            Height                   =   1440
            Left                     =   -73020
            Width                    =   10650
            Top                      =   1620
            DataField                =   "Observação"
            TabStop                  =  0
            Index                    =   31 
            MultiLine                =   -1
            ScrollBars               =   2
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
            TabIndex                 =   48
            TabStop                  =   -1
            Height                   =   255
            Left                     =   -73020
            Width                    =   2385
            Top                      =   3180
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
            Caption                  =   "NFe Complementar"
            Index                    =   0 
            DataField                =   "Nfe complementar"
         End
         Begin VB.Label Label
            Appearance               =   1
            BackColor                =   &H8000000F
            BackStyle                =   1
            BorderStyle              =   0
            AutoSize                 =   0
            Height                   =   240
            Left                     =   -70560
            Width                    =   2145
            Top                      =   3180
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
            ForeColor                =   &H80
            Caption                  =   "*NFe Referenciada:"
            Index                    =   43 
         End
         Begin VB.Label labFdo32
            Appearance               =  1
            BorderStyle              =  1
            BackColor                =  &H80000005
            Left                     =   -68325
            Top                      =   3180
            Width                    =   5910
            Height                   =   300
         End
         Begin VB.CommandButton bottxtCampo32
            Style                    =   1
            TabStop                  =   0
            Index                    =   1
            Left                     =   -62700
            Top                      =   3210
            Width                    =   255
            Height                   =   240
         End
         Begin VB.CommandButton bottxtCampo32
            Style                    =   1
            TabStop                  =   0
            Index                    =   2
            Left                     =   -62955
            Top                      =   3210
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
            TabIndex                 =   49
            TabStop                  =   -1
            Height                   =   240
            Left                     =   -68295
            Width                    =   5595
            Top                      =   3210
            DataField                =   "Chave nfe referenciada"
            Index                    =   32 
         End
         Begin NFE.GListV Grid
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851}
               Name                     =   "MS Sans Serif"
               CharSet                  =   0
               Weight                   =   400
               Size                     =   8.25
               Underline                =   0
               Italic                   =   0
               StrikeThrough            =   0
            EndProperty
            CellTextColor            =   &H80000008
            EditTextColor            =   &H80000008
            FilterBackColor          =   8454143
            LeftBackColor            =   -2147483633
            MaxBackColor             =   -2147483633
            AvgBackColor             =   -2147483633
            MinBackColor             =   -2147483633
            SumBackColor             =   -2147483633
            StatusBackColor          =   -2147483633
            ColSelectBackColor       =   -2147483633
            CellBackColor            =   -2147483643
            EditBackColor            =   8454143
            SelectBackColor          =   -2147483635
            StripesBackColor         =   13750737
            BackColor                =   -2147483643
            CaptionBackColor         =   -2147483633
            ColHeaderBackColor       =   -2147483633
            GridLinesColor           =   14737632
            FilterTextColor          =   -2147483640
            AvgTextColor             =   16512
            MinTextColor             =   255
            MaxTextColor             =   49152
            StatusTextColor          =   -2147483630
            SumTextColor             =   16711680
            ColTextBackColor         =   12582912
            CellTextColor            =   -2147483640
            SelectTextColor          =   -2147483634
            EditTextColor            =   -2147483640
            StripesTextColor         =   -2147483630
            CaptionTextColor         =   -2147483630
            ColHeaderTextColor       =   -2147483630
            TabIndex                 =   50
            TabStop                  =   -1
            Stripes                  =   0
            SaveGridBars             =   0
            Height                   =   2265
            Left                     =   -66720
            Width                    =   4455
            Top                      =   900
            Caption                  =   ""
            ShowGridCaption          =   0
            Index                    =   1 
         End
         Begin NFE.GListV Grid
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851}
               Name                     =   "Microsoft Sans Serif"
               CharSet                  =   0
               Weight                   =   400
               Size                     =   9.75
               Underline                =   0
               Italic                   =   0
               StrikeThrough            =   0
            EndProperty
            CellTextColor            =   &H80000008
            EditTextColor            =   &H80000008
            FilterBackColor          =   8454143
            LeftBackColor            =   -2147483633
            MaxBackColor             =   -2147483633
            AvgBackColor             =   -2147483633
            MinBackColor             =   -2147483633
            SumBackColor             =   -2147483633
            StatusBackColor          =   -2147483633
            ColSelectBackColor       =   -2147483633
            CellBackColor            =   -2147483643
            EditBackColor            =   8454143
            SelectBackColor          =   -2147483635
            StripesBackColor         =   13750737
            BackColor                =   -2147483643
            CaptionBackColor         =   -2147483633
            ColHeaderBackColor       =   -2147483633
            GridLinesColor           =   14737632
            FilterTextColor          =   -2147483640
            AvgTextColor             =   16512
            MinTextColor             =   255
            MaxTextColor             =   49152
            StatusTextColor          =   -2147483630
            SumTextColor             =   16711680
            ColTextBackColor         =   12582912
            CellTextColor            =   -2147483640
            SelectTextColor          =   -2147483634
            EditTextColor            =   -2147483640
            StripesTextColor         =   -2147483630
            CaptionTextColor         =   -2147483630
            ColHeaderTextColor       =   -2147483630
            TabIndex                 =   53
            TabStop                  =   -1
            Stripes                  =   0
            SaveGridBars             =   0
            Height                   =   2430
            Left                     =   -74880
            Width                    =   12525
            Top                      =   960
            Caption                  =   ""
            ShowGridCaption          =   0
            Index                    =   2 
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
            ForeColor                =   &H80000008
            Alignment                =   0
            TabIndex                 =   54
            TabStop                  =   -1
            Height                   =   255
            Left                     =   -74820
            Width                    =   9225
            Top                      =   480
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
            Alignment                =   0
            Caption                  =   "Devolução (Marque a Caixa ao lado para Incluir a(s) NFe Referenciada (s)"
            Index                    =   1 
            DataField                =   "Devolução"
         End
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   0
         Height                   =   240
         Left                     =   360
         Width                    =   1080
         Top                      =   1500
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
         Index                    =   44 
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
         Alignment                =   0
         Locked                   =   -1
         TabIndex                 =   0
         TabStop                  =   0
         Height                   =   300
         Left                     =   1620
         Width                    =   750
         Top                      =   1500
         DataField                =   "Sequencia da nota fiscal"
         TabStop                  =  0
         Index                    =   33 
         MultiLine                =   -1
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   0
         Height                   =   240
         Left                     =   2520
         Width                    =   1035
         Top                      =   1500
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
         Caption                  =   "* Emissão:"
         Index                    =   45 
      End
      Begin VB.Label labFdo34
         Appearance               =  1
         BorderStyle              =  1
         BackColor                =  &H80000005
         Left                     =   3660
         Top                      =   1500
         Width                    =   1455
         Height                   =   300
      End
      Begin VB.CommandButton bottxtCampo34
         Style                    =   1
         TabStop                  =   0
         Index                    =   0
         Left                     =   4830
         Top                      =   1530
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
         TabIndex                 =   1
         TabStop                  =   -1
         Height                   =   240
         Left                     =   3690
         Width                    =   1125
         Top                      =   1530
         DataField                =   "Data de emissão"
         Index                    =   34 
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   0
         Height                   =   240
         Left                     =   5280
         Width                    =   735
         Top                      =   1500
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
         Caption                  =   "* Geral:"
         Index                    =   46 
      End
      Begin VB.Label labFdo35
         Appearance               =  1
         BorderStyle              =  1
         BackColor                =  &H80000005
         Left                     =   6120
         Top                      =   1500
         Width                    =   6720
         Height                   =   300
      End
      Begin VB.CommandButton bottxtCampo35
         Style                    =   1
         TabStop                  =   0
         Index                    =   1
         Left                     =   12555
         Top                      =   1530
         Width                    =   255
         Height                   =   240
      End
      Begin VB.CommandButton bottxtCampo35
         Style                    =   1
         TabStop                  =   0
         Index                    =   2
         Left                     =   12300
         Top                      =   1530
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
         TabIndex                 =   2
         TabStop                  =   -1
         Height                   =   240
         Left                     =   6150
         Width                    =   6135
         Top                      =   1530
         DataField                =   "Sequencia do geral"
         Index                    =   35 
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   -1
         Height                   =   240
         Left                     =   300
         Width                    =   3150
         Top                      =   5880
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
         Caption                  =   "Informações Complementares:"
         Index                    =   47 
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
         TabIndex                 =   18
         TabStop                  =   0
         Height                   =   1020
         Left                     =   240
         Width                    =   12855
         Top                      =   6240
         DataField                =   "Historico"
         Index                    =   36 
         MultiLine                =   -1
         ScrollBars               =   2
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   -1
         Height                   =   240
         Left                     =   12960
         Width                    =   45
         Top                      =   7980
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
         Index                    =   48 
      End
      Begin NFE.GBotao Botao
         ButtonStyle              =   0
         JoinSeparators           =   0
         LeftSeparator            =   0
         TopSeparator             =   0
         TabIndex                 =   19
         TabStop                  =   0
         ButtonType               =   0
         Height                   =   270
         Left                     =   12840
         Width                    =   240
         Top                      =   1500
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
         Index                    =   2 
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   -1
         Height                   =   240
         Left                     =   255
         Width                    =   600
         Top                      =   7395
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
         Caption                  =   "Status:"
         Index                    =   49 
      End
      Begin VB.Shape Formato
         FillColor                =   255
         BackColor                =   &H0
         FillStyle                =   1
         Shape                    =   1
         BackStyle                =   1
         BorderColor              =   -2147483640
         BorderStyle              =   1
         BorderWidth              =   1
         Height                   =   150
         Left                     =   945
         Width                    =   150
         Top                      =   7440
         Index                    =   6 
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   -1
         Height                   =   240
         Left                     =   1170
         Width                    =   960
         Top                      =   7395
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
         Caption                  =   "Autorizada"
         Index                    =   50 
      End
      Begin VB.Shape Formato
         FillColor                =   255
         BackColor                =   &HFF
         FillStyle                =   1
         Shape                    =   1
         BackStyle                =   1
         BorderColor              =   -2147483640
         BorderStyle              =   1
         BorderWidth              =   1
         Height                   =   165
         Left                     =   2280
         Width                    =   165
         Top                      =   7440
         Index                    =   7 
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   -1
         Height                   =   240
         Left                     =   2505
         Width                    =   990
         Top                      =   7395
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
         Caption                  =   "Cancelada"
         Index                    =   51 
      End
      Begin VB.Shape Formato
         FillColor                =   255
         BackColor                =   &H80FFFF
         FillStyle                =   1
         Shape                    =   1
         BackStyle                =   1
         BorderColor              =   -2147483640
         BorderStyle              =   1
         BorderWidth              =   1
         Height                   =   165
         Left                     =   3645
         Width                    =   165
         Top                      =   7440
         Index                    =   8 
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   -1
         Height                   =   240
         Left                     =   3885
         Width                    =   1185
         Top                      =   7395
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
         Caption                  =   "Não Enviada"
         Index                    =   52 
      End
      Begin VB.Shape Formato
         FillColor                =   -2147483640
         BackColor                =   &HFF00
         FillStyle                =   1
         Shape                    =   1
         BackStyle                =   1
         BorderColor              =   -2147483640
         BorderStyle              =   1
         BorderWidth              =   1
         Height                   =   150
         Left                     =   5205
         Width                    =   150
         Top                      =   7440
         Index                    =   9 
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   -1
         Height                   =   240
         Left                     =   5430
         Width                    =   1170
         Top                      =   7395
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
         Caption                  =   "Transmitindo"
         Index                    =   53 
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &H8000000F
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   0
         Height                   =   240
         Left                     =   9300
         Width                    =   2115
         Top                      =   5880
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
         Caption                  =   "Valor Total da NFe:"
         Index                    =   54 
      End
      Begin VB.Label labFdo37
         Appearance               =  1
         BorderStyle              =  1
         BackColor                =  &HC0FFFF
         Left                     =   11505
         Top                      =   5865
         Width                    =   1575
         Height                   =   300
      End
      Begin VB.CommandButton bottxtCampo37
         Style                    =   1
         TabStop                  =   0
         Index                    =   0
         Left                     =   12795
         Top                      =   5895
         Width                    =   255
         Height                   =   240
      End
      Begin VB.TextBox txtCp
         Appearance               =   1
         BackColor                =   &HC0FFFF
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
         BorderStyle              =   0
         Alignment                =   1
         Locked                   =   -1
         TabIndex                 =   38
         TabStop                  =   0
         Height                   =   240
         Left                     =   11535
         Width                    =   1245
         Top                      =   5895
         DataField                =   "Valor total da nfe"
         TabStop                  =  0
         Index                    =   37 
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
         TabIndex                 =   39
         TabStop                  =   -1
         Height                   =   255
         Left                     =   1620
         Width                    =   2790
         Top                      =   780
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
         Caption                  =   "Não Calcular Tributos"
         Index                    =   2 
         DataField                =   "Nota avulsa"
      End
      Begin NFE.GBotao Botao
         ButtonStyle              =   0
         JoinSeparators           =   0
         LeftSeparator            =   0
         TopSeparator             =   0
         TabIndex                 =   40
         TabStop                  =   0
         ButtonType               =   0
         Height                   =   435
         Left                     =   9660
         Width                    =   1590
         Top                      =   120
         CaptionAlign             =   4
         CaptionOffset            =   50
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851}
            Name                     =   "Microsoft Sans Serif"
            CharSet                  =   0
            Weight                   =   700
            Size                     =   9.75
            Underline                =   0
            Italic                   =   0
            StrikeThrough            =   0
         EndProperty
         ForeColor                =   &H80000012
         Caption                  =   "DANFE"
         Index                    =   3 
      End
      Begin NFE.GBotao Botao
         ButtonStyle              =   0
         JoinSeparators           =   0
         LeftSeparator            =   0
         TopSeparator             =   0
         TabIndex                 =   41
         TabStop                  =   0
         ButtonType               =   0
         Height                   =   435
         Left                     =   9660
         Width                    =   1590
         Top                      =   600
         CaptionAlign             =   4
         CaptionOffset            =   50
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851}
            Name                     =   "Microsoft Sans Serif"
            CharSet                  =   0
            Weight                   =   700
            Size                     =   9.75
            Underline                =   0
            Italic                   =   0
            StrikeThrough            =   0
         EndProperty
         ForeColor                =   &H80000012
         Caption                  =   "Cancelar"
         Index                    =   4 
      End
      Begin VB.TextBox txtCp
         Appearance               =   0
         BackColor                =   &H80000005
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851}
            Name                     =   "Microsoft Sans Serif"
            CharSet                  =   0
            Weight                   =   400
            Size                     =   21.75
            Underline                =   0
            Italic                   =   0
            StrikeThrough            =   0
         EndProperty
         ForeColor                =   &H80000008
         MaxLength                =   254
         BorderStyle              =   1
         Alignment                =   2
         Locked                   =   -1
         TabIndex                 =   42
         TabStop                  =   0
         Height                   =   615
         Left                     =   11340
         Width                    =   1695
         Top                      =   420
         TabStop                  =  0
         Index                    =   38 
         MultiLine                =   -1
      End
      Begin VB.Label Label
         Appearance               =   0
         BackColor                =   &H0
         BackStyle                =   1
         BorderStyle              =   1
         AutoSize                 =   0
         Height                   =   300
         Left                     =   11340
         Width                    =   1695
         Top                      =   120
         Alignment                =   2
         BeginProperty Font
            Name                     =   "Microsoft Sans Serif"
            CharSet                  =   0
            Weight                   =   700
            Size                     =   12
            Underline                =   0
            Italic                   =   0
            StrikeThrough            =   0
         EndProperty
         ForeColor                =   &HFFFFFF
         Caption                  =   "NFe"
         Index                    =   55 
      End
      Begin NFE.GBotao Botao
         ButtonStyle              =   0
         JoinSeparators           =   0
         LeftSeparator            =   0
         TopSeparator             =   0
         TabIndex                 =   51
         TabStop                  =   0
         ButtonType               =   0
         Height                   =   435
         Left                     =   7995
         Width                    =   1590
         Top                      =   120
         CaptionAlign             =   4
         CaptionOffset            =   50
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851}
            Name                     =   "Microsoft Sans Serif"
            CharSet                  =   0
            Weight                   =   700
            Size                     =   9.75
            Underline                =   0
            Italic                   =   0
            StrikeThrough            =   0
         EndProperty
         ForeColor                =   &H80000012
         Caption                  =   "Correção"
         Index                    =   5 
      End
      Begin NFE.GBotao Botao
         ButtonStyle              =   0
         JoinSeparators           =   0
         LeftSeparator            =   0
         TopSeparator             =   0
         TabIndex                 =   52
         TabStop                  =   0
         ButtonType               =   0
         Height                   =   435
         Left                     =   7995
         Width                    =   1590
         Top                      =   600
         CaptionAlign             =   4
         CaptionOffset            =   50
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851}
            Name                     =   "Microsoft Sans Serif"
            CharSet                  =   0
            Weight                   =   700
            Size                     =   9.75
            Underline                =   0
            Italic                   =   0
            StrikeThrough            =   0
         EndProperty
         ForeColor                =   &H80000012
         Caption                  =   "DACCE"
         Index                    =   6 
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
Attribute VB_name = "frmNotafisc"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
'* Sistema...: Emissor de Nota Fiscal Eletronica
'* Empresa...: Ygor Eduardo Dellalio
'* Módulo....: Notafisc
'* Função....: NFe
'* CopyRight.: (C)2016 Ygor Eduardo Dellalio
'* Criação...: GAS-2007 - Gerador Automático de Sistemas
'* Data......: 13/07/2016 13:38:10
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
Dim txtCampo(38) As New FormataCampos             'classe dos campos tipo texto do módulo  
Dim chkCampo(2) As New FormataCampos              'classe dos campos tipo lógico do módulo
Dim opcPainel1(1) As New FormataCampos
Dim Sequencia_da_nota_fiscal As Long, Numero_da_nfe As Long, Data_de_emissao As Variant
Dim Sequencia_do_geral As Long, Sequencia_da_natureza As Integer, Sequencia_da_transportadora As Long
Dim Placa_do_veiculo As String, Uf_do_veiculo As String, Frete As String
Dim Valor_do_frete As Double, Valor_do_desconto As Double, Volumes As Long
Dim Especie As String, Data_de_saida As Variant, Hora_da_saida As Variant
Dim Forma_de_pagamento As String, Historico As String, Valor_total_do_ipi As Double
Dim Valor_total_do_icms As Double, Valor_total_dos_produtos As Double, Valor_total_da_nfe As Double
Dim Tipo_de_nota As Integer, Sequencia_da_classificacao As Long, Nota_cancelada As Boolean
Dim Nota_avulsa As Boolean, XmlAssinado As String, XmlAutorizado As String
Dim Peso_bruto As Double, Peso_liquido As Double, Nfe_complementar As Boolean
Dim Chave_nfe_referenciada As String, Chave_de_acesso_da_nfe As String, Protocolo_de_autorizacao As String
Dim Data_e_hora_da_nfe As String, Transmitido As Boolean, Autorizada As Boolean
Dim Numero_do_recibo As String, Observacao As String, Valor_total_da_bc As Double
Dim Valor_total_do_pis As Double, Valor_total_do_cofins As Double, Valor_total_base_st As Double
Dim Valor_total_icms_st As Double, Imprimiu As Boolean, Valor_total_dos_tributos As Double
Dim Finalidade_nfe As Integer, Devolucao As Boolean, Data_da_Alteracao As Variant
Dim Hora_da_Alteracao As Variant, Usuario_da_Alteracao As String, Ajuste As String
Public lblNota2 As Object, TxtEnderecoTrans As Object, TxtIETrans As Object
Public TxtCnpjTrans As Object, GrdProdutos As Object, lblParcelamento As Object
Public grdParcelamento As Object, lblAjuste As Object, cmdDanfe As Object
Public cmdCancelar As Object, lblNNota As Object, lblNota As Object
Dim Nota_fiscal As New GRecordSet, Produtos_da_nota_fiscal As New GRecordSet, Parcelas_nota_fiscal As New GRecordSet
Dim NFe_devolucao As New GRecordSet

Public Tipo As Byte, MunTransAux As New GRecordset, TransporteAux As New GRecordSet, ProdutoAux  As New GRecordSet
Public ProdutoNCMAux As New GRecordSet, ProdutoUnidadeAux As New GRecordSet

Private Function Filtro() As String
   On Error Resume Next
   Filtro = "[Sequencia da nota fiscal] > 0"
   Filtro = Filtro & " AND [Numero da NFe] > 0 Or ([Data de Emissão] >= " & D(Format(DateAdd("D", -180, Date))) & ")"
End Function

Private Sub Tabs_Click(Index As Integer, PreviousTab As Integer)
   MudaTamCampos Me
End Sub

'evento - quando uma opção for selecionada
Private Sub opcPainel1Cp_Click(Index As Integer)
   If vgPriVez Then Exit Sub
   If opcPainel1(Index).Locked Then
      opcPainel1(Val(labopcPainel1.Caption)).Value = True
   Else      
         labopcPainel1.Caption = Str$(opcPainel1(Index).BookMark)
         LigaFocos Me
         InicializaApelidos COM_TEXTBOX
         ExecutaVisivel
         ExecutaPreValidacao 
         MostraFormulas
         opcPainel1(Index).Change
         Select Case Index
            Case 0
               Tipo = 0
            Case 1
               Tipo = 1
      End Select      
   End If
End Sub


Private Sub RepositionNF()
   On Error Resume Next
   
   TbAuxiliar "Geral", "[Sequencia do Geral] = " & Sequencia_da_Transportadora, TransporteAux
   TbAuxiliar "Municipios", "[Sequencia do Municipio] = " & TransporteAux![Sequencia Do Municipio], MunTransAux
   
   If vgSituacao = ACAO_INCLUINDO Then
      Set Produtos_da_Nota_Fiscal = Nothing
      Set Parcelas_nota_fiscal = Nothing
      Set NFe_devolucao = Nothing
   End If
   
   CarregaTotalizador
   
   Tipo = Tipo_de_Nota
   'Alteração
   lblAlteracao.Caption = Nota_fiscal![Usuario da Alteração] & " " & Nota_fiscal![Data da Alteração] & " " & Nota_fiscal![Hora da Alteração]
  
End Sub

Private Function InfoProdutos(Sequencia_da_nota_fiscal As Long, Sequencia_produto_nota_fiscal As Long, Sequencia_do_produto As Long, _
   Quantidade As Double, Valor_unitario As Double, Valor_total As Double, _
   Valor_do_ipi As Double, Valor_do_icms As Double, Aliquota_do_ipi As Single, _
   Aliquota_do_icms As Single, Percentual_da_reducao As Single, Valor_da_base_de_calculo As Double, _
   Valor_do_pis As Double, Valor_do_cofins As Double, Iva As Double, _
   Base_de_calculo_st As Double, Valor_icms_st As Double, Cfop As Long, _
   Cst As Integer, Aliquota_icms_st As Single, Valor_dos_tributos As Double, Oq As String) As Variant
   
   On Error Resume Next
   
   TbAuxiliar "Produtos", "[Sequencia do Produto] = " & Sequencia_do_Produto, ProdutoAux   
      
   If ProdutoAux.RecordCount = 0 Then Exit Function
   TbAuxiliar "Classificação Fiscal", "[Sequencia da Classificação] = " & ProdutoAux![Sequencia da Classificação] & " AND [Sequencia da Classificação] > 0", ProdutoNCMAux     
   TbAuxiliar "Unidades", "[Sequencia da Unidade] = " & ProdutoAux![Sequencia da Unidade] & " AND [Sequencia da Unidade] > 0", ProdutoUnidadeAux
      
   Select Case Oq
      Case "NCM"
         InfoProdutos = ProdutoNCMAux!NCM      
      Case "Sigla"
         InfoProdutos = ProdutoUnidadeAux![Sigla da Unidade]
      Case "Valor Unitario"      
         InfoProdutos = ProdutoAux![Valor Total]
   End Select

End Function


Private Sub ComandosProdutos(KeyAscii As Integer, Sequencia_da_nota_fiscal As Long, Sequencia_produto_nota_fiscal As Long, Sequencia_do_produto As Long, _
   Quantidade As Double, Valor_unitario As Double, Valor_total As Double, _
   Valor_do_ipi As Double, Valor_do_icms As Double, Aliquota_do_ipi As Single, _
   Aliquota_do_icms As Single, Percentual_da_reducao As Single, Valor_da_base_de_calculo As Double, _
   Valor_do_pis As Double, Valor_do_cofins As Double, Iva As Double, _
   Base_de_calculo_st As Double, Valor_icms_st As Double, Cfop As Long, _
   Cst As Integer, Aliquota_icms_st As Single, Valor_dos_tributos As Double) 'Ação KeyPress
   On Error GoTo DeuErro
   
   If KeyAscii = vbKeyF12 Then
      With grdProdutos
         Select Case .ColumnField(.Col)
            Case "Sequencia do produto"
               seqRegistro = .ColumnValue(.Row + 1, .Col)
               frmProdutos.Show            
         End Select
      End With
    ElseIf KeyAscii = vbKeyF2 Then
       SuperAtualizaProdutos
   End If
   
   DeuErro:
   If Err.Number = 438 Then Err.Number = 0
   If Err.Number <> 0 Then
      MsgBox Err.Description, vbCritical + vbOKOnly, vaTitulo
   End If
End Sub


Private Sub AjustaValores()
   Dim IPIProdutos As New GRecordSet, BaseProdutos As New GRecordSet, ICMSProdutos As New GRecordSet, ValorProdutos As New GRecordSet
   Dim ICMSSTProdutos As New GRecordSet, BaseSTProdutos As New GRecordSet, ValorPIS As New GRecordSet, ValorCOFINS As New GRecordSet
   Dim ValorTributos As New GRecordset, ValorNFe As Currency

   On Error GoTo DeuErro
   
   'Campos Optativos
   vgDb.Execute "Update [Nota Fiscal] Set [Tipo de Nota] = " & Tipo & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal
   
   If vgSituacao = ACAO_EXCLUINDO Then Exit Sub
   
   Set IPIProdutos = vgDb.OpenRecordSet("SELECT SUM([Valor Do IPI]) Total FROM [Produtos da nota fiscal] WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal) 'IPI dos Produtos
   Set ICMSProdutos = vgDb.OpenRecordSet("SELECT SUM([Valor Do ICMS]) Total FROM [Produtos da nota fiscal] WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal) 'ICMS Produtos
   Set ICMSSTProdutos = vgDb.OpenRecordSet("SELECT SUM([Valor icms st]) Total FROM [Produtos da nota fiscal] WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal) 'ICMS ST Produtos
   Set BaseProdutos = vgDb.OpenRecordSet("SELECT SUM([Valor da base de calculo]) Total FROM [Produtos da nota fiscal] WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal)'Base Produtos
   Set BaseSTProdutos = vgDb.OpenRecordSet("SELECT SUM([Base de calculo st]) Total FROM [Produtos da nota fiscal] WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal) 'Base ST Produtos

   Set ValorProdutos = vgDb.OpenRecordSet("SELECT SUM([Produtos da nota fiscal].[Valor Total]) Total " & _
                                          "FROM [Produtos da nota fiscal] INNER JOIN Produtos ON [Produtos da nota fiscal].[Sequencia do produto] = Produtos.[Sequencia do produto] " & _
                                          "WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal) 'Produtos

   Set ValorPIS = vgDb.OpenRecordSet("SELECT SUM([Valor do pis]) PIS From  [Produtos da nota fiscal] WHERE [Sequencia da nota fiscal] = " &  Sequencia_da_nota_fiscal)
   Set ValorCOFINS = vgDb.OpenRecordSet("SELECT SUM([Valor do cofins]) COFINS From  [Produtos da nota fiscal] WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal)                   
   Set ValorTributos = vgdb.OpenRecordset("SELECT SUM([Valor dos Tributos]) Tributos From  [Produtos da nota fiscal] WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal)                                                                                          
   ValorNFe = IPIProdutos!Total + ValorProdutos!Total + Valor_do_frete
   ValorNFe = ValorNFe + ICMSSTProdutos!Total - Valor_do_desconto
   ValorNFe = Format(ValorNFe, "##,###,##0.00")
   
   If Produtos_da_nota_fiscal.RecordCount = 0 Then
      ValorNFe = 0
   End If
 
   'Atualizando
   vgDb.BeginTrans
   vgDb.Execute "Update [Nota fiscal] Set [Valor total do ipi] = " & Substitui(IPIProdutos!Total, ",", ".", SO_UM) & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal ' Total de Ipi
   vgDb.Execute "Update [Nota fiscal] Set [Valor total do icms] = " & Substitui(ICMSProdutos!Total, ",", ".", SO_UM) & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal 'Valor do ICMS
   vgDb.Execute "Update [Nota fiscal] Set [Valor total icms st] = " & Substitui(ICMSSTProdutos!Total, ",", ".", SO_UM) & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal 'Valor do ICMS ST
   vgDb.Execute "Update [Nota fiscal] Set [Valor total da bc] = " & Substitui(BaseProdutos!Total, ",", ".", SO_UM) & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal'Base de Cálculo ICMS
   vgDb.Execute "Update [Nota fiscal] Set [Valor total base st] = " & Substitui(BaseSTProdutos!Total, ",", ".", SO_UM) & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal 'Base de Cálculo ICMS ST
   vgDb.Execute "Update [Nota fiscal] Set [Valor total dos produtos] = " & Substitui(ValorProdutos!Total, ",", ".", SO_UM) & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal 'Produtos 
   vgDb.Execute "Update [Nota fiscal] Set [Valor total da nfe] = " & Substitui(CStr(ValorNFe), ",", ".", SO_UM) & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal'Valor da Nota
   vgDb.Execute "Update [Nota fiscal] Set [Valor total do pis] = " & Substitui(ValorPIS!PIS, ",", ".", SO_UM) & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal 'Valor Total Do PIS
   vgDb.Execute "Update [Nota fiscal] Set [Valor total do cofins] = " & Substitui(ValorCOFINS!COFINS, ",", ".", SO_UM) & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal'Valor Total do COFINS
   vgDb.Execute "Update [Nota fiscal] Set [Valor Total dos Tributos] = " & Substitui(ValorTributos!Tributos, ",", ".", SO_UM) & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal 'Valor Total do Tributo
   vgDb.CommitTrans
   
   If Not Nota_fiscal![Nota avulsa] Then
     If Nota_fiscal![Valor Do frete] > 0 Or Nota_fiscal![Valor Do Desconto] > 0 Then
     RateiaProdutos 'Rateio do frete e desconto
     Else
     AtualizaImposto
     End If
   End If
   
   If Nota_fiscal!Devolução And Not Nota_fiscal![Nfe complementar] And Not Nota_fiscal![Nota avulsa] Then        
      vgDb.Execute "Update [Nota Fiscal] Set [Finalidade Nfe] = 4 WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal
   ElseIf Nota_fiscal![Nfe complementar] And Not Nota_fiscal!Devolução And Not Nota_fiscal![Nota avulsa] Then
      vgDb.Execute "Update [Nota Fiscal] Set [Finalidade Nfe] = 2 WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal 
   ElseIf Not Nota_fiscal![Nfe complementar] And Not Nota_fiscal!Devolução And Not Nota_fiscal![Nota avulsa] Then 
      vgDb.Execute "Update [Nota Fiscal] Set [Finalidade Nfe] = 1 WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal   
   End If 
   
   If Sequencia_da_natureza = 0 And Not Nota_Avulsa Then
      DefineCFOP
   End If
   
   If Devolucao And Not Nota_Avulsa Then
      MontaDevolucao
   End If
                  
   Produtos_da_nota_fiscal.Requery 
   Alteracao
     
DeuErro:
   If Err Then
      MsgBox Err.Descption, vbCritical + vbOKOnly, vaTitulo
      vgDb.RollBackTrans
   End If

End Sub


Private Function ProcessaProdutos(Sequencia_da_nota_fiscal As Long, Sequencia_produto_nota_fiscal As Long, Sequencia_do_produto As Long, _
   Quantidade As Double, Valor_unitario As Double, Valor_total As Double, _
   Valor_do_ipi As Double, Valor_do_icms As Double, Aliquota_do_ipi As Single, _
   Aliquota_do_icms As Single, Percentual_da_reducao As Single, Valor_da_base_de_calculo As Double, _
   Valor_do_pis As Double, Valor_do_cofins As Double, Iva As Double, _
   Base_de_calculo_st As Double, Valor_icms_st As Double, Cfop As Long, _
   Cst As Integer, Aliquota_icms_st As Single, Valor_dos_tributos As Double) As Boolean
   Dim Tributos As Double 
     
   On Error GoTo DeuErro
   
   If Sequencia_produto_nota_fiscal = 0 Then
      Sequencia_produto_nota_fiscal = SuperPegaSequencial("Produtos da nota fiscal", "Sequencia produto nota fiscal") - 1
   End If
       
   vgDb.BeginTrans   
   vgDb.Execute "Update [Produtos da nota fiscal] Set [Valor Total] = " & Substitui(CCur(Round(Quantidade * Valor_Unitario, 2)), ",", ".", SO_UM) & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal & " AND [Sequencia produto nota fiscal] = " & Sequencia_Produto_nota_fiscal
   
   If Not Nota_Fiscal![Nota avulsa] Then 'Se não for Orçamento Avulso fazer o Calculo Automatico
    If Not Parametros_da_nfe![Simples nacional] Then   
      vgDb.Execute "Update [Produtos da nota fiscal] Set Cst = " & Substitui(CalculaImposto(Sequencia_do_Produto, Nota_fiscal![Sequencia Do geral], 5, Quantidade * Valor_Unitario, 0,0), ",", ".", SO_UM) & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal & " AND [Sequencia produto nota fiscal] = " & Sequencia_produto_nota_fiscal 'CST
      vgDb.Execute "Update [Produtos da nota fiscal] Set Cfop = " & Substitui(CalculaImposto(Sequencia_do_Produto, Nota_fiscal![Sequencia Do geral], 1, Quantidade * Valor_Unitario, 0,0), ",", ".", SO_UM) & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal & " AND [Sequencia produto nota fiscal] = " & Sequencia_produto_nota_fiscal 'CFOP
      vgDb.Execute "Update [Produtos da nota fiscal] Set [Valor da base de calculo] = " & Substitui(CalculaImposto(Sequencia_do_Produto, Nota_fiscal![Sequencia Do geral], 6, Quantidade * Valor_Unitario, 0,0), ",", ".", SO_UM) & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal & " AND [Sequencia produto nota fiscal] = " & Sequencia_produto_nota_fiscal 'Base de Cálculo
      vgDb.Execute "Update [Produtos da nota fiscal] Set [Valor do icms] = " & Substitui(CalculaImposto(Sequencia_do_Produto, Nota_fiscal![Sequencia Do geral], 7, Quantidade * Valor_Unitario, 0,0), ",", ".", SO_UM) & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal & " AND [Sequencia produto nota fiscal] = " & Sequencia_produto_nota_fiscal 'Valor do ICMS
      Tributos = Tributos + CalculaImposto(Sequencia_do_Produto, Nota_fiscal![Sequencia Do geral], 7, Quantidade * Valor_Unitario, 0,0)
      vgDb.Execute "Update [Produtos da nota fiscal] Set [Aliquota do icms] = " & Substitui(CalculaImposto(Sequencia_do_Produto, Nota_fiscal![Sequencia Do geral], 2, Quantidade * Valor_Unitario, 0,0), ",", ".", SO_UM) & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal & " AND [Sequencia produto nota fiscal] = " & Sequencia_produto_nota_fiscal 'Alíquota do ICMS
      vgDb.Execute "Update [Produtos da nota fiscal] Set Iva = " & Substitui(CalculaImposto(Sequencia_do_Produto, Nota_fiscal![Sequencia Do geral], 10, Quantidade * Valor_Unitario, 0, 0), ",", ".", SO_UM) & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal & " AND [Sequencia produto nota fiscal] = " & Sequencia_produto_nota_fiscal 'IVA
      vgDb.Execute "Update [Produtos da nota fiscal] Set [Base de calculo st] = " & Substitui(CalculaImposto(Sequencia_do_Produto, Nota_fiscal![Sequencia Do geral], 11, Quantidade * Valor_Unitario, 0,0), ",", ".", SO_UM) & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal & " AND [Sequencia produto nota fiscal] = " & Sequencia_produto_nota_fiscal 'Base de Cálculo ST
      vgDb.Execute "Update [Produtos da nota fiscal] Set [Valor icms st] = " & Substitui(CalculaImposto(Sequencia_do_Produto, Nota_fiscal![Sequencia Do geral], 12, Quantidade * Valor_Unitario,0,0), ",", ".", SO_UM) & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal & " AND [Sequencia produto nota fiscal] = " & Sequencia_produto_nota_fiscal 'Valor do ICMS ST
      vgDb.Execute "Update [Produtos da nota fiscal] Set [Aliquota icms st] = " & Substitui(CalculaImposto(Sequencia_do_Produto, Nota_fiscal![Sequencia Do geral], 13, Quantidade * Valor_Unitario,0,0), ",", ".", SO_UM) & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal & " AND [Sequencia produto nota fiscal] = " & Sequencia_produto_nota_fiscal 'Alíquota do ICMS ST
      vgDb.Execute "Update [Produtos da nota fiscal] Set [Valor do ipi] = " & Substitui(CalculaImposto(Sequencia_do_Produto, Nota_fiscal![Sequencia Do geral],4, Quantidade * Valor_Unitario,0,0), ",", ".", SO_UM) & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal & " AND [Sequencia produto nota fiscal] = " & Sequencia_produto_nota_fiscal 'Valor do IPI
      Tributos = Tributos + CalculaImposto(Sequencia_do_Produto, Nota_fiscal![Sequencia Do geral], 4, Quantidade * Valor_Unitario, 0, 0)
      vgDb.Execute "Update [Produtos da nota fiscal] Set [Aliquota do ipi] = " & Substitui(CalculaImposto(Sequencia_do_Produto, Nota_fiscal![Sequencia Do geral], 3, Quantidade * Valor_Unitario, 0,0), ",", ".", SO_UM) & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal & " AND [Sequencia produto nota fiscal] = " & Sequencia_produto_nota_fiscal 'Alíquota do IPI
      vgDb.Execute "Update [Produtos da nota fiscal] Set [Valor do pis] = " & Substitui(CalculaImposto(Sequencia_do_Produto, Nota_fiscal![Sequencia Do geral], 8, Quantidade * Valor_Unitario, 0,0), ",", ".", SO_UM) & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal & " AND [Sequencia produto nota fiscal] = " & Sequencia_produto_nota_fiscal 'PIS
      Tributos = Tributos + CalculaImposto(Sequencia_do_Produto, Nota_fiscal![Sequencia Do geral], 8, Quantidade * Valor_Unitario, 0,0)
      vgDb.Execute "Update [Produtos da nota fiscal] Set [Valor do cofins] = " & Substitui(CalculaImposto(Sequencia_do_Produto, Nota_fiscal![Sequencia Do geral], 9, Quantidade * Valor_Unitario, 0,0), ",", ".", SO_UM) & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal & " AND [Sequencia produto nota fiscal] = " & Sequencia_produto_nota_fiscal 'COFINS
      Tributos = Tributos + CalculaImposto(Sequencia_do_Produto, Nota_fiscal![Sequencia Do geral], 9, Quantidade * Valor_Unitario, 0,0)
      Tributos = Tributos + CalculaImposto(Sequencia_do_Produto, Nota_fiscal![Sequencia Do geral], 12, Quantidade * Valor_Unitario, 0,0)
      vgdb.Execute "Update [Produtos da nota fiscal] Set [Valor dos tributos] = " & Substitui(CStr(Tributos), ",", ".", SO_UM) & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal & " AND [Sequencia produto nota fiscal] = " & Sequencia_produto_nota_fiscal 'Tributos
    Else
      vgDb.Execute "Update [Produtos da nota fiscal] Set Cst = " & Substitui(CalculaSimplesNacional(Sequencia_do_Produto, Nota_fiscal![Sequencia Do geral], 5, Quantidade * Valor_Unitario, 0,0), ",", ".", SO_UM) & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal & " AND [Sequencia produto nota fiscal] = " & Sequencia_produto_nota_fiscal 'CST
      vgDb.Execute "Update [Produtos da nota fiscal] Set Cfop = " & Substitui(CalculaSimplesNacional(Sequencia_do_Produto, Nota_fiscal![Sequencia Do geral], 1, Quantidade * Valor_Unitario, 0,0), ",", ".", SO_UM) & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal & " AND [Sequencia produto nota fiscal] = " & Sequencia_produto_nota_fiscal 'CFOP
      vgDb.Execute "Update [Produtos da nota fiscal] Set [Valor da base de calculo] = " & Substitui(CalculaSimplesNacional(Sequencia_do_Produto, Nota_fiscal![Sequencia Do geral], 6, Quantidade * Valor_Unitario, 0,0), ",", ".", SO_UM) & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal & " AND [Sequencia produto nota fiscal] = " & Sequencia_produto_nota_fiscal 'Base de Cálculo
      vgDb.Execute "Update [Produtos da nota fiscal] Set [Valor do icms] = " & Substitui(CalculaSimplesNacional(Sequencia_do_Produto, Nota_fiscal![Sequencia Do geral], 7, Quantidade * Valor_Unitario, 0,0), ",", ".", SO_UM) & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal & " AND [Sequencia produto nota fiscal] = " & Sequencia_produto_nota_fiscal 'Valor do ICMS
      Tributos = Tributos + CalculaSimplesNacional(Sequencia_do_Produto, Nota_fiscal![Sequencia Do geral], 7, Quantidade * Valor_Unitario, 0,0)
      vgDb.Execute "Update [Produtos da nota fiscal] Set [Aliquota do icms] = " & Substitui(CalculaSimplesNacional(Sequencia_do_Produto, Nota_fiscal![Sequencia Do geral], 2, Quantidade * Valor_Unitario, 0,0), ",", ".", SO_UM) & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal & " AND [Sequencia produto nota fiscal] = " & Sequencia_produto_nota_fiscal 'Alíquota do ICMS
      vgDb.Execute "Update [Produtos da nota fiscal] Set Iva = " & Substitui(CalculaSimplesNacional(Sequencia_do_Produto, Nota_fiscal![Sequencia Do geral], 10, Quantidade * Valor_Unitario, 0, 0), ",", ".", SO_UM) & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal & " AND [Sequencia produto nota fiscal] = " & Sequencia_produto_nota_fiscal 'IVA
      vgDb.Execute "Update [Produtos da nota fiscal] Set [Base de calculo st] = " & Substitui(CalculaSimplesNacional(Sequencia_do_Produto, Nota_fiscal![Sequencia Do geral], 11, Quantidade * Valor_Unitario, 0,0), ",", ".", SO_UM) & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal & " AND [Sequencia produto nota fiscal] = " & Sequencia_produto_nota_fiscal 'Base de Cálculo ST
      vgDb.Execute "Update [Produtos da nota fiscal] Set [Valor icms st] = " & Substitui(CalculaSimplesNacional(Sequencia_do_Produto, Nota_fiscal![Sequencia Do geral], 12, Quantidade * Valor_Unitario,0,0), ",", ".", SO_UM) & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal & " AND [Sequencia produto nota fiscal] = " & Sequencia_produto_nota_fiscal 'Valor do ICMS ST
      vgDb.Execute "Update [Produtos da nota fiscal] Set [Aliquota icms st] = " & Substitui(CalculaSimplesNacional(Sequencia_do_Produto, Nota_fiscal![Sequencia Do geral], 13, Quantidade * Valor_Unitario,0,0), ",", ".", SO_UM) & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal & " AND [Sequencia produto nota fiscal] = " & Sequencia_produto_nota_fiscal 'Alíquota do ICMS ST
      vgDb.Execute "Update [Produtos da nota fiscal] Set [Valor do ipi] = " & Substitui(CalculaSimplesNacional(Sequencia_do_Produto, Nota_fiscal![Sequencia Do geral],4, Quantidade * Valor_Unitario,0,0), ",", ".", SO_UM) & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal & " AND [Sequencia produto nota fiscal] = " & Sequencia_produto_nota_fiscal 'Valor do IPI
      Tributos = Tributos + CalculaSimplesNacional(Sequencia_do_Produto, Nota_fiscal![Sequencia Do geral], 4, Quantidade * Valor_Unitario, 0, 0)
      vgDb.Execute "Update [Produtos da nota fiscal] Set [Aliquota do ipi] = " & Substitui(CalculaSimplesNacional(Sequencia_do_Produto, Nota_fiscal![Sequencia Do geral], 3, Quantidade * Valor_Unitario, 0,0), ",", ".", SO_UM) & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal & " AND [Sequencia produto nota fiscal] = " & Sequencia_produto_nota_fiscal 'Alíquota do IPI
      vgDb.Execute "Update [Produtos da nota fiscal] Set [Valor do pis] = " & Substitui(CalculaSimplesNacional(Sequencia_do_Produto, Nota_fiscal![Sequencia Do geral], 8, Quantidade * Valor_Unitario, 0,0), ",", ".", SO_UM) & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal & " AND [Sequencia produto nota fiscal] = " & Sequencia_produto_nota_fiscal 'PIS
      Tributos = Tributos + CalculaSimplesNacional(Sequencia_do_Produto, Nota_fiscal![Sequencia Do geral], 8, Quantidade * Valor_Unitario, 0,0)
      vgDb.Execute "Update [Produtos da nota fiscal] Set [Valor do cofins] = " & Substitui(CalculaSimplesNacional(Sequencia_do_Produto, Nota_fiscal![Sequencia Do geral], 9, Quantidade * Valor_Unitario, 0,0), ",", ".", SO_UM) & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal & " AND [Sequencia produto nota fiscal] = " & Sequencia_produto_nota_fiscal 'COFINS
      Tributos = Tributos + CalculaSimplesNacional(Sequencia_do_Produto, Nota_fiscal![Sequencia Do geral], 9, Quantidade * Valor_Unitario, 0,0)
      Tributos = Tributos + CalculaSimplesNacional(Sequencia_do_Produto, Nota_fiscal![Sequencia Do geral], 12, Quantidade * Valor_Unitario, 0,0)
      vgdb.Execute "Update [Produtos da nota fiscal] Set [Valor dos tributos] = " & Substitui(CStr(Tributos), ",", ".", SO_UM) & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal & " AND [Sequencia produto nota fiscal] = " & Sequencia_produto_nota_fiscal 'Tributos
    End If 
   End If 'Caso Contrario Vamos deixar o Usuario Digitar os Valores
   vgDb.CommitTrans
            
DeuErro:
   If Err.Number <> 0 Then
      MsgBox Err.Description, vbCritical + vbOKOnly, vaTitulo
      vgDb.RollBackTrans
   End If
End Function


Private Sub RateiaProdutos()
   Dim Tributos As Double, ValorFrete As Double, ValorDesc As Double, TbNotaFiscal As New GRecordSet
   Dim TotalProdutos As Double, PercentualDesc As Double, VrItem As Double
   Dim PercentualFrete As Double, Geral As New GRecordSet, GRevenda As Boolean 
         
   Screen.MousePointer = vbHourglass
   
   If Nota_fiscal![Valor Do desconto] = 0 And Nota_fiscal![Valor Do frete] = 0  Then GoTo SaiDaSub
         
   If Produtos_da_nota_fiscal.RecordCount > 0 Then
   Set TbNotaFiscal = VgDb.OpenRecordSet("SELECT * From [Nota fiscal] Where [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal)    
   
   Produtos_da_nota_fiscal.MoveFirst
    Do While Not  Produtos_da_nota_fiscal.EOF
       Tributos = 0
       With Produtos_da_nota_fiscal
       .Edit
         'Valor do Desconto e frete Rateado entre os produtos
            Set Geral = VgDb.OpenRecordSet("SELECT * From Geral Where [Sequencia Do Geral] = " & Nota_fiscal![Sequencia Do geral])
            GRevenda = Not(Geral![Consumidor Final]) 
            TotalProdutos = TbNotaFiscal![Valor total dos produtos]
            PercentualDesc = (Nota_fiscal![Valor Do desconto] / TotalProdutos * 100)
            VrItem = Produtos_da_nota_fiscal![Valor Total] 
            ValorDesc = (VrItem * PercentualDesc / 100)' Valor do Desconto
            
            'Valor do Frete Rateado entre os Produtos 
            If Nota_fiscal![Valor Do frete] > 0  Then  
            PercentualFrete = (Nota_fiscal![Valor Do frete] / TotalProdutos * 100)   
            ValorFrete = (VrItem * PercentualFrete / 100)'Valor do Frete 
            Else
            ValorFrete = 0
            End If 
            If Not Parametros_da_nfe![Simples nacional] Then 
            ![Valor da base de calculo] =  CalculaImposto(![Sequencia Do Produto], Nota_fiscal![Sequencia Do geral], 6, !Quantidade * ![Valor Unitario], ValorFrete, ValorDesc)
            !Cst = CalculaImposto(![Sequencia Do Produto], Nota_fiscal![Sequencia Do geral], 5, !Quantidade * ![Valor Unitario], ValorFrete, ValorDesc) 'CST
            !Cfop = CalculaImposto(![Sequencia Do Produto], Nota_fiscal![Sequencia Do geral], 1, !Quantidade * ![Valor Unitario], ValorFrete, ValorDesc) 'Cfop
            !Iva = CalculaImposto(![Sequencia Do Produto], Nota_fiscal![Sequencia Do geral], 10, !Quantidade * ![Valor Unitario], ValorFrete, ValorDesc)
            ![Valor Do icms] = CalculaImposto(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral] , 7, !Quantidade * ![Valor Unitario], ValorFrete, ValorDesc)
            Tributos = Tributos + CalculaImposto(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral] , 7, !Quantidade * ![Valor Unitario], ValorFrete, ValorDesc)
            ![Aliquota Do icms] = CalculaImposto(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral] , 2, !Quantidade * ![Valor Unitario], ValorFrete, ValorDesc)
            ![Valor Do ipi] = CalculaImposto(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral], 4, !Quantidade * ![Valor Unitario], ValorFrete, ValorDesc)
             Tributos = Tributos + CalculaImposto(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral], 4, !Quantidade * ![Valor Unitario], ValorFrete, ValorDesc)
            ![Aliquota Do Ipi] = CalculaImposto(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral], 3, !Quantidade * ![Valor Unitario], ValorFrete, ValorDesc)
            ![Valor Do pis] = CalculaImposto(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral], 8, !Quantidade * ![Valor Unitario], ValorFrete, ValorDesc)
             Tributos = Tributos + CalculaImposto(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral], 8, !Quantidade * ![Valor Unitario], ValorFrete, ValorDesc)
            ![Valor Do cofins] = CalculaImposto(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral], 9, !Quantidade * ![Valor Unitario], ValorFrete, ValorDesc)
             Tributos = Tributos + CalculaImposto(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral], 9, !Quantidade * ![Valor Unitario], ValorFrete, ValorDesc)
            ![Base de calculo st] = CalculaImposto(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral], 11, !Quantidade * ![Valor Unitario], ValorFrete, ValorDesc)
            ![Valor icms st] = CalculaImposto(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral], 12, !Quantidade * ![Valor Unitario], ValorFrete, ValorDesc)
            ![Aliquota icms st] = CalculaImposto(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral], 13, !Quantidade * ![Valor Unitario], ValorFrete, ValorDesc)
             Tributos = Tributos + CalculaImposto(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral], 12, !Quantidade * ![Valor Unitario], ValorFrete, ValorDesc)
            ![Valor dos Tributos] = Tributos 'Tributos
            Else
            ![Valor da base de calculo] =  CalculaSimplesNacional(![Sequencia Do Produto], Nota_fiscal![Sequencia Do geral], 6, !Quantidade * ![Valor Unitario], ValorFrete, ValorDesc)
            !Cst = CalculaSimplesNacional(![Sequencia Do Produto], Nota_fiscal![Sequencia Do geral], 5, !Quantidade * ![Valor Unitario], ValorFrete, ValorDesc) 'CST
            !Cfop = CalculaSimplesNacional(![Sequencia Do Produto], Nota_fiscal![Sequencia Do geral], 1, !Quantidade * ![Valor Unitario], ValorFrete, ValorDesc) 'Cfop
            !Iva = CalculaSimplesNacional(![Sequencia Do Produto], Nota_fiscal![Sequencia Do geral], 10, !Quantidade * ![Valor Unitario], ValorFrete, ValorDesc)
            ![Valor Do icms] = CalculaSimplesNacional(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral] , 7, !Quantidade * ![Valor Unitario], ValorFrete, ValorDesc)
            Tributos = Tributos + CalculaSimplesNacional(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral] , 7, !Quantidade * ![Valor Unitario], ValorFrete, ValorDesc)
            ![Aliquota Do icms] = CalculaSimplesNacional(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral] , 2, !Quantidade * ![Valor Unitario], ValorFrete, ValorDesc)
            ![Valor Do ipi] = CalculaSimplesNacional(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral], 4, !Quantidade * ![Valor Unitario], ValorFrete, ValorDesc)
             Tributos = Tributos + CalculaSimplesNacional(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral], 4, !Quantidade * ![Valor Unitario], ValorFrete, ValorDesc)
            ![Aliquota Do Ipi] = CalculaSimplesNacional(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral], 3, !Quantidade * ![Valor Unitario], ValorFrete, ValorDesc)
            ![Valor Do pis] = CalculaSimplesNacional(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral], 8, !Quantidade * ![Valor Unitario], ValorFrete, ValorDesc)
             Tributos = Tributos + CalculaSimplesNacional(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral], 8, !Quantidade * ![Valor Unitario], ValorFrete, ValorDesc)
            ![Valor Do cofins] = CalculaSimplesNacional(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral], 9, !Quantidade * ![Valor Unitario], ValorFrete, ValorDesc)
             Tributos = Tributos + CalculaSimplesNacional(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral], 9, !Quantidade * ![Valor Unitario], ValorFrete, ValorDesc)
            ![Base de calculo st] = CalculaSimplesNacional(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral], 11, !Quantidade * ![Valor Unitario], ValorFrete, ValorDesc)
            ![Valor icms st] = CalculaSimplesNacional(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral], 12, !Quantidade * ![Valor Unitario], ValorFrete, ValorDesc)
            ![Aliquota icms st] = CalculaSimplesNacional(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral], 13, !Quantidade * ![Valor Unitario], ValorFrete, ValorDesc)
             Tributos = Tributos + CalculaSimplesNacional(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral], 12, !Quantidade * ![Valor Unitario], ValorFrete, ValorDesc)
            ![Valor dos Tributos] = Tributos 'Tributos
            End If
            .Update
            .BookMark = .LastModified
            .MoveNext
         End With
      Loop
      AjustaTotais
      grdProdutos.ReBind 'Atualiza do Grid
      Reposition True    'Atualiza o Formulário 
     End If 
     If Produtos_da_nota_fiscal.RecordCount = 0 Then
        vgDb.BeginTrans   
        vgDb.Execute "Update [Nota fiscal] Set [Valor do frete] = 0 WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal
        vgDb.Execute "Update [Nota fiscal] Set [Valor do desconto] = 0 WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal
        vgDb.CommitTrans
     End If
          
SaiDaSub:
   Screen.MousePointer = vbDefault

End Sub

Private Sub AtualizaImposto()
   Dim Tributos As Double
         
   Screen.MousePointer = vbHourglass
   
  If Produtos_da_nota_fiscal.RecordCount > 0 Then      
   Produtos_da_nota_fiscal.MoveFirst
    Do While Not  Produtos_da_nota_fiscal.EOF
       Tributos = 0
       With Produtos_da_nota_fiscal
       .Edit
          If Not Parametros_da_nfe![Simples nacional] Then
            !Cst = CalculaImposto(![Sequencia Do Produto], Nota_fiscal![Sequencia Do geral], 5, !Quantidade * ![Valor Unitario], 0,0) 'CST
            !Cfop = CalculaImposto(![Sequencia Do Produto], Nota_fiscal![Sequencia Do geral], 1, !Quantidade * ![Valor Unitario], 0,0) 'Cfop
            !Iva = CalculaImposto(![Sequencia Do Produto], Nota_fiscal![Sequencia Do geral], 10, !Quantidade * ![Valor Unitario], 0,0)
            ![Valor da base de calculo] = CalculaImposto(![Sequencia Do Produto], Nota_fiscal![Sequencia Do geral], 6, !Quantidade * ![Valor Unitario], 0,0)
            ![Valor Do icms] = CalculaImposto(![Sequencia Do Produto], Nota_fiscal![Sequencia Do geral], 7, !Quantidade * ![Valor Unitario], 0,0)
            Tributos = Tributos + CalculaImposto(![Sequencia Do Produto], Nota_fiscal![Sequencia Do geral], 7, !Quantidade * ![Valor Unitario], 0,0)
            ![Aliquota Do icms] = CalculaImposto(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral] , 2, !Quantidade * ![Valor Unitario],0,0)
            ![Valor Do ipi] = CalculaImposto(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral], 4, !Quantidade * ![Valor Unitario], 0,0)
             Tributos = Tributos + CalculaImposto(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral], 4, !Quantidade * ![Valor Unitario], 0,0)
            ![Aliquota Do Ipi] = CalculaImposto(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral], 3, !Quantidade * ![Valor Unitario], 0,0)
            ![Valor Do pis] = CalculaImposto(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral], 8, !Quantidade * ![Valor Unitario], 0,0)
             Tributos = Tributos + CalculaImposto(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral], 8, !Quantidade * ![Valor Unitario], 0,0)
            ![Valor Do cofins] = CalculaImposto(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral], 9, !Quantidade * ![Valor Unitario], 0,0)
             Tributos = Tributos + CalculaImposto(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral], 9, !Quantidade * ![Valor Unitario], 0,0)
            ![Base de calculo st] = CalculaImposto(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral], 11, !Quantidade * ![Valor Unitario], 0,0)
            ![Valor icms st] = CalculaImposto(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral], 12, !Quantidade * ![Valor Unitario], 0,0)
             Tributos = Tributos + CalculaImposto(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral], 12, !Quantidade * ![Valor Unitario], 0,0)
             ![Aliquota icms st] = CalculaImposto(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral], 13, !Quantidade * ![Valor Unitario], 0,0) 
            ![Valor dos Tributos] = Tributos 'Tributos
           Else
            !Cst = CalculaSimplesNacional(![Sequencia Do Produto], Nota_fiscal![Sequencia Do geral], 5, !Quantidade * ![Valor Unitario], 0,0) 'CST
            !Cfop = CalculaSimplesNacional(![Sequencia Do Produto], Nota_fiscal![Sequencia Do geral], 1, !Quantidade * ![Valor Unitario], 0,0) 'Cfop
            !Iva = CalculaSimplesNacional(![Sequencia Do Produto], Nota_fiscal![Sequencia Do geral], 10, !Quantidade * ![Valor Unitario], 0,0)
            ![Valor da base de calculo] = CalculaSimplesNacional(![Sequencia Do Produto], Nota_fiscal![Sequencia Do geral], 6, !Quantidade * ![Valor Unitario], 0,0)
            ![Valor Do icms] = CalculaSimplesNacional(![Sequencia Do Produto], Nota_fiscal![Sequencia Do geral], 7, !Quantidade * ![Valor Unitario], 0,0)
            Tributos = Tributos + CalculaSimplesNacional(![Sequencia Do Produto], Nota_fiscal![Sequencia Do geral], 7, !Quantidade * ![Valor Unitario], 0,0)
            ![Aliquota Do icms] = CalculaSimplesNacional(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral] , 2, !Quantidade * ![Valor Unitario],0,0)
            ![Valor Do ipi] = CalculaSimplesNacional(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral], 4, !Quantidade * ![Valor Unitario], 0,0)
             Tributos = Tributos + CalculaSimplesNacional(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral], 4, !Quantidade * ![Valor Unitario], 0,0)
            ![Aliquota Do Ipi] = CalculaSimplesNacional(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral], 3, !Quantidade * ![Valor Unitario], 0,0)
            ![Valor Do pis] = CalculaSimplesNacional(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral], 8, !Quantidade * ![Valor Unitario], 0,0)
             Tributos = Tributos + CalculaSimplesNacional(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral], 8, !Quantidade * ![Valor Unitario], 0,0)
            ![Valor Do cofins] = CalculaSimplesNacional(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral], 9, !Quantidade * ![Valor Unitario], 0,0)
             Tributos = Tributos + CalculaSimplesNacional(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral], 9, !Quantidade * ![Valor Unitario], 0,0)
            ![Base de calculo st] = CalculaSimplesNacional(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral], 11, !Quantidade * ![Valor Unitario], 0,0)
            ![Valor icms st] = CalculaSimplesNacional(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral], 12, !Quantidade * ![Valor Unitario], 0,0)
             Tributos = Tributos + CalculaSimplesNacional(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral], 12, !Quantidade * ![Valor Unitario], 0,0)
             ![Aliquota icms st] = CalculaSimplesNacional(![Sequencia Do produto], Nota_fiscal![Sequencia Do geral], 13, !Quantidade * ![Valor Unitario], 0,0) 
            ![Valor dos Tributos] = Tributos 'Tributos
           End If
            .Update
            .BookMark = .LastModified
            .MoveNext
         End With
      Loop
      AjustaTotais
      grdProdutos.ReBind 'Atualiza do Grid
      Reposition True    'Atualiza o Formulário   
    End If     
SaiDaSub:
   Screen.MousePointer = vbDefault

End Sub


Private Function MostraDesconto(Sequencia_da_nota_fiscal As Long, Sequencia_produto_nota_fiscal As Long, Sequencia_do_produto As Long, _
   Quantidade As Double, Valor_unitario As Double, Valor_total As Double, _
   Valor_do_ipi As Double, Valor_do_icms As Double, Aliquota_do_ipi As Single, _
   Aliquota_do_icms As Single, Percentual_da_reducao As Single, Valor_da_base_de_calculo As Double, _
   Valor_do_pis As Double, Valor_do_cofins As Double, Iva As Double, _
   Base_de_calculo_st As Double, Valor_icms_st As Double, Cfop As Long, _
   Cst As Integer, Aliquota_icms_st As Single, Valor_dos_tributos As Double) As String
Dim Percentual As Double, ValorDesc As Double

 Percentual = (Nota_fiscal![Valor Do desconto] / Nota_fiscal![Valor total dos produtos] * 100)
 ValorDesc = ((Quantidade * Valor_unitario) * Percentual / 100)' Valor do Desconto
 
 MostraDesconto = Format(ValorDesc, "##,###,##0.00")
 
End Function


Private Function MostraFrete(Sequencia_da_nota_fiscal As Long, Sequencia_produto_nota_fiscal As Long, Sequencia_do_produto As Long, _
   Quantidade As Double, Valor_unitario As Double, Valor_total As Double, _
   Valor_do_ipi As Double, Valor_do_icms As Double, Aliquota_do_ipi As Single, _
   Aliquota_do_icms As Single, Percentual_da_reducao As Single, Valor_da_base_de_calculo As Double, _
   Valor_do_pis As Double, Valor_do_cofins As Double, Iva As Double, _
   Base_de_calculo_st As Double, Valor_icms_st As Double, Cfop As Long, _
   Cst As Integer, Aliquota_icms_st As Single, Valor_dos_tributos As Double) As String
Dim Percentual As Double, ValorFrete As Double

 Percentual = (Nota_fiscal![Valor Do Frete] / Nota_fiscal![Valor total dos produtos] * 100)
 ValorFrete = ((Quantidade * Valor_unitario) * Percentual / 100)' Valor do Desconto
 
 MostraFrete = Format(ValorFrete, "##,###,##0.00")
 
End Function


Private Sub AjustaTotais()
   Dim IPIProdutos As New GRecordSet, BaseProdutos As New GRecordSet, ICMSProdutos As New GRecordSet, ValorProdutos As New GRecordSet
   Dim ICMSSTProdutos As New GRecordSet, BaseSTProdutos As New GRecordSet, ValorPIS As New GRecordSet, ValorCOFINS As New GRecordSet
   Dim ValorTributos As New GRecordset, ValorNFe As Currency

   On Error GoTo DeuErro
   
   
   If vgSituacao = ACAO_EXCLUINDO Then Exit Sub
   
   Set IPIProdutos = vgDb.OpenRecordSet("SELECT SUM([Valor Do IPI]) Total FROM [Produtos da nota fiscal] WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal) 'IPI dos Produtos
   Set ICMSProdutos = vgDb.OpenRecordSet("SELECT SUM([Valor Do ICMS]) Total FROM [Produtos da nota fiscal] WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal) 'ICMS Produtos
   Set ICMSSTProdutos = vgDb.OpenRecordSet("SELECT SUM([Valor icms st]) Total FROM [Produtos da nota fiscal] WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal) 'ICMS ST Produtos
   Set BaseProdutos = vgDb.OpenRecordSet("SELECT SUM([Valor da base de calculo]) Total FROM [Produtos da nota fiscal] WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal)'Base Produtos
   Set BaseSTProdutos = vgDb.OpenRecordSet("SELECT SUM([Base de calculo st]) Total FROM [Produtos da nota fiscal] WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal) 'Base ST Produtos

   Set ValorProdutos = vgDb.OpenRecordSet("SELECT SUM([Produtos da nota fiscal].[Valor Total]) Total " & _
                                          "FROM [Produtos da nota fiscal] INNER JOIN Produtos ON [Produtos da nota fiscal].[Sequencia do produto] = Produtos.[Sequencia do produto] " & _
                                          "WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal) 'Produtos

   Set ValorPIS = vgDb.OpenRecordSet("SELECT SUM([Valor do pis]) PIS From  [Produtos da nota fiscal] WHERE [Sequencia da nota fiscal] = " &  Sequencia_da_nota_fiscal)
   Set ValorCOFINS = vgDb.OpenRecordSet("SELECT SUM([Valor do cofins]) COFINS From  [Produtos da nota fiscal] WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal)                   
   Set ValorTributos = vgdb.OpenRecordset("SELECT SUM([Valor dos Tributos]) Tributos From  [Produtos da nota fiscal] WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal)                                                                                          
   ValorNFe = IPIProdutos!Total + ValorProdutos!Total + Valor_do_frete
   ValorNFe = ValorNFe + ICMSSTProdutos!Total - Valor_do_desconto
   ValorNFe = Format(ValorNFe, "##,###,##0.00")
   
   If Produtos_da_nota_fiscal.RecordCount = 0 Then
      ValorNFe = 0
   End If
 
   'Atualizando
   vgDb.BeginTrans
   vgDb.Execute "Update [Nota fiscal] Set [Valor total do ipi] = " & Substitui(IPIProdutos!Total, ",", ".", SO_UM) & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal ' Total de Ipi
   vgDb.Execute "Update [Nota fiscal] Set [Valor total do icms] = " & Substitui(ICMSProdutos!Total, ",", ".", SO_UM) & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal 'Valor do ICMS
   vgDb.Execute "Update [Nota fiscal] Set [Valor total icms st] = " & Substitui(ICMSSTProdutos!Total, ",", ".", SO_UM) & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal 'Valor do ICMS ST
   vgDb.Execute "Update [Nota fiscal] Set [Valor total da bc] = " & Substitui(BaseProdutos!Total, ",", ".", SO_UM) & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal'Base de Cálculo ICMS
   vgDb.Execute "Update [Nota fiscal] Set [Valor total base st] = " & Substitui(BaseSTProdutos!Total, ",", ".", SO_UM) & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal 'Base de Cálculo ICMS ST
   vgDb.Execute "Update [Nota fiscal] Set [Valor total dos produtos] = " & Substitui(ValorProdutos!Total, ",", ".", SO_UM) & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal 'Produtos 
   vgDb.Execute "Update [Nota fiscal] Set [Valor total da nfe] = " & Substitui(CStr(ValorNFe), ",", ".", SO_UM) & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal'Valor da Nota
   vgDb.Execute "Update [Nota fiscal] Set [Valor total do pis] = " & Substitui(ValorPIS!PIS, ",", ".", SO_UM) & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal 'Valor Total Do PIS
   vgDb.Execute "Update [Nota fiscal] Set [Valor total do cofins] = " & Substitui(ValorCOFINS!COFINS, ",", ".", SO_UM) & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal'Valor Total do COFINS
   vgDb.Execute "Update [Nota fiscal] Set [Valor Total dos Tributos] = " & Substitui(ValorTributos!Tributos, ",", ".", SO_UM) & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal 'Valor Total do Tributo
   vgDb.CommitTrans
   
   Produtos_da_nota_fiscal.Requery 
   'Alteracao
     
DeuErro:
   If Err Then
      MsgBox Err.Descption, vbCritical + vbOKOnly, vaTitulo
      vgDb.RollBackTrans
   End If

End Sub

Private Sub CarregaTotalizador()
   On Error Resume Next

   With grdProdutos
      .ShowSumBar = True
      .ShowSumCol(.Columns("Valor total").Index) = True
      .ShowSumCol(.Columns("Valor unitario").Index) = True
      .ShowSumCol(.Columns("Valor icms st").Index) = True
      .ShowSumCol(.Columns("Valor da base de calculo").Index) = True
      .ShowSumCol(.Columns("Base de calculo st").Index) = True
      .ShowSumCol(.Columns("Valor do icms").Index) = True
      .ShowSumCol(.Columns("Valor do ipi").Index) = True
      .ShowSumCol(.Columns("Aliquota icms st").Index) = False
      .ShowSumCol(.Columns("Iva").Index) = False
      .ShowSumCol(.Columns("Aliquota do ipi").Index) = False
      .ShowSumCol(.Columns("Aliquota do icms").Index) = False
      .ShowSumCol(.Columns("Cst").Index) = False
      .ShowSumCol(.Columns("Cfop").Index) = False 
      .ShowSumCol(.Columns("Percentual da redução").Index) = False           
      .ShowFilterBar = False
      .HideStatus = True
   End With
   
End Sub


Private Sub MostraFormulas()
   
  lblNNota.Value = Format (Numero_da_nfe ,"000000")
  lblNota.Caption = "NFe"
  TxtEnderecoTrans.Value = TransporteAux!Endereço & "  " & TransporteAux!Complemento & "  " & TransporteAux!Nro & "  " & MunTransAux![Descrição Do municipio] & "  " & MunTransAux!UF
  If Err Then Err = 0: TxtEnderecoTrans.Text = ""
  TxtIETrans.Value = TransporteAux![Rg e Ie]
  If Err Then Err = 0: TxtIETrans.Text = ""
  TxtCnpjTrans.Value = TransporteAux![Cpf e cnpj]
  If Err Then Err = 0: TxtCnpjTrans.Text = ""
  lblParcelamento.Caption = "Parcelamento"
  If Err Then Err = 0: lblParcelamento.Caption = ""
 
  If Nota_Cancelada Then
      lblNota2.ForeColor = &H8FF
   Else
      lblNota2.ForeColor = &H0
   End If   
   If Autorizada Then 
      cmdDanfe.Caption = "DANFE"  
   Else
      cmdDanfe.Caption = "Autorizar"
   End If  
   If Err Then Err.Clear 
   
    If vgSituacao <> ACAO_NAVEGANDO Then
      lblNota.BackColor = &H80FFFF: lblNota.ForeColor = &H80000012 'Amarelo
   Else
      If Numero_da_nfe > 0 Then
         If Nota_Cancelada  Then
            lblNota.BackColor = &H8FF: lblNota.ForeColor = &HFFFFFF 'Vermelho
         ElseIf Autorizada Then
            lblNota.BackColor = &H0: lblNota.ForeColor = &HFFFFFF 'Preto
         ElseIf Transmitido Then
            lblNota.BackColor = &HC0FFC0: lblNota.ForeColor = &H80000012 'Preto
         Else
            lblNota.BackColor = &H80FFFF: lblNota.ForeColor = &H80000012 'Amarelo
         End If
      Else
         lblNota.BackColor = &H80FFFF: lblNota.ForeColor = &H80000012 'Amarelo
      End If
   End If
   'Label do Parcelamento
   lblParcelamento.BackColor = &H0: lblParcelamento.ForeColor = &HFFFFFF
      If TotalParcelas = 0 Then
         lblParcelamento.BackColor = &H80FFFF: lblParcelamento.ForeColor = &H80000012
      ElseIf (TotalParcelas < Valor_Total_da_NFe) Or (TotalParcelas > Valor_Total_da_NFe) Then
         lblParcelamento.BackColor = &H8FF: lblParcelamento.ForeColor = &HFFFFFF
      End If
  
End Sub


Private Sub Alteracao()
   On error Resume Next
      
   With vgTb   
      .Edit
      ![Data da Alteração] = Date
      ![Hora da Alteração] = Time
      ![Usuario da Alteração] = vgPwUsuario
      .Update
      .Bookmark = .lastModified
   End With

End Sub

'para mudar o titulo de quem vez a alteração
Private Sub LimpaLabel()
   lblAlteracao.Caption = ""
   lblProgresso.Caption = ""
End Sub


'Procedimento para enviar ou abrir a nota
Private Sub SuperAcao()
   If cmdDanfe.Caption = "DANFE" Then
      DANFE 'Abre Nota
   Else
      GeraNota 'Vamos Enviar a Nota
   End If
End Sub


Private Sub GeraNota()
   Dim XmlAssinado As String
   Dim UltimaEletronica As New GRecordset

   On Error Resume Next
   
   If Not Transmitido Then If MsgBox("Deseja Enviar essa Nota Fiscal?", vbQuestion + vbYesNo, vaTitulo) = vbNo Then Exit Sub
   
   Set UltimaEletronica = vgdb.OpenRecordset("SELECT MAX([Numero da nfe]) NFe FROM [Nota fiscal]")
           
      If Numero_da_nfe = 0 Then         
         vgDb.Execute "Update [Nota fiscal] Set [Numero da NFe] = " & UltimaEletronica!NFe + 1 & " WHERE [Sequencia da nota fiscal] = " & Sequencia_da_Nota_Fiscal
         Reposition
      End If

      If Not Transmitido Then
         PreValidaNFe 'Validação
      Else
         XmlAssinado = Nota_fiscal!XmlAssinado
         RetornoNFe310 XmlAssinado, Numero_do_Recibo 'Caso ele ja enviou entao vamos buscar novamente
      End If
End Sub


Private Sub PreValidaNFe()
   Dim Tb As New GRecordSet, Itens As New GRecordSet
   Dim Vector() As String
   Dim Email As New clsEnviaEMail
   Dim i As Long, vaPrivez As Boolean, Campo As Variant, Mensagem As String
   Dim endereco As String

   On Error GoTo DeuErro
   
   'ALGUNS CAMPOS OBRIGATÓRIOS
   '==========================================================================
   '======Identificação da NFe
   '- Natureza de Operação
   '====Destinatario====
   '- CNPJ ou CPF
   '- Razão Social
   '- Endereço
   '- Número Do Endereço (Se não Houver preencher com S/N)
   '- Bairro
   '- Código Do Município
   '- Nome Do Municipio (Informar EXTERIOR para operações com o exterior)
   '- UF (informar EX para operações com o exterior)
   '- IE (Quando Houver)
   '- Suframa (Quando Houver)
   '- Email (Quando Houver)
   '====Itens====
   '- Descrição
   '- Unidade
   '- NCM
   '- CFOP
   '=====Transporte======
   '- Modalidade Do Frete
   
   Set Tb = vgDb.OpenRecordSet("SELECT [Descrição do cfop], [Cfop], [Razão Social], Frete, " & _
                               "[Cpf e cnpj], G.Endereço GEndereço, G.Nro GNro, G.Complemento GComplemento, G.Bairro GBairro, MG.[codigo do ibge] MGIBGE, MG.Uf MGUF, G.Cep GCEP, " & _
                               "MG.[Descrição do municipio] MGDescrição, [Sequencia da Transportadora], [RG e IE], Isento, G.Nro GNumero, " & _
                               "G.Email, G.[Codigo Do suframa], N.[Tipo de Nota] As TipoNota FROM [Nota Fiscal] N " & _
                               "LEFT JOIN [Natureza de Operação] NATOP ON N.[Sequencia da natureza] = NATOP.[Sequencia da Natureza] " & _
                               "LEFT JOIN GERAL G ON N.[Sequencia Do Geral] = G.[Sequencia Do Geral] " & _
                               "LEFT JOIN Municipios MG ON G.[Sequencia Do Municipio] = MG.[Sequencia Do Municipio] " & _
                               "WHERE [Sequencia da Nota Fiscal] = " & Sequencia_da_Nota_Fiscal)
                               
   Set Itens = vgDb.OpenRecordSet ("SELECT PNF.[Sequencia da nota fiscal], P.[Sequencia do produto], P.Descrição, U.[Sigla da unidade], NCM.Ncm " & _
                                   "FROM [Produtos da nota fiscal] PNF LEFT JOIN Produtos P ON PNF.[Sequencia Do produto] = P.[Sequencia Do produto] " & _
                                   "LEFT JOIN Unidades U ON P.[Sequencia da Unidade] = U.[Sequencia da Unidade] " & _
                                   "LEFT JOIN [Classificação Fiscal] NCM ON P.[Sequencia da classificação] = NCM.[Sequencia da Classificação] " & _
                                   "WHERE [Sequencia da Nota Fiscal] = " & Sequencia_da_Nota_Fiscal)
                               
   If Tb.RecordCount = 0 Then Exit Sub
   If Itens.RecordCount = 0 Then Exit Sub
   
   'Vamos Validar
   i = 0 'Tamanho do Vetor
   ReDim Preserve Vector(0) As String
   If Vazio(Tb![Descrição Do cfop]) Then i = i + 1: ReDim Preserve Vector(i): Vector(i - 1) = "Descrição da Natureza de Operação (CFOP)"
   If Finalidade_nfe = 0 Then i = i + 1: ReDim Preserve Vector(i): Vector(i - 1) = "Informe a Finalidade da NFe 1 - NFe Normal - 2 NFe Complementar - 3 NFe de Ajuste - 4 NFe Devolução / Retorno"
   If Vazio(Tb![Razão social]) Then i = i + 1: ReDim Preserve Vector(i): Vector(i - 1) = "Razão Social (Geral)"
   If Vazio(Tb!Frete) Then i = i + 1: ReDim Preserve Vector(i): Vector(i - 1) = "Tipo do Frete (Emitente / Destinatario)"
   If Tb![Sequencia da transportadora] = 0 Then i = i + 1: ReDim Preserve Vector(i): Vector(i - 1) = "Transportadora (Nota Fiscal) Se não existir Informe O MESMO"
   If Not Mid(Tb![Cfop], 1, 1) = "7" And Not Mid(Tb![Cfop], 1, 1) = "3" Then
      If Vazio(Tb![Cpf e cnpj]) Then i = i + 1: ReDim Preserve Vector(i): Vector(i - 1) = "CPF/CNPJ (Geral)"
      If Vazio(Tb![Rg e ie]) And Not Tb!Isento Then i = i + 1: ReDim Preserve Vector(i): Vector(i - 1) = "RG/IE (Geral)"
      If Vazio(Tb!GCep) Then i = i + 1: ReDim Preserve Vector(i): Vector(i - 1) = "CEP do Município (Geral)"
   End If
   If Vazio(Tb!GEndereço) Then i = i + 1: ReDim Preserve Vector(i): Vector(i - 1) = "Endereço (Geral)"
   If Vazio(Tb!GNro) Then i = i + 1: ReDim Preserve Vector(i): Vector(i - 1) = "Nº do Endereço (Geral) Se não Existir Informe S/N"
   If Vazio(Tb!GBairro) Then i = i + 1: ReDim Preserve Vector(i): Vector(i - 1) = "Bairro (Geral)"
   If Not frmMunicipi.ValidaCMun(Tb!MGIbge, Tb!MGUf) Or Tb!MGIbge = 0 Then i = i + 1: ReDim Preserve Vector(i): Vector(i - 1) = "Código do Município (Geral)"
   If Vazio(Tb!MGDescrição) Then i = i + 1: ReDim Preserve Vector(i): Vector(i - 1) = "Município (Geral)"
   If Vazio(Tb!MGUf) Then i = i + 1: ReDim Preserve Vector(i): Vector(i - 1) = "UF do Município (Geral)"
   
      'If Vazio(Trim(Tb!Email)) Then
      '   i = i + 1
      '   ReDim Preserve Vector(i): Vector(i - 1) = "Email (Geral)"
      'Else
      '   If Not Email.IsValidEmailAddress(Trim(Tb!Email)) Then i = i + 1: ReDim Preserve Vector(i): Vector(i - 1) = "Email Inválido (Geral)"
      'End If
   
   Do While Not Itens.EOF
      If Vazio(Itens!Descrição) Then i = i + 1: ReDim Preserve Vector(i): Vector(i - 1) = "ITEM: " & Itens![Sequencia Do Produto] & " - Descrição"
      If Vazio(Itens![Sigla da unidade]) Then i = i + 1: ReDim Preserve Vector(i): Vector(i - 1) = "ITEM: " & Itens![Sequencia Do Produto] & " - Unidade"
      If Vazio(Itens!Ncm) Then i = i + 1: ReDim Preserve Vector(i): Vector(i - 1) = "ITEM: " & Itens![Sequencia Do Produto] & " - Classificação Fiscal (NCM)"
      Itens.MoveNext
   Loop
      
   If UBound(Vector) > 0 Then
      Mensagem = "Alguns Campos Precisam ser Preenchidos:" & vbCrLf
      For Each Campo In Vector
         Mensagem = Mensagem & vbCrLf & Campo
      Next
      If Mensagem <> "" Then
         MsgBox Mensagem, vbCritical + vbOKOnly, vaTitulo
         Exit Sub
      End If
   End If
   
   'Vamos Validar o Endereço
   If Len(Tb!GEndereço) > 64 Then
      If Len(Abreviacao(Tb!GEndereço)) > 64 Then '64 é o tamanho no Relatorio DANFE
         If MsgBox("O Sistema Abreviou o Endereço, mas NÃO foi o suficiente." & vbCrLf & Abreviacao(endereco) & vbCrLf & "Deseja Enviar mesmo assim?", vbYesNo + vbQuestion, vaTitulo) = vbNo Then Exit Sub
      End If
   End If
   
   XmlNFe
   
DeuErro:
   If Err <> 0 Then
      MsgBox Err.Description, vbCritical + vbOKOnly, vaTitulo
   End If

End Sub

'ROTINA QUE MONTA O XML DA NOTA FISCAL ELETRONICA
Private Sub XmlNFe()
'DECLARAÇÃO DAS VARIÁVEIS
'-------Variáveis Avulsas--------------
 Dim Item As New GRecordSet, Cliente As New GRecordSet, Transportadora As New GRecordSet, Usado As Boolean, Reducao As Boolean
 Dim NatOpe As New GRecordSet, Parcelas As New GRecordSet, objNFeUtil As Object, Arq As Long, Detalhes As String, Avulsa As String
'======Identificação do Documento======================================================================================
 Dim ide_cUF As Long, ide_cNF As String, ide_natOp As String, ide_indPag As Long, ide_mode As Long
 Dim ide_serie As Long, ide_nNF As Long, ide_tpNF As Long, ide_cMunFG As String, Ide As String
 Dim ide_tpImp As Long, ide_cDV As Long, ide_tpAmb As Long, ide_finNFe As Long, ide_tpEmis As Long, ide_procEmi As Long
 Dim ide_verProc As String, ide_NFref As String, ide_dhCont As String, ide_xJust As String
 Dim ide_dhEmi As String, ide_dhSaiEnt As String, ide_idDest As Integer, ide_indFinal As Integer, ide_indPres As Integer
'======Chave da NFe====================================================================================================
 Dim Resultado As Long, emi_CNPJ As String, cUF, Ano, Mes, modelo, serie, Numero, tpemis, codigoseguranca As String
 Dim msgResult As String, cNF As String, cDV As String, chaveNFe As String
'======NFe Referenciada=======
 Dim ide_NFRefs As String
'======Identificação do Emitente============================================================================
 Dim emi_CPF As String, emi_xNome As String, emi_xFant As String, emi_xLgr As String, Emitente As String
 Dim emi_nro As String, emi_xCpl As String, emi_xBairro As String, emi_cMun As String, emi_xMun As String
 Dim emi_UF As String, emi_CEP As String, emi_cPais As String, emi_xPais As String, emi_fone As String
 Dim emi_IE As String, emi_IEST As String, emi_IM As String, emi_CNAE As String, emi_CRT As String
'======Identificação do Destinatario==========================================================================
 Dim dest_CNPJ As String, dest_CPF As String, dest_xNome As String, dest_xLgr As String
 Dim dest_nro As String, dest_xCpl As String, dest_xBairro As String, dest_cMun As String, dest_xMun As String
 Dim dest_UF As String, dest_CEP As String, dest_cPais As String, dest_xPais As String, dest_fone As String
 Dim dest_IE As String, dest_IESUF As String, dest_eMail As String, Destinatario As String
 Dim dest_idEstrangeiro As String, dest_indIEDest As String, dest_IM As String
'======Identificação do Produtos/Serviços=====
 Dim det_nItem As Long, det_produto As String, det_imposto As String
 Dim Prod_cProd As String, Prod_cEAN As String, Prod_xProd As String, Prod_NCM As String, Prod_ExTIPI As String
 Dim Prod_CFOP As String, Prod_uCOM As String, Prod_qCom As String, Prod_vUnCom As String, Prod_vProd As String
 Dim Prod_cEANTrib As String, Prod_uTrib As String, Prod_qTrib As String, Prod_vUnTrib As String, Prod_DI As String
 Dim Prod_DetEspecifico As String, Prod_xPed As String, Prod_vFrete As Double, Prod_Ad As String
 Dim Prod_vSeguro As Double, Prod_vDesc As Double, Prod_vOutro As Double, Prod_indTot As Byte, Prod_nItemPed As Integer
 Dim TotalDosItens As double,PercentualRateio as Double, Prod_Cest As String
'Campos Novos Layout 3.10 usado em Importação
 Dim Prod_NVE_Opc As String, Prod_detExport_Opc As String, Prod_nFCI_Opc As String, Dta_Di As String, DtaDesembaraco As String
 Dim Prod_tpIntermediario As Integer, Prod_CNPJ_Opc As String, Prod_UFTerceiro As String, Prod_nDraw_Opc As String
 '=====Identificação do ICMS=======
 Dim det_icms As String, icms_orig As String, icms_CST As String, icms_modBC As Long, icms_pRedBC As Double, icms_vBC As Currency
 Dim icms_pICMS As Double, icms_vICMS As Currency, icms_modBCST As Long, icms_pmVAST As Double, icms_pRedBCST As Double
 Dim icms_vBCST As Currency, icms_pICMSST As Double, icms_vICMSST As Currency, icms_vBCSTRet As Currency
 Dim icms_vICMSSTRet As Currency, icms_motDesICMS As Long, icms_pBCOp As Double, icms_UFST As String, icms_pCredSN As Double
 Dim icms_vCredICMSSN As Currency, icms_vICMSSTDest As Currency, icms_vBCICMSSTDest As Currency, det_PISST As String
 Dim det_COFINSST As String, det_ISSQN As String, totalICMS As String, Icms As String
 'Campos Novos Layout 3.10
 Dim icms_vICMSDeson As Currency, icms_vICMSOp As Currency, icms_pDif As Double, icms_vICMSDif As Currency
 '=====Identificação do IPI=======
 Dim det_IPI As String, ipi_clEnq As String, ipi_CNPJProd As String, ipi_cSelo As String, ipi_qSelo As Integer
 Dim ipi_cEnq As String, ipi_CST As String, ipi_vBC As Double, ipi_pIPI As Double, ipi_qUnid As Double
 Dim ipi_vUnid As Double, ipi_vIPI As Double, Ipi As String, Det_pDevol As Integer, Det_vIPIDevol As Integer 
 '=====Identificação do PIS=======
 Dim det_PIS As String, pis_CST As String, pis_vBC As Double, pis_pPIS As Double, pis_qBCProd As Double
 Dim pis_vAliqProd As Double, pis_vPIS As Double, Pis As String
 '=====Identificação do COFINS======
 Dim det_COFINS As String, cofins_CST As String, cofins_vBC As Double, cofins_pCOFINS As Double
 Dim cofins_qBCProd As Double, cofins_vAliqProd As Double, cofins_vCOFINS As Double, Cofins As String
 Dim det_II As String, det_vTotTrib As Double
 '=====Identificação do Dados Ad======
 Dim det_infAdProd As String
 '=====Totais da NF=======
 Dim vBC As Double, vICMS As Double, vBCST As Double, vST As Double, vProd As Double, vFrete As Double
 Dim vSeg As Double, vDesc As Double, vII As Double, vIPI As Double, vPIS As Double, vCOFINS As Double
 Dim vOutro As Double, vNF As Double, ISSQNTot As String, retTrib As String
 Dim vICMSDeson As Double, vTotTrib As Double, Total As String ' Campo Novo Layout 3.10
 '=====Identificação do Transporte===============
 Dim modFrete As String, transporta As String, retTransp As String, veicTransp As String, reboque As String
 Dim vagao As String, balsa As String, vol As String, TransCNPJ As String, TransCPF As String, TransxNome As String, TransIE As String, TransxEnder As String
 Dim TransxMun As String, placa As String, TransUF As String, RNTC As String, qVol As String, esp As String, marca As String
 Dim nVol As String, pesoL As Double, pesoB As Double, lacres As String, veicUF As String
 '=====Identificação das Informações Adicionais======
 Dim infAdFisco As String, infCpl As String, obsCont As String, obsFisco As String, procRef As String
 '=====Identificação da Cobrança=====
 Dim nFat As String, vOrig As Double, vFatDesc As Double, vLiq As Double, dup As String, nDup As String
 Dim dVenc As Date, vDup As Double
 '=====Identificação da Exportação=====
 Dim UFEmbarq As String, xLocEmbarq As String
 Dim xLocDespacho As String ' Campo Novo Layout 3.10
 '=====Identificação da Compra=====
 '=====Identificação da Cana=====
 '=====Consolidação da NFe=======
 Dim NFe As String, versao As String, id As String
 Dim retirada As String, entrega As String, transp As String, cobr As String
 Dim infAdic As String, exporta As String, compra As String, cana As String
 Dim Pag As String, autXML As String 
 'Campos Novos Partilha do ICMS na Operação Interstadual, consumidor final não contribuinte
 Dim FormaCalculo As Integer, ValorBase As Double, AliqDestino As Double, AliqInterstadual As Double
 Dim AliqFCP As Double, AnoOperacao As Long, vBCUFDest As Double, pFCPUFDest As Double, pICMSUFDest As Double
 Dim pICMSInter As Double, pICMSInterPart As Double, vFCPUFDest As Double, vICMSUFDest As Double
 Dim vICMSUFRemet As Double, vBCopeInter As Double, vICMSOpeInter As Double, cResultado As Long, msgResultado As String
 Dim TbIcms As New GRecordSet, TotICMSUFDest As Double, TotICMSUFRemet As Double, TotvFCPUFDest As Double
 Dim CalcICMSUFDest As String, ICMSUFDest As String

 On Error GoTo DeuErro
 
 Screen.MousePointer = vbHourglass ' Ampulheta 
 lblProgresso.Caption = "Gerando XML..."
   
 Set Cliente = vgDb.OpenRecordSet("SELECT [Cpf e cnpj], Endereço, Nro, Complemento, Bairro, [Codigo do ibge], [Descrição do municipio] Municipio, UF, " & _
                                  "[Rg e ie], [Razão social], [Fone], Tipo, G.Cep, Email, Isento, [Consumidor final], [Codigo do suframa] " & _
                                  "FROM Geral G LEFT JOIN Municipios M ON G.[Sequencia do Municipio] = M.[Sequencia do municipio] WHERE G.[Sequencia do geral] = " & Nota_Fiscal![Sequencia Do geral])
 
 Set Transportadora = vgDb.OpenRecordSet("SELECT Tipo, [Cpf e cnpj], [Rg e ie], [Razão Social], Endereço, [Descrição do municipio] Municipio, UF, [Codigo da antt] " & _
                                         "FROM Geral T LEFT JOIN Municipios M ON T.[Sequencia do Municipio] = M.[Sequencia do Municipio] WHERE T.[Sequencia do Geral] = " & Nota_Fiscal![Sequencia da transportadora]) 
                                           
 Set NatOpe = vgDb.OpenRecordSet("SELECT * FROM [Natureza de operação] WHERE [Sequencia da natureza] = " & Sequencia_da_Natureza)                                                                          
 
 Set Item = vgDb.OpenRecordSet("SELECT [Sequencia da nota fiscal], P.[Sequencia do produto], P.Descrição [Descrição Produto], C.Ncm, C.Cest, Cfop, U.[Sigla da unidade] [Descrição Unidade], PNF.Quantidade, PNF.[Valor Unitario], PNF.[Valor total], " & _
                               "[Percentual da redução], [Valor da base de calculo], [Aliquota do icms], [Valor do icms], [Aliquota do ipi], [Valor do ipi], [Valor do pis], [Valor do cofins], Usado, Cst, PNF.Iva, [Base de calculo st], [Valor icms st], [Aliquota icms st], " & _
                               "[Sequencia produto nota fiscal] SeqItem, [Valor dos tributos], Importado " & _
                               " FROM [Produtos da nota fiscal] PNF, Produtos P, Unidades U, [Classificação fiscal] C  " & _
                               " WHERE PNF.[Sequencia do produto] = P.[Sequencia do produto] " & _  
                               " And P.[Sequencia da unidade] = U.[Sequencia da unidade] " & _  
                               " And P.[Sequencia da classificação] = C.[Sequencia da classificação] And [Sequencia da Nota Fiscal] = " & Sequencia_da_Nota_Fiscal)
                               
 Set Parcelas = Parcelas_nota_fiscal
 Set TbIcms = vgDb.OpenRecordSet("SELECT * From Icms Where UF = '" & Cliente!UF & "'")
 
   Reducao = Item![Percentual da redução] > 0                                
  '========Grupo de Identificação da NFe=================' 
   ide_cUF = Parametros_da_nfe![Codigo da uf]' código da UF - tabela do IBGE: 35 - SP, 43 - RS, etc
   ide_natOp = RemoveCaracteres(SuperTiraAcentos(Trim(NatOpe![Descrição Do cfop])), True) 'natureza da operação
   ide_indPag = IIf(Nota_fiscal![Forma de pagamento] = "Vista", 0, 1) ' 0=vista 1=Prazo 2=Outros
   ide_mode = 55 ' modelo da nota fiscal eletronica
   ide_serie = Parametros_da_nfe![Serie da nfe]                            ' série única = 0
   ide_nNF = Nota_fiscal![Numero da nfe]' número da NF-e
   
   If Parametros_da_nfe![Horario de verao] Then
      ide_dhEmi = Format(Now,"yyyy-MM-ddThh:mm:ss-02:00") ' data de emissão em Formato UTC TZD 02:00 HORARIO DE VERÃO
   Else
      ide_dhEmi = Format(Now,"yyyy-MM-ddThh:mm:ss-03:00") ' data de emissão em Formato UTC 
   End If
  
   ide_dhSaiEnt = ""
   ide_tpNF = IIf(Nota_fiscal![Tipo de nota] = 0, 1, 0)   ' Tipo de NF 0 = Entrada 1 = Saida
   ide_cMunFG = Empresa![Codigo Do municipio]             ' código do município do IBGE do Emitente
   ide_tpImp = 1                                          ' orientação da impressão 1-retrato/2-paisagem
   ide_tpAmb = IIf(Parametros_da_NFe!ambiente = 0, 1, 2)  ' ambiente de envio da NFe 1-produção / 2 - homologação
   ide_finNFe = Finalidade_nfe                            ' finalidade da emissão da NF-e 1- NF-e normal 2 - NF-e Complementar - 3 NF-e de Ajuste - 4 Devolução / Retorno
   ide_tpEmis = 1                                         ' forma de emissão da NF-e 1- normal, 2 - contingência FS, 3 - contingência SCAN, etc.
   ide_procEmi = 0                                        ' identificação do processo de emissão da NF-e 0 - aplicação do contribuinte
   ide_verProc = "DELLALIO NFE"                           ' identificação da versão do processo de emissão
   ide_dhCont = ""                                        ' data e hora de entrada em contingência - informar quanto tpEmis diferente de 1, informe #12:00:00 AM# para deixar vazio em VB
   ide_xJust = ""                                         ' justificativa para emissão em contingência                     
   
   If ide_finNFe = 2 Then                                 
      ide_indPres = 0
   Else
      ide_indPres = 9
   End If 
   
   If Cliente![Consumidor final] Then  
    ide_indFinal = 1 'Consumidor Final
   Else
    ide_indFinal = 0 'Revenda 
   End If
   
   If Cliente!Uf = "SP" Then 'Dentro do Estado
      ide_idDest = 1
   Else
      ide_idDest = 2
   End If 
   
   'Gera a Chave de Acesso da NFe
   'Utilizar a Função CriaChaveNFe para Gerar a Chave de Acesso, Código da NFe e DV
   emi_CNPJ = RemoveCaracteres(Empresa!Cnpj)
   cUF = Trim(Str(ide_cUF))
   Ano = Mid(ide_dhEmi,3,2)
   Mes = Mid(ide_dhEmi,6,2)
   modelo = Trim(Str(ide_mode))
   serie = Trim(Str(ide_serie))
   Numero = Trim(Str(ide_nNF))
   tpemis = Trim(Str(ide_tpEmis))
   codigoseguranca = "segredo"     ' informar uma expressão para garantir o sigilo da forma de cálculo do cNF
    
   Set objNFeUtil = CreateObject("NFe_Util_2G.Util")
    
   Resultado = objNFeUtil.CriaChaveNFe2G(cUF, Ano, Mes, emi_CNPJ, modelo, serie, Numero, tpemis, codigoseguranca, msgResult, cNF, cDV, chaveNFe)
    
   If Resultado <> 5601 Then
      MsgBox "Ocorreu um Erro ao Gerar a Chave de Acesso " + msgResult, vbCritical, vaTitulo
      With vgTb
         .Edit
         If Vazio(!Observação) Then
            !Observação = "Erro ao Gerar a Chave de Acesso"
         Else
            !Observação = !Observação & vbCrLf & "Erro ao Gerar a Chave de Acesso"
         End If
         .Update
         .BookMark = .LastModified
      End With
      GoTo SaiDaSub
   End If
    
   ide_cNF = Val(cNF)                     ' código numérico que compõe a chave de acesso
   ide_cDV = Val(cDV)                     ' DV da chave de acesso da NF-e
     
   'Gera Grupo NFeRef
   If Nota_fiscal![Nfe complementar] Then
      ide_NFRefs = objNFeUtil.NFeRef(Nota_fiscal![Chave nfe referenciada])
   End If 
   
   If Nota_fiscal!Devolução And Not Nota_fiscal![Nfe complementar] Then
     If NFe_devolucao.RecordCount > 0 Then
       Do While Not NFe_devolucao.EOF
       ide_NFRefs =  ide_NFRefs + objNFeUtil.NFeRef(NFe_devolucao![Chave da nfe])
       NFe_devolucao.MoveNext
       Loop
       NFe_devolucao.MoveFirst
     End If
   End If 
   
   'Gera Grupo ide
   Ide = objNFeUtil.identificador300(ide_cUF, ide_cNF, ide_natOp, ide_indPag, ide_mode, ide_serie, ide_nNF, ide_dhEmi, ide_dhSaiEnt, ide_tpNF, ide_idDest, ide_cMunFG, ide_NFRefs, ide_tpImp, ide_tpEmis, ide_cDV, ide_tpAmb, ide_finNFe, ide_indFinal, ide_indPres, ide_procEmi, ide_verProc, ide_dhCont, ide_xJust)
   
    '=====Grupo de Identificação do Emitente (Grupo B do Manual de Integração 4.01-NT2009/006 - página 113)=======
    '        <>&" são caracteres reservados do XML e devem ser evitados ou substituídos
   If Parametros_da_NFe!ambiente = 0 Then                     ' Produção
      emi_CPF = RemoveCaracteres(Empresa![Cpf Do emitente])   ' CPF do emitente, uso exclusivo do Fisco
      emi_xNome = RemoveCaracteres(Empresa![Razão social])    ' Razão social do emitente, evitar caracteres acentuados e &
      emi_xFant = RemoveCaracteres(Empresa![Nome fantasia])   ' Nome fantasia
      emi_IE = RemoveCaracteres(Empresa![Inscrição estadual]) ' Inscrição Estadual do emitente sem máscara
   Else
      emi_xNome = "NF-E EMITIDA EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL"
      emi_xFant = "NF-E EMITIDA EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL"
      emi_IE = RemoveCaracteres(Empresa![Inscrição estadual])
   End If
   emi_CNPJ = RemoveCaracteres(Empresa!Cnpj)                                       ' CNPJ do emitente sem máscara de formatação
   emi_xLgr = RemoveCaracteres(SuperTiraAcentos(Trim(Empresa!Rua)), True)          ' logradouro
   emi_nro = Empresa!Nro                                                          ' número, informar S/N quando inexistente para evitar erro de Schema XML
   emi_xBairro = RemoveCaracteres(SuperTiraAcentos(Trim(Empresa!Bairro)), True)    ' bairro
   emi_cMun = Empresa![Codigo Do municipio]                                        ' código do município - codificação IBGE, deve ser compatível com a UF
   emi_xMun = RemoveCaracteres(SuperTiraAcentos(Trim(Empresa!Município)), True)    ' nome do município
   emi_UF = Empresa!Uf                                                             ' sigla da UF
   emi_CEP = RemoveCaracteres(Empresa!Cep)                                         ' CEP - sem máscara
   emi_cPais = "1058"                                                              ' código do país - deve fixo em 1058 - Brasil
   emi_xPais = "Brasil"                                                            ' nome do país (Brasil ou BRASIL)
   emi_fone = RemoveCaracteres(Substitui(Empresa!Fone , " ", "", SO_UM))                                ' número do telefone sem máscara
   emi_IEST = ""                                                                   ' Inscrição Estadual do ST
   emi_IM = ""                                                                     ' Inscrição Municipal
   emi_CNAE = "" 
                                                                                   ' Código do CNAE
   If Parametros_da_nfe![Simples nacional] Then
      emi_CRT = "1"                                                                 ' Código do CRT: 3 - Regime Normal. - 1 Simples Nacional
   Else
      emi_CRT = "3" 
   End If 
   
     'Gera Grupo emi
   Emitente = objNFeUtil.emitente2G(emi_CNPJ, emi_CPF, emi_xNome, emi_xFant, emi_xLgr, emi_nro, emi_xCpl, emi_xBairro, emi_cMun, emi_xMun, emi_UF, emi_CEP, emi_cPais, emi_xPais, emi_fone, emi_IE, emi_IEST, emi_IM, emi_CNAE, emi_CRT)
   
   '========Grupo de Identificação do Destinatario=======================
   If Cliente!Tipo = 0 Then
      dest_CPF = RemoveCaracteres(Cliente![Cpf e cnpj])  ' CPF do destinatario sem máscara de formatação
   Else
      dest_CNPJ = RemoveCaracteres(Cliente![Cpf e cnpj]) ' CNPJ do destinatario sem máscara de formatação
         If Not Cliente!Isento Then
            dest_IE = RemoveCaracteres(Cliente![Rg e ie])      ' Inscrição Estadual do destinatario sem máscara
         Else
            dest_IE = ""                                       ' Inscrição Estadual do destinatario sem máscara
         End If
   End If
   dest_cPais = "1058"                                         ' código do pais - deve fixo em 1058 - Brasil
   dest_cMun = Cliente![Codigo Do ibge]                        ' código do município (vide página 141 do manual), deve ser compatível com a UF
   dest_xMun = RemoveCaracteres(SuperTiraAcentos(Trim(Cliente!Municipio)), True) ' nome do município
   dest_UF = Cliente!Uf                         ' sigla da UF
   'Vamos Tentar Abreviar se puder
      If Len(Cliente!Endereço & ", " & Cliente!Nro & " - " & Cliente!Complemento) > 64 Then
         dest_xLgr = RemoveCaracteres(Substitui(SuperTiraAcentos(Trim(Abreviacao(Cliente!Endereço))), "&", "E", 1), True) ' logradouro
         dest_nro = IIf(Vazio(Cliente!Nro), "S/N", Cliente!Nro) ' número, informar S/N quando inexistente para evitar erro de Schema XML
         dest_xCpl = RemoveCaracteres(Substitui(SuperTiraAcentos(Trim(Abreviacao(Cliente!Complemento))), "&", "E", 1), True) ' complemento do endereço, o conteúdo pode ser omitido
      Else
         dest_xLgr = RemoveCaracteres(Substitui(SuperTiraAcentos(Trim(Cliente!Endereço)), "&", "E", 1), True) ' logradouro
         dest_nro = IIf(Vazio(Cliente![Nro]), "S/N", Cliente!Nro) ' número, informar S/N quando inexistente para evitar erro de Schema XML
         dest_xCpl = RemoveCaracteres(Substitui(SuperTiraAcentos(Trim(Cliente!Complemento)), "&", "E", 1), True) ' complemento do endereço, o conteúdo pode ser omitido
      End If
      dest_xBairro = RemoveCaracteres(Substitui(SuperTiraAcentos(Trim(Cliente!Bairro)), "&", "E", 1), True) ' bairro
      dest_CEP = RemoveCaracteres(Cliente!CEP)     ' CEP - sem máscara
      If Parametros_da_NFe!ambiente = 0 Then 'Produção
         dest_xNome = RemoveCaracteres(Substitui(SuperTiraAcentos(Trim(Cliente![Razão Social])), "&", "E", 1), True) ' Razão social do destinatario, evitar caracteres acentuados e &
         dest_eMail = Cliente!Email                      ' e-mail do destinatário
      Else 'Homologação
      dest_xNome = "NF-E EMITIDA EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL" ' Razão social do destinatario, evitar caracteres acentuados e &
      dest_eMail = ""                                 ' e-mail do destinatário
   End If
   dest_fone = RemoveCaracteres(Substitui(Cliente![Fone], " ", "", SO_UM))  ' número do telefone sem máscara
   dest_IESUF = Cliente![Codigo Do suframa]                                 ' Inscrição SUFRAMA
   dest_IM = "" 
   dest_idEstrangeiro = "" 
   
   If Cliente!Tipo = 1 And Not Vazio(Cliente![RG e IE]) Then      'Pessoa Juridica Com IE é Contribuinte
   dest_indIEDest = 1
   End If
   
   If Cliente!Tipo = 0 Then ' Pessoa Fisica e sem Propriedade Não é Contribuinte
   dest_indIEDest = 9
   End If
   
   If Cliente!Tipo = 1 And Cliente!Isento Then ' Pessoa Jurida e Isenta de IE Não é Contribuinte
      If dest_UF <> "AM" And dest_UF <> "BA" And dest_UF <> "CE" And dest_UF <> "GO" And dest_UF <> "MG" And dest_UF <> "MT" And dest_UF <> "MS" And dest_UF <> "PE" And dest_UF <> "RN" And dest_UF <> "SE" And dest_UF <> "SP" Then
         dest_indIEDest = 2
      Else
         dest_indIEDest = 9  
      End If  
   End If
   
   'Gera Grupo do Destinatário
   Destinatario = objNFeUtil.destinatario310(dest_CNPJ, dest_CPF, dest_idEstrangeiro, dest_xNome, dest_xLgr, dest_nro, dest_xCpl, dest_xBairro, dest_cMun, dest_xMun, dest_UF, dest_CEP, dest_cPais, dest_xPais, dest_fone, dest_indIEDest, dest_IE, dest_IESUF, dest_IM, dest_eMail)
   
   Do While Not Item.EOF
         det_nItem = det_nItem + 1  ' informar o número do item, que deve ser sequencial crescente iniciado em 1 a quantidade máxima de itens é 990
         
         '================Grupo de Detalhe do Produto (Grupo I01 do Manual de Integração - páginas 95)=======================
         Prod_cProd = Item![Sequencia Do Produto]    ' código do produto
         'Não Usam esse Campo usam Apenas no Sistema para Consulta
         'LEMBRANDO: Se for colocar esse campo na NFe, alguns Código de Barras está incorreto arrumar antes
         Prod_cEAN = "" ' código EAN (0, 8,12, 13 ou 14 caracteres), o conteúdo pode ser omitido se não tiver EAN
         Prod_xProd = SuperTiraAcentos(Substitui(Trim(Item![Descrição Produto]), "&", "E", UM_A_UM)) ' código do produto, espaços em branco consecutivos ou no início ou fim do campo podem gerar erro de Schema XML, além de caracteres reservados do XML <>&"'
         Prod_NCM = Item!Ncm                         ' código NCM, pode informar somente a posição do capítulo se a operação não for sujeito ao IPI.
         Prod_Cest = Item!Cest  
         Prod_NVE_Opc = ""                           ' Campo Opcional 
         Prod_ExTIPI = ""                            ' ExTipi, informar de acordo com o código EX da TIPI se houver para o NCM do produto.
         Prod_CFOP = Item!Cfop                       ' CFOP do operação, causa erro de XML se informado um código inexistente
         Prod_uCOM = Item![Descrição Unidade]        ' unidade de comercialização
         Prod_qCom = Item!Quantidade                 ' quantidade de comercialização
         Prod_vUnCom = Item![Valor unitario]         ' valor unitário de comercialização, campo de mera demonstração deve ser o resultado da divisão do vProd / qCom
         Prod_vProd = Item![Valor total]             ' valor do total do item
         'Não Usam esse Campo usam Apenas no Sistema para Consulta
         'LEMBRANDO: Se for colocar esse campo na NFe, alguns Código de Barras está incorreto arrumar antes
         Prod_cEANTrib = ""' código EAN (0, 8,12, 13 ou 14 caracteres), o conteúdo pode ser omitido se não tiver EAN, em geral é o mesmo código do EAN de comercialização
         Prod_uTrib = Item![Descrição Unidade]       ' unidade de tributação, na maioria dos casos é idêntico  ao vUnCom
         Prod_qTrib = Item!Quantidade                ' quantidade de comercialização
         Prod_vUnTrib = Item![Valor Unitario]        ' valor unitário de tributação, campo de mera demonstração deve ser o resultado da divisão do vProd / qTrib
         
         If Nota_Fiscal![Valor Do Frete] > 0 Then
            TotalDosItens = Nota_fiscal![Valor total dos produtos]
            PercentualRateio = Nota_Fiscal![Valor Do Frete] / TotalDosItens * 100
            Prod_vFrete = Round((Prod_vProd * PercentualRateio / 100),2)
         End If
          
         If Nota_Fiscal![Valor Do desconto] > 0 Then
            TotalDosItens = Nota_fiscal![Valor total dos produtos] 
            PercentualRateio = Nota_fiscal![Valor Do desconto] / TotalDosItens * 100
            Prod_vDesc = Round((Prod_vProd * PercentualRateio / 100),2) ' valor do desconto concedido   
         End If
         
 
         If Not Nota_fiscal![Nfe complementar] Or Prod_vUnCom > 0 Then
            Prod_indTot = 1                          ' indicador se o valor do item será totalizado no valor total dos produtos
         End If
                  
         Prod_DetEspecifico = ""                     ' dados específicos, informar para medicamento, veículos novos, armamentos e combustíveis, para montar o grupo utilizar a funcionalidade correspondente
         Prod_xPed = ""                              ' número do pedido, uso exclusivo do usuário
         Prod_nItemPed = 0                           ' número do item do pedido, uso exclusivo do usuário   
         Prod_nFCI_Opc = ""                          ' Campo Novo Layout 3.10 Opcional
         Prod_detExport_Opc = ""                     ' Campo novo sei la pra que serve o importante é que pode informar Vazio "" 
         Prod_vSeguro = 0
         Prod_vOutro = 0
         Prod_DI = ""
         If Item!Usado Then Usado = True
      
         'Gera Grupo do Produto
         det_produto = objNFeUtil.produtoNT2015003(Prod_cProd, Prod_cEAN, Prod_xProd, Prod_NCM, Prod_NVE_Opc, Prod_Cest, Prod_ExTIPI, Prod_CFOP, Prod_uCOM, Prod_qCom, Prod_vUnCom, Prod_vProd, Prod_cEANTrib, Prod_uTrib, Prod_qTrib, Prod_vUnTrib, Prod_vFrete, Prod_vSeguro, Prod_vDesc, Prod_vOutro, Prod_indTot, Prod_DI, Prod_detExport_Opc, Prod_DetEspecifico, Prod_xPed, Prod_nItemPed, prod_nFCI_Opc)
         
         '========Grupo de Informações do Imposto do Item=========
         
         '=========Dados do ICMS (Grupo N01 do Manual de Integração - Páginas 128-)=====================
         'Bom se nw for importação entao vai ser 0 a origem, senao vai ser 1
         If Not Mid(NatOpe!Cfop, 1, 1) = "3" And Item!Importado = 0 Then
            icms_orig = "0"                             ' Tabela A - origem da mercadoria 0=nacional
         Else
            icms_orig = "1"                             ' Tabela A - origem da mercadoria 1=Estrangeiro
         End If
         
         If Not Parametros_da_nfe![Simples nacional] Then
            If Len(Item!CST) <= 2 Then
               icms_CST = Format(Item!Cst, "00")           ' Tabela B
            Else
               icms_CST = Format(Mid(Item!Cst, 2, 2), "00") ' Tabela B
            End If
         End If
         
         If Parametros_da_nfe![Simples nacional] Then
            icms_CST = Format(Item!Cst, "000")           ' Tabela B  
         End If
         
         icms_modBC = 3                              ' modalidade de determinação da BC = 3-valor da operação
         icms_pRedBC = Item![Percentual da redução]  ' percentual de redução da BC
         icms_vBC = Item![Valor da base de calculo]  ' valor da BC do ICMS = vProd + vFrete + vSeguro + vOutro
         icms_pICMS = Item![Aliquota Do icms]        ' alíquota do ICMS
         icms_vICMS = Item![Valor Do icms]           ' valor do ICMS
         icms_modBCST = 4                            ' modalidade de determinação da BC ICMS ST
         icms_pmVAST = Item!Iva                      ' percentual de valor de margem e valor adicionado
         icms_pRedBCST = 0                           ' percentual de redução da BC do ICMS ST
         icms_vBCST = Item![Base de calculo st]      ' BC do ICMS ST
         icms_pICMSST = Item![Aliquota icms st]      ' percentual do ICMSST
         icms_vICMSST = Item![Valor icms st]         ' valor do ICMS ST devido
         If Item!Cst = "60" Then
           ' icms_vBCSTRet = Prod_vProd + Prod_vSeguro + Prod_vFrete + Prod_vOutro - Prod_vDesc ' informação do ICMS retindo anteriormente por ST
            icms_vBCSTRet = 0 
            icms_vICMSSTRet = 0                      ' estes campos devem ser informado somente no caso do CST = 60 ou CSOSN = 500'
         End If
         icms_motDesICMS = 0                         ' motivo de desoneração do ICMS, só deve ser informado no caso de CST = 40 (isenção condicional)'
         icms_pBCOp = 0                              ' campos para uso nos casos de ICMSPart/ICMSST
         icms_UFST = ""                              '
         icms_vICMSSTDest = 0                        '
         icms_vBCICMSSTDest = 0                      '
         icms_pCredSN = 0                            ' campos exclusivos para emissor optante do Simples Nacional CSOSN= 101, 201 e 900
         icms_vCredICMSSN = 0                        ' não esquecer de informar o CRT=1
         'Alteração Conforme Lei da Transparência 12.741/12
         'Vigor em 01/06/2013
         det_vTotTrib = Item![Valor Dos Tributos]
         icms_vICMSDeson = 0 
         icms_vICMSOp = 0    
         icms_pDif = 0       
         icms_vICMSDif = 0   
         
         ' Partilha do ICMS Fora do Estado Consumidor Final Nw Contribuinte merda de sefaz
         If ide_indFinal = 1 And ide_idDest = 2 And dest_indIEDest = 9 Then                                                               
            ValorBase = Item![Valor da base de calculo]
            FormaCalculo = 3
              If Ano = "16" Then
                  AnoOperacao = 2016
                ElseIf Ano = "17" Then
                  AnoOperacao = 2017
                ElseIf Ano = "18" Then
                  AnoOperacao = 2018
                Else
                  AnoOperacao = 2019  
              End If
              AliqFCP = 0
              If Ano = "16" Then
                  pICMSInterPart = 40
               ElseIf Ano = "17" Then
                  pICMSInterPart = 60
               ElseIf Ano = "18" Then 
                 pICMSInterPart = 80
               Else
                 pICMSInterPart = 100    
              End If   
              AliqDestino = TbIcms![Aliquota interna] ' Aliquota Interna
              If icms_orig = 1 Then ' se for item importado
                 AliqInterstadual = 4
              Else
                 AliqInterstadual = TbIcms![Aliquota Do icms] ' Aliquota Intestadual      
              End If
              If ValorBase > 0 Then
                 calcICMSUFDest = objNFeUtil.calcICMSUFDest(FormaCalculo, ValorBase, AliqDestino, AliqInterstadual, AliqFCP, AnoOperacao, vBCUFDest, pFCPUFDest, pICMSUFDest, pICMSInter, pICMSInterPart, vFCPUFDest, vICMSUFDest, vICMSUFRemet, vBCOpeInter, vICMSOpeInter, cResultado, msgResultado)
              Else
                 vICMSUFDest = 0
                 vICMSUFRemet = 0
                 calcICMSUFDest = objNFeUtil.ICMSUFDest(ValorBase, AliqFCP, AliqDestino, AliqInterstadual, pICMSInterPart, vFCPUFDest, vICMSUFDest, vICMSUFRemet)
              End If
           'Totais devem ser amarrados no grupo totalICMSNT2015003
           TotICMSUFDest = TotICMSUFDest + vICMSUFDest
           TotICMSUFRemet = TotICMSUFRemet + vICMSUFRemet
           TotvFCPUFDest = TotvFCPUFDest + vFCPUFDest
          End If
           
         'Gera Grupo do ICMS
         det_icms = objNFeUtil.icms310(icms_orig, icms_CST, icms_modBC, icms_pRedBC, icms_vBC, icms_pICMS, icms_vICMS, icms_modBCST, icms_pmVAST, icms_pRedBCST, icms_vBCST, icms_pICMSST, icms_vICMSST, icms_vBCSTRet, icms_vICMSSTRet, icms_vBCICMSSTDest, icms_vICMSSTDest, icms_motDesICMS, icms_pBCOp, icms_UFST, icms_pCredSN, icms_vCredICMSSN,icms_vICMSDeson, icms_vICMSOp, icms_pDif, icms_vICMSDif)
                  
         '=========Dados do IPI=====================
         ipi_clEnq = ""
         ipi_CNPJProd = ""
         ipi_cSelo = ""
         ipi_qSelo = 0
         ipi_cEnq = "999"
         If Item![Valor Do ipi] > 0 Then
            ipi_CST = "50"
         Else
            Select Case Item!CFOP
               Case "6920", "5920" 'Rem.Vasilhame e Sacaria
                  ipi_CST = "55"
                  ipi_cEnq = "103"
               Case  "5914", "6914"  'Rem. Merc P/ Exp. e Feira
                  ipi_CST = "55"
                  ipi_cEnq = "102"
               Case "5901" ' Rem Para Industr. D. E.
                  ipi_CST = "55"
                  ipi_cEnq = "109"
               Case Else
                  ipi_CST = "99"
                  ipi_cEnq = "999"
            End Select
         End If
         ipi_vBC = Item![Valor total]
         ipi_pIPI = Item![Aliquota Do ipi]
         ipi_qUnid = 0
         ipi_vUnid = 0
         ipi_vIPI = Item![Valor Do ipi]
          
         'Gera Grupo do IPI
         det_IPI = objNFeUtil.IPI(ipi_clEnq, ipi_CNPJProd, ipi_cSelo, ipi_qSelo, ipi_cEnq, ipi_CST, ipi_vBC, ipi_pIPI, ipi_vIPI, ipi_qUnid, ipi_vUnid)
               
         '=========Dados do PIS=====================
         If Item![Valor Do pis] > 0 Then
            pis_CST = "01"
         Else
            pis_CST = "49"
         End If
         pis_vBC = Item![Valor total] + Prod_vFrete - Prod_vDesc 
         pis_pPIS = Empresa![Aliquota Do pis]
         pis_qBCProd = 0
         pis_vAliqProd = 0
         pis_vPIS = Item![Valor Do pis]
         
         'Gera Grupo do PIS
         det_PIS = objNFeUtil.pis(pis_CST, pis_vBC, pis_pPIS, pis_vPIS, pis_qBCProd, pis_vAliqProd)
         
         '=========Dados do COFINS=====================
         If Item![Valor Do cofins] > 0 Then
            cofins_CST = "01"
         Else
            cofins_CST = "49"
         End If
         cofins_vBC = Item![Valor total] + Prod_vFrete - Prod_vDesc 
         cofins_pCOFINS = Empresa![Aliquota Do cofins] 
         cofins_qBCProd = 0
         cofins_vAliqProd = 0
         cofins_vCOFINS = Item![Valor Do cofins]
         
         'Gera Grupo do COFINS
         det_COFINS = objNFeUtil.cofins(cofins_CST, cofins_vBC, cofins_pCOFINS, cofins_vCOFINS, cofins_qBCProd, cofins_vAliqProd)
         
         '==============Dados do Imposto de importação
         det_II = ""
                                    
         'Gera Grupo do Imposto
         'Lei da Transparencia  
         det_imposto = objNFeUtil.impostoNT2015003(det_vTotTrib, det_icms, det_IPI, det_II, det_PIS, det_PISST, det_COFINS, det_COFINSST, det_ISSQN, CalcICMSUFDest)
         
         ' Campos Novos Layout 3.10
         Det_pDevol = 0    ' Campo Opcional uhuu
         Det_vIPIDevol = 0 ' Campo Opcional uhuu
         
         'Gera Grupo de Detalhamento do Produto
         Detalhes = Detalhes & objNFeUtil.detalhe310(det_nItem, det_produto, det_imposto, det_infAdProd, Det_pDevol, Det_vIPIDevol)
         
    Item.MoveNext
    Loop
    
   '=========Totais da NFe=====================
   vBC = Nota_fiscal![Valor total da bc] 
   vICMS = Nota_fiscal![Valor total Do icms]
   vBCST = Nota_fiscal![Valor total base st]
   vST = Nota_fiscal![Valor total icms st] 
   vProd = Nota_fiscal![Valor total dos produtos] 
   vFrete = Nota_fiscal![Valor Do frete]
   vSeg = 0
   vDesc = Nota_fiscal![Valor Do desconto]
   vII = 0
   vIPI = Nota_fiscal![Valor total Do ipi]
   vPIS = Nota_fiscal![Valor total Do pis]
   vCOFINS = Nota_fiscal![Valor total Do cofins]
   vOutro = 0
   vTotTrib = Nota_fiscal![Valor total dos tributos]
   vNF = Nota_fiscal![Valor total da nfe]
   vICMSDeson = 0
   
   'Gera Total ICMS
   'Lei da Transparencia
    totalICMS = objNFeUtil.totalICMSNT2015003(vBC, vICMS, vBCST, vST, vProd, vFrete, vSeg, vDesc, vII, vIPI, vPIS, vCOFINS, vOutro, vNF, vTotTrib, vICMSDeson, TotICMSUFDest, TotICMSUFRemet, TotvFCPUFDest)
    'Gera Totais da NFe
    Total = objNFeUtil.Total(totalICMS, ISSQNTot, retTrib)
    
       '=========Dados da Transportadora=====================
      If Transportadora!Tipo = 0 Then
         TransCPF = RemoveCaracteres(Transportadora![CPF e CNPJ])
      Else
         TransCNPJ = RemoveCaracteres(Transportadora![CPF e CNPJ])
         TransIE = RemoveCaracteres(Transportadora![RG e IE])
      End If
      TransxNome = Substitui(SuperTiraAcentos(Trim(Transportadora![Razão Social])), "&", "E", 1)
      TransxEnder = RemoveCaracteres(SuperTiraAcentos(Trim(Transportadora!Endereço)), True)
      TransxMun = RemoveCaracteres(SuperTiraAcentos(Trim(Transportadora!Municipio)), True)
      TransUF = Transportadora!UF
     'Gera Dados da Transportadora
      transporta = objNFeUtil.transporta(TransCNPJ, TransCPF, TransxNome, TransIE, TransxEnder, TransxMun, TransUF)
   
     'Dados do Frete
      modFrete = IIf(Nota_fiscal!Frete = "Emitente", 0, 1)
      
      '=========Dados do Veiculo=====================
      If Not Vazio(Nota_fiscal![Placa Do veiculo]) And Not Vazio(Nota_fiscal![Uf Do veiculo]) Then
      placa = RemoveCaracteres(SuperTiraAcentos(UCase(Nota_fiscal![Placa Do veiculo])))
      veicUF = Nota_fiscal![Uf Do veiculo]
      RNTC = Transportadora![Codigo da antt]
    
      'Gera Dados do Veiculo
      veicTransp = objNFeUtil.veicTransp(placa, veicUF, RNTC)
      End If
   
     '=========Dados do Volume=====================
     qVol = Nota_fiscal!Volumes
     esp = RemoveCaracteres(SuperTiraAcentos(Nota_fiscal!Especie))
     marca = ""
     nVol = ""
     pesoL = Nota_fiscal![Peso liquido] 
     pesoB = Nota_fiscal![Peso bruto]
   
    'Gera Dados do Volume
     vol = objNFeUtil.vol(qVol, esp, marca, nVol, pesoL, pesoB, lacres)
   
    'Gera Transporte
     transp = objNFeUtil.transportador2G(modFrete, transporta, retTransp, veicTransp, reboque, vagao, balsa, vol)
     
      '=========Dados das Informações Adicionais=====================
      If Not Nota_fiscal![Nfe complementar] Then
         infAdFisco = ReservadoFisco(Usado, Reducao, Cliente![Consumidor Final], Cliente!Isento, TotICMSUFDest, TotICMSUFRemet)
        If dest_indIEDest = 2 Then 
           infCpl = infCpl & "Cliente Inscricao Estadual ISENTO.;"
        End If   
      Else
         infAdFisco = "NFe de COMPLEMENTO emitida para complementar a NFe:;"
         infAdFisco = infAdFisco & Nota_fiscal![Chave nfe referenciada]
      End If
      If Parametros_da_nfe![Simples nacional] Then
         infCpl = infCpl & "Valor Aproximado dos Tributos: R$ " & Round((Valor_total_da_nfe  * Parametros_da_nfe![Percentual tributos] / 100),2) & " "
      End If
      infCpl = infCpl & Substitui(Substitui(SuperTiraAcentos(Trim(Nota_fiscal!Historico)), vbCrLf, ".;", 1), "&", "E", 1)
      'Gera Informações Adicionais
      infAdic = objNFeUtil.infAdic2G(infAdFisco, infCpl, obsCont, obsFisco, procRef)
   
   '=========Dados da Fatura=====================
    If Parcelas.RecordCount > 0 Then
       nFat = Format(Nota_fiscal![Numero da nfe], "000000")
       vOrig = Nota_fiscal![Valor total da nfe]
       vLiq =  Nota_fiscal![Valor total da nfe]
      '=========Dados da Duplicata=====================
       Parcelas.MoveFirst
       Do While Not Parcelas.EOF
          nDup = Parcelas![Numero da parcela]
          dVenc = Parcelas![Data de vencimento]
          vDup = Parcelas![Valor da parcela]
         'Gera Duplicata
          dup = dup & objNFeUtil.dup(nDup, dVenc, vDup)
          Parcelas.MoveNext
       Loop
      'Gera Cobrança
      cobr = objNFeUtil.cobr(nFat, vOrig, vDesc, vLiq, dup)
    End If
   exporta = ""
   
   '=========Dados da Nota Fiscal Eletrônica=====================
   id = chaveNFe
   versao = "3.10"
   Pag = ""
   autXml = ""
   'ufa finalmente
   'Gera Consolidação da NFe
    NFe = objNFeUtil.NFe310(versao, id, ide, emitente, avulsa, destinatario, retirada, entrega, Detalhes, Total, transp, cobr, Pag, infAdic, exporta, compra, cana, autXml)
   
    'Salvando o xml...
    Arq = FreeFile
    If Parametros_da_nfe!ambiente = 0 Then 'Produção
       If Dir(Parametros_da_nfe![Diretorio 2 nfe produção] & Format(Nota_fiscal![Numero da nfe], "000000") & "_GERADO.xml", vbArchive) <> "" Then Kill Parametros_da_nfe![Diretorio 2 nfe produção] & Format(Nota_fiscal![Numero da nfe], "000000") & "_GERADO.xml"
       Open Parametros_da_nfe![Diretorio 2 nfe produção] & Format(Nota_fiscal![Numero da nfe], "000000") & "_GERADO.xml" For Append As #Arq
         Print #Arq, NFe
       Close #Arq
    Else 'Homologação
       If Dir(Parametros_da_nfe![Diretorio 2 nfe homologação] & Format(Nota_fiscal![Numero da nfe], "000000") & "_GERADO.xml", vbArchive) <> "" Then Kill Parametros_da_nfe![Diretorio 2 nfe homologação] & Format(Nota_fiscal![Numero da nfe], "000000") & "_GERADO.xml"
       Open Parametros_da_nfe![Diretorio 2 nfe homologação] & Format(Nota_fiscal![Numero da nfe], "000000") & "_GERADO.xml" For Append As #Arq
         Print #Arq, NFe
       Close #Arq
    End If
   
    'Histórico
    With vgTb
       .Edit
       If Vazio(!Observação) Then
          !Observação = "Gerando XML..."
       Else
          !Observação = !Observação & vbCrLf & "=================================================="
          !Observação = !Observação & vbCrLf & vbCrLf & "Gerando XML..."
       End If
      .Update
      .BookMark = .LastModified
    End With
   
    TransmitirNFe310 NFe, chaveNFe 
         
 DeuErro:
   If Err <> 0 Then
      MsgBox Err.Description, vbCritical + vbOKOnly, vaTitulo
   End If
   
 SaiDaSub:
   Reposition
   Screen.MousePointer = vbDefault ' normal
   Set objNFeUtil = Nothing
   If Parametros_da_NFe!ambiente = 0 Then
      lblProgresso.Caption = ""
   Else
      lblProgresso.Caption = "AMBIENTE NFe EM MODO TESTE"
   End If
End Sub


'Dados Adicionais da NFe
Private Function ReservadoFisco(Usado As Boolean, Reducao As Boolean, Optional ConsumidorFinal As Boolean, Optional Isento As Boolean, Optional IcmsDest As Double, Optional IcmsRemet As Double) As String
   Dim Natureza As New GRecordSet, IPIZero As Boolean, TbGeral As New GRecordSet
   Dim NFe As New GRecordSet, ProdutosNFe As New GRecordSet, Suframa As Boolean
   Dim VrCredSN As Double
   
   On Error Resume Next
   
   Set TbGeral = vgDb.OpenRecordSet("SELECT * FROM Geral WHERE [Sequencia do geral] = " & Sequencia_do_geral)
   Suframa =(CBool(Not Vazio(TbGeral![Codigo Do suframa])))    
   Set ProdutosNFe = vgDb.OpenRecordSet("SELECT * FROM [Produtos da nota fiscal] WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal)
   Set NFe = vgDb.OpenRecordSet("SELECT * FROM [Nota fiscal] WHERE [Sequencia da Nota Fiscal] = " & Sequencia_da_nota_fiscal)
   
   Set Natureza = vgDb.OpenRecordSet("SELECT DISTINCT CFOP FROM [Produtos da nota fiscal] " & _
                                     "WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal)
                                                                  
   
   If Usado Then ReservadoFisco = ReservadoFisco & _
      "Material Usado Adquirido de Terceiro;"
   
   If Parametros_da_nfe![Simples nacional] Then
      VrCredSN = Round((Nota_fiscal![Valor total dos produtos] * Parametros_da_nfe![Aliquota simples nacional] / 100),2)
   End If
   
   If Parametros_da_nfe![Simples nacional] Then
    If TbGeral!Tipo = 1 And Not TbGeral!Isento Then 
      ReservadoFisco = ReservadoFisco & _
      "Empresa Optante pelo Simples Nacional, Conforme lei compl. 128 de 19/12/2008, Permite o Aproveitamento do Credito ;" & _
      "de ICMS no Valor de R$" & Format(VrCredSN, "##,###,##0.00") & "  Correspondente ao Percentual de " & Parametros_da_nfe![Aliquota simples nacional] & "% Nos Termos do Art. 23 - LC 123/2006 (Resolucoes CGSN n. 10/2007 e 53/2008).;"
    End If
   End If
   
   If Parametros_da_nfe![Simples nacional] Then 
    If (TbGeral!Tipo = 0 Or TbGeral!Isento) Then
      ReservadoFisco = ReservadoFisco & _
      "Empresa Optante pelo Simples Nacional"
    End If  
   End If
   
   If IcmsDest > 0 Then
      ReservadoFisco = ReservadoFisco & "Valores Totais do ICMS Interstadual: DIFAL da UF Destino " & Format(IcmsDest,"##,###,##0.00") & " + DIFAL da UF Origem " & " " & Format(IcmsRemet ,"##,###,##0.00") & ".;"   
   End If 
   
    Do While Not Natureza.EOF
      Select Case Natureza!CFOP
         Case "6915", "5915"
            ReservadoFisco = ReservadoFisco & _
            "Remessa para Conserto.;" & _
            "Mercadoria que Enviamos para Conserto, Devendo Retornar.;" & _
            "Nao Incide ICMS Conforme Art. 7 Inciso X do RICMS, Dl 45490/00 (Rem. P/ Conserto).;"
         Case "6920", "5920"
            ReservadoFisco = ReservadoFisco & _
            "Isento Conforme Art. 82, Anexo I do RICMS/00 (Remessa de vasilhame).;" & _
            "Mercadoria de Nossa Propriedade que Segue, Devendo Retornar.;"
         Case "5403", "6403"
               ReservadoFisco = ReservadoFisco & _
               "Imposto Foi Recolhido Por Substituicao Tributaria Conforme Protocolo ICMS 49/2008, Portaria Cat 44/2008 .;"           
         Case "5912"
            ReservadoFisco = ReservadoFisco & _
            "Mercadoria de Nossa Propriedade Que Segue como Demonstração, Devendo Retornar ICMS - Suspensao Conforme Art. 319 do RICMS/00 (Remessa Demonstracao Dentro do Estado).;"
         Case "5914", "6914"
            ReservadoFisco = ReservadoFisco & _
            "ICMS com Isencao do Imposto de Acordo com o Artigo 33, Anexo I, do Decreto N.: 45.490/2000.;" & _
            "IPI com Suspensao do Imposto de Acordo com o Artigo 43, Inciso II, do RIPI/10.;"
      End Select
      Natureza.MoveNext
   Loop
  
End Function


Public Sub DANFE()
   Dim CC As Byte, ret&, Transportadora As GRecordset
   
   On Error Resume Next
    
   If Numero_da_nfe > 0 Then
      If Nota_cancelada Then
         CC = 1
      Else
         CC = 0
      End If
      
      TbAuxiliar "Geral", "[Sequencia do Geral] = " & Nota_fiscal![Sequencia da transportadora], Transportadora
   
      If Parametros_da_nfe!ambiente = 0 Then 'Produção
         Shell ("C:\unimake\uninfe\UniDANFe.exe arquivo=" & Parametros_da_nfe![Diretorio 1 nfe produção] & Format(Nota_fiscal![Numero da nfe], "000000") & "_AUTORIZADO.xml ee=0 cc=" & CC)'Parametro para ignorar o envio de email ee=0
      Else 'Homologação
         Shell ("C:\unimake\uninfe\UniDANFe.exe arquivo=" & Parametros_da_nfe![Diretorio 1 nfe homologação] & Format(Nota_fiscal![Numero da nfe], "000000") & "_AUTORIZADO.xml ee=0 cc=" & CC)'Parametro para ignorar o envio de email ee=0
      Reposition
      End If 
 End If
 
End Sub

'Busca Retorno NFe 3.10
Private Sub RetornoNFe310(NFeAssinada As String, Recibo As String)
   Dim msgDados As String, msgRetWS As String, msgResultado As String, siglaWS As String, certificado As String
   Dim tpAmbiente As Long, licenca As String, procNFe As String, versao As String, nroProtocolo As String
   Dim dhProtocolo As String, cMsg As String, xMsg As String, objNFeUtil As Object, i As Integer, Arq As Long
   Dim cStat As Long, proxy As String, usuario As String, senha As String, XML As New GRecordset

   On Error GoTo DeuErro
   
   Screen.MousePointer = vbHourglass ' Ampulheta
   Set objNFeUtil = CreateObject("NFe_util_2G.util")
   'Set XML = vgdb.OpenRecordset("SELECT * FROM [Notas Autorizadas]")
   lblProgresso.Caption = "Buscando NFe..."

   licenca = Empresa![Chave flexdocs]
   certificado = Parametros_da_nfe![Certificado digital]
   siglaWS = "SP3"
   versao = "3.10"

   If Parametros_da_nfe!ambiente = 0 Then 'Produção
      tpAmbiente = 1
   Else 'Homologação
      tpAmbiente = 2
   End If
   
   For i = 1 To 5 'Go To Search
      procNFe = objNFeUtil.BuscaNFe2G(siglaWS, tpAmbiente, NFeAssinada, Recibo, certificado, versao, msgDados, msgRetWS, cStat, msgResultado, nroProtocolo, dhProtocolo, cMsg, xMsg, proxy, usuario, senha, licenca)
      'Histórico
      With vgTb
         .Edit
         If Vazio(!Observação) Then
            !Observação = "Buscando Retorno da NFe... Tentativa " & i
         Else
            !Observação = !Observação & vbCrLf & "Buscando Retorno da NFe... Tentativa " & i
         End If
         .Update         
      End With
      If cStat <> 105 Then
         GoTo Continua
      End If
   Next
   MsgBox "NFe NÃO Retornada! Tente Mais Tarde.", vbExclamation + vbOKOnly, vaTitulo
   
   'Histórico
   With vgTb
      .Edit
      If Vazio(!Observação) Then
         !Observação = "Erro ao Buscar Retorno da NFe"
      Else
         !Observação = !Observação & vbCrLf & "Erro ao Buscar Retorno da NFe"
      End If
      .Update
      .BookMark = .LastModified      
   End With
   GoTo SaidaSub

   '           WS chamada com sucesso
   '
   '           105 – lote em processamento -> tentar novamente
   '           106 – lote não localizado   -> tentar enviar o lote novamente ou verificar se o nroRecibo está correto
   '           100 – NF-e autorizada       -> OK
   '           2xx – motivo de rejeição do WS -> erro na elaboração da NF-e, verificar o código de erro e corrigir a NF-e
Continua:
   Select Case cStat
      Case 5001 To 6423                ' erro da DLL
         MsgBox "Descrição do erro: " & Chr(13) & Chr(13) + msgResultado, vbCritical + vbOKOnly, "Atenção: O Retorno da NFe falhou..."
         
         'Histórico
         With vgTb
            .Edit
            If Vazio(!Observação) Then
               !Observação = "Erro ao Buscar Retorno da NFe: " & msgResultado
            Else
               !Observação = !Observação & vbCrLf & "Erro ao Buscar Retorno da NFe: " & msgResultado
            End If
            !Transmitido = False
            .Update
            .BookMark = .LastModified
         End With
         GoTo SaidaSub
      Case 100    ' NF-e autorizada Sucessssooooo
         With Nota_fiscal
            .Edit
            !Autorizada = True
            ![Protocolo de autorização] = nroProtocolo
            ![Data e hora da nfe] = dhProtocolo
            !XmlAutorizado = procNFe
            If Vazio(!Observação) Then
               !Observação = "NFe Autorizada com Sucesso!!!"
            Else
               !Observação = !Observação & vbCrLf & "NFe Autorizada com Sucesso!!!"
            End If
            .Update
            .BookMark = .LastModified
         End With
         
         'Salvando o xml...
         Arq = FreeFile
         If Parametros_da_nfe!ambiente = 0 Then 'Produção
            If Dir(Parametros_da_nfe![Diretorio 2 nfe produção] & Format(Nota_fiscal![Numero da nfe], "000000") & "_ASSINADO.xml", vbArchive) <> "" Then Kill Parametros_da_nfe![Diretorio 2 nfe produção] & Format(Nota_fiscal![Numero da nfe], "000000") & "_ASSINADO.xml"
            Open Parametros_da_nfe![Diretorio 1 nfe produção] & Format(Nota_fiscal![Numero da nfe], "000000") & "_AUTORIZADO.xml" For Append As #Arq
               Print #Arq, procNFe
            Close #Arq
            'With XML
            '   .addNew
            '   ![Sequencia da nota fiscal] = Nota_Fiscal![Sequencia da Nota Fiscal]
            '   !XML = procNFe
            '   .Update               
            'End With
         Else 'Homologação
            If Dir(Parametros_da_nfe![Diretorio 2 nfe homologação] & Format(Nota_fiscal![Numero da nfe], "000000") & "_ASSINADO.xml", vbArchive) <> "" Then Kill Parametros_da_nfe![Diretorio 2 nfe homologação] & Format(Nota_fiscal![Numero da nfe], "000000") & "_ASSINADO.xml"
            Open Parametros_da_nfe![Diretorio 1 nfe homologação] & Format(Nota_fiscal![Numero da nfe], "000000") & "_AUTORIZADO.xml" For Append As #Arq
               Print #Arq, procNFe
            Close #Arq
         End If                 
         
         MsgBox "NFe Autorizada!!!", vbInformation + vbOKOnly, vaTitulo
                          
      Case 101    ' NF-e denegada       
         With Nota_fiscal
            .Edit
            !Autorizada = True
            ![Protocolo de autorização] = nroProtocolo
            ![Data e hora da nfe] = dhProtocolo
            If Vazio(!Observação) Then
               !Observação = "NFe Autorizada com Sucesso!!!"
            Else
               !Observação = !Observação & vbCrLf & "NFe Autorizada com Sucesso!!!"
            End If
            .Update
            .BookMark = .LastModified
         End With 
       
         'Salvando o xml...
         Arq = FreeFile
         If Parametros_da_nfe!ambiente = 0 Then 'Produção
            If Dir(Parametros_da_nfe![Diretorio 2 nfe produção] & Format(Nota_fiscal![Numero da nfe], "000000") & "_ASSINADO.xml", vbArchive) <> "" Then Kill Parametros_da_nfe![Diretorio 2 nfe produção] & Format(Nota_fiscal![Numero da nfe], "000000") & "_ASSINADO.xml"
            Open Parametros_da_nfe![Diretorio 1 nfe produção] & Format(Nota_fiscal![Numero da nfe], "000000") & "_AUTORIZADO.xml" For Append As #Arq
               Print #Arq, procNFe
            Close #Arq
            'With XML
            '   .addNew
            '   ![Seqüência da Nota Fiscal] = Nota_Fiscal![Seqüência da Nota Fiscal]
            '   !XML = procNFe
            '   .Update               
            'End With
         Else 'Homologação
            If Dir(Parametros_da_nfe![Diretorio 2 nfe homologação] & Format(Nota_fiscal![Numero da nfe], "000000") & "_ASSINADO.xml", vbArchive) <> "" Then Kill Parametros_da_nfe![Diretorio 2 nfe homologação] & Format(Nota_fiscal![Numero da nfe], "000000") & "_ASSINADO.xml"
            Open Parametros_da_nfe![Diretorio 1 nfe homologação] & Format(Nota_fiscal![Numero da nfe], "000000") & "_AUTORIZADO.xml" For Append As #Arq
               Print #Arq, procNFe
            Close #Arq
         End If
         
         MsgBox "NFe Denegada!", vbInformation + vbOKOnly, vaTitulo
                               
      Case 106    ' Lote não localizado, verifique se o número do recibo está correto
         MsgBox msgResultado, vbCritical + vbOKOnly, "Atenção: Lote não localizado"
         
         'Histórico
         With vgTb
            .Edit
            If Vazio(!Observação) Then
               !Observação = "Erro ao Buscar Retorno da NFe: " & msgResultado
            Else
               !Observação = !Observação & vbCrLf & "Erro ao Buscar Retorno da NFe: " & msgResultado
            End If
            !Transmitido = False
            .Update
            .BookMark = .LastModified
         End With
         GoTo SaidaSub
      Case 108, 109 'Que feio Servidor
         MsgBox msgResultado & Chr(13) & Chr(13) + "O Web Service está com problemas de recepção.", vbCritical + vbOKOnly, "Atenção: WS com problemas na recepção!"
         
         'Histórico
         With vgTb
            .Edit
            If Vazio(!Observação) Then
               !Observação = "Erro ao Buscar Retorno da NFe: " & msgResultado
            Else
               !Observação = !Observação & vbCrLf & "Erro ao Buscar Retorno da NFe: " & msgResultado
            End If
            !Transmitido = False
            .Update
            .BookMark = .LastModified
         End With
         GoTo SaidaSub
      Case Else
         MsgBox "Descrição do erro: " & Chr(13) & Chr(13) & cStat & " - " & msgResultado, vbCritical + vbOKOnly, "Atenção: O WS rejeitou a NFe..."
         
         'Histórico
         With vgTb
            .Edit
            If Vazio(!Observação) Then
               !Observação = "Erro ao Buscar Retorno da NFe: " & msgResultado
            Else
               !Observação = !Observação & vbCrLf & "Erro ao Buscar Retorno da NFe: " & msgResultado
            End If
            !Transmitido = False
            .Update
            .BookMark = .LastModified
         End With
         GoTo SaidaSub
   End Select
   'Unidanfe
   DANFE
   
DeuErro:
   If Err <> 0 Then
      MsgBox Err.Description, vbCritical + vbOKOnly, vaTitulo
   End If
  
SaidaSub:
   Set objNFeUtil = Nothing
   Screen.MousePointer = vbDefault ' normal
   If Parametros_da_NFe!ambiente = 0 Then
      lblProgresso.Caption = ""
   Else
      lblProgresso.Caption = "AMBIENTE NFe EM MODO TESTE"
   End If   
End Sub


'Transmite NFe 3.10
Private Sub TransmitirNFe310(NFe As String, ChaveNFe As String)
   Dim msgDados As String, msgRetWS As String, msgResultado As String, siglaWS As String, certificado As String
   Dim licenca As String, NFeAssinada As String, nroRecibo As String, cStat As Long, versao As String, dhRecibo As String
   Dim tMed As String, i As Integer, objNFeUtil As Object, Arq As Long, proxy As String, usuario As String, senha As String
   
   On Error GoTo DeuErro
   
   Screen.MousePointer = vbHourglass    ' ampulheta
   lblProgresso.Caption = "Transmitindo NFe..."
   Set objNFeUtil = CreateObject("NFe_util_2G.util")

   certificado = Parametros_da_nfe![Certificado digital] 
   siglaWS = "SP3"
   versao = "3.10"
   licenca = Empresa![Chave flexdocs] 
      
   For i = 1 To 5 'Vamos Tentar 5 vezes
      NFeAssinada = objNFeUtil.EnviaNFe2G(siglaWS, NFe, certificado, versao, msgDados, msgRetWS, cStat, msgResultado, nroRecibo, dhRecibo, tMed, proxy, usuario, senha, licenca)
      'Histórico
      With vgTb
         .Edit
         If Vazio(!Observação) Then
            !Observação = "Transmitindo NFe... Tentativa " & i
         Else
            !Observação = !Observação & vbCrLf & "Transmitindo NFe... Tentativa " & i
         End If
         .Update
         .BookMark = .LastModified
      End With
      If cStat <> 105 Then 'Se o cStat for = 105 entao ainda esta processando
         GoTo Continua
      End If
   Next
   MsgBox "NFe Não Enviada! Tente Mais Tarde.", vbExclamation + vbOKOnly, vaTitulo
   
   'Histórico
   With vgTb
      .Edit
      If Vazio(!Observação) Then
         !Observação = "Erro ao Transmitir NFe"
      Else
         !Observação = !Observação & vbCrLf & "Erro ao Transmitir NFe"
      End If
      .Update
      .BookMark = .LastModified
   End With
   GoTo SaidaSub
                                    
   'Vamos verificar o Resultado
Continua:
   Select Case cStat
      Case 5000 To 7003                ' problemas no envio da DLL para o WS
         MsgBox "Descrição do erro: " & Chr(13) & Chr(13) + msgResultado, vbCritical + vbOKOnly, "Atenção: O envio da NFe falhou..."
         
         'Histórico
         With vgTb
            .Edit
            If Vazio(!Observação) Then
               !Observação = "Erro ao Transmitir NFe: " & msgResultado
            Else
               !Observação = !Observação & vbCrLf & "Erro ao Transmitir NFe: " & msgResultado
            End If
            .Update
            .BookMark = .LastModified
         End With
         GoTo SaidaSub
      Case 103 'Sucesso....
         With Nota_Fiscal
            .Edit
            !Transmitido = True
            ![Numero Do recibo] = nroRecibo
            ![Chave de acesso da nfe] = ChaveNFe
            !XmlAssinado = NFeAssinada 
            .Update
            .BookMark = .LastModified
         End With
      
         MsgBox "Transmitido com Sucesso!!!", vbInformation + vbOKOnly, "Atenção: NFe enviada!"
         
         'Salvando o xml...
         Arq = FreeFile
         If Parametros_da_NFe!ambiente = 0 Then 'Produção
            If Dir(Parametros_da_nfe![Diretorio 2 nfe produção] & Format(Nota_fiscal![Numero da nfe], "000000") & "_GERADO.xml", vbArchive) <> "" Then Kill Parametros_da_nfe![Diretorio 2 nfe produção] & Format(Nota_fiscal![Numero da nfe], "000000") & "_GERADO.xml"
            If Dir(Parametros_da_nfe![Diretorio 2 nfe produção] & Format(Nota_fiscal![Numero da nfe], "000000") & "_ASSINADO.xml", vbArchive) <> "" Then Kill Parametros_da_nfe![Diretorio 2 nfe produção] & Format(Nota_fiscal![Numero da nfe], "000000") & "_ASSINADO.xml"
            Open Parametros_da_nfe![Diretorio 2 nfe produção] & Format(Nota_fiscal![Numero da nfe], "000000") & "_ASSINADO.xml" For Append As #Arq
               Print #Arq, NFeAssinada
            Close #Arq
         Else 'Homologação
            If Dir(Parametros_da_nfe![Diretorio 2 nfe homologação] & Format(Nota_fiscal![Numero da nfe], "000000") & "_GERADO.xml", vbArchive) <> "" Then Kill Parametros_da_nfe![Diretorio 2 nfe homologação] & Format(Nota_fiscal![Numero da nfe], "000000") & "_GERADO.xml"
            If Dir(Parametros_da_nfe![Diretorio 2 nfe homologação] & Format(Nota_fiscal![Numero da nfe], "000000") & "_ASSINADO.xml", vbArchive) <> "" Then Kill Parametros_da_nfe![Diretorio 2 nfe homologação] & Format(Nota_fiscal![Numero da nfe], "000000") & "_ASSINADO.xml"
            Open Parametros_da_nfe![Diretorio 2 nfe homologação] & Format(Nota_fiscal![Numero da nfe], "000000") & "_ASSINADO.xml" For Append As #Arq
               Print #Arq, NFeAssinada
            Close #Arq
         End If
         
         'Histórico
         With vgTb
            .Edit
            If Vazio(!Observação) Then
               !Observação = "Transmitido com Sucesso"
            Else
               !Observação = !Observação & vbCrLf & "Transmitido com Sucesso"
            End If
            .Update
            .BookMark = .LastModified
         End With         
      Case 108, 109 'Que feio Servidor
         MsgBox msgResultado & Chr(13) & Chr(13) + "O Web Service com problemas de recepção", vbCritical + vbOKOnly, "Atenção: WS com problemas na recepção!"
         
         'Histórico
         With vgTb
            .Edit
            If Vazio(!Observação) Then
               !Observação = "Erro ao Transmitir NFe: " & msgResultado
            Else
               !Observação = !Observação & vbCrLf & "Erro ao Transmitir NFe: " & msgResultado
            End If
            .Update
            .BookMark = .LastModified
         End With
         GoTo SaidaSub
      Case Else  ' problemas na recepção do WS
         MsgBox "Descrição do erro: " & Chr(13) & Chr(13) & cStat & " - " & msgResultado, vbCritical + vbOKOnly, "Atenção: O WS rejeitou a NFe..."
         
         'Histórico
         With vgTb
            .Edit
            If Vazio(!Observação) Then
               !Observação = "Erro ao Transmitir NFe: " & msgResultado
            Else
               !Observação = !Observação & vbCrLf & "Erro ao Transmitir NFe: " & msgResultado
            End If
            .Update
            .BookMark = .LastModified
         End With
         GoTo SaidaSub
   End Select
   
  RetornoNFe310 NFeAssinada, nroRecibo 'Retornando
   
DeuErro:
   If Err <> 0 Then
      MsgBox Err.Description, vbCritical + vbOKOnly, vaTitulo
   End If
   
SaidaSub:
   Screen.MousePointer = vbDefault ' normal
   Set objNFeUtil = Nothing
   If Parametros_da_nfe!ambiente = 0 Then 'produção
      lblProgresso.Caption = ""
   Else 'Homologação
      lblProgresso.Caption = "AMBIENTE NFe EM MODO TESTE"
   End If
      
End Sub

Private Function UltimaParcela() As Long
   Dim Tb As New GRecordset

   On Error Resume Next
   
   Set Tb = vgdb.OpenRecordset("SELECT MAX([Numero da parcela]) PC FROM [Parcelas nota fiscal] WHERE [Sequencia da Nota Fiscal] = " & Sequencia_da_nota_fiscal)
   
   If Tb.RecordCount > 0 Then
      UltimaParcela = Tb!PC + 1
   Else
      UltimaParcela = 1
   End If

End Function


Private Function UltimoVencimento() As Variant
   Dim Tb As New GRecordSet, RetVal As Variant
   
   On Error Resume Next
      
   Set Tb = vgDb.OpenRecordSet("SELECT MAX([Data de vencimento]) [Data de Vencimento] FROM [Parcelas nota fiscal] WHERE [Sequencia da nota fiscal] = " & Sequencia_da_Nota_Fiscal)
      
   RetVal = grdParcelamento.ColumnValue(grdParcelamento.Row + 1, grdParcelamento.Col - 1)
      
   If Nota_fiscal![Forma de pagamento] = "Prazo" Then
      If Not IsNull(Tb![Data de Vencimento]) Then
         'Bom Vamos deixar ele colocar qualquer vencimento
         'Soh devemos tomar cuidado para não ser inferior a data de emissão
         'UltimoVencimento = RetVal >= Tb![Data de Vencimento]
         UltimoVencimento = True
      Else
         UltimoVencimento = RetVal >= Nota_fiscal![Data de emissão]
      End If
   Else
      UltimoVencimento = RetVal = Nota_fiscal![Data de emissão]
   End If

End Function


Private Function TotalParcelas(Optional Seq As Integer) As Currency
   Dim Tb As GRecordSet, Total As Currency
   
   Set Tb = vgDb.OpenRecordSet("SELECT Sum([Valor da parcela]) As Total From [Parcelas nota fiscal] Where [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal & " AND " & IIf(Seq > 0, "[Numero da parcela] = " & Seq, "1=1"))
   
   Total = Tb!Total
   
   TotalParcelas = Total

End Function


Private Function PegaSequencial() As Long
Dim Tb As New GRecordSet
 
 If VgSituacao = ACAO_INCLUINDO Then
    Set Tb = VgDb.OpenRecordSet("SELECT MAX([Sequencia da nota fiscal]) Seq From [Nota fiscal]")
    PegaSequencial = Tb!Seq + 1
 End If
 
End Function 
 
Private Sub AbreCancelamento()
   On Error Resume Next
   
   Load frmF_CanNF
   frmF_CanNF.txtNota.Value = Sequencia_da_nota_fiscal
   frmF_CanNF.Show     

End Sub 

Private Sub AbreCCe()
   On Error Resume Next
   
   Load frmCCe
   frmCCe.txtSeqNotaTela.Value = Sequencia_da_nota_fiscal
   frmCCe.Show     

End Sub  

Private Sub DACCE() 
  Dim CCe As New GRecordSet, evento As Byte, Arquivo As String, Principal As Byte
  On Error Resume Next
   
   NFe_Consulta = Nota_fiscal![Numero da nfe] 'Caso abrir a partir da Nota Fiscal entao vamos pegar o numero de lah
         
   If NFe_Consulta > 0 Then
      Set CCe = vgDb.OpenRecordSet("SELECT NF.[Sequencia da Nota Fiscal], CCe.[Numero da Correção], NF.[Numero da NFe] " & _
                                   "FROM [Carta de Correção NFe] CCe INNER JOIN [Nota Fiscal] NF ON CCe.[Sequencia da Nota Fiscal] = NF.[Sequencia da Nota Fiscal] " & _
                                   "WHERE NF.[Numero da NFe] = " & NFe_Consulta & " ORDER BY [Numero da Correção]")
      
      If CCe.RecordCount > 1 Then 'Opa possui mais de um evento bora lah
                          
         CCe.MoveLast 'Pegando o Ultimo Evento
         Principal = CCe![Numero da Correção]
         
         If Parametros_da_NFe!ambiente = 0 Then 'Produção
            Arquivo = "C:\unimake\uninfe\UniDANFe.exe arquivo=" & Parametros_da_NFe![Diretorio 1 NFe Produção] & Format(CCe![Numero da NFe], "000000") & "-" & Format(Principal, "00") & "_CORRECAO.xml ee=0" & " NFe=" & Parametros_da_NFe![Diretorio 1 NFe Produção] & Format(NFe_Consulta, "000000") & "_AUTORIZADO.xml"
         Else 'Homologação
            Arquivo = "C:\unimake\uninfe\UniDANFe.exe arquivo=" & Parametros_da_NFe![Diretorio 1 NFe Homologação] & Format(CCe![Numero da NFe], "000000") & "-" & Format(Principal, "00") & "_CORRECAO.xml ee=0" & " NFe=" & Parametros_da_NFe![Diretorio 1 NFe Homologação] & Format(NFe_Consulta, "000000") & "_AUTORIZADO.xml"
         End If
           
         CCe.MoveFirst: evento = 2
                     
         'Vamos Capturar todos os Eventos
         Do While Not CCe.EOF
            If CCe![Numero da Correção] = Principal Then Exit Do 'Se Caiu no Principal é pq é Ultimo Evento e não devemos adicionar ele aqui, já adicionamos em cima
            If Parametros_da_NFe!ambiente = 0 Then 'Produção
               Arquivo = Arquivo & " a" & evento & "=" & Parametros_da_NFe![Diretorio 1 NFe Produção] & Format(CCe![Numero da NFe], "000000") & "-" & Format(CCe![Numero da Correção], "00") & "_CORRECAO.xml"
            Else 'Homologação
               Arquivo = Arquivo & " a" & evento & "=" & Parametros_da_NFe![Diretorio 1 NFe Homologação] & Format(CCe![Numero da NFe], "000000") & "-" & Format(CCe![Numero da Correção], "00") & "_CORRECAO.xml"
            End If
            evento = evento + 1
            CCe.MoveNext
         Loop
         
         Shell (Arquivo) 'Abrindo "DACCE"
         
      ElseIf CCe.RecordCount = 1 Then 'Se tem apenas um Evento aí fica mais facil
         If Parametros_da_NFe!ambiente = 0 Then 'Produção
            If Dir(Parametros_da_NFe![Diretorio 1 NFe Produção] & Format(NFe_Consulta, "000000") & "_AUTORIZADO.xml", vbArchive) <> "" Then
               Shell ("C:\unimake\uninfe\UniDANFe.exe arquivo=" & Parametros_da_NFe![Diretorio 1 NFe Produção] & Format(NFe_Consulta, "000000") & "-" & Format(CCe![Numero da Correção], "00") & "_CORRECAO.xml ee=0" & " NFe=" & Parametros_da_NFe![Diretorio 1 NFe Produção] & Format(NFe_Consulta, "000000") & "_AUTORIZADO.xml")
            End If
         Else 'Homologação
            If Dir(Parametros_da_NFe![Diretorio 1 NFe Homologação] & Format(NFe_Consulta, "000000") & "_AUTORIZADO.xml", vbArchive) <> "" Then
               Shell ("C:\unimake\uninfe\UniDANFe.exe arquivo=" & Parametros_da_NFe![Diretorio 1 NFe Homologação] & Format(NFe_Consulta, "000000") & "-" & Format(CCe![Numero da Correção], "00") & "_CORRECAO.xml ee=0" & " NFe=" & Parametros_da_NFe![Diretorio 1 NFe Homologação] & Format(NFe_Consulta, "000000") & "_AUTORIZADO.xml")
            End If
         End If
      Else 'Nw tem Evento Vamos Notificar
         MsgBox "Essa NFe NÃO Possui Correções.", vbExclamation + vbOKOnly, vaTitulo
      End If
   Else 'Nw Enviou
      MsgBox "Essa Nota Fiscal NÃO foi Autorizada.", vbExclamation + vbOKOnly, vaTitulo
   End If   
End Sub 


Private Sub DeletaGrids()
 
 If VgSituacao = ACAO_EXCLUINDO Then
   If Produtos_da_nota_fiscal.RecordCount > 0 Then
    vgDb.Execute "DELETE FROM [Produtos da nota fiscal] WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal
   End If 
   If Parcelas_nota_fiscal.RecordCount > 0 Then  
    vgDb.Execute "DELETE FROM [Parcelas nota fiscal] WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal
   End If                 
 End If
End Sub


Private Function MostraMesAno(Sequencia_da_nota_fiscal As Long, Chave_da_nfe As String) As String
 Dim Ano As String, Mes As String
 
 Ano = Mid(Chave_da_NFe,3,2)
 Mes = Mid(Chave_da_NFe,5,2)
 
 MostraMesAno = Mes & "/" & Ano
  
End Function

Private Function MostraNroNFe(Sequencia_da_nota_fiscal As Long, Chave_da_nfe As String) As String
 Dim nNFe As Long
 nNFe = Mid(Chave_da_NFe,29,6)
 MostraNroNFe = Format(nNFe, "0000000")
End Function


Private Function MostraUFNFe(Sequencia_da_nota_fiscal As Long, Chave_da_nfe As String) As String
Dim CodUF As String
 CodUF = Mid(Chave_da_NFe,1,2)
  If CodUF = "11" Then
    MostraUFNFe = "RO"
  ElseIf CodUF = "12" Then
    MostraUFNFe = "AC" 
  ElseIf CodUF = "13" Then
    MostraUFNFe = "AM" 
  ElseIf CodUF = "14" Then
    MostraUFNFe = "RR" 
  ElseIf CodUF = "15" Then
    MostraUFNFe = "PA" 
  ElseIf CodUF = "16" Then
    MostraUFNFe = "AP"
  ElseIf CodUF = "17" Then
    MostraUFNFe = "TO"   
  ElseIf CodUF = "21" Then
    MostraUFNFe = "MA" 
  ElseIf CodUF = "22" Then
    MostraUFNFe = "PI" 
  ElseIf CodUF = "23" Then
    MostraUFNFe = "CE" 
  ElseIf CodUF = "24" Then
    MostraUFNFe = "RN" 
  ElseIf CodUF = "25" Then
    MostraUFNFe = "PB" 
  ElseIf CodUF = "26" Then
    MostraUFNFe = "PE"  
  ElseIf CodUF = "27" Then
    MostraUFNFe = "AL"  
  ElseIf CodUF = "28" Then
    MostraUFNFe = "SE"   
  ElseIf CodUF = "29" Then
    MostraUFNFe = "BA"   
  ElseIf CodUF = "31" Then
    MostraUFNFe = "MG"
  ElseIf CodUF = "32" Then
    MostraUFNFe = "ES"          
  ElseIf CodUF = "33" Then
    MostraUFNFe = "RJ"  
  ElseIf CodUF = "35" Then
    MostraUFNFe = "SP"   
  ElseIf CodUF = "41" Then
    MostraUFNFe = "PR" 
  ElseIf CodUF = "42" Then
    MostraUFNFe = "SC" 
  ElseIf CodUF = "43" Then
    MostraUFNFe = "RS"
  ElseIf CodUF = "50" Then
    MostraUFNFe = "MS"    
  ElseIf CodUF = "51" Then
    MostraUFNFe = "MT"    
  ElseIf CodUF = "52" Then
    MostraUFNFe = "GO"    
  ElseIf CodUF = "53" Then
    MostraUFNFe = "DF"                          
  End If  
End Function


Private Function ValidaChave(Sequencia_da_nota_fiscal As Long, Chave_da_nfe As String) As Boolean

 If Len(Chave_da_nfe) < 44 Or Len(Chave_da_nfe) > 44 Then 
    ValidaChave = False
 End If
    If Vazio(Chave_da_nfe) Then
       ValidaChave = False
    End If
 If Len(Chave_da_nfe) = 44 Then
    ValidaChave = True
 End If 
 
End Function  


Private Sub SuperAtualizaProdutos()
 If Not Nota_fiscal![Nota avulsa] Then
    AjustaValores
 End If
End Sub 

Private Sub DefineCFOP()
 Dim Tb As New GRecordSet, NatOp As New GRecordSet
 
   If Produtos_da_nota_fiscal.RecordCount = 0 Then: Exit Sub
   If Nota_avulsa Then: Exit Sub

      Set Tb = vgDb.OpenRecordSet("SELECT DISTINCT CFOP FROM [Produtos da nota fiscal] " & _
                                  "WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal)
                                                         
      TbAuxiliar "Natureza de Operação", "[Cfop] = " & Tb!Cfop, NatOp
                                     
   If Sequencia_da_natureza = 0 Then
      vgDb.Execute "Update [Nota Fiscal] Set [Sequencia da Natureza] = " & NatOp![Sequencia da Natureza] & " Where [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal     
   End If                                    
                                     
End Sub


Private Sub MontaDevolucao()
 Dim NatOp As New GRecordSet, Geral As New GRecordSet, ForaEstado As Boolean
 Dim Municipio As New GRecordSet
 
  If Produtos_da_nota_Fiscal.RecordCount = 0 Then : Exit Sub
 
    Set Geral = VgDb.OpenRecordSet("SELECT * From Geral Where [Sequencia do Geral] = " & Nota_fiscal![Sequencia Do geral])
    Set Municipio = VgDb.OpenRecordSet("SELECT * From Municipios Where [Sequencia do Municipio] = " & Geral![Sequencia Do Municipio])
    ForaEstado = Municipio!UF <> "SP"
 
   vgDb.BeginTrans
    
        If Not ForaEstado Then
           vgDb.Execute "Update [Produtos da Nota Fiscal] Set Cfop = 1201 WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal
        Else
           vgDb.Execute "Update [Produtos da Nota Fiscal] Set Cfop = 2201 WHERE [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal  
        End If
       
        If Not ForaEstado Then
           Set NatOp = VgDb.OpenRecordSet("SELECT * From [Natureza de Operação] Where Cfop = " & 1201)
        Else
           Set NatOp = VgDb.OpenRecordSet("SELECT * From [Natureza de Operação] Where Cfop = " & 2201)
        End If
         
      vgDb.Execute "Update [Nota Fiscal] Set [Sequencia da Natureza] = " & NatOp![Sequencia da Natureza] & " Where [Sequencia da nota fiscal] = " & Sequencia_da_nota_fiscal    
     Reposition True  
   vgDb.CommitTrans  
 
End Sub

Public Sub LigaDesligaBotoes
   Botao( 0 ).Enabled =    Botao( 0 ).Enabled And Permitido("Natureza de operação", ACAO_NAVEGANDO)
   Botao( 1 ).Enabled =    Botao( 1 ).Enabled And Permitido("Geral", ACAO_NAVEGANDO)
   Botao( 2 ).Enabled =    Botao( 2 ).Enabled And Permitido("Geral", ACAO_NAVEGANDO)
End Sub

Public Property Get txtCampoTab(Index As Integer) As FormataCampos   
   Set txtCampoTab = txtCampo(Index)
End Sub

'inicializa variaveis (apelidos) coms os campos correspondentes
Private Sub InicializaApelidos(vgComOQue As Integer)
   On Error Resume Next                           'prepara para possíveis erros
   If (vgTb.RecordCount > 0 And vgTb.Eof = False And vgTb.Bof = False) Or vgComOQue = COM_TEXTBOX Then
      If vgComOQue = COM_TEXTBOX Then
         Sequencia_da_nota_fiscal = txtCampo(33).Value
         Numero_da_nfe = Iif(vgSituacao = ACAO_INCLUINDO,0, vgTb![Numero da nfe])
         Data_de_emissao = txtCampo(34).Value
         Sequencia_do_geral = txtCampo(35).Value
         Sequencia_da_natureza = txtCampo(0).Value
         Sequencia_da_transportadora = txtCampo(4).Value
         Placa_do_veiculo = txtCampo(6).Value
         Uf_do_veiculo = txtCampo(7).Value
         Frete = txtCampo(5).Value
         Valor_do_frete = txtCampo(17).Value
         Valor_do_desconto = txtCampo(16).Value
         Volumes = txtCampo(11).Value
         Especie = txtCampo(12).Value
         Data_de_saida = txtCampo(2).Value
         Hora_da_saida = txtCampo(1).Value
         Forma_de_pagamento = txtCampo(15).Value
         Historico = txtCampo(36).Value
         Valor_total_do_ipi = txtCampo(18).Value
         Valor_total_do_icms = txtCampo(21).Value
         Valor_total_dos_produtos = txtCampo(19).Value
         Valor_total_da_nfe = txtCampo(37).Value
         Tipo_de_nota = Val(labopcPainel1.Caption)
         Sequencia_da_classificacao = Iif(vgSituacao = ACAO_INCLUINDO,0, vgTb![Sequencia da classificação])
         Nota_cancelada = Iif(vgSituacao = ACAO_INCLUINDO,False, vgTb![Nota cancelada])
         Nota_avulsa = chkCampo(2).Value
         XmlAssinado = Iif(vgSituacao = ACAO_INCLUINDO,"", vgTb!XmlAssinado)
         XmlAutorizado = Iif(vgSituacao = ACAO_INCLUINDO,"", vgTb!XmlAutorizado)
         Peso_bruto = txtCampo(14).Value
         Peso_liquido = txtCampo(13).Value
         Nfe_complementar = chkCampo(0).Value
         Chave_nfe_referenciada = txtCampo(32).Value
         Chave_de_acesso_da_nfe = txtCampo(27).Value
         Protocolo_de_autorizacao = txtCampo(28).Value
         Data_e_hora_da_nfe = txtCampo(29).Value
         Transmitido = Iif(vgSituacao = ACAO_INCLUINDO,False, vgTb!Transmitido)
         Autorizada = Iif(vgSituacao = ACAO_INCLUINDO,False, vgTb!Autorizada)
         Numero_do_recibo = txtCampo(30).Value
         Observacao = txtCampo(31).Value
         Valor_total_da_bc = txtCampo(20).Value
         Valor_total_do_pis = txtCampo(22).Value
         Valor_total_do_cofins = txtCampo(23).Value
         Valor_total_base_st = txtCampo(24).Value
         Valor_total_icms_st = txtCampo(25).Value
         Imprimiu = Iif(vgSituacao = ACAO_INCLUINDO,False, vgTb!Imprimiu)
         Valor_total_dos_tributos = txtCampo(26).Value
         Finalidade_nfe = txtCampo(3).Value
         Devolucao = chkCampo(1).Value
         Data_da_Alteracao = Iif(vgSituacao = ACAO_INCLUINDO,Null, vgTb![Data da Alteração])
         Hora_da_Alteracao = Iif(vgSituacao = ACAO_INCLUINDO,Null, vgTb![Hora da Alteração])
         Usuario_da_Alteracao = Iif(vgSituacao = ACAO_INCLUINDO,"", vgTb![Usuario da Alteração])
      Else
         Sequencia_da_nota_fiscal = IIf(IsNull(vgTb![Sequencia da nota fiscal]), 0, vgTb![Sequencia da nota fiscal])
         Numero_da_nfe = IIf(IsNull(vgTb![Numero da nfe]), 0, vgTb![Numero da nfe])
         Data_de_emissao = vgTb![Data de emissão]
         Sequencia_do_geral = IIf(IsNull(vgTb![Sequencia do geral]), 0, vgTb![Sequencia do geral])
         Sequencia_da_natureza = IIf(IsNull(vgTb![Sequencia da natureza]), 0, vgTb![Sequencia da natureza])
         Sequencia_da_transportadora = IIf(IsNull(vgTb![Sequencia da transportadora]), 0, vgTb![Sequencia da transportadora])
         Placa_do_veiculo = IIf(IsNull(vgTb![Placa do veiculo]), "", vgTb![Placa do veiculo])
         Uf_do_veiculo = IIf(IsNull(vgTb![Uf do veiculo]), "", vgTb![Uf do veiculo])
         Frete = IIf(IsNull(vgTb!Frete), "", vgTb!Frete)
         Valor_do_frete = IIf(IsNull(vgTb![Valor do frete]), 0, vgTb![Valor do frete])
         Valor_do_desconto = IIf(IsNull(vgTb![Valor do desconto]), 0, vgTb![Valor do desconto])
         Volumes = IIf(IsNull(vgTb!Volumes), 0, vgTb!Volumes)
         Especie = IIf(IsNull(vgTb!Especie), "", vgTb!Especie)
         Data_de_saida = vgTb![Data de saida]
         Hora_da_saida = vgTb![Hora da saida]
         Forma_de_pagamento = IIf(IsNull(vgTb![Forma de pagamento]), "", vgTb![Forma de pagamento])
         Historico = IIf(IsNull(vgTb!Historico), "", vgTb!Historico)
         Valor_total_do_ipi = IIf(IsNull(vgTb![Valor total do ipi]), 0, vgTb![Valor total do ipi])
         Valor_total_do_icms = IIf(IsNull(vgTb![Valor total do icms]), 0, vgTb![Valor total do icms])
         Valor_total_dos_produtos = IIf(IsNull(vgTb![Valor total dos produtos]), 0, vgTb![Valor total dos produtos])
         Valor_total_da_nfe = IIf(IsNull(vgTb![Valor total da nfe]), 0, vgTb![Valor total da nfe])
         Tipo_de_nota = IIf(IsNull(vgTb![Tipo de nota]), 0, vgTb![Tipo de nota])
         Sequencia_da_classificacao = IIf(IsNull(vgTb![Sequencia da classificação]), 0, vgTb![Sequencia da classificação])
         Nota_cancelada = IIf(IsNull(vgTb![Nota cancelada]), 0, vgTb![Nota cancelada])
         Nota_avulsa = IIf(IsNull(vgTb![Nota avulsa]), 0, vgTb![Nota avulsa])
         XmlAssinado = IIf(IsNull(vgTb!XmlAssinado), "", vgTb!XmlAssinado)
         XmlAutorizado = IIf(IsNull(vgTb!XmlAutorizado), "", vgTb!XmlAutorizado)
         Peso_bruto = IIf(IsNull(vgTb![Peso bruto]), 0, vgTb![Peso bruto])
         Peso_liquido = IIf(IsNull(vgTb![Peso liquido]), 0, vgTb![Peso liquido])
         Nfe_complementar = IIf(IsNull(vgTb![Nfe complementar]), 0, vgTb![Nfe complementar])
         Chave_nfe_referenciada = IIf(IsNull(vgTb![Chave nfe referenciada]), "", vgTb![Chave nfe referenciada])
         Chave_de_acesso_da_nfe = IIf(IsNull(vgTb![Chave de acesso da nfe]), "", vgTb![Chave de acesso da nfe])
         Protocolo_de_autorizacao = IIf(IsNull(vgTb![Protocolo de autorização]), "", vgTb![Protocolo de autorização])
         Data_e_hora_da_nfe = IIf(IsNull(vgTb![Data e hora da nfe]), "", vgTb![Data e hora da nfe])
         Transmitido = IIf(IsNull(vgTb!Transmitido), 0, vgTb!Transmitido)
         Autorizada = IIf(IsNull(vgTb!Autorizada), 0, vgTb!Autorizada)
         Numero_do_recibo = IIf(IsNull(vgTb![Numero do recibo]), "", vgTb![Numero do recibo])
         Observacao = IIf(IsNull(vgTb!Observação), "", vgTb!Observação)
         Valor_total_da_bc = IIf(IsNull(vgTb![Valor total da bc]), 0, vgTb![Valor total da bc])
         Valor_total_do_pis = IIf(IsNull(vgTb![Valor total do pis]), 0, vgTb![Valor total do pis])
         Valor_total_do_cofins = IIf(IsNull(vgTb![Valor total do cofins]), 0, vgTb![Valor total do cofins])
         Valor_total_base_st = IIf(IsNull(vgTb![Valor total base st]), 0, vgTb![Valor total base st])
         Valor_total_icms_st = IIf(IsNull(vgTb![Valor total icms st]), 0, vgTb![Valor total icms st])
         Imprimiu = IIf(IsNull(vgTb!Imprimiu), 0, vgTb!Imprimiu)
         Valor_total_dos_tributos = IIf(IsNull(vgTb![Valor total dos tributos]), 0, vgTb![Valor total dos tributos])
         Finalidade_nfe = IIf(IsNull(vgTb![Finalidade nfe]), 0, vgTb![Finalidade nfe])
         Devolucao = IIf(IsNull(vgTb!Devolução), 0, vgTb!Devolução)
         Data_da_Alteracao = vgTb![Data da Alteração]
         Hora_da_Alteracao = vgTb![Hora da Alteração]
         Usuario_da_Alteracao = IIf(IsNull(vgTb![Usuario da Alteração]), "", vgTb![Usuario da Alteração])
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
      i = ((Autorizada = 0) AND Nota_cancelada = 0) and Permitido(vgIdentTab, ACAO_EXCLUINDO)
      If Err Then Err.Clear: i = False
      vgTemExclusao = i
      grdBrowse.AllowDelete = i
      .botExclui.Enabled = i
      .Menu_Exclui.Enabled = i
      i = ((Autorizada = 0) AND Nota_cancelada = 0) and Permitido(vgIdentTab, ACAO_EDITANDO)
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
      vgOk = ((Not Vazio(Data_de_emissao)) And (IsDate(Data_de_emissao) Or Vazio(Data_de_emissao)))
      vgMsg$ = "Data de emissão não pode ser vazio!"
      If Not vgOk Then vgColumn = 35
      If vgOk Then
         vgOk = (Sequencia_do_geral > 0)
         vgMsg$ = "Geral Invalido!"
         If Not vgOk Then vgColumn = 36
      End If
      If vgOk Then
         If (Autorizada = 0) AND Nota_Cancelada = 0 Then
            vgOk = ((Not Vazio(Data_de_saida)) And (IsDate(Data_de_saida) Or Vazio(Data_de_saida)))
            vgMsg$ = "Data de saida não pode ser vazio!"
            If Not vgOk Then vgColumn = 3
         End If
      End If
      If vgOk Then
         vgOk = (Finalidade_nfe > 0)
         vgMsg$ = "Finalidade da NFe inválido!"
         If Not vgOk Then vgColumn = 4
      End If
      If vgOk Then
         If Not Vazio(Placa_do_Veiculo) Then
            vgOk = (Not Vazio(Uf_do_veiculo))
            vgMsg$ = "Uf do veiculo inválido!"
            If Not vgOk Then vgColumn = 8
         End If
      End If
      If vgOk Then
         vgOk = (Valor_do_desconto >= 0)
         vgMsg$ = "Valor do desconto inválido!"
         If Not vgOk Then vgColumn = 17
      End If
      If vgOk Then
         vgOk = (Valor_do_frete >= 0)
         vgMsg$ = "Valor do frete inválido!"
         If Not vgOk Then vgColumn = 18
      End If
      If vgOk Then
         If NFe_Complementar = True Then
            vgOk = (Not Vazio(Chave_nfe_referenciada))
            vgMsg$ = "Chave nfe referenciada não pode ser vazio!"
            If Not vgOk Then vgColumn = 33
         End If
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
                  txtCampo(1).Value = Time
         opcPainel1(0).Value = True
         opcPainel1(0).CtPri.TabStop = False
         txtCampo(3).Value = 1
         chkCampo(0).Value = False
         chkCampo(1).Value = False
         txtCampo(33).Value = PegaSequencial()
         txtCampo(34).Value = Date
         chkCampo(2).Value = False
         On Error Goto DeuErro
         InicializaApelidos COM_TEXTBOX
         PoeRelEFiltroCbo 0
         PoeRelEFiltroCbo 3
         PoeRelEFiltroCbo 4
         PoeRelEFiltroCbo 32
         PoeRelEFiltroCbo 35
      End If
   ElseIf vgOq = PEGA_DO_ARQUIVO Then
      If vgTb.RecordCount > 0 And vgTb.EOF = False And vgTb.BOF = False Then
         vgPriVez = True
         vgTb.Resync 1             'adAffectCurrent
         InicializaApelidos COM_REGISTRO
         PoeRelEFiltroCbo 0
         PoeRelEFiltroCbo 3
         PoeRelEFiltroCbo 4
         PoeRelEFiltroCbo 32
         PoeRelEFiltroCbo 35
         For i = 0 To UBound(txtCampo)
            If Len(txtCampo(i).DataField) > 0 Then
               txtCampo(i).SetOriginalValue = True
               txtCampo(i).Value = vgTb.Fields(txtCampo(i).DataField).Value
            End If
         Next
         opcPainel1(Tipo_de_nota).Value = True
         opcPainel1(Tipo_de_nota).CtPri.TabStop = False
         chkCampo(0).Value = Nfe_complementar
         chkCampo(1).Value = Devolucao
         chkCampo(2).Value = Nota_avulsa
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
      Numero_da_nfe = IIf(IsNull(vgTb![Numero da nfe]), 0, vgTb![Numero da nfe])
      InicializaApelidos COM_TEXTBOX
      vgTb![Tipo de nota] = Tipo_de_nota
      Sequencia_da_classificacao = IIf(IsNull(vgTb![Sequencia da classificação]), 0, vgTb![Sequencia da classificação])
      Nota_cancelada = IIf(IsNull(vgTb![Nota cancelada]), 0, vgTb![Nota cancelada])
      vgTb![Nota avulsa] = Nota_avulsa
      XmlAssinado = IIf(IsNull(vgTb!XmlAssinado), "", vgTb!XmlAssinado)
      XmlAutorizado = IIf(IsNull(vgTb!XmlAutorizado), "", vgTb!XmlAutorizado)
      vgTb![Nfe complementar] = Nfe_complementar
      Transmitido = IIf(IsNull(vgTb!Transmitido), 0, vgTb!Transmitido)
      Autorizada = IIf(IsNull(vgTb!Autorizada), 0, vgTb!Autorizada)
      Imprimiu = IIf(IsNull(vgTb!Imprimiu), 0, vgTb!Imprimiu)
      vgTb!Devolução = Devolucao
      Data_da_Alteracao = vgTb![Data da Alteração]
      Hora_da_Alteracao = vgTb![Hora da Alteração]
      Usuario_da_Alteracao = IIf(IsNull(vgTb![Usuario da Alteração]), "", vgTb![Usuario da Alteração])
   ElseIf vgOq = INI_APELIDOS Then
      InicializaApelidos COM_REGISTRO
      ExecutaVisivel
      ExecutaPreValidacao
   ElseIf vgOq = APOS_EDICAO Then
      On Error GoTo DeuErro
      InicializaApelidos COM_REGISTRO
      If Abs(vgSituacao) = ACAO_INCLUINDO Then
         AjustaValores
      ElseIf Abs(vgSituacao) = ACAO_EDITANDO Then
         AjustaValores
      ElseIf Abs(vgSituacao) = ACAO_EXCLUINDO Then
         DeletaGrids
      End If
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

Public Sub CancelGrids()
   Dim i As Integer
   For i = 0 To Grid.Count - 1
      If Grid(i).Status <> ACAO_NAVEGANDO Then
         Grid(i).CancelEdit
      End If
   Next
End Sub

Public Sub SaveGrids()
   Dim i As Integer
   For i = 0 To Grid.Count - 1
      If Grid(i).Status <> ACAO_NAVEGANDO Then
         Grid(i).SaveEdit
      End If
   Next
End Sub

'prepara botões e o formulário para o novo registro
Public Sub Reposition(Optional ForceRebind As Boolean, Optional LockGrids As Boolean = True)
   Dim i As Integer, x As String, MudouFiltro As Boolean, vgCols() As Variant
   On Error GoTo DeuErro
   If vgPriVez Then Exit Sub
   Set Nota_fiscal = vgTb
   If vgSituacao <> ACAO_INCLUINDO And vgSituacao <> ACAO_EDITANDO Then Executar PEGA_DO_ARQUIVO
   If vgSituacao = ACAO_NAVEGANDO Then
      AnalisaCondicoes 
   End If
   On Error Resume Next
   For i = 0 To 2
      Select Case i
         Case 0
            If vgSituacao = ACAO_INCLUINDO Or vgTb.EOF Or vgTb.BOF Or (vgSituacao <> ACAO_EXCLUINDO And vgEmBrowse)          Then
               Grid(0).CloseRecordset
            Else
               x$ = ExecutaGrid(0, vgCols(), ABRE_TABELA_GRID)
               MudouFiltro = (x$ <> Grid(0).SQLSource)
               If Err = 0 And (ForceRebind Or MudouFiltro) And Grid(0).Status = ACAO_NAVEGANDO Then
                  If Len(Grid(0).Recordset.RsSource) > 0 Then
                     Grid(0).CloseRecordSet
                  End If
                  Grid(0).OpenRecordSet x$, CURSOR_TABLE
               End If
            End If
               x$ = ExecutaGrid(0, vgCols(), CONDICOES_ESPECIAIS)
         Case 1
            If vgSituacao = ACAO_INCLUINDO Or vgTb.EOF Or vgTb.BOF Or (vgSituacao <> ACAO_EXCLUINDO And vgEmBrowse)          Then
               Grid(1).CloseRecordset
            Else
               x$ = ExecutaGrid(1, vgCols(), ABRE_TABELA_GRID)
               MudouFiltro = (x$ <> Grid(1).SQLSource)
               If Err = 0 And (ForceRebind Or MudouFiltro) And Grid(1).Status = ACAO_NAVEGANDO Then
                  If Len(Grid(0).Recordset.RsSource) > 0 Then
                     Grid(1).CloseRecordSet
                  End If
                  Grid(1).OpenRecordSet x$, CURSOR_TABLE
               End If
            End If
               x$ = ExecutaGrid(1, vgCols(), CONDICOES_ESPECIAIS)
         Case 2
            If vgSituacao = ACAO_INCLUINDO Or vgTb.EOF Or vgTb.BOF Or (vgSituacao <> ACAO_EXCLUINDO And vgEmBrowse)          Then
               Grid(2).CloseRecordset
            Else
               x$ = ExecutaGrid(2, vgCols(), ABRE_TABELA_GRID)
               MudouFiltro = (x$ <> Grid(2).SQLSource)
               If Err = 0 And (ForceRebind Or MudouFiltro) And Grid(2).Status = ACAO_NAVEGANDO Then
                  If Len(Grid(0).Recordset.RsSource) > 0 Then
                     Grid(2).CloseRecordSet
                  End If
                  Grid(2).OpenRecordSet x$, CURSOR_TABLE
               End If
            End If
               x$ = ExecutaGrid(2, vgCols(), CONDICOES_ESPECIAIS)
      End Select
   Next
   RepositionNF  
   ExecutaVisivel
   ExecutaPreValidacao
   MostraFormulas
   vgTemAlteracaoGrids = Not LockGrids
   If vgEmBrowse And vgSituacao = ACAO_NAVEGANDO And vgFrmImpCons Is Nothing Then grdBrowse.Refresh
DeuErro:
   
End Sub

'executa a pré-validação dos campos
Private Sub ExecutaPreValidacao()
   Dim Ok As Boolean, vgPV As Integer
   On Error Resume Next                           'prepara para possiveis erros
   vgPV = vgPriVez
   vgPriVez = True
   Ok = ((Autorizada = 0) AND Nota_Cancelada = 0)
   txtCampo(1).Enabled = (Ok And txtCampo(1).Editable)
   Ok = ((Autorizada = 0) AND Nota_Cancelada = 0)
   txtCampo(2).Enabled = (Ok And txtCampo(2).Editable)
   Ok = (Not Vazio(Placa_do_Veiculo))
   txtCampo(7).Enabled = (Ok And txtCampo(7).Editable)
   Ok = (NFe_Complementar = True)
   Label(43).Enabled = Ok
   Ok = (NFe_Complementar = True)
   txtCampo(32).Enabled = (Ok And txtCampo(32).Editable)
   Ok = (vgSituacao = ACAO_NAVEGANDO AND (IIf(cmdDanfe.Caption = "DANFE", 1 = 1, Nota_Cancelada = 0)))
   Botao(3).Enabled = Ok
   Ok = (vgSituacao = ACAO_NAVEGANDO AND Numero_da_NFe > 0  AND Not Nota_Cancelada)
   Botao(4).Enabled = Ok
   Ok = (vgSituacao = ACAO_NAVEGANDO AND cmdDanfe.Caption = "DANFE" And Not Nota_Cancelada)
   Botao(5).Enabled = Ok
   If Err Then Err.Clear                          'se houve erro, limpa...
   vgPriVez = vgPV
End Sub

'coloca os campos visíveis segundo a condição
Private Sub ExecutaVisivel()
   On Error Resume Next                           'prepara para possiveis erros
   Label(48).Visible = (False)
   If Err Then Err.Clear                          'se houve erro, limpa...
End Sub

'evento - quando o conteúdo do campo for alterado
Private Sub txtCp_Change(Index As Integer)
   If vgPriVez Or txtCampo(Index).PriVez Then Exit Sub
   If Len(txtCampo(Index).DataField) > 0 Then LigaFocos Me
   InicializaApelidos COM_TEXTBOX                         'inicializa apelidos com o que esta sendo digitado
   txtCampo(Index).Change
   If Index = 0 Or Index = 3 Or Index = 4 Or Index = 5 Or Index = 7 Or Index = 15 Or Index = 32 Or Index = 35 Then
      ExecutaVisivel
      ExecutaPreValidacao
      MostraFormulas
   End If
   Select Case Index
      Case 4
         RepositionNF  
   End Select
End Sub

'evento - quando o campo receber o foco
Private Sub txtCp_GotFocus(Index As Integer)
   If vgSituacao <> ACAO_NAVEGANDO Or (Len(txtCampo(Index).PesqSQLExpression) > 0) Then
      On Error Resume Next
      Select Case Index
         Case 0
            PoeRelEFiltroCbo 0
         Case 1
            If Len(txtCp(1).Text) = 0 Then
               txtCampo(1).Value = Time
               txtCp_Change Index
               InicializaApelidos COM_TEXTBOX
               ExecutaVisivel
               ExecutaPreValidacao
               MostraFormulas
            End If
         Case 2
            If Len(txtCp(2).Text) = 0 Then
               txtCampo(2).Value = Date
               txtCp_Change Index
               InicializaApelidos COM_TEXTBOX
               ExecutaVisivel
               ExecutaPreValidacao
               MostraFormulas
            End If
         Case 3
            PoeRelEFiltroCbo 3
            If Len(txtCp(3).Text) = 0 Then
               txtCampo(3).Value = 1
               txtCp_Change Index
               InicializaApelidos COM_TEXTBOX
               ExecutaVisivel
               ExecutaPreValidacao
               MostraFormulas
            End If
         Case 4
            PoeRelEFiltroCbo 4
         Case 5
            If Len(txtCp(5).Text) = 0 Then
               txtCampo(5).Value = "Destinatario"
               txtCp_Change Index
               InicializaApelidos COM_TEXTBOX
               ExecutaVisivel
               ExecutaPreValidacao
               MostraFormulas
            End If
         Case 32
            PoeRelEFiltroCbo 32
         Case 34
            If Len(txtCp(34).Text) = 0 Then
               txtCampo(34).Value = Date
               txtCp_Change Index
               InicializaApelidos COM_TEXTBOX
               ExecutaVisivel
               ExecutaPreValidacao
               MostraFormulas
            End If
         Case 35
            PoeRelEFiltroCbo 35
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
End Sub


'evento - quando o check for marcado/desmarcado
Private Sub chkCp_Click(Index As Integer)
   If vgPriVez Then Exit Sub
   If chkCampo(Index).Locked Then
      If Index = 0 Then
         chkCampo(0).Value = Nfe_complementar
      ElseIf Index = 1 Then
         chkCampo(1).Value = Devolucao

      ElseIf Index = 2 Then
         chkCampo(2).Value = Nota_avulsa
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
         Case 0
            PoeRelEFiltroCbo 0
         Case 3
            PoeRelEFiltroCbo 3
         Case 4
            PoeRelEFiltroCbo 4
         Case 32
            PoeRelEFiltroCbo 32
         Case 35
            PoeRelEFiltroCbo 35
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
   PosicionaRegistro frmNotaFisc, "Sequencia da nota fiscal", seqRegistro: lblProgresso.Caption = IIf(Parametros_da_NFe!Ambiente = 1, "AMBIENTE NFe EM MODO TESTE", ""): Tipo = Tipo_de_Nota
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
   Caption = LoadGasString(16390)
   vgFormID = 625
   vgIdentTab = "Nota fiscal"
   vgFiltroEmUso = -1
   vgIndDefault = "Sequencia da nota fiscal"
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
   vgUltimoTabIndex = 54
   vgSituacao = ACAO_NAVEGANDO
   Set mmCampo(0).Picture = LoadPicture(LoadGasPicture(7895))
   Set Botao(0).Picture = LoadPicture(LoadGasPicture(7896))
   Set Botao(1).Picture = LoadPicture(LoadGasPicture(7897))
   Set Botao(2).Picture = LoadPicture(LoadGasPicture(7898))
   Set Botao(3).Picture = LoadPicture(LoadGasPicture(7899))
   Set Botao(4).Picture = LoadPicture(LoadGasPicture(7900))
   Set Botao(5).Picture = LoadPicture(LoadGasPicture(7901))
   Set Botao(6).Picture = LoadPicture(LoadGasPicture(7902))
   Set lblNota2 = Label(0)
   Set TxtEnderecoTrans = txtCampo(8)
   Set TxtIETrans = txtCampo(9)
   Set TxtCnpjTrans = txtCampo(10)
   Set GrdProdutos = Grid(0)
   Set lblParcelamento = Label(34)
   Set grdParcelamento = Grid(1)
   Set lblAjuste = Label(48)
   Set cmdDanfe = Botao(3)
   Set cmdCancelar = Botao(4)
   Set lblNNota = txtCampo(38)
   Set lblNota = Label(55)
   Set vgTb = New GRecordSet
   If Len(vgFiltroInicial$) > 0 Then
      vgFiltroInicial$ = vgFiltroInicial$ + " And "
   End If
   vgFiltroInicial$ = vgFiltroInicial$ + Filtro()
   vgFiltroOriginal$ = vgFiltroInicial$
   DefineControles
   vgTooltips.Create
   Label(0).Caption = LoadGasString(16395)
   Tabs(0).TabCaption(0) = LoadGasString(16396)
   Tabs(0).TabCaption(1) = LoadGasString(16397)
   Tabs(0).TabCaption(2) = LoadGasString(16398)
   Tabs(0).TabCaption(3) = LoadGasString(16399)
   Tabs(0).TabCaption(4) = LoadGasString(16400)
   Label(1).Caption = LoadGasString(16401)
   vgTooltips.AddTool txtCampo(0).CtPri, 0, LoadGasString(16402)
   Label(2).Caption = LoadGasString(16403)
   Label(3).Caption = LoadGasString(16404)
   vgTooltips.AddTool txtCampo(1).CtPri, 0, LoadGasString(16405)
   vgTooltips.AddTool txtCampo(2).CtPri, 0, LoadGasString(16406)
   opcPainel1(0).Caption = LoadGasString(16407)
   opcPainel1(1).Caption = LoadGasString(16408)
   Label(4).Caption = LoadGasString(16409)
   Label(5).Caption = LoadGasString(16410)
   Label(6).Caption = LoadGasString(16411)
   vgTooltips.AddTool txtCampo(3).CtPri, 0, LoadGasString(16412)
   Label(7).Caption = LoadGasString(16413)
   vgTooltips.AddTool txtCampo(4).CtPri, 0, LoadGasString(16414)
   Label(8).Caption = LoadGasString(16415)
   vgTooltips.AddTool txtCampo(5).CtPri, 0, LoadGasString(16416)
   Label(9).Caption = LoadGasString(16417)
   vgTooltips.AddTool txtCampo(6).CtPri, 0, LoadGasString(16418)
   Label(10).Caption = LoadGasString(16419)
   vgTooltips.AddTool txtCampo(7).CtPri, 0, LoadGasString(16420)
   Label(11).Caption = LoadGasString(16421)
   Label(12).Caption = LoadGasString(16422)
   Label(13).Caption = LoadGasString(16423)
   Label(14).Caption = LoadGasString(16424)
   vgTooltips.AddTool txtCampo(11).CtPri, 0, LoadGasString(16425)
   Label(15).Caption = LoadGasString(16426)
   vgTooltips.AddTool txtCampo(12).CtPri, 0, LoadGasString(16427)
   Label(16).Caption = LoadGasString(16428)
   vgTooltips.AddTool txtCampo(13).CtPri, 0, LoadGasString(16429)
   Label(17).Caption = LoadGasString(16430)
   vgTooltips.AddTool txtCampo(14).CtPri, 0, LoadGasString(16431)
   Label(18).Caption = LoadGasString(16432)
   vgTooltips.AddTool txtCampo(15).CtPri, 0, LoadGasString(16433)
   Label(19).Caption = LoadGasString(16434)
   vgTooltips.AddTool txtCampo(16).CtPri, 0, LoadGasString(16435)
   Label(20).Caption = LoadGasString(16436)
   vgTooltips.AddTool txtCampo(17).CtPri, 0, LoadGasString(16437)
   Label(21).Caption = LoadGasString(16438)
   vgTooltips.AddTool txtCampo(18).CtPri, 0, LoadGasString(16439)
   Label(22).Caption = LoadGasString(16440)
   vgTooltips.AddTool txtCampo(19).CtPri, 0, LoadGasString(16441)
   Label(23).Caption = LoadGasString(16442)
   vgTooltips.AddTool txtCampo(20).CtPri, 0, LoadGasString(16443)
   Label(24).Caption = LoadGasString(16444)
   vgTooltips.AddTool txtCampo(21).CtPri, 0, LoadGasString(16445)
   Label(25).Caption = LoadGasString(16446)
   vgTooltips.AddTool txtCampo(22).CtPri, 0, LoadGasString(16447)
   Label(26).Caption = LoadGasString(16448)
   vgTooltips.AddTool txtCampo(23).CtPri, 0, LoadGasString(16449)
   Label(27).Caption = LoadGasString(16450)
   vgTooltips.AddTool txtCampo(24).CtPri, 0, LoadGasString(16451)
   Label(28).Caption = LoadGasString(16452)
   vgTooltips.AddTool txtCampo(25).CtPri, 0, LoadGasString(16453)
   Label(29).Caption = LoadGasString(16454)
   vgTooltips.AddTool txtCampo(26).CtPri, 0, LoadGasString(16455)
   Label(30).Caption = LoadGasString(16456)
   Label(31).Caption = LoadGasString(16457)
   Label(32).Caption = LoadGasString(16458)
   Label(33).Caption = LoadGasString(16459)
   Label(35).Caption = LoadGasString(16460)
   Label(36).Caption = LoadGasString(16461)
   Label(37).Caption = LoadGasString(16462)
   Label(38).Caption = LoadGasString(16463)
   Label(39).Caption = LoadGasString(16464)
   vgTooltips.AddTool txtCampo(27).CtPri, 0, LoadGasString(16465)
   Label(40).Caption = LoadGasString(16466)
   vgTooltips.AddTool txtCampo(28).CtPri, 0, LoadGasString(16467)
   Label(41).Caption = LoadGasString(16468)
   vgTooltips.AddTool txtCampo(29).CtPri, 0, LoadGasString(16469)
   Label(42).Caption = LoadGasString(16470)
   vgTooltips.AddTool txtCampo(30).CtPri, 0, LoadGasString(16471)
   vgTooltips.AddTool txtCampo(31).CtPri, 0, LoadGasString(16472)
   vgTooltips.AddTool chkCampo(0).CtPri, 0, LoadGasString(16473)
   chkCampo(0).Caption = LoadGasString(16474)
   Label(43).Caption = LoadGasString(16475)
   vgTooltips.AddTool txtCampo(32).CtPri, 0, LoadGasString(16476)
   vgTooltips.AddTool chkCampo(1).CtPri, 0, LoadGasString(16477)
   chkCampo(1).Caption = LoadGasString(16478)
   Label(44).Caption = LoadGasString(16479)
   vgTooltips.AddTool txtCampo(33).CtPri, 0, LoadGasString(16480)
   Label(45).Caption = LoadGasString(16481)
   vgTooltips.AddTool txtCampo(34).CtPri, 0, LoadGasString(16482)
   Label(46).Caption = LoadGasString(16483)
   vgTooltips.AddTool txtCampo(35).CtPri, 0, LoadGasString(16484)
   Label(47).Caption = LoadGasString(16485)
   vgTooltips.AddTool txtCampo(36).CtPri, 0, LoadGasString(16486)
   Label(48).Caption = LoadGasString(16487)
   Label(49).Caption = LoadGasString(16488)
   Label(50).Caption = LoadGasString(16489)
   Label(51).Caption = LoadGasString(16490)
   Label(52).Caption = LoadGasString(16491)
   Label(53).Caption = LoadGasString(16492)
   Label(54).Caption = LoadGasString(16493)
   vgTooltips.AddTool txtCampo(37).CtPri, 0, LoadGasString(16494)
   vgTooltips.AddTool chkCampo(2).CtPri, 0, LoadGasString(16495)
   chkCampo(2).Caption = LoadGasString(16496)
   Botao(3).Caption = LoadGasString(16497)
   Botao(4).Caption = LoadGasString(16498)
   Botao(5).Caption = LoadGasString(16499)
   Botao(6).Caption = LoadGasString(16500)
   With Grid(0)
      .RowHeight = 285
      .AddControlIgnoreFocus mdiNFE.botCancela.hWnd           'não deixa o grid tentar gravar automaticamente
      .AddControlIgnoreFocus mdiNFE.botSalva.hWnd             'se estiver perdendo o foco para esses botões
      .FullRowSelect = False
      .BorderStyle = 1
      .NavigationAddMode = 1
      .CacheSize = 100
      .SpecialPopupDisabled POP_GRID_COLS Or POP_GRID_BARS Or POP_GRID_STRIPES
      .AllowInsert = Permitido("Produtos da nota fiscal", ACAO_INCLUINDO)
      .AllowEdit= Permitido("Produtos da nota fiscal", ACAO_EDITANDO)
      .AllowDelete = Permitido("Produtos da nota fiscal", ACAO_EXCLUINDO)
      .AddColumn Nothing, , "Produto", "Sequencia do produto", TP_NUMERICO, "", , False, , "DADOSNFE", "Produtos", "Sequencia do produto", "Descrição; Sequencia do produto", "Descrição; Sequencia do produto", "Descrição", "", , "1", "Produtos.[Sequencia do produto]", "", "DADOSNFE", "18", 1, "0", 5250
      .AddColumn Nothing, , "NCM", , TP_CARACTER, , , True, , , , , , , , , , "0", , , , "0", 1, "0", 1170
      .AddColumn Nothing, , "CST", "Cst", TP_NUMERICO, "999", , False, , , , , , , , , , "0", , , , "0", 1, "0", 510
      .AddColumn Nothing, , "CFOP", "Cfop", TP_NUMERICO, "99999", , False, , , , , , , , , , "0", , , , "0", 1, "0", 615
      .AddColumn Nothing, , "Un", , TP_CARACTER, , , True, , , , , , , , , , "0", , , , "0", 1, "0", 510
      .AddColumn Nothing, , "Qtde", "Quantidade", TP_NUMERICO, "999.999,9999", , False, , , , , , , , , , "0", , , , "0", 1, "0", 1095
      .AddColumn Nothing, , "Valor Unitario", "Valor unitario", TP_NUMERICO, "999.999,9999", , False, , , , , , , , , , "0", , , , "0", 1, "0", 1290
      .AddColumn Nothing, , "Valor total", , TP_NUMERICO, "999.999.999,99", , True, , , , , , , , , , "0", , , , "0", 1, "0", 1320
      .AddColumn Nothing, , "% de IPI", "Aliquota do ipi", TP_NUMERICO, "99,99", , False, , , , , , , , , , "0", , , , "0", 1, "0", 870
      .AddColumn Nothing, , "Valor do IPI", "Valor do ipi", TP_NUMERICO, "99.999.999,99", , False, , , , , , , , , , "0", , , , "0", 1, "0", 1200
      .AddColumn Nothing, , "% Redução", "Percentual da redução", TP_NUMERICO, "99,99", , False, , , , , , , , , , "0", , , , "0", 1, "0", 1065
      .AddColumn Nothing, , "Frete", , TP_NUMERICO, , , True, , , , , , , , , , "0", , , , "0", 1, "0", 1035
      .AddColumn Nothing, , "Desconto", , TP_NUMERICO, , , True, , , , , , , , , , "0", , , , "0", 1, "0", 1095
      .AddColumn Nothing, , "B.Calculo ICMS", "Valor da base de calculo", TP_NUMERICO, "99.999.999,99", , False, , , , , , , , , , "0", , , , "0", 1, "0", 1425
      .AddColumn Nothing, , "% ICMS", "Aliquota do icms", TP_NUMERICO, "99,99", , False, , , , , , , , , , "0", , , , "0", 1, "0", 885
      .AddColumn Nothing, , "Valor do ICMS", "Valor do icms", TP_NUMERICO, "99.999.999,99", , False, , , , , , , , , , "0", , , , "0", 1, "0", 1350
      .AddColumn Nothing, , "% IVA Ajustado", "Iva", TP_NUMERICO, "99,9999", , False, , , , , , , , , , "0", , , , "0", 1, "0", 1320
      .AddColumn Nothing, , "% ICMS ST", "Aliquota icms st", TP_NUMERICO, "99,99", , False, , , , , , , , , , "0", , , , "0", 1, "0", 1020
      .AddColumn Nothing, , "B. Calc. ICMS ST", "Base de calculo st", TP_NUMERICO, "99.999.999,99", , False, , , , , , , , , , "0", , , , "0", 1, "0", 1590
      .AddColumn Nothing, , "Valor ICMS ST", "Valor icms st", TP_NUMERICO, "99.999.999,99", , False, , , , , , , , , , "0", , , , "0", 1, "0", 1350
      .AddColumn Nothing, , "Valor do Pis", "Valor do pis", TP_NUMERICO, "99.999.999,99", , False, , , , , , , , , , "0", , , , "0", 1, "0", 1320
      .AddColumn Nothing, , "Valor do Cofins", "Valor do cofins", TP_NUMERICO, "99.999.999,99", , False, , , , , , , , , , "0", , , , "0", 1, "0", 1470
      .AddColumn Nothing, , "Valor dos Tributos", "Valor dos tributos", TP_NUMERICO, "99.999.999,99", , False, , , , , , , , , , "0", , , , "0", 1, "0", 1680
   End With
   With Grid(1)
      .RowHeight = 285
      .AddControlIgnoreFocus mdiNFE.botCancela.hWnd           'não deixa o grid tentar gravar automaticamente
      .AddControlIgnoreFocus mdiNFE.botSalva.hWnd             'se estiver perdendo o foco para esses botões
      .FullRowSelect = False
      .BorderStyle = 1
      .NavigationAddMode = 1
      .CacheSize = 100
      .SpecialPopupDisabled POP_GRID_COLS Or POP_GRID_BARS Or POP_GRID_STRIPES
      .AllowInsert = Permitido("Parcelas nota fiscal", ACAO_INCLUINDO)
      .AllowEdit= Permitido("Parcelas nota fiscal", ACAO_EDITANDO)
      .AllowDelete = Permitido("Parcelas nota fiscal", ACAO_EXCLUINDO)
      .AddColumn Nothing, , "Nº Pc", "Numero da parcela", TP_NUMERICO, "9999", , True, , , , , , , , , , "0", , , , "0", 1, "0", 585
      .AddColumn Nothing, , "Dias", "Dias", TP_NUMERICO, "9999", , False, , , , , , , , , , "0", , , , "0", 1, "0", 540
      .AddColumn Nothing, , "Vencimento", "Data de vencimento", TP_DATA_HORA, "99/99/9999", , False, , , , , , , , , , "0", , , , "0", 1, "0", 1275
      .AddColumn Nothing, , "Valor da Parcela", "Valor da parcela", TP_NUMERICO, "9.999.999,99", , False, , , , , , , , , , "0", , , , "0", 1, "0", 1380
   End With
   With Grid(2)
      .RowHeight = 285
      .AddControlIgnoreFocus mdiNFE.botCancela.hWnd           'não deixa o grid tentar gravar automaticamente
      .AddControlIgnoreFocus mdiNFE.botSalva.hWnd             'se estiver perdendo o foco para esses botões
      .FullRowSelect = False
      .BorderStyle = 1
      .NavigationAddMode = 1
      .CacheSize = 100
      .SpecialPopupDisabled POP_GRID_COLS Or POP_GRID_BARS Or POP_GRID_STRIPES
      .AllowInsert = Permitido("NFe devolução", ACAO_INCLUINDO)
      .AllowEdit= Permitido("NFe devolução", ACAO_EDITANDO)
      .AllowDelete = Permitido("NFe devolução", ACAO_EXCLUINDO)
      .AddColumn Nothing, , "Chave da nfe", "Chave da nfe", TP_CARACTER, "@x", 44, False, , , , , , , , , , "0", , , , "0", 1, "0", 5340
      .AddColumn Nothing, , "Ano / Mês", , TP_CARACTER, , , True, , , , , , , , , , "0", , , , "0", 1, "0", 1035
      .AddColumn Nothing, , "UF", , TP_CARACTER, , , True, , , , , , , , , , "0", , , , "0", 1, "0", 675
      .AddColumn Nothing, , "Nº da NFe", , TP_CARACTER, , , True, , , , , , , , , , "0", , , , "0", 1, "0", 1305
   End With
   AjustaTamanho Me
   IniciaFormDados Me
   If vgTb.RecordCount > 0 Then vgTb.MoveLast
   Set Nota_fiscal = vgTb
   vgPriVez = False
   Reposition
   CarregaTotalizador
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

   Set txtCampo(33).CtPri = txtCp(33)
   txtCampo(33).DataType = 1
   txtCampo(33).Mask = "999999"
   txtCampo(33).Editable = False
   txtCampo(33).BoundColumn = ""
   txtCampo(33).ListFields = ""
   txtCampo(33).OrderFields = ""
   txtCampo(33).Relation = ""
   txtCampo(33).Source = ""
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(33).DataField), txtCampo(33)

   Set txtCampo(34).CtPri = txtCp(34)
   Set txtCampo(34).CtFdo = labFdo34
   Set txtCampo(34).CtBot(BOT_ACAO) = bottxtCampo34(BOT_ACAO)
   Set bottxtCampo34(BOT_ACAO).Picture = LoadPicture(LoadGasPicture(4))
   txtCampo(34).DataType = 2
   txtCampo(34).Mask = "99/99/9999"
   txtCampo(34).BoundColumn = ""
   txtCampo(34).ListFields = ""
   txtCampo(34).OrderFields = ""
   txtCampo(34).Relation = ""
   txtCampo(34).Source = ""
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(34).DataField), txtCampo(34)

   Set txtCampo(35).CtPri = txtCp(35)
   Set txtCampo(35).CtFdo = labFdo35
   Set txtCampo(35).CtBot(BOT_LISTA) = bottxtCampo35(BOT_LISTA)
   Set txtCampo(35).CtBot(BOT_COMBO) = bottxtCampo35(BOT_COMBO)
   bottxtCampo35(BOT_LISTA).Caption = "P"
   Set bottxtCampo35(BOT_COMBO).Picture = LoadPicture(LoadGasPicture(3))
   txtCampo(35).DataType = 1
   txtCampo(35).Mask = "999999"
   txtCampo(35).PesqModoAbertura =  2 
   txtCampo(35).PesqFieldCapture = "Geral.[Sequencia do geral]"
   txtCampo(35).BoundColumn = "Sequencia do geral"
   txtCampo(35).ListFields = "Razão social; Sequencia do geral"
   txtCampo(35).OrderFields = "Razão social"
   txtCampo(35).Relation = ""
   txtCampo(35).Source = "Geral"
   txtCampo(35).vgfrmGMCale.grdListaG.AutoRebind = True
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(35).DataField), txtCampo(35)

   Set txtCampo(0).CtPri = txtCp(0)
   Set txtCampo(0).CtFdo = labFdo0
   Set txtCampo(0).CtBot(BOT_LISTA) = bottxtCampo0(BOT_LISTA)
   Set txtCampo(0).CtBot(BOT_COMBO) = bottxtCampo0(BOT_COMBO)
   bottxtCampo0(BOT_LISTA).Caption = "P"
   Set bottxtCampo0(BOT_COMBO).Picture = LoadPicture(LoadGasPicture(3))
   txtCampo(0).DataType = 1
   txtCampo(0).Mask = "9999"
   txtCampo(0).PesqModoAbertura =  2 
   txtCampo(0).PesqFieldCapture = "[Natureza de operação].[Sequencia da natureza]"
   txtCampo(0).BoundColumn = "Sequencia da natureza"
   txtCampo(0).ListFields = "Cfop; Descrição do cfop"
   txtCampo(0).OrderFields = "Cfop"
   txtCampo(0).Relation = ""
   txtCampo(0).Source = "Natureza de operação"
   txtCampo(0).vgfrmGMCale.grdListaG.AutoRebind = True
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(0).DataField), txtCampo(0)

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
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(2).DataField), txtCampo(2)

   Set txtCampo(1).CtPri = txtCp(1)
   txtCampo(1).DataType = 2
   txtCampo(1).Mask = "99:99:99"
   txtCampo(1).BoundColumn = ""
   txtCampo(1).ListFields = ""
   txtCampo(1).OrderFields = ""
   txtCampo(1).Relation = ""
   txtCampo(1).Source = ""
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(1).DataField), txtCampo(1)

   Set txtCampo(3).CtPri = txtCp(3)
   Set txtCampo(3).CtFdo = labFdo3
   Set txtCampo(3).CtBot(BOT_COMBO) = bottxtCampo3(BOT_COMBO)
   Set bottxtCampo3(BOT_COMBO).Picture = LoadPicture(LoadGasPicture(3))
   txtCampo(3).DataType = 1
   txtCampo(3).Mask = "9"
   txtCampo(3).BoundColumn = "Codigo"
   txtCampo(3).ListFields = "Codigo; Descrição"
   txtCampo(3).OrderFields = "Codigo"
   txtCampo(3).Relation = ""
   txtCampo(3).Source = "Finalidade da nfe"
   txtCampo(3).vgfrmGMCale.grdListaG.AutoRebind = True
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(3).DataField), txtCampo(3)

   Set txtCampo(4).CtPri = txtCp(4)
   Set txtCampo(4).CtFdo = labFdo4
   Set txtCampo(4).CtBot(BOT_LISTA) = bottxtCampo4(BOT_LISTA)
   Set txtCampo(4).CtBot(BOT_COMBO) = bottxtCampo4(BOT_COMBO)
   bottxtCampo4(BOT_LISTA).Caption = "P"
   Set bottxtCampo4(BOT_COMBO).Picture = LoadPicture(LoadGasPicture(3))
   txtCampo(4).DataType = 1
   txtCampo(4).Mask = "999999"
   txtCampo(4).PesqModoAbertura =  2 
   txtCampo(4).PesqFieldCapture = "Geral.[Sequencia do geral]"
   txtCampo(4).BoundColumn = "Sequencia do geral"
   txtCampo(4).ListFields = "Razão social"
   txtCampo(4).OrderFields = "Razão social"
   txtCampo(4).Relation = ""
   txtCampo(4).Source = "Geral"
   txtCampo(4).vgfrmGMCale.grdListaG.AutoRebind = True
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(4).DataField), txtCampo(4)

   Set txtCampo(5).CtPri = txtCp(5)
   Set txtCampo(5).CtFdo = labFdo5
   Set txtCampo(5).CtBot(BOT_COMBO) = bottxtCampo5(BOT_COMBO)
   Set bottxtCampo5(BOT_COMBO).Picture = LoadPicture(LoadGasPicture(3))
   txtCampo(5).DataType = 0
   txtCampo(5).ListFields = "Emitente|Destinatario"
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
   Set txtCampo(7).CtBot(BOT_COMBO) = bottxtCampo7(BOT_COMBO)
   Set bottxtCampo7(BOT_COMBO).Picture = LoadPicture(LoadGasPicture(3))
   txtCampo(7).DataType = 0
   txtCampo(7).ListFields = "AC|AL|AP|AM|BA|CE|DF|ES|TO|GO|MA|MT|MS|MG|PA|PB|PR|PE|PI|RN|RS|RJ|RO|RR|SC|SP|SE"
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(7).DataField), txtCampo(7)

   Set txtCampo(11).CtPri = txtCp(11)
   txtCampo(11).DataType = 1
   txtCampo(11).Mask = "999999"
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

   Set txtCampo(13).CtPri = txtCp(13)
   txtCampo(13).DataType = 1
   txtCampo(13).Mask = "999.999,9999"
   txtCampo(13).BoundColumn = ""
   txtCampo(13).ListFields = ""
   txtCampo(13).OrderFields = ""
   txtCampo(13).Relation = ""
   txtCampo(13).Source = ""
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(13).DataField), txtCampo(13)

   Set txtCampo(14).CtPri = txtCp(14)
   txtCampo(14).DataType = 1
   txtCampo(14).Mask = "999.999,9999"
   txtCampo(14).BoundColumn = ""
   txtCampo(14).ListFields = ""
   txtCampo(14).OrderFields = ""
   txtCampo(14).Relation = ""
   txtCampo(14).Source = ""
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(14).DataField), txtCampo(14)

   Set opcPainel1(0).CtPri = opcPainel1Cp(0)
   Set opcPainel1(0).CtFdo = labopcPainel1
   opcPainel1(0).DataType = 6
   opcPainel1(0).BookMark = 0
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(opcPainel1(0).DataField), opcPainel1(0)

   Set opcPainel1(1).CtPri = opcPainel1Cp(1)
   Set opcPainel1(1).CtFdo = labopcPainel1
   opcPainel1(1).DataType = 6
   opcPainel1(1).BookMark = 1

   Set txtCampo(36).CtPri = txtCp(36)
   txtCampo(36).DataType = 4
   txtCampo(36).Mask = ""
   txtCampo(36).BoundColumn = ""
   txtCampo(36).ListFields = ""
   txtCampo(36).OrderFields = ""
   txtCampo(36).Relation = ""
   txtCampo(36).Source = ""
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(36).DataField), txtCampo(36)

   Set txtCampo(8).CtPri = txtCp(8)
   txtCampo(8).DataType = 0
   txtCampo(8).Mask = ""
   txtCampo(8).Editable = False
   txtCampo(8).BoundColumn = ""
   txtCampo(8).ListFields = ""
   txtCampo(8).OrderFields = ""
   txtCampo(8).Relation = ""
   txtCampo(8).Source = ""

   Set txtCampo(9).CtPri = txtCp(9)
   txtCampo(9).DataType = 0
   txtCampo(9).Mask = ""
   txtCampo(9).Editable = False
   txtCampo(9).BoundColumn = ""
   txtCampo(9).ListFields = ""
   txtCampo(9).OrderFields = ""
   txtCampo(9).Relation = ""
   txtCampo(9).Source = ""

   Set txtCampo(10).CtPri = txtCp(10)
   txtCampo(10).DataType = 0
   txtCampo(10).Mask = ""
   txtCampo(10).Editable = False
   txtCampo(10).BoundColumn = ""
   txtCampo(10).ListFields = ""
   txtCampo(10).OrderFields = ""
   txtCampo(10).Relation = ""
   txtCampo(10).Source = ""

   Set txtCampo(15).CtPri = txtCp(15)
   Set txtCampo(15).CtFdo = labFdo15
   Set txtCampo(15).CtBot(BOT_COMBO) = bottxtCampo15(BOT_COMBO)
   Set bottxtCampo15(BOT_COMBO).Picture = LoadPicture(LoadGasPicture(3))
   txtCampo(15).DataType = 0
   txtCampo(15).ListFields = "Vista|Prazo"
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(15).DataField), txtCampo(15)

   Set txtCampo(16).CtPri = txtCp(16)
   Set txtCampo(16).CtFdo = labFdo16
   Set txtCampo(16).CtBot(BOT_ACAO) = bottxtCampo16(BOT_ACAO)
   Set bottxtCampo16(BOT_ACAO).Picture = LoadPicture(LoadGasPicture(4))
   txtCampo(16).DataType = 1
   txtCampo(16).Mask = "99.999.999,99"
   txtCampo(16).BoundColumn = ""
   txtCampo(16).ListFields = ""
   txtCampo(16).OrderFields = ""
   txtCampo(16).Relation = ""
   txtCampo(16).Source = ""
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(16).DataField), txtCampo(16)

   Set txtCampo(17).CtPri = txtCp(17)
   Set txtCampo(17).CtFdo = labFdo17
   Set txtCampo(17).CtBot(BOT_ACAO) = bottxtCampo17(BOT_ACAO)
   Set bottxtCampo17(BOT_ACAO).Picture = LoadPicture(LoadGasPicture(4))
   txtCampo(17).DataType = 1
   txtCampo(17).Mask = "99.999.999,99"
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
   txtCampo(18).DataType = 1
   txtCampo(18).Mask = "99.999.999,99"
   txtCampo(18).Editable = False
   txtCampo(18).BoundColumn = ""
   txtCampo(18).ListFields = ""
   txtCampo(18).OrderFields = ""
   txtCampo(18).Relation = ""
   txtCampo(18).Source = ""
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(18).DataField), txtCampo(18)

   Set txtCampo(19).CtPri = txtCp(19)
   Set txtCampo(19).CtFdo = labFdo19
   Set txtCampo(19).CtBot(BOT_ACAO) = bottxtCampo19(BOT_ACAO)
   Set bottxtCampo19(BOT_ACAO).Picture = LoadPicture(LoadGasPicture(4))
   txtCampo(19).DataType = 1
   txtCampo(19).Mask = "99.999.999,99"
   txtCampo(19).Editable = False
   txtCampo(19).BoundColumn = ""
   txtCampo(19).ListFields = ""
   txtCampo(19).OrderFields = ""
   txtCampo(19).Relation = ""
   txtCampo(19).Source = ""
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(19).DataField), txtCampo(19)

   Set txtCampo(20).CtPri = txtCp(20)
   Set txtCampo(20).CtFdo = labFdo20
   Set txtCampo(20).CtBot(BOT_ACAO) = bottxtCampo20(BOT_ACAO)
   Set bottxtCampo20(BOT_ACAO).Picture = LoadPicture(LoadGasPicture(4))
   txtCampo(20).DataType = 1
   txtCampo(20).Mask = "99.999.999,99"
   txtCampo(20).Editable = False
   txtCampo(20).BoundColumn = ""
   txtCampo(20).ListFields = ""
   txtCampo(20).OrderFields = ""
   txtCampo(20).Relation = ""
   txtCampo(20).Source = ""
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(20).DataField), txtCampo(20)

   Set txtCampo(21).CtPri = txtCp(21)
   Set txtCampo(21).CtFdo = labFdo21
   Set txtCampo(21).CtBot(BOT_LISTA) = bottxtCampo21(BOT_LISTA)
   Set bottxtCampo21(BOT_LISTA).Picture = LoadPicture(LoadGasPicture(4))
   txtCampo(21).DataType = 1
   txtCampo(21).Mask = "99.999.999,99"
   txtCampo(21).Editable = False
   txtCampo(21).PesqModoAbertura =  2 
   txtCampo(21).BoundColumn = ""
   txtCampo(21).ListFields = ""
   txtCampo(21).OrderFields = ""
   txtCampo(21).Relation = ""
   txtCampo(21).Source = ""
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(21).DataField), txtCampo(21)

   Set txtCampo(22).CtPri = txtCp(22)
   Set txtCampo(22).CtFdo = labFdo22
   Set txtCampo(22).CtBot(BOT_LISTA) = bottxtCampo22(BOT_LISTA)
   Set bottxtCampo22(BOT_LISTA).Picture = LoadPicture(LoadGasPicture(4))
   txtCampo(22).DataType = 1
   txtCampo(22).Mask = "99.999.999,99"
   txtCampo(22).Editable = False
   txtCampo(22).PesqModoAbertura =  2 
   txtCampo(22).BoundColumn = ""
   txtCampo(22).ListFields = ""
   txtCampo(22).OrderFields = ""
   txtCampo(22).Relation = ""
   txtCampo(22).Source = ""
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(22).DataField), txtCampo(22)

   Set txtCampo(23).CtPri = txtCp(23)
   Set txtCampo(23).CtFdo = labFdo23
   Set txtCampo(23).CtBot(BOT_LISTA) = bottxtCampo23(BOT_LISTA)
   Set bottxtCampo23(BOT_LISTA).Picture = LoadPicture(LoadGasPicture(4))
   txtCampo(23).DataType = 1
   txtCampo(23).Mask = "99.999.999,99"
   txtCampo(23).Editable = False
   txtCampo(23).PesqModoAbertura =  2 
   txtCampo(23).BoundColumn = ""
   txtCampo(23).ListFields = ""
   txtCampo(23).OrderFields = ""
   txtCampo(23).Relation = ""
   txtCampo(23).Source = ""
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(23).DataField), txtCampo(23)

   Set txtCampo(24).CtPri = txtCp(24)
   Set txtCampo(24).CtFdo = labFdo24
   Set txtCampo(24).CtBot(BOT_ACAO) = bottxtCampo24(BOT_ACAO)
   Set bottxtCampo24(BOT_ACAO).Picture = LoadPicture(LoadGasPicture(4))
   txtCampo(24).DataType = 1
   txtCampo(24).Mask = "99.999.999,99"
   txtCampo(24).Editable = False
   txtCampo(24).BoundColumn = ""
   txtCampo(24).ListFields = ""
   txtCampo(24).OrderFields = ""
   txtCampo(24).Relation = ""
   txtCampo(24).Source = ""
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(24).DataField), txtCampo(24)

   Set txtCampo(25).CtPri = txtCp(25)
   Set txtCampo(25).CtFdo = labFdo25
   Set txtCampo(25).CtBot(BOT_COMBO) = bottxtCampo25(BOT_COMBO)
   Set bottxtCampo25(BOT_COMBO).Picture = LoadPicture(LoadGasPicture(4))
   txtCampo(25).DataType = 1
   txtCampo(25).Mask = "99.999.999,99"
   txtCampo(25).Editable = False
   txtCampo(25).BoundColumn = ""
   txtCampo(25).ListFields = ""
   txtCampo(25).OrderFields = ""
   txtCampo(25).Relation = ""
   txtCampo(25).Source = ""
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(25).DataField), txtCampo(25)

   Set txtCampo(26).CtPri = txtCp(26)
   Set txtCampo(26).CtFdo = labFdo26
   Set txtCampo(26).CtBot(BOT_LISTA) = bottxtCampo26(BOT_LISTA)
   Set bottxtCampo26(BOT_LISTA).Picture = LoadPicture(LoadGasPicture(4))
   txtCampo(26).DataType = 1
   txtCampo(26).Mask = "99.999.999,99"
   txtCampo(26).Editable = False
   txtCampo(26).PesqModoAbertura =  2 
   txtCampo(26).BoundColumn = ""
   txtCampo(26).ListFields = ""
   txtCampo(26).OrderFields = ""
   txtCampo(26).Relation = ""
   txtCampo(26).Source = ""
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(26).DataField), txtCampo(26)

   Set txtCampo(37).CtPri = txtCp(37)
   Set txtCampo(37).CtFdo = labFdo37
   Set txtCampo(37).CtBot(BOT_ACAO) = bottxtCampo37(BOT_ACAO)
   Set bottxtCampo37(BOT_ACAO).Picture = LoadPicture(LoadGasPicture(4))
   txtCampo(37).DataType = 1
   txtCampo(37).Mask = "999.999.999,99"
   txtCampo(37).Editable = False
   txtCampo(37).BoundColumn = ""
   txtCampo(37).ListFields = ""
   txtCampo(37).OrderFields = ""
   txtCampo(37).Relation = ""
   txtCampo(37).Source = ""
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(37).DataField), txtCampo(37)

   Set chkCampo(2).CtPri = chkCp(2)
   chkCampo(2).DataType = 5
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(chkCampo(2).DataField), chkCampo(2)

   Set txtCampo(38).CtPri = txtCp(38)
   txtCampo(38).DataType = 1
   txtCampo(38).Mask = ""
   txtCampo(38).Editable = False
   txtCampo(38).BoundColumn = ""
   txtCampo(38).ListFields = ""
   txtCampo(38).OrderFields = ""
   txtCampo(38).Relation = ""
   txtCampo(38).Source = ""

   Set txtCampo(27).CtPri = txtCp(27)
   txtCampo(27).DataType = 0
   txtCampo(27).Mask = "@x"
   txtCampo(27).Editable = False
   txtCampo(27).BoundColumn = ""
   txtCampo(27).ListFields = ""
   txtCampo(27).OrderFields = ""
   txtCampo(27).Relation = ""
   txtCampo(27).Source = ""
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(27).DataField), txtCampo(27)

   Set txtCampo(28).CtPri = txtCp(28)
   txtCampo(28).DataType = 0
   txtCampo(28).Mask = "@x"
   txtCampo(28).Editable = False
   txtCampo(28).BoundColumn = ""
   txtCampo(28).ListFields = ""
   txtCampo(28).OrderFields = ""
   txtCampo(28).Relation = ""
   txtCampo(28).Source = ""
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(28).DataField), txtCampo(28)

   Set txtCampo(29).CtPri = txtCp(29)
   txtCampo(29).DataType = 0
   txtCampo(29).Mask = "@x"
   txtCampo(29).Editable = False
   txtCampo(29).BoundColumn = ""
   txtCampo(29).ListFields = ""
   txtCampo(29).OrderFields = ""
   txtCampo(29).Relation = ""
   txtCampo(29).Source = ""
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(29).DataField), txtCampo(29)

   Set txtCampo(30).CtPri = txtCp(30)
   txtCampo(30).DataType = 0
   txtCampo(30).Mask = "@x"
   txtCampo(30).Editable = False
   txtCampo(30).BoundColumn = ""
   txtCampo(30).ListFields = ""
   txtCampo(30).OrderFields = ""
   txtCampo(30).Relation = ""
   txtCampo(30).Source = ""
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(30).DataField), txtCampo(30)

   Set txtCampo(31).CtPri = txtCp(31)
   txtCampo(31).DataType = 4
   txtCampo(31).Mask = ""
   txtCampo(31).Editable = False
   txtCampo(31).BoundColumn = ""
   txtCampo(31).ListFields = ""
   txtCampo(31).OrderFields = ""
   txtCampo(31).Relation = ""
   txtCampo(31).Source = ""
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(31).DataField), txtCampo(31)

   Set chkCampo(0).CtPri = chkCp(0)
   chkCampo(0).DataType = 5
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(chkCampo(0).DataField), chkCampo(0)

   Set txtCampo(32).CtPri = txtCp(32)
   Set txtCampo(32).CtFdo = labFdo32
   Set txtCampo(32).CtBot(BOT_LISTA) = bottxtCampo32(BOT_LISTA)
   Set txtCampo(32).CtBot(BOT_COMBO) = bottxtCampo32(BOT_COMBO)
   bottxtCampo32(BOT_LISTA).Caption = "P"
   Set bottxtCampo32(BOT_COMBO).Picture = LoadPicture(LoadGasPicture(3))
   txtCampo(32).DataType = 0
   txtCampo(32).Mask = "@x"
   txtCampo(32).PesqModoAbertura =  2 
   txtCampo(32).PesqFieldCapture = "[Nota fiscal].[Chave de acesso da nfe]"
   txtCampo(32).BoundColumn = "Chave de acesso da nfe"
   txtCampo(32).ListFields = "Numero da nfe; Chave de acesso da nfe"
   txtCampo(32).OrderFields = "Numero da nfe"
   txtCampo(32).Relation = ""
   txtCampo(32).Source = "Nota fiscal"
   txtCampo(32).vgfrmGMCale.grdListaG.AutoRebind = True
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(txtCampo(32).DataField), txtCampo(32)

 DefineControles1

 Exit Sub

 DeuErro:
  CErr.NumErro = Err
  CErr.FunctionName = "DefineControles0"
  CErr.Origem = CStr(vgFormID) +" - "+ Me.Caption
 CErr.Show
End Sub
Public Sub DefineControles1()
 On Error GoTo DeuErro

   Set chkCampo(1).CtPri = chkCp(1)
   chkCampo(1).DataType = 5
   grdBrowse.AddColumn vgDb.Tables(vgIdentTab).Columns(chkCampo(1).DataField), chkCampo(1)

 Exit Sub

 DeuErro:
  CErr.NumErro = Err
  CErr.FunctionName = "DefineControles1"
  CErr.Origem = CStr(vgFormID) +" - "+ Me.Caption
 CErr.Show
End Sub


'poe relacionamento e filtro na lista externa (combobox)
Private Sub PoeRelEFiltroCbo(Index As Integer)
   On Error Resume Next
   Select Case Index
      Case 0
         txtCampo(0).Filter = "([Sequencia da natureza] > " & 0 & ") AND Inativo = " & 0 & ""
                           txtCampo(0).PesqSQLExpression = "SELECT [Natureza de operação].[Sequencia da natureza], [Natureza de operação].Cfop, [Natureza de operação].[Descrição do cfop] FROM [Natureza de operação] WHERE ([Natureza de operação].[Sequencia da natureza] > " + CStr(0) + ") AND " + _
                                                              "([Natureza de operação].Inativo = " + CStr(0) + ")"
      Case 3
         txtCampo(3).Filter = "Codigo > " & 0 & ""
      Case 4
         txtCampo(4).Filter = "(([Sequencia do geral] > " & 0 & ") AND Transportadora = " & 1 & ") AND Inativo = " & 0 & ""
                           txtCampo(4).PesqSQLExpression = "SELECT Geral.[Sequencia do geral], Geral.[Razão social], Geral.[Nome fantasia], Geral.Endereço, Geral.Nro, " + _
                                                              "Geral.Bairro, Geral.Cep, Geral.Fone FROM Geral WHERE (Geral.[Sequencia do geral] > " + CStr(0) + ") AND " + _
                                                              "(Geral.Transportadora = " + CStr(1) + ") AND (Geral.Inativo = " + CStr(0) + ")"
      Case 32
         txtCampo(32).Filter = "((([Sequencia da nota fiscal] > " & 0 & ") AND [Numero da nfe] > " & 0 & ") AND Autorizada = " & 1 & ") AND [Nota cancelada] = " & 0 & ""
                           txtCampo(32).PesqSQLExpression = "SELECT [Nota fiscal].[Numero da nfe], [Nota fiscal].[Chave de acesso da nfe] FROM [Nota fiscal] WHERE ([Nota fiscal].[Sequencia da nota fiscal] > " + CStr(0) + ") AND " + _
                                                               "([Nota fiscal].[Numero da nfe] > " + CStr(0) + ") AND ([Nota fiscal].Autorizada = " + CStr(1) + ") AND ([Nota fiscal].[Nota cancelada] = " + CStr(0) + ")"
      Case 35
         txtCampo(35).Filter = "(([Sequencia do geral] > " & 0 & ") AND Inativo = " & 0 & ") AND Cliente = " & 1 & ""
                           txtCampo(35).PesqSQLExpression = "SELECT Geral.[Sequencia do geral], Geral.[Razão social], Geral.[Nome fantasia], Geral.Endereço, Geral.Nro, " + _
                                                               "Geral.Bairro, Geral.[Cpf e cnpj], Geral.[Rg e ie] FROM Geral WHERE (Geral.[Sequencia do geral] > " + CStr(0) + ") AND " + _
                                                               "(Geral.Inativo = " + CStr(0) + ") AND (Geral.Cliente = " + CStr(1) + ")"
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
   lblProgresso.Caption = IIf(Parametros_da_NFe!Ambiente = 1, "AMBIENTE NFe EM MODO TESTE", ""): MudaTamCampos Me
End Sub

'evento - descarregando o formulário da memória
Private Sub Form_Unload(Cancel As Integer)
   Dim i As Integer
   On Error Resume Next
   LimpaLabel  
   FinalizaForm Me
   Set lblNota2 = Nothing
   Set TxtEnderecoTrans = Nothing
   Set TxtIETrans = Nothing
   Set TxtCnpjTrans = Nothing
   Set GrdProdutos = Nothing
   Set lblParcelamento = Nothing
   Set grdParcelamento = Nothing
   Set lblAjuste = Nothing
   Set cmdDanfe = Nothing
   Set cmdCancelar = Nothing
   Set lblNNota = Nothing
   Set lblNota = Nothing
   For i = 0 To UBound(txtCampo)
      txtCampo(i).Finalize
      Set txtCampo(i) = Nothing
   Next
   Set chkCampo(0) = Nothing
   Set chkCampo(1) = Nothing
   Set chkCampo(2) = Nothing
   If Not Nota_fiscal Is Nothing Then
      Set Nota_fiscal = Nothing
   End If
   If Not Produtos_da_nota_fiscal Is Nothing Then
      Produtos_da_nota_fiscal.CloseRecordSet
      Set Produtos_da_nota_fiscal = Nothing
   End If
   If Not Parcelas_nota_fiscal Is Nothing Then
      Parcelas_nota_fiscal.CloseRecordSet
      Set Parcelas_nota_fiscal = Nothing
   End If
   If Not NFe_devolucao Is Nothing Then
      NFe_devolucao.CloseRecordSet
      Set NFe_devolucao = Nothing
   End If

   'se tiver imprimindo registros em grade, fecha form de selecao/preview
   UnLoad vgFrmImpCons
   Set vgFrmImpCons = Nothing

   'vamos descarregar todos os grids
   For i = 0 To Grid.Count - 1
      Grid(i).Finalize
   Next

   grdBrowse.Finalize                             'descarrega o grid
   Set frmNotafisc = Nothing                      'libera o segmento de código do form
End Sub

'evento - quando qq tecla for digitada no grid filho
Private Sub Grid_KeyPress(Index As Integer, ByVal KeyAscii As Integer, ByVal Shift As Integer, vgColumns() As Variant)
   Select Case Index
      Case 0
         ExecutaGrid0 vgColumns(), KEYPRESS_NO_GRID, , , , , , KeyAscii
   End Select
End Sub

'evento - está mudando a linha selecionada do grid
Private Sub Grid_SkipRecord(Index As Integer, vgColumns() As Variant, ByVal vgBookMark As Variant)
   ExecutaGrid Index, vgColumns(), CONDICOES_ESPECIAIS
End Sub

'evento - após efetuar update do recordset do grid
Private Sub Grid_AfterUpdateRecord(Index As Integer, ByVal vgItem As Long, vgColumns() As Variant, vgIsValid As Boolean, vgColumn As Integer, vgErrorMessage As String)
   Select Case Index
      Case 0
         ExecutaGrid Index, vgColumns(), PROCESSOS_DIRETOS, vgItem, 0, vgIsValid, vgColumn, vgErrorMessage
         ExecutaGrid Index, vgColumns(), APOS_EDICAO, vgItem, 0, vgIsValid, vgColumn, vgErrorMessage
   GeraLog Me, Grid(Index).Status, Index, False
      Case 1
   GeraLog Me, Grid(Index).Status, Index, False
      Case 2
   GeraLog Me, Grid(Index).Status, Index, False
   End Select
End Sub

'evento - antes de efetuar o edit do recordset do grid
Private Sub Grid_BeforeEditRecord(Index As Integer, ByVal vgItem As Long, vgColumns() As Variant, vgIsValid As Boolean, vgColumn As Integer, vgErrorMessage As String)
   GeraLog Me, Grid(Index).Status, Index, True
   Select Case Index
      Case 0
         ExecutaGrid Index, Grid(Index).GetColumnValues(vgItem), PROCESSOS_INVERSOS, vgItem, 0, vgIsValid, vgColumn, vgErrorMessage
      Case 1
         ExecutaGrid Index, Grid(Index).GetColumnValues(vgItem), PROCESSOS_INVERSOS, vgItem, 0, vgIsValid, vgColumn, vgErrorMessage
      Case 2
         ExecutaGrid Index, Grid(Index).GetColumnValues(vgItem), PROCESSOS_INVERSOS, vgItem, 0, vgIsValid, vgColumn, vgErrorMessage
   End Select
End Sub

'evento - antes de efetuar o update do recordset do grid
Private Sub Grid_BeforeUpdateRecord(Index As Integer, ByVal vgItem As Long, vgColumns() As Variant, vgIsValid As Boolean, vgColumn As Integer, vgErrorMessage As String)
   Select Case Index
      Case 0
         Produtos_da_nota_fiscal![Sequencia da nota fiscal] = Nota_fiscal![Sequencia da nota fiscal]
      Case 1
         Parcelas_nota_fiscal![Sequencia da nota fiscal] = Nota_fiscal![Sequencia da nota fiscal]
      Case 2
         NFe_devolucao![Sequencia da nota fiscal] = Nota_fiscal![Sequencia da nota fiscal]
   End Select
End Sub

'evento - antes de efetuar o delete no recordset do grid
Private Sub Grid_BeforeDeleteRecord(Index As Integer, ByVal vgItem As Long, vgColumns() As Variant, vgIsValid As Boolean, vgColumn As Integer, vgErrorMessage As String)
   GeraLog Me, ACAO_EXCLUINDO, Index, True
   ExecutaGrid Index, vgColumns(), EXCLUSOES, vgItem, 0, vgIsValid, 0, vgErrorMessage
   Select Case Index
      Case 0
      Case 1
      Case 2
   End Select
End Sub

'evento - quer pegar valores para cada célula
Private Sub Grid_GetColumnValue(Index As Integer, ByVal vgItem As Long, ByVal vgCol As Integer, vgColumns() As Variant, vgNewText As Variant)
   Dim RetVal As Variant, NCol As Integer
   RetVal = ExecutaGrid(Index, vgColumns(), CONTEUDODACOLUNA, vgItem, vgCol, , NCol)
   If NCol = -1 Then
      vgNewText = RetVal
   End If
End Sub

'evento - recordset do grid foi mudado
Private Sub Grid_RecordSetChanged(Index As Integer, ByVal vgNewRecordSet As GRecordSet)
   Select Case Index
      Case 0
         Set Produtos_da_nota_fiscal = vgNewRecordSet
      Case 1
         Set Parcelas_nota_fiscal = vgNewRecordSet
      Case 2
         Set NFe_devolucao = vgNewRecordSet
   End Select
End Sub

'evento - quer validar dados, está gravando
Private Sub Grid_ValidateData(Index As Integer, ByVal vgItem As Long, vgColumns() As Variant, vgIsValid As Boolean, vgColumn As Integer, vgErrorMessage As String)
   ExecutaGrid Index, vgColumns(), VALIDACOES, vgItem, vgColumn, vgIsValid, vgColumn, vgErrorMessage
End Sub

'evento - após a exclusao de um registro no grid filho
Private Sub Grid_AfterDeleteRecord(Index As Integer, ByVal vgItem As Long, vgColumns() As Variant, vgIsValid As Boolean, vgColumn As Integer, vgErrorMessage As String)
   GeraLog Me, ACAO_EXCLUINDO, Index, False
   Select Case Index
      Case 0
         ExecutaGrid Index, vgColumns(), APOS_EDICAO, vgItem, vgColumn, vgIsValid, vgColumn, vgErrorMessage
   End Select
   mdiNFE.RemontaForm                                   'vamos atualizar os forms de dados
   Grid(Index).Repaint -1                               'atualiza dados do grid (registro posicionado) 
End Sub

Private Sub Grid_ControlButtonClick(Index As Integer)
   Grid(Index).ShowFilterBar = Not Grid(Index).ShowFilterBar
End Sub

Private Sub Grid_GotFocus(Index As Integer)
   If vgSituacao <> ACAO_NAVEGANDO And Grid(Index).Status = ACAO_NAVEGANDO Then                 'o formulário pai não está em navegação
      mdiNFE.SalvaDados                           'salva o resitro em edição
      If vgSituacao <> ACAO_NAVEGANDO And ActiveControl Is Grid(Index) Then 'se não gravou e ainda está com foco no grid
         FocoNoPriControle Me                                               'vamos colocar foco no primeiro controle do pai
      End If
   End If
End Sub

Private Sub Grid_StatusChanged(Index As Integer, ByVal vgNewStatus As Integer)
   Dim vgTemAltGrdOld As Boolean
   If vgNewStatus <> ACAO_NAVEGANDO Then vgNewStatus = - vgNewStatus
   PrepBotoes Me, vgNewStatus                                     'acerta icones dos botoes
   vgTemAltGrdOld = vgTemAlteracaoGrids
   mdiNFE.RemontaForm                                             'remonta dos os form da tela
   If vgSituacao = ACAO_NAVEGANDO Then
      Reposition , Not vgTemAltGrdOld
   End If
End Sub

'evento - atualiza valores para os filtros das colunas do grid filho
Private Sub Grid_GetColumnFilter(Index As Integer, ByVal vgColumn As Integer, vgColumns() As Variant, vgFilter As String)
   vgFilter = ExecutaGrid(Index, vgColumns(), PEGAFILTRODASCOLUNAS, , vgColumn)
End Sub

'evento - pega expressão SQL para abertura de pesquisa
Private Sub Grid_GetColumnSQLSearch(Index As Integer, ByVal vgColumn As Integer, vgColumns() As Variant, vgSQLSearch As String)
   vgSQLSearch = ExecutaGrid(Index, vgColumns(), PEGAEXPRESSAOPESQUISA, , vgColumn)
End Sub

'inicializações, validações e processos para o grid
Private Function ExecutaGrid(Index As Integer, ColumnValue() As Variant, ByVal vgOq As Integer, Optional ByVal vgItem As Long, Optional ByVal vgCol As Integer, Optional vgIsValid As Boolean, Optional ByRef vgColumn As Integer, Optional vgErrorMessage As String, Optional KeyCodeAscii As Integer, Optional Shift As Integer) As Variant
   Select Case Index
      Case  0 
         ExecutaGrid = ExecutaGrid0(ColumnValue(), vgOq, vgItem, vgCol, vgIsValid, vgColumn, vgErrorMessage, KeyCodeAscii, Shift)
      Case  1 
         ExecutaGrid = ExecutaGrid1(ColumnValue(), vgOq, vgItem, vgCol, vgIsValid, vgColumn, vgErrorMessage, KeyCodeAscii, Shift)
      Case  2 
         ExecutaGrid = ExecutaGrid2(ColumnValue(), vgOq, vgItem, vgCol, vgIsValid, vgColumn, vgErrorMessage, KeyCodeAscii, Shift)
   End Select
End Function

'inicializações, validações e processos do grid filho
Private Function ExecutaGrid0(ColumnValue() As Variant, ByVal vgOq As Integer, Optional ByVal vgItem As Long, Optional ByVal vgCol As Integer, Optional vgIsValid As Boolean, Optional ByRef vgColumn As Integer, Optional vgErrorMessage As String, Optional KeyCodeAscii As Integer, Optional Shift As Integer) As Variant
   Dim vgRetVal As Variant, vgRsError As GRecordSet, x as String, vgNVez As Integer
   Dim Sequencia_produto_nota_fiscal As Long, Sequencia_do_produto As Long, Quantidade As Double
   Dim Valor_unitario As Double, Valor_total As Double, Valor_do_ipi As Double
   Dim Valor_do_icms As Double, Aliquota_do_ipi As Single, Aliquota_do_icms As Single
   Dim Percentual_da_reducao As Single, Valor_da_base_de_calculo As Double, Valor_do_pis As Double
   Dim Valor_do_cofins As Double, Iva As Double, Base_de_calculo_st As Double
   Dim Valor_icms_st As Double, Cfop As Long, Cst As Integer
   Dim Aliquota_icms_st As Single, Valor_dos_tributos As Double
   vgPriVez = True
   If vgOq = PREVALIDACOES Then
      vgRetVal = False
   Else
      vgRetVal = ""
   End If
   vgNVez = 0
   On Error GoTo DeuErro
   If vgOq = CONTEUDODACOLUNA Then
      If Grid(0).Status <> ACAO_NAVEGANDO And vgItem = Grid(0).SelectedItem Then
         GoSub IniApDaCol
      Else
         GoSub IniApDaTb
      End If
      On Error Resume Next
      Select Case vgCol
         Case 2
            vgRetVal = (InfoProdutos(Sequencia_da_nota_fiscal, Sequencia_produto_nota_fiscal, Sequencia_do_produto, Quantidade, Valor_unitario, Valor_total, _
   Valor_do_ipi, Valor_do_icms, Aliquota_do_ipi, Aliquota_do_icms, Percentual_da_reducao, Valor_da_base_de_calculo, _
   Valor_do_pis, Valor_do_cofins, Iva, Base_de_calculo_st, Valor_icms_st, Cfop, _
   Cst, Aliquota_icms_st, Valor_dos_tributos, "NCM"))
            vgColumn = -1                   'flag para permitir definição desse novo valor para coluna do grid
         Case 5
            vgRetVal = (InfoProdutos(Sequencia_da_nota_fiscal, Sequencia_produto_nota_fiscal, Sequencia_do_produto, Quantidade, Valor_unitario, Valor_total, _
   Valor_do_ipi, Valor_do_icms, Aliquota_do_ipi, Aliquota_do_icms, Percentual_da_reducao, Valor_da_base_de_calculo, _
   Valor_do_pis, Valor_do_cofins, Iva, Base_de_calculo_st, Valor_icms_st, Cfop, _
   Cst, Aliquota_icms_st, Valor_dos_tributos, "Sigla"))
            vgColumn = -1                   'flag para permitir definição desse novo valor para coluna do grid
         Case 8
            vgRetVal = (Quantidade * Valor_unitario)
            vgColumn = -1                   'flag para permitir definição desse novo valor para coluna do grid
         Case 12
            vgRetVal = (MostraFrete(Sequencia_da_nota_fiscal, Sequencia_produto_nota_fiscal, Sequencia_do_produto, Quantidade, Valor_unitario, Valor_total, _
   Valor_do_ipi, Valor_do_icms, Aliquota_do_ipi, Aliquota_do_icms, Percentual_da_reducao, Valor_da_base_de_calculo, _
   Valor_do_pis, Valor_do_cofins, Iva, Base_de_calculo_st, Valor_icms_st, Cfop, _
   Cst, Aliquota_icms_st, Valor_dos_tributos))
            vgColumn = -1                   'flag para permitir definição desse novo valor para coluna do grid
         Case 13
            vgRetVal = (MostraDesconto(Sequencia_da_nota_fiscal, Sequencia_produto_nota_fiscal, Sequencia_do_produto, Quantidade, Valor_unitario, Valor_total, _
   Valor_do_ipi, Valor_do_icms, Aliquota_do_ipi, Aliquota_do_icms, Percentual_da_reducao, Valor_da_base_de_calculo, _
   Valor_do_pis, Valor_do_cofins, Iva, Base_de_calculo_st, Valor_icms_st, Cfop, _
   Cst, Aliquota_icms_st, Valor_dos_tributos))
            vgColumn = -1                   'flag para permitir definição desse novo valor para coluna do grid
      End Select
      If Err Then Err.Clear
   ElseIf vgOq = PREVALIDACOES Then
      GoSub IniApDaCol
      Select Case vgCol
         Case 3
            vgRetVal = Not (Nota_fiscal![Nota avulsa] = True)
         Case 4
            vgRetVal = Not (Nota_fiscal![Nota avulsa] = True)
         Case 9
            vgRetVal = Not (Nota_fiscal![Nota avulsa] = True)
         Case 10
            vgRetVal = Not (Nota_fiscal![Nota avulsa] = True)
         Case 11
            vgRetVal = Not (Nota_fiscal![Nota avulsa] = True)
         Case 14
            vgRetVal = Not (Nota_fiscal![Nota avulsa] = True)
         Case 15
            vgRetVal = Not (Nota_fiscal![Nota avulsa] = True)
         Case 16
            vgRetVal = Not (Nota_fiscal![Nota avulsa] = True)
         Case 17
            vgRetVal = Not (Nota_fiscal![Nota avulsa] = True)
         Case 18
            vgRetVal = Not (Nota_fiscal![Nota avulsa] = True)
         Case 19
            vgRetVal = Not (Nota_fiscal![Nota avulsa] = True)
         Case 20
            vgRetVal = Not (Nota_fiscal![Nota avulsa] = True)
         Case 21
            vgRetVal = Not (Nota_fiscal![Nota avulsa] = True)
         Case 22
            vgRetVal = Not (Nota_fiscal![Nota avulsa] = True)
         Case 23
            vgRetVal = Not (Nota_fiscal![Nota avulsa] = True)
         Case Else
            vgRetVal = False
      End Select
   ElseIf vgOq = KEYPRESS_NO_GRID Then
      GoSub IniApDaCol
      ComandosProdutos KeyCodeAscii, Sequencia_da_nota_fiscal, Sequencia_produto_nota_fiscal, Sequencia_do_produto, Quantidade, Valor_unitario, Valor_total, _
   Valor_do_ipi, Valor_do_icms, Aliquota_do_ipi, Aliquota_do_icms, Percentual_da_reducao, Valor_da_base_de_calculo, _
   Valor_do_pis, Valor_do_cofins, Iva, Base_de_calculo_st, Valor_icms_st, Cfop, _
   Cst, Aliquota_icms_st, Valor_dos_tributos 
   ElseIf vgOq = CONDICOES_ESPECIAIS Then
      If vgSituacao <> ACAO_INCLUINDO Then
         GoSub IniApDaTb
      On Error Resume Next
         Grid(0).AllowInsert = ((Autorizada = 0) AND Nota_cancelada = 0)
      On Error Resume Next
         Grid(0).AllowEdit = ((Autorizada = 0) AND Nota_cancelada = 0)
      On Error Resume Next
         Grid(0).AllowDelete = ((Autorizada = 0) AND Nota_cancelada = 0)
      End If
      vgRetVal = ""
   ElseIf vgOq = ABRE_TABELA_GRID Then
      On Error Resume Next
      vgRetVal = "SELECT * FROM [Produtos da nota fiscal]"

      'definindo a expressão de ligação com o pai
      x$ = "[Sequencia da nota fiscal] = " & Nota_fiscal![Sequencia da nota fiscal]
      vgRetVal = InsereSQL(vgRetVal, EXP_WHERE, x$)

   ElseIf vgOq = DEFAULTDASCOLUNAS Then
      GoSub IniApDaCol
      vgRetVal = Null
      Select Case vgCol
         Case 7
            Valor_unitario = InfoProdutos(Sequencia_da_nota_fiscal, Sequencia_produto_nota_fiscal, Sequencia_do_produto, Quantidade, Valor_unitario, Valor_total, _
   Valor_do_ipi, Valor_do_icms, Aliquota_do_ipi, Aliquota_do_icms, Percentual_da_reducao, Valor_da_base_de_calculo, _
   Valor_do_pis, Valor_do_cofins, Iva, Base_de_calculo_st, Valor_icms_st, Cfop, _
   Cst, Aliquota_icms_st, Valor_dos_tributos, "Valor Unitario")
            If Grid(0).Col = 7 Then
               vgRetVal = Valor_unitario
            End If
      End Select
   ElseIf vgOq = PEGAFILTRODASCOLUNAS Then
      On Error Resume Next
      GoSub IniApDaCol
      Select Case vgCol
         Case 1
            vgRetVal = "([Sequencia do produto] > " & 0 & ") AND Inativo = " & 0 & ""
      End Select
   ElseIf vgOq = PEGAEXPRESSAOPESQUISA Then
      On Error Resume Next
      GoSub IniApDaCol
      Select Case vgCol
         Case 1
                                    vgRetVal = "SELECT Produtos.[Sequencia do produto], Produtos.Descrição, Produtos.Estoque, Produtos.[Valor total] FROM Produtos WHERE (Produtos.[Sequencia do produto] > " + CStr(0) + ") AND " + _
                                                  "(Produtos.Inativo = " + CStr(0) + ")"
      End Select
   Else
      If vgOq = VALIDACOES Then
         GoSub IniApDaCol
         vgIsValid = (Sequencia_do_produto > 0)
         If Not vgIsValid Then vgColumn =  1 
         vgErrorMessage$ = "Produto  Invalido!"
         If vgIsValid And vgCol = -1 Then
            If Nota_fiscal![Nfe complementar] = False Then
               vgIsValid = (Quantidade > 0)
               If Not vgIsValid Then vgColumn =  6 
               vgErrorMessage$ = "Quantidade inválido!"
            End If
         End If
         If vgIsValid And vgCol = -1 Then
            If Nota_fiscal![Nfe complementar] = True Then
               vgIsValid = (Quantidade >= 0)
               If Not vgIsValid Then vgColumn =  6 
               vgErrorMessage$ = "Quantidade inválido!"
            End If
         End If
         If vgIsValid And vgCol = -1 Then
            If Nota_fiscal![Nfe complementar] = False Then
               vgIsValid = (Valor_unitario > 0)
               If Not vgIsValid Then vgColumn =  7 
               vgErrorMessage$ = "Valor unitario inválido!"
            End If
         End If
         If vgIsValid And vgCol = -1 Then
            If Nota_fiscal![Nfe complementar] = True Then
               vgIsValid = (Valor_unitario >= 0)
               If Not vgIsValid Then vgColumn =  7 
               vgErrorMessage$ = "Valor unitario inválido!"
            End If
         End If
         If Not vgIsValid And Len(vgErrorMessage$) = 0 Then vgErrorMessage$ = "Err"
      ElseIf vgOq = APOS_EDICAO Then
         On Error GoTo DeuErro
         GoSub IniApDaCol
         If Abs(vgSituacao) = ACAO_INCLUINDO Then
            AjustaValores  
         ElseIf Abs(vgSituacao) = ACAO_EDITANDO Then
            AjustaValores  
         ElseIf Abs(vgSituacao) = ACAO_EXCLUINDO Then
            AjustaValores  
         End If
      ElseIf vgOq = PROCESSOS_DIRETOS Then
         GoSub IniApDaCol
         Produtos_da_nota_fiscal.Edit
         Set vgRsError = Produtos_da_nota_fiscal
         If ProcessaProdutos(Sequencia_da_nota_fiscal, Sequencia_produto_nota_fiscal, Sequencia_do_produto, Quantidade, Valor_unitario, Valor_total, _
   Valor_do_ipi, Valor_do_icms, Aliquota_do_ipi, Aliquota_do_icms, Percentual_da_reducao, Valor_da_base_de_calculo, _
   Valor_do_pis, Valor_do_cofins, Iva, Base_de_calculo_st, Valor_icms_st, Cfop, _
   Cst, Aliquota_icms_st, Valor_dos_tributos) Then
            Produtos_da_nota_fiscal![Sequencia da nota fiscal] = (0)
            Sequencia_da_nota_fiscal = Produtos_da_nota_fiscal![Sequencia da nota fiscal]
         End If
         Produtos_da_nota_fiscal.Update
         Set vgRsError = Nothing
      ElseIf vgOq = PROCESSOS_INVERSOS Or vgOq = EXCLUSOES Then
         On Error GoTo DeuErro
         GoSub IniApDaTb
      End If
   End If
   GoTo FimDaSub
   Exit Function

IniApDaCol:
   On Error Resume Next
   Sequencia_do_produto = Val(Parse$(CStr(ColumnValue(1)), Chr$(1), 1))
   Cst = ColumnValue(3)
   Cfop = ColumnValue(4)
   Quantidade = ColumnValue(6)
   Valor_unitario = ColumnValue(7)
   Aliquota_do_ipi = ColumnValue(9)
   Valor_do_ipi = ColumnValue(10)
   Percentual_da_reducao = ColumnValue(11)
   Valor_da_base_de_calculo = ColumnValue(14)
   Aliquota_do_icms = ColumnValue(15)
   Valor_do_icms = ColumnValue(16)
   Iva = ColumnValue(17)
   Aliquota_icms_st = ColumnValue(18)
   Base_de_calculo_st = ColumnValue(19)
   Valor_icms_st = ColumnValue(20)
   Valor_do_pis = ColumnValue(21)
   Valor_do_cofins = ColumnValue(22)
   Valor_dos_tributos = ColumnValue(23)
   If Grid(0).Status <> ACAO_INCLUINDO Then
      If Produtos_da_nota_fiscal.Eof = False And Produtos_da_nota_fiscal.BOF = False And Produtos_da_nota_fiscal.RecordCount > 0 Then
         Sequencia_produto_nota_fiscal = Produtos_da_nota_fiscal![Sequencia produto nota fiscal]
         Valor_total = Produtos_da_nota_fiscal![Valor total]
      End If
   End If
   If Err Then Err.Clear
   On Error GoTo DeuErro
   Return

IniApDaTb:
   On Error Resume Next
   If Produtos_da_nota_fiscal.Eof = False And Produtos_da_nota_fiscal.BOF = False And Produtos_da_nota_fiscal.RecordCount > 0 Then
      Sequencia_produto_nota_fiscal = Produtos_da_nota_fiscal![Sequencia produto nota fiscal]
      Sequencia_do_produto = Produtos_da_nota_fiscal![Sequencia do produto]
      Quantidade = Produtos_da_nota_fiscal!Quantidade
      Valor_unitario = Produtos_da_nota_fiscal![Valor unitario]
      Valor_total = Produtos_da_nota_fiscal![Valor total]
      Valor_do_ipi = Produtos_da_nota_fiscal![Valor do ipi]
      Valor_do_icms = Produtos_da_nota_fiscal![Valor do icms]
      Aliquota_do_ipi = Produtos_da_nota_fiscal![Aliquota do ipi]
      Aliquota_do_icms = Produtos_da_nota_fiscal![Aliquota do icms]
      Percentual_da_reducao = Produtos_da_nota_fiscal![Percentual da redução]
      Valor_da_base_de_calculo = Produtos_da_nota_fiscal![Valor da base de calculo]
      Valor_do_pis = Produtos_da_nota_fiscal![Valor do pis]
      Valor_do_cofins = Produtos_da_nota_fiscal![Valor do cofins]
      Iva = Produtos_da_nota_fiscal!Iva
      Base_de_calculo_st = Produtos_da_nota_fiscal![Base de calculo st]
      Valor_icms_st = Produtos_da_nota_fiscal![Valor icms st]
      Cfop = Produtos_da_nota_fiscal!Cfop
      Cst = Produtos_da_nota_fiscal!Cst
      Aliquota_icms_st = Produtos_da_nota_fiscal![Aliquota icms st]
      Valor_dos_tributos = Produtos_da_nota_fiscal![Valor dos tributos]
   End If
   If Err Then Err.Clear
   On Error GoTo DeuErro
   Return

DeuErro:
   If vgOq = CONTEUDODACOLUNA Or vgOq = DEFAULTDASCOLUNAS Or vgOq < 0 Then
      vgRetVal = Null
   Else
      vgErrorMessage$ = Err.Source + "|" + Trim$(Str$(Err)) + "-" + Error$
      vgIsValid = False
   End If
   If Not vgRsError Is Nothing Then
      vgRsError.CancelUpdate
      vgErrorMessage$ = vgRsError.Table & "=>" & vgErrorMessage$
      Set vgRsError = Nothing
   End If
   Resume ResumeErro

ResumeErro:
   On Error Resume Next

FimDaSub:
   ExecutaGrid0 = vgRetVal
   vgPriVez = False
End Function


'inicializações, validações e processos do grid filho
Private Function ExecutaGrid1(ColumnValue() As Variant, ByVal vgOq As Integer, Optional ByVal vgItem As Long, Optional ByVal vgCol As Integer, Optional vgIsValid As Boolean, Optional ByRef vgColumn As Integer, Optional vgErrorMessage As String, Optional KeyCodeAscii As Integer, Optional Shift As Integer) As Variant
   Dim vgRetVal As Variant, vgRsError As GRecordSet, x as String, vgNVez As Integer
   Dim Numero_da_parcela As Integer, Dias As Integer, Data_de_vencimento As Variant
   Dim Valor_da_parcela As Double
   vgPriVez = True
   If vgOq = PREVALIDACOES Then
      vgRetVal = False
   Else
      vgRetVal = ""
   End If
   vgNVez = 0
   On Error GoTo DeuErro
   If vgOq = CONTEUDODACOLUNA Then
      If Grid(1).Status <> ACAO_NAVEGANDO And vgItem = Grid(1).SelectedItem Then
         GoSub IniApDaCol
      Else
         GoSub IniApDaTb
      End If
      On Error Resume Next
      If Err Then Err.Clear
   ElseIf vgOq = CONDICOES_ESPECIAIS Then
      If vgSituacao <> ACAO_INCLUINDO Then
         GoSub IniApDaTb
      On Error Resume Next
         Grid(1).AllowInsert = (((Autorizada = 0) AND Nota_Cancelada = 0) AND Not Vazio(Nota_Fiscal![Forma de pagamento]) AND TotalParcelas < Valor_total_da_nfe)
      On Error Resume Next
         Grid(1).AllowEdit = (((Autorizada = 0) AND Nota_Cancelada = 0) AND Not Vazio(Nota_Fiscal![Forma de pagamento]))
      On Error Resume Next
         Grid(1).AllowDelete = (((Autorizada = 0) AND Nota_Cancelada = 0) AND Not Vazio(Nota_Fiscal![Forma de pagamento]))
      End If
      vgRetVal = ""
   ElseIf vgOq = ABRE_TABELA_GRID Then
      On Error Resume Next
      vgRetVal = "SELECT * FROM [Parcelas nota fiscal]"

      'definindo a expressão de ligação com o pai
      x$ = "[Sequencia da nota fiscal] = " & Nota_fiscal![Sequencia da nota fiscal]
      vgRetVal = InsereSQL(vgRetVal, EXP_WHERE, x$)

   ElseIf vgOq = DEFAULTDASCOLUNAS Then
      GoSub IniApDaCol
      vgRetVal = Null
      Select Case vgCol
         Case 1
            Numero_da_parcela = UltimaParcela
            vgRetVal = Numero_da_parcela
         Case 2
            Dias = DateDiff("D", Nota_fiscal![Data de emissão] , Data_de_vencimento)
            vgRetVal = Dias
         Case 3
            Data_de_vencimento = DateAdd("D", Dias, Nota_fiscal![Data de emissão])
            vgRetVal = Data_de_vencimento
         Case 4
            Valor_da_parcela = Nota_Fiscal![Valor total da nfe] - TotalParcelas()
            vgRetVal = Valor_da_parcela
      End Select
   Else
      If vgOq = VALIDACOES Then
         GoSub IniApDaCol
         vgIsValid = (1 = 1)
         If Not vgIsValid Then vgColumn =  2 
         vgErrorMessage$ = "Dias inválido!"
         If vgIsValid And vgCol = -1 Then
            vgIsValid = ((UltimoVencimento) And (IsDate(Data_de_vencimento) Or Vazio(Data_de_vencimento)))
            If Not vgIsValid Then vgColumn =  3 
            vgErrorMessage$ = "Vencimento Invalido!"
         End If
         If vgIsValid And vgCol = -1 Then
            vgIsValid = (IIf(vgSituacao = -ACAO_INCLUINDO, IIf(Nota_fiscal![Forma de pagamento] = "Prazo" , TotalParcelas() + Valor_da_Parcela <= Nota_Fiscal![Valor total da nfe], Valor_da_parcela = Nota_fiscal![Valor total da nfe]), IIf(Nota_fiscal![Forma de pagamento] = "Vista" , Valor_da_parcela = Nota_Fiscal![Valor total da nfe], Valor_da_parcela > 0 And (TotalParcelas() - TotalParcelas(Numero_da_parcela)) + Valor_da_Parcela <= Nota_Fiscal![Valor total da nfe])))
            If Not vgIsValid Then vgColumn =  4 
            vgErrorMessage$ = "A Soma das Parcelas não Correspondem ao Valor Total da Nota Fiscal."
         End If
         If Not vgIsValid And Len(vgErrorMessage$) = 0 Then vgErrorMessage$ = "Err"
      ElseIf vgOq = INICIALIZACOES Then
         GoSub IniApDaCol
         ColumnValue(1) = UltimaParcela
      End If
   End If
   GoTo FimDaSub
   Exit Function

IniApDaCol:
   On Error Resume Next
   Numero_da_parcela = ColumnValue(1)
   Dias = ColumnValue(2)
   Data_de_vencimento = ColumnValue(3)
   Valor_da_parcela = ColumnValue(4)
   If Err Then Err.Clear
   On Error GoTo DeuErro
   Return

IniApDaTb:
   On Error Resume Next
   If Parcelas_nota_fiscal.Eof = False And Parcelas_nota_fiscal.BOF = False And Parcelas_nota_fiscal.RecordCount > 0 Then
      Numero_da_parcela = Parcelas_nota_fiscal![Numero da parcela]
      Dias = Parcelas_nota_fiscal!Dias
      Data_de_vencimento = Parcelas_nota_fiscal![Data de vencimento]
      Valor_da_parcela = Parcelas_nota_fiscal![Valor da parcela]
   End If
   If Err Then Err.Clear
   On Error GoTo DeuErro
   Return

DeuErro:
   If vgOq = CONTEUDODACOLUNA Or vgOq = DEFAULTDASCOLUNAS Or vgOq < 0 Then
      vgRetVal = Null
   Else
      vgErrorMessage$ = Err.Source + "|" + Trim$(Str$(Err)) + "-" + Error$
      vgIsValid = False
   End If
   If Not vgRsError Is Nothing Then
      vgRsError.CancelUpdate
      vgErrorMessage$ = vgRsError.Table & "=>" & vgErrorMessage$
      Set vgRsError = Nothing
   End If
   Resume ResumeErro

ResumeErro:
   On Error Resume Next

FimDaSub:
   ExecutaGrid1 = vgRetVal
   vgPriVez = False
End Function


'inicializações, validações e processos do grid filho
Private Function ExecutaGrid2(ColumnValue() As Variant, ByVal vgOq As Integer, Optional ByVal vgItem As Long, Optional ByVal vgCol As Integer, Optional vgIsValid As Boolean, Optional ByRef vgColumn As Integer, Optional vgErrorMessage As String, Optional KeyCodeAscii As Integer, Optional Shift As Integer) As Variant
   Dim vgRetVal As Variant, vgRsError As GRecordSet, x as String, vgNVez As Integer
   Dim Chave_da_nfe As String
   vgPriVez = True
   If vgOq = PREVALIDACOES Then
      vgRetVal = False
   Else
      vgRetVal = ""
   End If
   vgNVez = 0
   On Error GoTo DeuErro
   If vgOq = CONTEUDODACOLUNA Then
      If Grid(2).Status <> ACAO_NAVEGANDO And vgItem = Grid(2).SelectedItem Then
         GoSub IniApDaCol
      Else
         GoSub IniApDaTb
      End If
      On Error Resume Next
      Select Case vgCol
         Case 2
            vgRetVal = (MostraMesAno(Sequencia_da_nota_fiscal, Chave_da_nfe))
            vgColumn = -1                   'flag para permitir definição desse novo valor para coluna do grid
         Case 3
            vgRetVal = (MostraUFNFe(Sequencia_da_nota_fiscal, Chave_da_nfe))
            vgColumn = -1                   'flag para permitir definição desse novo valor para coluna do grid
         Case 4
            vgRetVal = (MostraNroNFe(Sequencia_da_nota_fiscal, Chave_da_nfe))
            vgColumn = -1                   'flag para permitir definição desse novo valor para coluna do grid
      End Select
      If Err Then Err.Clear
   ElseIf vgOq = PREVALIDACOES Then
      GoSub IniApDaCol
      Select Case vgCol
         Case 1
            vgRetVal = Not (Devolucao = True)
         Case Else
            vgRetVal = False
      End Select
   ElseIf vgOq = CONDICOES_ESPECIAIS Then
      If vgSituacao <> ACAO_INCLUINDO Then
         GoSub IniApDaTb
      End If
      vgRetVal = ""
   ElseIf vgOq = ABRE_TABELA_GRID Then
      On Error Resume Next
      vgRetVal = "SELECT * FROM [NFe devolução]"

      'definindo a expressão de ligação com o pai
      x$ = "[Sequencia da nota fiscal] = " & Nota_fiscal![Sequencia da nota fiscal]
      vgRetVal = InsereSQL(vgRetVal, EXP_WHERE, x$)

   Else
      If vgOq = VALIDACOES Then
         GoSub IniApDaCol
         If Devolucao = True Then
            vgIsValid = (ValidaChave(Sequencia_da_nota_fiscal, Chave_da_nfe))
            If Not vgIsValid Then vgColumn =  1 
            vgErrorMessage$ = "Chave da NFe Referenciada deve conter 44 Digitos"
         End If
         If Not vgIsValid And Len(vgErrorMessage$) = 0 Then vgErrorMessage$ = "Err"
      End If
   End If
   GoTo FimDaSub
   Exit Function

IniApDaCol:
   On Error Resume Next
   Chave_da_nfe = ColumnValue(1) & ""
   If Err Then Err.Clear
   On Error GoTo DeuErro
   Return

IniApDaTb:
   On Error Resume Next
   If NFe_devolucao.Eof = False And NFe_devolucao.BOF = False And NFe_devolucao.RecordCount > 0 Then
      Chave_da_nfe = NFe_devolucao![Chave da nfe]
   End If
   If Err Then Err.Clear
   On Error GoTo DeuErro
   Return

DeuErro:
   If vgOq = CONTEUDODACOLUNA Or vgOq = DEFAULTDASCOLUNAS Or vgOq < 0 Then
      vgRetVal = Null
   Else
      vgErrorMessage$ = Err.Source + "|" + Trim$(Str$(Err)) + "-" + Error$
      vgIsValid = False
   End If
   If Not vgRsError Is Nothing Then
      vgRsError.CancelUpdate
      vgErrorMessage$ = vgRsError.Table & "=>" & vgErrorMessage$
      Set vgRsError = Nothing
   End If
   Resume ResumeErro

ResumeErro:
   On Error Resume Next

FimDaSub:
   ExecutaGrid2 = vgRetVal
   vgPriVez = False
End Function

'evento - pega o valor inicial das colunas do grid
Private Sub Grid_GetColumnDefaultValue(Index As Integer, ByVal vgCol As Integer, vgColumns() As Variant, ByRef vgDefaultValue As Variant)
   vgDefaultValue = ExecutaGrid(Index, vgColumns(), DEFAULTDASCOLUNAS, , vgCol)
End Sub

'evento - quer pegar valores para cada célula
Private Sub Grid_GetColumnLocked(Index As Integer, ByVal vgRow As Long, ByVal vgCol As Long, vgColumns() As Variant, ByRef FormField As FormataCampos, ByRef vgLocked As Boolean)
   Select Case Index
      Case 0
         vgLocked = ExecutaGrid(Index, vgColumns(), PREVALIDACOES, , vgCol)
      Case 1
         vgLocked = ExecutaGrid(Index, vgColumns(), PREVALIDACOES, , vgCol)
      Case 2
         vgLocked = ExecutaGrid(Index, vgColumns(), PREVALIDACOES, , vgCol)
   End Select
End Sub

'evento - quando o botão for pressionado
Private Sub Botao_Click(Index As Integer)
   Dim Cancel As Boolean, hMenu As Long, pt As POINTAPI
   If vgPriVez Then Exit Sub
   Select Case Index
      Case 0
         seqRegistro = Sequencia_da_natureza 
         mdiNFE.MCfop
      Case 1
         seqRegistro = Sequencia_da_Transportadora 
         mdiNFE.MGeral
      Case 2
         seqRegistro = Sequencia_do_Geral 
         mdiNFE.MGeral
      Case 3
         SuperAcao  
      Case 4
         AbreCancelamento  
      Case 5
         AbreCCe  
      Case 6
         DACCE  
   End Select
End Sub


'evento - quando o botão for apertado
Private Sub bottxtCampo34_Click(Index As Integer)
   txtCampo(34).SetFocus
   DoEvents
   txtCampo(34).botClick Index
End Sub

'evento - quando o botão for apertado
Private Sub bottxtCampo35_Click(Index As Integer)
   txtCampo(35).SetFocus
   DoEvents
   txtCampo(35).botClick Index
End Sub

'evento - quando o botão for apertado
Private Sub bottxtCampo0_Click(Index As Integer)
   txtCampo(0).SetFocus
   DoEvents
   txtCampo(0).botClick Index
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
Private Sub bottxtCampo7_Click(Index As Integer)
   txtCampo(7).SetFocus
   DoEvents
   txtCampo(7).botClick Index
End Sub

'evento - quando o botão for apertado
Private Sub bottxtCampo15_Click(Index As Integer)
   txtCampo(15).SetFocus
   DoEvents
   txtCampo(15).botClick Index
End Sub

'evento - quando o botão for apertado
Private Sub bottxtCampo16_Click(Index As Integer)
   txtCampo(16).SetFocus
   DoEvents
   txtCampo(16).botClick Index
End Sub

'evento - quando o botão for apertado
Private Sub bottxtCampo17_Click(Index As Integer)
   txtCampo(17).SetFocus
   DoEvents
   txtCampo(17).botClick Index
End Sub

'evento - quando o botão for apertado
Private Sub bottxtCampo18_Click(Index As Integer)
   txtCampo(18).SetFocus
   DoEvents
   txtCampo(18).botClick Index
End Sub

'evento - quando o botão for apertado
Private Sub bottxtCampo19_Click(Index As Integer)
   txtCampo(19).SetFocus
   DoEvents
   txtCampo(19).botClick Index
End Sub

'evento - quando o botão for apertado
Private Sub bottxtCampo20_Click(Index As Integer)
   txtCampo(20).SetFocus
   DoEvents
   txtCampo(20).botClick Index
End Sub

'evento - quando o botão for apertado
Private Sub bottxtCampo21_Click(Index As Integer)
   txtCampo(21).SetFocus
   DoEvents
   txtCampo(21).botClick Index
End Sub

'evento - quando o botão for apertado
Private Sub bottxtCampo22_Click(Index As Integer)
   txtCampo(22).SetFocus
   DoEvents
   txtCampo(22).botClick Index
End Sub

'evento - quando o botão for apertado
Private Sub bottxtCampo23_Click(Index As Integer)
   txtCampo(23).SetFocus
   DoEvents
   txtCampo(23).botClick Index
End Sub

'evento - quando o botão for apertado
Private Sub bottxtCampo24_Click(Index As Integer)
   txtCampo(24).SetFocus
   DoEvents
   txtCampo(24).botClick Index
End Sub

'evento - quando o botão for apertado
Private Sub bottxtCampo25_Click(Index As Integer)
   txtCampo(25).SetFocus
   DoEvents
   txtCampo(25).botClick Index
End Sub

'evento - quando o botão for apertado
Private Sub bottxtCampo26_Click(Index As Integer)
   txtCampo(26).SetFocus
   DoEvents
   txtCampo(26).botClick Index
End Sub

'evento - quando o botão for apertado
Private Sub bottxtCampo37_Click(Index As Integer)
   txtCampo(37).SetFocus
   DoEvents
   txtCampo(37).botClick Index
End Sub

'evento - quando o botão for apertado
Private Sub bottxtCampo32_Click(Index As Integer)
   txtCampo(32).SetFocus
   DoEvents
   txtCampo(32).botClick Index
End Sub

'evento - quando o mouse for pressionado sobre o campo
Private Sub txtCp_MouseDown(Index As Integer, Button As Integer, Shift As Integer, x as Single, y as Single)
   txtCampo(Index).MouseDown
End Sub


