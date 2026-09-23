SELECT 
	wp.pra_id,
	CONCAT(wtd.tip_doc_descricao, ' ' ,wd.doc_codigo_individual_ano) 'DOCUMENTO',
	wp.pra_assunto,
	wp.pra_tipo_prazo_id_fk,
	wp.pra_dias_de_prazo,
	wp.pra_data_inicio,
	wp.pra_data_encerramento,
	wp.pra_data_concluido,
	wp.pra_conta_dias_uteis,
	wp.pra_concluido
FROM 
	wcm_prazos wp
	LEFT JOIN wcm_documentos wd ON wd.doc_id = wp.pra_documento_id_fk
	LEFT JOIN wcm_tipos_documentos wtd ON wtd.tip_doc_id = wd.doc_tipo_documento_id_fk
ORDER BY 
    wp.pra_id DESC