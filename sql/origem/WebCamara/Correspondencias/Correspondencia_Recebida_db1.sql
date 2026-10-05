SELECT 
	wcm4.cor_id AS 'ID-Correspondencia-NovoWCM',
	CONCAT(pr.processo_numero, '-', pr.processo_ano) 'NUMERO-PROTOCOLO-NOVOWCM',
	cr.Codigo_Individual_Ano AS 'CODIGO-INDIVIDUAL-ANO',
	cr.Numero_Correspondencia 'NUMERO-CORRESPONDENCIA',
	cr.Tipo_Correspondencia AS 'SUBTIPO',
	cr.Em_Resposta,
	cr.REMETENTE,
	cr.ASSUNTO,
	cr.observacao AS 'OBSERVACOES',
	cr.classificacao,
	cr.Nome AS 'RESPONSAVEL-CORRESPONDENCIA',
	cr.Endereco,
	cr.instituicao,
	cr.codigo_cidade,
	cr.estado,
	cr.codigo_bairro,
	cr.cep,
	cr.Cargo_Remetente,
	cr.Numero_origem,
	CASE
		WHEN (cr.Data IS NULL AND pr.Data_Protocolo IS NULL) 
			OR (cr.Data = 0 AND pr.Data_Protocolo IS NULL)
			OR (cr.Data IS NULL AND pr.Data_Protocolo = 0)
			OR (cr.Data = 0 AND pr.Data_Protocolo = 0)
			THEN CONCAT(cr.Ano, '-01-01')
	 	WHEN cr.Data IS NULL THEN pr.Data_Protocolo
		WHEN cr.Data = 0 THEN pr.Data_Protocolo
		ELSE cr.Data
	END AS 'DATA-REGISTRO',
	cr.INTERNET
FROM 	 
	correspondencias_recebidas cr
	LEFT JOIN protocolo pr ON pr.Num_Protocolo = cr.Num_Protocolo_PROTOCOLO
	LEFT JOIN {bancowcm4}.wcm_correspondencias wcm4 ON wcm4.codigo_correspondencia_recebidas_webcamara = cr.Codigo
ORDER BY 
	wcm4.cor_id DESC