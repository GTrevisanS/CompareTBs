SELECT
	wcm4.ofi_id AS 'ID-Oficio-Enviado-Webcamara',
	o.Codigo_Sequencial_Ano AS 'CODIGO-INDIVIDUAL-ANO',
	o.EMENTA,
	o.ORIGEM,
-- 	o.Destinatario,
	o.Resposta,
	o.texto,
	tpo.Descricao AS 'SUBTIPO',
	o.observacao AS 'OBSERVACOES',
	CASE
		WHEN o.Data IS NULL OR o.Data = 0
			THEN CONCAT(o.Ano, '-01-01')
		ELSE o.Data
	END AS 'DATA-REGISTRO',
	o.INTERNET
FROM 
	oficio o
	LEFT JOIN tipo_oficio tpo ON tpo.Codigo = o.Codigo_Tipo
	LEFT join {bancowcm4}.wcm_oficios wcm4 ON wcm4.codigo_oficio_webcamara = o.Codigo
ORDER BY 
	wcm4.ofi_id DESC