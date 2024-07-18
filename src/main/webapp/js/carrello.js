document.addEventListener("DOMContentLoaded", function () {
    const listDiv = document.getElementById("list");
    const totalPriceDiv = document.getElementById("totalPrice");

    fetch("retrieve-cart")
        .then(response => response.json())
        .then(json => {
            if (Number(json[0].total) > 0) {
                let jkeysId = Object.keys(json[0]);
                let jkeysPrice = Object.keys(json[1]);
                let totalPrice = 0;

                jkeysId.forEach(jkeyId => {
                    if (jkeyId === "total" || jkeyId === "status")
                        return;
                    //console.log(json[0][jkeyId]);
                    const productDiv = document.createElement("div");
                    productDiv.classList.add("product");

                    const checkboxLabel = document.createElement("label");
                    checkboxLabel.classList.add("check");
                    const checkboxInput = document.createElement("input");
                    checkboxInput.type = "checkbox";
                    checkboxLabel.appendChild(checkboxInput);

                    const imageDiv = document.createElement("div");
                    imageDiv.classList.add("image");
                    const image = document.createElement("img");
                    image.src = "https://via.placeholder.com/150x150/00ff00/ffffff"; //TODO: inserire l'immagine
                    image.alt = "image";
                    image.style.objectFit = "contain";
                    imageDiv.appendChild(image);

                    const descriptionContainer = document.createElement("div");
                    descriptionContainer.classList.add("description-container");

                    const productNameDiv = document.createElement("div");
                    productNameDiv.classList.add("product-name", "description-items");
                    const productName = document.createElement("h1");
                    productName.textContent = json[4][jkeyId];
                    const productPrice = document.createElement("h1");
                    productPrice.textContent = `${json[1][jkeyId]}€`;
                    totalPrice += json[1][jkeyId] * json[0][jkeyId];

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
                    quantityLabel.appendChild(quantitySelect);
                    for (let i = 1; i <= Number(json[3][jkeyId]); i++) {
                        const option = document.createElement("option");
                        option.value = i.toString();
                        option.textContent = i.toString();
                        if (i === jkeyId.quantity) {
                            option.selected = true;
                        }
                        quantitySelect.appendChild(option);
                    }

                    let indexQuantity = quantitySelect.selectedIndex;
                    quantitySelect.addEventListener("change", () => {
                        fetch("carrello-add-ajax?id=" + jkeyId + "&add=" + quantitySelect.options[indexQuantity])
                            .then()
                    });

                    const removeButton = document.createElement("button");
                    removeButton.textContent = "Rimuovi";
                    removeButton.addEventListener("click", () => {
                        fetch("carrello-add-ajax?id=" + jkeyId + "&add=0")
                            .then(() => location.reload())
                    });

                    const hr = document.createElement('hr');
                    hr.style.width = '90%';
                    hr.style.margin = '10px auto';

                    buttonsDiv.appendChild(quantityLabel);
                    buttonsDiv.appendChild(quantitySelect);
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

                totalPriceDiv.querySelector("b").textContent = `Prezzo totale: ${totalPrice}€`;
            } else {
                const noProductsMessage = document.createElement("b");
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

