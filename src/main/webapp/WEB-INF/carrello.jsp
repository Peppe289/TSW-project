<!DOCTYPE html>

<html lang="it">
<head>
    <title>Carrello</title>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link type="text/css" rel="stylesheet" href="../css/navbar.css">
    <link type="text/css" rel="stylesheet" href="../css/footer.css">
    <link type="text/css" rel="stylesheet" href="../css/carrello.css">
</head>

<body>
<%@ include file="include/navbar.jsp" %>

<div id="container">
    <div id="left-div">
        <div id="list">
            <div class="product">
                <label class="check">
                    <input type="checkbox">
                </label>
                <div class="image">
                    <img src="https://via.placeholder.com/150x150/00ff00/ffffff" alt="image" style="object-fit: contain">
                </div>
                <div class="description-container">
                    <div class="product-name description-items">
                        <h1>Ossa di Pterodatilo</h1>
                        <h1>30€</h1>
                    </div>
                    <div class="description description-items">
                        <p>Descrizione prodotto cosa a caso per vedere come va sicuramente molto bene ed è fantastico molto bello però ci sono cose che non vanno insomma sto prodotto in realtà fa schifo ma tu compralo lo stesso non si sa mai</p>
                    </div>
                    <div class="buttons red-button remove-button">
                        <div>
                            <label for="quantity">Quantità:</label>
                            <select id="quantity">
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                            </select>
                        </div>
                        <button>Rimuovi</button>
                    </div>
                </div>
            </div>
            <hr style="width: 90%; margin: 10px auto;">
            <div class="product">
                <label class="check">
                    <input type="checkbox">
                </label>
                <div class="image">
                    <img src="https://via.placeholder.com/150x150/00ff00/ffffff" alt="image">
                </div>
                <div class="description-container">
                    <div class="product-name description-items">
                        <h1>Nome Prodotto</h1>
                        <h1>30€</h1>
                    </div>
                    <div class="description description-items">
                        <p>Descrizione prodotto cosa a caso per vedere come va sicuramente molto bene ed è fantastico molto bello però ci sono cose che non vanno insomma sto prodotto in realtà fa schifo ma tu compralo lo stesso non si sa mai</p>
                    </div>
                    <div class="buttons red-button remove-button">
                        <div>
                            <label for="quantity">Quantità:</label>
                            <select id="quantity">
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                            </select>
                        </div>
                        <button>Rimuovi</button>
                    </div>
                </div>
            </div>
            <hr style="width: 90%; margin: 10px auto;">
        </div>
    </div>
    <div id="right-div">
        <div id="totalPrice">
            <b>Prezzo totale: 20€</b>
        </div>
        <div class="buttons green-button">
            <button style="">Procedi con l'ordine</button>
        </div>
    </div>
</div>

<%@ include file="include/footer.jsp" %>
</body>
</html>