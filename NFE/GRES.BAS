Attribute VB_Name = "modResources"
'* Sistema...: Emissor de MDF-e (Layout 3.00)
'* Empresa...: Ygor Eduardo Dellalio
'* Módulo....: GRES.BAS
'* Função....: Módulo de funções para resource
'* CopyRight.: (C)2024 Ygor Eduardo Dellalio
'* Criação...: GAS-2007 - Gerador Automático de Sistemas
'* Data......: 05/09/2024 18:10:18
'* * * * * * *

Option Explicit                                   'requer variáveis explicitamente declaradas
DefInt A - Z                                      'inteiras, por default

Private ResCollection As New Collection
Private vghRes As Integer, vgArqFig As String

'Calcula o código hash de uma string
'Retorna uma entrada válida dentro da tabela hashing
Public Function Hash(nn As Long) As Long
   Dim Rp As Long
   Rp = nn * FATOR_HASH
   Rp = Rp - (Int(Rp / vgQdeRecursos) * vgQdeRecursos)
   If (Rp > vgQdeRecursos Or Rp < 2) Then Rp = 2
   Hash = Rp
End Function

'descompacta números (long)
Public Function Cvl(S As String) As Long
   Dim i As Long
   If Len(S) <> 4 Then
      i = 0
   Else
      CopyMemory i, Byval S, 4
   End If
   Cvl = i
End Function

Public Function LoadFixedGasPicture(ByVal n As Long, Optional ByVal Size As Variant, Optional ByVal ColorDepth As Variant, Optional ByVal SizeX As Variant, Optional ByVal SizeY As Variant) As IPictureDisp
   Dim vgPic As IPictureDisp, nPic As Long, vgArq As String

   On Error Resume Next

   nPic = n
   Set vgPic = ResCollection("P" + CStr(nPic))
   Err.Clear
   If vgPic Is Nothing Then
      vgArq$ = LoadGasPicture(n)
      If Len(vgArq$) > 0 Then
         Set vgPic = LoadPicture(vgArq$, Size, ColorDepth, SizeX, SizeY)
         ResCollection.Add vgPic, "P" + CStr(nPic)
      End If
   End If
   
   Set LoadFixedGasPicture = vgPic

FimDaSub:
   Set vgPic = Nothing
   
   Exit Function
      
DeuErro:
   Resume FimDaSub
   
End Function

Public Function LoadGasStringParam(n As Long, ParamArray vgValores() As Variant) As String
   Dim RetVal As String, i As Integer
   On Error Resume Next
   RetVal = LoadGasString(n)
   For i = 0 To UBound(vgValores)
      RetVal = Substitui$(RetVal$, "[" + CStr$(i + 1) + "]", CStr(vgValores(i)), SO_UM)
   Next 
   LoadGasStringParam = RetVal 
End Function

'carrega String do arquivo de recursos
Public Function LoadGasString(n As Long) As String
   Dim p As Long, RetVal As String, HE As HashEntry, NTent As Integer
   On Error Goto DeuErro
   RetVal = ""                                    'prepara saída
   p = (Hash(n) * 12) - 11                        'calcula offset na tabela hash
   Do
      Seek vghRes, p                              'posiciona na entrada do header correspondente
      Get vghRes, , HE                            'pega a entrada na tabela hash
      If Cvl(HE.id) = n Then                      'corresponde?
         Seek vghRes, Cvl(HE.Offs)                'então posiciona no offset da string
         RetVal$ = Space$(Cvl(HE.Tama))           'para recuperá-la
         Get vghRes, , RetVal                     'le a string,
         RetVal = Cript$(RetVal$, vgNomeApp$)     'desencripta
         Exit Do                                  'e retorna
      ElseIf Cvl(HE.Tama) = -1 Then               'entrada vazia,
         Exit Do                                  'retorna nada...
      Else
         p = p + 12                               'passa para a próxima
         If p >= vgQdeRecursos * 12 Then p = 13   'fora da tabela, retorna a 2a. entrada da tabela
      End If
   Loop
   LoadGasString = RetVal
   Exit Function
   
DeuErro:
   If Err = 52 Then
      NTent = NTent + 1
      If NTent < 3 Then
         AbreHandleRes
         Resume
      End If
   End If
   MsgBox "Ocorreu um erro inesperado ao carregar o resource " + CStr(n) + "!", vbCritical, "Erro"
End Function

''carrega picture
Public Function LoadGasPicture(Byval n As Long) As String
   Dim T As Long, p As Long, Resto As Long, i As Long, Ar As Long, TBloco As Long
   Dim x As String, RetVal As String, NVez As Integer
   Dim HE As HashEntry
   
   n = n + INICIO_FIG                                'imagens, soma mais 1 milhao
   TBloco = 32000
   RetVal = ""                                       'prepara saída

Volta:
   If NVez > 0 Then
      On Error Resume Next
      Kill vgArqFig$ + ".xxx"
      Err.Clear
   End If
   On Error Goto DeuErro
   
   p = (Hash(n) * 12) - 11                           'calcula offset na tabela hash
   Do
      Seek vghRes, p                                 'posiciona na entrada do header correspondente
      Get vghRes, , HE                               'pega a entrada na tabela hash
      If Cvl(HE.id) = n Then                         'corresponde?
         Seek vghRes, Cvl(HE.Offs)                   'então posiciona no offset da string
         RetVal = vgArqFig$ + ".xxx"                 'vamos retornar nome do arquivo
         If Len(Dir$(RetVal)) > 0 Then Kill RetVal
         Ar = FreeFile
         Open RetVal For Binary As #Ar
         T = Cvl(HE.Tama)
         If T <= TBloco Then
            x$ = Space(T)
            Get vghRes, , x$                         'le Arquivo
            Put Ar, , x$
         Else
            p = T \ TBloco                           'p = quantos pedaços de TBloco
            Resto = T Mod TBloco                     'pedaço restante
            For i = 1 To p
               x$ = Space(TBloco)
               Get vghRes, , x$                      'le Arquivo
               Put Ar, , x$
            Next
            If Resto > 0 Then
               x$ = Space(Resto)
               Get vghRes, , x$
               Put Ar, , x$
            End If
         End If
         Close Ar
         Exit Do                                     'e retorna
      ElseIf Cvl(HE.Tama) = -1 Then                  'entrada vazia,
         Exit Do                                     'retorna nada...
      Else
         p = p + 12                                  'passa para a próxima
         If p >= vgQdeRecursos * 12 Then p = 13      'fora da tabela, retorna a 2a. entrada da tabela
      End If
   Loop
   
   LoadGasPicture = RetVal

   Exit Function
      
DeuErro:
   If Err.Number = 75 Then
      NVez = NVez + 1
      If NVez < 10 Then
         Err.Clear
         Resume Volta
      End If
   ElseIf Err = 52 Then
      nVez = nVez + 1
      If nVez < 3 Then
         AbreHandleRes
         Resume
      End If
   End If
   Resume ResumeErro

ResumeErro:
   On Error Resume Next
   Close #Ar
   LoadGasPicture = ""
End Function

'fecha o arquivo de recursos
Public Sub FechaHandleRes()
   Close vghRes
   If Len(vgArqFig$) > 0 Then
      If Len(Dir$(vgArqFig$)) > 0 Then Kill vgArqFig$
   End If
End Sub

'abre o arquivo de recursos e cria um handle 
'e monta um nome ArqFig para extrair imagens
Public Function AbreHandleRes() As Integer
   Dim sTempPath As String, x As String, vgArqR As String, HE As HashEntry
   On Error Goto DeuErro
   vgNomeRes$ = "NFE.RES"                         'nome do arquivo resource
   vgArqR$ = vgDirEXE$ + vgNomeRes$
   If Len(Dir$(vgArqR$)) > 0 Then
      
      'monta nome para figuras
      sTempPath$ = String(256, Chr$(0))
      GetTempPath 256, sTempPath$
      sTempPath$ = Left$(sTempPath$, Instr(sTempPath$, Chr$(0)) - 1)
      x$ = sTempPath$
      If Right$(x$, 1) <> "\" Then x$ = x$ + "\"
      vgArqFig$ = x$ + "img~gas"
      
      'cria handle e abre arquivos
      vghRes = FreeFile
      Open vgArqR$ For Binary Access Read Shared As vghRes

      'apura qde de recursos no RC
      Get #vghRes, 1, HE
      vgQdeRecursos = Cvl(HE.Tama)

      AbreHandleRes = -1
   Else
      AbreHandleRes = 0
   End If
   Exit Function
DeuErro:
   AbreHandleRes = 0
   Close
   
End Function
