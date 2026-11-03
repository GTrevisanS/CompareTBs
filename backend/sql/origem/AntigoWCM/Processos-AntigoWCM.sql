SELECT 
	p.pro_id 'ID-WCM-ANTIGO',
	tp.tip_pro_descricao 'TIPO-PROCESSO',
    CONCAT(p.pro_codigo_individual_documentos, '-', YEAR(p.pro_data_hora)) 'CODIGO-INDIVIDUAL-ANO',
	(
        SELECT COUNT(*)
        FROM wfx_mensagens m
        WHERE m.men_processos_id_fk = p.pro_id
    ) AS 'QUANTIDADE-MENSAGENS',
	p.pro_setores_id_fk 'SETOR',
	p.pro_usuarios_id_fk 'USUARIO',
	p.pro_data_hora 'DATA-REGISTRO',
	p.pro_data_arquivado 'DATA-ARQUIVAMENTO',
	p.pro_data_desarquivado 'DATA-DESARQUIVAMENTO',
	p.pro_numero_protocolo 'ID-PROTOCOLO',
	p.pro_requerente_id 'REQUERENTE',
	t.tra_descricao 'SITUACAO',
    1 'INTERNET'
	-- p.pro_situacao_id_fk
FROM 
	wfx_processos p
	LEFT JOIN wcm_tipos_processos tp ON tp.tip_pro_id = p.pro_tipos_processos_id_fk
	LEFT JOIN wcm_tramitacoes t ON t.tra_id = p.pro_situacao_id_fk
ORDER BY	
	p.pro_id DESC