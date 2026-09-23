SELECT
	ws.codigo_sessao_importado,
	ws.ses_nome,
	ws.ses_codigo_individual,
	ws.ses_data_hora_sessao,
	wts.tip_ses_descricao_singular,
	ws.ses_observacao,
	ws.ses_mostra_online
FROM 
	wcm_sessoes ws
	LEFT JOIN wcm_tipos_sessoes wts ON wts.tip_ses_id = ws.ses_tipo_sessao_id_fk
WHERE -- Adicionei um where pra ignorar o codigo 0 (que sempre será da sessão para votações sem vinculo)
	ws.codigo_sessao_importado != 0
ORDER BY 
	ws.codigo_sessao_importado DESC