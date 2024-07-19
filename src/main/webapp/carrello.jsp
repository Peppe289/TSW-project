<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>

<html lang="it">
<head>
    <title>Carrello</title>

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link type="text/css" rel="stylesheet" href="css/navbar.css">
    <link type="text/css" rel="stylesheet" href="css/footer.css">
    <link type="text/css" rel="stylesheet" href="css/carrello.css">

    <link href='https://fonts.googleapis.com/css?family=Open Sans' rel='stylesheet'>
</head>

<body>
<%@ include file="WEB-INF/include/navbar.jsp" %>

<div id="container">
    <div id="left-div">
        <div id="list">

        </div>
    </div>
    <div id="right-div">
        <div id="totalPrice">
            <b>Prezzo Totale: 0€</b>
        </div>
        <div class="buttons green-button">
            <button onclick='location.href="${pageContext.request.contextPath}/compra"'>Procedi con l'ordine</button>
        </div>
    </div>
</div>

<%@ include file="WEB-INF/include/footer.jsp" %>
<script src="js/carrello.js" defer></script>
</body>
</html>