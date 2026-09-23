import subprocess as subp
import time
import os
import socket

def DerrubarProcesso(): 
    import signal 
    import psutil 
    # Obtém o processo atual do Python que roda o Streamlit 
    pid = os.getpid() 
    os.system('cls') 
    print(f"\nProcesso {pid} encerrado com sucesso.") 
    processo = psutil.Process(pid) 
    # Mata o processo atual e todos os subprocessos filhos que ele criou 
    for filho in processo.children(recursive=True): 
        filho.kill() 
    return processo.kill() # Finaliza de forma bruta o processo pai


def encontrar_porta_disponivel(porta_inicial):
    Tentativa = False
    porta = porta_inicial
    while True:
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            Tentativa = (s.connect_ex(("localhost", porta)) != 0)
            if Tentativa is False:
                porta += 1
            else:
                break
    return porta


def RodarPrograma(programa, porta_passada):
    porta = encontrar_porta_disponivel(porta_passada)
    subp.Popen(
        [
            "python",
            "-m",
            "streamlit",
            "run",
            programa,
            "--server.headless",
            "true",
            "--server.port",
            str(porta)
        ]
    )
    os.system('cls')
    print(f'\nIniciando "{programa}" na porta {porta}!\n')
    time.sleep(1.6)
    os.system(f'start chrome "http://localhost:{porta}"')

if __name__ == "__main__":              # Caso eu chame o rodar primeiro, ele considera que é o principal e não tenho problema dele ficar recriando páginas depois por engano
    RodarPrograma("main.py", 8501)      # Tenta rodar o streamlit na porta 8501 (No caso de já estar ocupada, a função verifica e tenta executar na porta seguinte)