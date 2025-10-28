VERSION 1.0 CLASS
BEGIN
      MultiUse = -1                                    'True
      Persistable = 0                                  'NotPersistable
      DataBindingBehavior = 0                          'vbNone
      DataSourceBehavior  = 0                          'vbNone
      MTSTransactionMode  = 0                          'NotAnMTSObject
END
Attribute VB_Name = "GQuery"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private vgParent As GDatabase
Private vgName As String, vgTitle As String, vgQuery As String

Public Property Get Name() As String
Attribute Name.VB_UserMemId = 0
   Name = vgName
End Property

Public Property Get Title() As String
   Title = vgTitle
End Property

Public Property Get Query() As String
   Query = vgQuery
End Property

Public Property Get Parent() As GDatabase
   Set Parent = vgParent
End Property

Friend Function Init(ByVal NewParent As GDataBase, ByVal NewName As String, ByVal NewTitle As String, ByVal NewQuery As String, ByVal NewIndex As Long) As Boolean
   Set vgParent = NewParent
   vgName = NewName
   If Len(NewTitle) = 0 Then
      vgTitle = NewName
   Else
      vgTitle = NewTitle
   End If
   vgQuery = NewQuery
   Init = True
End Function
