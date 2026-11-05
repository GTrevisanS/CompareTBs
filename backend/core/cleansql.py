from backend.core.db import carregarConexao # Meu arquivo separado que define as conexões de banco

DB1, DB2, DB3, DESCRIPT = carregarConexao()

def ajustarQuery(query, parametros):
    query = query.replace("{bancowcm4}", DB3) # Se encontrar a chave do wcm4, faz o replace (Somente ocorre na query1 / Webcamara)
    query = query.replace("{codigo_descriptografia_rg_cpf}", DESCRIPT) # Se encontrar o código de descriptografias, troca (Somente ocorre na query2 / NovoWCM)
    if not parametros:  # Verifica se o dicionário do documento possui algum parametro cadastrado
        pass            # Se o dicionário não tiver parâmetros, ele pula a função, se tiver, ele executa os replaces
    else:
        # parametros = cfg["parametros"]
        for cadalinha in parametros.keys():
            variavel = cadalinha
            valor = parametros[cadalinha]
            chave = "{" + variavel + "}"
            troca = str(valor)
            query = query.replace(chave, troca)
    return query
