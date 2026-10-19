SELECT 	
	w.doc_id 'ID-WCM-ANTIGO',
 	CONCAT(wp.pro_numero, '-', YEAR(w.doc_data_documento), '  ( ', wp.pro_data_hora ,' )') 	'PROTOCOLO-REGISTRO',
--  	CONCAT(wp.pro_numero, '-', YEAR(w.doc_data_documento)) 'NUMERO-PROTOCOLO-NOVOWCM',
-- 	wp.pro_data_hora 'DATA-HORA-PROTOCOLO',
	CONCAT(w.doc_codigo_individual, '-', YEAR(w.doc_data_documento)) 'CODIGO-INDIVIDUAL-ANO',
	w.doc_data_documento 'DATA-REGISTRO',
	wtd.tip_doc_descricao 'SUBTIPO',
	w.doc_ementa 'EMENTA',
	w.doc_justificativa 'JUSTIFICATIVA',
	w.doc_observacao 'OBSERVACOES',
-- 	w.doc_texto_executivo 'TEXTO-EXECUTIVO',
-- 	w.doc_texto 'TEXTO',
	wtp.tip_pro_descricao 'TIPO-REGISTRO',
	wtr.tra_descricao 'SITUACAO-TRAMITACAO',
	wrt.reg_tra_descricao 'REGIME-TRAMITACAO',
	wtq.tip_quo_descricao 'QUORUM',
	wi.ini_descricao 'INICIATIVA',
	w.doc_titulo_propositura 'TITULO-PROPOSITURA',
	w.doc_data_publicacao 'DATA-PUBLICACAO',
	wpv.pro_vot_descricao 'PROCESSO-VOTACAO',
	w.doc_data_inicio_tramitacao 'DATA-INICIO-TRAMITACAO',
	CASE
		WHEN w.doc_data_limite_tramitacao != NULL THEN w.doc_data_limite_tramitacao
		ELSE w.doc_data_fim_tramitacao 
	END AS 'DATA-LIMITE-TRAMITACAO',
	w.doc_data_fim_tramitacao 'DATA-FIM-TRAMITACAO',
	wl.leg_descricao 'LEGISLATURA',
	wfxp.pro_id 'ID-PROCESSO',
	concat(wfxp.pro_codigo_individual_documentos, '-', wfxp.pro_ano) 'NUMERO-PROCESSO',
	w.doc_mostra_online 'INTERNET'
FROM 
	wcm_documentos w
	LEFT JOIN wcm_protocolos wp ON wp.pro_documentos_id_fk = w.doc_id
	LEFT JOIN wcm_tipos_protocolos wtp ON wtp.tip_pro_id = wp.pro_tipos_protocolos_id_fk
	LEFT JOIN wcm_tramitacoes wtr ON wtr.tra_id = w.doc_tramitacoes_id_fk
	LEFT JOIN wcm_regimes_tramitacoes wrt ON wrt.reg_tra_id = w.doc_regimes_tramitacoes_id_fk
	LEFT JOIN wcm_tipos_quoruns wtq ON wtq.tip_quo_id = w.doc_tipos_quoruns_id_fk
	LEFT JOIN wcm_tipos_documentos wtd ON wtd.tip_doc_id = w.doc_tipos_documentos_id_fk
	LEFT JOIN wcm_iniciativas wi ON wi.ini_id = w.doc_iniciativas_id_fk
	LEFT JOIN wcm_processos_votacoes wpv ON wpv.pro_vot_id = w.doc_processos_votacoes_id_fk
	-- LEFT JOIN wfx_processos wpro ON wpro.pro_codigo_individual_documentos = w.doc_id
	LEFT JOIN wcm_legislaturas wl ON wl.leg_id = w.doc_legislaturas_id_fk
	LEFT JOIN wfx_processos wfxp ON wfxp.pro_numero_protocolo = wp.pro_id
WHERE 
	w.doc_tipos_protocolos_id_fk = {tipo_protocolo_antigowcm}
ORDER BY 
	w.doc_id DESC 
