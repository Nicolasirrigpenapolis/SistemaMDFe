using System.Text;
using MDFeApi.Models;
using MDFeApi.Data;
using Microsoft.EntityFrameworkCore;

namespace MDFeApi.Services
{
    /// <summary>
    /// 🚀 NOVA ARQUITETURA SIMPLIFICADA
    /// Responsável por TODA a geração de XML/INI
    /// Frontend envia apenas dados essenciais
    /// </summary>
    public class XMLGenerationService
    {
        private readonly MDFeContext _context;
        private readonly ILogger<XMLGenerationService> _logger;

        public XMLGenerationService(MDFeContext context, ILogger<XMLGenerationService> logger)
        {
            _context = context;
            _logger = logger;
        }

        /// <summary>
        /// Gera XML completo do MDFe baseado apenas em dados essenciais
        /// Busca TODOS os detalhes internamente
        /// </summary>
        public async Task<string> GerarXMLMDFe(MDFe mdfe)
        {
            _logger.LogInformation("Iniciando geração de XML para MDFe {Id}", mdfe.Id);

            var xml = new StringBuilder();

            // === CABEÇALHO XML ===
            xml.AppendLine("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
            xml.AppendLine("<MDFe xmlns=\"http://www.portalfiscal.inf.br/mdfe\">");

            // === INFO MDFE ===
            xml.AppendLine($"  <infMDFe Id=\"MDFe{mdfe.ChaveAcesso}\">");
            xml.AppendLine($"    <ide>");
            xml.AppendLine($"      <cUF>{ObterCodigoUF(mdfe.EmitenteUf)}</cUF>");
            xml.AppendLine($"      <tpAmb>2</tpAmb>"); // Homologação
            xml.AppendLine($"      <tpEmit>1</tpEmit>"); // Prestador
            xml.AppendLine($"      <mod>58</mod>"); // MDFe
            xml.AppendLine($"      <serie>{mdfe.Serie}</serie>");
            xml.AppendLine($"      <nMDF>{mdfe.NumeroMdfe}</nMDF>");
            xml.AppendLine($"      <dhEmi>{mdfe.DataEmissao:yyyy-MM-ddTHH:mm:sszzz}</dhEmi>");
            xml.AppendLine($"      <tpEmis>1</tpEmis>"); // Normal
            xml.AppendLine($"      <procEmi>0</procEmi>"); // Aplicativo contribuinte
            xml.AppendLine($"      <verProc>1.0.0</verProc>");
            xml.AppendLine($"      <UFIni>{mdfe.UfIni}</UFIni>");
            xml.AppendLine($"      <UFFim>{mdfe.UfFim}</UFFim>");

            // === DOCUMENTOS FISCAIS ===
            await AdicionarDocumentosFiscais(xml, mdfe);

            xml.AppendLine($"    </ide>");

            // === EMITENTE ===
            AdicionarEmitente(xml, mdfe);

            // === MODAL RODOVIÁRIO ===
            await AdicionarModalRodoviario(xml, mdfe);

            // === TOTAIS ===
            AdicionarTotais(xml, mdfe);

            xml.AppendLine("  </infMDFe>");
            xml.AppendLine("</MDFe>");

            var xmlCompleto = xml.ToString();
            _logger.LogInformation("XML gerado com sucesso para MDFe {Id}", mdfe.Id);

            return xmlCompleto;
        }

        /// <summary>
        /// 🔍 Busca e adiciona documentos fiscais automaticamente
        /// Backend resolve TODA a complexidade
        /// </summary>
        private async Task AdicionarDocumentosFiscais(StringBuilder xml, MDFe mdfe)
        {
            xml.AppendLine("      <infDoc>");

            // 📄 CTe - busca detalhes por chave
            if (!string.IsNullOrEmpty(mdfe.DocumentosCTeJson))
            {
                var chavesCTe = System.Text.Json.JsonSerializer.Deserialize<List<string>>(mdfe.DocumentosCTeJson);
                foreach (var chave in chavesCTe ?? new List<string>())
                {
                    var cteDetalhes = await BuscarDetalhesCTe(chave);
                    xml.AppendLine("        <infMunDescarga>");
                    xml.AppendLine($"          <cMunDescarga>{cteDetalhes.CodigoMunicipioDescarga}</cMunDescarga>");
                    xml.AppendLine($"          <xMunDescarga>{cteDetalhes.MunicipioDescarga}</xMunDescarga>");
                    xml.AppendLine("          <infCTe>");
                    xml.AppendLine($"            <chCTe>{chave}</chCTe>");
                    if (cteDetalhes.ValorTotal.HasValue)
                        xml.AppendLine($"            <vCarga>{cteDetalhes.ValorTotal:F2}</vCarga>");
                    if (cteDetalhes.PesoBrutoTotal.HasValue)
                        xml.AppendLine($"            <qCarga>{cteDetalhes.PesoBrutoTotal:F3}</qCarga>");
                    xml.AppendLine("          </infCTe>");
                    xml.AppendLine("        </infMunDescarga>");
                }
            }

            // 📄 NFe - busca detalhes por chave
            if (!string.IsNullOrEmpty(mdfe.DocumentosNFeJson))
            {
                var chavesNFe = System.Text.Json.JsonSerializer.Deserialize<List<string>>(mdfe.DocumentosNFeJson);
                foreach (var chave in chavesNFe ?? new List<string>())
                {
                    var nfeDetalhes = await BuscarDetalhesNFe(chave);
                    xml.AppendLine("        <infMunDescarga>");
                    xml.AppendLine($"          <cMunDescarga>{nfeDetalhes.CodigoMunicipioDescarga}</cMunDescarga>");
                    xml.AppendLine($"          <xMunDescarga>{nfeDetalhes.MunicipioDescarga}</xMunDescarga>");
                    xml.AppendLine("          <infNFe>");
                    xml.AppendLine($"            <chNFe>{chave}</chNFe>");
                    if (nfeDetalhes.ValorTotal.HasValue)
                        xml.AppendLine($"            <vNF>{nfeDetalhes.ValorTotal:F2}</vNF>");
                    xml.AppendLine("          </infNFe>");
                    xml.AppendLine("        </infMunDescarga>");
                }
            }

            xml.AppendLine("      </infDoc>");
        }

        private void AdicionarEmitente(StringBuilder xml, MDFe mdfe)
        {
            xml.AppendLine("    <emit>");
            xml.AppendLine($"      <CNPJ>{mdfe.EmitenteCnpj}</CNPJ>");
            xml.AppendLine($"      <IE>{mdfe.EmitenteIe}</IE>");
            xml.AppendLine($"      <xNome>{mdfe.EmitenteRazaoSocial}</xNome>");
            if (!string.IsNullOrEmpty(mdfe.EmitenteNomeFantasia))
                xml.AppendLine($"      <xFant>{mdfe.EmitenteNomeFantasia}</xFant>");
            xml.AppendLine("      <enderEmit>");
            xml.AppendLine($"        <xLgr>{mdfe.EmitenteEndereco}</xLgr>");
            xml.AppendLine($"        <nro>{mdfe.EmitenteNumero}</nro>");
            xml.AppendLine($"        <xBairro>{mdfe.EmitenteBairro}</xBairro>");
            xml.AppendLine($"        <cMun>{mdfe.EmitenteCodMunicipio}</cMun>");
            xml.AppendLine($"        <xMun>{mdfe.EmitenteMunicipio}</xMun>");
            xml.AppendLine($"        <CEP>{mdfe.EmitenteCep}</CEP>");
            xml.AppendLine($"        <UF>{mdfe.EmitenteUf}</UF>");
            xml.AppendLine("      </enderEmit>");
            xml.AppendLine("    </emit>");
        }

        private async Task AdicionarModalRodoviario(StringBuilder xml, MDFe mdfe)
        {
            xml.AppendLine("    <infModal versaoModal=\"3.00\">");
            xml.AppendLine("      <rodo>");

            // === VEÍCULO TRAÇÃO ===
            xml.AppendLine("        <veicTracao>");
            xml.AppendLine($"          <placa>{mdfe.VeiculoPlaca}</placa>");
            xml.AppendLine($"          <tara>{mdfe.VeiculoTara}</tara>");
            xml.AppendLine($"          <UF>{mdfe.VeiculoUf}</UF>");
            xml.AppendLine("        </veicTracao>");

            // === CONDUTOR ===
            xml.AppendLine("        <moto>");
            xml.AppendLine($"          <xNome>{mdfe.CondutorNome}</xNome>");
            xml.AppendLine($"          <CPF>{mdfe.CondutorCpf}</CPF>");
            xml.AppendLine("        </moto>");

            xml.AppendLine("      </rodo>");
            xml.AppendLine("    </infModal>");
        }

        private void AdicionarTotais(StringBuilder xml, MDFe mdfe)
        {
            xml.AppendLine("    <tot>");
            xml.AppendLine($"      <qCTe>{ContarDocumentosCTe(mdfe)}</qCTe>");
            xml.AppendLine($"      <qNFe>{ContarDocumentosNFe(mdfe)}</qNFe>");
            if (mdfe.ValorTotal.HasValue)
                xml.AppendLine($"      <vCarga>{mdfe.ValorTotal:F2}</vCarga>");
            if (mdfe.PesoBrutoTotal.HasValue)
                xml.AppendLine($"      <qCarga>{mdfe.PesoBrutoTotal:F3}</qCarga>");
            xml.AppendLine("    </tot>");
        }

        // === MÉTODOS AUXILIARES ===

        private async Task<(int CodigoMunicipioDescarga, string MunicipioDescarga, decimal? ValorTotal, decimal? PesoBrutoTotal)> BuscarDetalhesCTe(string chave)
        {
            // 🔍 Em produção: integrar com API da SEFAZ ou base de CTe
            // Por enquanto, retorna dados simulados
            return (3550308, "São Paulo", 5000.00m, 1000.000m);
        }

        private async Task<(int CodigoMunicipioDescarga, string MunicipioDescarga, decimal? ValorTotal)> BuscarDetalhesNFe(string chave)
        {
            // 🔍 Em produção: integrar com API da SEFAZ ou base de NFe
            // Por enquanto, retorna dados simulados
            return (3550308, "São Paulo", 3000.00m);
        }

        private int ContarDocumentosCTe(MDFe mdfe)
        {
            if (string.IsNullOrEmpty(mdfe.DocumentosCTeJson)) return 0;
            var chaves = System.Text.Json.JsonSerializer.Deserialize<List<string>>(mdfe.DocumentosCTeJson);
            return chaves?.Count ?? 0;
        }

        private int ContarDocumentosNFe(MDFe mdfe)
        {
            if (string.IsNullOrEmpty(mdfe.DocumentosNFeJson)) return 0;
            var chaves = System.Text.Json.JsonSerializer.Deserialize<List<string>>(mdfe.DocumentosNFeJson);
            return chaves?.Count ?? 0;
        }

        private string ObterCodigoUF(string uf)
        {
            return uf switch
            {
                "SP" => "35",
                "RJ" => "33",
                "MG" => "31",
                "RS" => "43",
                "PR" => "41",
                "SC" => "42",
                _ => "35" // Default SP
            };
        }
    }
}