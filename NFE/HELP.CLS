Version 1.0 Class
BEGIN
      MultiUse = -1                               'True
END
Attribute VB_Name = "cTooltips"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'Classe para apresentação de tootips com diversos aspectos

Option Explicit
DefInt A-Z

#Const WIN32_IE = &H400

'estruturas
Private Type RECT
   Left As Long
   Top As Long
   Right As Long
   Bottom As Long
End Type

Private Type TOOLINFO
   cbSize As Long
   uFlags As Long
   hwnd As Long
   uId As Long
   WinRect As RECT
   hInst As Long
   lpszText As String
   #If WIN32_IE >= &H300 Then
      lParam As Long
   #End If
End Type

Private Type Size
   cx As Long
   cy As Long
End Type

Private Type INITCOMMONCONTROLEXSTRUCT
   dwSize As Long
   dwICC As Long
End Type

Private Type POINTAPI
   X As Long
   Y As Long
End Type

Private Type TTHITTESTINFO
   hwnd As Long
   pt As POINTAPI
   ti As TOOLINFO
End Type

Private Type OLECOLOR
   RedOrSys As Byte
   Green As Byte
   Blue As Byte
   Type As Byte
End Type

'enums
Public Enum TooltipFlagConstants
   ttfAlwaysTip = &H1
   ttfNoPrefix = &H2
   ttfNoAnimate = &H10
   ttfNoFade = &H20
   ttfBalloon = &H40
End Enum

Public Enum ToolFlagConstants
   tfCenterTip = &H2
   tfRtlReading = &H4
   tfTrack = &H20
   tfAbsolute = &H80
   tfTransparent = &H100
End Enum

Public Enum DelayTimeConstants
   dtAutoPop = 2
   dtInitial = 3
   dtReshow = 1
End Enum

Public Enum SetDelayTimeConstants
   sdtAutoPop = 2
   sdtInitial = 3
   sdtReshow = 1
   sdtAutomatic = 0
End Enum

Public Enum InfoTitleConstants
   itNoIcon = 0
   itInfoIcon = 1
   itWarningIcon = 2
   itErrorIcon = 3
End Enum

Private Declare Function SetWindowPos Lib "user32" (ByVal hwnd As Long, ByVal hWndInsertAfter As Long, ByVal X As Long, ByVal Y As Long, ByVal cx As Long, ByVal cy As Long, ByVal wFlags As Long) As Long
Private Const HWND_TOPMOST = -1
Private Const SWP_NOMOVE = &H2
Private Const SWP_NOSIZE = &H1
Private Const SWP_NOACTIVATE = &H10

Private Declare Function InitCommonControls Lib "comctl32" () As Long
Private Const ICC_WIN95_CLASSES = &HFF
Private Const ICC_BAR_CLASSES = &H4

Private Declare Function CreateWindowEx Lib "user32" Alias "CreateWindowExA" (ByVal dwExStyle As Long, ByVal lpClassName As String, ByVal lpWindowName As String, ByVal dwStyle As Long, ByVal X As Long, ByVal Y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hWndParent As Long, ByVal hMenu As Long, ByVal hInstance As Long, lpParam As Any) As Long
Private Const WS_EX_TOPMOST = &H8&
Private Const WS_POPUP = &H80000000
Private Const CW_USEDEFAULT = &H80000000

Private Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, lParam As Any) As Long
Private Const WM_USER = &H400
#If Not UNICODE Then
   Private Const TTM_ADDTOOL = WM_USER + 4
   Private Const TTM_DELTOOL = WM_USER + 5
   Private Const TTM_ENUMTOOLS = WM_USER + 14
   Private Const TTM_HITTEST = WM_USER + 10
   Private Const TTM_NEWTOOLRECT = WM_USER + 6
   Private Const TTM_SETTITLE = WM_USER + 32
   Private Const TTM_UPDATETIPTEXT = WM_USER + 12
#Else
   Private Const TTM_ADDTOOL = WM_USER + 50
   Private Const TTM_DELTOOL = WM_USER + 51
   Private Const TTM_ENUMTOOLS = WM_USER + 58
   Private Const TTM_HITTEST = WM_USER + 55
   Private Const TTM_NEWTOOLRECT = WM_USER + 52
   Private Const TTM_SETTITLE = WM_USER + 33
   Private Const TTM_UPDATETIPTEXT = WM_USER + 57
#End If
Private Const TTM_ACTIVATE = WM_USER + 1
Private Const TTM_ADJUSTRECT = WM_USER + 31
Private Const TTM_GETTOOLCOUNT = WM_USER + 13
Private Const TTM_GETBUBBLESIZE = WM_USER + 30
Private Const TTM_GETDELAYTIME = WM_USER + 21
Private Const TTM_GETMARGIN = WM_USER + 27
Private Const TTM_GETMAXTIPWIDTH = WM_USER + 25
Private Const TTM_GETTIPBKCOLOR = WM_USER + 22
Private Const TTM_GETTIPTEXTCOLOR = WM_USER + 23
Private Const TTM_POP = WM_USER + 28
Private Const TTM_SETDELAYTIME = WM_USER + 3
Private Const TTM_SETMARGIN = WM_USER + 26
Private Const TTM_SETMAXTIPWIDTH = WM_USER + 24
Private Const TTM_SETTIPBKCOLOR = WM_USER + 19
Private Const TTM_SETTIPTEXTCOLOR = WM_USER + 20
Private Const TTM_TRACKACTIVATE = WM_USER + 17
Private Const TTM_TRACKPOSITION = WM_USER + 18

Private Declare Function DestroyWindow Lib "user32" (ByVal hwnd As Long) As Long
Private Const TTF_IDISHWND = &H1
Private Const TTF_SUBCLASS = &H10

Private Declare Function GetTextExtentPoint32 Lib "gdi32" Alias "GetTextExtentPoint32A" (ByVal hDC As Long, ByVal lpString As String, ByVal cbString As Long, lpSize As Size) As Long
Private Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (Destination As Any, Source As Any, ByVal Length As Long)

Private Declare Function GetSysColor Lib "user32" (ByVal nIndex As Long) As Long

Private vgTTIcon As InfoTitleConstants
Private vgTitulo As String
Private vghWndTIP As Long
Private vgEnabled As Boolean

'cria a window do tootip
Public Sub Create()
   Dim InitCtrls As INITCOMMONCONTROLEXSTRUCT
   InitCtrls.dwSize = Len(InitCtrls)
   InitCtrls.dwICC = ICC_WIN95_CLASSES Or ICC_BAR_CLASSES
   Class_Terminate
   vgEnabled = True
   vgTTIcon = itNoIcon
   vgTitulo = ""
   InitCommonControls                             'inicia controles comuns do Windows
   vghWndTIP = CreateWindowEx(WS_EX_TOPMOST, "tooltips_class32", "", _
               WS_POPUP Or ttfAlwaysTip, CW_USEDEFAULT, CW_USEDEFAULT, _
               CW_USEDEFAULT, CW_USEDEFAULT, 0, 0, App.hInstance, _
               ByVal 0&)
   SetWindowPos vghWndTIP, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE Or SWP_NOSIZE Or SWP_NOACTIVATE
   MaxTipWidth = 170                              'quebra linha maior que 170 pixel  
   BackColor = &H80FFFF&                          'cor do fundo 
   ForeColor = &H80000008&                        'cor da frente 
   Enabled = vgAjudaAtiva                         'que ajuda ativa
End Sub

'anexa tooltip a um controle
Public Sub AddTool(Ctl As Control, Flags As ToolFlagConstants, Optional Text As String)
   Dim vgInfo As TOOLINFO
   If vghWndTIP = 0 Then Exit Sub
   vgInfo.cbSize = Len(vgInfo)
   vgInfo.uFlags = Flags
   If Not (Flags And tfTrack) Then
      vgInfo.uFlags = vgInfo.uFlags Or TTF_SUBCLASS
   End If
   vgInfo.uFlags = vgInfo.uFlags Or TTF_IDISHWND
   vgInfo.hwnd = Ctl.Container.hwnd
   vgInfo.hInst = App.hInstance
   vgInfo.uId = Ctl.hwnd
   If Len(Text) > 0 Then
      vgInfo.lpszText = Substitui$(Text$, "|", vbCrLf, SO_UM)
   End If
   SendMessage vghWndTIP, TTM_ADDTOOL, 0, vgInfo
End Sub

'retira o tootip do controle
Public Sub DeleteTool(Ctl As Control)
   Dim vgInfo As TOOLINFO
   If vghWndTIP = 0 Then Exit Sub
   vgInfo = GetToolInfo(Ctl.hwnd)
   If vgInfo.cbSize <> 0 Then
      SendMessage vghWndTIP, TTM_DELTOOL, 0, vgInfo
   End If
End Sub

'retorna status habilitado/desab
Public Property Get Enabled() As Boolean
   If vghWndTIP = 0 Then Exit Property
   Enabled = vgEnabled
End Property

'hablita/desabilita
Public Property Let Enabled(NewState As Boolean)
   vgEnabled = NewState
   If vghWndTIP = 0 Then Exit Property
   SendMessage vghWndTIP, TTM_ACTIVATE, vgEnabled, ByVal 0&
End Property

'pega temp intervalo
Public Function GetDelayTime(TimeMode As DelayTimeConstants) As Long
   If vghWndTIP = 0 Then Exit Function
   GetDelayTime = SendMessage(vghWndTIP, TTM_GETDELAYTIME, TimeMode, 0&)
End Function

'pega símbolo
Public Property Get Icon() As InfoTitleConstants
   If vghWndTIP = 0 Then Exit Property
   Icon = vgTTIcon
End Property

'makelong
Public Function MakeLong(Int1 As Integer, Int2 As Integer) As Long
   Dim vgInts(1 To 2) As Integer
   CopyMemory vgInts(1), Int1, Len(Int1)
   CopyMemory vgInts(2), Int2, Len(Int2)
   CopyMemory MakeLong, vgInts(1), Len(MakeLong)
End Function

'trata tooltip de arrasto
Public Sub SetTracking(Ctl As Control, Tracking As Boolean)
   Dim vgInfo As TOOLINFO
   If vghWndTIP = 0 Then Exit Sub
   vgInfo = GetToolInfo(Ctl.hwnd)
   If vgInfo.cbSize <> 0 Then
      SendMessage vghWndTIP, TTM_TRACKACTIVATE, Tracking, vgInfo
   End If
End Sub

'ajusta posição durante arrasto
Public Sub SetTrackPosition(Ctl As Control, X As Integer, Y As Integer)
   Dim vgInfo As TOOLINFO
   If vghWndTIP = 0 Then Exit Sub
   vgInfo = GetToolInfo(Ctl.hwnd)
   If vgInfo.cbSize <> 0 Then
      SendMessage vghWndTIP, TTM_TRACKPOSITION, 0, ByVal MakeLong(X, Y)
   End If
End Sub

'título do tooltip em negrito
Public Property Get Title() As String
   If vghWndTIP = 0 Then Exit Property
   Title = vgTitulo
End Property

'designa símbolo
Public Property Let Icon(NewIcon As InfoTitleConstants)
   If vghWndTIP = 0 Then Exit Property
   vgTTIcon = NewIcon
   SendMessage vghWndTIP, TTM_SETTITLE, vgTTIcon, ByVal Title
End Property

'designa título para o ttip
Public Property Let Title(NewTitle As String)
   If vghWndTIP = 0 Then Exit Property
   vgTitulo = NewTitle
   SendMessage vghWndTIP, TTM_SETTITLE, Icon, ByVal vgTitulo
End Property

'ajusta tempo intervalo
Public Sub SetDelayTime(TimeMode As SetDelayTimeConstants, Time As Long)
   If vghWndTIP = 0 Then Exit Sub
   SendMessage vghWndTIP, TTM_SETDELAYTIME, TimeMode, ByVal Time
End Sub

'esconde tooltip
Public Sub HideTips()
   If vghWndTIP = 0 Then Exit Sub
   SendMessage vghWndTIP, TTM_POP, 0, ByVal 0&
End Sub
'testa pos mouse
Public Function HitTest(Ctl As Control, X As Long, Y As Long) As Boolean
   Dim vgInfo As TTHITTESTINFO
   If vghWndTIP = 0 Then Exit Function
   With vgInfo
      .hwnd = Ctl.hwnd
      .pt.X = X
      .pt.Y = Y
      .ti.cbSize = Len(.ti)
   End With
   HitTest = (SendMessage(Ctl.hwnd, TTM_HITTEST, 0, vgInfo) <> 0)
End Function

'pega margem esq
Public Property Get MarginLeft() As Long
   Dim vgRct As RECT
   If vghWndTIP = 0 Then Exit Property
   SendMessage vghWndTIP, TTM_GETMARGIN, 0, vgRct
   MarginLeft = vgRct.Left
End Property

'ajusta margem esq
Public Property Let MarginLeft(NewMargin As Long)
   Dim vgRct As RECT
   If vghWndTIP = 0 Then Exit Property
   With vgRct
      .Left = NewMargin
      .Top = MarginTop
      .Right = MarginRight
      .Bottom = MarginBottom
   End With
   SendMessage vghWndTIP, TTM_SETMARGIN, 0, vgRct
End Property

'ajusta margem topo
Public Property Let MarginTop(NewMargin As Long)
   Dim vgRct As RECT
   If vghWndTIP = 0 Then Exit Property
   With vgRct
      .Left = MarginLeft
      .Top = NewMargin
      .Right = MarginRight
      .Bottom = MarginBottom
   End With
   SendMessage vghWndTIP, TTM_SETMARGIN, 0, vgRct
End Property

'ajusta margem dir
Public Property Let MarginRight(NewMargin As Long)
   Dim vgRct As RECT
   If vghWndTIP = 0 Then Exit Property
   With vgRct
      .Left = MarginLeft
      .Top = MarginTop
      .Right = NewMargin
      .Bottom = MarginBottom
   End With
   SendMessage vghWndTIP, TTM_SETMARGIN, 0, vgRct
End Property

'ajusta margem fundo
Public Property Let MarginBottom(NewMargin As Long)
   Dim vgRct As RECT
   If vghWndTIP = 0 Then Exit Property
   With vgRct
      .Left = MarginLeft
      .Top = MarginTop
      .Right = MarginRight
      .Bottom = NewMargin
   End With
   SendMessage vghWndTIP, TTM_SETMARGIN, 0, vgRct
End Property

'pega margem topo
Public Property Get MarginTop() As Long
   Dim vgRct As RECT
   If vghWndTIP = 0 Then Exit Property
   SendMessage vghWndTIP, TTM_GETMARGIN, 0, vgRct
   MarginTop = vgRct.Top
End Property

'pega margem dir
Public Property Get MarginRight() As Long
   Dim vgRct As RECT
   If vghWndTIP = 0 Then Exit Property
   SendMessage vghWndTIP, TTM_GETMARGIN, 0, vgRct
   MarginRight = vgRct.Right
End Property

'pega margem baixo
Public Property Get MarginBottom() As Long
   Dim vgRct As RECT
   If vghWndTIP = 0 Then Exit Property
   SendMessage vghWndTIP, TTM_GETMARGIN, 0, vgRct
   MarginBottom = vgRct.Bottom
End Property

'pega info da tooltip
Private Function GetToolInfo(ToolWnd As Long) As TOOLINFO
   Dim i As Long, vgInfo As TOOLINFO, vgFound As Boolean
   If vghWndTIP = 0 Then Exit Function
   vgInfo.cbSize = Len(vgInfo)
   For i = 0 To ToolCount - 1
      If SendMessage(vghWndTIP, TTM_ENUMTOOLS, i, vgInfo) <> 0 Then
         If vgInfo.uId = ToolWnd Then
            vgFound = True
            Exit For
         End If
      End If
   Next
   If vgFound Then GetToolInfo = vgInfo
End Function

'pega largura da tootip
Public Function GetTooltipWidth(Ctl As Control) As Long
   Dim vgTipSize As Long, vgInfo As TOOLINFO
   If vghWndTIP = 0 Then Exit Function
   vgInfo = GetToolInfo(Ctl.hwnd)
   If vgInfo.cbSize <> 0 Then
      vgTipSize = SendMessage(vghWndTIP, TTM_GETBUBBLESIZE, 0, vgInfo)
   End If
   GetTooltipWidth = LoWord(vgTipSize)
End Function

'pega altura da tooltip
Public Function GetTooltipHeight(Ctl As Control) As Long
   Dim vgTipSize As Long, vgInfo As TOOLINFO
   If vghWndTIP = 0 Then Exit Function
   vgInfo = GetToolInfo(Ctl.hwnd)
   If vgInfo.cbSize <> 0 Then
      vgTipSize = SendMessage(vghWndTIP, TTM_GETBUBBLESIZE, 0, vgInfo)
   End If
   GetTooltipHeight = HiWord(vgTipSize)
End Function

'retorna Low word de um long
Private Function LoWord(DWord As Long) As Integer
   Dim vgInts(1 To 2) As Integer
   CopyMemory vgInts(1), DWord, Len(DWord)
   LoWord = vgInts(1)
End Function

'retorna high word de um long
Private Function HiWord(DWord As Long) As Integer
   Dim vgInts(1 To 2) As Integer
   CopyMemory vgInts(1), DWord, Len(DWord)
   HiWord = vgInts(2)
End Function

'pega larg max do tooltip
Public Property Get MaxTipWidth() As Long
   If vghWndTIP = 0 Then Exit Property
   MaxTipWidth = SendMessage(vghWndTIP, TTM_GETMAXTIPWIDTH, 0, ByVal 0&)
End Property

'ajusta larg max do tooltip
Public Property Let MaxTipWidth(NewWidth As Long)
   If vghWndTIP = 0 Then Exit Property
   SendMessage vghWndTIP, TTM_SETMAXTIPWIDTH, 0, ByVal NewWidth
End Property

'ajusta área da tootip
Public Sub SetToolRect(Ctl As Control, Left As Long, Top As Long, Right As Long, Bottom As Long)
   Dim vgInfo As TOOLINFO
   If vghWndTIP = 0 Then Exit Sub
   vgInfo = GetToolInfo(Ctl.hwnd)
   With vgInfo.WinRect
      .Left = Left
      .Top = Top
      .Right = Right
      .Bottom = Bottom
   End With
   If vgInfo.cbSize <> 0 Then
      SendMessage vghWndTIP, TTM_NEWTOOLRECT, 0, vgInfo
   End If
End Sub

'retorna qde de tootips
Public Property Get ToolCount() As Long
   If vghWndTIP = 0 Then Exit Property
   ToolCount = SendMessage(vghWndTIP, TTM_GETTOOLCOUNT, 0, ByVal 0&)
End Property

'pega cor fundo
Public Property Get BackColor() As OLE_COLOR
   If vghWndTIP = 0 Then Exit Property
   BackColor = SendMessage(vghWndTIP, TTM_GETTIPBKCOLOR, 0, ByVal 0&)
End Property

'ajusta cor fundo
Public Property Let BackColor(NewColor As OLE_COLOR)
   If vghWndTIP = 0 Then Exit Property
   SendMessage vghWndTIP, TTM_SETTIPBKCOLOR, WinColor(NewColor), ByVal 0&
End Property

'designa texto da tooltip
Public Sub SetTipText(Ctl As Control, NewText As String)
   Dim vgInfo As TOOLINFO
   If vghWndTIP = 0 Then Exit Sub
   vgInfo = GetToolInfo(Ctl.hwnd)
   If vgInfo.cbSize <> 0 Then
      vgInfo.lpszText = NewText
      vgInfo.cbSize = Len(vgInfo)
      SendMessage vghWndTIP, TTM_UPDATETIPTEXT, 0, vgInfo
   End If
End Sub

'designa cor frente
Public Property Let ForeColor(NewColor As OLE_COLOR)
   If vghWndTIP = 0 Then Exit Property
   SendMessage vghWndTIP, TTM_SETTIPTEXTCOLOR, WinColor(NewColor), ByVal 0&
End Property

'pega uma cor do sistema
Private Function WinColor(VBColor As Long) As Long
   Dim vgSysClr As OLECOLOR
   CopyMemory vgSysClr, VBColor, Len(vgSysClr)
   If vgSysClr.Type = &H80 Then                   'cor do sistema
      'vgSysClr.RedOrSys é o índice da cor de sistema
      WinColor = GetSysColor(vgSysClr.RedOrSys)
   Else
      WinColor = VBColor
   End If
End Function

'pega cor frente
Public Property Get ForeColor() As OLE_COLOR
   If vghWndTIP = 0 Then Exit Property
   ForeColor = SendMessage(vghWndTIP, TTM_GETTIPTEXTCOLOR, 0, ByVal 0&)
End Property

'calcula largura a partir do texto
Public Function ToolTipWidthFromText(hDC As Long, Text As String) As Long
   Dim vgRct As RECT, vgSize As Size
   If vghWndTIP = 0 Then Exit Function
   GetTextExtentPoint32 hDC, Text, LenB(Text), vgSize
   vgRct.Right = vgSize.cx
   vgRct.Bottom = vgSize.cy
   SendMessage vghWndTIP, TTM_ADJUSTRECT, True, vgRct
   ToolTipWidthFromText = (vgRct.Right - vgRct.Left)
End Function

'calcula altura a partir do texto
Public Function ToolTipHeightFromText(hDC As Long, Text As String) As Long
   Dim vgRct As RECT, vgSize As Size
   If vghWndTIP = 0 Then Exit Function
   GetTextExtentPoint32 hDC, Text, LenB(Text), vgSize
   vgRct.Right = vgSize.cx
   vgRct.Bottom = vgSize.cy
   SendMessage vghWndTIP, TTM_ADJUSTRECT, True, vgRct
   ToolTipHeightFromText = (vgRct.Bottom - vgRct.Top)
End Function

'calcula altura do texto a partir do altura da janela tooltip
Public Function TextHeightFromToolTipHeight(TextHeight As Long) As Long
   Dim vgRct As RECT 
   If vghWndTIP = 0 Then Exit Function
   vgRct.Bottom = TextHeight
   SendMessage vghWndTIP, TTM_ADJUSTRECT, False, vgRct
   TextHeightFromToolTipHeight = (vgRct.Bottom - vgRct.Top)
End Function

'largura do texto a partir da largura da janela tooltip
Public Function TextWidthFromToolTipWidth(TextWidth As Long) As Long
   Dim vgRct As RECT 
   If vghWndTIP = 0 Then Exit Function
   vgRct.Right = TextWidth
   SendMessage vghWndTIP, TTM_ADJUSTRECT, False, vgRct
   TextWidthFromToolTipWidth = (vgRct.Right - vgRct.Left)
End Function

'termina a classe
Private Sub Class_Terminate()
   Dim vgErrNum As Long, vgErrDesc As String, vgErrSrc As String

   'salva erro
   vgErrNum = Err.Number
   vgErrDesc = Err.Description
   vgErrSrc = Err.Source
   
   If vghWndTIP <> 0 Then DestroyWindow vghWndTIP

   'restaura erro
   Err.Number = vgErrNum
   Err.Description = vgErrDesc
   Err.Source = vgErrSrc

End Sub
