var isOpen = false;
var navBarStyle = document.getElementById("navbar").style;

function openNav() {

    if (!isOpen) {
        navBarStyle.left = "0";
    } else {
        navBarStyle.left = "-260px";
    }

    isOpen = !isOpen;
}
