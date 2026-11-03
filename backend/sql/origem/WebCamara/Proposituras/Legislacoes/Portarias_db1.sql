SELECT 
	wcm4.por_id AS 'ID-Portaria-NovoWCM',
	p.Codigo_Individual_Ano AS 'CODIGO-INDIVIDUAL-ANO',
	p.ASSUNTO,
	p.observacao AS 'OBSERVACOES',
	tp.Descricao AS 'SUBTIPO',
	p.orgaoimprensa AS 'ORGAO-IMPRENSA',
	p.edicao AS 'EDICAO',
	pol.Nome AS 'PRESIDENTE',
	p.situacao AS 'SITUACAO-TRAMITACAO',
	p.data AS 'DATA-REGISTRO',
	p.data_publicacao AS 'DATA-INICIO-TRAMITACAO',
	p.INTERNET
FROM 
	portarias p
	LEFT JOIN tipo_portaria tp ON tp.Codigo = p.Codigo_TIPO_PORTARIA
	LEFT JOIN politico pol ON pol.Codigo = p.Codigo_presidente_POLITICO
	LEFT JOIN {bancowcm4}.wcm_portarias wcm4 ON wcm4.codigo_portarias_webcamara = p.Codigo
ORDER BY 
	wcm4.por_id DESC