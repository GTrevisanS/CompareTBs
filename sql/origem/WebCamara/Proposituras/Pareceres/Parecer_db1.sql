SELECT
    wcm4.doc_id AS 'ID-Parecer-NovoWCM',
    CONCAT(pr.processo_numero, '-', pr.processo_ano) 'NUMERO-PROTOCOLO-NOVOWCM',
    pr.Data_Protocolo,
    p.Num_Sequencial_Ano AS 'CODIGO-INDIVIDUAL-ANO',
	 CASE
		WHEN p.Data IS NULL then pr.Data_Protocolo
		WHEN p.Data = 0 THEN pr.Data_Protocolo
	 	ELSE p.Data
	 END AS 'Data_Inicio_Tramitacao',
    p.Ementa,
    p.Tipo AS 'TIPOS-PARECERES',
    l.Nome AS 'LEGISLATURA',
    tp.Descricao 'TIPO-PARECER-SITUACAO',
    tpp.Descricao AS 'TIPO-PROPOSITURA-PARECER',
    p.observacao,
--     p.Num_Sequencial_PROJETO,
    p.INTERNET
FROM
    parecer p
    LEFT JOIN tipo_parecer tp ON tp.Codigo = p.codigo_tipo_parecer
    LEFT JOIN tipo_propositura_parecer tpp ON tpp.Codigo = p.Tipo_Propositura
    LEFT JOIN legislatura l ON l.Codigo = p.Codigo_LEGISLATURA
    LEFT JOIN protocolo pr ON pr.Num_Protocolo = p.Num_Protocolo_PROTOCOLO
    LEFT JOIN {bancowcm4}.wcm_documentos wcm4 ON wcm4.codigo_parecer_webcamara = p.Codigo
ORDER BY
    wcm4.doc_id DESC