VERSION 1.0 CLASS
BEGIN
      MultiUse = -1                                         'True
      Persistable = 0                                       'NotPersistable
      DataBindingBehavior = 0                               'vbNone
      DataSourceBehavior  = 0                               'vbNone
      MTSTransactionMode  = 0                               'NotAnMTSObject
END
Attribute VB_Name = "GRecordSet"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
DefInt A-Z

Enum EnumCursorType
   CURSOR_TABLE = 1
   CURSOR_DYNAMIC = 2
   CURSOR_FORWARD = 3
   CURSOR_ASYNC = 4                                         'na verdade isso não é tipo de cursor, apenas para facilitar desenvolvimento, esse tipo será sempre DYNAMIC no momento da abertura
End Enum

Private vgTable As GTable                                 'tabela correspondente a tabela base do recordset

Public WithEvents BdTrans As GBdTrans

Dim vgDataBase As GDataBase, vgCursorType As EnumCursorType, vgLockType As Long, vgOptions As Long, _
            vgUpdateCriteria As Long, vgRecordSet As Object, vgEOF As Long, vgIndex As String, _
            vgNoMatch As Boolean, vgSort As String, vgPriVez As Boolean, _
            vgSelectRecords As Boolean, vgSelectColumns As String, vgWhere As String, vgExternalWhere As String, vgOrderBy As String, vgExternalOrderBy As String, _
            vgTop As Long, vgExternalTop As Long, vgSource As String, vgStatus As Integer, vgRelations() As String

Dim vgSeekType As Integer, vgUltOperSeek() As String, vgExpSeek() As String, vgQtCpsUltSeek() As Integer, vgIsPendingUpdate As Boolean, vgExpFilterPending As String
Dim vgExpInsert As String, vgExpUpdate As String, vgExpDelete As String, vgExtraFields As String, vgExpFilter As String, vgIndexKey As String, vgExpFilterReady As String, vgExpPureFilterReady As String
Dim vgExpSeekFilter As String                     'expressão de filtro a ser aplicada na propriedade filter do vgRecordSet
Dim vgPrepExpSeekFilter As String                 'expressão temporária para montagem do filtro da seekrecord a ser aplicado na propriedade filter do vgRecordSet
Dim vgTransactionBookmark As Variant, vgTransactionPosiction As Variant
Dim vgForm As Object
Dim vgRecCount As Long, vgAsyncComplete As Boolean
Dim vgOpenSource As String
Dim WithEvents RsAsyncFetch As ADODB.Recordset
Attribute RsAsyncFetch.VB_VarHelpID = -1

Event FetchProgress(ByVal RecordCount As Long)
Event FetchComplete(ByVal RecordCount As Long)
Event BeforeBeginTrans()
Event BeforeCommitTrans()
Event BeforeRollBackTrans()
Event AfterBeginTrans()
Event AfterCommitTrans()
Event AfterRollBackTrans()
Event Opened()

'retorna o valor do campo formatado conforme máscara do banco de campos
'Index - o nome ou o índice da coluna do recordset atual.
'vgFormatter - vamos receber uma instância da FormataCampos
Public Property Get FormattedFieldValue(ByVal Index As Variant, ByRef vgFormatter As Object) As Variant
   Dim vgPV As Boolean
   If CStr(Val(Index)) <> CStr(Index) Then
      Index = Database.GetFieldNameShort(Index)        'vamos corrigir o nome
   End If
   vgPV = True
   If (vgStatus <> ACAO_NAVEGANDO Or vgIsPendingUpdate) And Len(vgExpUpdate$) > 0 Then
      FormattedFieldValue = vgFormatter.FormatField(vgTable.Columns(Index).Value, BancoDeCampos(vgTable.Columns(Index).Name).Mask, BancoDeCampos(vgTable.Columns(Index).Name).ColumnType, "")
   ElseIf IsNull(vgRecordSet.Fields(vgTable.Columns(Index).Name).Value) Then
      Select Case vgTable.Columns(Index).ColumnType
         Case TP_DATA_HORA
            FormattedFieldValue = vgFormatter.FormatField(Null, BancoDeCampos(vgTable.Columns(Index).Name).Mask, BancoDeCampos(vgTable.Columns(Index).Name).ColumnType, "")
         Case TP_CARACTER, TP_MEMO
            FormattedFieldValue = vgFormatter.FormatField("", BancoDeCampos(vgTable.Columns(Index).Name).Mask, BancoDeCampos(vgTable.Columns(Index).Name).ColumnType, "")
         Case TP_NUMERICO
            FormattedFieldValue = vgFormatter.FormatField(0, BancoDeCampos(vgTable.Columns(Index).Name).Mask, BancoDeCampos(vgTable.Columns(Index).Name).ColumnType, "")
         Case Else
            FormattedFieldValue = vgFormatter.FormatField(vgRecordSet.Fields(vgTable.Columns(Index).Name).Value, BancoDeCampos(vgTable.Columns(Index).Name).Mask, BancoDeCampos(vgTable.Columns(Index).Name).ColumnType, "")
      End Select
   Else
      FormattedFieldValue = vgFormatter.FormatField(vgRecordSet.Fields(vgTable.Columns(Index).Name).Value, BancoDeCampos(vgTable.Columns(Index).Name).Mask, BancoDeCampos(vgTable.Columns(Index).Name).ColumnType, "")
   End If
End Property

Public Property Get FieldValue(ByVal Index As Variant) As Variant
Attribute FieldValue.VB_UserMemId = 0
   Dim vgPV As Boolean
   If CStr(val(Index)) <> CStr(Index) Then
      Index = DataBase.GetFieldNameShort(Index)       'vamos corrigir o nome
   End If
   vgPV = True
   If (vgStatus <> ACAO_NAVEGANDO Or vgIsPendingUpdate) And Len(vgExpUpdate$) > 0 Then
      FieldValue = vgTable.Columns(Index).Value
   ElseIf IsNull(vgRecordSet.Fields(vgTable.Columns(Index).Name).Value) Then
      Select Case vgTable.Columns(Index).ColumnType
         Case TP_DATA_HORA
            FieldValue = Null
         Case TP_CARACTER, TP_MEMO
            FieldValue = ""
         Case TP_NUMERICO
            FieldValue = 0
         Case Else
            FieldValue = vgRecordSet.Fields(vgTable.Columns(Index).Name).Value
      End Select
   Else
      FieldValue = vgRecordSet.Fields(vgTable.Columns(Index).Name).Value
   End If
End Property

Public Property Let FieldValue(ByVal Index As Variant, ByVal NewValue As Variant)
   If CStr(val(Index)) <> CStr(Index) Then
      Index = DataBase.GetFieldNameShort(Index)       'vamos corrigir o nome
   End If
   If vgTable.Columns(Index).Nullable And IsNull(NewValue) = False Then
      Select Case vgTable.Columns(Index).ColumnType
         Case TP_CARACTER, TP_MEMO, TP_DATA_HORA
            If NewValue = "" Then NewValue = Null
      End Select
   End If
   If vgStatus <> ACAO_NAVEGANDO And Len(vgExpUpdate$) > 0 Then
      If CStr(Val(Index)) = CStr(Index) Then
         vgTable.Columns(Index - 1).Value = NewValue
      Else
         vgTable.Columns(Index).Value = NewValue
      End If
   Else
      vgRecordSet.Fields(vgTable.Columns(Index).Name).Value = NewValue
   End If
End Property

Public Property Get Field(Index As Variant) As Object
   Dim vgPV As Boolean
   On Error GoTo DeuErro
   If CStr(val(Index)) <> CStr(Index) Then
      Index = DataBase.GetFieldNameShort(Index)       'vamos corrigir o nome
   End If
   vgPV = True
   If (vgStatus <> ACAO_NAVEGANDO Or vgIsPendingUpdate) And Len(vgExpUpdate$) > 0 Then
      Set Field = vgTable.Columns(Index)
   Else
      Set Field = vgRecordSet.Fields(vgTable.Columns(Index).Name)
   End If
   Exit Property

DeuErro:
   If Err.Number = 91 And vgPV Then
      vgPV = False
      OpenRecordSet
   Else
      On Error GoTo 0
   End If
   Resume
End Property

Public Property Get Fields() As Object
   Dim vgPV As Boolean
   On Error GoTo DeuErro
   vgPV = True
   If (vgStatus <> ACAO_NAVEGANDO Or vgIsPendingUpdate) And Len(vgExpUpdate$) > 0 Then
      Set Fields = vgTable.Columns
   Else
      Set Fields = vgRecordSet.Fields
   End If
   Exit Sub

DeuErro:
   If Err.Number = 91 And vgPV Then
      vgPV = False
      OpenRecordSet
   Else
      On Error GoTo 0
   End If
   Resume
End Property

Public Property Set DataBase(New_DataBase As GDataBase)
   Set vgDataBase = New_DataBase
   Set BdTrans = vgDataBase.BdTrans
End Property

Public Property Get DataBase() As GDataBase
   Set DataBase = vgDataBase
End Property

Public Property Let CursorType(New_CursorType As EnumCursorType)
   vgCursorType = New_CursorType
End Property

Public Property Get CursorType() As EnumCursorType
   CursorType = vgCursorType
End Property

Public Property Let AsyncComplete(New_AsyncComplete As Boolean)
   vgAsyncComplete = New_AsyncComplete
End Property

Public Property Get AsyncComplete() As Boolean
   AsyncComplete = vgAsyncComplete
End Property

Public Property Get RealCursorType() As Long
   Dim RetVal As Long
   Select Case vgCursorType
      Case CURSOR_TABLE
         RetVal = 2                               'adOpenDynamic
      Case CURSOR_DYNAMIC
         RetVal = 2                               'adOpenDynamic
      Case CURSOR_FORWARD
         RetVal = 0                               'adOpenForwardOnly
      Case CURSOR_ASYNC
         RetVal = 2                               'adOpenDynamic
   End Select
   
   RealCursorType = RetVal
End Property

Public Property Let LockType(New_LockType As Long)
   vgLockType = New_LockType
End Property

Public Property Get LockType() As Long
   LockType = vgLockType
End Property

Public Property Let Options(New_Options As Long)
   vgOptions = New_Options
End Property

Public Property Get Options() As Long
   Options = vgOptions
End Property

Public Property Let BookMark(NewBookMark As Variant)
   If Val(NewBookMark) = -99 Then                       'registro pendente...
      If vgRecordSet.RecordCount > 0 Then
         vgRecordSet.MoveLast
      End If
   ElseIf Val(NewBookMark) = -2 Then                    'EOF
      If vgRecordSet.RecordCount > 0 Then
         vgRecordSet.MoveLast
         vgRecordSet.MoveNext
      End If
   ElseIf Val(NewBookMark) = -3 Then                    'BOF
      If vgRecordSet.RecordCount > 0 Then
         vgRecordSet.MoveFirst
         vgRecordSet.MovePrevious
      End If
   Else
      vgRecordSet.BookMark = NewBookMark
   End If
End Property

Public Property Get BookMark() As Variant
   On Error Resume Next
   If vgIsPendingUpdate Then
      BookMark = -99                              'registro pendente
   ElseIf vgRecordSet.EOF Then                    'EOF
      BookMark = -2
   ElseIf vgRecordSet.BOF Then                    'BOF
      BookMark = -3
   Else
      BookMark = vgRecordSet.BookMark
   End If
End Property

Public Property Get LastModified() As Variant
   Dim vgPV As Boolean
   On Error GoTo DeuErro
   vgPV = True
   LastModified = vgRecordSet.LastModified
   Exit Sub

DeuErro:
   If Err.Number = 91 And vgPV Then
      vgPV = False
      OpenRecordSet
      Resume
   End If
   Resume ResumeErro
   
ResumeErro:
   On Error Resume Next
   LastModified = BookMark
   Err.Clear
End Property

Public Property Get AbsolutePosition() As Long
   Dim vgPV As Boolean
   On Error GoTo DeuErro
   vgPV = True
   AbsolutePosition = vgRecordSet.AbsolutePosition
   Exit Sub

DeuErro:
   If Err.Number = 91 And vgPV Then
      vgPV = False
      OpenRecordSet
      Resume
   End If
End Property

Public Property Get EditableField(FieldName As Variant) As Boolean
   Dim x As String
   On Error Resume Next
   x$ = vgDataBase.Tables(vgTable.Name).Columns(vgTable.Columns(FieldName).Name).Name
   If Err = 0 Then
      EditableField = Editable
   Else
      EditableField = False
   End If
   On Error GoTo 0
End Property

Public Property Get Editable() As Boolean
   Editable = ((vgRecordSet.Properties("Updatability") And 1) = 1)
   If Not Editable Then
      Editable = (Len(vgExpUpdate$) > 0)
   End If
End Property

Public Property Get Insertable() As Boolean
   Insertable = ((vgRecordSet.Properties("Updatability") And 4) = 4)
   If Not Insertable Then
      Insertable = (Len(vgExpInsert$) > 0)
   End If
End Property

Public Property Get Deletable() As Boolean
   Deletable = ((vgRecordSet.Properties("Updatability") And 4) = 4)
   If Not Deletable Then
      Deletable = (Len(vgExpDelete$) > 0)
   End If
End Property

Public Property Let UpdateCriteria(New_UpdateCriteria As Long)
   vgUpdateCriteria = New_UpdateCriteria
End Property

Public Property Get UpdateCriteria() As Long
   UpdateCriteria = vgUpdateCriteria
End Property

Public Property Set RecordSet(New_RecordSet As Object)
   Set vgRecordSet = Nothing
   Set vgRecordSet = New_RecordSet
   Set BdTrans = vgDataBase.BdTrans
   Source = vgSource
End Property

Public Property Get RecordSet() As Object
   Set RecordSet = vgRecordSet
End Property

Public Property Get EOF() As Boolean
   EOF = vgRecordSet.EOF
End Property

Public Property Get BOF() As Boolean
   BOF = vgRecordSet.BOF
End Property

Public Property Get Status() As Integer
   Status = vgStatus
End Property

Public Property Get NoMatch() As Boolean
   NoMatch = vgNoMatch
End Property

Private Property Let NoMatch(NewNoMatch As Boolean)
   vgNoMatch = NewNoMatch
End Property

Public Property Get ExternalWhere() As String
   ExternalWhere = vgExternalWhere
End Property

Public Property Let ExternalWhere(NewExternalWhere As String)
   vgExternalWhere = NewExternalWhere
End Property

Public Property Get Where() As String
   Where = vgWhere
End Property

Public Property Let Where(NewWhere As String)
   vgWhere = NewWhere
End Property

Public Property Get SelectColumns() As String
   SelectColumns = vgSelectColumns
End Property

Public Property Let SelectColumns(NewSelectColumns As String)
   vgSelectColumns = NewSelectColumns
End Property

Public Property Get OrderBy() As String
   OrderBy = vgOrderBy
End Property

Public Property Let OrderBy(NewOrderBy As String)
   Dim x As String, z As String, vgNovo As String
   x = NewOrderBy
   Do While Len(x) > 0
      z$ = Parse(x$, ",")
      If UCase$(Right$(z$, 5)) = " DESC" Then
         z$ = PoeColchetes(Trim$(Left$(z$, Len(z$) - 5))) + " DESC"
      ElseIf Right(z$, 1) = "-" Then
         z$ = PoeColchetes(Left(z$, Len(z$) - 1)) + " DESC"
      Else
         z$ = PoeColchetes(Trim$(z$))
      End If
      vgNovo = vgNovo + ", " + z$
   Loop
   vgNovo$ = Mid$(vgNovo$, 3)
   vgOrderBy = vgNovo
End Property

Public Property Get ExternalOrderBy() As String
   ExternalOrderBy = vgExternalOrderBy
End Property

Public Property Let ExternalOrderBy(NewExternalOrderBy As String)
   Dim x As String, z As String, vgNovo As String
   x = NewExternalOrderBy
   Do While Len(x) > 0
      z$ = Parse(x$, ",")
      If UCase$(Right$(z$, 5)) = " DESC" Then
         z$ = PoeColchetes(Trim$(Left$(z$, Len(z$) - 5))) + " DESC"
      ElseIf Right(z$, 1) = "-" Then
         z$ = PoeColchetes(Left(z$, Len(z$) - 1)) + " DESC"
      Else
         z$ = PoeColchetes(Trim$(z$))
      End If
      vgNovo = vgNovo + ", " + z$
   Loop
   vgNovo$ = Mid$(vgNovo$, 3)
   vgExternalOrderBy = vgNovo
End Property

Public Property Get Top() As Long
   Top = vgTop
End Property

Public Property Let Top(NewTop As Long)
   vgTop = NewTop
End Property

Public Property Get ExternalTop() As Long
   ExternalTop = vgExternalTop
End Property

Public Property Let ExternalTop(NewExternalTop As Long)
   vgExternalTop = NewExternalTop
End Property

Public Property Get Source() As String
   Source = vgSource
End Property

Public Sub Reset()
   On Error Resume Next
   vgWhere = ""
   vgExternalWhere = ""
   vgOrderBy = ""
   vgExternalOrderBy = ""
   vgSort = ""
   vgIndex = ""
   vgTop = -1
   vgExternalTop = -1
   vgCursorType = -1
   vgLockType = -1
   vgOptions = -1
   vgUpdateCriteria = -1
   vgStatus = ACAO_NAVEGANDO
   vgSelectColumns = ""
   vgNoMatch = True
   vgAsyncComplete = False
   vgSelectRecords = False
   vgRecordSet.Close
   vgOpenSource$ = ""
   Set vgRecordSet = Nothing
   Set vgTable = Nothing
   ReDim vgUltOperSeek(0) As String
   ReDim vgExpSeek(0) As String
   ReDim vgQtCpsUltSeek(0) As Integer
   RsAsyncFetch.Close
   Set RsAsyncFetch = Nothing
   Set BdTrans = Nothing
   Call ClearRelations
End Sub

Public Property Get Table() As GTable
   Set Table = vgTable
End Property

Public Property Set Table(New_Table As GTable)
   Set vgTable = New_Table
End Property

Public Property Let Source(NewSource As String)
   Dim vgPV As Boolean, x As String
   On Error Resume Next
   If vgDataBase Is Nothing Then
      Call CheckDataBase
   End If
   vgPV = True
   vgSource = NewSource
   x$ = Retira(ExtraiSQL(vgSource, EXP_FROM, False), "[]", UM_A_UM)
   Set vgTable = vgDataBase.Tables(x$)
   If Err Then
      Set vgTable = Nothing
      ReDim vgUltOperSeek(0) As String
      ReDim vgExpSeek(0) As String
      ReDim vgQtCpsUltSeek(0) As Integer
   Else
      ReDim vgUltOperSeek(vgDataBase.Tables(vgTable.Name).Indexes.Count) As String
      ReDim vgExpSeek(vgDataBase.Tables(vgTable.Name).Indexes.Count) As String
      ReDim vgQtCpsUltSeek(vgDataBase.Tables(vgTable.Name).Indexes.Count) As Integer
   End If
   vgSeekType = 3
   vgNoMatch = True
End Property

Public Property Get RsSource() As String
   RsSource = vgOpenSource$
End Property

Public Property Let RsSource(ByVal New_RsSource As String)
   vgOpenSource$ = New_RsSource
End Property

Public Property Get RecordCount() As Long
   Dim vgPV As Boolean
   vgPV = True
   On Error GoTo DeuErro
   If CursorType = CURSOR_ASYNC And vgAsyncComplete = False Then
      RecordCount = vgRecCount
   Else
      RecordCount = vgRecordSet.RecordCount
   End If
   Exit Property

DeuErro:
   If Err.Number = 91 And vgPV Then
      vgPV = False
      OpenRecordSet
   Else
      On Error GoTo 0
   End If
   Resume
End Property

Public Property Get Filter() As String
   Dim vgPV As Boolean
   On Error GoTo DeuErro
   vgPV = True
   Filter = vgRecordSet.Filter
   Exit Sub

DeuErro:
   If Err.Number = 91 And vgPV Then
      vgPV = False
      OpenRecordSet
   Else
      On Error GoTo 0
   End If
   Resume
End Property

Public Property Let Filter(New_Filter As String)
   Dim vgPV As Boolean, x As String
   On Error GoTo DeuErro
   vgPV = True
   
   x$ = New_Filter
   vgRecordSet.Filter = x$
   Exit Property

DeuErro:
   If Err.Number = 91 And vgPV Then
      vgPV = False
      OpenRecordSet
   Else
      On Error GoTo 0
   End If
   Resume
End Property


Public Property Get Index() As String
   Index = vgIndex
End Property

Public Property Let Index(New_Index As String)
   Dim vgIndIndex As Integer                      'armazena o número do índice aplicado
   Dim i As Integer                               'propósito geral
   vgIndex = New_Index                            'define o índice atual da GRecordSet
   
   'vamos obter o número do índice na estrutura da tabela
   On Error Resume Next           
   vgIndIndex = vgDataBase.Tables(vgTable.Name).Indexes(vgIndex).Index
   If Err Then
      vgIndIndex = 0
      Err.Clear
   End If

   'vamos usar a propriedade Sort para ordenar o recordset conforme o índice definido para o recordset
   vgSort = ""
   If vgIndIndex > 0 Then                         'se tem um índice válido
      For i = 1 To vgDataBase.Tables(vgTable.Name).Indexes(vgIndex).Columns.Count
         If vgDataBase.Tables(vgTable.Name).Indexes(vgIndex).Columns(i).ColumnType <> TP_MEMO Then 'não vamos usar campo memo para evitar erro com a propriedade Sort do recordset.
            If Len(vgSort) > 0 Then vgSort = vgSort & ", "
            vgSort = vgSort & PoeColchetes(vgDataBase.Tables(vgTable.Name).Indexes(vgIndex).Columns(i).Name)
         End If
      Next
   End If
   vgRecordSet.Sort = vgSort                      'aplicando a ordem conforme campos do índice atual do recordset
   
   vgPriVez = False
End Property

Public Property Get Sort() As String
   Sort = vgSort
End Property

Public Property Let Sort(New_Sort As String)
   Dim vgPV As Boolean
   On Error GoTo DeuErro
   vgPV = True
   vgSort = New_Sort
   If Not vgRecordSet Is Nothing And vgCursorType <> CURSOR_TABLE Then
      vgRecordSet.Sort = New_Sort
   End If
   vgPriVez = False
   Exit Property

DeuErro:
   If Err.Number = 91 And vgPV Then
      vgPV = False
      OpenRecordSet
   Else
      On Error GoTo 0
   End If
   Resume
End Property

Public Sub ChangeIndex(New_Index As String)
   Index = New_Index
End Sub

Public Sub AddNew()
   Dim vgPV As Boolean, vgCol As GColumn
   On Error GoTo DeuErro
   If vgDataBase.vgInTransaction Then
      vgTransactionBookmark = BookMark
      vgTransactionPosiction = AbsolutePosition
   End If
   vgPV = True
   If Len(vgExpUpdate$) > 0 And Len(vgExpFilter$) > 0 Then
      For Each vgCol In vgTable.Columns
         vgCol.Value = Null
         vgCol.HasChange = False
      Next
      vgExpFilterReady$ = ""
      vgExpPureFilterReady$ = ""
   Else
      vgRecordSet.AddNew
   End If
   vgStatus = ACAO_INCLUINDO
   Exit Sub

DeuErro:
   If Err.Number = 91 And vgPV Then
      vgPV = False
      OpenRecordSet
      If vgDataBase.vgInTransaction Then
         vgTransactionBookmark = BookMark
         vgTransactionPosiction = AbsolutePosition
      End If
   Else
      On Error GoTo 0
   End If
   Resume

End Sub

'Monta expressão de filtro conforme registro atual
Private Sub DefineFilter(Optional ByVal vgToInsert As Boolean)
   Dim vgCol As GColumn, x As String, z As String, vgVal As Variant
   vgExpFilterReady$ = vgExpFilter$
   vgExpPureFilterReady$ = vgExpFilter$
   If Len(vgIndexKey$) > 0 Then
      For Each vgCol In vgDataBase.Tables(vgTable.Name).Indexes(vgIndexKey$).Columns
         If vgToInsert Then
            vgVal = vgTable.Columns(vgCol.Name).Value
         Else
            vgVal = vgRecordSet.Fields(vgCol.Name).Value
         End If
         x$ = ""
         z$ = ""
         If vgCol.ColumnType = TP_CARACTER Or vgCol.ColumnType = TP_MEMO Then x$ = x$ + "'"
         If (vgCol.ColumnType = TP_DATA_HORA And Not IsNull(vgVal)) Or vgCol.ColumnType = TP_CARACTER Or vgCol.ColumnType = TP_MEMO Then z$ = z$ + "'"
         If vgCol.ColumnType = TP_CARACTER Or vgCol.ColumnType = TP_MEMO Then
            x$ = x$ + (vgVal & "")
            z$ = z$ + (vgVal & "")
         ElseIf vgCol.ColumnType = TP_DATA_HORA Then
            If IsNull(vgVal) Then
               x$ = x$ + "NULL"
               z$ = z$ + "NULL"
            ElseIf vgCol.Mask = "99:99" Then
               x$ = x$ + "Format('" + Format(vgVal, "hh:mm") + "', 'hh:mm')"
               z$ = z$ + Format(vgVal, "hh:mm")
            ElseIf vgCol.Mask = "99:99:99" Then
               x$ = x$ + "Format('" + Format(vgVal, "hh:mm:ss") + "', 'hh:mm:ss')"
               z$ = z$ + Format(vgVal, "hh:mm:ss")
            Else
               x$ = x$ + "Format('" + Format(vgVal, "yyyy-mm-dd") + "', 'yyyy-mm-dd')"
               z$ = z$ + Format(vgVal, "yyyy-mm-dd")
            End If
         ElseIf vgCol.ColumnType = TP_NUMERICO Then
            If IsNull(vgVal) Then
               x$ = x$ + "0"
               z$ = z$ + "0"
            Else
               x$ = x$ + Substitui(CStr(Val(vgVal)), ",", ".", UM_A_UM)
               z$ = z$ + Substitui(CStr(Val(vgVal)), ",", ".", UM_A_UM)
            End If
         ElseIf vgCol.ColumnType = TP_LOGICO Then
            If CBool(vgVal) = True Then
               x$ = x$ + "1"
               z$ = z$ + "1"
            Else
               x$ = x$ + "0"
               z$ = z$ + "0"
            End If
         End If
         If vgCol.ColumnType = TP_CARACTER Or vgCol.ColumnType = TP_MEMO Then x$ = x$ + "'"
         If (vgCol.ColumnType = TP_DATA_HORA And Not IsNull(vgVal)) Or vgCol.ColumnType = TP_CARACTER Or vgCol.ColumnType = TP_MEMO Then z$ = z$ + "'"
         vgExpFilterReady$ = Substitui$(vgExpFilterReady$, "#{" + vgCol.Name + "}", x$, SO_UM)
         vgExpPureFilterReady$ = Substitui$(vgExpPureFilterReady$, "#{" + vgCol.Name + "}", z$, SO_UM)
      Next
   End If
   If vgToInsert Then
      vgExpFilterReady$ = Mid$(vgExpFilterReady$, 7)
      vgExpPureFilterReady$ = Mid$(vgExpPureFilterReady$, 7)
   End If
End Sub

Public Sub Edit()
   Dim vgPV As Boolean, vgCol As GColumn
   On Error GoTo DeuErro
   vgPV = True

   If vgDataBase.vgInTransaction Then
      vgTransactionBookmark = BookMark
      vgTransactionPosiction = AbsolutePosition
   End If
   
   'recordset não é editável, vamos guardar as chaves (já monta o filtro)
   If Len(vgExpUpdate$) > 0 And Len(vgExpFilter$) > 0 Then
      For Each vgCol In vgTable.Columns
         vgCol.Value = vgRecordSet.Fields(vgCol.Name).Value
         vgCol.HasChange = False
      Next
      Call DefineFilter                                'monta expressão de filtro
   Else
      Resync 1                                         ' se editar um registro, fizer um update e logo após dar um rollback, se tentar editar novamente dá erro (MDB ADO), vamos sincronizar esse reg novamente
      vgRecordSet.Edit
   End If
   vgStatus = ACAO_EDITANDO
   Exit Sub

DeuErro:
   If Err.Number = 91 And vgPV Then                    'objeto não setado, vamos abrir
      vgPV = False
      OpenRecordSet
      If vgDataBase.vgInTransaction Then
         vgTransactionBookmark = BookMark
         vgTransactionPosiction = AbsolutePosition
      End If
   ElseIf Err.Number = 438 Then                        'propriedade não existe... ignora
      Resume Next
   Else
      If vgDataBase.vgInTransaction Then
         vgTransactionBookmark = ""
         vgTransactionPosiction = 0
      End If
      On Error GoTo 0
   End If
   Resume
End Sub

Public Sub Update()
   Dim vgPV As Boolean, vgBook As Variant, vgExecute As String, vgCol As GColumn, vgQt As Long, i As Integer, x As String
   On Error GoTo DeuErro
   vgPV = True
   If vgStatus = ACAO_EDITANDO Then
      vgBook = vgRecordSet.BookMark
   End If

   'se recordset não é editável... vamos fazer via query
   If Len(vgExpUpdate$) > 0 Then
      If vgStatus = ACAO_EDITANDO Then
         vgExecute$ = vgExpUpdate$
      ElseIf vgStatus = ACAO_INCLUINDO Then
         vgExecute$ = vgExpInsert$
      End If
      vgQt = 0                                         'número de colunas que serão atualizadas
      For Each vgCol In vgTable.Columns
         If vgCol.UpdatableColumn Then
            If Not vgCol.HasChange Then                'se coluna não foi alterada
               Do
                  i = InStr(vgExecute$, "$" + CStr(vgCol.Index) + "{")
                  If i > 0 Then
                     vgExecute$ = Left$(vgExecute$, i - 1) + Mid$(vgExecute$, InStr(vgExecute$, "}" + CStr(vgCol.Index) + "$") + 2 + Len(CStr(vgCol.Index)))
                  End If
               Loop Until i = 0
            Else
               vgQt = vgQt + 1
               
               'coloca separador de campos
               If vgQt > 1 Then vgExecute$ = Substitui$(vgExecute$, "$" + CStr(vgCol.Index) + "{", ", ", SO_UM)
               
               'vamos remover marcações de campo
               vgExecute$ = Retira$(vgExecute$, "$" + CStr(vgCol.Index) + "{", SO_UM)
               vgExecute$ = Retira$(vgExecute$, "}" + CStr(vgCol.Index) + "$", SO_UM)
               x$ = ""
               If vgCol.ColumnType = TP_CARACTER Or vgCol.ColumnType = TP_MEMO Or (Not IsNull(vgTable.Columns(vgCol.Name).Value) And vgCol.ColumnType = TP_DATA_HORA) Then x$ = x$ + "'"
               If vgCol.ColumnType = TP_CARACTER Or vgCol.ColumnType = TP_MEMO Then
                  x$ = x$ + (vgTable.Columns(vgCol.Name).Value & "")
               ElseIf vgCol.ColumnType = TP_DATA_HORA Then
                  If IsNull(vgTable.Columns(vgCol.Name).Value) Then
                     x$ = x$ + "NULL"
                  Else
                     If (InStr(CStr(vgTable.Columns(vgCol.Name).Value & ""), "/") > 0 Or InStr(CStr(vgTable.Columns(vgCol.Name).Value & ""), "-") > 0) And InStr(CStr(vgTable.Columns(vgCol.Name).Value & ""), ":") > 0 Then
                        x$ = x$ + Format(vgTable.Columns(vgCol.Name).Value, "yyyy-mm-dd hh:mm:ss")
                     ElseIf InStr(CStr(vgTable.Columns(vgCol.Name).Value & ""), "/") > 0 Or InStr(CStr(vgTable.Columns(vgCol.Name).Value & ""), "-") > 0 Then
                        x$ = x$ + Format(vgTable.Columns(vgCol.Name).Value, "yyyy-mm-dd")
                     Else
                        x$ = x$ + Format(vgTable.Columns(vgCol.Name).Value, "hh:mm:ss")
                     End If
                  End If
               ElseIf vgCol.ColumnType = TP_NUMERICO Then
                  If IsNull(vgTable.Columns(vgCol.Name).Value) Then
                     x$ = x$ + "0"
                  Else
                     x$ = x$ + Substitui(CStr(ValBrasil(vgTable.Columns(vgCol.Name).Value)), ",", ".", UM_A_UM)
                  End If
               ElseIf vgCol.ColumnType = TP_LOGICO Then
                  If CBool(vgTable.Columns(vgCol.Name).Value) = True Then
                     x$ = x$ + "1"
                  Else
                     x$ = x$ + "0"
                  End If
               End If
               If vgCol.ColumnType = TP_CARACTER Or vgCol.ColumnType = TP_MEMO Or (Not IsNull(vgTable.Columns(vgCol.Name).Value) And vgCol.ColumnType = TP_DATA_HORA) Then x$ = x$ + "'"
               vgExecute$ = Substitui$(vgExecute$, "@{" + vgCol.Name + "}", x$, SO_UM)
            End If
         End If
      Next
      
      'faz a filtragem
      If vgQt > 0 Then                                 ' Verifica se existem campos para fazer o Update
         vgExecute$ = Replace$(vgExecute$, "{FILTER}", vgExpFilterReady$)
         vgDataBase.Execute vgExecute$
      End If

      If vgQt > 0 Then
         Call DefineFilter(True)                       'monta expressão de filtro para pegar novo bookmark
         Requery
         If vgStatus = ACAO_INCLUINDO Then
            vgRecordSet.MoveLast
            vgBook = vgRecordSet.BookMark
         End If
         vgRecordSet.Filter = vgExpPureFilterReady$
         If vgRecordSet.RecordCount > 0 Then
            vgBook = vgRecordSet.BookMark
         End If
         vgRecordSet.Filter = ""
         If vgRecordSet.RecordCount > 0 Then
            vgRecordSet.BookMark = vgBook
         End If
      End If

   Else
      vgQt = vgRecordSet.RecordCount
      vgRecordSet.Update
      Call DefineFilter(False)                         'monta expressão de filtro para pegar novo bookmark
      If Not vgDataBase.vgInTransaction Or vgStatus = ACAO_INCLUINDO Then Resync 1 'vamos atualizar registro corrente
      If vgRecordSet.RecordCount < vgQt Then                                       'ops, o ADO retirou o registro do recordset
         Dim vgRsTemp As GRecordSet
         Set vgRsTemp = vgDataBase.OpenRecordSet("SELECT COUNT(*) AS TOT FROM (" + NewSource + ") AS T") 'vamos contar número de registros que deveria ter
         If vgRsTemp!TOT <> vgRecordSet.RecordCount Then                                                 'compara com o que temos
            Requery                               'força atualização do recordset inteiro
            vgBook = vgRecordSet.BookMark         'pega bookmark atual
            If vgStatus = ACAO_INCLUINDO Then     'estamos incluindo
                  vgRecordSet.MoveLast            'posiciona no fim
                  vgBook = vgRecordSet.BookMark   'guarda esse bookmark
            End If
            vgRecordSet.Filter = vgExpPureFilterReady$ 'tenta localizar o registro que foi incluído
            If vgRecordSet.RecordCount > 0 Then        'achou?
                  vgBook = vgRecordSet.BookMark        'grava bookmark
            End If
            vgRecordSet.Filter = ""                    'mostra todos os registros novamente
            If vgRecordSet.RecordCount > 0 Then        'tem registros?
               vgRecordSet.BookMark = vgBook           'posiciona no bookmark encontrado
            End If
         End If
         vgRsTemp.CloseRecordset                       'destroi tabela temporária
         Set vgRsTemp = Nothing
      End If
   End If
   If vgStatus = ACAO_EDITANDO Then
      vgRecordSet.BookMark = vgBook
   End If

FimDaSub:
   vgStatus = ACAO_NAVEGANDO
   PrepareResync                                       'define propriedades "Unique Table" e "Resync Command" para SQL-Server
   If Not vgDataBase.vgInTransaction Then Resync 1     'adAffectCurrent
   Exit Sub

DeuErro:
   If Err.Number = 3246 Then
      vgExpFilterPending$ = vgExpPureFilterReady$
      vgIsPendingUpdate = True
      Resume FimDaSub
   ElseIf Err.Number = 91 And vgPV Then
      vgPV = False
      OpenRecordSet
   Else
      On Error GoTo 0
   End If
   Resume
End Sub

Public Sub CancelUpdate()
   Dim vgPV As Boolean
   On Error GoTo DeuErro
   vgPV = True
   If Len(vgExpUpdate$) > 0 Then
      vgIsPendingUpdate = False
   Else
      If Not vgRecordSet.EOF And Not vgRecordSet.BOF Then
         vgRecordSet.CancelUpdate
      End If
   End If
   vgStatus = ACAO_NAVEGANDO
   Exit Sub

DeuErro:
   If Err.Number = 91 And vgPV Then
      vgPV = False
      OpenRecordSet
   Else
      On Error GoTo 0
   End If
   Resume
End Sub

Public Sub Delete()
   Dim vgPV As Boolean, vgExecute As String, vgRecAfect As Long

   On Error GoTo DeuErro
   vgPV = True

   'recordset não é editável, vamos guardar as chaves (já monta o filtro)
   If Len(vgExpDelete$) > 0 And Len(vgExpFilter$) > 0 Then
      vgExecute$ = vgExpDelete$
      Call DefineFilter                                  'monta expressão de filtro
      vgExecute$ = Replace$(vgExecute$, "{FILTER}", vgExpFilterReady$) 'faz a filtragem
      vgDataBase.Execute vgExecute$, , vgRecAfect                      'execute
      If vgRecAfect > 1 Then
         Err.Description = LoadGasString(121)
         Err.Number = 3600
         Error 3600
      End If
      Resync 1, 2                                 'apenas atualiza o atual, isso faz com que o registro seja retirado do recordset
   Else
      vgRecordSet.Delete
   End If
   
   Exit Sub

DeuErro:
   If Err.Number = 91 And vgPV Then
      vgPV = False
      OpenRecordSet
   Else
      On Error GoTo 0
   End If
   Resume
End Sub

Public Sub Requery()
   Dim vgPV As Boolean
   On Error GoTo DeuErro
   vgPV = True
   If CursorType <> CURSOR_TABLE Then 
      vgRecordSet.Requery
      Populate
   End If
   Exit Sub

DeuErro:
   If Err.Number = 91 And vgPV And Len(vgSource) > 0 Then
      vgPV = False
      OpenRecordSet
   ElseIf Len(vgSource) > 0 Then
      On Error GoTo 0
   Else
      On Error Resume Next
   End If
   Resume
End Sub

Public Sub MoveFirst()
   Dim vgPV As Boolean
   On Error GoTo DeuErro
   vgPV = True
   vgRecordSet.MoveFirst
   Call UpdateNoMatch
   Exit Sub

DeuErro:
   If Err.Number = 91 And vgPV Then
      vgPV = False
      OpenRecordSet
   Else
      On Error GoTo 0
   End If
   Resume
End Sub

Public Sub MovePrevious()
   Dim vgPV As Boolean
   On Error GoTo DeuErro
   vgPV = True
   vgRecordSet.MovePrevious
   Call UpdateNoMatch
   Exit Sub

DeuErro:
   If Err.Number = 91 And vgPV Then
      vgPV = False
      OpenRecordSet
   Else
      On Error GoTo 0
   End If
   Resume
End Sub

Public Sub MoveNext()
   Dim vgPV As Boolean
   On Error GoTo DeuErro
   vgPV = True
   vgRecordSet.MoveNext
   Call UpdateNoMatch
   Exit Sub

DeuErro:
   If Err.Number = 91 And vgPV Then
      vgPV = False
      OpenRecordSet
   Else
      On Error GoTo 0
   End If
   Resume
End Sub

Public Sub MoveLast()
   Dim vgPV As Boolean
   On Error GoTo DeuErro
   vgPV = True
   If CursorType = CURSOR_ASYNC And vgAsyncComplete = False Then
      vgRecordSet.MoveFirst                            'move para o primeiro
      Move vgRecCount                                  'e posiciona no último registro lido
   Else
      vgRecordSet.MoveLast
      Call UpdateNoMatch
   End If
   Exit Sub

DeuErro:
   If Err.Number = 91 And vgPV Then
      vgPV = False
      OpenRecordSet
   Else
      On Error GoTo 0
   End If
   Resume
End Sub

Public Sub Find(ByVal vgSQL As String)
   Dim rsClone As Object
   Dim vgPV As Boolean
   On Error GoTo DeuErro
   vgPV = True
   Set rsClone = vgRecordSet.Clone
   rsClone.Filter = vgSQL$
   If rsClone.EOF Or rsClone.BOF Then
      vgRecordSet.MoveLast
      vgRecordSet.MoveNext
   Else
      vgRecordSet.BookMark = rsClone.BookMark
   End If
   Call UpdateNoMatch
   rsClone.Close
   Set rsClone = Nothing
Exit Sub

DeuErro:
   If Err.Number = 91 And vgPV Then
      vgPV = False
      OpenRecordSet
   Else
      On Error GoTo 0
   End If
   Resume
End Sub

Private Sub UpdateNoMatch()
   On Error Resume Next
   vgNoMatch = (vgRecordSet.EOF = True Or vgRecordSet.BOF = True)
   If Err Then
      Err.Clear
      vgNoMatch = True
   End If
End Sub

Private Sub CheckDataBase()
   On Error Resume Next
   If DataBase Is Nothing Then
      Set DataBase = vgDb(1)
   End If
End Sub

Public Function PTab(ByVal vgInd As String, ParamArray vgParams() As Variant) As Boolean
   If Len(vgInd) > 0 Then
      Index = vgInd                                     'estamos setando diretamente para vgIndex para que o Let de Index não monta temporariamente o recordset, evitando assim a abertura desnecessária de um rs
   End If
   vgSelectRecords = True
   Select Case UBound(vgParams)                         'pela qtde de chave pesquisa...
      Case 0                                            'uma chave
         SeekRecord "", "=", vgParams(0)
      Case 1                                            'duas chaves
         SeekRecord "", "=", vgParams(0), vgParams(1)
      Case 2                                            'tres chaves
         SeekRecord "", "=", vgParams(0), vgParams(1), vgParams(2)
      Case 3                                            'quatro chaves
         SeekRecord "", "=", vgParams(0), vgParams(1), vgParams(2), vgParams(3)
      Case 4                                            'cinco chaves
         SeekRecord "", "=", vgParams(0), vgParams(1), vgParams(2), vgParams(3), vgParams(4)
      Case 5                                            'seis chaves
         SeekRecord "", "=", vgParams(0), vgParams(1), vgParams(2), vgParams(3), vgParams(4), vgParams(5)
      Case 6                                            'sete chaves
         SeekRecord "", "=", vgParams(0), vgParams(1), vgParams(2), vgParams(3), vgParams(4), vgParams(5), vgParams(6)
      Case 7                                            'oito chaves
         SeekRecord "", "=", vgParams(0), vgParams(1), vgParams(2), vgParams(3), vgParams(4), vgParams(5), vgParams(6), vgParams(7)
      Case 8                                            'nove chaves
         SeekRecord "", "=", vgParams(0), vgParams(1), vgParams(2), vgParams(3), vgParams(4), vgParams(5), vgParams(6), vgParams(7), vgParams(8)
      Case 9                                            'dez chaves
         SeekRecord "", "=", vgParams(0), vgParams(1), vgParams(2), vgParams(3), vgParams(4), vgParams(5), vgParams(6), vgParams(7), vgParams(8), vgParams(9)
   End Select
   
   vgSelectRecords = False
   PTab = Not vgNoMatch
   
End Function

Public Sub SeekRecord(ByVal vgInd As String, ByVal vgOper As String, ParamArray vgParams() As Variant)
   Dim vgSQL As String, i As Integer, vgRegAtual As Variant, vgSortAtual As String, vgNomeCp As String, _
       vgIndAtual As String, vgWhereAtual As String, vgOrderAtual As String, vgOk As Boolean, vgCp As GColumn, _
       vgTipo As GCOLUMN_TYPE, x As String, vgIndIndex As Integer, z As String, _
       vgEDtHora As Boolean, vgClearExpSeek As Boolean
   ReDim vgPar(UBound(vgParams)) As Variant
   Dim vgPV As Integer
   
   On Error GoTo DeuErro
   vgPV = 0
   If Not vgSelectRecords Then
      vgWhereAtual = vgWhere
      vgOrderAtual = vgOrderBy
      vgSortAtual = vgSort
   End If
   vgIndAtual = vgIndex
   
   If Len(vgInd) > 0 And vgIndex <> vgInd Then
      Index = vgInd
   End If
   
   If vgSource <> vgOpenSource And vgSeekType = 1 Then   'ainda não abriu o recordset
      If Len(vgWhere) = 0 And Len(vgOrderBy) = 0 And vgTop = -1 Then 'realmente vai abrir em modo table
         OpenRecordSet                                               'abre o recordset
      Else
         vgSeekType = 3
      End If
   End If


   'se nao tem a definicao da tabela...
   If Not vgTable Is Nothing Then
      x$ = vgTable.Name
   Else
      x$ = ""
   End If
   If Len(x$) = 0 Then
      If Len(vgSource) > 0 Then
         Set vgTable = vgDataBase.Tables(vgSource)
      End If
   End If
   On Error Resume Next
   vgIndIndex = vgDataBase.Tables(vgTable.Name).Indexes(vgIndex).Index
   If Err Then
      vgIndIndex = 0
      Err.Clear
   End If
   
   'monta a ordem para procurar o registro na tela de procura
   vgSort = ""
   If vgIndIndex > 0 Then
      For i = 1 To vgDataBase.Tables(vgTable.Name).Indexes(vgIndex).Columns.Count
         If vgDataBase.Tables(vgTable.Name).Indexes(vgIndex).Columns(i).ColumnType <> TP_MEMO Then 'não podemos atribuir campo memo à propriedade Sort do Recordset (evitar erro)
            If Len(vgSort) > 0 Then vgSort = vgSort & ", "
            vgSort = vgSort & PoeColchetes(vgDataBase.Tables(vgTable.Name).Indexes(vgIndex).Columns(i).Name)
         End If
      Next
   End If
   
   If UBound(vgExpSeek) = 0 Then
      ReDim vgUltOperSeek(vgDataBase.Tables(vgTable.Name).Indexes.Count) As String
      ReDim vgExpSeek(vgDataBase.Tables(vgTable.Name).Indexes.Count) As String
      ReDim vgQtCpsUltSeek(vgDataBase.Tables(vgTable.Name).Indexes.Count) As Integer
   End If

   On Error GoTo DeuErro
   
   'remonta expressão para seek quando necesário
   vgClearExpSeek = False
   If vgQtCpsUltSeek(vgIndIndex) <> UBound(vgParams()) Or vgUltOperSeek$(vgIndIndex) <> vgOper$ Or vgIndIndex = 0 Then
      vgPrepExpSeekFilter$ = ""
      vgExpSeek$(vgIndIndex) = ""
      vgUltOperSeek$(vgIndIndex) = vgOper$
      vgQtCpsUltSeek(vgIndIndex) = UBound(vgParams())
      If vgIndIndex > 0 Then
         For i = 1 To vgDataBase.Tables(vgTable.Name).Indexes(vgIndex).Columns.Count
            vgTipo = vgDataBase.Tables(vgTable.Name).Indexes(vgIndex).Columns(i).ColumnType
            vgNomeCp$ = PoeColchetes(vgDataBase.Tables(vgTable.Name).Indexes(vgIndex).Columns(i).Name)
            If UBound(vgParams) >= i - 1 Then
               If Len(vgExpSeek$(vgIndIndex)) > 0 And (Len(vgParams(i - 1) & "") > 0 Or vgOper$ = "=") Then 
                  vgPrepExpSeekFilter$ = vgPrepExpSeekFilter$ & " AND "
                  vgExpSeek$(vgIndIndex) = vgExpSeek$(vgIndIndex) + " AND "
               End If
               If vgTipo = TP_DATA_HORA And Len(CStr(vgParams(i - 1) & "")) > 0 And InStr(vgParams(i - 1) & "", ":") = 0 And Not vgSelectRecords Then 'se tem data válida e não tem hora especificada...
                  Select Case vgUltOperSeek$(vgIndIndex)
                     Case "="                     'Data >=  XX/XX/XX 00:00:00 AND Data <= XX/XX/XX 23:59:59
                        vgPrepExpSeekFilter$ = vgPrepExpSeekFilter$ & vgNomeCp$ + " >= " + "|" + CStr(i) + ".HI| AND " + vgNomeCp$ + " <= " + "|" + CStr(i) + ".HF|"
                        vgExpSeek$(vgIndIndex) = vgExpSeek$(vgIndIndex) + vgNomeCp$ + " >= " + "|" + CStr(i) + ".HI| AND " + vgNomeCp$ + " <= " + "|" + CStr(i) + ".HF|"
                     Case ">"                     'Data >   XX/XX/XX 23:59:59
                        vgPrepExpSeekFilter$ = vgPrepExpSeekFilter$ & vgNomeCp$ + " > " + "|" + CStr(i) + ".HF|"
                        vgExpSeek$(vgIndIndex) = vgExpSeek$(vgIndIndex) + vgNomeCp$ + " > " + "|" + CStr(i) + ".HF|"
                     Case ">="                    'Data >=  XX/XX/XX 00:00:00
                        vgPrepExpSeekFilter$ = vgPrepExpSeekFilter$ & vgNomeCp$ + " >= " + "|" + CStr(i) + ".HI|"
                        vgExpSeek$(vgIndIndex) = vgExpSeek$(vgIndIndex) + vgNomeCp$ + " >= " + "|" + CStr(i) + ".HI|"
                     Case "<"                     'Data <   XX/XX/XX 00:00:00
                        vgPrepExpSeekFilter$ = vgPrepExpSeekFilter$ & vgNomeCp$ + " < " + "|" + CStr(i) + ".HI|"
                        vgExpSeek$(vgIndIndex) = vgExpSeek$(vgIndIndex) + vgNomeCp$ + " < " + "|" + CStr(i) + ".HI|"
                     Case "<="                    'Data <=  XX/XX/XX 23:59:59
                        vgPrepExpSeekFilter$ = vgPrepExpSeekFilter$ & vgNomeCp$ + " <= " + "|" + CStr(i) + ".HF|"
                        vgExpSeek$(vgIndIndex) = vgExpSeek$(vgIndIndex) + vgNomeCp$ + " <= " + "|" + CStr(i) + ".HF|"
                  End Select
               Else                               'qualquer tipo exceto data válida
                  If vgTipo = TP_DATA_HORA And Len(CStr(vgParams(i - 1) & "")) > 0 Then
                     vgEDtHora = ((InStr(CStr(vgParams(i - 1) & ""), "/") > 0 Or InStr(CStr(vgParams(i - 1) & ""), "-") > 0) And InStr(CStr(vgParams(i - 1) & ""), ":") > 0)
                  Else
                     vgEDtHora = False
                  End If
                  If vgTipo = TP_DATA_HORA And vgEDtHora = False Then
                     If Len(CStr(vgParams(i - 1) & "")) > 0 Then
                        vgExpSeek$(vgIndIndex) = vgExpSeek$(vgIndIndex) + "Format("
                     Else
                        vgClearExpSeek = True
                     End If
                  End If
                  
                  'se o parâmetro está preenchido ou o operador é "=", adicionamos o nome do campo à expressão
                  If Len(vgParams(i - 1) & "") > 0 Or vgOper$ = "=" Then 
                     vgPrepExpSeekFilter$ = vgPrepExpSeekFilter$ & vgNomeCp$
                     vgExpSeek$(vgIndIndex) = vgExpSeek$(vgIndIndex) + vgNomeCp$
                  End If
                  
                  If vgTipo = TP_DATA_HORA And Len(CStr(vgParams(i - 1) & "")) > 0 And vgEDtHora = False Then
                     If (InStr(CStr(vgParams(i - 1) & ""), "/") > 0 Or InStr(CStr(vgParams(i - 1) & ""), "-") > 0) And InStr(CStr(vgParams(i - 1) & ""), ":") > 0 Then
                        x = "yyyy-mm-dd hh:mm:ss"
                     ElseIf InStr(CStr(vgParams(i - 1) & ""), "/") > 0 Or InStr(CStr(vgParams(i - 1) & ""), "-") > 0 Then
                        x = "yyyy-mm-dd"
                     Else
                        x = "hh:mm:ss"
                     End If
                     vgExpSeek$(vgIndIndex) = vgExpSeek$(vgIndIndex) + ", '" + x + "')"
                  End If
                  
                  'se o parâmetro está preenchido ou o operador é "=", vamos adicionar o operador à expressão
                  If Len(vgParams(i - 1) & "") Or vgOper$ = "=" Then 
                     vgPrepExpSeekFilter$ = vgPrepExpSeekFilter$ & " " + vgUltOperSeek$(vgIndIndex) + " "
                     vgExpSeek$(vgIndIndex) = vgExpSeek$(vgIndIndex) + " " + vgUltOperSeek$(vgIndIndex) + " "
                  End If
                  If vgEDtHora Then
                     vgExpSeek$(vgIndIndex) = vgExpSeek$(vgIndIndex) + "CDate("
                  End If
                  
                  'se é um campo que requer pipe e o parâmetro foi preenchido ou o operador é "=", vamos adicionar o pipe à expressão
                  If (vgTipo = TP_CARACTER Or vgTipo = TP_MEMO) And (Len(vgParams(i - 1) & "") > 0 Or vgOper$ = "=") Then 
                     vgPrepExpSeekFilter$ = vgPrepExpSeekFilter$ & "'"
                     vgExpSeek$(vgIndIndex) = vgExpSeek$(vgIndIndex) + "'"
                  End If
                  
                  'se o parâmetro está preenchido, vamos adicionar o valor a ser substituído na expressão
                  If Len(vgParams(i - 1) & "") > 0 Or vgOper$ = "=" Then 
                     vgPrepExpSeekFilter$ = vgPrepExpSeekFilter$ & "|" + CStr(i) + "|"
                     vgExpSeek$(vgIndIndex) = vgExpSeek$(vgIndIndex) + "|" + CStr(i) + "|"
                  End If
                  
                  'se é um campo que requer pipe e o parâmetro foi preenchido ou o operador é "=", vamos adicionar o pipe à expressão
                  If (vgTipo = TP_CARACTER Or vgTipo = TP_MEMO) And (Len(vgParams(i - 1) & "") > 0 Or vgOper$ = "=") Then 
                     vgPrepExpSeekFilter$ = vgPrepExpSeekFilter$ & "'"
                     vgExpSeek$(vgIndIndex) = vgExpSeek$(vgIndIndex) + "'"
                  End If

                  If vgEDtHora Then
                     vgExpSeek$(vgIndIndex) = vgExpSeek$(vgIndIndex) + ")"
                  End If
               End If
            End If
         Next
      Else                                        'não tem esse índice na tabela, vamos utilizar como nome de campo
         vgTipo = vgDataBase.Tables(vgTable.Name).Columns(vgIndex).ColumnType
         If vgSelectRecords And Len(Where) > 0 Then
            vgExpSeek$(vgIndIndex) = "(" + Where + ")"
         Else
            vgExpSeek$(vgIndIndex) = ""
         End If
         If Len(vgExpSeek$(vgIndIndex)) > 0 Then vgExpSeek$(vgIndIndex) = vgExpSeek$(vgIndIndex) + " AND "
         vgNomeCp$ = PoeColchetes(vgDataBase.Tables(vgTable.Name).Columns(vgIndex$).Name)
         If vgTipo = TP_DATA_HORA And Len(CStr(vgParams(0) & "")) > 0 And InStr(vgParams(0) & "", ":") = 0 And Not vgSelectRecords Then 'se tem data válida e não tem hora especificada...
            Select Case vgUltOperSeek$(vgIndIndex)
               Case "="                           'Data >=  XX/XX/XX 00:00:00 AND Data <= XX/XX/XX 23:59:59
                  vgExpSeek$(vgIndIndex) = vgExpSeek$(vgIndIndex) + vgNomeCp$ + " >= " + "|1.HI| AND " + vgNomeCp$ + " <= " + "|0.HF|"
               Case ">"                           'Data >   XX/XX/XX 23:59:59
                  vgExpSeek$(vgIndIndex) = vgExpSeek$(vgIndIndex) + vgNomeCp$ + " > " + "|1.HF|"
               Case ">="                          'Data >=  XX/XX/XX 00:00:00
                  vgExpSeek$(vgIndIndex) = vgExpSeek$(vgIndIndex) + vgNomeCp$ + " >= " + "|1.HI|"
               Case "<"                           'Data <   XX/XX/XX 00:00:00
                  vgExpSeek$(vgIndIndex) = vgExpSeek$(vgIndIndex) + vgNomeCp$ + " < " + "|1.HI|"
               Case "<="                          'Data <=  XX/XX/XX 23:59:59
                  vgExpSeek$(vgIndIndex) = vgExpSeek$(vgIndIndex) + vgNomeCp$ + " <= " + "|1.HF|"
            End Select
         Else                                     'qualquer tipo exceto data válida
            If vgTipo = TP_DATA_HORA And Len(CStr(vgParams(0) & "")) > 0 Then
               vgEDtHora = ((InStr(CStr(vgParams(0) & ""), "/") > 0 Or InStr(CStr(vgParams(0) & ""), "-") > 0) And InStr(CStr(vgParams(0) & ""), ":") > 0)
            Else
               vgEDtHora = False
            End If
            If vgEDtHora Then
               vgExpSeek$(vgIndIndex) = vgExpSeek$(vgIndIndex) + "CDate("
               End If
            If vgTipo = TP_DATA_HORA And vgEDtHora = False Then
               If Len(CStr(vgParams(0) & "")) > 0  Then
                  vgExpSeek$(vgIndIndex) = vgExpSeek$(vgIndIndex) + "Format("
               Else
                  vgClearExpSeek = True
               End If
            End If
            vgPrepExpSeekFilter$ = vgPrepExpSeekFilter$ & vgNomeCp$
            vgExpSeek$(vgIndIndex) = vgExpSeek$(vgIndIndex) + vgNomeCp$
            If vgTipo = TP_DATA_HORA And Len(CStr(vgParams(0) & "")) > 0 And vgEDtHora = False Then
               If (InStr(CStr(vgParams(0) & ""), "/") > 0 Or InStr(CStr(vgParams(0) & ""), "-") > 0) And InStr(CStr(vgParams(0) & ""), ":") > 0 Then
                  x = "yyyy-mm-dd hh:mm:ss"
               ElseIf InStr(CStr(vgParams(0) & ""), "/") > 0 Or InStr(CStr(vgParams(0) & ""), "-") > 0 Then
                  x = "yyyy-mm-dd"
               Else
                  x = "hh:mm:ss"
               End If
               vgExpSeek$(vgIndIndex) = vgExpSeek$(vgIndIndex) + ", '" + x + "')"
            End If
            vgPrepExpSeekFilter$ = vgPrepExpSeekFilter$ & " " + vgUltOperSeek$(vgIndIndex) + " "
            vgExpSeek$(vgIndIndex) = vgExpSeek$(vgIndIndex) + " " + vgUltOperSeek$(vgIndIndex) + " "
            If vgTipo = TP_CARACTER Or vgTipo = TP_MEMO Then 
               vgPrepExpSeekFilter$ = vgPrepExpSeekFilter$ & "'"
               vgExpSeek$(vgIndIndex) = vgExpSeek$(vgIndIndex) + "'"
            End If
            vgPrepExpSeekFilter$ = vgPrepExpSeekFilter$ & "|1|"
            vgExpSeek$(vgIndIndex) = vgExpSeek$(vgIndIndex) + "|1|"
            If vgTipo = TP_CARACTER Or vgTipo = TP_MEMO Then
               vgPrepExpSeekFilter$ = vgPrepExpSeekFilter$ & "'" 
               vgExpSeek$(vgIndIndex) = vgExpSeek$(vgIndIndex) + "'"
            End If
            If vgEDtHora Then
               vgExpSeek$(vgIndIndex) = vgExpSeek$(vgIndIndex) + ")"
            End If
         End If
      End If
      vgExpSeek$(vgIndIndex) = DataBase.TrataSQL(vgSource$, "", 1, vgExpSeek$(vgIndIndex), "")
   End If
   
   'substitui os valores passados para o seek na string para seek desse recordset
   vgExpSeekFilter$ = vgPrepExpSeekFilter$        'vamos usar a expressão template montada para substituir os valores dos campos
   vgSQL$ = vgExpSeek$(vgIndIndex)
   For i = 0 To UBound(vgParams)
      x$ = "|" + CStr(i + 1) + "|"
      vgOk = True
      If vgIndIndex = 0 Then
         Set vgCp = vgDataBase.Tables(vgTable.Name).Columns(vgIndex)
      Else
         Set vgCp = vgDataBase.Tables(vgTable.Name).Indexes(vgIndex).Columns(i + 1)
      End If
      If vgCp.Nullable Then
         Select Case vgCp.ColumnType
            Case TP_CARACTER, TP_MEMO
               vgOk = (Len(vgParams(i) & "") > 0)
            Case TP_DATA_HORA
               vgOk = IsDate(vgParams(i))
               vgClearExpSeek = True              'sempre que for campo data vamos remontar a expressão para evitar erro
         End Select
      End If
      If Not vgOk Then
         If vgOper$ = "=" Then
            vgSQL$ = Substitui(vgSQL$, vgUltOperSeek$(vgIndIndex) + " " + x, "= NULL", SO_UM)
            vgExpSeekFilter$ = Substitui$(vgExpSeekFilter$, vgUltOperSeek$(vgIndIndex) + " " + x, "= NULL", SO_UM)
         Else
            vgSQL$ = Substitui(vgSQL$, vgUltOperSeek$(vgIndIndex) + " " + x, "<> NULL", SO_UM)
            vgExpSeekFilter$ = Substitui$(vgExpSeekFilter$, vgUltOperSeek$(vgIndIndex) + " " + x, "<> NULL", SO_UM)
         End If
      Else
         If vgCp.ColumnType = TP_DATA_HORA Then
            If IsNull(vgParams(i)) Then
               vgSQL$ = Substitui(vgSQL$, x$, "NULL", SO_UM)
            Else
               If (InStr(CStr(vgParams(i) & ""), "/") > 0 Or InStr(CStr(vgParams(i) & ""), "-") > 0) And InStr(CStr(vgParams(i) & ""), ":") > 0 Then
                  z = "yyyy-mm-dd hh:mm:ss"
               ElseIf InStr(CStr(vgParams(i) & ""), "/") > 0 Or InStr(CStr(vgParams(i) & ""), "-") > 0 Then
                  z = "yyyy-mm-dd"
               Else
                  z = "hh:mm:ss"
               End If
               vgExpSeekFilter$ = Substitui(vgExpSeekFilter$, x, "'" + Format(vgParams(i), z) + "'", SO_UM)
               vgSQL$ = Substitui(vgSQL$, x, "'" + Format(vgParams(i), z) + "'", SO_UM)
               
               'faz subsituições para data em formatos especiais (dd/mm/yyyy 00:00:00 e dd/mm/yyyy 23:59:59 fixados)
               z$ = Left$(x$, Len(x$) - 1)
               vgExpSeekFilter$ = Substitui(vgExpSeekFilter$, z$ + ".HI|", "'" + Format(vgParams(i), "yyyy-mm-dd") + " 00:00:00'", SO_UM)
               vgSQL$ = Substitui(vgSQL$, z$ + ".HI|", "'" + Format(vgParams(i), "yyyy-mm-dd") + " 00:00:00'", SO_UM)
               vgExpSeekFilter$ = Substitui(vgExpSeekFilter$, z$ + ".HF|", "'" + Format(vgParams(i), "yyyy-mm-dd") + " 23:59:59'", SO_UM)
               vgSQL$ = Substitui(vgSQL$, z$ + ".HF|", "'" + Format(vgParams(i), "yyyy-mm-dd") + " 23:59:59'", SO_UM)
            End If
         Else
            z$ = Substitui(CStr(vgParams(i)), "'", "''", SO_UM)
            If vgCp.ColumnType = TP_NUMERICO Then
               z$ = Substitui(z$, ",", ".", SO_UM) 'vamos trocar a , (vírgula) por . (ponto) para inserir na query
               If UCase$(vgOper) = "LIKE" Then
                  z$ = Retira$(z$, "*", UM_A_UM)
               End If
            End If
            vgExpSeekFilter$ = Substitui(vgExpSeekFilter$, x$, z$, SO_UM)
            vgSQL$ = Substitui(vgSQL$, x$, z$, SO_UM)
         End If
      End If
   Next

   If vgClearExpSeek Then
      vgUltOperSeek$(vgIndIndex) = ""
   End If

   Set vgCp = Nothing
   
   If vgSelectRecords Then
      OpenRecordSet vgSQL$, , True
   Else                                            'seektype = 3
      vgRegAtual = BookMark
      x$ = DataBase.TrataSQL(Source, SelectColumns, -1, Where, OrderBy)
      If x$ <> RsSource Then
         Top = -1
         OpenRecordSet
      End If
      vgRecordSet.Filter = vgExpSeekFilter$
      vgRecordSet.Sort = vgSort
   End If

   Call UpdateNoMatch
   If Not vgNoMatch Then
      If Not vgSelectRecords Then
         vgRegAtual = BookMark
      End If
   End If
   If Not vgSelectRecords Then
      vgWhere = vgWhereAtual
      vgOrderBy = vgOrderAtual
      vgSort = vgSortAtual
   End If
   vgIndex = vgIndAtual
   If vgSeekType = 3 And Not vgSelectRecords Then  'vamos SEMPRE retirar o filter pois não quer selecionar só esse registro do Seek
      vgRecordSet.Filter = ""
      vgRecordSet.Sort = vgSortAtual               'volta a ordenação para antes do sort da procura
      If Not IsEmpty(vgRegAtual) Then
         BookMark = vgRegAtual
      End If
   End If
   Exit Sub
   
DeuErro:
   If Err.Number = 91 And vgPV = 0 Then
      vgPV = 1
      Call CheckDataBase
   ElseIf Err.Number = 91 And vgPV = 1 Then
      vgPV = 2
      OpenRecordSet
   ElseIf Err.Number = 3021 Then
      Resume Next
   Else
      On Error GoTo 0
   End If
   Resume
End Sub

Public Sub CloseRecordset()
   On Error Resume Next
   vgRecordSet.Close
   Set vgRecordSet = Nothing
   RsAsyncFetch.Close
   Set RsAsyncFetch = Nothing
   Set BdTrans = Nothing
   Err.Clear
   vgOpenSource$ = ""
End Sub

Public Sub Move(ByVal NumRecords As Double, Optional ByVal Start As Variant)
   On Error Resume Next
   vgRecordSet.Move NumRecords, Start
   Call UpdateNoMatch
End Sub

Public Sub Populate()
   If Not vgRecordSet Is Nothing Then
      On Error Resume Next
      If RecordCount > 0 And CursorType <> CURSOR_ASYNC And CursorType <> CURSOR_FORWARD Then
         vgRecordSet.MoveLast
         vgRecordSet.MoveFirst
      End If
      Err.Clear
   End If
End Sub

Private Sub PrepareResync()
   Dim vgCol As GColumn, vgResyncWHERE As String
   
   'se for SQL-Server e houver relacionamentos na tabela então vamos montar o "Resync Command" e determinar a "Unique Table"
   If Database.DataBaseType = DB_SQL And UBound(vgRelations) > 0 Then 
      If Len(vgIndexKey) > 0 Then                                            'se há indice único então podemos continuar
         vgRecordSet.Properties("Unique Table") = vgTable.Name               'atribui o nome da tabela principal
         For Each vgCol In vgDataBase.Tables(vgTable.Name).Indexes(vgIndexKey$).Columns
            vgResyncWHERE = vgResyncWHERE & IIf(Len(vgResyncWHERE) > 0, " AND ", "") & PoeColchetes(vgCol.Name) & " = ? " 'prepara a WHERE da consulta
         Next
         vgRecordSet.Properties("Resync Command") = "SELECT * FROM (" & vgRecordSet.Source & ") AS TbPrepResync WHERE " & vgResyncWHERE
      End If
   End If
End Sub

Public Sub Resync(Optional AffectRecords As Long = 3, Optional ResyncValues As Long = 2)
   Dim vgPV As Boolean, i As Integer, TemPKey As Integer
   On Error GoTo DeuErro
   vgPV = True
   For i = 1 To vgDataBase.Tables(vgTable).Indexes.Count
      If vgDataBase.Tables(vgTable).Indexes(i).IndexType = TYPE_Primary Then
         TemPKey = True
         vgRecordSet.Resync AffectRecords, ResyncValues
         Exit For
      End If
   Next
   If Not TemPKey Then
      Requery
   End If
   Exit Sub

DeuErro:
   If Err.Number = 91 And vgPV Then
      vgPV = False
      OpenRecordSet
      Resume
   ElseIf Err.Number = 438 Then
      Resume Next                                 'propriedade não existe, vamos ignorar
   Else
      If vgRecordSet.Status = 262144 Then
         Resume Next                              'registro foi excluído através do método execute e não existe para sincronizar. Mesmo com o erro o registro é removido do recordset.
      End If
   End If
End Sub

Public Property Get NewSource() As String
   Dim vgPV As Boolean
   On Error GoTo DeuErro
   vgPV = True
   NewSource = DataBase.TrataSQL(vgSource, vgSelectColumns, vgTop, vgWhere, vgOrderBy)
   Exit Property

DeuErro:
   If Err.Number = 91 And vgPV Then
      vgPV = False
      Call CheckDataBase
      Resume
   End If
End Property

Public Function Clone() As GRecordSet
   Dim i As Long, j As Long

   'popula o recordset
   i = vgRecordSet.RecordCount
   Do While vgAsyncComplete = False And j < 200000
      j = j + 1
      DoEvents
   Loop
   
   Set Clone = New GRecordSet
   Set Clone.DataBase = vgDataBase
   Set Clone.Table = vgTable
   Set Clone.RecordSet = vgRecordSet.Clone
   Clone.CursorType = vgCursorType
   Clone.LockType = vgLockType
   Clone.Options = vgOptions
   Clone.UpdateCriteria = vgUpdateCriteria
   Clone.Sort = vgSort
   Clone.SelectColumns = vgSelectColumns
   Clone.Where = vgWhere
   Clone.OrderBy = vgOrderBy
   Clone.Top = vgTop
   Clone.Source = vgSource
   Clone.RsSource = vgOpenSource$
   Clone.AsyncComplete = vgAsyncComplete
   Clone.Index = vgIndex
   Set Clone.Table = vgTable
End Function

Public Function State() As Long
   On Error Resume Next
   State = vgRecordSet.State
   If Err Then
      State = 0                                         'adStateClosed
      Err.Clear
   End If
End Function

Public Sub SetForm(Form As Object)
   Set vgForm = Form
End Sub

'Retorna expressão que determina o campo no SELECT
'Ex:
'    SELECT Count(*) As Total FROM ...                 Retorno = Count(*)
'    SELECT Código As Produto FROM ...                 Retorno = Código
'    SELECT 'Código: ' + Código As Produto FROM ...    Retorno = 'Código: ' + Código
'    SELECT Código FROM ...                            Retorno = Código
'    SELECT * FROM ...                                 Retorno = Código
Public Function GetExpressionSelect(ByVal vgCp As Integer) As String
   Dim x As String, i As Long, j As Long, RetVal As String, vgSQL As String, vgCps As String
   RetVal$ = ""
   If vgSeekType = 3 Then
      vgSQL = Substitui(RsSource, vbCrLf, Chr(32) + Chr(32), UM_A_UM)
      i = InStr(UCase(vgSQL), "SELECT ")
      j = InStr(i + 1, UCase(vgSQL$), " FROM ")
      If j = 0 Then j = Len(vgSQL$) + 1           'se a query não tem cláusula FROM vamos pegar o Mid até o final da query
      Do While i > 0
         If Tally(Left(vgSQL, j - 1), Chr(39)) Mod 2 = 0 And Tally(Mid(vgSQL, j + 4), Chr(39)) Mod 2 = 0 Then
            vgCps = Trim$(Mid$(vgSQL$, i + 6, j - i - 6))
            i = 0
            Exit Do
         Else
            j = InStr(j + 1, vgSQL, "FROM")
         End If
      Loop
      vgCps$ = Trim$(Substitui$(vgCps$, vbCrLf, Chr(32) + Chr(32), UM_A_UM))
      If UCase$(Left$(vgCps$, 4)) = "TOP " Then
         vgCps$ = Trim$(Mid$(vgCps$, 4))
         vgCps$ = Trim$(Mid$(vgCps$, InStr(vgCps$, Chr(32)) + 1))
      End If
      If Len(vgCps) Then
         If vgCps = "*" Then
            RetVal$ = vgRecordSet.Fields(vgCp).Name
         Else
            If InStr$(vgCps$, "*") Then
               vgCps$ = CorrectSelect(vgCps$)     'vamos montar expressão para o select
            End If
            x = Parse(vgCps, ",", vgCp + 1)
            i = InStr(UCase(x), " AS ")
            If i Then
               x = Left(x, i - 1)
            End If
            RetVal$ = Trim(x)
         End If
      End If
   End If
   GetExpressionSelect = RetVal$
End Function

'Remonta expressão SELECT corrigindo os * pelos nomes reais dos campos
Private Function CorrectSelect(ByVal vgSelect As String) As String
   Dim vgRetVal As String, i As Integer, j As Integer, k As Integer, x As String, z As String
   vgRetVal = ""
   For i = 1 To Tally(vgSelect$, ",") + 1
      x$ = Trim$(Parse(vgSelect$, ",", i))
      If x$ = "*" Or Right(x$, 1) = "*" Then             'tem asterisco...
         If i < Tally(vgSelect$, ",") + 1 Then           'se não for o último
            For j = i + 1 To Tally(vgSelect$, ",") + 1   'vamos procurar o próximo campo na query
               z$ = Trim$(Parse(vgSelect$, ",", j))
               If z$ <> "*" And Right(z$, 1) <> "*" Then 'tem asterisco...
                  j = 0
                  Exit For
               End If
            Next
            If j = 0 Then
               If InStr(UCase(z$), " AS ") Then
                  z$ = Left$(z$, InStr(UCase$(z$), " AS ") - 1)
               End If
               For j = i + 1 To vgRecordSet.Fields.Count
                  If UCase$(vgRecordSet.Fields(j - 1).Name) = UCase$(z$) Then
                     k = j
                     j = 0
                     Exit For
                  End If
               Next
            End If
         Else
            j = 1
         End If
         If j <> 0 Then
            k = vgRecordSet.Fields.Count
         End If
         For j = i To k
            vgRetVal = vgRetVal + ", " + PoeColchetes(vgRecordSet.Fields(j - 1).Name)
         Next
      Else
         vgRetVal = vgRetVal + ", " + x$
      End If
   Next
   If Left$(vgRetVal$, 1) = "," Then vgRetVal$ = Trim$(Mid$(vgRetVal$, 2))
   CorrectSelect = vgRetVal$
End Function

Public Sub AddRelation(ByVal vgTableName As String, ByVal vgFieldCapture As String, ByVal vgListFields As String, ByVal vgOrder As String, ByVal vgComboFilter As String, ByVal vgRelation As String)
   Dim vgInd As Integer
   vgInd = UBound(vgRelations) + 1
   ReDim Preserve vgRelations(vgInd) As String
   vgRelations(vgInd) = vgTableName$ + "|" + vgFieldCapture$ + "|" + vgListFields$ + "|" + vgOrder$ + "|" + vgComboFilter$ + "|" + vgRelation$
End Sub

Public Sub ClearRelations()
   ReDim vgRelations(0) As String
End Sub

Private Function MakeExpressionSelect(ByVal vgBaseSelect As String, ByVal vgTab As String) As String
   Dim i As Integer, RetVal As String, x As String
   RetVal$ = ""
   For i = 1 To Tally(vgBaseSelect, "|")
      x = Parse$(vgBaseSelect$, "|", i)
      RetVal$ = RetVal$ + PoeColchetes(vgTab$) + "." + PoeColchetes(x$, True) + " AS " + PoeColchetes(x$, True) + ", "
   Next
   RetVal$ = Left$(RetVal$, Len(RetVal$) - 2)
   MakeExpressionSelect = RetVal
End Function

'Transforma campos do select em uma string separada por "|"
'Ex:  vgSelect = Codigo, Descrição As Desc
'     RetVal   = Codigo|Descrição
'Caso passada vgBaseTable retorna apenas campos do select
'que possam ser campos dessa tabela
'se vgRemoveFunc = True as funções agregadas serão retiradas
Private Function ParseSelect(ByVal vgSelect As String, vgRemoveFunc As Boolean, vgInsertPosition As Boolean, vgBaseTable As String) As String
   Dim vgRetVal As String, i As Integer, x As String, k As String, vgPos As Integer, vgTableTmp As GTable, vgTab As String, z As String, p As Integer
   vgPos = 0
   If Len(vgBaseTable$) > 0 Then
      Set vgTableTmp = vgDataBase.Tables(vgBaseTable$)
   End If
   vgSelect$ = Trim$(Substitui(vgSelect$, vbCrLf, Chr$(32) + Chr$(32), UM_A_UM)) + Chr$(32)
   vgSelect$ = Substitui$(vgSelect$, "[]", Chr$(34) + Chr$(34), UM_A_UM)
   If UCase$(Left$(vgSelect$, 4)) = "TOP " Then
      vgSelect$ = Trim$(Mid$(vgSelect$, 5))
      vgSelect$ = Trim$(Mid$(vgSelect$, InStr(vgSelect$, " ") + 1))
   End If
   vgRetVal$ = ""
   Do While Len(vgSelect$)
      x$ = Parse$(vgSelect$, ",")
      Do While Tally(x$, "(") <> Tally(x$, ")")        'vamos pegar todos os parâmetros se função ou se somatório de campos entre ()
         x$ = x$ + "," + Parse$(vgSelect$, ",")
      Loop
      x$ = Trim$(x$)
      k$ = ""
      If InStr(x$, "(") = 0 Then
         Do While Len(x$)
            k$ = k$ + Parse$(x$, Chr$(32)) + Chr$(32)
            If Tally(k$, Chr(34)) Mod 2 = 0 Then x$ = ""
         Loop
         k$ = Trim$(k$)
      Else
         k$ = x$
      End If
      k$ = Retira$(k$, Chr$(34) + "[]", UM_A_UM)
      vgTab$ = ""
      i = 0
      If vgRemoveFunc Then
         i = InStr(k$, "(")
      End If
      If vgInsertPosition Then
         vgPos = vgPos + 1
      End If
      
      If InStr(k$, "(") = 0 Then
         If InStr(k$, ".") > 0 Then
            vgTab$ = Parse$(k$, ".")
         End If
      End If
      
      'vamos ver se campo presente na tabela origem
      If Len(vgBaseTable$) > 0 Then
         If UCase$(vgTab$) = UCase$(vgBaseTable$) Or vgTab$ = "" Then
            On Error Resume Next
            z$ = vgDataBase.Tables(vgBaseTable$).Columns(k$).Name
            If Err <> 0 Then
               i = -99
            End If
            On Error GoTo 0
         Else
            i = -99
         End If
      End If

      If i = 0 Then
      
         'coloca todos os campos da tabela...
         If Len(vgTab$) > 0 And k$ = "*" Then
            k$ = ""
            For p = 1 To vgDataBase.Tables(vgTab$).Columns.Count
               k$ = k$ + "|" + vgDataBase.Tables(vgTab$).Columns(p).Name
            Next
            k$ = Mid$(k$, 2)
         End If
      
         If vgInsertPosition Then vgRetVal$ = vgRetVal$ + CStr(vgPos) + "-"
         vgRetVal$ = vgRetVal$ + k$ + "|"
      End If
   Loop
   If Len(vgRetVal$) > 0 Then vgRetVal$ = "|" + vgRetVal$
   ParseSelect = vgRetVal$
End Function

'Separa campos válidos (que não são fórmulas) de um SELECT
'Esses serão os campos que são atualizáveis
Private Function GetValidColumnsSelect(ByVal vgSQL As String) As String
   Dim vgTableName As String, vgTableTmp As GTable, vgSelect As String, vgRetVal As String, vgCol As GColumn
   
   vgRetVal$ = ""
   
   'vamos achar o nome da tabela
   vgTableName$ = ExtraiSQL(vgSQL$, EXP_FROM, True)
   If Left$(vgTableName$, 1) = Chr$(34) Or Left$(vgTableName$, 1) = "[" Then
      vgTableName$ = Mid$(vgTableName$, 2, Len(vgTableName$) - 2)
   End If
   Set vgTableTmp = Nothing
   On Error Resume Next
   Set vgTableTmp = vgDataBase.Tables(vgTableName$)
   On Error GoTo 0
   If vgTableTmp Is Nothing Then vgTableName$ = ""
   
   'vamos verificar se é necessário inserir as colunas chave
   If Len(vgTableName$) > 0 Then
      vgSelect$ = Trim$(ExtraiSQL(vgSQL$, EXP_SELECT))
      If UCase$(Left$(vgSelect$, 4)) = "TOP " Then
         vgSelect$ = Trim$(Mid$(vgSelect$, 4))
         vgSelect$ = Trim$(Mid$(vgSelect$, InStr(vgSelect$, Chr(32)) + 1))
      End If
      If (vgSelect$ = "*" Or vgSelect$ = "") Then         'vamos pegar todos os campos da tabela
         For Each vgCol In vgTableTmp.Columns
            vgRetVal$ = vgRetVal$ + "|" + CStr(vgCol.Index) + "-" + UCase$(vgCol.Name)
         Next
         vgRetVal$ = vgRetVal$ + "|"
      Else
         vgRetVal$ = UCase$(ParseSelect(vgSelect$, True, True, vgTableName$))
      End If
   End If
   GetValidColumnsSelect = vgRetVal$
End Function

'insere campos chave na expressão SELECT e monta expressão de filtragem pela chave
Private Sub InsertKeys(ByRef vgSQL As String, ByRef vgIndKey As String, ByRef vgFilter As String)
   Dim vgTableName As String, vgTableTmp As GTable, vgSelect As String, vgCp As GColumn, vgCps As String, _
       vgQtCps As Integer, vgKeys As String, vgKeysTemp As String, vgFilterTemp As String, vgIndOk As Boolean, _
       vgSoFiltro As Boolean, i As Integer, x As String, vgHasGroup As String
   
   vgHasGroup = (Len(ExtraiSQL(vgSQL$, EXP_GROUPBY, True)) > 0)
   
   If vgHasGroup Then
      vgIndKey$ = ""
      vgFilter$ = ""
      Exit Sub
   End If
   
   'vamos achar o nome da tabela
   vgTableName$ = ExtraiSQL(vgSQL$, EXP_FROM, True)
   If Left$(vgTableName$, 1) = Chr$(34) Or Left$(vgTableName$, 1) = "[" Then
      vgTableName$ = Mid$(vgTableName$, 2, Len(vgTableName$) - 2)
   End If
   Set vgTableTmp = Nothing
   On Error Resume Next
   Set vgTableTmp = vgDataBase.Tables(vgTableName$)
   On Error GoTo 0
   If vgTableTmp Is Nothing Then vgTableName$ = ""
   
   vgFilter$ = ""
   
   'vamos verificar se é necessário inserir as colunas chave
   If Len(vgTableName$) > 0 Then
      vgSelect$ = Trim$(ExtraiSQL(vgSQL$, EXP_SELECT))
      If UCase$(Left$(vgSelect$, 4)) = "TOP " Then
         vgSelect$ = Trim$(Mid$(vgSelect$, 4))
         vgSelect$ = Trim$(Mid$(vgSelect$, InStr(vgSelect$, Chr(32)) + 1))
      End If
      vgSoFiltro = (vgSelect$ = "*" Or vgSelect$ = "") And Len(vgIndex) = 0 
      If Not vgSoFiltro Then vgCps$ = UCase$(ParseSelect(vgSelect$, True, False, ""))
      vgQtCps = 99
      For i = 1 To vgTableTmp.Indexes.Count
         If vgTableTmp.Indexes(i).IndexType = TYPE_Unique Or vgTableTmp.Indexes(i).IndexType = TYPE_Primary Then
            vgFilterTemp$ = ""
            If Not vgSoFiltro Then vgKeysTemp$ = ""
            For Each vgCp In vgTableTmp.Indexes(i).Columns
               vgIndOk = True
               If Not vgSoFiltro Then
                  If InStr(vgCps$, "|" + UCase$(vgCp.Name) + "|") = 0 And InStr(vgCps$, "|" + UCase$(vgTableTmp.Name) + "." + UCase$(vgCp.Name) + "|") = 0 Then   'campo não está no select...
                     vgIndOk = False
                  End If
               End If
               x$ = PoeColchetes(vgCp.Name)
               If Len(vgFilterTemp$) > 0 Then vgFilterTemp$ = vgFilterTemp$ + " AND "
               vgFilterTemp$ = vgFilterTemp$ + x$ + " = #{" + vgCp.Name + "}"
               If Not vgSoFiltro And Not vgIndOk Then
                  If Len(vgKeysTemp$) > 0 Then vgKeysTemp$ = vgKeysTemp$ + ", "
                  vgKeysTemp$ = vgKeysTemp$ + PoeColchetes(vgTableName$) + "." + x$
               End If
            Next
            If vgTableTmp.Indexes(i).Columns.Count < vgQtCps And Not vgIndOk Then   'se índice não está no select
               vgIndKey$ = vgTableTmp.Indexes(i).Name
               vgFilter$ = vgFilterTemp$
               If Not vgSoFiltro Then vgKeys$ = vgKeysTemp$
               vgQtCps = vgTableTmp.Indexes(i).Columns.Count
            ElseIf vgIndOk Then
               vgIndKey$ = vgTableTmp.Indexes(i).Name
               vgFilter$ = vgFilterTemp$
               If Not vgSoFiltro Then vgKeys$ = ""
               Exit For
            End If
         End If
      Next
      If Not vgIndOk And Not vgSoFiltro And Len(vgCps$) > 0 And Len(vgKeys$) > 0 Then
         If Len(vgIndex) = 0  Then vgSelect$ = vgSelect$ + ", " + vgKeys$
         If Len(vgIndex) = 0  Then vgSQL$ = Trim$(InsereSQL(vgSQL$, EXP_SELECT, vgSelect$))
         vgSQL$ = vgDataBase.TrataSQL(vgSQL$, "", -1, "", "")
         vgExtraFields$ = vgExtraFields$ + UCase$(Retira$(Substitui(vgKeys$, ", ", "|", SO_UM), "[]", UM_A_UM)) + "|"
      End If
   End If
   
End Sub

'corrige o select colocando todas as relações com left join...
Private Sub PrepareRelation(ByRef vgSQL As String)
   Dim Ct As Integer, i As Integer, j As Integer, vgExtFields As String, x As String, z As String, _
       vgTableName As String, vgFieldCapture As String, vgListFields As String, vgTabFrom As String, _
       vgOrder As String, vgRelation As String, vgComboFilter As String, vgSqlTemp As String, vgRel As String
   
   If UBound(vgRelations) > 0 Then
      
      Ct = 0
      vgTabFrom$ = Retira$(ExtraiSQL$(vgSQL$, EXP_FROM), Chr$(34) + "[]", UM_A_UM)
      For i = 1 To UBound(vgRelations)
         Ct = Ct + 1
         vgExtFields$ = ""
         vgRel$ = vgRelations(i)
         vgTableName$ = Parse$(vgRel$, "|", 1)
         vgFieldCapture$ = Parse$(vgRel$, "|", 2)
         vgListFields$ = Substitui$(Parse$(vgRel$, "|", 3), ";", "|", SO_UM)
         vgOrder$ = Substitui$(Parse$(vgRel$, "|", 4), ";", "|", SO_UM)
         vgComboFilter$ = Parse$(vgRel$, "|", 5)
         vgRelation$ = Parse$(vgRel$, "|", 6)
         vgRelation$ = Trim$(Substitui$(" " + vgRelation$, " " + PoeColchetes(vgTabFrom$) + ".", " T" + CStr(Ct) + ".", SO_UM))
         vgSqlTemp$ = "SELECT " + "T" + CStr(Ct) + ".*"
         If Len(PoeColchetes(vgFieldCapture$)) > 0 Then
         x$ = "|" + PoeColchetes(vgFieldCapture$) + "|"
         Else
            x$ = "|"
         End If
         For j = 1 To Tally(vgListFields$ + "|", "|")
            z$ = PoeColchetes(Trim$(Parse$(vgListFields$ + "|", "|", j)))
            If Len(z$) > 0 Then
               If InStr(x$, "|" + z$ + "|") = 0 Then
                  x$ = x$ + z$ + "|"
               End If
            End If
         Next
         x$ = TrimAll(x$, "|")
         If Len(x$) > 0 Then
            For j = 1 To Tally(x$ + "|", "|")
               vgExtFields$ = vgExtFields$ + "|" + vgDataBase.GetFieldNameShort(vgTableName$ + "_" + Retira$(Parse(x$, "|", j), "[]", UM_A_UM))
            Next
            For j = 1 To Tally(x$ + "|", "|")
               If Parse(x$, "|", j) <> "*" Then
                  vgSqlTemp$ = vgSqlTemp$ + ", " + PoeColchetes(vgTableName$) + "." + Parse(x$, "|", j) + " AS " + PoeColchetes(vgDataBase.GetFieldNameShort(vgTableName$ + "_" + Retira$(Parse(x$, "|", j), "[]", UM_A_UM)), True)
               Else
                  vgSqlTemp$ = vgSqlTemp$ + ", " + PoeColchetes(vgTableName$) + "_" + Parse(x$, "|", j)
               End If
            Next
         End If
         vgSQL$ = vgSqlTemp$ + " FROM " + vbCrLf + "(" + vbCrLf + TrimAll(vgSQL$, vbCrLf) + vbCrLf + ") AS T" + CStr(Ct) + vbCrLf + "LEFT JOIN " + PoeColchetes(vgTableName$) + vbCrLf + "ON " + vgRelation$
      Next
      vgExtFields$ = Mid$(vgExtFields$, 2)
      If Len(vgExtFields$) > 0 Then
         vgExtFields$ = ", " + MakeExpressionSelect(vgExtFields$ + "|", "T")
      End If
      vgSQL$ = "SELECT T.* FROM " + vbCrLf + "(" + vbCrLf + vgSQL$ + vbCrLf + ") AS T"
      vgSQL$ = DataBase.TrataSQL(vgSQL$, "", -1, "", "")
   End If

End Sub

Public Sub OpenRecordSet(Optional vgSQL As String, Optional vgDatBas As GDataBase, Optional vgFromDataBase As Boolean, Optional vgInsertKey As Boolean = True, Optional vgForceOpen As Boolean = False)
   Dim vgPV As Boolean, vgNewSQL As Boolean, vgFieldName As String, vgTableName As String, x As String, _
       z As String, i As Integer, vgColumn As GColumn, vgTp As GCOLUMN_TYPE, _
       vgFilter As String, vgIndKey As String, vgFName As String, vgFValue As String, vgFNameValue As String, _
       vgCreate As Boolean, vgTabName As String, vgUpdatableColumn As Boolean, vgSize As Long, vgDecimal As Integer, _
       vgTitle As String, vgNameFilter As String, vgNotUpdateCol As Boolean, vgHidden As Boolean, vgHasExecute As Boolean, _
       vgSystem As Boolean, vgFIni As String, vgFEnd As String, vgValidCols As String
               
   On Error GoTo DeuErro
   vgPV = True

   If Not vgDatBas Is Nothing Then
      Set DataBase = vgDatBas
   End If
   If vgFromDataBase = False Then                                 'se não vem da classe Database, SQL ainda não tratado...
      If Len(vgSQL) = 0 Then                                      'se não passou SQL,
         vgSQL$ = NewSource                                       'vamos tentar montar um segundos parâmetros WHERE, ORDERBY, TOP, etc...
         vgNewSQL = False
      Else                                        'passou SQL
         vgSQL$ = vgDataBase.TrataSQL(vgSQL$, vgSelectColumns, vgTop, vgWhere, vgOrderBy) 'então vamos apenas tratá-lo para esse banco
         vgNewSQL = True
      End If
   ElseIf Not vgSelectRecords Then                'se for setado pelo openrecordset do database diretamente
      vgNewSQL = True                             'tem que inicializa o source
   End If

   vgTableName$ = ExtraiSQL(vgSQL$, EXP_FROM, True) 'vamos guardar o nome retirado do from antes das transformações
   
   'vamos verificar se pode construir cláusulas de update, delete e insert
   If Len(vgTableName$) > 0 And UBound(vgRelations) > 0 Then
      vgHasExecute = True
   Else
      vgHasExecute = False
   End If
   
   vgExtraFields$ = "|"                             'campos extras inseridos no select
   
   If vgInsertKey And Not vgFromDataBase And Len(ExtraiSQL(vgSQL$, EXP_GROUPBY)) = 0 Then 'se não tem agrupamento (funções agregadas), insere chaves
      Call InsertKeys(vgSQL$, vgIndKey$, vgFilter$)                                       'insere os campos que compoem a chave no select e retorna expressão de filtro assim como da chave que será utilizada
   End If

   vgValidCols$ = GetValidColumnsSelect(vgSQL$)                                           'pega colunas que estão no SELECT que são campos da tabela base do SELECT

   Call PrepareRelation(vgSQL$)                   'vamos fazer as relações necessárias

   'vamos colocar cláusulas em select externo
   If Len(vgExternalWhere) > 0 Or Len(vgExternalOrderBy) > 0 Or vgExternalTop > 0 Then
      If UBound(vgRelations) = 0 Then             'se não tem relação (se tem relação já foram montadas sub-querys)
         x$ = UCase$(Left$(Substitui(vgSQL$, vbCrLf, Chr$(32) + Chr$(32), UM_A_UM), 7)) 'vamos montar um sub-select
         If x$ = "SELECT " Then                   'só se já tem SELECT, se não tem (ia abrir como table) deixa que a trata faz a query
            If vgDataBase.DataBaseType = DB_SQL And Val(vgDataBase.Connection.Properties("DBMS Version")) > 8 Then
               vgSQL$ = InsereSQL(vgSQL$, EXP_SELECT, IIf(InStr(ExtraiSQL(vgSQL$, EXP_SELECT), "TOP "), "", " TOP 1000000000 ") & ExtraiSQL(vgSQL$, EXP_SELECT))
            End If    
            vgSQL$ = "SELECT * FROM (" + vgSQL$ + ") AS TGR"
         End If
      End If
      vgSQL$ = vgDataBase.TrataSQL(vgSQL$, "", vgExternalTop, vgExternalWhere, vgExternalOrderBy) 'vamos colocar as cláusulas externas
   End If

   'abre o recordset
   On Error Resume Next
   If vgSQL$ <> vgOpenSource$ Or vgForceOpen Then
      CloseRecordset
      On Error GoTo 0
      
      'vamos criar o objeto
      If vgRecordSet Is Nothing Then
         Set vgRecordSet = CreateObject("ADODB.RecordSet")                                        'tenta criar um recordset ADO
      End If
      If vgCursorType = -1 Or vgCursorType = CURSOR_TABLE Then vgCursorType = CURSOR_DYNAMIC      'adOpenDynamic
      If vgLockType = -1 Then vgLockType = 2      'adLockPessimistic
      If vgOptions = -1 Then vgOptions = 1        'adCmdText
      If vgUpdateCriteria = -1 Then vgUpdateCriteria = 2 'adCriteriaUpdCols
      If vgCursorType = CURSOR_ASYNC Then
         vgOptions = 32                                  'adAsyncFetch
         If Not RsAsyncFetch Is Nothing Then
            RsAsyncFetch.Close
            Set RsAsyncFetch = Nothing
         End If
         Set RsAsyncFetch = New ADODB.RecordSet
         RsAsyncFetch.CursorLocation = 3                 'adUseClient
         RsAsyncFetch.Properties("Initial Fetch Size") = 5000
         RsAsyncFetch.Properties("Background Fetch Size") = 5000
         vgAsyncComplete = False
         vgRecCount = 0
         RsAsyncFetch.Open vgSQL$, vgDataBase.Connection, RealCursorType, vgLockType, vgOptions
         vgRecCount = RsAsyncFetch.RecordCount
      Else
         vgRecordSet.Open vgSQL$, vgDataBase.Connection, RealCursorType, vgLockType, vgOptions
         vgAsyncComplete = True
      End If
      If vgUpdateCriteria <> 2 Then
         On Error Resume Next
         vgRecordSet.Properties("Update Criteria").Value = vgUpdateCriteria
         On Error GoTo 0
      End If
      If vgCursorType = CURSOR_ASYNC Then
         Set vgRecordSet = RsAsyncFetch
      End If
   
      If vgNewSQL Then
         Source = vgSQL$
      End If
      
      vgOpenSource = vgSQL

      vgSeekType = 3
      'vamos achar o nome da tabela
      If Left$(vgTableName$, 1) = Chr$(34) Or Left$(vgTableName$, 1) = "[" Then
         vgTableName$ = Mid$(vgTableName$, 2, Len(vgTableName$) - 2)
      End If
      Set vgTable = Nothing
      On Error Resume Next
      Set vgTable = vgDataBase.Tables(vgTableName$)
      On Error GoTo 0
      If vgTable Is Nothing Then vgTableName$ = ""
      
      'verifica se há expressões de insert, delete e update
      If vgHasExecute Then
         vgHasExecute = (Len(vgTableName$) > 0)
      End If

      'vamos montar a estrutura padrão para essa tabela
      vgTabName$ = vgTableName$
      vgFName$ = ""
      vgFValue$ = ""
      vgFNameValue$ = ""
   
      If vgHasExecute Then
         vgExpInsert$ = "INSERT INTO " + PoeColchetes(vgTabName$) + " ({FIELDNAME}) VALUES ({FIELDVALUE})"
         vgExpUpdate$ = "UPDATE " + PoeColchetes(vgTabName$) + " SET {FIELDNAME+FIELDVALUE} {FILTER}"
         vgExpDelete$ = "DELETE * FROM " + PoeColchetes(vgTabName$) + " {FILTER}"
         If Len(vgFilter$) > 0 Then vgFilter$ = "WHERE " + vgFilter$
      End If
   
      If vgTableName$ <> "" Then
         x$ = ExtraiSQL(vgSQL$, EXP_SELECT, True)
         If UCase$(Left$(x$, 4)) = "TOP " Then
            x$ = Trim$(Mid$(x$, 4))
            x$ = Trim$(Mid$(x$, InStr(x$, Chr(32)) + 1))
         End If
      Else
         x$ = ""
      End If
      If (x$ <> "*" Or vgTableName$ = "") And RealCursorType <> CURSOR_TABLE Then
         vgCreate = True
         Set vgTable = New GTable
         vgTable.Init vgDataBase, vgTableName$, vgTableName$, False, False, 0
      Else
         vgCreate = False
      End If

      'corre todos os campos do recordset para montar estrutura padrão e também expressões
      'só caso seja necessário montar nova estrutura ou se pode montar expressão de insert, update e delete
      If vgCreate Or vgHasExecute Then
         For i = 0 To vgRecordSet.Fields.Count - 1
            Set vgColumn = New GColumn                   'instancia a coluna

            'pega tipo correspondente para GCOLUMNTYPE
            Select Case vgRecordSet.Fields(i).Type
               Case 129, 200, 130, 202, 201, 203         'se for caracter/memo(adChar, adVarChar, adWChar, adVarWChar, adLongVarChar, adLongVarWChar)
                  If (vgRecordSet.Fields(i).DefinedSize > 300) Then 'força tipo memo
                     vgTp = TP_MEMO
                  Else
                     vgTp = TP_CARACTER
                  End If
               Case 7, 135                                          'se for data (adDate, adDBTimeStamp)
                  vgTp = TP_DATA_HORA
               Case 11                                              'se for lógico (adBoolean)
                  vgTp = TP_LOGICO
               Case 205                                             'se for imagem/multimídia (adLongVarBinary)
                  vgTp = TP_BINARIO
               Case Else                                            'se for númerico
                  vgTp = TP_NUMERICO
            End Select
            
            'pega algumas outras definições da coluna
            vgTableName$ = vgRecordSet.Fields(i).Properties("BASETABLENAME" ).Value & ""
            vgFieldName = vgRecordSet.Fields(i).Properties("BASECOLUMNNAME" ).Value & ""
            
            'se ADO não conseguiu pegar o nome do campo... vamos tentar na mão...
            If (Len(vgTableName$) = 0 Or UCase$(vgTableName$) = UCase$(vgTabName$)) And Len(vgFieldName$) = 0 Then
               If InStr(vgValidCols$, "|" + CStr(i + 1) + "-" + UCase$(vgRecordSet.Fields(i).Name) + "|") > 0 Then
                  vgTableName$ = vgTabName$
                  vgFieldName$ = vgRecordSet.Fields(i).Name
               End If
            End If
            
            vgNotUpdateCol = vgRecordSet.Fields(i).Properties("ISAUTOINCREMENT").Value
            vgSize = vgRecordSet.Fields(i).DefinedSize
            vgDecimal = vgRecordSet.Fields(i).Precision

            'ok, podemos colocar esse campo na expressão de update, insert e delete
            If Len(vgFieldName$) > 0 And UCase$(vgTableName$) = UCase$(vgTabName$) And Len(vgTabName$) > 0 And vgTp <> TP_BINARIO And vgNotUpdateCol = False Then
               x$ = PoeColchetes(vgFieldName$)
               z$ = "@{" + vgFieldName$ + "}"
               vgFIni$ = "$" + CStr(i + 1) + "{"
               vgFEnd$ = "}" + CStr(i + 1) + "$"
               vgFName$ = vgFName$ + vgFIni$ + x$ + vgFEnd$
               vgFValue$ = vgFValue$ + vgFIni$ + z$ + vgFEnd$
               vgFNameValue$ = vgFNameValue$ + vgFIni$ + x$ + " = " + z$ + vgFEnd$
               vgUpdatableColumn = True
            Else
               vgUpdatableColumn = False
            End If
            
            'se vamos criar estrutura para tabela
            If vgCreate Then
               
               'pega título para a coluna
               On Error Resume Next
               If vgRecordSet.Fields(i).Name <> vgFieldName$ Or Len(vgTableName$) = 0 Then 'se tem alias
                  vgTitle$ = vgRecordSet.Fields(i).Name                                    'vamos usar o alias como título
               Else                               'caso contrário
                  vgTitle$ = vgDataBase.Tables(vgTableName$).Columns(vgFieldName$).Title 'pega o título de acordo com a definição do xml
               End If
               On Error GoTo 0
               
               'se a coluna é válida, atribui propriedade System
               If Len(vgTableName$) > 0 And Len(vgFieldName$) > 0 Then
                  On Error Resume Next
                     vgSystem = vgDataBase.Tables(vgTableName$).Columns(vgFieldName$).System
                  On Error GoTo 0
               End If
               
               'pega campo de acordo com a expressão SELECT
               vgNameFilter$ = GetExpressionSelect(i)
               
               vgHidden = InStr(vgExtraFields$, "|" + UCase$(vgRecordSet.Fields(i).Name) + "|")
               
               'inicializa coluna
               vgColumn.Init vgTable, vgRecordSet.Fields(i).Name, vgTitle$, vgTp, "", vgSize, vgDecimal, vgHidden, False, vgSystem, False, 0, False, "", i, vgUpdatableColumn, vgNameFilter$
               
               'coloca propriedades se coluna válida
               If Len(vgTableName$) > 0 And Len(vgFieldName$) > 0 Then
                  On Error Resume Next
                  vgColumn.Mask = vgDataBase.Tables(vgTableName$).Columns(vgFieldName$).Mask
                  vgColumn.Size = vgDataBase.Tables(vgTableName$).Columns(vgFieldName$).Size
                  vgColumn.QDecimal = vgDataBase.Tables(vgTableName$).Columns(vgFieldName$).QDecimal
                  vgColumn.ColumnType = vgDataBase.Tables(vgTableName$).Columns(vgFieldName$).ColumnType
                  On Error GoTo 0
               ElseIf Len(vgTitle$) > 0 Then                                             'se não é uma coluna válida, vamos usar o alias definido na consulta SQL, conforme o banco de campos
                  On Error Resume Next            'dessa forma, poderemos formatar uma expressão conforme definição de um campo da estrutura do banco de dados da solução
                  If Not BancoDeCampos(vgTitle$) Is Nothing Then
                     Set vgColumn = BancoDeCampos(vgTitle$)
                  End If
                  On Error GoTo 0
               End If
               
               'adiciona coluna à coleção
               vgTable.Columns.Add vgColumn.Name, vgColumn.Title, vgColumn.ColumnType, vgColumn.Mask, vgColumn.Size, vgColumn.QDecimal, vgColumn.Hidden, vgColumn.Nullable, vgColumn.System, vgColumn.SeqInterno, vgColumn.Sequencia, vgColumn.Descending, vgColumn.Default, vgColumn.UpdatableColumn, vgColumn.NameFilter
            End If
         Next
      End If
      
      'se é preciso montar expressão para insert, update ou delete
      If vgHasExecute Then

         'expressão INSERT
         vgExpInsert$ = Replace$(vgExpInsert$, "{FIELDNAME}", vgFName$)
         vgExpInsert$ = Replace$(vgExpInsert$, "{FIELDVALUE}", vgFValue$)
         vgExpInsert$ = Trim$(vgExpInsert$)

         'expressão UPDATE
         vgExpUpdate$ = Replace$(vgExpUpdate$, "{FIELDNAME+FIELDVALUE}", vgFNameValue$)
         vgExpUpdate$ = Trim$(vgExpUpdate$)

         'expressão DELETE
         vgExpDelete$ = Trim$(vgExpDelete$)

      End If

      'vamos guardar o nome do índice utilizado para base do WHERE
      vgIndexKey$ = vgIndKey$

      'vamos guardar o filtro
      vgExpFilter$ = vgFilter$
      vgExpFilterReady$ = ""
      vgExpPureFilterReady$ = ""
      
      Call UpdateNoMatch
      RaiseEvent Opened
   ElseIf vgRecordSet.RecordCount > 0 Then        'é o mesmo recordset que está sendo solicitado para abertura
      vgRecordSet.MoveFirst                       'reposicona no primeiro registro
   End If

   Set BdTrans = vgDataBase.BdTrans
   PrepareResync                                  'define propriedades "Unique Table" e "Resync Command" para SQL-SERVER

   Exit Sub

DeuErro:
   If Err.Number = 91 And vgPV Then
      vgPV = False
      Call CheckDataBase
   Else
      On Error GoTo 0
   End If
   Resume
End Sub

Private Sub BdTrans_BeforeBeginTrans()
   RaiseEvent BeforeBeginTrans
End Sub

Private Sub BdTrans_BeforeCommitTrans()
   RaiseEvent BeforeCommitTrans
End Sub

Private Sub BdTrans_BeforeRollBackTrans()
   RaiseEvent BeforeRollBackTrans
End Sub

Private Sub BdTrans_AfterBeginTrans()
   vgDataBase.vgInTransaction = True
   RaiseEvent AfterBeginTrans
End Sub

'Está sendo feito commit na GDataBase
Private Sub BdTrans_AfterCommitTrans()
   If vgIsPendingUpdate Then
      On Error Resume Next
      Requery
      vgRecordSet.FindFirst vgExpFilterPending$
      vgExpFilterPending$ = ""
      vgIsPendingUpdate = False
   End If
   vgDataBase.vgInTransaction = False
   vgTransactionBookmark = ""
   vgTransactionPosiction = 0
   RaiseEvent AfterCommitTrans
End Sub

'Está sendo feito rollback na GDataBase
Private Sub BdTrans_AfterRollBackTrans()
   If vgIsPendingUpdate Then
      Resync 1                                           'adAffectCurrent
      vgExpFilterPending$ = ""
      vgIsPendingUpdate = False
   End If
   RestoreTransaction
   RaiseEvent AfterRollBackTrans
End Sub

Private Sub RestoreTransaction()
      If vgDataBase.vgInTransaction And Len(vgTransactionBookmark) > 0 And CStr(BookMark) <> CStr(vgTransactionBookmark) Then
      Err.Clear
      On Error Resume Next
      BookMark = vgTransactionBookmark
      If Err And vgCursorType = CURSOR_TABLE Then         'em alguns recordsets o bookmark não pode ser atualizado após um roolback!!!
         CloseRecordset                                   'vamos tentar recuperar... fecha e 
         OpenRecordSet                                    'abre novamente
         Move vgTransactionPosiction - 1                  'reposiciona recordset no registro (segundo AbsolutePosition)
      End If
      On Error GoTo 0
   End If
   vgDataBase.vgInTransaction = False
   vgTransactionBookmark = ""
   vgTransactionPosiction = 0
End Sub

'inicialização de propriedades
Private Sub Class_Initialize()
   On Error Resume Next
   vgDataBase.vgInTransaction = False
   Reset
End Sub

Private Sub Class_Terminate()
   Dim vgErrNum As Long, vgErrDesc As String, vgErrSrc As String

   'salva erro
   vgErrNum = Err.Number
   vgErrDesc = Err.Description
   vgErrSrc = Err.Source
   
   On Error Resume Next
   CloseRecordset
   Set vgRecordSet = Nothing
   Set vgForm = Nothing
   Err.Clear

   'restaura erro
   Err.Number = vgErrNum
   Err.Description = vgErrDesc
   Err.Source = vgErrSrc
End Sub

Private Sub FetchComplete()
   If vgAsyncComplete Then Exit Sub
   vgAsyncComplete = True
   If Not vgForm Is Nothing Then
      On Error Resume Next
      Call vgForm.FetchComplete(RecordCount)
   Else
      RaiseEvent FetchComplete(RecordCount)
   End If
End Sub

Private Sub RsAsyncFetch_FetchComplete(ByVal pError As ADODB.Error, adStatus As ADODB.EventStatusEnum, ByVal pRecordset As ADODB.RecordSet)
   On Error GoTo DeuErro
   vgRecCount = pRecordset.RecordCount
   Call FetchComplete
   Exit Sub

DeuErro:
   vgAsyncComplete = True
End Sub

Private Sub RsAsyncFetch_FetchProgress(ByVal Progress As Long, ByVal MaxProgress As Long, adStatus As ADODB.EventStatusEnum, ByVal pRecordset As ADODB.RecordSet)
   On Error GoTo DeuErro
   vgRecCount = Progress
   If Not vgForm Is Nothing Then
      On Error Resume Next
      Call vgForm.FetchProgress(Progress)
   Else
      RaiseEvent FetchProgress(Progress)
   End If
   If Progress = MaxProgress Then
      Call FetchComplete
   End If
   Exit Sub
   
DeuErro:
   vgAsyncComplete = True
   adStatus = 4                                       'adStatusCancel
End Sub
