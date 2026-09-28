SELECT
    wd.codigo_sic_importado,
    wd.doc_codigo_individual_ano AS 'CODIGO-MANIFESTACAO',
    ws.sit_descricao,
    wd.doc_ementa,
--     h.his_sic_justificativa,
    wt.sub_tip_doc_descricao,
    wd.doc_codigo_licitacao,
    wd.doc_data_documento
FROM 
	wcm_documentos wd
	LEFT JOIN wcm_sub_tipos_documentos wt ON wt.sub_tip_doc_id = wd.doc_subtipo_documento_id_fk
	LEFT JOIN wcm_documentos_situacoes wds ON wds.doc_sit_documento_id_fk = wd.doc_id
	LEFT JOIN wcm_situacoes ws ON ws.sit_id = wds.doc_sit_situacao_id_fk
-- 	LEFT JOIN wcm_historico_sic h ON h.his_sic_documento_id_fk = wd.doc_id
WHERE
    wd.doc_tipo_documento_id_fk = {id_tipo_documento_novowcm}
    AND wd.deleted_at IS NULL
ORDER BY
    wd.codigo_sic_importado DESC;