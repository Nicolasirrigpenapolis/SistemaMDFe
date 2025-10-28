VERSION 1.0 CLASS
BEGIN
      MultiUse = -1                               'True
END
Attribute VB_Name = "MAPIClass"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
DefInt A-Z

Private Type MAPIAttach
   Index As Integer
   Name As String
   PathName As String
End Type

Private Type MAPIRecipient
   Index As Integer
   Address As String
   DisplayName As String
   Type As Integer
End Type

Public Enum MAPIRecipientType
   MAPI_Dest_TO = 1
   MAPI_Dest_CC = 2
   MAPI_Dest_CCO = 3
End Enum

Dim Attachments() As MAPIAttach, Recipients() As MAPIRecipient, CounterAtt As Integer, CounterRec As Integer, _
            vgSubject As String, vgMessage As String, DeuErro As String

Public Property Let Assunto(NovoAssunto As String)
   vgSubject$ = NovoAssunto$
End Property

Public Property Get Assunto() As String
   Assunto$ = vgSubject$
End Property

Public Property Let Mensagem(NovaMensagem As String)
   vgMessage = NovaMensagem$
End Property

Public Property Get Mensagem() As String
   Mensagem$ = vgMessage$
End Property

Public Property Get Erro() As String
   Erro$ = DeuErro$
End Property

Public Sub IncluiDestinatario(ByVal vgDestEMail As String, Optional ByVal vgDestNome As String, Optional ByVal vgDestTipo As MAPIRecipientType = MAPI_Dest_TO)
   CounterRec = CounterRec + 1
   ReDim Preserve Recipients(CounterRec) As MAPIRecipient
   Recipients(CounterRec).Index = CounterRec - 1
   Recipients(CounterRec).Address = vgDestEMail$
   Recipients(CounterRec).DisplayName = vgDestNome$
   Recipients(CounterRec).Type = vgDestTipo                                   '1=TO, 2=CC, 3=CCO
End Sub

Public Sub LimpaDestinatarios()
   CounterRec = 0
   ReDim Recipients(0) As MAPIRecipient
End Sub

Public Sub IncluiAttach(ByVal vgArquivo As String)
   Dim i As Integer
   For i = Len(vgArquivo$) To 1 Step -1
      If Mid(vgArquivo$, i, 1) = "\" Then
         Exit For
      End If
   Next
   CounterAtt = CounterAtt + 1
   ReDim Preserve Attachments(CounterAtt) As MAPIAttach
   Attachments(CounterAtt).Index = CounterAtt - 1
   Attachments(CounterAtt).Name = Mid(vgArquivo$, i + 1)
   Attachments(CounterAtt).PathName = vgArquivo$
End Sub

Public Sub LimpaAttachs()
   CounterAtt = 0
   ReDim Attachments(0) As MAPIAttach
End Sub

Public Sub EnviaEMail()
   Dim objSession As MAPISession, objMessage As MAPIMessages, i As Long
   On Error GoTo DeuErro
   
   DeuErro$ = ""
   
   'Create the Session Object
   Set objSession = frmEnviaEMail.MAPISession

   objSession.NewSession = True
   objSession.SignOn
      
   'Add a new message object to the OutBox
   Set objMessage = frmEnviaEMail.MAPIMessages
   
   objMessage.SessionID = objSession.SessionID

   objMessage.Compose
   
   objMessage.MsgSubject = vgSubject$
   
   If CounterRec >= 1 Then
      For i = 1 To CounterRec
         objMessage.MsgIndex = -1
         objMessage.RecipIndex = Recipients(i).Index
         objMessage.RecipAddress = Recipients(i).Address
         objMessage.RecipDisplayName = Recipients(i).DisplayName
         objMessage.RecipType = Recipients(i).Type
      Next
   End If
   
   If CounterAtt >= 1 Then
      For i = 1 To CounterAtt
         objMessage.MsgIndex = -1
         objMessage.AttachmentIndex = Attachments(i).Index
         objMessage.AttachmentName = Attachments(i).Name
         objMessage.AttachmentPathName = Attachments(i).PathName
         objMessage.AttachmentType = 0
      Next
   End If
   
   objMessage.MsgNoteText = vgMessage$

   objMessage.Send True
   
   objSession.SignOff
   
DeuErro:
   If Err.Number <> 0 Then
      i = CStr(Err.Number)
      DeuErro$ = Err.Description
      DeuErro$ = LoadGasString(9200) + CStr(i) + vbCrLf + LoadGasString(9202) + DeuErro$
      Err.Clear
   End If
   Set objSession = Nothing
   Set objMessage = Nothing
End Sub
