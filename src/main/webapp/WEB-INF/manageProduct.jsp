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

        & #img-prev {
            width: 100%;
            gap: 10px;
            object-fit: cover;
            display: flex;
            flex-wrap: wrap;

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
<script src="${pageContext.request.contextPath}/js/productAdmin/productManage.js"></script>
<body>
<div class="containerpopup">
    <p style="display: none" id="id-product">${product.id}</p>
    <h1>Modifica Prodotto</h1>
    <div id="container-img">
        <img id="image-src">
        <div id="img-prev">
            <c:forEach items="${product.photo_path}" var="photo">
                <div class="img-item">
                    <img src="${pageContext.request.contextPath}${photo}" onclick="changeit(this.src, this)">
                    <span onclick="removeImg(this)">&#10006;</span>
                </div>
            </c:forEach>
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
        <div class="form-group"><label for="description">Descrizione:</label> <textarea id="description"
                                                                                        style="resize: none;" rows="5"
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

    /* carica di default la prima immagine dalla lista della preview */
    document.getElementById("image-src").src = document.getElementsByClassName("img-item")[0].getElementsByTagName("img")[0].src;

    /* funzinoe per cambiare immagine dalla preview */
    function changeit(path, el) {
        var img = document.getElementById("image-src");
        img.src = path;
    }

    function editImg() {
        let img_items = document.getElementsByClassName("img-item");

        for (let i = 0; i < img_items.length; ++i) {
            if (isEditingImg) {
                try {
                    img_items[i].getElementsByTagName("span")[0].classList.remove("hide");
                } catch (e) {
                }
                img_items[i].classList.add("vibrate");
            } else {
                try {
                    img_items[i].getElementsByTagName("span")[0].classList.add("hide");
                } catch (e) {
                }
                img_items[i].classList.remove("vibrate");
            }
        }

        isEditingImg = !isEditingImg;
    }

    editImg();

    function removeImg(element) {
        const parent = element.parentNode;
        const img = parent.getElementsByTagName("img")[0];
        const imgpath = img.src;
        console.log(imgpath);
        parent.classList.add("hide");
    }

    // Funzione per creare un nuovo elemento div con un'immagine e un pulsante di rimozione
    function createImgItem(e) {
        // Creare l'elemento div
        let imgItem = document.createElement('div');
        imgItem.classList.add('img-item');

        // Creare l'elemento img
        let img = document.createElement('img');
        img.src = e.target.result;

        // Creare l'elemento span
        let span = document.createElement('span');
        span.innerHTML = '&#10006;';
        span.onclick = function () {
            removeImg(this);
        };

        // Aggiungere img e span a imgItem
        imgItem.appendChild(img);
        imgItem.appendChild(span);

        return imgItem;
    }

    document.getElementById('file-upload').addEventListener('change', function (event) {
        let file = event.target.files[0];

        if (file && file.type.startsWith('image/')) {
            let reader = new FileReader();

            reader.onload = function (e) {
                const container = document.getElementById("img-prev");
                let imgElement = createImgItem(e);
                container.prepend(imgElement);
            };

            reader.readAsDataURL(file);
        } else {
            alert("Il file selezionato non è un'immagine.");
        }
    });

</script>
</html>
