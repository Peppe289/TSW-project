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

<jsp:include page="include/navbar.jsp"/>

<!-- carosello -->
<c:if test="${not empty isHome}">
    <div class="slideshow-container not-select">
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
        <div id="filter" class="not-select bg-f4f5f5 sticky-top">
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

                <input class="bg-3CB371" type="submit" value="filtra">
            </form>
        </div>
        <button id="button-mobile-form-submit" class="bg-3CB371" type="submit" form="filter-form">Filtra</button>
    </c:if>
    <!-- end filtro ricerca-->

    <div id="parent-cont">
        <c:forEach items="${products}" var="product">
            <a href="p?product=${product.id}" class="item">
                <img class="bg-f4f5f5" src="https://via.placeholder.com/600x200/00ff00/ffffff">
                <c:if test="${product.sconto != 0}">
                    <div class="off">
                        <p>-${product.sconto}%</p>
                    </div>
                </c:if>
                <div class="item-desc">
                    <p class="title-product">${product.name}</p>
                    <p class="desc overtext">
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
    <c:choose>
        <c:when test="${empty isHome}">
            <ul>
                <li class="${page > 0 ? 'bg-3CB371 active' : 'deactive'}">
                    <a href="${pageContext.request.contextPath}/product?page=${page - 1}&search=${lastSearch}">Precedente</a>
                </li>
                <c:forEach var="number" begin="0" end="${btn_page}">
                    <li class="${page == number ? 'bg-3CB371 active' : 'other'}">
                        <a href="${pageContext.request.contextPath}/product?page=${number}&search=${lastSearch}">${number + 1}</a>
                    </li>
                </c:forEach>
                <li class="${page < btn_page ? 'bg-3CB371 active' : 'deactive'}">
                    <a href="${pageContext.request.contextPath}/product?page=${page + 1}&search=${lastSearch}">Successiva</a>
                </li>
            </ul>
        </c:when>
        <c:otherwise>
            <ul>
                <li class="bg-3CB371 active"><a href="${pageContext.request.contextPath}/product">Mostra più
                    prodotti</a></li>
            </ul>
        </c:otherwise>
    </c:choose>
</div>
<jsp:include page="include/footer.jsp"/>
</body>
<c:if test="${not empty isHome}">
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
</c:if>
</html>