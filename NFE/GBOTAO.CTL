VERSION 5.00
Begin VB.UserControl GBotao 
   ClientHeight    =   705
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   660
   ScaleHeight     =   705
   ScaleWidth      =   660
   ToolboxBitmap   =   "GBOTAO.CTX":0000
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Interval        =   200
      Left            =   420
      Top             =   30
   End
   Begin VB.Line linLeft 
      BorderColor     =   &H00FF0000&
      Index           =   0
      Visible         =   0   'False
      X1              =   30
      X2              =   30
      Y1              =   690
      Y2              =   1080
   End
   Begin VB.Line linLeft 
      BorderColor     =   &H00FF0000&
      Index           =   1
      Visible         =   0   'False
      X1              =   90
      X2              =   90
      Y1              =   720
      Y2              =   1110
   End
   Begin VB.Line linTop 
      BorderColor     =   &H00FF0000&
      Index           =   1
      Visible         =   0   'False
      X1              =   -300
      X2              =   210
      Y1              =   1020
      Y2              =   1020
   End
   Begin VB.Line linTop 
      BorderColor     =   &H00FF0000&
      Index           =   0
      Visible         =   0   'False
      X1              =   -330
      X2              =   210
      Y1              =   960
      Y2              =   960
   End
   Begin VB.Line linDir 
      Visible         =   0   'False
      X1              =   -60
      X2              =   180
      Y1              =   870
      Y2              =   870
   End
   Begin VB.Line linFdo 
      Visible         =   0   'False
      X1              =   -60
      X2              =   180
      Y1              =   930
      Y2              =   930
   End
   Begin VB.Line LinB 
      BorderColor     =   &H80000014&
      Index           =   0
      X1              =   -660
      X2              =   90
      Y1              =   90
      Y2              =   90
   End
   Begin VB.Line LinB 
      BorderColor     =   &H80000014&
      Index           =   1
      X1              =   90
      X2              =   -660
      Y1              =   150
      Y2              =   150
   End
   Begin VB.Line LinB 
      BorderColor     =   &H80000014&
      Index           =   2
      X1              =   -660
      X2              =   90
      Y1              =   210
      Y2              =   210
   End
   Begin VB.Line LinB 
      BorderColor     =   &H80000014&
      Index           =   3
      X1              =   -660
      X2              =   90
      Y1              =   270
      Y2              =   270
   End
   Begin VB.Image img 
      Enabled         =   0   'False
      Height          =   480
      Index           =   3
      Left            =   60
      Top             =   240
      Visible         =   0   'False
      Width           =   450
   End
   Begin VB.Image img 
      Enabled         =   0   'False
      Height          =   480
      Index           =   2
      Left            =   -300
      Top             =   240
      Visible         =   0   'False
      Width           =   480
   End
   Begin VB.Image img 
      Enabled         =   0   'False
      Height          =   480
      Index           =   1
      Left            =   60
      Top             =   0
      Visible         =   0   'False
      Width           =   480
   End
   Begin VB.Image img 
      Enabled         =   0   'False
      Height          =   480
      Index           =   0
      Left            =   -300
      Top             =   0
      Width           =   480
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Height          =   195
      Left            =   0
      TabIndex        =   0
      Top             =   630
      Width           =   45
   End
End
Attribute VB_Name = "GBotao"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'* Sistema...: Emissor de MDF-e (Layout 3.00)
'* Empresa...: Ygor Eduardo Dellalio
'* Módulo....: GBotao
'* Função....: Controle de botão
'* CopyRight.: (C)2024 Ygor Eduardo Dellalio
'* Criação...: GAS-2007 - Gerador Automático de Sistemas
'* Data......: 05/09/2024 18:10:19
'* * * * * * *
Option Explicit

'propriedades default
Const m_def_CaptionAlign = 0
Const m_def_ButtonStyle = 0
Const m_def_ButtonType = 0
Const m_def_CaptionOffset = 30
Const m_def_GroupItem = 0
Const m_def_Value = False
Const m_def_LeftSeparator = 0
Const m_def_TopSeparator = 0
Const m_def_JoinSeparators = 0
Const m_def_ShowFocus = -1
Const m_def_Locked = False
Const m_def_Stretch = False
Const m_def_GroupName = ""

'qde pixels para afundar botão
Const AFUNDA_PIC = 15

'constantes para a aparência do botão
Const B_Desativa = 0
Const B_Baixo = 1
Const B_Cima = 2

'imgs
Const I_Enabled = 0
Const I_Disabled = 1
Const I_Down = 2
Const I_MouseOver = 3

' opções para CaptionAlign
Enum GBotPosiCaption
   Center
   [Bottom edge]
   [Left edge]
   [Top edge]
   [Right edge]
End Enum

' mousepointer
Enum GBotTipoMouse
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

'estilo do botão
Enum GBotEstilo
   Normal
   VB5
End Enum

'estilo do botão
Enum GBotJuntaSeparadores
   None
   Horizontal
   Vertical
End Enum

' tipo
Enum GBotTipo
   [Push button]
   [Two state]
End Enum

'para pegar o tamanho do BITMAP
Private Type BITMAP                                '14 bytes
   bmType As Long
   bmWidth As Long
   bmHeight As Long
   bmWidthBytes As Long
   bmPlanes As Integer
   bmBitsPixel As Integer
   bmBits As Long
End Type

'para API's
Private Type POINTAPI
   x As Long
   y As Long
End Type

'estrutura e API's para pegar/testar coordenadas mouse
Private Type RECT
   Left As Long
   Top As Long
   Right As Long
   Bottom As Long
End Type

'desenha foco
Private Declare Function GetWindowRect Lib "user32" (ByVal hWnd As Long, lpRect As RECT) As Long
Private Declare Function DrawFocusRect Lib "user32" (ByVal hdc As Long, lpRect As RECT) As Long
Private Declare Function GetCursorPos& Lib "user32" (Pt As POINTAPI)

'para pegar tamanho do objeto
Private Declare Function GetObject Lib "GDI32" Alias "GetObjectA" (ByVal hObject As Long, ByVal nCount As Long, lpObject As Any) As Long

' Publicas da classe
Dim TemBotao As Long
Dim Rodando As Boolean                             'para testar ambient.user.mode
Dim BtAt As Boolean
Dim CtTimer As Boolean
Dim CtAtivo As Boolean

'Property Variables:
Dim m_CaptionAlign As GBotPosiCaption
Dim m_ButtonStyle As GBotEstilo
Dim m_ButtonType As GBotTipo
Dim m_CaptionOffset As Integer
Dim m_GroupItem As Integer
Dim m_Value As Boolean
Dim m_LeftSeparator As Boolean
Dim m_TopSeparator As Boolean
Dim m_JoinSeparators As GBotJuntaSeparadores
Dim m_ShowFocus As Boolean
Dim m_Locked As Boolean
Dim m_Stretch As Boolean
Dim m_GroupName As String
Dim m_Enabled As Boolean
Dim m_ForeColor As Long

Dim LargImgOriginal As Single, AltImgOriginal As Single
Dim EmCima As Integer                              ' indica se botão está em cima
Dim LargSeparador As Integer                       ' largura dos separadores
Dim JaSomou As Integer                             ' flag p/ controlar afundamento botão
Dim qPic As Integer                                ' armazena qual pic a defasar no mouse down
Dim LeuProps As Boolean                            ' flag
Dim TecEsp As Boolean                              ' tecla espaço com botão com foco para clicar
Dim mCoord As POINTAPI, pCoord As POINTAPI
Dim RetPic As RECT
Dim bmp As BITMAP
Dim lBmp(3) As Long, aBmp(3) As Long
Dim ComFoco As Boolean, IgnoreMouseUp As Boolean
Dim aButton As Integer, aShift As Integer, aX As Single, aY As Single

' declarações do eventos
Event Click()
Event MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
Event MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
Event MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
Event KeyDown(KeyCode As Integer, Shift As Integer)
Event KeyPress(KeyAscii As Integer)
Event KeyUp(KeyCode As Integer, Shift As Integer)

Public Property Get BackColor() As OLE_COLOR
   BackColor = UserControl.BackColor
End Property

'handle do controle
Public Property Get hWnd() As Long
   hWnd = UserControl.hWnd
End Property

'handle do controle
Public Property Get hdc() As Long
   hdc = UserControl.hdc
End Property

Public Property Let BackColor(ByVal New_BackColor As OLE_COLOR)
   UserControl.BackColor() = New_BackColor
   PropertyChanged "BackColor"
   UserControl_Resize
End Property

Public Property Get ForeColor() As OLE_COLOR
   ForeColor = m_ForeColor
End Property

Public Property Let ForeColor(ByVal New_ForeColor As OLE_COLOR)
   m_ForeColor = New_ForeColor
   If m_Enabled Then
      Label1.ForeColor = m_ForeColor
   End If
   PropertyChanged "ForeColor"
End Property

Public Property Get WhatsThisHelpID() As Long
   WhatsThisHelpID = UserControl.Extender.WhatsThisHelpID
End Property

Public Property Let WhatsThisHelpID(ByVal New_WhatsThisHelpID As Long)
   UserControl.Extender.WhatsThisHelpID() = New_WhatsThisHelpID
   PropertyChanged "WhatsThisHelpID"
End Property

Public Property Get Enabled() As Boolean
   Enabled = m_Enabled
End Property

Public Property Let Enabled(ByVal New_Enabled As Boolean)
   m_Enabled = New_Enabled
   Label1.Enabled = m_Enabled
   If img(I_Disabled).Picture <> 0 Then              'se tem imagem desativado
      img(I_Enabled).Visible = m_Enabled             'ajusta figuras enabled/disabled
      img(I_Disabled).Visible = (Not m_Enabled)
      Label1.ZOrder 0                                'caption sempre em cima
      UserControl.Refresh
   End If
   If Label1.Enabled Then
      Label1.ForeColor = m_ForeColor
   Else
      UserControl.Cls
      Label1.ForeColor = vbButtonShadow
   End If
   UserControl_Resize
   PropertyChanged "Enabled"
End Property

Public Sub AtivaBotao()
   GetCursorPos mCoord
   GetWindowRect UserControl.hWnd, RetPic
   If mCoord.x < RetPic.Left Or mCoord.x > RetPic.Right Or _
      mCoord.y < RetPic.Top Or mCoord.y > RetPic.Bottom Then
      If BtAt Then
         If Me.ButtonType = [Push button] And EmCima = B_Cima Then
            Me.PoeBorda B_Desativa
            'mostra figura em cima, em botoes vb5, se tiver
            If img(I_MouseOver).Picture <> 0 And img(I_Enabled).Picture <> 0 Then
               img(I_Enabled).Visible = True
               Label1.ZOrder 0
               img(I_MouseOver).Visible = False
            End If
         Else
            If m_Value Then
               UserControl.BackColor = &H8000000F
               PoeBorda B_Baixo
            Else
               UserControl.BackColor = vbButtonFace
               PoeBorda B_Desativa
            End If
         End If
      End If
   End If
End Sub

Public Sub LigaDeslTimer(Sta As Boolean)
   Timer1.Enabled = Sta
End Sub

Private Sub img_Click(Index As Integer)
   UserControl_Click
End Sub

Private Sub img_DblClick(Index As Integer)
   UserControl_DblClick
End Sub

Private Sub img_MouseDown(Index As Integer, Button As Integer, Shift As Integer, x As Single, y As Single)
   UserControl_MouseDown Button, Shift, x, y
End Sub

Private Sub img_MouseMove(Index As Integer, Button As Integer, Shift As Integer, x As Single, y As Single)
   UserControl_MouseMove Button, Shift, x, y
End Sub

Private Sub img_MouseUp(Index As Integer, Button As Integer, Shift As Integer, x As Single, y As Single)
   UserControl_MouseUp Button, Shift, x, y
End Sub

Private Sub Label1_Click()
   UserControl_Click
End Sub

Private Sub Label1_DblClick()
   UserControl_DblClick
End Sub

Private Sub Label1_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
   UserControl_MouseDown Button, Shift, x, y
End Sub

Private Sub Label1_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
   UserControl_MouseMove Button, Shift, x, y
End Sub

Private Sub Label1_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
   UserControl_MouseUp Button, Shift, x, y
End Sub

Private Sub UserControl_DblClick()
   UserControl_MouseDown aButton, aShift, aX, aY
   UserControl_MouseUp aButton, aShift, aX, aY
   UserControl_Click
End Sub

Private Sub UserControl_EnterFocus()
   If m_Enabled Then
      ComFoco = True
      PoeFoco
   Else
      TiraFoco
   End If
End Sub

Private Sub UserControl_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
   Dim SOk As Boolean
   SOk = True
   If m_Enabled Then
      If m_LeftSeparator Then SOk = (x >= LargSeparador)
      If m_TopSeparator Then SOk = SOk And (y >= LargSeparador)
      If SOk Then
         GMouseMove Button
         RaiseEvent MouseMove(Button, Shift, x, y)
      End If
   End If
End Sub

Private Sub Timer1_Timer()
   If CtAtivo Then
      Me.AtivaBotao
   End If
End Sub

Private Sub GMouseMove(Button As Integer)
   If Rodando = False Then Exit Sub                  'sai se em design time...
   If m_Locked Or m_Enabled = False Then Exit Sub    'botão bloqueado não desce nunca!
   If TemBotao <> UserControl.hWnd And TemBotao <> 0 And BtAt Then
      If Me.Value Then
         Me.PoeBorda B_Baixo
      Else
         Me.PoeBorda B_Desativa
      End If
   End If
   If m_ButtonStyle = VB5 And Button = 0 Then        'se estilo VB5 e nenhum botao
      If EmCima <> B_Cima Then
         If m_ButtonType = [Push button] Or m_Value = False Then
            PoeBorda B_Cima
            'mostra figura mouseover, em botoes vb5, se tiver
            If img(I_MouseOver).Picture <> 0 Then
               img(I_MouseOver).Visible = True
               Label1.ZOrder 0
               img(I_Enabled).Visible = False
            End If
         End If
      End If
      If m_ButtonType = [Two state] And m_Value Then
         If UserControl.BackColor <> vbButtonFace Then
            UserControl.BackColor = vbButtonFace     ' troca a cor para botão
            PoeBorda B_Baixo
         End If
      End If
      CtAtivo = True
      If CtTimer Then
         Me.LigaDeslTimer True
      End If
      TemBotao = UserControl.hWnd
      BtAt = True
   End If
   DoEvents
End Sub

Private Sub GMouseDown(Button As Integer)
   'botão bloqueado não desce nunca!
   If m_Locked Or m_Enabled = False Then Exit Sub
   'botão de dois estágios, que pertença a um grupo e com valor true, não aceita clique (os outros o levantam)
   If m_ButtonType = [Two state] And m_Value = True And Len(m_GroupName) > 0 Then Exit Sub
   If Button = vbLeftButton Then
      If img(I_Down).Picture <> 0 Then                 'se há pic down,
         qPic = I_Down                                 'é ela quem iremos defasar
      Else                                             'senão,
         If m_ButtonStyle = VB5 And _
          img(I_MouseOver).Picture <> 0 Then
            qPic = I_MouseOver
         Else
            qPic = I_Enabled                           'defasa a picture enabled
         End If
      End If
      If JaSomou Or (m_ButtonType = [Two state] And m_Value) Then
         img(qPic).Left = img(qPic).Left - AFUNDA_PIC
         img(qPic).Top = img(qPic).Top - AFUNDA_PIC
         Label1.Left = Label1.Left - AFUNDA_PIC
         Label1.Top = Label1.Top - AFUNDA_PIC
         JaSomou = False
      Else
         img(qPic).Left = img(qPic).Left + AFUNDA_PIC
         img(qPic).Top = img(qPic).Top + AFUNDA_PIC
         Label1.Left = Label1.Left + AFUNDA_PIC
         Label1.Top = Label1.Top + AFUNDA_PIC
         JaSomou = True
      End If
   End If
   If m_ButtonType = [Two state] Then                  'se de dois estagios
      m_Value = (Not m_Value)
      If m_Value Then
         UserControl.BackColor = &H8000000F            'cinza
         If Len(m_GroupName) > 0 Then                  'tem nome de grupo, vamos levantar os demais no form...
            m_GroupItem = 1
            LevantaOsOutros m_GroupName
            m_GroupItem = 0
         End If
         PoeBorda B_Baixo
      Else
         UserControl.BackColor = vbButtonFace          'cinza
         PoeBorda B_Cima
      End If
   Else
      PoeBorda B_Baixo
   End If
End Sub

'levanta os botões
Private Sub LevantaOsOutros(GrName As String)
   Dim Bt As Object
   For Each Bt In UserControl.Parent.Controls
      If TypeOf Bt Is GBotao Then
         If Bt.ButtonType = [Two state] And Bt.GroupName = GrName And _
            Bt.GroupItem = 0 And Bt.Value Then
            Bt.Value = False                               'levanta
         End If
      End If
   Next
End Sub

Private Sub GMouseUp(Button As Integer)
   If m_Locked Or m_Enabled = False Then Exit Sub    'botão bloqueado não desce nunca!
   If m_ButtonType <> [Two state] Then
      If Button = vbLeftButton And JaSomou Then
         img(qPic).Left = img(qPic).Left - AFUNDA_PIC
         img(qPic).Top = img(qPic).Top - AFUNDA_PIC
         Label1.Left = Label1.Left - AFUNDA_PIC
         Label1.Top = Label1.Top - AFUNDA_PIC
         JaSomou = False
      End If
      If m_ButtonStyle = Normal Then
         PoeBorda B_Cima
      Else
         PoeBorda B_Desativa
      End If
   End If
End Sub

Public Sub Refresh()
   UserControl.Refresh
End Sub

Private Sub PoeSeparador()
   Dim Ps As Integer, i As Integer, Cor(1) As Long, Ls As Integer, Xy As Single
   ' mostra separadores, se tiver
   If m_LeftSeparator Then
      Ls = linLeft(0).BorderWidth * Screen.TwipsPerPixelX + 7
      Ps = (LargSeparador / 2) - Ls
      Cor(0) = vbButtonShadow
      Cor(1) = vb3DHighlight
      If m_JoinSeparators = None Or m_JoinSeparators = Horizontal Then
         Xy = 0
      Else
         Xy = ((LargSeparador / 2) + (linTop(0).BorderWidth * Screen.TwipsPerPixelY + 7)) * Abs(m_TopSeparator)
      End If
      For i = 0 To 1
         linLeft(i).BorderColor = Cor(i)
         linLeft(i).x1 = Ps - (Ls * (i = 1))
         linLeft(i).y1 = IIf(m_JoinSeparators, Xy, LargSeparador * Abs(m_TopSeparator))
         linLeft(i).X2 = Ps - (Ls * (i = 1))
         linLeft(i).Y2 = UserControl.Height - (LargSeparador * m_TopSeparator)
         linLeft(i).Visible = True
      Next
   End If
   If m_TopSeparator Then
      Ls = linTop(0).BorderWidth * Screen.TwipsPerPixelY + 7
      Ps = (LargSeparador / 2) - Ls
      Cor(0) = vbButtonShadow
      Cor(1) = vb3DHighlight
      If m_JoinSeparators = None Or m_JoinSeparators = Vertical Then
         Xy = 0
      Else
         Xy = ((LargSeparador / 2) + (linLeft(0).BorderWidth * Screen.TwipsPerPixelX + 7)) * Abs(m_LeftSeparator)
      End If
      For i = 0 To 1
         linTop(i).BorderColor = Cor(i)
         linTop(i).y1 = Ps - (Ls * (i = 1))
         linTop(i).x1 = IIf(m_JoinSeparators, Xy, LargSeparador * Abs(m_LeftSeparator))
         linTop(i).Y2 = Ps - (Ls * (i = 1))
         linTop(i).X2 = (UserControl.Width + 15) - (LargSeparador * m_LeftSeparator)
         linTop(i).Visible = True
      Next
   End If
End Sub

Public Sub PoeBorda(Posicao As Integer)
   PoeB Posicao
   PoeFoco
End Sub

' desenha o botão
Private Sub PoeB(Posi As Integer)
   Dim Luz As Long, Sombra As Long, EmCimaAnt As Integer
   EmCimaAnt = EmCima
   On Error Resume Next
   Select Case Posi
      Case B_Baixo                                     'pressionado
         Luz = IIf(m_ButtonStyle = Normal, vb3DDKShadow, vbButtonShadow)
         Sombra = vb3DHighlight
         linDir.Visible = False
         linFdo.Visible = False
      Case B_Cima                                      'em cima
         Luz = vb3DHighlight
         Sombra = vbButtonShadow
         linDir.Visible = (m_ButtonStyle = Normal)
         linFdo.Visible = (m_ButtonStyle = Normal)
         UserControl.Extender.ZOrder 0
         If Err Then Err.Clear
      Case Else                                        'desativado (vb5)
         Luz = vbButtonFace
         Sombra = vbButtonFace
         If CtTimer Then
            Me.LigaDeslTimer False
         End If
         CtAtivo = False
         TemBotao = 0
   End Select
   If Posi = B_Baixo Then
      If img(I_Down).Picture <> 0 Then                 'se tem pic down
         img(I_Down).Visible = True                    'ajusta figuras enabled/disabled
         img(I_Enabled).Visible = False
         img(I_Disabled).Visible = False
         img(I_MouseOver).Visible = False
         Label1.ZOrder 0
      End If
   Else
      If m_Enabled Then
         If img(I_Enabled).Picture <> 0 Then           'se tem pic up
            img(I_Enabled).Visible = True
            img(I_Enabled).ZOrder 0
            img(I_Down).Visible = False
            img(I_Disabled).Visible = False
            img(I_MouseOver).Visible = False
            Label1.ZOrder 0
         End If
      Else
         If img(I_Disabled).Picture <> 0 Then
            img(I_Disabled).Visible = True
            img(I_Down).Visible = False
            img(I_Enabled).Visible = False
            img(I_MouseOver).Visible = False
            Label1.ZOrder 0
         End If
      End If
   End If
   EmCima = Posi

   'bordas
   With LinB(0)                                        'topo
      .BorderWidth = IIf(m_ButtonStyle = VB5, 1, 2)
      .BorderColor = Luz
      .x1 = IIf(m_LeftSeparator, LargSeparador + Screen.TwipsPerPixelX, 0)
      .y1 = IIf(m_TopSeparator, LargSeparador + Screen.TwipsPerPixelY, 0)
      .X2 = UserControl.Width
      .Y2 = IIf(m_TopSeparator, LargSeparador + Screen.TwipsPerPixelY, 0)
      .ZOrder 0
   End With
   With LinB(1)                                        'dir
      .BorderWidth = IIf(m_ButtonStyle = VB5, 1, 2)
      .BorderColor = Sombra
      .x1 = UserControl.Width - Screen.TwipsPerPixelX
      .y1 = IIf(m_TopSeparator, LargSeparador + Screen.TwipsPerPixelX, 0)
      .X2 = UserControl.Width - Screen.TwipsPerPixelX
      .Y2 = UserControl.Height
      .ZOrder 0
   End With
   With LinB(2)                                        'fundo
      .BorderWidth = IIf(m_ButtonStyle = VB5, 1, 2)
      .BorderColor = Sombra
      .x1 = Screen.TwipsPerPixelX + IIf(m_LeftSeparator, LargSeparador + Screen.TwipsPerPixelX, 0)
      .y1 = UserControl.Height - Screen.TwipsPerPixelY
      .X2 = UserControl.Width
      .Y2 = UserControl.Height - Screen.TwipsPerPixelY
      .ZOrder 0
   End With
   With LinB(3)                                        'Esq
      .BorderWidth = IIf(m_ButtonStyle = VB5, 1, 2)
      .BorderColor = Luz
      .x1 = IIf(m_LeftSeparator, LargSeparador + Screen.TwipsPerPixelX, 0)
      .y1 = IIf(m_TopSeparator, LargSeparador + Screen.TwipsPerPixelY, 0)
      .X2 = IIf(m_LeftSeparator, LargSeparador + Screen.TwipsPerPixelX, 0)
      .Y2 = UserControl.Height
      .ZOrder 0
   End With

   'poe parte mais escura em botões normais
   If m_ButtonStyle = Normal Then
      With linDir
         .x1 = UserControl.Width - Screen.TwipsPerPixelX
         .y1 = IIf(m_TopSeparator, LargSeparador + Screen.TwipsPerPixelY, 0)
         .X2 = UserControl.Width - Screen.TwipsPerPixelX
         .Y2 = UserControl.Height
         .ZOrder 0
      End With
      With linFdo
         .x1 = IIf(m_LeftSeparator, LargSeparador + Screen.TwipsPerPixelX, 0)
         .y1 = UserControl.Height - Screen.TwipsPerPixelY
         .X2 = UserControl.Width
         .Y2 = UserControl.Height - Screen.TwipsPerPixelY
         .ZOrder 0
      End With
   End If
   If EmCimaAnt <> EmCima Then
      UserControl.Refresh
   End If
End Sub

Private Sub UserControl_Click()
   If m_Enabled And Not IgnoreMouseUp Then
      If ButtonStyle = VB5 Then
         On Error Resume Next
         UserControl.Extender.Container.SetFocus
      End If
      RaiseEvent Click
   End If
End Sub

Private Sub UserControl_ExitFocus()
   ComFoco = False
   If m_ShowFocus And m_ButtonStyle = Normal Then
      UserControl.Cls
   End If
End Sub

Private Sub UserControl_Initialize()
   LeuProps = False
   m_Enabled = True
   LargSeparador = 120
   LargImgOriginal = img(0).Width                    'salva tamanho original para recompor qdo stretch = false
   AltImgOriginal = img(0).Height
End Sub

Private Sub UserControl_KeyDown(KeyCode As Integer, Shift As Integer)
   If m_Enabled Then
      If (KeyCode = vbKeySpace Or KeyCode = vbKeyReturn) And m_ButtonStyle = Normal And Not TecEsp Then
         TecEsp = True
         UserControl_MouseDown vbLeftButton, 0, 0, 0
      End If
      RaiseEvent KeyDown(KeyCode, Shift)
   End If
End Sub

Private Sub UserControl_KeyPress(KeyAscii As Integer)
   If m_Enabled Then
      RaiseEvent KeyPress(KeyAscii)
   End If
End Sub

Private Sub UserControl_KeyUp(KeyCode As Integer, Shift As Integer)
   If m_Enabled Then
      If (KeyCode = vbKeySpace Or KeyCode = vbKeyReturn) And TecEsp And m_ButtonStyle = Normal Then
         UserControl_MouseUp vbLeftButton, 0, 0, 0
      End If
      RaiseEvent KeyUp(KeyCode, Shift)
   End If
   TecEsp = False
End Sub

Public Property Get Caption() As String
   Caption = Label1.Caption
End Property

Public Property Let Caption(ByVal New_Caption As String)
   Dim p As Integer
   Label1.Caption() = New_Caption
   p = InStr(New_Caption, "&")
   If p > 0 And p < Len(New_Caption) Then            'designa tecla de atalho
      UserControl.AccessKeys = Mid$(New_Caption, p + 1, 1)
   End If
   Label1.Visible = (Len(New_Caption) > 0)           'torna o label visível
   UserControl_Resize
   PropertyChanged "Caption"
End Property

Public Property Get MousePointer() As GBotTipoMouse
   MousePointer = UserControl.MousePointer
End Property

Public Property Let MousePointer(ByVal New_MousePointer As GBotTipoMouse)
   UserControl.MousePointer = New_MousePointer
   PropertyChanged "MousePointer"
End Property

Public Property Get MouseIcon() As Picture
   Set MouseIcon = UserControl.MouseIcon
End Property

Public Property Set MouseIcon(ByVal New_MouseIcon As Picture)
   Set UserControl.MouseIcon() = New_MouseIcon
   PropertyChanged "MouseIcon"
End Property

'Initialize Properties for User Control
Private Sub UserControl_InitProperties()
   Rodando = False
   m_CaptionAlign = m_def_CaptionAlign
   m_ButtonStyle = m_def_ButtonStyle
   m_ButtonType = m_def_ButtonType
   m_CaptionOffset = m_def_CaptionOffset
   m_GroupName = m_def_GroupName
   m_GroupItem = m_def_GroupItem
   m_Value = m_def_Value
   m_LeftSeparator = m_def_LeftSeparator
   m_TopSeparator = m_def_TopSeparator
   m_JoinSeparators = m_def_JoinSeparators
   m_ShowFocus = m_def_ShowFocus
   m_Locked = m_def_Locked
   m_Stretch = m_def_Stretch
End Sub

Private Sub UserControl_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
   Dim SOk As Boolean
   aButton = Button
   aShift = Shift
   aX = x
   aY = y
   IgnoreMouseUp = False
   If m_Enabled Then
      SOk = True
      If m_LeftSeparator Then SOk = (x >= LargSeparador)
      If m_TopSeparator Then SOk = SOk And (y >= LargSeparador)
      If SOk Then
         GMouseDown Button
         RaiseEvent MouseDown(Button, Shift, x, y)
      End If
   Else
      IgnoreMouseUp = True
   End If
End Sub

Private Sub UserControl_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
   Dim SOk As Boolean
   If m_Enabled And Not IgnoreMouseUp Then
      SOk = True
      If m_LeftSeparator Then SOk = (x >= LargSeparador)
      If m_TopSeparator Then SOk = SOk And (y >= LargSeparador)
      If SOk Then
         GMouseUp Button
         RaiseEvent MouseUp(Button, Shift, x, y)
      End If

      'vamos forçar o disparo do evento click pq esse em alguns pontos (mouse down é disparado, em seguida mouse up, mas o click não dispara)
      UserControl_Click
      IgnoreMouseUp = True
   End If
End Sub

'Load property values from storage
Private Sub UserControl_ReadProperties(PropBag As PropertyBag)
   Dim i As Integer
   On Error Resume Next                              'tenta acabar com o erro cliente.site not available
   Rodando = UserControl.Ambient.UserMode
   If Err Then
      Rodando = False
      Err.Clear
   End If
   On Error GoTo 0
   ComFoco = False
   UserControl.BackColor = PropBag.ReadProperty("BackColor", &H8000000F)
   m_Enabled = PropBag.ReadProperty("Enabled", True)
   m_ForeColor = PropBag.ReadProperty("ForeColor", &H80000012)
   Set Label1.Font = PropBag.ReadProperty("Font", Ambient.Font)
   Label1.Caption = PropBag.ReadProperty("Caption", "")
   UserControl.MousePointer = PropBag.ReadProperty("MousePointer", 0)
   Set UserControl.MouseIcon = PropBag.ReadProperty("MouseIcon", Nothing)
   m_CaptionAlign = PropBag.ReadProperty("CaptionAlign", m_def_CaptionAlign)
   m_ButtonStyle = PropBag.ReadProperty("ButtonStyle", m_def_ButtonStyle)
   m_ButtonType = PropBag.ReadProperty("Buttontype", m_def_ButtonType)
   m_CaptionOffset = PropBag.ReadProperty("CaptionOffset", m_def_CaptionOffset)
   m_GroupName = PropBag.ReadProperty("GroupName", m_def_GroupName)
   m_GroupItem = PropBag.ReadProperty("GroupItem", m_def_GroupItem)
   m_Value = PropBag.ReadProperty("Value", m_def_Value)
   m_LeftSeparator = PropBag.ReadProperty("LeftSeparator", m_def_LeftSeparator)
   m_TopSeparator = PropBag.ReadProperty("TopSeparator", m_def_TopSeparator)
   m_JoinSeparators = PropBag.ReadProperty("JoinSeparators", m_def_JoinSeparators)
   m_ShowFocus = PropBag.ReadProperty("ShowFocus", m_def_ShowFocus)
   m_Locked = PropBag.ReadProperty("Locked", m_def_Locked)
   m_Stretch = PropBag.ReadProperty("Stretch", False)
   For i = I_Enabled To I_MouseOver
      img(i).Stretch = m_Stretch
   Next
   Set Picture = PropBag.ReadProperty("Picture", Nothing)
   Set PictureDisabled = PropBag.ReadProperty("PictureDisabled", Nothing)
   Set PictureDown = PropBag.ReadProperty("PictureDown", Nothing)
   Set PictureMouseOver = PropBag.ReadProperty("PictureMouseOver", Nothing)
   Label1.Visible = (Len(Label1.Caption) > 0)
   EmCima = B_Desativa
   If Rodando Then
      If CtTimer = False Then
         CtTimer = True
      End If
   End If
   Label1.Enabled = m_Enabled
   If m_Enabled Then
      Label1.ForeColor = m_ForeColor
   Else
      UserControl.Cls
      Label1.ForeColor = vbButtonShadow
   End If
   linDir.Visible = (m_ButtonStyle = Normal)
   linFdo.Visible = (m_ButtonStyle = Normal)
End Sub

Public Sub Finaliza()
   On Error Resume Next
   If Rodando Then
      If CtTimer Then
         Me.LigaDeslTimer False
         CtTimer = False
      End If
      If BtAt Then
         BtAt = False
      End If
      If CtAtivo Then
         CtAtivo = False
      End If
   End If
End Sub

' redimensiona o controle
Private Sub UserControl_Resize()
   Dim i As Integer, AltTot As Single, LargTot As Single, fY As Single, fX As Long
   fX = (2 * Screen.TwipsPerPixelX)
   fY = (2 * Screen.TwipsPerPixelY)
   If Not LeuProps Then GoTo FimDaSub
   'centraliza as quatro imagens para conter as pictures enabled/disabled
   For i = I_Enabled To I_MouseOver
      With img(i)
         If m_Stretch Then                               'se stretch
            img(i).Stretch = True
            If UserControl.Width > 90 Then
               .Width = UserControl.Width - 90
               .Height = UserControl.Height - 90
               .Left = (2 * Screen.TwipsPerPixelX) - (LargSeparador * m_LeftSeparator) 'soma considerando o separador
               .Top = (2 * Screen.TwipsPerPixelY) - (LargSeparador * m_TopSeparator)   'soma considerando o separador
            End If
         Else
            If lBmp(i) = 0 Then                   'icone vem zero. Mantem quadrado
               img(i).Stretch = False
               If .Width > LargImgOriginal Then
                  .Width = LargImgOriginal
               End If
               If .Height > AltImgOriginal Then
                  .Height = AltImgOriginal
               End If
            Else                                  'bmp - pega proporção
               img(i).Stretch = True
               If (aBmp(i) / AltImgOriginal) >= (lBmp(i) / LargImgOriginal) Then 'imagem portrait ou quadrada
                  .Height = AltImgOriginal                                       'mantem altura
                  .Width = .Height * lBmp(i) / aBmp(i)                           'e ajusta largura
               Else                               'landscape
                  .Width = LargImgOriginal        'mantém largura
                  .Height = .Width * aBmp(i) / lBmp(i)
               End If
            End If
            .Left = ((UserControl.Width - (LargSeparador * m_LeftSeparator)) - .Width) \ 2
            .Top = ((UserControl.Height - (LargSeparador * m_TopSeparator)) - .Height) \ 2
         End If
      End With
   Next

   'ajusta o label, se tiver caption
   If Len(Label1.Caption) > 0 Then
      With Label1
         If img(0).Picture = 0 Or img(0).Stretch Then 'não tem picture ou stretch = true
            Select Case m_CaptionAlign
               Case 1                                 'em baixo
                  .Move ((UserControl.Width - (LargSeparador * m_LeftSeparator)) - .Width) \ 2, _
                        ((UserControl.Height - (LargSeparador * m_TopSeparator)) - (.Height + m_CaptionOffset)) \ 2
               Case 2                                 'left
                  .Move m_CaptionOffset - (LargSeparador * m_LeftSeparator), (UserControl.Height - .Height) \ 2
               Case 3                                 'top
                  .Move (UserControl.Width - .Width) \ 2, m_CaptionOffset
               Case 4                                 'right
                  .Move UserControl.Width - (.Width + m_CaptionOffset), (UserControl.Height - .Height) \ 2
            End Select
         Else
            AltTot = img(0).Height + m_CaptionOffset + Label1.Height
            LargTot = img(0).Width + m_CaptionOffset + Label1.Width
            Select Case m_CaptionAlign
               Case 1                                 ' em baixo ========
                  For i = 0 To 3                      'move imagem
                     img(i).Move ((UserControl.Width - (LargSeparador * m_LeftSeparator) - img(i).Width) \ 2), _
                                 ((UserControl.Height - (LargSeparador * m_TopSeparator) - AltTot) \ 2) - fY
                  Next
                  .Move (UserControl.Width - (LargSeparador * m_LeftSeparator) - .Width) \ 2, _
                          img(0).Top + img(0).Height + m_CaptionOffset
               Case 2                                 'left =========
                  For i = 0 To 3                      'move imagem
                     img(i).Move UserControl.Width - (img(i).Width + m_CaptionOffset) - fX, _
                                 (UserControl.Height - (LargSeparador * m_TopSeparator) - img(i).Height) \ 2
                  Next
                  .Move img(0).Left - (.Width + m_CaptionOffset), _
                        (UserControl.Height - (LargSeparador * m_TopSeparator) - .Height) \ 2
               Case 3                                 'top =====
                  .Move ((UserControl.Width - (LargSeparador * m_LeftSeparator) - .Width) \ 2), _
                          (UserControl.Height - (LargSeparador * m_TopSeparator) - AltTot) \ 2
                  For i = 0 To 3                      'move imagem
                     img(i).Move ((UserControl.Width - (LargSeparador * m_LeftSeparator) - img(i).Width) \ 2), _
                                 .Top + .Height + m_CaptionOffset + fY
                  Next
               Case 4                                 'right ===
                  For i = 0 To 3                      'move imagem
                     img(i).Move m_CaptionOffset - (m_LeftSeparator * LargSeparador) + fX, _
                     (UserControl.Height - (LargSeparador * m_TopSeparator) - img(i).Height) \ 2
                        '      (UserControl.Height - img(i).Height) \ 2
                  Next
                  .Move img(0).Left + img(0).Width + m_CaptionOffset, _
                        (UserControl.Height - (LargSeparador * m_TopSeparator) - .Height) \ 2

            End Select
         End If
         'alinhar caption no centro - deixa as imgs centralizadas e joga por cima
         If m_CaptionAlign = 0 Then
            .Move (UserControl.Width - (LargSeparador * m_LeftSeparator) - .Width) \ 2, _
                  (UserControl.Height - (LargSeparador * m_TopSeparator) - .Height) \ 2
         End If
      End With
   End If

   ' mostra bordas do botão
   If m_ButtonType = [Push button] Then
      If m_ButtonStyle = VB5 And Rodando And m_Locked = False Then
         PoeBorda B_Desativa
      Else
         PoeBorda B_Cima
      End If
   Else
      If m_Value Then
         UserControl.BackColor = &H8000000F           'cinza
         PoeBorda B_Baixo
      Else
         UserControl.BackColor = vbButtonFace
         If m_ButtonStyle = VB5 And Rodando And m_Locked = False Then
            PoeBorda B_Desativa                       'run time, desativa
         Else
            PoeBorda B_Cima                           'design time - mostra
         End If
      End If
   End If
   If m_ButtonStyle = VB5 Then PoeSeparador           'estilo VB5

FimDaSub:

End Sub

'pega tamanho do bmp colocado na img
Private Sub PegaTamanhoBMP(Index As Integer)
   Dim j As Long
   bmp.bmWidth = 0
   bmp.bmHeight = 0
   j = GetObject(img(Index).Picture, Len(bmp), bmp)
   lBmp(Index) = bmp.bmWidth
   aBmp(Index) = bmp.bmHeight
End Sub

Private Sub PoeFoco()
   Dim r As RECT
   UserControl.Cls
   If ComFoco Then
      If m_ShowFocus And m_ButtonStyle = Normal And Rodando And m_Enabled Then
         GetWindowRect UserControl.hWnd, r
         r.Left = 5
         r.Top = 5
         r.Right = (UserControl.Width / Screen.TwipsPerPixelX) - 5
         r.Bottom = (UserControl.Height / Screen.TwipsPerPixelY) - 5
         DrawFocusRect UserControl.hdc, r
      End If
   End If
End Sub

Private Sub UserControl_Show()
   If img(I_Disabled).Picture <> 0 Then              'se tem imagem desativado
      img(I_Enabled).Visible = m_Enabled             'ajusta figuras enabled/disabled
      img(I_Disabled).Visible = (Not m_Enabled)
      Label1.ZOrder 0
      Label1.Refresh
   End If
   LeuProps = True
   UserControl_Resize
End Sub

Private Sub UserControl_Terminate()
   Finaliza
End Sub

'Write property values to storage
Private Sub UserControl_WriteProperties(PropBag As PropertyBag)

   Call PropBag.WriteProperty("ForeColor", m_ForeColor, &H80000012)
   Call PropBag.WriteProperty("BackColor", UserControl.BackColor, &H8000000F)
   Call PropBag.WriteProperty("Enabled", m_Enabled, True)
   Call PropBag.WriteProperty("Font", Label1.Font, Ambient.Font)
   Call PropBag.WriteProperty("Caption", Label1.Caption, "")
   Call PropBag.WriteProperty("MousePointer", UserControl.MousePointer, 0)
   Call PropBag.WriteProperty("MouseIcon", UserControl.MouseIcon, Nothing)
   Call PropBag.WriteProperty("CaptionAlign", m_CaptionAlign, m_def_CaptionAlign)
   Call PropBag.WriteProperty("ButtonStyle", m_ButtonStyle, m_def_ButtonStyle)
   Call PropBag.WriteProperty("Buttontype", m_ButtonType, m_def_ButtonType)
   If m_ButtonType = [Push button] Then
      m_Value = False                                  'força valor falso, se não for dois estados
   End If
   Call PropBag.WriteProperty("CaptionOffset", m_CaptionOffset, m_def_CaptionOffset)
   Call PropBag.WriteProperty("GroupName", m_GroupName, m_def_GroupName)
   Call PropBag.WriteProperty("GroupItem", m_GroupItem, m_def_GroupItem)
   Call PropBag.WriteProperty("Value", m_Value, m_def_Value)
   Call PropBag.WriteProperty("LeftSeparator", m_LeftSeparator, m_def_LeftSeparator)
   Call PropBag.WriteProperty("TopSeparator", m_TopSeparator, m_def_TopSeparator)
   Call PropBag.WriteProperty("JoinSeparators", m_JoinSeparators, m_def_JoinSeparators)
   Call PropBag.WriteProperty("ShowFocus", m_ShowFocus, m_def_ShowFocus)
   Call PropBag.WriteProperty("Locked", m_Locked, m_def_Locked)
   Call PropBag.WriteProperty("Stretch", m_Stretch, m_def_Stretch)
   Call PropBag.WriteProperty("Picture", img(I_Enabled).Picture, Nothing)
   Call PropBag.WriteProperty("PictureDisabled", img(I_Disabled).Picture, Nothing)
   Call PropBag.WriteProperty("PictureDown", img(I_Down).Picture, Nothing)
   Call PropBag.WriteProperty("PictureMouseOver", img(I_MouseOver).Picture, Nothing)

End Sub

Public Property Get Picture() As Picture
   Set Picture = img(I_Enabled).Picture
End Property

Public Property Set Picture(ByVal New_Picture As Picture)
   Set img(I_Enabled).Picture = New_Picture
   PegaTamanhoBMP I_Enabled
   UserControl_Resize
   PropertyChanged "Picture"
End Property

Public Property Get PictureDisabled() As Picture
   Set PictureDisabled = img(I_Disabled).Picture
End Property

Public Property Set PictureDisabled(ByVal New_PictureDisabled As Picture)
   Set img(I_Disabled).Picture = New_PictureDisabled
   PegaTamanhoBMP I_Disabled
   img(I_Enabled).Visible = m_Enabled                   'ajusta figuras enabled/disabled
   img(I_Disabled).Visible = (Not m_Enabled)
   Label1.ZOrder 0                                      'caption sempre em cima
   UserControl.Refresh
   UserControl_Resize
   PropertyChanged "PictureDisabled"
End Property

Public Property Get PictureDown() As Picture
   Set PictureDown = img(I_Down).Picture
End Property

Public Property Set PictureDown(ByVal New_PictureDown As Picture)
   Set img(I_Down).Picture = New_PictureDown
   PegaTamanhoBMP I_Down
   UserControl_Resize
   PropertyChanged "PictureDown"
End Property

Public Property Get PictureMouseOver() As Picture
   Set PictureMouseOver = img(I_MouseOver).Picture
End Property

Public Property Set PictureMouseOver(ByVal New_PictureMouseOver As Picture)
   Set img(I_MouseOver).Picture = New_PictureMouseOver
   PegaTamanhoBMP I_MouseOver
   UserControl_Resize
   PropertyChanged "PictureMouseOver"
End Property

Public Property Get Font() As Font
   Set Font = Label1.Font
End Property

Public Property Set Font(ByVal New_Font As Font)
   Set Label1.Font = New_Font
   UserControl_Resize
   PropertyChanged "Font"
End Property

Public Property Get CaptionAlign() As GBotPosiCaption
   CaptionAlign = m_CaptionAlign
End Property

Public Property Let CaptionAlign(ByVal New_CaptionAlign As GBotPosiCaption)
   m_CaptionAlign = New_CaptionAlign
   UserControl_Resize
   PropertyChanged "CaptionAlign"
End Property

Public Property Get ButtonStyle() As GBotEstilo
   ButtonStyle = m_ButtonStyle
End Property

Public Property Let ButtonStyle(ByVal New_ButtonStyle As GBotEstilo)
   If Rodando Then Err.Raise 393                     'só em design time
   m_ButtonStyle = New_ButtonStyle
   If m_ButtonStyle = VB5 Then
      UserControl.BackColor = vbButtonFace
      linDir.Visible = True
      linFdo.Visible = True
      m_ShowFocus = False
   Else
      linDir.Visible = True
      linFdo.Visible = True
      UserControl.BackColor = vbButtonFace
   End If
   UserControl_Resize
   PropertyChanged "ButtonStyle"
End Property

Public Property Get ButtonType() As GBotTipo
   ButtonType = m_ButtonType
End Property

Public Property Let ButtonType(ByVal New_ButtonType As GBotTipo)
   If Rodando Then Err.Raise 393                     'só em design time
   m_ButtonType = New_ButtonType
   If m_ButtonType = [Two state] Then
      If m_Value Then
         UserControl.BackColor = &H8000000F          'cinza
         PoeBorda B_Baixo
      Else
         UserControl.BackColor = vbButtonFace
         PoeBorda B_Cima
      End If
   Else
      UserControl.BackColor = vbButtonFace
      m_Value = False                                'reseta valor se bot normal
   End If
   UserControl_Resize
   PropertyChanged "ButtonType"
End Property

Public Property Get CaptionOffset() As Integer
   CaptionOffset = m_CaptionOffset
End Property

Public Property Let CaptionOffset(ByVal New_CaptionOffset As Integer)
   If Rodando Then Err.Raise 393                     'só em design time
   m_CaptionOffset = New_CaptionOffset
   UserControl_Resize
   PropertyChanged "CaptionOffset"
End Property

Public Property Get GroupName() As String
   GroupName = m_GroupName
End Property

Public Property Let GroupName(ByVal New_GroupName As String)
   If Rodando Then Err.Raise 393                     'só em design time
   m_GroupName = UCase$(New_GroupName)
   PropertyChanged "GroupName"
End Property

Public Property Get GroupItem() As Integer
   GroupItem = m_GroupItem
End Property

Public Property Let GroupItem(ByVal New_GroupItem As Integer)
   If Rodando = False Then Err.Raise 382             'só em Run time
   m_GroupItem = New_GroupItem
   PropertyChanged "GroupItem"
End Property

Public Property Get Value() As Boolean
   Value = m_Value
End Property

Public Property Let Value(ByVal New_Value As Boolean)
   m_Value = New_Value
   If m_ButtonType = [Two state] Then
      If m_Value Then
         UserControl.BackColor = &H8000000F              'cinza
         PoeBorda B_Baixo
      Else
         UserControl.BackColor = vbButtonFace            'cor do botão
         PoeBorda B_Cima
      End If
      UserControl_Resize
   End If
   PropertyChanged "Value"
   RaiseEvent Click
End Property

Public Property Get LeftSeparator() As Boolean
   LeftSeparator = m_LeftSeparator
End Property

Public Property Let LeftSeparator(ByVal New_LeftSeparator As Boolean)
   If Rodando Then Err.Raise 393
   m_LeftSeparator = New_LeftSeparator
   If m_LeftSeparator = False Then
      linLeft(0).Visible = False                       'esconde linhas
      linLeft(1).Visible = False
   End If
   PropertyChanged "LeftSeparator"
   UserControl_Resize                                  'força redesenho
End Property

Public Property Get TopSeparator() As Boolean
   TopSeparator = m_TopSeparator
End Property

Public Property Let TopSeparator(ByVal New_TopSeparator As Boolean)
   If Rodando Then Err.Raise 393
   m_TopSeparator = New_TopSeparator
   If m_TopSeparator = False Then
      linTop(0).Visible = False                        'esconde linhas
      linTop(1).Visible = False
   End If
   PropertyChanged "TopSeparator"
   UserControl_Resize                                  'força redesenho
End Property

Public Property Get JoinSeparators() As GBotJuntaSeparadores
   JoinSeparators = m_JoinSeparators
End Property

Public Property Let JoinSeparators(ByVal New_JoinSeparators As GBotJuntaSeparadores)
   If Rodando Then Err.Raise 393
   m_JoinSeparators = New_JoinSeparators
   PropertyChanged "JoinSeparators"
   UserControl_Resize                                'força redesenho
End Property

Public Property Get ShowFocus() As Boolean
   ShowFocus = m_ShowFocus
End Property

Public Property Let ShowFocus(ByVal New_ShowFocus As Boolean)
   If Rodando Then Err.Raise 393
   m_ShowFocus = New_ShowFocus
   PropertyChanged "ShowFocus"
End Property

Public Sub TiraFoco()
   UserControl.Enabled = False
   DoEvents                                       'permite liberar o botão
   UserControl.Enabled = True
End Sub

Public Property Get Locked() As Boolean
   Locked = m_Locked
End Property

Public Property Let Locked(ByVal New_Locked As Boolean)
   m_Locked = New_Locked
   If m_Locked And m_ButtonStyle = VB5 And Rodando Then
      PoeBorda B_Cima
   End If
   PropertyChanged "Locked"
End Property

Public Property Get Stretch() As Boolean
   Stretch = m_Stretch
End Property

Public Property Let Stretch(ByVal New_Stretch As Boolean)
   m_Stretch = New_Stretch
   UserControl_Resize
   PropertyChanged "Stretch"
End Property
