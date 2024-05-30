const container = document.getElementById("list");
var updateStats;
let first = 1;
let json;
document.getElementById("checkbox_area").getElementsByTagName("input")[0].addEventListener("change", (event) => {
    if (event.target.checked) {
        updateStats = setInterval(sererStatsPage, 1000);
    } else if (!event.target.checked) {
        clearInterval(updateStats);
    }
});

document.getElementById("general").addEventListener("click", (event) => {
    cleanupSelect(event.currentTarget);
    generalPage();
});

document.getElementById("products").addEventListener("click", (event) => {
    cleanupSelect(event.currentTarget);
    productsPage();
});

document.getElementById("serverStat").addEventListener("click", (event) => {
    cleanupSelect(event.currentTarget);
    document.getElementById("checkbox_area").classList.remove("hide");
    sererStatsPage();
});

function cleanupSelect(val) {
    var arr = document.getElementsByClassName("item");
    for (var i = 0; i < arr.length; ++i) {
        arr[i].classList.remove("active");
    }
    first = 1;
    val.classList.add("active");
    document.getElementById("checkbox_area").getElementsByTagName("input")[0].checked = false;
    clearInterval(updateStats);
    document.getElementById("checkbox_area").classList.add("hide");
}

function sererStatsPage() {
    if (first) container.innerHTML = '';

    const xhttp = new XMLHttpRequest();
    xhttp.onload = function () {
        var json = JSON.parse(this.responseText);

        if (first) {
            container.innerHTML += '<div class="listbox">Max time: ' + json.maxTime + '</div>';
            container.innerHTML += '<div class="listbox">Bytes Ricevuti: ' + json.bytesReceived + '</div>';
            container.innerHTML += '<div class="listbox">Bytes Inviati: ' + json.bytesSent + '</div>';
            container.innerHTML += '<div class="listbox">Richieste: ' + json.requestCount + '</div>';
            container.innerHTML += '<div class="listbox">Numero di errori: ' + json.errorCount + '</div>';
            container.innerHTML += '<div class="listbox">Tempo di servizio: ' + json.processingTime + '</div>';
            first = 0;
        } else {
            const children = container.getElementsByTagName("div");
            children[0].innerHTML = "Max Time: " + json.maxTime;
            children[1].innerHTML = "Bytes Ricevuti: " + json.bytesReceived;
            children[2].innerHTML = "Bytes Inviati: " + json.bytesSent;
            children[3].innerHTML = "Richieste: " + json.requestCount;
            children[4].innerHTML = "Numero di errori: " + json.errorCount;
            children[5].innerHTML = "Tempo di servizio: " + json.processingTime;
        }
    }
    xhttp.open("GET", "stats?reason=serverstats", true);
    xhttp.send();
}

function createTableHead() {
    const table = document.createElement("table");
    const table_head_row = document.createElement("tr");
    const head = ["ID", "Nome", "Prezzo"];

    head.forEach(function (value) {
        let table_head = document.createElement("th");
        table_head.innerHTML = value;

        table_head_row.innerHTML += table_head.outerHTML;
    });

    table.innerHTML = table_head_row.outerHTML;

    return table;
}

function createRowTableElement(json) {
    return "<tr> <td onclick='openEdit(this)'>" + json.id + "</td> <td> " + json.name + " </td><td> " + json.price + " </td></tr>";
}

function openEdit(item) {
    // make request for this ID
    const id = item.innerHTML;

    json.forEach((item) => {
        if (item.id === id) {
            let code = createEditPopup(item.name, item.price, item.categoria, item.alimentazione, item.description);
            container.innerHTML += code;
            const fields = document.querySelectorAll('#name, #price, #category, #nutrition, #description');

            fields.forEach(field => {
                field.addEventListener('keydown', (e) => {
                    if (e.key === 'Enter') {
                        e.preventDefault(); // Evita che il tasto Invio invii il form
                        disableAllFields();
                    }
                });
            });
        }
    });
    //console.log(json[id].id);
}

function productsPage() {
    container.innerHTML = '';

    const xhttp = new XMLHttpRequest();
    xhttp.onload = function () {
        json = JSON.parse(this.responseText);
        const table = createTableHead();

        json.forEach(function(value) {
            //console.log(value.id);
            table.innerHTML += createRowTableElement(value);
        });

        container.appendChild(table);
    }
    xhttp.open("GET", "stats?reason=products", true);
    xhttp.send();
}

function createEditPopup(nome, prezzo, categoria, alimentazione, descrizione) {
    let popup =
        "   <div class=\"containerpopup\">\n" +
        "        <h1>Modifica Prodotto</h1>\n" +
        "        <div class=\"product-form\">\n" +
        "            <div class=\"form-group\">\n" +
        "                <label for=\"name\">Nome:</label>\n" +
        "                <input type=\"text\" id=\"name\" value=\"?????NOME?????\" disabled>\n" +
        "                <button onclick=\"enableEdit('name')\">Modifica</button>\n" +
        "            </div>\n" +
        "            <div class=\"form-group\">\n" +
        "                <label for=\"price\">Prezzo:</label>\n" +
        "                <input type=\"text\" id=\"price\" value=\"?????PREZZO?????\" disabled>\n" +
        "                <button onclick=\"enableEdit('price')\">Modifica</button>\n" +
        "            </div>\n" +
        "            <div class=\"form-group\">\n" +
        "                <label for=\"category\">Categoria:</label>\n" +
        "                <input type=\"text\" id=\"category\" value=\"?????CATEGORIA?????\" disabled>\n" +
        "                <button onclick=\"enableEdit('category')\">Modifica</button>\n" +
        "            </div>\n" +
        "            <div class=\"form-group\">\n" +
        "                <label for=\"nutrition\">Alimentazione:</label>\n" +
        "                <input type=\"text\" id=\"nutrition\" value=\"?????ALIMENTAZIONE?????\" disabled>\n" +
        "                <button onclick=\"enableEdit('nutrition')\">Modifica</button>\n" +
        "            </div>\n" +
        "            <div class=\"form-group\">\n" +
        "                <label for=\"description\">Descrizione:</label>\n" +
        "                <textarea id=\"description\" disabled>?????DESC?????</textarea>\n" +
        "                <button onclick=\"enableEdit('description')\">Modifica</button>\n" +
        "            </div>\n" +
        "            <div class=\"form-actions\">\n" +
        "                <button onclick=\"applyChanges()\">Applica</button>\n" +
        "                <button onclick=\"deleteProduct()\">Elimina Prodotto</button>\n" +
        "                <button onclick=\"closeForm()\">Chiudi</button>\n" +
        "            </div>\n" +
        "        </div>\n" +
        "    </div>";


    popup = popup.replace("?????NOME?????", nome);
    popup = popup.replace("?????PREZZO?????", prezzo);
    popup = popup.replace("?????CATEGORIA?????", categoria);
    popup = popup.replace("?????ALIMENTAZIONE?????", alimentazione);
    popup = popup.replace("?????DESC?????", descrizione);

    return popup;
}

function generalPage() {
    const btn = new Map([['Gestione prodotti', 'Aggiungi, rimuovi, modifica prezzo, aggiungi sconti.'], ['Gestione Utenti', 'Rimuovi gli utenti, resetta password, gestisci gli admin.']]);

    container.innerHTML = '';
    btn.forEach((val, key) => {
        container.innerHTML += '<div class="listbox"><p>' + key + '</p><br><p>' + val + '</p>' + '</div>';
    });
}

function enableEdit(fieldId) {
    const field = document.getElementById(fieldId);
    field.disabled = false;
    field.focus();
}

function applyChanges() {
    // Logica per applicare le modifiche
    alert('Modifiche applicate');
    disableAllFields();
}

function deleteProduct() {
    // Logica per eliminare il prodotto
    alert('Prodotto eliminato');
}

function closeForm() {
    document.getElementsByClassName("containerpopup")[0].remove();
}

function disableAllFields() {
    const fields = document.querySelectorAll('#name, #price, #category, #nutrition, #description');
    fields.forEach(field => field.disabled = true);
}

