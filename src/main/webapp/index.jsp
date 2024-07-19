<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link type="text/css" rel="stylesheet" href="css/carosello.css">
    <link type="text/css" rel="stylesheet" href="css/filter.css">
    <link type="text/css" rel="stylesheet" href="css/listproduct.css">
    <link type="text/css" rel="stylesheet" href="css/project.css">
    <link type="image/x-icon" rel="icon" href="${pageContext.request.contextPath}/img/solo_logo.png">


    <link href='https://fonts.googleapis.com/css?family=Open Sans' rel='stylesheet'>

    <title>DinoStore</title>

    <script type="module" src="js/eventListener.js"></script>
</head>

<body style="padding: 0">
<%@ include file="WEB-INF/include/navbar.jsp" %>
<%@ include file="WEB-INF/include/upButton.html" %>
<%@ include file="WEB-INF/include/carrello_portable.html" %>

<!-- carosello -->
<div id="carousel" style="overflow-x: scroll; scroll-snap-type: x mandatory">
    <div class="slideshow-container not-select">
        <div class="slides">
            <img alt="Slide" src="img/carosello/image.png" onError="this.onerror=null; this.src='img/missing.jpg';"
                 style="width:100%">
            <div class="text">
                <p class="text">Dinosauri sopravvissuti</p>
            </div>
        </div>

        <div class="slides">
            <img alt="Slide" src="img/carosello/image_1.jpg" onError="this.onerror=null; this.src='img/missing.jpg';"
                 style="width:100%">
            <div class="text">
                <p class="text">Dinosauri nuovi ogni 100 anni</p>
            </div>
        </div>

        <div class="slides">
            <img alt="Slide" src="img/carosello/image_2.jpg" onError="this.onerror=null; this.src='img/missing.jpg';"
                 style="width:100%">
            <div class="text">
                <p class="text">Dinosauri per ogni era</p>
            </div>
        </div>
    </div>
</div>
<button class="prev" onclick="changeSlide(-1)">❮</button>
<button class="next" onclick="changeSlide(1)">❯</button>
<!-- end carosello -->

<input type="hidden" value="${pageContext.request.contextPath}" id="PageContext">

<div id="content-main">
    <div id="parent-cont">

    </div>
</div>

<%@ include file="WEB-INF/include/btn_page.jsp" %>
<%@ include file="WEB-INF/include/footer.jsp" %>
<script>
    let slideIndex = 0;
    let carousel = document.getElementById("carousel");
    let position = carousel.scrollWidth / 3;

    function changeSlide(index) {
        slideIndex = (slideIndex + index + 3) % 3;
        carousel.scrollTo({
            left: position * slideIndex,
            behavior: 'smooth'
        });
    }
</script>
</body>
</html>