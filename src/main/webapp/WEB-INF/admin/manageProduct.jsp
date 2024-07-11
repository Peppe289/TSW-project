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
</head>
<body>
<div id="main_container">
    <div id="sidebar">
        <ul>
            <li><a class="active" href="#">Prodotti</a></li>
            <li><a href="#">Utenti</a></li>
            <li><a href="#">Admin</a></li>
        </ul>
    </div>
    <div id="content">
        <div id="prodotti" class="section">
            <h3>Prodotti</h3>
            <hr>
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
<script src="js/windowSize.js" defer>
    /**
     * the admin page should not be used from mobile devices. so use js for make
     * redirect or show some banner when the page goes to mobile view.
     */
</script>
</html>