SELECT
	l.leg_id 'ID-WCM-ANTIGO',
	l.leg_descricao 'LEGISLATURA',
	l.leg_sigla 'SIGLA',
	l.leg_data_inicio 'DATA-INICIO',
	l.leg_data_fim 'DATA-FIM',
	l.leg_mostra_online 'INTERNET'
FROM 
	wcm_legislaturas l
-- 	LEFT JOIN wcm
ORDER BY l.leg_id DESC 