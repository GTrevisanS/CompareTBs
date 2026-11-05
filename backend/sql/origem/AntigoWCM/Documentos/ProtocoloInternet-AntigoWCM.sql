SELECT 
	p.pro_int_id 'ID-WCM-ANTIGO',
	doc.doc_id,
	p.pro_int_data_hora 'DATA-REGISTRO',
	CASE
		WHEN p.pro_int_numero_gabinete_ano IS NULL THEN CONCAT(tp.tip_pro_descricao, ' ( ', p.pro_int_data_hora,' )')
		ELSE CONCAT(tp.tip_pro_descricao, ' ( ', p.pro_int_numero_gabinete_ano,' )')
	END AS 'IDENTIFICADOR-PROTOCOLO-INTERNET',
	p.pro_int_numero_gabinete_ano 'CODIGO-INDIVIDUAL-ANO',
	tp.tip_pro_descricao 'TIPO-PROTOCOLO',
	td.tip_doc_descricao 'SUBTIPO-PROTOCOLO',
	CASE
		WHEN ts.tip_sit_descricao LIKE '%AGUARDANDO LIBERAÇÃO%' THEN 'AGUARDANDO LIBERAÇÃO'
		WHEN ts.tip_sit_descricao LIKE '%TRAMITACAO%' THEN 'DOCUMENTO LIBERADO'
		WHEN ts.tip_sit_descricao LIKE '%DEVOLVIDO%' THEN 'DEVOLVIDO'
		WHEN ts.tip_sit_descricao LIKE '%CANCELADO%' THEN 'CANCELADO PELO RESPONSÁVEL'
		ELSE 'NAO IDENTIFICADO'
	END AS 'SITUACAO',
	u1.usu_nome 'USUARIO-CRIACAO',
	u2.usu_nome 'USUARIO-REVISAO',
	p.pro_int_ementa 'EMENTA',
	p.pro_int_ementa_revisada 'EMENTA-REVISADA',
	p.pro_int_revisado 'REVISAO',
	p.pro_int_parlamentares_id_fk,
	se.ses_nome 'SESSAO-VINCULADA',
	p.pro_int_motivo_anulacao 'MOTIVO-ANULACAO',
	p.pro_int_protocolo_sigiloso_usuario_id_fk
FROM 
	wgb_protocolos_internet p
	LEFT JOIN wcm_tipos_protocolos tp ON tp.tip_pro_id = p.pro_int_tipos_protocolos_id_fk
	LEFT JOIN wcm_tipos_documentos td ON td.tip_doc_id = p.pro_int_tipos_documentos_id_fk
	LEFT JOIN wgb_tipos_situacoes ts ON ts.tip_sit_id = p.pro_int_tipos_situacoes_id_fk
	LEFT JOIN wcm_usuarios u1 ON u1.usu_id = p.pro_int_usuarios_id_fk
	LEFT JOIN wcm_usuarios u2 ON u2.usu_id = p.pro_int_usuario_revisado
	LEFT JOIN wcm_sessoes se ON se.ses_id = p.pro_int_sessoes_id_fk
	LEFT JOIN wcm_protocolos pr ON pr.pro_id = p.pro_int_protocolos_id_fk
	LEFT JOIN wcm_documentos doc ON doc.doc_id = pr.pro_documentos_id_fk
WHERE
	doc.doc_id IS NOT NULL -- Lista somente os que tem documentos vinculados.
ORDER BY
	p.pro_int_id DESC