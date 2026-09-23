SELECT 
-- 	wr.rev_id,
	CONCAT('[ ',wr.rev_data_hora_revogacao,' ]', '  -  ', CONCAT(wt1.tip_doc_descricao, ' ', wd1.doc_codigo_individual_ano), "       REVOGOU / ALTEROU       ", CONCAT(wt2.tip_doc_descricao, ' ', wd2.doc_codigo_individual_ano)) 'IDENTIFICADOR-REVOGACAO',
	RANK() OVER (ORDER BY wr.rev_data_hora_revogacao DESC, wr.rev_id DESC) AS 'rev_id',
	wr.rev_data_hora_revogacao,
	CONCAT(wt1.tip_doc_descricao, ' - ', wd1.doc_codigo_individual_ano) 'LEI-QUE-REVOGA-NOVOWCM',
	CASE
		WHEN wr.rev_acao = 1 THEN 'ALTERAÇÃO'
		WHEN wr.rev_acao = 2 THEN 'REVOGAÇÃO PARCIAL'
		WHEN wr.rev_acao = 3 THEN 'REVOGAÇÃO TOTAL'
		ELSE ''
	END AS 'rev_acao',
	CONCAT(wt2.tip_doc_descricao, ' - ', wd2.doc_codigo_individual_ano) 'LEI-REVOGADA-NOVOWCM',
	wr.rev_observacao
FROM 
	wcm_revogacoes wr
	LEFT JOIN wcm_documentos wd1 ON wd1.doc_id = wr.rev_documentos_id_fk
	LEFT JOIN wcm_tipos_documentos wt1 ON wt1.tip_doc_id = wr.rev_tipos_documento_id_fk
	LEFT JOIN wcm_documentos wd2 ON wd2.doc_id = wr.rev_documento_revogado_id_fk	
	LEFT JOIN wcm_tipos_documentos wt2 ON wt2.tip_doc_id = wr.rev_tipos_documentos_revogados_id_fk
WHERE 
    {parametro_where_novowcm}