-- Configura View
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- Apaga view
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_exemplo]'))
DROP VIEW [dbo].[vw_exemplo]
GO

-- Cria View
CREATE VIEW [dbo].[vw_exemplo]
WITH ENCRYPTION
AS
    SELECT

    exemplo.exe_id,
    exemplo.exe_ativo,
    exe_ativo_label = CASE exe_ativo
        WHEN 1 THEN 'Ativo'
        ELSE 'Inativo'
    END,
    exemplo.exe_nome,    
    exemplo.exe2_id,
    exemplo.exe_cpf,
    exemplo.exe_senha,
    exemplo.exe_data,
    exemplo.exe_valor,
    exemplo.exe_checkbox,
    exemplo.exe_checkbox_char,
    exemplo.exe_radio_button,    
    exemplo.exe_telefone,
    exemplo.exe_cep,
    exemplo.grupo_id,

    --ex2.exe2_id,
    ex2.exe2_categoria,
    ex2.exe2_descricao,
    
    grupo.grupo_nome
    
    FROM exemplo AS exemplo

    LEFT OUTER JOIN exemplo2 AS ex2
    ON exemplo.exe2_id = ex2.exe2_id

    LEFT OUTER JOIN grupo AS grupo
    ON exemplo.grupo_id = grupo.grupo_id
    
GO