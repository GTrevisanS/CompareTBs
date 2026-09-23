SELECT 
	wcm4.ofi_id AS 'ID-Tribunal-Contas-NovoWCM',
	tc.Codigo_Individial_Ano AS 'CODIGO-INDIVIDUAL-ANO',
	l.nome AS 'LEGISLATURA',
	tc.Numero_Oficio,
	tc.Data,
	tc.Assunto,
	tc.Em_Resposta,
	tc.Em_resposta_Tipo,
	tc.Em_resposta_codigo,
	tc.INTERNET
FROM 
	tribunal_contas tc
	LEFT JOIN legislatura l ON l.Codigo = tc.Codigo_LEGISLATURA
	LEFT JOIN {bancowcm4}.wcm_oficios wcm4 ON wcm4.codigo_tribunal_contas_webcamara = tc.Codigo
ORDER BY wcm4.ofi_id DESC 