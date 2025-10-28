VERSION 1.0 CLASS
BEGIN
      MultiUse = -1                                       'True
END
Attribute VB_Name = "DBox"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
'Classe para mostrar mensagens genéricas das aplicações

Public Titulo As String
Public Description As String
Public Mensagem As String
Public Tipo As Long
Public Fatal As Boolean
Public Bloqueado As Boolean
Public Origem As String
Public vgOcultarDetalhe As Boolean

Dim vgNumErro As Long
Dim vgFunctionName As String

'enum para tipo da dbox
Public Enum TipoDbox
   Erro = 32513                                   'numero do icone no stock
   Pergunta = 32514
   Exclama = 32515
   Informa = 32516
End Enum

'método para mostrar a caixa de mensagem
Public Sub Show(Optional ByVal Modo As TipoDbox)
   Tipo = IIf(IsMissing(Modo), Erro, Modo)        'o tipo da caixa vem neste método: Dbox.Show Tipo
   Tipo = IIf(Tipo = 0, Erro, Tipo)
   frmMsgErros.Show vbModal                       'mostra form de mensagem
End Sub

'inicializa valores default
Private Sub Class_Initialize()
   Titulo = vgAtencao$                            'propriedade default para título = tit aplicação
   Tipo = Erro                                    'default = erro crít
   Mensagem = ""
End Sub

'Ocultar os Detalhes - pega
Public Property Get OcultarDetalhe() As Long
   OcultarDetalhe = vgOcultarDetalhe
End Property

Public Property Let OcultarDetalhe(ByVal NewOcultar As Long)
   vgOcultarDetalhe = NewOcultar
End Property

'controle principal - pega
Public Property Get NumErro() As Long
   NumErro = vgNumErro
End Property

'controle que será o título - coloca
Public Property Let NumErro(ByVal New_Erro As Long)
   vgNumErro = New_Erro

   'registro bloqueado por outro usuário
   Bloqueado = (vgNumErro = 3046 Or vgNumErro = 3158 Or vgNumErro = 3186 Or vgNumErro = 3187 Or _
                vgNumErro = 3188 Or vgNumErro = 3189 Or vgNumErro = 3218 Or vgNumErro = 3260)

   If Err.Number = New_Erro Then
      Description = Err.Description
      Origem = Err.Source
   End If
End Property

Public Property Get FunctionName() As String
   FunctionName = vgFunctionName
End Property

Public Property Let FunctionName(ByVal New_FunctionName As String)
   vgFunctionName = New_FunctionName
End Property
