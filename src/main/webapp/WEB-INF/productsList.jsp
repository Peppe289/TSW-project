<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link type="text/css" rel="stylesheet" href="css/carosello/style.css">
    <link type="text/css" rel="stylesheet" href="css/filtro/style.css">
    <link type="text/css" rel="stylesheet" href="css/misc/style.css">

    <link href='https://fonts.googleapis.com/css?family=Open Sans' rel='stylesheet'>

    <title>DinoStore</title>
</head>

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

<body style="margin: 0; padding: 0">

<a id="top-button" href="#" style="position: fixed;
    height: 50px; width: 50px; border-radius: 50%; display: flex;
    justify-content: space-around; bottom: 20px; right: 20px;
    background-color: rgb(232, 232, 232); z-index: 600000">
    <img src="${pageContext.request.contextPath}/img/arrows.png" style="padding: 5px">
</a>

<jsp:include page="navbar/navbar.jsp"/>

<!-- carosello -->
<c:if test="${not empty isHome}">
    <div class="slideshow-container">
        <div class="slides">
            <img src="https://via.placeholder.com/600x300/0000ff/ffffff" style="width:100%">
            <div class="text">Caption Text</div>
        </div>

        <div class="slides">
            <img src="https://via.placeholder.com/600x200/00ff00/ffffff" style="width:100%">
            <div class="text">Caption Two</div>
        </div>

        <div class="slides">
            <img src="https://via.placeholder.com/600x300/ff0000/ffffff" style="width:100%">
            <div class="text">Caption Three</div>
        </div>

        <a class="prev" onclick="plusSlides(-1)">❮</a>
        <a class="next" onclick="plusSlides(1)">❯</a>
    </div>
</c:if>
<!-- end carosello -->

<div id="content-main">
    <!-- filtro ricerca -->
    <c:if test="${empty isHome}">
        <div id="filter">
            <h4>Filtri di ricerca</h4>
            <form id="filter-form" action="">
                <h4>Ambiente</h4>

                <div class="single-table">
                    <input type="checkbox" id="terrestri" name="terrestri">
                    <label for="terrestri">Terrestri</label>
                </div>

                <div class="single-table">
                    <input type="checkbox" id="volatili" name="volatili">
                    <label for="volatili">Volatili</label>
                </div>

                <div class="single-table">
                    <input type="checkbox" id="acquatici" name="acquatici">
                    <label for="acquatici">Acquatici</label>
                </div>

                <h4>Alimentazione</h4>

                <div class="single-table">
                    <input type="checkbox" id="carnivori" name="carnivori">
                    <label for="carnivori">Carnivori</label>
                </div>

                <div class="single-table">
                    <input type="checkbox" id="onnivori" name="onnivori">
                    <label for="onnivori">Onnivori</label>
                </div>

                <div class="single-table">
                    <input type="checkbox" id="erbivori" name="erbivori">
                    <label for="erbivori">Erbivori</label>
                </div>

                <input type="submit" value="filtra">
            </form>
        </div>
        <button id="button-mobile-form-submit" type="submit" form="filter-form">Filtra</button>
    </c:if>
    <!-- end filtro ricerca-->

    <div id="parent-cont">
        <c:forEach items="${products}" var="product">
            <a href="p?product=${product.id}" class="item">
                <img src="https://via.placeholder.com/600x200/00ff00/ffffff">
                <c:if test="${product.sconto != 0}">
                    <div class="off">
                        <p>-${product.sconto}%</p>
                    </div>
                </c:if>
                <div class="item-desc">
                    <p class="title-product">${product.name}</p>
                    <p class="desc">
                            ${product.description}
                    </p>
                    <div style="display: flex; margin: 0; padding: 5px 0 0;">
                        <c:choose>
                            <c:when test="${product.sconto != 0}">
                                <p class="prezzo">
                                    <fmt:formatNumber value="${product.price * (1 - (product.sconto / 100))}"
                                                      type="number" minFractionDigits="2" maxFractionDigits="2"/>&#8364;
                                </p>
                                <s style="height: 100%; margin-top: 15px; padding: 0">
                                    <fmt:formatNumber value="${product.price}"
                                                      type="number" minFractionDigits="2"
                                                      maxFractionDigits="2"/>&#8364;</s>
                            </c:when>
                            <c:otherwise>
                                <p class="prezzo"><fmt:formatNumber value="${product.price}"
                                                                    type="number" minFractionDigits="2"
                                                                    maxFractionDigits="2"/>&#8364;</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </a>
        </c:forEach>
    </div>
</div>

<jsp:include page="footer/footer.jsp"/>
</body>
<script>
    let slideIndex = 1;

    showSlides(slideIndex);

    function plusSlides(n) {
        showSlides(slideIndex += n);
    }

    function currentSlide(n) {
        showSlides(slideIndex = n);
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