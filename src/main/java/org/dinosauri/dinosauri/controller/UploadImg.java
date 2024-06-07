package org.dinosauri.dinosauri.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@WebServlet("/uploadimg")
@MultipartConfig
public class UploadImg extends HttpServlet {
    private static final String CARTELLA_UPLOAD = "upload";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Part filePart = request.getPart("image");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String id = request.getParameter("id");

        String destinazione = CARTELLA_UPLOAD + File.separator + fileName;
        Path pathDestinazione = Paths.get(getServletContext().getRealPath(destinazione));

        // se un file con quel nome esiste già, gli cambia nome
        for (int i = 2; Files.exists(pathDestinazione); i++) {
            destinazione = CARTELLA_UPLOAD + File.separator + id + "_" + i + "_" + fileName;
            pathDestinazione = Paths.get(getServletContext().getRealPath(destinazione));
        }

        InputStream fileInputStream = filePart.getInputStream();
        // crea CARTELLA_UPLOAD, se non esiste
        Files.createDirectories(pathDestinazione.getParent());
        // scrive il file
        Files.copy(fileInputStream, pathDestinazione);

        response.setStatus(HttpServletResponse.SC_OK);
        response.getWriter().print("{\"status\":\"success\"}");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
