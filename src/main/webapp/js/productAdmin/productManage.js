/**
 * This module is responsible for manage user request to the server.
 *
 * @module productManage
 */

/**
 * Import notify script for show Toast popup
 */
import {notifyUserModule} from '../ToastAPI.js';

let isEditingImg = false;
let removedPath = [];
const fields = document.querySelectorAll('#name, #price, #category, #nutrition, #quantity, #description');
/* element contains id for new product. */
let new_prod_id = document.getElementById("id_prod");
let wrong_ID = false;

/* Register callback for first time for img */
register_callback_preview_image(document.getElementById("img-prev"));
/* At load whe need to hide delete button from img */
editImg();
/* See function comment */
default_zoom_preview();

fields.forEach(field => {
    field.addEventListener('keydown', (e) => {
        if (e.key === 'Enter') {
            e.preventDefault(); // Evita che il tasto Invio invii il form
            disableAllFields();
        }
    });
    /**
     * <div class="form-group"><label for="name">Nome:</label>
     *      <input type="text" id="name" value="${product.name}" disabled>
     *      <button onclick="enableEdit('name')">Modifica</button>
     * </div>
     *
     * In this way whe can add action listner to button from input.
     */
    const button = field.parentElement.getElementsByTagName("button")[0];
    button.addEventListener("click", () => {
        /* disable input. */
        field.disabled = false;
        field.focus();
    });
});

/**
 * Make ajax request for seeing if ID already took.
 * Make ajax request at all keydown with time out.
 */
function verify_new_id() {
    /* ajax request for generate ID for new product. */
    let xhr = new XMLHttpRequest();
    let string = document.getElementById("id_prod").value;
    xhr.open("GET", "edit-prod-request?o=new_id&id=" + string, true);
    xhr.onreadystatechange = function () {
        if (this.readyState === 4 && this.status === 200) {
            /* check if id is already present. */
            let result = JSON.parse(this.responseText);
            wrong_ID = result["status"] !== "ok";
            if (wrong_ID) {
                new_prod_id.classList.add('custom-outline');
            } else {
                while(new_prod_id.classList.contains("custom-outline")) {
                    new_prod_id.classList.remove("custom-outline");
                }
            }
        }
    };
    xhr.send();
}

/* if this button is present means we need to add new product. make request to server to check if ID already exists. */
if (new_prod_id != null && new_prod_id.classList.contains("newProd") === true) {

    document.addEventListener('DOMContentLoaded', (event) => {
        const inputElement = new_prod_id

        inputElement.addEventListener('focus', () => {
            if (wrong_ID) {
                inputElement.classList.add('custom-outline');
            }
        });

        inputElement.addEventListener('blur', () => {
            if (!wrong_ID) {
                try {
                    while (inputElement.classList.contains("custom-outline"))
                        inputElement.classList.remove('custom-outline');
                } catch (e) {
                }
            }
        });
    });

    new_prod_id.addEventListener("keydown", () => {
        setTimeout(verify_new_id, 1000);
    });
}


document.getElementById("applica-btn").addEventListener("click", () => {
    /* disable all fields mean confirm changes from js. */
    disableAllFields();
    /* Use fetch for request about upload img. */
    uploadimg_ajax();
    /* Use fetch for request about delete img. */
    deleteimg_ajax();
    /* After image update reload default side preview */
    default_zoom_preview();
    /* Send request with custom name, price, category ... */
    update_database_ajax();
});

/**
 * Button for edit image list.
 */
document.getElementById("container-img").getElementsByTagName("button")[0].addEventListener("click", () => {
    editImg();
});

/**
 * Manage the new entry image. Print as preview to html and add EventListner using register_callback_preview_image().
 */
document.getElementById('file-upload').addEventListener('change', function (event) {
    let file = event.target.files[0];

    if (file && file.type.startsWith('image/')) {
        let reader = new FileReader();

        reader.onload = function (e) {
            const container = document.getElementById("img-prev");
            let imgElement = createImgItem(e.target.result);
            container.prepend(imgElement);
            register_callback_preview_image(container);
        };

        reader.readAsDataURL(file);
    } else {
        alert("Il file selezionato non è un'immagine.");
    }
});

/*************************** UTILS ***************************/

/**
 * 1) Server request
 */

/**
 * Update database for this product. This fetch text from input text.
 */
function update_database_ajax() {
    const id = document.getElementById("id_prod").value;

    const name = document.getElementById("name");
    const price = document.getElementById("price");
    const category = document.getElementById("category");
    const nutrition = document.getElementById("nutrition");
    const quantity = document.getElementById("quantity");
    const description = document.getElementById("description");
    const new_prod = document.getElementById("new_prod");
    const obj = {
        new_prod: new_prod.value,
        name: name.value,
        price: price.value,
        category: category.value,
        nutrition: nutrition.value,
        quantity: quantity.value,
        description: description.value
    };
    let json = JSON.stringify(obj);
    fetch("edit-prod-request?id=" + id + "&o=update_database", {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        }, body: json
    })
        .then(/* Take response json */response => response.json())
        .then(data => {
            /* Notify to client result of server using json. */
            if (data == null) {
                notifyUserModule("Error", "");
            } else {
                notifyUserModule("Dati Aggiornati", "Dati aggiornati con successo.");
            }
            reloadInputValue(data);
        }).catch(error => {
        console.error('Error:', error);
    });
}

/**
 * This function is used for delete image.
 * no param is required.
 *
 * @function applyChanges - only this call this function.
 * @function fetch - used for request.
 */
function deleteimg_ajax() {
    const id = document.getElementById("id_prod").value;

    if (removedPath.length === 0) return;

    /**
     * Remove locally image. Whe skip to delete this because not we skip this upload
     * (maybe already delete locally).
     *
     * (deformazione professionale: o stanno sul server o non stanno. noi aggiorniamo ogni volta bruh).
     *
     * @type {*[]} - return array
     */
    removedPath = removedPath.filter(function (item) {
        return !item.includes("data:image/");
    });

    fetch("edit-prod-request?id=" + id + "&o=remove", {
        method: 'POST', headers: {
            'Content-Type': 'application/json',
        }, body: JSON.stringify(removedPath),
    })
        .then(/* Take response json */response => response.json())
        .then(data => {
            /* Notify to client result of server using json. */
            let status = data["status"];
            if (status.indexOf("success") < 0) {
                notifyUserModule("Error", status);
            } else {
                notifyUserModule("Immagine rimossa", "immagine rimossa con successo.");
            }

            reloadImgItem(data);
        }).catch(error => {
        console.error('Error:', error);
    });

    // clean up removed img list
    removedPath = [];
}

/**
 * This function is used for upload to server new image.
 * no param is required.
 *
 * @function applyChanges - only this call this function.
 * @function fetch - used for upload.
 */
function uploadimg_ajax() {
    const uploadImg = document.getElementsByClassName("img-item");
    for (let i = 0; i < uploadImg.length; ++i) {
        let src = uploadImg[i].getElementsByTagName("img")[0].src;

        /**
         * Se questa sotto stringa non è presente allora è stata presa dal server l'immagine.
         * Non caricarla di nuovo sul server.
         */
        if (!src.includes("data:image/")) {
            continue;
        } else if (removedPath.length > 0) {
            /**
             * here we know src contain data:image payload.
             * The user can remove the newly added image.
             */
            let skip = false;
            removedPath.forEach(path => {
                if (path.includes(src)) {
                    skip = true;
                }
            });
            if (skip) continue;
        }

        /* This first fetch needed for convert image to binary and make another fetch to server. */
        fetch(src)
            .then(response => {
                /* Take binary of image. Need for manage image */
                return response.blob();
            })
            .then(blob => {
                /* after get binary prepare for send. */
                const formData = new FormData();
                formData.append('image', blob, 'image.jpg'); // Append the Blob with a filename
                const id = document.getElementById("id_prod").value;
                /* send data */
                return fetch('http://localhost:8080/dinosauri_war_exploded/edit-prod-request?id=' + id + "&o=upload", {
                    method: 'POST', body: formData
                });
            })
            .then(response => {
                /**
                 * From return take json. This can say if result goes well or not.
                 * If the operation went well, the entire list of images is returned in the json.
                 */
                return response.json();
            })
            .then(data => {
                /* Notify to client result of server using json. */
                let status = data["status"];
                if (status.indexOf("success") < 0) {
                    notifyUserModule("Error", status);
                } else {
                    notifyUserModule("Immagine caricata", "immagine caricata con successo.");
                }

                /* reload img item after ajax request. */
                reloadImgItem(data);
            })
            .catch(error => {
                console.error('Error:', error);
            });
    }
}

/**
 * 2) utils for html
 */

function reloadInputValue(json) {
    document.getElementById("name").value = json["name"];
    document.getElementById("price").value = json["price"];
    document.getElementById("category").value = json["categoria"];
    document.getElementById("nutrition").value = json["alimentazione"];
    document.getElementById("quantity").value = json["quantity"];
    document.getElementById("description").value = json["description"];
}

/**
 * This function is used for update image after change.
 * Remove all element and create new from json.
 *
 * @param data - json object from result of ajax request.
 */
function reloadImgItem(data) {
    /* We can remove older preview of image and replace with server image. */
    let old = document.getElementById("img-prev").getElementsByTagName("div");
    while (old.length !== 0) old[0].remove();

    /* Load new image preview from server using json list */
    let src_arr = Array.from(data["path"]);
    let container = document.getElementById("img-prev");
    src_arr.forEach(src => container.prepend(createImgItem("http://localhost:8080/dinosauri_war_exploded/" + src)));
    register_callback_preview_image(container);
}

/**
 * Function for create new div element for image preview
 *
 * @param src - source of image.
 * @returns {HTMLDivElement} - element to append
 */
function createImgItem(src) {
    /* create item container */
    let imgItem = document.createElement('div');
    imgItem.classList.add('img-item');

    /* create image element for preview */
    let img = document.createElement('img');
    img.src = src;

    /* create span element for delete action */
    let span = document.createElement('span');
    span.innerHTML = '&#10006;';
    span.classList.add("hide");

    /* compose item for show image and add span for remove button */
    imgItem.appendChild(img);
    imgItem.appendChild(span);

    return imgItem;
}

/**
 * This added dynamically ActionListner.
 * Use callback function to register action on click.
 * Need for button on preview image.
 *
 * @param element - array of element
 * @param callback - callback function
 */
function addActionListnerArr(element, callback) {
    Array.from(element).forEach(function (el) {
        el.addEventListener("click", function () {
            callback(el);
        });
    });
}

/**
 * This function need for add actionlistner to preview image.
 *
 * @param container
 */
function register_callback_preview_image(container) {
    /* add callback function for new image added */
    addActionListnerArr(container.getElementsByTagName("span"), /* function for delete image. */
        function (el) {
            const parent = el.parentNode;
            const img = parent.getElementsByTagName("img")[0];
            // save path to remove from server.
            removedPath.push(img.src);
            parent.classList.add("hide");
        });
    addActionListnerArr(container.getElementsByTagName("img"), /* function to change big side view */
        function (el) {
            let img = document.getElementById("image-src");
            img.src = el.src;
        });
}

/**
 * Disable all fields about active input.
 *
 * @function applyChanges - Invoked from this for confirm changes.
 */
function disableAllFields() {
    fields.forEach(field => field.disabled = true);
}

/**
 * Action for enable editable image list.
 * This can show span with "x" content for remove specify image.
 */
function editImg() {
    let img_items = document.getElementsByClassName("img-item");

    for (let i = 0; i < img_items.length; ++i) {
        let items_span = img_items[i].getElementsByTagName("span")[0];

        if (isEditingImg) {
            // Remove all instances of the 'hide' class
            while (items_span.classList.contains("hide")) {
                items_span.classList.remove("hide");
            }

            // Add the 'vibrate' class if it doesn't already exist
            if (!img_items[i].classList.contains("vibrate")) {
                img_items[i].classList.add("vibrate");
            }
        } else {
            // Remove the 'vibrate' class if it exists
            while (img_items[i].classList.contains("vibrate")) {
                img_items[i].classList.remove("vibrate");
            }

            // Add the 'hide' class if it doesn't already exist
            if (!items_span.classList.contains("hide")) {
                items_span.classList.add("hide");
            }
        }
    }

    // Toggle the editing state
    isEditingImg = !isEditingImg;
}

/**
 * Just used for choose default image (first image) as side preview.
 */
function default_zoom_preview() {
    /* carica di default la prima immagine dalla lista della preview */
    try {
        document.getElementById("image-src").src = document.getElementsByClassName("img-item")[0].getElementsByTagName("img")[0].src;
    } catch (e) {
        document.getElementById("image-src").src = "img/missing.jpg"
    }
}

/*************************************************************/
