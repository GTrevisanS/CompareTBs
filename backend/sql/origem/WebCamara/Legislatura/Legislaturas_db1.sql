SELECT
	wcm4.leg_id AS 'ID-Legislatura-NovoWCM',
	l.NOME AS 'NOME-LEGISLATURA',
	p1.NOME AS 'NOME-PREFEITO',
	l.VOTOS,
	p2.NOME AS 'NOME-VICE-PREFEITO',
	l.DATA_INICIAL,
	l.DATA_FINAL,
	l.OBSERVACAO,
	l.SIGLA,
	l.DATA_ELEICAO,
	l.INTERNET
FROM 
	legislatura l
	LEFT JOIN politico p1 ON p1.Codigo = l.Cod_Prefeito_POLITICO
	LEFT JOIN politico p2 ON p2.Codigo = l.Cod_Vice_POLITICO
	LEFT JOIN {bancowcm4}.wcm_legislaturas wcm4 ON wcm4.codigo_legislatura_webcamara = l.CODIGO
	ORDER BY wcm4.leg_id DESC