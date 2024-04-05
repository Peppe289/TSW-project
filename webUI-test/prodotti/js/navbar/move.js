var isOpen = false;
var navBarStyle = document.getElementById("navbar").style;

function openNav() {

    if (!isOpen) {
        navBarStyle.left = "0";
        // aggiungi l'ombra che è figa
        navBarStyle.boxShadow = "0 0 15px rgba(0, 0, 0, 0.5)";
    } else {
        navBarStyle.left = "-250px";
        // Rimuovi l'ombra, altrimenti si vede di lato 
        navBarStyle.boxShadow = "";
    }

    isOpen = !isOpen;
}
