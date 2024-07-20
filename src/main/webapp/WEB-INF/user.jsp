<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Area Utente</title>
    <style>
        * {
            font-family: 'Open Sans', Arial, sans-serif;
            box-sizing: border-box;
            scroll-behavior: smooth;
        }

        html, body {
            margin: 0;
        }

        .disable_select_text {
            -webkit-user-select: none; /* Safari */
            -ms-user-select: none; /* IE 10 and IE 11 */
            user-select: none; /* Standard syntax */
        }

        #container {
            display: flex;
            justify-content: center;
            margin: 0 auto;
            max-width: 1200px;
            width: 90%;
            background-color: white;
            box-shadow: 0 0 10px #e8e8e8;


            button.change_address,
            div.apply > button.apply {
                background-color: #28a745;
                color: #fff;
            }

            button.change_address,
            div.apply > button.apply:hover {
                background-color: #218838;
            }
        }

        #side_bar_btn {
            display: none;
        }

        #side-bar {
            padding-top: 40px;
            width: 20%;
            height: 100vh;
            min-width: 250px;
            border-right: 1px solid black;
            position: sticky;
            top: 0;

            & ul {
                top: 40px;
                text-align: center;
                margin: 0 auto;
                padding: 0;
                width: 100%;
            }

            & ul li {
                margin: 0;
                cursor: pointer;
                list-style-type: none;
                width: 100%;
            }

            & ul li:hover {
                background-color: rgba(0, 0, 0, 0.08);
            }

            & a {
                overflow: hidden;
                text-decoration: none;
                /* Use parent color. */
                color: inherit;
                padding: 10px 0 10px 0;
                margin: 0;
                display: block;
            }
        }

        #content {
            min-width: 500px;
            padding: 10px 20px 0 20px;
            text-align: center;

            label,
            input[type="email"],
            input[type="text"],
            input[type="password"],
            input[type="number"],
            button.editable {
                display: flex;
                align-items: center;
                height: 30px;
                min-width: 30px;
                font-size: 0.9rem;
                padding: 0 8px 0 8px;
                margin: 0;
            }

            /**
             * Use hr (horizontal line) in new line.
             * In flex need width 100%
             */

            hr {
                width: 100%;
            }

            *:focus {
                user-select: unset;
                outline: none;
            }

            button.change_address {
                width: 60%;
            }

            & .container {
                display: flex;
                flex-direction: row;
                flex-wrap: wrap;
                justify-content: center;
                align-content: center;
                align-items: center;
                overflow: hidden;

                & h3 {
                    padding-top: 40px;
                }

                & div.apply {
                    width: 100%;
                }

                button.change_address,
                & div.apply > button.apply {
                    height: 40px;
                    padding: 0 20px 0 20px;
                    border: none;
                    cursor: pointer;
                    border-radius: 4px;
                }
            }

            & .box {
                display: inline-flex;
                position: relative;
                align-items: center;
                min-width: 310px;
                padding: 20px;
                max-width: 100%;
                margin: 5px;

                & #show_pass {
                    position: absolute;
                    right: 50px;

                    & span {
                        position: absolute;
                        height: 2px;
                        width: 25px;
                        display: block;
                        background-color: black;
                        z-index: 3;
                        transform: rotate(45deg);
                    }

                    & img {
                        width: 25px;
                        cursor: pointer;
                    }
                }
            }

            & .row-table {
                width: 100%;
                display: block;
                padding: 0;

                & .row-item {
                    display: flex;
                    align-items: center;
                    justify-content: space-between;
                    height: 50px;
                    margin: 0 0 0 25px;
                    width: calc(100% - 25px);
                    padding: 20px;

                    & > div {
                        font-size: 0.99rem;
                    }

                    /*
                    & .quantity_prod {

                    }

                    & .name_prod {

                    }

                    & .price_prod {

                    }
                    */
                }

                & .row-item:nth-child(odd) {
                    background-color: rgba(141, 141, 141, 0.08);
                }

                & .summary {
                    height: 70px;
                    margin: 0;
                    padding: 0 75px 0 0;
                    background-color: rgba(98, 98, 98, 0.12);
                    display: flex;
                    justify-content: space-between;

                    & .order-propriety {
                        display: flex;
                        align-items: center;
                        justify-content: center;
                    }
                }

                & .open_order {
                    height: 100%;
                    width: min-content;
                    cursor: pointer;
                }

                & .toggle {
                    height: 100%;
                    display: flex;
                    width: 20px;
                    align-items: center;
                    justify-content: center;
                    margin: 0 10px 0 10px;
                    padding: 0 10px 0 10px;
                    font-size: 1.5em;
                }

                & .hide {
                    display: none;
                }

                & .active {
                    box-shadow: 0 5px 5px #adadad;
                }
            }

            & .grid-items {
                box-shadow: 0 0 10px #c0c0c0;
                margin-inline: 10px;
                margin-block: 10px;
                display: inline-flex;
                flex-direction: column;
                flex-wrap: wrap;
                height: 350px;
                width: 350px;
                padding: 0;

                & > .box {
                    padding: 0;
                    margin: 10px 0 10px 0;
                    position: relative;

                    & > label input {
                        margin: auto;
                        min-width: unset;
                        width: 150px;
                        right: 140px;
                        max-width: unset;
                    }

                    & input.editable {
                        right: 45px;
                        position: absolute;
                    }

                    & button.editable {
                        right: 10px;
                        position: absolute;
                    }
                }

                & .box:first-child {
                    margin-top: 15px;
                }

                & .box:last-child {
                    margin-bottom: 15px;
                }
            }

            input.editable {
                border: 1px solid rgba(126, 126, 126, 0.13);
                border-right: none;
            }

            label {
                max-width: min-content;
            }

            button.editable {
                background: rgba(126, 126, 126, 0.13);
                border: none;
                margin: 0;
                cursor: pointer;

                & img {
                    width: 20px;
                }
            }
        }

        @media screen and (max-width: 900px) {
            #container {
                width: 100%;
            }

            #content {
                padding: 0;
                min-width: unset;
            }

            #content .row-table .toggle {
                font-size: 0.8rem;
            }

            #content .row-table {
                font-size: 0.9rem;
            }

            #side-bar {
                display: none;
                position: absolute;
                background-color: white;
                left: 0;
                top: 0;
                height: 100vh;
                z-index: 500;
            }

            .summary {
                margin: 0;
                padding: 0 !important;
                gap: 4px;
            }

            #side_bar_btn {
                display: flex;
                justify-content: center;
                align-items: center;
                font-size: 1.5rem;
                cursor: pointer;
                position: absolute;
                top: 40px;
                left: 0;
                height: 60px;
                width: 50px;
                border-radius: 0 15px 15px 0;
                box-shadow: 1px 0 5px black;
                background-color: white;
            }
        }
    </style>
</head>
<body>

<div id="container">
    <div id="side_bar_btn">&#9776;</div>
    <div id="side-bar">
        <ul>
            <li><a href="/">Continua ad acquistare</a></li>
            <li><a href="#user_info">Informazioni personali</a></li>
            <li><a href="#addr_manage">Gestisci indirizzi</a></li>
            <li><a href="#order_done">Ordini effettuati</a></li>
            <li><a href="/">Carrello</a></li>
        </ul>
    </div>
    <div id="content">
        <h1 class="scroll-item">Il tuo profilo</h1>
            <form id="info" method="post" action="${pageContext.request.contextPath}/user_page"
                  class="scroll-item container">
                <input type="hidden" name="reason" value="changeInfo">
                <h3 id="user_info">Informazioni personali</h3>
                <hr>
                <div class="box">
                    <label for="nome">Nome:</label>
                    <input class="editable" id="nome" name="nome" type="text" value="${user.nome}" disabled>
                    <button class="editable"><img alt="edit" src="${pageContext.request.contextPath}/img/edit-ico.png">
                    </button>
                </div>
            <div class="box">
                <label for="surname">Cognome:</label>
                <input class="editable" id="surname" name="surname" type="text" value="${user.cognome}" disabled>
                <button class="editable"><img alt="edit" src="${pageContext.request.contextPath}/img/edit-ico.png">
                </button>
            </div>
            <div class="box">
                <label for="email">Email:</label>
                <input class="editable" id="email" name="email" type="email" value="${user.email}" disabled>
                <button class="editable"><img alt="edit" src="${pageContext.request.contextPath}/img/edit-ico.png">
                </button>
            </div>
            <div class="box">
                <label for="password">Change Password:</label>
                <input class="editable" id="password" name="password" type="password" value="" disabled>
                <label for="password" id="show_pass"><span></span><img alt="show password"
                                                                       src="${pageContext.request.contextPath}/img/show_password.png"></label>
                <button class="editable"><img alt="edit" src="${pageContext.request.contextPath}/img/edit-ico.png">
                </button>
            </div>

            <div class="apply">
                <button form="info" id="submit_info" class="apply">
                    Applica
                </button>
            </div>
        </form>
        <p>${message}</p>
        <div class="scroll-item container">
            <h3 id="addr_manage">Gestione degli indirizzi</h3>
            <hr>
            <div id="address" class="box grid-items">
                <div class="box">
                    <label>Destinatario:
                        <input class="editable" name="nome" type="text" value="${address.name} ${address.cognome}"
                               disabled>
                    </label>
                </div>
                <div class="box">
                    <label>Via:
                        <input class="editable" name="addr" type="text" value="${address.via}" disabled>
                    </label>
                </div>
                <div class="box">
                    <label>Civico:
                        <input class="editable" name="addr_num" type="text" value="${address.numero_civico}" disabled>
                    </label>
                </div>
                <div class="box">
                    <label>Città:
                        <input class="editable" name="city" type="text" value="${address.comune}" disabled>
                    </label>
                </div>
                <div class="box">
                    <label>Cap:
                        <input class="editable" name="cap" type="number" value="${address.cap}" disabled>
                    </label>
                </div>
                <button id="change_address" onclick='location.href=`${pageContext.request.contextPath}/address_page`'
                        class="change_address">
                    Modifica Indirizzo
                </button>
            </div>
        </div>

        <div class="scroll-item container">
            <h3 id="order_done">Ordini effettuati</h3>
            <hr>
            <!-- first order -->
            <div class="box row-table">
                <!-- pointer button for hide/show order details. -->
                <div class="summary disable_select_text">
                    <div class="open_order">
                        <span class="toggle opened hide">&#x25B2;</span>
                        <span class="toggle closed">&#x25BC;</span>
                    </div>
                    <div class="order-propriety">24/01/2020</div>
                    <div class="order-propriety">Consegnato in Via Domenico Amorelli 19</div>
                    <div class="order-propriety">34821094820498 €</div>
                </div>
                <div class="row-item">
                    <div class="quantity_prod">
                        2x
                    </div>
                    <div class="name_prod">
                        T-Rex
                    </div>
                    <div class="price_prod">
                        532 €
                    </div>
                </div>
                <div class="row-item">
                    <div class="quantity_prod">
                        2x
                    </div>
                    <div class="name_prod">
                        Ciro
                    </div>
                    <div class="price_prod">
                        6363463 €
                    </div>
                </div>
                <div class="row-item">
                    <div class="quantity_prod">
                        2x
                    </div>
                    <div class="name_prod">
                        Guinzaglio medio
                    </div>
                    <div class="price_prod">
                        6433 €
                    </div>
                </div>
            </div>
            <!-- end order -->
            <!-- order -->
            <div class="box row-table">
                <!-- pointer button for hide/show order details. -->
                <div class="summary disable_select_text">
                    <div class="open_order">
                        <span class="toggle opened hide">&#x25B2;</span>
                        <span class="toggle closed">&#x25BC;</span>
                    </div>
                    <div class="order-propriety">24/01/2020</div>
                    <div class="order-propriety">Consegnato in Via Domenico Amorelli 19</div>
                    <div class="order-propriety">34821094820498 €</div>
                </div>
                <div class="row-item">
                    <div class="quantity_prod">
                        2x
                    </div>
                    <div class="name_prod">
                        T-Rex
                    </div>
                    <div class="price_prod">
                        532 €
                    </div>
                </div>
                <div class="row-item">
                    <div class="quantity_prod">
                        2x
                    </div>
                    <div class="name_prod">
                        Ciro
                    </div>
                    <div class="price_prod">
                        6363463 €
                    </div>
                </div>
                <div class="row-item">
                    <div class="quantity_prod">
                        2x
                    </div>
                    <div class="name_prod">
                        Guinzaglio medio
                    </div>
                    <div class="price_prod">
                        6433 €
                    </div>
                </div>
            </div>
            <!-- end order -->
        </div>
    </div>
</div>
</body>

<script defer>
    let input = document.getElementsByTagName("input");
    let side_bar_open = false;
    let side_bar_btn = document.getElementById("side_bar_btn");
    let side_bar = document.getElementById("side-bar");

    /* on click show/hide the sidebar. */
    side_bar_btn.addEventListener("click", () => {
        side_bar_open = !side_bar_open;

        if (side_bar_open) {
            side_bar.style.display = "block";
            /* get sidebar width for move button for show/hide. */
            side_bar_btn.style.left = side_bar.getBoundingClientRect().width.toString() + "px";
        } else {
            /* hide and restore. */
            side_bar.style.display = "none";
            side_bar_btn.style.left = "0";
        }
    });

    /* add event listener for force show/hide sidebar. */
    window.addEventListener("resize", () => {
        if (window.innerWidth > 900) {
            side_bar.style.display = "block";
        } else {
            side_bar.style.display = "none";
        }
    });

    /* show order box. */
    let show_order_btn = document.getElementsByClassName("open_order");

    /**
     * Helper function for show/hide product for order
     *
     * @param items - elements list (row with product)
     * @param hide - flag for hide/show
     */
    function hide_show_order(items, hide) {
        Array.from(items).forEach((el) => {
            if (hide) {
                el.style.display = "none";
            } else {
                el.style.display = "flex";
            }
        });
    }

    /* for show product in order add event listener to all summary. */
    Array.from(show_order_btn).forEach((el) => {
        let items = el.parentElement.parentElement.getElementsByClassName("row-item");
        hide_show_order(items, true);

        el.addEventListener("click", () => {
            let opened = el.getElementsByClassName("opened")[0];
            let closed = el.getElementsByClassName("closed")[0];

            /* hide/show order details. */
            if (Array.from(opened.classList).includes("hide")) {
                /* when active, enable shadow */
                el.parentElement.classList.add("active");
                closed.classList.add("hide");
                opened.classList.remove("hide");
                hide_show_order(items, false);
            } else {
                /* when deactivated, hide shadow */
                el.parentElement.classList.remove("active");
                closed.classList.remove("hide");
                opened.classList.add("hide");
                hide_show_order(items, true);
            }
        });
    });

    /**
     * Disable input when is focused and user press enters.
     * Disable the default action (submit form) and make the state disabled.
     */
    Array.from(input).forEach((item) => {
        /* should be single button in box with an input element. */
        let button;
        let boxing = item.parentElement;

        /* if eh button element are in label go out to parent. */
        if (boxing.tagName.toUpperCase() === "label".toUpperCase())
            boxing = item.parentElement.parentElement;

        /**
         * button for deactivate/active input.
         *
         * Example:
         *  <div class="box">
         *      <label for="password">Password:</label>
         *      <input class="editable" id="password" name="password" type="password" value="bruh" disabled>
         *      <label for="password" id="show_pass"><span></span><img alt="show password"
         *                                                                        src="show_password.png"></label>
         *      <button class="editable"><img alt="edit" src="edit-ico.png"></button>
         *  </div>
         */
        button = boxing.getElementsByTagName("button");

        /* getElements retrieves always array. check if array is more larger than 0. */
        if (button.length > 0) {
            /* we need always only first element in box. */
            button = button[0];
            button.addEventListener("click", () => {
                item.disabled = !item.disabled;
            });
        }
    });

    let show_password = document.getElementById("show_pass");
    let password_input = show_password.parentElement.getElementsByTagName("input")[0];
    let password_span = show_password.getElementsByTagName("span")[0];
    let password_image = show_password.getElementsByTagName("img")[0];
    let show_flag = false;

    /**
     * Show and hide password text.
     * Convert input to text for show password and remove span over image
     * (eye animation as serious website).
     * otherwise, use input as password and keep password hidden.
     */
    password_image.addEventListener("click", () => {
        show_flag = !show_flag;

        if (show_flag) {
            password_input.type = "text";
            password_span.style.display = "none";
        } else {
            password_input.type = "password";
            password_span.style.display = "block";
        }
    });

    /* prevent default action for all button. */
    document.getElementById("info").addEventListener("submit", (event) => {
        event.preventDefault();
    })

    /* make submit only with dedicated button. */
    document.getElementById("submit_info").addEventListener("click", () => {
        const from_input = document.getElementsByTagName("input");
        Array.from(from_input).forEach(item => {
            item.disabled = false;
        })
        document.getElementById("info").submit();
    })
</script>

</html>