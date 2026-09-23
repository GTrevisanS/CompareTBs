SELECT 
	wmd.codigo_mesa_importada,
	wl.leg_descricao,
	wmd.mes_dir_descricao,
	wmd.mes_dir_sigla,
	wmd.mes_dir_bienio,
	wmd.mes_dir_data_inicio AS 'DATA-INICIO',
	wmd.mes_dir_data_fim AS 'DATA-FIM',
	wmd.mes_dir_situacao,
	wmd.mes_dir_observacao
FROM 
	wcm_mesas_diretoras wmd
	LEFT JOIN wcm_legislaturas wl ON wl.leg_id = wmd.mes_dir_legislatura_id_fk
ORDER BY wmd.codigo_mesa_importada DESC