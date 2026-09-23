SELECT
    cg.cad_gen_id AS 'ID-Protocolo-Dinamico-NovoWCM',
    pd.Codigo_Individual_Ano AS 'CODIGO-INDIVIDUAL-ANO',
    pd.Assunto,
    CASE
        WHEN pd.Data IS NULL THEN cg.cad_gen_data_hora
        WHEN pd.Data = 0 THEN cg.cad_gen_data_hora
        ELSE pd.Data
    END AS 'Data-Protocolo-Dinamico',
    CASE
        WHEN l.Nome IS NULL THEN leg.leg_descricao
        ELSE l.Nome
    END AS 'LEGISLATURA',
    pd.observacao,
    pd.INTERNET
FROM 
	protocolo_dinamico_3 pd
	LEFT JOIN legislatura l ON l.Codigo = pd.Codigo_Legislatura
	LEFT JOIN {bancowcm4}.wcm_cadastros_genericos cg ON cg.codigo_protocolo_dinamico_3_webcamara = pd.Codigo
	LEFT JOIN {bancowcm4}.wcm_legislaturas leg ON leg.leg_id = cg.cad_gen_legislaturas_id_fk
ORDER BY cg.cad_gen_id DESC;