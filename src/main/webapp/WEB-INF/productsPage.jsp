<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link type="text/css" rel="stylesheet" href="css/carosello.css">
    <link type="text/css" rel="stylesheet" href="css/filter.css">
    <link type="text/css" rel="stylesheet" href="css/listproduct.css">
    <link type="text/css" rel="stylesheet" href="css/project.css">
    <link type="text/css" rel="stylesheet" href="css/home.css">
    <link type="image/x-icon" rel="icon" href="img/solo_logo.png">

    <link href='https://fonts.googleapis.com/css?family=Open Sans' rel='stylesheet'>

    <title>DinoStore</title>

</head>

<body style="margin: 0; padding: 0">
<%@ include file="include/navbar.jsp" %>
<a id="top-button" href="#" style="position: fixed;
    height: 50px; width: 50px; border-radius: 50%; display: flex;
    justify-content: space-around; bottom: 20px; right: 20px;
    background-color: rgb(232, 232, 232); z-index: 600000">
    <img src="${pageContext.request.contextPath}/img/arrows.png" style="padding: 5px">
</a>

<%@ include file="include/carrello_portable.html" %>

<script defer>
    const product_nav = document.getElementById("product_nav");
    product_nav.classList.add("curr-page");
</script>
<div id="content-main">
    <!-- filtro ricerca -->
    <div id="filter" class="not-select bg-f4f5f5 sticky-top">
        <h4>Filtri di ricerca</h4>
        <form id="filter-form" action="">
            <h4>Categoria</h4>

            <div class="single-table">
                <input type="checkbox" id="terra" name="cat" value="terra">
                <label for="terra">Terra</label>
            </div>

            <div class="single-table">
                <input type="checkbox" id="acqua" name="cat" value="acqua">
                <label for="acqua">Acqua</label>
            </div>

            <div class="single-table">
                <input type="checkbox" id="aria" name="cat" value="aria">
                <label for="aria">Aria</label>
            </div>

            <div class="single-table">
                <input type="checkbox" id="ossa" name="cat" value="ossa">
                <label for="ossa">Ossa</label>
            </div>

            <div class="single-table">
                <input type="checkbox" id="uova" name="cat" value="uova">
                <label for="uova">Uova</label>
            </div>

            <div class="single-table">
                <input type="checkbox" id="guinzagli" name="cat" value="guinzaglio">
                <label for="guinzagli">Guinzagli</label>
            </div>

            <h4>Alimentazione</h4>

            <div class="single-table">
                <input type="checkbox" id="carnivori" name="nut" value="carnivoro">
                <label for="carnivori">Carnivori</label>
            </div>

            <div class="single-table">
                <input type="checkbox" id="onnivori" name="nut" value="onnivoro">
                <label for="onnivori">Onnivori</label>
            </div>

            <div class="single-table">
                <input type="checkbox" id="erbivori" name="nut" value="erbivoro">
                <label for="erbivori">Erbivori</label>
            </div>

            <input class="bg-3CB371" type="submit" value="filtra">
        </form>
    </div>
    <button id="button-mobile-form-submit" class="bg-3CB371" type="submit" form="filter-form">Filtra</button>

    <script>
        document.addEventListener('DOMContentLoaded', (event) => {
            let catCheck = document.getElementsByName("cat");
            let nutCheck = document.getElementsByName("nut");

            // Funzione per caricare lo stato delle checkbox dal localStorage
            function loadCheckboxState(checkboxes) {
                for (let i = 0; i < checkboxes.length; i++) {
                    let checkbox = checkboxes[i];
                    if (localStorage.getItem(checkbox.id) === 'true') {
                        checkbox.checked = true;
                    }
                }
            }

            // Funzione per salvare lo stato delle checkbox nel localStorage
            function saveCheckboxState(checkboxes) {
                for (let i = 0; i < checkboxes.length; i++) {
                    let checkbox = checkboxes[i];
                    checkbox.addEventListener('change', function() {
                        localStorage.setItem(checkbox.id, checkbox.checked);
                    });
                }
            }

            // Carica lo stato delle checkbox
            loadCheckboxState(catCheck);
            loadCheckboxState(nutCheck);

            // Aggiungi event listener per salvare lo stato quando cambia
            saveCheckboxState(catCheck);
            saveCheckboxState(nutCheck);
        });
    </script>
    <!-- end filtro ricerca-->

    <div id="parent-cont">
        <c:forEach items="${products}" var="product">
            <a href="p?product=${product.id}" class="item">
                <img class="bg-f4f5f5" src="${pageContext.request.contextPath}/img/logo.png">
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

<div id="btn-page" class="not-select">
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
</div>
<%@ include file="include/footer.jsp" %>
</body>
</html>