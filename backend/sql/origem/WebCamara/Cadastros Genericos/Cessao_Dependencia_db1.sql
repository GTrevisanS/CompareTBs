SELECT
    wcm4.cad_gen_id AS 'ID-Cessao-Dependencia-NovoWCM',
    cd.Codigo_Individual_Ano AS 'CODIGO-INDIVIDUAL-ANO',
    cd.Nome,
    cd.Finalidade,
    CONCAT_WS(', ',
        IF(cd.Requer_Plenario != 0, 'Plenario', NULL),
        IF(cd.Requer_Plenarinho != 0, 'Plenarinho', NULL),
        IF(cd.Requer_Saguao_Eventos != 0, 'Saguão de Eventos', NULL),
        IF(cd.Requer_Sala_Reuniao1 != 0, 'Sala de Reunião', NULL),
        IF(cd.Requer_Notebook != 0, 'Notebook', NULL),
        IF(cd.Requer_Projetor != 0, 'Projetor', NULL),
        IF(cd.Requer_Som != 0, 'Som', NULL),
        IF(cd.Requer_Copa != 0, 'Copa', NULL),
        IF(
            cd.Requer_outros != 0,
            IF(
                cd.Texto_Requer_Outros IS NOT NULL
                AND cd.Texto_Requer_Outros <> '',
                CONVERT(cd.Texto_Requer_Outros USING utf8),
                'Outros'
            ),
            NULL
        )
    ) AS 'REQUERER',
    CONCAT_WS(', ',
        IF(cd.Presidencia_Deferido != 0, 'Deferido', NULL),
        IF(cd.Presidencia_Indeferido != 0, 'Inferido', NULL),
        IF(cd.Presidencia_Com_Taxa != 0, 'Com taxa', NULL),
        IF(cd.Presidencia_Sem_Taxa != 0, 'Sem taxa', NULL)
    ) AS 'DESPACHO-PRESIDENCIA',
    
    cd.INTERNET
FROM 
	cessao_dependencia cd
	LEFT JOIN {bancowcm4}.wcm_cadastros_genericos wcm4 ON wcm4.codigo_cessao_dependencia_webcamara = cd.Codigo
ORDER BY 
	wcm4.cad_gen_id DESC;