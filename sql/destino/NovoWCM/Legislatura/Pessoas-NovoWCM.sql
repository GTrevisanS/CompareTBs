SELECT 
	wc.{tipo_documento_importado},
	wc.cad_uni_nome,
	wc.cad_uni_apelido,
	AES_DECRYPT(UNHEX(wc.cad_uni_data_nascimento),'{codigo_descriptografia_rg_cpf}') AS 'DATA-NASCIMENTO-NOVOWCM',
	wc.cad_uni_nacionalidade,
	wc.cad_uni_naturalidade,
	CASE wc.cad_uni_sexo
		WHEN 0 THEN 'M'
		WHEN 1 THEN 'F'
		ELSE ''
	END AS 'cad_uni_sexo',
	we.end_endereco,
	AES_DECRYPT(UNHEX(wc.cad_uni_rg),'{codigo_descriptografia_rg_cpf}') AS 'RG-NOVOWCM',
	wc.cad_uni_data_emissao_rg,
	AES_DECRYPT(UNHEX(wc.cad_uni_documento),'{codigo_descriptografia_rg_cpf}') AS 'CPF-NOVOWCM',
	wc.cad_uni_carteira_habilitacao,
	wc.cad_uni_titulo_eleitor,
	wc.cad_uni_data_emissao_titulo_eleitor,
	wc.cad_uni_zona_eleitoral,
	wc.cad_uni_secao_eleitoral,
	wc.cad_uni_carteira_profissional,
	wp.pro_descricao,	
	wcg.cad_uni_car_descricao,
	wc.cad_uni_reservista,
	wc.cad_uni_conjuge,
	wec.est_civ_descricao,
	wcep.cep_numero,
	wesc.esc_descricao,
	wc.cad_uni_nome_pai,
	wc.cad_uni_nome_mae,
	wpol.pol_historia
FROM 
	wcm_cadastros_unicos wc
	LEFT JOIN wcm_enderecos we ON we.end_id = wc.cad_uni_endereco_id_fk
	LEFT JOIN wcm_ceps wcep ON wcep.cep_id = we.end_cep_id_fk
	LEFT JOIN wcm_escolaridades wesc ON wesc.esc_id = wc.cad_uni_escolaridade_id_fk
	LEFT JOIN wcm_estados_civis wec ON wec.est_civ_id = wc.cad_uni_estado_civil_id_fk
	LEFT JOIN wcm_profissoes wp ON wp.pro_id = wc.cad_uni_profissao_id_fk
	LEFT JOIN wcm_cadastros_unicos_cargos wcg ON wcg.cad_uni_car_id = wc.cad_uni_cargo_id_fk
	LEFT JOIN wcm_politicos wpol ON wpol.pol_cadastro_unico_id_fk = wc.cad_uni_id
WHERE 
	{parametro_where}
ORDER BY
	wc.{tipo_documento_importado} DESC