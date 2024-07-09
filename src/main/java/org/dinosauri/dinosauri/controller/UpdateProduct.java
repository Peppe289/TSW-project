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
import java.util.*;

@WebServlet("/edit-prod-request")
@MultipartConfig
public class UpdateProduct extends HttpServlet {

    /**
     * Method for update database information of single product.
     *
     * @param request - Retrieve data
     * @param response - Set status
     * @return json string for success or not
     * @throws IOException - Retrieve data
     */
    private String update_database(HttpServletRequest request, HttpServletResponse response) throws IOException {
        BufferedReader reader = request.getReader();
        StringBuilder buffer = new StringBuilder();
        String line;
        Product product = new Product();
        String id = request.getParameter("id");
        int elements;

        while ((line = reader.readLine()) != null)
            buffer.append(line);

        String payload = buffer.toString();
        ObjectMapper objectMapper = new ObjectMapper();
        Map<String, String> map = objectMapper.readValue(payload, new TypeReference<Map<String, String>>(){});

        product.setId(id);
        product.setPrice(Double.parseDouble(map.get("price")));
        product.setCategoria(map.get("category"));
        product.setAlimentazione(map.get("nutrition"));
        product.setDescription(map.get("description"));
        product.setName(map.get("name"));
        ProductDAO.doUpdateByID(product);
        elements = Integer.parseInt(map.get("quantity")) - ProductDAO.doRetrieveProductByID(product.getId(), true).size();

        while (elements > 0) {
            ProductDAO.doAddQuantityByID(product.getId());
            elements--;
        }
        while (elements < 0) {
            ProductDAO.doRemoveQuantityByID(product.getId());
            elements++;
        }

        response.setContentType("application/json");
        return "{\"status\":\"success\"}";
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

        response.setContentType("application/json");
        return "{\"path\": " + objectMapper.writeValueAsString(newPath.toArray()) + ",\"status\":\"success\"}";
    }

    /**
     * This control the image upload.
     *
     * @param request  take resource from request.
     * @param response not needed but is better to keep here for set status code.
     */
    private String upload_image(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        Part filePart = request.getPart("image");
        Path destination = FileManager.getNextDiskPath(id, getServletContext().getRealPath("/"));
        List<File> files;
        List<String> newPath = new ArrayList<>();
        ObjectMapper objectMapper = new ObjectMapper();

        /*
         * Needed for fix this:
         *
         * XML Parsing Error: not well-formed
         * Location: http://localhost:8080/dinosauri_war_exploded/uploadimg?id=OBR
         * Line Number 1, Column 1:
         */
        response.setContentType("application/json");

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

    /**
     * This servlet is used for write in server directory the new immage taked from client
     * About this we can consider:
     *
     * @throws IOException if we can't write in that directory, we need to catch this error and return the right status response.
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String json_result;

        switch (request.getParameter("o")) {
            case "upload" -> json_result = upload_image(request, response);
            case "remove" -> json_result = remove_image(request, response);
            case "update_database" -> json_result = update_database(request, response);
            default -> json_result = "{\"status\":\"Request Error\"}";
        }

        /* return json page with status success */
        response.getWriter().print(json_result);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
