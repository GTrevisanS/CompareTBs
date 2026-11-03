SELECT 
	wcm4.cad_gen_id AS 'ID-Recebido-Vereador-NovoWCM',
	CONCAT(pr.processo_numero, '-', pr.processo_ano) 'NUMERO-PROTOCOLO-NOVOWCM',
	pr.Data_Protocolo,
	-- rv.Codigo,
	rv.Codigo_Individual_Ano AS 'CODIGO-INDIVIDUAL-ANO',
	l.nome AS 'LEGISLATURA',
	rv.Assunto,
	rv.INTERNET
FROM 
	recebido_vereador rv
	LEFT JOIN legislatura l ON l.Codigo = rv.Codigo_LEGISLATURA
	LEFT JOIN protocolo pr ON pr.Num_Protocolo = rv.Num_Protocolo_PROTOCOLO
	LEFT JOIN {bancowcm4}.wcm_cadastros_genericos wcm4 ON wcm4.codigo_recebido_vereador_webcamara = rv.Codigo
ORDER BY wcm4.cad_gen_id DESC