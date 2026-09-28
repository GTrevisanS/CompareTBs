SELECT
    wcm4.leg_id AS 'ID-Legislacao-NovoWCM',
    wcm4.leg_codigo_individual,
    tl.Nome_Tipo_Lei,
    lei.Numero,
    lei.ementa,
    lei.observacao,
    lei.Situacao_Tramitacao,
    CONCAT_WS(', ',
        IF(lei.Situacao_Lei_Ativa = 1, 'Em Vigor', NULL),
        IF(lei.Situacao_Lei_Revogada_Parcialmente = 2, 'Revogada Parcialmente', NULL),
        IF(lei.Situacao_Lei_Revogada_Totalmente = 3, 'Revogada Totalmente', NULL),
        IF(lei.Situacao_Lei_Inconstitucional = 4, 'Inconstitucional', NULL),
        IF(lei.Situacao_Lei_Suspensa_por_Liminar = 5, 'Suspensa por Liminar', NULL),
        IF(lei.Situacao_Lei_Parcialmente_Inconstitucional = 6, 'Parcialmente Inconstitucional', NULL),
        IF(lei.Situacao_Lei_Declarada_Ilegal = 7, 'Declarada Ilegal', NULL),
        IF(lei.Situacao_Lei_Declarada_Parcialmente_Ilegal = 8, 'Declarada Parcialmente Ilegal', NULL),
        IF(lei.situacao_lei_alterada = 9, 'Alterada', NULL),
        IF(lei.Situacao_Lei_Suspensa_Lei_Complementar = 10, 'Suspensa Lei Complementar', NULL)
        -- IF(lei.Situacao_Lei_Parcialmente_Vetada = 11, 'Parcialmente Vetada', NULL)
    ) AS 'SITUACAO-LEI',
    le.Nome AS 'LEGISLATURA',
    tp.Nome AS 'TIPO-PROJETO',
    lei.Codigo_Projeto,
    st.Descricao AS 'TRAMITACAO',
    lei.Responsavel,
    lei.Data AS 'DATA-REGISTRO',
	lei.INTERNET
FROM
    lei
    LEFT JOIN tipo_lei tl ON tl.Codigo = lei.Codigo_TIPO_lei
    LEFT JOIN tipo_projeto tp ON tp.Codigo = lei.Codigo_Tipo_Projeto
    LEFT JOIN legislatura le ON le.Codigo = lei.Codigo_LEGISLATURA
    LEFT JOIN situacao_tramitacao st ON st.Codigo = lei.Situacao_LEI
    LEFT JOIN {bancowcm4}.wcm_legislacoes wcm4 ON wcm4.codigo_leis_webcamara = lei.Codigo
WHERE
    lei.Codigo_TIPO_lei = {id_tipo_documento_webcamara}
ORDER BY
    wcm4.codigo_leis_webcamara DESC