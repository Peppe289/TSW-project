<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link type="text/css" rel="stylesheet" href="css/login.css">
    <link type="image/x-icon" rel="icon" href="${pageContext.request.contextPath}/img/solo_logo.png">

    <title>DinoStore - Log in</title>
</head>

<body>

<!-- Nel caso in cui l'utente sia già loggato fai un redirect verso la pagina di index. -->
<c:if test="${not empty admin}">
    <c:redirect url="/adminControl"/>
</c:if>

<div id="content">
    <img alt="logo" style="height: 200px;" src="img/admin-ico.png">
    <form id="login" action="adminLogIn" method="post">
        <div class="input">
            <input type="text" name="id" id="id" required>
            <label for="id" class="field">ID</label>
        </div>
        <div class="input">
            <input type="password" name="password" id="password" required>
            <label for="password" class="field">Password</label>
        </div>
    </form>

    <button form="login" name="button" value="login">Log in</button>
</div>
</body>

</html>