from dotenv import load_dotenv
load_dotenv(dotenv_path='./data/.env') # CARREGA O ARQUIVO .ENV
import os

def carregar_bancos():
    DB1 = { 
        "host": os.getenv("DATABASE-1-HOST"),
        "port": int(os.getenv("DATABASE-1-PORT")),
        "user": os.getenv("DATABASE-1-USER"),
        "password": os.getenv("DATABASE-1-PASS"),
        "database": os.getenv("DATABASE-1-NAME")
    }
    DB3 = os.getenv("DATABASE-3-NAME")
    DB2 = { 
        "host": os.getenv("DATABASE-2-HOST"),
        "port": int(os.getenv("DATABASE-2-PORT")),
        "user": os.getenv("DATABASE-2-USER"),
        "password": os.getenv("DATABASE-2-PASS"),
        "database": os.getenv("DATABASE-2-NAME")
    }
    return DB1, DB2, DB3

def carregar_conexao():
    DB1, DB2, DB3 = carregar_bancos()
    DESCRIPT = os.getenv("NOVOWCM_DESCRIPTOGRAFIA_DOCUMENTO")    # Código de descriptografia usado para ler corretamente os dados sensiveis

    os.system('cls')
    print('')
    print("="*50)
    print(f'Banco WebCamara.....{DB1["database"]}')
    print(f'Banco NovoWCM.......{DB2["database"]}')
    print("="*50)

    return DB1, DB2, DB3, DESCRIPT