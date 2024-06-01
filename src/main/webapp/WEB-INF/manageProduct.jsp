<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<html>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard/dashboard.css">
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
        }

        & .img-prev {
            width: 100%;
            gap: 10px;
            object-fit: cover;
            display: flex;
            flex-wrap: wrap;

            & img {
                height: 60px;
                padding: 5px;
                border: 1px solid #494949;
            }
        }

        & .img-item {
            position: relative;

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
        0% { transform: translateX(0); }
        25% { transform: translateX(-3px); }
        50% { transform: translateX(3px); }
        75% { transform: translateX(-3px); }
        100% { transform: translateX(0); }
    }

    .vibrate {
        animation: vibrate 0.4s linear infinite;
    }
</style>
<script src="${pageContext.request.contextPath}/js/productAdmin/productManage.js"></script>
<body>
<div class="containerpopup"><h1>Modifica Prodotto</h1>
    <div id="container-img">
        <img id="image-src" src="${pageContext.request.contextPath}/img/login-ico.png">
        <div class="img-prev">
            <div id="imgDiv0" class="img-item">
                <img id="img0" src="${pageContext.request.contextPath}/img/login-ico.png">
                <span onclick="removeImg(this, 0)">&#10006;</span>
            </div>
            <div id="imgDiv1" class="img-item">
                <img id="img1" src="${pageContext.request.contextPath}/img/login-ico.png">
                <span onclick="removeImg(this, 1)">&#10006;</span>
            </div>
            <div id="imgDiv2" class="img-item">
                <img id="img2" src="${pageContext.request.contextPath}/img/login-ico.png">
                <span onclick="removeImg(this, 2)">&#10006;</span>
            </div>
            <div id="imgDiv3" class="img-item">
                <img id="img3" src="${pageContext.request.contextPath}/img/login-ico.png">
                <span onclick="removeImg(this, 3)">&#10006;</span>
            </div>
            <form action="Upload" method="post" enctype="multipart/form-data">
                <label for="file-upload" class="custom-file-upload">
                    <img src="${pageContext.request.contextPath}/img/plus-icon.jpg">
                </label>
                <input id="file-upload" type="file" accept="image/*"/>
            </form>
        </div>
        <button class="editImage" onclick="editImg()">Editing</button>
    </div>
    <div class="product-form">
        <div class="form-group"><label for="name">Nome:</label> <input type="text" id="name" value="${product.name}"
                                                                       disabled>
            <button onclick="enableEdit('name')">Modifica</button>
        </div>
        <div class="form-group"><label for="price">Prezzo:</label> <input type="text" id="price"
                                                                          value="${product.price}" disabled>
            <button onclick="enableEdit('price')">Modifica</button>
        </div>
        <div class="form-group"><label for="category">Categoria:</label> <input type="text" id="category"
                                                                                value="${product.categoria}" disabled>
            <button onclick="enableEdit('category')">Modifica</button>
        </div>
        <div class="form-group"><label for="nutrition">Alimentazione:</label> <input type="text" id="nutrition"
                                                                                     value="${product.alimentazione}"
                                                                                     disabled>
            <button onclick="enableEdit('nutrition')">Modifica</button>
        </div>
        <div class="form-group"><label for="description">Descrizione:</label> <textarea id="description" style="resize: none;" rows="5"
                                                                                        disabled>${product.description}</textarea>
            <button onclick="enableEdit('description')">Modifica</button>
        </div>
        <div class="form-actions">
            <button onclick="applyChanges()">Applica</button>
            <button onclick="deleteProduct()">Elimina Prodotto</button>
            <button onclick="window.close()">Chiudi</button>
        </div>
    </div>
</div>
</body>
<script defer>
    let isEditingImg = false;
    let removedPath = []; // lista delle immagini rimosse
    const fields = document.querySelectorAll('#name, #price, #category, #nutrition, #description');

    fields.forEach(field => {
        field.addEventListener('keydown', (e) => {
            if (e.key === 'Enter') {
                e.preventDefault(); // Evita che il tasto Invio invii il form
                disableAllFields();
            }
        });
    });

    function editImg() {
        let img_items = document.getElementsByClassName("img-item");

        for (let i = 0; i < img_items.length; ++i) {

            if (isEditingImg) {
                try {
                    img_items[i].getElementsByTagName("span")[0].classList.remove("hide");
                } catch (e) {}
                img_items[i].classList.add("vibrate");
            } else {
                try {
                    img_items[i].getElementsByTagName("span")[0].classList.add("hide");
                } catch (e) {}
                img_items[i].classList.remove("vibrate");
            }
        }

        isEditingImg = !isEditingImg;
    }

    editImg();

</script>
</html>
