SELECT
    wcm4.doc_id AS 'ID-Emenda-NovoWCM',
    CONCAT(pr.processo_numero, '-', pr.processo_ano) 'NUMERO-PROTOCOLO-NOVOWCM',
    em.codigo_individual_ano AS 'CODIGO-INDIVIDUAL-ANO',
    em.EMENTA,    
	em.observacao AS 'OBSERVACOES',
    te.Descricao AS 'TIPO',
    st.Descricao AS 'TRAMITACAO',
    l.nome AS 'LEGISLATURA',
    -- em.discussao,
	em.INTERNET
FROM
    emenda em
    LEFT JOIN tipo_emenda te ON te.Codigo = em.Codigo_TIPO_EMENDA
    LEFT JOIN situacao_tramitacao st ON em.Codigo_SITUACAO_TRAMITACAO = st.Codigo    
	LEFT JOIN protocolo pr ON pr.Num_Protocolo = em.Num_Protocolo_PROTOCOLO
	LEFT JOIN legislatura l ON l.Codigo = em.Codigo_Legislatura
    LEFT JOIN {bancowcm4}.wcm_documentos wcm4 ON wcm4.codigo_emenda_webcamara = em.Codigo
ORDER BY
    wcm4.doc_id DESC