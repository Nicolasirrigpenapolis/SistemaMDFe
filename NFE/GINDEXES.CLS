VERSION 1.0 CLASS
BEGIN
      MultiUse = -1                                          'True
      Persistable = 0                                        'NotPersistable
      DataBindingBehavior = 0                                'vbNone
      DataSourceBehavior  = 0                                'vbNone
      MTSTransactionMode  = 0                                'NotAnMTSObject
END
Attribute VB_Name = "GIndexes"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private vgParent As Object
Private vgIndexes As Collection

Public Property Get Item(ByVal Index As Variant) As GIndex
Attribute Item.VB_UserMemId = 0
   On Error Resume Next
   Set Item = vgIndexes.Item(Index)
End Property

Public Property Get NewEnum() As IUnknown
Attribute NewEnum.VB_UserMemId = -4
Attribute NewEnum.VB_MemberFlags = "40"
   vgIndexes.[_NewEnum]
   Set NewEnum = vgIndexes.[_NewEnum]
End Property

Public Property Set Parent(ByRef NewParent As Object)
   Set vgParent = NewParent
End Property

Friend Function Add(ByVal NewName As String, ByVal NewTitle As String, ByVal IndexType As INDEX_TYPE, ByVal NewHidden As Boolean, ByVal NewSystem As Boolean, ByVal NewCluster As Integer, ByVal NewFillFactor As Integer) As GIndex
   Dim oIndex As GIndex
   Set oIndex = New GIndex
   oIndex.Init vgParent, NewName, NewTitle, IndexType, NewHidden, NewSystem, NewCluster, NewFillFactor, (vgIndexes.Count + 1)
   vgIndexes.Add oIndex, NewName
   Set Add = oIndex
End Function

Friend Property Get count() As Long
   count = vgIndexes.count
End Property

Friend Function Remove(ByVal Index As Variant) As Boolean
   On Error Resume Next
   vgIndexes.Remove Index
   Remove = (Err.Number = 0)
End Function

Private Sub Class_Initialize()
   Set vgIndexes = New Collection
End Sub

Private Sub Class_Terminate()
   Set vgIndexes = Nothing
End Sub

Public Function toString() As String
   Dim vgIndex As GIndex
   Dim vgRetVal As String
   
   For Each vgIndex In vgIndexes
      vgRetVal$ = vgRetVal$ & vgIndex.Name
      vgRetVal$ = vgRetVal$ & vgIndex.IndexType
   Next
   toString = vgRetVal$
End Function
