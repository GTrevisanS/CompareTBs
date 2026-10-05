import streamlit as st # Biblioteca responsável por gerar o Frontend
import random # Biblioteca que eu uso pra trazer cores aleatórias nos nomes dos documentos
import pandas # Biblioteca utilizada pra montar as tabelas de diferenças que são exibidas no streamlit
from core.cleansql import ajustar_query # Função para trocar os termos / variáveis das consultas (ex: "{bancowcm4}")
from utils.pdname import encontrar_nome_protocolo as findpdname # Função utilizada para corrigir / trocar 
# os nomes retornados dos protocolos dinamicos (visto que o cliente geralmente troca o nome)
import json # Biblioteca usada para manusear os arquivos json
from core.db import carregar_bancos # Arquivo separado que define as conexões de banco
from core.compare import carregar_sql, executar_query, procurar_inexistentes, procurar_diferencas
from utils.switchdata import trocar_dados
from utils.sistemas import identificar # arquivo pra coletar nome, conexão e porta que é exibido no tooltip acíma

def abrirJson(caminho):
    with open(caminho, encoding="utf8") as combinacoes:
        ARQUIVO = json.load(combinacoes)
    return ARQUIVO

DB1, DB2, DB3 = carregar_bancos()
b1, b1_host, b1_port, b2, b2_host, b2_port, tipo_migracao = identificar(DB1, DB2)

if tipo_migracao == 'Migração do Webcamara':
    caminho_dicionario = 'sql/origem/WebCamara/dicionario.json'
    caminho_dicionario_padroes = 'sql/origem/WebCamara/tabelas.json'
    CONFIGURACOES = abrirJson(caminho_dicionario)
    PADROES = abrirJson(caminho_dicionario_padroes)
else:
    caminho_dicionario = 'sql/origem/AntigoWCM/dicionario.json'
    caminho_dicionario_padroes = 'sql/origem/AntigoWCM/tabelas.json'
    CONFIGURACOES = abrirJson(caminho_dicionario)
    PADROES = abrirJson(caminho_dicionario_padroes)


def sistema(padrao, documento):
    if padrao == 'Migração do Webcamara':
        cfg = CONFIGURACOES.get(str(documento))
        parametros = cfg.get("parametros")
        if cfg.get("mapeamento"):
            mapeamento = cfg["mapeamento"]
            query1 = cfg["query1"]
            query2 = cfg["query2"]
        else:
            padrao = PADROES.get(str(cfg["tabela"]))
            mapeamento = padrao["mapeamento"]
            query1 = padrao["query1"]
            query2 = padrao["query2"]
        chave1 = cfg["chave1"]
        chave2 = cfg["chave2"]
        nomemodulo = cfg["nome"]
    else:
        cfg = CONFIGURACOES.get(str(documento))
        tabela = cfg["tabela"]
        padrao = PADROES.get(str(tabela))
        parametros = cfg.get("parametros")
        mapeamento = padrao["mapeamento"]
        query1 = padrao["query1"]
        query2 = padrao["query2"]
        nomemodulo = cfg["nome"]
        chave1 = cfg["chave1"]
        chave2 = cfg["chave2"]
    return cfg, parametros, mapeamento, query1, query2, chave1, chave2, nomemodulo


def comparar_todos(documentos, totalerros):
    resultados = []
    for documento in documentos:
        cfg, parametros, mapeamento, query1, query2, chave1, chave2, nomemodulo = sistema(tipo_migracao, documento)
        try:
            query1 = ajustar_query(carregar_sql(query1), parametros)
            query2 = ajustar_query(carregar_sql(query2), parametros)

            resultado1 = executar_query(DB1, query1)
            if tipo_migracao == 'Migração do Webcamara':
                query2 = trocar_dados(resultado1, query2, cfg)  # corrigir depois no webcamara
            resultado2 = executar_query(DB2, query2)

            # if len(resultado1) != len(resultado2):
            #     print(f"opa, {nomemodulo} está com problemas")
            totalregistros, inexistentes = procurar_inexistentes(resultado1, resultado2, chave1, chave2)
            diferencas = procurar_diferencas(resultado1, resultado2, chave1, chave2, mapeamento)

        except Exception as erro:
            diferencas, inexistentes, totalregistros = 0, 0, 1
            totalerros += 1
            titulo = f' Erro ao comparar e encontrar diferenças de: "{nomemodulo}" '.center(224, '-')
            rodape = f''.center(224, '-')
            print('\n\n')
            print(titulo)
            print(f'\nERRO: {erro}\n')
            print(rodape)
            print('\n\n')
        
        totalcolunas = len(mapeamento)
        if tipo_migracao == 'Migração do Webcamara' and nomemodulo.count("Protocolo Dinamico") != 0:
            try:
                nomemodulo = findpdname(nomemodulo, tipo_migracao)
            except Exception as falha:
                print(f"Não foi possivel altetar o nome do {nomemodulo} pelo seguinte erro:")
                print(falha)
        elif nomemodulo.count("Protocolo Dinamico") != 0: 
            try:
                nomemodulo = findpdname(nomemodulo, tipo_migracao, parametros.get('tipo_cadastro_generico_antigowcm'))
            except Exception as falha:
                print(f"Não foi possivel altetar o nome do {nomemodulo} pelo seguinte erro:")
                print(falha)
        else:
            pass

        conteudo = {
            "modulo": nomemodulo,
            "contatotalcolunas": totalcolunas,
            "diferencas": diferencas,
            "inexistentes": inexistentes,
            "totalregistros": totalregistros
        }
        resultados.append(conteudo)

    print("\nFim da execução do comparador :)")
    return resultados, totalerros


# ==================================== Configurações ==================================== #

st.set_page_config(
    page_title="CompareTBs",
    page_icon="🐞",
    layout="wide"
)

st.title("CompareTBs 🐞")
st.markdown(f':grey[Conectado à:] :green["{b2}"]  :grey[({tipo_migracao})]', 
    help=f"""
```text
DB1......  {b1}
HOST.....  {b1_host}
PORTA....  {b1_port}
-----------------------------------------
DB2......  {b2}
HOST.....  {b2_host}
PORTA....  {b2_port}
```
"""
)

# ====================== Lógica do input que recebe os documentos ======================= #

opcoes = {}
rejeitar = ["Sessões (Expedientes)", "Leis - Revogação", "Leis - Alteração"] # Lista de documentos rejeitados / que não aparecem disponíveis no input do streamlit 

for chave, cfg in CONFIGURACOES.items():
    if cfg["nome"] not in rejeitar:
        opcoes[str(chave)] = str(cfg["nome"])
    else:
        pass

input_documentos = st.multiselect( 
    ":grey[Escolha os documentos que deseja realizar a comparação]",
    options=list(opcoes.keys()),
    placeholder="Projeto de...",
    help=
    f"""Aqui listam todos os tipos de documento e tabelas disponiveis para comparação
     (Pode ser que alguma tabela esteja bloqueada para não listar por problemas técnicos)
     
    Atualmente Bloqueando:  {rejeitar}""",
    format_func=lambda x: opcoes[x]
)


# ========================== Lógica da exibição dos resultados ========================= #
resultados = []
totalerros = 0

if input_documentos:
    with st.spinner(":violet[Comparando os bancos...]"):
        resultados, totalerros = comparar_todos(input_documentos, totalerros)

moduloscomparados = 0
moduloslimpos = 0
modulosvazios = 0
totalregistrosgeral = 0
nomesmodulosvazios = []

colors = ['orange', 'blue', 'red', 'violet', 'rainbow', 'yellow', 'green']

for resultado in resultados:

    nome_modulo = f'{resultado["modulo"]}'
    total_colunas = resultado["contatotalcolunas"]
    totalregistrosmodulo = resultado["totalregistros"]
    moduloscomparados += 1

    if totalregistrosmodulo == 0:
        modulosvazios += 1
        nomesmodulosvazios.append(str(nome_modulo))
    else:
        totalregistrosgeral+=totalregistrosmodulo

    if not resultado["diferencas"] and not resultado["inexistentes"]:
        moduloslimpos += 1
        pass
    else:
        with st.container(border=True):

            total_dif = len(resultado["diferencas"])
            total_ine = len(resultado["inexistentes"])
            titulo_colunas = f':grey[{total_colunas} colunas]'

            titulo_diferencas = f'###### :orange-background[:orange[{total_dif} Diferenças]]'
            titulo_inexistentes = f'###### :red-background[:red[{total_ine} Inexistentes]]'
            titulo_registros = f'###### :violet-background[:violet[{totalregistrosmodulo} Registros]]'

            col1, col2, col3, col4, col5, col6 = st.columns([2.4, 3, 0.7, 0.7, 0.7, 0.7]) # Ajustei levemente os tamanhos para caber o texto do pills
            cor = random.choice(colors)

            col1.write(f"### :{cor}[_{nome_modulo}_]")

            if total_dif and total_ine:
                col3.write(titulo_colunas)
                col4.write(titulo_diferencas)
                col5.write(titulo_inexistentes)
                col6.write(titulo_registros)
            elif total_ine and not total_dif:
                col4.write(titulo_colunas)
                col5.write(titulo_inexistentes)
                col6.write(titulo_registros)
            elif total_dif and not total_ine:
                col4.write(titulo_colunas)
                col5.write(titulo_diferencas)
                col6.write(titulo_registros)
 
            if resultado["diferencas"]:
                st.dataframe(pandas.DataFrame(resultado["diferencas"]), width='stretch', hide_index=True)
            if resultado["inexistentes"]:
                inexistentes = []
                for every in resultado["inexistentes"]:
                    inexistentes.append(every)
                with st.expander(f"( {len(inexistentes)} ) IDs inexistentes encontrados"):
                    for every in inexistentes:
                        st.code(every)
            
# ==================== Informações adicionais que ficam no "rodapé" ==================== #

# if nomesmodulosvazios:
#     with st.container(border=True):
#         st.write(f":grey[Lista de módulos vazios encontrados: {nomesmodulosvazios}]")

col1, col2, col3, col4, col5, col6, col7 = st.columns([1.4, 2, 1.1, 0.9, 0.9, 1.2, 0.8])


# Força o encerramento bruto do servidor
if col1.button(":red[Encerrar Processo !]", width='stretch'):    
    from rodar import DerrubarProcesso
    DerrubarProcesso()

moduloslimpos = moduloslimpos - modulosvazios

if resultados:
    st.toast(f":grey[Foram comparados mais de {totalregistrosgeral*2} registros.]")
    if totalerros:
        st.toast(f":red[{totalerros} Módulos deram erro!]")
        col2.write(f":red-background[:red[Módulos que deram erro...{totalerros}]]")
    else:
        st.toast(":green[Todos os módulos rodaram sem problemas!]")
    st.toast(":green[Comparação concluída!]")

col3.write(f":red-background[:red[Módulos inconsistentes...{moduloscomparados - (moduloslimpos + modulosvazios)}]]")
col4.write(f":blue-background[:blue[Módulos limpos...{moduloslimpos}]]")
col5.write(f":green-background[:green[Módulos vazios...{modulosvazios}]]")
col6.write(f":orange-background[:orange[Módulos sendo comparados...{moduloscomparados}]]")
col7.write(f":violet-background[:violet[{totalregistrosgeral} comparações]]")
