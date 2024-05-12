<%@ page import="org.dinosauri.dinosauri.model.Product" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<!DOCTYPE html>
<html>

<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/product.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link href='https://fonts.googleapis.com/css?family=Open Sans' rel='stylesheet'>

    <title>DinoStore - Prodotto</title>

</head>
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

    li.propriety *{
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

<body>
<jsp:include page="../navbar/navbar.jsp"/>
<div id="container">
    <div id="view-container">
        <div id="img-container">
            <!-- l'immagina viene caricata dopo da js -->
            <img id="img-main">
        </div>
        <div class="some-photo">
            <img class="preview-img" onclick="changeit(this.src, this)" src="${pageContext.request.contextPath}/img/solo_logo.png">
            <img class="preview-img" onclick="changeit(this.src, this)" src="${pageContext.request.contextPath}/img/search_ico.png">
        </div>
    </div>
    <div id="description">
        <c:if test="${not empty product}">
            <h1>${product.name}</h1>
            <p class="paragraph-desc">
                    ${product.description}
            </p>
            <div class="price">
                <p><%= String.format("%.2f", ((Product) request.getAttribute("product")).getPrice()) %>&#8364;</p>
                <s>5000&#8364;</s>
            </div>
            <ul id="show-propriety">
                <c:if test="${not empty product.categoria}">
                    <li class="propriety"><p>Categoria: </p><p>${product.categoria}</p></li>
                </c:if>
                <c:if test="${not empty product.alimentazione}">
                    <li class="propriety"><p>Alimentazione: </p><p>${product.alimentazione}</p></li>
                </c:if>
            </ul>
            <p>Disponibili: <span id="disp">${product.quantity}</span></p>
        </c:if>
        <form action="" id="shop-btn">
            <input type="submit" value="Aggiungi al carrello">
        </form>
    </div>
</div>

<jsp:include page="../footer/footer.jsp"/>
</body>
<script>
    /* carica di default la prima immagine dalla lista della preview */
    document.getElementById("img-main").src = document.getElementsByClassName("preview-img")[0].src;

    /* funzinoe per cambiare immagine dalla preview */
    function changeit(path, el) {
        var img = document.getElementById("img-main");
        img.src = path;
    }

    function disableButton() {
        var disp = document.getElementById("disp").innerHTML;
        console.log(disp);
        if (disp < 1) {
            document.getElementById("shop-btn").classList.add("hide");
        }
    }

    /* esegui il codice dopo che il DOM è stato caricato */
    document.addEventListener('DOMContentLoaded', function() {
        disableButton();
    });
</script>

</html>