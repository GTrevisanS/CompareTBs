SELECT 
	wcm4.cad_gen_id AS 'ID-Reuniao-NovoWCM', 
	r.Codigo_Individual_Ano AS 'CODIGO-INDIVIDUAL-ANO',
	r.EMENTA,
	r.`Data` AS 'DATA-REGISTRO',
	r.Tipo_Reuniao 'SUBTIPO', -- É um campo de texto, então ababa por ser comparado com justificativa mesmo
    0 AS 'INTERNET' -- Deixei como 0 pq como não existe o campo no webcamara, é melhor vir como 0 por questão de privacidade
FROM 
	reuniao r
    LEFT JOIN {bancowcm4}.wcm_cadastros_genericos wcm4 ON wcm4.codigo_reuniao_webcamara = r.Codigo
ORDER BY
	wcm4.cad_gen_id DESC