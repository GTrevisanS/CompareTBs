SELECT
	ce.Codigo_Individual_Ano AS 'CODIGO-INDIVIDUAL-ANO',
	ce.`Data` AS 'DATA-REGISTRO',
	ce.ADICIONAIS AS 'EMENTA',
	ce.Tipo_Correspondencia AS 'SUBTIPO',
	ce.QUANTIDADE,
	ce.ORIGEM,
	ce.AR,
	ce.RESPONSAVEL,
	ce.Numero_Rastreio AS 'NUMERO-RASTREIO',
	ce.NOME,
	ce.ENDERECO,
	ce.CIDADE,
	ce.ESTADO,
	ce.CEP,
	ce.INTERNET
FROM 
	controle_correspondencias_enviadas ce
	LEFT JOIN {bancowcm4}.wcm_correspondencias wcm4 ON wcm4.codigo_controle_correspondencia_enviada_webcamara = ce.Codigo
ORDER BY
	wcm4.cor_id DESC