SELECT 
	wcm4.ofi_id AS'ID-Requerimento-Recebido-NovoWCM', 
	CONCAT(pr.processo_numero, '-', pr.processo_ano) 'NUMERO-PROTOCOLO-NOVOWCM',
	pr.Data_Protocolo,
	req.codigo_Individual_ano AS 'CODIGO-INDIVIDUAL-ANO', 
	req.EMENTA, 
	req.observacao AS 'OBSERVACOES',
	req.Destinatario,
	req.Nome,
	req.INTERNET
FROM 
	requerimento_recebido req	
	LEFT JOIN protocolo pr ON pr.Num_Protocolo = req.Num_Protocolo_PROTOCOLO
	LEFT JOIN {bancowcm4}.wcm_oficios wcm4 ON wcm4.codigo_requerimento_recebido_webcamara = req.Codigo 
	-- Caso de erro novamente, verificar a coluna "codigo_requerimento_recebido_webcamara" (já que dependendo da forma que o cliente coloca a info, eles importam pra outra coluna)
ORDER BY wcm4.ofi_id DESC