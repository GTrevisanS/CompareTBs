
/* ========================================
   Variáveis globais
======================================== */

var modulos = [];
var selecionados = [];
var ultimoResultado = null;


/* ========================================
   Funções auxiliares
======================================== */

// Atalho para buscar elementos pelo ID.
var $ = function (id) {
    return document.getElementById(id);
};

// Escapa caracteres especiais para evitar que valores
// inseridos na interface sejam interpretados como HTML.
function esc(v) {
    return String(v == null ? "" : v)
        .replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;")
        .replace(/"/g, "&quot;")
        .replace(/'/g, "&#039;");
}

// Realiza requisições à API e trata respostas com erro.
async function api(url, opts) {
    var r = await fetch(url, opts || {});
    var d = await r.json();

    if (!r.ok) {
        throw new Error(d.erro || "Falha na solicitação.");
    }

    return d;
}

// Limita o texto exibido sem alterar o valor original.
function limitarTexto(valor, limite) {
    var texto = String(valor == null ? "" : valor);

    if (texto.length <= limite) {
        return esc(texto);
    }

    return esc(texto.substring(0, limite)) + "...";
}


/* ========================================
   Inicialização da aplicação
======================================== */

async function iniciar() {
    // Verifica a conexão e identifica o tipo de migração.
    try {
        var s = await api("/api/status");

        $("connection").textContent = "Conectado: " + s.banco2;
        $("migration").textContent = s.tipo_migracao;

    } catch (e) {
        $("connection").textContent = "Falha ao carregar conexão";
        $("migration").textContent = "Migração não identificada";
    }

    // Carrega os módulos disponíveis para comparação.
    try {
        var d = await api("/api/modulos");

        modulos = d.modulos || [];

        renderModulos();

    } catch (e) {
        $("modules").textContent = "Erro ao carregar módulos: " + e.message;
    }
}


/* ========================================
   Renderização dos módulos
======================================== */

function renderModulos() {
    var q = $("search").value
        .toLocaleLowerCase("pt-BR")
        .trim();

    // Filtra os módulos conforme o texto pesquisado.
    var lista = modulos.filter(function (m) {
        return m.nome.toLocaleLowerCase("pt-BR").includes(q);
    });

    // Monta a lista de módulos na interface.
    $("modules").innerHTML = lista.length
        ? lista.map(function (m) {
            var on = selecionados.includes(m.id);

            return `
                <label class="module ${on ? "selected" : ""}">
                    <input
                        type="checkbox"
                        data-id="${esc(m.id)}"
                        ${on ? "checked" : ""}
                    >
                    <span>${esc(m.nome)}</span>
                </label>
            `;
        }).join("")
        : "Nenhum módulo encontrado.";

    // Atualiza a seleção quando um checkbox é alterado.
    $("modules").querySelectorAll("input").forEach(function (input) {
        input.addEventListener("change", function () {
            var id = input.dataset.id;

            if (input.checked && !selecionados.includes(id)) {
                selecionados.push(id);

            } else {
                selecionados = selecionados.filter(function (x) {
                    return x !== id;
                });
            }

            renderModulos();
        });
    });

    // Atualiza a quantidade de módulos selecionados.
    $("count").textContent = selecionados.length + " selecionado(s)";

    // Habilita a comparação somente quando houver seleção.
    $("compare").disabled = !selecionados.length;

    // Atualiza a orientação exibida ao usuário.
    $("hint").textContent = selecionados.length
        ? selecionados.length + " módulo(s) pronto(s) para comparação."
        : "Selecione os módulos para começar.";
}


/* ========================================
   Eventos da seleção de módulos
======================================== */

// Pesquisa de módulos.
$("search").addEventListener("input", renderModulos);


// Seleciona todos os módulos que correspondem à pesquisa.
$("selectAll").addEventListener("click", function () {
    var q = $("search").value
        .toLocaleLowerCase("pt-BR")
        .trim();

    modulos.forEach(function (m) {
        var corresponde = m.nome
            .toLocaleLowerCase("pt-BR")
            .includes(q);

        if (corresponde && !selecionados.includes(m.id)) {
            selecionados.push(m.id);
        }
    });

    renderModulos();
});


// Limpa todos os módulos selecionados.
$("clear").addEventListener("click", function () {
    selecionados = [];

    renderModulos();
});


/* ========================================
   Execução da comparação
======================================== */

$("compare").addEventListener("click", async function () {
    // Desabilita o botão e exibe o indicador de carregamento.
    $("compare").disabled = true;

    $("loading").classList.remove("hidden");
    $("results").classList.add("hidden");

    try {
        // Envia os módulos selecionados para a API Python.
        ultimoResultado = await api("/api/comparar", {
            method: "POST",

            headers: {
                "Content-Type": "application/json"
            },

            body: JSON.stringify({
                documentos: selecionados
            })
        });

        // Exibe os resultados recebidos.
        renderResultados(ultimoResultado);

    } catch (e) {
        // Exibe uma mensagem caso a comparação falhe.
        $("messages").innerHTML = `
            <div class="message error">
                ${esc(e.message)}
            </div>
        `;

        $("results").classList.remove("hidden");

    } finally {
        // Oculta o carregamento e atualiza os módulos.
        $("loading").classList.add("hidden");

        renderModulos();
    }
});


/* ========================================
   Renderização do resumo
======================================== */

function renderResultados(d) {
    var s = d.resumo || {};

    // Dados dos cards de resumo.
    var cards = [
        ["Módulos comparados", s.modulos_comparados || 0, ""],
        ["Módulos limpos", s.modulos_limpos || 0, "green"],
        ["Diferenças encontradas", s.total_diferencas || 0, "orange"],
        ["Registros Inexistentes", s.total_inexistentes || 0, "red"],
        ["Erros de execução", d.totalerros || 0, "red"]
    ];

    // Monta os cards de resumo.
    $("summary").innerHTML = cards.map(function (c) {
        return `
            <div class="summary-card ${c[2]}">
                <div class="label">${esc(c[0])}</div>
                <div class="value">${esc(c[1])}</div>
                <div class="line"></div>
            </div>
        `;
    }).join("");


    // Exibe o status geral da comparação.
    $("messages").innerHTML = d.totalerros
        ? `
            <div class="message error">
                ${d.totalerros} módulo(s) apresentaram erro.
                Confira os detalhes.
            </div>
        `
        : `
            <div class="message success">
                Comparação concluída sem erros de execução.
            </div>
        `;


    // Mantém apenas módulos com erros ou inconsistências.
    var rs = (d.resultados || []).filter(function (r) {
        return r.erro
            || (r.diferencas || []).length
            || (r.inexistentes || []).length;
    });


    // Renderiza os resultados detalhados.
    $("resultList").innerHTML = rs.length
        ? rs.map(renderModulo).join("")
        : `
            <div class="empty">
                Nenhuma diferença ou registro inexistente foi encontrado.
            </div>
        `;


    // Exibe a seção e direciona a tela para os resultados.
    $("results").classList.remove("hidden");

    // $("results").scrollIntoView({
    //     behavior: "smooth"
    // });
}


/* ========================================
   Renderização dos resultados por módulo
======================================== */

function renderModulo(r) {
    var dif = Array.isArray(r.diferencas)
        ? r.diferencas
        : [];

    var ine = Array.isArray(r.inexistentes)
        ? r.inexistentes
        : [];

    var cols = r.contatotalcolunas || 0;
    var body = "";


    // Exibe o erro do módulo, se houver.
    if (r.erro) {
        body += `
            <div class="error-text">
                ${esc(r.erro)}
            </div>
        `;
    }


    // Monta a tabela de diferenças.
    if (dif.length) {
        var keys = Object.keys(dif[0]);

        body += `
            <details>
                <summary>
                    ${dif.length} diferença(s) encontrada(s)
                </summary>

                <div class="table-wrap">
                    <table>
                        <thead>
                            <tr>
                                ${keys.map(function (k) {
                                    return `<th>${esc(k)}</th>`;
                                }).join("")}
                            </tr>
                        </thead>

                        <tbody>
                            ${dif.map(function (row) {
                                return `
                                    <tr>
                                        ${keys.map(function (k) {
                                            var valor = String(row[k] == null ? "" : row[k]);
                                            var limite = 100;

                                            return `
                                                <td title="${esc(valor)}">
                                                    ${limitarTexto(valor, limite)}
                                                </td>
                                            `;
                                        }).join("")}
                                    </tr>
                                `;
                            }).join("")}
                        </tbody>
                    </table>
                </div>
            </details>
        `;
    }


    // Monta a tabela de registros inexistentes.
    if (ine.length) {
        body += `
            <details>
                <summary>
                    ${ine.length} registro(s) inexistente(s)
                </summary>

                <div class="table-wrap">
                    <table>
                        <thead>
                            <tr>
                                <th>Descrição</th>
                            </tr>
                        </thead>

                        <tbody>
                            ${ine.map(function (x) {
                                return `
                                    <tr>
                                        <td>${esc(x)}</td>
                                    </tr>
                                `;
                            }).join("")}
                        </tbody>
                    </table>
                </div>
            </details>
        `;
    }


    // Retorna o card completo do módulo.
    return `
        <article class="result-card">

            <div class="result-head">

                <div>
                    <h3>${esc(r.modulo)}</h3>

                    <p>
                        ${cols} coluna(s) mapeada(s)
                        · ${esc(r.totalregistros || 0)} registro(s)
                    </p>
                </div>

                <div class="pills">

                    <span class="pill neutral">
                        ${cols} colunas
                    </span>

                    ${dif.length
                        ? `
                            <span class="pill orange">
                                ${dif.length} diferenças
                            </span>
                        `
                        : ""
                    }

                    ${ine.length
                        ? `
                            <span class="pill red">
                                ${ine.length} inexistentes
                            </span>
                        `
                        : ""
                    }

                    ${r.erro
                        ? `
                            <span class="pill red">
                                Erro
                            </span>
                        `
                        : ""
                    }

                </div>

            </div>

            <div class="body">
                ${body || `
                    <div class="message success">
                        Nenhuma inconsistência neste módulo.
                    </div>
                `}
            </div>

        </article>
    `;
}


/* ========================================
   Exportação dos resultados
======================================== */

$("export").addEventListener("click", function () {
    // Não exporta caso ainda não exista resultado.
    if (!ultimoResultado) {
        return;
    }

    // Converte o resultado em um arquivo JSON.
    var blob = new Blob(
        [
            JSON.stringify(ultimoResultado, null, 2)
        ],
        {
            type: "application/json"
        }
    );

    // Cria um link temporário para iniciar o download.
    var url = URL.createObjectURL(blob);
    var a = document.createElement("a");

    a.href = url;
    a.download = "comparacao-CompareTBs.json";

    a.click();

    // Libera a URL temporária.
    URL.revokeObjectURL(url);
});


/* ========================================
   Inicialização
======================================== */

iniciar();