<%--@elvariable id="user" type="org.dinosauri.dinosauri.model.User"--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <title>DinoStore - Pagamento</title>
</head>

<style>
    body {
        margin: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        width: 100%;
    }

    #main {
        display: block;
        height: 80vh;
        min-width: 300px;
        width: 90%  ;
        max-width: 1200px;
        box-shadow: 0 0 5px #bebebe;
        border-radius: 10px;
    }

    h2 {
        width: 100%;
        text-align: center;
        border-bottom: 1px solid black;
        font-size: 35px;
    }

    .item {
        width: 100%;
        text-align: center;
        font-size: 25px;
        height: 35px;
    }

    .item.img {
        width: 100%;
        height: calc(100% - 35px);

        & img {
            width: 300px;
            height: 100%;
            object-fit: contain;
        }
    }
</style>

<body>
    <div id="main">
        <h2>${user.nome} ${user.cognome} ***8829</h2>
        <div>
            <div class="item">
                Pagamento in corso...
            </div>
            <div class="item img">
                <img alt="payment" src="${pageContext.request.contextPath}/img/payment.gif">
            </div>
        </div>
    </div>
</body>
<script>
    setTimeout(function() {
        location.href = "/";
    }, 4900)
</script>
</html>
