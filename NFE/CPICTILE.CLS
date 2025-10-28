VERSION 1.0 CLASS
BEGIN
      MultiUse = -1                               'True
      Persistable = 0                             'NotPersistable
      DataBindingBehavior = 0                     'vbNone
      DataSourceBehavior  = 0                     'vbNone
      MTSTransactionMode  = 0                     'NotAnMTSObject
END
Attribute VB_Name = "cPicTile"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private Type BITMAP
   bmType As Long
   bmWidth As Long
   bmHeight As Long
   bmWidthBytes As Long
   bmPlanes As Integer
   bmBitsPixel As Integer
   bmBits As Long
End Type

Private Const CAPS1 = 94                          '  other caps
Private Const C1_TRANSPARENT = &H1                '  new raster cap
Private Const NEWTRANSPARENT = 3                  '  use with SetBkMode()

Private Const SRCCOPY = &HCC0020

Private Const LR_LOADFROMFILE = &H10
Private Const LR_LOADTRANSPARENT = &H20
Private Const LR_LOADMAP3DCOLORS = &H1000

Private Const IMAGE_BITMAP = 0

Private Const CF_BITMAP = 2

Private Declare Function GetDesktopWindow Lib "user32" () As Long
Private Declare Function GetDC Lib "user32" (ByVal hwnd As Long) As Long
Private Declare Function CreateCompatibleDC Lib "gdi32" (ByVal hdc As Long) As Long
Private Declare Function ReleaseDC Lib "user32" (ByVal hwnd As Long, ByVal hdc As Long) As Long
Private Declare Function GetObjectAPI Lib "gdi32" Alias "GetObjectA" (ByVal hObject As Long, ByVal nCount As Long, lpObject As Any) As Long
Private Declare Function BitBlt Lib "gdi32" (ByVal hDestDC As Long, ByVal x As Long, ByVal y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal dwRop As Long) As Long
Private Declare Function StretchBlt Lib "gdi32" (ByVal hdc As Long, ByVal x As Long, ByVal y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal nSrcWidth As Long, ByVal nSrcHeight As Long, ByVal dwRop As Long) As Long
Private Declare Function GetDeviceCaps Lib "gdi32" (ByVal hdc As Long, ByVal nIndex As Long) As Long
Private Declare Function SetBkColor Lib "gdi32" (ByVal hdc As Long, ByVal crColor As Long) As Long
Private Declare Function CreateBitmap Lib "gdi32" (ByVal nWidth As Long, ByVal nHeight As Long, ByVal nPlanes As Long, ByVal nBitCount As Long, lpBits As Any) As Long
Private Declare Function CreateCompatibleBitmap Lib "gdi32" (ByVal hdc As Long, ByVal nWidth As Long, ByVal nHeight As Long) As Long
Private Declare Function DeleteDC Lib "gdi32" (ByVal hdc As Long) As Long
Private Declare Function OpenClipboard Lib "user32" (ByVal hwnd As Long) As Long
Private Declare Function SetClipboardData Lib "user32" (ByVal wFormat As Long, ByVal hMem As Long) As Long
Private Declare Function EmptyClipboard Lib "user32" () As Long
Private Declare Function CloseClipboard Lib "user32" () As Long
Private Declare Function LoadImage Lib "user32" Alias "LoadImageA" (ByVal hInst As Long, ByVal lpsz As String, ByVal un1 As Long, ByVal n1 As Long, ByVal n2 As Long, ByVal un2 As Long) As Long

Private m_lHdc As Long
Private m_lHBmpOld As Long
Private m_lhPalOld As Long
Private m_pic As StdPicture
Private m_lBitmapW As Long
Private m_lBitmapH As Long
Private m_sFileName As String

Private m_lHdcTrans As Long
Private m_lHBmpOldTrans As Long
Private m_lhPalOldTrans As Long
Private m_PicTrans As StdPicture
Private m_lBitmapWTrans As Long
Private m_lBitmapHTrans As Long

Private m_lXOriginOffset As Long
Private m_lYOriginOffset As Long
Private m_bMapSystemColors As Boolean
Private m_bLoadTransparent As Boolean

Private m_BackGroundType As Integer               '0 = ladoalado, 1 = expandido, 2 = centralizado
Private m_lXDestOffset As Long
Private m_lYDestOffset As Long

Public Property Get PicturehDC() As Long
Attribute PicturehDC.VB_Description = "Returns the hDC which contains the tiling picture."
   PicturehDC = m_lHdc
End Property

Public Property Get LoadTransparent() As Boolean
Attribute LoadTransparent.VB_Description = "Gets/sets whether the pixel at the top left corner of the picture to be drawn should be transparent."
   LoadTransparent = m_bLoadTransparent
End Property

Public Property Let LoadTransparent(ByVal bLoadTransparent As Boolean)
   m_bLoadTransparent = bLoadTransparent
End Property

Public Property Get BackgroundType() As Integer
   BackgroundType = m_BackGroundType
End Property

Public Property Let BackgroundType(ByVal NewBackgroundType As Integer)
   m_BackGroundType = NewBackgroundType
End Property

Public Property Get MapSystemColors() As Boolean
Attribute MapSystemColors.VB_Description = "Gets/sets whether gray colours in the image should be mapped onto the button face colours.  RGB colours (128,128,128), (192,192,192) and (223,223,223) will be mapped to the Dark Shadow, Button Face and Light Shadow system colours respectively."
   MapSystemColors = m_bMapSystemColors
End Property

Public Property Let MapSystemColors(ByVal bMapSystemColors As Boolean)
   m_bMapSystemColors = bMapSystemColors
End Property

Public Property Get XDestOffset() As Long
   XDestOffset = m_lXDestOffset
End Property

Public Property Let XDestOffset(ByVal lPixels As Long)
   m_lXDestOffset = lPixels
End Property

Public Property Get YDestOffset() As Long
   YDestOffset = m_lYDestOffset
End Property

Public Property Let YDestOffset(ByVal lPixels As Long)
   m_lYDestOffset = lPixels
End Property

Public Property Get XOriginOffset() As Long
Attribute XOriginOffset.VB_Description = "Gets/Sets the X offset from 0,0 in the source bitmap at which to start tiling."
   XOriginOffset = m_lXOriginOffset
End Property

Public Property Let XOriginOffset(ByVal lPixels As Long)
   m_lXOriginOffset = lPixels
End Property

Public Property Get YOriginOffset() As Long
Attribute YOriginOffset.VB_Description = "Gets/Sets the Y offset from 0,0 in the source bitmap at which to start tiling."
   YOriginOffset = m_lYOriginOffset
End Property

Public Property Let YOriginOffset(ByVal lPiYels As Long)
   m_lYOriginOffset = lPiYels
End Property

Public Property Get BitmapWidth() As Long
Attribute BitmapWidth.VB_Description = "Returns the height of the bitmap used for tiling."
   BitmapWidth = m_lBitmapW
End Property

Public Property Get BitmapHeight() As Long
Attribute BitmapHeight.VB_Description = "Returns the height of the bitmap used for tiling."
   BitmapHeight = m_lBitmapH
End Property
'Private Sub pErr(lNumber As Long, smsg As String)
' MsgBox "Erro! " & smsg & ", (" & lNumber & ")", vbExclamation
'End Sub

Public Property Let Filename(ByVal sFileName As String)
Attribute Filename.VB_Description = "Gets/sets the name of a file containing a picture to tile."
   'carrega picture do arquivo passado
   If (m_sFileName <> sFileName) Then
      pClearUp
      If Len(sFileName) <> 0 Then
         If (pbLoadPicture(sFileName)) Then
            m_sFileName = sFileName
         End If
      Else
         Set m_pic = Nothing                      'destroi a picture
         m_sFileName = sFileName
      End If
   End If
End Property

Public Property Get Filename() As String
   Filename = m_sFileName
End Property

Public Property Get Picture() As StdPicture
Attribute Picture.VB_Description = "Gets/sets a reference to a picture object containing the picture to tile."
   Set Picture = m_pic
End Property

Public Property Let Picture(oPic As StdPicture)
   'carrega pictrue de um objeto StdPicture
   pClearUp
   If (pbEnsurePicture()) Then
      Set m_pic = oPic
      If (Err.Number = 0) Then
         pbGetBitmapIntoDC
      End If
   End If
End Property

Public Property Get TransPicture() As StdPicture
   Set TransPicture = m_PicTrans
End Property

Public Property Let TransPicture(oPic As StdPicture)
   
   'carrega pictrue de um objeto StdPicture
   pClearUpTrans
   If (pbEnsurePictureTransPicture()) Then
      Set m_PicTrans = oPic
      If (Err.Number = 0) Then
         pbGetBitmapIntoDCTrans
      End If
   End If
End Property

Private Function pbEnsurePictureTransPicture() As Boolean
   On Error Resume Next
   pbEnsurePictureTransPicture = True
   If (m_PicTrans Is Nothing) Then
      Set m_PicTrans = New StdPicture
      If (Err.Number <> 0) Then
         pbEnsurePictureTransPicture = False
      Else
      End If
   End If
   On Error GoTo 0
   Exit Function
End Function

Private Function pbEnsurePicture() As Boolean
   On Error Resume Next
   pbEnsurePicture = True
   If (m_pic Is Nothing) Then
      Set m_pic = New StdPicture
      If (Err.Number <> 0) Then
         pbEnsurePicture = False
      Else
      End If
   End If
   On Error GoTo 0
   Exit Function
End Function

Private Function pbLoadPictureFromFile(sFile As String) As Boolean
   On Error Resume Next
   If (m_bMapSystemColors) Or (m_bLoadTransparent) Then
      Dim sError As String
      If (LoadPictureTransparent(m_pic, sFile, sError, m_bLoadTransparent)) Then
                  pbLoadPictureFromFile = True
      Else
      End If
   Else
      Set m_pic = LoadPicture(sFile)
      If (Err.Number <> 0) Then
      Else
         pbLoadPictureFromFile = True
      End If
   End If
   On Error GoTo 0
   Exit Function
End Function

Private Function pbLoadPicture(sFile As String) As Boolean
   If (pbEnsurePicture()) Then
      If (pbLoadPictureFromFile(sFile)) Then
         pbLoadPicture = pbGetBitmapIntoDC()
      End If
   End If
End Function

Private Function pbGetBitmapIntoDCTrans() As Boolean
   Dim tB As BITMAP
   Dim lHDC As Long, lHwnd As Long
   'cria um DC para conter a figura bmp que usamos para o blt
   lHwnd = GetDesktopWindow()
   lHDC = GetDC(lHwnd)
   m_lHdcTrans = CreateCompatibleDC(lHDC)
   ReleaseDC lHwnd, lHDC
   If (m_lHdcTrans <> 0) Then
      'pega tamanho da picture
      GetObjectAPI m_PicTrans.Handle, LenB(tB), tB
      m_lBitmapWTrans = tB.bmWidth
      m_lBitmapHTrans = tB.bmHeight
      
      'seleciona bmp no DC
      m_lHBmpOldTrans = SelectObject(m_lHdcTrans, m_PicTrans.Handle)
      If (m_lHBmpOldTrans <> 0) Then
         'seleciona a paleta em DC
         m_lhPalOldTrans = SelectObject(m_lHdcTrans, m_PicTrans.hPal)
         pbGetBitmapIntoDCTrans = True
      Else
         pClearUpTrans
      End If
   Else
   End If
End Function

Private Function pbGetBitmapIntoDC() As Boolean
   Dim tB As BITMAP
   Dim lHDC As Long, lHwnd As Long
   'cria um DC para conter a figura bmp que usamos para o blt
   lHwnd = GetDesktopWindow()
   lHDC = GetDC(lHwnd)
   m_lHdc = CreateCompatibleDC(lHDC)
   ReleaseDC lHwnd, lHDC
   If (m_lHdc <> 0) Then
      'pega tamanho da picture
      GetObjectAPI m_pic.Handle, LenB(tB), tB
      m_lBitmapW = tB.bmWidth
      m_lBitmapH = tB.bmHeight
      
      'seleciona bmp no DC
      m_lHBmpOld = SelectObject(m_lHdc, m_pic.Handle)
      If (m_lHBmpOld <> 0) Then
         'seleciona a paleta em DC
         m_lhPalOld = SelectObject(m_lHdc, m_pic.hPal)
         pbGetBitmapIntoDC = True
         If (m_sFileName = "") Then
            m_sFileName = "PICTURE"
         End If
      Else
         pClearUp
      End If
   Else
   End If
End Function

Public Property Get Palette() As StdPicture
Attribute Palette.VB_Description = "Returns a reference to a picture object which can set to the palette property of a form.  Use with 256 colour systems to ensure correct display behaviour."
   Set Palette = m_pic
End Property

Private Sub pClearUpTrans()
   'se temos um DC, limpa...
   If (m_lHdcTrans <> 0) Then
      'seleciona o bitmap fora do DC
      If (m_lHBmpOldTrans <> 0) Then
         SelectObject m_lHdcTrans, m_lHBmpOldTrans
         'o bmp original não precisa ser deletado porque está contido em m_pic
      End If
      'seleciona a paleta fora do DC
      If (m_lhPalOldTrans <> 0) Then
         'a paleta original - a paleta não precisa ser deletada porque está contida em m_pic
         SelectObject m_lHdcTrans, m_lhPalOldTrans
      End If
      DeleteObject m_lHdcTrans
   End If
End Sub

Private Sub pClearUp()
   m_sFileName = ""
   'se temos um DC, limpa...
   If (m_lHdc <> 0) Then
      'seleciona o bitmap fora do DC
      If (m_lHBmpOld <> 0) Then
         SelectObject m_lHdc, m_lHBmpOld
         'o bmp original não precisa ser deletado porque está contido em m_pic
      End If
      'seleciona a paleta fora do DC
      If (m_lhPalOld <> 0) Then
         'a paleta original - a paleta não precisa ser deletada porque está contida em m_pic
         SelectObject m_lHdc, m_lhPalOld
      End If
      DeleteObject m_lHdc
   End If
End Sub

Public Sub TileArea(ByRef hdc As Long, ByVal x As Long, ByVal y As Long, ByVal Width As Long, ByVal Height As Long)
Attribute TileArea.VB_Description = "Tile a particular area in a particular hDC."
   Dim lSrcX As Long
   Dim lSrcY As Long
   Dim lSrcStartX As Long
   Dim lSrcStartY As Long
   Dim lSrcStartWidth As Long
   Dim lSrcStartHeight As Long
   Dim lDstX As Long
   Dim lDstY As Long
   Dim lDstWidth As Long
   Dim lDstHeight As Long

   If m_lBitmapW = 0 Or m_lBitmapH = 0 Then Exit Sub
   lSrcStartX = ((x + m_lXOriginOffset) Mod m_lBitmapW)
   lSrcStartY = ((y + m_lYOriginOffset) Mod m_lBitmapH)
   lSrcStartWidth = (m_lBitmapW - lSrcStartX)
   lSrcStartHeight = (m_lBitmapH - lSrcStartY)
   lSrcX = lSrcStartX
   lSrcY = lSrcStartY
            
   lDstY = y + m_lYDestOffset
   lDstHeight = lSrcStartHeight
            
   If m_BackGroundType = 0 Then                   'Tiled
      Do While lDstY < (y + Height)
         If (lDstY + lDstHeight) > (y + Height) Then
            lDstHeight = y + Height - lDstY
         End If
         lDstWidth = lSrcStartWidth
         lDstX = x + m_lXDestOffset
         lSrcX = lSrcStartX
         Do While lDstX <= (x + Width)
            If (lDstX + lDstWidth) > (x + Width) Then
               lDstWidth = x + Width - lDstX
               If (lDstWidth = 0) Then
                  lDstWidth = 4
               End If
            End If
            BitBlt hdc, lDstX, lDstY, lDstWidth, lDstHeight, m_lHdc, lSrcX, lSrcY, SRCCOPY
            lDstX = lDstX + lDstWidth
            lSrcX = 0
            lDstWidth = m_lBitmapW
         Loop
         lDstY = lDstY + lDstHeight
         lSrcY = 0
         lDstHeight = m_lBitmapH
      Loop
   ElseIf m_BackGroundType = 1 Then               'stretched
      StretchBlt hdc, m_lXDestOffset, m_lYDestOffset, Width - m_lXDestOffset, Height - m_lYDestOffset, m_lHdc, 0, 0, m_lBitmapW, m_lBitmapH, SRCCOPY
   Else                                           'centralizado
      'BitBlt hdc, (Width - m_lBitmapW - m_lXDestOffset) / 2, (Height - m_lBitmapH - m_lYDestOffset) / 2, m_lBitmapW, m_lBitmapH, m_lHdc, m_lBitmapW, m_lBitmapH, SRCCOPY
      BitBlt hdc, m_lXDestOffset + (((Width - m_lXDestOffset) - m_lBitmapW) / 2), m_lYDestOffset + (((Height - m_lYDestOffset) - m_lBitmapH) / 2), _
                  m_lBitmapW, m_lBitmapH, m_lHdc, m_lXOriginOffset, m_lYOriginOffset, SRCCOPY
   End If

End Sub

Public Sub TransPaint(ByVal hdc As Long, ByVal Width As Long, ByVal Height As Long)
   Dim OrigColor As Long                          ' Holds original background color
   Dim OrigMode As Long                           ' Holds original background drawing mode
   Dim hDestDC As Long, x As Long, y As Long, hSrc As StdPicture, xSrc As Long, ySrc As Long, TransColor As Long
         
   If m_PicTrans Is Nothing Then
      Exit Sub
   End If
   
   If m_lBitmapWTrans = 0 Or m_lBitmapHTrans = 0 Then Exit Sub
   hDestDC = hdc
   Set hSrc = m_PicTrans
   xSrc = 0
   ySrc = 0
   
   x = m_lXDestOffset + (((Width - m_lXDestOffset) - m_lBitmapWTrans) / 2)
   y = m_lYDestOffset + (((Height - m_lYDestOffset) - m_lBitmapHTrans) / 2)
   
   TransColor = GetPixel(m_lHdcTrans, 0, 0) 
   If (GetDeviceCaps(hDestDC, CAPS1) And C1_TRANSPARENT) Then
      '
      ' Some NT machines support this *super* simple method!
      ' Save original settings, Blt, restore settings.
      '
      OrigMode = SetBkMode(hDestDC, NEWTRANSPARENT)
      OrigColor = SetBkColor(hDestDC, TransColor)
      Call BitBlt(hDestDC, x, y, m_lBitmapWTrans, m_lBitmapHTrans, m_lHdcTrans, xSrc, ySrc, SRCCOPY)
      Call SetBkColor(hDestDC, OrigColor)
      Call SetBkMode(hDestDC, OrigMode)
   Else
      Dim SaveDC As Long                          ' Backup copy of source bitmap
      Dim maskDC As Long                          ' Mask bitmap (monochrome)
      Dim invDC As Long                           ' Inverse of mask bitmap (monochrome)
      Dim resultDC As Long                        ' Combination of source bitmap & background
      Dim hSaveBmp As Long                        ' Bitmap stores backup copy of source bitmap
      Dim hMaskBmp As Long                        ' Bitmap stores mask (monochrome)
      Dim hInvBmp As Long                         ' Bitmap holds inverse of mask (monochrome)
      Dim hResultBmp As Long                      ' Bitmap combination of source & background
      Dim hSavePrevBmp As Long                    ' Holds previous bitmap in saved DC
      Dim hMaskPrevBmp As Long                    ' Holds previous bitmap in the mask DC
      Dim hInvPrevBmp As Long                     ' Holds previous bitmap in inverted mask DC
      Dim hDestPrevBmp As Long                    ' Holds previous bitmap in destination DC
      '
      ' Create DCs to hold various stages of transformation.
      '
      SaveDC = CreateCompatibleDC(hDestDC)
      maskDC = CreateCompatibleDC(hDestDC)
      invDC = CreateCompatibleDC(hDestDC)
      resultDC = CreateCompatibleDC(hDestDC)
      '
      ' Create monochrome bitmaps for the mask-related bitmaps.
      '
      hMaskBmp = CreateBitmap(m_lBitmapWTrans, m_lBitmapHTrans, 1, 1, ByVal 0&)
      hInvBmp = CreateBitmap(m_lBitmapWTrans, m_lBitmapHTrans, 1, 1, ByVal 0&)
      '
      ' Create color bitmaps for final result & stored copy of source.
      '
      hResultBmp = CreateCompatibleBitmap(hDestDC, m_lBitmapWTrans, m_lBitmapHTrans)
      hSaveBmp = CreateCompatibleBitmap(hDestDC, m_lBitmapWTrans, m_lBitmapHTrans)
      '
      ' Select bitmaps into DCs.
      '
      hSavePrevBmp = SelectObject(SaveDC, hSaveBmp)
      hMaskPrevBmp = SelectObject(maskDC, hMaskBmp)
      hInvPrevBmp = SelectObject(invDC, hInvBmp)
      hDestPrevBmp = SelectObject(resultDC, hResultBmp)
   
      '
      ' Create mask: set background color of source to transparent color.
      '
      OrigColor = SetBkColor(m_lHdcTrans, TransColor)
      Call BitBlt(maskDC, 0, 0, m_lBitmapWTrans, m_lBitmapHTrans, m_lHdcTrans, xSrc, ySrc, vbSrcCopy)
      TransColor = SetBkColor(m_lHdcTrans, OrigColor)
      '
      ' Create inverse of mask to AND w/ source & combine w/ background.
      '
      Call BitBlt(invDC, 0, 0, m_lBitmapWTrans, m_lBitmapHTrans, maskDC, 0, 0, vbNotSrcCopy)
      '
      ' Copy background bitmap to result.
      '
      Call BitBlt(resultDC, 0, 0, m_lBitmapWTrans, m_lBitmapHTrans, hDestDC, x, y, vbSrcCopy)
      '
      ' AND mask bitmap w/ result DC to punch hole in the background by
      ' painting black area for non-transparent portion of source bitmap.
      '
      Call BitBlt(resultDC, 0, 0, m_lBitmapWTrans, m_lBitmapHTrans, maskDC, 0, 0, vbSrcAnd)
      '
      ' get overlapper
      '
      Call BitBlt(SaveDC, 0, 0, m_lBitmapWTrans, m_lBitmapHTrans, m_lHdcTrans, xSrc, ySrc, vbSrcCopy)
      '
      ' AND with inverse monochrome mask
      '
      Call BitBlt(SaveDC, 0, 0, m_lBitmapWTrans, m_lBitmapHTrans, invDC, 0, 0, vbSrcAnd)
      '
      ' XOR these two
      '
      Call BitBlt(resultDC, 0, 0, m_lBitmapWTrans, m_lBitmapHTrans, SaveDC, 0, 0, vbSrcInvert)
      '
      ' Display transparent bitmap on background.
      '
      Call BitBlt(hDestDC, x, y, m_lBitmapWTrans, m_lBitmapHTrans, resultDC, 0, 0, vbSrcCopy)
      '
      ' Select original objects back.
      '
      Call SelectObject(SaveDC, hSavePrevBmp)
      Call SelectObject(resultDC, hDestPrevBmp)
      Call SelectObject(maskDC, hMaskPrevBmp)
      Call SelectObject(invDC, hInvPrevBmp)
      '
      ' Deallocate system resources.
      '
      Call DeleteObject(hSaveBmp)
      Call DeleteObject(hMaskBmp)
      Call DeleteObject(hInvBmp)
      Call DeleteObject(hResultBmp)
      Call DeleteDC(SaveDC)
      Call DeleteDC(invDC)
      Call DeleteDC(maskDC)
      Call DeleteDC(resultDC)
   End If
      
End Sub

Private Sub Class_Terminate()
   Dim vgErrNum As Long, vgErrDesc As String, vgErrSrc As String

   'salva erro
   vgErrNum = Err.Number
   vgErrDesc = Err.Description
   vgErrSrc = Err.Source
   
   pClearUp                                       'assegura a liberação de todos os objetos GDI
   pClearUpTrans
   Set m_pic = Nothing                            'destroi a picture
   Set m_PicTrans = Nothing                       'destroi a picture

   'restaura erro
   Err.Number = vgErrNum
   Err.Description = vgErrDesc
   Err.Source = vgErrSrc

End Sub

Public Function LoadPictureTransparent(pic As Object, ByVal Filename As String, ByRef sError As String, Optional ByVal bLoadTransparent As Boolean = False) As Boolean
   Dim hBMP As Long
   Dim lR As Long
   Dim lFlags As Long
   On Error GoTo gbLoadTransErrorPic
   'apronta clipboard ...
   lR = OpenClipboard(0)
   If (lR > 0) Then
      EmptyClipboard
      'carrega a imagem
      If (bLoadTransparent) Then
         lFlags = LR_LOADFROMFILE Or LR_LOADTRANSPARENT
         Beep
      Else
         lFlags = LR_LOADFROMFILE Or LR_LOADMAP3DCOLORS
      End If
      hBMP = LoadImage(0, Filename, IMAGE_BITMAP, 0, 0, lFlags)
      If (hBMP <> 0) Then
         'copia para o clipboard
         SetClipboardData CF_BITMAP, hBMP
         CloseClipboard
         'coloca a pic no lugar
         Set pic = Clipboard.GetData(vbCFBitmap)
         'limpa o clipboard
         Clipboard.SetText ""
         LoadPictureTransparent = True
      Else
         sError = "Impossível abrir o arquivo bitmap."
      End If
   Else
      sError = "impossível abrir o clipboard."
   End If
   Exit Function

gbLoadTransErrorPic:
   sError = Err.Description
   Exit Function
End Function
