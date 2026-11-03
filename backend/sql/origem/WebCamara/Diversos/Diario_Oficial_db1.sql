SELECT 
	wcm4.div_id AS 'ID-Diario-Oficial-NovoWCM',
	-- d.Edicao,
	-- d.agendar,
	d.Observacao AS 'OBSERVACOES',
	d.Data as 'DATA-REGISTRO',
	d.INTERNET
FROM 
	diario_oficial d
	LEFT JOIN {bancowcm4}.wcm_diversos wcm4 ON wcm4.codigo_diario_oficial_webcamara = d.Codigo
ORDER BY wcm4.div_id DESC