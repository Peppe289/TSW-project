/**
 * This JavaScript file is responsible for dynamically loading
 * products to display on the home screen using AJAX.
 *
 * @module loadProducts
 */

/**
 * Adds a formatted product to the container on the page.
 *
 * @function addProduct
 * @param {Object} product - The product object to add.
 */
function addProduct(product) {
    let string = formatString(product);

    document.getElementById("parent-cont").innerHTML += string;
}

/**
 * Makes an AJAX request to get the products to display
 * on the home screen and adds them to the container.
 *
 * @function requestProducts
 * @exports requestProducts
 */
export function requestProducts() {
    const xhttp = new XMLHttpRequest();
    xhttp.onload = function () {
        let json = JSON.parse(this.responseText);
        for (let i = 0; i < json.length; i++) {
            addProduct(json[i]);
        }
    }
    xhttp.open("GET", "requestIndexProduct", true);
    xhttp.send();
}

/**
 * Creates the formatted HTML string to display a product.
 *
 * @function formatString
 * @param {Object} product - The product object to format.
 * @returns {string} The formatted HTML string.
 */
function formatString(product) {
    let contextPath = document.getElementById("PageContext").value;

    let string =
        "            <a href=\"p?product=?????id?????\" class=\"item\">\n" +
        "                <img class=\"bg-f4f5f5\" src=\"??? IMG ???\" loading=\"lazy\" alt='????ACCESSIBILITY????'" +
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

    let offPercentage =
        "                   <div class=\"off\">\n" +
        "                        <p>- ? %</p>\n" +
        "                    </div>\n";

    let off =
        "                                <p class=\"prezzo\">\n ? </p>\n" +
        "                                <s style=\"height: 100%; margin-top: 15px; padding: 0\"> ?? </s>\n";

    offPercentage = offPercentage.replace(" ? ", product.sconto);
    off = off.replace(" ?? ", product.sconto === 0 ? "" : (product.price.toFixed(2) + "€") )
    const price = product.sconto === 0 ? product.price : (product.price * (1 - (product.sconto / 100)));
    off = off.replace(" ? ", price.toFixed(2) + "€");
    string = string.replace("??? IMG ???", contextPath + product.photo_path[0]);
    console.log(contextPath + product.photo_path[0]);
    string = string.replace("????ACCESSIBILITY????", product.name);
    string = string.replace(" ??? ", product.sconto === 0 ? "" : offPercentage);
    string = string.replace(" ???? ", off);
    string = string.replace("?????description?????", product.description);
    string = string.replace("????name????", product.name);
    string = string.replace("?????id?????", product.id);

    return string;
}
