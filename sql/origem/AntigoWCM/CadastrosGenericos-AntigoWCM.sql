SELECT
	g.cad_gen_id 'ID-WCM-ANTIGO',
	wtp.tip_pro_descricao,
	CONCAT(wp.pro_numero, '-', YEAR(g.cad_gen_data_hora)) 'NUMERO-PROTOCOLO-NOVOWCM',
	wp.pro_data_hora 'DATA-HORA-PROTOCOLO',
	CONCAT(g.cad_gen_codigo_individual, '-', YEAR(g.cad_gen_data_hora)) 'CODIGO-INDIVIDUAL-ANO',
-- 	g.cad_gen_tipos_protocolos_id_fk,
	g.cad_gen_data_hora 'DATA-REGISTRO',
	g.cad_gen_assunto 'ASSUNTO',
	g.cad_gen_ementa 'EMENTA',
	g.cad_gen_observacao 'OBSERVACOES',
	g.cad_gen_descricao 'DESCRICAO',
	t.tra_descricao 'SITUACAO-TRAMITACAO',
	g.cad_gen_valor 'VALOR',
	g.cad_gen_data_inicio 'DATA-INICIO',
	g.cad_gen_data_fim 'DATA-FIM',
	l.leg_descricao 'LEGISLATURA',
	c.cad_uni_nome 'CADASTRO-UNICO-VINCULADO',
	g.cad_gen_presidente_id_fk 'PRESIDENTE',
	g.cad_gen_edital_id_fk 'EDITAL',
	g.cad_gen_mostra_online 'INTERNET'
FROM 
	wcm_cadastros_genericos g
	LEFT JOIN wcm_tramitacoes t ON t.tra_id = g.cad_gen_tramitacoes_id_fk
	LEFT JOIN wcm_legislaturas l ON l.leg_id = g.cad_gen_legislaturas_id_fk
	LEFT JOIN wcm_cadastros_unicos c ON c.cad_uni_id = g.cad_gen_cadastros_unicos_id_fk
	LEFT JOIN wcm_protocolos wp ON wp.pro_documentos_id_fk = g.cad_gen_id
	LEFT JOIN wcm_tipos_protocolos wtp ON wtp.tip_pro_id = g.cad_gen_tipos_protocolos_id_fk
WHERE 
	g.cad_gen_tipos_protocolos_id_fk = {tipo_cadastro_generico_antigowcm}
ORDER BY
	g.cad_gen_id DESC