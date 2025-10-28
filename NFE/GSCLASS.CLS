VERSION 1.0 CLASS
BEGIN
      MultiUse = -1                               'True
      Persistable = 0                             'NotPersistable
      DataBindingBehavior = 0                     'vbNone
      DataSourceBehavior  = 0                     'vbNone
      MTSTransactionMode  = 0                     'NotAnMTSObject
END
Attribute VB_Name = "GSubClass"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'********************************************************************************************
'** GSubClass
'** GAS Informática Ltda
'** Based on code from Paul Caton (paul_caton@hotmail.com)
'********************************************************************************************

Option Explicit

Private SubClasses As Collection

Private Declare Function GetCurrentProcessId Lib "kernel32" () As Long
Private Declare Function GetWindowThreadProcessId Lib "user32" (ByVal hWnd As Long, lpdwProcessId As Long) As Long
Private Declare Function IsWindow Lib "user32" (ByVal hWnd As Long) As Long

Public Function AddMessage(ByVal hWnd As Long, ByVal Message As GSCMessage, ByVal When As GSCWhen) As Boolean
   On Error GoTo DeuErro
   SubClasses(CStr(hWnd)).AddMessage Message, When
   
   AddMessage = True
   Exit Function
   
DeuErro:
   Err.Clear
   AddMessage = False
End Function

Public Function RemoveMessage(ByVal hWnd As Long, ByVal Message As GSCMessage, ByVal When As GSCWhen) As Boolean
   On Error GoTo DeuErro
   SubClasses(CStr(hWnd)).RemoveMessage Message, When
   
   RemoveMessage = True
   Exit Function
   
DeuErro:
   Err.Clear
   RemoveMessage = False
End Function

Public Function SubClass(ByVal hWnd As Long, ByVal OwnerCallback As GSubclassInterface) As Boolean
   Dim vgItemSubClass As GSubClassItem, nID As Long, nMyID As Long
   
   On Error GoTo DeuErro
   
   If SubClasses Is Nothing Then
      Set SubClasses = New Collection
   End If
   
   If IsWindow(hWnd) = 0 Then                                                 'Ensure the window handle is valid
      GoTo DeuErro
   End If

   nMyID = GetCurrentProcessId                                                'Get this process's ID
   GetWindowThreadProcessId hWnd, nID                                         'Get the process ID associated with the window handle
   If nID <> nMyID Then                           'Ensure that the window handle doesn't belong to another process
      GoTo DeuErro
   End If
   
   On Error Resume Next
   Set vgItemSubClass = SubClasses(CStr(hWnd))
   If Not vgItemSubClass Is Nothing Then
      Set vgItemSubClass = Nothing
      GoTo DeuErro
   End If
   
   On Error GoTo DeuErro
   
   Set vgItemSubClass = New GSubClassItem
   vgItemSubClass.hWnd = hWnd
   vgItemSubClass.OwnerCallback = ObjPtr(OwnerCallback)
   
   SubClasses.Add vgItemSubClass, CStr(hWnd)      'Add the hWnd/thunk-address to the collection
   
   If Not vgItemSubClass.SubClass Then
      GoTo DeuErro
   End If

   SubClass = True                                'Indicate success
   
   Exit Function                                  'Exit Subclass

DeuErro:
   Err.Clear
   SubClass = False

End Function

Private Sub Class_Initialize()
   Set SubClasses = New Collection
End Sub

'Terminate all subclassing
Public Sub Terminate()
   Dim i As Long
   On Error Resume Next
   If Not SubClasses is Nothing Then
      With SubClasses
         For i = .Count To 1 Step -1                                            'Loop through the collection of window handles in reverse order
            .Item(i).UnSubClass
         Next                                     'Next member of the collection
      End With
      Set SubClasses = Nothing                    'Destroy the hWnd/thunk-address collection
   End If
   Err.Clear
End Sub

'UnSubclass the specified window handle
Public Sub UnSubClass(Optional ByVal hwnd As Long)
   On Error GoTo DeuErro
   If hwnd <> 0 Then
      SubClasses(CStr(hwnd)).UnSubClass
      SubClasses.Remove CStr(hwnd)
   Else
      Call Terminate                              'unsubclass all handles
   End If
   
DeuErro:
   Err.Clear
End Sub
