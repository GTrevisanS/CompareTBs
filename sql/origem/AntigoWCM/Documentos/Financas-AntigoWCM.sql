SELECT 
	f.fin_id 'ID-WCM-ANTIGO',
	CONCAT(f.fin_codigo_invidual, '-', YEAR(f.fin_data_inicio))'CODIGO-INDIVIDUAL-ANO',
	tp.tip_pro_descricao 'TIPO',
	f.fin_financas_id_fk,
	f.fin_assunto 'EMENTA',
	f.fin_motivo 'JUSTIFICATIVA', -- NAO É JUSTIFICATIVA, MAS VOU CHUTAR QUE É
	f.fin_data_inicio 'DATA-INICIO',
	f.fin_data_fim 'DATA-FIM', 
	f.fin_localidade 'LOCAL',
	f.fin_cessao_veiculos 'CESSAO-VEICULOS',
	f.fin_autorizado 'AUTORIZADO',
	f.fin_veiculos_id_fk 'VEICULO',
	f.fin_km_saida 'KM-SAIDA',
	f.fin_km_chegada 'KM-CHEGADA',
	f.fin_combustivel 'COMBUSTIVEL',
	f.fin_valor 'VALOR',
	f.fin_dotacao 'DOTACAO',
	f.fin_valor_devolvido 'VALOR-DEVOLVIDO',
	f.fin_comprovante_despesas 'COMPROVANTE-DESPESAS',
	f.fin_diarias 'DIARIAS',
	f.fin_itinerario 'ITINERARIO',
	f.fin_mostra_online 'INTERNET'
FROM
	wcm_financas f
	LEFT JOIN wcm_tipos_protocolos tp ON tp.tip_pro_id = f.fin_tipos_protocolos_id_fk
WHERE 
	f.fin_tipos_protocolos_id_fk = {tipo_protocolo_antigowcm}
ORDER BY
	f.fin_id DESC