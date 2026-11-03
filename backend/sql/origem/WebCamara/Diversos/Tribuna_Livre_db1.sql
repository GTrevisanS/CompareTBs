SELECT
	wcm4.div_id AS 'ID-Tribuna-Livre-NovoWCM',
	tl.Codigo_Individual_Ano AS 'CODIGO-INDIVIDUAL-ANO',
	tl.Assunto,
	tl.Nome_Orador,
	tl.Endereco_Orador,
	tl.Titulo_Eleitor_Orador,
	tl.Link_Video,
	tl.Em_Resposta,
	tl.INTERNET
FROM 
	tribuna_livre tl
	LEFT JOIN {bancowcm4}.wcm_diversos wcm4 ON wcm4.codigo_tribuna_livre_webcamara = tl.Codigo
ORDER BY wcm4.div_id DESC 