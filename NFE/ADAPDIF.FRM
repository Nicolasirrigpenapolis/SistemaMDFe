VERSION 5.00
Begin VB.Form frmAdapDif
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Form1"
   ClientHeight    =   5805
   ClientLeft      =   3300
   ClientTop       =   255
   ClientWidth     =   6510
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5805
   ScaleWidth      =   6510
   ShowInTaskbar   =   0   'False
   Begin VB.CommandButton BotCria 
      Caption         =   "Cria &Nova"
      Height          =   315
      Left            =   3660
      MousePointer    =   1  'Arrow
      TabIndex        =   13
      Top             =   5280
      Width           =   975
   End
   Begin VB.PictureBox picCp
      BeginProperty Font
         name            =   "MS Sans Serif"
         size            =   8.25
         Charset         =   0
         Weight          =   700
         underline       =   0   'False
         italic          =   0   'False
         strikethrough   =   0   'False
      EndProperty
      Height          =   4395
      Left            =   60
      ScaleHeight     =   4335
      ScaleWidth      =   6285
      TabIndex        =   0
      TabStop         =   0   'False
      Top             =   720
      Visible         =   0   'False
      Width           =   6345
      Begin VB.VScrollBar scrCp
         Height          =   495
         LargeChange     =   3
         Left            =   3900
         Max             =   0
         TabIndex        =   1
         TabStop         =   0   'False
         Top             =   180
         Width           =   195
      End
      Begin VB.TextBox txtCpOrigem 
         Appearance      =   0  'Flat
         BorderStyle     =   0  'None
         Height          =   225
         Index           =   0
         Left            =   90
         TabIndex        =   12
         Top             =   660
         Width           =   2295
      End
      Begin VB.CommandButton botCp 
         Caption         =   ".."
         Height          =   255
         Left            =   3600
         TabIndex        =   2
         TabStop         =   0   'False
         Top             =   240
         Visible         =   0   'False
         Width           =   255
      End
      Begin VB.Label labCpDestino
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         ForeColor       =   &H80000008&
         Height          =   255
         Index           =   0
         Left            =   120
         TabIndex        =   5
         Top             =   360
         Width           =   555
      End
      Begin VB.Label labTitCp
         Appearance      =   0  'Flat
         Caption         =   "Tabela anterior"
         BeginProperty Font
            name            =   "MS Sans Serif"
            size            =   8.25
            Charset         =   0
            Weight          =   700
            underline       =   0   'False
            italic          =   0   'False
            strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000E&
         Height          =   195
         Index           =   1
         Left            =   2880
         TabIndex        =   4
         Top             =   840
         Width           =   795
      End
      Begin VB.Label labTitCp
         Appearance      =   0  'Flat
         Caption         =   "Tabela atual"
         BeginProperty Font
            name            =   "MS Sans Serif"
            size            =   8.25
            Charset         =   0
            Weight          =   700
            underline       =   0   'False
            italic          =   0   'False
            strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000E&
         Height          =   195
         Index           =   0
         Left            =   2640
         TabIndex        =   3
         Top             =   540
         Width           =   1215
      End
      Begin VB.Line linCp
         Index           =   0
         X1              =   3480
         X2              =   3480
         Y1              =   240
         Y2              =   540
      End
   End
   Begin VB.ListBox lstTabelas
      Height          =   4350
      Left            =   60
      TabIndex        =   10
      Top             =   720
      Width           =   6315
   End
   Begin VB.CommandButton botLimpa
      Height          =   315
      Left            =   420
      TabIndex        =   12
      Top             =   5280
      Width           =   975
      Caption         =   "&Limpa"
      Enabled         =   0   'False
      mousepointer    =   1
   End
   Begin VB.Label labMsg
      Alignment       =   2  'Center
      Height          =   615
      Left            =   120
      TabIndex        =   9
      Top             =   60
      Width           =   6285
      WordWrap        =   -1  'True
   End
   Begin VB.CommandButton botIgnora
      Height          =   315
      Left            =   2580
      TabIndex        =   8
      Top             =   5280
      Width           =   975
      Caption         =   "&Ignora"
      Visible         =   0   'False
   End
   Begin VB.CommandButton botOk
      Height          =   315
      Left            =   4740
      TabIndex        =   6
      Top             =   5280
      Width           =   975
      Caption         =   "&Prossegue"
      Enabled         =   0   'False
   End
   Begin VB.CommandButton botCancela
      Height          =   315
      Left            =   1500
      TabIndex        =   7
      Top             =   5280
      Width           =   975
      Caption         =   "&Cancela  "
      mousepointer    =   1
   End
End
Attribute VB_Name = "frmAdapDif"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
'* Sistema...: Emissor de MDF-e (Layout 3.00)
'* Empresa...: Ygor Eduardo Dellalio
'* Módulo....: ADAPDIF
'* Função....: Relaciona campos origem-destino
'* CopyRight.: (C)2023 Ygor Eduardo Dellalio
'* Criação...: GAS-2007 - Gerador Automático de Sistemas
'* Data......: 01/09/2023 10:21:36
'* * * * * * *

Option Explicit                                   'variáveis devem ser declaradas
DefInt A-Z                                        'e por default todas seram inteiras

Dim vgFazerOq As Integer
Dim vgPriVez As Integer                           'flag do que o form vai apresentar

Private Sub botCancela_Click()
   vgCancelou = True                              'flag - cancelado
   Unload Me                                      'retira o form da memório e retorna
End Sub

Private Sub botCp_Click()
   Load frmAdapCps                                'quer trocar o campo origem
   frmAdapCps.Show vbModal                        'apresenta o form para escolha
End Sub

Private Sub BotCria_Click()
   vgTabAdap$ = ""                                   'seta tabela não será adaptada
   vgAcao = ACAO_CRIA
   Unload Me                                         'descarrega o form de relacao dos campos
End Sub

Private Sub botIgnora_Click()
   vgTabAdap$ = ""                                'seta tabela não será adaptada
   vgAcao = ACAO_IGNORA
   Unload Me                                      'descarrega o form de relacao dos campos
End Sub

Private Sub botLimpa_Click()
   txtCpOrigem(vgQualScrCp).Text = ""             'limpa relacao dos cps
End Sub

Private Sub botOk_Click()
   If vgFazerOq = PEGA_TABELA Then                'se esta escolhendo a tabela
      vgTabAdap$ = lstTabelas.Text                'vamos pegar seu nome
   End If
   vgAcao = ACAO_PROSSEGUE
   Unload Me                                      'descarrega o form para continuar...
End Sub

Private Sub Form_Unload(Cancel As Integer)
   Unload frmAdapCps                              'descarrega form de escolha de campos
   Set frmAdapDif = Nothing                       'destroi este formulário
End Sub

Private Sub lstTabelas_Click()
   botOk.Enabled = True                           'habilita botao de ok se escolheu uma tabela
End Sub

Private Sub scrCp_Change()
   If Not vgPriVez Then                           'se clicou realmente no scroll
      ListaCp                                     'altera campos do grid
   End If
End Sub

Private Sub ListaCp()                             'lista cps no grid
   Dim i As Integer, j As Integer, vgPV As Integer
   vgPV = vgPriVez                                'salva estado original da flag
   vgPriVez = True                                'evita recursividade
   For i = 0 To scrCp.LargeChange                 'corre todos controles do grid
      j = i + scrCp.Value                         'calcula relacao com vetor q armazena conteudo
      If j > scrCp.Max Then                       'esta fora do grid...
         labCpDestino(i).Caption = ""             'limpa controles
         txtCpOrigem(i).Text = ""                 'da linha atual e
         labCpDestino(i).Enabled = False          'os desabilita
         txtCpOrigem(i).Enabled = False
      ElseIf j > -1 Then                          'ok mostra campos no grid
         labCpDestino(i).Caption = " " + vgCpDestino$(j)
         txtCpOrigem(i).Text = vgCpOrigem$(j)
         txtCpOrigem(i).Enabled = True            'habilita os controles
         labCpDestino(i).Enabled = True
      End If
   Next
   If vgQualScrCp <> vgQualCp - scrCp.Value Then
      DesmarcaItemCp                              'desmarca o item selecionado
      SelecionaItemCp                             'e marca novamente
   End If
   vgPriVez = vgPV                                'restabelece situacao da flag
End Sub

Private Sub DesmarcaItemCp()
   If vgQualScrCp > -1 And vgQualCp > -1 Then                    'se tem um item marcado
      txtCpOrigem(vgQualScrCp).Width = txtCpOrigem(vgQualScrCp).Width + botCp.Width
      labCpDestino(vgQualScrCp).BackColor = vbWindowBackground   'vamos trocar as corres dos
      labCpDestino(vgQualScrCp).ForeColor = vbWindowText         'controles para ficar
      botCp.ZOrder 1                                             'coloca botao de escolha de cps para baixo
      botCp.Visible = False                                      'e o torna invisível
   End If
   vgQualScrCp = -1                                              'flag, nehum campo selecionado
End Sub

Private Sub SelecionaItemCp()                     'seleciona campo
   Dim i As Integer
   botLimpa.Enabled = True                        'habilita botao para limpar o campo
   i = vgQualCp - scrCp.Value                     'item do grid que deve ser marcado
   If i >= 0 And i <= scrCp.LargeChange Then      'se esta dentro da faixa do grid
      vgQualScrCp = i                             'seta qual item vai ser marcado
      labCpDestino(i).BackColor = vbHighlight     'e troca as cores dos controles
      labCpDestino(i).ForeColor = vbHighlightText 'para diferenciar dos demais
      botCp.Top = txtCpOrigem(i).Top              'ajusta coordenadas do botao de escolha de cps
      botCp.Left = txtCpOrigem(i).Left + txtCpOrigem(i).Width - botCp.Width
      botCp.Visible = True                        'torna ele visível
      botCp.ZOrder 0                              'e coloca em cima dos outros controles
      txtCpOrigem(i).Width = txtCpOrigem(i).Width - botCp.Width
      On Error Resume Next
      txtCpOrigem(i).SetFocus
   Else                                           'item escolhido esta fora do grid
      vgQualScrCp = -1                            'flag, nemhum item selecionado
   End If
End Sub

Private Sub txtCpOrigem_Change(Index As Integer)
   If vgPriVez Then Exit Sub
   vgCpOrigem$(vgQualCp) = txtCpOrigem(Index).Text
End Sub

Private Sub txtCpOrigem_Click(Index As Integer)
   If Not vgPriVez Then                           'evita recursividade
      If Index + scrCp.Value <> vgQualCp Then     'se clicou em cima de um cp diferente do já selecionado
         labCpDestino_Click Index                 'força a seleção deste novo campo
      End If
   End If
End Sub

Private Sub labCpDestino_Click(Index As Integer)
   If Len(labCpDestino(Index).Caption) > 0 Then   'se tem campo para selecionar
      DesmarcaItemCp                              'desmarca item anterior
      vgQualCp = Index + scrCp.Value              'item atualmente selecionado
      SelecionaItemCp                             'seleciona o novo item
   End If
End Sub

Private Sub Form_Load()
   Dim i As Integer
   vgPriVez = True

   'monta grid dos campos da tabela
   picCp.BackColor = vbWindowBackground           'troca cor da pic para parecer grid
   scrCp.Top = 0                                  'ajusta scroll a direita
   scrCp.Left = picCp.Width - scrCp.Width - 60    'da picture
   scrCp.Height = picCp.Height - 60

   labTitCp(0).Left = -15                         'titulo esquedo do gride
   labTitCp(0).Top = -15                          'ajusta posicao e tamanho
   labTitCp(0).Width = picCp.Width - txtCpOrigem(0).Width - scrCp.Width - (linCp(0).BorderWidth * Screen.TwipsPerPixelX) - 45

   linCp(0).X1 = labTitCp(0).Left + labTitCp(0).Width
   linCp(0).X2 = linCp(0).X1                      'linha de separacao entre os
   linCp(0).Y1 = 0                                'campos (colunas) e ajusta
   linCp(0).Y2 = picCp.Height                     'posicao e tamanho

   Load linCp(1)                                  'cria outra linha
   linCp(1).X1 = 0                                'agora para separar
   linCp(1).X2 = picCp.Width - scrCp.Width        'cada linha do grid
   linCp(1).Y1 = labTitCp(0).Top + labTitCp(0).Height
   linCp(1).Y2 = linCp(1).Y1                      'ajusta posicao e tamanho
   linCp(1).Visible = True                        'torna a linha visível

   labCpDestino(0).Left = labTitCp(0).Left        'primeiro campo do lado
   labCpDestino(0).Top = labTitCp(0).Height       'esquerdo
   labCpDestino(0).Width = labTitCp(0).Width

   labTitCp(1).Left = linCp(0).X1 + (linCp(0).BorderWidth * Screen.TwipsPerPixelX)
   labTitCp(1).Top = labTitCp(0).Top
   labTitCp(1).Width = txtCpOrigem(0).Width       'titulo do lado direito
   txtCpOrigem(0).Left = labTitCp(1).Left
   txtCpOrigem(0).Top = labCpDestino(0).Top

   'numero maximo de item que cabem no grid
   scrCp.LargeChange = Int(picCp.Height / labCpDestino(0).Height) - 1
   vgQualCp = -1                                  'flag qual campo selecionado
   vgQualScrCp = -1                               'falg qual controle selecionado
   For i = 1 To scrCp.LargeChange                 'enche os outras linhas do grid
      Load linCp(i + 1)                           'cria nova linha
      linCp(i + 1).X1 = 0
      linCp(i + 1).X2 = picCp.Width - scrCp.Width
      linCp(i + 1).Y1 = labCpDestino(i - 1).Top + labCpDestino(i - 1).Height
      linCp(i + 1).Y2 = linCp(i + 1).Y1
      linCp(i + 1).Visible = True
      Load labCpDestino(i)                        'cria novo campo do lado esquerdo
      labCpDestino(i).Top = labCpDestino(i - 1).Top + labCpDestino(i - 1).Height + (linCp(i).BorderWidth * Screen.TwipsPerPixelX)
      labCpDestino(i).Visible = True
      labCpDestino(i).ZOrder 0
      labCpDestino(i).Refresh
      Load txtCpOrigem(i)                         'cria novo campo do lado direito
      txtCpOrigem(i).Top = labCpDestino(i).Top
      txtCpOrigem(i).Visible = True
   Next
   vgPriVez = False
End Sub

Public Sub IniciaForm(vgOq As Integer)            'inicia apresentacao do form
   Dim i As Integer
   Left = frmAdapta.Left + 1000                   'ajusta sua posicao na tela
   Top = frmAdapta.Top + 1000
   vgFazerOq = vgOq                               'flag, o que o form vai fazer
   picCp.Visible = (vgFazerOq <> PEGA_TABELA)     'liga ou desliga controles
   lstTabelas.Visible = (vgFazerOq = PEGA_TABELA) 'de acordo com o que form vai fazer
   If vgFazerOq = PEGA_CAMPOS Then                'vai mostrar grid de campos
      Load frmAdapCps                             'carrega form de escolha de cps
      Caption = "CAMPOS a adaptar"                'titulo do form
      botOk.Enabled = True                        'habilita botao de OK
      DesmarcaItemCp                              'desmarca item selecionado se houver
      picCp.Enabled = (vgNumCps > -1)             'se tem cps habilita movimentacao no grid
      scrCp.Enabled = picCp.Enabled
      scrCp.Max = vgNumCps
      vgQualCp = -1                               'campo selecionado
      ListaCp                                     'mostra campos no grid
   Else                                           'vai escolher tabela
      Caption = "TABELA a adaptar"                'título do form
   End If
   CentraNaTela Me
   BotIgnora.Visible = True
End Sub
