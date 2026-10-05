SELECT
    wcm4.doc_id 'ID-Indicacao-NovoWCM',
    CONCAT(pr.processo_numero, '-', pr.processo_ano) 'NUMERO-PROTOCOLO-NOVOWCM',
    pr.Data_Protocolo,
    ind.Codigo_Individial_Ano AS 'CODIGO-INDIVIDUAL-ANO',
    CASE
		WHEN ind.Data_Inicio_Tramitacao IS NULL then pr.Data_Protocolo
		WHEN ind.Data_Inicio_Tramitacao = 0 THEN pr.Data_Protocolo
	 	ELSE ind.Data_Inicio_Tramitacao    
    END AS 'DATA-INICIO-TRAMITACAO',
    ind.EMENTA,
    ind.observacao AS 'OBSERVACOES',
    ind.JUSTIFICATIVA,
    ti.Descricao AS 'SUBTIPO',
    st.Descricao AS 'SITUACAO-TRAMITACAO',
    ind.Regime_Tramitacao AS 'REGIME-TRAMITACAO',
    ind.Destinatario,
    ind.solicitacoes,
    ind.Revogado,
    l.nome AS 'LEGISLATURA',
    ind.INTERNET
FROM
    indicacoes ind
    LEFT JOIN tipo_indicacao ti ON ti.Codigo = ind.tipo_indicacao
    LEFT JOIN situacao_tramitacao st ON ind.Codigo_SITUACAO_TRAMITACAO = st.Codigo
    LEFT JOIN protocolo pr ON pr.Num_Protocolo = ind.Num_Protocolo_PROTOCOLO
    LEFT JOIN legislatura l ON l.Codigo = ind.Codigo_LEGISLATURA
    LEFT JOIN {bancowcm4}.wcm_documentos wcm4 ON wcm4.codigo_indicacoes_webcamara = ind.Codigo
ORDER BY
    wcm4.doc_id DESC