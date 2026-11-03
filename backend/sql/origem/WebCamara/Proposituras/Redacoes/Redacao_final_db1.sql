SELECT 
	wcm4.doc_id AS 'ID-Redacao-Final-NovoWCM',
	r.Codigo_Individual_Ano AS 'CODIGO-INDIVIDUAL-ANO',
	r.EMENTA,
	r.`Data` AS 'DATA-REGISTRO', 
	st.Descricao AS 'SITUACAO-TRAMITACAO',
	l.Nome AS 'LEGISLATURA',
	r.INTERNET
FROM 
	redacao_final r
	LEFT JOIN legislatura l ON l.Codigo = r.Codigo_LEGISLATURA
	LEFT JOIN situacao_tramitacao st ON st.Codigo = r.Codigo_SITUACAO_TRAMITACAO
	LEFT JOIN {bancowcm4}.wcm_documentos wcm4 ON wcm4.codigo_redacao_final_webcamara = r.Codigo
ORDER BY
	wcm4.doc_id DESC