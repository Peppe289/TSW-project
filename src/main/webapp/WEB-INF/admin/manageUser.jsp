<%@ page import="java.util.*" %>
<%@ page import="org.dinosauri.dinosauri.model.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Admin Page</title>
    <link type="text/css" rel="stylesheet" href="css/admin.css">
    <link type="image/x-icon" rel="icon" href="${pageContext.request.contextPath}/img/solo_logo.png">
</head>
<body>
<div id="main_container">
    <%@ include file="sidebar.jsp" %>
    <div id="content">
        <div id="utenti" class="section">
            <h3>Utenti</h3>
            <hr>
            <table>
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>Cognome</th>
                    <th>Email</th>
                </tr>

                <%
                    List<User> users = (List<User>) request.getAttribute("users");

                    for (User user : users) {
                %>
                    <tr>
                        <td><%= user.getId() %></td>
                        <td><%= user.getNome() %></td>
                        <td><%= user.getCognome() %></td>
                        <td><%= user.getEmail() %></td>
                    </tr>
                <%
                    }
                %>
            </table>
        </div>
    </div>
</div>
</body>
</html>