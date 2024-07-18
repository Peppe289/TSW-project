<%@ page import="java.util.*" %>
<%@ page import="org.dinosauri.dinosauri.model.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Page</title>
    <link type="text/css" rel="stylesheet" href="css/admin.css">
    <link type="image/x-icon" rel="icon" href="${pageContext.request.contextPath}/img/solo_logo.png">
</head>
<body>
<div id="main_container">
    <%@ include file="sidebar.jsp" %>
    <div id="content">
        <div id="prodotti" class="section">
            <h3>Prodotti</h3>
            <hr>
            <button style="margin: 10px;" onclick='window.location.href="${pageContext.request.contextPath}/editid"'>Aggiungi Prodotti</button>
            <button style="margin: 10px; background-color: white; color: black; border: 1px solid black;" onclick='window.location.href="${pageContext.request.contextPath}/adminControl"'>Ricarica</button>
            <table>
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>Descrizione</th>
                    <th>Quantità Disponibile</th>
                    <th>Quantità Venduta</th>
                    <th>Prezzo</th>
                    <th></th>
                </tr>
                <c:forEach items="${products}" var="prod">
                <tr>
                    <td>${prod.id}</td>
                    <td>${prod.name}</td>
                    <td>${prod.description}</td>
                    <td>${prod.quantity}</td>
                    <td>${prod.bought}</td>
                    <td>${prod.price}</td>
                    <td>
                        <button class="edit" onclick='window.location.href="${pageContext.request.contextPath}/editid?id=${prod.id}"'>Edit</button>
                    </td>
                </tr>
                </c:forEach>
            </table>
        </div>
    </div>
</div>
</body>
</html>