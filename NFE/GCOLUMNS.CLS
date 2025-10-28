VERSION 1.0 CLASS
BEGIN
      MultiUse = -1                                      'True
      Persistable = 0                                    'NotPersistable
      DataBindingBehavior = 0                            'vbNone
      DataSourceBehavior  = 0                            'vbNone
      MTSTransactionMode  = 0                            'NotAnMTSObject
END
Attribute VB_Name = "GColumns"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private vgParent As Object
Private vgColumns As Collection

Public Property Get Item(ByVal Index As Variant) As GColumn
Attribute Item.VB_UserMemId = 0
   On Error Resume Next
   Set Item = vgColumns.Item(Index)
End Property

Public Property Get NewEnum() As IUnknown
Attribute NewEnum.VB_UserMemId = -4
Attribute NewEnum.VB_MemberFlags = "40"
   On Error Resume Next
   vgColumns.[_NewEnum]
   Set NewEnum = vgColumns.[_NewEnum]
End Property

Public Property Set Parent(ByRef NewParent As Object)
   Set vgParent = NewParent
End Property

Public Sub ChangeItemName(ByVal Index As Variant, ByVal NewName As String)
   Dim vgNewColumns As Collection, vgCol As GColumn
   Set vgNewColumns = New Collection
   For Each vgCol In vgColumns
      If vgCol = Item(Index) Then
         vgNewColumns.Add vgCol, NewName
      Else
         vgNewColumns.Add vgCol, vgCol.Name
      End If
   Next
   Set vgColumns = vgNewColumns
   Set vgNewColumns = Nothing
   vgColumns.Item(Index) = NewName                'altera nome também em GCOLUMN
End Sub

Friend Function Append(ByVal NewColumn As GColumn)
   vgColumns.Add NewColumn, NewColumn.Name
   Set Append = NewColumn
End Function

Friend Function Add(ByVal NewName As String, ByVal NewTitle As String, ByVal NewType As Variant, ByVal NewMask As String, ByVal NewSize As Double, ByVal NewDecimal As Integer, ByVal NewHidden As Boolean, ByVal NewNullable As Boolean, ByVal NewSystem As Boolean, ByVal NewSeqInterno As Boolean, ByVal NewSequencia As Long, ByVal NewDescending As Boolean, ByVal NewDefault As String, ByVal NewUpdatableColumn As Boolean, Optional ByVal NewBaseColumnName As String) As GColumn
   Dim oColumn As GColumn
   Set oColumn = New GColumn
   oColumn.Init vgParent, NewName, NewTitle, NewType, NewMask, NewSize, NewDecimal, NewHidden, NewNullable, NewSystem, NewSeqInterno, NewSequencia, NewDescending, NewDefault, vgColumns.Count + 1, NewUpdatableColumn, NewBaseColumnName
   vgColumns.Add oColumn, NewName
   Set Add = oColumn
End Function

Public Property Get Count() As Long
   Count = vgColumns.Count
End Property

Public Function Remove(ByVal Index As Variant) As Boolean
   On Error Resume Next
   vgColumns.Remove Index
   Remove = (Err.Number = 0)
End Function

Private Sub Class_Initialize()
   Set vgColumns = New Collection
End Sub

Private Sub Class_Terminate()
   Set vgColumns = Nothing
End Sub

'retorna como string todas as informações das colunas que são úteis para o processo de adaptação
Public Function toString() As String
   Dim vgColumn As GColumn
   Dim vgRetVal As String
   
   'percorre todas as colunas da tabela e concatela os dados da estrutura
   For Each vgColumn In vgColumns
      vgRetVal$ = vgRetVal$ & vgColumn.Name 
      vgRetVal$ = vgRetVal$ & vgColumn.ColumnType
      vgRetVal$ = vgRetVal$ & vgColumn.Size
      vgRetVal$ = vgRetVal$ & vgColumn.QDecimal
      vgRetVal$ = vgRetVal$ & vgColumn.Nullable
      vgRetVal$ = vgRetVal$ & vgColumn.Default
   Next
   toString = vgRetVal$
End Function
