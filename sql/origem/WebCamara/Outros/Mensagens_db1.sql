SELECT 
	wcm4.doc_id AS 'ID-Mensagem-NovoWCM',
	CONCAT(pr.processo_numero, '-', pr.processo_ano) 'NUMERO-PROTOCOLO-NOVOWCM',
	pr.Data_Protocolo,
	m.Codigo_Individual_Ano AS 'CODIGO-INDIVIDUAL-ANO',
	m.Assunto,
   CASE
		WHEN m.Data IS NULL then pr.Data_Protocolo
		WHEN m.Data = 0 THEN pr.Data_Protocolo
	 	ELSE m.Data   
   END AS 'Data_Inicio_Tramitacao',
	m.Numero_Oficio,
	m.Em_Resposta,
	l.nome AS 'LEGISLATURA',
	m.INTERNET
FROM 
	mensagem m 
	LEFT JOIN legislatura l ON l.Codigo = m.Codigo_LEGISLATURA
	LEFT JOIN protocolo pr ON pr.Num_Protocolo = m.Num_Protocolo_PROTOCOLO
	LEFT JOIN {bancowcm4}.wcm_documentos wcm4 ON wcm4.codigo_mensagem_webcamara = m.Codigo
ORDER BY wcm4.doc_id DESC