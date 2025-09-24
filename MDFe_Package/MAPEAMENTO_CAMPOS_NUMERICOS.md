# 🔢 MAPEAMENTO COMPLETO - CAMPOS NUMÉRICOS MDFe

## 🎯 **PROBLEMA RESOLVIDO**
Este guia resolve o problema de **campos numéricos incorretos** quando você implementar o MDFe no seu sistema com cadastros pré-definidos.

⚠️ **CRÍTICO**: Sempre passe **CÓDIGOS NUMÉRICOS**, nunca texto!

---

## 📋 **TABELA COMPLETA - TODOS OS CAMPOS NUMÉRICOS**

### **1️⃣ IDENTIFICAÇÃO (IDE)**

| **Campo INI** | **Nome** | **Valores Aceitos** | **Descrição** |
|---------------|----------|---------------------|---------------|
| `tpAmb` | Tipo Ambiente | `1` = Produção<br>`2` = Homologação | **SEMPRE começar com 2** |
| `tpEmit` | Tipo Emitente | `1` = Transportadora<br>`2` = Carga Própria | **Sempre 1 para transportadoras** |
| `tpTransp` | Tipo Transportador | `1` = ETC<br>`2` = TAC<br>`3` = CTC | **Geralmente 1** |
| `mod` | Modelo | `58` | **SEMPRE 58 para MDFe** |
| `modal` | Modal | `01` = Rodoviário | **SEMPRE 01** |
| `tpEmis` | Forma Emissão | `1` = Normal<br>`2` = Contingência<br>`3` = Regime Especial | **SEMPRE 1** |
| `procEmi` | Processo Emissão | `0` = Aplicativo contribuinte | **SEMPRE 0** |

### **2️⃣ VEÍCULO (VEICTRAÇÃO)**

| **Campo INI** | **Nome** | **Valores Aceitos** | **Descrição** |
|---------------|----------|---------------------|---------------|
| `tpRod` | **Tipo Rodado** | `01` = Truck<br>`02` = Toco<br>`03` = Cavalo Mecânico<br>`04` = VAN<br>`05` = Utilitário<br>`06` = Outros | ⭐ **MAIS COMUM: Truck=01** |
| `tpCar` | **Tipo Carroceria** | `01` = Aberta<br>`02` = Fechada/Baú<br>`03` = Granelera<br>`04` = Porta Container<br>`05` = Sider | ⭐ **MAIS COMUM: Baú=02** |

### **3️⃣ PROPRIETÁRIO VEÍCULO (PROP)**

| **Campo INI** | **Nome** | **Valores Aceitos** | **Descrição** |
|---------------|----------|---------------------|---------------|
| `tpProp` | **Tipo Proprietário** | `0` = TAC - Agregado<br>`1` = TAC - Independente<br>`2` = Outros | ⭐ **MAIS COMUM: Independente=1** |

### **4️⃣ SEGURO (SEG)**

| **Campo INI** | **Nome** | **Valores Aceitos** | **Descrição** |
|---------------|----------|---------------------|---------------|
| `respSeg` | **Responsável Seguro** | `1` = Emitente do MDFe<br>`2` = Contratante do Transporte<br>`3` = Embarcador<br>`4` = Emitente ou Contratante<br>`5` = Destinatário | ⭐ **COMUM: 4=Emitente/Contratante** |

### **5️⃣ CARGA (PRODPRED)**

| **Campo INI** | **Nome** | **Valores Aceitos** | **Descrição** |
|---------------|----------|---------------------|---------------|
| `tpCarga` | **Tipo Carga** | `01` = Granel sólido<br>`02` = Granel líquido<br>`03` = Frigorificada<br>`04` = Conteinerizada<br>`05` = Carga Geral<br>`06` = Neogranel<br>`07` = Perigosa (ONS)<br>`08` = Viva (animais)<br>`09` = Automotores<br>`10` = Passageiros<br>`11` = Excesso de Bagagem<br>`12` = **NOVO 2025**: Granel Pressurizada | ⭐ **MAIS COMUM: 05=Carga Geral** |

### **6️⃣ TOTALIZADORES (TOT)**

| **Campo INI** | **Nome** | **Valores Aceitos** | **Descrição** |
|---------------|----------|---------------------|---------------|
| `cUnid` | **Código Unidade** | `01` = KG (Quilograma)<br>`02` = TON (Tonelada) | ⭐ **SEMPRE usar 01=KG** |

### **7️⃣ PAGAMENTO (INFPAG) - NOTA TÉCNICA 2025.001**

| **Campo INI** | **Nome** | **Valores Aceitos** | **Descrição** |
|---------------|----------|---------------------|---------------|
| `indPag` | **Indicador Pagamento** | `0` = À Vista<br>`1` = À Prazo | **0=À Vista é mais comum** |
| `tpComp` | **Tipo Componente** | `01` = Vale Pedágio<br>`02` = Impostos, taxas e outros<br>`03` = Outros<br>`04` = **NOVO 2025**: Frete | **04=Frete é novidade** |
| `indAntecipaAdiant` | **Antecipa Adiantamento** | `0` = Não<br>`1` = Sim | **Geralmente 0** |

---

## 🚨 **CAMPOS QUE MAIS DÃO PROBLEMA**

### **❌ ERROS COMUNS:**
```ini
# ❌ ERRADO - Nunca passar texto:
tpRod=Truck
tpCar=Baú
tpCarga=Carga Geral

# ✅ CORRETO - Sempre códigos numéricos:
tpRod=01
tpCar=02
tpCarga=05
```

### **⚠️ VALIDAÇÃO NO SEU SISTEMA:**
Quando buscar dados dos cadastros, **SEMPRE** converter para código:

```csharp
// ❌ NUNCA fazer isso:
veiculo.TipoRodado = "Truck";

// ✅ SEMPRE fazer isso:
veiculo.TipoRodadoCodigo = 1; // Truck
veiculo.TipoCarroceriaCodigo = 2; // Baú
```

---

## 📝 **TEMPLATE DE VALIDAÇÃO PARA CADASTROS**

### **Tabela de Conversão para seu Banco de Dados:**

```sql
-- Exemplo de tabela de tipos para seu sistema
CREATE TABLE TiposVeiculo (
    Id INT PRIMARY KEY,
    TipoRodadoDescricao NVARCHAR(50),
    TipoRodadoCodigo INT, -- ← Este é o que vai para o MDFe
    TipoCarroceriaDescricao NVARCHAR(50),
    TipoCarroceriaCodigo INT -- ← Este é o que vai para o MDFe
);

INSERT INTO TiposVeiculo VALUES
(1, 'Truck', 01, 'Baú', 02),
(2, 'Toco', 02, 'Aberta', 01),
(3, 'Cavalo Mecânico', 03, 'Granelera', 03);
```

### **Validação no C#:**
```csharp
public class VeiculoCadastro
{
    public string Placa { get; set; }
    public string TipoRodadoDescricao { get; set; } // Para exibir na tela
    public int TipoRodadoCodigo { get; set; } // ← Para o MDFe
    public string TipoCarroceriaDescricao { get; set; } // Para exibir na tela
    public int TipoCarroceriaCodigo { get; set; } // ← Para o MDFe

    // Método para validar antes de enviar para MDFe
    public void ValidarCodigos()
    {
        if (TipoRodadoCodigo < 1 || TipoRodadoCodigo > 6)
            throw new Exception($"Código tipo rodado inválido: {TipoRodadoCodigo}");

        if (TipoCarroceriaCodigo < 1 || TipoCarroceriaCodigo > 5)
            throw new Exception($"Código tipo carroceria inválido: {TipoCarroceriaCodigo}");
    }
}
```

---

## 🎯 **CHECKLIST DE IMPLEMENTAÇÃO**

### **✅ ANTES DE EMITIR MDFE:**
- [ ] Todos os campos numéricos estão como INT (não string)
- [ ] TipoRodado está entre 01-06
- [ ] TipoCarroceria está entre 01-05
- [ ] TipoCarga está entre 01-12
- [ ] ResponsavelSeguro está entre 1-5
- [ ] TipoProprietario está entre 0-2
- [ ] UnidadeCarga é sempre 01 (KG)

### **✅ VALIDAÇÃO DE CADASTROS:**
- [ ] Veículos têm códigos numéricos salvos no banco
- [ ] Condutores têm CPF válido (11 dígitos)
- [ ] Emitentes têm CNPJ válido (14 dígitos)
- [ ] Códigos municipais são do IBGE (7 dígitos)

---

## 🔍 **DEBUG - CAMPOS NUMÉRICOS**

Se der erro de validação, verificar:

1. **Campo por campo no INI gerado**
2. **Conferir se não tem texto onde deveria ter número**
3. **Validar se código existe na tabela oficial**

```csharp
public void DebugCamposNumericos(string iniPath)
{
    var linhas = File.ReadAllLines(iniPath);

    foreach (var linha in linhas)
    {
        if (linha.StartsWith("tpRod=") && !int.TryParse(linha.Split('=')[1], out _))
            Console.WriteLine($"❌ ERRO: tpRod deve ser numérico: {linha}");

        if (linha.StartsWith("tpCar=") && !int.TryParse(linha.Split('=')[1], out _))
            Console.WriteLine($"❌ ERRO: tpCar deve ser numérico: {linha}");
    }
}
```

---

**💡 DICA FINAL**: Sempre testar em homologação primeiro. A SEFAZ rejeita imediatamente se códigos estiverem errados!