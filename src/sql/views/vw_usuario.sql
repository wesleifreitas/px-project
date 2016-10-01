-- Configurar View
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- Apagar view
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_usuario]'))
DROP VIEW [dbo].[vw_usuario]
GO

-- Criar View
CREATE VIEW [dbo].[vw_usuario]
--WITH ENCRYPTION
AS
	SELECT

	usuario.usu_id,
	usuario.usu_ativo,
    usu_ativo_label = CASE usuario.usu_ativo
    	WHEN 1 THEN 'Ativo'
    	WHEN 2 THEN 'Bloqueado'
		ELSE 'Inativo'
	END,
	usuario.per_id,
	usuario.usu_login,
	usuario.usu_senha,
	usuario.usu_nome,
	usuario.usu_email,
	usuario.usu_cpf,
	usuario.usu_ultimoAcesso,
	usuario.usu_senhaExpira,
	usuario.usu_senhaData,
	usuario.usu_mudarSenha,	
	usuario.usu_tentativasLogin,
	usuario.usu_countTentativasLogin,	
	usuario.usu_recuperarSenha,
	usuario.usu_recuperarSenhaData,	
	
	perfil.per_master,
	perfil.per_ativo,
	perfil.per_nome,
	perfil.per_developer,
	perfil.per_resetarSenha,
	perfil.grupo_id,

	--grupo.grupo_id, 
    grupo.grupo_nome

	FROM usuario AS usuario

	INNER JOIN perfil AS perfil
	ON usuario.per_id = perfil.per_id

	INNER JOIN grupo AS grupo
	ON perfil.grupo_id = grupo.grupo_id

GO