<%--@elvariable id="userProfile" type="org.dinosauri.dinosauri.model.User"--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Ordini di ${userProfile.nome}</title>
    <link type="image/x-icon" rel="icon" href="${pageContext.request.contextPath}/img/solo_logo.png">
    <style>

        p {
            pointer-events: none;
        }

        .gesture {
            width: 100%;
            margin: 20px;
        }

        .gesture button {
            padding: 10px;
        }

        .order {
            margin-bottom: 20px;
            border: 1px solid #E0E0E0;
            border-radius: 4px;
            overflow: hidden;
            box-shadow: 0 2px 4px rgba(0,0,0,0.18), 0 3px 10px rgba(0,0,0,0.12);
            transition: box-shadow 0.3s ease-in-out;
        }

        .order:hover {
            box-shadow: 0 5px 15px rgba(0,0,0,0.32), 0 5px 20px rgba(0,0,0,0.24);
        }

        .head {
            display: flex;
            flex-direction: row;
            justify-content: space-around;
            cursor: pointer;
            background-color: rgba(236, 236, 236, 0.55);
            padding: 16px;
            font-family: 'Roboto', 'Helvetica', 'Arial', sans-serif;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }

        .head:hover {
            background-color: #d2d2d2;
        }

        .head p {
            margin: 0;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            transition: max-height 0.5s ease-out;
        }

        .hide {
            display: none;
        }

        th, td {
            padding: 16px;
            text-align: left;
            border-bottom: 1px solid #E0E0E0;
        }

        th {
            background-color: #F5F5F5;
            color: #757575;
        }

        tr:nth-child(even) {
            background-color: #FAFAFA;
        }

        tr:hover {
            background-color: #ECEFF1;
        }
    </style>
</head>
<body>

<h1>
    ${userProfile.nome} ${userProfile.cognome}
</h1>
<hr>

<c:if test="${empty orderList}">
    <span>
        Questo utente non ha effettuato ordini.
    </span>
</c:if>

<div class="gesture">
    <button onclick="history.back()">Torna indietro</button>
</div>

<%--@elvariable id="orderList" type="java.util.List"--%>
<c:forEach items="${orderList}" var="ordine">
    <div class="order">
        <div class="head">
            <p>${ordine.date}</p>
            <p>${ordine.address.via}, ${ordine.address.comune} (${ordine.address.provincia})</p>
            <p>${ordine.total_price} €</p>
        </div>
        <table class="hide">
            <tbody>
            <tr>
                <td>Quantità</td>
                <td>Prodotto</td>
                <td>Prezzo</td>
                <td>Prezzo Totale</td>
            </tr>
            <c:forEach var="entry" items="${ordine.name}">
                <tr>
                    <td>${ordine.quantity[entry.key]}x</td>
                    <td>${entry.value}</td>
                    <td>${ordine.price[entry.key]} €</td>
                    <td>${ordine.quantity[entry.key] * ordine.price[entry.key]} €</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</c:forEach>
<script>
    const elements = document.getElementsByClassName("head");

    Array.from(elements).forEach(el => {
        if (el.tagName.toUpperCase() === "DIV" && el.classList.contains("head")) {
            el.addEventListener("click", (event) => {
                const table = event.target.parentElement.getElementsByTagName("table")[0];
                table.classList.toggle("hide");
            });
        }
    });
</script>
</body>
</html>