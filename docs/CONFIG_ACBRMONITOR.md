# 🔧 Configuração do ACBrMonitor

## 📋 Visão Geral

O **ACBrMonitor** é responsável por gerenciar toda a comunicação com a SEFAZ e operações relacionadas a certificados digitais. Este documento detalha como configurar corretamente o `ACBrMonitor.ini`.

---

## 📂 Localização do Arquivo

O arquivo de configuração deve estar localizado no mesmo diretório do executável do ACBrMonitor:

```
C:\ACBrMonitorPlus\ACBrMonitor.ini
```

---

## 🔐 Seção: Certificado Digital

### Configuração Básica

```ini
[Certificado]
# Caminho absoluto do certificado digital .pfx ou .p12
CaminhoArquivo=C:\Certificados\empresa.pfx

# Senha do certificado (ATENÇÃO: Não versionar este arquivo!)
Senha=SuaSenhaAqui

# Número de série (alternativa ao caminho do arquivo)
# NumeroSerie=1234567890ABCDEF
```

### ⚠️ Importante - Segurança

1. **NUNCA** versione o arquivo `ACBrMonitor.ini` com a senha exposta
2. Use permissões de arquivo do Windows para restringir acesso
3. A senha fica apenas no servidor, não transita pela rede
4. Considere usar certificado A3 (token/smartcard) para maior segurança

### Exemplo com Certificado A3 (Token)

```ini
[Certificado]
# Para certificado A3, use o número de série
NumeroSerie=1234567890ABCDEF
Senha=SenhaDoCertificadoA3
```

---

## 🌐 Seção: SEFAZ

### Configuração do Ambiente

```ini
[SEFAZ]
# Ambiente de execução
# 1 = Produção (ATENÇÃO: Emissão real!)
# 2 = Homologação (Testes)
Ambiente=2

# Versão do layout do MDF-e
# 3.00 = Versão atual (recomendada)
VersaoDF=3.00

# Forma de emissão
# 1 = Normal (padrão)
# 2 = Contingência
FormaEmissao=1

# Timeout para webservices (em segundos)
Timeout=30
```

### 🚨 Atenção: Produção vs Homologação

**Homologação (Ambiente=2)**
- ✅ Para testes e desenvolvimento
- ✅ Não tem validade fiscal
- ✅ Use para validar o sistema

**Produção (Ambiente=1)**
- ⚠️ Emite documentos fiscais REAIS
- ⚠️ Gera obrigações fiscais
- ⚠️ Use apenas quando o sistema estiver validado

---

## 📁 Seção: Caminhos de Arquivos

### Diretórios Padrão

```ini
[Caminhos]
# Diretório onde os XMLs dos MDF-e serão salvos
PathMDFe=C:\MDFe\XMLs\

# Diretório para XMLs de eventos (Cancelamento, Encerramento, etc)
PathEventos=C:\MDFe\Eventos\

# Diretório para DAMDFe (PDFs)
PathDAMDFe=C:\MDFe\DAMDFe\

# Diretório temporário para processamento
PathTemp=C:\MDFe\Temp\

# Diretório de logs
PathLogs=C:\MDFe\Logs\
```

### 📌 Observações

- Todos os caminhos devem existir antes de iniciar o ACBrMonitor
- Use caminhos absolutos (não relativos)
- Evite espaços nos nomes de diretórios

---

## 🖨️ Seção: Impressão DAMDFE

```ini
[DAMDFE]
# Tipo de impressão
# 1 = Retrato
# 2 = Paisagem
TipoImpressao=2

# Caminho da logo da empresa (opcional)
LogoMarca=C:\MDFe\Logo.png

# Mostrar preview antes de imprimir
MostrarPreview=1

# Imprimir automaticamente após autorização
ImprimirAutomatico=0
```

---

## 🔌 Seção: TCP/IP (Comunicação com a API)

```ini
[TCP]
# Porta TCP para comunicação com a API
Porta=3434

# Host (deixar 127.0.0.1 para localhost)
Host=127.0.0.1

# Ativar servidor TCP
Ativo=1
```

### Configuração na API (.NET)

No `appsettings.json` da API:

```json
{
  "ACBrMonitor": {
    "Host": "127.0.0.1",
    "Port": 3434,
    "Timeout": 30000
  }
}
```

---

## 📧 Seção: Email (Opcional)

```ini
[Email]
# Servidor SMTP
Host=smtp.gmail.com
Port=587

# Autenticação
Usuario=seu-email@gmail.com
Senha=sua-senha-app

# Configurações de segurança
UsarTLS=1
UsarSSL=0

# Remetente padrão
De=seu-email@gmail.com
NomeRemetente=Empresa Nome
```

---

## 🔧 Exemplo Completo de ACBrMonitor.ini

```ini
# =====================================================
# CONFIGURAÇÃO ACBRMONITOR - SISTEMA MDF-E
# =====================================================

[Certificado]
CaminhoArquivo=C:\Certificados\empresa.pfx
Senha=SenhaSegura123!

[SEFAZ]
Ambiente=2
VersaoDF=3.00
FormaEmissao=1
Timeout=30

[Caminhos]
PathMDFe=C:\MDFe\XMLs\
PathEventos=C:\MDFe\Eventos\
PathDAMDFe=C:\MDFe\DAMDFe\
PathTemp=C:\MDFe\Temp\
PathLogs=C:\MDFe\Logs\

[DAMDFE]
TipoImpressao=2
LogoMarca=C:\MDFe\Logo.png
MostrarPreview=1
ImprimirAutomatico=0

[TCP]
Porta=3434
Host=127.0.0.1
Ativo=1

[Email]
Host=smtp.gmail.com
Port=587
Usuario=seu-email@gmail.com
Senha=sua-senha-app
UsarTLS=1
UsarSSL=0
De=seu-email@gmail.com
NomeRemetente=Sua Empresa
```

---

## 🚀 Comandos ACBr via TCP

### Configurar Certificado (Programaticamente)

```
MDFe.SetCertificado("C:\Certificados\empresa.pfx", "SenhaCertificado")
```

### Configurar Ambiente

```
MDFe.SetAmbiente(2)  // 1=Produção, 2=Homologação
```

### Verificar Certificado

```
MDFe.ObterCertificados                 // Lista todos os certificados
MDFe.CertificadoDataVencimento         // Data de vencimento do atual
```

---

## ✅ Checklist de Configuração

Antes de emitir o primeiro MDF-e:

- [ ] Certificado digital configurado e válido
- [ ] Senha do certificado correta
- [ ] Ambiente configurado (Homologação para testes)
- [ ] Diretórios criados e com permissões de escrita
- [ ] ACBrMonitor rodando na porta configurada
- [ ] API conectando com sucesso ao ACBrMonitor
- [ ] Teste de conexão com SEFAZ bem-sucedido

---

## 🐛 Troubleshooting

### Erro: "Certificado não encontrado"
- ✅ Verificar caminho do arquivo `.pfx`
- ✅ Verificar se arquivo existe e tem permissão de leitura
- ✅ Verificar se senha está correta

### Erro: "Falha na conexão TCP"
- ✅ Verificar se ACBrMonitor está rodando
- ✅ Verificar porta no `ACBrMonitor.ini` e `appsettings.json`
- ✅ Verificar firewall do Windows

### Erro: "Erro de certificado na SEFAZ"
- ✅ Verificar validade do certificado
- ✅ Verificar se certificado é e-CNPJ ou e-CPF válido
- ✅ Verificar se o CNPJ do certificado corresponde ao emitente

### Erro: "Diretório não encontrado"
- ✅ Criar todos os diretórios configurados
- ✅ Verificar permissões de escrita
- ✅ Evitar espaços nos caminhos

---

## 📚 Referências

- [Documentação ACBr](http://www.projetoacbr.com.br/)
- [Manual MDF-e SEFAZ](http://www.nfe.fazenda.gov.br/portal/principal.aspx)
- [Comandos ACBrMonitor](../documentacao.md)

---

**Data:** 2025-10-03
**Versão:** 1.0
**Sistema:** MDF-e .NET + ACBr
