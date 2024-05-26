/**
 * Questo file js si occupa di caricare dinamicamente tramite
 * AJAX i prodotti da mostrare nella schermata home.
 *
 * @module productLoader
 */

/**
 * Aggiunge un prodotto formattato al contenitore nella pagina.
 *
 * @function addProduct
 * @param {Object} product - L'oggetto prodotto da aggiungere.
 */
function addProduct(product) {
    var string = formatString(product);

    document.getElementById("parent-cont").innerHTML += string;
}

/**
 * Effettua una richiesta AJAX per ottenere i prodotti da mostrare
 * nella schermata home e li aggiunge al contenitore.
 *
 * @function requestProducts
 * @exports requestProducts
 */
export function requestProducts() {
    const xhttp = new XMLHttpRequest();
    xhttp.onload = function () {
        var json = JSON.parse(this.responseText);
        for (var i = 0; i < json.length; i++) {
            addProduct(json[i]);
        }
    }
    xhttp.open("GET", "requestIndexProduct", true);
    xhttp.send();
}

/**
 * Crea la stringa formattata HTML per visualizzare un prodotto.
 *
 * @function formatString
 * @param {Object} product - L'oggetto prodotto da formattare.
 * @returns {string} La stringa HTML formattata.
 */
function formatString(product) {
    var string =
        "            <a href=\"p?product=?????id?????\" class=\"item\">\n" +
        "                <img class=\"bg-f4f5f5\" src=\"img/logo.png\" loading=\"lazy\"" +
        "                   onError=\"this.onerror=null; this.src='img/missing.jpg';\">\n" +
        " ??? " +
        "                <div class=\"item-desc\">\n" +
        "                    <p class=\"title-product\">????name????</p>\n" +
        "                    <p class=\"desc overtext\">\n" +
        "                            ?????description?????\n" +
        "                    </p>\n" +
        "                    <div style=\"display: flex; margin: 0; padding: 5px 0 0;\">\n" +
        " ???? " +
        "                    </div>\n" +
        "                </div>\n" +
        "            </a>\n";

    var offPercentage =
        "                   <div class=\"off\">\n" +
        "                        <p>- ? %</p>\n" +
        "                    </div>\n";

    var off =
        "                                <p class=\"prezzo\">\n ? </p>\n" +
        "                                <s style=\"height: 100%; margin-top: 15px; padding: 0\"> ?? </s>\n";

    offPercentage = offPercentage.replace(" ? ", product.sconto);
    off = off.replace(" ?? ", product.sconto === 0 ? "" : (product.price.toFixed(2) + "€") )
    const price = product.sconto === 0 ? product.price : (product.price * (1 - (product.sconto / 100)));
    off = off.replace(" ? ", price.toFixed(2) + "€");
    string = string.replace(" ??? ", product.sconto === 0 ? "" : offPercentage);
    string = string.replace(" ???? ", off);
    string = string.replace("?????description?????", product.description);
    string = string.replace("????name????", product.name);
    string = string.replace("?????id?????", product.id);

    return string;
}
