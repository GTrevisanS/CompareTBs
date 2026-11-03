def ajustarNome(texto):
    limite = 30
    texto = str(texto)
    if len(texto) > limite:
        texto = texto[:limite] + "..."
    else: pass
    return texto


def identificarSistema(DB1, DB2):
    b2 = ajustarNome(DB2["database"])
    b2_host = ajustarNome( DB2["host"])
    b2_port = DB2["port"]

    b1 = ajustarNome(DB1["database"])
    b1_host = ajustarNome(DB1["host"])
    b1_port = DB1["port"]

    if 'webcamara' in b1.lower():
        tipo_migracao = 'Migração do Webcamara'
    else:
        tipo_migracao = 'Migração do WCM'

    return b1, b1_host, b1_port, b2, b2_host, b2_port, tipo_migracao