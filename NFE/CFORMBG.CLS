VERSION 1.0 CLASS
BEGIN
      MultiUse = -1                               'True
      Persistable = 0                             'NotPersistable
      DataBindingBehavior = 0                     'vbNone
      DataSourceBehavior  = 0                     'vbNone
      MTSTransactionMode  = 0                     'NotAnMTSObject
END
Attribute VB_Name = "cFormBG"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Implements GSubClassInterface
Private vgSubClass As GSubClass

Private m_hWnd As Long
Private m_oBackColor As OLE_COLOR
Private m_cT As cPicTile

Private Const GW_CHILD = 5

Private Const PS_SOLID = 0


Private Declare Function GetDC Lib "user32" (ByVal hwnd As Long) As Long
Private Declare Function ReleaseDC Lib "user32" (ByVal hwnd As Long, ByVal hdc As Long) As Long
Private Declare Function GetClientRect Lib "user32" (ByVal hwnd As Long, lpRect As RECT) As Long
Private Declare Function GetWindow Lib "user32" (ByVal hwnd As Long, ByVal wCmd As Long) As Long
Private Declare Function IsIconic Lib "user32" (ByVal hwnd As Long) As Long
Private Declare Function CreateSolidBrush Lib "GDI32" (ByVal crColor As Long) As Long
Private Declare Function FillRect Lib "user32" (ByVal hdc As Long, lpRect As RECT, ByVal hBrush As Long) As Long
Private Declare Function InvalidateRect Lib "user32" (ByVal hwnd As Long, lpRect As RECT, ByVal bErase As Long) As Long
Private Declare Function GetWindowRect Lib "user32" (ByVal hwnd As Long, lpRect As RECT) As Long
Private Declare Function ScreenToClient Lib "user32" (ByVal hwnd As Long, lpPoint As POINTAPI) As Long

Private Declare Function OleTranslateColor Lib "OLEPRO32.DLL" (ByVal OLE_COLOR As Long, ByVal HPALETTE As Long, pccolorref As Long) As Long
Private Const CLR_INVALID = -1

Public Property Get BackColor() As OLE_COLOR
   BackColor = m_oBackColor
End Property

Public Property Let BackColor(ByVal oColor As OLE_COLOR)
   m_oBackColor = oColor
End Property

' converte cor OLE automation para cor windows
Private Function TranslateColor(ByVal clr As OLE_COLOR, Optional hPal As Long = 0) As Long
   If OleTranslateColor(clr, hPal, TranslateColor) Then
      TranslateColor = CLR_INVALID
   End If
End Function

Private Sub PaintBackground(ByVal hParent As Long, ByVal oColor As OLE_COLOR, ByVal nPenStyle As Long)
   'Dim tPS As PAINTSTRUCT                           'estrutura usada para painting
   Dim hNewBrush As Long                             'handle do novo brush
   Dim nRectangle As RECT                            'estrutura do retângulo
   Dim lColor As Long                                'versão GDI da OLE_COLOR para pintar
   Dim hdc As Long
   If Not (IsIconic(m_hWnd)) Then                    'se iconizado, não pinta
      hdc = GetDC(m_hWnd)
      'BeginPaint m_hWnd, tPS                          'inicia pintura
      GetClientRect m_hWnd, nRectangle               'recupera o tamanho do retângulo que descreve a área de cliente da window
      If (m_cT.FileName = "") Then                   'estamos usando bitmap?
         lColor = TranslateColor(m_oBackColor)       'se não, vamos usar só o backcolor
         hNewBrush = CreateSolidBrush(lColor)        'cria brush de cor sólida - retorna handle
         FillRect hdc, nRectangle, hNewBrush         'enche a ára de cliente
         DeleteObject hNewBrush                      'destroi o brush
      Else
         If m_cT.BackgroundType = 2 Then             'se for centralizado, temos de preencher o fundo
            lColor = TranslateColor(m_oBackColor)    'usando o backcolor
            hNewBrush = CreateSolidBrush(lColor)     'cria brush de cor sólida - retorna handle
            FillRect hdc, nRectangle, hNewBrush      'enche a ára de cliente
            DeleteObject hNewBrush                   'destroi o brush
         End If
         m_cT.TileArea hdc, nRectangle.Left, nRectangle.Top, nRectangle.Right - nRectangle.Left, nRectangle.Bottom - nRectangle.Top
      End If
      
      'imprime figura transparente no centro do form MDI
      m_cT.TransPaint hdc, nRectangle.Right - nRectangle.Left, nRectangle.Bottom - nRectangle.Top
      'EndPaint m_hWnd, tPS                            'finaliza
      ReleaseDC m_hWnd, hdc
   End If
End Sub

Public Sub Paint(Ct As Object)
   m_cT.TileArea Ct.hdc, 0, 0, Ct.Width \ Screen.TwipsPerPixelX, Ct.Height \ Screen.TwipsPerPixelY
   m_cT.TransPaint Ct.hdc, Ct.Width \ Screen.TwipsPerPixelX, Ct.Height \ Screen.TwipsPerPixelY
End Sub

'proporciona acesso ao objeto tiling do MDI
Property Get Tile() As cPicTile
   Set Tile = m_cT
End Property

Public Sub Refresh()
   Dim tR As RECT
   Dim Tp As POINTAPI
   If (m_hWnd <> 0) Then
      GetWindowRect m_hWnd, tR
      Tp.x = tR.Left
      Tp.y = tR.Top
      ScreenToClient m_hWnd, Tp
      tR.Left = Tp.x
      tR.Top = Tp.y
      Tp.x = tR.Right
      Tp.y = tR.Bottom
      ScreenToClient m_hWnd, Tp
      tR.Right = Tp.x
      tR.Bottom = Tp.y
      InvalidateRect m_hWnd, tR, 1
   End If
End Sub

Private Sub Class_Initialize()
   Set m_cT = New cPicTile
End Sub

Public Sub Init(ByRef frmThis As Object)
   Destroy                                           'assegura de que não existe link anterior
   'armazena a window usada para restaurar o background do MDI
   If TypeOf frmThis Is MDIForm Then
      m_hWnd = GetWindow(frmThis.hwnd, GW_CHILD)
   Else
      m_hWnd = frmThis.hwnd
   End If
   'armazena o backcolor atual
   m_oBackColor = frmThis.BackColor
   'incia subclassing
   Set vgSubClass = New GSubClass
   vgSubClass.SubClass m_hWnd, Me
   vgSubClass.AddMessage m_hWnd, WM_PAINT, MSG_AFTER
End Sub

Public Sub Destroy()
   'se temos um hWnd, então vamos remover as mensagens de subclassing
   If (m_hWnd <> 0) Then
      vgSubClass.UnSubClass m_hWnd
      'DetachMessage Me, m_hWnd, WM_PAINT
      m_hWnd = 0
      Set vgSubClass = Nothing
   End If
End Sub

Private Sub Class_Terminate()
   Dim vgErrNum As Long, vgErrDesc As String, vgErrSrc As String

   'salva erro
   vgErrNum = Err.Number
   vgErrDesc = Err.Description
   vgErrSrc = Err.Source
   
   Set m_cT = Nothing                                'destroy o objeto
   Destroy

   'restaura erro
   Err.Number = vgErrNum
   Err.Description = vgErrDesc
   Err.Source = vgErrSrc

End Sub

Private Sub GSubClassInterface_WndProc(ByVal lhWnd As Long, ByVal message As GSCMessage, wParam As Long, lParam As Long, ByVal bBefore As Boolean, bCancel As Boolean, lReturn As Long)
   If (message = WM_PAINT) Then
      PaintBackground m_hWnd, m_oBackColor, PS_SOLID
   End If
End Sub
