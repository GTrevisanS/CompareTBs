SELECT 
	wcm4.fin_id AS 'ID-Prestacao-Conta-NovoWCM',
	CONCAT(pr.processo_numero, '-', pr.processo_ano) 'NUMERO-PROTOCOLO-NOVOWCM',
	pr.Data_Protocolo,
	p.Codigo_Individual_Ano AS 'CODIGO-INDIVIDUAL-ANO',
	p.RESPONSAVEL,
	p.IMPORTANCIA,
	-- p.Empenho,
	-- p.Memorando,
	-- p.Categoria_Economica,
	-- p.Dotacao,
	p.ASSUNTO,
	p.INTERNET
FROM 
	prestacao_contas p    
	LEFT JOIN protocolo pr ON pr.Num_Protocolo = p.Num_Protocolo_PROTOCOLO
	LEFT JOIN {bancowcm4}.wcm_financas wcm4 ON wcm4.codigo_prestacao_contas_webcamara = p.Codigo
ORDER BY 	
	wcm4.fin_id DESC