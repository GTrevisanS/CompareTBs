from dotenv import load_dotenv
load_dotenv(dotenv_path='./backend/data/.env')
import os

def obterVariavel(nome):
    valor = os.getenv(nome)
    if valor is None or valor.strip() == '':
        raise ValueError(f"\n\nVariável '{nome}' não encontrada no .env")
    return valor

def carregarBancos():
    try:
        DB1 = {
            "host": obterVariavel("DATABASE-1-HOST"),
            "port": int(obterVariavel("DATABASE-1-PORT")),
            "user": obterVariavel("DATABASE-1-USER"),
            "password": obterVariavel("DATABASE-1-PASS"),
            "database": obterVariavel("DATABASE-1-NAME")
        }

        DB3 = obterVariavel("DATABASE-3-NAME")

        DB2 = {
            "host": obterVariavel("DATABASE-2-HOST"),
            "port": int(obterVariavel("DATABASE-2-PORT")),
            "user": obterVariavel("DATABASE-2-USER"),
            "password": obterVariavel("DATABASE-2-PASS"),
            "database": obterVariavel("DATABASE-2-NAME")
        }
        return DB1, DB2, DB3

    except Exception as erro:
        print(f"Erro ao carregar os dados do .env: {erro}")
        raise


def carregarConexao():
    try:
        DB1, DB2, DB3 = carregarBancos()
        DESCRIPT = os.getenv("NOVOWCM_DESCRIPTOGRAFIA_DOCUMENTO")

        os.system('cls')
        print('')
        print("=" * 50)
        print(f'Banco WebCamara.....{DB1["database"]}')
        print(f'Banco NovoWCM.......{DB2["database"]}')
        print("=" * 50)
        return DB1, DB2, DB3, DESCRIPT

    except Exception as erro:
        print(f"Erro ao carregar conexões: {erro}")
        raise