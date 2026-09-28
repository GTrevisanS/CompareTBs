SELECT 
	wcm4.por_id AS 'ID-Portaria-NovoWCM',
	p.Codigo_Individual_Ano AS 'CODIGO-INDIVIDUAL-ANO',
	p.Assunto,
	p.observacao,
	tp.Descricao AS 'TIPO-PORTARIA',
	p.data AS 'DATA-REGISTRO',
	p.data_publicacao AS 'DATA-INICIO-TRAMITACAO',
	p.orgaoimprensa,
	p.situacao,
	p.INTERNET
FROM 
	portarias p
	LEFT JOIN tipo_portaria tp ON tp.Codigo = p.Codigo_TIPO_PORTARIA
	LEFT JOIN {bancowcm4}.wcm_portarias wcm4 ON wcm4.codigo_portarias_webcamara = p.Codigo
ORDER BY wcm4.por_id DESC