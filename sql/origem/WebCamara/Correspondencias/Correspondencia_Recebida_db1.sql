SELECT 
	wcm4.cor_id AS 'ID-Correspondencia-NovoWCM',
	cr.Codigo_Individual_Ano AS 'CODIGO-INDIVIDUAL-ANO',
	cr.Numero_Correspondencia,
	cr.Tipo_Correspondencia,
	cr.Em_Resposta,
	cr.Remetente,
	cr.Assunto,
	cr.observacao,
	cr.classificacao,
	cr.Nome as 'RESPONSAVEL-CORRESPONDENCIA',
	cr.Endereco,
	cr.instituicao,
	cr.codigo_cidade,
	cr.estado,
	cr.codigo_bairro,
	cr.cep,
	cr.Cargo_Remetente,
	cr.Numero_origem,
	cr.Data,
	cr.INTERNET
FROM 	 
	correspondencias_recebidas cr
	LEFT JOIN {bancowcm4}.wcm_correspondencias wcm4 ON wcm4.codigo_correspondencia_recebidas_webcamara = cr.Codigo
ORDER BY wcm4.cor_id DESC