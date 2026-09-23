SELECT
	wcm4.ato_id AS 'ID-Ato-NovoWCM',
	am.Codigo_Individual_ano AS 'CODIGO-INDIVIDUAL-ANO',
	am.Data,
	am.Assunto,
	leg.Nome AS 'LEGISLATURA',
	am.situacao,
	am.observacao,
	am.orgaoimprensa,
	am.INTERNET
FROM 
	atos_mesa am
	LEFT JOIN legislatura leg ON leg.Codigo = am.Codigo_LEGISLATURA
	LEFT JOIN {bancowcm4}.wcm_atos wcm4 ON wcm4.codigo_atos_mesa_webcamara = am.Codigo
ORDER BY wcm4.ato_id DESC 