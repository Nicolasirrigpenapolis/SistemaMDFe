VERSION 5.00
Begin VB.UserControl GListV 
   BackColor       =   &H80000015&
   BorderStyle     =   1  'Fixed Single
   ClientHeight    =   1500
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   2985
   KeyPreview      =   -1  'True
   ScaleHeight     =   1500
   ScaleWidth      =   2985
   ToolboxBitmap   =   "GLISTV.ctx":0000
   Begin VB.Timer timRefresh 
      Enabled         =   0   'False
      Interval        =   500
      Left            =   0
      Top             =   0
   End
   Begin VB.PictureBox picSel 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   435
      Left            =   360
      ScaleHeight     =   435
      ScaleWidth      =   1425
      TabIndex        =   0
      Top             =   630
      Width           =   1425
      Begin VB.PictureBox picEdit 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   0
         ScaleHeight     =   255
         ScaleWidth      =   1425
         TabIndex        =   1
         TabStop         =   0   'False
         Top             =   90
         Width           =   1425
         Begin VB.TextBox txtEdit 
            Appearance      =   0  'Flat
            BackColor       =   &H000000FF&
            BorderStyle     =   0  'None
            Height          =   195
            Left            =   60
            TabIndex        =   2
            TabStop         =   0   'False
            Top             =   30
            Width           =   495
         End
         Begin VB.CommandButton bottxtCampo 
            Height          =   195
            Index           =   0
            Left            =   1140
            Style           =   1  'Graphical
            TabIndex        =   4
            TabStop         =   0   'False
            Top             =   30
            Width           =   255
         End
         Begin VB.TextBox txtEditMult 
            Appearance      =   0  'Flat
            BackColor       =   &H000000FF&
            BorderStyle     =   0  'None
            Height          =   195
            Left            =   600
            MultiLine       =   -1  'True
            ScrollBars      =   2  'Vertical
            TabIndex        =   3
            TabStop         =   0   'False
            Top             =   30
            Width           =   495
         End
      End
   End
   Begin VB.PictureBox picStatus 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BorderStyle     =   0  'None
      BeginProperty DataFormat 
         Type            =   0
         Format          =   ""
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1046
         SubFormatType   =   0
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   315
      Left            =   360
      ScaleHeight     =   315
      ScaleWidth      =   1425
      TabIndex        =   9
      TabStop         =   0   'False
      Top             =   1110
      Width           =   1425
      Begin VB.PictureBox picTop 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   30
         ScaleHeight     =   225
         ScaleWidth      =   1335
         TabIndex        =   10
         TabStop         =   0   'False
         Top             =   30
         Width           =   1365
         Begin VB.TextBox txtTop 
            Alignment       =   1  'Right Justify
            Appearance      =   0  'Flat
            BackColor       =   &H000000FF&
            BorderStyle     =   0  'None
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   6.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   180
            Left            =   30
            TabIndex        =   11
            TabStop         =   0   'False
            Top             =   30
            Width           =   1275
         End
      End
   End
   Begin VB.PictureBox picMove 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   315
      Left            =   1860
      ScaleHeight     =   315
      ScaleWidth      =   1065
      TabIndex        =   8
      TabStop         =   0   'False
      Top             =   1110
      Visible         =   0   'False
      Width           =   1065
   End
   Begin VB.PictureBox picFilter 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BorderStyle     =   0  'None
      BeginProperty DataFormat 
         Type            =   0
         Format          =   ""
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1046
         SubFormatType   =   0
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   360
      ScaleHeight     =   255
      ScaleWidth      =   1425
      TabIndex        =   14
      TabStop         =   0   'False
      Top             =   330
      Width           =   1425
      Begin VB.CommandButton botFilter 
         Height          =   195
         Index           =   0
         Left            =   1140
         Style           =   1  'Graphical
         TabIndex        =   12
         TabStop         =   0   'False
         Top             =   30
         Visible         =   0   'False
         Width           =   255
      End
      Begin VB.TextBox txtFilter 
         Appearance      =   0  'Flat
         BackColor       =   &H000000FF&
         BorderStyle     =   0  'None
         Height          =   195
         Index           =   0
         Left            =   60
         TabIndex        =   13
         Top             =   30
         Visible         =   0   'False
         Width           =   1035
      End
   End
   Begin VB.PictureBox picFundo 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BorderStyle     =   0  'None
      BeginProperty DataFormat 
         Type            =   0
         Format          =   ""
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1046
         SubFormatType   =   0
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   915
      Left            =   1860
      ScaleHeight     =   915
      ScaleWidth      =   1065
      TabIndex        =   7
      TabStop         =   0   'False
      Top             =   90
      Width           =   1065
   End
   Begin VB.PictureBox picHeader 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BorderStyle     =   0  'None
      BeginProperty DataFormat 
         Type            =   0
         Format          =   ""
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1046
         SubFormatType   =   0
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   195
      Left            =   360
      ScaleHeight     =   195
      ScaleWidth      =   1425
      TabIndex        =   6
      TabStop         =   0   'False
      Top             =   90
      Width           =   1425
   End
   Begin VB.PictureBox picBarra 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BorderStyle     =   0  'None
      BeginProperty DataFormat 
         Type            =   0
         Format          =   ""
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1046
         SubFormatType   =   0
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   1335
      Left            =   60
      ScaleHeight     =   1335
      ScaleWidth      =   225
      TabIndex        =   5
      TabStop         =   0   'False
      Top             =   90
      Width           =   225
   End
   Begin VB.Menu M_Menu 
      Caption         =   "GLISTV"
      Visible         =   0   'False
      Begin VB.Menu M_Option 
         Caption         =   "Remove Top"
         Index           =   0
      End
      Begin VB.Menu M_Option 
         Caption         =   "-"
         Index           =   1
      End
      Begin VB.Menu M_Option 
         Caption         =   "Show Filter Bar"
         Index           =   2
      End
      Begin VB.Menu M_Option 
         Caption         =   "Status Bar"
         Index           =   3
      End
      Begin VB.Menu M_Option 
         Caption         =   "-"
         Index           =   4
      End
      Begin VB.Menu M_Option 
         Caption         =   "Sum Bar"
         Index           =   5
      End
      Begin VB.Menu M_Option 
         Caption         =   "Max Bar"
         Index           =   6
      End
      Begin VB.Menu M_Option 
         Caption         =   "Min Bar"
         Index           =   7
      End
      Begin VB.Menu M_Option 
         Caption         =   "Avg Bar"
         Index           =   8
      End
      Begin VB.Menu M_Option 
         Caption         =   "-"
         Index           =   9
      End
      Begin VB.Menu M_Option 
         Caption         =   "Special Options"
         Index           =   10
         Begin VB.Menu M_Special 
            Caption         =   "Stripes"
            Index           =   0
         End
         Begin VB.Menu M_Special 
            Caption         =   "-"
            Index           =   1
         End
         Begin VB.Menu M_Special 
            Caption         =   "Save Bars"
            Index           =   2
         End
         Begin VB.Menu M_Special 
            Caption         =   "Save Cols"
            Index           =   3
         End
         Begin VB.Menu M_Special 
            Caption         =   "Save Stripes"
            Index           =   4
         End
         Begin VB.Menu M_Special 
            Caption         =   "-"
            Index           =   5
         End
         Begin VB.Menu M_Special 
            Caption         =   "Restore"
            Index           =   6
         End
      End
   End
   Begin VB.Menu M_MenuCol 
      Caption         =   "GLISTVCOL"
      Begin VB.Menu M_ColOption 
         Caption         =   "Sum Value"
         Index           =   0
      End
      Begin VB.Menu M_ColOption 
         Caption         =   "Max Value"
         Index           =   1
      End
      Begin VB.Menu M_ColOption 
         Caption         =   "Min Value"
         Index           =   2
      End
      Begin VB.Menu M_ColOption 
         Caption         =   "Avg Value"
         Index           =   3
      End
      Begin VB.Menu M_ColOption 
         Caption         =   "-"
         Index           =   4
      End
      Begin VB.Menu M_ColOption 
         Caption         =   "Ord Asc"
         Index           =   5
      End
      Begin VB.Menu M_ColOption 
         Caption         =   "Ord Desc"
         Index           =   6
      End
   End
End
Attribute VB_Name = "GListV"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'* Sistema...: Emissor de Nota Fiscal Eletronica
'* Empresa...: Ygor Eduardo Dellalio
'* Módulo....: GListV
'* Função....: Controle listview virtual
'* CopyRight.: (C)2016 Ygor Eduardo Dellalio
'* Criação...: GAS-2007 - Gerador Automático de Sistemas
'* Data......: 23/05/2016 15:26:10
'* * * * * * *
Option Explicit
DefInt A-Z

Implements GSubClassInterface

'constantes/estruturas/enumerações para header
Private Const CCM_FIRST = &H2000                                    '// Common control shared Messages
Private Const CCM_SETUNICODEFORMAT = (CCM_FIRST + 5)
Private Const CCM_GETUNICODEFORMAT = (CCM_FIRST + 6)
Private Const DEFAULT_PITCH = 0

'constantes para definições de colunas (header)
Private Const HDI_WIDTH = &H1
Private Const HDI_TEXT = &H2

Private Const WHEEL_DELTA = 120

Private Enum HEADER_MESSAGES
   HDM_FIRST = &H1200                                              '// Header Messages
   HDM_GETITEMCOUNT = (HDM_FIRST + 0)
   HDM_INSERTITEMA = (HDM_FIRST + 1)
   HDM_INSERTITEMW = (HDM_FIRST + 10)
   HDM_INSERTITEM = HDM_INSERTITEMA
   HDM_DELETEITEM = (HDM_FIRST + 2)
   HDM_GETITEMA = (HDM_FIRST + 3)
   HDM_GETITEMW = (HDM_FIRST + 11)
   HDM_GETITEM = HDM_GETITEMA
   HDM_SETITEMA = (HDM_FIRST + 4)
   HDM_SETITEMW = (HDM_FIRST + 12)
   HDM_SETITEM = HDM_SETITEMA
   HDM_LAYOUT = (HDM_FIRST + 5)
   HDM_ORDERTOINDEX = (HDM_FIRST + 15)
   HDM_GETITEMRECT = (HDM_FIRST + 7)
   HDM_SETIMAGELIST = (HDM_FIRST + 8)
   HDM_GETIMAGELIST = (HDM_FIRST + 9)
   HDM_CREATEDRAGIMAGE = (HDM_FIRST + 16)                          '// wparam = which item (by index)
   HDM_SETHOTDIVIDER = (HDM_FIRST + 19)
   HDM_SETUNICODEFORMAT = CCM_SETUNICODEFORMAT
   HDM_GETUNICODEFORMAT = CCM_GETUNICODEFORMAT
   HDM_SETFILTERCHANGETIMEOUT = (HDM_FIRST + 22)
   HDM_EDITFILTER = (HDM_FIRST + 23)
   HDM_CLEARFILTER = (HDM_FIRST + 24)
End Enum

Public Enum GRID_NAVIGATION
   GRID_NAVIGATION_AUTO = -1
   GRID_NAVIGATION_LEFT = 0
   GRID_NAVIGATION_RIGHT = 1
   GRID_NAVIGATION_UP = 2
   GRID_NAVIGATION_DOWN = 3
End Enum

'flags para desabilitar item do popupmenu "Opções especiais"
Public Enum POP_GRID_DISABLED
   POP_GRID_COLS = 1
   POP_GRID_BARS = 2
   POP_GRID_STRIPES = 4
End Enum

Private Type HD_ITEM
   Mask As Long
   cxy As Long
   pszText As String
   hbm As Long
   cchTextMax As Long
   fmt As Long
   lParam As Long
   ' 4.70:
   iImage As Long
   iOrder As Long
End Type

'constantes/estruturas/enumerações para listview
Private Enum LVCFMT
   LVCFMT_LEFT = &H0
   LVCFMT_RIGHT = &H1
   LVCFMT_CENTER = &H2
   LVCFMT_JUSTIFYMASK = &H3
   LVCFMT_IMAGE = &H800
   LVCFMT_BITMAP_ON_RIGHT = &H1000
   LVCFMT_COL_HAS_IMAGES = &H8000
End Enum

Private Enum LVCFMASK
   LVCF_FMT = &H1
   LVCF_WIDTH = &H2
   LVCF_TEXT = &H4
   LVCF_SUBITEM = &H8
   LVCF_IMAGE = &H10
   LVCF_ORDER = &H20
End Enum

Private Type LVCOLUMN
   Mask As Long
   fmt As Long
   cx As Long
   pszText As String
   cchTextMax As Long
   iSubItem As Long
   iImage As Long
   iOrder As Long
End Type

Private Enum LVNotifications
   LVN_FIRST = -100&                                               ' &HFFFFFF9C   ' (0U-100U)
   LVN_LAST = -199&                                                ' &HFFFFFF39   ' (0U-199U)
   LVN_ITEMCHANGING = (LVN_FIRST - 0)                              ' NM_LISTVIEW
   LVN_ITEMCHANGED = (LVN_FIRST - 1)                               ' NM_LISTVIEW
   LVN_INSERTITEM = (LVN_FIRST - 2)                                ' NM_LISTVIEW
   LVN_DELETEITEM = (LVN_FIRST - 3)                                ' NM_LISTVIEW
   LVN_DELETEALLITEMS = (LVN_FIRST - 4)                            ' NM_LISTVIEW
   LVN_COLUMNCLICK = (LVN_FIRST - 8)                               ' NM_LISTVIEW
   LVN_BEGINDRAG = (LVN_FIRST - 9)                                 ' NM_LISTVIEW
   LVN_BEGINRDRAG = (LVN_FIRST - 11)                               ' NM_LISTVIEW
   LVN_ODCACHEHINT = (LVN_FIRST - 13)                              ' > 4.70
   LVN_ITEMACTIVATE = (LVN_FIRST - 14)
   LVN_ODSTATECHANGED = (LVN_FIRST - 15)
   LVN_BEGINLABELEDIT = (LVN_FIRST - 5)                            ' LV_DISPINFO
   LVN_ENDLABELEDIT = (LVN_FIRST - 6)                              ' LV_DISPINFO
   LVN_GETDISPINFO = (LVN_FIRST - 50)                              ' LV_DISPINFO
   LVN_SETDISPINFO = (LVN_FIRST - 51)                              ' LV_DISPINFO
   LVN_ODFINDITEM = (LVN_FIRST - 52)
   LVN_KEYDOWN = (LVN_FIRST - 55)                                  ' LV_KEYDOWN
   LVN_MARQUEEBEGIN = (LVN_FIRST - 56)
End Enum

Private Enum LISTVIEW_MessageS
   LVM_FIRST = &H1000
   LVM_SETBKCOLOR = (LVM_FIRST + 1)
   LVM_SETIMAGELIST = (LVM_FIRST + 3)
   LVM_GETITEMCOUNT = (LVM_FIRST + 4)
   LVM_GETITEMA = (LVM_FIRST + 5)
   LVM_SUBITEMHITTEST = (LVM_FIRST + 57)
   LVM_GETITEM = LVM_GETITEMA
   LVM_GETNEXTITEM = LVM_FIRST + 12
   LVM_SETTEXTBKCOLOR = (LVM_FIRST + 38)
   LVM_SETITEMSTATE = (LVM_FIRST + 43)
   LVM_GETSELECTEDCOUNT = (LVM_FIRST + 50)
   LVM_ENSUREVISIBLE = (LVM_FIRST + 19)
   LVM_SETITEMCOUNT = (LVM_FIRST + 47)
   LVM_GETITEMRECT = (LVM_FIRST + 14)
   LVM_SCROLL = (LVM_FIRST + 20)
   LVM_REDRAWITEMS = (LVM_FIRST + 21)
   LVM_GETTOPINDEX = (LVM_FIRST + 39)
   LVM_GETCOUNTPERPAGE = (LVM_FIRST + 40)
   LVM_HITTEST = (LVM_FIRST + 18)
   LVM_DELETEALLITEMS = (LVM_FIRST + 9)
   LVM_SETEXTENDEDLISTVIEWSTYLE = (LVM_FIRST + 54)
   LVM_GETEXTENDEDLISTVIEWSTYLE = (LVM_FIRST + 55)
   LVM_SETCOLUMN = (LVM_FIRST + 26)
   LVM_INSERTCOLUMN = (LVM_FIRST + 27)
   LVM_DELETECOLUMN = (LVM_FIRST + 28)
   LVM_GETCOLUMNWIDTH = (LVM_FIRST + 29)
   LVM_SETCOLUMNWIDTH = (LVM_FIRST + 30)
   LVM_GETHEADER = (LVM_FIRST + 31)
   LVM_GETITEMSTATE = (LVM_FIRST + 44)
   LVM_SETCOLUMNORDERARRAY = (LVM_FIRST + 58)
   LVM_GETCOLUMNORDERARRAY = (LVM_FIRST + 59)
End Enum

Private Enum LV_ITEM_mask
   LVIF_TEXT = &H1
   LVIF_IMAGE = &H2
   LVIF_PARAM = &H4
   LVIF_STATE = &H8
   LVIF_INDENT = &H10
   LVIF_NORECOMPUTE = &H800
   LVIF_DI_SETITEM = &H1000                                        ' LV_DISPINFO notification
End Enum

Private Enum LV_ITEM_state
   LVIS_FOCUSED = &H1
   LVIS_SELECTED = &H2
   LVIS_CUT = &H4
   LVIS_DROPHILITED = &H8
   LVIS_OVERLAYMASK = &HF00
   LVIS_STATEIMAGEMASK = &HF000
   LVIS_ALL = LVIS_FOCUSED Or LVIS_SELECTED Or LVIS_CUT Or LVIS_DROPHILITED Or LVIS_OVERLAYMASK Or LVIS_STATEIMAGEMASK
End Enum

Private Enum CD_DrawStage
   CDDS_PREPAINT = &H1
   CDDS_POSTPAINT = &H2
   CDDS_PREERASE = &H3
   CDDS_POSTERASE = &H4
   CDDS_ITEM = &H10000
   CDDS_ITEMPREPAINT = (CDDS_ITEM Or CDDS_PREPAINT)
   CDDS_ITEMPOSTPAINT = (CDDS_ITEM Or CDDS_POSTPAINT)
   CDDS_ITEMPREERASE = (CDDS_ITEM Or CDDS_PREERASE)
   CDDS_ITEMPOSTERASE = (CDDS_ITEM Or CDDS_POSTERASE)
   CDDS_SUBITEM = &H20000
End Enum                                                ' CD_DrawStage

Private Enum CD_ItemState
   CDIS_SELECTED = &H1                                             ' The item is selected.
   CDIS_GRAYED = &H2                                               ' The item is grayed.
   CDIS_DISABLED = &H4                                             ' The item is disabled.
   CDIS_CHECKED = &H8                                              ' The item is checked.
   CDIS_FOCUS = &H10                                               ' The item is in focus.
   CDIS_DEFAULT = &H20                                             ' The item is in its default state.
   CDIS_HOT = &H40                                                 ' The item is currently under the pointer ("hot").
   CDIS_MARKED = &H80                                              ' The item is marked. The meaning of this is up to the implementation.
   CDIS_INDETERMINATE = &H100                                      ' The item is in an indeterminate state.
End Enum

Private Type LV_ITEM
   Mask As LV_ITEM_mask
   iItem As Long
   iSubItem As Long
   State As LV_ITEM_state
   stateMask As Long
   pszText As Long                                                 ' if String, must be pre-allocated
   cchTextMax As Long
   iImage As Long
   lParam As Long
   iIndent As Long                                                 ' 4.70
End Type

Private Type NMHDR
   hwndFrom As Long
   idfrom As Long
   code As Long
End Type

Private Type MEASUREITEMSTRUCT
   CtlType As Long
   CtlID As Long
   itemID As Long
   itemWidth As Long
   itemHeight As Long
   itemData As Long
End Type

Private Type NM_LISTVIEW
   hdr As NMHDR
   iItem As Long
   iSubItem As Long
   uNewState As Long
   uOldState As Long
   uChanged As Long
   ptAction As POINTAPI
   lParam As Long
End Type

Private Type LV_DISPINFO
   hdr As NMHDR
   Item As LV_ITEM
End Type

Private Type DRAWITEMSTRUCT
   CtlType As Long
   CtlID As Long
   itemID As Long
   itemAction As Long
   itemState As Long
   hwndItem As Long
   hdc As Long
   RcItem As RECT
   itemData As Long
End Type

Private Type LVHITTESTINFO
   pt As POINTAPI
   Flags As Long
   iItem As Long
   iSubItem As Long
End Type

Private Type SCROLLINFO
   cbSize As Long
   fMask As Long
   nMin As Long
   nMax As Long
   nPage As Long
   nPos As Long
   nTrackPos As Long
End Type

Private Type InitCommonControlsExType
   dwSize As Long                                             'size of this structure
   dwICC As Long                                              'flags indicating which classes to be initialized
End Type

'definições extra para colunas
Private Type GRD_ColumnDefinition
   List As String
   Locked As Boolean
   TemporaryLocked As Boolean                                   'se coluna está bloqueada temporariamente (condição por pré-validação)
   NewText As String                                            'usado apenas para combo-box
   OriginalText As String
   NewValue As Variant
   OriginalValue As Variant
   HasInitialValue As Boolean                                   'coluna tem valor inicial (controle de sequencial)
   Changed As Boolean
   Position As Integer                                          'posição visual da coluna no grid
   OriginalPosition As Integer                                  'posição visual inicial da coluna no grid
   Order As Integer                                             '0=nenhuma, 1=crescente, -1=decrescente
   OrderPosition As Integer                                     'ordem da coluna no order by
   ComboDataBase As Variant                                     'definição de banco de dados externo (combo)
   ComboTable As String                                         'definição de tabela externa (combo)
   ComboFieldCapture As String                                  'campo a capturar
   ComboFieldsShow As String                                    'campos a mostrar
   ComboFieldsList As String                                    'campos para listar
   ComboFieldsOrder As String                                   'campos a ordenar
   ComboFieldsFilter As String                                  'filtragem
   ComboFieldsRelation  As String                               'campos para relação
   ComboExtensor As String                                      'extensor utilizado na combo
   PesqFieldCapture As String                                   'campo a capturar na pesquisa
   PesqSQLExpression As String                                  'expressão SQL para pesquisa
   PesqBD As String                                             'banco de dados para pesquisa
   PesqModoAbertura As Integer                                  'modo de abertura da pesquisa
   PesqExtensor As String                                       'extensor utilizado na pesquisa
   ActionButtonExtensor As String                               'extensor do botão de ação
   ShowSum As Boolean                                           'quer mostrar somatório da coluna
   ShowMax As Boolean                                           'quer mostrar valor máximo da coluna
   ShowMin As Boolean                                           'quer mostrar valor mínimo da coluna
   ShowAvg As Boolean                                           'quer mostrar valor médio da coluna
   ValueSum As Double                                           'somatório da coluna
   ValueMax As Double                                           'valor máximo da coluna
   ValueMin As Double                                           'valor mínimo da coluna
   ValueAvg As Double                                           'valor médio da coluna
   ValueSumSel As Double                                        'somatório da coluna para linhas Selecionada
   ValueMaxSel As Double                                        'valor máximo da coluna para linhas Selecionada
   ValueMinSel As Double                                        'valor mínimo da coluna para linhas Selecionada
   ValueAvgSel As Double                                        'valor médio da coluna para linhas Selecionada
   txtCampo As FormataCampos
   txtCampoGrd As FormataCampos
   HeaderBackColor As Long
   HeaderTextColor As Long
   BackColor As Long
   TextColor As Long
   Width As Single
   Left As Long                                                 'posição visual da esquerda da coluna
   Alignment As AlignmentConstants                              'alinhamento do conteúdo da coluna
   OriginalWidth As Single
End Type

Private Type GridColorDefinition
   TextColor As Long
   BackColor As Long
   SelectTextColor As Long
   SelectBackColor As Long
   ColumnTextColor As Long
   ColumnBackColor As Long
End Type

'constantes para informação de scroll
Private Const SB_HORZ = 0

Private Const SIF_RANGE = &H1
Private Const SIF_POS = &H4

'estilos para listview
Private Const LVS_REPORT = &H1
Private Const LVS_SINGLESEL = &H4
Private Const LVS_SHOWSELALWAYS = &H8
Private Const LVS_OWNERDATA = &H1000
Private Const LVS_OWNERDRAWFIXED = &H400
Private Const LVS_NOCOLUMNHEADER = &H4000

'estilos extendidos para listview
Private Const LVS_EX_LABELTIP = &H4000                           ' listview unfolds partly hidden labels if it does not have infotip text

'Constantes para showwindow
Private Const SW_SHOW = 5
Private Const SW_HIDE = 0

'mensagens para edit box
Private Const EM_LINEFROMCHAR = &HC9
Private Const EM_GETLINECOUNT = &HBA

'mensagens para listview (owner draw)
Private Const ODA_SELECT = &H2
Private Const ODA_DRAWENTIRE = &H1

'estilos e tipos para frame control
Private Const DFC_BUTTON = 4
Private Const DFCS_BUTTONCHECK = &H0
Private Const DFCS_CHECKED = &H400
Private Const BDR_RAISEDINNER = &H4
Private Const BDR_SUNKENOUTER = &H2
Private Const BF_BOTTOM = &H8
Private Const BF_LEFT = &H1
Private Const BF_RIGHT = &H4
Private Const BF_TOP = &H2
Private Const BF_RECT = (BF_LEFT Or BF_TOP Or BF_RIGHT Or BF_BOTTOM)

Private Const LVSCW_AUTOSIZE As Long = -1
Private Const LVSCW_AUTOSIZE_USEHEADER As Long = -2

'common control
Private Declare Function ImageList_Destroy Lib "comctl32" (ByVal hImageList As Long) As Long

'apis do windows
Private Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (hpvDest As Any, hpvSource As Any, ByVal cbCopy As Long)
Private Declare Function InitCommonControlsEx Lib "comctl32" (Init As InitCommonControlsExType) As Boolean
Private Declare Function SendMessageAPI Lib "User32.dll" Alias "SendMessageA" (ByVal hWnd As Long, ByVal Msg As Long, wParam As Any, lParam As Any) As Long
Private Declare Function GetSystemMetrics Lib "user32" (ByVal nIndex As Long) As Long
Private Declare Function SetWindowPos Lib "user32" (ByVal hWnd As Long, ByVal hWndInsertAfter As Long, ByVal x As Long, ByVal y As Long, ByVal cx As Long, ByVal cy As Long, ByVal wFlags As Long) As Long
Private Declare Function RedrawWindow Lib "user32" (ByVal hWnd As Long, lprcUpdate As Any, ByVal hrgnUpdate As Long, ByVal fuRedraw As Long) As Long
Private Declare Function CreateWindowEx Lib "user32" Alias "CreateWindowExA" (ByVal dwExStyle As Long, ByVal lpClassName As String, ByVal lpWindowName As String, ByVal dwStyle As Long, ByVal x As Long, ByVal y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hWndParent As Long, ByVal hMenu As Long, ByVal hInstance As Long, lpParam As Any) As Long
Private Declare Function DestroyWindow Lib "user32" (ByVal hWnd As Long) As Long
Private Declare Function InvalidateRect Lib "user32" (ByVal hWnd As Long, lpRect As RECT, ByVal bErase As Long) As Long
Private Declare Function GetDC Lib "user32" (ByVal hWnd As Long) As Long
Private Declare Function GetDeviceCaps Lib "GDI32" (ByVal hdc As Long, ByVal nIndex As Long) As Long
Private Declare Function ReleaseDC Lib "user32" (ByVal hWnd As Long, ByVal hdc As Long) As Long
Private Declare Function SetFocus Lib "user32" (ByVal hWnd As Long) As Long
Private Declare Function SendMessageLong Lib "user32" Alias "SendMessageA" (ByVal hWnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
Private Declare Sub GetClientRect Lib "user32" (ByVal hWnd As Long, lpRect As RECT)
Private Declare Function CreateCompatibleDC Lib "GDI32" (ByVal hdc As Long) As Long
Private Declare Function CreateCompatibleBitmap Lib "GDI32" (ByVal hdc As Long, ByVal nWidth As Long, ByVal nHeight As Long) As Long
Private Declare Function DeleteDC Lib "GDI32" (ByVal hdc As Long) As Long
Private Declare Function GetWindowRect Lib "user32" (ByVal hWnd As Long, lpRect As RECT) As Long
Private Declare Function SetTextColor Lib "GDI32" (ByVal hdc As Long, ByVal crColor As Long) As Long
Private Declare Function DrawText Lib "user32" Alias "DrawTextA" (ByVal hdc As Long, ByVal lpStr As String, ByVal nCount As Long, lpRect As RECT, ByVal wFormat As Long) As Long
Private Declare Function DrawFrameControl Lib "user32" (ByVal hdc As Long, lpRect As RECT, ByVal un1 As Long, ByVal un2 As Long) As Long
Private Declare Function DrawEdge Lib "user32" (ByVal hdc As Long, qrc As RECT, ByVal edge As Long, ByVal grfFlags As Long) As Long
Private Declare Function CreateSolidBrush Lib "GDI32" (ByVal crColor As Long) As Long
Private Declare Function FillRect Lib "user32" (ByVal hdc As Long, lpRect As RECT, ByVal hBrush As Long) As Long
Private Declare Function InflateRect Lib "user32" (lpRect As RECT, ByVal x As Long, ByVal y As Long) As Long
Private Declare Function GetCursorPos Lib "user32" (lpPoint As POINTAPI) As Long
Private Declare Function PtInRect Lib "user32" (lpRect As RECT, ByVal x As Long, ByVal y As Long) As Long
Private Declare Function ScreenToClient Lib "user32" (ByVal hWnd As Long, lpPoint As POINTAPI) As Long
Private Declare Function GetAsyncKeyState Lib "user32" (ByVal vKey As Long) As Integer
Private Declare Function GetSysColor Lib "user32" (ByVal nIndex As Long) As Long
Private Declare Function DrawFocusRect Lib "user32" (ByVal hdc As Long, lpRect As RECT) As Long
Private Declare Function CreateFont Lib "GDI32" Alias "CreateFontA" (ByVal nHeight As Long, ByVal nWidth As Long, ByVal nEscapement As Long, ByVal nOrientation As Long, ByVal fnWeight As Long, ByVal fdwItalic As Long, ByVal fdwUnderline As Long, ByVal fdwStrikeOut As Long, ByVal fdwCharSet As Long, ByVal fdwOutputPrecision As Long, ByVal fdwClipPrecision As Long, ByVal fdwQuality As Long, ByVal fdwPitchAndFamily As Long, ByVal lpszFace As String) As Long
Private Declare Function MulDiv Lib "kernel32" (ByVal nNumber As Long, ByVal nNumerator As Long, ByVal nDenominator As Long) As Long
Private Declare Function BitBlt Lib "GDI32" (ByVal hDestDC As Long, ByVal x As Long, ByVal y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal dwRop As Long) As Long
Private Declare Function DrawState Lib "user32" Alias "DrawStateA" (ByVal hdc As Long, ByVal hBrush As Long, ByVal lpDrawStateProc As Long, ByVal lParam As Long, ByVal wParam As Long, ByVal n1 As Long, ByVal n2 As Long, ByVal n3 As Long, ByVal n4 As Long, ByVal un As Long) As Long
Private Declare Function MoveToEx Lib "GDI32" (ByVal hdc As Long, ByVal x As Long, ByVal y As Long, lpPoint As POINTAPI) As Long
Private Declare Function LineTo Lib "GDI32" (ByVal hdc As Long, ByVal x As Long, ByVal y As Long) As Long
Private Declare Function CreatePen Lib "GDI32" (ByVal nPenStyle As Long, ByVal nWidth As Long, ByVal crColor As Long) As Long
Private Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)
Private Declare Sub ClipCursor Lib "user32" (lpRect As Any)
Private Declare Function SetCursorPos Lib "user32" (ByVal x As Long, ByVal y As Long) As Long
Private Declare Function GetActiveWindow Lib "user32" () As Long
Private Declare Function GetScrollInfo Lib "user32" (ByVal hWnd As Long, ByVal n As Long, lpScrollInfo As SCROLLINFO) As Long
Private Declare Function EnableWindow Lib "user32" (ByVal hWnd As Long, ByVal fEnable As Long) As Long
Private Declare Function GetFocus Lib "user32" () As Long
Private Declare Function SetBkMode Lib "GDI32" (ByVal hdc As Long, ByVal nBkMode As Long) As Long

'constantes para inicialização da commoncontrol
Private Const ICC_LISTVIEW_CLASSES = &H1                   ' listview, header

' constantes para DrawState
Private Const DSS_DISABLED As Long = &H20&
Private Const DST_ICON As Long = &H3&

'constantes para auxílio de apis
Private Const SM_CXVSCROLL = 2
Private Const SM_CYHSCROLL = 3
Private Const SM_CXBORDER = 5

Private Const SWP_NOACTIVATE = &H10
Private Const SWP_NOMOVE = &H2
Private Const SWP_NOOWNERZORDER = &H200                         '  Don't do owner Z ordering
Private Const SWP_NOZORDER = &H4

'estilo da window
Private Const GWL_STYLE = (-16)                              'pega estilo da janela


Private Const CLIP_DEFAULT_PRECIS = 0
Private Const LOGPIXELSY = 90

Private Const DEFAULT_CHARSET = 1
Private Const OUT_DEFAULT_PRECIS = 0
Private Const PROOF_QUALITY = 2

'alinhamentos para drawtext
Private Const DT_LEFT = &H0
Private Const DT_CENTER = &H1
Private Const DT_RIGHT = &H2
Private Const DT_VCENTER = &H4
Private Const DT_WORDBREAK = &H10
Private Const DT_SINGLELINE = &H20

'estilos para windows
Private Const WS_CHILD = &H40000000
Private Const WS_VISIBLE = &H10000000
Private Const WS_TABSTOP = &H100000

'estilos extendidos para windows
Private Const WS_EX_CLIENTEDGE = &H200&

'valores de teclas
Private Const VK_LSHIFT = &HA0
Private Const VK_RSHIFT = &HA1
Private Const VK_LCONTROL = &HA2
Private Const VK_RCONTROL = &HA3
Private Const VK_LMENU = &HA4
Private Const VK_RMENU = &HA5

'estados owner draw
Private Const ODS_SELECTED = &H1
'formas de redraw
Private Const RDW_ALLCHILDREN = &H80
Private Const RDW_ERASE = &H4
Private Const RDW_INVALIDATE = &H1
Private Const RDW_UPDATENOW = &H100

Private Const H_MAX As Long = &HFFFF + 1

'constantes para controle de cache
Private Const ITEM_CACHE_VALUE = 1
Private Const ITEM_CACHE_TEXT = 2
Private Const ITEM_CACHE_COLOR = 3

'usar como parâmetro da FillScalarValues carregar os valores independentemente da exibição das barras
Private Const SCALAR_SUM = 1
Private Const SCALAR_MAX = 2
Private Const SCALAR_MIN = 4
Private Const SCALAR_AVG = 8
Private Const SCALAR_ALL = SCALAR_SUM Or SCALAR_MAX Or SCALAR_MIN Or SCALAR_AVG

Private Const ITEM_CACHE_MAX = 3                    'deve ser o último (igual ao último item) sempre

Private Type WINDOWPOS
   hWnd As Long
   hWndInsertAfter As Long
   x As Long
   y As Long
   cx As Long
   cy As Long
   Flags As Long
End Type

'enumerações para o colunas visíveis
Public Enum gVisibleCols
   COL_FIRST
   COL_PREVIOUS
   COL_NEXT
   COL_LAST
End Enum

'enumerações para o listview
Public Enum gBorderStyle
   GBorder_None
   GBorder_Flat
   GBorder_3D
End Enum

'controle interno para propriedades
Private vgFilterApplied As Boolean
Private vgGridLines As Boolean
Private vgEnabled As Boolean
Private vgFlatHeader As Boolean
Private vgHideHeader As Boolean
Private vgHideStatus As Boolean
Private vgHideCaption As Boolean
Private vgHideLeftBar As Boolean
Private vgHideHScroll As Boolean
Private vgFullRowSelect As Boolean
Private vgTrackSelect As Boolean
Private vgHideSelect As Boolean
Private vgHideFocus As Boolean
Private vgStripes As Boolean
Private vgUboundMode As Boolean
Private vgBorderStyle As gBorderStyle
Private vgHeaderHeight As Single
Private vgCaptionHeight As Single
Private vgRowHeight As Long
Private vgLeftBarWidth As Single
Private vgAllowEdit As Boolean
Private vgAllowInsert As Boolean
Private vgAllowDelete As Boolean
Private vgManualUpdate As Boolean
Private vgManualDelete As Boolean
Private vgNavigationAddMode As GRID_NAVIGATION
Private vgNavigationEditNavigation As GRID_NAVIGATION
Private vgShowFilterBar As Boolean
Private vgShowTopField As Boolean
Private vgRemoveInitialTop As Boolean
Private vgShowSumBar As Boolean
Private vgShowMaxBar As Boolean
Private vgShowMinBar As Boolean
Private vgShowAvgBar As Boolean
Private vgShowGridCaption As Boolean
Private vgShowCloseButton As Boolean
Private vgShowGridControl As Boolean
Private vgSaveGridBars As Boolean
Private vgSaveGridCols As Boolean
Private vgSaveGridStripes As Boolean
Private vgCaption As String
Private vgLocked As Boolean
Private vgAutoApplyFilter As Boolean
Private vgAutoRebind As Boolean

'propriedades da categoria "Aparência (cores)"
Private vgFilterBackColor As Long                 'fundo barra filtro
Private vgLeftBackColor As Long                   'fundo barra lateral
Private vgMaxBackColor As Long                    'fundo barra máximo
Private vgAvgBackColor As Long                    'fundo barra média
Private vgMinBackColor As Long                    'fundo barra mínimo
Private vgSumBackColor As Long                    'fundo barra somatório
Private vgStatusBackColor As Long                 'fundo barra status
                                                                                                                        'fundo coluna
Private vgColSelectBackColor As Long              'fundo coluna ativa
Private vgCellBackColor As Long                   'fundo célula
Private vgEditBackColor As Long                   'fundo célula edição
Private vgSelectBackColor As Long                 'fundo célula selec.
Private vgStripesBackColor As Long                'fundo célula zebra
Private vgBackColor As Long                       'fundo grid
                                                                                                                        'fundo linha
Private vgCaptionBackColor As Long                'fundo título coluna
                                                                                                                        'fundo título grid
Private vgColHeaderBackColor As Long              'fundo título colunas
Private vgGridLinesColor As Long                  'linha de grid
Private vgFilterTextColor As Long                 'texto barra filtro
Private vgAvgTextColor As Long                    'texto barra média
Private vgMinTextColor As Long                    'texto barra mínimo
Private vgMaxTextColor As Long                    'texto barra máximo
Private vgStatusTextColor As Long                 'texto barra status
Private vgSumTextColor As Long                    'texto barra somatório
                                                                                                                        'texto coluna
Private vgColSelectTextColor As Long              'texto coluna ativa
Private vgCellTextColor As Long                   'texto célula
Private vgSelectTextColor As Long                 'texto célula selec.
Private vgEditTextColor As Long                   'texto célula edição
Private vgStripesTextColor As Long                'texto célula zebra
                                                                                                                        'texto linha
Private vgCaptionTextColor As Long                'texto título coluna
                                                                                                                        'texto título grid
Private vgColHeaderTextColor As Long              'texto título colunas

'flags de permissões
Private vgAllowEditDatabase As Boolean
Private vgAllowInsertDatabase As Boolean
Private vgAllowDeleteDatabase As Boolean

'controles para listview
Private hWndLst As Long
Private hWndImgLst As Long
Private vgHwndHeader As Long

Private txtCampo As FormataCampos
Private txtCampoFilter() As FormataCampos
Private vgColumns As GColumns                                   'coleção das colunas da lista
Private WithEvents vgTabela As GRecordSet                       'recordset relacionado à lista
Attribute vgTabela.VB_VarHelpID = -1
Private vgItens() As String
Private vgNumItems As Long                                       'número de itens na lista
Private vgNumItemsTot As Long                                    'número de itens na lista (incluindo linha em branco quando existente)
Private vgInternalLst As Boolean
Private vgComFoco As Integer
Private vgUltFocusRect As RECT
Private vgColAtual As Integer
Private vgNavigation As GRID_NAVIGATION
Private vgFont As Long
Private vgUltRcResize As RECT
Private vgColDefinitions() As GRD_ColumnDefinition               'guarda definições para cada coluna
Private vgRowsSelected As String
Private vgColsSelected As String
Private vgIgnoredFocusControls() As Long
Private vgLastRow As Long
Private vgCacheSize As Long

Private vgTimerLastClick As Single
Private vgIgnoreMouseUp As Boolean

Private vgSubClass As GSubClass

Private vgOrigHeight As Long, vgOrigFont As Long, vgFormParent As Form, vgImgFundo As IPictureDisp, vgTpX As Long, vgTpY As Long, vgFieldsSelect As String, vgBkVirtual As Variant
Private vgUltColProcura As String, vgUltProcura As String, vgEProcura As Boolean, vgFilterBarHeight As Long, vgStatusBarHeight As Long, vgSumaryBarHeight As Long, vgInFilter As Boolean, vgBkSelect As Variant, vgUltBkSelect As Long, vgRecPosAtual As Long, vgTopOrig As Long, vgLastSkipRec As Long, vgForcePicSel As Boolean, vgForcePosSel As Boolean
Private vgPriVez As Long, vgHasChanged As Boolean, vgColEditing As Long, vgRowEditing As Long, vgIsPreEditing As Boolean, vgColResizing As Integer, vgLinResizing As Long, vgMovingColumn As Integer, vgColX As Long, vgColY As Long, vgColMoving As Integer, vgTargetCol As Integer, vgSQLOrig As String, vgWhOrig As String, vgOrdOrig As String, vgAutoColumnOrig As Boolean
Private vgIcoSum As Long, vgIcoMax As Long, vgIcoMin As Long, vgIcoAvg As Long, vgIcoSel As Long, vgIcoSelect As Long, vgIcoEdit As Long, vgIcoGReady As Long, vgIcoGBusy1 As Long, vgIcoGBusy2 As Long, vgIcoGEdit As Long, vgIcoNew As Long, vgIcoFilter As Long, vgIcoCmd As Long, vgIcoSeta As Long, vgIcoOrdC As Long, vgIcoOrdD As Long, vgCurSizeV As IPictureDisp, vgCurSizeH As IPictureDisp, vgCurSizeHPart As IPictureDisp, vgCurSelR As IPictureDisp, vgCurSelC As IPictureDisp, vgCurMove As IPictureDisp, vgCurMove2 As IPictureDisp, vgCurOrdC As IPictureDisp, vgCurOrdD As IPictureDisp, vgCurOrdR As IPictureDisp
Private vgCacheTable() As Variant, vgCacheFirst As Long, vgSQLEscalar As String, vgFreezeCount As Integer, vgReadingProps As Boolean, vgHasFocus As Boolean
Private vgIgnoreKey As Long, vgLastKey As Long

'eventos do listview
Event GetColumnValue(ByVal Row As Long, ByVal Column As Integer, Columns() As Variant, ByRef NewText As Variant)
Event GetColumnDefaultValue(ByVal Column As Integer, Columns() As Variant, ByRef DefaultValue As Variant)
Event GetColumnFilter(ByVal Column As Integer, Columns() As Variant, ByRef Filter As String)
Event GetColumnSQLSearch(ByVal Column As Integer, Columns() As Variant, ByRef SQLSearch As String)
Event GetColor(ByVal Row As Long, ByVal Column As Long, ByRef TextColor As Long, ByRef BackColor As Long, ByRef SelectTextColor As Long, ByRef SelectBackColor As Long, ByRef ColumnTextColor As Long, ByRef ColumnBackColor As Long)
Event KeyDown(ByVal KeyCode As Integer, ByVal Shift As Integer, Columns() As Variant)
Event KeyUp(ByVal KeyCode As Integer, ByVal Shift As Integer, Columns() As Variant)
Event KeyPress(ByVal KeyAscii As Integer, ByVal Shift As Integer, Columns() As Variant)
Event ItemClick(ByVal Row As Long, Columns() As Variant)
Event ItemSelect(ByVal Row As Long, Columns() As Variant)
Event ColumnActionButtonClick(ByRef ColumnValue() As Variant, ByVal Row As Long, ByVal Column As Integer, ByRef Cancel As Boolean)
Event InitEdit(ByRef CancelEdit As Boolean)
Event GetTextEnable(ByVal Row As Long, ByVal Column As Long, ByRef Enabled As Boolean)
Event GetColumnLocked(ByVal Row As Long, ByVal Column As Long, ByRef Columns() As Variant, ByRef FormField As FormataCampos, ByRef vgLocked As Boolean)
Event ValidateData(ByVal Row As Long, ByRef Columns() As Variant, ByRef IsValid As Boolean, ByRef Column As Integer, ByRef ErrorMessage As String)
Event CancelEdit(ByVal Row As Long)
Event BeforeEditRecord(ByVal Row As Long, ByRef Columns() As Variant, ByRef IsValid As Boolean, ByRef Column As Integer, ByRef ErrorMessage As String)
Event BeforeUpdateRecord(ByVal Row As Long, ByRef Columns() As Variant, ByRef IsValid As Boolean, ByRef Column As Integer, ByRef ErrorMessage As String)
Event AfterUpdateRecord(ByVal Row As Long, ByRef Columns() As Variant, ByRef IsValid As Boolean, ByRef Column As Integer, ByRef ErrorMessage As String)
Event BeforeDeleteRecord(ByVal Row As Long, ByRef Columns() As Variant, ByRef IsValid As Boolean, ByRef Column As Integer, ByRef ErrorMessage As String)
Event AfterDeleteRecord(ByVal Row As Long, ByRef Columns() As Variant, ByRef IsValid As Boolean, ByRef Column As Integer, ByRef ErrorMessage As String)
Event SaveData(ByVal Row As Long, ByRef Columns() As Variant, ByRef DataSaved As Boolean, ByRef Column As Integer, ByRef ErrorMessage As String)
Event DeleteData(ByVal Row As Long, ByRef Columns() As Variant, ByRef DataDeleted As Boolean, ByRef ErrorMessage As String)
Event SkipRecord(ByRef Columns() As Variant, ByVal BookMark As Variant)
Event StatusChanged(ByVal NewStatus As Integer)
Event RecordSetChanged(ByVal NewRecordSet As GRecordSet)
Event MenuButtonClick(ByRef Cancel As Boolean)
Event CloseButtonClick()
Event MouseMove()
Event ActionButtonClick(ByRef ColumnValue() As Variant, ByVal Column As Integer, Cancel As Boolean)
Event ActionDoubleClick(ByRef ColumnValue() As Variant, ByVal Column As Integer, ByRef Cancel As Boolean)

'=================================================
'Propriedades somente leitura do listview
'=================================================

Public Property Get hWndHeader() As Long
   hWndHeader = vgHwndHeader
End Property

Public Property Get Status(Optional ByVal vgRow As Long = -1) As Integer
   If vgRow = -1 Then vgRow = SelectedItem
   If vgAllowInsert And (Not vgInternalLst Or vgAllowInsertDatabase) And vgRow = vgNumItemsTot - 1 And SelectedItem = vgNumItemsTot - 1 And vgHasChanged Then
      Status = ACAO_INCLUINDO
   ElseIf vgHasChanged And vgRow = SelectedItem Then
      Status = ACAO_EDITANDO
   Else
      Status = ACAO_NAVEGANDO
   End If
End Property

Public Property Get PreEditing() As Boolean
   PreEditing = vgIsPreEditing
End Property

Public Property Let PreEditing(NewIsPreEditing As Boolean)
   vgIsPreEditing = NewIsPreEditing
   vgForcePosSel = True
   PosicionaSelect
   UserControl.SetFocus
End Property

Public Property Get Source() As String
   On Error Resume Next
   Source = vgTabela.Source
End Property

Public Property Get SQLSource() As String
   SQLSource = vgSQLOrig
End Property

Public Property Get ColumnOrdered() As GColumns
   Dim vgCols As New GColumns, vgCol As GColumn, i As Integer
   For i = 1 To vgColumns.Count
      Set vgCol = vgColumns(GetColumnByPosition(i))
      vgCols.Add vgCol.Name, vgCol.Title, vgCol.ColumnType, vgCol.Mask, vgCol.Size, vgCol.QDecimal, vgCol.Hidden, vgCol.Nullable, vgCol.System, vgCol.SeqInterno, vgCol.SeqInterno, vgCol.Descending, vgCol.Default, vgCol.UpdatableColumn, vgCol.NameFilter
   Next
   Set ColumnOrdered = vgCols
   Set vgCol = Nothing
End Property

Public Property Get Columns() As GColumns
   Set Columns = vgColumns
End Property

Public Property Get RecordSet() As GRecordSet
   
   On Error GoTo DeuErro
   
   'vamos reposicionar recordset no registro selecionado
   If Val(vgUltBkSelect) <> -1 And Val(vgUltBkSelect) <> -2 And Val(vgUltBkSelect) <> -3 And Len(vgUltBkSelect) > 0 And vgTabela.Status = ACAO_NAVEGANDO Then
      vgTabela.BookMark = vgBkSelect
   End If
   
DeuErro:
   Err.Clear
   
   'vamos zerar controle de bookmark
   Call ResetBookMark
   
   Set RecordSet = vgTabela
End Property

Public Property Set RecordSet(NewRecordSet As GRecordSet)
   Dim x As String
   
   Set vgTabela = NewRecordSet
   
   RaiseEvent RecordSetChanged(vgTabela)

   vgTopOrig = -1

   'vamos pegar TOP original da select e sugerir no campo para TOP
   x$ = ExtraiSQL(vgTabela.Source, EXP_SELECT)
      'Atenção!!!
      'Ao executar o aplicativo pelo VB e ocorrer erro nesta linha, verifique se a forma de debug está corretamente definida.
      'Verifique no menu:
      'Tools->Options, na aba General, no frame "Error trapping",
      'Selecione a opção: "Break on Unhanheld Errors"

   If Len(x$) > 0 Then
      x$ = Substitui$(x$, vbCrLf, "", UM_A_UM)
      If UCase$(Left$(x$, 4)) = "TOP " Then
         x$ = Mid$(x$, 4)
         vgTopOrig = Val(x$)
         txtTop.Text = CStr(vgTopOrig)
      End If
   End If

   vgInternalLst = False
   vgSQLOrig = vgTabela.Source
   vgAllowEditDatabase = vgTabela.Editable
   vgAllowInsertDatabase = vgTabela.Insertable
   vgAllowDeleteDatabase = vgTabela.Deletable
   
   SetItemCount vgTabela.RecordCount

   'caso esteja em grid filho e está navegando no pai, sempre que reabrir o rs precisamos retirar a seleção para que
   'quando o primeiro item for selecionado o evento LVN_ITEMCHANGED seja disparado...
   SelecionaItem -1

   'vamos zerar controle de bookmark
   Call ResetBookMark
   
   vgColEditing = -1
   vgRowEditing = -1

   If vgTabela.RecordCount > 0 Then
      vgTabela.MoveFirst
   Else
      If vgIsPreEditing Then EndEditGrid False, True
   End If
   vgColAtual = GetVisibleCol(COL_FIRST)
   ItemSelect 0, False

   FillScalarValues
   
   Refresh

End Property

Public Property Get SelectedRowsCount() As Long
   SelectedRowsCount = IIf(Tally(vgRowsSelected, "|") - 1 > 0, Tally(vgRowsSelected, "|") - 1, 0)
End Property

'Retorna o numero da linha selecionada de acordo com NewRow
Public Property Get GetSelectedRowNumber(ByVal NewRow As Long) As Long
   Dim vgRows As Variant
   If Len(vgRowsSelected) > 0 Then
      vgRows = Split(vgRowsSelected, "|")
      OrdenaVetor vgRows, 1, UBound(vgRows) - 1
      GetSelectedRowNumber = vgRows(NewRow) + 1
   Else
      GetSelectedRowNumber = 0
   End If
End Property

'Retorna as colunas selecionadas no Grid
Public Property Get ColumnSelected() As GColumns
   Dim vgCols As New GColumns, vgColSel As Variant, vgCol As GColumn, vgInd As Integer, vgT As String, i As Integer
   vgColSel = Split(vgColsSelected, "|")
   vgT = "|"
   For i = 1 To UBound(vgColSel) - 1
      vgT = vgT + CStr(vgColDefinitions(vgColSel(i)).Position) + "|"
   Next
   vgColSel = Split(vgT, "|")
   OrdenaVetor vgColSel, 1, UBound(vgColSel) - 1
   For i = 1 To UBound(vgColSel) - 1
      vgInd = vgColSel(i)
      Set vgCol = vgColumns(vgInd)
      vgCols.Add vgCol.Name, vgCol.Title, vgCol.ColumnType, vgCol.Mask, vgCol.Size, vgCol.QDecimal, vgCol.Hidden, vgCol.Nullable, vgCol.System, vgCol.SeqInterno, vgCol.SeqInterno, vgCol.Descending, vgCol.Default, vgCol.UpdatableColumn, vgCol.NameFilter
   Next
   Set vgCol = Nothing
   Set ColumnSelected = vgCols
End Property

'Retorna o numero da coluna selecionada de acordo com NewCol
Public Property Get GetColNumber(ByVal NewCol As Long) As Long
   Dim vgCols As Variant
   If Len(vgColsSelected) > 0 Then
      vgCols = Split(vgColsSelected, "|")
      OrdenaVetor vgCols, 1, UBound(vgCols) - 1
      GetColNumber = vgCols(NewCol)
   Else
      GetColNumber = 1
   End If
End Property

Public Property Get ColumnValue(ByVal vgRow As Long, ByVal vgColumn As Variant) As Variant
   If vgRow = -1 Then vgRow = SelectedItem + 1
   If Len(vgColumns(vgColumn).NameFilter) > 0 Then
      ColumnValue = GetColumnRs(vgRow - 1, vgColumn)
   Else
      ColumnValue = GetColumnText(vgRow - 1, vgColumn)
   End If
End Property

Public Property Let ColumnValue(ByVal vgRow As Long, ByVal vgColumn As Variant, ByVal vgNewValue As Variant)
   Dim vgChanged As Boolean, vgCol As Integer
   If vgRow = -1 Then vgRow = SelectedItem + 1
   vgCol = Val(vgColumns(vgColumn).Index)
   
   If vgColDefinitions(vgCol).NewValue = vgNewValue Then Exit Property
   
   If vgColEditing = vgCol Then
      txtCampo.Value = vgNewValue
   Else
      vgChanged = Not vgHasChanged
      If vgChanged Then
         vgHasChanged = True
         vgIsPreEditing = False
      End If
      vgColDefinitions(vgCol).NewValue = vgNewValue
      vgColDefinitions(vgCol).Changed = True
      If Not vgColDefinitions(vgCol).txtCampo Is Nothing Then
         vgColDefinitions(vgCol).txtCampo.Value = vgColDefinitions(vgCol).NewValue
      End If
      If vgChanged Then
         Call RefreshStatus
      End If
      DrawHeaderBar
      Repaint -1
   End If
End Property

Public Property Get SelectedItem() As Long
   SelectedItem = SendMessageLong(hWndLst, LVM_GETNEXTITEM, -1, LVIS_FOCUSED Or LVIS_SELECTED)
End Property

Public Property Get ColumnWidth(ByVal vgColumn As Variant) As Long
   If Val(vgColumns(vgColumn).Index) > 0 Then
      ColumnWidth = vgColDefinitions(Val(vgColumns(vgColumn).Index)).Width
   End If
End Property

Public Property Let ColumnWidth(ByVal vgColumn As Variant, ByVal NewColumnWidth As Long)
   Dim vgInd As Integer, vgWidth As Single, w As Single, x As String, i As Long
   vgWidth = NewColumnWidth
   vgInd = Val(vgColumns(vgColumn).Index)
   If vgWidth = -1 Then
      If Not vgColumns(vgInd).Hidden Then
         vgWidth = Me.TextWidth(vgColumns(vgInd).Title) + Screen.TwipsPerPixelX * 8
         If Len(vgColumns(vgInd).NameFilter) > 0 Then
            If vgColumns(vgInd).ColumnType = TP_MEMO Then
               w = 200 * vgTpX
            Else
               w = vgTabela.Table.Columns(vgColumns(vgInd).Name).Size * Me.TextWidth("X") + Screen.TwipsPerPixelX * 4
            End If
            If vgWidth < w Then
               vgWidth = w
            End If
         End If
      End If
   ElseIf vgWidth = -2 Then
      vgWidth = vgColDefinitions(vgInd).OriginalWidth
   End If
   If vgWidth < 0 Then vgWidth = 0
   vgColDefinitions(vgInd).Width = vgWidth
   If vgColDefinitions(vgInd).Width <> vgColDefinitions(vgInd).OriginalWidth Or NewColumnWidth = -2 Then
      For i = vgInd + 1 To vgColumns.Count
         vgColDefinitions(i).Left = vgColDefinitions(i - 1).Left + vgColDefinitions(i - 1).Width
      Next
   End If
   SendMessageLong hWndLst, LVM_SETCOLUMNWIDTH, (vgColDefinitions(vgInd).Position - 1), vgWidth / vgTpX
   AdjustFilterBar
   PosicionaSelect
End Property

'restaura as colunas conforme o grid original
Private Sub RestoreOriginalGrid()
   Dim i As Integer
   For i = 1 To vgColumns.Count                                            'corre todas as colunas
      ColumnWidth(i) = vgColDefinitions(i).OriginalWidth                   'restaura a largura original
      vgColDefinitions(i).Position = vgColDefinitions(i).OriginalPosition  'restaura a posição original
   Next
   UpdateColumnsLeft                              'ajusta o posicionamento do lado esquerdo das colunas
   Refresh                                        'atualiza exibição
End Sub

Private Sub UpdateColumnsWidth()
   Dim i As Integer
   For i = 1 To vgColumns.Count
      ColumnWidth(i) = ColumnWidth(i)
   Next
End Sub

Private Sub UpdateColumnsLeft()
   Dim i As Integer
   vgColDefinitions(GetColumnByPosition(1)).Left = 0
   For i = 1 To vgColumns.Count
      vgColDefinitions(GetColumnByPosition(i)).Left = vgColDefinitions(GetColumnByPosition(i - 1)).Left + vgColDefinitions(GetColumnByPosition(i - 1)).Width
   If Not vgHideLeftBar And i = 1 Then
      vgColDefinitions(GetColumnByPosition(i)).Left = vgColDefinitions(GetColumnByPosition(i)).Left + vgLeftBarWidth
   End If
   Next
End Sub

Public Property Get ColumnComboDataBase(ByVal vgColumn As Variant) As String
   ColumnComboDataBase = vgColDefinitions(vgColumn).ComboDataBase
End Property

Public Property Let ColumnComboDataBase(ByVal vgColumn As Variant, ByVal NewColumnComboDataBase As String)
   vgColDefinitions(vgColumn).ComboDataBase = NewColumnComboDataBase
   DefineMask vgColumn                                'definições do mask para combo-box
   vgColDefinitions(vgColumn).txtCampoGrd.DataBase = vgDb(NewColumnComboDataBase)
End Property

Public Property Get ColumnComboTable(ByVal vgColumn As Variant) As String
   ColumnComboTable = vgColDefinitions(vgColumn).ComboTable
End Property

Public Property Let ColumnComboTable(ByVal vgColumn As Variant, ByVal NewColumnComboTable As String)
   vgColDefinitions(vgColumn).ComboTable = NewColumnComboTable
   DefineMask vgColumn                                'definições do mask para combo-box
   vgColDefinitions(vgColumn).txtCampoGrd.Source = NewColumnComboTable
End Property

Public Property Get ColumnComboFieldCapture(ByVal vgColumn As Variant) As String
   ColumnComboFieldCapture = vgColDefinitions(vgColumn).ComboFieldCapture
End Property

Public Property Let ColumnComboFieldCapture(ByVal vgColumn As Variant, ByVal NewColumnComboFieldCapture As String)
   vgColDefinitions(vgColumn).ComboFieldCapture = NewColumnComboFieldCapture
   DefineMask vgColumn                                'definições do mask para combo-box
   vgColDefinitions(vgColumn).txtCampoGrd.BoundColumn = NewColumnComboFieldCapture
End Property

Public Property Get ColumnComboFieldsShow(ByVal vgColumn As Variant) As String
   ColumnComboFieldsShow = vgColDefinitions(vgColumn).ComboFieldsShow
End Property

Public Property Let ColumnComboFieldsShow(ByVal vgColumn As Variant, ByVal NewColumnComboFieldsShow As String)
   vgColDefinitions(vgColumn).ComboFieldsShow = NewColumnComboFieldsShow
   DefineMask vgColumn                                'definições do mask para combo-box
   vgColDefinitions(vgColumn).txtCampoGrd.ShowFields = NewColumnComboFieldsShow
End Property

Public Property Get ColumnComboFieldsList(ByVal vgColumn As Variant) As String
   ColumnComboFieldsList = vgColDefinitions(vgColumn).ComboFieldsList
End Property

Public Property Let ColumnComboFieldsList(ByVal vgColumn As Variant, ByVal NewColumnComboFieldsList As String)
   vgColDefinitions(vgColumn).ComboFieldsList = NewColumnComboFieldsList
   DefineMask vgColumn                                'definições do mask para combo-box
   vgColDefinitions(vgColumn).txtCampoGrd.ListFields = NewColumnComboFieldsList
End Property

Public Property Get ColumnComboFieldsOrder(ByVal vgColumn As Variant) As String
   ColumnComboFieldsOrder = vgColDefinitions(vgColumn).ComboFieldsOrder
End Property

Public Property Let ColumnComboFieldsOrder(ByVal vgColumn As Variant, ByVal NewColumnComboFieldsOrder As String)
   vgColDefinitions(vgColumn).ComboFieldsOrder = NewColumnComboFieldsOrder
   DefineMask vgColumn                                'definições do mask para combo-box
   vgColDefinitions(vgColumn).txtCampoGrd.OrderFields = NewColumnComboFieldsOrder
End Property

Public Property Get ColumnComboFieldsFilter(ByVal vgColumn As Variant) As String
   ColumnComboFieldsFilter = vgColDefinitions(vgColumn).ComboFieldsFilter
End Property

Public Property Let ColumnComboFieldsFilter(ByVal vgColumn As Variant, ByVal NewColumnComboFieldsFilter As String)
   vgColDefinitions(vgColumn).ComboFieldsFilter = NewColumnComboFieldsFilter
   DefineMask vgColumn                                'definições do mask para combo-box
   vgColDefinitions(vgColumn).txtCampoGrd.Filter = NewColumnComboFieldsFilter
End Property

Public Property Get ColumnComboFieldsRelation(ByVal vgColumn As Variant) As String
   ColumnComboFieldsRelation = vgColDefinitions(vgColumn).ComboFieldsRelation
End Property

Public Property Let ColumnComboFieldsRelation(ByVal vgColumn As Variant, ByVal NewColumnComboFieldsRelation As String)
   vgColDefinitions(vgColumn).ComboFieldsRelation = NewColumnComboFieldsRelation
   DefineMask vgColumn                                'definições do mask para combo-box
   vgColDefinitions(vgColumn).txtCampoGrd.Relation = NewColumnComboFieldsRelation
End Property

Public Property Get ColumnComboExtensor(ByVal vgColumn As Variant) As String
   ColumnComboExtensor = vgColDefinitions(vgColumn).ComboExtensor
End Property

Public Property Let ColumnComboExtensor(ByVal vgColumn As Variant, ByVal NewColumnComboExtensor As String)
   vgColDefinitions(vgColumn).ComboExtensor = NewColumnComboExtensor
   DefineMask vgColumn                                'definições do mask para combo-box
End Property

Public Property Get ColumnPesqFieldCapture(ByVal vgColumn As Variant) As String
   ColumnPesqFieldCapture = vgColDefinitions(vgColumn).PesqFieldCapture
End Property

Public Property Let ColumnPesqFieldCapture(ByVal vgColumn As Variant, ByVal NewColumnPesqFieldCapture As String)
   vgColDefinitions(vgColumn).PesqFieldCapture = NewColumnPesqFieldCapture
   DefineMask vgColumn                                'definições do mask para lista
End Property

Public Property Get ColumnPesqSQLExpression(ByVal vgColumn As Variant) As String
   ColumnPesqSQLExpression = vgColDefinitions(vgColumn).PesqSQLExpression
End Property

Public Property Let ColumnPesqSQLExpression(ByVal vgColumn As Variant, ByVal NewColumnPesqSQLExpression As String)
   vgColDefinitions(vgColumn).PesqSQLExpression = NewColumnPesqSQLExpression
   DefineMask vgColumn                                'definições do mask para lista
End Property

Public Property Get ColumnPesqBD(ByVal vgColumn As Variant) As String
   ColumnPesqBD = vgColDefinitions(vgColumn).PesqBD
End Property

Public Property Let ColumnPesqBD(ByVal vgColumn As Variant, ByVal NewColumnPesqBD As String)
   vgColDefinitions(vgColumn).PesqBD = NewColumnPesqBD
   DefineMask vgColumn                               'definições do mask para lista
End Property

'pega o modo de abertura da pesquisa na coluna
Public Property Get ColumnPesqModoAbertura(ByVal vgColumn As Variant) As Integer
   ColumnPesqModoAbertura = vgColDefinitions(vgColumn).PesqModoAbertura
End Property

'define o modo de abertura da pesquisa na coluna
Public Property Let ColumnPesqModoAbertura(ByVal vgColumn As Variant, ByVal NewColumnPesqModoAbertura As Integer)
   vgColDefinitions(vgColumn).PesqModoAbertura = NewColumnPesqModoAbertura
End Property

Public Property Get ColumnPesqExtensor(ByVal vgColumn As Variant) As String
   ColumnPesqExtensor = vgColDefinitions(vgColumn).PesqExtensor
End Property

Public Property Let ColumnPesqExtensor(ByVal vgColumn As Variant, ByVal NewColumnPesqExtensor As String)
   vgColDefinitions(vgColumn).PesqExtensor = NewColumnPesqExtensor
   DefineMask vgColumn                                'definições do mask para lista
End Property

Public Property Get ColumnActionButtonExtensor(ByVal vgColumn As Variant) As String
   ColumnActionButtonExtensor = vgColDefinitions(vgColumn).ActionButtonExtensor
End Property

Public Property Let ColumnActionButtonExtensor(ByVal vgColumn As Variant, ByVal NewColumnActionButtonExtensor As String)
   vgColDefinitions(vgColumn).ActionButtonExtensor = NewColumnActionButtonExtensor
End Property

Public Property Get ColumnCaption(ByVal vgColumn As Variant) As String
   ColumnCaption = vgColumns(vgColumn).Title
End Property

Public Property Let ColumnCaption(ByVal vgColumn As Variant, ByVal NewColumnCaption As String)
   vgColumns(vgColumn).Title = NewColumnCaption
   Refresh
End Property

Public Property Get ColumnField(ByVal vgColumn As Variant) As String
   ColumnField = vgColumns(vgColumn).Name
End Property

Public Property Let ColumnField(ByVal vgColumn As Variant, ByVal NewColumnField As String)
   vgColumns.ChangeItemName vgColumn, NewColumnField
   vgColumns(vgColumn).NameFilter = NewColumnField
   Refresh
End Property

Public Property Get ColumnLocked(ByVal vgColumn As Variant) As Boolean
   ColumnLocked = vgColDefinitions(vgColumn).Locked
End Property

Public Property Let ColumnLocked(ByVal vgColumn As Variant, ByVal NewColumnLocked As Boolean)
   vgColDefinitions(vgColumn).Locked = NewColumnLocked
End Property

Public Property Get ColumnMask(ByVal vgColumn As Variant) As String
   ColumnMask = vgColumns(vgColumn).Mask
End Property

Public Property Let ColumnMask(ByVal vgColumn As Variant, ByVal NewColumnMask As String)
   vgColumns(vgColumn).Mask = NewColumnMask
   Refresh
End Property

Public Property Get ColumnSize(ByVal vgColumn As Variant) As Integer
   ColumnSize = vgColumns(vgColumn).Size
End Property

Public Property Let ColumnSize(ByVal vgColumn As Variant, ByVal NewColumnSize As Integer)
   vgColumns(vgColumn).Size = NewColumnSize
   Refresh
End Property

Public Property Get ColumnType(ByVal vgColumn As Variant) As GCOLUMN_TYPE
   ColumnType = vgColumns(vgColumn).ColumnType
End Property

Public Property Let ColumnType(ByVal vgColumn As Variant, ByVal NewColumnType As GCOLUMN_TYPE)
   Dim ulvc As LVCOLUMN
   vgColumns(vgColumn).ColumnType = NewColumnType
   With ulvc
      .Mask = LVCF_FMT
      If NewColumnType = TP_NUMERICO Then
         .fmt = LVCFMT_RIGHT
      Else
         .fmt = LVCFMT_LEFT
      End If
   End With
   SendMessageAPI hWndLst, LVM_SETCOLUMN, vgColumns(vgColumn).Index - 1, ulvc
   Refresh
End Property

'retorna o alinhamento da coluna do grid
Public Property Get ColumnAlignment(ByVal vgColumn As Variant) As AlignmentConstants
   ColumnAlignment = vgColDefinitions(vgColumn).Alignment
End Property

'define o alinhamento da coluna do grid
Public Property Let ColumnAlignment(ByVal vgColumn As Variant, ByVal NewAlignment As AlignmentConstants)
   vgColDefinitions(vgColumn).Alignment = NewAlignment
End Property

Public Property Get ColumnLeft(ByVal vgColumn As Variant) As Long
   Dim vgLeft As Single, i As Integer, Rc As RECT
   If vgColumn < 0 Then Exit Property
   SendMessage hWndLst, LVM_GETITEMRECT, 0, Rc                      'pega posicionamento do 1º item
   vgLeft = Rc.Left * vgTpX
   If Not vgHideLeftBar Then
      vgLeft = vgLeft + vgLeftBarWidth
   End If
   If CStr(vgColumn) <> "0" Then
      vgLeft = Rc.Left * vgTpX + vgColDefinitions(vgColumn).Left
   End If
   ColumnLeft = vgLeft
End Property

Public Property Get ColumnRight(ByVal vgColumn As Variant) As Long
   Dim vgRight As Single, i As Integer, Rc As RECT
   If vgColumn < 0 Then Exit Property
   SendMessage hWndLst, LVM_GETITEMRECT, 0, Rc                      'pega posicionamento do 1º item
   vgRight = Rc.Left * vgTpX + vgColDefinitions(vgColumn).Left + vgColDefinitions(vgColumn).Width
   ColumnRight = vgRight
End Property

Public Property Get ColumnTextColor(ByVal vgColumn As Variant) As Long
   ColumnTextColor = vgColDefinitions(vgColumn).TextColor
End Property

Public Property Let ColumnTextColor(ByVal vgColumn As Variant, ByVal NewColumnTextColor As Long)
   vgColDefinitions(vgColumn).TextColor = NewColumnTextColor
End Property

Public Property Get ColumnBackColor(ByVal vgColumn As Variant) As Long
   ColumnBackColor = vgColDefinitions(vgColumn).BackColor
End Property

Public Property Let ColumnBackColor(ByVal vgColumn As Variant, ByVal NewColumnBackColor As Long)
   vgColDefinitions(vgColumn).BackColor = NewColumnBackColor
End Property

Public Property Get ColumnHeaderTextColor(ByVal vgColumn As Variant) As Long
   ColumnHeaderTextColor = vgColDefinitions(vgColumn).HeaderTextColor
End Property

Public Property Let ColumnHeaderTextColor(ByVal vgColumn As Variant, ByVal NewColumnHeaderTextColor As Long)
   vgColDefinitions(vgColumn).HeaderTextColor = NewColumnHeaderTextColor
End Property

Public Property Get ColumnHeaderBackColor(ByVal vgColumn As Variant) As Long
   ColumnHeaderBackColor = vgColDefinitions(vgColumn).HeaderBackColor
End Property

Public Property Let ColumnHeaderBackColor(ByVal vgColumn As Variant, ByVal NewColumnHeaderBackColor As Long)
   vgColDefinitions(vgColumn).HeaderBackColor = NewColumnHeaderBackColor
End Property

Public Property Get List(ByVal Index As Long) As String
   List = vgItens(Index + 1)
End Property

Public Property Let List(ByVal Index As Long, ByVal vgNewList As String)
   vgItens(Index + 1) = vgNewList
End Property

Public Property Get ListCount() As Long
   ListCount = vgNumItems
End Property

Public Property Get Col() As Long
   Col = vgColAtual
End Property

Public Property Let Col(ByVal NewCol As Long)
   On Error GoTo DeuErro
   If Not vgColumns(NewCol).Hidden And ColumnWidth(NewCol) > 0 Then
      vgColAtual = NewCol
      Refresh
      PosicionaSelect
   End If
DeuErro:
End Property

Public Property Get Row() As Long
   Row = SelectedItem
End Property

'=================================================
'Propriedades leitura/escrita do listview
'=================================================

Public Property Let BorderStyle(NewBorderStyle As gBorderStyle)
   vgBorderStyle = NewBorderStyle
   If vgBorderStyle = GBorder_None Then
      UserControl.BorderStyle = 0                       'None
   ElseIf vgBorderStyle = GBorder_Flat Then
      UserControl.Appearance = 0                        'Flat
      UserControl.BorderStyle = 1                       'Fixed Single
   ElseIf vgBorderStyle = GBorder_3D Then
      UserControl.Appearance = 1                        '3D
      UserControl.BorderStyle = 1                       'Fixed Single
   End If
End Property

Public Property Get BorderStyle() As gBorderStyle
   BorderStyle = vgBorderStyle
End Property

Public Property Let GridLines(ByVal NewGridLines As Boolean)
   If vgGridLines <> NewGridLines Then
      vgGridLines = NewGridLines
      PropertyChanged "GridLines"
      Call SetStyle
   End If
End Property

Public Property Get GridLines() As Boolean
   GridLines = vgGridLines
End Property

Public Property Let Locked(ByVal NewLocked As Boolean)
   If vgLocked <> NewLocked Then
      vgLocked = NewLocked
      PropertyChanged "Locked"
   End If
End Property

Public Property Get Locked() As Boolean
   Locked = vgLocked
End Property

Public Property Let Enabled(ByVal NewEnabled As Boolean)
   vgEnabled = NewEnabled
   SetEnabled
End Property

Public Property Get Enabled() As Boolean
   Enabled = vgEnabled
End Property

Public Property Let FlatHeader(ByVal NewFlatHeader As Boolean)
   If vgFlatHeader <> NewFlatHeader Then
      vgFlatHeader = NewFlatHeader
      PropertyChanged "FlatHeader"
      Call SetStyle
   End If
End Property

Public Property Get FlatHeader() As Boolean
   FlatHeader = vgFlatHeader
End Property

Public Property Let HideHeader(ByVal NewHideHeader As Boolean)
   If vgHideHeader <> NewHideHeader Then
      vgHideHeader = NewHideHeader
      PropertyChanged "HideHeader"
      Call SetStyle
   End If
End Property

Public Property Get HideHeader() As Boolean
   HideHeader = vgHideHeader
End Property

Public Property Let HideStatus(ByVal NewHideStatus As Boolean)
   If vgHideStatus <> NewHideStatus Then
      vgHideStatus = NewHideStatus
      PropertyChanged "HideStatus"
      If vgPriVez = 0 Then Call SetStyle
   End If
   M_Option(3).Checked = Not vgHideStatus
End Property

Public Property Get HideStatus() As Boolean
   HideStatus = vgHideStatus
End Property

Public Property Let HideCaption(ByVal NewHideCaption As Boolean)
   If vgHideCaption <> NewHideCaption Then
      vgHideCaption = NewHideCaption
      PropertyChanged "HideCaption"
      If vgPriVez = 0 Then Call SetStyle
   End If
End Property

Public Property Get HideCaption() As Boolean
   HideCaption = vgHideCaption
End Property

Public Property Let HeaderHeight(ByVal NewHeaderHeight As Single)
   If vgHeaderHeight <> NewHeaderHeight Then
      vgHeaderHeight = NewHeaderHeight
      PropertyChanged "HeaderHeight"
      Call SetStyle
   End If
End Property

Public Property Get HeaderHeight() As Single
   HeaderHeight = vgHeaderHeight
End Property

Public Property Get HeaderHeightFull() As Single
   Dim RetVal As Single
   If Not vgHideHeader Then
      RetVal = vgHeaderHeight
   End If
   If vgShowGridCaption Then
      RetVal = RetVal + vgCaptionHeight + 4 * vgTpY         'picHeader.TextHeight("X") + 4 * vgTpY
   End If
   HeaderHeightFull = RetVal
End Property

Private Property Get StatusBarHeightFull() As Single
   Dim RetVal As Single
   If Not vgHideStatus Then RetVal = vgStatusBarHeight
   If vgShowSumBar Then RetVal = RetVal + vgSumaryBarHeight + vgTpY * 2
   If vgShowMaxBar Then RetVal = RetVal + vgSumaryBarHeight + vgTpY * 2
   If vgShowMinBar Then RetVal = RetVal + vgSumaryBarHeight + vgTpY * 2
   If vgShowAvgBar Then RetVal = RetVal + vgSumaryBarHeight + vgTpY * 2
   StatusBarHeightFull = RetVal
End Property

Private Property Get HeaderTop() As Single
   Dim RetVal As Single
   If vgShowGridCaption Then
      RetVal = vgCaptionHeight + 4 * vgTpY                  ' picHeader.TextHeight("X") + 4 * vgTpY
   Else
      RetVal = 0
   End If
   HeaderTop = RetVal
End Property

Public Property Let RowHeight(ByVal NewRowHeight As Long)
   If vgRowHeight <> NewRowHeight Then
      vgRowHeight = NewRowHeight
      PropertyChanged "RowHeight"
      Call SetStyle
   End If
End Property

Public Property Get RowHeight() As Long
   RowHeight = vgRowHeight
End Property

Private Property Get MinRowHeight() As Long
   MinRowHeight = picEdit.TextHeight("X") + 6 * vgTpY
End Property

Public Property Let HideLeftBar(ByVal NewHideLeftBar As Boolean)
   If vgHideLeftBar <> NewHideLeftBar Then
      vgHideLeftBar = NewHideLeftBar
      PropertyChanged "HideLeftBar"
      Call SetStyle
   End If
End Property

Public Property Get HideLeftBar() As Boolean
   HideLeftBar = vgHideLeftBar
End Property

Public Property Let LeftBarWidth(ByVal NewLeftBarWidth As Single)
   If vgLeftBarWidth <> NewLeftBarWidth Then
      vgLeftBarWidth = NewLeftBarWidth
      PropertyChanged "LeftBarWidth"
      Call SetStyle
   End If
End Property

Public Property Get LeftBarWidth() As Single
   LeftBarWidth = vgLeftBarWidth
End Property

Public Property Let AllowEdit(ByVal NewAllowEdit As Boolean)
   If vgAllowEdit <> NewAllowEdit Then
      vgAllowEdit = NewAllowEdit
      PropertyChanged "AllowEdit"
      Call SetStyle
   End If
End Property

Public Property Get AllowEdit() As Boolean
   AllowEdit = vgAllowEdit
End Property

Public Property Let AllowInsert(ByVal NewAllowInsert As Boolean)
   If vgAllowInsert <> NewAllowInsert Then
      vgAllowInsert = NewAllowInsert
      PropertyChanged "AllowInsert"
      SetItemCount vgNumItems
      Call SetStyle
   End If
End Property

Public Property Get AllowInsert() As Boolean
   AllowInsert = vgAllowInsert
End Property

Public Property Let AllowDelete(ByVal NewAllowDelete As Boolean)
   vgAllowDelete = NewAllowDelete
   PropertyChanged "AllowDelete"
End Property

Public Property Get AllowDelete() As Boolean
   AllowDelete = vgAllowDelete
End Property

Public Property Let ManualUpdate(ByVal NewManualUpdate As Boolean)
   vgManualUpdate = NewManualUpdate
   PropertyChanged "ManualUpdate"
End Property

Public Property Get ManualUpdate() As Boolean
   ManualUpdate = vgManualUpdate
End Property

Public Property Let NavigationAddMode(ByVal NewNavigationAddMode As GRID_NAVIGATION)
   vgNavigationAddMode = NewNavigationAddMode
   PropertyChanged "NavigationAddMode"
End Property

Public Property Get NavigationAddMode() As GRID_NAVIGATION
   NavigationAddMode = vgNavigationAddMode
End Property

Public Property Let NavigationEditNavigation(ByVal NewNavigationEditNavigation As GRID_NAVIGATION)
   vgNavigationEditNavigation = NewNavigationEditNavigation
   PropertyChanged "NavigationEditNavigation"
End Property

Public Property Get NavigationEditNavigation() As GRID_NAVIGATION
   NavigationEditNavigation = vgNavigationEditNavigation
End Property

Public Property Let ShowFilterBar(ByVal NewShowFilterBar As Boolean)
   If vgShowFilterBar <> NewShowFilterBar Then
      vgShowFilterBar = NewShowFilterBar
      PropertyChanged "ShowFilterBar"
      If vgPriVez = 0 Then Call SetStyle
   End If
   M_Option(2).Checked = vgShowFilterBar
End Property

Public Property Get ShowFilterBar() As Boolean
   ShowFilterBar = vgShowFilterBar
End Property

Public Property Let ShowTopField(ByVal NewShowTopField As Boolean)
   If vgShowTopField <> NewShowTopField Then
      vgShowTopField = NewShowTopField
      PropertyChanged "ShowTopField"
      Call SetStyle
   End If
End Property

Public Property Get ShowTopField() As Boolean
   ShowTopField = vgShowTopField
End Property

Public Property Let RemoveInitialTop(ByVal NewRemoveInitialTop As Boolean)
   If vgRemoveInitialTop <> NewRemoveInitialTop Then
      vgRemoveInitialTop = NewRemoveInitialTop
      PropertyChanged "RemoveInitialTop"
      Call SetStyle
      ApplyFilterAndOrder
   End If
   M_Option(0).Checked = vgRemoveInitialTop
End Property

Public Property Get RemoveInitialTop() As Boolean
   RemoveInitialTop = vgRemoveInitialTop
End Property

Public Property Let ShowSumBar(ByVal NewShowSumBar As Boolean)
   If vgShowSumBar <> NewShowSumBar Then
      vgShowSumBar = NewShowSumBar
      SetAllColumnsScalar 0
      PropertyChanged "ShowSumBar"
      If vgPriVez = 0 Then Call SetStyle
   End If
   M_Option(5).Checked = vgShowSumBar
End Property

Public Property Get ShowSumBar() As Boolean
   ShowSumBar = vgShowSumBar
End Property

'retorna se somatório da coluna está exibido ou não na barra de somatórios
Public Property Get ShowSumCol(ByVal vgCol As Integer) As Boolean
   ShowSumCol = vgColDefinitions(vgCol).ShowSum
End Property

'define se somatório da coluna deve ser exibido ou não na barra de somatórios
Public Property Let ShowSumCol(ByVal vgCol As Integer, ByVal NewShowSumCol As Boolean)
   vgColDefinitions(vgCol).ShowSum = NewShowSumCol
End Property

Public Property Let ShowMaxBar(ByVal NewShowMaxBar As Boolean)
   If vgShowMaxBar <> NewShowMaxBar Then
      vgShowMaxBar = NewShowMaxBar
      SetAllColumnsScalar 1
      PropertyChanged "ShowMaxBar"
      If vgPriVez = 0 Then Call SetStyle
   End If
   M_Option(6).Checked = vgShowMaxBar
End Property

Public Property Get ShowMaxBar() As Boolean
   ShowMaxBar = vgShowMaxBar
End Property

'retorna se o valor máximo da coluna está exibido ou não na barra de máximos
Public Property Get ShowMaxCol(ByVal vgCol As Integer) As Boolean
   ShowMaxCol = vgColDefinitions(vgCol).ShowMax
End Property

'define se o valor máximo da coluna deve ser exibido ou não na barra de máximos
Public Property Let ShowMaxCol(ByVal vgCol As Integer, ByVal NewShowMaxCol As Boolean)
   vgColDefinitions(vgCol).ShowMax = NewShowMaxCol
End Property

Public Property Let ShowMinBar(ByVal NewShowMinBar As Boolean)
   If vgShowMinBar <> NewShowMinBar Then
      vgShowMinBar = NewShowMinBar
      SetAllColumnsScalar 2
      PropertyChanged "ShowMinBar"
      If vgPriVez = 0 Then Call SetStyle
   End If
   M_Option(7).Checked = vgShowMinBar
End Property

Public Property Get ShowMinBar() As Boolean
   ShowMinBar = vgShowMinBar
End Property

'retorna se o valor mínimo da coluna está exibido ou não na barra de mínimos
Public Property Get ShowMinCol(ByVal vgCol As Integer) As Boolean
   ShowMinCol = vgColDefinitions(vgCol).ShowMin
End Property

'define se o valor mínimo da coluna deve ser exibido ou não na barra de mínimos
Public Property Let ShowMinCol(ByVal vgCol As Integer, ByVal NewShowMinCol As Boolean)
   vgColDefinitions(vgCol).ShowMin = NewShowMinCol
End Property

Public Property Let ShowAvgBar(ByVal NewShowAvgBar As Boolean)
   If vgShowAvgBar <> NewShowAvgBar Then
      vgShowAvgBar = NewShowAvgBar
      SetAllColumnsScalar 3
      PropertyChanged "ShowAvgBar"
      If vgPriVez = 0 Then Call SetStyle
   End If
   M_Option(8).Checked = vgShowAvgBar
End Property

Public Property Get ShowAvgBar() As Boolean
   ShowAvgBar = vgShowAvgBar
End Property

'retorna se a média da coluna está exibida ou não na barra de médias
Public Property Get ShowAvgCol(ByVal vgCol As Integer) As Boolean
   ShowAvgCol = vgColDefinitions(vgCol).ShowAvg
End Property

'define se a média da coluna deve ser exibido ou não na barra de médias
Public Property Let ShowAvgCol(ByVal vgCol As Integer, ByVal NewShowAvgCol As Boolean)
   vgColDefinitions(vgCol).ShowAvg = NewShowAvgCol
End Property

Public Property Let ShowGridCaption(ByVal NewShowGridCaption As Boolean)
   If vgShowGridCaption <> NewShowGridCaption Then
      vgShowGridCaption = NewShowGridCaption
      PropertyChanged "ShowGridCaption"
      Call SetStyle
   End If
End Property

Public Property Get ShowGridCaption() As Boolean
   ShowGridCaption = vgShowGridCaption
End Property

Public Property Let ShowCloseButton(ByVal NewShowCloseButton As Boolean)
   If vgShowCloseButton <> NewShowCloseButton Then
      vgShowCloseButton = NewShowCloseButton
      PropertyChanged "ShowCloseButton"
      Call SetStyle
   End If
End Property

Public Property Get ShowCloseButton() As Boolean
   ShowCloseButton = vgShowCloseButton
End Property

Public Property Let ShowGridControl(ByVal NewShowGridControl As Boolean)
   If vgShowGridControl <> NewShowGridControl Then
      vgShowGridControl = NewShowGridControl
      PropertyChanged "ShowGridControl"
      Call SetStyle
   End If
End Property

Public Property Get ShowGridControl() As Boolean
   ShowGridControl = vgShowGridControl
End Property

Public Property Let SaveGridBars(ByVal NewSaveGridBars As Boolean)
   If vgSaveGridBars <> NewSaveGridBars Then
      vgSaveGridBars = NewSaveGridBars
      PropertyChanged "SaveGridBars"
   End If
   M_Special(2).Checked = vgSaveGridBars
End Property

Public Property Get SaveGridBars() As Boolean
   SaveGridBars = vgSaveGridBars
End Property

Public Property Let SaveGridCols(ByVal NewSaveGridCols As Boolean)
   If vgSaveGridCols <> NewSaveGridCols Then
      vgSaveGridCols = NewSaveGridCols
      PropertyChanged "SaveGridCols"
   End If
   M_Special(3).Checked = vgSaveGridCols
End Property

Public Property Get SaveGridCols() As Boolean
   SaveGridCols = vgSaveGridCols
End Property

Public Property Get SaveGridStripes() As Boolean
   SaveGridStripes = vgSaveGridStripes
End Property

Public Property Let SaveGridStripes(ByVal NewSaveGridStripes As Boolean)
   If vgSaveGridStripes <> NewSaveGridStripes Then
      vgSaveGridStripes = NewSaveGridStripes
      PropertyChanged "SaveGridStripes"
   End If
   M_Special(4).Checked = vgSaveGridStripes
End Property

Public Property Let Caption(ByVal NewCaption As String)
   If vgCaption <> NewCaption Then
      vgCaption = NewCaption
      PropertyChanged "Caption"
      Call SetStyle
   End If
End Property

Public Property Get Caption() As String
   Caption = vgCaption
End Property

Public Property Let ManualDelete(ByVal NewManualDelete As Boolean)
   vgManualDelete = NewManualDelete
   PropertyChanged "ManualDelete"
End Property

Public Property Get ManualDelete() As Boolean
   ManualDelete = vgManualDelete
End Property

Public Property Let HideHScroll(ByVal NewHideHScroll As Boolean)
   If vgHideHScroll <> NewHideHScroll Then
      vgHideHScroll = NewHideHScroll
      PropertyChanged "HideHScroll"
      Call SetStyle
   End If
End Property

Public Property Get HideHScroll() As Boolean
   HideHScroll = vgHideHScroll
End Property

Public Property Let UboundMode(ByVal NewUboundMode As Boolean)
   vgUboundMode = NewUboundMode
   PropertyChanged "UboundMode"
End Property

Public Property Get UboundMode() As Boolean
   UboundMode = vgUboundMode
End Property

Public Property Let Stripes(ByVal NewStripes As Boolean)
   If vgStripes <> NewStripes Then
      vgStripes = NewStripes
      PropertyChanged "Stripes"
      Call SetStyle
      If vgCacheSize <> 0 Then                    'se o grid tem cache, recarregar informações, pois as cores são armazenadas no cache
         ReBind
      End If
   End If
   M_Special(0).Checked = vgStripes
End Property

Public Property Get Stripes() As Boolean
   Stripes = vgStripes
End Property

Public Property Let FullRowSelect(ByVal NewFullRowSelect As Boolean)
   vgFullRowSelect = NewFullRowSelect
   PropertyChanged "FullRowSelect"
End Property

Public Property Get FullRowSelect() As Boolean
   FullRowSelect = vgFullRowSelect
End Property

Public Property Let TrackSelect(ByVal NewTrackSelect As Boolean)
   vgTrackSelect = NewTrackSelect
   PropertyChanged "TrackSelect"
End Property

Public Property Get TrackSelect() As Boolean
   TrackSelect = vgTrackSelect
End Property

Public Property Let HideSelect(ByVal NewHideSelect As Boolean)
   If vgHideSelect <> NewHideSelect Then
      vgHideSelect = NewHideSelect
      PropertyChanged "HideSelect"
      Call SetStyle
   End If
End Property

Public Property Get HideSelect() As Boolean
   HideSelect = vgHideSelect
End Property

Public Property Let HideFocus(ByVal NewHideFocus As Boolean)
   If vgHideFocus = NewHideFocus Then
      vgHideFocus = NewHideFocus
      PropertyChanged "HideFocus"
      Call SetStyle
   End If
End Property

Public Property Get HideFocus() As Boolean
   HideFocus = vgHideFocus
End Property

Public Property Set Font(ByVal NewFont As Font)
   Set txtEdit.Font = NewFont
   Set txtEditMult.Font = NewFont
   Set picEdit.Font = NewFont
   Set picFilter.Font = NewFont
   Set UserControl.Font = NewFont
   RowHeight = MinRowHeight
   vgFilterBarHeight = vgRowHeight
   If vgFont Then DeleteObject vgFont
   vgFont = MakeFont(txtEdit.Font.Size, txtEdit.Font.Weight, txtEdit.Font.Italic, txtEdit.Font.Underline, txtEdit.Font.Strikethrough, txtEdit.Font.Name)
   PropertyChanged "Font"
   Call Refresh
End Property

Public Property Get Font() As Font
   Set Font = txtEdit.Font
End Property

Public Property Get TextWidth(ByVal Text As String) As Single
      TextWidth = picEdit.TextWidth(Text)
End Property

Public Property Get TextHeight(ByVal Text As String) As Single
   TextHeight = picEdit.TextHeight(Text)
End Property

Public Property Let BackColor(ByVal NewBackColor As OLE_COLOR)
   If vgBackColor <> NewBackColor Then
      vgBackColor = NewBackColor
      PropertyChanged "BackColor"
      Call SetStyle
   End If
End Property

Public Property Get BackColor() As OLE_COLOR
   BackColor = vgBackColor
End Property

Public Property Let EditBackColor(ByVal NewEditBackColor As OLE_COLOR)
   If vgEditBackColor <> NewEditBackColor Then
      vgEditBackColor = NewEditBackColor
      PropertyChanged "EditBackColor"
      Call SetStyle
   End If
End Property

Public Property Get EditBackColor() As OLE_COLOR
   EditBackColor = vgEditBackColor
End Property

Public Property Let EditTextColor(ByVal NewEditTextColor As OLE_COLOR)
   If vgEditTextColor <> NewEditTextColor Then
      vgEditTextColor = NewEditTextColor
      PropertyChanged "EditTextColor"
      Call SetStyle
   End If
End Property

Public Property Get EditTextColor() As OLE_COLOR
   EditTextColor = vgEditTextColor
End Property

Public Property Let CellBackColor(ByVal NewCellBackColor As OLE_COLOR)
   If vgCellBackColor <> NewCellBackColor Then
      vgCellBackColor = NewCellBackColor
      PropertyChanged "CellBackColor"
      Call SetStyle
   End If
End Property

Public Property Get CellBackColor() As OLE_COLOR
   CellBackColor = vgCellBackColor
End Property

Public Property Let CellTextColor(ByVal NewCellTextColor As OLE_COLOR)
   If vgCellTextColor <> NewCellTextColor Then
      vgCellTextColor = NewCellTextColor
      PropertyChanged "CellTextColor"
      Call SetStyle
   End If
End Property

Public Property Get CellTextColor() As OLE_COLOR
   CellTextColor = vgCellTextColor
End Property

Public Property Let StripesBackColor(ByVal NewStripesBackColor As OLE_COLOR)
   If vgStripesBackColor <> NewStripesBackColor Then
      vgStripesBackColor = NewStripesBackColor
      PropertyChanged "StripesBackColor"
      Call SetStyle
   End If
End Property

Public Property Get StripesBackColor() As OLE_COLOR
   StripesBackColor = vgStripesBackColor
End Property

Public Property Let StripesTextColor(ByVal NewStripesTextColor As OLE_COLOR)
   If vgStripesTextColor <> NewStripesTextColor Then
      vgStripesTextColor = NewStripesTextColor
      PropertyChanged "StripesTextColor"
      Call SetStyle
   End If
End Property

Public Property Get StripesTextColor() As OLE_COLOR
   StripesTextColor = vgStripesTextColor
End Property

Public Property Let SelectBackColor(ByVal NewSelectBackColor As OLE_COLOR)
   If vgSelectBackColor <> NewSelectBackColor Then
      vgSelectBackColor = NewSelectBackColor
      PropertyChanged "SelectBackColor"
      Call SetStyle
   End If
End Property

Public Property Get SelectBackColor() As OLE_COLOR
   SelectBackColor = vgSelectBackColor
End Property

Public Property Let SelectTextColor(ByVal NewSelectTextColor As OLE_COLOR)
   If vgSelectTextColor <> NewSelectTextColor Then
      vgSelectTextColor = NewSelectTextColor
      PropertyChanged "SelectTextColor"
      Call SetStyle
   End If
End Property

Public Property Get SelectTextColor() As OLE_COLOR
   SelectTextColor = vgSelectTextColor
End Property

Public Property Let ColSelectBackColor(ByVal NewColSelectBackColor As OLE_COLOR)
   If vgColSelectBackColor <> NewColSelectBackColor Then
      vgColSelectBackColor = NewColSelectBackColor
      PropertyChanged "ColSelectBackColor"
      Call SetStyle
   End If
End Property

Public Property Get ColSelectBackColor() As OLE_COLOR
   ColSelectBackColor = vgColSelectBackColor
End Property

Public Property Let ColSelectTextColor(ByVal NewColSelectTextColor As OLE_COLOR)
   If vgColSelectTextColor <> NewColSelectTextColor Then
      vgColSelectTextColor = NewColSelectTextColor
      PropertyChanged "ColSelectTextColor"
      Call SetStyle
   End If
End Property

Public Property Get ColSelectTextColor() As OLE_COLOR
   ColSelectTextColor = vgColSelectTextColor
End Property

Public Property Let CaptionBackColor(ByVal NewCaptionBackColor As OLE_COLOR)
   vgCaptionBackColor = NewCaptionBackColor
   PropertyChanged "CaptionBackColor"
   If Not vgReadingProps Then DrawBars
End Property

Public Property Get CaptionBackColor() As OLE_COLOR
   CaptionBackColor = vgCaptionBackColor
End Property

Public Property Let CaptionTextColor(ByVal NewCaptionTextColor As OLE_COLOR)
   vgCaptionTextColor = NewCaptionTextColor
   PropertyChanged "CaptionTextColor"
   If Not vgReadingProps Then DrawBars
End Property

Public Property Get CaptionTextColor() As OLE_COLOR
   CaptionTextColor = vgCaptionTextColor
End Property

Public Property Let ColHeaderBackColor(ByVal NewColHeaderBackColor As OLE_COLOR)
   vgColHeaderBackColor = NewColHeaderBackColor
   PropertyChanged "ColHeaderBackColor"
   If Not vgReadingProps Then DrawBars
End Property

Public Property Get ColHeaderBackColor() As OLE_COLOR
   ColHeaderBackColor = vgColHeaderBackColor
End Property

Public Property Let ColHeaderTextColor(ByVal NewColHeaderTextColor As OLE_COLOR)
   vgColHeaderTextColor = NewColHeaderTextColor
   PropertyChanged "ColHeaderTextColor"
   If Not vgReadingProps Then DrawBars
End Property

Public Property Get ColHeaderTextColor() As OLE_COLOR
   ColHeaderTextColor = vgColHeaderTextColor
End Property

Public Property Let FilterBackColor(ByVal NewFilterBackColor As OLE_COLOR)
   vgFilterBackColor = NewFilterBackColor
   PropertyChanged "FilterBackColor"
   If Not vgReadingProps Then DrawBars
End Property

Public Property Get FilterBackColor() As OLE_COLOR
   FilterBackColor = vgFilterBackColor
End Property

Public Property Let FilterTextColor(ByVal NewFilterTextColor As OLE_COLOR)
   vgFilterTextColor = NewFilterTextColor
   PropertyChanged "FilterTextColor"
   If Not vgReadingProps Then DrawBars
End Property

Public Property Get FilterTextColor() As OLE_COLOR
   FilterTextColor = vgFilterTextColor
End Property

Public Property Let StatusBackColor(ByVal NewStatusBackColor As OLE_COLOR)
   vgStatusBackColor = NewStatusBackColor
   PropertyChanged "StatusBackColor"
   If Not vgReadingProps Then DrawBars
End Property

Public Property Get StatusBackColor() As OLE_COLOR
   StatusBackColor = vgStatusBackColor
End Property

Public Property Let StatusTextColor(ByVal NewStatusTextColor As OLE_COLOR)
   vgStatusTextColor = NewStatusTextColor
   PropertyChanged "StatusTextColor"
   If Not vgReadingProps Then DrawBars
End Property

Public Property Get StatusTextColor() As OLE_COLOR
   StatusTextColor = vgStatusTextColor
End Property

Public Property Let LeftBackColor(ByVal NewLeftBackColor As OLE_COLOR)
   vgLeftBackColor = NewLeftBackColor
   PropertyChanged "LeftBackColor"
   If Not vgReadingProps Then DrawBars
End Property

Public Property Get LeftBackColor() As OLE_COLOR
   LeftBackColor = vgLeftBackColor
End Property

Public Property Let SumBackColor(ByVal NewSumBackColor As OLE_COLOR)
   vgSumBackColor = NewSumBackColor
   PropertyChanged "SumBackColor"
   If Not vgReadingProps Then DrawBars
End Property

Public Property Get SumBackColor() As OLE_COLOR
   SumBackColor = vgSumBackColor
End Property

Public Property Let SumTextColor(ByVal NewSumTextColor As OLE_COLOR)
   vgSumTextColor = NewSumTextColor
   PropertyChanged "SumTextColor"
   If Not vgReadingProps Then DrawBars
End Property

Public Property Get SumTextColor() As OLE_COLOR
   SumTextColor = vgSumTextColor
End Property

Public Property Let AvgBackColor(ByVal NewAvgBackColor As OLE_COLOR)
   vgAvgBackColor = NewAvgBackColor
   PropertyChanged "AvgBackColor"
   If Not vgReadingProps Then DrawBars
End Property

Public Property Get AvgBackColor() As OLE_COLOR
   AvgBackColor = vgAvgBackColor
End Property

Public Property Let AvgTextColor(ByVal NewAvgTextColor As OLE_COLOR)
   vgAvgTextColor = NewAvgTextColor
   PropertyChanged "AvgTextColor"
   If Not vgReadingProps Then DrawBars
End Property

Public Property Get AvgTextColor() As OLE_COLOR
   AvgTextColor = vgAvgTextColor
End Property

Public Property Let MinBackColor(ByVal NewMinBackColor As OLE_COLOR)
   vgMinBackColor = NewMinBackColor
   PropertyChanged "MinBackColor"
   If Not vgReadingProps Then DrawBars
End Property

Public Property Get MinBackColor() As OLE_COLOR
   MinBackColor = vgMinBackColor
End Property

Public Property Let MinTextColor(ByVal NewMinTextColor As OLE_COLOR)
   vgMinTextColor = NewMinTextColor
   PropertyChanged "MinTextColor"
   If Not vgReadingProps Then DrawBars
End Property

Public Property Get MinTextColor() As OLE_COLOR
   MinTextColor = vgMinTextColor
End Property

Public Property Let MaxBackColor(ByVal NewMaxBackColor As OLE_COLOR)
   vgMaxBackColor = NewMaxBackColor
   PropertyChanged "MaxBackColor"
   If Not vgReadingProps Then DrawBars
End Property

Public Property Get MaxBackColor() As OLE_COLOR
   MaxBackColor = vgMaxBackColor
End Property

Public Property Let MaxTextColor(ByVal NewMaxTextColor As OLE_COLOR)
   vgMaxTextColor = NewMaxTextColor
   PropertyChanged "MaxTextColor"
   If Not vgReadingProps Then DrawBars
End Property

Public Property Get MaxTextColor() As OLE_COLOR
   MaxTextColor = vgMaxTextColor
End Property

Public Property Let GridLinesColor(ByVal NewGridLinesColor As OLE_COLOR)
   vgGridLinesColor = NewGridLinesColor
   PropertyChanged "GridLinesColor"
   If Not vgReadingProps Then DrawBars
End Property

Public Property Get GridLinesColor() As OLE_COLOR
   GridLinesColor = vgGridLinesColor
End Property

Public Property Get ColumnCount() As Integer
   ColumnCount = vgColumns.Count
End Property

Public Property Let ColumnCount(ByVal NewColumnCount As Integer)
   Dim i As Integer
   ClearColumns
   For i = 1 To NewColumnCount
      AddColumn Nothing, Nothing, "COLUMN" + CStr(i), "", TP_CARACTER, "", 0, True
   Next
   Refresh
End Property

'retorna o valor da soma dos itens da coluna informada
Public Property Get GetColumnSum(ByVal vgColumn As Variant) As Double
   FillScalarValues SCALAR_SUM                    'carrega os valores de soma das colunas independente da exibição da barra de soma
   GetColumnSum = vgColDefinitions(vgColumns(vgColumn).Index).ValueSum
End Property

'retorna o valor máximo da coluna informada
Public Property Get GetColumnMax(ByVal vgColumn As Variant) As Double
   FillScalarValues SCALAR_MAX                    'carrega os valores máximos das colunas independente da exibição da barra de máximo
   GetColumnMax = vgColDefinitions(vgColumns(vgColumn).Index).ValueMax
End Property

'retorna o valor mínimo da coluna informada
Public Property Get GetColumnMin(ByVal vgColumn As Variant) As Double
   FillScalarValues SCALAR_MIN                    'carrega os valores mínimos das colunas independente da exibição da barra de mínimo
   GetColumnMin = vgColDefinitions(vgColumns(vgColumn).Index).ValueMin
End Property

'retorna o valor médio da coluna informada
Public Property Get GetColumnAvg(ByVal vgColumn As Variant) As Double
   FillScalarValues SCALAR_AVG                    'carrega os valores médios das colunas independente da exibição da barra de média
   GetColumnAvg = vgColDefinitions(vgColumns(vgColumn).Index).ValueAvg
End Property

Public Property Get CacheSize() As Integer
   CacheSize = vgCacheSize
End Property

Public Property Let CacheSize(ByVal NewCacheSize As Integer)
   vgCacheSize = NewCacheSize
   If vgCacheSize = 0 Then
      ReDim vgCacheTable(0, 0, 0) As Variant
   Else
      ReDim vgCacheTable(1 To vgCacheSize, 1 To ITEM_CACHE_MAX, 0 To vgColumns.Count) As Variant
   End If
   ResetBookMark
End Property

'determina se filtro funcionará automaticamento com o timer
Public Property Let AutoApplyFilter(ByVal NewAutoApplyFilter As Boolean)
   vgAutoApplyFilter = NewAutoApplyFilter
End Property

'informa se o filtro está automatico - usando o timer - ou não.
Public Property Get AutoApplyFilter() As Boolean
   AutoApplyFilter = vgAutoApplyFilter
End Property

'determina se o combo irá recarregar os dados antes de abrir
Public Property Let AutoRebind(ByVal NewAutoRebind As Boolean)
   vgAutoRebind = NewAutoRebind
End Property

'informa se o combo irá recarregar seus dados no clique de abertura
Public Property Get AutoRebind() As Boolean
   AutoRebind = vgAutoRebind
End Property


'============================================
' Métodos do listview (públicos)
'============================================

'CUIDADO: ROTINA MANUAL
'PROPOSITO: Quando a consulta retornar apenas um registro nw dar foco a barra de filtro
'caso contrario bora lah
Public Sub SetFocusFilter()
   If vgShowFilterBar And vgColAtual > 0 Then
      If vgNumItemsTot > 1 Then      'Manual
         ApplyFilterAndOrder
         DoEvents                                    'para permitir que a barra de filtro receba o foco
         If txtFilter(vgColAtual).Visible Then
            txtFilter(vgColAtual).SetFocus
         End If
      End If
   'INICIO MANUAL
   Else
      SelecionaItem 1
   End If
   'FIM MANUAL
End Sub
Public Sub Scroll(ByVal dX As Long, dy As Long)
   If dX = 0 And dy < 0 And FirstItemVisible = 0 Then Exit Sub
   If dX = 0 And dy > 0 And LastItemVisible = vgNumItemsTot - 1 Then Exit Sub
   vgForcePosSel = True                               'vamos ter que forçar o reposicionamento da picSel e nova chamada para DefineControle
   SendMessageLong hWndLst, LVM_SCROLL, dX, dy
   Repaint -1
End Sub

Public Sub SetAllColumnsScalar(vgOq As Integer)
   Dim vgCol As GColumn
   For Each vgCol In vgColumns
      If Len(vgCol.NameFilter) > 0 And Len(vgColDefinitions(vgCol.Index).ComboTable) = 0 And Len(vgColDefinitions(vgCol.Index).ComboFieldsList) = 0 Then                    'não vamos dar sugestão de sum para colunas tipo fórmula
         Select Case vgOq
            Case 0
               vgColDefinitions(Val(vgCol.Index)).ShowSum = True
            Case 1
               vgColDefinitions(Val(vgCol.Index)).ShowMax = True
            Case 2
               vgColDefinitions(Val(vgCol.Index)).ShowMin = True
            Case 3
               vgColDefinitions(Val(vgCol.Index)).ShowAvg = True
         End Select
      End If
   Next
   ApplyFilterAndOrder
   DrawStatusBar
End Sub

Public Sub AddItem(ByVal vgValor As String)
   Dim vgNItems As Long
   vgInternalLst = True
   If Columns.Count = 0 Then
      AddColumn Nothing, Nothing, "", "", TP_CARACTER, "", 255, True
   End If
   vgNItems = vgNumItems + 1
   ReDim Preserve vgItens(vgNItems) As String
   vgItens(vgNItems) = vgValor
   vgPriVez = vgPriVez + 1
   SetItemCount vgNItems
   vgPriVez = vgPriVez - 1
End Sub

Public Sub RemoveItem(ByVal vgIndex As Long)
   vgIndex = vgIndex + 1
   If vgIndex > 0 And vgIndex <= vgNumItems Then
      If vgIndex < vgNumItems Then
         CopyMemory ByVal VarPtr(vgItens(vgIndex)), ByVal VarPtr(vgItens(vgIndex + 1)), (vgNumItems - vgIndex + 1) * 4
         CopyMemory ByVal VarPtr(vgItens(vgNumItems)), StrPtr(vgItens(vgIndex)), 4&
      End If
      vgNumItems = vgNumItems - 1
      ReDim Preserve vgItens(vgNumItems) As String
      vgPriVez = vgPriVez + 1
      SetItemCount vgNumItems
      vgPriVez = vgPriVez - 1
   End If
End Sub

Public Sub DeleteRecords(Optional DeleteAll As Boolean, Optional ChangeStatus As Boolean = True)
   Call DeleteRows(DeleteAll, ChangeStatus)
End Sub

Public Sub ClearItems()
   SetItemCount 0
   vgInternalLst = False
End Sub

Public Sub GetItemInfo(ByRef x As Long, ByRef y As Long, ByRef w As Long, ByRef h As Long, Optional ByVal vgRow As Long = -1)
   Dim Rc As RECT
   If vgRow = -1 Then
      vgRow = SelectedItem
   End If
   Rc.Left = 0: Rc.Right = 0: Rc.Top = 0: Rc.Bottom = 0
   SendMessage hWndLst, LVM_GETITEMRECT, vgRow, Rc
   x = (Rc.Left + 3) * vgTpX
   y = (Rc.Top - 1) * vgTpY
   w = (Rc.Right - Rc.Left) * vgTpX
   h = (Rc.Bottom - Rc.Top) * vgTpY
End Sub

'permite desabilitar itens do menu popup "opções especiais"
Public Sub SpecialPopupDisabled(vgDisabledFlags As POP_GRID_DISABLED)
   If vgDisabledFlags And POP_GRID_COLS Then M_Special(3).Enabled = False      'desabilita a opção de "salvar colunas"
   If vgDisabledFlags And POP_GRID_BARS Then M_Special(2).Enabled = False      'desabilita a opção de "salvar barras"
   If vgDisabledFlags And POP_GRID_STRIPES Then
      M_Special(0).Enabled = False                                             'desabilita a opção de "zebrar"
      M_Special(4).Enabled = False                                             'desabilita a opção de "salvar zebrado"
   End If
End Sub

Private Sub DefineMask(ByVal vgColumn As Variant)
   If vgColDefinitions(vgColumn).txtCampoGrd Is Nothing Then
      Set vgColDefinitions(vgColumn).txtCampoGrd = New FormataCampos
   End If
End Sub

' Returns the low 16-bit integer from a 32-bit long integer
Private Function LoWord(ByVal dwValue As Long) As Integer
   CopyMemory LoWord, dwValue, 2&
End Function

' returns the high 16-bit integer from a 32-bit long integer
Private Function HiWord(ByVal nValue&) As Integer
   CopyMemory HiWord, ByVal VarPtr(nValue) + 2, 2&
End Function

've se é BMP/WMF/DIB gravado no bd
Private Function BlobComBMP(ByVal vgColumn As String) As Boolean
   Dim x As String, Assina As String, Chk() As Byte
   ReDim Chk(3) As Byte
   'assinatura de imagens gravadas como bmp/wmf/dib
   Assina$ = Chr$(&H6C) + Chr$(&H74) + Chr$(0) + Chr$(0)
   vgTabela.BookMark = vgTabela.BookMark
   Chk() = vgTabela.Fields(vgColumn).GetChunk(4)       'pega assinatura
   x$ = Chr$(Chk(0)) + Chr$(Chk(1)) + Chr$(Chk(2)) + Chr$(Chk(3)) 'assinatura no blob
   BlobComBMP = (x$ = Assina$)
End Function

'pega tamanho pelo header do blob (so bmp/wmf/dib)
Private Function PegaTamaRealBMP(ByVal vgColumn As String) As Long
   Dim Chk() As Byte
   Dim x As String, i As Integer
   ReDim Chk(3)
   vgTabela.BookMark = vgTabela.BookMark
   Chk() = vgTabela.Fields(vgColumn).GetChunk(4)       'le duas vezes para pegar
   Chk() = vgTabela.Fields(vgColumn).GetChunk(4)       'bytes de 4 a 8
   x$ = ""
   For i = 0 To 3
      x$ = x$ + Chr$(Chk(i))
   Next
   PegaTamaRealBMP = CVL(x$)
End Function

'pega nome real do BMP/WMF/DIB e enche a pública ArqMidia$
'retorna nome da midia
Private Function PegaNomeRealBMP(ByVal vgColumn As String) As String
   Dim Chk() As Byte, i As Integer, lOffset As Long, qLer As Long, lTama As Long, ArqMidia As String
   'monta nome do arqmidia$
   lTama = PegaTamaRealBMP(vgColumn)                           'apura o tamanho real do bmp
   'posiciona no nome do arquivo...
   lOffset = 8
   qLer = 32000
   If lTama < qLer Then qLer = lTama
   ReDim Chk(qLer - 1)
   Chk() = vgTabela.Fields(vgColumn).GetChunk(qLer)
   lOffset = lOffset + qLer
   Do While lOffset < lTama
      If (lTama + 8) - lOffset < qLer Then qLer = (lTama + 8) - lOffset
      ReDim Chk(qLer - 1) As Byte
      Chk() = vgTabela.Fields(vgColumn).GetChunk(qLer)
      lOffset = lOffset + qLer
   Loop
   ReDim Chk(255) As Byte
   Chk() = vgTabela.Fields(vgColumn).GetChunk(255)             'tamanho do nome do arquivo
   vgTabela.BookMark = vgTabela.BookMark
   'cria arqmidia$
   ArqMidia$ = ""
   For i = 0 To UBound(Chk)
      If Chk(i) <> 0 Then
         ArqMidia$ = ArqMidia$ + Chr$(Chk(i))
      Else
         Exit For
      End If
   Next
   PegaNomeRealBMP = ArqMidia$
End Function

'retorna Nome do arquivo multimídia vinculado ao campo
Private Function PegaNomeMidia(ByVal vgColumn As String) As String
   Dim Chk() As Byte, i As Integer, tNomeArq As Integer, vgArqMidia As String
   ReDim Chk(0) As Byte
   vgTabela.BookMark = vgTabela.BookMark
   Chk() = vgTabela.Fields(vgColumn).GetChunk(1)        'tamanho do nome do arquivo
   tNomeArq = Chk(0)                                    'salva tamanho
   ReDim Chk(tNomeArq + 1) As Byte                      'vamos encher com o nome do arq
      Chk() = vgTabela.Fields(vgColumn).GetChunk(tNomeArq) 'tamanho do nome do arquivo
   vgArqMidia$ = ""
   For i = 0 To tNomeArq - 1                               'recupera nome do arquivo original
      vgArqMidia$ = vgArqMidia$ + Chr$(Chk(i))
   Next
   PegaNomeMidia = vgArqMidia
End Function

Private Function HasBotCp(ByVal vgQual As Integer) As Boolean
   Dim vgBot As CommandButton
   On Error Resume Next
   Set vgBot = bottxtCampo(vgQual)
   vgBot.Visible = vgBot.Visible
   If Err Then
      HasBotCp = False
   Else
      HasBotCp = True
   End If
   Set vgBot = Nothing
   Err.Clear
End Function

Private Function GetBotCp(ByVal vgQual As Integer) As CommandButton
   Dim vgBot As CommandButton
   On Error Resume Next
   Set vgBot = bottxtCampo(vgQual)
   vgBot.Visible = vgBot.Visible
   If Err Then
      Load bottxtCampo(vgQual)
      Err.Clear
   End If
   Set vgBot = bottxtCampo(vgQual)
   Set GetBotCp = vgBot
   Set vgBot = Nothing
   Err.Clear
End Function

Private Function LastItemVisible() As Long
   Dim RetVal As Long
   RetVal = SendMessageLong(hWndLst, LVM_GETTOPINDEX, 0, 0)               'primeiro item da lista
   RetVal = RetVal + SendMessageLong(hWndLst, LVM_GETCOUNTPERPAGE, 0, 0) - 1 'número de itens possíveis para visualização
   If RetVal > vgNumItemsTot - 1 Then                                        'se lista não está completamente cheia
      RetVal = vgNumItemsTot - 1                                             'o índice final será o índice do último item
   End If
   LastItemVisible = RetVal
End Function

Private Function FirstItemVisible() As Long
   FirstItemVisible = SendMessageLong(hWndLst, LVM_GETTOPINDEX, 0, 0)               'primeiro item da lista
End Function

Public Sub SelectFirstItem()
   ItemSelect 0, False
End Sub

Public Sub SelectLastItem()
   Dim vgRow As Long
   vgRow = vgNumItems - 1
   ItemSelect vgRow, False
End Sub

Public Sub SelectNextItem()
   Dim vgRow As Long
   If SelectedItem < vgNumItems - 1 Then
      vgRow = SelectedItem + 1
   Else
      vgRow = vgNumItems - 1
   End If
   ItemSelect vgRow, False
End Sub

Public Sub SelectPreviousItem()
   Dim vgRow As Long
   If SelectedItem > 0 Then
      vgRow = SelectedItem - 1
   Else
      vgRow = 0
   End If
   ItemSelect vgRow, False
End Sub

Public Sub SelecionaItem(ByVal vgRow As Long)
   Dim vgLvi As LV_ITEM, vgItemAtual As Long, i As Long
   If vgPriVez > 0 Or vgRow > vgNumItemsTot - 1 Then Exit Sub
   If Len(vgColsSelected) > 0 And vgRow <> -1 Then
      vgColsSelected = ""
      Refresh
   End If
   If Len(vgRowsSelected) > 0 Then
      vgRowsSelected = Mid(vgRowsSelected, 2)
      Do While Len(vgRowsSelected)
         i = Val(Parse$(vgRowsSelected, "|"))
         Repaint i
      Loop
   End If
   vgRowsSelected = ""
   LimpaValueSel
   vgPriVez = vgPriVez + 1
   vgHasChanged = False
   vgItemAtual = SelectedItem
   If vgItemAtual <> vgRow Then
      vgLvi.iItem = vgRow
      vgLvi.iSubItem = 0
      If vgRow >= 0 Then
         vgLvi.State = LVIS_SELECTED Or LVIS_FOCUSED
      End If
      vgLvi.stateMask = LVIS_SELECTED Or LVIS_FOCUSED
      SendMessageLong hWndLst, LVM_SETITEMSTATE, vgRow, VarPtr(vgLvi)                         'seleciona o primeiro item
      If vgRow <> -1 Then
         LocateRecordset vgRow, True
      End If
   End If
   If vgRow <> -1 Then
      SendMessageLong hWndLst, LVM_ENSUREVISIBLE, vgRow, 0                                    'certifica que ele ficará visível
   Else
      If vgIsPreEditing Then EndEditGrid False, True
   End If
   DrawLeftBar                                    'vamos forçar o desenho da barra lateral, se for necessário
   DrawStatusBar
   DrawHeaderBar
   vgPriVez = vgPriVez - 1
   If (vgAllowInsert And (Not vgInternalLst Or vgAllowInsertDatabase) And vgRow = vgNumItemsTot - 1 And vgTabela.AsyncComplete) Then
      Dim Cols() As Variant
      ReDim Cols(vgColumns.Count) As Variant
      RaiseEvent SkipRecord(Cols(), -2)
      vgLastSkipRec = vgRow
   End If
End Sub

Public Sub AddControlIgnoreFocus(ByVal vgHandle As Long)
   Dim i As Long
   i = UBound(vgIgnoredFocusControls) + 1
   ReDim Preserve vgIgnoredFocusControls(i) As Long
   vgIgnoredFocusControls(i) = vgHandle
End Sub

Public Sub AddColumn(ByVal vgCol As GColumn, Optional ByVal txtCampo As FormataCampos, Optional ByVal vgTitulo As String, Optional ByVal vgCampo As String, Optional ByVal vgTipo As GCOLUMN_TYPE, Optional ByVal vgMask As String, Optional ByVal vgSize As Integer, Optional ByVal vgColumnLocked As Boolean = False, Optional ByVal vgPoeNoGrid As Boolean = True, _
                                                               Optional vgComboDatabase As String, Optional vgComboTable As String, Optional vgComboFieldCapture As String, Optional vgComboFieldsShow As String, Optional vgComboFieldsList As String, Optional vgComboFieldsOrder As String, Optional vgComboFieldsFilter As String, Optional vgComboFieldsRelation As String, Optional vgComboExtensor As String, _
                                                               Optional vgPesqFieldCapture As String, Optional vgPesqSQLExpression As String, Optional vgPesqBD As String, Optional vgPesqExtensor As String, Optional vgPesqModoAbertura As Integer, Optional vgActionButtonExtensor As String, Optional vgColumnWidth As Long, Optional vgColumnTextColor As Long = -1, Optional vgColumnBackColor As Long = -1, _
                                                               Optional vgTitColumnTextColor As Long = -1, Optional vgTitColumnBackColor As Long = -1)
   Dim Format As LVCFMT, ulvc As LVCOLUMN, vgNCampo As String, vgHidden As Boolean
   Dim vgQtCols As Integer                        'armazena a quantidade de colunas de vgColumns.Count para evitar carga de pilha
   If vgCol Is Nothing Then
      If vgTipo = TP_NUMERICO And Len(vgMask) = 0 Then
         vgMask = String(vgSize, "9")
      End If
      If Len(vgCampo$) = 0 Then
         vgNCampo = vgTitulo$
      Else
         vgNCampo = vgCampo$
      End If
      vgHidden = False
      vgColumns.Add vgNCampo, vgTitulo, vgTipo, vgMask, vgSize, 0, Not vgPoeNoGrid, False, False, False, 0, False, "", False, vgCampo
   Else
      If Len(vgCol.Name) = 0 Then
         vgNCampo = vgCol.Title
      Else
         vgNCampo = vgCol.Name
      End If
      vgHidden = vgCol.Hidden
      vgColumns.Add vgNCampo, vgCol.Title, vgCol.ColumnType, vgCol.Mask, vgCol.Size, vgCol.QDecimal, Not vgPoeNoGrid Or vgHidden, False, False, False, 0, False, "", vgCol.UpdatableColumn, vgCol.Name
      vgTitulo = vgCol.Title
      vgTipo = vgCol.ColumnType
      If vgTipo <> TP_MEMO And vgTipo <> TP_BINARIO Then
         vgSize = vgCol.Size
      End If
   End If
   vgQtCols = vgColumns.Count
   ReDim Preserve vgColDefinitions(vgQtCols) As GRD_ColumnDefinition

   'vamos pegar definições de "Lista (combo-box)"
   If Not txtCampo Is Nothing Then
      If Len(vgComboDatabase) = 0 Then vgComboDatabase = txtCampo.DataBase
      If Len(vgComboTable) = 0 Then vgComboTable = txtCampo.Source
      If Len(vgComboFieldCapture) = 0 Then vgComboFieldCapture = txtCampo.BoundColumn
      If Len(vgComboFieldsShow) = 0 Then vgComboFieldsShow = txtCampo.ShowFields
      If Len(vgComboFieldsList) = 0 Then vgComboFieldsList = txtCampo.ListFields
      If Len(vgComboFieldsOrder) = 0 Then vgComboFieldsOrder = txtCampo.OrderFields
      If Len(vgComboFieldsFilter) = 0 Then vgComboFieldsFilter = txtCampo.Filter
      If Len(vgComboFieldsRelation) = 0 Then vgComboFieldsRelation = txtCampo.Relation
   End If
   
   'vamos pegar definições de "Lista (pesquisa)"
   If Not txtCampo Is Nothing Then
      If Len(vgPesqFieldCapture) = 0 Then vgPesqFieldCapture = txtCampo.PesqFieldCapture
      If Len(vgPesqSQLExpression) = 0 Then vgPesqSQLExpression = txtCampo.PesqSQLExpression
      If Len(vgPesqBD) = 0 Then vgPesqBD = txtCampo.PesqBD
      If Len(vgPesqModoAbertura) = 0 Then vgPesqModoAbertura = txtCampo.PesqModoAbertura
   End If
   
   'definições para "Lista (combo-box)"
   vgColDefinitions(vgQtCols).ComboDataBase = vgComboDatabase
   vgColDefinitions(vgQtCols).ComboTable = vgComboTable
   vgColDefinitions(vgQtCols).ComboFieldCapture = vgComboFieldCapture
   vgColDefinitions(vgQtCols).ComboFieldsShow = vgComboFieldsShow
   vgColDefinitions(vgQtCols).ComboFieldsList = vgComboFieldsList
   vgColDefinitions(vgQtCols).ComboFieldsOrder = vgComboFieldsOrder
   vgColDefinitions(vgQtCols).ComboFieldsRelation = vgComboFieldsRelation
   vgColDefinitions(vgQtCols).ComboFieldsFilter = vgComboFieldsFilter
   vgColDefinitions(vgQtCols).ComboExtensor = vgComboExtensor
   
   'definições para "Lista (pesquisa)"
   vgColDefinitions(vgQtCols).PesqFieldCapture = vgPesqFieldCapture
   vgColDefinitions(vgQtCols).PesqSQLExpression = vgPesqSQLExpression
   vgColDefinitions(vgQtCols).PesqBD = vgPesqBD
   vgColDefinitions(vgQtCols).PesqExtensor = vgPesqExtensor
   vgColDefinitions(vgQtCols).PesqModoAbertura = vgPesqModoAbertura

   'definição para extensor de "Comportamento"
   vgColDefinitions(vgQtCols).ActionButtonExtensor = vgActionButtonExtensor
   
   'definições de cores
   vgColDefinitions(vgQtCols).TextColor = vgColumnTextColor
   vgColDefinitions(vgQtCols).BackColor = vgColumnBackColor
   vgColDefinitions(vgQtCols).HeaderTextColor = vgTitColumnTextColor
   vgColDefinitions(vgQtCols).HeaderBackColor = vgTitColumnBackColor

   'definição de bloqueio do campo
   If Not txtCampo Is Nothing Then
      vgColumnLocked = txtCampo.Locked
   End If
   vgColDefinitions(vgQtCols).Locked = vgColumnLocked

   'instancia campo para definições se tem "Ação do clique", "Lista (pesquisa)" ou "Lista (combo-box)" ou lista interna
   If Val(vgActionButtonExtensor) > 0 Or Len(vgPesqSQLExpression) > 0 Or Len(vgComboTable) > 0 Or Len(vgComboFieldsList) > 0 Then
      If vgColDefinitions(vgQtCols).txtCampoGrd Is Nothing Then
         Set vgColDefinitions(vgQtCols).txtCampoGrd = New FormataCampos
      End If
   End If

   'definições de lista interna
   If Len(vgComboFieldsList) > 0 Then
      With vgColDefinitions(vgQtCols).txtCampoGrd
         .ListFields = vgColDefinitions(vgQtCols).ComboFieldsList
         .DataType = PegaTipoMask(vgTipo)
      End With
   End If

   'definições de "Lista (pesquisa)"
   If Len(vgPesqSQLExpression) > 0 Then
      With vgColDefinitions(vgQtCols).txtCampoGrd
         .PesqFieldCapture = vgColDefinitions(vgQtCols).PesqFieldCapture
         .PesqSQLExpression = vgColDefinitions(vgQtCols).PesqSQLExpression
         .PesqBD = vgColDefinitions(vgQtCols).PesqBD
      End With
   End If

   'definições de "Lista (combo-box)"
   If Len(vgComboTable) > 0 Then
      With vgColDefinitions(vgQtCols).txtCampoGrd
         .DataBase = vgDb(vgColDefinitions(vgQtCols).ComboDataBase)
         .ListFields = vgColDefinitions(vgQtCols).ComboFieldsList
         .BoundColumn = vgColDefinitions(vgQtCols).ComboFieldCapture
         .ShowFields = vgColDefinitions(vgQtCols).ComboFieldsShow
         .OrderFields = vgColDefinitions(vgQtCols).ComboFieldsOrder
         .Filter = vgColDefinitions(vgQtCols).ComboFieldsFilter
         .Source = vgColDefinitions(vgQtCols).ComboTable
      End With
   End If

   If vgPoeNoGrid And Not vgHidden Then           'se coluna presente no grid
      With ulvc
         .pszText = vgTitulo
         .cchTextMax = Len(vgTitulo)
         .Mask = LVCF_FMT Or LVCF_TEXT Or LVCF_WIDTH
         If vgQtCols > 1 Then
            .Mask = .Mask Or LVCF_SUBITEM
            .iSubItem = vgQtCols
         End If
         If vgTipo = TP_NUMERICO Then
            vgColDefinitions(vgQtCols).Alignment = LVCFMT_RIGHT
         Else
            vgColDefinitions(vgQtCols).Alignment = LVCFMT_LEFT
         End If
         .fmt = vgColDefinitions(vgQtCols).Alignment
         If vgColumnWidth > 0 Then
            .cx = vgColumnWidth / vgTpX
         Else
            If vgSize > 0 Then
               vgColumnWidth = Len(vgTitulo) * Me.TextWidth("X")
               If vgColumnWidth < vgSize * Me.TextWidth("X") Then
                  vgColumnWidth = vgSize * Me.TextWidth("X")
               End If
            Else
               vgColumnWidth = 117 * vgTpX
            End If
            .cx = vgColumnWidth / vgTpX
         End If
      End With
      SendMessageAPI hWndLst, LVM_INSERTCOLUMN, (vgQtCols - 1), ulvc
      
   End If

   If txtFilter.Count <= vgQtCols Then
      Load txtFilter(vgQtCols)
      Load botFilter(vgQtCols)
   End If
   ReDim Preserve txtCampoFilter(vgQtCols) As FormataCampos
   Set txtCampoFilter(vgQtCols) = New FormataCampos
   vgColDefinitions(vgQtCols).Position = vgQtCols
   vgColDefinitions(vgQtCols).OriginalPosition = vgQtCols
   vgColDefinitions(vgQtCols).OrderPosition = 0
   vgColDefinitions(vgQtCols).Order = 0
   vgColDefinitions(vgQtCols).Width = vgColumnWidth
   vgColDefinitions(vgQtCols).Left = vgColDefinitions(vgQtCols - 1).Left + vgColDefinitions(vgQtCols - 1).Width
   If Not vgHideLeftBar And vgQtCols = 1 Then
      vgColDefinitions(vgQtCols).Left = vgColDefinitions(vgQtCols).Left + vgLeftBarWidth
   End If
   vgColDefinitions(vgQtCols).OriginalWidth = vgColumnWidth
   If Not txtCampo Is Nothing Then
      Set vgColDefinitions(vgQtCols).txtCampo = txtCampo
   End If
   DefineCampo vgQtCols
   DefineCampoFilter vgQtCols                     'vamos definir as propriedades da coluna na barra de filtragem
   If vgCacheSize <> 0 Then
      ReDim vgCacheTable(1 To vgCacheSize, 1 To ITEM_CACHE_MAX, 0 To vgQtCols) As Variant
      vgCacheFirst = -1
   End If
End Sub

Public Sub ClearSearch()
   vgUltColProcura = ""
   vgUltProcura = ""
End Sub

Public Sub ClearColumns()
   Dim i As Integer
   On Error Resume Next
   For i = vgColumns.Count To 1 Step -1
      vgColumns.Remove i
      SendMessageLong hWndLst, LVM_DELETECOLUMN, (i - 1), 0
   Next
End Sub

'ROTINA MANUAL
'PROPOSITO: Apagar o filtro da pesquisa sempre que fechar ela
Public Sub ClearFilterBar()
   'Antes
   'Dim i As Integer
   'For i = 1 To vgColumns.Count - 1
   '   txtFilter(i).Text = ""
   'Next
   'Agora
   'Inicio Manual
   Dim i As Integer, Limpou As Boolean
   For i = 0 To vgColumns.Count - 1
      If txtFilter(i).Text <> "" Then Limpou = True
      txtFilter(i).Text = ""
   Next
   If Limpou Then ApplyFilterAndOrder
   'Fim Manual
End Sub

Public Sub CancelEdit()
   If vgHasChanged Then
      RaiseEvent CancelEdit(SelectedItem)         'dispara o evento Canceledit do grid
      vgHasChanged = False
      vgIsPreEditing = True
      vgForcePosSel = True
      vgPriVez = vgPriVez + 1
      Call RefreshStatus
      vgPriVez = vgPriVez - 1
      ClearColumnDefinition
      If vgTabela.AsyncComplete Then FillScalarValues 'atualiza os valores das barras de somatório, média, mínimo, máximo
   End If
   
   'vamos forças redefinição completa para o txtEdit
   vgForcePosSel = True
   vgColEditing = -1
   vgRowEditing = -1
   PosicionaSelect
   
   DrawBars
   
   Repaint SelectedItem
End Sub

Public Sub SaveEdit()
   EndEditGrid True, True
End Sub

Private Function MakeExpressionSelect(ByVal vgBaseSelect As String, ByVal vgTab As String) As String
   Dim i As Integer, RetVal As String, x As String
   RetVal$ = ""
   For i = 1 To Tally(vgBaseSelect, "|")
      x = Parse$(vgBaseSelect$, "|", i)
      RetVal$ = RetVal$ + PoeColchetes(vgTab$) + "." + PoeColchetes(x$, True) + " AS " + PoeColchetes(x$, True) + ", "
   Next
   RetVal$ = Left$(RetVal$, Len(RetVal$) - 2)
   MakeExpressionSelect = RetVal
End Function

Public Sub CloseRecordset()
   Dim i As Integer
   For i = 1 To vgColumns.Count
      If Not vgColDefinitions(i).txtCampoGrd Is Nothing Then
         If Not vgColDefinitions(i).txtCampoGrd.vgfrmGMCale Is Nothing Then
            vgColDefinitions(i).txtCampoGrd.vgfrmGMCale.grdListaG.RecordSet.CloseRecordset
         End If
      End If
   Next
   vgTabela.CloseRecordset
   vgSQLOrig$ = ""
   vgCacheFirst = -1
   vgColAtual = -1
   ResetBookMark
   SetItemCount 0
   Refresh
   PosicionaSelect
   RaiseEvent SkipRecord(GetOriginalCols, -2)        'força skip para que os grids neto também sejam atualizados
End Sub

Public Sub OpenRecordSet(ByVal vgSQL As String, vgCursorType As EnumCursorType, Optional vgAutoColumn As Boolean, Optional vgWh As String, Optional vgOrd As String, Optional vgTop As Integer = -1, Optional vgNDb As Integer = 1, Optional vgNative As Boolean = False, Optional vgForceOpen As Boolean = False)
   Dim vgCp As GColumn, i As Integer, x As String, vgExtWhere As String, vgExtOrd As String

   If vgSQL = vgSQLOrig And vgWh$ = vgWhOrig$ And vgOrd$ = vgOrdOrig$ And vgAutoColumn = vgAutoColumnOrig And vgTop = vgTopOrig And Not vgForceOpen Then Exit Sub
   
   vgInternalLst = False
   ResetBookMark
   vgTopOrig = -1
   
   'vamos pegar TOP original da select e sugerir no campo para TOP
   x$ = ExtraiSQL(vgSQL$, EXP_SELECT)
   If Len(x$) > 0 Then
      x$ = Substitui$(x$, vbCrLf, "", UM_A_UM)
      If UCase$(Left$(x$, 4)) = "TOP " Then
         x$ = Mid$(x$, 4)
         vgTopOrig = Val(x$)
         txtTop.Text = CStr(vgTopOrig)
      End If
   End If
   
   PrepareFilterAndOrder
   
   vgExtWhere = vgTabela.ExternalWhere
   vgExtOrd = vgTabela.ExternalOrderBy
   
   'vamos instanciar o recordset
   If vgTabela Is Nothing Then
      Set vgTabela = New GRecordSet
   Else
      vgTabela.Reset
   End If
   vgTabela.CursorType = vgCursorType                    'abre em modo async, enche gradativamente
   vgTabela.Top = vgTop
   vgTabela.Where = vgWh                                 'Coloca Where
   vgTabela.OrderBy = vgOrd                              'Coloca Order By
   vgTabela.SelectColumns = ""
   vgTabela.Source = vgSQL$
   
      'filter and order
   vgTabela.ExternalWhere = vgExtWhere
   vgTabela.ExternalOrderBy = vgExtOrd
   
   'tira top se necessário e coloca como cláusula externa
   PrepareTop
   
   'armazena para comparação no início deste método
   vgSQLOrig$ = vgSQL$
   vgWhOrig$ = vgWh$
   vgOrdOrig$ = vgOrd$
   vgAutoColumnOrig = vgAutoColumn

   'vamos adicionar as relações para combo-box
   vgTabela.ClearRelations
   For i = 1 To vgColumns.Count
      If Len(vgColDefinitions(i).ComboTable) > 0 And Len(vgColDefinitions(i).ComboFieldsRelation) > 0 Then
         vgTabela.AddRelation vgColDefinitions(i).ComboTable, vgColDefinitions(i).ComboFieldCapture, vgColDefinitions(i).ComboFieldsList, vgColDefinitions(i).ComboFieldsOrder, vgColDefinitions(i).ComboFieldsFilter, vgColDefinitions(i).ComboFieldsRelation
      End If
   Next
   
   Set vgTabela.DataBase = vgDb(vgNDb)                   'define o banco onde será executada a consulta
   vgTabela.OpenRecordSet , , vgNative, vgAllowDelete Or vgAllowEdit Or vgAllowInsert 'ok, agora abre o recordset
   
   'se tem barra de filtro e existe valor tem algum valor a ser filtrado, habilita timer para disparar a aplicação do filtro
   If vgShowFilterBar Then
      For i = 1 To txtFilter.Count - 1
         If Len(txtFilter(i).Text) > 0 Then
            timRefresh.Enabled = vgAutoApplyFilter
            Exit For
         End If
      Next
   End If

   Screen.MousePointer = vbDefault
   
   If vgTabela.AsyncComplete Then
      RaiseEvent RecordSetChanged(vgTabela)
   End If
   
   vgAllowEditDatabase = vgTabela.Editable
   vgAllowInsertDatabase = vgTabela.Insertable
   vgAllowDeleteDatabase = vgTabela.Deletable

   SetItemCount vgTabela.RecordCount

   'vamos inserir automaticamente as colunas conforme o RecordSet
   If vgAutoColumn Then
      ClearColumns
      For Each vgCp In vgTabela.Table.Columns
         AddColumn vgCp                           '  vgCp.Title, vgCp.Name, vgCp.ColumnType, vgCp.Mask, vgCp.Size, Not vgCp.Hidden, ""
      Next
      Set vgCp = Nothing
   End If
   
   'vamos zerar controle de bookmark
   Call ResetBookMark

   vgColEditing = -1
   vgRowEditing = -1
   
   vgColAtual = GetVisibleCol(COL_FIRST)
   
   If vgNumItems > 0 Then
      SelecionaItem 0
   Else
      ClearColumnDefinition
   End If
   PosicionaSelect
   
   If vgTabela.AsyncComplete Then FillScalarValues
   Refresh
End Sub

'ROTINA MANUAL
'PROPOSITO: QUANDO SELECIONAR TODOS OS ITENS DO GRID RECALCULAR O SOMATORIO
Public Sub ReBind()
   On Error Resume Next
   If Not vgTabela Is Nothing And vgHasChanged = False Then

      'vamos zerar controle de bookmark
      Call ResetBookMark
      PrepareCacheTable -1

      If Len(vgTabela.Source) > 0 Or Len(vgTabela.RsSource) > 0 Then
         If vgTabela.AsyncComplete And vgTabela.RecordCount < 200000 Then
            vgTabela.Requery
            vgCacheFirst = -1
            SetItemCount vgTabela.RecordCount
         End If
         'caso esteja em grid filho e está navegando no pai, sempre que reabrir o rs precisamos retirar a seleção para que
         'quando o primeiro item for selecionado o evento LVN_ITEMCHANGED seja disparado...
         SelecionaItem -1
         Repaint -1
         If vgTabela.RecordCount > 0 Then
            vgRecPosAtual = 0
            vgTabela.MoveFirst
         End If
         If vgIsPreEditing Then
            vgColEditing = -1                              'vamos forçar
            vgForcePosSel = True                           'redefinição
         End If
         If vgTabela.AsyncComplete Then
            RaiseEvent RecordSetChanged(vgTabela)
         End If
      End If
   End If
   'Inicio Manual
   FillScalarValues
   'Fim Manual
   Refresh
End Sub
Public Sub RefreshRecordSet()
   Dim vgBk As Variant
   
   vgBk = vgTabela.BookMark
   
   SetItemCount vgTabela.RecordCount
   
   'vamos zerar controle de bookmark
   Call ResetBookMark

   If Val(vgBk) <> -1 And Val(vgBk) <> -2 And Val(vgBk) <> -3 And Len(vgBk) > 0 Then
      vgTabela.BookMark = vgBk
      ItemSelect vgTabela.AbsolutePosition - 1, False
   End If
   
   Refresh
End Sub

Public Sub Refresh(Optional vgClearCache As Boolean)
   Dim Rc As RECT
   If vgPriVez > 0 Or vgReadingProps Then Exit Sub
   If UserControl.Extender.Visible Then
      If vgClearCache Then
         vgCacheFirst = -1
      End If
      If picFundo.Visible Then Exit Sub
      GetClientRect hWndLst, Rc
      RedrawWindow hWndLst, Rc, 0, RDW_ALLCHILDREN Or RDW_ERASE Or RDW_INVALIDATE Or RDW_UPDATENOW
   End If
   DrawBars
End Sub

Public Sub SetItemCount(ByVal nItems As Long)
   If vgPriVez = 0 Then                                              'se não veio da AddItem, pois ela já incrementa o contador e arruma o aray
      vgNumItems = nItems
      ReDim vgItens(0) As String
   End If
   vgNumItems = nItems
   vgNumItemsTot = vgNumItems
   If Len(vgSQLOrig$) > 0 And Not vgTabela Is Nothing Then
      If vgAllowInsert And (vgInternalLst Or vgAllowInsertDatabase) And vgTabela.AsyncComplete Then
         vgNumItemsTot = vgNumItemsTot + 1
      End If
   End If
   SendMessageLong hWndLst, LVM_SETITEMCOUNT, vgNumItemsTot, 0
End Sub

Private Sub AdjustFilterBar()
   Dim i As Integer, x As Long
   
   If Not vgShowFilterBar Then Exit Sub
   
   picFilter.BackColor = vgFilterBackColor
   For i = 1 To vgColumns.Count
      If Not vgColumns(i).Hidden Then
         If ColumnWidth(i) > 3 * vgTpX Then
            txtFilter(i).BackColor = vgEditBackColor
            txtFilter(i).ForeColor = vgEditTextColor
            If vgColumns(i).ColumnType <> TP_LOGICO Then
               txtFilter(i).Alignment = vgColDefinitions(i).Alignment
            End If
            txtFilter(i).Locked = (Len(vgColumns(i).NameFilter) = 0)
            txtFilter(i).Visible = True
            If i = GetVisibleCol(COL_FIRST) Then
               x = ColumnLeft(i) + vgTpX
               If ((vgColumns(i).ColumnType = TP_DATA_HORA And InStr(vgColumns(i).Mask, "/") > 0) Or Len(vgColDefinitions(i).ComboFieldsList) > 0) And ((ColumnWidth(i) - 2 * vgTpX) > botFilter(i).Width) Then                   'se tem extensor de data ou combobox, vamos descontar a largura do botão
                  botFilter(i).Visible = True
                  txtFilter(i).Width = ColumnWidth(i) - vgTpX - botFilter(i).Width
               Else
                  botFilter(i).Visible = False
                  txtFilter(i).Width = ColumnWidth(i) - vgTpX
               End If
            Else
               x = ColumnLeft(i) + 2 * vgTpX
               If ((vgColumns(i).ColumnType = TP_DATA_HORA And InStr(vgColumns(i).Mask, "/") > 0) Or Len(vgColDefinitions(i).ComboFieldsList) > 0) And ((ColumnWidth(i) - 2 * vgTpX) > botFilter(i).Width) Then                   'se tem extensor de data ou combobox, vamos descontar a largura do botão
                  botFilter(i).Visible = True
                  txtFilter(i).Width = ColumnWidth(i) - 2 * vgTpX - botFilter(i).Width
               Else
                  botFilter(i).Visible = False
                  txtFilter(i).Width = ColumnWidth(i) - 2 * vgTpX
               End If
            End If
            If Not vgHideLeftBar Then
               x = x - vgLeftBarWidth
            End If
            txtFilter(i).BackColor = vgFilterBackColor
            txtFilter(i).ForeColor = vgFilterTextColor
            txtFilter(i).Left = x
            txtFilter(i).Top = vgTpY
            txtFilter(i).Height = vgFilterBarHeight - 2 * vgTpY
         Else
            txtFilter(i).Visible = False
            botFilter(i).Visible = False
         End If
         'posicionando o botão extensor para campos do tipo data ou combobox
         botFilter(i).Left = txtFilter(i).Left + txtFilter(i).Width
      End If
   Next
   DrawFilterBar
End Sub

Private Sub AdjustScroll()
   Dim Rc As RECT, xIni As Long, xFim As Long, sI As SCROLLINFO, x As Long
   
   'coordenadas da coluna na tela...
   Rc.Left = ColumnLeft(vgColAtual)
   Rc.Right = Rc.Left + ColumnWidth(vgColAtual)

   'vamos calcular coordenadas mínima e máxima para manter a coluna inteiramente visível
   xIni = 0
   xFim = UserControl.ScaleWidth
   If Not vgHideLeftBar Then
      xIni = vgLeftBarWidth
   End If

   If FirstItemVisible <> 0 Or LastItemVisible < vgNumItemsTot - 1 Then   'se tem scroll vertical visível
      xFim = xFim - GetSystemMetrics(SM_CXVSCROLL) * vgTpX
   End If

   'vamos calcular o scroll necessário para possibilitar vizualização da coluna
   x = 0
   sI.cbSize = Len(sI)
   sI.fMask = SIF_POS Or SIF_RANGE
   x = GetScrollInfo(hWndLst, SB_HORZ, sI)
   
   x = 0
   If Rc.Left < xIni Or (Rc.Right - Rc.Left) > xFim Then                  'ops... início da coluna não está aparecendo... vamos corrigir
      x = ColumnLeft(vgColAtual) / vgTpX
      If Not vgHideLeftBar Then
         x = x - vgLeftBarWidth / vgTpX
      End If
      If sI.nPos + x > 0 Then
         x = x + 1
      ElseIf x > 0 Then
         x = x - 1
      End If
   ElseIf Rc.Left > xFim Or Rc.Right > xFim Then
      x = (ColumnRight(vgColAtual) - xFim) / vgTpX
      x = x + 5                                   '(para aparecer a coluna só precisa somar 3 pixels... vamos somar 2 pixels a mais apenas para deixar uma sobre para a próxima coluna)
   End If
   
   If x <> 0 Then
      Scroll x, 0
   End If

   AdjustFilterBar
   
   'redesenha as barras
   DrawBars

End Sub

Private Sub AdjustColumn()
   AdjustScroll
   PosicionaSelect
   Repaint -1                                        'vamos forçar redraw do item inteiro na mudança de coluna, os fundo das colunas (em edição/inclusão) podem ficar sujos com o backcolor do edit na navegação
End Sub

Public Sub Repaint(ByVal vgRow As Long)
   Dim Rc As RECT, RcLst As RECT
   If vgRow = -1 Then
      vgRow = SelectedItem
   End If
   If vgRow <> -1 And vgRow >= FirstItemVisible And vgRow <= LastItemVisible Then
      Rc.Left = 0: Rc.Right = 0: Rc.Top = 0: Rc.Bottom = 0
      SendMessage hWndLst, LVM_GETITEMRECT, vgRow, Rc
      InvalidateRect hWndLst, Rc, 0
   End If
End Sub

'============================================
' Métodos com retorno (funções públicas)
'============================================
Public Function SearchItem(ByVal vgColumn As String, vgSearch As String) As Boolean
   Dim Pos As Long, RetVal As Boolean
   Dim i As Long
   Dim vgNumSearch As String
   vgEProcura = True
   
   Pos = -1
   If UBound(vgItens) Then                        'se tem itens, é lista interna
      For i = 1 To vgNumItems
         If UCase$(Left$(vgItens(i), Len(vgSearch$))) = UCase$(vgSearch) Then
            Pos = i - 1
            Exit For
         End If
      Next
      GoSub Selecionar
   End If
   
   Select Case vgTabela.Table.Columns(vgColumn).ColumnType
      Case TP_NUMERICO
         vgNumSearch = txtCampo.FormatField(vgSearch, vgColumns(vgColumn).Mask, vgColumns(vgColumn).ColumnType, "")
         vgNumSearch = Retira(vgNumSearch, ".", UM_A_UM)
         vgNumSearch = Substitui(vgNumSearch, ",", ".", UM_A_UM)
         RecordSet.Find PoeColchetes(vgColumn) + " >= " + vgNumSearch + " And " + PoeColchetes(vgColumn) + " < " + CStr(Int(vgSearch) + 1)
         Pos = -1
         If Not RecordSet.NoMatch Then            'se encontrou
            Pos = RecordSet.AbsolutePosition - 1  'vamos pegar a posição do registro
         End If
         RecordSet.Find PoeColchetes(vgColumn) + " = " + vgNumSearch
         If Not RecordSet.NoMatch Then
            Pos = RecordSet.AbsolutePosition - 1  'vamos pegar a posição do registro
         Else
            i = 1
            Do While i <= (vgTabela.Table.Columns(vgColumn).Size - vgTabela.Table.Columns(vgColumn).QDecimal)
               RecordSet.Find PoeColchetes(vgColumn) + " >= " + vgNumSearch + " And " + PoeColchetes(vgColumn) + " < " + CStr(Int(Val(vgNumSearch)) + (10 ^ (i - 1)))
               If Not RecordSet.NoMatch Then
                  Pos = RecordSet.AbsolutePosition - 1
                  Exit Do
               End If
               vgNumSearch = Val(vgNumSearch) * 10
               i = i + 1
            Loop
         End If
      Case Else
         If vgUltColProcura <> vgColumn Or UCase$(Left$(vgUltProcura, Len(vgSearch))) <> UCase(vgSearch) Or Len(vgUltProcura) > Len(vgSearch) Then
            Pos = -1
            If vgInternalLst Then
               For i = 1 To vgNumItems
                  If UCase$(Left$(vgItens(i), Len(vgSearch$))) = UCase$(vgSearch) Then
                     Pos = i - 1
                     Exit For
                  End If
               Next
            Else
               If vgSearch <> "*" Then            'se não tiver apenas colocado o curinga para início da busca
                  RecordSet.SeekRecord vgColumn, "Like", vgSearch + "*"
                  If Not RecordSet.NoMatch Then
                     If UCase(Left(CStr(TiraAcentos(RecordSet.Fields(vgColumn).Value & "")), Len(vgSearch))) = UCase(TiraAcentos(vgSearch)) Then
                        Pos = RecordSet.AbsolutePosition - 1
                     Else
                        i = 1
                        Do While i < vgTabela.Table.Columns(vgColumn).Size
                           vgSearch = vgSearch + "0"
                           RecordSet.SeekRecord vgColumn, ">=", vgSearch
                           If Not RecordSet.NoMatch Then
                              If UCase(Left(CStr(TiraAcentos(RecordSet.Fields(vgColumn).Value & "")), Len(vgSearch) - i)) = UCase(TiraAcentos(Left$(vgSearch, Len(vgSearch) - i))) Then
                                 Pos = RecordSet.AbsolutePosition - 1
                                 vgSearch = Left$(vgSearch, Len(vgSearch) - i)
                                 Exit Do
                              End If
                           End If
                           i = i + 1
                        Loop
                     End If
                  End If
               End If
            End If
         Else
            RetVal = True
         End If
   End Select

Selecionar:
   If Pos >= 0 Then
      vgUltColProcura = vgColumn
      vgUltProcura = vgSearch
      ItemSelect Pos, False
      RetVal = True
   Else
      RetVal = False
      vgUltColProcura = ""
      vgUltProcura = ""
      If Not txtCampoFilter(vgColAtual).AllowAnyText Then vgSearch = ""
   End If
   
   vgEProcura = False
   SearchItem = RetVal
End Function

Public Function GetColumnValues(ByVal Row As Long) As Variant()
   GetColumnValues = GetRsCols(Row)
End Function

'==============================================
'Métodos do listview (internos)
'==============================================

Private Function GetRsCols(Optional ByVal vgRow As Long = -1, Optional ByVal GetDefault As Boolean = True) As Variant()
   Dim Cols() As Variant, ItemStatus As Integer, i As Integer
   If vgRow = -1 Then vgRow = SelectedItem
   If vgRow = SelectedItem And Status(vgRow) = ACAO_NAVEGANDO Then
      Cols = GetOriginalCols
   Else
      ReDim Cols(vgColumns.Count) As Variant
      If vgInternalLst Or vgUboundMode Then
         For i = 1 To vgColumns.Count
            Cols(i) = GetColumnRs(vgRow, i, GetDefault)
         Next
      Else
         ItemStatus = Status(vgRow)
         If ItemStatus = ACAO_EDITANDO Or ItemStatus = ACAO_INCLUINDO Then
            For i = 1 To vgColumns.Count
               Cols(i) = vgColDefinitions(i).NewValue
            Next
         Else
            Call LocateRecordset(vgRow, False)                       'posiciona recordset no item requerido
            For i = 1 To vgColumns.Count
               If Not vgTabela.EOF And Not vgTabela.BOF And (Len(vgColumns(i).NameFilter) > 0 Or Len(vgColDefinitions(i).ComboFieldsList) > 0) Then
                  Cols(i) = vgTabela.Field(vgColumns(i).Name).Value  'pega valor original do rs
               End If
            Next
         End If
      End If
   End If
   GetRsCols = Cols
End Function

Private Function GetRsColsDirect() As Variant()
   Dim Cols() As Variant, ItemStatus As Integer, i As Integer
   ReDim Cols(vgColumns.Count) As Variant
   For i = 1 To vgColumns.Count
      If Not vgTabela.EOF And Not vgTabela.BOF And (Len(vgColumns(i).NameFilter) > 0 Or Len(vgColDefinitions(i).ComboFieldsList) > 0) Then
         Cols(i) = vgTabela.Field(vgColumns(i).Name).Value       'pega valor original do rs
      End If
   Next
   GetRsColsDirect = Cols
End Function

Private Function GetNewCols() As Variant()
   Dim Cols() As Variant, i As Integer
   ReDim Cols(vgColumns.Count) As Variant
   For i = 1 To vgColumns.Count
      Cols(i) = vgColDefinitions(i).NewValue
   Next
   GetNewCols = Cols
End Function

'pega colunas a partir do vetor...
Private Function GetOriginalCols() As Variant()
   Dim Cols() As Variant, i As Integer
   ReDim Cols(vgColumns.Count) As Variant
   For i = 1 To vgColumns.Count
      Cols(i) = vgColDefinitions(i).OriginalValue
   Next
   GetOriginalCols = Cols
End Function

'Selecionou um item da lista, prepara vetor de colunas e dispara o evento
Private Sub ItemSelect(ByVal vgRow As Long, ByVal vgForceEvent As Boolean)
   Dim vgChanged As Boolean
   If vgRow > vgNumItemsTot - 1 Then Exit Sub
   If Not vgEProcura Then
      vgUltProcura = ""
      vgUltColProcura = ""
   End If
   vgForcePosSel = True                                 'vamos forçar reposicionamento da picSel e também a redefinição do txtCampo (Força chamada para DefineCampo)
   vgChanged = (vgRow <> SelectedItem)
   SelecionaItem vgRow
   If vgLastSkipRec > 0 And vgLastSkipRec <> vgRow Then 'só vamos forçar esse locate para que um skiprecord seja disparado
      LocateRecordset vgRow, True                       'quando usuário estiver nagegando entre os registros do grid com o teclado
   End If
   If vgChanged Or vgForceEvent Then
      RaiseEvent ItemSelect(vgRow, GetOriginalCols())
   End If
End Sub

'Selecionou um item da lista, prepara vetor de colunas e dispara o evento
Private Sub ItemClick(ByVal vgRow As Long)
   If Not vgEProcura Then
      vgUltProcura = ""
      vgUltColProcura = ""
   End If
   If vgRow <> SelectedItem Then
      ItemSelect vgRow, False
   End If
   RaiseEvent ItemClick(vgRow, GetOriginalCols())
End Sub

Private Sub SetEnabled()
   If UserControl.Enabled <> vgEnabled Then
      EnableWindow hWndLst, vgEnabled
      UserControl.Enabled = vgEnabled
      Refresh
   End If
End Sub

Private Sub SetStyle()
   Dim vgStyle As Long, Rc As RECT, WP As WINDOWPOS

   vgStyle = vgStyle Or LVS_EX_LABELTIP Or WS_EX_CLIENTEDGE
   Call SendMessageLong(hWndLst, LVM_SETEXTENDEDLISTVIEWSTYLE, 0, vgStyle)

   SendMessageLong hWndLst, LVM_SETBKCOLOR, 0, SysColor(vgBackColor)
   SendMessageLong hWndLst, LVM_SETTEXTBKCOLOR, 0, SysColor(vgCellBackColor)

   'envia uma WM_WINDOWPOSCHANGED para que a WM_MEASUREITEM seja chamada
   GetWindowRect hWndLst, Rc
   WP.hWnd = hWndLst
   WP.cx = Rc.Right - Rc.Left
   WP.cy = Rc.Bottom - Rc.Top
   WP.Flags = SWP_NOACTIVATE Or SWP_NOMOVE Or SWP_NOOWNERZORDER Or SWP_NOZORDER
   SendMessage hWndLst, WM_WINDOWPOSCHANGED, 0, WP

   picHeader.Visible = Not vgHideHeader Or vgShowGridCaption
   picStatus.Visible = Not vgHideStatus Or vgShowSumBar Or vgShowMaxBar Or vgShowMinBar Or vgShowAvgBar
   picBarra.Visible = Not vgHideLeftBar
   picFilter.Visible = vgShowFilterBar
   picTop.Visible = Not vgHideStatus And vgShowTopField

   picSel.ForeColor = vgCellBackColor

   SetEnabled

   UserControl_Resize

   AdjustFilterBar

   Call Refresh
   
End Sub

'cria o controle ListView
'Os estilos Report, ShowAlwalys e SingleSel realmente serão fixados pela criação
'Não será possível alterá-los por propriedade
Private Sub Create()
   Dim initcc As InitCommonControlsExType, dwStyle As Long, dwStyleEx As Long, vgNVez As Long
   
   On Error Resume Next
   dwStyle = (WS_TABSTOP Or WS_CHILD Or WS_VISIBLE Or LVS_REPORT Or LVS_SHOWSELALWAYS Or LVS_SINGLESEL Or LVS_OWNERDATA Or LVS_OWNERDRAWFIXED Or LVS_NOCOLUMNHEADER)
   dwStyleEx = 0
   vgNVez = 0
   
OutraVez:
   hWndLst = CreateWindowEx(dwStyleEx, "SysListView32", "GVirtListView", dwStyle, 0, 0, 100, 100, hWnd, 5, App.hInstance, 0)
   
   'se o VB não inicializou a COMCTL ainda, vamos iniciar...
   If hWndLst = 0 And vgNVez = 0 Then
      initcc.dwSize = Len(initcc)
      initcc.dwICC = ICC_LISTVIEW_CLASSES
      InitCommonControlsEx initcc
      vgNVez = vgNVez + 1
      GoTo OutraVez
   End If
   
   vgHwndHeader = SendMessageLong(hWndLst, LVM_GETHEADER, 0, 0)
   Call SetStyle
End Sub

Private Sub Initiate()
   Dim ulvc As LVCOLUMN, F As Object
   If Not VBDesignMode Then
      Set F = UserControl.Parent
      Do While Not F Is Nothing
         If TypeOf F Is Form Then
            Set vgFormParent = F
            Set F = Nothing
         Else
            Set F = UserControl.Parent
         End If
      Loop
      Set F = Nothing
      Set vgSubClass = New GSubClass
      Call ChangeCallBackControl
      Call ChangeCallBackLista
   Else
      picHeader.Visible = False
      picBarra.Visible = False
      picFilter.Visible = False
      With ulvc                                         'cria coluna temporárias
         .pszText = UserControl.Extender.Name
         .cchTextMax = Len(UserControl.Extender.Name)
         .Mask = LVCF_FMT Or LVCF_TEXT Or LVCF_WIDTH
         .cx = 100
         SendMessageAPI hWndLst, LVM_INSERTCOLUMN, 0, ulvc
      End With
      vgNumItemsTot = 5
      SendMessageLong hWndLst, LVM_SETITEMCOUNT, vgNumItemsTot, 0
   End If
   ReDim vgColDefinitions(0) As GRD_ColumnDefinition
   ReDim vgIgnoredFocusControls(0) As Long
   Set txtCampo = New FormataCampos
   Set txtCampo.CtPri = txtEdit
   Set vgTabela = New GRecordSet
   ReDim txtCampoFilter(0) As FormataCampos
   Set txtEdit.Font = UserControl.Font
   Set txtEditMult.Font = UserControl.Font
   Set picEdit.Font = UserControl.Font
   If vgFont Then DeleteObject vgFont
   vgFont = MakeFont(txtEdit.Font.Size, txtEdit.Font.Weight, txtEdit.Font.Italic, txtEdit.Font.Underline, txtEdit.Font.Strikethrough, txtEdit.Font.Name)
   txtEdit.Visible = False
   txtEditMult.Visible = False
   picEdit.Visible = False
   UserControl.BackColor = vbButtonFace
   txtFilter(0).BackColor = vbWindowBackground
   picFilter.BackColor = vgEditBackColor
   picFilter.ForeColor = vgEditTextColor
   picFilter.BackColor = vbWindowBackground
   txtTop.BackColor = vbWindowBackground
   vgFilterBarHeight = picFilter.TextHeight("X") + 5 * vgTpY
   Call GetShiftKeys                                    'vamos fazer a chamada uma vez, não sei pq mas a sempre na primeira chamada GetAsyncKeyState para CTRL vem setada! :-D

   If Not VBDesignMode Then
      'opções de visualização definidas pelo menu
      M_Option(0).Caption = LoadGasString(1813)
      M_Option(2).Caption = LoadGasString(1800)
      M_Option(3).Caption = LoadGasString(1801)
      M_Option(5).Caption = LoadGasString(1802)
      M_Option(6).Caption = LoadGasString(1803)
      M_Option(7).Caption = LoadGasString(1804)
      M_Option(8).Caption = LoadGasString(1805)
      M_Option(10).Caption = LoadGasString(1814)
      
      'sub-menu de opções especiais
      M_Special(0).Caption = LoadGasString(1815)
      M_Special(2).Caption = LoadGasString(1816)
      M_Special(3).Caption = LoadGasString(1817)
      M_Special(4).Caption = LoadGasString(1818)
      M_Special(6).Caption = LoadGasString(1819)
      
      'opções de visualização definidas pelo menu da coluna
      M_ColOption(0).Caption = LoadGasString(1806)
      M_ColOption(1).Caption = LoadGasString(1807)
      M_ColOption(2).Caption = LoadGasString(1808)
      M_ColOption(3).Caption = LoadGasString(1809)
      M_ColOption(5).Caption = LoadGasString(1810)
      M_ColOption(6).Caption = LoadGasString(1811)
   End If

   'mostra lista e esconde fundo
   ShowWindow hWndLst, SW_SHOW
   picFundo.Visible = False

End Sub

Public Sub Finalize()
   Dim i As Integer
   On Error Resume Next
   Call EndEditGrid(False, True)
   For i = 1 To UBound(txtCampoFilter)
      txtCampoFilter(i).Finalize
      Set txtCampoFilter(i) = Nothing
   Next
   For i = 0 To UBound(vgColDefinitions)
      vgColDefinitions(i).txtCampo.Finalize
      Set vgColDefinitions(i).txtCampo = Nothing
      vgColDefinitions(i).txtCampoGrd.Finalize
      Set vgColDefinitions(i).txtCampoGrd = Nothing
   Next
   txtCampo.Finalize
   Set txtCampo = Nothing
   Unload bottxtCampo(BOT_ACAO)
   Unload bottxtCampo(BOT_LISTA)
   Unload bottxtCampo(BOT_COMBO)
   ReDim vgCacheTable(0, 0, 0) As Variant
   ReDim vgItens(0) As String
   ReDim vgIgnoredFocusControls(0) As Long
   ReDim vgColDefinitions(0) As GRD_ColumnDefinition
   ReDim txtCampoFilter(0) As FormataCampos
End Sub

'==============================================
'Funções do listview (internas)
'==============================================
Private Function TiraAcentos(St As String) As String
   Dim x As String, RetVal As String, z As String
   x$ = Chr$(192) + Chr$(193) + Chr$(194) + Chr$(195) + Chr$(196) + Chr$(199) + Chr$(199) + Chr$(200) + Chr$(201) + Chr$(202) + Chr$(202) + Chr$(203) + Chr$(204) + Chr$(205) + Chr$(206) + Chr$(206) + Chr$(207) + Chr$(210) + Chr$(211) + Chr$(212) + Chr$(213) + Chr$(214) + Chr$(217) + Chr$(218) + Chr$(219)
   x$ = x$ + Chr$(219) + Chr$(220) + Chr$(224) + Chr$(225) + Chr$(226) + Chr$(227) + Chr$(228) + Chr$(231) + Chr$(232) + Chr$(233) + Chr$(234) + Chr$(234) + Chr$(235) + Chr$(236) + Chr$(237) + Chr$(238) + Chr$(238) + Chr$(239) + Chr$(242) + Chr$(243) + Chr$(244) + Chr$(245) + Chr$(246) + Chr$(249) + Chr$(250) + Chr$(251) + Chr$(251) + Chr$(252)
   z$ = "aaaaacceeeeeiiiiioooooyuuuuaaaaaceeeeeiiiiiooooouuuuu"
   RetVal$ = Substitui(St$, x$, z$, UM_A_UM)
   TiraAcentos$ = RetVal$
End Function

'ordenar um arranjo utilizando quick sort
Private Sub OrdenaVetor(ByRef Vetor As Variant, vgPriIndice As Long, vgUltIndice As Long)
   Dim vgPriTemp As Long, vgUltTemp As Long, vgParamTemp As Long, vgNovoParam As String
   vgPriTemp = vgPriIndice
   vgUltTemp = vgUltIndice
   vgParamTemp = Val(Vetor((vgPriIndice + vgUltIndice) / 2))
   While (vgPriTemp <= vgUltTemp)
      While (Val(Vetor(vgPriTemp)) < vgParamTemp And vgPriTemp < vgUltIndice)
         vgPriTemp = vgPriTemp + 1
      Wend
      While (vgParamTemp < Val(Vetor(vgUltTemp)) And vgUltTemp > vgPriIndice)
         vgUltTemp = vgUltTemp - 1
      Wend
      If (vgPriTemp <= vgUltTemp) Then
         vgNovoParam$ = Vetor(vgPriTemp)
         Vetor(vgPriTemp) = Vetor(vgUltTemp)
         Vetor(vgUltTemp) = vgNovoParam$
         vgPriTemp = vgPriTemp + 1
         vgUltTemp = vgUltTemp - 1
      End If
   Wend
   If (vgPriIndice < vgUltTemp) Then
      OrdenaVetor Vetor, vgPriIndice, vgUltTemp
   End If
   If (vgPriTemp < vgUltIndice) Then
      OrdenaVetor Vetor, vgPriTemp, vgUltIndice
   End If
End Sub

'ordenar um arranjo utilizando quick sort
Private Sub OrdenaVetorDesc(ByRef Vetor As Variant, vgPriIndice As Long, vgUltIndice As Long)
   Dim vgPriTemp As Long, vgUltTemp As Long, vgParamTemp As Long, vgNovoParam As String
   vgPriTemp = vgPriIndice
   vgUltTemp = vgUltIndice
   vgParamTemp = Val(Vetor((vgPriIndice + vgUltIndice) / 2))
   While (vgPriTemp <= vgUltTemp)
      While (Val(Vetor(vgPriTemp)) > vgParamTemp And vgPriTemp < vgUltIndice)
         vgPriTemp = vgPriTemp + 1
      Wend
      While (vgParamTemp > Val(Vetor(vgUltTemp)) And vgUltTemp > vgPriIndice)
         vgUltTemp = vgUltTemp - 1
      Wend
      If (vgPriTemp <= vgUltTemp) Then
         vgNovoParam$ = Vetor(vgPriTemp)
         Vetor(vgPriTemp) = Vetor(vgUltTemp)
         Vetor(vgUltTemp) = vgNovoParam$
         vgPriTemp = vgPriTemp + 1
         vgUltTemp = vgUltTemp - 1
      End If
   Wend
   If (vgPriIndice < vgUltTemp) Then
      OrdenaVetorDesc Vetor, vgPriIndice, vgUltTemp
   End If
   If (vgPriTemp < vgUltIndice) Then
      OrdenaVetorDesc Vetor, vgPriTemp, vgUltIndice
   End If
End Sub

Private Sub ResetBookMark()
   vgUltBkSelect = -1
   vgBkSelect = ""
   vgRecPosAtual = -1
   vgCacheFirst = -1
   vgBkVirtual = ""
   vgLastSkipRec = -2
End Sub

'CUIDADO: ROTINA MANUAL
'PROPOSITO: QUANDO O FORM TEM MAIS DE UM GRID AO EXCLUIR O REGISTRO PAI OS GRIDS NW PASSAVAM PELA FORMULA INVERSA SOMENTE O PRIMEIRO GRID
Private Sub DeleteRows(Optional ByVal vgDeleteAllRecords As Boolean = False, Optional ByVal vgChangeStatus As Boolean = True)
   Dim vgRowsSelectedOrig As String, i As Long, j As Long, vgDeleteBookmark() As Variant, vgDeleteList() As String, vgRow As Long, vgDeleted As Boolean, vgMessage As String, vgNumDeleted As Long, x As String, vgIniciouTrans As Boolean, vgTot As Long, vgColunas() As Variant, vgErr As Long, vgOrigCount As Long
   On Error GoTo DeuErro
   
   If Len(vgRowsSelected$) = 0 And Not vgDeleteAllRecords Then Exit Sub
   
   FreezeListView True
   
   vgNumDeleted = 0
   vgRowsSelectedOrig$ = vgRowsSelected$
   
   If vgAllowDelete And (vgInternalLst Or vgAllowDeleteDatabase) And (vgDeleteAllRecords Or Len(vgRowsSelected) > 0) Then                    'se tem permissão de apagar registros...
      If Not vgDeleteAllRecords Then
         i = Tally(vgRowsSelected, "|") - 1
         If i = 1 Then
            x = LoadGasString(150)
         Else
            x = Substitui$(LoadGasString(151), "{1}", CStr(i), SO_UM)
         End If
         If MsgBox(x, vbQuestion + vbYesNo) = vbNo Then
            RestoreListView True
            UserControl.SetFocus
            Exit Sub
         End If
         vgRowsSelected = Mid(vgRowsSelected, 2)
      End If
      i = 0
      If vgDeleteAllRecords Then
         vgTot = vgNumItems
      Else
         ReDim vgDeleteList(0) As String
         Do While Len(vgRowsSelected) > 0
            i = i + 1
            vgRow = Parse(vgRowsSelected, "|")
            ReDim Preserve vgDeleteList(i) As String
            vgDeleteList(i) = vgRow
         Loop
         OrdenaVetor vgDeleteList, 1, CLng(i)
         vgTot = UBound(vgDeleteList)
      End If
      
      'força retirar seleção e forçca skiprecord obrigando os grids "netos" terem seus recordsets fechados antes do inídio dessa transação
      ResetBookMark
      SelecionaItem -1
      ResetBookMark
      LocateRecordset -1, True
      
      'vamos atualizar o status para excluindo pois a afterbegin de um grid (f9) precisa fechar os recordsets filhos
      If vgChangeStatus Then
         RaiseEvent StatusChanged(ACAO_EXCLUINDO)
      End If
      
      vgDb.BeginTrans
      vgIniciouTrans = True
      
      vgOrigCount = vgNumItems                    'vamos guardar o número de itens originais
      
      'INICIO MANUAL
      'ISSO JA FOI FEITO ANTERIORMENTE, MAS O RECORDSET NW TAVA ATUALIZADO
      'ENTAO PRECISEI COLOCAR ESSA LINHA LOGO APÓS O vgdb.BeginTrans, POIS ELE ATUALIZA O RECORDSET
      If vgDeleteAllRecords Then
         vgTot = vgNumItems 'AHHHH GAS DE MERD.....
      End If
      'FIM MANUAL
      
      For i = vgTot To 1 Step -1
         If vgDeleteAllRecords Then
            vgRow = i - 1
         Else
            vgRow = Val(vgDeleteList(i))
         End If
         vgDeleted = False
         
         ResetBookMark
         
         SelecionaItem vgRow
         
         If vgChangeStatus Then
            RaiseEvent StatusChanged(ACAO_EXCLUINDO)
         End If
         
         ClearColumnDefinition
         vgColunas = GetOriginalCols()            'pega colunas diretamente do rs, sem tentar pegar de cache... (pega do bookmark corrente)
         
         If Not vgUboundMode And Not vgManualDelete Then 'vamos fazer a deleção por aqui mesmo
            vgDeleted = True
            vgMessage = ""
            RaiseEvent BeforeDeleteRecord(vgRow, vgColunas, vgDeleted, 0, vgMessage)
            If vgDeleted Then                            'ocorreu algum erro...
               vgTabela.Delete
               vgDeleted = True
               vgMessage = ""
               RaiseEvent AfterDeleteRecord(vgRow, vgColunas, vgDeleted, 0, vgMessage)
            End If
         Else
            RaiseEvent DeleteData(vgRow, vgColunas, vgDeleted, vgMessage)
         End If
         If vgDeleted Then
            If Not vgDeleteAllRecords Then vgDeleteList(i) = ""
            vgNumDeleted = vgNumDeleted + 1
            SetItemCount vgOrigCount - vgNumDeleted
         Else
            If Len(vgMessage$) > 0 Then Error 3801
            If Len(vgRowsSelected) = 0 Then vgRowsSelected = "|"
            vgRowsSelected = vgRowsSelected + CStr(vgRow) + "|"
         End If
      Next
      
      'vamos atualizar novamente o status para excluindo, a DeleteData pode ter tirado o status, a a beforecommit de um grid (f9) precisará fechar os recordsets filhos
      If vgChangeStatus Then
         RaiseEvent StatusChanged(ACAO_EXCLUINDO)
      End If
      
      vgDb.CommitTrans
      If vgTabela.AsyncComplete Then FillScalarValues    'vamos atualizar os totais
      vgIniciouTrans = False
   End If
   
   'vamos zerar controle de bookmark
   Call ResetBookMark
      
   If vgChangeStatus Then
      RaiseEvent StatusChanged(ACAO_NAVEGANDO)
   End If
   
   If vgNumDeleted > 0 Then
      ReBind
      SelecionaItem 0
      PosicionaSelect
      FillScalarValues                                   'atualiza os valores das barras de somatório, média, mínimo e máximo
   End If
   
   If vgChangeStatus Then
      Call RefreshStatus
   End If
   
   RestoreListView True
   
   Exit Sub

DeuErro:
   vgDeleted = False
   If Err Or Len(vgMessage$) > 0 Then
      vgErr = Err
      If InStr(vgMessage$, "|") > 0 Then
         CErr.Mensagem = LoadGasString(3801)
         CErr.Origem = Parse$(vgMessage$, "|")
         CErr.NumErro = Val(vgMessage$)                  'deu erro
         CErr.Description = Trim$(Mid$(vgMessage$, InStr(vgMessage$, "-") + 1))
      Else
         CErr.NumErro = 3801
         If Len(vgMessage$) > 0 Then
            CErr.Description = vgMessage$
         ElseIf Err = 3600 Then
            CErr.Description = LoadGasString(54)
         Else
            CErr.Description = CStr(Err) + " - " + Error$
         End If
      End If
      CErr.Show
   End If
   If vgErr Then
      Resume ResumeErro
   Else
      GoTo ResumeErro
   End If
   
RollBackAll:
   On Error Resume Next
   If vgIniciouTrans Then
      SetItemCount vgOrigCount                           'restaura número de itens original

      'força retirar seleção e força skiprecord obrigando os grids "netos" terem seus recordsets fechados antes do fim dessa transação
      ResetBookMark
      SelecionaItem -1
      ResetBookMark
      LocateRecordset -1, True
      
      vgDb.RollBackTrans
      vgTabela.CancelUpdate
      vgIniciouTrans = False
      ResetBookMark
   End If
   Return
   
ResumeErro:
   GoSub RollBackAll
   vgRowsSelected$ = vgRowsSelectedOrig$
   If vgChangeStatus Then
      RaiseEvent StatusChanged(ACAO_NAVEGANDO)
   End If
   ReBind
   Refresh
   Call RefreshStatus
   Err.Clear
   RestoreListView True
End Sub

Public Sub DeleteCols()
   Dim j As Long
   On Error GoTo DeuErro
   If Len(vgColsSelected) > 0 Then
      FreezeListView True
      vgColsSelected$ = Mid$(vgColsSelected$, 2)
      Do While Len(vgColsSelected$) > 0
         j = Val(Parse$(vgColsSelected$, "|"))
         ColumnWidth(j) = 0
      Loop
      RestoreListView True
      DrawBars
   End If
   
   Exit Sub
   
DeuErro:
   RestoreListView True
   Refresh
   
End Sub

'vamos processar a gravação dos dados na base
Private Sub SaveChangedData(ByRef vgSaved As Boolean, ByRef vgColumn As Integer, ByRef vgMessage As String, ByRef vgRefresh As Boolean)
   Dim i As Integer, vgRow As Long, vgAdded As Boolean, vgIniciouTrans As Boolean, vgOk As Boolean, vgValue As Variant, vgUpdate As Boolean
   On Error GoTo DeuErro
   vgAdded = False
   vgRow = SelectedItem
   If Not vgManualUpdate Then                                   'vamos fazer a gravação por aqui mesmo
      vgDb.BeginTrans                                           'inicia transação
      vgIniciouTrans = True                                     'para saber que a transação começou
      If Not vgAllowInsert Or Not (vgInternalLst Or vgAllowInsertDatabase) Or vgRow <> vgNumItemsTot - 1 Then 'se tem inclusão, o último item é uma linha em branco...
         vgColumn = -1
         vgMessage = ""
         vgOk = True
         LocateRecordset vgRow, False
         RaiseEvent BeforeEditRecord(vgRow, GetOriginalCols(), vgOk, vgColumn, vgMessage)
         If Not vgOk Then                         'ocorreu algum erro...
            GoTo DeuErro
         End If
         LocateRecordset vgRow, False
         vgTabela.Edit
      Else
         vgTabela.AddNew
         vgAdded = True
      End If
      For i = 1 To vgColumns.Count
         vgUpdate = vgColDefinitions(i).Changed
         
           'Inicio Manual
            If GetColumnRs(vgRow, i) <> vgColDefinitions(i).NewValue And (vgColumns(i).NameFilter = "Data de vencimento" Or vgColumns(i).NameFilter = "Dias") Then
               vgUpdate = True
            End If
           'Fim Manual
      
         If Not vgUpdate Then
            vgValue = vgColDefinitions(i).NewValue
            If IsEmpty(vgValue) Then
               vgValue = GetColumnRs(vgRow, i, True)
            ElseIf vgValue & "" <> vgColDefinitions(i).OriginalValue & "" And Not IsEmpty(vgColDefinitions(i).OriginalValue) Then
               vgValue = GetColumnRs(vgRow, i, True)
            End If
            vgUpdate = (vgValue & "" <> vgColDefinitions(i).OriginalValue & "")
         Else
            vgValue = GetColumnRs(vgRow, i)
         End If
         If vgUpdate Then                         'tem alteração ou tem valor inicial
            vgTabela.Field(vgColumns(i).Name).Value = vgValue
         End If
      Next
      vgColumn = -1
      vgMessage = ""
      vgOk = True
      RaiseEvent BeforeUpdateRecord(vgRow, GetNewCols(), vgOk, vgColumn, vgMessage)
      If Not vgOk Then                            'ocorreu algum erro...
         GoTo DeuErro
      End If
      vgTabela.Update
      vgColumn = -1
      vgMessage = ""
      vgOk = True
      RaiseEvent AfterUpdateRecord(vgRow, GetNewCols(), vgOk, vgColumn, vgMessage)
      If Not vgOk Then                            'ocorreu algum erro...
         GoTo DeuErro
      End If
      vgSaved = True
      vgDb.CommitTrans
      vgIniciouTrans = False
      FillScalarValues                            'vamos atualizar os totais
   Else
      vgAdded = vgAllowInsert And vgAllowInsertDatabase And (vgRow = vgNumItemsTot - 1)
      RaiseEvent SaveData(vgRow, GetNewCols(), vgSaved, vgColumn, vgMessage)
   End If
   If vgSaved Then
      vgHasChanged = False
      vgIsPreEditing = True
      vgForcePosSel = True
      vgPriVez = vgPriVez + 1
      Call RefreshStatus
      vgPriVez = vgPriVez - 1
      If vgAdded Then
         SetItemCount vgTabela.RecordCount
      End If
      ClearColumnDefinition
      If vgTabela.AsyncComplete Then FillScalarValues 'atualiza os valores das barras de somatório, média, mínimo, máximo
      DrawBars
   End If
   
   Exit Sub

DeuErro:
   vgSaved = False
   If Err Then
      vgRefresh = (Err = -2147217864)
      CErr.NumErro = Err
      vgMessage = Err.Description
      Resume ResumeErro
   Else
      GoTo ResumeErro
   End If
   
ResumeErro:
   On Error Resume Next
   vgTabela.CancelUpdate
   If vgIniciouTrans Then
      vgDb.RollBackTrans
   End If
   vgTabela.Requery
   Err.Clear
End Sub
Private Function CalculaPosicao(ByVal vgRow As Long, ByVal vgPosAtual As Long) As Long
   Dim vgMove As Long, vgRetVal As Long
   vgMove = (vgRow - vgPosAtual)                                    'calcula diferença
   If vgRow <> vgPosAtual Then
      If vgMove <> 0 Then
         If vgMove = 1 And Not vgTabela.EOF Then                    'está solicitando o próximo registro
            vgRetVal = 1
         ElseIf vgMove = -1 And Not vgTabela.BOF Then               'está solicitando o registro anterior
            vgRetVal = 1
         ElseIf vgRow = 0 Then                                      'está solicitando o primeiro registro
            vgRetVal = 0
         ElseIf vgRow + 1 = vgNumItems Then                         'está solicitando o último registro
            vgRetVal = 0
         ElseIf Abs(vgMove) < ((vgRow + 1) - vgNumItems) Then       'se a diferença for menor que o próprio item solicitado... (quer dizer que é melhor mover a partir do item atual do que mover a partir do último)
            vgRetVal = vgMove
         ElseIf (vgNumItems - (vgRow + 1)) < vgRow + 1 And (vgNumItems - (vgRow + 1)) < Abs(vgMove) Then 'se está mais próximo do último registro que do primeiro
            vgRetVal = ((vgRow + 1) - vgNumItems)
         ElseIf Abs(vgMove) < vgRow Then          'se a diferença for menor que o próprio item solicitado... (quer dizer que é melhor mover a partir do item atual do que mover a partir do primeiro)
            vgRetVal = vgMove
         Else                                     'está mais próximo do primeiro registro
            vgRetVal = vgRow
         End If
      End If
   ElseIf (vgTabela.EOF Or vgTabela.BOF) And vgTabela.RecordCount > 0 Then 'recordset está desposicionado (ERRO), vamos reposicionar
      If vgMove = 1 Then                          'se é o primeiro item
         vgRetVal = 0
      ElseIf vgRow + 1 = vgNumItems Then          'se é o último item
         vgRetVal = 0
      ElseIf (vgNumItems - (vgRow + 1)) < vgRow + 1 Then 'se está mais próximo do último registro que do primeiro
         vgRetVal = ((vgRow + 1) - vgNumItems)
      Else                                               'está mais próximo do primeiro registro
         vgRetVal = vgRow
      End If
   Else
      vgRetVal = 0
   End If
   CalculaPosicao = vgRetVal
End Function

'pega valor da coluna correspondente no recordset
'ROTINA MANUAL
'Proposito: Valor Inicial no Grid de Parcelamento
Private Function GetColumnRs(ByVal vgRow As Long, ByVal vgColumn As Variant, Optional ByVal GetDefault As Boolean = True) As Variant
   Dim RetVal As Variant, vgCol As Integer, ItemStatus As Integer, NewItem As Boolean, vgItemCache As Long, vgHasCache As Boolean
   
   vgCol = Val(vgColumns(vgColumn).Index)
   vgInternalLst = UBound(vgItens)                'se tem itens, é lista interna
   
   If Not vgInternalLst Then
      
      'usuário quer Cache... vamos prepara tabela
      If vgCacheSize <> 0 Then                    'tem controle de cache
         PrepareCacheTable vgRow
         vgItemCache = GetCachePosition(vgRow)
         If Status = ACAO_NAVEGANDO Or vgRow <> SelectedItem Then
            vgHasCache = (InStr(vgCacheTable(vgItemCache, ITEM_CACHE_VALUE, 0), "|" + CStr(vgCol) + "|") > 0)
         Else
            vgHasCache = False
         End If
      Else
         vgHasCache = False
      End If
   
      'flag que indica se está na linha de novo item
      NewItem = (vgAllowInsert And (Not vgInternalLst Or vgAllowInsertDatabase) And vgRow = vgNumItemsTot - 1)
      
      If vgHasCache Then
         RetVal = vgCacheTable(vgItemCache, ITEM_CACHE_VALUE, vgCol)
      ElseIf vgRow <> -1 Then
         ItemStatus = Status(vgRow)
         Call LocateRecordset(vgRow, False)       'posiciona recordset no item requerido
         If ItemStatus = ACAO_EDITANDO Or ItemStatus = ACAO_INCLUINDO Then
            If GetDefault And Len(vgColumns(vgCol).NameFilter) > 0 And Not vgColDefinitions(vgCol).Changed Then 'se se quer pegar valor default e é campo
               If Vazio(vgColDefinitions(vgCol).NewValue) Then
                  GetGridColumnLockedEnabled vgRow, vgCol, 0, 0
                  If (Not vgColDefinitions(vgCol).Locked And Not vgColDefinitions(vgCol).TemporaryLocked) Or vgTabela.Table.Columns(vgColumns(vgCol).NameFilter).Sequencia Or ((vgColDefinitions(vgCol).Locked Or vgColDefinitions(vgCol).TemporaryLocked) And vgCol <> vgColAtual) Then
                     RetVal = Null
                     RaiseEvent GetColumnDefaultValue(vgCol, GetNewCols, RetVal)                                'dispara o evento que retorna em DefaultValue o valor inicial da coluna
                     If Not IsNull(RetVal) Then
                        vgColDefinitions(vgCol).NewValue = RetVal
                        vgColDefinitions(vgCol).HasInitialValue = True
                     End If
                  End If
               End If
            End If
            'Antes
            'RetVal = vgColDefinitions(vgCol).NewValue
            'Agora
            'Inicio Manual
            RetVal = Null
            If ItemStatus = ACAO_EDITANDO And (vgColumns(vgCol).NameFilter = "Data de vencimento") And Not vgColDefinitions(vgCol).Changed Then
               RaiseEvent GetColumnDefaultValue(vgCol, GetNewCols, RetVal)                                'dispara o evento que retorna em DefaultValue o valor inicial da coluna
            ElseIf (ItemStatus = ACAO_EDITANDO Or ItemStatus = ACAO_INCLUINDO) And (vgColumns(vgCol).NameFilter = "Dias") And Not vgColDefinitions(vgCol).Changed Then
               RaiseEvent GetColumnDefaultValue(vgCol, GetNewCols, RetVal)                                'dispara o evento que retorna em DefaultValue o valor inicial da coluna
            Else
               RetVal = vgColDefinitions(vgCol).NewValue
            End If
            'Fim Manual
            
         ElseIf Not NewItem Then                  'se não está na linha de novo item
            If Not vgUboundMode Then
               If Not vgTabela.EOF And Not vgTabela.BOF And (Len(vgColumns(vgCol).NameFilter) > 0 Or Len(vgColDefinitions(vgCol).ComboFieldsList) > 0) Then
                  If vgColumns(vgCol).ColumnType <> TP_BINARIO Then
                     RetVal = vgTabela.Fields(vgColumns(vgCol).Name).Value 'pega valor original do rs
                  ElseIf Not IsNull(vgTabela.Fields(vgColumns(vgCol).Name).Value) Then
                     If BlobComBMP(vgColumns(vgCol).Name) Then
                        RetVal = PegaNomeRealBMP(vgColumns(vgCol).Name)
                     Else
                        RetVal = PegaNomeMidia(vgColumns(vgCol).Name)
                     End If
                  End If
               End If
            End If
         End If
         If vgCacheSize <> 0 Then                                          'tem controle de cache
            vgCacheTable(vgItemCache, ITEM_CACHE_VALUE, vgCol) = RetVal
            If InStr(vgCacheTable(vgItemCache, ITEM_CACHE_VALUE, 0), "|" + CStr(vgCol) + "|") = 0 Then
               If Len(vgCacheTable(vgItemCache, ITEM_CACHE_VALUE, 0)) = 0 Then vgCacheTable(vgItemCache, ITEM_CACHE_VALUE, 0) = "|"
               vgCacheTable(vgItemCache, ITEM_CACHE_VALUE, 0) = vgCacheTable(vgItemCache, ITEM_CACHE_VALUE, 0) + CStr(vgCol) + "|"
            End If
         End If
      End If
   Else
      RetVal = vgItens(vgRow + 1)
   End If
   If vgColumns(vgCol).ColumnType = TP_LOGICO Then
      If Len(RetVal & "") = 0 Then RetVal = False
      GetColumnRs = CBool(RetVal)
   ElseIf vgColumns(vgCol).ColumnType = TP_NUMERICO And Not NewItem Then
      If Len(RetVal & "") = 0 Then RetVal = 0
      GetColumnRs = RetVal
   ElseIf Len(vgColDefinitions(vgCol).ComboDataBase) > 0 And Len(vgColDefinitions(vgCol).ComboTable) > 0 Then 'verificando se é combo-box
      If vgTabela.Table.Columns(vgColumns(vgCol).NameFilter).ColumnType = TP_NUMERICO Then                    'se o campo a capturar é do tipo numérico
         If Len(RetVal & "") = 0 Then             'verificamos se foi deixado em branco
            RetVal = 0                            'retornamos zero para evitar erro de tipo
         End If
      End If
      GetColumnRs = RetVal
   Else
      GetColumnRs = RetVal
   End If
End Function


'pega valor da coluna correspondente formatado de acordo com máscara
Private Function GetColumnText(ByVal vgRow As Long, ByVal vgColumn As Variant) As Variant
   Dim RetVal As Variant, vgField As String, i As Integer, vgCol As Integer, vgFilter As String, _
       ItemStatus As Integer, NewItem As Boolean, vgHasCache As Boolean, vgItemCache As Long
   
   vgCol = Val(vgColumns(vgColumn).Index)
   
   'usuário quer Cache... vamos preparar a tabela
   If Not vgInternalLst And vgCacheSize <> 0 Then
      PrepareCacheTable vgRow
      vgItemCache = GetCachePosition(vgRow)
      If Status = ACAO_NAVEGANDO Or vgRow <> SelectedItem Then
         vgHasCache = (InStr(vgCacheTable(vgItemCache, ITEM_CACHE_TEXT, 0), "|" + CStr(vgCol) + "|") > 0)
      Else
         vgHasCache = False
      End If
   Else
      vgHasCache = False
   End If
   
   If vgHasCache Then
      RetVal = vgCacheTable(vgItemCache, ITEM_CACHE_TEXT, vgCol)
   ElseIf vgRow <> -1 Then
      ItemStatus = Status(vgRow)
      NewItem = (vgAllowInsert And (Not vgInternalLst Or vgAllowInsertDatabase) And vgRow = vgNumItemsTot - 1)
      If Len(vgColDefinitions(vgCol).ComboTable) > 0 Or Len(vgColDefinitions(vgCol).ComboFieldsList) > 0 Then                            'se tem combo
         Call LocateRecordset(vgRow, False)       'posiciona recordset no item requerido
         If ItemStatus = ACAO_EDITANDO Or ItemStatus = ACAO_INCLUINDO Then 'é o item atual e está no meio de inclusão/alteração
            GetColumnRs vgRow, vgColumn
            If vgColDefinitions(vgCol).txtCampoGrd.Value <> vgColDefinitions(vgCol).NewValue Or vgColDefinitions(vgCol).NewText <> vgColDefinitions(vgCol).txtCampoGrd.Text Then
               vgPriVez = vgPriVez + 1
               vgColDefinitions(vgCol).txtCampoGrd.SetOriginalValue = True
               vgColDefinitions(vgCol).txtCampoGrd.Value = vgColDefinitions(vgCol).NewValue
               vgPriVez = vgPriVez - 1
               If vgColDefinitions(vgCol).txtCampoGrd.Value & "" = "" Then
                  vgColDefinitions(vgCol).txtCampoGrd.vgfrmGMCale.grdListaG.ReBind
               Else
                  vgColDefinitions(vgCol).NewText = vgColDefinitions(vgCol).txtCampoGrd.Text
               End If
            End If
            If Len(vgColDefinitions(vgCol).NewText) = 0 And Len(CStr(vgColDefinitions(vgCol).NewValue & "")) > 0 And Len(vgColDefinitions(vgCol).ComboTable) = 0 And Len(vgColDefinitions(vgCol).ComboFieldsList) > 0 Then
               RetVal = CStr(vgColDefinitions(vgCol).NewValue & "")
            Else
               RetVal = vgColDefinitions(vgCol).NewText
            End If
         ElseIf Not NewItem Then                                           'se não está na linha de novo item
            If Not vgTabela.EOF And Not vgTabela.BOF And Len(vgColumns(vgCol).NameFilter) > 0 Then
               If Len(vgColDefinitions(vgCol).ComboFieldsRelation) > 0 Then
                  RetVal = ""
                  For i = 1 To Tally(Substitui$(vgColDefinitions(vgCol).ComboFieldsShow, "; ", "|", SO_UM) + "|", "|")
                     vgField = Parse$(Substitui$(vgColDefinitions(vgCol).ComboFieldsShow, "; ", "|", SO_UM) + "|", "|", i)
                     If Len(RetVal) > 0 Then RetVal = RetVal + "   "
                     RetVal = RetVal + CStr(vgTabela.Field(vgTabela.DataBase.GetFieldNameShort(vgColDefinitions(vgCol).ComboTable + "_" + vgField$)).Value & "")
                  Next
               Else
                  If vgColDefinitions(vgCol).txtCampoGrd.Value <> vgTabela.Field(vgColumns(vgCol).Name).Value Then
                     vgFilter = vgColDefinitions(vgCol).ComboFieldsFilter
            
                     'se não é lista interna
                     If Not (Len(vgColDefinitions(vgCol).ComboTable) = 0 And Len(vgColDefinitions(vgCol).ComboFieldsList) > 0) Then
                        RaiseEvent GetColumnFilter(vgCol, GetRsCols(vgRow), vgFilter)
                     End If
                     vgPriVez = vgPriVez + 1
                     vgColDefinitions(vgCol).txtCampoGrd.SetOriginalValue = True
                     vgColDefinitions(vgCol).txtCampoGrd.Filter = vgFilter
                     vgColDefinitions(vgCol).txtCampoGrd.Value = vgTabela.Field(vgColumns(vgCol).Name).Value
                     vgPriVez = vgPriVez - 1
                  End If
                  RetVal = vgColDefinitions(vgCol).txtCampoGrd.Text
               End If
            End If
         End If
      Else
         RetVal = GetColumnRs(vgRow, vgCol)
      End If
      
      'solicita valor para o parent (Apenas para colunas que não tenham campos vinculados ou em uboundmode)
      If (vgHasChanged And vgRow = vgRowEditing) Or Not vgAllowInsert Or Not (vgInternalLst Or vgAllowInsertDatabase) Or vgRow <> vgNumItemsTot - 1 Then
         If vgUboundMode Or Len(vgColumns(vgCol).NameFilter) = 0 Then
            Call LocateRecordset(vgRow, False)                             'posiciona recordset no item requerido
            RaiseEvent GetColumnValue(vgRow, vgCol, GetRsCols(vgRow), RetVal)
         End If
      End If
      
      If Not vgUboundMode Then                                             'se não for ubound mode vamos corrigir a máscara
         If Len(CStr(RetVal & "")) > 0 And Len(vgColDefinitions(vgCol).ComboTable) = 0 And Len(vgColDefinitions(vgCol).ComboFieldsList) = 0 Then
            RetVal = txtCampo.FormatField(RetVal, vgColumns(vgCol).Mask, PegaTipoMask(vgColumns(vgCol).ColumnType), vgColDefinitions(vgCol).List)
         End If
      End If
      If vgCacheSize <> 0 And Not vgHasCache Then
         vgCacheTable(vgItemCache, ITEM_CACHE_TEXT, vgCol) = RetVal
         If InStr(vgCacheTable(vgItemCache, ITEM_CACHE_TEXT, 0), "|" + CStr(vgCol) + "|") = 0 Then
            If Len(vgCacheTable(vgItemCache, ITEM_CACHE_TEXT, 0)) = 0 Then vgCacheTable(vgItemCache, ITEM_CACHE_TEXT, 0) = "|"
            vgCacheTable(vgItemCache, ITEM_CACHE_TEXT, 0) = vgCacheTable(vgItemCache, ITEM_CACHE_TEXT, 0) + CStr(vgCol) + "|"
         End If
      End If
   End If
   GetColumnText = RetVal & ""
   
   Call RestoreSelBookmark
End Function

'Restaura bokmark para o registro selecionado
Private Sub RestoreSelBookmark()
   If Len(vgBkSelect) > 0 Then
      vgTabela.BookMark = vgBkSelect
   End If
End Sub

'posiciona o recordset no item requerido
Private Sub LocateRecordset(ByVal vgRow As Long, ByVal vgSkipRecord As Boolean)
   Dim vgMove As Long, vgAdding As Boolean

   On Error GoTo FimDaSub

   vgAdding = (vgAllowInsert And (vgInternalLst Or vgAllowInsertDatabase) And vgRow = vgNumItemsTot - 1)               'se tem inclusão, o último item é uma linha em branco...
   
   If vgAdding Or (vgTabela.Status <> ACAO_NAVEGANDO And vgHasChanged And vgRow = SelectedItem And vgRow = vgRecPosAtual) Then
      GoTo FimDaSub
   End If
   
   If Not vgUboundMode Then
      If Not vgInternalLst Then
         If Val(vgBkVirtual) <> -1 And Val(vgBkVirtual) <> -2 And Val(vgBkVirtual) <> -3 And Len(vgBkVirtual) > 0 Then vgTabela.BookMark = vgBkVirtual 'vamos restaurar o bookmark no último posicionamento feito pelo locate
         If vgRow = vgUltBkSelect And Val(vgBkSelect) <> -1 And Val(vgBkSelect) <> -2 And Val(vgBkSelect) <> -3 And Len(vgBkSelect) > 0 Then           'se já tem esse bookmark
            vgTabela.BookMark = vgBkSelect
         Else
            If vgTabela.EOF Or vgTabela.BOF Or vgRecPosAtual = -1 Then

               'vamos zerar controle de bookmark
               Call ResetBookMark

               If vgTabela.RecordCount > 0 Then
                  vgTabela.MoveFirst
                  vgRecPosAtual = 0
               Else
                  vgRecPosAtual = -1
               End If
            End If
            vgMove = (vgRow - vgRecPosAtual)      'calcula diferença entre o solicitado e o último registro lido
            If vgRow <> vgRecPosAtual Then
               If vgMove <> 0 Then
                  If vgMove = 1 And Not vgTabela.EOF Then 'está solicitando o próximo registro
                     vgTabela.MoveNext
                  ElseIf vgMove = -1 And Not vgTabela.BOF Then 'está solicitando o registro anterior
                     vgTabela.MovePrevious
                  ElseIf vgRow = 0 Then                        'está solicitando o primeiro registro
                     vgTabela.MoveFirst
                  ElseIf vgRow + 1 = vgNumItems Then           'está solicitando o último registro
                     vgTabela.MoveLast
                  ElseIf Abs(vgMove) < ((vgRow + 1) - vgNumItems) Then 'se a diferença for menor que o próprio item solicitado... (quer dizer que é melhor mover a partir do item atual do que mover a partir do último)
                     vgTabela.Move vgMove
                  ElseIf (vgNumItems - (vgRow + 1)) < vgRow + 1 And (vgNumItems - (vgRow + 1)) < Abs(vgMove) Then 'se está mais próximo do último registro que do primeiro
                     vgTabela.MoveLast
                     vgTabela.Move ((vgRow + 1) - vgNumItems)
                  ElseIf Abs(vgMove) < vgRow Then   'se a diferença for menor que o próprio item solicitado... (quer dizer que é melhor mover a partir do item atual do que mover a partir do primeiro)
                     vgTabela.Move vgMove
                  Else                              'está mais próximo do primeiro registro
                     vgTabela.MoveFirst
                     vgTabela.Move vgRow
                  End If
               End If
            ElseIf (vgTabela.EOF Or vgTabela.BOF) And vgTabela.RecordCount > 0 Then 'recordset está desposicionado (ERRO), vamos reposicionar
               If vgMove = 1 Then                 'se é o primeiro item
                  vgTabela.MoveFirst
               ElseIf vgRow + 1 = vgNumItems Then 'se é o último item
                  vgTabela.MoveLast
               ElseIf (vgNumItems - (vgRow + 1)) < vgRow + 1 Then 'se está mais próximo do último registro que do primeiro
                  vgTabela.MoveLast
                  vgTabela.Move ((vgRow + 1) - vgNumItems)
               Else                                               'está mais próximo do primeiro registro
                  vgTabela.MoveFirst
                  vgTabela.Move vgRow
               End If
            End If
            If vgRow = SelectedItem And (vgRow <> vgUltBkSelect Or CStr(vgBkSelect) <> CStr(vgTabela.BookMark)) Then 'se deu locate no item selecionado e o bookmark salvo está incorreto, vamos ajustar
               vgUltBkSelect = vgRow              'guarda número do item da seleção atual
               vgBkSelect = vgTabela.BookMark     'guarda bookmark como sendo bk da seleção atual
            End If
         End If
         If vgSkipRecord And vgLastSkipRec <> vgRow And vgTabela.AsyncComplete Then
            vgLastSkipRec = vgRow
            If vgRow = SelectedItem Then
               RaiseEvent SkipRecord(GetOriginalCols, vgTabela.BookMark)
            Else                                  'isso nunca deverá ocorrer, pois o Skip só é solicitado para registro corrente, mas...
               RaiseEvent SkipRecord(GetRsColsDirect, vgTabela.BookMark)
            End If
         End If
         vgRecPosAtual = vgRow                    'número do item que temos no bookmark virtual
         vgBkVirtual = vgTabela.BookMark          'guarda último posicionamento da tabela
      End If
   End If

FimDaSub:
   If Err Then
      If Err = 3167 Then
         ResetBookMark
         LocateRecordset vgRow, vgSkipRecord
      End If
   End If

End Sub

'pega posição do item dentra da tabela de cache
Private Function GetCachePosition(ByVal vgRow As Long) As Long
   GetCachePosition = ((vgRow + 1) - vgCacheFirst + 1)
End Function

'prepara tabela de cache de acordo com o item solicitado
'tenta aproveitar ao máximo os itens já existentes em cache, fazendo
'o reposicionamento de toda tabela quando necessário
Private Sub PrepareCacheTable(ByVal vgRow As Long)
   Dim i As Integer, j As Integer, ii As Integer, vgDislocateCache As Long
   vgRow = vgRow + 1
   If vgCacheFirst = -1 Or vgRow < vgCacheFirst Or vgRow > vgCacheFirst + vgCacheSize - 1 Then           'se item não estiver no cache, vamos preparar a nova tabela para cache
      If vgCacheFirst = -1 Then                   'não tem cache ainda definido, vamos iniciar...
         If vgRow < vgNumItemsTot - vgCacheSize + 1 Or vgNumItemsTot < vgCacheSize + 1 Then
            vgCacheFirst = vgRow
         Else
            vgCacheFirst = vgNumItemsTot - vgCacheSize + 1
         End If
         vgDislocateCache = 0
      ElseIf vgRow < vgCacheFirst Then
         If vgRow < vgCacheFirst - vgCacheSize Then
            vgDislocateCache = 0
            vgCacheFirst = vgRow                  'vamos iniciar o cache nesse item
         Else                                     'vamos aproveitar alguns
            vgDislocateCache = vgRow - vgCacheFirst 'deslocando apenas essa quantidade
            vgCacheFirst = vgRow
         End If
      ElseIf vgRow > vgCacheFirst + vgCacheSize - 1 Then
         If vgRow > vgCacheFirst + 2 * vgCacheSize - 1 Then
            vgDislocateCache = 0                    'marca esse item para início do cache
            If vgRow < vgNumItemsTot - vgCacheSize + 1 Then
               vgCacheFirst = vgRow                 'vamos iniciar o cache nesse item
            Else
               vgCacheFirst = vgNumItemsTot - vgCacheSize + 1 'prepara última página de cache
            End If
         Else                                                 'vamos aproveitar alguns
            vgDislocateCache = vgRow - (vgCacheFirst + vgCacheSize - 1) 'deslocando apenas essa quantidade
            vgCacheFirst = vgCacheFirst + vgDislocateCache              'nova posição para início do cache
         End If
      End If
      If vgDislocateCache = 0 Then                                      'é necessário reiniciar o cache, limpa tudo
         ReDim vgCacheTable(1 To vgCacheSize, 1 To ITEM_CACHE_MAX, 0 To vgColumns.Count) As Variant 'reinicia o cache
      ElseIf vgDislocateCache > 0 Then            'é necessário deslocar o cache para trás
         For i = 1 To vgCacheSize                 'vamos correr a tabela do primeiro para o último elemento
            If i > vgCacheSize - vgDislocateCache Then 'se está no ponto de deslocamento
               For ii = 1 To ITEM_CACHE_MAX
                  vgCacheTable(i, ii, 0) = ""
               Next
            Else
               For j = 0 To vgColumns.Count            'corre todas as colunas
                  For ii = 1 To ITEM_CACHE_MAX
                     vgCacheTable(i, ii, j) = vgCacheTable(i + vgDislocateCache, ii, j) 'copia para nova posição
                  Next
               Next
            End If
         Next
      ElseIf vgDislocateCache < 0 Then                                                  'é necessário deslocar o cache para frente
         For i = vgCacheSize To 1 Step -1                                               'vamos carrer a tabela do último para o primeiro
            If i <= Abs(vgDislocateCache) Then                                          'se está no ponto de deslocamento
               For ii = 1 To ITEM_CACHE_MAX
                  vgCacheTable(i, ii, 0) = ""
               Next
            Else
               For j = 0 To vgColumns.Count                                             'corre todas as colunas
                  For ii = 1 To ITEM_CACHE_MAX
                     vgCacheTable(i, ii, j) = vgCacheTable(i + vgDislocateCache, ii, j) 'copia para nova posição
                  Next
               Next
            End If
         Next
      End If
   End If
End Sub

Private Function GetColorInfo(ByVal vgRow As Long, ByVal vgColumn As Long) As GridColorDefinition
   Dim ColSelected As Boolean, vgHasCache As Boolean, vgItemCache As Long, Colors As String, ColorDef As GridColorDefinition
   
   'usuário quer Cache... vamos preparar a tabela
   If vgCacheSize <> 0 And vgRow <> -1 Then                                  'tem controle de cache
      PrepareCacheTable vgRow
      vgItemCache = GetCachePosition(vgRow)
      If Status = ACAO_NAVEGANDO Then
         vgHasCache = (InStr(vgCacheTable(vgItemCache, ITEM_CACHE_COLOR, 0), "|" + CStr(vgColumn) + "|") > 0)
      Else
         vgHasCache = False
      End If
   Else
      vgHasCache = False
   End If
   
   'se tem cache
   If vgHasCache Then
      Colors = vgCacheTable(vgItemCache, ITEM_CACHE_COLOR, vgColumn)         'pega as cores para esse item que estão em cache
      ColorDef.TextColor = Val(Parse$(Colors, "|"))
      ColorDef.BackColor = Val(Parse$(Colors, "|"))
      ColorDef.SelectTextColor = Val(Parse$(Colors, "|"))
      ColorDef.SelectBackColor = Val(Parse$(Colors, "|"))
      ColorDef.ColumnTextColor = Val(Parse$(Colors, "|"))
      ColorDef.ColumnBackColor = Val(Parse$(Colors, "|"))
   Else
      
      'vamos pegar valores default para cores de texto e fundo
      ColorDef.TextColor = vgCellTextColor
      ColorDef.BackColor = vgCellBackColor
      
      If vgColumn > 0 Then
         If vgColDefinitions(vgColumn).TextColor <> -1 Then
            ColorDef.TextColor = vgColDefinitions(vgColumn).TextColor
         End If
         If vgColDefinitions(vgColumn).BackColor <> -1 Then
            ColorDef.BackColor = vgColDefinitions(vgColumn).BackColor
         End If
      End If
      
      ColorDef.SelectTextColor = vgSelectTextColor
      ColorDef.SelectBackColor = vgSelectBackColor
      
      'tem zebra
      If vgStripes Then
         If ((vgRow + 1) And 1) = 0 Then                                     'está em item par (vamos pegar cor do stripe)
            ColorDef.TextColor = vgStripesTextColor
            ColorDef.BackColor = vgStripesBackColor
         End If
      End If

      If Not vgEnabled Then
         ColorDef.TextColor = vbButtonText
         ColorDef.SelectTextColor = vbButtonText
         ColorDef.BackColor = vbButtonFace
         ColorDef.SelectBackColor = vbButtonFace
      End If

      ColorDef.ColumnTextColor = vgColHeaderTextColor
      ColorDef.ColumnBackColor = vgColHeaderBackColor
      
      If vgColumn > 0 Then
         If vgColDefinitions(vgColumn).HeaderTextColor <> -1 Then
            ColorDef.ColumnTextColor = vgColDefinitions(vgColumn).HeaderTextColor
         End If
         If vgColDefinitions(vgColumn).HeaderBackColor <> -1 Then
            ColorDef.ColumnBackColor = vgColDefinitions(vgColumn).HeaderBackColor
         End If
      End If
      
      'vamos solicitar para o controle as cores para esse item
      RaiseEvent GetColor(vgRow, vgColumn, ColorDef.TextColor, ColorDef.BackColor, ColorDef.SelectTextColor, ColorDef.SelectBackColor, ColorDef.ColumnTextColor, ColorDef.ColumnBackColor)

      'tem controle de cache, vamos gravar
      If vgCacheSize <> 0 And vgRow <> -1 Then                               'tem controle de cache
         Colors = CStr(SysColor(ColorDef.TextColor)) + "|" + CStr(SysColor(ColorDef.BackColor)) + "|" + CStr(SysColor(ColorDef.SelectTextColor)) + "|" + CStr(SysColor(ColorDef.SelectBackColor)) + "|" + CStr(SysColor(ColorDef.ColumnTextColor)) + "|" + CStr(SysColor(ColorDef.ColumnBackColor))
         vgCacheTable(vgItemCache, ITEM_CACHE_COLOR, vgColumn) = Colors
         If InStr(vgCacheTable(vgItemCache, ITEM_CACHE_COLOR, 0), "|" + CStr(vgColumn) + "|") = 0 Then
            If Len(vgCacheTable(vgItemCache, ITEM_CACHE_COLOR, 0)) = 0 Then vgCacheTable(vgItemCache, ITEM_CACHE_COLOR, 0) = "|"
            vgCacheTable(vgItemCache, ITEM_CACHE_COLOR, 0) = vgCacheTable(vgItemCache, ITEM_CACHE_COLOR, 0) + CStr(vgColumn) + "|"
         End If
      End If
   
   End If
   
   GetColorInfo = ColorDef
   
End Function

Private Function WithHScroll() As Boolean
   WithHScroll = (GetWindowLong(hWndLst, GWL_STYLE) And WS_HSCROLL)
End Function

Private Function GetShiftKeys() As Long
   Dim RetVal As Long
   RetVal = 0
   If GetAsyncKeyState(VK_LSHIFT) Or GetAsyncKeyState(VK_RSHIFT) Then
      RetVal = 1
   End If
   If GetAsyncKeyState(VK_LCONTROL) Or GetAsyncKeyState(VK_RCONTROL) Then
      RetVal = RetVal Or 2
   End If
   If GetAsyncKeyState(VK_LMENU) Then
      RetVal = RetVal Or 4
   ElseIf GetAsyncKeyState(VK_RMENU) Then
      RetVal = RetVal Or 6
   End If
   GetShiftKeys = RetVal
End Function

'transforma cor caso seja alguma de sistema
Private Function SysColor(ByVal vgColor As Long) As Long
   If vgColor And &H80000000 Then
      SysColor = GetSysColor(vgColor And &H7FFFFFFF)
   Else
      SysColor = vgColor
   End If
End Function

Private Function MakeFont(ByVal FontTypeSize As Single, ByVal FontWeight As Long, ByVal Italic As Long, ByVal Underline As Long, ByVal StrikeOut As Long, ByVal FaceName As String) As Long
   MakeFont = CreateFont(-MulDiv(FontTypeSize, GetDeviceCaps(hdc, LOGPIXELSY), 72), 0, 0, 0, FontWeight, Italic, Underline, StrikeOut, _
                         DEFAULT_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, PROOF_QUALITY, DEFAULT_PITCH, FaceName)
End Function

Private Sub botFilter_Click(Index As Integer)
   If vgColumns(Index).ColumnType = TP_DATA_HORA Then
      txtCampoFilter(Index).BotClick BOT_ACAO
   Else
      txtCampoFilter(Index).BotClick BOT_COMBO
   End If
End Sub

Public Sub BotClick(ByVal Index As Integer)
   vgIgnoreKey = vgLastKey
   If Not vgIsPreEditing And Not vgHasChanged Then
      PreEditing = True
      DoEvents
   End If
   bottxtCampo_Click Index
End Sub

Private Sub bottxtCampo_Click(Index As Integer)
   Dim Cancel As Boolean
   picEdit.SetFocus
   If Index = BOT_ACAO Then
      RaiseEvent ColumnActionButtonClick(GetNewCols(), SelectedItem, vgColAtual, Cancel)
      'vamos forças redefinição completa para o txtEdit
      vgForcePosSel = True                        'vamos forçar reposicionamento e definição de txtCampo
      vgColEditing = -1                           'vamos forçar redefinição do txtCampo
      vgRowEditing = -1
      vgCacheFirst = -1                           'vamos ignorar o cache para atualizar uma alteração que possa ter ocorrido no recordset após o clique do botão
      PosicionaSelect
   End If
   DoEvents
   If Not Cancel Then
      txtCampo.BotClick Index, picEdit
   End If
End Sub

'==============================================
'Métodos para controle de subclasses
'==============================================

Private Sub GSubClassInterface_WndProc(ByVal lHwnd As Long, ByVal message As GSCMessage, wParam As Long, lParam As Long, ByVal bBefore As Boolean, bCancel As Boolean, lReturn As Long)
   Dim udtNMHDR As NMHDR, udtNM_LISTVIEW As NM_LISTVIEW
   Dim udtLV_DISPINFO As LV_DISPINFO
   Dim Rc As RECT, RcLst As RECT, RcItem As RECT
   Dim hBrushBack As Long
   Dim lpmis As MEASUREITEMSTRUCT
   Dim i As Long
   Dim pt As POINTAPI
   Dim Ini As Long, Fim As Long, j As Long
   Dim vgRow As Long, vgHTI As LVHITTESTINFO
   Dim Cancel As Boolean, vgOk As Boolean
   Dim vgUltCol As Long, vgUltItemSel As Long
   Dim hDcTemp As Long, vgAdding As Boolean

   Select Case lHwnd
   
      '==============================================
      'tratamento para o listview
      '==============================================
      Case hWndLst

         If picFundo.Visible Then
            bCancel = True
            Exit Sub
         End If

         If message = WM_SETFOCUS Then
            bCancel = True
            UserControl.SetFocus
         ElseIf message = WM_VSCROLL Then
            DrawLeftBar
            DrawHeaderBar
            PosicionaSelect
         ElseIf message = WM_HSCROLL Then
            DrawBars
         ElseIf message = WM_PAINT Then                                        'está solicitando paint
         
            hDcTemp = GetDC(hWndLst)
         
            Ini = FirstItemVisible()                                           'primeiro item da lista (visível)
            Fim = LastItemVisible()                                            'último item da lista (visível)
            GetClientRect hWndLst, RcLst
            hBrushBack = CreateSolidBrush(SysColor(vgBackColor))               'cria o brush
            
            'pinta o restante do listview a direita das colunas
            Rc = RcLst
            Rc.Top = Rc.Top + 2
            Rc.Left = (ColumnRight(GetVisibleCol(COL_LAST))) / vgTpX + 1
            If Not vgHideLeftBar Then Rc.Left = Rc.Left - vgLeftBarWidth / vgTpX
            FillRect hDcTemp, Rc, hBrushBack                                   'faz o erase do lv

            'limpa sujeira após última linha
            Rc.Left = 0: Rc.Right = 0: Rc.Top = 0: Rc.Bottom = 0
            SendMessage hWndLst, LVM_GETITEMRECT, Fim, Rc                      'pega posicionamento do item
            RcItem = RcLst
            RcItem.Top = Rc.Bottom
            If Fim < vgNumItemsTot - 1 Then
               RcItem.Left = (ColumnLeft(vgColumns.Count) + ColumnWidth(vgColumns.Count)) / vgTpX
               If Not vgHideLeftBar Then
                  RcItem.Left = RcItem.Left - vgLeftBarWidth / vgTpX
               End If
            End If

            FillRect hDcTemp, RcItem, hBrushBack                               'faz o erase do lv na parte inferior
            DeleteObject hBrushBack                                            'mata o brush

            'se não quer esconder o select, vamos ver se há seleção válida, caso não haja vamos selecionar
            If Not vgHasChanged And Not vgIsPreEditing And Not vgHideSelect Then
               If Len(vgColsSelected) = 0 And vgColAtual = -1 Then
                  vgColAtual = GetVisibleCol(COL_FIRST)
               End If
               If Len(vgRowsSelected) = 0 And Len(vgColsSelected) = 0 And SelectedItem = -1 And FirstItemVisible = 0 Then
                  SelecionaItem 0
               End If
            End If
            
            ReleaseDC hWnd, hDcTemp
            
            'se não tiver nenhum item na lista, vamos repintar o header para corrigir desenha da parte inferior do mesmo
            If vgNumItemsTot = 0 Then DrawHeaderBar


         ElseIf message = WM_LBUTTONDBLCLK Then
            If GetShiftKeys = 0 Then
               GetCursorPos pt
               ScreenToClient hWndLst, pt
               vgHTI.pt = pt
               i = SendMessage(hWndLst, LVM_SUBITEMHITTEST, 0, vgHTI)          'vamos pegar a posição do double click
               If Not vgHasChanged And Not vgIsPreEditing And vgTabela.AsyncComplete And vgHTI.iItem <> -1 And vgHTI.iSubItem <> -1 Then
                  vgIsPreEditing = True
                  vgForcePosSel = True
                  PosicionaSelect
               End If
            End If
            bCancel = True
         ElseIf message = WM_RBUTTONDOWN Or message = WM_RBUTTONDBLCLK Then
            bCancel = True
         ElseIf message = WM_LBUTTONDOWN Then
            picSel.SetFocus                       'sempre deixa o foco na picSel
            vgUltCol = vgColAtual
            vgUltItemSel = SelectedItem
            Call GetShiftKeys                     'as vezes a GetAsyncKeyState fica com ALT ou CTRL travados... ALT+TAB por exemplo... vamos chamar uma primeira vez para liberar :D
            If GetShiftKeys = 0 Then
               GetCursorPos pt
               ScreenToClient hWndLst, pt
               vgHTI.pt = pt
               i = SendMessage(hWndLst, LVM_HITTEST, 0, vgHTI) 'pega o item clicado
               SendMessage hWndLst, LVM_SUBITEMHITTEST, 0, vgHTI 'pega o subitem correspondente à essa posição
               
               'clique em posição inválida
               If Not vgHideSelect And (i = -1 Or vgHTI.iSubItem = -1) Then
                  If vgHasChanged Then                           'estava alterando
                     vgAdding = (Status() = ACAO_INCLUINDO)
                     Cancel = EndEditGrid(True, False)           'tenta salvar informações
                     If Not vgHasChanged And vgAdding Then       'conseguiu gravar
                        vgColAtual = GetVisibleCol(COL_FIRST)
                        SelecionaItem vgNumItemsTot - 1
                     End If
                  End If
                  bCancel = True
                  Exit Sub
               End If
               
               'vai mudar de item
               If i <> SelectedItem Then                         'não é o atualmente selecionado
                  If vgHasChanged Then                           'está clicando em outro item e estávamos em edição/inclusão
                     Cancel = EndEditGrid(True, False)           'tenta salvar informações
                     If Not Cancel Then                          'tudo certo...
                        If i > LastItemVisible Then
                           SendMessageLong hWndLst, LVM_ENSUREVISIBLE, i, 0 'certifica que ele ficará visível
                        End If
                     End If
                  End If
               End If
               
               If Not Cancel Then
                  'verifica se quer mudar de coluna
                  If i <> -1 Then
                     If vgHTI.iSubItem <> -1 Or vgHideSelect Then
                        If vgColAtual <> GetColumnByPosition(vgHTI.iSubItem + 1) And Not vgFullRowSelect Then 'mudou de coluna
                           If vgHasChanged Then
                              Cancel = ValidateColumnGrid()
                           End If
                           If Not Cancel Then
                              vgColAtual = GetColumnByPosition(vgHTI.iSubItem + 1)
                           End If
                        End If
                     End If
                  ElseIf vgHideSelect Then
                     vgColAtual = -1
                  End If
                  
                  'vamos ver se é preciso gravar
                  If i = -1 And (vgHasChanged Or vgIsPreEditing) And Not Cancel Then                          'está clicando no fundo da lista e estava em edição ou pré-edição
                     Cancel = EndEditGrid(True, True)
                  End If
                  
                  'controle click para iniciar edição em DblClick
                  If Not vgHasChanged And Not vgIsPreEditing And Not Cancel Then
                     vgTimerLastClick = Timer
                  End If
               End If
            End If
                        
            If Not Cancel Then
               'quer mudar de item, seleciona
               If i <> SelectedItem And (i <> -1 Or vgHideSelect) Then
                  ItemClick i
                  vgOk = False
               Else
                  vgOk = True
               End If
                           
               'quer mudar de coluna, seleciona
               If vgColAtual <> vgUltCol Then
                  AdjustScroll
                  If vgOk And i = SelectedItem Then
                     PosicionaSelect
                  End If
               End If
               
               'vamos ver se está em pré-edição e clicou diretamente em um check, muda o estado do check
               If GetShiftKeys = 0 Then
                  If vgColAtual <> -1 And vgColumns.Count > 0 Then
                     If Not Cancel And (vgIsPreEditing Or vgHasChanged) And vgColumns(vgColAtual).ColumnType = TP_LOGICO Then 'está pré-editando ainda e foi clicado em campo lógico
                        Rc.Left = 0: Rc.Right = 0: Rc.Top = 0: Rc.Bottom = 0
                        SendMessage hWndLst, LVM_GETITEMRECT, i, Rc   'pega o posicionamento da coluna
                        Rc.Left = ColumnLeft(vgColAtual) / vgTpX
                        If Not vgHideLeftBar Then
                           Rc.Left = Rc.Left - vgLeftBarWidth / vgTpX
                        End If
                        Rc.Right = Rc.Left + ColumnWidth(vgColAtual) / vgTpX
                        Rc.Top = Rc.Top + 1
                        Rc.Left = Rc.Left + Round((Rc.Right - Rc.Left) / 2 - 13 / 2)
                        Rc.Bottom = Rc.Top + 13
                        Rc.Right = Rc.Left + 13
                        If PtInRect(Rc, pt.x, pt.y) Then
                           DefineCampo
                           Call EditCheckBox
                        End If
                     End If
                  End If
               End If
            End If
            bCancel = True                                            'vamos ignorar o evento click... ele foi tratado manualmente
         ElseIf message = WM_MOUSEMOVE Or message = WM_NCMOUSEMOVE Then
            If vgTrackSelect And vgComFoco <> 0 And Not vgHasChanged And Not vgIsPreEditing Then 'quer track select para o grid e pode fazer agora
               GetCursorPos pt
               ScreenToClient hWndLst, pt
               
               'não vamos considerar movimento sobre o scroll ou além do tamanho da lista
               vgOk = True
               GetClientRect hWndLst, RcLst
               If pt.x >= RcLst.Right Then
                  vgOk = False
               End If
               If vgOk Then                       'ok, mouse sobre uma coluna válida
                  vgHTI.pt = pt
                  i = SendMessage(hWndLst, LVM_SUBITEMHITTEST, 0, vgHTI)
                  If i <> -1 And (i <> SelectedItem Or (vgFullRowSelect Or GetColumnByPosition(vgHTI.iSubItem + 1) <> vgColAtual)) Then 'se está sobre algum item válido e não é o mesmo item/subitem que já está com a seleção
                     If Not vgFullRowSelect And GetColumnByPosition(vgHTI.iSubItem + 1) <> vgColAtual Then                              'mudou de coluna e não é fullrowselect
                        vgColAtual = GetColumnByPosition(vgHTI.iSubItem + 1)
                        AdjustColumn
                     End If
                     If i <> SelectedItem Then    'mudou de item no grid...
                        ItemSelect i, False
                     End If
                     PosicionaSelect
                  End If
               End If
            End If
            RaiseEvent MouseMove
         ElseIf message = WM_KEYDOWN Then
            RaiseEvent KeyDown(wParam, GetShiftKeys, GetNewCols())
            bCancel = TrataTeclaGrid(wParam, GetShiftKeys)
         ElseIf message = WM_KEYUP Then
            If vgIgnoreKey = wParam And Not vgIsPreEditing And Not vgHasChanged Then
               vgIgnoreKey = 0
            Else
               RaiseEvent KeyUp(wParam, GetShiftKeys, GetNewCols())
            End If
            bCancel = True
         ElseIf message = WM_CHAR Then
            If vgIgnoreKey = wParam And Not vgIsPreEditing And Not vgHasChanged Then
               vgIgnoreKey = 0
            Else
               RaiseEvent KeyPress(wParam, GetShiftKeys, GetNewCols())
            End If
            bCancel = True
            wParam = 0                            'vamos ignorar o pressionamento dessa tecla!!!
         End If
      
      '==============================================
      'tratamento para o user control
      '==============================================
      Case UserControl.hWnd
         
         If message = WM_NOTIFY Then
            CopyMemory udtNMHDR, ByVal lParam, LenB(udtNMHDR)
            If udtNMHDR.hwndFrom = hWndLst Then
               CopyMemory udtLV_DISPINFO, ByVal lParam, LenB(udtLV_DISPINFO)
               Select Case udtLV_DISPINFO.hdr.code
                  Case LVN_ITEMCHANGED
                     CopyMemory udtNM_LISTVIEW, ByVal lParam, Len(udtNM_LISTVIEW)
                     If (udtNM_LISTVIEW.uNewState And CDIS_SELECTED) = CDIS_SELECTED Then
                        vgRow = udtNM_LISTVIEW.iItem
                        If vgRow <> -1 Then
                           ClearColumnDefinition
                        End If
                     ElseIf udtNM_LISTVIEW.iItem <> -1 Then 'está perdendo a seleção
                        vgRowEditing = -1
                     End If
                  Case LVN_BEGINLABELEDIT
                     bCancel = True
               End Select
            End If
         ElseIf message = WM_MEASUREITEM Then
            If vgRowHeight > 0 Then
               CopyMemory lpmis, ByVal lParam, Len(lpmis)
               lpmis.itemHeight = (vgRowHeight / vgTpX)
               CopyMemory ByVal lParam, lpmis, Len(lpmis)
            End If
         ElseIf message = WM_MOUSEMOVE Then
            RaiseEvent MouseMove
         ElseIf message = WM_DRAWITEM Then
            DrawItem lParam
         ElseIf message = WM_MOUSEWHEEL Then
            j = HiWord(wParam)
            Scroll 0, -(j / WHEEL_DELTA) * vgTpY
            PosicionaSelect
         End If
   End Select
End Sub



Private Sub DrawItem(ByVal lParam As Long)
   Dim lpdis As DRAWITEMSTRUCT, RcCol As RECT, RcItem As RECT
   Dim i As Long, vgIsSel As Boolean, BC As Long, TC As Long, j As Long
   Dim hBrush As Long, hPen As Long, pt As POINTAPI, hPrevTC As Long
   Dim ColorDef As GridColorDefinition, vgRow As Long
   Dim hOldFont As Long, sTemp As String, hDcTemp As Long, hBmpTemp As Long, vgOrigBmp As Long
   Dim vgHTI As LVHITTESTINFO, FirstColDisplayed As Long
   
   If picFundo.Visible Then Exit Sub
   
   CopyMemory lpdis, ByVal lParam, Len(lpdis)
   
   Select Case lpdis.itemAction
      Case ODA_DRAWENTIRE, ODA_SELECT
         
         vgRow = lpdis.itemID
         
         'vamos desenhar informações na barra lateral, se necessário
         If Not vgHideLeftBar Then
            DrawLeftBarItem vgRow
         End If
         
         hDcTemp = CreateCompatibleDC(lpdis.hdc)
         
         hBmpTemp = CreateCompatibleBitmap(lpdis.hdc, lpdis.RcItem.Right - lpdis.RcItem.Left + 1, lpdis.RcItem.Bottom - lpdis.RcItem.Top)  'cria o bitmap...
         vgOrigBmp = SelectObject(hDcTemp, hBmpTemp)   'faz com que o device context criado utilize o bitmap também criado em memória
         
         RcCol.Left = 0
         RcCol.Top = 0
         RcCol.Right = lpdis.RcItem.Right
         If Not vgGridLines Then                       'vamos pintar o fundo até o lugar onde ficaria a linha de grid
            RcCol.Right = RcCol.Right + 1
         End If
         RcCol.Bottom = lpdis.RcItem.Bottom - lpdis.RcItem.Top
         hBrush = CreateSolidBrush(SysColor(vgCellBackColor)) 'cria o brush de acordo com a cor definida
         FillRect hDcTemp, RcCol, hBrush                      'pinta o fundo
         DeleteObject hBrush                                  'mata o brush
         
         'pega o índice da primeira coluna exibida na área de desenho do grid
         FirstColDisplayed = SendMessage(hWndLst, LVM_SUBITEMHITTEST, 0, vgHTI)
         FirstColDisplayed = vgHTI.iSubItem + 1
         If FirstColDisplayed < 1 Then FirstColDisplayed = 1
         
         For i = FirstColDisplayed To vgColumns.Count
            vgIsSel = (vgRow = SelectedItem And (i = vgColAtual Or vgFullRowSelect)) ' ((lpdis.itemState And ODS_SELECTED) And (vgFullRowSelect Or i = vgColAtual) And Not vgHideSelect)
            
            'calcula coordenadas da coluna/selection
            RcCol.Top = 0
            RcCol.Bottom = lpdis.RcItem.Bottom - lpdis.RcItem.Top
            
            RcCol.Left = ColumnLeft(i) / vgTpX + 1
            If Not vgHideLeftBar Then
               RcCol.Left = RcCol.Left - vgLeftBarWidth / vgTpX
            End If
            RcCol.Right = RcCol.Left + ColumnWidth(i) / vgTpX
            
            If i = GetVisibleCol(COL_FIRST) Then
               RcCol.Left = RcCol.Left - 1
            End If
            
            'vamos ajustas as bordas caso tenha grid line habilitado
            If vgGridLines Then
               RcCol.Right = RcCol.Right - 1
               RcCol.Bottom = RcCol.Bottom - 1
            End If
            
            'desenha as linhas de grid para essa coluna (linha inferior e linha direita apenas)
            If vgGridLines Then
               RcCol.Bottom = RcCol.Bottom - 1
               hPen = CreatePen(0, 1, SysColor(vgGridLinesColor))
               hPen = SelectObject(hDcTemp, hPen)
               
               'linha inferior
               MoveToEx hDcTemp, 0, RcCol.Bottom + 1, pt
               LineTo hDcTemp, RcCol.Right + 1, RcCol.Bottom + 1
               
               'linha lateral (direita)
               MoveToEx hDcTemp, RcCol.Right, RcCol.Top, pt
               LineTo hDcTemp, RcCol.Right, RcCol.Bottom + 1
               
               DeleteObject SelectObject(hDcTemp, hPen)
            End If
               
            'agora desenha o conteúdo dessa coluna (caso não seja a selected)
            If Not vgIsSel Or vgFullRowSelect Then                                   'em fullrowselect vamos imprimir mesmo assim para que a digitação na combo funcione bem
               DrawColumnContent i, vgRow, hDcTemp
            End If
            
            'se a coluna começa após a barra de scroll vertical
            If RcCol.Left * vgTpX > ScaleWidth - IIf(FirstItemVisible <> 0 Or LastItemVisible < vgNumItemsTot - 1, GetSystemMetrics(SM_CXVSCROLL) * vgTpX, 0) Then
               Exit For
            End If
            
         Next
         If vgRow = FirstItemVisible Then
            DrawHeaderBar
'    picFilter.Line (0, picHeader.ScaleHeight - 15)-(picHeader.ScaleWidth, picHeader.Height - 15), vbButtonShadow
         End If
   
         BitBlt lpdis.hdc, 0, lpdis.RcItem.Top, lpdis.RcItem.Right - lpdis.RcItem.Left + 1, lpdis.RcItem.Bottom - lpdis.RcItem.Top, hDcTemp, 0, 0, vbSrcCopy
   
         SelectObject hDcTemp, vgOrigBmp
         DeleteObject hBmpTemp
         DeleteDC hDcTemp
         
         If vgRow = SelectedItem Then
            PosicionaSelect
         End If
         
   End Select
End Sub

'desenha o conteúdo da coluna
Private Sub DrawColumnContent(ByVal vgColumn As Integer, ByVal vgRow As Long, ByVal hDcToDraw As Long)
   Dim hDcDraw As Long, RcItem As RECT, RcCol As RECT, BC As Long, TC As Long, ColorDef As GridColorDefinition, hBrush As Long, vgAlign As Long
   Dim sTemp As String, hPrevTC As Long, hOldFont As Long, hOldBkMode As Long
   Dim vgShowFields() As String                        'armazena os campos da combobox
   
   If picFundo.Visible Then Exit Sub
   
   'se passou hdc, vamos usar...
   If hDcToDraw = 0 Then
      hDcDraw = picSel.hdc
   Else
      hDcDraw = hDcToDraw
   End If
   
   If vgRow = -1 Then
      vgRow = SelectedItem
   End If
   
   If vgColumn = -1 Then
      vgColumn = 1
   End If
   
   SendMessage hWndLst, LVM_GETITEMRECT, vgRow, RcItem 'pega posicionamento do item
   
   'calcula coordenadas da coluna/selection
   RcCol.Top = 0
   RcCol.Bottom = RcItem.Bottom - RcItem.Top
   
   RcCol.Left = ColumnLeft(vgColumn) / vgTpX + 1
   If vgFullRowSelect And vgRow = SelectedItem Then    'adiciona diferença da posição inicial do rect.
      RcCol.Left = RcCol.Left + Abs(RcItem.Left)
   End If
   If Not vgHideLeftBar Then
      RcCol.Left = RcCol.Left - vgLeftBarWidth / vgTpX
   End If
   RcCol.Right = RcCol.Left + ColumnWidth(vgColumn) / vgTpX
   
   If vgColumn = GetVisibleCol(COL_FIRST) Then
      RcCol.Left = RcCol.Left - 1
   End If
   
   'vamos ajustas as bordas caso tenha grid line habilitado
   If vgGridLines Then
      RcCol.Right = RcCol.Right - 1
      RcCol.Bottom = RcCol.Bottom - 1
   End If
   
   BC = 0
   
   If (vgIsPreEditing Or vgHasChanged) And (vgColumn = vgColEditing Or vgColumn = vgColAtual) And vgRowEditing = vgRow Then
      BC = vgEditBackColor
   End If
   
   If BC = 0 Then
      If Not (vgIsPreEditing Or vgHasChanged) Or vgColumn <> vgColEditing Or vgRow <> vgRowEditing Then 'não vamos limpar o fundo para item selecionado em edição ou pré-edição
         
         'vamos pegar definição de cores para essa coluna
         ColorDef = GetColorInfo(vgRow, vgColumn)
         
         'pega informações de seleção (quando não estiver em modo pré-edição nem edição)
         If (InStr(vgRowsSelected, "|" + CStr(vgRow) + "|") > 0 Or InStr(vgColsSelected, "|" + CStr(vgColumn) + "|") > 0 Or (vgRow = SelectedItem) And (vgFullRowSelect Or vgColumn = vgColAtual)) And Not vgHideSelect Then
            TC = ColorDef.SelectTextColor
            BC = ColorDef.SelectBackColor
         Else                                     'pega informações para texto comum
            TC = ColorDef.TextColor
            BC = ColorDef.BackColor
         End If
         
      End If
   End If
   
   'vamos pintar o fundo/desenhar o retângulo de foco
   If vgRow = SelectedItem And (vgColumn = vgColAtual Or vgFullRowSelect) Then
      If Not vgFullRowSelect Or vgColumn = GetVisibleCol(COL_FIRST) Then 'só deixa fazer uma vez no caso de fullrowselect, ou sempre caso não seja fullrowselect
         picSel.Line (0, 0)-(picSel.Width, picSel.Height), BC, BF        'pinta o fundo do select
         If Not vgHideFocus And vgComFoco <> 0 And Not vgHasChanged And Not vgIsPreEditing And ParentIsFocused() Then 'se esse item está selecionado e não quer esconder seleção e não está em edição
            picSel.ForeColor = BC
            vgUltFocusRect.Left = 0
            vgUltFocusRect.Top = 0
            vgUltFocusRect.Right = picSel.ScaleWidth / vgTpX
            vgUltFocusRect.Bottom = picSel.ScaleHeight / vgTpY
            If vgHasFocus Then DrawFocusRect picSel.hdc, vgUltFocusRect                                               'desenha o focusrect
         End If
      End If
   ElseIf BC <> 0 And BC <> vgCellBackColor Then   'temos backcolor
      hBrush = CreateSolidBrush(SysColor(BC))      'cria o brush de acordo com a cor definida
      FillRect hDcDraw, RcCol, hBrush              'pinta o fundo
      DeleteObject hBrush                          'mata o brush
   End If
   
   If (Not (vgIsPreEditing Or vgHasChanged) Or vgColumn <> vgColEditing Or vgRow <> vgRowEditing Or vgColumns(vgColumn).ColumnType = TP_LOGICO) Then
      RcItem = RcCol
      
      If vgRow = SelectedItem And vgColumn = vgColAtual And Not vgFullRowSelect Then
         RcItem.Bottom = RcItem.Bottom - RcItem.Top
         RcItem.Right = RcItem.Right - RcItem.Left
         RcItem.Left = 0
         RcItem.Top = 0
      End If
      
      InflateRect RcItem, -4, -2
      
      If vgColumns(vgColumn).ColumnType = TP_LOGICO Then
         If ColumnWidth(vgColumn) > 15 * vgTpX Then
            RcItem.Left = RcItem.Left + Round((RcItem.Right - RcItem.Left) / 2 - 13 / 2)
            RcItem.Top = RcItem.Top + 1
            RcItem.Bottom = RcItem.Top + 13
            RcItem.Right = RcItem.Left + 13
            If GetColumnRs(vgRow, vgColumn) Then
               vgAlign = DFCS_CHECKED
            Else
               vgAlign = 0
            End If
            DrawFrameControl hDcDraw, RcItem, DFC_BUTTON, DFCS_BUTTONCHECK Or vgAlign
         End If
      Else
         sTemp = CStr(GetColumnText(vgRow, vgColumn) & "")
         If InStr(sTemp, "&") > 0 Then sTemp = Substitui$(sTemp, "&", "&&", SO_UM)
         hOldBkMode = SetBkMode(hDcDraw, 1)        'vamos definir fundo transparent para os paints
         hPrevTC = SetTextColor(hDcDraw, SysColor(TC)) 'define cor do texto
         hOldFont = SelectObject(hDcDraw, vgFont)
         If Len(vgColDefinitions(vgColumn).ComboTable) = 0 Then
            If vgColDefinitions(vgColumn).Alignment = vbCenter Then
               vgAlign = vbRightJustify
            ElseIf vgColDefinitions(vgColumn).Alignment = vbRightJustify Then
               vgAlign = vbCenter
            Else
               vgAlign = vbLeftJustify
            End If
         Else
            If vgColumns(vgColumn).ColumnType = TP_NUMERICO Then
               vgShowFields = Split(vgColDefinitions(vgColumn).ComboFieldsList, ";") 'vamos pegar as colunas da combobox
               If BancoDeCampos(vgShowFields(0)).ColumnType = TP_NUMERICO Then       'se a primeira coluna da combobox é numérica
                  vgAlign = vbCenter                                                 'vamos fazer o alinhamento para a direita
               Else
                  vgAlign = vbLeftJustify                                            'o alinhamento será à esquerda
               End If
            Else
               vgAlign = vbLeftJustify                                               'o alinhamento será à esquerda
            End If
         End If
         If vgColumns(vgColumn).ColumnType <> TP_MEMO Then
            vgAlign = vgAlign Or DT_SINGLELINE                                       'Or DT_VCENTER
         Else
            vgAlign = vgAlign Or DT_WORDBREAK
         End If
         DrawText hDcDraw, sTemp, Len(sTemp), RcItem, vgAlign
         SelectObject hDcDraw, hOldFont
         SetTextColor hDcDraw, hPrevTC
         
         SetBkMode hDcDraw, hOldBkMode
      End If
   End If

   If vgRow = SelectedItem And (vgColumn = vgColAtual Or vgFullRowSelect) Then
      picSel.ZOrder 0
   
      'vamos deixar todas as barras por cima da picSel
      If Not vgHideLeftBar Then picBarra.ZOrder 0
      If Not vgHideHeader Or ShowGridCaption Then picHeader.ZOrder 0
      If Not vgHideStatus Or vgShowSumBar Or vgShowMaxBar Or vgShowMinBar Or vgShowAvgBar Then picStatus.ZOrder 0
      If vgShowFilterBar Then picFilter.ZOrder 0
      
      picSel.Refresh
   End If

End Sub

Private Function ClearColumnDefinition()
   Dim i As Integer, vgRow As Long
   vgRow = SelectedItem
   For i = 1 To vgColumns.Count
      vgColDefinitions(i).Changed = False
      vgColDefinitions(i).HasInitialValue = False
      vgColDefinitions(i).OriginalValue = GetColumnRs(vgRow, i)
      vgColDefinitions(i).NewValue = vgColDefinitions(i).OriginalValue
      vgColDefinitions(i).OriginalText = GetColumnText(vgRow, i) & ""
      vgColDefinitions(i).NewText = vgColDefinitions(i).OriginalText
   Next
End Function

'vamos fazer uma cópia da imagem atual do listview e colocar sobre a picture
'isso é necessário quando algum form modal ou Messagebox for exibido sobre a listview...
'nesses casos as mensagens para o processamento ownerdraw não são disparadas
Public Sub FreezeListView(Optional ByVal vgHide As Boolean = True)
   vgFreezeCount = vgFreezeCount + 1
   If vgFreezeCount = 1 Then
      picFundo.Move 0, 0, Width, Height
      BitBlt picFundo.hdc, 0, 0, Width / vgTpX, Height / vgTpY, UserControl.hdc, 0, 0, vbSrcCopy
      Set vgImgFundo = picFundo.Image
      picFundo.Visible = True
      picFundo.ZOrder
      If vgHide Then
         ShowWindow hWndLst, SW_HIDE
      End If
   End If
End Sub

Public Sub RestoreListView(Optional ByVal vgShow As Boolean = True)
   vgFreezeCount = vgFreezeCount - 1
   If vgFreezeCount < 0 Then vgFreezeCount = 0
   If vgFreezeCount = 0 Then
      If vgShow Then
         ShowWindow hWndLst, SW_SHOW
      End If
      picFundo.Visible = False
      Set vgImgFundo = Nothing
   End If
End Sub

Private Sub PrepareFilterAndOrder()
   Dim vgFilter As String, vgOrder As String, vgField As String, vgQtOrd As Integer, x As String, i As Integer, j As Integer
   Dim vgOriginalFieldName As String
   vgFilter$ = ""
   vgOrder$ = ""
   vgQtOrd = 0
   
   'monta filtro e conta ordem
   For i = 1 To vgColumns.Count
      If Not vgColumns(i).Hidden Then
         If Not txtCampoFilter(i).CtPri Is Nothing Then
            If Len(CStr(txtFilter(i).Text)) > 0 Then
               If Len(vgFilter) > 0 Then vgFilter = vgFilter + " AND "
               If Len(vgColDefinitions(i).ComboTable) > 0 And Len(vgColDefinitions(i).ComboFieldsRelation) > 0 Then
                  vgField$ = vgTabela.DataBase.GetFieldNameShort(vgColDefinitions(i).ComboTable + "_" + Parse(vgColDefinitions(i).ComboFieldsShow, ";", 1))
               Else
                  vgField$ = vgColumns(i).Name
               End If
               If vgColumns(i).ColumnType = TP_DATA_HORA Then
                  If (InStr(txtCampoFilter(i).Mask, "-") > 0 Or InStr(txtCampoFilter(i).Mask, "/") > 0) And InStr(txtCampoFilter(i).Mask, ":") > 0 Then
                     x = "yyyy-mm-dd hh:mm:ss"
                  ElseIf (InStr(txtCampoFilter(i).Mask, "-") > 0 Or InStr(txtCampoFilter(i).Mask, "/") > 0) Then
                     x = "yyyy-mm-dd"
                  Else
                     x = "hh:mm:ss"
                  End If
                  vgFilter = vgFilter + "Format(" + PoeColchetes(vgTabela.Table.Columns(vgField$).Name) + ", '" + x + "')"
               Else
                  vgOriginalFieldName$ = vgTabela.Fields(vgField$).Properties("BASECOLUMNNAME").Value & ""
                  If vgField$ = vgOriginalFieldName$ Then                                            'se não tem alias
                     vgFilter = vgFilter + PoeColchetes(vgTabela.Table.Columns(vgField$).Name)       'vamos pegar o nome do campo
                  Else
                     vgFilter = vgFilter + PoeColchetes(vgField$)                                    'vamos usar o alias
                  End If
               End If
               If vgColumns(i).ColumnType = TP_CARACTER Or vgColumns(i).ColumnType = TP_MEMO Then
                  'se é combobox com relacionamento definido
                  If Len(vgColDefinitions(i).ComboTable) > 0 And Len(vgColDefinitions(i).ComboFieldsRelation) > 0 Then
                     vgFilter = vgFilter + " Like '" + Substitui(Parse$(txtCampoFilter(i).Text, vgSubsTab$), "'", "''", SO_UM) + "*'"
                  ElseIf Len(vgColDefinitions(i).ComboTable) > 0 Then                                'se é combobox sem relacionamento
                     'vamos verificar se é um registro selecionado da combobox
                     If txtCampoFilter(i).Value & "" <> "" Then
                        vgFilter = vgFilter + " Like '" + Substitui(CStr(txtCampoFilter(i).Value), "'", "''", SO_UM) + "*'"
                     Else                         'se foi digitado valor que não foi localizado no search da combobox
                        vgFilter = vgFilter + " Like '" + Substitui(Parse$(txtCampoFilter(i).Text, vgSubsTab$), "'", "''", SO_UM) + "*'"
                     End If
                  Else
                     'se não é combobox
                     vgFilter = vgFilter + " Like '" + Substitui(Parse$(txtCampoFilter(i).Text, vgSubsTab$), "'", "''", SO_UM) + "*'"
                  End If
               ElseIf vgColumns(i).ColumnType = TP_NUMERICO Then
                  'se é combobox com relacionamento definido
                  If Len(vgColDefinitions(i).ComboTable) > 0 And Len(vgColDefinitions(i).ComboFieldsRelation) > 0 Then
                     vgFilter = vgFilter + " Like '" + Substitui(Parse$(txtCampoFilter(i).Text, vgSubsTab$), ",", ".", UM_A_UM) + "*'"
                  ElseIf Len(vgColDefinitions(i).ComboTable) > 0 Then 'se é combobox sem relacionamento
                     'vamos verificar se é um registro selecionado da combobox
                     If txtCampoFilter(i).Value <> 0 Then
                        vgFilter = vgFilter + " Like '" + Substitui(CStr(ValBrasil(txtCampoFilter(i).Value)), ",", ".", UM_A_UM) + "'"
                     Else
                        vgFilter = vgFilter + " Like '" + Substitui(CStr(ValBrasil(txtCampoFilter(i).Text)), ",", ".", UM_A_UM) + "*'"
                     End If
                  Else
                     'se não é combobox vamos tratar aqui
                     If InStr(txtCampoFilter(i).Text, "*") > 0 Then   'se não tem curinga
                        vgFilter = vgFilter + " Like '" & txtCampoFilter(i).Text & "'"
                     Else
                        vgFilter = vgFilter + " = " & Substitui$(ValBrasil(txtCampoFilter(i).Text), ",", ".", UM_A_UM)
                     End If
                  End If
               ElseIf vgColumns(i).ColumnType = TP_DATA_HORA Then
                  vgFilter = vgFilter + " = '" + Format$(txtCampoFilter(i).Value, x) + "'"
               ElseIf vgColumns(i).ColumnType = TP_LOGICO Then
                  If txtCampoFilter(i).Value = 0 Then
                     vgFilter = vgFilter + " = 0"
                  Else
                     vgFilter = vgFilter + " <> 0"
                  End If
               End If
            End If
         End If
         If vgColDefinitions(i).Order <> 0 Then
            vgQtOrd = vgQtOrd + 1
         End If
      End If
   Next
   
   'monta ordem
   For i = 1 To vgQtOrd
      For j = 1 To vgColumns.Count
         If vgColDefinitions(j).OrderPosition = i And vgColDefinitions(j).Order <> 0 Then
            If Len(vgOrder$) > 0 Then vgOrder$ = vgOrder$ + ", "
            If Len(vgColDefinitions(j).ComboTable) > 0 And Len(vgColDefinitions(j).ComboFieldsRelation) > 0 Then
               vgField$ = vgTabela.DataBase.GetFieldNameShort(vgColDefinitions(j).ComboTable + "_" + Parse(vgColDefinitions(j).ComboFieldsShow, ";", 1))
            Else
               vgField$ = vgColumns(j).Name
            End If
            vgOrder$ = vgOrder$ + PoeColchetes(vgTabela.Table.Columns(vgField$).Name)
            If vgColDefinitions(j).Order = -1 Then
               vgOrder$ = vgOrder$ + " DESC"
            End If
         End If
      Next
   Next

   Screen.MousePointer = vbHourglass
   
   If Len(vgOrder$) > 0 Then
      vgTabela.ExternalOrderBy = vgOrder$
   End If
   vgTabela.ExternalWhere = vgFilter$

End Sub

Private Sub PrepareTop()
   Dim vgTTop As Long, vgExtTTop As Long
   vgTTop = -1
   vgExtTTop = -1
   If vgRemoveInitialTop Then
      If Len(vgTabela.ExternalOrderBy) > 0 Or Len(vgTabela.ExternalWhere) > 0 Then        'se tem ordem/filtro, aplica o top de origem sobre a nova ordem/filtro
         If Len(vgTabela.OrderBy) > 0 Then                                                'se tem ordem inicial... obrigatoriamente temo que ter top por dentro
            vgTTop = 4000000
         Else
            vgTTop = 0
         End If
         vgExtTTop = Val(txtTop.Text)
      Else
         vgTTop = Val(txtTop.Text)
         vgExtTTop = 0
      End If
   Else
      vgTTop = vgTopOrig
      If Val(txtTop.Text) <> vgTopOrig Then
         If vgTopOrig > 0 Then
            vgExtTTop = Val(txtTop.Text)
         Else
            txtTop.Text = "0"
         End If
      Else
         vgExtTTop = 0
      End If
   End If
   vgTabela.Top = vgTTop
   vgTabela.ExternalTop = vgExtTTop
End Sub

Private Sub ApplyFilterAndOrder()
   Dim Cancel As Boolean
   
   If (vgHasChanged Or vgIsPreEditing) Then
      Cancel = EndEditGrid(True, True)
   End If
   If Not Cancel And Len(vgSQLOrig$) > 0 Then
      If SelectedItem <> -1 Then SelecionaItem -1
      
      PrepareFilterAndOrder
      PrepareTop

      If (Len(vgTabela.ExternalWhere) > 0 Or Len(vgTabela.ExternalOrderBy) > 0 Or vgTabela.ExternalTop <> -1) And Len(ExtraiSQL(vgTabela.Source, EXP_ORDERBY)) > 0 And vgTabela.Top = -1 Then
         vgTabela.Top = 4000000
      End If

      vgTabela.OpenRecordSet
      vgTabela.Populate

      'vamos zerar controle de bookmark
      Call ResetBookMark

      vgColsSelected = ""
      vgRowsSelected = ""
      LimpaValueSel
      
      vgColEditing = -1
      vgRowEditing = -1
      ReBind
      SetItemCount vgTabela.RecordCount
      Screen.MousePointer = vbDefault
      If vgTabela.AsyncComplete Then FillScalarValues
   End If
End Sub

'vamos montar a tabela de colunas escalares (SUM,MAX,MIN,AVG)
'vgValues - usar constantes SCALAR_SUM, SCALAR_MAX, SCALAR_MIN, SCALAR_AVG, podendo usar o "OR" para mais de um valor
Private Sub FillScalarValues(Optional ByVal vgValues As Integer)
   Dim vgCol As GColumn, x As String, i As Integer
   
   'Recordset para as funcoes escalares (SUM.MAX,MIN,AVG)
   Dim vgTableEscalar As GRecordSet
   
   'se não tem a expressão SQL para montar as funções agregadas, deixa o procedimento
   If Len(vgTabela.RsSource) = 0 Then Exit Sub
   
   vgSQLEscalar = ""
   If vgShowSumBar Or (vgValues And SCALAR_SUM) Then
      MontaQueryScalar 0
   End If
   If vgShowMaxBar Or (vgValues And SCALAR_MAX) Then
      MontaQueryScalar 1
   End If
   If vgShowMinBar Or (vgValues And SCALAR_MIN) Then
      MontaQueryScalar 2
   End If
   If vgShowAvgBar Or (vgValues And SCALAR_AVG) Then
      MontaQueryScalar 3
   End If

   If Len(vgSQLEscalar) Then
      x$ = vgTabela.RsSource
      If Left$(x$, 7) <> "SELECT " Then
         x$ = InsereSQL(PoeColchetes(x$), EXP_SELECT, "*")
      End If
      x$ = InsereSQL(x$, EXP_ORDERBY, "")
      vgSQLEscalar = Left$(vgSQLEscalar, Len(vgSQLEscalar) - 2)
      vgSQLEscalar = "SELECT " + vgSQLEscalar + " FROM (" + x$ + ")" + " TE"
      Set vgTableEscalar = New GRecordSet
      Set vgTableEscalar.DataBase = vgTabela.DataBase
      vgTableEscalar.OpenRecordSet vgSQLEscalar
   End If
   
   'Atualiza propriedades de columnsdefinitions
   For i = 1 To vgColumns.Count
      vgColDefinitions(i).ValueSum = 0
      vgColDefinitions(i).ValueMax = 0
      vgColDefinitions(i).ValueMin = 0
      vgColDefinitions(i).ValueAvg = 0
      If vgColumns(i).ColumnType = TP_NUMERICO And Not vgColumns(i).Hidden And Len(vgColumns(i).NameFilter) > 0 And Len(vgColDefinitions(i).ComboTable) = 0 Then
         If (vgShowSumBar And vgColDefinitions(i).ShowSum) Or (vgValues And SCALAR_SUM) Then
            If Not IsNull(vgTableEscalar.Field("S_" + vgColumns(i).Name).Value) Then
               vgColDefinitions(i).ValueSum = vgTableEscalar.Field("S_" + vgColumns(i).Name).Value
            End If
         End If
         If (vgShowMaxBar And vgColDefinitions(i).ShowMax) Or (vgValues And SCALAR_MAX) Then
            If Not IsNull(vgTableEscalar.Field("Mx_" + vgColumns(i).Name).Value) Then
               vgColDefinitions(i).ValueMax = vgTableEscalar.Field("Mx_" + vgColumns(i).Name).Value
            End If
         End If
         If (vgShowMinBar And vgColDefinitions(i).ShowMin) Or (vgValues And SCALAR_MIN) Then
            If Not IsNull(vgTableEscalar.Field("Mn_" + vgColumns(i).Name).Value) Then
               vgColDefinitions(i).ValueMin = vgTableEscalar.Field("Mn_" + vgColumns(i).Name).Value
            End If
         End If
         If (vgShowAvgBar And vgColDefinitions(i).ShowAvg) Or (vgValues And SCALAR_AVG) Then
            If Not IsNull(vgTableEscalar.Field("A_" + vgColumns(i).Name).Value) Then
               vgColDefinitions(i).ValueAvg = vgTableEscalar.Field("A_" + vgColumns(i).Name).Value
            End If
         End If
      End If
   Next

   If Len(vgSQLEscalar) Then
      
      For Each vgCol In vgColumns
         If vgCol.ColumnType = TP_NUMERICO And Not vgCol.Hidden And Len(vgCol.NameFilter) = 0 And _
            (vgColDefinitions(Val(vgCol.Index)).ShowSum Or _
            vgColDefinitions(Val(vgCol.Index)).ShowMax Or _
            vgColDefinitions(Val(vgCol.Index)).ShowMin Or _
            vgColDefinitions(Val(vgCol.Index)).ShowAvg) Then
            GetValuesStatus True                                                'pega sum, max, min e avg para todos os registro (em fórmulas)
            Exit For
         End If
      Next
      
      DrawStatusBar False
   
      'Mata o objeto
      vgTableEscalar.CloseRecordset
      Set vgTableEscalar = Nothing
   
   End If
   
End Sub

Private Sub MontaQueryScalar(vgOq As Integer)
   Dim i As Integer, vgField As String
   For i = 1 To vgColumns.Count
      If Not vgColumns(i).Hidden Then
         If vgColumns(i).ColumnType = TP_NUMERICO And Len(vgColumns(i).NameFilter) > 0 And Len(vgColDefinitions(i).ComboTable) = 0 And Len(vgColDefinitions(i).ComboFieldsList) = 0 Then
            vgField$ = vgColumns(i).Name
            Select Case vgOq
               Case 0
                  vgSQLEscalar = vgSQLEscalar + "SUM(" + PoeColchetes(vgField$) + " * 1.0) As " + PoeColchetes("S_" + vgField$) + ", "
               Case 1
                  vgSQLEscalar = vgSQLEscalar + "MAX(" + PoeColchetes(vgField$) + ") As " + PoeColchetes("Mx_" + vgField$) + ", "
               Case 2
                  vgSQLEscalar = vgSQLEscalar + "MIN(" + PoeColchetes(vgField$) + ") As " + PoeColchetes("Mn_" + vgField$) + ", "
               Case 3
                  vgSQLEscalar = vgSQLEscalar + "AVG(" + PoeColchetes(vgField$) + ") As " + PoeColchetes("A_" + vgField$) + ", "
            End Select
         End If
      End If
   Next
End Sub

Private Sub RefreshStatus()
   Dim vgItemCache As Long, ii As Integer
   If vgCacheSize <> 0 And SelectedItem <> -1 Then
      PrepareCacheTable SelectedItem
      vgItemCache = GetCachePosition(SelectedItem)
      For ii = 1 To ITEM_CACHE_MAX
         vgCacheTable(vgItemCache, ii, 0) = ""
      Next
      RaiseEvent StatusChanged(Status)
   End If
End Sub

Private Function PegaTipoMask(ByVal vgColumnType As GCOLUMN_TYPE) As Integer
   Dim vgTpCp As Integer
   Select Case vgColumnType
      Case TP_CARACTER                                         'se for tipo texto
         vgTpCp = 0
      Case TP_MEMO                                             'se for memo
         vgTpCp = 4
      Case TP_DATA_HORA                                        'se for data
         vgTpCp = 2
      Case TP_LOGICO                                           'se for lógico
         vgTpCp = 5
      Case Else                                                'se for númerico
         vgTpCp = 1
   End Select
   PegaTipoMask = vgTpCp
End Function

'Faz validação imediata para o controle (quando muda a coluna atual)
Private Function ValidateColumnGrid() As Boolean
   Dim vgCol As Integer, vgMsg As String, vgValid As Boolean
   vgValid = True
   vgMsg = ""
   vgCol = vgColAtual
   txtCampo.LostFocus
   RaiseEvent ValidateData(SelectedItem, GetNewCols(), vgValid, vgCol, vgMsg)
   If Not vgValid Then
      If vgCol <> -1 Then
         vgColAtual = vgCol
         AdjustColumn
      End If
      If Len(vgMsg$) > 0 Then
         If InStr(vgMsg$, "|") > 0 Then
            CErr.Origem = Parse$(vgMsg$, "|")
            CErr.NumErro = Val(vgMsg$)                              'deu erro
            CErr.Description = Trim$(Mid$(vgMsg$, InStr(vgMsg$, "-") + 1))
         Else
            CErr.NumErro = 3800
            CErr.Description = vgMsg$
            CErr.Mensagem = vgMsg$
         End If
         If vgCol <> -1 Then
            CErr.OcultarDetalhe = True
            CErr.Show Informa                                       'mostra mensagem do erro
            PosicionaSelect
         Else
            CErr.Show                                               'mostra mensagem do erro
            txtCampo.SetFocus
         End If
      End If
   End If
   ValidateColumnGrid = Not vgValid
End Function

'Está terminando a edição da célula, vamos gravar se preciso e esconder a caixa de texto
Private Function EndEditGrid(ByVal Save As Boolean, ByVal Terminate As Boolean) As Boolean
   Dim vgRetVal As Boolean, vgColumn As Integer, vgMsg As String, vgValid As Boolean, vgChanged As Boolean, vgRefresh As Boolean
   If Save Or vgHasChanged Then
      If Not Terminate Then
         txtCampo.LostFocus                                       'vamos forçar formatação com máscara do campo
      End If
      vgValid = True
      If Save Then
         vgColumn = -1
      Else
         vgColumn = vgColAtual
      End If
      vgMsg = ""
      If Save And vgHasChanged Then
         txtCampo.LostFocus
         RaiseEvent ValidateData(SelectedItem, GetNewCols(), vgValid, vgColumn, vgMsg)
      End If
      If Save And vgHasChanged Then
         If vgValid Then
            vgColumn = -1
            vgMsg = ""
            vgRefresh = False
            SaveChangedData vgValid, vgColumn, vgMsg, vgRefresh
         End If
      End If
      If Not vgValid Then
         If vgColumn <> -1 Then
            vgColAtual = vgColumn
            AdjustColumn
         End If
         If Len(vgMsg$) > 0 Then
            If InStr(vgMsg$, "|") > 0 Then
               CErr.Origem = Parse$(vgMsg$, "|")
               CErr.NumErro = Val(vgMsg$)                         'deu erro
               CErr.Description = Trim$(Mid$(vgMsg$, InStr(vgMsg$, "-") + 1))
            Else
               CErr.NumErro = 3800
               CErr.Description = vgMsg$
               CErr.Mensagem = vgMsg$
            End If
            If vgColumn <> -1 Then
               CErr.OcultarDetalhe = True
               CErr.Show Informa                                  'mostra mensagem do erro
               PosicionaSelect
            Else
               CErr.Show                                          'mostra mensagem do erro
               txtCampo.SetFocus
            End If
         End If
      End If
      vgRetVal = Not vgValid                                      'verifica se pode ou não cancelar
   End If
   If Not vgRetVal Or vgRefresh Then
      If Terminate And vgHasChanged Then
         RaiseEvent CancelEdit(SelectedItem)
      End If
      If Terminate Or vgRefresh Then
         EndEditGrid = False
         vgColEditing = -1
         vgRowEditing = -1
         vgChanged = vgHasChanged
         vgIsPreEditing = False
         vgHasChanged = False
         picEdit.Visible = False
         If Not Terminate Then
            txtCampo.Visible = False
         End If
         If vgChanged Then
            Call RefreshStatus
         End If
         If Not Save Then
            Call ClearColumnDefinition
         End If
         If vgRefresh Then
            ReBind
         End If
         Repaint -1
      End If
   End If
   EndEditGrid = vgRetVal
End Function

Private Sub PosicionaSelect()
   Dim vgRow As Long, Rc As RECT, RcCol As RECT, j As Long, vgChangePos As Boolean, vgColor As Long
   Static vgPosSelect As Boolean

   On Error GoTo DeuErro
   
   If vgPosSelect Then Exit Sub                   'se está em modo freeze, não posiciona agora...

   vgPosSelect = True

   vgRow = SelectedItem
   
   If (vgFullRowSelect Or vgColAtual <> -1) And vgRow <> -1 And (vgInternalLst Or (vgTabela.AsyncComplete And Len(vgTabela.RsSource) > 0)) And Not vgHideSelect And Not picFundo.Visible Then

      'vamos posicionar controle
      Rc.Left = 0: Rc.Right = 0: Rc.Top = 0: Rc.Bottom = 0
      SendMessage hWndLst, LVM_GETITEMRECT, vgRow, Rc 'pega posicionamento do 1º item

      'vamos calcular posicionamento para o edit box
      If Not vgFullRowSelect Then
         Rc.Left = ColumnLeft(vgColAtual)
         Rc.Right = Rc.Left + ColumnWidth(vgColAtual)

         'se não for primeira coluna vamos retirar 1 pixel da caixa de texto...
         If vgColAtual > GetVisibleCol(COL_FIRST) Then
            Rc.Left = Rc.Left + vgTpX
         End If
   
      ElseIf Not vgHideLeftBar Then
         Rc.Left = Rc.Left * vgTpX + vgLeftBarWidth
         Rc.Right = Rc.Right * vgTpX + vgLeftBarWidth
      Else

         
         Rc.Left = Rc.Left * vgTpX
         Rc.Right = Rc.Right * vgTpX
      End If

      'não vamos deixar a caixa de texto passar sobre o scroll quando a coluna não estiver inteiramente visível... (tem scroll vertical)
      If FirstItemVisible <> 0 Or LastItemVisible < vgNumItemsTot - 1 Then
         If Rc.Right > UserControl.ScaleWidth - (GetSystemMetrics(SM_CXVSCROLL) * vgTpX) Then
            Rc.Right = UserControl.ScaleWidth - (GetSystemMetrics(SM_CXVSCROLL) * vgTpX)
         End If
      End If

      j = HeaderHeightFull
      If vgShowFilterBar Then
         j = j + vgFilterBarHeight
      End If
      j = j + (Rc.Top * vgTpY) - 2 * vgTpX
      Rc.Bottom = j + (Rc.Bottom - Rc.Top - 1) * vgTpY
      Rc.Top = j

      'vamos ver se mudou posição ou tamanho
      vgChangePos = vgForcePosSel
      If Not vgChangePos Then
         If (Rc.Right - Rc.Left) > 0 Then
            vgChangePos = picSel.Left <> Rc.Left Or picSel.Top <> Rc.Top Or picSel.Width <> (Rc.Right - Rc.Left) Or picSel.Height <> (Rc.Bottom - Rc.Top)
         Else
            vgChangePos = picSel.Left <> Rc.Left Or picSel.Top <> Rc.Top Or picSel.Width <> 0 Or picSel.Height <> (Rc.Bottom - Rc.Top)
         End If
      End If
      
      If vgChangePos Then
         vgForcePosSel = False
   
         'força o foco na PicSel
         If vgComFoco <> 0 And Not vgInFilter And picSel.Visible And Not vgIsPreEditing Then
            vgForcePicSel = True
            picSel.SetFocus                           'vamos colocar o foco na picSel para que ele não seja mandado para nenhum outro controle
            vgForcePicSel = False
         End If
   
         'vamos ocultar a picedit até o fim do posicionamento
         If (vgIsPreEditing Or vgHasChanged) Then
            If vgColEditing <> vgColAtual Or vgRowEditing <> vgRow Then
               picEdit.Visible = False
            End If
         Else
            picEdit.Visible = False
         End If
   
         'posiciona o picturebox
         If (Rc.Right - Rc.Left) > 0 Then
            picSel.Move Rc.Left, Rc.Top, (Rc.Right - Rc.Left), (Rc.Bottom - Rc.Top)
         Else
            picSel.Move Rc.Left, Rc.Top, 0, (Rc.Bottom - Rc.Top)
         End If
         
         If Not vgFullRowSelect And (vgIsPreEditing Or vgHasChanged) Then
            DefineCampo
         End If
      End If
      If Not vgFullRowSelect Then
         DrawColumnContent vgColAtual, -1, 0
      Else
         For j = 1 To vgColumns.Count
            DrawColumnContent j, -1, 0
         Next
      End If
   Else
      picSel.Move -240, -240, 30, 30
   End If
   vgPosSelect = False
   Exit Sub
   
DeuErro:
   vgPosSelect = False
End Sub

Private Sub GetGridColumnLockedEnabled(ByVal vgRow As Long, ByVal ColDef As Integer, ByRef ColEnabled As Boolean, ByRef ColLocked As Boolean)
   If vgRow = -1 Then vgRow = SelectedItem
   ColEnabled = True
   ColLocked = vgColDefinitions(ColDef).Locked
   RaiseEvent GetTextEnable(vgRow, ColDef, ColEnabled)
   If ColEnabled And Not ColLocked Then
      If Len(vgColumns(ColDef).NameFilter) > 0 And Len(vgSQLOrig$) > 0 And ((vgAllowEdit And vgAllowEditDatabase) Or (vgAllowInsert And vgAllowInsertDatabase And vgRow = vgNumItemsTot - 1)) Then
         ColLocked = Not vgTabela.EditableField(vgColumns(ColDef).Name)
         If Not ColLocked Then
            RaiseEvent GetColumnLocked(vgRow, ColDef, GetNewCols, vgColDefinitions(ColDef).txtCampo, ColLocked)
         End If
      Else
         ColLocked = True
      End If
   End If
   vgColDefinitions(ColDef).TemporaryLocked = ColLocked
End Sub

'define as propriedades de cada coluna da barra de filtro do grid
Private Sub DefineCampoFilter(vgIndCol As Integer)
   Set txtCampoFilter(vgIndCol).CtPri = txtFilter(vgIndCol)
   txtCampoFilter(vgIndCol).InFilter = True                    'indicando à GMask que será usado para filtragem para permitir o "*" em campo numérico
   
   'definições de combos para Listas Internas
   If Len(vgColDefinitions(vgIndCol).ComboFieldsList) > 0 Then
      txtCampoFilter(vgIndCol).DataBase = vgDb(vgColDefinitions(vgIndCol).ComboDataBase)
      txtCampoFilter(vgIndCol).ListFields = vgColDefinitions(vgIndCol).ComboFieldsList
      txtCampoFilter(vgIndCol).BoundColumn = vgColDefinitions(vgIndCol).ComboFieldCapture
      txtCampoFilter(vgIndCol).ShowFields = vgColDefinitions(vgIndCol).ComboFieldsShow
      txtCampoFilter(vgIndCol).Filter = vgColDefinitions(vgIndCol).ComboFieldsFilter
      txtCampoFilter(vgIndCol).OrderFields = vgColDefinitions(vgIndCol).ComboFieldsOrder
      txtCampoFilter(vgIndCol).Source = vgColDefinitions(vgIndCol).ComboTable
   End If
   
   'vamos tratar o campo conforme o tipo de dado
   If vgColumns(vgIndCol).ColumnType = TP_MEMO Then
      txtCampoFilter(vgIndCol).DataType = TP_CARACTER
   Else
      txtCampoFilter(vgIndCol).DataType = vgColumns(vgIndCol).ColumnType
   End If
   
   'definir que pode ser digitado qualquer texto nas comboboxes
   txtCampoFilter(vgIndCol).AllowAnyText = True
   
   'aplicando a máscara
   txtCampoFilter(vgIndCol).Mask = vgColumns(vgIndCol).Mask    'definindo a máscara conforme definição da coluna
   txtCampoFilter(vgIndCol).Max = vgColumns(vgIndCol).Size     'definindo o tamanho do campo conforme definição da coluna
   
   'definição do StuffChar
   If vgColumns(vgIndCol).ColumnType = TP_CARACTER Then
      If Len(txtCampoFilter(vgIndCol).Mask) > 0 And txtCampoFilter(vgIndCol).Mask = String$(Len(txtCampoFilter(vgIndCol).Mask), "9") Then 'se máscara tudo 9
         txtCampoFilter(vgIndCol).StuffChar = "0"   'ajusta com 0 a esquerda
      ElseIf Len(txtCampoFilter(vgIndCol).Mask) > 0 And txtCampoFilter(vgIndCol).Mask = String$(Len(txtCampoFilter(vgIndCol).Mask), "#") Then 'se máscara tudo #
         txtCampoFilter(vgIndCol).StuffChar = " "   'ajusta com brancos a esquerda
      Else                                          'caso contrario
         txtCampoFilter(vgIndCol).StuffChar = ""    'não ajusta a esquerda
      End If
   Else
      txtCampoFilter(vgIndCol).StuffChar = ""       'não ajusta a esquerda
   End If
   
End Sub

'seta definições de máscara, tipo e tamanho para o editbox e também posicionamento
Private Sub DefineCampo(Optional ByVal vgIndFilter As Integer = -1)
   Dim txtCp As FormataCampos                     'usada para definir a formatação da célula em edição no grid
   Dim vgIndCol As Long, vgTpCp As Integer, Rc As RECT, vgRow As Long, j As Long, _
       RcCol As RECT, vgTopTxt As Single, vgColEnabled As Boolean, vgColumnLocked As Boolean, vgSoPos As Boolean, _
       w As Long, vgFilter As String, vgHasBut As Boolean
   Dim vgShowFields() As String                   'armazena a lista com as colunas da combobox

   vgInternalLst = False
   If vgIndFilter = -1 Then
      vgIndCol = vgColAtual

      vgSoPos = True
      vgRow = SelectedItem

      If vgColEditing = vgColAtual And vgRowEditing = vgRow Then GoTo Posiciona

      vgSoPos = False

      'está mudando a coluna atual
      If vgColEditing <> vgColAtual And Not txtCampo Is Nothing And vgHasChanged Then
         txtCampo.LostFocus                       'vamos forçar formatação com máscara
      End If

      If picEdit.Visible Then
         vgPriVez = vgPriVez + 1
         txtCampo.Text = ""
         vgPriVez = vgPriVez - 1
      End If

      vgIsPreEditing = True
      vgColEditing = vgColAtual
      vgRowEditing = vgRow
   Else
      vgIndCol = vgIndFilter
      vgColAtual = vgIndCol
   End If
   
   Set txtCp = txtCampo

   If vgColumns(vgIndCol).ColumnType <> TP_LOGICO Then
      If vgIndFilter = -1 Then
         GetGridColumnLockedEnabled vgRow, vgIndCol, vgColEnabled, vgColumnLocked

         If txtCampo Is Nothing Then
            Set txtCampo = New FormataCampos
            txtCampo.Visible = True
         End If
         
         If vgColumns(vgIndCol).ColumnType = TP_MEMO Then
            txtEdit.Visible = False
            Set txtCampo.CtPri = txtEditMult
         Else
            txtEditMult.Visible = False
            Set txtCampo.CtPri = txtEdit
         End If

         'definição do extensor de "Ação do clique"
         vgHasBut = False
         If Val(vgColDefinitions(vgIndCol).ActionButtonExtensor) = 0 Then 'se tem extensor de ação no clique
            If Not vgColDefinitions(vgIndCol).txtCampo Is Nothing Then
               If Not vgColDefinitions(vgIndCol).txtCampo.CtBot(BOT_ACAO) Is Nothing Then
                  vgHasBut = True
               End If
            End If
         End If
         If Val(vgColDefinitions(vgIndCol).ActionButtonExtensor) > 0 Or vgHasBut Then 'se tem extensor de ação no clique
            If Not HasBotCp(BOT_ACAO) Then Call GetBotCp(BOT_ACAO)                    'se não tem botão ainda, define o botão
            bottxtCampo(BOT_ACAO).Visible = True                                      'mostrar o botão
            Set txtCampo.CtBot(BOT_ACAO) = bottxtCampo(BOT_ACAO)                      'vincula o botão ao campo
            If vgHasBut Then
               Set bottxtCampo(BOT_ACAO).Picture = vgColDefinitions(vgIndCol).txtCampo.CtBot(BOT_ACAO).Picture
               bottxtCampo(BOT_ACAO).Caption = vgColDefinitions(vgIndCol).txtCampo.CtBot(BOT_ACAO).Caption
            Else
               If Val(vgColDefinitions(vgIndCol).ActionButtonExtensor) <= 2 Then      'se o extensor é dropdown ou reticências, define imagem correspondente
                  Set bottxtCampo(BOT_ACAO).Picture = LoadPicture(LoadGasPicture(2 + Val(vgColDefinitions(vgIndCol).ActionButtonExtensor)))
                  bottxtCampo(BOT_ACAO).Caption = ""
               Else                               'se letras, coloca a letra no caption do botão
                  Set bottxtCampo(BOT_ACAO).Picture = LoadPicture("")
                  bottxtCampo(BOT_ACAO).Caption = Chr$(62 + Val(vgColDefinitions(vgIndCol).ActionButtonExtensor))
               End If
            End If
         ElseIf HasBotCp(BOT_ACAO) Then
            bottxtCampo(BOT_ACAO).Visible = False
            Set txtCampo.CtBot(BOT_ACAO) = Nothing
         End If

         'definição do extensor de "Lista (pesquisa)"
         vgHasBut = False
         If Val(vgColDefinitions(vgIndCol).PesqExtensor) = 0 Then 'se tem extensor de ação no clique
            If Not vgColDefinitions(vgIndCol).txtCampo Is Nothing Then
               If Not vgColDefinitions(vgIndCol).txtCampo.CtBot(BOT_LISTA) Is Nothing Then
                  vgHasBut = True
               End If
            End If
         End If
         If Val(vgColDefinitions(vgIndCol).PesqExtensor) > 0 Or vgHasBut Then 'se tem pesquisa
            vgColDefinitions(vgIndCol).PesqSQLExpression = ""
            RaiseEvent GetColumnSQLSearch(vgIndCol, GetNewCols(), vgColDefinitions(vgIndCol).PesqSQLExpression)
            If Len(vgColDefinitions(vgIndCol).PesqSQLExpression) > 0 Then
               If Not HasBotCp(BOT_LISTA) Then Call GetBotCp(BOT_LISTA)       'se não tem botão ainda, define o botão
               bottxtCampo(BOT_LISTA).Visible = True                          'mostrar o botão
               Set txtCampo.CtBot(BOT_LISTA) = bottxtCampo(BOT_LISTA)         'vincula o botão ao campo
               If vgHasBut Then
                  Set bottxtCampo(BOT_LISTA).Picture = vgColDefinitions(vgIndCol).txtCampo.CtBot(BOT_LISTA).Picture
                  bottxtCampo(BOT_LISTA).Caption = vgColDefinitions(vgIndCol).txtCampo.CtBot(BOT_LISTA).Caption
               Else
                  If Val(vgColDefinitions(vgIndCol).PesqExtensor) > 0 Then    'se tem extensor de pesquisa
                     If Val(vgColDefinitions(vgIndCol).PesqExtensor) <= 2 Then 'se o extensor é dropdown ou reticências, define imagem correspondente
                        Set bottxtCampo(BOT_LISTA).Picture = LoadPicture(LoadGasPicture(2 + Val(vgColDefinitions(vgIndCol).PesqExtensor)))
                        bottxtCampo(BOT_LISTA).Caption = ""
                     Else                         'se letras, coloca a letra no caption do botão
                        Set bottxtCampo(BOT_LISTA).Picture = LoadPicture("")
                        bottxtCampo(BOT_LISTA).Caption = Chr$(62 + Val(vgColDefinitions(vgIndCol).PesqExtensor))
                     End If
                  End If
               End If
            End If
         ElseIf HasBotCp(BOT_LISTA) Then
            bottxtCampo(BOT_LISTA).Visible = False
            Set txtCampo.CtBot(BOT_LISTA) = Nothing
         End If
         
         'definição do extensor de "Lista (combo-box)"
         vgHasBut = False
         If Val(vgColDefinitions(vgIndCol).ComboExtensor) = 0 Then 'se tem extensor de ação no clique
            If Not vgColDefinitions(vgIndCol).txtCampo Is Nothing Then
               If Not vgColDefinitions(vgIndCol).txtCampo.CtBot(BOT_COMBO) Is Nothing Then
                  vgHasBut = True
               End If
            End If
         End If
         If (Val(vgColDefinitions(vgIndCol).ComboExtensor) > 0 And ((Len(vgColDefinitions(vgIndCol).ComboTable) > 0 Or Len(vgColDefinitions(vgIndCol).ComboFieldsList) > 0))) Or vgHasBut Then
            If Not HasBotCp(BOT_COMBO) Then Call GetBotCp(BOT_COMBO) 'se não tem botão ainda, define o botão
            bottxtCampo(BOT_COMBO).Visible = True                    'mostrar o botão
            Set txtCampo.CtBot(BOT_COMBO) = bottxtCampo(BOT_COMBO)   'vincula o botão ao campo
            If vgHasBut Then
               Set bottxtCampo(BOT_COMBO).Picture = vgColDefinitions(vgIndCol).txtCampo.CtBot(BOT_COMBO).Picture
               bottxtCampo(BOT_COMBO).Caption = vgColDefinitions(vgIndCol).txtCampo.CtBot(BOT_COMBO).Caption
            Else
               If Val(vgColDefinitions(vgIndCol).ComboExtensor) > 0 Then 'se tem extensor de combo-box
                  If Val(vgColDefinitions(vgIndCol).ComboExtensor) <= 2 Then 'se o extensor é dropdown ou reticências, define imagem correspondente
                     Set bottxtCampo(BOT_COMBO).Picture = LoadPicture(LoadGasPicture(2 + Val(vgColDefinitions(vgIndCol).ComboExtensor)))
                     bottxtCampo(BOT_COMBO).Caption = ""
                  Else                            'se letras, coloca a letra no caption do botão
                     Set bottxtCampo(BOT_COMBO).Picture = LoadPicture("")
                     bottxtCampo(BOT_COMBO).Caption = Chr$(62 + Val(vgColDefinitions(vgIndCol).ComboExtensor))
                  End If
               End If
            End If
         ElseIf HasBotCp(BOT_COMBO) Then
            bottxtCampo(BOT_COMBO).Visible = False
            Set txtCampo.CtBot(BOT_COMBO) = Nothing
         End If

      Else

         'se for Lista Interna, vamos exibir o botão da combobox
         If Len(vgColDefinitions(vgIndCol).ComboFieldsList) > 0 Then
            botFilter(vgIndCol).Visible = True
            Set txtCampoFilter(vgIndCol).CtBot(BOT_COMBO) = botFilter(vgIndCol)
            Set botFilter(vgIndCol).Picture = LoadPicture(LoadGasPicture(3))
         ElseIf vgColumns(vgIndCol).ColumnType = TP_DATA_HORA And InStr(vgColumns(vgIndCol).Mask, "/") > 0 Then
            botFilter(vgIndCol).Visible = True
            Set txtCampoFilter(vgIndCol).CtBot(BOT_ACAO) = botFilter(vgIndCol)
            Set botFilter(vgIndCol).Picture = LoadPicture(LoadGasPicture(4))
         Else
            botFilter(vgIndCol).Visible = False
            Set txtCampoFilter(vgIndCol).CtBot(BOT_COMBO) = Nothing
         End If
      End If

      vgPriVez = vgPriVez + 1

      'definições da "Lista (pesquisa)"
      If Len(vgColDefinitions(vgIndCol).PesqSQLExpression) > 0 Then
         txtCampo.PesqFieldCapture = vgColDefinitions(vgIndCol).PesqFieldCapture
         txtCampo.PesqSQLExpression = vgColDefinitions(vgIndCol).PesqSQLExpression
         txtCampo.PesqBD = vgColDefinitions(vgIndCol).PesqBD
         txtCampo.PesqModoAbertura = vgColDefinitions(vgIndCol).PesqModoAbertura
      Else
         txtCampo.PesqFieldCapture = ""
         txtCampo.PesqSQLExpression = ""
         txtCampo.PesqBD = ""
         txtCampo.PesqModoAbertura = PESQ_MODO_JANELA
      End If

      'definições da "Lista (combo-box)"
      If (Len(vgColDefinitions(vgIndCol).ComboTable) > 0 Or Len(vgColDefinitions(vgIndCol).ComboFieldsList) > 0) Then
         vgFilter = vgColDefinitions(vgIndCol).ComboFieldsFilter

         'se não é lista interna
         If Not (Len(vgColDefinitions(vgIndCol).ComboTable) = 0 And Len(vgColDefinitions(vgIndCol).ComboFieldsList) > 0) Then
            RaiseEvent GetColumnFilter(vgIndCol, GetNewCols(), vgFilter)
         End If
         txtCampo.DataBase = vgDb(vgColDefinitions(vgIndCol).ComboDataBase)
         txtCampo.ListFields = vgColDefinitions(vgIndCol).ComboFieldsList
         txtCampo.BoundColumn = vgColDefinitions(vgIndCol).ComboFieldCapture
         txtCampo.ShowFields = vgColDefinitions(vgIndCol).ComboFieldsShow
         txtCampo.Filter = vgFilter
         txtCampo.OrderFields = vgColDefinitions(vgIndCol).ComboFieldsOrder
         txtCampo.Source = vgColDefinitions(vgIndCol).ComboTable
      Else
         txtCampo.ListFields = ""
         txtCampo.BoundColumn = ""
         txtCampo.ShowFields = ""
         txtCampo.Filter = ""
         txtCampo.OrderFields = ""
         txtCampo.Source = ""
      End If

      'definições gerais para os campos
      vgTpCp = PegaTipoMask(vgColumns(vgIndCol).ColumnType)
      txtCp.DataType = vgTpCp
      txtCp.Mask = vgColumns(vgIndCol).Mask

      If Len(vgColDefinitions(vgIndCol).ComboTable) = 0 Then
         If Len(vgColDefinitions(vgIndCol).ComboFieldsList) = 0 Then
            Select Case vgColumns(vgIndCol).ColumnType
               Case TP_CARACTER                   'se for tipo texto
                  txtCp.MaxLength = vgColumns(vgIndCol).Size
               Case TP_MEMO                       'se for memo
                  txtCp.MaxLength = 0
            End Select
         Else
            txtCp.Alignment = vbLeftJustify
         End If
         If vgColumns(vgIndCol).ColumnType = TP_CARACTER Then
            If Len(txtCp.Mask) > 0 And txtCp.Mask = String$(Len(txtCp.Mask), "9") Then 'se máscara tudo 9
               txtCp.StuffChar = "0"              'ajusta com 0 a esquerda
            ElseIf Len(txtCp.Mask) > 0 And txtCp.Mask = String$(Len(txtCp.Mask), "#") Then 'se máscara tudo #
               txtCp.StuffChar = " "              'ajusta com brancos a esquerda
            Else                                  'caso contrario
               txtCp.StuffChar = ""               'não ajusta a esquerda
            End If
         Else
            txtCp.StuffChar = ""                  'não ajusta a esquerda
         End If
      Else
         If vgColumns(vgIndCol).ColumnType <> TP_NUMERICO Then
            txtCp.MaxLength = 0
            txtCp.Mask = ""
            txtCp.StuffChar = ""                  'ajusta com brancos a esquerda
            vgColDefinitions(vgIndCol).Alignment = vbLeftJustify
         Else
            vgShowFields = Split(vgColDefinitions(vgIndCol).ComboFieldsList, ";") 'vamos pegar a lista de colunas de combobox
            If BancoDeCampos(vgShowFields(0)).ColumnType = TP_NUMERICO Then       'se a primeira coluna da combobox é numérica
               vgColDefinitions(vgIndCol).Alignment = vbRightJustify              'vamos alinhar à direita
            Else                                  'senão, se é caracter
               vgColDefinitions(vgIndCol).Alignment = vbLeftJustify 'vamos alinhar à esquerda
            End If
         End If
      End If
      txtCp.Alignment = vgColDefinitions(vgIndCol).Alignment        'define o alinhamento do campo
      If vgIndFilter = -1 Then
         txtCampo.Value = GetColumnRs(vgRow, vgIndCol)
         txtCampo.Text = GetColumnText(vgRow, vgIndCol)
         txtCampo.SelStart = 0
         txtCampo.SelLength = Len(txtCampo.Text)
         picEdit.BackColor = vgEditBackColor
         txtCampo.BackColor = vgEditBackColor
         txtCampo.ForeColor = vgEditTextColor
      End If
      vgPriVez = vgPriVez - 1
   Else
      vgPriVez = vgPriVez + 1
      'prepara campo para filtragem de colunas do tipo lógico
      vgPriVez = vgPriVez - 1
   End If

Posiciona:

   If vgIndFilter = -1 Then
      If vgColumns(vgIndCol).ColumnType <> TP_LOGICO Then
         picEdit.Move 2 * vgTpX, 2 * vgTpY, ColumnWidth(vgIndCol) - 4 * vgTpX, picSel.Height - 4 * vgTpY

         'vamos corrigir posicionamento com algumas altura "quebradas"
         vgTopTxt = 0

         'para a primeira coluna há desconto de 1 pixel
         txtCampo.Left = 2 * vgTpX
         txtCampo.Top = vgTopTxt
         txtCampo.Height = picEdit.Height                           ' (Rc.Bottom - Rc.Top)
         w = picEdit.ScaleWidth - 3 * vgTpX
         If w > 0 Then
            txtCampo.Width = w
         End If
         txtCampo.Left = txtCampo.Left                              'força reposicionamento dos botões dentro do controle
         
         If Not picEdit.Visible Then picEdit.Visible = True

         txtCampo.Visible = True
         txtCampo.ZOrder 0

         If Not vgSoPos Then
            txtCampo.Enabled = vgColEnabled
            txtCampo.Locked = vgColumnLocked Or vgLocked Or (vgColumns(vgIndCol).ColumnType = TP_BINARIO)
         End If

         If txtCampo.Enabled And ParentIsFocused And vgComFoco = 1 And Not vgInFilter Then
            txtCampo.SetFocus
         End If
      Else
         picEdit.Move -300, -300, 30, 30
         picEdit.Visible = True
         If ParentIsFocused And vgComFoco = 1 And Not vgInFilter Then
            picEdit.SetFocus
         End If
      End If
   End If
   Set txtCp = Nothing
   Exit Sub
   
   Resume
DeuErro:
   
End Sub

Private Function GetEditCurrentLine() As Long
   GetEditCurrentLine = SendMessage(txtEditMult.hWnd, EM_LINEFROMCHAR, -1, ByVal 0&) + 1
End Function

Private Function GetEditCountLine() As Long
   GetEditCountLine = SendMessage(txtEditMult.hWnd, EM_GETLINECOUNT, 0, ByVal 0&)
End Function

Public Function GetVisibleCol(ByVal vgCol As gVisibleCols, Optional ByVal vgColRef As Integer, Optional ByVal vgSkipLocked As Boolean) As Integer
   Dim i As Integer, ColDef As Integer, RetVal As Integer, vgColEnabled As Boolean, vgColLocked As Boolean, vgTempCol As Long
   Select Case vgCol
      Case COL_FIRST                                    'pega primeira coluna visível
         RetVal = -1
         vgTempCol = -1
         For i = 1 To vgColumns.Count
            ColDef = GetColumnByPosition(i)
            If Not vgColumns(ColDef).Hidden And ColumnWidth(ColDef) > 0 Then
               If vgTempCol = -1 Then vgTempCol = ColDef
               If vgSkipLocked Then
                  GetGridColumnLockedEnabled SelectedItem, ColDef, vgColEnabled, vgColLocked
                  If Not vgColLocked And vgColEnabled Then
                     RetVal = ColDef
                     Exit For
                  End If
               Else
                  RetVal = ColDef
                  Exit For
               End If
            End If
         Next
         If RetVal = -1 And vgTempCol <> -1 Then
            RetVal = vgTempCol
         End If
      Case COL_NEXT
         RetVal = -1
         If vgColRef <> 0 Then
            For i = vgColDefinitions(vgColRef).Position + 1 To vgColumns.Count
               ColDef = GetColumnByPosition(i)
               If Not vgColumns(ColDef).Hidden And ColumnWidth(ColDef) > 0 Then
                  If vgSkipLocked Then
                     GetGridColumnLockedEnabled SelectedItem, ColDef, vgColEnabled, vgColLocked
                     If Not vgColLocked And vgColEnabled Then
                        RetVal = ColDef
                        Exit For
                     End If
                  Else
                     RetVal = ColDef
                     Exit For
                  End If
               End If
            Next
         Else
            RetVal = GetVisibleCol(COL_FIRST)
         End If
      Case COL_PREVIOUS
         If vgColRef <> 0 Then
            RetVal = -1
            For i = vgColDefinitions(vgColRef).Position - 1 To 1 Step -1
               ColDef = GetColumnByPosition(i)
               If Not vgColumns(ColDef).Hidden And ColumnWidth(ColDef) > 0 Then
                  If vgSkipLocked Then
                     GetGridColumnLockedEnabled SelectedItem, ColDef, vgColEnabled, vgColLocked
                     If Not vgColLocked And vgColEnabled Then
                  RetVal = ColDef
                  Exit For
               End If
                  Else
                     RetVal = ColDef
                     Exit For
                  End If
               End If
            Next
         Else
            RetVal = GetVisibleCol(COL_FIRST)
         End If
      Case COL_LAST                                     'pega última coluna visível
         RetVal = -1
         vgTempCol = -1
         For i = vgColumns.Count To 1 Step -1
            ColDef = GetColumnByPosition(i)
            If Not vgColumns(ColDef).Hidden And ColumnWidth(ColDef) > 0 Then
               If vgTempCol = -1 Then vgTempCol = ColDef
               If vgSkipLocked Then
                  GetGridColumnLockedEnabled SelectedItem, ColDef, vgColEnabled, vgColLocked
                  If Not vgColLocked And vgColEnabled Then
                     RetVal = ColDef
                     Exit For
                  End If
               Else
               RetVal = ColDef
               Exit For
            End If
            End If
         Next
         If RetVal = -1 And vgTempCol <> -1 Then
            RetVal = vgTempCol
         End If
   End Select
   GetVisibleCol = RetVal
End Function

'Rotina para tratamento das teclas de função do GRID
'CUIDADO: ROTINA MANUAL
'PROPOSITO: Como eu coloquei pro grid entrar em modo de digitação quando receber foco, entao eu tive que mudar uma linha para poder excluir o registro
Private Function TrataTeclaGrid(ByRef KeyCode As Long, ByVal Shift As Long) As Boolean
   Dim Cancel As Boolean, vgRow As Long, vgEnter As Boolean, vgAdd As Boolean, vgNav As GRID_NAVIGATION, Ok As Boolean, IsBoolean As Boolean, vgValidCol As Boolean, vgColEnabled As Boolean, vgColLocked As Boolean, vgNewCol As Integer, vgChanged As Boolean
   Cancel = False
   vgRow = SelectedItem
   vgChanged = vgHasChanged
   If vgAllowInsert And (Not vgInternalLst Or vgAllowInsertDatabase) And vgRow = vgNumItemsTot - 1 And vgChanged Then     'está incluindo
      vgAdd = True
   Else
      vgAdd = False
   End If
   Ok = True
   If vgColAtual <> -1 Then
      If vgColumns(vgColAtual).ColumnType = TP_MEMO And vgColDefinitions(vgColAtual).Changed And txtEditMult.SelLength < Len(txtEditMult.Text) Then 'vamos deixar ENTER operar livremente dentro do memo só se já tiver mudado seu conteúdo
         Ok = False
      End If
   End If
   If KeyCode = vbKeyReturn And Ok Then
      If vgChanged Or vgIsPreEditing Then
         vgEnter = True
      End If
      If vgEnter Then
         If (vgAdd And vgNavigationAddMode = GRID_NAVIGATION_AUTO) Or (Not vgAdd And vgNavigationEditNavigation = GRID_NAVIGATION_AUTO) Then
            vgNav = vgNavigation
         Else
            If vgAdd Then
               vgNav = vgNavigationAddMode
            Else
               vgNav = vgNavigationEditNavigation
            End If
         End If
         Select Case vgNav
            Case GRID_NAVIGATION_LEFT
               KeyCode = vbKeyLeft
            Case GRID_NAVIGATION_RIGHT
               KeyCode = vbKeyRight
            Case GRID_NAVIGATION_UP
               KeyCode = vbKeyUp
            Case GRID_NAVIGATION_DOWN
               KeyCode = vbKeyDown
         End Select
      End If
   End If
   
   'vamos ignorar essas teclas... (CTRL+ESPAÇO também... faz com que o selectecitem seja o -1 :&)
   If ((Not vgFullRowSelect And vgColAtual = -1) Or SelectedItem = -1 Or (KeyCode = vbKeySpace And Shift = 2)) And KeyCode <> vbKeyDelete And KeyCode <> 16 And KeyCode <> 17 And KeyCode <> 18 Then
      vgIgnoreKey = KeyCode
      TrataTeclaGrid = True
      Exit Function
   End If
   
   Select Case KeyCode
      Case vbKeyHome
         If (vgChanged Or vgIsPreEditing) Then
            If vgColAtual <> GetVisibleCol(COL_FIRST) And Shift = 2 Then   'CTRL+HOME (vamos para primeira coluna)
               Cancel = False
               If vgChanged Then
                  Cancel = ValidateColumnGrid()
               End If
               If Not Cancel Then
                  vgColAtual = GetVisibleCol(COL_FIRST, , vgChanged)
                  AdjustColumn
               End If
            End If
            Cancel = True                                                  'ignora o home no grid
         ElseIf Shift = 2 Then
            vgColAtual = GetVisibleCol(COL_FIRST)
            AdjustColumn
            Cancel = True
         End If
      Case vbKeyEnd
         If (vgChanged Or vgIsPreEditing) Then
            If vgColAtual <> GetVisibleCol(COL_LAST) And Shift = 2 Then    'CTRL+END (vamos para última coluna)
               Cancel = False
               If vgChanged Then
                  Cancel = ValidateColumnGrid()
               End If
               If Not Cancel Then
                  vgColAtual = GetVisibleCol(COL_LAST, , vgChanged)
                  AdjustColumn
               End If
            End If
            Cancel = True                                                  'ignora o home no grid
         ElseIf Shift = 2 Then
            vgColAtual = GetVisibleCol(COL_LAST)
            AdjustColumn
            Cancel = True
         End If
      Case vbKeyPageDown
         If (vgChanged Or vgIsPreEditing) Then
            Cancel = EndEditGrid(True, False)
         End If
         If SelectedItem = vgNumItemsTot - 1 Then
            Cancel = True
            vgIgnoreKey = KeyCode
         End If
      Case vbKeyPageUp
         If (vgChanged Or vgIsPreEditing) Then
            Cancel = EndEditGrid(True, False)
         End If
         If SelectedItem = 0 Then
            Cancel = True
            vgIgnoreKey = KeyCode
         End If
      Case vbKeyDown
         If vgColumns(vgColAtual).ColumnType = TP_MEMO Then
            If txtEditMult.SelLength = Len(txtEditMult.Text) Then
               txtEditMult.SelLength = 0
               txtEditMult.SelStart = Len(txtEditMult.Text)
               Cancel = True
            Else
               Cancel = (GetEditCurrentLine < GetEditCountLine)
            End If
         ElseIf Val(vgColDefinitions(vgColAtual).ComboExtensor) > 0 And Not vgColumns(vgColAtual).HasChange And vgChanged And Shift = 0 Then
            txtCampo.KeyDown (KeyCode), 0
            Cancel = True
         End If
         If Not Cancel Then
            Cancel = EndEditGrid(True, False)
         End If
         vgIgnoreKey = KeyCode
         If Not Cancel Then
            vgNavigation = GRID_NAVIGATION_DOWN
            If SelectedItem < vgNumItemsTot - 1 Then
               SelecionaItem SelectedItem + 1
            End If
            Cancel = True
         End If
      Case vbKeyUp
         If vgColumns(vgColAtual).ColumnType = TP_MEMO Then
            If txtEditMult.SelLength = Len(txtEditMult.Text) Then
               txtEditMult.SelLength = 0
               Cancel = True
            Else
               Cancel = (GetEditCurrentLine > 1)
            End If
         ElseIf Val(vgColDefinitions(vgColAtual).ComboExtensor) > 0 And Not vgColumns(vgColAtual).HasChange And vgChanged And Shift = 0 Then
            txtCampo.KeyDown (KeyCode), 0
            Cancel = True
         End If
         If Not Cancel Then
            Cancel = EndEditGrid(True, False)
         End If
         vgIgnoreKey = KeyCode
         If Not Cancel Then
            vgNavigation = GRID_NAVIGATION_UP
            If SelectedItem <> 0 Then
               SelecionaItem SelectedItem - 1
            ElseIf vgShowFilterBar Then
               txtFilter(vgColAtual).SetFocus
            End If
            Cancel = True
         End If
      Case vbKeyRight
         If vgColAtual <> -1 Then
            IsBoolean = (vgColumns(vgColAtual).ColumnType = TP_LOGICO)
         Else
            IsBoolean = False
         End If
         If (Not (vgChanged Or vgIsPreEditing) Or vgEnter Or txtCampo.SelStart = Len(txtCampo.Text) Or IsBoolean) Or Shift = 2 Then 'CTRL+RIGHT vai direto para próxima coluna
            If Not vgFullRowSelect Then
               Cancel = False
               vgNewCol = GetVisibleCol(COL_NEXT, vgColAtual, vgChanged)
               If vgNewCol <> -1 Then
                  If vgChanged Then
                     Cancel = ValidateColumnGrid()
                  End If
                  If Not Cancel Then
                     vgColAtual = vgNewCol        'seleciona a próxima coluna editável
                     AdjustColumn
                     vgNavigation = GRID_NAVIGATION_RIGHT
                  End If
               Else
                  If vgChanged Then               'está em edição e última coluna
                     Cancel = EndEditGrid(True, False) 'tenta salvar... sem cancelar edição
                     If Not Cancel Then
                        vgNavigation = GRID_NAVIGATION_RIGHT
                     End If
                  End If
                  If Not Cancel Then
                     If vgRow <> vgNumItemsTot - 1 Then
                        SelecionaItem SelectedItem + 1
                        vgColAtual = GetVisibleCol(COL_FIRST, , vgChanged)
                        AdjustColumn
                     End If
                  End If
               End If
               If Shift = 0 Then                       'se não tiver com CTRL pressionado
                  vgIgnoreKey = vbKeyRight             'ignora o right no edit box (pois se tiver com ele pressionado o KeyRight não chega no edit, então nao precisa setar para ignorar)
               End If
            End If
         End If
         Cancel = True
      Case vbKeyLeft
         If vgColAtual <> -1 Then
            IsBoolean = (vgColumns(vgColAtual).ColumnType = TP_LOGICO)
         Else
            IsBoolean = False
         End If
         If (Not (vgChanged Or vgIsPreEditing) Or vgEnter Or txtCampo.SelStart = Len(txtCampo.Text) Or IsBoolean) Or Shift = 2 Then 'CTRL+LEFT vai direto para coluna anterior
            If Not vgFullRowSelect Then
               Cancel = False
               vgNewCol = GetVisibleCol(COL_PREVIOUS, vgColAtual, vgChanged)
               If vgNewCol <> -1 Then
                  If vgChanged Then
                     Cancel = ValidateColumnGrid()
                  End If
                  If Not Cancel Then
                     vgColAtual = vgNewCol        'seleciona a próxima coluna editável
                     AdjustColumn
                     vgNavigation = GRID_NAVIGATION_LEFT
                  End If
               Else
                  If vgChanged Then               'está em edição e última coluna
                     Cancel = EndEditGrid(True, False) 'tenta salvar... sem cancelar edição
                     If Not Cancel Then
                        vgNavigation = GRID_NAVIGATION_LEFT
                     End If
                  End If
                  If Not Cancel Then
                     If vgRow <> 0 Then
                        vgColAtual = GetVisibleCol(COL_LAST, , vgChanged)
                        SelecionaItem SelectedItem - 1
                        AdjustColumn
                     End If
                  End If
               End If
               If Shift = 0 Then                       'se não tiver com CTRL pressionado
                  vgIgnoreKey = vbKeyLeft              'ignora o left no edit box (pois se tiver com ele pressionado o KeyLeft não chega no edit, então nao precisa setar para ignorar)
               End If
            End If
         End If
         Cancel = True
      Case vbKeyDelete
         'Antes
         'If Not (vgChanged Or vgIsPreEditing) Then
         'Inicio Manual
         If Abs(mdiNFE.ActiveForm.vgSituacao) = ACAO_NAVEGANDO Then
         'Fim Manual
            Call DeleteRows
            Call DeleteCols
            picEdit.SetFocus
            PosicionaSelect
         End If
      Case vbKeyF5
         ReBind
         vgIgnoreKey = vbKeyF5
      Case vbKeyEscape
         DoEvents                                      'esse DoEvents serve apenas para que que o KeyPreview do form container do UserControl deixe o KeyPress processar primeiro lá... isso para que, por exemplo, possamos fazer com o ESC dentro do grid cancela a edição e não feche o form
         If vgChanged Or vgIsPreEditing Then
            Call EndEditGrid(False, True)
            DrawBars                                   'vamos atualizar todas as barras
            Cancel = True
         End If
      Case vbKeyF2, vbKeyReturn
         If Not vgFullRowSelect And Not (vgChanged Or vgIsPreEditing) And vgTabela.AsyncComplete And Not vgLocked Then
            vgIsPreEditing = True
            vgForcePosSel = True
            PosicionaSelect
         End If
      Case vbKeyF3
         If vgShowFilterBar Then
            txtCampoFilter(vgColAtual).SetFocus
         End If
   End Select
   If vgEnter Then
      vgIgnoreKey = vbKeyReturn
   End If

FimDaSub:

   TrataTeclaGrid = Cancel
End Function


Private Sub ChangeCallBackControl()
   
   'subclasse para o user control
   vgSubClass.SubClass UserControl.hWnd, Me
   vgSubClass.AddMessage UserControl.hWnd, WM_NOTIFY, MSG_BEFORE
   vgSubClass.AddMessage UserControl.hWnd, WM_MOUSEMOVE, MSG_AFTER
   vgSubClass.AddMessage UserControl.hWnd, WM_DRAWITEM, MSG_AFTER
   vgSubClass.AddMessage UserControl.hWnd, WM_MEASUREITEM, MSG_BEFORE_AND_AFTER
   vgSubClass.AddMessage UserControl.hWnd, WM_MOUSEWHEEL, MSG_AFTER

End Sub

Private Sub ChangeCallBackLista()
   
   'subclasse para o listview
   vgSubClass.SubClass hWndLst, Me
   vgSubClass.AddMessage hWndLst, WM_LBUTTONDOWN, MSG_BEFORE
   vgSubClass.AddMessage hWndLst, WM_RBUTTONDOWN, MSG_BEFORE_AND_AFTER
   vgSubClass.AddMessage hWndLst, WM_LBUTTONDBLCLK, MSG_BEFORE_AND_AFTER
   vgSubClass.AddMessage hWndLst, WM_RBUTTONDBLCLK, MSG_BEFORE_AND_AFTER
   vgSubClass.AddMessage hWndLst, WM_MOUSEMOVE, MSG_AFTER
   vgSubClass.AddMessage hWndLst, WM_NCMOUSEMOVE, MSG_AFTER
   vgSubClass.AddMessage hWndLst, WM_NOTIFY, MSG_BEFORE_AND_AFTER
   vgSubClass.AddMessage hWndLst, WM_KEYDOWN, MSG_BEFORE
   vgSubClass.AddMessage hWndLst, WM_KEYUP, MSG_BEFORE
   vgSubClass.AddMessage hWndLst, WM_CHAR, MSG_BEFORE
   vgSubClass.AddMessage hWndLst, WM_SETFOCUS, MSG_BEFORE_AND_AFTER
   vgSubClass.AddMessage hWndLst, WM_VSCROLL, MSG_BEFORE_AND_AFTER
   vgSubClass.AddMessage hWndLst, WM_HSCROLL, MSG_BEFORE_AND_AFTER
   vgSubClass.AddMessage hWndLst, WM_PAINT, MSG_AFTER
   
End Sub

Private Sub OrigCallBack()
   vgSubClass.UnSubClass                                         'defaz todas as subclasses
   Set vgSubClass = Nothing
End Sub

Private Sub M_ColOption_Click(Index As Integer)
   If Index <> 4 Then M_ColOption(Index).Checked = Not M_ColOption(Index).Checked
   Select Case Index
      Case 0
         vgColDefinitions(Val(M_MenuCol.Tag)).ShowSum = M_ColOption(Index).Checked
      Case 1
         vgColDefinitions(Val(M_MenuCol.Tag)).ShowMax = M_ColOption(Index).Checked
      Case 2
         vgColDefinitions(Val(M_MenuCol.Tag)).ShowMin = M_ColOption(Index).Checked
      Case 3
         vgColDefinitions(Val(M_MenuCol.Tag)).ShowAvg = M_ColOption(Index).Checked
      Case 5                                               'asc
         DefineOrderColumn Val(M_MenuCol.Tag), IIf(M_ColOption(Index).Checked, 1, 0)
      Case 6                                               'desc
         DefineOrderColumn Val(M_MenuCol.Tag), IIf(M_ColOption(Index).Checked, -1, 0)
   End Select
   If Index = 0 Or Index = 1 Or Index = 2 Or Index = 3 Then
      GetValuesStatus
      Call ApplyFilterAndOrder
   End If
End Sub

Private Sub M_Option_Click(Index As Integer)
   If Index <> 10 Then
      M_Option(Index).Checked = Not M_Option(Index).Checked
      vgPriVez = vgPriVez + 1
      ShowFilterBar = M_Option(2).Checked
      HideStatus = Not M_Option(3).Checked
      ShowSumBar = M_Option(5).Checked
      ShowMaxBar = M_Option(6).Checked
      ShowMinBar = M_Option(7).Checked
      ShowAvgBar = M_Option(8).Checked
      GetValuesStatus
      RemoveInitialTop = M_Option(0).Checked
      vgPriVez = vgPriVez - 1
      Call SetStyle
   End If
End Sub

Private Sub M_Special_Click(Index As Integer)
   If Index <> 6 Then                             'se não é a opção de restaurar grid
      M_Special(Index).Checked = Not M_Special(Index).Checked
   Else
      RestoreOriginalGrid
   End If
   Stripes = M_Special(0).Checked
   SaveGridBars = M_Special(2).Checked
   SaveGridCols = M_Special(3).Checked
   SaveGridStripes = M_Special(4).Checked
End Sub

Private Sub picBarra_Click()
   Dim pt As POINTAPI
   If vgShowFilterBar Then
      GetCursorPos pt
      ScreenToClient picBarra.hWnd, pt
      If pt.y < vgFilterBarHeight / vgTpY Then
         ApplyFilterAndOrder
      End If
   End If
End Sub

Private Sub picBarra_DblClick()
   If GetShiftKeys = 0 Then
      vgRowsSelected = ""
      LimpaValueSel
      RowHeight = MinRowHeight
   End If
   ClipCursor ByVal 0
End Sub

Private Sub picBarra_GotFocus()
   picSel.SetFocus
End Sub

Private Sub picBarra_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
   Dim i As Long, Rc As RECT, vgResize As Boolean, Ini As Long, Fim As Long, vgLin As Long, pt As POINTAPI, ItemTop As Long, vgRow As Long, z As String, j As Long, Cancel As Boolean
   vgResize = False
   Ini = FirstItemVisible
   Fim = LastItemVisible
   vgRow = Ini
   For i = Ini To Fim
      Rc.Left = 0: Rc.Right = 0: Rc.Top = 0: Rc.Bottom = 0
      SendMessage hWndLst, LVM_GETITEMRECT, i, Rc              'pega posicionamento do item
      Rc.Bottom = Rc.Bottom * vgTpY
      If vgShowFilterBar Then
         Rc.Bottom = Rc.Bottom + vgFilterBarHeight
      End If
      If y >= Rc.Bottom - 30 And y <= Rc.Bottom + 30 And GetShiftKeys = 0 Then
         vgResize = True
         vgLin = i
      ElseIf y > Rc.Bottom Then                                '- vgRowHeight / vgTpY Then
         vgRow = i + 1
      Else
         Exit For
      End If
   Next
   If vgResize Then
      Rc.Left = 0: Rc.Right = 0: Rc.Top = 0: Rc.Bottom = 0
      SendMessage hWndLst, LVM_GETITEMRECT, vgLin, Rc
      ItemTop = Rc.Top
      vgLinResizing = vgLin + 1
      GetCursorPos pt
      pt.x = picBarra.Width / 2 / vgTpX + 1
      pt.y = Rc.Bottom - 1
      If vgShowFilterBar Then
         pt.y = pt.y + vgFilterBarHeight / vgTpY
      End If
      ClientToScreen picBarra.hWnd, pt
      SetCursorPos pt.x, pt.y
      pt.x = picBarra.Width / 2 / vgTpX
      pt.y = 0
      ClientToScreen picBarra.hWnd, pt
      Rc.Top = pt.y
      Rc.Left = pt.x
      pt.x = picBarra.Width / 2 / vgTpX
      pt.y = picBarra.Height / vgTpY
      ClientToScreen picBarra.hWnd, pt
      Rc.Bottom = pt.y
      Rc.Right = pt.x
      pt.x = 0
      pt.y = (ItemTop + (MinRowHeight / vgTpY) + 1)            'limita movimento na altura mínima de linha
      ClientToScreen hWndLst, pt
      Rc.Top = pt.y
      ClipCursor Rc
      FreezeListView                                           'vamos congelar imagem do listview
   ElseIf vgRow < vgNumItemsTot - 1 + Abs(Not vgAllowInsert) And vgRow <= LastItemVisible And (Not vgShowFilterBar Or y > vgFilterBarHeight) Then
      If vgHasChanged Or vgIsPreEditing Then
         Cancel = EndEditGrid(True, True)
      End If
      If Not Cancel Then
         If GetShiftKeys = 1 And Len(vgRowsSelected) > 0 Then
            z = Mid$(vgRowsSelected, 2)
            j = -1
            Do While Len(z)
               i = Val(Parse$(z$, "|"))
               If i < vgRow And i > j Then
                  j = i
               End If
               Repaint i
            Loop
            If j >= 0 Then
               If Len(vgRowsSelected) = 0 Then vgRowsSelected = vgRowsSelected + "|"
               For i = j To vgRow
                  If InStr(vgRowsSelected, "|" + CStr(i) + "|") = 0 Then
                     vgRowsSelected = vgRowsSelected + CStr(i) + "|"
                     Repaint i
                  End If
               Next
            End If
         Else
            If vgRowsSelected = "|" + CStr(vgRow) + "|" Then
               vgRowsSelected = ""
               LimpaValueSel
            Else
               If SelectedItem <> -1 Or GetShiftKeys <> 2 Then SelecionaItem -1
               If GetShiftKeys <> 2 Then
                  vgRowsSelected = ""
                  LimpaValueSel
               End If
               If InStr(vgRowsSelected, "|" + CStr(vgRow) + "|") > 0 Then
                  vgRowsSelected = Substitui$(vgRowsSelected, "|" + CStr(vgRow) + "|", "|", SO_UM)
               Else
                  If Len(vgRowsSelected) = 0 Then vgRowsSelected = vgRowsSelected + "|"
                  vgRowsSelected = vgRowsSelected + CStr(vgRow) + "|"
               End If
               If Len(vgRowsSelected) = 1 Then
                  vgRowsSelected = ""
                  LimpaValueSel
               End If
            End If
         End If
         vgColAtual = -1
         PosicionaSelect
         GetValuesStatus                                       'Seta Valores escalares para colunas selecionadas
         DrawStatusBar
         Repaint vgRow
      End If
   End If
End Sub

'Vamos limpar valores escalares para as colunas selecionadas
Private Sub LimpaValueSel()
   Dim i As Integer
   For i = 1 To vgColumns.Count
      vgColDefinitions(i).ValueSumSel = 0
      vgColDefinitions(i).ValueMaxSel = 0
      vgColDefinitions(i).ValueMinSel = 0
      vgColDefinitions(i).ValueAvgSel = 0
   Next
End Sub

Private Sub GetValuesStatus(Optional ByVal vgAllRows As Boolean = False)
   Dim vgRows As Variant, i As Long, vgCol As GColumn, vgMax As Long, vgRow As Long, vgInd As Long
   If Len(vgRowsSelected) > 0 Or vgAllRows = True Then
      If Not vgAllRows Then
         vgRows = Split(vgRowsSelected, "|")
         vgMax = UBound(vgRows) - 1
      Else
         vgMax = vgTabela.RecordCount
      End If
      If Not vgAllRows Then LimpaValueSel
      For i = 1 To vgMax
         For Each vgCol In vgColumns
            If vgCol.ColumnType = TP_NUMERICO And Not vgCol.Hidden And (Not vgAllRows Or Len(vgCol.NameFilter) = 0) Then
               vgInd = Val(vgCol.Index)
               If Not vgAllRows Then
                  vgRow = vgRows(i)
               Else
                  vgRow = i - 1
               End If
            
               'Somatorio
               If vgColDefinitions(vgInd).ShowSum Or vgColDefinitions(vgInd).ShowAvg Then
                  If Len(vgCol.NameFilter) = 0 Then
                     If vgAllRows Then
                        vgColDefinitions(vgInd).ValueSum = vgColDefinitions(vgInd).ValueSum + ValBrasil(GetColumnText(vgRow, vgInd))
                     Else
                        vgColDefinitions(vgInd).ValueSumSel = vgColDefinitions(vgInd).ValueSumSel + ValBrasil(GetColumnText(vgRow, vgInd))
                     End If
                  Else
                     vgColDefinitions(vgInd).ValueSumSel = vgColDefinitions(vgInd).ValueSumSel + ColumnValue(vgRow + 1, vgInd)
                  End If
               End If
               
               'Valor Maximo
               If vgColDefinitions(vgInd).ShowMax Then
                  If i = 1 Then
                     If Len(vgCol.NameFilter) = 0 Then
                        If vgAllRows Then
                           vgColDefinitions(vgInd).ValueMax = ValBrasil(GetColumnText(vgRow, vgInd))
                        Else
                           vgColDefinitions(vgInd).ValueMaxSel = ValBrasil(GetColumnText(vgRow, vgInd))
                        End If
                     Else
                        vgColDefinitions(vgInd).ValueMaxSel = ColumnValue(vgRow + 1, vgInd)
                     End If
                  End If
                  If Len(vgCol.NameFilter) = 0 Then
                     If vgAllRows Then
                        vgColDefinitions(vgInd).ValueMax = Maior(vgColDefinitions(vgInd).ValueMax, ValBrasil(GetColumnText(vgRow, vgInd)))
                     Else
                        vgColDefinitions(vgInd).ValueMaxSel = Maior(vgColDefinitions(vgInd).ValueMaxSel, ValBrasil(GetColumnText(vgRow, vgInd)))
                     End If
                  Else
                     vgColDefinitions(vgInd).ValueMaxSel = Maior(vgColDefinitions(vgInd).ValueMaxSel, ColumnValue(vgRow + 1, vgInd))
                  End If
               End If
               
               'Valor Minimo
               If vgColDefinitions(vgInd).ShowMin Then
                  If i = 1 Then
                     If Len(vgCol.NameFilter) = 0 Then
                        If vgAllRows Then
                           vgColDefinitions(vgInd).ValueMin = ValBrasil(GetColumnText(vgRow, vgInd))
                        Else
                           vgColDefinitions(vgInd).ValueMinSel = ValBrasil(GetColumnText(vgRow, vgInd))
                        End If
                     Else
                        vgColDefinitions(vgInd).ValueMinSel = ColumnValue(vgRow + 1, vgInd)
                     End If
                  End If
                  If Len(vgCol.NameFilter) = 0 Then
                     If vgAllRows Then
                        vgColDefinitions(vgInd).ValueMin = Menor(vgColDefinitions(vgInd).ValueMin, ValBrasil(GetColumnText(vgRow, vgInd)))
                     Else
                        vgColDefinitions(vgInd).ValueMinSel = Menor(vgColDefinitions(vgInd).ValueMinSel, ValBrasil(GetColumnText(vgRow, vgInd)))
                     End If
                  Else
                     vgColDefinitions(vgInd).ValueMinSel = Menor(vgColDefinitions(vgInd).ValueMinSel, ColumnValue(vgRow + 1, vgInd))
                  End If
               End If
               
               'Média
               If vgColDefinitions(vgInd).ShowAvg Then
                  If Len(vgCol.NameFilter) = 0 Then
                     If vgAllRows Then
                        vgColDefinitions(vgInd).ValueAvg = vgColDefinitions(vgInd).ValueSum / vgMax
                     Else
                        vgColDefinitions(vgInd).ValueAvgSel = vgColDefinitions(vgInd).ValueSumSel / vgMax
                     End If
                  Else
                     vgColDefinitions(vgInd).ValueAvgSel = (vgColDefinitions(vgInd).ValueSumSel) / vgMax
                  End If
               End If
            
            End If
         Next
      Next
   End If
End Sub

Private Sub picBarra_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
   Dim i As Long, Rc As RECT, vgChangeCursor As Boolean, Ini As Long, Fim As Long, pt As POINTAPI, hPen As Long
   If vgLinResizing = -1 Then
      vgChangeCursor = False
      Ini = FirstItemVisible
      Fim = LastItemVisible
      For i = Ini To Fim                                                  'vamos repintar o fundo para os itens visíveis
         Rc.Left = 0: Rc.Right = 0: Rc.Top = 0: Rc.Bottom = 0
         SendMessage hWndLst, LVM_GETITEMRECT, i, Rc                      'pega posicionamento do item
         Rc.Bottom = Rc.Bottom * vgTpY
         If vgShowFilterBar Then Rc.Bottom = Rc.Bottom + vgFilterBarHeight
         If y >= Rc.Bottom - vgTpY * 2 And y <= Rc.Bottom + vgTpY * 2 And GetShiftKeys = 0 Then
            vgChangeCursor = True
         End If
      Next
      If vgChangeCursor Then
         Set picBarra.MouseIcon = vgCurSizeV
         picBarra.MousePointer = 99
      Else
         SendMessage hWndLst, LVM_GETITEMRECT, Fim, Rc                    'pega posicionamento do item
         If y < vgTpY Or y > Rc.Bottom * vgTpY Or (vgShowFilterBar And y < vgFilterBarHeight) Then
            picBarra.MousePointer = 0
         Else
            Set picBarra.MouseIcon = vgCurSelR
            picBarra.MousePointer = 99
         End If
      End If
   Else
      
      'vamos tirar a sujeira da última linha de resize, se existir...
      Set picFundo.Picture = vgImgFundo
      
      'vamos pintar nova linha de resize
      hPen = CreatePen(2, 1, SysColor(vbBlack))
      hPen = SelectObject(picFundo.hdc, hPen)
      y = y + HeaderHeightFull - vgTpY * 2
      MoveToEx picFundo.hdc, 0, y / vgTpY, pt
      LineTo picFundo.hdc, UserControl.Width / vgTpX, y / vgTpY
      DeleteObject SelectObject(picFundo.hdc, hPen)
      
      'grava coordenadas para limpar depois
      vgUltRcResize.Left = 0
      vgUltRcResize.Right = UserControl.Width / vgTpX
      vgUltRcResize.Top = y / vgTpY
      vgUltRcResize.Bottom = vgUltRcResize.Top
      
   End If
End Sub

Private Sub picBarra_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
   Dim ItemTop As Long, Rc As RECT, T As Long, TopIndex As Long
   If vgLinResizing <> -1 Then
      TopIndex = SendMessageLong(hWndLst, LVM_GETTOPINDEX, 0, 0)              'primeiro item da lista
      SendMessage hWndLst, LVM_GETITEMRECT, (vgLinResizing - 1), Rc
      ItemTop = Rc.Top - 2
      T = y - (ItemTop * vgTpY)
      If vgShowFilterBar Then T = T - vgFilterBarHeight
      
      'vamos mostrar o primeiro item (faz o scroll ir para 0)
      SendMessageLong hWndLst, LVM_ENSUREVISIBLE, 0, 0                        'certifica que ele ficará visível
      
      'redimenciona a altura da linha
      If (T - vgTpY) < MinRowHeight Then
         RowHeight = MinRowHeight
      Else
         RowHeight = (T - vgTpY)
      End If
      
      'vamos voltar a mostrar como primeiro o item que estava sendo visualizado
      SendMessageLong hWndLst, LVM_ENSUREVISIBLE, TopIndex, 0                 'certifica que ele ficará visível
      
      vgLinResizing = -1
      picBarra.MousePointer = 0
      ClipCursor ByVal 0
      vgUltRcResize.Left = 0
      vgUltRcResize.Right = 0
      vgUltRcResize.Top = 0
      vgUltRcResize.Bottom = 0
      RestoreListView
      
      PosicionaSelect
      
      Refresh
   End If
   ClipCursor ByVal 0                             'em algumas situações trava o cursor...
End Sub

Private Sub picEdit_GotFocus()
   vgHasFocus = True
   If ParentIsFocused And vgColAtual > 0 Then
      If vgColumns(vgColAtual).ColumnType <> TP_LOGICO And txtCampo.Enabled And txtCampo.Visible Then
         txtCampo.SetFocus
      End If
   End If
End Sub

Private Sub picEdit_LostFocus()
   vgHasFocus = False
End Sub

Private Sub EditCheckBox()
   Dim vgChanged As Boolean, vgColEnabled As Boolean, vgLocked As Boolean, vgRow As Long
   vgColEnabled = True
   vgLocked = vgColDefinitions(vgColEditing).Locked Or vgColDefinitions(vgColEditing).TemporaryLocked
   vgRow = SelectedItem
   RaiseEvent GetTextEnable(vgRow, vgColEditing, vgColEnabled)
   If vgColEnabled And Not vgLocked Then
      If Len(vgColumns(vgColEditing).NameFilter) > 0 And Len(vgSQLOrig$) > 0 And ((vgAllowEdit And vgAllowEditDatabase) Or (vgAllowInsert And vgAllowInsertDatabase And vgRow = vgNumItemsTot - 1)) Then
         vgLocked = Not vgTabela.EditableField(vgColumns(vgColEditing).Name)
         If Not vgLocked Then
            RaiseEvent GetColumnLocked(vgRow, vgColEditing, GetNewCols, vgColDefinitions(vgColEditing).txtCampo, vgLocked)
         End If
      Else
         vgLocked = True
      End If
   End If
   If Not vgLocked Then
      'se não tem valor algum, define como false
      If Len(vgColDefinitions(vgColEditing).NewValue & "") = 0 Then vgColDefinitions(vgColEditing).NewValue = False
      vgColDefinitions(vgColEditing).NewValue = Not CBool(vgColDefinitions(vgColEditing).NewValue)
      vgColDefinitions(vgColEditing).Changed = True
      If Not vgColDefinitions(vgColEditing).txtCampo Is Nothing Then
         vgColDefinitions(vgColEditing).txtCampo.Value = vgColDefinitions(vgColEditing).NewValue
      End If
      vgChanged = (vgHasChanged = False)
      vgHasChanged = True
      vgIsPreEditing = False
      If vgChanged Then
         Call RefreshStatus
      End If
      DrawHeaderBar
      Repaint -1
   End If
End Sub

'retorna o valor maior dos parâmentros passados
Private Function Maior(ParamArray vgValor() As Variant) As Double
   Dim i As Integer, vgRetVal As Double
   For i = 0 To UBound(vgValor)
      If vgRetVal < vgValor(i) Then vgRetVal = vgValor(i)
   Next
   Maior = vgRetVal
End Function

'retorna o valor maior dos parâmentros passados
Private Function Menor(ParamArray vgValor() As Variant) As Double
   Dim i As Integer, vgRetVal As Double
   vgRetVal = vgValor(0)
   For i = 0 To UBound(vgValor)
      If vgRetVal > vgValor(i) Then vgRetVal = vgValor(i)
   Next
   Menor = vgRetVal
End Function

Private Sub picEdit_KeyDown(KeyCode As Integer, Shift As Integer)
   If vgIgnoreKey <> 0 Then                                  'tem tecla prevista para ser ignorada...
      If vgIgnoreKey = KeyCode Then                          'se a tecla pressionada é que que estava sendo prevista para ser ignorada
         KeyCode = 0                                         'ignora...
      End If
      vgIgnoreKey = 0                                        'zera flag para não ignorar mais teclas
   End If
   If KeyCode = vbKeySpace And (vgIsPreEditing Or vgHasChanged) Then
      If vgColumns(vgColEditing).ColumnType = TP_LOGICO Then
         EditCheckBox
      End If
   End If
End Sub

Private Sub picHeader_Click()
   Dim pt As POINTAPI, vgCancel As Boolean
   If Not vgHideLeftBar And Not vgHideHeader And vgShowGridControl And (vgShowGridCaption Or Not vgFullRowSelect) Then
      GetCursorPos pt
      ScreenToClient picHeader.hWnd, pt
      If pt.y > HeaderTop / vgTpY And pt.x < vgLeftBarWidth / vgTpX Then
         RaiseEvent MenuButtonClick(vgCancel)
         If Not vgCancel Then
            M_Option(0).Enabled = (vgTopOrig > 0)             'remove TOP
            PopupMenu M_Menu
         End If
      End If
   End If
End Sub

Private Sub picHeader_DragDrop(Source As Control, x As Single, y As Single)
   Dim i As Integer, Ini As Integer, Fim As Integer, j As Integer, p As Integer, Incr As Integer, w As Long, PosColAtual As Integer
   ClipCursor ByVal 0                                               'libera o cursor
   vgMovingColumn = -1
   If vgTargetCol <> -1 And vgTargetCol <> vgColMoving Then         'se tem coluna destino... limpa e atualiza o header
      
      If vgColAtual <> -1 Then
         PosColAtual = vgColDefinitions(vgColAtual).Position        'guarda qual a posição da coluna atualmente selecionada
      Else
         PosColAtual = 0
      End If
      
      If vgTargetCol > vgColumns.Count Then
         p = vgColDefinitions(GetVisibleCol(COL_LAST)).Position
      Else
         p = vgColDefinitions(vgTargetCol).Position
         If p > vgColDefinitions(vgColMoving).Position Then
            p = p - 1
         End If
      End If
      
      If p < vgColDefinitions(vgColMoving).Position Then            'se está movendo para posição antes da atual
         Ini = p                                  'posição da coluna alvo
         Fim = vgColDefinitions(vgColMoving).Position - 1 'posição imediatamente anterior à coluna que está sendo movida
         Incr = 1                                         'vamos incrementar as posições do intervalo (Ini->Fim)
      Else                                                'está movendo para posição após a atual
         Ini = vgColDefinitions(vgColMoving).Position + 1
         Fim = p
         Incr = -1
      End If
      
      'ajusta nova posição da coluna que está sendo movida (ela terá a posição da coluna alvo)
      vgColDefinitions(vgColMoving).Position = -p
      
      'vamos redefinir posicionamento para as colunas...
      For i = Ini To Fim
         j = GetColumnByPosition(i)
         vgColDefinitions(j).Position = -(vgColDefinitions(j).Position + Incr) 'vamos definir valores negativos para não gerar erros nas próximas
      Next
      
      'corrige posições que estava negativas...
      For i = 1 To vgColumns.Count
         vgColDefinitions(i).Position = Abs(vgColDefinitions(i).Position)
      Next
      
      FreezeListView True
      
      'atualiza larguras das colunas no listview
      Call UpdateColumnsWidth
      Call UpdateColumnsLeft
      
      RestoreListView True
      
      'vamos ver se a coluna que estava selecionada mudou de lugar
      If PosColAtual <> 0 Then
         If vgColDefinitions(vgColAtual).Position <> PosColAtual Then          'se mudou,
            vgColAtual = GetColumnByPosition(PosColAtual)                      'vamos selecioná-la novamente
            AdjustColumn
         End If
      End If
      
      vgTargetCol = -1
      
   End If
   vgColMoving = -1
   vgTargetCol = -1
   Call DrawBars
End Sub

Private Sub picHeader_DragOver(Source As Control, x As Single, y As Single, State As Integer)
   Dim i As Integer, xCol As Long, vgCol As Integer
   vgCol = -1
   If Source = picMove Then
      For i = 1 To vgColumns.Count                                  'procura qual a coluna alvo para soltar
         If Not vgColumns(i).Hidden And vgColDefinitions(i).Width > 0 Then
            xCol = ColumnLeft(i)
            If x - vgColX >= xCol - vgTpX * 10 And x - vgColX <= xCol + vgTpX * 10 Then
               vgCol = i
               Exit For
            End If
         End If
      Next
      If vgCol = -1 Then                                            'não achou nenhuma, vamos ver se quer soltar após a última...
         xCol = ColumnRight(GetVisibleCol(COL_LAST))
         If x - vgColX >= xCol - vgTpX * 8 And x - vgColX <= xCol + vgTpX * 8 Then
            vgCol = vgColumns.Count + 1
         End If
      End If
   End If
   If vgCol <> vgTargetCol Then                                     'se tem coluna destino, vamos atualizar o header para desenhar a linha
      vgTargetCol = vgCol                                           'representa a coluna cuja posição será a nova nova posição da coluna que está sendo movida
      DrawBars
   End If
End Sub

Private Sub picHeader_GotFocus()
   picSel.SetFocus
End Sub

Private Sub picHeader_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
   Dim j As Integer, Rc As RECT, pt As POINTAPI, vgResize As Boolean, vgCol As Integer
   If (Button = 1 Or Button = 2) And Not vgHideHeader Then
      vgResize = False
      For j = 1 To vgColumns.Count                                'faz todas as colunas
         Rc.Left = ColumnRight(j)
         If y > HeaderTop And x >= Rc.Left - 30 And x <= Rc.Left + 30 And Not vgColumns(j).Hidden Then
            vgResize = True
            vgCol = j
         End If
      Next
      If vgResize And Button = 1 Then
         If Timer - vgTimerLastClick < 1 Then
            vgIgnoreMouseUp = True
            ColumnWidth(vgCol) = -2
            Exit Sub
         End If
         vgTimerLastClick = 0
         vgColResizing = vgCol
         pt.x = ColumnRight(vgCol) / vgTpX
         pt.y = HeaderTop / vgTpY + (HeaderHeightFull - HeaderTop) / 2 / vgTpY + 1
         ClientToScreen picHeader.hWnd, pt
         SetCursorPos pt.x, pt.y
         Rc.Top = pt.y
         Rc.Left = pt.x - ColumnWidth(vgCol) / vgTpX
         If vgCol = GetVisibleCol(COL_FIRST) Then                 'se for a primeira coluna visível
            Rc.Left = Rc.Left - 2
         End If
         pt.x = picHeader.ScaleWidth / vgTpX
         pt.y = HeaderTop / vgTpY + (HeaderHeightFull - HeaderTop) / 2 / vgTpY + 1
         ClientToScreen picHeader.hWnd, pt
         Rc.Bottom = pt.y
         Rc.Right = pt.x
         ClipCursor Rc
         FreezeListView                                           'vamos congelar imagem do listview
         vgTimerLastClick = Timer
      ElseIf y > HeaderTop And x < ColumnLeft(GetVisibleCol(COL_FIRST)) And Not vgHideLeftBar Then
         'está clicando sobre botão de menu
      ElseIf y > HeaderTop And x < ColumnRight(GetVisibleCol(COL_LAST)) And GetShiftKeys = 0 And (vgShowGridCaption Or Not vgFullRowSelect) Then 'parece estar clicando sobre uma coluna válida
         For j = 1 To vgColumns.Count             'faz todas as colunas
            Rc.Left = ColumnLeft(j)
            Rc.Right = Rc.Left + ColumnWidth(j)
            If x >= Rc.Left And x <= Rc.Right Then
               Exit For
            End If
         Next
         If Button = 1 Then                       'prepara para mover
            vgTargetCol = -1                      'nova posição para a coluna que está sendo arrastada
            vgColMoving = j
            vgMovingColumn = 1
            vgColX = x
            vgColY = y
            picMove.Width = ColumnWidth(vgColMoving)
            picMove.Left = ColumnLeft(vgColMoving)
            picMove.Top = HeaderTop
            picMove.Height = vgHeaderHeight
         Else

            'só pode colunas numéricas
            M_ColOption(0).Enabled = (vgColumns(j).ColumnType = TP_NUMERICO) 'sum
            M_ColOption(1).Enabled = (vgColumns(j).ColumnType = TP_NUMERICO) 'max
            M_ColOption(2).Enabled = (vgColumns(j).ColumnType = TP_NUMERICO) 'min
            M_ColOption(3).Enabled = (vgColumns(j).ColumnType = TP_NUMERICO) 'avg
            
            'vamos checar de acordo com a situação atual da coluna
            M_ColOption(0).Checked = (vgColumns(j).ColumnType = TP_NUMERICO And vgColDefinitions(j).ShowSum) 'sum
            M_ColOption(1).Checked = (vgColumns(j).ColumnType = TP_NUMERICO And vgColDefinitions(j).ShowMax) 'max
            M_ColOption(2).Checked = (vgColumns(j).ColumnType = TP_NUMERICO And vgColDefinitions(j).ShowMin) 'min
            M_ColOption(3).Checked = (vgColumns(j).ColumnType = TP_NUMERICO And vgColDefinitions(j).ShowAvg) 'avg

            M_ColOption(5).Checked = (vgColDefinitions(j).Order = 1)                                         'asc
            M_ColOption(6).Checked = (vgColDefinitions(j).Order = -1)                                        'desc

            M_MenuCol.Tag = CStr(j)               'vamos guardar o número da coluna que originou o popup

            PopupMenu M_MenuCol
         End If
      ElseIf y < HeaderTop And (vgShowGridCaption Or Not vgFullRowSelect) Then
         If Not DrawButtonsControl(Button) Then
            Call ReleaseCapture
            SendMessageLong vgFormParent.hWnd, WM_NCLBUTTONDOWN, 2, 0
         End If
      End If
   End If
End Sub

Private Sub picHeader_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
   Dim j As Integer, Rc As RECT, vgChangeCursor As Boolean, pt As POINTAPI, vgCol As Integer, vgColMov As Integer, vgOk As Boolean, hPen As Long
   If vgHideHeader Then Exit Sub
   If vgMovingColumn = 1 And (vgShowGridCaption Or Not vgFullRowSelect) Then
      If y > HeaderTop And y < HeaderHeightFull Then
         If x < vgColX - 30 Or x > vgColX + 30 Then
            vgMovingColumn = 2
            Set picMove.MouseIcon = vgCurMove2
            picMove.MousePointer = 99
            picMove.DragMode = 0
            picMove.Visible = True
            picMove.Drag vbBeginDrag
         
            pt.x = 0
            pt.y = HeaderTop / vgTpY
            ClientToScreen picHeader.hWnd, pt
            Rc.Left = pt.x
            Rc.Top = pt.y
            pt.x = picHeader.ScaleWidth / vgTpX
            pt.y = picHeader.ScaleHeight / vgTpY
            ClientToScreen picHeader.hWnd, pt
            Rc.Right = pt.x - 4
            Rc.Bottom = pt.y
               
            ClipCursor Rc
                  
            vgColX = x - ColumnLeft(vgColMoving)
            vgColY = y
         ElseIf x >= vgColX - 15 And x <= vgColX + 15 And x <> vgColX Then
            Set picHeader.MouseIcon = vgCurMove
            picHeader.MousePointer = 99
         End If
      Else
         picHeader.MousePointer = 0
         vgMovingColumn = -1
         vgColMoving = -1
         vgTargetCol = -1
         vgColX = 0
         vgColY = 0
      End If
   ElseIf vgMovingColumn = 2 And (vgShowGridCaption Or Not vgFullRowSelect) Then
      If y < 0 Or y > HeaderHeightFull Then
         vgTargetCol = -1
         DrawBars
      End If
   ElseIf vgColResizing = -1 And y > HeaderTop And y < HeaderHeightFull Then
      vgChangeCursor = False
      vgCol = -1
      For j = 1 To vgColumns.Count                                'faz todas as colunas
         Rc.Left = ColumnRight(j)
         If y > HeaderTop And x >= Rc.Left - 30 And x <= Rc.Left + 30 And GetShiftKeys = 0 And Not vgColumns(j).Hidden Then
            vgChangeCursor = True
            vgCol = j
         End If
         If x >= ColumnLeft(j) And x <= Rc.Left Then
            vgColMov = j
         End If
      Next
      If vgChangeCursor Then
         If ColumnWidth(vgCol) > 0 Then
            Set picHeader.MouseIcon = vgCurSizeH
         Else
            Set picHeader.MouseIcon = vgCurSizeHPart
         End If
         picHeader.MousePointer = 99
      ElseIf (vgShowGridCaption Or Not vgFullRowSelect) Then
         vgOk = (vgColMov <> 0)
         If (Not vgHideLeftBar And x < LeftBarWidth) Or x > ColumnRight(GetVisibleCol(COL_LAST)) Or (GetShiftKeys <> 0 And Not vgOk) Then
            picHeader.MousePointer = 0
         ElseIf GetShiftKeys <> 2 Or Len(vgColumns(vgColMov).NameFilter) = 0 Then 'sem CTRL ou coluna sem ordenação
            Set picHeader.MouseIcon = vgCurSelC
            picHeader.MousePointer = 99
         Else
            If vgColDefinitions(vgColMov).Order = 1 Then
               Set picHeader.MouseIcon = vgCurOrdD
            ElseIf vgColDefinitions(vgColMov).Order = 0 Or vgColMov <> GetLastOrderedCol() Then
               Set picHeader.MouseIcon = vgCurOrdC
            Else
               Set picHeader.MouseIcon = vgCurOrdR
            End If
            picHeader.MousePointer = 99
            
         End If
      Else
         UserControl.Parent.MousePointer = 0
         picHeader.MousePointer = 0
      End If
   ElseIf vgColResizing = -1 And y < HeaderTop And (vgShowGridCaption Or Not vgFullRowSelect) Then
      picHeader.MousePointer = 0
      If vgShowGridCaption Then DrawButtonsControl Button                         'vamos repintar os botões de controle
   ElseIf y > HeaderTop And y < HeaderHeightFull Then
   
      'vamos tirar a sujeira da última linha de resize, se existir...
      picFundo.Picture = vgImgFundo
      
      'vamos pintar nova linha de resize
      hPen = CreatePen(2, 1, SysColor(vbBlack))
      hPen = SelectObject(picFundo.hdc, hPen)
      MoveToEx picFundo.hdc, x / vgTpX, HeaderTop / vgTpY, pt
      LineTo picFundo.hdc, x / vgTpX, UserControl.Height / vgTpY
      DeleteObject SelectObject(picFundo.hdc, hPen)
      
      'grava coordenadas para limpar depois
      vgUltRcResize.Left = x / vgTpX
      vgUltRcResize.Right = vgUltRcResize.Left
      vgUltRcResize.Top = 0
      vgUltRcResize.Bottom = UserControl.Height / vgTpY
   End If
End Sub

'pega número da última coluna ordenada
Private Function GetLastOrderedCol() As Integer
   Dim vgRetVal As Integer, vgUltOrd As Integer, i As Integer
   vgRetVal = 0
   For i = 1 To vgColumns.Count
      If vgColDefinitions(i).Order <> 0 Then
         If vgColDefinitions(i).OrderPosition > vgUltOrd Then
            vgUltOrd = vgColDefinitions(i).OrderPosition
            vgRetVal = i
         End If
      End If
   Next
   GetLastOrderedCol = vgRetVal
End Function

'limpa a ordenação de todas as colunas do grid
Public Sub ClearOrderAllColumns()
   Dim i As Integer
   For i = 1 To UBound(vgColDefinitions)
      vgColDefinitions(i).Order = 0
   Next
End Sub

'Insere ou retira coluna na lista de ordenação
'vgOrder 99 = Define automaticamente
'         0 = Retira
'         1 = Crescente
'        -1 = Decrescente
Public Sub DefineOrderColumn(ByVal vgCol As Integer, Optional vgOrder As Integer = 99)
   Dim i As Integer, vgUltCol As Integer, vgUltOrd As Integer, vgQtOrd As Integer, vgNewOrd As Integer

   If Len(vgColumns(vgCol).NameFilter) = 0 Then Exit Sub

   'procura última coluna que está formando a ordem, índice da última ordem e conta quantidade de colunas com ordem
   vgUltCol = 0
   vgUltOrd = 0
   vgQtOrd = 0
   For i = 1 To vgColumns.Count
      If vgColDefinitions(i).Order <> 0 Then                       'tem ordem definida
         vgQtOrd = vgQtOrd + 1
         If vgColDefinitions(i).OrderPosition > vgUltOrd Then      'posição de ordem é maior que a última encontrada
            vgUltOrd = vgColDefinitions(i).OrderPosition
            vgUltCol = i                                           'número da última coluna que compoe a ordem do grid
         End If
      End If
   Next
   
   'define a nova ordem que a coluna terá
   If vgOrder <> 99 Then                                           'se quer uma ordem definida
      vgNewOrd = vgOrder                                           'usa a definição
   Else                                           'vamos redefinir o tipo de ordem para essa coluna
      If vgColDefinitions(vgCol).Order = -1 And vgCol = vgUltCol Then 'só deixa apagar a ordem se essa for a última coluna
         vgNewOrd = 0
      ElseIf vgColDefinitions(vgCol).Order = 1 Or vgOrder = -1 Then
         vgNewOrd = -1
      Else
         vgNewOrd = 1
      End If
   End If
   
   If vgColDefinitions(vgCol).Order = 0 Then                          'se não tem definição de ordem
      vgColDefinitions(vgCol).OrderPosition = vgUltOrd + 1            'incrementa
   End If
   
   vgColDefinitions(vgCol).Order = vgNewOrd                           'define nova ordem para essa coluna
   
   Call ApplyFilterAndOrder
   
End Sub

Private Sub picHeader_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
   Dim j As Integer, vgCol As Integer, Cancel As Boolean
   If Button <> 1 Or vgHideHeader Or ActiveControl Is Nothing Then Exit Sub
   If vgIgnoreMouseUp Then
      vgIgnoreMouseUp = False
      Exit Sub
   End If
   If vgColResizing <> -1 Then
   
      'está dando double click na linha de resize, vamos reatribuir largura original da coluna
      If ColumnWidth(vgColResizing) <> (x - ColumnLeft(vgColResizing)) Then
         vgTimerLastClick = 0
         SendMessageLong hWndLst, WM_SETREDRAW, 0, 0
         ColumnWidth(vgColResizing) = (x - ColumnLeft(vgColResizing))
         UpdateColumnsLeft
      End If
      
      vgColResizing = -1
      picHeader.MousePointer = 0
      ClipCursor ByVal 0
      vgUltRcResize.Left = 0
      vgUltRcResize.Top = 0
      vgUltRcResize.Bottom = 0
      vgUltRcResize.Top = 0
      SendMessageLong hWndLst, WM_SETREDRAW, 1, 0
      RestoreListView
      PosicionaSelect
      DrawBars
   ElseIf y > HeaderTop And y < HeaderHeightFull And (vgShowGridCaption Or Not vgFullRowSelect) Then
      If vgHasChanged Or vgIsPreEditing Then
         If ParentIsFocused And Not TypeOf vgFormParent.ActiveControl Is GListV Then   'vamos verificar se o foco não está no grid para tentar salvar
            Cancel = EndEditGrid(True, True)
            If Not Cancel Then
               PosicionaSelect
            End If
         Else
            Cancel = True
         End If
      End If
      If Not Cancel Then
         vgCol = 0
         For j = 1 To vgColumns.Count
            If x >= ColumnLeft(j) And x <= ColumnRight(j) And Not vgColumns(j).Hidden Then
               vgCol = j
            End If
         Next
         If vgCol > 0 Then
            If GetShiftKeys <> 2 Or Len(vgColumns(vgCol).NameFilter) = 0 Then          'só permite sem CTRL ou para colunas que não podem ter ordenação
               If vgColsSelected = "|" + CStr(vgCol) + "|" Then
                  vgColsSelected = ""
               Else
                  If SelectedItem <> -1 Then SelecionaItem -1
                  If GetShiftKeys = 0 Then vgColsSelected = ""
                  If InStr(vgColsSelected, "|" + CStr(vgCol) + "|") > 0 Then
                     vgColsSelected = Substitui$(vgColsSelected, "|" + CStr(vgCol) + "|", "|", SO_UM)
                  Else
                     If Len(vgColsSelected) = 0 Then vgColsSelected = vgColsSelected + "|"
                     vgColsSelected = vgColsSelected + CStr(vgCol) + "|"
                  End If
                  If Len(vgColsSelected) = 1 Then vgColsSelected = ""
               End If
            ElseIf Len(vgColumns(vgCol).NameFilter) > 0 Then
               DefineOrderColumn vgCol
            End If
            Refresh
         End If
         If vgMovingColumn <> -1 Then
            picMove.Visible = False
            picHeader.Drag vbCancel
            vgMovingColumn = -1
            vgColMoving = -1
            vgTargetCol = -1
            vgColX = 0
            vgColY = 0
            vgColAtual = -1
            DrawHeaderBar
         End If
      ElseIf vgMovingColumn <> -1 Then
         picMove.Visible = False
         picHeader.Drag vbCancel
         vgMovingColumn = -1
         vgColMoving = -1
         vgTargetCol = -1
         vgColX = 0
         vgColY = 0
         DrawHeaderBar
      End If
   ElseIf y < HeaderTop And (vgShowGridCaption Or Not vgFullRowSelect) Then
      If DrawButtonsControl(Button) Then
         RaiseEvent CloseButtonClick
      End If
   End If
   picHeader_MouseMove Button, Shift, x, y
   ClipCursor ByVal 0                             'em algumas situações trava o cursor...
End Sub

'CUIDADO: ROTINA MANUAL
'PROPOSITO: Quando o Grid pegar foco deixar em modo de digitação
Private Sub picSel_Click()
   'Inicio Manual
   If mdiNFE.ActiveForm.vgTipo <> 5 Then picSel_DblClick
   If mdiNFE.ActiveForm.vgTipo = 1 Then ItemClick SelectedItem 'Manual
   If mdiNFE.ActiveForm.vgTipo = TP_RELAT Then ItemClick SelectedItem 'Manual
   If mdiNFE.ActiveForm.vgTipo = TP_COMUM Then ItemClick SelectedItem 'Manual
   'Fim Manual
   
   'RETIRADO AS LINHAS DE BAIXO
   
   'If Not vgHasChanged And Not vgIsPreEditing And Not vgFullRowSelect Then
   '   If Timer - vgTimerLastClick < 1 Then
   '      picSel_DblClick
   '   End If
   'ElseIf vgFullRowSelect Then
   '   ItemClick SelectedItem
   'End If
End Sub
'CUIDADO: ROTINA MANUAL
'PROPOSITO: Quando o Grid pegar foco deixar em modo de digitação
Private Sub picSel_DblClick()
   Dim Validacao As String 'Variavel manual
   If GetShiftKeys = 0 And Not vgFullRowSelect Then
      'Inicio Manual
      If mdiNFE.ActiveForm.vgTipo <> 5 Then
         Validacao = mdiNFE.ActiveForm.Executar(VALIDACOES)
      End If
      'Fim Manual
      If Not vgHasChanged And Not vgIsPreEditing And vgTabela.AsyncComplete And Not vgLocked Then
         'Inicio Manual
         If Vazio(Validacao) Then
            vgForcePosSel = True
            vgIsPreEditing = True
            PosicionaSelect
         Else
            vgForcePosSel = False
            vgIsPreEditing = False
         End If
         'Fim Manual
      End If
   End If
End Sub


Private Sub picSel_GotFocus()
   vgHasFocus = True
   If Not vgForcePicSel And (vgHasChanged Or vgIsPreEditing) Then
      If picEdit.Visible Then
         picEdit.SetFocus
      End If
   End If
   PosicionaSelect
End Sub

Private Sub picSel_LostFocus()
   If Not picEdit.Visible Then
      vgHasFocus = False
   End If
   PosicionaSelect
End Sub

Private Sub picSel_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
   Dim Rc As RECT, pt As POINTAPI
   
   'vamos ver se está em pré-edição e clicou diretamente em um check, muda o estado do check
   If GetShiftKeys = 0 Then
      If vgColAtual <> -1 And vgColumns.Count > 0 Then
         If (vgIsPreEditing Or vgHasChanged) And vgColumns(vgColAtual).ColumnType = TP_LOGICO Then     'está pré-editando ainda e foi clicado em campo lógico
            Rc.Left = 2 + Round(picSel.ScaleWidth / vgTpX / 2 - 13 / 2)
            Rc.Top = 1 + Round(picSel.ScaleHeight / vgTpY / 2 - 13 / 2)
            Rc.Right = Rc.Left + 13
            Rc.Bottom = Rc.Top + 13
            pt.x = x / vgTpX
            pt.y = y / vgTpY
            If PtInRect(Rc, pt.x, pt.y) Then
               DefineCampo
               Call EditCheckBox
            End If
         End If
      End If
   End If
End Sub

Private Sub picStatus_GotFocus()
   picSel.SetFocus
End Sub

Private Sub picStatus_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
   If Button = 1 Then
      Call ReleaseCapture
      SendMessageLong vgFormParent.hWnd, WM_NCLBUTTONDOWN, 2, 0
   End If
End Sub

Private Sub txtEdit_Change()
   Dim vgChanged As Boolean, vgDraw As Boolean, j As Integer, txtCp As FormataCampos, vgCancel As Boolean

   If vgPriVez > 0 Then Exit Sub

   'se está iniciando edição/inclusão...
   If vgHasChanged = False Then
      vgCancel = False
      RaiseEvent InitEdit(vgCancel)
      If vgCancel Then                            'vamos cancelar edição
         vgPriVez = vgPriVez + 1
         txtEdit.Text = vgColDefinitions(vgColAtual).OriginalText
         vgPriVez = vgPriVez - 1
         Exit Sub
      End If
   End If

   txtCampo.Change
   
   'vamos ver se pediu relação com outro mask
   Set txtCp = vgColDefinitions(vgColEditing).txtCampo
   If Not txtCp Is Nothing Then
      If txtCp.DataType = 5 Then
         txtCp.Value = txtCampo.Value
      ElseIf txtCp.DataType = 6 Then
         For j = 0 To vgFormParent.Controls.Count - 1
            If UCase$(vgFormParent.Controls(j).Name) = UCase$(txtCp.CtPri.Name) Then
               If vgFormParent.Controls(j).Index = txtCampo.Value Then
                  vgFormParent.Controls(j).Value = True
               End If
            End If
         Next
      Else
         If txtCampo.ComLstExt Then
            txtCp.vgValueAtual = txtCampo.Value
         End If
         txtCp.Text = txtCampo.Text
      End If
   End If
   Set txtCp = Nothing
   
   vgColDefinitions(vgColEditing).NewValue = txtCampo.Value
   vgColDefinitions(vgColEditing).NewText = txtCampo.Text
   vgDraw = Not vgColDefinitions(vgColEditing).Changed
   vgColDefinitions(vgColEditing).Changed = (vgColDefinitions(vgColEditing).OriginalValue & "" <> vgColDefinitions(vgColEditing).NewValue & "")
   vgChanged = (vgHasChanged = False)

   'vamos restaurar todos os valores que foram atribuídos por valor inicial e também
   'voltar sequenciais que possam ter sido criados (Dispara evento CancelEdit)
   'para solicitarmos novos valores iniciais, pode ser que o valor inicial de alguma
   'coluna dependa do valor dessa coluna editada
   vgCancel = True
   For j = 1 To vgColumns.Count
      'se a coluna não foi altera e está a frente da coluna atualmente editada
      If vgColDefinitions(j).Changed = False And vgColDefinitions(j).Position > vgColDefinitions(vgColAtual).Position Then
         If vgColDefinitions(j).HasInitialValue Then 'se a coluna tem valor inicial
            'se é sequencial e está a frente da coluna em edição, volta seqüência
            If vgCancel And vgTabela.Table.Columns(vgColumns(j)).Sequencia And Not vgTabela.Table.Columns(vgColumns(j)).SeqInterno Then
               RaiseEvent CancelEdit(SelectedItem)
               vgCancel = False
            End If
            vgColDefinitions(j).NewValue = vgColDefinitions(j).OriginalValue 'atualiza os valores das colunas, exemplo: fórmulas
            vgColDefinitions(j).NewText = vgColDefinitions(j).OriginalText   'atualiza os textos apresentados nessas colunas
            vgColDefinitions(j).HasInitialValue = False                      'inicializa para que novo valor inicial seja buscado
         End If
         If vgChanged Then
            If Not vgColDefinitions(j).txtCampo Is Nothing Then
               If Not vgColDefinitions(j).txtCampo.DataType = [Option ] Then
                  vgColDefinitions(j).txtCampo.Value = vgColDefinitions(j).NewValue
               End If
            End If
         End If
      End If
   Next

   vgHasChanged = True
   vgIsPreEditing = False
   If vgChanged Then
      Call RefreshStatus
   End If
   Repaint -1                                     'vamos forçar atualização da linha inteira, para fazer refresh em fórmulas...
   If vgDraw Then DrawBars
End Sub

Private Sub txtEdit_DblClick()
   RaiseEvent ActionDoubleClick(GetNewCols(), vgColAtual, False)
End Sub

'dispara o evento de duplo clique em campo memo
Private Sub txtEditMult_DblClick()
   RaiseEvent ActionDoubleClick(GetNewCols(), vgColAtual, False)
End Sub

Private Sub txtEdit_GotFocus()
   vgIgnoreMouseUp = True
   txtCampo.GotFocus
   vgIgnoreMouseUp = False
End Sub

Private Sub txtEdit_KeyDown(KeyCode As Integer, Shift As Integer)
   If vgIgnoreKey <> 0 Then                                  'tem tecla prevista para ser ignorada...
      If vgIgnoreKey = KeyCode Then                          'se a tecla pressionada é que que estava sendo prevista para ser ignorada
         KeyCode = 0                                         'ignora...
      End If
      vgIgnoreKey = 0                                        'zera flag para não ignorar mais teclas
   End If
   txtCampo.KeyDown KeyCode, Shift
End Sub

Private Sub txtEdit_KeyPress(KeyAscii As Integer)
   Dim Cancel As Boolean
   Cancel = (KeyAscii = vbKeyEscape)
   If vgColEditing <> -1 And Not Cancel Then
      If KeyAscii = vbKeyReturn Then
         If vgColumns(vgColEditing).ColumnType <> TP_MEMO Or Not vgColDefinitions(vgColEditing).Changed Or txtEditMult.SelLength = Len(txtEditMult.Text) Then             'vamos deixar ENTER operar livremente dentro do memo só se já tiver mudado seu conteúdo
            Cancel = True
         End If
      End If
   End If
   If Cancel Then KeyAscii = 0
   txtCampo.KeyPress KeyAscii
End Sub

Private Sub txtEdit_LostFocus()
   If txtEdit.Visible And vgHasChanged Then
      txtCampo.LostFocus
   End If
End Sub

Private Sub txtEditMult_Change()
   txtEdit_Change
End Sub

Private Sub txtEditMult_GotFocus()
   txtCampo.GotFocus
End Sub

Private Sub txtEditMult_KeyDown(KeyCode As Integer, Shift As Integer)
   txtEdit_KeyDown KeyCode, Shift
End Sub

Private Sub txtEditMult_KeyPress(KeyAscii As Integer)
   txtEdit_KeyPress KeyAscii
End Sub

Private Sub txtEditMult_LostFocus()
   If Not txtCampo Is Nothing Then
      txtCampo.LostFocus
   End If
End Sub

'aplica o filtro
Private Sub timRefresh_Timer()
   If vgInFilter Then                             'se estamos com o foco na barra de filtro e o projeto foi definido para "Aplicar filtro automaticamente nos Grids"
      ApplyFilterAndOrder                         'aplicamos o filtro
   End If
   vgFilterApplied = True
   timRefresh.Enabled = False
End Sub

Private Sub txtFilter_Change(Index As Integer)
   If vgPriVez > 0 Then Exit Sub
   timRefresh.Enabled = False
   txtCampoFilter(Index).Change
   timRefresh.Enabled = vgAutoApplyFilter
   vgFilterApplied = False
End Sub

Private Sub txtFilter_GotFocus(Index As Integer)
   If ActiveControl Is Nothing Then Exit Sub       'se não tem controle ativo, não permitiremos a execução, para evitar erro ao abrir combo no filtro e clicar no formulário (fora do grid)
   If Not ActiveControl.Name = "txtFilter" Then Exit Sub
   vgInFilter = True
   txtCampoFilter(Index).GotFocus
   If UBound(txtCampoFilter) > 0 Then              'evitar o uso de instância já finalizada e redimensionado o array para zero
      DefineCampoFilter Index                      'vamos formatar o campo na barra de filtro
   End If
   If vgColAtual <> Index Then
      vgColAtual = Index
      DrawBars
   End If
End Sub

Private Sub txtFilter_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      ApplyFilterAndOrder
      txtCampoFilter(Index).LostFocus
      If vgFilterApplied Then
         RaiseEvent ItemClick(0, GetOriginalCols())
      Else
         vgFilterApplied = True
      End If
      txtCampoFilter(Index).SetFocus
      txtCampoFilter(Index).SelStart = Len(txtCampoFilter(Index).Text)
   ElseIf KeyCode = vbKeyEscape Then
      SendMessage hWndLst, WM_KEYDOWN, KeyCode, 0
      Exit Sub
   ElseIf KeyCode = vbKeyRight Then
      If txtFilter(Index).SelStart = Len(txtFilter(Index).Text) Then
         If vgColDefinitions(vgColAtual).Position < vgColDefinitions(txtFilter.Count - 1).Position Then      'se não for a última coluna visível
            vgColAtual = GetVisibleCol(COL_NEXT, vgColAtual)
         Else
            vgColAtual = GetVisibleCol(COL_FIRST)   'vamos posicionar na primeira coluna visível
         End If
         txtFilter(vgColAtual).SetFocus
         AdjustColumn
      End If
   ElseIf KeyCode = vbKeyLeft Then
      If txtFilter(Index).SelStart = 0 Then
         If vgColDefinitions(vgColAtual).Position > vgColDefinitions(GetVisibleCol(COL_FIRST)).Position Then 'se não for a primeira coluna visível
            vgColAtual = GetVisibleCol(COL_PREVIOUS, vgColAtual)
         Else
            vgColAtual = GetVisibleCol(COL_LAST)   'vamos posicionar na última coluna visível
         End If
         txtFilter(vgColAtual).SetFocus
         AdjustColumn
      End If
   ElseIf KeyCode = vbKeyDown Then
      vgInFilter = False
      If Not vgFullRowSelect Then
         If vgColAtual = -1 Then
            vgColAtual = GetVisibleCol(COL_FIRST)
         End If
      End If
      If SelectedItem = -1 Then SelecionaItem 0
      PosicionaSelect
      picSel.SetFocus                              'em algumas situações o foco não vai... vamos forçar
      Exit Sub
   ElseIf KeyCode = vbKeyPageDown Then
      vgInFilter = False
      If Not vgFullRowSelect Then
         If vgColAtual = -1 Then
            vgColAtual = GetVisibleCol(COL_FIRST)
         End If
      End If
      SelecionaItem LastItemVisible
      PosicionaSelect
      picSel.SetFocus                              'em algumas situações o foco não vai... vamos forçar
      Exit Sub
   End If
   If KeyCode = vbKeyReturn Or KeyCode = vbKeyDown Or KeyCode = vbKeyUp Then KeyCode = 0
   txtCampoFilter(Index).KeyDown KeyCode, Shift
End Sub

Private Sub txtFilter_KeyPress(Index As Integer, KeyAscii As Integer)
   On Error Resume Next
   If KeyAscii = vbKeyReturn Or KeyAscii = vbKeyUp Or KeyAscii = 91 Or KeyAscii = 93 Then KeyAscii = 0
   txtCampoFilter(Index).KeyPress KeyAscii
End Sub

Private Sub txtFilter_LostFocus(Index As Integer)
   On Error Resume Next
   vgInFilter = False
   If Not txtCampoFilter(Index) Is Nothing Then
      txtCampoFilter(Index).LostFocus
   End If
End Sub

Private Sub txtTop_KeyPress(KeyAscii As Integer)
   If Not vgIsPreEditing And Not vgHasChanged Then
      If KeyAscii = vbKeyReturn Then
         If Not vgHideHeader Then
            picHeader.SetFocus
         ElseIf Not vgHideStatus Then
            picStatus.SetFocus
         ElseIf Not vgHideLeftBar Then
            picBarra.SetFocus
         End If
         ApplyFilterAndOrder
         KeyAscii = 0
      ElseIf (KeyAscii < 48 Or KeyAscii > 57) And KeyAscii <> 8 Then      'só deixa número
         KeyAscii = 0
      End If
   Else
      KeyAscii = 0
   End If
End Sub

Private Function ParentIsFocused() As Boolean
   Dim vghWndParent As Long
   If Not VBDesignMode Then
      If GetActiveWindow <> mdiNFE.hWnd Then
         vghWndParent = GetActiveWindow
      ElseIf Not mdiNFE.ActiveForm Is Nothing Then
         vghWndParent = mdiNFE.ActiveForm.hWnd
      End If
      If vghWndParent And Not vgFormParent Is Nothing Then
         ParentIsFocused = (vghWndParent = vgFormParent.hWnd)                'se a janela ativa for a janela que contém o usercontrol
      Else
         ParentIsFocused = False
      End If
   Else
      ParentIsFocused = False
   End If
End Function

Private Sub UserControl_EnterFocus()
   vgComFoco = 1
   If vgShowFilterBar And vgFormParent.Name = "frmBrowse" Then
      SetFocusFilter
   Else
      If SelectedItem = -1 And Len(vgRowsSelected$) = 0 Then
         ItemSelect 0, False
      Else
         Repaint SelectedItem
      End If
      PosicionaSelect
   End If
End Sub

Private Sub UserControl_ExitFocus()
   Dim Cancel As Boolean, i As Long, Ok As Boolean, vgHandle As Long
   Ok = ParentIsFocused
   'se o controle que recebeu o foco é um botão e está no formulário ativo, vamos ver se é para ignorar o foco
   If Not mdiNFE.ActiveForm Is Nothing Then
      If Not mdiNFE.ActiveForm.ActiveControl Is Nothing And Ok Then
         If TypeOf mdiNFE.ActiveForm.ActiveControl Is GBotao Then
            vgHandle = mdiNFE.ActiveForm.ActiveControl.hWnd
            For i = 1 To UBound(vgIgnoredFocusControls)
               If vgIgnoredFocusControls(i) = vgHandle Then
                  Ok = False
                  UserControl.SetFocus
                  Exit For
               End If
            Next
         End If
      End If
   End If

   'se o foco foi dado a um botão da barra de ferramentas, verifica se o controle do formulário ativo é um grid e verifica se deve ignorar o foco
   If Not mdiNFE.ActiveControl Is Nothing And Ok Then
      If Not mdiNFE.ActiveForm Is Nothing Then
         If Not mdiNFE.ActiveForm.ActiveControl Is Nothing Then
            If TypeOf mdiNFE.ActiveForm.ActiveControl Is GListV Then
               vgHandle = mdiNFE.ActiveControl.hWnd
               For i = 1 To UBound(vgIgnoredFocusControls)
                  If vgIgnoredFocusControls(i) = vgHandle Then
                     Ok = False
                     Exit For
                  End If
               Next
            End If
         End If
      End If
   End If
   If Ok Then                                                 'se a janela ativa for a janela que contém o usercontrol
      If vgHasChanged Or vgIsPreEditing Then
         If Not vgFormParent.ActiveControl Is Nothing Then
            If Not TypeOf vgFormParent.ActiveControl Is GListV Then
               Cancel = EndEditGrid(True, True)
            End If
         Else
            Cancel = True
         End If
      End If
      If Cancel And vgFormParent.Visible And Not vgFormParent.ActiveControl Is Nothing Then
         UserControl.SetFocus
         PosicionaSelect
      Else
         Repaint -1
         vgComFoco = 0
         Repaint SelectedItem
      End If
   Else
      vgComFoco = 0
      Repaint -1
   End If
   timRefresh.Enabled = False                                 'desativa timer de filtragem automática
End Sub

'==============================================
'Eventos do controle
'==============================================

Private Sub UserControl_Initialize()
   On Error Resume Next
   ReDim vgItens(0) As String
   vgNumItems = 0
   vgNumItemsTot = 0
   vgColAtual = -1
   Call ResetBookMark
   vgTpX = Screen.TwipsPerPixelX
   vgTpY = Screen.TwipsPerPixelY
   vgStatusBarHeight = 17 * vgTpX
   vgSumaryBarHeight = 18 * vgTpX                        'barras de SUM/MAX/MIN/AVG
   vgCaptionHeight = 16 * vgTpY
   vgNavigation = GRID_NAVIGATION_RIGHT
   vgInternalLst = False
   vgIsPreEditing = False
   vgMovingColumn = -1
   vgColMoving = -1
   vgTargetCol = -1
   vgColEditing = -1
   vgRowEditing = -1
   vgLinResizing = -1
   vgColResizing = -1
   vgLastRow = -1
   Set vgColumns = New GColumns
   vgIcoSelect = LoadFixedGasPicture(350, vbLPCustom, vbLPDefault, 16, 14)
   vgIcoSel = LoadFixedGasPicture(351, vbLPCustom, vbLPDefault, 16, 14)
   vgIcoEdit = LoadFixedGasPicture(352, vbLPCustom, vbLPDefault, 16, 14)
   vgIcoGEdit = LoadFixedGasPicture(371, vbLPCustom, vbLPDefault, 16, 16)
   vgIcoGReady = LoadFixedGasPicture(368, vbLPCustom, vbLPDefault, 16, 16)
   vgIcoGBusy1 = LoadFixedGasPicture(369, vbLPCustom, vbLPDefault, 16, 16)
   vgIcoGBusy2 = LoadFixedGasPicture(370, vbLPCustom, vbLPDefault, 16, 16)
   vgIcoNew = LoadFixedGasPicture(353, vbLPCustom, vbLPDefault, 16, 14)
   vgIcoFilter = LoadFixedGasPicture(354, vbLPCustom, vbLPDefault, 16, 14)
   vgIcoCmd = LoadFixedGasPicture(376, vbLPCustom, vbLPDefault, 16, 16)
   vgIcoSeta = LoadFixedGasPicture(355, vbLPCustom, vbLPDefault, 16, 16)
   vgIcoOrdC = LoadFixedGasPicture(356, vbLPCustom, vbLPDefault, 16, 14)
   vgIcoOrdD = LoadFixedGasPicture(357, vbLPCustom, vbLPDefault, 16, 14)
   vgIcoSum = LoadFixedGasPicture(372, vbLPCustom, vbLPDefault, 16, 14)
   vgIcoMax = LoadFixedGasPicture(373, vbLPCustom, vbLPDefault, 16, 14)
   vgIcoMin = LoadFixedGasPicture(374, vbLPCustom, vbLPDefault, 16, 14)
   vgIcoAvg = LoadFixedGasPicture(375, vbLPCustom, vbLPDefault, 16, 14)
   Set vgCurSizeH = LoadFixedGasPicture(358, vbLPCustom, , 16, 16)
   Set vgCurSizeHPart = LoadFixedGasPicture(359, vbLPCustom, , 16, 16)
   Set vgCurSizeV = LoadFixedGasPicture(360, vbLPCustom, , 16, 16)
   Set vgCurSelR = LoadFixedGasPicture(361, vbLPCustom, , 16, 16)
   Set vgCurSelC = LoadFixedGasPicture(362, vbLPCustom, , 16, 16)
   Set vgCurMove = LoadFixedGasPicture(363, vbLPCustom, , 16, 16)
   Set vgCurMove2 = LoadFixedGasPicture(364, vbLPCustom, , 16, 16)
   Set vgCurOrdC = LoadFixedGasPicture(365, vbLPCustom, , 16, 16)
   Set vgCurOrdD = LoadFixedGasPicture(366, vbLPCustom, , 16, 16)
   Set vgCurOrdR = LoadFixedGasPicture(367, vbLPCustom, , 16, 16)
   Call Create
End Sub

Private Sub UserControl_InitProperties()
   vgBackColor = vbWindowBackground
   vgCellBackColor = vbWindowBackground
   vgEditBackColor = &H80FFFF
   vgEditTextColor = vbButtonText
   vgCellTextColor = vbButtonText
   vgFullRowSelect = True
   vgTrackSelect = False
   vgHideSelect = False
   vgHideFocus = False
   vgGridLines = True
   vgLocked = False
   vgFlatHeader = True
   vgHideHScroll = False
   vgHideHeader = False
   vgHideStatus = False
   vgHideCaption = False
   vgHideLeftBar = False
   vgStripes = False
   vgHeaderHeight = 17 * vgTpX
   vgLeftBarWidth = 20 * vgTpX
   vgRowHeight = 14 * vgTpY
   vgAllowEdit = False
   vgAllowInsert = False
   vgAllowDelete = False
   vgManualUpdate = False
   vgManualDelete = False
   vgNavigationAddMode = GRID_NAVIGATION_AUTO
   vgNavigationEditNavigation = GRID_NAVIGATION_AUTO
   vgShowFilterBar = False
   vgAutoApplyFilter = True                       'usar filtro com timer, sem pressionar ENTER
   vgAutoRebind = False                           'atualizar dados de combos, sem pressionar F5
   vgShowTopField = False
   vgRemoveInitialTop = False
   vgShowSumBar = False
   vgShowMaxBar = False
   vgShowMinBar = False
   vgShowAvgBar = False
   vgShowGridCaption = True
   vgShowCloseButton = False
   vgShowGridControl = True
   vgSaveGridBars = False
   vgSaveGridCols = False
   vgSaveGridStripes = True
   vgCaption = "GRID"
   vgAllowEditDatabase = False
   vgAllowInsertDatabase = False
   vgAllowDeleteDatabase = False
   vgStripesBackColor = &HD1D1D1
   vgStripesTextColor = vbButtonText
   vgSelectBackColor = &H8000000D
   vgSelectTextColor = &H8000000E
   vgColSelectBackColor = vbButtonFace
   vgColSelectTextColor = &HC00000
   vgInternalLst = True
   vgUboundMode = False
   vgEnabled = True
   vgBorderStyle = GBorder_3D
   ClearColumns                                   'columncount=0
   vgCacheSize = 0
   ResetBookMark
   Call Initiate
End Sub

'vamos passar a mensagem de keydown para a listview, só para os controles especificados abaixo
Private Sub UserControl_KeyDown(KeyCode As Integer, Shift As Integer)
   Dim vgHwnd As Long
   vgHwnd = GetFocus
   If vgHwnd = picHeader.hWnd Or vgHwnd = picBarra.hWnd Or vgHwnd = picStatus.hWnd Or vgHwnd = picFundo.hWnd Or vgHwnd = picEdit.hWnd Or vgHwnd = txtEdit.hWnd Or vgHwnd = txtEditMult.hWnd Or vgHwnd = picSel.hWnd Or vgHwnd = UserControl.hWnd Then
      vgLastKey = KeyCode                                'armazena a última tecla digitada
      SendMessage hWndLst, WM_KEYDOWN, KeyCode, 0
      Sleep 0
      SendMessage hWndLst, WM_CHAR, KeyCode, 0
      Sleep 0
      SendMessage hWndLst, WM_KEYUP, KeyCode, 0
      Sleep 0
   End If
End Sub

'Pega número real da coluna segundo uma posição passada
Private Function GetColumnByPosition(ByVal vgPos As Integer) As Integer
   Dim i As Integer, RetVal As Integer
   RetVal = vgPos
   For i = 1 To vgColumns.Count
      If vgColDefinitions(i).Position = vgPos Then
         RetVal = i
         Exit For
      End If
   Next
   GetColumnByPosition = RetVal
End Function

Private Sub DrawBars(Optional ByVal ChangeBusy As Boolean)
   DrawHeaderBar
   DrawStatusBar ChangeBusy
   DrawLeftBar
End Sub

Private Sub DrawLeftBarItem(ByVal vgRow As Long)
   Dim Rc As RECT, y As Long, j As Long
   
   Rc.Left = 0: Rc.Right = 0: Rc.Top = 0: Rc.Bottom = 0
   SendMessage hWndLst, LVM_GETITEMRECT, vgRow, Rc                      'pega posicionamento do item
   If Not vgHideLeftBar Then
      Rc.Top = Rc.Top - 1
      Rc.Bottom = Rc.Bottom - 2
      y = Rc.Bottom * vgTpY
      If vgShowFilterBar Then
         Rc.Top = Rc.Top + vgFilterBarHeight / vgTpY
         Rc.Bottom = Rc.Bottom + vgFilterBarHeight / vgTpY
         y = y + vgFilterBarHeight
      End If
      
      'vamos limpar o fundo
      picBarra.Line (vgTpX, Rc.Top * vgTpY)-(vgLeftBarWidth - 3 * vgTpX, Rc.Bottom * vgTpY), vgLeftBackColor, BF
      
      picBarra.Line (0, y - vgTpY)-(picBarra.ScaleWidth - vgTpX, y - vgTpY), vbButtonShadow
      picBarra.Line (0, y)-(picBarra.ScaleWidth - vgTpX, y), vbWhite
      
      j = 0
      If vgRow = vgNumItemsTot - 1 And vgAllowInsert And (vgInternalLst Or vgAllowInsertDatabase) Then
         If vgRowEditing = vgRow And vgHasChanged Then
            j = vgIcoEdit
         Else
            j = vgIcoNew
         End If
      ElseIf vgRow = SelectedItem Then                                  'é o item selecionado...
         If vgHasChanged Then
            j = vgIcoEdit
         Else
            j = vgIcoSelect
         End If
      ElseIf InStr(vgRowsSelected, "|" + CStr(vgRow) + "|") > 0 Then
         j = vgIcoSel
      End If
      If j Then
         y = Rc.Top + (Rc.Bottom - Rc.Top) / 2 - 14 / 2 - 1
         DrawState picBarra.hdc, 0, 0, j, 0, vgLeftBarWidth / vgTpX / 2 - 16 / 2 - 1, y, 16, 14, DST_ICON Or (DSS_DISABLED * Abs(Not vgEnabled))
      End If
   End If
End Sub

Private Sub DrawLeftBar()
   Dim i As Long, Fim As Long, Ini As Long, vgRow As Long, Rc As RECT, hBrushBack As Long
   
   'vamos desenhar barra lateral de status
   If Not vgHideLeftBar Then
      Rc.Left = 0
      Rc.Top = 1
      Rc.Right = picBarra.Width / vgTpX
      Rc.Bottom = picBarra.ScaleHeight / vgTpY
      hBrushBack = CreateSolidBrush(SysColor(vgLeftBackColor))          'cria o brush
      FillRect picBarra.hdc, Rc, hBrushBack                             'faz o erase do header
      DeleteObject hBrushBack                                           'mata o brush
      
      picBarra.Line (picBarra.Width - vgTpX, 0)-(picBarra.Width - vgTpX, picBarra.ScaleHeight), vbButtonShadow

      If vgShowFilterBar Then
         picBarra.Line (0, vgTpY)-(picBarra.ScaleWidth - 2 * vgTpX, vgFilterBarHeight - vgTpY), vgFilterBackColor, BF
         picBarra.Line (0, vgFilterBarHeight - 15)-(picBarra.ScaleWidth, vgFilterBarHeight - 15), vbButtonShadow
         picBarra.Line (0, vgFilterBarHeight)-(picBarra.ScaleWidth - 15, vgFilterBarHeight), vbWhite
         DrawState picBarra.hdc, 0, 0, vgIcoFilter, 0, vgLeftBarWidth / vgTpX / 2 - 16 / 2 - 1, vgFilterBarHeight / 2 / vgTpY - 14 / 2 - 1, 16, 14, DST_ICON Or (DSS_DISABLED * Abs(Not vgEnabled))
         picBarra.Refresh
      End If
   
      Ini = FirstItemVisible
      Fim = LastItemVisible
      vgRow = SelectedItem
   
      'vamos desenhar barra de controle de status para esse item e também limpar restante do listview a direira
      For i = Ini To Fim
         DrawLeftBarItem i
      Next
      
      picBarra.Refresh
      
   End If

End Sub

Private Sub DrawStatusBar(Optional ByVal ChangeBusy As Boolean)
   Dim vgIco As Long, vgRow As Long, x As String, y As Long, vgPX As Long, i As Integer, vgDraw As Boolean, RcCol As RECT, hBrushBack As Long
   Dim vgCol As New GColumn, vgValue As Double, j As Long, vgColor As Long, vgBKColor As Long, vgValueSel As Double
   Static vgBusy As Boolean
   Dim vgHTI As LVHITTESTINFO, FirstColDisplayed As Long, vgIndCol As Long
   Dim vgSumMask As String                        'armazena a máscara para a formatação da soma, acrescentando um dígito significativo

   'vamos desenhar o status
   If Not vgHideStatus Or vgShowSumBar Or vgShowMaxBar Or vgShowMinBar Or vgShowAvgBar Then
      picStatus.BackColor = vgStatusBackColor
      
      y = 0
      vgDraw = False
      For i = 1 To 5
         Select Case i
            Case 1
               vgDraw = vgShowSumBar
               vgIco = vgIcoSum
            Case 2
               vgDraw = vgShowMaxBar
               vgIco = vgIcoMax
            Case 3
               vgDraw = vgShowMinBar
               vgIco = vgIcoMin
            Case 4
               vgDraw = vgShowAvgBar
               vgIco = vgIcoAvg
            Case 5
               If Not vgHideStatus Then
                  vgDraw = True
                  vgIco = 0
                  If vgHasChanged Then
                     vgIco = vgIcoGEdit
                  ElseIf Not vgTabela Is Nothing Then
                     If vgTabela.AsyncComplete Then
                        vgIco = vgIcoGReady
                     Else
                        If ChangeBusy Then vgBusy = Not vgBusy
                        If vgBusy Then
                           vgIco = vgIcoGBusy1
                        Else
                           vgIco = vgIcoGBusy2
                        End If
                     End If
                  Else
                     vgIco = vgIcoGReady
                  End If
            
                  'vamos colocar informação da quantidade de linhas e da linha atualmente selecionado
                  vgRow = SelectedItem
                  If vgRow <> -1 Then
                     If vgRow = vgNumItemsTot - 1 And vgAllowInsert And (vgInternalLst Or vgAllowInsertDatabase) Then
                        x$ = "?/"
                     Else
                        x$ = Format(vgRow + 1, "#,###,###,###,###") + "/"
                     End If
                  Else
                     x$ = "?/"
                  End If
                  x$ = x$ + Format(vgNumItems, "#,###,###,###,###")
                  
                  'posiciona e imprime
                  If vgEnabled Then
                     picStatus.ForeColor = vbButtonText
                  Else
                     picStatus.ForeColor = vbButtonShadow
                  End If
                  
                  picStatus.ForeColor = vgStatusTextColor
                  
                  picStatus.CurrentX = 20 * vgTpX
                  picStatus.CurrentY = y + vgStatusBarHeight / 2 - picStatus.TextHeight(x$) / 2 + vgTpY
                  picStatus.Print x$
            
                  'vamos colocar quantidade de linhas selecionadas também na status
                  If Len(vgRowsSelected$) > 0 Then
                     vgPX = 20 + picStatus.TextWidth(x$) / vgTpX + 8
                     DrawState picStatus.hdc, 0, 0, vgIcoSel, 0, vgPX, y / vgTpY + vgStatusBarHeight / vgTpY / 2 - 14 / 2 + 1, 16, 14, DST_ICON Or (DSS_DISABLED * Abs(Not vgEnabled))
                     
                     'formata a quantidade de linhas selecionada
                     x$ = Format(SelectedRowsCount, "#,###,###,###,###")
                     picStatus.CurrentX = vgPX * vgTpX + 16 * vgTpX
                     picStatus.CurrentY = y + vgStatusBarHeight / 2 - picStatus.TextHeight(x$) / 2 + vgTpY
                     picStatus.Print x$           'imprime
                  End If

                  'se quer campo para definição de TOP
                  If vgShowTopField Then
                     picTop.Top = y + 3 * vgTpY
                     picTop.Left = picStatus.ScaleWidth - picTop.Width - 2 * vgTpX
                     picTop.Height = vgStatusBarHeight - 4 * vgTpY
                     txtTop.Left = vgTpX
                     txtTop.Top = 0
                     txtTop.Width = picTop.ScaleWidth - vgTpX
                     txtTop.Height = picTop.ScaleHeight
                     x$ = "TOP"
                     picStatus.CurrentX = picTop.Left - picStatus.TextWidth(x$) - 4 * vgTpX
                     picStatus.CurrentY = picTop.Top
                     picStatus.Print x$
                  End If

               End If
         End Select
         If vgDraw Then                           'se tem que desenhar essa barra
         
            'vamos pintar o fundo da barra
            Select Case i
               Case 1
                  vgColor = SysColor(vgSumTextColor)
                  vgBKColor = SysColor(vgSumBackColor)
               Case 2
                  vgColor = SysColor(vgMaxTextColor)
                  vgBKColor = SysColor(vgMaxBackColor)
               Case 3
                  vgColor = SysColor(vgMinTextColor)
                  vgBKColor = SysColor(vgMinBackColor)
               Case 4
                  vgColor = SysColor(vgAvgTextColor)
                  vgBKColor = SysColor(vgAvgBackColor)
               Case Else
                  vgDraw = False
            End Select
            If vgDraw Then
               RcCol.Left = 0
               RcCol.Top = y / vgTpY
               RcCol.Right = picStatus.Width / vgTpX
               RcCol.Bottom = (y + vgSumaryBarHeight + vgTpY * 2) / vgTpY
               hBrushBack = CreateSolidBrush(vgBKColor) 'cria o brush
               FillRect picStatus.hdc, RcCol, hBrushBack 'faz o erase da status
               DeleteObject hBrushBack                   'mata o brush
            End If

            FirstColDisplayed = SendMessage(hWndLst, LVM_SUBITEMHITTEST, 0, vgHTI)
            FirstColDisplayed = vgHTI.iSubItem + 1
            If FirstColDisplayed < 1 Then FirstColDisplayed = 1
            
            For vgIndCol = FirstColDisplayed To vgColumns.Count
               Select Case i
                  Case 1
                     vgDraw = vgColDefinitions(vgIndCol).ShowSum
                     vgValue = vgColDefinitions(vgIndCol).ValueSum
                     vgValueSel = vgColDefinitions(vgIndCol).ValueSumSel
                  Case 2
                     vgDraw = vgColDefinitions(vgIndCol).ShowMax
                     vgValue = vgColDefinitions(vgIndCol).ValueMax
                     vgValueSel = vgColDefinitions(vgIndCol).ValueMaxSel
                  Case 3
                     vgDraw = vgColDefinitions(vgIndCol).ShowMin
                     vgValue = vgColDefinitions(vgIndCol).ValueMin
                     vgValueSel = vgColDefinitions(vgIndCol).ValueMinSel
                  Case 4
                     vgDraw = vgColDefinitions(vgIndCol).ShowAvg
                     vgValue = vgColDefinitions(vgIndCol).ValueAvg
                     vgValueSel = vgColDefinitions(vgIndCol).ValueAvgSel
                  Case Else
                     vgDraw = False
               End Select
               
               If vgColumns(vgIndCol).ColumnType = TP_NUMERICO And Not vgColumns(vgIndCol).Hidden And vgDraw Then
                  j = vgIndCol
                  RcCol.Left = ColumnLeft(j) / vgTpX
                  RcCol.Top = y / vgTpY + 2
                  RcCol.Bottom = RcCol.Top + vgSumaryBarHeight / vgTpY
                  vgSumMask = vgColumns(vgIndCol).Mask
                  If InStr(vgSumMask, ".") < 4 Then
                     vgSumMask = "9" & vgSumMask
                  Else
                     vgSumMask = "9." & vgSumMask
                  End If
                  x$ = txtCampo.FormatField(vgValue, vgSumMask, PegaTipoMask(vgColumns(vgIndCol).ColumnType), "")
                  If vgValueSel <> 0 Then
                     x$ = x$ & " (" & txtCampo.FormatField(vgValueSel, vgColumns(vgIndCol).Mask, PegaTipoMask(vgColumns(vgIndCol).ColumnType), "") & ")"
                  End If
                  RcCol.Right = RcCol.Left + ColumnWidth(j) / vgTpX - 2
                  j = SetTextColor(picStatus.hdc, vgColor)
                  DrawText picStatus.hdc, x$, Len(x$), RcCol, DT_SINGLELINE Or DT_RIGHT Or DT_VCENTER
                  SetTextColor picStatus.hdc, j
               End If
               
               'se a coluna começa após a barra de scroll vertical
               If RcCol.Left * vgTpX > ScaleWidth - IIf(FirstItemVisible <> 0 Or LastItemVisible < vgNumItemsTot - 1, GetSystemMetrics(SM_CXVSCROLL) * vgTpX, 0) Then
                  Exit For
               End If
            Next
            picStatus.Line (0, y)-(picStatus.ScaleWidth, y), vbButtonShadow
            picStatus.Line (0, y + vgTpY)-(picStatus.ScaleWidth, y + vgTpY), vbWhite
            If vgIco <> 0 Then
               If i <> 5 Then
                  j = vgSumaryBarHeight
               Else
                  j = vgStatusBarHeight
               End If
               DrawState picStatus.hdc, 0, 0, vgIco, 0, 2, y / vgTpY + j / 2 / vgTpY - 16 / 2 + 2 + IIf(i <> 5, 1, -1), 16, 16, DST_ICON Or (DSS_DISABLED * Abs(Not vgEnabled))
            End If
            If i <> 5 Then y = y + vgSumaryBarHeight + 2 * vgTpY 'vamos incrementar para o top da próxima barra
         End If
      Next
      picStatus.Refresh
   End If

End Sub

Private Sub DrawHeaderBar()
   Dim RcCol As RECT, RcTemp As RECT, sTemp As String, i As Long, k As Long, vgTargetPosition As Integer, _
       xIni As Long, hBrushBack As Long, BC As Long, TC As Long, vgCor As Long, vgCor2 As Long, vgPreviousCol As Integer, _
       vgIco As Long, vgFTemp As Long, vgTemOrd As Boolean, hPrevTC  As Long, ColorDef As GridColorDefinition, _
       vgHTI As LVHITTESTINFO, FirstColDisplayed As Long

   AdjustFilterBar
   
   'vamos desenhar o header
   If Not vgHideHeader Then
      If Not vgHideLeftBar Then
         xIni = vgLeftBarWidth / vgTpX - 2                            'posição inicial para os captions
      Else
         xIni = 0                                 'posição inicial para os captions
      End If
      
      vgFTemp = MakeFont(5, 300, False, False, False, "Arial")

      'pega o índice da primeira coluna exibida na área de desenho do grid
      FirstColDisplayed = SendMessage(hWndLst, LVM_SUBITEMHITTEST, 0, vgHTI)
      FirstColDisplayed = vgHTI.iSubItem + 1
      If FirstColDisplayed < 1 Then FirstColDisplayed = 1
      
      For i = FirstColDisplayed To vgColumns.Count
         
         ColorDef = GetColorInfo(SelectedItem, i)
         
         RcCol.Left = ColumnRight(i) / vgTpX
         If RcCol.Left - 1 > xIni And ColumnWidth(i) > 0 And Not vgColumns(i).Hidden Then
            
            'vamos desenhar o caption para o header
            If Not vgHideCaption Or vgHeaderHeight > 0 Then
               RcCol.Left = ColumnLeft(i) / vgTpX + 1
               If vgColDefinitions(i).Position > vgColDefinitions(GetVisibleCol(COL_FIRST)).Position Then 'se não for a primeira coluna visível
                  RcCol.Left = RcCol.Left + 1
               End If
               RcCol.Right = RcCol.Left + ColumnWidth(i) / vgTpX
               RcCol.Top = HeaderTop / vgTpY + 1
               RcCol.Bottom = HeaderHeightFull / vgTpY
               If vgEnabled Then
                  If InStr(vgColsSelected, "|" + CStr(i) + "|") > 0 Then
                     BC = &H80000015
                     TC = vbHighlightText
                  Else
                     If i = vgColAtual Then
                        BC = vgColSelectBackColor
                        TC = vgColSelectTextColor
                     Else
                        TC = ColorDef.ColumnTextColor
                        BC = ColorDef.ColumnBackColor
                     End If
                     If i = vgColMoving And vgMovingColumn = -2 Then
                        BC = vbButtonShadow
                     End If
                  End If
               Else
                  TC = vbButtonShadow
                  BC = vbButtonFace
               End If
               hBrushBack = CreateSolidBrush(SysColor(BC))                                                'cria o brush
               FillRect picHeader.hdc, RcCol, hBrushBack                                                  'faz o erase do header
               DeleteObject hBrushBack            'mata o brush
               If Not vgHideCaption Then
                  hPrevTC = SetTextColor(picHeader.hdc, SysColor(TC))
                  RcCol.Left = RcCol.Left + 2
                  If vgColDefinitions(i).Order = 1 Then
                     vgIco = vgIcoOrdC
                  ElseIf vgColDefinitions(i).Order = -1 Then
                     vgIco = vgIcoOrdD
                  Else
                     vgIco = 0
                  End If
                  vgTemOrd = False
                  If vgIco Then
                     k = ColumnRight(i) / vgTpX - 14
                     If k - 7 > ColumnLeft(i) / vgTpX Then
                        RcTemp = RcCol
                        If vgColumns(i).ColumnType = TP_NUMERICO Then
                           DrawState picHeader.hdc, 0, 0, vgIco, 0, ColumnLeft(i) / vgTpX, HeaderTop / vgTpY + (HeaderHeightFull - HeaderTop) / 2 / vgTpY - 14 / 2 + 3, 16, 14, DST_ICON Or (DSS_DISABLED * Abs(Not vgEnabled))
                           RcTemp.Left = ColumnLeft(i) / vgTpX + 3
                           RcTemp.Right = ColumnLeft(i) / vgTpX + 13
                        Else
                           DrawState picHeader.hdc, 0, 0, vgIco, 0, k, HeaderTop / vgTpY + (HeaderHeightFull - HeaderTop) / 2 / vgTpY - 14 / 2 + 3, 16, 14, DST_ICON Or (DSS_DISABLED * Abs(Not vgEnabled))
                           RcTemp.Left = k + 3
                        End If
                        vgFTemp = SelectObject(picHeader.hdc, vgFTemp)
                        RcTemp.Top = HeaderTop / vgTpY + 1
                        sTemp = CStr(vgColDefinitions(i).OrderPosition)
                        DrawText picHeader.hdc, sTemp, Len(sTemp), RcTemp, DT_SINGLELINE Or DT_CENTER
                        vgFTemp = SelectObject(picHeader.hdc, vgFTemp)
                        vgTemOrd = True
                     End If
                  End If
                  If RcCol.Right - RcCol.Left > 0 Then 'se coluna está visível
                     If vgTemOrd Then
                        If vgColumns(i).ColumnType = TP_NUMERICO Then
                           RcCol.Left = RcCol.Left + 12
                        Else
                           RcCol.Right = RcCol.Right - 12
                        End If
                     End If
                     sTemp = vgColumns(i).Title
                     If vgColDefinitions(i).Changed And vgHasChanged Then
                        sTemp = sTemp + " *"
                     End If
                     If vgColumns(i).ColumnType = TP_NUMERICO Then
                        k = DT_RIGHT
                        RcCol.Right = RcCol.Right - 3
                     Else
                        k = DT_LEFT
                     End If
                     DrawText picHeader.hdc, sTemp, Len(sTemp), RcCol, DT_VCENTER Or DT_SINGLELINE Or k 'desenha o capion para ela
                  End If
                  SetTextColor picHeader.hdc, hPrevTC
               End If
            End If
            vgCor = vbButtonShadow
            vgCor2 = vbWhite
            RcCol.Left = ColumnRight(i) / vgTpX
            If vgColMoving <> -1 And vgTargetCol <> -1 Then
               If vgTargetCol > vgColumns.Count Then   'se alvo for após a última coluna
                  vgTargetPosition = vgColDefinitions(GetVisibleCol(COL_LAST)).Position + 1 'calcula posição
               Else
                  vgTargetPosition = vgColDefinitions(vgTargetCol).Position                 'pega posição da coluna alvo
               End If
               If vgTargetPosition <> vgColDefinitions(GetVisibleCol(COL_FIRST)).Position Then 'se coluna alvo não for a primeira
                  If vgTargetCol <= vgColumns.Count Then
                     vgPreviousCol = GetVisibleCol(COL_PREVIOUS, vgTargetCol)
                  Else
                     vgPreviousCol = GetVisibleCol(COL_LAST)
                  End If
                  If i = vgPreviousCol Then       'se coluna que está sendo pintada for igual a coluna visível imediatamente anterior à coluna alvo
                     If vgColMoving <> vgTargetCol And vgColDefinitions(vgColMoving).Position <> vgTargetPosition - 1 Then
                        vgCor = vbBlue
                        vgCor2 = vbBlue
                        RcCol.Top = HeaderTop / vgTpY + ((HeaderHeightFull - HeaderTop) / 2) / vgTpY
                        DrawState picHeader.hdc, 0, 0, vgIcoSeta, 0, RcCol.Left - 16, HeaderTop / vgTpY, 16, 16, DST_ICON Or (DSS_DISABLED * Abs(Not vgEnabled))
                     End If
                  End If
               End If
            End If
            picHeader.Line (RcCol.Left * vgTpX, HeaderTop - vgTpY)-(RcCol.Left * vgTpX, HeaderHeightFull), vgCor
            picHeader.Line (RcCol.Left * vgTpX + 15, HeaderTop)-(RcCol.Left * vgTpX + 15, HeaderHeightFull), vgCor2
         End If
         
         'se a coluna começa após a barra de scroll vertical
         If RcCol.Left * vgTpX > ScaleWidth - IIf(FirstItemVisible <> 0 Or LastItemVisible < vgNumItemsTot - 1, GetSystemMetrics(SM_CXVSCROLL) * vgTpX, 0) Then
            Exit For
         End If
         
      Next
      
      'desenha linha inferior do header
      picHeader.Line (0, HeaderTop)-(picHeader.ScaleWidth, HeaderTop), vbWhite
      
      'desenha botão de controle se tiver leftbar
      If Not vgHideLeftBar Then
         vgCor = vbButtonShadow
         vgCor2 = vbWhite
         If vgTargetCol = GetVisibleCol(COL_FIRST) And vgColMoving <> GetVisibleCol(COL_FIRST) And vgTargetCol <= vgColumns.Count Then 'se tem alvo válido e não é após a última coluna
            vgCor = vbBlue
            vgCor2 = vbBlue
         End If
         picHeader.Line (vgLeftBarWidth - vgTpX, HeaderTop - vgTpX)-(vgLeftBarWidth - vgTpX, HeaderHeightFull), vgCor
         picHeader.Line (vgLeftBarWidth, HeaderTop)-(vgLeftBarWidth, HeaderHeightFull), vgCor2
         picHeader.Line (0, HeaderTop + vgTpY)-(vgLeftBarWidth - 2 * vgTpX, HeaderHeightFull - 2 * vgTpY), vgColHeaderBackColor, BF
         If vgShowGridControl Then
            DrawState picHeader.hdc, 0, 0, vgIcoCmd, 0, vgLeftBarWidth / 2 / vgTpX - 18 / 2, HeaderTop / vgTpY + HeaderHeight / 2 / vgTpY - 16 / 2, 16, 16, DST_ICON Or (DSS_DISABLED * Abs(Not vgEnabled))
         End If
         If vgTargetCol = GetVisibleCol(COL_FIRST) And vgColMoving <> GetVisibleCol(COL_FIRST) And vgTargetCol <= vgColumns.Count Then 'se tem alvo válido e não é após a última coluna
            RcCol.Left = ColumnLeft(GetVisibleCol(COL_FIRST)) / vgTpX - 18
            RcCol.Top = HeaderTop / vgTpY + ((HeaderHeightFull - HeaderTop) / 2) / vgTpY
            DrawState picHeader.hdc, 0, 0, vgIcoSeta, 0, RcCol.Left, HeaderTop / vgTpY, 16, 16, DST_ICON Or (DSS_DISABLED * Abs(Not vgEnabled))
         End If
      End If
      
      'vamos pintar a região à direita da última coluna
      If vgColumns.Count = 0 Then
         RcCol.Left = ColumnLeft(0) / vgTpX - 1
      Else
         RcCol.Left = ColumnRight(GetVisibleCol(COL_LAST)) / vgTpX
      End If
      picHeader.Line ((RcCol.Left + 2) * vgTpX, HeaderTop + vgTpY)-(picHeader.ScaleWidth, HeaderHeightFull), vgColHeaderBackColor, BF
      
      If vgFTemp Then DeleteObject vgFTemp
   End If
   If Not vgHideHeader Or vgShowGridCaption Then
      picHeader.Line (0, picHeader.ScaleHeight - 15)-(picHeader.ScaleWidth, picHeader.ScaleHeight - 15), vbButtonShadow
      If Not vgHideLeftBar Then
         picBarra.Line (0, 0)-(LeftBarWidth - vgTpX, 0), vbWhite
      End If
   End If
   If vgShowGridCaption Then
      RcCol.Left = 0
      RcCol.Top = 0
      RcCol.Right = picHeader.ScaleWidth / vgTpX
      RcCol.Bottom = HeaderTop / vgTpY
      hBrushBack = CreateSolidBrush(SysColor(vgCaptionBackColor))   'cria o brush
      FillRect picHeader.hdc, RcCol, hBrushBack                     'faz o erase do header
      DeleteObject hBrushBack                                       'mata o brush
      
      picHeader.Line (0, 0)-(picHeader.ScaleWidth, 0), vbWhite
      If Not vgHideHeader Then picHeader.Line (0, HeaderTop - vgTpY)-(picHeader.ScaleWidth, HeaderTop - vgTpY), vbButtonShadow
      
      sTemp = vgCaption
      RcCol.Top = 0
      RcCol.Left = 0
      RcCol.Right = picHeader.ScaleWidth / vgTpX
      RcCol.Bottom = HeaderTop / vgTpY
      If vgEnabled Then
         SetTextColor picHeader.hdc, SysColor(vgCaptionTextColor)
      Else
         SetTextColor picHeader.hdc, SysColor(vbButtonShadow)
      End If
      picHeader.Font.Bold = True
      DrawText picHeader.hdc, sTemp, Len(sTemp), RcCol, DT_CENTER Or DT_VCENTER Or DT_SINGLELINE 'desenha o capion para ela
      picHeader.Font.Bold = False
      Call DrawButtonsControl(0)
   End If
   picHeader.Refresh

End Sub

Private Function DrawButtonsControl(ByVal Button As Integer) As Boolean
   Dim Rc As RECT, pt As POINTAPI, vgIsOver As Boolean
   If Not vgHideHeader And vgShowGridCaption And vgShowCloseButton Then
      Rc.Left = picHeader.ScaleWidth / vgTpX - 20
      Rc.Top = 3
      Rc.Right = Rc.Left + 14
      Rc.Bottom = 3 + 14
      
      GetCursorPos pt
      ScreenToClient picHeader.hWnd, pt
      
      picHeader.Line (Rc.Left * vgTpX, Rc.Top * vgTpY)-(Rc.Right * vgTpX, Rc.Bottom * vgTpY), vgCaptionBackColor, BF
      
      vgIsOver = False
      
      If PtInRect(Rc, pt.x, pt.y) Then
         If Button = 1 Then
            DrawEdge picHeader.hdc, Rc, BDR_SUNKENOUTER, BF_RECT
         Else
            DrawEdge picHeader.hdc, Rc, BDR_RAISEDINNER, BF_RECT
         End If
         vgIsOver = True
      End If
      
      If Not vgIsOver Or (vgIsOver And Button = 1) Then
         Rc.Left = Rc.Left + 1
         Rc.Top = Rc.Top + 1
         Rc.Right = Rc.Right + 1
         Rc.Bottom = Rc.Bottom + 1
      End If

      picHeader.DrawWidth = 2

      Rc.Left = (Rc.Left + 3) * vgTpX
      Rc.Top = (Rc.Top + 3) * vgTpY
      Rc.Right = Rc.Left + 6 * vgTpX
      Rc.Bottom = Rc.Top + 6 * vgTpY
   
      picHeader.Line (Rc.Left + vgTpX, Rc.Top + vgTpY)-(Rc.Right + vgTpX, Rc.Bottom + vgTpY), vbWhite
      picHeader.Line (Rc.Left + vgTpX, Rc.Bottom + vgTpY)-(Rc.Right + vgTpX, Rc.Top + vgTpY), vbWhite
   
      picHeader.Line (Rc.Left, Rc.Top)-(Rc.Right, Rc.Bottom), IIf(Not vgIsOver, &H404040, vbButtonText)
      picHeader.Line (Rc.Left, Rc.Bottom)-(Rc.Right, Rc.Top), IIf(Not vgIsOver, &H404040, vbButtonText)
      
      picHeader.DrawWidth = 1
   End If
   DrawButtonsControl = vgIsOver
End Function

Private Sub DrawFilterBar()
   Dim RcCol As RECT, j As Long, vgHTI As LVHITTESTINFO, FirstColDisplayed As Long
   
   'vamos desenhar a barra de filtro
   If vgShowFilterBar Then
         
      'desenha linhas para efeito de luz da barra de filtro
      picFilter.Line (0, 0)-(picFilter.ScaleWidth, 0), vbWhite           'linha superior
      picFilter.Line (0, 0)-(0, picFilter.ScaleHeight), vbWhite          'linha lateral esquerda (primeira)
      
      FirstColDisplayed = SendMessage(hWndLst, LVM_SUBITEMHITTEST, 0, vgHTI)
      FirstColDisplayed = vgHTI.iSubItem + 1
      If FirstColDisplayed < 1 Then FirstColDisplayed = 1

      For j = FirstColDisplayed To vgColumns.Count                       'faz todas as colunas
         If Not vgColumns(j).Hidden Then
            RcCol.Left = ColumnRight(j) / vgTpX
            If Not vgHideLeftBar Then
               RcCol.Left = RcCol.Left - vgLeftBarWidth / vgTpX
            End If
            picFilter.Line (RcCol.Left * vgTpX, 0)-(RcCol.Left * vgTpX, vgFilterBarHeight), vbButtonShadow
            picFilter.Line (RcCol.Left * vgTpX + 15, 0)-(RcCol.Left * vgTpX + 15, vgFilterBarHeight), vbWhite
         End If
         
         'se a coluna começa após a barra de scroll vertical
         If RcCol.Left * vgTpX > ScaleWidth - IIf(FirstItemVisible <> 0 Or LastItemVisible < vgNumItemsTot - 1, GetSystemMetrics(SM_CXVSCROLL) * vgTpX, 0) Then
            Exit For
         End If
      Next
      
      'vamos pintar o que "sobra" após o último campo de filtro
      If vgHideLeftBar Then
         j = vgTpX
      Else
         j = vgLeftBarWidth - 2 * vgTpX
      End If
      
      If vgColumns.Count > 0 Then
         picFilter.Line (ColumnRight(GetVisibleCol(COL_LAST)) - j, vgTpY)-(picFilter.ScaleWidth, vgFilterBarHeight - 2 * vgTpY), vgFilterBackColor, BF
         picFilter.Line (0, picFilter.ScaleHeight - vgTpY)-(picFilter.ScaleWidth, picFilter.ScaleHeight - vgTpY), vbButtonShadow
      End If
      
      picFilter.Refresh
   End If
End Sub

Private Sub UserControl_Resize()
   Dim tR As RECT, tHI As HD_ITEM, x As Single, y As Single, h As Long, vgStHeight As Single
   If vgPriVez > 0 Then Exit Sub
   vgPriVez = vgPriVez + 1
   vgOrigHeight = 0
   GetClientRect hWnd, tR
   If vgHideHScroll And WithHScroll Then
      tR.Bottom = tR.Bottom - GetSystemMetrics(SM_CYHSCROLL)
   End If
   If (Not vgHideHeader Or vgShowGridCaption) Then
      picHeader.Move 0, 0, UserControl.Width, HeaderHeightFull
   End If
   y = HeaderHeightFull
   h = UserControl.ScaleHeight - y
   vgStHeight = StatusBarHeightFull
   If vgStHeight > 0 And UserControl.ScaleWidth > 0 Then
      h = h - vgStHeight                                   'altura de todas as barras que compoem o status
   End If
   If Not vgHideLeftBar And UserControl.ScaleHeight > 0 And h > 0 Then
      picBarra.Move 0, y, vgLeftBarWidth, h
      x = vgLeftBarWidth
   Else
      x = 0
   End If
   If vgShowFilterBar And UserControl.ScaleWidth > 0 Then
      picFilter.Move x, y, UserControl.ScaleWidth, vgFilterBarHeight
      y = y + vgFilterBarHeight
   End If
   If vgStHeight > 0 And UserControl.ScaleWidth > 0 Then
      picStatus.Move 0, UserControl.ScaleHeight - vgStHeight, UserControl.ScaleWidth, vgStHeight
      tR.Bottom = tR.Bottom - vgStHeight / vgTpY
   End If
   x = x / vgTpX
   y = y / vgTpY - 2
   SetWindowPos hWndLst, 0, x, y, tR.Right - tR.Left - x, tR.Bottom - tR.Top - y, SWP_NOOWNERZORDER
   picBarra.ZOrder
   picHeader.ZOrder
   picStatus.ZOrder
   picFilter.ZOrder
   vgPriVez = vgPriVez - 1
   If Not txtCampo Is Nothing Then
      Refresh
   End If
End Sub

Private Sub UserControl_Show()
   Call SetStyle
   Refresh
End Sub

Private Sub UserControl_Terminate()
   On Error Resume Next
   Finalize

   If hWndImgLst Then ImageList_Destroy hWndImgLst
   If hWndLst Then DestroyWindow hWndLst
   
   Set vgFormParent = Nothing
   
   DeleteObject vgFont
   Set vgCurSizeH = Nothing
   Set vgCurSizeHPart = Nothing
   Set vgCurSizeV = Nothing
   Set vgCurSelR = Nothing
   Set vgCurSelC = Nothing
   Set vgCurMove = Nothing
   Set vgCurMove2 = Nothing
   Set vgCurOrdC = Nothing
   Set vgCurOrdD = Nothing
   Set vgCurOrdR = Nothing
   Set vgImgFundo = Nothing
   If Not VBDesignMode Then
      Call OrigCallBack
   End If
   vgTabela.CloseRecordset
   Set vgTabela = Nothing
   Set vgColumns = Nothing

End Sub

Private Sub UserControl_ReadProperties(PropBag As PropertyBag)
   vgReadingProps = True
   If Not VBDesignMode Then Call Initiate
   BackColor = PropBag.ReadProperty("BackColor", vbWindowBackground)
   EditBackColor = PropBag.ReadProperty("EditBackColor", &H80FFFF)
   EditTextColor = PropBag.ReadProperty("EditTextColor", vbButtonText)
   CellBackColor = PropBag.ReadProperty("CellBackColor", vbWindowBackground)
   CellTextColor = PropBag.ReadProperty("CellTextColor", vbButtonText)
   FullRowSelect = PropBag.ReadProperty("FullRowSelect", True)
   TrackSelect = PropBag.ReadProperty("TrackSelect", False)
   HideSelect = PropBag.ReadProperty("HideSelect", False)
   HideFocus = PropBag.ReadProperty("HideFocus", False)
   GridLines = PropBag.ReadProperty("GridLines", True)
   Locked = PropBag.ReadProperty("Locked", False)
   FlatHeader = PropBag.ReadProperty("FlatHeader", True)
   HideHeader = PropBag.ReadProperty("HideHeader", False)
   HideStatus = PropBag.ReadProperty("HideStatus", False)
   HideCaption = PropBag.ReadProperty("HideCaption", False)
   HideLeftBar = PropBag.ReadProperty("HideLeftBar", False)
   HideHScroll = PropBag.ReadProperty("HideHScroll", False)
   Enabled = PropBag.ReadProperty("Enabled", True)
   Stripes = PropBag.ReadProperty("Stripes", False)
   StripesBackColor = PropBag.ReadProperty("StripesBackColor", &HE0E0E0)
   StripesTextColor = PropBag.ReadProperty("StripesTextColor", vbButtonText)
   SelectBackColor = PropBag.ReadProperty("SelectBackColor", &H8000000D)
   SelectTextColor = PropBag.ReadProperty("SelectTextColor", &H8000000E)
   ColSelectBackColor = PropBag.ReadProperty("ColSelectBackColor", vbButtonFace)
   ColSelectTextColor = PropBag.ReadProperty("ColSelectTextColor", &HC00000)
   CaptionBackColor = PropBag.ReadProperty("CaptionBackColor", &H8000000F)
   CaptionTextColor = PropBag.ReadProperty("CaptionTextColor", &H80000012)
   FilterBackColor = PropBag.ReadProperty("FilterBackColor", &H80FFFF)
   FilterTextColor = PropBag.ReadProperty("FilterTextColor", &H80000008)
   StatusBackColor = PropBag.ReadProperty("StatusBackColor", &H8000000F)
   StatusTextColor = PropBag.ReadProperty("StatusTextColor", &H80000012)
   LeftBackColor = PropBag.ReadProperty("LeftBackColor", &H8000000F)
   SumBackColor = PropBag.ReadProperty("SumBackColor", &H8000000F)
   SumTextColor = PropBag.ReadProperty("SumTextColor", SysColor(vbBlue))
   AvgBackColor = PropBag.ReadProperty("AvgBackColor", &H8000000F)
   AvgTextColor = PropBag.ReadProperty("AvgTextColor", SysColor(&H4080&))
   MinBackColor = PropBag.ReadProperty("MinBackColor", &H8000000F)
   MinTextColor = PropBag.ReadProperty("MinTextColor", SysColor(vbRed))
   MaxBackColor = PropBag.ReadProperty("MaxBackColor", &H8000000F)
   MaxTextColor = PropBag.ReadProperty("MaxTextColor", SysColor(&HC000&))
   ColHeaderBackColor = PropBag.ReadProperty("ColHeaderBackColor", &H8000000F)
   ColHeaderTextColor = PropBag.ReadProperty("ColHeaderTextColor", &H80000012)
   GridLinesColor = PropBag.ReadProperty("GridLinesColor", &HE0E0E0)
   UboundMode = PropBag.ReadProperty("UboundMode", False)
   BorderStyle = PropBag.ReadProperty("BorderStyle", GBorder_3D)
   HeaderHeight = PropBag.ReadProperty("HeaderHeight", 17 * vgTpX)
   RowHeight = PropBag.ReadProperty("RowHeight", 14 * vgTpX)
   LeftBarWidth = PropBag.ReadProperty("LeftBarWidth", 20 * vgTpX)
   AllowEdit = PropBag.ReadProperty("AllowEdit", False)
   AllowInsert = PropBag.ReadProperty("AllowInsert", False)
   AllowDelete = PropBag.ReadProperty("AllowDelete", False)
   ManualUpdate = PropBag.ReadProperty("ManualUpdate", False)
   ManualDelete = PropBag.ReadProperty("ManualDelete", False)
   NavigationAddMode = PropBag.ReadProperty("NavigationAddMode", GRID_NAVIGATION_AUTO)
   NavigationEditNavigation = PropBag.ReadProperty("NavigationEditNavigation", GRID_NAVIGATION_AUTO)
   ShowFilterBar = PropBag.ReadProperty("ShowFilterBar", False)
   AutoApplyFilter = PropBag.ReadProperty("AutoApplyFilter", True)
   AutoRebind = PropBag.ReadProperty("AutoRebind", True)
   ShowTopField = PropBag.ReadProperty("ShowTopField", False)
   RemoveInitialTop = PropBag.ReadProperty("RemoveInitialTop", False)
   ShowSumBar = PropBag.ReadProperty("ShowSumBar", False)
   ShowMaxBar = PropBag.ReadProperty("ShowMaxBar", False)
   ShowMinBar = PropBag.ReadProperty("ShowMinBar", False)
   ShowAvgBar = PropBag.ReadProperty("ShowAvgBar", False)
   ShowGridCaption = PropBag.ReadProperty("ShowGridCaption", True)
   ShowCloseButton = PropBag.ReadProperty("ShowCloseButton", False)
   ShowGridControl = PropBag.ReadProperty("ShowGridControl", True)
   SaveGridBars = PropBag.ReadProperty("SaveGridBars", False)
   SaveGridCols = PropBag.ReadProperty("SaveGridCols", False)
   Caption = PropBag.ReadProperty("Caption", "GRID")
   Set Font = PropBag.ReadProperty("Font", Ambient.Font)
   ColumnCount = PropBag.ReadProperty("ColumnCount", 0)
   CacheSize = PropBag.ReadProperty("CacheSize", 0)
   UserControl_Resize
   vgReadingProps = False
End Sub

Private Sub UserControl_WriteProperties(PropBag As PropertyBag)
   PropBag.WriteProperty "BackColor", vgBackColor, vbWindowBackground
   PropBag.WriteProperty "EditBackColor", vgEditBackColor, &H80FFFF
   PropBag.WriteProperty "EditTextColor", vgEditTextColor, vbButtonText
   PropBag.WriteProperty "CellBackColor", vgCellBackColor, vbWindowBackground
   PropBag.WriteProperty "CellTextColor", vgCellTextColor, vbButtonText
   PropBag.WriteProperty "FullRowSelect", vgFullRowSelect, True
   PropBag.WriteProperty "TrackSelect", vgTrackSelect, False
   PropBag.WriteProperty "HideSelect", vgHideSelect, False
   PropBag.WriteProperty "HideFocus", vgHideFocus, False
   PropBag.WriteProperty "GridLines", vgGridLines, True
   PropBag.WriteProperty "Locked", vgLocked, False
   PropBag.WriteProperty "Enabled", vgEnabled, True
   PropBag.WriteProperty "FlatHeader", vgFlatHeader, True
   PropBag.WriteProperty "HideHeader", vgHideHeader, False
   PropBag.WriteProperty "HideStatus", vgHideStatus, False
   PropBag.WriteProperty "HideCaption", vgHideCaption, False
   PropBag.WriteProperty "HideLeftBar", vgHideLeftBar, False
   PropBag.WriteProperty "HideHScroll", vgHideHScroll, False
   PropBag.WriteProperty "Stripes", vgStripes, False
   PropBag.WriteProperty "StripesBackColor", vgStripesBackColor, &HD1D1D1
   PropBag.WriteProperty "StripesTextColor", vgStripesTextColor, vbButtonText
   PropBag.WriteProperty "SelectBackColor", vgSelectBackColor, &H8000000D
   PropBag.WriteProperty "SelectTextColor", vgSelectTextColor, &H8000000E
   PropBag.WriteProperty "ColSelectBackColor", vgColSelectBackColor, vbButtonFace
   PropBag.WriteProperty "ColSelectTextColor", vgColSelectTextColor, &HC00000
   PropBag.WriteProperty "CaptionBackColor", CaptionBackColor, &H8000000F
   PropBag.WriteProperty "CaptionTextColor", CaptionTextColor, &H80000012
   PropBag.WriteProperty "FilterBackColor", FilterBackColor, &H80FFFF
   PropBag.WriteProperty "FilterTextColor", FilterTextColor, &H80000008
   PropBag.WriteProperty "StatusBackColor", StatusBackColor, &H8000000F
   PropBag.WriteProperty "StatusTextColor", StatusTextColor, &H80000012
   PropBag.WriteProperty "LeftBackColor", LeftBackColor, &H8000000F
   PropBag.WriteProperty "SumBackColor", SumBackColor, &H8000000F
   PropBag.WriteProperty "SumTextColor", SumTextColor, SysColor(vbBlue)
   PropBag.WriteProperty "AvgBackColor", AvgBackColor, &H8000000F
   PropBag.WriteProperty "AvgTextColor", AvgTextColor, SysColor(&H4080&)
   PropBag.WriteProperty "MinBackColor", MinBackColor, &H8000000F
   PropBag.WriteProperty "MinTextColor", MinTextColor, SysColor(vbRed)
   PropBag.WriteProperty "MaxBackColor", MaxBackColor, &H8000000F
   PropBag.WriteProperty "MaxTextColor", MaxTextColor, SysColor(&HC000&)
   PropBag.WriteProperty "GridLinesColor", GridLinesColor, &HE0E0E0
   PropBag.WriteProperty "ColHeaderBackColor", ColHeaderBackColor, &H8000000F
   PropBag.WriteProperty "ColHeaderTextColor", ColHeaderTextColor, &H80000012
   PropBag.WriteProperty "UBoundMode", vgUboundMode, False
   PropBag.WriteProperty "BorderStyle", vgBorderStyle, GBorder_3D
   PropBag.WriteProperty "HeaderHeight", vgHeaderHeight, 17 * vgTpX
   PropBag.WriteProperty "RowHeight", vgRowHeight, 14 * vgTpX
   PropBag.WriteProperty "LeftBarWidth", vgLeftBarWidth, 20 * vgTpX
   PropBag.WriteProperty "AllowEdit", vgAllowEdit, False
   PropBag.WriteProperty "AllowInsert", vgAllowInsert, False
   PropBag.WriteProperty "AllowDelete", vgAllowDelete, False
   PropBag.WriteProperty "ManualUpdate", vgManualUpdate, False
   PropBag.WriteProperty "ManualDelete", vgManualDelete, False
   PropBag.WriteProperty "NavigationAddMode", vgNavigationAddMode, GRID_NAVIGATION_AUTO
   PropBag.WriteProperty "NavigationEditNavigation", vgNavigationEditNavigation, GRID_NAVIGATION_AUTO
   PropBag.WriteProperty "ShowFilterBar", vgShowFilterBar, False
   PropBag.WriteProperty "ShowTopField", vgShowTopField, False
   PropBag.WriteProperty "RemoveInitialTop", vgRemoveInitialTop, False
   PropBag.WriteProperty "ShowSumBar", vgShowSumBar, False
   PropBag.WriteProperty "ShowMaxBar", vgShowMaxBar, False
   PropBag.WriteProperty "ShowMinBar", vgShowMinBar, False
   PropBag.WriteProperty "ShowAvgBar", vgShowAvgBar, False
   PropBag.WriteProperty "ShowGridCaption", vgShowGridCaption, True
   PropBag.WriteProperty "ShowCloseButton", vgShowCloseButton, False
   PropBag.WriteProperty "ShowGridControl", vgShowGridControl, True
   PropBag.WriteProperty "SaveGridBars", vgSaveGridBars, False
   PropBag.WriteProperty "SaveGridCols", vgSaveGridCols, False
   PropBag.WriteProperty "SaveGridStripes", vgSaveGridStripes, True
   PropBag.WriteProperty "Caption", vgCaption, "GRID"
   PropBag.WriteProperty "Font", txtEdit.Font, Ambient.Font
   PropBag.WriteProperty "ColumnCount", vgColumns.Count, 0
   PropBag.WriteProperty "CacheSize", vgCacheSize, 0
End Sub

Private Sub vgTabela_FetchComplete(ByVal RecordCount As Long)
   SetItemCount RecordCount
   
   If SelectedItem = -1 Then
      ItemSelect 0, False
   End If
   
   'vamos zerar controle de bookmark
   Call ResetBookMark

   RaiseEvent RecordSetChanged(vgTabela)
   RaiseEvent SkipRecord(GetNewCols(), vgTabela.BookMark)
   
   FillScalarValues
   Repaint -1
   DrawBars True
End Sub

Private Sub vgTabela_FetchProgress(ByVal RecordCount As Long)
   SetItemCount RecordCount

   'vamos zerar controle de bookmark
   Call ResetBookMark

   FillScalarValues
   DrawBars True
End Sub

Private Sub vgTabela_Opened()
   
   SetItemCount vgTabela.RecordCount

   'vamos zerar controle de bookmark
   Call ResetBookMark

   FillScalarValues
   DrawBars True
End Sub
