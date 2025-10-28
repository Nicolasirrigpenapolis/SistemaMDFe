VERSION 1.0 CLASS
BEGIN
      MultiUse = -1                               'True
      Persistable = 0                             'NotPersistable
      DataBindingBehavior = 0                     'vbNone
      DataSourceBehavior  = 0                     'vbNone
      MTSTransactionMode  = 0                     'NotAnMTSObject
END
Attribute VB_Name = "GSubClassItem"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'********************************************************************************************
'** GSubClassItem
'** GAS Informática Ltda
'** Based on code from Paul Caton (paul_caton@hotmail.com)
'********************************************************************************************
Option Explicit

Private Const GWL_WNDPROC          As Long = -4                                     'SetWindowsLong WndProc index

Private Const PAGE_RWX             As Long = &H40&                                  'Allocate executable memory
Private Const MEM_COMMIT           As Long = &H1000&                                'Commit allocated memory

Private Const MSG_ENTRIES          As Long = 32                                     'Number of msg table entries

Private Const VAR_SHUTDOWN         As Long = 0                                      'Thunk data index of the shutdown flag
Private Const VAR_OWNER            As Long = 1                                      'Thunk data index of the Owner object's vTable address
Private Const VAR_WNDPROC          As Long = 2                                      'Thunk data index of the original WndProc
Private Const VAR_CALLBACK         As Long = 3                                      'Thunk data index of the callback method address

Private Const FUNC_EBMODE          As Long = 4                                      'Thunk data index of the EbMode function address
Private Const FUNC_CWP             As Long = 5                                      'Thunk data index of the CallWindowProc function address
Private Const FUNC_SWL             As Long = 6                                      'Thunk data index of the SetWindowsLong function address
Private Const FUNC_BADPTR          As Long = 7                                      'Thunk data index of the IsBadCodePtr function address
Private Const FUNC_VIRTUALFREE     As Long = 8                                      'Thunk data index of the callback method address

Private Const VAR_CALLSTACK        As Long = 9                                      'Callstack control
Private Const VAR_BEFORE_TABLE     As Long = 10                                     'Main Before Table
Private Const VAR_AFTER_TABLE      As Long = 11                                     'Main After Table

Private Declare Function GetModuleHandleA Lib "kernel32" (ByVal lpModuleName As String) As Long
Private Declare Function GetProcAddress Lib "kernel32" (ByVal hModule As Long, ByVal lpProcName As String) As Long
Private Declare Function SetWindowLongA Lib "user32" (ByVal hWnd As Long, ByVal nIndex As Long, ByVal dwNewLong As Long) As Long
Private Declare Function IsBadCodePtr Lib "kernel32" (ByVal lpfn As Long) As Long
Private Declare Sub RtlMoveMemory Lib "kernel32" (ByVal Destination As Long, ByVal Source As Long, ByVal Length As Long)
Private Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (Destination As Any, Source As Any, ByVal Length As Long)
Private Declare Function VirtualAlloc Lib "kernel32" (ByVal lpAddress As Long, ByVal dwSize As Long, ByVal flAllocationType As Long, ByVal flProtect As Long) As Long

Dim vgPatch As Long
Dim vgMemCallBack As Long

Dim vgAfterTable As Collection
Dim vgBeforeTable As Collection

Dim vgOwnerCallBack          As Long
Dim vgHwnd                   As Long

Public Property Let OwnerCallback(ByVal NewOwnerCallBack As Long)
   vgOwnerCallBack = NewOwnerCallBack
End Property

Public Property Get OwnerCallback() As Long
   OwnerCallback = vgOwnerCallBack
End Property

Public Property Let hWnd(ByVal NewhWnd As Long)
   vgHwnd = NewhWnd
End Property

Public Property Get hWnd() As Long
   hWnd = vgHwnd
End Property

Private Sub SetData(ByVal Index As Long, ByVal Value As Long)
   RtlMoveMemory vgMemCallBack + (Index * 4), VarPtr(Value), 4
End Sub

Private Function GetData(ByVal Index As Long) As Long
   RtlMoveMemory VarPtr(GetData), vgMemCallBack + (Index * 4), 4
End Function

Private Function SetPatch(ByVal Value As Long) As String
   Call CopyMemory(ByVal (vgMemCallBack + vgPatch), Value, 4)
End Function

Private Function SetMessage(ByVal nTable As Long, ByVal Index As Long, ByVal Message As Long)
   RtlMoveMemory GetData(nTable) + (Index * 4), VarPtr(Message), 4
End Function

'Add the message to the specified table of the window handle
Private Sub AddMsg(ByRef vgTableMessages As Collection, ByVal Message As GSCMessage, ByVal nTable As Long)
   Dim vgQt As Long, i As Long
   On Error GoTo DeuErro
   
   If Message = ALL_MESSAGES Then                                             'If ALL_MESSAGES are being added to the table...
      Set vgTableMessages = New Collection
      vgQt = ALL_MESSAGES                         'Set the table entry count to ALL_MESSAGES
   Else
      vgQt = vgTableMessages.Count                'Get the current table entry count
      If vgQt >= MSG_ENTRIES Then                 'Check for message table overflow
         Exit Sub
      End If
      vgTableMessages.Add Message, CStr(Message)  'add message in collection
      For i = 1 To vgTableMessages.Count          'Loop through the table entries
         SetMessage nTable, i, Val(vgTableMessages(i))
      Next
      vgQt = vgTableMessages.Count
   End If

   SetMessage nTable, 0, vgQt                     'Store the new table entry count
      
DeuErro:

End Sub

'Delete the message from the specified table of the window handle
Private Sub DelMsg(ByRef vgTableMessages As Collection, ByVal Message As GSCMessage, ByVal nTable As Long)
   Dim vgQt As Long, i As Long
   On Error GoTo DeuErro

   If Message = ALL_MESSAGES Then                                             'If ALL_MESSAGES are being deleted from the table...
      Set vgTableMessages = New Collection
      vgQt = 0                                    'Zero the table entry count
   Else
      vgTableMessages.Remove CStr(Message)        'remove message from collection
      For i = 1 To vgTableMessages.Count          'Loop through the table entries
         SetMessage nTable, i, Val(vgTableMessages(i))
      Next
      vgQt = vgTableMessages.Count
   End If
   
   SetMessage nTable, 0, vgQt                     'Store the new table entry count
      
DeuErro:

End Sub

'Return the address of the specified DLL/procedure
Private Function GetFunctionAddress(ByVal sDLL As String, ByVal sProc As String) As Long
   GetFunctionAddress = GetProcAddress(GetModuleHandleA(sDLL), sProc)                    'Get the specified procedure address
End Function

Private Function InEXE() As Boolean
   On Error GoTo DeuErro
   Debug.Print 1 / 0
   InEXE = True
   Exit Function

DeuErro:
   InEXE = False
End Function

Public Sub AddMessage(ByVal Message As GSCMessage, ByVal When As GSCWhen)
   If IsBadCodePtr(vgMemCallBack) = 0 Then                               'Ensure that the thunk hasn't already released its memory
      If When And MSG_BEFORE Then                                        'If the message is to be added to the before original WndProc table...
         AddMsg vgBeforeTable, Message, VAR_BEFORE_TABLE                 'Add the message to the before table
      End If
      If When And MSG_AFTER Then                                         'If message is to be added to the after original WndProc table...
         AddMsg vgAfterTable, Message, VAR_AFTER_TABLE                   'Add the message to the after table
      End If
   End If
End Sub

Public Sub RemoveMessage(ByVal Message As GSCMessage, ByVal When As GSCWhen)
   If IsBadCodePtr(vgMemCallBack) = 0 Then                               'Ensure that the thunk hasn't already released its memory
      If When And MSG_BEFORE Then                                        'If the message is to be deleted from the before original WndProc table...
         DelMsg vgBeforeTable, Message, VAR_BEFORE_TABLE                 'Delete the message from the before table
      End If
      If When And MSG_AFTER Then                                         'If the message is to be deleted from the after original WndProc table...
         DelMsg vgAfterTable, Message, VAR_AFTER_TABLE                   'Delete the message from the after table
      End If
   End If
End Sub

Public Function SubClass() As Boolean
   Dim vgHex As String, vgAddr As Long, vgSCode As String, vgCodeLen As Long, vgMemLen As Long, _
       vgDataLenght As Long, vgOffSet As Long, vgOldProc As Long, i As Long

   On Error GoTo DeuErro

   vgDataLenght = 11
   vgPatch = 56

   vgHex$ = "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000031C031D26089E5BB00000000FF4324E87A00000083FE027414BAFF" + _
            "FFFFFFE83E000000837D14000F85DE00000053FF7530FF752CFF7528FF7524FF7308FF531489451C5BE84500000083FE020F84B9000000BA00000000E805000000E9AA000000E879000000" + _
            "83F9000F849B000000538D451C508D4D1451528D4D30518D452C50FF7528FF7524FF7304FF530C5B53FF730CFF531C5B751A833B007515BE01000000837B10007462FF531089C683FE0075" + _
            "585853FF73086AFCFF7524FF53185B837B24017545895D108B45208945186183C41468008000006A005351FF632083FA0074058B7B28EB038B7B2C8B0FE30E85C9781183C7048B4528F2AF" + _
            "7407B900000000EB05B901000000C3FF4B2461C21000000000000000"
   
   vgOffSet = ((vgDataLenght + 1) * 8) / 2

   'Convert the string from hex pairs to bytes and store
   'in the ASCII string opcode buffer
   For i = 1 To Len(vgHex$) Step 2
      vgSCode = vgSCode & ChrB$(Val("&H" & Mid$(vgHex$, i, 2)))
   Next
   
   vgCodeLen = LenB(vgSCode)

   vgMemLen = vgCodeLen + 8 * (MSG_ENTRIES + 1)

   vgMemCallBack = VirtualAlloc(0, vgMemLen, MEM_COMMIT, PAGE_RWX)                  'Allocate executable memory

   Call CopyMemory(ByVal vgMemCallBack, ByVal StrPtr(vgSCode), vgCodeLen)
   
   SetPatch vgMemCallBack
   
   RtlMoveMemory VarPtr(vgAddr), vgOwnerCallBack, 4                                 'Get the address of the owner's vTable
   RtlMoveMemory VarPtr(vgAddr), vgAddr + &H1C, 4                                   'Get the address of the implemented interface

   If Not InEXE Then
      SetData FUNC_EBMODE, GetFunctionAddress("vba6", "EbMode")
   Else
      SetData FUNC_EBMODE, 0
   End If
   SetData FUNC_CWP, GetFunctionAddress("user32", "CallWindowProcA")
   SetData FUNC_SWL, GetFunctionAddress("user32", "SetWindowLongA")
   SetData FUNC_BADPTR, GetFunctionAddress("kernel32", "IsBadCodePtr")
   SetData FUNC_VIRTUALFREE, GetFunctionAddress("kernel32", "VirtualFree")
   
   SetData VAR_OWNER, vgOwnerCallBack
   SetData VAR_CALLBACK, vgAddr
   SetData VAR_SHUTDOWN, 0                        'Store the callback address in the thunk data
   
   SetData VAR_CALLSTACK, 0

   SetData VAR_BEFORE_TABLE, vgMemCallBack + vgCodeLen 'Store the address of the before table in the thunk data
   SetData VAR_AFTER_TABLE, vgMemCallBack + vgCodeLen + ((MSG_ENTRIES + 1) * 4) 'Store the address of the after table in the thunk data

   Set vgAfterTable = New Collection
   Set vgBeforeTable = New Collection

   vgOldProc = SetWindowLongA(vgHwnd, GWL_WNDPROC, vgMemCallBack + vgOffSet)    'Set the new WndProc, return the address of the original WndProc

   If vgOldProc = 0 Then GoTo DeuErro

   SetData VAR_WNDPROC, vgOldProc                                               'Store the callback address in the thunk data

   SubClass = True

   Exit Function

DeuErro:
   SubClass = False

End Function

Public Function UnSubClass() As Boolean
   SetData VAR_SHUTDOWN, 1                                        'shutdown...
End Function

