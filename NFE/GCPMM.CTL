VERSION 5.00
Begin VB.UserControl GCpMM
   ClientHeight    =   4155
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   5550
   ScaleHeight     =   4155
   ScaleWidth      =   5550
   ToolboxBitmap   =   "GCPMM.CTX":0000
   Begin VB.PictureBox picTools 
      BorderStyle     =   0  'None
      Height          =   360
      Left            =   0
      ScaleHeight     =   360
      ScaleWidth      =   5070
      TabIndex        =   7
      Top             =   0
      Visible         =   0   'False
      Width           =   5070
      Begin VB.CheckBox chkMM 
         Height          =   300
         Index           =   10
         Left            =   3750
         Picture         =   "GCPMM.CTX":0532
         Style           =   1  'Graphical
         TabIndex        =   19
         Top             =   30
         Width           =   300
      End
      Begin VB.CheckBox chkMM 
         Height          =   300
         Index           =   9
         Left            =   3450
         Picture         =   "GCPMM.CTX":0ABC
         Style           =   1  'Graphical
         TabIndex        =   18
         Top             =   30
         Width           =   300
      End
      Begin VB.CommandButton botCancela 
         Appearance      =   0  'Flat
         Enabled         =   0   'False
         Height          =   300
         Left            =   4740
         Picture         =   "GCPMM.CTX":1046
         Style           =   1  'Graphical
         TabIndex        =   17
         Top             =   30
         Width           =   300
      End
      Begin VB.CommandButton botSalva 
         Appearance      =   0  'Flat
         Enabled         =   0   'False
         Height          =   300
         Left            =   4440
         Picture         =   "GCPMM.CTX":15D0
         Style           =   1  'Graphical
         TabIndex        =   16
         Top             =   30
         Width           =   300
      End
      Begin VB.CommandButton botMM 
         Appearance      =   0  'Flat
         Height          =   300
         Index           =   12
         Left            =   4050
         Picture         =   "GCPMM.CTX":1B5A
         Style           =   1  'Graphical
         TabIndex        =   15
         TabStop         =   0   'False
         Top             =   30
         Width           =   300
      End
      Begin VB.ComboBox cboTipo 
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   6.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Left            =   900
         Style           =   2  'Dropdown List
         TabIndex        =   14
         TabStop         =   0   'False
         Top             =   45
         Width           =   1665
      End
      Begin VB.CommandButton botMM 
         Appearance      =   0  'Flat
         Height          =   300
         Index           =   8
         Left            =   3150
         Picture         =   "GCPMM.CTX":20E4
         Style           =   1  'Graphical
         TabIndex        =   13
         TabStop         =   0   'False
         Top             =   30
         Width           =   300
      End
      Begin VB.CommandButton botMM 
         Appearance      =   0  'Flat
         Enabled         =   0   'False
         Height          =   300
         Index           =   7
         Left            =   2850
         Picture         =   "GCPMM.CTX":266E
         Style           =   1  'Graphical
         TabIndex        =   12
         TabStop         =   0   'False
         Top             =   30
         Width           =   300
      End
      Begin VB.CommandButton botMM 
         Appearance      =   0  'Flat
         Enabled         =   0   'False
         Height          =   300
         Index           =   5
         Left            =   2550
         Picture         =   "GCPMM.CTX":2BF8
         Style           =   1  'Graphical
         TabIndex        =   11
         TabStop         =   0   'False
         Top             =   30
         Width           =   300
      End
      Begin VB.CommandButton botMM 
         Appearance      =   0  'Flat
         Height          =   300
         Index           =   4
         Left            =   600
         Picture         =   "GCPMM.CTX":3182
         Style           =   1  'Graphical
         TabIndex        =   10
         TabStop         =   0   'False
         Top             =   30
         Width           =   300
      End
      Begin VB.CommandButton botMM 
         Appearance      =   0  'Flat
         Height          =   300
         Index           =   2
         Left            =   300
         Picture         =   "GCPMM.CTX":370C
         Style           =   1  'Graphical
         TabIndex        =   9
         TabStop         =   0   'False
         Top             =   30
         Width           =   300
      End
      Begin VB.CommandButton botMM 
         Appearance      =   0  'Flat
         Height          =   300
         Index           =   0
         Left            =   0
         Picture         =   "GCPMM.CTX":3C96
         Style           =   1  'Graphical
         TabIndex        =   8
         TabStop         =   0   'False
         Top             =   30
         Width           =   300
      End
   End
   Begin VB.PictureBox pic 
      Appearance      =   0  'Flat
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   825
      Index           =   0
      Left            =   60
      ScaleHeight     =   825
      ScaleWidth      =   1395
      TabIndex        =   1
      Top             =   510
      Width           =   1395
      Begin VB.PictureBox pic 
         Appearance      =   0  'Flat
         BorderStyle     =   0  'None
         DrawWidth       =   2
         BeginProperty Font 
            Name            =   "Wingdings"
            Size            =   5.25
            Charset         =   2
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   405
         Index           =   1
         Left            =   120
         MouseIcon       =   "GCPMM.CTX":4220
         ScaleHeight     =   405
         ScaleWidth      =   825
         TabIndex        =   2
         TabStop         =   0   'False
         Top             =   90
         Width           =   825
         Begin VB.VScrollBar scrV 
            Height          =   375
            LargeChange     =   10
            Left            =   900
            Max             =   0
            MouseIcon       =   "GCPMM.CTX":452A
            TabIndex        =   5
            TabStop         =   0   'False
            Top             =   0
            Visible         =   0   'False
            Width           =   195
         End
         Begin VB.HScrollBar scrH 
            Height          =   195
            LargeChange     =   10
            Left            =   90
            MouseIcon       =   "GCPMM.CTX":4834
            TabIndex        =   4
            TabStop         =   0   'False
            Top             =   480
            Visible         =   0   'False
            Width           =   675
         End
         Begin VB.CommandButton bot 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   195
            Left            =   840
            MouseIcon       =   "GCPMM.CTX":4B3E
            Picture         =   "GCPMM.CTX":4E48
            Style           =   1  'Graphical
            TabIndex        =   3
            TabStop         =   0   'False
            Top             =   480
            Visible         =   0   'False
            Width           =   255
         End
         Begin VB.Label labNomeMM 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   6.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000008&
            Height          =   180
            Left            =   390
            TabIndex        =   6
            Top             =   120
            Visible         =   0   'False
            Width           =   45
         End
         Begin VB.Image imgIcone 
            Appearance      =   0  'Flat
            Enabled         =   0   'False
            Height          =   225
            Left            =   0
            Top             =   270
            Visible         =   0   'False
            Width           =   225
         End
         Begin VB.Image img 
            Enabled         =   0   'False
            Height          =   225
            Left            =   30
            Stretch         =   -1  'True
            Top             =   0
            Width           =   255
         End
      End
   End
   Begin VB.Label lab 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Height          =   195
      Left            =   750
      TabIndex        =   0
      Top             =   1620
      Width           =   165
   End
   Begin VB.Shape shp 
      FillColor       =   &H0000FF00&
      Height          =   375
      Left            =   540
      Shape           =   4  'Rounded Rectangle
      Top             =   1080
      Visible         =   0   'False
      Width           =   375
   End
   Begin VB.Menu m_Opcoes 
      Caption         =   "Opções"
      Visible         =   0   'False
      Begin VB.Menu m_opc 
         Caption         =   "&Abrir..."
         Index           =   0
      End
      Begin VB.Menu m_opc 
         Caption         =   "-"
         Index           =   1
      End
      Begin VB.Menu m_opc 
         Caption         =   "&Carregar"
         Index           =   2
      End
      Begin VB.Menu m_opc 
         Caption         =   "&Selecionar fonte"
         Index           =   3
      End
      Begin VB.Menu m_opc 
         Caption         =   "&Digitalizar - formato..."
         Index           =   4
         Begin VB.Menu m_opcBMP 
            Caption         =   "&BMP"
         End
         Begin VB.Menu m_opcJPG 
            Caption         =   "&JPG - compactação..."
            Begin VB.Menu opc_jpg 
               Caption         =   "Máxima (- qualidade)"
               Index           =   0
            End
            Begin VB.Menu opc_jpg 
               Caption         =   "Média-alta"
               Index           =   1
            End
            Begin VB.Menu opc_jpg 
               Caption         =   "Média"
               Index           =   2
            End
            Begin VB.Menu opc_jpg 
               Caption         =   "Média-baixa"
               Index           =   3
            End
            Begin VB.Menu opc_jpg 
               Caption         =   "Baixa (+ qualidade)"
               Index           =   4
            End
         End
      End
      Begin VB.Menu m_opc 
         Caption         =   "&Retirar"
         Enabled         =   0   'False
         Index           =   5
      End
      Begin VB.Menu m_opc 
         Caption         =   "-"
         Index           =   6
      End
      Begin VB.Menu m_opc 
         Caption         =   "&Imprimir"
         Enabled         =   0   'False
         Index           =   7
      End
      Begin VB.Menu m_opc 
         Caption         =   "&Exportar"
         Enabled         =   0   'False
         Index           =   8
      End
      Begin VB.Menu m_opc 
         Caption         =   "Imagem &parcial"
         Enabled         =   0   'False
         Index           =   9
      End
      Begin VB.Menu m_opc 
         Caption         =   "&Maximizar"
         Index           =   10
      End
      Begin VB.Menu m_opc 
         Caption         =   "-"
         Index           =   11
      End
      Begin VB.Menu m_opc 
         Caption         =   "Mostrar botões"
         Checked         =   -1  'True
         Index           =   12
      End
      Begin VB.Menu m_opc 
         Caption         =   "&Mostrar imagens"
         Checked         =   -1  'True
         Index           =   13
      End
   End
End
Attribute VB_Name = "GCpMM"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'* Sistema...: Emissor de MDF-e (Layout 3.00)
'* Empresa...: Ygor Eduardo Dellalio
'* Módulo....: GCpMM
'* Função....: Campo multimídia
'* CopyRight.: (C)2024 Ygor Eduardo Dellalio
'* Criação...: GAS-2007 - Gerador Automático de Sistemas
'* Data......: 05/09/2024 18:10:19
'* * * * * * *
Option Explicit
DefInt A-Z

'Contantes/Funções para TWAIN (EZTW)

Private Const TWCY_BRAZIL = 55

'Linguagens
Private Const TWLG_POR = 10                       '/* Portuguese             */

Private Declare Function TWAIN_AcquireToFilename Lib "EZTW32.DLL" (ByVal hwndApp As Long, ByVal sFile As String) As Long
Private Declare Function TWAIN_SelectImageSource Lib "EZTW32.DLL" (ByVal hWnd As Long) As Long
Private Declare Function TWAIN_IsAvailable Lib "EZTW32.DLL" () As Long
Private Declare Sub TWAIN_RegisterApp Lib "EZTW32.DLL" (ByVal nMajorNum As Long, ByVal nMinorNum As Long, ByVal nLanguage As Long, ByVal nCountry As Long, ByVal sVersion As String, ByVal sMfg As String, ByVal sFamily As String, ByVal sProduct As String)

'Fim de constantes/funções para TWAIN (EZTW)

'para getar o ícone associado ao tipo (defaulticon)
Private Type TypeIcon
   cbSize As Long
   picType As PictureTypeConstants
   hIcon As Long
End Type

Private Type CLSID
   id(16) As Byte
End Type

Private Const MAXI_PATH = 260

Private Type SHFILEINFO
   hIcon As Long                                  ' icone
   iIcon As Long                                  ' inde do icone
   dwAttributes As Long                           ' flags SFGAO_
   szDisplayName As String * MAXI_PATH            ' nome ou path (or path)
   szTypeName As String * 80                      ' nome do tipo
End Type

Private Declare Function OleCreatePictureIndirect Lib "oleaut32.dll" (pDicDesc As TypeIcon, riid As CLSID, ByVal fown As Long, lpUnk As Object) As Long
Private Declare Function SHGetFileInfo Lib "shell32.dll" Alias "SHGetFileInfoA" (ByVal pszPath As String, ByVal dwFileAttributes As Long, psfi As SHFILEINFO, ByVal cbFileInfo As Long, ByVal uFlags As Long) As Long
Private Declare Function GetTempPath Lib "kernel32.dll" Alias "GetTempPathA" (ByVal nBufLen As Long, ByVal lpBuffer As String) As Long
Private Declare Function GetTempFileName Lib "kernel32" Alias "GetTempFileNameA" (ByVal lpszPath As String, ByVal lpPrefixString As String, ByVal wUnique As Long, ByVal lpTempFileName As String) As Long

Private Const SHGFI_ICON = &H100
Private Const SHGFI_LARGEICON = &H0
Private Const SHGFI_SMALLICON = &H1

Private Const SW_SHOWNORMAL = 1
Private Const SEE_MASK_NOCLOSEPROCESS = &H40
Private Const SEE_MASK_FLAG_DDEWAIT = &H100

Private Type SHELLEXECUTEINFO
   cbSize As Long
   fMask As Long
   hWnd As Long
   lpVerb As String
   lpFile As String
   lpParameters As String
   lpDirectory As String
   nShow As Long
   hInstApp As Long
   'Optional fields
   lpIDList As Long
   lpClass As String
   hkeyClass As Long
   dwHotKey As Long
   hIcon As Long
   hProcess As Long
End Type

Private Declare Function ShellExecuteEx Lib "shell32.dll" (lpExecInfo As SHELLEXECUTEINFO) As Boolean


Private Declare Function WaitForSingleObject Lib "kernel32" (ByVal hHandle As Long, ByVal dwMilliseconds As Long) As Long
Private Declare Function CloseHandle Lib "kernel32" (ByVal hObject As Long) As Long

'para o pegafolder
'  Converte um identificador de item em um path - retorna TRUE se sucesso, FALSE se um erro ocorreu
Private Declare Function SHGetPathFromIDList Lib "shell32.dll" Alias "SHGetPathFromIDListA" (ByVal pidl As Long, ByVal pszPath As String) As Long
'  Recupera um local de um folder especial (de sistema) - retorna NOERROR se sucesso, OLE-defined error se deu erro
Private Declare Function SHGetSpecialFolderLocation Lib "shell32.dll" (ByVal hwndOwner As Long, ByVal nFolder As Long, pidl As ITEMIDLIST) As Long
Private Declare Function SHBrowseForFolder Lib "shell32.dll" Alias "SHBrowseForFolderA" (lpBrowseInfo As BROWSEINFO) As Long  'ITEMIDLIST

' Identificador do item
Private Type SHITEMID                             'mkid
   cb   As Long                                   'tamanho do identificador (incluindo o próprico Cb
   AbID As Byte                                   'Identificador do item (tamanho variável)
End Type

'  Define um elemento em uma lista de identificadores
Private Type ITEMIDLIST
   mkid As SHITEMID
End Type


Private Type BROWSEINFO
   hOwner As Long
   pidlRoot As Long
   pszDisplayName As String
   lpszTitle As String
   ulFlags As Long
   lpfn As Long
   lParam As Long
   iImage As Long
End Type

Const BIF_RETURNONLYFSDIRS = &H1

'constantes para o ExtraiMidia
Public Enum ModoExtraiMidiaBD
   EX_NADA
   EX_MATA
   EX_TOCA_MATA
End Enum

Enum GMMAparencia
   Flat
   [3D]
End Enum

Enum GMMTipoMouse
   Default
   Arrow
   Cross
   [I-Beam]
   Icon
   Size
   [Size NE SW]
   [Size N S]
   [Size NW SE]
   [Size W W]
   [Up Arrow]
   HourGlass
   [No Drop]
   [Arrow and Hourglass]
   [Arrow and Question]
   [Size All]
   Custom = 99
End Enum

'posicao do label no controle
Enum GMMTipoAlinhamento
   [Field Top]
   [Field Bottom]
   [Field Left]
   [Field Right]
End Enum

'Tipo de Shape
Enum GMMTipoShape
   Rectangle
   Square
   Oval
   [Circle ]
   [Rounded Rectangle]
   [Rounded Square]
End Enum

'Estilo do Shape
Enum GMMEstiloShape
   Solid
   Transparent
   [Horizontal Line]
   [Vertical Line]
   [Upward Diagonal]
   [Downward Diagonal]
   [Cross]
   [Diagonal Cross]
End Enum

'tipo da borda
Enum GMMTipoBordaShape
   Transparent
   Solid
   Dash
   Dot
   [Dash-Dot]
   [Dash-Dot-Dot]
   [Inside Solid]
End Enum

'tipo da borda
Enum GMMTipoBordaMM
   None
   [Fixed single]
End Enum

'toolbar
Const B_ABRE = 0
Const B_CARREGA = 2
Const B_SELECIONA = 3
Const B_DIGITALIZA = 4
Const B_RETIRA = 5
Const B_IMPRIME = 7
Const B_EXPORTA = 8
Const B_IMAGEMPARC = 9
Const B_MAXIMIZA = 10
Const B_TOOLBAR = 12
Const B_DISPLAYIMG = 13

'Default Property Values:
Const CHUNKSIZE As Integer = 32000                '16384
Const m_def_Alignment = 0
Const m_def_Shape = 2
Const m_def_CaptionOffset = 50

'tipo de midia imagem
Const IMG_NAO = 0
Const IMG_OUTRAS = 1
Const IMG_BMP = 2                                 'essa vamos gravar na forma do vb/blob

Dim gCaptionOffSet As Integer
Dim gDataField As String
Dim gAlignment As GMMTipoAlinhamento
Dim gColorOnFocus As OLE_COLOR
Dim gColorNoFocus As OLE_COLOR
Dim gFillStyleOnFocus As GMMEstiloShape
Dim gFillStyleNoFocus As GMMEstiloShape
Dim gDisplayImages As Boolean
Dim gMediaFilter As String
Dim gAllowMaximize As Boolean
Dim gHasToolBar As Boolean
Dim gToolBarVisible As Boolean
Dim gLocked As Boolean
Dim gEditable As Boolean
Dim gScrollBars As Boolean
Dim gLargeChange As Integer
Dim gAppearance As GMMAparencia
Dim gBorderStyle As GMMTipoBordaMM
Dim gDataSource As Object

Dim ScanOk As Boolean                             'flag scan
Dim Qualidade As Long                             'para jpg

'dimensiona variaveis para a mascara
Dim gMaximizado As Boolean
Dim gTopAnt As Long
Dim gLeftAnt As Long
Dim gWidthAnt As Long
Dim gHeightAnt As Long

Dim ArqMidia As String                            'nome do arquivo atual que contém o blob
Dim gSituacao As Integer                          'nome da midia salva no blob
Dim gFilter As String                             'filtro de arquivos possiveis
Dim gDirTemp As String                            'diretório temporário do windows
Dim ETipoMDB As Boolean                           'flag distingue mdb/sql

'Event Declarations:
Event Click()
Event DblClick()
Event OptionSelected(ByVal Opt As Integer, ByVal TypeImg As Integer, Cancel As Boolean) 'dispara qdo clica em botoes ou menu
Event MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
Event Change()
Event MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)            'MappingInfo=UserControl,UserControl,-1,MouseUp
Event MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)          'MappingInfo=UserControl,UserControl,-1,MouseMove
Event OpenMedia(Status As Integer)

Public Property Get DataSource() As Object
   Set DataSource = gDataSource
End Property

Public Property Set DataSource(ByVal New_DataSource As Object)
   Dim i As Boolean
   Set gDataSource = New_DataSource
   ETipoMDB = True
   If Not gDataSource Is Nothing Then
      On Error Resume Next
      i = gDataSource.RecordSet.NoMatch
      If Err Then
         ETipoMDB = False
         Err.Clear
      End If
   End If
End Property

Public Property Get DataChanged() As Boolean
   DataChanged = botSalva.Enabled
End Property

Public Sub ExportMedia(Optional NomeMidia As String)
   Dim NAnt As String, k As String, PosiExtrai As Long
   k$ = NomePuro$
   PosiExtrai = Len(k$)                           'pega offset da midia gravada para extrair
   NAnt$ = ArqMidia$                              'salva nome da midia atual
   On Error Resume Next                           'privine erros na nome do arquivo e path nao validos...
   If NomeMidia$ <> "" Then
      ArqMidia$ = NomeMidia$                      'usa nome passado
   End If
   If ETipoImagem = IMG_BMP Then                  'figuras bmp/wmf/dib
      ExtraiMidiaBD 7, EX_NADA                    'figuras bmp/wmf/dib
   Else
      ExtraiMidiaBD (PosiExtrai), EX_NADA         'extrai e nao mata...
   End If
   ArqMidia$ = NAnt$                              'restaura nome da mídia atual
End Sub

Public Property Get MediaName() As String
   Dim HaMidia As Boolean
   've se midia vazia...
   If ETipoMDB Then
      HaMidia = (gDataSource.Fields(gDataField).FieldSize > 1)
   Else
      HaMidia = (gDataSource.Fields(gDataField).ActualSize > 1)
   End If
   If Not HaMidia Then
      MediaName = ""
   Else
      If BlobComBMP Then                          'trata tipos bmp/wmf/dib...
         PegaNomeRealBMP                          'enche ArqMidia$
      Else
         PegaNomeMidia                            'idem para outras midias
      End If
      MediaName = NomePuro$                       'nome puro da midia
   End If
End Property

Public Property Let DataChanged(ByVal New_DataChanged As Boolean)
   botSalva.Enabled = New_DataChanged
   If New_DataChanged Then
      botSalva_Click
   End If
End Property

Public Property Get Picture() As Picture
   Set Picture = img.Picture
End Property

Public Property Set Picture(ByVal New_Picture As Picture)
   Dim Rt As Single, w As Single, h As Single
   If UCase$(UserControl.Extender.Parent.Name) = "FRMMM" And img.Stretch = True Then   'vamos pegar o ratio da imagem
      With img
         w = .Width
         h = .Height
         .Stretch = False
         Set img.Picture = New_Picture
         Rt = .Width / .Height
         .Width = w
         .Height = h
         .Stretch = True
      End With
      UserControl.Extender.Parent.Height = (UserControl.Extender.Parent.Width / Rt) + 560 + _
                  Abs(picTools.Visible * picTools.Height)
   Else
      Set img.Picture = New_Picture
   End If
   imgIcone.Picture = LoadPicture("")
   labNomeMM.Caption = ""
   labNomeMM.Visible = False
   img.Visible = True
   imgIcone.Visible = False                       'esconde icone de mídia, se tiver
   AcertaOpcoesMenu
   PropertyChanged "Picture"
End Property

Public Property Get BackColor() As OLE_COLOR
   BackColor = pic(0).BackColor
End Property

Public Property Let BackColor(ByVal New_BackColor As OLE_COLOR)
   pic(0).BackColor() = New_BackColor
   pic(1).BackColor() = New_BackColor
   UserControl_Resize
   PropertyChanged "BackColor"
End Property

Public Property Get Stretch() As Boolean
   Stretch = img.Stretch
End Property

Public Property Let Stretch(ByVal New_Stretch As Boolean)
   img.Stretch = New_Stretch
   LigaDesligaScr
   UserControl_Resize
   PropertyChanged "Stretch"
End Property

Public Property Get EstaMaximizado() As Boolean
   EstaMaximizado = gMaximizado
End Property

Public Sub Refresh()
   If gMaximizado Then
      MaximizaFigura
   End If
   UserControl_Resize
End Sub

' função para mostrar o diálogo de abrir arquivo
Private Function AbreDlgArquivo() As String
   Dim x As String, dlgArquivo As New cCommonDialog
   On Error Resume Next
   Err.Clear
   With dlgArquivo
      .CancelError = True
      .Filter = gFilter
      .DialogTitle = LoadGasString(1204)
      .Flags = OFN_HIDEREADONLY
      .hWnd = UserControl.Parent.hWnd
      .ShowOpen
      If Err.Number <> 0 Then
         Err.Clear
         Exit Function
      End If
      x$ = .FileName
   End With
   Set dlgArquivo = Nothing
   AbreDlgArquivo$ = x$
End Function

'maximiza a figura no form
Sub MaximizaFigura()
   Dim j As Single
   gMaximizado = True
   gTopAnt = UserControl.Extender.Top
   gLeftAnt = UserControl.Extender.Left
   gWidthAnt = UserControl.Width
   gHeightAnt = UserControl.Height
   UserControl.Extender.Top = 0
   UserControl.Extender.Left = 0
   On Error Resume Next
   j = UserControl.Extender.Container.ScaleWidth
   If Err Then
      UserControl.Width = UserControl.Extender.Container.Width
      UserControl.Height = UserControl.Extender.Container.Height
   Else
      UserControl.Width = j
      UserControl.Height = UserControl.Extender.Container.ScaleHeight
   End If
   UserControl.Extender.ZOrder 0
   UserControl_Resize
End Sub

Sub RestauraFigura()
   gMaximizado = False
   UserControl.Extender.Top = gTopAnt
   UserControl.Extender.Left = gLeftAnt
   UserControl.Width = gWidthAnt
   UserControl.Height = gHeightAnt
   UserControl_Resize
End Sub

Private Function NomePuro$()
   NomePuro$ = Mid$(ArqMidia$, InStrRev("\" + ArqMidia$, "\"))  'extrai o nome puro do arquivo
End Function

Private Sub botCancela_Click()
   ShowMedia
   botSalva.Enabled = False
   botCancela.Enabled = False
End Sub

Private Sub botMM_Click(Index As Integer)
   botMM(Index).Enabled = False
   If Index = B_DIGITALIZA Then
      If cboTipo.ListIndex = 0 Then               'bmp
         m_opcBMP_Click                           'faz bmp
      Else
         opc_jpg_Click (cboTipo.ListIndex + 1)    'jpg no formato da combo
      End If
   Else
      m_Opc_Click Index                           'mesmo do menu
   End If
   botMM(Index).Enabled = True
End Sub

'salva e atualiza bd
Public Sub SaveWithUpdate()
   On Error Resume Next
   If ETipoMDB Then gDataSource.Edit
   SaveMedia
   gDataSource.Update
End Sub

Private Sub botSalva_Click()
   SaveWithUpdate
   botSalva.Enabled = False
   botCancela.Enabled = False
End Sub

Private Sub chkMM_Click(Index As Integer)
   m_Opc_Click Index                              'mesmo do menu
End Sub

Private Sub m_Opc_Click(Index As Integer)
   Dim x As String, NAnt As String, k As String, Cancel As Boolean
   On Error GoTo Fora
   If Index <> B_DIGITALIZA Then
      RaiseEvent OptionSelected(Index, -2, Cancel)
      If Cancel Then Exit Sub
   End If
   DoEvents
   Select Case Index
      Case B_ABRE                                 'abre...
         If ETipoImagem = IMG_BMP Then
            ExtraiMidiaBD 7, EX_TOCA_MATA         'extrai e executa
         Else
            x$ = NomePuro$
            ExtraiMidiaBD Len(x$), EX_TOCA_MATA   'extrai e executa
         End If
      
      Case B_SELECIONA
         TWAIN_SelectImageSource UserControl.Parent.hWnd
      
      Case B_CARREGA                              'carrega blob no controle
         x$ = AbreDlgArquivo$
         DisplayMidia x$
   
      Case B_RETIRA                               'retira figura
         DisplayMidia ""

      Case B_IMPRIME                              'imprime
         
         If MsgBox(LoadGasString(1226), vbQuestion + vbYesNo, LoadGasString(1225)) = vbYes Then
            DoEvents
            Printer.PaintPicture img.Picture, 0, 0
            Printer.EndDoc
         End If

      Case B_EXPORTA                              'exporta
         k$ = NomePuro$
PegaF:
         x$ = PegaFolder(13, LoadGasString(1205) + k$ + "...")
         
         If Len(x$) > 0 Then
            If Len(Dir$(x$ + k$)) > 0 Then        'nao tem o arquivo
               If MsgBox(LoadGasString(1228), vbQuestion + vbYesNo, LoadGasString(1225)) <> vbYes Then
                  GoTo PegaF                      'pega novo folder
               End If
            End If
            NAnt$ = ArqMidia$                     'salva nome da midia atual
            ArqMidia$ = x$ + k$
            If ETipoImagem = IMG_BMP Then         'figuras bmp/wmf/dib
               ExtraiMidiaBD 7, EX_NADA           'figuras bmp/wmf/dib
            Else
               ExtraiMidiaBD Len(k$), EX_NADA     'extrai e nao mata...
            End If
            ArqMidia$ = NAnt$                     'restaura nome da mídia atual
         End If
      
      Case B_IMAGEMPARC                           'stretch
         Stretch = (Not img.Stretch)
         If img.Stretch Then
            m_opc(Index).Caption = LoadGasString(1206)
         Else
            m_opc(Index).Caption = LoadGasString(1207)
         End If

      Case B_MAXIMIZA                             'max
         If gMaximizado Then
            m_opc(Index).Caption = LoadGasString(1218) 'maximizar
            RestauraFigura
         Else
            m_opc(Index).Caption = LoadGasString(1208)
            MaximizaFigura
         End If
         
      Case B_TOOLBAR
         ToolBarVisible = Not ToolBarVisible           'inverte
         m_opc(B_TOOLBAR).Checked = gToolBarVisible
   
      Case B_DISPLAYIMG
         DisplayImages = Not DisplayImages             'inverte
         m_opc(B_DISPLAYIMG).Checked = gDisplayImages
         ShowMedia
'   If ETipoImagem <> IMG_NAO Then        'se estiver mostrando trata o que está mostrando
'    If gDisplayImages = False Then
'     MostraIconeMidia  'mostra so icone
'    Else
'     ShowMedia         'mostra imagem
'    End If
'   End If
   
   End Select

Fora:
   If Err = 481 Then
      MsgBox LoadGasString(1221), vbInformation, LoadGasString(1225)
   End If
End Sub

Public Sub DisplayMidia(New_Name As String)
   Dim k As String
   ArqMidia$ = New_Name$                          'nome do que vai ser gravado
   If Len(ArqMidia$) > 0 And Len(Dir$(ArqMidia$)) > 0 Then
      gSituacao = 3
      If Len(gMediaFilter) > 0 Then
         k$ = Right$(UCase$(ArqMidia$), 3)
         If InStr(gMediaFilter, k$) = 0 Then
            Error 481
         End If
      End If
      If ETipoImagem <> IMG_NAO And gDisplayImages Then 'é imagem qualquer...
         Screen.MousePointer = vbHourglass
         Set Picture = LoadPicture(ArqMidia$)           'coloca figura no controle
         Screen.MousePointer = vbDefault
      Else                                              'outros blobs...
         Call MostraIconeMidia                          'mostra outros tipos
         AcertaOpcoesMenu
      End If
      RaiseEvent Change
      botSalva.Enabled = True
      botCancela.Enabled = True
      UserControl_Resize
   Else
      Set Picture = LoadPicture("")
      gSituacao = 2
      RaiseEvent Change
      botSalva.Enabled = True
      botCancela.Enabled = True
      UserControl_Resize
      scrV.Enabled = False
      scrH.Enabled = False
   End If
End Sub

'cuida do scroll
Private Sub ScrollV(y As Long)
   img.Top = -y
   scrV.Value = y
End Sub

'cuida do scroll
Private Sub ScrollH(x As Long)
   img.Left = -x
   scrH.Value = x
End Sub

Public Property Get LinkTimeOut() As Integer
   LinkTimeOut = pic(0).LinkTimeOut
End Property

Public Property Let LinkTimeOut(ByVal New_LinkTimeOut As Integer)
   pic(0).LinkTimeOut = New_LinkTimeOut
   pic(1).LinkTimeOut = New_LinkTimeOut
   PropertyChanged "LinkTimeOut"
End Property

Public Property Get ColorNoFocus() As OLE_COLOR
   ColorNoFocus = gColorNoFocus
End Property

Public Property Let ColorNoFocus(ByVal New_ColorNoFocus As OLE_COLOR)
   gColorNoFocus = New_ColorNoFocus
   shp.FillColor() = gColorNoFocus
   PropertyChanged "ColorNoFocus"
End Property

Public Property Get ColorOnFocus() As OLE_COLOR
   ColorOnFocus = gColorOnFocus
End Property

Public Property Let ColorOnFocus(ByVal New_ColorOnFocus As OLE_COLOR)
   gColorOnFocus = New_ColorOnFocus
   PropertyChanged "ColorOnFocus"
End Property

Public Property Get ScrollBars() As Boolean
   ScrollBars = gScrollBars
End Property

Public Property Let ScrollBars(ByVal New_ScrollBars As Boolean)
   gScrollBars = New_ScrollBars
   LigaDesligaScr
   UserControl_Resize
   PropertyChanged "ScrollBars"
End Property

Public Property Get Locked() As Boolean
   Locked = gLocked
End Property

Public Property Let Locked(ByVal New_Locked As Boolean)
   gLocked = New_Locked
   PropertyChanged "Locked"
End Property

Public Property Get HasToolBar() As Boolean
   HasToolBar = gHasToolBar
End Property

Public Property Let HasToolBar(ByVal New_HTB As Boolean)
   gHasToolBar = New_HTB
   PropertyChanged "HasToolBar"
   If gHasToolBar = False Then ToolBarVisible = False   'reseta visibilidade
End Property

Public Property Get AllowMaximize() As Boolean
   AllowMaximize = gAllowMaximize
End Property

Public Property Let AllowMaximize(ByVal New_AM As Boolean)
   gAllowMaximize = New_AM
   PropertyChanged "AllowMaximize"
   chkMM(B_MAXIMIZA).Enabled = gAllowMaximize
   m_opc(B_MAXIMIZA).Enabled = gAllowMaximize
End Property

Public Property Get MediaFilter() As String
   MediaFilter = gMediaFilter
End Property

Public Property Let MediaFilter(ByVal New_MF As String)
   gMediaFilter = UCase$(New_MF)
   'tira pipe do inicio e fim, se tiver..
   If Right$(gMediaFilter, 1) = "|" Then gMediaFilter = Left$(gMediaFilter, Len(gMediaFilter) - 1)
   If Left$(gMediaFilter, 1) = "|" Then gMediaFilter = Mid$(gMediaFilter, 2)
   gMediaFilter = Troca(gMediaFilter, "*", "")    'remove asteriscos
   gMediaFilter = Troca(gMediaFilter, ".", "")    'remove pontos
   PropertyChanged "MediaFilter"
   MontaFiltroArqs                                'monta filtro de acordo
   m_opcBMP.Enabled = (InStr(gMediaFilter, "BMP") > 0 Or gMediaFilter = "")
   m_opcJPG.Enabled = (InStr(gMediaFilter, "JPG") > 0 Or gMediaFilter = "")
   m_opc(B_DIGITALIZA).Enabled = (InStr(gMediaFilter, "BMP") > 0 Or _
                                 InStr(gMediaFilter, "JPG") > 0 Or _
                                 gMediaFilter = "")

End Property

Public Property Get DisplayImages() As Boolean
   DisplayImages = gDisplayImages
End Property

Public Property Let DisplayImages(ByVal New_DI As Boolean)
   gDisplayImages = New_DI
   PropertyChanged "DisplayImages"
   m_opc(B_DISPLAYIMG).Checked = gDisplayImages
End Property

Public Property Get ToolBarVisible() As Boolean
   ToolBarVisible = gToolBarVisible
End Property

Public Property Let ToolBarVisible(ByVal New_TBV As Boolean)
   gToolBarVisible = New_TBV
   picTools.Visible = gToolBarVisible
   UserControl_Resize
   PropertyChanged "ToolBarVisible"
End Property

Public Property Get Editable() As Boolean
   Editable = gEditable
End Property

Public Property Let Editable(ByVal New_Editable As Boolean)
   gEditable = New_Editable
   PropertyChanged "Editable"
End Property

Public Property Get LargeChange() As Integer
   LargeChange = gLargeChange
End Property

Public Property Let LargeChange(ByVal New_LargeChange As Integer)
   gLargeChange = New_LargeChange
   PropertyChanged "LargeChange"
End Property

Private Sub bot_Click()
   If gLocked = False And UserControl.Extender.WhatsThisHelpID <> -1 Then
      PopupMenu m_Opcoes
   End If
End Sub

Public Sub PopMenu()
   If gLocked = False And UserControl.Extender.WhatsThisHelpID <> -1 Then
      PopupMenu m_Opcoes
   End If
End Sub

Private Sub lab_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
   RaiseEvent MouseDown(Button, Shift, ScaleX(x + lab.Left, UserControl.ScaleMode, vbContainerPosition), ScaleY(y + lab.Top, UserControl.ScaleMode, vbContainerPosition))
End Sub

Private Sub lab_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
   RaiseEvent MouseMove(Button, Shift, ScaleX(x + lab.Left, UserControl.ScaleMode, vbContainerPosition), ScaleY(y + lab.Top, UserControl.ScaleMode, vbContainerPosition))
End Sub

Private Sub lab_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
   RaiseEvent MouseUp(Button, Shift, ScaleX(x + lab.Left, UserControl.ScaleMode, vbContainerPosition), ScaleY(y + lab.Top, UserControl.ScaleMode, vbContainerPosition))
End Sub

Private Sub m_opcBMP_Click()
   Dim Cancel As Boolean
   DoEvents
   RaiseEvent OptionSelected(B_DIGITALIZA, -1, Cancel)
   If Not Cancel Then
      Qualidade = 0                               'bmp não usa
      Call FazScan
   End If
End Sub

Private Sub opc_jpg_Click(Index As Integer)
   Dim Cancel As Boolean
   DoEvents
   Qualidade = Index * 20 + 10                    'apura os números 10,30,50,70 e 90
   RaiseEvent OptionSelected(B_DIGITALIZA, Qualidade, Cancel)
   If Cancel Then Exit Sub
   cboTipo.ListIndex = Index + 1
   Call FazScan
End Sub

Private Sub pic_Click(Index As Integer)
   RaiseEvent Click
End Sub

Private Sub pic_DblClick(Index As Integer)
   RaiseEvent DblClick
End Sub

Private Sub pic_MouseDown(Index As Integer, Button As Integer, Shift As Integer, x As Single, y As Single)
   If Button = vbRightButton And gLocked = False And UserControl.Extender.WhatsThisHelpID <> -1 Then
      PopupMenu m_Opcoes
   End If
   RaiseEvent MouseDown(Button, Shift, ScaleX(x + pic(Index).Left, UserControl.ScaleMode, vbContainerPosition), ScaleY(y + pic(Index).Top, UserControl.ScaleMode, vbContainerPosition))
End Sub

Private Sub pic_MouseMove(Index As Integer, Button As Integer, Shift As Integer, x As Single, y As Single)
   RaiseEvent MouseMove(Button, Shift, ScaleX(x + pic(Index).Left, UserControl.ScaleMode, vbContainerPosition), ScaleY(y + pic(Index).Top, UserControl.ScaleMode, vbContainerPosition))
End Sub

Private Sub pic_MouseUp(Index As Integer, Button As Integer, Shift As Integer, x As Single, y As Single)
   RaiseEvent MouseUp(Button, Shift, ScaleX(x + pic(Index).Left, UserControl.ScaleMode, vbContainerPosition), ScaleY(y + pic(Index).Top, UserControl.ScaleMode, vbContainerPosition))
End Sub

Private Sub scrH_Change()
   ScrollH scrH.Value
End Sub

Private Sub scrH_Scroll()
   ScrollH scrH.Value
End Sub

Private Sub scrV_Scroll()
   ScrollV scrV.Value
End Sub

Private Sub scrV_Change()
   ScrollV scrV.Value
End Sub

Public Property Get hWnd() As Long
Attribute hWnd.VB_UserMemId = -515
   hWnd = UserControl.hWnd
End Property

Public Property Get hdc() As Long
   hdc = UserControl.hdc
End Property

Public Property Get ShapeBorderColor() As OLE_COLOR
   ShapeBorderColor = shp.BorderColor
End Property

Public Property Let ShapeBorderColor(ByVal New_ShapeBorderColor As OLE_COLOR)
   shp.BorderColor() = New_ShapeBorderColor
   PropertyChanged "ShapeBorderColor"
End Property

Public Property Get ShapeBorderWidth() As Integer
   ShapeBorderWidth = shp.BorderWidth
End Property

Public Property Let ShapeBorderWidth(ByVal New_ShapeBorderWidth As Integer)
   shp.BorderWidth() = New_ShapeBorderWidth
   UserControl_Resize
   PropertyChanged "ShapeBorderWidth"
End Property

Public Property Get ShapeBorderStyle() As GMMTipoBordaShape
   ShapeBorderStyle = shp.BorderStyle
End Property

Public Property Let ShapeBorderStyle(ByVal New_ShapeBorderStyle As GMMTipoBordaShape)
   shp.BorderStyle() = New_ShapeBorderStyle
   PropertyChanged "ShapeBorderStyle"
End Property

Public Property Get CaptionColor() As OLE_COLOR
   CaptionColor = lab.ForeColor
End Property

Public Property Let CaptionColor(ByVal New_CaptionColor As OLE_COLOR)
   lab.ForeColor() = New_CaptionColor
   PropertyChanged "CaptionColor"
End Property

Public Property Get CaptionFont() As Font
   Set CaptionFont = lab.Font
End Property

Public Property Set CaptionFont(ByVal New_CaptionFont As Font)
   Set lab.Font = New_CaptionFont
   UserControl_Resize
   PropertyChanged "CaptionFont"
End Property

Public Property Get Font() As Font
   Set Font = labNomeMM.Font
End Property

Public Property Set Font(ByVal New_Font As Font)
   Set labNomeMM.Font = New_Font
   PropertyChanged "Font"
End Property

Public Property Get Enabled() As Boolean
Attribute Enabled.VB_UserMemId = -514
   Enabled = UserControl.Enabled
End Property

Public Property Let Enabled(ByVal New_Enabled As Boolean)
   UserControl.Enabled() = New_Enabled
   bot.Enabled() = New_Enabled
   scrH.Enabled() = New_Enabled
   scrV.Enabled() = New_Enabled
   lab.Enabled() = New_Enabled
   PropertyChanged "Enabled"
End Property

Private Sub UserControl_EnterFocus()
   shp.FillColor = gColorOnFocus
   shp.FillStyle = gFillStyleOnFocus
End Sub

Private Sub UserControl_ExitFocus()
   shp.FillColor = gColorNoFocus
   shp.FillStyle = gFillStyleNoFocus
End Sub

Private Sub UserControl_Initialize()
   gColorNoFocus = &HFF&
   gColorOnFocus = &HFF00&
   gFillStyleOnFocus = GMMEstiloShape.Transparent
   gFillStyleNoFocus = GMMEstiloShape.Transparent
   shp.Shape = m_def_Shape
   shp.FillColor = gColorNoFocus
   shp.FillStyle = gFillStyleNoFocus
   pic(0).BackColor = &H8000000F
   pic(1).BackColor = &H8000000F
   img.Stretch = True
   gScrollBars = True
   gEditable = True
   gLargeChange = 0
   gAppearance = [3D]
   gBorderStyle = [Fixed single]
   scrH.SmallChange = 20
   scrV.SmallChange = 20

   'enche combo
   cboTipo.AddItem "BMP (Bitmap)"
   cboTipo.AddItem "JPG-Maximum (- quality)"
   cboTipo.AddItem "JPG-High-medium"
   cboTipo.AddItem "JPG-Medium"
   cboTipo.AddItem "JPG-Low-medium"
   cboTipo.AddItem "JPG-Low (+ quality)"
   cboTipo.ListIndex = 3                          'default=compac media
   
   If Not VBDesignMode Then                       'se não for design, vamos carregar os hints
      cboTipo.ToolTipText = LoadGasString(1239)
      
      'hints
      botMM(B_ABRE).ToolTipText = LoadGasString(1230)
      botMM(B_CARREGA).ToolTipText = LoadGasString(1231)
      botMM(B_DIGITALIZA).ToolTipText = LoadGasString(1232)
      botMM(B_RETIRA).ToolTipText = LoadGasString(1233)
      botMM(B_IMPRIME).ToolTipText = LoadGasString(1234)
      botMM(B_EXPORTA).ToolTipText = LoadGasString(1235)
      botMM(B_TOOLBAR).ToolTipText = LoadGasString(1238)
      
      chkMM(B_IMAGEMPARC).ToolTipText = LoadGasString(1236)
      chkMM(B_MAXIMIZA).ToolTipText = LoadGasString(1237)
      botSalva.ToolTipText = LoadGasString(1240)
      botCancela.ToolTipText = LoadGasString(1241)
   End If
End Sub

Private Sub UserControl_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
   RaiseEvent MouseUp(Button, Shift, x, y)
End Sub

Public Property Get CaptionOffset() As Integer
   CaptionOffset = gCaptionOffSet
End Property

Public Property Let CaptionOffset(ByVal New_CaptionOffset As Integer)
   gCaptionOffSet = New_CaptionOffset
   UserControl_Resize
   PropertyChanged "CaptionOffSet"
End Property

Public Property Get DataField() As String
   DataField = gDataField
End Property

Public Property Let DataField(ByVal New_DataField As String)
   gDataField = New_DataField
   PropertyChanged "DataField"
End Property

Public Property Get FileType() As Integer
   FileType = 1
End Property

Public Property Let FileType(ByVal New_FileType As Integer)
   '====???
   PropertyChanged "FileType"
End Property

Public Property Get MousePointer() As GMMTipoMouse
   MousePointer = UserControl.MousePointer
End Property

Public Property Let MousePointer(ByVal New_MousePointer As GMMTipoMouse)
   UserControl.MousePointer() = New_MousePointer
   PropertyChanged "MousePointer"
End Property

Private Sub UserControl_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
   RaiseEvent MouseMove(Button, Shift, x, y)
   DoEvents
End Sub

Public Property Get MouseIcon() As Picture
   Set MouseIcon = UserControl.MouseIcon
End Property

Public Property Set MouseIcon(ByVal New_MouseIcon As Picture)
   Set UserControl.MouseIcon = New_MouseIcon
   PropertyChanged "MouseIcon"
End Property

Public Property Get SmallChange() As Integer
   SmallChange = scrH.SmallChange
End Property

Public Property Let SmallChange(ByVal New_SmallChange As Integer)
   scrH.SmallChange() = New_SmallChange
   scrV.SmallChange() = New_SmallChange
   PropertyChanged "SmallChange"
End Property

Private Sub LigaDesligaScr()
   If img.Stretch = False And gScrollBars Then
      Set bot.Picture = pic(1).MouseIcon
      bot.Visible = True
      scrV.Visible = True
      scrH.Visible = True
   Else
      bot.Visible = False
      scrV.Visible = False
      scrH.Visible = False
   End If
End Sub

'Initialize Properties for User Control
Private Sub UserControl_InitProperties()
   gSituacao = 0
   gScrollBars = True
   gEditable = True
   gCaptionOffSet = m_def_CaptionOffset
   gDataField = ""
   gAlignment = m_def_Alignment
End Sub

'Load property values from storage
Private Sub UserControl_ReadProperties(PropBag As PropertyBag)
   Dim i As Long
   gSituacao = 0
   gLargeChange = PropBag.ReadProperty("LargeChange", 0)
   UserControl.Enabled = PropBag.ReadProperty("Enabled", True)
   UserControl.MousePointer = PropBag.ReadProperty("MousePointer", 0)
   Set MouseIcon = PropBag.ReadProperty("MouseIcon", Nothing)
   scrH.SmallChange = PropBag.ReadProperty("SmallChange", 1)
   scrV.SmallChange = scrH.SmallChange
   gCaptionOffSet = PropBag.ReadProperty("CaptionOffSet", m_def_CaptionOffset)
   gDataField = PropBag.ReadProperty("DataField", "")
   gColorOnFocus = PropBag.ReadProperty("ColorOnFocus", &HFF00&)
   lab.Caption = PropBag.ReadProperty("Caption", "")
   lab.ForeColor = PropBag.ReadProperty("CaptionColor", &H80000012)
   Set lab.Font = PropBag.ReadProperty("CaptionFont", Ambient.Font)
   Set labNomeMM.Font = PropBag.ReadProperty("Font", labNomeMM.Font)
   gColorNoFocus = PropBag.ReadProperty("ColorNoFocus", &HFF&)
   gAppearance = PropBag.ReadProperty("Appearance", [3D])
   gAlignment = PropBag.ReadProperty("Alignment", m_def_Alignment)
   gBorderStyle = PropBag.ReadProperty("BorderStyle", [Fixed single])
   shp.Shape = PropBag.ReadProperty("Shape", m_def_Shape)
   shp.BorderColor = PropBag.ReadProperty("ShapeBorderColor", &H80000008)
   shp.BorderWidth = PropBag.ReadProperty("ShapeBorderWidth", 1)
   shp.BorderStyle = PropBag.ReadProperty("ShapeBorderStyle", 1)
   gFillStyleOnFocus = PropBag.ReadProperty("FillStyleOnFocus", 1)
   gFillStyleNoFocus = PropBag.ReadProperty("FillStyleNoFocus", 1)
   img.Stretch = PropBag.ReadProperty("Stretch", True)
   shp.FillStyle = gFillStyleNoFocus
   shp.FillColor = gColorNoFocus
   pic(0).BackColor = PropBag.ReadProperty("BackColor", &H8000000F)
   pic(1).BackColor = pic(0).BackColor
   gHasToolBar = PropBag.ReadProperty("HasToolBar", False)
   gMediaFilter = PropBag.ReadProperty("MediaFilter", "")
   gDisplayImages = PropBag.ReadProperty("DisplayImages", True)
   gAllowMaximize = PropBag.ReadProperty("AllowMaximize", True)
   gToolBarVisible = PropBag.ReadProperty("ToolBarVisible", False)
   gLocked = PropBag.ReadProperty("Locked", False)
   gEditable = PropBag.ReadProperty("Editable", True)
   gScrollBars = PropBag.ReadProperty("ScrollBars", True)
   bot.Enabled() = UserControl.Enabled
   scrH.Enabled() = UserControl.Enabled
   scrV.Enabled() = UserControl.Enabled
   lab.Enabled() = UserControl.Enabled
   pic(0).LinkTimeOut = PropBag.ReadProperty("LinkTimeOut", 50)
   pic(1).LinkTimeOut = pic(0).LinkTimeOut
   ScanOk = ScanPresente

   m_opc(B_DISPLAYIMG).Checked = gDisplayImages
   chkMM(B_MAXIMIZA).Enabled = gAllowMaximize
   m_opc(B_MAXIMIZA).Enabled = gAllowMaximize
   
   'monta nome temporário com o temppath do windows
   gDirTemp$ = Space$(256)
   i = GetTempPath(256, gDirTemp$)
   If i = 0 Then
      gDirTemp$ = "C:\"
   Else
      gDirTemp$ = Left$(gDirTemp$, i)
      If Right$(gDirTemp$, 1) <> "\" Then gDirTemp$ = gDirTemp$ + "\"
   End If

   picTools.Visible = gToolBarVisible

   gMaximizado = False

   If Not VBDesignMode Then                       'só se não for design
      AcertaTitMenus
      MontaFiltroArqs                             'enche sfilter
      AcertaCaption
      AcertaOpcoesMenu
   End If
End Sub

'troca caracter por outro, dentro da string
Private Function Troca(Alvo As String, OQue As String, PeloQue As String) As String
   Dim x As String, p As Integer                         'dimensiona
   x$ = Alvo$
   p = InStr(x$, OQue$)                                  'vamos trocar
   While p > 0                                           'todos de uma vez
      x$ = Left$(x$, p - 1) + PeloQue$ + Mid$(x$, p + Len(OQue$)) 'quantas vezes necessário
      p = InStr(p + Len(PeloQue$), x$, OQue$)                     'na string alvo
   Wend
   Troca$ = x$                                    'retorna a nova string
End Function

Private Sub MontaFiltroArqs()
   Dim x As String, k As String
   If Len(gMediaFilter) > 0 Then
      x$ = LoadGasString(1229)                    'arquivos
      k$ = gMediaFilter
      gFilter = "|"
      Do While Len(k$) > 0
         gFilter = gFilter + "*." + ParseFilt(k$) + ";"
      Loop
      k$ = Troca$(gMediaFilter, "|", "/")
      gFilter = ParseFilt$(x$) + " " + k$ + Left$(gFilter, Len(gFilter) - 1)
   Else
      x$ = LoadGasString(1201)                    '1201 "Imagens|Clipe de som|Clipe de vídeo|Documentos|Planilhas|Compactados|Todos os arquivos"
      gFilter = ParseFilt$(x$) + "|*.bmp;*.dib;*.gif;*.jpg;*.wmf;*.emf;*.ico;*.cur|" + _
                ParseFilt$(x$) + "|*.wav;*.mid;*.mp3|" + _
                ParseFilt$(x$) + "|*.avi;*.mpg|" + _
                ParseFilt$(x$) + "|*.doc;*.rtf;*.txt;*.htm;*.wkb;*.hlp;*.pdf;*.awd|" + _
                ParseFilt$(x$) + "|*.xls;*.wk*;*.cal|" + _
                ParseFilt$(x$) + "|*.arj;*.zip;*.rar;*.lha;*.arc|" + _
                x$ + "|*.*"
   End If
End Sub

'parseia string vgSt$
Private Function ParseFilt(vgSt As String) As String
   Dim i As Integer
   i = InStr(vgSt, "|")
   If i > 0 Then
      ParseFilt$ = Left$(vgSt, i - 1)
      vgSt = Mid$(vgSt, i + 1)
   Else
      ParseFilt$ = vgSt
      vgSt = ""
   End If
End Function
   
Private Sub AcertaOpcoesMenu()
   Dim Ok As Boolean, NArq As String, i As Integer
   'prepara menu popup para mídia
   NArq$ = NomePuro$
   If Len(NArq$) > 0 Then NArq$ = ": " + NArq$
   m_opc(B_CARREGA).Enabled = (gEditable = True)  'carregar
   m_opc(B_DIGITALIZA).Enabled = (gEditable = True) And ScanOk And _
                                 (InStr(gMediaFilter, "BMP") > 0 Or _
                                 InStr(gMediaFilter, "JPG") > 0 Or gMediaFilter = "")
   If ETipoImagem <> IMG_NAO Then
      m_opc(B_IMPRIME).Caption = LoadGasString(1215) + NArq$
      m_opc(B_EXPORTA).Caption = LoadGasString(1216) + NArq$
      Ok = (img.Picture <> 0 Or imgIcone.Picture <> 0) And gSituacao = 1
      m_opc(B_ABRE).Enabled = Ok                  'abrir
      m_opc(B_EXPORTA).Enabled = Ok               'abrir
      m_opc(B_RETIRA).Enabled = (img.Picture <> 0) And (gEditable = True) 'retirar
      m_opc(B_IMPRIME).Enabled = Ok And gDisplayImages                    'só se mostra pictures
      m_opc(B_IMAGEMPARC).Enabled = m_opc(B_IMPRIME).Enabled              'só se mostra pictures
      m_opc(B_MAXIMIZA).Enabled = Ok And gAllowMaximize And gDisplayImages
      m_opc(B_ABRE).Caption = LoadGasString(1209) + NArq$
   Else
      Ok = (imgIcone.Picture <> 0) And gSituacao = 1
      m_opc(B_ABRE).Caption = LoadGasString(1209) + NArq$
      m_opc(B_ABRE).Enabled = Ok                                          'abrir
      m_opc(B_RETIRA).Enabled = (imgIcone.Picture <> 0) And (gEditable = True) 'ret midia
      m_opc(B_IMPRIME).Enabled = False                                         'imprimir      (so pic)
      m_opc(B_EXPORTA).Caption = LoadGasString(1216) + NArq$                   'exp
      m_opc(B_EXPORTA).Enabled = Ok                                            'exp
      m_opc(B_IMAGEMPARC).Enabled = False                                      'img parcial
      m_opc(B_MAXIMIZA).Enabled = gAllowMaximize And m_opc(B_MAXIMIZA).Caption = LoadGasString(1208)
   'maximizar
   End If
   m_opc(B_TOOLBAR).Visible = gHasToolBar                                      'linha sep - menus visiveis ou nao se tem toolbar
   m_opc(B_TOOLBAR).Visible = gHasToolBar
   m_opc(B_TOOLBAR).Checked = gToolBarVisible
   
   'hints
   botMM(B_ABRE).ToolTipText = LoadGasString(1230) + NArq$
   botMM(B_IMPRIME).ToolTipText = LoadGasString(1234) + NArq$
   botMM(B_EXPORTA).ToolTipText = LoadGasString(1235) + NArq$
   'sincroniza enables
   For i = 0 To 11
      If i = 0 Or i = 2 Or i = 4 Or i = 5 Or i = 7 Or i = 8 Or i = 12 Then     'esses nao tem
         botMM(i).Enabled = m_opc(i).Enabled
      End If
   Next
   chkMM(B_IMAGEMPARC).Enabled = m_opc(B_IMAGEMPARC).Enabled
   chkMM(B_MAXIMIZA).Enabled = m_opc(B_MAXIMIZA).Enabled
   cboTipo.Enabled = botMM(B_DIGITALIZA).Enabled                               'combo
End Sub

'acerta menus de acordo com a lingua
Private Sub AcertaTitMenus()
   Dim i As Integer
   m_Opcoes.Caption = LoadGasString(1210)
   m_opc(0).Caption = LoadGasString(1209)
   For i = 0 To 3                                 'de seleciona origem a retirar
      m_opc(i + 2).Caption = LoadGasString(1211 + i)
   Next
   For i = 0 To 3                                 'de imp a maxim
      m_opc(i + 7).Caption = LoadGasString(1215 + i)
   Next
   m_opc(B_TOOLBAR).Caption = LoadGasString(1219)
   m_opc(B_DISPLAYIMG).Caption = LoadGasString(1220)
   m_opcJPG.Caption = LoadGasString(1227)         'jpg...
   For i = 0 To 4
      opc_jpg(i).Caption = LoadGasString(1242 + i)
   Next
End Sub

'coloca GMMAparencia 3d no controle
Private Sub Coloca3D(Limpar As Boolean)
   Dim x As Single, y As Single, x1 As Single, y1 As Single
   If gAppearance = [3D] And gBorderStyle <> None Then
      pic(0).AutoRedraw = True
      If Limpar Then pic(0).Cls
      x1 = (pic(0).DrawWidth * Screen.TwipsPerPixelX)
      y1 = (pic(0).DrawWidth * Screen.TwipsPerPixelY)
      pic(0).Line (0, pic(0).Height)-(0, 0), vb3DShadow
      pic(0).Line -(pic(0).Width - x1, 0), vb3DShadow
      pic(0).Line -(pic(0).Width - x1, pic(0).Height - y1), vb3DHighlight
      pic(0).Line -(0, pic(0).Height - y1), vb3DHighlight
      x = pic(0).DrawWidth * Screen.TwipsPerPixelX
      y = pic(0).DrawWidth * Screen.TwipsPerPixelY
      pic(0).Line (x, pic(0).Height - y - y1)-(x, y), vb3DDKShadow
      pic(0).Line -(pic(0).Width - x - x1, y), vb3DDKShadow
      pic(0).Line -(pic(0).Width - x - x1, Height - y - y1), vb3DLight
      pic(0).Line -(x, Height - y - y1), vb3DLight
      pic(0).AutoRedraw = False
   ElseIf gBorderStyle = [Fixed single] Then
      pic(0).AutoRedraw = True
      If Limpar Then pic(0).Cls
      x1 = (pic(0).DrawWidth * Screen.TwipsPerPixelX)
      y1 = (pic(0).DrawWidth * Screen.TwipsPerPixelY)
      pic(0).Line (0, pic(0).Height)-(0, 0), vb3DDKShadow
      pic(0).Line -(pic(0).Width - x1, 0), vb3DDKShadow
      pic(0).Line -(pic(0).Width - x1, pic(0).Height - y1), vb3DDKShadow
      pic(0).Line -(0, pic(0).Height - y1), vb3DDKShadow
      pic(0).AutoRedraw = False
   End If
End Sub

Private Sub UserControl_Resize()
   Dim i As Long, TmLbl As Integer, AlLbl As Integer, AlShp As Integer, TmShp As Integer, LargBordaShape As Integer, _
       MA As Integer, ML As Integer, SepLab As Integer, AltMin As Integer, LargMin As Integer, _
       ComShp As Integer, x As Single, y As Single, PosiYPic As Integer
   AlLbl = 0
   TmLbl = 0
   AlShp = 0
   SepLab = 0
   LargBordaShape = 0
   MA = 0
   ML = 0
   ComShp = 0
   AltMin = TextHeight("0")
   LargMin = TextWidth("0")
   If gAppearance = [3D] And gBorderStyle <> None Then
      AltMin = AltMin + ((4 * pic(0).DrawWidth) * Screen.TwipsPerPixelX)
      LargMin = LargMin + ((4 * pic(0).DrawWidth) * Screen.TwipsPerPixelY)
   ElseIf gBorderStyle = [Fixed single] Then
      AltMin = AltMin + ((2 * pic(0).DrawWidth) * Screen.TwipsPerPixelX)
      LargMin = LargMin + ((2 * pic(0).DrawWidth) * Screen.TwipsPerPixelY)
   End If
   If Len(lab.Caption) > 0 Then                                       'se tem caption
      ComShp = (gFillStyleOnFocus <> GMMEstiloShape.Transparent Or gFillStyleNoFocus <> GMMEstiloShape.Transparent)
      SepLab = gCaptionOffSet                                         'espaco entre o caption e o textbox
      If gAlignment = [Field Top] Or gAlignment = [Field Bottom] Then 'label no topo ou fundo
         AlLbl = lab.Height + SepLab
      Else                                        'label na esq ou dir
         If gFillStyleOnFocus <> GMMEstiloShape.Transparent Or gFillStyleNoFocus <> GMMEstiloShape.Transparent Then
            AlLbl = lab.Height
         End If
         TmLbl = lab.Width + SepLab               'soma separacao no tamanho
      End If

      'se vai ter shape?
      If ComShp Then
         LargBordaShape = (shp.BorderWidth * Screen.TwipsPerPixelX) 'lagura da borda do shape
         AlShp = 2 * SepLab                                         'pedaco adicional para o shp passar a cima do lbl
         AlLbl = AlLbl + AlShp + LargBordaShape                     'soma tudo no tamanho do lbl
         i = UserControl.ScaleWidth - TmLbl - IIf(gAlignment = [Field Bottom] Or gAlignment = [Field Top], lab.Width, 0) - 200 'tamanho provavel do textbox
         If i < 250 Then i = 250                  'valor minimo para colocar o inico do shp
         TmShp = IIf(i < 600, i / 3, 200)         'pedaco entre o fim do lbl e o fim do shp
         TmLbl = TmLbl + TmShp + LargBordaShape   'calcula tamaho total do lbl+outros
      End If
   End If
   'calcula posi da pic(0)
   If gToolBarVisible Then
      picTools.Move Screen.TwipsPerPixelX, Screen.TwipsPerPixelY, ScaleWidth - Screen.TwipsPerPixelX
      PosiYPic = picTools.Height + AlLbl
   Else
      PosiYPic = AlLbl
   End If
   'tamanho mimimo do controle
   i = Int(((LargMin + TmLbl + IIf(gAlignment = [Field Bottom] Or gAlignment = [Field Top], lab.Width, 0) + IIf(img.Stretch = False And gScrollBars, scrV.Width, 0)) / Screen.TwipsPerPixelX) + 0.5) * Screen.TwipsPerPixelX
   If UserControl.Width < i Then UserControl.Width = i

   'altura minima do controle
   i = Int(((AltMin + AlLbl + IIf(img.Stretch = False And gScrollBars, scrH.Height, 0)) / Screen.TwipsPerPixelY) + 0.5) * Screen.TwipsPerPixelY
   If UserControl.Height < i Then UserControl.Height = i

   pic(0).Top = IIf(gAlignment = [Field Bottom], 0, PosiYPic) 'topo do text box (a pic so e' o 3d)
   pic(0).Left = IIf(gAlignment = [Field Right], 0, TmLbl)

   If img.Stretch = False And gScrollBars Then
      ML = scrV.Width
      MA = scrH.Height
   End If

   i = UserControl.ScaleWidth - TmLbl - ML
   If i < LargMin Then i = LargMin                            'que 195 forca 195
   pic(0).Width = i + ML
   i = UserControl.ScaleHeight - PosiYPic - MA                'idem para a altura
   If i < AltMin Then i = AltMin
   pic(0).Height = i + MA

   If Len(lab.Caption) > 0 Then                               'tem caption?

      'calcula altura e tamanho do shape
      shp.Width = TmLbl + (2 * TmShp) + IIf(gAlignment = [Field Bottom] Or gAlignment = [Field Top], lab.Width, 0)
      shp.Height = AlLbl + (AltMin / 2)
      If gAlignment = [Field Bottom] Then                     'se lbl no topo
         shp.Top = (pic(0).Top + pic(0).Height) + AlLbl - shp.Height - (LargBordaShape / 2) 'acerta posicoes do shp e lbl
         lab.Top = pic(0).Top + pic(0).Height + SepLab
      Else
         lab.Top = pic(0).Top - IIf(gAlignment = [Field Top], (SepLab + lab.Height), IIf(ComShp And (gAlignment = [Field Left] Or gAlignment = [Field Right]), lab.Height, 0))
         shp.Top = LargBordaShape / 2
      End If
      If gAlignment = [Field Right] Then
         lab.Left = (pic(0).Left + pic(0).Width) + SepLab
         shp.Left = lab.Left + lab.Width + TmShp - shp.Width
      Else
         lab.Left = IIf(gAlignment = [Field Left], shp.Top + TmShp, pic(0).Left)
         shp.Left = LargBordaShape / 2
      End If
      lab.ZOrder 0
      lab.Refresh
   End If
   If gAppearance = [3D] And gBorderStyle <> None Then
      y = ((2 * pic(0).DrawWidth) * Screen.TwipsPerPixelY)
      x = ((2 * pic(0).DrawWidth) * Screen.TwipsPerPixelX)
   ElseIf gBorderStyle = [Fixed single] Then
      y = ((1 * pic(0).DrawWidth) * Screen.TwipsPerPixelY)
      x = ((1 * pic(0).DrawWidth) * Screen.TwipsPerPixelX)
   Else
      x = 0: y = 0
   End If
   pic(1).Move x, y, pic(0).ScaleWidth - (2 * y), pic(0).ScaleHeight - (2 * x)
   If img.Stretch = False And gScrollBars Then
      img.Move 0, 0
      scrV.Move pic(1).ScaleWidth - scrV.Width, 0, scrV.Width, pic(1).ScaleHeight - scrH.Height
      scrH.Move 0, pic(1).ScaleHeight - scrH.Height, pic(1).ScaleWidth - scrV.Width, scrH.Height
      scrH.Value = scrH.Min
      scrV.Value = scrV.Min
      If img.Width <= (pic(1).ScaleWidth - scrV.Width) Then
         scrH.Enabled = False
      Else
         scrH.Enabled = True
         scrH.Max = img.Width - (pic(1).ScaleWidth - scrV.Width)
         If gLargeChange = 0 Then
            scrH.LargeChange = pic(1).ScaleWidth
         Else
            scrH.LargeChange = gLargeChange
         End If
      End If
      If img.Height <= (pic(1).ScaleHeight - scrH.Height) Then
         scrV.Enabled = False
      Else
         scrV.Enabled = True
         scrV.Max = img.Height - (pic(1).ScaleHeight - scrH.Height)
         If gLargeChange = 0 Then
            scrV.LargeChange = pic(1).ScaleHeight
         Else
            scrV.LargeChange = gLargeChange
         End If
      End If
      bot.Move scrH.Width, scrH.Top, scrV.Width, scrH.Height
   Else
      img.Move 0, 0, pic(1).ScaleWidth, pic(1).ScaleHeight
   End If
   Call PosicionaIconeMidia
   Coloca3D True
End Sub

Private Sub UserControl_Show()
   LigaDesligaScr
   UserControl_Resize
End Sub

'Write property values to storage
Private Sub UserControl_WriteProperties(PropBag As PropertyBag)
   Call PropBag.WriteProperty("BackColor", pic(0).BackColor, &H8000000F)
   Call PropBag.WriteProperty("LinkTimeOut", pic(0).LinkTimeOut, 50)
   Call PropBag.WriteProperty("MediaFilter", gMediaFilter, "")
   Call PropBag.WriteProperty("DisplayImages", gDisplayImages, True)
   Call PropBag.WriteProperty("AllowMaximize", gAllowMaximize, True)
   Call PropBag.WriteProperty("HasToolBar", gHasToolBar, False)
   Call PropBag.WriteProperty("ToolBarVisible", gToolBarVisible, False)
   Call PropBag.WriteProperty("Locked", gLocked, False)
   Call PropBag.WriteProperty("Editable", gEditable, True)
   Call PropBag.WriteProperty("ScrollBars", gScrollBars, True)
   Call PropBag.WriteProperty("LargeChange", gLargeChange, 0)
   Call PropBag.WriteProperty("Enabled", UserControl.Enabled, True)
   Call PropBag.WriteProperty("MousePointer", UserControl.MousePointer, 0)
   Call PropBag.WriteProperty("Appearance", gAppearance, [3D])
   Call PropBag.WriteProperty("MouseIcon", MouseIcon, Nothing)
   Call PropBag.WriteProperty("BorderStyle", gBorderStyle, [Fixed single])
   Call PropBag.WriteProperty("SmallChange", scrH.SmallChange, 1)
   Call PropBag.WriteProperty("CaptionOffSet", gCaptionOffSet, m_def_CaptionOffset)
   Call PropBag.WriteProperty("DataField", gDataField, "")
   Call PropBag.WriteProperty("Caption", lab.Caption, "")
   Call PropBag.WriteProperty("CaptionColor", lab.ForeColor, &H80000012)
   Call PropBag.WriteProperty("CaptionFont", lab.Font, Ambient.Font)
   Call PropBag.WriteProperty("Font", labNomeMM.Font, labNomeMM.Font)
   Call PropBag.WriteProperty("ColorNoFocus", gColorNoFocus, &HFF&)
   Call PropBag.WriteProperty("ColorOnFocus", gColorOnFocus, &HFF00&)
   Call PropBag.WriteProperty("Alignment", gAlignment, m_def_Alignment)
   Call PropBag.WriteProperty("Shape", shp.Shape, m_def_Shape)
   Call PropBag.WriteProperty("ShapeBorderColor", shp.BorderColor, &H80000008)
   Call PropBag.WriteProperty("ShapeBorderWidth", shp.BorderWidth, 1)
   Call PropBag.WriteProperty("ShapeBorderStyle", shp.BorderStyle, 1)
   Call PropBag.WriteProperty("FillStyleOnFocus", gFillStyleOnFocus, 1)
   Call PropBag.WriteProperty("FillStyleNoFocus", gFillStyleNoFocus, 1)
   Call PropBag.WriteProperty("Stretch", img.Stretch, True)
End Sub

Public Property Get BorderStyle() As GMMTipoBordaMM
   BorderStyle = gBorderStyle
End Property

Public Property Let BorderStyle(ByVal New_BorderStyle As GMMTipoBordaMM)
   gBorderStyle = New_BorderStyle
   UserControl_Resize
   PropertyChanged "BorderStyle"
End Property

Public Property Get Appearance() As GMMAparencia
   Appearance = gAppearance
End Property

Public Property Let Appearance(ByVal New_Appearance As GMMAparencia)
   gAppearance = New_Appearance
   UserControl_Resize
   PropertyChanged "Appearance"
End Property

Public Property Get Caption() As String
Attribute Caption.VB_UserMemId = -518
   Caption = lab.Caption
End Property

Public Property Let Caption(ByVal New_Caption As String)
   lab.Caption() = New_Caption
   AcertaCaption
   UserControl_Resize
   UserControl.Refresh
   PropertyChanged "Caption"
End Property

Private Sub AcertaCaption()
   lab.Visible = (Len(lab.Caption) > 0)
   shp.Visible = (Len(lab.Caption) > 0 And (gFillStyleOnFocus <> GMMEstiloShape.Transparent Or gFillStyleNoFocus <> GMMEstiloShape.Transparent))
End Sub

Public Property Get Alignment() As GMMTipoAlinhamento
   Alignment = gAlignment
End Property

Public Property Let Alignment(ByVal New_Alignment As GMMTipoAlinhamento)
   gAlignment = New_Alignment
   UserControl_Resize
   PropertyChanged "Alignment"
End Property

Public Property Get FillStyleOnFocus() As GMMEstiloShape
   FillStyleOnFocus = gFillStyleOnFocus
End Property

Public Property Let FillStyleOnFocus(ByVal New_FillStyleOnFocus As GMMEstiloShape)
   gFillStyleOnFocus = New_FillStyleOnFocus
   shp.FillStyle = gFillStyleOnFocus
   AcertaCaption
   UserControl_Resize
   PropertyChanged "FillStyleOnFocus"
End Property

Public Property Get FillStyleNoFocus() As GMMEstiloShape
   FillStyleNoFocus = gFillStyleNoFocus
End Property

Public Property Let FillStyleNoFocus(ByVal New_FillStyleNoFocus As GMMEstiloShape)
   gFillStyleNoFocus = New_FillStyleNoFocus
   AcertaCaption
   UserControl_Resize
   PropertyChanged "FillStyleNoFocus"
End Property

Public Property Get Shape() As GMMTipoShape
   Shape = shp.Shape
End Property

Public Property Let Shape(ByVal New_Shape As GMMTipoShape)
   shp.Shape = New_Shape
   PropertyChanged "Shape"
End Property

'centraliza o icone
Private Sub PosicionaIconeMidia()
   If pic(1).Height > 480 + labNomeMM.Height Then  'se cabe icone grande+nome,
      imgIcone.Move (pic(1).ScaleWidth - imgIcone.Width) / 2, (pic(1).ScaleHeight - imgIcone.Height) / 2
      labNomeMM.Move (pic(1).ScaleWidth - labNomeMM.Width) / 2, imgIcone.Top + imgIcone.Height
   Else                                            'img peq tem 240
      imgIcone.Move 15, (pic(1).ScaleHeight - imgIcone.Height) / 2
      labNomeMM.Move 15 + imgIcone.Width, (pic(1).ScaleHeight - labNomeMM.Height) / 2
   End If
End Sub

'esta função vai só mostrar o ícone do arquivo associado no
'campo destinado ao blob...
Private Sub MostraIconeMidia()
   Dim x As String, T As Integer, fCriou As Boolean
   On Error GoTo ErroLoadPic
   'cria um arquivo zerado so para pegar icone prog associado
   fCriou = False
   If Len(ArqMidia$) > 0 Then
      If Len(Dir$(ArqMidia$)) = 0 Then            'nao tem o arquivo
         T = FreeFile
         Open ArqMidia$ For Output As #T          'cria um zerado
         Close
         fCriou = True
      End If
   End If
   x$ = NomePuro$
   labNomeMM.Caption = x$
   If pic(1).Height > 480 + labNomeMM.Height Then 'se cabe icone grande+nome,
      imgIcone.Picture = GetIcon(ArqMidia$, SHGFI_LARGEICON)
   Else                                           'img peq tem 240
      imgIcone.Picture = GetIcon(ArqMidia$, SHGFI_SMALLICON) 'pega icone pequeno e alinha texto a direita
   End If
   Call PosicionaIconeMidia
   If fCriou Then Kill ArqMidia$                             'agora mata arq criado para pegar ico
   imgIcone.Visible = True
   labNomeMM.Visible = True
   img.Visible = False                                       'esconde picture
   Set img.Picture = LoadPicture("")
   DoEvents
   Exit Sub

ErroLoadPic:
   Set img.Picture = Nothing
End Sub

Public Sub Clear()
   Set Picture = LoadPicture("")
End Sub

've se é BMP/WMF/DIB gravado no bd
Private Function BlobComBMP() As Boolean
   Dim x As String, Assina As String, Chk() As Byte
   ReDim Chk(3) As Byte
   'assinatura de imagens gravadas como bmp/wmf/dib
   Assina$ = Chr$(&H6C) + Chr$(&H74) + Chr$(0) + Chr$(0)
   If ETipoMDB Then
      Chk() = gDataSource.Fields(gDataField).GetChunk(0, 4)   'pega assinatura
   Else
      gDataSource.BookMark = gDataSource.BookMark
      Chk() = gDataSource.Fields(gDataField).GetChunk(4)      'pega assinatura
   End If
   x$ = Chr$(Chk(0)) + Chr$(Chk(1)) + Chr$(Chk(2)) + Chr$(Chk(3)) 'assinatura no blob
   BlobComBMP = (x$ = Assina$)
End Function

'método chamado para pegar a mídia do banco e mostrar imagem ou mostrar icone outras midias
Public Sub ShowMedia()
   Dim offExtrai As Integer
   On Error GoTo DeuErro
   ArqMidia$ = ""
   If Not IsNull(gDataSource.Fields(gDataField)) Then
      If BlobComBMP Then                          'trata tipos bmp/wmf/dib...
         offExtrai = PegaNomeRealBMP              'enche ArqMidia$ e pera offset de onde começa figuras bmp/wmf/dib
      Else
         offExtrai = PegaNomeMidia                'idem para outras midias
      End If
   End If
   If Len(ArqMidia$) = 0 Then
   
DeuErro:
      ArqMidia$ = ""
      gSituacao = 0
      Clear
   Else
      gSituacao = 1
      If ETipoImagem <> IMG_NAO And gDisplayImages Then
         img.Visible = True                       'mostra imagem para picture
         imgIcone.Visible = False                 'esconde imagem de ícone
         labNomeMM.Visible = False
         ExtraiMidiaBD offExtrai, EX_MATA         'extrai a midia a partir de offExtrai (tama do nome do arquivo) e mata...
      Else                                        'outras mídias, mostra só o ícone associado...
         img.Visible = False
         On Error Resume Next
         Call MostraIconeMidia                    'arq já existia (?) so mostra..
      End If
   End If
   UserControl_Resize
   AcertaOpcoesMenu
End Sub

'Pega tamanho em bytes
Private Function CVL(x As String) As Double
   Dim i As Integer, j As Integer, P1 As Long, P2 As Long, p3 As Long, p4 As Long
   For i = 1 To 4
      j = Asc(Mid$(x$, i, 1))
      Select Case i
         Case 1
            P1 = j
         Case 2
            P2 = 256# * j
         Case 3
            p3 = 65536# * j
         Case 4
            p4 = 4294967296# * j
      End Select
   Next
   CVL = Int(P1 + P2 + p3 + p4)
End Function

'pega tamanho pelo header do blob (so bmp/wmf/dib)
Private Function PegaTamaRealBMP() As Long
   Dim Chk() As Byte
   Dim x As String, i As Integer
   ReDim Chk(3)
   If ETipoMDB Then
      Chk() = gDataSource.Fields(gDataField).GetChunk(4, 4)   'tamanho do nome do arquivo bmp/wmf/dib
   Else
      gDataSource.BookMark = gDataSource.BookMark
      Chk() = gDataSource.Fields(gDataField).GetChunk(4)      'le duas vezes para pegar
      Chk() = gDataSource.Fields(gDataField).GetChunk(4)      'bytes de 4 a 8
   End If
   x$ = ""
   For i = 0 To 3
      x$ = x$ + Chr$(Chk(i))
   Next
   PegaTamaRealBMP = CVL(x$)
End Function

'pega nome real do BMP/WMF/DIB e enche a pública ArqMidia$
'retorna offset para extrair midia
Private Function PegaNomeRealBMP() As Long
   Dim Chk() As Byte, i As Integer, lOffset As Long, qLer As Long, lTama As Long
   'monta nome do arqmidia$
   lTama = PegaTamaRealBMP                        'apura o tamanho real do bmp
   If ETipoMDB Then
      ReDim Chk(255) As Byte                      'para pegar o nome do arquivo
      Chk() = gDataSource.Fields(gDataField).GetChunk(lTama + 8, 255) 'tamanho do nome do arquivo
   Else
      'posiciona no nome do arquivo...
      lOffset = 8
      qLer = CHUNKSIZE
      If lTama < qLer Then qLer = lTama
      ReDim Chk(qLer - 1)
      Chk() = gDataSource.Fields(gDataField).GetChunk(qLer)
      lOffset = lOffset + qLer
      Do While lOffset < lTama
         If (lTama + 8) - lOffset < qLer Then qLer = (lTama + 8) - lOffset
         ReDim Chk(qLer - 1) As Byte
         Chk() = gDataSource.Fields(gDataField).GetChunk(qLer)
         lOffset = lOffset + qLer
      Loop
      ReDim Chk(255) As Byte
      Chk() = gDataSource.Fields(gDataField).GetChunk(255)            'tamanho do nome do arquivo
      gDataSource.BookMark = gDataSource.BookMark                     'reseta GMMTipoMouse dentro do blob
   End If
   'cria arqmidia$
   ArqMidia$ = ""
   For i = 0 To UBound(Chk)
      If Chk(i) <> 0 Then
         ArqMidia$ = ArqMidia$ + Chr$(Chk(i))
      Else
         Exit For
      End If
   Next
   ArqMidia$ = gDirTemp$ + ArqMidia$                                  'nome arqmidia para BMP/WMF/DIB
   PegaNomeRealBMP = 7                                                'offset é fixo, no caso desses arquivos
End Function

'pega nome real da midia e enche a pública ArqMidia$
'retorna offset para extrair midia
Private Function PegaNomeMidia() As Long
   Dim Chk() As Byte, i As Integer, tNomeArq As Integer
   ReDim Chk(0) As Byte
   If ETipoMDB Then
      Chk() = gDataSource.Fields(gDataField).GetChunk(0, 1)    'tamanho do nome do arquivo
   Else
      gDataSource.BookMark = gDataSource.BookMark
      Chk() = gDataSource.Fields(gDataField).GetChunk(1)       'tamanho do nome do arquivo
   End If
   tNomeArq = Chk(0)                                           'salva tamanho
   ReDim Chk(tNomeArq + 1) As Byte                             'vamos encher com o nome do arq
   If ETipoMDB Then
      Chk() = gDataSource.Fields(gDataField).GetChunk(1, tNomeArq) 'tamanho do nome do arquivo
   Else
      Chk() = gDataSource.Fields(gDataField).GetChunk(tNomeArq)    'tamanho do nome do arquivo
   End If
   ArqMidia$ = ""
   For i = 0 To tNomeArq - 1                                       'recupera nome do arquivo original
      ArqMidia$ = ArqMidia$ + Chr$(Chk(i))
   Next
   ArqMidia$ = gDirTemp$ + ArqMidia$                               'junta com dir temporário..
   PegaNomeMidia = tNomeArq                                        'retorna offset para extrair
End Function

Private Function BMPHeader(n As Double) As String
   Dim x As String, j As Integer, B(3) As Byte, b4 As Double
   b4# = 65536# ^ 2
   B(3) = Int(n / b4#)
   n = n - (B(3) * b4#)
   B(2) = Int(n / 65536#)
   n = n - (B(2) * 65536#)
   B(1) = Int(n / 256#)
   n = n - (B(1) * 256#)
   B(0) = n
   x$ = Chr$(&H6C) + Chr$(&H74) + Chr$(&H0) + Chr$(&H0)  '3 bytes de header
   For j = 0 To 3                          
      x$ = x$ + Chr$(B(j))
   Next
   BMPHeader = x$
End Function

Public Sub SaveMedia()
   Dim Ar As Integer, NArq As String, i As Integer, Chunk() As Byte
   Dim Fl As Long, NChunks As Integer, Fragmento As Integer
   If gSituacao = 2 Then
      gDataSource.Fields(gDataField) = Null
   Else
      If Len(Trim$(ArqMidia$)) = 0 Or Len(Dir$(ArqMidia$)) = 0 Then
         Exit Sub                                 'zerado...
      End If
      Ar = FreeFile
      Open ArqMidia$ For Binary Access Read As #Ar
      Fl = LOF(Ar)                                ' tamanho do arquivo
      If Fl = 0 Then
         Close Ar
         Exit Sub
      End If
      Screen.MousePointer = vbHourglass
      NChunks = Fl \ (CHUNKSIZE)
      Fragmento = Fl Mod (CHUNKSIZE)
      If ETipoImagem = IMG_BMP Then               'prop so figura
         NArq$ = BMPHeader$((Fl))
         ReDim Chunk(Len(NArq$) - 1) As Byte
         For i = 1 To Len(NArq$)                  'header do bmp
            Chunk(i - 1) = Asc(Mid$(NArq$, i, 1))
         Next
      Else
         NArq$ = Mid$("\" + ArqMidia$, InStrRev("\" + ArqMidia$, "\") + 1) 'extrai só o nome arq
         NArq$ = Left$(Trim$(NArq$), 255)                                  'máximo 255 + 1 byte de tamanho
         ReDim Chunk(Len(NArq$)) As Byte
         Chunk(0) = Len(NArq$)                                             'tamanho
         For i = 1 To Len(NArq$)
            Chunk(i) = Asc(Mid$(NArq$, i, 1))
         Next
      End If
      gDataSource.Fields(gDataField).AppendChunk Chunk()                   'tamanho+nome do arquivo
      ReDim Chunk(Fragmento - 1)                                           'pedaço (começa de 0)
      Get Ar, , Chunk()
      gDataSource.Fields(gDataField).AppendChunk Chunk()                   'poe pedaço
      ReDim Chunk(CHUNKSIZE - 1)
      For i = 1 To NChunks
         Get Ar, , Chunk()                                                 'e os demais buffers
         gDataSource.Fields(gDataField).AppendChunk Chunk()
      Next
      If ETipoImagem = IMG_BMP Then                                        'so bmp/wmf/dib
         NArq$ = NomePuro$
         ReDim Chunk(Len(NArq$) - 1) As Byte
         For i = 1 To Len(NArq$)
            Chunk(i - 1) = Asc(Mid$(NArq$, i, 1))
         Next
         gDataSource.Fields(gDataField).AppendChunk Chunk()
      End If
      Close Ar
      Screen.MousePointer = vbDefault
   End If
   AcertaOpcoesMenu                               'acerta opções do popmenu
   
End Sub

Private Function GetTempFile() As String
   Dim vgRetVal As String, i As Long
   vgRetVal = String(255, " ")
   GetTempFileName gDirTemp$, "PicTemp.bmp", 0, vgRetVal$
   i = InStr(vgRetVal$, Chr$(0))
   If i Then
      vgRetVal$ = Left$(vgRetVal$, i - 1)
   End If
   GetTempFile = vgRetVal$
End Function

Public Sub LoadMedia(ByVal NomeMidia As Variant)
   If VarType(NomeMidia) = vbString Then
      ArqMidia$ = NomeMidia
   Else
      On Error Resume Next
      Set Picture = NomeMidia
      ArqMidia$ = gDirTemp$ + "PicTemp.bmp"        'GetTempFile()
      SavePicture img.Picture, ArqMidia$
      If Err Then
         Err.Clear
         Err.Raise Err.Number                      'passa o erro para aplic
         Exit Sub
      End If
   End If
   Call SaveMedia
   If Err = 0 Then Call ShowMedia
End Sub

'antes de chamar tem de encher a pública arqmidia$
Private Function ETipoImagem() As Integer
   Dim x As String, RetVal As Integer
   x$ = UCase$(Right$(ArqMidia$, 4))
   RetVal = IMG_NAO
   If Len(x$) > 0 Then
      If InStr(".BMP/.DIB/.WMF", x$) > 0 Then
         RetVal = IMG_BMP
      ElseIf InStr(".GIF/.JPG/.EMF/.ICO/.CUR", x$) > 0 Then
         RetVal = IMG_OUTRAS
      End If
   End If
   ETipoImagem = RetVal
End Function

'convert um handle de icone em IPictureDisp
Private Function IconToPicture(hIcon As Long) As IPictureDisp
   Dim cls_id As CLSID
   Dim hRes As Long
   Dim new_icon As TypeIcon
   Dim lpUnk As IUnknown
   With new_icon
      .cbSize = Len(new_icon)
      .picType = vbPicTypeIcon
      .hIcon = hIcon
   End With
   With cls_id
      .id(8) = &HC0
      .id(15) = &H46
   End With
   hRes = OleCreatePictureIndirect(new_icon, cls_id, 1, lpUnk)
   If hRes = 0 Then Set IconToPicture = lpUnk
End Function

Private Function GetIcon(filename As String, icon_size As Long) As IPictureDisp
   Dim hIcon As Long
   Dim icon_pic As IPictureDisp
   Dim sh_info As SHFILEINFO
   SHGetFileInfo filename, 0, sh_info, Len(sh_info), SHGFI_ICON + icon_size
   hIcon = sh_info.hIcon
   Set icon_pic = IconToPicture(hIcon)
   Set GetIcon = icon_pic
End Function

'posi inicial = inicio do dado descontando o len e nome do arquivo original...
Private Sub ExtraiMidiaBD(PosiInicial As Integer, QAcao As ModoExtraiMidiaBD)
   Dim Ar As Integer, Chunk() As Byte, lTama As Long
   Dim lOffset As Long, qLer As Long

   On Error Resume Next
   qLer = CHUNKSIZE
   Screen.MousePointer = vbHourglass
   Ar = FreeFile
   Open ArqMidia$ For Binary Access Write As #Ar

   'tentou gravar e está tocando (NUNCA!)
   If Err.Number = 70 Then
      Close Ar
      MsgBox LoadGasString(1202) & Err.Number & vbCrLf & _
             LoadGasString(1203), vbCritical, LoadGasString(1225)
      Err.Clear
      Exit Sub
   End If
   'capta tamanho
   If ETipoImagem = IMG_BMP Then
      lTama = PegaTamaRealBMP
   Else
      If ETipoMDB Then
         lTama = gDataSource.Fields(gDataField).FieldSize - PosiInicial - 1
      Else
         gDataSource.BookMark = gDataSource.BookMark
         lTama = gDataSource.Fields(gDataField).ActualSize - 1
         gDataSource.Fields(gDataField).GetChunk PosiInicial + 1
      End If
   End If
   lOffset = PosiInicial + 1                      'aponta para o inicio do dado
   
   If ETipoImagem = IMG_BMP Then                  'tira imagem normal...
      If lTama < qLer Then qLer = lTama
      ReDim Chunk(qLer - 1)
      If ETipoMDB Then
         Chunk() = gDataSource.Fields(gDataField).GetChunk(lOffset, qLer)
      Else
         Chunk() = gDataSource.Fields(gDataField).GetChunk(qLer)
      End If
      Put #Ar, , Chunk()
      lOffset = lOffset + qLer
      Do While lOffset < lTama + 8                '8 bytes
         If (lTama + 8) - lOffset < qLer Then qLer = (lTama + 8) - lOffset
         ReDim Chunk(qLer - 1)
         If ETipoMDB Then
            Chunk() = gDataSource.Fields(gDataField).GetChunk(lOffset, qLer)
         Else
            Chunk() = gDataSource.Fields(gDataField).GetChunk(qLer)
         End If
         Put #Ar, , Chunk()
         lOffset = lOffset + qLer
      Loop
   Else
      If lTama < qLer Then qLer = lTama
      ReDim Chunk(qLer - 1)
      If ETipoMDB Then
         Chunk() = gDataSource.Fields(gDataField).GetChunk(lOffset, qLer) 'vamos ler a partir do nome do arquivo
      Else
         Chunk() = gDataSource.Fields(gDataField).GetChunk(qLer)          'vamos ler a partir do nome do arquivo
      End If
      Put #Ar, , Chunk()
      lOffset = lOffset + qLer
      Do While lOffset < lTama
         If (lTama + PosiInicial + 1) - lOffset < qLer Then qLer = (lTama + PosiInicial + 1) - lOffset
         ReDim Chunk(qLer - 1)
         If ETipoMDB Then
            Chunk() = gDataSource.Fields(gDataField).GetChunk(lOffset, qLer)
         Else
            Chunk() = gDataSource.Fields(gDataField).GetChunk(qLer)
         End If
         Put #Ar, , Chunk()
         lOffset = lOffset + qLer
      Loop
   End If
   Close #Ar
   Screen.MousePointer = vbDefault

   'agora mostra ou toca...
   If ETipoImagem <> IMG_NAO Then
      If QAcao <> EX_NADA Then
         If QAcao = EX_TOCA_MATA Then
            Call ExecutaMultiMidia
         Else
            Set Picture = LoadPicture(ArqMidia$)                          'mostra e mata
            On Error Resume Next
            Kill ArqMidia$
         End If
      End If
   Else
      If QAcao <> EX_NADA Then
         Call ExecutaMultiMidia                                           'executa... síncrono e mata
      End If
   End If

End Sub

Private Sub ExecutaMultiMidia()
   Dim DataHoraArq As Variant                     'vamos gerenciar data/hora do arquivo editado...
   Dim lResult As Long
   Dim sI As SHELLEXECUTEINFO
   DataHoraArq = FileDateTime(ArqMidia$)          'salva data e hora
   sI.cbSize = Len(sI)
   sI.fMask = SEE_MASK_FLAG_DDEWAIT Or SEE_MASK_NOCLOSEPROCESS
   sI.hWnd = 0
   sI.lpVerb = "open"
   sI.lpFile = ArqMidia$
   sI.lpParameters = vbNullString
   sI.lpDirectory = vbNullString
   sI.nShow = SW_SHOWNORMAL
   'zero out other fields
   sI.lpIDList = 0
   sI.lpClass = vbNullString
   sI.hkeyClass = 0
   sI.dwHotKey = 0
   sI.hIcon = 0
   sI.hProcess = 0
   RaiseEvent OpenMedia(1)
   
   lResult = ShellExecuteEx(sI)
   
   If lResult = 1 And sI.hProcess = 0 And sI.hInstApp <> 0 Then 'conseguiu carregar com sucesso, mas não tem o handle do proc... vamos cair fora
      RaiseEvent OpenMedia(-3)                                  'vamos voltar erro!!!
      GoTo FimDaSub
   Else
      m_opc(B_ABRE).Enabled = False                             'desabilita opcao "Abrir"
      Do While lResult <> 0
         lResult = WaitForSingleObject(sI.hProcess, 200)
         DoEvents
      Loop
      CloseHandle (lResult)
   End If
   
   'fechou a aplicação...
   If DataHoraArq <> FileDateTime(ArqMidia$) Then               'editou o arquivo...
      If ETipoImagem <> IMG_NAO And gDisplayImages Then         'se for imagem, poe na tela a nova imagem...
         Set Picture = LoadPicture(ArqMidia$)
      End If
      RaiseEvent Change
      botSalva.Enabled = True
      botCancela.Enabled = True
   Else                                           'já que nao editou, mata aqui..
      On Error Resume Next
      Kill ArqMidia$                              'mata do temporário...
   End If
   
FimDaSub:
   
   RaiseEvent OpenMedia(2)
   m_opc(B_ABRE).Enabled = True                   'habilita opcao "Abrir"
   On Error Resume Next
   UserControl.Extender.Parent.SetFocus           'joga o foco para o form
End Sub

'mostra interface explorer
'Parâmetro Qual =...
'0=Default, 1=Desktop, 2=Programas..., 3=Painel de controle, 4=Printers
'5=Documentos, 6=Favoritos, 7=Iniciar, 8=Recentes, 9=Enviar para, 10=Lixeira
'11=Menu iniciar, 12=Desktop, 13=Meu computador, 14=Ambiente da rede, 15=Toda a rede
'16=Fontes, 17=Shell new
Private Function PegaFolder(Qual As Integer, Tit As String) As String
   Dim nFolder As Long, bi As BROWSEINFO, idl As ITEMIDLIST, rtn As Long, pidl As Long, _
       path As String, x As String
   'save the value of the system folder to begin dialog display from
   If Qual = 1 Then
      nFolder& = 0
   ElseIf Qual < 12 Then
      nFolder& = Qual
   Else
      nFolder& = Qual + 4
   End If
   bi.hOwner = UserControl.Extender.Parent.hWnd
      
   'seta o limite do browse do diálogo
   'neste caso se Qual = 0 (Default), bi.pidlRoot será Null
   If Qual Then
      rtn& = SHGetSpecialFolderLocation(ByVal UserControl.Extender.Parent.hWnd, ByVal nFolder&, idl)
      bi.pidlRoot = idl.mkid.cb
   End If
   
   'mensagem do diálogo
   bi.lpszTitle = Tit$
   
   'seta o tipo de folder a retornar
   bi.ulFlags = BIF_RETURNONLYFSDIRS              'BIF_RETURNFSANCESTORS 'BIF_BROWSEFORPRINTER + BIF_DONTGOBELOWDOMAIN
   
   'show the browse folder dialog
   pidl& = SHBrowseForFolder(bi)
   
   'pega folder selecionado
   path$ = Space$(512)
   rtn& = SHGetPathFromIDList(ByVal pidl&, ByVal path$)
   If rtn& Then
      x$ = Left(path$, InStr(path$, Chr$(0)) - 1)
      If Right$(x$, 1) <> "\" Then x$ = x$ + "\"
      PegaFolder$ = x$
   Else
      PegaFolder$ = ""
   End If
End Function

Public Function BMPparaJPG() As Boolean
   Dim vgSaveJPG As New IntelJpg
   vgSaveJPG.CreateFromPicture img.Picture
   If vgSaveJPG.SaveJPG(ArqMidia$, Qualidade) Then
      BMPparaJPG = True
   Else                                           'erro
      MsgBox LoadGasString(1222), vbExclamation, LoadGasString(1225)
   End If
   Set vgSaveJPG = Nothing
End Function

Private Function ScanPresente() As Boolean
   Dim vgRetVal As Boolean
   If TWAIN_IsAvailable = 1 Then
      vgRetVal = True
      TWAIN_RegisterApp 1, 0, TWLG_POR, TWCY_BRAZIL, "v1.00", "GAS Informática", "GAS", "GCPMM"
   Else
      vgRetVal = False
   End If
   If Err Then Err.Clear
   ScanPresente = vgRetVal
End Function

'executa o scan
Private Sub FazScan()
   Dim ArqAntes As String
   On Error Resume Next
   ArqAntes$ = ArqMidia$                          'salva nome
   ArqMidia$ = GetTempFile()
   If Qualidade = 0 Then
      ArqMidia$ = Mid(ArqMidia$, 1, Rat(ArqMidia$, ".")) + "BMP"
   Else
      ArqMidia$ = Mid(ArqMidia$, 1, Rat(ArqMidia$, ".")) + "JPG"
   End If
   If Len(Dir$(ArqMidia$)) Then Kill ArqMidia$    'mata arq temp anterior
   'faz scan
   TWAIN_AcquireToFilename UserControl.Extender.Parent.hWnd, ArqMidia$
   If Err Then Err.Clear
   If Len(Dir$(ArqMidia$)) = 0 Then
      ArqMidia$ = ArqAntes$                       'erro - restaura nome
      MsgBox LoadGasString(1224), vbCritical, LoadGasString(1225)
   Else
      If ETipoImagem <> IMG_NAO Then              'é imagem...
         Screen.MousePointer = vbHourglass
         Set Picture = LoadPicture(ArqMidia$)     'coloca figura no controle
         If Err Then
            Err.Clear
            MsgBox LoadGasString(1224), vbCritical, LoadGasString(1225)
            Screen.MousePointer = vbDefault
            Exit Sub
         End If
         If Qualidade > 0 Then                    'e é JPG! - converte
            On Error Resume Next
            If Len(Dir$(ArqMidia$)) Then Kill ArqMidia$ 'mata o bmp
            ArqMidia$ = Left$(ArqMidia$, Len(ArqMidia$) - 3) + "jpg"
            If BMPparaJPG() Then
               Set Picture = LoadPicture(ArqMidia$)     'coloca figura no controle
               RaiseEvent Change                        'hab gravar
               botSalva.Enabled = True
               botCancela.Enabled = True
            End If
         Else                                           'é tipo bmp nao converte
            RaiseEvent Change                           'hab gravar
            botSalva.Enabled = True
            botCancela.Enabled = True
         End If
         If Not gDisplayImages Then                     'nao
            Set Picture = LoadPicture("")               'tira a pic e mostra o icone
            Call MostraIconeMidia
         End If
         Screen.MousePointer = vbDefault
      Else                                              'outros blobs...
         Call MostraIconeMidia                          'mostra outros tipos
      End If
      UserControl_Resize
   End If
End Sub
