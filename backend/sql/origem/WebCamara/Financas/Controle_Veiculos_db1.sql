SELECT 
	wcm4.fin_id AS 'ID-Controle-Veiculo-NovoWCM',
	cv.Codigo_Individual_Ano AS 'CODIGO-INDIVIDUAL-ANO',
	cv.Data_Saida,
	cv.Hora_Saida,
	cv.Data_Chegada,
	cv.Hora_Chegada,
	cv.Data_Solicitacao,
	cv.Codigo_Politico,
	cv.Itinerarios_Destino,
	cv.Acompanhantes,
	cv.Local,
	cv.Observacao,
	cv.Valor_Despesa,
	cv.Responsavel,
	cv.conforme
FROM 
	controle_veiculos cv
	LEFT JOIN {bancowcm4}.wcm_financas wcm4 ON wcm4.codigo_controle_veiculo_webcamara = cv.Codigo
ORDER BY
	wcm4.fin_id desc