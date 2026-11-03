SELECT
	wcm4.cad_gen_id AS 'ID-Protocolo-Municipe-NovoWCM',
    CONCAT(pr.processo_numero, '-', pr.processo_ano) 'NUMERO-PROTOCOLO-NOVOWCM',
	pc.Codigo_Individual_Ano AS 'CODIGO-INDIVIDUAL-ANO',
	pc.ASSUNTO,
	pc.TEXTO AS 'EMENTA',
	pc.Observacao AS 'OBSERVACOES',
	CONCAT_WS(' ', pc.Data, pc.Hora) AS 'DATA-REGISTRO',
	st.Descricao AS 'SITUACAO-TRAMITACAO',
	pc.Autor_Solicitante AS 'SOLICITANTE',
	pc.CPF_Autor AS 'CPF-SOLICITANTE',
	pc.EMISSOR,
	pc.VALOR,
-- 	pc.Codigo_Departamento_Responsavel,
-- 	pc.Setor_de_Encaminhamento,
	pc.INTERNET
FROM 
	protocolo_configuravel pc 
	LEFT JOIN protocolo pr ON pr.Num_Protocolo = pc.Num_Protocolo_PROTOCOLO
	LEFT JOIN situacao_tramitacao st ON pc.Codigo_Situacao_Tramitacao_Protocolo_Configuravel = st.Codigo
	LEFT JOIN {bancowcm4}.wcm_cadastros_genericos wcm4 ON wcm4.codigo_protocolo_municipe_webcamara = pc.Codigo
ORDER BY 
	wcm4.cad_gen_id DESC 