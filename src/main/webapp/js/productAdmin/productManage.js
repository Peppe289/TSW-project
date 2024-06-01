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
        console.log(src);
        fetch(src)
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.blob();
            })
            .then(blob => {
                const formData = new FormData();
                formData.append('image', blob, 'image.jpg'); // Append the Blob with a filename

                return fetch('http://localhost:8080/dinosauri_war_exploded/uploadimg', {
                    method: 'POST',
                    body: formData
                });
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
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
