SELECT
	p.codigo_protocolo_importacao,
	CONCAT(p.pro_codigo_individual_ano, '   /   ', p.pro_data_hora) AS 'IDENTIFICADOR-PROTOCOLO-NOVOWCM',
	wtd.tip_doc_descricao,
	wd.doc_codigo_individual_ano AS 'CODIGO-TIPO-NOVOWCM',
	p.pro_codigo_individual,
	p.pro_ano,
	p.pro_data_hora,
	p.pro_motivo_anulacao,
	p.pro_motivo_reativacao,
	wus.usu_sis_login AS 'PROTOCOLANTE'
FROM
	wcm_protocolos p
	LEFT JOIN wcm_tipos_documentos wtd ON wtd.tip_doc_id = p.pro_tipo_documento_id_fk
	LEFT JOIN wcm_documentos wd ON wd.doc_id = p.pro_documento_id_fk
	LEFT JOIN wcm_usuarios_sistema wus ON wus.usu_sis_id = p.pro_usuario_protocolante_id_fk
WHERE p.codigo_protocolo_importacao	IS NOT null
ORDER BY p.codigo_protocolo_importacao DESC