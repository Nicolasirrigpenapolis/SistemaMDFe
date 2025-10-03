using MDFeApi.DTOs;
using MDFeApi.Interfaces;
using System.Text.RegularExpressions;

namespace MDFeApi.Services
{
    public class ACBrResponseParser : IACBrResponseParser
    {
        private readonly ILogger<ACBrResponseParser> _logger;

        public ACBrResponseParser(ILogger<ACBrResponseParser> logger)
        {
            _logger = logger;
        }

        public ACBrResponseDto ParseResposta(string respostaBruta)
        {
            var dto = new ACBrResponseDto
            {
                RespostaBruta = respostaBruta
            };

            try
            {
                // Verificar se é sucesso ou erro
                if (respostaBruta.StartsWith("OK:", StringComparison.OrdinalIgnoreCase) ||
                    respostaBruta.Contains("OK:", StringComparison.OrdinalIgnoreCase))
                {
                    dto.Sucesso = true;
                    dto.Mensagem = "Operação executada com sucesso";

                    // Extrair chave do MDFe (44 dígitos)
                    var chaveMatch = Regex.Match(respostaBruta, @"(?:Chave|chave)[:\s]+(\d{44})", RegexOptions.IgnoreCase);
                    if (chaveMatch.Success)
                    {
                        dto.ChaveMDFe = chaveMatch.Groups[1].Value;
                        _logger.LogInformation("Chave MDFe extraída: {Chave}", dto.ChaveMDFe);
                    }

                    // Extrair protocolo
                    var protocoloMatch = Regex.Match(respostaBruta, @"(?:Protocolo|protocolo)[:\s]+(\d+)", RegexOptions.IgnoreCase);
                    if (protocoloMatch.Success)
                    {
                        dto.Protocolo = protocoloMatch.Groups[1].Value;
                        _logger.LogInformation("Protocolo extraído: {Protocolo}", dto.Protocolo);
                    }

                    // Extrair caminho do XML gerado (se houver)
                    var xmlMatch = Regex.Match(respostaBruta, @"(?:Arquivo|arquivo|XML)[:\s]+([\w\:\\\/\-\.]+\.xml)", RegexOptions.IgnoreCase);
                    if (xmlMatch.Success)
                    {
                        dto.XmlGerado = xmlMatch.Groups[1].Value;
                        _logger.LogInformation("Caminho XML extraído: {Xml}", dto.XmlGerado);
                    }
                }
                else if (respostaBruta.StartsWith("ERRO:", StringComparison.OrdinalIgnoreCase) ||
                         respostaBruta.Contains("ERRO:", StringComparison.OrdinalIgnoreCase))
                {
                    dto.Sucesso = false;

                    // Extrair mensagem de erro
                    var erroMatch = Regex.Match(respostaBruta, @"ERRO:\s*(.+)", RegexOptions.IgnoreCase | RegexOptions.Singleline);
                    if (erroMatch.Success)
                    {
                        dto.Mensagem = erroMatch.Groups[1].Value.Trim();
                    }
                    else
                    {
                        dto.Mensagem = respostaBruta.Replace("ERRO:", "").Trim();
                    }

                    dto.Erros.Add(dto.Mensagem);
                    _logger.LogWarning("Erro ACBr: {Mensagem}", dto.Mensagem);
                }
                else if (respostaBruta.Contains("Rejeição", StringComparison.OrdinalIgnoreCase) ||
                         respostaBruta.Contains("Rejeitado", StringComparison.OrdinalIgnoreCase))
                {
                    dto.Sucesso = false;
                    dto.Mensagem = "MDFe rejeitado pela SEFAZ";
                    dto.Erros.Add(respostaBruta);
                    _logger.LogWarning("MDFe rejeitado: {Resposta}", respostaBruta);
                }
                else
                {
                    // Resposta não reconhecida - tratar como sucesso se não contém palavras de erro
                    if (!respostaBruta.Contains("falha", StringComparison.OrdinalIgnoreCase) &&
                        !respostaBruta.Contains("erro", StringComparison.OrdinalIgnoreCase))
                    {
                        dto.Sucesso = true;
                        dto.Mensagem = "Operação executada";
                    }
                    else
                    {
                        dto.Sucesso = false;
                        dto.Mensagem = "Resposta não reconhecida do ACBr";
                        dto.Erros.Add(respostaBruta);
                        _logger.LogWarning("Resposta não reconhecida: {Resposta}", respostaBruta);
                    }
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao parsear resposta ACBr");
                dto.Sucesso = false;
                dto.Mensagem = $"Erro ao processar resposta: {ex.Message}";
                dto.Erros.Add(ex.Message);
            }

            return dto;
        }
    }
}
