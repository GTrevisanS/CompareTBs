SELECT 	
	wcm4.cad_gen_id AS 'ID-Registro-Preco-NovoWCM',
	rp.Codigo_Sequencial_Ano,
	p1.Nome AS 'NOME-PRESIDENTE',
	p2.Nome AS 'NOME-PREFEITO',
	f.Nome_completo AS 'NOME-FUNCIONARIO',
	l.Nome AS 'LEGISLATURA',
	rp.Origem,
	rp.Edital,
	rp.Objeto,
	rp.Valor_Global,
	rp.Razao_Social,
	rp.Endereco,
	rp.Fone,
	rp.CNPJ,
	rp.Representante,
	rp.Codigo_Licitacao,
	rp.Data_ata,
	rp.Email,
	rp.Situacao,
	rp.Data_inicio,
	rp.Data_termino,
	rp.internet
FROM 
	registro_preco rp
	LEFT JOIN politico p1 ON p1.Codigo = rp.Codigo_presidente_POLITICO
	LEFT JOIN politico p2 ON p2.Codigo = rp.Codigo_Prefeito_Politico
	LEFT JOIN funcionarios f ON f.Codigo = rp.codigo_funcionario
	LEFT JOIN legislatura l ON l.Codigo = rp.Codigo_LEGISLATURA
	LEFT JOIN {bancowcm4}.wcm_cadastros_genericos wcm4 ON wcm4.codigo_registro_preco_webcamara = rp.Codigo
ORDER BY wcm4.cad_gen_id DESC
