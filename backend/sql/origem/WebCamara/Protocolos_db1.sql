SELECT 
	wcm4.pro_id AS 'ID-Protocolo-NovoWCM',
	tp.Nome AS 'TIPO-PROTOCOLO-WEBCAMARA',
	p.CODIGO_TIPO,
	p.processo_numero,
	p.processo_ano,
	p.Data_Protocolo,
	p.Anulado,
	p.Criado,
	p.Motivo_Anulacao,
	p.Motivo_Reativacao,
	p.ementa,
	-- p.observacao,
	-- p.obs_protocolo,
	p.usuario as 'RESPONSAVEL-PROTOCOLO-WEBCAMARA'
FROM
	protocolo p
	LEFT JOIN {bancowcm4}.wcm_protocolos wcm4 ON wcm4.codigo_protocolo_webcamara = p.Num_Protocolo
	LEFT JOIN tipo_protocolo tp ON tp.Codigo = p.Codigo_TIPO_PROTOCOLO

WHERE wcm4.pro_id IS NOT null
ORDER BY wcm4.pro_id desc