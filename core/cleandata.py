import unicodedata
import re 

def removerAcentos(texto: str) -> str:
    # Normaliza o texto separando o caractere base do seu acento
    nfkd = unicodedata.normalize('NFKD', texto)
    # Filtra mantendo apenas caracteres que não possuem propriedades de acentuação
    textolimpo = "".join([c for c in nfkd if not unicodedata.combining(c)])
    return textolimpo
    

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


def limparValor(valor):
    """
    (Função PRINCIPAL para normalizar valores / colunas)
    Essa função roda para todos as colunas, independente
    se é uma coluna TEXT (como a ementa), ou se é uma coluna
    INT (como o codigo do documento)  
    """
    # 1º - No caso do valor vir Nulo ou vazio, transformo ele em "0" e termino a função aqui mesmo (Porque fica mais fácil de trabalhar)
    if valor is None or str(valor).replace(" ", "") == "":
        return '0'
    # 2º - Eu faço ter certeza que o valor é uma string limpa (sem espaços ou caracteres em caixa alta)
    valor = str(valor).strip().lower()
    valor = re.sub(r"\s+", " ", valor)

    # 3º - Utilizo meu dicionário criado externamente para traduzir (trocar os caracteres estranhos) utilizando a função translate
    valor = valor.translate(CARACTERES_NORMALIZADOS)  
    
    # 4º - Passo pela minha função de remoção de acentuação geral e retorno o valor 100% formatado.
    valor = removerAcentos(valor)

    # 5º - Por último, verifico se o valor é apenas digitos, caso for, retorna o número formatado ("000" -> "0")
    if valor.isdigit():
        valor = str(int(valor))
    return valor

def finalmenteRetornar(valor):
    if valor is None or valor.strip() == "":
        valor = "0"
    return valor

