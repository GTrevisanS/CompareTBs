SELECT
	wcm4.ato_id AS 'ID-Ato-NovoWCM',
	CONCAT(pr.processo_numero, '-', pr.processo_ano) 'NUMERO-PROTOCOLO-NOVOWCM',
	ap.Codigo_Individual_ano AS 'CODIGO-INDIVIDUAL-ANO',
	ap.Codigo,
	CASE
		WHEN (ap.Data IS NULL AND pr.Data_Protocolo IS NULL) 
			OR (ap.Data = 0 AND pr.Data_Protocolo IS NULL)
			OR (ap.Data IS NULL AND pr.Data_Protocolo = 0)
			OR (ap.Data = 0 AND pr.Data_Protocolo = 0)
			THEN CONCAT(ap.Ano, '-01-01')
	 	WHEN ap.Data IS NULL THEN pr.Data_Protocolo
		WHEN ap.Data = 0 THEN pr.Data_Protocolo
		ELSE ap.Data
	END AS 'DATA-REGISTRO',
	ap.Assunto,
	l.Nome AS 'LEGISLATURA',
	ap.situacao,
	ap.observacao,
	ap.data_publicacao,
	ap.orgaoimprensa,
	ap.INTERNET
FROM 
	atos_presidente ap
	LEFT JOIN legislatura l ON l.Codigo = ap.Codigo_LEGISLATURA
	LEFT JOIN protocolo pr ON pr.Num_Protocolo = ap.Num_Protocolo_PROTOCOLO
	LEFT JOIN {bancowcm4}.wcm_atos wcm4 ON wcm4.codigo_atos_presidente_webcamara = ap.Codigo
ORDER BY wcm4.ato_id DESC