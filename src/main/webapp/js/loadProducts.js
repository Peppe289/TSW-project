/**
 * Questo file js si occupa di caricare dinamicamente tramite
 * ajax i prodotti da mostrare nella schermata home.
 *
 * @requestProducts: si occupa di fare la richiesta ajax
 * @formatString: si occupa di crare la formattazione corretta per mostrare il prodotto
 * @addProduct: si occupa di aggiungere l'elemento formattato nel div.
 */
function addProduct(product) {
    var string = formatString(product);

    document.getElementById("parent-cont").innerHTML += string;
}

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

function formatString(product) {
    var string =
        "            <a href=\"p?product=?????id?????\" class=\"item\">\n" +
        "                <img class=\"bg-f4f5f5\" src=\"https://via.placeholder.com/600x200/00ff00/ffffff\"" +
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
    off = off.replace(" ?? ", product.sconto === 0 ? "" : product.price)
    off = off.replace(" ? ", product.sconto === 0 ? product.price : product.price * (1 - (product.sconto / 100)));
    string = string.replace(" ??? ", product.sconto === 0 ? "" : offPercentage);
    string = string.replace(" ???? ", off);
    string = string.replace("?????description?????", product.description);
    string = string.replace("????name????", product.name);
    string = string.replace("?????id?????", product.id);

    return string;
}