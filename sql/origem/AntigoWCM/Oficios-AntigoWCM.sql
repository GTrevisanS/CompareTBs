SELECT 
	o.ofi_id 'ID-WCM-ANTIGO',
	o.ofi_data_hora 'DATA-REGISTRO',
	concat(o.ofi_codigo_individual, '-', YEAR(o.ofi_data_hora)) 'CODIGO-INDIVIDUAL-ANO',
	o.ofi_ementa 'EMENTA',
	o.ofi_observacoes 'OBSERVACOES',
	o.ofi_numero_protocolo_prefeitura,
	o.ofi_designacao,
	o.ofi_enderecamento 'ENDERECAMENTO',
	des.des_descricao 'DESTINATARIO',
	o.ofi_mostra_online 'INTERNET'
FROM 
	wcm_oficios o
	LEFT JOIN wcm_destinatarios_oficios d ON d.des_ofi_oficios_id_fk = o.ofi_id
	LEFT JOIN wcm_destinatarios des ON des.des_id = d.des_ofi_destinatarios_id_fk
WHERE 
	o.ofi_tipos_protocolos_id_fk = {tipo_protocolo_antigowcm}