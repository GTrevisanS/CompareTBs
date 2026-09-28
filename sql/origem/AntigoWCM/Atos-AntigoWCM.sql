SELECT 
    a.ato_id 'ID-WCM-ANTIGO',
    CONCAT(a.ato_codigo_individual, '-', YEAR(a.ato_data_hora)) 'CODIGO-INDIVIDUAL-ANO',
    a.ato_data_hora 'DATA-REGISTRO',
    a.ato_data_hora_publicacao 'DATA-PUBLICACAO',
    a.ato_orgao_imprensa 'ORGAO-IMPRENSA',
    a.ato_observacao 'OBSERVACOES',
    a.ato_local_publicacao 'LOCAL-PUBLICACAO',
    a.ato_assunto 'ASSUNTO',
    CONCAT_WS(', ',
        IF(a.ato_situacao_lei_ativa != 0, 'Em vigor', NULL),
        IF(a.ato_situacao_lei_revogada_parcialmente != 0, 'Revogada Parcial', NULL),
        IF(a.ato_situacao_lei_revogada_totalmente != 0, 'Revogada Totalmente', NULL),
        IF(a.ato_situacao_lei_inconstitucional != 0, 'Inconstitucional', NULL),
        IF(a.ato_situacao_lei_suspensa_por_liminar != 0, 'Suspensa por liminar', NULL),
        IF(a.ato_situacao_lei_parcialmente_inconstitucional != 0, 'Parcialmente inconstitucional', NULL),
        IF(a.ato_situacao_lei_suspensa_parcialmente_por_liminar != 0, 'Suspensa Parcialmente por liminar', NULL)
    ) AS 'SITUACAO-TRAMITACAO',
    l.leg_descricao 'LEGISLATURA',
    m.mes_dir_descricao 'MESA-DIRETORA',
    a.ato_tipos_atos_id_fk 'TIPO-ATO',
    a.ato_mostra_online 'INTERNET'
FROM 
    wcm_atos a
	 LEFT JOIN wcm_legislaturas l ON l.leg_id = a.ato_legislaturas_id_fk
	 LEFT JOIN wcm_mesas_diretoras m ON m.mes_dir_id = a.ato_mesas_diretoras_id_fk
WHERE
	 -- 2 = aTOS DA PRESIDENCIA	
    a.ato_tipos_atos_id_fk = {tipos_atos_antigowcm}
	 
ORDER BY 
    a.ato_id DESC