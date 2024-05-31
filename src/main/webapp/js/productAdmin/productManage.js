function enableEdit(fieldId) {
    const field = document.getElementById(fieldId);
    field.disabled = false;
    field.focus();
}

function applyChanges() {
    // Logica per applicare le modifiche
    alert('Modifiche applicate');
    disableAllFields();
}

function deleteProduct() {
    // Logica per eliminare il prodotto
    alert('Prodotto eliminato');
}

function disableAllFields() {
    const fields = document.querySelectorAll('#name, #price, #category, #nutrition, #description');
    fields.forEach(field => field.disabled = true);
}
