
Version 1.0 Class
BEGIN
      MultiUse = -1                               'True
      Persistable = 0                             'NotPersistable
      DataBindingBehavior = 0                     'vbNone
      DataSourceBehavior  = 0                     'vbNone
      MTSTransactionMode  = 0                     'NotAnMTSObject
END
Attribute VB_Name = "GDataBase"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
DefInt A-Z

Enum EnumDataBaseType
   DB_SQL = 8
End Enum

Dim vgDataBaseType As EnumDataBaseType, vgConnection As Object, _
            vgDataBase As Object, vgUserName As String, vgPassword As String, _
            vgServer As String, vgDataBaseDir As String, vgDataBaseName As String, _
            vgDialeto As Integer, vgProvider As String, vgDriver As String, vgTimeOut As Long, _
            vgTrustedConnection As Boolean, vgStringConnection As String, vgMaxLocks As Integer, vgTransCount As Integer

Private vgTables As GTables                                 'coleção de tabelas para essa conexão
Private vgQuerys As GQuerys                                 'coleção de querys para esse banco
Private vgRelations As GRelations
Private vgName As String

Public BdTrans As GBdTrans
Public vgInTransaction As Boolean                            'flag que indica se o banco está no meio de uma transação

Private Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)


Public Property Get Name() As String
Attribute Name.VB_UserMemId = 0
   Name = vgName
End Property

Friend Function Init(ByVal Name As String) As Boolean
   vgName = Name
   Init = True
End Function

'inicialização de propriedades
Private Sub Class_Initialize()
   On Error Resume Next
   DataBaseType = -1
vgTransCount = 0
   Username = ""
   Password = ""
   Server = ""
   DataBaseName = ""
   DataBaseDir = ""
   Dialeto = -1
   MaxLocks = 9500
   Provider = ""
   StringConnection = ""
   Set vgRelations = New GRelations
   Set vgTables = New GTables
   Set vgQuerys = New GQuerys
   Set vgRelations.Parent = Me
   Set vgTables.Parent = Me
   Set vgQuerys.Parent = Me
   Set Connection = Nothing
   Set BdTrans = New GBdTrans
   vgTimeOut = 1500
End Sub

Private Sub Class_Terminate()
   Set Tables = Nothing
   Set vgQuerys = Nothing
   Set vgRelations = Nothing
End Sub

Public Property Let DataBaseType(New_DatabaseType As EnumDataBaseType)
   vgDataBaseType = New_DatabaseType
End Property

Public Property Get DataBaseType() As EnumDataBaseType
   DataBaseType = vgDataBaseType
End Property

Public Property Let StringConnection(New_StringConnection As String)
   vgStringConnection = New_StringConnection
End Property

Public Property Get StringConnection() As String
Attribute StringConnection.VB_UserMemId = 0
   StringConnection = vgStringConnection
End Property

'função para corrigir as filtragens usando Null
Public Function TrataNull(ByVal vgQuery As String) As String
   Dim x As String
   x$ = ExtraiSQL(vgQuery$, EXP_WHERE)
   If Len(x$) > 0 Then                            'se tem expressão WHERE
      x$ = Substitui(x$, "= 'NULL'", "IS NULL", SO_UM) 
      x$ = Substitui(x$, "= NULL", "IS NULL", SO_UM) 
      TrataNull = InsereSQL(vgQuery$, EXP_WHERE, x$)
   Else
      TrataNull = vgQuery$
   End If
End Function

'função para Trocar um valores por outro, dentro de uma query
Public Function TrocaValores(vgAlvo As String, vgOque As String, vgPeloQue As String) As String
   Dim x As String, vgRetVal As String, i As Integer, z As String, ii As Integer, zz As String
   vgRetVal$ = vgAlvo
   x$ = "!(),.+-*/<>= "
   'vamos ver se tem
   If InStr(UCase(vgRetVal$), UCase(vgOque)) > 0 Then
      For i = 1 To Len(x$)
         z$ = Mid(x$, i, 1)

         'Vamos ver se tem com um operador antes
         If InStr(UCase(vgRetVal$), UCase(z$ & vgOque)) > 0 Then
            For ii = 1 To Len(x$)
               zz$ = Mid(x$, ii, 1)

               'Vamos fazer para operador antes e depois
               Do While InStr(UCase(vgRetVal$), UCase(z$ & vgOque & zz$))
                  vgRetVal$ = Substitui$(vgRetVal$, z$ & vgOque & zz$, z$ & vgPeloQue & zz$, SO_UM)
               Loop
            Next
            
            'Vamos ver se não está no final, para fazer também
            ii = InStr(UCase(vgRetVal$), UCase(z$ & vgOque))
            If ii = Len(vgRetVal$) - Len(z$ & vgOque) + 1 Then
               vgRetVal$ = Mid(vgRetVal$, 1, ii) & vgPeloQue
            End If
         End If
      Next
   End If
   TrocaValores = vgRetVal$
End Function

Public Function GetFieldNameShort(ByVal vgFieldName As String) As String
   Dim vgRetVal As String, i As Integer
   vgRetVal$ = vgFieldName$
   i = InStr(vgFieldName, ".")
   If i = 0 Then
      If Len(vgRetVal$) > 30 Then
         vgRetVal$ = "F_" + Hex(GetCRC(vgRetVal$))
      End If
   ElseIf Len(vgRetVal$) - i > 30 Then
      vgRetVal$ = Left$(vgRetVal$, i) + "F_" + Hex(GetCRC(Mid$(vgRetVal$, i + 1)))
   End If
   GetFieldNameShort = vgRetVal$
End Function

Public Property Let Username(New_UserName As String)
   vgUserName = New_UserName
End Property

Public Property Get Username() As String
   Username = vgUserName
End Property

Public Property Let TimeOut(New_TimeOut As Long)
   vgTimeOut = New_TimeOut
End Property

Public Property Get TimeOut() As Long
   TimeOut = vgTimeOut
End Property

Public Property Let Password(New_Password As String)
   vgPassword = New_Password
End Property

Public Property Get Password() As String
   Password = vgPassword
End Property

Public Property Let Server(New_Server As String)
   vgServer = New_Server
End Property

Public Property Get Server() As String
   Server = vgServer
End Property

Public Property Let DataBaseName(New_DataBaseName As String)
   vgDataBaseName = New_DataBaseName
End Property

Public Property Get DataBaseName() As String
   DatabaseName = vgDataBaseName
End Property

Public Property Let DataBaseDir(New_DataBaseDir As String)
   vgDataBaseDir = New_DataBaseDir
   If Right(vgDataBaseDir, 1) <> "\" Then vgDataBaseDir = vgDataBaseDir + "\"
End Property

Public Property Get DataBaseDir() As String
   DataBaseDir = vgDataBaseDir
End Property

Public Property Let Provider(New_Provider As String)
   vgProvider = New_Provider
End Property

Public Property Get Provider() As String
   Provider = vgProvider
End Property

Public Property Let Driver(New_Driver As String)
   vgDriver = New_Driver
End Property

Public Property Get Driver() As String
   Driver = vgDriver
End Property

Public Property Let TrustedConnection(New_TrustedConnection As String)
   vgTrustedConnection = New_TrustedConnection
End Property

Public Property Get TrustedConnection() As String
   TrustedConnection = vgTrustedConnection
End Property

'FIREBIRD
Public Property Let Dialeto(New_Dialeto As String)
   vgDialeto = New_Dialeto
End Property

'FIREBIRD
Public Property Get Dialeto() As String
   Dialeto = vgDialeto
End Property

Public Property Let MaxLocks(New_MaxLocks As Integer)
   vgMaxLocks = New_MaxLocks
   'DBEngine.SetOption dbMaxLocksPerFile, vgMaxLocks           'passa para o DAO
End Property

Public Property Get MaxLocks() As Integer
   MaxLocks = vgMaxLocks
End Property

Public Property Get Tables() As GTables
   Set Tables = vgTables
End Property

Public Property Set Tables(New_GTables As GTables)
   Set vgTables = New_GTables
End Property

Public Property Get Querys() As GQuerys
   Set Querys = vgQuerys
End Property

Public Property Set Querys(New_GQuerys As GQuerys)
   Set vgQuerys = New_GQuerys
End Property

Public Property Get Relations() As GRelations
   Set Relations = vgRelations
End Property

Public Property Set Relations(New_GRelations As GRelations)
   Set vgRelations = New_GRelations
End Property

Public Property Set Connection(New_Connection As Object)
   Set vgConnection = New_Connection
End Property

Public Property Get Connection() As Object
   Set Connection = vgConnection
End Property

Public Property Set DataBase(New_DataBase As Object)
   Set vgDataBase = New_DataBase
End Property

Public Property Get DataBase() As Object
   Set DataBase = vgDataBase
End Property

Public Property Get TransactionCount() As Integer
   TransactionCount = vgTransCount
End Property

Public Sub CreateDatabase()
   Select Case vgDataBaseType
      Case DB_SQL
         CreateSQLDataBase
   End Select
End Sub

'Alias utilizado para registro do banco de dados
Public Function Alias() As String
   Alias = Me.Name
End Function

Public Sub CreateSQLDataBase()
   Dim Ar As Long, z As String, Exec As String
   Dim Pv As Boolean
   Pv = True
   
   On Error GoTo DeuErro
   OpenConnection False, True
   
TentaNovamente:
   'cria o banco sql
   vgConnection.Execute "CREATE DATABASE " + Chr$(34) + vgDataBaseName$ + Chr$(34)
   vgConnection.Execute "USE " + Chr$(34) + vgDataBaseName$ + Chr$(34)
   Ar = FreeFile
   Open vgDirEXE$ + Alias$ + "-SQL.SQL" For Input As #Ar
   Exec$ = ""
   On Error GoTo ApagaBanco
   Do While Not EOF(Ar) Or Err.Number <> 0
      z$ = ""
      Line Input #Ar, z$

      
      If UCase(Trim(z$)) = "GO" Then
         
         'troca o nome do banco pelo novo banco...
         Exec$ = Substitui(Exec$, "Use " + Alias, "Use " + vgDataBaseName$, SO_UM)
         
         vgConnection.Execute Mid(Exec$, 3)
         Exec$ = ""
      Else
         Exec$ = Exec$ + vbCrLf + z$
      End If
   Loop
   Close #Ar
   Exit Sub
   
ApagaBanco:
   Close #Ar                                      'fecha arquivo
   vgConnection.Execute "USE " & Chr$(34) & "MASTER" & Chr$(34) 'seleciona o banco master
   vgConnection.Execute "DROP DATABASE " + vgDataBaseName$      'apaga o banco, porque deu erro após o banco ter sido criado pelo programa
   If Pv = True Then                                            'se deu erro 1 vez, tenta novamente
      Pv = False
      Resume TentaNovamente
   End If
   On Error GoTo DeuErro                                        'direciona o erro para DeuErro
   Resume
   
DeuErro:                                          'dispara erro com query executada
   Err.Raise Err.Number, "GDataBase-CreateSQLDataBase", Err.Description & vbCrLf & Exec$ 

End Sub

Public Sub OpenConnection(Optional ByVal vgCreateDb As Boolean, Optional ByVal vgConnectOnly As Boolean)
   Dim vgStrConn As String, vgWithPassword As Boolean, vgErrDatabase As Boolean
   Dim vgTemp As String, x As String

   On Error Resume Next
   vgConnection.Close
   Set vgConnection = Nothing
   vgDataBase.Close
   Set vgDataBase = Nothing

   On Error GoTo DeuErro

   Call LoadStruct

   Set vgConnection = CreateObject("ADODB.Connection")

AbreNovamente:
   vgStrConn$ = ""
   If Len(vgStringConnection$) > 0 Then
      vgTemp$ = vgStringConnection$
      Do While Len(vgTemp$) > 0
         x = Parse$(vgTemp$, ";")
         If vgTrustedConnection Then
            If UCase$(Parse$(x, "=", 2)) = "[PASSWORD]" Or UCase$(Parse$(x, "=", 2)) = "[USER]" Then
               x = ""
            End If
         Else
            If Len(vgPassword) = 0 And UCase$(Parse$(x, "=", 2)) = "[PASSWORD]" Then
               x = ""
            End If
         End If
         If vgConnectOnly Then
            If UCase$(Parse$(x, "=", 2)) = "[DATABASE]" Then
               x = ""
            End If
         End If
         If Len(x) Then vgStrConn$ = vgStrConn$ + ";" + x
      Loop
      vgStrConn$ = Mid$(vgStrConn$, 2)
      vgStrConn$ = Substitui$(vgStrConn$, "[PROVIDER]", vgProvider$, SO_UM)
      vgStrConn$ = Substitui$(vgStrConn$, "[DRIVER]", vgDriver$, SO_UM)
      vgStrConn$ = Substitui$(vgStrConn$, "[SERVER]", vgServer$, SO_UM)
      vgStrConn$ = Substitui$(vgStrConn$, "[USER]", vgUserName$, SO_UM)
      vgStrConn$ = Substitui$(vgStrConn$, "[PASSWORD]", vgPassword$, SO_UM)
      vgStrConn$ = Substitui$(vgStrConn$, "[DATABASE]", vgDataBaseName$, SO_UM)
      vgStrConn$ = Substitui$(vgStrConn$, "[TRUSTED]", IIf(vgTrustedConnection, "yes", "no"), SO_UM)
      vgStrConn$ = Substitui$(vgStrConn$, "[DIALECT]", CStr(vgDialeto), SO_UM)
      vgStrConn$ = Substitui$(vgStrConn$, "[PATH]", vgDataBaseDir, SO_UM)
   Else
      If Not vgTrustedConnection Then
         vgStrConn$ = "Provider=SQLOLEDB.1;Persist Security Info=False;DRIVER={SQL Server};Server=" + vgServer + ";UID=" + vgUserName$ + ";Pwd=" + vgPassword$ + ";Trusted_Connection=NO"
      Else
         vgStrConn$ = "Provider=SQLOLEDB.1;Persist Security Info=False;DRIVER={SQL Server};Server=" + vgServer + ";Integrated Security=SSPI;Trusted_Connection=YES"
      End If
      If Not vgConnectOnly Then
         vgStrConn$ = vgStrConn$ + ";Database=" + vgDataBaseName$
      End If
   End If

   vgConnection.ConnectionString = vgStrConn$
   vgConnection.CursorLocation = 3
   vgConnection.CommandTimeout = vgTimeOut
   vgConnection.Open
   If vgDataBaseType = DB_SQL Then
      On Error Resume Next
      vgConnection.Execute "SET LANGUAGE Brazilian", True
      vgConnection.Execute "SET DATEFORMAT mdy", True
      On Error GoTo DeuErro
   End If
   
   If vgErrDatabase Then
      'Atenção!!!
      'Ao executar o aplicativo pelo VB e ocorrer erro nesta linha, verifique se a forma de debug está corretamente definida.
      'Verifique no menu:
      'Tools->Options, na aba General, no frame "Error trapping", 
      'Selecione a opção: "Break on Unhanheld Errors"
      Error 65500
   ElseIf vgCreateDb Then
      GoTo CriaBanco
   End If
   
   Exit Sub

CriaBanco:
   On Error GoTo 0
   Call CreateDatabase
   Sleep 500
   DoEvents
   Call OpenConnection
   Exit Sub

DeuErro:
   If Err.Number = 3031 And Not vgCreateDb And Not vgWithPassword Then
      vgWithPassword = True
      Resume AbreNovamente
   ElseIf Err.Number = -2147467259 And Not vgConnectOnly Then
      If vgCreateDb Then
         Resume CriaBanco
      Else
         vgErrDatabase = True
         vgConnectOnly = True
         Resume AbreNovamente
      End If
   ElseIf Err.Number = 3024 Then                     'banco não encontrado
      If vgCreateDb Then
         Resume CriaBanco
      Else
         vgErrDatabase = True
         Resume Next
      End If
   Else
      On Error GoTo 0
      Resume
   End If

End Sub

Public Sub CloseConnection()
   On Error Resume Next
   Connection.Close
   vgDataBase.Close
   Set BDTrans = Nothing
   Set vgDataBase = Nothing
   Set Connection = Nothing
End Sub

Public Function OpenRecordSet(ByVal vgSQL As String, Optional ByVal CursorType As EnumCursorType = -1, Optional ByVal Options As Long = -1, Optional ByVal LockType As Long = -1, Optional ByVal UpdateCriteria As Long = -1, Optional ByVal SelectColumns As String, Optional ByVal TopN As Integer = -1, Optional Where As String = "", Optional OrderBy As String = "", Optional Native As Boolean = False) As GRecordSet
   Set OpenRecordSet = New GRecordSet

   'vamos definir as propriedades para abertura do recordset segundo a solicitação
   OpenRecordSet.CursorType = CursorType
   OpenRecordSet.LockType = LockType
   OpenRecordSet.Options = Options
   OpenRecordSet.UpdateCriteria = UpdateCriteria
   OpenRecordSet.SelectColumns = SelectColumns
   OpenRecordSet.Where = Where
   OpenRecordSet.OrderBy = OrderBy
   OpenRecordSet.Top = TopN

   'vamos corrigir a query para o banco específico dessa conexão
   If Not Native Then
      vgSQL$ = TrataSQL(vgSQL$, SelectColumns, TopN, Where, OrderBy)
   End If

   'abre o recordset
   OpenRecordSet.OpenRecordSet vgSQL$, Me, True
End Function

Public Sub BeginTrans()
   BdTrans.BeforeBeginTrans
   vgConnection.BeginTrans
   vgTransCount = vgTransCount + 1
   BdTrans.AfterBeginTrans
End Sub

Public Sub CommitTrans()
   BdTrans.BeforeCommitTrans
   vgConnection.CommitTrans
   vgTransCount = vgTransCount - 1
   BdTrans.AfterCommitTrans
End Sub

Public Sub RollBackTrans()
   BdTrans.BeforeRollBackTrans
   vgConnection.RollBackTrans
   vgTransCount = vgTransCount - 1
   BdTrans.AfterRollBackTrans
End Sub

Public Function Execute(ByVal vgSQL As String, Optional ByVal vgNative As Boolean, Optional ByRef vgRecordsAffected As Long) As Object
   Dim RetVal As Object
   If vgNative = False Then
      vgSQL$ = TrataSQL$(vgSQL$, "", -1, "", "")
   End If
   Set RetVal = vgConnection.Execute(vgSQL$, vgRecordsAffected)
   Set Execute = RetVal
End Function

Public Function ReservedKeywords() As String
   Dim RetVal As String
   RetVal$ = "|"
   RetVal$ = RetVal$ + "ADD|EXCEPT|PERCENT|ALL|EXEC|PLAN|ALTER|EXECUTE|PRECISION|AND|EXISTS|PRIMARY|ANY|EXIT|PRINT|"
   RetVal$ = RetVal$ + "AS|FETCH|PROC|ASC|FILE|PROCEDURE|AUTHORIZATION|FILLFACTOR|PUBLIC|BACKUP|FOR|RAISERROR|BEGIN|"
   RetVal$ = RetVal$ + "FOREIGN|READ|BETWEEN|FREETEXT|READTEXT|BREAK|FREETEXTTABLE|RECONFIGURE|BROWSE|FROM|REFERENCES|"
   RetVal$ = RetVal$ + "BULK|FULL|REPLICATION|BY|FUNCTION|RESTORE|CASCADE|GOTO|RESTRICT|CASE|GRANT|RETURN|CHECK|GROUP|"
   RetVal$ = RetVal$ + "REVOKE|CHECKPOINT|HAVING|RIGHT|CLOSE|HOLDLOCK|ROLLBACK|CLUSTERED|IDENTITY|ROWCOUNT|COALESCE|"
   RetVal$ = RetVal$ + "IDENTITY_INSERT|ROWGUIDCOL|COLLATE|IDENTITYCOL|RULE|COLUMN|IF|SAVE|COMMIT|IN|SCHEMA|COMPUTE|"
   RetVal$ = RetVal$ + "INDEX|SELECT|CONSTRAINT|INNER|SESSION_USER|CONTAINS|INSERT|SET|CONTAINSTABLE|INTERSECT|SETUSER|"
   RetVal$ = RetVal$ + "CONTINUE|INTO|SHUTDOWN|CONVERT|IS|SOME|CREATE|JOIN|STATISTICS|CROSS|KEY|SYSTEM_USER|CURRENT|"
   RetVal$ = RetVal$ + "KILL|TABLE|CURRENT_DATE|LEFT|TEXTSIZE|CURRENT_TIME|LIKE|THEN|CURRENT_TIMESTAMP|LINENO|TO|"
   RetVal$ = RetVal$ + "CURRENT_USER|LOAD|TOP|CURSOR|NATIONAL|TRAN|DATABASE|NOCHECK|TRANSACTION|DBCC|NONCLUSTERED|"
   RetVal$ = RetVal$ + "TRIGGER|DEALLOCATE|NOT|TRUNCATE|DECLARE|NULL|TSEQUAL|DEFAULT|NULLIF|UNION|DELETE|OF|UNIQUE|"
   RetVal$ = RetVal$ + "DENY|OFF|UPDATE|DESC|OFFSETS|UPDATETEXT|DISK|ON|USE|DISTINCT|OPEN|USER|DISTRIBUTED|"
   RetVal$ = RetVal$ + "OPENDATASOURCE|VALUES|DOUBLE|OPENQUERY|VARYING|DROP|OPENROWSET|VIEW|DUMMY|OPENXML|WAITFOR|"
   RetVal$ = RetVal$ + "DUMP|OPTION|WHEN|ELSE|OR|WHERE|END|ORDER|WHILE|ERRLVL|OUTER|WITH|ESCAPE|OVER|WRITETEXT|"
   RetVal$ = RetVal$ + "ABSOLUTE|OVERLAPS|ACTION|PAD|ADA|PARTIAL|EXTERNAL|PASCAL|EXTRACT|POSITION|ALLOCATE|FALSE|"
   RetVal$ = RetVal$ + "PREPARE|FIRST|PRESERVE|FLOAT|ARE|PRIOR|PRIVILEGES|FORTRAN|ASSERTION|FOUND|AT|REAL|AVG|GET|"
   RetVal$ = RetVal$ + "GLOBAL|RELATIVE|GO|BIT|BIT_LENGTH|BOTH|ROWS|HOUR|CASCADED|SCROLL|IMMEDIATE|SECOND|CAST|"
   RetVal$ = RetVal$ + "SECTION|CATALOG|INCLUDE|CHAR|SESSION|CHAR_LENGTH|INDICATOR|CHARACTER|INITIALLY|"
   RetVal$ = RetVal$ + "CHARACTER_LENGTH|SIZE|INPUT|SMALLINT|INSENSITIVE|SPACE|INT|SQL|COLLATION|INTEGER|SQLCA|"
   RetVal$ = RetVal$ + "SQLCODE|INTERVAL|SQLERROR|CONNECT|SQLSTATE|CONNECTION|SQLWARNING|ISOLATION|SUBSTRING|"
   RetVal$ = RetVal$ + "CONSTRAINTS|SUM|LANGUAGE|CORRESPONDING|LAST|TEMPORARY|COUNT|LEADING|TIME|LEVEL|TIMESTAMP|"
   RetVal$ = RetVal$ + "TIMEZONE_HOUR|LOCAL|TIMEZONE_MINUTE|LOWER|MATCH|TRAILING|MAX|MIN|TRANSLATE|DATE|MINUTE|"
   RetVal$ = RetVal$ + "TRANSLATION|DAY|MODULE|TRIM|MONTH|TRUE|DEC|NAMES|DECIMAL|NATURAL|UNKNOWN|NCHAR|DEFERRABLE|"
   RetVal$ = RetVal$ + "NEXT|UPPER|DEFERRED|NO|USAGE|NONE|USING|DESCRIBE|VALUE|DESCRIPTOR|DIAGNOSTICS|NUMERIC|"
   RetVal$ = RetVal$ + "VARCHAR|DISCONNECT|OCTET_LENGTH|DOMAIN|ONLY|WHENEVER|WORK|END-EXEC|WRITE|YEAR|OUTPUT|ZONE|"
   RetVal$ = RetVal$ + "EXCEPTION|FREE|ADMIN|GENERAL|AFTER|READS|AGGREGATE|ALIAS|RECURSIVE|GROUPING|REF|HOST|"
   RetVal$ = RetVal$ + "REFERENCING|ARRAY|IGNORE|RESULT|RETURNS|BEFORE|ROLE|BINARY|INITIALIZE|ROLLUP|ROUTINE|BLOB|"
   RetVal$ = RetVal$ + "INOUT|ROW|BOOLEAN|SAVEPOINT|BREADTH|CALL|SCOPE|SEARCH|ITERATE|LARGE|SEQUENCE|CLASS|LATERAL|"
   RetVal$ = RetVal$ + "SETS|CLOB|LESS|COMPLETION|LIMIT|SPECIFIC|SPECIFICTYPE|LOCALTIME|CONSTRUCTOR|LOCALTIMESTAMP|"
   RetVal$ = RetVal$ + "SQLEXCEPTION|LOCATOR|CUBE|MAP|CURRENT_PATH|START|CURRENT_ROLE|STATE|CYCLE|MODIFIES|STATEMENT|"
   RetVal$ = RetVal$ + "MODIFY|STATIC|STRUCTURE|TERMINATE|THAN|NCLOB|DEPTH|NEW|DEREF|DESTROY|TREAT|DESTRUCTOR|"
   RetVal$ = RetVal$ + "OBJECT|DETERMINISTIC|OLD|UNDER|DICTIONARY|OPERATION|UNNEST|ORDINALITY|OUT|DYNAMIC|EACH|"
   RetVal$ = RetVal$ + "PARAMETER|VARIABLE|EQUALS|PARAMETERS|EVERY|WITHOUT|PATH|POSTFIX|PREFIX|PREORDER|CDATE|"
   RetVal$ = RetVal$ + "ROWNUM|ALL_TABLES|OWNER|TABLE_NAME|TO_DATE|VARCHAR|FORMAT|TO_CHAR|DATE_FORMAT|SYSDATE|"
   RetVal$ = RetVal$ + "CSTR|CONCAT|MID|GETDATE|STR|LEN|VAL|IIF|ROW_NUMBER|NOW|DATEDIFF|DATEADD|ROUND|DISTINCTROW|"
   RetVal$ = RetVal$ + "DATEVALUE|CCUR|"
   ReservedKeywords$ = RetVal$
End Function

Private Function PegaPropXML(ByVal vgNode As Object, ByVal Prop As String) As String
   Dim RetVal As String
   If vgNode.Attributes.getNamedItem(Prop) Is Nothing Then
      RetVal$ = ""
   Else
      RetVal$ = vgNode.Attributes.getNamedItem(Prop).Text
   End If
   PegaPropXML = RetVal$
End Function

Private Sub LoadStruct()
   Dim vgArqEstrutura As Object, vgProjeto As Object
   Dim vgBancos As Object, vgTabelas As Object, vgQuerys As Object, vgCampos As Object, vgIndices As Object, vgRelacoes As Object
   Dim vgBanco As Object, vgTabela As Object, vgQuery As Object, vgCampo As Object, vgIndice As Object, vgRelacao As Object
   Dim vgTabelaBase As GTable, vgTabelaEst As GTable, vgCampoBase As GColumn, vgCampoEst As GColumn
   Dim vgT As String, vgQ As String, vgI As String, vgC As String, vgR As String, vgTE As String, x As String
   Dim vgColumn As GColumn                                     'campo temporário para ser adicionado o banco de campos

   Set Tables = Nothing                                        'destroi se já carregada
   Set Querys = Nothing                                        'destroi se já carregada
   Set Relations = Nothing                                     'destroi se já carregada
   
   Set Tables = New GTables                                    'e instancia a nova coleção
   Set Querys = New GQuerys                                    'e instancia a nova coleção
   Set Relations = New GRelations                              'e instancia a nova coleção
   Set Tables.Parent = Me
   Set Querys.Parent = Me
   Set Relations.Parent = Me
   
   Set vgArqEstrutura = CreateObject("Msxml.DOMDocument")

   'vamos carregar o XML para a coleção de tabelas
   vgArqEstrutura.async = False
   If vgArqEstrutura.Load(vgArqEstXML$) Then
      Set vgProjeto = vgArqEstrutura.selectSingleNode("PROJETO")
      Set vgBancos = vgProjeto.selectNodes("BANCO")
      For Each vgBanco In vgBancos
         If UCase$(PegaPropXML(vgBanco, "NOME")) = UCase$(Alias$) Then
            Set vgTabelas = vgBanco.selectNodes("TABELA")
            For Each vgTabela In vgTabelas
               vgT$ = PegaPropXML(vgTabela, "NOME")
               Tables.Add vgT$, PegaPropXML(vgTabela, "TITULO"), Val(PegaPropXML(vgTabela, "INVISIVEL")), Val(PegaPropXML(vgTabela, "SISTEMA"))
               Set vgCampos = vgTabela.selectNodes("CAMPO")
               For Each vgCampo In vgCampos
                  vgC$ = PegaPropXML(vgCampo, "NOME")
                  Tables(vgT$).Columns.Add vgC$, PegaPropXML(vgCampo, "TITULO"), PegaPropXML(vgCampo, "TIPO"), PegaPropXML(vgCampo, "MASCARA"), Val(PegaPropXML(vgCampo, "TAMANHO")), Val(PegaPropXML(vgCampo, "DECIMAL")), Val(PegaPropXML(vgCampo, "INVISIVEL")), Val(PegaPropXML(vgCampo, "NULO")), Val(PegaPropXML(vgCampo, "SISTEMA")), Val(PegaPropXML(vgCampo, "SEQINTERNO")), Val(PegaPropXML(vgCampo, "SEQUENCIA")), False, PegaPropXML(vgCampo, "DEFAULT"), True
                  Set vgColumn = Tables(vgT$).Columns(vgC$)
                  'vamos adicionar o campo ao BancoDeCampos. Se já existir, ignora o erro
                  On Error Resume Next
                  BancoDeCampos.Add vgColumn.Name, vgColumn.Title, vgColumn.ColumnType, vgColumn.Mask, vgColumn.Size, vgColumn.QDecimal, vgColumn.Hidden, vgColumn.Nullable, vgColumn.System, vgColumn.SeqInterno, vgColumn.Sequencia, vgColumn.Descending, vgColumn.Default, vgColumn.UpdatableColumn
                  On Error GoTo 0
               Next
               Set vgIndices = vgTabela.selectNodes("INDICE")
               For Each vgIndice In vgIndices
                  vgI$ = PegaPropXML(vgIndice, "NOME")
                  Tables(vgT$).Indexes.Add vgI$, PegaPropXML(vgIndice, "TITULO"), Val(PegaPropXML(vgIndice, "TIPO")), Val(PegaPropXML(vgIndice, "INVISIVEL")), Val(PegaPropXML(vgIndice, "SISTEMA")), Val(PegaPropXML(vgIndice, "CLUSTERIZADO")), Val(PegaPropXML(vgIndice, "FILLFACTOR"))
                  Set vgCampos = vgIndice.selectNodes("CAMPO")
                  For Each vgCampo In vgCampos
                     vgC$ = PegaPropXML(vgCampo, "NOME")
                     Tables(vgT$).Indexes(vgI$).Columns.Add vgC$, Tables(vgT$).Columns(vgC$).Title, Tables(vgT$).Columns(vgC$).ColumnType, Tables(vgT$).Columns(vgC$).Mask, Tables(vgT$).Columns(vgC$).Size, Tables(vgT$).Columns(vgC$).QDecimal, Tables(vgT$).Columns(vgC$).Hidden, Tables(vgT$).Columns(vgC$).Nullable, Tables(vgT$).Columns(vgC$).System, Tables(vgT$).Columns(vgC$).SeqInterno, Tables(vgT$).Columns(vgC$).Sequencia, Val(PegaPropXML(vgCampo, "DESC")), Tables(vgT$).Columns(vgC$).Default, True
                  Next
               Next
            Next
            Set vgQuerys = vgBanco.selectNodes("CONSULTA")
            For Each vgQuery In vgQuerys
               vgQ$ = PegaPropXML(vgQuery, "NOME")
               x$ = vgQuery.Text
               If IsNull(x$) Then x$ = ""
               Querys.Add vgQ$, PegaPropXML(vgQuery, "TITULO"), x$
            Next
            Set vgRelacoes = vgBanco.selectNodes("INTEGRIDADE")
            For Each vgRelacao In vgRelacoes
               vgR$ = PegaPropXML(vgRelacao, "NOME")

               'tabela base da relação
               Set vgTabelaBase = New GTable
               vgT$ = PegaPropXML(vgRelacao, "BASE")
               vgTabelaBase.Init Me, vgT$, Tables(vgT$).Title, Tables(vgT$).Hidden, Tables(vgT$).System, 0
            
               'tabela estrangeira da relação
               Set vgTabelaEst = New GTable
               vgTE$ = PegaPropXML(vgRelacao, "ESTRANGEIRA")
               vgTabelaEst.Init Me, vgTE$, Tables(vgTE$).Title, Tables(vgTE$).Hidden, Tables(vgTE$).System, 0
            
               Relations.Add vgR$, vgTabelaBase, vgTabelaEst, Val(PegaPropXML(vgRelacao, "ATUALIZA")), Val(PegaPropXML(vgRelacao, "EXCLUI")), Val(PegaPropXML(vgRelacao, "TRIGGER")), Val(PegaPropXML(vgRelacao, "INVISIVEL")), Val(PegaPropXML(vgRelacao, "TIPO")), PegaPropXML(vgRelacao, "MSG"), Val(PegaPropXML(vgRelacao, "SISTEMA"))
               Set vgCampos = vgRelacao.selectNodes("CAMPO")
               For Each vgCampo In vgCampos
               
                  'campo base da relação
                  Set vgCampoBase = New GColumn
                  vgC$ = PegaPropXML(vgCampo, "BASE")
                  vgCampoBase.Init Relations(vgR$), vgC$, vgC$, Tables(vgT$).Columns(vgC$).ColumnType, Tables(vgT$).Columns(vgC$).Mask, Tables(vgT$).Columns(vgC$).Size, Tables(vgT$).Columns(vgC$).QDecimal, Tables(vgT$).Columns(vgC$).Hidden, Tables(vgT$).Columns(vgC$).Nullable, Tables(vgT$).Columns(vgC$).System, Tables(vgT$).Columns(vgC$).SeqInterno, Tables(vgT$).Columns(vgC$).Sequencia, Tables(vgT$).Columns(vgC$).Descending, Tables(vgT$).Columns(vgC$).Default, 0, True

                  'campo estrangeiro da relação
                  Set vgCampoEst = New GColumn
                  vgC$ = PegaPropXML(vgCampo, "ESTRANGEIRO")
                  vgCampoEst.Init Relations(vgR$), vgC$, vgC$, Tables(vgTE$).Columns(vgC$).ColumnType, Tables(vgTE$).Columns(vgC$).Mask, Tables(vgTE$).Columns(vgC$).Size, Tables(vgTE$).Columns(vgC$).QDecimal, Tables(vgTE$).Columns(vgC$).Hidden, Tables(vgTE$).Columns(vgC$).Nullable, Tables(vgTE$).Columns(vgC$).System, Tables(vgTE$).Columns(vgC$).SeqInterno, Tables(vgTE$).Columns(vgC$).Sequencia, Tables(vgTE$).Columns(vgC$).Descending, Tables(vgTE$).Columns(vgC$).Default, 0, True
               
                  'adiciona campo base/estrangeiro para relação
                  vgC$ = PegaPropXML(vgCampo, "NOME")
                  Relations(vgR$).RelationColumns.Add vgC$, vgCampoBase, vgCampoEst, Val(PegaPropXML(vgCampo, "INVISIVEL")), Val(PegaPropXML(vgCampo, "SISTEMA"))
               
                  Set vgCampoBase = Nothing
                  Set vgCampoEst = Nothing
               Next
            Next
         End If
      Next
   End If

   'destroi todos os objetos instanciados
   Set vgArqEstrutura = Nothing
   Set vgProjeto = Nothing
   Set vgBancos = Nothing
   Set vgTabelas = Nothing
   Set vgCampos = Nothing
   Set vgIndices = Nothing
   Set vgQuerys = Nothing
   Set vgRelacoes = Nothing
   Set vgBanco = Nothing
   Set vgTabela = Nothing
   Set vgCampo = Nothing
   Set vgIndice = Nothing
   Set vgQuery = Nothing
   Set vgRelacao = Nothing
   Set vgCampoBase = Nothing
   Set vgCampoEst = Nothing
   Set vgTabelaBase = Nothing
   Set vgTabelaEst = Nothing
   Set vgColumn = Nothing
End Sub

Public Function TrataSQL(ByVal vgSQL As String, ByVal SelectColumns As String, ByVal TopN As Long, ByVal Where As String, ByVal OrderBy As String, Optional ByRef vgSelects As Variant, Optional ByRef NSelect As Long = 0) As String
   Dim x As String, z As String, i As Long, j As Long, ii As Long, jj As Long, vgNSelect As Long, vgPV As Boolean
   Dim vgOps As String, vgPosOper As Integer
   
   vgOps$ = "= <> > >= < <= LIKE"
   
   If NSelect = 0 Then
      vgPV = True
      ReDim vgSelects(0) As String
   Else
      vgPV = False
   End If

   'tira os tabs...
   vgSQL$ = Substitui(vgSQL$, Chr$(9), " ", SO_UM)
   
   'Vamos fazer a troca de " GetDate()" para " Date()"
   vgSQL$ = TrocaValores(vgSQL$, "GETDATE()", "DATE()")
   
   'vamos separar os UNIONS
   i = InStr(UCase$(vgSQL$), "UNION")
   If i Then
      j = InStrRev(vgSQL$, "SELECT", i)
      
      'se número de " ou ' for ímpar... vamos ignorar esse UNION
      If (Tally(Left$(vgSQL$, i - 1), Chr$(34)) And 1) = 0 And (Tally(Left$(vgSQL$, i - 1), Chr$(39)) And 1) = 0 Then
         ii = j
         Do While ii > 0
            jj = ii
            If Tally(Mid$(vgSQL$, ii, i - j), "(") <> Tally(Mid$(vgSQL$, ii, i - j), ")") Then    'se não tem mesma qtd de parânteses abrindo e fechando...
               ii = InStrRev(vgSQL$, "(", ii)
            Else
               Exit Do
            End If
         Loop
         x$ = Trim$(Mid$(vgSQL$, jj, i - jj))
         z$ = Trim$(Mid$(vgSQL$, i + 5))          'pega segunda parte do union
         If Tally(x$, "(") = Tally(x$, ")") And Tally(z$, "(") = Tally(z$, ")") Then
            'vamos ver se tem um "ALL" no início da segunda parte do UNION
            If Left$(LTrim$(Mid$(vgSQL$, i + 5)), 3) = "ALL" Then 'se tem ALL, vamos tirá-lo do início da segunda parte
               z$ = Trim$(Mid(z$, 4))
               vgSQL$ = Trim$(TrataSQL(x$, "", -1, "", "")) + vbCrLf + "UNION ALL" + vbCrLf + Trim$(TrataSQL$(z$, "", -1, "", ""))
            Else
               vgSQL$ = Trim$(TrataSQL(x$, "", -1, "", "")) + vbCrLf + "UNION" + vbCrLf + Trim$(TrataSQL$(z$, "", -1, "", ""))
            End If
            GoTo FimDaFunc
         End If
      End If
   End If

   'tira paranteses das bordas... e também crlf
   vgSQL$ = TrimAll$(vgSQL$, vbCrLf)
   Do While Left$(vgSQL$, 1) = "(" And Right$(vgSQL$, 1) = ")"
      vgSQL$ = Mid$(vgSQL$, 2, Len(vgSQL$) - 2)
   Loop
   
   vgSQL$ = Trim(vgSQL$)
   
   'vamos dividir os selects para o caso de subquerys ...
   i = 2
   Do While i > 0
      i = InStr(i, UCase$(vgSQL$), "SELECT")
      If i > 0 Then                                               'se tem a SELECT de subquery
         Do While Len(vgOps$)                                     'parse dos operadores
            x$ = Parse$(vgOps$, " ")                              'pega o operador
            vgPosOper = InStrRev(vgSQL$, x$, i)                   'pega a posição do operador na consulta, antes da SELECT de subquery
            If vgPosOper > 0 And vgPosOper < i Then               'se encontrou o operador
               Exit Do                                            'encerra o parse, mantendo a posição do último operador em vgPosOper
            End If
         Loop                                     'próximo
         If InStrRev(vgSQL$, "(", i) < vgPosOper Then 'se o primeiro parêntese aberto, antes do SELECT de subquery, estiver numa posição antes de um operador, não iremos considerar (pode ser valor de campo)
            i = i + 1                                       
            i = InStr(i, UCase$(vgSQL$), "SELECT")    'continuamos procurando por subquerys
         End If
      End If
      If i Then
         i = InStrRev(vgSQL$, "(", i)
         
         'se número de " ou ' for ímpar... vamos ignorar esse SELECT
         'se i = 0 a query esta errada... vai dar erro aqui
         If ((Tally(Left$(vgSQL$, i - 1), Chr$(34)) And 1) = 1 Or (Tally(Left$(vgSQL$, i - 1), Chr$(39)) And 1) = 1) Then
            i = i + 1
         Else
            j = i
            Do While j > 0
               j = InStr(j, vgSQL$, ")")
               If j Then                              'encontrou um parênteses fechando...
                  If Tally(Mid$(vgSQL$, i, j - i + 1), "(") = Tally(Mid$(vgSQL$, i, j - i + 1), ")") Then
                     NSelect = NSelect + 1
                     vgNSelect = NSelect
                     ReDim Preserve vgSelects(vgNSelect) As String
                     vgSelects(vgNSelect) = TrataSQL(Trim$(Mid$(vgSQL$, i + 1, j - i - 1)), "", -1, "", "", vgSelects, NSelect)
                     vgSQL$ = Left$(vgSQL$, i) + "{" + CStr(vgNSelect) + "}" + Mid$(vgSQL$, j)
                     j = 0
                  Else
                     j = j + 1
                  End If
               End If
            Loop
         End If
      End If
   Loop
   
   'faz o tratamento específico para cada banco
   Select Case vgDataBaseType
      Case DB_SQL
         vgSQL$ = TrataSQLSQLServer(vgSQL$, SelectColumns, TopN, Where, OrderBy)
   End Select
   
'vamos substituir sub-querys na query principal
   If vgPV Then                                       'só vamos juntar tudo no primeiro nível de select....
      For i = 1 To UBound(vgSelects)
         If InStr(UCase$(vgSQL$), "INSERT ") Then
            vgSQL$ = Substitui(vgSQL$, "({" + CStr(i) + "})", IdentSelect(vgSelects(i), i), SO_UM)
         Else
            vgSQL$ = Substitui(vgSQL$, "{" + CStr(i) + "}", IdentSelect(vgSelects(i), i), SO_UM)
         End If
      Next
   End If
   
FimDaFunc:
   vgSQL$ = Trim$(Substitui$(vgSQL$, Chr$(32) + vbCrLf$ + Chr$(32), vbCrLf, SO_UM))
   
   Do While Right$(vgSQL$, 2) = vbCrLf
      vgSQL$ = Left$(vgSQL$, Len(vgSQL$) - 2)
   Loop

   TrataSQL = vgSQL$
End Function

Private Function TrimAll(ByVal St As String, ByVal TrimChars As String) As String
   Dim RetVal As String, i As Integer

   RetVal$ = Trim$(St$)

OutraVez:
   For i = 1 To Len(TrimChars)
      If Left$(RetVal$, 1) = Mid$(TrimChars$, i, 1) Then
         RetVal$ = Mid$(RetVal$, 2)
         GoTo OutraVez
      End If
      If Right$(RetVal$, 1) = Mid$(TrimChars$, i, 1) Then
         RetVal$ = Left$(RetVal$, Len(RetVal$) - 1)
         GoTo OutraVez
      End If
   Next
   
   TrimAll = RetVal$
End Function

'vamos identar select segundo seu nível hierárquico dentro da query principal
Private Function IdentSelect(ByVal vgSQL As String, ByVal vgIdent As Integer) As String
   Dim vgRetVal As String, i As Integer, x As String
   vgSQL$ = TrimAll(vgSQL$, vbCrLf + " ") + vbCrLf
   vgRetVal$ = ""
   For i = 1 To Tally(vgSQL$, vbCrLf)
      x$ = TrimAll(Parse$(vgSQL$, vbCrLf, i), vbCrLf + " ")
      If Left$(x$, 1) <> "{" Then x$ = Space$(vgIdent) + x$
      vgRetVal$ = vgRetVal$ + x$ + vbCrLf
   Next
   IdentSelect = Left$(vgRetVal$, Len(vgRetVal$) - 2)
End Function

'converte o tipo do índice do banco de dados para a estrutura da GIndex
Public Function ConvIndexTypeByTypeName(vgTipo As String) As INDEX_TYPE
   Select Case UCase$(vgTipo$)
      Case "P"
         ConvIndexTypeByTypeName = TYPE_Primary
      Case "UNIQUE"
         ConvIndexTypeByTypeName = TYPE_Unique
      Case "NONUNIQUE"
         ConvIndexTypeByTypeName = TYPE_Normal
   End Select
End Function

'converte o nome do tipo do campo em uma constante de GCOLUMN_TYPE
'obs.: Os tipos TP_LOGICO e TP_MEMO, se o banco for diferente de SQL Server, dependem do tamanho que deve ser verificado externamente
Public Function ConvFieldTypeByTypeName(vgTipo As String) As GCOLUMN_TYPE
   If InStr(vgTipo$, "(") > 0 Then
      vgTipo$ = Left$(vgTipo$, InStr(vgTipo$, "(") - 1)
   End If
   Select Case UCase$(vgTipo$)
      Case "NUMBER", "INT", "SMALLINT", "DECIMAL", "SHORT", "INT64", "LONG", "BIGINT"
         ConvFieldTypeByTypeName = TP_NUMERICO
      Case "VARCHAR", "VARCHAR2", "VARYING"
         ConvFieldTypeByTypeName = TP_CARACTER
      Case "LONG RAW", "BLOB", "LONGBLOB", "IMAGE"
         ConvFieldTypeByTypeName = TP_BINARIO
      Case "DATE", "TIMESTAMP", "DATETIME"
         ConvFieldTypeByTypeName = TP_DATA_HORA
      Case "TEXT"
         ConvFieldTypeByTypeName = TP_MEMO
      Case "BIT", "TINYINT"
         ConvFieldTypeByTypeName = TP_LOGICO
   End Select
End Function

Public Function ConvFieldNullable(vgNullable As String) As Boolean
   Select Case vgNullable
      Case "Y"
         ConvFieldNullable = True
      Case "N"
         ConvFieldNullable = False
   End Select
End Function
Public Function GetFieldDefDb(vgCp As GColumn, Optional vgDelim As String) As String
   'faz o tratamento específico para cada banco
   Select Case vgDataBaseType
      Case DB_SQL
         GetFieldDefDb = GetFieldDefDbSQL(vgCp, vgDelim) 
   End Select
End Function

Private Function GetFieldDefDbSQL(vgCp As GColumn, Optional vgDelim As String) As String
   Dim RetVal As String
   Select Case vgCp.ColumnType
      Case TP_CARACTER
         GetFieldDefDbSQL = RPad("varchar (" + CStr(vgCp.Size) + ")", 20, " ")
      Case TP_LOGICO
         GetFieldDefDbSQL = RPad("bit", 20, " ")
      Case TP_BINARIO
         GetFieldDefDbSQL = RPad("image", 20, " ")
      Case TP_MEMO
         GetFieldDefDbSQL = RPad("text", 20, " ")
      Case TP_DATA_HORA
         GetFieldDefDbSQL = RPad("datetime", 20, " ")
      Case TP_NUMERICO
         If vgCp.QDecimal > 0 Then
            GetFieldDefDbSQL = RPad("Decimal (" + CStr(vgCp.Size) + ", " + CStr(vgCp.QDecimal) + ")", 20, " ")
         Else
            If vgCp.Size < 5 Then
               GetFieldDefDbSQL = RPad("smallint", 20, " ")
            ElseIf vgCp.Size < 10 Then
               GetFieldDefDbSQL = RPad("int", 20, " ")
            Else
               GetFieldDefDbSQL = RPad("bigint", 20, " ")
            End If
         End If
   End Select
   If vgCp.Parent.System Then
      If vgCp.ColumnType = TP_CARACTER Then
         GetFieldDefDbSQL = GetFieldDefDbSQL + vgDelim + RPad("COLLATE SQL_Latin1_General_CP1_CI_AS  DEFAULT ''", 50, " ")
      ElseIf vgCp.ColumnType = TP_NUMERICO Then
         GetFieldDefDbSQL = GetFieldDefDbSQL + vgDelim + RPad("DEFAULT 0", 50, " ")
      Else
         GetFieldDefDbSQL = GetFieldDefDbSQL + vgDelim + RPad("COLLATE SQL_Latin1_General_CP1_CI_AS", 50, " ")
      End If
   Else
      If (vgCp.ColumnType = TP_CARACTER Or vgCp.ColumnType = TP_MEMO) And Not vgCp.SeqInterno Then
         If Len(vgCp.Default) > 0 Then
            GetFieldDefDbSQL = GetFieldDefDbSQL + vgDelim + RPad("DEFAULT " + vgCp.Default, 20, " ")
         ElseIf Not vgCp.Nullable Then
            GetFieldDefDbSQL = GetFieldDefDbSQL + vgDelim + RPad("DEFAULT ''", 20, " ")
         End If
      ElseIf (vgCp.ColumnType = TP_NUMERICO Or vgCp.ColumnType = TP_LOGICO) And Not vgCp.SeqInterno Then
         If Len(Trim(vgCp.Default)) > 0 Then
            GetFieldDefDbSQL = GetFieldDefDbSQL + vgDelim + RPad("DEFAULT " + vgCp.Default, 20, " ")
         ElseIf Not vgCp.Nullable Then
            GetFieldDefDbSQL = GetFieldDefDbSQL + vgDelim + RPad("DEFAULT 0", 20, " ")
         End If
      Else
         If Len(vgCp.Default) > 0 And Not vgCp.SeqInterno Then
            GetFieldDefDbSQL = GetFieldDefDbSQL + vgDelim + RPad("DEFAULT " + vgCp.Default, 20, " ")
         End If
      End If
   End If
   GetFieldDefDbSQL = GetFieldDefDbSQL + vgDelim + RPad(IIf(vgCp.Nullable, " NULL ", " NOT NULL "), 20, " ")
   If vgCp.SeqInterno Then
      GetFieldDefDbSQL = GetFieldDefDbSQL + vgDelim + "IDENTITY(1, " + CStr(vgCp.Sequencia) + ") NOT FOR REPLICATION"
   End If
   RetVal = GetFieldDefDbSQL
End Function

Private Function Maior(ParamArray vgValor() As Variant) As Single
   Dim i As Integer, vgRetVal As Single
   For i = 0 To UBound(vgValor)
      If vgRetVal < vgValor(i) Then vgRetVal = vgValor(i)
   Next
   Maior = vgRetVal
End Function

Private Function TrataSQLSQLServer(ByVal vgSQL As String, ByVal vgSelectColumns As String, ByVal TopN As Long, ByVal Where As String, ByVal OrderBy As String) As String
   Dim vgRetVal As String, x As String, xx As String, z As String, zz As String, i As Long, j As Long, k As String, p As Long, vgCp As String, vgCps As String, vgOp As String, _
       vgOp1 As String, y As Long, vgValorParam As String, vgStrTemp As String

   vgRetVal$ = vgSQL$
   
   x$ = UCase$(Left$(Substitui(vgRetVal$, vbCrLf, Chr$(32) + Chr$(32), UM_A_UM), 7))

   'Não altere stored procedure
   If Left(x$, 5) = "EXEC " OR Left(UCase(vgRetVal$), 8) = "EXECUTE " Then 
      GoSub FimDaSub
   End If
   
   If x$ <> "SELECT " And x$ <> "DELETE " And x$ <> "UPDATE " And x$ <> "INSERT " Then
      x$ = PoeColchetes(vgRetVal$)
      vgRetVal$ = "SELECT"
      vgRetVal$ = vgRetVal$ + " * FROM " + x$
   ElseIf x$ = "DELETE " Then
      If Mid$(vgRetVal$, 8, 1) = "*" Then
         vgRetVal$ = Trim$(Left(vgRetVal$, 7)) + " " + Trim$(Mid$(vgRetVal$, 9))
      End If
   End If
   If Len(vgSelectColumns) > 0 And Trim$(vgSelectColumns) <> "*" Then
      x$ = ExtraiSQL$(vgRetVal$, EXP_SELECT, False)
      i = InStr(UCase$(x$), "TOP ")
      If i > 0 Then
         x$ = " " + Mid(x$, i)
      Else
         x$ = ""
      End If
      vgRetVal$ = InsereSQL(vgRetVal$, EXP_SELECT, vgSelectColumns + x$)
   End If
   If TopN <> -1 Then
      x$ = ExtraiSQL$(vgRetVal$, EXP_SELECT)
      If UCase$(Left$(x$, 4)) = "TOP " Then
         x$ = Trim$(Mid$(x$, 5))
         x$ = Trim$(Mid$(x$, InStr(x$, Chr(32)) + 1))
         vgRetVal$ = InsereSQL(vgRetVal$, EXP_SELECT, x$)
      End If
      If TopN > 0 Then
         vgRetVal$ = InsereSQL(vgRetVal$, EXP_SELECT, "TOP " + CStr(TopN) + " " + x$)
      End If
   End If
   If Len(Where) > 0 Then
      vgRetVal$ = InsereSQL(vgRetVal$, EXP_WHERE, Where)
   End If
   If Len(OrderBy) > 0 Then
      vgRetVal$ = InsereSQL(vgRetVal$, EXP_ORDERBY, OrderBy)
   End If

   'vamos corrigir prováveis querys incorretas que referenciam os campos com ! ao invéz de .
   j = 1
   Do
      i = InStr(j, vgRetVal$, "!")
      If i Then
         If (Tally(Left(vgRetVal$, i - 1), Chr(34)) And 1) = 0 And (Tally(Left(vgRetVal$, i - 1), Chr(39)) And 1) = 0 Then
            Mid(vgRetVal$, i, 1) = "."
         End If
         j = i + 1
      End If
   Loop Until i = 0

   'Vamos fazer a troca de " Date()" para " GetDate()"
   vgRetVal$ = TrocaValores(vgRetVal$, "DATE()", "GETDATE()")

   'Vamos fazer a troca de "xtrue" para "1"
   vgRetVal$ = TrocaValores(vgRetVal$, "TRUE", "1")

   'Vamos fazer a troca de "xfalse" para "0"
   vgRetVal$ = TrocaValores(vgRetVal$, "FALSE", "0")
   

   'Vamos fazer algumas correções na query para SQL ou ORACLE
   vgRetVal$ = TrataNull(vgRetVal$)

   'ajusta o like * ou %
   x$ = "LIKE "
   j = InStr(UCase$(vgRetVal$), x$)
   If j > 0 Then
      vgRetVal$ = Left$(vgRetVal$, j) + Substitui(Mid$(vgRetVal$, j + 1), "*", "%", UM_A_UM)
   End If

   '*** conversão a função CDATE()
   k$ = "CDATE("

OutraData:
   j = InStr(UCase$(vgRetVal$), k$)                        'posição da função na query
   If j > 0 Then                                           'se tem a função CDate()
      vgStrTemp$ = Mid$(vgRetVal$, j + Len(k$))             
      y = InStr(vgStrTemp$, ")") - 1
      vgValorParam$ = Retira$(LTrim$(Mid$(vgStrTemp$, 1, y)), "'", SO_UM)
      vgValorParam$ = Format(vgValorParam$, "yyyy-mm-dd hh:mm:ss") 'formata a data
      vgRetVal$ = Left$(vgRetVal$, j - 1) + "CONVERT(VARCHAR, '" + vgValorParam$ + "'" + ", 120" + Mid(vgRetVal, InStr(j + Len(k$), vgRetVal$, ")"))
      GoTo OutraData
   End If
   
   '*** conversão da função FORMAT()
   k$ = "FORMAT("

OutroFormat:
   j = InStr(UCase$(vgRetVal$), k$)
   If j > 0 Then
      y = j - 1
      vgRetVal$ = Left$(vgRetVal$, y) + "LEFT(CONVERT(VARCHAR, " + Mid$(vgRetVal$, j + Len(k$))
      j = j + 22
      j = InStr(j, vgRetVal$, ",")
      If j > 0 Then
         p = InStr(j, vgRetVal$, ")")
         If p > 0 Then
            z$ = Trim$(Mid$(vgRetVal$, j + 1, p - j - 1))
            If InStr(z$, "-") = 0 And InStr(z$, "/") = 0 Then
               vgRetVal$ = Left$(vgRetVal$, j - 1) + ", 120)" + ", " + CStr(Len(z$) - 2) + Mid$(vgRetVal$, p)
               vgRetVal$ = Left$(vgRetVal$, y) + "RIGHT" + Mid$(vgRetVal$, y + 5)
            Else
               vgRetVal$ = Left$(vgRetVal$, j - 1) + ", 120)" + ", " + CStr(Len(z$) - 2) + Mid$(vgRetVal$, p)
            End If
         End If
      End If
      GoTo OutroFormat
   End If

   'vamos colocar todos os objetos (nomes campos/tabelas) entre ""
   vgRetVal$ = TrataNomes(vgRetVal$, "[", "]")

FimDaSub:
   TrataSQLSQLServer = vgRetVal$
End Function

Private Function TrataNomes(vgSQL As String, vgDeliIni As String, vgDeliFim As String) As String
   Dim vgRetVal As String, p As Long, i As Long, ii As Long, x As String, j As Long, k As String
   On Error GoTo DeuErro
   
   'vamos colocar todos os objetos (nomes campos/tabelas) entre ""
   vgRetVal$ = Chr$(32) + Substitui$(vgSQL$, vbCrLf, Chr$(32) + vbCrLf$ + Chr$(32), SO_UM) + Chr$(32)
   
   p = 1
   Do
   
      'vamos verificar quem ocorre primeiro...
      x$ = "!(),.+-*/<>= "
      i = 0
      For j = 1 To Len(x)
         ii = InStr(p + 1, vgRetVal$, Mid$(x$, j, 1))
         If (i = 0 Or ii < i) And ii <> 0 Then
            i = ii
         End If
      Next
      
      x$ = ""
      Do While i > 0 And Len(x$) = 0
         x$ = Mid$(vgRetVal$, p + 1, i - p - 1)
         If Len(Trim$(x$)) = 0 Then
            p = i                                           'nova posição para início...
            
            'vamos verificar quem ocorre primeiro...
            x$ = "!(),.+-*/<>= "
            i = 0
            For j = 1 To Len(x)
               ii = InStr(p + 1, vgRetVal$, Mid$(x$, j, 1))
               If (i = 0 Or ii < i) And ii <> 0 Then
                  i = ii
               End If
            Next
            
            x$ = ""
         
         ElseIf (Left$(x$, 1) = "[" And Right(x$, 1) <> "]") Or Left$(x$, 1) = Chr$(34) Or Left$(x$, 1) = "#" Or Left$(x$, 1) = "'" Or Left$(x$, 1) = "{" Or Left$(x$, 1) = "|" Then
            x$ = Left$(x$, 1)
            If x$ = "[" Then
               i = InStr(p + 2, vgRetVal$, "]") + 1
            ElseIf Left$(x$, 1) = "{" Then
               i = InStr(p + 2, vgRetVal$, "}") + 1
               p = i - 1                                    'vamos ignorar essa sentença e continuar a procura
            Else
               i = InStr(p + 2, vgRetVal$, x$) + 1
               p = i - 1                                    'vamos ignorar essa sentença e continuar a procura
            End If
            x$ = ""
         End If
      Loop
            
      If x$ <> vbCrLf And InStr("(),<>=+-*/&% ", x$) = 0 And Right(x$, 2) <> "%'" Then
         If Left$(x$, 1) = "[" And Right$(x$, 1) = "]" Then
            k$ = GetFieldNameShort(Mid(x$, 2, Len(x$) - 2))
            vgRetVal$ = Left$(vgRetVal$, p) + vgDeliIni + k$ + vgDeliFim + Mid$(vgRetVal$, i)
            i = i - (Len(x$) - Len(k$)) + 2
         Else
            If CStr(Val(x$)) <> CStr(x$) And LPad(CStr(Val(x$)), Len(x$), "0") <> x$ Then
               If InStr(ReservedKeywords, "|" + UCase$(x$) + "|") = 0 Then
                  k$ = GetFieldNameShort(x$)
                  vgRetVal$ = Left$(vgRetVal$, p) + vgDeliIni + k$ + vgDeliFim + Mid$(vgRetVal$, i)
                  i = i - (Len(x$) - Len(k$)) + 2
               End If
            End If
         End If
      End If
      
      p = i
   Loop Until p = 0

DeuErro:

FimDaSub:

   TrataNomes = vgRetVal
End Function

