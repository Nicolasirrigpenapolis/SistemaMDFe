VERSION 1.0 CLASS
BEGIN
      MultiUse = -1                                       'True
      Persistable = 0                                     'NotPersistable
      DataBindingBehavior = 0                             'vbNone
      DataSourceBehavior  = 0                             'vbNone
      MTSTransactionMode  = 0                             'NotAnMTSObject
END
Attribute VB_Name = "GColumn"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Enum GCOLUMN_TYPE
   TP_CARACTER = 0                                        'carcarter
   TP_NUMERICO = 1                                        'numerico
   TP_DATA_HORA = 2                                       'data/hora
   TP_MEMO = 3                                            'memo
   TP_LOGICO = 4                                          'logico
   TP_BINARIO = 5                                         'binario
End Enum

Private vgParent As Object
Private vgName As String, vgValue As Variant, vgHasChange As Boolean, vgIndex As Long, vgTitle As String, vgColumnType As GCOLUMN_TYPE, vgColumnTypeName As String, vgMask As String, vgSize As Double, vgQDecimal As Integer, vgHidden As Boolean, vgNullable As Boolean, vgSystem As Boolean, vgSeqInterno As Boolean, vgSequencia As Long, vgDescending As Boolean, vgDefault As String, vgUpdatableColumn As Boolean, vgBaseColumnName As String

Public Property Get Name() As String
Attribute Name.VB_UserMemId = 0
   Name = vgName
End Property

Public Property Let Name(NewName As String)
   vgName = NewName
End Property

Public Property Get Value() As Variant
   Value = vgValue
End Property

Public Property Let Value(NewValue As Variant)
   If vgValue & "" <> NewValue & "" Then vgHasChange = True
   vgValue = NewValue
End Property

Public Property Get HasChange() As Boolean
   HasChange = vgHasChange
End Property

Public Property Let HasChange(NewHasChange As Boolean)
   vgHasChange = NewHasChange
End Property

Public Property Get NameFilter() As String
      NameFilter = vgBaseColumnName
End Property

Public Property Let NameFilter(NewNameFilter As String)
      vgBaseColumnName = NewNameFilter
End Property

Public Property Get Index() As String
   Index = vgIndex
End Property

Public Property Let Index(NewIndex As String)
   vgIndex = NewIndex
End Property

Public Property Get Title() As String
   Title = vgTitle
End Property

Public Property Let Title(NewTitle As String)
   vgTitle = NewTitle
End Property

Public Property Get Mask() As String
   Mask = vgMask
End Property

Public Property Let Mask(NewMask As String)
   vgMask = NewMask
End Property

Public Property Get ColumnType() As GCOLUMN_TYPE
   ColumnType = vgColumnType
End Property

Public Property Let ColumnType(NewColumnType As GCOLUMN_TYPE)
   vgColumnType = NewColumnType
End Property

Public Property Get ColumnTypeName() As String
   ColumnTypeName = vgColumnTypeName
End Property

Public Property Get Size() As Double
   Size = vgSize
End Property

Public Property Let Size(NewSize As Double)
   vgSize = NewSize
End Property

Public Property Get QDecimal() As Integer
   QDecimal = vgQDecimal
End Property

Public Property Let QDecimal(NewQDecimal As Integer)
   vgQDecimal = NewQDecimal
End Property

Public Property Get Hidden() As Boolean
   Hidden = vgHidden
   If InStr(vgName, "~") Then Hidden = True
End Property

Public Property Let Hidden(NewHidden As Boolean)
   vgHidden = NewHidden
End Property

Public Property Get Nullable() As Boolean
   Nullable = vgNullable
End Property

Public Property Let Nullable(NewNullable As Boolean)
   vgNullable = NewNullable
End Property

Public Property Get System() As Boolean
   System = vgSystem
End Property

Public Property Let System(NewSystem As Boolean)
   vgSystem = NewSystem
End Property

Public Property Get SeqInterno() As Boolean
   SeqInterno = vgSeqInterno
End Property

Public Property Let SeqInterno(NewSeqInterno As Boolean)
   vgSeqInterno = NewSeqInterno
End Property

Public Property Get Sequencia() As Long
   Sequencia = vgSequencia
End Property

Public Property Let Sequencia(NewSequencia As Long)
   vgSequencia = NewSequencia
End Property

Public Property Get Descending() As Boolean
   Descending = vgDescending
End Property

Public Property Let Descending(NewDescending As Boolean)
   vgDescending = NewDescending
End Property

Public Property Get Parent() As Object
   Set Parent = vgParent
End Property

Public Property Set Parent(NewParent As Object)
   Set vgParent = NewParent
End Property

Public Property Get Default() As String
   Default = vgDefault
End Property

Public Property Let Default(NewDefault As String)
   vgDefault = NewDefault
End Property

Public Property Get UpdatableColumn() As Boolean
   UpdatableColumn = vgUpdatableColumn
End Property

Public Property Let UpdatableColumn(NewUpdatableColumn As Boolean)
   vgUpdatableColumn = NewUpdatableColumn
End Property

Friend Function Init(ByRef NewParent As Object, ByVal NewName As String, ByVal NewTitle As String, ByVal NewColumnType As Variant, ByVal NewMask As String, ByVal NewSize As Double, ByVal NewQDecimal As Integer, ByVal NewHidden As Boolean, ByVal NewNullable As Boolean, ByVal NewSystem As Boolean, ByVal NewSeqInterno As Boolean, ByVal NewSequencia As Long, ByVal NewDescending As Boolean, ByVal NewDefault As String, ByVal NewIndex As Long, ByVal NewUpdatableColumn As Boolean, Optional ByVal NewBaseColumnName As String) As Boolean
   Set vgParent = NewParent
   vgName = NewName
   If Len(NewTitle) = 0 Then
      vgTitle = NewName
   Else
      vgTitle = NewTitle
   End If
   If IsNumeric(NewColumnType) Then
      vgColumnTypeName = GetFieldTypeName(NewColumnType)
      vgColumnType = Val(NewColumnType)
   Else
      vgColumnTypeName = NewColumnType
      vgColumnType = GetFieldType(NewColumnType)
   End If
   vgBaseColumnName = NewBaseColumnName
   vgMask = NewMask
   vgSize = NewSize
   vgQDecimal = NewQDecimal
   vgHidden = NewHidden
   vgNullable = NewNullable
   vgSystem = NewSystem
   vgSeqInterno = NewSeqInterno
   vgSequencia = NewSequencia
   vgDescending = NewDescending
   vgDefault = NewDefault
   vgIndex = NewIndex
   vgUpdatableColumn = NewUpdatableColumn
   vgHasChange = False
   Init = True
End Function

Private Function GetFieldType(ByVal vgType As String) As GCOLUMN_TYPE
   Dim vgRetVal As GCOLUMN_TYPE
   Select Case UCase$(vgType)
      Case "TEXTO"
         vgRetVal = TP_CARACTER
      Case "LOGICO"
         vgRetVal = TP_LOGICO
      Case "IMAGEM"
         vgRetVal = TP_BINARIO
      Case "MEMO"
         vgRetVal = TP_MEMO
      Case "DATA"
         vgRetVal = TP_DATA_HORA
      Case "NUMERICO"
         vgRetVal = TP_NUMERICO
   End Select
   GetFieldType = vgRetVal
End Function

Private Function GetFieldTypeName(ByVal vgType As GCOLUMN_TYPE) As String
   Dim vgRetVal As String
   Select Case vgType
      Case TP_CARACTER
         vgRetVal = "TEXTO"
      Case TP_LOGICO
         vgRetVal = "LOGICO"
      Case TP_BINARIO
         vgRetVal = "IMAGEM"
      Case TP_MEMO
         vgRetVal = "MEMO"
      Case TP_DATA_HORA
         vgRetVal = "DATA"
      Case TP_NUMERICO
         vgRetVal = "NUMERICO"
   End Select
   GetFieldTypeName = vgRetVal
End Function

Public Function GetTypeDb(ByVal vgType As String) As GCOLUMN_TYPE
   Dim vgTp As GCOLUMN_TYPE
   Select Case vgType
      Case 129, 200, 130, 202                            'se for caracter/memo(adChar, adVarChar, adWChar, adVarWChar)
         vgTp = TP_CARACTER
      Case 201, 203                                      '( adLongVarChar, adLongVarWChar) MEMO
         vgTp = TP_MEMO
      Case 7, 135                                        'se for data (adDate, adDBTimeStamp)
         vgTp = TP_DATA_HORA
      Case 11                                            'se for lógico (adBoolean)
         vgTp = TP_LOGICO
      Case 205                                           'se for imagem/multimídia (adLongVarBinary)
         vgTp = TP_BINARIO
      Case Else                                          'se for númerico
         vgTp = TP_NUMERICO
         End Select
      GetTypeDb = vgTp
End Function
