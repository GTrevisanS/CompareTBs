SELECT 
	wcm4.cad_gen_id AS 'ID-Ordem-Servico-NovoWCM',
	CONCAT(pr.processo_numero, '-', pr.processo_ano) 'NUMERO-PROTOCOLO-NOVOWCM',
	pr.Data_Protocolo AS 'DATA-PROTOCOLO-NOVOWCM',
	o.Codigo_Individual_Ano AS 'CODIGO-INDIVIDUAL-ANO',
	o.EMENTA,
	o.ASSUNTO,
	o.observacao AS 'OBSERVACOES',
	CASE
	    WHEN o.`Data` IS NULL OR o.`Data` = 0 THEN
	        CASE
	            WHEN pr.Data_Protocolo IS NULL OR pr.Data_Protocolo = 0 THEN CONCAT(o.Ano, '-01-01')
	            ELSE pr.Data_Protocolo
	        END
	    ELSE o.`Data`
	END AS 'DATA-REGISTRO',
	l.Nome AS 'LEGISLATURA',
-- 	o.Codigo_Mala_Direta,
-- 	o.Processo,
-- 	o.Resposta,
-- 	o.Autoria,
-- 	o.orgaoimprensa
	0 AS 'INTERNET' -- DEFAULT 0 PQ N TEM O CAMPO
FROM 
	ordem_servico o
	LEFT JOIN {bancowcm4}.wcm_cadastros_genericos wcm4 ON wcm4.codigo_ordem_servico_webcamara = o.Codigo 
	LEFT JOIN protocolo pr ON pr.Num_Protocolo = o.Num_Protocolo_PROTOCOLO
	LEFT JOIN legislatura l ON l.Codigo = o.Codigo_Legislatura
ORDER BY
	wcm4.cad_gen_id DESC