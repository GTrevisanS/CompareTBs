SELECT
    wcm4.edi_id AS edi_id,
    e.codigo_individual_ano AS 'CODIGO-INDIVIDUAL-ANO',
    e.assunto,
    te.Descricao AS "tipo edital",
    tl.descricao AS "tipo licitacao",
    sl.Descricao AS "situacao licitacao",
    e.numero_licitacao,
    e.Data,
	e.INTERNET
FROM
    editais e
    LEFT JOIN tipo_editais te ON te.Codigo = e.Codigo_TIPO_EDITAIS
    LEFT JOIN tipo_licitacao tl ON tl.codigo = e.Codigo_Tipo_Licitacao
    LEFT JOIN situacao_licitacao sl ON sl.Codigo = e.Codigo_Situacao_Licitacao
    LEFT JOIN politico po ON po.Codigo = e.Codigo_presidente_POLITICO
    LEFT JOIN {bancowcm4}.wcm_editais wcm4 ON wcm4.codigo_editais_webcamara = e.Codigo
    
UNION ALL -- Utilizo o Union all para "Concatenar" os registros das duas tabelas

SELECT
	wcm4.edi_id AS edi_id,
	ec.Codigo_Individual_Ano AS 'CODIGO-INDIVIDUAL-ANO',
	ec.Descricao,
	'convocacao',
	NULL, -- Já que a segunda tabela não salva todos os mesmos dados que a primeira, preciso trazer as colunas como null para não dar erro
	NULL,
	NULL,
	ec.Data,
	ec.INTERNET
FROM 
	edital_convocacao ec
	LEFT JOIN {bancowcm4}.wcm_editais wcm4 ON wcm4.codigo_edital_convocacao_webcamara = ec.Codigo
WHERE edi_id IS NOT null

ORDER BY edi_id DESC