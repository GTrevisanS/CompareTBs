SELECT 
	c.Codigo_Individual_Ano AS 'CODIGO-INDIVIDUAL-ANO',
	c.EMENTA,
	c.Prazo,
	c.Data,
	0 AS 'INTERNET'
FROM 
	comunicados c
	LEFT JOIN {bancowcm4}.wcm_diversos wcm4 ON wcm4. -- nao achei
ORDER BY 
	wcm4