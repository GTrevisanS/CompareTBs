SELECT 
	s.ses_id 'ID-WCM-ANTIGO',
	ts.tip_ses_descricao 'TIPO-SESSAO',
	CONCAT_WS('-',s.ses_codigo_individual, YEAR(s.ses_data_hora_sessao)) 'CODIGO-INDIVIDUAL-ANO',
	s.ses_nome 'NOME-SESSAO',
	s.ses_data_hora_sessao 'DATA-REGISTRO',
	s.ses_data_hora_limite_protocolo 'DATA-LIMITE-PROTOCOLO',
	s.ses_observacao 'OBSERVACOES',
	s.ses_link_video_sessao 'LINK-VIDEO-SESSAO',
	s.ses_local_sessao 'LOCAL-SESSAO',
	s.ses_mostra_online 'INTERNET'	
FROM 
	wcm_sessoes s
	LEFT JOIN wcm_tipos_sessoes ts ON ts.tip_ses_id = s.ses_tipos_sessoes_id_fk
ORDER BY
	s.ses_id DESC