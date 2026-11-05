SELECT 
	wcm4.cad_gen_id AS 'ID-Memorando-Externo-NovoWCM',
	me.Codigo_Individual_Ano AS 'CODIGO-INDIVIDUAL-ANO',
	me.EMENTA,
	me.OBSERVACOES,
	me.`Data` AS 'DATA-REGISTRO',
	me.INTERNET
FROM 
	memorando_externo me
   LEFT JOIN {bancowcm4}.wcm_cadastros_genericos wcm4 ON wcm4.codigo_memorando_externo_webcamara = me.Codigo
ORDER BY
	wcm4.cad_gen_id DESC