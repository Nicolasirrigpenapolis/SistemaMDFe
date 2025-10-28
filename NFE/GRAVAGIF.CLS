VERSION 1.0 CLASS
BEGIN
      MultiUse = -1                               'True
END
Attribute VB_Name = "SaveGIF"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
'* Sistema...: Emissor de MDF-e (Layout 3.00)
'* Empresa...: Ygor Eduardo Dellalio
'* Módulo....: GRAVAGIF.CLS
'* Função....: Grava imagem no formato GIF
'* CopyRight.: (C)2024 Ygor Eduardo Dellalio
'* Criação...: GAS-2007 - Gerador Automático de Sistemas
'* Data......: 05/09/2024 18:10:18
'* * * * * * *

Option Explicit                                   'variáveis devem ser declaradas
DefInt A-Z                                        'e por default todas seram inteiras

'==== estruturas para manipular BMP
Private Type RGBTRIPLE
   rgbRed As Byte
   rgbGreen As Byte
   rgbBlue As Byte
End Type

Private Type RGBQUAD
   rgbBlue As Byte
   rgbGreen As Byte
   rgbRed As Byte
   rgbReserved As Byte
End Type

Private Type BITMAPINFOHEADER                     'tamanho = 40 bytes
   biSize As Long
   biWidth As Long
   biHeight As Long
   biPlanes As Integer
   biBitCount As Integer
   biCompression As Long
   biSizeImage As Long
   biXPelsPerMeter As Long
   biYPelsPerMeter As Long
   biClrUsed As Long
   biClrImportant As Long
End Type

Private Type BITMAPINFO256
   bmiHeader As BITMAPINFOHEADER
   bmiColors(0 To 255) As RGBQUAD
End Type

Private Type BITMAP                               'tamanho=14
   bmType As Long
   bmWidth As Long
   bmHeight As Long
   bmWidthBytes As Long
   bmPlanes As Integer
   bmBitsPixel As Integer
   bmBits As Long
End Type

Private Const BI_RGB = 0&
Private Const DIB_RGB_COLORS = 0
Private Declare Function GetFileAttributes Lib "kernel32" Alias "GetFileAttributesA" (ByVal lpFileName As String) As Long
Private Declare Function CreateDCAsNull Lib "gdi32" Alias "CreateDCA" (ByVal lpDriverName As String, lpDeviceName As Any, lpOutput As Any, lpInitData As Any) As Long
Private Declare Function CreateCompatibleDC Lib "gdi32" (ByVal hDc As Long) As Long
Private Declare Function GetObjectAPI Lib "gdi32" Alias "GetObjectA" (ByVal hObject As Long, ByVal nCount As Long, lpObject As Any) As Long
Private Declare Function BitBlt Lib "gdi32" (ByVal hDestDC As Long, ByVal x As Long, ByVal y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal dwRop As Long) As Long
Private Declare Function DeleteDC Lib "gdi32" (ByVal hDc As Long) As Long
Private Declare Function GetDIBits Lib "gdi32" (ByVal aHDC As Long, ByVal hBitmap As Long, ByVal nStartScan As Long, ByVal nNumScans As Long, lpBits As Any, lpBI As BITMAPINFO256, ByVal wUsage As Long) As Long
Private Declare Function CreateDIBSection256 Lib "gdi32" Alias "CreateDIBSection" (ByVal hDc As Long, pBitmapInfo As BITMAPINFO256, ByVal un As Long, lplpVoid As Long, ByVal handle As Long, ByVal dw As Long) As Long

'==== estruturas para manipular GIF

Private Type GifScreenDescriptor
   logical_screen_width As Integer
   logical_screen_height As Integer
   Flags As Byte
   background_color_index As Byte
   pixel_aspect_ratio As Byte
End Type

Private Type GifImageDescriptor
   Left As Integer                                'esq
   Top As Integer                                 'topo
   Width As Integer                               'largura
   Height As Integer                              'altura
   Format As Byte                                 'formato da imagem
End Type

Private Type CONTROLBLOCK
   Blocksize As Byte
   Flags As Byte
   Delay As Integer
   TransParent_Color As Byte
   Terminator As Byte
End Type

Private Const GIF87a = "GIF87a"
Private Const GIF89a = "GIF89a"
Private Const CtrlIntro As Byte = &H21
Private Const CtrlLabel As Byte = &HF9
Private Const GifTerminator As Byte = &H3B
Private Const ImageSeparator As Byte = &H2C
Private Const CHAR_BIT = 8
Private Const CodeSize As Byte = 9
Private Const ClearCode = 256
Private Const EndCode  As Integer = 257
Private Const FirstCode = 258
Private Const LastCode As Integer = 511
Private Const MAX_CODE = LastCode - FirstCode

Private vgColTable As New Collection
Private vgFn As Integer
Private vgGifPalette(0 To 255) As RGBTRIPLE
Private vgBitPosition As Integer
Private vgCodeCount As Integer
Private vgDataBuffer(255) As Byte
Private vgPower2(31) As Long
Private vgPicWidth As Long, vgPicHeight As Long
Private vgIsBusy As Boolean

Public Event Progress(ByVal Percents As Integer)

Dim vgObProg As Object, vgValIni As Single, vgMax As Single

Public Sub SetProgress(vgObProgresso As Object, vgValorIni As Single, vgMaximo As Single)
   Set vgObProg = vgObProgresso
   vgValIni = vgValorIni
   vgMax = vgMaximo
End Sub

Public Function SaveGIF(ByVal pic As StdPicture, ByVal sFileName As String, _
                     Optional hDc As Long = 0, Optional UseTrans As Boolean = False, _
                     Optional ByVal TransColor As Long = 0) As Boolean
   If vgIsBusy Then Exit Function
   Dim i As Long, j As Long
   Dim vgScr As GifScreenDescriptor, im As GifImageDescriptor
   Dim vgBI As BITMAPINFO256, vgBM As BITMAP
   Dim vghDCScn As Long, vgOldObj As Long, vgSrcHDC As Long, vgClr As Long
   Dim vghDib256 As Long, vghDC256 As Long, vgOldObj256 As Long
   Dim vgBuf() As Byte, vgData As Byte, vgTransIndex As Byte
   Dim vgFound As Boolean
   Dim vgIntCode As Integer, vgCount  As Integer
   Dim vgPrefix As String, vgByte As String
   Dim vgTemProgresso As Boolean
   vgIsBusy = True
   vgTemProgresso = Not vgObProg Is Nothing
   
   'calcula tamanho da imagem e aloca memória do buffer
   Call GetObjectAPI(pic, Len(vgBM), vgBM)
   vgPicWidth = vgBM.bmWidth
   vgPicHeight = vgBM.bmHeight
   ReDim vgBuf(CLng(((vgPicWidth + 3) \ 4) * 4), vgPicHeight) As Byte
   
   'prepara DC (device context) para desenhar
   vghDCScn = CreateDCAsNull("DISPLAY", ByVal 0&, ByVal 0&, ByVal 0&)
   vghDC256 = CreateCompatibleDC(vghDCScn)        'cria device context em memória
   If hDc = 0 Then
      vgSrcHDC = CreateCompatibleDC(vghDCScn)
      vgOldObj = SelectObject(vgSrcHDC, pic)
   Else
      vgSrcHDC = hDc
   End If
   DeleteDC vghDCScn
   
   'uma vez que arquivos GIF suportam somente 256 cores, reduz qde para 256
   'este exemplo use a paleta mais simples de meio tom para reduzir qde de cores
   If vgBM.bmBitsPixel <> 8 Then vghDib256 = CreateDib256(vghDC256, vgBI)
   If vghDib256 <> 0 Then
      vgOldObj256 = SelectObject(vghDC256, vghDib256)
      Call BitBlt(vghDC256, 0, 0, vgPicWidth, vgPicHeight, vgSrcHDC, 0, 0, vbSrcCopy)
      For i = 0 To vgPicHeight - 1
         Call GetDIBits(vghDC256, vghDib256, i, 1, vgBuf(0, vgPicHeight - i), vgBI, 0)
      Next
   Else
      With vgBI.bmiHeader
         .biSize = Len(vgBI.bmiHeader)
         .biWidth = vgPicWidth
         .biHeight = vgPicHeight
         .biPlanes = 1
         .biBitCount = 8
         .biCompression = BI_RGB
      End With
      For i = 0 To vgPicHeight - 1
         Call GetDIBits(vgSrcHDC, pic, i, 1, vgBuf(0, vgPicHeight - i), vgBI, 0)
      Next
   End If
   
   'enche estrutura da info do GIF
   For i = 0 To 255
      vgGifPalette(i).rgbBlue = vgBI.bmiColors(i).rgbBlue
      vgGifPalette(i).rgbGreen = vgBI.bmiColors(i).rgbGreen
      vgGifPalette(i).rgbRed = vgBI.bmiColors(i).rgbRed
      If Not vgFound Then
         vgClr = RGB(vgGifPalette(i).rgbRed, vgGifPalette(i).rgbGreen, vgGifPalette(i).rgbBlue)
         If vgClr = TransColor Then
            vgTransIndex = i
            vgFound = True
         End If
      End If
   Next
   
   vgScr.background_color_index = 0
   vgScr.Flags = &HF7                             '256-color gif with global color map
   vgScr.pixel_aspect_ratio = 0
   
   im.Format = &H7                                'GlobalNonInterlaced
   im.Height = vgPicHeight
   im.Width = vgPicWidth

   If FileExists(sFileName) Then
      Kill sFileName
   End If 
      
   vgFn = FreeFile
   Open sFileName For Binary As vgFn
   'grava o header de informações do GIF
   If UseTrans = True Then
      Put #vgFn, , GIF89a
   Else
      Put #vgFn, , GIF87a
   End If
   Put #vgFn, , vgScr
   Put #vgFn, , vgGifPalette
   If UseTrans = True Then
      Put #vgFn, , CtrlIntro
      Put #vgFn, , CtrlLabel
      Dim cb As CONTROLBLOCK
      cb.Blocksize = 4                            'Always 4
      cb.Flags = 9                                'Packed = 00001001 (If Bit 0 = 1: Use Transparency)
      cb.Delay = 0
      cb.TransParent_Color = vgTransIndex
      cb.Terminator = 0                           'Always 0
      Put #vgFn, , cb
   End If
   Put #vgFn, , ImageSeparator
   Put #vgFn, , im
   vgData = CodeSize - 1
   Put #vgFn, , vgData
   vgDataBuffer(0) = 0
   vgBitPosition = CHAR_BIT
   
   'processa os dados dos pixels usando compressão LZW/GIF
   For i = 1 To vgPicHeight
      Reinitialize
      vgPrefix = ""
      vgIntCode = vgBuf(0, i)
      On Error Resume Next
      For j = 1 To vgPicWidth - 1
         vgByte = MyFormat(vgBuf(j, i))
         vgPrefix = vgPrefix & vgByte
         vgIntCode = vgColTable(vgPrefix)
         If Err <> 0 Then                         'prefixo não estava na coleção
            vgCount = vgColTable.count
            If vgCount = MAX_CODE Then
               Reinitialize
            End if 
            vgColTable.Add vgCount + FirstCode, vgPrefix
            OutputBits vgIntCode, CodeSize
            vgPrefix = vgByte
            vgIntCode = vgBuf(j, i)
            Err.Clear
         End If
      Next
      OutputBits vgIntCode, CodeSize
      If i Mod 10 = 0 Then
         RaiseEvent Progress(i * 100 / vgPicHeight)
         DoEvents
      End If
      If vgTemProgresso Then
         vgObProg.Value = vgValIni + i * vgMax / vgPicHeight
         If vgObProg.Parent.vgQuerCancelar Then Exit For
      End If
   Next
   OutputCode (EndCode)
   For i = 0 To vgDataBuffer(0)
      Put #vgFn, , vgDataBuffer(i)
   Next
   vgData = 0
   Put #vgFn, , vgData
   Put #vgFn, , GifTerminator
   Close vgFn
   Erase vgBuf
   If hDc = 0 Then
      SelectObject vgSrcHDC, vgOldObj
      DeleteDC vgSrcHDC
   End If
   SelectObject vghDC256, vgOldObj256
   DeleteObject vghDib256
   DeleteDC vghDC256
   SaveGIF = True
   vgIsBusy = False
End Function

Private Sub OutputBits(Value As Integer, count As Integer)
   Dim i As Integer, vgBit As Integer
   Do While i < count
      If vgBitPosition = CHAR_BIT Then
         If vgDataBuffer(0) = 255 Then
            Put #vgFn, , vgDataBuffer
            vgDataBuffer(0) = 1
         Else
            vgDataBuffer(0) = vgDataBuffer(0) + 1
         End If
         vgDataBuffer(vgDataBuffer(0)) = 0
         vgBitPosition = 0
      End If
      vgBit = Sgn(Power2(i) And Value)
      If vgBit > 0 Then vgDataBuffer(vgDataBuffer(0)) = Power2(vgBitPosition) Or vgDataBuffer(vgDataBuffer(0))
      i = i + 1: vgBitPosition = vgBitPosition + 1
   Loop
End Sub

Private Sub OutputCode(code As Integer)
   vgCodeCount = vgCodeCount + 1
   If vgCodeCount > LastCode Then
      vgCodeCount = FirstCode
      Call OutputBits(ClearCode, CodeSize)
      ClearTable
   End If
   Call OutputBits(code, CodeSize)
End Sub

Private Sub ClearTable()
   Set vgColTable = Nothing
   Set vgColTable = New Collection
End Sub

Private Sub Reinitialize()
   ClearTable
   Call OutputBits(ClearCode, CodeSize)
End Sub

'arquivo existe?
Private Function FileExists(ByVal strPathName As String) As Boolean
   Dim j As Long
   j = GetFileAttributes(strPathName)
   FileExists = (j <> -1)
End Function

Private Function Power2(ByVal i As Integer) As Long
   If vgPower2(0) = 0 Then
      vgPower2(0) = &H1&
      vgPower2(1) = &H2&
      vgPower2(2) = &H4&
      vgPower2(3) = &H8&
      vgPower2(4) = &H10&
      vgPower2(5) = &H20&
      vgPower2(6) = &H40&
      vgPower2(7) = &H80&
      vgPower2(8) = &H100&
      vgPower2(9) = &H200&
      vgPower2(10) = &H400&
      vgPower2(11) = &H800&
      vgPower2(12) = &H1000&
      vgPower2(13) = &H2000&
      vgPower2(14) = &H4000&
      vgPower2(15) = &H8000&
      vgPower2(16) = &H10000
      vgPower2(17) = &H20000
      vgPower2(18) = &H40000
      vgPower2(19) = &H80000
      vgPower2(20) = &H100000
      vgPower2(21) = &H200000
      vgPower2(22) = &H400000
      vgPower2(23) = &H800000
      vgPower2(24) = &H1000000
      vgPower2(25) = &H2000000
      vgPower2(26) = &H4000000
      vgPower2(27) = &H8000000
      vgPower2(28) = &H10000000
      vgPower2(29) = &H20000000
      vgPower2(30) = &H40000000
      vgPower2(31) = &H80000000
   End If
   Power2 = vgPower2(i)
End Function

'formata byte
Private Function MyFormat(ByVal s As String) As String
   MyFormat = Right$("00" & s, 3)
End Function

'cria device independent bitmap de 256 cores
Private Function CreateDib256(ByVal h_Dc As Long, vgBI As BITMAPINFO256) As Long
   Dim vgScanSize As Long
   Dim lptr As Long, lIndex As Long
   Dim r As Long, g As Long, b As Long
   Dim rA As Long, gA As Long, bA As Long
   With vgBI.bmiHeader
      .biSize = Len(vgBI.bmiHeader)
      .biWidth = vgPicWidth
      .biHeight = vgPicHeight
      .biPlanes = 1
      .biBitCount = 8
      .biCompression = BI_RGB
      vgScanSize = (vgPicWidth + vgPicWidth Mod 4)
      .biSizeImage = vgScanSize * vgPicHeight
   End With
   'paleta meio-ton de 256 cores
   For b = 0 To &H100 Step &H40
      If b = &H100 Then
         bA = b - 1
      Else
         bA = b
      End If
      For g = 0 To &H100 Step &H40
         If g = &H100 Then
            gA = g - 1
         Else
            gA = g
         End If
         For r = 0 To &H100 Step &H40
            If r = &H100 Then
               rA = r - 1
            Else
               rA = r
            End If
            With vgBI.bmiColors(lIndex)
               .rgbRed = rA: .rgbGreen = gA: .rgbBlue = bA
            End With
            lIndex = lIndex + 1
         Next
      Next
   Next
   CreateDib256 = CreateDIBSection256(h_Dc, vgBI, DIB_RGB_COLORS, lptr, 0, 0)
End Function

Private Sub Class_Terminate()
   Set vgObProg = Nothing
End Sub
