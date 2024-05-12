<%--
  Created by IntelliJ IDEA.
  User: peppe289
  Date: 5/11/24
  Time: 3:14 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<style>
    footer {
        width: 100%;
    }

    #footer {
        margin: 0;
        padding: 20px;
        padding-bottom: 50px;
        padding-top: 50px;
        width: calc(100% - 40px);
        background-color: #003D1D;
        color: #ffffff;
        font-family: Verdana, Geneva, Tahoma, sans-serif;
    }

    #footer ul,
    #footer ul * {
        padding: 0px;
        margin: 0px;
    }

    #footer ul li {
        list-style-type: none;
    }

    #footer ul li:first-of-type {
        font-size: 20px;
    }

    #footer ul li a {
        color: #ffffff;
        text-decoration: none;
    }

    #disclamer {
        width: 100%;
        padding-bottom: 5px;
        padding-top: 5px;
        background-color: #002e16;
        color: white;
        display: flex;
        align-items: center;
        justify-content: space-evenly;
    }

    @media screen and (min-width: 800px) {
        #footer {
            /* allineamento */
            display: flex;
            flex-direction: row;
            align-items: center;
            justify-content: space-evenly;
            flex-wrap: wrap;
        }
    }

    @media screen and (max-width: 799px) {
        #footer {
            /* allineamento */
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: space-evenly;
            flex-wrap: wrap;
        }

        #footer ul {
            margin: 10px;
            text-align: center;
        }
    }
</style>
<body>
<footer>
    <div id="footer">
        <ul>
            <li>Contattaci</li>
            <li><a href="#">${initParam["emailSupport"]}</a></li>
            <li><a href="#">Altre cose</a></li>
        </ul>

        <ul>
            <li>Chi siamo</li>
            <li><a href="#">3 tizi</a></li>
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
</body>
</html>
