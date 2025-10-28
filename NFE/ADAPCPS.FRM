VERSION 5.00
Begin VB.Form frmAdapCps
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "CAPTURA CAMPO"
   ClientHeight    =   2130
   ClientLeft      =   3420
   ClientTop       =   2790
   ClientWidth     =   2325
   Height          =   2535
   Left            =   3360
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2130
   ScaleWidth      =   2325
   ShowInTaskbar   =   0   'False
   Top             =   2445
   Width           =   2445
   Begin VB.ListBox lstCampos
      Height          =   1620
      Left            =   60
      TabIndex        =   0
      Top             =   420
      Width           =   2175
   End
   Begin VB.Label labTit
      Caption         =   "Campos da Tabela anterior"
      Height          =   195
      Left            =   60
      TabIndex        =   1
      Top             =   120
      Width           =   2175
   End
End
Attribute VB_Name = "frmAdapCps"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
'* Sistema...: Emissor de MDF-e (Layout 3.00)
'* Empresa...: Ygor Eduardo Dellalio
'* Módulo....: ADAPCPS
'* Função....: Captura campo
'* CopyRight.: (C)2023 Ygor Eduardo Dellalio
'* Criação...: GAS-2007 - Gerador Automático de Sistemas
'* Data......: 01/09/2023 10:21:36
'* * * * * * *

Option Explicit                                    'variáveis devem ser declaradas
DefInt A-Z                                         'e por default todas seram inteiras

Private Sub Form_Load()
   Dim i As Integer
   Top = (Screen.Height - Height) / 2                 'centraliza esta janela vertical e
   Left = (Screen.Width - Width) / 2                  'horizontalmente
   lstCampos.Clear                                    'limpa lst de campos
   For i = 0 To vgCat.Tables(vgTabAdap$).Columns.Count - 1
      lstCampos.AddItem vgCat.Tables(vgTabAdap$).Columns(i).Name 'da tabela original
   Next
End Sub

Private Sub lstCampos_Click()
   frmAdapDif.txtCpOrigem(vgQualScrCp).Text = lstCampos.Text   'altera texto do grid
   vgCpOrigem$(vgQualCp) = lstCampos.Text                      'armazena o novo campo
   Unload Me                                      'volta para o form do grid
End Sub

Private Sub Form_Unload(Cancel As Integer)
   Set frmAdapCps = Nothing                       'destroi este formulário
End Sub
