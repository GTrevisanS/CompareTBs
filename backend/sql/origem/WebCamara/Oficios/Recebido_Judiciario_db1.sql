SELECT 
	wcm4.ofi_id AS 'ID-Oficio-NovoWCM',
	CONCAT(pr.processo_numero, '-', pr.processo_ano) 'NUMERO-PROTOCOLO-NOVOWCM',
	rj.Codigo_Individial_Ano AS 'CODIGO-INDIVIDUAL-ANO',
	l.nome AS 'LEGISLATURA',
	rj.Numero_Oficio,
	rj.Em_Resposta,
	rj.Assunto,
	CASE
		WHEN (rj.Data IS NULL AND pr.Data_Protocolo IS NULL) 
			OR (rj.Data = 0 AND pr.Data_Protocolo IS NULL)
			OR (rj.Data IS NULL AND pr.Data_Protocolo = 0)
			OR (rj.Data = 0 AND pr.Data_Protocolo = 0)
			THEN CONCAT(rj.Ano, '-01-01')
	 	WHEN rj.Data IS NULL THEN pr.Data_Protocolo
		WHEN rj.Data = 0 THEN pr.Data_Protocolo
		ELSE rj.Data
	END AS 'DATA-REGISTRO',
	rj.INTERNET
FROM 
	recebido_judiciario rj
	LEFT JOIN legislatura l ON l.Codigo = rj.Codigo_LEGISLATURA
	LEFT JOIN protocolo pr ON pr.Num_Protocolo = rj.Num_Protocolo_PROTOCOLO
	LEFT JOIN {bancowcm4}.wcm_oficios wcm4 ON wcm4.codigo_recebido_judiciario_webcamara = rj.Codigo
ORDER BY wcm4.ofi_id DESC