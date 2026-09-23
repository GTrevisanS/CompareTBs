SELECT
    wcm4.doc_id AS 'ID-Mocoes-NovoWCM',
    CONCAT(pr.processo_numero, '-', pr.processo_ano) 'NUMERO-PROTOCOLO-NOVOWCM',
    pr.Data_Protocolo,
    m.Codigo_individial_ano AS 'CODIGO-INDIVIDUAL-ANO',
    m.data_inicio_tramitacao,
    m.ementa,
    m.Justificativa,
    m.observacao,
    l.nome AS 'LEGISLATURA',
    tm.Descricao AS 'TIPO-MOCAO',
    st.Descricao AS 'TRAMITACAO',
    m.Regime_Tramitacao,
    m.Destinatario,
--     m.solicitacoes,
--     m.Titulo_mocao,
    m.INTERNET
FROM
    mocoes m
    LEFT JOIN legislatura l ON l.Codigo = m.Codigo_LEGISLATURA
    LEFT JOIN situacao_tramitacao st ON m.Codigo_SITUACAO_TRAMITACAO = st.Codigo
    LEFT JOIN tipo_mocao tm ON tm.Codigo = m.Tipo_Mocao_TIPO_MOCAO
    LEFT JOIN protocolo pr ON pr.Num_Protocolo = m.Num_Protocolo_PROTOCOLO
    LEFT JOIN {bancowcm4}.wcm_documentos wcm4 ON wcm4.codigo_mocoes_webcamara = m.Codigo
ORDER BY
    wcm4.doc_id DESC