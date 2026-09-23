SELECT 
	o.ofi_id 'ID-WCM-ANTIGO',
	o.ofi_data_hora 'DATA-REGISTRO',
	concat(o.ofi_codigo_individual, '-', YEAR(o.ofi_data_hora)) 'CODIGO-INDIVIDUAL-ANO',
	o.ofi_ementa 'EMENTA',
	o.ofi_observacoes 'OBSERVACOES',
	o.ofi_numero_protocolo_prefeitura,
	o.ofi_designacao,
	o.ofi_enderecamento 'ENDERECAMENTO',
	o.ofi_mostra_online 'INTERNET'
FROM 
	wcm_oficios o
WHERE 
	o.ofi_tipos_protocolos_id_fk = {tipo_protocolo_antigowcm}