SELECT
    wd.{tipo_documento_importado},
    -- A coluna acima define de qual coluna o registro é importado
    -- (que como é o id que bate com o do webcamara, é o id que eu uso para comparar)
    -- (Por exemplo, se for filtrar por editais, a coluna equivalente do código de importação sera a "codigo_editais_importado")

    CONCAT(wpr.pro_codigo_individual_ano, '  ( ', wpr.pro_data_hora, ' )') AS 'PROTOCOLO-CONCATENADO-NOVOWCM',
    wpr.pro_data_hora, -- Data / Hora do protocolo do registro no novoWCM
    wpr.pro_codigo_individual_ano, -- Numero do protocolo do registro no novoWCM
    wd.doc_codigo_individual_ano, -- Codigo individual ano 
    wd.doc_ementa, -- Ementa 
    wd.doc_observacao, -- Observacoes
    wd.doc_justificativa, -- Justificativa
    wst.sub_tip_doc_descricao, -- Subtipo do registro (Ex: Moção -> Pesar, "Pesar" seria o subtipo)
    wd.doc_codigo_licitacao, -- Campo variável, pode ser muitas coisas
    situacoes.sit_descricao, -- Situação de tramitação
    wreg.reg_tra_descricao, -- Regime de tramitação
    autores.autores AS 'AUTOR-DOCUMENTO-NOVOWCM', 
    wcu.cad_uni_nome, -- Nome do cadastro unico vinculado (se tiver)
    -- Abaixo fica o CPF do cadastro unico vinculado (se tiver),
    AES_DECRYPT(UNHEX(wcu.cad_uni_documento),'{codigo_descriptografia_rg_cpf}') AS 'CPF-NOVOWCM',
    exp.expediente,
    ord.ordem_dia,
    GROUP_CONCAT(
    	CONCAT_WS(' ', wdtp1.tip_doc_descricao, wdresp1.doc_codigo_individual_ano)
    		ORDER BY wdresp1.doc_codigo_individual_ano
    		SEPARATOR ', '
    ) AS 'RESPOSTAS-RECEBIDAS-NOVOWCM',
    wd.doc_providencias, -- Providencias (se tiver)
    wd.doc_valor, -- Valor em reais (se tiver)
    wd.doc_valor_final, -- Valor final em reais (se tiver)
    wd.doc_local_viagem, -- Local viagem (se tiver)
    wti.tip_ini_descricao, -- Iniciativa (Só vi em projeto)
    wtq.tip_quo_descricao, -- Tipo de quorum de votação
    wtc.tip_cat_descricao, -- Categoria
    wpv.pro_vot_descricao, -- Processo de votação
    wd.doc_data_documento, -- Data do registro
    wd.doc_data_inicio_tramitacao, -- Data de inicio da tramitação
    wd.doc_data_limite_tramitacao, -- Data de limite da tramitação
    wd.doc_data_abertura, -- Data de abertura (Geralmente do edital)
    wd.doc_hora_abertura, -- Hora de abertura (Geralmente do edital)
    wd.doc_data_realizacao, -- Data de realização (Geralmente do edital)
    wd.doc_data_julgamento, -- Data do julgamento (Geralmente do edital)
    wd.doc_data_adjudicacao, -- Data de adjudicacao (Geralmente do edital)
    wd.doc_data_homologacao, -- Data de homologacao (Geralmente do edital)
    wd.doc_data_fim, -- Data Fim (Utilizo em atas no lugar da data de afixacao)
    wd.doc_data_arquivamento, -- Data arquivamento
    arqva.doc_arq_his_data, -- Data arquivamento (Da tabela de arquivamento)
    wde.dep_descricao, -- Nome do departamento responsável pelo registro
    wleg.leg_descricao, -- Nome da legislatura referente ao registro
    wmes.mes_dir_descricao, -- Nome da mesa diretora referente ao registro
    wd.doc_retificacao, -- Define se uma ata da sessão foi retificada ou não
    wd.doc_despacho_presidencia, -- "Despacho presidencia (Cessão dependencia)"
    -- wd.doc_cadastro_unico_id_fk, -- Cadastro único vinculado ao documento
    wd.doc_titulo_documento, -- Utilizado no "orgaoimprensa" de portarias
    wd.doc_edicao_documento, --  Utilizado na "edicao" de portarias
    wtl.tip_lic_descricao, -- Tipo de licitação (Geralmente Edital)
    we.end_descricao, -- Enderecamento (Destinatario)
    wcu1.cad_uni_nome as 'doc_fiscal_cadastro_unico' ,
    wdpro.doc_codigo_individual_ano 'NUMERO-PROCESSO-NOVOWCM',
    (
    	SELECT COUNT(*)
    	FROM wcm_processos_mensagens process_men
    	WHERE process_men.pro_men_documento_id_fk = wd.doc_id
    ) AS 'QUANTIDADE-MENSAGENS-NOVOWCM',
    wd.doc_mostra_online -- Se está ativo na internet
FROM 
    wcm_documentos wd
    LEFT JOIN wcm_protocolos wpr ON wpr.pro_documento_id_fk = wd.doc_id
    LEFT JOIN wcm_sub_tipos_documentos wst ON wst.sub_tip_doc_id = wd.doc_subtipo_documento_id_fk
    LEFT JOIN wcm_regimes_tramitacoes wreg ON wreg.reg_tra_id = wd.doc_regimes_tramitacoes_id_fk
    LEFT JOIN wcm_cadastros_unicos wcu ON wcu.cad_uni_id = wd.doc_cadastro_unico_id_fk
    LEFT JOIN wcm_cadastros_unicos wcu1 ON wcu1.cad_uni_id = wd.doc_fiscal_cadastro_unico_id_fk
    LEFT JOIN wcm_legislaturas wleg ON wleg.leg_id = wd.doc_legislatura_id_fk
    LEFT JOIN wcm_mesas_diretoras wmes ON wmes.mes_dir_id = wd.doc_mesa_diretora
    LEFT JOIN wcm_tipos_licitacoes wtl ON wtl.tip_lic_id = wd.doc_tipos_licitacoes_id_fk
    LEFT JOIN wcm_departamentos wde ON wde.dep_id = wd.doc_departamento_id_fk
    LEFT JOIN wcm_tipos_iniciativa wti ON wti.tip_ini_id = wd.doc_tipo_iniciativa_id_fk
    LEFT JOIN wcm_tipos_quoruns wtq ON wtq.tip_quo_id = wd.doc_tipo_quorum_id_fk
    LEFT JOIN wcm_documentos_categorias wdc ON wdc.doc_cat_documentos_id_fk = wd.doc_id
    LEFT JOIN wcm_tipos_categorias wtc ON wtc.tip_cat_id = wdc.doc_cat_tipos_categorias_id_fk
    LEFT JOIN wcm_processos_votacoes wpv ON wpv.pro_vot_id = wd.doc_processo_votacao_id_fk
	LEFT JOIN wcm_documentos_enderecamentos wden ON wden.doc_end_documento_id_fk = wd.doc_id
	LEFT JOIN wcm_enderecamentos we ON we.end_id = wden.doc_end_enderecamento_id_fk
    LEFT JOIN wcm_documentos_arquivamentos_historicos arqva ON arqva.doc_arq_his_documento_id_fk = wd.doc_id 

-- ========================================== PROCESSO DO DOCUMENTO ==========================================
	LEFT JOIN wcm_documentos_vinculados wdvinc ON wdvinc.doc_vin_documento_vinculado_id_fk = wd.doc_id
	LEFT JOIN wcm_documentos wdpro ON wdpro.doc_id = wdvinc.doc_vin_documento_principal_id_fk
	 	AND wdpro.doc_tipo_documento_id_fk IN (55, 146) -- Somente o tipo de processo legislativo e administrativo 	 
-- 	 LEFT JOIN wcm_processos_mensagens wpm ON wpm. 
-- ===========================================================================================================

-- =========================================== RESPOSTAS RECEBIDAS ===========================================
	LEFT JOIN wcm_documentos_respostas_encaminhamentos resp1 
	    ON resp1.doc_res_enc_documento_encaminhado_respondido_id_fk = wd.doc_id
	 	AND resp1.doc_res_enc_designacao = 1 -- 1 = Resposta (nesse caso, estou coletando as respostas recebidas)
	LEFT JOIN wcm_documentos wdresp1 ON wdresp1.doc_id = resp1.doc_res_enc_documento_origem_id_fk
	LEFT JOIN wcm_tipos_documentos wdtp1 ON wdtp1.tip_doc_id = wdresp1.doc_tipo_documento_id_fk 
-- ===========================================================================================================

    -- Situações de tramitação
    LEFT JOIN (SELECT wds.doc_sit_documento_id_fk, GROUP_CONCAT(DISTINCT wsit.sit_descricao ORDER BY wsit.sit_descricao SEPARATOR ', ') 
        AS sit_descricao FROM wcm_documentos_situacoes wds
    LEFT JOIN wcm_situacoes wsit ON wsit.sit_id = wds.doc_sit_situacao_id_fk
        GROUP BY wds.doc_sit_documento_id_fk) situacoes ON situacoes.doc_sit_documento_id_fk = wd.doc_id


    LEFT JOIN (
        SELECT
            wad.aut_doc_documento_id_fk,
            GROUP_CONCAT(
                DISTINCT wcu2.cad_uni_nome
                ORDER BY wcu2.cad_uni_nome
                SEPARATOR ', '
            ) AS autores
        FROM wcm_autor_documento wad
        LEFT JOIN wcm_cadastros_unicos wcu2
            ON wcu2.cad_uni_id = wad.aut_doc_cadastro_unico_id_fk
        GROUP BY wad.aut_doc_documento_id_fk
    ) autores
        ON autores.aut_doc_documento_id_fk = wd.doc_id

    LEFT JOIN (
        SELECT
            wsd.ses_doc_documento_id_fk,
            GROUP_CONCAT(
                DISTINCT wse.ses_nome
                ORDER BY wse.ses_nome
                SEPARATOR ', '
            ) AS expediente
        FROM wcm_sessoes_documentos wsd
        INNER JOIN wcm_sessoes wse
            ON wse.ses_id = wsd.ses_doc_sessao_id_fk
        WHERE wsd.ses_doc_tipo_pertencente = 1
        GROUP BY wsd.ses_doc_documento_id_fk
    ) exp
        ON exp.ses_doc_documento_id_fk = wd.doc_id

    LEFT JOIN (
        SELECT
            wsd.ses_doc_documento_id_fk,
            GROUP_CONCAT(
                DISTINCT wse.ses_nome
                ORDER BY wse.ses_nome
                SEPARATOR ', '
            ) AS ordem_dia
        FROM wcm_sessoes_documentos wsd
        INNER JOIN wcm_sessoes wse
            ON wse.ses_id = wsd.ses_doc_sessao_id_fk
        WHERE wsd.ses_doc_tipo_pertencente = 2
        GROUP BY wsd.ses_doc_documento_id_fk
    ) ord
        ON ord.ses_doc_documento_id_fk = wd.doc_id

WHERE
    wd.doc_tipo_documento_id_fk IN ( {id_tipo_documento_novowcm} ) -- ID que define o tipo de documento (Ex: Requerimento = 3)
    -- Pra ter certeza que não vou coletar registros deletados no novowcm (que geralmente são os de teste)
    AND wd.deleted_at IS NULL 
    
GROUP BY
	wd.doc_id

ORDER BY
    wd.{tipo_documento_importado} DESC;
