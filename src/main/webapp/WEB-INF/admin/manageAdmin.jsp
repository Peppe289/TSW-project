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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/NotifyUser.css">
    <link type="image/x-icon" rel="icon" href="${pageContext.request.contextPath}/img/solo_logo.png">
</head>
<body>
<div id="main_container">
    <%@ include file="sidebar.jsp" %>
    <div id="content">
        <div id="admin" class="section">
            <h3>Admin</h3>
            <hr>
            <div id="admin-box">
                <table style="min-width: unset">
                    <tr>
                        <th>ID</th>
                        <th>Permission</th>
                        <th></th>
                    </tr>
                    <c:forEach items="${admins}" var="admin">
                        <tr>
                            <td>${admin.id}</td>
                            <td>
                                <label>
                                    <input type="number" min="0" max="2" value="${admin.permission}">
                                </label>
                            </td>
                            <td>
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
<script type="module" src="./js/ToastAPI.js"></script>
<script type="module">
    import {notifyUserModule} from "./js/ToastAPI.js"

    /******************* ADMIN UTILS AND AJAX *******************/

    let admin_box = document.getElementById("admin-box");
    let admin_table = admin_box.getElementsByTagName("table")[0];
    let admin_button = admin_table.getElementsByTagName("button");
    let admin_permission = admin_table.getElementsByTagName("input");

    Array.from(admin_permission).forEach(el => {
        el.addEventListener("change", (event) => {
            /* form input > label > td > tr. from tr I can get first child to see id of admin. */
            let id = event.target.parentElement.parentElement.parentElement.getElementsByTagName("td")[0].innerHTML;
            let permission = event.target.value;
            let obj  = {
                id: id,
                permission: permission.toString(),
                action: "modify_perm"
            }
            let xhr = new XMLHttpRequest();

            xhr.open("POST", "changePermission", true);
            xhr.onreadystatechange = function() {
                if (this.readyState === 4 && this.status === 200) {
                    let json = JSON.parse(this.responseText);

                    if (json["status"] !== "success") {
                        notifyUserModule("Error", json["status"]);
                    } else {
                        /* if all it's ok, reload the page to update content. */
                        location.reload();
                    }
                }
            }
            xhr.send(JSON.stringify(obj));
        })
    })

    /* for each button, add event listener for remove admin from database. */
    Array.from(admin_button).forEach(el => {
        let row = el.parentElement.parentElement;
        let id = row.getElementsByTagName("td")[0];
        el.addEventListener("click", () => {
            let admin_id = {
                id: id.innerHTML,
                action: "removeAdmin"
            };
            let xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function () {
                if (this.readyState === 4 && this.status === 200) {
                    let json = JSON.parse(this.responseText)
                    if (json["status"] !== "success") {
                        notifyUserModule("Error", json["status"]);
                    } else {
                        /* if all it's ok, reload the page to update content. */
                        location.reload();
                    }
                }
            }
            xhr.open("POST", "removeAdmin", true);
            xhr.send(JSON.stringify(admin_id));
        });
    });

    let output_password = document.getElementById("pwd_generated");
    let output_id = document.getElementById("id_admin");
    /* get the second element in label. this is for submit button. need to copy semi-random password generated. */
    let copy = document.getElementById("copy");

    /* Add event listener for copy to clipboard the password. */
    copy.addEventListener("click", () => {
        copy_to_clipboard();
        output_password.value = "";
        output_id.value = "";
        let reload = function reload() {
            location.reload()
        }
        setTimeout(reload, 1000);
    })

    /* event listener for generate random password or semi-random password. */
    document.getElementById("new_admin").addEventListener("click", () => {
        let password = "";
        /* generate random string. */
        for (let i = 0; i < 8; ++i) {
            let random = Math.floor(Math.random() * 10 + 55) + Math.floor(Math.random() * Math.floor(Math.random() * 10));
            password += String.fromCharCode(random);
        }

        output_password.value = password;
        let xhr = new XMLHttpRequest();
        let plyload = {
            action: "addAdmin",
            password: password
        }

        xhr.open("POST", "addAdmin", true);
        xhr.onreadystatechange = function () {
            if (this.readyState === 4 && this.status === 200) {
                let json = JSON.parse(this.responseText);
                if (json["status"] !== "success") {
                    notifyUserModule("Error", json["status"]);
                } else {
                    output_id.value = json["id"];
                }
            }
        }
        xhr.send(JSON.stringify(plyload));
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