<%--
  Created by IntelliJ IDEA.
  User: peppe289
  Date: 5/11/24
  Time: 3:00 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<html>
<head>
    <link type="text/css" rel="stylesheet" href="css/navbar.css">
</head>
<body>
<div id="mobile-bar">
    <img src="${pageContext.request.contextPath}/img/solo_logo.png">
    <form class="form-bar" action="${pageContext.request.contextPath}/search">
        <input class="bg-f4f5f5" type="text" name="search" value="${lastSearch}">
        <button class="bg-f4f5f5"><img src="${pageContext.request.contextPath}/img/search_ico.png"></button>
    </form>
    <div class="open-btn not-select" onclick="openNav()">☰</div>
</div>

<nav class="bg-f4f5f5" id="navbar">
    <ul>
        <!-- il logo si nasconde quando siamo da mobile -->
        <li class="logo"><img src="${pageContext.request.contextPath}/img/logo.png"></li>
        <li><a id="home_nav" href="${pageContext.request.contextPath}/">Home</a></li>
        <li><a class="" href="#">Offerte</a></li>
        <li><a class="" href="#">Categorie</a></li>
        <li><a class="" href="${pageContext.request.contextPath}/product">Prodotti</a></li>
        <li>
            <div class="dropdown">
                <button class="dropbtn">
                    Area Utente
                </button>
                <div class="dropdown-content">
                    <a href="#">Carrello</a>
                    <!-- user dovrebbe stare nella sessione -->
                    <c:choose>
                        <c:when test="${not empty user}">
                            <a href="${pageContext.request.contextPath}/logout">Log out</a>
                            <a href="#">Ordini</a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/login.jsp">Accedi</a>
                            <a href="${pageContext.request.contextPath}/registrazione.jsp">Registrati</a>
                        </c:otherwise>
                    </c:choose>
                    <a href="https://www.youtube.com/watch?v=xvFZjo5PgG0" target="_blank">RickRoll</a>
                </div>
            </div>
        </li>
        <li></li>
        <form class="form-bar" action="${pageContext.request.contextPath}/search">
            <input type="text" name="search" value="${lastSearch}">
            <button><img src="${pageContext.request.contextPath}/img/search_ico.png"></button>
        </form>
    </ul>
</nav>
<script>
    var isOpen = false;
    var navBarStyle = document.getElementById("navbar").style;

    function openNav() {

        if (!isOpen) {
            navBarStyle.left = "0";
        } else {
            navBarStyle.left = "-260px";
        }

        isOpen = !isOpen;
    }
</script>
</body>
</html>
