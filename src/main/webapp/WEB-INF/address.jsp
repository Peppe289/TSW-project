<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Modifica Indirizzo</title>

    <style>
        #main_box {
            margin: auto;
            box-shadow: 0 0 5px black;
            padding: 30px;
            max-width: 500px;
            height: max-content;
            display: flex;
            flex-direction: column;
            text-align: center;
        }

        form {
            display: flex;
            flex-direction: row;
            width: 100%;
            justify-content: space-around;
        }

        form > div {
            display: flex;
            flex-direction: column;
        }

        .input {
            position: relative;
            margin: 10px;
        }

        input[type="text"]:focus + label,
        input[type="text"]:valid + label {
            top: -10px;
            font-size: 12px;
            color: #3CB371;
        }

        .invalid {
            border-color: red !important;
        }

        input[type="text"],
        input[type="password"] {
            padding: 10px;
            font-size: 16px;
            border: none;
            border-bottom: 2px solid #ccc;
            outline: none;
        }

        input[type="text"]:focus {
            border-color: #3CB371;
        }

        label {
            /* positione assoluta relativa al div dentro il form */
            position: absolute;
            top: 10px;
            left: 5px;

            color: #999;
            transition: all 0.2s ease-in-out;
            /**
             * In modo che il mouse non riesca mai
             * a vedere la solidità del blocco.
             */
            pointer-events: none;
        }

        button {
            padding: 10px 20px;
            border: none;
            background-color: #28a745;
            color: #fff;
            cursor: pointer;
            border-radius: 4px;
            margin: 5px 10px;
        }

        button:hover {
            background-color: #218838;
        }
    </style>

</head>
<body>

<div id="main_box">
    <h3>Inserisci dettagli di spedizione</h3>
    <form id="address" method="post" action="change_address">
        <c:choose>
            <c:when test="${not empty reason}">
                <input type="hidden" name="reason" value="${reason}">
            </c:when>
            <c:otherwise>
                <input type="hidden" name="reason" value="settings">
            </c:otherwise>
        </c:choose>
        <div>
            <div class="input">
                <input type="text" id="nome" name="nome" required value="${address_resp.name}">
                <label for="nome">Nome</label>
            </div>
            <div class="input">
                <input type="text" id="cognome" name="cognome" required value="${address_resp.cognome}">
                <label for="cognome">Cognome</label>
            </div>
            <div class="input">
                <input type="text" id="via" name="via" required value="${address_resp.via}">
                <label for="via">Via</label>
            </div>
        </div>
        <div>
            <div class="input">
                <input type="text" list="sugg_comune" id="comune" name="comune" required value="${address_resp.comune}">
                <label for="comune">Comune</label>
                <datalist id="sugg_comune">
                    <!-- options -->
                </datalist>
            </div>

            <div class="input">
                <input type="text" list="sugg_cap" id="cap" name="cap" required value="${address_resp.cap}">
                <label for="cap">Cap</label>
                <datalist id="sugg_cap">
                    <!-- options -->
                </datalist>
            </div>

            <div class="input">
                <input type="text" id="civico" name="civico" required value="${address_resp.numero_civico}">
                <label for="civico">Civico</label>
            </div>

            <div class="input">
                <input type="text" id="provincia" name="provincia" required value="${address_resp.provincia}">
                <label for="provincia">Provincia</label>
            </div>
        </div>
    </form>
    <c:if test="${not empty message}">
        <p>${message}</p>
    </c:if>
    <c:choose>
        <c:when test="${not empty btn_message}">
            <button form="address">${btn_message}</button>
        </c:when>
        <c:otherwise>
            <button form="address">Salva</button>
        </c:otherwise>
    </c:choose>
</div>

<script>
    let json;
    let provincia = document.getElementById("provincia");
    let cap = document.getElementById("cap");
    let comune = document.getElementById("comune");

    function retrieveItalyCap() {
        let xhr = new XMLHttpRequest();
        xhr.open("GET", "https://raw.githubusercontent.com/Peppe289/comuni-localita-cap-italia/main/files/comuni-localita-cap-italia.json", true)
        xhr.onreadystatechange = function () {
            if (this.status === 200 && this.readyState === 4) {
                json = JSON.parse(this.responseText);
            } else {
                json = null;
            }
        }

        xhr.send();
    }

    function findFromProvincia(Provincia_target) {
        return json["Sheet 1 - comuni-localita-cap-i"].filter(object => {
            let value = object.Provincia;
            return value.toString().toUpperCase() === Provincia_target.toString().toUpperCase();
        });
    }

    function findFromCAP(CAP_target) {
        return json["Sheet 1 - comuni-localita-cap-i"].filter(object => object.CAP === CAP_target.toString());
    }

    function findFromCity(City_target) {
        return json["Sheet 1 - comuni-localita-cap-i"].filter(object => {
            /*
             * For some reason js don't like if I write this key.
             * So take it directly from array of keys.
             */
            let cityKey = Object.keys(object)[0];
            let value = object[cityKey];
            return value.toString().toUpperCase() === City_target.toString().toUpperCase();
        });
    }

    function emptyString(string) {
        return /^\\s*$/.test(string) && string.toString().length < 1;
    }

    function suggestionFind() {
        let prov_value = provincia.value;
        let cap_value = cap.value;
        let comune_value = comune.value;
        let arr_prov = null;
        let arr_cap = null;
        let arr_city = null;
        const default_data = json["Sheet 1 - comuni-localita-cap-i"];

        if (!(prov_value === null || emptyString(prov_value))) {
            arr_prov = findFromProvincia(prov_value);
        }

        if (!(cap_value === null || emptyString(cap_value))) {
            arr_cap = findFromCAP(cap_value);
        }

        if (!(comune_value === null || emptyString(comune_value))) {
            arr_city = findFromCity(comune_value);
        }

        let merged = [].concat([arr_prov, arr_city, arr_cap]);
        let result = default_data;
        merged.forEach(el => {
            if (el.length > 0) {
                if (result.length > el.length)
                    result = el;
            }
        });

        if (result.length === default_data.length)
            return null;

        return result;
    }

    function setSuggestion() {
        const sugg_com = document.getElementById("sugg_comune");
        const sugg_cap = document.getElementById("sugg_cap");
        let arr = suggestionFind();

        sugg_com.innerHTML = "";
        sugg_cap.innerHTML = "";

        if (arr == null) {
            provincia.value = "";
            comune.value = "";
            cap.value = "";
            return;
        }

        Array.from(arr).forEach(obj => {
            let item = document.createElement("option");
            item.innerHTML = obj["CAP"];
            item.value = obj["CAP"];
            sugg_cap.append(item);
        });

        if (Array.from(arr).length === 1) {
            cap.value = arr[0]["CAP"];
            let key = Object.keys(arr[0])[0];
            comune.value = arr[0][key];
        } else {
            Array.from(arr).forEach(obj => {
                let item = document.createElement("option");
                let key = Object.keys(obj)[0];
                item.innerHTML = obj[key];
                item.value = obj[key];
                sugg_com.append(item);
            })
        }

        provincia.value = arr[0].Provincia;
    }

    provincia.addEventListener("focus", (e) => {
        setSuggestion();
    });


    cap.addEventListener("focus", () => {
        setSuggestion();
    });

    comune.addEventListener("focus", () => {
        setSuggestion();
    });

    /* prendi i dati di tutti i comuni italiani. */
    retrieveItalyCap();
</script>

</body>
</html>