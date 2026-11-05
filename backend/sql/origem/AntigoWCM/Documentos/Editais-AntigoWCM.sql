SELECT 
	e.edi_id 'ID-WCM-ANTIGO',
	CONCAT(e.edi_codigo_individual, '-', YEAR(e.edi_data_edital)) 'CODIGO-INDIVIDUAL-ANO',
	e.edi_assunto 'EMENTA',
	te.tip_edi_descricao 'SUBTIPO',
	tl.tip_lic_descricao 'TIPO-LICITACAO',
	e.edi_codigo_licitacao 'CODIGO-LICITACAO',
	l.leg_descricao 'LEGISLATURA',
	e.edi_providencias 'PROVIDENCIA',
	t.tra_descricao 'SITUACAO-TRAMITACAO',
	e.edi_regime_execucao 'REGIME-EXECUCAO',
	e.edi_data_edital 'DATA-REGISTRO',
	e.edi_data_realizacao 'DATA-REALIZACAO',
	e.edi_data_abertura 'DATA-ABERTURA',
	e.edi_hora_abertura 'HORA-ABERTURA',
	e.edi_mostra_online 'INTERNET'
FROM 
	wcm_editais e
	LEFT JOIN wcm_tramitacoes t ON t.tra_id = e.edi_tramitacoes_id_fk
	LEFT JOIN wcm_tipos_editais te ON te.tip_edi_id = e.edi_tipos_editais_id_fk
	LEFT JOIN wcm_tipos_licitacoes tl ON tl.tip_lic_id = e.edi_tipos_licitacoes_id_fk
	LEFT JOIN wcm_legislaturas l ON l.leg_id = e.edi_legislaturas_id_fk
ORDER BY 
	e.edi_id DESC