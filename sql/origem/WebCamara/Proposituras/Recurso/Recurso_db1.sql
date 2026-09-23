SELECT 
	wcm4.doc_id AS 'ID-Recurso-NovoWCM',    
	CONCAT(pr.processo_numero, '-', pr.processo_ano) 'NUMERO-PROTOCOLO-NOVOWCM',
	r.Codigo_Individial_Ano AS 'CODIGO-INDIVIDUAL-ANO',
	r.Ementa,
	l.Nome AS 'LEGISLATURA',
	r.Data,
	CASE
	 	WHEN r.Data_Inicio_Tramitacao IS NULL THEN pr.Data_Protocolo
		WHEN r.Data_Inicio_Tramitacao = 0 THEN pr.Data_Protocolo
		ELSE r.Data_Inicio_Tramitacao
	END AS 'Data_Inicio_Tramitacao',
	st.Descricao AS 'TRAMITACAO',
	r.INTERNET
FROM 
	recurso r
	LEFT JOIN situacao_tramitacao st ON st.Codigo = r.Codigo_SITUACAO_TRAMITACAO
	LEFT JOIN legislatura l ON l.Codigo = r.Codigo_LEGISLATURA
	LEFT JOIN protocolo pr ON pr.Num_Protocolo = r.Num_Protocolo_PROTOCOLO
	LEFT JOIN {bancowcm4}.wcm_documentos wcm4 ON wcm4.codigo_recurso_webcamara = r.Codigo
ORDER BY wcm4.doc_id DESC