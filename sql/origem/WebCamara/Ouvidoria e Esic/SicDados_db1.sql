SELECT
    sic.dadsic_id,
    sic.dadsic_codigo_individual,
    st.stasic_descricao AS 'SIC-SIT',
    sic.dadsic_mensagem,
    sic.dadsic_justificativa,
    sic.dadsic_ip_cadastro,
    tm.tip_man_descricao AS 'TIPO-MANIFESTACAO',
    sic.dadsic_data_cadastro
FROM
    sic_dados sic
    LEFT JOIN sic_status st ON st.stasic_id = sic.dadsic_id_status_fk
    LEFT JOIN web_tipo_manifestacao tm ON tm.tip_man_id = sic.ususic_tipo_manifestacao
WHERE
    dadsic_tipo_cadastro = {id_tipo_documento_webcamara}
ORDER BY sic.dadsic_id DESC 