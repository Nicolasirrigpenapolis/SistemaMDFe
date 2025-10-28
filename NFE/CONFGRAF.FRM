VERSION 5.00
Object = "{0842D103-1E19-101B-9AAF-1A1626551E7C}#1.0#0"; "GRAPH32.OCX"
Begin VB.Form frmConfGraf
   BorderStyle     =   3  'Fixed Dialog
   ClientHeight    =   4395
   ClientLeft      =   915
   ClientTop       =   3345
   ClientWidth     =   5940
   Height          =   4800
   KeyPreview      =   -1  'True
   Left            =   855
   LinkTopic       =   "frmConfGraf"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4395
   ScaleWidth      =   5940
   ShowInTaskbar   =   0   'False
   Top             =   3000
   Width           =   6060
   Begin VB.ComboBox cboDestaca
      Enabled         =   0   'False
      Height          =   315
      Left            =   4560
      Style           =   2  'Dropdown List
      TabIndex        =   22
      Top             =   360
      Width           =   1155
   End
   Begin VB.TextBox txtTitEsq
      Height          =   285
      Left            =   3180
      MaxLength       =   80
      TabIndex        =   19
      Top             =   3180
      Width           =   2655
   End
   Begin VB.ComboBox cboTipoGraf
      Height          =   315
      Left            =   3180
      Style           =   2  'Dropdown List
      TabIndex        =   14
      Top             =   360
      Width           =   1275
   End
   Begin VB.ComboBox cboEstilo
      Height          =   315
      Left            =   3180
      Style           =   2  'Dropdown List
      TabIndex        =   8
      Top             =   1020
      Width           =   2655
   End
   Begin VB.TextBox txtTitGraf
      Height          =   285
      Left            =   3180
      MaxLength       =   80
      TabIndex        =   3
      Top             =   2580
      Width           =   2655
   End
   Begin VB.TextBox txtTitFundo
      Height          =   285
      Left            =   3180
      MaxLength       =   80
      TabIndex        =   2
      Top             =   2880
      Width           =   2655
   End
   Begin VB.Frame fraGrade
      Height          =   1035
      Left            =   3180
      TabIndex        =   9
      Top             =   1440
      Width           =   2655
      Caption         =   "Grades"
      Begin VB.OptionButton opcGrade
         Height          =   255
         Index           =   3
         Left            =   1440
         TabIndex        =   13
         Top             =   660
         Width           =   1035
         Caption         =   "Ambas"
      End
      Begin VB.OptionButton opcGrade
         Height          =   255
         Index           =   2
         Left            =   1440
         TabIndex        =   12
         Top             =   360
         Width           =   1035
         Caption         =   "Vertical"
      End
      Begin VB.OptionButton opcGrade
         Height          =   255
         Index           =   1
         Left            =   180
         TabIndex        =   11
         Top             =   660
         Width           =   1095
         Caption         =   "Horizontal"
      End
      Begin VB.OptionButton opcGrade
         Height          =   255
         Index           =   0
         Left            =   180
         TabIndex        =   10
         Top             =   360
         Width           =   1095
         Caption         =   "Nenhuma"
      End
   End
   Begin GraphLib.Graph gra1
      Height          =   2415
      Left            =   60
      TabIndex        =   25
      Top             =   60
      Width           =   3075
      _version        =   65536
      _extentx        =   5424
      _extenty        =   4260
      _stockprops     =   96
      borderstyle     =   1
      graphstyle      =   6
      graphtype       =   4
      gridstyle       =   3
      numpoints       =   7
      patternedlines  =   1
      randomdata      =   1
      thicklines      =   0
      colordata       =   0
      extradata       =   0
      extradata[]     =   7
      fontfamily      =   4
      fontsize        =   4
      fontsize[0]     =   200
      fontsize[1]     =   150
      fontsize[2]     =   100
      fontsize[3]     =   100
      fontstyle       =   4
      graphdata       =   0
      graphdata[]     =   7
      labeltext       =   0
      legendtext      =   0
      patterndata     =   0
      symboldata      =   0
      xposdata        =   0
      xposdata[]      =   0
   End
   Begin NFE.GBotao botRestaura
      Height          =   450
      Left            =   4950
      TabIndex        =   24
      Top             =   3900
      Width           =   450
      ForeColor       =   -2147483640
   End
   Begin VB.Label labDestaca
      AutoSize        =   -1  'True
      Caption         =   "Destaca fatias"
      Enabled         =   0   'False
      Height          =   195
      Left            =   4560
      TabIndex        =   23
      Top             =   120
      Width           =   1215
   End
   Begin VB.CheckBox chkConfGraf
      Height          =   255
      Index           =   4
      Left            =   3600
      TabIndex        =   21
      Top             =   3600
      Width           =   1635
      Caption         =   "Exibir rótulos"
   End
   Begin VB.Label labTitEsq
      Alignment       =   1  'Right Justify
      AutoSize        =   -1  'True
      Caption         =   "Título a usar no eixo Y"
      Height          =   195
      Left            =   1440
      TabIndex        =   20
      Top             =   3240
      Width           =   1665
   End
   Begin NFE.GBotao botCancela
      Height          =   450
      Left            =   5400
      TabIndex        =   18
      Top             =   3900
      Width           =   450
      ForeColor       =   -2147483640
   End
   Begin NFE.GBotao botOk
      Height          =   450
      Left            =   4500
      TabIndex        =   17
      Top             =   3900
      Width           =   450
      ForeColor       =   -2147483640
   End
   Begin VB.Label labTipoGraf
      AutoSize        =   -1  'True
      Caption         =   "Tipo do gráfico"
      Height          =   195
      Left            =   3180
      TabIndex        =   16
      Top             =   120
      Width           =   1335
   End
   Begin VB.Label labEstilo
      AutoSize        =   -1  'True
      Caption         =   "Estilo do gráfico"
      Height          =   195
      Left            =   3180
      TabIndex        =   15
      Top             =   780
      Width           =   2655
   End
   Begin VB.Label labTitFundo
      Alignment       =   1  'Right Justify
      AutoSize        =   -1  'True
      Caption         =   "Título a usar no eixo X"
      Height          =   195
      Left            =   1500
      TabIndex        =   7
      Top             =   2940
      Width           =   1605
   End
   Begin VB.CheckBox chkConfGraf
      Height          =   255
      Index           =   3
      Left            =   1740
      TabIndex        =   6
      Top             =   3960
      Width           =   1635
      Caption         =   "Monocromático"
   End
   Begin VB.Label labTitGraf
      Alignment       =   1  'Right Justify
      AutoSize        =   -1  'True
      Caption         =   "Título do gráfico"
      Height          =   195
      Left            =   1440
      TabIndex        =   5
      Top             =   2640
      Width           =   1650
   End
   Begin VB.CheckBox chkConfGraf
      Height          =   255
      Index           =   2
      Left            =   1740
      TabIndex        =   4
      Top             =   3600
      Width           =   1755
      Caption         =   "Legendas a cores"
   End
   Begin VB.CheckBox chkConfGraf
      Height          =   255
      Index           =   1
      Left            =   60
      TabIndex        =   1
      Top             =   3960
      Width           =   1635
      Caption         =   "Tonalidade pastel"
   End
   Begin VB.CheckBox chkConfGraf
      Height          =   255
      Index           =   0
      Left            =   60
      TabIndex        =   0
      Top             =   3600
      Width           =   1635
      Caption         =   "Usar bordas"
   End
End
Attribute VB_Name = "frmConfGraf"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
'* Sistema...: Emissor de MDF-e (Layout 3.00)
'* Empresa...: Ygor Eduardo Dellalio
'* Módulo....: frmConfGraf
'* Função....: Configuração de gráficos
'* CopyRight.: (C)2024 Ygor Eduardo Dellalio
'* Criação...: GAS-2007 - Gerador Automático de Sistemas
'* Data......: 05/09/2024 18:10:18
'* * * * * * *

Option Explicit                                   'requer declarações explícita de variáveis
DefInt A-Z                                        'por default, todas serão do tipo inteiro
Public vgCaracteristica As Integer                'estas propriedades todos os forms têm
Public vgSituacao As Integer, vgFormID As Long
Public vgTipo As Integer

'constantes para indexar as opcoes do gráfico
Const O_BORDA = 0                                 'com borda
Const O_PASTEL = 1                                'usar cores pastel
Const O_LEGENDA = 2                               'legendas
Const O_MONOCROMATICO = 3                         'monocromático
Const O_COMROTULOS = 4                            'usar rótulos

Dim vgFator As Integer                            'dimensiona o que precisamos
Public vgTooltips As New cTooltips

'pega as configurações do gráfico original
'enche com dados demonstrativos para visualizar o gráfico
Private Sub PegaConfigOriginal()
   Dim i As Integer, j As Integer                          'dimensiona locais
   With mdiNFE.ActiveForm.gra1                             'com a instância ativa do gráfico
      gra1.NumSets = IIf(.NumSets > 1, 3, 1)               'ajusta num sets e
      gra1.NumPoints = IIf(.NumPoints > 1, 3, 1)           'e número de pontos
      cboTipoGraf.ListIndex = .GraphType - 1 - vgFator     'desconta o indice 0 = nenhum e o fator
      cboEstilo.ListIndex = .GraphStyle                    'estilo do gráfico
      opcGrade(.GridStyle).Value = True                    'grade
      chkConfGraf(O_BORDA).Value = Abs(.BorderStyle = 1)   'borda
      chkConfGraf(O_PASTEL).Value = Abs(.Palette = 1)      'tonalidade pastel
      chkConfGraf(O_LEGENDA).Value = Abs(.LegendStyle = 1) 'estilo da legenda
      chkConfGraf(O_MONOCROMATICO).Value = Abs(.DrawStyle = 0) 'cor
      chkConfGraf(O_COMROTULOS).Value = Abs(.Labels = 1)       'usar labels
      txtTitGraf.Text = .GraphTitle                            'titulo do gráfico na textbox
      gra1.GraphTitle = .GraphTitle                            'aplica no gráfico
      txtTitFundo.Text = .BottomTitle                          'titulo inferior na textbox
      gra1.BottomTitle = .BottomTitle                          'aplica no gráfico
      txtTitEsq.Text = .LeftTitle                              'titulo esquerda na textbox
      gra1.LeftTitle = .LeftTitle                              'aplica no gráfico
      If Len(.LegendText) > 0 Then                             'se existe legendas
         For i = 1 To gra1.NumPoints                           'enche com
            gra1.LegendText = Chr$(64 + i)                     'letras de A-Z
         Next                                                  'só para mostrar exemplo
      End If
      j = 0                                       'vamos captar o destaque de fatias: 0=nenhuma
      For i = 1 To .NumPoints                     'para cada ponto,
         .ThisPoint = i                           'seleciona o ponto
         If .ExtraData <> 0 Then                  'os destaques de fatia estão nesta propriedade
            If i = 1 Then                         'este é o primeiro ponto
               j = 1                              'j=1 = primeira
            ElseIf i = .NumPoints Then            'este é o ultimo
               j = 3 - j                          'última está destacada
            Else                                  'senão,
               j = 2                              'j=2 = todas
               Exit For                           'sai do for...
            End If
         End If
      Next
      cboDestaca.ListIndex = -1                   'reseta e
      cboDestaca.ListIndex = j                    'força a seleção do que está configurado
   End With
End Sub

'cancelou - não nos interessa o que configurou! Caimos fora...
Private Sub botCancela_Click()
   Unload Me                                      'descarrega este que vos fala...
End Sub

'clicou no botão ok - vamos copiar o que foi configurado para
'o modelo e copiar para o nosso gráfico
Private Sub botOk_Click()
   Dim i As Integer                                 'dimensiona
   With mdiNFE.ActiveForm.gra1                      'com o gráfico
      .GraphType = cboTipoGraf.ListIndex + vgFator + 1 'tipo 0 = nenhum !?
      .GraphStyle = cboEstilo.ListIndex                'aplicamos o estilo
      .ThickLines = gra1.ThickLines                    'linhas grossas
      mdiNFE.ActiveForm.RestauraDados                  'restaura os dados, após configuracao
      For i = 0 To 3                                   'pega o que
         If opcGrade(i).Value Then                     'foi configurado
            .GridStyle = i                             'para o estilo da grade
            Exit For                                   'e sai...
         End If
      Next
      .BorderStyle = gra1.BorderStyle                  'aplica tipo de borda
      .Palette = gra1.Palette                          'paleta de cores
      .LegendStyle = gra1.LegendStyle                  'estilo de legenda
      .DrawStyle = gra1.DrawStyle                      'estilo monocromático/colorido
      .Labels = gra1.Labels                            'labels
      If Len(txtTitGraf.Text) > 0 Then                 'se houver título,
         .GraphTitle = Left$(txtTitGraf.Text, 80)      'aplica
      Else                                             'senão,
         .GraphTitle = ""                              'limpa
      End If
      If Len(txtTitFundo.Text) > 0 Then                'se houver título de fundo
         .BottomTitle = txtTitFundo.Text               'aplica
      Else                                             'senão,
         .BottomTitle = ""                             'limpa
      End If
      If Len(txtTitEsq.Text) > 0 Then                  'se houver título esquerdo
         .LeftTitle = txtTitEsq.Text                   'aplica
      Else                                             'senão,
         .LeftTitle = ""                               'limpa
      End If
      .DataReset = 3                                   'reseta extradata (destaque de fatias)
      For i = 1 To .NumPoints                          'corre os pontos
         .ThisPoint = i                                'pega uma fatia
         If i = 1 And cboDestaca.ListIndex = 1 Or _
            i = .NumPoints And cboDestaca.ListIndex = 3 Or _
            cboDestaca.ListIndex = 2 Then              've se está destacada e
            .ExtraData = 1                             'designa esta propriedade
         End If
      Next
      .DrawMode = 2                                    'força repintura do gráfico
   End With
   Unload Me                                           'descarrega este form de configuração
End Sub

'deseja restaurar configurações default
Private Sub botRestaura_Click()
   PegaConfigOriginal                             'pega a configuração "de fábrica"
   gra1.DrawMode = 2                              'força repintura do gráfico
End Sub

'clicou na combo de destaque de fatias - gráfico pizza
Private Sub cboDestaca_Click()
   Dim i As Integer                               'dimensiona
   With gra1                                      'com o modelo,
      .DataReset = 3                              'reseta os destaques
      For i = 1 To .NumPoints                     'para cada ponto
         .ThisPoint = i                           'qual fatia        'pega um deles
         If i = 1 And cboDestaca.ListIndex = 1 Or _
            i = .NumPoints And cboDestaca.ListIndex = 3 Or _
            cboDestaca.ListIndex = 2 Then         'vê se está destacado
            .ExtraData = 1                        'e joga na propriedade extradata
         End If
      Next                                        'pega proximo ponto
      .DrawMode = 2                               'redesenha o gráfico
   End With
End Sub

'clicou na combo de estilo de gráfico
'a variável do form vgFator é utilizada como artifício para selecionar na combo
'gráficos que usam conjunto de dados semelhantes (por exemplo, pizza, barras 2d, barras 3d...)
Private Sub cboEstilo_Click()
   gra1.GraphStyle = cboEstilo.ListIndex             've o que está selecionado e aplica no modelo
   If cboTipoGraf.ListIndex = 5 + vgFator Then       'gráfico de linhas
      gra1.ThickLines = Abs(cboEstilo.ListIndex <> 4) 'aplica propriedade no modelo
   End If
   gra1.DrawMode = 2                                  'redesenha o gráfico
End Sub

'selecionou tipo de gráfico
Private Sub cboTipoGraf_Click()
   Dim x As String, i As Integer                             'dimensiona o que precisamos
   labDestaca.Enabled = (cboTipoGraf.ListIndex + vgFator < 2) 'só pizza pode ter destaque
   cboDestaca.Enabled = labDestaca.Enabled                    'de fatias...
   fraGrade.Enabled = Not (labDestaca.Enabled)                'quem não tem destaque, pode ter grades
   For i = 0 To 3                                             'habilita as
      opcGrade(i).Enabled = fraGrade.Enabled                  'opções de grade (nenhuma, vert, horiz, ambas)
   Next
   If cboDestaca.Enabled = False Then                         'se não tem fatias,
      gra1.DataReset = 3                                      'reseta extradata
   End If

   'enche combo com nomes dos estilos de gráficos, segundo o tipo
   With cboEstilo
      .Clear                                                  'limpa a combo
      Select Case cboTipoGraf.ListIndex + vgFator             'verifica tipo de gráfico e carrega estilos...
         Case 0, 1                                            'para gráficos de pizza 2D e 3D
            .AddItem LoadGasString(2330)                      'Linhas do rótulo para fatia
            .AddItem LoadGasString(2340)                      'Sem linhas para o rótulo
            .AddItem LoadGasString(2350)                      'Usar cores nos rótulos
            .AddItem LoadGasString(2360)                      'Rótulos a cores, sem linhas
            .AddItem LoadGasString(2370)                      'Rótulos em %
            .AddItem LoadGasString(2380)                      'Rótulos em %, sem linhas
            .AddItem LoadGasString(2390)                      'Rótulos em %, a cores
            .AddItem LoadGasString(2400)                      'Rótulos em %, a cores, s/linhas
         Case 2, 3                                            'para gráficos de barras 2D e 3D
            .AddItem LoadGasString(2410)                      'Vertical
            .AddItem LoadGasString(2420)                      'Horizontal
            .AddItem LoadGasString(2430)                      'Empilhado
            .AddItem LoadGasString(2440)                      'Empilhado horizontal
            .AddItem LoadGasString(2450)                      'Empilhado em %
            .AddItem LoadGasString(2460)                      'Empilhado em %, horizontal
            If cboTipoGraf.ListIndex + vgFator = 3 Then       'se barras 3D, tem mais esses dois abaixo...
               .AddItem LoadGasString(2470)                   'Z-Agrupado
               .AddItem LoadGasString(2480)                   'Z-Agrupado horizontal
            End If
         Case 4                                               'para gráficos Gantt...
            .AddItem LoadGasString(2490)                      'Barras adjacentes
            .AddItem LoadGasString(2500)                      'Barras espaçadas
         Case 5, 6, 9                                         'para gráficos de Linha, Log/lin e Polar
            .AddItem LoadGasString(2510)                      'Linhas normais
            .AddItem LoadGasString(2520)                      'Símbolos
            .AddItem LoadGasString(2530)                      'Bastões
            .AddItem LoadGasString(2540)                      'Bastões e símbolos
            .AddItem LoadGasString(2550)                      'Linhas pontilhadas
            .AddItem LoadGasString(2560)                      'Linhas e símbolos
            .AddItem LoadGasString(2570)                      'Linhas e bastões
            .AddItem LoadGasString(2580)                      'Linhas, bastões e símbolos
         Case 7                                               'para gráficos de área
            .AddItem LoadGasString(2590)                      'Áreas empilhadas
            .AddItem LoadGasString(2600)                      'Absoluto
            .AddItem LoadGasString(2610)                      'Percentual
         Case 8                                               'para gráfico espalhado
            .AddItem LoadGasString(2620)                      'Sómente símbolos
         Case 10                                              'para gráfico HLC
            .AddItem LoadGasString(2630)                      'Barras HLC
            .AddItem LoadGasString(2640)                      'Sem média
            .AddItem LoadGasString(2650)                      'Sem máximo e mínimo
            .AddItem LoadGasString(2660)                      'Sem barras
      End Select
   End With
   gra1.GraphType = cboTipoGraf.ListIndex + vgFator + 1       'index = 0 = nenhum

   'carrega o gráfico exemplo com alguma coisa para a gente ver...
   x$ = "95-76-87-58-56-40-23-30-10"                          'alguns dados...
   gra1.ThisPoint = 1                                         'pega primeiro ponto
   gra1.ThisSet = 1                                           'pega primeiro set
   For i = 1 To gra1.NumSets * gra1.NumPoints                 'enche o gráfico
      gra1.GraphData = Val(Mid$(x$, i * 3 - 2, 2))            'com os dados
   Next
   cboEstilo.ListIndex = 0                                    'ajusta para o default
End Sub

'clicou nos checkboxes de opções...
Private Sub chkConfGraf_Click(Index As Integer)
   If Index = O_MONOCROMATICO Then                 'se clicou em monocromático,
      chkConfGraf(O_PASTEL).Enabled = (chkConfGraf(Index).Value = vbUnChecked) 'habilita ou desabilita esses dois que
      chkConfGraf(O_LEGENDA).Enabled = (chkConfGraf(Index).Value =  vbUnChecked) 'se aplicam somente a colorido...
   End If
   Select Case Index                              'verifica em qual clicou...
      Case O_BORDA                                'opção de bordas,
         gra1.BorderStyle = Abs(chkConfGraf(Index).Value) 'aplica no modelo
      Case O_PASTEL                                       'tonalidade pastel,
         gra1.Palette = Abs(chkConfGraf(Index).Value)     'aplica no modelo
      Case O_LEGENDA                                      'tipo da legenda,
         gra1.LegendStyle = Abs(chkConfGraf(Index).Value) 'aplica no modelo
      Case O_MONOCROMATICO                                'monocromático,
         gra1.DrawStyle = Abs(chkConfGraf(Index).Value - 1) 'aplica no modelo
      Case O_COMROTULOS                                     'com rótulos,
         gra1.Labels = Abs(chkConfGraf(Index).Value)        'aplica no modelo
   End Select                                               'e
   gra1.DrawMode = 2                                        'redesenha
End Sub

'carga do form de configuração de gráficos...
Private Sub Form_Load()
   Dim vgTiposG As String, vgDFatias As String, _
       x As String, i As Integer                         'dimensiona o que precisamos
   vgCaracteristica = F_COMUM                            'designa propriedades
   vgSituacao = ACAO_NAVEGANDO
   vgTipo = TP_CONFGRAF
   vgFormID = 3                                          'identificacao do form
   Screen.MousePointer = vbHourglass                     'mouse = ampulheta
   Caption = LoadGasString(2670) + _
             mdiNFE.ActiveForm.Caption                   'designa título
   SET botOk.Picture = LoadPicture(LoadGasPicture(270))  'põe figura no botão ok,
   SET botCancela.Picture = LoadPicture(LoadGasPicture(275)) 'cancela e
   SET botRestaura.Picture = LoadPicture(LoadGasPicture(280)) 'restaura
   labTipoGraf.Caption = LoadGasString(2000)                  'título no label do tipo,
   labDestaca.Caption = LoadGasString(2010)                   'no destaque de fatias e
   labEstilo.Caption = LoadGasString(2020)                    'no de estilos
   fraGrade.Caption = LoadGasString(2030)                     'título do frame de opções de grade
   opcGrade(0).Caption = LoadGasString(2040)                  'nenhuma
   opcGrade(1).Caption = LoadGasString(2050)                  'horizontal,
   opcGrade(2).Caption = LoadGasString(2060)                  'vertical
   opcGrade(3).Caption = LoadGasString(2070)                  'ambas
   labTitGraf.Caption = LoadGasString(2080)                   'campo do título do gráfico,
   labTitFundo.Caption = LoadGasString(2090)                  'titulo de fundo e
   labTitEsq.Caption = LoadGasString(2100)                    'título à esquerda
   chkConfGraf(0).Caption = LoadGasString(2110)               'bordas
   chkConfGraf(1).Caption = LoadGasString(2120)               'tonalidade pastel
   chkConfGraf(2).Caption = LoadGasString(2130)               'legendas
   chkConfGraf(3).Caption = LoadGasString(2140)               'monocromático e
   chkConfGraf(4).Caption = LoadGasString(2150)               'exibir rótulos

   'carrega textos de ajuda na propriedade TAG dos objetos
   vgTooltips.Create 
   vgTooltips.AddTool cboTipoGraf, 0, LoadGasString(2160)     'ajuda para label do tipo de gráfico,
   vgTooltips.AddTool txtTitEsq, 0, LoadGasString(2170)       'campo do título à esquerda,
   vgTooltips.AddTool botOk, 0, LoadGasString(2180)           'botão Ok,
   vgTooltips.AddTool botCancela, 0, LoadGasString(2190)      'cancela e
   vgTooltips.AddTool botRestaura, 0, LoadGasString(2200)     'restaura
   vgTooltips.AddTool fraGrade, 0, LoadGasString(2210)        'ajuda para o frame de opções de grade
   vgTooltips.AddTool gra1, 0, LoadGasString(2220)            'modelo do gráfico
   vgTooltips.AddTool cboDestaca, 0, LoadGasString(2230)      'label de destaque de fatias
   vgTooltips.AddTool txtTitFundo, 0, LoadGasString(2240)     'campo do título do fundo e
   vgTooltips.AddTool txtTitGraf, 0, LoadGasString(2250)      'do título do gráfico
   vgTooltips.AddTool chkConfGraf(0), 0, LoadGasString(2260)  'ajuda para as opções de bordas,
   vgTooltips.AddTool chkConfGraf(1), 0, LoadGasString(2270)  'tonalidade pastel,
   vgTooltips.AddTool chkConfGraf(2), 0, LoadGasString(2280)  'legendas,
   vgTooltips.AddTool chkConfGraf(3), 0, LoadGasString(2290)  'monocromático e
   vgTooltips.AddTool chkConfGraf(4), 0, LoadGasString(2300)  'exibir rótulos

   'esta variável controlará o listindex da combo de tipos de gráficos para
   'ajustar seleção de gráficos com conjunto de dados semelhantes
   vgFator = 0
   vgTiposG$ = LoadGasString(2310)                            'tipos de gráfico para encher a combo

   'tira gráficos impróprios para o set selecionado
   If mdiNFE.ActiveForm.gra1.NumSets > 1 Then                 'os tres primeiros gráficos
      For i = 1 To 3                                          'só tem um set de dados, portanto, se tiver
         x$ = Parse$(vgTiposG$, "|")                          'mais de um set, vamos tirá-los
      Next
      vgFator = 3                                             'fator a somar no listindex da combo de tipos de gráficos
   End If
   While Len(vgTiposG$) > 0                                   'enche a combo de tipos de gráficos
      cboTipoGraf.AddItem Parse(vgTiposG$, "|")               'extrai cada tipo separado por |
   Wend

   vgDFatias$ = LoadGasString(2320)                           'destaque fatias de gráfico pizza
   While Len(vgDFatias$) > 0                                  'enche a combo
      cboDestaca.AddItem Parse(vgDFatias$, "|")               'com as possibilidades de destaque
   Wend
   CentraNaTela Me                                            'centraliza na tela
   PegaConfigOriginal                                         'pega as  configurações originais
   Screen.MousePointer = vbDefault                            'restaura ponteiro do mouse
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyEscape Then                 'se teclou ESC
      Unload Me                                   'tira este form da memória
   End If
End Sub

'clicou em uma opção de grade
Private Sub opcGrade_Click(Index As Integer)
   gra1.GridStyle = Index                                'aplica estilo de grade
   gra1.DrawMode = 2                                     'e força redesenho do modelo
End Sub

Private Sub Form_Unload(Cancel As Integer)
   Set vgTooltips = Nothing                       'digitou algo... Deliga ajuda
   Set frmConfGraf = Nothing                      'libera o segmento de código do form
End Sub

'se estava digitando titulo à esquerda
Private Sub txtTitEsq_LostFocus()
   If Len(txtTitEsq.Text) > 0 Then                'se há texto para o título esquerdo,
      gra1.LeftTitle = txtTitEsq.Text             'aplica no modelo
   Else                                           'senão,
      gra1.LeftTitle = ""                         'limpa
   End If
   gra1.DrawMode = 2                              'redesenha
End Sub

'se estava digitando  título de fundo
Private Sub txtTitFundo_LostFocus()
   If Len(txtTitFundo.Text) > 0 Then              'se há texto digitado,
      gra1.BottomTitle = txtTitFundo.Text         'aplica no modelo
   Else                                           'senão,
      gra1.BottomTitle = ""                       'limpa
   End If
   gra1.DrawMode = 2                              'redesenha
End Sub

'se estava digitando texto do título do gráfico
Private Sub txtTitGraf_LostFocus()
   If Len(txtTitGraf.Text) > 0 Then               'se há texto digitado
      gra1.GraphTitle = Left$(txtTitGraf.Text, 80) 'aplica
   Else                                            'senão,
      gra1.GraphTitle = ""                         'limpa
   End If
   gra1.DrawMode = 2                               'redesenha o modelo
End Sub
