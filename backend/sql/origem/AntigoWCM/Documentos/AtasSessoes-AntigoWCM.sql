SELECT 
	a.ata_ses_id 'ID-WCM-ANTIGO',
	CONCAT(a.ata_ses_codigo_individual, '-', YEAR(a.ata_ses_data_ata), ' - ', ts.tip_ses_descricao) 'CODIGO-INDIVIDUAL-ANO',
	a.ata_ses_descricao 'EMENTA',
	a.ata_ses_data_ata 'DATA-REGISTRO',
	a.ata_ses_data_aprovacao 'DATA-APROVACAO',
	a.ata_ses_data_afixacao 'DATA-AFIXACAO',
	md.mes_dir_descricao 'MESA-DIRETORA',
	s.ses_nome 'SESSAO',
	ts.tip_ses_descricao 'TIPO-SESSAO',
	a.ata_ses_retificacao 'RETIFICACAO',
	a.ata_ses_mostra_online 'INTERNET'
FROM 
	wcm_atas_sessoes a
	LEFT JOIN wcm_mesas_diretoras md ON md.mes_dir_id = a.ata_ses_mesas_diretoras_id_fk
	LEFT JOIN wcm_sessoes s ON s.ses_id = a.ata_ses_sessoes_id_fk
	LEFT JOIN wcm_tipos_sessoes ts ON ts.tip_ses_id = a.ata_ses_tipos_sessoes_id_fk
ORDER BY
	a.ata_ses_id DESC