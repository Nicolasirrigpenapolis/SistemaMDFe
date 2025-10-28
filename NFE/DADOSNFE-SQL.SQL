/* Esquema para a criação do banco de dados da aplicação      */
/* Banco/Esquema: DADOSNFE                                    */


/*------------------------------------------------------------*/
/*        Exclusão de triggers/foreign key constraints        */
/*------------------------------------------------------------*/

 IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('FK_Geral_Municipios') AND sysstat & 0xf = 11)
  ALTER TABLE [dbo].Geral
        DROP CONSTRAINT [FK_Geral_Municipios]
 GO

 IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('FK_Nota_fiscal_Geral') AND sysstat & 0xf = 11)
  ALTER TABLE [dbo].[Nota fiscal]
        DROP CONSTRAINT [FK_Nota_fiscal_Geral]
 GO

 IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('FK_Nota_fiscal_Natureza_de_operação') AND sysstat & 0xf = 11)
  ALTER TABLE [dbo].[Nota fiscal]
        DROP CONSTRAINT [FK_Nota_fiscal_Natureza_de_operação]
 GO

 IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('FK_Nota_fiscal_Classificação_fiscal') AND sysstat & 0xf = 11)
  ALTER TABLE [dbo].[Nota fiscal]
        DROP CONSTRAINT [FK_Nota_fiscal_Classificação_fiscal]
 GO

 IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('FK_Produtos_Classificação_fiscal') AND sysstat & 0xf = 11)
  ALTER TABLE [dbo].Produtos
        DROP CONSTRAINT [FK_Produtos_Classificação_fiscal]
 GO

 IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('FK_Produtos_Unidades') AND sysstat & 0xf = 11)
  ALTER TABLE [dbo].Produtos
        DROP CONSTRAINT [FK_Produtos_Unidades]
 GO

 IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('FK_Produtos_da_nota_fiscal_Produtos') AND sysstat & 0xf = 11)
  ALTER TABLE [dbo].[Produtos da nota fiscal]
        DROP CONSTRAINT [FK_Produtos_da_nota_fiscal_Produtos]
 GO

 IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('FK_PW~Usuarios_PW~Grupos') AND sysstat & 0xf = 11)
  ALTER TABLE [dbo].[PW~Usuarios]
        DROP CONSTRAINT [FK_PW~Usuarios_PW~Grupos]
 GO

 IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('FK_PW~Tabelas_PW~Grupos') AND sysstat & 0xf = 11)
  ALTER TABLE [dbo].[PW~Tabelas]
        DROP CONSTRAINT [FK_PW~Tabelas_PW~Grupos]
 GO


/*------------------------------------------------------------*/
/*                     Exclusão de tabelas                    */
/*------------------------------------------------------------*/

 IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('[Carta de correção nfe]') AND sysstat & 0xf = 3)
  DROP TABLE [Carta de correção nfe]
 GO

 IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('[Classificação fiscal]') AND sysstat & 0xf = 3)
  DROP TABLE [Classificação fiscal]
 GO

 IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('Codutores') AND sysstat & 0xf = 3)
  DROP TABLE Codutores
 GO

 IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('[Cte da carga]') AND sysstat & 0xf = 3)
  DROP TABLE [Cte da carga]
 GO

 IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('[Descarregamento cte]') AND sysstat & 0xf = 3)
  DROP TABLE [Descarregamento cte]
 GO

 IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('[Descarregamento nfe]') AND sysstat & 0xf = 3)
  DROP TABLE [Descarregamento nfe]
 GO

 IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('[Emitentes mdfe]') AND sysstat & 0xf = 3)
  DROP TABLE [Emitentes mdfe]
 GO

 IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('Empresa') AND sysstat & 0xf = 3)
  DROP TABLE Empresa
 GO

 IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('[Finalidade da nfe]') AND sysstat & 0xf = 3)
  DROP TABLE [Finalidade da nfe]
 GO

 IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('Geral') AND sysstat & 0xf = 3)
  DROP TABLE Geral
 GO

 IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('Icms') AND sysstat & 0xf = 3)
  DROP TABLE Icms
 GO

 IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('[Local de carregamento]') AND sysstat & 0xf = 3)
  DROP TABLE [Local de carregamento]
 GO

 IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('Manifesto') AND sysstat & 0xf = 3)
  DROP TABLE Manifesto
 GO

 IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('Motoristas') AND sysstat & 0xf = 3)
  DROP TABLE Motoristas
 GO

 IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('Municipios') AND sysstat & 0xf = 3)
  DROP TABLE Municipios
 GO

 IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('[Natureza de operação]') AND sysstat & 0xf = 3)
  DROP TABLE [Natureza de operação]
 GO

 IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('[Nfe da carga]') AND sysstat & 0xf = 3)
  DROP TABLE [Nfe da carga]
 GO

 IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('[NFe devolução]') AND sysstat & 0xf = 3)
  DROP TABLE [NFe devolução]
 GO

 IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('[Nota fiscal]') AND sysstat & 0xf = 3)
  DROP TABLE [Nota fiscal]
 GO

 IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('[Parametros da nfe]') AND sysstat & 0xf = 3)
  DROP TABLE [Parametros da nfe]
 GO

 IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('[Parcelas nota fiscal]') AND sysstat & 0xf = 3)
  DROP TABLE [Parcelas nota fiscal]
 GO

 IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('Produtos') AND sysstat & 0xf = 3)
  DROP TABLE Produtos
 GO

 IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('[Produtos da nota fiscal]') AND sysstat & 0xf = 3)
  DROP TABLE [Produtos da nota fiscal]
 GO

 IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('[Uf de percurso]') AND sysstat & 0xf = 3)
  DROP TABLE [Uf de percurso]
 GO

 IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('Unidades') AND sysstat & 0xf = 3)
  DROP TABLE Unidades
 GO

 IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('[PW~Grupos]') AND sysstat & 0xf = 3)
  DROP TABLE [PW~Grupos]
 GO

 IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('[PW~Tabelas]') AND sysstat & 0xf = 3)
  DROP TABLE [PW~Tabelas]
 GO

 IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('[PW~Usuarios]') AND sysstat & 0xf = 3)
  DROP TABLE [PW~Usuarios]
 GO


/*------------------------------------------------------------*/
/*     Criação de Tabelas, Indices e Atribuição de Default    */
/*                    Carta de correção nfe                   */
/*------------------------------------------------------------*/

 CREATE TABLE [Carta de correção nfe] (
       [Sequencia da correção]          int                 DEFAULT 0 NOT NULL, 
       [Sequencia da nota fiscal]       int                 DEFAULT 0 NOT NULL, 
       [Numero da correção]             smallint            DEFAULT 0 NOT NULL, 
       [Justificativa cce]              text                DEFAULT '' NOT NULL, 
       [Data correção]                  datetime            NULL, 
          CONSTRAINT [Sequencia da correção] PRIMARY KEY CLUSTERED
          (
                  [Sequencia da correção], [Sequencia da nota fiscal]
          ) WITH FILLFACTOR = 90

 )
GO

 CREATE UNIQUE INDEX SeqCorrecao ON [Carta de correção nfe]
       ([Sequencia da nota fiscal], [Numero da correção]) WITH FILLFACTOR = 90
GO




/*------------------------------------------------------------*/
/*     Criação de Tabelas, Indices e Atribuição de Default    */
/*                    Classificação fiscal                    */
/*------------------------------------------------------------*/

 CREATE TABLE [Classificação fiscal] (
       [Sequencia da classificação]     int                 DEFAULT 0 NOT NULL, 
       Ncm                              int                 DEFAULT 0 NOT NULL, 
       [Descrição do ncm]               varchar (80)        DEFAULT '' NOT NULL, 
       [Percentual de ipi]              decimal (8, 4)      DEFAULT 0 NOT NULL, 
       [Produto diferido]               bit                 DEFAULT 0 NOT NULL, 
       Iva                              decimal (7, 4)      DEFAULT 0 NOT NULL, 
       Cest                             varchar (7)         DEFAULT '' NOT NULL, 
       Inativo                          bit                 DEFAULT 0 NOT NULL, 
          CONSTRAINT [Sequencia da classificação] PRIMARY KEY CLUSTERED
          (
                  [Sequencia da classificação]
          ) WITH FILLFACTOR = 90

 )
GO


/*------------------------------------------------------------*/
/*     Criação de Tabelas, Indices e Atribuição de Default    */
/*                          Codutores                         */
/*------------------------------------------------------------*/

 CREATE TABLE Codutores (
       [Sequencia do manifesto]         int                 DEFAULT 0 NOT NULL, 
       [Nome condutor]                  varchar (60)        DEFAULT '' NOT NULL, 
       [Cpf condutor]                   varchar (14)        DEFAULT '' NOT NULL, 
          CONSTRAINT Seq_Condutor PRIMARY KEY CLUSTERED
          (
                  [Sequencia do manifesto], [Nome condutor]
          ) WITH FILLFACTOR = 90

 )
GO


/*------------------------------------------------------------*/
/*     Criação de Tabelas, Indices e Atribuição de Default    */
/*                        Cte da carga                        */
/*------------------------------------------------------------*/

 CREATE TABLE [Cte da carga] (
       [Sequencia descarrega cte]       int                 DEFAULT 0 NOT NULL, 
       [Sequencia do manifesto]         int                 DEFAULT 0 NOT NULL, 
       [Chave do cte]                   varchar (44)        DEFAULT '' NOT NULL, 
       [Descrição do municipio]         varchar (80)        DEFAULT '' NOT NULL, 
       [Valor total]                    decimal (12, 2)     DEFAULT 0 NOT NULL, 
       [Peso bruto]                     decimal (11, 4)     DEFAULT 0 NOT NULL, 
          CONSTRAINT SeqMan_CTe PRIMARY KEY CLUSTERED
          (
                  [Sequencia descarrega cte], [Sequencia do manifesto]
          ) WITH FILLFACTOR = 90

 )
GO


/*------------------------------------------------------------*/
/*     Criação de Tabelas, Indices e Atribuição de Default    */
/*                     Descarregamento cte                    */
/*------------------------------------------------------------*/

 CREATE TABLE [Descarregamento cte] (
       [Sequencia descarregamento cte]  int                 DEFAULT 0 NOT NULL, 
       [Sequencia do manifesto]         int                 DEFAULT 0 NOT NULL, 
       [Codigo do ibge]                 int                 DEFAULT 0 NOT NULL, 
       [Descrição do municipio]         varchar (80)        DEFAULT '' NOT NULL, 
          CONSTRAINT [Sequencia descarregamento cte] PRIMARY KEY CLUSTERED
          (
                  [Sequencia descarregamento cte], [Sequencia do manifesto]
          ) WITH FILLFACTOR = 90

 )
GO


/*------------------------------------------------------------*/
/*     Criação de Tabelas, Indices e Atribuição de Default    */
/*                     Descarregamento nfe                    */
/*------------------------------------------------------------*/

 CREATE TABLE [Descarregamento nfe] (
       [Sequencia descarrega]           int                 DEFAULT 0 NOT NULL, 
       [Sequencia do manifesto]         int                 DEFAULT 0 NOT NULL, 
       [Codigo do ibge]                 int                 DEFAULT 0 NOT NULL, 
       [Descrição do municipio]         varchar (80)        DEFAULT '' NOT NULL, 
          CONSTRAINT [Sequencia descarrega] PRIMARY KEY CLUSTERED
          (
                  [Sequencia descarrega], [Sequencia do manifesto]
          ) WITH FILLFACTOR = 90

 )
GO


/*------------------------------------------------------------*/
/*     Criação de Tabelas, Indices e Atribuição de Default    */
/*                       Emitentes mdfe                       */
/*------------------------------------------------------------*/

 CREATE TABLE [Emitentes mdfe] (
       [Sequencia do emitente]          int                 DEFAULT 0 NOT NULL, 
       Cnpj                             varchar (18)        DEFAULT '' NOT NULL, 
       Ie                               varchar (20)        DEFAULT '' NOT NULL, 
       [Razão social]                   varchar (60)        DEFAULT '' NOT NULL, 
       [Nome fantasia]                  varchar (60)        DEFAULT '' NOT NULL, 
       Logradouro                       varchar (80)        DEFAULT '' NOT NULL, 
       Nro                              varchar (8)         DEFAULT '' NOT NULL, 
       Complemento                      varchar (30)        DEFAULT '' NOT NULL, 
       Bairro                           varchar (60)        DEFAULT '' NOT NULL, 
       [Codigo do ibge]                 int                 DEFAULT 0 NOT NULL, 
       Municipio                        varchar (80)        DEFAULT '' NOT NULL, 
       Cep                              varchar (9)         DEFAULT '' NOT NULL, 
       Uf                               varchar (3)         DEFAULT '' NOT NULL, 
       Fone                             varchar (13)        DEFAULT '' NOT NULL, 
       Email                            varchar (255)       DEFAULT '' NOT NULL, 
       Inativo                          bit                 DEFAULT 0 NOT NULL, 
       [Certificado digital]            varchar (255)       DEFAULT '' NOT NULL, 
       [Chave flexdocs]                 varchar (130)       DEFAULT '' NOT NULL, 
          CONSTRAINT [Sequencia do emitente] PRIMARY KEY CLUSTERED
          (
                  [Sequencia do emitente]
          ) WITH FILLFACTOR = 90

 )
GO


/*------------------------------------------------------------*/
/*     Criação de Tabelas, Indices e Atribuição de Default    */
/*                           Empresa                          */
/*------------------------------------------------------------*/

 CREATE TABLE Empresa (
       [Razão social]                   varchar (60)        DEFAULT '' NOT NULL, 
       [Nome fantasia]                  varchar (60)        DEFAULT '' NOT NULL, 
       [Cpf do emitente]                varchar (14)        DEFAULT '' NOT NULL, 
       [Inscrição estadual]             varchar (20)        DEFAULT '' NOT NULL, 
       Cnpj                             varchar (18)        DEFAULT '' NOT NULL, 
       Rua                              varchar (60)        DEFAULT '' NOT NULL, 
       Nro                              varchar (8)         DEFAULT '' NOT NULL, 
       Bairro                           varchar (60)        DEFAULT '' NOT NULL, 
       Município                        varchar (60)        DEFAULT '' NOT NULL, 
       [Codigo do municipio]            int                 DEFAULT 0 NOT NULL, 
       Uf                               varchar (3)         DEFAULT '' NOT NULL, 
       Cep                              varchar (9)         DEFAULT '' NOT NULL, 
       Fone                             varchar (13)        DEFAULT '' NOT NULL, 
       [Aliquota do pis]                decimal (8, 4)      DEFAULT 0 NOT NULL, 
       [Aliquota do cofins]             decimal (8, 4)      DEFAULT 0 NOT NULL, 
       [Chave flexdocs]                 varchar (130)       DEFAULT '' NOT NULL, 
       Email                            varchar (255)       DEFAULT '' NOT NULL, 
       [Data Inicial da Ativação]       datetime            NULL
 )
GO


/*------------------------------------------------------------*/
/*     Criação de Tabelas, Indices e Atribuição de Default    */
/*                      Finalidade da nfe                     */
/*------------------------------------------------------------*/

 CREATE TABLE [Finalidade da nfe] (
       Codigo                           smallint            DEFAULT 0 NOT NULL, 
       Descrição                        varchar (80)        DEFAULT '' NOT NULL, 
          CONSTRAINT Codigo PRIMARY KEY CLUSTERED
          (
                  Codigo
          ) WITH FILLFACTOR = 90

 )
GO


/*------------------------------------------------------------*/
/*     Criação de Tabelas, Indices e Atribuição de Default    */
/*                            Geral                           */
/*------------------------------------------------------------*/

 CREATE TABLE Geral (
       Cliente                          bit                 DEFAULT 0 NOT NULL, 
       Transportadora                   bit                 DEFAULT 0 NOT NULL, 
       [Consumidor final]               bit                 DEFAULT 0 NOT NULL, 
       Isento                           bit                 DEFAULT 0 NOT NULL, 
       Inativo                          bit                 DEFAULT 0 NOT NULL, 
       [Sequencia do geral]             int                 DEFAULT 0 NOT NULL, 
       [Razão social]                   varchar (60)        DEFAULT '' NOT NULL, 
       [Nome fantasia]                  varchar (60)        DEFAULT '' NOT NULL, 
       Tipo                             smallint            DEFAULT 0 NOT NULL, 
       Endereço                         varchar (100)       DEFAULT '' NOT NULL, 
       Complemento                      varchar (30)        DEFAULT '' NOT NULL, 
       Nro                              varchar (8)         DEFAULT '' NOT NULL, 
       Bairro                           varchar (60)        DEFAULT '' NOT NULL, 
       [Sequencia do municipio]         int                 DEFAULT 0 NOT NULL, 
       Cep                              varchar (9)         DEFAULT '' NOT NULL, 
       Fone                             varchar (13)        DEFAULT '' NOT NULL, 
       Celular                          varchar (14)        DEFAULT '' NOT NULL, 
       [Codigo do suframa]              varchar (9)         DEFAULT '' NOT NULL, 
       [Cpf e cnpj]                     varchar (20)        DEFAULT '' NOT NULL, 
       [Rg e ie]                        varchar (20)        DEFAULT '' NOT NULL, 
       Observação                       text                DEFAULT '' NOT NULL, 
       [Data do cadastro]               datetime            NULL, 
       Fornecedor                       bit                 DEFAULT 0 NOT NULL, 
       Email                            varchar (255)       DEFAULT '' NOT NULL, 
       [Codigo da antt]                 varchar (20)        DEFAULT '' NOT NULL, 
       [Data de Nascimento]             datetime            NULL, 
          CONSTRAINT [Sequencia do geral] PRIMARY KEY CLUSTERED
          (
                  [Sequencia do geral]
          ) WITH FILLFACTOR = 90

 )
GO


/*------------------------------------------------------------*/
/*     Criação de Tabelas, Indices e Atribuição de Default    */
/*                            Icms                            */
/*------------------------------------------------------------*/

 CREATE TABLE Icms (
       [Sequencia do icms]              smallint            DEFAULT 0 NOT NULL, 
       Uf                               varchar (3)         DEFAULT '' NOT NULL, 
       Região                           varchar (20)        DEFAULT '' NOT NULL, 
       [Aliquota do icms]               decimal (5, 2)      DEFAULT 0 NOT NULL, 
       [Aliquota interna]               decimal (5, 2)      DEFAULT 0 NOT NULL, 
       [Codigo da uf]                   smallint            DEFAULT 0 NOT NULL, 
       Inativo                          bit                 DEFAULT 0 NOT NULL, 
          CONSTRAINT [Sequencia do icms] PRIMARY KEY CLUSTERED
          (
                  [Sequencia do icms]
          ) WITH FILLFACTOR = 90

 )
GO


/*------------------------------------------------------------*/
/*     Criação de Tabelas, Indices e Atribuição de Default    */
/*                    Local de carregamento                   */
/*------------------------------------------------------------*/

 CREATE TABLE [Local de carregamento] (
       [Sequencia do manifesto]         int                 DEFAULT 0 NOT NULL, 
       Sequencia                        int                 DEFAULT 0 NOT NULL, 
       Uf                               varchar (3)         DEFAULT '' NOT NULL, 
       [Descrição do municipio]         varchar (80)        DEFAULT '' NOT NULL, 
       [Codigo do ibge]                 int                 DEFAULT 0 NOT NULL, 
          CONSTRAINT Seq_Carrega PRIMARY KEY CLUSTERED
          (
                  [Sequencia do manifesto], [Descrição do municipio]
          ) WITH FILLFACTOR = 90

 )
GO


/*------------------------------------------------------------*/
/*     Criação de Tabelas, Indices e Atribuição de Default    */
/*                          Manifesto                         */
/*------------------------------------------------------------*/

 CREATE TABLE Manifesto (
       [Sequencia do manifesto]         int                 DEFAULT 0 NOT NULL, 
       [Numero do manifesto]            int                 DEFAULT 0 NOT NULL, 
       [Data de emissão]                datetime            NULL, 
       Uf                               varchar (3)         DEFAULT '' NOT NULL, 
       [Tipo de emitente]               varchar (34)        DEFAULT '' NOT NULL, 
       [Uf de descarregamento]          varchar (3)         DEFAULT '' NOT NULL, 
       Observação                       text                DEFAULT '' NOT NULL, 
       Rntrc                            varchar (25)        DEFAULT '' NOT NULL, 
       [Tipo de carroceria]             varchar (15)        DEFAULT '' NOT NULL, 
       [Uf do veiculo]                  varchar (3)         DEFAULT '' NOT NULL, 
       [Tipo de rodado]                 varchar (15)        DEFAULT '' NOT NULL, 
       Placa                            varchar (9)         DEFAULT '' NOT NULL, 
       Tara                             varchar (20)        DEFAULT '' NOT NULL, 
       Renavam                          varchar (20)        DEFAULT '' NOT NULL, 
       [Capacidade kg]                  varchar (15)        DEFAULT '' NOT NULL, 
       [Codigo do emitente]             smallint            DEFAULT 0 NOT NULL, 
       Transmitido                      bit                 DEFAULT 0 NOT NULL, 
       [Nota cancelada]                 bit                 DEFAULT 0 NOT NULL, 
       Autorizada                       bit                 DEFAULT 0 NOT NULL, 
       Historico                        text                DEFAULT '' NOT NULL, 
       Proprietario                     bit                 DEFAULT 0 NOT NULL, 
       [Cpf Proprietario]               varchar (14)        DEFAULT '' NOT NULL, 
       [Cnpj Proprietario]              varchar (18)        DEFAULT '' NOT NULL, 
       [Rntrc proprietario]             varchar (25)        DEFAULT '' NOT NULL, 
       [Nome Proprietario]              varchar (60)        DEFAULT '' NOT NULL, 
       [Ie Proprietario]                varchar (20)        DEFAULT '' NOT NULL, 
       [Uf proprietario]                varchar (3)         DEFAULT '' NOT NULL, 
       [Tipo de proprietario]           varchar (16)        DEFAULT '' NOT NULL, 
       [Tipo documento]                 smallint            DEFAULT 0 NOT NULL, 
       [Numero do recibo]               varchar (20)        DEFAULT '' NOT NULL, 
       [Chave de acesso]                varchar (50)        DEFAULT '' NOT NULL, 
       XmlAssinado                      text                DEFAULT '' NOT NULL, 
       [Protocolo de autorização]       varchar (50)        DEFAULT '' NOT NULL, 
       [Data e hora do mdfe]            varchar (30)        DEFAULT '' NOT NULL, 
       XmlAutorizado                    text                DEFAULT '' NOT NULL, 
       Encerrado                        bit                 DEFAULT 0 NOT NULL, 
       [Responsavel do seguro]          varchar (53)        DEFAULT '' NOT NULL, 
       [Tipo do responsavel]            smallint            DEFAULT 0 NOT NULL, 
       [Documento do responsavel]       varchar (20)        DEFAULT '' NOT NULL, 
       [Nome da seguradora]             varchar (50)        DEFAULT '' NOT NULL, 
       [Cnpj da seguradora]             varchar (18)        DEFAULT '' NOT NULL, 
       [N da apolice]                   varchar (20)        DEFAULT '' NOT NULL, 
       [N averbação]                    varchar (60)        DEFAULT '' NOT NULL, 
       [Tipo de contratante]            smallint            DEFAULT 0 NOT NULL, 
       [Documento do contratante]       varchar (20)        DEFAULT '' NOT NULL, 
       [Produto Predominante]           varchar (120)       DEFAULT '' NOT NULL, 
       [Latitude de Carregamento]       decimal (10, 6)     DEFAULT 0 NOT NULL, 
       [Longitude de Carregamento]      decimal (10, 6)     DEFAULT 0 NOT NULL, 
       [Latitude de Descrregamento]     decimal (10, 6)     DEFAULT 0 NOT NULL, 
       [Longitude de Descarregamento]   decimal (10, 6)     DEFAULT 0 NOT NULL, 
       [CEP Carregamento]               varchar (9)         DEFAULT '' NOT NULL, 
       [CEP Descarregamento]            varchar (9)         DEFAULT '' NOT NULL, 
          CONSTRAINT [Sequencia do manifesto] PRIMARY KEY CLUSTERED
          (
                  [Sequencia do manifesto]
          ) WITH FILLFACTOR = 90

 )
GO


/*------------------------------------------------------------*/
/*     Criação de Tabelas, Indices e Atribuição de Default    */
/*                         Motoristas                         */
/*------------------------------------------------------------*/

 CREATE TABLE Motoristas (
       [Codigo do Motorista]            smallint            DEFAULT 0 NOT NULL, 
       [Nome do Motorista]              varchar (40)        DEFAULT '' NOT NULL, 
       CPF                              varchar (14)        DEFAULT '' NOT NULL, 
          CONSTRAINT [Codigo do Motorista] PRIMARY KEY CLUSTERED
          (
                  [Codigo do Motorista]
          ) WITH FILLFACTOR = 90

 )
GO


/*------------------------------------------------------------*/
/*     Criação de Tabelas, Indices e Atribuição de Default    */
/*                         Municipios                         */
/*------------------------------------------------------------*/

 CREATE TABLE Municipios (
       [Sequencia do municipio]         int                 DEFAULT 0 NOT NULL, 
       [Descrição do municipio]         varchar (80)        DEFAULT '' NOT NULL, 
       Uf                               varchar (3)         DEFAULT '' NOT NULL, 
       [Codigo do ibge]                 int                 DEFAULT 0 NOT NULL, 
       Cep                              varchar (9)         DEFAULT '' NOT NULL, 
       Inativo                          bit                 DEFAULT 0 NOT NULL, 
       Latitude                         decimal (10, 6)     DEFAULT 0 NOT NULL, 
       Longitude                        decimal (10, 6)     DEFAULT 0 NOT NULL, 
          CONSTRAINT [Sequencia do municipio] PRIMARY KEY CLUSTERED
          (
                  [Sequencia do municipio]
          ) WITH FILLFACTOR = 90

 )
GO


/*------------------------------------------------------------*/
/*     Criação de Tabelas, Indices e Atribuição de Default    */
/*                    Natureza de operação                    */
/*------------------------------------------------------------*/

 CREATE TABLE [Natureza de operação] (
       [Sequencia da natureza]          smallint            DEFAULT 0 NOT NULL, 
       Cfop                             int                 DEFAULT 0 NOT NULL, 
       [Descrição do cfop]              varchar (40)        DEFAULT '' NOT NULL, 
       Inativo                          bit                 DEFAULT 0 NOT NULL, 
          CONSTRAINT [Sequencia da natureza] PRIMARY KEY CLUSTERED
          (
                  [Sequencia da natureza]
          ) WITH FILLFACTOR = 90

 )
GO


/*------------------------------------------------------------*/
/*     Criação de Tabelas, Indices e Atribuição de Default    */
/*                        Nfe da carga                        */
/*------------------------------------------------------------*/

 CREATE TABLE [Nfe da carga] (
       [Sequencia descarrega]           int                 DEFAULT 0 NOT NULL, 
       [Sequencia do manifesto]         int                 DEFAULT 0 NOT NULL, 
       [Chave da nfe]                   varchar (44)        DEFAULT '' NOT NULL, 
       [Descrição do municipio]         varchar (80)        DEFAULT '' NOT NULL, 
       [Valor total]                    decimal (12, 2)     DEFAULT 0 NOT NULL, 
       [Peso bruto]                     decimal (11, 4)     DEFAULT 0 NOT NULL, 
          CONSTRAINT Seq_MDFe_NFe_Carga PRIMARY KEY CLUSTERED
          (
                  [Sequencia descarrega], [Sequencia do manifesto]
          ) WITH FILLFACTOR = 90

 )
GO


/*------------------------------------------------------------*/
/*     Criação de Tabelas, Indices e Atribuição de Default    */
/*                        NFe devolução                       */
/*------------------------------------------------------------*/

 CREATE TABLE [NFe devolução] (
       [Sequencia da nota fiscal]       int                 DEFAULT 0 NOT NULL, 
       [Chave da nfe]                   varchar (44)        DEFAULT '' NOT NULL, 
          CONSTRAINT [SeqNFe Devolucao] PRIMARY KEY CLUSTERED
          (
                  [Sequencia da nota fiscal], [Chave da nfe]
          ) WITH FILLFACTOR = 90

 )
GO


/*------------------------------------------------------------*/
/*     Criação de Tabelas, Indices e Atribuição de Default    */
/*                         Nota fiscal                        */
/*------------------------------------------------------------*/

 CREATE TABLE [Nota fiscal] (
       [Sequencia da nota fiscal]       int                 DEFAULT 0 NOT NULL, 
       [Numero da nfe]                  int                 DEFAULT 0 NOT NULL, 
       [Data de emissão]                datetime            NULL, 
       [Sequencia do geral]             int                 DEFAULT 0 NOT NULL, 
       [Sequencia da natureza]          smallint            DEFAULT 0 NOT NULL, 
       [Sequencia da transportadora]    int                 DEFAULT 0 NOT NULL, 
       [Placa do veiculo]               varchar (8)         DEFAULT '' NOT NULL, 
       [Uf do veiculo]                  varchar (3)         DEFAULT '' NOT NULL, 
       Frete                            varchar (12)        DEFAULT '' NOT NULL, 
       [Valor do frete]                 decimal (11, 2)     DEFAULT 0 NOT NULL, 
       [Valor do desconto]              decimal (11, 2)     DEFAULT 0 NOT NULL, 
       Volumes                          int                 DEFAULT 0 NOT NULL, 
       Especie                          varchar (30)        DEFAULT '' NOT NULL, 
       [Data de saida]                  datetime            NULL, 
       [Hora da saida]                  datetime            NULL, 
       [Forma de pagamento]             varchar (5)         DEFAULT '' NOT NULL, 
       Historico                        text                DEFAULT '' NOT NULL, 
       [Valor total do ipi]             decimal (11, 2)     DEFAULT 0 NOT NULL, 
       [Valor total do icms]            decimal (11, 2)     DEFAULT 0 NOT NULL, 
       [Valor total dos produtos]       decimal (11, 2)     DEFAULT 0 NOT NULL, 
       [Valor total da nfe]             decimal (12, 2)     DEFAULT 0 NOT NULL, 
       [Tipo de nota]                   smallint            DEFAULT 0 NOT NULL, 
       [Sequencia da classificação]     int                 DEFAULT 0 NOT NULL, 
       [Nota cancelada]                 bit                 DEFAULT 0 NOT NULL, 
       [Nota avulsa]                    bit                 DEFAULT 0 NOT NULL, 
       [Peso bruto]                     decimal (11, 4)     DEFAULT 0 NOT NULL, 
       [Peso liquido]                   decimal (11, 4)     DEFAULT 0 NOT NULL, 
       [Nfe complementar]               bit                 DEFAULT 0 NOT NULL, 
       [Chave nfe referenciada]         varchar (45)        DEFAULT '' NOT NULL, 
       [Chave de acesso da nfe]         varchar (50)        DEFAULT '' NOT NULL, 
       [Protocolo de autorização]       varchar (50)        DEFAULT '' NOT NULL, 
       [Data e hora da nfe]             varchar (25)        DEFAULT '' NOT NULL, 
       Transmitido                      bit                 DEFAULT 0 NOT NULL, 
       Autorizada                       bit                 DEFAULT 0 NOT NULL, 
       [Numero do recibo]               varchar (20)        DEFAULT '' NOT NULL, 
       Observação                       text                DEFAULT '' NOT NULL, 
       [Valor total da bc]              decimal (11, 2)     DEFAULT 0 NOT NULL, 
       [Valor total do pis]             decimal (11, 2)     DEFAULT 0 NOT NULL, 
       [Valor total do cofins]          decimal (11, 2)     DEFAULT 0 NOT NULL, 
       [Valor total base st]            decimal (11, 2)     DEFAULT 0 NOT NULL, 
       [Valor total icms st]            decimal (11, 2)     DEFAULT 0 NOT NULL, 
       Imprimiu                         bit                 DEFAULT 0 NOT NULL, 
       [Valor total dos tributos]       decimal (11, 2)     DEFAULT 0 NOT NULL, 
       [Finalidade nfe]                 smallint            DEFAULT 0 NOT NULL, 
       Devolução                        bit                 DEFAULT 0 NOT NULL, 
       [Data da Alteração]              datetime            NULL, 
       [Hora da Alteração]              datetime            NULL, 
       [Usuario da Alteração]           varchar (30)        DEFAULT '' NOT NULL, 
       XmlAssinado                      text                DEFAULT '' NOT NULL, 
       XmlAutorizado                    text                DEFAULT '' NOT NULL, 
          CONSTRAINT [Sequencia da nota fiscal] PRIMARY KEY CLUSTERED
          (
                  [Sequencia da nota fiscal]
          ) WITH FILLFACTOR = 90

 )
GO


/*------------------------------------------------------------*/
/*     Criação de Tabelas, Indices e Atribuição de Default    */
/*                      Parametros da nfe                     */
/*------------------------------------------------------------*/

 CREATE TABLE [Parametros da nfe] (
       [Codigo da uf]                   smallint            DEFAULT 0 NOT NULL, 
       [Serie da nfe]                   smallint            DEFAULT 0 NOT NULL, 
       Ambiente                         smallint            DEFAULT 0 NOT NULL, 
       [Horario de verao]               bit                 DEFAULT 0 NOT NULL, 
       [Aliquota simples nacional]      decimal (8, 4)      DEFAULT 0 NOT NULL, 
       [Diretorio 1 nfe homologação]    varchar (255)       DEFAULT '' NOT NULL, 
       [Diretorio 2 nfe homologação]    varchar (255)       DEFAULT '' NOT NULL, 
       [Diretorio 1 nfe produção]       varchar (255)       DEFAULT '' NOT NULL, 
       [Diretorio 2 nfe produção]       varchar (255)       DEFAULT '' NOT NULL, 
       [Certificado digital]            varchar (255)       DEFAULT '' NOT NULL, 
       [Simples nacional]               bit                 DEFAULT 0 NOT NULL, 
       [Percentual tributos]            decimal (8, 4)      DEFAULT 0 NOT NULL
 )
GO


/*------------------------------------------------------------*/
/*     Criação de Tabelas, Indices e Atribuição de Default    */
/*                    Parcelas nota fiscal                    */
/*------------------------------------------------------------*/

 CREATE TABLE [Parcelas nota fiscal] (
       [Sequencia da nota fiscal]       int                 DEFAULT 0 NOT NULL, 
       [Numero da parcela]              smallint            DEFAULT 0 NOT NULL, 
       Dias                             smallint            DEFAULT 0 NOT NULL, 
       [Data de vencimento]             datetime            NULL, 
       [Valor da parcela]               decimal (10, 2)     DEFAULT 0 NOT NULL, 
          CONSTRAINT SeqNF_Pc PRIMARY KEY CLUSTERED
          (
                  [Sequencia da nota fiscal], [Numero da parcela]
          ) WITH FILLFACTOR = 90

 )
GO


/*------------------------------------------------------------*/
/*     Criação de Tabelas, Indices e Atribuição de Default    */
/*                          Produtos                          */
/*------------------------------------------------------------*/

 CREATE TABLE Produtos (
       [Sequencia do produto]           int                 DEFAULT 0 NOT NULL, 
       Descrição                        varchar (80)        DEFAULT '' NOT NULL, 
       Estoque                          decimal (11, 4)     DEFAULT 0 NOT NULL, 
       [Sequencia da unidade]           smallint            DEFAULT 0 NOT NULL, 
       [Valor total]                    decimal (12, 2)     DEFAULT 0 NOT NULL, 
       [Sequencia da classificação]     int                 DEFAULT 0 NOT NULL, 
       Usado                            bit                 DEFAULT 0 NOT NULL, 
       Inativo                          bit                 DEFAULT 0 NOT NULL, 
       [Material adquirido de terceiro] bit                 DEFAULT 0 NOT NULL, 
       Importado                        bit                 DEFAULT 0 NOT NULL, 
       [Ultima nfe]                     datetime            NULL, 
          CONSTRAINT [Sequencia do produto] PRIMARY KEY CLUSTERED
          (
                  [Sequencia do produto]
          ) WITH FILLFACTOR = 90

 )
GO


/*------------------------------------------------------------*/
/*     Criação de Tabelas, Indices e Atribuição de Default    */
/*                   Produtos da nota fiscal                  */
/*------------------------------------------------------------*/

 CREATE TABLE [Produtos da nota fiscal] (
       [Sequencia da nota fiscal]       int                 DEFAULT 0 NOT NULL, 
       [Sequencia produto nota fiscal]  int                 NOT NULL     IDENTITY (1,  1 ) NOT FOR REPLICATION, 
       [Sequencia do produto]           int                 DEFAULT 0 NOT NULL, 
       Quantidade                       decimal (11, 4)     DEFAULT 0 NOT NULL, 
       [Valor unitario]                 decimal (11, 4)     DEFAULT 0 NOT NULL, 
       [Valor total]                    decimal (12, 2)     DEFAULT 0 NOT NULL, 
       [Valor do ipi]                   decimal (11, 2)     DEFAULT 0 NOT NULL, 
       [Valor do icms]                  decimal (11, 2)     DEFAULT 0 NOT NULL, 
       [Aliquota do ipi]                decimal (5, 2)      DEFAULT 0 NOT NULL, 
       [Aliquota do icms]               decimal (5, 2)      DEFAULT 0 NOT NULL, 
       [Percentual da redução]          decimal (5, 2)      DEFAULT 0 NOT NULL, 
       [Valor da base de calculo]       decimal (11, 2)     DEFAULT 0 NOT NULL, 
       [Valor do pis]                   decimal (11, 2)     DEFAULT 0 NOT NULL, 
       [Valor do cofins]                decimal (11, 2)     DEFAULT 0 NOT NULL, 
       Iva                              decimal (7, 4)      DEFAULT 0 NOT NULL, 
       [Base de calculo st]             decimal (11, 2)     DEFAULT 0 NOT NULL, 
       [Valor icms st]                  decimal (11, 2)     DEFAULT 0 NOT NULL, 
       Cfop                             int                 DEFAULT 0 NOT NULL, 
       Cst                              smallint            DEFAULT 0 NOT NULL, 
       [Aliquota icms st]               decimal (5, 2)      DEFAULT 0 NOT NULL, 
       [Valor dos tributos]             decimal (11, 2)     DEFAULT 0 NOT NULL, 
          CONSTRAINT SeqNf_e_produto PRIMARY KEY CLUSTERED
          (
                  [Sequencia da nota fiscal], [Sequencia produto nota fiscal]
          ) WITH FILLFACTOR = 90

 )
GO


/*------------------------------------------------------------*/
/*     Criação de Tabelas, Indices e Atribuição de Default    */
/*                       Uf de percurso                       */
/*------------------------------------------------------------*/

 CREATE TABLE [Uf de percurso] (
       [Sequencia do manifesto]         int                 DEFAULT 0 NOT NULL, 
       Sequencia                        int                 DEFAULT 0 NOT NULL, 
       Uf                               varchar (3)         DEFAULT '' NOT NULL, 
          CONSTRAINT Seq_UFPercurso PRIMARY KEY CLUSTERED
          (
                  [Sequencia do manifesto], Uf
          ) WITH FILLFACTOR = 90

 )
GO


/*------------------------------------------------------------*/
/*     Criação de Tabelas, Indices e Atribuição de Default    */
/*                          Unidades                          */
/*------------------------------------------------------------*/

 CREATE TABLE Unidades (
       [Sequencia da unidade]           smallint            DEFAULT 0 NOT NULL, 
       Descrição                        varchar (80)        DEFAULT '' NOT NULL, 
       [Sigla da unidade]               varchar (3)         DEFAULT '' NOT NULL, 
       Inativo                          bit                 DEFAULT 0 NOT NULL, 
          CONSTRAINT [Sequencia da unidade] PRIMARY KEY CLUSTERED
          (
                  [Sequencia da unidade]
          ) WITH FILLFACTOR = 90

 )
GO


/*------------------------------------------------------------*/
/*     Criação de Tabelas, Indices e Atribuição de Default    */
/*                          PW~Grupos                         */
/*------------------------------------------------------------*/

 CREATE TABLE [PW~Grupos] (
       [PW~Nome]                        varchar (100)       DEFAULT ''   COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
          CONSTRAINT [PW~Nome] PRIMARY KEY  CLUSTERED
          (
                  [PW~Nome]
          ) WITH FILLFACTOR = 90
)
GO

/*------------------------------------------------------------*/
/*     Criação de Tabelas, Indices e Atribuição de Default    */
/*                         PW~Usuarios                        */
/*------------------------------------------------------------*/

 CREATE TABLE [PW~Usuarios] (
       [PW~Grupo]                       varchar (100)       DEFAULT ''   COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
       [PW~Nome]                        varchar (100)       DEFAULT ''   COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
       [PW~Senha]                       varchar (100)       DEFAULT ''   COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
       [PW~Obs]                         varchar (100)       DEFAULT ''   COLLATE SQL_Latin1_General_CP1_CI_AS  NULL,
       CONSTRAINT [Chave usuario] PRIMARY KEY  CLUSTERED
          (
                  [PW~Nome], [PW~Senha]
          ) WITH FILLFACTOR = 90
)
GO

 CREATE INDEX [PW~Grupo] ON [PW~Usuarios]
        ([PW~Grupo]) WITH FILLFACTOR = 90
GO

/*------------------------------------------------------------*/
/*     Criação de Tabelas, Indices e Atribuição de Default    */
/*                         PW~Tabelas                         */
/*------------------------------------------------------------*/

 CREATE TABLE [PW~Tabelas] (
       [PW~Projeto]                     varchar (10)        DEFAULT ''   COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
       [PW~Grupo]                       varchar (100)       DEFAULT ''   COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
       [PW~Nome]                        varchar (100)       DEFAULT ''   COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
       [PW~Permissoes]                  varchar (100)       DEFAULT ''   COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
          CONSTRAINT [Chave tabelas] PRIMARY KEY  CLUSTERED
          (
                  [PW~Projeto], [PW~Grupo], [PW~Nome]
          ) WITH FILLFACTOR = 90
)
GO

/*------------------------------------------------------------*/
/*         Criação de triggers/foreign key constraints        */
/*------------------------------------------------------------*/

 ALTER TABLE [dbo].[Geral] ADD CONSTRAINT [FK_Geral_Municipios]
      FOREIGN KEY
         (  [Sequencia do municipio]  )
      REFERENCES Municipios
         (  [Sequencia do municipio]  )
      ON UPDATE CASCADE
GO

 ALTER TABLE [dbo].[Nota fiscal] ADD CONSTRAINT [FK_Nota_fiscal_Geral]
      FOREIGN KEY
         (  [Sequencia do geral]  )
      REFERENCES Geral
         (  [Sequencia do geral]  )
      ON UPDATE CASCADE
GO

 ALTER TABLE [dbo].[Nota fiscal] ADD CONSTRAINT [FK_Nota_fiscal_Natureza_de_operação]
      FOREIGN KEY
         (  [Sequencia da natureza]  )
      REFERENCES [Natureza de operação]
         (  [Sequencia da natureza]  )
      ON UPDATE CASCADE
GO

 ALTER TABLE [dbo].[Nota fiscal] ADD CONSTRAINT [FK_Nota_fiscal_Classificação_fiscal]
      FOREIGN KEY
         (  [Sequencia da classificação]  )
      REFERENCES [Classificação fiscal]
         (  [Sequencia da classificação]  )
      ON UPDATE CASCADE
GO

 ALTER TABLE [dbo].[Produtos] ADD CONSTRAINT [FK_Produtos_Classificação_fiscal]
      FOREIGN KEY
         (  [Sequencia da classificação]  )
      REFERENCES [Classificação fiscal]
         (  [Sequencia da classificação]  )
      ON UPDATE CASCADE
GO

 ALTER TABLE [dbo].[Produtos] ADD CONSTRAINT [FK_Produtos_Unidades]
      FOREIGN KEY
         (  [Sequencia da unidade]  )
      REFERENCES Unidades
         (  [Sequencia da unidade]  )
      ON UPDATE CASCADE
GO

 ALTER TABLE [dbo].[Produtos da nota fiscal] ADD CONSTRAINT [FK_Produtos_da_nota_fiscal_Produtos]
      FOREIGN KEY
         (  [Sequencia do produto]  )
      REFERENCES Produtos
         (  [Sequencia do produto]  )
      ON UPDATE CASCADE
GO

 ALTER TABLE [dbo].[PW~Usuarios] ADD CONSTRAINT [FK_PW~Usuarios_PW~Grupos]
      FOREIGN KEY
         ( [PW~Grupo])
      REFERENCES [PW~Grupos]
         ( [PW~Nome] )
      ON DELETE CASCADE
      ON UPDATE CASCADE
GO

 ALTER TABLE [dbo].[PW~Tabelas] ADD CONSTRAINT [FK_PW~Tabelas_PW~Grupos]
      FOREIGN KEY
         ( [PW~Grupo])
      REFERENCES [PW~Grupos]
         ( [PW~Nome] )
      ON DELETE CASCADE
      ON UPDATE CASCADE
GO
