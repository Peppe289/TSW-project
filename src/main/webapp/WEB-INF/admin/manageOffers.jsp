<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link type="image/x-icon" rel="icon" href="${pageContext.request.contextPath}/img/solo_logo.png">
    <title>Offerte</title>

    <style>
        .box-offerte {
            width: 50%;
            display: flex;
            flex-direction: column;
            margin: 15px auto;
            text-align: center;

            & table {
                width: 100%;
                border-collapse: unset;
            }

            & button {
                margin: 10px auto;
                width: 40%;
            }
        }

        .line {
            display: block;
            height: 2px;
            width: 90%;
            border-bottom: 1px solid black;
            margin: 10px auto 30px auto;
        }

        .box-offerte {
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
            padding: 20px;
            text-align: center;

            & form {
                margin: 10px;
                display: flex;
                flex-direction: column;
            }

            & .form-box {
                display: inline-flex;
                justify-content: center;
            }

            & .row {
                position: relative;
                width: 50%;
                display: flex;
                flex-direction: column;
                margin-inline: 10px;
                margin-block: 5px;
                align-self: center;
            }

            & input {
                outline: none;
                border: none;
                box-shadow: 0 0 3px rgba(0, 0, 0, 0.34);
                height: 25px;
                width: 100%;
            }

            div.percentage > div {
                display: flex;
                flex-direction: row;
                justify-content: center;
                & input,
                & span {
                    width: 45%;
                    margin-inline: 5px;
                }

                & span {
                    border: 1px solid rgba(189, 189, 189, 0.37);
                }
            }

            input.wrong {
                color: red;
            }
        }
    </style>
</head>
<body>

<div id="main_container">
    <%@ include file="sidebar.jsp" %>
    <div id="content">
        <div id="prodotti" class="section">
            <h3>Offerte</h3>
            <hr>
            <div class="box-offerte">
                <form id="add_offerte" method="POST" action="offer">
                    <div class="form-box">
                        <div class="row">
                            <label for="id_prod">ID Prodotto</label>
                            <input list="suggestion" name="id_prod" id="id_prod" type="text">
                            <datalist id="suggestion">
                                <!-- put here suggestions from json of all names. -->
                            </datalist>
                        </div>
                        <div class="row percentage">
                            <label for="percentage">Percentuale Sconto</label>
                            <div>
                                <input name="percentage" id="percentage" type="number" min="0" max="99">
                                <span id="output_percentage">price</span>
                            </div>
                        </div>
                    </div>
                    <div class="form-box">
                        <div class="row">
                            <label for="startDate">Data Inizio</label>
                            <input name="startDate" id="startDate" type="date">
                        </div>
                        <div class="row">
                            <label for="endDate">Data Fine</label>
                            <input name="endDate" id="endDate" type="date">
                        </div>
                    </div>
                    <label style="margin-top: 10px;">Descrizione Prodotto
                        <textarea id="description" style="width: 100%; resize: none;" rows="3">
                        </textarea>
                    </label>
                </form>
                <button form="add_offerte">
                    Aggiungi Offerta
                </button>
            </div>
            <span class="line"></span>
            <table id="table">
                <tr class="headers_table">
                    <th>ID Offerta</th>
                    <th>ID Prodotto</th>
                    <th>Descrizione</th>
                    <th>Data Inizio</th>
                    <th>Data Fine</th>
                    <th>Percentuale</th>
                    <th aria-label="vuoto"></th>
                </tr>
            </table>
        </div>
    </div>
</div>
</body>
<script>
    let json_prod = [];

    function loadProdAjax() {
        let xhr = new XMLHttpRequest();

        xhr.open("GET", "products-json", true);
        xhr.onload = function() {
            json_prod = Array.from(JSON.parse(this.responseText));
            generateSuggestionsArray();
        }
        xhr.send();
    }

    function loadOffersAjax() {
        let json_offers;
        let xhr = new XMLHttpRequest();

        xhr.open("GET", "offer", true);
        xhr.onreadystatechange = function () {
            if (this.readyState === 4 && this.status === 200) {
                json_offers = JSON.parse(this.responseText);
                generateTable(json_offers);
            }
        }
        xhr.send();
    }

    /* retrieve from server the list of all produtcs. */
    loadProdAjax();
    /* retrieve from server the list of all offerts. */
    loadOffersAjax();

    document.getElementById('add_offerte').addEventListener('submit', function(event) {
        // Prevent the default form submission
        event.preventDefault();

        let obj = {
            id: document.getElementById("id_prod").value,
            percent: document.getElementById("percentage").value,
            startDate: document.getElementById("startDate").value,
            endDate: document.getElementById("endDate").value,
            description: document.getElementById("description").value,
            reason: "add"
        }

        /* on submitted form send ajax request for insert new offer. */
        let xhr = new XMLHttpRequest();
        xhr.open("POST", "offer", true);
        xhr.onload = function () {
            let json_res = JSON.parse(this.responseText);
            if (json_res["status"] === "success") {
                /* retrieve from server the list of all offerts. */
                loadOffersAjax();
            }
        }
        xhr.send(JSON.stringify(obj));
    });

    /******************** Table Stuff **************************/

    let table = document.getElementById("table");

    function createTableRow(id, productId, description, startDate, endDate, percentage) {
        const tr = document.createElement('tr');

        const idTd = document.createElement('td');
        idTd.textContent = id;
        tr.appendChild(idTd);

        const productIdTd = document.createElement('td');
        productIdTd.textContent = productId;
        tr.appendChild(productIdTd);

        const descriptionTd = document.createElement('td');
        descriptionTd.textContent = description;
        tr.appendChild(descriptionTd)

        const startDateTd = document.createElement('td');
        startDateTd.textContent = startDate;
        tr.appendChild(startDateTd);

        const endDateTd = document.createElement('td');
        endDateTd.textContent = endDate;
        tr.appendChild(endDateTd);

        const percentageTd = document.createElement('td');
        percentageTd.textContent = percentage;
        tr.appendChild(percentageTd);

        const button = document.createElement('button');
        button.textContent = 'Rimuovi';
        button.classList.add('edit');

        const buttonTd = document.createElement('td');
        buttonTd.appendChild(button);
        tr.appendChild(buttonTd);

        buttonTd.addEventListener("click", () => {
           let xhr = new XMLHttpRequest();
           xhr.open("POST", "offer", true);
           let obj = {
               id: id,
               reason: "remove"
           }
           xhr.onreadystatechange = function() {
                if (this.readyState === 4 && this.status === 200) {
                    let result = JSON.parse(this.responseText);
                    if (result["status"] === "success") {
                        loadOffersAjax();
                    }
                }
           }
           xhr.send(JSON.stringify(obj));
        });

        return tr;
    }

    /* fix time zone. */
    function adjustDateForTimezone(dateStr) {
        const date = new Date(dateStr);
        const userTimezoneOffset = date.getTimezoneOffset() * 60000;
        return new Date(date.getTime() - userTimezoneOffset).toISOString().split("T")[0];
    }

    /* generate table after ajax request. */
    function generateTable(json_offers) {
        /* before add the new element, remove all content inside. */
        let table_row = table.getElementsByTagName("tr");
        Array.from(table_row).forEach(el => {
            if (!el.classList.contains("headers_table")) {
                el.remove();
            }
        });
        Array.from(json_offers).forEach(el => {
            let startDate = adjustDateForTimezone(el["startDate"])
            let endDate = adjustDateForTimezone (el["endDate"]);
            table.append(createTableRow(el["id_offerta"], el["id_prodotto"], el["description"], startDate, endDate, el["percentage"] + "%"));
        });
    }

    const startDate_input = document.getElementById("startDate");
    const endDate_input = document.getElementById("endDate");

    /* check input date even change state in startDate or endDate. */
    startDate_input.addEventListener("change", () => {
        compareDates();
    });

    endDate_input.addEventListener("change", () => {
        compareDates();
    });
    /*************************************************************/

    function compareDates() {
        const startDate = new Date(startDate_input.value);
        const endDate = new Date(endDate_input.value);

        if (startDate >= endDate) {
            endDate_input.classList.add("wrong");
        } else {
            /* the class can be added more than one time, then remove until is prensent. */
            while (endDate_input.classList.contains("wrong")) {
                endDate_input.classList.remove("wrong");
            }
        }
    }

    /************************* Add offer: Percentage box **************************/

    let input_field = document.getElementsByTagName("input");

    /* disable browser suggestion in the input field. (we use our stuff.)*/
    Array.from(input_field).forEach(el => {
        el.autocomplete = "off";
    });

    let output_percentage = document.getElementById("output_percentage");
    let percentage_input = document.getElementById("percentage");

    /* show price with setted percentage. */
    function show_set_price(id) {
        let price;
        let percentage_val = percentage_input.value;
        let id_find = id.toLocaleUpperCase();
        Array.from(json_prod).every(el => {
            /* find in json the right id and retrieve price. */
            if (el.id.toLocaleUpperCase() === id_find) {
                price = parseFloat(el.price);
                return false;
            }

            return true;
        });

        if (percentage_val === 0 || percentage_val === null) {
            /* if percentage isn't set show default price. */
            output_percentage.innerHTML = price;
        } else if (percentage_val >= 0 && percentage_val <= 99) {
            /* if percentage is set, show price with offer. */
            output_percentage.innerHTML = (price - ((price / 100) * percentage_val)).toFixed(2).toString();
        }
    }

    /* at press calculate price in the side span. */
    percentage_input.addEventListener("input", (event) => {
        let value = event.target.value;

        /* validate range in js after html. */
        if (value < 0 || value > 99) {
            console.log("Valore non cencesso");
        } else {
            show_set_price(input_name.value);
        }
    })

    /************************ Add offer: Suggestion box ID ************************/

    let suggestion_box = document.getElementById("suggestion");
    let input_name = document.getElementById("id_prod");

    /* take all products from json, make upperCase and sort. */
    function generateSuggestionsArray() {
        let arr = [];
        for (let i = 0; i < json_prod.length; ++i)
            arr.push(json_prod[i].id + " - " + json_prod[i].name.toUpperCase());

        arr.sort();

        arr.forEach(item => {
            const option = document.createElement("option");
            option.textContent = item;
            option.value = item.split(" - ")[0];
            suggestion_box.appendChild(option);
        });
    }
</script>
</html>