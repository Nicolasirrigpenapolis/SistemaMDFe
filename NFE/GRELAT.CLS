VERSION 1.0 CLASS
BEGIN
      MultiUse = -1                                          'True
      Persistable = 0                                        'NotPersistable
      DataBindingBehavior = 0                                'vbNone
      DataSourceBehavior  = 0                                'vbNone
      MTSTransactionMode  = 0                                'NotAnMTSObject
END
Attribute VB_Name = "GRelation"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Enum RELATION_TYPE
   TYPE_INSERT = 1
   TYPE_UPDATE = 2
   TYPE_DELETE = 3
End Enum

Private vgParent As GDataBase
Private vgBaseTable As GTable
Private vgForeignTable As GTable
Private vgRelationColumns As GRelationColumns
Private vgName As String, vgUpdate As Boolean, vgDelete As Boolean, vgTrigger As Boolean, vgHidden As Boolean, vgTipo As Integer, vgMsg As String, vgSystem As Boolean

Public Property Get Name() As String
Attribute Name.VB_UserMemId = 0
   Name = vgName
End Property

Public Property Get BaseTable() As GTable
   Set BaseTable = vgBaseTable
End Property

Public Property Get ForeignTable() As GTable
   Set ForeignTable = vgForeignTable
End Property

Public Property Get RelationColumns() As GRelationColumns
   Set RelationColumns = vgRelationColumns
End Property

Public Property Get Update() As Boolean
   Update = vgUpdate
End Property

Public Property Get Delete() As Boolean
   Delete = vgDelete
End Property

Public Property Get Trigger() As Boolean
   Trigger = vgTrigger
End Property

Public Property Get Hidden() As Boolean
   Hidden = vgHidden
End Property

Public Property Get Tipo() As Integer 
   Tipo = vgTipo
End Property

Public Property Get Msg() As String
   Msg = vgMsg
End Property

Public Property Get System() As Boolean
   System = vgSystem
End Property

Private Sub Class_Initialize()
   Set vgRelationColumns = New GRelationColumns
   Set vgRelationColumns.Parent = Me
End Sub

Private Sub Class_Terminate()
   Set vgRelationColumns = Nothing
End Sub

Friend Function Init(ByRef NewParent As GDataBase, ByVal NewName As String, ByVal NewBase As GTable, ByVal NewForeign As GTable, ByVal NewUpdate As Boolean, ByVal NewDelete As Boolean, ByVal NewTrigger As Boolean, ByVal NewHidden As Boolean, ByVal NewTipo As Integer, ByVal NewMsg As String, ByVal NewSystem As Boolean) As Boolean
   Set vgParent = NewParent
   vgName = NewName
   Set vgBaseTable = NewBase
   Set vgForeignTable = NewForeign
   vgUpdate = NewUpdate
   vgDelete = NewDelete
   vgTrigger = NewTrigger
   vgHidden = NewHidden
   vgTipo = NewTipo
   vgMsg = NewMsg
   vgSystem = NewSystem
   Init = True
End Function
