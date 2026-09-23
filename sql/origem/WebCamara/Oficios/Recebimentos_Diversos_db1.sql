SELECT 
	wcm4.ofi_id AS 'ID-Recebimento-Diverso-NovoWCM',
    CONCAT(pr.processo_numero, '-', pr.processo_ano) 'NUMERO-PROTOCOLO-NOVOWCM',
	rd.Codigo_Individual_Ano AS 'CODIGO-INDIVIDUAL-ANO',
	l.nome AS 'LEGISLATURA',
	rd.Assunto,
	rd.Tipo_Solicitacao,
	rd.nome,
	rd.observacao,
	st.Descricao AS 'TRAMITACAO',
	rd.INTERNET
FROM 
	recebimentos_diversos rd
	LEFT JOIN legislatura l ON l.Codigo = rd.Codigo_LEGISLATURA
	LEFT JOIN situacao_tramitacao st ON st.Codigo = rd.Codigo_SITUACAO_TRAMITACAO
	LEFT JOIN protocolo pr ON pr.Num_Protocolo = rd.Num_Protocolo_PROTOCOLO
	LEFT JOIN {bancowcm4}.wcm_oficios wcm4 ON wcm4.codigo_representacao_webcamara = rd.Codigo
ORDER BY wcm4.ofi_id DESC