
# ================================= NORMALIZA OS CODIGOS DE ANO QUE VEM ERRADOS / BUGADOS =================================


# def corrige_int(valor):
#     nome, numero = valor.split(" - ")
#     # print(numero)
#     numero = numero.replace(" ", "")
#     numero = str(int(numero))
#     # print(numero)
#     return f'{nome} {numero}'

def codigo_individual_ano(valor):
    valor = str(valor)
    if valor.count("-") != 1:
        return valor
    else:
        import re
        valor = re.sub(r'[a-zA-Z]', '', valor) # Nessa linha utilizo a biblioteca re para remover toda e qualquer letra de "A" até "Z"
        numero, ano = valor.split("-")
        if not numero:
            numero = '0000'
        if ',' in numero:
            codigocerto = f"{numero}-{ano}"
        else:
            codigocerto = f"{int(numero):04d}-{ano}"
    return codigocerto

# ================================ NORMALIZA O NUMERO DE DOCUMENTO PESSOAL DESCRIPTOGRAFADO ===============================


def descriptografia_hex(valor):
    valor = str(valor).strip()
    valor = valor.replace("b", "").replace("'","")
    # valor = valor.replace("/", "").replace("-", "").replace(".", "")
    # if not valor.isdigit() and not valor.isalpha(): # Retirei o IF em 08/09 por causa de um cliente que escrevia os documentos com a numeração espaçada
    valor = valor.replace(" ", "")
    return valor
    

def descriptografia_hex_limpa(valor):
    valor = str(valor).strip()
    valor = valor.replace("b", "").replace("'","")
    valor = valor.replace("/", "").replace("-", "").replace(".", "")
    # if not valor.isdigit() and not valor.isalpha(): # Retirei o IF em 08/09 por causa de um cliente que escrevia os documentos com a numeração espaçada
    valor = valor.replace(" ", "")
    return valor


# =========================================== NORMALIZA SITUACOES DE TRAMITACAO ===========================================


def situacao(valor):
    match str(valor):
        case "totalmente revogado":
            valor = "revogada totalmente"
        case _:
            pass
    return valor


# =============================================== NORMALIZA TIPOS DE PARECER ==============================================


def tipo_parecer(valor):
    match str(valor):
        case "comissao permanente" | "comissao temporaria":
            valor = "comissoes"
        case "parecer juridico":
            valor = "juridico"
        case _:
            pass
    return valor


# ======================================== NORMALIZA A DATA DO NOVOWCM -> WEBCAMARA =======================================


def n_data(valor): 
    valor = str(valor).strip()
    valor = valor[:10] 
    # A linha acima faz com que a data tenha somente 10 caracteres 
    # (Removendo o horário que vem acompanhado na frente, já que geralmente é "00:00:00")
    return valor


def add_hour(valor): 
    valor = str(valor).strip()
    if valor == '0' or valor == '' or valor is None:
        return '0'
    elif len(valor) <= 11:
        return f'{valor} 00:00:00'
    return valor


# =============================================== NORMALIZAR COLUNAS DO E-SIC =============================================


def sic_code(valor):
    valor = str(valor).split("-")
    PrimeiraFatia = valor[0]
    if PrimeiraFatia.isdigit():
        novovalor = int(PrimeiraFatia)
    else:
        novovalor = PrimeiraFatia
    return str(novovalor)


def sic_tipo(valor):
    valor = valor.strip().lower()
    tiposmanifestacoes = {
        'denúncias': 'denúncia',
        'denuncias': 'denuncia',
        'elogios': 'elogio'
    }

    return tiposmanifestacoes.get(valor, valor)


def sic_sit(valor):
    valor = str(valor)
    match valor:
        case "0" | "":
            valor = "aberto" # Digo que quando uma solicitação não possuia nada no banco antigo, ela deve vir como aberta
        case _:
            pass
    return valor


# =============================================== NORMALIZAR ESTADOS CIVIS DOS POLITICOS =============================================


def estados_civis(valor):
    valor = str(valor).lower()
    if valor.count("separado") > 0 or valor.count("separada") > 0:
        valor = "Divorciado (a)"
    elif valor.count("divorciado") > 0 or valor.count("divorciada") > 0:
        valor = "Divorciado (a)"
    else: pass
    match valor:
        case "solteira" | "solteiro":
            valor = "Solteiro(a)"
        case "casado" | "casada":
            valor = "Casado (a)"
        case _:
            pass

    return valor.strip().lower()


# ========================================= NORMALIZA OS NOMES CONCATENADOS QUE VEM DAS COMISSOES =========================================


def concat_nomes(valor):
    valores = valor.split('___') # Pego a string concatenada e separo pelo ___ criando uma lista
    valores = sorted(valores)    # Reordeno essa lista para ficar em ordem alfabética
    newlista = []                # Crio uma nova lista vazia onde seram adicionados os nomes tratados
    for nome in valores:
        nomecorrigido = nome.strip()
        newlista.append(nomecorrigido)
    # Por fim trago os nomes em formato de string novamente (separados por uma virgula) para que o streamlit
    # não alerte um erro por esperar um string e receber uma lista 
    resultado = ", ".join(newlista) 
    # print(resultado)
    return resultado


def ajusta_cpf(valor):
    valor = str(valor).zfill(11)
    if valor.count('0') == 11:
        valor = '0' # Se for apenas zeros por completo, o valor volta a ser apenas 1 zero
        # print(valor)
        # print(type(valor))
    return valor




# ================================================== PROTOCOLOS DO WEBCAMARA PRO NOVOWCM ==================================================


termosajustados = {
        'lei ordinaria': 'leis ordinarias',
        'emendas a lom': 'emenda a lom',
        'proposta de emendas a lom': 'proposta de emenda a lom',
        'requerimento': 'requerimentos',
        'recurso': 'recursos',
        'edital de convocacao': 'edital',
        'edital de licitacao': 'edital',
        # 'emenda': 'emendas',
        'oficio': 'oficios enviados',
        'parecer': 'pareceres',
        'oficios administracao municipal': 'recebido do executivo',
        'pareceres tribunal de contas': 'parecer do tribunal de contas',
        'balancete prefeitura': 'balancete da prefeitura',
        'balancetes': 'balancete da prefeitura',
        'mocao': 'mocoes',
        'indicacao': 'indicacoes',
        'ata da sessao': 'atas das sessoes',
        'parecer tribunal de contas': 'parecer do tribunal de contas',
        'atestado': 'atestados',
        'anteprojeto': 'anteprojetos',
        'denuncia': 'denuncias',
        'recebido do executivo': 'oficios administracao municipal',
        'atos do presidente': 'atos da presidencia'
    }


def tipo_protocolo(valor):
    return termosajustados.get(valor, valor)


def protocolante(valor):
    valor = str(valor).strip()
    if valor == "0" or valor == "" or valor is None:
        valor = "webline" 
    return valor


# ========================================= LISTA DAS COLUNAS À SEREM NORMALIZADAS =========================================


def corrige_tipo_doc(valor):
    for termo, substituto in termosajustados.items():
        if termo in valor:
            valor = valor.replace(termo, substituto, 1)
    return valor



def corrige_tipo_doc_novowcm(valor):
    tipos_atas = {
        " - ordinaria": "",
        " - extraordinaria": "",
        " - solene": "",
        " - especial": ""
    }
    for cada in tipos_atas.keys():
        if cada in valor:
            valor = valor.replace(cada, "")
    return valor



# =========================================================== wcm ===========================================================
# =========================================================== wcm ===========================================================
# =========================================================== wcm ===========================================================


def corrige_numero_protocolo_wcm(valor):
    # Se não for uma string válida ou não tiver hífen, garante o padrão básico
    valor_str = str(valor).strip()
    if '-' not in valor_str:
        return valor_str if valor_str else "0000-0000"
    
    # Divide garantindo que sempre teremos duas partes, mesmo se faltar um lado
    partes = valor_str.split('-', 1)
    esquerda = partes[0].strip()
    direita = partes[1].strip()
    
    # Formata a esquerda: se for número, põe zeros; se for vazia, assume '0000'
    esquerda_formatada = f"{int(esquerda):04d}" if esquerda.isdigit() else "0000"
    
    # Formata a direita: se estiver vazia, assume '0000'
    direita_formatada = direita if direita else "0000"
    
    return f"{esquerda_formatada}-{direita_formatada}"



def corrige_int(valor):
    valor = str(valor).strip()

    # Caso: "leis complementares - 82"
    if " - " in valor:
        nome, numero = valor.rsplit(" - ", 1)

    # Caso: "leis complementares 82"
    else:
        partes = valor.rsplit(" ", 1)

        if len(partes) != 2:
            return valor

        nome, numero = partes

    numero = numero.replace(" ", "").strip()

    if not numero.isdigit():
        return valor

    numero = numero.zfill(4)

    return f"{nome.strip()} {numero}"

    
def limpa_format_lista(valor):
    valor = str(valor).replace('[', '').replace(']', '').replace('_', ' ')

    valores = valor.split(',')

    valores = [
        palavra.strip()
        for palavra in valores
        if palavra.strip()
    ]

    valores.sort(key=str.lower)

    return ', '.join(valores)


def limpa_format_dicionario(valor):
    if valor is None:
        return '0'

    # Se for realmente um dicionário, trata os valores separadamente
    if isinstance(valor, dict):
        valores = []

        for chave, valor_dicionario in valor.items():
            if valor_dicionario not in (0, 1):
                continue

            chave = str(chave).replace('_', ' ').strip()

            if chave:
                valores.append(chave)

        valores.sort(key=str.lower)

        return ', '.join(valores) if valores else '0'

    # Trata caso o dicionário tenha vindo como texto
    valor = str(valor).strip()

    if valor.startswith('{') and valor.endswith('}'):
        valor = valor[1:-1]

        valores = []

        for item in valor.split(','):
            if ':' not in item:
                continue

            chave, valor_dicionario = item.split(':', 1)

            chave = chave.replace('"', '').replace("'", '').replace('_', ' ').strip()
            valor_dicionario = valor_dicionario.replace('"', '').replace("'", '').strip()

            if valor_dicionario in ('0', '1') and chave:
                valores.append(chave)

        valores.sort(key=str.lower)

        return ', '.join(valores) if valores else '0'

    # Caso seja uma lista
    return limpa_format_lista(valor)



def aperfeicoa_revog(valor):
    valor = corrige_int(valor)
    valor = corrige_tipo_doc(valor)
    return valor




NORMALIZADORES = {
    "LEI-QUE-REVOGA": aperfeicoa_revog,
    "LEI-REVOGADA": aperfeicoa_revog,
    "LEI-REVOGADA-NOVOWCM": aperfeicoa_revog,
    "LEI-QUE-REVOGA-NOVOWCM": aperfeicoa_revog,
    "doc_despacho_presidencia": limpa_format_dicionario,
    "DOCUMENTO-EXPEDIENTE-WEBCAMARA": corrige_tipo_doc,
    "DOCUMENTO-EXPEDIENTE-NOVOWCM": corrige_tipo_doc_novowcm,
    "MEMBROS-COMISSAO-WEBCAMARA": concat_nomes,
    "MEMBROS-COMISSAO": concat_nomes,
    "CODIGO-INDIVIDUAL-ANO": codigo_individual_ano,
    "CODIGO-MANIFESTACAO": sic_code,
    "NUMERO-PROTOCOLO-NOVOWCM": corrige_numero_protocolo_wcm,
    "CNPJ-NOVOWCM": descriptografia_hex_limpa,
    "CPF-NOVOWCM": descriptografia_hex,
    "RG-NOVOWCM": descriptografia_hex,
    "CNPJ": descriptografia_hex_limpa,
    "CPF-WEBCAMARA": ajusta_cpf,
    "RG": descriptografia_hex,
    "Estado_Civil": estados_civis,
    "DATA-NASCIMENTO-NOVOWCM": descriptografia_hex,
    "TIPO-MANIFESTACAO": sic_tipo,
    "SIC-SIT": sic_sit,
    "situacao": situacao,
    "TIPOS-PARECERES": tipo_parecer,
    "TIPO-PROTOCOLO-WEBCAMARA": tipo_protocolo,
    "RESPONSAVEL-PROTOCOLO-WEBCAMARA": protocolante,
    "Data-Protocolo-Dinamico": n_data,
    "DATA-EMISSAO-TITULO-ELEITORAL": n_data,
    "DATA-EMISSAO-RG": n_data,
    "DATA-NASCIMENTO": n_data,
    "Data-oficio-diverso": n_data,
    "Data_Inicio_Tramitacao": n_data,
    "DATA-CONTRATO": n_data,
    "DATA-REGISTRO": add_hour,
    "DATA-INICIO": add_hour,
    "DATA-INICIO-TRAMITACAO": add_hour,
    "DATA-LIMITE-TRAMITACAO": add_hour,
    "DATA-FIM": add_hour,
}



