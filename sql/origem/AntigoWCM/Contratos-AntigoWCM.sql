SELECT
	c.con_id 'ID-WCM-ANTIGO',
	CONCAT(c.con_codigo_individual, '-', YEAR(c.con_data_contrato)) 'CODIGO-INDIVIDUAL-ANO',
	c.con_data_contrato 'DATA-REGISTRO',
	c.con_data_inicio 'DATA-INICIO',
	c.con_data_fim 'DATA-FIM',
	c.con_assunto 'EMENTA',
	c.con_valor 'VALOR',
	t.tra_descricao 'SITUACAO-TRAMITACAO',
	c.con_mostra_online 'INTERNET'
FROM 
	wcm_contratos c
	LEFT JOIN wcm_tramitacoes t ON t.tra_id = c.con_tramitacoes_id_fk
ORDER BY 
	c.con_id DESC