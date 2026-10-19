
# ================================= NORMALIZA OS CODIGOS DE ANO QUE VEM ERRADOS / BUGADOS =================================


# def corrige_int(valor):
#     nome, numero = valor.split(" - ")
#     # print(numero)
#     numero = numero.replace(" ", "")
#     numero = str(int(numero))
#     # print(numero)
#     return f'{nome} {numero}'


def ajustarCodigoIndividual(valor):

    import re

    def ajustaCaractere(valor, caractere):
        numero, ano = valor.split(caractere, 1)
        if not numero or ',' in numero:
            numero = '0000'
        else:
            numero = f"{int(numero):04d}"
        return f"{numero}{caractere}{ano}"

    valor = str(valor)

    if "-" not in valor and "/" not in valor:
        return valor

    valor = re.sub(r'[a-zA-Z]', '', valor)

    if "-" in valor:
        valor = ajustaCaractere(valor, "-")
    if "/" in valor:
        valor = ajustaCaractere(valor, "/")
    return valor

# ================================ NORMALIZA O NUMERO DE DOCUMENTO PESSOAL DESCRIPTOGRAFADO ===============================


def limparDescriptografiasHex(valor):
    valor = str(valor).strip()
    valor = valor.replace("b", "").replace("'","")
    # valor = valor.replace("/", "").replace("-", "").replace(".", "")
    # if not valor.isdigit() and not valor.isalpha(): # Retirei o IF em 08/09 por causa de um cliente que escrevia os documentos com a numeração espaçada
    valor = valor.replace(" ", "")
    return valor
    

def limparDescriptografiasHexPorCompleto(valor):
    valor = str(valor).strip()
    valor = valor.replace("b", "").replace("'","")
    valor = valor.replace("/", "").replace("-", "").replace(".", "")
    # if not valor.isdigit() and not valor.isalpha(): # Retirei o IF em 08/09 por causa de um cliente que escrevia os documentos com a numeração espaçada
    valor = valor.replace(" ", "")
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


def limitarData(valor): 
    valor = str(valor).strip()
    valor = valor[:10] 
    # A linha acima faz com que a data tenha somente 10 caracteres 
    # (Removendo o horário que vem acompanhado na frente, já que geralmente é "00:00:00")
    return valor


def aumentarData(valor): 
    valor = str(valor).strip()
    if valor == '0' or valor == '' or valor is None:
        return ''
    elif len(valor) <= 11:
        return f'{valor} 00:00:00'
    return valor


# =============================================== NORMALIZAR COLUNAS DO E-SIC =============================================


def ajustarCodigoSic(valor):
    valor = str(valor).split("-")
    PrimeiraFatia = valor[0]
    if PrimeiraFatia.isdigit():
        novovalor = int(PrimeiraFatia)
    else:
        novovalor = PrimeiraFatia
    return str(novovalor)


def ajustarTipoSic(valor):
    valor = valor.strip().lower()
    tiposmanifestacoes = {
        'denúncias': 'denúncia',
        'denuncias': 'denuncia',
        'elogios': 'elogio'
    }
    return tiposmanifestacoes.get(valor, valor)


def ajustarSituacaoSic(valor):
    valor = str(valor)
    match valor:
        case "0" | "":
            valor = "aberto" # Digo que quando uma solicitação não possuia nada no banco antigo, ela deve vir como aberta
        case _:
            pass
    return valor


# =============================================== NORMALIZAR ESTADOS CIVIS DOS POLITICOS =============================================


def ajustarEstadosCivis(valor):
    valor = str(valor).lower()
    if valor.count("separado") > 0 or valor.count("separada") > 0:
        valor = "Divorciado (a)"
    elif valor.count("divorciado") > 0 or valor.count("divorciada") > 0:
        valor = "Divorciado (a)"
    else: pass
    match valor:
        case "solteira" | "solteiro":
            valor = "Solteiro (a)"
        case "casado" | "casada":
            valor = "Casado (a)"
        case "viuvo" | "viuva":
            valor = "viuvo (a)"
        case "juntada" | "juntado":
            valor = "juntado (a)"
        case _:
            pass

    return valor.strip().lower()


# ========================================= NORMALIZA OS NOMES CONCATENADOS QUE VEM DAS COMISSOES =========================================


def desconcatenarNomes(valor):
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


def ajustarCPF(valor):
    valor = str(valor).strip().zfill(11)
    if valor.count('0') == 11:
        valor = '0' # Se for apenas zeros por completo, o valor volta a ser apenas 1 zero
    return valor.replace(' ', '')




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


def ajustaNumeroProtocoloWCM(valor):
    # Se não for uma string válida ou não tiver hífen, garante o padrão básico
    valor_str = str(valor).strip()

    # print(f"valor com strip: {valor}")
    # input()

    if valor_str.startswith('-1-'):
        return ''

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


def limparFormatoDicionario(valor):
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



def aperfeicoarRevogacao(valor):
    valor = corrige_int(valor)
    valor = corrige_tipo_doc(valor)
    return valor


NORMALIZADORES = {
    "PROTOCOLO-REGISTRO": ajustaNumeroProtocoloWCM,
    "LEI-QUE-REVOGA": aperfeicoarRevogacao,
    "LEI-REVOGADA": aperfeicoarRevogacao,
    "LEI-REVOGADA-NOVOWCM": aperfeicoarRevogacao,
    "LEI-QUE-REVOGA-NOVOWCM": aperfeicoarRevogacao,
    "doc_despacho_presidencia": limparFormatoDicionario,
    "DOCUMENTO-EXPEDIENTE-WEBCAMARA": corrige_tipo_doc,
    "DOCUMENTO-EXPEDIENTE-NOVOWCM": corrige_tipo_doc_novowcm,
    "MEMBROS-COMISSAO-WEBCAMARA": desconcatenarNomes,
    "MEMBROS-COMISSAO": desconcatenarNomes,
    "CODIGO-INDIVIDUAL-ANO": ajustarCodigoIndividual,
    "doc_codigo_individual": ajustarCodigoIndividual,
    "NUMERO-PROCESSO": ajustarCodigoIndividual,
    "CODIGO-MANIFESTACAO": ajustarCodigoSic,
    "NUMERO-PROTOCOLO-NOVOWCM": ajustaNumeroProtocoloWCM,
    "CNPJ-NOVOWCM": limparDescriptografiasHexPorCompleto,
    "CPF-NOVOWCM": limparDescriptografiasHex,
    "RG-NOVOWCM": limparDescriptografiasHex,
    "CNPJ": limparDescriptografiasHexPorCompleto,
    "CPF-WEBCAMARA": ajustarCPF,
    "RG": limparDescriptografiasHex,
    "Estado_Civil": ajustarEstadosCivis,
    "DATA-NASCIMENTO-NOVOWCM": limparDescriptografiasHex,
    "DATA-NASCIMENTO": limitarData,
    "TIPO-MANIFESTACAO": ajustarTipoSic,
    "SIC-SIT": ajustarSituacaoSic,
    "TIPOS-PARECERES": tipo_parecer,
    "TIPO-PROTOCOLO-WEBCAMARA": tipo_protocolo,
    "RESPONSAVEL-PROTOCOLO-WEBCAMARA": protocolante,
    "DATA-EMISSAO-TITULO-ELEITORAL": limitarData,
    "DATA-EMISSAO-RG": limitarData,
    "DATA-CONTRATO": limitarData,
    "DATA-REALIZACAO": limitarData,
    "DATA-REGISTRO": aumentarData,
    "DATA-INICIO": aumentarData,
    "DATA-FIM": aumentarData,
    "DATA-INICIO-TRAMITACAO": aumentarData,
    "DATA-LIMITE-TRAMITACAO": aumentarData,
    "com_data_inicio": aumentarData,
    "com_data_fim": aumentarData,
    "ses_codigo_individual": ajustarCodigoIndividual
}



