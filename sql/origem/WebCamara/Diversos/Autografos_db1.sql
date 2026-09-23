SELECT
	wcm4.aut_id AS 'ID-Autografo-NovoWCM',
	a.Codigo_Individual_Ano AS 'CODIGO-INDIVIDUAL-ANO',
	a.Data,
	a.Ementa,
	a.INTERNET
FROM 
	autografo a
	LEFT JOIN {bancowcm4}.wcm_autografos wcm4 ON wcm4.codigo_autografo_webcamara = a.Codigo
ORDER BY wcm4.aut_id DESC