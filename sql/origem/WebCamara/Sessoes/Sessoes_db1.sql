SELECT 
	wcm4.ses_id AS 'ID-Sessao-NovoWCM',
	s.Nome AS 'NOME-SESSAO',
	CONCAT_WS('-',s.Codigo_Individual, s.Ano)AS 'CODIGO-INDIVIDUAL-ANO',
	CONCAT_WS(' ', s.Data, s.Hora)AS 'DATA-REGISTRO',
	ts.nome_tipo_sessao,
	s.observacao AS 'OBSERVACOES',
	s.INTERNET
FROM 
	sessao s
	LEFT JOIN tipo_sessao ts ON ts.Codigo = s.tipo
	LEFT JOIN {bancowcm4}.wcm_sessoes wcm4 ON wcm4.codigo_sessao_webcamara = s.Codigo
ORDER BY 
	wcm4.ses_id DESC