from core.compare import executar_query
from core.db import carregar_conexao

def encontrar_nome_protocolo(nome_dicionario):
    DB1, DB2, DB3, DESCRIPT = carregar_conexao()

    nome_dinamico = nome_dicionario.replace("Protocolo Dinamico", "").strip()
    nome_dinamico = nome_dinamico or "1"
    tabeladaquery = nome_dicionario.lower().strip().replace(" ", "_") # EX: Protocolo Dinamico 2 -> protocolo_dinamico_2

    query = f"""
        SELECT tp.nome
        FROM tipo_protocolo tp
        WHERE tp.tabela = '{tabeladaquery}'
    """

    resultado = executar_query(DB1, query)

    if not resultado:
        return f"{nome_dicionario} (PD{nome_dinamico})"

    nome = resultado[0]["nome"]

    return f"{nome}   (PD{nome_dinamico})"