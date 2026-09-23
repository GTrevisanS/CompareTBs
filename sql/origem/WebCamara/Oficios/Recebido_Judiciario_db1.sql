SELECT 
	wcm4.ofi_id AS 'ID-Oficio-NovoWCM',
	rj.Codigo_Individial_Ano AS 'CODIGO-INDIVIDUAL-ANO',
	l.nome AS 'LEGISLATURA',
	rj.Numero_Oficio,
	rj.Em_Resposta,
	rj.Assunto,
	rj.Data,
	rj.INTERNET
FROM 
	recebido_judiciario rj
	LEFT JOIN legislatura l ON l.Codigo = rj.Codigo_LEGISLATURA
	LEFT JOIN {bancowcm4}.wcm_oficios wcm4 ON wcm4.codigo_recebido_judiciario_webcamara = rj.Codigo
ORDER BY wcm4.ofi_id DESC 