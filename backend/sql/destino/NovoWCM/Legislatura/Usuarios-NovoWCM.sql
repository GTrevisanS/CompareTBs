SELECT
	wus.codigo_usuario_wcm,
	wus.usu_sis_login,
	wus.usu_sis_senha,
	wus.usu_sis_ativo,
	wdep.dep_descricao,
	wgus.gru_usu_sis_nome
FROM 
	wcm_usuarios_sistema wus
	LEFT JOIN wcm_departamentos wdep ON wdep.dep_id = wus.usu_sis_departamento_principal_id_fk
	LEFT JOIN wcm_grupos_usuarios_sistema wgus ON wgus.gru_usu_sis_id = wus.usu_sis_grupo_usuario_sistema_id_fk
WHERE wus.codigo_usuario_wcm IS NOT NULL
ORDER BY wus.codigo_usuario_wcm DESC