SELECT 
	wl.leg_id 'ID-WCM-ANTIGO',
	wl.leg_codigo_individual 'CODIGO-INDIVIDUAL-ANO',
	wl.leg_data_hora 'DATA-REGISTRO',
--  wtl.tip_lei_descricao 'TIPO-LEI', 
-- 	wl.leg_tipos_leis_id_fk,
	wl.leg_ementa 'EMENTA',
	wl.leg_local_publicacao 'LOCAL-PUBLICACAO',
	wl.leg_data_hora_publicacao 'DATA-PUBLICACAO',
-- 	CASE
-- 		WHEN wl.leg_titulo_honorifico_situacao = 0 THEN 'Entregue'
-- 		WHEN wl.leg_titulo_honorifico_situacao = 1 THEN 'Não Entregue'
-- 		WHEN wl.leg_titulo_honorifico_situacao = 2 THEN 'Aguardando Entrega'
-- 		WHEN wl.leg_titulo_honorifico_situacao = 3 THEN 'Recusado'
-- 		ELSE ''
-- 	END AS 'SITUACAO-TITULO-HONORIFICO',
-- 	wl.leg_titulo_honorifico_data_entrega,
-- 	wl.leg_titulo_honorifico_observacao,
-- 	wl.leg_adin_numero_processo,
-- 	wl.leg_adin_data_hora_acordao,
-- 	wl.leg_adin_observacao,
-- 	wl.leg_atos_id_fk,
	wl.leg_texto 'TEXTO',
	CONCAT_WS(', ',
	    IF(wl.leg_situacao_lei_ativa != 0, 'Em vigor', NULL),
	    IF(wl.leg_situacao_lei_revogada_parcialmente != 0, 'Revogada Parcial', NULL),
	    IF(wl.leg_situacao_lei_revogada_totalmente != 0, 'Revogada Totalmente', NULL),
	    IF(wl.leg_situacao_lei_inconstitucional != 0, 'Inconstitucional', NULL),
	    IF(wl.leg_situacao_lei_suspensa_por_liminar != 0, 'Suspensa por liminar', NULL),
	    IF(wl.leg_situacao_lei_parcialmente_inconstitucional != 0, 'Parcialmente inconstitucional', NULL),
	    IF(wl.leg_situacao_lei_alterada != 0, 'Alterada', NULL),
	    IF(wl.leg_situacao_lei_suspensa_lei_complementar != 0, 'Suspensa por lei complementar', NULL),
	    IF(wl.leg_situacao_lei_suspensa_parcialmente_por_liminar != 0, 'Suspensa Parcialmente por liminar', NULL)) 
	AS 'SITUACAO-TRAMITACAO',
	l.leg_descricao 'LEGISLATURA',
	wl.leg_mostra_online 'INTERNET'
FROM 
	wcm_legislacoes wl 
	LEFT JOIN wcm_tipos_leis wtl ON wtl.tip_lei_id = wl.leg_tipos_leis_id_fk 
	LEFT JOIN wcm_legislaturas l ON l.leg_id = wl.leg_legislaturas_id_fk
WHERE 
	wl.leg_tipos_leis_id_fk = {tipo_legislacao_antigowcm}
ORDER BY 
	wl.leg_id DESC