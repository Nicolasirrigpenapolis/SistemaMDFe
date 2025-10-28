VERSION 1.0 CLASS
BEGIN
      MultiUse = -1                               'True
      Persistable = 0                             'NotPersistable
      DataBindingBehavior = 0                     'vbNone
      DataSourceBehavior  = 0                     'vbNone
      MTSTransactionMode  = 0                     'NotAnMTSObject
END
Attribute VB_Name = "Base64"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Const BASE64CHR As String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/="
Private pbBase64Byt(0 To 63)    As Byte                  ' base 64 encoder byte array
Private psUUEncodeChr(0 To 63)  As String                ' UU encoder string array


Private Sub Class_Initialize()
   Dim iPtr As Integer
   For iPtr = 0 To 63
      pbBase64Byt(iPtr) = Asc(Mid$(BASE64CHR, iPtr + 1, 1))
      psUUEncodeChr(iPtr) = Chr$(iPtr + &H20)
   Next
   psUUEncodeChr(0) = Chr$(&H60)

End Sub

Public Function DecodeBase64String(ByVal str2Decode As String) As String

' ******************************************************************************
'
' Synopsis:     Decode a Base 64 string
'
' Parameters:   str2Decode  - The base 64 encoded input string
'
' Return:       decoded string
'
' Description:
' Coerce 4 base 64 encoded bytes into 3 decoded bytes by converting 4, 6 bit
' values (0 to 63) into 3, 8 bit values. Transform the 8 bit value into its
' ascii character equivalent. Stop converting at the end of the input string
' or when the first '=' (equal sign) is encountered.
'
' ******************************************************************************

            Dim lPtr            As Long
            Dim iValue          As Integer
            Dim iLen            As Integer
            Dim iCtr            As Integer
            Dim Bits(1 To 4)    As Byte
            Dim strDecode       As String

            ' for each 4 character group....
            For lPtr = 1 To Len(str2Decode) Step 4
               iLen = 4
               For iCtr = 0 To 3
                  ' retrive the base 64 value, 4 at a time
                  iValue = InStr(1, BASE64CHR, Mid$(str2Decode, lPtr + iCtr, 1), vbBinaryCompare)
                  Select Case iValue
                     ' A~Za~z0~9+/
                     Case 1 To 64: Bits(iCtr + 1) = iValue - 1
                     ' =
                     Case 65
                                 iLen = iCtr
                                 Exit For
                     ' not found
                     Case 0: Exit Function
                  End Select
               Next

               ' convert the 4, 6 bit values into 3, 8 bit values
               Bits(1) = Bits(1) * &H4 + (Bits(2) And &H30) \ &H10
               Bits(2) = (Bits(2) And &HF) * &H10 + (Bits(3) And &H3C) \ &H4
               Bits(3) = (Bits(3) And &H3) * &H40 + Bits(4)

               ' add the three new characters to the output string
               For iCtr = 1 To iLen - 1
                  strDecode = strDecode & Chr$(Bits(iCtr))
               Next

            Next

            DecodeBase64String = strDecode

End Function

Public Function EncodeBase64String(ByVal str2Encode As String, Optional ByVal vgISemail As Boolean = False) As String

' ******************************************************************************
'
' Synopsis:     Base 64 encode a string
'
' Parameters:   str2Encode  - The input string
'
' Return:       encoded string
'
' Description:
' Convert a string to a byte array and pass to EncodeBase64Byte function (above)
' for Base64 conversion. Convert byte array back to a string and return.
'
' ******************************************************************************

            Dim tmpByte()   As Byte

            If Len(str2Encode) Then

               ' convert string to byte array
               tmpByte = StrConv(str2Encode, vbFromUnicode)

               ' pass to the byte array encoder
               tmpByte = EncodeBase64Byte(tmpByte, vgISemail)

               ' convert back to string & return
               EncodeBase64String = StrConv(tmpByte, vbUnicode)

            End If

End Function

Public Function EncodeBase64Byte(InArray() As Byte, ByVal vgISemail As Boolean) As Variant

'******************************************************************************
'
' Synopsis:     Base 64 encode a byte array
'
' Parameters:   InArray  - The input byte array
'
' Return:       encoded byte array
'
' Description:
'   Convert a byte array to a Base 64 encoded byte array. Coerce 3 bytes into
'   4 by converting 3, 8 bit bytes into 4, 6 bit values. Each 6 bit value
'   (0 to 63) is then used as a pointer into a base64 byte array to derive a
'   character.
'
'******************************************************************************

Dim lInPtr              As Long                       ' pointer into input array
Dim lOutPtr             As Long                       ' pointer into output array
Dim OutArray()          As Byte                       ' output byte array buffer
Dim lLen                As Long                       ' number of extra bytes past 3 byte boundry
Dim iNewLine            As Long                       ' line counter

' if size of input array is not a multiple of 3,
' increase it to the next multiple of 3
lLen = (UBound(InArray) - LBound(InArray) + 1) Mod 3
If lLen Then
            lLen = 3 - lLen
            ReDim Preserve InArray(UBound(InArray) + lLen)
End If

' create an output buffer
ReDim OutArray(UBound(InArray) * 2 + 100)

' step through the input array, 3 bytes at a time
For lInPtr = 0 To UBound(InArray) Step 3

            ' add CrLf as required
            If iNewLine = 19 And vgISemail Then
                        OutArray(lOutPtr) = 13
                        OutArray(lOutPtr + 1) = 10
                        lOutPtr = lOutPtr + 2
                        iNewLine = 0
            End If

            ' convert 3 bytes into 4 base 64 encoded bytes
            OutArray(lOutPtr) = pbBase64Byt((InArray(lInPtr) And &HFC) \ 4)
            OutArray(lOutPtr + 1) = pbBase64Byt((InArray(lInPtr) And &H3) * &H10 + (InArray(lInPtr + 1) And &HF0) \ &H10)
            OutArray(lOutPtr + 2) = pbBase64Byt((InArray(lInPtr + 1) And &HF) * 4 + (InArray(lInPtr + 2) And &HC0) \ &H40)
            OutArray(lOutPtr + 3) = pbBase64Byt(InArray(lInPtr + 2) And &H3F)

            ' update pointers
            lOutPtr = lOutPtr + 4
            iNewLine = iNewLine + 1
Next

' add terminator '=' as required
Select Case lLen
            Case 1: OutArray(lOutPtr - 1) = 61
            Case 2: OutArray(lOutPtr - 1) = 61: OutArray(lOutPtr - 2) = 61
End Select

' add CrLf if not already there
If OutArray(lOutPtr - 2) <> 13 And vgISemail Then
            OutArray(lOutPtr) = 13
            OutArray(lOutPtr + 1) = 10
            lOutPtr = lOutPtr + 2
End If

' resize output buffer and return
ReDim Preserve OutArray(lOutPtr - 1)
EncodeBase64Byte = OutArray

End Function

Public Function UUEncodeString(ByRef str2UUEncode As String) As String

' ******************************************************************************
'
' Synopsis:     UUEncode a string
'
' Parameters:   str2UUEncode  - The input string
'
' Return:       encoded string
'
' Description:
' UU Encode a string. Coerce 3 bytes into 4 by converting 3, 8 bit bytes into
' 4, 6 bit values. Each 6 bit value (0 to 63) is then used as a pointer into
' the UUEncode string array to derive the correct character. The string will
' be a multiple of 4 bytes in lenght after conversion, padded with '=' as
' required. The line length will be encoded as a leading character
' (same 0 to 63 encoding) in the return string.
'
' ******************************************************************************

            Dim sValue              As String
            Dim lPtr                As Long
            Dim lCtr                As Long
            Dim lLen                As Long
            Dim lLineLen            As Long
            Dim sEncoded            As String
            Dim Bits8(1 To 3)       As Byte
            Dim Bits6(1 To 4)       As Byte

            lLineLen = Len(str2UUEncode)
            ' lines are limited to 63
            If lLineLen > 63 Then Exit Function

            For lCtr = 1 To Len(str2UUEncode) Step 3

                        ' Get 3 characters
                        sValue = Mid$(str2UUEncode, lCtr, 3)
                        lLen = Len(sValue)

                        ' Move string data into a byte array, then
                        ' swap bits to create 4, 6 bit values (0-63)
                        If lLen < 3 Then Erase Bits8
                        CopyMemory Bits8(1), ByVal sValue, lLen
                        Bits6(1) = (Bits8(1) And &HFC) \ &H4
                        Bits6(2) = (Bits8(1) And &H3) * &H10 + (Bits8(2) And &HF0) \ &H10
                        Bits6(3) = (Bits8(2) And &HF) * &H4 + (Bits8(3) And &HC0) \ &H40
                        Bits6(4) = Bits8(3) And &H3F

                        ' Encode new 4 byte string by selecting a character from
                        ' the array. Length is determined by 'lLen' to make sure
                        ' the file attachment is the right length
                        For lPtr = 1 To lLen + 1
                                    sEncoded = sEncoded & psUUEncodeChr(Bits6(lPtr))
                        Next

            Next

            ' add the line length character
            sEncoded = psUUEncodeChr(lLineLen) & sEncoded

            ' The decoder expects the size to be a multiple of 4 bytes.
            ' Possible sizes for the last packet are: 2, 3 & 4.
            Select Case lLen + 1
                        Case 2: sEncoded = sEncoded & "=="               ' send two pad characters
                        Case 3: sEncoded = sEncoded & "="                ' send one pad character
            ' no pad characers needed
            End Select

            UUEncodeString = sEncoded

End Function

'verifica se a string passada como parâmetro está com encriptação Base64
Public Function IsBase64(ByVal sBase64String As String) As Boolean
   
   Dim RegularExpressions As Object   
   
   Set RegularExpressions = CreateObject("VBScript.RegExp")
   
   RegularExpressions.Pattern = "[^a-zA-Z0-9+/=]"
   If Not RegularExpressions.Test(sBase64String) And Len(sBase64String) Mod 4 = 0 And Len(sBase64String) >= 4 Then
      IsBase64 = True
   Else
      IsBase64 = False
   End If
   Set RegularExpressions = Nothing
End Function
