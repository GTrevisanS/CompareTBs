SELECT
    wcm4.doc_ses_id AS 'ID-Expediente-NovoWCM',
    s.Nome AS 'SESSAO',
    CONCAT(sd.Tipo, ' ', sd.Numero_Doc) AS 'DOCUMENTO-EXPEDIENTE-WEBCAMARA'
FROM 
	sessao_documentos sd
	LEFT JOIN sessao s ON s.Codigo = sd.Codigo_Sessao
	LEFT JOIN {bancowcm4}.wcm_documentos_sessoes wcm4 ON wcm4.codigo_sessao_doc_webcamara = sd.Codigo
WHERE 
	sd.Codigo = (
    SELECT MAX(sd2.Codigo)
    FROM sessao_documentos sd2
    WHERE sd2.Codigo_Sessao = sd.Codigo_Sessao
      AND sd2.Tipo = sd.Tipo
      AND sd2.Numero_Doc = sd.Numero_Doc) 
   AND wcm4.doc_ses_id IS NOT NULL
ORDER BY sd.Codigo ASC
-- LIMIT 3000;