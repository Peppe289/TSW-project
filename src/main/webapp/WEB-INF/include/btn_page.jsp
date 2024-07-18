<%--@elvariable id="page" type="java.lang.Integer"--%>
<%--@elvariable id="lastSearch" type=""--%>
<%--@elvariable id="btn_page" type=""--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<style>
    #btn-page {
        display: inline-block;
        text-align: center;
        margin: auto;
        overflow: hidden;
        position: relative;
        width: auto;
        font-family: Arial, Helvetica, sans-serif;
    }

    #btn-page ul {
        list-style-type: none;
        padding: 0;
    }

    #btn-page * {
        display: inline-block;
        text-decoration: none;
    }

    #btn-page li {
        border-radius: 5px;
    }

    #btn-page a {
        padding: 10px;
    }

    #btn-page .active {
        color: white;
    }

    #btn-page .other {
        background-color: #ececec;
    }

    #btn-page .deactive {
        pointer-events: none;
        background-color: #939393;
        color: #cdcdcd;
    }
</style>

<div id="btn-page" class="not-select">
    <c:choose>
        <c:when test="${not empty page}">
            <ul>
                <li class="${page > 0 ? 'bg-3CB371 active' : 'deactive'}">
                    <a class="text" href="${pageContext.request.contextPath}/product?page=${page - 1}&search=${lastSearch}">Precedente</a>
                </li>
                <c:forEach var="number" begin="0" end="${btn_page}">
                    <li class="${page == number ? 'bg-3CB371 active' : 'other'}">
                        <a href="${pageContext.request.contextPath}/product?page=${number}&search=${lastSearch}">${number + 1}</a>
                    </li>
                </c:forEach>
                <li class="${page < btn_page ? 'bg-3CB371 active' : 'deactive'}">
                    <a class="text" href="${pageContext.request.contextPath}/product?page=${page + 1}&search=${lastSearch}">Successiva</a>
                </li>
            </ul>
        </c:when>
        <c:otherwise>
            <ul>
                <li class="bg-3CB371 active"><a class="text" href="${pageContext.request.contextPath}/product">Mostra più
                    prodotti</a></li>
            </ul>
        </c:otherwise>
    </c:choose>
</div>
