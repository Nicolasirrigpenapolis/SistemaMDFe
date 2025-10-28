Attribute VB_Name = "modAdapta"
'* Sistema...: Emissor de MDF-e (Layout 3.00)
'* Empresa...: Ygor Eduardo Dellalio
'* Módulo....: ADAPTA
'* Função....: Funçoes/declarações genéricas
'* CopyRight.: (C)2023 Ygor Eduardo Dellalio
'* Criação...: GAS-2007 - Gerador Automático de Sistemas
'* Data......: 01/09/2023 10:21:36
'* * * * * * *

Option Explicit                                   'variáveis devem ser declaradas
DefInt A-Z                                        'e por default todas seram inteiras

'Windows API's - pega o nome da estacao
Declare Function GetComputerName Lib "kernel32" Alias "GetComputerNameA" (ByVal lpBuffer As String, nSize As Long) As Long

'Windows API's - para ler WIN.INI
Declare Function GetProfileString Lib "Kernel32" Alias "GetProfileStringA" (ByVal lpAppName As String, ByVal lpkeyName As String, ByVal lpDefa As String, ByVal lpRet As String, ByVal nSize As Long) As Long

'Windows API's - para definir posicionamento de uma janela
Declare Function SetWindowPos Lib "user32" (ByVal hWnd As Long, ByVal hWndInsertAfter As Long, ByVal x As Long, ByVal y As Long, ByVal cx As Long, ByVal cy As Long, ByVal wFlags As Long) As Long

'Windows API para ler e gravar no arquivo INI
Declare Function GetPrivateProfileInt Lib "Kernel32" Alias "GetPrivateProfileIntA" (ByVal NAp As String, ByVal Chave As String, ByVal nDefa As Long, ByVal NArq As String) As Long
Declare Function GetPrivateProfileString Lib "Kernel32" Alias "GetPrivateProfileStringA" (ByVal NAp As String, ByVal Chave As Any, ByVal nDefa As String, ByVal StRet As String, ByVal nTama As Long, ByVal NArq As String) As Long
Declare Function WritePrivateProfileString Lib "Kernel32" Alias "WritePrivateProfileStringA" (ByVal NAp As String, ByVal Chave As Any, ByVal St As Any, ByVal NArq As String) As Long

'Windows API's - pega diretório temporário para o usuário atual
Declare Function GetTempPath Lib "kernel32" Alias "GetTempPathA" (ByVal nBufferLength As Long, ByVal lpBuffer As String) As Long

'Windows API's - utilizada para tratamento do resource
Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (hpvDest As Any, hpvSource As Any, ByVal cbCopy As Long)

'evia um mensagem para o windows
Declare Sub keybd_event Lib "user32" (ByVal bVk As Byte, ByVal bScan As Byte, ByVal dwFlags As Long, ByVal dwExtraInfo As Long)

'Windows API's - abre browser para capturar uma pasta
Declare Function SHGetPathFromIDList Lib "shell32.dll" Alias "SHGetPathFromIDListA" (ByVal pidl As Long, ByVal pszPath As String) As Long
Declare Function SHBrowseForFolder Lib "shell32.dll" Alias "SHBrowseForFolderA" (lpBrowseInfo As BROWSEINFO) As Long 'ITEMIDLIST

'registro do header da tabela hash
Type HashEntry
   Tama As String * 4                             'tamanho do recurso
   Offs As String * 4                             'offset
   id   As String * 4                             'numero do recurso para comparar
End Type

'cria estrutura para o browser para capturar uma pasta
Type BROWSEINFO
   hOwner As Long
   pidlRoot As Long
   pszDisplayName As String
   lpszTitle As String
   ulFlags As Long
   lpfn As Long
   lParam As Long
   iImage As Long
End Type

Public Const FATOR_HASH = 5                       'fator para evitar muitas coincidencias dentro do resource
Public Const INICIO_FIG = 1000000                 'inicio dos recursos de imagens 

'constantes para a variavel "vgSituacao" de cada form
Public Const ACAO_NAVEGANDO = 1                    'está visualizando
Public Const ACAO_INCLUINDO = 2                    'está em módulo de inclusão
Public Const ACAO_EDITANDO = 3                     'está alterando o registro

'constantes para a variavel "vgAcao" do modulo
Public vgAcao As Integer
Public Const ACAO_PROSSEGUE = 0
Public Const ACAO_IGNORA = 1
Public Const ACAO_CRIA = 2

'para evento que simula tecla pressionada
Public Const KEYEVENTF_EXTENDEDKEY = &H1           'envia simulação de tecla extendida
Public Const KEYEVENTF_KEYUP = &H2                 'envia simulação de tecla liberada
Public Const VK_SHIFT = &H10                       'envia simulação de shift pressionado

'abrir o browser para capturar uma pasta
Public Const BI_RETORNADIR = &H1   
Public Const BIF_EDITBOX = &H10
Public Const BIF_USENEWUI = &H40

'função do form frmAdapDif
Public Const PEGA_TABELA = 0                       'vai selecionar tabela
Public Const PEGA_CAMPOS = 1                       'vai relacionar os campos origem - destino

'função CriaBancoDados
Public Const TABELAS = 0                           'cria somente as tabelas no BD
Public Const RELACOES = 1                          'apenda os relacionamentos na tabela

'parâmetros da função HaNaString
Public Const UM_A_UM = -1                         'só um caracter testado
Public Const SO_UM = 0                            'todos os caracteres testados um a um

'para o form controle
Public Const PEGA_DIR = 0                         'pega diretório do BD
Public Const PEGA_ESTACAO = 1                     'pega nome da estação

'usadas na montagem de "queries" para extrair ou colocar as cláusulas
'da expressão SQL
Public Const EXP_SELECT = 0                         'extrai a expressão SELECT/UPDATE/DELETE do SQL
Public Const EXP_SET = 1                            'extrai a expressão SET do SQL
Public Const EXP_FROM = 2                           'extrai a expressão FROM do SQL
Public Const EXP_LEFT_JOIN = 3                      'extrai a expressão LEFT JOIN do SQL
Public Const EXP_RIGHT_JOIN = 4                     'extrai a expressão RIGHT JOIN do SQL
Public Const EXP_INNER_JOIN = 5                     'extrai a expressão INNER JOIN do SQL
Public Const EXP_INNER_ON = 6                       'extrai a expressão ON do SQL
Public Const EXP_WHERE = 7                          'extrai a expressão WHERE do SQL
Public Const EXP_GROUPBY = 8                        'extrai a expressão GROUPBY do SQL
Public Const EXP_HAVING = 9                         'extrai a expressão HAVING do SQL
Public Const EXP_ORDERBY = 10                       'extrai a expressão ORDERBY do SQL
Public Const EXP_LIMIT = 11                         'extrai a expressão LIMIT do SQL (MySQL)
Public Const EXP_TODAS = 12                         'extrai a expressão SQL inteira


'variáveis usadas em todo projeto

Public vgTabAdap As String
Public vgCpOrigem() As String
Public vgCpDestino() As String
Public vgCpDoArq() As Boolean
Public vgQualCp As Integer
Public vgQualScrCp As Integer
Public vgNumCps As Integer
Public vgCancelou As Integer

Public vgAliasDb(1) As String                     'alias para registro do banco de dados
Public vgNomeDb(1) As String                      'path e nome do banco de dados
Public vgTiposPermDb(1) As Integer                'tipos que o banco pode assumir
Public vgServerDb(1) As String                    'servidor do banco de dados
Public vgTipoDb(1) As EnumDataBaseType            'tipo do banco de dados
Public vgDirDb(1) As String                       'diretório do banco de dados
Public vgProviderDb(1) As String                  'providers para conexão com o bancos de dados
Public vgDriverDb(1) As String                    'drivers para conexão com o bancos de dados
Public vgUsuarioID(1) As String                    'usuário para conexão com o banco de dados
Public vgSenhaDb(1) As String                     'senha para conexão com o banco de dados
Public vgStrConnectionDb(1) As String             'string connection para os bancos de dados
Public vgTrustConnDb(1) As Boolean                'vai utilizar trusted connection para o banco
Public vgSpDec As String                          'separador de decimais

Public vgClausula(EXP_TODAS - 1) As String         'vetor com os nomes das cláusulas SQL
Public vgNomeEstacao As String                     'nome da estação de trabalho
Public vgDirEXE As String                          'diretório do sistema (.EXE)
Public vgNomeApp As String                         'nome original do aplicativo (.EXE)
Public vgArqEstXML As String                       'arquivo de estrutura do banco
Public vgNomeINI As String                         'nome do arquivo .INI
Public vgAtencao As String                         'palavra "Atenção!"
Public vgNomeRes As String                         'nome do arquivo resource
Public vgQdeRecursos As Long                       'Quantidade de recursos no resource (.RC)
Public vgNomeSistema As String                     'nome do sistema
Public CErr As New Dbox                            'classe para mostrar erros
Public vgTemLogDb(1) As Boolean                   'controle de logs por banco
Public vgSenhaLog(1) As String

'cria variáveis vistas em todo sistema

'para bancos sql

'estrutura de metadados
Public vgMetaDB As New GDataBase
Public BancoDeCampos As New GColumns              'coleção de todos os campos de todos os bancos.

Public vgDb As New GConnection                    'Coleção de bancos de dados utilizados pelo aplicativo
Public vgCat As New ADOX.Catalog
Private Crc32Table(255) As Long                   'Vetor para CRC
Private vghRes As Integer, vgArqFig As String

Public Function GetCRC(Exp As String) As Long
   Dim lCrc32Value As Long
   lCrc32Value = InitCrc32()
   lCrc32Value = AddCrc32(Exp, lCrc32Value)
   GetCRC = GetCrc32(lCrc32Value)
End Function

Public Function InitCrc32(Optional ByVal Seed As Long = &HEDB88320, Optional ByVal Precondition As Long = &HFFFFFFFF) As Long
      Dim iBytes As Integer, iBits As Integer, lCrc32 As Long
      Dim lTempCrc32 As Long

      '// Turn on error trapping
      On Error Resume Next

      '// Iterate 256 times
      For iBytes = 0 To 255

            '// Initiate lCrc32 to counter variable
            lCrc32 = iBytes

            '// Now iterate through each bit in counter byte
            For iBits = 0 To 7
                  '// Right shift unsigned long 1 bit
                  lTempCrc32 = lCrc32 And &HFFFFFFFE
                  lTempCrc32 = lTempCrc32 \ &H2
                  lTempCrc32 = lTempCrc32 And &H7FFFFFFF

                  '// Now check if temporary is less than zero and then
                  'mix Crc32 checksum with Seed value
                  If (lCrc32 And &H1) <> 0 Then
                        lCrc32 = lTempCrc32 Xor Seed
                  Else
                        lCrc32 = lTempCrc32
                  End If
            Next

            '// Put Crc32 checksum value in the holding array
            Crc32Table(iBytes) = lCrc32
      Next

      '// After this is done, set function value to the
      'precondition value
      InitCrc32 = Precondition

End Function

Public Function AddCrc32(ByVal Item As String, ByVal Crc32 As Long) As Long
      Dim bCharValue As Byte, iCounter As Integer, lIndex As Long
      Dim lAccValue As Long, lTableValue As Long

      '// Turn on error trapping
      On Error Resume Next

      '// Iterate through the string that is to be checksum-computed
      For iCounter = 1 To Len(Item)

            '// Get ASCII value for the current character
            bCharValue = Asc(Mid$(Item, iCounter, 1))

            '// Right shift an Unsigned Long 8 bits
            lAccValue = Crc32 And &HFFFFFF00
            lAccValue = lAccValue \ &H100
            lAccValue = lAccValue And &HFFFFFF

            '// Now select the right adding value from the
            'holding table
            lIndex = Crc32 And &HFF
            lIndex = lIndex Xor bCharValue
            lTableValue = Crc32Table(lIndex)

            '// Then mix new Crc32 value with previous
            'accumulated Crc32 value
            Crc32 = lAccValue Xor lTableValue
      Next

      '// Set function value the the new Crc32 checksum
      AddCrc32 = Crc32

End Function

Public Function GetCrc32(ByVal Crc32 As Long) As Long
      On Error Resume Next
      GetCrc32 = Crc32 Xor &HFFFFFFFF
End Function

Public Function TrimAll(ByVal St As String, ByVal TrimChars As String) As String
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

'parseia string St$ atraves do caracter Delim$
Public Function Parse(ByRef St As String, ByVal Delim As String, Optional ByVal NumParse As Integer = 0) As String
   Dim i As Integer, NewSt As String, RetVal As String, Cont As Integer
   NewSt$ = St$
PegaOutro:
   Cont = Cont + 1
   i = InStr(NewSt$, Delim$)
   If i > 0 Then
      RetVal$ = Left$(NewSt$, i - 1)
      NewSt$ = Mid$(NewSt$, i + Len(Delim$))
      If Cont < NumParse Then
         GoTo PegaOutro
      End If
   Else
      If NumParse = 0 Or Cont = NumParse Then
         RetVal$ = NewSt$
         NewSt$ = ""
      Else
         RetVal$ = ""
      End If
   End If
   If NumParse = 0 Then
      St$ = NewSt$
   End If
   Parse$ = RetVal$
End Function


'troca caracter por outro, dentro da string
Public Function Substitui(Alvo As String, OQue As String, PeloQue As String, Como As Integer) As String
   Dim x As String, k As String, p As Integer, i As Integer       'dimensiona
   x$ = Alvo$                                     'salva string alvo
   If Como = UM_A_UM Then                         'se um a um,
      For i = 1 To Len(x$)                        'vamos trocar
         k$ = Mid$(x$, i, 1)                      'cada caracter de oque$
         p = InStr(OQue$, k$)                     'pelo correspondente em PeloQue$
         If p > 0 Then Mid$(x$, i, 1) = Mid$(PeloQue$, p, 1) 'na string alvo
      Next
   Else                                           'senão,
      p = InStr(x$, OQue$)                        'vamos trocar
      While p > 0                                 'todos de uma vez
         x$ = Left$(x$, p - 1) + PeloQue$ + Mid$(x$, p + Len(OQue$)) 'quantas vezes necessário
         p = InStr(p + Len(PeloQue$), x$, OQue$)                     'na string alvo
      Wend
   End If
   Substitui$ = x$                                'retorna a nova string
End Function

Public Function Existe(NomeArq As String) As Integer
   Existe = Len(Dir$(NomeArq$)) > 0
End Function

'retorna o valor de precisão dupla de uma string com pontos separando milhares
'e vírgula separando decimais, por exemplo: 99.999.999,99
Public Function ValBrasil(St As String) As Double
   Dim x As String                                'dimensiona
   If vgSpDec$ = "," Then
      x$ = Retira$(St$, ".", SO_UM)               'remove pontos, se tiver = 99.999.999,99
      x$ = Substitui$(x$, ",", ".", SO_UM)        'troca virgulas por pontos
      ValBrasil = Val(x$)                         'retorna o val...
   Else
      x$ = Retira$(St$, ",", SO_UM)               'remove pontos, se tiver = 99,999,999.99
      ValBrasil = Val(x$)                         'retorna o val...
   End If
End Function

Public Function RPad(St As String, Tm As Integer, Ch As String) As String
   Dim x As String                                            'dimensiona
   If VarType(St) = vbString Then                             'se veio uma string
      x$ = St                                                 'pega ela...
   Else                                           'senão,
      x$ = Str$(St)                               'transforma em string
   End If
   RPad$ = Left$(LTrim$(x$) + String$(Tm, Ch$), Tm) 'completa com brancos à direita
End Function

'enche caracteres à esquerda de uma string
Public Function LPad(vgSt As Variant, vgTm As Integer, vgCh As String) As String
   Dim x As String                                            'dimensiona
   If VarType(vgSt) = vbString Then                           'se veio uma string
      x$ = vgSt                                               'pega ela...
   Else                                           'senão,
      x$ = CStr(vgSt)                             'transforma em string
   End If
   LPad$ = Right$(String$(vgTm, vgCh$) + LTrim$(x$), vgTm) 'completa com brancos à esquerda
End Function

'pega posição de argumento, a partir da direita
Public Function Rat(Alvo As String, Pesq As String) As Integer
   Dim i As Integer, RetVal As Integer, j As Integer, p As String
   RetVal = 0
   j = Len(Pesq$)
   For i = Len(Alvo$) To 1 Step -1
      p$ = Mid$(Alvo$, i, j)
      If p$ = Pesq$ Then
         RetVal = i
         Exit For
      End If
   Next
   Rat = RetVal
End Function

'Encripta/desencripta uma string
Public Function EncriptaPW(vgSt As String) As String
   Dim x As String
   x$ = Trim$(Cript$(RPad$(vgSt$, 25, "+" ), "B0358A5E"))
   While Right$(x$, 1) = "+"
      x$ = Left$(x$, Len(x$) - 1)
   Wend
   EncriptaPW$ = x$
End Function

Public Function Encripta(vgSt As String) As String
   Dim Base64 As New Base64
   Dim vgRetVal As String
   If Len(vgSt) > 0 Then
      vgRetVal = Base64.EncodeBase64String(EncriptaPW$(vgSt$))
   End If
   Encripta = vgRetVal
   Set Base64 = Nothing
End Function

Public Function Decripta(vgSt As String) As String
   Dim Base64 As New Base64
   Dim vgRetVal As String
   If Len(vgSt) > 0 Then
      vgRetVal = EncriptaPW(Base64.DecodeBase64String(vgSt))
   End If
   Decripta = vgRetVal
   Set Base64 = Nothing
End Function

'criptografa/descriptografa
Public Function Cript(St As String, Pw As String) As String
   Dim x As String, i As Integer, n As Integer, _
       p As Integer, j As Integer, n0 As Integer     'dimensiona
   p = 0
   For i = 1 To Len(St$)                             'para cada caracter
      p = p + 1                                      'incrementa ponteiro
      If p > Len(Pw$) Then p = 1                     'testa e reseta, se for o caso
      j = Asc(Mid$(Pw$, p, 1)) Or 128                'pega char da senha evitando acima de 128
      n = Asc(Mid$(St$, i))                          'pega char da string a encriptar

DeNovo:
      n = n Xor j                                    'encripta...
      If n < 31 Then                                 'se char de controle
         n = (128 + n)                               'somar 128 e
         GoTo DeNovo                                 'ecripta novamente
      ElseIf n > 127 And n < 159 Then                'se nesta faixa pode ser char de controle
         n = n - 128                                 'tira 128 e
         GoTo DeNovo                                 'encripta novamente
      End If
      x$ = x$ + Chr$(n)                              'concatena string encriptada
   Next                                              'próximo caracter a encriptar
   Cript$ = x$                                       'retorna a nova string
End Function

'remove caracteres de uma string
Public Function Retira(Alvo As String, OQue As String, Como As Integer) As String
   Dim x As String, k As String, i As Integer, _
       j As Integer, p As Integer                        'dimensiona
   If Como = UM_A_UM Then                                'se um a um
      x$ = ""                                            'vamos concatenar em x
      For i = 1 To Len(Alvo$)                            'cada caracter que
         k$ = Mid$(Alvo$, i, 1)                          'não estiver
         If InStr(OQue$, k$) = 0 Then x$ = x$ + k$       'contido na string a regirar
      Next
   Else                                                  'se não for um a um
      x$ = Alvo$                                         'vamos tirar

ProcuraOutro:
      p = InStr(x$, OQue$)                               'toda a string
      If p > 0 Then                                      'de uma só vez
         x$ = Left$(x$, p - 1) + Mid$(x$, p + Len(OQue$)) 'da string alvo
         GoTo ProcuraOutro
      End If
   End If
   Retira$ = x$                                           'retorna nova string
End Function

'poe colchetes nos nomes de tabelas e campos se necessario
Public Function PoeColchetes(St As String, Optional ByVal vgParaAlias As Boolean = False) As String
   Dim x As String, i As Integer                         'dimensiona
   If (InStr(St, " ") > 0 Or InStr(St$, "/") > 0 Or _
      InStr(St$, "-") > 0 Or InStr(St$, "~") > 0 Or _
      IsNumeric(Left(St$, 1)) Or InStr(St$, "=") > 0 Or _
      InStr(St$, "?") > 0) And Left$(St$, 1) <> "[" And _
      Right$(St$, 1) <> "]" Then                         'se tiver espaço ou barras
      i = InStr(St, ".")                                 'seta no formato Tabela.Campo
      If i > 0 Then                                      'poe colchetes em ambas se necessario
         x$ = PoeColchetes(Left$(St, i - 1)) + "." + PoeColchetes(Mid$(St, i + 1))
      Else
         x$ = "[" + St$ + "]"                            'vamos retornar entre colchetes
      End If
   Else                                                  'senão,
      x$ = St$                                           'vamos retornar o que veio
   End If
   PoeColchetes$ = x$                                    'retorna
End Function

'insere uma nova cláusula na expressão SQL
Public Function InsereSQL(Byval vgExpSQL As String, Byval vgQual As Integer, Byval vgOQueInserir As String) As String
   Dim vgRetVal As String, i As Integer, j As Long, x As String, vgExpTop As String
   Dim vgSeleDel As String
   vgRetVal$ = ""                                     'conter toda a exp SQL
   If Instr(UCase$(vgExpSQL$), "DELETE ") Then
      vgSeleDel$ = "DELETE "
   Else
      vgSeleDel$ = vgClausula$(EXP_SELECT)
   End If
   vgOQueInserir$ = Trim$(vgOQueInserir$)             'cláusula a inserir
   vgExpTop$ = ExtraiSQL(vgExpSQL$, EXP_SELECT)
   If UCase$(Left$(vgExpTop$, 4)) = "TOP " Or UCase$(Left$(vgExpTop$, 8)) = "PERCENT " Then
      x$ = Parse(vgExpTop$, Chr(32))
      x$ = x$ + Chr(32) + Parse(vgExpTop$, Chr(32))
      If Left(vgExpTop$, 7) = "PERCENT" Then
         x$ = x$ + Chr(32) + "PERCENT"
      End If
      vgExpTop$ = x$
   Else
      vgExpTop$ = ""
   End If
   For i = 0 To EXP_TODAS - 1                         'corre todas as cláusulas
      If i = vgQual Then                              'se for a que quer inserir
         x$ = vgOQueInserir$                          'substitui pela informada
      Else                                            'caso contrário
         x$ = ExtraiSQL$(vgExpSQL$, i, True)          'tira cláusula da própria exp SQL
      End If
      If Len(x$) > 0 Or(i = EXP_SELECT And vgSeleDel$ = "DELETE ") Then 'se a clusula existe segue montando nova exp SQL
         If (i = EXP_FROM Or i = EXP_LEFT_JOIN Or i = EXP_RIGHT_JOIN Or i = EXP_INNER_JOIN Or i = EXP_INNER_ON) And Left$(LTrim$(x$), 1) = "(" Then
            x$ = LTrim$(x$)
            x$ = vbCrLf + "(" + vbCrLf + Mid$(x$, 2)
            j = InStrRev(x$, ")")
            If j > 0 Then
               x$ = Left$(x$, j - 1) + vbCrLf + Mid$(x$, j)
            End If
         End If
         vgRetVal$ = vgRetVal$ + LTrim$(IIf(i = EXP_SELECT, vgSeleDel$, vgClausula$(i))) + x$ + vbCrLf
      End If
   Next
   If Len(vgExpTop$) And vgQual <> EXP_SELECT Then
      x$ = ExtraiSQL(vgRetVal$, EXP_SELECT)
      If UCase(Left(x$, 3)) <> "TOP" And UCase(Left(x$, 7)) <> "PERCENT" Then
         x$ = vgExpTop$ + Chr(32) + x$
         vgRetVal$ = InsereSQL(vgRetVal$, EXP_SELECT, x$)
      End If
   End If
   InsereSQL = Trim$(vgRetVal$)                                         'esta é a nova exp SQL
End Function

'Extrai a clausula escolhida da expressao SQL
Public Function ExtraiSQL(ByVal vgExpSQL As String, ByVal vgQualSQL As Integer, Optional vgTiraTop As Variant) As String
   Dim vgPosIni As Integer, vgPosFim As Integer, x As String, vgSeleDel As String
   Dim vgExpNormal As String, vgExpMaiusc As String, i As Integer, j As Integer, p As Integer
   
   Dim vgDelimitador As Byte                      'controla os delimitadores colchetes e plicks
   
   vgExpNormal$ = " " + vgExpSQL$ + " "
   vgExpNormal$ = Substitui$(vgExpNormal$, "(" + vbCrLf, "(", SO_UM)
   vgExpNormal$ = Substitui$(vgExpNormal$, vbCrLf + ")", ")", SO_UM)
   vgExpNormal$ = Substitui$(vgExpNormal$, Chr$(13), " ", SO_UM)
   vgExpNormal$ = Substitui$(vgExpNormal$, Chr$(10), " ", SO_UM)
   vgExpNormal$ = Substitui$(vgExpNormal$, " ,", ",", SO_UM)
   
   'vamos retirar os espaços desnecessários
   vgDelimitador = 0
   For i = 1 To Len(vgExpNormal$)
      If Mid(vgExpNormal$, i, 1) = " " Then
         If Mid(vgExpNormal$, i + 1, 1) = " " And vgDelimitador = 0 Then
            vgExpNormal$ = Mid(vgExpNormal$, 1, i - 1) + Mid(vgExpNormal$, i + 1)
            i = i - 1
         End If
      Else
         If Mid(vgExpNormal$, i, 1) = "[" Or Mid(vgExpNormal$, i, 1) = "'" And vgDelimitador = 0 Then
            vgDelimitador = vgDelimitador + 1
         ElseIf Mid(vgExpNormal$, i, 1) = "]" Or Mid(vgExpNormal$, i, 1) = "'" Then
            vgDelimitador = vgDelimitador - 1
         End If
      End If
   Next
   
   vgExpMaiusc$ = UCase$(vgExpNormal$)

   'verifica se o query e de delecao ou update
   If InStr(vgExpMaiusc$, "DELETE ") Then
      vgSeleDel$ = "DELETE "
   ElseIf InStr(vgExpMaiusc$, "UPDATE ") Then
      vgSeleDel$ = "UPDATE "
   ElseIf InStr(vgExpMaiusc$, "INSERT ") Then
      vgSeleDel$ = "INSERT "
   Else
      vgSeleDel$ = vgClausula$(EXP_SELECT)
   End If

   If vgQualSQL <> EXP_TODAS Then
      vgPosIni = InStr(vgExpMaiusc$, IIf(vgQualSQL = EXP_SELECT, vgSeleDel$, vgClausula$(vgQualSQL)))
   End If
   
   If vgPosIni > 0 Then
      Do While vgPosIni > 0 And (Tally(Left$(vgExpMaiusc$, vgPosIni), "(") <> Tally(Left$(vgExpMaiusc$, vgPosIni), ")") Or _
         Tally(Left$(vgExpMaiusc$, vgPosIni), "[") <> Tally(Left$(vgExpMaiusc$, vgPosIni), "]"))
         vgPosIni = InStr(vgPosIni + 4, vgExpMaiusc$, IIf(vgQualSQL = EXP_SELECT, vgSeleDel$, vgClausula$(vgQualSQL)))
      Loop
   End If
   If vgPosIni > 0 Or vgQualSQL = EXP_TODAS Then
      If vgQualSQL <> EXP_TODAS Then
         vgPosIni = vgPosIni + Len(IIf(vgQualSQL = EXP_SELECT, vgSeleDel$, vgClausula$(vgQualSQL))) - 1  
      End If
      vgPosFim = Len(vgExpMaiusc$)
      For i = 0 To EXP_TODAS - 1
         j = InStr(vgExpMaiusc$, IIf(i = EXP_SELECT, vgSeleDel$, vgClausula$(i)))
         Do While j > 0 And (Tally(Left$(vgExpMaiusc$, j), "(") <> Tally(Left$(vgExpMaiusc$, j), ")") Or _
            Tally(Left$(vgExpMaiusc$, j), "[") <> Tally(Left$(vgExpMaiusc$, j), "]"))
            j = InStr(j + 4, vgExpMaiusc$, IIf(i = EXP_SELECT, vgSeleDel$, vgClausula$(i)))
         Loop
         If j >= vgPosIni And j < vgPosFim Then vgPosFim = j
      Next
      x$ = Trim$(Mid$(vgExpNormal$, vgPosIni, (vgPosFim - vgPosIni) + 1))
      If Not IsMissing(vgTiraTop) Then
         If vgQualSQL = EXP_SELECT And vgTiraTop Then 'extrai o TOP n PERCENT
            If UCase$(Left$(x$, 4)) = "TOP " Then
               x$ = LTrim$(Mid$(x$, 5))
               If Val(x$) > 0 Then x$ = LTrim$(Mid$(x$, InStr(x$, " ")))
               If UCase$(Left$(x$, 8)) = "PERCENT " Then
                  x$ = LTrim$(Mid$(x$, 9))
               End If
            End If
         ElseIf vgQualSQL = EXP_WHERE And vgTiraTop Then
            i = InStr(x$, "ROWNUM <= ")
            If i Then
               If Len(Trim$(Mid$(x$, i + 10))) = Len(CStr(Val(Mid$(x$, i + 10)))) Then
                  x$ = Rtrim$(Mid(x$, 1, i - 1))
                  If UCase$(Right$(x$, 4)) = " AND" Then
                     x$ = Rtrim$(Left$(x$, Len(x$) - 4))
                  End If
               End If
            End If
         End If
      End If
   ElseIf vgQualSQL = EXP_FROM And Len(vgExpSQL$) > 0 And UCase$(Left$(vgExpSQL$, 7)) <> "SELECT " And vgSeleDel$ <> "UPDATE " And vgSeleDel$ <> "INSERT " Then 'so tem tabela
      x$ = vgExpSQL$
   Else
      x$ = ""
   End If
   
      'Corrige propriedade Filter do Driver do FireBird
   If vgQualSQL = EXP_WHERE Then
      p = 1
      x$ = TrimAll(x$, vbCrLf)
      i = InStr(p, x$, Chr(34))
      Do While i > 0
         If Tally(Left(x, i - 1), "'") Mod 2 = 0 And Tally(Mid(x, i + 1), "'") Mod 2 = 0 Then
            Mid(x, i, 1) = "["
            i = InStr(i + 1, x$, Chr(34))
            If i Then
               Mid(x, i, 1) = "]"
            End If
         End If
         p = p + 1
         i = InStr(p, x$, Chr(34))
      Loop
   End If
   
   ExtraiSQL = TrimAll$(x$, vbCrLf)
End Function

Public Function Tally(vgAlvo As String, vgOq As String) As Integer
   Dim i As Long, vgQt As Integer
   vgQt = 0                                       'inicializa variaveis
   i = 0

OutraVez:
   i = InStr(i + 1, vgAlvo$, vgOq$)               'procura...
   If i > 0 Then                                  'se achou
      vgQt = vgQt + 1                             'soma a quantidade
      GoTo OutraVez                               'e procura mais
   End If
   Tally = vgQt
End Function

Public Function TiraAcentos(St As String) As String
   Dim x As String, RetVal As String, z As String
   x$ = Chr$(192) + Chr$(193) + Chr$(194) + Chr$(195) + Chr$(196) + Chr$(199) + Chr$(199) + Chr$(200) + Chr$(201) + Chr$(202) + Chr$(202) + Chr$(203) + Chr$(204) + Chr$(205) + Chr$(206) + Chr$(206) + Chr$(207) + Chr$(210) + Chr$(211) + Chr$(212) + Chr$(213) + Chr$(214) + Chr$(217) + Chr$(218) + Chr$(219)
   x$ = x$ + Chr$(219) + Chr$(220) + Chr$(224) + Chr$(225) + Chr$(226) + Chr$(227) + Chr$(228) + Chr$(231) + Chr$(232) + Chr$(233) + Chr$(234) + Chr$(234) + Chr$(235) + Chr$(236) + Chr$(237) + Chr$(238) + Chr$(238) + Chr$(239) + Chr$(242) + Chr$(243) + Chr$(244) + Chr$(245) + Chr$(246) + Chr$(249) + Chr$(250) + Chr$(251) + Chr$(251) + Chr$(252)
   z$ = "aaaaacceeeeeiiiiioooooyuuuuaaaaaceeeeeiiiiiooooouuuuu"
   RetVal$ = Substitui(St$, x$, z$, UM_A_UM)
   TiraAcentos$ = RetVal$
End Function


'Carrega todas as informações para o banco requerido
Public Function LeInfDb(Optional vgTipo As EnumDataBaseType = -1) As Boolean
   Dim RetVal As Boolean
   If vgTipo <> -1 Then                           'vamos pegar informações definidas em projeto
      vgNomeDb(1) = "DADOSNFE"
      vgTrustConnDb(1) = False
      vgUsuarioID(1) = ""
      vgSenhaDb(1) = ""
      vgStrConnectionDb(1) = "Provider=[PROVIDER];Persist Security Info=False;DRIVER=[DRIVER];Server=[SERVER];UID=[USER];Pwd=[PASSWORD];Database=[DATABASE];Trusted_Connection=[TRUSTED]"
   Else                                           'lê informações do INI
      vgNomeDb(1) = PegaStrDoIni(vgNomeEstacao$ + "Geral", "Nome de " + vgAliasDb(1), vgNomeINI$)
      vgTipoDb(1) = PegaIntDoIni(vgNomeEstacao$ + "Geral", "Tipo de " + vgAliasDb(1), -1, vgNomeINI$)
      vgDirDb(1) = PegaStrDoIni(vgNomeEstacao$ + "Geral", "Diretório de " + vgAliasDb(1), vgNomeINI$)
      vgServerDb(1) = PegaStrDoIni(vgNomeEstacao$ + "Geral", "Server de " + vgAliasDb(1), vgNomeINI$)
      vgTrustConnDb(1) = PegaIntDoIni(vgNomeEstacao$ + "Geral", "Trusted Connection de " + vgAliasDb(1), 0, vgNomeINI$)
      vgUsuarioID(1) = Decripta$(PegaStrDoIni(vgNomeEstacao$ + "Geral", "Usuário de " + vgAliasDb(1), vgNomeINI$))
      vgSenhaDb(1) = DeCripta$(PegaStrDoIni(vgNomeEstacao$ + "Geral", "Senha de " + vgAliasDb(1), vgNomeINI$))
      vgProviderDb(1) = PegaStrDoIni(vgNomeEstacao$ + "Geral", "Provider de " + vgAliasDb(1), vgNomeINI$)
      vgDriverDb(1) = PegaStrDoIni(vgNomeEstacao$ + "Geral", "Driver de " + vgAliasDb(1), vgNomeINI$)
      vgStrConnectionDb(1) = PegaStrDoIni(vgNomeEstacao$ + "Geral", "String Connection de " + vgAliasDb(1), vgNomeINI$)
      
      RetVal = ((vgTiposPermDb(1) And vgTipoDb(1)) <> 0 And vgTipoDb(1) <> -1)
      
      If RetVal Then                              'se tipo ok, vamos validar se tem o restante dos dados para o tipo de banco selecionado
               RetVal = (Len(vgStrConnectionDb(1)) > 0) Or ((Len(vgServerDb$(1)) > 0) And (vgTrustConnDb(1) Or ((Len(vgUsuarioID(1)) > 0) And (Len(vgSenhaDb(1)) > 0))))
      End If
   End If
   
   LeInfDb = RetVal
End Function


'pega valor string em um arquivo .INI
Public Function PegaStrDoIni(vgSecao As String, vgItem As String, vgArqIni As String) As String
   Dim p As String * 200, i As Long                                   'prepara buffer
   i = GetPrivateProfileString(vgSecao$, vgItem$, "", p$, 200, vgArqIni$) 'aciona API
   PegaStrDoIni$ = Left$(p$, i)                                           'o tamanho está em i
End Function

'pega valor inteiro em um arquivo .INI
Public Function PegaIntDoIni(vgSecao As String, vgItem As String, vgDefa As Long, vgArqIni As String) As String
   PegaIntDoIni$ = GetPrivateProfileInt(vgSecao$, vgItem$, vgDefa, vgArqIni$)   'pega inteiro na forma de string
End Function

'grava valor string em um arquivo .INI
Public Sub GravaNoIni(vgSecao As String, vgItem As String, vgV As String, vgNomeINI As String)
   WritePrivateProfileString vgSecao$, vgItem$, vgV$, vgNomeINI$    'grava string no INI
End Sub


''carrega picture
Public Function LoadGasPicture(ByVal n As Long) As String
   Dim T As Long, p As Long, Resto As Long, i As Long, Ar As Long, TBloco As Long
   Dim x As String, Tam As String, RetVal As String, NVez As Integer
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
   On Error GoTo DeuErro
   
   p = (Hash(n) * 12) - 11                           'calcula offset na tabela hash
   Do
      Seek vghRes, p                                 'posiciona na entrada do header correspondente
      Get vghRes, , HE                               'pega a entrada na tabela hash
      If CVL(HE.id) = n Then                         'corresponde?
         Seek vghRes, CVL(HE.Offs)                   'então posiciona no offset da string
         RetVal = vgArqFig$ + ".xxx"                 'vamos retornar nome do arquivo
         If Len(Dir$(RetVal)) > 0 Then Kill RetVal
         Ar = FreeFile
         Open RetVal For Binary As #Ar
         T = CVL(HE.Tama)
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
      ElseIf CVL(HE.Tama) = -1 Then                  'entrada vazia,
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


'descompacta números (long)
Public Function CVL(S As String) As Long
   Dim i As Long
   If Len(S) <> 4 Then
      i = 0
   Else
      CopyMemory i, ByVal S, 4
   End If
   CVL = i
End Function


'carrega String do arquivo de recursos
Public Function LoadGasString(n As Long) As String
   Dim T As Long, p As Long, x As String, RetVal As String, HE As HashEntry, NTent As Integer
   On Error GoTo DeuErro
   RetVal = ""                                    'prepara saída
   p = (Hash(n) * 12) - 11                        'calcula offset na tabela hash
   Do
      Seek vghRes, p                              'posiciona na entrada do header correspondente
      Get vghRes, , HE                            'pega a entrada na tabela hash
      If CVL(HE.id) = n Then                      'corresponde?
         Seek vghRes, CVL(HE.Offs)                'então posiciona no offset da string
         RetVal$ = Space$(CVL(HE.Tama))           'para recuperá-la
         Get vghRes, , RetVal                     'le a string,
         RetVal = Cript$(RetVal$, vgNomeApp$)     'desencripta
         Exit Do                                  'e retorna
      ElseIf CVL(HE.Tama) = -1 Then               'entrada vazia,
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

'abre o arquivo de recursos e cria um handle 
'e monta um nome ArqFig para extrair imagens
Public Function AbreHandleRes() As Integer
   Dim sTempPath As String, x As String, vgArqR As String, L As String, HE As HashEntry
   On Error GoTo DeuErro
   vgNomeRes$ = "NFE.RES"                         'nome do arquivo resource
   vgArqR$ = vgDirEXE$ + vgNomeRes$
   If Len(Dir$(vgArqR$)) > 0 Then
      'monta nome para figuras
      sTempPath$ = String(256, Chr$(0))
      GetTempPath 256, sTempPath$
      sTempPath$ = Left$(sTempPath$, InStr(sTempPath$, Chr$(0)) - 1)
      x$ = sTempPath$
      If Right$(x$, 1) <> "\" Then x$ = x$ + "\"
      vgArqFig$ = x$ + "img~gas"
      'cria handle e abre arquivos
      vghRes = FreeFile

      Open vgArqR$ For Binary Access Read Shared As vghRes

      'apura qde de recursos no RC
      Get #vghRes, 1, HE
      vgQdeRecursos = CVL(HE.Tama)

      AbreHandleRes = -1
   Else
      AbreHandleRes = 0
   End If
   Exit Function
DeuErro:
   AbreHandleRes = 0
   Close
   
End Function

Public Function Hash(nn As Long) As Long
   Dim Rp As Long
   Dim x As String
   Rp = nn * FATOR_HASH
   Rp = Rp - (Int(Rp / vgQdeRecursos) * vgQdeRecursos)
   If (Rp > vgQdeRecursos Or Rp < 2) Then Rp = 2
   Hash = Rp
End Function

Public Sub SendK(ByVal KeyCode As Integer)
   keybd_event KeyCode, &H45, KEYEVENTF_EXTENDEDKEY Or 0, 0                'Simula KeyPress
   keybd_event KeyCode, &H45, KEYEVENTF_EXTENDEDKEY Or KEYEVENTF_KEYUP, 0  'Simula KeyRelease
End Sub

Public Sub CentraNaTela(F As Form)
      F.Top = (Screen.Height - F.Height) / 2                               'caso contrário,
      F.Left = (Screen.Width - F.Width) / 2                                'centraliza na tela
End Sub

'dependento do tipo do banco de dados troca []'s por aspas
Public Function PoeColAspas(St As String, TpDoDB As Integer) As String
   Dim RetVal As String
   RetVal$ = PoeColchetes$(St$)

   PoeColAspas = RetVal$
End Function




'grava arquivo de log de ações dos usuários
Public Sub GeraLogAcao(vgAcao As String)
   Dim vgArqLog As String, vgRet As Long, vgHandleArqLog As Integer, _
       vgLin As String, vgSeparador As String, vgSep As String, x As String
   On Error GoTo DeuErro
   vgSep$ = Chr(160)
   x$=PegaStrDoIni(vgNomeEstacao$ + "Geral", "Diretorio das consultas", vgNomeINI$)
   If len(x$) = 0 Then x$ = vgDirExe
   vgArqLog$ = Left$(x$, Rat(x$, "\" ))
   vgArqLog$ = vgArqLog$ + vgDb(1).Alias() + ".Lag"
   vgRet = PreparaArqLog
   If vgRet > 0 Then Error vgRet
   vgLin$ = Format(Now, "yyyy/mm/dd hh:mm") + vgSep$                    'data e hora
   vgLin$ = vgLin$ + LoadGasString(1140) + vgSep$ + vgAliasDb$(1) + vgSep$ 'nome da tabela e usuário
   vgLin$ = vgLin$ + "[A]" + vgSep$ + vgAcao$                              'tipo da operação + ação 
   vgHandleArqLog = FreeFile
   Open vgArqLog For Append As vgHandleArqLog
   Print #vgHandleArqLog, Cript$(vgLin$, vgSenhaLog$(1))
   Close vgHandleArqLog
   Exit Sub

DeuErro:
   If vgHandleArqLog >= 0 Then
      Close vgHandleArqLog
   End If
   
End Sub

Private Function PreparaArqLog() As Long
   Dim vgArqLog As String, vgHandleArqLog As Integer, i As Integer, j As Integer, _
       vgLin As String, vgSep As String, k As String, x As String
   On Error GoTo DeuErro
   vgSep$ = Chr(160)
   x$=PegaStrDoIni(vgNomeEstacao$ + "Geral", "Diretorio das consultas", vgNomeINI$)
   vgArqLog$ = Left$(x$, Rat(x$, "\" ))
   vgArqLog$ = vgArqLog$ + vgDb(1).Alias() + ".Lag"
   vgHandleArqLog = FreeFile      
   If Not Existe(vgArqLog$) Then
      Open vgArqLog$ For Output As vgHandleArqLog                    'vamos criar o arquivo em branco
      
      'vamos criar o header para o arquivo de log
      Print #vgHandleArqLog, Cript("Aplicação = " + vgNomeSistema$, vgSenhaLog$(1)) 'grava o nome de cada campo
      For i = 1 To vgDb.Tables.Count                                                'para cada tabela do banco
         With vgDb.Tables(i)
            If Not .System And Not .Hidden Then                                     'não é tabela de sistema e se não for tabela invisível
               vgLin$ = "*" + .Name + vgSep$                                        'nome da tabela 
               For j = 1 To .Columns.Count                                          'para cada campo da tabela
                  If .Columns(j).ColumnType <> TP_BINARIO And Not .Columns(j).Hidden Then 'imagem ou campo invisivel não pode
                     If j > 1 Then vgLin$ = vgLin$ + ";"
                     vgLin$ = vgLin$ + .Columns(j).Name                                   'grava o nome de cada campo
                  End If
               Next
               Print #vgHandleArqLog, Cript$(vgLin$, vgSenhaLog$(1))                      'grava o nome da tabela
            End If
         End With
      Next

      'coloca ação executada
      vgLin$ = "*" + LoadGasString(1140) + vgSep$ + LoadGasString(1141)
      Print #vgHandleArqLog, Cript$(vgLin$, vgSenhaLog$(1))

      Close vgHandleArqLog
   End If
   PreparaArqLog = 0
   Exit Function
   
DeuErro:
   If vgHandleArqLog >= 0 Then
      Close vgHandleArqLog
   End If
   PreparaArqLog = Err.Number
End Function



'mantém um formulário sempre visível
Public Sub FormSempreVisivel(F As Form, OnTop As Boolean)
   Dim Switch As Integer

   If OnTop Then
      Switch = -1                                 'em primeiro plano
   Else
      Switch = -2                                 'em segundo plano
   End If
   Call SetWindowPos(F.hWnd, Switch, 0, 0, 0, 0, &H53)
End Sub
