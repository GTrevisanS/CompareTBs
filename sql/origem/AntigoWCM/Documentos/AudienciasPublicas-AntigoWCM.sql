SELECT 
	a.aud_pub_id 'ID-WCM-ANTIGO',
	a.aud_pub_protocolos_id_fk,
	CONCAT_WS('-', a.aud_pub_codigo_individual, YEAR(a.aud_pub_data_hora_audiencia)) 'CODIGO-INDIVIDUAL-ANO',
	a.aud_pub_ementa 'EMENTA',
	a.aud_pub_data_hora_audiencia 'DATA-REGISTRO',
	a.aud_pub_documentos_id_fk,
	a.aud_pub_tipos_protocolos_id_fk,
-- 	a.link_audiencia_publica_webcamara,
	a.aud_pub_ata_sessao_id_fk,
	ta.tip_aud_descricao 'SUBTIPO',
	l.leg_descricao 'LEGISLATURA',
	a.aud_pub_ges_doc_id_fk,
	a.aud_pub_ges_data,
	a.aud_pub_mostra_online 'INTERNET'
FROM 
	wcm_audiencias_publicas a
	LEFT JOIN wcm_legislaturas l ON l.leg_id = a.aud_pub_legislaturas_id_fk
	LEFT JOIN wcm_tipos_audiencias_publicas ta ON ta.tip_aud_id = a.aud_pub_tipos_aud_pub_id_fk
ORDER BY 
	a.aud_pub_id DESC 