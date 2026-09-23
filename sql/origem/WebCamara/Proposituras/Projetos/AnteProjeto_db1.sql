SELECT 
	wcm4.doc_id AS 'ID-Anteprojeto-NovoWCM',
	a.Codigo_Individual_Ano AS 'CODIGO-INDIVIDUAL-ANO',
	l.Nome AS 'LEGISLATURA',
	a.Situacao_Final,
	a.Ementa,
	a.observacao,
	a.justificativa,
	a.Regime_Tramitacao,
	a.INTERNET
FROM 
	anteprojeto a
	LEFT JOIN {bancowcm4}.wcm_documentos wcm4 ON wcm4.codigo_anteprojeto_webcamara = a.Codigo
	LEFT JOIN legislatura l ON l.Codigo = a.Codigo_LEGISLATURA
ORDER BY wcm4.doc_id DESC