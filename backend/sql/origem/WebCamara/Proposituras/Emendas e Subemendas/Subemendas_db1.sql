SELECT
    wcm4.doc_id AS 'ID-SubEmenda-NovoWCM',
    CONCAT(pr.processo_numero, '-', pr.processo_ano) 'NUMERO-PROTOCOLO-NOVOWCM',
    s.codigo_individual_ano AS 'CODIGO-INDIVIDUAL-ANO',
    s.EMENTA,
    s.observacao 'OBSERVACOES',
    te.Descricao AS 'TIPO-EMENDA',
    st.Descricao AS 'TRAMITACAO',
    s.Num_Protocolo_PROTOCOLO,
    l.nome AS 'LEGISLATURA',
    -- s.discussao
    s.INTERNET
FROM
    subemenda s
    LEFT JOIN situacao_tramitacao st ON s.Codigo_SITUACAO_TRAMITACAO = st.Codigo
    LEFT JOIN tipo_emenda te ON te.Codigo = s.Codigo_TIPO_EMENDA    
	LEFT JOIN legislatura l ON l.Codigo = s.Codigo_LEGISLATURA	 
    LEFT JOIN protocolo pr ON pr.Num_Protocolo = s.Num_Protocolo_PROTOCOLO
    LEFT JOIN {bancowcm4}.wcm_documentos wcm4 ON wcm4.codigo_subemendas_webcamara = s.Codigo
ORDER BY
    wcm4.doc_id DESC