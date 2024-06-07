package org.dinosauri.dinosauri.model.utils;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Objects;

public class FileManager {

    /* directory in cui vengono salvate le immagini */
    public static final String directory = "/upload";

    /* cerca tutte le immagini che contengono questo ID e la path root della servlet context */
    public static List<File> RetriveFileFromID(String id, String path) {
        List<File> imageList = new ArrayList<>();
        System.out.println("Start reading directory" + path);
        final File folder = new File(path + directory);
        for (File fileEntry : Objects.requireNonNull(folder.listFiles())) {
            if (!fileEntry.isDirectory()) {
                System.out.println(fileEntry.getName());
                if (fileEntry.getName().indexOf(id + "_") == 0) {
                    imageList.add(fileEntry);
                }
            }
        }

        return imageList;
    }

    // Not used for now
    public static boolean isEqual(Path firstFile, Path secondFile) {
        try {
            if (Files.size(firstFile) != Files.size(secondFile)) {
                return false;
            }

            byte[] first = Files.readAllBytes(firstFile);
            byte[] second = Files.readAllBytes(secondFile);
            return Arrays.equals(first, second);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return false;
    }
}
