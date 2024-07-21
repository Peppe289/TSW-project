let inputNut = document.getElementsByName("nut");
let inputCat = document.getElementsByName("cat");
let nut_title = document.getElementById("nut-title");
let nut_title_show_boolean = true;
//Array che conterrà solo le categorie che mi interessano
let arr_cat_utils = [];
let extrafilter = document.getElementsByClassName("extra-filter");

//Inserimento di sole le categorie che mi interessano
Array.from(inputCat).forEach(element => {
    Array.from(extrafilter).forEach((el) =>{
        if(element.id === el.value) arr_cat_utils.push(element)
    });
});

//Funzione che fa sparire il filtro di alimentazione
function nut_invisible() {
    nut_title_show_boolean = false;
    show_nut_on_resize(window);
    Array.from(inputNut).forEach(element => {
        element.parentElement.style.display = "none";
    });
}

arr_cat_utils.forEach(input_el => {
    input_el.addEventListener("change", () => {
        /**
         * Mi serve per sapere se almeno uno è checkato
         * in questo modo se deseleziono uno ma l'altro è ancora checkato
         * il filtro "alimentazione" rimane visibile
         */
        arr_cat_utils.every(element => {
            /**
             * Se almeno uno è checkato allora il filtro Alimentazione compare/rimane.
             * Altrimenti scompare.
             */
            if (element.checked) {
                inputNut.forEach(el => {
                    nut_title_show_boolean = true;
                    el.parentElement.style.display = "block";
                    show_nut_on_resize(window);
                });
                return false;
            } else nut_invisible();

            return true;
        });
    });
});

/* show/hide title nutrition. */
function show_nut_on_resize(element) {
    if (element.innerWidth > 900 && nut_title_show_boolean) {
        nut_title.style.display = "block";
    } else {
        nut_title.style.display = "none";
    }
}

/* event listener on resize of page. */
window.addEventListener("resize", (event) => {
    show_nut_on_resize(event.target);
});

//mi prendo l'URL
const params = new URLSearchParams(document.location.search);

//prendo tutti i parametri che mi interessano e li metto in un array
let arr_cat = params.getAll("cat");
let arr_nut = params.getAll("nut");
let order_filter = params.get("sort");

/* restore old order sort. */
function loadDefaultSelectedSort() {
    const orderElements = document.getElementById("order_filter");
    if (!(order_filter === null || order_filter === "")) {
        orderElements.value = order_filter;
    }
}
loadDefaultSelectedSort();

//prendo gli elementi che mi interessano
let form = document.getElementById("filter-form");
let inp_elements = form.getElementsByTagName("input");

//scorro gli elementi
Array.from(inp_elements).forEach(element => {
    if (element.name === "cat") {
        //scorro i cat presenti nell'array di cat
        arr_cat.forEach(string => {
            if (string === element.value) {
                element.checked = true;
            }
        });
    } else {
        //scorro i nut presenti nell'array di nut
        arr_nut.forEach(string => {
            if (string === element.value) {
                element.checked = true;
                nut_title_show_boolean = true;
                show_nut_on_resize(window);
            }
        })
    }
});

/**
 * If none of arr_cat_utils elements are checked, we can hide the other filter input.
 * Check this after checked element from url.
 */
if (!arr_cat_utils.some(element => element.checked)) {
    nut_title_show_boolean = false;
    nut_invisible();
}

/* check if default nutrition title if necessary or not. */
show_nut_on_resize(window);
