SELECT
	wcm4.aud_pub_id AS 'ID-Audiencia-Publica-NovoWCM',
   CONCAT(pr.processo_numero, '-', pr.processo_ano) 'NUMERO-PROTOCOLO-NOVOWCM',
	au.Codigo_Individual_Ano AS 'CODIGO-INDIVIDUAL-ANO',
	au.Data,
	l.nome AS 'LEGISLATURA',
	au.Pub_Jornal1,
	au.Pub_Data1,
	au.Pub_Jornal2,
	au.Pub_Data2,
	au.Ementa,
	CONCAT(au.Data_Audiencia, ' ', au.Hora_Audiencia) AS 'DATA-REGISTRO',
	au.Tipo_legislacao,
	au.Link,
	au.INTERNET
FROM 
	audiencia_publica au
	LEFT JOIN {bancowcm4}.wcm_audiencias_publicas wcm4 ON wcm4.codigo_audiencia_publica_webcamara = au.Codigo
    LEFT JOIN legislatura l ON l.Codigo = au.Codigo_LEGISLATURA
    LEFT JOIN protocolo pr ON pr.Num_Protocolo = au.Num_Protocolo_PROTOCOLO
ORDER BY wcm4.aud_pub_id DESC