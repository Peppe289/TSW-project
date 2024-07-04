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

    <c:if test="${not empty message}">
        <p style="color: red; margin: 4px; padding: 0;">${message}</p>
    </c:if>

    <button form="registrazione" name="button" value="registrazione">Registrati</button>
    <button onclick="location.href='login.jsp'">Accedi</button>
</div>
</body>

</html>