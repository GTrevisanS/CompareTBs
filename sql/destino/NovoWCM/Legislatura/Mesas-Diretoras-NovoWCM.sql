SELECT 
	wmd.codigo_mesa_importada,
	wmd.mes_dir_descricao,
	wl.leg_descricao,
	wmd.mes_dir_sigla,
	wmd.mes_dir_bienio,
	wmd.mes_dir_data_inicio AS 'DATA-INICIO',
	wmd.mes_dir_data_fim AS 'DATA-FIM',
	wmd.mes_dir_observacao,
	GROUP_CONCAT(wcad.cad_uni_nome ORDER BY wcad.cad_uni_nome DESC SEPARATOR '___') AS 'MEMBROS-NOVOWCM',
	wmd.mes_dir_situacao
FROM 
	wcm_mesas_diretoras wmd
	LEFT JOIN wcm_legislaturas wl ON wl.leg_id = wmd.mes_dir_legislatura_id_fk
	LEFT JOIN wcm_mesas_membros mem ON mem.mes_mem_mesas_diretoras_id_fk = wmd.mes_dir_id
	LEFT JOIN wcm_cadastros_unicos wcad ON wcad.cad_uni_id = mem.mes_mem_cadastro_unico_id_fk
GROUP BY
	wmd.mes_dir_id
ORDER BY 
	wmd.codigo_mesa_importada DESC