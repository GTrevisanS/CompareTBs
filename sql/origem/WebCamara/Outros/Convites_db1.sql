SELECT
	wcm4.con_id AS 'ID-Convite-NovoWCM',
	CONCAT(pr.processo_numero, '-', pr.processo_ano) 'NUMERO-PROTOCOLO-NOVOWCM',
	c.Codigo_Individial_Ano AS 'CODIGO-INDIVIDUAL-ANO',
	c.Assunto,
	c.Ano,
	c.Numero_Oficio,
	CASE
		WHEN (c.Data IS NULL AND pr.Data_Protocolo IS NULL) 
			OR (c.Data = 0 AND pr.Data_Protocolo IS NULL)
			OR (c.Data IS NULL AND pr.Data_Protocolo = 0)
			OR (c.Data = 0 AND pr.Data_Protocolo = 0)
			THEN CONCAT(c.Ano, '-01-01')
		WHEN c.Data IS NULL THEN pr.Data_Protocolo
		WHEN c.Data = 0 THEN pr.Data_Protocolo
		ELSE CONCAT(c.Data," ", c.Hora_Evento)
	END AS 'DATA-REGISTRO',
	c.Em_Resposta,
	c.Em_resposta_Tipo,
	c.Em_resposta_codigo,
	c.Data_Evento,
	c.Local_Endereco,
	c.REPRESENTANTE,
	c.INTERNET
FROM 
	convite c
	LEFT JOIN protocolo pr ON pr.Num_Protocolo = c.Num_Protocolo_PROTOCOLO
	LEFT JOIN {bancowcm4}.wcm_convites wcm4 ON wcm4.codigo_convite_webcamara = c.Codigo
ORDER BY 
	wcm4.con_id DESC