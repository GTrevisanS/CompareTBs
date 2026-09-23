SELECT 
    -- Força a conversão do ID para um número inteiro
    CAST(`ID-Revogacao-NovoWCM` AS UNSIGNED) AS `ID-Revogacao-NovoWCM`,
    CONCAT(Data, ' 00:00:00') AS Data,
    `LEI-QUE-REVOGA`,
    ACAO,
    `LEI-REVOGADA`,
    Observacao
FROM (
    SELECT
        -- Cálculo do RANK() escondido aqui dentro
        @rank := IF(@prev_data = r.Data AND @prev_codigo = r.Codigo, @rank, @row_num) AS `ID-Revogacao-NovoWCM`,
        @row_num := @row_num + 1,
        @prev_data := r.Data,
        @prev_codigo := r.Codigo,
        
        -- Seus campos originais
        r.Data,
        CONCAT(tl1.Nome_Tipo_Lei, ' ', l1.Numero, ' ', l1.Ano) AS `LEI-QUE-REVOGA`,
        r.ACAO,
        CONCAT(tl2.Nome_Tipo_Lei, ' ', l2.Numero, ' ', l2.Ano) AS `LEI-REVOGADA`,
        r.Observacao,
        r.Codigo AS sub_codigo 
    FROM 
        revogacao r
        LEFT JOIN lei l1 ON l1.Codigo = r.Codigo_LEI
        LEFT JOIN lei l2 ON l2.Codigo = r.Codigo_LEI_Revogada
        LEFT JOIN tipo_lei tl1 ON tl1.Codigo = l1.Codigo_TIPO_lei
        LEFT JOIN tipo_lei tl2 ON tl2.Codigo = l2.Codigo_TIPO_lei,
        
        -- Inicialização das variáveis
        (SELECT @rank := 1, @row_num := 1, @prev_data := NULL, @prev_codigo := NULL) vars
    WHERE 
        {parametro_where_webcamara}
    ORDER BY 
        r.Data DESC, r.Codigo DESC 
) tabela_temporaria
ORDER BY 
    sub_codigo DESC;
