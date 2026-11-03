SELECT
    cg.cad_gen_id AS 'ID-Protocolo-Dinamico-NovoWCM',
    pd.Codigo_Individual_Ano AS 'CODIGO-INDIVIDUAL-ANO',
    pd.Assunto 'ASSUNTO',
    CASE
        WHEN pd.Data IS NULL THEN cg.cad_gen_data_hora
        WHEN pd.Data = 0 THEN cg.cad_gen_data_hora
        ELSE pd.Data
    END AS 'DATA-REGISTRO',
    CASE
        WHEN l.Nome IS NULL THEN leg.leg_descricao
        ELSE l.Nome
    END AS 'LEGISLATURA',
    pd.observacao 'OBSERVACOES',
    CASE
        WHEN pd.data_recebimento IS NOT NULL 
		  		AND pd.data_recebimento != 0  
				THEN pd.data_recebimento
				
        WHEN cg.cad_gen_data_inicio IS NOT NULL
            AND cg.cad_gen_data_inicio != 0
            THEN cg.cad_gen_data_inicio

        ELSE CONCAT(pd.Ano, '-01-01')
    END AS 'DATA-INICIO-TRAMITACAO',
    CASE
        WHEN pd.data_retorno IS NOT NULL 
		  		AND pd.data_retorno != 0  
				THEN pd.data_retorno
				
        WHEN cg.cad_gen_data_fim IS NOT NULL
            AND cg.cad_gen_data_fim != 0
            THEN cg.cad_gen_data_fim
        ELSE CONCAT(pd.Ano, '-01-01')
    END AS 'DATA-LIMITE-TRAMITACAO',
    pd.destinatario 'DESTINATARIO',
    pd.tipo_documento 'SUBTIPO',
    -- pd.numero_digitavel '',
    pd.INTERNET
FROM 
	protocolo_dinamico_4 pd
	LEFT JOIN legislatura l ON l.Codigo = pd.Codigo_Legislatura
	LEFT JOIN {bancowcm4}.wcm_cadastros_genericos cg ON cg.codigo_protocolo_dinamico_4_webcamara = pd.Codigo
	LEFT JOIN {bancowcm4}.wcm_legislaturas leg ON leg.leg_id = cg.cad_gen_legislaturas_id_fk
ORDER BY cg.cad_gen_id DESC;