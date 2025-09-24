# 🚛 GUIA COMPLETO - ACBrLibMDFe v1.2.2.337 - MODAL RODOVIÁRIO

## 📋 **ÍNDICE**
- [Visão Geral](#visão-geral)
- [Arquitetura e Versões](#arquitetura-e-versões)
- [Métodos da API](#métodos-da-api)
- [Configuração Completa](#configuração-completa)
- [Implementação ASP.NET](#implementação-aspnet)
- [Nota Técnica 2025.001](#nota-técnica-2025001)
- [Troubleshooting](#troubleshooting)

---

## 📖 **VISÃO GERAL**

A **ACBrLibMDFe v1.2.2.337** é uma biblioteca compartilhada para integração do **Manifesto Eletrônico de Documentos Fiscais (MDF-e)** especificamente para **transporte rodoviário (caminhões)**.

### **Características Principais:**
- ✅ Suporte completo ao MDFe versão 3.00 - Modal Rodoviário
- ✅ Emissão para transportadoras de carga rodoviária
- ✅ Conformidade com Nota Técnica 2025.001
- ✅ Validação local com schemas XSD
- ✅ Assinatura digital integrada
- ✅ Transmissão direta para SEFAZ

---

## 🏗️ **ARQUITETURA E VERSÕES**

### **Estrutura de DLLs Disponíveis:**

```
Binaries/
├── x64/                          # Aplicações 64 bits
│   ├── MT_Cdecl/                # MultiThread + Cdecl
│   ├── MT_StdCall/              # MultiThread + StdCall
│   ├── ST_Cdecl/                # SingleThread + Cdecl
│   └── ST_StdCall/              # SingleThread + StdCall
└── x86/                          # Aplicações 32 bits
    ├── MT_Cdecl/                # MultiThread + Cdecl
    ├── MT_StdCall/              # MultiThread + StdCall
    ├── ST_Cdecl/                # SingleThread + Cdecl
    └── ST_StdCall/              # SingleThread + StdCall
```

### **Qual Versão Usar?**

| **Cenário** | **Recomendação** | **Pasta** |
|-------------|------------------|-----------|
| **ASP.NET Web** | x64 MultiThread Cdecl | `x64/MT_Cdecl/` |
| **Console App** | x64 SingleThread Cdecl | `x64/ST_Cdecl/` |
| **Windows Forms** | x64 SingleThread StdCall | `x64/ST_StdCall/` |
| **Aplicação 32-bit** | x86 conforme necessidade | `x86/*/` |

### **DLLs em Cada Pasta:**
- `ACBrMDFe64.dll` (ou `ACBrMDFe32.dll`)
- `libcrypto-1_1-x64.dll` - Criptografia OpenSSL
- `libssl-1_1-x64.dll` - SSL/TLS OpenSSL
- `libexslt.dll` - Extensões XSLT
- `libiconv.dll` - Conversão de caracteres
- `libxml2.dll` - Processamento XML
- `libxslt.dll` - Transformação XSLT

---

## 🔧 **MÉTODOS DA API**

### **📋 Inicialização e Controle**

| **Método** | **Descrição** | **Parâmetros** |
|------------|---------------|----------------|
| `MDFE_Inicializar` | Inicializa a biblioteca | `string eIniPath, string eChaveCrypt` |
| `MDFE_Finalizar` | Finaliza e libera recursos | - |
| `MDFE_Nome` | Retorna nome da biblioteca | `StringBuilder sResposta, ref int esTamanho` |
| `MDFE_Versao` | Retorna versão da biblioteca | `StringBuilder sResposta, ref int esTamanho` |

### **⚙️ Configuração**

| **Método** | **Descrição** | **Parâmetros** |
|------------|---------------|----------------|
| `MDFE_ConfigLer` | Lê valor de configuração | `string eSecao, string eChave, StringBuilder sResposta, ref int esTamanho` |
| `MDFE_ConfigGravar` | Grava valor de configuração | `string eSecao, string eChave, string eValor` |
| `MDFE_ConfigGravarArquivo` | Salva configurações em arquivo | `string eArquivoIni` |
| `MDFE_ConfigLerArquivo` | Carrega configurações de arquivo | `string eArquivoIni` |

### **📄 Manipulação de Documentos**

| **Método** | **Descrição** | **Parâmetros** |
|------------|---------------|----------------|
| `MDFE_CarregarXML` | Carrega MDFe de XML | `string eArquivoOuXML` |
| `MDFE_CarregarINI` | Carrega MDFe de INI | `string eArquivoOuINI` |
| `MDFE_Limpar` | Limpa documentos carregados | - |
| `MDFE_Assinar` | Assina digitalmente o MDFe | `StringBuilder sResposta, ref int esTamanho` |
| `MDFE_Validar` | Valida MDFe com schemas | `StringBuilder sResposta, ref int esTamanho` |

### **🌐 Transmissão SEFAZ**

| **Método** | **Descrição** | **Parâmetros** |
|------------|---------------|----------------|
| `MDFE_Enviar` | Envia MDFe para SEFAZ | `int aLote, bool aImprimir, bool aSincrono, StringBuilder sResposta, ref int esTamanho` |
| `MDFE_Consultar` | Consulta MDFe por chave | `string eChaveOuArquivo, bool aExtrairEventos, StringBuilder sResposta, ref int esTamanho` |
| `MDFE_StatusServico` | Verifica status do serviço | `StringBuilder sResposta, ref int esTamanho` |
| `MDFE_ConsultarRecibo` | Consulta recibo de lote | `string aRecibo, StringBuilder sResposta, ref int esTamanho` |

### **📋 Eventos Rodoviários**

| **Método** | **Descrição** | **Parâmetros** |
|------------|---------------|----------------|
| `MDFE_EnviarEvento` | Envia evento para SEFAZ | `string eArquivoOuINI, StringBuilder sResposta, ref int esTamanho` |
| `MDFE_CancelarMDFe` | Cancela MDFe | `string eChave, string eJustificativa, string eCNPJCPF, int nLote, StringBuilder sResposta, ref int esTamanho` |
| `MDFE_EncerrarMDFe` | Encerra MDFe (chegada destino) | `string eArquivoOuINI, StringBuilder sResposta, ref int esTamanho` |
| `MDFE_IncluirCondutor` | Inclui condutor adicional | `string eArquivoOuINI, StringBuilder sResposta, ref int esTamanho` |
| `MDFE_IncluirDFe` | Inclui CT-e/NF-e | `string eArquivoOuINI, StringBuilder sResposta, ref int esTamanho` |

### **🔍 Consultas Especiais**

| **Método** | **Descrição** | **Parâmetros** |
|------------|---------------|----------------|
| `MDFE_ConsultarNaoEncerrados` | Lista MDFe não encerrados | `string eCNPJ, StringBuilder sResposta, ref int esTamanho` |
| `MDFE_DistribuicaoDFe` | Consulta distribuição DFe | `string eCNPJCPF, string eultNSU, string eNSUDistrib, string echDFe, StringBuilder sResposta, ref int esTamanho` |

---

## ⚙️ **CONFIGURAÇÃO COMPLETA**

### **📁 Arquivo ACBrLib.ini**

```ini
[DFe]
UF=SP                           # Estado da transportadora
AmbienteCodigo=2               # 1=Produção, 2=Homologação
Salvar=1                       # Salvar XMLs automaticamente
PathSchemas=Schemas\MDFe\      # Caminho dos schemas XSD
PathMDFe=MDFe\                # Pasta para salvar MDFe
SepararPorCNPJ=1              # Organizar por CNPJ
SepararPorMes=1               # Organizar por mês

[WebServices]
UF=SP                          # UF para webservices
Ambiente=2                     # Ambiente (1=Prod, 2=Homolog)
Timeout=5000                   # Timeout em milissegundos
AjustarAutomaticamente=1       # Ajuste automático de URLs

[Certificados]
NumeroSerie=                   # Número série do certificado
ArquivoPFX=                   # Caminho do arquivo PFX
Senha=                        # Senha do certificado

[MDFe]
FormaEmissao=1                # Forma de emissão (1=Normal)
ModeloDF=58                   # Modelo do documento (58=MDFe)
VersaoDF=3.00                 # Versão do MDFe
```

### **🎯 Templates INI Disponíveis**

| **Template** | **Uso** |
|--------------|---------|
| `MDFeTemplate.ini` | MDFe rodoviário padrão |
| `MDFeTemplate_NotaTecnica2025.ini` | Com alterações NT 2025.001 |

---

## 💻 **IMPLEMENTAÇÃO ASP.NET**

### **🔧 1. Configuração do Projeto**

**Program.cs:**
```csharp
builder.Services.AddScoped<IMDFeService, MDFeService>();
```

**Configuração no .csproj:**
```xml
<PropertyGroup>
  <Platforms>x64</Platforms>
  <RuntimeIdentifier>win-x64</RuntimeIdentifier>
</PropertyGroup>

<ItemGroup>
  <!-- DLLs x64 MT_Cdecl para ASP.NET -->
  <Content Include="Binaries\x64\MT_Cdecl\*.dll">
    <CopyToOutputDirectory>Always</CopyToOutputDirectory>
  </Content>
  <!-- Arquivos de configuração -->
  <Content Include="Config\*.ini">
    <CopyToOutputDirectory>Always</CopyToOutputDirectory>
  </Content>
  <!-- Schemas XSD -->
  <Content Include="Schemas\**\*.xsd">
    <CopyToOutputDirectory>Always</CopyToOutputDirectory>
  </Content>
</ItemGroup>
```

---

## 🆕 **NOTA TÉCNICA 2025.001**

### **📅 Cronograma de Implementação**
- **Homologação**: Julho 2025
- **Produção**: Outubro 2025

### **🔄 Principais Alterações para Transporte Rodoviário**

#### **1. Nova Categoria de Carga**
```ini
[prodPred]
tpCarga=12                    # NOVO: 12 - Granel Pressurizada (ex: gás, combustível)
xProd=Granel Pressurizada
```

**Categorias de Carga Rodoviário:**
- `01` - Granel sólido
- `02` - Granel líquido
- `03` - Frigorificada
- `04` - Conteinerizada
- `05` - Carga Geral
- `06` - Neogranel
- `07` - Perigosa (ONS)
- `08` - Viva (animais)
- `09` - Automotores
- `10` - Passageiros
- `11` - Excesso de Bagagem
- `12` - **NOVO**: Granel Pressurizada

#### **2. Alteração no Vale-Pedágio**
```ini
[infPagDireito]
nCompra={IDVPO_VALE_PEDAGIO}  # ALTERADO: Agora é IDVPO (Identificador Vale Pedágio Obrigatório)
vValePed=50.00
CNPJCPF=12345678000195        # CNPJ da empresa de vale-pedágio
```

#### **3. Novo Componente de Pagamento**
```ini
[Comp001]
tpComp=04                     # NOVO: 04 - Frete
vComp=500.00
xComp=Frete do Transporte
```

#### **4. Códigos de Status Expandidos**
- Códigos `cStat` agora suportam 3-4 dígitos (antes: apenas 3)
- Exemplo: `1001`, `2001`, etc.

---

## 🔧 **TROUBLESHOOTING**

### **❌ Erro: "Unable to load DLL 'ACBrMDFe64.dll'"**

**Possíveis Causas:**
1. DLLs não estão na pasta correta
2. Falta dependências (Visual C++ Redistributable)
3. Arquitetura incorreta (32/64 bits)

**Soluções:**
```csharp
// 1. Verificar se DLLs estão na pasta de output
string dllPath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "ACBrMDFe64.dll");
if (!File.Exists(dllPath))
    throw new FileNotFoundException($"DLL não encontrada: {dllPath}");

// 2. Instalar Visual C++ Redistributable 2019 x64
// 3. Verificar se aplicação é x64
```

### **❌ Erro de Validação RNTRC**

**Problema comum em transportadoras:**
```ini
[infANTT]
RNTRC=48736984               # Obrigatório para transportadoras
```

### **❌ Erro de Placa de Veículo**

```ini
[veicTracao]
placa=ABC1234                # Formato: 3 letras + 4 números
                            # OU ABC1D23 (Mercosul)
```

### **❌ Problema com Condutor**

```ini
[moto001]
xNome=NOME DO MOTORISTA      # Nome completo obrigatório
CPF=12345678901             # CPF válido obrigatório
```

---

## 📞 **SUPORTE**

### **🏢 Profissional**
- **ACBr Pro**: https://projetoacbr.com.br/pro/
- Suporte direto com desenvolvedores
- SLA de atendimento garantido

### **👥 Comunidade**
- **Fórum**: https://www.projetoacbr.com.br/forum/forum/76-acbrlib/
- **Discord**: https://discord.gg/acbr
- Suporte gratuito da comunidade

---

## 📊 **CÓDIGOS DE RETORNO COMUNS**

| **Código** | **Descrição** |
|------------|---------------|
| `0` | Sucesso |
| `-1` | Erro genérico |
| `-2` | Certificado não encontrado |
| `-3` | Erro de rede/timeout |
| `-4` | Erro de validação XML |
| `-5` | Arquivo não encontrado |
| `-6` | Erro de inicialização |

---

*Documentação ACBrLibMDFe v1.2.2.337 - Modal Rodoviário - Atualizada com NT 2025.001*