listadosvariaveis = {
    "Funcionários": {
        "parametro_where": "wc.codigo_cadastro_unico_importado IN", 
        "oqueseraprocurado": "ID-Funcionario-NovoWCM"
    },
    "Politicos": {
        "parametro_where": "wc.cad_uni_politico = 1", 
    }
}

def trocarDados(resultado1, query2, cfg):
    if "{parametro_where}" in query2:
        listain = []
        documento = listadosvariaveis.get(cfg["nome"])
        parametro = documento["parametro_where"]
        if documento.get("oqueseraprocurado"):
            for registro in resultado1:
                valor = registro.get(documento["oqueseraprocurado"])
                if valor is not None:
                    listain.append(valor)
            parametrocompleto = parametro + " " + str(tuple(listain))
            query2 = query2.replace("{parametro_where}", parametrocompleto)
        else:   
            query2 = query2.replace("{parametro_where}", parametro)
        # print(query2) 
    return query2

