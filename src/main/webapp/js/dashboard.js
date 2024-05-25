const container = document.getElementById("list");
var serverStat = false;
var updateStats;
var updateStats_btn = document.getElementById("checkbox_area").checked;
document.getElementById("checkbox_area").addEventListener("change", (event) => {
    if (event.target.checked && serverStat) {
        updateStats = setInterval(sererStatsPage, 1000);
    } else if (!event.target.checked && serverStat) {
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
    serverStat = !serverStat;
    document.getElementById("checkbox_area").classList.remove("hide");
    sererStatsPage();
});

function cleanupSelect(val) {
    var arr = document.getElementsByClassName("item");
    for (var i = 0; i < arr.length; ++i) {
        arr[i].classList.remove("active");
    }

    val.classList.add("active");
    updateStats_btn = false;
    clearInterval(updateStats);
    document.getElementById("checkbox_area").classList.add("hide");
}

function sererStatsPage() {
    container.innerHTML = '';

    const xhttp = new XMLHttpRequest();
    xhttp.onload = function () {
        var json = JSON.parse(this.responseText);
        container.innerHTML += '<div>Max time: ' + json.maxTime + '</div>';
        container.innerHTML += '<div>Bytes Ricevuti: ' + json.bytesReceived + '</div>';
        container.innerHTML += '<div>Bytes Inviati: ' + json.bytesSent + '</div>';
        container.innerHTML += '<div>Richieste: ' + json.requestCount + '</div>';
        container.innerHTML += '<div>Numero di errori: ' + json.errorCount + '</div>';
        container.innerHTML += '<div>Tempo di servizio: ' + json.processingTime + '</div>';
    }
    xhttp.open("GET", "stats?reason=serverstats", true);
    xhttp.send();
}

function webStatPage() {
    container.innerHTML = '';
}

function generalPage() {
    const btn = new Map([
        ['Gestione prodotti',
            'Aggiungi, rimuovi, modifica prezzo, aggiungi sconti.'],
        ['Gestione Utenti',
            'Rimuovi gli utenti, resetta password, gestisci gli admin.']
    ]);

    container.innerHTML = '';
    btn.forEach((val, key) => {
        container.innerHTML += '<div><p>' +
            key + '</p><br><p>' +
            val + '</p>' +
            '</div>';
    });
}