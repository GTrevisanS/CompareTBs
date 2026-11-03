SELECT 
	wcm4.ata_ses_id AS 'ID-Ata-Sessao-NovoWCM',
	a.Codigo_Individual_Ano AS 'CODIGO-INDIVIDUAL-ANO',
	l.Nome AS 'LEGISLATURA',
	m.Nome AS 'MESA-DIRETORA',
	a.Tipo_Sessao,
	a.Data_Sessao,
	a.Codigo_Ata,
	a.Numero_Ata,
	a.Descricao,
	st.Descricao AS 'TRAMITACAO',
	a.observacao,
	CASE
		WHEN a.Retificacao = 'SIM' THEN 1
		ELSE 0
	END AS 'RETIFICACAO',
	a.Data_Afixacao,
	a.Data_Aprovacao,
	a.Codigo_SESSAO,
	a.Codigo_SESSAO_DELIBERACAO,
	a.Codigo_SESSAO_APRESENTACAO,
	a.INTERNET
FROM 
	ata_sessao a
	LEFT JOIN legislatura l ON l.Codigo = a.Codigo_LEGISLATURA
	LEFT JOIN mesa m ON m.Codigo = a.Codigo_MESA
	LEFT JOIN situacao_tramitacao st ON a.Codigo_SITUACAO_TRAMITACAO = st.Codigo
	LEFT JOIN {bancowcm4}.wcm_atas_sessoes wcm4 ON wcm4.codigo_ata_sessao_webcamara = a.Codigo
ORDER BY wcm4.ata_ses_id DESC