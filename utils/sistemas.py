def ajustarnome(texto):
    limite = 30
    texto = str(texto)
    if len(texto) > limite:
        texto = texto[:limite] + "..."
    else: pass
    return texto

def identificar(DB1, DB2):
    b2 = ajustarnome(DB2["database"])
    b2_host = ajustarnome( DB2["host"])
    b2_port = DB2["port"]

    b1 = ajustarnome(DB1["database"])
    b1_host = ajustarnome(DB1["host"])
    b1_port = DB1["port"]

    if 'webcamara' in b1.lower():
        tipo_migracao = 'Migração do Webcamara'
    else:
        tipo_migracao = 'Migração do WCM'

    return b1, b1_host, b1_port, b2, b2_host, b2_port, tipo_migracao


def padrao_query(padrao, documento):
    if padrao == 'Migração do Webcamara':
        cfg = CONFIGURACOES.get(str(documento))
        parametros = cfg.get("parametros")
        mapeamento = cfg["mapeamento"]
        query1 = cfg["query1"]
        query2 = cfg["query2"]
        chave1 = cfg["chave1"]
        chave2 = cfg["chave2"]
        nomemodulo = cfg["nome"]
    else:
        cfg = CONFIGURACOES.get(str(documento))
        tabela = cfg["tabela"]
        padrao = PADROES.get(str(tabela))
        parametros = cfg.get("parametros")
        mapeamento = padrao["mapeamento"]
        nomemodulo = cfg["nome"]
        query1 = padrao["query1"]
        query2 = padrao["query2"]
        chave1 = cfg["chave1"]
        chave2 = cfg["chave2"]
    return cfg, parametros, mapeamento, query1, query2, chave1, chave2, nomemodulo
