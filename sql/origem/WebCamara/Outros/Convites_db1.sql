SELECT
	wcm4.con_id AS 'ID-Convite-NovoWCM',
	c.Codigo_Individial_Ano AS 'CODIGO-INDIVIDUAL-ANO',
	c.Assunto,
	c.Ano,
	c.Numero_Oficio,
	c.Data,
	c.Em_Resposta,
	c.Em_resposta_Tipo,
	c.Em_resposta_codigo,
	c.Data_Evento,
	c.Hora_Evento,
	c.Local_Endereco,
	c.Representante,
	c.INTERNET
FROM 
	convite c
	LEFT JOIN {bancowcm4}.wcm_convites wcm4 ON wcm4.codigo_convite_webcamara = c.Codigo
ORDER BY wcm4.con_id DESC