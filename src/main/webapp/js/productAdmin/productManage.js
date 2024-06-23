function enableEdit(fieldId) {
    const field = document.getElementById(fieldId);
    field.disabled = false;
    field.focus();
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

        console.log(src);
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
                console.log('Success:', data);
            })
            .catch(error => {
                console.error('Error:', error);
            });
    }

}

function deleteProduct() {
    // Logica per eliminare il prodotto
    alert('Prodotto eliminato');
}

function disableAllFields() {
    const fields = document.querySelectorAll('#name, #price, #category, #nutrition, #description');
    fields.forEach(field => field.disabled = true);
}
