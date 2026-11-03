SELECT
	wl.codigo_legislatura_importada,
	wl.leg_descricao,
	wcuprefeito.cad_uni_nome AS 'NOME-PREFEITO-NOVOWCM',
	wcuvice.cad_uni_nome AS 'NOME-VICE-PREFEITO-NOVOWCM',
	wl.leg_sigla,
	wl.leg_data_inicio,
	wl.leg_data_fim,
	wl.leg_mostra_online
FROM 
	wcm_legislaturas wl
	LEFT JOIN wcm_legislaturas_prefeito_e_vice wlprefeito 
		ON wlprefeito.leg_pre_vic_legislatura_id_fk = wl.leg_id
		AND wlprefeito.leg_pre_vic_tipo_pertecente = 0
		
	LEFT JOIN wcm_cadastros_unicos wcuprefeito 
		ON wcuprefeito.cad_uni_id = wlprefeito.leg_pre_vic_cadastro_unico_id_fk
		
	LEFT JOIN wcm_legislaturas_prefeito_e_vice wlvice 
		ON wlvice.leg_pre_vic_legislatura_id_fk = wl.leg_id
		AND wlvice.leg_pre_vic_tipo_pertecente = 1
		
	LEFT JOIN wcm_cadastros_unicos wcuvice 
		ON wcuvice.cad_uni_id = wlvice.leg_pre_vic_cadastro_unico_id_fk
		
ORDER BY wl.codigo_legislatura_importada DESC