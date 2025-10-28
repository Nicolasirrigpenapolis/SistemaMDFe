VERSION 5.00
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "Tabctl32.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.1#0"; "Mscomctl.ocx"
Begin VB.Form frmSenhas 
   AutoRedraw      =   -1  'True
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Manutenção de SENHAS"
   ClientHeight    =   6300
   ClientLeft      =   2670
   ClientTop       =   2565
   ClientWidth     =   8295
   ClipControls    =   0   'False
   KeyPreview      =   -1  'True
   LinkTopic       =   "26617"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   6300
   ScaleWidth      =   8295
   ShowInTaskbar   =   0   'False
   Begin VB.Frame fraGrupos 
      Caption         =   "Grupos"
      Height          =   6075
      Left            =   0
      TabIndex        =   12
      Top             =   0
      Width           =   8115
      Begin NFE.GBotao botGrava 
         Height          =   450
         Left            =   6510
         TabIndex        =   9
         Top             =   5550
         Width           =   450
         _ExtentX        =   0
         _ExtentY        =   0
         ForeColor       =   -2147483640
         Enabled         =   0   'False
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin NFE.GBotao botCancela 
         Height          =   450
         Left            =   6990
         TabIndex        =   10
         Top             =   5550
         Width           =   450
         _ExtentX        =   0
         _ExtentY        =   0
         ForeColor       =   -2147483640
         Enabled         =   0   'False
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin NFE.GBotao botAdiciona 
         Height          =   450
         Left            =   5550
         TabIndex        =   7
         Top             =   5550
         Width           =   450
         _ExtentX        =   0
         _ExtentY        =   0
         ForeColor       =   -2147483640
         Enabled         =   0   'False
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin NFE.GBotao botRemove 
         Height          =   450
         Left            =   6030
         TabIndex        =   8
         Top             =   5550
         Width           =   450
         _ExtentX        =   0
         _ExtentY        =   0
         ForeColor       =   -2147483640
         Enabled         =   0   'False
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin NFE.GBotao botRetorna 
         Height          =   450
         Left            =   7470
         TabIndex        =   11
         Top             =   5550
         Width           =   450
         _ExtentX        =   0
         _ExtentY        =   0
         ForeColor       =   -2147483640
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin VB.TextBox cpNovoGrupo 
         Height          =   315
         Left            =   120
         MaxLength       =   25
         TabIndex        =   13
         Top             =   5610
         Width           =   3045
      End
      Begin TabDlg.SSTab tabPermis 
         Height          =   5235
         Left            =   3360
         TabIndex        =   14
         Top             =   240
         Width           =   4575
         _ExtentX        =   8070
         _ExtentY        =   9234
         _Version        =   393216
         Style           =   1
         Tab             =   2
         TabHeight       =   520
         TabCaption(0)   =   "Usuários"
         Tab(0).ControlEnabled=   0   'False
         Tab(0).Control(0)=   "txtCampo(1)"
         Tab(0).Control(1)=   "cboGrupos"
         Tab(0).Control(2)=   "txtCampo(0)"
         Tab(0).Control(3)=   "txtCampo(2)"
         Tab(0).Control(4)=   "txtCampo(3)"
         Tab(0).Control(5)=   "txtCampo(4)"
         Tab(0).Control(6)=   "labSenha(1)"
         Tab(0).Control(7)=   "labSenha(0)"
         Tab(0).Control(8)=   "labGrupo(4)"
         Tab(0).Control(9)=   "labSenha(2)"
         Tab(0).Control(10)=   "labSenha(3)"
         Tab(0).Control(11)=   "labSenha(4)"
         Tab(0).ControlCount=   12
         TabCaption(1)   =   "Menus"
         Tab(1).ControlEnabled=   0   'False
         Tab(1).Control(0)=   "trvMenu"
         Tab(1).ControlCount=   1
         TabCaption(2)   =   "Tabelas"
         Tab(2).ControlEnabled=   -1  'True
         Tab(2).Control(0)=   "trvEstrutura"
         Tab(2).Control(0).Enabled=   0   'False
         Tab(2).Control(1)=   "chkPermis(0)"
         Tab(2).Control(1).Enabled=   0   'False
         Tab(2).Control(2)=   "chkPermis(1)"
         Tab(2).Control(2).Enabled=   0   'False
         Tab(2).Control(3)=   "chkPermis(2)"
         Tab(2).Control(3).Enabled=   0   'False
         Tab(2).Control(4)=   "chkPermis(3)"
         Tab(2).Control(4).Enabled=   0   'False
         Tab(2).ControlCount=   5
         Begin VB.TextBox txtCampo 
            Height          =   315
            IMEMode         =   3  'DISABLE
            Index           =   1
            Left            =   -74880
            MaxLength       =   25
            PasswordChar    =   "*"
            TabIndex        =   3
            Top             =   1920
            Width           =   4260
         End
         Begin VB.ComboBox cboGrupos 
            Height          =   315
            Left            =   -74880
            Style           =   2  'Dropdown List
            TabIndex        =   1
            Top             =   600
            Width           =   4245
         End
         Begin VB.TextBox txtCampo 
            Height          =   315
            Index           =   0
            Left            =   -74880
            MaxLength       =   25
            TabIndex        =   2
            Top             =   1260
            Width           =   4245
         End
         Begin VB.TextBox txtCampo 
            Height          =   315
            IMEMode         =   3  'DISABLE
            Index           =   2
            Left            =   -74880
            MaxLength       =   25
            PasswordChar    =   "*"
            TabIndex        =   4
            Top             =   2535
            Width           =   4245
         End
         Begin VB.TextBox txtCampo 
            Height          =   315
            IMEMode         =   3  'DISABLE
            Index           =   3
            Left            =   -74880
            MaxLength       =   25
            PasswordChar    =   "*"
            TabIndex        =   5
            Top             =   3195
            Width           =   4245
         End
         Begin VB.TextBox txtCampo 
            Height          =   315
            Index           =   4
            Left            =   -74880
            MaxLength       =   25
            TabIndex        =   6
            Top             =   3870
            Width           =   4245
         End
         Begin VB.CheckBox chkPermis 
            Caption         =   "Exclui"
            Height          =   255
            Index           =   3
            Left            =   3600
            TabIndex        =   18
            Top             =   4920
            Width           =   915
         End
         Begin VB.CheckBox chkPermis 
            Caption         =   "Modifica"
            Height          =   255
            Index           =   2
            Left            =   2550
            TabIndex        =   17
            Top             =   4920
            Width           =   915
         End
         Begin VB.CheckBox chkPermis 
            Caption         =   "Inclui"
            Height          =   255
            Index           =   1
            Left            =   1560
            TabIndex        =   16
            Top             =   4920
            Width           =   915
         End
         Begin VB.CheckBox chkPermis 
            Caption         =   "Visualiza"
            Height          =   255
            Index           =   0
            Left            =   390
            TabIndex        =   15
            Top             =   4920
            Width           =   915
         End
         Begin MSComctlLib.TreeView trvMenu 
            Height          =   4605
            Left            =   -74880
            TabIndex        =   20
            Top             =   480
            Width           =   4335
            _ExtentX        =   7646
            _ExtentY        =   8123
            _Version        =   393217
            HideSelection   =   0   'False
            Indentation     =   529
            LabelEdit       =   1
            Style           =   4
            Checkboxes      =   -1  'True
            Appearance      =   1
         End
         Begin MSComctlLib.TreeView trvEstrutura 
            Height          =   4335
            Left            =   120
            TabIndex        =   27
            Top             =   480
            Width           =   4335
            _ExtentX        =   7646
            _ExtentY        =   7646
            _Version        =   393217
            HideSelection   =   0   'False
            Indentation     =   529
            LabelEdit       =   1
            LineStyle       =   1
            Style           =   6
            FullRowSelect   =   -1  'True
            Appearance      =   1
         End
         Begin VB.Label labSenha 
            AutoSize        =   -1  'True
            Caption         =   "Senha anterior"
            Height          =   195
            Index           =   1
            Left            =   -74880
            TabIndex        =   26
            Top             =   1680
            Width           =   1050
         End
         Begin VB.Label labSenha 
            AutoSize        =   -1  'True
            Caption         =   "Usuário"
            Height          =   195
            Index           =   0
            Left            =   -74880
            TabIndex        =   25
            Top             =   960
            Width           =   975
         End
         Begin VB.Label labGrupo 
            AutoSize        =   -1  'True
            Caption         =   "Grupos"
            Height          =   195
            Index           =   4
            Left            =   -74880
            TabIndex        =   24
            Top             =   360
            Width           =   510
         End
         Begin VB.Label labSenha 
            AutoSize        =   -1  'True
            Caption         =   "Senha"
            Enabled         =   0   'False
            Height          =   195
            Index           =   2
            Left            =   -74880
            TabIndex        =   23
            Top             =   2295
            Width           =   465
         End
         Begin VB.Label labSenha 
            AutoSize        =   -1  'True
            Caption         =   "Redigite senha"
            Enabled         =   0   'False
            Height          =   195
            Index           =   3
            Left            =   -74880
            TabIndex        =   22
            Top             =   2955
            Width           =   1065
         End
         Begin VB.Label labSenha 
            AutoSize        =   -1  'True
            Caption         =   "Observações"
            Enabled         =   0   'False
            Height          =   195
            Index           =   4
            Left            =   -74880
            TabIndex        =   21
            Top             =   3630
            Width           =   1785
         End
      End
      Begin MSComctlLib.TreeView trvUsuarios 
         Height          =   5085
         Left            =   120
         TabIndex        =   0
         Top             =   240
         Width           =   3135
         _ExtentX        =   5530
         _ExtentY        =   8969
         _Version        =   393217
         HideSelection   =   0   'False
         Indentation     =   529
         LabelEdit       =   1
         Style           =   6
         FullRowSelect   =   -1  'True
         HotTracking     =   -1  'True
         Appearance      =   1
         OLEDragMode     =   1
         OLEDropMode     =   1
      End
      Begin VB.Label lblNovoGrupo 
         AutoSize        =   -1  'True
         Caption         =   "Novo grupo"
         Height          =   195
         Left            =   120
         TabIndex        =   19
         Top             =   5370
         Width           =   840
      End
   End
End
Attribute VB_Name = "frmSenhas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'* Sistema...: Emissor de Nota Fiscal Eletronica
'* Empresa...: Ygor Eduardo Dellalio
'* Módulo....: frmSenhas
'* Função....: Manutenção de senhas
'* CopyRight.: (C)2016 Ygor Eduardo Dellalio
'* Criação...: GAS-2007 - Gerador Automático de Sistemas
'* Data......: 11/05/2016 16:55:57
'* * * * * * *

Option Explicit                                   'requer declaração de variáveis
DefInt A-Z                                        'todas inteiras, por default

Private blnDragging As Boolean                    'arrastar itens pela treeview

Public vgSituacao As Integer, vgCaracteristica As Integer, _
                     vgTipo As Integer, vgFormID As Long   'todo form tem de ter...
Public vgTooltips As New cTooltips

Dim vgNaoEClick As Integer, vgNTabelas As String                   'para mudar o valor dos chkbox sem disparar o clique

've se pode e, se for o caso, habilita o botão remover usuarios
Private Sub HabilitaBotaoRemove()
   Dim vgOk As Integer                               'dimensiona
   If trvUsuarios.SelectedItem Is Nothing Then
      trvUsuarios.Nodes(0).Selected = True
   End If
   If UCase$(trvUsuarios.SelectedItem.Text) = UCase$(LoadGasString(11166)) Or UCase$(cboGrupos) = UCase$(LoadGasString(11166)) Then 'assume ok para hab botão remove usuário
      vgOk = (NumeroUsuariosDentroGrupo(cboGrupos.Text) > 1)    'no grupo de supervisão, tem de ter pelo menos 1!
   Else
      vgOk = True
      End If
   botAdiciona.Enabled = (vgPWGrupo) = UCase$(LoadGasString(11166)) And vgSituacao = ACAO_NAVEGANDO
   botRemove.Enabled = vgOk And botAdiciona.Enabled
                                                                                                                           'muda status do botão
End Sub

'habilita/desabilta campos para cadastro de novo usuario
'mostra as permissoes para a tabela selecionada
Private Sub MostraPermisMenu()
   Dim i As Integer, vgG As String
   If UCase$(cboGrupos.Text) = UCase$(LoadGasString(11166)) Or UCase$(vgPWGrupo) <> UCase$(LoadGasString(11166)) Then
      Exit Sub
   End If

   vgNaoEClick = True                                'liga flag para evitar recursividade
   If cboGrupos.ListIndex > -1 Then                  'se algo grupo selecionado
      vgG = Encripta$(cboGrupos.Text)
      vgRsPwTabelas.Index = "Chave tabelas"          'liga o índice e pesquisa...
      For i = 1 To trvMenu.Nodes.Count               'procura o menu dentro da treeview
         trvMenu.Nodes(i).Checked = False
         vgRsPwTabelas.SeekRecord "", "=", vgIDSistema$, vgG, Encripta$("M." + trvMenu.Nodes(i).Tag)
         If Not vgRsPwTabelas.NoMatch Then           'achou?
            If Val(Left(Decripta$(vgRsPwTabelas![PW~Permissoes]), 1)) <> 0 Then 'tem permissão para o menu
               trvMenu.Nodes(i).Checked = True                                  'marca
               vgRsPwTabelas.Delete
            End If
         Else
            trvMenu.Nodes(i).Checked = True                                     'marca
         End If
      Next
   End If
   vgNaoEClick = False                            'agora podemos resetar esta flag
End Sub

'habilita/desabilta campos para cadastro de novo usuario
'mostra as permissoes para a tabela selecionada
Private Sub MostraPermissoes()
   Dim x As String, i As Integer, vgNTb As String                       'dimensiona
   vgNTb$ = trvEstrutura.SelectedItem
   For i = 1 To 4                                 'pega cada uma delas (ver, incluir, etc...)
      chkPermis(i - 1).Enabled = (trvEstrutura.SelectedItem.Children = 0) 'habilita para tabela apenas...
   Next
   vgRsPwTabelas.Index = "Chave tabelas"                                  'liga o índice e pesquisa...
   vgRsPwTabelas.SeekRecord "", "=", " ", Encripta$(cboGrupos.Text), Encripta$(UCase$(vgNTb$))
   vgNaoEClick = True                             'liga flag para evitar recursividade
   If vgRsPwTabelas.NoMatch = False Then          'se achou,
      x$ = Decripta$(vgRsPwTabelas![PW~Permissoes]) 'descriptografa as permissões
      If x$ = "1111" Then vgRsPwTabelas.Delete
   Else
      x$ = "1111"
   End If
   For i = 1 To Len(x$)                             'pega cada uma delas (ver, incluir, etc...)
      chkPermis(i - 1).Value = Val(Mid$(x$, i, 1))  'e ajusta o check box de acordo...
   Next
   vgNaoEClick = False                              'agora podemos resetar esta flag
End Sub

'

'enche lista com os menus do esquema de segurança
Private Function EncheLstMenus() As Boolean
   Dim vgTag As String, vgIdata As Integer, vgNiv As Integer, PaiDoNiv() As Long, _
       i As Integer, j As Long, z As String
   trvMenu.Nodes.Clear
   If vgPWGrupo <> UCase$(LoadGasString(11166)) Then
      EncheLstMenus = False
      Exit Function
   End If
   ReDim PaiDoNiv(0) As Long
   vgNiv = 0
   For i = 0 To mdiNFE.Controls.Count - 1          'corre todos os controles
      If TypeOf mdiNFE.Controls(i) Is Menu Then    'menus
         vgTag$ = mdiNFE.Controls(i).Tag
         If Val(vgTag$) > 0 Then                   'se tem identificador
            vgIdata = Val(Parse$(vgTag$, "|"))     'item data na lista
            vgNiv = (Val(vgTag$) - 1)
            z$ = "P" + CStr(vgIdata)
            If vgNiv = 0 Then
               trvMenu.Nodes.Add , , z$, Retira$(mdiNFE.Controls(i).Caption, "&", SO_UM)
            Else
               trvMenu.Nodes.Add PaiDoNiv(vgNiv - 1), tvwChild, z$, Retira$(mdiNFE.Controls(i).Caption, "&", SO_UM)
            End If
            trvMenu.Nodes(z$).Tag = CStr(vgIdata)
            trvMenu.Nodes(z$).Expanded = True
            j = trvMenu.Nodes.Count
            If vgNiv > UBound(PaiDoNiv) Then
               ReDim Preserve PaiDoNiv(vgNiv) As Long
            End If
            PaiDoNiv(vgNiv) = j
         End If
      End If
   Next                                            'pega próximo menu
   EncheLstMenus = True
End Function

'click no botão de adicionar
Private Sub botAdiciona_Click()
   PrepTelaEBotao ACAO_INCLUINDO
   txtCampo(0).SetFocus
End Sub

Private Sub botCancela_Click()
   CancelaAlteracoes                              'faz cancelamento das alterações
End Sub

'controla os cancelamentos da manipulação de permissões
Private Sub CancelaAlteracoes()
   If cpNovoGrupo.Text <> "" Then
      cpNovoGrupo.Text = ""
      cpNovoGrupo_Change
      Exit Sub
   End If
   PrepTelaEBotao ACAO_NAVEGANDO
   trvUsuarios_NodeClick trvUsuarios.SelectedItem
End Sub

'clicou botão de gravação do form de senhas
Private Sub botGrava_Click()
   Dim vgNTb As String, i As Integer, x As String
   Dim vgNVez As Integer
   Dim rsUsuarios As New GRecordSet
   On Error GoTo FimDaSub                                   'vamos cercar erros
   If cpNovoGrupo.Text <> "" Then
      IncluirGrupo cpNovoGrupo.Text
      cpNovoGrupo.Text = ""
      cpNovoGrupo_Change
      PrepTelaEBotao ACAO_NAVEGANDO
      Exit Sub
   End If
   vgNVez = 0                                               'contador de tentativas
   Screen.MousePointer = vbHourglass                        'mouse = ampulheta
   Select Case tabPermis.Tab                                'verifica em qual tab está
      Case 0                                                'está mudando senhas...
      If (Trim(txtCampo(0).Text) = "") Then
         MsgBox LoadGasString(11288), vbExclamation, App.Title
         Exit Sub
      End If
         If (txtCampo(1).Text <> vgPWSenha$) And (vgPWGrupo <> UCase$(LoadGasString(11166))) Then 'se digitou senha diferente da atual
            Beep                                  'beep
            MsgBox LoadGasString(11200), vbExclamation, vgAtencao$ 'e mostra mensagem
            txtCampo(1).SetFocus                                   'voltando o foco para o campo
         ElseIf txtCampo(2).Text <> txtCampo(3).Text Or (Vazio(txtCampo(2).Text) And (vgPWGrupo <> UCase$(LoadGasString(11166)))) Then 'se nova senha diferente da confirmada
            Beep                                  'emite som e
            MsgBox LoadGasString(11210), vbExclamation, vgAtencao$ 'avisa
            txtCampo(2).Text = ""
            txtCampo(3).Text = ""
            txtCampo(2).SetFocus                                   'voltando o foco para o campo
            Screen.MousePointer = vbDefault
            Exit Sub
         Else                                     'tudo ok - mudou a senha - vamos tratar
            Set rsUsuarios = vgDb.OpenRecordSet("SELECT * FROM [PW~Usuarios] WHERE [PW~Nome] = '" & Encripta(txtCampo(0).Text) & "'")
            On Error GoTo ErroAoGravar            'prepara para cercar erro de gravação
            vgDb(1).BeginTrans                    'inicia transação
            If rsUsuarios.RecordCount > 0 Then
            'Inicio Manual qdo criava um novo usuario com o nome = de algum usuario existente alterava o Usuario existente o Gasss
            If rsUsuarios![PW~Nome] = Encripta(txtCampo(0).Text) And vgSituacao = ACAO_INCLUINDO Then
                MsgBox ("Impossivel já existe um usuario com esse Login"), vbExclamation, App.Title
                vgDb(1).RollBackTrans  'desfaz tudo...
                rsUsuarios.CloseRecordset
                GoTo FimDaSub
            End If
               rsUsuarios.Edit                    'edita
            Else
                     rsUsuarios.AddNew
            End If
               
            If vgSituacao = ACAO_INCLUINDO Then rsUsuarios![PW~Nome] = Encripta$(txtCampo(0).Text) 'necessário se criando um novo.
            rsUsuarios![PW~Grupo] = Encripta$(cboGrupos.Text)
            If Not Vazio(txtCampo(2).Text) Then rsUsuarios![PW~Senha] = Encripta$(txtCampo(2).Text) 'joga no campo a senha criptografada
            rsUsuarios![PW~Obs] = Encripta$(txtCampo(4).Text)                                       'observacao
            rsUsuarios.Update                     'e atualiza

            vgDb(1).CommitTrans
            rsUsuarios.CloseRecordset
            Set rsUsuarios = Nothing

            If Not vgRsPwUsuarios.RecordSet Is Nothing Then vgRsPwUsuarios.Requery
            On Error GoTo FimDaSub                'agora, se der erro, vamos para o final...
            GeraLogAcao LoadGasString(11281) + " " + vgPWSenha$ + " " + Chr$(187) + " " + txtCampo(2).Text
            vgPWSenha$ = txtCampo(2).Text         'atualiza esta variável pública...
         End If
         PegaDadosUsuario txtCampo(0).Text

      Case 1                                      'esta alterando a permissão das tabelas
         vgDb(1).BeginTrans                       'inicia transação
         On Error GoTo ErroAoGravar               'prepara para pegar um erro
         For i = 1 To trvMenu.Nodes.Count
            vgNTb$ = trvMenu.Nodes(i).Tag
            vgNTb$ = Encripta$("M." + vgNTb$)
            vgRsPwTabelas.SeekRecord "", "=", vgIDSistema$, Encripta$(cboGrupos.Text), vgNTb$
            x$ = CStr(Abs(trvMenu.Nodes(i).Checked)) + "111"
            If vgRsPwTabelas.NoMatch = False Then 'se achou,
               If x$ = "1111" Then
                  vgRsPwTabelas.Delete
               Else
                  vgRsPwTabelas.Edit              'edita,
                  vgRsPwTabelas![PW~Permissoes] = Encripta$(x$) 'joga no campo
                  vgRsPwTabelas.Update                          'e atualiza
               End If
            Else
               If x$ <> "1111" Then
                  vgRsPwTabelas.AddNew
                  vgRsPwTabelas![PW~Projeto] = vgIDSistema$     'não coloca ID
                  vgRsPwTabelas![PW~Grupo] = Encripta$(cboGrupos.Text) 'grupo
                  vgRsPwTabelas![PW~Nome] = vgNTb$                     'nome da tabela
                  vgRsPwTabelas![PW~Permissoes] = Encripta$(x$)        'joga no campo
                  vgRsPwTabelas.Update                                 'e atualiza
               End If
            End If
         Next
         vgDb(1).CommitTrans
         vgRsPwTabelas.Requery
         GeraLogAcao LoadGasString(11284) + " " + cboGrupos.Text
         On Error GoTo FimDaSub                                        'direciona erro para a saída...

      Case 2                                      'está criando usuários
         vgRsPwTabelas.Index = "Chave tabelas"    'liga o índice e pesquisa...
         vgRsPwTabelas.SeekRecord "", "=", " ", Encripta$(cboGrupos.Text), Encripta$(UCase$(trvEstrutura.SelectedItem))
         x$ = ""                                  'vamos montar as permissões em x$
         For i = 0 To 3                           'no formato 1010 (1=true, 0=false)
            x$ = x$ + Right$(Str$(Abs(chkPermis(i).Value)), 1)
         Next
         On Error GoTo ErroAoGravar               'prepara para pegar um erro
         vgDb(1).BeginTrans                       'inicia transação
         If vgRsPwTabelas.NoMatch = False Then    'se achou...
            If x$ = "1111" Then
               vgRsPwTabelas.Delete
            Else
               vgRsPwTabelas.Edit                 'edita,
               vgRsPwTabelas![PW~Permissoes] = Encripta$(x$) 'joga no campo
               vgRsPwTabelas.Update                          'e atualiza
            End If
         Else                                                'isso NUNCA!!!
            If x$ <> "1111" Then
               vgRsPwTabelas.AddNew                          'edita,
               vgRsPwTabelas![PW~Projeto] = " "              'não coloca ID
               vgRsPwTabelas![PW~Grupo] = Encripta$(cboGrupos.Text) 'grupo
               vgRsPwTabelas![PW~Nome] = Encripta$(UCase$(trvEstrutura.SelectedItem)) 'nome da tabela
               vgRsPwTabelas![PW~Permissoes] = Encripta$(x$)                          'joga no campo
               vgRsPwTabelas.Update               'e atualiza
            End If
         End If
         vgDb(1).CommitTrans
         vgRsPwTabelas.Requery
            GeraLogAcao LoadGasString(11283) + " " + cboGrupos.Text + "/" + trvEstrutura.SelectedItem
   End Select
   GoTo FimDaSub

DeuErro:                                          'se caiu aqui,
   Resume Next                                    'vamos mandar ignorar...

ErroAoGravar:                                     'se caiu aqui, deu erro de gravação
   Select Case Err                                'vamos verificar qual foi
      Case 3197                                   'registro acabou de ser alterado por outro usuário
         Beep                                     'emite som e mostra a mensagem
         MsgBox LoadGasString(58) + vbCrLf + LoadGasString(59), vbCritical, vgAtencao$

      Case 3167                                   'registro foi apagado por outro usuário
         Beep                                     'emite som
         MsgBox$ LoadGasString(57), vbCritical, vgAtencao$ 'e mostra a mensagem
         MoveRegistro Me, REG_FORCAVOLTA                   'vamos retroceder um registro (sob controle)
         CancelaAlteracoes                                 'cancela alteração
         vgDb(1).RollBackTrans                             'desfaz tudo...
         GoTo FimDaSub                                     'e pular fora daqui...

      Case 3046, 3158, 3186, 3187, 3188, 3189, 3218, 3260  'registro bloqueado
         vgNVez = vgNVez + 1                               'vamos tentar
         If vgNVez <= 10 Then                              '10 vezes a
            Delay 0.5                                      'cada .5 segundos
            Resume                                         'a mesma instrução
         End If
         Beep                                              'não logramos,
         MsgBox LoadGasString(56), vbCritical, vgAtencao$  'mostra mensagem do erro de bloqueio

      Case Else                                            'senão, deu outro tipo de erro qualquer
         CErr.NumErro = Err
         CErr.Show
         vgDb(1).RollBackTrans                             'desfaz tudo...
         GoTo FimDaSub                                     'e sair
   End Select
   On Error Resume Next
   CancelaAlteracoes                                       'e cancelamos a alteração

FimDaSub:                                                  'saída como desta rotina
   Screen.MousePointer = vbDefault                         'restaura o cursor do mouse
   PreencheTreeUsuarios vgSituacao
   PrepTelaEBotao ACAO_NAVEGANDO
End Sub

'clicou o botão de remover grupos, usuários e tabelas
Private Sub botRemove_Click()
   Dim i As Integer                                'dimensiona
   Dim vgNVez As Integer
   vgNVez = 0                                      'contador de tentativas
   On Error GoTo ErroDele                          'prepara para pegar erro ao excluir
   If Not UsuarioSelecionado Then                  'estava manipulando GRUPOS...
      If trvUsuarios.SelectedItem.Children > 0 Then
         MsgBox LoadGasString(11289), vbExclamation, App.Title
         Exit Sub
      Else
         vgDb(1).Execute "DELETE FROM [PW~Grupos] WHERE [PW~Nome] = '" + Encripta$(cboGrupos.Text) + "'"
         GoTo FimDaSub
         GeraLogAcao LoadGasString(11286) + " " + cboGrupos.Text
      End If
   End If
   If MsgBox(LoadGasString(11265), vbExclamation + vbYesNo + vbDefaultButton2, vgAtencao$) = vbYes Then
      Screen.MousePointer = vbHourglass            'mouse = ampulheta
      vgDb(1).Execute "DELETE FROM [PW~Usuarios] WHERE [PW~Grupo] = '" + Encripta$(cboGrupos.Text) + _
                                          "' AND [PW~Nome] = '" + Encripta$(txtCampo(0).Text) + "'"
      If Not vgRsPwUsuarios.RecordSet Is Nothing Then vgRsPwUsuarios.Requery
      GeraLogAcao LoadGasString(11287) + " " + cboGrupos.Text + "/" + txtCampo(0).Text
      GoTo FimDaSub                                'sai desta rotina
   End If
   Exit Sub

ErroDele:                                          'se caiu aqui, deu erro de apagamento
   i = False                                       'vamos usar esta flag para testar exclusão
   Select Case Err                                 'verifica qual erro ocorreu...
      Case 3167                                    'registro ja foi excluido
         i = True                                  'liga flag
      Case 3046, 3158, 3186, 3187, 3188, 3189, 3218, 3260 'registro bloqueado
         vgNVez = vgNVez + 1                              'vamos tentar,
         If vgNVez <= 10 Then                             'por 10 vezes
            Delay 0.5                                     'a cada .5 segundos
            Resume                                        'a mesma instrução
         End If
   End Select

   CErr.NumErro = Err
   CErr.Show
   If i Then                                              'se registro foi excluido
      MoveRegistro Me, REG_FORCAVOLTA                     'retrocede um, sob controle
   End If

FimDaSub:                                                 'saída comum
   Screen.MousePointer = vbDefault                        'e restaura o cursor do mouse
   PreencheTreeUsuarios ACAO_EXCLUINDO

End Sub

Private Sub botRetorna_Click()
   Unload Me                                      'descarrega e
End Sub

Private Sub IncluirGrupo(sGrupo As String)
   Dim rsGrupos As New GRecordSet
   Dim rsTabelas As New GRecordSet
   Dim i As Integer
   Set rsGrupos = vgDb.OpenRecordSet("SELECT * FROM [PW~Grupos] WHERE [PW~Nome] = '" & Encripta(sGrupo) & "'")
   If rsGrupos.RecordCount > 0 Then
      MsgBox LoadGasString(11250), vbExclamation, App.Title
      rsGrupos.CloseRecordset
      Set rsGrupos = Nothing
      Exit Sub
   End If
   rsGrupos.AddNew
   rsGrupos![PW~Nome] = Encripta(sGrupo)
   rsGrupos.Update
   PreencheTreeUsuarios
   rsGrupos.CloseRecordset
   Set rsGrupos = Nothing
   vgDb.Execute "DELETE FROM [PW~Tabelas] WHERE [PW~Grupo] = '" & Encripta(sGrupo) & "'"
   If Not vgRsPwGrupos.RecordSet Is Nothing Then vgRsPwGrupos.Requery
   If Not vgRsPwTabelas.RecordSet Is Nothing Then vgRsPwTabelas.Requery
End Sub

'clicou nos checkboxes de permissões - a flag vgNaoEClick é utilizada aqui
'para evitar recursividade, ou seja esta rotina ficar chamando a sí própria, o
'que ocorre sempre quando mudamos o valor de uma das checkboxes
Private Sub chkPermis_Click(Index As Integer)
   Dim i As Integer                               'dimensiona
   If vgNaoEClick = False Then                    'esta flag é necessária para evitar recursividade
      vgNaoEClick = True                          'liga a flag para não entrar mais aqui...
      If Index = 0 And chkPermis(Index).Value = vbUnchecked Then 'se não pode visualizar registros, então
         For i = 1 To 3                                          'muito menos poderá fazer
            chkPermis(i).Value = vbUnchecked                     'gravações, inclusões e exclusões
         Next                                     'porisso ajustamos automaticamente esses três
      Else                                        'por outro lado, se não for a permissão de visualizar,
         chkPermis(0).Value = vbChecked           'vamos ligar a visualização, automaticamente
      End If
      vgNaoEClick = False                         'reseta a flag
      PrepTelaEBotao ACAO_EDITANDO
   End If
End Sub

Private Sub cpNovoGrupo_Change()
Dim i As Integer
            i = cpNovoGrupo.SelStart                      'salva posição do cursor
            cpNovoGrupo = UCase$(cpNovoGrupo)             'sempre em maiusculo
            cpNovoGrupo.SelStart = i                      'restaura posição do cursor
            If Len(cpNovoGrupo.Text) > 0 Then
               PrepTelaEBotao ACAO_EDITANDO
            Else
               PrepTelaEBotao ACAO_NAVEGANDO
            End If
End Sub

Private Sub trvMenu_Collapse(ByVal Node As MSComctlLib.Node)
   Node.Expanded = True
End Sub

Private Sub trvMenu_NodeCheck(ByVal Node As MSComctlLib.Node)
   If vgNaoEClick = False Then                        'esta flag é necessária para evitar recursividade
      PrepTelaEBotao ACAO_EDITANDO
   End If
End Sub

Private Sub Form_Activate()
   On Error Resume Next                           'evita erro
   txtCampo(0).SetFocus                           'poe foco no primeiro campo
   tabPermis.Tab = 2                              'Muda para o Tab 2
   tabPermis.Tab = 0                              'liga no tab 0
End Sub

'carga do form de manipulação de senhas
Private Sub Form_Load()
   Dim i As Integer
   vgCaracteristica = F_COMUM                     'designa a característica
   vgSituacao = ACAO_NAVEGANDO                    'situação e
   vgTipo = TP_SENHAS                             'tipo deste form
   vgFormID = 11                                  'identificacao do form
   Caption = LoadGasString(11000)                 'coloca o seu título
   vgNaoEClick = False                            'para evitar recursividade nos clicks das chkboxes
   'hint para os controles
   vgTooltips.Create

   For i = 0 To 3
      chkPermis(i).Caption = LoadGasString(11150 + i) 'títulos das permissões
      vgTooltips.AddTool chkPermis(i), 0, LoadGasString(11160 + i)
   Next

   vgTooltips.AddTool trvMenu, 0, LoadGasString(11205)

   'coloca ícones nos botoes
   Set botAdiciona.Picture = LoadPicture(LoadGasPicture(420))
   Set botAdiciona.PictureDisabled = LoadPicture(LoadGasPicture(425))
   Set botRemove.Picture = LoadPicture(LoadGasPicture(430))
   Set botRemove.PictureDisabled = LoadPicture(LoadGasPicture(435))
   Set botGrava.Picture = LoadPicture(LoadGasPicture(405))
   Set botGrava.PictureDisabled = LoadPicture(LoadGasPicture(400))
   Set botCancela.Picture = LoadPicture(LoadGasPicture(410))
   Set botCancela.PictureDisabled = LoadPicture(LoadGasPicture(415))
   Set botRetorna.Picture = LoadPicture(LoadGasPicture(445))

   vgTooltips.AddTool cboGrupos, 0, LoadGasString(11174) 'ajuda da lista de grupos,
   vgTooltips.AddTool trvEstrutura, 0, LoadGasString(11175) 'da lista de tabelas
   vgTooltips.AddTool trvUsuarios, 0, LoadGasString(11176)  'da lista de usuários
   vgTooltips.AddTool botGrava, 0, LoadGasString(11170)     'do botão grava,
   vgTooltips.AddTool botAdiciona, 0, LoadGasString(11171)  'do adiciona
   vgTooltips.AddTool botRemove, 0, LoadGasString(11172)    'do remove e
   vgTooltips.AddTool botCancela, 0, LoadGasString(11173)   'do cancela
   vgTooltips.AddTool botRetorna, 0, LoadGasString(11177)   'do cancela
   vgTooltips.AddTool cpNovoGrupo, 0, LoadGasString(11183)  'do Novo Grupo
   vgTooltips.AddTool txtCampo(0), 0, LoadGasString(11184)  'do Usuario
   vgTooltips.AddTool txtCampo(1), 0, LoadGasString(11180)  'do Senha Atual
   vgTooltips.AddTool txtCampo(2), 0, LoadGasString(11181)  'do Nova Senha
   vgTooltips.AddTool txtCampo(3), 0, LoadGasString(11182)  'do Redigita Nova Senha
   vgTooltips.AddTool txtCampo(4), 0, LoadGasString(11187)  'da Observação

   Top = mdiNFE.Top + (mdiNFE.Height - mdiNFE.ScaleHeight + 120) 'joga para a cima por causa dos diálogos
   If EncheLstMenus Then                                         'enche lst de menus
      CentraNaTela Me                                            'centraliza este form na tela
   End If
   PreencheTreeUsuarios
   PrepTelaEBotao ACAO_NAVEGANDO
End Sub

Private Sub Form_Paint()
   On Error Resume Next                           'evita erro
   txtCampo(0).SetFocus
End Sub

Private Sub Form_Unload(Cancel As Integer)
   Set vgTooltips = Nothing
   Set frmSenhas = Nothing                        'destroi o objeto
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyEscape Then                 'se teclou ESC
      Unload Me                                   'tira este form da memória
   End If
End Sub

'selecionou uma das tabelas
Private Sub trvEstrutura_NodeClick(ByVal Node As MSComctlLib.Node)
   MostraPermissoes                               'mostra as permissões para a tabela selecionada
End Sub

'selecionou um usuário ou grupo
Private Sub trvUsuarios_NodeClick(ByVal Node As MSComctlLib.Node)
   vgNaoEClick = True
   If UsuarioSelecionado Then                     'um usuario selecionado
      PegaDadosUsuario trvUsuarios.SelectedItem.Text
   Else                                           'um grupo selecionado
      cboGrupos.Text = trvUsuarios.SelectedItem.Text
      txtCampo(0).Text = ""
      txtCampo(2).Text = ""
      txtCampo(3).Text = ""
      txtCampo(4).Text = ""
   End If
   MostraPermisMenu
   EncheEstrutura
            'nao permitimos alterar permissoes de tabelas e menus para admins.
   PrepTelaEBotao ACAO_NAVEGANDO
End Sub

Private Sub txtCampo_Change(Index As Integer)
   Dim i As Integer
   i = txtCampo(Index).SelStart                   'salva posição do cursor
   txtCampo(Index) = UCase$(txtCampo(Index))      'sempre em maiusculo
   txtCampo(Index).SelStart = i                   'restaura posição do cursor
   If (vgNaoEClick = False Or Index <> 0) And vgSituacao = ACAO_NAVEGANDO Then 'se não for esta mesma rotina chamando,
      PrepTelaEBotao ACAO_EDITANDO                                             'muda o status do botão de gravação
   End If
End Sub

'está digitando dentro de um dos campos
Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then                             'se for ENTER,
      KeyAscii = 0                                            'não registra o enter e
      SendK vbKeyTab
   End If
End Sub

Private Function PreencheTreeUsuarios(Optional ByVal Situacao As Integer)
   Dim rsGrupos As New GRecordSet
   Dim rsUsuarios As New GRecordSet
   Dim Node As MSComctlLib.Node
   Dim tmpGrupo As Integer
   DoEvents
   Set rsGrupos = vgDb.OpenRecordSet("SELECT * FROM [PW~Grupos] " & IIf(vgPWGrupo <> UCase$(LoadGasString(11166)), " WHERE [PW~Nome] = '" & Encripta$(vgPWGrupo) & "'", ""))
   Set rsUsuarios = vgDb.OpenRecordSet("SELECT * FROM [PW~Usuarios]" & IIf(vgPWGrupo <> UCase$(LoadGasString(11166)), " WHERE [PW~Nome] = '" & Encripta$(vgPWUsuario) & "'", ""))
   If Situacao = ACAO_INCLUINDO Then
      tmpGrupo = trvUsuarios.Nodes.Count + 1
   ElseIf Situacao = ACAO_EXCLUINDO Then
      tmpGrupo = 1
   Else
      tmpGrupo = PegaNodeSelecionado(trvUsuarios)
   End If
   trvUsuarios.Nodes.Clear
   cboGrupos.Clear
   With rsGrupos
      .MoveFirst
      Do While Not .EOF
         trvUsuarios.Nodes.Add , , Decripta(![PW~Nome]), Decripta(![PW~Nome])
         cboGrupos.AddItem Decripta(![PW~Nome])
         .MoveNext
      Loop
   End With
   With rsUsuarios
      .MoveFirst
      Do While Not .EOF
         Set Node = trvUsuarios.Nodes.Add(Decripta(![PW~Grupo]), tvwChild, Decripta(![PW~Nome]) & "|" & Decripta(![PW~Grupo]), Decripta(![PW~Nome]))
         Node.EnsureVisible
         Node.ForeColor = vbBlue
         .MoveNext
      Loop
   End With
   If trvUsuarios.Nodes.Count < tmpGrupo Then tmpGrupo = trvUsuarios.Nodes.Count
   trvUsuarios.Nodes(tmpGrupo).Selected = True
   trvUsuarios_NodeClick trvUsuarios.SelectedItem
   rsGrupos.CloseRecordset
   rsUsuarios.CloseRecordset
   Set rsGrupos = Nothing
   Set rsUsuarios = Nothing
   If Not vgRsPwGrupos.RecordSet Is Nothing Then vgRsPwGrupos.Requery
   If Not vgRsPwUsuarios.RecordSet Is Nothing Then vgRsPwUsuarios.Requery
End Function

Private Function NumeroUsuariosDentroGrupo(strGrupo As String) As Integer
Dim rsUsuarios As New GRecordSet
   Set rsUsuarios = vgDb.OpenRecordSet("SELECT * FROM [PW~Usuarios] WHERE [PW~Grupo] = '" & Encripta(strGrupo) & "'")
   NumeroUsuariosDentroGrupo = rsUsuarios.RecordCount
   rsUsuarios.CloseRecordset
   Set rsUsuarios = Nothing
End Function

Private Sub PegaDadosUsuario(sUsuario As String)
   Dim rsUsuarios As New GRecordSet
   Set rsUsuarios = vgDb.OpenRecordSet("SELECT * FROM [PW~Usuarios] WHERE [PW~Nome] = '" & Encripta(sUsuario) & "'")
   If rsUsuarios.RecordCount = 0 Then Exit Sub
      cboGrupos.Text = Decripta(rsUsuarios![PW~Grupo])
      txtCampo(0).Text = (sUsuario)
      txtCampo(2).Text = ""                       'BuscaSenhaUsuario(txtCampo(0).Text)
      txtCampo(3).Text = ""                       'txtCampo(2).Text
      txtCampo(4).Text = Decripta(rsUsuarios![PW~Obs])
      rsUsuarios.CloseRecordset
      Set rsUsuarios = Nothing
End Sub

Private Function UsuarioSelecionado() As Boolean
            UsuarioSelecionado = False
            On Error Resume Next
            UsuarioSelecionado = InStr(1, trvUsuarios.SelectedItem.FullPath, trvUsuarios.PathSeparator, vbBinaryCompare) > 0
End Function

Private Sub HabilitaAbas()
   Dim sGrupoSelecionado As String
   If UsuarioSelecionado Then
      sGrupoSelecionado = trvUsuarios.SelectedItem.Parent
      txtCampo(0).Text = trvUsuarios.SelectedItem.Text
   Else
      sGrupoSelecionado = trvUsuarios.SelectedItem.Text
   End If
   
   tabPermis.TabEnabled(0) = True
   tabPermis.TabEnabled(1) = (sGrupoSelecionado <> UCase$(LoadGasString(11166)) And vgPWGrupo = UCase$(LoadGasString(11166)))
   tabPermis.TabEnabled(2) = (sGrupoSelecionado <> UCase$(LoadGasString(11166)) And vgPWGrupo = UCase$(LoadGasString(11166)))
   If tabPermis.TabEnabled(tabPermis.Tab) = False Then tabPermis.Tab = 0
   'se um admin estiver editando um nao-admin, libera as tabs.
   
   trvUsuarios.Enabled = Not (vgSituacao = ACAO_EDITANDO)
   trvEstrutura.Enabled = Not (vgSituacao = ACAO_EDITANDO)
End Sub

'prepara a tela e botões de acordo com a situação
Private Sub PrepTelaEBotao(Situacao As Integer)
   vgSituacao = Situacao
   botCancela.Enabled = (vgSituacao = ACAO_EDITANDO) Or (vgSituacao = ACAO_INCLUINDO)
   botGrava.Enabled = (vgSituacao = ACAO_EDITANDO) Or (vgSituacao = ACAO_INCLUINDO)
   HabilitaBotaoRemove
   HabilitaAbas
   
   'Vamos habilitar os campos agora
   txtCampo(0).Enabled = (vgSituacao = ACAO_INCLUINDO) And (vgPWGrupo = UCase$(LoadGasString(11166)))
   labSenha(0).Enabled = txtCampo(0).Enabled
   
   txtCampo(1).Enabled = (vgPWGrupo <> UCase$(LoadGasString(11166))) And UsuarioSelecionado
   labSenha(1).Enabled = txtCampo(1).Enabled
   
   txtCampo(2).Enabled = UsuarioSelecionado Or vgSituacao = ACAO_INCLUINDO
   labSenha(2).Enabled = txtCampo(2).Enabled
   
   txtCampo(3).Enabled = UsuarioSelecionado Or vgSituacao = ACAO_INCLUINDO
   labSenha(3).Enabled = txtCampo(3).Enabled
   
   txtCampo(4).Enabled = vgPWGrupo = UCase$(LoadGasString(11166)) Or vgSituacao = ACAO_INCLUINDO
   labSenha(4).Enabled = txtCampo(4).Enabled

   If vgSituacao = ACAO_NAVEGANDO Then txtCampo(1).Text = ""
   
   If vgSituacao = ACAO_INCLUINDO Then
      If txtCampo(0).Enabled Then txtCampo(0).Text = ""
      If txtCampo(2).Enabled Then txtCampo(2).Text = ""
      If txtCampo(3).Enabled Then txtCampo(3).Text = ""
      If txtCampo(4).Enabled Then txtCampo(4).Text = ""
   End If
   
   'Desabilitao Grupo se não for ADMIN
   cpNovoGrupo.Enabled = (vgPWGrupo = UCase$(LoadGasString(11166)))

End Sub

Private Sub trvUsuarios_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
            Dim nodNode As MSComctlLib.Node
            Set nodNode = trvUsuarios.HitTest(x, y)
            If nodNode Is Nothing Then Exit Sub
            nodNode.Selected = True
            If UsuarioSelecionado Then nodNode.Selected = False
End Sub

Private Sub trvUsuarios_OLEStartDrag(Data As MSComctlLib.DataObject, AllowedEffects As Long)
   AllowedEffects = vbDropEffectMove
   Data.SetData trvUsuarios.SelectedItem.Key
   blnDragging = True

'Vamos verificar se é o administrador e só tem ele, para não mover.
   If UsuarioSelecionado Then
      If InStr(trvUsuarios.SelectedItem.Key, "|" & UCase$(LoadGasString(11166))) Then
         If trvUsuarios.Nodes(UCase$(LoadGasString(11166))).Children <= 1 Then
            blnDragging = False
         End If
      End If
   End If
End Sub

Private Sub trvUsuarios_OLEDragOver(Data As MSComctlLib.DataObject, Effect As Long, Button As Integer, Shift As Integer, x As Single, y As Single, State As Integer)
   Dim nodNode As MSComctlLib.Node
   Effect = vbDropEffectMove
   Set nodNode = trvUsuarios.HitTest(x, y)
   If nodNode Is Nothing Or blnDragging = False Then
      Effect = vbDropEffectNone
   End If
End Sub

Private Sub trvUsuarios_OLEDragDrop(Data As MSComctlLib.DataObject, Effect As Long, Button As Integer, Shift As Integer, x As Single, y As Single)
   Dim strSourceKey As String
   Dim nodTarget    As MSComctlLib.Node
   Dim rsUsuarios   As New GRecordSet
   Dim sGrupo       As String, sUser As String

   strSourceKey = Data.GetData(vbCFText)
   Set nodTarget = trvUsuarios.HitTest(x, y)

   'essas 3 condicoes que seguem sao para certificar que NAO VAMOS:
   'arrastar algo q nao seja um usuario(grupo seria o unico caso, por enquanto)
   'ou arrastar este usuario para cima de outro usuario(e sim para cima de um grupo)
   'ou arrastar o usuario para o grupo ao qual já pertence
   If (Not UsuarioSelecionado) Or NodeUsuario(nodTarget) Or (Right(strSourceKey, Len(nodTarget.Text)) = nodTarget.Text) Then
      GoTo SaiSub
   End If
   If MsgBox(LoadGasString(11290), vbQuestion + vbYesNo, App.Title) = vbNo Then
      GoTo SaiSub
   End If
   sGrupo = strSourceKey
   sUser = Parse(sGrupo, "|")
   Set rsUsuarios = vgDb.OpenRecordSet("SELECT * FROM [PW~Usuarios] WHERE ([PW~Nome] = '" & Encripta(sUser) & "') AND [PW~Grupo] = '" & Encripta(sGrupo) & "'")
   If rsUsuarios.NoMatch Then
      MsgBox LoadGasString(11291), vbExclamation, App.Title
      GoTo SaiSub
   End If
   rsUsuarios.Edit
   rsUsuarios![PW~Grupo] = Encripta(nodTarget.Text)
   rsUsuarios.Update
   rsUsuarios.CloseRecordset
   vgRsPwUsuarios.Requery
   Set rsUsuarios = Nothing
   Set trvUsuarios.Nodes(strSourceKey).Parent = nodTarget
   trvUsuarios.Nodes(strSourceKey).Text = Parse(strSourceKey, "|") & "|" & nodTarget
   PreencheTreeUsuarios
SaiSub:
   blnDragging = False
   Effect = 0
   Exit Sub
End Sub

Private Function NodeUsuario(Node As MSComctlLib.Node) As Boolean
   NodeUsuario = False
   On Error Resume Next
   NodeUsuario = InStr(1, Node.FullPath, trvUsuarios.PathSeparator, vbBinaryCompare) > 0
End Function

Private Sub EncheEstrutura()
   Dim vgBanco As GDataBase, vgTb As GTable, Node As MSComctlLib.Node, vgKey(3) As String
   If UCase$(cboGrupos.Text) = UCase$(LoadGasString(11166)) Or UCase$(vgPWGrupo) <> UCase$(LoadGasString(11166)) Then
      Exit Sub
   End If
   If trvEstrutura.Nodes.Count = 0 Then           'Se não fez ainda...
      For Each vgBanco In vgDb
         vgKey(1) = "BD=" + vgBanco.Name
         Set Node = trvEstrutura.Nodes.Add(, , vgKey(1), vgBanco.Name)
         Node.Bold = True
         Node.Expanded = True

         'enche lista com as tabelas
         vgKey(2) = vgKey(1) + "|TABS"
         Set Node = trvEstrutura.Nodes.Add(vgKey(1), tvwChild, vgKey(2), LoadGasString(11140))
         Node.Expanded = True
         Node.Bold = True
         For Each vgTb In vgBanco.Tables
            If InStr(vgTb.Name, "~") = 0 Then
               vgKey(3) = vgKey(1) + "|TAB=" + vgTb.Name
               Set Node = trvEstrutura.Nodes.Add(vgKey(2), tvwChild, vgKey(3), vgTb.Name)
               Node.ForeColor = vbBlue
            End If
         Next
      Next
   End If
   
   'Atualiza forçando o click
   trvEstrutura.Nodes(PegaNodeSelecionado(trvEstrutura)).Selected = True
   trvEstrutura_NodeClick trvEstrutura.SelectedItem

   Set vgTb = Nothing
   Set Node = Nothing
End Sub

Private Function PegaNodeSelecionado(Item As MSComctlLib.TreeView) As Long
   On Error GoTo DeuErro
   PegaNodeSelecionado = Item.SelectedItem.Index
   Exit Function

DeuErro:
   PegaNodeSelecionado = 1
End Function
