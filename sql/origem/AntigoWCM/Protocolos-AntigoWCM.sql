SELECT 
	p.pro_id 'ID-WCM-ANTIGO',
	tp.tip_pro_descricao 'TIPO-DOCUMENTO',
	CONCAT(wd.doc_codigo_individual, '-', 	YEAR(wd.doc_data_documento)) 'CODIGO-INDIVIDUAL-ANO',
	p.pro_numero 'NUMERO-PROTOCOLO-NOVOWCM',
	p.pro_data_hora 'DATA-HORA-PROTOCOLO',
	p.pro_observacao 'OBSERVACOES',
	u.usu_nome 'PROTOCOLANTE'
FROM 
	wcm_protocolos p
	LEFT JOIN wcm_tipos_protocolos tp ON tp.tip_pro_id = p.pro_tipos_protocolos_id_fk
	LEFT JOIN wcm_usuarios u ON u.usu_id = p.pro_protocolante_id_fk
	LEFT JOIN wcm_documentos wd ON wd.doc_id = p.pro_documentos_id_fk
	
ORDER BY 
	p.pro_id DESC 