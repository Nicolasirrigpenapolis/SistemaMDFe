using MDFeApi.Models;
using MDFeApi.Interfaces;
using MDFeApi.Utils;
using System.Text;
using Microsoft.Extensions.Configuration;

namespace MDFeApi.Services
{
    public class MDFeIniGenerator : IMDFeIniGenerator
    {
        private readonly ILogger<MDFeIniGenerator> _logger;
        private readonly IConfiguration _configuration;

        public MDFeIniGenerator(ILogger<MDFeIniGenerator> logger, IConfiguration configuration)
        {
            _logger = logger;
            _configuration = configuration;
        }

        public async Task<string> GerarIniAsync(MDFe mdfe)
        {
            var ini = new StringBuilder();

            _logger.LogInformation("Gerando INI para MDFe {Id}", mdfe.Id);

            // === SEÇÃO [infMDFe] ===
            ini.AppendLine("[infMDFe]");
            ini.AppendLine("versao=3.00");
            ini.AppendLine();

            // === SEÇÃO [ide] - Identificação do MDFe ===
            ini.AppendLine("[ide]");
            var codUF = CodigosUF.ObterCodigo(mdfe.EmitenteUf);
            _logger.LogInformation("[INI] Código UF: {CodUF} ({UF})", codUF, mdfe.EmitenteUf);
            ini.AppendLine($"cUF={codUF}");

            // Ambiente SEFAZ definido no cadastro do Emitente (1=Produção, 2=Homologação)
            var tipoAmbiente = mdfe.Emitente?.AmbienteSefaz ?? _configuration.GetValue<int>("ACBrMDFe:TipoAmbiente", 2);
            _logger.LogInformation("[INI] Tipo Ambiente: {TipoAmbiente} ({Descricao})", tipoAmbiente, tipoAmbiente == 1 ? "Produção" : "Homologação");
            ini.AppendLine($"tpAmb={tipoAmbiente}");

            _logger.LogInformation("[INI] Tipo Transportador: {TipoTransportador} ({Descricao})", mdfe.TipoTransportador, 
                mdfe.TipoTransportador == 1 ? "ETC" : mdfe.TipoTransportador == 2 ? "TAC" : "CTC");
            ini.AppendLine($"tpEmit={mdfe.TipoTransportador}"); // 1=ETC, 2=TAC, 3=CTC
            ini.AppendLine("mod=58"); // Fixo: 58 = MDFe
            _logger.LogInformation("[INI] Série: {Serie}", mdfe.Serie);
            ini.AppendLine($"serie={mdfe.Serie}");
            
            _logger.LogInformation("[INI] Número MDFe: {Numero}", mdfe.NumeroMdfe);
            ini.AppendLine($"nMDF={mdfe.NumeroMdfe}");
            
            var codMDF = mdfe.CodigoNumericoAleatorio ?? GerarCodigoAleatorio();
            _logger.LogInformation("[INI] Código Numérico: {CodigoNumerico}", codMDF);
            ini.AppendLine($"cMDF={codMDF}");
            
            var codDV = mdfe.CodigoVerificador ?? "0";
            _logger.LogInformation("[INI] Dígito Verificador: {DigitoVerificador}", codDV);
            ini.AppendLine($"cDV={codDV}");
            
            _logger.LogInformation("[INI] Modal: {Modal} (Rodoviário)", mdfe.Modal);
            ini.AppendLine($"modal={mdfe.Modal}"); // 1=Rodoviário
            _logger.LogInformation("[INI] Data/Hora Emissão: {DataEmissao}", mdfe.DataEmissao.ToString("yyyy-MM-ddTHH:mm:sszzz"));
            ini.AppendLine($"dhEmi={mdfe.DataEmissao:yyyy-MM-ddTHH:mm:sszzz}");

            _logger.LogInformation("[INI] Tipo Emissão: 1 (Normal)");
            ini.AppendLine("tpEmis=1"); // 1=Normal

            _logger.LogInformation("[INI] Processo Emissão: 0 (Aplicativo contribuinte)");
            ini.AppendLine("procEmi=0"); // 0=Aplicativo contribuinte

            _logger.LogInformation("[INI] Versão Processo: 1.0.0");
            ini.AppendLine("verProc=1.0.0"); // Versão do sistema

            _logger.LogInformation("[INI] UF Inicial: {UFIni}", mdfe.UfIni);
            ini.AppendLine($"UFIni={mdfe.UfIni}");

            _logger.LogInformation("[INI] UF Final: {UFFim}", mdfe.UfFim);
            ini.AppendLine($"UFFim={mdfe.UfFim}");
            ini.AppendLine();

            // === SEÇÃO [perc001] - Percurso (UFs intermediárias) ===
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

            // === SEÇÃO [emit] - Emitente ===
            ini.AppendLine("[emit]");

            if (!string.IsNullOrEmpty(mdfe.EmitenteCnpj))
            {
                _logger.LogInformation("[INI] CNPJ Emitente: {CNPJ}", mdfe.EmitenteCnpj);
                ini.AppendLine($"CNPJ={mdfe.EmitenteCnpj}");
            }
            else if (!string.IsNullOrEmpty(mdfe.EmitenteCpf))
            {
                _logger.LogInformation("[INI] CPF Emitente: {CPF}", mdfe.EmitenteCpf);
                ini.AppendLine($"CPF={mdfe.EmitenteCpf}");
            }

            _logger.LogInformation("[INI] IE Emitente: {IE}", mdfe.EmitenteIe);
            ini.AppendLine($"IE={mdfe.EmitenteIe}");

            _logger.LogInformation("[INI] Razão Social Emitente: {RazaoSocial}", mdfe.EmitenteRazaoSocial);
            ini.AppendLine($"xNome={mdfe.EmitenteRazaoSocial}");

            if (!string.IsNullOrEmpty(mdfe.EmitenteNomeFantasia))
                ini.AppendLine($"xFant={mdfe.EmitenteNomeFantasia}");

            // Endereço do emitente
            ini.AppendLine($"xLgr={mdfe.EmitenteEndereco}");
            ini.AppendLine($"nro={mdfe.EmitenteNumero ?? "SN"}");

            if (!string.IsNullOrEmpty(mdfe.EmitenteComplemento))
                ini.AppendLine($"xCpl={mdfe.EmitenteComplemento}");

            ini.AppendLine($"xBairro={mdfe.EmitenteBairro}");
            ini.AppendLine($"cMun={mdfe.EmitenteCodMunicipio}");
            ini.AppendLine($"xMun={mdfe.EmitenteMunicipio}");
            ini.AppendLine($"CEP={mdfe.EmitenteCep}");
            ini.AppendLine($"UF={mdfe.EmitenteUf}");
            ini.AppendLine();

            // === SEÇÃO [infModal] - Modal Rodoviário ===
            ini.AppendLine("[infModal]");
            ini.AppendLine("versaoModal=3.00");
            ini.AppendLine();

            // === SEÇÃO [rodo] - Rodoviário ===
            ini.AppendLine("[rodo]");

            // CEPs de Carregamento/Descarregamento (opcionais)
            if (!string.IsNullOrEmpty(mdfe.CepCarregamento))
                ini.AppendLine($"CEPCarga={mdfe.CepCarregamento}");

            if (!string.IsNullOrEmpty(mdfe.CepDescarregamento))
                ini.AppendLine($"CEPDescarga={mdfe.CepDescarregamento}");

            ini.AppendLine();

            // === SEÇÃO [infANTT] - Dados ANTT (se houver RNTRC) ===
            if (!string.IsNullOrEmpty(mdfe.EmitenteRntrc))
            {
                ini.AppendLine("[infANTT]");
                ini.AppendLine($"RNTRC={mdfe.EmitenteRntrc}");
                ini.AppendLine();
            }

            // === SEÇÃO [veicTracao] - Veículo de Tração ===
            ini.AppendLine("[veicTracao]");
            ini.AppendLine($"placa={mdfe.VeiculoPlaca}");
            ini.AppendLine($"tara={mdfe.VeiculoTara ?? 0}");
            ini.AppendLine($"UF={mdfe.VeiculoUf}");

            // Tipo de Rodado e Carroceria conforme tabela SEFAZ
            ini.AppendLine($"tpRod={mdfe.VeiculoTipoRodado}");
            ini.AppendLine($"tpCar={mdfe.VeiculoTipoCarroceria}");
            ini.AppendLine();

            // === SEÇÃO [condutor001] - Condutor ===
            if (!string.IsNullOrEmpty(mdfe.CondutorNome))
            {
                ini.AppendLine("[condutor001]");
                ini.AppendLine($"xNome={mdfe.CondutorNome}");
                ini.AppendLine($"CPF={mdfe.CondutorCpf}");
                ini.AppendLine();
            }

            // === SEÇÃO [CARR001] - Município de Carregamento ===
            if (mdfe.MunicipioCarregamento != null)
            {
                ini.AppendLine("[CARR001]");
                ini.AppendLine($"cMunCarrega={mdfe.MunicipioCarregamento.Codigo}");
                ini.AppendLine($"xMunCarrega={mdfe.MunicipioCarregamento.Nome}");

                if (mdfe.DataInicioViagem.HasValue)
                    ini.AppendLine($"dhIniViagem={mdfe.DataInicioViagem.Value:dd/MM/yyyy}");

                ini.AppendLine();
            }

            // === SEÇÃO [infDoc001] - Documentos Fiscais (CTe/NFe) ===
            await AdicionarDocumentosFiscaisIni(ini, mdfe);

            // === SEÇÃO [seg001] - Seguradora (Opcional) ===
            if (!string.IsNullOrEmpty(mdfe.TipoResponsavelSeguro) && !string.IsNullOrEmpty(mdfe.SeguradoraCnpj))
            {
                ini.AppendLine("[seg001]");
                ini.AppendLine($"respSeg={mdfe.TipoResponsavelSeguro}");
                ini.AppendLine($"CNPJ={mdfe.SeguradoraCnpj}");
                ini.AppendLine($"xSeg={mdfe.SeguradoraRazaoSocial}");
                ini.AppendLine();
            }

            // === SEÇÃO [tot] - Totalizadores ===
            ini.AppendLine("[tot]");
            ini.AppendLine($"qCTe={mdfe.QuantidadeCTe ?? 0}");
            ini.AppendLine($"qNFe={mdfe.QuantidadeNFe ?? 0}");
            ini.AppendLine("qMDFe=1"); // FIXO: sempre 1 (um MDFe por arquivo)
            ini.AppendLine($"vCarga={mdfe.ValorTotal?.ToString("F2", System.Globalization.CultureInfo.InvariantCulture) ?? "0.00"}");
            ini.AppendLine("cUnid=01"); // FIXO: 01=Quilograma
            ini.AppendLine($"qCarga={mdfe.PesoBrutoTotal?.ToString("F3", System.Globalization.CultureInfo.InvariantCulture) ?? "0.000"}");
            ini.AppendLine();

            // === SEÇÃO [prodPred] - Produto Predominante (Opcional) ===
            if (!string.IsNullOrEmpty(mdfe.TipoCarga))
            {
                ini.AppendLine("[prodPred]");
                ini.AppendLine($"tpCarga={mdfe.TipoCarga}");
                ini.AppendLine($"xProd={mdfe.DescricaoProduto ?? "Diversos"}");
                ini.AppendLine();
            }

            var conteudoIni = ini.ToString();
            _logger.LogInformation("INI gerado com sucesso para MDFe {Id} ({Bytes} bytes)", mdfe.Id, conteudoIni.Length);

            return conteudoIni;
        }

        private async Task AdicionarDocumentosFiscaisIni(StringBuilder ini, MDFe mdfe)
        {
            // Obter localidades de descarregamento do JSON
            List<dynamic> localidadesDescarregamento = new List<dynamic>();

            if (!string.IsNullOrEmpty(mdfe.LocalidadesDescarregamentoJson))
            {
                try
                {
                    localidadesDescarregamento = System.Text.Json.JsonSerializer.Deserialize<List<dynamic>>(mdfe.LocalidadesDescarregamentoJson)
                        ?? new List<dynamic>();
                }
                catch (Exception ex)
                {
                    _logger.LogWarning(ex, "Erro ao deserializar LocalidadesDescarregamentoJson");
                }
            }

            // Se não houver localidades, usar valores padrão
            string codigoMunicipioDescarga = "3550308"; // Padrão: São Paulo
            string nomeMunicipioDescarga = "São Paulo";

            // Se houver pelo menos uma localidade, usar a primeira
            if (localidadesDescarregamento.Count > 0)
            {
                try
                {
                    var primeiraLocalidade = localidadesDescarregamento[0];
                    var codigoIBGE = primeiraLocalidade.GetProperty("codigoIBGE");
                    var municipio = primeiraLocalidade.GetProperty("municipio");

                    codigoMunicipioDescarga = codigoIBGE.GetInt32().ToString();
                    nomeMunicipioDescarga = municipio.GetString() ?? "Não informado";

                    _logger.LogInformation("Usando município de descarregamento: {Municipio} ({Codigo})",
                        nomeMunicipioDescarga, codigoMunicipioDescarga);
                }
                catch (Exception ex)
                {
                    _logger.LogWarning(ex, "Erro ao extrair município de descarregamento, usando padrão");
                }
            }
            else
            {
                _logger.LogWarning("Nenhuma localidade de descarregamento informada. Usando São Paulo como padrão.");
            }

            int docIndex = 1;

            // === CTe - HIERARQUIA CORRETA: [infDoc001] + [infCTe001001] ===
            if (!string.IsNullOrEmpty(mdfe.DocumentosCTeJson))
            {
                try
                {
                    var chavesCTe = System.Text.Json.JsonSerializer.Deserialize<List<string>>(mdfe.DocumentosCTeJson);

                    foreach (var chave in chavesCTe ?? new List<string>())
                    {
                        _logger.LogInformation("[INI] Adicionando CT-e {NumCTe}: {ChaveCTe}", docIndex, chave);
                        _logger.LogInformation("[INI] Local de descarga do CT-e {NumCTe}: {Municipio} ({Codigo})", 
                            docIndex, nomeMunicipioDescarga, codigoMunicipioDescarga);

                        // Seção de descarga do documento
                        ini.AppendLine($"[infDoc{docIndex:D3}]");
                        ini.AppendLine($"cMunDescarga={codigoMunicipioDescarga}");
                        ini.AppendLine($"xMunDescarga={nomeMunicipioDescarga}");
                        ini.AppendLine();

                        // CTe dentro do documento (sempre índice 001 = primeiro CTe deste grupo de descarga)
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

            // === NFe - HIERARQUIA CORRETA: [infDoc002] + [infNFe002001] ===
            if (!string.IsNullOrEmpty(mdfe.DocumentosNFeJson))
            {
                try
                {
                    var chavesNFe = System.Text.Json.JsonSerializer.Deserialize<List<string>>(mdfe.DocumentosNFeJson);

                    foreach (var chave in chavesNFe ?? new List<string>())
                    {
                        _logger.LogInformation("[INI] Adicionando NF-e {NumNFe}: {ChaveNFe}", docIndex, chave);
                        _logger.LogInformation("[INI] Local de descarga da NF-e {NumNFe}: {Municipio} ({Codigo})", 
                            docIndex, nomeMunicipioDescarga, codigoMunicipioDescarga);

                        // Seção de descarga do documento
                        ini.AppendLine($"[infDoc{docIndex:D3}]");
                        ini.AppendLine($"cMunDescarga={codigoMunicipioDescarga}");
                        ini.AppendLine($"xMunDescarga={nomeMunicipioDescarga}");
                        ini.AppendLine();

                        // NFe dentro do documento (sempre índice 001 = primeira NFe deste grupo de descarga)
                        ini.AppendLine($"[infNFe{docIndex:D3}001]");
                        ini.AppendLine($"chNFe={chave}");
                        ini.AppendLine();

                        docIndex++;
                    }
                }
                catch (Exception ex)
                {
                    _logger.LogWarning(ex, "Erro ao processar DocumentosNFeJson");
                }
            }

            await Task.CompletedTask; // Método assíncrono para futura expansão
        }

        public string GerarIniEvento(string tipoEvento, MDFe mdfe, Dictionary<string, string> parametrosEvento)
        {
            var ini = new StringBuilder();

            ini.AppendLine("[EVENTO]");
            ini.AppendLine($"idLote={parametrosEvento.GetValueOrDefault("idLote", "1")}");
            ini.AppendLine();

            ini.AppendLine("[EVENTO001]");
            ini.AppendLine($"cOrgao={CodigosUF.ObterCodigo(mdfe.EmitenteUf)}");
            ini.AppendLine($"CNPJCPF={mdfe.EmitenteCnpj ?? mdfe.EmitenteCpf}");
            ini.AppendLine($"chMDFe={mdfe.ChaveAcesso}");
            ini.AppendLine($"dhEvento={DateTime.Now:yyyy-MM-ddTHH:mm:sszzz}");
            ini.AppendLine($"tpEvento={tipoEvento}");
            ini.AppendLine($"nSeqEvento={parametrosEvento.GetValueOrDefault("nSeqEvento", "1")}");
            ini.AppendLine("versaoEvento=3.00");

            // Campos específicos por tipo de evento
            switch (tipoEvento)
            {
                case "110111": // Cancelamento
                    ini.AppendLine($"nProt={mdfe.Protocolo}");
                    ini.AppendLine($"xJust={parametrosEvento["xJust"]}");
                    break;

                case "110112": // Encerramento
                    ini.AppendLine($"nProt={mdfe.Protocolo}");
                    ini.AppendLine($"dtEnc={parametrosEvento["dtEnc"]}");
                    ini.AppendLine($"cUF={CodigosUF.ObterCodigo(parametrosEvento["UFEnc"])}");
                    ini.AppendLine($"cMun={parametrosEvento["cMun"]}");
                    break;

                case "110114": // Inclusão de Condutor
                    ini.AppendLine($"xNome={parametrosEvento["xNome"]}");
                    ini.AppendLine($"CPF={parametrosEvento["CPF"]}");
                    break;
            }

            ini.AppendLine();

            var conteudoIni = ini.ToString();
            _logger.LogInformation("INI de evento {TipoEvento} gerado", tipoEvento);

            return conteudoIni;
        }

        // === MÉTODOS AUXILIARES ===

        private string GerarCodigoAleatorio()
        {
            return new Random().Next(10000000, 99999999).ToString();
        }
    }
}
