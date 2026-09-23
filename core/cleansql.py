import unicodedata
import re 
from core.db import carregar_conexao # Meu arquivo separado que define as conexões de banco

DB1, DB2, DB3, DESCRIPT = carregar_conexao()

def ajustar_query(query, parametros):
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


def remover_acentos(texto: str) -> str:
    # Normaliza o texto separando o caractere base do seu acento
    nfkd = unicodedata.normalize('NFKD', texto)
    # Filtra mantendo apenas caracteres que não possuem propriedades de acentuação
    texto_sem_acento = "".join([c for c in nfkd if not unicodedata.combining(c)])
    return texto_sem_acento



CARACTERES_NORMALIZADOS = str.maketrans({ 
        # Crio um dicionário de tradução contendo os caracteres de acentuação
        # presentes no texto normalizado para que sejam removidos.
        "–": "-",
        "—": "-",
        "“": '"',
        "”": '"',
        "‘": "'",
        "’": "'",
        "•": "."
})

def limparvalor(valor):
    """
    (Função PRINCIPAL para normalizar valores / colunas)
    Essa função roda para todos as colunas, independente
    se é uma coluna TEXT (como a ementa), ou se é uma coluna
    INT (como o codigo do documento)  
    """
    # 1º - No caso do valor vir Nulo ou vazio, transformo ele em "0" e termino a função aqui mesmo (Porque fica mais fácil de trabalhar)
    if valor is None or str(valor).strip() == "":
        return "0" 
    # 2º - Eu faço ter certeza que o valor é uma string limpa (sem espaços ou caracteres em caixa alta)
    valor = str(valor).strip().lower()
    valor = re.sub(r"\s+", " ", valor)

    # 3º - Utilizo meu dicionário criado externamente para traduzir (trocar os caracteres estranhos) utilizando a função translate
    valor = valor.translate(CARACTERES_NORMALIZADOS)  
    
    # 4º - Passo pela minha função de remoção de acentuação geral e retorno o valor 100% formatado.
    valor = remover_acentos(valor)

    # 5º - Por último, verifico se o valor é apenas digitos, caso for, retorna o número formatado ("000" -> "0")
    if valor.isdigit():
        valor = str(int(valor))
    return valor
