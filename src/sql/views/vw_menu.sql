-- Configurar View
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- Apagar view
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_menu]'))
DROP VIEW [dbo].[vw_menu]
GO

-- Criar View
CREATE VIEW [dbo].[vw_menu]
WITH ENCRYPTION
AS
	SELECT

	me.men_id
	,me.men_ativo
	,me.men_nome
	,me.men_ordem
	,me.men_idPai
	,me.men_sistema
	,me.com_id

	,co.com_view
    ,co.com_icon

	FROM menu AS me

	LEFT OUTER JOIN componente AS co
	ON me.com_id = co.com_id

GO