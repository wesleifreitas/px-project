-- SQL Manager Lite for SQL Server 4.2.1.47272
-- ---------------------------------------
-- Host      : (local)
-- Database  : px_project
-- Version   : Microsoft SQL Server 2014 12.0.2000.8

--
-- Dropping table acesso : 
--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'acesso') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  DROP TABLE dbo.acesso
GO

--
-- Dropping table componente : 
--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'componente') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  DROP TABLE dbo.componente
GO

--
-- Dropping table exemplo : 
--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'exemplo') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  DROP TABLE dbo.exemplo
GO

--
-- Dropping table exemplo2 : 
--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'exemplo2') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  DROP TABLE dbo.exemplo2
GO

--
-- Dropping table grupo : 
--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'grupo') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  DROP TABLE dbo.grupo
GO

--
-- Dropping table log : 
--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'log') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  DROP TABLE dbo.log
GO

--
-- Dropping table menu : 
--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'menu') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  DROP TABLE dbo.menu
GO

--
-- Dropping table perfil : 
--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'perfil') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  DROP TABLE dbo.perfil
GO

--
-- Dropping table project : 
--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'project') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  DROP TABLE dbo.project
GO

--
-- Dropping table projeto : 
--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'projeto') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  DROP TABLE dbo.projeto
GO

--
-- Dropping table usuario : 
--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'usuario') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
  DROP TABLE dbo.usuario
GO

--
-- Dropping view vw_exemplo : 
--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'vw_exemplo') AND OBJECTPROPERTY(id, N'IsView') = 1)
  DROP VIEW dbo.vw_exemplo
GO

--
-- Dropping view vw_menu : 
--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'vw_menu') AND OBJECTPROPERTY(id, N'IsView') = 1)
  DROP VIEW dbo.vw_menu
GO

--
-- Dropping view vw_perfil : 
--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'vw_perfil') AND OBJECTPROPERTY(id, N'IsView') = 1)
  DROP VIEW dbo.vw_perfil
GO

--
-- Dropping view vw_usuario : 
--

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'vw_usuario') AND OBJECTPROPERTY(id, N'IsView') = 1)
  DROP VIEW dbo.vw_usuario
GO

--
-- Definition for table componente : 
--

CREATE TABLE dbo.componente (
  com_id int IDENTITY(1, 1) NOT NULL,
  com_view varchar(255) COLLATE Latin1_General_CI_AS NULL,
  com_icon varchar(40) COLLATE Latin1_General_CI_AS NULL,
  com_px_lib bit NULL,
  PRIMARY KEY CLUSTERED (com_id)
    WITH (
      PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF,
      ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)
)
ON [PRIMARY]
GO

--
-- Definition for table exemplo : 
--

CREATE TABLE dbo.exemplo (
  exe_id int IDENTITY(1, 1) NOT NULL,
  exe_ativo bit NULL,
  exe_nome varchar(30) COLLATE Latin1_General_CI_AS NULL,
  exe2_id int NULL,
  exe_cpf varchar(11) COLLATE Latin1_General_CI_AS NULL,
  exe_senha varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  exe_data datetime NULL,
  exe_valor decimal(19, 2) NULL,
  exe_telefone varchar(15) COLLATE Latin1_General_CI_AS NULL,
  exe_cep varchar(8) COLLATE Latin1_General_CI_AS NULL,
  exe_checkbox bit NULL,
  exe_checkbox_char char(1) COLLATE Latin1_General_CI_AS NULL,
  exe_radio_button char(1) COLLATE Latin1_General_CI_AS NULL,
  grupo_id int NULL,
  PRIMARY KEY CLUSTERED (exe_id)
    WITH (
      PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF,
      ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
ON [PRIMARY]
GO

EXEC sp_addextendedproperty 'MS_Description', N'Campo para px-input-search', N'schema', N'dbo', N'table', N'exemplo', N'column', N'exe2_id'
GO

--
-- Definition for table exemplo2 : 
--

CREATE TABLE dbo.exemplo2 (
  exe2_id int IDENTITY(1, 1) NOT NULL,
  exe2_categoria varchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  exe2_descricao varchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  PRIMARY KEY CLUSTERED (exe2_id)
    WITH (
      PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF,
      ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
ON [PRIMARY]
GO

--
-- Definition for table grupo : 
--

CREATE TABLE dbo.grupo (
  grupo_id int IDENTITY(1, 1) NOT NULL,
  grupo_nome varchar(30) COLLATE Latin1_General_CI_AS NULL,
  PRIMARY KEY CLUSTERED (grupo_id)
    WITH (
      PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF,
      ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
ON [PRIMARY]
GO

--
-- Definition for table log : 
--

CREATE TABLE dbo.log (
  log_id bigint IDENTITY(1, 1) NOT NULL,
  log_usu_id bigint NULL,
  log_objeto varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  log_action int NULL,
  log_script varchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  log_data datetime DEFAULT getdate() NULL,
  log_obs varchar(max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  log_objeto_tipo int NULL,
  log_com_id bigint NULL,
  log_browser varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  log_ip varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  CONSTRAINT log_pk PRIMARY KEY CLUSTERED (log_id)
    WITH (
      PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF,
      ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
ON [PRIMARY]
GO

--
-- Definition for table menu : 
--

CREATE TABLE dbo.menu (
  men_id int IDENTITY(1, 1) NOT NULL,
  men_ativo bit DEFAULT 0 NULL,
  men_nome varchar(50) COLLATE Latin1_General_CI_AS NULL,
  men_ordem tinyint NULL,
  men_idPai int NULL,
  men_sistema bit DEFAULT 0 NULL,
  com_id int DEFAULT 0 NULL,
  pro_id int NULL,
  PRIMARY KEY CLUSTERED (men_id)
    WITH (
      PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF,
      ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF)
)
ON [PRIMARY]
GO

EXEC sp_addextendedproperty 'MS_Description', N'1 = ativo', N'schema', N'dbo', N'table', N'menu', N'column', N'men_ativo'
GO

EXEC sp_addextendedproperty 'MS_Description', N'0 = menu principal', N'schema', N'dbo', N'table', N'menu', N'column', N'men_idPai'
GO

EXEC sp_addextendedproperty 'MS_Description', N'1 = somente usuários especias podem acessar', N'schema', N'dbo', N'table', N'menu', N'column', N'men_sistema'
GO

--
-- Definition for table perfil : 
--

CREATE TABLE dbo.perfil (
  per_id bigint IDENTITY(1, 1) NOT NULL,
  per_master bit NULL,
  per_ativo bit NULL,
  per_nome varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  per_developer bit NULL,
  per_resetarSenha bit DEFAULT 0 NULL,
  grupo_id bigint DEFAULT -1 NULL,
  pro_id int NULL,
  PRIMARY KEY CLUSTERED (per_id)
    WITH (
      PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF,
      ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
ON [PRIMARY]
GO

--
-- Definition for table project : 
--

CREATE TABLE dbo.project (
  pro_id int NOT NULL,
  pro_name varchar(255) COLLATE Latin1_General_CI_AS NULL,
  PRIMARY KEY CLUSTERED (pro_id)
    WITH (
      PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF,
      ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
ON [PRIMARY]
GO

--
-- Definition for table projeto : 
--

CREATE TABLE dbo.projeto (
  pro_id bigint NOT NULL,
  pro_versao varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  pro_ativo bit NULL,
  pro_data_atualizacao date NULL,
  pro_nome varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  pro_manutencao bit DEFAULT 0 NULL,
  pro_mensagem varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  PRIMARY KEY CLUSTERED (pro_id)
    WITH (
      PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF,
      ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
ON [PRIMARY]
GO

--
-- Definition for table usuario : 
--

CREATE TABLE dbo.usuario (
  usu_id bigint IDENTITY(1, 1) NOT NULL,
  usu_ativo tinyint NULL,
  per_id bigint NULL,
  usu_login varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  usu_senha varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  usu_nome varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  usu_email varchar(255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  usu_cpf varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
  usu_ultimoAcesso datetime NULL,
  usu_senhaExpira int NULL,
  usu_senhaData date NULL,
  usu_mudarSenha bit NULL,
  usu_tentativasLogin int NULL,
  usu_countTentativasLogin int NULL,
  usu_recuperarSenha bit DEFAULT 0 NULL,
  usu_recuperarSenhaData datetime NULL,
  CONSTRAINT usuario_pk PRIMARY KEY CLUSTERED (usu_id)
    WITH (
      PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF,
      ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)
ON [PRIMARY]
GO

--
-- Definition for view vw_exemplo : 
--
GO
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW dbo.vw_exemplo
WITH ENCRYPTION
AS
/* encrypted */
GO

--
-- Definition for view vw_menu : 
--
GO
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW dbo.vw_menu
WITH ENCRYPTION
AS
/* encrypted */
GO

--
-- Definition for view vw_perfil : 
--
GO
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW dbo.vw_perfil
WITH ENCRYPTION
AS
/* encrypted */
GO

--
-- Definition for view vw_usuario : 
--
GO
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW dbo.vw_usuario
WITH ENCRYPTION
AS
/* encrypted */
GO

--
-- Data for table dbo.acesso  (LIMIT 0,500)
--

INSERT INTO dbo.acesso (per_id, men_id, men_check)
VALUES 
  (2, 6, 0)
GO

INSERT INTO dbo.acesso (per_id, men_id, men_check)
VALUES 
  (2, 7, 1)
GO

INSERT INTO dbo.acesso (per_id, men_id, men_check)
VALUES 
  (2, 8, 1)
GO

--
-- Data for table dbo.componente  (LIMIT 0,500)
--

SET IDENTITY_INSERT dbo.componente ON
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (1, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (2, N'system/perfil/perfil.html', N'fa fa-users', 1)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (3, N'system/usuario/usuario.html', N'fa fa-user', 1)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (4, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (5, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (6, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (7, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (8, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (9, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (10, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (11, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (12, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (13, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (14, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (15, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (16, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (17, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (18, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (19, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (20, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (21, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (22, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (23, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (24, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (25, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (26, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (27, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (28, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (29, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (30, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (31, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (32, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (33, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (34, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (35, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (36, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (37, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (38, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (39, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (40, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (41, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (42, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (43, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (44, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (45, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (46, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (47, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (48, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (49, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (50, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (51, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (52, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (53, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (54, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (55, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (56, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (57, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (58, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (59, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (60, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (61, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (62, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (63, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (64, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (65, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (66, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (67, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (68, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (69, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (70, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (71, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (72, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (73, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (74, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (75, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (76, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (77, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (78, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (79, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (80, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (81, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (82, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (83, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (84, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (85, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (86, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (87, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (88, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (89, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (90, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (91, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (92, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (93, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (94, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (95, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (96, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (97, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (98, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (99, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (100, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (101, N'custom/rpl/rpl.html', N'fa fa-plane', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (102, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (103, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (104, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (105, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (106, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (107, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (108, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (109, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (110, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (111, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (112, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (113, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (114, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (115, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (116, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (117, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (118, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (119, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (120, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (121, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (122, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (123, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (124, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (125, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (126, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (127, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (128, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (129, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (130, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (131, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (132, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (133, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (134, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (135, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (136, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (137, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (138, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (139, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (140, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (141, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (142, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (143, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (144, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (145, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (146, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (147, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (148, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (149, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (150, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (151, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (152, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (153, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (154, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (155, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (156, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (157, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (158, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (159, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (160, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (161, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (162, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (163, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (164, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (165, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (166, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (167, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (168, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (169, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (170, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (171, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (172, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (173, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (174, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (175, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (176, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (177, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (178, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (179, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (180, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (181, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (182, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (183, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (184, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (185, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (186, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (187, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (188, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (189, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (190, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (191, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (192, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (193, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (194, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (195, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (196, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (197, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (198, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (199, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (200, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (201, N'custom/fornecedor/fornecedor.html', N'fa fa-industry', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (202, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (203, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (204, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (205, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (206, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (207, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (208, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (209, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (210, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (211, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (212, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (213, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (214, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (215, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (216, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (217, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (218, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (219, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (220, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (221, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (222, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (223, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (224, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (225, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (226, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (227, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (228, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (229, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (230, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (231, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (232, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (233, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (234, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (235, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (236, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (237, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (238, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (239, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (240, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (241, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (242, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (243, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (244, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (245, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (246, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (247, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (248, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (249, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (250, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (251, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (252, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (253, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (254, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (255, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (256, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (257, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (258, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (259, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (260, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (261, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (262, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (263, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (264, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (265, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (266, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (267, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (268, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (269, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (270, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (271, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (272, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (273, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (274, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (275, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (276, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (277, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (278, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (279, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (280, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (281, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (282, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (283, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (284, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (285, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (286, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (287, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (288, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (289, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (290, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (291, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (292, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (293, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (294, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (295, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (296, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (297, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (298, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (299, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (300, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (301, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (302, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (303, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (304, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (305, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (306, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (307, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (308, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (309, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (310, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (311, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (312, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (313, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (314, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (315, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (316, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (317, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (318, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (319, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (320, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (321, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (322, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (323, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (324, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (325, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (326, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (327, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (328, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (329, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (330, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (331, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (332, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (333, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (334, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (335, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (336, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (337, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (338, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (339, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (340, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (341, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (342, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (343, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (344, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (345, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (346, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (347, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (348, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (349, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (350, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (351, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (352, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (353, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (354, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (355, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (356, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (357, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (358, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (359, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (360, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (361, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (362, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (363, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (364, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (365, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (366, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (367, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (368, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (369, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (370, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (371, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (372, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (373, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (374, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (375, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (376, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (377, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (378, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (379, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (380, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (381, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (382, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (383, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (384, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (385, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (386, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (387, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (388, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (389, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (390, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (391, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (392, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (393, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (394, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (395, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (396, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (397, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (398, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (399, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (400, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (401, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (402, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (403, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (404, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (405, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (406, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (407, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (408, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (409, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (410, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (411, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (412, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (413, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (414, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (415, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (416, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (417, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (418, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (419, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (420, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (421, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (422, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (423, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (424, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (425, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (426, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (427, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (428, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (429, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (430, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (431, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (432, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (433, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (434, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (435, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (436, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (437, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (438, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (439, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (440, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (441, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (442, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (443, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (444, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (445, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (446, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (447, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (448, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (449, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (450, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (451, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (452, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (453, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (454, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (455, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (456, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (457, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (458, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (459, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (460, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (461, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (462, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (463, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (464, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (465, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (466, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (467, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (468, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (469, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (470, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (471, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (472, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (473, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (474, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (475, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (476, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (477, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (478, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (479, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (480, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (481, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (482, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (483, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (484, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (485, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (486, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (487, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (488, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (489, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (490, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (491, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (492, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (493, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (494, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (495, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (496, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (497, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (498, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (499, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (500, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

--
-- Data for table dbo.componente  (LIMIT 500,500)
--

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (501, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (502, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

INSERT INTO dbo.componente (com_id, com_view, com_icon, com_px_lib)
VALUES 
  (503, N'custom/exemplo/exemplo.html', N'glyphicon glyphicon-education', NULL)
GO

SET IDENTITY_INSERT dbo.componente OFF
GO

--
-- Data for table dbo.exemplo  (LIMIT 500,500)
--

SET IDENTITY_INSERT dbo.exemplo ON
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (1, 1, N'Nome 1', 1, N'39145592845', N'5D19B24E4E4146160CD2B98E705E335BCC9CB71F7EAAACAFD2096D3BF160C7D33007B8CA5BD48A7869F2B53F5DF1F79D71D8874A5ADF7156BA4DF19EE22F4683', '20151204 11:12:13.453', 12572.17, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (2, 1, N'Nome 2', 1, N'97972717349', N'123', '20151204 11:12:13.457', 13483.63, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (3, 1, N'Nome 3', 1, N'78747937642', N'123', '20151204 11:12:13.457', 18829.21, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (4, 1, N'Nome 4', 1, N'94042708790', N'123', '20151204 11:12:13.457', 13218.53, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (5, 1, N'Nome 5', 1, N'81148942232', N'123', '20151204 11:12:13.457', 16587.98, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (6, 1, N'Nome 6', 1, N'56472324408', N'123', '20151204 11:12:13.457', 16587.82, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (7, 1, N'Nome 7', 1, N'50389029576', N'123', '20151204 11:12:13.457', 13827.67, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (8, 1, N'Nome 8', 1, N'90522422817', N'123', '20151204 11:12:13.460', 18631.43, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (9, 1, N'Nome 9', 1, N'87181446248', N'123', '20151204 11:12:13.460', 16611.94, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (10, 1, N'Nome 10', 1, N'89075644575', N'123', '20151204 11:12:13.467', 10420.67, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (11, 1, N'Nome 11', 1, N'30702723806', N'123', '20151204 11:12:13.467', 15353.09, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (12, 1, N'Nome 12', 1, N'48760327066', N'123', '20151204 11:12:13.467', 17663.27, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (13, 1, N'Nome 13', 1, N'48005388730', N'123', '20151204 11:12:13.467', 16235.02, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (14, 1, N'Nome 14', 1, N'19144166066', N'123', '20151204 11:12:13.467', 17549.95, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (15, 1, N'Nome 15', 1, N'36319812411', N'123', '20151204 11:12:13.467', 11439.43, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (16, 1, N'Nome 16', 1, N'66101969289', N'123', '20151204 11:12:13.467', 12983.51, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (17, 1, N'Nome 17', 1, N'49950090777', N'123', '20151204 11:12:13.467', 12819.62, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (18, 1, N'Nome 18', 1, N'48074158129', N'123', '20151204 11:12:13.467', 15885.8, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (19, 1, N'Nome 19', 1, N'62574579809', N'123', '20151204 11:12:13.470', 18818.69, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (20, 1, N'Nome 20', 1, N'59840898011', N'123', '20151204 11:12:13.470', 13948.56, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (21, 1, N'Nome 21', 1, N'35851829097', N'123', '20151204 11:12:13.470', 10959.31, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (22, 1, N'Nome 22', 1, N'82920435123', N'123', '20151204 11:12:13.470', 10070.4, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (23, 1, N'Nome 23', 1, N'17300433710', N'123', '20151204 11:12:13.470', 14736.98, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (24, 1, N'Nome 24', 1, N'58165572665', N'123', '20151204 11:12:13.470', 12277.1, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (25, 1, N'Nome 25', 1, N'71344486857', N'123', '20151204 11:12:13.470', 14456.06, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (26, 1, N'Nome 26', 1, N'47175621561', N'123', '20151204 11:12:13.470', 10223.59, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (27, 1, N'Nome 27', 1, N'59632519919', N'123', '20151204 11:12:13.470', 19035.72, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (28, 1, N'Nome 28', 1, N'32634848860', N'123', '20151204 11:12:13.470', 18454.48, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (29, 1, N'Nome 29', 1, N'21346872454', N'123', '20151204 11:12:13.480', 14056.82, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (30, 1, N'Nome 30', 1, N'47097628840', N'123', '20151204 11:12:13.480', 16439.8, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (31, 1, N'Nome 31', 1, N'48252915071', N'123', '20151204 11:12:13.480', 11708.72, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (32, 1, N'Nome 32', 1, N'16805710095', N'123', '20151204 11:12:13.480', 18613.95, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (33, 1, N'Nome 33', 1, N'36050202921', N'123', '20151204 11:12:13.483', 14649.19, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (34, 1, N'Nome 34', 1, N'73969728928', N'123', '20151204 11:12:13.483', 12903.78, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (35, 1, N'Nome 35', 1, N'18312061650', N'123', '20151204 11:12:13.483', 13549.96, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (36, 1, N'Nome 36', 1, N'97065364220', N'123', '20151204 11:12:13.483', 17884.35, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (37, 1, N'Nome 37', 1, N'87804461165', N'123', '20151204 11:12:13.483', 13432.38, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (38, 1, N'Nome 38', 1, N'20049624430', N'123', '20151204 11:12:13.483', 17959.45, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (39, 1, N'Nome 39', 1, N'54074560614', N'123', '20151204 11:12:13.483', 18472.52, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (40, 1, N'Nome 40', 1, N'48141698596', N'123', '20151204 11:12:13.483', 15231.84, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (41, 1, N'Nome 41', 1, N'84703355465', N'123', '20151204 11:12:13.483', 16059.83, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (42, 1, N'Nome 42', 1, N'40062320897', N'123', '20151204 11:12:13.527', 10831.55, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (43, 1, N'Nome 43', 1, N'97953179815', N'123', '20151204 11:12:13.527', 12507.81, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (44, 1, N'Nome 44', 1, N'56928597893', N'123', '20151204 11:12:13.527', 10336.43, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (45, 1, N'Nome 45', 1, N'93260129667', N'123', '20151204 11:12:13.527', 17937.35, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (46, 1, N'Nome 46', 1, N'91360148862', N'123', '20151204 11:12:13.527', 15320.67, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (47, 1, N'Nome 47', 1, N'89731132725', N'123', '20151204 11:12:13.527', 19266.86, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (48, 1, N'Nome 48', 1, N'40793044018', N'123', '20151204 11:12:13.530', 13113.59, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (49, 1, N'Nome 49', 1, N'43488434839', N'123', '20151204 11:12:13.530', 14865.91, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (50, 1, N'Nome 50', 1, N'88161312942', N'123', '20151204 11:12:13.530', 16029.31, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (51, 1, N'Nome 51', 1, N'49106484072', N'123', '20151204 11:12:13.530', 14001.88, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (52, 1, N'Nome 52', 1, N'90465441479', N'123', '20151204 11:12:13.530', 15333.82, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (53, 1, N'Nome 53', 1, N'33973159229', N'123', '20151204 11:12:13.530', 14248.37, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (54, 1, N'Nome 54', 1, N'63891351087', N'123', '20151204 11:12:13.530', 13499.39, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (55, 1, N'Nome 55', 1, N'50713368383', N'123', '20151204 11:12:13.580', 11024.12, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (56, 1, N'Nome 56', 1, N'37608713012', N'123', '20151204 11:12:13.580', 12762.42, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (57, 1, N'Nome 57', 1, N'66554658093', N'123', '20151204 11:12:13.580', 12888.16, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (58, 1, N'Nome 58', 1, N'12488605658', N'123', '20151204 11:12:13.580', 12666.29, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (59, 1, N'Nome 59', 1, N'70126161386', N'123', '20151204 11:12:13.580', 16553.19, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (60, 1, N'Nome 60', 1, N'13840428814', N'123', '20151204 11:12:13.580', 18719.37, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (61, 1, N'Nome 61', 1, N'94241575139', N'123', '20151204 11:12:13.580', 17652.1, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (62, 1, N'Nome 62', 1, N'92683281612', N'123', '20151204 11:12:13.583', 17792.83, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (63, 1, N'Nome 63', 1, N'58454691128', N'123', '20151204 11:12:13.583', 12275.9, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (64, 1, N'Nome 64', 1, N'43576427688', N'123', '20151204 11:12:13.583', 17592.57, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (65, 1, N'Nome 65', 1, N'38626894690', N'123', '20151204 11:12:13.583', 16148.5, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (66, 1, N'Nome 66', 1, N'99526925061', N'123', '20151204 11:12:13.583', 14080.32, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (67, 1, N'Nome 67', 1, N'69149006166', N'123', '20151204 11:12:13.583', 18193.6, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (68, 1, N'Nome 68', 1, N'21380587243', N'123', '20151204 11:12:13.583', 15912.69, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (69, 1, N'Nome 69', 1, N'39071066239', N'123', '20151204 11:12:13.623', 14145.66, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (70, 1, N'Nome 70', 1, N'48345382656', N'123', '20151204 11:12:13.623', 16338.56, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (71, 1, N'Nome 71', 1, N'39135792042', N'123', '20151204 11:12:13.623', 14184.36, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (72, 1, N'Nome 72', 1, N'87740111906', N'123', '20151204 11:12:13.627', 14409.81, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (73, 1, N'Nome 73', 1, N'78754048733', N'123', '20151204 11:12:13.627', 13890.74, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (74, 1, N'Nome 74', 1, N'83062397744', N'123', '20151204 11:12:13.627', 15486.66, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (75, 1, N'Nome 75', 1, N'64630447006', N'123', '20151204 11:12:13.627', 17125.1, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (76, 1, N'Nome 76', 1, N'18210895884', N'123', '20151204 11:12:13.627', 14793.13, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (77, 1, N'Nome 77', 1, N'13678471979', N'123', '20151204 11:12:13.627', 14039.9, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (78, 1, N'Nome 78', 1, N'77128329229', N'123', '20151204 11:12:13.627', 14140.83, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (79, 1, N'Nome 79', 1, N'16578126848', N'123', '20151204 11:12:13.627', 18077.33, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (80, 1, N'Nome 80', 1, N'24533760665', N'123', '20151204 11:12:13.627', 17385.23, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (81, 1, N'Nome 81', 1, N'11172804114', N'123', '20151204 11:12:13.627', 15766.85, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (82, 1, N'Nome 82', 1, N'87809761467', N'123', '20151204 11:12:13.663', 11071.16, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (83, 1, N'Nome 83', 1, N'42434745142', N'123', '20151204 11:12:13.663', 14807.55, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (84, 1, N'Nome 84', 1, N'54817098907', N'123', '20151204 11:12:13.663', 10368.68, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (85, 1, N'Nome 85', 1, N'65416088068', N'123', '20151204 11:12:13.663', 13333.19, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (86, 1, N'Nome 86', 1, N'73222015875', N'123', '20151204 11:12:13.667', 12422.23, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (87, 1, N'Nome 87', 1, N'53698885235', N'123', '20151204 11:12:13.667', 11499.41, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (88, 1, N'Nome 88', 1, N'32371701714', N'123', '20151204 11:12:13.667', 13159.64, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (89, 1, N'Nome 89', 1, N'17347288715', N'123', '20151204 11:12:13.667', 13474.29, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (90, 1, N'Nome 90', 1, N'52243070886', N'123', '20151204 11:12:13.667', 16035.94, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (91, 1, N'Nome 91', 1, N'21679810722', N'123', '20151204 11:12:13.667', 14968.31, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (92, 1, N'Nome 92', 1, N'86847530464', N'123', '20151204 11:12:13.667', 13738.02, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (93, 1, N'Nome 93', 1, N'62713447832', N'123', '20151204 11:12:13.667', 18859.71, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (94, 1, N'Nome 94', 1, N'77462005146', N'123', '20151204 11:12:13.667', 19746.93, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (95, 1, N'Nome 95', 1, N'56209301811', N'123', '20151204 11:12:13.667', 15142.81, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (96, 1, N'Nome 96', 1, N'23874336953', N'123', '20151204 11:12:13.703', 15207.14, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (97, 1, N'Nome 97', 1, N'11202237012', N'123', '20151204 11:12:13.703', 10107.73, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (98, 1, N'Nome 98', 1, N'43023225706', N'123', '20151204 11:12:13.703', 13148.64, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (99, 1, N'Nome 99', 1, N'99272843119', N'123', '20151204 11:12:13.703', 18805.34, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (100, 1, N'Nome 100', 1, N'61545467012', N'123', '20151204 11:12:13.707', 12457, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (101, 1, N'Nome 101', 1, N'36554524913', N'3C9909AFEC25354D551DAE21590BB26E38D53F2173B8D3DC3EEE4C047E7AB1C1EB8B85103E3BE7BA613B31BB5C9C36214DC9F14A42FD7A2FDB84856BCA5C44C2', '20151204 11:12:13.707', 17760.83, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (102, 1, N'Nome 102', 1, N'77708542546', N'123', '20151204 11:12:13.707', 11628.56, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (103, 1, N'Nome 103', 1, N'96378200423', N'123', '20151204 11:12:13.707', 16624.87, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (104, 1, N'Nome 104', 1, N'17584394302', N'123', '20151204 11:12:13.710', 17316.69, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (105, 1, N'Nome 105', 1, N'56899687239', N'123', '20151204 11:12:13.710', 17708.29, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (106, 1, N'Nome 106', 1, N'27107281839', N'123', '20151204 11:12:13.710', 15487.78, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (107, 1, N'Nome 107', 1, N'72512702826', N'123', '20151204 11:12:13.710', 10262.77, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (108, 1, N'Nome 108', 1, N'80253667156', N'123', '20151204 11:12:13.710', 11733.12, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (109, 1, N'Nome 109', 1, N'20518191208', N'123', '20151204 11:12:13.710', 14739.25, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (110, 1, N'Nome 110', 1, N'36855279362', N'123', '20151204 11:12:13.747', 11969.64, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (111, 1, N'Nome 111', 1, N'91558184472', N'123', '20151204 11:12:13.750', 17170.91, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (112, 1, N'Nome 112', 1, N'37314178225', N'123', '20151204 11:12:13.750', 18617.74, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (113, 1, N'Nome 113', 1, N'77228576793', N'123', '20151204 11:12:13.750', 10196.03, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (114, 1, N'Nome 114', 1, N'97194580884', N'123', '20151204 11:12:13.750', 14363.06, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (115, 1, N'Nome 115', 1, N'72112315195', N'123', '20151204 11:12:13.750', 10793.22, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (116, 1, N'Nome 116', 1, N'86534600317', N'123', '20151204 11:12:13.750', 11893.61, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (117, 1, N'Nome 117', 1, N'42733094378', N'123', '20151204 11:12:13.750', 13853.65, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (118, 1, N'Nome 118', 1, N'44107917850', N'123', '20151204 11:12:13.750', 17077.8, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (119, 1, N'Nome 119', 1, N'38947716203', N'123', '20151204 11:12:13.750', 17506.69, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (120, 1, N'Nome 120', 1, N'68812222032', N'123', '20151204 11:12:13.750', 11219.2, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (121, 1, N'Nome 121', 1, N'64992982706', N'123', '20151204 11:12:13.750', 10498.28, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (122, 1, N'Nome 122', 1, N'44669839991', N'123', '20151204 11:12:13.750', 12793.34, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (123, 1, N'Nome 123', 1, N'33676327717', N'123', '20151204 11:12:13.780', 18148.27, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (124, 1, N'Nome 124', 1, N'61265603825', N'123', '20151204 11:12:13.780', 16875.86, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (125, 1, N'Nome 125', 1, N'93242670266', N'123', '20151204 11:12:13.780', 10294.78, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (126, 1, N'Nome 126', 1, N'99562202857', N'123', '20151204 11:12:13.780', 17777.83, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (127, 1, N'Nome 127', 1, N'57682207419', N'123', '20151204 11:12:13.780', 17535.92, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (128, 1, N'Nome 128', 1, N'90278288353', N'123', '20151204 11:12:13.780', 19569.1, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (129, 1, N'Nome 129', 1, N'80205573161', N'123', '20151204 11:12:13.780', 12811.78, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (130, 1, N'Nome 130', 1, N'29806613272', N'123', '20151204 11:12:13.780', 12041.97, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (131, 1, N'Nome 131', 1, N'28112295278', N'123', '20151204 11:12:13.780', 17882.69, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (132, 1, N'Nome 132', 1, N'92067391519', N'123', '20151204 11:12:13.780', 10408.27, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (133, 1, N'Nome 133', 1, N'32766446895', N'123', '20151204 11:12:13.780', 19187.41, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (134, 1, N'Nome 134', 1, N'63573159216', N'123', '20151204 11:12:13.780', 10851.46, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (135, 1, N'Nome 135', 1, N'49415748989', N'123', '20151204 11:12:13.780', 15511.56, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (136, 1, N'Nome 136', 1, N'70707355241', N'123', '20151204 11:12:13.783', 19200.64, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (137, 1, N'Nome 137', 1, N'17858884667', N'123', '20151204 11:12:13.813', 12865.49, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (138, 1, N'Nome 138', 1, N'30975829771', N'123', '20151204 11:12:13.813', 11087.98, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (139, 1, N'Nome 139', 1, N'81578098832', N'123', '20151204 11:12:13.813', 11440.61, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (140, 1, N'Nome 140', 1, N'79326516095', N'123', '20151204 11:12:13.813', 15393.54, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (141, 1, N'Nome 141', 1, N'84727256391', N'123', '20151204 11:12:13.813', 14328.22, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (142, 1, N'Nome 142', 1, N'17469218505', N'123', '20151204 11:12:13.817', 13989.84, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (143, 1, N'Nome 143', 1, N'53967456735', N'123', '20151204 11:12:13.817', 18898.62, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (144, 1, N'Nome 144', 1, N'28681915690', N'123', '20151204 11:12:13.817', 15490.87, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (145, 1, N'Nome 145', 1, N'46630789645', N'123', '20151204 11:12:13.817', 18897, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (146, 1, N'Nome 146', 1, N'86615137536', N'123', '20151204 11:12:13.817', 12768.9, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (147, 1, N'Nome 147', 1, N'48334806764', N'123', '20151204 11:12:13.817', 17007.87, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (148, 1, N'Nome 148', 1, N'39249923722', N'123', '20151204 11:12:13.817', 15359.64, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (149, 1, N'Nome 149', 1, N'32035313620', N'123', '20151204 11:12:13.817', 13524.04, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (150, 1, N'Nome 150', 1, N'71823187667', N'123', '20151204 11:12:13.850', 18087.97, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (151, 1, N'Nome 151', 1, N'77940846026', N'123', '20151204 11:12:13.850', 19619.67, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (152, 1, N'Nome 152', 1, N'82323398559', N'123', '20151204 11:12:13.850', 18006.06, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (153, 1, N'Nome 153', 1, N'95771217417', N'123', '20151204 11:12:13.850', 17498.17, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (154, 1, N'Nome 154', 1, N'46894261843', N'123', '20151204 11:12:13.850', 10690.92, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (155, 1, N'Nome 155', 1, N'84920887797', N'123', '20151204 11:12:13.853', 11527.12, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (156, 1, N'Nome 156', 1, N'52227350244', N'123', '20151204 11:12:13.853', 14641.58, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (157, 1, N'Nome 157', 1, N'97653481031', N'123', '20151204 11:12:13.853', 19735.94, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (158, 1, N'Nome 158', 1, N'66220745372', N'123', '20151204 11:12:13.853', 13693.63, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (159, 1, N'Nome 159', 1, N'74267055655', N'123', '20151204 11:12:13.853', 10269.81, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (160, 1, N'Nome 160', 1, N'52161266986', N'123', '20151204 11:12:13.853', 19619.75, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (161, 1, N'Nome 161', 1, N'13996300387', N'123', '20151204 11:12:13.853', 11801.3, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (162, 1, N'Nome 162', 1, N'73313502136', N'123', '20151204 11:12:13.853', 15064.63, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (163, 1, N'Nome 163', 1, N'13765161846', N'123', '20151204 11:12:13.853', 17880.99, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (164, 1, N'Nome 164', 1, N'27597255129', N'123', '20151204 11:12:13.863', 12315.01, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (165, 1, N'Nome 165', 1, N'34941408894', N'123', '20151204 11:12:13.863', 11995.02, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (166, 1, N'Nome 166', 1, N'55688076149', N'123', '20151204 11:12:13.863', 12095.88, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (167, 1, N'Nome 167', 1, N'80799961249', N'123', '20151204 11:12:13.863', 19672.82, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (168, 1, N'Nome 168', 1, N'83119981545', N'123', '20151204 11:12:13.863', 13692.26, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (169, 1, N'Nome 169', 1, N'29673633857', N'123', '20151204 11:12:13.863', 16431.23, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (170, 1, N'Nome 170', 1, N'56475593681', N'123', '20151204 11:12:13.863', 14740.41, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (171, 1, N'Nome 171', 1, N'34861325995', N'123', '20151204 11:12:13.867', 18846.17, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (172, 1, N'Nome 172', 1, N'79154582395', N'123', '20151204 11:12:13.867', 12407.77, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (173, 1, N'Nome 173', 1, N'72531952519', N'123', '20151204 11:12:13.867', 12104.84, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (174, 1, N'Nome 174', 1, N'15525532468', N'123', '20151204 11:12:13.867', 12808.36, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (175, 1, N'Nome 175', 1, N'21684369402', N'123', '20151204 11:12:13.867', 15416.24, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (176, 1, N'Nome 176', 1, N'80500325836', N'123', '20151204 11:12:13.867', 12024.31, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (177, 1, N'Nome 177', 1, N'76033310125', N'123', '20151204 11:12:13.867', 19811.98, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (178, 1, N'Nome 178', 1, N'12457712114', N'123', '20151204 11:12:13.870', 18193.3, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (179, 1, N'Nome 179', 1, N'44713605448', N'123', '20151204 11:12:13.870', 19426.73, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (180, 1, N'Nome 180', 1, N'78062607350', N'123', '20151204 11:12:13.870', 17183.32, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (181, 1, N'Nome 181', 1, N'62522218452', N'123', '20151204 11:12:13.870', 13645.16, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (182, 1, N'Nome 182', 1, N'25427818771', N'123', '20151204 11:12:13.870', 12381.61, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (183, 1, N'Nome 183', 1, N'12465027550', N'123', '20151204 11:12:13.870', 13178.98, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (184, 1, N'Nome 184', 1, N'26289703696', N'123', '20151204 11:12:13.870', 14238.65, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (185, 1, N'Nome 185', 1, N'47138982171', N'123', '20151204 11:12:13.870', 13862.72, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (186, 1, N'Nome 186', 1, N'28963820170', N'123', '20151204 11:12:13.870', 19368.56, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (187, 1, N'Nome 187', 1, N'75254321852', N'123', '20151204 11:12:13.870', 16203.02, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (188, 1, N'Nome 188', 1, N'41136067682', N'123', '20151204 11:12:13.870', 12263.02, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (189, 1, N'Nome 189', 1, N'99178194459', N'123', '20151204 11:12:13.870', 14119.26, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (190, 1, N'Nome 190', 1, N'38199494523', N'123', '20151204 11:12:13.870', 14148.63, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (191, 1, N'Nome 191', 1, N'22305308794', N'123', '20151204 11:12:13.870', 19841.07, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (192, 1, N'Nome 192', 1, N'65851437094', N'123', '20151204 11:12:13.870', 15847.33, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (193, 1, N'Nome 193', 1, N'62123536176', N'123', '20151204 11:12:13.870', 15076.62, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (194, 1, N'Nome 194', 1, N'26114705158', N'123', '20151204 11:12:13.870', 10010.16, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (195, 1, N'Nome 195', 1, N'85163776938', N'123', '20151204 11:12:13.873', 10182.73, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (196, 1, N'Nome 196', 1, N'54299011140', N'123', '20151204 11:12:13.873', 14337.32, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (197, 1, N'Nome 197', 1, N'20355970830', N'123', '20151204 11:12:13.873', 19460.46, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (198, 1, N'Nome 198', 1, N'12703656573', N'123', '20151204 11:12:13.873', 10882.6, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (199, 1, N'Nome 199', 1, N'29232308472', N'123', '20151204 11:12:13.873', 17513.62, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (200, 1, N'Nome 200', 1, N'39484955522', N'123', '20151204 11:12:13.873', 15099.16, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (201, 1, N'Nome 201', 1, N'65363378396', N'123', '20151204 11:12:13.873', 17398.07, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (202, 1, N'Nome 202', 1, N'84526232891', N'123', '20151204 11:12:13.873', 16309.64, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (203, 1, N'Nome 203', 1, N'39436241017', N'123', '20151204 11:12:13.873', 14071.54, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (204, 1, N'Nome 204', 1, N'21670169878', N'123', '20151204 11:12:13.900', 17286.34, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (205, 1, N'Nome 205', 1, N'75944366002', N'123', '20151204 11:12:13.900', 19687.64, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (206, 1, N'Nome 206', 1, N'21904535140', N'123', '20151204 11:12:13.903', 13555.92, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (207, 1, N'Nome 207', 1, N'62380970672', N'123', '20151204 11:12:13.903', 16860.38, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (208, 1, N'Nome 208', 1, N'47892848493', N'123', '20151204 11:12:13.903', 19579.13, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (209, 1, N'Nome 209', 1, N'40087045690', N'123', '20151204 11:12:13.903', 11320.63, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (210, 1, N'Nome 210', 1, N'58871202354', N'123', '20151204 11:12:13.903', 10941.5, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (211, 1, N'Nome 211', 1, N'98611412966', N'123', '20151204 11:12:13.903', 19597.44, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (212, 1, N'Nome 212', 1, N'15694449511', N'123', '20151204 11:12:13.903', 11902.12, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (213, 1, N'Nome 213', 1, N'28229805176', N'123', '20151204 11:12:13.903', 12622.57, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (214, 1, N'Nome 214', 1, N'83820667566', N'123', '20151204 11:12:13.907', 19798.66, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (215, 1, N'Nome 215', 1, N'73124499362', N'123', '20151204 11:12:13.907', 17101.49, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (216, 1, N'Nome 216', 1, N'64394730953', N'123', '20151204 11:12:13.907', 18461.83, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (217, 1, N'Nome 217', 1, N'86136464707', N'123', '20151204 11:12:13.907', 14753.66, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (218, 1, N'Nome 218', 1, N'44231344254', N'123', '20151204 11:12:13.907', 14519.61, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (219, 1, N'Nome 219', 1, N'93448031163', N'123', '20151204 11:12:13.907', 19706.16, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (220, 1, N'Nome 220', 1, N'88824263552', N'123', '20151204 11:12:13.907', 17670.8, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (221, 1, N'Nome 221', 1, N'86682096236', N'123', '20151204 11:12:13.907', 14771.6, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (222, 1, N'Nome 222', 1, N'90384829879', N'123', '20151204 11:12:13.907', 18817.81, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (223, 1, N'Nome 223', 1, N'24193607213', N'123', '20151204 11:12:13.907', 14372, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (224, 1, N'Nome 224', 1, N'48158771560', N'123', '20151204 11:12:13.907', 10627.55, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (225, 1, N'Nome 225', 1, N'46794583378', N'123', '20151204 11:12:13.907', 12191.99, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (226, 1, N'Nome 226', 1, N'52276306313', N'123', '20151204 11:12:13.910', 18281.56, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (227, 1, N'Nome 227', 1, N'55301653762', N'123', '20151204 11:12:13.910', 16238.86, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (228, 1, N'Nome 228', 1, N'29597906982', N'123', '20151204 11:12:13.910', 13508.65, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (229, 1, N'Nome 229', 1, N'41998790052', N'123', '20151204 11:12:13.910', 16840.39, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (230, 1, N'Nome 230', 1, N'32267327272', N'123', '20151204 11:12:13.910', 17726.09, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (231, 1, N'Nome 231', 1, N'52076918092', N'123', '20151204 11:12:13.910', 18413.12, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (232, 1, N'Nome 232', 1, N'19642696307', N'123', '20151204 11:12:13.910', 13838.55, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (233, 1, N'Nome 233', 1, N'36613871024', N'123', '20151204 11:12:13.910', 13357.89, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (234, 1, N'Nome 234', 1, N'59528837926', N'123', '20151204 11:12:13.910', 12626.27, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (235, 1, N'Nome 235', 1, N'65628373617', N'123', '20151204 11:12:13.910', 17029.27, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (236, 1, N'Nome 236', 1, N'54373319342', N'123', '20151204 11:12:13.910', 10536.05, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (237, 1, N'Nome 237', 1, N'64718088809', N'123', '20151204 11:12:13.910', 11287.99, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (238, 1, N'Nome 238', 1, N'28334893176', N'123', '20151204 11:12:13.913', 15728.74, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (239, 1, N'Nome 239', 1, N'94691467864', N'123', '20151204 11:12:13.913', 12698.49, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (240, 1, N'Nome 240', 1, N'24389328672', N'123', '20151204 11:12:13.913', 14027.42, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (241, 1, N'Nome 241', 1, N'12716458616', N'123', '20151204 11:12:13.913', 14906.67, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (242, 1, N'Nome 242', 1, N'72439731424', N'123', '20151204 11:12:13.913', 11264.84, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (243, 1, N'Nome 243', 1, N'83762287920', N'123', '20151204 11:12:13.913', 14721.5, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (244, 1, N'Nome 244', 1, N'30525010401', N'123', '20151204 11:12:13.913', 15132.73, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (245, 1, N'Nome 245', 1, N'96646346329', N'123', '20151204 11:12:13.913', 14256.51, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (246, 1, N'Nome 246', 1, N'46830963654', N'123', '20151204 11:12:13.913', 12414.26, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (247, 1, N'Nome 247', 1, N'73075317872', N'123', '20151204 11:12:13.913', 18352.63, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (248, 1, N'Nome 248', 1, N'29974707730', N'123', '20151204 11:12:13.913', 16339.2, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (249, 1, N'Nome 249', 1, N'32620550905', N'123', '20151204 11:12:13.913', 16405.19, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (250, 1, N'Nome 250', 1, N'95495368272', N'123', '20151204 11:12:13.917', 12011.75, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (251, 1, N'Nome 251', 1, N'37967238644', N'123', '20151204 11:12:13.917', 12333.97, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (252, 1, N'Nome 252', 1, N'38785728283', N'123', '20151204 11:12:13.917', 16656.15, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (253, 1, N'Nome 253', 1, N'54626224630', N'123', '20151204 11:12:13.917', 11565.23, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (254, 1, N'Nome 254', 1, N'90912216550', N'123', '20151204 11:12:13.917', 18873.34, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (255, 1, N'Nome 255', 1, N'78443524295', N'123', '20151204 11:12:13.917', 12619.96, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (256, 1, N'Nome 256', 1, N'64620893209', N'123', '20151204 11:12:13.917', 14803.15, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (257, 1, N'Nome 257', 1, N'99806394898', N'123', '20151204 11:12:13.917', 10756.37, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (258, 1, N'Nome 258', 1, N'95507126241', N'123', '20151204 11:12:13.917', 19244.03, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (259, 1, N'Nome 259', 1, N'14057366837', N'123', '20151204 11:12:13.917', 17097.31, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (260, 1, N'Nome 260', 1, N'20895642640', N'123', '20151204 11:12:13.917', 15178.7, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (261, 1, N'Nome 261', 1, N'90308204877', N'123', '20151204 11:12:13.917', 10687.43, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (262, 1, N'Nome 262', 1, N'74663991763', N'123', '20151204 11:12:13.920', 19727.97, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (263, 1, N'Nome 263', 1, N'68213546134', N'123', '20151204 11:12:13.920', 13526.92, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (264, 1, N'Nome 264', 1, N'34302398780', N'123', '20151204 11:12:13.920', 12376.76, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (265, 1, N'Nome 265', 1, N'28719410283', N'123', '20151204 11:12:13.920', 15943.71, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (266, 1, N'Nome 266', 1, N'31956448518', N'123', '20151204 11:12:13.920', 16374.02, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (267, 1, N'Nome 267', 1, N'29313610907', N'123', '20151204 11:12:13.920', 10379.7, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (268, 1, N'Nome 268', 1, N'70870918131', N'123', '20151204 11:12:13.920', 11147.98, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (269, 1, N'Nome 269', 1, N'13597160024', N'123', '20151204 11:12:13.920', 15104.59, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (270, 1, N'Nome 270', 1, N'80152955379', N'123', '20151204 11:12:13.920', 13259.65, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (271, 1, N'Nome 271', 1, N'54539596975', N'123', '20151204 11:12:13.920', 11059.27, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (272, 1, N'Nome 272', 1, N'13647659978', N'123', '20151204 11:12:13.920', 10859.44, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (273, 1, N'Nome 273', 1, N'70397647429', N'123', '20151204 11:12:13.920', 11945.93, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (274, 1, N'Nome 274', 1, N'23084195201', N'123', '20151204 11:12:13.920', 15100.23, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (275, 1, N'Nome 275', 1, N'46994532297', N'123', '20151204 11:12:13.920', 12408.87, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (276, 1, N'Nome 276', 1, N'75921485517', N'123', '20151204 11:12:13.920', 14167.35, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (277, 1, N'Nome 277', 1, N'84067603408', N'123', '20151204 11:12:13.920', 18652.94, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (278, 1, N'Nome 278', 1, N'91375790280', N'123', '20151204 11:12:13.923', 19128.56, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (279, 1, N'Nome 279', 1, N'32312069790', N'123', '20151204 11:12:13.923', 11189.82, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (280, 1, N'Nome 280', 1, N'49813300018', N'123', '20151204 11:12:13.923', 11104.53, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (281, 1, N'Nome 281', 1, N'42429852718', N'123', '20151204 11:12:13.923', 12757.02, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (282, 1, N'Nome 282', 1, N'74909587742', N'123', '20151204 11:12:13.923', 19102.32, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (283, 1, N'Nome 283', 1, N'16694477642', N'123', '20151204 11:12:13.923', 16607.13, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (284, 1, N'Nome 284', 1, N'16409199415', N'123', '20151204 11:12:13.923', 19120.5, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (285, 1, N'Nome 285', 1, N'63665800152', N'123', '20151204 11:12:13.923', 13562.23, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (286, 1, N'Nome 286', 1, N'81234334705', N'123', '20151204 11:12:13.923', 15953.58, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (287, 1, N'Nome 287', 1, N'75921658577', N'123', '20151204 11:12:13.923', 15398.44, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (288, 1, N'Nome 288', 1, N'94515291803', N'123', '20151204 11:12:13.923', 10844.04, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (289, 1, N'Nome 289', 1, N'17938977252', N'123', '20151204 11:12:13.923', 12083.06, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (290, 1, N'Nome 290', 1, N'96887896352', N'123', '20151204 11:12:13.923', 18381.53, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (291, 1, N'Nome 291', 1, N'54973399385', N'123', '20151204 11:12:13.927', 19569.19, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (292, 1, N'Nome 292', 1, N'41219681121', N'123', '20151204 11:12:13.927', 17607.57, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (293, 1, N'Nome 293', 1, N'36029477310', N'123', '20151204 11:12:13.927', 14865.98, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (294, 1, N'Nome 294', 1, N'28016618230', N'123', '20151204 11:12:13.927', 18995.85, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (295, 1, N'Nome 295', 1, N'55692974575', N'123', '20151204 11:12:13.927', 15337.22, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (296, 1, N'Nome 296', 1, N'76081146869', N'123', '20151204 11:12:13.927', 19080.9, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (297, 1, N'Nome 297', 1, N'44681476640', N'123', '20151204 11:12:13.927', 17816.93, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (298, 1, N'Nome 298', 1, N'15749587245', N'123', '20151204 11:12:13.927', 12953.88, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (299, 1, N'Nome 299', 1, N'49474211254', N'123', '20151204 11:12:13.927', 13508.1, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (300, 1, N'Nome 300', 1, N'76543342780', N'123', '20151204 11:12:13.927', 18468.93, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (301, 1, N'Nome 301', 1, N'37830222298', N'123', '20151204 11:12:13.927', 18076.44, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (302, 1, N'Nome 302', 1, N'40120788502', N'123', '20151204 11:12:13.930', 13748.9, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (303, 1, N'Nome 303', 1, N'68931542546', N'123', '20151204 11:12:13.930', 11908.72, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (304, 1, N'Nome 304', 1, N'90067428514', N'123', '20151204 11:12:13.930', 18529.39, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (305, 1, N'Nome 305', 1, N'17959177101', N'123', '20151204 11:12:13.930', 15764.18, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (306, 1, N'Nome 306', 1, N'44596810599', N'123', '20151204 11:12:13.930', 12236.31, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (307, 1, N'Nome 307', 1, N'71538112551', N'123', '20151204 11:12:13.930', 15956.68, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (308, 1, N'Nome 308', 1, N'61726816218', N'123', '20151204 11:12:13.930', 11521.8, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (309, 1, N'Nome 309', 1, N'35484913821', N'123', '20151204 11:12:13.930', 16567.7, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (310, 1, N'Nome 310', 1, N'82683254906', N'123', '20151204 11:12:13.930', 18839.76, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (311, 1, N'Nome 311', 1, N'38210825201', N'123', '20151204 11:12:13.930', 10225.39, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (312, 1, N'Nome 312', 1, N'61883185117', N'123', '20151204 11:12:13.930', 13149.28, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (313, 1, N'Nome 313', 1, N'80385905859', N'123', '20151204 11:12:13.930', 16722.23, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (314, 1, N'Nome 314', 1, N'72683420012', N'123', '20151204 11:12:13.930', 18982.13, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (315, 1, N'Nome 315', 1, N'19683614441', N'123', '20151204 11:12:13.930', 14474.41, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (316, 1, N'Nome 316', 1, N'83587093431', N'123', '20151204 11:12:13.930', 11796.67, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (317, 1, N'Nome 317', 1, N'14547123564', N'123', '20151204 11:12:13.930', 12129.32, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (318, 1, N'Nome 318', 1, N'88303880592', N'123', '20151204 11:12:13.930', 15883.79, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (319, 1, N'Nome 319', 1, N'52560097694', N'123', '20151204 11:12:13.933', 18095.86, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (320, 1, N'Nome 320', 1, N'36294858554', N'123', '20151204 11:12:13.933', 17724.77, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (321, 1, N'Nome 321', 1, N'38961332636', N'123', '20151204 11:12:13.933', 18168.68, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (322, 1, N'Nome 322', 1, N'74677903653', N'123', '20151204 11:12:13.933', 15608.98, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (323, 1, N'Nome 323', 1, N'13090580466', N'123', '20151204 11:12:13.933', 12860.59, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (324, 1, N'Nome 324', 1, N'73490280287', N'123', '20151204 11:12:13.933', 17397.18, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (325, 1, N'Nome 325', 1, N'69189984277', N'123', '20151204 11:12:13.933', 10318.96, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (326, 1, N'Nome 326', 1, N'16561504602', N'123', '20151204 11:12:13.933', 17951.47, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (327, 1, N'Nome 327', 1, N'70007684982', N'123', '20151204 11:12:13.933', 17050.64, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (328, 1, N'Nome 328', 1, N'15571218312', N'123', '20151204 11:12:13.933', 19700.41, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (329, 1, N'Nome 329', 1, N'80513528969', N'123', '20151204 11:12:13.933', 13264.56, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (330, 1, N'Nome 330', 1, N'24382728907', N'123', '20151204 11:12:13.933', 18318.24, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (331, 1, N'Nome 331', 1, N'34852087523', N'123', '20151204 11:12:13.937', 17913.45, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (332, 1, N'Nome 332', 1, N'15339079407', N'123', '20151204 11:12:13.937', 18723.38, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (333, 1, N'Nome 333', 1, N'69269320380', N'123', '20151204 11:12:13.937', 17594.22, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (334, 1, N'Nome 334', 1, N'65481896482', N'123', '20151204 11:12:13.980', 13927.99, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (335, 1, N'Nome 335', 1, N'57704778126', N'123', '20151204 11:12:13.980', 18939.99, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (336, 1, N'Nome 336', 1, N'25258834507', N'123', '20151204 11:12:13.980', 13574.29, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (337, 1, N'Nome 337', 1, N'28904142136', N'123', '20151204 11:12:13.980', 18884.31, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (338, 1, N'Nome 338', 1, N'61432389671', N'123', '20151204 11:12:13.980', 12146.49, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (339, 1, N'Nome 339', 1, N'33327633458', N'123', '20151204 11:12:13.983', 11699.69, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (340, 1, N'Nome 340', 1, N'97850194121', N'123', '20151204 11:12:13.983', 10493.02, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (341, 1, N'Nome 341', 1, N'66994801609', N'123', '20151204 11:12:13.983', 18147.7, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (342, 1, N'Nome 342', 1, N'59026940603', N'123', '20151204 11:12:13.983', 12313.64, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (343, 1, N'Nome 343', 1, N'78088098353', N'123', '20151204 11:12:13.987', 11290.75, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (344, 1, N'Nome 344', 1, N'78609949698', N'123', '20151204 11:12:13.987', 11359.94, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (345, 1, N'Nome 345', 1, N'53740083387', N'123', '20151204 11:12:13.987', 18405.85, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (346, 1, N'Nome 346', 1, N'57271902361', N'123', '20151204 11:12:13.990', 16407.23, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (347, 1, N'Nome 347', 1, N'59293936263', N'123', '20151204 11:12:13.990', 18460.26, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (348, 1, N'Nome 348', 1, N'37649979172', N'123', '20151204 11:12:13.990', 19570.51, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (349, 1, N'Nome 349', 1, N'98783894450', N'123', '20151204 11:12:13.990', 11069.4, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (350, 1, N'Nome 350', 1, N'99300762226', N'123', '20151204 11:12:13.990', 16699.3, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (351, 1, N'Nome 351', 1, N'69037906333', N'123', '20151204 11:12:13.990', 14193.97, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (352, 1, N'Nome 352', 1, N'74596975444', N'123', '20151204 11:12:13.990', 18408.46, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (353, 1, N'Nome 353', 1, N'80675108887', N'123', '20151204 11:12:13.990', 18115.99, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (354, 1, N'Nome 354', 1, N'93567584093', N'123', '20151204 11:12:13.990', 18657.02, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (355, 1, N'Nome 355', 1, N'13276319513', N'123', '20151204 11:12:13.993', 13357.77, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (356, 1, N'Nome 356', 1, N'13381942092', N'123', '20151204 11:12:13.993', 17820.85, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (357, 1, N'Nome 357', 1, N'62894694634', N'123', '20151204 11:12:13.993', 14054.8, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (358, 1, N'Nome 358', 1, N'22024829610', N'123', '20151204 11:12:13.993', 19616.91, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (359, 1, N'Nome 359', 1, N'76749150090', N'123', '20151204 11:12:13.993', 18150.4, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (360, 1, N'Nome 360', 1, N'16452782167', N'123', '20151204 11:12:13.997', 14284.24, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (361, 1, N'Nome 361', 1, N'54727883210', N'123', '20151204 11:12:13.997', 10708.92, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (362, 1, N'Nome 362', 1, N'56365223509', N'123', '20151204 11:12:13.997', 10536.46, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (363, 1, N'Nome 363', 1, N'36357087874', N'123', '20151204 11:12:13.997', 13395.49, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (364, 1, N'Nome 364', 1, N'54749770037', N'123', '20151204 11:12:13.997', 10792.68, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (365, 1, N'Nome 365', 1, N'73489600339', N'123', '20151204 11:12:13.997', 14701.04, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (366, 1, N'Nome 366', 1, N'15782676806', N'123', '20151204 11:12:13.997', 10604.09, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (367, 1, N'Nome 367', 1, N'19842457554', N'123', '20151204 11:12:14', 17755.18, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (368, 1, N'Nome 368', 1, N'84084465397', N'123', '20151204 11:12:14', 18489.67, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (369, 1, N'Nome 369', 1, N'14917317757', N'123', '20151204 11:12:14', 14770.33, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (370, 1, N'Nome 370', 1, N'67960915317', N'123', '20151204 11:12:14', 18100.72, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (371, 1, N'Nome 371', 1, N'76645052438', N'123', '20151204 11:12:14', 12763.03, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (372, 1, N'Nome 372', 1, N'55002974921', N'123', '20151204 11:12:14', 18168.79, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (373, 1, N'Nome 373', 1, N'88890873565', N'123', '20151204 11:12:14', 18189.81, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (374, 1, N'Nome 374', 1, N'25360312494', N'123', '20151204 11:12:14', 11220.63, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (375, 1, N'Nome 375', 1, N'89845182035', N'123', '20151204 11:12:14.003', 13690.96, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (376, 1, N'Nome 376', 1, N'44396814741', N'123', '20151204 11:12:14.003', 10520.85, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (377, 1, N'Nome 377', 1, N'46335604587', N'123', '20151204 11:12:14.003', 19094.04, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (378, 1, N'Nome 378', 1, N'25854465601', N'123', '20151204 11:12:14.003', 14574.9, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (379, 1, N'Nome 379', 1, N'78104464879', N'123', '20151204 11:12:14.003', 15369.54, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (380, 1, N'Nome 380', 1, N'63874112223', N'123', '20151204 11:12:14.003', 16339.54, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (381, 1, N'Nome 381', 1, N'76881935831', N'123', '20151204 11:12:14.007', 14453.78, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (382, 1, N'Nome 382', 1, N'81115887110', N'123', '20151204 11:12:14.007', 10783.6, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (383, 1, N'Nome 383', 1, N'21692600141', N'123', '20151204 11:12:14.007', 16045.57, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (384, 1, N'Nome 384', 1, N'23626701502', N'123', '20151204 11:12:14.007', 16084.67, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (385, 1, N'Nome 385', 1, N'83451987372', N'123', '20151204 11:12:14.007', 15284.57, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (386, 1, N'Nome 386', 1, N'29862456079', N'123', '20151204 11:12:14.007', 18989.52, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (387, 1, N'Nome 387', 1, N'24886970763', N'123', '20151204 11:12:14.010', 12168.4, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (388, 1, N'Nome 388', 1, N'98476727492', N'123', '20151204 11:12:14.010', 14890.94, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (389, 1, N'Nome 389', 1, N'95996033022', N'123', '20151204 11:12:14.010', 12912.62, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (390, 1, N'Nome 390', 1, N'72017015023', N'123', '20151204 11:12:14.010', 15885.11, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (391, 1, N'Nome 391', 1, N'44512677647', N'123', '20151204 11:12:14.010', 11641.61, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (392, 1, N'Nome 392', 1, N'52471583511', N'123', '20151204 11:12:14.010', 16630.77, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (393, 1, N'Nome 393', 1, N'42253838417', N'123', '20151204 11:12:14.010', 12170.2, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (394, 1, N'Nome 394', 1, N'69542709549', N'123', '20151204 11:12:14.013', 12569.27, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (395, 1, N'Nome 395', 1, N'88879285760', N'123', '20151204 11:12:14.013', 19169.91, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (396, 1, N'Nome 396', 1, N'94057902800', N'123', '20151204 11:12:14.013', 14262.74, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (397, 1, N'Nome 397', 1, N'49793098265', N'123', '20151204 11:12:14.013', 14991.63, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (398, 1, N'Nome 398', 1, N'68123418238', N'123', '20151204 11:12:14.013', 17504.08, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (399, 1, N'Nome 399', 1, N'13155611784', N'123', '20151204 11:12:14.013', 15439.3, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (400, 1, N'Nome 400', 1, N'27717614378', N'123', '20151204 11:12:14.013', 14961.27, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (401, 1, N'Nome 401', 1, N'27023529239', N'123', '20151204 11:12:14.013', 19564.85, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (402, 1, N'Nome 402', 1, N'58049987831', N'123', '20151204 11:12:14.017', 14121.31, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (403, 1, N'Nome 403', 1, N'70057067183', N'123', '20151204 11:12:14.017', 12259.82, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (404, 1, N'Nome 404', 1, N'92764848501', N'123', '20151204 11:12:14.017', 17330.86, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (405, 1, N'Nome 405', 1, N'45196794777', N'123', '20151204 11:12:14.017', 13512.94, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (406, 1, N'Nome 406', 1, N'63162940295', N'123', '20151204 11:12:14.017', 15899.79, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (407, 1, N'Nome 407', 1, N'20790698519', N'123', '20151204 11:12:14.017', 11876.5, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (408, 1, N'Nome 408', 1, N'84223005180', N'123', '20151204 11:12:14.020', 12719.13, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (409, 1, N'Nome 409', 1, N'40609688660', N'123', '20151204 11:12:14.020', 12526.23, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (410, 1, N'Nome 410', 1, N'57409609418', N'123', '20151204 11:12:14.020', 19803.99, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (411, 1, N'Nome 411', 1, N'95338386149', N'123', '20151204 11:12:14.020', 18785.01, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (412, 1, N'Nome 412', 1, N'76662851089', N'123', '20151204 11:12:14.020', 16279.71, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (413, 1, N'Nome 413', 1, N'15665677065', N'123', '20151204 11:12:14.020', 15496.1, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (414, 1, N'Nome 414', 1, N'32008260809', N'123', '20151204 11:12:14.020', 13251.19, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (415, 1, N'Nome 415', 1, N'66603071760', N'123', '20151204 11:12:14.020', 10009.62, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (416, 1, N'Nome 416', 1, N'81613670926', N'123', '20151204 11:12:14.023', 11541.11, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (417, 1, N'Nome 417', 1, N'24982183142', N'123', '20151204 11:12:14.023', 11359.18, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (418, 1, N'Nome 418', 1, N'96520170991', N'123', '20151204 11:12:14.023', 18756.3, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (419, 1, N'Nome 419', 1, N'67528271887', N'123', '20151204 11:12:14.023', 17298.92, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (420, 1, N'Nome 420', 1, N'98098177059', N'123', '20151204 11:12:14.023', 15929.5, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (421, 1, N'Nome 421', 1, N'33416364163', N'123', '20151204 11:12:14.023', 11448.23, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (422, 1, N'Nome 422', 1, N'95960659320', N'123', '20151204 11:12:14.027', 16919.61, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (423, 1, N'Nome 423', 1, N'62980354086', N'123', '20151204 11:12:14.027', 18734.99, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (424, 1, N'Nome 424', 1, N'35050093248', N'123', '20151204 11:12:14.027', 17708.83, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (425, 1, N'Nome 425', 1, N'33408298619', N'123', '20151204 11:12:14.027', 14406.21, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (426, 1, N'Nome 426', 1, N'68790402385', N'123', '20151204 11:12:14.027', 12361.16, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (427, 1, N'Nome 427', 1, N'40204196470', N'123', '20151204 11:12:14.027', 15339.8, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (428, 1, N'Nome 428', 1, N'85393716390', N'123', '20151204 11:12:14.030', 15145.83, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (429, 1, N'Nome 429', 1, N'47167257953', N'123', '20151204 11:12:14.030', 10279.86, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (430, 1, N'Nome 430', 1, N'61654046478', N'123', '20151204 11:12:14.030', 10187.16, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (431, 1, N'Nome 431', 1, N'96123073910', N'123', '20151204 11:12:14.030', 15699.31, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (432, 1, N'Nome 432', 1, N'31715657544', N'123', '20151204 11:12:14.030', 18424.37, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (433, 1, N'Nome 433', 1, N'85009591224', N'123', '20151204 11:12:14.030', 18814.8, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (434, 1, N'Nome 434', 1, N'86347513625', N'123', '20151204 11:12:14.030', 13315.44, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (435, 1, N'Nome 435', 1, N'24019274840', N'123', '20151204 11:12:14.030', 11127.74, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (436, 1, N'Nome 436', 1, N'73557429226', N'123', '20151204 11:12:14.033', 15186.4, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (437, 1, N'Nome 437', 1, N'59574917534', N'123', '20151204 11:12:14.033', 10654.32, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (438, 1, N'Nome 438', 1, N'51380463710', N'123', '20151204 11:12:14.033', 13225.3, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (439, 1, N'Nome 439', 1, N'61910029228', N'123', '20151204 11:12:14.033', 16253.75, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (440, 1, N'Nome 440', 1, N'73774956466', N'123', '20151204 11:12:14.033', 11485.3, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (441, 1, N'Nome 441', 1, N'84695489598', N'123', '20151204 11:12:14.033', 11600.54, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (442, 1, N'Nome 442', 1, N'11934464323', N'123', '20151204 11:12:14.037', 19229.36, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (443, 1, N'Nome 443', 1, N'32652425980', N'123', '20151204 11:12:14.037', 16714.5, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (444, 1, N'Nome 444', 1, N'41621973410', N'123', '20151204 11:12:14.073', 17958.93, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (445, 1, N'Nome 445', 1, N'70122470534', N'123', '20151204 11:12:14.073', 16327.08, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (446, 1, N'Nome 446', 1, N'17611461641', N'123', '20151204 11:12:14.073', 16344.93, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (447, 1, N'Nome 447', 1, N'43790501998', N'123', '20151204 11:12:14.073', 16454.65, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (448, 1, N'Nome 448', 1, N'63955318960', N'123', '20151204 11:12:14.077', 10167.22, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (449, 1, N'Nome 449', 1, N'17883749201', N'123', '20151204 11:12:14.077', 15801.64, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (450, 1, N'Nome 450', 1, N'70774590235', N'123', '20151204 11:12:14.077', 15944.97, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (451, 1, N'Nome 451', 1, N'40242511910', N'123', '20151204 11:12:14.077', 18254.88, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (452, 1, N'Nome 452', 1, N'42177825025', N'123', '20151204 11:12:14.077', 12753.6, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (453, 1, N'Nome 453', 1, N'88572024718', N'123', '20151204 11:12:14.077', 16317.49, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (454, 1, N'Nome 454', 1, N'36796266292', N'123', '20151204 11:12:14.077', 19033.47, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (455, 1, N'Nome 455', 1, N'94738340048', N'123', '20151204 11:12:14.077', 16990.82, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (456, 1, N'Nome 456', 1, N'60529818573', N'123', '20151204 11:12:14.077', 18796.32, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (457, 1, N'Nome 457', 1, N'80916227728', N'123', '20151204 11:12:14.080', 12042.93, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (458, 1, N'Nome 458', 1, N'64906034180', N'123', '20151204 11:12:14.080', 12464.2, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (459, 1, N'Nome 459', 1, N'39286752398', N'123', '20151204 11:12:14.080', 19417.04, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (460, 1, N'Nome 460', 1, N'71403016840', N'123', '20151204 11:12:14.080', 19333.54, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (461, 1, N'Nome 461', 1, N'89517387606', N'123', '20151204 11:12:14.080', 17000.87, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (462, 1, N'Nome 462', 1, N'62243056738', N'123', '20151204 11:12:14.080', 14097.29, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (463, 1, N'Nome 463', 1, N'59420152538', N'123', '20151204 11:12:14.080', 17769.3, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (464, 1, N'Nome 464', 1, N'57619151870', N'123', '20151204 11:12:14.080', 14890.03, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (465, 1, N'Nome 465', 1, N'82889568774', N'123', '20151204 11:12:14.080', 10100.93, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (466, 1, N'Nome 466', 1, N'21007781249', N'123', '20151204 11:12:14.080', 17949.33, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (467, 1, N'Nome 467', 1, N'48609037684', N'123', '20151204 11:12:14.080', 12798.3, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (468, 1, N'Nome 468', 1, N'66060149800', N'123', '20151204 11:12:14.083', 19033.64, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (469, 1, N'Nome 469', 1, N'24325267171', N'123', '20151204 11:12:14.083', 16533.26, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (470, 1, N'Nome 470', 1, N'57450147573', N'123', '20151204 11:12:14.083', 18583.34, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (471, 1, N'Nome 471', 1, N'31598563926', N'123', '20151204 11:12:14.083', 13966.31, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (472, 1, N'Nome 472', 1, N'95631207592', N'123', '20151204 11:12:14.083', 10047.35, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (473, 1, N'Nome 473', 1, N'99151987828', N'123', '20151204 11:12:14.083', 17453.89, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (474, 1, N'Nome 474', 1, N'25260994762', N'123', '20151204 11:12:14.087', 15012.74, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (475, 1, N'Nome 475', 1, N'52009203488', N'123', '20151204 11:12:14.087', 15358.97, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (476, 1, N'Nome 476', 1, N'70513510335', N'123', '20151204 11:12:14.087', 14639.68, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (477, 1, N'Nome 477', 1, N'68750127485', N'123', '20151204 11:12:14.087', 11891.59, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (478, 1, N'Nome 478', 1, N'67112780935', N'123', '20151204 11:12:14.087', 16652.06, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (479, 1, N'Nome 479', 1, N'33719387355', N'123', '20151204 11:12:14.087', 19786.41, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (480, 1, N'Nome 480', 1, N'44214557392', N'123', '20151204 11:12:14.087', 11824.19, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (481, 1, N'Nome 481', 1, N'64127787612', N'123', '20151204 11:12:14.087', 17853.73, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (482, 1, N'Nome 482', 1, N'49606867603', N'123', '20151204 11:12:14.090', 16061.67, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (483, 1, N'Nome 483', 1, N'21551674226', N'123', '20151204 11:12:14.090', 14270.67, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (484, 1, N'Nome 484', 1, N'70849907328', N'123', '20151204 11:12:14.090', 19079.58, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (485, 1, N'Nome 485', 1, N'37261444256', N'123', '20151204 11:12:14.090', 14744.07, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (486, 1, N'Nome 486', 1, N'61814013470', N'123', '20151204 11:12:14.090', 11485.71, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (487, 1, N'Nome 487', 1, N'99651731230', N'123', '20151204 11:12:14.090', 16169.79, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (488, 1, N'Nome 488', 1, N'39443987096', N'123', '20151204 11:12:14.090', 13766.99, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (489, 1, N'Nome 489', 1, N'18866506554', N'123', '20151204 11:12:14.090', 13846.74, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (490, 1, N'Nome 490', 1, N'45327205853', N'123', '20151204 11:12:14.090', 14045.69, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (491, 1, N'Nome 491', 1, N'21822700734', N'123', '20151204 11:12:14.090', 12284.65, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (492, 1, N'Nome 492', 1, N'32922744517', N'123', '20151204 11:12:14.090', 15999.67, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (493, 1, N'Nome 493', 1, N'23098190745', N'123', '20151204 11:12:14.093', 14139.89, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (494, 1, N'Nome 494', 1, N'80795413746', N'123', '20151204 11:12:14.093', 14611.81, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (495, 1, N'Nome 495', 1, N'17104069969', N'123', '20151204 11:12:14.093', 10013.04, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (496, 1, N'Nome 496', 1, N'13332689904', N'123', '20151204 11:12:14.093', 10837.71, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (497, 1, N'Nome 497', 1, N'47015511767', N'123', '20151204 11:12:14.093', 19731.84, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (498, 1, N'Nome 498', 1, N'16073536884', N'123', '20151204 11:12:14.093', 13566.87, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (499, 1, N'Nome 499', 1, N'36914910458', N'123', '20151204 11:12:14.097', 18285.2, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

INSERT INTO dbo.exemplo (exe_id, exe_ativo, exe_nome, exe2_id, exe_cpf, exe_senha, exe_data, exe_valor, exe_telefone, exe_cep, exe_checkbox, exe_checkbox_char, exe_radio_button, grupo_id)
VALUES 
  (500, 1, N'Nome 500', 1, N'21067839056', N'123', '20151204 11:12:14.097', 16288.91, N'11912345678', N'11222500', 0, N'A', N'A', 1)
GO

SET IDENTITY_INSERT dbo.exemplo OFF
GO

--
-- Data for table dbo.exemplo2  (LIMIT 0,500)
--

SET IDENTITY_INSERT dbo.exemplo2 ON
GO

INSERT INTO dbo.exemplo2 (exe2_id, exe2_categoria, exe2_descricao)
VALUES 
  (1, N'Categoria A', N'Aaaaa aaaa')
GO

INSERT INTO dbo.exemplo2 (exe2_id, exe2_categoria, exe2_descricao)
VALUES 
  (2, N'Categoria B', N'Bbbbb bbbb')
GO

INSERT INTO dbo.exemplo2 (exe2_id, exe2_categoria, exe2_descricao)
VALUES 
  (3, N'Categoria C', N'Ccccc cccc')
GO

SET IDENTITY_INSERT dbo.exemplo2 OFF
GO

--
-- Data for table dbo.grupo  (LIMIT 0,500)
--

SET IDENTITY_INSERT dbo.grupo ON
GO

INSERT INTO dbo.grupo (grupo_id, grupo_nome)
VALUES 
  (1, N'Phoenix Team')
GO

SET IDENTITY_INSERT dbo.grupo OFF
GO

--
-- Data for table dbo.menu  (LIMIT 0,500)
--

SET IDENTITY_INSERT dbo.menu ON
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (1, 1, N'Phoenix', 1, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (2, 1, N'View - Exemplo', 1, 1, 1, 1, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (3, 1, N'Componentes', 2, 1, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (4, 1, N'Menus', 3, 1, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (5, 1, N'Configurações', 4, 1, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (6, 1, N'Painel', 2, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (7, 1, N'Perfil de usuário', 1, 6, 1, 2, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (8, 1, N'Usuários', 2, 6, 1, 3, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (9, 1, N'Configurações', 3, 6, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (10, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (11, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (12, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (13, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (14, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (15, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (16, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (17, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (18, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (19, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (20, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (21, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (22, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (23, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (24, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (25, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (26, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (27, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (28, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (29, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (30, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (31, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (32, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (33, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (34, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (35, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (36, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (37, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (38, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (39, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (40, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (41, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (42, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (43, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (44, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (45, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (46, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (47, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (48, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (49, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (50, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (51, 1, N'Phoenix', 1, 0, 1, 0, 1)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (52, 1, N'View - Exemplo', 1, 51, 1, 1, 1)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (53, 1, N'Componentes', 2, 51, 1, 0, 1)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (54, 1, N'Menus', 3, 51, 1, 0, 1)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (55, 1, N'Configurações', 4, 51, 1, 0, 1)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (56, 1, N'Painel', 2, 0, 1, 0, 1)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (57, 1, N'Perfil de usuário', 1, 56, 1, 2, 1)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (58, 1, N'Usuários', 2, 56, 1, 3, 1)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (59, 1, N'Configurações', 3, 56, 1, 0, 1)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (60, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (61, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (62, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (63, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (64, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (65, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (66, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (67, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (68, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (69, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (70, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (71, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (72, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (73, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (74, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (75, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (76, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (77, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (78, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (79, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (80, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (81, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (82, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (83, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (84, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (85, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (86, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (87, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (88, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (89, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (90, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (91, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (92, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (93, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (94, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (95, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (96, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (97, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (98, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (99, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (100, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (101, 1, N'CGNA', 1, 0, 1, 0, 2)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (102, 1, N'RPL', 1, 101, 1, 101, 2)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (103, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (104, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (105, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (106, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (107, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (108, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (109, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (110, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (111, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (112, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (113, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (114, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (115, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (116, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (117, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (118, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (119, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (120, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (121, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (122, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (123, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (124, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (125, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (126, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (127, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (128, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (129, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (130, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (131, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (132, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (133, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (134, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (135, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (136, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (137, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (138, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (139, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (140, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (141, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (142, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (143, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (144, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (145, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (146, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (147, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (148, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (149, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (150, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (151, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (152, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (153, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (154, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (155, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (156, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (157, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (158, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (159, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (160, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (161, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (162, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (163, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (164, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (165, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (166, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (167, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (168, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (169, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (170, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (171, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (172, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (173, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (174, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (175, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (176, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (177, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (178, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (179, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (180, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (181, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (182, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (183, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (184, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (185, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (186, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (187, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (188, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (189, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (190, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (191, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (192, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (193, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (194, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (195, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (196, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (197, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (198, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (199, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (200, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (201, 1, N'Exemplo', 1, 0, 1, 0, 3)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (202, 1, N'View - Exemplo', 2, 201, 1, 1, 3)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (203, 1, N'Componentes', 3, 201, 1, 0, 3)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (204, 1, N'Menus', 4, 201, 1, 0, 3)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (205, 1, N'Configurações', 2, 201, 1, 0, 3)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (206, 1, N'Painel', 1, 0, 1, 0, 3)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (207, 1, N'Perfil de usuário', 2, 206, 1, 2, 3)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (208, 1, N'Usuários', 3, 206, 1, 3, 3)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (209, 1, N'Configurações', 0, 206, 1, 0, 3)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (210, 1, N'Cadastros', 2, 0, 1, 0, 3)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (211, 1, N'Fornecedores', 1, 210, 1, 201, 3)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (212, 1, N'Materiais', 2, 210, 1, 0, 3)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (213, 1, N'Depósitos', 3, 210, 1, 0, 3)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (214, 1, N'Ambientes', 4, 210, 1, 0, 3)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (215, 1, N'Categorias (Materiais)', 5, 210, 1, 0, 3)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (216, 1, N'Linha de serviço', 6, 210, 1, 0, 3)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (217, 1, N'Unidades', 7, 210, 1, 0, 3)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (218, 1, N'Importação', 8, 210, 1, 0, 3)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (219, 1, N'Legendas', 9, 210, 1, 0, 3)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (220, 1, N'Cursos', 10, 210, 1, 0, 3)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (221, 1, N'Estoque', 3, 0, 1, 0, 3)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (222, 1, N'Histórico de entradas', 1, 221, 1, 0, 3)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (223, 1, N'Limite de gasto anual', 2, 221, 1, 0, 3)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (224, 1, N'Transferência de estoque', 3, 221, 1, 0, 3)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (225, 1, N'Solicitações', 4, 0, 1, 0, 3)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (226, 1, N'Solicitações', 1, 225, 1, 0, 3)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (227, 1, N'Pedidos (Compras)', 2, 225, 1, 0, 3)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (228, 1, N'Oderm de serviço', 5, 0, 1, 0, 3)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (229, 1, N'O.S.', 1, 228, 1, 0, 3)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (230, 1, N'Patrimônio', 2, 228, 1, 0, 3)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (231, 1, N'Compras', 6, 0, 1, 0, 3)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (232, 1, N'Disparar cotações', 1, 231, 1, 0, 3)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (233, 1, N'Relatórios', 7, 0, 1, 0, 3)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (234, 1, N'Linha de serviço', 1, 233, 1, 0, 3)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (235, 1, N'Solicitações', 2, 233, 1, 0, 3)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (236, 1, N'Fornecedores', 3, 233, 1, 0, 3)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (237, 1, N'Estoque', 4, 233, 1, 0, 3)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (238, 1, N'Material x Ambiente', 5, 233, 1, 0, 3)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (239, 1, N'Material x Solicitante', 6, 233, 1, 0, 3)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (240, 1, N'Material x Categoria', 7, 233, 1, 0, 3)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (241, 1, N'Log de disparos', 8, 233, 1, 0, 3)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (242, 1, N'Mov. estoque diário', 9, 233, 1, 0, 3)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (243, 1, N'Material não utilizado', 10, 233, 1, 0, 3)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (244, 1, N'O.S. X Patrimônio', 11, 233, 1, 0, 3)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (245, 1, N'O.S. X Local', 12, 233, 1, 0, 3)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (246, 1, N'Ordem de serviço (PDF)', 13, 233, 1, 0, 3)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (247, 1, N'O.S. x Local (PDF)', 14, 233, 1, 0, 3)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (248, 1, N'Interessados', 15, 233, 1, 0, 3)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (249, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (250, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (251, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (252, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (253, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (254, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (255, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (256, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (257, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (258, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (259, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (260, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (261, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (262, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (263, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (264, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (265, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (266, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (267, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (268, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (269, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (270, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (271, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (272, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (273, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (274, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (275, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (276, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (277, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (278, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (279, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (280, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (281, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (282, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (283, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (284, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (285, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (286, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (287, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (288, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (289, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (290, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (291, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (292, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (293, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (294, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (295, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (296, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (297, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (298, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (299, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (300, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (301, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (302, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (303, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (304, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (305, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (306, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (307, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (308, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (309, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (310, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (311, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (312, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (313, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (314, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (315, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (316, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (317, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (318, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (319, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (320, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (321, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (322, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (323, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (324, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (325, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (326, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (327, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (328, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (329, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (330, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (331, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (332, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (333, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (334, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (335, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (336, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (337, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (338, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (339, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (340, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (341, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (342, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (343, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (344, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (345, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (346, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (347, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (348, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (349, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (350, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (351, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (352, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (353, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (354, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (355, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (356, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (357, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (358, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (359, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (360, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (361, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (362, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (363, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (364, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (365, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (366, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (367, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (368, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (369, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (370, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (371, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (372, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (373, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (374, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (375, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (376, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (377, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (378, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (379, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (380, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (381, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (382, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (383, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (384, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (385, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (386, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (387, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (388, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (389, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (390, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (391, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (392, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (393, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (394, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (395, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (396, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (397, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (398, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (399, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (400, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (401, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (402, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (403, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (404, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (405, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (406, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (407, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (408, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (409, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (410, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (411, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (412, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (413, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (414, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (415, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (416, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (417, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (418, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (419, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (420, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (421, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (422, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (423, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (424, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (425, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (426, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (427, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (428, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (429, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (430, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (431, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (432, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (433, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (434, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (435, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (436, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (437, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (438, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (439, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (440, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (441, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (442, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (443, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (444, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (445, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (446, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (447, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (448, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (449, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (450, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (451, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (452, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (453, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (454, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (455, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (456, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (457, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (458, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (459, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (460, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (461, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (462, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (463, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (464, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (465, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (466, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (467, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (468, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (469, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (470, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (471, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (472, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (473, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (474, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (475, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (476, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (477, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (478, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (479, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (480, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (481, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (482, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (483, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (484, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (485, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (486, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (487, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (488, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (489, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (490, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (491, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (492, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (493, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (494, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (495, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (496, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (497, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (498, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (499, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (500, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

--
-- Data for table dbo.menu  (LIMIT 500,500)
--

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (501, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (502, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (503, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (504, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

INSERT INTO dbo.menu (men_id, men_ativo, men_nome, men_ordem, men_idPai, men_sistema, com_id, pro_id)
VALUES 
  (505, 0, N'Reservado', 0, 0, 1, 0, 0)
GO

SET IDENTITY_INSERT dbo.menu OFF
GO

--
-- Data for table dbo.perfil  (LIMIT 0,500)
--

SET IDENTITY_INSERT dbo.perfil ON
GO

INSERT INTO dbo.perfil (per_id, per_master, per_ativo, per_nome, per_developer, per_resetarSenha, grupo_id, pro_id)
VALUES 
  (1, 1, 1, N'Developer', 1, 1, 1, 0)
GO

INSERT INTO dbo.perfil (per_id, per_master, per_ativo, per_nome, per_developer, per_resetarSenha, grupo_id, pro_id)
VALUES 
  (2, 0, 1, N'Convidado', NULL, 0, 1, 0)
GO

SET IDENTITY_INSERT dbo.perfil OFF
GO

--
-- Data for table dbo.project  (LIMIT 0,500)
--

INSERT INTO dbo.project (pro_id, pro_name)
VALUES 
  (0, N'px-project')
GO

INSERT INTO dbo.project (pro_id, pro_name)
VALUES 
  (1, N'px-example')
GO

--
-- Data for table dbo.projeto  (LIMIT 0,500)
--

INSERT INTO dbo.projeto (pro_id, pro_versao, pro_ativo, pro_data_atualizacao, pro_nome, pro_manutencao, pro_mensagem)
VALUES 
  (0, N'1', 1, '20160320', N'px-project', 0, N'')
GO

INSERT INTO dbo.projeto (pro_id, pro_versao, pro_ativo, pro_data_atualizacao, pro_nome, pro_manutencao, pro_mensagem)
VALUES 
  (1, N'1', 1, '20160320', N'px-example', 0, N'')
GO

--
-- Data for table dbo.usuario  (LIMIT 0,500)
--

SET IDENTITY_INSERT dbo.usuario ON
GO

INSERT INTO dbo.usuario (usu_id, usu_ativo, per_id, usu_login, usu_senha, usu_nome, usu_email, usu_cpf, usu_ultimoAcesso, usu_senhaExpira, usu_senhaData, usu_mudarSenha, usu_tentativasLogin, usu_countTentativasLogin, usu_recuperarSenha, usu_recuperarSenhaData)
VALUES 
  (1, 1, 1, N'px-project', N'D9E6762DD1C8EAF6D61B3C6192FC408D4D6D5F1176D0C29169BC24E71C3F274AD27FCD5811B313D681F7E55EC02D73D499C95455B6B5BB503ACF574FBA8FFE85', N'User Phoenix Project', N'weslei.rfreitas@gmail.com', N'39145592845', '20160924 07:21:42.707', 365, '20151204', 0, 99, 0, 0, NULL)
GO

INSERT INTO dbo.usuario (usu_id, usu_ativo, per_id, usu_login, usu_senha, usu_nome, usu_email, usu_cpf, usu_ultimoAcesso, usu_senhaExpira, usu_senhaData, usu_mudarSenha, usu_tentativasLogin, usu_countTentativasLogin, usu_recuperarSenha, usu_recuperarSenhaData)
VALUES 
  (2, 1, 2, N'convidado', N'D9E6762DD1C8EAF6D61B3C6192FC408D4D6D5F1176D0C29169BC24E71C3F274AD27FCD5811B313D681F7E55EC02D73D499C95455B6B5BB503ACF574FBA8FFE85', N'Usuário convidado', N'convidado@pxproject.com.br', N'11111111111', '20160917 09:54:11.083', 365, '20160327', 0, 99, 0, 0, NULL)
GO

SET IDENTITY_INSERT dbo.usuario OFF
GO