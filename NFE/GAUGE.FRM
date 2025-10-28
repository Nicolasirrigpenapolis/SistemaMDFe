VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form frmGauge
   BorderStyle     =   1  'Fixed Single
   ClientHeight    =   735
   ClientLeft      =   2430
   ClientTop       =   3060
   ClientWidth     =   4395
   ControlBox      =   0   'False
   Height          =   1140
   KeyPreview      =   -1  'True
   Left            =   2370
   LinkTopic       =   "frmGauge"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   735
   ScaleWidth      =   4395
   Top             =   2715
   Width           =   4515
   Begin NFE.GPainel pan1
      Align           =   1  'Align Top
      Height          =   600
      Left            =   0
      Top             =   0
      Width           =   4395
      _ExtentX        =   0
      _ExtentX        =   0
      bevelinner      =   1
      borderwidth     =   0
      Begin MSComctlLib.ProgressBar pgb1
         Height          =   285
         Left            =   90
         TabIndex        =   4
         Top             =   180
         Visible         =   0   'False
         Width           =   3525
         _ExtentX        =   6218
         _ExtentY        =   503
         _Version        =   327682
         Appearance      =   0
      End
      Begin NFE.GBotao BotCancela
         Height          =   450
         Left            =   3810
         TabIndex        =   0
         TabStop         =   0   'False
         Top             =   90
         Visible         =   0   'False
         Width           =   450
         ForeColor       =   -2147483640
         mousepointer    =   1
      End
   End
End
Attribute VB_Name = "frmGauge"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
'* Sistema...: Emissor de MDF-e (Layout 3.00)
'* Empresa...: Ygor Eduardo Dellalio
'* Módulo....: frmGauge
'* Função....: Apresenta barra de progressão
'* CopyRight.: (C)2024 Ygor Eduardo Dellalio
'* Criação...: GAS-2007 - Gerador Automático de Sistemas
'* Data......: 05/09/2024 18:10:18
'* * * * * * *

Option Explicit                                   'variáveis devem ser explicitamente declaradas
DefInt A-Z                                        'inteiras por default

Const W_HPARENT = -8                              'constante para API SetWindowsWord

Public vgCaracteristica As Integer                'esta variável todo form tem de ter
Public vgFrmOrigem As Form                        'vai ser designada por outros forms que chamarem este
Public vgQuerCancelar As Integer                  'flag - botão cancelar clicado
Public vgFormID As Long                           'identificacao do form
Public vgTooltips As New cTooltips

'mostra painel de progressao ou diálogo de totalização da consulta
Public Sub MostraGauge(Optional ByVal vgTit As String)
   On Error Resume Next
   PrepBotoes vgFrmOrigem, ACAO_EM_PROGRESSO         'ajusta os botões de acordo
   CentraNaTela Me                                   'centra este form na tela
   pgb1.Value = 0                                    'zera o painel de progressão
   pgb1.Visible = True                               'e o torna visível
   botCancela.Visible = True                         'deste precisamos para cancelar,
   If IsMissing(vgTit$) Then vgTit$ = ""
   If Len(vgTit$) = 0 Then                           'se não passou um título extra
      vgTit$ = mdiNFE.ActiveForm.Caption             'pega título do form
      If Err Then                                    'se deu erro
         Err.Clear                                   'reseta erro
         vgTit$ = ""                                 'não tem form ativo
      End If
   End If
   Caption = LoadGasString(10040) + vgTit$           'põe neste form
   Show
   Call SetWindowWord(hWnd, W_HPARENT, mdiNFE.hWnd)  'força ficar no topo do form MDI
End Sub

'imprime a consulta...
Private Sub ImprimeConsulta(F As Form, vgTotalizar As String)
   Dim vgPg As Integer, p As String, x As String, vgCb As String, i As Integer, vgLinha As String, _
       vgQReg As Long, j As Integer, vgQdT As Integer, vgColInic As Integer, _
       vgColFinal As Integer, vgCpT As String, vgAltCabec As Integer, _
       vgLinhasPag As Integer, vgTbCopia As GRecordSet
   Dim vgLarg() As Integer                           'largura a considerar nas colunas
   Dim vgTotal() As Variant                          'vetor de totais das colunas...

   GeraLogAcao LoadGasString(292) + " " + F.Caption
   i = F.dbgBrowse.SelStartCol                       'coluna inicial da impressão
   vgColInic = IIf(i < 0, 0, i)                      'se -1, nada está selecionado... inicia em 0
   If F.dbgBrowse.SelEndCol < 0 Then                 'se tem coluna marcada
      vgColFinal = F.dbgBrowse.Cols - 1              'pega qual é a última
   Else                                              'se não
      vgColFinal = F.dbgBrowse.SelEndCol             'vamos imprimir todas
   End If
   ReDim vgTotal(vgColFinal)
   With Printer
      .FontName = "Courier New"                      'vamos usar fonte mono-espacejada
      .FontSize = 8.25                               'tamanho da fonte
   End With
   vgPg = 0                                          'numeração de página
   vgQdT = 0                                         'qde total de reg listados
   Set vgTbCopia = F.vgTb.Clone()                    'faz uma cópia da tabela
   vgTbCopia.Index = F.vgTb.Index                    'coloca o mesmo indice da original
   vgCb$ = ""                                        'linha do cabeçalho
   With vgTbCopia.Table                              'trabalhando com a cópia...
      For i = vgColInic To vgColFinal                'so na faixa selecionada da grade
         ReDim Preserve vgLarg(i)                    'largura da coluna
         If F.dbgBrowse.Columns(i).Visible Then      'se a coluna está visível
            vgCpT$ = F.dbgBrowse.DataField(i)        'nome do campo da coluna
            Select Case .Columns(vgCpT$).ColumnType  'através do tipo do campo vamos
               Case TP_CARACTER                      'definir a sua largura
                  vgLarg(i) = .Columns(vgCpT$).Size  'texto... pega seu própio tamanho
                  If vgLarg(i) = 0 Then vgLarg(i) = 10 'se não conseguiu 10 será o default
               Case TP_MEMO
                  vgLarg(i) = 30                       'memo... fixa em 30 posicões
               Case Else
                  vgLarg(i) = 10                       'numérico, data, etc... 10 posições
            End Select
            p$ = Left$(vgCpT$, vgLarg(i))              'trunca o título da coluna
            If .Columns(vgCpT$).ColumnType = TP_NUMERICO Then 'campos numéricos vamos ajustar
               p$ = LPad$(p$, vgLarg(i), " ")                 'os títulos pela direita
            Else
               p$ = RPad$(p$, vgLarg(i), " ")                 'o resto pela esquerda
            End If
            vgCb$ = vgCb$ + p$ + " "                          'concatena na linha de cabeçalho
         End If
      Next
   End With                                       'fim da referência pela cópia
   GoSub ImprimeCabecalho                         'imprime cabeçalho
   vgQReg = 0                                     'zera qde de reg impressos
   Set vgFrmOrigem = F                            'sincroniza os dois forms
   MostraGauge                                    'apressenta o gauge
   If F.dbgBrowse.SelBookmarks.count > 0 Then     'se tem registros selecionados
      For i = 0 To F.dbgBrowse.SelBookmarks.count - 1 'vamos trabalhar com
         vgTbCopia.BookMark = F.dbgBrowse.SelBookmarks(i) 'a coleção de bookmarks e
         GoSub ImprimeLinha                               'imprimir só eles
      Next
   Else                                           'sem registro selecionados...
      vgTbCopia.MoveFirst                         'vamos listar todos
      While Not vgTbCopia.EOF And _
            vgQuerCancelar = False                'até chegar o fim de arq ou ter cancelado
         GoSub ImprimeLinha                       'imprime o registro
         vgTbCopia.MoveNext                       'próximo...
      Wend
   End If
   If vgQuerCancelar Then                         'cancelou a impressão
      Printer.KillDoc                             'retira o documento do spooler
   Else                                           'impressão OK! vamos totalizar
      If Len(vgTotalizar$) > 0 Then               'há colunas para totalizar,
         'testa se as linhas de totalizações irão caber na página
         If vgAltCabec + ((vgLinhasPag + 6) * TextHeight(vgLinha$)) > Printer.ScaleHeight Then
            GoSub ImprimeCabecalho                'não cabem, imprime o cabeçalho
         End If
         vgLinha$ = ""                            'inicia a montagem da linha de totais
         For j = vgColInic To vgColFinal          'para cada coluna,
            If F.dbgBrowse.Columns(j).Visible Then 'se esta coluna estiver visível na grade e
               x$ = Mid$(Str$(j + 1000), 3) + "|"  'se isto
               If InStr(vgTotalizar$, x$) Then     'estiver dentro de vgTotalizar$,
                  p$ = LPad$((vgTotal(j)), vgLarg(j), " ") 'monta
               Else                                        'senão,
                  p$ = Space$(vgLarg(j))                   'coloca brancos...
               End If
               vgLinha$ = vgLinha$ + p$ + " "              'e vai montando a linha de totais
            End If
         Next
         Printer.FontBold = True                           'totais em negrito
         Printer.Print                                     'pula uma linha
         Printer.Print vgLinha$                            'imprime totais
         Printer.FontBold = False                          'retira o negrito
         Printer.Print                                     'pula outra linha
      End If
      Printer.Print                                        'imprime a qde de reg impressos
      Printer.Print LoadGasString(1550) & vgQReg & LoadGasString(1560)
      Printer.NewPage                                      'fim da impressãp
      Printer.EndDoc                                       'descarrega gerenciador de impressão
   End If

SaiImp:
   Set vgTbCopia = Nothing                                 'libera o segmento da memória
   Unload Me                                               'descarrega o form de gauge
   Exit Sub

ImprimeLinha:                                              'monta a linha a ser impressa
   With vgTbCopia
      vgLinha$ = ""                                        'linha com os campos a imprimir
      For j = vgColInic To vgColFinal                      'pega toda a faixa selecionada
         If F.dbgBrowse.Columns(j).Visible Then            'coluna esta visível?
            vgCpT$ = F.dbgBrowse.DataField(j)              'nome do campo a imprimir
            If IsNull(.Fields(vgCpT$).Value) Then          'se o valor é nulo
               p$ = ""                                     'imprime branco
            Else                                           'se não
               p$ = .Fields(vgCpT$).Value                  'pega o valor do campo
            End If
            If F.dbgBrowse.DataType(j) = 5 And _
               Len(p$) > 0 Then                            'tira CR LF do memo
               p$ = Substitui$(Left$(p$, 30), vbCrLf, "  ", UM_A_UM)
            End If
            If F.dbgBrowse.DataType(j) = 1 Or F.dbgBrowse.DataType(j) = 9 Then 'campo numérico
               p$ = LPad$(p$, vgLarg(j), " ")                                  'alinha direita
            Else                                  'o restante
               p$ = RPad$(p$, vgLarg(j), " ")     'à esquerda
            End If
            vgLinha$ = vgLinha$ + p$ + " "        'incrementa linha de impressão
            x$ = Mid$(Str$(j + 1000), 3) + "|"    'coluna atual
            If InStr(vgTotalizar$, x$) Then       'é para totalizar?
               vgTotal(j) = vgTotal(j) + ValBrasil(p$) 'soma...
            End If
         End If
      Next
      vgQReg = vgQReg + 1                              'soma qde reg impressos
      vgLinhasPag = vgLinhasPag + 1                    'e linhas nesta página
      pgb1.Value = vgQReg * 100 / .RecordCount         'atualiza gauge
      Printer.Print vgLinha$                           'imprime linha detalhe...
   End With

   If vgAltCabec + (vgLinhasPag * TextHeight(vgLinha$)) > Printer.ScaleHeight Then
      GoSub ImprimeCabecalho                           'chegou ao final da página...
   End If
   DoEvents                                            'deixa os outros trabalharem...
   Return                                              'volta para quem chamou...

ImprimeCabecalho:                                      'imprime o cabeçalho da consulta
   vgPg = vgPg + 1
   If vgPg > 1 Then Printer.NewPage                    'se não for a 1a página, salta folha
   p$ = LoadGasString(1570) + Mid$(Str$(vgPg), 2)      'monta a msg da página
   Printer.FontBold = True                             'cabeçalho em negrito
   Printer.CurrentX = Printer.ScaleWidth - Printer.TextWidth(p$) - 120 'posiciona no canto superior direito
   Printer.Print p$                               'e imprime pg
   vgAltCabec = TextHeight(p$)                    'vamos calcular a altura do cabeçalho...
   Printer.FontSize = 12                          'titulo com fonte maior
   Printer.Print UCase$(F.Caption)                'imprime título - usamos título deste form
   Printer.Print                                  'salta uma linha
   vgAltCabec = vgAltCabec + (2 * TextHeight(F.Caption)) 'acumula a altura dessas duas linhas
   Printer.FontSize = 8.25                               'retorna fonte do corpo do relatório
   Printer.Print vgCb$                                   'imprime títulos das colunas
   vgAltCabec = vgAltCabec + TextHeight(vgCb$)           'acumula esta altura...
   Printer.FontBold = False                              'retira negrito
   vgLinhasPag = 0                                       'zera contador de linhas impressas na página
   Return                                                'continua a impressão...

End Sub

'carga do form
Private Sub Form_Load()
   vgCaracteristica = F_COMUM                            'designa sua característica
   vgFormID = 16                                         'identificacao do form
   vgTooltips.Create
   vgTooltips.AddTool botCancela, 0, LoadGasString(10000) 'ajuda para o botão cancela,
   Set botCancela.Picture = LoadPicture(LoadGasPicture(661)) 'carrega ícone no botão de cancelar e
   On Error Resume Next                                      'previne um possivel erro
   Caption = mdiNFE.ActiveForm.Caption                       'e iguala título ao título do form chamador...
End Sub

'vai ser descarregado, vamos manipular...
Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)
   Call SetWindowWord(hWnd, W_HPARENT, 0)            'desativa condição sempre em cima...
   PrepBotoes vgFrmOrigem, ACAO_NAVEGANDO            'e ajusta botões para a nova situação
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyEscape Then                    'se teclou ESC
      vgQuerCancelar = True                          'cancela processamentos
      Unload Me                                      'tira este form da memória
   End If
End Sub

Private Sub Form_Unload(Cancel As Integer)
   Set vgTooltips = Nothing
   Set frmGauge = Nothing                         'libera o segmento de código do form
End Sub

'cancela operações diversas
Private Sub botCancela_Click()
   vgQuerCancelar = True                             'liga flag de cancelar - a rotina em operação irá testar...
End Sub
