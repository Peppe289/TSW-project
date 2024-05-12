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
    <!--
    inutile linkare qui, serve linkare nelle pagine in cui includo la jsp

    <link type="text/css" rel="stylesheet" href="dropdown.css">
    <link type="text/css" rel="stylesheet" href="style.css">
    -->
</head>
<style>
    /**

grazie
https://www.w3schools.com/howto/tryit.asp?filename=tryhow_css_dropdown_navbar

*/
    .dropdown {
        float: left;
        overflow: hidden;
    }

    .dropdown .dropbtn {
        border: none;
        background-color: transparent;
        color: black;
        height: 100%;
    }

    .navbar a:hover,
    .dropdown:hover .dropbtn {
        background-color: #00AE46;
        color: white;
    }

    .dropdown-content {
        position: absolute;
        background-color: #f9f9f9;
        box-shadow: 0 10px 10px #666;
        min-width: 160px;
        z-index: 1;

        /* Aggiungi l'animazione per il dropdown */
        height: 0px;
        overflow: hidden;
        transition: height 1s ease;
    }

    .dropdown-content a {
        float: none;
        color: black;
        padding: 12px 16px;
        text-decoration: none;
        display: block;
        text-align: left;
    }

    .dropdown-content a:hover {
        background-color: #f3f3f3;
        color: #3CB371;
    }

    .dropdown:hover .dropdown-content {
        height: 200px;
    }

    @media screen and (max-width: 1000px) {
        .dropdown, .dropbtn {
            width: 100%;
        }

        .dropdown-content,
        .dropdown-content a {
            width: 100%;
        }
    }

    nav {
        /**
         * Il colore incide anche nell'icona di ricerca
         * poiché quella non ha background.
         */
        background-color: #F4F5F5;
        overflow: hidden;
        font-family: 'Open Sans';
        z-index: 20;
        box-shadow: 0 0 15px rgba(0, 0, 0, 0.5);
    }

    /* metti la nav bar a sinistra */
    .form-bar {
        display: flex;
        align-items: center;
        float: right;
        padding-top: 15px;
    }

    /**
     * Tolgo tutti i margini a quello che sta dentro
     * altrimenti la navbar in basso ha uno spazio
     * che non ci deve essere.
     */
    .form-bar * {
        margin: 0;
    }

    .form-bar input[type="text"],
    .form-bar input[type="text"]:focus {
        padding: 10px;
        border: 2px solid #3CB371;
        background-color: #fff;
        font-size: 16px;
        outline: none;
        transition: border-color 0.3s ease;
        width: 300px;
        border-right: none;
        margin: 0;
        box-sizing: border-box;
        height: 45px;
    }

    .form-bar button {
        border: none;
        background: none;
        height: 45px;
        width: 45px;
        margin: 0px;
        padding: 0px;
    }

    .form-bar button img {
        background: none;
        cursor: pointer;
        width: 45px;
        height: 45px;
        padding: 10px;
        border: 2px solid #3CB371;
        box-sizing: border-box;
        border-left: none;
        margin: 0 20px 0 0;
    }

    nav ul {
        list-style-type: none;
        margin: 0;
        padding: 0;
        overflow: hidden;
    }

    nav li {
        float: right;
    }

    nav li.left {
        float: left;
    }

    nav li a,
    .dropdown .dropbtn {
        display: block;
        color: black;
        text-align: center;
        padding: 24px 18px;
        text-decoration: none;
        font-size: 16px;
    }

    /**
     * Per quando passi sopra con il mouse
     * e/o sei nella pagina corrispondente
     */
    nav li a:hover,
    nav li .curr-page {
        background-color: #00AE46;
        color: white;
    }

    .logo {
        float: left;
        padding: 5px 0 0 5px;
    }

    .logo img {
        margin: 0;
        padding: 0;
        width: 60px;
    }


    /**
     * Devo tenermi +1 altrimenti a 1000 sparisce tutto
     */
    @media screen and (min-width: 1001px) {
        #mobile-bar {
            /* senza !important non funziona */
            display: none !important;
        }
    }

    @media screen and (max-width: 1000px) {

        .form-bar button img {
            width: 46px;
            height: 46px;
        }

        .form-bar button {
            padding: 0px;
            margin: 0px;
        }

        .logo {
            display: none;
        }

        #mobile-bar > img:first-child {
            width: 50px;
            margin-right: 5px;
        }

        nav {
            width: 100%;
            left: 0;
        }

        nav li {
            float: none;
        }

        nav {
            width: 250px;
            height: 100%;
            position: fixed;
            top: 0;
            left: -260px;
            transition: left 0.3s ease;
        }

        nav ul {
            list-style-type: none;
        }

        /**
         * Nascondi la barra di ricerca nella nav bar,
         * ora l'abbiamo nella #mobile-bar
         */
        nav .form-bar {
            display: none;
        }
    }

    #mobile-bar {
        height: 50px;
        background-color: #00AE46;
        padding: 10px;
        display: flex;
        justify-content: space-between;
    }

    #mobile-bar .open-btn {
        cursor: pointer;
        font-size: 50px;
        color: #F4F5F5;

        /* remove selectable text */
        -webkit-user-select: none;
        -ms-user-select: none;
        user-select: none;

        /* Allinea verticalmente */
        display: flex;
        align-items: center;
        padding-bottom: 10px;
        z-index: 999999;
    }

    #mobile-bar .form-bar input[type="text"],
    #mobile-bar .form-bar input[type="text"]:focus {
        padding: 10px;
        font-size: 16px;
        width: 100%;
        max-width: 300px;
        height: 50px;
    }

    #mobile-bar .form-bar button,
    #mobile-bar .form-bar button img {
        background-color: #F4F5F5;
        border: none;
    }

    #mobile-bar .form-bar input,
    #mobile-bar .form-bar button {
        margin-bottom: 20px;
    }

</style>
<body>
<div id="mobile-bar">
    <img src="${pageContext.request.contextPath}/img/solo_logo.png">
    <form class="form-bar" action="search">
        <input type="text">
        <button><img src="${pageContext.request.contextPath}/img/search_ico.png"></button>
    </form>
    <div class="open-btn" onclick="openNav()">☰</div>
</div>

<nav id="navbar">
    <ul>
        <!-- il logo si nasconde quando siamo da mobile -->
        <li class="logo"><img src="${pageContext.request.contextPath}/img/logo.png"></li>
        <c:choose>
            <c:when test="${not empty isHome}">
                <li><a class="curr-page" href="${pageContext.request.contextPath}/">Home</a></li>
            </c:when>
            <c:otherwise>
                <li><a class="" href="${pageContext.request.contextPath}/">Home</a></li>
            </c:otherwise>
        </c:choose>
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
                    <a href="https://www.youtube.com/watch?v=xvFZjo5PgG0">RickRoll</a>
                </div>
            </div>
        </li>
        <li></li>
        <form class="form-bar" action="search">
            <input type="text">
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
