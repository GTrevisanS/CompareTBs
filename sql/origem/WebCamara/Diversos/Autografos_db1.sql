SELECT
	wcm4.aut_id AS 'ID-Autografo-NovoWCM',
	a.Codigo_Individual_Ano AS 'CODIGO-INDIVIDUAL-ANO',
	CASE
		WHEN a.Data IS NULL OR a.Data = 0
			THEN CONCAT(a.Ano, '-01-01')
		ELSE a.Data
	END AS 'DATA-REGISTRO',
	a.Ementa,
	a.INTERNET
FROM 
	autografo a
	LEFT JOIN {bancowcm4}.wcm_autografos wcm4 ON wcm4.codigo_autografo_webcamara = a.Codigo
ORDER BY wcm4.aut_id DESC