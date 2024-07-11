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
</head>
<body>
<div id="main_container">
    <div id="sidebar">
        <ul>
            <li><a href="${pageContext.request.contextPath}/adminControl">Prodotti</a></li>
            <li><a href="${pageContext.request.contextPath}/adminControl?reason=user">Utenti</a></li>
            <li><a class="active" href="${pageContext.request.contextPath}/adminControl?reason=admin">Admin</a></li>
        </ul>
    </div>
    <div id="content">
        <div id="admin" class="section">
            <h3>Admin</h3>
            <hr>
            <div id="admin-box">
                <table style="min-width: unset">
                    <tr>
                        <th>ID</th>
                        <th></th>
                    </tr>
                    <c:forEach items="${admins}" var="admin">
                        <tr>
                            <td>${admin.id}</td>
                            <td>
                                <!-- TODO: implements revoca action. -->
                                <button class="edit">Revoca</button>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
                <div id="generate_admin">
                    <h3>Genera un nuovo amministratore</h3>
                    <p>L'admin è generato con ID semi-casuale. La password verrà generate in modo casuale.</p>
                    <button id="new_admin">Crea Admin</button>
                    <label>
                        <input id="id_admin" type="text" value="" disabled>
                        <input id="pwd_generated" type="text" value="" disabled>
                        <input id="copy" type="submit" value="copia">
                    </label>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script>

    /******************* ADMIN UTILS AND AJAX *******************/

    let admin_box = document.getElementById("admin-box");
    let admin_table = admin_box.getElementsByTagName("table")[0];
    let admin_button = admin_table.getElementsByTagName("button");

    /* for each button, add event listener for remove admin from database. */
    Array.from(admin_button).forEach(el => {
        let row = el.parentElement.parentElement;
        let id = row.getElementsByTagName("td")[0];
        el.addEventListener("click", () => {
            /* TODO: make ajax request for remove this admin from database. */
            let admin_id = id.innerHTML;
            console.log(admin_id);
        });
    });

    let output_password = document.getElementById("pwd_generated");
    let output_id = document.getElementById("id_admin");
    /* get the second element in label. this is for submit button. need to copy semi-random password generated. */
    let copy = document.getElementById("copy");

    /* Add event listener for copy to clipboard the password. */
    copy.addEventListener("click", () => {
        copy_to_clipboard();
    })

    /* event listener for generate random password or semi-random password. */
    document.getElementById("new_admin").addEventListener("click", () => {
        let password = "";
        /* generate random string. */
        for (let i = 0; i < 8; ++i) {
            let random = Math.floor(Math.random() * 10 + 55) + Math.floor(Math.random() * Math.floor(Math.random() * 10));
            password += String.fromCharCode(random);
        }

        /* TODO: ajax request for insert new admin using this password. then retrieve ID generated and show it on output_id. */
        output_id.value = "need ajax";
        output_password.value = password;
    });

    /**
     * Utility for copy new password and id to clipboard.
     *
     * @function addEventListener add to event listener.
     */
    function copy_to_clipboard() {
        let copyText = output_password;
        copyText.select();
        copyText.setSelectionRange(0, 99999);
        let password = " Password: " + copyText.value;
        copyText = output_id;
        copyText.select();
        copyText.setSelectionRange(0, 99999);
        let id = "ID: " + copyText.value;
        console.log(id + password);
        navigator.clipboard.writeText(id + password);
    }
</script>
</html>