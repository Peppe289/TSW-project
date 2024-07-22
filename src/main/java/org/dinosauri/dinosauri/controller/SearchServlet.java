package org.dinosauri.dinosauri.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import org.dinosauri.dinosauri.model.*;

import java.io.*;
import java.util.*;

@WebServlet(name = "search", urlPatterns = {"/search", "/product"})
public class SearchServlet extends HttpServlet {

    final public int max_prod_page = 10;

    /* save all paths of image. */
    private void addImage(List<Product> products) {
        for (Product product : products) {
            product.SaveFileList(new File(getServletContext().getRealPath("/")).getAbsolutePath());
        }
    }

    /**
     * Search and filter for keywords
     *
     * @param req - Needed for request parameter.
     * @return - List of products.
     */
    private List<Product> doGetForKeyWord(HttpServletRequest req) {
        List<Product> products;
        String keyword = req.getParameter("search");
        String[] keywords = keyword.split(" ");

        products = new ArrayList<>();
        for (String tmp : keywords) {
            List<Product> list = ProductDAO.doRetrieveProducts(tmp);
            for (Product prod : list) {
                if (!products.contains(prod)) {
                    products.add(prod);
                }
            }
            list.clear();
        }
        return products;
    }


    private List<Product> applyFilter(List<Product> products, HttpServletRequest request) {
        List<Product> filter;
        String[] nut_words = request.getParameterValues("nut");
        String[] cat_words = request.getParameterValues("cat");

        /* filter for category. */
        if (cat_words != null) {
            filter = new ArrayList<>();
            for (Product product : products) {
                /* multiple category entry. */
                for (String tmp : cat_words) {
                    if (product.getCategoria().equals(tmp)) {
                        filter.add(product);
                        break;
                    }
                }
            }
        } else {
            /* if I can't make the first filter, return. I can't make another filter. */
            return products;
        }

        /* filter for nutrition. */
        if (nut_words != null) {
            filter.removeIf((item) -> {

                /* maybe can be "ossa" or some other stuff that not have nutrition. skipp and keep this. */
                if (item.getAlimentazione() == null) {
                    return false;
                }

                boolean remove = true;
                /*
                 * multiple nutrition entry works.
                 * make AND if is required (nut != null) for remove product which does not have this nut.
                 */
                for (String tmp : nut_words) {
                    if (item.getAlimentazione().equals(tmp)) {
                        remove = false;
                        break;
                    }
                }
                return remove;
            });

        }

        return filter;
    }

    /* save filter for the next page. we will put this in btn page linker. */
    private String saveFilter(HttpServletRequest req) {
        String[] nut_words = req.getParameterValues("nut");
        String[] cat_words = req.getParameterValues("cat");
        String sort = req.getParameter("sort");
        StringBuilder result = new StringBuilder();

        if (nut_words != null) {
            for (String tmp : nut_words) {
                result.append("&nut=").append(tmp);
            }
        }

        if (cat_words != null) {
            for (String tmp : cat_words) {
                result.append("&cat=").append(tmp);
            }
        }

        if (sort != null && !sort.isEmpty()) {
            result.append("&sort=").append(sort);
        }

        return result.toString();
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = req.getParameter("search");
        String page = req.getParameter("page");
        String sort = req.getParameter("sort");
        String persistentFilter = saveFilter(req);

        List<Product> products;
        if (page == null) page = "0";

        if (keyword != null) {
            //Viene chiamata la servlet come search. In questo caso cerca dal pattern.
            products = doGetForKeyWord(req);
        } else {
            //Viene chiamata la servlet come lista prodotti. In questo caso ci servono tutti i prodotti.
            products = ProductDAO.doRetrieveProducts();
        }

        /* exec filter if is required. */
        products = applyFilter(products, req);

        /* remove product that isn't available. */
        products.removeIf((item) -> {
            List<Integer> prods_id = ProductDAO.doRetrieveProductByID(item.getId(), true);
            return prods_id.isEmpty();
        });

        if (sort != null) {
            switch (sort) {
                case "price_cresc" -> products.sort((item1, item2) -> (int) (item1.getPrice() - item2.getPrice()));
                case "price_dec" -> products.sort((item1, item2) -> (int) (item2.getPrice() - item1.getPrice()));
                case "quantity_cresc" ->
                        products.sort(Comparator.comparingInt(item -> ProductDAO.doRetrieveProductByID(item.getId(), true).size()));
                case "quantity_dec" ->
                        products.sort((item1, item2) -> ProductDAO.doRetrieveProductByID(item2.getId(), true).size() - ProductDAO.doRetrieveProductByID(item1.getId(), true).size());
            }
        }

        int min = max_prod_page * Integer.parseInt(page);
        int max = max_prod_page + (max_prod_page * Integer.parseInt(page));

        // assicurati di non uscire dagli index
        if (max >= products.size()) max = products.size();

        // Unico modo decente per partizionare gli elementi e far vedere il numero di pagine esatte.
        int btn_page = (int) Math.ceil((double) products.size() / max_prod_page) - 1;
        products = products.subList(min, max);

        if (btn_page < 0) btn_page = 0;

        /* add an image path to all of this product. */
        addImage(products);

        req.setAttribute("page", page);
        req.setAttribute("btn_page", btn_page);
        req.setAttribute("saveFilter", persistentFilter);
        req.setAttribute("lastSearch", keyword);
        req.setAttribute("products", products);
        RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/productsPage.jsp");
        rd.forward(req, resp);
    }
}
