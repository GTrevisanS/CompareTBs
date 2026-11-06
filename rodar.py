import time, json, os
from pathlib import Path
from flask import Flask, Response, request, send_from_directory
from backend.core.db import carregarBancos
from backend.core.cleansql import ajustarQuery
from backend.core.compare import carregarSql, executarQuery, procurarInexistentes, procurarDiferencas
from backend.utils.pdname import encontrarNomeProtocolo as findpdname
from backend.utils.switchdata import trocarDados
from backend.utils.sistemas import identificarSistema


BASE_DIR = Path(__file__).resolve().parent

ROOT = BASE_DIR / "backend"
FRONTEND = BASE_DIR / "frontend"

app = Flask(__name__, static_folder=None)

DB1, DB2, DB3 = carregarBancos()
b1, b1_host, b1_port, b2, b2_host, b2_port, tipo_migracao = identificarSistema(DB1, DB2)

if tipo_migracao == "Migração do Webcamara":
    pasta_origem = ROOT / "sql" / "origem" / "WebCamara"
else:
    pasta_origem = ROOT / "sql" / "origem" / "AntigoWCM"

def abrirJSON(caminho):
    with open(str(caminho), encoding="utf-8") as arquivo:
        return json.load(arquivo)

CONFIGURACOES = abrirJSON(pasta_origem / "dicionario.json")
PADROES = abrirJSON(pasta_origem / "tabelas.json")
REJEITAR = ["Sessões (Expedientes)", "Leis - Revogação", "Leis - Alteração", "Protocolos"]

def resposta(dados, status=200):
    return Response(json.dumps(dados, ensure_ascii=False, default=str),
                    status=status, mimetype="application/json; charset=utf-8")
def opcoes_modulos():
    return [
        {"id": str(chave), "nome": str(cfg.get("nome", "Módulo sem nome"))}
        for chave, cfg in CONFIGURACOES.items()
        if cfg.get("nome") not in REJEITAR
    ]

def carregar_config_modulo(documento):
    cfg = CONFIGURACOES.get(str(documento))
    if not isinstance(cfg, dict):
        raise ValueError("Configuração não encontrada para o documento: " + str(documento))

    if cfg.get("mapeamento"):
        mapeamento = cfg["mapeamento"]
        query1_path = "sql/origem/" + cfg["query1"]
        query2_path = "sql/destino/" + cfg["query2"]
    else:
        tabela = str(cfg.get("tabela", ""))
        padrao = PADROES.get(tabela)
        if not isinstance(padrao, dict):
            raise ValueError("Padrão de consulta não encontrado para a tabela: " + tabela)
        mapeamento = padrao["mapeamento"]
        query1_path = "sql/origem/" + padrao["query1"]
        query2_path = "sql/destino/" + padrao["query2"]

    return cfg, cfg.get("parametros") or {}, mapeamento, query1_path, query2_path

def caminho_sql(caminho):
    caminho = Path(str(caminho))
    return str(caminho if caminho.is_absolute() else ROOT / caminho)


def comparar_todos(documentos):
    resultados, total_erros = [], 0

    for documento in documentos:

        # Inicia o temporizador do documento.
        inicio_documento = time.perf_counter()

        nome = "Módulo desconhecido"
        mapeamento, parametros = {}, {}
        diferencas, inexistentes, total_registros, erro_texto = [], [], 0, None

        try:
            cfg, parametros, mapeamento, q1_path, q2_path = carregar_config_modulo(documento)
            nome = cfg.get("nome", nome)
            chave1, chave2 = cfg["chave1"], cfg["chave2"]

            query1 = ajustarQuery(carregarSql(caminho_sql(q1_path)), parametros)
            query2 = ajustarQuery(carregarSql(caminho_sql(q2_path)), parametros)

            resultado1 = executarQuery(DB1, query1)

            if tipo_migracao == "Migração do Webcamara":
                query2 = trocarDados(resultado1, query2, cfg)

            resultado2 = executarQuery(DB2, query2)

            total_registros, inexistentes = procurarInexistentes(
                resultado1, resultado2, chave1, chave2
            )

            diferencas = procurarDiferencas(
                resultado1, resultado2, chave1, chave2, mapeamento
            )

        except Exception as erro:
            total_erros += 1
            erro_texto = str(erro)

        if "Protocolo Dinamico" in str(nome):
            try:
                if tipo_migracao == "Migração do Webcamara":
                    nome = findpdname(nome, tipo_migracao)
                else:
                    nome = findpdname(
                        nome, tipo_migracao,
                        parametros.get("tipo_cadastro_generico_antigowcm")
                    )
            except Exception:
                pass

        # Finaliza o temporizador do documento.
        fim_documento = time.perf_counter()

        tempo_documento = round(
            fim_documento - inicio_documento, 3
        )

        resultados.append({
            "id": str(documento),
            "modulo": nome,
            "contatotalcolunas": len(mapeamento) if isinstance(mapeamento, dict) else 0,
            "diferencas": diferencas,
            "inexistentes": inexistentes,
            "totalregistros": total_registros,
            "erro": erro_texto,

            # Tempo individual do documento.
            "tempo_execucao_individual": tempo_documento
        })

    return resultados, total_erros


@app.route("/")
def index():
    return send_from_directory(str(FRONTEND), "index.html")

@app.route("/<path:arquivo>")
def arquivos_frontend(arquivo):
    if arquivo in ("style.css", "script.js", "particles.js") or arquivo.endswith(".svg"):
        return send_from_directory(str(FRONTEND), arquivo)
    return resposta({"erro": "Arquivo não encontrado."}, 404)

@app.route("/api/status")
def status():
    return resposta({
        "banco1": b1, "banco1_host": b1_host, "banco1_porta": b1_port,
        "banco2": b2, "banco2_host": b2_host, "banco2_porta": b2_port,
        "tipo_migracao": tipo_migracao
    })

@app.route("/api/modulos")
def modulos():
    return resposta({"modulos": opcoes_modulos()})


@app.route("/api/comparar", methods=["POST"])
def comparar():
    dados = request.get_json(silent=True) or {}
    documentos = dados.get("documentos", [])

    if not isinstance(documentos, list) or not documentos:
        return resposta({"erro": "Selecione pelo menos um módulo."}, 400)

    ids_validos = set(item["id"] for item in opcoes_modulos())
    documentos = [str(item) for item in documentos if str(item) in ids_validos]

    if not documentos:
        return resposta({"erro": "Nenhum módulo válido foi selecionado."}, 400)

    # Inicia o temporizador da comparação.
    inicio = time.perf_counter()

    resultados, total_erros = comparar_todos(documentos)

    diferencas = sum(len(r["diferencas"]) for r in resultados)
    inexistentes = sum(len(r["inexistentes"]) for r in resultados)

    # Módulos sem registros para comparação.
    vazios = sum(
        1 for r in resultados
        if not r["erro"]
        and r["totalregistros"] == 0
    )

    # Módulos que possuem registros e não apresentam divergências.
    limpos = sum(
        1 for r in resultados
        if not r["erro"]
        and r["totalregistros"] > 0
        and not r["diferencas"]
        and not r["inexistentes"]
    )

    divergentes = len(resultados) - (vazios + limpos)

    # Finaliza o temporizador.
    fim = time.perf_counter()

    tempo_execucao = round(fim - inicio, 3)

    return resposta({
        "resultados": resultados,
        "totalerros": total_erros,

        # Tempo total da comparação em segundos.
        "tempo_execucao": tempo_execucao,

        "resumo": {
            "modulos_comparados": len(resultados),
            "modulos_limpos": limpos,
            "modulos_vazios": vazios,
            "modulos_divergentes": divergentes,
            "total_diferencas": diferencas,
            "total_inexistentes": inexistentes,
            "totalregistros": sum(r["totalregistros"] for r in resultados)
        }
    })


if __name__ == "__main__":
    PORTA = 5000
    HOST = "127.0.0.1"
    URL = HOST + ":" + str(PORTA)
    os.system(f'start chrome "{URL}"') # Abre já na página correta 
    app.run(host=HOST, port=PORTA, debug=False) # Executa o programa no instante seguinte
