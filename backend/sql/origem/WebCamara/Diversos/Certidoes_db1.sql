SELECT 
	wcm4.div_id AS 'ID-Certidao-NovoWCM',
	c.Codigo_Individual_Ano AS 'CODIGO-INDIVIDUAL-ANO',
	c.ASSUNTO,
	tc.Descricao AS 'TIPO-CERTIDAO',
	-- c.Solicitante,
	-- l.Nome AS 'LEGISLATURA',
	-- p1.NOME AS 'NOME-PRESIDENTE',
	-- p2.NOME AS 'NOME-PREFEITO',
	c.Data as 'DATA-REGISTRO'
FROM 
	certidoes c
	LEFT JOIN politico p1 ON p1.Codigo = c.Codigo_presidente_POLITICO
	LEFT JOIN politico p2 ON p2.Codigo = c.Codigo_Prefeito_Politico
	LEFT JOIN legislatura l ON l.Codigo = c.Codigo_LEGISLATURA
	LEFT JOIN tipo_certidoes tc ON tc.Codigo = c.Codigo_TIPO_CERTIDOES
	LEFT JOIN {bancowcm4}.wcm_diversos wcm4 ON wcm4.codigo_certidoes_webcamara = c.Codigo
ORDER BY wcm4.div_id DESC