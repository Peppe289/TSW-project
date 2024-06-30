<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<html>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/NotifyUser.css">
    <link type="image/x-icon" rel="icon" href="img/solo_logo.png">
    <title>Modifica ${product.name}</title>
</head>
<style>
    body {
        background-color: #f4f4f4;
        margin: 0;
        padding: 0;
    }

    #container-img {
        display: flex;
        height: 200px;
        justify-content: center;

        #image-src {
            margin-right: 50px;
        }

        & > img {
            object-fit: cover;
            max-width: 400px;
        }

        & #img-prev {
            width: 100%;
            gap: 10px;
            object-fit: cover;
            display: flex;
            flex-wrap: wrap;
            overflow: scroll;

            & img {
                height: 60px;
                width: 60px;
                object-fit: contain;
                padding: 5px;
                border: 1px solid #494949;
            }
        }

        & .img-item {
            position: relative;

            & img {
                cursor: pointer;
            }

            & span {
                background-color: red;
                color: white;
                padding: 5px;
                cursor: pointer;
                border-radius: 25%;
                position: absolute;
                top: 0;
                right: 0;
            }
        }

        & input[type="file"] {
            display: none;
        }

        & .custom-file-upload {
            cursor: pointer;
        }

        & form {
            padding: 0;
            margin: 0;
        }
    }

    .hide {
        display: none;
    }

    @keyframes vibrate {
        0% {
            transform: translateX(0);
        }
        25% {
            transform: translateX(-3px);
        }
        50% {
            transform: translateX(3px);
        }
        75% {
            transform: translateX(-3px);
        }
        100% {
            transform: translateX(0);
        }
    }

    .vibrate {
        animation: vibrate 0.4s linear infinite;
    }
</style>
<script type="module" src="${pageContext.request.contextPath}/js/productAdmin/productManage.js"></script>
<body>
<div class="containerpopup">
    <p style="display: none" id="id-product">${product.id}</p>
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
        <div class="form-group"><label for="name">Nome:</label> <input type="text" id="name" value="${product.name}"
                                                                       disabled>
            <button>Modifica</button>
        </div>
        <div class="form-group"><label for="price">Prezzo:</label> <input type="text" id="price"
                                                                          value="${product.price}" disabled>
            <button>Modifica</button>
        </div>
        <div class="form-group"><label for="category">Categoria:</label> <input type="text" id="category"
                                                                                value="${product.categoria}" disabled>
            <button>Modifica</button>
        </div>
        <div class="form-group"><label for="nutrition">Alimentazione:</label> <input type="text" id="nutrition"
                                                                                     value="${product.alimentazione}"
                                                                                     disabled>
            <button>Modifica</button>
        </div>
        <div class="form-group"><label for="description">Descrizione:</label> <textarea id="description"
                                                                                        style="resize: none;" rows="5"
                                                                                        disabled>${product.description}</textarea>
            <button>Modifica</button>
        </div>
        <div class="form-actions">
            <button id="applica-btn">Applica</button>
            <button id="delete-btn">Elimina Prodotto</button>
            <button onclick="window.close()">Chiudi</button>
        </div>
    </div>
</div>
</body>
</html>
