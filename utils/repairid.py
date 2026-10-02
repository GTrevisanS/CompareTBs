# ====================================================== AJUSTE DE ID ======================================================

possibilidades = {
    'ses_nome_identificador': 'Numero / tipo da sessão (NovoWCM)',                                       # UTILIZADO PARA SESSÕES  
    'IDENTIFICADOR-PROTOCOLO-NOVOWCM': 'ID / Data Hora do Protocolo (NovoWCM)',   # UTILIZADO SOMENTE EM PROTOCOLOS
    'doc_codigo_individual_ano': 'Código-Ano do registro',                        # UTILIZADO PARA DOCUMENTOS NO GERAL
    'codigo_outros_documentos_importado': 'ID de importação da ata',              # UTILIZADO PARA ATA 
    'NOME-COMISSAO': 'Nome da Comissão',                                          # UTILIZADO PARA NOMES DE COMISSOES
    'CODIGO-MANIFESTACAO': 'Código da manifestação',                              # UTILIZADO PARA CODIGO DE MANIFESTAÇÃO (E-SIC E OUVIDORIA)
    'cad_uni_nome': 'Nome do cadastro único (NovoWCM)',                           # UTILIZADO PARA NOMES (CADASTROS UNICOS) EM GERAL
    'usu_sis_login': 'Login / do usuário (NovoWCM)',                              # UTILIZADO PARA NOMES (USUARIOS)
    'mes_dir_descricao': 'Nome da mesa diretora (NovoWCM)',                       # UTILIZADO PARA MESAS DIRETORAS
    'IDENTIFICADOR-REVOGACAO': 'ID da Query do NovoWCM que identifica a ação',    # UTILIZADO PARA REVOGACAO E ALTERAÇÃO DE LEIS (USUARIOS)
    'CODIGO-INDIVIDUAL-ANO': 'Codigo de identificação'                            # UTILIZADO PARA REVOGACAO E ALTERAÇÃO DE LEIS (USUARIOS)
}   

def trocar_id(documento, possibilidade):
    colunacerta = documento.get(possibilidade)
    if colunacerta is not None and colunacerta != "":
        return colunacerta
    return None


def encontrar_id(linha):
    dadoscoluna = None
    nome_identificador = ""
    for nome_coluna, descricao in possibilidades.items():
        newdados = trocar_id(linha, nome_coluna)
        if newdados is not None:
            dadoscoluna = newdados
            nome_identificador = descricao
            # Para no primeiro identificador encontrado,
            # evitando conflito entre possíveis identificadores.
            break
    return dadoscoluna, nome_identificador