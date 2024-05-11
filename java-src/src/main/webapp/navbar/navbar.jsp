<%--
  Created by IntelliJ IDEA.
  User: peppe289
  Date: 5/11/24
  Time: 3:00 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <!--
    inutile linkare qui, serve linkare nelle pagine in cui includo la jsp

    <link type="text/css" rel="stylesheet" href="dropdown.css">
    <link type="text/css" rel="stylesheet" href="style.css">
    -->
</head>
<!--<script src="move.js"></script>-->
<body>

<div id="mobile-bar">
    <img src="img/solo_logo.png">
    <form class="form-bar" action="search">
        <input type="text">
        <button><img src="img/search_ico.png"></button>
    </form>
    <div class="open-btn" onclick="openNav()">☰</div>
</div>

<nav id="navbar">
    <ul>
        <!-- il logo si nasconde quando siamo da mobile -->
        <li class="logo"><img src="img/logo.png"></li>
        <li><a class="" href="#">Home</a></li>
        <li><a class="" href="#">Offerte</a></li>
        <li><a class="" href="#">Categorie</a></li>
        <li><a class="" href="#">Prodotti</a></li>
        <li>
            <div class="dropdown">
                <button class="dropbtn">
                    Area Utente
                </button>
                <div class="dropdown-content">
                    <a href="#">Carrello</a>
                    <a href="#">Log out</a>
                    <a href="#">Ordini</a>
                    <a href="https://www.youtube.com/watch?v=xvFZjo5PgG0">RickRoll</a>
                </div>
            </div>
        </li>
        <li></li>
        <form class="form-bar" action="search">
            <input type="text">
            <button><img src="img/search_ico.png"></button>
        </form>
    </ul>
</nav>
</body>
</html>
