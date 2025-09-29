using Microsoft.AspNetCore.Mvc;
using MDFeApi.Models;
using MDFeApi.DTOs;
using System.Text.Json;
using System.Text.RegularExpressions;

namespace MDFeApi.Controllers
{
    [ApiController]
    [Route("api/validation")]
    public class ValidationController : ControllerBase
    {
        private readonly ILogger<ValidationController> _logger;
        private readonly HttpClient _httpClient;

        public ValidationController(ILogger<ValidationController> logger, HttpClient httpClient)
        {
            _logger = logger;
            _httpClient = httpClient;
        }

        /// <summary>
        /// Consultar CNPJ na BrasilAPI
        /// </summary>
        [HttpGet("cnpj/{cnpj}")]
        public async Task<ActionResult<ApiResponse<CNPJData>>> ConsultarCNPJ(string cnpj)
        {
            try
            {
                // Limpar CNPJ
                var cnpjLimpo = Regex.Replace(cnpj, @"\D", "");

                if (cnpjLimpo.Length != 14)
                {
                    return BadRequest(ApiResponse<CNPJData>.CreateError("CNPJ deve conter 14 dígitos"));
                }

                // Validar CNPJ
                if (!ValidarCNPJ(cnpjLimpo))
                {
                    return BadRequest(ApiResponse<CNPJData>.CreateError("CNPJ inválido"));
                }

                // Consultar BrasilAPI
                var response = await _httpClient.GetAsync($"https://brasilapi.com.br/api/cnpj/v1/{cnpjLimpo}");

                if (!response.IsSuccessStatusCode)
                {
                    if (response.StatusCode == System.Net.HttpStatusCode.NotFound)
                    {
                        return NotFound(ApiResponse<CNPJData>.CreateError("CNPJ não encontrado"));
                    }
                    return StatusCode(500, ApiResponse<CNPJData>.CreateError("Erro ao consultar CNPJ"));
                }

                var jsonContent = await response.Content.ReadAsStringAsync();
                var brasilApiData = JsonSerializer.Deserialize<BrasilApiCNPJResponse>(jsonContent);

                if (brasilApiData == null)
                {
                    return StatusCode(500, ApiResponse<CNPJData>.CreateError("Erro ao processar resposta da consulta"));
                }

                // Mapear para nosso formato
                var cnpjData = new CNPJData
                {
                    Cnpj = brasilApiData.cnpj,
                    RazaoSocial = brasilApiData.razao_social ?? "",
                    NomeFantasia = brasilApiData.nome_fantasia ?? "",
                    Logradouro = brasilApiData.logradouro ?? "",
                    Numero = brasilApiData.numero ?? "",
                    Complemento = brasilApiData.complemento ?? "",
                    Bairro = brasilApiData.bairro ?? "",
                    Municipio = brasilApiData.municipio ?? "",
                    Uf = brasilApiData.uf ?? "",
                    Cep = !string.IsNullOrEmpty(brasilApiData.cep) ? Regex.Replace(brasilApiData.cep, @"\D", "") : "",
                    CodigoMunicipio = int.TryParse(brasilApiData.codigo_municipio, out var codMun) ? codMun : 0,
                    Telefone = !string.IsNullOrEmpty(brasilApiData.ddd_telefone_1)
                        ? $"({brasilApiData.ddd_telefone_1.Substring(0, 2)}) {brasilApiData.ddd_telefone_1.Substring(2)}"
                        : "",
                    Email = brasilApiData.email ?? "",
                    Situacao = brasilApiData.situacao ?? "",
                    DataSituacao = brasilApiData.data_situacao ?? ""
                };

                return Ok(ApiResponse<CNPJData>.CreateSuccess(cnpjData));
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao consultar CNPJ {CNPJ}", cnpj);
                return StatusCode(500, ApiResponse<CNPJData>.CreateError("Erro interno do servidor"));
            }
        }

        /// <summary>
        /// Validar CPF
        /// </summary>
        [HttpPost("cpf")]
        public ActionResult<ApiResponse<bool>> ValidarCPF([FromBody] ValidarDocumentoRequest request)
        {
            try
            {
                var cpfLimpo = Regex.Replace(request.Documento, @"\D", "");
                var valido = ValidarCPFInterno(cpfLimpo);

                return Ok(ApiResponse<bool>.CreateSuccess(valido));
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao validar CPF");
                return StatusCode(500, ApiResponse<bool>.CreateError("Erro interno do servidor"));
            }
        }

        /// <summary>
        /// Validar CNPJ
        /// </summary>
        [HttpPost("cnpj")]
        public ActionResult<ApiResponse<bool>> ValidarCNPJEndpoint([FromBody] ValidarDocumentoRequest request)
        {
            try
            {
                var cnpjLimpo = Regex.Replace(request.Documento, @"\D", "");
                var valido = ValidarCNPJ(cnpjLimpo);

                return Ok(ApiResponse<bool>.CreateSuccess(valido));
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erro ao validar CNPJ");
                return StatusCode(500, ApiResponse<bool>.CreateError("Erro interno do servidor"));
            }
        }

        private bool ValidarCNPJ(string cnpj)
        {
            if (cnpj.Length != 14) return false;

            // Verifica se todos os dígitos são iguais
            if (cnpj.All(c => c == cnpj[0])) return false;

            // Validação do primeiro dígito verificador
            int soma = 0;
            int peso = 5;

            for (int i = 0; i < 12; i++)
            {
                soma += int.Parse(cnpj[i].ToString()) * peso;
                peso = peso == 2 ? 9 : peso - 1;
            }

            int resto1 = soma % 11;
            int dv1 = resto1 < 2 ? 0 : 11 - resto1;

            if (int.Parse(cnpj[12].ToString()) != dv1) return false;

            // Validação do segundo dígito verificador
            soma = 0;
            peso = 6;

            for (int i = 0; i < 13; i++)
            {
                soma += int.Parse(cnpj[i].ToString()) * peso;
                peso = peso == 2 ? 9 : peso - 1;
            }

            int resto2 = soma % 11;
            int dv2 = resto2 < 2 ? 0 : 11 - resto2;

            return int.Parse(cnpj[13].ToString()) == dv2;
        }

        private bool ValidarCPFInterno(string cpf)
        {
            if (cpf.Length != 11) return false;

            // Verifica se todos os dígitos são iguais
            if (cpf.All(c => c == cpf[0])) return false;

            // Algoritmo de validação do CPF
            int soma = 0;

            for (int i = 1; i <= 9; i++)
            {
                soma += int.Parse(cpf.Substring(i - 1, 1)) * (11 - i);
            }

            int resto = soma % 11;
            int dv1 = resto < 2 ? 0 : 11 - resto;

            if (dv1 != int.Parse(cpf.Substring(9, 1))) return false;

            soma = 0;
            for (int i = 1; i <= 10; i++)
            {
                soma += int.Parse(cpf.Substring(i - 1, 1)) * (12 - i);
            }

            resto = soma % 11;
            int dv2 = resto < 2 ? 0 : 11 - resto;

            return dv2 == int.Parse(cpf.Substring(10, 1));
        }
    }

    // DTOs para o controller
    public class ValidarDocumentoRequest
    {
        public string Documento { get; set; } = string.Empty;
    }

    public class CNPJData
    {
        public string Cnpj { get; set; } = string.Empty;
        public string RazaoSocial { get; set; } = string.Empty;
        public string? NomeFantasia { get; set; }
        public string Logradouro { get; set; } = string.Empty;
        public string Numero { get; set; } = string.Empty;
        public string? Complemento { get; set; }
        public string Bairro { get; set; } = string.Empty;
        public string Municipio { get; set; } = string.Empty;
        public string Uf { get; set; } = string.Empty;
        public string Cep { get; set; } = string.Empty;
        public int CodigoMunicipio { get; set; }
        public string? Telefone { get; set; }
        public string? Email { get; set; }
        public string? Situacao { get; set; }
        public string? DataSituacao { get; set; }
    }

    // Resposta da BrasilAPI
    internal class BrasilApiCNPJResponse
    {
        public string cnpj { get; set; } = string.Empty;
        public string? razao_social { get; set; }
        public string? nome_fantasia { get; set; }
        public string? logradouro { get; set; }
        public string? numero { get; set; }
        public string? complemento { get; set; }
        public string? bairro { get; set; }
        public string? municipio { get; set; }
        public string? uf { get; set; }
        public string? cep { get; set; }
        public string? codigo_municipio { get; set; }
        public string? ddd_telefone_1 { get; set; }
        public string? email { get; set; }
        public string? situacao { get; set; }
        public string? data_situacao { get; set; }
    }
}