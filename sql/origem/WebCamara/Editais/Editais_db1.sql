SELECT
	wcm4.edi_id AS edi_id,
	CONCAT(pr.processo_numero, '-', pr.processo_ano) 'NUMERO-PROTOCOLO-NOVOWCM',
	e.codigo_individual_ano AS 'CODIGO-INDIVIDUAL-ANO',
	e.assunto,
	te.Descricao AS "tipo edital",
	tl.descricao AS "tipo licitacao",
	sl.Descricao AS "situacao licitacao",
	e.numero_licitacao,
	CASE
		WHEN (e.Data IS NULL AND pr.Data_Protocolo IS NULL) 
			OR (e.Data = 0 AND pr.Data_Protocolo IS NULL)
			OR (e.Data IS NULL AND pr.Data_Protocolo = 0)
			OR (e.Data = 0 AND pr.Data_Protocolo = 0)
			THEN CONCAT(e.Ano, '-01-01')
	 	WHEN e.Data IS NULL THEN pr.Data_Protocolo
		WHEN e.Data = 0 THEN pr.Data_Protocolo
		ELSE e.Data
	END AS 'DATA-REGISTRO',
	e.INTERNET
FROM
	editais e
	LEFT JOIN tipo_editais te ON te.Codigo = e.Codigo_TIPO_EDITAIS
	LEFT JOIN tipo_licitacao tl ON tl.codigo = e.Codigo_Tipo_Licitacao
	LEFT JOIN situacao_licitacao sl ON sl.Codigo = e.Codigo_Situacao_Licitacao
	LEFT JOIN politico po ON po.Codigo = e.Codigo_presidente_POLITICO
	LEFT JOIN protocolo pr ON pr.Num_Protocolo = e.Num_Protocolo_PROTOCOLO
	LEFT JOIN {bancowcm4}.wcm_editais wcm4 ON wcm4.codigo_editais_webcamara = e.Codigo

UNION ALL

SELECT
	wcm4.edi_id AS edi_id,
	CONCAT(pr.processo_numero, '-', pr.processo_ano) 'NUMERO-PROTOCOLO-NOVOWCM',
	ec.Codigo_Individual_Ano AS 'CODIGO-INDIVIDUAL-ANO',
	ec.Descricao,
	'convocacao',
	NULL,
	NULL,
	NULL,
	CASE
		WHEN (ec.Data IS NULL AND pr.Data_Protocolo IS NULL) 
			OR (ec.Data = 0 AND pr.Data_Protocolo IS NULL)
			OR (ec.Data IS NULL AND pr.Data_Protocolo = 0)
			OR (ec.Data = 0 AND pr.Data_Protocolo = 0)
			THEN CONCAT(ec.Ano, '-01-01')
	 	WHEN ec.Data IS NULL THEN pr.Data_Protocolo
		WHEN ec.Data = 0 THEN pr.Data_Protocolo
		ELSE ec.Data
	END AS 'DATA-REGISTRO',
	ec.INTERNET
FROM 
	edital_convocacao ec
	LEFT JOIN protocolo pr ON pr.Num_Protocolo = ec.Num_Protocolo_PROTOCOLO
	LEFT JOIN {bancowcm4}.wcm_editais wcm4 ON wcm4.codigo_edital_convocacao_webcamara = ec.Codigo
WHERE edi_id IS NOT null

ORDER BY edi_id DESC