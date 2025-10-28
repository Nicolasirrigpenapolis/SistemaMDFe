VERSION 5.00
Begin VB.UserControl GPainel
   Alignable       =   -1  'True
   CanGetFocus     =   -1  'True
   ClientHeight    =   1230
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   1650
   ControlContainer=   -1  'True
   ScaleHeight     =   1230
   ScaleWidth      =   1650
   ToolboxBitmap   =   "GPAINEL.CTX":0000
   Begin VB.Line linDentro 
      BorderColor     =   &H80000015&
      Index           =   3
      Visible         =   0   'False
      X1              =   120
      X2              =   720
      Y1              =   600
      Y2              =   600
   End
   Begin VB.Line linDentro 
      BorderColor     =   &H80000015&
      Index           =   2
      Visible         =   0   'False
      X1              =   120
      X2              =   720
      Y1              =   540
      Y2              =   540
   End
   Begin VB.Line linDentro 
      BorderColor     =   &H80000014&
      Index           =   1
      Visible         =   0   'False
      X1              =   90
      X2              =   690
      Y1              =   450
      Y2              =   450
   End
   Begin VB.Line linDentro 
      BorderColor     =   &H80000014&
      Index           =   0
      Visible         =   0   'False
      X1              =   90
      X2              =   690
      Y1              =   390
      Y2              =   390
   End
   Begin VB.Line linBorda 
      BorderColor     =   &H80000015&
      Index           =   3
      X1              =   60
      X2              =   1170
      Y1              =   300
      Y2              =   300
   End
   Begin VB.Line linBorda 
      BorderColor     =   &H80000015&
      Index           =   2
      X1              =   60
      X2              =   1170
      Y1              =   240
      Y2              =   240
   End
   Begin VB.Line linBorda 
      BorderColor     =   &H80000014&
      Index           =   1
      X1              =   90
      X2              =   1200
      Y1              =   150
      Y2              =   150
   End
   Begin VB.Line linBorda 
      BorderColor     =   &H80000014&
      Index           =   0
      X1              =   90
      X2              =   1200
      Y1              =   60
      Y2              =   60
   End
   Begin VB.Image Image1 
      Height          =   480
      Left            =   360
      Top             =   120
      Width           =   480
   End
End
Attribute VB_Name = "GPainel"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'* Sistema...: Emissor de MDF-e (Layout 3.00)
'* Empresa...: Ygor Eduardo Dellalio
'* Módulo....: GPainel
'* Função....: Painel 3-D
'* CopyRight.: (C)2024 Ygor Eduardo Dellalio
'* Criação...: GAS-2007 - Gerador Automático de Sistemas
'* Data......: 05/09/2024 18:10:20
'* * * * * * *
Option Explicit
DefInt A-Z

'BevelOuter, BevelInner
Enum GPanTipoBorda
   None
   Inset
   Raised
End Enum

' mousepointer
Enum GPabTipoMouse
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

Const m_def_BevelOuter = 2
Const m_def_BevelInner = 0
Const m_def_BevelWidth = 1
Const m_def_BorderWidth = 1

'Dim m_AutoRedraw As Boolean
Dim m_BevelOuter As GPanTipoBorda
Dim m_BevelInner As GPanTipoBorda
Dim m_BevelWidth As Integer
Dim m_BorderWidth As Integer
Const m_def_ToolTipText = ""

'Property Variables:
Dim m_ToolTipText As String

'Event Declarations:
Event Resize()
Event Click()
Event DblClick()
Event MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
Event MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
Event MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)

Sub TrataBevelWidth()
   Dim i As Integer
   For i = 0 To 3
      If m_BevelWidth = 0 Then
         linBorda(i).Visible = False
         linDentro(i).Visible = False
      Else
         linBorda(i).Visible = True
         linBorda(i).Visible = True
         linBorda(i).BorderWidth = m_BevelWidth
         linDentro(i).BorderWidth = m_BevelWidth
      End If
   Next
End Sub

Public Sub Refresh()
   UserControl_Resize
End Sub

Public Property Get BevelOuter() As GPanTipoBorda
Attribute BevelOuter.VB_Description = "Returns/sets the border style for an object."
   BevelOuter = m_BevelOuter
End Property

Public Property Let BevelOuter(ByVal New_BevelOuter As GPanTipoBorda)
   m_BevelOuter = New_BevelOuter
   PropertyChanged "BevelOuter"
   UserControl_Resize
End Property

Public Property Get BevelInner() As GPanTipoBorda
   BevelInner = m_BevelInner
End Property

Public Property Let BevelInner(ByVal New_BevelInner As GPanTipoBorda)
   m_BevelInner = New_BevelInner
   PropertyChanged "BevelInner"
   UserControl_Resize
End Property

Public Property Get BackStyle() As Integer
   BackStyle = UserControl.BackStyle
End Property

Public Property Let BackStyle(ByVal New_BackStyle As Integer)
   UserControl.BackStyle = New_BackStyle
   PropertyChanged "BackStyle"
End Property

Public Property Get BevelWidth() As Integer
Attribute BevelWidth.VB_Description = "Returns or sets the width of a control's border."
   BevelWidth = m_BevelWidth
End Property

Public Property Let BevelWidth(ByVal New_BevelWidth As Integer)
   If New_BevelWidth > 3 Then New_BevelWidth = 3    'limita 0 - 3 (até mudar lógica trabalhando com linhas ao invés de largura)
   If New_BevelWidth < 0 Then New_BevelWidth = 0
   m_BevelWidth = New_BevelWidth
   PropertyChanged "BevelWidth"
   TrataBevelWidth
   UserControl_Resize
End Property

Public Property Get BorderWidth() As Integer
   BorderWidth = m_BorderWidth
End Property

Public Property Let BorderWidth(ByVal New_BorderWidth As Integer)
   If New_BorderWidth < 0 Then New_BorderWidth = 0
   If New_BorderWidth > 16 Then New_BorderWidth = 16    'limita 1-16  ??
   m_BorderWidth = New_BorderWidth
   PropertyChanged "BorderWidth"
   UserControl_Resize
End Property

Private Sub Image1_Click()
   RaiseEvent Click
End Sub

Private Sub Image1_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
   RaiseEvent MouseDown(Button, Shift, x, y)
End Sub

Private Sub Image1_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
   RaiseEvent MouseMove(Button, Shift, x, y)
End Sub

Private Sub Image1_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
   RaiseEvent MouseUp(Button, Shift, x, y)
End Sub

'Initialize Properties for User Control
Private Sub UserControl_InitProperties()
   m_BevelOuter = m_def_BevelOuter
   m_BevelInner = m_def_BevelInner
   m_BevelWidth = m_def_BevelWidth
   m_BorderWidth = m_def_BorderWidth
   UserControl_Resize
   m_ToolTipText = m_def_ToolTipText
End Sub

'Load property values from storage
Private Sub UserControl_ReadProperties(PropBag As PropertyBag)
   m_BevelOuter = PropBag.ReadProperty("BevelOuter", m_def_BevelOuter)
   m_BevelInner = PropBag.ReadProperty("BevelInner", m_def_BevelInner)
   m_BevelWidth = PropBag.ReadProperty("BevelWidth", m_def_BevelWidth)
   m_BorderWidth = PropBag.ReadProperty("BorderWidth", m_def_BorderWidth)
   Set Image1.Picture = PropBag.ReadProperty("Picture", Nothing)
   Image1.Stretch = PropBag.ReadProperty("Stretch", False)
   UserControl.BackColor = PropBag.ReadProperty("BackColor", &H8000000F)
   UserControl.Enabled = PropBag.ReadProperty("Enabled", True)
   UserControl.MousePointer = PropBag.ReadProperty("MousePointer", 0)
   UserControl.AutoRedraw = PropBag.ReadProperty("AutoRedraw", False)
   UserControl.BackStyle = PropBag.ReadProperty("BackStyle", 1)
   Set UserControl.MouseIcon = PropBag.ReadProperty("MouseIcon", Nothing)
   m_ToolTipText = PropBag.ReadProperty("ToolTipText", m_def_ToolTipText)
   TrataBevelWidth
   UserControl_Resize
End Sub

Private Sub AjustaBordas()
   Dim dX As Integer, dy As Integer, DbX As Integer, DbY As Integer, i As Integer
   Dim LuzO As Long, LuzI As Long, SombraO As Long, SombraI As Long, x1 As Integer, y1 As Integer
   If UserControl.Width < 240 Then UserControl.Width = 240
   If UserControl.Height < 240 Then UserControl.Height = 240
   
   dX = (linBorda(0).BorderWidth * Screen.TwipsPerPixelX / 2)
   dy = (linBorda(0).BorderWidth * Screen.TwipsPerPixelY / 2)
   DbX = m_BorderWidth * Screen.TwipsPerPixelX
   DbY = m_BorderWidth * Screen.TwipsPerPixelY
   x1 = IIf(m_BevelWidth = 1, 15, 0)
   y1 = IIf(m_BevelWidth = 1, 15, 0)
   
   If m_BevelOuter <> None Then
   
      'cores para bevel outer
      Select Case m_BevelOuter
         Case 0                                   'none
            LuzO = vbButtonFace
            SombraO = vbButtonFace
         Case 1                                   'inset
            LuzO = vbButtonShadow
            SombraO = vb3DHighlight
         Case 2                                   'raised
            LuzO = vb3DHighlight
            SombraO = vbButtonShadow
      End Select
      
      For i = 0 To 3
         linDentro(i).x1 = 1000
         linDentro(i).y1 = 1000
         linDentro(i).X2 = 500
         linDentro(i).Y2 = 500
      Next
      
      'Outer esq
      linBorda(0).BorderColor = LuzO
      linBorda(0).x1 = dX - x1
      linBorda(0).y1 = dy - y1
      linBorda(0).X2 = dX - x1
      linBorda(0).Y2 = UserControl.ScaleHeight - dy - y1
      'Outer topo
      linBorda(1).BorderColor = LuzO
      linBorda(1).x1 = dX - x1 - Screen.TwipsPerPixelX
      linBorda(1).y1 = dy - y1
      linBorda(1).X2 = UserControl.ScaleWidth - dX - x1
      linBorda(1).Y2 = dy - y1
      'Outer dir
      linBorda(2).BorderColor = SombraO
      linBorda(2).x1 = UserControl.ScaleWidth - dX
      linBorda(2).y1 = dy - y1
      linBorda(2).X2 = UserControl.ScaleWidth - dX
      linBorda(2).Y2 = UserControl.ScaleHeight - dy - y1
      'Outer fundo
      linBorda(3).BorderColor = SombraO
      linBorda(3).x1 = dX - x1
      linBorda(3).y1 = UserControl.ScaleHeight - dy
      linBorda(3).X2 = UserControl.ScaleWidth - dX
      linBorda(3).Y2 = UserControl.ScaleHeight - dy
      For i = 0 To 3
         linBorda(i).Visible = True
      Next
   Else
      dX = 0
      dy = 0
      For i = 0 To 3
         linBorda(i).Visible = False
      Next
   End If

   If m_BevelInner <> None Then
      'cores para bevel inner
      Select Case m_BevelInner
         Case 0                                   'none
            LuzI = vbButtonFace
            SombraI = vbButtonFace
         Case 1                                   'inset
            LuzI = vbButtonShadow
            SombraI = vb3DHighlight
         Case 2                                   'raised
            LuzI = vb3DHighlight
            SombraI = vbButtonShadow
      End Select
   
      'Inner esq
      linDentro(0).Visible = False
      linDentro(0).BorderColor = LuzI
      linDentro(0).x1 = (3 * dX + DbX) - x1
      linDentro(0).y1 = (3 * dy + DbY) - y1
      linDentro(0).X2 = (3 * dX + DbX) - x1
      linDentro(0).Y2 = UserControl.ScaleHeight - (3 * dy + DbY) - y1
      linDentro(0).Visible = True
      'Inner topo
      linDentro(1).BorderColor = LuzI
      linDentro(1).x1 = (3 * dX + DbX) - x1
      linDentro(1).y1 = (3 * dy + DbY) - y1
      linDentro(1).X2 = UserControl.ScaleWidth - (3 * dX + DbX) - x1
      linDentro(1).Y2 = (3 * dy + DbY) - y1
      'Inner dir
      linDentro(2).BorderColor = SombraI
      linDentro(2).x1 = UserControl.ScaleWidth - (3 * dX + DbX)
      linDentro(2).y1 = (3 * dy + DbY)
      linDentro(2).X2 = UserControl.ScaleWidth - (3 * dX + DbX)
      linDentro(2).Y2 = UserControl.ScaleHeight - (3 * dy + DbY)
      'Inner fundo
      linDentro(3).BorderColor = SombraI
      linDentro(3).x1 = (3 * dX + DbX) - x1
      linDentro(3).y1 = UserControl.ScaleHeight - (3 * dy + DbY)
      linDentro(3).X2 = UserControl.ScaleWidth - (3 * dX + DbX)
      linDentro(3).Y2 = UserControl.ScaleHeight - (3 * dy + DbY)
      For i = 0 To 3
         linDentro(i).Visible = True
      Next
   Else
      linDentro(0).x1 = 0                         'fazemos conta com isto...
      linDentro(1).y1 = 0
      For i = 0 To 3
         linDentro(i).Visible = False
      Next
   End If
   Image1.Width = (UserControl.Width - 2 * (linDentro(0).x1 + dX)) + Screen.TwipsPerPixelX
   Image1.Height = (UserControl.Height - 2 * (linDentro(1).y1 + dy)) + Screen.TwipsPerPixelY
   Image1.Move (linDentro(0).x1 + dX), linDentro(1).y1 + dy

End Sub

Private Sub UserControl_Resize()
   AjustaBordas
End Sub

'Write property values to storage
Private Sub UserControl_WriteProperties(PropBag As PropertyBag)
   Call PropBag.WriteProperty("BevelOuter", m_BevelOuter, m_def_BevelOuter)
   Call PropBag.WriteProperty("BevelInner", m_BevelInner, m_def_BevelInner)
   Call PropBag.WriteProperty("BevelWidth", m_BevelWidth, m_def_BevelWidth)
   Call PropBag.WriteProperty("BorderWidth", m_BorderWidth, m_def_BorderWidth)
   Call PropBag.WriteProperty("Picture", Image1.Picture, Nothing)
   Call PropBag.WriteProperty("Stretch", Image1.Stretch, False)
   Call PropBag.WriteProperty("BackColor", UserControl.BackColor, &H8000000F)
   Call PropBag.WriteProperty("Enabled", UserControl.Enabled, True)
   Call PropBag.WriteProperty("MousePointer", UserControl.MousePointer, 0)
   Call PropBag.WriteProperty("AutoRedraw", UserControl.AutoRedraw, False)
   Call PropBag.WriteProperty("BackStyle", UserControl.BackStyle, 1)
   Call PropBag.WriteProperty("MouseIcon", UserControl.MouseIcon, Nothing)
   Call PropBag.WriteProperty("ToolTipText", m_ToolTipText, m_def_ToolTipText)
End Sub

Public Property Get hWnd() As Long
Attribute hWnd.VB_Description = "Returns a handle (from Microsoft Windows) to an object's window."
   hWnd = UserControl.hWnd
End Property

Public Property Get BackColor() As OLE_COLOR
Attribute BackColor.VB_Description = "Returns/sets the background color used to display text and graphics in an object."
   BackColor = UserControl.BackColor
End Property

Public Property Let BackColor(ByVal New_BackColor As OLE_COLOR)
   UserControl.BackColor() = New_BackColor
   PropertyChanged "BackColor"
End Property

Public Property Get Enabled() As Boolean
Attribute Enabled.VB_Description = "Returns/sets a value that determines whether an object can respond to user-generated events."
   Enabled = UserControl.Enabled
End Property

Public Property Let Enabled(ByVal New_Enabled As Boolean)
   UserControl.Enabled() = New_Enabled
   PropertyChanged "Enabled"
End Property

Public Property Get MousePointer() As GPabTipoMouse
Attribute MousePointer.VB_Description = "Returns/sets the type of mouse pointer displayed when over part of an object."
   MousePointer = UserControl.MousePointer
End Property

Public Property Let MousePointer(ByVal New_MousePointer As GPabTipoMouse)
   UserControl.MousePointer() = New_MousePointer
   PropertyChanged "MousePointer"
End Property

Public Property Get hdc() As Long
Attribute hdc.VB_Description = "Returns a handle (from Microsoft Windows) to the object's device context."
   hdc = UserControl.hdc
End Property

Public Property Get AutoRedraw() As Boolean
Attribute AutoRedraw.VB_Description = "Returns/sets the output from a graphics method to a persistent bitmap."
   AutoRedraw = UserControl.AutoRedraw
End Property

Public Property Let AutoRedraw(ByVal New_AutoRedraw As Boolean)
   UserControl.AutoRedraw() = New_AutoRedraw
   PropertyChanged "AutoRedraw"
End Property

Public Property Get Picture() As Picture
Attribute Picture.VB_Description = "Returns/sets a graphic to be displayed in a control."
   Set Picture = Image1.Picture
End Property

Public Property Set Picture(ByVal New_Picture As Picture)
   Set Image1.Picture = New_Picture
   PropertyChanged "Picture"
   UserControl_Resize
End Property

Public Property Get MouseIcon() As Picture
Attribute MouseIcon.VB_Description = "Sets a custom mouse icon."
   Set MouseIcon = UserControl.MouseIcon
End Property

Public Property Set MouseIcon(ByVal New_MouseIcon As Picture)
   Set UserControl.MouseIcon = New_MouseIcon
   PropertyChanged "MouseIcon"
End Property

Private Sub UserControl_Click()
   RaiseEvent Click
End Sub

Private Sub UserControl_DblClick()
   RaiseEvent DblClick
End Sub

Private Sub UserControl_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
   RaiseEvent MouseDown(Button, Shift, x, y)
End Sub

Private Sub UserControl_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
   RaiseEvent MouseMove(Button, Shift, x, y)
End Sub

Private Sub UserControl_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
   RaiseEvent MouseUp(Button, Shift, x, y)
End Sub

Public Property Get Stretch() As Boolean
Attribute Stretch.VB_Description = "Returns/sets a value that determines whether a graphic resizes to fit the size of an Image control."
   Stretch = Image1.Stretch
End Property

Public Property Let Stretch(ByVal New_Stretch As Boolean)
   Image1.Stretch() = New_Stretch
   PropertyChanged "Stretch"
   UserControl_Resize
End Property

Public Property Get ToolTipText() As String
Attribute ToolTipText.VB_Description = "Returns/sets the text displayed when the mouse is paused over the control."
   ToolTipText = m_ToolTipText
End Property

Public Property Let ToolTipText(ByVal New_ToolTipText As String)
   m_ToolTipText = New_ToolTipText
   PropertyChanged "ToolTipText"
End Property

