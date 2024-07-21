<%--@elvariable id="price" type="java.lang.Double"--%>
<%--@elvariable id="total" type="java.lang.Integer"--%>
<%--@elvariable id="prodotti" type="java.util.List"--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link href='https://fonts.googleapis.com/css?family=Open Sans' rel='stylesheet'>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link type="image/x-icon" rel="icon" href="${pageContext.request.contextPath}/img/solo_logo.png">
    <title>Procedi con l'ordine</title>

    <style>

        body {
            margin: 0;
            padding: 0;
        }

        #main_container {
            margin: 30px auto;
            display: flex;
            justify-content: space-between;
            width: 60%;
            min-width: 902px;
            box-shadow: 0 0 5px #b4b4b4;
            padding: 40px;
        }

        .side_left {
            width: 60%;
        }

        .side_right {
            width: 40%;
            min-width: 320px !important;
        }

        .side_left .item {
            padding: 10px 0 10px 0;
            margin: 20px 0 20px 0;
            display: flex;
            height: 200px;
            overflow: hidden;
        }

        .side_left .item .info {
            width: calc(100% - 220px);
            margin-inline: 20px;
        }

        .side_left .item .info p {
            float: right;
        }

        .side_left .item .image {
            overflow: hidden;
            width: 200px;
            height: 200px;
            border: 1px solid #b7b7b7;
        }

        .side_left .item .image img {
            object-fit: contain;
            width: 200px;
            height: 200px;
        }

        .side_right {
            border: 1px solid #c0c0c0;
            height: max-content;
            padding: 15px 5px 15px 5px;
            margin: 20px;
        }

        button.submit {
            padding: 10px 20px;
            border: none;
            background-color: #28a745;
            color: #fff;
            cursor: pointer;
            border-radius: 4px;
            margin: 0 10px;
        }

        #indirizzi p {
            text-align: left;
            width: 80%;
            margin: 10px auto;
            color: #595959;
        }

        button.submit:hover {
            background-color: #218838;
        }

        @media screen and (max-width: 1250px) {
            #main_container {
                flex-direction: column-reverse;
                flex-wrap: wrap;
                margin: 5px auto;
                padding: 10px;
                width: calc(100% - 60px);
                box-shadow: none;
                min-width: 250px;
            }

            #main_container > div {
                width: 100%;
            }

            .side_right {
                margin: 0;
            }
        }
    </style>

</head>
<body>
<%@ include file="include/navbar.jsp" %>
<div id="main_container">
    <div class="side_left">
        <c:forEach items="${prodotti}" var="prod">
            <div class="item">
                <div class="image">
                    <img alt="image prod" src="${pageContext.request.contextPath}${prod.photoPath}" onError="this.onerror=null; this.src='img/missing.jpg';">
                </div>
                <div class="info">
                    <h1>${prod.getTile()}</h1>
                    <br>
                    <span>Quantità: ${prod.quantity}</span><p><fmt:formatNumber value="${prod.price * prod.quantity}" type="number" minFractionDigits="2" maxFractionDigits="2"/> €</p>
                </div>
            </div>
            <hr>
        </c:forEach>
    </div>
    <div class="side_right">
        <div style="width: 100%; text-align: center">
            <h3 style="padding: 0; margin: 10px;">${total} Prodotti totali</h3>
            <hr style="width: 80%">
        </div>
        <div style="width: 100%; text-align: center">
            <div id="indirizzi">
                <h3>Indirizzo per questo ordine</h3>
                <p>${address_resp.name} ${address_resp.cognome}<br>${address_resp.via} ${address_resp.numero_civico}, ${address_resp.cap} ${address_resp.comune} (${address_resp.provincia})</p>
                <a href="${pageContext.request.contextPath}/address_page?reason=ORDER">Cambia indirizzo</a>
                <hr style="width: 80%">
                <h3>Scegli come Pagare</h3>
                <div class="form">
                    <label>
                        <input name="pagamento" value="Visa" type="radio">
                        Visa
                    </label>
                    <label>
                        <input name="pagamento" value="paypal" type="radio">
                        PayPal
                    </label>
                </div>
                <h3>Prezzo totale: <span class="total_price"><fmt:formatNumber value="${price}" type="number" minFractionDigits="2" maxFractionDigits="2"/> €</span></h3>
            </div>
        </div>
        <div style="width: 100%; text-align: center">
            <button class="submit" style="width: 80%" onclick="location.href = '${pageContext.request.contextPath}/make_order'">Compra</button>
        </div>
    </div>
</div>
<%@ include file="include/footer.jsp" %>
</body>
</html>