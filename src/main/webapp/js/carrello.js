/* retrieve from hidden input in the HTML the context path */
let contextPath = document.getElementById("contextPath").value;

document.addEventListener("DOMContentLoaded", function () {
    const listDiv = document.getElementById("list");
    const totalPriceDiv = document.getElementById("totalPrice");

    fetch("retrieve-cart")
        .then(response => response.json())
        .then(json => {
            if (Number(json[0].total) > 0) {
                let jkeysId = Object.keys(json[0]);
                let totalPrice = 0;

                jkeysId.forEach(jkeyId => {
                    if (jkeyId === "total" || jkeyId === "status")
                        return;

                    if (json[0][jkeyId] === "0")
                        return;

                    const productDiv = document.createElement("div");
                    productDiv.classList.add("product");

                    const checkboxLabel = document.createElement("label");
                    checkboxLabel.classList.add("check");
                    checkboxLabel.ariaLabel = "checkbox";
                    const checkboxInput = document.createElement("input");
                    checkboxInput.type = "checkbox";
                    checkboxInput.id = jkeyId;
                    checkboxInput.checked = true;

                    checkboxInput.addEventListener("change", () => {
                        let recalc = 0;
                        let allcheck = document.getElementsByTagName("input");

                        Array.from(allcheck).forEach(element => {
                            if (element.type.toString().toUpperCase() === "CHECKBOX") {
                                if (element.checked === true && Number(json[3][element.id]) > 0) {
                                    recalc += json[0][element.id] * json[1][element.id];
                                }
                            }
                        })

                        totalPriceDiv.querySelector("b").textContent = `Prezzo totale: ${parseFloat(recalc).toFixed(2)}€`
                    });

                    checkboxLabel.appendChild(checkboxInput);

                    const imageDiv = document.createElement("div");
                    imageDiv.classList.add("image");
                    const image = document.createElement("img");

                    if (typeof json[5][jkeyId] === "undefined")
                        image.src = "img/missing.jpg";
                    else
                        image.src = json[5][jkeyId].replace("/", "");

                    image.alt = "image";
                    imageDiv.appendChild(image);

                    const descriptionContainer = document.createElement("div");
                    descriptionContainer.classList.add("description-container");

                    const productNameDiv = document.createElement("div");
                    productNameDiv.classList.add("product-name", "description-items");
                    const productName = document.createElement("h1");
                    productName.textContent = json[4][jkeyId];
                    const productPrice = document.createElement("h1");
                    const price = parseFloat(json[1][jkeyId]).toFixed(2);
                    if (Number(json[3][jkeyId]) > 0) {
                        productPrice.textContent = (price * json[0][jkeyId]).toFixed(2) + "€";
                        totalPrice += json[1][jkeyId] * json[0][jkeyId];
                    } else {
                        productPrice.textContent = "";
                    }
                    productNameDiv.appendChild(productName);
                    productNameDiv.appendChild(productPrice);

                    const descriptionDiv = document.createElement("div");
                    descriptionDiv.classList.add("description", "description-items");
                    const description = document.createElement("p");
                    description.textContent = json[2][jkeyId];
                    descriptionDiv.appendChild(description);

                    const buttonsDiv = document.createElement("div");
                    buttonsDiv.classList.add("buttons", "red-button", "remove-button");
                    const quantityLabel = document.createElement("label");
                    quantityLabel.textContent = "Quantità:";
                    const quantitySelect = document.createElement("select");
                    quantitySelect.name = "quantity";
                    quantitySelect.id = jkeyId;
                    quantityLabel.appendChild(quantitySelect);
                    if (Number(json[3][jkeyId]) > 0) {
                        for (let i = 1; i <= Number(json[3][jkeyId]); i++) {
                            const option = document.createElement("option");
                            option.value = i.toString();
                            option.textContent = i.toString();
                            if (i === Number(json[0][jkeyId])) {
                                option.selected = true;
                            }
                            quantitySelect.appendChild(option);
                        }
                    } else {
                        quantityLabel.innerHTML = "Prodotto non più disponibile";
                    }

                    quantitySelect.addEventListener("change", (event) => {
                        if (!(quantitySelect.value > 0 && quantitySelect.value <= Number(json[3][event.target.id]))) {
                            console.log("Invalid select " + quantitySelect.value + " - " + json[3][event.target.id]);
                            return;
                        }

                        fetch("carrello-add-ajax?id=" + jkeyId + "&add=" + quantitySelect.value)
                            .then(() => {
                            location.reload();
                        }).catch(e => console.log(e));
                    });

                    const removeButton = document.createElement("button");
                    removeButton.textContent = "Rimuovi";
                    removeButton.addEventListener("click", () => {
                        if (!confirm("Vuoi davvero rimuovere " + json[4][jkeyId] + " dal carrello?"))
                            return;

                        fetch("carrello-add-ajax?id=" + jkeyId + "&add=0")
                            .then(() => location.reload())
                    });

                    const hr = document.createElement('hr');
                    hr.style.width = '90%';
                    hr.style.margin = '10px auto';

                    buttonsDiv.appendChild(quantityLabel);
                    buttonsDiv.appendChild(removeButton);

                    descriptionContainer.appendChild(productNameDiv);
                    descriptionContainer.appendChild(descriptionDiv);
                    descriptionContainer.appendChild(buttonsDiv);

                    productDiv.appendChild(checkboxLabel);
                    productDiv.appendChild(imageDiv);
                    productDiv.appendChild(descriptionContainer);

                    listDiv.appendChild(productDiv);
                    listDiv.appendChild(hr);
                });

                totalPriceDiv.querySelector("b").textContent = `Prezzo totale: ${parseFloat(totalPrice).toFixed(2)}€`;
            } else {
                const noProductsMessage = document.createElement("b");
                document.getElementById("right-div").style.display = "none";
                noProductsMessage.textContent = "Non ci sono prodotti";
                listDiv.appendChild(noProductsMessage);
            }
        })
        .catch(error => {
            console.error('Error fetching the cart data:', error);
            const errorMessage = document.createElement("p");
            errorMessage.textContent = "Errore nel recupero dei dati del carrello.";
            listDiv.appendChild(errorMessage);
        });
});


/* send using js parameter in post with checked product. */
document.getElementById("btn_submit").addEventListener("click", (event) => {
    const input = document.getElementsByTagName("input");
    let url= `${contextPath}/compra?`;

    Array.from(input).forEach(item => {
        if (item.type.toUpperCase() === "CHECKBOX") {
            if (item.checked) {
                url += "el=" + item.id + "&";
            }
        }
    });

    location.href = url;
})

