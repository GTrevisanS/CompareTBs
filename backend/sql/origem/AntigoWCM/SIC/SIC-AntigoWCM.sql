SELECT
    s.dadsic_id 'ID-SIC',
    s.dadsic_codigo_individual 'CODIGO-INDIVIDUAL-ANO',
    CASE
    	WHEN st.stasic_descricao IS NULL THEN 'Protocolado'
		ELSE st.stasic_descricao 
	 END AS 'SITUACAO-TRAMITACAO',
    s.dadsic_mensagem 'EMENTA',
    s.dadsic_justificativa 'JUSTIFICATIVA',
--     s.dadsic_ip_cadastro 'IP-CADASTRO',
    tm.tip_man_descricao AS 'TIPO-MANIFESTACAO',
--     s.dadsic_sigiloso,
    s.dadsic_data_cadastro 'DATA-REGISTRO',
    s.dadsic_nota_atendimento 'NOTA-ATENDIMENTO'
FROM
    sic_dados s
    LEFT JOIN sic_status st ON st.stasic_id = s.dadsic_id_status_fk
    LEFT JOIN web_tipo_manifestacao tm ON tm.tip_man_id = s.ususic_tipo_manifestacao
WHERE    
	 -- Ouvidoria = 1 | Esic = 0
    s.dadsic_tipo_cadastro = {tipo_protocolo_antigowcm}
ORDER BY 
    s.dadsic_id DESC 