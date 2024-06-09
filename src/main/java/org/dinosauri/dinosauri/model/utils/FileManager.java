package org.dinosauri.dinosauri.model.utils;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Objects;

@SuppressWarnings("unused")
public class FileManager {
    // Directory where images are saved
    public static final String directory = "/upload";
    // Basic name about images
    public static final String fileName = "image.jpg";
    // Just used for robust logging
    private static final Logger logger = LogManager.getLogger(FileManager.class);

    /**
     * Searches for all images that contain this ID within the root path of the servlet context
     *
     * @param id   The ID of the images to search for
     * @param path The root path of the servlet context
     * @return A list of files that contain the specified ID in their name
     */
    public static List<File> RetriveFileFromID(String id, String path) {
        List<File> imageList = new ArrayList<>();
        System.out.println("Start reading directory" + path);
        final File folder = new File(path + directory);
        for (File fileEntry : Objects.requireNonNull(folder.listFiles())) {
            if (!fileEntry.isDirectory()) {
                // The name must be like "TR_1_image.jpg"
                if (fileEntry.getName().indexOf(id + "_") == 0) {
                    imageList.add(fileEntry);
                }
            }
        }

        return imageList;
    }

    /**
     * Determines the next available file path on the disk.
     *
     * @param id          The unique identifier for the file.
     * @param contextPath The path of the servlet context.
     * @return The next available file path.
     */
    public static Path getNextDiskPath(String id, String contextPath) {
        String fileNameOnDisk = directory + File.separator + id + "_" + fileName;
        Path destination = Paths.get(contextPath, fileNameOnDisk);

        for (int i = 2; Files.exists(destination); ++i) {
            fileNameOnDisk = directory + File.separator + id + "_" + i + "_" + fileName;
            destination = Paths.get(contextPath, fileNameOnDisk);
        }

        return destination;
    }

    /**
     * Writes an InputStream to the specified file path.
     *
     * @param inputStream The InputStream to write.
     * @param path        The file path where the InputStream will be written.
     * @throws IOException If an I/O error occurs.
     */
    public static void writeFile(InputStream inputStream, Path path) throws IOException {
        Files.copy(inputStream, path);
    }

    /**
     * Creates the parent directories for the specified path if they do not exist.
     *
     * @param path The file path for which to create the parent directories.
     * @throws IOException If an I/O error occurs.
     */
    public static void createDirectory(Path path) throws IOException {
        Files.createDirectories(path.getParent());
    }

    /**
     * Compares two files for equality by comparing their sizes and content bytes.
     *
     * @param firstFile  The path of the first file
     * @param secondFile The path of the second file
     * @return true if the files are equal, false otherwise
     */
    public static boolean isEqual(Path firstFile, Path secondFile) {
        try {
            if (Files.size(firstFile) != Files.size(secondFile)) {
                return false;
            }

            byte[] first = Files.readAllBytes(firstFile);
            byte[] second = Files.readAllBytes(secondFile);
            return Arrays.equals(first, second);
        } catch (IOException e) {
            logger.error("An error occurred while comparing files", e);
        }
        return false;
    }
}

