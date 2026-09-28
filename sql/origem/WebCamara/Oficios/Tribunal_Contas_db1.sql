SELECT 
	wcm4.ofi_id AS 'ID-Tribunal-Contas-NovoWCM',
	CONCAT(pr.processo_numero, '-', pr.processo_ano) 'NUMERO-PROTOCOLO-NOVOWCM',
	tc.Codigo_Individial_Ano AS 'CODIGO-INDIVIDUAL-ANO',
	l.nome AS 'LEGISLATURA',
	tc.Numero_Oficio,
	CASE
		WHEN (tc.Data IS NULL AND pr.Data_Protocolo IS NULL) 
			OR (tc.Data = 0 AND pr.Data_Protocolo IS NULL)
			OR (tc.Data IS NULL AND pr.Data_Protocolo = 0)
			OR (tc.Data = 0 AND pr.Data_Protocolo = 0)
			THEN CONCAT(tc.Ano, '-01-01')
	 	WHEN tc.Data IS NULL THEN pr.Data_Protocolo
		WHEN tc.Data = 0 THEN pr.Data_Protocolo
		ELSE tc.Data
	END AS 'DATA-REGISTRO',
	tc.Assunto,
	tc.Em_Resposta,
	tc.Em_resposta_Tipo,
	tc.Em_resposta_codigo,
	tc.INTERNET
FROM 
	tribunal_contas tc
	LEFT JOIN legislatura l ON l.Codigo = tc.Codigo_LEGISLATURA
	LEFT JOIN protocolo pr ON pr.Num_Protocolo = tc.Num_Protocolo_PROTOCOLO
	LEFT JOIN {bancowcm4}.wcm_oficios wcm4 ON wcm4.codigo_tribunal_contas_webcamara = tc.Codigo
ORDER BY wcm4.ofi_id DESC