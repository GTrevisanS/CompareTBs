SELECT 
	p.por_id 'ID-WCM-ANTIGO',
	CONCAT(p.por_codigo_individual, '-', YEAR(p.por_data_hora)) 'CODIGO-INDIVIDUAL-ANO',
	p.por_data_hora 'DATA-REGISTRO',
	p.por_ementa 'EMENTA',
	tp.tip_por_descricao 'SUBTIPO',
	p.por_numero_processo 'NUMERO-PROCESSO',
	p.por_local_publicacao 'LOCAL-PUBLICACAO',
	p.por_data_hora_publicacao 'DATA-PUBLICACAO',
	p.por_orgao_imprensa 'ORGAO-IMPRENSA',
	p.por_edicao 'EDICAO',
	md.mes_dir_descricao 'MESA-DIRETORA',
	p.por_mostra_online 'INTERNET'
FROM 
	wcm_portarias p
	LEFT JOIN wcm_tipos_portarias tp ON tp.tip_por_id = p.por_tipos_portarias_id_fk
	LEFT JOIN wcm_mesas_diretoras md ON md.mes_dir_id = p.por_mesas_diretoras_id_fk
ORDER BY
	p.por_id