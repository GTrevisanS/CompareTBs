SELECT
	wcm4.mes_dir_id AS 'ID-Mesa-Diretora-NovoWCM',
	l.Nome AS 'LEGISLATURA',
	m.NOME AS 'MESA-DIRETORA',
	m.SIGLA,
	m.BIENIO,
	m.DATA_INICIO 'DATA-INICIO',
	m.DATA_FIM 'DATA-FIM',
	m.SITUACAO,
	m.OBSERVACOES
FROM 
	mesa m
	LEFT JOIN legislatura l ON l.Codigo = m.Codigo_LEGISLATURA
	LEFT JOIN {bancowcm4}.wcm_mesas_diretoras wcm4 ON wcm4.codigo_mesa_webcamara = m.CODIGO
ORDER BY wcm4.mes_dir_id DESC