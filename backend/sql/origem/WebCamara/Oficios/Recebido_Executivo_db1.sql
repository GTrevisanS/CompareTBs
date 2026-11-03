SELECT 
	wcm4.ofi_id AS 'ID-Oficio-NovoWCM',
	oam.Codigo_Individual_Ano AS 'CODIGO-INDIVIDUAL-ANO',
	oam.Numero_Oficio,
	l.Nome AS 'LEGISLATURA',
	oam.ASSUNTO,
	oam.observacao AS 'OBSERVACOES',
	oam.Data,
	oam.Em_Resposta,
	oam.Em_resposta_Tipo,
	oam.Em_resposta_codigo,
	-- oam.Origem,
	oam.INTERNET
FROM
	oficios_administracao_municipal oam
	LEFT JOIN {bancowcm4}.wcm_oficios wcm4 ON wcm4.codigo_recebido_executivo_webcamara = oam.Codigo
    LEFT JOIN legislatura l ON l.Codigo = oam.Codigo_LEGISLATURA
ORDER BY wcm4.ofi_id DESC 