<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link type="text/css" rel="stylesheet" href="css/login.css">

    <title>DinoStore - Registrazione</title>
</head>

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