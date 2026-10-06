SELECT
    wcm4.doc_id AS 'ID-Mocoes-NovoWCM',
    CONCAT(pr.processo_numero, '-', pr.processo_ano) 'NUMERO-PROTOCOLO-NOVOWCM',
    pr.Data_Protocolo,
    m.Codigo_individial_ano AS 'CODIGO-INDIVIDUAL-ANO',
	CASE
	 	WHEN m.Data_Inicio_Tramitacao IS NULL THEN pr.Data_Protocolo
		WHEN m.Data_Inicio_Tramitacao = 0 THEN pr.Data_Protocolo
		ELSE m.Data_Inicio_Tramitacao
    END AS 'DATA-REGISTRO',
    m.EMENTA,
    m.JUSTIFICATIVA,
    m.observacao AS 'OBSERVACOES',
    m.Titulo_mocao 'TITULO',
	 CASE
		WHEN m.quorum_votacao = 1 THEN 'Simples'
		WHEN m.quorum_votacao = 2 THEN 'Absoluta'
		WHEN m.quorum_votacao = 3 THEN 'Qualificada'
		WHEN m.quorum_votacao = 4 THEN 'Dois Terços'
	 END AS 'QUORUM',
    l.nome AS 'LEGISLATURA',
    tm.Descricao AS 'SUBTIPO',
    st.Descricao AS 'SITUACAO-TRAMITACAO',
    m.Regime_Tramitacao 'REGIME-TRAMITACAO',
    m.DESTINATARIO,
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