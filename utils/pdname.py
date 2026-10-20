from core.compare import executarQuery
from core.db import carregarBancos

def encontrarNomeProtocolo(nome_dicionario, tipo_migracao, numeroprotocolo=None):

    # Coleta e ajuste das informacoes
    DB1, DB2, DB3 = carregarBancos()
    nome_dinamico = nome_dicionario.replace("Protocolo Dinamico", "").strip()
    nome_dinamico = nome_dinamico or "1"
    tabeladaquery = nome_dicionario.lower().strip().replace(" ", "_") # EX: Protocolo Dinamico 2 -> protocolo_dinamico_2

    if tipo_migracao == 'Migração do Webcamara':
        query = f"""
            SELECT tp.nome
            FROM tipo_protocolo tp
            WHERE tp.tabela = '{tabeladaquery}'
        """
    else:
        query = f"""
            SELECT t.tip_pro_descricao as 'nome'
            FROM wcm_tipos_protocolos t 
            WHERE t.tip_pro_id = {numeroprotocolo}
        """

    resultado = executarQuery(DB1, query)
    nome = resultado[0]["nome"]

    if not resultado:
        return f"{nome_dicionario} (PD{nome_dinamico})"
    return f"{nome}  [PD{nome_dinamico}]"