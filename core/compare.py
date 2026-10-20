import mysql.connector as mysql # Biblioteca usada para conectar com o banco de dados
from core.normalizar import NORMALIZADORES # Arquivo Py que "normaliza" colunas ESPECIFICAS para que consigam ser comparadas corretamente
from core import db # Meu arquivo separado que define as conexões de banco
from utils.repairid import encontrarId
from core.cleandata import limparValor

def carregarSql(caminho):
    with open(caminho, "r", encoding="utf-8") as f:
        return f.read()

def executarQuery(config, query):
    try:
        conexao = mysql.connect(**config)
    except Exception as erro:
        print("\nOpa!, não foi possivel se conectar nos bancos informados (verifique as conexões do .env)")
        print(f"Erro: {erro}")
    cursor = conexao.cursor(dictionary=True)
    cursor.execute(query)
    resultado = cursor.fetchall()
    cursor.close()
    conexao.close()
    return resultado

def procurarInexistentes(resultado1, resultado2, chave_db1, chave_db2):

    dados1 = {
        linha[chave_db1]: linha
        for linha in resultado1
        if linha[chave_db1] is not None
    }

    dados2 = {
        linha[chave_db2]: linha
        for linha in resultado2
        if linha[chave_db2] is not None
    }

    inexistentes = []
    total_registros_webcamara = len(dados1)

    todos_ids = set(dados1.keys()) | set(dados2.keys())

    for registro_id in sorted(todos_ids):

        if registro_id not in dados1:
            # Pega a linha completa do Banco 2 referente ao ID
            linha = dados2[registro_id]

            dadoslinha, nome_identificador = encontrarId(linha)

            inexistentes.append(
                f'{nome_identificador} "{dadoslinha}" existe apenas no BANCO 2'
            )

        elif registro_id not in dados2:
            # Pega a linha completa do Banco 1 referente ao ID
            linha = dados1[registro_id]

            dadoslinha, nome_identificador = encontrarId(linha)

            inexistentes.append(
                f'{nome_identificador} "{dadoslinha}" existe apenas no BANCO 1'
            )

    return total_registros_webcamara, inexistentes

# =====================================================
# COMPARADOR DOS CAMPOS
# =====================================================

def procurarDiferencas(resultado1, resultado2, chave_db1, chave_db2, mapeamento):
    
    dados1 = {
        linha[chave_db1]: linha
        for linha in resultado1
    }
    dados2 = {
        linha[chave_db2]: linha
        for linha in resultado2
    }

    diferencas = []
    ids_comuns = set(dados1.keys()) & set(dados2.keys())

    for registro_id in sorted(ids_comuns):

        linha1 = dados1[registro_id]
        linha2 = dados2[registro_id]

        for campo_db1, campo_db2 in mapeamento.items():

            valor1 = limparValor(linha1.get(campo_db1))
            valor2 = limparValor(linha2.get(campo_db2))

            if campo_db1 in NORMALIZADORES:
                valor1 = NORMALIZADORES[campo_db1](valor1) # Procura a coluna nos normalizadores, e retorna ela normalizada

            if campo_db2 in NORMALIZADORES:
                valor2 = NORMALIZADORES[campo_db2](valor2)
                
            if valor1 != valor2:
                dadoslinha, nome_identificador = encontrarId(linha2)
                diferencas.append({
                    f"{nome_identificador}": dadoslinha,
                    "COLUNA-WEBCAMARA": campo_db1,
                    "VALOR ANTIGO": valor1,
                    "NOVO VALOR": valor2,
                })

    return diferencas



