VERSION 1.0 CLASS
BEGIN
      MultiUse = -1                                          'True
      Persistable = 0                                        'NotPersistable
      DataBindingBehavior = 0                                'vbNone
      DataSourceBehavior  = 0                                'vbNone
      MTSTransactionMode  = 0                                'NotAnMTSObject
END
Attribute VB_Name = "GRelationColumn"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private vgParent As Object
Private vgBaseColumn As GColumn
Private vgForeignColumn As GColumn
Private vgName As String, vgHidden As Boolean, vgSystem As Boolean

Public Property Get Name() As String
Attribute Name.VB_UserMemId = 0
   Name = vgName
End Property

Public Property Get BaseColumn() As GColumn
   Set BaseColumn = vgBaseColumn
End Property

Public Property Get ForeignColumn() As GColumn
   Set ForeignColumn = vgForeignColumn
End Property

Public Property Get Hidden() As Boolean
   Hidden = vgHidden
End Property

Public Property Get System() As Boolean
   System = vgSystem
End Property

Friend Function Init(ByRef NewParent As GRelation, ByVal NewBase As GColumn, ByVal NewForeign As GColumn, ByVal NewHidden As Boolean, ByVal NewSystem As Boolean) As Boolean
   Set vgParent = NewParent
   Set vgBaseColumn = NewBase
   Set vgForeignColumn = NewForeign
   vgHidden = NewHidden
   vgSystem = NewSystem
   Init = True
End Function

Private Sub Class_Initialize()
   Set vgBaseColumn = New GColumn
   Set vgForeignColumn = New GColumn
End Sub

Private Sub Class_Terminate()
   Set vgBaseColumn = Nothing
   Set vgForeignColumn = Nothing
End Sub
