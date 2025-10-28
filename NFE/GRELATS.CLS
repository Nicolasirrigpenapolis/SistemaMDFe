VERSION 1.0 CLASS
BEGIN
      MultiUse = -1                                          'True
      Persistable = 0                                        'NotPersistable
      DataBindingBehavior = 0                                'vbNone
      DataSourceBehavior  = 0                                'vbNone
      MTSTransactionMode  = 0                                'NotAnMTSObject
END
Attribute VB_Name = "GRelations"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private vgParent As Object
Private vgRelations As Collection

Public Property Get Item(ByVal Index As Variant) As GRelation
Attribute Item.VB_UserMemId = 0
   On Error Resume Next
   Set Item = vgRelations.Item(Index)
End Property

Public Property Get NewEnum() As IUnknown
Attribute NewEnum.VB_UserMemId = -4
Attribute NewEnum.VB_MemberFlags = "40"
   vgRelations.[_NewEnum]
   Set NewEnum = vgRelations.[_NewEnum]
End Property

Public Property Set Parent(ByRef NewParent As Object)
   Set vgParent = NewParent
End Property

Friend Function Add(ByVal NewName As String, ByVal NewBase As GTable, ByVal NewForeign As GTable, ByVal NewUpdate As Boolean, ByVal NewDelete As Boolean, ByVal NewTrigger As Boolean, ByVal NewHidden As Boolean, ByVal NewTipo As Integer, ByVal NewMsg As String, ByVal NewSystem As Boolean) As GRelation
   Dim oRelation As GRelation
   Set oRelation = New GRelation
   oRelation.Init vgParent, NewName, NewBase, NewForeign, NewUpdate, NewDelete, NewTrigger, NewHidden, NewTipo, NewMsg, NewSystem
   vgRelations.Add oRelation, NewName
   Set Add = oRelation
End Function

Friend Property Get Count() As Long
   Count = vgRelations.Count
End Property

Friend Function Remove(ByVal Index As Variant) As Boolean
   On Error Resume Next
   vgRelations.Remove Index
   Remove = (Err.Number = 0)
End Function

Private Sub Class_Initialize()
   Set vgRelations = New Collection
End Sub

Private Sub Class_Terminate()
   Set vgRelations = Nothing
End Sub
