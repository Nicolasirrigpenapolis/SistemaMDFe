VERSION 1.0 CLASS
BEGIN
      MultiUse = -1                               'True
END
Attribute VB_Name = "IntelJpg"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'* Sistema...: Emissor de MDF-e (Layout 3.00)
'* Empresa...: Ygor Eduardo Dellalio
'* Módulo....: INTELJPG.CLS
'* Função....: Grava imagem no formato JPG
'* CopyRight.: (C)2024 Ygor Eduardo Dellalio
'* Criação...: GAS-2007 - Gerador Automático de Sistemas
'* Data......: 05/09/2024 18:10:18
'* * * * * * *

Option Explicit                                   'variáveis devem ser declaradas
DefInt A-Z                                        'e por default todas serão inteiras

Private Enum IJLERR
   'os seguintes valores de erro indicam condição "OK"
   IJL_OK = 0
   IJL_INTERRUPT_OK = 1
   IJL_ROI_OK = 2
   'e os valores de erro seguintes indicam erros ocorridos
   IJL_EXCEPTION_DETECTED = -1
   IJL_INVALID_ENCODER = -2
   IJL_UNSUPPORTED_SUBSAMPLING = -3
   IJL_UNSUPPORTED_BYTES_PER_PIXEL = -4
   IJL_MEMORY_ERROR = -5
   IJL_BAD_HUFFMAN_TABLE = -6
   IJL_BAD_QUANT_TABLE = -7
   IJL_INVALID_JPEG_PROPERTIES = -8
   IJL_ERR_FILECLOSE = -9
   IJL_INVALID_FILENAME = -10
   IJL_ERROR_EOF = -11
   IJL_PROG_NOT_SUPPORTED = -12
   IJL_ERR_NOT_JPEG = -13
   IJL_ERR_COMP = -14
   IJL_ERR_SOF = -15
   IJL_ERR_DNL = -16
   IJL_ERR_NO_HUF = -17
   IJL_ERR_NO_QUAN = -18
   IJL_ERR_NO_FRAME = -19
   IJL_ERR_MULT_FRAME = -20
   IJL_ERR_DATA = -21
   IJL_ERR_NO_IMAGE = -22
   IJL_FILE_ERROR = -23
   IJL_INTERNAL_ERROR = -24
   IJL_BAD_RST_MARKER = -25
   IJL_THUMBNAIL_DIB_TOO_SMALL = -26
   IJL_THUMBNAIL_DIB_WRONG_COLOR = -27
   IJL_RESERVED = -99
End Enum

Private Enum IJLIOTYPE
   IJL_SETUP = -1&
   'le parametros jpeg (height, width, channels, sampling, etc.) de uma seqüência de bits
   IJL_JFILE_READPARAMS = 0&
   IJL_JBUFF_READPARAMS = 1&
   'le formato de intercambio de uma imagem jpeg
   IJL_JFILE_READWHOLEIMAGE = 2&
   IJL_JBUFF_READWHOLEIMAGE = 3&
   'le tabelas a partir de seqüência de bits de formato abreviado do arquivo jpeg
   IJL_JFILE_READHEADER = 4&
   IJL_JBUFF_READHEADER = 5&
   'le informação da imagem jpeg a partir de seq de bits em formato abreviado 
   IJL_JFILE_READENTROPY = 6&
   IJL_JBUFF_READENTROPY = 7&
   'grava sequência de bits JFIF inteira
   IJL_JFILE_WRITEWHOLEIMAGE = 8&
   IJL_JBUFF_WRITEWHOLEIMAGE = 9&
   'grava sequência de bits de formato abreviado JPEG
   IJL_JFILE_WRITEHEADER = 10&
   IJL_JBUFF_WRITEHEADER = 11&
   'grava info da imagem em uma seq de bits abreviados de JPEG
   IJL_JFILE_WRITEENTROPY = 12&
   IJL_JBUFF_WRITEENTROPY = 13&
   'opcoes de decodificação escalar:
   'le imagem JPEG em escala 1/2 tamanho
   IJL_JFILE_READONEHALF = 14&
   IJL_JBUFF_READONEHALF = 15&
   'le imagem JPEG em escala 1/4 tamanho
   IJL_JFILE_READONEQUARTER = 16&
   IJL_JBUFF_READONEQUARTER = 17&
   'le imagem JPEG em escala 1/8 tamanho
   IJL_JFILE_READONEEIGHTH = 18&
   IJL_JBUFF_READONEEIGHTH = 19&
   'le amostra embutida em seq de bits JFIF
   IJL_JFILE_READTHUMBNAIL = 20&
   IJL_JBUFF_READTHUMBNAIL = 21&

End Enum

Private Type JPEG_CORE_PROPERTIES_VB
   UseJPEGPROPERTIES As Long                      'default = 0

   'especificadores de dados de entrada e saída de DIB
   DIBBytes As Long                               'default = NULL 4
   DIBWidth As Long                               'default = 8
   DIBHeight As Long                              'default = 12
   DIBPadBytes As Long                            'default = 16
   DIBChannels As Long                            'default = 20
   DIBColor As Long                               ';                  'default = IJL_BGR 24
   DIBSubsampling As Long                         'default = IJL_NONE 28

   'especificadores de dados entrada e saída de JPEG
   JPGFile As Long                                'default = NULL
   JPGBytes As Long                               'default = NULL 36
   JPGSizeBytes As Long                           'default = 40
   JPGWidth As Long                               'default = 44
   JPGHeight As Long                              'default = 48
   JPGChannels As Long                            'default = 3
   JPGColor As Long                               'default = IJL_YCBCR
   JPGSubsampling As Long                         'default = IJL_411
   JPGThumbWidth As Long                          'default = 0
   JPGThumbHeight As Long                         'default = 0

   'propriedades de conversão JPEG
   cconversion_reqd As Long                       'default = TRUE
   upsampling_reqd As Long                        'default = TRUE
   jquality As Long                               'default = 75

   'propriedades de baixo-nível 20.000 bytes
   jprops(0 To 19999) As Byte
End Type

Private Type SAFEARRAYBOUND
   cElements As Long
   lLbound As Long
End Type

Private Type SAFEARRAY2D
   cDims As Integer
   fFeatures As Integer
   cbElements As Long
   cLocks As Long
   pvData As Long
   Bounds(0 To 1) As SAFEARRAYBOUND
End Type

Private Type RGBQUAD
   rgbBlue As Byte
   rgbGreen As Byte
   rgbRed As Byte
   rgbReserved As Byte
End Type

Private Type BITMAPINFOHEADER                     '40 bytes
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

Private Type BITMAPINFO
   bmiHeader As BITMAPINFOHEADER
   bmiColors As RGBQUAD
End Type

Private Type BITMAP
   bmType As Long
   bmWidth As Long
   bmHeight As Long
   bmWidthBytes As Long
   bmPlanes As Integer
   bmBitsPixel As Integer
   bmBits As Long
End Type

Private Declare Function ijlInit Lib "ijl10.dll" (jcprops As Any) As Long
Private Declare Function ijlFree Lib "ijl10.dll" (jcprops As Any) As Long
Private Declare Function ijlWrite Lib "ijl10.dll" (jcprops As Any, ByVal ioType As Long) As Long

Private Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" ( lpvDest As Any, lpvSource As Any, ByVal cbCopy As Long)

Private Const BI_RGB = 0&
Private Const DIB_RGB_COLORS = 0                  '  color table in RGBs

Private Declare Function VarPtrArray Lib "msvbvm50.dll" Alias "VarPtr" (Ptr() As Any) As Long
Private Declare Function CreateCompatibleDC Lib "gdi32" (ByVal hdc As Long) As Long
Private Declare Function GetDC Lib "USER32" (ByVal hWnd As Long) As Long
Private Declare Function GetDesktopWindow Lib "USER32" () As Long
Private Declare Function CreateDIBSection Lib "gdi32" (ByVal hdc As Long, pBitmapInfo As BITMAPINFO, ByVal un As Long, lplpVoid As Long, ByVal Handle As Long, ByVal dw As Long) As Long
Private Declare Function BitBlt Lib "gdi32" (ByVal hDestDC As Long, ByVal x As Long, ByVal y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal dwRop As Long) As Long
Private Declare Function DeleteDC Lib "gdi32" (ByVal hdc As Long) As Long

Private Declare Function GetObjectAPI Lib "gdi32" Alias "GetObjectA" (ByVal hObject As Long, ByVal nCount As Long, lpObject As Any) As Long


'handle para a DIBSection atual
Private m_hDIb As Long
'handle para bitmap anterior no DC
Private m_hBmpOld As Long
'handle para o DC que tem a DIBSection
Private m_hDC As Long
'endereço da memória que aponta para os bits da DIBSection
Private m_lPtr As Long
'estrutura para conter info do BMP
Private m_tBI As BITMAPINFO

'cria device independent bitmap
Public Function CreateDIB(ByVal lhDC As Long, ByVal lWidth As Long, ByVal lHeight As Long, ByRef hDib As Long) As Boolean
   With m_tBI.bmiHeader
      .biSize = Len(m_tBI.bmiHeader)
      .biWidth = lWidth
      .biHeight = lHeight
      .biPlanes = 1
      .biBitCount = 24
      .biCompression = BI_RGB
      .biSizeImage = BytesPerScanLine * .biHeight
   End With
   hDib = CreateDIBSection(lhDC, m_tBI, DIB_RGB_COLORS, m_lPtr, 0, 0)
   CreateDIB = (hDib <> 0)
End Function

Public Function CreateFromPicture(ByRef picThis As StdPicture)
   Dim vglhDC As Long
   Dim vglhDCDesktop As Long
   Dim vglhBmpOld As Long
   Dim vgBMP As BITMAP
   GetObjectAPI picThis.handle, Len(vgBMP), vgBMP
   If (Create(vgBMP.bmWidth, vgBMP.bmHeight)) Then
      vglhDCDesktop = GetDC(GetDesktopWindow())
      If (vglhDCDesktop <> 0) Then
         vglhDC = CreateCompatibleDC(vglhDCDesktop)
         DeleteDC vglhDCDesktop
         If (vglhDC <> 0) Then
            vglhBmpOld = SelectObject(vglhDC, picThis.handle)
            LoadPictureBlt vglhDC
            SelectObject vglhDC, vglhBmpOld
            DeleteObject vglhDC
         End If
      End If
   End If
End Function

Public Function Create(ByVal lWidth As Long, ByVal lHeight As Long) As Boolean
   ClearUp
   m_hDC = CreateCompatibleDC(0)
   If (m_hDC <> 0) Then
      If (CreateDIB(m_hDC, lWidth, lHeight, m_hDIb)) Then
         m_hBmpOld = SelectObject(m_hDC, m_hDIb)
         Create = True
      Else
         DeleteObject m_hDC
         m_hDC = 0
      End If
   End If
End Function

Public Property Get BytesPerScanLine() As Long
   BytesPerScanLine = (m_tBI.bmiHeader.biWidth * 3 + 3) And &HFFFFFFFC
End Property

Public Property Get Width() As Long
   Width = m_tBI.bmiHeader.biWidth
End Property

Public Property Get Height() As Long
   Height = m_tBI.bmiHeader.biHeight
End Property

Public Sub LoadPictureBlt(ByVal lhDC As Long, _
                        Optional ByVal lSrcLeft As Long = 0, _
                        Optional ByVal lSrcTop As Long = 0, _
                        Optional ByVal lSrcWidth As Long = -1, _
                        Optional ByVal lSrcHeight As Long = -1, _
                        Optional ByVal eRop As RasterOpConstants = vbSrcCopy)
   If lSrcWidth < 0 Then lSrcWidth = m_tBI.bmiHeader.biWidth
   If lSrcHeight < 0 Then lSrcHeight = m_tBI.bmiHeader.biHeight
   BitBlt m_hDC, 0, 0, lSrcWidth, lSrcHeight, lhDC, lSrcLeft, lSrcTop, eRop
End Sub


Public Sub PaintPicture(ByVal lhDC As Long, _
                        Optional ByVal lDestLeft As Long = 0, _
                        Optional ByVal lDestTop As Long = 0, _
                        Optional ByVal lDestWidth As Long = -1, _
                        Optional ByVal lDestHeight As Long = -1, _
                        Optional ByVal lSrcLeft As Long = 0, _
                        Optional ByVal lSrcTop As Long = 0, _
                        Optional ByVal eRop As RasterOpConstants = vbSrcCopy)
   If (lDestWidth < 0) Then lDestWidth = m_tBI.bmiHeader.biWidth
   If (lDestHeight < 0) Then lDestHeight = m_tBI.bmiHeader.biHeight
   BitBlt lhDC, lDestLeft, lDestTop, lDestWidth, lDestHeight, m_hDC, lSrcLeft, lSrcTop, eRop
End Sub

Public Property Get hdc() As Long
   hdc = m_hDC
End Property

Public Property Get hDib() As Long
   hDib = m_hDIb
End Property

Public Property Get DIBSectionBitsPtr() As Long
   DIBSectionBitsPtr = m_lPtr
End Property

Public Sub ClearUp()
   If (m_hDC <> 0) Then
      If (m_hDIb <> 0) Then
         SelectObject m_hDC, m_hBmpOld
         DeleteObject m_hDIb
      End If
      DeleteObject m_hDC
   End If
   m_hDC = 0: m_hDIb = 0: m_hBmpOld = 0: m_lPtr = 0
End Sub

Public Function Resample(ByVal lNewHeight As Long, ByVal lNewWidth As Long) As IntelJpg
   If Create(lNewWidth, lNewHeight) Then
      If (lNewWidth <> m_tBI.bmiHeader.biWidth) Or (lNewHeight <> m_tBI.bmiHeader.biHeight) Then
         'mudou tamanho, redimensiona
         ResampleDib
      Else
         'não mudou tamanho, restorna só cópia
         LoadPictureBlt m_hDC
      End If
   End If
End Function

Private Function ResampleDib() As Boolean
   Dim bDibFrom() As Byte, bDibTo() As Byte, tSAFrom As SAFEARRAY2D, tSATo As SAFEARRAY2D
   Dim vgxScale As Single, vgyScale As Single
   Dim x As Long, y As Long, vgXEnd As Long, vgXOut As Long
   Dim vgfX As Single, fY As Single
   Dim vgifY As Long, vgifX As Long
   Dim dX As Single, dy As Single
   Dim r As Long, r1 As Single, r2 As Single, r3 As Single, r4 As Single
   Dim g As Long, g1 As Single, g2 As Single, g3 As Single, g4 As Single
   Dim b As Long, b1 As Single, b2 As Single, b3 As Single, b4 As Single
   Dim ir1 As Long, ig1 As Long, ib1 As Long
   Dim ir2 As Long, ig2 As Long, ib2 As Long

   'pega bits do DIB section
   With tSAFrom
      .cbElements = 1
      .cDims = 2
      .Bounds(0).lLbound = 0
      .Bounds(0).cElements = m_tBI.bmiHeader.biHeight
      .Bounds(1).lLbound = 0
      .Bounds(1).cElements = BytesPerScanLine()
      .pvData = m_lPtr
   End With
   CopyMemory ByVal VarPtrArray(bDibFrom()), VarPtr(tSAFrom), 4

   With tSATo
      .cbElements = 1
      .cDims = 2
      .Bounds(0).lLbound = 0
      .Bounds(0).cElements = Height
      .Bounds(1).lLbound = 0
      .Bounds(1).cElements = BytesPerScanLine()
      .pvData = DIBSectionBitsPtr
   End With
   CopyMemory ByVal VarPtrArray(bDibTo()), VarPtr(tSATo), 4
   vgxScale = (Width - 1) / Width
   vgyScale = (Height - 1) / Height
   vgXEnd = Width - 1
   For y = 0 To Height - 1
      fY = y * vgyScale
      vgifY = Int(fY)
      dy = fY - vgifY
      For x = 0 To vgXEnd
         vgfX = x * vgxScale
         vgifX = Int(vgfX)
         dX = vgfX - vgifX
         
         vgifX = vgifX * 3
         'interpola usando os quatro os pixels mais próximos na fonte
         b1 = bDibFrom(vgifX, vgifY): g1 = bDibFrom(vgifX + 1, vgifY): r1 = bDibFrom(vgifX + 2, vgifY)
         b2 = bDibFrom(vgifX + 3, vgifY): g2 = bDibFrom(vgifX + 4, vgifY): r2 = bDibFrom(vgifX + 5, vgifY)
         b3 = bDibFrom(vgifX, vgifY + 1): g3 = bDibFrom(vgifX + 1, vgifY + 1): r3 = bDibFrom(vgifX + 2, vgifY + 1)
         b4 = bDibFrom(vgifX + 3, vgifY + 1): g4 = bDibFrom(vgifX + 4, vgifY + 1): r4 = bDibFrom(vgifX + 5, vgifY + 1)
         
         'interpola na direção x
         ir1 = r1 * (1 - dy) + r3 * dy: ig1 = g1 * (1 - dy) + g3 * dy: ib1 = b1 * (1 - dy) + b3 * dy
         ir2 = r2 * (1 - dy) + r4 * dy: ig2 = g2 * (1 - dy) + g4 * dy: ib2 = b2 * (1 - dy) + b4 * dy
         'interpola em y
         r = ir1 * (1 - dX) + ir2 * dX: g = ig1 * (1 - dX) + ig2 * dX: b = ib1 * (1 - dX) + ib2 * dX
         
         'prepara saída
         If (r < 0) Then r = 0
         If (r > 255) Then r = 255
         If (g < 0) Then g = 0
         If (g > 255) Then g = 255
         If (b < 0) Then b = 0
         If (b > 255) Then
                     b = 255
         End If
         vgXOut = x * 3
         bDibTo(vgXOut, y) = b
         bDibTo(vgXOut + 1, y) = g
         bDibTo(vgXOut + 2, y) = r
      Next x
   Next y
   'limpa o descritor do arranjo
   CopyMemory ByVal VarPtrArray(bDibFrom), 0&, 4
   CopyMemory ByVal VarPtrArray(bDibTo), 0&, 4
End Function

Private Sub Class_Terminate()
   Dim vgErrNum As Long, vgErrDesc As String, vgErrSrc As String

   'salva erro
   vgErrNum = Err.Number
   vgErrDesc = Err.Description
   vgErrSrc = Err.Source
   
   ClearUp

   'restaura erro
   Err.Number = vgErrNum
   Err.Description = vgErrDesc
   Err.Source = vgErrSrc

End Sub

Public Function SaveJPG(ByVal sFile As String, Optional ByVal lQuality As Long = 90) As Boolean
   Dim vgtJ As JPEG_CORE_PROPERTIES_VB
   Dim vgbFile() As Byte
   Dim lPtr As Long
   Dim lR As Long
   lR = ijlInit(vgtJ)
   If lR = IJL_OK Then
      'ajusta informaçõs do DIB
      'designa DIBWidth
      vgtJ.DIBWidth = Width
      'designa DIBHeight
      vgtJ.DIBHeight = -Height
      'designa DIBBytes (ponteiro para dados JPG não comprimidos)
      vgtJ.DIBBytes = DIBSectionBitsPtr
      'importante! diz à IJL quantos bytes extras existem em cada linha de scan do DIB
      'para ajustar em 32 bits
      vgtJ.DIBPadBytes = BytesPerScanLine - Width * 3
      
      'ajusta informações JPEG
      
      'designa JPGFile
      vgbFile = StrConv(sFile, vbFromUnicode)
      ReDim Preserve vgbFile(0 To UBound(vgbFile) + 1) As Byte
      vgbFile(UBound(vgbFile)) = 0
      lPtr = VarPtr(vgbFile(0))
      CopyMemory vgtJ.JPGFile, lPtr, 4
      'designa JPGWIdth
      vgtJ.JPGWidth = Width
      'e JPGHeight
      vgtJ.JPGHeight = Height
      'designa qualidade/compressão para gravar
      vgtJ.jquality = lQuality
                        
      'grava a imagem
      lR = ijlWrite(vgtJ, IJL_JFILE_WRITEWHOLEIMAGE)
      If lR = IJL_OK Then
         SaveJPG = True
      Else
         'mostra erro
         MsgBox "Falha ao salvar JPJ", vbExclamation
      End If
      
      'libera memória
      ijlFree vgtJ
   Else
      'mostra erro
      MsgBox "Falha ao inicializar biblioteca IJL: " & lR, vbExclamation
   End If
         
End Function
