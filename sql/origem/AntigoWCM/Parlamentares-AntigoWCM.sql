SELECT
	wp.par_id 'ID-WCM-ANTIGO',
	wp.par_nome 'NOME-POLITICO',
	wp.par_apelido 'APELIDO',
	wp.par_data_nascimento 'DATA-NASCIMENTO',
	-- wp.par_nacionalidade 'NACIONALIDADE',
	wp.par_naturalidade 'NATURALIDADE',
	CASE 
		WHEN wp.par_sexo = 1 THEN 'm'
		WHEN wp.par_sexo = 2 THEN 'f'
		ELSE ''
	END AS 'SEXO',
	wp.par_rg 'RG',
	wp.par_data_emissao_rg 'DATA-EMISSAO-RG',
	wp.par_cpf 'CPF',
	wp.par_pis 'PIS',
	wp.par_carteira_habilitacao 'CARTEIRA-HABILITACAO',
	wp.par_titulo_eleitoral 'TITULO-ELEITORAL',
	wp.par_data_emissao_te 'DATA-EMISSAO-TITULO-ELEITORAL',
	wp.par_zona_eleitoral 'ZONA-ELEITORAL',
	wp.par_secao_eleitoral 'SECAO-ELEITORAL',
	wp.par_carteira_profissional 'CARTEIRA-PROFISSIONAL',
	-- wp.par_profissoes_id_fk,
	pf.pro_descricao 'PROFISSAO',
	wp.par_reservista 'RESERVISTA',
	ec.est_civ_descricao 'ESTADO-CIVIL',
-- 	wp.par_ceps_id_fk
	esc.esc_descricao 'ESCOLARIDADE',
	wp.par_historia 'HISTORIA',
	wp.par_facebook 'REDE-SOCIAL-FACEBOOK',
	wp.par_instagram 'REDE-SOCIAL-INSTAGRAM',
	wp.par_linkedin 'REDE-SOCIAL-LINKEDIN',
	wp.par_twitter 'REDE-SOCIAL-TWITTER',
	wp.par_youtube 'REDE-SOCIAL-YOUTUBE',
	wp.par_mostra_online 'INTERNET'
FROM 
	wcm_parlamentares wp
	LEFT JOIN wcm_estados_civis ec ON ec.est_civ_id = wp.par_estados_civis_id_fk
	LEFT JOIN wcm_escolaridades esc ON esc.esc_id = wp.par_escolaridades_id_fk
	LEFT JOIN wcm_profissoes pf ON pf.pro_id = wp.par_profissoes_id_fk
ORDER BY wp.par_id DESC