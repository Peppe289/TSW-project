package org.dinosauri.dinosauri.model;

import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.databind.*;

import java.util.*;

public class Carrello {
    private final HashMap<String, String> elements;
    private final HashMap<String, String> price;
    private final HashMap<String, String> description;
    private final HashMap<String, String> available;
    private final HashMap<String, String> name;
    private final HashMap<String, String> path; // photo path
    private final String context;

    public Carrello(String context) {
        super();
        elements = new HashMap<>();
        price = new HashMap<>();
        description = new HashMap<>();
        available = new HashMap<>();
        name = new HashMap<>();
        this.context = context;
        path = new HashMap<>();
    }

    /**
     * @return - list of keys in this hash map. should have same id in elements and price hashmap.
     */
    private ArrayList<String> getID() {
        return new ArrayList<>(elements.keySet());
    }

    public void loadPrice() {
        ArrayList<String> id_list = this.getID();

        for (String id : id_list) {
            /* retrieve all information about this product. */
            Product prod = ProductDAO.doRetrieveProductByID(id);

            /* this maybe can contain "total" or other stuff in hashmap. ignore it. */
            if (prod == null) continue;
            try {
                prod.SaveFileList(context);
            } catch (NoSuchElementException ignore) {}
            description.put(id, prod.getDescription());
            available.put(id, ((Integer) ProductDAO.doRetrieveProductByID(id, true).size()).toString());
            name.put(id, prod.getName());

            /* load only one photo path. */
            if (!prod.getPhoto_path().isEmpty())
                path.put(id, prod.getPhoto_path().getFirst());

            /* check if this product has some discount. */
            if (prod.getSconto() == 0) price.put(id, Double.toString(prod.getPrice()));
            else price.put(id, Double.toString(prod.getPrice() * (1 - ((double) prod.getSconto() / 100))));
        }
    }

    public void putElements(String id, int itemsNum) {
        elements.put(id, Integer.toString(itemsNum));
    }

    public void setTotalElements(int total) {
        elements.put("total", Integer.toString(total));
    }

    public void setAddedElements(int added) {
        elements.put("added", Integer.toString(added));
    }

    public void setStatus() {
        setStatus(null);
    }

    public void setStatus(String status) {
        if (status == null) {
            status = "success";
        }

        elements.put("status", status);
    }

    public String generateJson() throws JsonProcessingException {
        ArrayList<HashMap<String, String>> hashMapArrayList = new ArrayList<>();
        hashMapArrayList.add(elements);
        hashMapArrayList.add(price);
        hashMapArrayList.add(description);
        hashMapArrayList.add(available);
        hashMapArrayList.add(name);
        hashMapArrayList.add(path);
        ObjectMapper objectMapper = new ObjectMapper();
        return objectMapper.writeValueAsString(hashMapArrayList);
    }
}
