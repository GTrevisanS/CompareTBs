SELECT 
	wcm4.ofi_id AS 'ID-Oficio-NovoWCM',
	bp.Codigo_Individial_Ano AS 'CODIGO-INDIVIDUAL-ANO',
	-- bp.Codigo,
	l.nome AS 'LEGISLATURA',
	bp.Numero_Oficio,
	bp.Data,
	bp.Assunto,
	bp.INTERNET
FROM 	 
	balancete_prefeitura bp
	LEFT JOIN legislatura l ON l.Codigo = bp.Codigo_LEGISLATURA
	LEFT JOIN {bancowcm4}.wcm_oficios wcm4 ON wcm4.codigo_balancete_prefeitura_webcamara = bp.Codigo
ORDER BY wcm4.ofi_id DESC 