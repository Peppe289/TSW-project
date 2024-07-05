package org.dinosauri.dinosauri.controller;

import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import org.dinosauri.dinosauri.model.*;

import java.io.*;
import java.util.*;


@WebServlet(name = "Cart", urlPatterns = {"/carrello-add-ajax", "/retrieve-cart"})
public class CarrelloServlet extends HttpServlet {

    /* for ignore other elements in session specify prefix of product items. */
    public static final String prefix = "PRODUCT_";

    private String stringJsonGenerate(int totalProductCart, int howManyProd, String status) {
        /* success by default. */
        if (status == null) status = "success";

        return "{\"elements\":\"" + totalProductCart + "\",\"item\":\"" + howManyProd + "\",\"status\":\"" + status + "\"}";
    }

    /**
     * Try to add an element to cart using id. Check if it is available.
     *
     * @param request - Need for GET param.
     * @return json string with all elements and single item (from id).
     */
    private String addElementsToCart(HttpServletRequest request) {
        String id = request.getParameter("id");
        Integer howManyProd;
        Integer totalProductCart = 0;
        String status = null;
        int availableElements = ProductDAO.doRetrieveProductByID(id, true).size();
        HttpSession session = request.getSession(true);
        Enumeration<String> sessionEl = session.getAttributeNames();
        /* Check if is logged or not. If isn't logged save data in session. If is logged save in a database. */
        User user = (User) request.getSession().getAttribute("user");

        try {
            howManyProd = Integer.parseInt(request.getParameter("add"));
        } catch (NumberFormatException e) {
            /* If we don't have how many elements to add return null. (Ignore error, just response as no data) */
            return null;
        }

        while (sessionEl.hasMoreElements()) {
            String id_el = sessionEl.nextElement();
            /* consider only session item with product prefix in name. ignore otherwise. */
            if (id_el.equals(prefix + id)) {
                /* save the number of products for later. skip for now in total counter. */
                howManyProd += (Integer) session.getAttribute(id_el);
            } else if (id_el.indexOf(prefix) == 0) totalProductCart += (Integer) session.getAttribute(id_el);
        }

        /* try to add more elements. error with this. replace size with max. */
        if (availableElements < howManyProd) {
            howManyProd = availableElements;
            status = "Too many element";
        }

        /* if user is logged add cart items to database, otherwise add to session. */
        if (user != null) {
            /* TODO: insert to database about user. */
        } else {
            session.setAttribute(prefix + id, howManyProd);
        }

        /* calculate total items in card. */
        totalProductCart += howManyProd;
        return stringJsonGenerate(totalProductCart, howManyProd, status);
    }

    /**
     * Retrieve all elements if we use session.
     *
     * @param request - get session.
     * @return json with number of all elements
     */
    private String doRetrieveAllElementsCart(HttpServletRequest request) {
        int totalProductCart = 0;
        // TODO: implement also without session for logged user.
        HttpSession session = request.getSession(true);
        Enumeration<String> attributes = session.getAttributeNames();

        /* see all elements but add only the elements which name start with product prefix. */
        while (attributes.hasMoreElements()) {
            Integer temp;

            String element_id = attributes.nextElement();
            if (element_id.indexOf(prefix) == 0) {
                temp = (Integer) session.getAttribute(element_id);
                totalProductCart += temp;
            }
        }

        return "{\"elements\":\"" + totalProductCart + "\",\"status\":\"success\"}";
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String json;
        /* specify id for try to add all elements. otherwise, retrieve total cart items. */
        if (request.getParameter("id") != null && request.getParameter("add") != null) {
            json = addElementsToCart(request);
        } else {
            json = doRetrieveAllElementsCart(request);
        }
        response.setContentType("application/json");
        response.getWriter().print(json);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        doGet(request, response);
    }
}
