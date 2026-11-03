SELECT 
	wcm4.cad_uni_id AS 'ID-Funcionario-NovoWCM',
	f.Nome_completo,
	f.Data_Nascimento,
	f.Sexo,
	f.Cargo,
	f.RG,
	f.CPF,
	f.Estado_Civil,
	f.Nome_Pai,
	f.Nome_Mae,
	f.Nacionalidade,
	f.Naturalidade,
	f.Endereco,
	f.Data_Emissao_RG,
	f.Carteira_habilitacao,
	f.Titulo_eleitor,
	f.Zona_titulo_eleitor,
	f.Secao_titulo_eleitor,
	f.Carteira_profissional,
	f.Profissao,
	f.Reservista,
	f.Conjuge,
	f.Escolaridade
FROM
	funcionarios f
	LEFT JOIN {bancowcm4}.wcm_cadastros_unicos wcm4 ON wcm4.codigo_funcionario_webcamara = f.Codigo
ORDER BY wcm4.cad_uni_id DESC 