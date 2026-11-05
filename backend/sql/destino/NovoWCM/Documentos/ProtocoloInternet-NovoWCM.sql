SELECT 
	n.protocolo_internet_importado, -- ID IMPORTACAO
	n.pro_int_data_hora,            -- DATA REGISTRO
    
	CASE 
		WHEN n.pro_int_numero_gabinete_ano IS NULL THEN CONCAT(td.tip_doc_descricao, ' ( ', n.pro_int_data_hora,' )')
		ELSE CONCAT(td.tip_doc_descricao, ' ( ', n.pro_int_numero_gabinete_ano,' )')
	END AS 'IDENTIFICADOR-PROTOCOLO-INTERNET',

	td.tip_doc_descricao,           -- TIPO DOCUMENTO
	sit.sit_pro_int_descricao,      -- SITUACAO DO PROTOCOLO
	u1.usu_sis_login 'USUARIO-CRIACAO-NOVOWCM',
	u2.usu_sis_login 'USUARIO-LIBERACAO-NOVOWCM',
	n.pro_int_ementa_original,      -- EMENTA 
	n.pro_int_revisado,             -- FOI REVISADO?
	n.pro_int_politico_id_fk,     
	s.ses_nome,                     -- SEWSSÃO VINCULADA
	n.pro_int_numero_gabinete_ano, 
	n.pro_int_motivo_cancelamento   -- TEXTO DO MOTIVO DE CANCELAMENTO
FROM
	wcm_protocolos_internet n
	LEFT JOIN wcm_documentos d ON d.doc_id = n.pro_int_documento_id_fk
	LEFT JOIN wcm_tipos_documentos td ON td.tip_doc_id = d.doc_tipo_documento_id_fk
	LEFT JOIN wcm_situacoes_protocolos_internet sit ON sit.sit_pro_int_id = n.pro_int_situacao_protocolo_internet_id_fk
	LEFT JOIN wcm_usuarios_sistema u1 ON u1.usu_sis_id = n.pro_int_usuario_criacao_id_fk
	LEFT JOIN wcm_usuarios_sistema u2 ON u2.usu_sis_id = n.pro_int_usuario_liberacao_id_fk
	LEFT JOIN wcm_sessoes s ON s.ses_id = n.pro_int_sessao_id_fk
ORDER BY
	n.protocolo_internet_importado DESC