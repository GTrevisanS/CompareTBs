SELECT
	us.usu_id 'ID-WCM-ANTIGO',
	us.usu_nome 'USUARIO',
	'tm1vpu9htt1pr0u9t1rjpu9ewt1pr0k9tlrjpu5qaz1pree9tm1vpu56zz0=' AS 'SENHA',
	CASE
		WHEN us.usu_situacao = 'Ativo' THEN 1 
		ELSE 0
	END AS 'SITUACAO',
	IF(wd.dep_descricao IS NULL, 'DIRETORIA LEGISLATIVA', wd.dep_descricao) 'DEPARTAMENTO',
	gu.gru_usu_nome 'GRUPO-USUARIO'
FROM 
	wcm_usuarios us
	LEFT JOIN wcm_departamentos wd ON wd.dep_id = us.usu_departamentos_id_fk
	LEFT JOIN wcm_grupos_usuarios gu ON gu.gru_usu_id = us.usu_grupos_usuarios_id_fk
WHERE us.usu_nome NOT LIKE 'webline' # Pra não atrapalhar (visto que é padrão)
ORDER BY us.usu_id DESC