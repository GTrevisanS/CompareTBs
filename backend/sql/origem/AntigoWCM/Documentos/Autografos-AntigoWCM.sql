SELECT 
	a.aut_id 'ID-WCM-ANTIGO',
	CONCAT(a.aut_codigo_individual, '-', YEAR(a.aut_data_hora_autografo)) 'CODIGO-INDIVIDUAL-ANO',
	a.aut_data_hora_autografo 'DATA-REGISTRO',
	tp.tip_pro_descricao 'TIPO-DOCUMENTO-VINCULADO',
	CONCAT(wd.doc_codigo_individual, '-', YEAR(wd.doc_data_documento)) 'NUMERO-DOCUMENTO-VINCULADO',
	a.aut_ementa 'EMENTA',
	a.aut_observacao 'OBSERVACOES',
	a.aut_mostra_online 'INTERNET'
FROM 
	wcm_autografos a
	LEFT JOIN wcm_documentos wd ON wd.doc_id = a.aut_documentos_id_fk
	LEFT JOIN wcm_tipos_protocolos tp ON tp.tip_pro_id = wd.doc_tipos_protocolos_id_fk
ORDER BY
	a.aut_id DESC