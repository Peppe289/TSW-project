<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link type="text/css" rel="stylesheet" href="css/login.css">

    <title>DinoStore - Log in</title>
</head>

<body>

<!-- Nel caso in cui l'utente sia già loggato fai un redirect verso la pagina di index. -->
<c:if test="${not empty user}">
    <c:redirect url="/"/>
</c:if>

<div id="content">
    <img src="img/login-ico.png">
    <form id="login" action="loginServlet" method="post">
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

    <button form="login">Log in</button>
    <button onclick="location.href='registrazione.jsp'">Registrati</button>
    <br><a href="#">Password dimenticata?</a>
</div>
</body>

</html>