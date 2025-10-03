# RELATÓRIO DE AUDITORIA TÉCNICA - SISTEMA MDF-e

**Data:** 03/10/2025
**Auditor:** Claude (Assistente de IA)
**Projeto:** Sistema de Gestão com Módulo MDF-e
**Foco:** Integração ACBrMonitor Plus e correção de bugs críticos

---

## 1. SUMÁRIO EXECUTIVO

### Avaliação Geral: **REGULAR COM PONTOS CRÍTICOS**

O projeto apresenta uma arquitetura sólida e bem organizada, mas possui **problemas críticos** na integração ACBr e **bugs graves** que impedem o funcionamento correto do módulo MDF-e. A integração com ACBrMonitor Plus foi implementada recentemente e **NÃO está completamente funcional**.

### Principais Problemas Identificados:

1. ✅ **CORRIGIDO**: Erro ao salvar MDFe como rascunho (campo `UfFim` NULL)
2. ⚠️ **CRÍTICO**: Geração de arquivo INI inconsistente com o modelo oficial
3. ⚠️ **CRÍTICO**: Bug no carregamento de dados ao editar MDFe
4. ⚠️ **ALTO**: Endpoints não implementados retornando sucesso falso
5. ⚠️ **MÉDIO**: Código de UF de Alagoas incorreto no gerador INI

### Recomendações Prioritárias:

1. **IMEDIATO**: Corrigir geração do arquivo INI (estrutura hierárquica incorreta)
2. **IMEDIATO**: Implementar endpoints de rascunho funcionais
3. **IMEDIATO**: Corrigir bug de edição de MDFe
4. **CURTO PRAZO**: Validar integração ACBr completa com testes reais
5. **MÉDIO PRAZO**: Implementar testes automatizados para o módulo MDFe

---

## 2. ANÁLISE GERAL DO PROJETO

### 2.1. Qualidade do Código e Boas Práticas

#### ✅ Pontos Positivos:

- **Arquitetura em Camadas**: Separação clara entre Controllers, Services, Repositories
- **Injeção de Dependências**: Uso adequado de DI com interfaces
- **DTOs Bem Definidos**: Separação entre modelos de domínio e DTOs de API
- **Logging Estruturado**: Uso correto de `ILogger` em todos os serviços
- **Nomenclatura Clara**: Variáveis e métodos com nomes descritivos
- **React com TypeScript**: Frontend tipado e organizado em componentes

#### ⚠️ Problemas Identificados:

##### 1. **Código Duplicado (DRY Violation)**

**Localização**: `MDFe.Api/Services/MDFeIniGenerator.cs` linha 347-361

```csharp
// ❌ PROBLEMA: Mapa de UF duplicado
private string ObterCodigoUF(string uf)
{
    var codigosUF = new Dictionary<string, string>
    {
        {"AC", "12"}, {"AL", "27"}, // ❌ AL deveria ser "17", não "27"
        // ... resto do código
    };
    return codigosUF.GetValueOrDefault(uf, "35");
}
```

**Impacto**: O mesmo mapa existe em `MDFe.cs` linha 623-631 com valores corretos. Há divergência de dados.

**Solução**:
```csharp
// ✅ SOLUÇÃO: Criar classe estática compartilhada
public static class CodigosUF
{
    public static readonly Dictionary<string, string> Codigos = new()
    {
        {"AC", "12"}, {"AL", "17"}, {"AP", "16"}, // ...
    };
}
```

##### 2. **Funções Muito Longas**

**Localização**: `MDFe.Api/Services/MDFeIniGenerator.cs:19-191` (GerarIniAsync)
**Problema**: Método com 173 linhas, responsável por múltiplas tarefas

**Solução**: Refatorar em métodos menores:
```csharp
// ✅ Exemplo de refatoração
private void AdicionarSecaoIde(StringBuilder ini, MDFe mdfe) { }
private void AdicionarSecaoEmit(StringBuilder ini, MDFe mdfe) { }
private void AdicionarSecaoRodo(StringBuilder ini, MDFe mdfe) { }
```

##### 3. **Tratamento de Erros Inconsistente**

**Localização**: `MDFe.Api/Controllers/MDFeBasicController.cs`

```csharp
// ❌ PROBLEMA: Alguns endpoints retornam detalhes, outros não
catch (ArgumentException ex)
{
    return BadRequest(new { message = ex.Message }); // Detalhado
}
catch (Exception ex)
{
    _logger.LogError(ex, "Erro...");
    return StatusCode(500, new { message = "Erro interno" }); // Genérico
}
```

**Solução**: Padronizar respostas de erro com middleware global.

##### 4. **Random em Método de Serviço**

**Localização**: `MDFeIniGenerator.cs:365`

```csharp
// ❌ PROBLEMA: Uso de Random sem seed
private string GerarCodigoAleatorio()
{
    return new Random().Next(10000000, 99999999).ToString();
}
```

**Solução**:
```csharp
// ✅ Usar gerador criptograficamente seguro
private string GerarCodigoAleatorio()
{
    return RandomNumberGenerator.GetInt32(10000000, 99999999).ToString();
}
```

### 2.2. Inconsistências de Arquitetura e Integração

#### ⚠️ CRÍTICO: Endpoints Não Implementados

**Localização**: `MDFeBasicController.cs` linhas 289-320

```csharp
// ❌ PROBLEMA: Endpoints retornam sucesso sem fazer nada
[HttpPost("salvar-rascunho")]
public async Task<ActionResult> SalvarRascunho([FromBody] object mdfeData)
{
    try
    {
        // Implementar lógica de salvar rascunho  ← VAZIO!
        return Ok(new { sucesso = true, mensagem = "Rascunho salvo com sucesso" });
    }
    catch (Exception ex) { ... }
}
```

**Impacto**: Frontend chama estes endpoints e recebe "sucesso falso", causando confusão no usuário.

**Solução Imediata**:
```csharp
[HttpPost("salvar-rascunho")]
public async Task<ActionResult> SalvarRascunho([FromBody] MDFeCreateDto mdfeData)
{
    try
    {
        MDFe mdfe;

        if (mdfeData.Id.HasValue)
        {
            // Atualizar rascunho existente
            mdfe = await _mdfeBusinessService.UpdateMDFeAsync(mdfeData.Id.Value, mdfeData);
        }
        else
        {
            // Criar novo rascunho
            mdfe = await _mdfeBusinessService.CreateMDFeAsync(mdfeData);
        }

        return Ok(new {
            sucesso = true,
            mensagem = "Rascunho salvo com sucesso",
            id = mdfe.Id,
            numero = mdfe.NumeroMdfe
        });
    }
    catch (Exception ex)
    {
        _logger.LogError(ex, "Erro ao salvar rascunho");
        return StatusCode(500, new { sucesso = false, mensagem = ex.Message });
    }
}
```

#### ⚠️ Banco de Dados e ORMs

**Positivo**: Uso correto do Entity Framework Core com migrations

**Problema Encontrado**: Campo `UfFim` definido como `[Required]` mas DTO permite `null`

**Localização**:
- Modelo: `MDFe.cs:142` - `[Required] public string UfFim`
- DTO: `MDFeDTOs.cs:26` - `public string? UfFim` (nullable)

**✅ Correção Aplicada**:
```csharp
// MDFeBusinessService.cs:205-206
mdfe.UfIni = !string.IsNullOrWhiteSpace(mdfeDto.UfIni) ? mdfeDto.UfIni : (emitente?.Uf ?? "RS");
mdfe.UfFim = !string.IsNullOrWhiteSpace(mdfeDto.UfFim) ? mdfeDto.UfFim : (emitente?.Uf ?? "RS");
```

### 2.3. Problemas de Frontend

#### ⚠️ CRÍTICO: Loop Infinito de Re-renderização

**Localização**: `MDFeForm.tsx:65-80`

```tsx
// ❌ PROBLEMA: useEffect sem controle adequado de dependências
useEffect(() => {
  if (dadosHook && Object.keys(dadosHook).length > 0) {
    const idsChanged = // ... validação
    if (idsChanged) {
      onDadosChange({ ...dados, ...dadosHook }); // ← Dispara re-render
    }
  }
}, [dadosHook]); // ← Falta 'dados' nas dependências, mas adicioná-lo causa loop
```

**Solução**:
```tsx
// ✅ Usar useRef para rastrear mudanças anteriores
const prevDadosRef = useRef(dados);

useEffect(() => {
  if (dadosHook && Object.keys(dadosHook).length > 0) {
    const idsChanged =
      dadosHook.emitenteId !== prevDadosRef.current.emitenteId ||
      dadosHook.veiculoId !== prevDadosRef.current.veiculoId;

    if (idsChanged) {
      prevDadosRef.current = { ...dados, ...dadosHook };
      onDadosChange(prevDadosRef.current);
    }
  }
}, [dadosHook, onDadosChange]);
```

#### ⚠️ Responsividade e UX

**Problema**: Interface não otimizada para mobile
**Evidência**: Uso excessivo de tabelas sem scroll horizontal

**Recomendação**: Implementar design responsivo com breakpoints do Tailwind CSS

---

## 3. ANÁLISE APROFUNDADA: MÓDULO MDF-e

### 3.1. Integração com ACBrMonitor Plus

#### ⚠️ CRÍTICO: Geração de INI Inconsistente com Modelo Oficial

**Comparação Documentação vs. Implementação**:

| Seção | Modelo Oficial (ModeloINI.ini) | Implementação Atual | Status |
|-------|-------------------------------|---------------------|--------|
| `[ide]` | ✅ Presente | ✅ Presente | ✅ OK |
| `[perc001]` | ✅ Percurso com índice | ❌ `UFPer1`, `UFPer2` (sem seção) | ❌ ERRO |
| `[CARR001]` | ✅ Carregamento | ❌ Ausente | ❌ FALTA |
| `[emit]` | ✅ Emitente | ✅ Presente | ✅ OK |
| `[Rodo]` | ✅ Modal rodoviário | ❌ `[infModal]` e `[rodo]` | ⚠️ DIVERGENTE |
| `[infANTT]` | ✅ Dados ANTT | ❌ Ausente | ❌ FALTA |
| `[veicTracao]` | ✅ Veículo | ✅ Presente | ✅ OK |
| `[condutor001]` | ✅ Condutor | ✅ Presente | ✅ OK |
| `[infDoc001]` + `[infCTe001001]` | ✅ Hierarquia correta | ❌ `[infDoc001]` + `[infCTe001001]` | ❌ ÍNDICE ERRADO |
| `[tot]` | ✅ Totalizadores | ✅ Presente | ✅ OK |

**ERRO CRÍTICO IDENTIFICADO**:

**Localização**: `MDFeIniGenerator.cs:251-258`

```csharp
// ❌ COMO ESTÁ (ERRADO):
ini.AppendLine($"[infDoc{docIndex:D3}]");
ini.AppendLine($"cMunDescarga={codigoMunicipioDescarga}");
ini.AppendLine($"xMunDescarga={nomeMunicipioDescarga}");
ini.AppendLine();

ini.AppendLine($"[infCTe{docIndex:D3}001]"); // ← ERRO: deveria ser [infCTe001001]
ini.AppendLine($"chCTe={chave}");
```

**Segundo o modelo oficial** (`ModeloINI.ini:458-461`):
```ini
[infDoc001]        ← Primeiro documento
[infCTe001001]     ← Primeiro CTe do primeiro documento (índice fixo 001)

[infDoc002]        ← Segundo documento
[infCTe002001]     ← Primeiro CTe do segundo documento
```

**✅ SOLUÇÃO CORRETA**:

```csharp
// ✅ COMO DEVERIA SER:
int docIndex = 1;

foreach (var chave in chavesCTe ?? new List<string>())
{
    // Grupo de documento
    ini.AppendLine($"[infDoc{docIndex:D3}]");
    ini.AppendLine($"cMunDescarga={codigoMunicipioDescarga}");
    ini.AppendLine($"xMunDescarga={nomeMunicipioDescarga}");
    ini.AppendLine();

    // Primeiro (e único) CTe deste documento (sempre 001)
    ini.AppendLine($"[infCTe{docIndex:D3}001]");
    ini.AppendLine($"chCTe={chave}");
    ini.AppendLine();

    docIndex++;
}
```

#### ⚠️ ALTA: Campos Obrigatórios Ausentes

**Faltando no INI gerado**:

1. **`[CARR001]`** - Município de carregamento (linha 48-54 do modelo)
```ini
[CARR001]
cMunCarrega=3534401
xMunCarrega=OSASCO
dhIniViagem=04/02/2017
```

**Solução**:
```csharp
// Adicionar após seção [rodo]
if (mdfe.MunicipioCarregamento != null)
{
    ini.AppendLine("[CARR001]");
    ini.AppendLine($"cMunCarrega={mdfe.MunicipioCarregamento.Codigo}");
    ini.AppendLine($"xMunCarrega={mdfe.MunicipioCarregamento.Nome}");
    ini.AppendLine($"dhIniViagem={mdfe.DataInicioViagem:dd/MM/yyyy}");
    ini.AppendLine();
}
```

2. **`[infANTT]`** - Dados RNTRC (linha 104-108)
```ini
[infANTT]
RNTRC=22222222
```

**Solução**:
```csharp
// Adicionar após [Rodo]
if (!string.IsNullOrEmpty(mdfe.EmitenteRntrc))
{
    ini.AppendLine("[infANTT]");
    ini.AppendLine($"RNTRC={mdfe.EmitenteRntrc}");
    ini.AppendLine();
}
```

3. **`[perc001]`** - Percurso (linha 36-44)

**Como está (ERRADO)**:
```csharp
// Linha 60: sem seção
ini.AppendLine($"UFPer{(i + 1):D3}={percursos[i]}");
```

**Como deveria ser**:
```csharp
for (int i = 0; i < percursos?.Count; i++)
{
    ini.AppendLine($"[perc{(i + 1):D3}]");
    ini.AppendLine($"UFPer={percursos[i]}");
    ini.AppendLine();
}
```

#### ⚠️ MÉDIA: Código UF Incorreto

**Localização**: `MDFeIniGenerator.cs:351`

```csharp
{"AL", "27"}, // ❌ ERRADO - Alagoas é 27 (código IBGE)
```

**Correção**:
```csharp
{"AL", "17"}, // ✅ CORRETO - Código UF de Alagoas para MDFe
```

**Tabela Correta** (conforme `MDFe.cs:623-631`):
| UF | Código |
|----|--------|
| AL | **17** |
| TO | **27** |

#### ✅ Comunicação ACBr Correta

**Localização**: `ACBrMonitorClient.cs:25-65`

```csharp
// ✅ IMPLEMENTAÇÃO CORRETA
public async Task<string> ExecutarComandoAsync(string comando)
{
    // Encoding correto: ISO-8859-1
    var comandoFormatado = $"{comando}\r\n.\r\n"; // ✅ Formato correto
    // ...
}
```

**Confere com documentação** (`documentacao.md:569`):
> MDFe.CriarEnviarMDFe("C:\\ACBrMonitorPLUS\\Entrada\\MDFe.INI", 1, 1)

### 3.2. Bug: Erro ao Salvar como Rascunho

**Status**: ✅ **CORRIGIDO**

**Causa Raiz Identificada**:
- Campo `UfFim` no modelo `MDFe.cs` é `[Required]`
- DTO `MDFeCreateDto` permite `UfFim` como nullable (`string?`)
- Ao salvar rascunho sem preencher, tentava inserir NULL

**Stack Trace Original**:
```
Cannot insert the value NULL into column 'UfFim', table 'MDFeSystem.dbo.MDFes'
Error at: MDFeBusinessService.cs:line 219 (SaveChangesAsync)
```

**Correção Aplicada**:

```csharp
// ✅ MDFeBusinessService.cs:205-206
// Garantir valores padrão para campos obrigatórios quando vazios
mdfe.UfIni = !string.IsNullOrWhiteSpace(mdfeDto.UfIni)
    ? mdfeDto.UfIni
    : (emitente?.Uf ?? "RS");

mdfe.UfFim = !string.IsNullOrWhiteSpace(mdfeDto.UfFim)
    ? mdfeDto.UfFim
    : (emitente?.Uf ?? "RS");
```

**Teste Recomendado**:
1. Criar MDFe sem preencher UF de início/fim
2. Salvar como rascunho
3. Verificar se usa UF do emitente como padrão

### 3.3. Bug: Falha ao Editar MDFe (Não Carrega Dados)

**Status**: ⚠️ **PARCIALMENTE IDENTIFICADO**

**Fluxo de Edição**:

1. **Frontend** chama: `GET /api/mdfe/data/wizard-complete/{id}`
2. **Backend** retorna estrutura: `{ mdfe: {...}, entities: {...} }`
3. **Frontend** mapeia dados em `FormularioMDFe.tsx:107-187`

**Problema 1: Mapeamento Incompleto**

**Localização**: `FormularioMDFe.tsx:145-162`

```tsx
// ⚠️ PROBLEMA: JSON parseado, mas pode falhar silenciosamente
localidadesCarregamento: mdfe.localidadesCarregamentoJson
  ? JSON.parse(mdfe.localidadesCarregamentoJson)  // ← Pode lançar exceção
  : [],
```

**Solução**:
```tsx
// ✅ Parse seguro com tratamento de erro
const parseJsonSafe = (json: string | null) => {
  if (!json) return [];
  try {
    return JSON.parse(json);
  } catch (error) {
    console.error('Erro ao fazer parse do JSON:', error);
    return [];
  }
};

// Usar:
localidadesCarregamento: parseJsonSafe(mdfe.localidadesCarregamentoJson),
localidadesDescarregamento: parseJsonSafe(mdfe.localidadesDescarregamentoJson),
```

**Problema 2: Campos Não Retornados pelo Backend**

**Localização**: `MDFeBasicController.cs:344-418` (endpoint wizard-complete)

```csharp
// ❌ PROBLEMA: Campos JSON não estão sendo retornados
var resposta = new
{
    mdfe = new
    {
        // ... outros campos
        // ❌ FALTANDO:
        // localidadesCarregamentoJson = mdfe.LocalidadesCarregamentoJson,
        // localidadesDescarregamentoJson = mdfe.LocalidadesDescarregamentoJson,
        // rotaPercursoJson = mdfe.RotaPercursoJson,
        // documentosCTeJson = mdfe.DocumentosCTeJson,
        // documentosNFeJson = mdfe.DocumentosNFeJson,
    }
};
```

**✅ SOLUÇÃO COMPLETA**:

```csharp
// MDFeBasicController.cs - Adicionar campos JSON
var resposta = new
{
    mdfe = new
    {
        // ... campos existentes

        // ✅ Adicionar campos JSON necessários
        localidadesCarregamentoJson = mdfe.LocalidadesCarregamentoJson,
        localidadesDescarregamentoJson = mdfe.LocalidadesDescarregamentoJson,
        rotaPercursoJson = mdfe.RotaPercursoJson,
        documentosCTeJson = mdfe.DocumentosCTeJson,
        documentosNFeJson = mdfe.DocumentosNFeJson,

        // ✅ Adicionar IDs dos reboques
        reboquesIds = mdfe.Reboques?.Select(r => r.ReboqueId).ToList() ?? new List<int>(),
    },
    // ... resto
};
```

**Problema 3: Estado do Formulário Não Sincroniza**

**Localização**: `MDFeForm.tsx:82-115`

```tsx
// ⚠️ PROBLEMA: useEffect carrega apenas se locaisCarregamento.length === 0
useEffect(() => {
  if (isEdicao && dados && !carregandoDados) {
    if (dados.localidadesCarregamento &&
        dados.localidadesCarregamento.length > 0 &&
        locaisCarregamento.length === 0) { // ← Nunca atualiza se já tiver dados
      setLocaisCarregamento(locais);
    }
  }
}, [isEdicao, carregandoDados, dados, locaisCarregamento.length, ...]);
```

**✅ SOLUÇÃO**:

```tsx
// Usar flag de "carregado" ao invés de verificar tamanho do array
const [dadosCarregados, setDadosCarregados] = useState(false);

useEffect(() => {
  if (isEdicao && dados && !carregandoDados && !dadosCarregados) {
    // Carregar localidades de carregamento
    if (dados.localidadesCarregamento && dados.localidadesCarregamento.length > 0) {
      const locais = dados.localidadesCarregamento.map((mun, index) => ({
        id: `carregamento-${index}`,
        uf: mun.uf || '',
        municipio: mun.municipio || '',
        codigoIBGE: mun.codigoIBGE || 0
      }));
      setLocaisCarregamento(locais);
    }

    // ... repetir para outras localidades

    // Marcar como carregado
    setDadosCarregados(true);
    setFormData(dados);
  }
}, [isEdicao, carregandoDados, dados, dadosCarregados, setFormData]);
```

---

## 4. RECOMENDAÇÕES E PLANO DE AÇÃO

### 4.1. Correções Críticas (Ações Imediatas - 1-3 dias)

#### 🔴 **PRIORIDADE 1: Corrigir Geração de INI**

**Arquivo**: `MDFe.Api/Services/MDFeIniGenerator.cs`

**Mudanças necessárias**:

1. **Corrigir índices de documentos** (linha 251-258):

```csharp
// ✅ APLICAR ESTA CORREÇÃO COMPLETA:
private async Task AdicionarDocumentosFiscaisIni(StringBuilder ini, MDFe mdfe)
{
    // ... código de município de descarregamento ...

    int docIndex = 1;

    // CTe
    if (!string.IsNullOrEmpty(mdfe.DocumentosCTeJson))
    {
        try
        {
            var chavesCTe = System.Text.Json.JsonSerializer.Deserialize<List<string>>(mdfe.DocumentosCTeJson);

            foreach (var chave in chavesCTe ?? new List<string>())
            {
                // Seção de descarga do documento
                ini.AppendLine($"[infDoc{docIndex:D3}]");
                ini.AppendLine($"cMunDescarga={codigoMunicipioDescarga}");
                ini.AppendLine($"xMunDescarga={nomeMunicipioDescarga}");
                ini.AppendLine();

                // CTe dentro do documento (sempre 001 = primeiro CTe deste documento)
                ini.AppendLine($"[infCTe{docIndex:D3}001]");
                ini.AppendLine($"chCTe={chave}");
                ini.AppendLine();

                docIndex++;
            }
        }
        catch (Exception ex)
        {
            _logger.LogWarning(ex, "Erro ao processar DocumentosCTeJson");
        }
    }

    // NFe - mesma lógica
    if (!string.IsNullOrEmpty(mdfe.DocumentosNFeJson))
    {
        // ... aplicar mesma correção para NFe
    }
}
```

2. **Adicionar seção CARR001** (após linha 124):

```csharp
// Após seção [rodo]
if (mdfe.MunicipioCarregamento != null)
{
    ini.AppendLine("[CARR001]");
    ini.AppendLine($"cMunCarrega={mdfe.MunicipioCarregamento.Codigo}");
    ini.AppendLine($"xMunCarrega={mdfe.MunicipioCarregamento.Nome}");

    if (mdfe.DataInicioViagem.HasValue)
        ini.AppendLine($"dhIniViagem={mdfe.DataInicioViagem.Value:dd/MM/yyyy HH:mm:ss}");

    ini.AppendLine();
}
```

3. **Adicionar seção infANTT** (após CARR001):

```csharp
if (!string.IsNullOrEmpty(mdfe.EmitenteRntrc))
{
    ini.AppendLine("[infANTT]");
    ini.AppendLine($"RNTRC={mdfe.EmitenteRntrc}");
    ini.AppendLine();
}
```

4. **Corrigir percursos com seções** (linha 53-67):

```csharp
// Percurso (se houver)
if (!string.IsNullOrEmpty(mdfe.RotaPercursoJson))
{
    try
    {
        var percursos = System.Text.Json.JsonSerializer.Deserialize<List<string>>(mdfe.RotaPercursoJson);
        for (int i = 0; i < percursos?.Count; i++)
        {
            ini.AppendLine($"[perc{(i + 1):D3}]");
            ini.AppendLine($"UFPer={percursos[i]}");
            ini.AppendLine();
        }
    }
    catch (Exception ex)
    {
        _logger.LogWarning(ex, "Erro ao processar percursos JSON");
    }
}
```

5. **Corrigir código UF de Alagoas** (linha 351):

```csharp
{"AL", "17"}, // ✅ Corrigido
```

#### 🔴 **PRIORIDADE 2: Implementar Endpoints de Rascunho**

**Arquivo**: `MDFe.Api/Controllers/MDFeBasicController.cs`

**Substituir métodos vazios** (linhas 289-320):

```csharp
/// <summary>
/// Salvar rascunho
/// </summary>
[HttpPost("salvar-rascunho")]
public async Task<ActionResult> SalvarRascunho([FromBody] MDFeCreateDto mdfeData)
{
    try
    {
        MDFe mdfe;

        // Verificar se é atualização ou criação
        if (mdfeData.Id.HasValue && mdfeData.Id > 0)
        {
            mdfe = await _mdfeBusinessService.UpdateMDFeAsync(mdfeData.Id.Value, mdfeData);

            if (mdfe == null)
                return NotFound(new { sucesso = false, mensagem = "MDFe não encontrado" });
        }
        else
        {
            mdfe = await _mdfeBusinessService.CreateMDFeAsync(mdfeData);
        }

        return Ok(new {
            sucesso = true,
            mensagem = "Rascunho salvo com sucesso",
            id = mdfe.Id,
            numero = mdfe.NumeroMdfe,
            chave = mdfe.ChaveAcesso
        });
    }
    catch (ArgumentException ex)
    {
        return BadRequest(new { sucesso = false, mensagem = ex.Message });
    }
    catch (Exception ex)
    {
        _logger.LogError(ex, "Erro ao salvar rascunho");
        return StatusCode(500, new { sucesso = false, mensagem = "Erro ao salvar rascunho" });
    }
}

/// <summary>
/// Carregar rascunho
/// </summary>
[HttpGet("carregar-rascunho/{id}")]
public async Task<ActionResult> CarregarRascunho(int id)
{
    try
    {
        var mdfe = await _mdfeBusinessService.GetMDFeByIdAsync(id);

        if (mdfe == null)
            return NotFound(new { sucesso = false, mensagem = "Rascunho não encontrado" });

        if (mdfe.StatusSefaz != "RASCUNHO")
            return BadRequest(new { sucesso = false, mensagem = "Este MDFe não é um rascunho" });

        return Ok(new {
            sucesso = true,
            dados = mdfe
        });
    }
    catch (Exception ex)
    {
        _logger.LogError(ex, "Erro ao carregar rascunho {Id}", id);
        return StatusCode(500, new { sucesso = false, mensagem = "Erro ao carregar rascunho" });
    }
}
```

#### 🔴 **PRIORIDADE 3: Corrigir Bug de Edição**

**Arquivo 1**: `MDFe.Api/Controllers/MDFeBasicController.cs:344-418`

```csharp
// ✅ Adicionar campos JSON na resposta do endpoint wizard-complete
var resposta = new
{
    mdfe = new
    {
        id = mdfe.Id,
        emitenteId = mdfe.EmitenteId,
        veiculoId = mdfe.VeiculoId,
        condutorId = mdfe.CondutorId,
        contratanteId = mdfe.ContratanteId,
        seguradoraId = mdfe.SeguradoraId,
        numeroMdfe = mdfe.NumeroMdfe,
        serie = mdfe.Serie,
        dataEmissao = mdfe.DataEmissao,
        dataInicioViagem = mdfe.DataInicioViagem,
        ufIni = mdfe.UfIni,
        ufFim = mdfe.UfFim,
        municipioIni = mdfe.MunicipioIni,
        municipioFim = mdfe.MunicipioFim,
        valorTotal = mdfe.ValorTotal,
        pesoBrutoTotal = mdfe.PesoBrutoTotal,
        observacoes = mdfe.InfoAdicional,
        statusSefaz = mdfe.StatusSefaz,
        chaveAcesso = mdfe.ChaveAcesso,
        protocolo = mdfe.Protocolo,

        // ✅ ADICIONAR ESTES CAMPOS:
        localidadesCarregamentoJson = mdfe.LocalidadesCarregamentoJson,
        localidadesDescarregamentoJson = mdfe.LocalidadesDescarregamentoJson,
        rotaPercursoJson = mdfe.RotaPercursoJson,
        documentosCTeJson = mdfe.DocumentosCTeJson,
        documentosNFeJson = mdfe.DocumentosNFeJson,

        // ✅ Reboques
        reboquesIds = mdfe.Reboques?.Select(r => r.ReboqueId).ToList() ?? new List<int>(),

        // Snapshots (manter como está)
        emitenteRazaoSocial = mdfe.EmitenteRazaoSocial,
        // ...
    },
    entities = new
    {
        emitentes = mdfe.Emitente != null ? new[] { mdfe.Emitente } : new object[0],
        veiculos = mdfe.Veiculo != null ? new[] { mdfe.Veiculo } : new object[0],
        condutores = mdfe.Condutor != null ? new[] { mdfe.Condutor } : new object[0],
        contratantes = mdfe.Contratante != null ? new[] { mdfe.Contratante } : new object[0],
        seguradoras = mdfe.Seguradora != null ? new[] { mdfe.Seguradora } : new object[0]
    }
};
```

**Arquivo 2**: `frontend/src/pages/MDFe/FormularioMDFe/FormularioMDFe.tsx:145-162`

```tsx
// ✅ Parse seguro de JSON
const parseJsonSafe = <T,>(json: string | null | undefined, fallback: T): T => {
  if (!json || json.trim() === '') return fallback;
  try {
    return JSON.parse(json) as T;
  } catch (error) {
    console.error('Erro ao fazer parse do JSON:', json, error);
    return fallback;
  }
};

// Usar no mapeamento:
const dadosMapeados: Partial<MDFeData> = {
  // ... campos existentes ...

  // ✅ Parse seguro
  localidadesCarregamento: parseJsonSafe(mdfe.localidadesCarregamentoJson, []),
  localidadesDescarregamento: parseJsonSafe(mdfe.localidadesDescarregamentoJson, []),
  rotaPercurso: parseJsonSafe(mdfe.rotaPercursoJson, []),
  documentosCTe: parseJsonSafe(mdfe.documentosCTeJson, []),
  documentosNFe: parseJsonSafe(mdfe.documentosNFeJson, []),
  reboquesIds: mdfe.reboquesIds || [],
};
```

**Arquivo 3**: `frontend/src/components/UI/Forms/MDFeForm.tsx:82-115`

```tsx
// ✅ Usar flag de carregamento único
const [dadosInicializados, setDadosInicializados] = useState(false);

useEffect(() => {
  // Apenas executar UMA VEZ quando em modo de edição
  if (isEdicao && dados && !carregandoDados && !dadosInicializados) {
    console.log('🔄 Inicializando dados do MDFe para edição:', dados);

    // Carregar localidades de carregamento
    if (dados.localidadesCarregamento && dados.localidadesCarregamento.length > 0) {
      const locais = dados.localidadesCarregamento.map((mun, index) => ({
        id: `carregamento-${index}`,
        uf: mun.uf || '',
        municipio: mun.municipio || '',
        codigoIBGE: mun.codigoIBGE || 0
      }));
      setLocaisCarregamento(locais);
      console.log('✅ Carregados', locais.length, 'locais de carregamento');
    }

    // Carregar localidades de descarregamento
    if (dados.localidadesDescarregamento && dados.localidadesDescarregamento.length > 0) {
      const locais = dados.localidadesDescarregamento.map((mun, index) => ({
        id: `descarregamento-${index}`,
        uf: mun.uf || '',
        municipio: mun.municipio || '',
        codigoIBGE: mun.codigoIBGE || 0
      }));
      setLocaisDescarregamento(locais);
      console.log('✅ Carregados', locais.length, 'locais de descarregamento');
    }

    // Carregar rota
    if (dados.rotaPercurso && dados.rotaPercurso.length > 0) {
      setRotaSelecionada(dados.rotaPercurso);
      console.log('✅ Carregada rota com', dados.rotaPercurso.length, 'UFs');
    }

    // Carregar reboques
    if (dados.reboquesIds && dados.reboquesIds.length > 0) {
      setReboquesSelecionados(dados.reboquesIds);
      console.log('✅ Carregados', dados.reboquesIds.length, 'reboques');
    }

    // Atualizar hook com os IDs
    setFormData(dados);

    // Marcar como inicializado (não executar novamente)
    setDadosInicializados(true);
  }
}, [isEdicao, carregandoDados, dados, dadosInicializados, setFormData]);

// Resetar flag ao mudar de MDFe (limpar formulário)
useEffect(() => {
  if (!isEdicao || !dados?.id) {
    setDadosInicializados(false);
  }
}, [isEdicao, dados?.id]);
```

### 4.2. Melhorias de Médio Prazo (1-2 semanas)

#### 🟡 Refatoração de Código

1. **Criar classe utilitária para códigos UF**

```csharp
// MDFe.Api/Utils/CodigosUF.cs
public static class CodigosUF
{
    public static readonly Dictionary<string, string> Codigos = new()
    {
        {"AC", "12"}, {"AL", "17"}, {"AP", "16"}, {"AM", "13"},
        {"BA", "29"}, {"CE", "23"}, {"DF", "53"}, {"ES", "32"},
        {"GO", "52"}, {"MA", "21"}, {"MT", "51"}, {"MS", "50"},
        {"MG", "31"}, {"PA", "15"}, {"PB", "25"}, {"PR", "41"},
        {"PE", "26"}, {"PI", "22"}, {"RJ", "33"}, {"RN", "24"},
        {"RS", "43"}, {"RO", "11"}, {"RR", "14"}, {"SC", "42"},
        {"SP", "35"}, {"SE", "28"}, {"TO", "27"}
    };

    public static string ObterCodigo(string uf, string padrao = "35")
    {
        return Codigos.GetValueOrDefault(uf?.ToUpper() ?? "", padrao);
    }
}
```

2. **Middleware Global de Exceções**

```csharp
// MDFe.Api/Middleware/ExceptionHandlingMiddleware.cs
public class ExceptionHandlingMiddleware
{
    private readonly RequestDelegate _next;
    private readonly ILogger<ExceptionHandlingMiddleware> _logger;

    public async Task InvokeAsync(HttpContext context)
    {
        try
        {
            await _next(context);
        }
        catch (ArgumentException ex)
        {
            await HandleExceptionAsync(context, ex, 400);
        }
        catch (InvalidOperationException ex)
        {
            await HandleExceptionAsync(context, ex, 409);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Erro não tratado");
            await HandleExceptionAsync(context, ex, 500);
        }
    }

    private static async Task HandleExceptionAsync(HttpContext context, Exception ex, int statusCode)
    {
        context.Response.StatusCode = statusCode;
        context.Response.ContentType = "application/json";

        var response = new
        {
            sucesso = false,
            mensagem = ex.Message,
            erro = ex.GetType().Name
        };

        await context.Response.WriteAsJsonAsync(response);
    }
}
```

3. **Quebrar MDFeIniGenerator em métodos menores**

```csharp
public async Task<string> GerarIniAsync(MDFe mdfe)
{
    var ini = new StringBuilder();

    AdicionarSecaoInfMDFe(ini);
    AdicionarSecaoIde(ini, mdfe);
    AdicionarSecaoPercurso(ini, mdfe);
    AdicionarSecaoEmit(ini, mdfe);
    AdicionarSecaoModalRodoviario(ini, mdfe);
    AdicionarSecaoVeiculoCondutor(ini, mdfe);
    AdicionarSecaoCarregamento(ini, mdfe);
    await AdicionarSecaoDocumentosFiscais(ini, mdfe);
    AdicionarSecaoSeguro(ini, mdfe);
    AdicionarSecaoTotalizadores(ini, mdfe);
    AdicionarSecaoProdutoPredominante(ini, mdfe);

    return ini.ToString();
}

private void AdicionarSecaoIde(StringBuilder ini, MDFe mdfe) { /* ... */ }
private void AdicionarSecaoEmit(StringBuilder ini, MDFe mdfe) { /* ... */ }
// ... etc
```

#### 🟡 Validações de Dados

1. **Validar estrutura do arquivo INI gerado**

```csharp
// MDFe.Api/Validators/IniValidator.cs
public class IniValidator
{
    public (bool IsValid, List<string> Errors) ValidarIni(string iniContent)
    {
        var errors = new List<string>();

        // Validar seções obrigatórias
        if (!iniContent.Contains("[ide]"))
            errors.Add("Seção [ide] obrigatória não encontrada");

        if (!iniContent.Contains("[emit]"))
            errors.Add("Seção [emit] obrigatória não encontrada");

        if (!iniContent.Contains("[tot]"))
            errors.Add("Seção [tot] obrigatória não encontrada");

        // Validar hierarquia de documentos
        var docMatches = Regex.Matches(iniContent, @"\[infDoc(\d{3})\]");
        var cteMatches = Regex.Matches(iniContent, @"\[infCTe(\d{3})(\d{3})\]");

        foreach (Match cte in cteMatches)
        {
            var docNum = cte.Groups[1].Value;
            var subNum = cte.Groups[2].Value;

            if (subNum != "001")
                errors.Add($"Índice incorreto em infCTe{docNum}{subNum} - deve ser infCTe{docNum}001");
        }

        return (!errors.Any(), errors);
    }
}
```

2. **Adicionar validação antes de enviar ao ACBr**

```csharp
// MDFeService.cs
public async Task<string> GerarXmlAsync(int mdfeId)
{
    var mdfe = await _context.MDFes.FindAsync(mdfeId);
    var iniContent = await _iniGenerator.GerarIniAsync(mdfe);

    // ✅ Validar INI antes de enviar
    var validator = new IniValidator();
    var (isValid, errors) = validator.ValidarIni(iniContent);

    if (!isValid)
    {
        _logger.LogError("INI inválido: {Errors}", string.Join("; ", errors));
        throw new InvalidOperationException($"INI gerado é inválido: {string.Join(", ", errors)}");
    }

    // Continuar com envio ao ACBr...
}
```

#### 🟡 Testes Automatizados

**Criar testes unitários para gerador de INI**:

```csharp
// MDFe.Api.Tests/Services/MDFeIniGeneratorTests.cs
public class MDFeIniGeneratorTests
{
    [Fact]
    public async Task GerarIniAsync_DeveGerarEstruturaCTe_Corretamente()
    {
        // Arrange
        var mdfe = CriarMDFeComCTe();
        var generator = new MDFeIniGenerator(/* ... */);

        // Act
        var ini = await generator.GerarIniAsync(mdfe);

        // Assert
        Assert.Contains("[infDoc001]", ini);
        Assert.Contains("[infCTe001001]", ini); // ✅ Índice correto
        Assert.Contains("chCTe=35", ini);
    }

    [Fact]
    public async Task GerarIniAsync_DeveIncluirSecaoCarregamento()
    {
        // Arrange
        var mdfe = CriarMDFeComCarregamento();
        var generator = new MDFeIniGenerator(/* ... */);

        // Act
        var ini = await generator.GerarIniAsync(mdfe);

        // Assert
        Assert.Contains("[CARR001]", ini);
        Assert.Contains("cMunCarrega=", ini);
    }

    [Fact]
    public void ObterCodigoUF_DeveRetornarCodigoCorreto_ParaAlagoas()
    {
        // Arrange
        var generator = new MDFeIniGenerator(/* ... */);

        // Act
        var codigo = generator.ObterCodigoUF("AL");

        // Assert
        Assert.Equal("17", codigo); // ✅ Não "27"
    }
}
```

### 4.3. Sugestões de Longo Prazo (1-3 meses)

#### 🔵 Infraestrutura e DevOps

1. **Pipeline de CI/CD**
   - Configurar GitHub Actions / Azure DevOps
   - Testes automatizados em cada commit
   - Deploy automático para homologação

2. **Monitoramento e Observabilidade**
   - Application Insights / Sentry para rastreamento de erros
   - Dashboards de métricas (tempo de resposta, erros, uso)
   - Alertas para erros críticos

3. **Cache e Performance**
   - Implementar Redis para cache de entidades frequentemente acessadas
   - Otimizar queries do EF Core (usar AsNoTracking quando apropriado)
   - Paginação server-side para listas grandes

#### 🔵 Melhorias de Arquitetura

1. **CQRS (Command Query Responsibility Segregation)**
   - Separar comandos (criar/atualizar) de consultas (listar/buscar)
   - Facilita evolução e manutenção

2. **Event Sourcing para Auditoria**
   - Registrar todos os eventos do MDFe (criado, editado, transmitido, cancelado)
   - Histórico completo de alterações

3. **Feature Flags**
   - Permitir ligar/desligar funcionalidades sem deploy
   - Testes A/B de novas features

#### 🔵 Experiência do Usuário

1. **Wizard Aprimorado**
   - Salvar automaticamente a cada mudança (auto-save)
   - Indicador visual de campos obrigatórios não preenchidos
   - Validação em tempo real

2. **Feedback Visual**
   - Loading skeletons ao invés de spinners
   - Toasts informativos para ações bem-sucedidas
   - Confirmações modais para ações destrutivas

3. **Modo Offline**
   - Service Workers para funcionamento offline
   - Sincronização quando voltar online

---

## 5. CHECKLIST DE VALIDAÇÃO

### Antes de Enviar para Produção:

- [ ] **Geração de INI**
  - [ ] Validar hierarquia de documentos `[infDoc001]` + `[infCTe001001]`
  - [ ] Confirmar seção `[CARR001]` presente
  - [ ] Confirmar seção `[infANTT]` com RNTRC
  - [ ] Validar percursos com seções `[perc001]`
  - [ ] Confirmar código UF "17" para Alagoas

- [ ] **Endpoints de Rascunho**
  - [ ] Salvar rascunho criando novo MDFe
  - [ ] Salvar rascunho atualizando MDFe existente
  - [ ] Carregar rascunho por ID
  - [ ] Validar campos obrigatórios (UfIni, UfFim)

- [ ] **Edição de MDFe**
  - [ ] Endpoint `wizard-complete` retorna campos JSON
  - [ ] Frontend mapeia localidades corretamente
  - [ ] Frontend mapeia rota de percurso
  - [ ] Frontend mapeia documentos (CTe/NFe)
  - [ ] Frontend mapeia reboques
  - [ ] Dados exibidos nos campos do formulário

- [ ] **Integração ACBr**
  - [ ] Testar comando `MDFe.CriarMDFe` com INI gerado
  - [ ] Validar resposta do ACBr
  - [ ] Testar transmissão para SEFAZ (homologação)
  - [ ] Validar XML gerado pela SEFAZ

- [ ] **Testes de Regressão**
  - [ ] Criar MDFe do zero funciona
  - [ ] Editar MDFe carrega dados
  - [ ] Salvar rascunho persiste dados
  - [ ] Transmissão para SEFAZ funciona

---

## 6. CONCLUSÃO

O projeto possui uma **base sólida** com arquitetura bem organizada, mas a integração ACBr apresenta **problemas críticos** que impedem seu funcionamento correto. Os bugs identificados são todos **corrigíveis** e as soluções foram detalhadas neste relatório.

### Próximos Passos Recomendados:

1. **Semana 1**: Aplicar correções críticas (INI, endpoints, edição)
2. **Semana 2**: Validar correções com testes manuais completos
3. **Semana 3**: Testar integração ACBr em ambiente de homologação
4. **Semana 4**: Implementar melhorias de médio prazo (refatoração, validações)

**Tempo Estimado Total**: 4-6 semanas para estabilização completa do módulo MDF-e

### Riscos Residuais:

- **Baixo**: Após correções, integração ACBr deve funcionar conforme esperado
- **Médio**: Possíveis problemas adicionais podem surgir em cenários não testados
- **Mitigação**: Implementar testes automatizados e validação rigorosa

---

**Relatório gerado em:** 03/10/2025
**Próxima revisão recomendada:** Após aplicação das correções críticas
