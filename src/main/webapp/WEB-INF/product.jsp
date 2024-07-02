<%@ page import="org.dinosauri.dinosauri.model.Product" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/product.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/NotifyUser.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link href='https://fonts.googleapis.com/css?family=Open Sans' rel='stylesheet'>
    <link type="text/css" rel="stylesheet" href="css/home.css">
    <link type="image/x-icon" rel="icon" href="img/solo_logo.png">

    <title>DinoStore - Prodotto</title>

    <style>
        /* serve per far stare il footer in basso */
        body {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            margin: 0;
        }

        footer {
            margin-top: auto;
        }

        #show-propriety {
            list-style: none;
            padding: 0;
        }

        li.propriety * {
            display: inline;
            padding: 0;
        }

        li.propriety p:first-child {
            font-weight: bold;
        }

        .hide {
            display: none;
        }
    </style>
</head>

<body>
<%@ include file="include/navbar.jsp" %>
<%@ include file="include/carrello_portable.html" %>
<div id="container">
    <div id="view-container">
        <div id="img-container">
            <!-- l'immagina viene caricata dopo da js -->
            <img id="img-main">
        </div>
        <div class="some-photo">
            <c:if test="${not empty product}">
                <c:forEach items="${product.photo_path}" var="photo">
                    <img class="preview-img" onclick="changeit(this.src, this)"
                         src="${pageContext.request.contextPath}${photo}">
                </c:forEach>
            </c:if>
        </div>
    </div>
    <div id="description">
        <c:if test="${not empty product}">
            <span id="id_prod" style="display: none">${product.id}</span>
            <h1>${product.name}</h1>
            <p class="paragraph-desc">
                    ${product.description}
            </p>
            <div class="price">
                <c:choose>
                    <c:when test="${product.sconto != 0}">
                        <p class="prezzo">
                            <fmt:formatNumber value="${product.price * (1 - (product.sconto / 100))}"
                                              type="number" minFractionDigits="2" maxFractionDigits="2"/>&#8364;
                        </p>
                        <s style="height: 100%; margin-top: 15px; padding: 0">
                            <fmt:formatNumber value="${product.price}"
                                              type="number" minFractionDigits="2"
                                              maxFractionDigits="2"/>&#8364;</s>
                    </c:when>
                    <c:otherwise>
                        <p class="prezzo"><fmt:formatNumber value="${product.price}"
                                                            type="number" minFractionDigits="2"
                                                            maxFractionDigits="2"/>&#8364;</p>
                    </c:otherwise>
                </c:choose>
            </div>
            <ul id="show-propriety">
                <c:if test="${product.sconto != 0}">
                    <li class="propriety"><p>Sconto: </p>
                        <p>-${product.sconto}%</p></li>
                </c:if>
                <c:if test="${not empty product.categoria}">
                    <li class="propriety"><p>Categoria: </p>
                        <p>${product.categoria}</p></li>
                </c:if>
                <c:if test="${not empty product.alimentazione}">
                    <li class="propriety"><p>Alimentazione: </p>
                        <p>${product.alimentazione}</p></li>
                </c:if>
            </ul>
            <p>Disponibili: <span id="disp">${product.quantity}</span></p>
        </c:if>
        <button id="add_carrello">Aggiungi al carrello</button>
    </div>
</div>

<%@ include file="include/footer.jsp" %>
</body>
<script>
    try {
        /* carica di default la prima immagine dalla lista della preview */
        document.getElementById("img-main").src = document.getElementsByClassName("preview-img")[0].src;
    } catch (e) {
        document.getElementById("img-main").src = "img/missing.jpg";
    }

    /* funzinoe per cambiare immagine dalla preview */
    function changeit(path, el) {
        var img = document.getElementById("img-main");
        img.src = path;
    }

    function disableButton() {
        var disp = document.getElementById("disp").innerHTML;
        if (disp < 1) {
            document.getElementById("shop-btn").classList.add("hide");
        }
    }

    /* esegui il codice dopo che il DOM è stato caricato */
    document.addEventListener('DOMContentLoaded', function () {
        disableButton();
    });
</script>
<script type="module" src="./js/ToastAPI.js"></script>
<script type="module">
    import {notifyUserModule} from "./js/ToastAPI.js"

    /**
     * Controlla l'icona carrello.
     */
    let disponibility = document.getElementById("disp");
    let id_product = document.getElementById("id_prod").innerHTML;
    let carrello = document.getElementById("carrello");
    let carrello_span = carrello.getElementsByTagName("span")[0];

    document.getElementById("add_carrello").addEventListener("click", () => {
        /* Need ajax request. */
        let xhr = new XMLHttpRequest();
        /**
         * Ajax request for add product to cart.
         */
        xhr.onreadystatechange = function () {
            if (this.readyState === 4 && this.status === 200) {
                let json = JSON.parse(this.response);
                /**
                 * Check in response json if all is ok. Notify status to user.
                 */
                if (json["status"] !== "success") {
                    notifyUserModule("Impossibile aggiungere al carrello", "Elementi non disponibili");
                } else {
                    notifyUserModule("Elemento aggiunto al carrello", "Quantità totali: " + json["item"]);
                }
                /**
                 * Set current number of available elements.
                 */
                carrello_set_number(json["elements"]);
            }
        }

        xhr.open("GET", "carrello-add-ajax?id=" + id_product + "&add=1", true);
        xhr.send();
    });

    function carrello_set_number(number) {
        if (number === 0) {
            carrello_span.style.display = "none";
        } else {
            carrello_span.style.display = "flex";
        }
        carrello_span.innerHTML = number;
    }

    function carrello_increase_number(n) {
        let number = Number(carrello_span.innerHTML);
        if ((number + n) <= 0) {
            carrello_span.style.display = "none";
            number = 0;
        } else {
            carrello_span.style.display = "flex";
            number += n;
        }
        carrello_span.innerHTML = number;
    }
</script>

</html>