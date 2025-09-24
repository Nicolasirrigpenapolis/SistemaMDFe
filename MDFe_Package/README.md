# 🚛 **MDFe Package - Completo e Atualizado v1.2.2.337**

## 📦 **Pacote Profissional para Integração MDFe - Modal Rodoviário**

Este é um pacote **completo e funcional** para integração do **Manifesto Eletrônico de Documentos Fiscais (MDF-e)** em projetos ASP.NET, baseado na versão oficial **ACBrLibMDFe v1.2.2.337** com suporte à **Nota Técnica 2025.001**.

---

## 🎯 **CARACTERÍSTICAS PRINCIPAIS**

✅ **Versão Oficial Completa**: ACBrLibMDFe v1.2.2.337 com todas as DLLs e dependências
✅ **Modal Rodoviário**: Especializado para transporte de carga por caminhões
✅ **Nota Técnica 2025.001**: Suporte completo às novas funcionalidades
✅ **88 Schemas XSD**: Validação local completa
✅ **8 Versões de DLL**: Para diferentes arquiteturas e convenções
✅ **Código ASP.NET**: Classes e controllers prontos para usar
✅ **Documentação Completa**: Guias e exemplos detalhados

---

## 📁 **ESTRUTURA DO PACOTE**

```
MDFe_Package/
├── 📂 Binaries/                    # DLLs Oficiais v1.2.2.337
│   ├── 📂 x64/                    # Aplicações 64 bits
│   │   ├── 📂 MT_Cdecl/           # ⭐ RECOMENDADO para ASP.NET
│   │   ├── 📂 MT_StdCall/         # MultiThread StdCall
│   │   ├── 📂 ST_Cdecl/           # SingleThread Cdecl
│   │   └── 📂 ST_StdCall/         # SingleThread StdCall
│   └── 📂 x86/                    # Aplicações 32 bits
│       ├── 📂 MT_Cdecl/           # MultiThread Cdecl
│       ├── 📂 MT_StdCall/         # MultiThread StdCall
│       ├── 📂 ST_Cdecl/           # SingleThread Cdecl
│       └── 📂 ST_StdCall/         # SingleThread StdCall
├── 📂 Config/                     # Arquivos de Configuração
│   ├── ACBrLib.ini               # Configurações principais
│   ├── MDFeTemplate.ini          # Template padrão rodoviário
│   ├── MDFeTemplate_NotaTecnica2025.ini # Com NT 2025.001
│   └── ACBrMDFeServicos.ini      # URLs dos webservices SEFAZ
├── 📂 Schemas/                    # 88 Arquivos XSD de Validação
│   └── 📂 MDFe/                  # Schemas oficiais da SEFAZ
├── 📂 XML_Templates/              # Exemplos de XML
│   └── MDFe_Rodoviario_Exemplo_Completo.xml
├── 📂 Exemplos_ASP.NET/           # Código ASP.NET Pronto
│   ├── MDFeService.cs            # Serviço completo
│   ├── MDFeController.cs         # Controller com todos endpoints
│   ├── Program.cs                # Configuração da aplicação
│   └── exemplo.csproj            # Projeto configurado
├── 📂 ACBrLibMDFe-Windows-1.2.2.337/ # Pacote oficial original
├── 📄 GUIA_COMPLETO_ACBrLibMDFe.md    # Documentação técnica completa
├── 📄 INSTALACAO_DETALHADA.md         # Guia de instalação passo-a-passo
└── 📄 README.md                       # Este arquivo
```

---

## 🚀 **INÍCIO RÁPIDO**

### **1️⃣ Para ASP.NET (.NET 8.0)**

1. **Copie os binários**:
   ```bash
   Binaries/x64/MT_Cdecl/*.dll → SeuProjeto/
   ```

2. **Copie as configurações**:
   ```bash
   Config/*.ini → SeuProjeto/
   ```

3. **Configure o .csproj**:
   ```xml
   <PropertyGroup>
     <Platforms>x64</Platforms>
     <RuntimeIdentifier>win-x64</RuntimeIdentifier>
   </PropertyGroup>

   <ItemGroup>
     <Content Include="*.dll;*.ini">
       <CopyToOutputDirectory>Always</CopyToOutputDirectory>
     </Content>
   </ItemGroup>
   ```

4. **Use os exemplos**:
   - Copie `Exemplos_ASP.NET/MDFeService.cs`
   - Copie `Exemplos_ASP.NET/MDFeController.cs`
   - Configure no `Program.cs`: `builder.Services.AddScoped<IMDFeService, MDFeService>();`

### **2️⃣ Teste Básico**

```csharp
var mdfeService = new MDFeService();

// Configurar ambiente de homologação
mdfeService.ConfigurarAmbiente(2);

// Verificar status do serviço
var status = mdfeService.StatusServico();
Console.WriteLine(status);

// Gerar MDFe
var xml = mdfeService.GerarMDFe("MDFeTemplate.ini");
Console.WriteLine("MDFe gerado com sucesso!");
```

---

## 📋 **FUNCIONALIDADES COMPLETAS**

### **🔧 Operações Principais**
- ✅ **Gerar MDFe** - A partir de templates INI
- ✅ **Assinar MDFe** - Certificado digital integrado
- ✅ **Validar MDFe** - Validação local com schemas XSD
- ✅ **Transmitir MDFe** - Envio direto para SEFAZ
- ✅ **Consultar MDFe** - Por chave de acesso
- ✅ **Status Serviço** - Verificar disponibilidade SEFAZ

### **📋 Eventos Rodoviários**
- ✅ **Cancelar MDFe** - Com justificativa
- ✅ **Encerrar MDFe** - Ao chegar no destino
- ✅ **Incluir Condutor** - Adicionar motoristas
- ✅ **Incluir Documentos** - CT-e, NF-e adicionais
- ✅ **Consultar Não Encerrados** - Lista pendentes

### **🆕 Nota Técnica 2025.001**
- ✅ **Nova Categoria de Carga**: 12 - Granel Pressurizada
- ✅ **Vale-Pedágio IDVPO**: Identificador obrigatório
- ✅ **Componente Frete**: Novo tipo de pagamento
- ✅ **Status Expandidos**: Códigos 3-4 dígitos

---

## 📖 **DOCUMENTAÇÃO DISPONÍVEL**

| **Arquivo** | **Descrição** |
|-------------|---------------|
| `GUIA_COMPLETO_ACBrLibMDFe.md` | 📚 **Manual técnico completo** - Métodos, configurações, exemplos |
| `INSTALACAO_DETALHADA.md` | 🔧 **Guia passo-a-passo** - Instalação, configuração, deploy |
| `Exemplos_ASP.NET/` | 💻 **Código pronto** - Serviços e controllers funcionais |
| `Config/` | ⚙️ **Templates configurados** - INIs para diferentes cenários |

---

## 🏗️ **ARQUITETURAS SUPORTADAS**

| **Aplicação** | **Pasta Recomendada** | **Observações** |
|---------------|----------------------|------------------|
| **ASP.NET Web** | `Binaries/x64/MT_Cdecl/` | ⭐ **Recomendado** |
| **Console/Windows Service** | `Binaries/x64/ST_Cdecl/` | SingleThread mais eficiente |
| **Windows Forms/WPF** | `Binaries/x64/ST_StdCall/` | Compatibilidade UI |
| **Aplicações Legadas 32-bit** | `Binaries/x86/*/` | Conforme necessidade |

---

## 🔐 **CERTIFICAÇÃO E CONFORMIDADE**

✅ **ACBr Oficial**: Baseado no pacote oficial do Projeto ACBr
✅ **SEFAZ Homologado**: Testado em ambiente de homologação
✅ **Schemas Atualizados**: 88 arquivos XSD oficiais
✅ **Nota Técnica 2025.001**: Totalmente implementada
✅ **SSL/TLS**: Comunicação segura com SEFAZ

---

## ⚡ **PERFORMANCE E CONFIABILIDADE**

- **🚀 MultiThread**: Versões MT para aplicações web
- **🔒 Thread-Safe**: Uso seguro em aplicações concorrentes
- **⚡ Validação Local**: Schemas XSD para validação offline
- **🛡️ Tratamento de Erros**: Códigos de retorno detalhados
- **📊 Logging**: Integração com ILogger do .NET

---

## 📞 **SUPORTE**

### **🏢 Suporte Profissional**
- **ACBr Pro**: https://projetoacbr.com.br/pro/
- Suporte direto com desenvolvedores
- SLA de atendimento garantido

### **👥 Comunidade**
- **Fórum ACBr**: https://www.projetoacbr.com.br/forum/forum/76-acbrlib/
- **Discord ACBr**: https://discord.gg/acbr
- Suporte gratuito da comunidade

---

## 📊 **VERSIONAMENTO**

| **Versão** | **Data** | **Alterações** |
|------------|----------|----------------|
| **1.2.2.337** | **2025-09** | Versão oficial ACBr com NT 2025.001 |
| **1.2.2.336** | 2025-08 | Versão anterior |

---

## ⚖️ **LICENÇA**

Este pacote utiliza a **ACBrLib** que é distribuída sob licença **LGPL**:
- ✅ Uso comercial permitido
- ✅ Modificações permitidas
- ✅ Distribuição livre
- ✅ Código fonte disponível

**Links da Licença**:
- https://pt.wikipedia.org/wiki/GNU_Lesser_General_Public_License
- http://licencas.softwarelivre.org/lgpl-3.0.pt-br.html

---

## 🎯 **CONCLUSÃO**

Este é um **pacote profissional e completo** para integração MDFe em qualquer projeto ASP.NET. Com **zero configuração adicional necessária**, você pode começar a emitir MDFes imediatamente.

**Tudo está incluído**:
- ✅ DLLs oficiais mais recentes
- ✅ Configurações prontas
- ✅ Código ASP.NET funcional
- ✅ Documentação completa
- ✅ Exemplos práticos
- ✅ Suporte à NT 2025.001

**Basta descompactar e usar!** 🚀

---

*MDFe Package v1.2.2.337 - Modal Rodoviário - Setembro 2025*