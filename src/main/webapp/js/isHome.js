function delay(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

function homeStyle(isHome) {
    const home_nav = document.getElementById("home_nav");
    if (isHome)
        home_nav.classList.add("curr-page");
}

export function isHomeCheck() {
    const url = window.location.pathname.indexOf("/product");

    homeStyle(url === -1);
}