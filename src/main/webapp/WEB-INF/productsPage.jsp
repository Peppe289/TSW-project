<%--@elvariable id="products" type="org.dinosauri.dinosauri.model.Product"--%>
<%--@elvariable id="nutritions" type="java.util.List"--%>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/carosello.css">
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/filter.css">
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/listproduct.css">
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/project.css">
    <link type="image/x-icon" rel="icon" href="${pageContext.request.contextPath}/img/solo_logo.png">

    <link href='https://fonts.googleapis.com/css?family=Open Sans' rel='stylesheet'>

    <title>DinoStore</title>

</head>

<body>
<%@ include file="include/navbar.jsp" %>
<%@ include file="include/upButton.html" %>
<%@ include file="include/carrello_portable.html" %>

<script defer>
    const product_nav = document.getElementById("product_nav");
    product_nav.classList.add("curr-page");
</script>

<%
    HashMap<String, Integer> hashMap = (HashMap<String, Integer>) request.getServletContext().getAttribute("categories");

    if (hashMap != null) {
        Set<String> keys = hashMap.keySet();
        for (String key : keys) {
            if (hashMap.get(key) != 0) {
%>
                <input type="hidden" class="cat extra-filter" value="<%= key %>">
<%
            } else {
%>
                <input type="hidden" class="cat" value="<%= key %>">
<%
            }
        }
    }
%>

<div id="content-main">
    <!-- filtro ricerca -->
    <div id="filter" class="not-select bg-f4f5f5 sticky-top">
        <h4>Filtri di ricerca</h4>

        <form id="filter-form" action="">
            <label>
                Ordina Per
                <select name="sort">
                    <option value="seleziona" selected="selected">seleziona</option>
                    <option value="price_cresc">Prezzo Crescente</option>
                    <option value="price_dec">Prezzo Decrescente</option>
                    <option value="quantity_cresc">Quantità Crescente</option>
                    <option value="quantity_dec">Quantità Decrescente</option>
                </select>
            </label>
            <h4 id="cat-title">Categoria</h4>

            <%
                if (hashMap != null) {
                    Set<String> keys = hashMap.keySet();
                    for (String key : keys) {
            %>
                    <div class="single-table">
                        <input type="checkbox" id="<%=key%>" name="cat" value="<%=key%>">
                        <label for="<%=key%>"><%=key%></label>
                    </div>
            <%
                    }
                }
            %>

            <h4 id="nut-title">Alimentazione</h4>

            <c:forEach items="${nutritions}" var="nut">
                <div class="single-table">
                    <input type="checkbox" id="${nut}" name="nut" value="${nut}">
                    <label for="${nut}">${nut}</label>
                </div>
            </c:forEach>
            <input class="bg-3CB371" type="submit" value="filtra">
        </form>
    </div>

    <button id="button-mobile-form-submit" class="bg-3CB371" type="submit" form="filter-form">Filtra</button>
    <!-- end filtro ricerca-->

    <div id="parent-cont">
        <c:forEach items="${products}" var="product">
            <a href="p?product=${product.id}" class="item text">
                <c:choose>
                    <c:when test="${not empty product.photo_path[0]}">
                        <img alt="${product.name}" class="bg-f4f5f5" src="${pageContext.request.contextPath}/${product.photo_path[0]}" onError="this.onerror=null; this.src='img/missing.jpg'">
                    </c:when>
                    <c:otherwise>
                        <img alt="${product.name}" class="bg-f4f5f5" src="${pageContext.request.contextPath}/img/missing.jpg">
                    </c:otherwise>
                </c:choose>
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

<%@ include file="include/btn_page.jsp" %>
<%@ include file="include/footer.jsp" %>
<script src="${pageContext.request.contextPath}/js/ProductsFilter.js"></script>
</body>
</html>