SELECT 
	wcm4.doc_id AS 'ID-Pedido-Informacao-NovoWCM',
	CONCAT(pr.processo_numero, '-', pr.processo_ano) 'NUMERO-PROTOCOLO-NOVOWCM',
	pr.Data_Protocolo AS 'DATA-PROTOCOLO-NOVOWCM',
	p.Num_Sequencial_Ano AS 'CODIGO-INDIVIDUAL-ANO',
	p.Tipo AS 'SUBTIPO',
	p.EMENTA,
	p.`Data` AS 'DATA-REGISTRO',
	l.nome AS 'LEGISLATURA'
-- 	p.Codigo_propositura,
-- 	p.Tipo_Codigo,
-- 	p.Codigo_TIPO_PROJETO_PROJETO
FROM 
	pedido_informacao p
	LEFT JOIN {bancowcm4}.wcm_documentos wcm4 ON wcm4.codigo_pedido_informacao_webcamara = p.Codigo	
	LEFT JOIN protocolo pr ON pr.Num_Protocolo = p.Num_Protocolo_PROTOCOLO
	LEFT JOIN legislatura l ON l.Codigo = p.Codigo_LEGISLATURA
ORDER BY 
	wcm4.doc_id DESC