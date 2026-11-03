SELECT 
	a.ate_id 'ID-WCM-ANTIGO',
	CONCAT(a.ate_codigo_individual, '-', YEAR(a.ate_data_hora_atestado) )'CODIGO-INDIVIDUAL-ANO',
	a.ate_assunto 'EMENTA',
	a.ate_data_hora_atestado 'DATA-REGISTRO',
	ta.tip_ate_descricao 'SUBTIPO',
	a.ate_mostra_online 'INTERNET'
FROM 
	wcm_atestados a
	LEFT JOIN wcm_tipos_atestados ta ON ta.tip_ate_id = a.ate_tipos_atestados_id_fk
ORDER BY 
	a.ate_id DESC