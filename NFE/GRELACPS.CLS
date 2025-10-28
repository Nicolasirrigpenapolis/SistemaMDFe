VERSION 1.0 CLASS
BEGIN
      MultiUse = -1                                          'True
      Persistable = 0                                        'NotPersistable
      DataBindingBehavior = 0                                'vbNone
      DataSourceBehavior  = 0                                'vbNone
      MTSTransactionMode  = 0                                'NotAnMTSObject
END
Attribute VB_Name = "GRelationColumns"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private vgParent As Object
Private vgRelationColumns As Collection

Public Property Get Item(ByVal Index As Variant) As GRelationColumn
Attribute Item.VB_UserMemId = 0
   On Error Resume Next
   Set Item = vgRelationColumns.Item(Index)
End Property

Public Property Get NewEnum() As IUnknown
Attribute NewEnum.VB_UserMemId = -4
Attribute NewEnum.VB_MemberFlags = "40"
   vgRelationColumns.[_NewEnum]
   Set NewEnum = vgRelationColumns.[_NewEnum]
End Property

Public Property Set Parent(ByRef NewParent As Object)
   Set vgParent = NewParent
End Property

Friend Function Add(ByVal NewName As String, ByVal NewBase As GColumn, ByVal NewForeign As GColumn, ByVal NewHidden As Boolean, ByVal NewSystem As Boolean) As GRelationColumn
   Dim oRelationColumn As GRelationColumn
   Set oRelationColumn = New GRelationColumn
   oRelationColumn.Init vgParent, NewBase, NewForeign, NewHidden, NewSystem
   vgRelationColumns.Add oRelationColumn, NewName
   Set Add = oRelationColumn
End Function

Friend Property Get Count() As Long
   Count = vgRelationColumns.Count
End Property

Friend Function Remove(ByVal Index As Variant) As Boolean
   On Error Resume Next
   vgRelationColumns.Remove Index
   Remove = (Err.Number = 0)
End Function

Private Sub Class_Initialize()
   Set vgRelationColumns = New Collection
End Sub

Private Sub Class_Terminate()
   Set vgRelationColumns = Nothing
End Sub
