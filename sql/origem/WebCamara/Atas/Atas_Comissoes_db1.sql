SELECT 
	wcm4.ata_com_id AS 'ID-Ata-Comissao-NovoWCM',
-- 	a.Codigo,
	a.Titulo,
	a.Observacoes,
	c.Nome AS 'NOME-COMISSAO',
	l.nome AS 'LEGISLATURA',
	a.Data as 'Data_Inicio_Tramitacao',
	CASE
		WHEN a.codigo_tipo = 1 THEN 'Comissão Permanente'
		WHEN a.codigo_tipo = 2 THEN 'Comissão Temporária'
		ELSE Null 
	END AS 'TIPO' 
FROM 
	ata_comissao a
	LEFT JOIN legislatura l ON l.Codigo = a.Codigo_Legislatura
	LEFT JOIN comissao c ON c.Codigo = a.Codigo_Legislatura_Comissao
	LEFT JOIN {bancowcm4}.wcm_atas_comissoes wcm4 ON wcm4.codigo_ata_comissao = a.Codigo
ORDER BY wcm4.ata_com_id DESC