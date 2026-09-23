SELECT
	wcm4.usu_id AS 'ID-Usuario-NovoWCM',
	c.Usuario,
	'tm1vpu9htt1pr0u9t1rjpu9ewt1pr0k9tlrjpu5qaz1pree9tm1vpu56zz0=' as 'Senha',
	CASE 
		WHEN c.status_usuario = 'ATIVO' THEN 1
		ELSE 0
	END AS 'USUARIO-ATIVO',
	IF(d.Nome IS NULL, 'DIRETORIA LEGISLATIVA', d.Nome) AS 'DEPARTAMENTO',
	gp.DESCRICAO AS 'GRUPO-USUARIO'
-- 	c.Funcionario_Protocolo AS 'NOME-COMPLETO'
FROM 
	configuracoes c
	LEFT JOIN departamento_usuario du ON du.Usuario = c.Usuario
	LEFT JOIN departamento d ON d.Codigo = du.Codigo_Departamento
	LEFT JOIN permissao p ON p.usuario = c.Usuario
	LEFT JOIN grupo_permissoes gp ON gp.Codigo = p.GRUPO
	LEFT JOIN {bancowcm4}.wcm_usuarios wcm4 ON wcm4.codigo_usuario_webcamara = c.Cod_Unico
GROUP BY c.Usuario
HAVING wcm4.usu_id -- (Faço essa tratativa para ignorar o usuario webline)
ORDER BY wcm4.usu_id DESC