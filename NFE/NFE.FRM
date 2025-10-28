Version 5.00
Begin VB.MDIForm mdiNFE
   Height                   =   3000
   Left                     =   1440
   LinkTopic                =   "NFE"
   LockControls             =   -1
   AutoShowChildren         =   0
   NegotiateToolbars=   0
   Icon                     =   "NFE.frx":0000
   Top                      =   2260
   Width                    =   8670
   Begin NFE.GPainel panTools
      AutoRedraw               =   -1
      BackColor                =   &HE0E0E0
      BevelOuter               =   2
      BevelInner               =   0
      BorderWidth              =   0
      BevelWidth               =   1
      BorderStyle              =   0
      Align                    =   1
      Stretch                  =   -1
      Stripes                  =   0
      SaveGridBars             =   0
      Height                   =   930
      Left                     =   -75000
      Width                    =   8385
      Top                      =   0
      TabStop                  =  0
      _extentx                 =   14782
      _extenty                 =   1639
      Begin NFE.GPainel Painel
         AutoRedraw               =   -1
         BackColor                =   &H8000000F
         BevelOuter               =   1
         BevelInner               =   0
         BorderWidth              =   1
         BevelWidth               =   1
         BorderStyle              =   0
         Align                    =   0
         Stretch                  =   -1
         Stripes                  =   0
         SaveGridBars             =   0
         Height                   =   840
         Left                     =   60
         Width                    =   5880
         Top                      =   60
         TabStop                  =  0
         _extentx                 =   10366
         _extenty                 =   1480
         Index                    =   0 
         Begin NFE.GBotao botInclui
            ButtonStyle              =   1
            JoinSeparators           =   0
            LeftSeparator            =   0
            TopSeparator             =   0
            TabIndex                 =   1
            TabStop                  =   -1
            ButtonType               =   0
            Height                   =   360
            Left                     =   15
            Width                    =   1440
            Top                      =   75
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
            ForeColor                =   &H0
            Caption                  =   "Incluir"
            TabStop                  =   0
         End
         Begin NFE.GBotao botCancela
            ButtonStyle              =   1
            JoinSeparators           =   0
            LeftSeparator            =   0
            TopSeparator             =   0
            TabIndex                 =   2
            TabStop                  =   -1
            ButtonType               =   0
            Height                   =   360
            Left                     =   1455
            Width                    =   1440
            Top                      =   75
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
            ForeColor                =   &H0
            Caption                  =   "Cancelar"
            TabStop                  =   0
         End
         Begin NFE.GBotao botBrowse
            ButtonStyle              =   1
            JoinSeparators           =   0
            LeftSeparator            =   0
            TopSeparator             =   0
            TabIndex                 =   3
            TabStop                  =   -1
            ButtonType               =   1
            Height                   =   360
            Left                     =   2895
            Width                    =   1440
            Top                      =   75
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
            ForeColor                =   &H0
            Caption                  =   "Grade"
            TabStop                  =   0
         End
         Begin VB.PictureBox picNavega
            BorderStyle              =   0
            Left                     =   4335
            Height                   =   360
            Top                      =   75
            Width                    =   1480
            TabStop                  =   0
            Begin VB.HScrollBar schNavega
               LargeChange              =   10
               SmallChange              =   1
               Max                      =   32767
               Min                      =   0
               Height                   =   360
               Left                     =   0
               Width                    =   1480
               Top                      =   0
               Max                      =  101
               Min                      =  -1
               LargeChange              =  10
               SmallChange              =  1
            End
         End
         Begin NFE.GBotao botPrimeiro
            ButtonStyle              =   1
            JoinSeparators           =   0
            LeftSeparator            =   0
            TopSeparator             =   0
            TabIndex                 =   4
            TabStop                  =   -1
            ButtonType               =   0
            Height                   =   360
            Left                     =   4335
            Width                    =   360
            Top                      =   435
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
            TabStop                  =   0
         End
         Begin NFE.GBotao botAnterior
            ButtonStyle              =   1
            JoinSeparators           =   0
            LeftSeparator            =   0
            TopSeparator             =   0
            TabIndex                 =   5
            TabStop                  =   -1
            ButtonType               =   0
            Height                   =   360
            Left                     =   4710
            Width                    =   360
            Top                      =   435
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
            TabStop                  =   0
         End
         Begin NFE.GBotao botSeguinte
            ButtonStyle              =   1
            JoinSeparators           =   0
            LeftSeparator            =   0
            TopSeparator             =   0
            TabIndex                 =   6
            TabStop                  =   -1
            ButtonType               =   0
            Height                   =   360
            Left                     =   5085
            Width                    =   360
            Top                      =   435
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
            TabStop                  =   0
         End
         Begin NFE.GBotao botUltimo
            ButtonStyle              =   1
            JoinSeparators           =   0
            LeftSeparator            =   0
            TopSeparator             =   0
            TabIndex                 =   7
            TabStop                  =   -1
            ButtonType               =   0
            Height                   =   360
            Left                     =   5460
            Width                    =   360
            Top                      =   435
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
            TabStop                  =   0
         End
         Begin NFE.GBotao botImprime
            ButtonStyle              =   1
            JoinSeparators           =   0
            LeftSeparator            =   0
            TopSeparator             =   0
            TabIndex                 =   8
            TabStop                  =   -1
            ButtonType               =   0
            Height                   =   360
            Left                     =   2895
            Width                    =   1440
            Top                      =   435
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
            ForeColor                =   &H0
            Caption                  =   "Print"
            TabStop                  =   0
         End
         Begin NFE.GBotao botExclui
            ButtonStyle              =   1
            JoinSeparators           =   0
            LeftSeparator            =   0
            TopSeparator             =   0
            TabIndex                 =   9
            TabStop                  =   -1
            ButtonType               =   0
            Height                   =   360
            Left                     =   1455
            Width                    =   1440
            Top                      =   435
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
            ForeColor                =   &H0
            Caption                  =   "Excluir"
            TabStop                  =   0
         End
         Begin NFE.GBotao botSalva
            ButtonStyle              =   1
            JoinSeparators           =   0
            LeftSeparator            =   0
            TopSeparator             =   0
            TabIndex                 =   10
            TabStop                  =   -1
            ButtonType               =   0
            Height                   =   360
            Left                     =   15
            Width                    =   1440
            Top                      =   435
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
            ForeColor                =   &H0
            Caption                  =   "Gravar"
            TabStop                  =   0
         End
      End
      Begin NFE.GBotao Botao
         ButtonStyle              =   1
         JoinSeparators           =   0
         LeftSeparator            =   0
         TopSeparator             =   0
         TabIndex                 =   0
         TabStop                  =   -1
         ButtonType               =   1
         Height                   =   180
         Left                     =   240
         Width                    =   300
         Top                      =   1080
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
         TabStop                  =   0
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &HE0E0E0
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   -1
         Height                   =   435
         Left                     =   120
         Width                    =   3435
         Top                      =   300
         Alignment                =   0
         BeginProperty Font
            Name                     =   "Verdana"
            CharSet                  =   0
            Weight                   =   700
            Size                     =   18
            Underline                =   0
            Italic                   =   0
            StrikeThrough            =   0
         EndProperty
         ForeColor                =   &H80000008
         Caption                  =   "Emissor de MDFe"
         Index                    =   0 
      End
      Begin NFE.GBotao Botao
         ButtonStyle              =   0
         JoinSeparators           =   0
         LeftSeparator            =   0
         TopSeparator             =   0
         TabIndex                 =   11
         TabStop                  =   0
         ButtonType               =   0
         Height                   =   840
         Left                     =   6990
         Width                    =   1110
         Top                      =   60
         CaptionAlign             =   1
         CaptionOffset            =   50
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851}
            Name                     =   "Arial"
            CharSet                  =   0
            Weight                   =   700
            Size                     =   11.25
            Underline                =   0
            Italic                   =   0
            StrikeThrough            =   0
         EndProperty
         ForeColor                =   &H80000012
         Caption                  =   "MDF-E"
         Index                    =   1 
      End
   End
   Begin NFE.GPainel Painel
      AutoRedraw               =   -1
      BackColor                =   &HE0E0E0
      BevelOuter               =   1
      BevelInner               =   2
      BorderWidth              =   1
      BevelWidth               =   1
      BorderStyle              =   0
      Align                    =   2
      Stretch                  =   -1
      Stripes                  =   0
      SaveGridBars             =   0
      Height                   =   390
      Left                     =   -75000
      Width                    =   8385
      Top                      =   2010
      TabStop                  =  0
      _extentx                 =   14782
      _extenty                 =   687
      Index                    =   1 
      Begin VB.Label Label
         Appearance               =   0
         BackColor                =   &HE0E0E0
         BackStyle                =   1
         BorderStyle              =   1
         AutoSize                 =   0
         Height                   =   255
         Left                     =   60
         Width                    =   2040
         Top                      =   60
         Alignment                =   0
         BeginProperty Font
            Name                     =   "Microsoft Sans Serif"
            CharSet                  =   0
            Weight                   =   700
            Size                     =   8.25
            Underline                =   0
            Italic                   =   0
            StrikeThrough            =   0
         EndProperty
         ForeColor                =   &H0
         Caption                  =   "Grupo"
         Index                    =   1 
      End
      Begin VB.Label Label
         Appearance               =   0
         BackColor                =   &HE0E0E0
         BackStyle                =   1
         BorderStyle              =   1
         AutoSize                 =   0
         Height                   =   255
         Left                     =   2160
         Width                    =   2040
         Top                      =   60
         Alignment                =   0
         BeginProperty Font
            Name                     =   "Microsoft Sans Serif"
            CharSet                  =   0
            Weight                   =   700
            Size                     =   8.25
            Underline                =   0
            Italic                   =   0
            StrikeThrough            =   0
         EndProperty
         ForeColor                =   &H80000008
         Caption                  =   "Usuario"
         Index                    =   2 
      End
      Begin VB.Label Label
         Appearance               =   0
         BackColor                =   &HE0E0E0
         BackStyle                =   1
         BorderStyle              =   1
         AutoSize                 =   0
         Height                   =   255
         Left                     =   4260
         Width                    =   2040
         Top                      =   60
         Alignment                =   0
         BeginProperty Font
            Name                     =   "Microsoft Sans Serif"
            CharSet                  =   0
            Weight                   =   700
            Size                     =   8.25
            Underline                =   0
            Italic                   =   0
            StrikeThrough            =   0
         EndProperty
         ForeColor                =   &H80000008
         Caption                  =   "Data e Hora"
         Index                    =   3 
      End
      Begin VB.Label Label
         Appearance               =   0
         BackColor                =   &HE0E0E0
         BackStyle                =   1
         BorderStyle              =   1
         AutoSize                 =   0
         Height                   =   255
         Left                     =   6360
         Width                    =   2040
         Top                      =   60
         Alignment                =   0
         BeginProperty Font
            Name                     =   "Microsoft Sans Serif"
            CharSet                  =   0
            Weight                   =   700
            Size                     =   8.25
            Underline                =   0
            Italic                   =   0
            StrikeThrough            =   0
         EndProperty
         ForeColor                =   &H80000008
         Caption                  =   "Pc"
         Index                    =   4 
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &HE0E0E0
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   -1
         Height                   =   240
         Left                     =   9420
         Width                    =   60
         Top                      =   60
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
         Caption                  =   ""
         Index                    =   5 
      End
      Begin VB.Label Label
         Appearance               =   1
         BackColor                =   &HE0E0E0
         BackStyle                =   1
         BorderStyle              =   0
         AutoSize                 =   -1
         Height                   =   240
         Left                     =   14580
         Width                    =   60
         Top                      =   60
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
         Caption                  =   ""
         Index                    =   6 
      End
                  Begin VB.Timer timRefresh
                           Enabled         =   0
                           Interval        =   5000
                           left            =   6120
                           top             =   60
                  End
                  Begin VB.PictureBox picAux 
                           AutoRedraw      =   -1   'True   
                           AutoSize        =   -1   'True   
                           BorderStyle     =   0    'None    
                           Height          =   255         
                           Left            =   6520
                           ScaleHeight     =   255         
                           ScaleWidth      =   285         
                           TabIndex        =   18          
                           Top             =   60
                           Visible         =   0    'False  
                           Width           =   285         
                  End
         End
   Begin VB.Menu Menu_570
      Caption         =   "&Arquivo"
      Index           =   0
      Tag             =   "570|1"
      Begin VB.Menu Menu_Consulta
         Caption         =   "C&onstrução de consultas"
         Tag             =   "571|2"
      End
      Begin VB.Menu Menu_Repara
         Caption         =   "&Reparação"
         Tag             =   "572|2"
      End
      Begin VB.Menu Menu_Info
         Caption         =   "&Informações sobre o BD"
         Tag             =   "573|2"
      End
      Begin VB.Menu Menu_ConfImp
         Caption         =   "&Configuração impressora"
         Tag             =   "574|2"
      End
      Begin VB.Menu Menu_Senhas
         Caption         =   "&Manutenção de senhas"
         Tag             =   "575|2"
      End
      Begin VB.Menu Menu_N1
         Caption         =   "-"
      End
      Begin VB.Menu Menu_Fim
         Caption         =   "&Finalizar"
         Tag             =   "577|2"
      End
   End
   Begin VB.Menu Menu_570
      Caption         =   "&Editar"
      Index           =   1
      Tag             =   "578|1"
      Begin VB.Menu Menu_Salva
         Caption         =   "&Gravar"
         Shortcut        =   ^S
         Tag             =   "579|2"
      End
      Begin VB.Menu Menu_Cancela
         Caption         =   "&Cancelar"
         Shortcut        =   ^A
         Tag             =   "580|2"
      End
      Begin VB.Menu Menu_Inclui
         Caption         =   "&Incluir"
         Shortcut        =   ^I
         Tag             =   "581|2"
      End
      Begin VB.Menu Menu_Exclui
         Caption         =   "&Excluir"
         Shortcut        =   ^E
         Tag             =   "582|2"
      End
      Begin VB.Menu Menu_N2
         Caption         =   "-"
      End
      Begin VB.Menu Menu_ApagaCol
         Caption         =   "Apagar co&luna"
         Shortcut        =   ^L
         Tag             =   "584|2"
      End
      Begin VB.Menu Menu_Procura
         Caption         =   "&Procurar"
         Shortcut        =   ^P
         Tag             =   "585|2"
      End
      Begin VB.Menu Menu_Filtra
         Caption         =   "&Filtrar"
         Shortcut        =   ^F
         Tag             =   "586|2"
      End
      Begin VB.Menu Menu_Grafa
         Caption         =   "G&rafar"
         Shortcut        =   ^G
         Tag             =   "587|2"
      End
      Begin VB.Menu Menu_Imprime
         Caption         =   "I&mprimir"
         Tag             =   "588|2"
      End
      Begin VB.Menu Menu_ConfGraf
         Caption         =   "Co&nfigurar"
         Tag             =   "589|2"
      End
      Begin VB.Menu Menu_Ortog
         Caption         =   "&Ortografia"
         Tag             =   "590|2"
      End
      Begin VB.Menu Menu_Repeticao
         Caption         =   "&Repetir campos"
         Shortcut        =   {F3}
         Tag             =   "591|2"
      End
      Begin VB.Menu Menu_FRM00621
         Caption         =   "Capitaliza"
         Tag             =   "621|2"
      End
      Begin VB.Menu Menu_N3
         Caption         =   "-"
      End
      Begin VB.Menu Menu_Primeiro
         Caption         =   "Primeir&o"
         Shortcut        =   {F5}
         Tag             =   "594|2"
      End
      Begin VB.Menu Menu_Anterior
         Caption         =   "&Anterior"
         Shortcut        =   {F6}
         Tag             =   "595|2"
      End
      Begin VB.Menu Menu_Seguinte
         Caption         =   "&Seguinte"
         Shortcut        =   {F7}
         Tag             =   "596|2"
      End
      Begin VB.Menu Menu_Ultimo
         Caption         =   "&Ultimo"
         Shortcut        =   {F8}
         Tag             =   "597|2"
      End
   End
   Begin VB.Menu Menu_570
      Caption         =   "&Parametros"
      Index           =   2
      Tag             =   "613|1"
      Begin VB.Menu Menu_614
         Caption         =   "&Parametros do Emitente"
         Index           =   0
         Tag             =   "614|2"
      End
      Begin VB.Menu Menu_614
         Caption         =   "&Parametros do MDFe"
         Index           =   1
         Tag             =   "615|2"
      End
   End
   Begin VB.Menu Menu_570
      Caption         =   "&Cadastro"
      Index           =   3
      Tag             =   "611|1"
      Begin VB.Menu Menu_642
         Caption         =   "&Emitentes"
         Index           =   0
         Tag             =   "642|2"
      End
      Begin VB.Menu Menu_642
         Caption         =   "&Municípios"
         Index           =   1
         Tag             =   "619|2"
      End
      Begin VB.Menu Menu_642
         Caption         =   "&Motoristas"
         Index           =   2
         Tag             =   "651|2"
      End
   End
   Begin VB.Menu Menu_570
      Caption         =   "&Manifesto"
      Index           =   4
      Tag             =   "638|1"
      Begin VB.Menu Menu_639
         Caption         =   "&MDF-e"
         Index           =   0
         Tag             =   "639|2"
      End
      Begin VB.Menu Menu_639
         Caption         =   "&Ocultos"
         Index           =   1
         Tag             =   "646|2"
         Begin VB.Menu Menu_647
            Caption         =   "Cancela Manifesto"
            Index           =   0
            Tag             =   "647|3"
         End
         Begin VB.Menu Menu_647
            Caption         =   "Encerra Manifesto"
            Index           =   1
            Tag             =   "648|3"
         End
      End
   End
   Begin VB.Menu Menu_570
      Caption         =   "&Consultas"
      Index           =   5
      Tag             =   "631|1"
   End
   Begin VB.Menu Menu_570
      Caption         =   "&Ferramentas"
      Index           =   6
      Tag             =   "636|1"
      Begin VB.Menu Menu_637
         Caption         =   "Copia de Segurança"
         Index           =   0
         Tag             =   "637|2"
      End
   End
   Begin VB.Menu Menu_570
      Caption         =   "E&xibir"
      Index           =   7
      Tag             =   "598|1"
      Begin VB.Menu Menu_Barra
         Caption         =   "&Barra de ferramentas"
         Tag             =   "599|2"
      End
      Begin VB.Menu Menu_Ajuda
         Caption         =   "&Ajuda ativa"
         Tag             =   "600|2"
      End
      Begin VB.Menu Menu_Browse
         Caption         =   "Em &grade"
         Shortcut        =   {F9}
         Tag             =   "601|2"
      End
   End
   Begin VB.Menu Menu_570
      Caption         =   "&Janela"
      Index           =   8
      Windowlist      =   -1
      Tag             =   "602|1"
      Begin VB.Menu Menu_Cascata
         Caption         =   "&Cascata"
         Tag             =   "603|2"
      End
      Begin VB.Menu Menu_Vert
         Caption         =   "Lado a lado &vertical"
         Tag             =   "604|2"
      End
      Begin VB.Menu Menu_Horiz
         Caption         =   "Lado a lado &horizontal"
         Tag             =   "605|2"
      End
      Begin VB.Menu Menu_Organiza
         Caption         =   "&Organizar ícones"
         Tag             =   "606|2"
      End
   End
   Begin VB.Menu Menu_570
      Caption         =   "A&juda"
      Index           =   9
      Tag             =   "607|1"
      Begin VB.Menu Menu_Conteudo
         Caption         =   "&Conteúdo"
         Shortcut        =   {F1}
         Tag             =   "608|2"
      End
      Begin VB.Menu Menu_N4
         Caption         =   "-"
      End
      Begin VB.Menu Menu_Sobre
         Caption         =   "Sobre&..."
         Tag             =   "610|2"
      End
   End
         Begin VB.Menu Menu_PropGrade
                  Caption         =   "PropGrades"
                  Visible         =   0             'False
                  Begin VB.Menu Menu_Grd_ApgCol
                           Caption         =   "&Apagar colunas"
                  End
                  Begin VB.Menu Menu_Grd_Filtra
                           Caption         =   "&Filtrar"
                  End
                  Begin VB.Menu Menu_Grd_Graf
                           Caption         =   "&Grafar"
                  End
                  Begin VB.Menu Menu_Grd_Imp
                           Caption         =   "&Imprimir"
                  End
                  Begin VB.Menu Menu_Grd_Procura
                           Caption         =   "&Procurar"
                  End
                  Begin VB.Menu Menu_Grd_Constroi
                           Caption         =   "&Remontar a grade"
                  End
         End
         Begin VB.Menu M_Oper 
                  Caption         =   "MOper"
                  Visible         =   0             'False
                  Begin VB.Menu Menu_Operador 
                           Caption         =   "Like"
                           Index           =   0
                  End
                  Begin VB.Menu Menu_Operador 
                           Caption         =   "="
                           Index           =   1
                  End
                  Begin VB.Menu Menu_Operador 
                           Caption         =   "<>"
                           Index           =   2
                  End
                  Begin VB.Menu Menu_Operador 
                           Caption         =   "Vazio"
                           Index           =   3
                  End
                  Begin VB.Menu Menu_Operador 
                           Caption         =   "<"
                           Index           =   4
                  End
                  Begin VB.Menu Menu_Operador 
                           Caption         =   "<="
                           Index           =   5
                  End
                  Begin VB.Menu Menu_Operador 
                           Caption         =   ">"
                           Index           =   6
                  End
                  Begin VB.Menu Menu_Operador 
                           Caption         =   ">="
                           Index           =   7
                  End
                  Begin VB.Menu Menu_Operador 
                           Caption         =   "Entre"
                           Index           =   8
                  End
         End
End
Attribute VB_Name = "mdiNFE"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
'* Sistema...: Emissor de MDF-e (Layout 3.00)
'* Empresa...: Ygor Eduardo Dellalio
'* Módulo....: mdiNFE
'* Função....: Janela principal - MDI
'* CopyRight.: (C)2024 Ygor Eduardo Dellalio
'* Criação...: GAS-2007 - Gerador Automático de Sistemas
'* Data......: 05/09/2024 18:10:15
'* * * * * * *

Option Explicit                                     'requer variáveis explicitamente declaradas
DefInt A-Z                                          'inteiras, por default

'declara variáveis públicas - todos os forms possuem essas variáveis
Public vgSituacao As Integer                      'situação de cada form child
Public vgCaracteristica As Integer                'característica dos forms
Public vgTipo As Integer                          'tipo de cada form child
Public vgFormID As Long                           'identificacao do form
Public vgEmBrowse As Integer                      'flag: se true, dados mostrados em browse
Public vgPriVez As Integer
Public vgTb As GRecordSet                         'referência a recordset dos data controls
Public vgTooltips As New cTooltips
Dim vgTile As New cFormBG

'apaga colunas selecionadas na grade
Public Sub ApagaColunas()
   If ActiveForm.grdBrowse.ColumnSelected.Count < 1 Then           'se não tem coluna selecionada,
      Beep                                        'avisa,
      MsgBox LoadGasString(1535), vbExclamation, vgAtencao$ 'mostra mensagem e retorna
   Else                                           'senão,
      With ActiveForm.grdBrowse                   'com a grade...
         .DeleteCols                              'invoca método para apagar colunas selecionadas
      End With
   End If
End Sub

'mostra fórmulas na janela
Private Sub MostraFormulas()
   On Error Resume Next                           'previne erros...
   Label(1).Caption = Ucase(vgPWGrupo)
   If Err Then Err = 0: Label(1).Caption = ""
   Label(2).Caption = UCase(vgPWUsuario)
   If Err Then Err = 0: Label(2).Caption = ""
   Label(4).Caption = UCase(UsuarioPC)
   If Err Then Err = 0: Label(4).Caption = ""
   If Err Then Err.Clear                          'se houve erro, limpa...
End Sub

' procedure para reparar o banco de dados
Public Sub ReparaBD()
   Dim x As String
   On Error GoTo DeuErro
   Beep                                           'avisa que pode demorar...
   If MsgBox(LoadGasString(36), vbExclamation + vbYesNo + _
      vbDefaultButton2, LoadGasString(35)) = vbYes Then
      MousePointer = vbHourglass                  'ponteiro do mouse = ampulheta

      If Len(x$) > 0 Then
         Beep
         MsgBox x$, vbCritical, vgAtencao$        'mostra mensagem de erro e
         FinalizaAplicacao
         End
      End If

      FechaBancoDeDados                           'fecha tudo e abre novamente

      If Not AbreBancoDeDados Then                'tenta abrir o banco de dados...
         Beep                                     'se não foi possível,
         MsgBox LoadGasString(1130), vbCritical, vgAtencao$ 'mostra mensagem e
         End                                                'sai da aplicação...
      End If

      MousePointer = vbDefault                              'deu tudo certo, acerta ponteiro do mouse
      Beep
      MsgBox LoadGasString(37), vbInformation, LoadGasString(38) 'informa reparado com sucesso!
   End If
   Exit Sub

DeuErro:                                          'erros da reparação caem aqui...
   If Err = 3356 Or Err = 3196 Then               'DB está bloqueado por outros usuários,
      x$ = LoadGasString(130)                     'monta mensagem
   Else                                           'senão,
      x$ = LoadGasString(120) & " (" & Err & ")"  'outro tipo de erro - junta seu número
   End If
   Beep                                           'apita e
   MsgBox x$, vbExclamation, vgAtencao$           'mostra mensagem
   If Not AbreBancoDeDados Then                   'tenta abrir o banco de dados...
      Beep                                        'se não foi possível,
      MsgBox LoadGasString(1130), vbCritical, vgAtencao$ 'mostra mensagem e
      End                                                'sai da aplicação...
   End If
   MousePointer = vbDefault                              'BD foi aberto, acerta o mouse
End Sub

'esta rotina é chamada sempre que o usuário clicar no botão de imprimir ou na
'opção de menu correspondente - esta rotina atua diferentemente para cada tipo
'de form que esteja ativo no momento
Public Sub ImprimeForm()
   Dim vgSz As Integer
   Dim x As Integer
   Dim vgTit As String
   Dim i As Integer
   Dim vgNTbs As String, vgNt As String
   Dim vgBanco As GDataBase, vgTabela As GTable, vgInd As GIndex, vgCp As GColumn

   Select Case ActiveForm.vgTipo                            'verifica o tipo de form
      Case TP_TABELA, TP_PARAMETROS                         'SE FORM DE DADOS...
         If ActiveForm.vgEmBrowse Then                      'se na grade - vamos imprimir colunas
            Set ActiveForm.vgFrmImpCons.vgFrmOrigem = ActiveForm 'cria instância do form ativo
            Load ActiveForm.vgFrmImpCons
            ActiveForm.vgFrmImpCons.Show
            GoTo FimDaSub
         End If
         Beep                                     've se quer imprimir o form (hard copy)
         If MsgBox(LoadGasString(85) + UCase$(ActiveForm.Caption) + "?", _
          vbQuestion + vbYesNo, vgAtencao$) = vbYes Then
            GeraLogAcao LoadGasString(290) + " " + ActiveForm.Caption
            On Error Resume Next
            For i = 0 To ActiveForm.Grid.Count - 1 'vamos correr todos os grids
               ActiveForm.Grid(i).FreezeListView False 'congelar a exibição do grid
            Next
            On Error GoTo ErroImp                      'prepara para pegar um erro
            ActiveForm.PrintForm                       'invoca o método printform do VB
            On Error Resume Next
            For i = 0 To ActiveForm.Grid.Count - 1     'vamos correr todos os grids
	 
               ActiveForm.Grid(i).RestoreListView True 'descongelar a exibição do grid
            Next
         End If
         GoTo FimDaSub                                 'cai fora...

ErroImp:                                               'erro ao imprimir
         Beep                                          'beepa e
         MsgBox LoadGasString(90), vbExclamation, vgAtencao$ 'dá mensagem
         Resume Next                                         'continua a partir do erro...

      Case TP_GRAFICO                                        'SE FORM DE GRÁFICO...
         Beep                                                've se quer imprimir o gráfico
         If MsgBox(LoadGasString(85) + UCase$(ActiveForm.Caption) + "?", _
          vbQuestion + vbYesNo, vgAtencao$) = vbYes Then
            GeraLogAcao LoadGasString(291) + " " + ActiveForm.Caption
            ActiveForm.gra1.PrintStyle = 1                   'impressão colorida...
            ActiveForm.gra1.DrawMode = 5                     'imprime o grafico
         End If

      Case TP_BROWSE                                         'SE FORM DE CONSULTAS...
         Set ActiveForm.vgFrmImpCons.vgFrmOrigem = ActiveForm 'cria instância do form ativo
         Load ActiveForm.vgFrmImpCons
         ActiveForm.vgFrmImpCons.Show

      Case TP_INFODB                                          'SE FORM DE INFORMAÇÔES BD
         GeraLogAcao LoadGasString(290) + " " + ActiveForm.Caption
         Screen.MousePointer = vbHourglass                    'mouse = ampulheta
         vgSz = Printer.FontSize                              'salva tamanho da fonte da impressora
         For Each vgBanco In vgDb                             'corre todos os bancos da aplicação
            Printer.FontBold = True                           'liga negrito
            GoSub TestaSalto                                  'testa fim de página
            GoSub Cabecalho                                   'imprime o cabeçalho,
            GoSub TestaSalto                                  'testa fim de página
            For Each vgTabela In vgBanco.Tables               'corre todas as tabelas do banco atual
               Printer.FontBold = True                        'liga negrito
               GoSub TestaSalto                               'testa fim de página
               Printer.Print LoadGasString(95) + vgTabela.Name 'imprime Tabela: XXXXXXXX
               Printer.FontBold = False                        'desliga negrito
               GoSub TestaSalto                                'testa fim de página
               Printer.Print                                   'uma linha em branco
               GoSub TestaSalto                                'testa fim de página
               Printer.Print LoadGasString(100);               'imprime tít dos índices
               For Each vgInd In vgTabela.Indexes              'corre todos os índices da tabela atual
                  GoSub TestaSalto                             'testa fim de página
                  Printer.Print Tab(12); vgInd.Name            'imprime nome do índice
               Next                                            'vai para o próximo índice da tabela atual
               GoSub TestaSalto                                'testa fim de página
               Printer.Print                                   'uma linha em branco
               GoSub TestaSalto                                'testa fim de página
               Printer.Print Tab(12); LoadGasString(105);      'imprime tít dos campos
               For Each vgCp In vgTabela.Columns               'corre todos os campos da tabela atual
                  GoSub TestaSalto                             'testa fim de página
                  Printer.Print Tab(20); vgCp.Name             'imprime nome do campo
               Next                                            'vai para o próximo campo da tabela atual
               GoSub TestaSalto                                'testa fim de página
               Printer.Print                                   'salta linha
               GoSub TestaSalto                                'testa fim de página
               Printer.Line (0, Printer.CurrentY)-(Printer.Width, Printer.CurrentY) 'traça uma linha
               GoSub TestaSalto                   'testa fim de página
               Printer.Print                      'salta linha
            Next                                  'vai para próxima tabela do banco atual
         Next                                     'vai para próximo banco da aplicação
         Printer.FontSize = vgSz                  'restaura tamanho da fonte
         Printer.EndDoc                           'termina o documento
         Screen.MousePointer = vbDefault          'restaura ponteiro do mouse
         GoTo FimDaSub                            'cai fora...

TestaSalto:                                       'trata final de página
         If Printer.CurrentY > (Printer.Height - (Printer.Height * 0.1)) Then 'se 10% faltando
            Printer.NewPage                       'pula página
            GoSub Cabecalho                       'e imprime cabeçalho
         End If
         Return                                   'volta pra quem chamou...

Cabecalho:                                        'imprime cabeçalho
         With Printer                             'com a impressora,
            .FontSize = 16                        'ajusta tamanho e
            .FontBold = True                      'corpo da fonte
            vgTit$ = LoadGasString(110)           'título do relatório
            x = .TextWidth(vgTit$)                'calcula quatos pontos gasta o título
            .CurrentX = (.Width - x) / 2          'e centraliza para imprimir
            Printer.Print vgTit$                  'imprime título
            .FontSize = 14                        'diminui a fonte
            x = .TextWidth(vgBanco.Name)          'calcula quatos pontos gasta o título
            .CurrentX = (.Width - x) / 2          'e centraliza para imprimir
            Printer.Print vgBanco.Name            'imprime nome do banco atual
            Printer.Print                         'salta uma linha
            .FontBold = False                     'desliga negrito
            Printer.Line (0, .CurrentY)-(.Width, .CurrentY + 60), , BF
            Printer.Print                         'salta linha
            .FontSize = 9.5                       'ajusta tamanho da fonte
         End With
         Return                                   'e retorna para quem chamou...

   End Select
   
FimDaSub:

CancelouConfig:                                   'se caiu aqui, cancelou configuração impressora

End Sub

'esta rotina é chamada sempre que o usuário solicitar filtragem de registros,
'atuando diferentemente para cada tipo de form que estiver ativo no momento
Public Sub FiltraRegistros(Optional AbreNaOrdem As Boolean, Optional vgOq As Integer)
   On Error GoTo DeuErro
   vgBotoesOK = False                                       'flag - botões não preparados
   vgFiltroAtual$ = ActiveForm.vgUltimoFiltro               'pega o último filtro feito
   vgFiltroAtualComTit$ = ActiveForm.vgUltimoFiltroComTit
   vgOrdemAtual$ = ActiveForm.vgUltimaOrdem                 'pega a última ordem feito
   vgOrdemAtualComTit$ = ActiveForm.vgUltimaOrdemComTit
   If vgoq = 0 Then
      Load frmFiltra                                        'carrega form de filtragem
      If ActiveForm.vgTipo = TP_TABELA Then
         frmFiltra.IniciaTabDoFiltro ActiveForm, ActiveForm.vgTb 'inicializa a tabela do filtro
      ElseIf ActiveForm.vgTipo = TP_BROWSE Then
         frmFiltra.IniciaTabDoFiltro ActiveForm, ActiveForm.grdBrowse.Recordset 'inicializa a tabela do filtro
      End If
   End If
   If AbreNaOrdem Then
      frmFiltra.tabFiltro.Tab = 1
   End If
   If vgOq = 0 Then frmFiltra.Show vbModal                                      'apresenta o form de filtragem para o usuário
   If ActiveForm.vgUltimoFiltro <> vgFiltroAtual$ Or _
      ActiveForm.vgUltimaOrdem <> vgOrdemAtual$ Or vgOq = 1 Then                'se o novo filtro/ordem feito pelo usuário for diferente
      Screen.MousePointer = vbHourglass                                         'mouse = ampulheta
      With ActiveForm                             'com o form ativo,
         .vgUltimoFiltro = vgFiltroAtual$         'atualiza a variável vgUltimoFiltro 
         .vgUltimoFiltroComTit = vgFiltroAtualComTit$ 'e vgUltimoFiltroComTit
         .vgUltimaOrdem = vgOrdemAtual$                        
         .vgUltimaOrdemComTit = vgOrdemAtualComTit$ 
         InicializaFiltro ActiveForm
         If .vgTipo = TP_TABELA And Not .vgEmBrowse Then 'é form de dados e não está em modo grade?
            .Reposition
         ElseIf .vgTipo = TP_TABELA And .vgEmBrowse Then 'é janeda de dados e está em modo grade?
            .grdBrowse.OpenRecordSet ActiveForm.vgSQL, CURSOR_TABLE, False, ActiveForm.vgUltimoFiltro, ActiveForm.vgUltimaOrdem   
         ElseIf .vgTipo = TP_BROWSE Then                 'é form de consulta?                            
            .grdBrowse.OpenRecordSet ActiveForm.vgSQL, CURSOR_TABLE, False, ActiveForm.vgFiltroAtual, ActiveForm.vgOrdemAtual
         End If
      End With
      Screen.MousePointer = vbDefault                    'restaura o ponteiro do mouse
   End If
   PrepBotoes ActiveForm, ACAO_NAVEGANDO                 'reajusta funcionalidade e aparencia dos botoes
   If ActiveForm.vgTipo = TP_TABELA Then
      mdiNFE.vgPriVez = True
      mdiNFE.vgPriVez = False
   End If 
   
   vgBotoesOK = True                                     'flag - os botões estão OK...
   Exit Sub

DeuErro:
   Beep
   CErr.NumErro = Err
   CErr.Mensagem = LoadGasString(76)
   CErr.Show
   Screen.MousePointer = vbDefault                       'restaura o ponteiro do mouse
End Sub

'esta rotina é chamada para excluir um registro de uma tabela
'qualquer de um form de dados
Public Function ExcluiRegistro() As Boolean
   Dim x As String, i As Integer, vgRegAgora As Variant, vgNVez As Integer   'dimensiona
   If Not ActiveForm.vgTemExclusao Then Exit Function                        'se não pode excluir, cai fora...
      If Not ActiveForm.ActiveControl Is Nothing Then
         If TypeOf ActiveForm.ActiveControl Is GListV Then
            If UCase$(ActiveForm.ActiveControl.Name) = "GRID" Then
               If ActiveForm.ActiveControl.SelectedRowsCount > 0 Then        'se tem linha selecionada
                  Beep
                  ActiveForm.SetFocus                                        'vamos excluir no grid
                  SendK vbKeyDelete
                  Exit Function
               End If
            End If
         End If
      End If
   vgNVez = 0                                     'contador de tentativas
   Beep                                           'fomm, fomm! VAMOS EXCLUIR
   If ActiveForm.vgCaracteristica = F_DADOS And ActiveForm.vgEmBrowse Then
      i = vbYes
   Else
      i = vbYesNo + vbQuestion + vbDefaultButton2 'pede confirmação...
      i = MsgBox(LoadGasString(50), i, vgAtencao$) 'mostrando esta mensagem
   End If
   If i = vbYes Then                               'se confirmou,
      On Error GoTo ErroDele                       'prepara para pegar o erro
      vgBotoesOK = False                           'desliga troca de icones nos botoes
      Screen.MousePointer = vbHourglass            'mouse = ampulheta
      ActiveForm.vgSituacao = ACAO_EXCLUINDO       'ajusta situação atual do form
      vgDb.BeginTrans
      With ActiveForm.vgTb                         'com a tabela do form ativo,
         vgRegAgora = ActiveForm.vgTb.Bookmark     'salva o registro atual
         GeraLog ActiveForm, ACAO_EXCLUINDO, -1, True
         .Delete                                   'agora sim, apaga o registro corrente
      End With
      GeraLog ActiveForm, ACAO_EXCLUINDO
      vgDb.CommitTrans
      ExcluiRegistro = True                        'ok, exclusão executada com sucesso
      On Error GoTo FimDaSub
      x$ = ActiveForm.Executar(APOS_EDICAO)        'executa ação após exclusão do registro
      If (ActiveForm.vgCaracteristica = F_DADOS) And Not ActiveForm.vgEmBrowse Then
         ActiveForm.vgSituacao = ACAO_NAVEGANDO    'ajusta situação atual do form
         MoveRegistro ActiveForm, REG_FORCAVOLTA   'move para o registro anterior...
      End If
   End If
   GoTo FimDaSub                                   'pula fora...

ErroDele:                                          'se caiu aqui, vamos ver os erros possíveis
   CErr.NumErro = Err
   If CErr.Bloqueado Then                          'se o reg esta bloqueado por outro usuario
      vgNVez = vgNVez + 1                          'vamos tentar
      If vgNVez <= 10 Then                         'por 10 vezes
         Delay 3                                   'a cada 3 segundo
         Resume                                    'a mesma operação
      End If
   End If

   'salva o erro atual
   x$ = Err.Source + "|" + CStr(Err.Number) + "|" + Err.Description
   If Err Then Resume ResumeErro
   
ResumeErro:
   On Error Resume Next
   ActiveForm.vgTb.CancelUpdate                    'cancela alteracao no recordset                 
   Err.Clear
   vgDb.RollBackTrans
   CErr.Mensagem = LoadGasString(123)
   'restaura o erro original
   Err.Source = Parse$(x$, "|")                    'onde o erro foi causado
   Err.Number = Val(Parse$(x$, "|" ))              'o número do erro e a sua descrição
   Err.Description = Parse$(x$, "|")
   If (ActiveForm.vgCaracteristica = F_DADOS) And Not ActiveForm.vgEmBrowse Then
      If CErr.NumErro = 3167 Or CErr.NumErro = -2147217885 Then 'registro foi apagado por outro usuário
         MoveRegistro ActiveForm, REG_FORCAVOLTA                'precisamos retroceder um registro
      Else
         ActiveForm.vgTb.Bookmark = vgRegAgora                  'e volta para o mesmo registro
      End If
   Else
      ActiveForm.vgTb.BookMark = vgRegAgora                     'e volta para o mesmo registro
   End If
   CErr.Show                                      'mostra o erro
   On Error Resume Next

FimDaSub:                                         'finaliza esta rotina...
   If Not ActiveForm.vgEmBrowse Then
      RemontaForm                                 'atualiza os forms de dados
      ActiveForm.SetFocus                         'volta o foco para o form atual
      PrepBotoes ActiveForm, ACAO_NAVEGANDO       'ajusta funcionalidade dos botoes
   End If
   Screen.MousePointer = vbDefault                'restaura ponteiro do mouse
End Function

'inicia inclusão de registro
Public Sub IncluiRegistro()
   On Error GoTo DeuErro
   vgBotoesOK = False                             'botoeira em estado de edição
   PrepBotoes ActiveForm, ACAO_INCLUINDO          'troca icones dos botoes
   ActiveForm.Executar INICIALIZACOES             'coloca valor inicial para os campos
   ActiveForm.Reposition                          'mostra os campos
   FocoNoPriControle ActiveForm                   'coloca foco no 1o. campo do form
   Exit Sub
DeuErro:
   If mdiNFE.ActiveForm Is Nothing Then
      PrepBotoes Me, ACAO_NAVEGANDO               'ajusta barra de farramenta
   End If
End Sub

' rotina para manipular os cancelamentos de alterações nas tabelas
Public Sub CancelaAlteracoes()
   Dim vgIsGrid As Boolean
   On Error GoTo DeuErro
   If ActiveForm.vgSituacao < 0 Or ActiveForm.vgSituacao = ACAO_NAVEGANDO Then  'editando o grid não faz nada
      ActiveForm.Painel(0).Enabled = False
      ActiveForm.Painel(0).Enabled = True
      If ActiveForm.vgSituacao < 0 Then                                         'se estava em edição ou inclusão no GRID
         ActiveForm.vgSituacao = -99                                            'seta vgSituacao para forçar o cancelamento
      End If
      On Error Resume Next                        'pode ser que este form nao tenha esta procedure
      ActiveForm.Grid_LostFocus ActiveForm.ActiveControl.Index 'dispara o LostFocus do grid para cancelar a inclusão/alteração
      ActiveForm.ActiveControl.CancelEdit                      'cancela a inclusão/alteração no grid
      If Err Then Err.Clear                                    'ignora possíveis erros (se não tem grid)
      Exit Sub                                                 'e cai fora
   ElseIf ActiveForm.vgTipo = TP_BROWSE Then
      If ActiveForm.grdBrowse.Status <> ACAO_NAVEGANDO Then
         ActiveForm.grdBrowse.CancelEdit
      End If
      Exit Sub
   End If
   On Error GoTo DeuErro                                       'prepara para captar erros
   vgIsGrid = False
   If (ActiveForm.vgCaracteristica = F_DADOS) Then
      vgIsGrid = ActiveForm.vgEmBrowse
   End If
   If vgIsGrid Then
      ActiveForm.grdBrowse.CancelEdit
   Else
      ActiveForm.vgSituacao = ACAO_NAVEGANDO                   'ajusta situação do form
      PrepBotoes ActiveForm, ACAO_NAVEGANDO                    'acerta icones dos botoes
   End If
   ActiveForm.Reposition                                       'atualiza controles com dados do registro
   ActiveForm.SetFocus                                         'volta o foco para o form
   Exit Sub                                       'e sai...

DeuErro:                                          'se caiu aqui, deu erro
   If mdiNFE.ActiveForm Is Nothing Then
      PrepBotoes Me, ACAO_NAVEGANDO               'ajusta barra de farramenta
   Else
      MoveRegistro ActiveForm, REG_FORCAVOLTA     'vamos somente voltar um registro e
   End If
   Resume Next                                    'continuar
End Sub

'rotina para gravação de dados - invocada quando o botão de gravar é clicado ou
'quando a opção de menu correspondente é selecionada
Public Sub SalvaDados(Optional ByRef vgColumn As Integer)
   Dim vgRegAgora As Variant, x As String, vgIniciouTrans As Integer, vgEtapa As Integer, vgNTent As Integer, vgResume As Boolean, vgAdded As Boolean  'dimensiona
   Dim vgNVez As Integer                          'contador de tentativas
   Dim dlgArquivo As cCommonDialog
   vgResume = True                                'se pode fazer resume no tratamento de erros
   On Error GoTo DeuErro
   If ActiveForm.vgTipo <> TP_GRAFICO And (ActiveForm.vgSituacao < 0 Or ActiveForm.vgSituacao = ACAO_NAVEGANDO) Then 'editando o grid não faz nada
      If ActiveForm.vgSituacao < 0 Then
         ActiveForm.SaveGrids
      End If
      Exit Sub
   ElseIf ActiveForm.vgTipo = TP_BROWSE Then
      If ActiveForm.grdBrowse.Status <> ACAO_NAVEGANDO Then
         ActiveForm.grdBrowse.SaveEdit
      End If
      Exit Sub
   End If
   Screen.MousePointer = vbHourglass              'mouse = ampulheta
   vgNVez = 0                                     'inicia contador de tentativas
   vgIniciouTrans = False                         'flag - iniciou transação
   vgEtapa = 0                                    'etapa do processo de gravação
   vgNTent = 0                                    'número de vezes que tentou executar gravação e ocorreu o erro -2147217864
   On Error GoTo SaiDaSUb                         'prepara para pegar erros
   Select Case ActiveForm.vgTipo                  'verifica o tipo de form
      Case TP_GRAFICO                             'SE FOR TIPO GRÁFICO...
         Set dlgArquivo = New cCommonDialog
         With dlgArquivo                          'vamos apresentar diálogo para salvar
            .CancelError = True                   'vamos testar se o usuário cancelou
            .InitDir = vgDirEXE$                  'inicializa o diretório apresentado
            .DialogTitle = LoadGasString(60)      'e o título do diálogo...
            .Filter = "Bitmaps (*.bmp)|*.bmp|Metafiles (*.wmf)|*.wmf"
            .FilterIndex = 0                      'vamos oferecer *.bmp primeiro
            .Flags = OFN_CREATEPROMPT             'se não existir, poderemos criar?
            .ShowSave                             'mostra o diálogo de gravação
            ActiveForm.gra1.ImageFile = .filename 'ajusta o nome do arquivo
            If InStr(UCase$(.filename), ".WMF") Then 'se tem extensão .WMF
               ActiveForm.gra1.DrawMode = 6          'grava o wmf
            Else                                     'senão
               ActiveForm.gra1.DrawMode = 3          'cria bmp em memoria
               ActiveForm.gra1.DrawMode = 6          'e grava em disco...
            End If
         End With
         Set dlgArquivo = Nothing
      Case Else                                      'SE FORM DIFERENTE DE GRÁFICO...
         vgBotoesOK = False                          'reseta flag
         vgRegAgora = ""
         If ActiveForm.vgTb.RecordCount > 0 Then
            If ActiveForm.vgTb.EOF = False And ActiveForm.vgTb.BOF = False And ActiveForm.vgTb.NoMatch = False Then
               vgRegAgora = ActiveForm.vgTb.Bookmark 'salva o registro atual
            End If
         End If
         x$ = ActiveForm.Executar(VALIDACOES, vgColumn) 'faz validação dos campos
         If Len(x$) > 0 Then                            'EPA!... tem campo errado
            If InStr(x$, "|") > 0 Then
               Err.Source = Parse$(x$, "|")
               Err.Number = Val(Parse$(x$, "|"))        'deu erro
               Err.Description = Parse$(x$, "|")
               CErr.NumErro = Err.Number
               CErr.Show
            Else
               Beep                                     'manda aviso sonoro
               MsgBox x$, vbCritical, vgAtencao$        'mostra mensagem do erro
            End If
            ActiveForm.SetFocus                         'volta o foco para o form
            Screen.MousePointer = vbDefault             'reseta o pointer do mouse
            Exit Sub                                    'e sai para continuar a edição ou inclusão
         End If                                         'OK. os campos estão certos
         On Error GoTo ErroAoGravar                     'vamos cercar erros...
         vgDb.BeginTrans
         vgIniciouTrans = True                          'iniciou transação = true
      VoltaGravacao:
         If ActiveForm.vgSituacao = ACAO_EDITANDO Then  'se estava editando registros
            x$ = ActiveForm.Executar(TESTA_VAL_RS)      'testa se o recordset foi alterado por outro usuário
            If Len(x$) > 0 Then                         'deu erro?
               vgNVez = 100                             'ajusta contador de tentativas
               Err.Source = Parse$(x$, "|")             'força erro que deu...
               Err.Number = Val(Parse$(x$, "|"))
               Err.Description = Parse$(x$, "|")
               vgResume = False
               GoTo ErroAoGravar
            End If
            ActiveForm.vgTb.Edit                        'invoca a edição da tabela
            If vgEtapa < 1 Then
            End If
         Else
            If vgEtapa < 1 Then
               ActiveForm.vgTb.AddNew                   'cria registro em branco
               vgEtapa = vgEtapa + 1  
            End If
         End If
         GeraLog ActiveForm, ActiveForm.vgSituacao, -1, True
         If vgEtapa < 2 Then
            x$ = ActiveForm.Executar(POE_NO_ARQUIVO)    'atualiza registro com os controles
            If Len(x$) > 0 Then                         'deu erro?
               vgNVez = 100                             'ajusta contador de tentativas
               Err.Source = Parse$(x$, "|")             'força erro que deu...
               Err.Number = Val(Parse$(x$, "|"))        'força erro que deu...
               Err.Description = Parse$(x$, "|")
               vgResume = False
               GoTo ErroAoGravar
            End If
            ActiveForm.vgTb.Update                      'deu certo - atualiza
            vgRegAgora = ActiveForm.vgTb.BookMark       'atualiza para o novo registro
            vgEtapa = vgEtapa + 1
         End If
         GeraLog ActiveForm, ActiveForm.vgSituacao
         vgDb.CommitTrans
         vgIniciouTrans = False                         'reseta a flag
         If ActiveForm.vgTipo = TP_PARAMETROS Then
            Empresa.Requery
            Parametros_da_nfe.Requery
         End If
         On Error GoTo DeuErro                          'vamos cercar erros...
         RemontaForm                                    'atualiza forms de dados
         ActiveForm.vgSituacao = ACAO_NAVEGANDO         'situacao normal, força método reposition
         If ActiveForm.vgTemBrowse Then
            If ActiveForm.vgEmBrowse Then
               ActiveForm.grdBrowse.CancelEdit
            End If
         End If
         ActiveForm.Reposition True, Not vgAdded        'atualiza controles com dados do registro
         AjustaRolagem ActiveForm
         If Not ActiveForm.vgEmBrowse Then
            PrepBotoes ActiveForm, ACAO_NAVEGANDO
         Else
            ActiveForm.grdBrowse.SetFocus
         End If
         If botInclui.Enabled And panTools.Visible Then 'se toolbar visível e se botão de inclusão habilitado
            If botInclui.ButtonStyle = 0 Then
               botInclui.SetFocus                       'e coloca foco nele
            Else
               ActiveForm.SetFocus
            End If
         End If
   End Select
   GoTo SaiDaSub                                        'fora daqui

DeuErro:                                                'deu um erro
   Resume Next                                          'continuar...

ErroAoGravar:
   CErr.NumErro = Err
   If CErr.Bloqueado Then                               'se o reg esta bloqueado por outro usuario
      vgNVez = vgNVez + 1                               'vamos tentar
      If vgNVez <= 10 Then                              'por 10 vezes
         Delay 3                                        'a cada 3 segundo
         Resume                                         'a mesma operação
      End If
   End If
   If vgIniciouTrans Then                               'se iniciou transação
      If Err = -2147217864 And vgNTent < 10 Then
         Err.Clear
         If vgEtapa < 3 Then
            ActiveForm.vgTb.CancelUpdate                'cancela alteracao no recordset                 'cancela a operacao do recordset
         End If
         ActiveForm.vgTb.CloseRecordset
         InicializaFiltro ActiveForm
         On Error Resume Next
         ActiveForm.vgTb.BookMark = vgRegAgora
         Err.Clear
         On Error GoTo ErroAoGravar
         vgNTent = vgNTent + 1
         GoTo VoltaGravacao
      ElseIf Err <> 20 And Err <> 3600 And Err <> 3601 Then
         x$= Err.Source & "|" & Err.Number & "|" & Err.Description
         If vgResume Then
            Resume ResetaErro
         End If
      End If

ResetaErro:
      On Error Resume Next
      If vgEtapa < 3 Then
         ActiveForm.vgTb.CancelUpdate                   'cancela alteracao no recordset                 'cancela a operacao do recordset
      End If
      vgDb.RollBackTrans
      If Len(CStr(vgRegAgora)) > 0 Then
         ActiveForm.vgTb.Bookmark = vgRegAgora          'volta para o registro
      ElseIf ActiveForm.vgTb.RecordCount > 0 Then       'forca inicio de arquivo
         ActiveForm.vgTb.MoveFirst
         If ActiveForm.vgTb.BOF = False Then            'não sabemos o porquê, mas 
            ActiveForm.vgTb.MovePrevious                'algumas vezes já está posicionado em, BOF
         End If
      End If
      Err.Source = Parse$(x$, "|")
      Err.Number = Val(Parse$(x$, "|"))
      Err.Description = Parse$(x$, "|")
   End If
   If Not ActiveForm.vgEmBrowse Then
      FocoNoPriControle ActiveForm
   End If
   CErr.Show
   If CErr.Fatal Then CancelaAlteracoes                 'cancela inclusao/altercao
   ActiveForm.SetFocus                                  'volta o foco para o form

SaiDaSub:                                               'saída comum da sub...
   If mdiNFE.ActiveForm Is Nothing Then
      PrepBotoes Me, ACAO_NAVEGANDO                     'ajusta barra de farramenta
   End If
   Screen.MousePointer = vbDefault                      'ponteiro do mouse = default
End Sub

'executa a remontagem de um form
Public Sub RemontaForm()
   Dim F As Form, vgEstadoBotoes As Integer
   
   vgEstadoBotoes = vgBotoesOK                    'salva o estado dos botões
   For Each F In Forms                            'e atualiza os registros
      If F.vgCaracteristica <> F_COMUM Then       'de todos os forms abertos
         vgBotoesOK = False                       'reseta flag
         On Error Resume Next                     'pode ocorrer algum erro...
         If F.vgSituacao = ACAO_NAVEGANDO And F.vgCaracteristica <> F_GRAFICO Then
            If F.vgTipo = TP_BROWSE Then
               F.grdBrowse.Refresh
            Else
               With F.vgTb                        'tabela principal do form
   

   VerificaReg:
                  If .RecordCount > 0 Then
                     If .EOF OR .BOF Then         'tem reg e nao esta visivel
                        .MoveFirst
                     End If
                     .Bookmark = .Bookmark
                     If F.vgCaracteristica = F_DADOS Then
                        F.Reposition
                     End If
                     If Err = 3167 Then           'se o registro já esta deletado
                        .MovePrevious             'move para o registro anterior
                        If .BOF Or Err > 0 Then   'se esta no inicio do arquivo ou deu erro
                           .MoveFirst             'vai para o primeiro do arquivo
                        End If
                        Err.Clear
                        GoTo VerificaReg
                     End If
                  Else
                     F.vgTb.Requery
                     F.Reposition
                  End If
               End With
            End If
         End If
      End If                                      'de inclusao/alteracao
   Next
   vgBotoesOK = vgEstadoBotoes                    'restaura a flag
End Sub

Private Sub botAnterior_Click()
   MoveRegistro ActiveForm, REG_ANTERIOR          'retrocede um registro por estímulo do usuário...
End Sub

Private Sub botBrowse_Click()
   If vgPriVez Then Exit Sub
   ActiveForm.vgEmBrowse = (Not ActiveForm.vgEmBrowse)  'inverte a flag e
   TrocaBrowse ActiveForm                               'troca forma de apresentar os dados
   PrepBotoes ActiveForm, ACAO_NAVEGANDO                'arruma botoes do mdi
   ActiveForm.SetFocus
End Sub

Private Sub botCancela_Click()
   CancelaAlteracoes                              'manda cancelar as alterações...
End Sub

Private Sub botCancela_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
   If ActiveForm.vgSituacao < 0 Then
      ActiveForm.vgSituacao = -99
   End If
End Sub

Private Sub Menu_Repeticao_Click()
   LigaDesligaRepeticao                           'repeticao de campos na inclusao 
End Sub

'lega/desliga a repeticao de campos na inclusao 
Public Sub LigaDesligaRepeticao()           
   On Error Resume Next
   ActiveForm.LigaDesligaRepeticao
End Sub

Private Sub Menu_Ortog_Click()
   CorrigeOrtografia                              'corrigo ortografia
End Sub

Public Sub CorrigeOrtografia()
   Dim vgDic As Object, vgTexto As String

   On Error Resume Next
   Set vgDic = CreateObject("Word.Basic")         'tenta cria objeto word
   If Err Then                                    'se não consegui
      Beep                                        'avisa e
      MsgBox LoadGasString(155), vbExclamation, vgAtencao$
      Exit Sub                                    'sai
   End If
   On Error GoTo DeuErro                          'espera um erro
   mdiNFE.Enabled = False
   With vgDic
      .FileNew
      .Insert ActiveForm.ActiveControl.Text
      .ToolsSpelling
      .EditSelectAll
      vgTexto$ = .Selection()
      .FileExit 2
   End With
   Set vgDic = Nothing                            'retira o objeto da memória
   mdiNFE.Enabled = True

   If Right$(vgTexto$, 1) = vbCr Then             'se texto termida com Enter
      vgTexto$ = Left$(vgTexto$, Len(vgTexto$) - 1) 'vamos despresar
   End If
   Beep                                             'aviso que passou por aqui
   ActiveForm.ActiveControl.Text =  Substitui$(vgTexto$, vbCr, vbCrLf, SO_UM)
   Exit Sub

DeuErro:
   mdiNFE.Enabled = True
   Set vgDic = Nothing                              'retira o objeto da memória
   Err.Clear                                        'limpa o erro que deu
End Sub

Private Sub botExclui_Click()
   If (ActiveForm.vgCaracteristica = F_DADOS) And ActiveForm.vgEmBrowse Then
      If ActiveForm.grdBrowse.SelectedRowsCount > 0 Then        'se tem registro selecionado
         ActiveForm.grdBrowse.DeleteRecords
      Else
         Beep
         MsgBox LoadGasString(1536), vbExclamation, vgAtencao$  'mostra mensagem e retorna
      End If
   Else
      ExcluiRegistro                                            'manda excluir o registro
   End If
End Sub

Private Sub botSalva_Click()
   SalvaDados                                     'manda gravar os dados
End Sub

Private Sub botImprime_Click()
   ImprimeForm                                    'imprime o form, com tratamento
End Sub

Private Sub botInclui_Click()
   IncluiRegistro                                 'trata inclusão do registro
End Sub

Private Sub botPrimeiro_Click()
   MoveRegistro ActiveForm, REG_PRIMEIRO          'movimenta para o primeiro registro da tabela
End Sub

Private Sub botSeguinte_Click()
   MoveRegistro ActiveForm, REG_SEGUINTE          'invoca movimentação para o registro seguinte
End Sub

Private Sub botUltimo_Click()
   MoveRegistro ActiveForm, REG_ULTIMO            'movimenta para o último registro
End Sub

'liga e desliga a apresentação de ajuda ativa para a aplicação
Private Sub Menu_Ajuda_Click()
   Dim i As Integer
   vgAjudaAtiva = Not vgAjudaAtiva                'inverte a flag
   Menu_Ajuda.Checked = vgAjudaAtiva              'marca/desmarca opção no menu
   On Error Resume Next
   For i = 0 To Forms.Count - 1                   'corre todos os forms abertos
      Forms(i).vgTooltips.Enabled = vgAjudaAtiva  'trocando apresentação da ajuda
   Next 

   'grava status no arquivo .INI
   GravaNoIni vgNomeEstacao$ + "Geral", "Ajuda ativa", Str$(vgAjudaAtiva), vgNomeINI$
End Sub

Private Sub Menu_Cascata_Click()
   mdiNFE.Arrange vbCascade                       'janelas em cascata
End Sub

Private Sub Menu_Horiz_Click()
   mdiNFE.Arrange vbTileHorizontal                'lado a lado horizontal
End Sub

Private Sub Menu_Vert_Click()
   mdiNFE.Arrange vbTileVertical                  'lado a lado vertical
End Sub

Private Sub Menu_Organiza_Click()
   mdiNFE.Arrange vbArrangeIcons                  'organiza icones
End Sub

Private Sub Menu_Anterior_Click()
   MoveRegistro ActiveForm, REG_ANTERIOR          'movimenta para o registro anterior
End Sub

'quer apagar colunas
Private Sub Menu_ApagaCol_Click()
   ApagaColunas                                   'apaga as colunas
End Sub

'liga/desliga a apresentação da barra de ferramentas
Private Sub Menu_Barra_Click()
   vgBarraFerr = Not vgBarraFerr                  'inverte a flag
   PoeTiraBarra

   'grava status no arquivo .INI
   GravaNoIni vgNomeEstacao$ + "Geral", "Barra ferramentas", Str$(vgBarraFerr), vgNomeINI$
End Sub

Public Sub PoeTiraBarra()
   Menu_Barra.Checked = vgBarraFerr               'marca/desmarca no menu
   With panTools
      .Visible = vgBarraFerr                      'mostra/esconde a barra de ferramentas
      If vgBarraFerr Then                         'Ah! VB @#%&! - temos que "sacodir" a barra
         If .Align < 3 Then                       'para que ela não fique parada no meio do form
            .Height = .Height + 15                'em certos casos, causando efeito estético indesejável
            .Height = .Height - 15                'mexemos na altura se o align for topo ou fundo...
         Else
            .Width = .Width + 15                  'se o .align for esquerda ou direita
            .Width = .Width - 15                  'só podemos mexher na largura
         End If
      End If
   End With
End Sub

'controla a forma de apresentação dos dados no form (grade/tela)
Private Sub Menu_Browse_Click()
   ActiveForm.vgEmBrowse = (Not ActiveForm.vgEmBrowse)   'inverte a flag
   TrocaBrowse ActiveForm                                'muda a forma de apresentação
   PrepBotoes ActiveForm, ACAO_NAVEGANDO                 'ajusta a ação no form
End Sub

Private Sub Menu_Cancela_Click()
   CancelaAlteracoes                              'invoca o cancelamento de alterações
End Sub

Private Sub Menu_ConfGraf_Click()
   frmConfGraf.Show vbModal
End Sub

'configura impressora a utilizar
Private Sub Menu_ConfImp_Click()
   ConfigImpressora
End Sub

'apresenta o form de seleção de consultas existentes
Private Sub Menu_Consulta_Click()
   If frmSeleQueries.WindowState = vbMinimized Then   'se minimizado,
      frmSeleQueries.WindowState = vbNormal           'apenas abre
   Else                                               'senão
      frmSeleQueries.Show                             'carrega e mostra
   End If
End Sub

Private Sub Menu_Conteudo_Click()
   AtivaHelp                                      'mostra conteúdo da ajuda on-line
End Sub

'popmenu da grade - apaga colunas
Private Sub Menu_Grd_ApgCol_Click()
   ApagaColunas                                   'chama função para apagar colunas
End Sub

'popmenu da grade - filtra registro
Private Sub Menu_Grd_Filtra_Click()
   FiltraRegistros                                'chama rotina apropriada
End Sub

'popmenu da grade - monta gráfico da consulta
Private Sub Menu_Grd_Graf_Click()
   MontaGraficoConsulta ActiveForm                'chama rotina apropriada
End Sub

'popmenu da grade - impreme consulta
Private Sub Menu_Grd_Imp_Click()
   ImprimeForm                                    'chama rotina apropriada
End Sub

'popmenu da grade - procura registro
Private Sub Menu_Grd_Procura_Click()
   frmProcura.Show vbModal                        'chama rotina apropriada
End Sub

'popmenu da grade - reconstro consulta
Private Sub Menu_Grd_Constroi_Click()
   Dim i As Integer
   With ActiveForm.grdBrowse                      'então, com a grade,
      For i = 0 To .Cols - 1                      'torna todas as colunas
         .Columns(i).Visible = (InStr(.Columns(i).Caption, "~") = 0) 'visivel se não int~lan, cod~lan
      Next
      .SelStartCol = -1                                              'reseta a
      .SelEndCol = -1                                                'seleção de colunas
   End With
End Sub


Private Sub Menu_Exclui_Click()
   If (ActiveForm.vgCaracteristica = F_DADOS) And ActiveForm.vgEmBrowse Then
      If ActiveForm.grdBrowse.SelectedRowsCount > 0 Then        'se tem registro selecionado
         ActiveForm.grdBrowse.DeleteRecords
      Else
         Beep
         MsgBox LoadGasString(1536), vbExclamation, vgAtencao$  'mostra mensagem e retorna
      End If
   Else
      ExcluiRegistro                                            'manda excluir o registro
   End If
End Sub

Private Sub Menu_Filtra_Click()
   FiltraRegistros                                'invoca a filtragem de registros
End Sub

Private Sub Menu_Fim_Click()
   UnLoad Me                                      'descarrega este form que vos fala...
End Sub

Private Sub Menu_Grafa_Click()
   MontaGraficoConsulta ActiveForm                'chama rotina de montagem de gráfico
End Sub

Private Sub Menu_Salva_Click()
   SalvaDados                                     'invoca a gravação de dados
End Sub

Private Sub Menu_Imprime_Click()
   ImprimeForm                                    'invoca a impressão do form
End Sub

Private Sub Menu_Inclui_Click()
   IncluiRegistro                                 'manipula a incluisão do registro
End Sub

Private Sub Menu_Info_Click()
   If frmInfoDB.WindowState = 1 Then              'se minimizado,
      frmInfoDB.WindowState = 0                   'somente abre
   Else                                           'senao
      frmInfoDB.Show                              'carrega e mostra
   End If
End Sub

Private Sub Menu_Primeiro_Click()
   MoveRegistro ActiveForm, REG_PRIMEIRO          '"go top"...
End Sub

Private Sub Menu_Procura_Click()
   frmProcura.Show vbModal                        'apresenta o form para montar pesquisa à tabela
End Sub

Private Sub Menu_Repara_Click()
   ReparaBD                                       'manda reparar o BD
End Sub

Private Sub Menu_Seguinte_Click()
   MoveRegistro ActiveForm, REG_SEGUINTE          'avança um registro
End Sub

Private Sub Menu_Senhas_Click()
   frmSenhas.Show vbModal                         'apresenta módulo de manutenção de senhas...
End Sub

Private Sub Menu_Sobre_Click()
   frmSobre.Show vbModal                          'mostra os créditos...
End Sub

Private Sub Menu_Ultimo_Click()
   MoveRegistro ActiveForm, REG_ULTIMO            'vai para o último registro...
End Sub

Private Sub Menu_Operador_Click(Index As Integer)
   mdiNFE.ActiveForm.ClickOperador Index
End Sub

Private Sub MDIForm_Activate()
   MostraFormulas
   If mdiNFE.ActiveForm Is Nothing Then
      PrepBotoes Me, ACAO_NAVEGANDO               'ajusta barra de farramenta
   End If
End Sub

' carga do form principal da aplicação
Private Sub MDIForm_Load()
   Dim x As String                                'dimensiona
   Dim vgWinInfo As RECT

   If vgCriandoSenha Then Exit Sub

   vgCaracteristica = F_COMUM                     'ajusta característica,
   vgTipo = TP_COMUM                              'seu tipo
   vgFormID = 1                                   'identificacao do form
   vgSituacao = ACAO_NAVEGANDO                    'e a situação atual neste form

   'designa icones para os botoes da barra de ferramenta
   Set botInclui.Picture = LoadPicture(LoadGasPicture(28))
   Set botInclui.PictureDisabled = LoadPicture(LoadGasPicture(52))
   Set botInclui.PictureMouseOver = LoadPicture(LoadGasPicture(12))
   Set botCancela.Picture = LoadPicture(LoadGasPicture(31))
   Set botCancela.PictureDisabled = LoadPicture(LoadGasPicture(51))
   Set botCancela.PictureMouseOver = LoadPicture(LoadGasPicture(11))
   Set botBrowse.Picture = LoadPicture(LoadGasPicture(83))
   Set botBrowse.PictureDisabled = LoadPicture(LoadGasPicture(82))
   Set botBrowse.PictureMouseOver = LoadPicture(LoadGasPicture(81))
   Set botPrimeiro.Picture = LoadPicture(LoadGasPicture(35))
   Set botPrimeiro.PictureDisabled = LoadPicture(LoadGasPicture(54))
   Set botPrimeiro.PictureMouseOver = LoadPicture(LoadGasPicture(14))
   Set botAnterior.Picture = LoadPicture(LoadGasPicture(36))
   Set botAnterior.PictureDisabled = LoadPicture(LoadGasPicture(55))
   Set botAnterior.PictureMouseOver = LoadPicture(LoadGasPicture(15))
   Set botSeguinte.Picture = LoadPicture(LoadGasPicture(37))
   Set botSeguinte.PictureDisabled = LoadPicture(LoadGasPicture(56))
   Set botSeguinte.PictureMouseOver = LoadPicture(LoadGasPicture(16))
   Set botUltimo.Picture = LoadPicture(LoadGasPicture(38))
   Set botUltimo.PictureDisabled = LoadPicture(LoadGasPicture(57))
   Set botUltimo.PictureMouseOver = LoadPicture(LoadGasPicture(17))
   Set botImprime.Picture = LoadPicture(LoadGasPicture(34))
   Set botImprime.PictureDisabled = LoadPicture(LoadGasPicture(61))
   Set botImprime.PictureMouseOver = LoadPicture(LoadGasPicture(21))
   Set botExclui.Picture = LoadPicture(LoadGasPicture(29))
   Set botExclui.PictureDisabled = LoadPicture(LoadGasPicture(53))
   Set botExclui.PictureMouseOver = LoadPicture(LoadGasPicture(13))
   Set botSalva.Picture = LoadPicture(LoadGasPicture(27))
   Set botSalva.PictureDisabled = LoadPicture(LoadGasPicture(50))
   Set botSalva.PictureMouseOver = LoadPicture(LoadGasPicture(10))
   Set Botao(1).Picture = LoadPicture(LoadGasPicture(1000))

   'nome dos menus
   Set MnuCadastro = MDINFE.Menu_570(3)
   Set MnuParametros = MDINFE.Menu_570(2)
   Set mnuCapitaliza = MDINFE.Menu_FRM00621
   Set MnuConsultas = MDINFE.Menu_570(5)
   Set MnuFerramentas = MDINFE.Menu_570(6)

   'prepara texto de ajuda para os objetos
   vgTooltips.Create
   vgTooltips.AddTool botInclui, 0, LoadGasString(300)
   botInclui.Caption = LoadGasString(301)
   vgTooltips.AddTool botCancela, 0, LoadGasString(302)
   botCancela.Caption = LoadGasString(303)
   vgTooltips.AddTool botBrowse, 0, LoadGasString(304)
   botBrowse.Caption = LoadGasString(305)
   vgTooltips.AddTool botPrimeiro, 0, LoadGasString(306)
   vgTooltips.AddTool botAnterior, 0, LoadGasString(307)
   vgTooltips.AddTool botSeguinte, 0, LoadGasString(308)
   vgTooltips.AddTool botUltimo, 0, LoadGasString(309)
   vgTooltips.AddTool botImprime, 0, LoadGasString(310)
   botImprime.Caption = LoadGasString(311)
   vgTooltips.AddTool botExclui, 0, LoadGasString(312)
   botExclui.Caption = LoadGasString(313)
   vgTooltips.AddTool botSalva, 0, LoadGasString(314)
   botSalva.Caption = LoadGasString(315)
   vgTooltips.AddTool Botao(0), 0, LoadGasString(316)
   Label(0).Caption = LoadGasString(317)
   Botao(1).Caption = LoadGasString(318)
   Label(3).Caption = LoadGasString(319)
   x$ = PegaStrDoIni("Opcoes", "Tempo refresh", vgNomeINI$) 'pega tempo refresh no INI
   If Val(x$) = 0 Then                                      'não achou,
      x$ = "25"                                             'fixamos 25 segundos
      GravaNoIni "Opcoes", "Tempo refresh", x$, vgNomeINI$  'e gravamos - na próxima vamos achar...
   End If
   timRefresh.Interval = Val(x$) * 1000                     'ajusta em milésimos de segundo

   x$ = PegaStrDoIni("Opcoes", "WindowState", vgNomeINI$)   'vê se o mdi estava maximizado
   If x$ = "2" Then WindowState = Val(x$)
   Set paneControles = Painel(0)
   Set cmdCapitaliza = Botao(0)
   Set lblTitulo = Label(0)
   Set lblGrupo = Label(1)
   Set lblUsuario = Label(2)
   Set lblDataHora = Label(3)
   Set lblUsuario2 = Label(4)
   Set lblAlteracao = Label(5)
   Set lblProgresso = Label(6)

   'ajusta este para ficar um pouco menor do que a tela, desconsiderando o systray
   If SystemParametersInfo(SPI_GETWORKAREA, 0, vgWinInfo, 0) <> 0 Then
      Width = (vgWinInfo.Right * Screen.TwipsPerPixelX) - (40 * Screen.TwipsPerPixelX) 'largura
      Height = (vgWinInfo.Bottom * Screen.TwipsPerPixelY) - (40 * Screen.TwipsPerPixelY) 'altura
   Else
      Width = Screen.Width - 720                  'largura
      Height = Screen.Height - 720                'altura
   End If
   Caption = vgNomeSistema$ + Chr$(160)           'o título será o título da aplicação
   vgTile.Tile.BackGroundType = 1
   vgTile.Tile.Picture = LoadPicture(LoadGasPicture(6))
   vgTile.Tile.TransPicture = LoadPicture(LoadGasPicture(7))
   vgTile.Init Me
   CentraNaTela Me                                'centraliza dentro da área de cliente
   LeParametrosForm Me                            'le parâmetros dest form no .INI e,
   Menu_Ajuda.Checked = vgAjudaAtiva              'marca/desmarca opção no menu
   mdiLoad  
End Sub

'tentou descarrega o form principal - vamos tratar...
Private Sub MDIForm_QueryUnload(Cancel As Integer, UnloadMode As Integer)
   Dim i As Long                                       'dimensiona
   If vgCriandoSenha Then Exit Sub
   If QtForms > 0 And Visible Then                     'se tem outros forms e se o MDI está visível,
      For i = 1 To Forms.Count - 1                     'enquanto existir forms,
         If FormPendente(Forms(i)) Then                'se tiver pendente de atualização, vamos avisar
            If Forms(i).WindowState = vbMinimized Then 'se form está minimizado,
               Forms(i).WindowState = vbNormal         'ajusta para normal
            End If
            Forms(i).SetFocus                          'e voltar para lá...
            PrepBotoes Forms(i), Forms(i).vgSituacao   'ajeita barra de ferramentas
            Cancel = True                              'cancela a saída
            Exit For                                   'e sai...
         End If
      Next
   End If
   If Not Cancel Then                                  'se realmente vai abandonar a aplicação
      Do While Forms.Count > 1                         'e enquanto existir forms,
         If Forms(1).Name <> "mdiNFE" Then
            UnLoad Forms(1)                            'vamos descarrega-los 
         Else
            UnLoad Forms(0)                            'vamos descarrega-los
         End If
         DoEvents
      Loop
   End If
End Sub

Private Sub MDIForm_Resize()
   Dim vgLargMin As Long, vgAltMin As Long        'vamos limitar o tamanho deste form
   If WindowState = vbNormal Then                 'se não esta minimizado...
      vgAltMin = Screen.Height / 3                'altura e lagura mímina é
      vgLargMin = Screen.Width / 3                'igual a 1/3 do tamanho da tela
      If Height < vgAltMin Then Height = vgAltMin 'limita o rezise vertical e
      If Width < vgLargMin Then Width = vgLargMin 'horizontal
   End If
   vgTile.Refresh
End Sub

Private Sub MDIForm_Unload(Cancel As Integer)
   If vgCriandoSenha Then Goto UnloadAll
   GravaParametrosForm Me                         'parâmetros genéricos
   timRefresh.Enabled = False                     'desabilita o timer de refresh dos dados
   GravaNoIni "Opcoes", "WindowState", Str$(WindowState), vgNomeINI$ 'estado do form
   Do While Forms.Count > 1                                          'enquanto existir forms,
      Unload Forms(1)                                                'vamos descarrega-los
   Loop
UnloadAll:
   Set paneControles = Nothing
   Set cmdCapitaliza = Nothing
   Set lblTitulo = Nothing
   Set lblGrupo = Nothing
   Set lblUsuario = Nothing
   Set lblDataHora = Nothing
   Set lblUsuario2 = Nothing
   Set lblAlteracao = Nothing
   Set lblProgresso = Nothing
   Set vgTooltips = Nothing                                          'libera memória da variável
   Set vgTile = Nothing
   GeraLogAcao LoadGasString(294)
   If Not vgCriandoSenha Then FinalizaAplicacao                      'Finaliza o programa
End Sub

Private Sub schNavega_Change()
   Dim i As Long
   Static vgValAnt As Integer
   If Not vgNaoAtRolagem Then                     'se não é para atualizar valor do scroll
      Screen.MousePointer = vbHourglass           'mouse = ampulheta
      vgBotoesOK = False                          'reseta flag
      With schNavega
         If .Value = vgValAnt + 1 Or .Value = vgValAnt - 1 Or _
          .Value = vgValAnt + 10 Or .Value = vgValAnt - 10 Then 'testa valor com valor anterior
            ActiveForm.vgTb.Move (.Value - vgValAnt)            'e move o necessário
         Else                                     'senão,
            i = (ActiveForm.vgTb.RecordCount - 1) * .Value / 100
            ActiveForm.vgTb.MoveFirst             'move para o primeiro, calcula posição
            ActiveForm.vgTb.Move i
         End If
      End With
      If ActiveForm.vgTb.EOF Then                 'se final de arquivo,
         ActiveForm.vgTb.MoveLast                 'move para o último registro
      ElseIf ActiveForm.vgTb.BOF Then             'se início,
         ActiveForm.vgTb.MoveFirst                'move para o primeiro
      End If
      vgBotoesOK = True                           'liga flag
      ActiveForm.Reposition                       'remonta a tela
      AjustaRolagem ActiveForm                    'ajusta a rolagem
      Screen.MousePointer = vbDefault
   End If
   vgValAnt = schNavega.Value                     'salva o valor do filtro
End Sub

'esta rotina é chamada a intervalos periódicos de tempo (cerca de 10 seg) para
'remontar os dados nos forms de visualização de dados
Private Sub timRefresh_Timer()
   Dim F As Form, vgMouseAtual As Integer            'dimensiona
   vgMouseAtual = Screen.MousePointer                'salva pointer do mouse
   Screen.MousePointer = vbHourglass                 'passa para ampulheta
   On Error GoTo DeuErro                             'prepara para erros
   If QtForms > 0 Then                               'se tiver algum form aberto
      For Each F In Forms
         If F.vgTipo = TP_TABELA Then                'se é form que contém controles vinculados
            If F.vgSituacao = ACAO_NAVEGANDO And F.vgPriVez = False Then 'se está somente navegando,
               If F.Name <> ActiveForm.Name And F.vgCaracteristica = F_DADOS Then
                  If Err Then
                     Err.Clear
                  Else
                     F.Reposition
                     If F.vgEmBrowse Then                                'se esta em grid
                        F.grdBrowse.Refresh                              'força uma remontagem
                     End If
                  End If
               End If
            End If
         End If
      Next
   End If
   Screen.MousePointer = vgMouseAtual                                    'restabelece o ponteiro do mouse
   On Error Resume Next
   mdiNFE.Botao(0).Visible = (False)
   If Err > 0 Then
      Err.Clear
      mdiNFE.Botao(0).Visible = False
   End If
   Exit Sub                                       'e cai fora...

DeuErro:                                          'se caiu aqui, deu erro...
   If Err = 3167 Then                             'EPA! este registro está deletado!
      MoveRegistro F, REG_FORCAVOLTA              'retrocede um registro...
   End If
   Resume Next                                    'e continua normalmente
End Sub

'evento - quando o botão for pressionado
Private Sub Botao_Click(Index As Integer)
   Dim Cancel As Boolean, hMenu As Long, pt As POINTAPI
   If vgPriVez Then Exit Sub
   Select Case Index
      Case 1
         vgPriVez = True
         mdiNFE.MMDFe
         vgPriVez = False
   End Select
End Sub


'Capitaliza
Private Sub MFRM00621
   If mnuCapitaliza.Checked Then
    mnuCapitaliza.Checked = False
    cmdCapitaliza.Value = False
Else
    mnuCapitaliza.Checked = True
    cmdCapitaliza.Value = True
End If
End Sub

'Parametros do Emitente
Private Sub MEmpresa
   On Error Resume Next
   If frmEmpresa.WindowState = vbMinimized Then
      frmEmpresa.WindowState = vbNormal
   Else
      frmEmpresa.Show 
   End If
   frmEmpresa.SetFocus
End Sub

'Parametros do MDFe
Private Sub MParNFe
   On Error Resume Next
   If frmParNFe.WindowState = vbMinimized Then
      frmParNFe.WindowState = vbNormal
   Else
      frmParNFe.Show 
   End If
   frmParNFe.SetFocus
End Sub

'Emitentes
Private Sub MEmitMdfe
   On Error Resume Next
   If frmEmitMdfe.WindowState = vbMinimized Then
      frmEmitMdfe.WindowState = vbNormal
   Else
      frmEmitMdfe.Show 
   End If
   frmEmitMdfe.SetFocus
End Sub

'Municípios
Private Sub MMunicipi
   On Error Resume Next
   If frmMunicipi.WindowState = vbMinimized Then
      frmMunicipi.WindowState = vbNormal
   Else
      frmMunicipi.Show 
   End If
   frmMunicipi.SetFocus
End Sub

'Motoristas
Private Sub MMotorist
   On Error Resume Next
   If frmMotorist.WindowState = vbMinimized Then
      frmMotorist.WindowState = vbNormal
   Else
      frmMotorist.Show 
   End If
   frmMotorist.SetFocus
End Sub

'MDF-e
Public Sub MMDFe
   On Error Resume Next
   If frmMDFe.WindowState = vbMinimized Then
      frmMDFe.WindowState = vbNormal
   Else
      frmMDFe.Show 
   End If
   frmMDFe.SetFocus
End Sub

'Cancela Manifesto
Private Sub MCanMDFe
   On Error Resume Next
   If frmCanMDFe.WindowState = vbMinimized Then
      frmCanMDFe.WindowState = vbNormal
   Else
      frmCanMDFe.Show 
   End If
   frmCanMDFe.SetFocus
End Sub

'Encerra Manifesto
Private Sub MEncMDFe
   On Error Resume Next
   If frmEncMDFe.WindowState = vbMinimized Then
      frmEncMDFe.WindowState = vbNormal
   Else
      frmEncMDFe.Show 
   End If
   frmEncMDFe.SetFocus
End Sub

'Copia de Segurança
Private Sub MBackup
   On Error Resume Next
   If frmBackup.WindowState = vbMinimized Then
      frmBackup.WindowState = vbNormal
   Else
      frmBackup.Show 
   End If
   frmBackup.SetFocus
End Sub

'evento - quando o menu de &Parametros do Emitente for pressionado
Private Sub Menu_614_Click(Index As Integer)
   Select Case Index
      Case 0 'Parametros do Emitente
         MEmpresa
      Case 1 'Parametros do MDFe
         MParNFe
   End Select
End Sub

'evento - quando o menu de &Emitentes for pressionado
Private Sub Menu_642_Click(Index As Integer)
   Select Case Index
      Case 0 'Emitentes
         MEmitMdfe
      Case 1 'Municípios
         MMunicipi
      Case 2 'Motoristas
         MMotorist
   End Select
End Sub

'evento - quando o menu de &MDF-e for pressionado
Private Sub Menu_639_Click(Index As Integer)
   Select Case Index
      Case 0 'MDF-e
         MMDFe
   End Select
End Sub

'evento - quando o menu de Cancela Manifesto for pressionado
Private Sub Menu_647_Click(Index As Integer)
   Select Case Index
      Case 0 'Cancela Manifesto
         MCanMDFe
      Case 1 'Encerra Manifesto
         MEncMDFe
   End Select
End Sub

'evento - quando o menu de Copia de Segurança for pressionado
Private Sub Menu_637_Click(Index As Integer)
   Select Case Index
      Case 0 'Copia de Segurança
         MBackup
   End Select
End Sub

'evento - quando o menu de Capitaliza for pressionado
Private Sub Menu_FRM00621_Click()
   MFRM00621
End Sub 

