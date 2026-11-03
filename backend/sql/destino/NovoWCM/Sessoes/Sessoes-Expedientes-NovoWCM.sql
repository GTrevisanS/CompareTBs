SELECT 
	wsd.{tipo_documento_importado},
	ws.ses_nome,
	CONCAT(wtd.tip_doc_descricao, ' ', wd.doc_codigo_individual_ano) AS 'DOCUMENTO-EXPEDIENTE-NOVOWCM'
FROM 
	wcm_sessoes_documentos wsd
	LEFT JOIN wcm_sessoes ws ON ws.ses_id = wsd.ses_doc_sessao_id_fk
	LEFT JOIN wcm_documentos wd ON wd.doc_id = wsd.ses_doc_documento_id_fk
	LEFT JOIN wcm_tipos_documentos wtd ON wtd.tip_doc_id = wd.doc_tipo_documento_id_fk
WHERE 
	wsd.ses_doc_tipo_pertencente = {id_tipo_documento_novowcm}
ORDER BY 
	wsd.{tipo_documento_importado} ASC