SELECT
    wcm4.ate_id AS 'CODIGO-ATESTADO-WEBCAMARA',
    CONCAT(pr.processo_numero, '-', pr.processo_ano) 'NUMERO-PROTOCOLO-NOVOWCM',
    ats.Codigo_Individual_Ano AS 'CODIGO-INDIVIDUAL-ANO',
    ats.Assunto,
    tpa.Descricao AS 'TIPO-ATESTADO',
    CASE
	 	WHEN ats.Data IS NULL THEN pr.Data_Protocolo
		WHEN ats.Data = 0 THEN pr.Data_Protocolo
    	ELSE ats.Data
    END AS 'Data_Inicio_Tramitacao'
    -- l.Nome AS 'LEGISLATURA'
FROM
    atestado ats
    LEFT JOIN tipo_atestado tpa ON tpa.Codigo = ats.Codigo_Tipo_atestado    
	-- LEFT JOIN legislatura l ON l.Codigo = ats.Codigo_LEGISLATURA
    LEFT JOIN protocolo pr ON pr.Num_Protocolo = ats.Num_Protocolo_PROTOCOLO
    LEFT JOIN {bancowcm4}.wcm_atestados wcm4 ON wcm4.codigo_atestado_webcamara = ats.Codigo
ORDER BY wcm4.ate_id DESC