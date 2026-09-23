def identificar(DB1, DB2):
    banco1 = DB1["database"]
    banco1_host = DB1["host"]
    banco1_port = DB1["port"]

    banco2 = DB2["database"]
    banco2_host = DB2["host"]
    banco2_port = DB2["port"]

    def ajustarnome(texto):
        limite = 30
        texto = str(texto)
        if len(texto) > limite:
            texto = texto[:limite] + "..."
        else: pass
        return texto

    banco2 = ajustarnome(banco2)
    banco2_host = ajustarnome(banco2_host)
    banco1 = ajustarnome(banco1)
    banco1_host = ajustarnome(banco1_host)

    if 'webcamara' in banco1.lower():
        tipo_migracao = 'Migração do Webcamara'
    else:
        tipo_migracao = 'Migração do WCM'

    return banco1, banco1_host, banco1_port, banco2, banco2_host, banco2_port, tipo_migracao


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
