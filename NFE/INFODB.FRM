VERSION 5.00
Object = "{0A8A0428-822E-11D3-BBEF-444553540000}#1.0#0"; "gPainel2.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MsComCtl.ocx"
Begin VB.Form frmInfoDB 
   Caption         =   "INFORMAÇÔES sobre o banco de dados"
   ClientHeight    =   5955
   ClientLeft      =   5085
   ClientTop       =   1905
   ClientWidth     =   8130
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H80000008&
   KeyPreview      =   -1  'True
   LinkTopic       =   "frmInfoDB"
   MDIChild        =   -1  'True
   ScaleHeight     =   5955
   ScaleWidth      =   8130
   ShowInTaskbar   =   0   'False
   Begin NFE.GPainel Painel 
      Height          =   5490
      Index           =   0
      Left            =   180
      Top             =   210
      Width           =   7755
      _ExtentX        =   13679
      _ExtentY        =   9684
      Begin VB.CheckBox chkSepararIntegridade 
         Caption         =   "Separar Integridades"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   5880
         TabIndex        =   2
         Top             =   720
         Value           =   1  'Checked
         Width           =   1815
      End
      Begin MSComctlLib.TreeView trvEstrutura 
         Height          =   4695
         Left            =   180
         TabIndex        =   0
         Top             =   570
         Width           =   3495
         _ExtentX        =   6165
         _ExtentY        =   8281
         _Version        =   393217
         HideSelection   =   0   'False
         Indentation     =   529
         LabelEdit       =   1
         LineStyle       =   1
         Style           =   6
         FullRowSelect   =   -1  'True
         Appearance      =   1
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
      Begin VB.Label labEstrutura 
         Caption         =   "Estrutura"
         Height          =   195
         Left            =   180
         TabIndex        =   1
         Top             =   300
         Width           =   1665
      End
   End
End
Attribute VB_Name = "frmInfoDB"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
'* Sistema...: Emissor de MDF-e (Layout 3.00)
'* Empresa...: Ygor Eduardo Dellalio
'* Módulo....: frmInfoDB
'* Função....: Informações do banco de dados
'* CopyRight.: (C)2024 Ygor Eduardo Dellalio
'* Criação...: GAS-2007 - Gerador Automático de Sistemas
'* Data......: 05/09/2024 18:10:18
'* * * * * * *

Option Explicit                                    'requer declaração de variáveis
DefInt A-Z                                         'tipo inteiro, por default

Public vgSituacao As Integer, vgCaracteristica As Integer, _
                     vgTipo As Integer, vgFormID As Long          'propriedades dos forms
Public vgPriVez As Boolean, vgEmBrowse As Integer

Private Sub chkSepararIntegridade_Click()
   EncheEstrutura
End Sub
   
Private Sub Form_Activate()
   AtivaForm Me                                       'inicializa o form
End Sub

'carga do form de informações
Private Sub Form_Load()
   Screen.MousePointer = vbHourglass                      'mouse = hourglass
   vgCaracteristica = F_COMUM                             'designa sua característica,
   vgSituacao = ACAO_NAVEGANDO                            'situação e
   vgTipo = TP_INFODB                                     'tipo
   vgFormID = 6                                           'identificacao do form
   Icon = LoadPicture(LoadGasPicture(132))                'coloca o ícone no form
   DesligaRepara                                          'desabilita botao de repara DB
   labEstrutura.Caption = LoadGasString(3000)             'coloca no label
   EncheEstrutura                                         'enche estrutura dos bancos
   AjustaTamanho Me                                       'ajusta o tamanho do form
   Screen.MousePointer = vbDefault                        'restaura o mouse pointer
End Sub

'enche árvore com a estrutura dos bancos de dados
Private Sub EncheEstrutura()
   Dim vgBanco As GDataBase, vgTb As GTable, vgInd As GIndex, vgCp As GColumn, vgRel As GRelation, _ 
               vgCpRel As GRelationColumn, vgKey(7) As String, Node As MSComctlLib.Node, vgRs As New GRecordSet

   trvEstrutura.Nodes.Clear
   
   For Each vgBanco In vgDb                                'corre todos os bancos da aplicação

      vgKey(1) = "BD=" + vgBanco.Name
      Set Node = trvEstrutura.Nodes.Add(, , vgKey(1), vgBanco.Name)
      Node.Bold = True
      Node.Expanded = True

      'enche lista com as tabelas
      vgKey(2) = vgKey(1) + "|TABS"
      Set Node = trvEstrutura.Nodes.Add(vgKey(1), tvwChild, vgKey(2), LoadGasString(3005))
      Node.Expanded = True
      Node.Bold = True
      For Each vgTb In vgBanco.Tables
         vgKey(3) = vgKey(1) + "|TAB=" + vgTb.Name
         Set vgRs = vgDb(vgBanco.Name).OpenRecordSet(vgTb.Name)
         Set Node = trvEstrutura.Nodes.Add(vgKey(2), tvwChild, vgKey(3), vgTb.Name + " (" + CStr$(vgRs.RecordCount) + LoadGasString(1560) + ")")
         Node.ForeColor = vbBlue
         vgKey(4) = vgKey(3) + "|CPS"
         Set Node = trvEstrutura.Nodes.Add(vgKey(3), tvwChild, vgKey(4), LoadGasString(3010))
         Node.Expanded = True
         For Each vgCp In vgTb.Columns
            vgKey(5) = vgKey(3) + "|CP=" + vgCp.Name
            Set Node = trvEstrutura.Nodes.Add(vgKey(4), tvwChild, vgKey(5), vgCp.Name)
            Node.Text = Node.Text + "  -  " + vgCp.ColumnTypeName
            If vgCp.ColumnType = TP_CARACTER Then
               Node.Text = Node.Text + "(" + CStr(vgCp.Size) + ")"
            End If
            If Len(vgCp.Mask) > 0 Then
               Node.Text = Node.Text + "  -  " + vgCp.Mask
            End If
            Node.ForeColor = vbBlue
         Next
         If vgTb.Indexes.Count > 0 Then
            vgKey(4) = vgKey(3) + "|INDS"
            Set Node = trvEstrutura.Nodes.Add(vgKey(3), tvwChild, vgKey(4), LoadGasString(3030))
            Node.Expanded = True
         End If
         For Each vgInd In vgTb.Indexes
            vgKey(5) = vgKey(3) + "IND=" + vgInd.Name
            Set Node = trvEstrutura.Nodes.Add(vgKey(4), tvwChild, vgKey(5), vgInd.Name)
            If vgInd.IndexType = TYPE_Primary Then
               Node.Text = Node.Text + " (" + LoadGasString(3050) + ")"
            ElseIf vgInd.IndexType = TYPE_Unique Then
               Node.Text = Node.Text + " (" + LoadGasString(3070) + ")"
            End If
            Node.ForeColor = vbBlue
            vgKey(6) = vgKey(5) + "|CPS"
            Set Node = trvEstrutura.Nodes.Add(vgKey(5), tvwChild, vgKey(6), LoadGasString(3010))
            Node.Expanded = True
            For Each vgCp In vgInd.Columns
               vgKey(7) = vgKey(6) + "|CP=" + vgCp.Name
               Set Node = trvEstrutura.Nodes.Add(vgKey(6), tvwChild, vgKey(7), vgCp.Name)
               If vgCp.Descending Then
                  Node.Text = Node.Text + " (DESC)"
               End If
               Node.ForeColor = vbBlue
            Next
         Next
      Next

      'enche lista com as integridades
      If chkSepararIntegridade.Value <> 0 Then
         vgKey(2) = vgKey(1) + "|RELAS"
         Set Node = trvEstrutura.Nodes.Add(vgKey(1), tvwChild, vgKey(2), LoadGasString(3007))
         Node.Expanded = True
         Node.Bold = True
      End If 
      For Each vgRel In vgBanco.Relations
         If chkSepararIntegridade.Value = 0 Then
            vgKey(2) = vgKey(1) + "|TAB=" + vgRel.BaseTable.Name + "|RELAS"
            On Error Resume Next
            Set Node = trvEstrutura.Nodes.Add(vgKey(1) + "|TAB=" + vgRel.BaseTable.Name, tvwChild, vgKey(2), LoadGasString(3007))
            On Error GoTo 0
            Node.Expanded = True
         End If
         vgKey(3) = vgKey(1) + "|RELA=" + vgRel.Name
         Set Node = trvEstrutura.Nodes.Add(vgKey(2), tvwChild, vgKey(3), vgRel.BaseTable.Name + " --> " + vgRel.ForeignTable.Name)
         Node.ForeColor = vbBlue
         If vgRel.Trigger Then
            Node.Text = Node.Text + " (" + LoadGasString(3074) + ")"
         End If
      
         vgKey(4) = vgKey(3) + "|CPS"
         Set Node = trvEstrutura.Nodes.Add(vgKey(3), tvwChild, vgKey(4), LoadGasString(3010))
         Node.Expanded = True
      
         If vgRel.Update Or vgRel.Delete Then
            vgKey(5) = vgKey(3) + "|ATRIBS"
            Set Node = trvEstrutura.Nodes.Add(vgKey(3), tvwChild, vgKey(5), LoadGasString(3008))
            Node.Expanded = True
            If vgRel.Update Then
               Set Node = trvEstrutura.Nodes.Add(vgKey(5), tvwChild, vgKey(3) + "|ATRIB=UPDATE", LoadGasString(3072))
               Node.ForeColor = vbBlue
            End If
            If vgRel.Delete Then
               Set Node = trvEstrutura.Nodes.Add(vgKey(5), tvwChild, vgKey(3) + "|ATRIB=DELETE", LoadGasString(3073))
               Node.ForeColor = vbBlue
            End If
         End If
      
         For Each vgCpRel In vgRel.RelationColumns
            vgKey(5) = vgKey(3) + "|CP=" + vgCpRel.BaseColumn.Name
            Set Node = trvEstrutura.Nodes.Add(vgKey(4), tvwChild, vgKey(5), vgCpRel.BaseColumn.Name + " = " + vgCpRel.ForeignColumn.Name)
            Node.ForeColor = vbBlue
         Next
      Next
   Next
   Set vgTb = Nothing
   Set vgInd = Nothing
   Set vgCp = Nothing
   Set Node = Nothing
   Set vgRel = Nothing
   Set vgCpRel = Nothing
   Set vgRs = Nothing
End Sub

'usuário está alterando o tamanho do form
Private Sub Form_Resize()
   AjustaPanFundo Me                                      'centra o painel do fundo no form
   labEstrutura.Left = 90
   labEstrutura.Top = 90
   trvEstrutura.Left = 90
   chkSepararIntegridade.Top = 90
   trvEstrutura.Top = labEstrutura.Top + labEstrutura.Height + 30
   trvEstrutura.Height = Painel(0).Height - trvEstrutura.Top - 90
   trvEstrutura.Width = Painel(0).Width - 180
End Sub

Private Sub Form_Unload(Cancel As Integer)
   FinalizaForm Me                                    'executa rotinas de finalização
   Set frmInfoDB = Nothing                            'destroi o objeto liberando o seu segmento de código
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyEscape Then                     'se teclou ESC
      Unload Me                                       'tira este form da memória
   End If
End Sub
