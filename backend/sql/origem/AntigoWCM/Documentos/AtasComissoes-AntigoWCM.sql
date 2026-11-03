SELECT
    a.ata_com_id AS 'ID-WCM-ANTIGO',
    CONCAT(a.ata_com_codigo_individual, '-', YEAR(a.ata_com_data_ata)) AS 'CODIGO-INDIVIDUAL-ANO',
    a.ata_com_titulo AS 'TITULO',
    a.ata_com_descricao AS 'EMENTA',
    a.ata_com_retificacao AS 'RETIFICACAO',

    CASE a.ata_com_tipo_comissao
        WHEN 0 THEN per.com_per_descricao
        ELSE temp.com_tem_descricao
    END AS 'COMISSÃO VINCULADA',

    a.ata_com_data_aprovacao AS 'DATA-APROVACAO',
    a.ata_com_data_ata AS 'DATA-REGISTRO',
    a.ata_com_mostra_online AS 'INTERNET'

FROM wcm_atas_comissoes a

LEFT JOIN wcm_comissoes_permanentes per
    ON per.com_per_id = a.ata_com_comissoes_id_fk
    AND a.ata_com_tipo_comissao = 0

LEFT JOIN wcm_comissoes_temporarias temp
    ON temp.com_tem_id = a.ata_com_comissoes_id_fk
    AND a.ata_com_tipo_comissao <> 0;