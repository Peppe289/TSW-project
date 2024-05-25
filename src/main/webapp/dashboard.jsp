<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <link type="text/css" rel="stylesheet" href="css/dashboard/dashboard.css">
    <link type="text/css" rel="stylesheet" href="css/project.css">
</head>
<style>
    body {
        margin: 0;
        overflow: hidden;
    }
</style>
</head>
<body>
<div id="cotinaner">
    <div id="side_bar">
        <h2>Store</h2>
        <hr>
        <ul>
            <li onclick="location.href='${pageContext.request.contextPath}/'" class="item">Torna alla home</li>
        </ul>
        <h2>Admin</h2>
        <hr>
        <ul>
            <li id="general" class="item">Generale</li>
            <li id="webStat" class="item">Visualizza statistiche</li>
        </ul>
        <h2>Per sviluppatori</h2>
        <hr>
        <ul>
            <li id="serverStat" class="item">Statistiche server</li>
        </ul>
    </div>
    <div id="content">
        <span id='checkbox_area' class='hide'>
        Aggiornamento continuo
        <span style='margin: 5px'></span>
            <label class="switch">
                <input type="checkbox">
                <span class="slider round"></span>
            </label>
        </span>
        <div id="list">

        </div>
    </div>
</div>
</body>
<script src="js/dashboard.js"></script>
</html>