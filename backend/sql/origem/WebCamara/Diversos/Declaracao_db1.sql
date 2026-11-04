SELECT 
	wcm4.div_id AS 'ID-Declaracao-NovoWCM',
	d.Codigo_Individual_Ano AS 'CODIGO-INDIVIDUAL-ANO',
	d.ASSUNTO,
	td.Descricao AS 'TIPO-DECLARACAO',
	d.Data AS 'DATA-REGISTRO',
	0 AS 'INTERNET' -- Crio uma coluna para confirmar que será importado sem internet ativo no NovoWCM
FROM 
	declaracao d
	LEFT JOIN tipo_declaracao td ON td.Codigo = d.Codigo_Tipo_declaracao
	LEFT JOIN {bancowcm4}.wcm_diversos wcm4 ON wcm4.codigo_declaracao_webcamara = d.Codigo
ORDER BY 
    wcm4.div_id DESC