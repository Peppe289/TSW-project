<%--@elvariable id="products" type="org.dinosauri.dinosauri.model.Product"--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/listproduct.css">
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/project.css">
    <link type="image/x-icon" rel="icon" href="${pageContext.request.contextPath}/img/solo_logo.png">
    <link href='https://fonts.googleapis.com/css?family=Open Sans' rel='stylesheet'>
    <meta charset="UTF-8">
    <title>Offerte</title>
</head>

<style>
    #container {
        display: flex;
        flex-direction: column;
        width: 100%;
    }

    .items {
        box-shadow: 1px 0 5px #9d9d9d;
        margin: 10px auto;
        padding: 10px;
        width: 90%;
        display: flex;
        flex-wrap: wrap;

        & > div {
            height: 100%;
            margin-inline: 20px;
            align-items: center;
            align-content: center;

            & h1,
            & p {
                padding: 5px;
                margin: 5px;
                height: 35px;
            }
        }

        .info {
            width: calc(100% - 280px);
        }

        & .img {
            height: 100%;

            & img {
                object-fit: contain;
                margin: auto;
                height: 100px;
                width: 100px;
            }
        }
    }

    @media screen and (max-width: 1000px) {
        .info {
            width: 100% !important;
        }
    }
</style>

<body>
<%@ include file="include/navbar.jsp" %>
<%@ include file="include/carrello_portable.html" %>
<div id="container">
    <c:forEach items="${products}" var="product">
        <a class="items text" href="p?product=${product.id}">
            <div class="img">
                <c:choose>
                    <c:when test="${not empty product.photo_path[0]}">
                        <img alt="${product.name}" class="bg-f4f5f5" src="${pageContext.request.contextPath}/${product.photo_path[0]}" onError="this.onerror=null; this.src='img/missing.jpg'">
                    </c:when>
                    <c:otherwise>
                        <img alt="${product.name}" class="bg-f4f5f5" src="${pageContext.request.contextPath}/img/missing.jpg">
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="overtext info">
                <h1>${product.name}</h1>
                <p>${product.description}</p>
            </div>
        </a>
    </c:forEach>
</div>

<script defer>
    const offerte = document.getElementById("offerte");
    offerte.classList.add("curr-page");
</script>
<%@ include file="include/footer.jsp" %>
</body>
</html>