SELECT
	(SELECT COUNT(*) FROM comissao) + c.Codigo AS 'ID-Comissao-Temporaria-NovoWCM',
	-- Na linha acima, somo o numero maior das comissões permanentes e gero os numeros apartir disso.
	-- Exemplo, se tiver 20 permanentes, a primeira comissão temporária tera o ID como 21
	c.Nome AS 'NOME-COMISSAO',
	c.SIGLA,
	l.Nome AS 'LEGISLATURA',
	c.BIENIO,
	c.FINALIDADE,
	c.INSTITUICAO,
	c.Atribuicao AS 'ATRIBUICOES',
	c.Observacao AS 'OBSERVACOES',
	c.SITUACAO,
	c.CONCLUSAO,
	c.PERIODO,
	c.INICIO AS 'DATA-INICIO',
	c.Termino AS 'DATA-FIM',
	c.ATIVO,
	GROUP_CONCAT(p2.Nome SEPARATOR '___') AS 'MEMBROS-COMISSAO-WEBCAMARA'
FROM 
	comissao_temporaria c
	LEFT JOIN legislatura l ON l.Codigo = c.Codigo_LEGISLATURA
	LEFT JOIN comissao_legislatura_temporaria clt ON clt.Codigo_COMISSAO_TEMPORARIA = c.Codigo
	LEFT JOIN politico p2 ON p2.Codigo = clt.Codigo_POLITICO
GROUP BY c.Codigo
ORDER BY c.Codigo DESC