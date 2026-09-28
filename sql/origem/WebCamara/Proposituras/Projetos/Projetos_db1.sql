SELECT
    wcm4.doc_id 'ID-Projeto-NovoWCM',
    -- proj.Num_Protocolo_PROTOCOLO, # NUMERO DO PROTOCOLO NA TABELA DE PROTOCOLO DO WEBCAMARA
    CONCAT(pr.processo_numero, '-', pr.processo_ano) 'NUMERO-PROTOCOLO-NOVOWCM',
	pr.Data_Protocolo,
    proj.codigo_individual_ano AS 'CODIGO-INDIVIDUAL-ANO',
    l.Nome AS 'LEGISLATURA',
    proj.EMENTA,
    proj.JUSTIFICATIVA,
    proj.observacao AS 'OBSERVACOES',
    st.Descricao AS 'SITUACAO-TRAMITACAO',
    proj.Regime_Tramitacao 'REGIME-TRAMITACAO',
    proj.Iniciativa AS 'INICIATIVA',
    proj.QUORUM,
    c.Nome AS 'CATEGORIA',
    CASE
		WHEN proj.Data_Inicio_Tramitacao IS NULL THEN pr.Data_Protocolo
		WHEN proj.Data_Inicio_Tramitacao = 0 THEN pr.Data_Protocolo
	 	ELSE proj.Data_Inicio_Tramitacao    
    END AS 'DATA-INICIO-TRAMITACAO',
    proj.Data_Fim_Tramitacao 'DATA-LIMITE-TRAMITACAO',
    proj.INTERNET
FROM
    projeto proj
    LEFT JOIN tipo_projeto tp ON tp.Codigo = proj.Codigo_TIPO_PROJETO
    LEFT JOIN situacao_tramitacao st ON proj.Codigo_SITUACAO_TRAMITACAO = st.Codigo
    LEFT JOIN legislatura l ON l.Codigo = proj.Codigo_LEGISLATURA
    LEFT JOIN protocolo pr ON pr.Num_Protocolo = proj.Num_Protocolo_PROTOCOLO
    LEFT JOIN categoria_projeto catp ON catp.Num_Sequencial_PROJETO = proj.Num_Sequencial
    LEFT JOIN categoria c ON c.Codigo = catp.Codigo_CATEGORIA
    -- LEFT JOIN autor_projeto ap ON ap.Num_Sequencial_PROJETO = proj.Num_Sequencial AND ap.tipo = {id_tipo_documento_webcamara}
    LEFT JOIN {bancowcm4}.wcm_documentos wcm4 ON wcm4.codigo_projeto_webcamara = proj.Num_Sequencial
WHERE
    proj.Codigo_TIPO_PROJETO = {id_tipo_documento_webcamara}
--     proj.Codigo_Individual_Ano = '0002-2022'
GROUP BY
    proj.Num_Sequencial
ORDER BY
    wcm4.doc_id DESC