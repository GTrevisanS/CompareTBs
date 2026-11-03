SELECT 
	c.con_id 'ID-WCM-ANTIGO',
	CONCAT(c.con_codigo_individual, '-', YEAR(c.con_data_hora)) 'CODIGO-INDIVIDUAL-ANO',
	c.con_data_hora 'DATA-REGISTRO',
	c.con_numero_convite_original 'NUMERO-ORIGINAL',
	c.con_assunto 'EMENTA',
	c.con_endereco 'LOCAL',
	l.leg_descricao 'LEGISLATURA',
	c.con_cadastros_unicos_id_fk 'REPRESENTANTE',
	c.con_mostra_online 'INTERNET'
FROM 
	wcm_convites c
	LEFT JOIN wcm_legislaturas l ON l.leg_id = c.con_legislaturas_id_fk
ORDER BY	
	c.con_id DESC