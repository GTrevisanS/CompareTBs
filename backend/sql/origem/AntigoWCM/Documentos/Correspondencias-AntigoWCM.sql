SELECT 
	c.cor_id 'ID-WCM-ANTIGO',
	CONCAT(c.cor_codigo_individual, '-',YEAR(c.cor_data_hora)) 'CODIGO-INDIVIDUAL-ANO',
	c.cor_descricao 'EMENTA',
	c.cor_assunto 'ASSUNTO',
	c.cor_observacao 'OBSERVACOES',
	c.cor_data_hora 'DATA-REGISTRO',
	c.cor_data_hora_final 'DATA-FIM',
	l.leg_descricao 'LEGISLATURA',
	c.cor_tipos_correspondencias_id_fk 'SUBTIPO', 
	c.cor_designacao 'DESIGNACAO',
	c.cor_origem 'ORIGEM',
	c.cor_quantidade 'QUANTIDADE',
	c.cor_nome_remetente 'REMETENTE',
	c.cor_instituicao_remetente 'INSTITUICAO-REMETENTE',
	c.cor_endereco_remetente 'ENDERECO-REMETENTE',
	c.cor_bairro_remetente 'BAIRRO-REMETENTE',
	c.cor_cidade_remetente 'CIDADE-REMETENTE',
	c.cor_estado_remetente 'ESTADO-REMETENTE',
	c.cor_cep_remetente 'CEP-REMETENTE',
	c.cor_cargo_remetente 'CARGO-REMETENTE',
	c.cor_mostra_online 'INTERNET'
FROM 
	wcm_correspondencias c
	LEFT JOIN wcm_legislaturas l ON l.leg_id = c.cor_legislaturas_id_fk
ORDER BY
	c.cor_id DESC