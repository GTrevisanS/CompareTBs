SELECT
	wcm4.doc_id AS 'ID-Pedido-Retirada-NovoWCM',
   CONCAT(pro.processo_numero, '-', pro.processo_ano) 'NUMERO-PROTOCOLO-NOVOWCM',
	pro.Data_Protocolo,
	pr.Codigo_Individual_Ano AS 'CODIGO-INDIVIDUAL-ANO',
	pr.Data AS 'DATA-REGISTRO',
	pr.ASSUNTO,
	CASE
		WHEN pr.quorum_votacao = 1 THEN 'Simples'
		WHEN pr.quorum_votacao = 2 THEN 'Absoluta'
		WHEN pr.quorum_votacao = 3 THEN 'Qualificada'
		WHEN pr.quorum_votacao = 4 THEN 'Dois Terços'
	END AS 'QUORUM',
	l.nome AS 'LEGISLATURA',
	pr.INTERNET
FROM 
	pedido_retirada pr
	LEFT JOIN protocolo pro ON pro.Num_Protocolo = pr.Num_Protocolo_PROTOCOLO
	LEFT JOIN legislatura l ON l.Codigo = pr.Codigo_Legislatura
	LEFT JOIN {bancowcm4}.wcm_documentos wcm4 ON wcm4.codigo_pedido_retirada_webcamara = pr.Codigo
ORDER BY 
	wcm4.doc_id DESC