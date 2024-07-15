<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link type="text/css" rel="stylesheet" href="css/login.css">
    <link type="image/x-icon" rel="icon" href="img/solo_logo.png">

    <title>DinoStore - Registrazione</title>
</head>

<body>

<!-- Nel caso in cui l'utente sia già loggato fai un redirect verso la pagina di index. -->
<c:if test="${not empty user}">
    <c:redirect url="/"/>
</c:if>

<div id="content">
    <img alt="DinoStore ico" src="img/login-ico.png">
    <form id="registrazione" action="login-validate" method="post">
        <div class="input">
            <input type="text" name="nome" id="nome" required>
            <label for="nome" class="field">Nome</label>
        </div>
        <div class="input">
            <input type="text" name="cognome" id="cognome" required>
            <label for="cognome" class="field">Cognome</label>
        </div>
        <div class="input">
            <input type="text" name="email" id="email" required>
            <label for="email" class="field">Email</label>
        </div>
        <div class="input">
            <input type="password" name="password" id="password" required>
            <label for="password" class="field">Password</label>
        </div>
        <div class="add_cookie not-select ">
            <input type="checkbox" value="stay_connect" name="stay_connect" id="stay_connect">
            <label for="stay_connect">Resta connesso</label>
        </div>
    </form>

    <c:choose>
        <c:when test="${not empty message}">
            <p id="message" style="color: red; margin: 4px; padding: 0;">${message}</p>
        </c:when>
        <c:otherwise>
            <p id="message" style="color: red; margin: 4px; padding: 0;"></p>
        </c:otherwise>
    </c:choose>

    <button form="registrazione" name="button" value="registrazione">Registrati</button>
    <button onclick="location.href='login.jsp'">Accedi</button>
</div>
</body>
<script defer>
    let email_input = document.getElementById("email");
    /*  */
    let validInput = {
        email: false,
        password: false
    };
    let password_input = document.getElementById("password");

    /**
     * Function to see regex for validated email.
     * I prefer to validate from js because I can change.
     * More flexibility than pattern="/^[a-zA-Z0-9]+@[a-zA-Z0-9]+[.]+[a-zA-Z0-9]+$/"
     *
     * @param el
     * @returns {boolean}
     */
    function email_regex(el) {
        return /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/.test(el.value);
    }

    function validatePassword() {
        if (password_input.value.indexOf(" ") > 0 || password_input.value.length < 8) {
            password_input.classList.add("invalid");
            validInput["password"] = false;
        } else {
            while (password_input.classList.contains("invalid"))
                password_input.classList.remove("invalid");

            validInput["password"] = true;
        }
    }

    function validateEmail() {
        if (email_regex(email_input) === false) {
            email_input.classList.add("invalid");
            validInput["email"] = false;
        } else {
            while (email_input.classList.contains("invalid"))
                email_input.classList.remove("invalid");

            validInput["email"] = true;
        }
    }

    email_input.onchange = function () {
        validateEmail();
    }

    password_input.onchange = function () {
        validatePassword();
    }

    /**
     * add action listener on a submitted form.
     * this code performs for check if you can execute default
     * action or edit action.
     */
    document.addEventListener("DOMContentLoaded", function() {
        document.getElementById("registrazione").addEventListener("submit", function(event) {
            /* perform validation here. */
            let isValid = validateForm();
            let message = document.getElementById("message");

            if (!isValid) {
                /* prevent form submit */
                event.preventDefault();
                if (!validInput["password"]) {
                    if (password_input.value.indexOf(" ") > 0)
                        message.innerHTML = "Password: Non usare spazi";
                    else
                        message.innerHTML = "Password: Password troppo corta";
                }

                if (!validInput["email"]) {
                    message.innerHTML = "Email: Inserisci una email valida";
                }
            }
        });
    });

    /**
     * check if email and password have the right value.
     *
     * @returns {boolean} validated or not.
     */
    function validateForm() {
        validateEmail();
        validatePassword();

        return validInput["password"] && validInput["email"];
    }

</script>
</html>