<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>DinoStore - Registrazione</title>
</head>
<style>
    /**
     * CSS riciclato da login
     */
    body {
        display: flex;
        justify-content: center;
        text-align: center;
        align-items: center;
        height: 100vh;
    }

    #content {
        border: 2px solid #ccc;
        width: 250px;
        padding: 50px 40px;
    }

    form {
        display: flex;
        flex-direction: column;
    }

    .input {
        position: relative;
        margin: 10px;
    }

    input[type="text"]:focus+label,
    input[type="text"]:valid+label,
    input[type="password"]:focus+label,
    input[type="password"]:valid+label {
        top: -10px;
        font-size: 12px;
        color: #3CB371;
    }

    input[type="text"],
    input[type="password"] {
        padding: 10px;
        font-size: 16px;
        border: none;
        border-bottom: 2px solid #ccc;
        outline: none;
    }

    input[type="text"]:focus,
    input[type="password"]:focus {
        border-color: #3CB371;
    }

    label {
        /* positione assoluta relativa al div dentro il form */
        position: absolute;
        top: 10px;
        left: 5px;

        color: #999;
        transition: all 0.2s ease-in-out;
        /**
         * In modo che il mouse non riesca mai
         * a vedere la solidità del blocco.
         */
        pointer-events: none;
    }

    button:first-of-type {
        background-color: white;
        border: 2px solid #3CB371;
        color: #3CB371;
    }

    button:first-of-type:hover {
        background-color: #3CB371;
        color: white;
    }

    button {
        background-color: #3CB371;
        color: white;
        border: 2px solid #3CB371;
        font-weight: bold;
        padding: 10px 20px;
        cursor: pointer;
        transition: 0.3s;

        /* allontana i tasti l'uno dell'altro */
        margin-top: 10px;
        margin-left: 5px;
        margin-right: 5px;

        /* abbassiamo il testo "password dimenticata" */
        margin-bottom: 10px;
    }
</style>

<body>
    <div id="content">
        <img src="img/login-ico.png">
        <form id="registrazione" action="loginServlet" method="post">
            <div class="input">
                <input type="text" name="nome" id="nome" required>
                <label>Nome</label>
            </div>
            <div class="input">
                <input type="text" name="cognome" id="cognome" required>
                <label>Cognome</label>
            </div>
            <div class="input">
                <input type="text" name="email" id="email" required>
                <label>Email</label>
            </div>
            <div class="input">
                <input type="password" name="password" id="password" required>
                <label>Password</label>
            </div>
        </form>

        <c:if test="${not empty message}">
            <p style="color: red; margin: 4px; padding: 0;">${message}</p>
        </c:if>

        <button form="registrazione">Registrati</button>
        <button onclick="location.href='login.jsp'">Accedi</button>
    </div>
</body>

</html>