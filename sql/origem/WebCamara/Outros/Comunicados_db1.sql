SELECT 
	c.Codigo_Individual_Ano AS 'CODIGO-INDIVIDUAL-ANO',
	c.Ementa,
	c.Prazo,
	c.Data
FROM 
	comunicados c
-- 	LEFT JOIN wcm_4_terrarica. wcm4 ON wcm4.
ORDER BY wcm4.