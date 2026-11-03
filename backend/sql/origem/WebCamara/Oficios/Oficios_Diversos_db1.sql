SELECT 
	wcm4.ofi_id AS 'ID-Oficio-Diverso-NovoWCM',
	od.Codigo_Individual_Ano AS 'CODIGO-INDIVIDUAL-ANO',
	l.nome AS 'LEGISLATURA',
	od.ASSUNTO,
	od.observacao AS 'OBSERVACOES',
	od.Numero_Oficio,
	CASE
		WHEN od.Data IS NULL then wcm4.ofi_data_hora
		WHEN od.Data = 0 then wcm4.ofi_data_hora
		ELSE od.Data
	END AS 'DATA-REGISTRO',
	od.Em_resposta_codigo,
	od.Em_resposta_Tipo,
	od.Em_Resposta,
	od.INTERNET
FROM 
	oficios_diversos od
	LEFT JOIN legislatura l ON l.Codigo = od.Codigo_LEGISLATURA
	LEFT JOIN {bancowcm4}.wcm_oficios wcm4 ON wcm4.codigo_oficios_diversos_webcamara = od.Codigo
ORDER BY
	wcm4.ofi_id DESC