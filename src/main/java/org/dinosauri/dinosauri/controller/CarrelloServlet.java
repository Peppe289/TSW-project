package org.dinosauri.dinosauri.controller;

import com.fasterxml.jackson.core.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import org.dinosauri.dinosauri.model.*;

import java.io.*;
import java.util.*;


@WebServlet(name = "Cart", urlPatterns = {"/carrello-add-ajax", "/retrieve-cart"})
public class CarrelloServlet extends HttpServlet {

    /* for ignore other elements in session specify prefix of product items. */
    public static final String prefix = "PRODUCT_";

    /**
     * Try to add an element to cart using id. Check if it is available.
     *
     * @param request - Need for GET param.
     * @return json string with all elements and single item (from id).
     */
    private String addElementsToCart(HttpServletRequest request) throws JsonProcessingException {
        String id = request.getParameter("id");
        int howManyProd;
        int totalProductCart = 0;
        String status = null;
        int availableElements = ProductDAO.doRetrieveProductByID(id, true).size();
        HttpSession session = request.getSession(true);
        Enumeration<String> sessionEl = session.getAttributeNames();
        /* Check if is logged or not. If isn't logged save data in session. If is logged save in a database. */
        User user = (User) request.getSession().getAttribute("user");
        Carrello cartJson = new Carrello();

        try {
            howManyProd = Integer.parseInt(request.getParameter("add"));
        } catch (NumberFormatException e) {
            /* If we don't have how many elements to add return null. (Ignore error, just response as no data) */
            return null;
        }

        while (sessionEl.hasMoreElements()) {
            String id_el = sessionEl.nextElement();
            /* consider only session item with product prefix in name. ignore otherwise. */
            /* ignore also id in request parameter (we need to check some stuff later). */
             if (id_el.indexOf(prefix) == 0 && !id_el.equals(prefix + id)) {
                int single_prod = (int) session.getAttribute(id_el);
                totalProductCart += single_prod;
                /* add id - quantity in hashmap. */
                cartJson.putElements(id_el.substring(prefix.length()), single_prod);
            }
        }

        /* try to add more elements. error with this. replace size with max. */
        if (availableElements < howManyProd) {
            howManyProd = availableElements;
            status = "Troppi selezionati.";
        } else if (howManyProd < 0) {
            /* the user not should have a negative element. */
            howManyProd = 0;
        }

        /* return how many elements are added for this id. */
        cartJson.setAddedElements(howManyProd);

        /* If the product isn't available in a database, this will be 0. Don't set this key and return error */
        if (availableElements == 0) {
            status = "Elemento non disponibile.";
        }

        /* if user is logged add cart items to database, otherwise add to session. */
        if (user != null) {
            /* TODO: insert to database about user. */
        } else {
            session.setAttribute(prefix + id, howManyProd);
        }

        /* add this element with id to hashmap. if already exist will do override (no problem) */
        cartJson.putElements(id, howManyProd);

        /* calculate total items in card. */
        totalProductCart += howManyProd;
        /* set other cart data in hashmap. */
        cartJson.setTotalElements(totalProductCart);
        cartJson.setStatus(status);
        cartJson.loadPrice();
        /* convert hashmap to json. */
        return cartJson.generateJson();
    }

    /**
     * Retrieve all elements if we use session.
     *
     * @param request - get session.
     * @return json with number of all elements
     */
    private String doRetrieveAllElementsCart(HttpServletRequest request) throws JsonProcessingException {
        int totalProductCart = 0;
        // TODO: implement also without session for logged user.
        HttpSession session = request.getSession(true);
        Carrello cartJson = new Carrello();
        Enumeration<String> attributes = session.getAttributeNames();

        /* see all elements but add only the elements which name start with product prefix. */
        while (attributes.hasMoreElements()) {
            int temp;

            String element_id = attributes.nextElement();
            if (element_id.indexOf(prefix) == 0) {
                temp = (int) session.getAttribute(element_id);
                /* add id - quantity to hashmap. */
                cartJson.putElements(element_id.substring(prefix.length()), temp);
                totalProductCart += temp;
            }
        }

        /* add total quantity to hashmap. */
        cartJson.setTotalElements(totalProductCart);
        /* set the default state ("success"). */
        cartJson.loadPrice();
        cartJson.setStatus();
        return cartJson.generateJson();
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
