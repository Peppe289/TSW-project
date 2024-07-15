document.addEventListener("DOMContentLoaded", function () {
    const listDiv = document.getElementById("list");
    const totalPriceDiv = document.getElementById("totalPrice");

    fetch("/retrieve-cart")
        .then(response => response.json())
        .then(json => {
            if (json.elements && json.elements.length > 0) {
                let totalPrice = 0;

                json.elements.forEach(product => {
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
                    productName.textContent = product.name;
                    const productPrice = document.createElement("h1");
                    productPrice.textContent = `${product.price}€`;
                    productNameDiv.appendChild(productName);
                    productNameDiv.appendChild(productPrice);

                    const descriptionDiv = document.createElement("div");
                    descriptionDiv.classList.add("description", "description-items");
                    const description = document.createElement("p");
                    description.textContent = product.description;
                    descriptionDiv.appendChild(description);

                    const buttonsDiv = document.createElement("div");
                    buttonsDiv.classList.add("buttons", "red-button", "remove-button");
                    const quantityLabel = document.createElement("label");
                    quantityLabel.setAttribute("for", "quantity");
                    quantityLabel.textContent = "Quantità:";
                    const quantitySelect = document.createElement("select");
                    quantitySelect.id = "quantity";
                    [1, 2, 3].forEach(value => { //TODO: Inserire la quantià e le varie opzioni
                        const option = document.createElement("option");
                        option.value = value;
                        option.textContent = value;
                        if (value === product.quantity) {
                            option.selected = true;
                        }
                        quantitySelect.appendChild(option);
                    });
                    const removeButton = document.createElement("button");
                    removeButton.textContent = "Rimuovi";
                    removeButton.addEventListener("click", () => {
                        // Logica per rimuovere il prodotto dal carrello
                    });
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

                    totalPrice += product.price * product.quantity;
                });

                totalPriceDiv.querySelector("b").textContent = `Prezzo totale: ${totalPrice}€`; //TODO: mettere il prezzo totale
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

