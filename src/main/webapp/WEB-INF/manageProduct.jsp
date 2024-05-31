<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<html>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard/dashboard.css">
    <title>Title</title>
</head>
<script src="${pageContext.request.contextPath}/js/productAdmin/productManage.js"></script>
<body>
<div class="containerpopup"><h1>Modifica Prodotto</h1>
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
    const fields = document.querySelectorAll('#name, #price, #category, #nutrition, #description');

    fields.forEach(field => {
        field.addEventListener('keydown', (e) => {
            if (e.key === 'Enter') {
                e.preventDefault(); // Evita che il tasto Invio invii il form
                disableAllFields();
            }
        });
    });
</script>
</html>
