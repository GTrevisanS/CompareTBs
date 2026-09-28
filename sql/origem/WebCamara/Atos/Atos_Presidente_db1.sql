SELECT
	wcm4.ato_id AS 'ID-Ato-NovoWCM',
	ap.Codigo_Individual_ano AS 'CODIGO-INDIVIDUAL-ANO',
	ap.Codigo,
	ap.Data AS 'DATA-REGISTRO',
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
	LEFT JOIN {bancowcm4}.wcm_atos wcm4 ON wcm4.codigo_atos_presidente_webcamara = ap.Codigo
ORDER BY wcm4.ato_id DESC 