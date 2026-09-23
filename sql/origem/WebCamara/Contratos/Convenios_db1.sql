SELECT 
	wcm4.con_id AS 'ID-Convenio-NovoWCM',	
	c.Codigo_Sequencial_Ano AS 'CODIGO-INDIVIDUAL-ANO',
	p1.Nome AS 'NOME-PRESIDENTE',
	p2.Nome AS 'NOME-PREFEITO',
	l.Nome AS 'LEGISLATURA',
	c.Origem,
	c.Edital,
	c.Objeto,
	c.Valor_Global,
	c.Razao_Social,
	c.Endereco,
	c.Fone,
	c.CNPJ,
	c.Representante,
	c.Codigo_Licitacao,
	c.Data_inicio,
	c.Data_termino,
	c.Data_Convenio,
	c.INTERNET
FROM 
	convenios c
	LEFT JOIN politico p1 ON p1.Codigo = c.Codigo_presidente_POLITICO
	LEFT JOIN politico p2 ON p2.Codigo = c.Codigo_Prefeito_Politico
	LEFT JOIN legislatura l ON l.Codigo = c.Codigo_LEGISLATURA
	LEFT JOIN {bancowcm4}.wcm_contratos wcm4 ON wcm4.codigo_convenios_webcamara = c.Codigo
ORDER BY wcm4.con_id desc