SELECT
     wcm4.con_id AS 'CODIGO-CONTRATO-WEBCAMARA',
	 cont.Codigo_Sequencial_Ano AS 'CODIGO-INDIVIDUAL-ANO',
	 cont.Situacao,
	 p.Nome AS 'PRESIDENTE-CONTRATO',
	 cont.Objeto,
	 cont.Razao_Social,
	 cont.Endereco,
	 cont.CNPJ,
	 cont.Fone,
	 cont.Representante,
	 cont.Data_Contrato,
	 cont.Data_inicio,
	 cont.Data_termino,
	 cont.Origem,
	 cont.Valor_Global,
	 cont.Codigo_Licitacao,
	 tc.Descricao AS 'TIPO-CONTRATO',
	 cont.INTERNET
FROM
    contrato cont
    LEFT JOIN tipo_contrato tc ON cont.Codigo = tc.Codigo
    LEFT JOIN politico p ON p.Codigo = cont.Codigo_presidente_POLITICO
    LEFT JOIN {bancowcm4}.wcm_contratos wcm4 ON wcm4.codigo_contratos_webcamara = cont.Codigo
ORDER BY wcm4.con_id DESC