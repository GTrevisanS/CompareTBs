SELECT 
    c.cad_uni_id 'ID-WCM-ANTIGO', 
    c.cad_uni_tipo_pessoa 'TIPO-PESSOA', -- 0: Pessoa Física // 1: Pessoa Jurídica
    CASE c.cad_uni_sexo 
   	WHEN 0 THEN 'M'
		WHEN 1 THEN 'F'
		ELSE ''
    END AS 'SEXO', 
    c.cad_uni_nome 'NOME',
    c.cad_uni_apelido 'APELIDO',
    c.cad_uni_data_nascimento 'DATA-NASCIMENTO',
    c.cad_uni_rg 'RG',
    c.cad_uni_cpf 'CPF',
    c.cad_uni_cnpj 'CNPJ',
    c.cad_uni_titulo_eleitor 'TITULO-ELEITOR',
    c.cad_uni_inscricao_estadual 'INSCRICAO-ESTADUAL',
    c.cad_uni_zona_eleitoral 'ZONA-ELEITORAL',
    c.cad_uni_secao_eleitoral 'SECAO-ELEITORAL',
    c.cad_uni_observacao 'OBSERVACOES',
    ra.ram_ati_descricao 'RAMO-ATIVIDADE',
    cs.cla_soc_descricao 'CLASSE-SOCIAL',
    c.cad_uni_endereco_comercial_id_fk 'ENDERECO-COMERCIAL-ID',
    c.cad_uni_endereco_residencial_id_fk 'ENDERECO-RESIDENCIAL-ID',
    c.cad_uni_escolaridades_id_fk 'ESCOLARIDADE-ID',
    c.cad_uni_profissoes_id_fk 'PROFISSAO-ID',
    c.cad_uni_tratamentos_id_fk 'TRATAMENTO-ID',
    ec.est_civ_descricao 'ESTADO-CIVIL',
    c.cad_uni_numero_endereco 'NUMERO-ENDERECO',
    c.cad_uni_complemento_endereco 'COMPLEMENTO-ENDERECO',
    c.cad_uni_bairros_id_fk 'BAIRRO-ID',
    c.cad_uni_cidades_id_fk 'CIDADE-ID',
    c.cad_uni_ceps_id_fk 'CEP-ID',
    c.cad_uni_numero_endereco_comercial 'NUMERO-ENDERECO-COMERCIAL',
    c.cad_uni_complemento_endereco_comercial 'COMPLEMENTO-ENDERECO-COMERCIAL',
    c.cad_uni_bairros_comercial_id_fk 'BAIRRO-COMERCIAL-ID',
    c.cad_uni_cidades_comercial_id_fk 'CIDADE-COMERCIAL-ID',
    c.cad_uni_ceps_comercial_id_fk 'CEP-COMERCIAL-ID',
    c.cad_uni_grupos_id_fk 'GRUPO-ID',
    c.cad_uni_naturalidade 'NATURALIDADE',
    c.cad_uni_carteira_habilitacao 'CARTEIRA-HABILITACAO',
    c.cad_uni_reservista 'RESERVISTA',
    c.cad_uni_data_emissao_rg 'DATA-EMISSAO-RG',
    c.cad_uni_data_emissao_te 'DATA-EMISSAO-TE',
    c.cad_uni_nome_pai 'NOME-PAI',
    c.cad_uni_nome_mae 'NOME-MAE',
    c.cad_uni_numero_pis_pasep 'PIS',
    c.cad_uni_carteira_profissional 'CARTEIRA-PROFISSIONAL',
    c.cad_uni_matricula 'MATRICULA',
    ca.car_descricao 'CARGO',
--     c.cad_uni_cargo 'CARGO',
    c.cad_uni_conjuge 'CONJUGE',
    c.cad_uni_data_nascimento_conjuge 'DATA-NASCIMENTO-CONJUGE',
    c.cad_uni_setor 'SETOR',
    c.cad_uni_funcao 'FUNCAO',
    c.cad_uni_origem 'ORIGEM',
    c.cad_uni_responsavel 'RESPONSAVEL',
    c.cad_uni_descricao 'DESCRICAO'
FROM
	  wcm_cadastros_unicos c
	  LEFT JOIN wcm_ramos_atividades ra ON ra.ram_ati_id = c.cad_uni_ramos_atividades_id_fk
	  LEFT JOIN wcm_classes_sociais cs ON cs.cla_soc_id = c.cad_uni_classes_sociais_id_fk
	  LEFT JOIN wcm_estados_civis ec ON ec.est_civ_id = c.cad_uni_estados_civis_id_fk
	  LEFT JOIN wcm_cargos ca ON ca.car_id = c.cad_uni_cargo_id_fk 
ORDER BY c.cad_uni_id DESC 
