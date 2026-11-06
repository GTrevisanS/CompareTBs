SELECT 	
	wcm4.cad_gen_id AS 'ID-Registro-Preco-NovoWCM',
	rp.Codigo_Sequencial_Ano AS 'CODIGO-INDIVIDUAL-ANO',
	p1.Nome AS 'NOME-PRESIDENTE',
	p2.Nome AS 'NOME-PREFEITO',
	f.Nome_completo AS 'NOME-FUNCIONARIO',
	l.Nome AS 'LEGISLATURA',
	rp.ORIGEM,
	rp.EDITAL,
	rp.OBJETO AS 'EMENTA',
	rp.Valor_Global AS 'VALOR',
	rp.Razao_Social AS 'RAZAO-SOCIAL',
	rp.Endereco AS 'ENDERECO',
	rp.Fone AS 'TELEFONE',
	rp.CNPJ AS 'CNPJ',
	rp.Representante AS 'REPRESENTANTE',
	rp.Codigo_Licitacao AS 'CODIGO-LICITACAO',
	rp.Data_ata AS 'DATA-ATA',
	rp.Email AS 'EMAIL',
	rp.Situacao AS 'SITUACAO-TRAMITACAO',
	rp.Data_inicio AS 'DATA-INICIO',
	rp.Data_termino AS 'DATA-FIM',
	rp.INTERNET
FROM 
	registro_preco rp
	LEFT JOIN politico p1 ON p1.Codigo = rp.Codigo_presidente_POLITICO
	LEFT JOIN politico p2 ON p2.Codigo = rp.Codigo_Prefeito_Politico
	LEFT JOIN funcionarios f ON f.Codigo = rp.codigo_funcionario
	LEFT JOIN legislatura l ON l.Codigo = rp.Codigo_LEGISLATURA
	LEFT JOIN {bancowcm4}.wcm_cadastros_genericos wcm4 ON wcm4.codigo_registro_preco_webcamara = rp.Codigo
ORDER BY 
	wcm4.cad_gen_id DESC
