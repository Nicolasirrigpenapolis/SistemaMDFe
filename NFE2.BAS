'CUIDADO: ROTINA MANUAL
'PROPOSITO: QUANDO FAZIA UMA QUERY MANUAL COM ORDER BY ELE NW DAVA UM ESPAÇO ANTES DE COLOCAR ELE, ASSIM RESULTADO EM UM ERRO A QUERY
'insere uma nova cláusula na expressão SQL
Public Function InsereSQL(ByVal vgExpSQL As String, ByVal vgQual As Integer, ByVal vgOQueInserir As String) As String
   Dim vgRetVal As String, i As Integer, j As Long, x As String, vgExpTop As String
   Dim vgSeleDel As String
   vgRetVal$ = ""                                      'conter toda a exp SQL
   If InStr(UCase$(vgExpSQL$), "DELETE ") Then
      vgSeleDel$ = "DELETE "
   ElseIf InStr(UCase$(vgExpSQL$), "UPDATE ") Then
      vgSeleDel$ = "UPDATE "
   ElseIf InStr(UCase$(vgExpSQL$), "INSERT ") Then
      vgSeleDel$ = "INSERT "
   Else
      vgSeleDel$ = vgClausula$(EXP_SELECT)
   End If
   'Inicio Manual
   If vgQual <> 10 Then
      vgOQueInserir$ = Trim$(vgOQueInserir$)              'cláusula a inserir
   Else
      vgOQueInserir$ = (vgOQueInserir$)                   'cláusula a inserir
   End If
   'Fim Manual
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
   For i = 0 To EXP_TODAS - 1                          'corre todas as cláusulas
      If i = vgQual Then                               'se for a que quer inserir
         x$ = vgOQueInserir$                           'substitui pela informada
      Else                                             'caso contrário
         x$ = ExtraiSQL$(vgExpSQL$, i, True)           'tira cláusula da própria exp SQL
      End If
      If Len(x$) > 0 Or (i = EXP_SELECT And vgSeleDel$ = "DELETE ") Then 'se a cláusula existe segue montando nova exp SQL
         If (i = EXP_FROM Or i = EXP_LEFT_JOIN Or i = EXP_RIGHT_JOIN Or i = EXP_INNER_JOIN Or i = EXP_INNER_ON) And Left$(LTrim$(x$), 1) = "(" Then
            x$ = LTrim$(x$)
            x$ = vbCrLf + "(" + vbCrLf + Mid$(x$, 2)
            j = InStrRev(x$, ")")
            If j > 0 Then
               x$ = Left$(x$, j - 1) + vbCrLf + Mid$(x$, j)
            End If
         End If
         'Inicio Manual
         If vgQual <> 10 Then
            vgRetVal$ = vgRetVal$ + LTrim$(IIf(i = EXP_SELECT, vgSeleDel$, vgClausula$(i))) + x$ + vbCrLf
         Else
            vgRetVal$ = vgRetVal$ + (IIf(i = EXP_SELECT, vgSeleDel$, vgClausula$(i))) + x$ + vbCrLf
         End If
         'Fim Manual
      End If
   Next
   If Len(vgExpTop$) And vgQual <> EXP_SELECT Then
      x$ = ExtraiSQL(vgRetVal$, EXP_SELECT)
      If UCase(Left(x$, 3)) <> "TOP" And UCase(Left(x$, 7)) <> "PERCENT" Then
         x$ = vgExpTop$ + Chr(32) + x$
         vgRetVal$ = InsereSQL(vgRetVal$, EXP_SELECT, x$)
      End If
   End If
   InsereSQL = Trim$(vgRetVal$)                                          'esta é a nova exp SQL
End Function
----------------------------------------------------------------------------------------------------------------------------------------
'CUIDADO: ROTINA MANUAL
'PROPOSITO: QUANDO FAZIA UMA QUERY MANUAL COM ORDER BY ELE NW DAVA UM ESPAÇO ANTES DE COLOCAR ELE, ASSIM RESULTADO EM UM ERRO A QUERY
'PROPOSITO2: QUANDO FAZIA UMA QUERY MANUAL EX.: "WITH" ELE NW RETORNA A QUERY CORRETAMENTE
'Extrai a clausula escolhida da expressao SQL
Public Function ExtraiSQL(ByVal vgExpSQL As String, ByVal vgQualSQL As Integer, Optional vgTiraTop As Variant) As String
   Dim vgPosIni As Integer, vgPosFim As Integer, x As String, vgSeleDel As String
   Dim vgExpNormal As String, vgExpMaiusc As String, i As Integer, j As Integer, p As Integer
   
   Dim vgDelimitador As Byte                      'controla os delimitadores colchetes e plicks
   
   'Proposito quando temos uma query manual Ex.: "With"
   'Ele extrai a sql incorreta quando tem order by
   'Inicio Manual
   If Mid(vgExpSQL, 1, 1) = ";" Then ExtraiSQL = "": Exit Function
   'Fim Manual
   
   vgExpNormal$ = " " + vgExpSQL$ + " "
   vgExpNormal$ = Substitui$(vgExpNormal$, "(" + vbCrLf, "(", SO_UM)
   vgExpNormal$ = Substitui$(vgExpNormal$, vbCrLf + ")", ")", SO_UM)
   vgExpNormal$ = Substitui$(vgExpNormal$, " ,", ",", SO_UM)
   
   'vamos retirar os espaços desnecessários
   vgDelimitador = 0
   For i = 1 To Len(vgExpNormal$)
      If Mid(vgExpNormal$, i, 1) = " " Or Mid(vgExpNormal$, i, 1) = Chr$(13) Or Mid(vgExpNormal$, i, 1) = Chr$(10) Then
         If Mid(vgExpNormal$, i + 1, 1) = " " And vgDelimitador = 0 Then
            vgExpNormal$ = Mid(vgExpNormal$, 1, i - 1) + Mid(vgExpNormal$, i + 1)
            i = i - 1
         ElseIf (Mid(vgExpNormal$, i, 1) = Chr$(13) Or Mid(vgExpNormal$, i, 1) = Chr$(10)) And vgDelimitador = 0 Then
            vgExpNormal$ = Mid(vgExpNormal$, 1, i - 1) + " " + Mid(vgExpNormal$, i + 2)
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
                  x$ = RTrim$(Mid(x$, 1, i - 1))
                  If UCase$(Right$(x$, 4)) = " AND" Then
                     x$ = RTrim$(Left$(x$, Len(x$) - 4))
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
   
   'Inicio Manual
   If vgQualSQL <> 10 Then
      ExtraiSQL = TrimAll$(x$, vbCrLf)
   Else
      If Len(x$) > 0 Then
         ExtraiSQL = " " & TrimAll$(x$, vbCrLf)
      End If
   End If
   'Fim Manual
   
End Function
--------------------------------------------------------------------------------------------------------
'CUIDADO: Rotina Manual
'Proposito: quando o formulario for o da manutenção do contas não deixar entra em modo janela
'troca o modo de apresentação do formulário (grade ou tela cheia)
Public Sub TrocaBrowse(F As Form)
   Dim x As String, z As String, vgRow As Long
   On Error Resume Next                           'evita erros caso não tenha os campos para filtragem no grid na janela de dados, não existirá portanto a picFundo
   With F
      If .WindowState = vbNormal Then
         z$ = .Tag                                'pega tamanho anterior
         x$ = Str$(.Width) + "|" + Str$(.Height)  'salva tamanho atual
         If Len(z$) Then
            .Painel(0).Visible = False            'esconde a tela
            .grdBrowse.Visible = False            'o grid
            .picFundo.Visible = False             'e também os campos para filtro
            .Move .Left, .Top, Val(Parse$(z$, "|")), Val(z$) 'tamanho do form anterior
         End If
         .Tag = x$                                           'guarda o tamanho que estava
      End If
      'Inicio Manual
      If .Name = "frmManuCont" Then .vgEmBrowse = True
      'Fim Manual
      If .vgEmBrowse Then                                    'se esta no módulo de browse
         AjustagrdBrowse F
         vgRow = F.vgTb.AbsolutePosition - 1
         Set F.grdBrowse.RecordSet = F.vgTb
         F.grdBrowse.SelecionaItem vgRow
         On Error Resume Next
         .Painel(0).Visible = False                          'esconde a tela
         .grdBrowse.Visible = True                           'e mostra o grid
         .picFundo.Visible = True                            'e também os campos para filtro
         .grdBrowse.SetFocus
      Else                                        'se está no módulo de tela
         Set F.grdBrowse.RecordSet = Nothing
         .grdBrowse.Visible = False               'esconde o grid
         .picFundo.Visible = False                'e também os campos para filtro
         .Painel(0).Visible = True                'e mostra a tela
         .Reposition
      End If
   End With
   mdiNFe.Menu_Browse.Checked = F.vgEmBrowse    'ajusta menu
End Sub
