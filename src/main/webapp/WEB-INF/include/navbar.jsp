<%--@elvariable id="lastSearch" type="String"--%>
<%--@elvariable id="user" type="User"--%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<%@ page contentType="text/html;charset=UTF-8" %>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/navbar.css">
<div id="mobile-bar">
    <img alt="DinoStore Logo" src="${pageContext.request.contextPath}/img/solo_logo.png">
    <form class="form-bar" action="${pageContext.request.contextPath}/search">
        <!-- Use this just for support accessibility -->
        <label>
            <input aria-label="Cerca" placeholder="Cerca" id="search-mobile" class="bg-f4f5f5" type="text" name="search" value="${lastSearch}">
        </label>
        <button class="bg-f4f5f5"><img src="${pageContext.request.contextPath}/img/search_ico.png" alt="search ico">
        </button>
    </form>
    <div tabindex=0 role="menu" class="open-btn not-select menu-button" id="menuButton">
        <div class="line line1"></div>
        <div class="line line2"></div>
        <div class="line line3"></div>
    </div>
</div>

<nav class="bg-f4f5f5" id="navbar">
    <ul>
        <!-- il logo si nasconde quando siamo da mobile -->
        <li class="logo"><img alt="DinoStore Logo" src="${pageContext.request.contextPath}/img/logo.png"></li>
        <li><a id="home_nav" href="${pageContext.request.contextPath}/">Home</a></li>
        <li><a id="offerte" class="" href="${pageContext.request.contextPath}/offerte">Offerte</a></li>
        <li><a id="product_nav" class="" href="${pageContext.request.contextPath}/product">Prodotti</a></li>
        <li>
            <div class="dropdown">
                <button class="dropbtn">
                    Area Utente
                </button>
                <div class="dropdown-content">
                    <a href="${pageContext.request.contextPath}/carrello.jsp">Carrello</a>
                    <!-- user dovrebbe stare nella sessione -->
                    <c:choose>
                        <c:when test="${not empty user}">
                            <a href="#">Area Personale</a>
                            <a href="${pageContext.request.contextPath}/logout">Log out</a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/login.jsp">Accedi</a>
                            <a href="${pageContext.request.contextPath}/registrazione.jsp">Registrati</a>
                        </c:otherwise>
                    </c:choose>
                    <a href="https://www.youtube.com/watch?v=xvFZjo5PgG0" target="_blank">RickRoll</a>
                </div>
            </div>
        </li>
        <li></li>
    </ul>
    <form class="form-bar" action="${pageContext.request.contextPath}/search">
        <input id="search-desktop" type="text" name="search" value="${lastSearch}">
        <!-- This bar isn't empty. I use js to dynamically populate this using interval -->
        <label for="search-desktop" id="label_desktop">Search Bar</label>
        <button><img alt="search ico" src="${pageContext.request.contextPath}/img/search_ico.png"></button>
    </form>
</nav>
<script>

    let input_label_desktop = document.getElementById("label_desktop");
    let input_desktop = document.getElementById("search-desktop");
    let navBarStyle = document.getElementById("navbar").style;
    let isOpen = false;

    /**
     * When from desktop input (for search) is focused
     * disable label used for placeholder.
     */
    input_desktop.addEventListener("focusin", function () {
        input_label_desktop.style.display = "none";
    });

    /**
     * Hide label used for placeholder. This is only for desktop view.
     * @function check_for_hide_label
     * @param value - Check if is present some string in box. if it is present, hide this label.
     */
    function check_for_hide_label(value) {
        if (value === "") {
            input_label_desktop.style.display = "unset";
        } else {
            input_label_desktop.style.display = "none";
        }
    }

    /**
     * For first time whe need to hide label if is necessary.
     * (If input isn't empty)
     */
    check_for_hide_label(input_desktop.value);

    /**
     * For accessibility and flexibility, I use label as placeholder.
     * So, when some text is in the input area, I need to hide this "placeholder".
     * Check it at focusout.
     *
     * @function check_for_hide_label
     */
    input_desktop.addEventListener("focusout", function () {
        check_for_hide_label(input_desktop.value);
    });

    input_desktop.addEventListener("keypress", function () {
        //console.log("Sto scrivendo");
        /**
         * TODO: suggerimenti in tempo reale.
         */
    });

    /**
     * Needed for mobile view.
     * This can open and close the sidebar.
     *
     * @function openNav - used from button in html.
     */
    const menuButton = document.getElementById('menuButton');
    menuButton.addEventListener('click', () => {
        menuButton.classList.toggle('open');
        if (!isOpen) {
            navBarStyle.left = "0";
        } else {
            navBarStyle.left = "-260px";
        }

        isOpen = !isOpen;
    });
</script>
