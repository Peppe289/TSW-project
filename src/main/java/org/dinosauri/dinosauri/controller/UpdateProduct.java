package org.dinosauri.dinosauri.controller;

import com.fasterxml.jackson.core.type.*;
import com.fasterxml.jackson.databind.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import org.dinosauri.dinosauri.model.*;
import org.dinosauri.dinosauri.model.utils.*;

import java.io.*;
import java.nio.file.*;
import java.sql.*;
import java.util.*;

@WebServlet("/edit-prod-request")
@MultipartConfig
@SuppressWarnings("unchecked")
public class UpdateProduct extends HttpServlet {

    /**
     * Method for update database information of single product.
     *
     * @param request  Retrieve data
     * @return json string for success or not
     * @throws IOException if some get wrong return this error.
     */
    private String update_database(HttpServletRequest request) throws IOException {
        BufferedReader reader = request.getReader();
        StringBuilder buffer = new StringBuilder();
        String line;
        Product product = new Product();
        String id = request.getParameter("id");
        int elements;
        int disp;

        while ((line = reader.readLine()) != null) buffer.append(line);

        String payload = buffer.toString();
        ObjectMapper objectMapper = new ObjectMapper();
        Map<String, String> map = objectMapper.readValue(payload, HashMap.class);

        if (id.isEmpty()) {
            return "{\"status\":\"ID vuoto\"}";
        }

        product.setId(id);
        product.setPrice(Double.parseDouble(map.get("price")));

        String cat = map.get("category");
        /* check if match with white space. */
        if (cat != null)
            cat = cat.matches("^\\s*$") || cat.isBlank() ? null : cat;

        String nut = map.get("nutrition");
        if (nut != null)
            nut = nut.matches("^\\s*$") || nut.isBlank() ? null : nut;

        product.setCategoria(cat);
        product.setAlimentazione(nut);
        product.setDescription(map.get("description"));
        product.setName(map.get("name"));

        /* make insert or update. this is specified by client from input hidden. */
        if (map.get("new_prod").isEmpty()) {
            ProductDAO.doUpdateByID(product);
        } else {
            try {
                ProductDAO.doInsertProduct(product);
            } catch (SQLException e) {
                return null;
            }
        }

        disp = ProductDAO.doRetrieveProductByID(product.getId(), true).size();
        elements = Integer.parseInt(map.get("quantity")) - disp;

        /* add product if necessary. */
        while (elements > 0) {
            ProductDAO.doAddQuantityByID(product.getId());
            elements--;
        }

        /* remove product if necessary. */
        /* check also if available product is more than 0 */
        while (elements < 0 && disp != 0) {
            ProductDAO.doRemoveQuantityByID(product.getId());
            elements++;
        }

        product = ProductDAO.doRetrieveProductByID(product.getId());
        product.setQuantity(ProductDAO.doRetrieveProductByID(product.getId(), true).size());

        return objectMapper.writeValueAsString(product);
    }

    private String remove_image(HttpServletRequest request, HttpServletResponse response) throws IOException {
        BufferedReader reader = request.getReader();
        String id = request.getParameter("id");
        /* read array from json (request) */
        String line;
        StringBuilder buffer = new StringBuilder();
        ObjectMapper objectMapper = new ObjectMapper();
        List<File> files;
        List<String> newPath = new ArrayList<>();

        while ((line = reader.readLine()) != null) buffer.append(line);

        /* string with url path of image to remove. */
        String[] array = objectMapper.readValue(buffer.toString(), String[].class);
        /*
         * Use this as filter. whe need only name of file, so remove other stuff.
         * Is better make this from server bcs whe need to check file to remove.
         * This work as filter for save file remove.
         *
         * For example for block request from client to remove /etc/passwd
         * (in this case whe receive only "passwd" and this can be safe).
         *
         * Also check if ID is equal to keywords in filename.
         *
         * Work as:
         * input : http://localhost:8080/dinosauri_war_exploded/upload/OTC_3_image.jpg
         * output : OTC_3_image.jpg
         */
        for (int i = 0; i < array.length; ++i) {
            String[] name = array[i].split("/");
            String filename = name[name.length - 1];
            array[i] = filename;
        }

        /* Delete files as request. */
        for (String string : array) {
            FileManager.removeFileByPath(getServletContext().getRealPath("/") + FileManager.directory + "/" + string);
        }

        /* get update image list */
        files = FileManager.RetriveFileFromID(id, new File(getServletContext().getRealPath("/")).getAbsolutePath());
        for (File file : files) {
            newPath.add(FileManager.directory + "/" + file.getName());
        }

        return "{\"path\": " + objectMapper.writeValueAsString(newPath.toArray()) + "}";
    }

    /**
     * This control the image upload.
     *
     * @param request  take resource from request.
     * @param response not needed but is better to keep here for set status code.
     * @throws IOException get error if some get wrong.
     */
    private String upload_image(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        Part filePart = request.getPart("image");
        Path destination = FileManager.getNextDiskPath(id, getServletContext().getRealPath("/"));
        List<File> files;
        List<String> newPath = new ArrayList<>();
        ObjectMapper objectMapper = new ObjectMapper();

        try {
            /* write file received in the right directory. this can be give IOException. Catch it. */
            FileManager.writeFile(filePart.getInputStream(), destination);
        } catch (IOException e) {
            /* some error happened. send result to client */
            response.setStatus(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
            /* return json page with error status */
            return "{\"status\":\"I/O Error\"}";
        }

        /* get update image list */
        files = FileManager.RetriveFileFromID(id, new File(getServletContext().getRealPath("/")).getAbsolutePath());
        for (File file : files) {
            newPath.add(FileManager.directory + "/" + file.getName());
        }

        return "{\"path\": " + objectMapper.writeValueAsString(newPath.toArray()) + ",\"status\":\"success\"}";
    }

    public String check_new_id(String id) {
        Product product = ProductDAO.doRetrieveProductByID(id);

        if (product == null) return "{\"status\":\"ok\"}";
        else return "{\"status\":\"Already Present\"}";
    }

    /**
     * This servlet is used for write in server directory the new immage taked from client
     * If some get wrong whe set response status at 500.
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException {
        String json_result = null;

        switch (request.getParameter("o")) {
            case "upload" -> {
                try {
                    json_result = upload_image(request, response);
                } catch (IOException e) {
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                }
            }
            case "remove" -> {
                try {
                    json_result = remove_image(request, response);
                } catch (IOException e) {
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                }
            }
            case "update_database" -> {
                try {
                    json_result = update_database(request);
                } catch (IOException e) {
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                }
            }
            case "new_id" -> {
                json_result = check_new_id(request.getParameter("id"));
            }
            default -> {

            }
        }

        response.setContentType("application/json");

        try {
            if (json_result == null) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
            /* return json page with status success */
            response.getWriter().print(json_result);
        } catch (IOException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
