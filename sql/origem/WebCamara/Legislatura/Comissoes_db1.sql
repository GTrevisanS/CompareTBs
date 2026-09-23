SELECT 
	wcm4.com_per_id AS 'ID-Comissao-NovoWCM',
	c.Nome,
	c.Sigla,
	l.Nome AS 'LEGISLATURA',
	c.Periodo,
	c.Data_Inicial,
	c.Data_Final,
	c.Atribuicao,
	c.Observacoes,
	GROUP_CONCAT(p.Nome SEPARATOR '___') AS 'MEMBROS-COMISSAO-WEBCAMARA'
FROM 
	comissao c
	LEFT JOIN legislatura l ON l.Codigo = c.Codigo_LEGISLATURA
	LEFT JOIN {bancowcm4}.wcm_comissoes_permanentes wcm4 ON wcm4.codigo_comissao_permanente_webcamara = c.Codigo
	LEFT JOIN comissao_legislatura cl ON cl.Codigo_COMISSAO = c.Codigo
	LEFT JOIN politico p ON p.Codigo = cl.Codigo_POLITICO
GROUP BY c.Codigo
ORDER BY wcm4.com_per_id DESC 
