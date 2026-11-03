SELECT 
	e.eme_id 'ID-WCM-ANTIGO',
	e.eme_numero 'NUMERO',
	e.eme_descricao 'EMENTA'
FROM 
	wcm_ementas e
ORDER BY e.eme_id DESC 