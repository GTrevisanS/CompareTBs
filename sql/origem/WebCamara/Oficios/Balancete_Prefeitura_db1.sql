SELECT 
	wcm4.ofi_id AS 'ID-Oficio-NovoWCM',
	CONCAT(pr.processo_numero, '-', pr.processo_ano) 'NUMERO-PROTOCOLO-NOVOWCM',
	bp.Codigo_Individial_Ano AS 'CODIGO-INDIVIDUAL-ANO',
	-- bp.Codigo,
	l.nome AS 'LEGISLATURA',
	bp.Numero_Oficio,
	CASE
		WHEN (bp.Data IS NULL AND pr.Data_Protocolo IS NULL) 
			OR (bp.Data = 0 AND pr.Data_Protocolo IS NULL)
			OR (bp.Data IS NULL AND pr.Data_Protocolo = 0)
			OR (bp.Data = 0 AND pr.Data_Protocolo = 0)
			THEN CONCAT(bp.Ano, '-01-01')
	 	WHEN bp.Data IS NULL THEN pr.Data_Protocolo
		WHEN bp.Data = 0 THEN pr.Data_Protocolo
		ELSE bp.Data
	END AS 'DATA-REGISTRO',
	bp.Assunto,
	bp.INTERNET
FROM 	 
	balancete_prefeitura bp
	LEFT JOIN legislatura l ON l.Codigo = bp.Codigo_LEGISLATURA
	LEFT JOIN protocolo pr ON pr.Num_Protocolo = bp.Num_Protocolo_PROTOCOLO
	LEFT JOIN {bancowcm4}.wcm_oficios wcm4 ON wcm4.codigo_balancete_prefeitura_webcamara = bp.Codigo
ORDER BY wcm4.ofi_id DESC