SELECT
    wd.codigo_contratos_importado,
    wd.doc_codigo_individual_ano,
    ws.sit_descricao,
    wd.doc_ementa,
    wcad.cad_uni_nome AS 'RAZAO-SOCIAL',
    AES_DECRYPT(UNHEX(wcad.cad_uni_documento),'{codigo_descriptografia_rg_cpf}') AS 'CNPJ-NOVOWCM',
	wemp.edi_emp_representante,
    wd.doc_data_inicio_tramitacao,
    wd.doc_data_documento AS 'DATA-CONTRATO',
    wd.doc_data_fim AS 'DATA-FIM',
    wd.doc_valor,
    wd.doc_codigo_licitacao,
    wt.sub_tip_doc_descricao,
    wd.doc_mostra_online
FROM wcm_documentos wd

LEFT JOIN wcm_editais_empresas wemp 
	 ON wemp.edi_editais_id_fk = wd.doc_id

LEFT JOIN wcm_cadastros_unicos wcad
	 ON wemp.edi_emp_cadastros_unicos_id_fk = wcad.cad_uni_id

LEFT JOIN wcm_sub_tipos_documentos wt
    ON wt.sub_tip_doc_id = wd.doc_subtipo_documento_id_fk

LEFT JOIN wcm_documentos_situacoes wds
    ON wds.doc_sit_documento_id_fk = wd.doc_id

LEFT JOIN wcm_situacoes ws
    ON ws.sit_id = wds.doc_sit_situacao_id_fk
    
WHERE
    wd.doc_tipo_documento_id_fk = {id_tipo_documento_novowcm}
    AND wd.deleted_at IS NULL
    
ORDER BY
    wd.codigo_contratos_importado DESC;