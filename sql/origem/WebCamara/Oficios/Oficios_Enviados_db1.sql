SELECT
	wcm4.ofi_id AS 'ID-Oficio-Enviado-Webcamara',
	o.Codigo_Sequencial_Ano AS 'CODIGO-INDIVIDUAL-ANO',
	o.Ementa,
	o.Origem,
-- 	o.Destinatario,
	tpo.Descricao AS 'SUBTIPO-OFICIO',
	o.Resposta,
	o.texto,
	o.observacao,
	o.Data AS 'DATA-REGISTRO',
	o.INTERNET
FROM 
	oficio o
	LEFT JOIN tipo_oficio tpo ON tpo.Codigo = o.Codigo_Tipo
	LEFT JOIN {bancowcm4}.wcm_oficios wcm4 ON wcm4.codigo_oficio_webcamara = o.Codigo
ORDER BY wcm4.ofi_id DESC  