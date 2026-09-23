SELECT 
	wl.leg_id 'ID-WCM-ANTIGO',
	wl.leg_codigo_individual 'CODIGO-INDIVIDUAL-ANO',
--  wtl.tip_lei_descricao 'TIPO-LEI', 
-- 	wl.leg_tipos_leis_id_fk,
	wl.leg_ementa 'EMENTA',
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
	wl.leg_data_hora 'DATA-REGISTRO',
	-- wl.leg_data_hora_publicacao,
	-- wl.leg_local_publicacao,
	l.leg_descricao 'LEGISLATURA',
	wl.leg_mostra_online 'INTERNET'
FROM 
	wcm_legislacoes wl 
	LEFT JOIN wcm_tipos_leis wtl ON wtl.tip_lei_id = wl.leg_tipos_leis_id_fk 
	LEFT JOIN wcm_legislaturas l ON l.leg_id = wl.leg_legislaturas_id_fk
WHERE 
	wl.leg_tipos_leis_id_fk = {tipo_legislacao_antigowcm}