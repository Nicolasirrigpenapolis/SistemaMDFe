VERSION 1.0 CLASS
BEGIN
      MultiUse = -1                                                 'True
      Persistable = 0                                               'NotPersistable
      DataBindingBehavior = 0                                       'vbNone
      DataSourceBehavior  = 0                                       'vbNone
      MTSTransactionMode  = 0                                       'NotAnMTSObject
END
Attribute VB_Name = "GQuerys"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private vgParent As Object
Private vgQuerys As Collection

Public Property Get Item(ByVal Index As Variant) As GQuery
Attribute Item.VB_UserMemId = 0
   On Error Resume Next
   Set Item = vgQuerys.Item(Index)
End Property

Public Property Get NewEnum() As IUnknown
Attribute NewEnum.VB_UserMemId = -4
Attribute NewEnum.VB_MemberFlags = "40"
   vgQuerys.[_NewEnum]
   Set NewEnum = vgQuerys.[_NewEnum]
End Property

Public Property Set Parent(ByRef NewParent As Object)
   Set vgParent = NewParent
End Property

Friend Function Add(ByVal NewName As String, ByVal NewTitle As String, ByVal NewQuery As String) As GQuery
   Dim oQuery As GQuery
   Set oQuery = New GQuery
   oQuery.Init vgParent, NewName, NewTitle, NewQuery, vgQuerys.Count + 1
   vgQuerys.Add oQuery, NewName
   Set Add = oQuery
End Function

Friend Property Get count() As Long
   Count = vgQuerys.Count
End Property

Friend Function Remove(ByVal Index As Variant) As Boolean
   On Error Resume Next
   vgQuerys.Remove Index
   Remove = (Err.Number = 0)
End Function

Private Sub Class_Initialize()
   Set vgQuerys = New Collection
End Sub

Private Sub Class_Terminate()
   Set vgQuerys = Nothing
End Sub
