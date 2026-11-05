
/* ========================================
   Notificações Toast
======================================== */

function alertaSucesso(titulo, mensagem) {
    Swal.fire({
        toast: true,
        position: 'top-end',
        icon: 'success',
        title: titulo,
        text: mensagem,
        showConfirmButton: false,
        timer: 6500,
        timerProgressBar: true,
        customClass: {
            popup: 'toast-custom',
            title: 'toast-title',
            htmlContainer: 'toast-message',
            timerProgressBar: 'toast-progress'
        }
    });
}

function alertaErro(titulo, mensagem) {
    Swal.fire({
        toast: true,
        position: 'top-end',
        icon: 'error',
        title: titulo,
        text: mensagem,
        showConfirmButton: false,
        timer: 8000,
        timerProgressBar: true,
        customClass: {
            popup: 'toast-custom',
            title: 'toast-title',
            htmlContainer: 'toast-message',
            timerProgressBar: 'toast-progress'
        }
    });
}

function alertaAviso(titulo, mensagem) {
    Swal.fire({
        toast: true,
        position: 'top-end',
        icon: 'warning',
        title: titulo,
        text: mensagem,
        showConfirmButton: false,
        timer: 7000,
        timerProgressBar: true,
        customClass: {
            popup: 'toast-custom',
            title: 'toast-title',
            htmlContainer: 'toast-message',
            timerProgressBar: 'toast-progress'
        }
    });
}


/* ========================================
   Variáveis globais
======================================== */

var modulos = [];
var selecionados = [];
var pesquisaIniciada = false;
var temporizadorComparacao = null;
var idComparacao = 0;


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

        $("connection").innerHTML = `
            ${esc(s.banco1)} --> ${esc(s.banco2)}
        `;
        $("migration").innerHTML = `
            ${esc(s.tipo_migracao)}
        `;

    } catch (e) {
        $("connection").textContent = "Falha ao carregar conexão";
        $("migration").textContent = "Migração não identificada";

        alertaErro(
            "Falha na conexão!",
            e.message
        );
    }

    // Carrega os módulos disponíveis para comparação.
    try {
        var d = await api("/api/modulos");

        modulos = d.modulos || [];

        renderModulos();

    } catch (e) {
        $("modules").textContent = "Erro ao carregar módulos: " + e.message;

        alertaErro(
            "Erro ao carregar módulos!",
            e.message
        );
    }
}


/* ========================================
   Renderização do Taggable Multi-Select
======================================== */

function renderModulos() {

    var q = $("search").value
        .toLocaleLowerCase("pt-BR")
        .trim();

    // Normaliza os identificadores.
    selecionados = selecionados.map(String);

    // Recupera os módulos selecionados.
    var selecionadosHtml = modulos
        .filter(function (m) {
            return selecionados.includes(String(m.id));
        })
        .map(function (m) {
            return `
                <span class="module-tag">
                    ${esc(m.nome)}

                    <button
                        type="button"
                        class="remove-tag"
                        data-remove="${esc(m.id)}"
                        title="Remover módulo"
                    >
                        ×
                    </button>
                </span>
            `;
        }).join("");

    $("selectedModules").innerHTML = selecionadosHtml;

    // Filtra os módulos disponíveis.
    var lista = modulos.filter(function (m) {
        return m.nome
            .toLocaleLowerCase("pt-BR")
            .includes(q);
    });

    // Renderiza as opções.
    $("modules").innerHTML = lista.length
        ? lista.map(function (m) {

            var id = String(m.id);
            var on = selecionados.includes(id);

            return `
                <div
                    class="module-option ${on ? "selected" : ""}"
                    data-id="${esc(id)}"
                >
                    <span>${esc(m.nome)}</span>

                    <span class="option-check">
                        ${on ? "✓" : ""}
                    </span>
                </div>
            `;

        }).join("")
        : `
            <div class="no-options">
                Nenhum módulo encontrado.
            </div>
        `;

    // Evento de seleção dos módulos.
    $("modules").querySelectorAll(".module-option").forEach(function (option) {

        option.addEventListener("click", function () {

            var id = option.dataset.id;

            if (selecionados.includes(id)) {

                selecionados = selecionados.filter(function (x) {
                    return x !== id;
                });

            } else {

                selecionados.push(id);

            }
            // Limpa o campo de pesquisa após selecionar.
            $("search").value = "";
            renderModulos();

            // Agenda a comparação automática.
            agendarComparacao();


        });

    });

    // Evento para remover uma tag individualmente.
    $("selectedModules").querySelectorAll(".remove-tag").forEach(function (button) {

        button.addEventListener("click", function (e) {

            e.stopPropagation();

            var id = button.dataset.remove;

            selecionados = selecionados.filter(function (x) {
                return x !== id;
            });

            renderModulos();

            // Agenda a comparação automática.
            agendarComparacao();

            $("search").focus();

        });

    });

    // Atualiza a orientação exibida ao usuário.
    $("hint").textContent = selecionados.length
        ? selecionados.length + " módulo(s) selecionado(s)."
        : "Nenhum módulo selecionado ainda.";
}


/* ========================================
   Eventos do Taggable Multi-Select
======================================== */


// Abre a lista ao clicar ou focar no campo de pesquisa.
$("search").addEventListener("focus", function () {
    $("modules").classList.add("open");
});

$("search").addEventListener("click", function () {
    $("modules").classList.add("open");
});


// Pesquisa em tempo real.
$("search").addEventListener("input", function () {

    // Esconde o placeholder definitivamente após começar a digitar.
    if (this.value.length > 0) {
        this.placeholder = "";
    }

    $("modules").classList.add("open");

    renderModulos();

});

// NOVO: Seleciona os módulos filtrados ao pressionar Enter.
$("search").addEventListener("keydown", function (e) {
    
    if (e.key !== "Enter") {
        return;
    }

    e.preventDefault();

    var q = $("search").value
        .toLocaleLowerCase("pt-BR")
        .trim();

    // Não seleciona tudo caso o campo esteja vazio.
    if (!q) {
        return;
    }

    // Recupera os módulos que correspondem à pesquisa.
    var encontrados = modulos.filter(function (m) {

        return m.nome
            .toLocaleLowerCase("pt-BR")
            .includes(q);

    });

    // Adiciona os módulos encontrados.
    encontrados.forEach(function (m) {

        var id = String(m.id);

        if (!selecionados.includes(id)) {
            selecionados.push(id);
        }

    });

    // Limpa a pesquisa e atualiza a interface.
    $("search").value = "";
    renderModulos();
    $("modules").classList.remove("open");

    // Executa a comparação automática.
    agendarComparacao();

});

// Fecha a lista ao clicar fora do componente.
document.addEventListener("click", function (e) {
    if (!$("multiSelect").contains(e.target)) {
        $("modules").classList.remove("open");
    }
});

// Seleciona todos os módulos que correspondem à pesquisa.
$("selectAll").addEventListener("click", function () {

    var q = $("search").value
        .toLocaleLowerCase("pt-BR")
        .trim();

    modulos.forEach(function (m) {

        var corresponde = m.nome
            .toLocaleLowerCase("pt-BR")
            .includes(q);

        var id = String(m.id);

        if (corresponde && !selecionados.includes(id)) {
            selecionados.push(id);
        }

    });

    renderModulos();

    // Agenda a comparação automática.
    agendarComparacao();

});

// Limpa todos os módulos selecionados.
$("clear").addEventListener("click", function () {

    selecionados = [];

    renderModulos();

    // Agenda a comparação automática.
    agendarComparacao();

});


/* ========================================
   Comparação automática
======================================== */

// Aguarda um pequeno intervalo antes de iniciar a comparação.
// Isso evita várias execuções em sequência durante a seleção.
function agendarComparacao() {

    clearTimeout(temporizadorComparacao);

    // Invalida uma possível comparação anterior.
    idComparacao++;

    var idAtual = idComparacao;

    // Se não houver módulos selecionados, limpa os resultados.
    if (!selecionados.length) {

        $("results").classList.add("hidden");
        $("footer").classList.add("hidden");
        $("loading").classList.add("hidden");

        return;
    }

    temporizadorComparacao = setTimeout(function () {

        compararModulos(idAtual);

    }, 350);

}


// Executa a comparação dos módulos selecionados.
async function compararModulos(id) {

    // Ignora execuções antigas.
    if (id !== idComparacao) {
        return;
    }

    // Oculta o rodapé sempre que uma comparação for iniciada.
    $("footer").classList.add("hidden");

    // Exibe o carregamento e oculta os resultados anteriores.
    $("loading").classList.remove("hidden");
    $("results").classList.add("hidden");

    try {

        // Envia os módulos selecionados para a API Python.
        var resultado = await api("/api/comparar", {

            method: "POST",

            headers: {
                "Content-Type": "application/json"
            },

            body: JSON.stringify({
                documentos: selecionados
            })

        });

        // Ignora resultados de comparações antigas.
        if (id !== idComparacao) {
            return;
        }

        // Exibe os resultados recebidos.
        renderResultados(resultado);

    } catch (e) {

        // Só exibe o erro se a comparação ainda for a atual.
        if (id === idComparacao) {

            alertaErro(
                "Erro na comparação!",
                e.message
            );

        }

    } finally {

        // Só atualiza a interface se esta ainda for
        // a comparação mais recente.
        if (id === idComparacao) {

            $("loading").classList.add("hidden");

            // Mantém o rodapé oculto após a comparação.
            $("footer").classList.add("hidden");

            renderModulos();

        }

    }

}


/* ========================================
   Renderização do resumo
======================================== */

function renderResultados(d) {

    var s = d.resumo || {};

    // Dados dos cards de resumo.
    var cards = [
        ["Módulos comparados", s.modulos_comparados || 0, ""],
        ["Módulos vazios", s.modulos_vazios || 0, "green"],
        ["Módulos limpos", s.modulos_limpos || 0, "blue"],
        ["Módulos divergentes", s.modulos_divergentes || 0, "orange"],

        // ["Diferenças encontradas", s.total_diferencas || 0, "orange"],
        // ["Registros Inexistentes", s.total_inexistentes || 0, "red"],
        // ["Erros de execução", d.totalerros || 0, "red"],
        ["Tempo de execução", (d.tempo_execucao + "s") || 0, "red"]
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
    if (d.totalerros) {

        alertaAviso(
            "Comparação concluída com ressalvas!",
            d.totalerros + " módulo(s) apresentaram erro. Confira os detalhes."
        );

    } else {

        alertaSucesso(
            "Comparação concluída!",
            d.tempo_execucao.toFixed(0) + " segundos de comparação sem erros de execução."
        );

    }


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
                Eba!, nenhum problema encontrado!!
            </div>
        `;

    tippy('[data-tippy-content]', {
        placement: 'top',
        animation: 'fade',
        theme: 'custom',
        appendTo: document.body
    });


    // Inicializa os tooltips do Bootstrap.
    $("resultList").querySelectorAll('[data-bs-toggle="tooltip"]').forEach(function (el) {

        bootstrap.Tooltip.getOrCreateInstance(el, {
            container: 'body'
        });

    });


    // Exibe a seção de resultados.
    $("results").classList.remove("hidden");

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
    var registros = r.totalregistros || 0;

    var body = "";
    var tempo = r.tempo_execucao_individual;
    
    if (registros >= 2) {
        var milissegundo_registro = Math.round((r.tempo_execucao_individual / registros) * 1000);
    } else{
        var milissegundo_registro = r.tempo_execucao_individual * 1000;
    }

    // Identifica as colunas que apresentaram divergências.
    var colunasErro = Array.from(new Set(
        dif.map(function (row) {
            return row["COLUNA / CAMPO DO WEBCAMARA"];
        }).filter(Boolean)
    ));


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

        // Aqui embaixo eu crio uma variavel para validar se vai ter muitas diferenças pra 
        // listar, pq se for mais que X erros, ele vem fechado como padrão pra não consumir muito espaço do html
        var open = "open";
        if (dif.length > 40){
            open = "";
        }
        // Para definir se a tabela vem como default aberta ou não, basta adicionar "open"
        // na frente da tag details (no caso fica: "<details open>")
        body += `
            <details ${open}>
                <summary style="color: var(--textgrey)">
                    ${dif.length} diferença(s) encontrada(s)
                    <span
                        class="info-tooltip"
                        data-tippy-content="Colunas com divergência: [${esc(colunasErro.join("; "))}]">
                        <i class="fa-regular fa-circle-question"></i>
                    </span>
                </summary>

                <div class="table-wrap">
                    <table>
                        <thead>
                            <tr>
                                ${keys.map(function (k, index) {

                                    return `
                                        <th class="coluna-${index}">
                                            ${esc(k)}
                                        </th>
                                    `;

                                }).join("")}
                            </tr>
                        </thead>

                        <tbody>
                            ${dif.slice().reverse().map(function (row) {

                                return `
                                    <tr>
                                        ${keys.map(function (k, index) {

                                            var valor = String(row[k] == null ? "" : row[k]);
                                            var limite = 100;

                                            return `
                                                <td
                                                    title="${esc(valor)}"
                                                    class="td-obscure coluna-${index}"
                                                >
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
                <summary style="color: var(--textgrey)">
                    ${ine.length} registro(s) inexistente(s)
                </summary>

                <div class="table-wrap">
                    <table>
                        <thead>
                            <tr>
                                <th>Descrição dos registros não encontrados</th>
                            </tr>
                        </thead>

                        <tbody>
                            ${ine.slice().reverse().map(function (x) {

                                let texto = esc(x)

                                if(texto.includes("BANCO ANTIGO")){
                                    texto = texto.replace("BANCO ANTIGO", "");
                                     return `
                                        <tr>
                                            <td>${texto} <span style="color: #fb7185"; font-style: italic;>BANCO ANTIGO</span> </td>
                                        </tr>
                                    `;
                                }

                                // Caso não for no banco antigo faz o replace normal pro banco novo
                                texto = texto.replace("BANCO NOVO", "");
                                return `
                                    <tr>
                                        <td>${texto} <span style="color: #fb7185"; font-style: italic;>BANCO NOVO</span> </td>
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

                <h3>
                    <span
                        class="info-tooltip"
                        data-tippy-content="Este módulo esta comparando ${cols} colunas"
                    >
                         ${esc(r.modulo)}
                    </span>
                </h3>

                <div class="pills">

                    ${dif.length
                        ? `
                            <span class="pill orange">
                                <i class="fa-solid fa-triangle-exclamation" style="font-size: 10px; margin-right: 2px;" ></i>
                                ${dif.length} diferenças
                            </span>
                        `
                        : ""
                    }

                    ${ine.length
                        ? `
                            <span class="pill red">
                                <i class="fa-solid fa-triangle-exclamation" style="font-size: 10px; margin-right: 2px;" ></i>
                                ${ine.length} inexistentes
                            </span>
                        `
                        : ""
                    }

                    ${r.erro
                        ? `
                            <span class="pill red info-tooltip"
                            data-tippy-content="Ocorreu algum tipo de erro durante a execução, cheque abaixo o erro e valide os campos necessários!">
                                <i class="fa-solid fa-bug" style="font-size: 10px; margin-right: 2px;"></i>
                                Erro durante comparação
                            </span>
                        `
                        : ""
                    }

                    <span class="pill timer info-tooltip"
                    data-tippy-content="Este módulo demorou ${tempo} segundos para ser comparado. uma média de ${milissegundo_registro} milisegundos por registro!">
                        <i class="fa-solid fa-stopwatch" style="font-size: 10px; margin-right: 2px;"></i>
                        ${tempo}s
                    </span>

                    <span class="pill registers info-tooltip"
                    data-tippy-content="Total de registros que foram encontrados no WEBCAMARA (pode variar em relação ao NovoWCM)">
                        <i class="fa-solid fa-database" style="font-size: 10px; margin-right: 2px;"></i>
                        ${registros} registro(s)
                    </span>

                </div>

            </div>

            <div class="body">
                ${body || `
                    <div class="empty">
                        Nenhuma inconsistência neste módulo.
                    </div>
                `}
            </div>

        </article>
    `;

}


/* ========================================
   Inicialização
======================================== */

iniciar();
