using Microsoft.EntityFrameworkCore;
using MDFeApi.Data;
using MDFeApi.Models;
using MDFeApi.DTOs;
using MDFeApi.Interfaces;

namespace MDFeApi.Services
{
    /// <summary>
    /// Serviço de negócio MDFe - lógica de negócio e persistência
    /// Responsabilidades:
    /// - CRUD de MDFe
    /// - Validações de negócio
    /// - Numeração sequencial
    /// - Workflow de status
    /// </summary>
    public class MDFeService : IMDFeService
    {
        private readonly MDFeContext _context;
        private readonly ILogger<MDFeService> _logger;
        private readonly IACBrMonitorClient _acbrClient;
        private readonly IACBrResponseParser _acbrParser;
        private readonly IMDFeIniGenerator _iniGenerator;
        private readonly IConfiguration _configuration;

        public MDFeService(
            MDFeContext context,
            ILogger<MDFeService> logger,
            IACBrMonitorClient acbrClient,
            IACBrResponseParser acbrParser,
            IMDFeIniGenerator iniGenerator,
            IConfiguration configuration)
        {
            _context = context;
            _logger = logger;
            _acbrClient = acbrClient;
            _acbrParser = acbrParser;
            _iniGenerator = iniGenerator;
            _configuration = configuration;
        }

        #region Operações CRUD

        public async Task<MDFe> CreateAsync(MDFe mdfe)
        {
            try
            {
                // Gerar número sequencial se não informado
                if (mdfe.NumeroMdfe == 0)
                {
                    mdfe.NumeroMdfe = await ObterProximoNumeroAsync(mdfe.EmitenteId, mdfe.Serie);
                }

                // Status inicial
                if (string.IsNullOrEmpty(mdfe.StatusSefaz))
                {
                    mdfe.StatusSefaz = "Rascunho";
                }

                mdfe.DataEmissao = DateTime.Now;

                _context.MDFes.Add(mdfe);
                await _context.SaveChangesAsync();

                _logger.LogInformation("MDFe {Id} criado - Número: {Numero}", mdfe.Id, mdfe.NumeroMdfe);
                return mdfe;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao criar MDFe");
                throw;
            }
        }

        public async Task<MDFe?> GetByIdAsync(int id)
        {
            return await _context.MDFes
                .Include(m => m.Emitente)
                .Include(m => m.Veiculo)
                .Include(m => m.Condutor)
                .Include(m => m.Contratante)
                .Include(m => m.Reboques)
                .Include(m => m.Seguradora)
                .FirstOrDefaultAsync(m => m.Id == id && m.Ativo);
        }

        public async Task<IEnumerable<MDFe>> GetByEmitenteAsync(int emitenteId)
        {
            return await _context.MDFes
                .Include(m => m.Emitente)
                .Where(m => m.EmitenteId == emitenteId && m.Ativo)
                .OrderByDescending(m => m.DataEmissao)
                .ToListAsync();
        }

        public async Task<MDFe> UpdateAsync(MDFe mdfe)
        {
            var existing = await _context.MDFes.FindAsync(mdfe.Id);
            if (existing == null)
                throw new InvalidOperationException($"MDFe {mdfe.Id} não encontrado");

            if (existing.StatusSefaz != "Rascunho")
                throw new InvalidOperationException("Apenas MDFe em rascunho podem ser editados");

            _context.Entry(existing).CurrentValues.SetValues(mdfe);
            await _context.SaveChangesAsync();
            return existing;
        }

        public async Task<bool> DeleteAsync(int id)
        {
            var mdfe = await _context.MDFes.FindAsync(id);
            if (mdfe == null) return false;

            if (mdfe.StatusSefaz != "Rascunho")
                throw new InvalidOperationException("Apenas MDFe em rascunho podem ser excluídos");

            mdfe.Ativo = false;
            await _context.SaveChangesAsync();
            return true;
        }

        #endregion

        #region Operações de Negócio

        public async Task<int> ObterProximoNumeroAsync(int emitenteId, int serie)
        {
            const int NUMERO_INICIAL = 650;

            var ultimoNumero = await _context.MDFes
                .Where(m => m.EmitenteId == emitenteId && m.Serie == serie)
                .MaxAsync(m => (int?)m.NumeroMdfe) ?? 0;

            // Se não houver MDFes ainda, começar do número inicial (650)
            if (ultimoNumero == 0)
            {
                return NUMERO_INICIAL;
            }

            return ultimoNumero + 1;
        }

        public async Task<(bool valido, List<string> erros)> ValidarAsync(MDFe mdfe)
        {
            var erros = new List<string>();

            // Validações básicas - MANTENDO todos os campos xSeg, etc como estão
            if (mdfe.PesoBrutoTotal <= 0)
                erros.Add("Peso bruto total deve ser maior que zero");

            if (string.IsNullOrEmpty(mdfe.UfIni))
                erros.Add("UF de início é obrigatória");

            return (!erros.Any(), erros);
        }

        #endregion

        #region Métodos SEFAZ

        public async Task<string> GerarXmlAsync(int mdfeId)
        {
            var mdfe = await GetByIdAsync(mdfeId);
            if (mdfe == null)
                throw new InvalidOperationException($"MDFe {mdfeId} não encontrado");

            try
            {
                _logger.LogInformation("Gerando XML para MDFe {Id}", mdfeId);

                // 1. Gerar INI
                var conteudoIni = await _iniGenerator.GerarIniAsync(mdfe);

                // 2. Salvar INI temporariamente
                var pathTemp = Path.Combine(Path.GetTempPath(), $"mdfe_{mdfeId}_{DateTime.Now:yyyyMMddHHmmss}.ini");
                await File.WriteAllTextAsync(pathTemp, conteudoIni, System.Text.Encoding.GetEncoding("ISO-8859-1"));
                _logger.LogInformation("INI salvo em: {Path}", pathTemp);

                // 3. Enviar comando CriarMDFe
                var comando = $"MDFE.CriarMDFe({pathTemp})";
                var resposta = await _acbrClient.ExecutarComandoAsync(comando);

                // 4. Parsear resposta
                var resultado = _acbrParser.ParseResposta(resposta);

                if (!resultado.Sucesso)
                {
                    _logger.LogError("Erro ao gerar XML: {Mensagem}", resultado.Mensagem);
                    throw new InvalidOperationException($"Erro ao gerar XML: {resultado.Mensagem}");
                }

                // 5. XML foi gerado pelo ACBr - retornar mensagem de sucesso
                mdfe.StatusSefaz = "XML_GERADO";
                mdfe.DataUltimaAlteracao = DateTime.Now;
                await _context.SaveChangesAsync();

                _logger.LogInformation("XML gerado com sucesso para MDFe {Id}", mdfeId);

                // Limpar arquivo temporário
                try { File.Delete(pathTemp); } catch { }

                return resultado.RespostaBruta;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao gerar XML do MDFe {Id}", mdfeId);
                throw;
            }
        }

        public async Task<object> TransmitirAsync(int mdfeId)
        {
            var mdfe = await GetByIdAsync(mdfeId);
            if (mdfe == null)
                throw new InvalidOperationException($"MDFe {mdfeId} não encontrado");

            try
            {
                _logger.LogInformation("Transmitindo MDFe {Id} para SEFAZ", mdfeId);

                // 1. Gerar INI
                _logger.LogInformation("[TRANSMITIR] Iniciando geração do arquivo INI para MDFe {Id}", mdfeId);
                var conteudoIni = await _iniGenerator.GerarIniAsync(mdfe);
                
                var pathTemp = Path.Combine(Path.GetTempPath(), $"mdfe_{mdfeId}_{DateTime.Now:yyyyMMddHHmmss}.ini");
                _logger.LogInformation("[TRANSMITIR] Salvando arquivo INI em {Path}", pathTemp);
                await File.WriteAllTextAsync(pathTemp, conteudoIni, System.Text.Encoding.GetEncoding("ISO-8859-1"));
                
                // Logar conteúdo do INI
                _logger.LogInformation("[TRANSMITIR] Conteúdo do arquivo INI para MDFe {Id}:\n{Conteudo}", mdfeId, conteudoIni);

                // 2. Enviar comando CriarEnviarMDFe (tudo em um só comando)
                var lote = mdfe.Lote ?? 1;
                _logger.LogInformation("[TRANSMITIR] Preparando envio para SEFAZ - Lote: {Lote}", lote);
                
                var comando = $"MDFE.CriarEnviarMDFe({pathTemp}, {lote})";
                _logger.LogInformation("[TRANSMITIR] Executando comando ACBr: {Comando}", comando);
                
                var resposta = await _acbrClient.ExecutarComandoAsync(comando);

                // 3. Parsear resposta
                _logger.LogInformation("[TRANSMITIR] Processando resposta da SEFAZ para MDFe {Id}", mdfeId);
                var resultado = _acbrParser.ParseResposta(resposta);
                _logger.LogInformation("[TRANSMITIR] Resposta bruta da SEFAZ:\n{Resposta}", resultado.RespostaBruta);

                if (!resultado.Sucesso)
                {
                    _logger.LogWarning("[TRANSMITIR] MDFe {Id} foi REJEITADO pela SEFAZ", mdfeId);
                    _logger.LogWarning("[TRANSMITIR] Motivo da rejeição: {Mensagem}", resultado.Mensagem);
                    if (resultado.Erros?.Any() == true)
                    {
                        _logger.LogWarning("[TRANSMITIR] Erros detalhados:");
                        foreach (var erro in resultado.Erros)
                        {
                            _logger.LogWarning("[TRANSMITIR] - {Erro}", erro);
                        }
                    }

                    mdfe.StatusSefaz = "REJEITADO";
                    mdfe.XmlRetorno = resultado.RespostaBruta;
                    mdfe.DataUltimaAlteracao = DateTime.Now;
                    await _context.SaveChangesAsync();

                    return new
                    {
                        sucesso = false,
                        mensagem = resultado.Mensagem,
                        erros = resultado.Erros
                    };
                }

                // 4. Atualizar MDFe com dados da SEFAZ
                mdfe.ChaveAcesso = resultado.ChaveMDFe;
                mdfe.Protocolo = resultado.Protocolo;
                mdfe.StatusSefaz = "AUTORIZADO";
                mdfe.DataAutorizacao = DateTime.Now;
                mdfe.XmlRetorno = resultado.RespostaBruta;
                mdfe.DataUltimaAlteracao = DateTime.Now;
                await _context.SaveChangesAsync();

                _logger.LogInformation("MDFe {Id} autorizado com sucesso. Chave: {Chave}, Protocolo: {Protocolo}",
                    mdfeId, resultado.ChaveMDFe, resultado.Protocolo);

                // Limpar arquivo temporário
                try { File.Delete(pathTemp); } catch { }

                return new
                {
                    sucesso = true,
                    mensagem = "MDFe autorizado com sucesso",
                    chave = resultado.ChaveMDFe,
                    protocolo = resultado.Protocolo,
                    dataAutorizacao = mdfe.DataAutorizacao
                };
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao transmitir MDFe {Id}", mdfeId);
                mdfe.StatusSefaz = "ERRO_TRANSMISSAO";
                mdfe.DataUltimaAlteracao = DateTime.Now;
                await _context.SaveChangesAsync();
                throw;
            }
        }

        public async Task<object> ConsultarProtocoloAsync(int mdfeId, string protocolo)
        {
            try
            {
                _logger.LogInformation("Consultando protocolo {Protocolo} do MDFe {Id}", protocolo, mdfeId);

                var comando = $"MDFE.ReciboMDFe({protocolo})";
                var resposta = await _acbrClient.ExecutarComandoAsync(comando);
                var resultado = _acbrParser.ParseResposta(resposta);

                return new
                {
                    sucesso = resultado.Sucesso,
                    mensagem = resultado.Mensagem,
                    dados = resultado.RespostaBruta
                };
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao consultar protocolo {Protocolo}", protocolo);
                throw;
            }
        }

        public async Task<object> ConsultarMDFeAsync(int mdfeId)
        {
            var mdfe = await GetByIdAsync(mdfeId);
            if (mdfe == null)
                throw new InvalidOperationException($"MDFe {mdfeId} não encontrado");

            if (string.IsNullOrEmpty(mdfe.ChaveAcesso))
                throw new InvalidOperationException("MDFe não possui chave de acesso");

            return await ConsultarPorChaveAsync(mdfe.ChaveAcesso);
        }

        public async Task<object> CancelarAsync(int mdfeId, string justificativa)
        {
            if (justificativa.Length < 15)
                throw new ArgumentException("Justificativa deve ter no mínimo 15 caracteres");

            var mdfe = await GetByIdAsync(mdfeId);
            if (mdfe == null)
                throw new InvalidOperationException($"MDFe {mdfeId} não encontrado");

            if (mdfe.StatusSefaz != "AUTORIZADO")
                throw new InvalidOperationException("Apenas MDFe autorizados podem ser cancelados");

            try
            {
                _logger.LogInformation("Cancelando MDFe {Id}. Justificativa: {Just}", mdfeId, justificativa);

                // 1. Gerar INI do evento de cancelamento
                var parametros = new Dictionary<string, string>
                {
                    { "xJust", justificativa }
                };

                var iniEvento = _iniGenerator.GerarIniEvento("110111", mdfe, parametros);
                var pathTemp = Path.Combine(Path.GetTempPath(), $"evento_cancel_{mdfeId}_{DateTime.Now:yyyyMMddHHmmss}.ini");
                await File.WriteAllTextAsync(pathTemp, iniEvento, System.Text.Encoding.GetEncoding("ISO-8859-1"));

                // 2. Enviar evento
                var comando = $"MDFE.EnviarEvento({pathTemp})";
                var resposta = await _acbrClient.ExecutarComandoAsync(comando);

                // 3. Processar resposta
                var resultado = _acbrParser.ParseResposta(resposta);

                if (resultado.Sucesso)
                {
                    mdfe.StatusSefaz = "CANCELADO";
                    mdfe.DataUltimaAlteracao = DateTime.Now;
                    await _context.SaveChangesAsync();

                    _logger.LogInformation("MDFe {Id} cancelado com sucesso", mdfeId);

                    // Limpar arquivo temporário
                    try { File.Delete(pathTemp); } catch { }

                    return new { sucesso = true, mensagem = "MDFe cancelado com sucesso" };
                }
                else
                {
                    _logger.LogWarning("Falha ao cancelar MDFe {Id}: {Mensagem}", mdfeId, resultado.Mensagem);
                    return new { sucesso = false, mensagem = resultado.Mensagem, erros = resultado.Erros };
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao cancelar MDFe {Id}", mdfeId);
                throw;
            }
        }

        public async Task<object> EncerrarAsync(int mdfeId, string? codigoMunicipioEncerramento = null, DateTime? dataEncerramento = null)
        {
            var mdfe = await GetByIdAsync(mdfeId);
            if (mdfe == null)
                throw new InvalidOperationException($"MDFe {mdfeId} não encontrado");

            if (mdfe.StatusSefaz != "AUTORIZADO")
                throw new InvalidOperationException("Apenas MDFe autorizados podem ser encerrados");

            try
            {
                _logger.LogInformation("Encerrando MDFe {Id}", mdfeId);

                // Obter município de encerramento das localidades de descarregamento ou usar fornecido
                string codigoMunicipio = codigoMunicipioEncerramento ?? "3550308"; // Padrão SP

                if (string.IsNullOrEmpty(codigoMunicipioEncerramento) && !string.IsNullOrEmpty(mdfe.LocalidadesDescarregamentoJson))
                {
                    try
                    {
                        var localidades = System.Text.Json.JsonSerializer.Deserialize<List<dynamic>>(mdfe.LocalidadesDescarregamentoJson);
                        if (localidades?.Count > 0)
                        {
                            var primeira = localidades[0];
                            codigoMunicipio = primeira.GetProperty("codigoIBGE").GetInt32().ToString();
                            _logger.LogInformation("Usando município de descarregamento para encerramento: {Codigo}", codigoMunicipio);
                        }
                    }
                    catch (Exception ex)
                    {
                        _logger.LogWarning(ex, "Erro ao extrair município de encerramento, usando padrão");
                    }
                }

                // Parâmetros do encerramento
                var parametros = new Dictionary<string, string>
                {
                    { "dtEnc", (dataEncerramento ?? DateTime.Now).ToString("yyyy-MM-dd") },
                    { "UFEnc", mdfe.UfFim }, // UF de destino
                    { "cMun", codigoMunicipio }
                };

                var iniEvento = _iniGenerator.GerarIniEvento("110112", mdfe, parametros);
                var pathTemp = Path.Combine(Path.GetTempPath(), $"evento_enc_{mdfeId}_{DateTime.Now:yyyyMMddHHmmss}.ini");
                await File.WriteAllTextAsync(pathTemp, iniEvento, System.Text.Encoding.GetEncoding("ISO-8859-1"));

                var comando = $"MDFE.EnviarEvento({pathTemp})";
                var resposta = await _acbrClient.ExecutarComandoAsync(comando);
                var resultado = _acbrParser.ParseResposta(resposta);

                if (resultado.Sucesso)
                {
                    mdfe.StatusSefaz = "ENCERRADO";
                    mdfe.DataUltimaAlteracao = DateTime.Now;
                    await _context.SaveChangesAsync();

                    _logger.LogInformation("MDFe {Id} encerrado com sucesso", mdfeId);

                    // Limpar arquivo temporário
                    try { File.Delete(pathTemp); } catch { }

                    return new { sucesso = true, mensagem = "MDFe encerrado com sucesso" };
                }
                else
                {
                    _logger.LogWarning("Falha ao encerrar MDFe {Id}: {Mensagem}", mdfeId, resultado.Mensagem);
                    return new { sucesso = false, mensagem = resultado.Mensagem, erros = resultado.Erros };
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao encerrar MDFe {Id}", mdfeId);
                throw;
            }
        }

        public async Task<object> ConsultarStatusServicoAsync(string uf)
        {
            try
            {
                _logger.LogInformation("Consultando status do serviço SEFAZ - UF: {UF}", uf);

                var comando = "MDFE.StatusServico";
                var resposta = await _acbrClient.ExecutarComandoAsync(comando);
                var resultado = _acbrParser.ParseResposta(resposta);

                return new
                {
                    sucesso = resultado.Sucesso,
                    mensagem = resultado.Mensagem,
                    dados = resultado.RespostaBruta
                };
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao consultar status do serviço");
                throw;
            }
        }

        public async Task<object> ConsultarPorChaveAsync(string chave)
        {
            try
            {
                _logger.LogInformation("Consultando MDFe por chave: {Chave}", chave);

                var comando = $"MDFE.ConsultarMDFe({chave})";
                var resposta = await _acbrClient.ExecutarComandoAsync(comando);
                var resultado = _acbrParser.ParseResposta(resposta);

                return new
                {
                    sucesso = resultado.Sucesso,
                    mensagem = resultado.Mensagem,
                    dados = resultado.RespostaBruta
                };
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao consultar MDFe por chave {Chave}", chave);
                throw;
            }
        }

        public async Task<object> ConsultarReciboAsync(string recibo)
        {
            try
            {
                _logger.LogInformation("Consultando recibo: {Recibo}", recibo);

                var comando = $"MDFE.ReciboMDFe({recibo})";
                var resposta = await _acbrClient.ExecutarComandoAsync(comando);
                var resultado = _acbrParser.ParseResposta(resposta);

                return new
                {
                    sucesso = resultado.Sucesso,
                    mensagem = resultado.Mensagem,
                    dados = resultado.RespostaBruta
                };
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao consultar recibo {Recibo}", recibo);
                throw;
            }
        }

        public async Task<byte[]> GerarPDFAsync(int mdfeId)
        {
            var mdfe = await GetByIdAsync(mdfeId);
            if (mdfe == null)
                throw new InvalidOperationException($"MDFe {mdfeId} não encontrado");

            if (string.IsNullOrEmpty(mdfe.ChaveAcesso))
                throw new InvalidOperationException("MDFe não possui chave de acesso. Transmita o MDFe primeiro.");

            if (mdfe.StatusSefaz != "AUTORIZADO" && mdfe.StatusSefaz != "ENCERRADO" && mdfe.StatusSefaz != "CANCELADO")
                throw new InvalidOperationException("Apenas MDFe autorizados, encerrados ou cancelados podem gerar PDF");

            try
            {
                _logger.LogInformation("Gerando PDF do DAMDFE para MDFe {Id}", mdfeId);

                // Caminho onde o ACBr Monitor salva os XMLs (configurável no appsettings)
                var pathXml = _configuration.GetValue<string>("ACBrMDFe:PathSalvar", "C:\\ACBrMonitor\\MDFe");
                var xmlFile = Path.Combine(pathXml, $"{mdfe.ChaveAcesso}-mdfe.xml");

                // Verificar se XML existe
                if (!File.Exists(xmlFile))
                {
                    _logger.LogWarning("XML não encontrado em {Path}, tentando gerar novamente", xmlFile);
                    // Se XML não existir, podemos tentar gerar novamente ou usar outro caminho
                    // Por ora, vamos lançar exceção
                    throw new FileNotFoundException($"XML do MDFe não encontrado: {xmlFile}");
                }

                // Caminho temporário para o PDF
                var pdfPath = Path.Combine(Path.GetTempPath(), $"damdfe_{mdfe.ChaveAcesso}_{DateTime.Now:yyyyMMddHHmmss}.pdf");

                // Comando ACBr: MDFE.ImprimirDAMDFePDF(cArqXML, [cProtocolo], [bEncerrado])
                var encerrado = mdfe.StatusSefaz == "ENCERRADO" ? "1" : "0";
                var comando = $"MDFE.ImprimirDAMDFePDF({xmlFile}, {mdfe.Protocolo ?? ""}, {encerrado})";

                _logger.LogInformation("Executando comando ACBr: {Comando}", comando);
                var resposta = await _acbrClient.ExecutarComandoAsync(comando);

                // ACBr Monitor salva o PDF automaticamente no mesmo diretório do XML
                // O nome do PDF geralmente é: chave-mdfe.pdf
                var pdfFile = xmlFile.Replace(".xml", ".pdf");

                // Aguardar um pouco para o arquivo ser criado
                await Task.Delay(1000);

                if (!File.Exists(pdfFile))
                {
                    _logger.LogError("PDF não foi gerado pelo ACBr Monitor. Resposta: {Resposta}", resposta);
                    throw new InvalidOperationException("Erro ao gerar PDF. O ACBr Monitor não criou o arquivo.");
                }

                // Ler o PDF gerado
                var pdfBytes = await File.ReadAllBytesAsync(pdfFile);

                _logger.LogInformation("PDF gerado com sucesso. Tamanho: {Size} bytes", pdfBytes.Length);

                return pdfBytes;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao gerar PDF do MDFe {Id}", mdfeId);
                throw;
            }
        }

        #endregion
    }
}