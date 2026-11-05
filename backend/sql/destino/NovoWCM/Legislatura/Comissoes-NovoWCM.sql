SELECT 
    wc.codigo_comissao_importada,
    wc.com_descricao,
    wc.com_sigla,
    wl.leg_descricao,
    wc.com_periodo,
    wc.com_data_inicio,
    wc.com_data_fim,
    wc.com_atribuicoes,
    wc.com_observacao,
    GROUP_CONCAT(wcu.cad_uni_nome SEPARATOR '___') AS 'MEMBROS-COMISSAO',
    wc.com_tipo,
    CONCAT(wc.com_descricao, ' (', wl.leg_descricao ,') ') AS 'NOME-COMISSAO' -- CONCATENO PARA ACHAR MAIS FACIL DEPOIS PELO COMPARADOR
FROM 
    wcm_comissoes wc
    LEFT JOIN wcm_legislaturas wl ON wl.leg_id = wc.com_legislaturas_id_fk
    LEFT JOIN wcm_comissoes_membros m ON m.com_mem_comissoes_id_fk = wc.com_id
	LEFT JOIN wcm_cadastros_unicos wcu ON wcu.cad_uni_id = m.com_mem_cadastro_unico_id_fk
WHERE wc.com_tipo = {tipo_comissao_novowcm} -- 0 = permanente | 1 = Temporaria
GROUP BY 
    wc.com_id
ORDER BY
    wc.codigo_comissao_importada DESC;