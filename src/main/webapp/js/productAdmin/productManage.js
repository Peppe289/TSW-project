/**
 * This module is responsible for manage user request to the server.
 *
 * @module productManage
 */

/**
 * Import notify script for show Toast popup
 *
 * @
 */
import {notifyUserModule} from '../ToastAPI.js';

let isEditingImg = false;
let removedPath = []; // lista delle immagini rimosse
const fields = document.querySelectorAll('#name, #price, #category, #nutrition, #description');

document.getElementById("applica-btn").addEventListener("click", e => applyChanges());

function enableEdit(fieldId) {
    const field = document.getElementById(fieldId);
    field.disabled = false;
    field.focus();
}

fields.forEach(field => {
    field.addEventListener('keydown', (e) => {
        if (e.key === 'Enter') {
            e.preventDefault(); // Evita che il tasto Invio invii il form
            disableAllFields();
        }
    });
});

/* carica di default la prima immagine dalla lista della preview */
try {
    document.getElementById("image-src").src = document.getElementsByClassName("img-item")[0].getElementsByTagName("img")[0].src;
} catch (e) {
    document.getElementById("image-src").src = "img/missing.jpg"
}
/* funzinoe per cambiare immagine dalla preview */
function changeit(path, el) {
    let img = document.getElementById("image-src");
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

document.getElementById('file-upload').addEventListener('change', function (event) {
    let file = event.target.files[0];

    if (file && file.type.startsWith('image/')) {
        let reader = new FileReader();

        reader.onload = function (e) {
            const container = document.getElementById("img-prev");
            let imgElement = createImgItem(e.target.result);
            container.prepend(imgElement);
        };

        reader.readAsDataURL(file);
    } else {
        alert("Il file selezionato non è un'immagine.");
    }
});

// Funzione per creare un nuovo elemento div con un'immagine e un pulsante di rimozione
function createImgItem(src) {
    // Creare l'elemento div
    let imgItem = document.createElement('div');
    imgItem.classList.add('img-item');

    // Creare l'elemento img
    let img = document.createElement('img');
    img.src = src;

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

function applyChanges() {
    // Logica per applicare le modifiche
    //alert('Modifiche applicate');
    disableAllFields();
    const uploadImg = document.getElementsByClassName("img-item");
    for (let i = 0; i < uploadImg.length; ++i){
        let src = uploadImg[i].getElementsByTagName("img")[0].src;

        /**
         * Se questa sotto stringa non è presente allora è stata presa dal server l'immagine.
         * Non caricarla di nuovo sul server.
         */
        if (!src.includes("data:image/"))
            continue;

        fetch(src)
            .then(response => {
                return response.blob();
            })
            .then(blob => {
                const formData = new FormData();
                formData.append('image', blob, 'image.jpg'); // Append the Blob with a filename
                const id = document.getElementById("id-product").innerHTML;
                return fetch('http://localhost:8080/dinosauri_war_exploded/uploadimg?id=' + id, {
                    method: 'POST',
                    body: formData
                });
            })
            .then(response => {
                return response.json();
            })
            .then(data => {
                let status = data["status"];
                if (status.indexOf("success") < 0) {
                    notifyUserModule("Error", status);
                } else {
                    notifyUserModule("Immagine caricata", "immagine caricata con successo");
                }

                /* We can remove older preview of image and replace with server image. */
                let old = document.getElementById("img-prev").getElementsByTagName("div");
                while (old.length !== 0) {
                    old[0].remove();
                }

                /* load new image preview from server using json list */
                let src_arr = data["path"];
                src_arr.forEach(src =>
                    document.getElementById("img-prev")
                        .prepend(createImgItem("http://localhost:8080/dinosauri_war_exploded/" + src)
                        )
                );

            })
            .catch(error => {
                console.error('Error:', error);
            });
    }
}

/**
 * TODO: not implemented yet
 */
function deleteProduct() {
    // Logica per eliminare il prodotto
    alert('Prodotto eliminato');
}

function disableAllFields() {
    const fields = document.querySelectorAll('#name, #price, #category, #nutrition, #description');
    fields.forEach(field => field.disabled = true);
}
