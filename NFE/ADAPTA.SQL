/* Seleciona o banco de dados */

USE DADOSNFE
SET LANGUAGE Brazilian
SET DATEFORMAT mdy

/* Inicia uma transação */

SET XACT_ABORT ON
GO
BEGIN TRANSACTION
GO
SET NOCOUNT ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO
COMMIT
BEGIN TRANSACTION

/* Exclusão de triggers/foreign key constraints
   ============================================================ */

If exists (select * from sysobjects where id = object_id('FK_Geral_Municipios') and sysstat & 0xf = 11)
 ALTER TABLE [dbo].[Geral]
       DROP CONSTRAINT [FK_Geral_Municipios]
GO

If exists (select * from sysobjects where id = object_id('FK_Nota_fiscal_Geral') and sysstat & 0xf = 11)
 ALTER TABLE [dbo].[Nota fiscal]
       DROP CONSTRAINT [FK_Nota_fiscal_Geral]
GO

If exists (select * from sysobjects where id = object_id('FK_Nota_fiscal_Natureza_de_operação') and sysstat & 0xf = 11)
 ALTER TABLE [dbo].[Nota fiscal]
       DROP CONSTRAINT [FK_Nota_fiscal_Natureza_de_operação]
GO

If exists (select * from sysobjects where id = object_id('FK_Nota_fiscal_Classificação_fiscal') and sysstat & 0xf = 11)
 ALTER TABLE [dbo].[Nota fiscal]
       DROP CONSTRAINT [FK_Nota_fiscal_Classificação_fiscal]
GO

If exists (select * from sysobjects where id = object_id('FK_Produtos_Classificação_fiscal') and sysstat & 0xf = 11)
 ALTER TABLE [dbo].[Produtos]
       DROP CONSTRAINT [FK_Produtos_Classificação_fiscal]
GO

If exists (select * from sysobjects where id = object_id('FK_Produtos_Unidades') and sysstat & 0xf = 11)
 ALTER TABLE [dbo].[Produtos]
       DROP CONSTRAINT [FK_Produtos_Unidades]
GO

If exists (select * from sysobjects where id = object_id('FK_Produtos_da_nota_fiscal_Produtos') and sysstat & 0xf = 11)
 ALTER TABLE [dbo].[Produtos da nota fiscal]
       DROP CONSTRAINT [FK_Produtos_da_nota_fiscal_Produtos]
GO

If exists (select * from sysobjects where id = object_id('FK_PW~Usuarios_PW~Grupos') and sysstat & 0xf = 11)
 ALTER TABLE [dbo].[PW~Usuarios]
       DROP CONSTRAINT [FK_PW~Usuarios_PW~Grupos]
GO

If exists (select * from sysobjects where id = object_id('FK_PW~Tabelas_PW~Grupos') and sysstat & 0xf = 11)
 ALTER TABLE [dbo].[PW~Tabelas]
       DROP CONSTRAINT [FK_PW~Tabelas_PW~Grupos]
GO

/* cria tabela (Motoristas)
   ============================================================*/

CREATE TABLE Motoristas (
       [Codigo do Motorista]              smallint            DEFAULT 0           NOT NULL            ,
       [Nome do Motorista]                varchar (40)        DEFAULT ''          NOT NULL            ,
       CPF                                varchar (14)        DEFAULT ''          NOT NULL            ,
)
GO

ALTER TABLE Motoristas ADD CONSTRAINT [Codigo do Motorista] PRIMARY KEY  CLUSTERED 
(
[Codigo do Motorista]
)  WITH FILLFACTOR = 90
GO



/* Criação de triggers/foreign key constraints
   ============================================================ */

ALTER TABLE [dbo].[Nota fiscal] ADD CONSTRAINT FK_Nota_fiscal_Classificação_fiscal
 Foreign Key
  ( [Sequencia da classificação] )
 References [Classificação fiscal]
  ( [Sequencia da classificação] )
 ON UPDATE CASCADE
GO

ALTER TABLE [dbo].Produtos ADD CONSTRAINT FK_Produtos_Classificação_fiscal
 Foreign Key
  ( [Sequencia da classificação] )
 References [Classificação fiscal]
  ( [Sequencia da classificação] )
 ON UPDATE CASCADE
GO

ALTER TABLE [dbo].[Nota fiscal] ADD CONSTRAINT FK_Nota_fiscal_Geral
 Foreign Key
  ( [Sequencia do geral] )
 References Geral
  ( [Sequencia do geral] )
 ON UPDATE CASCADE
GO

ALTER TABLE [dbo].Geral ADD CONSTRAINT FK_Geral_Municipios
 Foreign Key
  ( [Sequencia do municipio] )
 References Municipios
  ( [Sequencia do municipio] )
 ON UPDATE CASCADE
GO

ALTER TABLE [dbo].[Nota fiscal] ADD CONSTRAINT FK_Nota_fiscal_Natureza_de_operação
 Foreign Key
  ( [Sequencia da natureza] )
 References [Natureza de operação]
  ( [Sequencia da natureza] )
 ON UPDATE CASCADE
GO

ALTER TABLE [dbo].[Produtos da nota fiscal] ADD CONSTRAINT FK_Produtos_da_nota_fiscal_Produtos
 Foreign Key
  ( [Sequencia do produto] )
 References Produtos
  ( [Sequencia do produto] )
 ON UPDATE CASCADE
GO

ALTER TABLE [dbo].Produtos ADD CONSTRAINT FK_Produtos_Unidades
 Foreign Key
  ( [Sequencia da unidade] )
 References Unidades
  ( [Sequencia da unidade] )
 ON UPDATE CASCADE
GO

ALTER TABLE [dbo].[PW~Usuarios] ADD CONSTRAINT [FK_PW~Usuarios_PW~Grupos]
 Foreign Key
  ( [PW~Grupo] )
 References [PW~Grupos]
  ( [PW~Nome] )
 ON DELETE CASCADE
 ON UPDATE CASCADE
GO

ALTER TABLE [dbo].[PW~Tabelas] ADD CONSTRAINT [FK_PW~Tabelas_PW~Grupos]
 Foreign Key
  ( [PW~Grupo] )
 References [PW~Grupos]
  ( [PW~Nome] )
 ON DELETE CASCADE
 ON UPDATE CASCADE
GO

/* fecha a transação */
COMMIT
SET NOCOUNT OFF
GO
SET XACT_ABORT OFF
GO

