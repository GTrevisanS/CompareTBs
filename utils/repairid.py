# ====================================================== AJUSTE DE ID ======================================================

possibilidades = {
    'IDENTIFICADOR-PROTOCOLO-NOVOWCM': 'ID / Data Hora do Protocolo (NovoWCM)',   # UTILIZADO SOMENTE EM PROTOCOLOS
    'doc_codigo_individual_ano': 'Código-Ano do registro',                        # UTILIZADO PARA DOCUMENTOS NO GERAL
    'codigo_outros_documentos_importado': 'ID de importação da ata',              # UTILIZADO PARA ATA 
    'ses_nome': 'Nome da sessão (NovoWCM)',                                       # UTILIZADO PARA SESSÕES  
    'NOME-COMISSAO': 'Nome da Comissão',                                          # UTILIZADO PARA NOMES DE COMISSOES
    'CODIGO-MANIFESTACAO': 'Código da manifestação',                              # UTILIZADO PARA CODIGO DE MANIFESTAÇÃO (E-SIC E OUVIDORIA)
    'cad_uni_nome': 'Nome do cadastro único (NovoWCM)',                           # UTILIZADO PARA NOMES (CADASTROS UNICOS) EM GERAL
    'usu_sis_login': 'Login / do usuário (NovoWCM)',                              # UTILIZADO PARA NOMES (USUARIOS)
    'IDENTIFICADOR-REVOGACAO': 'ID da Query do NovoWCM que identifica a ação'     # UTILIZADO PARA REVOGACAO E ALTERAÇÃO DE LEIS (USUARIOS)
}   

def trocar_id(documento, possibilidade):
    colunacerta = documento.get(possibilidade)
    if colunacerta:
        return colunacerta
    return None

def encontrar_id(linha):
    dadoscoluna = None
    nome_identificador = ""
    for nome_coluna, descricao in possibilidades.items():
        newdados = trocar_id(linha, nome_coluna)
        if newdados:
            dadoscoluna = newdados
            nome_identificador = descricao
            # Adicionado o break no for para que não haja divergencia de identificador de colunas 
            # (no caso de conter 2 no select e ele acabar misturando as coisas)
            break 
    return dadoscoluna, nome_identificador