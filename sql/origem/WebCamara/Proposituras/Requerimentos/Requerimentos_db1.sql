SELECT
    wcm4.doc_id as 'ID-Requerimento-NovoWCM',
    CONCAT(pr.processo_numero, '-', pr.processo_ano) 'NUMERO-PROTOCOLO-NOVOWCM',
    pr.Data_Protocolo,
    req.codigo_individual_ano AS 'CODIGO-INDIVIDUAL-ANO',
    req.ementa,
	req.JUSTIFICATIVA,
	req.observacao,
    req.Destinatario,
    l.nome AS 'LEGISLATURA',
--     req.Situacao_Final,
--     req.Codigo_Oficio,
--     req.Data_Publicacao,
--     req.Local_Publicacao,
    tr.Descricao AS 'tipo',
    st.Descricao AS 'tramitacao',
    req.Regime_Tramitacao,
	 CASE
	 	WHEN req.Data_Inicio_Tramitacao IS NULL THEN pr.Data_Protocolo
		WHEN req.Data_Inicio_Tramitacao = 0 THEN pr.Data_Protocolo
		ELSE req.Data_Inicio_Tramitacao
    END AS 'DATA-INICIO-TRAMITACAO',
--     req.palavrasprobabilidade,
--     req.revogado,
--     req.codigo_tipo_projeto,
--     req.solicitacoes,
    req.INTERNET
FROM
    requerimento req
    LEFT JOIN tipo_requerimento tr ON tr.Codigo = req.Codigo_Tipo_Requerimento
    LEFT JOIN situacao_tramitacao st ON req.Codigo_SITUACAO_TRAMITACAO = st.Codigo
	 LEFT JOIN legislatura l ON l.Codigo = req.Codigo_LEGISLATURA
	 LEFT JOIN protocolo pr ON pr.Num_Protocolo = req.Num_Protocolo_PROTOCOLO
    LEFT JOIN {bancowcm4}.wcm_documentos wcm4 ON wcm4.codigo_requerimento_webcamara = req.Codigo
ORDER BY
    wcm4.doc_id DESC