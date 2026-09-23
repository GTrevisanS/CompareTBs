SELECT 
	wcm4.fin_id AS 'ID-Relatorio-Viagem-NovoWCM',
	rv.Codigo_Individual_Ano AS 'CODIGO-INDIVIDUAL-ANO',
	l.Nome AS 'LEGISLATURA',
	rv.Finalidade,
	rv.Requisitante,
	rv.Data_Entrega_Relatorio,
	rv.Data_Retorno,
	rv.Localidade,
	rv.valor_requisitado,
	rv.valor_utilizado,
	rv.valor_devolvido,
	rv.valor_excedente,
	rv.comprovante_despesas,
	rv.INTERNET
FROM 
	relatorio_viagem rv
	LEFT JOIN legislatura l ON l.Codigo = rv.Codigo_LEGISLATURA
	LEFT JOIN {bancowcm4}.wcm_financas wcm4 ON wcm4.codigo_relatorio_viagem_webcamara = rv.Codigo
ORDER BY
	wcm4.fin_id desc