<%--
  Created by IntelliJ IDEA.
  User: darksassio
  Date: 05/07/24
  Time: 15:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>

<!DOCTYPE html>
<html>

<head>
    <title>DinoStore</title>
</head>

<body>
    <%@ include file="WEB-INF/include/navbar.jsp" %>
    <%@ include file="WEB-INF/include/carrello_portable.html" %>

    <table id="prodotti">
        <c:choose>
            <c:when test="${}"> <!--TODO: Se è presente almeno un prodotto-->
                <c:forEach> <!--TODO: Cicla per numero di elementi-->
                    <tr>
                        <img src=""> <!--TODO: Immagine del prodotto presente nel carello-->
                        <p>
                            <h3>Nome prodotto presente nel carello</h3>
                            Descrizione del prodotto presente nel carello
                        </p>
                        <p>Prezzo</p>
                        <!--TODO: Bottone per togliere il prodotto dal carello-->
                    </tr>
                </c:forEach>
                <div id="acquista">
                    <p>Totale del numero di prodotti e del prezzo presenti nel carello</p>
                    <!--TODO: Bottone per procedere con l'acquisto-->
                </div>
            </c:when>
            <c:otherwise>
                <div>
                    <h2>Non sono presenti prodotti</h2>
                </div>
            </c:otherwise>
        </c:choose>
    </table>

    <%@ include file="WEB-INF/include/footer.jsp" %>
</body>
</html>
