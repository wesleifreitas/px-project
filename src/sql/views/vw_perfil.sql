-- Configurar View
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- Apagar view
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_perfil]'))
DROP VIEW [dbo].[vw_perfil]
GO

-- Criar View
CREATE VIEW [dbo].[vw_perfil]
--WITH ENCRYPTION
AS
    SELECT
    
    perfil.per_id,
    perfil.per_master,
    perfil.per_ativo,
    per_ativo_label = CASE per_ativo
        WHEN 1 THEN 'Ativo'
        ELSE 'Inativo'
    END,
    perfil.per_nome,
    perfil.per_developer,
    perfil.per_resetarSenha,
    perfil.grupo_id,

    --grupo.grupo_id,
    grupo.grupo_nome

    FROM perfil AS perfil

    INNER JOIN grupo AS grupo
    ON perfil.grupo_id = grupo.grupo_id

GO