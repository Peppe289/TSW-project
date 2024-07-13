<style>
    #sidebar {
        margin-right: 20px;
        height: 100vh;
        position: sticky;
        top: 0;
        width: 300px;

        & ul {
            top: 50px;
            margin: 0;
            padding: 0;

            & li {
                height: 40px;
                list-style-type: none;
                position: relative;

                a, a:visited, a:hover, a:active {
                    color: inherit;
                }

                & a {
                    text-align: center;
                    text-decoration: none;
                    align-content: center;
                    position: absolute;
                    height: 100%;
                    width: 100%;
                }

                & a:hover {
                    background-color: rgba(173, 173, 173, 0.22);
                }
            }
        }

        button {
            width: 100%;
            position: absolute;
            bottom: 50px;
            padding: 10px 20px;
            border: none;
            background-color: #dc3545;
            color: #fff;
            cursor: pointer;
            border-radius: 4px;
            margin: 0 10px;
        }

        button:hover {
            background-color: #c82333;
        }
    }
</style>

<div id="sidebar">
    <ul>
        <li><a id="product_nav_li" href="adminControl">Prodotti</a></li>
        <li><a id="user_nav_li" href="adminControl?reason=user">Utenti</a></li>
        <li><a id="admin_nav_li" href="adminControl?reason=admin">Admin</a></li>
    </ul>
    <button onclick='window.location.href = "${pageContext.request.contextPath}/adminControl?reason=logout"'>Log out
    </button>
</div>
<script>
    const params = new URLSearchParams(document.location.search);
    const product = document.getElementById("product_nav_li");
    const user = document.getElementById("user_nav_li");
    const admin = document.getElementById("admin_nav_li");

    let reason = params.get("reason");

    if (reason != null) {
        if (reason.indexOf("user") === 0) {
            user.classList.add("active");
        } else if (reason.indexOf("admin") === 0) {
            admin.classList.add("active");
        } else {
            product.classList.add("active");
        }
    } else {
        product.classList.add("active");
    }
</script>