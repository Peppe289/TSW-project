<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link type="text/css" rel="stylesheet" href="css/carosello.css">
    <link type="text/css" rel="stylesheet" href="css/filter.css">
    <link type="text/css" rel="stylesheet" href="css/listproduct.css">
    <link type="text/css" rel="stylesheet" href="css/project.css">
    <link type="image/x-icon" rel="icon" href="img/solo_logo.png">

    <style>
        /**
         * Scrolling fluido per i collegamenti interni
         * Es. Il tasto per tornare in alto alla pagina.
         */
        html {
            scroll-behavior: smooth
        }

        /* serve per far stare il footer in basso */
        body {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        footer {
            margin-top: auto;
        }

        a, a:visited, a:hover, a:active {
            color: inherit;
        }

        .item {
            font-family: 'Open Sans', Arial, sans-serif;
        }
    </style>

    <link href='https://fonts.googleapis.com/css?family=Open Sans' rel='stylesheet'>

    <title>DinoStore</title>
</head>
<script type="module" src="js/eventListener.js"></script>

<body style="margin: 0; padding: 0">

<a id="top-button" href="#" style="position: fixed;
    height: 50px; width: 50px; border-radius: 50%; display: flex;
    justify-content: space-around; bottom: 20px; right: 20px;
    background-color: rgb(232, 232, 232); z-index: 600000">
    <img alt="Torna su" src="${pageContext.request.contextPath}/img/arrows.png" style="padding: 5px">
</a>

<%@ include file="WEB-INF/include/navbar.jsp" %>

<!-- carosello -->
<div class="slideshow-container not-select">
    <div class="slides">
        <img alt="Slide" src="img/missing.jpg" onError="this.onerror=null; this.src='img/missing.jpg';" style="width:100%">
        <div class="text">Caption Text</div>
    </div>

    <div class="slides">
        <img alt="Slide" src="img/missing.jpg" onError="this.onerror=null; this.src='img/missing.jpg';" style="width:100%">
        <div class="text">Caption Two</div>
    </div>

    <div class="slides">
        <img alt="Slide" src="img/missing.jpg" onError="this.onerror=null; this.src='img/missing.jpg';" style="width:100%">
        <div class="text">Caption Three</div>
    </div>

    <button class="prev" onclick="plusSlides(-1)">❮</button>
    <button class="next" onclick="plusSlides(1)">❯</button>
</div>
<!-- end carosello -->

<div id="content-main">
    <div id="parent-cont">

    </div>
</div>

<style>
    #btn-page {
        display: inline-block;
        text-align: center;
        margin: auto;
        overflow: hidden;
        position: relative;
        width: auto;
        font-family: Arial, Helvetica, sans-serif;

        & ul {
            list-style-type: none;
            padding: 0;
        }

        & a,
        & a:visited,
        & a:hover,
        & a:active {
            color: inherit;
        }

        & * {
            display: inline-block;
            text-decoration: none;
        }

        & li {
            border-radius: 5px;
        }

        & a {
            padding: 10px;
        }

        & .active {
            color: white;
        }

        & .other {
            background-color: #ececec;
        }

        & .deactive {
            pointer-events: none;
            background-color: #939393;
            color: #cdcdcd;
        }
    }
</style>
<div id="btn-page" class="not-select">
    <ul>
        <li class="bg-3CB371 active"><a href="${pageContext.request.contextPath}/product">Mostra più
            prodotti</a></li>
    </ul>
</div>
<%@ include file="WEB-INF/include/footer.jsp" %>
</body>
<script>
    let slideIndex = 1;

    showSlides(slideIndex);

    function plusSlides(n) {
        showSlides(slideIndex += n);
    }

    function showSlides(n) {
        let i;
        let slides = document.getElementsByClassName("slides");
        if (n > slides.length) {
            slideIndex = 1
        }
        if (n < 1) {
            slideIndex = slides.length
        }
        for (i = 0; i < slides.length; i++) {
            slides[i].style.display = "none";
        }
        slides[slideIndex - 1].style.display = "block";
    }
</script>

</html>