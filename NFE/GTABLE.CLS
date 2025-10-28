VERSION 1.0 CLASS
BEGIN
      MultiUse = -1                                   'True
      Persistable = 0                                 'NotPersistable
      DataBindingBehavior = 0                         'vbNone
      DataSourceBehavior  = 0                         'vbNone
      MTSTransactionMode  = 0                         'NotAnMTSObject
END
Attribute VB_Name = "GTable"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private vgParent As GDataBase
Private vgColumns As GColumns
Private vgIndexes As GIndexes
Private vgName As String, vgIndex As Long, vgTitle As String, vgHidden As Boolean, vgSystem As Boolean

Private Sub Class_Initialize()
   Set vgColumns = New GColumns
   Set vgIndexes = New GIndexes
   Set vgColumns.Parent = Me
   Set vgIndexes.Parent = Me
End Sub

Public Property Get Name() As String
Attribute Name.VB_UserMemId = 0
   Name = vgName
End Property

Public Property Get Index() As String
   Index = vgIndex
End Property

Public Property Get Title() As String
   Title = vgTitle
End Property

Public Property Get Hidden() As Boolean
   Hidden = vgHidden
   If InStr(vgName, "~") Then Hidden = True
End Property

Public Property Get System() As Boolean
   System = vgSystem
End Property

Public Property Get Columns() As GColumns
   Set Columns = vgColumns
End Property

Public Property Get Indexes() As GIndexes
   Set Indexes = vgIndexes
End Property


Public Property Get Parent() As GDataBase
   Set Parent = vgParent
End Property

Friend Function Init(ByVal NewParent As GDataBase, ByVal NewName As String, ByVal NewTitle As String, ByVal NewHidden As Boolean, ByVal NewSystem As Boolean, ByVal NewIndex As Long) As Boolean
   Set vgParent = NewParent
   vgName = NewName
   If Len(NewTitle) = 0 Then
      vgTitle = NewName
   Else
      vgTitle = NewTitle
   End If
   vgHidden = NewHidden
   vgSystem = NewSystem
   vgIndex = NewIndex
   Init = True
End Function

Private Sub Class_Terminate()
   Set vgColumns = Nothing
   Set vgIndexes = Nothing
End Sub

'Metodo para criar o script de uma tabela do BD.
'Parametro para receber opcionalmente o nome da tabela.
Public Function ScriptTable(Optional vgNewname As String, Optional vgRen As Boolean) As String

   Dim vgCp As GColumn, vgInd As GIndex
   Dim Scpt As String, NomecomCRC As String

   On Error GoTo DeuErro
   If vgNewname = "" Then vgNewname = vgName
   
   Select Case Parent.DataBaseType
      Case DB_SQL                                 ' Script para tabela do SQL Server
         Scpt = "CREATE TABLE " + PoeColAspas(vgNewname, Parent.DataBaseType) + " (" + vbCrLf
         For Each vgCp In vgColumns
            Scpt = Scpt + Space(7) + RPad(PoeColAspas(vgCp.Name, Parent.DataBaseType), 35, " ")
            Scpt = Scpt + Parent.GetFieldDefDb(vgCp) + "," + vbCrLf
         Next
         Scpt = Scpt + ")" + vbCrLf + "GO" + vbCrLf + vbCrLf
         For Each vgInd In vgIndexes
            If vgInd.IndexType = TYPE_Primary Then
               If UCase(Left$(vgNewname, 3)) = "TMP" Then
                  Scpt = Scpt + "If exists (select * from sysobjects where id = object_id('" & PoeColAspas(vgInd.Name, Parent.DataBaseType) & "'))" + vbCrLf
                  Scpt = Scpt + "ALTER TABLE " + PoeColAspas(vgName, Parent.DataBaseType) + vbCrLf
                  Scpt = Scpt + " DROP CONSTRAINT " + PoeColAspas(vgInd.Name, Parent.DataBaseType) + vbCrLf
                  Scpt = Scpt + "GO" + vbCrLf + vbCrLf
               End If
               Scpt = Scpt + "ALTER TABLE " + PoeColAspas(vgNewname, Parent.DataBaseType) + " ADD CONSTRAINT " + PoeColAspas(vgInd.Name, Parent.DataBaseType) + " PRIMARY KEY " + IIf(vgInd.Cluster = "1", " CLUSTERED ", "") + vbCrLf
               Scpt = Scpt + "(" + vbCrLf
               For Each vgCp In vgInd.Columns
                  If vgCp.Index > 1 Then Scpt = Scpt + ", "
                  Scpt = Scpt + PoeColAspas(vgCp.Name, Parent.DataBaseType) ' + vbCrLf
               Next
               Scpt = Scpt + vbCrLf + ") " + IIf(vgInd.FillFactor > 0, " WITH FILLFACTOR = " + CStr(vgInd.FillFactor), "")
            Else
               Scpt = Scpt + "CREATE " + IIf(vgInd.IndexType = TYPE_Unique, "UNIQUE ", "") + "INDEX " + PoeColAspas(vgInd.Name, Parent.DataBaseType) + " ON " + PoeColAspas(vgNewname, Parent.DataBaseType) + vbCrLf
               For Each vgCp In vgInd.Columns
                  If vgCp.Index = 1 Then
                     Scpt = Scpt + "("
                  Else
                     Scpt = Scpt + ", "
                  End If
                  Scpt = Scpt + PoeColAspas(vgCp.Name, Parent.DataBaseType)
               Next
               Scpt = Scpt + ") "
               Scpt = Scpt + IIf(vgInd.FillFactor > 0, " WITH FILLFACTOR = " + CStr(vgInd.FillFactor), "")
            End If
            Scpt = Scpt + vbCrLf + "GO" + vbCrLf + vbCrLf
         Next
         ScriptTable = Scpt
      End Select
      Exit Function

DeuErro:
   
End Function

