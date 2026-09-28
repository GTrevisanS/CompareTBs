SELECT
	wcm4.out_doc_id AS 'ID-Ata-Edital-NovoWCM',
	e.Codigo_Individual_Ano AS 'CODIGO-DO-EDITAL',
	ec.Codigo_Individual_Ano AS 'CODIGO-DO-EDITAL-LICITACAO',
	ael.TITULO,
	ael.OBSERVACOES,
	ael.Data AS 'DATA-REGISTRO'
FROM 
	ata_editais_licitacao ael
	LEFT JOIN {bancowcm4}.wcm_outros_documentos wcm4 ON wcm4.codigo_ata_editais_webcamara = ael.Codigo
	LEFT JOIN editais e ON e.Codigo = ael.Codigo_Edital
	LEFT JOIN edital_convocacao ec ON ec.Codigo = ael.Codigo_Edital_Licitacao
ORDER BY	wcm4.out_doc_id DESC