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
            <h4 id="cat-title">Categoria</h4>

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
                <input type="checkbox" id="uova" name="cat" value="uovo">
                <label for="uova">Uova</label>
            </div>

            <div class="single-table">
                <input type="checkbox" id="guinzagli" name="cat" value="guinzaglio">
                <label for="guinzagli">Guinzagli</label>
            </div>

            <h4 id="nut-title">Alimentazione</h4>

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

        <script>
            let arr_nutr = document.getElementsByName("nut");
            let arr_cate = document.getElementsByName("cat");
            let nut_title = document.getElementById("nut-title");
            //Array che conterrà solo le categorie che mi interessano
            let arr_cat_utils = [];

            //Inserimento di sole le categorie che mi interessano
            Array.from(arr_cate).forEach(element => {
                if (element.id === "terra" || element.id === "acqua" || element.id === "aria") {
                    arr_cat_utils.push(element);
                }
            });

            //Funzione che fa sparire il filtro di alimentazione
            function nut_invisible() {
                nut_title.style.display = "none";

                Array.from(arr_nutr).forEach(element => {
                    element.parentElement.style.display = "none";
                });
            }

            //Inizialmente quando tutto è disattivato il filtro non deve alimentazione non deve esserci
            nut_invisible();
            arr_cat_utils.forEach(element => {
                element.addEventListener("change", () => {
                    let check = false;

                    /*
                        Mi serve per sapere se almeno uno è checkato
                        in questo modo se deseleziono uno ma l'altro è ancora checkato
                        il filtro "alimentazione" rimane visibile
                    */
                    arr_cat_utils.forEach(element => {
                        if (element.checked) {
                            check = true;
                        }
                    });

                    /*
                        Se almeno uno è checkato allora il filtro Alimentazione compare/rimane.
                        Altrimenti scompare.
                    */
                    if (check) {
                        nut_title.style.display = "block";

                        arr_nutr.forEach(element => {
                            element.parentElement.style.display = "block";
                        });
                    } else {
                        //Deseleziono gli elementi presenti in alimentazione prima di farlo scomparire
                        arr_nutr.forEach(element => {
                           element.checked = false;
                        });

                        nut_invisible();
                    }
                });
            });
        </script>
    </div>

    <button id="button-mobile-form-submit" class="bg-3CB371" type="submit" form="filter-form">Filtra</button>

    <script>
        //mi prendo l'URL
        const params = new URLSearchParams(document.location.search);

        //prendo tutti i parametri che mi interessano e li metto in un array
        let arr_cat = params.getAll("cat");
        let arr_nut = params.getAll("nut");

        //prendo gli elementi che mi interessano
        let form = document.getElementById("filter-form");
        let inp_elements = form.getElementsByTagName("input");

        //scorro gli elementi
        Array.from(inp_elements).forEach(element => {
            if (element.name === "cat") {
                //scorro i cat presenti nell'array di cat
                arr_cat.forEach(string => {
                    if (string === element.value) {
                        element.checked = true;
                    }
                });
            } else {
                //scorro i nut presenti nell'array di nut
                arr_nut.forEach(string => {
                    if (string === element.value) {
                        element.checked = true;
                    }
                })
            }
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