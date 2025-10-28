VERSION 1.0 CLASS
BEGIN
      MultiUse = -1                               'True
      Persistable = 0                             'NotPersistable
      DataBindingBehavior = 0                     'vbNone
      DataSourceBehavior  = 0                     'vbNone
      MTSTransactionMode  = 0                     'NotAnMTSObject
END
Attribute VB_Name = "GTables"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private vgParent As Object
Private vgTables As Collection

Public Property Get Item(ByVal Index As Variant) As GTable
Attribute Item.VB_UserMemId = 0
   On Error Resume Next
   Set Item = vgTables.Item(Index)
End Property

Public Property Get NewEnum() As IUnknown
Attribute NewEnum.VB_UserMemId = -4
Attribute NewEnum.VB_MemberFlags = "40"
   vgTables.[_NewEnum]
   Set NewEnum = vgTables.[_NewEnum]
End Property

Public Property Set Parent(ByRef NewParent As Object)
   Set vgParent = NewParent
End Property

Friend Function Add(ByVal NewName As String, ByVal NewTitle As String, ByVal NewHidden As Boolean, ByVal System As Boolean) As GTable
   Dim oTable As GTable
   Set oTable = New GTable
   oTable.Init vgParent, NewName, NewTitle, NewHidden, System, vgTables.Count + 1
   vgTables.Add oTable, NewName
   Set Add = oTable
End Function

Friend Property Get count() As Long
   count = vgTables.count
End Property

Friend Function Remove(ByVal Index As Variant) As Boolean
   On Error Resume Next
   vgTables.Remove Index
   Remove = (Err.Number = 0)
End Function

Private Sub Class_Initialize()
   Set vgTables = New Collection
End Sub

Private Sub Class_Terminate()
   Set vgTables = Nothing
End Sub

'retorna como única string todos os nomes das tabelas do banco
Public Function toString() As String
   Dim vgTable As GTable
   Dim vgRetVal As String
   
   'percorre todas as tabelas da estrutura do banco
   For Each vgTable In vgTables
      vgRetVal$ = vgRetVal$ & vgTable.Name
   Next
   toString = vgRetVal$
End Function
