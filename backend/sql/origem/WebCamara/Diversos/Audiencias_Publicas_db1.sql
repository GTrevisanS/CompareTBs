SELECT
	wcm4.aud_pub_id AS 'ID-Audiencia-Publica-NovoWCM',
	CONCAT(pr.processo_numero, '-', pr.processo_ano) 'NUMERO-PROTOCOLO-NOVOWCM',
	au.Codigo_Individual_Ano AS 'CODIGO-INDIVIDUAL-ANO',
	l.nome AS 'LEGISLATURA',
	au.Pub_Jornal1,
	au.Pub_Data1,
	au.Pub_Jornal2,
	au.Pub_Data2,
	au.EMENTA,
	CASE
		WHEN (au.Data_Audiencia IS NULL AND pr.Data_Protocolo IS NULL) 
			OR (au.Data_Audiencia = 0 AND pr.Data_Protocolo IS NULL)
			OR (au.Data_Audiencia IS NULL AND pr.Data_Protocolo = 0)
			OR (au.Data_Audiencia = 0 AND pr.Data_Protocolo = 0)
			THEN CONCAT(YEAR(au.Data_Audiencia), '-01-01')
		WHEN au.Data_Audiencia IS NULL THEN pr.Data_Protocolo
		WHEN au.Data_Audiencia = 0 THEN pr.Data_Protocolo
		ELSE CONCAT(au.Data_Audiencia, ' ', au.Hora_Audiencia)
	END AS 'DATA-REGISTRO',
	au.Tipo_legislacao,
	au.Link,
	au.INTERNET
FROM 
	audiencia_publica au
	LEFT JOIN {bancowcm4}.wcm_audiencias_publicas wcm4 ON wcm4.codigo_audiencia_publica_webcamara = au.Codigo
	LEFT JOIN legislatura l ON l.Codigo = au.Codigo_LEGISLATURA
	LEFT JOIN protocolo pr ON pr.Num_Protocolo = au.Num_Protocolo_PROTOCOLO
ORDER BY 
	wcm4.aud_pub_id DESC