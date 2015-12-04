-- INSERT na tabela dbo.exemplo para testes.

DECLARE @I INT;
DECLARE @CPF BIGINT;
DECLARE @CPF_VARCHAR VARCHAR(11);
DECLARE @VALOR DECIMAL(19,2);

SET @I = 1;


WHILE (@I <= 500)
BEGIN

    SELECT @CPF = ROUND(((99999999999 - 11111111111 -1) * RAND() + 11111111111), 0);
    SELECT @CPF_VARCHAR = CONVERT(varchar(11), @CPF);
    SELECT @VALOR = ((10000 - 100 -1) * RAND() + 10000);

    PRINT(@I);
    PRINT(@CPF_VARCHAR);
    PRINT(@VALOR);


    INSERT INTO 
        dbo.exemplo
    (
        --exe_id,
		exe_ativo,
		exe_nome,
		exe2_id,
		exe_cpf,
		exe_senha,
		exe_data,
		exe_valor,
		exe_telefone,
		exe_cep,
		exe_checkbox,
		exe_checkbox_char,
		exe_radio_button,
		grupo_id
    ) 
    VALUES (
        --:exe_id,
		1,--:exe_ativo
        'Nome '+CAST(@I AS VARCHAR(100)),--:exe_exe_nomeaaaaa
		1,--:exe2_id
        @CPF_VARCHAR,--:exe_cpf
		123,--:exe_senha
        GETDATE(),--:exe_data
        @VALOR,--:exe_valor
		'11912345678',--:exe_telefone
		'11222500',--:exe_cep
        0,--:exe_checkbox
		'A',--:exe_checkbox_char
        'A',--:exe_radio_button
        1--:grupo_id
    );

    SET @I = @I+1;

END