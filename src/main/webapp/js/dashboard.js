const container = document.getElementById("list");
var updateStats;
let first = 1;
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

document.getElementById("webStat").addEventListener("click", (event) => {
    cleanupSelect(event.currentTarget);
    webStatPage();
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
            container.innerHTML += '<div>Max time: ' + json.maxTime + '</div>';
            container.innerHTML += '<div>Bytes Ricevuti: ' + json.bytesReceived + '</div>';
            container.innerHTML += '<div>Bytes Inviati: ' + json.bytesSent + '</div>';
            container.innerHTML += '<div>Richieste: ' + json.requestCount + '</div>';
            container.innerHTML += '<div>Numero di errori: ' + json.errorCount + '</div>';
            container.innerHTML += '<div>Tempo di servizio: ' + json.processingTime + '</div>';
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
    return "<tr> <td>" + json.id + "</td> <td> " + json.name + " </td><td> " + json.price + " </td></tr>";
}

function webStatPage() {
    container.innerHTML = '';

    const xhttp = new XMLHttpRequest();
    xhttp.onload = function () {
        let json = JSON.parse(this.responseText);
        const table = createTableHead();

        json.forEach(function(value) {
            //console.log(value.id);
            table.innerHTML += createRowTableElement(value);
        });

        container.appendChild(table);
    }
    xhttp.open("GET", "stats?reason=webstat", true);
    xhttp.send();
}

function generalPage() {
    const btn = new Map([['Gestione prodotti', 'Aggiungi, rimuovi, modifica prezzo, aggiungi sconti.'], ['Gestione Utenti', 'Rimuovi gli utenti, resetta password, gestisci gli admin.']]);

    container.innerHTML = '';
    btn.forEach((val, key) => {
        container.innerHTML += '<div><p>' + key + '</p><br><p>' + val + '</p>' + '</div>';
    });
}