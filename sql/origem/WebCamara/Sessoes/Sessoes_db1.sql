SELECT 
	wcm4.ses_id AS 'ID-Sessao-NovoWCM',
	s.Nome,
	s.Codigo_Individual AS 'CODIGO-INDIVIDUAL-ANO',
	s.Data,
	s.Hora,
	ts.nome_tipo_sessao,
	s.observacao,
	s.INTERNET
FROM 
	sessao s
	LEFT JOIN tipo_sessao ts ON ts.Codigo = s.tipo
	LEFT JOIN {bancowcm4}.wcm_sessoes wcm4 ON wcm4.codigo_sessao_webcamara = s.Codigo
ORDER BY 
	wcm4.ses_id DESC