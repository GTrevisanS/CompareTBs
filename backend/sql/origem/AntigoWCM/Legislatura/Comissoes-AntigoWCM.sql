SELECT 
    cp.com_per_id AS 'ID-WCM-ANTIGO',
    cp.com_per_descricao AS 'COMISSAO',
    cp.com_per_sigla AS 'SIGLA',
    wl1.leg_descricao AS 'LEGISLATURA',
    cp.com_per_periodo AS 'PERIODO',
    DATE(cp.com_per_data_inicio) AS 'DATA-INICIO',
    DATE(cp.com_per_data_fim) AS 'DATA-FIM',
    cp.com_per_atribuicoes AS 'ATRIBUICOES',
    cp.com_per_observacao AS 'OBSERVACOES',
    'PERMANENTE' AS 'TIPO',
    GROUP_CONCAT(wp1.par_nome SEPARATOR '___') AS 'MEMBROS-COMISSAO'
FROM wcm_comissoes_permanentes cp

LEFT JOIN wcm_legislaturas wl1
    ON wl1.leg_id = cp.com_per_legislaturas_id_fk

LEFT JOIN wcm_comissoes_permanentes_membros cpm
    ON cpm.com_per_mem_comissoes_permanentes_id_fk = cp.com_per_id

LEFT JOIN wcm_parlamentares wp1
    ON wp1.par_id = cpm.com_per_mem_parlamentares_id_fk

GROUP BY
    cp.com_per_id


UNION ALL


SELECT 
    ct.com_tem_id AS 'ID-WCM-ANTIGO',
    ct.com_tem_descricao AS 'COMISSAO',
    ct.com_tem_sigla AS 'SIGLA',
    wl2.leg_descricao AS 'LEGISLATURA',
    ct.com_tem_periodo AS 'PERIODO',
    DATE(ct.com_tem_data_inicio) AS 'DATA-INICIO',
    DATE(ct.com_tem_data_fim) AS 'DATA-FIM',
    ct.com_tem_atribuicao AS 'ATRIBUICOES',
    ct.com_tem_observacao AS 'OBSERVACOES',
    'TEMPORARIA' AS 'TIPO',
    GROUP_CONCAT(wp2.par_nome SEPARATOR '___') AS 'MEMBROS-DA-COMISSAO'
FROM wcm_comissoes_temporarias ct

LEFT JOIN wcm_legislaturas wl2
    ON wl2.leg_id = ct.com_tem_legislaturas_id_fk

LEFT JOIN wcm_comissoes_temporarias_membros ctm
    ON ctm.com_tem_mem_comissoes_temporarias_id_fk = ct.com_tem_id

LEFT JOIN wcm_parlamentares wp2
    ON wp2.par_id = ctm.com_tem_mem_membros_id_fk

GROUP BY
    ct.com_tem_id
