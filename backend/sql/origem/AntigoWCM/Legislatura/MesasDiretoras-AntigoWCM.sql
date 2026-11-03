SELECT 
	m.mes_dir_id 'ID-WCM-ANTIGO',
	m.mes_dir_descricao 'MESA-DIRETORA',
	l.leg_descricao 'LEGISLATURA',
	m.mes_dir_sigla 'SIGLA',
	m.mes_dir_bienio 'BIENIO',
	m.mes_dir_data_inicio AS 'DATA-INICIO',
	m.mes_dir_data_fim AS 'DATA-FIM',
	m.mes_dir_observacao 'OBSERVACOES',
	GROUP_CONCAT(p.par_nome ORDER BY p.par_nome DESC SEPARATOR '___' ) 'MEMBROS',
	m.mes_dir_situacao 'SITUACAO'
FROM 
	wcm_mesas_diretoras m
	LEFT JOIN wcm_legislaturas l ON l.leg_id = m.mes_dir_legislaturas_id_fk
	LEFT JOIN wcm_mesas_membros mem ON mem.mes_mem_mesas_diretoras_id_fk = m.mes_dir_id
	LEFT JOIN wcm_parlamentares p ON p.par_id = mem.mes_mem_parlamentares_id_fk
GROUP BY
	m.mes_dir_id
ORDER BY 
	m.mes_dir_id DESC