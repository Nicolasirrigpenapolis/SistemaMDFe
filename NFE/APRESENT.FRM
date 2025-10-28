VERSION 5.00
Begin VB.Form frmApresenta
   BorderStyle     =   0  'None
   ClientHeight    =   4215
   ClientLeft      =   1785
   ClientTop       =   2490
   ClientWidth     =   6615
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
   LinkTopic       =   "frmApresenta"
   LockControls    =   -1  'True
   ScaleHeight     =   4215
   ScaleWidth      =   6615
   Begin VB.Timer timApresenta 
      Enabled         =   0   'False
      Interval        =   3000
      Left            =   6960
      Top             =   360
   End
   Begin NFE.GPainel panInicio
      Height          =   4215
      Left            =   0
      Top             =   0
      Backcolor       =   16777215
      Width           =   6615
      _ExtentX        =   11668
      _ExtentY        =   7435
      bevelwidth      =   2
      borderwidth     =   1
      BevelInner      =   2
      BevelOuter      =   2
      Stretch         =   -1  'True
   End
End
Attribute VB_Name = "frmApresenta"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
'* Sistema...: Emissor de Nota Fiscal Eletronica
'* Empresa...: Ygor Eduardo Dellalio
'* Módulo....: frmApresenta
'* Função....: Apresentação inicial
'* CopyRight.: (C)2016 Ygor Eduardo Dellalio
'* Criação...: GAS-2007 - Gerador Automático de Sistemas
'* Data......: 25/05/2016 17:16:59
'* * * * * * *

Option Explicit                                   'variáveis devem ser previamente declaradas
DefInt A-Z                                        'por default, todas do tipo inteiro

'para pegar o tamanho do BITMAP
Private Type BITMAP                               '14 bytes
   bmType As Long
   bmWidth As Long
   bmHeight As Long
   bmWidthBytes As Long
   bmPlanes As Integer
   bmBitsPixel As Integer
   bmBits As Long
End Type

Private Declare Function GetObject Lib "GDI32" Alias "GetObjectA" (ByVal hObject As Long, ByVal nCount As Long, lpObject As Any) As Long

Public vgCaracteristica As Integer                'todo form tem de ter esta propriedade, para sua identificação
Public vgFormID As Long

'carga do form de apresentação
Private Sub Form_Load()
   Dim j As Long, bmp As BITMAP, h As Single, w As Single, imH As Long, imW As Long
   vgCaracteristica = F_COMUM                           'designa sua característica
   vgFormID = 13                                        'identificacao do form

   With panInicio                                       'com o painel inicial,
      Set .Picture = LoadPicture(LoadGasPicture(5))     'carrega figura, gravada no resource

   'acerta img para mostrar proporcionalidade
      j = GetObject(.Picture, Len(bmp), bmp)            'vamos pegar proporçao do bmp
      imW = bmp.bmWidth                                 'largura e
      imH = bmp.bmHeight                                'altura da figura
      If imW = 0 Or imH = 0 Then                        'ícone vem zerado!!!
         imW = 32                                       'vamos fixar 32 x 32 pixels
         imH = 32
      End If
      If (imH / Screen.Height) >= (imW / Screen.Width) Then 'qual lado é maior?
         h = .5 * Screen.Height                             'aplica percentual sobre a altura
         w = h * imW / imH                                  'calcula largura
      Else                                                  'landscape          'a largura é maior
         w = .5 * Screen.Width                              'calcula bmp pela largura
         h = w * imH / imW                                  'acha a altura proporcional
      End If
      Move ((Screen.Width - w) / 2), ((Screen.Height - h) / 2), w, h

      .Top = 0                                              'ajusta o seu topo,
      .Left = 0                                             'margem esquerda,
      .Width = ScaleWidth                                   'largura e
      .Height = ScaleHeight                                 'altura para ficar do tamanho do form
   End With
   CentraNaTela Me                                          'e agora, centraliza o form na tela
End Sub

'este timer será usado para fazer o efeito "spash" na aplicação
'A apresentação vai ficar na tela enquanto o form principal MDI estiver sendo carregado
'e, quando pronto, este evento irá descarregar este form e mostrar o MDI geral
Private Sub timApresenta_Timer()
   With mdiNFE                                    'com o form principal MDI
      .timRefresh.Enabled = True                  'habilita o timer de refresh de tabelas
      .Menu_Barra.Checked = vgBarraFerr           'com o que leu no INI, marca a opção da barra de ferramentas,
      .panTools.Visible = vgBarraFerr             'ajusta a sua visi,
      .Menu_Ajuda.Checked = vgAjudaAtiva          'marca/desmarca a opção de ajuda,
      On Error Resume Next                        'previne erro
      .Show                                       'e mostra o form principal
      If Err Then                                 'deu erro
         Err.Clear                                'limpa o erro
         Exit Sub                                 'espera mais um pouco
      End If
   End With
   timApresenta.Enabled = False                   'desabilita este timer
   Unload Me                                      'descarrega o form de apresentação,
   Screen.MousePointer = vbDefault                'restaura e ponteiro do mouse
End Sub

Private Sub Form_Unload(Cancel As Integer)
   Set frmApresenta = Nothing                     'destroi este formulário
End Sub
