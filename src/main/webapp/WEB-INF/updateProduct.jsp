<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<html>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/updateProduct.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/NotifyUser.css">
    <link type="image/x-icon" rel="icon" href="img/solo_logo.png">
    <title>Modifica ${product.name}</title>
</head>
<script type="module" src="${pageContext.request.contextPath}/js/productAdmin/productManage.js"></script>
<body>
<div class="containerpopup">
    <h1>Modifica Prodotto</h1>
    <div id="container-img">
        <img id="image-src">
        <div id="img-prev">
            <c:forEach items="${product.photo_path}" var="photo">
                <div class="img-item">
                    <img alt="preview image ${photo}" src="${pageContext.request.contextPath}${photo}">
                    <span>&#10006;</span>
                </div>
            </c:forEach>
            <form action="Upload" method="post" enctype="multipart/form-data">
                <label for="file-upload" class="custom-file-upload">
                    <img src="${pageContext.request.contextPath}/img/plus-icon.jpg">
                </label>
                <input id="file-upload" type="file" accept="image/*"/>
            </form>
        </div>
        <button class="editImage">Editing</button>
    </div>
    <div class="product-form">
        <div class="form-group">
            <c:choose>
                <c:when test="${not empty newProd}">
                    <input type="hidden" id="new_prod" value="new_prod">
                    <label for="id_prod">ID:</label>
                    <input type="text" id="id_prod" class="newProd" style="margin-right: 85px" value="${product.id}">
                </c:when>
                <c:otherwise>
                    <input type="hidden" id="new_prod" value="">
                    <label for="id_prod">ID:</label>
                    <input type="text" id="id_prod" style="margin-right: 85px" value="${product.id}" disabled>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="form-group">
            <label for="name">Nome:</label>
            <input type="text" id="name" value="${product.name}" disabled>
            <button>Modifica</button>
        </div>
        <div class="form-group">
            <label for="price">Prezzo:</label>
            <input type="number" min="1" id="price" value="${product.price}" disabled>
            <button>Modifica</button>
        </div>
        <div class="form-group">
            <label for="category">Categoria:</label>
            <input type="text" id="category" value="${product.categoria}" disabled>
            <button>Modifica</button>
        </div>
        <div class="form-group">
            <label for="nutrition">Alimentazione:</label>
            <input type="text" id="nutrition" value="${product.alimentazione}" disabled>
            <button>Modifica</button>
        </div>
        <div class="form-group">
            <label for="quantity">Quantità:</label>
            <input type="number" id="quantity" value="${product.quantity}" disabled>
            <button>Modifica</button>
        </div>
        <div class="form-group">
            <label for="description">Descrizione:</label>
            <textarea id="description" style="resize: none;" rows="5" disabled>${product.description}</textarea>
            <button>Modifica</button>
        </div>
        <div class="form-actions">
            <button id="applica-btn">Applica</button>
        </div>
    </div>
</div>
</body>
</html>
