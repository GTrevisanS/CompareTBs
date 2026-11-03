SELECT 
	wcm4.cad_gen_id AS 'ID-Documento-NovoWCM',
	CONCAT (d.codigo_individual, '-', d.ano)  AS 'CODIGO-INDIVIDUAL-ANO',
	d.ASSUNTO,
	d.observacao AS 'OBSERVACOES',
	-- d.autoria,
	td.descricao AS 'TIPO',
	d.Data AS 'DATA-REGISTRO',
	0 AS 'INTERNET' -- Faço isso pra ter certeza que vira desabilitado
FROM 
	documentos d
	LEFT JOIN {bancowcm4}.wcm_cadastros_genericos wcm4 ON wcm4.codigo_documentos_webcamara = d.codigo
	LEFT JOIN tipo_documento td ON td.codigo = d.Tipo_Documento
ORDER BY 
	wcm4.cad_gen_id DESC