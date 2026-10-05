SELECT
    wcm4.doc_id as 'ID-Requerimento-NovoWCM',
    req.Codigo,
    CONCAT(pr.processo_numero, '-', pr.processo_ano) 'NUMERO-PROTOCOLO-NOVOWCM',
    pr.Data_Protocolo,
    req.codigo_individual_ano AS 'CODIGO-INDIVIDUAL-ANO',
    req.EMENTA,
	req.JUSTIFICATIVA,
	req.observacao AS 'OBSERVACOES',
    req.DESTINATARIO,
    l.nome AS 'LEGISLATURA',
--     req.Situacao_Final,
--     req.Codigo_Oficio,
--     req.Data_Publicacao,
--     req.Local_Publicacao,
    tr.Descricao AS 'SUBTIPO',
    GROUP_CONCAT(
		CONCAT_WS(' ', resp.Tipo_Oficio, resp.Codigo_Individual_Ano_OFICIO) 
	 		ORDER BY resp.Codigo_Individual_Ano_OFICIO
			SEPARATOR ', ' 
	 ) AS 'RESPOSTAS-RECEBIDAS',
    st.Descricao AS 'SITUACAO-TRAMITACAO',
    req.Regime_Tramitacao 'REGIME-TRAMITACAO',
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
	LEFT JOIN oficio_resp_documentos resp ON resp.codigo_documento = req.Codigo
	 	AND resp.Tipo_Documento_Respondido LIKE '%Requerimento%' 
    LEFT JOIN {bancowcm4}.wcm_documentos wcm4 ON wcm4.codigo_requerimento_webcamara = req.Codigo
GROUP BY 
	wcm4.doc_id
ORDER BY
    wcm4.doc_id DESC