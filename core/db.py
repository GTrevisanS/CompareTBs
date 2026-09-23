
def carregar_conexao():
    
    from dotenv import load_dotenv
    import os

    load_dotenv(dotenv_path='./data/.env') # CARREGA O ARQUIVO .ENV

    DB1 = { 
        "host": os.getenv("WEBCAMARA_HOST"),
        "port": int(os.getenv("WEBCAMARA_PORT")),
        "user": os.getenv("WEBCAMARA_USER"),
        "password": os.getenv("WEBCAMARA_PASSWORD"),
        "database": os.getenv("WEBCAMARA_DATABASE")
    }
    DB2 = {
        "host": os.getenv("NOVOWCM_HOST"),
        "port": int(os.getenv("NOVOWCM_PORT")),
        "user": os.getenv("NOVOWCM_USER"),
        "password": os.getenv("NOVOWCM_PASSWORD"),
        "database": os.getenv("NOVOWCM_DATABASE"),
    }

    DB3 = os.getenv("WCM_4_DATABASE")                            # Banco do wcm4 utilizado para ajustar a query do webcamara
    DESCRIPT = os.getenv("NOVOWCM_DESCRIPTOGRAFIA_DOCUMENTO")    # Código de descriptografia usado para ler corretamente os dados sensiveis

    os.system('cls')
    print('')
    print("="*50)
    print(f'Banco WebCamara.....{os.getenv("WEBCAMARA_DATABASE")}')
    print(f'Banco NovoWCM.......{os.getenv("NOVOWCM_DATABASE")}')
    print("="*50)

    return DB1, DB2, DB3, DESCRIPT