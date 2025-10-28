VERSION 1.0 CLASS
BEGIN
      MultiUse = -1                                          'True
      Persistable = 0                                        'NotPersistable
      DataBindingBehavior = 0                                'vbNone
      DataSourceBehavior  = 0                                'vbNone
      MTSTransactionMode  = 0                                'NotAnMTSObject
END
Attribute VB_Name = "GIndex"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Enum INDEX_TYPE
   TYPE_Normal = 0
   TYPE_Primary = 1
   TYPE_Unique = 2
End Enum

Private vgParent As GTable
Private vgColumns As GColumns
Private vgName As String, vgTitle As String, vgHidden As Boolean, vgSystem As Boolean, vgIndexType As INDEX_TYPE, vgIndex As Integer
Private vgCluster As Integer, vgFillFactor As Integer

Public Property Get Name() As String
Attribute Name.VB_UserMemId = 0
   Name = vgName
End Property

Public Property Get Title() As String
   Title = vgTitle
End Property

Public Property Get Index() As Integer
   Index = vgIndex
End Property

Public Property Get IndexType() As INDEX_TYPE
   IndexType = vgIndexType
End Property

Public Property Get Columns() As GColumns
   Set Columns = vgColumns
End Property

Public Property Get Hidden() As Boolean
   Hidden = vgHidden
   If InStr(vgName, "~") Then Hidden = True
End Property

Public Property Get System() As Boolean
   System = vgSystem
End Property

Private Sub Class_Initialize()
   Set vgColumns = New GColumns
   Set vgColumns.Parent = Me
End Sub

Private Sub Class_Terminate()
   Set vgColumns = Nothing
End Sub

Public Property Get Cluster() As Integer
   Cluster = vgCluster
End Property

Public Property Get FillFactor() As Integer
   FillFactor = vgFillFactor
End Property

Friend Function Init(ByRef NewParent As GTable, ByVal NewName As String, ByVal NewTitle As String, ByVal NewIndexType As INDEX_TYPE, ByVal NewHidden As Boolean, ByVal NewSystem As Boolean, ByVal NewCluster As Integer, ByVal NewFillFactor As Integer, ByVal NewIndex As Integer) As Boolean
   Set vgParent = NewParent
   vgName = NewName
   If Len(NewTitle) = 0 Then
      vgTitle = NewName
   Else
      vgTitle = NewTitle
   End If
   vgIndexType = NewIndexType
   vgHidden = NewHidden
   vgSystem = NewSystem
   vgCluster = NewCluster
   vgFillFactor = NewFillFactor
   vgIndex = NewIndex
   Init = True
End Function
