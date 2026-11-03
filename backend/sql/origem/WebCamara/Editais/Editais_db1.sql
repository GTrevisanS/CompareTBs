SELECT
    wcm4.edi_id AS edi_id,
    e.codigo_individual_ano AS 'CODIGO-INDIVIDUAL-ANO',
    e.assunto AS 'ASSUNTO',
    te.Descricao AS 'TIPO-EDITAL',
    tl.descricao AS 'TIPO-LICITACAO',
    sl.Descricao AS 'SITUACAO-LICITACAO',
    e.numero_licitacao AS 'NUMERO-LICITACAO',
    e.PROVIDENCIA,
    e.Data AS 'DATA-REGISTRO',
    e.data_abertura AS 'DATA-ABERTURA',
    e.Data_Realizacao AS 'DATA-REALIZACAO',
    e.data_julgamento AS 'DATA-JULGAMENTO',
    e.data_adjudicacao AS 'DATA-ADJUDICACAO',
    e.data_homologacao AS 'DATA-HOMOLOGACAO',
    e.INTERNET
FROM
    editais e
    LEFT JOIN tipo_editais te ON te.Codigo = e.Codigo_TIPO_EDITAIS
    LEFT JOIN tipo_licitacao tl ON tl.codigo = e.Codigo_Tipo_Licitacao
    LEFT JOIN situacao_licitacao sl ON sl.Codigo = e.Codigo_Situacao_Licitacao
    LEFT JOIN politico po ON po.Codigo = e.Codigo_presidente_POLITICO
    LEFT JOIN {bancowcm4}.wcm_editais wcm4 
        ON wcm4.codigo_editais_webcamara = e.Codigo

UNION ALL

SELECT
    wcm4.edi_id AS edi_id,
    ec.Codigo_Individual_Ano AS 'CODIGO-INDIVIDUAL-ANO',
    ec.Descricao AS 'ASSUNTO',
    'convocacao' AS 'TIPO-EDITAL',
    NULL AS 'TIPO-LICITACAO',
    NULL AS 'SITUACAO-LICITACAO',
    NULL AS 'NUMERO-LICITACAO',
    NULL AS 'PROVIDENCIA',
    CASE 
	 	WHEN ec.Data IS NULL OR ec.Data = 0 
		 	THEN CONCAT(ec.Ano, '-01-01')
	 END AS 'DATA-REGISTRO',
    NULL AS 'DATA-ABERTURA',
    NULL AS 'DATA-REALIZACAO',
    NULL AS 'DATA-JULGAMENTO',
    NULL AS 'DATA-ADJUDICACAO',
    NULL AS 'DATA-HOMOLOGACAO',
    ec.INTERNET AS 'INTERNET'
FROM 
    edital_convocacao ec
    LEFT JOIN {bancowcm4}.wcm_editais wcm4 
        ON wcm4.codigo_edital_convocacao_webcamara = ec.Codigo
WHERE wcm4.edi_id IS NOT NULL

ORDER BY edi_id DESC