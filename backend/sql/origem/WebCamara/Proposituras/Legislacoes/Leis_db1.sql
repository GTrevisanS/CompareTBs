SELECT
    wcm4.leg_id AS 'ID-Legislacao-NovoWCM',
    wcm4.leg_codigo_individual,
    tl.Nome_Tipo_Lei,
    lei.Numero,
    lei.EMENTA,
    lei.observacao AS 'OBSERVACOES',
    CONCAT_WS(', ',
		IF(lei.situacao_lei_alterada = 9, 'Alterada', NULL),
		IF(lei.Situacao_Lei_Declarada_Ilegal = 7, 'Declarada Ilegal', NULL),
		IF(lei.Situacao_Lei_Declarada_Parcialmente_Ilegal = 8, 'Declarada Parcialmente Ilegal', NULL),
        IF(lei.Situacao_Lei_Ativa = 1, 'Em Vigor', NULL),
		IF(lei.Situacao_Lei_Inconstitucional = 4, 'Inconstitucional', NULL),
		IF(lei.Situacao_Lei_Parcialmente_Inconstitucional = 6, 'Parcialmente Inconstitucional', NULL),
		IF(lei.Situacao_Lei_Revogada_Parcialmente = 2, 'Revogada Parcialmente', NULL),
		IF(lei.Situacao_Lei_Revogada_Totalmente = 3, 'Revogada Totalmente', NULL),
		IF(lei.Situacao_Lei_Suspensa_Lei_Complementar = 10, 'suspensa por lei complementar', NULL),
		IF(lei.Situacao_Lei_Suspensa_por_Liminar = 5, 'Suspensa por Liminar', NULL)
	) AS 'SITUACAO-LEI',
    le.Nome AS 'LEGISLATURA',
    GROUP_CONCAT(DISTINCT c.Nome ORDER BY c.Nome DESC SEPARATOR ', ') AS 'CATEGORIA',
    tp.Nome AS 'TIPO-PROJETO',
    lei.Codigo_Projeto,
    -- st.Descricao AS 'SITUACAO-TRAMITACAO',
    lei.Responsavel,
    lei.Data AS 'DATA-REGISTRO',
    tpub.`Data` AS 'DATA-PUBLICACAO',
    tpub.data_final AS 'DATA-FINAL-PUBLICACAO',
    tpub.Descricao AS 'LOCAL-PUBLICACAO',
    tpub.edicao AS 'EDICAO',
    tpub.pagina AS 'PAGINA',
	lei.INTERNET
FROM
    lei
    LEFT JOIN tipo_lei tl ON tl.Codigo = lei.Codigo_TIPO_lei
    LEFT JOIN tipo_projeto tp ON tp.Codigo = lei.Codigo_Tipo_Projeto
    LEFT JOIN legislatura le ON le.Codigo = lei.Codigo_LEGISLATURA
    LEFT JOIN situacao_tramitacao st ON st.Codigo = lei.Situacao_LEI
    LEFT JOIN categoria_lei catl ON catl.Codigo_lei = lei.Codigo
    LEFT JOIN categoria c ON c.Codigo = catl.Codigo_CATEGORIA
    LEFT JOIN tipo_publicacao tpub ON tpub.codigo_lei = lei.Codigo
	LEFT JOIN {bancowcm4}.wcm_legislacoes wcm4 ON wcm4.codigo_leis_webcamara = lei.Codigo
WHERE
    lei.Codigo_TIPO_lei = {id_tipo_documento_webcamara}
GROUP BY
	wcm4.codigo_leis_webcamara
ORDER BY
    wcm4.codigo_leis_webcamara DESC