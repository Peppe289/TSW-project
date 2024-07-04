let arr_nutr = document.getElementsByName("nut");
let arr_cate = document.getElementsByName("cat");
let nut_title = document.getElementById("nut-title");
//Array che conterrà solo le categorie che mi interessano
let arr_cat_utils = [];

//Inserimento di sole le categorie che mi interessano
Array.from(arr_cate).forEach(element => {
    if (element.id === "terra" || element.id === "acqua" || element.id === "aria") {
        arr_cat_utils.push(element);
    }
});

//Funzione che fa sparire il filtro di alimentazione
function nut_invisible() {
    nut_title.style.display = "none";

    Array.from(arr_nutr).forEach(element => {
        element.parentElement.style.display = "none";
    });
}

//Inizialmente quando tutto è disattivato il filtro non deve alimentazione non deve esserci
nut_invisible();
arr_cat_utils.forEach(element => {
    element.addEventListener("change", () => {
        let check = false;

        /*
            Mi serve per sapere se almeno uno è checkato
            in questo modo se deseleziono uno ma l'altro è ancora checkato
            il filtro "alimentazione" rimane visibile
        */
        arr_cat_utils.forEach(element => {
            if (element.checked) {
                check = true;
            }
        });

        /*
            Se almeno uno è checkato allora il filtro Alimentazione compare/rimane.
            Altrimenti scompare.
        */
        if (check) {
            nut_title.style.display = "block";

            arr_nutr.forEach(element => {
                element.parentElement.style.display = "block";
            });
        } else {
            //Deseleziono gli elementi presenti in alimentazione prima di farlo scomparire
            arr_nutr.forEach(element => {
                element.checked = false;
            });

            nut_invisible();
        }
    });
})

//mi prendo l'URL
const params = new URLSearchParams(document.location.search);

//prendo tutti i parametri che mi interessano e li metto in un array
let arr_cat = params.getAll("cat");
let arr_nut = params.getAll("nut");

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
            }
        })
    }
});