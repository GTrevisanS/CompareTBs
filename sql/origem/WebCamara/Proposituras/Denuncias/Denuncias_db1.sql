SELECT 
	wcm4.doc_id AS 'ID-Denuncia-NovoWCM',
   CONCAT(pr.processo_numero, '-', pr.processo_ano) 'NUMERO-PROTOCOLO-NOVOWCM',
	d.Codigo_Individual_Ano AS 'CODIGO-INDIVIDUAL-ANO', 
	l.Nome AS 'LEGISLATURA',
	d.EMENTA,
	CASE
		WHEN d.quorum_votacao = 1 THEN 'Simples'
		WHEN d.quorum_votacao = 2 THEN 'Absoluta'
		WHEN d.quorum_votacao = 3 THEN 'Qualificada'
		WHEN d.quorum_votacao = 4 THEN 'Dois Terços'
	END AS 'QUORUM',
	st.Descricao 'SITUACAO-TRAMITACAO',
	d.Data AS 'DATA-REGISTRO',
	d.INTERNET
FROM 
	denuncia d
	LEFT JOIN legislatura l ON l.Codigo = d.Codigo_LEGISLATURA
	LEFT JOIN situacao_tramitacao st ON st.Codigo = d.codigo_situacao_tramitacao    
	LEFT JOIN protocolo pr ON pr.Num_Protocolo = d.Num_Protocolo_PROTOCOLO
	LEFT JOIN {bancowcm4}.wcm_documentos wcm4 ON wcm4.codigo_denuncia_webcamara = d.Codigo
ORDER BY 	
	wcm4.doc_id DESC