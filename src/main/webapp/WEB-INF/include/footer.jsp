<%@ page contentType="text/html;charset=UTF-8" %>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
<footer>
    <div id="footer">
        <ul>
            <li>Contattaci</li>
            <li><a href="#">${initParam["emailSupport"]}</a></li>
            <li><a href="#">Altre cose</a></li>
        </ul>

        <ul>
            <li>Chi siamo</li>
            <li><a href="${pageContext.request.contextPath}/chi_siamo.jsp">About us</a></li>
        </ul>

        <ul>
            <li>Pagamenti tramite</li>
            <li>GPay</li>
            <li>VISA</li>
            <li>Altre cose</li>
            <li>L'importante è pagare</li>
        </ul>
    </div>
    <div id="disclamer">
        <p>Sito creato per progetto universitario</p>
    </div>
</footer>