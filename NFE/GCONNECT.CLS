VERSION 1.0 CLASS
BEGIN
      MultiUse = -1                                    'True
      Persistable = 0                                  'NotPersistable
      DataBindingBehavior = 0                          'vbNone
      DataSourceBehavior  = 0                          'vbNone
      MTSTransactionMode  = 0                          'NotAnMTSObject
END
Attribute VB_Name = "GConnection"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
DefInt A-Z

Enum IdleTypes
   TPDB_FreeLocks = 1
End Enum

Private vgDataBases As Collection

Public Property Get Item(ByVal Index As Variant) As GDataBase
Attribute Item.VB_UserMemId = 0
   On Error Resume Next
   Set Item = vgDataBases.Item(Index)
End Property

Public Property Get NewEnum() As IUnknown
Attribute NewEnum.VB_UserMemId = -4
Attribute NewEnum.VB_MemberFlags = "40"
   vgDataBases.[_NewEnum]
   Set NewEnum = vgDataBases.[_NewEnum]
End Property

Friend Function RegisterDatabase(ByVal Name As String) As GDataBase
   Dim oDataBase As GDataBase
   Set oDataBase = New GDataBase
   oDataBase.Init Name
   vgDataBases.Add oDataBase, Name
   Set RegisterDatabase = oDataBase
End Function

Friend Property Get Count() As Long
   Count = vgDataBases.Count
End Property

Friend Sub Clear()
   Dim i As Integer
   On Error Resume Next
   For i = vgDataBases.Count To 1 Step -1
      vgDataBases(i).CloseConnection
      vgDataBases.Remove i
   Next
End Sub

Friend Function Remove(ByVal Index As Variant) As Boolean
   On Error Resume Next
   vgDataBases(Index).CloseConnection
   vgDataBases.Remove Index
   Remove = (Err.Number = 0)
End Function

Private Sub Class_Initialize()
   Set vgDataBases = New Collection
End Sub

Private Sub Class_Terminate()
   Set vgDataBases = Nothing
End Sub

Public Sub BeginTrans()
   Dim i As Integer
   On Error Resume Next
   For i = 1 To vgDataBases.Count
      vgDataBases(i).BeginTrans
   Next
End Sub

Public Sub CommitTrans()
   Dim i As Integer
   On Error Resume Next
   For i = 1 To vgDataBases.Count
      vgDataBases(i).CommitTrans
   Next
End Sub

Public Sub RollBackTrans()
   Dim i As Integer
   On Error Resume Next
   For i = 1 To vgDataBases.Count
      vgDataBases(i).RollBackTrans
   Next
End Sub

Public Function OpenRecordSet(ByVal vgSQL As String, Optional ByVal CursorType As EnumCursorType = -1, Optional ByVal Options As Long = -1, Optional ByVal LockType As Long = -1, Optional ByVal UpdateCriteria As Long = -1, Optional ByVal vgBanco As Variant = 1, Optional ByVal SelectColumns As String, Optional ByVal TopN As Long = -1, Optional ByVal Where As String, Optional ByVal OrderBy As String, Optional ByVal Native As Boolean = False) As GRecordSet
   Set OpenRecordSet = vgDataBases(Val(vgBanco)).OpenRecordSet(vgSQL, CursorType, Options, LockType, UpdateCriteria, SelectColumns, TopN, Where, OrderBy, Native)
End Function

Public Function Execute(ByVal vgSQL As String, Optional ByVal vgBanco As Variant = 1) As Object
   Set Execute = vgDataBases(Val(vgBanco)).Execute(vgSQL)
End Function

Public Property Get Tables() As GTables
   Set Tables = vgDataBases(1).Tables
End Property

Public Property Get Relations() As GRelations
   Set Relations = vgDataBases(1).Relations
End Property

